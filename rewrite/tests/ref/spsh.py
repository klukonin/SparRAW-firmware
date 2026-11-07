# SPDX-License-Identifier: AGPL-3.0-or-later
"""Spatial sharing и подавление помех DMG по 802.11-2020 11.30 [p. 2364–2367]: способность — поле SPSH and
Interference Mitigation DMG Capabilities (11.30.1); измерение Directional Channel Quality — запрос (9.4.2.20.16
[p. 995–996], рис. 9-216, 9-217, табл. 9-120, 9-121) и отчёт (9.4.2.21.15 [p. 1044], рис. 9-277, табл. 9-144) в
элементах Measurement Request/Report (9.4.2.20.1/9.4.2.21.1, тип 13 — табл. 9-98/9-125) кадров Radio Measurement
Request/Report (9.6.6.2/9.6.6.3 [p. 1459–1460], категория 5).

Правила:
  - AP/PCP при оценке кандидата SP: Target STA (AID) — пир в кандидате, Measurement Method = ANIPI; к STA уже
    выделенного SP — пир в нём, ANIPI (11.30.2); при сопровождении совмещённых SP — RSNI (11.30.3);
  - STA меряет той же приёмной конфигурацией, что при приёме от Target STA, если с ней обучен луч; AID broadcast или
    неизвестный — квази-омни (11.30.2);
  - отчёт: тот же формат, что в запросе (Operating Class, Channel, AID, Method, Number of Time Blocks; n значений по
    времени), Measurement Token = токен запроса, Late = 0 (радиоизмерение), Report Mode — выполнено/нет (11.30.2);
  - совмещение SP по времени — только после отчётов STA кандидата (и STA существующего, если кандидат уже в
    расписании) (11.30.3, should);
  - устойчивость BSS (11.30.4): после смены канала — N ~ U[0, SwitchInterval − 1] BI без новой смены; SwitchInterval
    от aMinSwitchInterval, ×2 на смену до aMaxSwitchInterval, сброс после aMaxSwitchInterval BI на одном канале.

Не моделируется: алгоритм выбора совмещения (вне стандарта), значения ANIPI/RSNI (измерение PHY), SSW Report
(9.4.2.222, EDMG/CDMG), FST (11.31)."""
from collections import namedtuple

from . import capelems as CE
from . import elements as E
from .timing import AID_BROADCAST, aMaxSwitchInterval, aMinSwitchInterval

CATEGORY_RM = 5                                     # табл. 9-51: Radio Measurement
ACT_RM_REQ, ACT_RM_REP = 0, 1                       # табл. 9-363
EID_MEAS_REQ, EID_MEAS_REP = 38, 39
TYPE_DCQ = 13                                       # «Directional Channel Quality» — табл. 9-98 и 9-125
METHOD_ANIPI, METHOD_RSNI = 0, 1
SUBEL_DCQ_REPORTING, SUBEL_VENDOR = 1, 221           # табл. 9-120
COND_EACH, COND_GE, COND_LE = 0, 1, 2               # табл. 9-121
DCQ_REQ_FIXED = 1 + 1 + 1 + 1 + 1 + 8 + 2 + 1       # рис. 9-216: до Optional Subelements
DCQ_REP_FIXED = DCQ_REQ_FIXED                       # рис. 9-277: до Measurement for Time Block List
# Measurement Request Mode (рис. 9-180) / Report Mode (рис. 9-223)
REQ_MODE = [('parallel', 1), ('enable', 1), ('request', 1), ('report', 1), ('duration_mandatory', 1), ('_r5', 3)]
REP_MODE = [('late', 1), ('incapable', 1), ('refused', 1), ('_r3', 5)]

DcqReq = namedtuple('DcqReq', 'op_class channel aid rsv method start duration blocks subelements')
DcqRep = namedtuple('DcqRep', 'op_class channel aid rsv method start duration blocks values subelements')
Meas = namedtuple('Meas', 'eid token mode type body')


def encode_dcq_req(r):
    return (bytes([r.op_class, r.channel, r.aid, r.rsv, r.method]) + E.le(r.start, 8) + E.le(r.duration, 2)
            + bytes([r.blocks]) + bytes(r.subelements))


