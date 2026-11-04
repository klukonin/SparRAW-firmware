# SPDX-License-Identifier: AGPL-3.0-or-later
"""Эталон структуры BI DMG: ожидания — из текста 802.11-2020 (табл. 11-22, рис. 9-77, 9-563/9-564, 10-55, 10-75,
10-76, 11-2; 9.4.2.131, 10.39.2–10.39.6.5, 10.42.4, 10.42.5, 11.1.2.1, 11.1.3.3), числа — ручным расчётом по
формулам, TXTIME — независимо по 20.11.3."""
from fractions import Fraction as Fr
from math import ceil

import pytest

from . import bi as B

BI_TU = 100                                  # dot11BeaconPeriod 100 TU = 102 400 мкс
BI = 102400
AP, S1, S2, S3 = 'ap', 's1', 's2', 's3'
AIDS = {AP: 0, S1: 1, S2: 2, S3: 3}


def ctrl_tx(length):
    """20.11.3, control mode: (50+9)·128·Tc + (88 + (L−6)·8 + NCW·168)·32·Tc, NCW = 1 + ⌈(L−6)·8/168⌉, Tc = 1/1760."""
    ncw = 1 + ceil(Fr((length - 6) * 8, 168))
    return Fr(59 * 128 + (88 + (length - 6) * 8 + ncw * 168) * 32, 1760)


TX_SSW = ctrl_tx(26)                         # рис. 9-54: 26 октетов
TX_FB = ctrl_tx(28)                          # рис. 9-55: 28 октетов
TX_BEACON = ctrl_tx(80)
MBIFS = 9                                    # 10.3.2.3.10: 3 × aSIFSTime


def sst(fss):
    """10.42.5.2 + табл. 11-22, вручную: 0,1 + ((FSS−1)·1 + FSS·TXTIME(SSW)) + 9 + TXTIME(SSW-FB) + 9."""
    return Fr(1, 10) + (fss - 1) + fss * TX_SSW + 9 + TX_FB + 9


# ---------------- постоянные и формулы ----------------
def test_constants_table_11_22():
    assert B.aMaxBIDuration == 1000 * 1024
    assert (B.aMinBTIPeriod, B.aSSFramesPerSlot, B.aDMGTSFAccuracy, B.aMaxABFTAccessPeriod) == (4, 4, 20, 2)
    assert (B.aTSFResolution, B.aMinAllocationDeliveryTime, B.aDMGPPMinListeningTime) == (1, 300, 150)
    assert B.DOT11_MAX_LOST_BEACONS == 4          # 11.1.3.3.3: AP — aMinBTIPeriod (и DEFVAL 4)
    assert (B.AID_AP_PCP, B.AID_BROADCAST) == (0, 255)


def test_ssw_txtimes():
    assert B.T_SSW == TX_SSW == Fr(164, 11)
    assert B.T_SSW_FB == TX_FB == Fr(1004, 55)


def test_ceil_two_params():
    """1.5: «Ceil (2.3, 2) is 4 and Ceil (–2.3, 2) is –2»."""
    assert B.ceil_to(Fr(23, 10), 2) == 4
    assert B.ceil_to(Fr(-23, 10), 2) == -2


def test_rx_advance_time():
    """10.39.2: Ceil(20·102400/10⁶ + 0,1, 1) = Ceil(2,148) = 3; T_DI = 0 → Ceil(0,1) = 1."""
    assert B.rx_advance_time(BI) == 3
    assert B.rx_advance_time(0) == 1


def test_guard_time_formula():
    """10.39.6.5: оба псевдостатичные (A = 4, D = BI): (5·20·102400·2)/10⁶ + 3 + 0,1 = 23,58 → 24."""
    assert B.guard_time(4, BI, 4, BI) == 24
    assert B.guard_between(True, True, BI) == 24
    # непсевдостатичные, D = 1000 мкс: 0,04 + 3,1 = 3,14 → 4
    assert B.guard_between(False, False, BI, 1000, 1000) == 4
    # минимальное значение: SIFS + T_P = 3,1 → 4
    assert B.guard_time(0, 0, 0, 0) == 4
    # непсевдостатичное → псевдостатичное, D = BI: (20·102400 + 5·20·102400)/10⁶ + 3,1 = 15,388 → 16
    assert B.guard_between(False, True, BI) == 16


