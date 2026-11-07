# SPDX-License-Identifier: AGPL-3.0-or-later
"""Адаптация линка DMG и измерение линка по 802.11-2020: общие правила 10.43.1 [p. 1970–1971], DMG TPC 10.43.2
[p. 1971], быстрая адаптация 10.43.3 [p. 1971–1972]; Link Measurement 11.10.11 [p. 2217]; кадры Radio Measurement
Action Link Measurement Request/Report (9.6.6.1 табл. 9-363, 9.6.6.4 рис. 9-862, 9.6.6.5 рис. 9-863 [p. 1460–1461]);
элементы TPC Report (9.4.2.16, рис. 9-175), DMG Link Margin (9.4.2.142, рис. 9-583, табл. 9-266 [p. 1262]), DMG Link
Adaptation Acknowledgment (9.4.2.143, рис. 9-584 [p. 1263]); поля Transmit Power Used / Max Transmit Power (9.4.1.19,
9.4.1.20), RCPI (9.4.2.37, табл. 9-176), DMG antenna ID (9.4.2.39), RSNI (9.4.2.40); бит Link Measurement Capability
Enabled поля RM Enabled Capabilities (табл. 9-179, бит 0); поля DMG Capabilities TPC, Fast Link Adaptation и Reverse
Direction (9.4.2.127.2) в правилах 10.43.3.

Поведение:
  LinkMeasResponder — отвечающая сторона (10.43.1, 11.10.11): Dialog Token ≠ 0 — измерение на следующем кадре от
                      запросившего; 0 — по любому принятому кадру; RA отчёта = TA запроса; DMG Link Margin — в отчёте
                      на запрос в PPDU Clause 20 (у DMG — всегда); AP с dot11RMLinkMeasurementActivated = false
                      запрос игнорирует; Reference Timestamp — младшие 4 октета TSF в конце PPDU измерения.
  TpcPeer           — получатель отчёта с Activity «уменьшить/увеличить мощность» (10.43.2): выполнил — отчёт с
                      LA Ack (Activity = полученному), не выполнил — может послать LA Ack с Activity 0; срок —
                      2·aPPDUMaxTime после подтверждения принятого отчёта.
  fla_*             — быстрая адаптация (10.43.3): кто может начать, условия PPDU запроса и отчёта, IFS ≤ SIFS
                      «заполняющими» PPDU, отчёт не позже BRPIFS; check_fla_exchange — последовательность PPDU.
  check_*           — тела кадров и элементов, пара запрос→отчёт, LA Ack (10.43.2).

Не моделируется: выбор MCS/Activity/мощности (стандарт: «implementation specific»), вычисление Link Margin («beyond the
scope»), RSNI по ANPI (11.10.9.4), CMMG (10.44), FST (Activity 4 — вне охвата); Radio Measurement Request/Report и
Neighbor Report (9.6.6.2/3/6/7) — только номера действий. Тип PPDU (поле AGGREGATION TXVECTOR) представлен флагом
agg; RD-протокол (10.29) — флагами rd_initiator/rd_responder (в open RD выключен — PLAN.md №35).

Представление: мощность — целые дБм, Link Margin — целые дБ (None — «не задано», −128), SNR — Fraction дБ (шаг 0,25);
время — Fraction мкс; нарушения — список строк."""
from collections import namedtuple
from fractions import Fraction as Fr

from . import elements as E
from . import fields as F
from .timing import BRPIFS, SIFS, SIFS_TOL, TSF_LOW_MOD, aPPDUMaxTime

# ---- номера (табл. 9-51, 9-363, 9-92) ----
CAT_RADIO_MEASUREMENT = 5           # табл. 9-51: «5 Radio Measurement», robust — Yes
ACT_RM_REQ, ACT_RM_REP, ACT_LM_REQ, ACT_LM_REP, ACT_NR_REQ, ACT_NR_RESP = 0, 1, 2, 3, 4, 5   # табл. 9-363
ACT_NAME = {ACT_RM_REQ: 'Radio Measurement Request', ACT_RM_REP: 'Radio Measurement Report',
            ACT_LM_REQ: 'Link Measurement Request', ACT_LM_REP: 'Link Measurement Report',
            ACT_NR_REQ: 'Neighbor Report Request', ACT_NR_RESP: 'Neighbor Report Response'}
