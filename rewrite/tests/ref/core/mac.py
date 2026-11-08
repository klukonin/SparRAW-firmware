# SPDX-License-Identifier: AGPL-3.0-or-later
"""Общая часть DMG MAC ядра (точка и станция): сторона MAC интерфейса PHY-SAP, доступ EDCA в CBAP, NAV, последовательности
обмена (инициатор), немедленные ответы через SIFS, Block Ack (отправитель и получатель), MAC-SAP, кадры управления
с Ack, SLS в DTI (инициатор и ответчик), BRP setup (Capability Request).

Время — модельное (Fraction, мкс), решения — по событиям PHY-SAP. Сроки — ref/timing (SIFS, SBIFS, MBIFS, aSlotTime,
AIFS, TXTIME). Правила — пункты 802.11-2020 в комментариях; принятые трактовки — README.md ядра.

Доступ к среде (10.23.2.2–10.23.2.4, 10.3.7, 10.39.5):
  - EDCAF на AC_VO (кадры управления, 10.2.3.2: «category AC_VO shall be selected») и AC_BE (данные TID 0, табл.
    10-1); параметры — табл. 9-155 или EDCA Parameter Set точки;
  - среда свободна: PHY-CCA IDLE, нет своей передачи/приёма, нет своего обмена/ответа, NAV свободен, момент внутри
    CBAP; опорная точка отсчёта — max(конец физической занятости, конец NAV, начало CBAP); после приёма с ошибкой —
    EIFS − DIFS + AIFS (10.3.2.3.7);
  - границы слотов — опорная + AIFS[AC] + k·aSlotTime; на границе счётчик backoff уменьшается, при 0 — передача
    (10.23.2.4); занятость замораживает счётчик (уменьшения засчитываются за прошедшие границы);
  - внутренняя коллизия (10.23.2.3): одновременно готовые EDCAF — передаёт старшая AC, младшая — backoff как при
    неудаче;
  - вызов backoff (10.23.2.2): a) кадр в пустую очередь при занятой среде и счётчике 0; b) успешное завершение TXOP
    (CW = CWmin); c) неудача (нет ответа);
  - обмен начинается, только если вместе с ответами укладывается в остаток CBAP (10.39.5) и в лимит TXOP (10.23.2.9);
    EDCAF приостановлен вне CBAP, счётчик и NAV сохраняются до следующего CBAP (10.39.5)."""
from collections import deque
from fractions import Fraction as Fr
from math import ceil

from .. import blockack as BA
from .. import brp as BRP
from .. import cbap as C
from .. import duration as D
from .. import fields as F
from ..medium import SENSITIVITY_DBM
from ..timing import (aSlotTime, BCAST, BRPIFS, DIFS, MBIFS, SBIFS, SIFS, T_SSW, T_SSW_ACK, T_SSW_FB, txtime,
                      txtime_control)
from . import frames as FR
from . import sap_mac as MS
from . import sap_mlme as ML
from . import sap_phy as P
from .offload import AdapterCaps, Offload as OF, OffloadNav, require_supported
from .sim import P_MAC

SLOT = aSlotTime
AC_VO, AC_BE = C.AC_VO, C.AC_BE
AC_ORDER = (AC_VO, AC_BE)                     # убывание приоритета (табл. 10-1)
ACI = {C.AC_BE: 0, C.AC_BK: 1, C.AC_VI: 2, C.AC_VO: 3}
EIFS = C.EIFS
T_RTS = txtime_control(20)
T_CTS = C.T_DMG_CTS
T_CF_END = C.T_CF_END
T_ACK = txtime_control(14)
# 10.23.2.10: CF-End с Duration ≠ 0 — только при остатке ≥ 2×TCF-End + 2×SIFS. СПОРНО: остаток от начала CF-End
# (air_judge.r_nav_txop, cbap.check_air_log) или от его конца (unit/ref_bridge2.judge_duration); запас после ответа
# (BlockAck) — SIFS + CF-End + 2×TCF-End + 2×SIFS: выполняются оба прочтения.
CF_END_RESERVE = SIFS + T_CF_END + 2 * T_CF_END + 2 * SIFS
LEN = {'RTS': 20, 'DMG CTS': 20, 'CF-End': 20, 'Ack': 14, 'BlockAck': 32}
TID = 0
MSDU_MAX = 7920                               # табл. 9-19 (DMG): максимальная MSDU
LA_MARGIN_DB = 3                              # запас адаптации MCS (модель)
DOT11_SHORT_RETRY_LIMIT = C.DOT11_SHORT_RETRY_LIMIT
MAX_AMPDU_EXP = 5                             # DMG Capabilities: Maximum A-MPDU Length Exponent (табл. 9-251) — 2^18 − 1


def ampdu_limit(caps):
    """10.12.2: длина A-MPDU не больше 2^(13 + Maximum A-MPDU Length Exponent) − 1 из DMG Capabilities получателя
    (ref/ampdu.length_limit; 9.7.1 — не больше aPSDUMaxLength)."""
    from .. import ampdu as AMP
    return AMP.length_limit(caps)


def response_timeout(resp_mcs, gap=SIFS):
    """10.3.2.11 / 10.3.2.9: AckTimeout/CTSTimeout = aSIFSTime + aSlotTime + aRxPHYStartDelay (от
    PHY-TXEND.confirm); aRxPHYStartDelay — по модуляции ожидаемого ответа (табл. 20-30). Ответ через MBIFS (SSW-Ack,
    10.42.6.2) — СПОРНО → принято: тот же вид тайм-аута с MBIFS вместо aSIFSTime (стандарт срок ожидания SSW-Ack
    не задаёт; повтор SSW-Feedback — через PIFS после ожидаемого конца SSW-Ack)."""
    return gap + SLOT + P.response_wait(resp_mcs)


def la_mcs(snr_db, max_mcs=12):
    """Адаптация MCS (модель, стандарт не задаёт): наибольшая SC MCS 1…max, для которой SNR из RXVECTOR не меньше
    чувствительности табл. 20-3 относительно MCS 0 (−78 дБм ↔ SNR приёма control mode) плюс запас."""
    best = 1
    for m in range(1, max_mcs + 1):
        need = SENSITIVITY_DBM[str(m)] - SENSITIVITY_DBM['0'] + LA_MARGIN_DB - 2
        if snr_db is not None and snr_db >= need:
            best = m
    return best


# ===================================================================================================== шаги обмена
class Tx:
    """Шаг последовательности: передать PPDU. Момент — at (абсолютный) или gap после конца предыдущего события
    последовательности (своей передачи или принятого кадра); первый шаг — немедленно. expect(frames) — ожидаемый
    немедленный ответ (тайм-аут — response_timeout(resp_mcs)). trn — единиц TRN-R (BRP-RX PPDU, 20.9.2.2)."""
    __slots__ = ('mpdus', 'mcs', 'beam', 'gap', 'at', 'agg', 'expect', 'resp_mcs', 'what', 'build', 'resp_gap', 'trn')

    def __init__(self, mpdus, mcs, beam, gap=SIFS, at=None, agg=False, expect=None, resp_mcs=0, what='', build=None,
                 resp_gap=SIFS, trn=0):
        self.resp_gap, self.trn = resp_gap, trn
        self.mpdus, self.mcs, self.beam, self.gap, self.at, self.agg = mpdus, mcs, beam, gap, at, agg
        self.expect, self.resp_mcs, self.what, self.build = expect, resp_mcs, what, build


class Rx:
    """Шаг: ждать кадры match(frames) до until; collect — копить (до done(список)), иначе — первый; extend(список) —
    новый срок после каждого принятого (напр. ожидаемый конец свипа по CDOWN)."""
    __slots__ = ('match', 'until', 'collect', 'done', 'extend')

    def __init__(self, match, until, collect=False, done=None, extend=None):
        self.match, self.until, self.collect, self.done, self.extend = match, until, collect, done, extend


class Job:
    """Элемент очереди EDCAF: последовательность обмена. gen(mac, t) — генератор шагов; est(t) — длительность обмена
    с ответами (для проверки CBAP и лимита TXOP); done(ok) — итог."""
    def __init__(self, gen, est, done=None, ra=None, name='', queue=False):
        self.gen, self.est, self.done, self.ra, self.name = gen, est, done, ra, name
        self.retries = 0
        # работа очереди: кадр управления с Ack или TXOP данных (у железа — очереди MAC); при разгрузке EDCA_BACKOFF
        # доступ для неё выигрывает арбитр адаптера, для прочих (SLS, BRP setup) — EDCAF ядра
        self.queue = queue


