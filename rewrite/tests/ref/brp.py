# SPDX-License-Identifier: AGPL-3.0-or-later
"""Beam Refinement Protocol (BRP) DMG по 802.11-2020: фаза BRP (10.42.3.1), BRP setup (10.42.3.2), MIDC — общие
правила, MID+BC, только MID, только BC (10.42.6.3), исполнение фазы BRP и транзакции уточнения (10.42.6.4.1–
10.42.6.4.3), настройка антенн во время транзакции (10.42.6.4.4), BRPIFS (10.3.2.3.9), прерывание по
dot11MaxBFTime (10.42.1). Кадр BRP (9.6.21.3), поле BRP Request (9.5.4), элемент DMG Beam Refinement (9.4.2.129,
рис. 9-558..9-560, табл. 9-255/9-256), размер Channel Measurement Feedback (9.4.2.136, табл. 9-263/9-264), BRP PPDU
и TRN (20.9.2.2), TXTIME с TRN (20.11.3). Время — Fraction, мкс, моменты «на эфире».

Состав:
  BrpRequest, FbckReq, FbckType, BeamRefinement  — кодеки полей (encode/parse/validate).
  BrpFrame, brp_frame_length, cmf_octets         — тело кадра BRP и длина PSDU.
  brp_txtime, Ppdu                               — длительность BRP PPDU (с AGC+TRN), событие эфира.
  Participant, run_transaction                   — генератор транзакции по стандарту (инициатор/ответчик).
  check_brp_log                                  — судья: транзакции, BRPIFS, ответы на запросы, бит Initiator,
                                                   поле Duration, агрегация, AWV полей TRN-R.
  midc_subphases, check_setup, check_mid, check_bc и др. — BRP setup и MIDC.
  rx_config_*, trn_r_tx_awv, reciprocity_awv     — 10.42.6.4.4.

Не моделируется: выбор лучшего AWV/сектора (зависит от реализации, 10.42.6.4.1 «implementation dependent»),
содержимое измерений канала (только размеры), сопровождение луча (10.42.7, 10.42.9), CDMG/CMMG/EDMG-расширения
(Enhanced Beam Tracking и SSW Report в кадре BRP считаются отсутствующими), LP SC режим (20.6), несколько антенн
при BRP (поле TX DMG Antenna ID только кодируется), выделение SP под BRP после A-BFT (10.42.5.3)."""
from fractions import Fraction as Fr
from math import ceil

from .cbap import Violation, ceil_us
from .timing import (aSBIFSAccuracy, aSBIFSTime, aSlotTime, BRP_TXN_TIMEOUT, BRPIFS, BRPIFS_MIN, DOT11_MAX_BF_TIME,
                     L_RX_MAX, SIFS, SIFS_TOL, T_BRP_DATA_MIN_SC, T_CE, T_HEADER, T_STF, T_TRN_UNIT,
                     TX_SECTOR_NOT_SWEPT, txtime_control, txtime_sc)

# ---------------- постоянные ----------------
# BRPIFS/BRPIFS_MIN (10.3.2.3.9), BRP_TXN_TIMEOUT (10.42.3.1 b)), T_TRN_UNIT и T_BRP_DATA_MIN_SC (20.11.3),
# L_RX_MAX и TX_SECTOR_NOT_SWEPT (9.5.4), DOT11_MAX_BF_TIME (MIB) — timing.py (одно определение на все модули).
# Табл. 20-22 (N_CWmin для SC BRP PPDU, базовые MCS 1..12; 9.1, 12.1..12.6 — EDMG-продолжение таблицы не нужно).
NCW_MIN = {1: 12, 2: 12, 3: 12, 4: 12, 5: 12, 6: 23, 7: 23, 8: 23, 9: 23, 10: 46, 11: 46, 12: 46}
# Табл. 9-255/9-256: «Number of Taps»: 0 – 1 tap, 1 – 5, 2 – 15, 3 – 63.
NTAPS = {0: 1, 1: 5, 2: 15, 3: 63}
# табл. 20-1 TRN_LEN «range 0–16» (L_RX_MAX 9.5.4 — timing.py).
TRN_LEN_MAX = 16
SUBFIELDS_PER_UNIT = 4                       # 9.5.4: «TRN-R subfields is equal to … L-RX … multiplied by 4»; 20.9.2.2.6
# Табл. 9-92: DMG Beam Refinement — Element ID 153; табл. 9-51: категория Unprotected DMG = 20;
# табл. 9-486: Unprotected DMG Action BRP = 1.
EID_DMG_BEAM_REFINEMENT = 153
CATEGORY_UNPROTECTED_DMG = 20
UNPROT_DMG_ACTION_BRP = 1
# 9.3.3.14 / 9.3.3.1: кадр управления — FC 2 + Duration 2 + A1/A2/A3 6·3 + Sequence Control 2 = 24, FCS 4
# (HT Control не используется DMG).
MGMT_HDR, FCS = 24, 4
BRP_TEMPLATE_BODY = 1 + 1 + 1 + 4 + 7        # табл. 9-488: Category, Unprot. DMG Action, Dialog Token, BRP Req., эл.
BRP_MIN_LEN = MGMT_HDR + BRP_TEMPLATE_BODY + FCS   # 42 октета


def _bits(v, lo, n):
    return (v >> lo) & ((1 << n) - 1)


def _put(v, lo, n):
    assert 0 <= v < (1 << n), (v, n)
    return v << lo


# ---------------- 9.5.4 BRP Request field (рис. 9-850) ----------------
class BrpRequest:
    """B0–B4 L-RX, B5 TX-TRN-REQ, B6 MID-REQ, B7 BC-REQ, B8 MID-Grant, B9 BC-Grant, B10 Chan-FBCK-CAP,
    B11–B16 TX Sector ID, B17–B24 Other_AID, B25–B26 TX DMG Antenna ID, B27–B31 Reserved (4 октета)."""
    FIELDS = (('l_rx', 0, 5), ('tx_trn_req', 5, 1), ('mid_req', 6, 1), ('bc_req', 7, 1), ('mid_grant', 8, 1),
              ('bc_grant', 9, 1), ('chan_fbck_cap', 10, 1), ('tx_sector_id', 11, 6), ('other_aid', 17, 8),
              ('tx_antenna_id', 25, 2))
    __slots__ = tuple(f[0] for f in FIELDS)

    def __init__(self, **kw):
        for name, _, _ in self.FIELDS:
            setattr(self, name, kw.pop(name, 0))
        assert not kw, kw

    def encode(self):
        v = 0
        for name, lo, n in self.FIELDS:
            v |= _put(int(getattr(self, name)), lo, n)
        return v.to_bytes(4, 'little')

    @classmethod
    def parse(cls, b):
        v = int.from_bytes(bytes(b[:4]), 'little')
        return cls(**{name: _bits(v, lo, n) for name, lo, n in cls.FIELDS})

    def validate(self):
        """Список нарушений 9.5.4."""
        out = []
        if self.l_rx > L_RX_MAX:            # «Values outside this range are reserved»
            out.append('L-RX > 16 (резерв, 9.5.4)')
        return out

    def trn_r_subfields(self):
        """9.5.4: при MID-REQ = 0 запрошено L-RX·4 подполей TRN-R."""
        return self.l_rx * SUBFIELDS_PER_UNIT

    def has_training_requests(self):
        return self.l_rx > 0 or bool(self.tx_trn_req)

    def __eq__(self, o):
        return isinstance(o, BrpRequest) and all(getattr(self, f) == getattr(o, f) for f in self.__slots__)

    def __repr__(self):
        return 'BrpRequest(' + ', '.join(f'{f}={getattr(self, f)}' for f in self.__slots__ if getattr(self, f)) + ')'


