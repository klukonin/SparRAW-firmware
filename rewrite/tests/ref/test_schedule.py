# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/schedule: Extended Schedule (9.4.2.131 [p. 1246–1249], рис. 9-562…9-564, табл. 9-257), BF Control в расписании
(9.5.5 [p. 1441]), расписание BI (10.39.6.1–10.39.6.5 [p. 1884–1888]), псевдостатика (10.39.6.4 [p. 1887]), знание STA
(obsolete allocation 10.39.6.1), генератор. Ожидания — из текста стандарта (числа формулы guard time, биты рисунков)."""
import os

import pytest

from . import bi as BI
from . import elements as E
from . import fields as F
from . import schedule as S
from . import test_consistency as TC
from .timing import AID_BROADCAST, aDMGPPMinListeningTime, DOT11_MAX_LOST_BEACONS, TU

BI_TU = 100
BI_US = BI_TU * TU                       # 102 400 мкс


@pytest.mark.parametrize('mod', ('schedule', 'sp', 'dynalloc', 'air_sched', 'tdma_scen'))
def test_shared_constants_only_in_timing(mod):
    """Как test_consistency: новые модули не определяют заново постоянные timing.py."""
    TC.test_no_redefinition_of_timing_constants(mod)
    TC.test_reexported_constants_are_timing_objects(mod)
    assert os.path.exists(os.path.join(TC.HERE, mod + '.py'))


# ---------------------------------------------------------------------------------------------- кодек
def test_allocation_bits_fig_9_564_and_bf_control_fig_9_852():
    """Allocation Control (рис. 9-564): ID B0–B3, AllocationType B4–B6, Pseudo-static B7, Truncatable B8, Extendable B9,
    PCP Active B10, LP SC Used B11; BF Control (рис. 9-852): BT B0, IsInitiatorTXSS B1, IsResponderTXSS B2, RXSS Length
    B3–B8. Поле — 15 октетов (рис. 9-563), элемент — ID 144 (табл. 9-92)."""
    bfc = F.BfControl(bt=1, is_init_txss=1, is_resp_txss=0, rxss_length=3)
    e = S.sp(1, 2, 0x11223344, 1000, alloc_id=5, pseudo_static=1, truncatable=1, extendable=1, pcp_active=1, lp_sc=1,
             bfc=bfc)
    b = S.encode([e])
    assert b[0] == 144 and b[1] == 15
    info = b[2:]
    assert int.from_bytes(info[0:2], 'little') == 5 | 1 << 7 | 1 << 8 | 1 << 9 | 1 << 10 | 1 << 11 == 0x0F85
    assert int.from_bytes(info[2:4], 'little') == 1 | 1 << 1 | 3 << 3
    assert info[4:6] == bytes([1, 2])
    assert info[6:10] == (0x11223344).to_bytes(4, 'little')
    assert int.from_bytes(info[10:12], 'little') == 1000 and info[12] == 1
    d = S.decode(info)
    assert len(d) == 1 and d[0].alloc.fields() == e.alloc.fields() and d[0].bfc == bfc
    # CBAP: AllocationType = 1 (табл. 9-257: B4 = 1)
    c = S.encode([S.cbap(100, 2000)])
    assert (int.from_bytes(c[2:4], 'little') >> 4) & 7 == 1


def test_split_into_elements_is_one_schedule():
    """9.4.2.131: «can split the Allocation fields into more than one Extended Schedule element» — 255 // 15 = 17 полей
    на элемент; набор элементов — «a single schedule for the beacon interval»."""
    es = [S.sp(1, 2, 10000 + 1000 * i, 100, alloc_id=1 + i % 15) for i in range(18)]
    b = S.encode(es)
    elems = E.parse_elements(b)
    assert len(elems) == 2
    got = S.from_elements(elems)
    assert [g.alloc.start for g in got] == [e.alloc.start for e in es]
    assert S.from_elements([(5, None, b'\x00')]) is None


def test_cmmg_allocation_type_rejected_for_dmg():
    """Табл. 9-257: 010/110 — распределения на канале 1,08 ГГц (CMMG), остальные — резерв: не DMG."""
    f = S.to_field(S.sp(1, 2, 0, 100))
    f.ctrl['allocation_type'] = 2
    with pytest.raises(S.ScheduleError):
        S.from_field(f)


# ---------------------------------------------------------------------------------------------- расписание BI
def _plan(*reqs, bhi=2000):
    return S.plan(0, BI_TU, bhi, list(reqs))


def test_plan_is_valid_and_uses_guard_time():
    """10.39.6.5: guard time между непсевдостатичными (A = 0, D = BI): Ceil((20·102 400 + 20·102 400)/10⁶ + 3 + 0,1,
    1) = Ceil(7,196) = 8 мкс; между псевдостатичными (A = 4): Ceil(20,48 + 3,1) = 24 мкс."""
    es = _plan(S.Req(S.SP, 1, 2, 1000), S.Req(S.CBAP, 255, 255, 1000), S.Req(S.SP, 3, 4, 1000, pseudo_static=1),
               S.Req(S.SP, 5, 6, 1000, pseudo_static=1))
    st = [e.alloc.start for e in es]
    assert st[1] - (st[0] + 1000) == 8 and st[3] - (st[2] + 1000) == 24
    assert BI.guard_between(True, False, BI_US) == 16 == st[2] - (st[1] + 1000)
    assert S.check(es, 0, BI_TU) == []
    assert es[1].alloc.alloc_id == 0                     # broadcast CBAP — Allocation ID 0 (9.4.2.131)


def test_plan_listening_time_between_sps_sharing_sta():
    """10.39.6.2: соседние SP с общей STA — «separated by at least aDMGPPMinListeningTime» (150 мкс, табл. 11-22)."""
    es = _plan(S.Req(S.SP, 1, 2, 1000), S.Req(S.SP, 2, 3, 1000))
    assert es[1].alloc.start - (es[0].alloc.start + 1000) == aDMGPPMinListeningTime
    es2 = S.plan(0, BI_TU, 2000, [S.Req(S.SP, 1, 2, 1000), S.Req(S.SP, 2, 3, 1000)], listen=False)
    rules = [r for r, _ in S.check(es2, 0, BI_TU)]
    assert rules == ['should_sp_listen']


def test_plan_cannot_cross_tbtt():
    """9.4.2.131: Allocation Block Duration «cannot cross beacon interval boundaries»."""
    with pytest.raises(S.ScheduleError):
        _plan(S.Req(S.SP, 1, 2, 32000), S.Req(S.SP, 3, 4, 32000), S.Req(S.SP, 5, 6, 32000), S.Req(S.SP, 7, 8, 32000))


def _rules(es, **kw):
    return {r for r, _ in S.check(es, 0, BI_TU, **kw)}


@pytest.mark.parametrize('case, rule', [
    ('overlap', 'overlap'), ('guard7', 'guard'), ('order', 'es_order'), ('dup', 'es_dup'), ('bhi', 'in_bhi'),
    ('cross', 'cross_bi'), ('bf_bcast', 'es_bf_bcast'), ('bf_both_txss', 'es_bfc'), ('cbap_trunc', 'alloc_reserved'),
    ('cbap_lp_sc', 'alloc_lp_sc'), ('pcp_active0', 'alloc_pcp_active'), ('delivery', 'alloc_delivery'),
    ('sp_dur_max', 'alloc_dur'), ('period_n1', 'es_field')])
def test_schedule_negative(case, rule):
    """Нарушения 9.4.2.131 / 10.39.6.x: каждое — своё правило."""
    a = S.sp(1, 2, 10000, 1000)
    b = S.sp(3, 4, 11008, 1000)
    es, kw = [a, b], {}
    if case == 'overlap':
        es = [a, S.sp(3, 4, 10500, 1000)]
    elif case == 'guard7':
        es = [a, S.sp(3, 4, 11007, 1000)]                 # 7 мкс < 8 мкс guard (10.39.6.5)
    elif case == 'order':
        es = [b, a]
    elif case == 'dup':
        es = [a, S.sp(1, 2, 11008, 1000)]                 # тот же (Source, Destination, Allocation ID)
    elif case == 'bhi':
        kw = dict(bti_end=10500)
    elif case == 'cross':
        es = [S.sp(1, 2, BI_US - 500, 1000)]
    elif case == 'bf_bcast':
        es = [S.cbap(10000, 1000, bfc=F.BfControl(bt=1, is_init_txss=1))]
    elif case == 'bf_both_txss':
        es = [S.sp(1, 2, 10000, 1000, bfc=F.BfControl(bt=1, is_init_txss=1, is_resp_txss=1))]
    elif case == 'cbap_trunc':
        es = [S.cbap(10000, 1000, src=1, dst=2, truncatable=1)]
    elif case == 'cbap_lp_sc':
        es = [S.cbap(10000, 1000, lp_sc=1)]
    elif case == 'pcp_active0':
        es = [S.sp(1, 2, 10000, 1000, pcp_active=0)]       # 10.39.6.1: AP ставит PCP Active = 1 всегда
    elif case == 'delivery':
        kw = dict(es_tx_tsf=9800)                          # 10000 < 9800 + aMinAllocationDeliveryTime (300)
    elif case == 'sp_dur_max':
        es = [S.sp(1, 2, 10000, 32768)]                    # SP: 1…32 767
    elif case == 'period_n1':
        es = [S.sp(1, 2, 10000, 1000, block_period=5)]     # Block Period резервный при Number of Blocks = 1
    assert rule in _rules(es, **kw)


def test_pcp_may_clear_pcp_active_but_not_with_truncatable():
    """9.4.2.131: PCP Active = 1 «at least» — PCP источник/получатель, Truncatable/Extendable = 1, передаёт AP."""
    es = [S.sp(1, 2, 10000, 1000, pcp_active=0)]
    assert _rules(es, role=E.ROLE_PCP) == set()
    es = [S.sp(1, 2, 10000, 1000, pcp_active=0, truncatable=1)]
    assert 'alloc_pcp_active' in _rules(es, role=E.ROLE_PCP)


def test_cbap_only_with_extended_schedule():
    """10.39.6.3: CBAP Only = 0, если DMG Beacon содержит Extended Schedule."""
    es = [S.cbap(10000, 1000)]
    assert 'cbap_only_es' in _rules(es, params=BI.DmgParameters(cbap_only=1), has_es_in_beacon=True)


# ---------------------------------------------------------------------------------------------- повтор и история
def test_repeats_in_bi():
    """10.39.6.1: содержимое ES внутри BI не меняется; исключение — PCP Active CBAP у PCP с несколькими антеннами."""
    a = [S.sp(1, 2, 10000, 1000), S.cbap(11008, 1000)]
    b = [S.sp(1, 2, 10000, 1000), S.cbap(11008, 1000, pcp_active=0)]
    assert S.check_repeats([a, list(a)]) == []
    assert [r for r, _ in S.check_repeats([a, b])] == ['es_repeat_changed']
    assert S.check_repeats([a, b], pcp_multi_antenna=True) == []


def test_history_overlap_with_previous_pseudo_static():
    """10.39.6.4: после изменения псевдостатичного «should not schedule a new allocation that overlaps with the
    previous pseudo-static allocation for a minimum of dot11MaxLostBeacons beacon intervals unless both … CBAP or the
    new allocation identifies the same source»."""
    ps = S.sp(1, 2, 10000, 1000, pseudo_static=1)
    sched = {0: [ps]}
    for k in range(1, 1 + DOT11_MAX_LOST_BEACONS + 1):
        off = int(k * BI_US)
        # в BI 1 распределение (1→2) перенесено на 30 000; новое (3→4) — на месте прежнего
        sched[k] = [S.sp(3, 4, 10000 + off, 1000), S.sp(1, 2, 30000 + off, 1000, pseudo_static=1)]
    v = S.check_history(sched, BI_TU)
    ks = sorted(int(m.split(':')[0].split()[1]) for r, m in v if r == 'should_ps_overlap')
    assert ks == [1, 2, 3, 4]                              # BI 1…4 = kn … kn + dot11MaxLostBeacons − 1
    # тот же источник — допустимо
    sched2 = {0: [ps], 1: [S.sp(1, 5, 10000 + int(BI_US), 1000), S.sp(1, 2, 30000 + int(BI_US), 1000,
                                                                       pseudo_static=1)]}
    assert S.check_history(sched2, BI_TU) == []


def test_history_moved_start_needs_delivery_time():
    """10.39.6.1: изменение начала существующего псевдостатичного с non-AP участником — не ближе
    aMinAllocationDeliveryTime (300 мкс) к передаче ES."""
    off = int(BI_US)
    sched = {0: [S.sp(1, 2, 10000, 1000, pseudo_static=1)], 1: [S.sp(1, 2, off + 5000, 1000, pseudo_static=1)]}
    assert [r for r, _ in S.check_history(sched, BI_TU, es_tx={1: off + 4800})] == ['alloc_delivery_ps']
    assert S.check_history(sched, BI_TU, es_tx={1: off + 4700}) == []


# ---------------------------------------------------------------------------------------------- знание STA
def test_sta_view_pseudo_static_recurs_and_ceases():
    """10.39.6.4: псевдостатичное повторяется с тем же смещением от TBTT; STA «shall cease transmission» после
    dot11MaxLostBeacons BI подряд без ES (bi.pseudo_static_valid, view='sta'); непсевдостатичные пропущенного BI STA не
    знает (10.39.6.7)."""
    v = S.StaView(1, BI_TU)
    v.receive(0, [S.sp(1, 2, 10000, 1000, pseudo_static=1), S.sp(1, 0, 20000, 1000)])
    assert len(v.allocations(0)) == 2
    for k in (1, 2, 3):
        al = v.allocations(k)
        assert len(al) == 1 and al[0].alloc.start == 10000 + k * BI_US
    assert v.allocations(4) == []


def test_sta_view_obsolete_allocation():
    """10.39.6.1: новое псевдостатичное, принятое после своего начала (TSF приёма > TSF начала), — obsolete,
    игнорируется; уже известное — нет."""
    v = S.StaView(1, BI_TU)
    v.receive(0, [S.sp(1, 2, 10000, 1000, pseudo_static=1)], rx_tsf=12000)
    assert v.allocations(0) == []
    v2 = S.StaView(1, BI_TU)
    v2.receive(0, [S.sp(1, 2, 10000, 1000, pseudo_static=1)], rx_tsf=5000)
    v2.receive(1, [S.sp(1, 2, 10000 + int(BI_US), 1000, pseudo_static=1)], rx_tsf=BI_US + 12000)
    assert len(v2.allocations(1)) == 1


def test_sta_view_cbap_only():
    """10.39.6.3: CBAP Only — псевдостатичный CBAP на dot11MaxLostBeacons BI; отменяется ES в Announce."""
    v = S.StaView(1, BI_TU)
    v.receive_cbap_only(0)
    assert all(v.cbap_only(k) for k in range(4)) and not v.cbap_only(4)
    v.receive(2, [S.sp(1, 2, 10000 + 2 * int(BI_US), 100)])
    assert not v.cbap_only(2)
    assert AID_BROADCAST == 255
