# SPDX-License-Identifier: AGPL-3.0-or-later
"""Адаптер Sparrow (этап 3, rewrite/docs/ARCHITECTURE.md §2–3): исполняемое ядро DMG MAC (tests/ref/core) — узел эфира
air.Air наравне с узлами CoSim (fw + uc + модель MAC machw). Ядро работает через PHY-SAP (ref/core/sap_phy.py) и точки
разгрузки (ref/core/offload.py); функции из набора разгрузки Sparrow (offload.SPARROW) выполняет здесь модель MAC — с
теми же допущениями H-*, что у machw/air, и, где можно, тем же кодом.

    air = MixedAir(fw_nodes=[sta], cores=[ap])     # узлы CoSim и узлы ядра в одном эфире
    air.run_us(500)                                # все вперёд во времени (консервативная синхронизация, как air.Air)
    snapshot(air)                                  # снимок ref_bridge2 с узлами ядра (вход судей и сравнителя)

Устройство:
  CoreNode     — узел ядра: свои модельные часы (ref/core/sim.Sim, мкс TSF эмулятора: τ = TSF0 + такт/165, H-SYNC),
                 MAC ядра (DmgApMac/DmgStaMac с AdapterCaps('sparrow', offload.SPARROW)) и сторона PHY: PhySap для MAC
                 ядра + OffloadSap (offload.py) + модель MAC Sparrow для разгруженных точек.
  MixedAir     — air.Air, где у части узлов вместо CoSim — CoreNode: кадр ядра уходит в общий эфир тем же путём, что
                 кадр узла прошивки (Air._tx: буфер приёма uc, отчёт r36..r39, ответ через SIFS у узла прошивки, NAV
                 machw, кольцо fw), кадр узла прошивки (и другого ядра) — в PHY-SAP ядра.

Модель MAC в CoSim не отделяется от uc: machw.HW отвечает на команды uc (ответ через SIFS — по команде 0x37000020,
Duration — из записи 0x15/регистра лимита TXOP, отсрочка — событие r42 б18 для uc), её нельзя поставить под ядро без
микрокода. Поэтому здесь — минимальная обвязка с теми же допущениями и формулами (ссылки на метки H-* и на код, который
переиспользуется):
  ответ через SIFS (SIFS_RESPONSE + BA_SCOREBOARD) — когда отвечает MAC: RTS себе → DMG CTS, A-MPDU данных себе →
      BlockAck, одиночные данные (Ack Policy ≠ No Ack) и кадр управления (кроме Action No Ack) себе → Ack;
      групповой RA — без ответа (как air.Air._tx: uni). Кадр и Duration — air.Air._frame (H-RESPCMD: Ack Duration 0,
      DMG CTS и BlockAck — по Duration запроса; BlockAck — карта MPDU принятого A-MPDU, SSN — первый, H-AMPDU).
      Момент — конец PPDU + IFS (SIFS_CLK) + MACLAT_CLK (machw._hw_response, команда «в срок»: микрокода нет, ядро не
      опаздывает) + resp_cmd_delay_clk (по умолчанию 0; 230 — как у железа с микрокодом, 4,95 мкс, стенд H-RESPCMD),
      MCS — H-RESPMCS (SC → MCS 1, control → control), длительность — machw.ctrl_txtime_clk/sc_txtime_clk. DMG CTS —
      только при свободном NAV MAC или TA = держатель (10.3.2.9);
  Duration (DURATION) — RTS и кадры очереди (QoS Data, кадры управления с Ack): остаток лимита TXOP от начала TXOP −
      SIFS (H-DURQ, machw._dur_field: новый TXOP — на RTS или после конца прежнего); лимит — TXOP Limit AC_BE ядра (у
      железа — регистр HW_MAC_TXOP_LIMIT_0, его пишет uc по параметрам EDCA). Значение — в каждый MPDU (у железа MAC
      ставит его в заголовок каждого кадра очереди) и ядру (offload_duration);
  доступ (EDCA_BACKOFF) — арбитр очередей machw (H-BACKOFF, machw._backoff_kick/_backoff_fire): событие через
      max(сейчас, конец NAV, конец занятости) + AIFS_CLK + U[0, BACKOFF_CW] · SLOT_CLK; занятая среда в этот момент —
      отсрочка заново. AIFS одна для всех очередей (AC_BE), CW не удваивается (H-BACKOFF);
  NAV — NAV MAC (air.Air._tx/machw.air_rx): кадр не себе — max(NAV, конец + Duration), у DMG Beacon с A-BFT в этом BI —
      ещё A-BFT (H-NAVABFT, air.Air._nav_us). CF-End NAV не сбрасывает (как machw);
  Timestamp маяка (BEACON_TIMESTAMP) — TSF начала PPDU (H-BIC, air.Air._frame: tsf0_us + start // 165).
Прямые передачи ядра: PPDU начинается в такт PHY-TXSTART.request (вверх до такта). Задержки H-ORIGIN/H-ORIGIN-RX
(0,55/0,05 мкс от события GP / конца приёма) не добавляются: это отсчёт пуска uc от точки IFS, а момент передачи ядро
задаёт само (у железа его задавал бы микрокод под ядром — его нет); от этой точки — разность ≤ 0,55 мкс.

Канал — идеальный, как у air.Air: каждый кадр принимается всеми; SNR в RXVECTOR — постоянный (snr_db), направленности
нет (секторы ядра — только номера). Своё: полудуплекс и перекрытие двух PPDU у приёмника ядра (оба испорчены — как
ref/core/medium_ideal без захвата)."""
import heapq
import math
import random
from fractions import Fraction as Fr

