# SPDX-License-Identifier: AGPL-3.0-or-later
"""Поле Timestamp и TSF по 802.11-2020: 9.4.1.10 [p. 880] (TSF источника кадра, 8 октетов), 11.1.3.1 [p. 2050]
(«Each STA shall maintain a TSF timer with modulus 2^64 counting in increments of microseconds»; DMG Beacon, Announce,
Timing Advertisement, Probe Response: Timestamp = TSF «at the time that the start of the data symbol containing the
first bit of the frame appears at the transmit antenna connector»), TBTT — кратные dot11BeaconPeriod (11.1.3.3.1:
BTI начинается в TBTT), точность TSF DMG ± aDMGTSFAccuracy (20 ppm, табл. 11-22, 11.1.3.9).

Что проверяемо без внешней опоры времени (сама точка «начало символа данных» относительно антенны — нет; см.
air_judge NOT_CHECKABLE timestamp_point):
  check_monotonic   — Timestamp кадров одного источника растёт вместе со временем эфира (модуль 2^64);
  check_deltas      — разности Timestamp равны разностям моментов, измеренных независимо (метки RX пира в его TSF;
                      допуск — квант двух меток + уход часов 2·aDMGTSFAccuracy);
  check_tbtt_offset — первый DMG Beacon BI: Timestamp − TBTT ≥ преамбула + заголовок control PHY (PPDU не раньше TBTT,
                      11.1.3.3.1, а Timestamp — начало символа данных, 11.1.3.1): меньше — нарушено одно из двух;
  check_same_point  — у кадров одного класса модуляции разность (Timestamp − метка TX) одна и та же: одна точка 11.1.3.1
                      для всех кадров с Timestamp (маяки control; Probe Response/Announce SC);
  check_anchor      — Timestamp кадра точки против времени эфира в её же TSF: ≈ начало PPDU + преамбула и заголовок
                      класса (допуск — квант и неопределённость точки метки).
Принято: PLAN.md №109.
Нарушения — [(индекс, текст)]."""
from fractions import Fraction as Fr

from .timing import aDMGTSFAccuracy, TU

TSF_MOD = 1 << 64
STAMP_Q = Fr(1)             # квант метки TSF (целые мкс): разность двух меток — до ±1 мкс


def tsf_diff(a, b):
    """b − a по модулю 2^64 (знаковая разность в пределах половины модуля)."""
    d = (b - a) % TSF_MOD
    return d - TSF_MOD if d >= TSF_MOD // 2 else d


def tbtt_of(ts, bi_tu):
    """TBTT BI, к которому относится Timestamp (кратные dot11BeaconPeriod·TU от TSF 0)."""
    bi = bi_tu * TU
    return ts - ts % int(bi)


def check_monotonic(seq):
    """seq — [(момент эфира, Timestamp)] кадров одного источника по времени. Timestamp не убывает быстрее эфира:
    ts_j − ts_i ≥ (t_j − t_i) − допуск."""
    v = []
    for i in range(1, len(seq)):
        (t0, s0), (t1, s1) = seq[i - 1], seq[i]
        dt, ds = t1 - t0, tsf_diff(s0, s1)
        tol = 2 * STAMP_Q + abs(dt) * Fr(2 * aDMGTSFAccuracy, 10 ** 6)
        if ds < dt - tol or ds <= 0 < dt:
            v.append((i, f'Timestamp {s1} после {s0}: разность {ds} мкс при {float(dt):.1f} мкс эфира — TSF «counting '
                         f'in increments of microseconds» (11.1.3.1)'))
    return v


def check_deltas(seq, tol=None):
    """seq — [(независимый момент, Timestamp)] (метки RX пира в его TSF). |Δts − Δt| ≤ 2 кванта + уход часов."""
    v = []
    for i in range(1, len(seq)):
        (t0, s0), (t1, s1) = seq[i - 1], seq[i]
        dt, ds = t1 - t0, tsf_diff(s0, s1)
        lim = (tol if tol is not None else 2 * STAMP_Q) + abs(dt) * Fr(2 * aDMGTSFAccuracy, 10 ** 6)
        if abs(ds - dt) > lim:
            v.append((i, f'разность Timestamp {ds} мкс ≠ разности приёма {float(dt):.2f} мкс (допуск {float(lim):.2f}) '
                         f'— Timestamp не TSF источника на моменте передачи (9.4.1.10, 11.1.3.1)'))
    return v


def check_tbtt_offset(ts, bi_tu, pre_us):
    """Первый DMG Beacon BI: Timestamp − TBTT ≥ pre_us − квант. → текст нарушения или None."""
    off = ts - tbtt_of(ts, bi_tu)
    if off < pre_us - STAMP_Q:
        return (f'Timestamp первого DMG Beacon BI на {off} мкс после TBTT < преамбулы и заголовка control PHY '
                f'{float(pre_us):.2f} мкс: либо BTI начат раньше TBTT (11.1.3.3.1), либо Timestamp не на начале '
                f'символа данных (11.1.3.1)')
    return None


def check_same_point(seq):
    """seq — [(Timestamp, метка TX)] кадров одного класса модуляции одного передатчика. Разность одна (± квант)."""
    if not seq:
        return []
    base = seq[0][0] - seq[0][1]
    return [(i, f'Timestamp − метка TX = {ts - st} ≠ {base} у первого кадра того же класса — точка Timestamp '
                f'(11.1.3.1) не одна для всех кадров')
            for i, (ts, st) in enumerate(seq) if abs((ts - st) - base) > STAMP_Q]


def check_anchor(ts, t_air, pre_us, uncert):
    """Кадр источника, время которого t_air (начало PPDU) — в его же TSF: |Timestamp − (t_air + pre_us)| ≤ квант +
    uncert. → текст нарушения или None (Timestamp = 0 или иной TSF — нарушение 9.4.1.10/11.1.3.1)."""
    d = ts - (t_air + pre_us)
    if abs(d) > STAMP_Q + uncert:
        return (f'Timestamp {ts} ≠ TSF источника на начале символа данных ≈ {float(t_air + pre_us):.1f} (разность '
                f'{float(d):.1f} мкс) — «value of the STA’s TSF timer» (9.4.1.10, 11.1.3.1)')
    return None
