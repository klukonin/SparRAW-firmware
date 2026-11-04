# SPDX-License-Identifier: AGPL-3.0-or-later
"""Направленный эфир DMG для дискретно-событийного моделирования нескольких станций (802.11-2020).

Понятия стандарта:
  3.2      — sector («transmit or receive antenna pattern corresponding to a sector ID»), quasi-omni antenna
             pattern («widest beamwidth attainable»), AWV (вектор возбуждения элементов решётки).
  10.42.1  — у STA одна или несколько DMG-антенн; секторов на антенну ≤ 64, всего ≤ 128.
  9.5.1    — Sector ID 6 бит (0…63), DMG Antenna ID 2 бита (0…3).
  10.3.4.2 — передача «directed toward the intended receiver», приём квази-омни или направленный на партнёра;
             рис. 10-19: станции, не попавшие в луч, среду не слышат (направленная скрытая станция).
  20.3.3.8, табл. 20-3 — минимальная чувствительность приёмника по MCS.
  20.4.4.2.2 / 20.5.4.2.2 — CCA DMG control / SC: занятость при уровне > −68 дБм; удержание занятости для
             любого сигнала на 20 дБ выше чувствительности MCS 1 (−48 дБм).
  20.8     — CCA BUSY по обнаружению STF; после верного заголовка — занято до ожидаемого конца PPDU.
  20.9.1   — усиление главного лепестка квази-омни не более чем на 15 дБ ниже направленного (check_quasi_omni).
  табл. 20-30 / 8.4 (MIB) — aAirPropagationTime: удвоенное время распространения между самыми далёкими STA.

Модель:
  Конфигурация антенны — кортеж (antenna_id, sector_id | None); None — квази-омни этой антенны (как в sls.py).
  Передача: конфигурация TX фиксирована на весь PPDU (TRN-поля BRP не моделируются: уровень одного PPDU).
  Приём: конфигурация RX — функция времени (история смен); None вместо кортежа — приёмник выключен.
  Мощность на входе приёмника, дБм = tx_power_dbm(передатчика) + gain(tx, tx_cfg, rx, rx_cfg), дБ; gain — таблица
  с явными значениями (в неё входят и антенные усиления, и потери трассы); нет записи — нет связи (−∞).
  Задержка распространения — на пару STA (односторонняя, ≤ aAirPropagationTime/2), по умолчанию 0 (как cbap.Air:
  все моменты «на эфире»).

ВЫБОР МОДЕЛИ (не стандарт, стандарт задаёт лишь минимальные требования к приёмнику):
  * Захват/коллизия: PPDU p принят приёмником r, только если для КАЖДОГО перекрывающегося у r PPDU q
    P_p > P_q + capture_db (capture_db по умолчанию 0: выживает только строго более сильный; равные гибнут оба).
    Порядок прихода не важен (без «message-in-message»), помехи не суммируются, шум не моделируется.
  * Синхронизация («lock», 20.8): приёмник, слушающий в момент прихода начала PPDU, синхронизируется, если
    уровень ≥ чувствительности заголовка: control — табл. 20-3 MCS 0 (−78 дБм), SC — MCS 1 (−68 дБм; совпадает
    с порогом CCA 20.5.4.2.2). Для control порог CCA «> −68 дБм» 20.4.4.2.2 — нижняя граница требования; модель
    чувствительнее (занято с −78 дБм, раз кадр декодируем), что требованию не противоречит.
  * CCA занято в момент t, если: STA передаёт; или есть PPDU, на который она синхронизировалась (до его конца,
    20.8, даже при смене конфигурации RX); или уровень любого PPDU в текущей конфигурации RX ≥ ed_dbm (−48).
    Пропущенная преамбула (STA передавала или смотрела не туда в начале PPDU) — только порог −48 дБм.
    Задержка индикации (≤ 3 мкс control, ≤ 1 мкс SC) — 0 (константа CCA_DETECT_MAX — для проверок).
  * Декодирование PPDU p у r: r синхронизировался в начале; r не передавал ни в какой момент прихода
    [s, e) (полудуплекс); RX не выключался; уровень в КАЖДОЙ действовавшей конфигурации RX ≥ табл. 20-3
    по MCS; правило захвата выше (для помехи берётся максимум уровня по конфигурациям RX на перекрытии).
  * PER не моделируется: выше чувствительности — принят, ниже — нет (табл. 20-3 задаёт уровень для PER 5 % / 1 %).

Не моделируется: TRN/AGC-поля и измерения BRP, многолучевость, взаимность антенн (Antenna Pattern Reciprocity,
9.4.2.127 — для симметричной таблицы есть reciprocal=True в set_gain), OFDM DMG (MCS 13–24, устарел; в табл. 20-3
его нет), EDMG, CCA по энергии вне DMG-сигналов.

API (в духе cbap.Air, но события — обратные вызовы):
  m = Medium(prop=0, capture_db=0)
  m.add_station(addr, antennas={0: 64}, tx_power_dbm=0, agent=None, rx_cfg=(0, None), tx_cfg=(0, None))
  m.set_gain(tx, tx_cfg, rx, rx_cfg, db, reciprocal=False)  — ANY вместо cfg — любая конфигурация
  m.set_delay(a, b, d)                     — односторонняя задержка пары (≤ aAirPropagationTime/2)
  m.set_rx(addr, cfg, t=None) / m.set_tx(addr, cfg, t=None)   — смена конфигурации сейчас или в момент t
  m.transmit(src, frame, t=None, tx_cfg=None) → AirEntry      — начать PPDU в t (≥ now)
  m.at(t, fn, *args)                       — таймер: fn(t, *args)
  m.run(until) → список AirEntry, начатых в этом вызове (журнал — m.log)
  m.cca(addr, t=None) → bool; m.cca_info(addr, t=None) → (bool, [причины])
  m.air_log() → кортежи формата cbap.check_air_log
  agent — объект с необязательными методами: on_rx_start(t, entry, power_dbm), on_rx_end(t, entry, frame|None,
  result), on_tx_end(t, entry), on_cca(t, busy)."""
