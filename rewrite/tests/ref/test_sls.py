# SPDX-License-Identifier: AGPL-3.0-or-later
"""Эталон SLS (10.42.2, 10.42.4, 10.42.6.2): числа — из формул и таблиц 802.11-2020 (TXTIME — ручной расчёт по
20.11.3), сценарии — рисунки 10-68, 10-69, 10-70, 10-71, автоматы рис. 10-91/10-92, нарушения, которые
check_sls_log обязана находить."""
import copy
from fractions import Fraction as Fr
from math import ceil

import pytest

from . import sls as S


def ctrl_tx(length):
    """Ручной TXTIME control mode (20.11.3, табл. 20-4): (50 + 9)·128·Tc + (88 + (L − 6)·8 + NCW·168)·32·Tc,
    NCW = 1 + ⌈(L − 6)·8 / 168⌉ (20.4.3.3.3), Tc = 1/1760 мкс."""
    ncw = 1 + ceil(Fr((length - 6) * 8, 168))
    return Fr(59 * 128 + (88 + (length - 6) * 8 + ncw * 168) * 32, 1760)


T_SSW = ctrl_tx(26)             # рис. 9-54: 26 октетов → NCW 2 → 26240/1760 мкс
T_FB = ctrl_tx(28)              # рис. 9-55/9-56: 28 октетов → NCW 3
SB, MB = Fr(1), Fr(9)           # табл. 20-30 aSBIFSTime; 10.3.2.3.10 MBIFS = 3·aSIFSTime
LB = T_SSW + 2 * SB             # 10.3.2.3.11
PIFS = Fr(3 + 5)                # (10-5): aSIFSTime + aSlotTime


def run(ini, rsp, channel=None, drop=None, until=10 ** 7):
    ch = channel or (lambda ta, a, s, ra, rxa, rxs: 20)
    return S.SlsLink(ini, rsp, ch, drop).run(until)


def kinds(log):
    return [(f.kind, f.ta) for f in log]


# ---------------------------------------------------------------------------------------------- постоянные и поля
def test_constants_from_standard():
    assert T_SSW == Fr(26240, 1760) and S.T_SSW == T_SSW
    assert S.T_SSW_FB == T_FB == S.T_SSW_ACK
    assert S.LBIFS == LB
    assert S.SBIFS_MAX == Fr(103, 100)                  # 10.3.2.3.8: aSBIFSTime + aSBIFSAccuracy (0,03)
    assert S.LBIFS_TOL == Fr(49, 100)                   # 10 %·(5 − 0,1)
    assert S.PIFS == PIFS


def test_mib_defaults():
    """Annex C dot11DMGBeamformingConfigEntry DEFVAL."""
    assert (S.DOT11_MAX_BF_TIME, S.dot11BFTXSSTime, S.dot11MaximalSectorScan, S.dot11BFRetryLimit) == \
        (4, 100_000, 8, 8)


def test_snr_report_encoding():
    """9.5.3: 4×(SNR − 19), 8-бит доп. код, −13 … 50,75 дБ."""
    assert S.snr_report(19) == 0
    assert S.snr_report(20) == 4
    assert S.snr_report(-13) == 0x80
    assert S.snr_report(Fr(5075, 100)) == 0x7F
    assert S.snr_report(18) == 0xFC                     # −4
    assert S.snr_report(-40) == 0x80 and S.snr_report(80) == 0x7F   # насыщение
    assert S.snr_from_report(0x80) == -13 and S.snr_from_report(0x7F) == Fr(203, 4)


def test_rxss_length_encoding():
    """9.5.1 / 9.5.5: (RXSS Length + 1) × 2, 2 … 128."""
    assert S.rxss_length(0) == 2 and S.rxss_length(63) == 128 and S.rxss_length(15) == 32
    assert S.rxss_length_field(32) == 15
    with pytest.raises(ValueError):
        S.rxss_length_field(33)


