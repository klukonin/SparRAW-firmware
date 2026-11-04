# SPDX-License-Identifier: AGPL-3.0-or-later
"""Станция DMG (AP/PCP-инфраструктура и non-AP STA) по 802.11-2020, собранная только из модулей эталона: timing,
fields, elements, bi, sls, abft, brp, mlme, cbap, blockack, duration, medium. Два режима.

Генератор (Network): станции на направленном эфире medium.Medium ведут себя по стандарту.
  AP: в TBTT (11.1.3.3.1) — BTI из DMG Beacon по всем секторам через SBIFS (10.42.4, bi.txss_plan/bti_beacons),
      поля маяка — кодеками fields/elements (9.3.4.2, табл. 9-45); A-BFT (10.42.5.1/10.42.5.2, abft.ApAbft: приём SSW
      квази-омни, SSW-Feedback за aSSFBDuration + MBIFS до конца слота); ATI (10.39.3: Announce каждой обученной/
      ассоциированной STA, ответ Ack через SIFS, следующий запрос через SIFS после ответа или PIFS без него); DTI —
      по Extended Schedule (9.4.2.131; по умолчанию один широковещательный CBAP), доступ — EDCAF cbap.Station
      (10.23.2, 10.39.5); после SSW-Feedback — BRP setup с Capability Request = 1 на MCS 0 через Sector Select
      ответчика в aMinBTIPeriod BI (10.42.5.2, 10.42.3.2); ассоциация (mlme.ApMlme, 11.3.5.3/11.3.5.5), получатель
      Block Ack (blockack, 10.25), нисходящие Data.
  STA: пассивный приём DMG Beacon квази-омни (11.1.4.2.2), JOIN (11.1.4.5, mlme.Join), A-BFT ответчиком
      (abft.Responder, 10.42.5.2), SSW-Feedback → лучший сектор передачи, ответ на BRP setup, (ре)ассоциация
      (mlme.StaMlme, 11.3.5.2/11.3.5.4), ADDBA (10.25.2), восходящие A-MPDU с BlockAck (10.25.6), контроль маяков
      (mlme.LinkMonitor, 11.1.3.1: dot11BeaconPeriod × dot11MaxLostBeacons) → потеря связи → повторный A-BFT и
      Reassociation Request к тому же AP.
  Журнал эфира — Network.air_log() → [AirRec].

Судья (judge): журнал [AirRec] (моменты на эфире, TA/RA, вид, Duration, MCS, разобранные поля, необязательные байты)
  → один список JViolation(idx, module, rule, clause, msg) по всем применимым проверкам: bi.check_air_log,
  abft.check_abft_log + abft.check_obligations, sls.check_sls_log (SSW вне BTI/A-BFT), brp.check_setup/check_brp_log,
  cbap.check_air_log (кадры CBAP), duration.check_duration, fields.check_mpdu (байты DMG Beacon/SSW/SSW-Feedback),
  elements (порядок и содержимое тел и элементов маяка), blockack (ADDBA), mlme.check_assoc_log.
  Конфигурация BI для судьи берётся из байтов DMG Beacon (BIC, DMG Parameters, Extended Schedule, Next DMG ATI);
  времена и поля SSW/CDOWN — из AirRec.fields (байты — только для побитовых проверок).

API:
  net = Network(seed=0, bi_tu=20)
  ap  = net.add_ap('02:00:00:00:00:01', sectors=8)
  sta = net.add_sta('02:00:00:00:00:02', sectors=4, ap_sector=2, sta_sector=1)   # модель канала — Network.link
  net.block(ap.addr, sta.addr, t0, t1)             # затенение пары (потеря маяков)
  net.run_bis(n)                                   # смоделировать BI 0…n−1
  log = net.air_log();  v = judge(log)             # [] — журнал соответствует стандарту
  sta.state, sta.mlme, sta.orig, ap.mlme, ap.recipients, ap.rx_msdus — состояние для проверок.

Принятые трактовки — PLAN.md; свои спорные места (СПОРНО) — в докстроках. Не моделируется: PCP/PBSS-специфика
(PCP Association Ready, Information Response), SP-распределения у генератора (судья их проверяет по Extended
Schedule), SLS/BRP-транзакции уточнения в DTI у генератора (судья проверяет sls/brp, если они есть в журнале),
несколько DMG-антенн, TSF-дрейф (TSF STA = TSF AP), безопасность (RSNA, 4-way handshake), энергосбережение."""
import random
from collections import namedtuple
from fractions import Fraction as Fr
from math import ceil

from . import abft as A
from . import bi as B
from . import blockack as BA
from . import brp as P
from . import cbap as C
from . import duration as D
from . import elements as E
from . import fields as F
from . import mlme as M
from . import sls as S
from .medium import ANY, DmgFrame, Medium, NEG_INF
from .timing import (aMinBTIPeriod, ALLOC_CBAP, AID_BROADCAST, BCAST, BRPIFS,
                     DOT11_MAX_LOST_BEACONS, LEN_SSW, LEN_SSW_FB, PIFS, SBIFS, SIFS, SIFS_TOL, TSF_LOW_MOD,
                     TU, txtime, txtime_control)

# ======================================================================================================
#                                 Выбор модели (не правила стандарта)
# ======================================================================================================
NOISE_DBM = -80             # шум приёмника для оценки SNR (SNR Report 9.5.3): SNR = уровень − шум; стандарт не задаёт
DATA_PAYLOAD = 1500         # MSDU, октеты
QOS_HDR = 26                # 9.3.2.1: заголовок QoS Data DMG (FC 2, Dur 2, A1–A3 18, Seq 2, QoS 2) без HT Control
AMPDU_DELIM = 4             # 9.7.1: разделитель MPDU в A-MPDU (4 октета) + выравнивание до 4
MPDUS_PER_AMPDU = 8
CBAP_TAIL_GUARD = None      # None — guard_between(False, False, BI) (10.39.6.5) перед следующим TBTT; иначе мкс
ROLE_AP, ROLE_STA = 'ap', 'sta'

# Виды кадров. Индивидуальные кадры управления/Action требуют Ack (9.3.3, 10.3.2.11) — для движка EDCA cbap они
# эквивалентны Data с Normal Ack (те же правила доступа 10.23.2); BRP — Action No Ack (9.6.21.3).
MGMT_ACKED = frozenset({'Association Request', 'Association Response', 'Reassociation Request',
                        'Reassociation Response', 'ADDBA Request', 'ADDBA Response', 'DELBA', 'Announce',
                        'Disassociation', 'Deauthentication', 'Probe Request', 'Probe Response', 'Authentication',
                        'Action', 'Information Request', 'Information Response'})
NO_ACK_KINDS = frozenset({'BRP', 'Action No Ack'})
BF_KINDS = frozenset({'DMG Beacon', 'SSW', 'SSW-Feedback', 'SSW-Ack'})
CTRL_KINDS = frozenset({'Ack', 'BlockAck', 'BlockAckReq', 'RTS', 'DMG CTS', 'CF-End'})
BODY_FRAMES = {k: k for k in (E.ASSOC_REQ, E.ASSOC_RESP, E.REASSOC_REQ, E.REASSOC_RESP, E.PROBE_REQ, E.PROBE_RESP,
                              E.AUTH, E.DEAUTH, E.DISASSOC)}

# receivers — кто декодировал PPDU, heard — кто синхронизировался на его преамбулу (20.8; None — неизвестно:
# судья cbap тогда считает, что все слышат всех, как cbap.check_air_log)
AirRec = namedtuple('AirRec', 't_start t_end src dst kind dur mcs fields raw tx_cfg receivers heard',
                    defaults=(0, None, None, None, None, None))
JViolation = namedtuple('JViolation', 'idx module rule clause msg')


def engine_kind(kind):
    """Вид кадра для движка EDCA cbap.Station и судьи cbap.check_air_log (адаптер: cbap знает только Data/A-MPDU/
    управляющие кадры)."""
    if kind in MGMT_ACKED or kind in NO_ACK_KINDS:
        return 'Data'
    return kind


def mpdu_len(body_len):
    """MMPDU: заголовок управления + тело + FCS (9.3.3.1, рис. 9-23)."""
    return P.MGMT_HDR + body_len + P.FCS


def ampdu_len(n):
    """A-MPDU из n QoS Data по DATA_PAYLOAD: каждое MPDU с разделителем, дополнено до 4 октетов (9.7.1)."""
    one = AMPDU_DELIM + QOS_HDR + DATA_PAYLOAD + P.FCS
    return n * (one + (-one) % 4)


def snr_of(power_dbm):
    """SNR, дБ, в шаге SNR Report (fields.snr_quantize, PLAN.md №6)."""
    if power_dbm == NEG_INF:
        return F.snr_quantize(-13)
    return F.snr_quantize(Fr(power_dbm).limit_denominator(1000) - NOISE_DBM)


def tbtt(k, bi_tu):
    return B.tbtt(k, bi_tu)


# ======================================================================================================
#                                 Эфир с затенением (адаптер medium)
# ======================================================================================================
class _Air(Medium):
    """medium.Medium + затенение пары STA на интервале [t0, t1) (усиление −∞): модель потери маяков."""
    def __init__(self, **kw):
        super().__init__(**kw)
        self.blocked = []

    def link_gain(self, tx, tx_cfg, rx, rx_cfg):
        for a, b, t0, t1 in self.blocked:
            if {tx, rx} == {a, b} and t0 <= self.now < t1:
                return NEG_INF
        return super().link_gain(tx, tx_cfg, rx, rx_cfg)


class _Msdu(C.Msdu):
    """Элемент очереди EDCAF с настоящим видом кадра и полями; extra — время ответов вне механизма Ack движка (BRP
    setup: ответ пира и завершающий кадр — 10.39.5 «including any control frame responses» → в exchange_time)."""
    def __init__(self, dst, kind, length, mcs, ack=True, agg=False, extra=0, **info):
        super().__init__(dst, length=length, mcs=mcs, ack=ack, agg=agg)
        self.kind_real, self.extra, self.info = kind, Fr(extra), dict(info)

    def exchange_time(self, with_rts=None):
        return super().exchange_time(with_rts) + self.extra