import heapq
from fractions import Fraction as Fr

from .timing import aAirPropagationTime, txtime

NEG_INF = float('-inf')
ANY = '*'

# ---- 20.3.3.8, табл. 20-3 — Receiver minimum input level sensitivity, дБм ----
SENSITIVITY_DBM = {
    '0': -78, '1': -68, '2': -66, '3': -65, '4': -64, '5': -62, '6': -63, '7': -62, '8': -61, '9': -59,
    '9.1': -57, '10': -55, '11': -54, '12': -53, '12.1': -51, '12.2': -50, '12.3': -48, '12.4': -46, '12.5': -44,
    '12.6': -42, '25': -64, '26': -60,
    # MCS 27 (low-power SC) в табл. 20-3 2020 отсутствует; 802.11-2024 табл. 20-3 дополняет строкой «27 | –57» —
    # пробел 2020 закрыт по 2024.
    '27': -57,
}
# 20.5.4.2.2: «minimum sensitivity for MCS 1 (–68 dBm)»; удержание занятости — «20 dB above» → −48 дБм
CCA_SC_DBM = -68
CCA_CONTROL_DBM = -68          # 20.4.4.2.2: «receive level greater than –68 dBm»
CCA_ED_DBM = SENSITIVITY_DBM['1'] + 20
# 20.4.4.2.2 «within 3 µs», 20.5.4.2.2 «within 1 µs»
CCA_DETECT_MAX = {'control': Fr(3), 'sc': Fr(1)}
# 20.9.1: квази-омни ≤ 15 дБ ниже направленного
QO_MAX_LOSS_DB = 15
# 10.42.1 / 9.5.1
MAX_SECTORS_PER_ANT = 64
MAX_SECTORS_PER_STA = 128
MAX_ANTENNAS = 4               # DMG Antenna ID — 2 бита
MAX_PROP_ONE_WAY = aAirPropagationTime / 2   # aAirPropagationTime — «twice the propagation time»