EID_TPC_REPORT = E.element_key('TPC Report')[0]                       # 35
EID_DMG_LINK_MARGIN = E.element_key('DMG Link Margin')[0]             # 162
EID_DMG_LA_ACK = E.element_key('DMG Link Adaptation Acknowledgment')[0]   # 172
EID_RM_ENABLED = E.element_key('RM Enabled Capabilities')[0]          # 70
RM_LINK_MEAS_BIT = 0                # табл. 9-179: бит 0 — Link Measurement Capability Enabled

# табл. 11-22 (DMG MAC sublayer attributes): «aMinPPDUDurationForDMGMeasurement 5.27 µs» — перенести в timing.py
aMinPPDUDurationForDMGMeasurement = Fr(527, 100)
# 10.43.2: «shall not send a Link Measurement Report later than 2×aPPDUMaxTime after it acknowledged …»
LA_ACK_DEADLINE = 2 * aPPDUMaxTime
FLA_REPORT_MCS = 1                  # 10.43.3: отчёт быстрой адаптации — «shall be sent using MCS 1»

# ---- табл. 9-266: Activity ----
ACTIVITY_NO_CHANGE, ACTIVITY_MCS, ACTIVITY_DEC_POWER, ACTIVITY_INC_POWER = 0, 1, 2, 3
ACTIVITY_FST, ACTIVITY_POWER_CONSERVE, ACTIVITY_SLS = 4, 5, 6
ACTIVITY_NAME = {0: 'No change preferred', 1: 'Change(d) MCS', 2: 'Decrease(d) transmit power',
                 3: 'Increase(d) transmit power', 4: 'Fast session transfer (FST)', 5: 'Power conserve mode',
                 6: 'Perform SLS'}
ACTIVITY_POWER = (ACTIVITY_DEC_POWER, ACTIVITY_INC_POWER)

# ---- 9.4.2.142: поле MCS — 0–12 и 25–31 как есть; 133…140 — расширенные SC MCS ----
MCS_EXT_CODE = {133: '12.1', 134: '9.1', 135: '12.3', 136: '12.4', 137: '12.5', 138: '12.2', 140: '12.6'}
MCS_CODES = set(range(0, 13)) | set(range(25, 32)) | set(MCS_EXT_CODE)
LINK_MARGIN_NONE = -128             # 9.4.2.142: «set to –128 to indicate that no link margin is provided»
LM_LEN, LA_ACK_LEN, TPC_LEN = 8, 5, 2   # рис. 9-583 (без ID/Length), рис. 9-584, рис. 9-175
RCPI_RESERVED = range(221, 255)     # табл. 9-176: 221–254 Reserved; 255 — «Measurement not available»
RCPI_NA = RSNI_NA = 255
DMG_ANTENNA_IDS = range(0, 4)       # 9.4.2.39: «A specific DMG antenna has a DMG antenna ID between 0 and 3»


def mcs_name(code):
    """Поле MCS DMG Link Margin → имя MCS ('9.1', '12', …) или None (зарезервировано)."""
    if code in MCS_EXT_CODE:
        return MCS_EXT_CODE[code]
    return str(code) if code in MCS_CODES else None


def mcs_code(name):
    """Имя MCS → значение поля MCS (9.4.2.142)."""
    name = str(name)
    for c, n in MCS_EXT_CODE.items():
        if n == name:
            return c
    c = int(name)
    if c not in MCS_CODES or c in MCS_EXT_CODE:
        raise ValueError(f'MCS {name} не кодируется в DMG Link Margin (9.4.2.142)')
    return c


def _s8(b):
    return b - 256 if b & 0x80 else b


def _u8(v, what):
    if not -128 <= v <= 127:
        raise ValueError(f'{what} = {v} не помещается в 8 бит со знаком')
    return v & 0xFF


def rcpi(p_dbm):
    """табл. 9-176: RCPI по мощности приёма P дБм (None — «Measurement not available»)."""
    if p_dbm is None:
        return RCPI_NA
    p = Fr(p_dbm)
    if p < Fr(-1095, 10):
        return 0
    if p >= 0:
        return 220
    return (2 * (p + 110)).__floor__()


# =====================================================================================================================
# Элементы
# =====================================================================================================================
LinkMargin = namedtuple('LinkMargin', 'activity mcs margin snr ref_ts')   # mcs — значение поля; margin None = −128
LaAck = namedtuple('LaAck', 'activity ref_ts')


