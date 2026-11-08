# SPDX-License-Identifier: AGPL-3.0-or-later
"""Идеальная среда: PHY-SAP (sap_phy) для каждого узла поверх общего направленного эфира. Без разгрузки
(offload.IDEAL): PHY только передаёт и принимает PPDU, всё остальное — ядро.

Эфир (выбор модели, не стандарт — стандарт задаёт лишь минимальные требования к приёмнику; пороги — ref/medium):
  - уровень приёма, дБм = base(пара) − штраф(луч передатчика) − штраф(луч приёмника): штраф сектора — step_db ×
    круговое расстояние до лучшего сектора к партнёру, квази-омни — qo_loss_db (≤ 15 дБ, 20.9.1). Детерминированная
    функция пары лучей — «качество луча»; SLS ядра находит лучший сектор по SNR из RXVECTOR;
  - задержка распространения — на пару (по умолчанию 10 нс ≈ 3 м; ≤ aAirPropagationTime/2, табл. 20-30);
  - синхронизация на PPDU (20.8): приёмник не передаёт, ни на что не синхронизирован и уровень ≥ чувствительности
    заголовка (control — табл. 20-3 MCS 0, −78 дБм; SC — MCS 1, −68 дБм);
  - PHY-CCA BUSY: есть PPDU, на который приёмник синхронизирован (до его конца, 8.3.5.13.3), или уровень любого
    PPDU не ниже порога обнаружения преамбулы (control −78, SC −68 дБм — та же чувствительность заголовка; 20.4.4.2.2,
    20.5.4.2.2) — и тогда, когда приёмник уже занят другим PPDU; IDLE — иначе;
  - коллизия: перекрытие у приёмника с другим PPDU уровня ≥ −78 дБм портит оба (без захвата); перекрытие до
    PHY-RXSTART — RXSTART не выдаётся; после — PSDU доставляется испорченным (FCS не сходится, MAC видит ошибку);
  - полудуплекс: узел, передававший во время прихода PPDU, его не принимает;
  - декодирование: уровень ≥ чувствительности MCS PPDU (табл. 20-3), иначе PHY-RXEND(FormatViolation) без данных;
  - уточняющая AWV (Beam.awv, BRP и сопровождение луча — расширение модели sap_phy): положение луча = сектор +
    awv·AWV_STEP сектора, штраф — step_db × круговое расстояние до лучшего положения (лучшее у пары может быть дробным —
    тогда SLS находит ближайший сектор, а BRP уточняет AWV); TRN_SNR в RXVECTOR — уровень на каждом подполе TRN (TRN-T —
    AWV передатчика TRN_AWVS, TRN-R — AWV приёма RX_TRN_AWVS по кругу);
  - движение (move): смена лучших секторов/уровня пары в заданный момент — деградация направленной связи.
SNR в RXVECTOR = уровень − шум (NOISE_DBM), насыщение −13…50,75 дБ, шаг 0,25 (табл. 20-1, fields.snr_quantize).
Журнал эфира — Journal (journal.py): каждый PPDU с моментами, передатчиком, PSDU, TXVECTOR, кто принял."""
from fractions import Fraction as Fr

from .. import fields as F
from ..medium import CCA_ED_DBM, SENSITIVITY_DBM
from . import sap_phy as P
from .journal import Journal
from .sim import P_END, P_START

NOISE_DBM = -80                     # шум приёмника для SNR (модель)
LOCK_DBM = {'control': SENSITIVITY_DBM['0'], 'sc': SENSITIVITY_DBM['1']}
INTERF_DBM = SENSITIVITY_DBM['0']   # помеха, портящая приём (модель: без захвата)
DEFAULT_PROP = Fr(1, 100)           # 10 нс
AWV_STEP = Fr(1, 4)                 # шаг уточняющей AWV в долях сектора (модель)


def _snr(level):
    return float(F.snr_quantize(Fr(level).limit_denominator(1000) - NOISE_DBM))


class _Ppdu:
    __slots__ = ('n', 'src', 'txv', 'psdu', 't0', 't1', 'rec', 'channel')

    def __init__(self, n, src, txv, psdu, t0, t1, channel=3):
        self.n, self.src, self.txv, self.psdu, self.t0, self.t1 = n, src, txv, psdu, t0, t1
        self.rec = None
        self.channel = channel


class _Arrival:
    __slots__ = ('ppdu', 't0', 't1', 'power', 'locked', 'spoiled', 'rxstart', 'pre_start')

    def __init__(self, ppdu, t0, t1, power):
        self.ppdu, self.t0, self.t1, self.power = ppdu, t0, t1, power
        self.locked = self.spoiled = self.rxstart = self.pre_start = False


