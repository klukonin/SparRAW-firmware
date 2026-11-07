# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/tsf: Timestamp (9.4.1.10) и TSF (11.1.3.1) — проверяемая без внешней опоры часть."""
from fractions import Fraction as Fr

from . import tsf as T

BI_US = 102400


def test_modulus_2_64():
    assert T.tsf_diff((1 << 64) - 10, 5) == 15
    assert T.tsf_diff(5, (1 << 64) - 10) == -15


def test_monotonic():
    seq = [(0, 1000), (100, 1100), (200, 1200)]
    assert T.check_monotonic(seq) == []
    assert T.check_monotonic([(0, 1000), (100, 900)])              # TSF назад
    assert T.check_monotonic([(0, 1000), (100, 1000)])             # стоит


def test_deltas_vs_peer_rx_stamps_with_drift():
    # пир: метки RX в своей TSF; уход 40 ppm за BI (4 мкс) — допустим, 10 мкс — нет
    assert T.check_deltas([(5000, 1000), (5000 + BI_US + 4, 1000 + BI_US)]) == []
    assert T.check_deltas([(5000, 1000), (5000 + BI_US + 12, 1000 + BI_US)])
    # внутри BTI (два маяка через 21 мкс) — только квант
    assert T.check_deltas([(5000, 1000), (5021, 1021)]) == []
    assert T.check_deltas([(5000, 1000), (5025, 1021)])


def test_tbtt_offset_11_1_3_3_1():
    pre = Fr(5)
    assert T.check_tbtt_offset(10 * BI_US + 5, 100, pre) is None
    assert T.check_tbtt_offset(10 * BI_US + 1, 100, pre)           # Timestamp раньше конца преамбулы после TBTT


def test_same_point_and_anchor():
    assert T.check_same_point([(1005, 1000), (2005, 2000)]) == []
    assert T.check_same_point([(1005, 1000), (2010, 2000)])
    assert T.check_anchor(10002, Fr(10000), Fr(2), Fr(1)) is None
    assert T.check_anchor(0, Fr(10000), Fr(2), Fr(1))              # Timestamp 0 — не TSF