def snr_field(snr_db):
    """SNR DMG Link Margin. СПОРНО → принято (PLAN.md №36): 9.4.2.142 даёт только диапазон −13…50,75 дБ шагом 0,25 —
    кодирование как SNR 9.5.3 (тот же диапазон: 4·(SNR − 19) в дополнительном коде)."""
    return F.snr_report_raw(F.snr_quantize(snr_db))


def encode_link_margin(lm):
    m = LINK_MARGIN_NONE if lm.margin is None else lm.margin
    info = bytes([lm.activity, lm.mcs, _u8(m, 'Link Margin'), F.snr_report_raw(lm.snr)]) + \
        E.le(lm.ref_ts % TSF_LOW_MOD, 4)
    return E.encode_element(EID_DMG_LINK_MARGIN, info)


def parse_link_margin(info):
    b = E.known_info(info, LM_LEN, 'DMG Link Margin')        # табл. 9-92: расширяемый (10.28.8)
    m = _s8(b[2])
    return LinkMargin(b[0], b[1], None if m == LINK_MARGIN_NONE else m, F.snr_from_raw(b[3]),
                      int.from_bytes(b[4:8], 'little'))


def check_link_margin(lm):
    v = []
    if lm.activity not in ACTIVITY_NAME:
        v.append(f'DMG Link Margin: Activity {lm.activity} зарезервирован (табл. 9-266: 7–255)')
    if mcs_name(lm.mcs) is None:
        v.append(f'DMG Link Margin: MCS {lm.mcs} не из 0–12, 25–31, 133–138, 140 (9.4.2.142)')
    return v


def encode_la_ack(a):
    return E.encode_element(EID_DMG_LA_ACK, bytes([a.activity]) + E.le(a.ref_ts % TSF_LOW_MOD, 4))


def parse_la_ack(info):
    b = E.known_info(info, LA_ACK_LEN, 'DMG Link Adaptation Acknowledgment')
    return LaAck(b[0], int.from_bytes(b[1:5], 'little'))


def check_la_ack(a):
    if a.activity not in ACTIVITY_NAME:
        return [f'DMG LA Ack: Activity {a.activity} зарезервирован (табл. 9-266)']
    return []


def rm_link_meas(info):
    """RM Enabled Capabilities (9.4.2.45): бит 0 — Link Measurement Capability Enabled
    (= dot11RMLinkMeasurementActivated, табл. 9-179)."""
    return bool(info and info[0] & (1 << RM_LINK_MEAS_BIT))


# =====================================================================================================================
# Кадры Link Measurement Request / Report (тело Action без MAC-заголовка: Category, Radio Measurement Action, …)
# =====================================================================================================================
LmRequest = namedtuple('LmRequest', 'token tx_power_used max_tx_power')
LmReport = namedtuple('LmReport', 'token tpc_tx_power tpc_link_margin rx_antenna tx_antenna rcpi rsni margin ack extra')
LM_REQ_LEN = 5                      # рис. 9-862
LM_REP_FIXED = 11                   # рис. 9-863: 1 + 1 + 1 + 4 (TPC Report) + 1 + 1 + 1 + 1


def encode_lm_request(r):
    return bytes([CAT_RADIO_MEASUREMENT, ACT_LM_REQ, r.token, _u8(r.tx_power_used, 'Transmit Power Used'),
                  _u8(r.max_tx_power, 'Max Transmit Power')])


def encode_lm_report(r):
    out = bytes([CAT_RADIO_MEASUREMENT, ACT_LM_REP, r.token])
    out += E.encode_element(EID_TPC_REPORT, bytes([_u8(r.tpc_tx_power, 'Transmit Power'),
                                                   _u8(r.tpc_link_margin, 'Link Margin')]))
    out += bytes([r.rx_antenna, r.tx_antenna, r.rcpi, r.rsni])
    if r.margin is not None:
        out += encode_link_margin(r.margin)
    if r.ack is not None:
        out += encode_la_ack(r.ack)
    return out + bytes(r.extra or b'')


def action_of(body):
    """(категория, действие) тела Action или None."""
    return (body[0], body[1]) if len(body) >= 2 else None


