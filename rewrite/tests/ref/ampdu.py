# SPDX-License-Identifier: AGPL-3.0-or-later
"""A-MPDU DMG по 802.11-2020: формат (9.7.1 [p. 1612–1614], рис. 9-971, 9-973, 9-975, табл. 9-528 — разделитель DMG:
Reserved 3 бита, MPDU Length 13 бит, CRC 8, Delimiter Signature 0x4E; паддинг неконечных подкадров до 4 октетов,
конечный — без паддинга, EOF Padding у DMG нет), CRC разделителя (9.7.2 [p. 1615], рис. 9-977: x^8 + x^2 + x + 1,
регистр — единицы, результат — дополнение), предел длины (9.7.1: 262 143 октета; 10.12.2 [p. 1719]: не длиннее Maximum
A-MPDU Length Exponent DMG Capabilities получателя, табл. 9-251), Minimum MPDU Start Spacing (10.12.3 [p. 1720]:
t_MMSS·r/8 октетов между началами MPDU, r — скорость табл. 20-15; паддинг — разделители с MPDU Length 0; QoS Null DMG
от правила освобождён), групповой RA (10.12.4 [p. 1721]: DMG STA может; пределы — минимум/максимум по всем связанным).

Не моделируется: A-MPDU в control mode (MCS 0) и low-power SC — паддинг по их скорости (r табл. 20-21) не нужен
прошивке; S-MPDU/EOF (только VHT/S1G); содержимое A-MPDU по контексту (табл. 9-530) — amsdu/blockack."""
from collections import namedtuple
from fractions import Fraction as Fr
from math import ceil

from . import elements as E
from .timing import SC_MCS, aPSDUMaxLength

DELIM_SIG = 0x4E                 # табл. 9-528: «The unique pattern is 0x4E»
DELIM_LEN = 4                    # рис. 9-973
DMG_MPDU_LEN_MAX = (1 << 13) - 1  # табл. 9-528: MPDU Length — 13 бит
DMG_AMPDU_MAX = 262143           # 9.7.1: «The maximum length of an A-MPDU in a DMG PPDU is 262 143 octets»
assert DMG_AMPDU_MAX == aPSDUMaxLength
# табл. 20-15: расширенные SC MCS (N_CBPS, ρ, R) — для скорости r в 10.12.3
EXT_SC_MCS = {'9.1': (2, 1, Fr(7, 8)), '12.1': (4, 1, Fr(13, 16)), '12.2': (4, 1, Fr(7, 8)), '12.3': (6, 1, Fr(5, 8)),
              '12.4': (6, 1, Fr(3, 4)), '12.5': (6, 1, Fr(13, 16)), '12.6': (6, 1, Fr(7, 8))}


def sc_rate(mcs):
    """Скорость данных DMG SC MCS, Мб/с (табл. 20-15): 1760·448/512·N_CBPS·R/ρ = 1540·N_CBPS·R/ρ."""
    n, rho, r = SC_MCS[mcs] if mcs in SC_MCS else EXT_SC_MCS[str(mcs)]
    return Fr(1540) * n * r / rho


def crc8(bits16):
    """9.7.2: CRC 16 бит B0…B15 разделителя (B0 первым): регистр c0…c7 = 1, обратная связь — c7 ⊕ вход, многочлен
    x^8 + x^2 + x + 1; результат — дополнение до единиц, C7 → B16 (рис. 9-977). Возвращает значение поля CRC
    (B16 — младший бит)."""
    c = 0xFF
    for i in range(16):
        fb = (c >> 7 & 1) ^ (bits16 >> i & 1)
        c = (c << 1) & 0xFF
        if fb:
            c ^= 0x07
    c ^= 0xFF
    return sum((c >> (7 - k) & 1) << k for k in range(8))       # C7 первым → B16 (младший бит поля)


Delim = namedtuple('Delim', 'rsv length crc sig')


def encode_delim(length, rsv=0):
    if not 0 <= length <= DMG_MPDU_LEN_MAX:
        raise ValueError(f'MPDU Length {length} не помещается в 13 бит (табл. 9-528)')
    w = rsv & 7 | length << 3
    return (w | crc8(w) << 16 | DELIM_SIG << 24).to_bytes(4, 'little')


def parse_delim(b):
    w = int.from_bytes(bytes(b[:4]), 'little')
    return Delim(w & 7, w >> 3 & DMG_MPDU_LEN_MAX, w >> 16 & 0xFF, w >> 24)


def check_delim(d):
    v = []
    if d.sig != DELIM_SIG:
        v.append(f'Delimiter Signature 0x{d.sig:02x} ≠ 0x4E (табл. 9-528)')
    if d.crc != crc8(d.rsv | d.length << 3):
        v.append('CRC разделителя не сходится (9.7.2)')
    if d.rsv:
        v.append('Reserved B0–B2 разделителя DMG ≠ 0 (рис. 9-975, 9.2.2)')
    return v


def pad4(n):
    return (-n) % 4


