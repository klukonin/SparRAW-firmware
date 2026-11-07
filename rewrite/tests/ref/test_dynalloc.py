# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/dynalloc: PP (10.39.7.2 [p. 1897–1898], ур. (10-18)), GP (10.39.7.3 [p. 1898–1899]), Grant Ack (10.39.4
[p. 1882], 9.3.1.18), Poll в ATI (10.39.3 [p. 1880]), Allocation Duration (9.5.2 [p. 1438]). Числа — по формулам
текста: TXTIME(Poll, 22 октета) = 14,327 мкс, TXTIME(SPR/Grant/Grant Ack, 27 октетов) = 15,055 мкс (20.11.3,
control)."""
from fractions import Fraction as Fr

import pytest

from . import bi as BI
from . import duration as D
from . import dynalloc as DA
from . import fields as F
from . import tdma_scen as TS
from .timing import ALLOC_CBAP, ALLOC_SP, BCAST, SBIFS, SIFS

AP, A, B, C = TS.AP, TS.A, TS.B, TS.C
SP_BC = BI.Period('SP', 2000, 12000, src_aid=255, dst_aid=255)
SP_BC.alloc = BI.Allocation('SP', 255, 255, 2000, 10000, truncatable=1)


def judge(evs, periods=(SP_BC,), **kw):
    v, w = DA.check_dyn_log(evs, list(periods), TS.AIDS, AP, **kw)
    return {x.rule for x in v}, v, w


def test_txtimes():
    assert abs(float(DA.T_POLL) - 14.327) < 1e-3 and abs(float(DA.T_SPR) - 15.055) < 1e-3
    assert DA.T_SPR == DA.T_GRANT == DA.T_GRANT_ACK


def test_pp_durations_and_response_offsets_10_18():
    """(10-18) для n = 2: D_1,2 = Ceil(TXTIME(Poll) + SBIFS + 0 + aSBIFSAccuracy) = Ceil(15,357) = 16; O_1 = SIFS = 3;
    O_2 = 3 + Ceil(15,055 + 3) = 22; D_1 = 16 + 22 + Ceil(15,055) = 54, D_2 = 0 + 22 + 16 = 38; Response Offset_1 =
    16 + 3 = 19, Response Offset_2 = 0 + 22 = 22. SPR — через Response Offset от конца Poll, Duration SPR =
    Duration Poll − Response Offset − TXTIME(SPR): ⌈54 − 19 − 15,055⌉ = 20, ⌈38 − 22 − 15,055⌉ = 1."""
    evs, pe = DA.pp(2100, AP, [A, B])
    polls = [e for e in evs if e[4] == 'Poll']
    sprs = [e for e in evs if e[4] == 'SPR']
    assert [p[5] for p in polls] == [54, 38]
    assert [p[6]['frame'].response_offset for p in polls] == [19, 22]
    assert polls[1][0] - polls[0][1] == SBIFS
    assert sprs[0][0] == polls[0][1] + 19 and sprs[1][0] == polls[1][1] + 22
    assert [s[5] for s in sprs] == [20, 1]
    assert sprs[1][0] - sprs[0][1] >= SIFS                 # NOTE 10.39.7.2: не меньше SIFS между SPR
    # 10.39.7.2: «The PP ends at … end of the last Poll … plus the value of the Response Offset … plus the expected
    # duration of the SPR … plus SIFS»
    assert pe == polls[1][1] + 22 + DA.T_SPR + SIFS
    assert judge(evs)[0] == set()


def test_pp_antenna_switching_time():
    """A_k = dot11AntennaSwitchingTime при смене антенны между Poll 1 и Poll 2 (PLAN.md №46 — переключение перед
    Poll_k): D_1,2 = Ceil(14,327 + 1 + 2 + 0,03) = 18."""
    evs, _ = DA.pp(2100, AP, [A, B], ant_switch=[2, 0])
    polls = [e for e in evs if e[4] == 'Poll']
    assert polls[0][5] == 18 + 22 + 16 and polls[0][6]['frame'].response_offset == 18 + 3
    assert polls[1][0] - polls[0][1] == SBIFS + 2
    assert judge(evs, ant_switch=2)[0] == set()


def test_pp_spr_order_is_ap_choice():
    """Позиция j SPR — выбор AP: Response Offset_i = D_i,n + O_j при любой перестановке."""
    evs, _ = DA.pp(2100, AP, [A, B], order=[2, 1])
    polls = [e for e in evs if e[4] == 'Poll']
    assert [p[6]['frame'].response_offset for p in polls] == [16 + 22, 3]
    sprs = sorted((e for e in evs if e[4] == 'SPR'), key=lambda e: e[0])
    assert [s[2] for s in sprs] == [B, A]
    assert judge(evs)[0] == set()


def test_gp_durations_and_allocation_start():
    """10.39.7.3: Duration Grant покрывает оставшиеся Grant/Grant Ack и IFS; выделение начинается в PHY-TXEND Grant +
    Duration. Grant B, затем (SBIFS) Grant A + Grant Ack A через SIFS: Duration Grant A = ⌈3 + 15,055⌉ = 19, Grant B =
    ⌈1 + 15,055 + 3 + 15,055⌉ = 35; Grant Ack — ⌈19 − 3 − 15,055⌉ = 1 (9.3.1.18)."""
    dai = F.Dai(0, ALLOC_SP, 1, 2, 3000)
    evs, w = DA.gp(2100, AP, [B, A], dai, grant_ack={A}, mac_of=TS.MAC_OF)
    g = [e for e in evs if e[4] == 'Grant']
    ga = [e for e in evs if e[4] == 'Grant Ack']
    assert [x[5] for x in g] == [35, 19] and ga[0][5] == 1
    assert w.start == g[1][1] + 19 and w.end == w.start + 3000 and w.members == {A, B} and w.src == A
    assert abs((g[0][1] + 35) - w.start) < 1
    rules, v, ws = judge(evs, caps={A: {'grant_ack': 1}, B: {'grant_ack': 0}})
    assert rules == set(), v
    assert len(ws) == 1


@pytest.mark.parametrize('case, rule', [
    ('dai_differs', 'dyn_grant_same'), ('last_not_src', 'should_grant_last_src'), ('alloc_32768', 'dyn_grant_alloc'),
    ('ga_group', 'grant_ack'), ('ga_late', 'grant_ack'), ('ga_bt', 'grant_ack'), ('ga_dur', 'grant_ack')])
def test_gp_negative(case, rule):
    dai = F.Dai(0, ALLOC_SP, 1, 2, 3000)
    order = [A, B] if case == 'last_not_src' else [B, A]
    if case == 'alloc_32768':
        dai = dai._replace(alloc_duration=32768)
    evs, _ = DA.gp(2100, AP, order, dai, grant_ack={A}, mac_of=TS.MAC_OF)
    if case == 'dai_differs':
        e = evs[0]
        evs[0] = e[:6] + (dict(e[6], frame=e[6]['frame']._replace(dai=dai._replace(tid=3))),)
    if case == 'ga_group':
        e = evs[0]
        evs = [e[:3] + (BCAST,) + e[4:], (e[1] + SIFS, e[1] + SIFS + DA.T_GRANT_ACK, B, AP, 'Grant Ack', 0, {})]
    i = next(k for k, e in enumerate(evs) if e[4] == 'Grant Ack')
    e = evs[i]
    if case == 'ga_late':
        evs[i] = (e[0] + 2, e[1] + 2) + e[2:]
    if case == 'ga_bt':
        evs[i] = e[:6] + (dict(e[6], frame=e[6]['frame']._replace(bfc=F.BfControl(bt=1))),)
    if case == 'ga_dur':
        evs[i] = e[:5] + (e[5] + 3,) + e[6:]
    rules = judge(evs, caps={A: {'grant_ack': 1}, B: {'grant_ack': 0}})[0]
    assert rule in rules, rules


def test_gp_start_after_pp_text_and_figure():
    """10.39.7.3: GP — «SIFS following the end of a PP»; конец PP уже включает SIFS (10.39.7.2) — по тексту первый
    Grant через 2·SIFS после ожидаемого конца последнего SPR; рис. 10-60 — через SIFS (PLAN.md №47: норма — текст,
    рисунок — 'dyn_gp_start_fig')."""
    pp, pe = DA.pp(2100, AP, [A])
    dai = F.Dai(0, ALLOC_SP, 1, 0, 500)
    g, _ = DA.gp(pe + SIFS, AP, [A], dai, mac_of=TS.MAC_OF)
    assert judge(pp + g)[0] == set()
    spr_end = max(e[1] for e in pp if e[4] == 'SPR')
    g2, _ = DA.gp(spr_end + SIFS, AP, [A], dai, mac_of=TS.MAC_OF)
    assert judge(pp + g2)[0] == {'dyn_gp_start_fig'}


def test_poll_in_ati_response_offset_zero():
    """10.39.3: «The Response Offset field within a Poll frame transmitted during the ATI shall be set to 0»; ответ —
    через SIFS (10.39.3)."""
    ati = BI.Period('ATI', 1000, 3000)
    p = F.Poll(500, A, AP, 0)
    t = Fr(1100)
    poll = (t, t + DA.T_POLL, AP, A, 'Poll', 500, dict(mcs=0, frame=p))
    spr = (poll[1] + SIFS, poll[1] + SIFS + DA.T_SPR, A, AP, 'SPR', 400,
           dict(mcs=0, frame=F.Spr(400, AP, A, F.Dai(0, ALLOC_SP, 1, 0, 100), F.BfControl())))
    assert judge([poll, spr], [ati])[0] == set()
    bad = poll[:6] + (dict(mcs=0, frame=p._replace(response_offset=5)),)
    assert 'dyn_poll_ro' in judge([bad, spr], [ati])[0]


def test_pp_location_rules():
    """10.39.7.2: PP — в SP broadcast/broadcast (Truncatable = 1, 10.39.7.1), в TXOP CBAP с broadcast Destination AID,
    во времени после усечения; не в SP с индивидуальным AID и не в CBAP с индивидуальным получателем."""
    evs, _ = DA.pp(2100, AP, [A])
    cb_only = BI.Period('CBAP', 2000, 12000, cbap_only=True)
    assert judge(evs, [cb_only])[0] == set()
    cb_ind = BI.Period('CBAP', 2000, 12000, src_aid=1, dst_aid=2)
    assert 'dyn_where' in judge(evs, [cb_ind])[0]
    sp_nt = BI.Period('SP', 2000, 12000, BI.Allocation('SP', 255, 255, 2000, 10000), src_aid=255, dst_aid=255)
    assert 'dyn_sp_truncatable' in judge(evs, [sp_nt])[0]
    assert judge(evs, [BI.Period('SP', 2000, 12000, src_aid=1, dst_aid=2)], relinquished=[(2050, 12000)])[0] == set()
    # PP_Available = 0 (STA Availability, 10.39.7.1)
    assert 'dyn_pp_unavail' in judge(evs, pp_available={A: 0})[0]
    # кадр PP за концом SP
    late, _ = DA.pp(SP_BC.end - 10, AP, [A])            # Poll (14,3 мкс) кончается после конца SP
    assert 'dyn_pp_end' in judge(late)[0]


def test_zero_allocation_duration_one_ppdu():
    """9.5.2: Allocation Duration = 0 — «the STA can transmit one PPDU followed by any relevant acknowledgment plus one
    RTS/DMG CTS handshake»."""
    dai = F.Dai(0, ALLOC_SP, 1, 2, 0)
    g, w = DA.gp(2100, AP, [A], dai, mac_of=TS.MAC_OF)
    assert w.zero
    from .sp import _ev
    d1 = _ev(w.start + SIFS, 'Data', A, B, 300, 8)
    a1 = _ev(d1[1] + SIFS, 'Ack', B, A, 14, 1)
    assert judge(g + [d1, a1])[0] == set()
    d2 = _ev(a1[1] + SIFS, 'Data', A, B, 300, 8)
    assert 'dyn_use' in judge(g + [d1, a1, d2])[0]


def test_bcast_sp_non_ap_silent_without_poll_or_grant():
    """9.4.2.131: SP broadcast/broadcast — «a non-AP and non-PCP STA does not transmit unless it receives a Poll or
    Grant frame from the AP»."""
    from .sp import _ev
    assert 'dyn_bcast_sp_sta' in judge([_ev(5000, 'Data', A, AP, 300, 8)])[0]


def test_txop_relinquish_grant_in_cbap():
    """10.39.7.3: держатель TXOP уступает остаток ответчику: Source AID = ответчик, Destination AID = держатель, CBAP,
    Allocation Duration = 32 768 (9.5.2 b)), Duration = остаток TXOP − TXTIME(Grant) − aSIFSTime."""
    cb = BI.Period('CBAP', 2000, 12000, cbap_only=True)
    from .sp import _ev
    rts = _ev(3000, 'RTS', A, B, 20, dur=500)
    cts = _ev(rts[1] + SIFS, 'DMG CTS', B, A, 20, dur=480)
    g = DA.relinquish_grant(cts[1] + SIFS, A, B, 1, 2, rts[1] + 500, kind='CBAP')
    assert g[6]['frame'].dai == F.Dai(0, ALLOC_CBAP, 2, 1, 32768)
    assert g[5] == D.field(rts[1] + 500 - g[0] - DA.T_GRANT - SIFS)
    rules, v, w = judge([rts, cts, g], [cb])
    assert rules == set(), v
    assert w and w[0].why == 'TXOP' and w[0].src == B
    bad = g[:6] + (dict(g[6], frame=g[6]['frame']._replace(dai=F.Dai(0, ALLOC_CBAP, 1, 2, 32768))),)
    assert 'dyn_txop_grant' in judge([rts, cts, bad], [cb])[0]
