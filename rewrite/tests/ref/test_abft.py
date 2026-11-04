# SPDX-License-Identifier: AGPL-3.0-or-later
"""Эталон A-BFT: ожидания — из текста 802.11-2020 (10.42.5.1–10.42.5.4, 10.42.2.3/10.42.2.4, рис. 9-77,
рис. 10-75/10-76, табл. 11-22, C.3 MIB, 20.11.3)."""
from fractions import Fraction as Fr

import pytest

from . import abft as A
from .cbap import SeqRng

Tc = Fr(1, 1760)                                            # табл. 20-4
# 20.11.3 control mode: T_STF-CM + T_CE-CM + (11·8 + (Length − 6)·8 + NCW·168)·Tc·32,
# T_STF-CM = 50·128·Tc, T_CE = 9·128·Tc, NCW = 1 + ⌈(Length − 6)·8 / 168⌉ (20.4.3.3.3)
T_SSW = (50 * 128 + 9 * 128 + 32 * (88 + 20 * 8 + 2 * 168)) * Tc      # SSW 26 октетов: NCW = 2
T_FB = (50 * 128 + 9 * 128 + 32 * (88 + 22 * 8 + 3 * 168)) * Tc       # SSW-Feedback 28 октетов: NCW = 3
MBIFS = 9                                                   # 10.3.2.3.10: 3×aSIFSTime
SBIFS = 1                                                   # табл. 20-30
PROP = Fr(1, 10)                                            # aAirPropagationTime 100 ns
AP, S1, S2, S3 = 'ap', 's1', 's2', 's3'


def rules(v):
    return sorted({x.rule for x in v})


# ---------------- постоянные ----------------
def test_constants_table_11_22_and_mib():
    assert (A.aSSFramesPerSlot, A.aMaxABFTAccessPeriod, A.aMinBTIPeriod) == (4, 2, 4)
    assert (A.DOT11_ABFT_RTXSS_SWITCH, A.DOT11_RSS_RETRY_LIMIT, A.DOT11_RSS_BACKOFF) == (4, 8, 8)
    assert A.MIB_RANGE == (1, 32)
    assert (A.LEN_SSW, A.LEN_SSW_FB) == (26, 28)            # рис. 9-54, 9-55


def test_txtimes():
    assert A.T_SSW == T_SSW == Fr(26240, 1760)
    assert A.T_SSW_FB == T_FB == Fr(32128, 1760)


@pytest.mark.parametrize('fss', [1, 4, 8, 16])
def test_ss_slot_time_formula(fss):
    """Табл. 11-22 + 10.42.5.2."""
    ssd = (fss - 1) * SBIFS + fss * T_SSW
    assert A.ss_duration(fss) == ssd
    assert A.ssfb_duration() == T_FB
    assert A.ss_slot_time(fss) == PROP + ssd + MBIFS + T_FB + MBIFS


def test_slot_time_fig_10_75_example():
    """Рис. 10-75: A-BFT Length 8, FSS 8 → A-BFT = 8·aSSSlotTime."""
    L = A.AbftLayout(1000, 8, 8)
    st = PROP + 7 + 8 * T_SSW + 9 + T_FB + 9
    assert L.slot_time == st
    assert L.end - L.start == 8 * st
    assert [L.slot_start(i) for i in range(3)] == [1000, 1000 + st, 1000 + 2 * st]


def test_abft_start_mbifs_after_bti():
    """10.42.5.1 / 10.3.2.3.10: A-BFT — MBIFS после конца BTI; STA — по Duration последнего маяка."""
    assert A.abft_start(500) == 509
    assert A.sta_bti_end(Fr(4901, 10), 0) == Fr(4901, 10)
    L = A.AbftLayout.from_bic(A.BeaconIntervalControl(abft_length=7, fss=7, is_responder_txss=1), 500)
    assert (L.start, L.n_slots, L.fss, L.is_txss) == (509, 8, 8, True)


