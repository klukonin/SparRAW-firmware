# SPDX-License-Identifier: AGPL-3.0-or-later
"""DMG TSPEC и распределения по DMG ADDTS по 802.11-2020: элемент DMG TSPEC (9.4.2.133 [p. 1251–1253], рис. 9-568…9-571,
табл. 9-260…9-262: DMG Allocation Info, BF Control, Allocation Period, Minimum/Maximum Allocation, Minimum Duration,
Constraint), кадры DMG ADDTS Request/Response (9.6.3.1–9.6.3.3 [p. 1447–1451], табл. 9-347…9-349, 9-351, 9-353: вариант
по Element ID; TS Delay — только при REJECTED_FOR_DELAY_PERIOD; TCLAS — только с TSPEC, TCLAS Processing — при > 1
TCLAS; U-PID — только с TSPEC), DELTS с DMG Allocation Info (9.6.3.4 [p. 1451–1452]), правила 11.4 для DMG [p. 2147–
2165]: распределение — (Source AID, Allocation ID, Destination AID); Allocation ID ≠ 0 в запросе и при успехе, 0 — при
неудаче (9.4.2.133); LP SC Used — только если получатель поддерживает low-power SC (11.4.1); не-DMG STA не шлёт DMG
TSPEC; ответ точки — источнику и получателю (11.4.4.4); U-PID в ответе — только если был в запросе, при SUCCESS — тот же
(11.4.4.4); после SUCCESS — распределение в Extended Schedule (11.4.4.4, 10.39.6); удаление (11.4.9.2: точка шлёт DELTS
второй стороне, если её AID не broadcast; разассоциация — локальное удаление); форматы распределений (11.4.13:
изохронное — сумма за период ≥ Minimum Allocation, каждое SP ≥ Minimum Duration; асинхронное — период кратен BI).

СПОРНО → принято (PLAN.md №71): вариант ADDTS Response — по первому элементу после Status Code, кроме TS Delay
(табл. 9-349 называет «sixth field», но TS Delay есть только при REJECTED_FOR_DELAY_PERIOD).
СПОРНО → принято (PLAN.md №72): SUCCESS_STA_IN_PS_MODE (11.4.4.4) = SUCCESS_POWER_SAVE_MODE 85 (табл. 9-50) — PS у нас
удалён: точка этот код не шлёт; в правилах Allocation ID код считается успехом.
Не моделируется: PTP TSPEC (11.4.14 — между non-AP STA), DMG Wakeup Schedule в ADDTS (PS удалён), Multi-band/MMS/U-PID
по содержимому, допуск SME (решение «admit» — вне стандарта), TS timeout (11.4.10)."""
from collections import namedtuple

from . import elements as E
from . import fields as F
from .timing import AID_BROADCAST, ALLOC_CBAP, ALLOC_CBAP_1G08, ALLOC_SP, ALLOC_SP_1G08

CATEGORY_QOS = 1                                           # табл. 9-51
ACT_ADDTS_REQ, ACT_ADDTS_RESP, ACT_DELTS = 0, 1, 2         # табл. 9-347
EID_TSPEC, EID_TCLAS, EID_TS_DELAY, EID_TCLAS_PROC, EID_DMG_TSPEC = 13, 14, 43, 44, 146
EID_UPID = 171
EID_MULTIBAND, EID_MMS, EID_HLSID = 158, 170, 188
SUCCESS, REQUEST_DECLINED, INVALID_PARAMETERS, REJECTED_WITH_SUGGESTED_CHANGES = 0, 37, 38, 39
REJECTED_FOR_DELAY_PERIOD, SUCCESS_POWER_SAVE_MODE, REJECT_UPID_SETTING = 47, 85, 89
SUCCESS_CODES = (SUCCESS, SUCCESS_POWER_SAVE_MODE)        # PLAN.md №72
# рис. 9-569: DMG Allocation Info (32 бита)
ALLOC_INFO = [('allocation_id', 4), ('allocation_type', 3), ('allocation_format', 1), ('pseudo_static', 1),
              ('truncatable', 1), ('extendable', 1), ('lp_sc_used', 1), ('up', 3), ('dst_aid', 8), ('src_aid', 8),
              ('_r31', 1)]
