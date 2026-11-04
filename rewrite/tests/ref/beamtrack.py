# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сопровождение луча (beam tracking) DMG по 802.11-2020 10.42.7 [p. 1964–1966]: запрос в TXVECTOR
(BEAM_TRACKING_REQUEST, PPDU_TYPE, TRN_LEN; поля заголовка PHY — 20.9.2.2.3 [p. 3003]), обязанности ответчика
(TRN-R на следующем PPDU с MCS > 0 в том же распределении; обратная связь BRP на TRN-T), предел времени (табл. 10-31,
9.4.2.127.4 [p. 1240], dot11BeamTrackingTimeLimit — C.3), когда инициатор вправе снова запросить TRN-T, неудача и
«опоздавший» ответ. Время — Fraction, мкс, моменты PHY-TXEND/PHY-RXEND «на эфире».

Состав:
  bt_time_limit(peer_field, own_mib)    — табл. 10-31 → предел в мкс или None («Transmit beam tracking is not
                                          supported»).
  Ppdu                                   — PPDU журнала: TXVECTOR сопровождения луча + BRP-поля обратной связи.
  Initiator                              — может ли запросить TRN-T (условия 10.42.7), исход запроса (успех / отказ по
                                          таймауту / ответ проигнорировать).
  Responder                              — что должен ответчик после принятого PPDU с запросом.
  check_bt_log(ppdus, limits)            — судья журнала пары STA (список Violation).