def test_ss_slot_time():
    """10.42.5.2: aSSSlotTime = aAirPropagationTime + aSSDuration + MBIFS + aSSFBDuration + MBIFS."""
    assert B.ss_duration(8) == 7 + 8 * TX_SSW               # табл. 11-22
    assert B.ss_duration(1) == TX_SSW
    assert B.ss_slot_time(8) == sst(8)
    assert B.ss_slot_time(4) == sst(4)
    s, e = B.abft_slot(1000, 3, 8)
    assert (s, e) == (1000 + 3 * sst(8), 1000 + 4 * sst(8))
    # SSW-Feedback начинается за aSSFBDuration + MBIFS до конца слота
    assert B.ssw_fb_start(e) == e - TX_FB - MBIFS


# ---------------- Beacon Interval Control (рис. 9-77) ----------------
def test_bic_encoding_minus_one():
    """Рис. 10-75: «A-BFT LENGTH = 8», FSS 8 — поля 9.3.4.2 хранят «minus 1»."""
    c = B.BeaconIntervalControl(abft_length=7, fss=7)
    assert (c.abft_slots, c.fss_frames, c.abft_present) == (8, 8, True)
    assert not B.BeaconIntervalControl(next_abft=2).abft_present
    assert c.validate() == []


def test_bic_validate():
    rules = lambda c, **kw: sorted(r for r, _ in c.validate(**kw))
    # 10.42.5.2: FSS ≥ aSSFramesPerSlot (4 кадра → поле 3)
    assert rules(B.BeaconIntervalControl(fss=3)) == []
    assert rules(B.BeaconIntervalControl(fss=2)) == ['bic_fss']
    # 11.1.2.1: TXSS Span ≤ dot11MaxLostBeacons; 9.3.4.2: ≥ 1
    assert rules(B.BeaconIntervalControl(txss_span=4)) == []
    assert rules(B.BeaconIntervalControl(txss_span=5)) == ['bic_txss_span']
    assert rules(B.BeaconIntervalControl(txss_span=0)) == ['bic_txss_span']
    # 11.1.3.4: Discovery Mode → Next A-BFT = 0
    assert rules(B.BeaconIntervalControl(discovery_mode=1, next_abft=1)) == ['bic_discovery']
    # ширины полей рис. 9-77
    assert rules(B.BeaconIntervalControl(abft_length=8)) == ['bic_range']
    assert rules(B.BeaconIntervalControl(next_beacon=16)) == ['bic_range']


# ---------------- TBTT / TSF ----------------
def test_tbtt():
    """11.1.3.3.1: TSF 0 — TBTT, TBTT через dot11BeaconPeriod TU."""
    assert B.tbtt(0, BI_TU) == 0
    assert B.tbtt(3, BI_TU) == 3 * 102400
    assert B.bi_index(102399, BI_TU) == 0 and B.bi_index(102400, BI_TU) == 1


def test_full_tsf_wrap():
    assert B.full_tsf(100, 2 ** 32 - 50) == 2 ** 32 + 100
    assert B.full_tsf(2 ** 32 - 10, 5) == -10           # ближайшее: чуть раньше 0 (СПОРНО — см. full_tsf)
    assert B.full_tsf(5000, 3 * 2 ** 32 + 4000) == 3 * 2 ** 32 + 5000


# ---------------- Allocation (9.4.2.131, 10.39.6.1) ----------------
def test_allocation_blocks():
    """10.39.6.1: начало i-го блока A_start + (i−1)·A_period, конец + Allocation Block Duration."""
    a = B.Allocation(B.SP, 1, 2, start=10000, block_dur=500, n_blocks=3, block_period=2000)
    assert a.blocks(0) == [(10000, 10500), (12000, 12500), (14000, 14500)]
    # 9.4.2.131: период резервный при одном блоке
    assert B.Allocation(B.SP, 1, 2, 10000, 500, 1, 7777).blocks(0) == [(10000, 10500)]