assert E.width(ALLOC_INFO) == 32
ISOCHRONOUS, ASYNCHRONOUS = 1, 0                           # табл. 9-260
ALLOC_TYPES_SP = (ALLOC_SP, ALLOC_SP_1G08)
ALLOC_TYPES = (ALLOC_SP, ALLOC_CBAP, ALLOC_SP_1G08, ALLOC_CBAP_1G08)   # табл. 9-257
DMG_TSPEC_FIXED = 4 + 2 + 2 + 2 + 2 + 2 + 1               # рис. 9-568: до Traffic Scheduling Constraint Set
CONSTRAINT_LEN = 4 + 2 + 2 + 6                             # рис. 9-571
MAX_CONSTRAINTS = 15                                       # 9.4.2.133: «ranges from 0 to 15»
PERIOD_FRACTION = 0x8000                                   # табл. 9-261/9-262: B15

Constraint = namedtuple('Constraint', 'start duration period interferer')
DmgTspec = namedtuple('DmgTspec', 'info bf_control period min_alloc max_alloc min_duration constraints')


def alloc_info(**kw):
    d = dict(allocation_id=0, allocation_type=ALLOC_SP, allocation_format=ISOCHRONOUS, pseudo_static=0, truncatable=0,
             extendable=0, lp_sc_used=0, up=0, dst_aid=0, src_aid=0, _r31=0)
    d.update(kw)
    return d


def encode_alloc_info(d):
    return E.le(E.pack(ALLOC_INFO, d), 4)


def parse_alloc_info(b):
    return E.unpack(ALLOC_INFO, int.from_bytes(bytes(b[:4]), 'little'))


def encode_dmg_tspec(t):
    b = encode_alloc_info(t.info) + E.le(t.bf_control, 2) + E.le(t.period, 2) + E.le(t.min_alloc, 2) \
        + E.le(t.max_alloc, 2) + E.le(t.min_duration, 2) + bytes([len(t.constraints)])
    for c in t.constraints:
        b += E.le(c.start, 4) + E.le(c.duration, 2) + E.le(c.period, 2) + F.mac_bytes(c.interferer)
    return E.encode_element(EID_DMG_TSPEC, b)


def parse_dmg_tspec(info):
    b = bytes(info)
    if len(b) < DMG_TSPEC_FIXED:
        raise ValueError(f'DMG TSPEC: {len(b)} октетов < {DMG_TSPEC_FIXED} (рис. 9-568)')
    n = b[14]
    if len(b) < DMG_TSPEC_FIXED + n * CONSTRAINT_LEN:
        raise ValueError(f'DMG TSPEC: Number of Constraints {n} не помещается в {len(b)} октетов (рис. 9-570)')
    cs = []
    for k in range(n):
        o = DMG_TSPEC_FIXED + k * CONSTRAINT_LEN
        cs.append(Constraint(int.from_bytes(b[o:o + 4], 'little'), int.from_bytes(b[o + 4:o + 6], 'little'),
                             int.from_bytes(b[o + 6:o + 8], 'little'), F.mac_str(b[o + 8:o + 14])))
    w = lambda o: int.from_bytes(b[o:o + 2], 'little')     # noqa: E731
    return DmgTspec(parse_alloc_info(b[0:4]), w(4), w(6), w(8), w(10), w(12), cs)


def period_us(raw, bi_us):
    """Табл. 9-261/9-262 → период, мкс; None — «Not periodic or periodicity unknown»; ValueError — Reserved."""
    n, frac = raw & 0x7FFF, raw & PERIOD_FRACTION
    if n == 0:
        if not frac:
            raise ValueError('период 0/0 — Reserved (табл. 9-261/9-262)')
        return None
    return bi_us / n if frac else bi_us * n


