# SPDX-License-Identifier: AGPL-3.0-or-later
"""Формирование луча после SLS (этап 4): BRP с TRN, сопровождение луча, поддержание направленной связи — часть DMG MAC
ядра (примесь к mac.DmgMac). Правила — 802.11-2020, номера пунктов в комментариях; модели и судьи — ref/brp,
ref/beamtrack, ref/linkmaint (используются, не дублируются).

BRP (10.42.3, 10.42.6.4):
  - MLME-BF-TRAINING.request(RequestBRP = true): SLS в DTI, в SSW-Feedback — свои запросы (L-RX, TX-TRN-REQ, 9.5.4;
    Duration — SSW-Ack + 2·MBIFS, 9.3.1.16 a)), ответчик в SSW-Ack — свои (10.42.2.5); через MBIFS после SSW-Ack —
    транзакция уточнения (10.42.6.4.3: при L-RX > 0 в SSW-Ack первый BRP — BRP-RX, при TX-TRN-REQ — TX-TRN-OK);
    BRP setup не нужен (10.42.3.2: RSS не в A-BFT, MID/BC не запрошены). Транзакция в отдельном TXOP — start_brp
    (инициатор — кто шлёт первый запрос, 10.42.3.1);
  - транзакция (10.42.6.4.2): кадр с Initiator = 1 → ответ ответчика через SIFS (≥ SIFS, ≤ BRPIFS, 10.42.3.1) → …;
    содержимое кадров — ref/brp.Participant (ответ на L-RX — BRP-RX с L-RX единицами TRN-R и RX-train-response = 1;
    на TX-TRN-REQ с TRN-T — TX-TRN-OK = TX-train-response = 1, BS-FBCK, FBCK-TYPE и Channel Measurement Feedback
    9.4.2.136; без TRN-T — TX-TRN-OK, L-RX = 0, затем BRP-TX); конец — 10.42.3.1 a) (кадр ответчика без запросов и
    своих нужд нет) или b) (BRPIFS + aSlotTime без ответа; до того — повтор кадра через BRPIFS, 10.42.6.4.1);
  - Duration кадра BRP — остаток TXOP (10.42.6.4.1); бит Initiator — 10.42.6.4.1;
  - итог: TRN-T → BS-FBCK пира → своя AWV передачи; TRN-R → AWV приёма с лучшим SNR (свой выбор, «implementation
    dependent»); AWV — расширение модели sap_phy (Beam.awv), кандидаты — BfConfig.tx_awvs / rx_awvs.
Сопровождение луча (10.42.7), только передача (TRN-T):
  - инициатор: в PPDU данных к пиру — BEAM_TRACKING_REQUEST, PPDU_TYPE TRN-T, TRN_LEN и подполя TRN-T, если пир
    объявил DMG STA Beam Tracking Time Limit ≠ 0 и выполнено одно из условий повторного запроса (beamtrack.Initiator);
  - ответчик: BRP с обратной связью (FBCK-TYPE — как в последнем BRP инициатора с TX-TRN-REQ = 1, иначе 0 и BS-FBCK —
    лучший TRN-T) через EDCA (RD выключен, 10.29.4) не позже предела табл. 10-31 (beamtrack.Responder); кадр — BRP с
    Initiator = 1 (предыдущий принятый кадр — не BRP, 10.42.6.4.1), пир отвечает BRP (10.42.6.4.2);
  - ответ позже предела — инициатор его игнорирует (10.42.7 «should ignore»).
Поддержание направленной связи (11.27.1):
  - dot11BeamLinkMaintenanceTime — по полям BLM SSW-Feedback/SSW-Ack (9.5.6, табл. 9-345, linkmaint.negotiate);
  - таймер на связь (linkmaint.LinkTimer): ставится по успешному SLS (без BRP) / BRP, у инициатора обмена — по
    принятому немедленному ответу (Ack, BlockAck, DMG CTS), у получателя — после передачи ответа; останавливается в
    BTI и A-BFT;
  - нет MSDU — QoS Null до истечения («shall transmit QoS Null frames to maintain a beamformed link»);
  - истечение: ответчик связи в CBAP — приём квази-омни (уточнённая AWV приёма забывается); инициатор связи (инициатор
    последнего SLS) «may initiate an ISS» — политика BfConfig.blm_restore.
Деградация связи (11.27.1 последние абзацы — «can use beam tracking or beam refinement», «should improve … by
performing RSS during the A-BFT»): политика ядра (стандарт её не предписывает, только разрешает) — BfConfig.degrade_db:
падение SNR от пира против опорного (после BF, при той же диаграмме приёма) ≥ degrade_db → уточнение (сопровождение
луча при данных и поддержке пиром, иначе транзакция BRP); ≥ resls_db, или fail_limit неудачных обменов подряд →
повторное BF: станция — RSS в A-BFT, если маяки объявляют A-BFT (Next A-BFT = 0), иначе SLS в DTI; точка — SLS в DTI.

Не исполняется: MIDC (MID/BC), запрос TXSS-FBCK, сопровождение приёма (PPDU_TYPE TRN-R с BEAM_TRACKING_REQUEST и
TRN-R, добавляемые ответчиком к следующему PPDU — у ответа через SIFS иной TXTIME и Duration), Other_AID, несколько
DMG-антенн, RXSS."""
from dataclasses import dataclass
from fractions import Fraction as Fr
from math import ceil
from typing import Optional