def test_allocation_validate():
    r = lambda a, **kw: sorted(x for x, _ in a.validate(**kw))
    assert r(B.Allocation(B.SP, 1, 2, 0, 32767)) == []
    assert r(B.Allocation(B.SP, 1, 2, 0, 32768)) == ['alloc_dur']        # SP: 1..32 767
    assert r(B.Allocation(B.CBAP, 1, 2, 0, 65535)) == []                 # CBAP: 1..65 535
    assert r(B.Allocation(B.CBAP, 1, 2, 0, 0)) == ['alloc_dur']
    assert r(B.Allocation(B.CBAP, 255, 255, 0, 100, alloc_id=1)) == ['alloc_id']   # broadcast CBAP → ID 0
    assert r(B.Allocation(B.CBAP, 255, 255, 0, 100, alloc_id=0)) == []
    assert r(B.Allocation(B.SP, 1, 2, 0, 100, pcp_active=0)) == ['alloc_pcp_active']   # AP: всегда 1
    assert r(B.Allocation(B.SP, 1, 2, 0, 100, pcp_active=0), by_ap=False) == []
    assert r(B.Allocation(B.SP, 1, 2, 0, 100, pcp_active=0, truncatable=1), by_ap=False) == ['alloc_pcp_active']
    assert r(B.Allocation(B.CBAP, 1, 2, 0, 100, truncatable=1)) == ['alloc_reserved']
    assert r(B.Allocation(B.CBAP, 1, 2, 0, 100, lp_sc=1)) == ['alloc_lp_sc']


def test_pseudo_static():
    """10.39.6.4: повтор с тем же смещением от TBTT; срок — dot11MaxLostBeacons BI (оба прочтения)."""
    a = B.Allocation(B.SP, 1, 2, start=30000, block_dur=1000, pseudo_static=1)
    assert a.recur(0, 2, BI).blocks(B.tbtt(2, BI_TU)) == [(2 * BI + 30000, 2 * BI + 31000)]
    assert [B.pseudo_static_valid(0, k) for k in range(6)] == [True, True, True, True, False, False]
    assert [B.pseudo_static_valid(0, k, view='ap') for k in range(6)] == [True] * 5 + [False]
    # 10.39.6.1: obsolete — TSF приёма больше TSF начала
    assert B.obsolete(a, 30001) and not B.obsolete(a, 29999)
    assert not B.obsolete(B.Allocation(B.SP, 1, 2, 30000, 1000), 40000)   # только для псевдостатичных


# ---------------- BTI: порядок маяков ----------------
def test_txss_plan_fragmented():
    """10.42.4: CDOWN — до конца всего TXSS, последний маяк — 0; TXSS Span — число BI."""
    span, frag, btis = B.txss_plan(list(range(10)), per_bti=4)
    assert (span, frag) == (3, 1)
    assert [[c for _, c in b] for b in btis] == [[9, 8, 7, 6], [5, 4, 3, 2], [1, 0]]
    assert [s for b in btis for s, _ in b] == list(range(10))
    span, frag, btis = B.txss_plan([2, 7, 0, 1])               # рис. 11-2: другой порядок направлений
    assert (span, frag, btis) == (1, 0, [[(2, 3), (7, 2), (0, 1), (1, 0)]])
    with pytest.raises(ValueError):
        B.txss_plan([1, 2, 1])                                   # 11.1.3.3.1: сектор дважды в BTI


def test_bti_beacons_timing_and_duration():
    """10.42.2.2.2: SBIFS между маяками; 9.3.4.2: Duration — остаток BTI (вверх до мкс, 9.2.5.1)."""
    t0 = B.tbtt(1, BI_TU)
    bea, end = B.bti_beacons(t0, [(0, 2), (1, 1), (2, 0)], TX_BEACON)
    assert [b[0] for b in bea] == [t0, t0 + TX_BEACON + 1, t0 + 2 * TX_BEACON + 2]
    assert end == t0 + 3 * TX_BEACON + 2
    assert [b[4] for b in bea] == [ceil(2 * TX_BEACON + 2), ceil(TX_BEACON + 1), 0]


