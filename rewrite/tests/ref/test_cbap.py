# SPDX-License-Identifier: AGPL-3.0-or-later
"""Эталон доступа DMG STA в CBAP: ожидания — из текста 802.11-2020 (10.23.2.2, 10.23.2.4, рис. 10-25, 10.3.2.4,
10.23.2.8–10.23.2.10, 10.39.4, 10.39.5, табл. 9-155)."""
from fractions import Fraction as Fr

import pytest

from . import cbap as C
from . import timing as T

AIFS_BE = T.aifs(3)                                         # 18 мкс
SLOT = T.aSlotTime


def rules(log, **kw):
    return sorted(v.rule for v in C.check_air_log(log, C.LogParams(**kw)))


def busy(st, t0, t1, f=None):
    """Чужой PPDU [t0, t1] у станции st."""
    st.rx_start(t0)
    st.rx_end(t1, f if f is not None else C.Frame('Data', 'X', 'Y', 100, 4, dur=0))


# ---------------- постоянные ----------------
def test_default_edca_dmg():
    """Табл. 9-155: CWmin/CWmax/AIFSN; DMG (Clause 20) — «Other PHYs», TXOP limit 0."""
    d = C.DEFAULT_EDCA
    assert [(d[a].cwmin, d[a].cwmax, d[a].aifsn) for a in (C.AC_BK, C.AC_BE, C.AC_VI, C.AC_VO)] == \
        [(15, 1023, 7), (15, 1023, 3), (7, 15, 2), (3, 7, 2)]
    assert all(p.txop_limit == 0 for p in d.values())


def test_ifs_and_timeouts():
    assert (C.PIFS, C.DIFS, AIFS_BE) == (8, 13, 18)       # (10-5), (10-6), AIFS = AIFSN·aSlotTime + aSIFSTime
    assert C.EIFS == 3 + T.txtime_control(14) + 13         # (10-7)
    assert C.response_timeout(0) == 3 + 5 + 10             # ответ в Control mode: aRxPHYStartDelay 10 мкс
    assert C.response_timeout(4) == 3 + 5 + Fr(36, 10)     # SC: 3,6 мкс
    assert C.NAV_TIMEOUT == 2 * 3 + T.txtime_control(20) + 5 + 2 * 5   # 10.3.2.4, DMG


def test_response_mcs():
    """10.6.7.2: на Control — Control; на SC — обязательная SC (≤ MCS 4) не быстрее вызвавшего."""
    assert [C.resp_mcs(m) for m in (0, 1, 3, 4, 8, 12)] == [0, 1, 3, 4, 4, 4]


# ---------------- 10.23.2.2: CW и QSRC ----------------
def test_cw_doubling_and_reset_after_retry_limit():
    """c)/d)/e): QSRC < dot11ShortRetryLimit (7) → QSRC+1, CW = min(CWmax, 2^QSRC·(CWmin+1) − 1); иначе 0 и CWmin."""
    e = C.Edcaf(C.AC_BE, C.DEFAULT_EDCA[C.AC_BE], C.SeqRng([0] * 20))
    assert (e.cw, e.qsrc) == (15, 0)                       # «initialized to the value of … CWmin[AC]»
    seq = []
    for _ in range(8):
        e.invoke_backoff('c')
        seq.append((e.cw, e.qsrc))
    assert seq == [(31, 1), (63, 2), (127, 3), (255, 4), (511, 5), (1023, 6), (1023, 7), (15, 0)]
    e.invoke_backoff('e')
    e.invoke_backoff('a')                                  # a): без изменений
    assert (e.cw, e.qsrc) == (31, 1)
    e.invoke_backoff('b')                                  # b): CWmin, 0
    assert (e.cw, e.qsrc) == (15, 0)


def test_cw_vo_capped_at_cwmax():
    e = C.Edcaf(C.AC_VO, C.DEFAULT_EDCA[C.AC_VO], C.SeqRng([0] * 5))
    assert [e.invoke_backoff('d') is not None and e.cw for _ in range(3)] == [7, 7, 7]