def test_feedback_point_and_qomni():
    """10.42.5.2: SSW-Feedback — за aSSFBDuration + MBIFS до конца слота; квази-омни ответчика — aSSFBDuration,
    кончаясь за MBIFS до конца слота."""
    L = A.AbftLayout(0, 2, 4)
    e = L.slot_end(1)
    assert L.fb_start(1) == e - T_FB - MBIFS
    assert L.responder_qomni(1) == (e - MBIFS - T_FB, e - MBIFS)
    # и то же — через составные части: начало слота + aAirPropagationTime + aSSDuration + MBIFS
    assert L.fb_start(0) == PROP + 3 * SBIFS + 4 * T_SSW + MBIFS


# ---------------- Beacon Interval Control ----------------
def test_bic_bit_positions_fig_9_77():
    B = A.BeaconIntervalControl
    assert B(abft_length=7, txss_span=0, n_bis_abft=0).encode() == 7 << 7          # B7–B9
    assert B(fss=15, txss_span=0, n_bis_abft=0).encode() == 0xF << 10              # B10–B13
    assert B(is_responder_txss=1, txss_span=0, n_bis_abft=0).encode() == 1 << 14
    assert B(next_abft=15, txss_span=0, n_bis_abft=0).encode() == 0xF << 15        # B15–B18
    assert B(txss_span=127, n_bis_abft=0).encode() == 0x7F << 20                    # B20–B26
    assert B(txss_span=0, n_bis_abft=15).encode() == 0xF << 27                      # B27–B30
    assert B(abft_count=63, txss_span=0, n_bis_abft=0).encode() == 0x3F << 31       # B31–B36
    assert B(n_abft_in_ant=63, txss_span=0, n_bis_abft=0).encode() == 0x3F << 37    # B37–B42
    assert B(pcp_assoc_ready=1, txss_span=0, n_bis_abft=0).encode() == 1 << 43
    assert B(cc_present=1, discovery_mode=1, txss_span=0, n_bis_abft=0).encode() == 3
    assert len(B().to_bytes()) == 6


def test_bic_counts_minus_one():
    """9.3.4.2: A-BFT Length и FSS — число минус 1."""
    b = A.BeaconIntervalControl(abft_length=0, fss=0)
    assert (b.abft_slots, b.fss_frames) == (1, 1)
    b = A.BeaconIntervalControl(abft_length=7, fss=15)
    assert (b.abft_slots, b.fss_frames) == (8, 16)
    assert A.BeaconIntervalControl.decode(b.to_bytes()) == b
    with pytest.raises(AssertionError):
        A.BeaconIntervalControl(abft_length=8).encode()


# ---------------- расписание точки ----------------
def test_next_abft_every_k():
    """10.42.5.1: Next A-BFT −1 после каждого BTI; 10.42.5.4: A-BFT каждые k BI."""
    s = A.ApAbftSchedule(k=3)
    seq = [s.bi(b) for b in range(7)]
    assert [x[0].next_abft for x in seq] == [0, 2, 1, 0, 2, 1, 0]
    assert all(x[0].n_bis_abft == 3 for x in seq)
    assert A.check_bic_sequence(seq) == []


def test_discovery_next_abft_zero():
    """11.1.3.4: Discovery Mode → Next A-BFT = 0."""
    s = A.ApAbftSchedule(k=4, discovery=True)
    assert [s.bi(b)[0].next_abft for b in range(4)] == [0, 0, 0, 0]


def test_rtxss_switch_forced():
    """10.42.5.2: TXSS не реже раза за dot11ABFTRTXSSSwitch (4) A-BFT, даже если точка хочет только RXSS."""
    s = A.ApAbftSchedule(want_rxss=lambda j: True, rxss_fss=12)
    seq = [s.bi(b) for b in range(9)]
    assert [x[0].is_responder_txss for x in seq] == [0, 0, 0, 1, 0, 0, 0, 1, 0]
    assert seq[0][0].fss_frames == 12 and seq[3][0].fss_frames == 4
    assert A.check_bic_sequence(seq) == []