import machw as MH
from air import (ACK_REP, AMPDU_REP, BA_REP, BCN_REP, CTS_REP, DATA_REP, FC_SSW, FC_SSW_ACK, FC_SSW_FB, QFRAME_REP,
                 RTS_REP, Air, ModelGapAir, qos_ack_policy, qos_tid, r38_group, rx_report)

from ref import cbap as C
from ref import fields as F
from ref.core import frames as FR
from ref.core import offload as O
from ref.core import sap_phy as P
from ref.core.sim import P_END, P_START, Sim

CLK = MH.CLK_PER_US
TSF0_US = 1_000_000                     # TSF в такт 0 — как machw.HW (tsf0_us по умолчанию), H-SYNC
SPARROW_CAPS = O.AdapterCaps('sparrow', O.SPARROW)
FC_RTS, FC_ACK, FC_BA, FC_CFEND, FC_CTS = 0x00b4, 0x00d4, 0x0094, 0x00e4, 0x0564
RESP_LEN = {'cts': 20, 'ack': 14, 'ba': MH.BA_LEN}      # PSDU ответа (как machw.air_rx resp_len)
SNR_DB = 25


def fc_of(f):
    return int.from_bytes(f[:2], 'little')


def ftype(f):
    return (f[0] >> 2) & 3


def subtype(f):
    return (f[0] >> 4) & 0xf


def is_beacon(f):
    return fc_of(f) & 0xff == 0x0c                       # Extension, подтип 0 — DMG Beacon (как air.Air)


def is_queue(f):
    """Кадр очереди MAC (у железа его собирает fw и выпускает арбитр очередей): данные и кадры управления, кроме Action
    No Ack (BRP — кадр FIFO микрокода, H-FIFO-MGMT)."""
    return ftype(f) == 2 or (ftype(f) == 0 and subtype(f) != 14)


def response_kind(mpdus, agg, me):
    """Ответ через SIFS, который собирает MAC (air.Air._tx: uni): 'cts' | 'ba' | 'ack' | None."""
    f = mpdus[0]
    if bytes(f[4:10]) != bytes(me) or f[4] & 1:
        return None
    if fc_of(f) == FC_RTS:
        return 'cts'
    if ftype(f) == 2:
        if agg:
            return 'ba'
        return None if qos_ack_policy(f) == 1 else 'ack'
    if ftype(f) == 0 and subtype(f) != 14:
        return 'ack'
    return None


class _RespSrc:
    """Узел-ответчик для air.Air._frame (поля, которые Air._tx ставит приёмнику кадра с ответом через SIFS)."""
    def __init__(self, mac, resp_ra, resp_kind, resp_dur, resp_ba=(0, 0, ())):
        self.mac, self.resp_ra, self.resp_kind, self.resp_dur, self.resp_ba = mac, resp_ra, resp_kind, resp_dur, \
            resp_ba


class _Arrival:
    __slots__ = ('t0', 't1', 'mpdus', 'agg', 'mcs', 'psdu', 'spoiled', 'locked', 'rxstart', 'trn')

    def __init__(self, t0, t1, mpdus, agg, mcs, trn=0):
        self.t0, self.t1, self.mpdus, self.agg, self.mcs, self.trn = t0, t1, mpdus, agg, mcs, trn
        self.psdu = FR.psdu(mpdus, agg)
        self.spoiled = self.locked = self.rxstart = False