Не моделируется: CDMG Enhanced Beam Tracking (10.42.9), содержимое обратной связи (выбор BS-FBCK — «implementation
dependent»), выделение времени под ответ через RDG (у нас reverse direction отключён намеренно, 10.29.4), длительность
TRN-полей (это brp.brp_txtime)."""
from collections import namedtuple
from fractions import Fraction as Fr

from .timing import BRPIFS, BT_TIME_LIMIT_DEFAULT_CODE, DOT11_BEAM_TRACKING_TIME_LIMIT

REQUESTED, NOT_REQUESTED = 'BEAM-TRACKING-REQUESTED', 'BEAM-TRACKING-NOT-REQUESTED'
TRN_R, TRN_T = 'TRN-R', 'TRN-T'
FIELD_MAX = BT_TIME_LIMIT_DEFAULT_CODE            # поле 2 октета (рис. 9-549), MIB SYNTAX 0..65535


def bt_time_limit(peer_field, own_mib):
    """Табл. 10-31: A — DMG STA Beam Tracking Time Limit пира, B — свой dot11BeamTrackingTimeLimit (мкс).
    None — «Transmit beam tracking is not supported» (A = 0 или B = 0); при A, B в (0, 65 535) — большее («A ≥ B → A»,
    «A < B → B»); 65 535 с одной стороны — другая; обе 65 535 — DEFVAL dot11BeamTrackingTimeLimit (10 000 мкс).
    peer_field None — поле не передано (NOTE 1: инициатор не может судить о неудаче) → None."""
    if peer_field is None:
        return None
    a, b = int(peer_field), int(own_mib)
    assert 0 <= a <= FIELD_MAX and 0 <= b <= FIELD_MAX
    if a == 0 or b == 0:
        return None
    if a == FIELD_MAX and b == FIELD_MAX:
        return DOT11_BEAM_TRACKING_TIME_LIMIT
    if a == FIELD_MAX:
        return Fr(b)
    if b == FIELD_MAX:
        return Fr(a)
    return Fr(max(a, b))


def tx_tracking_supported(peer_field):
    """10.42.7: «A beam tracking initiator shall not initiate transmit beam tracking if the beam tracking responder
    has indicated lack of support by setting the DMG STA Beam Tracking Time Limit field to zero» (NOTE 2: такая
    сигнализация устарела, но действует)."""
    return peer_field != 0


# PPDU журнала. bt — BEAM_TRACKING_REQUEST; ptype — PPDU_TYPE (TRN-R | TRN-T | None); trn_len — TRN_LEN;
# trn — к PPDU добавлены AGC + TRN-подполя (тип ptype); alloc — номер распределения (SP/CBAP-окно); brp — PPDU несёт
# кадр BRP; tx_trn_req / fbck_type / bs_fbck — поля BRP (9.5.4, 9.4.2.129); fbck — кадр BRP с обратной связью по TRN-T.
Ppdu = namedtuple('Ppdu', 't te src dst mcs bt ptype trn_len trn alloc brp tx_trn_req fbck_type bs_fbck fbck',
                  defaults=(NOT_REQUESTED, None, 0, False, 0, False, 0, 0, None, False))


def request_kind(p):
    """Вид запроса в PPDU по TXVECTOR (10.42.7): 'rx' — инициатор просит TRN-R от ответчика (REQUESTED, TRN-R);
    'tx' — инициатор просит обратную связь по своим TRN-T (REQUESTED, TRN-T, TRN-подполя добавлены);
    'resp_rx' — инициатор даёт ответчику TRN-R для его приёма (NOT_REQUESTED, TRN_LEN > 0, TRN-R добавлены); None."""
    if p.bt == REQUESTED and p.ptype == TRN_R:
        return 'rx'
    if p.bt == REQUESTED and p.ptype == TRN_T:
        return 'tx'
    if p.bt == NOT_REQUESTED and p.trn_len > 0 and p.ptype == TRN_R:
        return 'resp_rx'
    return None


def check_request_vector(p):
    """Согласованность TXVECTOR запроса (10.42.7): TRN-T — «append an AGC field and TRN-T subfields to the PPDU»;
    приёмное сопровождение ответчиком — «append an AGC field and TRN-R subfields»; запрос TRN-R — TRN_LEN > 0 («the
    number of requested TRN subfields»). Возвращает список сообщений."""
    k, out = request_kind(p), []
    if k == 'tx' and not (p.trn and p.trn_len > 0):
        out.append('запрос TRN-T без AGC/TRN-T в PPDU (10.42.7)')
    if k == 'resp_rx' and not p.trn:
        out.append('TRN_LEN > 0, PPDU_TYPE TRN-R без TRN-R в PPDU (10.42.7)')
    if k == 'rx' and p.trn_len <= 0:
        out.append('запрос TRN-R с TRN_LEN = 0 (10.42.7)')
    return out


class Initiator:
    """Инициатор сопровождения луча к одному ответчику. limit — предел (bt_time_limit), peer_field — поле пира."""
    def __init__(self, peer_field, own_mib=DOT11_BEAM_TRACKING_TIME_LIMIT):
        self.peer_field = peer_field
        self.limit = bt_time_limit(peer_field, own_mib)
        self.last_tx_req = None           # PHY-TXEND последнего PPDU с запросом TRN-T
        self.fb_since = True              # с последнего запроса принят BRP с обратной связью

    def may_request_tx(self, t):
        """10.42.7: TRN-T можно запросить, если поддержано (поле ≠ 0) и выполнено одно из: «The time since the last
        PPDU it transmitted … that requested transmit beam tracking is greater than the beam tracking time limit plus
        BRPIFS»; «A BRP frame with the channel measurement feedback … has been received»."""
        if not tx_tracking_supported(self.peer_field):
            return False
        if self.last_tx_req is None or self.fb_since:
            return True
        if self.limit is None:
            return False                  # NOTE 1: без поля предел не определён — повтор «implementation dependent»
        return t - self.last_tx_req > self.limit + BRPIFS

    def sent_tx_request(self, t_txend):
        self.last_tx_req, self.fb_since = Fr(t_txend), False

    def feedback(self, t_rxend):
        """Исход обратной связи, принятой в t_rxend (PHY-RXEND PPDU с BRP): 'ok' — раньше предела; 'ignore' — «within a
        time period that is greater than or equal to the beam tracking time limit … should ignore it»."""
        self.fb_since = True
        if self.last_tx_req is None or self.limit is None:
            return 'ok'
        return 'ok' if t_rxend - self.last_tx_req < self.limit else 'ignore'

    def failed(self, t):
        """«If the beam tracking initiator does not receive the expected feedback … within a time period that is less
        than the beam tracking time limit of the last request, the beam tracking request has failed»."""
        return (self.last_tx_req is not None and not self.fb_since and self.limit is not None
                and t - self.last_tx_req >= self.limit)


class Responder:
    """Ответчик сопровождения луча к одному инициатору; limit — предел со своей стороны (табл. 10-31: A — поле
    инициатора, B — свой MIB)."""
    def __init__(self, initiator_field, own_mib=DOT11_BEAM_TRACKING_TIME_LIMIT):
        self.limit = bt_time_limit(initiator_field, own_mib)
        self.last_brp_fbck_type = None    # FBCK-TYPE последнего BRP инициатора с TX-TRN-REQ = 1 (для обратной связи)

    def rx_brp(self, p):
        if p.brp and p.tx_trn_req:
            self.last_brp_fbck_type = p.fbck_type

    def feedback_type(self):
        """«The feedback type shall be the same as the feedback type in the last BRP frame … with TX-TRN-REQ equal to 1.
        If the responder has never received [such] a BRP frame …, the responder shall respond with all subfields of the
        FBCK-TYPE field equal to 0 and set the BS-FBCK field to the index of the TRN-T subfield … received with the best
        quality.» → (fbck_type, нужен ли BS-FBCK)."""
        if self.last_brp_fbck_type is None:
            return 0, True
        return self.last_brp_fbck_type, False

    def may_send_feedback(self, t_req_rxend, t_fb_txend):
        """«shall not transmit a BRP frame with feedback … if the time period between PHY-RXEND.indication … of the
        PPDU that contains the beam tracking request and … PHY-TXEND.confirm … of the response BRP frame is longer
        than the beam tracking time limit»."""
        return self.limit is None or t_fb_txend - t_req_rxend <= self.limit


# =====================================================================================================================
# судья
# =====================================================================================================================
Violation = namedtuple('Violation', 'idx rule msg')


def check_bt_log(ppdus, fields, own_mib=None):
    """ppdus — PPDU пары STA по времени (Ppdu). fields — {STA: DMG STA Beam Tracking Time Limit, переданный этой STA
    (None — поле не передано)}; own_mib — {STA: dot11BeamTrackingTimeLimit} (по умолчанию — значение её поля, иначе
    DEFVAL). Правила:
      bt_vector      — согласованность TXVECTOR запроса (check_request_vector);
      bt_tx_unsup    — запрос TRN-T к STA, объявившей поле = 0 (10.42.7);
      bt_tx_early    — повторный запрос TRN-T раньше «limit + BRPIFS» без принятой обратной связи (10.42.7);
      bt_trn_r       — следующий PPDU ответчика инициатору в том же распределении с MCS > 0 без AGC/TRN-R или с иным
                       TRN_LEN (10.42.7: «shall include … TRN-R subfields appended to the next PPDU … that employs an
                       MCS index greater than 0. The value of the TRN_LEN … shall be equal»);
      bt_fb_late     — BRP с обратной связью ответчика позже предела после запроса TRN-T (10.42.7);
      bt_fb_type     — FBCK-TYPE обратной связи ≠ FBCK-TYPE последнего BRP инициатора с TX-TRN-REQ = 1 (или ≠ 0, если
                       такого не было) (10.42.7)."""
    own_mib = dict(own_mib or {})
    out = []
    pend_rx = {}          # (инициатор, ответчик) → (i, trn_len, alloc): ждём TRN-R
    pend_tx = {}          # (инициатор, ответчик) → (i, PHY-RXEND запроса у ответчика)
    inits, resps = {}, {}

    def mib(s):
        if s in own_mib:
            return own_mib[s]
        f = fields.get(s)
        return f if f not in (None, 0) else DOT11_BEAM_TRACKING_TIME_LIMIT

    def init_of(a, b):
        if (a, b) not in inits:
            inits[(a, b)] = Initiator(fields.get(b), mib(a))
        return inits[(a, b)]

    def resp_of(b, a):
        if (b, a) not in resps:
            resps[(b, a)] = Responder(fields.get(a), mib(b))
        return resps[(b, a)]

    for i, p in enumerate(ppdus):
        a, b = p.src, p.dst
        # обязанности a как ответчика инициатору b
        key = (b, a)
        if key in pend_rx and p.mcs > 0:
            j, n, alloc = pend_rx[key]
            if p.alloc == alloc:
                if not (p.trn and p.ptype == TRN_R and p.trn_len == n):
                    out.append(Violation(i, 'bt_trn_r', f'PPDU {a}→{b} MCS {p.mcs} после запроса TRN-R (PPDU {j}, '
                                                        f'TRN_LEN {n}) без TRN-R той же длины (10.42.7)'))
                del pend_rx[key]
        if p.brp and p.fbck and key in pend_tx:
            j, t_req = pend_tx.pop(key)
            r = resp_of(a, b)
            if not r.may_send_feedback(t_req, p.te):
                out.append(Violation(i, 'bt_fb_late', f'обратная связь {a}→{b} через {float(p.te - t_req):.1f} мкс '
                                                      f'после запроса > предела {float(r.limit)} (10.42.7)'))
            want, _ = r.feedback_type()
            if p.fbck_type != want:
                out.append(Violation(i, 'bt_fb_type', f'FBCK-TYPE {p.fbck_type} ≠ {want} (10.42.7)'))
            init_of(b, a).feedback(p.te)
        # a — инициатор запроса к b
        for m in check_request_vector(p):
            out.append(Violation(i, 'bt_vector', m))
        k = request_kind(p)
        if k == 'rx':
            pend_rx[(a, b)] = (i, p.trn_len, p.alloc)
        elif k == 'tx':
            ini = init_of(a, b)
            if not tx_tracking_supported(fields.get(b)):
                out.append(Violation(i, 'bt_tx_unsup', f'запрос TRN-T к {b}, объявившей Beam Tracking Time Limit = 0 '
                                                       f'(10.42.7)'))
            elif not ini.may_request_tx(p.t):
                out.append(Violation(i, 'bt_tx_early', f'повторный запрос TRN-T к {b} через '
                                                       f'{float(p.t - ini.last_tx_req):.1f} мкс без обратной связи '
                                                       f'(≤ предел {float(ini.limit)} + BRPIFS, 10.42.7)'))
            ini.sent_tx_request(p.te)
            pend_tx[(a, b)] = (i, p.te)
        if p.brp:
            resp_of(b, a).rx_brp(p)
    return out