def test_multi_antenna_rotation():
    """10.42.5.4 / 9.3.4.2: 2 антенны, N A-BFT in Ant = 2 → антенны 0,0,1,1,0; A-BFT Count 0,1,0,1,0."""
    s = A.ApAbftSchedule(n_rx_ant=2, n_abft_in_ant=2)
    seq = [s.bi(b) for b in range(5)]
    assert [x[1] for x in seq] == [0, 0, 1, 1, 0]
    assert [x[0].abft_count for x in seq] == [0, 1, 0, 1, 0]
    assert A.check_bic_sequence(seq, n_rx_ant=2) == []


def test_check_bic_violations():
    B = A.BeaconIntervalControl
    ok = lambda **k: (B(**{'fss': 3, 'is_responder_txss': 1, **k}), None)
    assert rules(A.check_bic_sequence([ok(next_abft=2, n_bis_abft=3), ok(next_abft=0, n_bis_abft=3)])) == ['next_abft']
    assert rules(A.check_bic_sequence([ok(fss=2)])) == ['fss_min']          # 3 кадра < aSSFramesPerSlot
    assert A.check_bic_sequence([ok(fss=3)]) == []                           # 4 кадра — минимум
    rx = [ok(is_responder_txss=0) for _ in range(4)]
    assert rules(A.check_bic_sequence(rx)) == ['rtxss']
    assert A.check_bic_sequence(rx[:3]) == []
    assert rules(A.check_bic_sequence([ok(n_bis_abft=2), ok(n_bis_abft=2)])) == ['n_bis']
    assert rules(A.check_bic_sequence([([B(fss=3), B(fss=4)], None)])) == ['bti_same']
    # антенны: смена без A-BFT Count = 0 и A-BFT Count = 0 без смены
    a = lambda c, ant: (B(fss=3, abft_count=c, n_abft_in_ant=2), ant)
    assert rules(A.check_bic_sequence([a(0, 0), a(1, 1)], n_rx_ant=2)) == ['abft_count']
    assert rules(A.check_bic_sequence([a(0, 0), a(0, 0)], n_rx_ant=2)) == ['abft_count']
    assert rules(A.check_bic_sequence([a(0, 0), a(0, 1)], n_rx_ant=2)) == ['abft_count']   # раньше l = 2


# ---------------- допуск в A-BFT ----------------
def test_may_access_rules():
    """10.42.5.2 + табл. 9-69."""
    B, R = A.BeaconIntervalControl, A.BeaconRx
    S1, S2 = '02:00:00:00:00:01', '02:00:00:00:00:02'
    assert not A.may_access(R(B(), AP, received=False), S1)
    assert not A.may_access(None, S1)
    assert A.may_access(R(B(), AP), S1)
    assert A.may_access(R(B(discovery_mode=1, cc_present=0), AP), S1)
    d = B(discovery_mode=1, cc_present=1)
    assert A.may_access(R(d, AP, abft_responder=S1), S1)
    assert not A.may_access(R(d, AP, abft_responder=S2), S1)
    g = '03:00:00:00:00:01'
    assert A.is_group(g) and not A.is_group('02:00:00:00:00:01')
    assert A.may_access(R(d, AP, abft_responder=g, bss_type=1), S1, groups=(g,), role='non-AP STA')
    assert not A.may_access(R(d, AP, abft_responder=g, bss_type=3), S1, groups=(g,), role='non-AP STA')
    assert A.may_access(R(d, AP, abft_responder=g, bss_type=0), S1, groups=(g,), role='PCP')     # «Any»
    assert not A.may_access(R(d, AP, abft_responder=g, bss_type=0), S1, groups=())


# ---------------- ответчик и точка ----------------
def beacon(slots=8, fss=8, txss=1, **kw):
    bic = A.BeaconIntervalControl(abft_length=slots - 1, fss=fss - 1, is_responder_txss=txss,
                                  **{k: v for k, v in kw.items() if k in ('discovery_mode', 'cc_present')})
    rest = {k: v for k, v in kw.items() if k not in ('discovery_mode', 'cc_present')}
    return A.BeaconRx(bic, AP, best=(5, 0, 40), **rest)