from .. import beamtrack as BT
from .. import brp as BRP
from .. import fields as F
from .. import linkmaint as LM
from ..timing import BRPIFS, MBIFS, SIFS, aSlotTime, txtime
from . import frames as FR
from . import sap_mlme as ML
from . import sap_phy as P

EID_CMF = 154                              # табл. 9-92: Channel Measurement Feedback
RESP_KINDS = LM.RESP_KINDS                 # 11.27.1: Ack, BlockAck, DMG CTS, DMG DTS
BRP_RETRY = 2                              # повторов кадра инициатора без ответа (10.42.6.4.1 «may retransmit»)


@dataclass
class BfConfig:
    """Выбор реализации BF (стандарт оставляет его STA). Умолчания — поведение этапов 1–3 (BRP только по запросу,
    BLM не определён, сопровождение луча не поддержано, политики деградации нет)."""
    tx_awvs: tuple = (-2, -1, 0, 1, 2)     # кандидаты AWV передачи (TRN-T) вокруг сектора SLS
    rx_awvs: tuple = (-2, -1, 0, 1, 2)     # кандидаты AWV приёма (TRN-R)
    brp_on_sls: bool = False               # ответчик SLS просит BRP в SSW-Ack (10.42.2.5 «may include»)
    blm: F.Blm = F.Blm()                   # своё поле Beamformed Link Maintenance (Value 0 — не определено, 9.5.6)
    bt_time_limit: int = 0                 # DMG STA Beam Tracking Time Limit (9.4.2.127.4): 0 — не поддержано
    keepalive_margin_us: int = 1000        # QoS Null за столько до истечения таймера связи
    blm_restore: bool = True               # инициатор связи после истечения — ISS (11.27.1 «may»)
    degrade_db: Optional[float] = None     # политика деградации (None — выключена)
    resls_db: Optional[float] = None
    fail_limit: Optional[int] = None
    min_reaction_us: int = 2000            # не чаще одного действия по деградации на пира за это время


def awv_units(awvs):
    """Единиц TRN (по 4 подполя, 20.9.2.2.6), чтобы каждая AWV попала хотя бы в одно подполе."""
    return max(1, ceil(Fr(len(awvs), BRP.SUBFIELDS_PER_UNIT)))


def cmf_snr_raw(snr_db):
    """9.4.2.136: SNR — беззнаковое, опорный уровень −8 дБ, шаг 0,25 дБ; ≤ −8 — 0, ≥ 55,75 — 0xFF."""
    v = (Fr(snr_db).limit_denominator(1000) + 8) * 4
    return max(0, min(255, int(v)))


def cmf_snr_db(raw):
    return Fr(raw, 4) - 8


def encode_cmf(snrs=(), sectors=()):
    """Channel Measurement Feedback (9.4.2.136): SNR_1…SNR_Nmeas (8 бит), Sector ID Order (Sector ID 6 бит + DMG
    Antenna ID 2 бита); Channel Measurement и Tap Delay ядро не передаёт (FBCK-TYPE: Channel Measurement Present 0)."""
    payload = bytes(cmf_snr_raw(s) for s in snrs) + bytes((sid & 63) | ((ant & 3) << 6) for sid, ant in sectors)
    if not payload:
        return b''
    assert len(payload) <= 255
    return bytes([EID_CMF, len(payload)]) + payload


def parse_cmf_snrs(body_tail, n):
    """SNR из Channel Measurement Feedback (первые n октетов) или []."""
    if len(body_tail) >= 2 + n and body_tail[0] == EID_CMF:
        return [cmf_snr_db(x) for x in body_tail[2:2 + n]]
    return []


def brp_frame_of(raw):
    """MPDU кадра BRP (без FCS) → BrpFrame (поля 9.5.4, 9.4.2.129) и хвост тела (CMF)."""
    b = raw[24:]
    fr = BRP.BrpFrame(req=BRP.BrpRequest.parse(b[3:7]), bre=BRP.BeamRefinement.parse(b[7:14]), token=b[2])
    return fr, b[14:]


def brp_ppdu(t, src, dst, frame, rxv):
    """Принятый PPDU с BRP → brp.Ppdu (Training Length и PPDU Type — из RXVECTOR, 20.9.2.2.3)."""
    appended = P.trn_appended(rxv)
    return BRP.Ppdu(t, src, dst, 'BRP', frame, rxv.MCS, length=rxv.LENGTH, trn_len=rxv.TRN_LEN if appended else 0,
                    ppdu_type=rxv.PPDU_TYPE if appended else None)