# ---------------- 9.4.2.129 DMG Beam Refinement element ----------------
class FbckReq:
    """Рис. 9-559: B0 SNR Requested, B1 Channel Measurement Requested, B2–B3 Number of Taps Requested,
    B4 Sector ID Order Requested."""
    FIELDS = (('snr', 0, 1), ('chan', 1, 1), ('ntaps', 2, 2), ('sido', 4, 1))
    __slots__ = tuple(f[0] for f in FIELDS)

    def __init__(self, **kw):
        for name, _, _ in self.FIELDS:
            setattr(self, name, kw.pop(name, 0))
        assert not kw, kw

    def value(self):
        return sum(_put(int(getattr(self, n)), lo, w) for n, lo, w in self.FIELDS)

    @classmethod
    def from_value(cls, v):
        return cls(**{n: _bits(v, lo, w) for n, lo, w in cls.FIELDS})

    def any(self):
        return self.value() != 0


class FbckType:
    """Рис. 9-560: B0 SNR Present, B1 Channel Measurement Present, B2 Tap Delay Present, B3–B4 Number of Taps
    Present, B5–B11 Number of Measurements, B12 Sector ID Order Present, B13 Link Type, B14 Antenna Type,
    B15–B17 Number of Beams."""
    FIELDS = (('snr', 0, 1), ('chan', 1, 1), ('tap_delay', 2, 1), ('ntaps', 3, 2), ('nmeas', 5, 7), ('sido', 12, 1),
              ('link_type', 13, 1), ('antenna_type', 14, 1), ('nbeams', 15, 3))
    __slots__ = tuple(f[0] for f in FIELDS)

    def __init__(self, **kw):
        for name, _, _ in self.FIELDS:
            setattr(self, name, kw.pop(name, 0))
        assert not kw, kw

    def value(self):
        return sum(_put(int(getattr(self, n)), lo, w) for n, lo, w in self.FIELDS)

    @classmethod
    def from_value(cls, v):
        return cls(**{n: _bits(v, lo, w) for n, lo, w in cls.FIELDS})


class BeamRefinement:
    """Рис. 9-558 (биты после Element ID/Length): B16 Initiator, B17 TX-train-response, B18 RX-train-response,
    B19 TX-TRN-OK, B20 TXSS-FBCK-REQ, B21–B26 BS-FBCK, B27–B28 BS-FBCK DMG Antenna ID, B29–B33 FBCK-REQ,
    B34–B51 FBCK-TYPE, B52 MID Extension, B53 Capability Request, B54–B55 Reserved. Тело — 5 октетов.
    СПОРНО: BS-FBCK — 6 бит (индекс TRN-T с 1), а TRN_LEN до 16 даёт 64 подполя TRN-T: индекс 64 не кодируется.
    Принято: максимум 63 (encode отвергает 64); второе прочтение (индекс по модулю 64) текстом не поддержано."""
    FIELDS = (('initiator', 0, 1), ('tx_train_resp', 1, 1), ('rx_train_resp', 2, 1), ('tx_trn_ok', 3, 1),
              ('txss_fbck_req', 4, 1), ('bs_fbck', 5, 6), ('bs_fbck_ant', 11, 2), ('fbck_req', 13, 5),
              ('fbck_type', 18, 18), ('mid_ext', 36, 1), ('cap_req', 37, 1))
    __slots__ = tuple(f[0] for f in FIELDS)
    BODY = 5

    def __init__(self, **kw):
        for name, _, _ in self.FIELDS:
            setattr(self, name, kw.pop(name, 0))
        if not isinstance(self.fbck_req, FbckReq):
            self.fbck_req = FbckReq.from_value(self.fbck_req)
        if not isinstance(self.fbck_type, FbckType):
            self.fbck_type = FbckType.from_value(self.fbck_type)
        assert not kw, kw

    def encode(self):
        v = 0
        for name, lo, n in self.FIELDS:
            x = getattr(self, name)
            x = x.value() if isinstance(x, (FbckReq, FbckType)) else int(x)
            v |= _put(x, lo, n)
        return bytes([EID_DMG_BEAM_REFINEMENT, self.BODY]) + v.to_bytes(self.BODY, 'little')

    @classmethod
    def parse(cls, b):
        assert b[0] == EID_DMG_BEAM_REFINEMENT and b[1] == cls.BODY, bytes(b[:2])
        v = int.from_bytes(bytes(b[2:2 + cls.BODY]), 'little')
        return cls(**{name: _bits(v, lo, n) for name, lo, n in cls.FIELDS})


# ---------------- 9.4.2.136: размер Channel Measurement Feedback ----------------
def cmf_payload(ft):
    """Табл. 9-263/9-264: SNR — N_meas·8 бит; Channel Measurement — N_meas·N_taps·16 бит; Tap Delay — N_taps·8 бит;
    Sector ID Order — (6 + 2) бит на элемент списка (N_meas, при MIDC — N_beam). 9.4.2.129: «When both N_meas
    and N_beam … are equal to 0, the Channel Measurement Feedback element is not present»."""
    if ft.nmeas == 0 and ft.nbeams == 0:
        return 0
    taps = NTAPS[ft.ntaps]
    n_list = ft.nmeas if ft.nmeas else ft.nbeams
    return (ft.snr * ft.nmeas + ft.chan * ft.nmeas * taps * 2 + ft.tap_delay * taps + ft.sido * n_list)


def cmf_octets(payload):
    """9.6.21.3: больше 255 октетов — несколько элементов, каждый не последний — 257 октетов (2 + 255)."""
    if payload == 0:
        return 0
    return payload + 2 * ceil(Fr(payload, 255))


class BrpFrame:
    """Кадр BRP (Action No Ack, 9.6.21.3, табл. 9-488): Category 20, Unprotected DMG Action 1, Dialog Token,
    BRP Request (9.5.4), DMG Beam Refinement (9.4.2.129), 0+ Channel Measurement Feedback."""
    __slots__ = ('req', 'bre', 'token', 'cmf')

    def __init__(self, req=None, bre=None, token=0, cmf=None):
        self.req = req if req is not None else BrpRequest()
        self.bre = bre if bre is not None else BeamRefinement()
        self.token = token
        # cmf: None — по FBCK-TYPE (cmf_payload); иначе явный размер полезной нагрузки CMF, октеты
        self.cmf = cmf

    def cmf_payload(self):
        return cmf_payload(self.bre.fbck_type) if self.cmf is None else self.cmf

    def body(self):
        return (bytes([CATEGORY_UNPROTECTED_DMG, UNPROT_DMG_ACTION_BRP, self.token]) + self.req.encode()
                + self.bre.encode())

    @property
    def length(self):
        """Длина PSDU, октеты: заголовок управления + тело + CMF + FCS."""
        return MGMT_HDR + len(self.body()) + cmf_octets(self.cmf_payload()) + FCS

    def has_requests(self):
        """«Запросы» кадра: обучение (L-RX > 0, TX-TRN-REQ, 10.42.3.1), обратная связь TXSS (TXSS-FBCK-REQ,
        10.42.6.4.1), Capability Request (9.4.2.129), MID-REQ/BC-REQ (9.5.4)."""
        r, e = self.req, self.bre
        return bool(r.l_rx or r.tx_trn_req or r.mid_req or r.bc_req or e.txss_fbck_req or e.cap_req)

    def __repr__(self):
        e = self.bre
        flags = [n for n in ('initiator', 'tx_train_resp', 'rx_train_resp', 'tx_trn_ok', 'txss_fbck_req',
                             'mid_ext', 'cap_req') if getattr(e, n)]
        return f'BRP({self.req}, {"+".join(flags)}, bs={e.bs_fbck})'