def parse_dcq_req(b):
    b = bytes(b)
    if len(b) < DCQ_REQ_FIXED:
        raise ValueError(f'Directional Channel Quality request: {len(b)} < {DCQ_REQ_FIXED} октетов (рис. 9-216)')
    return DcqReq(b[0], b[1], b[2], b[3], b[4], int.from_bytes(b[5:13], 'little'), int.from_bytes(b[13:15], 'little'),
                  b[15], b[16:])


def encode_dcq_rep(r):
    return (bytes([r.op_class, r.channel, r.aid, r.rsv, r.method]) + E.le(r.start, 8) + E.le(r.duration, 2)
            + bytes([r.blocks]) + bytes(r.values) + bytes(r.subelements))


def parse_dcq_rep(b):
    b = bytes(b)
    if len(b) < DCQ_REP_FIXED:
        raise ValueError(f'Directional Channel Quality report: {len(b)} < {DCQ_REP_FIXED} октетов (рис. 9-277)')
    n = b[15]
    if len(b) < DCQ_REP_FIXED + n:
        raise ValueError(f'Directional Channel Quality report: {n} значений не помещаются (рис. 9-277)')
    return DcqRep(b[0], b[1], b[2], b[3], b[4], int.from_bytes(b[5:13], 'little'), int.from_bytes(b[13:15], 'little'),
                  n, list(b[16:16 + n]), b[16 + n:])


def encode_meas(eid, token, mode, mtype, body):
    return E.encode_element(eid, bytes([token, E.pack(REQ_MODE if eid == EID_MEAS_REQ else REP_MODE, mode), mtype])
                            + bytes(body))


def req_mode(**kw):
    d = dict(parallel=0, enable=0, request=0, report=0, duration_mandatory=0, _r5=0)
    d.update(kw)
    return d


def rep_mode(**kw):
    d = dict(late=0, incapable=0, refused=0, _r3=0)
    d.update(kw)
    return d


def encode_rm_request(token, elements, repetitions=0):
    """9.6.6.2: Category 5, Action 0, Dialog Token, Number of Repetitions (2), Measurement Request elements."""
    return bytes([CATEGORY_RM, ACT_RM_REQ, token]) + E.le(repetitions, 2) + b''.join(bytes(e) for e in elements)


def encode_rm_report(token, elements):
    return bytes([CATEGORY_RM, ACT_RM_REP, token]) + b''.join(bytes(e) for e in elements)


def is_rm(body):
    b = bytes(body)
    return len(b) >= 3 and b[0] == CATEGORY_RM and b[1] in (ACT_RM_REQ, ACT_RM_REP)


def parse_rm(body):
    """Тело Radio Measurement Request/Report → (action, dialog token, repetitions | None, [Meas])."""
    b = bytes(body)
    if not is_rm(b):
        raise ValueError('не Radio Measurement Request/Report (9.6.6.2/9.6.6.3)')
    off = 5 if b[1] == ACT_RM_REQ else 3
    if len(b) < off:
        raise ValueError('Radio Measurement Request без Number of Repetitions')
    reps = int.from_bytes(b[3:5], 'little') if b[1] == ACT_RM_REQ else None
    out = []
    for el in E.parse_elements(b[off:]):
        if el.eid in (EID_MEAS_REQ, EID_MEAS_REP) and len(el.info) >= 3:
            spec = REQ_MODE if el.eid == EID_MEAS_REQ else REP_MODE
            out.append(Meas(el.eid, el.info[0], E.unpack(spec, el.info[1]), el.info[2], el.info[3:]))
    return b[1], b[2], reps, out


def _subelements(b):
    out, i = [], 0
    b = bytes(b)
    while i < len(b):
        if i + 2 > len(b) or i + 2 + b[i + 1] > len(b):
            raise ValueError('обрезанный подэлемент (9.4.3)')
        out.append((b[i], b[i + 2:i + 2 + b[i + 1]]))
        i += 2 + b[i + 1]
    return out


def dcq_reporting(cond, ref):
    """Подэлемент Directional Channel Quality Reporting (рис. 9-217)."""
    return bytes([SUBEL_DCQ_REPORTING, 2, cond, ref])