def parse_lm_request(body):
    if action_of(body) != (CAT_RADIO_MEASUREMENT, ACT_LM_REQ):
        raise ValueError('не Link Measurement Request (табл. 9-363)')
    if len(body) < LM_REQ_LEN:
        raise ValueError(f'Link Measurement Request: {len(body)} октетов < {LM_REQ_LEN} (рис. 9-862)')
    return LmRequest(body[2], _s8(body[3]), _s8(body[4])), bytes(body[LM_REQ_LEN:])


def parse_lm_report(body):
    if action_of(body) != (CAT_RADIO_MEASUREMENT, ACT_LM_REP):
        raise ValueError('не Link Measurement Report (табл. 9-363)')
    if len(body) < LM_REP_FIXED:
        raise ValueError(f'Link Measurement Report: {len(body)} октетов < {LM_REP_FIXED} (рис. 9-863)')
    if body[3] != EID_TPC_REPORT or body[4] != TPC_LEN:
        raise ValueError(f'Link Measurement Report: на месте TPC Report элемент {body[3]}/{body[4]} (рис. 9-863, '
                         f'9.4.2.16: ID 35, Length 2)')
    margin = ack = None
    extra = b''
    els = E.parse_elements(bytes(body[LM_REP_FIXED:]))
    for k, el in enumerate(els):
        if el.eid == EID_DMG_LINK_MARGIN and margin is None and ack is None:
            margin = parse_link_margin(el.info)
        elif el.eid == EID_DMG_LA_ACK and ack is None:
            ack = parse_la_ack(el.info)
        else:
            extra = E.encode_elements(els[k:])
            break
    return LmReport(body[2], _s8(body[5]), _s8(body[6]), body[7], body[8], body[9], body[10], margin, ack, extra)


def check_lm_request(r, fla=False, extra=b''):
    """9.6.6.4, 9.4.1.20, 10.43.3. fla — запрос в роли начала быстрой адаптации (Action No Ack)."""
    v = []
    # 9.4.1.20: «It is less than or equal to the Max Transmit Power»
    if r.tx_power_used > r.max_tx_power:
        v.append(f'Link Measurement Request: Transmit Power Used {r.tx_power_used} > Max Transmit Power '
                 f'{r.max_tx_power} дБм (9.4.1.20)')
    if fla and r.token != 0:
        v.append('Link Measurement Request быстрой адаптации: Dialog Token ≠ 0 (10.43.3: «has its Dialog Token field '
                 'set to 0»)')
    if extra:
        v.append(f'Link Measurement Request: {len(extra)} октетов после Max Transmit Power (рис. 9-862)')
    return v


def check_lm_report(r, dmg=True):
    """Поля отчёта (рис. 9-863): DMG antenna ID, RCPI, элементы DMG Link Margin / LA Ack и порядок."""
    v = []
    if dmg:
        for n, a in (('Receive Antenna ID', r.rx_antenna), ('Transmit Antenna ID', r.tx_antenna)):
            if a not in DMG_ANTENNA_IDS:
                v.append(f'Link Measurement Report: {n} = {a} — у DMG 0…3 (9.4.2.39)')
    if r.rcpi in RCPI_RESERVED:
        v.append(f'Link Measurement Report: RCPI {r.rcpi} зарезервирован (табл. 9-176)')
    if r.margin is not None:
        v += check_link_margin(r.margin)
    if r.ack is not None:
        v += check_la_ack(r.ack)
    if r.extra:
        v.append('Link Measurement Report: после DMG Link Margin / DMG LA Ack — элементы не из рис. 9-863 (или '
                 'порядок нарушен)')
    return v


def check_report_reply(rep, req, req_ta, rep_ra, dmg=True):
    """Отчёт на запрос (10.43.1): RA = TA запроса, Dialog Token = токену запроса, у DMG — DMG Link Margin."""
    v = []
    if rep_ra != req_ta:
        v.append(f'RA отчёта {rep_ra} ≠ TA запроса {req_ta} (10.43.1)')
    if rep.token != req.token:
        v.append(f'Dialog Token отчёта {rep.token} ≠ токену запроса {req.token} (9.6.6.5)')
    if dmg and rep.margin is None:
        v.append('отчёт на запрос, посланный в DMG PPDU, без DMG Link Margin (10.43.1: «shall contain the DMG Link '
                 'Margin element»)')
    return v