def brp_frame_length(frame):
    return frame.length


# ---------------- 20.9.2.2, 20.11.3: BRP PPDU ----------------
TRN_R, TRN_T = 'TRN-R', 'TRN-T'               # TXVECTOR PPDU_TYPE (табл. 20-1); PPDU Type 0 / 1 (20.9.2.2.3)


def brp_txtime(length, mcs, n_trn=0):
    """20.11.3: SC, N_TRN > 0: T_STF + T_CE + T_header + max{T_Data, (α·β + γ)·T_C} + N_TRN·T_TRN-Unit;
    N_TRN = 0 — обычный TXTIME. Control mode: обычный TXTIME + N_TRN·T_TRN-Unit."""
    assert 0 <= n_trn <= TRN_LEN_MAX
    if mcs == 0:
        return txtime_control(length) + n_trn * T_TRN_UNIT
    t = txtime_sc(length, mcs)
    if n_trn == 0:
        return t
    t_data = t - (T_STF + T_CE + T_HEADER)
    return T_STF + T_CE + T_HEADER + max(t_data, T_BRP_DATA_MIN_SC) + n_trn * T_TRN_UNIT


class Ppdu:
    """Событие эфира. kind — 'BRP' или иной кадр ('SSW-Ack', 'SSW-Feedback', 'Data', 'Ack', …).
    trn_len — N (Training Length, единицы TRN), ppdu_type — TRN-R / TRN-T (20.9.2.2.3).
    lost — адресат не принял. dur — поле Duration (мкс) или None. ampdu — виды кадров в одном A-MPDU с этим.
    tx_awv / trn_awv — AWV преамбулы/данных и полей TRN-R (10.42.6.4.4). phase — 'setup'/'MID'/'BC'/None.
    bt — TXVECTOR BEAM_TRACKING_REQUEST = BEAM-TRACKING-REQUESTED (запрос сопровождения луча, 10.42.7)."""
    __slots__ = ('t', 'src', 'dst', 'kind', 'frame', 'mcs', 'length', 'trn_len', 'ppdu_type', 'lost', 'dur',
                 'ampdu', 'tx_awv', 'trn_awv', 'phase', 'bt')

    def __init__(self, t, src, dst, kind='BRP', frame=None, mcs=1, length=None, trn_len=0, ppdu_type=None,
                 lost=False, dur=None, ampdu=(), tx_awv=None, trn_awv=None, phase=None, bt=False):
        self.bt = bt
        self.t, self.src, self.dst, self.kind, self.frame, self.mcs = Fr(t), src, dst, kind, frame, mcs
        self.length = length if length is not None else (frame.length if frame is not None else 14)
        self.trn_len, self.ppdu_type, self.lost, self.dur, self.ampdu = trn_len, ppdu_type, lost, dur, tuple(ampdu)
        self.tx_awv, self.trn_awv, self.phase = tx_awv, trn_awv, phase

    @property
    def airtime(self):
        return brp_txtime(self.length, self.mcs, self.trn_len)

    @property
    def end(self):
        """10.3.2.3.9: BRPIFS отсчитывается от конца последнего символа PPDU «or training field if present»."""
        return self.t + self.airtime

    @property
    def is_brp(self):
        return self.kind == 'BRP'

    def is_brp_rx(self):
        """20.9.2.2.1: BRP-RX — Training Length > 0 и PPDU Type 0."""
        return self.trn_len > 0 and self.ppdu_type == TRN_R

    def is_brp_tx(self):
        """20.9.2.2.1: BRP-TX — Training Length > 0 и PPDU Type 1."""
        return self.trn_len > 0 and self.ppdu_type == TRN_T

    def trn_subfields(self):
        """20.9.2.2.6: N единиц TRN по 4 подполя."""
        return self.trn_len * SUBFIELDS_PER_UNIT

    def __repr__(self):
        return f'{self.kind}@{float(self.t):.3f}({self.src}->{self.dst} N={self.trn_len} {self.ppdu_type} {self.frame})'


def brp_duration(t_end, alloc_end):
    """10.42.6.4.1: Duration кадра BRP — «time remaining until the end of the current allocation» (SP) или
    «until the end of the TXOP»; отсчёт от конца PPDU, дробное — вверх (9.2.5.1)."""
    return ceil_us(alloc_end - t_end)


def bf_brp_expired(t_start, t_now, bi_us, max_bf_time=DOT11_MAX_BF_TIME):
    """10.42.1: STA «shall abort a BRP if the BRP is not completed within dot11MaxBFTime beacon intervals from the
    start of the BRP». СПОРНО: «within N beacon intervals» — как время N·BI от начала (принято) или как граница
    N-го TBTT после начала; второе требует сетки BI и здесь не моделируется."""
    return t_now - t_start > max_bf_time * bi_us


