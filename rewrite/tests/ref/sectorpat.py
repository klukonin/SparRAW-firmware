# SPDX-License-Identifier: AGPL-3.0-or-later
"""Antenna Sector ID Pattern по 802.11-2020: элемент 9.4.2.156 [p. 1275] (рис. 9-604: Element ID 190, Length, Type 4
бита — 0 «Random Sequence Generator», 1–3 Reserved; Tap 1 6 бит, State 1 6 бит, Tap 2 8 бит, State 2 8 бит), генераторы
последовательности секторов DMG Beacon (рис. 9-605 — 6-разрядный, рис. 9-606 — 8-разрядный регистр сдвига с обратной
связью по отводам; NOTE 1/2: отводы — из последовательностей максимальной длины), применение — Probe Response и PSC-RSP
точки (табл. 9-39 строка 57, табл. 9-459; 11.2.7.1 [p. 2112]: STA в энергосбережении может просыпаться только к маякам
нужного сектора, 11.2.7.2.4).

Правила генератора 1 (9.4.2.156): инициализация Tap 1/State 1; сдвиг на каждый ожидаемый DMG Beacon; «if the next
state equals the initial state for the second time, overwrite the state with an all-zero state. The next state
following … all zero-state uses the first 6 bits of the state of Sequence Generator 2 as the initial state»; при числе
секторов, не равном периоду, состояния ≥ числа секторов пропускаются. Генератор 2 сдвигается, когда нужно новое
начальное состояние.

Принято (PLAN.md №102): регистр Фибоначчи — новый бит на входе ячейки 0 = XOR(Tap_i · ячейка_i), ячейки сдвигаются
0 → 5 (7); бит i поля State/Tap — ячейка i; номер сектора = значение состояния (бит i — ячейка i, «State 1 (= Sector
ID)», рис. 9-605); первый маяк после элемента — сектор State 1; «initial state for the second time» — второй возврат к
начальному состоянию (два полных периода, затем нулевое состояние — сектор 0); генератор 2 сдвигается перед взятием
бит 0–5; нулевое начальное состояние из генератора 2 (регистр застрял бы в нуле) — берётся следующее. Энергосбережения
в open нет — элемент не нужен; если наша точка его передаёт, маяки должны следовать последовательности (судья).

Нарушения — список строк."""
from collections import namedtuple

from . import elements as E

EID_ASID_PATTERN = E.EID_ANTENNA_SECTOR_ID_PATTERN       # 190
ASID_LEN = 4
TYPE_RSG = 0

Pattern = namedtuple('Pattern', 'type tap1 state1 tap2 state2')


def encode(p):
    if p.type >> 4 or p.tap1 >> 6 or p.state1 >> 6 or p.tap2 >> 8 or p.state2 >> 8:
        raise ValueError('Antenna Sector ID Pattern: поле вне рис. 9-604')
    v = p.type | p.tap1 << 4 | p.state1 << 10 | p.tap2 << 16 | p.state2 << 24
    return E.encode_element(EID_ASID_PATTERN, v.to_bytes(4, 'little'))


def parse(info):
    if len(info) != ASID_LEN:
        raise ValueError(f'Antenna Sector ID Pattern: Length {len(info)} ≠ 4 (рис. 9-604)')
    v = int.from_bytes(info, 'little')
    return Pattern(v & 15, v >> 4 & 63, v >> 10 & 63, v >> 16 & 255, v >> 24 & 255)


def lfsr_step(state, taps, n):
    """Один сдвиг регистра Фибоначчи n разрядов (рис. 9-605/9-606; PLAN.md №102)."""
    fb = bin(state & taps).count('1') & 1
    return ((state << 1) | fb) & ((1 << n) - 1)


def period(state, taps, n):
    """Период последовательности из состояния (None — не возвращается за 2^n шагов)."""
    s = state
    for k in range(1, (1 << n) + 1):
        s = lfsr_step(s, taps, n)
        if s == state:
            return k
    return None


def is_maximal(taps, n):
    """NOTE 1/2: отводы с максимальной длиной — период 2^n − 1 из ненулевого состояния."""
    return period(1, taps, n) == (1 << n) - 1


def sectors(p, n_sectors, count):
    """Первые count номеров секторов DMG Beacon по элементу p (9.4.2.156)."""
    out = []
    init, s, returns = p.state1, p.state1, 0
    g2 = p.state2
    first = True
    steps = 0
    while len(out) < count:
        steps += 1
        if steps > 1024 * (count + 1) or n_sectors <= 0:
            raise ValueError('последовательность не даёт секторов < числа секторов (9.4.2.156)')
        if first:
            first = False
            cand = s
        else:
            if s == 0 and returns >= 2:
                # после нулевого состояния — новое начальное из генератора 2
                for _ in range(256):
                    g2 = lfsr_step(g2, p.tap2, 8)
                    if g2 & 63:
                        break
                init = s = g2 & 63
                returns = 0
                cand = s
            else:
                s = lfsr_step(s, p.tap1, 6)
                if s == init:
                    returns += 1
                    if returns >= 2:
                        s = 0
                cand = s
        if cand < n_sectors:
            out.append(cand)
    return out


def check(p, frame_kind=None):
    v = []
    if p.type != TYPE_RSG:
        v.append(f'Antenna Sector ID Pattern: Type {p.type} — Reserved (9.4.2.156: 0 — Random Sequence Generator)')
    if p.tap1 and not is_maximal(p.tap1, 6):
        v.append(f'Tap 1 0x{p.tap1:02x}: не последовательность максимальной длины (9.4.2.156 NOTE 1)')
    if p.tap2 and not is_maximal(p.tap2, 8):
        v.append(f'Tap 2 0x{p.tap2:02x}: не последовательность максимальной длины (9.4.2.156 NOTE 2)')
    if not p.tap1:
        v.append('Tap 1 = 0 — генератор 1 не меняет состояние')
    if frame_kind is not None and frame_kind not in (E.PROBE_RESP, 'Power Save Configuration Response'):
        v.append(f'Antenna Sector ID Pattern в {frame_kind} — элемент предусмотрен в Probe Response и PSC-RSP '
                 f'(табл. 9-39, 9-459; 11.2.7.1)')
    return v


def check_beacons(p, n_sectors, observed):
    """observed — номера секторов DMG Beacon точки по порядку после элемента. → [(индекс, текст)]."""
    try:
        want = sectors(p, n_sectors, len(observed))
    except ValueError as x:
        return [(0, str(x))]
    return [(i, f'DMG Beacon {i}: сектор {o} ≠ {w} по Antenna Sector ID Pattern (9.4.2.156)')
            for i, (o, w) in enumerate(zip(observed, want)) if o != w]