# ======================================================================================================
#                                      Общая часть станции
# ======================================================================================================
class _Node:
    """Агент medium: протокольный слой + движок EDCA cbap.Station (адаптер событий medium → cbap.Station).
    Передачи вне EDCA (маяки, SSW, SSW-Feedback, запросы ATI, BRP-ответы — «OOB») сообщаются движку как занятость
    среды своей передачей (10.3.2.1: «busy when the STA is transmitting»)."""
    def __init__(self, net, addr, role, sectors, seed):
        self.net, self.m, self.addr, self.role = net, net.m, addr, role
        self.sectors = list(range(sectors)) if isinstance(sectors, int) else list(sectors)
        self.rng = random.Random(seed)
        self.cb = C.Station(addr, rng=C.Rng(self.rng.randrange(1 << 30)), cbaps=[])
        self._gen = 0
        self.tx_cfg = {}                     # пир → (антенна, сектор) передачи
        self.m.add_station(addr, antennas={0: self.sectors}, agent=self, rx_cfg=(0, None))
        self.windows = []                    # CBAP-окна, переданные движку

    # ---------------- движок EDCA ----------------
    def _sync(self, t):
        """Выполнить действие движка, назначенное на момент t, до внешнего события в тот же момент (порядок
        cbap.Air: окончания, затем начала PPDU, затем тайм-ауты)."""
        na = self.cb.next_action()
        if na is None or na[0] > t:
            return
        assert na[0] == t, (self.addr, na, t)
        if na[1] == 'tx':
            self._engine_tx(t)
        else:
            self.cb.timeout(t)
            self._poll(t)

    def _kick(self):
        self._gen += 1
        na = self.cb.next_action()
        if na is not None:
            self.m.at(max(na[0], self.m.now), self._engine_timer, self._gen)

    def _engine_timer(self, t, gen):
        if gen != self._gen:
            return
        self._sync(t)
        self._kick()

    def add_window(self, s, e):
        """CBAP (s, e) движку (10.39.5: EDCAF работает только внутри CBAP)."""
        s, e = Fr(s), Fr(e)
        if self.windows and s < self.windows[-1][1]:
            return
        self.windows.append((s, e))
        self.cb.cbaps.append((s, e))
        self._kick()

    def enqueue(self, msdu):
        t = self.m.now
        self._sync(t)
        self.cb.enqueue(t, msdu)
        self._kick()

    def queued(self, pred=lambda m: True):
        return [m for ed in self.cb.edcafs.values() for m in ed.queue if pred(m)]

    def flush_queue(self):
        """Сброс очереди (реассоциация, 11.3.5.4) — только когда движок не ведёт обмен."""
        cb = self.cb
        if cb.txop is None and cb.wait is None and cb.sched is None and cb.tx is None:
            for ed in cb.edcafs.values():
                ed.queue.clear()

    def _engine_tx(self, t):
        f = self.cb.start(t)
        role = self.cb.tx[3]
        msdu = None
        if f.kind in C.DATA_KINDS and role == 'init':
            msdu = self.cb.txop.ed.queue[0]
        kind, fields, length = f.kind, {}, f.length
        if msdu is not None and isinstance(msdu, _Msdu):
            kind, fields = msdu.kind_real, dict(msdu.info)
        fields, dur = self._out_frame(t, kind, f, msdu, fields)
        if dur is not None:
            f.dur = dur                      # Duration на эфире = Duration движка (TXNAV, 10.23.2.2)
        fr = DmgFrame(kind, self.addr, f.dst, length, f.mcs, f.dur, dict(fields, _eng=True))
        self.m.transmit(self.addr, fr, t, self.tx_cfg.get(f.dst, (0, None)))

    def _oob_at(self, t, frame, cfg):
        self.m.at(t, self._oob_tx, frame, cfg)

    def _oob_tx(self, t, frame, cfg):
        self._sync(t)
        frame.fields['_oob'] = True
        if self.cb.wait is None:
            self.cb.rx_start(t)              # своя передача — среда занята для EDCAF
            frame.fields['_busy'] = True
        self.m.transmit(self.addr, frame, t, cfg)
        self._kick()

    # ---------------- обратные вызовы medium ----------------
    def on_rx_start(self, t, entry, power):
        self._sync(t)
        self.cb.rx_start(t)
        self._rx_start(t, entry)
        self._kick()

    def on_rx_end(self, t, entry, frame, res):
        self._sync(t)
        cf = None
        if frame is not None:
            cf = C.Frame(engine_kind(frame.kind), frame.src, frame.dst, frame.length, frame.mcs, frame.dur,
                         ack=frame.kind not in NO_ACK_KINDS)
        self.cb.rx_end(t, cf)
        self._poll(t)
        if frame is not None and (frame.dst in (self.addr, BCAST) or frame.kind in BF_KINDS):
            self._rx(t, entry, frame, res)
        self._kick()

    def on_tx_end(self, t, entry):
        self._sync(t)
        fl = entry.frame.fields
        if fl.get('_eng'):
            self.cb.tx_end(t)
        elif fl.get('_busy'):
            self.cb.rx_end(t, C.Frame('BRP', self.addr, self.addr, entry.frame.length, entry.frame.mcs, 0, ack=False))
        self._poll(t)
        self._tx_end(t, entry)
        self._kick()

    def _poll(self, t):
        cb = self.cb
        dl, ds = list(cb.delivered), list(cb.discarded)
        cb.delivered.clear()
        cb.discarded.clear()
        for ed in cb.edcafs.values():
            del ed.log[:-4]                  # журнал backoff нужен лишь для отладки; next_action копирует станцию
        for x in dl:
            self._delivered(t, x)
        for x in ds:
            self._discarded(t, x)

    # ---------------- крючки протокола ----------------
    def _rx_start(self, t, entry):
        pass

    def _rx(self, t, entry, frame, res):
        pass

    def _tx_end(self, t, entry):
        pass

    def _delivered(self, t, msdu):
        pass

    def _discarded(self, t, msdu):
        pass

    def _out_frame(self, t, kind, f, msdu, fields):
        return fields, None

    # ---------------- общие кадры ----------------
    def dmg_capabilities(self, aid=0, ap=False):
        """9.4.2.127: DMG Capabilities (одна RX-антенна, Total Number of Sectors = число − 1, SC MCS до 12)."""
        sc = dict(num_rx_dmg_antennas=0, total_num_sectors=len(self.sectors) - 1, max_sc_rx_mcs=12,
                  max_sc_tx_mcs=12, code_rate_13_16=1)
        apc = dict(max_associated_sta=self.net.max_sta) if ap else {}
        return E.encode_dmg_capabilities(E.DmgCapabilities(self.addr, aid, sc, apc, 0, {}, 0, 0))


# ======================================================================================================
#                                              AP
# ======================================================================================================
class BiPlan:
    """Расписание BI k, объявленное AP: маяки BTI, A-BFT, ATI, CBAP-окна DTI, поля для маяка."""
    def __init__(self, **kw):
        self.__dict__.update(kw)