def test_total_sectors_in_iss_example():
    """10.42.2.2.1: 4 сектора на антенне 0, 3 — на 1, 5 — на 2, у ответчика 2 приёмные антенны → 24."""
    assert S.total_sectors_in_iss({0: range(4), 1: range(3), 2: range(5)}, 2) == 24
    assert S.total_sectors_in_iss_field(24) == 23       # СПОРНО: 9.5.3 «0 to 511, representing 1 to 512»
    assert S.total_sectors_field(14) == 13              # 9.5.5 / DMG Capabilities: «… minus 1»


def test_antenna_limits():
    """10.42.1: ≤ 64 на антенну, ≤ 128 всего."""
    assert S.check_antennas({0: list(range(64))}) == []
    assert S.check_antennas({0: list(range(64)) + [0]})          # 65 (и повтор ID)
    assert S.check_antennas({0: list(range(43)), 1: list(range(43)), 2: list(range(43))})   # 129
    with pytest.raises(ValueError):
        S.Initiator('I', 'R', {0: list(range(30)) * 3})


def test_grant_start():
    """10.42.2.2.2: PIFS после Grant без Grant Ack; при Grant Ack Supported — SIFS после Grant Ack."""
    assert S.iss_start_after_grant(100, False) == 108
    assert S.iss_start_after_grant(100, True, 130) == 133


# ---------------------------------------------------------------------------------------------- раскладка, CDOWN
def test_single_antenna_txss_timing():
    """Рис. 10-70: CDOWN N−1 … 0 через SBIFS; 9.3.1.15: Duration = до конца CDOWN=0 + MBIFS."""
    fr = S.plan_sweep(S.sweep_slots({0: [14, 10, 25, 3]}), 0, 'I', 'R', 0)
    assert [f.cdown for f in fr] == [3, 2, 1, 0]
    assert [f.sector_id for f in fr] == [14, 10, 25, 3]
    assert [f.t for f in fr] == [k * (T_SSW + SB) for k in range(4)]
    assert fr[0].dur == ceil(3 * (T_SSW + SB) + MB) and fr[-1].dur == 9


def test_multi_antenna_iss_lbifs_and_cdown_grid():
    """10.42.2.2.2 / 10.42.6.2: две антенны инициатора (2 и 3 сектора), у ответчика 2 приёмные антенны → ISS × 2;
    между антеннами и повторами — LBIFS; CDOWN «including any LBIFS» — LBIFS считается передачей.
    LBIFS = TXTIME(SSW) + 2·SBIFS ⇒ кадр с CDOWN=k начинается в t0 + (N − 1 − k)·(TXTIME(SSW) + SBIFS)."""
    slots = S.sweep_slots({1: [0, 1, 2], 0: [0, 1]}, 2)
    fr = S.plan_sweep(slots, 0, 'I', 'R', 0, fb={'total': S.total_sectors_in_iss({0: [0, 1], 1: [0, 1, 2]}, 2),
                                                 'n_rx_ant': 0})
    assert [f.cdown for f in fr] == [12, 11, 9, 8, 7, 5, 4, 2, 1, 0]
    assert [f.antenna_id for f in fr] == [0, 0, 1, 1, 1, 0, 0, 1, 1, 1]
    for f in fr:
        assert f.t == (12 - f.cdown) * (T_SSW + SB)
    gaps = [b.t - a.end for a, b in zip(fr, fr[1:])]
    assert gaps == [SB, LB, SB, SB, LB, SB, LB, SB, SB]
    assert S.check_sls_log(fr, {'responder_rx_antennas': 2}) == []


def test_lbifs_cdown_reading_alternative():
    """СПОРНО 10.42.2.3.2: «initial value of CDOWN … total number of sectors … multiplied by the number of DMG
    antennas at the initiator minus one»: 3 сектора × 2 антенны − 1 = 5 — так при CDOWN без LBIFS; по правилу
    «including any LBIFS» (основное) — 6."""
    slots = S.sweep_slots({0: [0, 1, 2]}, 2)
    assert S.slots_cdown(slots)[0] == 6
    assert S.slots_cdown(slots, lbifs_in_cdown=False)[0] == 3 * 2 - 1