def test_backoff_drawn_within_cw():
    """10.23.2.4: счётчик — 0..CW[AC] равновероятно; крайние значения достижимы."""
    e = C.Edcaf(C.AC_BE, C.DEFAULT_EDCA[C.AC_BE], C.Rng(1))
    vals = {e.invoke_backoff('a') for _ in range(3000)}
    assert vals == set(range(16))


# ---------------- 10.23.2.4: одна станция ----------------
def test_single_station_aifs_plus_backoff_slots():
    """Кадр пришёл при занятой среде → backoff (a); передача = конец занятости + AIFS + N·aSlotTime."""
    st = C.Station('A', rng=C.SeqRng([4]))
    st.rx_start(0)
    st.enqueue(5, C.Msdu('B'))
    st.rx_end(10, C.Frame('Data', 'X', 'Y', 100, 4, dur=0))
    assert st.edcafs[C.AC_BE].log == [('a', 15, 0, 4)]
    assert st.next_action() == (10 + AIFS_BE + 4 * SLOT, 'tx')


def test_idle_medium_no_backoff_next_slot_boundary():
    """Счётчик 0, среда свободна: backoff не вызывается (a требует занятой среды); передача — на ближайшей
    границе слота (f: границы идут через aSlotTime свободной среды)."""
    st = C.Station('A', rng=C.SeqRng([]))
    busy(st, 0, 10)
    st.enqueue(100, C.Msdu('B'))
    b0 = 10 + AIFS_BE                                      # 28
    assert st.next_action() == (b0 + 15 * SLOT, 'tx')      # 103: первая граница > 100
    st2 = C.Station('A', rng=C.SeqRng([]))
    busy(st2, 0, 10)
    st2.enqueue(12, C.Msdu('B'))                           # внутри AIFS — передача ровно на AIFS
    assert st2.next_action() == (b0, 'tx')


def test_figure_10_25_example():
    """Рис. 10-25 / текст: AIFSN = 2, счётчик 1 → передача через aSIFSTime + 3 × aSlotTime после занятости."""
    st = C.Station('A', edca={C.AC_BE: C.EdcaParams(15, 1023, 2)}, rng=C.SeqRng([1]))
    st.rx_start(0)
    st.enqueue(1, C.Msdu('B'))
    st.rx_end(20, C.Frame('Data', 'X', 'Y', 100, 4, dur=0))
    assert st.next_action() == (20 + T.aSIFSTime + 3 * SLOT, 'tx')


def test_eifs_after_rx_error():
    """10.23.2.4 b), 10.3.2.3.7: после ошибочного кадра — EIFS − DIFS + AIFS[AC]."""
    st = C.Station('A', rng=C.SeqRng([0]))
    st.rx_start(0)
    st.enqueue(1, C.Msdu('B'))
    st.rx_end(10, None)
    assert st.next_action() == (10 + C.EIFS - C.DIFS + AIFS_BE, 'tx')


def test_internal_collision_higher_ac_wins():
    """10.23.2.4: две EDCAF STA на одной границе — передаёт старшая AC, младшая — backoff d) (CW удваивается)."""
    edca = {C.AC_BE: C.DEFAULT_EDCA[C.AC_BE], C.AC_VO: C.DEFAULT_EDCA[C.AC_VO]}
    st = C.Station('A', edca=edca, rng=C.SeqRng([1, 0, 5]))
    st.rx_start(0)
    st.enqueue(1, C.Msdu('B'), C.AC_VO)                    # VO: AIFS 13, счётчик 1 → 18
    st.enqueue(1, C.Msdu('B'), C.AC_BE)                    # BE: AIFS 18, счётчик 0 → 18
    st.rx_end(10, C.Frame('Data', 'X', 'Y', 100, 4, dur=0))
    assert st.next_action() == (10 + 18, 'tx')
    f = st.start(28)
    assert st.txop.ed.ac == C.AC_VO and f.kind == 'Data'
    be = st.edcafs[C.AC_BE]
    assert be.log[-1] == ('d', 31, 1, 5) and be.queue[0].retries == 1