class DmgAp(_Node):
    """AP DMG-инфраструктуры (BSS Type 3, 9.4.1.46). Параметры: sectors — сектора TXSS маяков (антенна 0);
    abft_slots, fss — A-BFT Length/FSS в числах (поле + 1, PLAN.md №1); ati — есть ли ATI; ati_duration — мкс;
    dl — нисходящих Data на ассоциированную STA за BI; ssid."""
    def __init__(self, net, addr, sectors=8, seed=0, abft_slots=8, fss=4, ati=True, ati_duration=200, dl=1,
                 ssid=b'dmg-ref'):
        super().__init__(net, addr, ROLE_AP, sectors, seed)
        self.abft_slots, self.fss, self.ati, self.ati_duration, self.dl, self.ssid = (abft_slots, fss, ati,
                                                                                     ati_duration, dl, ssid)
        self.mlme = M.ApMlme(addr)
        self.k = -1
        self.plan = None
        self.recipients = {}                 # sta → blockack.Recipient
        self.pending_ba = {}                 # sta → (SSN, bitmap) для ответа BlockAck
        self.rx_msdus = {}                   # sta → число принятых MSDU (выданные буфером BA, по всем соглашениям)
        self.rx_base = {}
        self.rx_data = {}                    # sta → принятые Data без Block Ack
        self.trained = {}                    # sta → BI последнего SSW-Feedback в A-BFT
        self.brp_due = {}                    # sta → последний BI окна обязанности BRP (10.42.5.2)
        self.brp_txn = None                  # текущий BRP setup: dict(sta, te1, dur1)
        self.ati_state = None

    # ---------------- расписание BI ----------------
    def _beacon(self, k, ts, sector, cdown, dur, plan):
        f = F.DmgBeacon(duration=int(dur), bssid=self.addr, timestamp=int(ts),
                        ssw=F.Ssw(direction=F.DIR_INITIATOR, cdown=cdown, sector_id=sector, antenna_id=0),
                        beacon_interval=self.net.bi_tu, bic=plan.bic, params=plan.params, cc=None,
                        elements=plan.elements)
        return F.encode_dmg_beacon(f, role='ap', pcp=False, rx_antennas=1)

    def _elements(self, allocs, ati):
        """Табл. 9-45: DMG Capabilities (7), Extended Schedule (8), DMG Operation (11), Next DMG ATI (12), SSID (18)."""
        els = [self.dmg_capabilities(0, ap=True), E.encode_extended_schedule(allocs),
               E.encode_dmg_operation(dict(tddti=0, pseudo_static=0, pcp_handover=0), self.net.bss_cfg)]
        if ati is not None:
            els.append(E.encode_next_dmg_ati(ati[0] % TSF_LOW_MOD, ati[1]))
        els.append(E.encode_ssid(self.ssid))
        return tuple((e.eid, e.ext, e.info) for e in E.parse_elements(b''.join(els)))

    @staticmethod
    def _cbap_allocs(s, e, bi_us):
        """Широковещательный CBAP [s, e) блоками ≤ 65 535 мкс (9.4.2.131), между блоками — guard (10.39.6.5)."""
        out, g = [], ceil(B.guard_between(False, False, bi_us))
        while e - s >= 1:
            d = min(e - s, E.CBAP_BLOCK_MAX)
            out.append((s, s + d))
            s += d + g
        return out

    def _plan_bi(self, k):
        bi_tu = self.net.bi_tu
        bi_us = bi_tu * TU
        t0, t1 = tbtt(k, bi_tu), tbtt(k + 1, bi_tu)
        bic = F.Bic(ati_present=int(self.ati), abft_length=self.abft_slots - 1, fss=self.fss - 1, is_resp_txss=1,
                    next_abft=0, txss_span=1, n_bis_abft=1)
        params = F.DmgParams(bss_type=3)
        dummy_alloc = [E.Allocation(dict(allocation_type=ALLOC_CBAP, pcp_active=1), 0, AID_BROADCAST,
                                    AID_BROADCAST, 0, 1, 1, 0)]
        plan = BiPlan(k=k, t0=t0, t1=t1, bic=bic, params=params,
                      elements=self._elements(dummy_alloc, (0, 0) if self.ati else None))
        n_len = len(self._beacon(k, 0, 0, 0, 0, plan))      # длина маяка не зависит от значений полей
        t_b = txtime_control(n_len)
        _, _, btis = B.txss_plan(self.sectors)
        beacons, bti_end = B.bti_beacons(t0, btis[0], t_b)
        layout = A.AbftLayout(A.abft_start(bti_end), self.abft_slots, self.fss, True)
        cur = layout.end
        ati = None
        if self.ati:
            s = ceil(M.ati_start_earliest(cur))              # 10.39.3: не раньше Max(guard, MBIFS) после A-BFT
            ati = (s, self.ati_duration)
            cur = s + self.ati_duration
        tail = CBAP_TAIL_GUARD if CBAP_TAIL_GUARD is not None else ceil(B.guard_between(False, False, bi_us))
        blocks = self._cbap_allocs(ceil(cur), int(t1) - tail, bi_us)
        allocs = [E.Allocation(dict(allocation_id=0, allocation_type=ALLOC_CBAP, pcp_active=1), 0, AID_BROADCAST,
                               AID_BROADCAST, int(s) % TSF_LOW_MOD, int(e - s), 1, 0) for s, e in blocks]
        plan.elements = self._elements(allocs, ati)
        plan.beacons, plan.bti_end, plan.layout, plan.ati_win, plan.cbaps = beacons, bti_end, layout, ati, blocks
        plan.t_beacon = t_b
        return plan

    def _tbtt(self, t, k):
        """11.1.3.3.1: BI начинается в TBTT; маяки BTI, A-BFT, ATI, окна CBAP."""
        self.k = k
        plan = self.plan = self._plan_bi(k)
        for s, e in plan.cbaps:
            self.add_window(s, e)
        for ts, te, sec, cd, dur in plan.beacons:
            raw = self._beacon(k, ts, sec, cd, dur, plan)
            fr = DmgFrame('DMG Beacon', self.addr, BCAST, len(raw), 0, dur,
                          dict(sector=sec, cdown=cd, antenna=0, raw=raw))
            self._oob_at(ts, fr, (0, sec))
        self.apabft = A.ApAbft(self.addr, plan.layout, bi=k)
        self.ssw_rx = {}
        for s in range(plan.layout.n_slots):
            self.m.at(plan.layout.fb_start(s), self._abft_fb, s)
        if plan.ati_win:
            self.m.at(plan.ati_win[0], self._ati_begin)
        self.m.at(plan.cbaps[0][0], self._dti_begin)
        self.m.at(plan.t1, self._tbtt, k + 1)

    # ---------------- A-BFT (10.42.5.2) ----------------
    def _abft_fb(self, t, s):
        rx = self.ssw_rx.pop(s, [])
        fb = self.apabft.slot_feedback(s, rx)
        if fb is None:
            return
        sta = fb.dst
        snr = F.snr_quantize(fb.snr)
        raw = F.encode_frame(F.SswFbFrame(duration=0, ra=sta, ta=self.addr,
                                          fb=F.SswFb(sector_select=fb.sector_select, antenna_select=fb.ant_select,
                                                     snr_report=F.snr_report_raw(snr)),
                                          brp=F.BrpReq(), blm=F.Blm()), abft=True, sender_ap_pcp=True)
        self.tx_cfg[sta] = fb.tx_sector      # 10.42.5.2: связь с ответчиком — через его Sector Select
        fr = DmgFrame('SSW-Feedback', self.addr, sta, LEN_SSW_FB, 0, 0,
                      dict(sector_select=fb.sector_select, ant_select=fb.ant_select, snr=snr, raw=raw))
        self._oob_tx(t, fr, fb.tx_sector)
        self.trained[sta] = self.k
        # 10.42.5.2: BRP с Capability Request = 1 в одном из aMinBTIPeriod BI, начиная с этого
        self.brp_due[sta] = self.k + aMinBTIPeriod - 1

    # ---------------- ATI (10.39.3) ----------------
    def _ati_begin(self, t):
        plan = self.plan
        targets = [s for s in self.tx_cfg if self.trained.get(s) == self.k or self.mlme.state(s) in (M.S3, M.S4)]
        self.ati_state = dict(queue=targets, end=Fr(plan.ati_win[0] + plan.ati_win[1]), wait=None)
        self._ati_next(t)

    def _ati_next(self, t):
        st = self.ati_state
        if st is None or not st['queue']:
            self.ati_state = None
            return
        sta = st['queue'][0]
        t_req, t_ack = txtime_control(LEN_ANNOUNCE), txtime_control(C.LEN['Ack'])
        if t + t_req + SIFS + t_ack > st['end']:
            self.ati_state = None
            return
        st['queue'].pop(0)
        te = t + t_req
        dur = D.duration_ati_request(st['end'] - te)       # 10.39.3: покрывает остаток ATI
        fr = DmgFrame('Announce', self.addr, sta, LEN_ANNOUNCE, 0, dur, dict(bi=self.k))
        st['wait'] = dict(sta=sta, te=te, started=False)
        self._oob_tx(t, fr, self.tx_cfg[sta])
        self.m.at(te + PIFS, self._ati_check, sta, te)

    def _ati_check(self, t, sta, te):
        st = self.ati_state
        if st is None or st['wait'] is None or st['wait']['sta'] != sta or st['wait']['te'] != te:
            return
        if not st['wait']['started']:
            # 10.39.3: ответа нет за SIFS — «as early as one PIFS after the end of its previous transmission»
            st['wait'] = None
            self._ati_next(t)

    def _rx_start(self, t, entry):
        st = self.ati_state
        if st and st['wait'] and entry.src == st['wait']['sta']:
            st['wait']['started'] = True

    # ---------------- DTI ----------------
    def _dti_begin(self, t):
        for sta, last in list(self.brp_due.items()):
            if self.k > last:
                self.brp_due.pop(sta)
            elif sta in self.tx_cfg and not self.queued(lambda m: getattr(m, 'kind_real', '') == 'BRP'
                                                         and m.dst == sta):
                self._enqueue_brp(sta)
        for sta in list(self.tx_cfg):
            if self.mlme.state(sta) in (M.S3, M.S4) and self.dl:
                if not self.queued(lambda m: getattr(m, 'kind_real', '') == 'Data' and m.dst == sta):
                    for _ in range(self.dl):
                        self.enqueue(_Msdu(sta, 'Data', QOS_HDR + DATA_PAYLOAD + P.FCS, 4))

    def _brp_frame(self, cap_req, initiator):
        return P.BrpFrame(req=P.BrpRequest(), bre=P.BeamRefinement(initiator=initiator, cap_req=cap_req))

    def _enqueue_brp(self, sta):
        fr = self._brp_frame(1, 1)
        t_brp = txtime_control(fr.length)
        # ответ STA и завершающий кадр setup — в том же TXOP (10.42.3.2, рис. 10-79)
        self.enqueue(_Msdu(sta, 'BRP', fr.length, 0, ack=False, extra=2 * SIFS + 2 * t_brp, brp=fr))

    def _out_frame(self, t, kind, f, msdu, fields):
        if kind == 'BRP' and msdu is not None:
            t_brp = txtime_control(f.length)
            dur1 = D.field(2 * SIFS + 2 * t_brp)           # 10.42.6.4.1: Duration — до конца TXOP setup
            self.brp_txn = dict(sta=f.dst, te1=t + t_brp, dur1=dur1)
            return fields, dur1
        if kind == 'BlockAck':
            ssn, bm = self.pending_ba.pop(f.dst, (0, 0))
            return dict(fields, ssn=ssn, bitmap=bm), None
        return fields, None

    # ---------------- приём ----------------
    def _rx(self, t, entry, frame, res):
        k, src = frame.kind, frame.src
        fl = frame.fields
        if k == 'SSW' and frame.dst == self.addr and self.plan is not None:
            s = self.plan.layout.slot_of(entry.t_start)
            if s is not None:
                self.ssw_rx.setdefault(s, []).append(A.AirFrame(
                    'SSW', entry.t_start, src, frame.dst, direction=fl['direction'], cdown=fl['cdown'],
                    sector_id=fl['sector_id'], ant_id=fl['ant_id'], sector_select=fl['sector_select'],
                    ant_select=fl['ant_select'], snr=fl['snr'], poll=fl.get('poll', 0), rx_snr=snr_of(res.power)))
            return
        if frame.dst != self.addr:
            return
        mk = 'Data' if k in C.DATA_KINDS else k
        try:
            decision, reply, reason = M.rx_filter(self.mlme.state(src), mk, frame.dst)
        except ValueError:
            decision, reply, reason = 'accept', None, None
        if decision != 'accept':
            # 11.3.5.1: класс 3 от STA в State 2 — отбросить и послать Disassociation (DMG, инфраструктура);
            # 11.3.4.1: класс 2/3 от State 1 — Deauthentication
            if reply is not None and src in self.tx_cfg and not self.queued(
                    lambda m: getattr(m, 'kind_real', '') == reply and m.dst == src):
                body = E.encode_body(reply, {'reason': reason})
                self.enqueue(_Msdu(src, reply, mpdu_len(len(body)), 1, body=body, reason=reason))
            return
        st = self.ati_state
        if k == 'Ack' and st and st['wait'] and st['wait']['sta'] == src:
            st['wait'] = None
            self.m.at(t + SIFS, lambda tt: self._ati_next(tt))   # 10.39.3: следующий запрос через SIFS
            return
        if k in (E.ASSOC_REQ, E.REASSOC_REQ):
            self._on_assoc_req(t, src, k, fl)
        elif k == 'ADDBA Request':
            req = BA.parse_addba_req(fl['body'])
            resp = BA.make_addba_response(req, buffer_size=64)
            self.recipients[src] = BA.Recipient(resp.params.buffer_size, req.ssn)
            body = BA.encode_addba_resp(resp)
            self.enqueue(_Msdu(src, 'ADDBA Response', mpdu_len(len(body)), 1, body=body))
        elif k == 'A-MPDU' and src in self.recipients:
            ba = self.recipients[src].on_ampdu([(sn, rt, (0, 0)) for sn, rt in fl['mpdus']])
            if ba is not None:
                self.pending_ba[src] = ba
            self.rx_msdus[src] = self.rx_base.get(src, 0) + len(self.recipients[src].delivered)
        elif k == 'Data':
            self.rx_data[src] = self.rx_data.get(src, 0) + 1
        elif k == 'BRP':
            x = self.brp_txn
            if x and x['sta'] == src and not fl['brp'].bre.cap_req:
                # 10.42.3.2: ответчик передал Capability Request = 0 → инициатор отвечает тоже 0 (конец setup)
                fr = self._brp_frame(0, 1)
                te3 = t + SIFS + txtime_control(fr.length)
                dur = P.brp_duration(te3, x['te1'] + x['dur1'])
                self._oob_at(t + SIFS, DmgFrame('BRP', self.addr, src, fr.length, 0, dur, dict(brp=fr)),
                             self.tx_cfg[src])
                self.brp_due.pop(src, None)
                self.brp_txn = None

    def _on_assoc_req(self, t, sta, kind, fl):
        if sta in self.mlme.pending_resp or sta not in self.tx_cfg:
            return                           # повтор запроса до Ack на ответ — уже отвечаем
        fx, _ = E.parse_body(kind, fl['body'])
        reassoc = kind == E.REASSOC_REQ
        status, aid, _ = self.mlme.on_assoc_req(sta, t, reassoc=reassoc, current_ap=fx.get('current_ap'))
        rk = E.REASSOC_RESP if reassoc else E.ASSOC_RESP
        body = E.encode_body(rk, {'capability': {'dmg_params': {'bss_type': 3}}, 'status': status, 'aid': aid or 0},
                             [self.dmg_capabilities(0, ap=True),
                              E.encode_dmg_operation(dict(tddti=0, pseudo_static=0, pcp_handover=0),
                                                     self.net.bss_cfg)])
        if status == E.SUCCESS and sta in self.recipients:
            # 11.3.5.3 k) / 11.3.5.5: сброс состояния (в т. ч. соглашений BA)
            self.rx_base[sta] = self.rx_msdus.get(sta, 0)
            self.recipients.pop(sta)
        self.enqueue(_Msdu(sta, rk, mpdu_len(len(body)), 1, body=body, status=status, aid=aid))

    def _delivered(self, t, m):
        if getattr(m, 'kind_real', None) in (E.ASSOC_RESP, E.REASSOC_RESP) and m.dst in self.mlme.pending_resp:
            self.mlme.on_resp_acked(m.dst, self.k)

    def _discarded(self, t, m):
        if getattr(m, 'kind_real', None) in (E.ASSOC_RESP, E.REASSOC_RESP):
            self.mlme.on_resp_abandoned(m.dst)

    def associated(self):
        return sorted(s for s in self.mlme.peers if self.mlme.state(s) in (M.S3, M.S4))