class _HwView:
    """То, что air.Air и снимок ref_bridge2 читают у узла как у machw.HW."""
    def __init__(self, node):
        self.node = node
        self.tsf0_us = node.tsf0_us
        self.air_dur_log = {}
        self.collisions = []
        self.late = []

    @property
    def now(self):
        return self.node.clk(self.node.sim.now)

    def _bi_period_us(self):
        bi = self.node.core.bi_tu
        return (bi or 100) * 1024

    @property
    def tbtt_us(self):
        # TBTT ядра — TSF, кратный BI (11.1.3.3.1); у точки TSF ядра = TSF эмулятора (tsf_off 0)
        return self.tsf0_us - self.tsf0_us % self._bi_period_us() + self._bi_period_us()


class CoreNode:
    """Узел ядра в эфире Sparrow: MAC ядра + PHY-SAP + модель MAC для точек разгрузки (докстрока модуля)."""

    def __init__(self, mac_cls, addr, name, sectors, seed=0, caps=SPARROW_CAPS, snr_db=SNR_DB, tsf0_us=TSF0_US,
                 backoff_seed=1, t0_clk=0, **mac_kw):
        self.name, self.mac, self.tsf0_us, self.snr_db = name, bytes(addr), tsf0_us, snr_db
        self.peer_idx = {}
        self.sim = Sim()
        self.sim.now = Fr(tsf0_us) + Fr(t0_clk, CLK)
        self.off = caps.offload
        self.air = None
        # PHY
        self.txv, self._psdu = None, None
        self.tx = None                          # (начало, конец) своей передачи в тактах (вкл. ответ MAC)
        self.tx_hist = []
        self.arr, self.lock, self.cca = [], None, P.IDLE
        self.last_rx_end = self.last_tx_end = None
        # модель MAC Sparrow
        self.nav_end, self.nav_holder = 0, None   # NAV MAC (такты), держатель TXOP (TA последнего RTS/данных)
        self.busy_end = 0                         # конец последнего PPDU в эфире (свой или чужой) — для AIFS
        self.txopq_end = None                     # H-DURQ: конец TXOP по лимиту
        self.bo_ev = None
        self.bo_rng = random.Random(backoff_seed)
        # задержка команды ответа после точки IFS (такты): 0 — команда «в срок» (ответ в конец + IFS + MACLAT,
        # минимум железа, H-RESPCMD); у узлов прошивки команда uc приходит позже — ответы через 4,5–6,4 мкс
        self.resp_cmd_delay_clk = 0
        self.log = []                             # (такт, что) — разбор прогонов
        self.hw = _HwView(self)
        self.core = mac_cls(self.sim, F.mac_str(addr), sectors, seed=seed, caps=caps, name=name, **mac_kw)
        self.core.phy = self

    # ------------------------------------------------------------------ часы
    def clk(self, t):
        return (Fr(t) - self.tsf0_us) * CLK

    def tau(self, c):
        return Fr(self.tsf0_us) + Fr(c) / CLK

    def next_clk(self):
        q = self.sim._q
        while q and not q[0].live:
            heapq.heappop(q)
        # горизонт — такт вверх: часы machw целые (bound узла прошивки — такт), событие ядра внутри такта — на нём
        return math.ceil(self.clk(q[0].t)) if q else float('inf')

    def run_until(self, bound):
        """События ядра с тактом ≤ bound; стоп после передачи в эфир (MixedAir._rebound — горизонты пересчитать)."""
        q = self.sim._q
        while q:
            ev = q[0]
            if not ev.live:
                heapq.heappop(q)
                continue
            if self.clk(ev.t) > bound:
                break
            heapq.heappop(q)
            self.sim.now = ev.t
            ev.fn(*ev.args)
            if self.air._rebound:
                break

    # ------------------------------------------------------------------ PhySap (вызывает MAC ядра)
    def phy_config_request(self, vector):
        self.config = vector                    # канал идеальный: луч приёма не влияет

    def phy_txstart_request(self, txvector):
        assert self.tx is None or self.tx[1] <= self.clk(self.sim.now), f'{self.name}: передача поверх своей'
        self.txv, self._psdu = txvector, None
        self.core.phy_txstart_confirm(P.TxStatus())

    def phy_data_request(self, data):
        assert len(data) == self.txv.LENGTH
        self._psdu = bytes(data)
        self.core.phy_data_confirm()

    def phy_txend_request(self):
        self._transmit()

    def phy_ccareset_request(self, ipi_state=None):
        pass

    # ------------------------------------------------------------------ OffloadSap (вызывает MAC ядра)
    def offload_access_request(self):
        """H-BACKOFF (machw._backoff_kick): одно событие отсрочки на узел."""
        if self.bo_ev is not None:
            return
        now = self.clk(self.sim.now)
        t = max(now, self.nav_end, self.busy_end) + MH.AIFS_CLK + self.bo_rng.randint(0, MH.BACKOFF_CW) * MH.SLOT_CLK
        self.bo_ev = self.sim.at(self.tau(t), self._backoff_fire)

    def _backoff_fire(self):
        """machw._backoff_fire: среда занята (приём, своя передача, NAV, меньше AIFS от конца занятости) — заново."""
        self.bo_ev = None
        now = self.clk(self.sim.now)
        if self.lock is not None or self.arr or (self.tx is not None and self.tx[1] > now) or now < self.nav_end or \
                now < self.busy_end + MH.AIFS_CLK:
            self.offload_access_request()
            return
        self.log.append((now, 'backoff'))
        self.core.offload_access_granted()

    def offload_nav_busy(self, t):
        return self.tau(self.nav_end) > t

    def offload_nav_idle_from(self):
        return self.tau(self.nav_end)

    def offload_nav_idle_for_rts(self, t, ta):
        return not self.offload_nav_busy(t) or ta == self.nav_holder

    # ------------------------------------------------------------------ передача кадра ядра
    def _transmit(self):
        txv, agg = self.txv, self.txv.AGGREGATION == P.AGGREGATED
        mpdus = [m for m, _ in FR.split_psdu(self._psdu, agg)]
        now = self.clk(self.sim.now)
        start = math.ceil(now)
        dur = math.ceil(P.ppdu_time(txv) * CLK)
        f0 = mpdus[0]
        if self.off & O.Offload.DURATION and (fc_of(f0) == FC_RTS or is_queue(f0)):
            lim = int(self.core.txop_limit[C.AC_BE])
            if lim:
                # H-DURQ (machw._dur_field): остаток лимита TXOP от начала TXOP − SIFS
                if fc_of(f0) == FC_RTS or self.txopq_end is None or start >= self.txopq_end:
                    self.txopq_end = start - MH.SIFS_CLK + lim * CLK
                d = max(0, (self.txopq_end - (start + dur)) // CLK)
                mpdus = [m[:2] + d.to_bytes(2, 'little') + m[4:] for m in mpdus]
                self.core.offload_duration(d)
        if self.off & O.Offload.BEACON_TIMESTAMP and is_beacon(f0):
            tsf = self.tsf0_us + start // CLK  # H-BIC: TSF начала PPDU
            mpdus[0] = f0[:0xa] + tsf.to_bytes(8, 'little') + f0[0x12:]
        f0 = mpdus[0]
        kind = 'A-MPDU' if agg else FR.classify(f0).kind
        what = f'ядро {self.name}: {kind}'
        if self.off & (O.Offload.DURATION | O.Offload.EDCA_BACKOFF) and is_queue(f0):
            what = 'queue ' + what              # кадр очереди MAC (сравнитель: H-DURQ, H-BACKOFF)
        qf = None
        if is_queue(f0):
            qf = [bytes(m) for m in mpdus] if agg else bytes(f0)
        ssw = 0
        if fc_of(f0) == FC_SSW:
            ssw = int.from_bytes(f0[16:19], 'little')
        elif is_beacon(f0):
            ssw = int.from_bytes(f0[0x12:0x15], 'little')
        rec = dict(start=start, dur=dur, what=what, dur_us=int.from_bytes(f0[2:4], 'little'), fifo=None,
                   mpdu_len=None, ssw=ssw, bic=b'', qframe=qf, trn=txv.TRN_LEN, mcs=txv.MCS, rdg=False, rd_resp=False,
                   core_frame=(bytes(f0), self._report(f0, agg, txv.MCS, (ssw >> 1) & 0x1ff)))
        self._own_tx(start, dur)
        self.air._tx(self, rec)
        self.sim.at(self.tau(start + dur), self._tx_end, prio=P_END)

    def _own_tx(self, start, dur):
        self.tx = (start, start + dur)
        self.tx_hist.append(self.tx)
        del self.tx_hist[:-8]
        self.busy_end = max(self.busy_end, start + dur)

    def _tx_end(self):
        self.tx = None
        self.last_tx_end = self.clk(self.sim.now)
        self.core.phy_txend_confirm()

    def _report(self, f, agg, mcs, cdown):
        """Отчёт приёма r36..r39 у узла прошивки для кадра ядра — те же значения, что air.Air._frame даёт кадру того же
        вида от узла прошивки (стенд/имена полей — там)."""
        air, fc = self.air, fc_of(f)
        if agg:
            return lambda dst: {**AMPDU_REP, 38: AMPDU_REP[38] | air._r38(dst, self) | (mcs & 0x1f) << 20}
        if fc == FC_BA:
            return lambda dst: {**BA_REP, 38: BA_REP[38] | air._r38(dst, self) | (mcs & 0x1f) << 20}
        if fc == FC_ACK:
            return lambda dst: dict(ACK_REP)
        if fc == FC_CTS:
            return lambda dst: {**CTS_REP, 38: air._r38(dst, self)}
        if fc == FC_RTS:
            return lambda dst: {**RTS_REP, 38: air._r38(dst, self)}
        if fc == FC_CFEND:
            return lambda dst: {36: 0, 37: 1 << 16, 38: air._r38(dst, self), 39: 0x08000040}
        if is_beacon(f):
            return lambda dst: dict(BCN_REP)
        if fc in (FC_SSW, FC_SSW_FB, FC_SSW_ACK):
            return lambda dst: rx_report(fc, Air._idx(dst, self), cdown)
        if ftype(f) == 2:
            ack = (qos_ack_policy(f) or 0) << 16
            return lambda dst: {**DATA_REP, 38: air._r38(dst, self) | (mcs & 0x1f) << 20 | ack | r38_group(f[4:10])}
        if ftype(f) == 0:
            if subtype(f) == 14:
                return lambda dst: {**QFRAME_REP, 36: (1 << 25) | 0x04, 38: air._r38(dst, self)}
            # received_mcs r38 [24:20] — как у данных (H-RXREP-DATA, стенд): air.Air его кадрам управления не ставит —
            # у прошивки они всегда на control PHY (MCS 0), у ядра — на MCS 1
            return lambda dst: {**QFRAME_REP, 38: air._r38(dst, self) | r38_group(f[4:10]) | (mcs & 0x1f) << 20}
        raise ModelGapAir('эфир: отчёт приёма кадра ядра FC %#06x не моделируется' % fc)

    # ------------------------------------------------------------------ приём (вызывает MixedAir)
    def rx_ppdu(self, start, end, mpdus, agg, mcs, trn=0):
        """PPDU в эфире [start, end) тактов (с полями TRN, если trn > 0): приём — PHY-SAP ядра."""
        a = _Arrival(start, end, [bytes(m) for m in mpdus], agg, mcs, trn)
        self.sim.at(self.tau(start), self._arrive, a, prio=P_START)
        self.sim.at(self.tau(end), self._depart, a, prio=P_END)

    def _arrive(self, a):
        for b in self.arr:
            a.spoiled = b.spoiled = True        # перекрытие у приёмника: без захвата (как medium_ideal)
        self.arr.append(a)
        self.busy_end = max(self.busy_end, a.t1)
        now = self.clk(self.sim.now)
        if self.lock is None and not (self.tx is not None and self.tx[1] > now):
            a.locked = True
            self.lock = a
            self.sim.at(self.tau(a.t0) + P.rx_start_delay(a.mcs), self._rxstart, a, prio=P_START)
        self._cca()

    def _rxstart(self, a):
        if self.lock is not a or a.spoiled or self.clk(self.sim.now) >= a.t1:
            return
        a.rxstart = True
        self.core.phy_rxstart_indication(P.RxVector(MCS=a.mcs, LENGTH=len(a.psdu), AGGREGATION=P.AGGREGATED if a.agg
                                                    else P.NOT_AGGREGATED, TRN_LEN=a.trn,
                                                    PPDU_TYPE='TRN-R' if a.trn else None, RSSI=-40.0,
                                                    SNR=float(self.snr_db), RCPI=-40.0))

    def _depart(self, a):
        self.arr.remove(a)
        if self.lock is a:
            self.lock = None
            if a.rxstart:
                half = any(t0 < a.t1 and a.t0 < t1 for t0, t1 in self.tx_hist)
                self.last_rx_end = a.t1
                if half:
                    self.core.phy_rxend_indication(P.FORMAT_VIOLATION)
                else:
                    data = a.psdu if not a.spoiled else bytes(x ^ 0xA5 for x in a.psdu)
                    if not a.spoiled:
                        self._mac_rx(a)
                    self.core.phy_data_indication(data)
                    self.core.phy_rxend_indication(P.NO_ERROR)
        self._cca()

    def _cca(self):
        st = P.BUSY if (self.lock is not None or self.arr) else P.IDLE
        if st != self.cca:
            self.cca = st
            self.core.phy_cca_indication(st)

    # ------------------------------------------------------------------ модель MAC Sparrow: приём
    def _mac_rx(self, a):
        f0, me = a.mpdus[0], self.mac
        dur = int.from_bytes(f0[2:4], 'little')
        if self.off & O.Offload.NAV and bytes(f0[4:10]) != me:
            nav = Air._nav_us(f0, {'dur_us': dur})          # H-NAVABFT у маяка
            if a.t1 + nav * CLK > self.nav_end:
                self.nav_end = a.t1 + nav * CLK
                if fc_of(f0) == FC_RTS or ftype(f0) == 2:
                    self.nav_holder = F.mac_str(f0[10:16])
        if not self.off & O.Offload.SIFS_RESPONSE:
            return
        kind = response_kind(a.mpdus, a.agg, me)
        if kind == 'cts':
            ta = F.mac_str(f0[10:16])
            if not self.core.nav.idle_for_rts(self.tau(a.t1), ta):
                self.log.append((a.t1, 'RTS при занятом NAV — без DMG CTS'))
                return
        if kind is not None:
            self._respond(a, kind)
            self.core.offload_response_pending()

    def _respond(self, a, kind):
        """Ответ через SIFS, который собирает MAC (machw._hw_response, кадр — air.Air._frame)."""
        f0 = a.mpdus[0]
        m = MH.RESP_MCS_DEFAULT_SC if a.mcs else 0          # H-RESPMCS
        L = RESP_LEN[kind]
        dur = MH.sc_txtime_clk(L, m) if m else MH.ctrl_txtime_clk(L)
        start = a.t1 + MH.SIFS_CLK + MH.MACLAT_CLK + self.resp_cmd_delay_clk     # H-RESPCMD
        src = _RespSrc(self.mac, bytes(f0[10:16]), 'cts' if kind == 'cts' else 'ack', int.from_bytes(f0[2:4], 'little'))
        if kind == 'ba':
            sns = [int.from_bytes(x[22:24], 'little') >> 4 for x in a.mpdus]
            src.resp_ba = (qos_tid(f0) or 0, sns[0], sns)
            what = 'ответ на A-MPDU %d MPDU (ядро %s)' % (len(a.mpdus), self.name)
        else:
            what = 'ответ на %s (ядро %s)' % (FR.classify(f0).kind, self.name)
        frame, report = Air._frame(self.air, src, dict(what=what, ssw=0, mcs=m, qframe=None))
        rec = dict(start=start, dur=dur, what=what, dur_us=int.from_bytes(frame[2:4], 'little'), fifo=None,
                   mpdu_len=None, ssw=0, bic=b'', qframe=None, trn=0, mcs=m, rdg=False, rd_resp=False,
                   core_frame=(frame, report))
        self._own_tx(start, dur)
        self.air._tx(self, rec)
        name = {'cts': 'DMG CTS', 'ack': 'Ack', 'ba': 'BlockAck'}[kind]
        self.sim.at(self.tau(start), self.core.offload_tx_start, name, prio=P_START)
        self.sim.at(self.tau(start + dur), self._resp_end, prio=P_END)

    def _resp_end(self):
        self.tx = None
        self.last_tx_end = self.clk(self.sim.now)
        self.core.offload_tx_end()


class MixedAir(Air):
    """Эфир узлов CoSim и узлов ядра (CoreNode). Синхронизация — как air.Air (консервативная, без опережения):
    горизонт узла ядра — такт его следующего события; узел, передавший кадр, и узел ядра, получивший кадр, прерывают
    шаг (горизонты пересчитываются: ответ через SIFS не должен оказаться в прошлом получателя)."""

    def __init__(self, fw_nodes=(), cores=()):
        super().__init__(fw_nodes)
        self.cores = list(cores)
        self._rebound = False
        for c in self.cores:
            c.air = self

    def _frame(self, src, rec):
        cf = rec.get('core_frame')
        return cf if cf is not None else super()._frame(src, rec)

    def _tx(self, src, rec):
        n0 = len(self.frames)
        super()._tx(src, rec)
        if self.cores:
            self._rebound = True
        if len(self.frames) == n0 or self.frames[-1].get('dropped'):
            return
        fr = self.frames[-1]
        first = fr['frame']
        if fr['mpdus']:
            # Duration — в каждый MPDU A-MPDU (air.Air ставит его только в первый кадр журнала)
            mpdus = [first] + [m[:2] + first[2:4] + m[4:] for m in fr['mpdus'][1:]]
        else:
            mpdus = [first]
        for c in self.cores:
            if c is src:
                continue
            if c.tau(rec['start']) < c.sim.now:
                raise ModelGapAir('эфир: кадр %r начинается в %s, узел ядра %s уже в %s' % (
                    rec['what'], rec['start'], c.name, float(c.clk(c.sim.now))))
            c.rx_ppdu(rec['start'], rec['start'] + rec['dur'], mpdus, bool(fr['mpdus']), rec.get('mcs', 0) or 0,
                      rec.get('trn', 0) or 0)

    def run_us(self, us):
        nodes = self.nodes
        for n in nodes:
            if getattr(n, 'fw_tick0', None) is None:
                n._track_tx()
                n.to_uc()
            n.t_prev = n.hw.now
        clocks = [n.hw.now for n in nodes] + [c.clk(c.sim.now) for c in self.cores]
        end = max(clocks) + int(us * CLK)
        nf = len(nodes)
        while True:
            hz = [self._horizon(n) for n in nodes] + [c.next_clk() for c in self.cores]
            i = min(range(len(hz)), key=hz.__getitem__)
            if hz[i] >= end:
                break
            bound = min([end] + [h for j, h in enumerate(hz) if j != i])
            self._rebound = False
            if i >= nf:
                self.cores[i - nf].run_until(bound)
                continue
            n = nodes[i]
            if getattr(n, 'fw_tick0', None) is not None and n._next_fw is not None:
                bound = min(bound, max(n._next_fw, n.hw.now + 1))
            n.hw.bound = bound
            c = n.uc.cpu
            live = getattr(n, 'fw_tick0', None) is not None
            if not hasattr(n, '_assert_pc'):
                n._assert_pc = {n.uc.sym[k] & 0x1ffff for k in ('uc_assert',) if k in n.uc.sym}
            while True:
                if (c.pc & 0x1ffff) in n._assert_pc:
                    raise ModelGapAir('uc узла %s: uc_assert(%#x) из %s' % (
                        bytes(n.mac).hex() if hasattr(n, 'mac') else '?', c.regs[1], n.uc.where(c.regs[0])))
                n.t_prev = n.hw.now
                c.step()
                if live:
                    n.pump()
                if n.hw.now >= bound or (c.sleeping and c.irq_ready() is None) or self._rebound:
                    break
        for c in self.cores:
            # события ядра до end исполнены (горизонт каждого узла ≥ end) — часы ядра до end, как Sim.run(until)
            c.sim.now = max(c.sim.now, c.tau(end))
        for n in nodes:
            n.hw.bound = None
            if getattr(n, 'fw_tick0', None) is None:
                n.to_fw()
        return [n.hw.uc_events() for n in nodes]

    def clock_us(self):
        """Модельное время эфира, мкс от такта 0 (самые поздние часы узлов)."""
        cs = [n.hw.now for n in self.nodes] + [c.clk(c.sim.now) for c in self.cores]
        return max(cs) / CLK


def snapshot(air, t0_clk=0):
    """ref_bridge2.snapshot с узлами ядра (TSF0, TBTT, BI — как у machw.HW)."""
    import ref_bridge2 as RB
    s = RB.snapshot(air, t0_clk)
    for c in getattr(air, 'cores', ()):
        s['nodes'][c.mac] = dict(tsf0_us=c.hw.tsf0_us, tbtt_us=c.hw.tbtt_us, bi_us=c.hw._bi_period_us())
    return s
