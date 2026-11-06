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


# Management (тип 0, табл. 9-1): подтип → вид для ref/mlme.frame_class (11.3.3)
MGMT = {0: 'Association Request', 1: 'Association Response', 2: 'Reassociation Request', 3: 'Reassociation Response',
        4: 'Probe Request', 5: 'Probe Response', 9: 'ATIM', 10: 'Disassociation', 11: 'Authentication',
        12: 'Deauthentication'}
# Action (подтип 13) / Action No Ack (14): категория (табл. 9-51) класса 1 (11.3.3 a) 2) vi, vii, ix); BRP — Unprotected DMG
ACTION_C1 = {4: 'Public Action', 15: 'Self-protected Action', 20: 'Unprotected DMG Action'}


def _mac(b):
    return ':'.join('%02x' % x for x in b)


def mlme_events(air, t0_clk=0):
    """Air.frames → журнал ref/mlme.check_assoc_log (LogEvent: t мкс, вид, TA, RA, info). Кадры без TA (Ack, DMG CTS
    к держателю и т. п. — класс 1) и маяки пропускаются; QoS Data/QoS Null и A-MPDU — 'Data'; Association Response —
    status/AID из тела (9.3.3.6: Capability 2, Status 2, AID 2), acked — Ack от STA следует (модель эфира без потерь:
    по наличию Ack в пределах 50 мкс)."""
    from ref import mlme as M
    fr = sorted((f for f in air.frames if f['start'] >= t0_clk and not f.get('dropped')), key=lambda f: f['start'])
    out = []
    for i, f in enumerate(fr):
        b = f['frame']
        fc = int.from_bytes(b[:2], 'little')
        typ, sub = (fc >> 2) & 3, (fc >> 4) & 0xf
        ta, ra = _mac(bytes(f['src'].mac)), _mac(b[4:10])
        info = {}
        if typ == 2:
            kind = 'Data'
        elif typ == 0 and sub in MGMT:
            kind = MGMT[sub]
            if sub in (1, 3) and len(b) >= 30:
                info = dict(status=int.from_bytes(b[26:28], 'little'), aid=int.from_bytes(b[28:30], 'little') & 0x3fff,
                            acked=any(int.from_bytes(g['frame'][:2], 'little') == 0x00d4 and g['frame'][4:10] ==
                                      bytes(f['src'].mac) and g['start'] - f['end'] < 50 * CLK for g in fr[i + 1:i + 4]))
            if sub in (10, 12) and len(b) >= 26:
                info = dict(reason=int.from_bytes(b[24:26], 'little'))
        elif typ == 0 and sub in (13, 14):
            kind = 'BRP' if sub == 14 else ACTION_C1.get(b[24] if len(b) > 24 else -1, 'Action')
        elif typ == 1 and sub in (8, 9):
            kind = CTL[sub]
        else:
            continue
        out.append(M.LogEvent(Fr(f['start'], CLK), kind, ta, ra, info))
    return out


def check(air, t0_clk=0, **params):
    """Нарушения правил доступа (cbap.check_air_log) в журнале эфира эмуляции."""
    ev = events(air, t0_clk)
    v = cbap.check_air_log(ev, cbap.LogParams(**params))
    return ev, v