# Announce (9.6.21.2): заголовок управления + Category, Unprotected DMG Action, Timestamp 8, Beacon Interval 2 + FCS
LEN_ANNOUNCE = mpdu_len(1 + 1 + 8 + 2)


# ======================================================================================================
#                                             non-AP STA
# ======================================================================================================
class DmgSta(_Node):
    """Non-AP DMG STA. ul — A-MPDU в восходящем направлении за BI после установления Block Ack;
    assoc_timeout_tu — dot11AssociationResponseTimeout (TU, DEFVAL в MIB нет; уточняется AssocRespConfirmTime)."""
    def __init__(self, net, addr, sectors=4, seed=0, ul=2, assoc_timeout_tu=200, ssid=b'dmg-ref'):
        super().__init__(net, addr, ROLE_STA, sectors, seed)
        self.ul, self.ssid = ul, ssid
        self.mlme = M.StaMlme(addr, assoc_timeout_tu)
        self.state = 'scan'
        self.ap = None
        self.join = None
        self.monitor = None
        self.resp = A.Responder(addr, [(0, s) for s in self.sectors], rng=C.Rng(self.rng.randrange(1 << 30)))
        self.bti = {}                        # k → dict(best=(snr, sector), bic, end, layout)
        self.fb_slot = {}
        self.need_bf = True
        self.orig = None
        self.addba_req = None
        self.ba_wait = False
        self.brp_rx = None
        self.rx_msdus = 0
        self.events = []                     # (t, событие) — для тестов
        self.aid = None
        self.k_tick = None

    # ---------------- маяки, JOIN, контроль связи ----------------
    def _rx(self, t, entry, frame, res):
        k, fl = frame.kind, frame.fields
        if k == 'DMG Beacon':
            self._on_beacon(t, entry, frame, res)
        elif k == 'SSW-Feedback' and frame.src == self.ap:
            s = self._cur_layout_slot(entry.t_start)
            if s is not None:
                self.fb_slot[s] = A.AirFrame('SSW-Feedback', entry.t_start, frame.src, frame.dst,
                                             sector_select=fl['sector_select'], ant_select=fl['ant_select'],
                                             snr=fl['snr'])
        elif frame.src != self.ap or frame.dst != self.addr:
            return
        elif k == 'BRP' and fl['brp'].bre.cap_req:
            # 10.42.3.2: «Upon receiving a BRP PPDU with the Capability Request subfield set to 1, the responder shall
            # respond with a BRP PPDU»; ответ — через SIFS (≥ SIFS, ≤ BRPIFS, 10.42.3.1)
            fr = P.BrpFrame(req=P.BrpRequest(), bre=P.BeamRefinement(initiator=0, cap_req=0))
            te2 = t + SIFS + txtime_control(fr.length)
            dur = P.brp_duration(te2, t + frame.dur)
            self._oob_at(t + SIFS, DmgFrame('BRP', self.addr, frame.src, fr.length, 0, dur, dict(brp=fr)),
                         self.tx_cfg[self.ap])
        elif k in (E.ASSOC_RESP, E.REASSOC_RESP):
            self._on_assoc_resp(t, k, fl)
        elif k == E.DISASSOC:
            reason = E.parse_body(k, fl['body'])[0]['reason']
            if self.mlme.on_disassoc(self.ap, t, reason) == M.S2:
                # 11.3.5.7: State 2; повторная ассоциация — не раньше, чем разрешит can_request (2 с / исправление)
                self.events.append((t, 'disassociated'))
                self.state, self.orig, self.addba_req = 'assoc', None, None
                self.flush_queue()
        elif k == 'ADDBA Response' and self.addba_req is not None:
            resp = BA.parse_addba_resp(fl['body'])
            if BA.check_addba_response(self.addba_req, resp):
                self.orig = BA.Originator(BA.originator_win_size(self.addba_req.params.buffer_size,
                                                                 resp.params.buffer_size), self.addba_req.ssn)
                self.events.append((t, 'ba'))
        elif k == 'BlockAck' and self.orig is not None:
            self.orig.on_blockack(fl['ssn'], fl['bitmap'])
            self.ba_wait = False
        elif k == 'Data':
            self.rx_msdus += 1

    def _on_beacon(self, t, entry, frame, res):
        fl = frame.fields
        raw = fl.get('raw')
        if raw is None or (self.ap is not None and frame.src != self.ap):
            return
        bcn = F.parse_dmg_beacon(raw)
        if self.join is None:
            # 11.1.4.2.2 пассивное сканирование → выбор BSS → MLME-JOIN (11.1.4.5)
            self.join = M.Join(bcn.bssid, bcn.beacon_interval, join_failure_timeout=4, t0=t)
        if self.join.on_beacon(t, bcn.bssid, bcn.timestamp, bcn.beacon_interval) != 'SUCCESS':
            return
        if self.ap is None:
            self.ap, self.bi_tu = bcn.bssid, bcn.beacon_interval
            self.monitor = M.LinkMonitor(self.ap, self.bi_tu, t0=t)
            self.state = 'bf'
            self.events.append((t, 'join'))
            k0 = B.bi_index(t, self.bi_tu)
            self.m.at(tbtt(k0, self.bi_tu) + self.bi_tu * TU / 2, self._tick, k0)
        self.monitor.on_rx(t, 'DMG Beacon', bcn.bssid)
        if self.state == 'lost':
            self.state = 'bf'
            self.events.append((t, 'beacon_back'))
        k = B.bi_index(entry.t_start, self.bi_tu)
        snr = snr_of(res.power)
        b = self.bti.get(k)
        if b is None:
            b = self.bti[k] = self._bti_info(k, entry, bcn)
        if snr > b['best'][0]:
            b['best'] = (snr, bcn.ssw.sector_id, bcn.ssw.antenna_id)

    def _bti_info(self, k, entry, bcn):
        """Первый маяк BTI: конец BTI, A-BFT, окна CBAP по Extended Schedule."""
        te = entry.t_end
        # 10.42.5.1: конец BTI — «expiration of the value within the Duration field of the last DMG Beacon frame
        # received» (PLAN.md №5). СПОРНО: Duration округлён вверх до мкс (9.2.5.1), поэтому te + Duration любого,
        # кроме последнего, маяка позже настоящего конца до 1 мкс; STA уточняет конец по CDOWN — te + CDOWN ×
        # (TXTIME(маяка) + SBIFS) (10.42.2.2.2, маяки одной длины), если это согласуется с Duration.
        est = te + bcn.ssw.cdown * (entry.t_end - entry.t_start + SBIFS)
        end = est if D.field(est - te) == bcn.duration else te + bcn.duration
        bic = A.BeaconIntervalControl.decode(F.encode_bic(bcn.bic))
        info = dict(best=(Fr(-100), 0, 0), bic=bic, end=end, layout=None, bcn=bcn)
        if bcn.bic.next_abft == 0:
            info['layout'] = A.AbftLayout.from_bic(bic, end)
            self.m.at(info['layout'].start, self._abft_begin, k)
        for e in bcn.elements:
            if e[0] == E.EID_EXTENDED_SCHEDULE:
                for a in E.parse_extended_schedule(e[2]):
                    # 10.39.5: CBAP с широковещательным Source AID — доступ всех STA; иначе — участников
                    if E.ALLOC_IS_SP.get(a.ctrl['allocation_type']) is False and \
                            (a.src_aid == AID_BROADCAST or self.aid in (a.src_aid, a.dst_aid)):
                        for s, en in B.Allocation(B.CBAP, a.src_aid, a.dst_aid, a.start, a.block_duration,
                                                  a.num_blocks, a.block_period).blocks(entry.t_start):
                            self.add_window(s, en)
            elif e[0] == E.EID_DMG_OPERATION:
                _, cfg = E.parse_dmg_operation(e[2])
                if cfg.get('assoc_resp_confirm_time'):
                    self.mlme.adopt_assoc_resp_confirm_time(cfg['assoc_resp_confirm_time'])
        return info

    def _cur_layout_slot(self, t):
        for b in self.bti.values():
            L = b['layout']
            if L is not None and L.slot_of(t) is not None:
                return L.slot_of(t)
        return None

    def _tick(self, t, k):
        """Середина BI: контроль маяков (11.1.3.1), тайм-аут ассоциации, восходящий трафик."""
        self.m.at(tbtt(k + 1, self.bi_tu) + self.bi_tu * TU / 2, self._tick, k + 1)
        for kk in [x for x in self.bti if x < k - 2]:
            del self.bti[kk]
        if self.monitor is not None and self.monitor.lost(t) and self.state != 'lost':
            # 11.1.3.1: нет DMG Beacon dot11BeaconPeriod × dot11MaxLostBeacons; связь потеряна → снова BF в A-BFT и
            # (ре)ассоциация с тем же AP (11.3.5.4)
            self.state = 'lost'
            self.events.append((t, 'lost'))
            self.need_bf = True
            self.resp = A.Responder(self.addr, [(0, s) for s in self.sectors],
                                    rng=C.Rng(self.rng.randrange(1 << 30)))
            self.orig, self.addba_req, self.ba_wait = None, None, False
            self.flush_queue()
        if self.mlme.tick(t):
            self.events.append((t, 'assoc_timeout'))
        if self.state == 'assoc' and self.mlme.pending is None and self.mlme.can_request(self.ap, t)[0]:
            self._request_assoc()
        if self.state == 'associated' and self.orig is not None and self.ul:
            if len(self.queued(lambda m: m.agg)) < self.ul:
                for _ in range(self.ul):
                    self.orig.enqueue(MPDUS_PER_AMPDU)
                    self.enqueue(_Msdu(self.ap, 'A-MPDU', ampdu_len(MPDUS_PER_AMPDU), 4, agg=True))

    # ---------------- A-BFT (10.42.5.2) ----------------
    def _abft_begin(self, t, k):
        b = self.bti.get(k)
        if b is None or not self.need_bf or self.state not in ('bf',):
            return
        snr, sec, ant = b['best']
        beacon = A.BeaconRx(b['bic'], self.ap, received=True, bss_type=3, best=(sec, ant, snr))
        L = b['layout']
        if not self.resp.begin_abft(beacon, L):
            return
        self.cur_abft = (k, L)
        self.fb_slot = {}
        self._abft_slot(t, 0)

    def _abft_slot(self, t, s):
        k, L = self.cur_abft
        for f in self.resp.slot_tx(s):
            fb = F.SswFb(sector_select=f.sector_select, antenna_select=f.ant_select,
                         snr_report=F.snr_report_raw(f.snr), poll_required=f.poll)
            raw = F.encode_frame(F.SswFrame(duration=f.duration, ra=f.dst, ta=self.addr,
                                            ssw=F.Ssw(direction=f.direction, cdown=f.cdown, sector_id=f.sector_id,
                                                      antenna_id=f.ant_id), fb=fb), in_cbap=False)
            fr = DmgFrame('SSW', self.addr, f.dst, LEN_SSW, 0, f.duration,
                          dict(direction=f.direction, cdown=f.cdown, sector_id=f.sector_id, ant_id=f.ant_id,
                               sector_select=f.sector_select, ant_select=f.ant_select, snr=f.snr, poll=f.poll,
                               raw=raw))
            self._oob_at(f.t, fr, (f.ant_id, f.sector_id))
        self.m.at(L.slot_end(s), self._abft_slot_end, s)

    def _abft_slot_end(self, t, s):
        k, L = self.cur_abft
        fb = self.fb_slot.pop(s, None)
        self.resp.slot_end(s, fb)
        if fb is not None and fb.dst == self.addr and self.resp.fb is fb:
            self._bf_done(t, fb)
        if s + 1 < L.n_slots and self.resp.state in ('backoff', 'tx'):
            self._abft_slot(t, s + 1)
        elif s + 1 < L.n_slots:
            self.m.at(L.end, self._abft_end)
        else:
            self._abft_end(t)

    def _abft_end(self, t):
        self.resp.end_abft()

    def _bf_done(self, t, fb):
        """SSW-Feedback получен: Sector Select / DMG Antenna Select — лучший сектор передачи к AP (10.42.2.4)."""
        self.tx_cfg[self.ap] = (fb.ant_select, fb.sector_select)
        self.need_bf = False
        self.events.append((t, 'bf'))
        self.state = 'assoc'
        self._request_assoc()

    # ---------------- (ре)ассоциация (11.3.5.2 / 11.3.5.4) ----------------
    def _request_assoc(self):
        if self.queued(lambda m: getattr(m, 'kind_real', '') in (E.ASSOC_REQ, E.REASSOC_REQ)):
            return
        caps = self.dmg_capabilities(0)
        if self.mlme.state(self.ap) in (M.S3, M.S4):
            kind = E.REASSOC_REQ
            fixed = {'capability': {'dmg_params': {}}, 'listen_interval': 0, 'current_ap': self.ap}
        else:
            kind = E.ASSOC_REQ
            fixed = {'capability': {'dmg_params': {}}, 'listen_interval': 0}
        body = E.encode_body(kind, fixed, [E.encode_ssid(self.ssid), caps])
        self.enqueue(_Msdu(self.ap, kind, mpdu_len(len(body)), 1, body=body))

    def _out_frame(self, t, kind, f, msdu, fields):
        if kind in (E.ASSOC_REQ, E.REASSOC_REQ) and not msdu.info.get('_sent'):
            msdu.info['_sent'] = True
            try:
                if kind == E.REASSOC_REQ:
                    self.mlme.reassociate(self.ap, self.ap, t)
                else:
                    self.mlme.associate(self.ap, t)
            except M.Refused:
                pass
        if kind == 'A-MPDU' and self.orig is not None:
            if self.ba_wait:
                self.orig.on_blockack_lost()                 # 10.25.6.7: BlockAck потерян → повтор
            retry = {s for s, v in self.orig.state.items() if v == BA.RETRY}
            sns = self.orig.build_ampdu(MPDUS_PER_AMPDU)
            self.ba_wait = True
            return dict(fields, mpdus=[(s, s in retry) for s in sns]), None
        return fields, None

    def _on_assoc_resp(self, t, kind, fl):
        fx, els = E.parse_body(kind, fl['body'])
        cfg = None
        for e in els:
            if e.eid == E.EID_DMG_OPERATION:
                cfg = E.parse_dmg_operation(e.info)[1]
        st = self.mlme.on_assoc_resp(self.ap, t, fx['status'], dmg_op_cfg=cfg)
        if st in (M.S3, M.S4) and fx['status'] == E.SUCCESS:
            self.state, self.aid = 'associated', fx['aid']
            self.monitor.max_lost = self.mlme.mib.get('dot11MaxLostBeacons', DOT11_MAX_LOST_BEACONS)
            self.events.append((t, 'associated'))
            # 10.25.2: соглашение Block Ack (TID 0, HT-immediate, буфер 64)
            ssn = self.rng.randrange(BA.SN_MOD)
            self.addba_req = BA.AddbaReq(1 + self.rng.randrange(255), BA.BAParams(0, BA.BA_POLICY_IMMEDIATE, 0, 64),
                                         0, ssn)
            body = BA.encode_addba_req(self.addba_req)
            self.enqueue(_Msdu(self.ap, 'ADDBA Request', mpdu_len(len(body)), 1, body=body))


