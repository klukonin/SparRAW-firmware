# SPDX-License-Identifier: AGPL-3.0-or-later
"""Подавление соседних DMG BSS (QAB) по 802.11-2020 11.35 [p. 2389–2390]: элементы Quiet Period Request (9.4.2.149
[p. 1270], рис. 9-595: Request Token, Quiet Period Offset/Period/Duration в TU, Repetition Count, Target BSSID) и Quiet
Period Response (9.4.2.150 [p. 1271], рис. 9-596), кадры QAB Request/Response (Public Action 16/17, 9.6.7.34/9.6.7.35
[p. 1492–1493], табл. 9-364, 9-381, 9-382; защищённый вариант — Protected Dual of Public Action, категория 9,
табл. 9-404), бит QAB Capability Extended Capabilities (бит 47, табл. 9-153; 11.35.1).

Поведение:
  QabRequester — AP-запросчик (11.35.2): шлёт QAB Request, только если обе точки QAB-способны; подтверждение — QAB
                 Response с совпавшими Dialog Token и Request Token: SUCCESS — успех, иное — отказ;
  QabResponder — AP-ответчик (11.35.3): обрабатывает элементы с Target BSSID = свой BSSID; при SUCCESS — SP с
                 источником и получателем = сама точка на каждый тихий интервал (не больше Repetition Count), в них не
                 передаёт; в ответе — копия Request Token и BSSID.
  quiet_intervals — интервалы [начало, конец) от начала преамбулы PPDU запроса (9.4.2.149, NOTE).

СПОРНО → принято (PLAN.md №62): ответ — по одному Quiet Period Response на каждый Quiet Period Request с Target BSSID =
своему (11.35.2 a) допускает несколько элементов в запросе, табл. 9-382 — один элемент; при одном адресованном элементе
— ровно один). Quiet Duration > Quiet Period (интервалы налезают) — нарушение запроса.
Не моделируется: GAS-проверка возможностей другой точки (NOTE 11.35.2), выбор результата SME (MLME-QAB.response)."""
from collections import namedtuple

from . import elements as E
from . import fields as F
from .timing import AID_AP_PCP, BCAST, TU

CATEGORY_PUBLIC, CATEGORY_PROTECTED_DUAL = 4, 9          # табл. 9-51
ACT_QAB_REQ, ACT_QAB_RESP = 16, 17                       # табл. 9-364 (и 9-404 для Protected Dual)
EID_QP_REQ, EID_QP_RESP = 175, 177                       # табл. 9-92
QP_REQ_LEN, QP_RESP_LEN = 17, 10                         # рис. 9-595, 9-596 (без Element ID и Length)
EXT_CAP_QAB_BIT = 47                                     # табл. 9-153
SUCCESS = 0

QpReq = namedtuple('QpReq', 'token offset period duration count target')
QpResp = namedtuple('QpResp', 'token bssid status')
QabFrame = namedtuple('QabFrame', 'category action token requester responder elements')


def encode_qp_req(q):
    return E.encode_element(EID_QP_REQ, q.token.to_bytes(2, 'little') + q.offset.to_bytes(2, 'little')
                            + q.period.to_bytes(4, 'little') + q.duration.to_bytes(2, 'little') + bytes([q.count])
                            + F.mac_bytes(q.target))


def parse_qp_req(info):
    b = E.known_info(info, QP_REQ_LEN, 'Quiet Period Request')
    return QpReq(int.from_bytes(b[0:2], 'little'), int.from_bytes(b[2:4], 'little'), int.from_bytes(b[4:8], 'little'),
                 int.from_bytes(b[8:10], 'little'), b[10], F.mac_str(b[11:17]))


def encode_qp_resp(r):
    return E.encode_element(EID_QP_RESP, r.token.to_bytes(2, 'little') + F.mac_bytes(r.bssid)
                            + r.status.to_bytes(2, 'little'))


def parse_qp_resp(info):
    b = E.known_info(info, QP_RESP_LEN, 'Quiet Period Response')
    return QpResp(int.from_bytes(b[0:2], 'little'), F.mac_str(b[2:8]), int.from_bytes(b[8:10], 'little'))