def test_responder_antenna_order_and_repetitions():
    """10.42.2.3.2: антенны по возрастанию ID; повтор RSS под каждую приёмную антенну инициатора."""
    ini = S.Initiator('I', 'R', {0: [0, 1]}, rx_antennas=2)
    rsp = S.Responder('R', 'I', {2: [7, 8], 0: [3]})
    ini.start(0)
    log = run(ini, rsp)
    rss = [f for f in log if f.kind == S.SSW and f.ta == 'R']
    assert [(f.antenna_id, f.sector_id) for f in rss] == [(0, 3), (2, 7), (2, 8), (0, 3), (2, 7), (2, 8)]
    # слоты: 3, LBIFS, 7, 8, LBIFS (смена антенны инициатора), 3, LBIFS, 7, 8 → CDOWN кадров 8, 6, 5, 3, 1, 0
    assert [f.cdown for f in rss] == [8, 6, 5, 3, 1, 0]
    assert all(f.fb['n_rx_ant'] == 1 for f in log if f.kind == S.SSW and f.ta == 'I')
    assert S.check_sls_log(log) == []
    assert ini.state == 'COMPLETE'


# ---------------------------------------------------------------------------------------------- полный SLS в SP
def test_sp_txss_txss_timing_and_fields():
    """10.42.6.2: RSS — MBIFS после ISS; SSW-Feedback — MBIFS после RSS; SSW-Ack — MBIFS после Feedback.
    10.42.2.3.2: Sector Select RSS = лучший кадр ISS; 10.42.2.4: Feedback — через этот сектор, Select = лучший RSS;
    10.42.2.5: Ack — через Select из Feedback."""
    # канал: лучший сектор инициатора — 2, ответчика — 6
    ch = lambda ta, a, s, ra, rxa, rxs: {('I', 2): 30, ('R', 6): 25}.get((ta, s), 10)
    ini = S.Initiator('I', 'R', {0: [0, 1, 2, 3]})
    rsp = S.Responder('R', 'I', {0: [5, 6, 7]})
    ini.start(0)
    log = run(ini, rsp, ch)
    assert kinds(log) == [(S.SSW, 'I')] * 4 + [(S.SSW, 'R')] * 3 + [(S.SSW_FB, 'I'), (S.SSW_ACK, 'R')]
    iss_end = 4 * T_SSW + 3 * SB
    rss_t0 = iss_end + MB
    assert log[4].t == rss_t0
    rss_end = rss_t0 + 3 * T_SSW + 2 * SB
    assert log[7].t == rss_end + MB
    assert log[8].t == rss_end + MB + T_FB + MB
    assert all(f.fb == {'sector': 2, 'antenna': 0, 'snr': S.snr_report(30), 'poll': 0} for f in log[4:7])
    assert log[7].fb['sector'] == 6 and log[7].fb['snr'] == S.snr_report(25) and log[7].tx == (0, 2)
    assert log[8].tx == (0, 6)
    # 9.3.1.16 b) / 9.3.1.17
    assert log[7].dur == ceil(T_FB + MB)
    assert log[8].dur == ceil(Fr(log[7].dur) - MB - T_FB)
    assert ini.result == {'tx': (0, 2), 'peer_tx': (0, 6), 'rx': None}
    assert S.check_sls_log(log, {'iss_snr': {k: (30 if k == 2 else 10) for k in range(4)},
                                 'rss_snr': {0: 10, 1: 25, 2: 10}}) == []