def check_dmg_tspec(t, frame='req', status=None, rx_caps=None, interference_report=False):
    """Нарушения DMG TSPEC. frame 'req' — в DMG ADDTS Request (non-AP), 'resp' — в ответе точки (status — его код);
    rx_caps — DmgCapabilities STA с Destination AID (для LP SC Used); interference_report — отчёт 10.39.6.6.6."""
    v = []
    i = t.info
    if i['_r31']:
        v.append('DMG Allocation Info B31 Reserved = 1 (рис. 9-569)')
    at = i['allocation_type']
    if at not in ALLOC_TYPES:
        v.append(f'AllocationType {at} — Reserved (табл. 9-257)')
    sp = at in ALLOC_TYPES_SP
    if not sp and (i['truncatable'] or i['extendable']):
        v.append('Truncatable/Extendable = 1 у CBAP — «reserved for CBAP allocations» (9.4.2.133)')
    if frame == 'req' and i['allocation_id'] == 0:
        v.append('Allocation ID = 0 в ADDTS Request — «sets … to a nonzero value» (9.4.2.133)')
    if frame == 'resp' and status is not None:
        if status in SUCCESS_CODES and i['allocation_id'] == 0:
            v.append('Allocation ID = 0 в успешном ADDTS Response (9.4.2.133, 11.4.4.4)')
        if status not in SUCCESS_CODES and i['allocation_id'] != 0:
            v.append(f'Allocation ID {i["allocation_id"]} ≠ 0 в неуспешном ADDTS Response (статус {status}) — «sets it '
                     f'to 0 if creating or modifying the allocation failed» (9.4.2.133)')
    try:
        period_us(t.period, 1)
    except ValueError as x:
        v.append(f'Allocation Period: {x}')
    if i['allocation_format'] == ASYNCHRONOUS:
        if t.period & PERIOD_FRACTION or not t.period & 0x7FFF:
            v.append('асинхронный формат: Allocation Period — «integer multiple of the beacon interval» (9.4.2.133)')
        if t.max_alloc:
            v.append('асинхронный формат: Maximum Allocation — «reserved» (9.4.2.133, 9.2.2)')
    elif t.max_alloc and t.min_alloc > t.max_alloc:
        v.append(f'изохронный формат: Minimum Allocation {t.min_alloc} > Maximum Allocation {t.max_alloc} (9.4.2.133)')
    if sp and t.min_duration > 32767:
        v.append(f'Minimum Duration {t.min_duration} > 32 767 для SP (9.4.2.133)')
    if len(t.constraints) > MAX_CONSTRAINTS:
        v.append(f'Number of Constraints {len(t.constraints)} > 15 (9.4.2.133)')
    for k, c in enumerate(t.constraints):
        if interference_report:
            if c.period != 0:
                v.append(f'Constraint[{k}]: TSCONST Period {c.period} ≠ 0 в отчёте о помехах (10.39.6.6.6; '
                         f'PLAN.md №70)')
        else:
            try:
                period_us(c.period, 1)
            except ValueError as x:
                v.append(f'Constraint[{k}]: TSCONST Period: {x}')
    if i['lp_sc_used'] and rx_caps is not None and not rx_caps.sta_cap['low_power_sc']:
        v.append('LP SC Used = 1, а получатель (Destination AID) не поддерживает low-power SC (11.4.1)')
    return v


# ---------------------------------------------------------------------------------------------------- кадры
Addts = namedtuple('Addts', 'action token status ts_delay dmg_tspec tspec tclas tclas_proc others variant order')


def encode_addts_req(token, dmg_tspec, tspec=None, tclas=(), tclas_proc=None, others=()):
    """Табл. 9-351: Category, Action, Dialog Token, DMG TSPEC, [TSPEC], [TCLAS…], [TCLAS Processing], …"""
    b = bytes([CATEGORY_QOS, ACT_ADDTS_REQ, token]) + encode_dmg_tspec(dmg_tspec)
    for x in ([tspec] if tspec else []) + list(tclas) + ([tclas_proc] if tclas_proc else []) + list(others):
        b += bytes(x)
    return b


def encode_addts_resp(token, status, dmg_tspec, ts_delay=None, tspec=None, tclas=(), tclas_proc=None, others=()):
    """Табл. 9-353: Category, Action, Dialog Token, Status Code, [TS Delay], DMG TSPEC, …"""
    b = bytes([CATEGORY_QOS, ACT_ADDTS_RESP, token]) + E.le(status, 2)
    if ts_delay is not None:
        b += E.encode_element(EID_TS_DELAY, E.le(ts_delay, 4))
    b += encode_dmg_tspec(dmg_tspec)
    for x in ([tspec] if tspec else []) + list(tclas) + ([tclas_proc] if tclas_proc else []) + list(others):
        b += bytes(x)
    return b


def is_addts(body):
    b = bytes(body)
    return len(b) >= 3 and b[0] == CATEGORY_QOS and b[1] in (ACT_ADDTS_REQ, ACT_ADDTS_RESP)