def _best(vals):
    """Индекс наибольшего SNR (при равенстве — первый)."""
    best = None
    for i, v in enumerate(vals):
        if v is not None and (best is None or v > vals[best]):
            best = i
    return best


class BfMixin:
    """BRP, сопровождение луча, поддержание связи и политика деградации — для mac.DmgMac."""

    def _bf_init(self):
        self.bf = BfConfig()
        self._last_rx_brp = False              # последний принятый (себе) PPDU — BRP
        self._last_tx_brp_init = False         # последний переданный PPDU — BRP с Initiator = 1
        self.halts = []                        # (начало BTI, конец A-BFT) — остановки таймеров связи (11.27.1)

    # ------------------------------------------------------------------ AWV
    def _tx_units(self):
        return awv_units(self.bf.tx_awvs) if len(self.bf.tx_awvs) > 1 else 0

    def _rx_units(self):
        return awv_units(self.bf.rx_awvs) if len(self.bf.rx_awvs) > 1 else 0

    def _base_beam(self, addr):
        b = self._beam_to(addr)
        return P.Beam(b.sector, b.antenna) if not b.quasi_omni else b

    def _trn_t_awvs(self, addr):
        base = self._base_beam(addr)
        return tuple(base.refined(w) for w in self.bf.tx_awvs) if not base.quasi_omni else ()

    def _trn_r_awvs(self, addr):
        """AWV приёма для TRN-R: уточнения вокруг сектора SLS к пиру (модель: диаграмма решётки взаимна — сектор
        передачи к пиру он же лучший сектор приёма; 10.42.6.4.4 «best known receive antenna configuration»)."""
        base = self._base_beam(addr)
        return tuple(base.refined(w) for w in self.bf.rx_awvs) if not base.quasi_omni else ()

    def _rx_for(self, addr):
        """Диаграмма приёма ответа пира в транзакции BRP: уточнённая AWV приёма (10.42.6.4.4 «best known receive
        antenna configuration»), иначе квази-омни. В обменах данными приём — квази-омни (выбор модели: адаптация MCS
        ядра опирается на взаимность канала — SNR своего приёма, — верную при одинаковых диаграммах приёма)."""
        p = self.peers.get(addr)
        rb = getattr(p, 'rx_beam', None) if p is not None else None
        return rb if rb is not None and not rb.quasi_omni else P.QUASI_OMNI

    def _initiator_bit(self):
        """10.42.6.4.1: Initiator = 1, если предыдущий принятый кадр — не BRP или последний переданный PPDU — BRP с
        Initiator = 1."""
        return (not self._last_rx_brp) or self._last_tx_brp_init

    # ------------------------------------------------------------------ BRP: кадры
    def _brp_raw(self, ra, frame, dur, snrs=(), sectors=()):
        body = frame.body() + encode_cmf(snrs, sectors)
        return FR.mgmt('Action No Ack', int(dur), ra, self.addr, self.bssid or ra, self.next_mgmt_sn(), body)

    def _brp_len(self, frame, n_meas=0):
        return FR.MGMT_HDR + len(frame.body()) + (2 + n_meas if n_meas else 0) + 4

    def _brp_results(self, peer, pp, rxv):
        """Итог принятого BRP PPDU: TRN-R по своему запросу → AWV приёма; TX-train-response → BS-FBCK → AWV передачи
        (10.42.6.4.1)."""
        p = self.peer(peer)
        f = pp.frame
        st = getattr(p, 'brp_st', None)
        if pp.is_brp_rx() and f.bre.rx_train_resp and st is not None and st.get('rx_awvs'):
            i = _best(rxv.TRN_SNR)
            if i is not None:
                awvs = st['rx_awvs']
                p.rx_beam = awvs[i % len(awvs)]
                self.log('brp_rx_trained', peer=peer, beam=p.rx_beam, snr=rxv.TRN_SNR[i])
            st['rx_awvs'] = ()
        if f.bre.tx_train_resp and f.bre.bs_fbck and st is not None and st.get('tx_awvs'):
            awvs = st['tx_awvs']
            p.tx_beam = awvs[(f.bre.bs_fbck - 1) % len(awvs)]
            self.log('brp_tx_trained', peer=peer, beam=p.tx_beam, bs_fbck=f.bre.bs_fbck)
            st['tx_awvs'] = ()

    def _brp_reply(self, me, peer, pp, rxv, initiator):
        """Кадр-ответ участника me на принятый pp (ref/brp.Participant) + TRN: → (BrpFrame, trn, ptype, trn_awvs,
        snrs CMF)."""
        st = self.peer(peer).__dict__.setdefault('brp_st', {})
        snrs = ()
        if pp is not None and pp.is_brp_tx() and rxv is not None and rxv.TRN_SNR:
            i = _best(rxv.TRN_SNR)
            me.best_trn = (lambda n, i=i: i + 1)            # BS-FBCK — индекс лучшего TRN-T с 1 (9.4.2.129)
            snrs = tuple(s if s is not None else -13 for s in rxv.TRN_SNR)
        fr, n, pt = me.build(pp, initiator=initiator)
        if not (fr.bre.fbck_type.snr and fr.bre.fbck_type.nmeas):
            snrs = ()
        else:
            snrs = snrs[:fr.bre.fbck_type.nmeas]
        awvs = ()
        if pt == P.TRN_T:
            awvs = self._trn_t_awvs(peer)
            st['tx_awvs'] = awvs
        if fr.req.l_rx:
            st['rx_awvs'] = self._trn_r_awvs(peer)
        return fr, n, pt, awvs, snrs

    # ------------------------------------------------------------------ BRP: инициатор транзакции
    def _participant(self, rx=True, tx=True):
        return BRP.Participant(self.addr, rx_units=self._rx_units() if rx else 0,
                               tx_units=self._tx_units() if tx else 0, fbck_req=BRP.FbckReq(snr=1))

    def _brp_txn_time(self, n_rx=None, n_tx=None):
        """Оценка длительности транзакции (для CBAP и Duration SSW-Feedback): до 6 кадров с TRN и SIFS."""
        n = max(self._rx_units(), self._tx_units(), 1)
        fr = BRP.BrpFrame(bre=BRP.BeamRefinement(fbck_type=BRP.FbckType(snr=1, nmeas=4 * n)))
        return 6 * (BRP.brp_txtime(self._brp_len(fr, 4 * n) + 4 * n, 0, n) + SIFS) + BRPIFS

    def _brp_txn_init(self, ra, ack_req=None, first_gap=SIFS, me=None, first_rx=None):
        """Транзакция уточнения инициатором (генератор шагов последовательности). ack_req — BRP Request из SSW-Ack
        (10.42.6.4.3); first_rx — (Ppdu, rxv), на который первый кадр — ответ. → True — 10.42.3.1 a), False — b)."""
        me = me or self._participant()
        p = self.peer(ra)
        p.brp_st = {}
        pseudo = None
        if ack_req is not None and ack_req.has_training_requests():
            # 10.42.6.4.3: запросы SSW-Ack — как запросы принятого кадра (первый BRP — BRP-RX / TX-TRN-OK)
            pseudo = BRP.Ppdu(self.sim.now, ra, self.addr, 'BRP', BRP.BrpFrame(req=ack_req), 0)
        pp, rxv = first_rx if first_rx is not None else (pseudo, None)
        fr, n, pt, awvs, snrs = self._brp_reply(me, ra, pp, rxv, self._initiator_bit())
        gap, tries = first_gap, 0
        while True:
            beam = self._beam_to(ra)
            rx_awvs = p.brp_st.get('rx_awvs', ()) if fr.req.l_rx else ()

            def build(tt, fr=fr, n=n, snrs=snrs):
                t_end = tt + BRP.brp_txtime(self._brp_len(fr, len(snrs)), 0, n)
                return [self._brp_raw(ra, fr, BRP.brp_duration(t_end, max(t_end, self.seq['txop_end'])), snrs)]
            r = yield self.Tx(None, 0, beam, gap=gap, build=build, trn=n, ptype=pt, trn_awvs=awvs,
                              expect=lambda frs: frs[0].action == 'BRP' and frs[0].ta == ra and frs[0].ra == self.addr,
                              resp_mcs=0, resp_gap=BRPIFS, what='BRP', rx_beam=self._rx_for(ra), rx_trn=rx_awvs)
            if r is None:
                if tries < BRP_RETRY:
                    tries += 1                  # 10.42.6.4.1: повтор кадра с Initiator = 1 через BRPIFS
                    gap = BRPIFS
                    continue
                self.log('brp_txn_timeout', peer=ra)
                return False                    # 10.42.3.1 b)
            frs, rxv, t0 = r
            rf, _ = brp_frame_of(frs[0].raw)
            pp = brp_ppdu(t0, ra, self.addr, rf, rxv)
            me.consume(pp)
            self._brp_seen(ra, rf)
            self._brp_results(ra, pp, rxv)
            if not rf.has_requests() and not me.pending():
                self.log('brp_txn_done', peer=ra, tx_beam=p.tx_beam, rx_beam=getattr(p, 'rx_beam', None))
                return True                     # 10.42.3.1 a)
            fr, n, pt, awvs, snrs = self._brp_reply(me, ra, pp, rxv, self._initiator_bit())
            gap, tries = SIFS, 0

    def start_brp(self, ra, done=None, rx=True, tx=True, name='BRP'):
        """Транзакция уточнения в отдельном TXOP (10.42.3.1: инициатор — STA, передающая первый запрос); доступ —
        EDCA AC_VO (BRP — кадр управления, 10.2.3.2)."""
        t = self._brp_txn_time()
        job = self.Job(None, lambda tt: t, None, ra, name)

        def fin(ok):
            if ok:
                self._bf_complete(ra, 'brp')
            if done is not None:
                done(ok)
        job.done = fin
        me = self._participant(rx, tx)
        job.gen = lambda mac, tt: mac._brp_txn_init(ra, me=me)
        self._enqueue(self.AC_VO, job)
        return job

    # ------------------------------------------------------------------ BRP: ответчик
    def _rx_brp_txn(self, f, rxv, t0):
        """Кадр BRP транзакции (не setup) от пира себе: ответ BRP через SIFS (10.42.6.4.2), содержимое —
        ref/brp.Participant; конец setup без запросов — без ответа (10.42.3.2: кадр инициатора, завершающий setup)."""
        p = self.peer(f.ta)
        fr, tail = brp_frame_of(f.raw)
        self._brp_seen(f.ta, fr)
        if self._bt_rx_feedback(f.ta, fr, tail, rxv):
            self._brp_results(f.ta, brp_ppdu(t0, f.ta, self.addr, fr, rxv), rxv)
        if fr.bre.initiator and getattr(p, 'setup_end_wait', False) and not fr.has_requests():
            p.setup_end_wait = False
            return
        p.setup_end_wait = False
        pp = brp_ppdu(t0, f.ta, self.addr, fr, rxv)
        me = getattr(p, 'brp_resp', None)
        if fr.bre.initiator and (me is None or getattr(p, 'brp_resp_done', True)):
            # начало транзакции: свои нужды — объявленные в SSW-Ack (brp_on_sls), иначе нет
            needs = getattr(p, 'brp_needs', (False, False))
            me = p.brp_resp = self._participant(*needs)
            p.brp_needs = (False, False)
            p.brp_resp_done = False
            p.__dict__.setdefault('brp_st', {})
        if me is None or getattr(p, 'brp_resp_done', True) and not fr.bre.initiator:
            return                              # не в транзакции (ответ без запроса) — отвечать не на что
        me.consume(pp)
        self._brp_results(f.ta, pp, rxv)
        rf, n, pt, awvs, snrs = self._brp_reply(me, f.ta, pp, rxv, self._initiator_bit())
        te = self.sim.now + SIFS + BRP.brp_txtime(self._brp_len(rf, len(snrs)), 0, n)
        m = self._brp_raw(f.ta, rf, BRP.brp_duration(te, max(te, self.sim.now + f.dur)), snrs)
        self._respond(m, 0, self._beam_to(f.ta), trn=n, ptype=pt, trn_awvs=awvs)
        if rf.req.l_rx:
            self.set_rx_beam(self.rx_beam, p.brp_st.get('rx_awvs', ()))
        if not rf.has_requests() and not me.pending():
            p.brp_resp_done = True
            self.sim.at(te, self._bf_complete, f.ta, 'brp')
        self.log('brp_txn_responder', peer=f.ta, l_rx=n if pt == P.TRN_R else 0, ptype=pt)

    # ------------------------------------------------------------------ сопровождение луча (10.42.7)
    def _brp_seen(self, ta, fr):
        """Принят BRP от пира: FBCK-TYPE последнего его кадра с TX-TRN-REQ = 1 — тип обратной связи сопровождения
        (10.42.7, beamtrack.Responder)."""
        if fr.req.tx_trn_req:
            self.peer(ta).bt_fbck_type = fr.bre.fbck_type.value()

    def _bt_field(self, addr):
        """DMG STA Beam Tracking Time Limit пира (None — не передан)."""
        caps = getattr(self.peers.get(addr), 'caps', None)
        return caps.beam_tracking_time_limit if caps is not None else None

    def _bt_initiator(self, addr):
        p = self.peer(addr)
        if getattr(p, 'bt', None) is None:
            mib = self.bf.bt_time_limit or BT.DOT11_BEAM_TRACKING_TIME_LIMIT
            p.bt = BT.Initiator(self._bt_field(addr), mib)
        return p.bt

    def bt_may_request(self, addr):
        f = self._bt_field(addr)
        return bool(self.bf.bt_time_limit) and f not in (None, 0) and self._tx_units() > 0 and \
            self._bt_initiator(addr).may_request_tx(self.sim.now)

    def _bt_data_vector(self, p):
        """Запрос сопровождения передачи на PPDU данных к пиру (если запрошен политикой и разрешён) → (trn, awvs)."""
        if getattr(p, 'bt_req', None) != 'tx' or not self.bt_may_request(p.addr):
            return 0, ()
        p.bt_req = 'sending'
        return self._tx_units(), self._trn_t_awvs(p.addr)

    def _bt_sent(self, p, t_end):
        p.bt_req = None
        p.bt_awvs = self._trn_t_awvs(p.addr)
        self._bt_initiator(p.addr).sent_tx_request(t_end)
        self.log('bt_request', peer=p.addr)

    def _bt_rx_data(self, ta, rxv):
        """Ответчик: PPDU с запросом TRN-T (BEAM_TRACKING_REQUEST, PPDU_TYPE TRN-T) → BRP с обратной связью через
        EDCA не позже предела (10.42.7)."""
        if rxv.BEAM_TRACKING_REQUEST != P.BT_REQUESTED or rxv.PPDU_TYPE != P.TRN_T or not rxv.TRN_SNR:
            return
        p = self.peer(ta)
        if getattr(p, 'bt_resp', None) is None:
            p.bt_resp = BT.Responder(self._bt_field(ta), self.bf.bt_time_limit or BT.DOT11_BEAM_TRACKING_TIME_LIMIT)
        i = _best(rxv.TRN_SNR)
        if i is None:
            return
        t_req = self.sim.now
        meas = [x if x is not None else -13 for x in rxv.TRN_SNR]
        fr0 = BRP.BrpFrame(bre=BRP.BeamRefinement(fbck_type=BRP.FbckType(snr=1, nmeas=len(meas))))
        t_max = BRP.brp_txtime(self._brp_len(fr0, len(meas)), 0, 0)
        job = self.Job(None, lambda tt: t_max + SIFS + t_max + BRPIFS, None, ta, 'BT feedback')

        def frame():
            # FBCK-TYPE — как в последнем к этому моменту BRP инициатора с TX-TRN-REQ = 1, иначе 0 и BS-FBCK (10.42.7);
            # Initiator — по 10.42.6.4.1
            p.bt_resp.last_brp_fbck_type = getattr(p, 'bt_fbck_type', None)
            ft = BRP.FbckType.from_value(p.bt_resp.feedback_type()[0])
            snrs = tuple((meas + [meas[-1]] * ft.nmeas)[:ft.nmeas]) if ft.snr and not ft.chan else ()
            ini = int(self._initiator_bit())
            fr = BRP.BrpFrame(bre=BRP.BeamRefinement(initiator=ini, tx_train_resp=1, tx_trn_ok=1, bs_fbck=i + 1,
                                                     fbck_type=ft))
            return fr, snrs

        def gen(mac, tt):
            fr, snrs = frame()
            t_brp = BRP.brp_txtime(mac._brp_len(fr, len(snrs)), 0, 0)
            if not p.bt_resp.may_send_feedback(t_req, mac.sim.now + t_brp):
                mac.log('bt_feedback_late', peer=ta)
                return None                     # позже предела — не передавать (10.42.7)
            p.brp_resp_done = True

            def build(t2):
                t_end = t2 + t_brp
                return [mac._brp_raw(ta, fr, BRP.brp_duration(t_end, max(t_end, mac.seq['txop_end'])), snrs)]
            # Initiator = 1 — начало транзакции: пир отвечает BRP (10.42.6.4.2); иначе ответа нет
            exp = (lambda frs: frs[0].action == 'BRP' and frs[0].ta == ta and frs[0].ra == mac.addr) \
                if fr.bre.initiator else None
            r = yield mac.Tx(None, 0, mac._beam_to(ta), build=build, resp_mcs=0, resp_gap=BRPIFS, what='BT feedback',
                             expect=exp)
            mac.log('bt_feedback', peer=ta, bs_fbck=i + 1, initiator=fr.bre.initiator)
            return r is not None or exp is None
        job.gen = gen
        self._enqueue(self.AC_VO, job)

    def _bt_rx_feedback(self, ta, fr, tail, rxv):
        """Инициатор сопровождения: принятый BRP с TX-train-response после своего запроса TRN-T — исход
        (beamtrack.Initiator.feedback): позже предела — игнорировать (10.42.7)."""
        p = self.peers.get(ta)
        bt = getattr(p, 'bt', None) if p is not None else None
        if bt is None or bt.last_tx_req is None or bt.fb_since or not fr.bre.tx_train_resp:
            return False
        res = bt.feedback(self.sim.now)
        if res == 'ignore':
            p.brp_st = {}
            self.log('bt_feedback_ignored', peer=ta)
            return False
        self.log('bt_feedback_ok', peer=ta)
        p.brp_st = dict(getattr(p, 'brp_st', {}) or {}, tx_awvs=getattr(p, 'bt_awvs', ()))
        self._bf_snr_reset(ta, refined=True)
        return True

    # ------------------------------------------------------------------ поддержание связи (11.27.1)
    def _blm_negotiated(self, peer, blm_peer):
        p = self.peer(peer)
        p.blm_dur = LM.negotiate(self.bf.blm, blm_peer)
        p.blm_timer = LM.LinkTimer(p.blm_dur, self.halts) if p.blm_dur is not None else None
        self.log('blm_negotiated', peer=peer, dur=p.blm_dur)

    def add_halt(self, s, e):
        """BTI + A-BFT BI [s, e): остановка таймеров связи (11.27.1)."""
        self.halts.append((Fr(s), Fr(e)))
        if len(self.halts) > 64:
            del self.halts[:-64]

    def _blm_set(self, peer, why):
        p = self.peers.get(peer)
        tm = getattr(p, 'blm_timer', None) if p is not None else None
        if tm is None:
            return
        tm.set(self.sim.now)
        p.blm_expired = False
        self._blm_arm(peer)

    def _blm_arm(self, peer):
        p = self.peers[peer]
        ev = getattr(p, 'blm_ev', None)
        if ev is not None:
            ev.cancel()
        tm = p.blm_timer
        x = tm.expires_at()
        t = max(self.sim.now, x - self._ka_margin())
        p.blm_ev = self.sim.at(t, self._blm_check, peer)

    def _ka_margin(self):
        """Запас QoS Null до истечения: у точки — половина (QoS Null станции с Ack ставит таймеры обеих сторон —
        вторая не нужна; выбор реализации)."""
        m = Fr(self.bf.keepalive_margin_us)
        return m / 2 if self.ROLE == 'AP' else m

    def _blm_check(self, peer):
        """Таймер связи: близко к истечению и нет MSDU — QoS Null; истёк — квази-омни ответчика / ISS инициатора."""
        p = self.peers[peer]
        p.blm_ev = None
        tm = p.blm_timer
        if tm is None or tm.t_set is None:
            return
        x = tm.expires_at()                     # с остановками, известными на этот момент
        if self.sim.now >= x:
            self._blm_expired(peer)
            return
        if x - self.sim.now > self._ka_margin():
            self._blm_arm(peer)
            return
        if not self._has_data_for(peer) and not getattr(p, 'keepalive_job', None) and self._may_send_data(peer):
            self._send_qos_null(peer)
        p.blm_ev = self.sim.at(x, self._blm_check, peer)

    def _has_data_for(self, peer):
        return any(q.addr == peer for q in self._data_peers())

    def _blm_expired(self, peer):
        p = self.peers[peer]
        if getattr(p, 'blm_expired', False):
            return
        p.blm_expired = True
        self.log('blm_expired', peer=peer)
        # 11.27.1: ответчик связи в CBAP — приём квази-омни после истечения
        p.rx_beam = None
        if getattr(p, 'bf_role', None) == 'ini' and self.bf.blm_restore:
            self.log('blm_restore', peer=peer)
            self._rebf(peer, 'blm')

    def _send_qos_null(self, peer, why='keepalive'):
        """QoS Null (9.3.2.1, табл. 9-1: подтип 1100) с Normal Ack через EDCAF AC_BE (TID 0) — поддержание связи
        (11.27.1); Duration — SIFS + Ack (9.2.5.2 a) 5) i))."""
        p = self.peer(peer)
        to_ds, from_ds = self._ds_bits()
        mcs = 1
        t_ack = txtime(14, 1)
        job = self.Job(None, None, None, peer, 'QoS Null', queue=True)

        def build(tt):
            a3 = self.addr if from_ds else peer          # табл. 9-4: From DS — A3 = SA; To DS — A3 = DA (точка)
            return [FR.qos_null(ceil(SIFS + t_ack), peer, self.addr, a3, p.sn, to_ds, from_ds,
                                retry=int(job.retries > 0))]

        def gen(mac, tt):
            r = yield mac.Tx(None, mcs, mac._beam_to(peer), build=build, what='QoS Null',
                             expect=lambda frs: frs[0].kind == 'Ack' and frs[0].ra == mac.addr, resp_mcs=1)
            return r is not None

        def fin(ok):
            p.keepalive_job = None
            p.sn = (p.sn + 1) % 4096
        job.gen, job.est, job.done = gen, (lambda tt: txtime(30, mcs) + SIFS + t_ack), fin
        p.keepalive_job = job
        self.log(why, peer=peer)
        self._enqueue(self.AC_BE, job)

    # ------------------------------------------------------------------ события BF
    def _bf_complete(self, peer, how):
        """SLS (без BRP) или BRP завершён успешно: таймер связи (11.27.1), опора SNR для политики деградации."""
        p = self.peer(peer)
        p.fails = 0
        self._bf_snr_reset(peer, refined=how == 'brp')
        self._blm_set(peer, how)
        self.log('bf_complete', peer=peer, how=how)

    def _bf_snr_reset(self, peer, refined=False):
        """Новая опора SNR. Политика деградации: None — связь в норме; 'refining' — уточнение начато; 'refined' —
        уточнение (BRP / сопровождение) завершено: новое падение — повторное BF."""
        p = self.peer(peer)
        p.snr_ref = {}
        st = getattr(p, 'degraded', None)
        p.degraded = 'refined' if refined and st in ('refining', 'refined') else None

    def _bf_on_response(self, frames, rxv):
        """Принят немедленный ответ своему обмену: таймер связи инициатора (11.27.1)."""
        f = frames[0]
        if f.kind in RESP_KINDS:
            peer = f.ta if f.ta is not None else (self.seq['job'].ra if self.seq and self.seq['job'] else None)
            if peer is not None and peer in self.peers:
                self.peers[peer].fails = 0
                self._blm_set(peer, 'init_rx_resp')

    def _bf_on_resp_sent(self, kind, ra):
        """Передан немедленный ответ: таймер связи получателя (11.27.1)."""
        if kind in RESP_KINDS and ra in self.peers:
            self._blm_set(ra, 'recip_tx_resp')

    def _bf_on_job_done(self, job, ok):
        if job is None or job.ra is None or job.ra not in self.peers or job.name in ('SLS', 'BRP setup'):
            return
        p = self.peers[job.ra]
        p.fails = 0 if ok else getattr(p, 'fails', 0) + 1
        lim = self.bf.fail_limit
        if lim and p.fails >= lim:
            p.fails = 0
            self.log('degrade_fail', peer=job.ra)
            self._rebf(job.ra, 'fail')

    def _bf_on_rx(self, f, rxv):
        """SNR принятого от пира кадра против опорного при той же диаграмме приёма — политика деградации. Только
        кадры, переданные пиром направленно этой STA (не развёртки: DMG Beacon, SSW)."""
        if self.bf.degrade_db is None or f.ta is None or f.ta not in self.peers or rxv.SNR is None or \
                f.kind in ('DMG Beacon', 'SSW', 'SSW-Feedback', 'SSW-Ack') or f.ra != self.addr:
            return
        p = self.peers[f.ta]
        if getattr(p, 'tx_beam', None) is None:
            return
        refs = p.__dict__.setdefault('snr_ref', {})
        key = self.rx_beam
        if key not in refs:
            refs[key] = rxv.SNR
            return
        drop = refs[key] - rxv.SNR
        if drop < self.bf.degrade_db:
            return
        last = getattr(p, 'degrade_t', None)
        st = getattr(p, 'degraded', None)
        if last is not None and self.sim.now - last < (self.bf.min_reaction_us if st != 'refining'
                                                        else 4 * self.bf.min_reaction_us):
            return                              # уточнение ещё идёт — ждать его итога
        p.degrade_t = self.sim.now
        if self.bf.resls_db is not None and drop >= self.bf.resls_db or st in ('refined', 'refining', 'rebf'):
            if st == 'rebf' and self._rebf_pending(f.ta):
                return
            self.log('degrade', peer=f.ta, drop=drop, action='rebf')
            p.degraded = 'rebf'
            self._rebf(f.ta, 'degrade')
            return
        p.degraded = 'refining'
        if self.bt_may_request(f.ta):
            # сопровождение передачи — на ближайшем PPDU данных к пиру; данных нет за min_reaction_us — BRP
            p.bt_req = 'tx'
            self.log('degrade', peer=f.ta, drop=drop, action='beam_tracking')
            self.sim.after(self.bf.min_reaction_us, self._bt_fallback, f.ta)
        else:
            self.log('degrade', peer=f.ta, drop=drop, action='brp')
            self._refine_brp(f.ta)

    def _bt_fallback(self, peer):
        p = self.peers[peer]
        if getattr(p, 'bt_req', None) == 'tx':
            p.bt_req = None
            self.log('degrade', peer=peer, action='brp (нет данных для сопровождения)')
            self._refine_brp(peer)

    def _refine_brp(self, peer):
        """Транзакция BRP по политике деградации. 10.42.3.1: в том же распределении, что SLS, инициатор уточнения —
        инициатор SLS; ответчик SLS начинает транзакцию только в следующем распределении (в CBAP-only DTI — после
        BTI, PLAN.md №20)."""
        p = self.peers[peer]
        alloc = getattr(p, 'sls_alloc', None)
        if getattr(p, 'bf_role', None) == 'resp' and alloc is not None and self.cbap is not None and \
                self.cbap[0] == alloc[0]:
            if not getattr(p, 'brp_deferred', False):
                p.brp_deferred = True
                self.log('brp_deferred', peer=peer, until=alloc[1])
                self.sim.at(alloc[1], self._refine_deferred, peer)
            return
        if not any(j.name == 'BRP' and j.ra == peer for j in self.acs[self.AC_VO].jobs):
            self.start_brp(peer)

    def _refine_deferred(self, peer):
        p = self.peers[peer]
        p.brp_deferred = False
        if getattr(p, 'degraded', None) == 'refining':
            self._refine_brp(peer)

    def _rebf_pending(self, peer):
        return any(j.name == 'SLS' and j.ra == peer for j in self.acs[self.AC_VO].jobs)

    def _rebf(self, peer, why):
        """Повторное BF с пиром (роль — в подклассе: станция может выбрать A-BFT)."""
        if self._rebf_pending(peer):
            return
        self.start_sls(peer, done=lambda ok: self._confirm_rebf(peer, ok))

    def _confirm_rebf(self, peer, ok):
        self.log('rebf_done', peer=peer, ok=ok)
        if ok:
            self._indicate(ML.MlmeBfTrainingIndication(PeerSTAAddress=peer, ResultCode=ML.SUCCESS))
            return
        # SLS не удался (повторы исчерпаны): новая попытка в следующем BI (политика ядра; стандарт — «may»)
        if self.bi_tu:
            self.sim.after(self.bi_tu * 1024, self._rebf_retry, peer)

    def _rebf_retry(self, peer):
        p = self.peers.get(peer)
        if p is not None and getattr(p, 'blm_expired', False) or getattr(p, 'degraded', None) == 'rebf':
            self._rebf(peer, 'retry')