def test_figure_10_68_responder_rxss():
    """Рис. 10-68: ISS — 32 сектора (CDOWN 31 … 0, Sector Id 14, 10, 25, …, 3), RSS — receive sweep: все кадры
    Sector Id=1, Best Sector=25, CDOWN 31 … 0; затем SSW-Feedback и SSW-Ack."""
    sectors = [14, 10, 25] + [s for s in range(4, 64) if s not in (14, 10, 25, 3)][:28] + [3]
    assert len(sectors) == 32
    rx_sweep = [(0, k) for k in range(32)]
    # лучший сектор инициатора — 25; лучший приёмный сектор инициатора — 7
    ch = lambda ta, a, s, ra, rxa, rxs: (40 if s == 25 else 10) if ta == 'I' else (30 if rxs == 7 else 12)
    ini = S.Initiator('I', 'R', {0: sectors}, rss=S.RXSS, rx_sweep=rx_sweep)
    rsp = S.Responder('R', 'I', {0: [1]}, rss=S.RXSS, peer_rxss_len=32)
    ini.start(0)
    log = run(ini, rsp, ch)
    iss = [f for f in log if f.kind == S.SSW and f.ta == 'I']
    rss = [f for f in log if f.kind == S.SSW and f.ta == 'R']
    assert [f.cdown for f in iss] == list(range(31, -1, -1)) and [f.sector_id for f in iss[:3]] == [14, 10, 25]
    assert iss[-1].sector_id == 3
    assert [f.cdown for f in rss] == list(range(31, -1, -1))
    assert {f.sector_id for f in rss} == {1} and {f.fb['sector'] for f in rss} == {25}
    fb = next(f for f in log if f.kind == S.SSW_FB)
    assert fb.fb['sector'] is None and fb.fb['snr'] == S.snr_report(30)     # 10.42.2.4: Select — reserved
    assert fb.tx == (0, 25)
    assert ini.result['rx'] == (0, 7)
    assert any(f.kind == S.SSW_ACK for f in log)
    assert S.check_sls_log(log, {'is_responder_txss': False, 'peer_rxss_len': 32}) == []


def test_figure_10_69_single_sector_responder():
    """Рис. 10-69: RSS — один SSW (CDOWN=0, Sector Id=1, Best Sector=25); SSW-Feedback — Best Sector=1."""
    ch = lambda ta, a, s, ra, rxa, rxs: 40 if (ta, s) == ('I', 25) else 15
    ini = S.Initiator('I', 'R', {0: [14, 10, 25, 3]})
    rsp = S.Responder('R', 'I', {0: [1]})
    ini.start(0)
    log = run(ini, rsp, ch)
    rss = [f for f in log if f.kind == S.SSW and f.ta == 'R']
    assert len(rss) == 1 and (rss[0].cdown, rss[0].sector_id, rss[0].fb['sector']) == (0, 1, 25)
    fb = next(f for f in log if f.kind == S.SSW_FB)
    assert fb.fb['sector'] == 1
    assert S.check_sls_log(log) == []


def test_lost_last_iss_frame_expected_end():
    """10.42.2.2.2: «If the responder is unable to receive this frame, the responder shall assume that the initiator
    TXSS has completed at the expected end time of this frame» — RSS всё равно MBIFS после ожидаемого конца."""
    ini = S.Initiator('I', 'R', {0: [0, 1, 2, 3]})
    rsp = S.Responder('R', 'I', {0: [5]})
    ini.start(0)
    log = run(ini, rsp, drop=lambda f: f.kind == S.SSW and f.ta == 'I' and f.cdown == 0)
    rss = [f for f in log if f.ta == 'R' and f.kind == S.SSW]
    assert rss[0].t == 4 * T_SSW + 3 * SB + MB
    assert S.check_sls_log(log) == []


# ---------------------------------------------------------------------------------------------- повторы, тайм-ауты
def test_lost_ack_feedback_retry_pifs():
    """10.42.6.2: повтор SSW-Feedback PIFS после ожидаемого конца SSW-Ack; рис. 10-92: в Pre-Complete повторный
    SSW-Feedback → снова SSW-Ack."""
    n = {'ack': 0}

    def drop(f):
        if f.kind == S.SSW_ACK:
            n['ack'] += 1
            return n['ack'] == 1
        return False
    ini = S.Initiator('I', 'R', {0: [0, 1]})
    rsp = S.Responder('R', 'I', {0: [5]})
    ini.start(0)
    log = run(ini, rsp, drop=drop)
    fbs = [f for f in log if f.kind == S.SSW_FB]
    acks = [f for f in log if f.kind == S.SSW_ACK]
    assert len(fbs) == 2 and len(acks) == 2
    assert fbs[1].t == fbs[0].end + MB + T_FB + PIFS
    assert ini.state == 'COMPLETE' and rsp.state == 'PRE_COMPLETE'
    assert S.check_sls_log(log) == []
    # рис. 10-92: «Non SSW-Feedback and non SSW frame received» → TXSS Phase Complete
    rsp.on_rx(S.BfFrame('Data', 'I', 'R', acks[-1].end + 20, length=100, mcs=4), 20, (0, None))
    assert rsp.state == 'COMPLETE' and rsp.result == {'tx': (0, 5)}