def mcs_key(mcs):
    """Нормализовать MCS (int, '9.1', 9.1) к ключу табл. 20-3."""
    if isinstance(mcs, float):
        mcs = f'{mcs:g}'
    return str(mcs)


def sensitivity(mcs):
    """Табл. 20-3: минимальный уровень для MCS; KeyError — MCS вне таблицы (напр. OFDM 13–24)."""
    k = mcs_key(mcs)
    if k not in SENSITIVITY_DBM:
        raise KeyError(f'MCS {mcs}: нет в табл. 20-3')
    return SENSITIVITY_DBM[k]


def phy_mode(mcs):
    """20.1/20.4/20.5: MCS 0 — DMG control mode, остальные из табл. 20-3 — SC (в т. ч. low-power SC 25–27)."""
    return 'control' if mcs_key(mcs) == '0' else 'sc'


def qo(ant=0):
    """Квази-омни конфигурация антенны ant."""
    return (ant, None)


def sec(sector, ant=0):
    """Сектор sector антенны ant."""
    return (ant, sector)


def norm_cfg(c):
    """Конфигурация → (ant, sector|None). Допускается: None/'qo' — квази-омни антенны 0, int — сектор антенны 0."""
    if c is ANY:
        return ANY
    if c is None or c == 'qo':
        return (0, None)
    if isinstance(c, int):
        return (0, c)
    a, s = c
    return (int(a), None if s is None else int(s))


class DmgFrame:
    """Кадр для эфира: вид, TA, RA, длина PSDU, MCS, Duration (мкс), прочие поля (dict) и, при надобности,
    собственная длительность на эфире (напр. PPDU с TRN, brp.brp_txtime)."""
    __slots__ = ('kind', 'src', 'dst', 'length', 'mcs', 'dur', 'fields', '_airtime')

    def __init__(self, kind, src, dst, length=26, mcs=0, dur=0, fields=None, airtime=None):
        self.kind, self.src, self.dst, self.length, self.mcs, self.dur = kind, src, dst, length, mcs, dur
        self.fields = dict(fields or {})
        self._airtime = None if airtime is None else Fr(airtime)

    @property
    def airtime(self):
        """20.11.3 TXTIME (timing.txtime), если не задана явно."""
        return self._airtime if self._airtime is not None else txtime(self.length, int(self.mcs))

    def __repr__(self):
        return f'{self.kind}({self.src}->{self.dst}, mcs={self.mcs})'


class RxResult:
    """Итог PPDU у одного приёмника: arr — [s, e) прихода; power — уровень в конфигурации RX начала, дБм;
    locked — синхронизация на заголовок; decoded; reason: 'ok' | 'half-duplex' | 'off' | 'no-lock' |
    'sensitivity' | 'collision'; rx_cfgs — конфигурации RX, действовавшие на [s, e)."""
    __slots__ = ('addr', 'arr', 'power', 'locked', 'decoded', 'reason', 'rx_cfgs', 'interferers')

    def __init__(self, addr, arr):
        self.addr, self.arr = addr, arr
        self.power, self.locked, self.decoded, self.reason, self.rx_cfgs, self.interferers = \
            NEG_INF, False, False, None, [], []

    def __repr__(self):
        return f'Rx({self.addr}: {self.reason}, {self.power} dBm)'


