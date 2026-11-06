# SPDX-License-Identifier: AGPL-3.0-or-later
"""A-BFT по 802.11-2020: выделение A-BFT (10.42.5.1), работа в A-BFT — слоты, выбор слота, счётчики неудач,
обратная связь (10.42.5.2), обязанности точки после A-BFT (10.42.5.2, 10.42.5.3), несколько DMG-антенн
(10.42.5.4); поле Beacon Interval Control (9.3.4.2, рис. 9-77), постоянные табл. 11-22 и MIB (C.3).
Время — Fraction, мкс; моменты — «на эфире» (10.3.7): начало первого символа преамбулы, конец последнего символа.

Состав:
  ss_duration / ssfb_duration / ss_slot_time  — aSSDuration, aSSFBDuration (табл. 11-22), aSSSlotTime (10.42.5.2).
  BeaconIntervalControl                       — рис. 9-77: кодирование/разбор 48 бит.
  AbftLayout, abft_start                      — границы A-BFT и слотов, момент SSW-Feedback, окно квази-омни.
  ApAbftSchedule, check_bic_sequence          — Next A-BFT, N BIs A-BFT, TXSS/RXSS (dot11ABFTRTXSSSwitch),
                                                A-BFT Count / N A-BFT in Ant (10.42.5.1, 10.42.5.2, 10.42.5.4).
  may_access                                  — допуск STA в A-BFT (10.42.5.2, Discovery Mode, табл. 9-69).
  Responder                                   — STA-ответчик: backoff по слотам, FSS, возобновление и перезапуск
                                                RSS, FailedRSSAttempts/dot11RSSRetryLimit/dot11RSSBackoff,
                                                aMaxABFTAccessPeriod.
  ApAbft                                      — точка-инициатор: приём SSW в слоте, SSW-Feedback, обязанности
                                                (Poll Required → выделение, BRP с Capability Request).
  simulate_abft                               — одна A-BFT: точка + несколько STA → журнал эфира.
  check_abft_log                              — проверка журнала эфира одной A-BFT.
  check_obligations                           — проверка обязанностей точки в aMinBTIPeriod BI после A-BFT.

Не моделируется: направленный эфир (кто кого слышит — параметр rx/collision), выбор «лучшего» сектора (10.42.2.3.2:
«implementation dependent» — берём максимум SNR), RxAdvanceTime (10.39.6.5), состав Extended Schedule/Grant для
BRP-выделения (10.42.5.3 1–4 — только факт выделения), ISS в BTI (модуль bi/sls), BRP (модуль brp)."""
from fractions import Fraction as Fr

from .cbap import Rng, Violation
from .duration import duration_ssw
from .timing import (aAirPropagationTime, ABFT_FB_TOL, ABFT_SSW_START_TOL, aMaxABFTAccessPeriod, aMinBTIPeriod,
                     aSBIFSAccuracy, aSSFramesPerSlot, FSS_MAX, LBIFS, LBIFS_TOL, LEN_SSW, LEN_SSW_ACK, LEN_SSW_FB,
                     MBIFS, MBIFS_TOL, SBIFS, ss_duration, ss_fb_duration, ss_slot_time, T_SSW, T_SSW_FB,
                     txtime_control)

# Табл. 11-22 (aMinBTIPeriod, aSSFramesPerSlot, aMaxABFTAccessPeriod), длины/TXTIME SSW и SSW-Feedback (10.6.7.1: в
# A-BFT оба кадра на MCS 0 — RXSSTxRate задаётся только BF Control в SP/Grant), LBIFS и допуски, FSS_MAX, пределы
# полей 9.5.1 — timing.py (одно определение на все модули).

# ---- C.3 MIB, dot11DMGBeamformingConfigEntry: SYNTAX Unsigned32 (1..32) ----
DOT11_ABFT_RTXSS_SWITCH = 4                 # dot11ABFTRTXSSSwitch DEFVAL { 4 }, «beacon intervals»
DOT11_RSS_RETRY_LIMIT = 8                   # dot11RSSRetryLimit DEFVAL { 8 }
DOT11_RSS_BACKOFF = 8                       # dot11RSSBackoff DEFVAL { 8 }
MIB_RANGE = (1, 32)

# ---- рис. 9-77 / 9.3.4.2: диапазоны ----
ABFT_SLOTS_MAX = 8                          # A-BFT Length — 3 бита, «number of … slots …, minus 1»


# ======================================================================================================
#                                   Время слота (10.42.5.2, табл. 11-22)
# ======================================================================================================
# ss_duration / ss_slot_time — timing.py (общие с bi.py); FSS в них — число кадров (поле + 1, PLAN.md).
ssfb_duration = ss_fb_duration


def abft_start(bti_end):
    """10.42.5.1: A-BFT — «MBIFS following the end of a BTI»; 10.3.2.3.10: MBIFS между BTI и A-BFT."""
    return Fr(bti_end) + MBIFS


def sta_bti_end(last_beacon_end, last_beacon_duration):
    """10.42.5.1: STA считает BTI завершённым «at the expiration of the value within the Duration field of the last
    DMG Beacon frame received» — от конца PPDU маяка (опорная точка Duration, 9.7.3 NOTE 1)."""
    return Fr(last_beacon_end) + last_beacon_duration


# ======================================================================================================
#                                  Beacon Interval Control (рис. 9-77)
# ======================================================================================================
# (имя, младший бит, ширина) — рис. 9-77
BIC_FIELDS = (
    ('cc_present', 0, 1), ('discovery_mode', 1, 1), ('next_beacon', 2, 4), ('ati_present', 6, 1),
    ('abft_length', 7, 3), ('fss', 10, 4), ('is_responder_txss', 14, 1), ('next_abft', 15, 4),
    ('fragmented_txss', 19, 1), ('txss_span', 20, 7), ('n_bis_abft', 27, 4), ('abft_count', 31, 6),
    ('n_abft_in_ant', 37, 6), ('pcp_assoc_ready', 43, 1),
)
BIC_BITS = 48                               # B0..B47, B44–B47 Reserved