def check_la_ack_reply(rep, peer_report):
    """10.43.2: LA Ack — только в ответ на отчёт с Activity «уменьшить/увеличить мощность»; Activity LA Ack — та же
    (выполнил) или 0 (не выполнил). peer_report — последний принятый от пира отчёт (или None)."""
    if rep.ack is None:
        return []
    got = peer_report.margin.activity if peer_report is not None and peer_report.margin is not None else None
    if got not in ACTIVITY_POWER:
        return [f'DMG LA Ack без принятого отчёта с Activity 2/3 (последний — {got}) (10.43.2: «shall not include … '
                f'unless … in response to a Link Measurement Report frame whose Activity field is equal to increase or '
                f'decrease transmit power»)']
    if rep.ack.activity not in (got, ACTIVITY_NO_CHANGE):
        return [f'DMG LA Ack: Activity {rep.ack.activity} — ни полученный {got}, ни 0 (10.43.2)']
    return []


# =====================================================================================================================
# Обмен 10.43.1 / 11.10.11
# =====================================================================================================================
Rx = namedtuple('Rx', 't_end src snr margin p_dbm rsni rx_antenna')   # измерение принятого PPDU; t_end — TSF мкс


class LinkMeasResponder:
    """Отвечающая STA. policy(rx) → (Activity, имя MCS) — «implementation specific» (9.4.2.142); tx_power — дБм, с
    которой будет послан отчёт (TPC Report, 9.4.2.16)."""
    def __init__(self, mac, activated=True, is_ap=False, policy=None, tx_power=10, tx_antenna=0):
        self.mac, self.activated, self.is_ap = mac, activated, is_ap
        self.policy = policy or (lambda rx: (ACTIVITY_NO_CHANGE, '1'))
        self.tx_power, self.tx_antenna = tx_power, tx_antenna
        self.pending = {}               # TA → (запрос, измерение кадра запроса): ждём следующий кадр (токен ≠ 0)
        self.last = {}                  # TA → последнее измерение (для токена 0)

    def _report(self, req, rx_req, rx):
        act, mcs = self.policy(rx)
        lm = LinkMargin(act, mcs_code(mcs), rx.margin, F.snr_quantize(rx.snr), int(rx.t_end) % TSF_LOW_MOD)
        # 9.6.6.5: TPC Report — мощность передачи отчёта и Link Margin кадра запроса (9.4.2.16); RCPI/RSNI и Receive
        # Antenna ID — «of the corresponding Link Measurement Request frame»; DMG Link Margin — по кадру измерения
        # (10.43.1), который для токена ≠ 0 — следующий кадр запросившего
        tpc_lm = rx_req.margin if rx_req.margin is not None else 0
        return LmReport(req.token, self.tx_power, tpc_lm, rx_req.rx_antenna, self.tx_antenna, rcpi(rx_req.p_dbm),
                        RSNI_NA if rx_req.rsni is None else rx_req.rsni, lm, None, b'')

    def on_request(self, ta, req, rx):
        """Принят Link Measurement Request в PPDU rx. Возвращает (RA, отчёт) сразу или None (ждём кадр / игнор)."""
        self.last[ta] = rx
        if not self.activated:
            # 11.10.11: «If dot11RMLinkMeasurementActivated is false in an AP or PCP …, it shall ignore the request»
            return None
        if req.token == 0:
            # 10.43.1: при токене 0 MCS — «based on any of the received frames» — берём кадр запроса
            return ta, self._report(req, rx, rx)
        self.pending[ta] = (req, rx)
        return None

    def on_rx(self, ta, rx):
        """Принят любой следующий PPDU от ta (10.43.1: «perform the measurement on the next frame received from the
        requesting STA»)."""
        self.last[ta] = rx
        if ta in self.pending:
            req, rx_req = self.pending.pop(ta)
            return ta, self._report(req, rx_req, rx)
        return None

    def unsolicited(self, ta, act=None, mcs='1'):
        """10.43.1: «A STA may send an unsolicited Link Measurement Report frame with the Dialog Token field set to
        0»."""
        rx = self.last[ta]
        policy = self.policy
        if act is not None:
            self.policy = lambda _rx: (act, mcs)
        try:
            return ta, self._report(LmRequest(0, 0, 0), rx, rx)
        finally:
            self.policy = policy


