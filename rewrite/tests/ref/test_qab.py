# SPDX-License-Identifier: AGPL-3.0-or-later
"""QAB (11.35 [p. 2389–2390]), Quiet Period Request/Response (9.4.2.149/150 [p. 1270–1271]), QAB Request/Response
(9.6.7.34/35 [p. 1492–1493])."""
from . import elements as E
from . import qab as Q
from .timing import BCAST, TU

A1, A2, A3 = '02:00:00:00:00:a1', '02:00:00:00:00:a2', '02:00:00:00:00:a3'


def test_element_layouts():
    q = Q.QpReq(7, 10, 100, 5, 3, A2)
    el = Q.encode_qp_req(q)
    assert el[0] == 175 and el[1] == 17                          # рис. 9-595: 2+2+4+2+1+6
    assert Q.parse_qp_req(E.parse_elements(el)[0].info) == q
    r = Q.QpResp(7, A2, 0)
    el = Q.encode_qp_resp(r)
    assert el[0] == 177 and el[1] == 10                          # рис. 9-596: 2+6+2
    assert Q.parse_qp_resp(E.parse_elements(el)[0].info) == r


def test_quiet_intervals_note():
    """9.4.2.149 NOTE: конец — начало преамбулы + Offset + (Count − 1)·Period + Duration (TU)."""
    q = Q.QpReq(1, 10, 100, 5, 3, A2)
    iv = Q.quiet_intervals(1000, q)
    assert iv[0] == (1000 + 10 * TU, 1000 + 15 * TU)
    assert iv[-1][1] == 1000 + (10 + 2 * 100 + 5) * TU and len(iv) == 3


def test_request_checks():
    body = Q.encode_frame(Q.ACT_QAB_REQ, 3, A1, A2, [Q.encode_qp_req(Q.QpReq(1, 0, 100, 5, 2, A2))])
    f = Q.parse_frame(body)
    assert Q.check_request(f, A1, True, True) == []
    assert any('Dialog Token = 0' in m for m in Q.check_request(f._replace(token=0), A1))
    assert any('RequesterAP' in m for m in Q.check_request(f, A3))
    assert any('QAB Capability = 0' in m for m in Q.check_request(f, A1, True, False))
    bad = Q.check_qp_req(Q.QpReq(0, 0, 10, 20, 2, BCAST))
    assert any('Request Token = 0' in m for m in bad) and any('налезают' in m for m in bad) \
        and any('broadcast' in m for m in bad)
    # ResponderAP = broadcast допускается (запрос нескольким AP), Target BSSID — каждого
    multi = Q.parse_frame(Q.encode_frame(Q.ACT_QAB_REQ, 3, A1, BCAST, [Q.encode_qp_req(Q.QpReq(1, 0, 100, 5, 2, A2)),
                                                                        Q.encode_qp_req(Q.QpReq(2, 0, 100, 5, 2, A3))]))
    assert Q.check_request(multi, A1) == []


def test_responder_schedules_quiet_sp_and_stays_silent():
    req = Q.encode_frame(Q.ACT_QAB_REQ, 9, A1, A2, [Q.encode_qp_req(Q.QpReq(4, 1, 100, 2, 2, A2)),
                                                    Q.encode_qp_req(Q.QpReq(5, 1, 100, 2, 2, A3))])
    resp = Q.QabResponder(A2)
    body = resp.on_request(req, 0)
    f = Q.parse_frame(body)
    assert f.token == 9 and f.requester == A1 and f.responder == A2
    assert [(r.token, r.bssid, r.status) for r in f.elements] == [(4, A2, 0)]      # только свой Target BSSID
    assert Q.check_response(f, A2, req=Q.parse_frame(req), own_bssid=A2) == []
    assert len(resp.quiet) == 2 and resp.quiet[0] == (1 * TU, 3 * TU)
    assert all(Q.quiet_allocation_ok(a) for a in resp.allocations())             # SP: источник = получатель = AP
    assert not resp.may_transmit(1 * TU + 10, 1 * TU + 50) and resp.may_transmit(3 * TU, 3 * TU + 10)
    assert Q.check_quiet_tx(resp.quiet, [(2 * TU, 2 * TU + 30, 'Data')])
    assert Q.QabResponder(A3, qab=False).on_request(req, 0) is None
    assert Q.QabResponder('02:00:00:00:00:a9').on_request(req, 0) is None


def test_rejected_no_schedule_and_requester_confirm():
    rq = Q.QabRequester(A1)
    assert rq.request(A2, peer_qab=False, quiet=[(1, 100, 2, 2)]) is None          # 11.35.2 a)
    body = rq.request(A2, True, [(1, 100, 2, 2)], protected=True)
    assert body[0] == Q.CATEGORY_PROTECTED_DUAL
    resp = Q.QabResponder(A2, accept=lambda q: 37)
    out = resp.on_request(body, 0)
    assert resp.quiet == [] and out[0] == Q.CATEGORY_PROTECTED_DUAL
    assert rq.on_response(out, A2) == [(A2, 1, False)]
    ok = Q.QabResponder(A2).on_request(rq.request(A2, True, [(1, 100, 2, 2)]), 0)
    assert rq.on_response(ok, A2)[-1] == (A2, 1, True)


def test_response_mismatch():
    req = Q.parse_frame(Q.encode_frame(Q.ACT_QAB_REQ, 9, A1, A2, [Q.encode_qp_req(Q.QpReq(4, 1, 100, 2, 2, A2))]))
    bad = Q.parse_frame(Q.encode_frame(Q.ACT_QAB_RESP, 8, A1, A2, [Q.encode_qp_resp(Q.QpResp(5, A3, 0))]))
    v = Q.check_response(bad, A2, req=req, own_bssid=A2)
    assert any('Dialog Token' in m for m in v) and any('без соответствующего' in m for m in v) \
        and any('нет Quiet Period Response' in m for m in v) and any('BSSID ответа' in m for m in v)