class IdealPhy:
    """PHY узла (PhySap). mac — PhySapUser."""
    def __init__(self, medium, name, addr, sectors, antennas=1):
        self.m, self.name, self.addr = medium, name, addr
        self.sectors, self.antennas = sectors, antennas
        self.mac = None
        self.rx_beam = P.QUASI_OMNI
        self.config = P.PhyConfigVector()
        self.tx = None                     # текущий PPDU передачи
        self.txv = None
        self.arr = []                      # активные приходы
        self.lock = None                   # _Arrival, на который синхронизирован
        self.cca = P.IDLE
        self.tx_hist = []                  # (t0, t1) своих передач — полудуплекс

    # ---------------- PhySap ----------------
    def phy_config_request(self, vector):
        self.config = vector
        self.rx_beam = vector.RX_ANT_CONFIG

    def phy_txstart_request(self, txvector):
        assert self.tx is None, f'{self.name}: PHY-TXSTART.request во время передачи'
        self.txv = txvector
        self._psdu = None
        self.mac.phy_txstart_confirm(P.TxStatus())

    def phy_data_request(self, data):
        assert self.txv is not None and len(data) == self.txv.LENGTH, (self.name, len(data), self.txv)
        self._psdu = bytes(data)
        self.mac.phy_data_confirm()

    def phy_txend_request(self):
        self.tx = self.m._transmit(self, self.txv, self._psdu)

    def phy_ccareset_request(self, ipi_state=None):
        pass

    # ---------------- от эфира ----------------
    def _tx_end(self, ppdu):
        self.tx, self.txv = None, None
        self.mac.phy_txend_confirm()

    def _arrive(self, a):
        self.arr.append(a)
        mode = 'control' if a.ppdu.txv.MCS == 0 else 'sc'
        busy_tx = self.tx is not None
        for b in self.arr:
            if b is not a and a.power >= INTERF_DBM:
                b.spoiled = True
            if b is not a and b.power >= INTERF_DBM:
                a.spoiled = True
        if not busy_tx and self.lock is None and a.power >= LOCK_DBM[mode]:
            a.locked = True
            self.lock = a
            self.m.sim.at(a.t0 + P.rx_start_delay(a.ppdu.txv.MCS), self._rxstart, a, prio=P_START)
        self._cca_update()

    def _rxstart(self, a):
        if self.lock is not a or a.spoiled or a.t1 <= self.m.sim.now:
            return
        a.rxstart = True
        txv = a.ppdu.txv
        snr = _snr(a.power)
        self.mac.phy_rxstart_indication(P.RxVector(MCS=txv.MCS, LENGTH=txv.LENGTH, AGGREGATION=txv.AGGREGATION,
                                                   PPDU_TYPE=txv.PPDU_TYPE, TRN_LEN=txv.TRN_LEN, RSSI=a.power,
                                                   SNR=snr, RCPI=a.power,
                                                   BEAM_TRACKING_REQUEST=txv.BEAM_TRACKING_REQUEST,
                                                   TRN_SNR=self._trn_snr(a)))

    def _trn_snr(self, a):
        """SNR на подполях TRN принятого PPDU (расширение модели): TRN-T — AWV передатчика по кругу при своей
        диаграмме приёма; TRN-R — AWV преамбулы передатчика при AWV приёма RX_TRN_AWVS по кругу (без них — своя
        диаграмма приёма)."""
        txv = a.ppdu.txv
        if not P.trn_appended(txv):
            return ()
        n = txv.TRN_LEN * 4
        out = []
        for i in range(n):
            if txv.PPDU_TYPE == P.TRN_T and txv.TRN_AWVS:
                lv = self.m.level(a.ppdu.src, txv.TRN_AWVS[i % len(txv.TRN_AWVS)], self.name, self.rx_beam)
            else:
                rx = self.config.RX_TRN_AWVS[i % len(self.config.RX_TRN_AWVS)] if self.config.RX_TRN_AWVS \
                    else self.rx_beam
                lv = self.m.level(a.ppdu.src, txv.ANT_CONFIG, self.name, rx)
            out.append(_snr(lv) if lv is not None else None)
        return tuple(out)

    def _depart(self, a):
        self.arr.remove(a)
        ok = False
        if self.lock is a:
            self.lock = None
            if a.rxstart:
                half = any(t0 < a.t1 and a.t0 < t1 for t0, t1 in self.tx_hist[-4:])
                sens = SENSITIVITY_DBM[str(a.ppdu.txv.MCS)]
                if a.power < sens or half:
                    self.mac.phy_rxend_indication(P.FORMAT_VIOLATION)
                else:
                    data = a.ppdu.psdu
                    if a.spoiled:
                        data = bytes(x ^ 0xA5 for x in data)          # помеха: FCS не сходится
                    else:
                        ok = True
                    self.mac.phy_data_indication(data)
                    self.mac.phy_rxend_indication(P.NO_ERROR)
        if a.ppdu.rec is not None:
            if a.locked:
                a.ppdu.rec.heard.add(self.name)
            if ok:
                a.ppdu.rec.receivers.add(self.name)
            elif a.rxstart:
                a.ppdu.rec.rx_err.add(self.name)          # PHY-RXEND с ошибкой / FCS не сошлась → EIFS у MAC
        self._cca_update()

    def _cca_update(self):
        busy = self.lock is not None or any(
            b.power >= min(CCA_ED_DBM, LOCK_DBM['control' if b.ppdu.txv.MCS == 0 else 'sc']) for b in self.arr)
        st = P.BUSY if busy else P.IDLE
        if st != self.cca:
            self.cca = st
            self.mac.phy_cca_indication(st)