class BeaconIntervalControl:
    """Поле Beacon Interval Control (рис. 9-77); атрибуты — значения подполей «как в поле»:
    abft_length = слоты − 1, fss = кадры − 1 (9.3.4.2)."""
    def __init__(self, **kw):
        for name, _, _ in BIC_FIELDS:
            setattr(self, name, 0)
        self.txss_span, self.n_bis_abft = 1, 1          # 9.3.4.2: TXSS Span ≥ 1; N BIs A-BFT = 1 — каждый BI
        for k, v in kw.items():
            assert any(k == f[0] for f in BIC_FIELDS), k
            setattr(self, k, v)

    @property
    def abft_slots(self):
        """9.3.4.2: «number of sector sweep slots … in the A-BFT …, minus 1»."""
        return self.abft_length + 1

    @property
    def fss_frames(self):
        """9.3.4.2: «The subfield contains the number of SSW frames allowed minus one»."""
        return self.fss + 1

    def encode(self):
        v = 0
        for name, lsb, w in BIC_FIELDS:
            x = getattr(self, name)
            assert 0 <= x < (1 << w), (name, x)
            v |= x << lsb
        return v

    def to_bytes(self):
        """9.2.2: поля — младшими битами вперёд (little-endian по октетам)."""
        return self.encode().to_bytes(BIC_BITS // 8, 'little')

    @classmethod
    def decode(cls, v):
        if isinstance(v, (bytes, bytearray)):
            v = int.from_bytes(v, 'little')
        return cls(**{name: (v >> lsb) & ((1 << w) - 1) for name, lsb, w in BIC_FIELDS})

    def __eq__(self, o):
        return isinstance(o, BeaconIntervalControl) and self.encode() == o.encode()

    def __repr__(self):
        return 'BIC(' + ', '.join(f'{n}={getattr(self, n)}' for n, _, _ in BIC_FIELDS) + ')'


# ======================================================================================================
#                                    Границы A-BFT и слотов (10.42.5.2)
# ======================================================================================================
class AbftLayout:
    """A-BFT из n_slots слотов aSSSlotTime при FSS (число кадров), начиная со start (10.42.5.2: «The first SSW slot
    begins at the start of the A-BFT, and the following SSW slots are adjacent and nonoverlapping»)."""
    def __init__(self, start, n_slots, fss, is_txss=True):
        assert 1 <= n_slots <= ABFT_SLOTS_MAX and 1 <= fss <= FSS_MAX
        self.start, self.n_slots, self.fss, self.is_txss = Fr(start), n_slots, fss, is_txss
        self.slot_time = ss_slot_time(fss)

    @classmethod
    def from_bic(cls, bic, bti_end):
        return cls(abft_start(bti_end), bic.abft_slots, bic.fss_frames, bool(bic.is_responder_txss))

    @property
    def end(self):
        """10.42.5.2: «the length of the A-BFT is an integer multiple of the sector sweep slot time»."""
        return self.start + self.n_slots * self.slot_time

    def slot_start(self, s):
        return self.start + s * self.slot_time

    def slot_end(self, s):
        return self.slot_start(s + 1)

    def ssw_pos(self, s, k):
        """Позиция k (0..FSS−1) в слоте s: кадры через SBIFS (табл. 11-22 aSSDuration, рис. 10-71)."""
        return self.slot_start(s) + k * (T_SSW + SBIFS)

    def ssw_window_end(self, s):
        """Конец aSSDuration на эфире у ответчика (рис. 10-76: aAirPropagationTime — до aSSDuration, т.е. на
        стороне точки; у ответчика окно — [начало слота, + aSSDuration])."""
        return self.slot_start(s) + ss_duration(self.fss)

    def fb_start(self, s):
        """10.42.5.2: начало первого символа SSW-Feedback — «at aSSFBDuration + MBIFS before the end of the SSW slot»."""
        return self.slot_end(s) - ssfb_duration() - MBIFS

    def responder_qomni(self, s):
        """10.42.5.2: ответчик, передавший SSW в слоте, — в квази-омни приёме «for a period of aSSFBDuration ending
        MBIFS before the end of the SSW slot»."""
        e = self.slot_end(s) - MBIFS
        return e - ssfb_duration(), e

    def slot_of(self, t):
        """Номер слота, содержащего момент t (None — вне A-BFT)."""
        t = Fr(t)
        if t < self.start or t >= self.end:
            return None
        return int((t - self.start) // self.slot_time)


# ======================================================================================================
#                            Расписание A-BFT у точки (10.42.5.1, 10.42.5.2, 10.42.5.4)
# ======================================================================================================
class ApAbftSchedule:
    """Значения Beacon Interval Control по BI для точки доступа/PCP.

    k (N BIs A-BFT) — «An AP or PCP shall have an A-BFT every k beacon intervals» (10.42.5.4);
    Next A-BFT — уменьшается на 1 после каждого BTI, 0 — A-BFT сразу после BTI (10.42.5.1, 9.3.4.2);
    TXSS/RXSS — want_rxss(j) задаёт желание RXSS для j-й A-BFT, но TXSS — «at least once every
    dot11ABFTRTXSSSwitch beacon intervals in which an A-BFT is present» (10.42.5.2);
    антенны — n_rx_ant DMG-антенн, смена каждые l = N A-BFT in Ant A-BFT; A-BFT Count — «number of A-BFTs since …
    last switched RX DMG antennas», 0 — антенна отличается от прошлой A-BFT (9.3.4.2, 10.42.5.4).
    10.42.4: «The AP or PCP shall not change DMG antennas within a BTI» и 10.42.5.4: в A-BFT точка принимает на
    антенне из DMG Antenna ID маяков → антенна маяков BTI = антенна приёма следующей A-BFT."""
    def __init__(self, k=1, n_slots=8, fss=aSSFramesPerSlot, rxss_fss=None, want_rxss=None,
                 rtxss_switch=DOT11_ABFT_RTXSS_SWITCH, n_rx_ant=1, n_abft_in_ant=1, discovery=False):
        assert 1 <= k <= 15 and MIB_RANGE[0] <= rtxss_switch <= MIB_RANGE[1]
        # 10.42.5.2: «FSS … no less than aSSFramesPerSlot» (о числе кадров — PLAN.md №1, check_bic_sequence)
        assert fss >= aSSFramesPerSlot
        self.k, self.n_slots, self.fss = k, n_slots, fss
        # 10.42.5.2: RXSS — «should set the value of the FSS field … to the number of receive sectors supported»
        self.rxss_fss = rxss_fss if rxss_fss is not None else fss
        self.want_rxss = want_rxss or (lambda j: False)
        self.rtxss_switch, self.n_rx_ant, self.l = rtxss_switch, n_rx_ant, n_abft_in_ant
        self.discovery = discovery
        self.run_rxss = 0                   # подряд RXSS A-BFT
        self.j = 0                          # номер A-BFT

    def bi(self, b):
        """BIC и антенна приёма для BI номер b (вызывать по возрастанию b). Возвращает (bic, abft_ant | None)."""
        # 11.1.3.4: Discovery Mode → Next A-BFT = 0 (A-BFT в каждом BI)
        k = 1 if self.discovery else self.k
        nxt = (k - b % k) % k
        bic = BeaconIntervalControl(discovery_mode=int(self.discovery), abft_length=self.n_slots - 1,
                                    next_abft=nxt, n_bis_abft=k)
        ant = None
        if nxt == 0:
            rxss = self.want_rxss(self.j) and self.run_rxss + 1 < self.rtxss_switch
            self.run_rxss = self.run_rxss + 1 if rxss else 0
            bic.is_responder_txss = 0 if rxss else 1
            bic.fss = (self.rxss_fss if rxss else self.fss) - 1
            ant = (self.j // self.l) % self.n_rx_ant
            if self.n_rx_ant > 1:       # 9.3.4.2: иначе подполя reserved
                bic.abft_count, bic.n_abft_in_ant = self.j % self.l, self.l
            self.j += 1
        else:
            bic.fss = self.fss - 1
            bic.is_responder_txss = 1
        return bic, ant


def check_bic_sequence(seq, rtxss_switch=DOT11_ABFT_RTXSS_SWITCH, n_rx_ant=1):
    """Проверка BIC маяков по BI. seq — список по BI: None (BTI нет) или (bics, ant): bics — BIC всех маяков BTI
    (или один BIC), ant — DMG Antenna ID маяков BTI (None — не проверять).

    Правила:
      'bti_same'    — BIC различаются внутри BTI (10.42.4: «shall retain the same value from start to completion of
                      a TXSS phase»; проверяем только внутри BTI — Next A-BFT меняется по BI, 10.42.5.1);
      'next_abft'   — Next A-BFT ≠ 0 и следующий BTI не объявил значение − 1 (10.42.5.1);
      'n_bis'       — расстояние между A-BFT ≠ k = N BIs A-BFT (10.42.5.4);
      'fss_min'     — FSS < aSSFramesPerSlot кадров (10.42.5.2; СПОРНО ниже);
      'rtxss'       — dot11ABFTRTXSSSwitch A-BFT подряд без TXSS (10.42.5.2);
      'abft_count'  — A-BFT Count не 0 при смене антенны / 0 без смены / смена не через N A-BFT in Ant
                      (9.3.4.2, 10.42.5.4); только при n_rx_ant > 1.
    СПОРНО → принято (PLAN.md №1, так же bi.BeaconIntervalControl.validate) (fss_min): «set the FSS subfield … to a
    value that is no less than aSSFramesPerSlot» — (а) значение подполя ≥ 4 (≥ 5 кадров) или (б) число кадров ≥ 4
    (подполе ≥ 3). Берём (б): в 10.42.5 «value of FSS» везде — число кадров (рис. 10-75: «the value of FSS is 8» при 8
    нарисованных SSW), да и имя «FramesPerSlot»."""
    out = []
    prev = None          # (b, bic)
    last_abft = None     # (b, bic, ant)
    rx_run = 0
    for b, item in enumerate(seq):
        if item is None:
            prev = None
            continue
        bics, ant = item
        if isinstance(bics, BeaconIntervalControl):
            bics = [bics]
        bic = bics[0]
        if any(x != bic for x in bics[1:]):
            out.append(Violation(b, 'bti_same', 'разные BIC в одном BTI'))
        if prev is not None and prev[0] == b - 1 and prev[1].next_abft != 0 and bic.next_abft != prev[1].next_abft - 1:
            out.append(Violation(b, 'next_abft', f'Next A-BFT {prev[1].next_abft} → {bic.next_abft}'))
        if bic.next_abft == 0:
            if bic.fss_frames < aSSFramesPerSlot:
                out.append(Violation(b, 'fss_min', f'FSS {bic.fss_frames} кадров < {aSSFramesPerSlot}'))
            rx_run = 0 if bic.is_responder_txss else rx_run + 1
            if rx_run >= rtxss_switch:
                out.append(Violation(b, 'rtxss', f'{rx_run} A-BFT подряд RXSS'))
            if last_abft is not None:
                lb, lbic, lant = last_abft
                if lbic.n_bis_abft == bic.n_bis_abft and b - lb != bic.n_bis_abft:
                    out.append(Violation(b, 'n_bis', f'A-BFT через {b - lb} BI при k={bic.n_bis_abft}'))
                if n_rx_ant > 1 and ant is not None and lant is not None:
                    switched = ant != lant
                    if switched != (bic.abft_count == 0):
                        out.append(Violation(b, 'abft_count', f'A-BFT Count {bic.abft_count}, антенна {lant}→{ant}'))
                    elif not switched and bic.abft_count != lbic.abft_count + 1:
                        out.append(Violation(b, 'abft_count', f'A-BFT Count {lbic.abft_count}→{bic.abft_count}'))
                    elif switched != (lbic.abft_count + 1 >= lbic.n_abft_in_ant):
                        out.append(Violation(b, 'abft_count', f'смена антенны не через {lbic.n_abft_in_ant} A-BFT'))
            last_abft = (b, bic, ant)
        prev = (b, bic)
    return out


# ======================================================================================================
#                                      Допуск STA в A-BFT (10.42.5.2)
# ======================================================================================================
ROLE_BY_BSS_TYPE = {3: 'AP', 2: 'PCP', 1: 'non-AP STA', 0: None}     # табл. 9-69, None — «Any»


def is_group(addr):
    """9.2.2: Individual/Group — бит 0 первого октета MAC-адреса."""
    return bool(int(addr.split(':')[0], 16) & 1)


class BeaconRx:
    """Что STA знает из последнего DMG Beacon BTI: BIC, TA (точка), Clustering Control (A-BFT Responder Address при
    Discovery Mode 1, рис. 9-79), BSS Type (DMG Parameters, табл. 9-69), итог ISS (лучший сектор/антенна/SNR) и
    Number of RX DMG Antennas инициатора (SSW Feedback поля маяка, рис. 9-848; число, не поле − 1)."""
    def __init__(self, bic, ap, received=True, abft_responder=None, bss_type=0, best=(0, 0, 0), n_init_rx_ant=1):
        self.bic, self.ap, self.received = bic, ap, received
        self.abft_responder, self.bss_type, self.best, self.n_init_rx_ant = abft_responder, bss_type, best, n_init_rx_ant


def may_access(beacon, addr, groups=(), role='non-AP STA'):
    """10.42.5.2: без DMG Beacon в BTI — не передавать; при Discovery Mode 1 — только если (CC Present 1 и A-BFT
    Responder Address = свой адрес) или (CC Present 1, групповой адрес своей группы и роль по табл. 9-69) или
    CC Present 0."""
    if beacon is None or not beacon.received:
        return False
    bic = beacon.bic
    if not bic.discovery_mode or not bic.cc_present:
        return True
    ra = beacon.abft_responder
    if ra == addr:
        return True
    if ra is not None and is_group(ra) and ra in groups:
        want = ROLE_BY_BSS_TYPE.get(beacon.bss_type)
        return want is None or want == role
    return False


def addressed(beacon, addr):
    """10.42.5.2: Discovery Mode 1, CC Present 1 и A-BFT Responder Address = адрес STA."""
    b = beacon.bic
    return bool(b.discovery_mode and b.cc_present and beacon.abft_responder == addr)


# ======================================================================================================
#                                         Кадры на эфире
# ======================================================================================================
class AirFrame:
    """Кадр в журнале эфира A-BFT. kind — 'SSW' | 'SSW-Feedback' | 'SSW-Ack' | 'BRP' | …; t — начало на эфире.
    SSW: direction, cdown, sector_id, ant_id (SSW field, рис. 9-846), sector_select, ant_select, snr, poll
    (SSW Feedback field вне ISS, рис. 9-849). SSW-Feedback: sector_select, ant_select, snr; tx_sector — сектор
    передачи (для проверки; None — неизвестно). rx_snr — SNR приёма у точки (вход модели медиума)."""
    __slots__ = ('kind', 't', 'src', 'dst', 'length', 'mcs', 'duration', 'direction', 'cdown', 'sector_id',
                 'ant_id', 'sector_select', 'ant_select', 'snr', 'poll', 'tx_sector', 'rx_snr')

    def __init__(self, kind, t, src, dst, **kw):
        for k in self.__slots__:
            setattr(self, k, None)
        self.kind, self.t, self.src, self.dst = kind, Fr(t), src, dst
        self.length = {'SSW': LEN_SSW, 'SSW-Feedback': LEN_SSW_FB, 'SSW-Ack': LEN_SSW_ACK}.get(kind)
        self.mcs = 0
        for k, v in kw.items():
            setattr(self, k, v)

    @property
    def end(self):
        return self.t + txtime_control(self.length) if self.mcs == 0 else None

    def __repr__(self):
        x = f' cdown={self.cdown} sec={self.sector_id}' if self.kind == 'SSW' else ''
        return f'{self.kind}({self.src}->{self.dst} @{float(self.t):.3f}{x})'


# ======================================================================================================
#                                   STA-ответчик (10.42.5.2, 10.42.2.3)
# ======================================================================================================
def sweep_positions(plan, n_init_rx_ant=1):
    """Последовательность позиций RSS-TXSS: plan — [(ant_id, sector_id)] секторов ответчика по возрастанию DMG
    Antenna ID (10.42.2.3.2: «in increasing order of DMG antenna ID»), повтор на каждую RX-антенну инициатора.
    Между кадрами SBIFS; LBIFS при смене своей антенны (10.3.2.3.11: «between transmissions employing different
    DMG antennas») или антенны инициатора (10.42.2.3.2). Возвращает [(ant, sector) | None] — None: «фантомная»
    позиция LBIFS = TXTIME(SSW) + 2×SBIFS, т.е. ровно одна позиция сетки TXTIME(SSW) + SBIFS.
    СПОРНО → принято (PLAN.md «Принятые трактовки» №2, так же sls.slots_cdown): CDOWN «including any LBIFS if
    required» — читаем как «LBIFS считается одной передачей» (CDOWN
    уменьшается на 2 через LBIFS); иное чтение — CDOWN = число оставшихся кадров (−1 через LBIFS), при котором
    начальное значение = «total number of sectors … multiplied by the number of DMG antennas at the initiator
    minus one» без учёта LBIFS. Текст про начальное значение при LBIFS противоречив; выбрано первое."""
    assert [a for a, _ in plan] == sorted(a for a, _ in plan)
    out = []
    for r in range(n_init_rx_ant):
        for i, (a, s) in enumerate(plan):
            if out and (i == 0 or a != plan[i - 1][0]):
                out.append(None)                    # LBIFS
            out.append((a, s))
    return out


class Responder:
    """Non-AP STA в A-BFT.

    Состояние между A-BFT: failed — FailedRSSAttempts; bi_backoff — счётчик dot11RSSBackoff (None — не идёт);
    block — сколько A-BFT ещё не обращаться после успеха в Discovery Mode (aMaxABFTAccessPeriod, «should»);
    pending — {is_txss: оставшиеся позиции} незавершённого RSS для возобновления в A-BFT того же типа.
    Внутри A-BFT: begin_abft → по слотам slot_tx(s) → slot_end(s, fb) → end_abft."""
    def __init__(self, addr, plan=((0, 0),), rng=None, retry_limit=DOT11_RSS_RETRY_LIMIT,
                 rss_backoff=DOT11_RSS_BACKOFF, groups=(), role='non-AP STA', poll_required=0, rxss_sector=None,
                 honor_access_period=True):
        assert MIB_RANGE[0] <= retry_limit <= MIB_RANGE[1] and MIB_RANGE[0] <= rss_backoff <= MIB_RANGE[1]
        self.addr, self.plan, self.rng = addr, list(plan), rng or Rng(0)
        self.retry_limit, self.rss_backoff = retry_limit, rss_backoff
        self.groups, self.role, self.poll_required = groups, role, poll_required
        # 10.42.2.3.3: RXSS — «from the DMG antenna and sector that were selected during the preceding TXSS»
        self.rxss_sector = rxss_sector if rxss_sector is not None else self.plan[0]
        self.honor_access_period = honor_access_period
        self.failed, self.bi_backoff, self.block, self.pending = 0, None, 0, {}
        self.fb = None                       # последний полученный SSW-Feedback
        self.initiations = 0
        self.state = 'idle'

    # ---- начало A-BFT ----
    def begin_abft(self, beacon, layout):
        """Решение об участии и выбор backoff. Возвращает True, если STA участвует в этой A-BFT."""
        self.layout, self.beacon, self.seq, self.pos = layout, beacon, None, 0
        self.state = 'out'
        if not may_access(beacon, self.addr, self.groups, self.role):
            return False                              # 10.42.5.2: без маяка / не допущена
        if self.bi_backoff is not None:
            # 10.42.5.2: «may reinitiate RSS only during an A-BFT when the backoff count becomes zero»;
            # уменьшение — «at the end of each A-BFT period in the following beacon intervals» (end_abft)
            if self.bi_backoff > 0:
                self.state = 'bi_backoff'
                return False
            self.bi_backoff = None
        if self.block > 0 and not addressed(beacon, self.addr):
            # 10.42.5.2: «should not attempt to access the following aMaxABFTAccessPeriod A-BFT allocations»
            self.block -= 1
            return False
        self.block = 0
        self.is_txss = bool(beacon.bic.is_responder_txss)
        # 10.42.5.2: продолжение незавершённого RSS — «at the next A-BFT for which the value of the IsResponderTXSS
        # field is the same»; СПОРНО: в A-BFT другого типа — новый RSS этого типа (текст не запрещает), а
        # незавершённый ждёт A-BFT своего типа.
        self.resume = self.pending.pop(self.is_txss, None)
        self._backoff()
        return True

    def _backoff(self):
        """10.42.5.2: «a random integer drawn from a uniform distribution [0, A-BFT Length)», A-BFT Length — из
        последнего принятого DMG Beacon (число слотов)."""
        self.count = self.rng.draw(self.beacon.bic.abft_slots - 1)
        self.state = 'backoff'

    def _new_seq(self):
        if self.is_txss:
            return sweep_positions(self.plan, self.beacon.n_init_rx_ant)
        # 10.42.2.3.3 / 10.42.5.2: RXSS — ровно FSS кадров из выбранного сектора
        return [self.rxss_sector] * self.layout.fss

    # ---- слот ----
    def slot_tx(self, s):
        """Кадры SSW, которые STA передаёт в слоте s (пусто — молчит)."""
        if self.state == 'backoff':
            if self.count != 0:
                return []
            # 10.42.5.2: «may initiate the RSS only at the start of the SSW slot for which the backoff count is 0»
            if self.resume is not None:
                self.seq, self.resume = self.resume, None
            else:
                self.seq = self._new_seq()
                self.initiations += 1
            self.pos = 0
            self.state = 'tx'
        if self.state != 'tx':
            return []
        L, b = self.layout, self.beacon
        # слот начинается с реального кадра (на границе слота SBIFS/LBIFS не соблюдается, 10.42.2.3.2)
        while self.seq[self.pos] is None:
            self.pos += 1
        total = len(self.seq)
        win = self.seq[self.pos:self.pos + L.fss]       # 10.42.5.2: не больше FSS кадров в слоте
        out = []
        for k, x in enumerate(win):
            if x is None:
                continue
            ant, sec = x
            cdown = total - 1 - (self.pos + k)
            f = AirFrame('SSW', L.ssw_pos(s, k), self.addr, b.ap, direction=1, cdown=cdown, sector_id=sec,
                         ant_id=ant, sector_select=b.best[0], ant_select=b.best[1], snr=b.best[2],
                         poll=self.poll_required)
            # 9.3.1.15: в A-BFT Duration — «time until the end of the current SSW slot»
            f.duration = duration_ssw(cdown, abft_slot_remaining=L.slot_end(s) - f.end)
            out.append(f)
        self.pos += len(win)
        # хвост окна — фантомные LBIFS: в следующем слоте не нужны
        self.done_sweep = self.pos >= total
        self.tx_slot = s
        return out

    def slot_end(self, s, fb=None):
        """Конец слота s; fb — SSW-Feedback, принятый в этом слоте (любой; чужой игнорируется)."""
        last = s == self.layout.n_slots - 1
        if self.state == 'backoff':
            # 10.42.5.2: «decrement the backoff count by one at the end of each SSW slot, even if the CS … busy»
            self.count -= 1
            return
        if self.state != 'tx' or self.tx_slot != s:
            return
        if fb is not None and fb.dst == self.addr:
            # 10.42.2.4: ответ до завершения RSS — «may cease the RSS»; 10.42.5.2: «set FailedRSSAttempts to 0
            # upon receiving an SSW-Feedback frame during the A-BFT»
            self.fb, self.failed, self.state = fb, 0, 'done'
            if self.beacon.bic.discovery_mode and self.honor_access_period:
                self.block = aMaxABFTAccessPeriod
            return
        if not self.done_sweep:
            # 10.42.5.2: «may resume the RSS at the start of the following SSW slot provided that the A-BFT has not
            # ended»; иначе — при следующей A-BFT того же типа (end_abft)
            return
        # RSS завершён без SSW-Feedback → неудачная попытка
        self.failed += 1
        if self.failed > self.retry_limit:
            # 10.42.5.2: «If FailedRSSAttempts exceeds dot11RSSRetryLimit … [0, dot11RSSBackoff)»
            # СПОРНО: в остатке текущей A-BFT не продолжаем (счёт идёт по «following beacon intervals»)
            self.bi_backoff = self.rng.draw(self.rss_backoff - 1)
            self.state = 'done'
            return
        if not last:
            # 10.42.5.2: перезапуск в той же A-BFT — backoff «beginning at the start of the SSW slot following the
            # completion of the RSS»
            self._backoff()
        else:
            self.state = 'done'

    def end_abft(self):
        """10.42.5.2: «At the end of an A-BFT the responder shall cancel a backoff procedure …»."""
        if self.state == 'tx' and not self.done_sweep:
            self.pending[self.is_txss] = self.seq[self.pos:]
        elif self.state == 'bi_backoff':
            self.bi_backoff -= 1
        self.state = 'idle'


# ======================================================================================================
#                                     Точка-инициатор (10.42.5.2–10.42.5.4)
# ======================================================================================================
class Obligation:
    """Обязанность точки после A-BFT: kind — 'poll_alloc' (Poll Required и TDDTI, 10.42.5.2), 'brp_cap' (BRP с
    Capability Request, 10.42.5.2), 'brp_alloc' (выделение BRP, 10.42.5.3); окно BI [first, last]; sector — сектор
    для BRP/Announce/Grant (Sector Select ответчика)."""
    def __init__(self, kind, sta, first, last, sector=None):
        self.kind, self.sta, self.first, self.last, self.sector = kind, sta, first, last, sector

    def __repr__(self):
        return f'Obligation({self.kind} {self.sta} BI {self.first}..{self.last} sec={self.sector})'


class ApAbft:
    """Точка в A-BFT: принимает SSW квази-омни одной антенной (10.42.5.4), в слоте с принятыми SSW передаёт
    SSW-Feedback одному ответчику. fb_incomplete — отвечать ли, если RSS в слоте не завершён (10.42.5.2: «may»);
    tddti — TDDTI в своём DMG Capabilities (Poll Required → выделение)."""
    def __init__(self, addr, layout, bi=0, fb_incomplete=True, tddti=0, need_brp=False):
        self.addr, self.layout, self.bi = addr, layout, bi
        self.fb_incomplete, self.tddti, self.need_brp = fb_incomplete, tddti, need_brp
        self.obligations = []
        self.heard = {}                  # sta → последние SSW (для ISS+RSS в DTI, 10.42.5.3)

    def slot_feedback(self, s, rx):
        """rx — SSW, принятые точкой в слоте s (после модели коллизий). Возвращает AirFrame SSW-Feedback или None."""
        if not rx:
            return None
        by = {}
        for f in rx:
            by.setdefault(f.src, []).append(f)
            self.heard[f.src] = f
        # выбор ответчика при нескольких — «implementation dependent»: максимум SNR приёма
        sta = max(by, key=lambda a: max((f.rx_snr or 0) for f in by[a]))
        frs = by[sta]
        complete = any(f.cdown == 0 for f in frs)
        if not complete and not self.fb_incomplete:
            return None
        best = max(frs, key=lambda f: f.rx_snr or 0)
        L = self.layout
        fb = AirFrame('SSW-Feedback', L.fb_start(s), self.addr, sta, duration=0, snr=best.rx_snr)
        if L.is_txss:
            # 10.42.2.4: TXSS — Sector Select / DMG Antenna Select лучшего кадра; передача через сектор, выбранный
            # ответчиком (Sector Select из его SSW)
            fb.sector_select, fb.ant_select = best.sector_id, best.ant_id
        # RXSS — поля Select reserved (10.42.2.4)
        fb.tx_sector = (best.ant_select, best.sector_select)
        self._oblige(sta, best)
        return fb

    def _oblige(self, sta, ssw):
        b, w = self.bi, aMinBTIPeriod - 1
        # 10.42.5.2: Poll Required = 1 и TDDTI = 1 → время в ATI/SP «of at least one of the following aMinBTIPeriod
        # beacon intervals beginning with the beacon interval in which the SSW frame was received»
        if ssw.poll and self.tddti:
            self.obligations.append(Obligation('poll_alloc', sta, b, b + w))
        # 10.42.5.2: после SSW-Feedback — BRP с Capability Request = 1, MCS 0, через Sector Select ответчика
        self.obligations.append(Obligation('brp_cap', sta, b, b + w, (ssw.ant_select, ssw.sector_select)))
        # 10.42.5.3: при необходимости BRP — выделение (SP/CBAP/Grant/CBAP-only) в те же aMinBTIPeriod BI
        if self.need_brp:
            self.obligations.append(Obligation('brp_alloc', sta, b, b + w))


def simulate_abft(ap, stas, beacons, capture=False):
    """Одна A-BFT: ap — ApAbft, stas — [Responder], beacons — {addr: BeaconRx}. Модель приёма: STA, одна в слоте,
    принимается вся; при нескольких (рис. 10-75: «might result in a collision») — capture=False: никто,
    capture=True: только с наибольшим rx_snr. Возвращает журнал [AirFrame]."""
    L = ap.layout
    live = [st for st in stas if st.begin_abft(beacons.get(st.addr), L)]
    log = []
    for s in range(L.n_slots):
        tx = {st.addr: st.slot_tx(s) for st in live}
        tx = {a: f for a, f in tx.items() if f}
        for frs in tx.values():
            log.extend(frs)
        if len(tx) == 1:
            rx = next(iter(tx.values()))
        elif len(tx) > 1 and capture:
            a = max(tx, key=lambda a: max((f.rx_snr or 0) for f in tx[a]))
            rx = tx[a]
        else:
            rx = []
        fb = ap.slot_feedback(s, rx)
        if fb is not None:
            log.append(fb)
        for st in live:
            st.slot_end(s, fb)
    for st in stas:
        st.end_abft()
    return sorted(log, key=lambda f: f.t)


# ======================================================================================================
#                                    Проверка журнала одной A-BFT
# ======================================================================================================
def check_abft_log(frames, layout, ap, start_tol=ABFT_SSW_START_TOL, fb_tol=ABFT_FB_TOL):
    """Проверка журнала эфира одной A-BFT (точка ap, границы layout).

    frames — [AirFrame] за интервал A-BFT (порядок любой). start_tol — допуск начала SSW относительно начала слота
    (СПОРНО → принято, PLAN.md №4: timing.ABFT_SSW_START_TOL = aAirPropagationTime — то же в bi.check_air_log);
    fb_tol — допуск SSW-Feedback («occurs at aSSFBDuration + MBIFS before the end» — точка; принято, PLAN.md:
    timing.ABFT_FB_TOL = MBIFS_TOL, только опоздание, как у MBIFS 10.3.2.3.10).

    Правила (Violation.rule):
      'kind'       — в A-BFT только SSW (от ответчиков) и SSW-Feedback (от точки): BRP — нет (10.42.5.2),
                     SSW-Ack — нет (10.42.2.1, 10.42.5.2), в RSS — только SSW (10.42.2.3.1);
      'mcs'        — SSW/SSW-Feedback не на MCS 0 (10.6.7.1);
      'window'     — кадр вне A-BFT или пересекает границу слота (10.42.5.2);
      'ssw_addr'   — SSW от точки или не на точку (10.42.5.2: точка — инициатор; 9.3.1.15 RA);
      'direction'  — Direction ≠ 1 (10.42.2.3.1);
      'ssw_start'  — первый SSW STA в слоте не в начале слота (10.42.5.2);
      'ssw_late'   — SSW кончается позже aSSDuration от начала слота (10.42.5.2, рис. 10-76);
      'fss'        — больше FSS кадров STA в слоте (10.42.5.2); RXSS — не ровно FSS (10.42.5.2);
      'gap'        — между SSW одной STA не SBIFS [aSBIFSTime, +aSBIFSAccuracy] (10.3.2.3.8) и не LBIFS
                     [LBIFS, +10 %…] (10.3.2.3.11); LBIFS — только при смене DMG Antenna ID;
      'cdown'      — CDOWN не убывает на 1 (через LBIFS — на 2, см. sweep_positions) в слоте и между соседними
                     слотами при продолжении; RXSS — CDOWN FSS−1…0 (10.42.2.3.2, 10.42.2.3.3);
      'resume'     — незавершённый RSS продолжен не в следующем слоте (10.42.5.2) или новый RSS начат в той же
                     A-BFT до завершения предыдущего (перезапуск — только после завершения, 10.42.5.2);
      'rxss_sector'— RXSS: Sector ID/DMG Antenna ID меняются (один сектор передачи, 10.42.2.3.3);
      'ant_order'  — TXSS: DMG Antenna ID убывает внутри прохода (10.42.2.3.2);
      'ssw_dur'    — Duration SSW ≠ ⌈конец слота − конец PPDU⌉ (9.3.1.15, 9.2.5.1);
      'fb_src'     — SSW-Feedback не от точки; 'fb_time' — не в момент конец слота − aSSFBDuration − MBIFS
                     (10.42.5.2); 'fb_dur' — Duration ≠ 0 (9.3.1.16); 'fb_multi' — больше одного в слоте;
      'fb_dst'     — SSW-Feedback STA, не передававшей SSW в этом слоте (10.42.5.2: «based on the SSW frames
                     received during the SSW slot»);
      'fb_select'  — TXSS: Sector Select/DMG Antenna Select не из SSW этой STA в слоте (10.42.2.4);
      'fb_sector'  — SSW-Feedback передан не через сектор из Sector Select ответчика (10.42.2.4), если tx_sector
                     известен."""
    L, out = layout, []
    idx = sorted(range(len(frames)), key=lambda i: frames[i].t)
    per = {}                     # (slot, sta) → [i]
    fbs = {}                     # slot → [i]
    for i in idx:
        f = frames[i]
        if f.kind not in ('SSW', 'SSW-Feedback'):
            out.append(Violation(i, 'kind', f'{f.kind} в A-BFT'))
            continue
        if f.mcs != 0:
            out.append(Violation(i, 'mcs', f'{f.kind} на MCS {f.mcs}'))
            continue
        s = L.slot_of(f.t)
        if s is None or f.end > L.slot_end(s):
            out.append(Violation(i, 'window', f'{f} вне слота'))
            continue
        if f.kind == 'SSW':
            if f.src == ap or f.dst != ap:
                out.append(Violation(i, 'ssw_addr', f'{f}'))
            if f.direction != 1:
                out.append(Violation(i, 'direction', f'Direction={f.direction}'))
            if f.duration is not None and f.duration != duration_ssw(f.cdown, abft_slot_remaining=L.slot_end(s) - f.end):
                out.append(Violation(i, 'ssw_dur', f'Duration {f.duration}'))
            per.setdefault((s, f.src), []).append(i)
        else:
            if f.src != ap:
                out.append(Violation(i, 'fb_src', f'{f}'))
            if not (L.fb_start(s) <= f.t <= L.fb_start(s) + fb_tol):
                out.append(Violation(i, 'fb_time', f'SSW-Feedback @{float(f.t - L.slot_start(s)):.3f} от начала слота'))
            if f.duration not in (None, 0):
                out.append(Violation(i, 'fb_dur', f'Duration {f.duration}'))
            fbs.setdefault(s, []).append(i)

    # ---- SSW по (слот, STA) ----
    last = {}                    # sta → (slot, cdown последнего кадра, i)
    for (s, sta) in sorted(per):
        ii = per[(s, sta)]
        fr = [frames[i] for i in ii]
        if not (L.slot_start(s) <= fr[0].t <= L.slot_start(s) + start_tol):
            out.append(Violation(ii[0], 'ssw_start', f'первый SSW @{float(fr[0].t - L.slot_start(s)):.3f}'))
        if len(fr) > L.fss:
            out.append(Violation(ii[-1], 'fss', f'{len(fr)} SSW > FSS {L.fss}'))
        if not L.is_txss and len(fr) != L.fss:
            out.append(Violation(ii[-1], 'fss', f'RXSS: {len(fr)} SSW ≠ FSS {L.fss}'))
        # допуск конца aSSDuration: сдвиг начала + допуски всех промежутков (SBIFS/LBIFS)
        late = L.ssw_window_end(s) + max(Fr(0), fr[0].t - L.slot_start(s))
        for j in range(1, len(fr)):
            a, b = fr[j - 1], fr[j]
            gap = b.t - a.end
            sw = a.ant_id != b.ant_id
            if not sw and SBIFS <= gap <= SBIFS + aSBIFSAccuracy:
                step = 1
                late += aSBIFSAccuracy
            elif L.is_txss and LBIFS <= gap <= LBIFS + LBIFS_TOL:
                step = 2
                late += LBIFS_TOL
            else:
                out.append(Violation(ii[j], 'gap', f'промежуток {float(gap):.3f} мкс'))
                step = 1
            if a.cdown is not None and b.cdown is not None and b.cdown != a.cdown - step:
                out.append(Violation(ii[j], 'cdown', f'CDOWN {a.cdown} → {b.cdown}'))
            if L.is_txss and b.ant_id is not None and a.ant_id is not None and b.ant_id < a.ant_id:
                # СПОРНО: повтор прохода для следующей антенны инициатора начинается снова с меньшего ID — в A-BFT
                # точка принимает одной антенной (10.42.5.4), поэтому повтора нет и убывание — нарушение
                out.append(Violation(ii[j], 'ant_order', f'DMG Antenna ID {a.ant_id} → {b.ant_id}'))
        if fr[-1].end > late:
            out.append(Violation(ii[-1], 'ssw_late', 'SSW кончается после aSSDuration'))
        if not L.is_txss:
            if [f.cdown for f in fr] != list(range(len(fr) - 1, -1, -1)):
                out.append(Violation(ii[0], 'cdown', f'RXSS CDOWN {[f.cdown for f in fr]}'))
            if len({(f.ant_id, f.sector_id) for f in fr}) > 1:
                out.append(Violation(ii[0], 'rxss_sector', 'RXSS через разные секторы'))
        # продолжение / перезапуск
        if sta in last:
            ps, pc, pi = last[sta]
            got_fb = any(frames[k].dst == sta for k in fbs.get(ps, []))
            # CDOWN неизвестен (None) у синтетических SSW из отчёта приёма PMC — тело нулевое: продолжение не судим
            if pc is not None and pc != 0 and not got_fb:
                if s != ps + 1:
                    out.append(Violation(ii[0], 'resume', f'продолжение RSS в слоте {s} вместо {ps + 1}'))
                elif L.is_txss and fr[0].cdown is not None and fr[0].cdown not in (pc - 1, pc - 2):
                    out.append(Violation(ii[0], 'cdown', f'CDOWN через слот {pc} → {fr[0].cdown}'))
        last[sta] = (s, fr[-1].cdown, ii[-1])

    # ---- SSW-Feedback ----
    for s, ii in fbs.items():
        if len(ii) > 1:
            out.append(Violation(ii[1], 'fb_multi', f'{len(ii)} SSW-Feedback в слоте {s}'))
        for i in ii:
            f = frames[i]
            mine = [frames[k] for k in per.get((s, f.dst), [])]
            if not mine:
                out.append(Violation(i, 'fb_dst', f'SSW-Feedback {f.dst} без SSW в слоте {s}'))
                continue
            if L.is_txss and f.sector_select is not None and \
                    (f.ant_select, f.sector_select) not in {(m.ant_id, m.sector_id) for m in mine}:
                out.append(Violation(i, 'fb_select', f'Sector Select {f.sector_select} не из принятых'))
            if f.tx_sector is not None and f.tx_sector not in {(m.ant_select, m.sector_select) for m in mine}:
                out.append(Violation(i, 'fb_sector', f'передача через {f.tx_sector}'))
    return sorted(out, key=lambda v: v.idx)


# ======================================================================================================
#                          Обязанности точки после A-BFT (10.42.5.2, 10.42.5.3)
# ======================================================================================================
def check_obligations(obligations, events):
    """events — [(bi, kind, dst, mcs, tx_sector)] передач/выделений точки после A-BFT: kind — 'Announce' | 'Grant'
    | 'Poll' | 'ESE-SP' (Extended Schedule, SP/ATI-время для STA) | 'BRP-cap' (BRP с Capability Request = 1) |
    'BRP-alloc' (выделение под BRP, 10.42.5.3 1–4).
    Правила: 'poll_alloc' — нет Poll/Grant/ESE-SP/Announce для STA в окне (10.42.5.2); 'brp_cap' — нет BRP-cap в
    окне (10.42.5.2); 'brp_alloc' — нет выделения в окне (10.42.5.3); 'mcs0' — BRP-cap/Announce/Grant STA не на
    MCS 0; 'sector' — не через Sector Select ответчика (10.42.5.2, 10.42.5.3)."""
    out = []
    want = {'poll_alloc': ('Poll', 'Grant', 'ESE-SP', 'Announce'), 'brp_cap': ('BRP-cap',),
            'brp_alloc': ('BRP-alloc', 'Grant')}
    for n, o in enumerate(obligations):
        hit = [e for e in events if e[2] == o.sta and e[1] in want[o.kind] and o.first <= e[0] <= o.last]
        if not hit:
            out.append(Violation(n, o.kind, f'{o}: нет в BI {o.first}..{o.last}'))
        if o.kind == 'brp_cap':
            for e in [e for e in events if e[2] == o.sta and e[1] in ('BRP-cap', 'Announce', 'Grant')]:
                if e[3] != 0:
                    out.append(Violation(n, 'mcs0', f'{e[1]} на MCS {e[3]}'))
                if o.sector is not None and e[4] is not None and e[4] != o.sector:
                    out.append(Violation(n, 'sector', f'{e[1]} через {e[4]} вместо {o.sector}'))
    return out


def sta_may_retry(bi_now, bi_last_attempt, got_announce_or_grant):
    """10.42.5.2: STA может повторить BF в A-BFT, если нет Announce/Grant «until aMinBTIPeriod beacon intervals after
    the beacon interval in which the SLS phase … was last attempted»."""
    return not got_announce_or_grant and bi_now - bi_last_attempt >= aMinBTIPeriod