# ---------------- 10.42.6.4: генератор транзакции ----------------
class Participant:
    """Участник транзакции уточнения луча (10.42.6.4.1–10.42.6.4.2).
    rx_units — сколько единиц TRN-R запросить (L-RX, 0 — не нужно); tx_units — сколько единиц TRN-T передать
    для обучения передачи (0 — не нужно); trn_with_request — прикладывать TRN-T сразу к запросу (рис. 10-72)
    или сначала запросить без TRN-T (рис. 10-87); fbck_req — тип обратной связи для TX-обучения;
    txss_fbck — запросить список секторов TXSS; sls_sectors — [(sector_id, snr)] из последнего TXSS
    (для ответа на TXSS-FBCK-REQ); ntaps_cap — код числа отводов, который STA умеет вернуть;
    best_trn(n) → индекс лучшего TRN-T (1..n), выбор зависит от реализации."""

    def __init__(self, name, rx_units=0, tx_units=0, trn_with_request=True, fbck_req=None, txss_fbck=False,
                 sls_sectors=(), ntaps_cap=0, mcs=1, best_trn=None, chan_cap=0):
        self.name = name
        self.rx_units, self.tx_units, self.trn_with_request = rx_units, tx_units, trn_with_request
        self.fbck_req = fbck_req if fbck_req is not None else FbckReq()
        self.txss_fbck, self.sls_sectors, self.ntaps_cap, self.mcs = txss_fbck, list(sls_sectors), ntaps_cap, mcs
        self.best_trn = best_trn or (lambda n: 1)
        self.chan_cap = chan_cap
        self.need_rx = rx_units > 0
        self.need_tx = tx_units > 0
        self.need_txss = txss_fbck
        self.tx_ok_received = False          # получен TX-TRN-OK без TX-train-response — должны прислать TRN-T
        self.last_tx_initiator = False
        self.got_sector_list = None

    def pending(self):
        return self.need_rx or self.need_tx or self.need_txss

    def consume(self, ppdu):
        """Учесть принятый от пира PPDU: что из своих нужд выполнено."""
        f = ppdu.frame
        if self.need_rx and ppdu.is_brp_rx() and f.bre.rx_train_resp:
            self.need_rx = False
        if self.need_tx and f.bre.tx_train_resp:
            self.need_tx = False
        if f.bre.tx_trn_ok and not f.bre.tx_train_resp:
            self.tx_ok_received = True
        if self.need_txss and f.bre.fbck_type.snr and f.bre.fbck_type.sido:
            self.need_txss = False
            self.got_sector_list = f.bre.fbck_type.nmeas

    def build(self, rx=None, initiator=False):
        """Кадр-ответ на rx (или первый запрос при rx = None): (BrpFrame, trn_len, ppdu_type)."""
        req, bre = BrpRequest(), BeamRefinement(initiator=int(initiator))
        trn_len, ptype = 0, None
        forbid_rx_req = False
        if rx is not None:
            f = rx.frame
            # 10.42.6.4.1: на L-RX > 0 — BRP PPDU с L-RX единицами TRN-R (20.9.2.2.3) и RX-train-response = 1
            if f.req.l_rx > 0:
                trn_len, ptype = f.req.l_rx, TRN_R
                bre.rx_train_resp = 1
            if f.req.tx_trn_req:
                bre.tx_trn_ok = 1
                if rx.is_brp_tx():
                    # 10.42.6.4.1: TX-TRN-OK = TX-train-response = 1, BS-FBCK — лучший TRN-T (с 1, 9.4.2.129)
                    n = rx.trn_subfields()
                    bre.tx_train_resp = 1
                    bre.bs_fbck = self.best_trn(n)
                    fr = f.bre.fbck_req
                    ntaps = min(fr.ntaps, self.ntaps_cap)  # «less than or equal to the number of taps … requested»
                    chan = fr.chan and self.chan_cap      # канал — только при Chan-FBCK-CAP (9.5.4, табл. 10-30)
                    bre.fbck_type = FbckType(snr=fr.snr, chan=chan, ntaps=ntaps,
                                             nmeas=n if (fr.snr or chan) else 0)
                else:
                    # 10.42.6.4.1: запрос без TRN-T — TX-TRN-OK = 1, TX-train-response = 0, L-RX = 0
                    forbid_rx_req = True
            if f.bre.txss_fbck_req:
                # 10.42.6.4.1: SNR Present = 1, Sector ID Order Present = 1, N_meas — число принятых секторов
                bre.fbck_type = FbckType(snr=1, sido=1, nmeas=len(self.sls_sectors))
        # свои запросы
        if self.need_rx and not forbid_rx_req:
            req.l_rx = self.rx_units
        if self.need_tx:
            req.tx_trn_req = 1
            bre.fbck_req = FbckReq(**{n: getattr(self.fbck_req, n) for n in ('snr', 'chan', 'ntaps')})  # SIDO Req = 0
            if ptype is None and (self.trn_with_request or self.tx_ok_received):
                trn_len, ptype = self.tx_units, TRN_T
                self.tx_ok_received = False
        elif self.need_txss and not req.tx_trn_req:
            # 10.42.6.4.1: TXSS-FBCK-REQ = 1, SNR Requested = 1, прочие FBCK-REQ = 0; не вместе с TX-TRN-REQ
            bre.txss_fbck_req = 1
            bre.fbck_req = FbckReq(snr=1)
        self.last_tx_initiator = bool(initiator)
        return BrpFrame(req, bre), trn_len, ptype


def run_transaction(init, resp, t0=0, gap=SIFS, lose=(), max_frames=64, alloc_end=None):
    """Транзакция уточнения луча от init к resp (10.42.6.4.2): первый кадр — с Initiator = 1; участник отвечает
    на кадр BRP кадром BRP через gap (≥ SIFS, ≤ BRPIFS, 10.42.3.1); инициатор заканчивает, получив кадр без
    запросов и не имея своих нужд (10.42.3.1 a)); при потере (номер кадра в lose) инициатор повторяет кадр через
    BRPIFS (10.42.6.4.1) — либо транзакция завершается по BRPIFS + aSlotTime (10.42.3.1 b)), если повторов нет.
    СПОРНО: ответчик отвечает и на кадр без запросов («A beam refinement transaction participant shall respond to a
    BRP frame with a BRP frame», 10.42.6.4.2; условие a) требует, чтобы инициатор получил кадр без запросов) —
    поэтому на рис. 10-72 после последнего кадра инициатора будет ещё кадр ответчика без запросов; второе
    прочтение (рис. 10-72 — полный обмен из трёх кадров) противоречит 10.42.6.4.2."""
    log, t = [], Fr(t0)
    frame, n, pt = init.build(None, initiator=True)
    cur, peer = init, resp
    initiator_bits = {init.name: True, resp.name: False}
    k = 0
    while k < max_frames:
        p = Ppdu(t, cur.name, peer.name, 'BRP', frame, cur.mcs, trn_len=n, ppdu_type=pt, lost=k in lose)
        if alloc_end is not None:
            p.dur = brp_duration(p.end, alloc_end)
        log.append(p)
        k += 1
        if p.lost:
            if cur is init:                  # 10.42.6.4.1: повтор кадра с Initiator = 1 через BRPIFS
                t = p.end + BRPIFS
                continue
            # потерян ответ: инициатор повторяет свой последний кадр через BRPIFS после него
            last = [e for e in log if e.src == init.name][-1]
            t = max(p.end + SIFS, last.end + BRPIFS)
            cur, peer = init, resp
            frame, n, pt = last.frame, last.trn_len, last.ppdu_type
            continue
        peer.consume(p)
        if peer is init and not p.frame.has_requests() and not init.pending():
            break                            # 10.42.3.1 a)
        # 10.42.6.4.1: бит Initiator = 1, если предыдущий принятый кадр не BRP или свой последний BRP был с 1
        reply, n, pt = peer.build(p, initiator=initiator_bits[peer.name])
        t = p.end + gap
        frame = reply
        cur, peer = peer, cur
    return log


# ---------------- 10.42.6.4.4: конфигурация антенн ----------------
def rx_config_rx_requester(receiving_trn_r, rx_trained, brp_since_sls, sls_had_rxss):
    """STA, запросившая RX-обучение: при приёме TRN-R — перебор AWV; иначе «best known receive antenna
    configuration» по прошлому BRP RX-обучению или RXSS; без BRP после SLS и без RXSS — квази-омни (should)."""
    if receiving_trn_r:
        return 'sweep'
    if rx_trained or sls_had_rxss:
        return 'best'
    if not brp_since_sls:
        return 'quasi-omni'
    return 'best'