# ---------------- две станции: замораживание счётчика ----------------
def _two_with_counters(na, nb):
    a = C.Station('A', rng=C.SeqRng([na] + [0] * 10))
    b = C.Station('B', rng=C.SeqRng([nb] + [0] * 10))
    c = C.Station('C', rng=C.SeqRng([]))                   # только отвечает
    for s, d in ((a, 'C'), (b, 'C')):
        s.rx_start(0)
        s.enqueue(1, C.Msdu(d, 1000, 4))
        s.rx_end(10, C.Frame('Data', 'X', 'Y', 100, 4, dur=0))
    c.rx_start(0)
    c.rx_end(10, C.Frame('Data', 'X', 'Y', 100, 4, dur=0))
    return a, b, c


def test_two_stations_counter_frozen_while_busy():
    """B уменьшает счётчик только на границах свободной среды; на границе передачи A — последнее уменьшение
    (одна функция на границу, 10.23.2.4); остаток досчитывается после AIFS следующей паузы."""
    a, b, c = _two_with_counters(2, 5)
    log = C.Air([a, b, c]).run(400)
    t_a = 10 + AIFS_BE + 2 * SLOT
    assert log[0][:3] == (t_a, log[0][1], 'A')
    assert b.edcafs[C.AC_BE].log[0] == ('a', 15, 0, 5)
    # B: границы 28, 33, 38 → счётчик 5 → 2
    ack_a = log[1]
    assert ack_a[4] == 'Ack' and ack_a[2] == 'C'
    # NAV B: max(конец Data A + Duration, конец Ack + Duration Ack) (10.3.2.4)
    nav_b = max(log[0][1] + log[0][5], ack_a[1] + ack_a[5])
    assert log[2][2] == 'B' and log[2][0] == max(ack_a[1], nav_b) + AIFS_BE + 2 * SLOT
    assert rules(log) == []


def test_equal_counters_collide():
    """Равные счётчики → одновременное начало (коллизия); оба без ответа → c): CW 31."""
    a, b, c = _two_with_counters(3, 3)
    log = C.Air([a, b, c]).run(200)
    assert log[0][0] == log[1][0] == 10 + AIFS_BE + 3 * SLOT
    assert a.edcafs[C.AC_BE].log[1][:3] == ('c', 31, 1) and b.edcafs[C.AC_BE].log[1][:3] == ('c', 31, 1)
    first = log[:2]
    assert rules(first) == [] and rules(first, report_collisions=True) == ['collision']


# ---------------- NAV (10.3.2.4, 10.23.2.10) ----------------
def test_nav_rules_single_nav():
    n = C.Nav('B')
    n.rx(10, C.Frame('RTS', 'A', 'B', dur=100))            # RA = свой → не обновлять
    assert n.idle_from() == 0
    n.rx(10, C.Frame('DMG CTS', 'B', 'A', dur=100))        # DMG CTS с TA = свой → не обновлять
    assert n.idle_from() == 0
    n.rx(10, C.Frame('Data', 'A', 'C', dur=100))
    n.rx(20, C.Frame('Data', 'A', 'C', dur=50))            # 70 < 110 — только «greater than current NAV»
    assert n.idle_from() == 110
    n.rx(30, C.Frame('Ack', 'C', 'A', dur=100))
    assert n.idle_from() == 130


def test_rts_nav_reset_after_navtimeout():
    """10.3.2.4: NAV по RTS можно сбросить, если за NAVTimeout после RTS нет PHY-RXSTART."""
    n = C.Nav('C')
    n.rx(10, C.Frame('RTS', 'A', 'B', dur=500))
    assert n.idle_from() == 10 + C.NAV_TIMEOUT
    n.rx_start(10 + C.NAV_TIMEOUT)                         # DMG CTS начался в пределах NAVTimeout
    assert n.idle_from() == 510
    n2 = C.Nav('C', rts_reset=False)
    n2.rx(10, C.Frame('RTS', 'A', 'B', dur=500))
    assert n2.idle_from() == 510


