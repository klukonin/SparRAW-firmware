# SPDX-License-Identifier: AGPL-3.0-or-later
"""Доступ к среде DMG STA в CBAP по 802.11-2020: EDCA backoff (10.23.2.2), получение TXOP (10.23.2.4, 10.3.7),
NAV (10.3.2.4, 10.23.2.10), несколько кадров в TXOP и лимит TXOP (10.23.2.8, 10.23.2.9), правила DTI/CBAP
(10.39.4, 10.39.5). Время — Fraction, мкс; все моменты — «на эфире» (10.3.7: конец последнего символа PPDU,
начало первого символа преамбулы). Граница слота на эфире = граница MAC + aRxTxTurnaroundTime, поэтому первая
граница после занятости — ровно AIFS[AC] (рис. 10-25: «aSIFSTime + 3 × aSlotTime» при AIFSN 2 и счётчике 1).

Состав:
  EdcaParams, DEFAULT_EDCA       — табл. 9-155 (строка «Other PHYs» для DMG: TXOP limit 0).
  Edcaf                          — CW, QSRC, счётчик backoff, вызов backoff по событиям a–e (10.23.2.2).
  Nav                            — единый NAV DMG STA (10.3.2.4) + CF-End DMG (10.23.2.10) + сброс по RTS.
  Station                        — STA с EDCAF, CBAP-окнами, TXOP, ответами; события → решения «передавать в t».
  Air                            — дискретно-событийный эфир (все слышат всех) для нескольких Station → журнал.
  check_air_log(events, params)  — проверка журнала эфира, список нарушений.

Не моделируется: несколько NAV (10.39.10), режим прослушивания SP (10.39.6.6), EIFS по dynamic EIFS, PIFS-
восстановление (10.23.2.8) и PIFS-старт источника CBAP (10.39.5) — см. докстроки."""
import copy
import heapq
import random
from fractions import Fraction as Fr
from math import ceil, floor

from .timing import (aAirPropagationTime, aCWmax, aCWmin, aifs, aRxPHYStartDelay, aSlotTime, BCAST, DIFS, PIFS, SIFS,
                     SIFS_TOL, txtime, txtime_control)

INF = float('inf')

# ---- 10.3.7 ----
# PIFS (10-5), DIFS (10-6), SIFS_TOL (10.3.2.3.3), BCAST — timing.py
# (10-7) EIFS = aSIFSTime + AckTxTime + DIFS; AckTxTime — Ack (14 октетов) на наименьшей обязательной MCS (MCS 0)
EIFS = SIFS + txtime_control(14) + DIFS

# ---- длины кадров управления, октеты (9.3.1) ----
LEN = {
    'RTS': 20,          # рис. 9-26: FC 2 + Duration 2 + RA 6 + TA 6 + FCS 4
    'DMG CTS': 20,      # 9.3.1.13, рис. 9-52
    'CF-End': 20,       # рис. 9-34
    'Ack': 14,          # рис. 9-28: FC + Duration + RA + FCS
    'BlockAck': 32,     # 9.3.1.8, Compressed: + BA Control 2 + SSC 2 + Bitmap 8
    'BlockAckReq': 24,  # 9.3.1.7, Compressed: + BAR Control 2 + SSC 2
}
# 10.6.7.1: «RTS, DMG CTS, DMG CTS-to-self, DMG DTS, CF-End … shall be transmitted using the DMG Control»
CONTROL_KINDS = ('RTS', 'DMG CTS', 'CF-End')
# ответы, требующие SIFS (10.3.2.3.3), по виду вызвавшего кадра
RESPONSES = {'RTS': ('DMG CTS',), 'Data': ('Ack', 'BlockAck'), 'A-MPDU': ('BlockAck', 'Ack'),
             'BlockAckReq': ('BlockAck',), 'CF-End': ('CF-End',)}
DATA_KINDS = ('Data', 'A-MPDU')

# ---- табл. 10-1 (приоритет AC) и табл. 9-155 ----
AC_BK, AC_BE, AC_VI, AC_VO = 'AC_BK', 'AC_BE', 'AC_VI', 'AC_VO'
AC_PRIO = {AC_BK: 0, AC_BE: 1, AC_VI: 2, AC_VO: 3}   # табл. 10-1: BK — «Lowest», VO — «Highest»


class EdcaParams:
    """CWmin, CWmax, AIFSN, TXOP limit (мкс; 0 — особый смысл, 10.23.2.9)."""
    def __init__(self, cwmin=aCWmin, cwmax=aCWmax, aifsn=3, txop_limit=0):
        # 10.23.2.4: «AIFSN[AC] shall be greater than or equal to 2 for non-AP STAs»; ≥ 1 для AP
        assert aifsn >= 1
        self.cwmin, self.cwmax, self.aifsn, self.txop_limit = cwmin, cwmax, aifsn, Fr(txop_limit)

    def __repr__(self):
        return f'EdcaParams({self.cwmin}, {self.cwmax}, {self.aifsn}, {self.txop_limit})'