# ---------------- layout (10.39.2, рис. 10-55) ----------------
def cfg_full(**kw):
    bic = B.BeaconIntervalControl(abft_length=7, fss=7, ati_present=1)
    allocs = [B.Allocation(B.CBAP, 255, 255, 20000, 30000, alloc_id=0),
              B.Allocation(B.SP, 1, 2, 50100, 10000, alloc_id=1),
              B.Allocation(B.SP, 2, 1, 60200, 20000, alloc_id=2),
              B.Allocation(B.CBAP, 255, 255, 80300, 22000, alloc_id=0)]
    return B.BiConfig(bic, allocations=allocs, ati_duration=2000, **kw)


def test_layout_figure_10_55():
    """Рис. 10-55: BTI, A-BFT, ATI, CBAP 1, SP 1, SP 2, CBAP 2; A-BFT через MBIFS после BTI (10.42.5.1)."""
    end = 300
    per = B.layout(0, BI_TU, cfg_full(), bti_end=end)
    assert [p.kind for p in per] == ['BTI', 'A-BFT', 'ATI', 'CBAP', 'SP', 'SP', 'CBAP']
    assert (per[0].start, per[0].end) == (0, 300)
    assert (per[1].start, per[1].end) == (309, 309 + 8 * sst(8))
    ati0 = 309 + 8 * sst(8) + MBIFS                           # 10.39.3: не раньше Max(guard, MBIFS)
    assert (per[2].start, per[2].end) == (ati0, ati0 + 2000)
    assert (per[4].start, per[4].end, per[4].src_aid, per[4].dst_aid) == (50100, 60100, 1, 2)
    assert B.period_at(per, 50100).kind == 'SP'
    assert B.period_at(per, 50099) is None                     # между CBAP 1 и SP 1 — нет доступа
    assert B.period_at(per, 60100) is None                     # [start, end)
    assert B.check_schedule(0, BI_TU, cfg_full(), bti_end=end) == []


def test_layout_no_abft_and_ati_start_time():
    """Next A-BFT ≠ 0 → A-BFT нет; ATI — не раньше Start Time Next DMG ATI (9.4.2.135)."""
    bic = B.BeaconIntervalControl(next_abft=1, ati_present=1)
    per = B.layout(2, BI_TU, B.BiConfig(bic, ati_duration=500), bti_end=2 * BI + 200)
    assert [(p.kind, p.start) for p in per] == [('BTI', 2 * BI), ('ATI', 2 * BI + 209)]
    per = B.layout(2, BI_TU, B.BiConfig(bic, ati_duration=500, ati_start=2 * BI + 1000), bti_end=2 * BI + 200)
    assert per[1].start == 2 * BI + 1000


def test_layout_without_bti_starts_with_ati():
    """11.1.3.3.1: BI без DMG Beacon AP начинает с ATI; 10.39.3: ATI не раньше TBTT."""
    bic = B.BeaconIntervalControl(ati_present=1)
    per = B.layout(1, BI_TU, B.BiConfig(bic, ati_duration=800), bti_end=None)
    assert [(p.kind, p.start, p.end) for p in per] == [('ATI', BI, BI + 800)]


def test_layout_cbap_only_guard():
    """10.39.6.3: CBAP Only — весь DTI один CBAP, перед ним guard time; до следующего TBTT."""
    c = B.BiConfig(B.BeaconIntervalControl(), B.DmgParameters(cbap_only=1))
    per = B.layout(0, BI_TU, c, bti_end=300)
    ab = 309 + 8 * sst(8)
    assert [p.kind for p in per] == ['BTI', 'A-BFT', 'CBAP']
    assert (per[2].start, per[2].end, per[2].cbap_only) == (ab + 16, BI, True)   # guard 16 — см. test_guard
    c = B.BiConfig(B.BeaconIntervalControl(), B.DmgParameters(cbap_only=1), cbap_only_guard=5)
    assert B.layout(0, BI_TU, c, bti_end=300)[2].start == ab + 5


