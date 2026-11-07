# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/sectorpat: Antenna Sector ID Pattern (9.4.2.156, рис. 9-604…9-606)."""
import pytest

from . import elements as E
from . import sectorpat as S

TAP6 = 0b110000          # x^6 + x^5 + 1 — максимальная длина (63)
TAP8 = 0b10111000        # максимальная длина (255)


def test_codec_fig_9_604():
    p = S.Pattern(0, TAP6, 5, TAP8, 0x5a)
    el = S.encode(p)
    assert el[:2] == bytes([190, 4]) and S.parse(el[2:]) == p
    with pytest.raises(ValueError):
        S.parse(b'\x00\x00\x00')


def test_lfsr_maximal_note_1_2():
    assert S.period(1, TAP6, 6) == 63 and S.is_maximal(TAP6, 6)
    assert S.is_maximal(TAP8, 8)
    assert not S.is_maximal(0b000011, 6)


def test_sequence_two_periods_then_zero_then_gen2():
    p = S.Pattern(0, TAP6, 5, TAP8, 0x5a)
    seq = S.sectors(p, 64, 130)
    assert seq[0] == 5                                       # первый маяк — State 1
    assert seq[63] == 5 and seq[126] == 0                    # возврат через период; после второго — нулевое состояние
    g2 = S.lfsr_step(0x5a, TAP8, 8)
    assert seq[127] == (g2 & 63 or S.lfsr_step(g2, TAP8, 8) & 63)     # новое начальное — 6 бит генератора 2
    assert sorted(set(seq[:63])) == list(range(1, 64))       # все ненулевые состояния за период


def test_skip_states_beyond_sector_count():
    p = S.Pattern(0, TAP6, 5, TAP8, 0x5a)
    seq = S.sectors(p, 16, 40)
    assert all(x < 16 for x in seq)
    full = [x for x in S.sectors(p, 64, 200) if x < 16]
    assert seq == full[:40]


def test_checks_and_beacon_series():
    assert S.check(S.Pattern(0, TAP6, 5, TAP8, 1), E.PROBE_RESP) == []
    assert S.check(S.Pattern(1, TAP6, 5, TAP8, 1))                 # Type 1 — Reserved
    assert S.check(S.Pattern(0, 0, 0, 0, 0))                        # Tap 1 = 0
    assert S.check(S.Pattern(0, TAP6, 5, TAP8, 1), 'DMG Beacon')    # не в Probe Response / PSC-RSP
    p = S.Pattern(0, TAP6, 5, TAP8, 1)
    want = S.sectors(p, 32, 10)
    assert S.check_beacons(p, 32, want) == []
    assert len(S.check_beacons(p, 32, list(range(10)))) > 0