class AirEntry:
    """Запись журнала: t_start/t_end — у передатчика «на эфире» (10.3.7), src, dst, kind, dur, mcs, fields,
    tx_cfg, tx_power, frame; rx — addr → RxResult; receivers — кто декодировал (по мере окончаний прихода)."""
    def __init__(self, n, t, src, frame, tx_cfg, tx_power):
        self.n, self.t_start, self.t_end = n, t, t + Fr(frame.airtime)
        self.src, self.frame, self.tx_cfg, self.tx_power = src, frame, tx_cfg, tx_power
        self.dst, self.kind = getattr(frame, 'dst', None), getattr(frame, 'kind', None)
        self.dur, self.mcs = getattr(frame, 'dur', 0), getattr(frame, 'mcs', 0)
        self.fields = dict(getattr(frame, 'fields', None) or {})
        self.rx = {}
        self.receivers = []

    def as_air_tuple(self, cbap_end=None):
        """Формат журнала cbap.Air / cbap.check_air_log."""
        return (self.t_start, self.t_end, self.src, self.dst, self.kind, self.dur, cbap_end)

    def __repr__(self):
        return (f'AirEntry(#{self.n} {self.t_start}..{self.t_end} {self.src}->{self.dst} {self.kind} '
                f'tx={self.tx_cfg} rx={self.receivers})')


class _Sta:
    def __init__(self, addr, antennas, tx_power_dbm, agent, rx_cfg, tx_cfg):
        self.addr, self.agent, self.tx_power = addr, agent, tx_power_dbm
        self.sectors = {}
        total = 0
        for a, s in antennas.items():
            if not 0 <= a < MAX_ANTENNAS:
                raise ValueError(f'{addr}: DMG Antenna ID {a} вне 0…3 (9.5.1)')
            ids = set(range(s)) if isinstance(s, int) else set(s)
            if len(ids) > MAX_SECTORS_PER_ANT or any(not 0 <= i < 64 for i in ids):
                raise ValueError(f'{addr}: антенна {a}: > 64 секторов или Sector ID вне 0…63 (10.42.1, 9.5.1)')
            self.sectors[a] = ids
            total += len(ids)
        if total > MAX_SECTORS_PER_STA:
            raise ValueError(f'{addr}: всего секторов {total} > 128 (10.42.1)')
        self.rx_hist = [(Fr(0), rx_cfg)]     # (t, cfg) по времени; cfg None — приёмник выключен
        self.tx_cfg = tx_cfg
        self.tx = []                         # свои AirEntry (интервалы передачи)
        self.cur_tx = None
        self.cca = False

    def check_cfg(self, c):
        if c is None:
            return
        a, s = c
        if a not in self.sectors:
            raise ValueError(f'{self.addr}: нет DMG-антенны {a}')
        if s is not None and s not in self.sectors[a]:
            raise ValueError(f'{self.addr}: нет сектора {s} у антенны {a}')

    def rx_at(self, t):
        c = self.rx_hist[0][1]
        for tt, cc in self.rx_hist:
            if tt > t:
                break
            c = cc
        return c

    def rx_during(self, s, e):
        """Конфигурации RX, действовавшие на [s, e)."""
        out = [self.rx_at(s)]
        for tt, cc in self.rx_hist:
            if s < tt < e:
                out.append(cc)
        return out

    def tx_during(self, s, e):
        return any(x.t_start < e and s < x.t_end for x in self.tx)

    def tx_at(self, t):
        return any(x.t_start <= t < x.t_end for x in self.tx)


# приоритеты событий в один момент: концы прихода, концы передачи, смены конфигурации, таймеры, начала
# передачи, начала прихода (начало прихода — после начала собственной передачи приёмника в тот же момент)
_P_ARR_END, _P_TX_END, _P_CFG, _P_TIMER, _P_TX_START, _P_ARR_START = range(6)