# Табл. 9-155 (dot11OCBActivated false): DMG (Clause 20) — столбец «Other PHYs», TXOP limit 0.
DEFAULT_EDCA = {
    AC_BK: EdcaParams(aCWmin, aCWmax, 7, 0),
    AC_BE: EdcaParams(aCWmin, aCWmax, 3, 0),
    AC_VI: EdcaParams((aCWmin + 1) // 2 - 1, aCWmin, 2, 0),
    AC_VO: EdcaParams((aCWmin + 1) // 4 - 1, (aCWmin + 1) // 2 - 1, 2, 0),
}

DOT11_SHORT_RETRY_LIMIT = 7                 # MIB: dot11ShortRetryLimit DEFVAL { 7 }


def ceil_us(x):
    """9.2.5.1: дробная мкс — вверх, отрицательное — 0."""
    return max(0, ceil(x))


def resp_mcs(elicit_mcs):
    """10.6.7.2: ответ на Control mode — Control mode; на SC — наибольшая обязательная MCS SC (≤ 4, 20.5.3.1.2:
    «MCS 4 and below is mandatory») со скоростью не выше вызвавшего кадра."""
    return 0 if elicit_mcs == 0 else min(elicit_mcs, 4)


def response_timeout(elicit_mcs):
    """10.3.2.11 / 10.3.2.9: AckTimeout = CTSTimeout = aSIFSTime + aSlotTime + aRxPHYStartDelay (от
    PHY-TXEND.confirm); aRxPHYStartDelay — по режиму ответа (табл. 20-30)."""
    mode = 'control' if resp_mcs(elicit_mcs) == 0 else 'sc'
    return SIFS + aSlotTime + aRxPHYStartDelay[mode]


T_DMG_CTS = txtime_control(LEN['DMG CTS'])
T_CF_END = txtime_control(LEN['CF-End'])
# 10.3.2.4: DMG NAVTimeout = 2·aSIFSTime + T_DMG-CTS + StartDelayCompensation (= aSlotTime) + 2·aSlotTime
NAV_TIMEOUT = 2 * SIFS + T_DMG_CTS + aSlotTime + 2 * aSlotTime


class Frame:
    """Кадр (PPDU с одним MPDU или A-MPDU): вид, TA, RA, длина PSDU, MCS, Duration (мкс)."""
    __slots__ = ('kind', 'src', 'dst', 'length', 'mcs', 'dur', 'ack')

    def __init__(self, kind, src, dst, length=None, mcs=None, dur=0, ack=True):
        self.kind, self.src, self.dst, self.dur, self.ack = kind, src, dst, dur, ack
        self.length = LEN.get(kind, 0) if length is None else length
        self.mcs = 0 if kind in CONTROL_KINDS else (4 if mcs is None else mcs)

    @property
    def airtime(self):
        return txtime(self.length, self.mcs)

    def needs_response(self):
        """10.3.2.11: немедленный ответ — индивидуальные Data (Normal Ack), BlockAckReq; 10.3.2.9 — RTS."""
        if self.kind == 'RTS':
            return True
        if self.kind in DATA_KINDS + ('BlockAckReq',):
            return self.dst != BCAST and self.ack
        return False

    def is_response_to(self, prev):
        """Кадр — ответ на prev по виду и адресам (CF-End-ответ: RA — TA prev или широковещательный, 9.3.1.6)."""
        if prev is None or self.kind not in RESPONSES.get(prev.kind, ()) or self.src != prev.dst:
            return False
        if prev.kind == 'CF-End':
            return prev.dur != 0 and self.dst in (prev.src, BCAST)
        return self.dst == prev.src

    def __repr__(self):
        return f'{self.kind}({self.src}->{self.dst}, dur={self.dur})'


class Msdu:
    """Элемент очереди: обмен Data[/A-MPDU] (+Ack/BlockAck), опционально под RTS/DMG CTS."""
    def __init__(self, dst, length=1500, mcs=4, rts=False, ack=True, agg=False):
        self.dst, self.length, self.mcs, self.rts, self.ack, self.agg = dst, length, mcs, rts, ack, agg
        self.retries = 0                     # 10.23.2.12.1: frame retry count

    @property
    def kind(self):
        return 'A-MPDU' if self.agg else 'Data'

    def t_data(self):
        return txtime(self.length, self.mcs)

    def t_resp(self):
        if not self.ack or self.dst == BCAST:
            return Fr(0)
        return txtime(LEN['BlockAck' if self.agg else 'Ack'], resp_mcs(self.mcs))

    def exchange_time(self, with_rts=None):
        """Длительность обмена на эфире, включая ответы и SIFS (10.39.5: «including any control frame responses»)."""
        rts = self.rts if with_rts is None else with_rts
        t = self.t_data()
        if self.t_resp():
            t += SIFS + self.t_resp()
        if rts:
            t += txtime_control(LEN['RTS']) + SIFS + T_DMG_CTS + SIFS
        return t


# ---- генераторы backoff: объект с draw(cw) → 0..cw (10.23.2.4: «uniform distribution … 0 to CW[AC]») ----
class Rng:
    def __init__(self, seed=0):
        self.r = random.Random(seed)

    def draw(self, cw):
        return self.r.randint(0, cw)


class SeqRng:
    """Заданная последовательность значений backoff (для тестов); проверяет диапазон 0..CW."""
    def __init__(self, values):
        self.values, self.i, self.cws = list(values), 0, []

    def draw(self, cw):
        v = self.values[self.i]
        self.i += 1
        self.cws.append(cw)
        assert 0 <= v <= cw, (v, cw)
        return v


class Edcaf:
    """EDCAF одной AC: CW[AC], QSRC[AC], счётчик backoff, очередь (10.23.2.2, 10.23.2.4)."""
    def __init__(self, ac, p, rng, retry_limit=DOT11_SHORT_RETRY_LIMIT):
        self.ac, self.p, self.rng, self.retry_limit = ac, p, rng, retry_limit
        self.cw = p.cwmin                    # «CW[AC], which shall be initialized to … CWmin[AC]»
        self.qsrc = 0                        # 10.23.2.12.1: «initial value for the QSRC[AC] counters shall be 0»
        self.backoff = 0
        self.queue = []
        self.log = []                        # (причина, CW, QSRC, backoff) — для тестов

    def invoke_backoff(self, reason):
        """10.23.2.2: a) — CW, QSRC без изменений; b) — CW = CWmin, QSRC = 0; c), d), e) — если QSRC <
        dot11ShortRetryLimit: QSRC += 1, CW = min(CWmax, 2^QSRC·(CWmin+1) − 1) (степень — по PDF с. 1739, в .txt
        «2QSRC»), иначе QSRC = 0, CW = CWmin.
        10.23.2.4: счётчик — равновероятно 0..CW[AC]."""
        assert reason in 'abcde'
        if reason == 'b':
            self.cw, self.qsrc = self.p.cwmin, 0
        elif reason in 'cde':
            if self.qsrc < self.retry_limit:
                self.qsrc += 1
                self.cw = min(self.p.cwmax, 2 ** self.qsrc * (self.p.cwmin + 1) - 1)
            else:
                self.qsrc, self.cw = 0, self.p.cwmin
        self.backoff = self.rng.draw(self.cw)
        self.log.append((reason, self.cw, self.qsrc, self.backoff))
        return self.backoff


class Nav:
    """Единый NAV DMG STA (10.3.2.4 — «DMG STAs that support a single NAV»); конец NAV — момент на эфире.

    Сохраняет адрес держателя TXOP (10.23.2.4) для ответа DMG CTS «without regard for … its NAV»."""
    def __init__(self, addr, rts_reset=True):
        self.addr, self.rts_reset = addr, rts_reset
        self.end = Fr(0)
        self.rts_end = None                  # PHY-RXEND RTS, если RTS — последняя основа NAV
        self.rx_after_rts = False
        self.holder = None
        self.frozen = False                  # 10.39.5: при приостановке EDCAF NAV не меняется

    def idle_from(self):
        """Момент освобождения NAV при отсутствии новых событий. 10.3.2.4: STA, обновившая NAV по RTS, «is
        permitted to reset its NAV if no PHY-RXSTART.indication … during a NAVTimeout» (rts_reset — выбор)."""
        if self.rts_reset and self.rts_end is not None and not self.rx_after_rts:
            return min(self.end, self.rts_end + NAV_TIMEOUT)
        return self.end

    def busy(self, t):
        return self.idle_from() > t

    def rx_start(self, t):
        if self.rts_end is not None and t <= self.rts_end + NAV_TIMEOUT:
            self.rx_after_rts = True

    def rx(self, t_end, f):
        """Обновление по PHY-RXEND корректного кадра f."""
        if self.frozen:
            return
        if f.kind == 'CF-End':
            # 10.23.2.10: DMG — «resets its NAV to 0 at the end of the time interval indicated in the … Duration/ID
            # field … starts at PHY-RXEND»; «shall not transmit during the interval if the RA … not equal»
            self.end, self.rts_end = t_end + f.dur, None
            if f.dur == 0:
                self.holder = None
            return
        if f.dst == self.addr:               # «When the received frame’s RA is equal to the STA’s own MAC address,
            return                           # the STA shall not update its NAV»
        if f.kind == 'DMG CTS' and f.src == self.addr:   # «DMG CTS frame and its TA is equal to … own» — нет
            return
        if f.kind in ('RTS',) + DATA_KINDS + ('BlockAckReq',):
            self.holder = f.src              # 10.23.2.4: TXOP holder = Address 2 кадра, начавшего обмен
        elif f.kind == 'DMG CTS' and f.dst == f.src:
            self.holder = f.dst              # «except when this is a CTS frame, … the Address 1 field»
        if t_end + f.dur > self.idle_from():  # «update its NAV when the received Duration is greater than … current»
            self.end = t_end + f.dur
            self.rts_end, self.rx_after_rts = (t_end, False) if f.kind == 'RTS' else (None, False)

    def idle_for_rts(self, t, ta):
        """10.3.2.9: «NAV indicates idle» — NAV 0 или NAV ≠ 0, но TA RTS = сохранённый адрес держателя TXOP
        (адрес очищается при сбросе NAV или отсчёте до 0, 10.23.2.4)."""
        if not self.busy(t):
            self.holder = None
            return True
        return ta == self.holder

    def shift(self, e, s2):
        """10.39.5: NAV не меняется с конца CBAP e до начала следующего s2 — остаток переносится."""
        d = s2 - e
        if self.end > e:
            self.end += d
        if self.rts_end is not None and self.rts_end + NAV_TIMEOUT > e:
            self.rts_end += d


class _Txop:
    def __init__(self, ed, start, dst):
        self.ed, self.start, self.dst = ed, start, dst
        self.seq = []                        # кадры текущего MSDU, ещё не переданные
        self.initial = True                  # ещё не было успешного PPDU (10.23.2.2 c)
        self.cf_end = False


class Station:
    """DMG STA (не AP/PCP) с EDCAF; методы-события (момент t не убывает):
      enqueue(t, msdu, ac)   — MA-UNITDATA.request (10.23.2.2 a)
      rx_start(t)            — PHY-RXSTART / CCA busy от чужого PPDU
      rx_end(t, frame|None)  — PHY-RXEND (None — ошибка приёма/коллизия → EIFS, 10.3.2.3.7)
      start(t) → Frame       — начать передачу в момент, выданный next_action()
      tx_end(t)              — PHY-TXEND.confirm
      timeout(t)             — истёк AckTimeout/CTSTimeout
    next_action() → (t, 'tx'|'timeout') | None — ближайшее собственное действие, если других событий не будет.

    Порядок одновременных событий: границы слотов ≤ t обрабатываются до события в момент t (решение на границе
    уже принято, 10.23.2.4 — «on these specific slot boundaries»).

    Параметры выбора реализации:
      cbaps — список CBAP (start, end) или None (весь DTI — CBAP). Граница слота ровно в конце CBAP не
        обрабатывается («suspended at the end of a CBAP»).
      resume_aifs — после возобновления в начале CBAP нужен AIFS свободной среды от его начала (стандарт не
        говорит, сколько ждать; принято как после конца занятости, 10.23.2.4 e).
      rts_nav_reset — сброс NAV по RTS без PHY-RXSTART за NAVTimeout («is permitted», 10.3.2.4).
      noninitial_failure — сбой не первого PPDU TXOP: 'backoff' (10.23.2.2 e, «may») или 'txnav' (ждать TXNAV,
        затем b). PIFS-восстановление (10.23.2.8) не моделируется.
      protection — 'single' или 'multiple' (9.2.5.2); при 'multiple' Duration — нижняя граница 9.2.5.2 b) 3)/4),
        при full_txop — верхняя (T_TXOP − T_PPDU, T_TXOP-REMAINING − T_PPDU).
      cf_end — завершать TXOP кадром CF-End при пустой очереди (10.23.2.10, «may»).
      respond_cf_end — отвечать CF-End на CF-End с RA = своему адресу и Duration ≠ 0 (10.23.2.10, «may»)."""

    def __init__(self, addr, edca=None, rng=None, cbaps=None, retry_limit=DOT11_SHORT_RETRY_LIMIT,
                 resume_aifs=True, rts_nav_reset=True, noninitial_failure='backoff', protection='single',
                 full_txop=False, cf_end=False, respond_cf_end=True):
        self.addr = addr
        rng = rng or Rng()
        # 10.23.2.1: «A DMG STA … may implement a single AC … all UP … mapped to AC_BE» — по умолчанию одна AC_BE
        edca = edca or {AC_BE: DEFAULT_EDCA[AC_BE]}
        self.edcafs = {ac: Edcaf(ac, p, rng, retry_limit) for ac, p in edca.items()}
        self.nav = Nav(addr, rts_nav_reset)
        self.cbaps = None if cbaps is None else sorted((Fr(s), Fr(e)) for s, e in cbaps)
        self.resume_aifs, self.noninitial_failure = resume_aifs, noninitial_failure
        self.protection, self.full_txop = protection, full_txop
        self.cf_end, self.respond_cf_end = cf_end, respond_cf_end
        self.done = Fr(0)                    # границы слотов ≤ done обработаны
        self.rx_n = 0                        # число чужих PPDU на эфире (физический CS)
        self.cs_idle, self.cs_err, self.busy_err = Fr(0), False, False
        self.tx = None                       # (t_start, t_end, frame, роль)
        self.wait = None                     # ожидание ответа: dict(frame, t_end, deadline, rx)
        self.sched = None                    # (t, frame, роль) — передача через SIFS
        self.txnav_end = Fr(0)               # 10.23.2.2: TXNAV
        self.txop = None
        self.b_due = None                    # (момент, Edcaf): отложенный вызов backoff b)
        self.recover_ac = None               # 10.23.2.2 e): backoff внутри TXOP — TXNAV не мешает держателю
        self.suspended, self.wi, self.susp_at = self.cbaps is not None, 0, None
        self.nav.frozen = self.suspended
        self.delivered, self.discarded = [], []

    # ---------------- окна CBAP ----------------
    def window(self):
        if self.cbaps is None:
            return (-INF, INF)
        return self.cbaps[self.wi] if self.wi < len(self.cbaps) else None

    def _suspend(self, e):
        # 10.39.5: «Operation of the EDCAF is suspended at the end of a CBAP … backoff and NAVs shall remain
        # unchanged until the start of the following CBAP»
        self.suspended, self.susp_at = True, e
        self.nav.frozen = True
        self.wi += 1

    def _resume(self, s):
        if self.susp_at is not None:
            self.nav.shift(self.susp_at, s)
        self.nav.frozen = False
        self.suspended = False
        self.done = max(self.done, s)

    # ---------------- границы слотов (10.23.2.4) ----------------
    def medium_busy(self, t):
        """10.23.2.2 a) 4): физический CS, виртуальный CS (NAV), ненулевой TXNAV; 10.3.2.1: своя передача."""
        return self.rx_n > 0 or self.tx is not None or self.nav.busy(t) or self.txnav_end > t

    def _b0(self, ed, s):
        """Первая граница слота: AIFS[AC] свободной среды после последней занятости (10.23.2.4 a, e), после
        ошибки приёма — EIFS − DIFS + AIFS[AC] (b), после NAV (виртуальный CS) и истечения TXNAV (d), после
        начала CBAP (resume_aifs)."""
        a = aifs(ed.p.aifsn)
        b0 = self.cs_idle + (EIFS - DIFS + a if self.cs_err else a)
        b0 = max(b0, self.nav.idle_from() + a)
        if self.recover_ac != ed.ac:         # 10.23.2.8: «All other channel access functions … treat the medium
            b0 = max(b0, self.txnav_end + a)  # as busy until the expiration of the TXNAV timer»
        return max(b0, s + (a if self.resume_aifs else 0))

    def _next_b(self, ed, s, e):
        if self.suspended or self.rx_n or self.tx or self.wait or self.sched or self.txop:
            return None
        if ed.backoff == 0 and not ed.queue:  # граница без действия («Do nothing») — пропуск
            return None
        b0 = self._b0(ed, s)
        k = 0 if self.done < b0 else floor((self.done - b0) / aSlotTime) + 1   # 10.23.2.4 f): шаг aSlotTime
        B = b0 + k * aSlotTime
        return B if B < e else None

    def _fits(self, B, ed):
        """10.39.4/10.39.5: обмен, включая ответы, должен завершиться до конца CBAP."""
        w = self.window()
        return B + ed.queue[0].exchange_time() <= w[1]

    def _fits_txnav(self, B, ed):
        """Backoff e) внутри TXOP («shall not extend the TXNAV timer value»): кадр + ответ — в остатке TXNAV
        (как 10.23.2.8); иначе передача — только после истечения TXNAV, обычным доступом."""
        if ed.ac != self.recover_ac or B >= self.txnav_end:
            return True
        return B + ed.queue[0].exchange_time() < self.txnav_end

    def _settle(self, t):
        if self.b_due and self.b_due[0] <= t:
            ed = self.b_due[1]
            self.b_due = None
            ed.invoke_backoff('b')   # 10.23.2.2 b): «final PPDU … completed and the TXNAV timer has expired»

    def _run(self, t_lim):
        """Обработать границы слотов ≤ t_lim; вернуть (B, Edcaf) первой границы с разрешением передачи."""
        while True:
            self._settle(t_lim)
            if self.suspended:
                if self.cbaps is None or self.wi >= len(self.cbaps) or self.cbaps[self.wi][0] > t_lim:
                    self.done = max(self.done, t_lim)
                    return None
                self._resume(self.cbaps[self.wi][0])
                continue
            s, e = self.window()
            cand = [(B, ed) for ed in self.edcafs.values()
                    if (B := self._next_b(ed, s, e)) is not None and B <= t_lim]
            if not cand:
                if self.cbaps is not None and e <= t_lim:
                    self.done = max(self.done, e)
                    self._suspend(e)
                    continue
                self.done = max(self.done, t_lim)
                return None
            B = min(c[0] for c in cand)
            group = [ed for b, ed in cand if b == B]
            self.done = B
            # 10.23.2.4: на границе каждая EDCAF выполняет ровно одно: уменьшить счётчик / начать передачу /
            # внутренняя коллизия / ничего
            ready = [ed for ed in group if ed.backoff == 0 and ed.queue and self._fits(B, ed)
                     and self._fits_txnav(B, ed)]
            for ed in group:
                if ed.backoff > 0:
                    ed.backoff -= 1
            if ready:
                win = max(ready, key=lambda ed: AC_PRIO[ed.ac])
                for ed in ready:
                    if ed is not win:        # d) internal collision; 10.23.2.12.1: retry count += 1
                        ed.queue[0].retries += 1
                        if ed.queue[0].retries >= ed.retry_limit:
                            self.discarded.append(ed.queue.pop(0))
                        ed.invoke_backoff('d')
                return (B, win)

    def _event(self, t):
        g = self._run(t)
        if g is not None:
            raise RuntimeError(f'{self.addr}: пропущена передача в {g[0]}')

    # ---------------- внешние события ----------------
    def enqueue(self, t, msdu, ac=AC_BE):
        t = Fr(t)
        self._event(t)
        ed = self.edcafs[ac]
        # 10.23.2.2 a): очередь стала непустой, счётчик 0, среда занята → backoff без изменения CW/QSRC
        if not ed.queue and ed.backoff == 0 and self.medium_busy(t):
            ed.invoke_backoff('a')
        ed.queue.append(msdu)

    def rx_start(self, t):
        t = Fr(t)
        if self.tx is None:
            self._event(t)
            if self.rx_n == 0:
                self.busy_err = False        # новый период занятости
        self.rx_n += 1
        self.nav.rx_start(t)
        if self.wait and t <= self.wait['deadline']:
            self.wait['rx'] = True

    def rx_end(self, t, f, started=True):
        """started=False — PPDU начался во время своей передачи: PHY-RXSTART не было, ошибки приёма тоже."""
        t = Fr(t)
        self._event(t)
        self.rx_n -= 1
        if f is None and started:
            self.busy_err = True
        if self.rx_n == 0 and self.tx is None:
            self.cs_idle, self.cs_err = t, self.busy_err
        if f is not None:
            self.nav.rx(t, f)
        if self.wait and self.wait['rx']:
            w = self.wait
            if f is not None and f.dst == self.addr and f.is_response_to(w['frame']):
                self._success(t)
            else:                            # 10.3.2.9/10.3.2.11: «anything else … failure»
                self._failure(t)
        if f is not None and f.dst in (self.addr, BCAST) and f.src != self.addr:
            r = self._response(t, f)
            if r is not None:
                self.sched = (t + SIFS, r, 'resp')

    def timeout(self, t):
        t = Fr(t)
        assert self.wait and not self.wait['rx'] and t >= self.wait['deadline']
        self._event(t)
        self._failure(t)

    def next_action(self):
        if self.tx is not None:
            return None
        if self.sched is not None:
            return (self.sched[0], 'tx')
        if self.wait is not None:
            return None if self.wait['rx'] else (self.wait['deadline'], 'timeout')
        g = copy.deepcopy(self)._run(INF)
        return None if g is None else (g[0], 'tx')

    def start(self, t):
        t = Fr(t)
        if self.sched is not None and self.sched[0] == t:
            _, f, role = self.sched
            self.sched = None
            return self._tx(t, f, role)
        g = self._run(t)
        assert g is not None and g[0] == t, (self.addr, t, g)
        return self._begin_txop(t, g[1])

    def tx_end(self, t):
        t = Fr(t)
        self._event(t)
        t0, _, f, role = self.tx
        self.tx = None
        if self.rx_n == 0:                   # 10.3.2.1: «busy when the STA is transmitting»
            self.cs_idle, self.cs_err, self.busy_err = t, False, False
        if role == 'resp':
            return
        if f.needs_response():
            self.wait = dict(frame=f, t_end=t, deadline=t + response_timeout(f.mcs), rx=False)
        else:
            self.wait = dict(frame=f, t_end=t)
            self._success(t)

    # ---------------- TXOP ----------------
    def _tx(self, t, f, role):
        if self.rx_n == 0:
            self.busy_err = False            # своя передача открывает период занятости
        self.tx = (t, t + f.airtime, f, role)
        return f

    def _data_frame(self, m, t_start, first, pending=Fr(0)):
        f = Frame(m.kind, self.addr, m.dst, m.length, m.mcs, ack=m.ack)
        f.dur = self._duration(f, t_start, first, single=ceil_us(SIFS + m.t_resp()) if m.t_resp() else 0,
                               pending=pending)
        return f

    def _duration(self, f, t_start, first, single, pending=Fr(0)):
        """9.2.5.2: a) single protection — значение single; b) multiple (неравенства — по PDF 802.11-2020 с. 791, в
        .txt знаки потеряны): 3) min(T_PENDING, T_TXOP − T_PPDU) ≤ D ≤ T_TXOP − T_PPDU; 4) T_END-NAV − T_PPDU ≤ D ≤
        T_TXOP-REMAINING − T_PPDU. T_PENDING — время ожидающих обменов после текущего PPDU (трактовка: определение
        не уточняет, входит ли текущий), т.е. (обмены очереди) − T_PPDU."""
        lim = self.txop.ed.p.txop_limit
        if self.protection != 'multiple' or lim == 0:
            return single
        if self.full_txop:
            return ceil_us(lim - (t_start - self.txop.start) - f.airtime)
        if first:
            return ceil_us(min(pending - f.airtime, lim - f.airtime))
        return ceil_us(self.txnav_end - (t_start + f.airtime))

    def _pending(self, ed):
        q = ed.queue
        return sum((m.exchange_time() for m in q), Fr(0)) + SIFS * (len(q) - 1)

    def _begin_txop(self, t, ed):
        """10.23.2.4: TXOP получен — начать обмен (RTS/DMG CTS + Data/Ack или Data/Ack)."""
        m = ed.queue[0]
        self.txop = _Txop(ed, t, m.dst)
        self.recover_ac = None
        pend = self._pending(ed)
        if m.rts:
            f = Frame('RTS', self.addr, m.dst)
            # 9.2.5.2 a) 1): «pending frame, plus one CTS frame, plus one Ack … plus applicable IFSs»
            single = ceil_us(T_DMG_CTS + m.t_data() + (m.t_resp() + SIFS if m.t_resp() else 0) + 2 * SIFS)
            f.dur = self._duration(f, t, True, single, pend)
            self.txop.seq = [None]           # Data строится после DMG CTS
        else:
            f = self._data_frame(m, t, True, pend)
        return self._tx(t, f, 'init')

    def _success(self, t):
        w = self.wait
        self.wait = None
        f = w['frame']
        # 10.23.2.2: TXNAV — Duration последнего успешно переданного кадра, от конца его PPDU
        self.txnav_end = w['t_end'] + f.dur
        tx = self.txop
        if tx is None:
            return
        tx.initial = False
        ed = tx.ed
        if f.kind == 'CF-End':
            return self._end_txop(t)
        if f.kind == 'RTS':                  # 10.3.5: Data — через SIFS после DMG CTS
            nf = self._data_frame(ed.queue[0], t + SIFS, False)
            self.sched = (t + SIFS, nf, 'init')
            return
        self.delivered.append(ed.queue.pop(0))
        # 10.23.2.8: следующий кадр той же AC через SIFS, если кадр + ответ < остатка TXNAV и в пределах лимита
        if ed.queue:
            m = ed.queue[0]
            t1 = t + SIFS
            t2 = t1 + m.exchange_time(with_rts=False)
            lim = ed.p.txop_limit
            if lim > 0 and t2 < self.txnav_end and t2 - tx.start <= lim and t2 <= self.window()[1]:
                self.sched = (t1, self._data_frame(m, t1, False), 'init')
                return
        if self.cf_end and not ed.queue:
            # 10.23.2.10: «may transmit a CF-End … provided that the remaining duration is long enough»; DMG — не
            # ненулевой Duration, если остаток < 2×TCF-End + 2×SIFS; 9.3.1.6: Duration = (i − 1)(TXTIME(CF-End)+SIFS)
            t1 = t + SIFS
            rem = min(self.txnav_end, self.window()[1]) - t1    # 10.39.5: и ответный CF-End — до конца CBAP
            if rem >= T_CF_END:
                dur = ceil_us(T_CF_END + SIFS) if rem >= 2 * T_CF_END + 2 * SIFS else 0
                tx.cf_end = True
                self.sched = (t1, Frame('CF-End', self.addr, tx.dst, dur=dur), 'init')
                return
        self._end_txop(t)

    def _end_txop(self, t):
        ed = self.txop.ed
        self.txop = None
        self.b_due = (max(t, self.txnav_end), ed)

    def _failure(self, t):
        """Сбой передачи MPDU (10.23.2.2): c) — первый PPDU TXOP, e) — не первый (выбор реализации)."""
        self.wait = None
        tx = self.txop
        self.txop = None
        ed = tx.ed
        m = ed.queue[0]
        m.retries += 1                       # 10.23.2.12.1: «incremented every time transmission fails … RTS»
        if m.retries >= ed.retry_limit:      # «equal to dot11ShortRetryLimit … shall be discarded»
            self.discarded.append(ed.queue.pop(0))
        if tx.initial:
            ed.invoke_backoff('c')
        elif self.noninitial_failure == 'backoff':
            self.recover_ac = ed.ac          # «shall not extend the TXNAV timer value»
            ed.invoke_backoff('e')
        else:
            self.b_due = (max(t, self.txnav_end), ed)

    # ---------------- ответы ----------------
    def _response(self, t, f):
        if f.dst != self.addr:
            return None
        if f.kind == 'RTS':
            # 10.3.2.9: «If the NAV indicates idle, the STA shall respond with a CTS … after a SIFS»; DMG — DMG CTS;
            # 9.3.1.13 (рис. 9-52): Duration = Duration RTS − (TXTIME(DMG CTS) + SIFS)
            if not self.nav.idle_for_rts(t, f.src):
                return None
            return Frame('DMG CTS', self.addr, f.src, dur=ceil_us(f.dur - (T_DMG_CTS + SIFS)))
        if f.needs_response():
            # 10.3.2.11: «transmit an Ack or BlockAck … after a SIFS, without regard to the busy/idle state»;
            # 9.2.5.7: Duration = Duration вызвавшего − (SIFS + TXTIME ответа)
            kind = 'BlockAck' if f.kind in ('A-MPDU', 'BlockAckReq') else 'Ack'
            r = Frame(kind, self.addr, f.src, mcs=resp_mcs(f.mcs))
            r.dur = ceil_us(f.dur - (SIFS + r.airtime))
            return r
        if f.kind == 'CF-End' and f.dur != 0 and self.respond_cf_end:
            return Frame('CF-End', self.addr, BCAST, dur=0)   # 9.3.1.6: i = 1 — последний CF-End
        return None


class Air:
    """Эфир: все STA слышат всех; перекрытие PPDU у приёмника — ошибка приёма обоих (без захвата).
    Журнал — кортежи формата check_air_log."""
    def __init__(self, stations):
        self.st = {s.addr: s for s in stations}
        self.log = []
        self.ends = []                       # (t_end, id, src, frame)
        self.active = {a: [] for a in self.st}   # чужие PPDU на эфире у приёмника: [id]
        self.bad = set()                     # (id, приёмник) — испорчен
        self.deaf = set()                    # (id, приёмник) — приёмник передавал в начале PPDU
        self.n = 0

    def run(self, until):
        """Продолжить моделирование до момента until (повторные вызовы продолжают с того же состояния; между
        ними можно подавать события станциям, например enqueue)."""
        until = Fr(until)
        ends, active, bad = self.ends, self.active, self.bad
        start = len(self.log)
        while True:
            acts = {a: s.next_action() for a, s in self.st.items()}
            cands = [x[0] for x in acts.values() if x] + ([ends[0][0]] if ends else [])
            if not cands:
                break
            t = min(cands)
            if t > until:
                break
            if ends and ends[0][0] == t:     # 1) окончания PPDU
                while ends and ends[0][0] == t:
                    _, i, src, f = heapq.heappop(ends)
                    self.st[src].tx_end(t)
                    for a, s in self.st.items():
                        if a != src:
                            active[a].remove(i)
                            s.rx_end(t, None if (i, a) in bad else f, (i, a) not in self.deaf)
                continue
            starters = [a for a, x in acts.items() if x and x == (t, 'tx')]
            if starters:                     # 2) начала PPDU (решения на границе слота уже приняты)
                new = []
                for a in starters:
                    f = self.st[a].start(t)
                    self.n += 1
                    new.append((self.n, a, f))
                    for j in active[a]:      # передатчик не принимает
                        bad.add((j, a))
                    w = self.st[a].window()
                    self.log.append((t, t + f.airtime, a, f.dst, f.kind, f.dur,
                                     None if self.st[a].cbaps is None or w is None else w[1]))
                for i, src, f in new:
                    for a, s in self.st.items():
                        if a == src:
                            continue
                        if a in starters or self.st[a].tx is not None:
                            self.deaf.add((i, a))
                        if active[a] or a in starters:
                            bad.add((i, a))
                            for j in active[a]:
                                bad.add((j, a))
                        active[a].append(i)
                        s.rx_start(t)
                    heapq.heappush(ends, (t + f.airtime, i, src, f))
                continue
            for a, x in acts.items():        # 3) таймауты ответа
                if x == (t, 'timeout'):
                    self.st[a].timeout(t)
        return self.log[start:]


# ======================== проверка журнала эфира ========================
class LogParams:
    """Параметры check_air_log.
      aifsn — AIFSN передатчика: int, dict src → AIFSN или функция (src, индекс события во входном списке) → AIFSN
        (AC кадра: 10.2.3.2 — кадры управления на AC_VO); по умолчанию 3 — AC_BE.
      sifs_tol — допуск SIFS (10.3.2.3.3: +10 %·(aSlotTime − aAirPropagationTime), −0 %).
      slot_tol, tol_early — допуски выравнивания на границу слота (стандарт не задаёт; по умолчанию как SIFS).
      check_slots — проверять, что начало доступа — AIFS + k·aSlotTime от освобождения среды.
      aps — адреса AP/PCP (им разрешён CF-End не держателем TXOP; 10.23.2.10 — запрет только для non-AP).
      txop_limit — лимит TXOP (0 — по умолчанию для DMG, табл. 9-155).
      cbaps — список CBAP (start, end) для учёта приостановки EDCAF (10.39.5); None — не учитывать.
      rts_nav_reset — допускать сброс NAV по RTS (10.3.2.4, «is permitted»).
      report_collisions — сообщать одновременные начала (это не нарушение: обе STA на границе слота).
      unchecked — виды кадров вне правил EDCA (BTI, BF) — занимают среду, но доступ не проверяется;
      txnav_kinds — из них виды, Duration которых задаёт TXNAV передатчика (10.23.2.2: «Duration/ID field in the
        frame most recently successfully transmitted by the TXOP holder»), напр. BRP setup в TXOP (10.42.3.2);
        или функция (индекс события во входном списке) → bool (кадр держателя, а не ответчика)."""
    def __init__(self, aifsn=3, sifs_tol=SIFS_TOL, slot_tol=SIFS_TOL, tol_early=Fr(0), check_slots=True, aps=(),
                 txop_limit=0, cbaps=None, rts_nav_reset=True, report_collisions=False,
                 unchecked=('Beacon', 'DMG Beacon', 'SSW', 'SSW-Feedback', 'SSW-Ack', 'BRP'), txnav_kinds=()):
        self.txnav_kinds = txnav_kinds if callable(txnav_kinds) else tuple(txnav_kinds)
        self.aifsn, self.sifs_tol, self.slot_tol, self.tol_early = aifsn, sifs_tol, slot_tol, tol_early
        self.check_slots, self.aps, self.txop_limit = check_slots, set(aps), Fr(txop_limit)
        self.cbaps = None if cbaps is None else sorted((Fr(s), Fr(e)) for s, e in cbaps)
        self.rts_nav_reset, self.report_collisions, self.unchecked = rts_nav_reset, report_collisions, unchecked

    def aifs_of(self, src, idx=None):
        if callable(self.aifsn):
            n = self.aifsn(src, idx)
        else:
            n = self.aifsn.get(src, 3) if isinstance(self.aifsn, dict) else self.aifsn
        return aifs(n)


class Violation:
    __slots__ = ('idx', 'rule', 'msg')

    def __init__(self, idx, rule, msg):
        self.idx, self.rule, self.msg = idx, rule, msg

    def __repr__(self):
        return f'Violation(#{self.idx} {self.rule}: {self.msg})'


def _frame(e):
    return Frame(e[4], e[2], e[3], dur=e[5])


def check_air_log(events, params=None):
    """Проверка журнала эфира на правила доступа DMG STA в CBAP.

    events — итерируемое кортежей (t_start_us, t_end_us, src, dst, kind, duration_field_us, cbap_end_us):
      t_start/t_end — начало первого символа преамбулы и конец последнего символа PPDU на эфире (10.3.7);
      src/dst — TA/RA (широковещательный — BCAST); kind — 'RTS' | 'DMG CTS' | 'CTS' | 'Data' | 'A-MPDU' | 'Ack' |
      'BlockAck' | 'BlockAckReq' | 'CF-End' | 'Beacon' | …; DMG CTS с dst == src — DMG CTS-to-self;
      duration_field_us — значение поля Duration; cbap_end_us — конец CBAP, в котором кадр передан (None — нет).
    Модель эфира: все STA слышат всех; PPDU, перекрытый другим, никем не принят.

    Возвращает список Violation(idx — индекс во входном списке, rule, msg); rule:
      'busy'     — начало доступа при занятой среде (чужой PPDU на эфире; 10.3.2.1);
      'nav'      — начало доступа при ненулевом NAV передатчика (10.3.2.1, 10.3.2.4, 10.23.2.10);
      'aifs'     — доступ без AIFS[AC] свободной среды (10.23.2.4, 10.3.2.3.6);
      'slot'     — доступ не на границе слота AIFS + k·aSlotTime (10.23.2.4 f);
      'sifs'     — ответ не через SIFS (10.3.2.3.3);
      'cts_nav'  — DMG CTS при занятом NAV ответчика (10.3.2.9);
      'timeout'  — новый доступ до истечения AckTimeout/CTSTimeout своего кадра (10.3.2.11, 10.3.2.9);
      'txnav'    — кадр TXOP с ответом не укладывается в TXNAV (10.23.2.8);
      'txop_limit' — второй Data/A-MPDU в TXOP при лимите 0 (10.23.2.9);
      'cbap_end' — обмен (с ответами) заканчивается после конца CBAP (10.39.4, 10.39.5);
      'cf_end'   — CF-End от non-AP STA, не держателя TXOP (10.23.2.10);
      'cf_end_dur' — DMG CF-End с Duration ≠ 0 при остатке < 2×TCF-End + 2×SIFS (10.23.2.10);
      'collision' — одновременное начало (только при report_collisions)."""
    p = params or LogParams()
    ev = [tuple(e[:5]) + (e[5], e[6] if len(e) > 6 else None) for e in events]
    order = sorted(range(len(ev)), key=lambda i: (Fr(ev[i][0]), Fr(ev[i][1])))
    R = [dict(i=i, ts=Fr(ev[i][0]), te=Fr(ev[i][1]), src=ev[i][2], f=_frame(ev[i]),
              cbap=None if ev[i][6] is None else Fr(ev[i][6])) for i in order]
    n = len(R)
    out = []

    def v(r, rule, msg):
        out.append(Violation(r['i'], rule, msg))

    # перекрытия: PPDU, перекрытый другим, испорчен для всех
    over = [False] * n
    for a in range(n):
        for b in range(a + 1, n):
            if R[b]['ts'] >= R[a]['te']:
                break
            over[a] = over[b] = True
    # ответы: ближайший предыдущий по концу кадр + вид/адреса
    resp_of = {}                             # индекс вызвавшего → индекс ответа
    is_resp = [False] * n
    for k in range(n):
        prev = max((j for j in range(k) if R[j]['te'] <= R[k]['ts']), key=lambda j: R[j]['te'], default=None)
        R[k]['prev'] = prev
        if prev is not None and R[k]['f'].is_response_to(R[prev]['f']) and prev not in resp_of:
            is_resp[k] = True
            resp_of[prev] = k

    names = {r['src'] for r in R} | {r['f'].dst for r in R}
    names.discard(BCAST)
    navs = {x: Nav(x, p.rts_nav_reset) for x in names}
    feed = sorted([(R[k]['te'], 1, k) for k in range(n)] + [(R[k]['ts'], 0, k) for k in range(n)],
                  key=lambda x: (x[0], -x[1]))   # в один момент: окончания раньше начал
    fi = 0
    wins = p.cbaps
    wstate = {'wi': 0}

    def mine_overlap(x, k):
        return any(R[j]['src'] == x and R[j]['ts'] < R[k]['te'] and R[k]['ts'] < R[j]['te'] for j in range(n))

    def advance_windows(t):
        # 10.39.5: NAV заморожены от конца CBAP до начала следующего
        while wins is not None and wstate['wi'] + 1 < len(wins) and wins[wstate['wi'] + 1][0] <= t:
            e, s2 = wins[wstate['wi']][1], wins[wstate['wi'] + 1][0]
            for nv in navs.values():
                nv.shift(e, s2)
            wstate['wi'] += 1

    def in_gap(t):
        return wins is not None and not any(s <= t < e for s, e in wins)

    def feed_until(t):
        nonlocal fi
        while fi < len(feed) and (feed[fi][0] < t or (feed[fi][0] == t and feed[fi][1] == 1)):
            tt, kind, k = feed[fi]
            fi += 1
            advance_windows(tt)
            for x, nv in navs.items():
                if x == R[k]['src']:
                    continue
                if kind == 0:
                    nv.rx_start(tt)
                elif not over[k] and not mine_overlap(x, k) and not in_gap(tt):
                    nv.rx(tt, R[k]['f'])
        advance_windows(t)

    txop = {}          # держатель → dict(txnav_end, open, ok, failed, data)
    last_init = {}     # STA → индекс последнего своего кадра, требующего ответа
    for k in range(n):
        r = R[k]
        t, f, x = r['ts'], r['f'], r['src']
        feed_until(t)
        prev = r['prev']
        pf = R[prev] if prev is not None else None
        # конец CBAP: кадр и (для инициатора) его ответ
        end_x = R[resp_of[k]]['te'] if k in resp_of else r['te']
        if r['cbap'] is not None and end_x > r['cbap']:
            v(r, 'cbap_end', f'{f} заканчивается (с ответом) в {float(end_x)} > конца CBAP {float(r["cbap"])}')
        if is_resp[k]:
            gap = t - pf['te']
            if not (SIFS <= gap <= SIFS + p.sifs_tol):
                v(r, 'sifs', f'{f}: промежуток {float(gap)} мкс вместо SIFS')
            if f.kind == 'DMG CTS' and not navs[x].idle_for_rts(t, pf['src']):
                v(r, 'cts_nav', f'{f}: NAV ответчика занят до {float(navs[x].idle_from())}')
            h = txop.get(pf['src'])
            if h is not None:
                h['txnav_end'] = pf['te'] + pf['f'].dur      # 10.23.2.2: TXNAV по успешному кадру
                h['ok'], h['failed'] = True, False
                if pf['f'].kind in DATA_KINDS:
                    h['data'] += 1
            last_init.pop(pf['src'], None)
            continue
        if f.kind in p.unchecked:
            if (p.txnav_kinds(r['i']) if callable(p.txnav_kinds) else f.kind in p.txnav_kinds):
                txop[x] = dict(txnav_end=r['te'] + f.dur, open=True, ok=True, failed=False, data=0)
            continue
        h = txop.get(x)
        cont = False
        if h is not None and h['open'] and pf is not None and t < h['txnav_end']:
            gap = t - pf['te']
            fits = end_x < h['txnav_end'] or (end_x == h['txnav_end'] and pf['f'].kind == 'DMG CTS')
            # продолжение: через SIFS после успешного обмена; после сбоя — не раньше PIFS (10.23.2.8) и только в
            # пределах TXNAV (иначе — обычный доступ, проверяется как новый)
            cont = (h['ok'] and SIFS <= gap <= SIFS + p.sifs_tol) or (h['failed'] and gap >= PIFS and fits)
        if cont:
            # 10.23.2.8: «duration of transmission of that frame plus any expected acknowledgment … less than the
            # remaining TXNAV» — ожидаемый ответ: через номинальный SIFS
            if k in resp_of:
                rr = R[resp_of[k]]
                end_x = r['te'] + SIFS + (rr['te'] - rr['ts'])
            # кадр после DMG CTS — защищённый кадр обмена RTS (10.3.5), Duration RTS покрывает его ровно (9.2.5.2 a 1)
            after_cts = pf['f'].kind == 'DMG CTS' and pf['f'].dst == x
            if end_x > h['txnav_end'] or (end_x == h['txnav_end'] and not after_cts):
                v(r, 'txnav', f'{f} с ответом до {float(end_x)} > TXNAV {float(h["txnav_end"])}')
            if p.txop_limit == 0 and f.kind in DATA_KINDS and h['data'] >= 1:
                v(r, 'txop_limit', f'{f}: второй Data в TXOP при лимите 0')
        else:
            # новый доступ по EDCA
            same = [j for j in range(k) if R[j]['ts'] == t and R[j]['src'] != x]
            busy = [j for j in range(k) if R[j]['ts'] < t < R[j]['te'] and R[j]['src'] != x]
            if busy:
                v(r, 'busy', f'{f} начат во время {R[busy[0]]["f"]}')
            if same and p.report_collisions:
                v(r, 'collision', f'{f} одновременно с {R[same[0]]["f"]}')
            nv = navs.get(x)
            nav_end = nv.idle_from() if nv else Fr(0)
            if nv and nav_end > t:
                v(r, 'nav', f'{f}: NAV {x} занят до {float(nav_end)}')
            li = last_init.get(x)
            if li is not None and t < R[li]['te'] + response_timeout(R[li]['f'].mcs):
                v(r, 'timeout', f'{f}: до истечения таймаута ответа на {R[li]["f"]}')
            ended = [j for j in range(k) if R[j]['te'] <= t]
            if ended and not busy:
                jb = max(ended, key=lambda j: R[j]['te'])
                a = p.aifs_of(x, r['i'])
                ref = max(R[jb]['te'], nav_end if nav_end <= t else Fr(0))
                if wins is not None:
                    ws = [s for s, e in wins if s <= t]
                    if ws:
                        ref = max(ref, ws[-1])
                refs = [ref + a]
                # 10.23.2.4 d): после своей передачи — и после истечения TXNAV; после сбоя внутри TXOP допустим
                # backoff по e) без ожидания TXNAV (10.23.2.2 NOTE 1) — оба варианта
                if h is not None and ref < h['txnav_end'] <= t:
                    if h['failed']:
                        refs.append(h['txnav_end'] + a)
                    else:
                        ref = h['txnav_end']
                        refs = [ref + a]
                # ошибка приёма в последнем периоде занятости → EIFS − DIFS + AIFS (10.3.2.3.7); кадр, начатый во
                # время своей передачи, не принимается (нет PHY-RXSTART)
                lo, err = R[jb]['te'], False
                for j in sorted(ended, key=lambda j: -R[j]['te']):
                    if R[j]['te'] < lo:
                        break
                    lo = min(lo, R[j]['ts'])
                    if over[j] and R[j]['src'] != x and not any(
                            R[q]['src'] == x and R[q]['ts'] <= R[j]['ts'] < R[q]['te'] for q in range(n)):
                        err = True
                if err:
                    refs.append(max(ref, R[jb]['te'] + EIFS - DIFS) + a)
                d = t - refs[0]
                if d < -p.tol_early:
                    v(r, 'aifs', f'{f}: свободно {float(t - ref)} мкс < AIFS {float(a)}')
                elif p.check_slots:
                    def aligned(b0):
                        dd = t - b0
                        if dd < -p.tol_early:
                            return False
                        m = dd % aSlotTime
                        return m <= p.slot_tol or m >= aSlotTime - p.tol_early
                    if not any(aligned(b) for b in refs):
                        v(r, 'slot', f'{f}: {float(d)} мкс после AIFS — не граница слота')
            if f.kind == 'CF-End' and x not in p.aps:
                v(r, 'cf_end', f'{f}: CF-End не от держателя TXOP')
            h = txop[x] = dict(txnav_end=Fr(0), open=True, ok=False, failed=False, data=0)
        if f.kind == 'CF-End':
            if f.dur != 0 and h['txnav_end'] - t < 2 * T_CF_END + 2 * SIFS:
                v(r, 'cf_end_dur', f'{f}: остаток {float(h["txnav_end"] - t)} < 2×TCF-End + 2×SIFS')
            h['open'] = False                 # 10.23.2.10: «shall not initiate any further frame exchange»
        if f.needs_response():
            last_init[x] = k
            if k not in resp_of:
                h['failed'], h['ok'] = True, False
        else:
            h['txnav_end'] = r['te'] + f.dur
            h['ok'], h['failed'] = True, False
            last_init.pop(x, None)
    return out