def mmss_octets(spacing_code, mcs):
    """10.12.3: минимум октетов между началами двух MPDU = t_MMSS·r/8 (t — мкс, табл. 9-251 в нс; r — Мб/с)."""
    t_us = Fr(E.MIN_MPDU_SPACING_NS[spacing_code], 1000)
    return ceil(t_us * sc_rate(mcs) / 8)


def build(mpdus, mcs=None, spacing_code=0, qos_null=()):
    """Список MPDU (bytes, с FCS) → A-MPDU DMG. Разделители с MPDU Length 0 — перед MPDU, если от начала предыдущего
    меньше mmss_octets; перед QoS Null — не нужны (10.12.3). qos_null — индексы MPDU-QoS Null. Последний подкадр без
    паддинга (9.7.1)."""
    need = mmss_octets(spacing_code, mcs) if spacing_code else 0
    out = bytearray()
    prev = None
    for k, m in enumerate(mpdus):
        if prev is not None and k not in qos_null:
            while len(out) - prev < need:
                out += encode_delim(0)                  # подкадр без MPDU — 4 октета, кратен 4
        prev = len(out) + DELIM_LEN                     # начало MPDU «measured at the PHY SAP»
        out += encode_delim(len(m)) + bytes(m)
        if k != len(mpdus) - 1:
            out += bytes(pad4(len(m)))
    return bytes(out)


Sub = namedtuple('Sub', 'offset delim mpdu')


def parse(psdu):
    """A-MPDU → [Sub]; разделитель с Length 0 — mpdu None. Обрыв — ValueError."""
    b = bytes(psdu)
    out, i = [], 0
    while i < len(b):
        if i + DELIM_LEN > len(b):
            raise ValueError(f'обрезанный разделитель на смещении {i}')
        d = parse_delim(b[i:i + DELIM_LEN])
        j = i + DELIM_LEN + d.length
        if j > len(b):
            raise ValueError(f'MPDU на смещении {i} длиной {d.length} выходит за конец A-MPDU')
        out.append(Sub(i, d, b[i + DELIM_LEN:j] if d.length else None))
        i = j + (pad4(d.length) if j < len(b) else 0)
    return out


def check(psdu, mcs, rx_caps=None, qos_null_at=None, group=False, all_caps=()):
    """Нарушения A-MPDU DMG: разделители, паддинг (последний без паддинга), предел длины (9.7.1, 10.12.2), спейсинг
    (10.12.3). rx_caps — DmgCapabilities получателя; при group — пределы по всем связанным all_caps (10.12.4).
    qos_null_at(mpdu) → True для QoS Null (не подчиняется спейсингу)."""
    v = []
    lim, code = _limits(rx_caps, group, all_caps)
    if len(psdu) > DMG_AMPDU_MAX:
        v.append(f'A-MPDU {len(psdu)} октетов > 262 143 (9.7.1)')
    if lim is not None and len(psdu) > lim:
        v.append(f'A-MPDU {len(psdu)} октетов > Maximum A-MPDU Length получателя {lim} (10.12.2, табл. 9-251)')
    try:
        subs = parse(psdu)
    except ValueError as x:
        return v + [str(x)]
    for s in subs:
        v += [f'@{s.offset}: {m}' for m in check_delim(s.delim)]
    last = subs[-1] if subs else None
    if last is not None and last.offset + DELIM_LEN + last.delim.length != len(psdu):
        v.append('после последнего подкадра лишние октеты: в DMG PPDU последний подкадр без паддинга и EOF Padding '
                 'нет (9.7.1)')
    if code and mcs is not None:
        need = mmss_octets(code, mcs)
        starts = [(s.offset + DELIM_LEN, s.mpdu) for s in subs if s.mpdu is not None]
        for (a, _), (b, m) in zip(starts, starts[1:]):
            if b - a < need and not (qos_null_at and qos_null_at(m)):
                v.append(f'MPDU @{b}: от начала предыдущего {b - a} < {need} октетов (10.12.3: Minimum MPDU Start '
                         f'Spacing {E.MIN_MPDU_SPACING_NS[code]} нс на MCS {mcs})')
    return v


def _limits(rx_caps, group, all_caps):
    if group and all_caps:
        exp = min(c.sta_cap['max_ampdu_len_exp'] for c in all_caps)
        code = max(c.sta_cap['min_mpdu_start_spacing'] for c in all_caps)
        return 2 ** (13 + exp) - 1, code
    if rx_caps is None:
        return None, 0
    return E.max_ampdu_length(rx_caps.sta_cap), rx_caps.sta_cap['min_mpdu_start_spacing']


def length_limit(rx_caps=None, group=False, all_caps=()):
    """Предел длины A-MPDU (октеты) для получателя (10.12.2) или группы (10.12.4: минимум по связанным)."""
    lim, _ = _limits(rx_caps, group, all_caps)
    return min(DMG_AMPDU_MAX, lim) if lim is not None else DMG_AMPDU_MAX