def test_retry_limit():
    """10.42.6.2: до dot11BFRetryLimit (8) повторов; рис. 10-91: «dot11BFRetryLimit exceeded» → Idle."""
    ini = S.Initiator('I', 'R', {0: [0]})
    rsp = S.Responder('R', 'I', {0: [5]})
    ini.start(0)
    log = run(ini, rsp, drop=lambda f: f.kind == S.SSW_ACK)
    assert len([f for f in log if f.kind == S.SSW_FB]) == 1 + 8
    assert ini.state == 'IDLE' and ini.result == 'retry_limit'
    assert S.check_sls_log(log) == []
    assert any('dot11BFRetryLimit' in e for e in S.check_sls_log(log, {'retry_limit': 7}))


def test_no_rss_t1_timeout():
    """Рис. 10-91: нет RSS — «Timeout (T1 …) and DTI» → Idle, T1 = dot11BFTXSSTime (100 мс)."""
    ini = S.Initiator('I', 'R', {0: [0, 1]})
    rsp = S.Responder('R', 'I', {0: [5]})
    ini.start(0)
    run(ini, rsp, channel=lambda *a: None)
    assert ini.state == 'IDLE' and ini.result == 'T1'
    assert ini.trace[-1][0] == 2 * T_SSW + SB + 100_000
    assert rsp.state == 'IDLE'


def test_t2_max_bf_time():
    """10.42.1 / рис. 10-91: SLS прерывается через dot11MaxBFTime (4) BI от начала."""
    ini = S.Initiator('I', 'R', {0: [0]}, bi=10_000)
    rsp = S.Responder('R', 'I', {0: [5]})
    ini.start(0)
    run(ini, rsp, channel=lambda *a: None)
    assert ini.result == 'T2' and ini.trace[-1][0] == 40_000


# ---------------------------------------------------------------------------------------------- распределения
def test_rss_needs_time_in_allocation():
    """10.42.6.2: RSS — только если хватает времени на все SSW RSS; по NOTE может начать без запаса (оборвётся)."""
    iss_end = 2 * T_SSW + SB
    alloc = iss_end + MB + 2 * T_SSW + SB - Fr(1, 10)     # на 3 кадра RSS не хватает
    ini = S.Initiator('I', 'R', {0: [0, 1]}, alloc_end=alloc)
    rsp = S.Responder('R', 'I', {0: [5, 6, 7]}, alloc_end=alloc)
    ini.start(0)
    log = run(ini, rsp)
    assert [f.ta for f in log] == ['I', 'I']
    ini = S.Initiator('I', 'R', {0: [0, 1]}, alloc_end=alloc)
    rsp = S.Responder('R', 'I', {0: [5, 6, 7]}, alloc_end=alloc, start_if_insufficient=True)
    ini.start(0)
    log = run(ini, rsp)
    rss = [f for f in log if f.ta == 'R']
    assert [f.cdown for f in rss] == [2] and all(f.end <= alloc for f in rss)
    assert S.check_sls_log(log, {'alloc_end': alloc}) == []


def test_feedback_moves_to_next_allocation():
    """10.42.6.2: нет времени на SSW-Feedback + MBIFS + SSW-Ack — Feedback в следующем распределении."""
    rss_end = T_SSW + MB + T_SSW
    alloc = rss_end + MB + T_FB + MB + T_FB - Fr(1, 100)
    ini = S.Initiator('I', 'R', {0: [0]}, alloc_end=alloc)
    rsp = S.Responder('R', 'I', {0: [5]}, alloc_end=alloc)
    ini.start(0)
    link = S.SlsLink(ini, rsp, lambda *a: 20)
    link.run(10_000)
    assert ini.state == 'FB_PENDING' and not any(f.kind == S.SSW_FB for f in link.log)
    ini.new_allocation(50_000, 60_000)
    rsp.new_allocation(50_000, 60_000)
    log = link.run(10 ** 6)
    fb = next(f for f in log if f.kind == S.SSW_FB)
    assert fb.t == 50_000 and ini.state == 'COMPLETE'
    # 9.3.1.15: «… plus MBIFS, or until the end of the current allocation …, whichever comes first»
    assert log[0].dur == 9 and min(MB, alloc - log[0].end) == MB
    assert fb.dur == ceil(T_FB + MB)    # 9.3.1.16 b): в новом распределении времени хватает