def rx_config_tx_responder(other_aid_both, other_aid, rx_trained, brp_since_sls, sls_had_rxss):
    """STA, получившая запрос TX-обучения: после ответа — лучшая известная RX-конфигурация; при поддержке
    Other_AID обеими и Other_AID ≠ 0 — лучшая для приёма от STA с этим AID; без BRP после SLS и RXSS —
    квази-омни (should)."""
    if other_aid_both and other_aid:
        return ('best-for-aid', other_aid)
    if not (rx_trained or sls_had_rxss) and not brp_since_sls:
        return ('quasi-omni', None)
    return ('best', None)


def trn_r_tx_awv(preamble_awv, other_aid_both, other_aid, best_awv_for=None):
    """BRP-RX: все TRN-R тем же TX AWV, что преамбула и данные (10.42.6.4.4; 20.9.2.2.5/20.9.2.2.6), кроме
    Other_AID ≠ 0 при поддержке обеими — лучший TX AWV к STA с этим AID."""
    if other_aid_both and other_aid:
        return best_awv_for(other_aid)
    return preamble_awv


def reciprocity_awv(both_reciprocal, brp_rx_awv, current_awv):
    """10.42.6.4.4: обе STA с Antenna Pattern Reciprocity = 1 — после BRP-RX использовать тот же AWV для
    последующих передач и приёма с пиром в DTI."""
    return brp_rx_awv if both_reciprocal else current_awv


# ---------------- 10.42.3.2 / 10.42.6.3: BRP setup и MIDC ----------------
def setup_required(rss_in_abft=False, ssw_fb_req=None, ssw_ack_req=None, intends_midc=False):
    """10.42.3.2: setup обязателен — RSS был в A-BFT (SSW-Ack не было); MID-REQ или BC-REQ = 1 в SSW-Feedback
    инициатора или в SSW-Ack ответчика; инициатор намерен провести MID/BC. ssw_*_req — BrpRequest."""
    reqs = [r for r in (ssw_fb_req, ssw_ack_req) if r is not None]
    return bool(rss_in_abft or intends_midc or any(r.mid_req or r.bc_req for r in reqs))


def midc_subphases(init_req=None, resp_grant=None, resp_req=None, init_grant=None):
    """Какие подфазы MIDC выполняются и в каком порядке (10.42.3.2, 10.42.6.3.2 a), 10.42.6.3.3, 10.42.6.3.4).
    Запрос инициатора → R-MID/R-BC (передаёт ответчик), запрос ответчика → I-MID/I-BC. MID+BC вместе — только если
    выданы оба Grant («If either the MID or BC were not granted …, the MID and BC subphases shall not occur»).
    Порядок: MID до BC, R-MID до I-MID, R-BC до I-BC."""
    def grant(req, gr):
        if req is None or gr is None:
            return set()
        if req.mid_req and req.bc_req:
            return {'MID', 'BC'} if (gr.mid_grant and gr.bc_grant) else set()
        out = set()
        if req.mid_req and gr.mid_grant:
            out.add('MID')
        if req.bc_req and gr.bc_grant:
            out.add('BC')
        return out
    r, i = grant(init_req, resp_grant), grant(resp_req, init_grant)
    order = [('R-MID', 'MID' in r), ('I-MID', 'MID' in i), ('R-BC', 'BC' in r), ('I-BC', 'BC' in i)]
    return [name for name, on in order if on]


def check_grant_frame(req, grant_frame):
    """10.42.3.2: кадр, выдающий MID only, — Capability Request и TX-TRN-REQ, L-RX, MID-REQ, BC-REQ = 0;
    STA, выдавшая MID only, «shall not request MID or BC in the response PPDU». grant_frame — BrpFrame."""
    out = []
    g = grant_frame
    if req.mid_req and not req.bc_req and g.req.mid_grant:
        if g.bre.cap_req or g.req.tx_trn_req or g.req.l_rx or g.req.mid_req or g.req.bc_req:
            out.append('кадр Grant MID only: Capability Request/TX-TRN-REQ/L-RX/MID-REQ/BC-REQ ≠ 0 (10.42.3.2)')
    return out


def check_mid_sector_list(frame, n_sls_sectors):
    """10.42.3.2: после Grant MID запросившая STA передаёт BRP с SNR Present = Sector ID Order Present = 1,
    N_meas = число SNR из последнего SLS и Capability Request = 0."""
    ft, out = frame.bre.fbck_type, []
    if not (ft.snr and ft.sido):
        out.append('список секторов: SNR Present/Sector ID Order Present ≠ 1 (10.42.3.2)')
    if ft.nmeas != n_sls_sectors:
        out.append(f'список секторов: N_meas {ft.nmeas} ≠ {n_sls_sectors} (10.42.3.2)')
    if frame.bre.cap_req:
        out.append('список секторов: Capability Request ≠ 0 (10.42.3.2)')
    return out


def transactions_follow(last_frames):
    """10.42.3.2: транзакции после MIDC (и setup) обязательны, если в последних кадрах L-RX > 0 или
    TX-TRN-REQ = 1 у инициатора или ответчика."""
    return any(f.req.l_rx > 0 or f.req.tx_trn_req for f in last_frames)


def first_brp_after_sls_ok(ssw_ack_req, midc_granted, ppdu):
    """10.42.6.4.3: L-RX > 0 в SSW-Ack — первый кадр BRP инициатора — BRP-RX (TRN-R по L-RX, 20.9.2.2.3);
    L-RX = 0 и TX-TRN-REQ = 1 — первый кадр с TX-TRN-OK = 1 или L-RX > 0. Возвращает список нарушений."""
    if midc_granted or not ssw_ack_req.has_training_requests():
        return []
    out = []
    if ssw_ack_req.l_rx > 0:
        if not (ppdu.is_brp_rx() and ppdu.trn_len == ssw_ack_req.l_rx):
            out.append('первый BRP после SLS — не BRP-RX с L-RX из SSW-Ack (10.42.6.4.3)')
    elif ssw_ack_req.tx_trn_req:
        f = ppdu.frame
        if not (f.bre.tx_trn_ok or f.req.l_rx > 0):
            out.append('первый BRP после SLS: нет TX-TRN-OK = 1 и L-RX = 0 (10.42.6.4.3)')
    return out


def _gap_ok(gap, lo, hi):
    return lo <= gap <= hi


def _sifs_like(gap):
    return SIFS <= gap <= SIFS + SIFS_TOL


def _sbifs_like(gap):
    """10.3.2.3.8: SBIFS — не меньше aSBIFSTime и не больше aSBIFSTime + aSBIFSAccuracy."""
    return aSBIFSTime <= gap <= aSBIFSTime + aSBIFSAccuracy


def check_setup(events, initiator):
    """10.42.3.2: setup начинает инициатор кадром BRP с Capability Request = 1; на каждый кадр с Capability
    Request = 1 пир отвечает кадром BRP; конец — ответчик передал Capability Request = 0, и инициатор ответил
    тоже 0. Промежутки ≥ SIFS и ≤ BRPIFS (рис. 10-73, 10-79, 10-80). Возвращает (нарушения, индекс конца)."""
    out, brp = [], [(i, e) for i, e in enumerate(events) if e.is_brp]
    if not brp or brp[0][1].src != initiator or not brp[0][1].frame.bre.cap_req:
        return [Violation(0, 'setup-start', 'setup начинается BRP инициатора с Capability Request = 1')], None
    end = None
    for k in range(1, len(brp)):
        (_, p), (i, e) = brp[k - 1], brp[k]
        if e.src == p.src:
            out.append(Violation(i, 'setup-order', 'два кадра setup подряд от одной STA'))
        gap = e.t - p.end
        if not _gap_ok(gap, BRPIFS_MIN, BRPIFS):
            out.append(Violation(i, 'brpifs', f'промежуток {float(gap)} мкс вне [SIFS, BRPIFS] (10.42.3.2)'))
        if p.src != initiator and not p.frame.bre.cap_req and e.src == initiator and not e.frame.bre.cap_req:
            end = i
            break
    if end is None:
        out.append(Violation(brp[-1][0], 'setup-end', 'нет пары Capability Request = 0 (ответчик, затем инициатор)'))
    return out, end