def test_layout_pseudo_static_recurs():
    a = B.Allocation(B.SP, 1, 2, 40000, 1000, pseudo_static=1)
    per = B.layout(3, BI_TU, B.BiConfig(allocations=[a.recur(0, 3, BI)]), bti_end=3 * BI + 100)
    assert [(p.kind, p.start - 3 * BI) for p in per] == [('BTI', 0), ('A-BFT', 109), ('SP', 40000)]


# ---------------- check_schedule ----------------
def sched_rules(cfg, k=0, end=300, **kw):
    return sorted(r for r, _ in B.check_schedule(k, BI_TU, cfg, bti_end=end, **kw))


def test_schedule_violations():
    sp = lambda s, d, i=1, **kw: B.Allocation(B.SP, 1, 2, s, d, alloc_id=i, **kw)
    # перекрытие
    assert sched_rules(B.BiConfig(allocations=[sp(20000, 1000), sp(20500, 1000, 2)])) == ['overlap']
    # guard: два непсевдостатичных, D = BI по умолчанию: (20·102400·2)/10⁶ + 3,1 = 7,196 → 8
    assert sched_rules(B.BiConfig(allocations=[sp(20000, 1000), sp(21008, 1000, 2)])) == []
    assert sched_rules(B.BiConfig(allocations=[sp(20000, 1000), sp(21007, 1000, 2)])) == ['guard']
    # в BHI (BTI 0..300 + A-BFT)
    assert sched_rules(B.BiConfig(allocations=[sp(1000, 100)])) == ['in_bhi']
    # через границу BI
    assert sched_rules(B.BiConfig(allocations=[sp(BI - 500, 1000)])) == ['cross_bi']
    # порядок полей и повтор
    assert sched_rules(B.BiConfig(allocations=[sp(30000, 100), sp(20000, 100, 2)])) == ['es_order']
    assert 'es_dup' in sched_rules(B.BiConfig(allocations=[sp(20000, 100), sp(20000, 100)]))
    assert sched_rules(B.BiConfig(allocations=[sp(20000, 100), sp(30000, 100)])) == ['es_dup']   # тот же кортеж
    # CBAP Only и Extended Schedule / ATI
    assert sched_rules(B.BiConfig(params=B.DmgParameters(cbap_only=1), has_es_in_beacon=True)) == ['cbap_only_es']
    assert sched_rules(B.BiConfig(B.BeaconIntervalControl(ati_present=1), B.DmgParameters(cbap_only=1),
                                  ati_duration=100)) == ['cbap_only_ati']
    assert sched_rules(B.BiConfig(params=B.DmgParameters(cbap_source=1))) == ['cbap_source']
    # aMinAllocationDeliveryTime: STA-участник, ES передан в 19 800 → начало ≥ 20 100
    assert sched_rules(B.BiConfig(allocations=[sp(20100, 100)], es_tx_tsf=19800)) == []
    assert sched_rules(B.BiConfig(allocations=[sp(20099, 100)], es_tx_tsf=19800)) == ['alloc_delivery']
    assert sched_rules(B.BiConfig(allocations=[sp(20099, 100, pseudo_static=1)], es_tx_tsf=19800)) == []
    # aMaxBIDuration
    assert 'bi_max' in [r for r, _ in B.check_schedule(0, 1001, B.BiConfig(), bti_end=300)]
    # единственный CBAP — только в строгом режиме (СПОРНО)
    one = B.BiConfig(allocations=[B.Allocation(B.CBAP, 255, 255, 20000, 1000, alloc_id=0)])
    assert sched_rules(one) == [] and sched_rules(one, strict_cbap_only=True) == ['cbap_only_single']


# ---------------- журнал эфира ----------------
def mk_bss(cfgs=None, **kw):
    return B.Bss(AP, AIDS, BI_TU, cfgs if cfgs is not None else {0: cfg_full()}, **kw)