def parse_addts(body):
    """Тело Action ADDTS → Addts; variant 'dmg' | 'basic' (табл. 9-348/9-349; PLAN.md №71)."""
    b = bytes(body)
    if not is_addts(b):
        raise ValueError('не ADDTS Request/Response (табл. 9-347)')
    act, token = b[1], b[2]
    off, status = 3, None
    if act == ACT_ADDTS_RESP:
        if len(b) < 5:
            raise ValueError('ADDTS Response без Status Code')
        status, off = int.from_bytes(b[3:5], 'little'), 5
    els = E.parse_elements(b[off:])
    ts_delay = None
    rest = list(els)
    if act == ACT_ADDTS_RESP and rest and rest[0].eid == EID_TS_DELAY:
        ts_delay = int.from_bytes(rest[0].info[:4], 'little')
        rest = rest[1:]
    if not rest:
        raise ValueError('ADDTS без TSPEC/DMG TSPEC (табл. 9-350…9-353)')
    variant = 'dmg' if rest[0].eid == EID_DMG_TSPEC else 'basic' if rest[0].eid == EID_TSPEC else None
    if variant is None:
        raise ValueError(f'ADDTS: первый элемент {E.element_name(rest[0].eid, rest[0].ext)} — ни TSPEC, ни DMG TSPEC '
                         f'(табл. 9-348/9-349)')
    dmg = parse_dmg_tspec(rest[0].info) if variant == 'dmg' else None
    tspec = next((e for e in rest[1:] if e.eid == EID_TSPEC), None) if variant == 'dmg' else rest[0]
    tclas = [e for e in rest[1:] if e.eid == EID_TCLAS]
    proc = next((e for e in rest[1:] if e.eid == EID_TCLAS_PROC), None)
    others = [e for e in rest[1:] if e.eid not in (EID_TSPEC, EID_TCLAS, EID_TCLAS_PROC)]
    return Addts(act, token, status, ts_delay, dmg, tspec, tclas, proc, others, variant, [e.eid for e in els])


# табл. 9-351 / 9-353: порядок после DMG TSPEC
_ORDER = {EID_TSPEC: 1, EID_TCLAS: 2, EID_TCLAS_PROC: 3, EID_MULTIBAND: 4, EID_UPID: 5, EID_MMS: 6, EID_HLSID: 7}


def check_addts(f, src_is_ap=None, dmg_sta=True):
    """Нарушения одного DMG ADDTS Request/Response (без пары)."""
    v = []
    if f.variant != 'dmg':
        return v
    if not dmg_sta:
        v.append('DMG TSPEC от не-DMG STA (11.4.1: «A STA that is not a DMG STA shall not transmit a PTP TSPEC or a '
                 'DMG TSPEC»)')
    seq = [x for x in f.order if x not in (EID_TS_DELAY, EID_DMG_TSPEC)]
    ranks = [_ORDER.get(x, 8) for x in seq]
    if ranks != sorted(ranks):
        v.append(f'порядок элементов {seq} не по табл. {"9-351" if f.action == ACT_ADDTS_REQ else "9-353"}')
    if f.order and f.order[0] == EID_TS_DELAY and f.action == ACT_ADDTS_REQ:
        v.append('TS Delay в ADDTS Request (табл. 9-351)')
    if f.tclas and f.tspec is None:
        v.append('TCLAS без TSPEC (9.6.3.2.2: «If a TSPEC element is not present, then the TCLAS element is not '
                 'present»)')
    if len(f.tclas) > 1 and f.tclas_proc is None:
        v.append('несколько TCLAS без TCLAS Processing (9.6.3.2.2)')
    if len(f.tclas) <= 1 and f.tclas_proc is not None:
        v.append('TCLAS Processing при ≤ 1 TCLAS (9.6.3.2.2: «present if there is more than one TCLAS»)')
    if any(e.eid == EID_UPID for e in f.others) and f.tspec is None:
        v.append('U-PID без TSPEC (9.6.3.2.2/9.6.3.3.2: «If a TSPEC element is not present … the U-PID element is not '
                 'present»)')
    if f.action == ACT_ADDTS_RESP:
        if (f.ts_delay is not None) != (f.status == REJECTED_FOR_DELAY_PERIOD):
            v.append(f'TS Delay {"есть" if f.ts_delay is not None else "нет"} при статусе {f.status} (9.6.3.3.2: «only '
                     f'if the status code is set to REJECTED_FOR_DELAY_PERIOD»)')
        if f.status == SUCCESS_POWER_SAVE_MODE:
            v.append('SUCCESS_POWER_SAVE_MODE (85): power save у DMG STA удалён — точка не должна его слать (PLAN.md '
                     '№72)')
        if src_is_ap is False:
            v.append('DMG ADDTS Response от non-AP STA (DMG TSPEC ответа шлёт AP/PCP, 9.4.2.133)')
        v += check_dmg_tspec(f.dmg_tspec, 'resp', f.status)
    else:
        if src_is_ap is True:
            v.append('DMG ADDTS Request от AP/PCP (9.4.2.133: «sent by a non-AP and non-PCP DMG STA»)')
        v += check_dmg_tspec(f.dmg_tspec, 'req')
    return v