class TpcPeer:
    """STA, получившая отчёт с DMG Link Margin (10.43.2)."""
    def __init__(self, mac, implements=True, ack_when_not=True):
        self.mac, self.implements, self.ack_when_not = mac, implements, ack_when_not

    def on_report(self, report, t_acked, tx_report_template):
        """report — принятый отчёт; t_acked — конец подтверждения его приёма (Ack; у Action No Ack — конец PPDU
        отчёта, PLAN.md №37). Возвращает (крайний срок, отчёт с LA Ack) или None."""
        lm = report.margin
        if lm is None or lm.activity not in ACTIVITY_POWER:
            return None                 # LA Ack только на 2/3 (10.43.2, последний абзац)
        if self.implements:
            act = lm.activity
        elif self.ack_when_not:
            act = ACTIVITY_NO_CHANGE    # «shall be set to 0, indicating that the STA did not change its transmit power»
        else:
            return None
        # СПОРНО → принято (PLAN.md №37): Reference Timestamp LA Ack — Reference Timestamp полученного DMG Link Margin
        # (какую рекомендацию подтверждаем); текст 9.4.2.143 повторяет определение 9.4.2.142 дословно
        rep = tx_report_template._replace(token=0, ack=LaAck(act, lm.ref_ts))
        return t_acked + LA_ACK_DEADLINE, rep


def la_ack_ref_ok(ack, peer_lm, peer_report_end):
    """Reference Timestamp LA Ack: копия Reference Timestamp рекомендации или конец PPDU принятого отчёта
    (младшие 32 бита TSF; ± 1 мкс квант). PLAN.md №37."""
    if ack.ref_ts == peer_lm.ref_ts:
        return True
    if peer_report_end is None:
        return False
    d = (ack.ref_ts - int(peer_report_end)) % TSF_LOW_MOD
    return d <= 1 or d >= TSF_LOW_MOD - 1


# =====================================================================================================================
# 10.43.3 быстрая адаптация
# =====================================================================================================================
def check_fla_caps(sta_cap, who='STA'):
    """9.4.2.127.2, 10.43.3: Fast Link Adaptation = 1 требует поддержки RD (поле Reverse Direction = 1)."""
    if sta_cap.get('fast_link_adaptation') and not sta_cap.get('reverse_direction'):
        return [f'{who}: Fast Link Adaptation = 1 при Reverse Direction = 0 (10.43.3: «A STA that supports fast link '
                f'adaptation shall support the reverse direction protocol»)']
    return []


def fla_may_initiate(own_cap, peer_cap):
    """10.43.3: только если обе стороны объявили Fast Link Adaptation = 1."""
    return bool(own_cap.get('fast_link_adaptation')) and bool(peer_cap.get('fast_link_adaptation'))


# PPDU последовательности быстрой адаптации: frames — кортеж Frame
Frame = namedtuple('Frame', 'kind noack token immediate')     # kind: 'LM Request' | 'LM Report' | иное; immediate —
#                                                               требует немедленного ответа (Ack/BA)
Ppdu = namedtuple('Ppdu', 't te src dst mcs agg frames rd')   # rd: держатель с RDG (инициатор) / RD-ответ (ответчик)


def is_fla_request(p):
    """Начало быстрой адаптации (10.43.3): Link Measurement Request подтипа Action No Ack с токеном 0 в агрегированном
    PPDU."""
    return p.agg and any(f.kind == 'LM Request' and f.noack and f.token == 0 for f in p.frames)


def fla_ppdu_ok(p, what):
    """Общие условия PPDU 10.43.3: AGGREGATED, без кадров с немедленным ответом, длительность > aMinPPDU…"""
    v = []
    if not p.agg:
        v.append(f'{what}: PPDU не агрегированный (10.43.3: AGGREGATION = AGGREGATED)')
    if any(f.immediate for f in p.frames):
        v.append(f'{what}: в PPDU кадр, требующий немедленного ответа (10.43.3)')
    if p.te - p.t <= aMinPPDUDurationForDMGMeasurement:
        v.append(f'{what}: длительность {float(p.te - p.t):.2f} мкс ≤ aMinPPDUDurationForDMGMeasurement 5,27 мкс '
                 f'(10.43.3)')
    return v


