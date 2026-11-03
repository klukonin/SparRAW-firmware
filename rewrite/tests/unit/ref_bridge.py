# SPDX-License-Identifier: AGPL-3.0-or-later
"""Мост эмулятор → эталон (tests/ref): журнал кадров модели эфира (air.Air.frames) в события cbap.check_air_log.

Вид кадра — по Frame Control (802.11-2020 9.2.4.1.3, табл. 9-1: тип/подтип; Control Frame Extension — подтип 6,
расширение FC [11:8], табл. 9-2). Время — такты 165 МГц → мкс (Fraction). Отправитель — узел, получатель — RA (A1)."""
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from ref import cbap                                              # noqa: E402

CLK = 165
# Control Frame Extension (табл. 9-2): значение поля Control Frame Extension → вид
CTL_EXT = {2: 'Poll', 3: 'SPR', 4: 'Grant', 5: 'DMG CTS', 6: 'DMG DTS', 7: 'Grant Ack', 8: 'SSW', 9: 'SSW-Feedback',
           10: 'SSW-Ack'}
# Control (тип 1): подтип → вид
CTL = {8: 'BlockAckReq', 9: 'BlockAck', 11: 'RTS', 12: 'CTS', 13: 'Ack', 14: 'CF-End'}


def kind_of(frame, mpdus=None):
    fc = int.from_bytes(frame[:2], 'little')
    typ, sub = (fc >> 2) & 3, (fc >> 4) & 0xf
    if typ == 3 and sub == 0:
        return 'DMG Beacon'
    if typ == 1 and sub == 6:
        return CTL_EXT.get((fc >> 8) & 0xf, 'CTL-EXT %d' % ((fc >> 8) & 0xf))
    if typ == 1:
        return CTL.get(sub, 'CTL %d' % sub)
    if typ == 2:
        return 'A-MPDU' if mpdus else 'Data'
    if typ == 0:
        return 'Mgmt' if not (sub == 14) else 'BRP'          # Action No Ack (BRP) — подтип 14
    return 'type %d' % typ


def events(air, t0_clk=0):
    """Air.frames (начиная с t0_clk) → [(t_start_us, t_end_us, src, dst, kind, duration_us, cbap_end)]."""
    out = []
    for f in air.frames:
        if f['start'] < t0_clk:
            continue
        fr = f['frame']
        out.append((Fr(f['start'], CLK), Fr(f['end'], CLK), bytes(f['src'].mac), bytes(fr[4:10]),
                    kind_of(fr, f['mpdus']), int.from_bytes(fr[2:4], 'little'), None))
    return out


def check(air, t0_clk=0, **params):
    """Нарушения правил доступа (cbap.check_air_log) в журнале эфира эмуляции."""
    ev = events(air, t0_clk)
    v = cbap.check_air_log(ev, cbap.LogParams(**params))
    return ev, v