# ---------------------------------------------------------------------------------------------- CBAP, RXSS
def test_cbap_rxss_length_selects_responder_rxss():
    """10.42.2.3.3 / 10.42.6.2: CBAP, RXSS Length в SSW ≠ 0 → responder RXSS из (RXSS Length + 1)·2 кадров;
    9.5.1: поле действительно только в CBAP."""
    ini = S.Initiator('I', 'R', {0: [0, 1, 2]}, access=S.CBAP, rxss_request=1, rx_sweep=[(0, k) for k in range(4)])
    rsp = S.Responder('R', 'I', {0: [5]}, access=S.CBAP)
    ini.start(0)
    log = run(ini, rsp)
    rss = [f for f in log if f.kind == S.SSW and f.ta == 'R']
    assert len(rss) == 4 and {f.sector_id for f in rss} == {5} and [f.cdown for f in rss] == [3, 2, 1, 0]
    assert all(f.rxss_len == 1 for f in log if f.ta == 'I' and f.kind == S.SSW)
    assert S.check_sls_log(log, {'access': S.CBAP}) == []
    # то же в SP — поле должно быть reserved
    assert any('reserved' in e for e in S.check_sls_log(log, {'access': S.SP, 'is_responder_txss': False}))


def test_cbap_initiator_rxss_cannot_obtain_txop():
    """10.42.2.2.3: «During a CBAP, an initiator shall not obtain a TXOP with an initiator RXSS»."""
    with pytest.raises(ValueError):
        S.Initiator('I', 'R', {0: [0]}, iss=S.RXSS, access=S.CBAP, peer_rxss_len=4)
    S.Initiator('I', 'R', {0: [0]}, iss=S.RXSS, access=S.CBAP, peer_rxss_len=4, txop_by_iss=False)
    with pytest.raises(ValueError):     # 10.42.2.2.3: больше одного сектора — сначала TXSS
        S.Initiator('I', 'R', {0: [0, 1]}, iss=S.RXSS, peer_rxss_len=4)


def test_initiator_rxss_txrate():
    """10.6.7.1: RXSS с RXSSTxRate — первый SSW DMG Control, остальные MCS 1 SC, промежутки SBIFS; ответчик считает
    конец ISS по CDOWN и TXTIME(SSW, MCS 1)."""
    ch = lambda ta, a, s, ra, rxa, rxs: (30 if rxs == 2 else 10) if ta == 'I' else 20
    ini = S.Initiator('I', 'R', {0: [4]}, iss=S.RXSS, peer_rxss_len=6, rxss_txrate=True)
    rsp = S.Responder('R', 'I', {0: [5]}, iss=S.RXSS, rx_sweep=[(0, k) for k in range(6)], iss_start=0,
                      peer_rxss_txrate=True)
    ini.start(0)
    log = run(ini, rsp, ch)
    iss = [f for f in log if f.kind == S.SSW and f.ta == 'I']
    assert [f.mcs for f in iss] == [0, 1, 1, 1, 1, 1]
    assert all(b.t - a.end == SB for a, b in zip(iss, iss[1:]))
    rss = [f for f in log if f.kind == S.SSW and f.ta == 'R']
    assert rss[0].t == iss[-1].end + MB
    assert rsp.rx_config(rss[0].t) == (0, 2)                    # 10.42.2.4: лучший приёмный сектор после RXSS
    assert S.check_sls_log(log, {'rxss_txrate': {'iss': True}, 'iss_rxss_len': 6}) == []