def check_fla_exchange(seq, caps=None):
    """Последовательность PPDU, начиная с PPDU запроса быстрой адаптации (seq[0]). caps — {MAC: поля DMG STA
    Capability} или None. Возвращает (нарушения, заметки): заметка «откат на 10.43.1» — отчёт не по условиям 10.43.3
    (это разрешено: «If at least one of the conditions … is not met, the STA may follow the rules in 10.43.1»)."""
    v, notes = [], []
    req = seq[0]
    if not is_fla_request(req):
        return ['первый PPDU — не запрос быстрой адаптации (10.43.3)'], notes
    init, resp = req.src, req.dst
    if caps is not None:
        a, b = caps.get(init), caps.get(resp)
        if a is not None and b is not None and not fla_may_initiate(a, b):
            v.append(f'быстрая адаптация с {resp}: Fast Link Adaptation = {a.get("fast_link_adaptation")}/'
                     f'{b.get("fast_link_adaptation")} (10.43.3: «shall not initiate … with a peer STA that does not '
                     f'support fast link adaptation»)')
        if a is not None:
            v += check_fla_caps(a, init)
    v += fla_ppdu_ok(req, 'запрос быстрой адаптации')
    if req.rd is False:
        v.append('запрос быстрой адаптации вне RD: инициатор — не держатель с RDG (10.43.3: «shall be the RD '
                 'initiator»)')
    # ответчик: PPDU до отчёта и сам отчёт
    prev_end, rep = req.te, None
    fillers = []
    for p in seq[1:]:
        if p.src != resp:
            break
        gap = p.t - prev_end
        if any(f.kind == 'LM Report' for f in p.frames):
            rep = (p, gap)
            break
        fillers.append((p, gap))
        prev_end = p.te
    if rep is None:
        notes.append('отчёта ответчика вслед за запросом нет — откат на 10.43.1 или запрос не принят')
        return v, notes
    p, gap = rep
    cond = fla_ppdu_ok(p, 'отчёт быстрой адаптации')
    lm = next(f for f in p.frames if f.kind == 'LM Report')
    if not lm.noack:
        cond.append('отчёт быстрой адаптации — не Action No Ack (10.43.3)')
    if p.mcs != FLA_REPORT_MCS:
        cond.append(f'отчёт быстрой адаптации на MCS {p.mcs} ≠ 1 (10.43.3)')
    if p.t - req.te > BRPIFS:
        cond.append(f'отчёт через {float(p.t - req.te):.2f} мкс после запроса > BRPIFS (10.43.3)')
    for q, g in fillers + [rep]:
        if g > SIFS + SIFS_TOL:
            cond.append(f'промежуток {float(g):.2f} мкс > SIFS до PPDU ответчика (10.43.3: «shall keep the IFS not '
                        f'longer than SIFS»)')
    for q, _ in fillers:
        cond += fla_ppdu_ok(q, 'заполняющий PPDU ответчика')
    if cond:
        notes.append('откат на 10.43.1: ' + '; '.join(cond))
    else:
        mcs = {q.mcs for q, _ in fillers + [rep]}
        if len(mcs) > 1:
            notes.append(f'PPDU ответчика на разных MCS {sorted(mcs)} (10.43.3: «should use the same MCS»)')
    return v, notes


def fla_respond(req_te, payload, t_compute, mcs=FLA_REPORT_MCS, filler=Fr(6)):
    """Генератор ответчика 10.43.3 (рис. 10-95): отчёт готов через t_compute (SIFS < t_compute < BRPIFS); до него —
    заполняющие PPDU длительности filler (> aMinPPDU…) через SIFS. payload(t, te) → Ppdu отчёта. Возвращает список
    PPDU ответчика."""
    if not SIFS <= t_compute <= BRPIFS:
        raise ValueError('время вычисления отчёта вне [SIFS, BRPIFS] (рис. 10-95)')
    if filler <= aMinPPDUDurationForDMGMeasurement:
        raise ValueError('заполняющий PPDU должен быть длиннее aMinPPDUDurationForDMGMeasurement (10.43.3)')
    out, t = [], req_te + SIFS
    while t < req_te + t_compute:
        out.append(Ppdu(t, t + filler, None, None, mcs, True, (Frame('QoS Null', True, None, False),), True))
        t = t + filler + SIFS
    out.append(payload(t))
    return out