def check_dcq_req(m, k=1):
    v = []
    w = f'DCQ request[{k}]'
    if m.token == 0:
        v.append(f'{w}: Measurement Token = 0 (9.4.2.20.1: «nonzero number»)')
    if m.mode['_r5']:
        v.append(f'{w}: Measurement Request Mode B5–B7 Reserved ≠ 0 (рис. 9-180)')
    try:
        r = parse_dcq_req(m.body)
    except ValueError as x:
        return v + [f'{w}: {x}']
    if r.rsv:
        v.append(f'{w}: октет Reserved ≠ 0 (рис. 9-216)')
    if r.method not in (METHOD_ANIPI, METHOD_RSNI):
        v.append(f'{w}: Measurement Method {r.method} — Reserved (9.4.2.20.16)')
    if r.blocks == 0:
        v.append(f'{w}: Number of Time Blocks = 0 — нет единицы измерения (9.4.2.20.16: Duration/Number of Time '
                 f'Blocks)')
    if r.op_class in CE.DMG_GLOBAL_CLASSES and not CE.channel_in_class(r.op_class, r.channel):
        v.append(f'{w}: канал {r.channel} не в классе {r.op_class} (приложение E, табл. E-4)')
    try:
        for sid, data in _subelements(r.subelements):
            if sid not in (SUBEL_DCQ_REPORTING, SUBEL_VENDOR):
                v.append(f'{w}: подэлемент {sid} — Reserved (табл. 9-120)')
            elif sid == SUBEL_DCQ_REPORTING and (len(data) < 2 or data[0] > COND_LE):
                v.append(f'{w}: Reporting Condition {data[0] if data else "?"} — Reserved (табл. 9-121)')
    except ValueError as x:
        v.append(f'{w}: {x}')
    return v


def check_dcq_rep(m, req=None, k=1):
    """Отчёт; req — Meas запроса (тот же токен) или None."""
    v = []
    w = f'DCQ report[{k}]'
    if m.mode['late']:
        v.append(f'{w}: Late = 1 у радиоизмерения (9.4.2.21.1: «set to 0 in all measurement report elements for '
                 f'radio measurement types»)')
    if m.mode['_r3']:
        v.append(f'{w}: Measurement Report Mode B3–B7 Reserved ≠ 0 (рис. 9-223)')
    failed = m.mode['incapable'] or m.mode['refused']
    if failed and not m.body:
        return v
    try:
        r = parse_dcq_rep(m.body)
    except ValueError as x:
        return v + [f'{w}: {x}']
    if r.rsv:
        v.append(f'{w}: октет Reserved ≠ 0 (рис. 9-277)')
    if r.method not in (METHOD_ANIPI, METHOD_RSNI):
        v.append(f'{w}: Measurement Method {r.method} — Reserved (9.4.2.21.15)')
    try:
        for sid, _ in _subelements(r.subelements):
            if sid != SUBEL_VENDOR:
                v.append(f'{w}: подэлемент {sid} — Reserved (табл. 9-144)')
    except ValueError as x:
        v.append(f'{w}: {x}')
    if req is not None and not failed:
        q = parse_dcq_req(req.body)
        for name in ('op_class', 'channel', 'aid', 'method', 'blocks'):
            if getattr(r, name) != getattr(q, name):
                v.append(f'{w}: {name} {getattr(r, name)} ≠ запроса {getattr(q, name)} (11.30.2: «formatted and '
                         f'transmitted as specified in the Directional Channel Quality request»)')
    return v


def check_rm_pair(req_body, rep_body):
    """Пара Radio Measurement Request → Report: Dialog Token, Measurement Token, отчёт на каждый DCQ-запрос."""
    _, tq, _, qs = parse_rm(req_body)
    _, tr, _, rs = parse_rm(rep_body)
    v = []
    if tr != tq:
        v.append(f'Dialog Token отчёта {tr} ≠ запроса {tq} (9.6.6.3)')
    by = {m.token: m for m in qs if m.type == TYPE_DCQ}
    for k, m in enumerate((m for m in rs if m.type == TYPE_DCQ), 1):
        q = by.get(m.token)
        if q is None and m.token != 0:
            v.append(f'DCQ report[{k}]: Measurement Token {m.token} без запроса (9.4.2.21.1)')
        v += check_dcq_rep(m, q, k)
    return v


# ---------------------------------------------------------------------------------------------------- поведение
SpPair = namedtuple('SpPair', 'src_aid dst_aid')