def test_cf_end_dmg_nav_reset_at_end_of_duration():
    """10.23.2.10: DMG STA сбрасывает NAV в конце интервала Duration CF-End (от PHY-RXEND); 0 — сразу."""
    n = C.Nav('C')
    n.rx(10, C.Frame('Data', 'A', 'B', dur=1000))
    n.rx(100, C.Frame('CF-End', 'A', 'B', dur=12))
    assert n.idle_from() == 112
    n.rx(105, C.Frame('CF-End', 'B', C.BCAST, dur=0))
    assert n.idle_from() == 105
    m = C.Nav('C')                                         # интервал CF-End длиннее NAV — передавать нельзя
    m.rx(10, C.Frame('Ack', 'A', 'B', dur=5))
    m.rx(20, C.Frame('CF-End', 'A', 'B', dur=40))
    assert m.idle_from() == 60


def test_third_station_defers_on_rts_of_other_pair():
    """C слышит RTS/DMG CTS пары A–B: NAV до конца обмена; C начинает доступ только после NAV + AIFS."""
    a = C.Station('A', rng=C.SeqRng([0, 0]))
    b = C.Station('B', rng=C.SeqRng([]))
    c = C.Station('C', rng=C.SeqRng([0, 0]))
    a.enqueue(0, C.Msdu('B', 4000, 4, rts=True))
    air = C.Air([a, b, c])
    log = air.run(30)                                      # RTS A в 18; C получает кадр во время RTS
    assert log[0][4] == 'RTS' and log[0][0] == AIFS_BE
    c.enqueue(30, C.Msdu('A', 200, 4))                     # среда занята (RTS) → backoff a), 0
    assert c.edcafs[C.AC_BE].log == [('a', 15, 0, 0)]
    log2 = air.run(500)
    kinds = [(e[2], e[4]) for e in log2]
    assert kinds[:3] == [('B', 'DMG CTS'), ('A', 'Data'), ('B', 'Ack')]
    rts, cts, data, ack, c_data = log[0], log2[0], log2[1], log2[2], log2[3]
    assert c_data[2] == 'C'
    nav = max(rts[1] + rts[5], cts[1] + cts[5], data[1] + data[5], ack[1] + ack[5])
    assert nav >= ack[1]
    assert c_data[0] == nav + AIFS_BE
    assert C.check_air_log(log + log2) == []


def test_cts_withheld_when_nav_busy():
    """10.3.2.9: NAV ответчика занят (не держателем-инициатором RTS) → DMG CTS не отправляется; у A — сбой c)."""
    a = C.Station('A', rng=C.SeqRng([0, 0, 0]))
    b = C.Station('B', rng=C.SeqRng([]))
    b.rx_start(0)
    b.rx_end(10, C.Frame('Data', 'X', 'Y', 100, 4, dur=400))   # NAV B до 410
    a.rx_start(0)
    a.enqueue(1, C.Msdu('B', 1000, 4, rts=True))
    a.rx_end(10, None)                                     # A не принял тот кадр
    log = C.Air([a, b]).run(150)
    assert [e[4] for e in log][:2] == ['RTS', 'RTS']
    assert a.edcafs[C.AC_BE].log[1][:3] == ('c', 31, 1)


def test_other_valid_frame_during_timeout_is_failure():
    """10.23.2.2: при PHY-RXSTART в таймауте — ждать RXEND; «any other valid frame» → сбой."""
    a = C.Station('A', rng=C.SeqRng([0]))
    a.enqueue(0, C.Msdu('B', 1000, 4))
    f = a.start(AIFS_BE)
    a.tx_end(AIFS_BE + f.airtime)
    a.rx_start(AIFS_BE + f.airtime + 3)
    a.rx_end(AIFS_BE + f.airtime + 10, C.Frame('Ack', 'Z', 'A', dur=0))   # Ack не от адресата
    assert a.edcafs[C.AC_BE].log[-1][0] == 'c'