# ======================================================================================================
#                                               Сеть
# ======================================================================================================
class Network:
    """Генератор: AP и STA на medium.Medium, детерминированно от seed."""
    def __init__(self, seed=0, bi_tu=20, prop=0, capture_db=0, max_sta=8):
        self.m = _Air(prop=Fr(prop), capture_db=capture_db)
        self.rng = random.Random(seed)
        self.bi_tu, self.max_sta = bi_tu, max_sta
        self.nodes = {}
        self.ap = None
        self.started = False
        # 9.4.2.128, рис. 9-557: DMG BSS Parameter Configuration — значения из MIB DEFVAL (mlme.BSS_PARAM_TO_MIB)
        self.bss_cfg = dict(ps_request_suspension_interval=M.DOT11_PS_REQUEST_SUSPENSION_INTERVAL,
                            min_bhi_duration=int(M.DOT11_MIN_BHI_DURATION),
                            broadcast_sta_info_duration=M.DOT11_BROADCAST_STA_INFO_DURATION,
                            assoc_resp_confirm_time=10, min_pp_duration=M.DOT11_MIN_PP_DURATION,
                            sp_idle_timeout=M.DOT11_SP_IDLE_TIMEOUT, max_lost_beacons=DOT11_MAX_LOST_BEACONS)

    def _seed(self):
        return self.rng.randrange(1 << 30)

    def add_ap(self, addr, sectors=8, **kw):
        assert self.ap is None
        self.ap = DmgAp(self, addr, sectors, self._seed(), **kw)
        self.nodes[addr] = self.ap
        return self.ap

    def add_sta(self, addr, sectors=4, ap_sector=None, sta_sector=0, base_db=-50, sta_link_db=-50, **kw):
        sta = DmgSta(self, addr, sectors, self._seed(), **kw)
        others = [n for n in self.nodes.values() if n.role == ROLE_STA]
        self.nodes[addr] = sta
        if ap_sector is None:
            ap_sector = (len(others) + 1) % len(self.ap.sectors)
        self.link(self.ap.addr, addr, base_db, ap_sector, sta_sector)
        for o in others:
            # СПОРНО → выбор модели: судья cbap.check_air_log считает, что все STA слышат всех; STA одной BSS
            # связаны ровным усилением выше порога синхронизации SC (20.5.4.2.2)
            self.m.set_gain(addr, ANY, o.addr, ANY, sta_link_db, reciprocal=True)
        return sta

    def link(self, a, b, base_db, best_a, best_b, step_db=3, qo_loss_db=10):
        """Модель канала пары: усиление = base − штраф(a) − штраф(b); штраф сектора — step_db × круговое
        расстояние до лучшего, квази-омни — qo_loss_db (≤ 15 дБ, 20.9.1)."""
        na, nb = self.nodes[a], self.nodes[b]

        def pen(n, best, s):
            if s is None:
                return qo_loss_db
            d = abs(n.sectors.index(s) - n.sectors.index(best))
            return step_db * min(d, len(n.sectors) - d)
        for sa in [None] + na.sectors:
            for sb in [None] + nb.sectors:
                self.m.set_gain(a, (0, sa), b, (0, sb), base_db - pen(na, best_a, sa) - pen(nb, best_b, sb),
                                reciprocal=True)

    def block(self, a, b, t0, t1):
        """Затенение пары на [t0, t1) — нет приёма ни в одну сторону."""
        self.m.blocked.append((a, b, Fr(t0), Fr(t1)))

    def tbtt(self, k):
        return tbtt(k, self.bi_tu)

    def run_bis(self, n):
        """Моделировать до конца BI n − 1 (TBTT n не включается)."""
        if not self.started:
            self.started = True
            self.m.at(0, self.ap._tbtt, 0)
        self.m.run(self.tbtt(n) - Fr(1, 1000))

    def air_log(self):
        out = []
        for e in self.m.log:
            fl = {k: v for k, v in e.fields.items() if not k.startswith('_')}
            raw = fl.pop('raw', None)
            out.append(AirRec(e.t_start, e.t_end, e.src, e.dst, e.kind, e.dur, e.mcs, fl, raw, e.tx_cfg,
                              tuple(e.receivers), tuple(a for a, x in e.rx.items() if x.locked)))
        return out