def assessment_requests(candidate, existing, token0=1, op_class=180, channel=2, start=0, duration=1, blocks=1):
    """11.30.2: запросы AP/PCP для оценки совмещения кандидата с существующим SP — к STA кандидата (Target — пир по
    кандидату) и к STA существующего (Target — пир по существующему), Method = ANIPI. → [(AID адресата, Meas-тело)]."""
    out, tok = [], token0
    for pair in (candidate, existing):
        for me, peer in ((pair.src_aid, pair.dst_aid), (pair.dst_aid, pair.src_aid)):
            r = DcqReq(op_class, channel, peer, 0, METHOD_ANIPI, start, duration, blocks, b'')
            out.append((me, encode_meas(EID_MEAS_REQ, tok, req_mode(), TYPE_DCQ, encode_dcq_req(r))))
            tok += 1
    return out


def monitor_request(pair, me, token=1, op_class=180, channel=2, start=0, duration=1, blocks=1):
    """11.30.3: сопровождение совмещённых SP — Target — пир в том же SP, Method = RSNI."""
    peer = pair.dst_aid if me == pair.src_aid else pair.src_aid
    r = DcqReq(op_class, channel, peer, 0, METHOD_RSNI, start, duration, blocks, b'')
    return encode_meas(EID_MEAS_REQ, token, req_mode(), TYPE_DCQ, encode_dcq_req(r))


def measurement_antenna(aid, trained_aids, aid_of=None):
    """11.30.2: обучен луч с Target STA — та же приёмная конфигурация ('peer'); AID broadcast/неизвестный —
    'quasi-omni'."""
    if aid == AID_BROADCAST or aid not in trained_aids:
        return 'quasi-omni'
    return 'peer'


def answer(req_meas, values, performed=True, refused=False):
    """Отчёт STA на DCQ-запрос: тот же формат (11.30.2); performed=False — Incapable, refused — Refused."""
    q = parse_dcq_req(req_meas.body)
    if refused or not performed:
        return encode_meas(EID_MEAS_REP, req_meas.token, rep_mode(incapable=int(not performed and not refused),
                                                                  refused=int(refused)), TYPE_DCQ, b'')
    if len(values) != q.blocks:
        raise ValueError(f'значений {len(values)} ≠ Number of Time Blocks {q.blocks} (9.4.2.21.15)')
    r = DcqRep(q.op_class, q.channel, q.aid, 0, q.method, q.start, q.duration, q.blocks, list(values), b'')
    return encode_meas(EID_MEAS_REP, req_meas.token, rep_mode(), TYPE_DCQ, encode_dcq_rep(r))


def overlaps(a, b):
    return a[0] < b[1] and b[0] < a[1]


def check_overlap_allowed(candidate, existing, reports, candidate_scheduled_before):
    """11.30.3 (should): совмещение кандидата с существующим — после отчётов DCQ от обеих STA кандидата, а если
    кандидат уже был в расписании — и от STA существующего. reports — множество AID, приславших DCQ report."""
    need = {candidate.src_aid, candidate.dst_aid}
    if candidate_scheduled_before:
        need |= {existing.src_aid, existing.dst_aid}
    miss = sorted(need - set(reports) - {AID_BROADCAST})
    return [f'SP {candidate} совмещён с {existing} без отчётов DCQ от AID {miss} (11.30.3)'] if miss else []


class SwitchBackoff:
    """11.30.4: устойчивость BSS к частой смене канала. rand(n) → целое в [0, n − 1]."""

    def __init__(self, rand):
        self.rand = rand
        self.interval = aMinSwitchInterval
        self.block_until = None
        self.last_switch = None

    def may_switch(self, bi):
        return self.block_until is None or bi >= self.block_until

    def switch(self, bi):
        if not self.may_switch(bi):
            raise ValueError(f'смена канала в BI {bi} раньше BI {self.block_until} (11.30.4)')
        n = self.rand(self.interval)
        if not 0 <= n < self.interval:
            raise ValueError('N вне [0, SwitchInterval − 1] (11.30.4)')
        self.block_until = bi + n
        self.last_switch = bi
        self.interval = min(2 * self.interval, aMaxSwitchInterval)
        return n

    def tick(self, bi):
        """Сброс SwitchInterval после aMaxSwitchInterval BI подряд на одном канале."""
        if self.last_switch is not None and bi - self.last_switch >= aMaxSwitchInterval:
            self.interval = aMinSwitchInterval


def spsh_capable(caps):
    return bool(caps.sta_cap['spsh_interference_mitigation'])