# ---------------- повторы до dot11ShortRetryLimit ----------------
def test_retries_double_cw_then_discard_and_reset():
    """Нет Ack: каждая неудача первого PPDU — c); после 7 неудач MSDU отбрасывается (10.23.2.12.1); следующая
    неудача при QSRC = 7 сбрасывает CW в CWmin (10.23.2.2 «Else»)."""
    a = C.Station('A', rng=C.SeqRng([0] * 20))
    a.enqueue(0, C.Msdu('Z', 1000, 4))
    a.enqueue(0, C.Msdu('Z', 1000, 4))
    log = C.Air([a]).run(800)
    ed = a.edcafs[C.AC_BE]
    assert [(r, cw, q) for r, cw, q, _ in ed.log[:8]] == \
        [('c', 31, 1), ('c', 63, 2), ('c', 127, 3), ('c', 255, 4), ('c', 511, 5), ('c', 1023, 6),
         ('c', 1023, 7), ('c', 15, 0)]
    assert len(a.discarded) >= 1 and a.discarded[0].retries == 7
    # повтор: таймаут SC 11,6 мкс < AIFS — доступ на AIFS после конца своего PPDU (счётчик 0)
    assert all(log[i + 1][0] == log[i][1] + AIFS_BE for i in range(7))
    assert C.check_air_log(log) == []


# ---------------- CBAP (10.39.4, 10.39.5) ----------------
def _cbap_station(n, cbaps, length=1000):
    st = C.Station('A', rng=C.SeqRng([n, 0, 0]), cbaps=cbaps)
    st._run(Fr(0))
    st.rx_start(0)
    st.enqueue(1, C.Msdu('B', length, 4))
    st.rx_end(50, C.Frame('Data', 'X', 'Y', 100, 4, dur=0))
    return st


def test_exchange_not_fitting_cbap_end_not_started():
    """Обмен (Data + SIFS + Ack) не успевает до конца CBAP → не начинается; в следующем CBAP — через AIFS от
    начала, счётчик не меняется за паузу."""
    cb = [(0, 100), (200, 1000)]
    m = C.Msdu('B', 1000, 4)
    st = _cbap_station(4, cb)
    # границы 68, 73, 78, 83 → 0; 88/93/98: 88 + обмен > 100
    assert 88 + m.exchange_time() > 100
    assert st.next_action() == (200 + AIFS_BE, 'tx')
    st2 = _cbap_station(9, cb)                             # 68…98 — 7 уменьшений, остаток 2
    assert st2.next_action() == (200 + AIFS_BE + 2 * SLOT, 'tx')
    st3 = _cbap_station(2, cb)                             # 68 → 1, 73 → 0, 78: 78 + обмен ≤ 100
    assert 78 + m.exchange_time() <= 100
    assert st3.next_action() == (78, 'tx')


def test_nav_frozen_between_cbaps():
    """10.39.5: «values of the backoff and NAVs shall remain unchanged until the start of the following CBAP»."""
    st = C.Station('A', rng=C.SeqRng([0]), cbaps=[(0, 100), (200, 1000)])
    st._run(Fr(0))
    st.rx_start(80)
    st.enqueue(81, C.Msdu('B', 200, 4))
    st.rx_end(90, C.Frame('Data', 'X', 'Y', 100, 4, dur=60))   # NAV до 150; на конце CBAP остаток 50
    assert st.next_action() == (250 + AIFS_BE, 'tx')


def test_cbap_sim_and_log_consistent():
    cb = [(0, 300), (400, 700), (900, 1500)]
    sts = [C.Station(x, rng=C.Rng(i), cbaps=cb) for i, x in enumerate('ABC')]
    for i, s in enumerate(sts):
        for k in range(4):
            s.enqueue(0, C.Msdu('ABC'[(i + 1) % 3], 2000 + 500 * k, 4, rts=(k % 2 == 1)))
    log = C.Air(sts).run(1500)
    assert all(e[1] <= e[6] for e in log)
    assert all(not (300 < e[0] < 400 or 700 < e[0] < 900) for e in log)
    assert C.check_air_log(log, C.LogParams(cbaps=cb)) == []