def test_reciprocity_only_best_antenna():
    """10.42.2.3.2: Reciprocity = 1 — RSS через антенну лучшего приёма в ISS; длина sweep-а та же (СПОРНО: слоты
    других антенн молчат, сетка CDOWN сохраняется)."""
    ch = lambda ta, a, s, ra, rxa, rxs: (30 if rxa == 1 else 10) if ta == 'I' else 20
    ini = S.Initiator('I', 'R', {0: [0, 1]}, peer_rx_antennas=2)
    rsp = S.Responder('R', 'I', {0: [3, 4], 1: [7, 8]}, rx_antennas=2, reciprocity=True, iss_start=0,
                      peer_tx_slots=2)
    ini.start(0)
    log = run(ini, rsp, ch)
    rss = [f for f in log if f.kind == S.SSW and f.ta == 'R']
    assert [(f.antenna_id, f.cdown) for f in rss] == [(1, 1), (1, 0)]
    assert rss[0].t == 5 * T_SSW + 4 * SB + MB + 3 * (T_SSW + SB)


# ---------------------------------------------------------------------------------------------- BTI
def test_bti_fragmented_txss():
    """10.42.4: CDOWN по всему фрагментированному TXSS, Fragmented TXSS = 1, TXSS Span = число BI; Duration — до
    конца BTI; между Beacon — SBIFS."""
    sec = [(0, s) for s in range(6)]
    btis = S.bti_txss(sec, [3, 3], [0, 102_400], 100)
    assert [[f.cdown for f in b] for b in btis] == [[5, 4, 3], [2, 1, 0]]
    assert {(f.fragmented, f.txss_span, f.direction, f.kind) for b in btis for f in b} == {(1, 2, 0, S.BEACON)}
    tb = ctrl_tx(100)
    assert [f.t for f in btis[0]] == [0, tb + SB, 2 * (tb + SB)]
    assert [f.dur for f in btis[0]] == [ceil(2 * (tb + SB)), ceil(tb + SB), 0]
    whole = S.bti_txss(sec, [6], [0], 100)
    assert {f.fragmented for f in whole[0]} == {0}
    with pytest.raises(ValueError):     # 10.42.4: «shall not change DMG antennas within a BTI»
        S.bti_txss([(0, 1), (1, 1)], [2], [0], 100)
    with pytest.raises(ValueError):     # 10.42.4: TXSS Span < dot11MaximalSectorScan (8)
        S.bti_txss([(0, s) for s in range(8)], [1] * 8, [k * 1000 for k in range(8)], 100)


# ---------------------------------------------------------------------------------------------- проверка журнала
@pytest.fixture
def good_log():
    ini = S.Initiator('I', 'R', {0: [0, 1, 2]})
    rsp = S.Responder('R', 'I', {0: [5, 6]})
    ini.start(0)
    log = run(ini, rsp, lambda ta, a, s, ra, rxa, rxs: 20 + s)
    assert S.check_sls_log(log) == []
    return log


def shift_from(log, i, dt):
    out = copy.deepcopy(log)
    for f in out[i:]:
        f.t += dt
    return out


@pytest.mark.parametrize('i,dt,ok', [(1, Fr(3, 100), True), (1, Fr(31, 1000), False), (1, Fr(-1, 100), False),
                                     (3, Fr(49, 100), True), (3, Fr(1, 2), False), (3, Fr(-1, 100), False),
                                     (5, Fr(49, 100), True), (5, Fr(1, 2), False),
                                     (6, Fr(49, 100), True), (6, Fr(1, 2), False)])
def test_check_ifs_tolerances(good_log, i, dt, ok):
    """10.3.2.3.8: SBIFS ∈ [1; 1,03]; 10.3.2.3.10: MBIFS −0 … +0,49 (ISS→RSS, RSS→FB, FB→Ack)."""
    assert (S.check_sls_log(shift_from(good_log, i, dt)) == []) == ok


def mutate(log, i, **kw):
    out = copy.deepcopy(log)
    for k, v in kw.items():
        setattr(out[i], k, v)
    return out