# ======================================================================================================
#                                               Судья
# ======================================================================================================
# Пункт по (модуль, правило) — для нарушений без номера пункта в тексте; иначе номер берётся из сообщения.
CLAUSES = {
    'bi': dict(beacon_src='11.1.2.1', beacon_outside_bti='10.39.2', beacon_gap='10.42.2.2.2, 10.3.2.3.8',
               beacon_sector_dup='11.1.3.3.1', beacon_cdown='10.42.4, 10.42.2.2.2', beacon_dur='9.3.4.2',
               sector_coverage='11.1.2.1', bti_sta='10.39.2', bti_kind='10.42.4', abft_kind='10.42.5.2',
               abft_slot_start='10.42.5.2', abft_fss='10.42.5.2', abft_ss_end='10.42.5.2 (рис. 10-76)',
               abft_sbifs='10.3.2.3.8, 10.3.2.3.11', abft_fb_time='10.42.5.2', ati_sta='10.39.3',
               ati_resp_dst='10.39.3', ati_kind='10.39.3', ati_noack='10.39.3', no_period='10.39.4, 10.39.6.5',
               period_end='10.39.4, 10.39.5', sp_foreign='10.39.6.2', sp_pcp_inactive='10.39.6.2',
               cbap_member='10.39.5'),
    'abft': dict(kind='10.42.5.2', mcs='10.6.7.1', window='10.42.5.2', ssw_addr='10.42.5.2', direction='10.42.2.3.1',
                 ssw_start='10.42.5.2', ssw_late='10.42.5.2 (рис. 10-76)', fss='10.42.5.2',
                 gap='10.3.2.3.8, 10.3.2.3.11', cdown='10.42.2.3.2', resume='10.42.5.2', rxss_sector='10.42.2.3.3',
                 ant_order='10.42.2.3.2', ssw_dur='9.3.1.15', fb_src='10.42.5.2', fb_time='10.42.5.2',
                 fb_dur='9.3.1.16', fb_multi='10.42.5.2', fb_dst='10.42.5.2', fb_select='10.42.2.4',
                 fb_sector='10.42.2.4', poll_alloc='10.42.5.2', brp_cap='10.42.5.2', brp_alloc='10.42.5.3',
                 mcs0='10.42.5.2', sector='10.42.5.2'),
    'cbap': dict(busy='10.3.2.1', nav='10.3.2.4', aifs='10.23.2.4, 10.3.2.3.6', slot='10.23.2.4',
                 sifs='10.3.2.3.3', cts_nav='10.3.2.9', timeout='10.3.2.11, 10.3.2.9', txnav='10.23.2.8',
                 txop_limit='10.23.2.9', cbap_end='10.39.4, 10.39.5', cf_end='10.23.2.10', cf_end_dur='10.23.2.10',
                 collision='10.23.2.4'),
    'mlme': dict(class_tx='11.3.3', ap_initiates='11.3.5.1', open_system='12.3.3.1', aid_range='9.4.1.8',
                 aid_dup='9.4.1.8', holdoff='11.3.5.2 g)', port_blocked='11.3.1', missing_reply='11.3.5.1'),
    'brp': {'setup-start': '10.42.3.2', 'setup-order': '10.42.3.2', 'setup-end': '10.42.3.2', 'brpifs': '10.42.3.2',
            'frame': '9.5.4, 20.9.2.2.3', 'ampdu': '10.42.6.4.1', 'ack': '9.6.21.3', 'duration': '10.42.6.4.1',
            'alloc': '10.42.3.1', 'initiator': '10.42.6.4.1', 'gap': '10.3.2.3.9, 10.42.3.1',
            'no-response': '10.42.6.4.2, 10.42.3.1', 'retransmit': '10.42.6.4.1', 'owe-trn-t': '10.42.6.4.1'},
}
DEFAULT_CLAUSE = {'duration': '9.2.5', 'fields': '9.3.1/9.3.4.2', 'elements': '9.3.3, 9.4.2', 'sls': '10.42.2',
                  'blockack': '10.25.2', 'brp': '10.42.3', 'bi': '10.39', 'abft': '10.42.5', 'cbap': '10.23.2',
                  'mlme': '11.3'}


def _clause(module, rule, msg):
    c = CLAUSES.get(module, {}).get(rule)
    if c:
        return c
    import re
    hits = re.findall(r'(?:(?:табл|рис)\.\s*)?\d+\.\d+(?:\.\d+)*(?:\s?[a-z]\)(?:\s?\d+\))?)?', msg or '')
    return hits[-1] if hits else DEFAULT_CLAUSE.get(module, '')


def _rec(r):
    if isinstance(r, AirRec):
        return r
    return AirRec(*r)


def _bic_to_bi(b):
    """fields.Bic → bi.BeaconIntervalControl (адаптер: в bi/abft/fields — три представления рис. 9-77)."""
    return B.BeaconIntervalControl(cc_present=b.cc_present, discovery_mode=b.discovery, next_beacon=b.next_beacon,
                                   ati_present=b.ati_present, abft_length=b.abft_length, fss=b.fss,
                                   is_responder_txss=b.is_resp_txss, next_abft=b.next_abft,
                                   fragmented_txss=b.fragmented_txss, txss_span=b.txss_span,
                                   n_bis_abft=b.n_bis_abft, abft_count=b.abft_count, n_abft_in_ant=b.n_abft_in_ant,
                                   pcp_association_ready=b.pcp_assoc_ready)


def beacon_config(raw):
    """Байты DMG Beacon → (bi.BiConfig, fields.DmgBeacon). Extended Schedule → bi.Allocation (9.4.2.131), Next DMG ATI
    → ati_start/ati_duration (9.4.2.135)."""
    bcn = F.parse_dmg_beacon(raw)
    allocs, ati_start, ati_dur = [], None, 0
    for eid, ext, info in bcn.elements:
        if eid == E.EID_EXTENDED_SCHEDULE:
            for a in E.parse_extended_schedule(info):
                c = a.ctrl
                allocs.append(B.Allocation(B.SP if E.ALLOC_IS_SP.get(c['allocation_type']) else B.CBAP,
                                           a.src_aid, a.dst_aid, a.start, a.block_duration, a.num_blocks,
                                           a.block_period, alloc_id=c['allocation_id'],
                                           pseudo_static=c['pseudo_static'], truncatable=c['truncatable'],
                                           extendable=c['extendable'], pcp_active=c['pcp_active'],
                                           lp_sc=c['lp_sc_used']))
        elif eid == E.EID_NEXT_DMG_ATI:
            ati_start, ati_dur = E.parse_next_dmg_ati(info)
    p = bcn.params
    cfg = B.BiConfig(bic=_bic_to_bi(bcn.bic), params=B.DmgParameters(p.bss_type, p.cbap_only, p.cbap_source,
                                                                      p.privacy, p.ecapc),
                     allocations=allocs, ati_start=ati_start, ati_duration=ati_dur)
    return cfg, bcn


def _beacon_checks(raw, idx, add):
    """fields.check_mpdu (биты, табл. 9-45 — порядок элементов) + содержимое элементов маяка (elements)."""
    rx_ant = 1
    try:
        bcn = F.parse_dmg_beacon(raw)
    except F.FieldError as e:
        for msg in e.violations:
            add(idx, 'fields', 'beacon', msg)
        return
    for eid, ext, info in bcn.elements:
        try:
            if eid == E.EID_DMG_CAPABILITIES:
                c = E.parse_dmg_capabilities(info)
                rx_ant = E.rx_dmg_antennas(c.sta_cap)
                for msg in E.validate_dmg_capabilities(c, role=E.ROLE_AP):
                    add(idx, 'elements', 'dmg_capabilities', msg)
            elif eid == E.EID_DMG_OPERATION:
                for msg in E.validate_dmg_operation(*E.parse_dmg_operation(info)):
                    add(idx, 'elements', 'dmg_operation', msg)
            elif eid == E.EID_EXTENDED_SCHEDULE:
                role = E.ROLE_AP if bcn.params.bss_type == 3 else E.ROLE_PCP
                for msg in E.validate_extended_schedule(E.parse_extended_schedule(info), role):
                    add(idx, 'elements', 'extended_schedule', msg)
        except ValueError as ex:
            add(idx, 'elements', 'element', str(ex))
    role = {3: 'ap', 2: 'pcp'}.get(bcn.params.bss_type)
    for msg in F.check_mpdu(raw, role=role, pcp=role == 'pcp', rx_antennas=rx_ant):
        add(idx, 'fields', 'beacon', msg)