def run(stas, bcn, layout=None, **apkw):
    layout = layout or A.AbftLayout(0, bcn.bic.abft_slots, bcn.bic.fss_frames, bool(bcn.bic.is_responder_txss))
    ap = A.ApAbft(AP, layout, **apkw)
    log = A.simulate_abft(ap, stas, {s.addr: bcn for s in stas})
    return ap, layout, log


def test_fig_10_75_contention():
    """Рис. 10-75: 8 слотов, STA A — 2, B и C — 5 → A в слоте 2 с ответом, B и C сталкиваются в слоте 5."""
    sa = A.Responder('A', plan=[(0, i) for i in range(8)], rng=SeqRng([2]))
    sb = A.Responder('B', plan=[(0, i) for i in range(8)], rng=SeqRng([5, 0, 0]))
    sc = A.Responder('C', plan=[(0, i) for i in range(8)], rng=SeqRng([5, 0, 0]))
    ap, L, log = run([sa, sb, sc], beacon())
    slot = {f.src: {L.slot_of(g.t) for g in log if g.src == f.src} for f in log if f.kind == 'SSW'}
    assert slot['A'] == {2}
    assert slot['B'] >= {5} and slot['C'] >= {5}
    fbs = [f for f in log if f.kind == 'SSW-Feedback']
    assert [(L.slot_of(f.t), f.dst) for f in fbs][0] == (2, 'A')
    assert all(f.dst != 'B' or L.slot_of(f.t) != 5 for f in fbs)
    assert sa.fb is not None and sa.failed == 0
    # B и C: RSS без ответа → перезапуск с backoff 0 в слотах 6 и 7 (снова столкновение) → FailedRSSAttempts = 3
    assert slot['B'] == {5, 6, 7}
    assert (sb.failed, sc.failed) == (3, 3)
    assert sb.rng.cws == [7, 7, 7]                           # [0, A-BFT Length) = 0..7
    assert A.check_abft_log(log, L, AP) == []