@pytest.mark.parametrize('i,kw,needle', [
    (0, {'direction': 1}, 'Direction'),
    (3, {'direction': 0}, 'Direction'),
    (1, {'cdown': 0}, 'CDOWN'),
    (5, {'tx': (0, 1)}, '10.42.2.4'),
    (6, {'tx': (0, 5)}, '10.42.2.5'),
    (5, {'mcs': 1}, '10.6.7.1'),
    (2, {'mcs': 1}, '10.6.7.1'),
    (0, {'dur': 1}, '9.3.1.15'),
    (5, {'dur': 100}, '9.3.1.16'),
    (6, {'dur': 100}, '9.3.1.17'),
    (1, {'trn': 4}, 'TRN'),
    (1, {'sector_id': 0}, 'Sector ID'),
    (0, {'kind': S.BEACON}, 'Beacon'),
    (6, {'ta': 'I', 'ra': 'R'}, 'роли'),
])
def test_check_detects(good_log, i, kw, needle):
    errs = S.check_sls_log(mutate(good_log, i, **kw))
    assert any(needle in e for e in errs), errs


def test_check_select_fields(good_log):
    """10.42.2.3.2: Sector Select RSS = лучший кадр ISS; 10.42.2.4: Select Feedback = лучший кадр RSS."""
    assert S.check_sls_log(good_log, {'iss_snr': {0: 20, 1: 21, 2: 22}, 'rss_snr': {0: 25, 1: 26}}) == []
    errs = S.check_sls_log(good_log, {'iss_snr': {0: 30, 1: 21, 2: 22}})
    assert any('лучший кадр ISS' in e for e in errs)
    errs = S.check_sls_log(good_log, {'rss_snr': {0: 30, 1: 26}})
    assert any('лучший кадр RSS' in e for e in errs)
    bad = copy.deepcopy(good_log)
    bad[3].fb = dict(bad[3].fb, sector=9)
    assert any('Sector Select' in e for e in S.check_sls_log(bad))


def test_check_other_exchange_during_sls(good_log):
    """10.42.6.2: «complete the SLS phase before any additional frame exchange takes place between these STAs»."""
    log = copy.deepcopy(good_log)
    log.insert(5, S.BfFrame('Data', 'I', 'R', log[4].end + 2, length=100, mcs=4))
    assert any('10.42.6.2' in e for e in S.check_sls_log(log))
    log = copy.deepcopy(good_log) + [S.BfFrame('Data', 'I', 'R', good_log[-1].end + 3, length=100, mcs=4)]
    assert S.check_sls_log(log) == []


def test_check_retry_gap(good_log):
    """10.42.6.2: повтор SSW-Feedback — PIFS после ожидаемого конца SSW-Ack."""
    fb = good_log[5]
    log = good_log[:6]
    rep = copy.deepcopy(fb)
    rep.t = fb.end + MB + T_FB + PIFS
    assert S.check_sls_log(log + [rep]) == []
    rep2 = copy.deepcopy(rep)
    rep2.t += 1
    assert any('PIFS' in e for e in S.check_sls_log(log + [rep2]))


def test_check_rxss_feedback_select_reserved():
    """10.42.2.4: после responder RXSS Sector Select / DMG Antenna Select в SSW-Feedback — reserved."""
    ini = S.Initiator('I', 'R', {0: [0, 1]}, rss=S.RXSS, rx_sweep=[(0, 0), (0, 1)])
    rsp = S.Responder('R', 'I', {0: [5]}, rss=S.RXSS, peer_rxss_len=2)
    ini.start(0)
    log = run(ini, rsp)
    ctx = {'is_responder_txss': False, 'peer_rxss_len': 2}
    assert S.check_sls_log(log, ctx) == []
    bad = copy.deepcopy(log)
    fb = next(f for f in bad if f.kind == S.SSW_FB)
    fb.fb['sector'] = 5
    assert any('reserved' in e for e in S.check_sls_log(bad, ctx))


def test_check_iss_repetitions(good_log):
    """10.42.6.2: ISS повторяется по числу приёмных антенн ответчика."""
    assert any('повторов' in e for e in S.check_sls_log(good_log, {'responder_rx_antennas': 2}))


def test_check_truncated_sweep_without_alloc_end(good_log):
    """10.42.2.2.2: sweep кончается CDOWN=0, иначе — только конец распределения."""
    log = [f for k, f in enumerate(good_log) if k != 2]
    log = [f for f in log if f.kind == S.SSW and f.ta == 'I']
    assert any('оборван' in e for e in S.check_sls_log(log))