def encode_frame(action, token, requester, responder, elements, protected=False):
    """Тело Action QAB Request/Response (табл. 9-381/9-382): Category, Public Action, Dialog Token, RequesterAP Address,
    ResponderAP Address, элементы."""
    cat = CATEGORY_PROTECTED_DUAL if protected else CATEGORY_PUBLIC
    return bytes([cat, action, token]) + F.mac_bytes(requester) + F.mac_bytes(responder) \
        + b''.join(bytes(e) for e in elements)


def is_qab(body):
    b = bytes(body)
    return len(b) >= 2 and b[0] in (CATEGORY_PUBLIC, CATEGORY_PROTECTED_DUAL) and b[1] in (ACT_QAB_REQ, ACT_QAB_RESP)


def parse_frame(body):
    b = bytes(body)
    if not is_qab(b) or len(b) < 15:
        raise ValueError('не QAB Request/Response (табл. 9-381/9-382)')
    els = []
    for el in E.parse_elements(b[15:]):
        if b[1] == ACT_QAB_REQ and el.eid == EID_QP_REQ:
            els.append(parse_qp_req(el.info))
        elif b[1] == ACT_QAB_RESP and el.eid == EID_QP_RESP:
            els.append(parse_qp_resp(el.info))
    return QabFrame(b[0], b[1], b[2], F.mac_str(b[3:9]), F.mac_str(b[9:15]), els)


def quiet_intervals(t_ppdu, q):
    """9.4.2.149: начало k-го интервала — начало преамбулы PPDU с элементом + Offset + k·Period (TU), длина —
    Duration TU; k = 0…Repetition Count − 1 (NOTE: конец — … + (Count − 1)·Period + Duration)."""
    return [(t_ppdu + (q.offset + k * q.period) * TU, t_ppdu + (q.offset + k * q.period + q.duration) * TU)
            for k in range(q.count)]


def check_qp_req(q, k=1):
    v = []
    w = f'Quiet Period Request[{k}]'
    if q.token == 0:
        v.append(f'{w}: Request Token = 0 (9.4.2.149: «set to a nonzero value»)')
    if q.count == 0:
        v.append(f'{w}: Repetition Count = 0 — нет ни одного интервала (9.4.2.149)')
    if q.duration == 0:
        v.append(f'{w}: Quiet Duration = 0 (9.4.2.149)')
    if q.count > 1 and q.duration > q.period:
        v.append(f'{w}: Quiet Duration {q.duration} > Quiet Period {q.period} TU — интервалы налезают (PLAN.md №62)')
    if q.target == BCAST:
        v.append(f'{w}: Target BSSID = broadcast — «set to the responder AP’s MAC address» (9.4.2.149)')
    return v


def check_request(f, src, requester_qab=None, responder_qab=None):
    """Нарушения QAB Request (src — TA)."""
    v = []
    if f.token == 0:
        v.append('Dialog Token = 0 (9.6.7.34: «nonzero value»)')
    if f.requester != src:
        v.append(f'RequesterAP Address {f.requester} ≠ TA {src} (9.6.7.34)')
    if not f.elements:
        v.append('нет Quiet Period Request (табл. 9-381)')
    for k, q in enumerate(f.elements, 1):
        v += check_qp_req(q, k)
        if f.responder != BCAST and q.target != f.responder:
            v.append(f'Target BSSID {q.target} ≠ ResponderAP Address {f.responder} (9.4.2.149, 9.6.7.34)')
    if requester_qab is False or responder_qab is False:
        v.append('QAB Request при QAB Capability = 0 у запросчика или ответчика (11.35.2 a))')
    return v


def check_response(f, src, req=None, own_bssid=None):
    """Нарушения QAB Response (src — TA ответчика); req — QabFrame запроса."""
    v = []
    if f.responder != src:
        v.append(f'ResponderAP Address {f.responder} ≠ TA {src} (9.6.7.35)')
    if len(f.elements) == 0:
        v.append('нет Quiet Period Response (табл. 9-382)')
    for r in f.elements:
        if own_bssid is not None and r.bssid != own_bssid:
            v.append(f'BSSID ответа {r.bssid} ≠ BSSID точки {own_bssid} (11.35.3 b) 1): «the BSSID of the AP’s BSS»)')
    if req is not None:
        if f.token != req.token:
            v.append(f'Dialog Token {f.token} ≠ запроса {req.token} (9.6.7.35)')
        if f.requester != req.requester:
            v.append(f'RequesterAP Address {f.requester} ≠ запроса {req.requester} (9.6.7.35)')
        mine = [q for q in req.elements if q.target == src]
        want = {(q.token, q.target) for q in mine}
        got = {(r.token, r.bssid) for r in f.elements}
        for t, b in got - want:
            v.append(f'Quiet Period Response (Request Token {t}, BSSID {b}) без соответствующего Quiet Period Request '
                     f'(9.4.2.150: «copy of the request token», BSSID = Target BSSID)')
        for t, b in want - got:
            v.append(f'нет Quiet Period Response на Request Token {t} (PLAN.md №62)')
    return v