# ---------------- TXOP: несколько кадров, лимит, CF-End ----------------
def test_txop_limit_zero_one_msdu_per_txop():
    """10.23.2.9: лимит 0 — один MSDU за TXOP; второй — после backoff b) (AIFS после TXNAV)."""
    a = C.Station('A', rng=C.SeqRng([0, 0]))
    b = C.Station('B', rng=C.SeqRng([]))
    a.enqueue(0, C.Msdu('B', 1000, 4))
    a.enqueue(0, C.Msdu('B', 1000, 4))
    log = C.Air([a, b]).run(300)
    d1, ack, d2 = log[0], log[1], log[2]
    txnav = d1[1] + d1[5]                                   # TXNAV = Duration успешного Data от его конца
    assert d2[0] == max(ack[1], txnav) + AIFS_BE
    assert a.edcafs[C.AC_BE].log[-1][0] == 'b'
    assert rules(log) == []


def test_multiple_frames_in_txop_with_limit():
    """10.23.2.8: при ненулевом лимите и multiple protection — следующий MSDU через SIFS в TXOP; 10.23.2.10:
    пустая очередь — CF-End (Duration = TXTIME(CF-End) + SIFS) и ответный CF-End; C ждёт не весь TXOP."""
    p = C.EdcaParams(15, 1023, 3, txop_limit=1000)
    a = C.Station('A', edca={C.AC_BE: p}, rng=C.SeqRng([0, 0]), protection='multiple', full_txop=True,
                  cf_end=True)
    b = C.Station('B', rng=C.SeqRng([]))
    c = C.Station('C', rng=C.SeqRng([0, 0]))
    for _ in range(2):
        a.enqueue(0, C.Msdu('B', 2000, 4))
    air = C.Air([a, b, c])
    log = air.run(60)
    c.enqueue(60, C.Msdu('A', 200, 4))
    log += air.run(2000)
    kinds = [(e[2], e[4]) for e in log]
    assert kinds[:6] == [('A', 'Data'), ('B', 'Ack'), ('A', 'Data'), ('B', 'Ack'), ('A', 'CF-End'),
                         ('B', 'CF-End')]
    assert log[2][0] == log[1][1] + T.SIFS
    # CF-End: Duration = TXTIME(CF-End) + SIFS (i = 2), ответ — 0 (9.3.1.6); C — AIFS после ответа CF-End
    assert log[4][5] == C.ceil_us(C.T_CF_END + T.SIFS) and log[5][5] == 0
    assert log[6][2] == 'C' and log[6][0] == log[5][1] + AIFS_BE
    assert rules(log, txop_limit=1000) == []
    assert rules(log, txop_limit=0) == ['txop_limit']


# ---------------- check_air_log: обнаружение нарушений ----------------
def _clean():
    a = C.Station('A', rng=C.SeqRng([1, 0]))
    b = C.Station('B', rng=C.SeqRng([]))
    a.enqueue(0, C.Msdu('B', 1000, 4, rts=True))
    return C.Air([a, b]).run(300)                           # RTS, DMG CTS, Data, Ack


def _mv(e, t0):
    d = Fr(t0) - e[0]
    return (e[0] + d, e[1] + d) + tuple(e[2:])


def test_clean_log_has_no_violations():
    log = _clean()
    assert [e[4] for e in log] == ['RTS', 'DMG CTS', 'Data', 'Ack']
    assert C.check_air_log(log) == []


def test_detects_busy_nav_aifs_slot_sifs():
    log = _clean()
    rts, cts, data, ack = log
    l = T.txtime(200, 4)
    # передача C посреди Data A
    assert 'busy' in rules(log + [(data[0] + 2, data[0] + 2 + l, 'C', 'D', 'Data', 0, None)])
    # C в паузе SIFS между RTS и DMG CTS — под NAV RTS
    assert 'nav' in rules(log[:1] + [(rts[1] + 1, rts[1] + 1 + l, 'C', 'D', 'Data', 0, None)])
    # после Ack: 10 мкс < AIFS
    end = max(ack[1] + ack[5], data[1] + data[5], ack[1])
    assert rules(log + [(end + 10, end + 10 + l, 'C', 'D', 'Data', 0, None)]) == ['aifs']
    # AIFS + 2,5 мкс — не граница слота; AIFS + 2 слота — норма
    assert rules(log + [(end + AIFS_BE + Fr(5, 2), end + 30 + l, 'C', 'D', 'Data', 0, None)]) == ['slot']
    assert rules(log + [(end + AIFS_BE + 10, end + 28 + l, 'C', 'D', 'Data', 0, None)]) == []
    # Ack через 5 мкс вместо SIFS (допуск +10 %·(aSlotTime − aAirPropagationTime) = 0,49 мкс)
    assert rules(log[:3] + [_mv(ack, data[1] + 5)]) == ['sifs']
    assert rules(log[:3] + [_mv(ack, data[1] + 3 + Fr(49, 100))]) == []
    assert rules(log[:3] + [_mv(ack, data[1] + 3 + Fr(1, 2))]) == ['sifs']