class Peer:
    """Состояние MAC относительно пира: лучи, SNR, соглашения Block Ack, очередь MSDU, номера."""
    def __init__(self, addr):
        self.addr = addr
        self.tx_beam = None                   # Beam передачи к пиру (итог BF)
        self.snr = None                       # SNR последнего принятого от пира PPDU (RXVECTOR)
        self.sn = 0                           # следующий SN данных TID 0 (10.3.2.14.2: <Address 1, TID>)
        self.msdus = deque()                  # MSDU без соглашения: (sn, data, sa, da, retries)
        self.orig = None                      # (BA.Originator, {sn: (data, sa, da)}, AddbaReq)
        self.recip = None                     # BA.Recipient
        self.addba_wait = None                # AddbaReq, ждущий ответа
        self.max_mcs = 12
        self.max_ampdu = 8191                 # 10.12.2: до DMG Capabilities получателя — наименьший предел (exp 0)
        self.aid = None


class EdcaAc:
    def __init__(self, ac, params, rng):
        self.ac = ac
        self.ed = C.Edcaf(ac, params, rng)
        self.jobs = deque()


# ===================================================================================================== MAC
class DmgMac:
    """Общий DMG MAC. Подклассы: ap.DmgApMac, sta.DmgStaMac (кадры и процедуры роли)."""
    ROLE = None

    def __init__(self, sim, addr, sectors=8, seed=0, caps=AdapterCaps(), name=None):
        self.caps = require_supported(caps)
        self.off = caps.offload               # точки разгрузки (offload.py); IDEAL — всё делает ядро
        self.sim, self.addr, self.name = sim, addr, name or addr
        self.sectors = list(range(sectors)) if isinstance(sectors, int) else list(sectors)
        import random
        self.rng = random.Random(seed)
        self._phy = None
        self._off_resp = False                # SIFS_RESPONSE: адаптер назначил ответ и ещё не закончил его
        self.sme = None                       # MlmeSapUser + MacSapUser
        self.tsf_off = Fr(0)                  # TSF = модельное время + tsf_off
        self.bssid = None
        self.bi_tu = None
        self.ssid = b''
        # среда
        self.tx_on = self.rx_on = False
        self.cca = P.IDLE
        self.phys_idle_since = Fr(0)
        self.eifs = False
        self.nav = C.Nav(addr)
        self.txnav_end = Fr(0)                # 10.23.2.2: TXNAV — Duration последнего переданного держателем кадра
        self.cbap = None                      # (start, end) текущего CBAP в модельном времени
        self.cbap_margin = Fr(0)
        self._cbap_prev_end = None
        self._idle_ref = None
        self._acc_ev = None
        self._nav_ev = None
        params = dict(C.DEFAULT_EDCA)
        self.acs = {ac: EdcaAc(ac, params[ac], C.Rng(self.rng.randrange(1 << 30))) for ac in AC_ORDER}
        self.txop_limit = {AC_VO: Fr(0), AC_BE: Fr(0)}
        # обмен
        self.seq = None
        self._resp_ev = None
        self._last_tx_dur = None
        self._tx_cb = None
        self._rxv = None
        self._rx_data = None
        self._rx_t0 = None
        self.peers = {}
        self.mgmt_sn = 0
        # MCS кадров управления с Ack (выбор реализации: MCS 1 — обязательный SC, табл. 20-3; 0 — control mode)
        self.mgmt_mcs = 1
        self.rx_beam = P.QUASI_OMNI
        self._dup = {}
        self.events = []                      # (t, событие) — для тестов и отчётов
        self.counters = dict(tx_ppdu=0, rx_ok=0, rx_err=0, collisions_seen=0)

    # ------------------------------------------------------------------ служебное
    @property
    def phy(self):
        return self._phy

    @phy.setter
    def phy(self, phy):
        """PHY-SAP узла; при разгрузке NAV — NAV адаптера (offload.OffloadNav) вместо своего."""
        self._phy = phy
        if phy is not None and self.off & OF.NAV:
            self.nav = OffloadNav(phy)

    def peer(self, addr):
        p = self.peers.get(addr)
        if p is None:
            p = self.peers[addr] = Peer(addr)
        return p

    def tsf(self, t=None):
        return (self.sim.now if t is None else t) + self.tsf_off

    def t_of_tsf(self, tsf):
        return Fr(tsf) - self.tsf_off

    def log(self, what, **kw):
        self.events.append((self.sim.now, what, kw))

    def _beam_to(self, addr):
        p = self.peers.get(addr)
        return p.tx_beam if p is not None and p.tx_beam is not None else P.QUASI_OMNI

    def set_rx_beam(self, beam):
        if beam != self.rx_beam:
            self.rx_beam = beam
            self.phy.phy_config_request(P.PhyConfigVector(RX_ANT_CONFIG=beam))

    def next_mgmt_sn(self):
        sn = self.mgmt_sn
        self.mgmt_sn = (self.mgmt_sn + 1) % BA.SN_MOD
        return sn

    # ------------------------------------------------------------------ PHY-SAP: сторона MAC
    def phy_txstart_confirm(self, txstatus):
        pass

    def phy_data_confirm(self):
        pass

    def phy_txend_confirm(self):
        self.tx_on = False
        if self.cca == P.IDLE and not self.rx_on:
            self.phys_idle_since = self.sim.now
        cb, self._tx_cb = self._tx_cb, None
        if cb is not None:
            cb()
        self._medium_changed()

    def phy_cca_indication(self, state, channel_list=None):
        self.cca = state
        if state == P.IDLE and not self.tx_on and not self.rx_on:
            self.phys_idle_since = self.sim.now
        self._medium_changed()

    def phy_rxstart_indication(self, rxvector):
        self.rx_on = True
        self._rxv = rxvector
        self._rx_data = None
        self._rx_t0 = self.sim.now - P.rx_start_delay(rxvector.MCS)
        self.nav.rx_start(self.sim.now)
        self._medium_changed()

    def phy_data_indication(self, data):
        self._rx_data = data

    def phy_rxend_indication(self, rxerror):
        self.rx_on = False
        if self.cca == P.IDLE and not self.tx_on:
            self.phys_idle_since = self.sim.now
        data, rxv, t0 = self._rx_data, self._rxv, self._rx_t0
        self._rx_data = None
        good = []
        if rxerror == P.NO_ERROR and data is not None:
            good = [m for m, ok in FR.split_psdu(data, rxv.AGGREGATION == P.AGGREGATED) if ok]
        if not good:
            self.eifs = True                  # 10.3.2.3.7: EIFS после приёма с ошибкой
            self.counters['rx_err'] += 1
            self._seq_rx_failed()
            self._medium_changed()
            return
        self.eifs = False
        self.counters['rx_ok'] += 1
        frames = [FR.classify(m) for m in good]
        f0 = frames[0]
        self._nav_update(f0)
        if f0.ta is not None and f0.ta in self.peers:
            self.peers[f0.ta].snr = rxv.SNR
        self._dispatch(frames, rxv, t0)
        self._medium_changed()

    # ------------------------------------------------------------------ передача
    def _phy_tx(self, mpdus, mcs, beam, agg=False, on_end=None, trn=0):
        assert not self.tx_on, f'{self.name}: передача поверх своей передачи'
        psdu = FR.psdu(mpdus, agg)
        self._last_tx_dur = int.from_bytes(mpdus[0][2:4], 'little')
        # trn — BRP-RX PPDU (20.9.2.2): TRN_LEN единиц TRN-R (10.42.6.4.1)
        txv = P.TxVector(MCS=mcs, LENGTH=len(psdu), AGGREGATION=P.AGGREGATED if agg else P.NOT_AGGREGATED,
                         ANT_CONFIG=beam, TRN_LEN=trn, PPDU_TYPE=BRP.TRN_R if trn else None)
        self.tx_on = True
        self._tx_cb = on_end
        self.counters['tx_ppdu'] += 1
        self._medium_changed()
        self.phy.phy_txstart_request(txv)
        self.phy.phy_data_request(psdu)
        self.phy.phy_txend_request()
        return self.sim.now + P.ppdu_time(txv)

    # ------------------------------------------------------------------ NAV (10.3.2.4, 10.23.2.10)
    def _nav_update(self, f):
        if not self.in_cbap():
            return                            # 10.39.5: вне CBAP NAV не меняется (до начала следующего CBAP)
        kind = {'QoS Data': 'Data'}.get(f.kind, f.kind)
        if f.fc.type == F.TYPE_MGMT:
            kind = 'Data'
        before = self.nav.idle_from()
        self.nav.rx(self.sim.now, C.Frame(kind, f.ta, f.ra if f.ra is not None else BCAST, dur=f.dur))
        if self.nav.idle_from() != before:
            self._arm_nav_timer()

    def _arm_nav_timer(self):
        if self._nav_ev is not None:
            self._nav_ev.cancel()
            self._nav_ev = None
        t = self.nav.idle_from()
        if t > self.sim.now:
            self._nav_ev = self.sim.at(t, self._medium_changed)

    # ------------------------------------------------------------------ CBAP (10.39.5)
    def set_cbap(self, s, e, margin=0):
        """Окно CBAP [s, e) в модельном времени: EDCAF работает только внутри (10.39.5). margin — запас к концу при
        проверке «обмен укладывается в CBAP» (STA: неточность своего TSF)."""
        self.cbap_margin = Fr(margin)
        if self.cbap is not None and self.cbap[1] > self.sim.now:
            return
        if self._cbap_prev_end is not None:
            self.nav.shift(self._cbap_prev_end, Fr(s))   # 10.39.5: NAV не меняется между CBAP
            self._arm_nav_timer()
        self.cbap = (Fr(s), Fr(e))
        self._cbap_prev_end = Fr(e)
        self.sim.at(max(Fr(s), self.sim.now), self._medium_changed)
        self.sim.at(Fr(e), self._medium_changed)

    def in_cbap(self, t=None):
        t = self.sim.now if t is None else t
        return self.cbap is not None and self.cbap[0] <= t < self.cbap[1]

    # ------------------------------------------------------------------ EDCA (10.23.2)
    def _aifs(self, ac):
        a = C.aifs(self.acs[ac].ed.p.aifsn)
        if self.eifs:
            a += EIFS - DIFS
        return a

    def _idle_now(self):
        now = self.sim.now
        # 10.23.2.2 a) 4): среда занята и при ненулевом TXNAV (держатель TXOP)
        return (not self.tx_on and not self.rx_on and self.cca == P.IDLE and self.seq is None and
                self._resp_ev is None and not self._off_resp and not self.nav.busy(now) and self.txnav_end <= now and
                self.in_cbap(now))

    def _ref(self):
        r = self.phys_idle_since
        ne = self.nav.idle_from()
        if ne <= self.sim.now:
            r = max(r, ne)
        return max(r, self.txnav_end, self.cbap[0])

    def _medium_changed(self):
        idle = self._idle_now()
        if idle and self._idle_ref is None:
            self._idle_ref = self._ref()
            self._kick()
        elif not idle and self._idle_ref is not None:
            self._freeze(self.sim.now)
            self._idle_ref = None
            if self._acc_ev is not None:
                self._acc_ev.cancel()
                self._acc_ev = None
        elif idle:
            self._kick()
        if not idle and self.nav.busy(self.sim.now):
            self._arm_nav_timer()
        if not idle and self.txnav_end > self.sim.now:
            self.sim.at(self.txnav_end, self._medium_changed)
        if self.off & OF.EDCA_BACKOFF:
            self._offload_kick()

    def _freeze(self, tb):
        """Занятость с tb: засчитать уменьшения счётчика за границы слотов до tb (10.23.2.4)."""
        for ac, x in self.acs.items():
            if x.ed.backoff > 0:
                b0 = self._idle_ref + self._aifs(ac)
                nb = ceil((tb - b0) / SLOT) if tb > b0 else 0
                x.ed.backoff = max(0, x.ed.backoff - nb)

    def _job_for(self, ac):
        x = self.acs[ac]
        if ac == AC_BE:
            j = self._data_job()
            return j
        return x.jobs[0] if x.jobs else None

    def _kick(self):
        if self._acc_ev is not None:
            self._acc_ev.cancel()
            self._acc_ev = None
        if not self._idle_now():
            return
        now = self.sim.now
        best = None
        for ac in AC_ORDER:
            job = self._job_for(ac)
            if job is None or self._arbiter_job(job):
                continue                      # работа очереди при разгрузке EDCA_BACKOFF — у арбитра адаптера
            b0 = self._idle_ref + self._aifs(ac)
            t = b0 + self.acs[ac].ed.backoff * SLOT
            if t < now:
                t = b0 + ceil((now - b0) / SLOT) * SLOT
            if t + job.est(t) > self.cbap[1] - self.cbap_margin:
                continue                      # 10.39.5: обмен не укладывается в остаток CBAP
            if best is None or t < best[0]:
                best = (t, ac, job)
        if best is not None:
            self._acc_ev = self.sim.at(best[0], self._acc_fire, best[1], best[2])

    def _acc_fire(self, ac, job):
        self._acc_ev = None
        if not self._idle_now():
            return
        now = self.sim.now
        self._freeze(now)
        # 10.23.2.3: внутренняя коллизия — младшие AC, готовые в тот же момент, — backoff как при неудаче
        for other in AC_ORDER:
            if other == ac or self._job_for(other) is None or self._arbiter_job(self._job_for(other)):
                continue
            if self.acs[other].ed.backoff == 0 and C.aifs(self.acs[other].ed.p.aifsn) <= now - self._idle_ref:
                self.acs[other].ed.invoke_backoff('e')
        self._idle_ref = None
        self.acs[ac].ed.backoff = 0
        self._seq_start(job.gen(self, now), job=job, ac=ac)

    def _enqueue(self, ac, job=None):
        """Новая работа в EDCAF; 10.23.2.2 a) — кадр в пустую очередь при занятой среде и счётчике 0 → backoff."""
        x = self.acs[ac]
        was = self._job_for(ac) is not None
        if job is not None:
            x.jobs.append(job)
        head = self._job_for(ac)
        if not was and x.ed.backoff == 0 and not self._idle_now() and self.seq is None and \
                not (head is not None and self._arbiter_job(head)):
            x.ed.invoke_backoff('a')
        self._medium_changed()

    def _txop_done(self, ac, ok):
        """10.23.2.2: b) успешное завершение TXOP — CW = CWmin и новый счётчик; c) неудача — удвоение CW."""
        self.acs[ac].ed.invoke_backoff('b' if ok else 'c')

    # ------------------------------------------------------------------ разгрузка EDCA_BACKOFF (offload.py)
    def _arbiter_job(self, job):
        """Доступ для работы выигрывает арбитр адаптера (EDCA_BACKOFF разгружена, работа очереди)."""
        return bool(self.off & OF.EDCA_BACKOFF) and job.queue

    def _own_idle(self):
        """Ядро готово начать обмен со своей стороны: не передаёт, не принимает, нет своей последовательности и
        назначенного ответа, момент внутри CBAP (10.39.5). Среду, NAV и отсрочку проверяет арбитр адаптера."""
        return (not self.tx_on and not self.rx_on and self.seq is None and self._resp_ev is None and
                not self._off_resp and self.in_cbap())

    def _arbiter_pick(self):
        """Работа очереди старшей AC (10.23.2.3), укладывающаяся с ответами в остаток CBAP с этого момента (10.39.5)."""
        now = self.sim.now
        for ac in AC_ORDER:
            job = self._job_for(ac)
            if job is not None and self._arbiter_job(job) and now + job.est(now) <= self.cbap[1] - self.cbap_margin:
                return ac, job
        return None

    def _offload_kick(self):
        if self._own_idle() and self._arbiter_pick() is not None:
            self.phy.offload_access_request()

    def offload_access_granted(self):
        """Арбитр адаптера выиграл доступ (у железа — backoff_event очереди MAC): начать обмен, если готовы."""
        if not self._own_idle():
            return
        pick = self._arbiter_pick()
        if pick is None:
            return
        ac, job = pick
        self.log('offload_access', ac=ac, job=job.name)
        self._seq_start(job.gen(self, self.sim.now), job=job, ac=ac)

    # ------------------------------------------------------------------ разгрузка SIFS_RESPONSE / DURATION
    def offload_response_pending(self):
        """Адаптер назначил немедленный ответ через SIFS на принятый кадр: среду своей стороной не занимать."""
        self._off_resp = True
        self._medium_changed()

    def offload_tx_start(self, kind):
        """Ответ адаптера в эфире (полудуплекс): своя передача и приём невозможны до offload_tx_end."""
        self.tx_on = True
        self.counters['tx_ppdu'] += 1
        self.log('offload_response', kind=kind)
        self._medium_changed()

    def offload_tx_end(self):
        self.tx_on = False
        self._off_resp = False
        if self.cca == P.IDLE and not self.rx_on:
            self.phys_idle_since = self.sim.now
        self._medium_changed()

    def offload_duration(self, value):
        """Duration, которое поставил адаптер в переданный кадр (RTS, кадр очереди): основа TXNAV (10.23.2.2) и конца
        NAV держателя TXOP."""
        self._last_tx_dur = int(value)

    # ------------------------------------------------------------------ последовательности обмена
    def _seq_start(self, gen, job=None, ac=None):
        assert self.seq is None
        self.seq = dict(gen=gen, job=job, ac=ac, ref=self.sim.now, wait=None, timer=None, coll=None, started=False,
                        late=False)
        self._seq_step(None)

    def _seq_step(self, value):
        s = self.seq
        try:
            step = s['gen'].send(value)
        except StopIteration as e:
            self.seq = None
            self._seq_finished(s, e.value)
            self._medium_changed()
            return
        if isinstance(step, Tx):
            t = step.at if step.at is not None else (s['ref'] + step.gap if s['started'] else self.sim.now)
            s['started'] = True
            if t <= self.sim.now:
                self._seq_tx(step)
            else:
                s['timer'] = self.sim.at(t, self._seq_tx, step)
        else:
            s['wait'], s['coll'] = step, []
            s['timer'] = self.sim.at(max(step.until, self.sim.now), self._seq_rx_deadline, step)

    def _seq_tx(self, step):
        s = self.seq
        s['timer'] = None
        if self.tx_on or self.rx_on or self._off_resp:
            # СПОРНО → модель: момент передачи пришёлся на приём чужого PPDU (или на назначенный адаптером ответ через
            # SIFS) — последовательность прерывается
            s['gen'].close()
            self.seq = None
            self._seq_finished(s, False)
            self._medium_changed()
            return
        mpdus = step.build(self.sim.now) if step.build is not None else step.mpdus
        self._phy_tx(mpdus, step.mcs, step.beam, step.agg, on_end=lambda: self._seq_txend(step), trn=step.trn)

    def _seq_txend(self, step):
        s = self.seq
        if s is None:
            return
        s['ref'] = s['tx_end'] = self.sim.now
        # 10.23.2.2: TXNAV — из Duration кадра, «most recently successfully transmitted» держателем TXOP, от конца
        # PPDU: кадр без ответа — сразу, с ответом — по получении ответа (неудача TXNAV не ставит)
        s['txnav'] = (self.sim.now + self._last_tx_dur) if s['job'] is not None and self._last_tx_dur is not None \
            else None
        if step.expect is None and s['txnav'] is not None:
            self.txnav_end = s['txnav']
        if step.expect is not None:
            s['wait'] = step
            s['late'] = False
            s['timer'] = self.sim.at(self.sim.now + response_timeout(step.resp_mcs, step.resp_gap), self._seq_timeout, step)
        else:
            self.sim.at(self.sim.now, self._seq_step, None, prio=P_MAC)

    def _seq_timeout(self, step):
        s = self.seq
        if s is None or s['wait'] is not step:
            return
        s['timer'] = None
        if self.rx_on:
            s['late'] = True                  # 10.3.2.11: PHY-RXSTART в пределах тайм-аута — ждать PHY-RXEND
            return
        s['wait'] = None
        self._seq_step(None)

    def _seq_rx_failed(self):
        s = self.seq
        if s is not None and isinstance(s['wait'], Tx) and s['late']:
            s['wait'] = None
            self._seq_step(None)

    def _seq_rx_deadline(self, step):
        s = self.seq
        if s is None or s['wait'] is not step:
            return
        s['wait'], s['timer'] = None, None
        self._seq_step(s['coll'] if step.collect else None)

    def _seq_offer(self, frames, rxv, t0):
        """Принятый кадр — последовательности, если она его ждёт. → True, если поглощён."""
        s = self.seq
        if s is None or s['wait'] is None:
            return False
        w = s['wait']
        if isinstance(w, Tx):
            if w.expect(frames):
                if s.get('txnav') is not None:
                    self.txnav_end = s['txnav']
                if s['timer'] is not None:
                    s['timer'].cancel()
                s['wait'], s['timer'], s['ref'] = None, None, self.sim.now
                self._seq_step((frames, rxv, t0))
                return True
            if s['late']:
                s['wait'] = None
                self._seq_step(None)
            return False
        if w.match(frames):
            item = (frames, rxv, t0, self.sim.now)
            if not w.collect:
                s['timer'].cancel()
                s['wait'], s['timer'], s['ref'] = None, None, self.sim.now
                self._seq_step(item)
                return True
            s['coll'].append(item)
            s['ref'] = self.sim.now
            if w.done is not None and w.done(s['coll']):
                s['timer'].cancel()
                s['wait'], s['timer'] = None, None
                self._seq_step(s['coll'])
            elif w.extend is not None:
                s['timer'].cancel()
                s['timer'] = self.sim.at(max(w.extend(s['coll']), self.sim.now), self._seq_rx_deadline, w)
            return True
        return False

    def _seq_finished(self, s, result):
        job, ac = s['job'], s['ac']
        if job is None:
            return                            # последовательность ответчика (RSS, BRP-ответ)
        ok = bool(result)
        x = self.acs[ac]
        arb = self._arbiter_job(job)
        if ac != AC_BE:
            if ok or job.retries >= DOT11_SHORT_RETRY_LIMIT or result is None:
                if x.jobs and x.jobs[0] is job:
                    x.jobs.popleft()
                if job.done is not None:
                    job.done(ok)
            else:
                job.retries += 1
        if not arb:
            self._txop_done(ac, ok)           # отсрочку работы очереди ведёт арбитр адаптера

    # ------------------------------------------------------------------ немедленные ответы (10.3.2.3.3)
    def _respond(self, mpdu, mcs, beam, kind=None, trn=0):
        """Ответ через SIFS после PHY-RXEND (10.3.2.3.3). Ack/BlockAck/DMG CTS при разгрузке SIFS_RESPONSE передаёт
        адаптер (решение и кадр — его), ядро — нет."""
        if kind in ('Ack', 'BlockAck', 'DMG CTS') and self.off & OF.SIFS_RESPONSE:
            return
        if self._resp_ev is not None or self.tx_on:
            return
        self._resp_ev = self.sim.at(self.sim.now + SIFS, self._resp_tx, mpdu, mcs, beam, trn)
        self._medium_changed()

    def _resp_tx(self, mpdu, mcs, beam, trn=0):
        if self.tx_on or self.rx_on:
            self._resp_ev = None
            self._medium_changed()
            return

        def end():
            self._resp_ev = None
        self._phy_tx([mpdu], mcs, beam, on_end=end, trn=trn)

    # ------------------------------------------------------------------ приём
    def _dispatch(self, frames, rxv, t0):
        f = frames[0]
        if self._seq_offer(frames, rxv, t0):
            return
        if f.kind == 'DMG Beacon':
            self._rx_beacon(f, rxv, t0)
            return
        if f.kind in ('SSW', 'SSW-Feedback', 'SSW-Ack'):
            if f.ra == self.addr:
                self._rx_bf(f, rxv, t0)
            return
        if f.ra != self.addr:
            return
        if f.kind == 'RTS':
            # 10.3.2.9: DMG CTS через SIFS, если NAV свободен (или NAV поставил держатель TXOP — TA RTS)
            if self.nav.idle_for_rts(self.sim.now, f.ta):
                d = D.duration_cts_response(f.dur)
                self._respond(FR.dmg_cts(d, f.ta, self.addr), 0, self._beam_to(f.ta), 'DMG CTS')
            return
        if f.kind == 'CF-End':
            # 10.23.2.10: «may transmit a CF-End frame if the RA … equal to the STA MAC address and … Duration ≠ 0»;
            # 9.3.1.6: ответ — последний в последовательности (i = 1, Duration 0), RA — передатчик CF-End
            if f.dur:
                self._respond(FR.cf_end(D.duration_cf_end(1), f.ta, self.addr), 0, self._beam_to(f.ta))
            return
        if f.kind == 'QoS Data':
            self._rx_qos_data(frames, rxv)
            return
        if f.fc.type == F.TYPE_MGMT:
            if f.kind != 'Action No Ack':
                # 10.3.2.11: Ack на индивидуальный кадр управления; Duration — 9.2.5.7
                m = D.response_mcs('ack', rxv.MCS)
                d = D.duration_ack(f.dur, txtime(14, m))
                self._respond(FR.ack(d, f.ta), m, self._beam_to(f.ta), 'Ack')
            key = (f.ta, int.from_bytes(f.raw[22:24], 'little'))
            if f.fc.retry and self._dup.get(f.ta) == key:
                return                        # табл. 10-6: дубликат кадра управления
            self._dup[f.ta] = key
            self._rx_mgmt(f, rxv)

    # ------------------------------------------------------------------ крючки роли
    def _rx_beacon(self, f, rxv, t0):
        pass

    def _rx_mgmt_role(self, f, rxv):
        pass

    def _rx_bf(self, f, rxv, t0):
        """SSW/SSW-Feedback/SSW-Ack, адресованные этой STA (вне последовательности): ответчик SLS в DTI."""
        if f.kind == 'SSW':
            self._sls_responder_rx(f, rxv, t0)

    # ------------------------------------------------------------------ кадры управления
    def send_mgmt(self, kind, ra, body_fn, done=None, mcs=None, name=''):
        """Индивидуальный кадр управления с Ack через EDCAF AC_VO (10.2.3.2). body_fn(t) — тело; t — модельный
        момент начала символа данных с первым битом кадра (Timestamp Probe Response, 11.1.3.1)."""
        mcs = self.mgmt_mcs if mcs is None else mcs
        sn = self.next_mgmt_sn()
        bssid = self.bssid or ra
        job = Job(None, None, done, ra, name or kind, queue=True)

        def build(t, retry):
            body = body_fn(t + P.data_symbol_offset(mcs))
            ack_m = D.response_mcs('ack', mcs)
            dur = D.duration_data_single(txtime(14, ack_m))         # 9.2.5.2 a) 5) i): Ack + SIFS
            m = FR.mgmt(kind, dur, ra, self.addr, bssid, sn, body)
            if retry:
                m = FR.fc_bytes(F.TYPE_MGMT, FR.MGMT_SUBTYPE[kind], retry=1) + m[2:]
            return [m]

        def est(t):
            n = FR.MGMT_HDR + len(body_fn(t)) + 4
            return txtime(n, mcs) + SIFS + txtime(14, D.response_mcs('ack', mcs))

        def gen(mac, t):
            r = yield Tx(None, mcs, mac._beam_to(ra), build=lambda tt: build(tt, job.retries > 0),
                         expect=lambda fr: fr[0].kind == 'Ack' and fr[0].ra == mac.addr,
                         resp_mcs=D.response_mcs('ack', mcs), what=kind)
            return r is not None
        job.gen, job.est = gen, est
        self._enqueue(AC_VO, job)
        return job

    def _rx_mgmt(self, f, rxv):
        if f.kind == 'Action' and f.action in ('ADDBA Request', 'ADDBA Response', 'DELBA'):
            self._rx_addba(f)
            return
        if f.kind == 'Action No Ack' and f.action == 'BRP':
            self._rx_brp(f, rxv)
            return
        self._rx_mgmt_role(f, rxv)

    # ------------------------------------------------------------------ MLME-SAP
    def mlme_request(self, prim):
        h = getattr(self, '_req_' + type(prim).__name__, None)
        if h is None:
            raise NotImplementedError(f'{self.ROLE}: {prim.NAME} не поддержан ядром этапа 1')
        h(prim)

    mlme_response = mlme_request

    def _confirm(self, prim):
        self.log(prim.NAME, prim=prim)
        if self.sme is not None:
            self.sim.at(self.sim.now, self.sme.mlme_confirm, prim)

    def _indicate(self, prim):
        self.log(prim.NAME, prim=prim)
        if self.sme is not None:
            self.sim.at(self.sim.now, self.sme.mlme_indication, prim)

    # ------------------------------------------------------------------ Block Ack: установление (10.25.2)
    def _req_MlmeAddbaRequest(self, prim):
        p = self.peer(prim.PeerSTAAddress)
        ssn = p.sn if prim.BlockAckStartingSequenceControl is None else prim.BlockAckStartingSequenceControl
        req = BA.AddbaReq(prim.DialogToken, BA.BAParams(0, BA.BA_POLICY_IMMEDIATE, prim.TID, prim.BufferSize),
                          prim.BlockAckTimeout, ssn)
        p.addba_wait = req
        body = BA.encode_addba_req(req)
        self.send_mgmt('Action', p.addr, lambda t: body, name='ADDBA Request')

    def _req_MlmeAddbaResponse(self, prim):
        p = self.peer(prim.PeerSTAAddress)
        req = p.addba_in
        resp = BA.make_addba_response(req, accept=prim.ResultCode == ML.SUCCESS, buffer_size=prim.BufferSize)
        body = BA.encode_addba_resp(resp)
        if prim.ResultCode == ML.SUCCESS:
            # 10.25.2: получатель создаёт запись по ответу; окно — Buffer Size ответа (10.25.6.3)
            p.recip = BA.Recipient(resp.params.buffer_size, req.ssn)
        self.send_mgmt('Action', p.addr, lambda t: body, name='ADDBA Response')

    def _rx_addba(self, f):
        p = self.peer(f.ta)
        body = f.raw[24:]
        if f.action == 'ADDBA Request':
            req = BA.parse_addba_req(body)
            p.addba_in = req
            self._indicate(ML.MlmeAddbaIndication(PeerSTAAddress=f.ta, DialogToken=req.token, TID=req.params.tid,
                                                  BufferSize=req.params.buffer_size, BlockAckTimeout=req.timeout))
        elif f.action == 'ADDBA Response' and p.addba_wait is not None:
            resp = BA.parse_addba_resp(body)
            req = p.addba_wait
            ok = BA.check_addba_response(req, resp) and resp.status == BA.STATUS_SUCCESS
            if ok:
                win = BA.originator_win_size(req.params.buffer_size, resp.params.buffer_size)
                orig = BA.Originator(win, req.ssn)
                p.orig = (orig, {}, req)
                # MSDU, ждавшие соглашения, — под соглашение (номера — с SSN подряд, 10.25.2)
                for (sn, data, sa, da, _r) in list(p.msdus):
                    s = orig.enqueue(1)[0]
                    p.orig[1][s] = (data, sa, da)
                p.msdus.clear()
            p.addba_wait = None
            self._confirm(ML.MlmeAddbaConfirm(PeerSTAAddress=f.ta, DialogToken=resp.token, TID=resp.params.tid,
                                              ResultCode=ML.SUCCESS if ok else ML.REFUSED,
                                              BufferSize=resp.params.buffer_size, BlockAckTimeout=resp.timeout))
            self._medium_changed()

    # ------------------------------------------------------------------ MAC-SAP (5.2)
    def ma_unitdata_request(self, req):
        da = req.destination_address
        ra = self._ra_for(da)
        if ra is None or len(req.data) > MSDU_MAX:
            st = MS.NO_BSS if ra is None else 'Undeliverable (excessive data length)'
            self._status(req, st)
            return
        p = self.peer(ra)
        if p.orig is not None:
            sn = p.orig[0].enqueue(1)[0]
            p.orig[1][sn] = (req.data, req.source_address, da)
        else:
            p.msdus.append((p.sn, req.data, req.source_address, da, 0))
            p.sn = (p.sn + 1) % BA.SN_MOD
        self._enqueue(AC_BE)

    def _ra_for(self, da):
        return None

    def _status(self, req_or_tuple, status):
        if isinstance(req_or_tuple, MS.MaUnitdataRequest):
            sa, da = req_or_tuple.source_address, req_or_tuple.destination_address
        else:
            sa, da = req_or_tuple
        ind = MS.MaUnitdataStatusIndication(sa, da, status)
        if self.sme is not None:
            self.sim.at(self.sim.now, self.sme.ma_unitdata_status_indication, ind)

    def _deliver(self, sa, da, data):
        ind = MS.MaUnitdataIndication(sa, da, data)
        if self.sme is not None:
            self.sim.at(self.sim.now, self.sme.ma_unitdata_indication, ind)

    # ------------------------------------------------------------------ данные: TXOP (10.23.2.8, 10.25.6)
    def _data_peers(self):
        out = []
        for p in self.peers.values():
            if not self._may_send_data(p.addr):
                continue
            if p.orig is not None:
                o = p.orig[0]
                if any(v in (BA.NEW, BA.RETRY) and o.in_window(s) for s, v in o.state.items()):
                    out.append(p)
            elif p.msdus and p.addba_wait is None:
                out.append(p)
        return out

    def _may_send_data(self, ra):
        return True

    def _data_job(self):
        ps = self._data_peers()
        if not ps:
            return None
        p = ps[0]
        return Job(lambda mac, t: mac._seq_data(p, t), lambda t: self._data_est(p, t), ra=p.addr, name='TXOP',
                   queue=True)

    def _ampdu_plan(self, p, t):
        """Сколько MPDU в A-MPDU: в окне Block Ack (≤ 64), aPPDUMaxTime, aPSDUMaxLength, лимит TXOP и остаток CBAP."""
        o, store, _ = p.orig
        cand = sorted((s for s, v in o.state.items() if v in (BA.NEW, BA.RETRY) and o.in_window(s)),
                      key=lambda s: (o.state[s] != BA.RETRY, BA.sn_off(s, o.start)))
        mcs = la_mcs(p.snr, p.max_mcs)
        only = self._only_peer(p)
        best, plen, res = 0, 0, False
        for n in range(1, len(cand) + 1):          # длина и время растут с n — первый неподходящий n останавливает
            sub = FR.DELIM + FR.QOS_HDR + len(store[cand[n - 1]][0]) + FR.FCS_LEN
            nl = plen + (-plen % 4 if n > 1 else 0) + sub   # дополнение предыдущего подкадра до 4 октетов
            ex = self._exchange_time(nl, mcs, True, empties=(n == len(cand) and only))
            if not (nl <= p.max_ampdu and txtime(nl, mcs) <= 2000 and self._fits(t, ex)):
                if n < len(cand):
                    break
                ex = self._exchange_time(nl, mcs, True, empties=False)
                if nl <= p.max_ampdu and txtime(nl, mcs) <= 2000 and self._fits(t, ex):
                    best, plen, res = n, nl, False  # последняя MSDU влезает, но без запаса под CF-End
                break
            best, plen, res = n, nl, n == len(cand) and only
        return best, mcs, plen, res

    def _only_peer(self, p):
        return len(self._data_peers()) <= 1

    def _exchange_time(self, plen, mcs, agg, empties):
        resp = D.response_txtime('ba' if agg else 'ack', mcs, 32 if agg else 14)
        t = T_RTS + SIFS + T_CTS + SIFS + txtime(plen, mcs) + SIFS + resp
        return t + (CF_END_RESERVE if empties else 0)

    def _fits(self, t, ex):
        lim = self.txop_limit[AC_BE]
        if lim and ex > lim:
            return False
        return self.cbap is not None and t + ex <= self.cbap[1] - self.cbap_margin

    def _data_est(self, p, t):
        if p.orig is not None:
            n, mcs, plen, res = self._ampdu_plan(p, t)
            if n == 0:
                return Fr(10 ** 9)
            return self._exchange_time(plen, mcs, True, res)
        sn, data, sa, da, _ = p.msdus[0]
        mcs = la_mcs(p.snr, p.max_mcs)
        return self._exchange_time(FR.QOS_HDR + len(data) + 4, mcs, False, True)

    def _ds_bits(self):
        return (1, 0)                         # STA → AP: To DS = 1 (табл. 9-4); точка переопределяет

    def _addr3(self, sa, da):
        return da

    def _seq_data(self, p, t):
        """TXOP данных: RTS → DMG CTS → A-MPDU (Implicit BAR) → BlockAck [→ CF-End → CF-End] (10.23.2.8, 10.23.2.10,
        10.25.6.5); без соглашения — одиночный QoS Data с Normal Ack."""
        ra = p.addr
        beam = self._beam_to(ra)
        to_ds, from_ds = self._ds_bits()
        if p.orig is not None:
            o, store, _ = p.orig
            n, mcs, plen, res = self._ampdu_plan(p, t)
            if n == 0:
                return None
            retry = {s for s, v in o.state.items() if v == BA.RETRY}
            sns = o.build_ampdu(n)
            agg = True
            items = [(s, store[s], s in retry) for s in sns]
        else:
            sn, data, sa, da, r = p.msdus[0]
            mcs = la_mcs(p.snr, p.max_mcs)
            items = [(sn, (data, sa, da), r > 0)]
            plen = FR.QOS_HDR + len(data) + 4
            agg, res = False, False
        empties = res if agg else (len(p.msdus) == 1 and self._only_peer(p))
        resp_kind = 'ba' if agg else 'ack'
        resp_mcs = D.response_mcs(resp_kind, mcs, 32 if agg else 14)
        t_resp = txtime(32 if agg else 14, resp_mcs)
        t_data = txtime(plen, mcs)
        pend = SIFS + T_CTS + SIFS + t_data + SIFS + t_resp
        # 9.2.5.2 b) 3) (TEND-NAV = 0, лимит TXOP > 0): min(TPENDING, TTXOP − TPPDU) ≤ D ≤ TTXOP − TPPDU; запас под
        # CF-End-обмен (10.23.2.10) — в пределах лимита
        d_rts = D.field(pend + (CF_END_RESERVE if empties else 0))
        r = yield Tx([FR.rts(d_rts, ra, self.addr)], 0, beam,
                     expect=lambda fr: fr[0].kind == 'DMG CTS' and fr[0].ra == self.addr and fr[0].ta == ra,
                     resp_mcs=0, what='RTS')
        if r is None:
            if agg:
                p.orig[0].on_blockack_lost()  # MPDU не переданы — снова к передаче
                for s, _, _ in items:
                    if p.orig[0].state.get(s) == BA.RETRY and s not in retry:
                        p.orig[0].state[s] = BA.NEW
            return False
        # конец NAV держателя: конец RTS + Duration (переданное значение — при разгрузке DURATION его ставит адаптер)
        nav_end = self.seq['tx_end'] + self._last_tx_dur

        def build(tt):
            d = D.field(nav_end - (tt + t_data))           # 9.2.5.2 b) 4): до конца NAV держателя
            out = []
            for s, (data, sa, da), rt in items:
                a1, a2, a3 = ra, self.addr, self._addr3(sa, da)
                out.append(FR.qos_data(d, a1, a2, a3, s, data, to_ds, from_ds, retry=rt))
            return out
        exp = (lambda fr: fr[0].kind == 'BlockAck' and fr[0].ra == self.addr and fr[0].ta == ra) if agg else \
            (lambda fr: fr[0].kind == 'Ack' and fr[0].ra == self.addr)
        r = yield Tx(None, mcs, beam, agg=agg, build=build, expect=exp, resp_mcs=resp_mcs, what='Data')
        if r is None:
            if agg:
                p.orig[0].on_blockack_lost()          # 10.25.6.7: BlockAck потерян — MPDU к повтору
            else:
                sn, data, sa, da, rr = p.msdus[0]
                if rr >= DOT11_SHORT_RETRY_LIMIT:
                    p.msdus.popleft()
                    self._status((sa, da), MS.UNDELIVERABLE)
                else:
                    p.msdus[0] = (sn, data, sa, da, rr + 1)
            return False
        if agg:
            b = r[0][0].raw
            ssn, bm = BA.parse_ba_info(b[18:28])
            acked, _ = p.orig[0].on_blockack(ssn, bm)
            for s in acked:
                data, sa, da = p.orig[1].pop(s)
                self._status((sa, da), MS.SUCCESSFUL)
        else:
            sn, data, sa, da, _ = p.msdus.popleft()
            self._status((sa, da), MS.SUCCESSFUL)
        if empties and not self._data_peers():
            # 10.23.2.10: очередь пуста, остаток ≥ 2×TCF-End + 2×SIFS — CF-End с Duration (i = 2, 9.3.1.6)
            rem = nav_end - (self.seq['ref'] + SIFS)
            if D.cf_end_nonzero_allowed(rem):
                yield Tx([FR.cf_end(D.duration_cf_end(2), ra, self.addr)], 0, beam,
                         expect=lambda fr: fr[0].kind == 'CF-End' and fr[0].ra == self.addr, resp_mcs=0,
                         what='CF-End')
        return True

    def _rx_qos_data(self, frames, rxv):
        """QoS Data к себе: соглашение есть — scoreboard + буфер переупорядочения и BlockAck на A-MPDU (10.25.6.3,
        10.25.6.5, 10.25.6.6); нет — Ack через SIFS (10.3.2.11) и выдача MSDU."""
        f0 = frames[0]
        ta = f0.ta
        if not self._may_rx_data(ta):
            return
        p = self.peer(ta)
        agg = rxv.AGGREGATION == P.AGGREGATED
        if agg and p.recip is not None:
            for f in frames:
                sn, tid, ackpol, retry, body = FR.qos_fields(f.raw)
                sa, da = self._sa_da(f)
                p.recip.on_mpdu(sn, bool(retry), (sa, da, body))
            for sn, (sa, da, body) in p.recip.delivered:
                self._deliver(sa, da, body)
            p.recip.delivered.clear()
            if self.off & OF.BA_SCOREBOARD:
                return                        # BlockAck строит и передаёт адаптер (scoreboard — его)
            ssn, bm = p.recip.build_blockack()
            m = D.response_mcs('ba', rxv.MCS, 32)
            d = D.duration_ba_response(f0.dur, txtime(32, m))
            self._respond(FR.blockack(d, ta, self.addr, TID, ssn, bm), m, self._beam_to(ta), 'BlockAck')
            return
        sn, tid, ackpol, retry, body = FR.qos_fields(f0.raw)
        if ackpol == 0:
            m = D.response_mcs('ack', rxv.MCS)
            self._respond(FR.ack(D.duration_ack(f0.dur, txtime(14, m)), ta), m, self._beam_to(ta), 'Ack')
        key = ('d', ta, sn)
        if retry and self._dup.get(('d', ta)) == key:
            return
        self._dup[('d', ta)] = key
        sa, da = self._sa_da(f0)
        self._deliver(sa, da, body)

    def _may_rx_data(self, ta):
        return True

    def _sa_da(self, f):
        """Табл. 9-4 (To DS, From DS): 1,0 — A2 = SA, A3 = DA; 0,1 — A2 = BSSID, A3 = SA, A1 = DA."""
        if f.fc.to_ds:
            return F.mac_str(f.raw[10:16]), F.mac_str(f.raw[16:22])
        return F.mac_str(f.raw[16:22]), F.mac_str(f.raw[4:10])

    # ------------------------------------------------------------------ SLS в DTI (10.42.2, 10.42.6.2)
    def _sls_ssw(self, ra, direction, cdown, sector, fb, dur):
        return F.encode_frame(F.SswFrame(duration=int(dur), ra=ra, ta=self.addr,
                                         ssw=F.Ssw(direction=direction, cdown=cdown, sector_id=sector, antenna_id=0),
                                         fb=fb), with_fcs=False, in_cbap=True)

    def _sls_time(self, n_init, n_resp):
        return ((n_init + n_resp) * (T_SSW + SBIFS) - 2 * SBIFS + MBIFS + MBIFS + T_SSW_FB + MBIFS + T_SSW_ACK)

    def start_sls(self, peer_addr, done=None, n_resp_guess=None):
        """SLS в DTI инициатором (MLME-BF-TRAINING.request, RequestBRP = false): ISS-TXSS по своим секторам → RSS
        ответчика через MBIFS → SSW-Feedback через MBIFS после конца RSS → SSW-Ack (10.42.2, 10.42.6.2). Доступ —
        EDCA (AC_VO; 10.39.5: начинать, только если SLS укладывается в CBAP)."""
        n_resp = n_resp_guess or len(self.sectors)
        job = Job(None, lambda t: self._sls_time(len(self.sectors), n_resp), done, peer_addr, 'SLS')
        job.gen = lambda mac, t: mac._seq_sls_init(peer_addr)
        self._enqueue(AC_VO, job)
        return job

    def _seq_sls_init(self, ra):
        secs = self.sectors
        n = len(secs)
        self.set_rx_beam(P.QUASI_OMNI)
        fb_iss = F.SswFbIss(total_sectors=F.total_sectors_raw(n), rx_antennas=0, poll_required=0)
        for i, s in enumerate(secs):
            cd = n - 1 - i
            yield Tx([self._sls_ssw(ra, 0, cd, s, fb_iss, D.duration_ssw(cd))], 0, P.Beam(s), gap=SBIFS,
                     what='SSW ISS')
        iss_end = self.seq['ref']
        # RSS ответчика: первый кадр — через MBIFS после конца ISS (10.42.6.2); ждём до последнего (CDOWN 0)
        until = iss_end + MBIFS + 2 * T_SSW + 2 * SIFS

        def match(fr):
            f = fr[0]
            return f.kind == 'SSW' and f.ta == ra and f.ra == self.addr and f.raw[16] & 1 == 1

        def cdown(c):
            return F.parse_frame(c[-1][0][0].raw, with_fcs=False).ssw.cdown

        # срок — ожидаемый конец RSS по CDOWN последнего принятого кадра (10.42.2.2.2) + запас на приём
        coll = yield Rx(match, until, collect=True, done=lambda c: cdown(c) == 0,
                        extend=lambda c: c[-1][3] + cdown(c) * (T_SSW + SBIFS) + SIFS)
        if not coll:
            return False
        last = coll[-1]
        p_last = F.parse_frame(last[0][0].raw, with_fcs=False)
        rss_end = last[3] + p_last.ssw.cdown * (T_SSW + SBIFS)      # 10.42.2.2.2: конец RSS по CDOWN
        best = max(coll, key=lambda c: (c[1].SNR, -F.parse_frame(c[0][0].raw, with_fcs=False).ssw.sector_id))
        pb = F.parse_frame(best[0][0].raw, with_fcs=False)
        # SSW Feedback поля RSS — лучший сектор ISS по мнению ответчика (10.42.2.3.2) → свой луч передачи
        my_sel = pb.fb.sector_select
        self.peer(ra).tx_beam = P.Beam(my_sel)
        snr = F.snr_quantize(Fr(best[1].SNR).limit_denominator(1000))
        d_fb = D.duration_ssw_fb(False, False)
        fb = F.encode_frame(F.SswFbFrame(duration=d_fb, ra=ra, ta=self.addr,
                                         fb=F.SswFb(sector_select=pb.ssw.sector_id, antenna_select=pb.ssw.antenna_id,
                                                    snr_report=F.snr_report_raw(snr)),
                                         brp=F.BrpReq(), blm=F.Blm()), with_fcs=False, abft=False)
        r = yield Tx([fb], 0, P.Beam(my_sel), at=rss_end + MBIFS,
                     expect=lambda fr: fr[0].kind == 'SSW-Ack' and fr[0].ta == ra and fr[0].ra == self.addr,
                     resp_mcs=0, resp_gap=MBIFS, what='SSW-Feedback')
        # 10.42.6.2: ответ SSW-Ack ожидается через MBIFS; тайм-аут — как у немедленного ответа
        self.peer(ra).rx_beam = P.QUASI_OMNI
        return r is not None

    def _sls_responder_rx(self, f, rxv, t0):
        """Ответчик SLS: ISS (Direction 0, адресован себе) → RSS через MBIFS после конца ISS по CDOWN."""
        if self.seq is not None:
            return
        p = F.parse_frame(f.raw, with_fcs=False)
        if p.ssw.direction != 0:
            return
        st = getattr(self, '_sls_rx', None)
        if st is None or st['ini'] != f.ta or st['done']:
            st = self._sls_rx = dict(ini=f.ta, frames=[], done=False, ev=None)
        st['frames'].append((p, rxv.SNR))
        iss_end = self.sim.now + p.ssw.cdown * (T_SSW + SBIFS)
        if st['ev'] is not None:
            st['ev'].cancel()
        st['ev'] = self.sim.at(iss_end + MBIFS, self._sls_rss_start, f.ta)

    def _sls_rss_start(self, ini):
        st = self._sls_rx
        st['done'], st['ev'] = True, None
        if self.seq is not None or self.tx_on:
            return
        self._seq_start(self._seq_sls_resp(ini, st['frames']))

    def _seq_sls_resp(self, ini, iss):
        best_p, best_snr = max(iss, key=lambda x: (x[1], -x[0].ssw.sector_id))
        snr = F.snr_quantize(Fr(best_snr).limit_denominator(1000))
        fb = F.SswFb(sector_select=best_p.ssw.sector_id, antenna_select=best_p.ssw.antenna_id,
                     snr_report=F.snr_report_raw(snr))
        secs = self.sectors
        n = len(secs)
        for i, s in enumerate(secs):
            cd = n - 1 - i
            yield Tx([self._sls_ssw(ini, 1, cd, s, fb, D.duration_ssw(cd))], 0, P.Beam(s), gap=SBIFS,
                     what='SSW RSS')
        rss_end = self.seq['ref']
        r = yield Rx(lambda fr: fr[0].kind == 'SSW-Feedback' and fr[0].ta == ini,
                     rss_end + MBIFS + T_SSW_FB + SIFS)
        if r is None:
            return False
        p = F.parse_frame(r[0][0].raw, with_fcs=False)
        self.peer(ini).tx_beam = P.Beam(p.fb.sector_select, p.fb.antenna_select)   # 10.42.2.4
        snr = F.snr_quantize(Fr(r[1].SNR).limit_denominator(1000))
        ack = F.encode_frame(F.SswAck(duration=D.duration_ssw_ack(p.duration), ra=ini, ta=self.addr,
                                      fb=F.SswFb(sector_select=best_p.ssw.sector_id,
                                                 antenna_select=best_p.ssw.antenna_id,
                                                 snr_report=F.snr_report_raw(snr)),
                                      brp=F.BrpReq(), blm=F.Blm()), with_fcs=False)
        yield Tx([ack], 0, self.peer(ini).tx_beam, gap=MBIFS, what='SSW-Ack')
        self.log('sls_responder_done', peer=ini)
        self._indicate(ML.MlmeBfTrainingIndication(PeerSTAAddress=ini, ResultCode=ML.SUCCESS))
        return True

    # ------------------------------------------------------------------ BRP setup (10.42.3.2)
    def _brp_mpdu(self, ra, dur, initiator, cap_req, rx_train_resp=0):
        fr = BRP.BrpFrame(req=BRP.BrpRequest(), bre=BRP.BeamRefinement(initiator=initiator, cap_req=cap_req,
                                                                     rx_train_resp=rx_train_resp))
        return FR.mgmt('Action No Ack', dur, ra, self.addr, self.bssid or ra, self.next_mgmt_sn(), fr.body()), fr

    def start_brp_setup(self, ra, done=None):
        """10.42.5.2: после SSW-Feedback в A-BFT — BRP с Capability Request = 1 на MCS 0 через Sector Select
        ответчика; ответ ответчика (Capability Request = 0) через SIFS…BRPIFS, завершающий BRP инициатора (10.42.3.2,
        рис. 10-79). Доступ — EDCA AC_VO (Action No Ack — кадр управления)."""
        _, fr = self._brp_mpdu(ra, 0, 1, 1)
        t_brp = txtime_control(fr.length)
        # с ответом через BRPIFS (10.3.2.3.9) и завершающим BRP-RX до L_RX_MAX единиц TRN-R (10.42.6.4.1)
        job = Job(None, lambda t: 2 * t_brp + BRP.brp_txtime(fr.length, 0, BRP.TRN_LEN_MAX) + BRPIFS + SIFS, done,
                  ra, 'BRP setup')
        job.gen = lambda mac, t: mac._seq_brp_init(ra, t_brp)
        self._enqueue(AC_VO, job)
        return job

    def _seq_brp_init(self, ra, t_brp):
        dur1 = D.field(2 * SIFS + 2 * t_brp)                # 10.42.6.4.1: до конца обмена setup в TXOP
        m, _ = self._brp_mpdu(ra, dur1, 1, 1)
        t_end1 = self.sim.now + t_brp
        # ответ ответчика — от SIFS до BRPIFS (10.42.3.1, 10.3.2.3.9): ожидание — BRPIFS + aSlotTime + aRxPHYStartDelay
        r = yield Tx([m], 0, self._beam_to(ra),
                     expect=lambda fr: fr[0].action == 'BRP' and fr[0].ta == ra and fr[0].ra == self.addr,
                     resp_mcs=0, resp_gap=BRPIFS, what='BRP setup')
        if r is None:
            return None                       # Action No Ack: повторов нет (10.42.3.2 — повтор не предписан)
        # 10.42.3.2: BRP инициатора, завершающий setup, может быть первым BRP фазы BRP; ответчик запросил обучение
        # приёма (L-RX > 0) — это BRP-RX с L-RX·4 подполями TRN-R и RX-train-response = 1 (10.42.6.4.1)
        n = self._brp_l_rx(r[0][0])
        m3, fr3 = self._brp_mpdu(ra, 0, 1, 0, rx_train_resp=1 if n else 0)
        t3 = self.sim.now + SIFS + BRP.brp_txtime(fr3.length, 0, n)
        m3 = m3[:2] + BRP_dur(t3, max(t3, t_end1 + dur1)) + m3[4:]
        yield Tx([m3], 0, self._beam_to(ra), what='BRP setup end', trn=n)
        return True

    @staticmethod
    def _brp_l_rx(f):
        """L-RX (9.5.4) принятого кадра BRP — запрошенные единицы TRN-R (не больше TRN_LEN 16, табл. 20-1)."""
        try:
            return min(BRP.BrpRequest.parse(f.raw[27:31]).l_rx, BRP.TRN_LEN_MAX)
        except Exception:
            return 0

    def _rx_brp(self, f, rxv):
        body = f.raw[24:]
        bre = BRP.BeamRefinement.parse(body[7:14])
        n = self._brp_l_rx(f)
        if n and not bre.cap_req and f.ra == self.addr:
            # 10.42.6.4.1: запрос обучения приёма (L-RX > 0) — ответ BRP PPDU с L-RX·4 подполями TRN-R и
            # RX-train-response = 1; Initiator = 0 (предыдущий принятый кадр — BRP, свой последний — не BRP с
            # Initiator = 1); через SIFS (≥ SIFS, ≤ BRPIFS, 10.3.2.3.9). Обучение передачи (TX-TRN-REQ) — этап 4
            m, fr = self._brp_mpdu(f.ta, 0, 0, 0, rx_train_resp=1)
            te = self.sim.now + SIFS + BRP.brp_txtime(fr.length, 0, n)
            m = m[:2] + BRP_dur(te, max(te, self.sim.now + f.dur)) + m[4:]
            self._respond(m, 0, self._beam_to(f.ta), trn=n)
            self.log('brp_rx_training_responder', peer=f.ta, l_rx=n)
            return
        if bre.cap_req and bre.initiator:
            # 10.42.3.2: «Upon receiving a BRP PPDU with the Capability Request subfield set to 1, the responder shall
            # respond with a BRP PPDU» с Capability Request = 0; через SIFS (≥ SIFS, ≤ BRPIFS, 10.42.3.1)
            m, fr = self._brp_mpdu(f.ta, 0, 0, 0)
            te = self.sim.now + SIFS + txtime_control(fr.length)
            m = m[:2] + BRP_dur(te, self.sim.now + f.dur) + m[4:]
            self._respond(m, 0, self._beam_to(f.ta))
            self.log('brp_setup_responder', peer=f.ta)


def BRP_dur(t_end, alloc_end):
    return int(BRP.brp_duration(t_end, alloc_end)).to_bytes(2, 'little')