def base_log():
    bss = mk_bss()
    _, _, btis = B.txss_plan([0, 1, 2, 3])
    log, per = B.generate_bi(0, bss, btis[0], TX_BEACON, abft_ssw=[(2, S1, 8), (5, S2, 4)],
                             ati=[(S1, 'Announce', 40, 'Ack', 14), (S2, 'Announce', 40, 'Ack', 14)])
    return bss, log, per


def rules(log, bss):
    return sorted(v.rule for v in B.check_air_log(log, bss))


def test_generated_bi_is_clean():
    bss, log, per = base_log()
    assert rules(log, bss) == []
    beacons = [e for e in log if e[4] == 'DMG Beacon']
    assert [e[6]['cdown'] for e in beacons] == [3, 2, 1, 0]
    # SSW слота 2: начало слота = A-BFT + 2·aSSSlotTime
    ssw = [e for e in log if e[4] == 'SSW' and e[2] == S1]
    abft0 = beacons[-1][1] + MBIFS
    assert ssw[0][0] == abft0 + 2 * sst(8) and len(ssw) == 8
    fb = [e for e in log if e[4] == 'SSW-Feedback' and e[3] == S1][0]
    assert fb[0] == abft0 + 3 * sst(8) - TX_FB - MBIFS


def data(ts, src, dst, kind='Data', dur=100):
    return (Fr(ts), Fr(ts) + dur, src, dst, kind, 0)


def test_dti_traffic_ok():
    bss, log, per = base_log()
    log += [data(20100, S1, S2), data(20200 + 3, S2, S1, 'Ack', 5),      # CBAP 1 (broadcast): любые
            data(50100, S1, S2), data(50203, S2, S1, 'BlockAck', 10),   # SP 1: 1 → 2
            data(60300, S2, S1), data(60403, S1, S2, 'Ack', 5)]         # SP 2: 2 → 1
    assert rules(log, bss) == []


def test_bti_violations():
    bss, log, _ = base_log()
    b1 = log[1]
    # STA в BTI (10.39.2)
    assert rules(log + [(b1[0] - 1, b1[0] - Fr(1, 2), S1, AP, 'SSW', 0)], bss) == ['bti_sta']
    # маяки: зазор 2 мкс вместо SBIFS (1 … 1,03)
    shifted = [log[0]] + [(e[0] + 1, e[1] + 1) + e[2:] for e in log[1:4]] + log[4:]
    r = rules(shifted, bss)
    assert 'beacon_gap' in r
    # сектор дважды; CDOWN не по порядку; Duration не остаток BTI
    dup = list(log)
    dup[2] = dup[2][:6] + (dict(sector=0, cdown=1),)
    assert rules(dup, bss) == ['beacon_sector_dup']
    cd = list(log)
    cd[2] = cd[2][:6] + (dict(sector=2, cdown=0),)
    assert rules(cd, bss) == ['beacon_cdown', 'beacon_cdown']
    bad = list(log)
    bad[0] = bad[0][:5] + (bad[0][5] + 1,) + bad[0][6:]
    assert rules(bad, bss) == ['beacon_dur']


def test_beacon_outside_bti_and_foreign_beacon():
    bss, log, _ = base_log()
    assert rules(log + [(30000, 30000 + TX_BEACON, AP, B.BCAST, 'DMG Beacon', 0)], bss) == ['beacon_outside_bti']
    assert rules(log + [(30000, 30000 + TX_BEACON, S1, B.BCAST, 'DMG Beacon', 0)], bss) == ['beacon_src']


