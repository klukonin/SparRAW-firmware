# SPDX-License-Identifier: AGPL-3.0-or-later
"""Передача PCP (11.27.2 [p. 2357–2359]), Next PCP List / PCP Handover (9.4.2.140/141 [p. 1261]), Handover Request/
Response (9.6.19.6/7 [p. 1573])."""
from . import elements as E
from . import handover as H
from .timing import DOT11_MAX_LOST_BEACONS

PCP, C1, C2 = '02:00:00:00:00:0a', '02:00:00:00:00:c1', '02:00:00:00:00:c2'


def alloc(aid_src, aid_dst, ps=1, start=1000):
    ctrl = dict(allocation_id=1, allocation_type=0, pseudo_static=ps, truncatable=0, extendable=0, pcp_active=1,
                lp_sc_used=0, _r12=0)
    return E.Allocation(ctrl, 0, aid_src, aid_dst, start, 500, 1, 0)


def test_elements():
    assert H.encode_next_pcp_list(None, [])[1] == 0                    # Length 0 — нет способных STA (11.27.2.1)
    n = H.parse_next_pcp_list(E.parse_elements(H.encode_next_pcp_list(3, [5, 2]))[0].info)
    assert n == H.NextPcpList(3, [5, 2])
    assert H.check_next_pcp_list(n, {5: True, 2: True}) == []
    assert any('Token без AID' in m for m in H.check_next_pcp_list(H.NextPcpList(3, [])))
    assert any('не способна' in m for m in H.check_next_pcp_list(n, {5: True, 2: False}))
    assert any('Length 0 при способной' in m for m in H.check_next_pcp_list(H.NextPcpList(None, []), {5: True}))
    h = H.PcpHandover(PCP, C1, 7)
    el = H.encode_pcp_handover(h)
    assert el[:2] == bytes([161, 13]) and H.parse_pcp_handover(E.parse_elements(el)[0].info) == h


def test_frames():
    f, act = H.parse_frame(H.encode_request(H.REASON_LOW_POWER, 5))
    assert act == H.ACT_HANDOVER_REQ and f == H.HandoverReq(1, 5)
    assert H.check_request(f, True, None, True) == []
    assert any('резерв' in m for m in H.check_request(H.HandoverReq(4, 5), True))
    assert any('неспособной' in m for m in H.check_request(f, True, None, False))
    assert any('без способности' in m for m in H.check_request(f, False, False, True))
    assert any('вне PBSS' in m for m in H.check_request(f, True, pbss=False))
    assert H.check_response(H.HandoverResp(0, 0)) == [] and H.check_response(H.HandoverResp(1, 3)) == []
    assert any('№64' in m for m in H.check_response(H.HandoverResp(2, 0)))
    assert any('set to 0' in m for m in H.check_response(H.HandoverResp(0, 1)))
    assert any('резерв' in m for m in H.check_response(H.HandoverResp(1, 4)))


def test_explicit_countdown_and_member_filter():
    """11.27.2.2: Request в BI 10 (Handover Remaining BI 5, без BI запроса — BI 11…15), ответ в том же BI → PCP
    Handover в BI 11…14 (dot11NbrOfChangeBeacons = 4) с 5, 4, 3, 2; с TBTT BI 16 кандидат — PCP; член BSS — на нуле."""
    p = H.HandoverPcp(PCP, n_change=4)
    p.request_sent(C1, 5, 10)
    p.response(H.RESULT_ACCEPT, 10)
    seq = [(k, p.beacon_element(k)) for k in range(10, 17)]
    assert [h.remaining if h else None for _, h in seq] == [None, 5, 4, 3, 2, None, None]
    assert p.takes_over_bi() == 16
    assert H.check_handover_beacons(seq, PCP, n_change=4) == []
    m = H.HandoverMember(PCP)
    m.on_beacon(seq[1][1])
    for _ in range(4):
        m.tbtt()
    assert m.filter == PCP
    m.tbtt()
    assert m.filter == C1                                   # 5 TBTT от BI 11 — TBTT BI 16


def test_explicit_rejected_and_bad_sequences():
    p = H.HandoverPcp(PCP)
    p.request_received(C1, 5, 3)
    p.response(H.RESULT_REJECT, 3)
    assert p.beacon_element(4) is None and p.candidate is None
    seq = [(1, H.PcpHandover(PCP, C1, 5)), (2, H.PcpHandover(PCP, C1, 3)), (3, None),
           (4, H.PcpHandover('02:00:00:00:00:ff', C2, 2))]
    v = H.check_handover_beacons(seq, PCP, n_change=4)
    assert any('ожидалось 4' in m for m in v) and any('BI 3: нет PCP Handover' in m for m in v)
    assert any('Old BSSID' in m for m in v) and any('New PCP Address' in m for m in v)


def test_next_pcp_list_token():
    p = H.NextPcpListPcp()
    assert p.element() == H.NextPcpList(None, [])
    a = p.update([3])
    b = p.update([3])
    c = p.update([3, 4])
    assert (a.token, b.token, c.token) == (1, 1, 2)
    assert H.check_next_pcp_tokens([a, b, c]) == []
    assert H.check_next_pcp_tokens([a, H.NextPcpList(2, [3])])
    assert H.check_next_pcp_tokens([a, H.NextPcpList(3, [4])])


def test_implicit_candidate():
    """11.27.2.3: кандидат 2 срабатывает после 2·dot11ImplicitHandoverLostBeacons BI без маяков, шлёт
    dot11MaxLostBeacons маяков, последний — Remaining BIs 0 (PLAN.md №66)."""
    c = H.ImplicitCandidate(C2, 7, PCP, lost_beacons=3)
    assert c.on_next_pcp_list(H.NextPcpList(1, [5, 7])) and c.index == 2
    assert not c.on_next_pcp_list(H.NextPcpList(1, [5, 7]))
    out = [c.bi(False) for _ in range(6 + DOT11_MAX_LOST_BEACONS + 1)]
    sent = [h for h in out if h is not None]
    assert out[:5] == [None] * 5 and [h.remaining for h in sent] == [3, 2, 1, 0]
    assert all(h.old_bssid == PCP and h.new_pcp == C2 for h in sent) and c.completed
    c2 = H.ImplicitCandidate(C2, 7, PCP, lost_beacons=1)
    c2.on_next_pcp_list(H.NextPcpList(1, [5, 7]))
    assert c2.bi(False) is None and c2.bi(False) is not None
    assert c2.bi(False, lower_candidate_beacon=True) is None and not c2.completed
    assert c2.bi(True) is None and c2.missed == 0                     # маяк PCP вернулся


def test_member_choice_and_after_handover():
    heard = [(C1, H.PcpHandover(PCP, C1, 2)), (C2, H.PcpHandover(PCP, C2, 1)), ('x', H.PcpHandover('y', 'x', 0))]
    assert H.choose_new_pcp(heard, PCP) == C2
    before = [alloc(1, 2), alloc(2, 3, ps=0)]
    assert H.check_pseudo_static_kept(before, [alloc(1, 2)]) == []
    assert H.check_pseudo_static_kept(before, [alloc(1, 2, start=2000)])
    assert H.check_member_contact(20, [21]) == [] and H.check_member_contact(20, [24])
