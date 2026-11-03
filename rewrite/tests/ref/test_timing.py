# SPDX-License-Identifier: AGPL-3.0-or-later
"""Эталонные TXTIME и IFS: примеры стандарта и сверка с моделью MAC эмулятора (tests/unit/machw.py)."""
import os
import sys
from fractions import Fraction as Fr

import pytest

from . import timing as T

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'unit'))


def test_control_ncw_standard_example():
    """20.4.3.3.3 NOTE: Length = 128 → NCW = 7."""
    assert T.control_ncw(128) == 7


def test_ifs_values():
    assert T.MBIFS == 9                                     # 3·aSIFSTime
    assert T.aifs(3) == 18                                  # AIFSN 3 (AC_BE по умолчанию): 3·5 + 3
    assert T.BRPIFS_MAX == 44


@pytest.mark.parametrize('length', [14, 20, 26, 28, 40, 100, 128, 255])
def test_control_txtime_matches_machw(length):
    import machw
    assert T.us_to_clk(T.txtime_control(length)) == machw.ctrl_txtime_clk(length)


@pytest.mark.parametrize('mcs', range(1, 13))
@pytest.mark.parametrize('length', [14, 32, 100, 1534, 7000, 65535])
def test_sc_txtime_matches_machw(mcs, length):
    import machw
    if not hasattr(machw, 'sc_txtime_clk'):
        pytest.skip('machw без sc_txtime_clk')
    assert T.us_to_clk(T.txtime_sc(length, mcs)) == machw.sc_txtime_clk(length, mcs)


def test_sc_ncw_formula():
    """20.5.3.2.3.3 a): Length 1000, LCW 672, R 1/2 — MCS 2 (ρ = 1): ⌈8000 / 336⌉ = 24; MCS 1 (ρ = 2): ⌈8000 / 168⌉ = 48."""
    assert (T.sc_ncw(1000, 2), T.sc_ncw(1000, 1)) == (24, 48)