def _bti_ends(recs, order, ap, bi_tu):
    """Как bi.check_air_log: цепочка DMG Beacon AP от первого маяка BI, конец — конец последнего + его Duration."""
    out = {}
    by = {}
    for i in order:
        r = recs[i]
        if r.kind == 'DMG Beacon' and r.src == ap:
            by.setdefault(B.bi_index(r.t_start, bi_tu), []).append(i)
    for k, js in by.items():
        chain = [js[0]]
        for j in js[1:]:
            if recs[j].t_start - recs[chain[-1]].t_end <= B.LBIFS + B.LBIFS_TOL:
                chain.append(j)
            else:
                break
        last = recs[chain[-1]]
        out[k] = (last.t_end + (Fr(last.dur) if last.dur is not None else 0), chain)
    return out


def _response_of(recs, order, pos):
    """Индекс ответа (Ack/BlockAck/DMG CTS) на кадр order[pos]: следующий кадр от адресата к передатчику через
    SIFS … SIFS + SIFS_TOL (10.3.2.3.3)."""
    r = recs[order[pos]]
    for j in order[pos + 1:pos + 4]:
        q = recs[j]
        if q.t_start < r.t_end:
            continue
        if q.src == r.dst and q.dst == r.src and q.kind in CTRL_KINDS and \
                SIFS <= q.t_start - r.t_end <= SIFS + SIFS_TOL:
            return j
        break
    return None