class Medium:
    """Направленный эфир DMG (см. докстроку модуля)."""
    def __init__(self, prop=Fr(0), capture_db=0, lock_dbm=None, ed_dbm=CCA_ED_DBM, default_gain=NEG_INF):
        self.prop, self.capture_db, self.ed_dbm, self.default_gain = Fr(prop), capture_db, ed_dbm, default_gain
        if self.prop > MAX_PROP_ONE_WAY:
            raise ValueError('задержка > aAirPropagationTime/2 (табл. 20-30)')
        # пороги синхронизации на заголовок (выбор модели, см. докстроку)
        self.lock_dbm = lock_dbm or {'control': SENSITIVITY_DBM['0'], 'sc': CCA_SC_DBM}
        self.st = {}
        self.gain = {}
        self.delay = {}
        self.log = []
        self.arrivals = {}                   # rx → [(s, e, entry)]
        self.q = []
        self.seq = 0
        self.now = Fr(0)

    # ---------------- конфигурация ----------------
    def add_station(self, addr, antennas=None, tx_power_dbm=0, agent=None, rx_cfg=(0, None), tx_cfg=(0, None)):
        st = _Sta(addr, antennas or {0: MAX_SECTORS_PER_ANT}, tx_power_dbm, agent,
                  None if rx_cfg is None else norm_cfg(rx_cfg), norm_cfg(tx_cfg))
        st.check_cfg(st.rx_hist[0][1])
        st.check_cfg(st.tx_cfg)
        self.st[addr] = st
        self.arrivals[addr] = []
        return st

    def set_gain(self, tx, tx_cfg, rx, rx_cfg, db, reciprocal=False):
        """Усиление звена (дБ, включая антенны и трассу). reciprocal — то же в обратную сторону (взаимность
        антенн, 9.4.2.127 Antenna Pattern Reciprocity — предположение модели, не правило)."""
        tc, rc = norm_cfg(tx_cfg), norm_cfg(rx_cfg)
        for a, c in ((tx, tc), (rx, rc)):
            if c is not ANY:
                self.st[a].check_cfg(c)
        self.gain[(tx, tc, rx, rc)] = db
        if reciprocal:
            self.gain[(rx, rc, tx, tc)] = db

    def link_gain(self, tx, tx_cfg, rx, rx_cfg):
        """Поиск: точная запись, (tx_cfg, ANY), (ANY, rx_cfg), (ANY, ANY), иначе default_gain (−∞ — нет связи)."""
        if rx_cfg is None:
            return NEG_INF
        g = self.gain
        for k in ((tx, tx_cfg, rx, rx_cfg), (tx, tx_cfg, rx, ANY), (tx, ANY, rx, rx_cfg), (tx, ANY, rx, ANY)):
            if k in g:
                return g[k]
        return self.default_gain

    def rx_power(self, tx, tx_cfg, rx, rx_cfg):
        """Уровень на входе приёмника, дБм."""
        return self.st[tx].tx_power + self.link_gain(tx, norm_cfg(tx_cfg), rx,
                                                     None if rx_cfg is None else norm_cfg(rx_cfg))

    def set_delay(self, a, b, d):
        d = Fr(d)
        if d < 0 or d > MAX_PROP_ONE_WAY:
            raise ValueError('задержка вне [0, aAirPropagationTime/2] (табл. 20-30)')
        self.delay[(a, b)] = self.delay[(b, a)] = d

    def delay_of(self, a, b):
        return self.delay.get((a, b), self.prop)

    def set_tx_power(self, addr, dbm):
        self.st[addr].tx_power = dbm

    # ---------------- события ----------------
    def _push(self, t, prio, fn, *args):
        t = Fr(t)
        if t < self.now:
            raise ValueError(f'событие в прошлом: {t} < {self.now}')
        self.seq += 1
        heapq.heappush(self.q, (t, prio, self.seq, fn, args))

    def at(self, t, fn, *args):
        """Таймер: fn(t, *args) в момент t."""
        self._push(t, _P_TIMER, lambda tt, *a: fn(tt, *a), *args)

    def set_rx(self, addr, cfg, t=None):
        """Конфигурация приёма с момента t (None — сейчас): (ant, sector|None) или None — приёмник выключен."""
        st = self.st[addr]
        c = None if cfg is None else norm_cfg(cfg)
        st.check_cfg(c)
        self._push(self.now if t is None else t, _P_CFG, self._do_rx, addr, c)

    def _do_rx(self, t, addr, c):
        h = self.st[addr].rx_hist
        if h[-1][0] == t:
            h[-1] = (t, c)
        else:
            h.append((t, c))

    def set_tx(self, addr, cfg, t=None):
        """Конфигурация передачи по умолчанию (для transmit без tx_cfg) с момента t."""
        c = norm_cfg(cfg)
        self.st[addr].check_cfg(c)
        self._push(self.now if t is None else t, _P_CFG, lambda tt, a, cc: setattr(self.st[a], 'tx_cfg', cc),
                   addr, c)

    def transmit(self, src, frame, t=None, tx_cfg=None):
        """Начать PPDU frame от src в момент t (≥ now). tx_cfg — конфигурация на весь PPDU (иначе текущая
        set_tx). Возвращает AirEntry (заполняется при начале)."""
        holder = {}
        c = None if tx_cfg is None else norm_cfg(tx_cfg)
        if c is not None:
            self.st[src].check_cfg(c)
        self._push(self.now if t is None else t, _P_TX_START, self._do_tx, src, frame, c, holder)
        return _Pending(holder)

    def _do_tx(self, t, src, frame, c, holder):
        st = self.st[src]
        if st.cur_tx is not None:
            raise RuntimeError(f'{src}: новый PPDU при незавершённом своём (полудуплекс, один PPDU за раз)')
        e = AirEntry(len(self.log) + 1, t, src, frame, c if c is not None else st.tx_cfg, st.tx_power)
        holder['e'] = e
        self.log.append(e)
        st.tx.append(e)
        st.cur_tx = e
        self._push(e.t_end, _P_TX_END, self._do_tx_end, e)
        for r in self.st:
            if r == src:
                continue
            d = self.delay_of(src, r)
            arr = (t + d, e.t_end + d)
            e.rx[r] = RxResult(r, arr)
            self.arrivals[r].append((arr[0], arr[1], e))
            self._push(arr[0], _P_ARR_START, self._do_arr_start, e, r)
            self._push(arr[1], _P_ARR_END, self._do_arr_end, e, r)

    def _do_tx_end(self, t, e):
        st = self.st[e.src]
        st.cur_tx = None
        cb = getattr(st.agent, 'on_tx_end', None)
        if cb:
            cb(t, e)

    def _power(self, e, r, cfg):
        if cfg is None:
            return NEG_INF
        return e.tx_power + self.link_gain(e.src, e.tx_cfg, r, cfg)

    def _do_arr_start(self, t, e, r):
        st, res = self.st[r], e.rx[r]
        cfg = st.rx_at(t)
        res.power = self._power(e, r, cfg) if cfg is not None else NEG_INF
        # 20.8: синхронизация по STF/заголовку — только если STA слушает (не передаёт) в начале PPDU
        res.locked = (cfg is not None and not st.tx_at(t)
                      and res.power >= self.lock_dbm[phy_mode(e.mcs)])
        if res.locked:
            cb = getattr(st.agent, 'on_rx_start', None)
            if cb:
                cb(t, e, res.power)

    def _do_arr_end(self, t, e, r):
        st, res = self.st[r], e.rx[r]
        s, en = res.arr
        res.rx_cfgs = st.rx_during(s, en)
        if st.tx_during(s, en):
            res.reason = 'half-duplex'                 # STA передаёт — не принимает
        elif any(c is None for c in res.rx_cfgs):
            res.reason = 'off'
        elif not res.locked:
            res.reason = 'no-lock'
        else:
            p = min(self._power(e, r, c) for c in res.rx_cfgs)
            if p < sensitivity(e.mcs):                 # табл. 20-3
                res.reason = 'sensitivity'
            else:
                res.reason = 'ok'
                for s2, e2, q in self.arrivals[r]:
                    if q is e or not (s2 < en and s < e2):
                        continue
                    pq = max(self._power(q, r, c) for c in st.rx_during(max(s, s2), min(en, e2)) if c is not None)
                    res.interferers.append((q.n, pq))
                    if not p > pq + self.capture_db:  # выбор модели: захват строго более сильным
                        res.reason = 'collision'
        res.decoded = res.reason == 'ok'
        if res.decoded:
            e.receivers.append(r)
        if res.locked or res.decoded:
            cb = getattr(st.agent, 'on_rx_end', None)
            if cb:
                cb(t, e, e.frame if res.decoded else None, res)

    # ---------------- CCA ----------------
    def cca_info(self, addr, t=None):
        """(занято, причины) у addr в момент t: 'tx', 'locked:#n', 'ed:#n' (см. докстроку модуля)."""
        t = self.now if t is None else Fr(t)
        st = self.st[addr]
        why = []
        if st.tx_at(t):
            why.append('tx')
        cfg = st.rx_at(t)
        for s, en, e in self.arrivals[addr]:
            if not s <= t < en:
                continue
            res = e.rx[addr]
            if res.locked:
                why.append(f'locked:#{e.n}')       # 20.8: занято до ожидаемого конца PPDU
            elif cfg is not None and self._power(e, addr, cfg) >= self.ed_dbm:
                why.append(f'ed:#{e.n}')           # 20.5.4.2.2: «20 dB above the minimum sensitivity for MCS 1»
        return bool(why), why

    def cca(self, addr, t=None):
        return self.cca_info(addr, t)[0]

    def _update_cca(self, t):
        for a, st in self.st.items():
            cb = getattr(st.agent, 'on_cca', None)
            if cb is None:
                continue
            b = self.cca(a, t)
            if b != st.cca:
                st.cca = b
                cb(t, b)

    # ---------------- ход ----------------
    def run(self, until):
        """Обработать события до момента until включительно; вернуть AirEntry, начатые в этом вызове."""
        until = Fr(until)
        n0 = len(self.log)
        while self.q and self.q[0][0] <= until:
            t = self.q[0][0]
            self.now = t
            while self.q and self.q[0][0] == t:
                _, _, _, fn, args = heapq.heappop(self.q)
                fn(t, *args)
            self._update_cca(t)
        self.now = max(self.now, until)
        return self.log[n0:]

    def air_log(self):
        return [e.as_air_tuple() for e in self.log]