def test_abft_violations():
    bss, log, per = base_log()
    abft = [p for p in per if p.kind == 'A-BFT'][0]
    s0 = abft.start                                   # слот 0
    # SSW-Ack и BRP в A-BFT запрещены (10.42.5.2)
    assert rules(log + [(s0, s0 + TX_FB, AP, S1, 'SSW-Ack')], bss) == ['abft_kind']
    assert rules(log + [(s0, s0 + 10, S3, AP, 'BRP')], bss) == ['abft_kind']
    # SSW не в начале слота
    assert rules(log + [(s0 + 5, s0 + 5 + TX_SSW, S3, AP, 'SSW')], bss) == ['abft_slot_start']
    # 9 SSW при FSS 8 — девятая выходит и за aSSDuration
    extra = [(s0 + i * (TX_SSW + 1), s0 + i * (TX_SSW + 1) + TX_SSW, S3, AP, 'SSW') for i in range(9)]
    assert rules(log + extra, bss) == ['abft_fss', 'abft_ss_end']
    # SSW через 2 мкс вместо SBIFS
    two = [(s0, s0 + TX_SSW, S3, AP, 'SSW'), (s0 + TX_SSW + 2, s0 + 2 * TX_SSW + 2, S3, AP, 'SSW')]
    assert rules(log + two, bss) == ['abft_sbifs']
    # SSW-Feedback не в положенный момент
    fb = B.ssw_fb_start(s0 + sst(8)) - 2
    assert rules(log + [(fb, fb + TX_FB, AP, S3, 'SSW-Feedback')], bss) == ['abft_fb_time']


def test_ati_violations():
    bss, log, per = base_log()
    ati = [p for p in per if p.kind == 'ATI'][0]
    t = ati.end - 300
    # инициатива STA в ATI
    assert rules(log + [(t, t + 20, S1, AP, 'Mgmt')], bss) == ['ati_sta']
    # ответ не AP
    req = (t, t + 20, AP, S1, 'Announce')
    assert rules(log + [req, (t + 23, t + 40, S1, S2, 'Ack')], bss) == ['ati_resp_dst']
    # Data в ATI (кроме RSNA) — нет; запрос AP Data — нет
    assert rules(log + [req, (t + 23, t + 40, S1, AP, 'Data')], bss) == ['ati_kind']
    assert rules(log + [(t, t + 20, AP, S1, 'Data')], bss) == ['ati_kind']
    assert rules(log + [req, (t + 23, t + 40, S1, AP, 'EAPOL')], bss) == []
    assert rules(log + [(t, t + 20, AP, S1, 'Action No Ack')], bss) == ['ati_kind', 'ati_noack']
    # ответ не через SIFS
    assert rules(log + [req, (t + 30, t + 40, S1, AP, 'Ack')], bss) == ['ati_sta']


def test_sp_violations():
    bss, log, _ = base_log()
    # 10.39.6.2: S3 — не участник SP 1
    assert rules(log + [data(50100, S3, S1)], bss) == ['sp_foreign']
    # ответ S3 на кадр S1, адресованный S3, — тоже чужой (S3 не назначение)
    assert rules(log + [data(50100, S1, S3), data(50203, S3, S1, 'Ack', 5)], bss) == ['sp_foreign']
    # обмен за концом SP (10.39.6.2: «shall not … extend … beyond the end of that SP»)
    assert rules(log + [data(60050, S1, S2)], bss) == ['period_end']
    # динамическое окно (Grant) разрешает
    bss2 = mk_bss(dynamic=[(50100, 50300, {S3})])
    assert rules(log + [data(50100, S3, S1)], bss2) == []


def test_sp_broadcast_and_pcp_active():
    allocs = [B.Allocation(B.SP, 255, 255, 20000, 5000, alloc_id=1, truncatable=1),
              B.Allocation(B.SP, 1, 255, 30000, 5000, alloc_id=2),
              B.Allocation(B.SP, 1, 2, 40000, 5000, alloc_id=3, pcp_active=0)]
    bss = mk_bss({0: B.BiConfig(allocations=allocs)})
    _, _, btis = B.txss_plan([0, 1])
    log, _ = B.generate_bi(0, bss, btis[0], TX_BEACON)
    # broadcast/broadcast: AP передаёт; STA — только ответом; без Poll/Grant — нельзя
    ok = [data(20000, AP, S1, 'Poll', 10), data(20013, S1, AP, 'SPR', 10)]
    assert rules(log + ok, bss) == []
    assert rules(log + [data(21000, S1, AP, 'SPR', 10)], bss) == ['sp_foreign']
    # источник 1, назначение broadcast: S2 отвечает источнику — да, начинает сам — нет (СПОРНО)
    assert rules(log + [data(30000, S1, S2), data(30103, S2, S1, 'Ack', 5)], bss) == []
    assert rules(log + [data(31000, S2, S1)], bss) == ['sp_foreign']
    # PCP Active = 0, PCP не участник: передача к PCP запрещена
    assert rules(log + [data(40000, S1, AP)], bss) == ['sp_pcp_inactive']