def judge(log, ap=None, bi_tu=None, sectors='auto', configs=None, max_lost=DOT11_MAX_LOST_BEACONS, aids=None):
    """Проверка журнала эфира [AirRec] всеми применимыми судьями модулей. → [JViolation] по возрастанию idx.
    ap — MAC AP (по умолчанию — передатчик DMG Beacon); bi_tu — dot11BeaconPeriod (по умолчанию из маяка);
    sectors — сектора TXSS AP для bi ('auto' — все встреченные в журнале, None — не проверять покрытие);
    configs — {k: bi.BiConfig} поверх извлечённых из байтов маяков; aids — {MAC: AID} поверх извлечённых из
    (Re)Association Response."""
    recs = [_rec(r) for r in log]
    out = []

    def add(idx, module, rule, msg, clause=None):
        out.append(JViolation(idx, module, rule, clause or _clause(module, rule, msg), msg))

    order = sorted(range(len(recs)), key=lambda i: (Fr(recs[i].t_start), Fr(recs[i].t_end)))
    beacons = [i for i in order if recs[i].kind == 'DMG Beacon']
    if ap is None:
        srcs = [recs[i].src for i in beacons]
        ap = max(set(srcs), key=srcs.count) if srcs else None
    if ap is None:
        return out
    # ---- конфигурации BI из маяков ----
    cfgs, bcns = {}, {}
    for i in beacons:
        r = recs[i]
        if r.raw is None or r.src != ap:
            continue
        _beacon_checks(r.raw, i, add)
        try:
            cfg, bcn = beacon_config(r.raw)
        except (F.FieldError, ValueError):
            continue
        if bi_tu is None:
            bi_tu = bcn.beacon_interval
        k = B.bi_index(r.t_start, bi_tu)
        cfgs.setdefault(k, cfg)
        bcns.setdefault(k, bcn)
    if bi_tu is None:
        bi_tu = 100
    cfgs.update(configs or {})
    # ---- AID из (Re)Association Response ----
    aid_map = {}
    for i in order:
        r = recs[i]
        if r.kind in (E.ASSOC_RESP, E.REASSOC_RESP) and r.src == ap:
            aid = r.fields.get('aid')
            if aid is None and r.fields.get('body') is not None:
                try:
                    aid = E.parse_body(r.kind, r.fields['body'])[0]['aid']
                except ValueError:
                    aid = None
            if aid:
                aid_map[r.dst] = aid
    aid_map.update(aids or {})
    secs = None
    if sectors == 'auto':
        secs = {recs[i].fields.get('sector') for i in beacons if recs[i].src == ap} - {None}
    elif sectors is not None:
        secs = set(sectors)
    bss = B.Bss(ap, aid_map, bi_tu, configs=cfgs, sectors=secs or None, max_lost=max_lost)

    # ---- bi.check_air_log ----
    def info(r):
        f = r.fields or {}
        return dict(sector=f.get('sector', f.get('sector_id')), cdown=f.get('cdown'),
                    antenna=f.get('antenna', f.get('ant_id')))
    ev = [(r.t_start, r.t_end, r.src, r.dst, r.kind, r.dur, info(r)) for r in recs]
    for v in B.check_air_log(ev, bss):
        add(v.idx, 'bi', v.rule, v.msg)

    # ---- периоды BI ----
    btis = _bti_ends(recs, order, ap, bi_tu)
    lay = {}

    def layout_of(k):
        if k not in lay:
            lay[k] = B.layout(k, bi_tu, bss.cfg(k), btis[k][0] if k in btis else None)
        return lay[k]

    def period(r):
        return B.period_at(layout_of(B.bi_index(r.t_start, bi_tu)), r.t_start)

    per = {i: period(recs[i]) for i in order}

    # ---- A-BFT: abft.check_abft_log, обязанности точки ----
    obligations, last_k = [], max(B.bi_index(r.t_start, bi_tu) for r in recs) if recs else 0
    for k in sorted({B.bi_index(recs[i].t_start, bi_tu) for i in order}):
        pa = [p for p in layout_of(k) if p.kind == 'A-BFT']
        if not pa:
            continue
        bic = bss.cfg(k).bic
        L = A.AbftLayout(pa[0].start, bic.abft_slots, bic.fss_frames, bool(bic.is_responder_txss))
        idx = [i for i in order if per[i] is pa[0] or (pa[0].start <= recs[i].t_start < pa[0].end)]
        frames = []
        for i in idx:
            r = recs[i]
            f = r.fields or {}
            af = A.AirFrame(r.kind, r.t_start, r.src, r.dst, duration=r.dur)
            af.mcs = r.mcs
            for name in ('direction', 'cdown', 'sector_id', 'ant_id', 'sector_select', 'ant_select', 'snr', 'poll'):
                if name in f:
                    setattr(af, name, f[name])
            if r.kind == 'SSW-Feedback':
                af.tx_sector = tuple(r.tx_cfg) if r.tx_cfg is not None else None
            frames.append(af)
        for v in A.check_abft_log(frames, L, ap):
            add(idx[v.idx], 'abft', v.rule, v.msg)
        # 10.42.5.2: после SSW-Feedback — BRP с Capability Request = 1 через Sector Select ответчика
        for n, af in enumerate(frames):
            if af.kind == 'SSW-Feedback' and af.src == ap and k + aMinBTIPeriod - 1 <= last_k:
                s = L.slot_of(af.t)
                mine = [x for x in frames if x.kind == 'SSW' and x.src == af.dst and L.slot_of(x.t) == s]
                if mine:
                    obligations.append((idx[n], A.Obligation('brp_cap', af.dst, k, k + aMinBTIPeriod - 1,
                                                             (mine[0].ant_select, mine[0].sector_select))))
    if obligations:
        oev = []
        for i in order:
            r = recs[i]
            if r.src != ap:
                continue
            kb = B.bi_index(r.t_start, bi_tu)
            cfg = tuple(r.tx_cfg) if r.tx_cfg is not None else None
            brp = (r.fields or {}).get('brp')
            if r.kind == 'BRP' and getattr(brp, 'bre', None) is not None and brp.bre.cap_req:
                oev.append((kb, 'BRP-cap', r.dst, r.mcs, cfg))
            elif r.kind in ('Announce', 'Grant', 'Poll'):
                oev.append((kb, r.kind, r.dst, r.mcs, cfg))
        for v in A.check_obligations([o for _, o in obligations], oev):
            add(obligations[v.idx][0], 'abft', v.rule, v.msg)

    # ---- cbap.check_air_log: кадры CBAP; прочие — «вне EDCA» (занимают среду, доступ не проверяется) ----
    # СПОРНО → адаптер: cbap.check_air_log считает, что все STA слышат всех; в направленном эфире STA может
    # законно не заметить PPDU (пропущенная преамбула, уровень ниже порога ED, 20.4.4.2.2/20.5.4.2.2). Если журнал
    # знает, кто синхронизировался (AirRec.heard), доступ каждой STA проверяется по её собственной картине эфира:
    # свои кадры + услышанные; нарушения берутся только для её кадров.
    windows = sorted({(p.start, p.end) for k in list(lay) for p in lay[k] if p.kind == B.CBAP})
    unchecked = set(C.LogParams().unchecked)
    cev = []
    resp_like = set()
    for pos, i in enumerate(order):
        # кадр без Ack (BRP, Action No Ack) — ответ, если начат через ≤ BRPIFS после кадра пира (10.42.3.1); иначе
        # это новый доступ EDCA: для cbap — индивидуальный кадр без ответа (вид 'Action No Ack': cbap не ждёт Ack,
        # адресат не обновляет NAV, 10.3.2.4), TXNAV = его Duration (10.23.2.2)
        r = recs[i]
        if r.kind in NO_ACK_KINDS:
            prev = [j for j in order[:pos] if recs[j].t_end <= r.t_start]
            if prev:
                q = recs[max(prev, key=lambda j: recs[j].t_end)]
                if q.src == r.dst and q.dst == r.src and r.t_start - q.t_end <= BRPIFS:
                    resp_like.add(i)
    for i in range(len(recs)):
        r = recs[i]
        p = per[i]
        if p is not None and p.kind == B.CBAP:
            kk = engine_kind(r.kind)
            if r.kind in NO_ACK_KINDS:
                kk = r.kind if i in resp_like else 'Action No Ack'
            cev.append((r.t_start, r.t_end, r.src, r.dst, kk, r.dur or 0, p.end))
        else:
            kk = 'BHI:' + r.kind
            unchecked.add(kk)
            cev.append((r.t_start, r.t_end, r.src, r.dst, kk, r.dur or 0, None))
    lp = C.LogParams(aps={ap}, cbaps=windows or None, unchecked=tuple(unchecked))
    if all(r.heard is not None for r in recs):
        for x in sorted({r.src for r in recs}):
            view = [i for i, r in enumerate(recs) if r.src == x or x in r.heard]
            for v in C.check_air_log([cev[i] for i in view], lp):
                if recs[view[v.idx]].src == x:
                    add(view[v.idx], 'cbap', v.rule, v.msg)
    else:
        for v in C.check_air_log(cev, lp):
            add(v.idx, 'cbap', v.rule, v.msg)

    # ---- duration.check_duration ----
    for pos, i in enumerate(order):
        r = recs[i]
        p = per[i]
        if r.dur is None:
            continue
        kind, ctx = None, None
        if r.kind == 'DMG Beacon':
            k = B.bi_index(r.t_start, bi_tu)
            if k in btis and i in btis[k][1]:
                kind, ctx = 'dmg_beacon', {'bti_remaining': btis[k][0] - r.t_end}
        elif p is None:
            pass
        elif p.kind == 'A-BFT':
            bic = bss.cfg(B.bi_index(r.t_start, bi_tu)).bic
            L = A.AbftLayout(p.start, bic.abft_slots, bic.fss_frames)
            s = L.slot_of(r.t_start)
            if r.kind == 'SSW' and s is not None:
                kind, ctx = 'ssw', {'abft_slot_remaining': L.slot_end(s) - r.t_end}
            elif r.kind == 'SSW-Feedback':
                kind, ctx = 'ssw_fb', {'in_abft': True}
        elif p.kind == 'ATI':
            if r.src == ap and r.kind != 'Ack':
                kind, ctx = 'ati_request', {'ati_remaining': p.end - r.t_end}
            else:
                prev = [j for j in order[:pos] if recs[j].t_end <= r.t_start]
                if prev:
                    q = recs[max(prev, key=lambda j: recs[j].t_end)]
                    if q.dur is not None:
                        kind, ctx = 'ati_response', {'request_duration': q.dur, 'resp_txtime': r.t_end - r.t_start}
        elif p.kind == B.CBAP:
            prev = [j for j in order[:pos] if recs[j].t_end <= r.t_start]
            q = recs[max(prev, key=lambda j: recs[j].t_end)] if prev else None
            rem = {'alloc_remaining_seq': D.field(p.end - r.t_end)}
            if r.kind in ('Ack', 'BlockAck') and q is not None and q.dst == r.src and q.dur is not None:
                kind = 'ack' if r.kind == 'Ack' else 'ba'
                ctx = {'elicit_duration': q.dur, 'elicit_mcs': q.mcs, 'gap': r.t_start - q.t_end}
            elif r.kind in ('Data', 'A-MPDU') or r.kind in MGMT_ACKED:
                j = _response_of(recs, order, pos)
                if r.dst == BCAST:
                    kind, ctx = 'data' if r.kind in C.DATA_KINDS else 'mgmt', dict(rem)
                elif j is not None or r.kind in C.DATA_KINDS or r.kind in MGMT_ACKED:
                    rk = 'BlockAck' if r.kind == 'A-MPDU' else 'Ack'
                    rt = txtime(C.LEN[rk], C.resp_mcs(r.mcs))
                    kind = 'data' if r.kind in C.DATA_KINDS else 'mgmt'
                    ctx = dict(rem, resp_txtime=rt)
        if kind is not None:
            msg = D.check_duration(kind, r.dur, ctx)
            if msg:
                add(i, 'duration', kind, msg)

    # ---- fields.check_mpdu: байты SSW / SSW-Feedback / SSW-Ack ----
    for i in order:
        r = recs[i]
        if r.raw is None or r.kind == 'DMG Beacon':
            continue
        p = per[i]
        ctx = dict(sender_ap_pcp=r.src == ap)
        if r.kind == 'SSW':
            ctx['in_cbap'] = p is not None and p.kind == B.CBAP
        if r.kind == 'SSW-Feedback':
            ctx['abft'] = p is not None and p.kind == 'A-BFT'
        for msg in F.check_mpdu(r.raw, **ctx):
            add(i, 'fields', r.kind, msg)

    # ---- elements: тела кадров управления; blockack: ADDBA ----
    reqs = {}
    for pos, i in enumerate(order):
        r = recs[i]
        body = (r.fields or {}).get('body')
        if body is None:
            continue
        if r.kind in BODY_FRAMES:
            role = E.ROLE_AP if r.src == ap else E.ROLE_STA
            try:
                for msg in E.check_body(r.kind, body, role):
                    add(i, 'elements', r.kind, msg)
            except (ValueError, NotImplementedError) as ex:
                add(i, 'elements', r.kind, str(ex))
        elif r.kind == 'ADDBA Request':
            try:
                reqs[(r.src, r.dst)] = BA.parse_addba_req(body)
            except ValueError as ex:
                add(i, 'blockack', 'addba_req', str(ex))
        elif r.kind == 'ADDBA Response':
            try:
                resp = BA.parse_addba_resp(body)
                req = reqs.get((r.dst, r.src))
                if req is None:
                    add(i, 'blockack', 'addba_resp', 'ADDBA Response без ADDBA Request (10.25.2)')
                else:
                    BA.check_addba_response(req, resp)
            except ValueError as ex:
                add(i, 'blockack', 'addba_resp', str(ex))

    # ---- mlme.check_assoc_log ----
    # СПОРНО → адаптер: состояние пары у STA меняется по приёму (Re)Association Response (11.3.5.2 e)), у AP — по
    # Ack на него (11.3.5.3 n)); check_assoc_log ведёт одно состояние. Если журнал знает приёмников (receivers),
    # судья проходит дважды: «взгляд AP» (успех = AP принял Ack) — для кадров AP и его обязанности ответить
    # (missing_reply), «взгляд STA» (успех = STA приняла ответ) — для кадров STA.
    known = all(r.receivers is not None for r in recs)

    def mlme_events(view):
        mev, midx = [], []
        for pos, i in enumerate(order):
            r = recs[i]
            k = 'Data' if r.kind in C.DATA_KINDS else r.kind
            try:
                M.frame_class(k)
            except ValueError:
                continue
            inf = {}
            if r.kind in (E.ASSOC_RESP, E.REASSOC_RESP):
                body = (r.fields or {}).get('body')
                if body is not None:
                    fx = E.parse_body(r.kind, body)[0]
                    inf.update(status=fx['status'], aid=fx['aid'])
                else:
                    inf.update(status=r.fields.get('status', E.SUCCESS), aid=r.fields.get('aid'))
                j = _response_of(recs, order, pos)
                if view == 'sta':
                    inf['acked'] = r.dst in r.receivers
                elif view == 'ap':
                    inf['acked'] = j is not None and ap in recs[j].receivers
                else:
                    inf['acked'] = j is not None
            mev.append(M.LogEvent(r.t_start, k, r.src, r.dst, inf))
            midx.append(i)
        return mev, midx

    for view in (('ap', 'sta') if known else (None,)):
        mev, midx = mlme_events(view)
        for v in M.check_assoc_log(mev, ap):
            i = midx[v.idx]
            mine = v.rule == 'missing_reply' or recs[i].src == ap
            if view is None or (view == 'ap') == mine:
                add(i, 'mlme', v.rule, v.msg)

    # ---- brp: BRP setup (10.42.3.2) и журнал BRP пары ----
    pairs = {}
    for i in order:
        r = recs[i]
        if r.kind == 'BRP' and (r.fields or {}).get('brp') is not None:
            pairs.setdefault(frozenset((r.src, r.dst)), []).append(i)
    for js in pairs.values():
        seqs, cur = [], []
        for j in js:
            if cur and Fr(recs[j].t_start) - Fr(recs[cur[-1]].t_end) > BRPIFS + SIFS_TOL:
                seqs.append(cur)
                cur = []
            cur.append(j)
        if cur:
            seqs.append(cur)
        for sq in seqs:
            first = recs[sq[0]]
            setup = bool(first.fields['brp'].bre.cap_req)
            evs = [P.Ppdu(recs[j].t_start, recs[j].src, recs[j].dst, frame=recs[j].fields['brp'], mcs=recs[j].mcs,
                          length=None, dur=recs[j].dur, phase='setup' if setup else None) for j in sq]
            alloc_end = Fr(first.t_end) + first.dur if first.dur is not None else None
            # PPDU, не принятый адресатом (известно из receivers), — неудачная попытка: ответа не требуется
            for e, j in zip(evs, sq):
                e.lost = recs[j].receivers is not None and recs[j].dst not in recs[j].receivers
            if setup and not (len(sq) == 1 and evs[0].lost):
                vs, _ = P.check_setup(evs, first.src)
                for v in vs:
                    add(sq[v.idx], 'brp', v.rule, v.msg)
            for v in P.check_brp_log(evs, P.BrpParams(alloc_end=alloc_end)):
                add(sq[v.idx], 'brp', v.rule, v.msg)

    # ---- sls: SLS вне BTI/A-BFT (10.42.6.2) ----
    sls_frames = {}
    for i in order:
        r = recs[i]
        p = per[i]
        if r.kind in ('SSW', 'SSW-Feedback', 'SSW-Ack') and (p is None or p.kind not in ('BTI', 'A-BFT')):
            sls_frames.setdefault(frozenset((r.src, r.dst)), []).append(i)
    for js in sls_frames.values():
        frs = []
        for j in js:
            r = recs[j]
            f = r.fields or {}
            fb = {}
            if 'sector_select' in f:
                fb = {'sector': f.get('sector_select'), 'antenna': f.get('ant_select'), 'snr': f.get('snr'),
                      'poll': f.get('poll', 0)}
            frs.append(S.BfFrame(r.kind, r.src, r.dst, r.t_start, mcs=r.mcs, dur=r.dur, direction=f.get('direction'),
                                 cdown=f.get('cdown'), sector_id=f.get('sector_id'), antenna_id=f.get('ant_id'),
                                 fb=fb, tx=tuple(r.tx_cfg) if r.tx_cfg is not None else None))
        p = per[js[0]]
        ctx = {'access': S.CBAP if p is not None and p.kind == B.CBAP else S.SP}
        if p is not None:
            ctx['alloc_end'] = p.end
        for msg in S.check_sls_log(frs, ctx):
            add(js[0], 'sls', 'sls', msg)
    out.sort(key=lambda v: (v.idx, v.module, v.rule))
    return out


def rules(violations):
    """{(модуль, правило)} — для тестов."""
    return {(v.module, v.rule) for v in violations}