class _Pending:
    """Ссылка на AirEntry, который появится в момент начала PPDU."""
    __slots__ = ('_h',)

    def __init__(self, h):
        self._h = h

    @property
    def entry(self):
        return self._h.get('e')

    def __getattr__(self, k):
        e = self._h.get('e')
        if e is None:
            raise AttributeError(f'{k}: PPDU ещё не начат')
        return getattr(e, k)


def check_quasi_omni(m, tol_db=QO_MAX_LOSS_DB):
    """20.9.1: усиление квази-омни ≤ 15 дБ ниже направленного. Для каждой явной записи таблицы с квази-омни на
    одной стороне сравнивает с лучшим сектором той же антенны при той же другой стороне. Возвращает нарушения
    [(tx, tx_cfg, rx, rx_cfg, qo_db, best_sector_db)]."""
    out = []
    for (tx, tc, rx, rc), g in m.gain.items():
        for side in (0, 1):
            c = (tc, rc)[side]
            if c is ANY or c[1] is not None:
                continue
            best = max((g2 for (tx2, tc2, rx2, rc2), g2 in m.gain.items()
                        if (tx2, rx2) == (tx, rx) and ((tc2, rc2)[1 - side] == (tc, rc)[1 - side])
                        and (tc2, rc2)[side] is not ANY and (tc2, rc2)[side][0] == c[0]
                        and (tc2, rc2)[side][1] is not None), default=None)
            if best is not None and g < best - tol_db:
                out.append((tx, tc, rx, rc, g, best))
    return out