def check_mid(events, tx, l_rx, with_bc=False, prev_end=None):
    """MID-подфаза от передатчика tx (10.42.6.3.2 b), 10.42.6.3.3 b)): BRP-RX PPDU с Training Length = L-RX
    приёмника (20.9.2.2.3), MID Extension = 1 у всех, кроме последнего (0); в каждом — TX Sector ID; при MID only —
    по одному PPDU с каждого выбранного сектора (сектора различны). Первый PPDU — в пределах BRPIFS после
    последнего кадра setup (prev_end). Затем ответ приёмника с обратной связью через ≥ SIFS и ≤ BRPIFS: при MID+BC —
    Number of Beams (число RX AWV для BC), при MID only — BS-FBCK (сектор с лучшим качеством из переданных).
    СПОРНО: промежуток между MID BRP-RX одной STA — на рис. 10-85 подписан «SIFS», а по 10.3.2.3.8 передачи одной
    STA разными TX-конфигурациями без ответа разделяются SBIFS; принимаются оба."""
    out = []
    mids = [(i, e) for i, e in enumerate(events) if e.src == tx and e.is_brp_rx()]
    if not mids:
        return [Violation(0, 'mid-empty', 'нет BRP-RX в MID')]
    first_i, first = mids[0]
    if prev_end is not None and not _gap_ok(first.t - prev_end, BRPIFS_MIN, BRPIFS):
        out.append(Violation(first_i, 'brpifs', 'первый BRP-RX MID не в [SIFS, BRPIFS] после setup (10.42.6.3.2 b))'))
    sectors = []
    for k, (i, e) in enumerate(mids):
        last = k == len(mids) - 1
        if e.trn_len != l_rx:
            out.append(Violation(i, 'mid-trn', f'Training Length {e.trn_len} ≠ L-RX {l_rx} (20.9.2.2.3)'))
        if e.frame.bre.mid_ext != (0 if last else 1):
            out.append(Violation(i, 'mid-ext', 'MID Extension: 1 у всех BRP-RX, кроме последнего (10.42.6.3.2 b))'))
        if k:
            gap = e.t - mids[k - 1][1].end
            if not (_sifs_like(gap) or _sbifs_like(gap)):
                out.append(Violation(i, 'mid-gap', f'промежуток MID {float(gap)} мкс — не SIFS/SBIFS'))
        sectors.append(e.frame.req.tx_sector_id)
    if not with_bc and len(set(sectors)) != len(sectors):
        out.append(Violation(mids[-1][0], 'mid-sector', 'MID only: по одному BRP-RX на выбранный сектор (10.42.6.3.3)'))
    last_i, last = mids[-1]
    fb = next(((i, e) for i, e in enumerate(events) if i > last_i and e.is_brp), None)
    if fb is None or fb[1].src == tx:
        out.append(Violation(last_i, 'mid-fbck', 'после MID Extension = 0 нет BRP с обратной связью от приёмника'))
        return out
    i, e = fb
    if not _gap_ok(e.t - last.end, BRPIFS_MIN, BRPIFS):
        out.append(Violation(i, 'brpifs', 'обратная связь MID не в [SIFS, BRPIFS]'))
    if with_bc:
        if e.frame.bre.fbck_type.nbeams == 0:
            out.append(Violation(i, 'mid-fbck', 'MID+BC: в обратной связи нет Number of Beams (10.42.6.3.2 b))'))
    elif e.frame.bre.bs_fbck not in sectors:
        out.append(Violation(i, 'mid-fbck', 'MID only: BS-FBCK — не сектор из переданных BRP-RX (10.42.6.3.3 b))'))
    return out


def check_bc(events, tx, nbeam_tx, nbeam_rx):
    """BC-подфаза (10.42.6.3.2 c), рис. 10-83): tx передаёт N_beam(TX) BRP-RX кадров, разделённых SBIFS, в каждом —
    Sector ID использованного сектора и N_beam(RX) TRN-R подполей; затем пир — BRP через ≥ SIFS и ≤ BRPIFS с
    BS-FBCK = сектор лучшего BRP-RX и Sector ID Order Present = 1.
    СПОРНО: «appended with N_beam(I,RX) TRN-R subfields», а TRN-R идут единицами по 4 (20.9.2.2.6; N_beam ≤ 7 —
    до 49 проб, рис. 10-81). Принято: Training Length ≥ ⌈N_beam(RX)/4⌉; второе прочтение (ровно N_beam(RX)
    подполей) физически невыполнимо при N_beam не кратном 4."""
    out = []
    bcs = [(i, e) for i, e in enumerate(events) if e.src == tx and e.is_brp_rx()]
    if len(bcs) != nbeam_tx:
        out.append(Violation(bcs[0][0] if bcs else 0, 'bc-count', f'{len(bcs)} BRP-RX ≠ N_beam(TX) {nbeam_tx}'))
    if not bcs:
        return out
    sectors = []
    for k, (i, e) in enumerate(bcs):
        if e.trn_subfields() < nbeam_rx:
            out.append(Violation(i, 'bc-trn', f'TRN-R {e.trn_subfields()} < N_beam(RX) {nbeam_rx}'))
        if k and not _sbifs_like(e.t - bcs[k - 1][1].end):
            out.append(Violation(i, 'bc-gap', 'BRP-RX BC не разделены SBIFS (рис. 10-83)'))
        sectors.append(e.frame.req.tx_sector_id)
    last_i, last = bcs[-1]
    fb = next(((i, e) for i, e in enumerate(events) if i > last_i and e.is_brp), None)
    if fb is None or fb[1].src == tx:
        out.append(Violation(last_i, 'bc-fbck', 'нет BRP с обратной связью после BC'))
        return out
    i, e = fb
    if not _gap_ok(e.t - last.end, BRPIFS_MIN, BRPIFS):
        out.append(Violation(i, 'brpifs', 'обратная связь BC не в [SIFS, BRPIFS] (рис. 10-83)'))
    if e.frame.bre.bs_fbck not in sectors:
        out.append(Violation(i, 'bc-fbck', 'BS-FBCK — не сектор из BRP-RX BC (10.42.6.3.2 c))'))
    if not e.frame.bre.fbck_type.sido:
        out.append(Violation(i, 'bc-fbck', 'нет Sector ID Order (10.42.6.3.2 c))'))
    return out