def test_detects_rts_nav_violation_and_permitted_reset():
    """NAV по RTS без продолжения обмена: до NAVTimeout — нарушение; после — допустимо (сброс разрешён)."""
    rts = (Fr(18), Fr(18) + T.txtime_control(20), 'A', 'B', 'RTS', 500, None)
    l = T.txtime(200, 4)
    t1 = rts[1] + AIFS_BE + SLOT                            # < NAVTimeout ≈ 34 мкс
    assert t1 < rts[1] + C.NAV_TIMEOUT
    assert rules([rts, (t1, t1 + l, 'C', 'D', 'Data', 0, None)]) == ['nav']
    t2 = rts[1] + C.NAV_TIMEOUT + AIFS_BE
    assert rules([rts, (t2, t2 + l, 'C', 'D', 'Data', 0, None)]) == []
    assert rules([rts, (t2, t2 + l, 'C', 'D', 'Data', 0, None)], rts_nav_reset=False) == ['nav']


def test_detects_cbap_end():
    log = [tuple(e[:6]) + (Fr(60),) for e in _clean()]
    assert log[-1][1] > 60
    assert 'cbap_end' in rules(log)
    assert rules([tuple(e[:6]) + (log[-1][1],) for e in log]) == []


def test_detects_cts_with_busy_nav():
    other = (Fr(0), Fr(10), 'X', 'Y', 'Data', 1000, None)  # NAV B до 1010
    rts = (Fr(28), Fr(28) + T.txtime_control(20), 'A', 'B', 'RTS', 100, None)
    cts = (rts[1] + 3, rts[1] + 3 + C.T_DMG_CTS, 'B', 'A', 'DMG CTS', 80, None)
    r = rules([other, rts, cts])
    assert 'cts_nav' in r and 'nav' in r                    # A тоже начал при NAV (он слышал X)


def test_detects_response_timeout():
    """RTS повторён до истечения CTSTimeout (18 мкс) при AIFSN 2 (AIFS 13 мкс) — нарушение таймаута."""
    t_rts = T.txtime_control(20)
    r1 = (Fr(13), 13 + t_rts, 'A', 'B', 'RTS', 100, None)
    r2 = (r1[1] + 13, r1[1] + 13 + t_rts, 'A', 'B', 'RTS', 100, None)
    assert rules([r1, r2], aifsn=2) == ['timeout']
    r3 = _mv(r2, r1[1] + 18)
    assert rules([r1, r3], aifsn=2) == []


def test_detects_txnav_and_txop_limit():
    """Второй Data через SIFS: без TXNAV — не продолжение TXOP (AIFS); с RTS, Duration которого покрывает оба
    обмена, — продолжение; при лимите 0 — нарушение лимита."""
    log = [e for e in _clean()]
    rts, cts, data, ack = log
    d2 = _mv(data, ack[1] + 3)
    a2 = _mv(ack, d2[1] + 3)
    assert 'aifs' in rules(log + [d2, a2])
    # TXNAV — по Duration последнего успешного кадра (10.23.2.2), поэтому и Data несёт Duration до конца TXOP
    long_rts = rts[:5] + (rts[5] + 200,) + rts[6:]
    long_cts = cts[:5] + (cts[5] + 200,) + cts[6:]
    long_data = data[:5] + (data[5] + 40,) + data[6:]
    assert rules([long_rts, long_cts, data, ack, d2, a2]) == ['aifs']   # Duration Data — только до Ack
    assert rules([long_rts, long_cts, long_data, ack, d2, a2]) == ['txop_limit']
    assert rules([long_rts, long_cts, long_data, ack, d2, a2], txop_limit=1000) == []
    big = d2[:1] + (d2[1] + 300,) + d2[2:]                  # кадр длиннее остатка TXNAV
    assert 'txnav' in rules([long_rts, long_cts, long_data, ack, big], txop_limit=1000)