class IdealMedium:
    """Общий эфир. attach() — PHY узла; link() — модель канала пары; block() — затенение пары на интервале."""
    def __init__(self, sim, prop=DEFAULT_PROP, journal=None):
        self.sim, self.prop = sim, Fr(prop)
        self.phys = {}
        self.links = {}
        self.blocked = []
        self.delay = {}
        self.journal = journal if journal is not None else Journal()
        self._n = 0

    def attach(self, name, addr, sectors, mac):
        phy = IdealPhy(self, name, addr, sectors)
        phy.mac = mac
        self.phys[name] = phy
        self.journal.nodes[name] = addr
        return phy

    def link(self, a, b, base_dbm=-40, best_a=0, best_b=0, step_db=3, qo_loss_db=10):
        """Канал пары a↔b (взаимный): уровень = base − штраф(луч a) − штраф(луч b)."""
        self.links[(a, b)] = (base_dbm, best_a, best_b, step_db, qo_loss_db)
        self.links[(b, a)] = (base_dbm, best_b, best_a, step_db, qo_loss_db)

    def move(self, a, b, t, best_a=None, best_b=None, base_dbm=None):
        """С момента t — новые лучшие положения луча пары (могут быть дробными: доля сектора) и/или уровень base:
        деградация направленной связи (поворот, смещение узла)."""
        def apply():
            base, ba, bb, step, qo = self.links[(a, b)]
            self.link(a, b, base if base_dbm is None else base_dbm, ba if best_a is None else best_a,
                      bb if best_b is None else best_b, step, qo)
        self.sim.at(Fr(t), apply)

    def set_delay(self, a, b, d):
        self.delay[(a, b)] = self.delay[(b, a)] = Fr(d)

    def block(self, a, b, t0, t1):
        self.blocked.append((a, b, Fr(t0), Fr(t1)))

    def level(self, tx, tx_beam, rx, rx_beam):
        """Уровень приёма, дБм (модель «качества луча»): None — связи нет."""
        L = self.links.get((tx, rx))
        if L is None:
            return None
        for a, b, t0, t1 in self.blocked:
            if {a, b} == {tx, rx} and t0 <= self.sim.now < t1:
                return None
        base, best_tx, best_rx, step, qo = L

        def pen(beam, best, n):
            if beam.sector is None:
                return qo
            pos = beam.sector + (beam.awv or 0) * AWV_STEP
            d = abs(pos - best) % n
            return step * min(d, n - d)
        return base - pen(tx_beam, best_tx, len(self.phys[tx].sectors)) - pen(rx_beam, best_rx,
                                                                               len(self.phys[rx].sectors))

    def _transmit(self, phy, txv, psdu):
        now = self.sim.now
        t1 = now + P.ppdu_time(txv)
        self._n += 1
        pp = _Ppdu(self._n, phy.name, txv, psdu, now, t1, phy.config.OPERATING_CHANNEL)
        pp.rec = self.journal.add(now, t1, phy.name, phy.addr, txv, psdu)
        phy.tx_hist.append((now, t1))
        self.sim.at(t1, phy._tx_end, pp, prio=P_END)
        for name, other in self.phys.items():
            if other is phy:
                continue
            d = self.delay.get((phy.name, name), self.prop)
            self.sim.at(now + d, self._arrive_at, other, pp, d, prio=P_START)
        return pp

    def _arrive_at(self, phy, pp, d):
        if phy.config.OPERATING_CHANNEL != pp.channel:
            return                                         # другой канал (20.2.3 OPERATING_CHANNEL)
        lv = self.level(pp.src, pp.txv.ANT_CONFIG, phy.name, phy.rx_beam)
        if lv is None:
            return
        a = _Arrival(pp, pp.t0 + d, pp.t1 + d, lv)
        if pp.rec is not None and lv >= min(CCA_ED_DBM, LOCK_DBM['control' if pp.txv.MCS == 0 else 'sc']):
            pp.rec.sensed.add(phy.name)                    # PHY-CCA BUSY у приёмника (обнаружение)
        phy._arrive(a)
        self.sim.at(a.t1, phy._depart, a, prio=P_END)