# ---------------- судья транзакций ----------------
class BrpParams:
    """alloc_end — конец SP/TXOP (мкс) или None; strict_final_response — требовать ответ ответчика и на кадр
    инициатора без запросов (см. СПОРНО в run_transaction); other_aid_both — обе STA поддерживают Other_AID;
    best_awv_for(aid) — ожидаемый AWV TRN-R при Other_AID."""
    def __init__(self, alloc_end=None, strict_final_response=True, other_aid_both=False, best_awv_for=None):
        self.alloc_end = None if alloc_end is None else Fr(alloc_end)
        self.strict_final_response = strict_final_response
        self.other_aid_both, self.best_awv_for = other_aid_both, best_awv_for


def _check_response_content(i, e, p, out):
    """Содержимое ответа e на кадр p (10.42.6.4.1). Правила обучения в BRP setup (Capability Request = 1) и MIDC
    (MID-REQ/BC-REQ) не применяются: там L-RX/TX-TRN-REQ — намерение, а не запрос немедленного TRN.
    СПОРНО: 10.42.3.2 допускает в кадре setup L-RX > 0 (рис. 10-79); принято, что немедленный TRN-R требуется
    только на кадр с Capability Request = 0 и MID-REQ = BC-REQ = 0."""
    f, r = p.frame, e.frame
    immediate = not f.bre.cap_req and not f.req.mid_req and not f.req.bc_req
    if immediate and f.req.l_rx > 0:
        if not (e.is_brp_rx() and e.trn_len == f.req.l_rx):
            out.append(Violation(i, 'rx-trn', f'на L-RX {f.req.l_rx} нужен BRP-RX с Training Length = L-RX '
                                              f'(10.42.6.4.1, 20.9.2.2.3), есть N={e.trn_len} {e.ppdu_type}'))
        if not r.bre.rx_train_resp:
            out.append(Violation(i, 'rx-trn', 'нет RX-train-response = 1 (10.42.6.4.1)'))
    if immediate and f.req.tx_trn_req:
        if not r.bre.tx_trn_ok:
            out.append(Violation(i, 'tx-trn', 'на TX-TRN-REQ нет TX-TRN-OK = 1 (10.42.6.4.1)'))
        if p.is_brp_tx():
            n = p.trn_subfields()
            if not r.bre.tx_train_resp:
                out.append(Violation(i, 'tx-trn', 'на TRN-T нет TX-train-response = 1 (10.42.6.4.1)'))
            if not 1 <= r.bre.bs_fbck <= n:
                out.append(Violation(i, 'bs-fbck', f'BS-FBCK {r.bre.bs_fbck} вне 1..{n} (9.4.2.129)'))
            ft, fr = r.bre.fbck_type, f.bre.fbck_req
            if NTAPS[ft.ntaps] > NTAPS[fr.ntaps]:
                out.append(Violation(i, 'fbck-taps', 'отводов в FBCK-TYPE больше запрошенного (10.42.6.4.1)'))
            if not ft.snr and not ft.chan and r.cmf_payload():
                out.append(Violation(i, 'cmf', 'SNR/Channel Measurement Present = 0, но CMF есть (10.42.6.4.1)'))
            if (ft.snr or ft.chan) and ft.nmeas != n:
                out.append(Violation(i, 'nmeas', f'N_meas {ft.nmeas} ≠ числу TRN-T {n} (табл. 9-256)'))
        else:
            if r.bre.tx_train_resp:
                out.append(Violation(i, 'tx-trn', 'TX-train-response = 1 без принятых TRN-T (10.42.6.4.1)'))
            if r.req.l_rx:
                out.append(Violation(i, 'tx-trn', 'TX-TRN-OK без TRN-T: L-RX должен быть 0 (10.42.6.4.1)'))
    if f.bre.txss_fbck_req:
        ft = r.bre.fbck_type
        if not (ft.snr and ft.sido):
            out.append(Violation(i, 'txss-fbck', 'на TXSS-FBCK-REQ нужны SNR Present = Sector ID Order Present = 1'))