def test_cbap_membership():
    """10.39.5: инициатор — Source AID broadcast, свой AID = Source или Destination; ответ — всегда."""
    allocs = [B.Allocation(B.CBAP, 1, 255, 20000, 5000, alloc_id=1)]
    bss = mk_bss({0: B.BiConfig(allocations=allocs)})
    _, _, btis = B.txss_plan([0])
    log, _ = B.generate_bi(0, bss, btis[0], TX_BEACON)
    assert rules(log + [data(20100, S1, S2)], bss) == []
    assert rules(log + [data(20100, S2, S1)], bss) == ['cbap_member']
    assert rules(log + [data(20100, S1, S2), data(20203, S2, S1, 'Ack', 5)], bss) == []
    # CBAP Only: доступ всем
    bss = mk_bss({0: B.BiConfig(params=B.DmgParameters(cbap_only=1, cbap_source=1))})
    log, _ = B.generate_bi(0, bss, btis[0], TX_BEACON)
    assert rules(log + [data(20100, S2, S1)], bss) == []


def test_no_period_and_guard():
    bss, log, per = base_log()
    # нераспределённое время DTI (между CBAP 1 и SP 1) — передавать нельзя (10.39.4)
    assert rules(log + [data(50050, S1, S2, dur=10)], bss) == ['no_period']
    # CBAP Only: guard после BHI — тоже вне периода
    bss = mk_bss({0: B.BiConfig(params=B.DmgParameters(cbap_only=1))})
    _, _, btis = B.txss_plan([0])
    log, per = B.generate_bi(0, bss, btis[0], TX_BEACON)
    c = per[-1]
    assert rules(log + [data(c.start - 1, S1, S2, dur=0.5)], bss) == ['no_period']
    assert rules(log + [data(c.start, S1, S2, dur=0.5)], bss) == []


def test_bi_without_beacon():
    """BI без BTI: A-BFT нет — SSW там, где мог бы быть A-BFT, — вне периода (10.42.5.2: не передавать в A-BFT без
    маяка в BTI); ATI с TBTT."""
    c = B.BiConfig(B.BeaconIntervalControl(ati_present=1), ati_duration=1000)
    bss = mk_bss({1: c})
    t = BI + 1100
    assert rules([(t, t + TX_SSW, S1, AP, 'SSW')], bss) == ['no_period']
    assert rules([(BI, BI + 20, AP, S1, 'Announce'), (BI + 23, BI + 30, S1, AP, 'Ack')], bss) == []


def test_sector_coverage():
    """11.1.2.1: каждый сектор — хотя бы раз за dot11MaxLostBeacons × dot11BeaconPeriod (фрагментированный TXSS)."""
    span, frag, btis = B.txss_plan(list(range(8)), per_bti=2)
    assert (span, frag) == (4, 1)
    cfg = B.BiConfig(B.BeaconIntervalControl(fragmented_txss=1, txss_span=4))
    bss = mk_bss({k: cfg for k in range(8)}, sectors=range(8))
    log = []
    for k in range(8):
        log += B.generate_bi(k, bss, btis[k % 4], TX_BEACON)[0]
    assert rules(log, bss) == []
    # пропуск BTI 5 → секторы 2,3 не покрыты в окнах BI 2..5, 3..6, 4..7
    drop = [e for e in log if B.bi_index(e[0], BI_TU) != 5]
    assert rules(drop, bss) == ['sector_coverage'] * 3