def quiet_allocation_ok(alloc, aid_ap=AID_AP_PCP):
    """11.35.3 b) 1): тихий интервал — SP, у которого точка и источник, и получатель."""
    return E.ALLOC_IS_SP.get(alloc.ctrl['allocation_type'], False) and alloc.src_aid == aid_ap == alloc.dst_aid


class QabRequester:
    def __init__(self, mac, qab=True):
        self.mac, self.qab = mac, qab
        self.pending = {}                      # (dialog token, request token) → QpReq
        self.results = []                      # (responder, request token, успех)
        self._tok = 0

    def request(self, peer_mac, peer_qab, quiet, protected=False):
        """quiet — [(offset, period, duration, count)] → тело QAB Request или None (11.35.2 a)."""
        if not (self.qab and peer_qab):
            return None
        self._tok = self._tok % 255 + 1
        els = []
        for k, (off, per, dur, cnt) in enumerate(quiet, 1):
            q = QpReq(k, off, per, dur, cnt, peer_mac)
            els.append(encode_qp_req(q))
            self.pending[(self._tok, k)] = q
        return encode_frame(ACT_QAB_REQ, self._tok, self.mac, peer_mac, els, protected)

    def on_response(self, body, src):
        """11.35.2 b), c): MLME-QAB.confirm по совпавшим Dialog Token и Request Token."""
        f = parse_frame(body)
        for r in f.elements:
            if self.pending.pop((f.token, r.token), None) is not None:
                self.results.append((src, r.token, r.status == SUCCESS))
        return self.results


class QabResponder:
    """Ответчик. accept(q) → код статуса (решение SME, MLME-QAB.response)."""

    def __init__(self, mac, qab=True, accept=lambda q: SUCCESS):
        self.mac, self.qab, self.accept = mac, qab, accept
        self.quiet = []                        # [(начало, конец)] — SP точки без передачи

    def on_request(self, body, t_ppdu):
        """→ тело QAB Response или None (не наш BSSID / не QAB-способна)."""
        f = parse_frame(body)
        mine = [q for q in f.elements if q.target == self.mac]
        if not self.qab or not mine or f.action != ACT_QAB_REQ:
            return None
        out = []
        for q in mine:
            st = self.accept(q)
            if st == SUCCESS:
                self.quiet += quiet_intervals(t_ppdu, q)       # не больше Repetition Count интервалов
            out.append(encode_qp_resp(QpResp(q.token, q.target, st)))
        return encode_frame(ACT_QAB_RESP, f.token, f.requester, self.mac, out,
                            protected=f.category == CATEGORY_PROTECTED_DUAL)

    def allocations(self, tsf_low=lambda t: int(t) % (1 << 32)):
        """SP расписания (Extended Schedule) на тихие интервалы: источник и получатель — точка (AID 0)."""
        out = []
        for k, (a, b) in enumerate(self.quiet):
            ctrl = dict(allocation_id=1 + k % 15, allocation_type=0, pseudo_static=0, truncatable=0, extendable=0,
                        pcp_active=1, lp_sc_used=0, _r12=0)
            out.append(E.Allocation(ctrl, 0, AID_AP_PCP, AID_AP_PCP, tsf_low(a), int(b - a), 1, 0))
        return out

    def may_transmit(self, t0, t1):
        """11.35.3 b) 1): «the AP shall not transmit during the SP»."""
        return not any(t0 < b and a < t1 for a, b in self.quiet)


def check_quiet_tx(intervals, txs):
    """txs — [(начало, конец, что)] передач точки → нарушения «не передаёт в тихий SP»."""
    v = []
    for t0, t1, what in txs:
        for a, b in intervals:
            if t0 < b and a < t1:
                v.append(f'{what} @{float(t0):.1f} в тихом интервале [{float(a):.1f}, {float(b):.1f}) (11.35.3 b) 1))')
    return v