def check_brp_log(events, params=None):
    """Проверка журнала эфира двух STA с кадрами BRP (транзакции 10.42.3.1, 10.42.6.4). Возвращает [Violation]:
      frame       — поля: L-RX ≤ 16 (9.5.4), Training Length 1..16 при PPDU_TYPE и 0 без (20.9.2.2.3),
                    TXSS-FBCK-REQ и TX-TRN-REQ не вместе, Sector ID Order Requested = 0 при TX-TRN-REQ (10.42.6.4.1);
                    BS-FBCK = 0, если последний принятый PPDU не BRP-TX (9.4.2.129) — кроме обратной связи
                    сопровождения луча: TX-train-response после PPDU пира с запросом TRN-T (10.42.7 «set the BS-FBCK
                    field to the index of the TRN-T subfield that was received with the best quality»; PLAN.md №111);
      ampdu       — не два BRP в A-MPDU; BRP — только с одним Ack, BA или QoS Null (10.42.6.4.1);
      ack         — BRP — Action No Ack (9.6.21.3): Ack на него не передаётся;
      duration    — Duration = остаток SP/TXOP (10.42.6.4.1);
      alloc       — PPDU не выходит за конец SP/TXOP (10.42.3.1 «provided sufficient time»);
      initiator   — бит Initiator (10.42.6.4.1);
      gap         — ответ/запрос после кадра пира раньше SIFS (10.3.2.3.9, 10.42.3.1);
      no-response — нет ответа в пределах BRPIFS на кадр, требующий ответа (10.42.6.4.2, 10.42.3.1);
      retransmit  — повтор инициатора раньше BRPIFS без ответа; повтор у ответчика (10.42.6.4.1);
      owe-trn-t   — после TX-TRN-OK без TX-train-response запросившая STA не прислала TRN-T (10.42.6.4.1);
      rx-trn, tx-trn, bs-fbck, fbck-taps, cmf, nmeas, txss-fbck — содержимое ответа (10.42.6.4.1);
      trn-awv     — AWV полей TRN-R ≠ AWV преамбулы (10.42.6.4.4, 20.9.2.2.6).
    События с phase 'MID'/'BC' проверяются check_mid/check_bc и здесь пропускаются (кроме полей и агрегации).
    СПОРНО (ответ «филлером»): 10.42.3.1 — ответчик, которому нужно больше SIFS, «should keep the IFS not longer than
    SIFS by transmitting one or more PPDUs»; принято: первый PPDU ответчика (любой) — в [SIFS, BRPIFS] после кадра,
    сам BRP-ответ — до следующего кадра запросившей STA."""
    P = params or BrpParams()
    ev = sorted(enumerate(events), key=lambda x: x[1].t)
    out = []
    last_rx = {}                    # STA → последний принятый PPDU
    last_tx = {}                    # STA → последний переданный PPDU
    owe_trn_t = set()
    last_bt = {}                    # STA → последний принятый PPDU с запросом сопровождения TRN-T (10.42.7)
    txn = None                      # {'init': имя, 'resp': имя}
    for k, (i, e) in enumerate(ev):
        if e.kind == 'Ack' and last_rx.get(e.src) is not None and last_rx[e.src].is_brp \
                and e.t - last_rx[e.src].end <= SIFS + SIFS_TOL:
            out.append(Violation(i, 'ack', 'Ack на кадр BRP (Action No Ack, 9.6.21.3)'))
        if P.alloc_end is not None and e.end > P.alloc_end:
            out.append(Violation(i, 'alloc', 'PPDU выходит за конец SP/TXOP'))
        if not e.lost and e.bt and e.is_brp_tx():
            last_bt[e.dst] = e
        if not e.is_brp:
            last_tx[e.src] = e
            if not e.lost:
                last_rx[e.dst] = e
            continue
        f = e.frame
        # ---- поля ----
        for msg in f.req.validate():
            out.append(Violation(i, 'frame', msg))
        if e.ppdu_type is not None and not 1 <= e.trn_len <= TRN_LEN_MAX:
            out.append(Violation(i, 'frame', 'PPDU_TYPE при Training Length вне 1..16 (табл. 20-1)'))
        if e.ppdu_type is None and e.trn_len:
            out.append(Violation(i, 'frame', 'Training Length > 0 без PPDU_TYPE'))
        if f.bre.txss_fbck_req and f.req.tx_trn_req:
            out.append(Violation(i, 'frame', 'TXSS-FBCK-REQ и TX-TRN-REQ = 1 в одном кадре (10.42.6.4.1)'))
        if f.req.tx_trn_req and f.bre.fbck_req.sido and not f.bre.cap_req:
            out.append(Violation(i, 'frame', 'Sector ID Order Requested ≠ 0 в запросе TX-обучения (10.42.6.4.1)'))
        prx = last_rx.get(e.src)
        lt = last_tx.get(e.src)
        fresh = prx is not None and (lt is None or prx.t > lt.t)   # кадр пира принят после своей передачи
        bt_fb = f.bre.tx_train_resp and last_bt.get(e.src) is not None and last_bt[e.src].src == e.dst
        if e.phase not in ('MID', 'BC') and f.bre.bs_fbck and not (prx is not None and prx.is_brp_tx()) and \
                not bt_fb:
            out.append(Violation(i, 'frame', 'BS-FBCK ≠ 0, а последний принятый PPDU — не BRP-TX (9.4.2.129)'))
        # ---- агрегация ----
        if 'BRP' in e.ampdu:
            out.append(Violation(i, 'ampdu', 'два кадра BRP в одном A-MPDU (10.42.6.4.1)'))
        others = [x for x in e.ampdu if x != 'BRP']
        if others and not (len(others) == 1 and others[0] in ('Ack', 'BlockAck', 'QoS Null')):
            out.append(Violation(i, 'ampdu', f'BRP в A-MPDU с {others} (10.42.6.4.1)'))
        # ---- Duration ----
        if e.dur is not None and P.alloc_end is not None and e.dur != brp_duration(e.end, P.alloc_end):
            out.append(Violation(i, 'duration', f'Duration {e.dur} ≠ {brp_duration(e.end, P.alloc_end)} '
                                                f'(остаток выделения, 10.42.6.4.1)'))
        # ---- AWV TRN-R ----
        if e.is_brp_rx() and e.trn_awv is not None and e.tx_awv is not None:
            want = trn_r_tx_awv(e.tx_awv, P.other_aid_both, f.req.other_aid, P.best_awv_for)
            if e.trn_awv != want:
                out.append(Violation(i, 'trn-awv', 'AWV полей TRN-R не по 10.42.6.4.4'))
        if e.phase in ('MID', 'BC', 'setup'):
            last_tx[e.src] = e
            if not e.lost:
                last_rx[e.dst] = e
            continue
        # ---- бит Initiator (10.42.6.4.1) ----
        want_init = (prx is None or not prx.is_brp) or (lt is not None and lt.is_brp and lt.frame.bre.initiator)
        if bool(f.bre.initiator) != want_init:
            out.append(Violation(i, 'initiator', f'Initiator = {f.bre.initiator}, ожидается {int(want_init)}'))
        # ---- транзакция ----
        if txn is not None and e.src == txn['init']:
            li = txn['last_init']
            if e.t - li.end > BRP_TXN_TIMEOUT and not txn['answered']:
                txn = None                  # 10.42.3.1 b): завершена по тайм-ауту
        if f.bre.initiator and (txn is None or txn['init'] != e.src):
            txn = {'init': e.src, 'resp': e.dst, 'last_init': e, 'answered': False}
        if txn is not None:
            if e.src == txn['init']:
                prev_own = txn['last_init']
                if prev_own is not e and not txn['answered']:
                    # повтор без ответа: не раньше BRPIFS после своего кадра (10.42.6.4.1)
                    if e.t - prev_own.end < BRPIFS:
                        out.append(Violation(i, 'retransmit', 'повтор кадра инициатора раньше BRPIFS'))
                txn['last_init'], txn['answered'] = e, False
            else:
                txn['answered'] = True
                lr = last_tx.get(e.src)
                if lr is not None and lr.is_brp and lr.t > txn['last_init'].t:
                    out.append(Violation(i, 'retransmit', 'ответчик передал второй BRP без кадра инициатора'))
        # ---- нижняя граница промежутка после кадра пира ----
        if fresh and prx.src == e.dst and e.t - prx.end < BRPIFS_MIN:
            out.append(Violation(i, 'gap', f'BRP через {float(e.t - prx.end)} мкс после кадра пира (< SIFS)'))
        # ---- обязательный TRN-T ----
        if e.src in owe_trn_t:
            if not e.is_brp_tx():
                out.append(Violation(i, 'owe-trn-t',
                                     'после TX-TRN-OK без TX-train-response нужен BRP-TX (10.42.6.4.1)'))
            owe_trn_t.discard(e.src)
        # ---- ответ на кадр пира ----
        if fresh and prx.is_brp and prx.dst == e.src and prx.phase is None:
            _check_response_content(i, e, prx, out)
            if prx.frame.req.tx_trn_req and not prx.is_brp_tx() and not prx.frame.bre.cap_req \
                    and f.bre.tx_trn_ok and not f.bre.tx_train_resp:
                owe_trn_t.add(e.dst)
        # ---- требуется ли ответ на e ----
        if not e.lost and txn is not None:
            from_init = e.src == txn['init']
            need = (from_init and (P.strict_final_response or f.has_requests())) or \
                   (not from_init and f.has_requests())
            if need:
                _check_reply_exists(i, e, [x for _, x in ev[k + 1:]], P, out)
        last_tx[e.src] = e
        if not e.lost:
            last_rx[e.dst] = e
    return out


def _check_reply_exists(i, e, after, P, out):
    """10.42.6.4.2: «shall respond to a BRP frame with a BRP frame»; 10.42.3.1: ответ — не позже BRPIFS «provided
    sufficient time is available … within the SP allocation or TXOP»."""
    first = next((x for x in after if x.src == e.dst), None)
    if P.alloc_end is not None:
        t_min = e.end + SIFS + brp_txtime(BRP_MIN_LEN, 0 if e.mcs == 0 else 1)
        if t_min > P.alloc_end and (first is None or first.t > e.end + BRPIFS):
            return
    if first is None or first.t - e.end > BRPIFS:
        out.append(Violation(i, 'no-response', 'нет ответа в пределах BRPIFS (10.42.3.1, 10.42.6.4.2)'))
        return
    if not first.is_brp:
        nxt_req = next((x for x in after if x.src == e.src), None)
        brp = next((x for x in after if x.src == e.dst and x.is_brp), None)
        if brp is None or (nxt_req is not None and brp.t > nxt_req.t):
            out.append(Violation(i, 'no-response', 'после PPDU-«заполнителя» нет BRP-ответа (10.42.3.1)'))