def check_addts_pair(req, resp):
    """Пара запрос → ответ: Dialog Token, вариант, U-PID (11.4.4.4)."""
    v = []
    if resp.token != req.token:
        v.append(f'Dialog Token ответа {resp.token} ≠ запроса {req.token} (9.6.3.3.2)')
    if resp.variant != req.variant:
        v.append(f'вариант ответа {resp.variant} ≠ запроса {req.variant} (9.6.3.1)')
    up_req = [bytes(e.info) for e in req.others if e.eid == EID_UPID]
    up_resp = [bytes(e.info) for e in resp.others if e.eid == EID_UPID]
    if up_resp and not up_req:
        v.append('U-PID в ответе без U-PID в запросе (11.4.4.4)')
    if up_req and resp.status == SUCCESS and up_resp != up_req:
        v.append('успешный ответ без того же U-PID, что в запросе (11.4.4.4)')
    if resp.dmg_tspec is not None and req.dmg_tspec is not None and resp.status in SUCCESS_CODES:
        a, b = req.dmg_tspec.info, resp.dmg_tspec.info
        if (a['src_aid'], a['dst_aid']) != (b['src_aid'], b['dst_aid']):
            v.append(f'Source/Destination AID ответа {b["src_aid"]}/{b["dst_aid"]} ≠ запроса {a["src_aid"]}/'
                     f'{a["dst_aid"]} (распределение — (Source AID, Allocation ID, Destination AID), 11.4.1)')
    return v


def allocation_key(info):
    """11.4.1: распределение однозначно — Allocation ID, Source AID, Destination AID."""
    return info['src_aid'], info['allocation_id'], info['dst_aid']


def response_targets(info, requester_aid, ap_aid=0):
    """11.4.4.4: точка шлёт ADDTS Response «to the STAs identified as source and destination AID» (если запрос от
    non-AP STA) → множество AID адресатов (без самой точки и broadcast)."""
    return {a for a in (info['src_aid'], info['dst_aid'], requester_aid) if a not in (ap_aid, AID_BROADCAST)}


def check_schedule_has(info, allocs):
    """11.4.4.4: после SUCCESS — «delivering the Extended Schedule element»: в расписании есть Allocation с тем же
    (Source AID, Destination AID, Allocation ID) и типом."""
    for a in allocs:
        want = (info['src_aid'], info['dst_aid'], info['allocation_id'], info['allocation_type'])
        if (a.src_aid, a.dst_aid, a.ctrl['allocation_id'], a.ctrl['allocation_type']) == want:
            return []
    return [f'распределение {allocation_key(info)} после SUCCESS нет в Extended Schedule (11.4.4.4)']


def check_isochronous(t, blocks, bi_us):
    """11.4.13.2 (should): за каждый Allocation Period сумма ≥ Minimum Allocation и каждое SP ≥ Minimum Duration.
    blocks — [(начало, конец)] SP распределения за наблюдаемый интервал (по возрастанию)."""
    v = []
    if t.info['allocation_format'] != ISOCHRONOUS or not blocks:
        return v
    per = period_us(t.period, bi_us)
    for a, b in blocks:
        if t.min_duration and b - a < t.min_duration:
            v.append(f'SP [{a}, {b}) короче Minimum Duration {t.min_duration} мкс (11.4.13.2)')
    if per is None:
        return v
    t0, t_end = blocks[0][0], blocks[-1][1]
    k = 0
    while t0 + (k + 1) * per <= t_end:
        lo, hi = t0 + k * per, t0 + (k + 1) * per
        s = sum(min(b, hi) - max(a, lo) for a, b in blocks if a < hi and lo < b)
        if s < t.min_alloc:
            v.append(f'за период [{lo}, {hi}) выделено {s} < Minimum Allocation {t.min_alloc} мкс (11.4.13.2)')
        k += 1
    return v


