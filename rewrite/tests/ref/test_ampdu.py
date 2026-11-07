# SPDX-License-Identifier: AGPL-3.0-or-later
"""A-MPDU DMG: разделитель (9.7.1 [p. 1613], рис. 9-975, табл. 9-528), CRC (9.7.2 [p. 1615]), паддинг и пределы
(9.7.1, 10.12.2–10.12.4 [p. 1719–1721]), скорость табл. 20-15 [p. 2983]."""
from fractions import Fraction as Fr

import pytest

from . import ampdu as A
from . import elements as E


def caps(exp=5, spacing=0):
    sc = {n: 0 for n, _ in E.DMG_STA_CAP}
    sc.update(max_ampdu_len_exp=exp, min_mpdu_start_spacing=spacing)
    return E.DmgCapabilities('02:00:00:00:00:01', 1, sc, {n: 0 for n, _ in E.DMG_AP_PCP_CAP}, 0,
                             {n: 0 for n, _ in E.EXT_SC_MCS}, 0, 0)


def test_crc_zero_length_delimiter():
    """9.7.2, рис. 9-977: x^8 + x^2 + x + 1, регистр — единицы, дополнение. Разделитель без MPDU (Length 0) — CRC
    0x14, октеты 00 00 14 4E (та же схема, что у разделителя HT)."""
    assert A.crc8(0) == 0x14
    assert A.encode_delim(0) == bytes([0, 0, 0x14, 0x4E])
    d = A.parse_delim(A.encode_delim(1234))
    assert d.length == 1234 and d.sig == 0x4E and A.check_delim(d) == []


def test_crc_detects_single_bit_errors():
    for n in (1, 100, 8191):
        w = n << 3
        c = A.crc8(w)
        assert all(A.crc8(w ^ (1 << b)) != c for b in range(16))


def test_delimiter_layout_dmg():
    """Рис. 9-975: B0–B2 Reserved, B3–B15 MPDU Length (13 бит), B16–B23 CRC, B24–B31 0x4E."""
    b = A.encode_delim(8191)
    assert int.from_bytes(b, 'little') >> 3 & 0x1FFF == 8191
    with pytest.raises(ValueError):
        A.encode_delim(8192)
    d = A.parse_delim(A.encode_delim(5, rsv=1))
    assert any('Reserved' in m for m in A.check_delim(d))
    bad = A.parse_delim(A.encode_delim(5)[:3] + b'\x4f')
    assert any('0x4E' in m for m in A.check_delim(bad))


@pytest.mark.parametrize('mcs,rate', [(1, 385), (2, 770), (3, Fr(9625, 10)), (4, 1155), (5, Fr(125125, 100)),
                                      (6, 1540), (7, 1925), (8, 2310), (9, Fr(25025, 10)), ('9.1', 2695), (10, 3080),
                                      (11, 3850), (12, 4620), ('12.1', 5005), ('12.2', 5390), ('12.3', 5775),
                                      ('12.4', 6930), ('12.5', Fr(75075, 10)), ('12.6', 8085)])
def test_rate_table_20_15(mcs, rate):
    assert A.sc_rate(mcs) == rate


def test_mmss_octets_formula():
    """10.12.3: t_MMSS·r/8 — 1024 нс (код 7, табл. 9-251) на MCS 12 (4620 Мб/с) = 591,36 → не меньше 592 октетов."""
    assert A.mmss_octets(7, 12) == 592
    assert A.mmss_octets(0, 12) == 0
    assert A.mmss_octets(1, 1) == 1                       # 16 нс · 385 / 8 = 0,77 → 1


def test_build_parse_padding_last_unpadded():
    """9.7.1: неконечные подкадры кратны 4, конечный без паддинга (DMG), EOF Padding нет."""
    m = [bytes(37), bytes(40), bytes(9)]
    b = A.build(m)
    assert len(b) == (4 + 37 + 3) + (4 + 40) + (4 + 9)
    subs = A.parse(b)
    assert [s.offset for s in subs] == [0, 44, 88] and [len(s.mpdu) for s in subs] == [37, 40, 9]
    assert A.check(b, 4) == []
    assert any('последнего подкадра' in m for m in A.check(b + bytes(3), 4))


def test_spacing_padding_and_qos_null_exception():
    m = [bytes(30), bytes(30), bytes(30)]
    b = A.build(m, mcs=12, spacing_code=7)
    starts = [s.offset + 4 for s in A.parse(b) if s.mpdu is not None]
    assert all(y - x >= 592 for x, y in zip(starts, starts[1:]))
    assert any(s.mpdu is None for s in A.parse(b))        # разделители с MPDU Length 0
    rx = caps(spacing=7)
    assert A.check(b, 12, rx_caps=rx) == []
    assert any('10.12.3' in v for v in A.check(A.build(m), 12, rx_caps=rx))
    # QoS Null DMG не подчиняется спейсингу
    b2 = A.build(m[:1] + [b'N' * 30], mcs=12, spacing_code=7, qos_null=(1,))
    assert A.check(b2, 12, rx_caps=rx, qos_null_at=lambda x: x[:1] == b'N') == []


def test_length_limits():
    """Табл. 9-251: 2^(13+exp) − 1; 9.7.1: 262 143; 10.12.4: групповой — минимум по связанным."""
    assert A.length_limit(caps(0)) == 8191 and A.length_limit(caps(5)) == 262143 == A.DMG_AMPDU_MAX
    big = A.build([bytes(4000), bytes(4000), bytes(300)])
    assert any('Maximum A-MPDU Length' in v for v in A.check(big, 4, rx_caps=caps(0)))
    assert A.check(big, 4, rx_caps=caps(1)) == []
    assert A.length_limit(group=True, all_caps=[caps(3), caps(1)]) == 2 ** 14 - 1
    assert A.check(big, 4, group=True, all_caps=[caps(3), caps(0)])