def test_detects_cf_end_rules():
    log = _clean()
    rts, cts, data, ack = log
    end = max(ack[1] + ack[5], data[1] + data[5])
    cf = (end + AIFS_BE, end + AIFS_BE + C.T_CF_END, 'C', C.BCAST, 'CF-End', 0, None)
    assert rules(log + [cf]) == ['cf_end']                  # non-AP, не держатель TXOP
    assert rules(log + [cf], aps={'C'}) == []
    # держатель: CF-End с Duration ≠ 0 при остатке TXNAV < 2×TCF-End + 2×SIFS
    t_cf = ack[1] + 3

    def with_rem(rem):                                      # Data с Duration: остаток TXNAV в начале CF-End = rem
        return [rts, cts, data[:5] + (t_cf + rem - data[1],) + data[6:], ack]
    cfa = (t_cf, t_cf + C.T_CF_END, 'A', 'B', 'CF-End', C.ceil_us(C.T_CF_END + 3), None)
    assert 30 < 2 * C.T_CF_END + 2 * T.SIFS < 40
    assert rules(with_rem(30) + [cfa]) == ['cf_end_dur']
    assert rules(with_rem(30) + [cfa[:5] + (0, None)]) == []
    assert rules(with_rem(40) + [cfa]) == []


# ---------------- согласованность модели и проверки журнала ----------------
@pytest.mark.parametrize('seed', range(8))
def test_random_sim_log_is_clean(seed):
    import random
    r = random.Random(seed)
    sts = [C.Station(x, rng=C.Rng(seed * 10 + i)) for i, x in enumerate('ABCD')]
    for i, s in enumerate(sts):
        for k in range(5):
            dst = 'ABCD'[(i + 1 + r.randrange(3)) % 4]
            s.enqueue(0, C.Msdu(dst, r.choice([200, 1500, 7000]), r.choice([1, 4, 8, 12]), rts=r.random() < 0.4))
    log = C.Air(sts).run(5000)
    assert sum(len(s.delivered) + len(s.discarded) for s in sts) == 20
    assert C.check_air_log(log) == []


@pytest.mark.parametrize('seed', range(24))
def test_random_sim_options_log_is_clean(seed):
    """Разные AIFSN, лимит TXOP, защита, CF-End, CBAP, политика сбоя не первого PPDU — журнал модели чист."""
    import random
    r = random.Random(1000 + seed)
    cb = None if r.random() < 0.4 else [(0, 400), (500, 1200), (1500, 3000), (3300, 6000)]
    lim = r.choice([0, 0, 500, 2000])
    opts = dict(protection=r.choice(['single', 'multiple']), full_txop=r.random() < 0.5, cf_end=r.random() < 0.5,
                noninitial_failure=r.choice(['backoff', 'txnav']))
    names = 'ABCDE'[:r.randint(2, 5)]
    sts = [C.Station(x, edca={C.AC_BE: C.EdcaParams(15, 1023, r.choice([2, 3]), lim)}, rng=C.Rng(seed * 10 + i),
                     cbaps=cb, **opts) for i, x in enumerate(names)]
    for s in sts:
        for _ in range(r.randint(1, 6)):
            dst = r.choice([n for n in names if n != s.addr] + ['Z'])     # 'Z' — нет в эфире: сбои и повторы
            s.enqueue(0, C.Msdu(dst, r.choice([100, 1500, 7000, 20000]), r.choice([1, 4, 8, 12]),
                                rts=r.random() < 0.4))
    log = C.Air(sts).run(6000)
    aifsn = {s.addr: s.edcafs[C.AC_BE].p.aifsn for s in sts}
    assert C.check_air_log(log, C.LogParams(aifsn=aifsn, txop_limit=lim, cbaps=cb)) == []
