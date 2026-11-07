# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/bssparams: смена параметров DMG BSS (11.29.1–11.29.3 [p. 2361–2362], рис. 11-47/11-48), сброс TSF (11.1.3.3.1
[p. 2052]), рекомендация точке (11.29.5 [p. 2363]), элемент DMG BSS Parameter Change (9.4.2.126 [p. 1235]),
Information Request/Response (9.6.19.4/9.6.19.5 [p. 1571–1572]); правило судьи bss_params. Ожидания — из текста
стандарта."""
from types import SimpleNamespace as NS

import pytest

from . import air_judge as J
from . import bssparams as B
from . import elements as E
from . import timing as T
from .test_air_judge_c import AP, STA, Air
from .test_linkadapt import act

BI = 100
BI_US = BI * T.TU


def btis(plan, ts_delay=7):
    return [B.Bti(p.tsf + ts_delay, p.bi_tu,
                  None if p.change is None else E.parse_bss_param_change(B.encode_change(p.change)[2:]), p.j)
            for p in plan]


def lead(k=3):
    """BTI до объявления (TBTT = k·BI на шкале TSF)."""
    return [B.Bti((10 - k + i) * BI_US + 7, BI, None, -i) for i in range(k)]


def test_nbr_must_exceed_max_lost_beacons():
    # 11.29.2/11.29.3: «The value of dot11NbrOfChangeBeacons shall be greater than dot11MaxLostBeacons» (= 4);
    # MIB DEFVAL { 4 } — недопустим (PLAN.md №38)
    assert B.DOT11_NBR_OF_CHANGE_BEACONS_DEFVAL == T.DOT11_MAX_LOST_BEACONS == 4
    with pytest.raises(ValueError):
        B.ApBssParamChange(BI, nbr=4)
    assert B.ApBssParamChange(BI).nbr == 5
    with pytest.raises(ValueError):
        B.ApBssParamChange(BI, nbr=33)                       # SYNTAX 1..32


def test_change_element_fields():
    assert B.check_change(dict(move=0, size=1, tbtt_offset=0, bi_duration=50, _r2=0)) == []
    assert B.check_change(dict(move=0, size=0, tbtt_offset=0, bi_duration=0, _r2=0))
    assert B.check_change(dict(move=0, size=1, tbtt_offset=0, bi_duration=0, _r2=0))    # BI 0
    assert B.check_change(dict(move=1, size=0, tbtt_offset=0, bi_duration=0, _r2=2))    # резерв B2–B7


def test_plan_size_figure_11_48():
    # 11.29.3: N объявлений, TBTT Offset — TBTT позиции N+1; там BI = BI Duration и TSF = 0
    pl = B.ApBssParamChange(BI).plan(10 * BI_US, new_bi_tu=50)
    assert [p.change is not None for p in pl[:6]] == [True] * 5 + [False]
    assert pl[0].change.tbtt_offset == 15 * BI_US and pl[5].at == 15 * BI_US
    assert pl[5].tsf == 0 and pl[5].bi_tu == 50 and pl[6].at - pl[5].at == 50 * T.TU


def test_plan_move_figure_11_47():
    # 11.29.2: Beacon Interval на N+1 = новый TBTT − TBTT N+1; новый TBTT — N+2-й; TSF = 0
    new = 15 * BI_US + 30 * T.TU
    pl = B.ApBssParamChange(BI).plan(10 * BI_US, move_to=new)
    assert pl[5].bi_tu == 30 and pl[5].change is not None and pl[6].at == new and pl[6].tsf == 0
    assert pl[0].change.tbtt_offset == new and B.new_tbtt_of(pl) == new
    ap = B.ApBssParamChange(BI)
    with pytest.raises(ValueError):
        ap.plan(10 * BI_US, move_to=15 * BI_US + 2 * BI_US + T.TU)     # сдвиг больше Beacon Interval
    with pytest.raises(ValueError):
        ap.plan(10 * BI_US, move_to=15 * BI_US + 100)                 # не кратно TU


def test_sequence_size_ok_and_errors():
    pl = B.ApBssParamChange(BI).plan(10 * BI_US, new_bi_tu=50)
    v, sk, runs = B.check_beacon_sequence(lead() + btis(pl))
    assert v == [] and sk == [] and runs[0]['nbr'] == 5 and runs[0]['new_bi'] == 50
    # 4 объявления — мало (11.29.3)
    v, _, _ = B.check_beacon_sequence(lead() + btis(B.ApBssParamChange(BI).plan(10 * BI_US, new_bi_tu=50))[1:])
    assert any('dot11MaxLostBeacons' in m for _, m in v)
    # TSF не сброшен после изменения
    b = btis(pl)
    b[5] = b[5]._replace(ts=15 * BI_US + 7)
    assert any('TSF не сброшен' in m for _, m in B.check_beacon_sequence(lead() + b)[0])
    # элемент изменился посреди объявления
    b = btis(pl)
    b[2] = b[2]._replace(change=dict(b[2].change, bi_duration=60))
    assert any('изменился' in m for _, m in B.check_beacon_sequence(lead() + b)[0])


def test_sequence_move_ok_and_errors():
    new = 15 * BI_US + 30 * T.TU
    pl = B.ApBssParamChange(BI).plan(10 * BI_US, move_to=new)
    v, sk, runs = B.check_beacon_sequence(lead() + btis(pl))
    assert v == [] and sk == [] and runs[0]['nbr'] == 5 and runs[0]['d'] == 30 * T.TU
    # элемент в маяках N+1 отсутствует — допустимо (PLAN.md №39)
    b = btis(pl)
    b[5] = b[5]._replace(change=None)
    assert B.check_beacon_sequence(lead() + b)[0] == []
    # Beacon Interval на N+1 не равен разности
    b = btis(pl)
    b[5] = b[5]._replace(bi_tu=40)
    assert any('разности' in m or 'difference' in m for _, m in B.check_beacon_sequence(lead() + b)[0])
    # элемент после нового TBTT (объявление не остановлено)
    b = btis(pl)
    b[6] = b[6]._replace(change=b[0].change)
    assert B.check_beacon_sequence(lead() + b)[0]


def test_sequence_capture_edges():
    pl = B.ApBssParamChange(BI).plan(10 * BI_US, new_bi_tu=50)
    _, sk, _ = B.check_beacon_sequence(btis(pl)[:3])
    assert any('началось до начала захвата' in m for m in sk) and any('кончился' in m for m in sk)


def test_sta_must_not_cross_new_tbtt_and_schedule_fits():
    assert B.sta_tx_crosses_new_tbtt(90, 110, 100) and not B.sta_tx_crosses_new_tbtt(90, 99, 100)
    assert B.sta_tx_crosses_new_tbtt(90, 100, 100)          # «ends at the TBTT or later»
    a = E.Allocation({'allocation_id': 1}, 0, 0, 0, start=1000, block_duration=60 * 1024, num_blocks=1,
                     block_period=0)
    assert B.check_schedule_fits([a], 0, 100) == [] and B.check_schedule_fits([a], 0, 50)


def test_recommendation_11_29_5():
    rec = B.recommend(bi_tu=50)
    assert rec == B.Change(0, 1, 0, 50)
    ap = B.ApBssParamChange(BI)
    els, plan = B.ap_answer(rec, True, ap, now_tsf=10 * BI_US + 500)
    assert els and els[0].eid == E.EID_DMG_BSS_PARAMETER_CHANGE and plan[0].change.bi_duration == 50
    assert B.ap_answer(rec, False, ap, 0) == ([], None)          # «shall not include»
    # перенос: рекомендованный TBTT Offset — TSF STA
    els, plan = B.ap_answer(B.recommend(sta_tsf_at_tbtt=20 * BI_US + 30 * T.TU), True, ap, now_tsf=10 * BI_US)
    assert B.new_tbtt_of(plan) == 20 * BI_US + 30 * T.TU
    # слишком поздно для dot11NbrOfChangeBeacons — точка не меняет
    assert B.ap_answer(B.recommend(sta_tsf_at_tbtt=12 * BI_US), True, ap, now_tsf=10 * BI_US) == ([], None)
    ch = E.parse_bss_param_change(els[0].info)
    assert B.check_recommendation_answer(ch, [ch]) == [] and B.check_recommendation_answer(ch, [])
    assert B.check_recommendation_answer(None, []) == []


def test_info_frames():
    # табл. 9-460: Category 16, DMG Action 2, Subject Address, Request element; табл. 9-461: DMG Capabilities
    req = B.encode_info(B.ACT_INFO_REQ, AP, [E.Element(10, None, b'')])
    f = B.parse_info(req)
    assert req[:2] == bytes([16, 2]) and f.subject == AP and B.check_info(f) == []
    assert B.check_info(B.parse_info(B.encode_info(B.ACT_INFO_REQ, AP)))
    resp = B.parse_info(B.encode_info(B.ACT_INFO_RESP, T.BCAST))
    assert any('DMG Capabilities' in m for m in B.check_info(resp))
    cap = E.encode_dmg_capabilities(E.DmgCapabilities(AP, 0, {}, {}, 0, {}, 0, 0))
    resp = B.parse_info(B.encode_info(B.ACT_INFO_RESP, T.BCAST) + cap)
    assert B.check_info(resp, T.BCAST, noack=False) and B.check_info(resp, T.BCAST, noack=True) == []


# ---------------------------------------------------------------------------------------------- судья
def beacon(a, t, ts, bi_tu, els=()):
    p = NS(beacon_interval=bi_tu, timestamp=int(ts), ssw=NS(cdown=0, sector_id=0),
           elements=tuple((x[0], None, bytes(x[2:])) for x in els), bic=None, params=None)
    return a.add('DMG Beacon', AP, T.BCAST, t, length=60, p=p, tx='AP')


def air_from(plan, lead_n=2):
    a = Air()
    for i in range(lead_n):
        t = plan[0].at - (lead_n - i) * BI_US
        beacon(a, t + 7, t + 7, BI)
    for p in plan:
        beacon(a, p.at + 7, p.tsf + 7, p.bi_tu, [B.encode_change(p.change)] if p.change else [])
    return a


def test_judge_bss_params_move_and_sta_crossing():
    new = 15 * BI_US + 30 * T.TU
    plan = B.ApBssParamChange(BI).plan(10 * BI_US, move_to=new)
    a = air_from(plan)
    r = J.r_bss_params(a.ctx())
    assert r.viol == [] and r.checked == 6 and r.info['changes'][0]['nbr'] == 5
    a = air_from(plan)
    a.add('Data', STA, AP, new - 5, length=2000, mcs=4, tx='STA')       # конец за новым TBTT
    assert any('11.29.2' in m for _, m, _ in J.r_bss_params(a.ctx()).viol)


def test_judge_bss_params_none_and_size_short():
    a = Air()
    beacon(a, 1000, 1007, BI)
    r = J.r_bss_params(a.ctx())
    assert r.checked == 0 and r.unchecked
    plan = B.ApBssParamChange(BI).plan(10 * BI_US, new_bi_tu=50)
    a = air_from(plan[1:], lead_n=2)                                     # только 4 объявления
    assert any('dot11MaxLostBeacons' in m for _, m, _ in J.r_bss_params(a.ctx()).viol)


def test_judge_recommendation():
    a = Air()
    rec = E.Element(E.EID_DMG_BSS_PARAMETER_CHANGE, None, B.encode_change(B.recommend(bi_tu=50))[2:])
    act(a, STA, AP, 1000, B.encode_info(B.ACT_INFO_REQ, AP, [E.Element(10, None, b''), rec]))
    a.add('Data', STA, AP, 1000 + 200 * T.TU, length=100, mcs=4, tx='STA')
    r = J.r_bss_params(a.ctx())
    assert any('без Information Response' in m for _, m, _ in r.viol)
    a = Air()
    act(a, STA, STA, 1000, B.encode_info(B.ACT_INFO_REQ, AP, [E.Element(10, None, b''), rec]))
    assert any('не точке' in m for _, m, _ in J.r_bss_params(a.ctx()).viol)


def test_judge_rule_registered():
    assert J.r_bss_params in J.RULES and 'bss_params_tsf' in {x[0] for x in J.NOT_CHECKABLE}