def test_ssw_frames_in_slot():
    """FSS 4, 10 секторов: RSS занимает 3 слота подряд (4 + 4 + 2), CDOWN 9..0, через SBIFS, Duration до конца слота."""
    st = A.Responder(S1, plan=[(0, i) for i in range(10)], rng=SeqRng([1]))
    ap, L, log = run([st], beacon(slots=8, fss=4), fb_incomplete=False)
    ssw = [f for f in log if f.kind == 'SSW']
    assert [f.cdown for f in ssw] == list(range(9, -1, -1))
    assert [L.slot_of(f.t) for f in ssw] == [1] * 4 + [2] * 4 + [3] * 2
    assert ssw[0].t == L.slot_start(1) and ssw[1].t == L.slot_start(1) + T_SSW + SBIFS
    assert all(f.direction == 1 and f.dst == AP and f.mcs == 0 for f in ssw)
    assert ssw[0].duration == -(-(L.slot_end(1) - ssw[0].t - T_SSW) // 1)        # ⌈остаток слота⌉ (9.3.1.15)
    fb = [f for f in log if f.kind == 'SSW-Feedback']
    assert len(fb) == 1 and L.slot_of(fb[0].t) == 3 and fb[0].duration == 0
    assert fb[0].t == L.slot_end(3) - T_FB - MBIFS
    assert A.check_abft_log(log, L, AP) == []


def test_feedback_fields_txss_and_obligations():
    """10.42.2.4: Sector Select/DMG Antenna Select — лучший кадр, передача через Sector Select ответчика;
    10.42.5.2: Poll Required + TDDTI → выделение и BRP Capability Request за aMinBTIPeriod BI."""
    st = A.Responder(S1, plan=[(0, 0), (0, 1), (0, 2), (0, 3)], rng=SeqRng([0]), poll_required=1)
    L = A.AbftLayout(0, 4, 4)
    ap = A.ApAbft(AP, L, bi=10, tddti=1)
    st.begin_abft(beacon(4, 4), L)
    frs = st.slot_tx(0)
    for f, snr in zip(frs, (1, 9, 3, 2)):
        f.rx_snr = snr
    fb = ap.slot_feedback(0, frs)
    assert (fb.sector_select, fb.ant_select, fb.snr) == (1, 0, 9)
    assert fb.tx_sector == (0, 5)                          # Sector Select ответчика (лучший сектор ISS)
    ob = {o.kind: o for o in ap.obligations}
    assert set(ob) == {'poll_alloc', 'brp_cap'}
    assert (ob['brp_cap'].first, ob['brp_cap'].last) == (10, 13)
    assert A.check_obligations(ap.obligations, [(12, 'Grant', S1, 0, (0, 5)), (13, 'BRP-cap', S1, 0, (0, 5))]) == []
    assert rules(A.check_obligations(ap.obligations, [(14, 'BRP-cap', S1, 0, (0, 5))])) == ['brp_cap', 'poll_alloc']
    assert rules(A.check_obligations(ap.obligations, [(11, 'Poll', S1, 0, None), (11, 'BRP-cap', S1, 4, (0, 2))])) \
        == ['mcs0', 'sector']


def test_rxss_exact_fss_frames():
    """10.42.5.2: RXSS — ровно FSS кадров, один сектор, CDOWN FSS−1…0; поля Select в SSW-Feedback reserved."""
    st = A.Responder(S1, plan=[(0, 3), (0, 4)], rng=SeqRng([0]), rxss_sector=(0, 4))
    ap, L, log = run([st], beacon(slots=2, fss=6, txss=0))
    ssw = [f for f in log if f.kind == 'SSW']
    assert len(ssw) == 6 and {f.sector_id for f in ssw} == {4}
    assert [f.cdown for f in ssw] == [5, 4, 3, 2, 1, 0]
    fb = [f for f in log if f.kind == 'SSW-Feedback'][0]
    assert fb.sector_select is None and fb.ant_select is None
    assert A.check_abft_log(log, L, AP) == []


def test_resume_next_abft_same_type():
    """10.42.5.2: не успел до конца A-BFT → продолжение в следующей A-BFT того же IsResponderTXSS, по backoff."""
    st = A.Responder(S1, plan=[(0, i) for i in range(6)], rng=SeqRng([1, 0, 0]))
    b = beacon(slots=2, fss=4)
    run([st], b, fb_incomplete=False)
    assert st.pending[True] == [(0, 4), (0, 5)] and st.failed == 0
    # A-BFT RXSS — новый RSS своего типа, TXSS ждёт
    run([st], beacon(slots=2, fss=4, txss=0), fb_incomplete=False)
    assert True in st.pending
    ap, L, log = run([st], b)
    ssw = [f for f in log if f.kind == 'SSW']
    assert [f.cdown for f in ssw] == [1, 0] and [f.sector_id for f in ssw] == [4, 5]
    assert st.fb is not None and True not in st.pending


def test_failed_rss_attempts_and_backoff():
    """10.42.5.2: FailedRSSAttempts > dot11RSSRetryLimit → backoff [0, dot11RSSBackoff) по A-BFT; сброс на SSW-Feedback."""
    draws = [0] * 3 + [2, 0]       # 3 попытки (лимит 2) → backoff 2; затем backoff слота 0
    st = A.Responder(S1, plan=[(0, 0)], rng=SeqRng(draws), retry_limit=2, rss_backoff=8)
    b = beacon(slots=1, fss=4)
    for _ in range(3):
        L = A.AbftLayout(0, 1, 4)
        st.begin_abft(b, L) and (st.slot_tx(0), st.slot_end(0, None))
        st.end_abft()
    assert st.failed == 3 and st.bi_backoff == 2
    assert st.rng.cws[-1] == 7                             # 0..dot11RSSBackoff − 1
    # две A-BFT пропускает (счёт уменьшается в конце каждой), третья — доступна
    for expect in (False, False, True):
        part = st.begin_abft(b, A.AbftLayout(0, 1, 4))
        assert part == expect
        st.end_abft()
    # приём SSW-Feedback обнуляет счётчик
    st.rng = SeqRng([0])
    ap, L, log = run([st], b)
    assert st.failed == 0 and st.fb is not None


def test_failed_counts_each_initiation_within_abft():
    """10.42.5.2: «consecutive number of times the STA initiates RSS» — перезапуск в той же A-BFT — тоже попытка."""
    st = A.Responder(S1, plan=[(0, 0)], rng=SeqRng([0, 0, 0, 0]))
    L = A.AbftLayout(0, 4, 4)
    st.begin_abft(beacon(4, 4), L)
    for s in range(4):
        assert len(st.slot_tx(s)) == 1
        st.slot_end(s, None)
    st.end_abft()
    assert st.failed == 4 and st.initiations == 4


def test_restart_backoff_and_cancel():
    """10.42.5.2: перезапуск — backoff со следующего слота; незавершённый backoff отменяется в конце A-BFT."""
    st = A.Responder(S1, plan=[(0, 0)], rng=SeqRng([0, 2]))
    L = A.AbftLayout(0, 3, 4)
    st.begin_abft(beacon(3, 4), L)
    assert st.slot_tx(0)
    st.slot_end(0, None)
    assert st.state == 'backoff' and st.count == 2
    for s in (1, 2):
        assert st.slot_tx(s) == []
        st.slot_end(s, None)
    st.end_abft()
    assert st.state == 'idle' and st.pending == {}


def test_no_beacon_no_transmit():
    """10.42.5.2: без DMG Beacon в BTI — в A-BFT не передавать."""
    st = A.Responder(S1, rng=SeqRng([]))
    b = beacon()
    b.received = False
    ap, L, log = run([st], b)
    assert log == []


def test_discovery_access_period():
    """10.42.5.2: после SSW-Feedback в A-BFT с Discovery Mode 1 — не обращаться aMaxABFTAccessPeriod (2) A-BFT,
    если маяк не адресует STA (CC Present 1, A-BFT Responder Address)."""
    st = A.Responder(S1, rng=SeqRng([0, 0]))
    b = beacon(slots=1, fss=4, discovery_mode=1, cc_present=0)
    run([st], b)
    assert st.fb is not None and st.block == 2
    assert [st.begin_abft(b, A.AbftLayout(0, 1, 4)) or st.end_abft() for _ in range(2)] == [None, None]
    assert st.block == 0
    st.block = 2
    ba = beacon(slots=1, fss=4, discovery_mode=1, cc_present=1, abft_responder=S1)
    assert st.begin_abft(ba, A.AbftLayout(0, 1, 4)) is True


def test_multi_antenna_responder_lbifs():
    """10.42.2.3.2 / 10.3.2.3.11: смена DMG-антенны ответчика — LBIFS; антенны по возрастанию ID."""
    st = A.Responder(S1, plan=[(0, 0), (0, 1), (1, 0), (1, 1)], rng=SeqRng([0]))
    ap, L, log = run([st], beacon(slots=2, fss=8))
    ssw = [f for f in log if f.kind == 'SSW']
    assert [f.ant_id for f in ssw] == [0, 0, 1, 1]
    assert ssw[2].t - (ssw[1].t + T_SSW) == T_SSW + 2 * SBIFS                    # LBIFS
    assert [f.cdown for f in ssw] == [4, 3, 1, 0]                                 # СПОРНО: LBIFS — одна передача
    assert A.check_abft_log(log, L, AP) == []


# ---------------- проверка журнала ----------------
def good_log(fss=4, n=4, txss=True):
    st = A.Responder(S1, plan=[(0, i) for i in range(n)], rng=SeqRng([0]))
    b = beacon(slots=2, fss=fss, txss=int(txss))
    return run([st], b)


@pytest.mark.parametrize('mut,rule', [
    (lambda log, L: log[0].__setattr__('direction', 0), 'direction'),
    (lambda log, L: log[0].__setattr__('duration', log[0].duration + 1), 'ssw_dur'),
    (lambda log, L: log[1].__setattr__('cdown', 0), 'cdown'),
    (lambda log, L: log[0].__setattr__('t', log[0].t + 1), 'ssw_start'),
    (lambda log, L: log[1].__setattr__('t', log[1].t + Fr(1, 10)), 'gap'),
    (lambda log, L: log[-1].__setattr__('t', log[-1].t - 1), 'fb_time'),
    (lambda log, L: log[-1].__setattr__('duration', 5), 'fb_dur'),
    (lambda log, L: log[-1].__setattr__('dst', S2), 'fb_dst'),
    (lambda log, L: log[-1].__setattr__('src', S2), 'fb_src'),
    (lambda log, L: log[-1].__setattr__('sector_select', 9), 'fb_select'),
    (lambda log, L: log[-1].__setattr__('tx_sector', (0, 1)), 'fb_sector'),
    (lambda log, L: log[0].__setattr__('mcs', 1), 'mcs'),
    (lambda log, L: log[0].__setattr__('dst', S2), 'ssw_addr'),
    (lambda log, L: log.append(A.AirFrame('SSW-Ack', log[-1].t + 20, S1, AP)), 'kind'),
    (lambda log, L: log.append(A.AirFrame('BRP', log[-1].t + 20, AP, S1)), 'kind'),
    (lambda log, L: log.append(A.AirFrame('SSW-Feedback', L.fb_start(0), AP, S1, duration=0)), 'fb_multi'),
    (lambda log, L: log.append(A.AirFrame('SSW', L.end + 1, S1, AP, direction=1, cdown=0)), 'window'),
])
def test_checker_rules(mut, rule):
    ap, L, log = good_log()
    assert A.check_abft_log(log, L, AP) == []
    mut(log, L)
    assert rule in rules(A.check_abft_log(log, L, AP))


def test_checker_fss_and_late():
    ap, L, log = good_log(fss=4)
    extra = A.AirFrame('SSW', log[3].end + SBIFS, S1, AP, direction=1, cdown=None, sector_id=4, ant_id=0)
    log.insert(4, extra)
    assert {'fss', 'ssw_late'} <= set(rules(A.check_abft_log(log, L, AP)))


def test_checker_rxss_count_and_sector():
    ap, L, log = good_log(fss=4, txss=False)
    assert A.check_abft_log(log, L, AP) == []
    log[1].sector_id = 7
    assert rules(A.check_abft_log(log, L, AP)) == ['rxss_sector']
    ap, L, log = good_log(fss=4, txss=False)
    del log[3]
    assert 'fss' in rules(A.check_abft_log(log, L, AP))


def test_checker_resume_not_next_slot():
    """10.42.5.2: незавершённый RSS — продолжение только в следующем слоте."""
    st = A.Responder(S1, plan=[(0, i) for i in range(6)], rng=SeqRng([0]))
    ap, L, log = run([st], beacon(slots=3, fss=4), fb_incomplete=False)
    assert A.check_abft_log(log, L, AP) == []
    for f in log:
        if L.slot_of(f.t) == 1:
            f.t += L.slot_time
    assert 'resume' in rules(A.check_abft_log(log, L, AP))


def test_checker_tolerances():
    """10.3.2.3.8: SBIFS до aSBIFSTime + aSBIFSAccuracy; SSW — до aAirPropagationTime после начала слота."""
    ap, L, log = good_log()
    for f in log[1:4]:
        f.t += Fr(3, 100)
    assert 'gap' not in rules(A.check_abft_log(log, L, AP))
    ap, L, log = good_log()
    for f in log[:4]:
        f.t += PROP
        f.duration = None
    assert A.check_abft_log(log, L, AP) == []


def test_sta_may_retry():
    """10.42.5.2: повтор BF в A-BFT — если нет Announce/Grant aMinBTIPeriod BI после попытки."""
    assert not A.sta_may_retry(13, 10, False)
    assert A.sta_may_retry(14, 10, False)
    assert not A.sta_may_retry(20, 10, True)