# ---------------------------------------------------------------------------------------------------- DELTS
Delts = namedtuple('Delts', 'ts_info reason alloc_info others')


def encode_delts(reason, info=None, ts_info=0):
    """Табл. 9-354: Category, QoS Action, TS Info (3), Reason Code (2), [DMG Allocation Info (4)], [Multi-band]."""
    return bytes([CATEGORY_QOS, ACT_DELTS]) + E.le(ts_info, 3) + E.le(reason, 2) \
        + (encode_alloc_info(info) if info is not None else b'')


def parse_delts(body):
    b = bytes(body)
    if len(b) < 7 or b[0] != CATEGORY_QOS or b[1] != ACT_DELTS:
        raise ValueError('не DELTS (табл. 9-354)')
    rest = b[7:]
    info = None
    # СПОРНО: DMG Allocation Info (4 октета, без заголовка) и Multi-band (элемент 158) оба необязательны; хвост,
    # целиком разбираемый как элементы с первым 158, — Multi-band без DMG Allocation Info.
    multiband_only = False
    if rest and rest[0] == EID_MULTIBAND:
        try:
            multiband_only = all(e.eid == EID_MULTIBAND for e in E.parse_elements(rest))
        except ValueError:
            multiband_only = False
    if len(rest) >= 4 and not multiband_only:
        info, rest = parse_alloc_info(rest[:4]), rest[4:]
    return Delts(int.from_bytes(b[2:5], 'little'), int.from_bytes(b[5:7], 'little'), info, rest)


class AllocationTable:
    """Распределения точки по DMG TSPEC (11.4.4.4, 11.4.9.2)."""

    def __init__(self, ap_aid=0):
        self.ap_aid = ap_aid
        self.allocs = {}                   # ключ (src, id, dst) → DmgTspec

    def admit(self, t, status=SUCCESS, alloc_id=None):
        """Ответ точки на запрос → DmgTspec ответа (Allocation ID 0 при неудаче)."""
        info = dict(t.info)
        if status in SUCCESS_CODES:
            info['allocation_id'] = alloc_id or info['allocation_id']
            r = t._replace(info=info)
            self.allocs[allocation_key(info)] = r
            return r
        info['allocation_id'] = 0
        return t._replace(info=info)

    def on_delts(self, info, from_aid):
        """11.4.9.2: DELTS от источника (получатель ≠ broadcast) → точка шлёт DELTS получателю, и наоборот; запись
        удаляется. → [AID, кому слать DELTS]."""
        self.allocs.pop(allocation_key(info), None)
        out = []
        if from_aid == info['src_aid'] and info['dst_aid'] != AID_BROADCAST and info['dst_aid'] != self.ap_aid:
            out.append(info['dst_aid'])
        elif from_aid == info['dst_aid'] and info['src_aid'] != AID_BROADCAST and info['src_aid'] != self.ap_aid:
            out.append(info['src_aid'])
        return out

    def on_disassoc(self, aid):
        """11.4.9.2: при (раз/пере)ассоциации STA точка удаляет распределения этой STA и шлёт DELTS второй стороне,
        если она не broadcast. → [(AID, DMG Allocation Info)]."""
        out = []
        for k, t in list(self.allocs.items()):
            src, _, dst = k
            if aid in (src, dst):
                del self.allocs[k]
                peer = dst if src == aid else src
                if peer not in (AID_BROADCAST, self.ap_aid):
                    out.append((peer, t.info))
        return out


def check_delts(d, deleting_alloc):
    """9.6.3.4: при удалении распределения — DMG Allocation Info есть; иначе — все подполя 0 (если поле есть)."""
    v = []
    if deleting_alloc and d.alloc_info is None:
        v.append('DELTS удаляет распределение без DMG Allocation Info (9.6.3.4)')
    if not deleting_alloc and d.alloc_info is not None and any(d.alloc_info.values()):
        v.append('DMG Allocation Info ≠ 0 в DELTS, не удаляющем распределение (9.6.3.4)')
    if d.alloc_info is not None and d.alloc_info['allocation_id'] == 0 and deleting_alloc:
        v.append('DELTS: Allocation ID = 0 — распределение не идентифицируется (9.6.3.4, 9.4.2.133)')
    return v
