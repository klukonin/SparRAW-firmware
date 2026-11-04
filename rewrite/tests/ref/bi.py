# SPDX-License-Identifier: AGPL-3.0-or-later
"""Структура интервала маяков (BI) DMG по 802.11-2020: TBTT и TSF (11.1.2.1, 11.1.3.3), периоды доступа BTI, A-BFT,
ATI, DTI (10.39.2, 10.39.3, 10.42.4, 10.42.5.1–10.42.5.2), DTI из CBAP и SP по Extended Schedule (9.4.2.131,
10.39.4–10.39.6.5), поля Beacon Interval Control и DMG Parameters (9.3.4.2, 9.4.1.46) в смысловом виде, порядок
DMG Beacon по секторам в BTI и фрагментированный TXSS (10.42.4, 10.42.2.2.2, 11.1.3.3.1), guard time и
RxAdvanceTime (10.39.6.5, 10.39.2), псевдостатичные распределения (10.39.6.4). Время — Fraction, мкс, TSF AP/PCP;
моменты кадров — «на эфире» (10.3.7).

Состав:
  константы табл. 11-22 и MIB (dot11MaxLostBeacons, dot11MinBHIDuration);
  ceil_to, rx_advance_time, guard_time, guard_between — формулы 10.39.2 и 10.39.6.5;
  ss_duration, ss_slot_time, abft_slot, ssw_fb_start — A-BFT (10.42.5.2, табл. 11-22);
  BeaconIntervalControl, DmgParameters — подполя (сырые значения как на эфире) + validate;
  Allocation — поле Allocation (рис. 9-563/9-564), блоки (10.39.6.1), validate, recur (псевдостатика);
  full_tsf, pseudo_static_valid, obsolete — 10.39.6.1, 10.39.6.4;
  txss_plan, bti_beacons — порядок и времена DMG Beacon в BTI (10.42.4, 10.42.2.2.2, 9.3.4.2);
  BiConfig, layout, period_at — периоды BI k; check_schedule — инварианты расписания;
  Bss, check_air_log — проверка журнала эфира на инварианты BI (список Violation).

Не моделируется: CMMG/CDMG (каналы 540/1080 МГц, BHI на 1,08 ГГц), кластеризация AP/PCP (10.40) и ECAPC-случайная
задержка маяка (11.1.3.3.1), PCP power save (A-BI/D-BI, 11.2.7), spatial sharing (11.30), DMG protected period
(10.39.6.6), SP recovery (10.39.6.7), правила PP/GP внутри SP (10.39.7) — кроме допуска «динамических» окон,
переданных вызывающим, MMSL-кластеры, несколько антенн AP (A-BFT Count, N A-BFT in Ant, LBIFS в BTI), выбор слота
A-BFT и FailedRSSAttempts (это abft.py), поле Duration кадров (duration.py), правила EDCA внутри CBAP (cbap.py),
Discovery Mode (11.1.3.4) — только ограничение Next A-BFT = 0."""
from fractions import Fraction as Fr
from math import ceil, floor

from . import duration as D
from .cbap import Violation
from .timing import (aAirPropagationTime, ABFT_FB_TOL, ABFT_SSW_START_TOL, aDMGPPMinListeningTime, aDMGTSFAccuracy,
                     AID_AP_PCP, AID_BROADCAST, ALLOC_CBAP, ALLOC_SP, aMaxABFTAccessPeriod, aMaxBIDuration,
                     aMinAllocationDeliveryTime, aMinBTIPeriod, aSBIFSAccuracy, aSIFSTime, aSSFramesPerSlot,
                     aTSFResolution, BCAST, ceil_to, DOT11_MAX_LOST_BEACONS, LBIFS, LBIFS_TOL, MBIFS, MBIFS_TOL,
                     SBIFS, SBIFS_MAX, SIFS, SIFS_TOL, ss_duration, ss_fb_duration, ss_slot_time, T_SSW, T_SSW_FB,
                     TSF_LOW_MOD, TU, txtime_control)

# TU (3.1), табл. 11-22, MIB dot11MaxLostBeacons (11.1.3.3.3: AP ставит aMinBTIPeriod = DEFVAL 4) и
# dot11MinBHIDuration, AID (9.4.1.8), TSF_LOW_MOD (9.4.2.131), SBIFS_MAX/SIFS_TOL (10.3.2.3), T_SSW/T_SSW_FB
# (10.6.7.1: DMG Control) — timing.py (одно определение на все модули).

# ====================== формулы 1.5, 10.39.2, 10.39.6.5 ======================
# ceil_to (1.5 «Ceil (x, y)») — timing.py
def rx_advance_time(t_di, c=aDMGTSFAccuracy):
    """10.39.2: RxAdvanceTime = Ceil(C·T_DI/10⁶ + T_P, T_TR); T_DI — мкс от приёма Timestamp AP/PCP."""
    return ceil_to(Fr(c) * Fr(t_di) / 10 ** 6 + aAirPropagationTime, aTSFResolution)


def guard_time(a_i, d_i, a_next, d_next, c=aDMGTSFAccuracy):
    """10.39.6.5: T_guard = Ceil(((A_i+1)·C·D_i + (A_{i+1}+1)·C·D_{i+1})/10⁶ + SIFS + T_P, T_TR)."""
    num = (a_i + 1) * c * Fr(d_i) + (a_next + 1) * c * Fr(d_next)
    return ceil_to(num / 10 ** 6 + aSIFSTime + aAirPropagationTime, aTSFResolution)


def guard_between(ps_i, ps_next, bi_us, d_i=None, d_next=None, max_lost=DOT11_MAX_LOST_BEACONS):
    """10.39.6.5: A = dot11MaxLostBeacons и D = длительность BI для псевдостатичного распределения, A = 0 и D — время
    с синхронизирующего события (параметр) для непсевдостатичного.
    СПОРНО: для непсевдостатичного стандарт даёт только «time elapsed since a synchronizing reference event»; по
    умолчанию берётся худший случай внутри BI — D = BI (синхронизация в BTI этого BI); вызывающий может передать
    точное D (например, конец распределения − TBTT)."""
    a_i, a_n = (max_lost if ps_i else 0), (max_lost if ps_next else 0)
    di = bi_us if ps_i or d_i is None else d_i
    dn = bi_us if ps_next or d_next is None else d_next
    return guard_time(a_i, di, a_n, dn)


# ====================== A-BFT (10.42.5.2, табл. 11-22) ======================
# ss_duration / ss_fb_duration / ss_slot_time — timing.py (общие с abft.py). СПОРНО → принято (PLAN.md «Принятые
# трактовки» №1): FSS в них — число кадров (= поле FSS + 1): рис. 10-75 «value of FSS is 8» при 8 кадрах, 9.3.4.2
# «minus one».


def abft_slot(abft_start, i, fss_frames, **kw):
    """10.42.5.2: «The first SSW slot begins at the start of the A-BFT, and the following SSW slots are adjacent»."""
    s = ss_slot_time(fss_frames, **kw)
    return abft_start + i * s, abft_start + (i + 1) * s


def ssw_fb_start(slot_end, t_ssw_fb=T_SSW_FB):
    """10.42.5.2: начало SSW-Feedback на эфире — «aSSFBDuration + MBIFS before the end of the SSW slot»."""
    return slot_end - ss_fb_duration(t_ssw_fb) - MBIFS


# ====================== поля DMG Beacon (9.3.4.2, 9.4.1.46) ======================
class BeaconIntervalControl:
    """Рис. 9-77 — подполя в сырых значениях (как на эфире): A-BFT Length = слоты − 1, FSS = кадры − 1."""
    WIDTH = dict(cc_present=1, discovery_mode=1, next_beacon=4, ati_present=1, abft_length=3, fss=4,
                 is_responder_txss=1, next_abft=4, fragmented_txss=1, txss_span=7, n_bis_abft=4, abft_count=6,
                 n_abft_in_ant=6, pcp_association_ready=1)

    def __init__(self, cc_present=0, discovery_mode=0, next_beacon=0, ati_present=0, abft_length=7, fss=7,
                 is_responder_txss=1, next_abft=0, fragmented_txss=0, txss_span=1, n_bis_abft=1, abft_count=0,
                 n_abft_in_ant=0, pcp_association_ready=0):
        for k in self.WIDTH:
            setattr(self, k, locals()[k])

    @property
    def abft_slots(self):
        """9.3.4.2: «A-BFT Length … number of sector sweep slots … minus 1»."""
        return self.abft_length + 1

    @property
    def fss_frames(self):
        """9.3.4.2: «FSS … number of SSW frames allowed minus one»."""
        return self.fss + 1

    @property
    def abft_present(self):
        """9.3.4.2 / 10.42.5.1: «Next A-BFT … set to 0 if the A-BFT immediately follows this BTI»."""
        return self.next_abft == 0

    def validate(self, max_lost=DOT11_MAX_LOST_BEACONS):
        out = []
        for k, w in self.WIDTH.items():
            if not 0 <= getattr(self, k) < (1 << w):
                out.append(('bic_range', f'{k}={getattr(self, k)} вне {w} бит (рис. 9-77)'))
        if self.fss_frames < aSSFramesPerSlot:
            out.append(('bic_fss', f'FSS {self.fss_frames} кадров < aSSFramesPerSlot (10.42.5.2, PLAN.md №1)'))
        if self.txss_span < 1:
            out.append(('bic_txss_span', 'TXSS Span < 1 (9.3.4.2: «always greater than or equal to 1»)'))
        if self.txss_span > max_lost:
            out.append(('bic_txss_span', f'TXSS Span {self.txss_span} > dot11MaxLostBeacons (11.1.2.1)'))
        if self.discovery_mode and self.next_abft != 0:
            out.append(('bic_discovery', 'Discovery Mode 1 и Next A-BFT ≠ 0 (11.1.3.4)'))
        if self.n_bis_abft == 0:
            # 9.3.4.2: «set to 1 if every beacon interval contains an A-BFT» — 0 не имеет смысла интервала
            out.append(('bic_n_bis_abft', 'N BIs A-BFT = 0'))
        return out

    def same_as(self, other):
        return all(getattr(self, k) == getattr(other, k) for k in self.WIDTH)


class DmgParameters:
    """Рис. 9-133 / 9.4.1.46: BSS Type (3 — AP, 2 — PCP), CBAP Only, CBAP Source, DMG Privacy, ECAPC."""
    def __init__(self, bss_type=3, cbap_only=0, cbap_source=0, privacy=0, ecapc=0):
        self.bss_type, self.cbap_only, self.cbap_source, self.privacy, self.ecapc = (bss_type, cbap_only,
                                                                                     cbap_source, privacy, ecapc)


# ====================== Allocation (9.4.2.131) ======================
SP, CBAP = 'SP', 'CBAP'
ALLOC_TYPE_CODE = {SP: ALLOC_SP, CBAP: ALLOC_CBAP}   # табл. 9-257 (биты 4..6: 000 — SP, 100 — CBAP; 2,16 ГГц)


class Allocation:
    """Поле Allocation (рис. 9-563) с Allocation Control (рис. 9-564, DMG). start — младшие 32 бита TSF, мкс."""
    __slots__ = ('alloc_id', 'alloc_type', 'pseudo_static', 'truncatable', 'extendable', 'pcp_active', 'lp_sc',
                 'src_aid', 'dst_aid', 'start', 'block_dur', 'n_blocks', 'block_period')

    def __init__(self, alloc_type, src_aid, dst_aid, start, block_dur, n_blocks=1, block_period=0, alloc_id=1,
                 pseudo_static=0, truncatable=0, extendable=0, pcp_active=1, lp_sc=0):
        self.alloc_type, self.src_aid, self.dst_aid = alloc_type, src_aid, dst_aid
        self.start, self.block_dur, self.n_blocks, self.block_period = start, block_dur, n_blocks, block_period
        self.alloc_id, self.pseudo_static, self.truncatable, self.extendable = (alloc_id, pseudo_static, truncatable,
                                                                                extendable)
        self.pcp_active, self.lp_sc = pcp_active, lp_sc

    def key(self):
        """9.4.2.131: «the tuple (Source AID, Destination AID, Allocation ID) uniquely identifies the allocation»."""
        return (self.src_aid, self.dst_aid, self.alloc_id)

    def fields(self):
        return tuple(getattr(self, k) for k in self.__slots__)

    def blocks(self, ref_tsf=0):
        """10.39.6.1: начало i-го блока = A_start + (i − 1)·A_period, i = 1..Number of Blocks; конец = начало +
        Allocation Block Duration. Полный TSF начала — full_tsf(start, ref_tsf)."""
        s0 = full_tsf(self.start, ref_tsf)
        per = self.block_period if self.n_blocks > 1 else 0     # 9.4.2.131: период резервный при 1 блоке
        return [(s0 + i * per, s0 + i * per + self.block_dur) for i in range(self.n_blocks)]

    def validate(self, by_ap=True):
        """Ограничения 9.4.2.131 / 10.39.6.x на одно поле. by_ap — передаёт AP (не PCP)."""
        out = []
        lim = 32767 if self.alloc_type == SP else 65535
        # 9.4.2.131: «from 1 to 32 767 for an SP allocation and 1 to 65 535 for a CBAP allocation»
        if not 1 <= self.block_dur <= lim:
            out.append(('alloc_dur', f'Allocation Block Duration {self.block_dur} вне 1..{lim}'))
        if not 1 <= self.n_blocks <= 255:       # рис. 9-563: 1 октет; 0 блоков — пустое распределение
            out.append(('alloc_blocks', f'Number of Blocks {self.n_blocks}'))
        if self.n_blocks > 1 and self.block_period < self.block_dur:
            # блоки одного распределения не перекрываются (иначе «time blocks» теряют смысл, 10.39.6.1)
            out.append(('alloc_period', f'Allocation Block Period {self.block_period} < длительности блока'))
        if not 0 <= self.alloc_id < 16:
            out.append(('alloc_id', 'Allocation ID вне 4 бит'))
        bb = self.src_aid == AID_BROADCAST and self.dst_aid == AID_BROADCAST
        if self.alloc_type == CBAP and bb and self.alloc_id != 0:
            # 9.4.2.131: «For CBAP allocations with broadcast Source AID and broadcast Destination AID, the Allocation
            # ID subfield is set to 0»
            out.append(('alloc_id', 'CBAP broadcast/broadcast с Allocation ID ≠ 0'))
        if self.alloc_type == SP and self.alloc_id == 0:
            # 9.4.2.131: «when set to a nonzero value, identifies an airtime allocation»
            out.append(('alloc_id', 'SP с Allocation ID 0 (не идентифицируется)'))
        if self.alloc_type == CBAP and (self.truncatable or self.extendable):
            # 9.4.2.131: для CBAP Truncatable/Extendable «reserved» — должны быть 0
            out.append(('alloc_reserved', 'Truncatable/Extendable в CBAP — резерв'))
        if by_ap and not self.pcp_active:
            # 10.39.6.1: «The AP shall set the PCP Active field to 1 for every allocation»
            out.append(('alloc_pcp_active', 'AP передал PCP Active = 0'))
        if (self.truncatable or self.extendable) and not self.pcp_active:
            # 9.4.2.131: PCP Active = 1 «At least one of the Truncatable or Extendable subfields is set to 1»
            out.append(('alloc_pcp_active', 'Truncatable/Extendable при PCP Active = 0'))
        if self.lp_sc and self.alloc_type != SP:
            # 10.39.4: LP SC — «only within SPs that have the LP SC Used subfield … equal to 1»
            out.append(('alloc_lp_sc', 'LP SC Used в CBAP'))
        for a in (self.src_aid, self.dst_aid):
            if not 0 <= a <= 255:
                out.append(('alloc_aid', f'AID {a}'))
        return out

    def recur(self, k_from, k_to, bi_us):
        """10.39.6.4: псевдостатичное «recurs at the same relative offset to TBTT and with the same duration»."""
        a = Allocation.__new__(Allocation)
        for k in self.__slots__:
            setattr(a, k, getattr(self, k))
        a.start = int((Fr(self.start) + (k_to - k_from) * Fr(bi_us)) % TSF_LOW_MOD)
        return a

    def __repr__(self):
        return (f'Allocation({self.alloc_type} {self.src_aid}->{self.dst_aid} id={self.alloc_id} @{self.start} '
                f'{self.block_dur}×{self.n_blocks}/{self.block_period} ps={self.pseudo_static})')


def full_tsf(low32, ref_tsf):
    """TSF по младшим 32 битам (9.4.2.131).
    СПОРНО: стандарт не говорит, как достраивать старшие биты. Берётся ближайшее к ref_tsf значение с теми же
    младшими 32 битами (окно ±2³¹ мкс ≈ ±35 мин ≫ aMaxBIDuration); альтернатива — ближайшее не раньше ref_tsf
    (но тогда «obsolete allocation» из 10.39.6.1 была бы невыразима)."""
    ref = Fr(ref_tsf)
    base = ref - (ref % TSF_LOW_MOD)
    cands = [base + low32 + d for d in (-TSF_LOW_MOD, 0, TSF_LOW_MOD)]
    return min(cands, key=lambda c: (abs(c - ref), c))


def obsolete(alloc, rx_tsf):
    """10.39.6.1: новое псевдостатичное распределение игнорируется, если TSF при приёме кадра с Extended Schedule
    больше TSF начала распределения («obsolete allocation»)."""
    return bool(alloc.pseudo_static) and Fr(rx_tsf) > full_tsf(alloc.start, rx_tsf)


def pseudo_static_valid(k_rx, k, max_lost=DOT11_MAX_LOST_BEACONS, view='sta'):
    """10.39.6.4: действует ли псевдостатичное распределение в BI k, если последний Extended Schedule (или CBAP Only
    = 1) получен в BI k_rx.
    СПОРНО: «recurs … in up to dot11MaxLostBeacons beacon intervals following the last received» (view='ap':
    k_rx..k_rx+N) против «shall cease transmission … if it fails to receive … for dot11MaxLostBeacons consecutive
    beacon intervals» (view='sta': после N подряд потерь — уже в BI k_rx+N, где расписание идёт в BHI до DTI,
    передавать нельзя: k_rx..k_rx+N−1). По умолчанию — строгое правило STA."""
    if k < k_rx:
        return False
    return k - k_rx <= (max_lost if view == 'ap' else max_lost - 1)


# ====================== BTI: порядок DMG Beacon (10.42.4, 11.1.3.3.1) ======================
def txss_plan(sectors, per_bti=None):
    """Разбиение initiator TXSS по BTI (10.42.4). sectors — порядок секторов TXSS (11.1.3.3.1: последовательность
    направлений может меняться после полного обхода — порядок задаёт вызывающий); per_bti — маяков за BTI (None —
    все: нефрагментированный TXSS).
    Возвращает (txss_span, fragmented, [[(sector, cdown), …] по BTI]). CDOWN — «total number of transmissions
    remaining to the end of the initiator TXSS … last … CDOWN 0» (10.42.4) — сквозной через BTI."""
    n = len(sectors)
    per = n if per_bti is None else per_bti
    if len(set(sectors)) != n:
        raise ValueError('11.1.3.3.1: не более одного DMG Beacon через одну конфигурацию антенны в BTI')
    span = ceil(Fr(n, per))
    btis = [[(sectors[i], n - 1 - i) for i in range(j * per, min(n, (j + 1) * per))] for j in range(span)]
    return span, int(per < n), btis


def bti_beacons(tbtt_us, entries, t_beacon, delay=0, bti_extra=0):
    """Времена DMG Beacon BTI: первый — в TBTT (+delay, 11.1.3.3.1: «may delay … if the medium is … busy»),
    следующие — через SBIFS (10.42.2.2.2: «Each transmitted BF frame shall be separated by … SBIFS»; AP не меняет
    DMG-антенну в BTI — 10.42.4, поэтому LBIFS не нужен).
    t_beacon — TXTIME маяка (число или список). bti_extra — запас после последнего маяка до конца BTI.
    СПОРНО → принято (PLAN.md «Принятые трактовки» №5): конец BTI = конец последнего маяка + его Duration (10.42.5.1;
    так же abft.sta_bti_end, sls.bti_txss, check_air_log); генератор по умолчанию — запас 0.
    Возвращает (список (ts, te, sector, cdown, duration_field), конец BTI)."""
    tb = list(t_beacon) if isinstance(t_beacon, (list, tuple)) else [t_beacon] * len(entries)
    t = Fr(tbtt_us) + Fr(delay)
    out = []
    for i, (sec, cd) in enumerate(entries):
        if i:
            t += SBIFS
        out.append([t, t + Fr(tb[i]), sec, cd])
        t += Fr(tb[i])
    end = t + Fr(bti_extra)
    # 9.3.4.2 / 11.1.3.3.1: «Duration field … set to the time remaining until the end of the current BTI»
    return [(a, b, s, c, D.duration_dmg_beacon(end - b)) for a, b, s, c in out], end


# ====================== периоды BI (10.39.2) ======================
class Period:
    __slots__ = ('kind', 'start', 'end', 'alloc', 'src_aid', 'dst_aid', 'cbap_only')

    def __init__(self, kind, start, end, alloc=None, src_aid=AID_BROADCAST, dst_aid=AID_BROADCAST, cbap_only=False):
        self.kind, self.start, self.end, self.alloc = kind, Fr(start), Fr(end), alloc
        self.src_aid, self.dst_aid, self.cbap_only = src_aid, dst_aid, cbap_only

    def __repr__(self):
        x = f' {self.src_aid}->{self.dst_aid}' if self.kind in (SP, CBAP) else ''
        return f'{self.kind}[{float(self.start)}, {float(self.end)}){x}'


class BiConfig:
    """Объявленные AP параметры BI (из DMG Beacon BTI этого BI и Announce):
      bic, params — Beacon Interval Control, DMG Parameters;
      allocations — поля Allocation Extended Schedule, действующие в этом BI (псевдостатичные из прошлых BI —
        через Allocation.recur);
      ati_start — Start Time из Next DMG ATI (младшие 32 бита TSF, «earliest start time», 9.4.2.135) или None;
      ati_duration — ATI Duration (мкс, 9.4.2.135);
      ati_guard — guard time перед ATI (10.39.3: «Max(guard time, MBIFS)»); СПОРНО: A-BFT/BTI — «allocation» для
        guard time только перед CBAP Only (10.39.6.5), поэтому по умолчанию 0 и ATI ограничен лишь MBIFS;
      cbap_only_guard — guard перед CBAP Only (10.39.6.3); None — guard_between(False, True, BI) (СПОРНО: BHI —
        непсевдостатичный с D = BI, CBAP Only — псевдостатичный, 10.39.6.4);
      es_tx_tsf — TSF передачи последнего Extended Schedule (для aMinAllocationDeliveryTime, 10.39.6.1) или None;
      has_es_in_beacon — DMG Beacon содержит Extended Schedule (10.39.6.3)."""
    def __init__(self, bic=None, params=None, allocations=(), ati_start=None, ati_duration=0, ati_guard=0,
                 cbap_only_guard=None, es_tx_tsf=None, has_es_in_beacon=None):
        self.bic = bic or BeaconIntervalControl()
        self.params = params or DmgParameters()
        self.allocations = list(allocations)
        self.ati_start, self.ati_duration, self.ati_guard = ati_start, Fr(ati_duration), Fr(ati_guard)
        self.cbap_only_guard, self.es_tx_tsf = cbap_only_guard, es_tx_tsf
        self.has_es_in_beacon = bool(self.allocations) if has_es_in_beacon is None else has_es_in_beacon


def tbtt(k, bi_tu):
    """11.1.3.3.1: «Time value zero of the TSF is defined to be a TBTT», TBTT через dot11BeaconPeriod TU."""
    return Fr(k * bi_tu * TU)


def bi_index(t, bi_tu):
    return floor(Fr(t) / (bi_tu * TU))


def layout(k, bi_tu, cfg, bti_end=None, t_ssw=T_SSW, t_ssw_fb=T_SSW_FB):
    """Периоды BI k. bti_end — конец BTI (None — BTI нет: 10.39.2 «Not all beacon intervals contain a BTI»).
      BTI   [TBTT, bti_end);
      A-BFT через MBIFS после BTI (10.42.5.1), если в BTI Next A-BFT = 0; длина = слоты × aSSSlotTime (10.42.5.2);
      ATI   (ATI Present = 1, 9.3.4.2) — не раньше Max(guard, MBIFS) после A-BFT/BTI и не раньше Start Time Next DMG
            ATI; без BTI — с TBTT (11.1.3.3.1: «the AP shall begin the beacon interval with an ATI»);
      DTI   — от конца BHI до следующего TBTT (10.39.2): CBAP Only → один CBAP после guard (10.39.6.3), иначе блоки
            Extended Schedule (10.39.6.1), не вошедшее — без доступа (10.39.4)."""
    bi = bi_tu * TU
    t0, t1 = tbtt(k, bi_tu), tbtt(k + 1, bi_tu)
    bic = cfg.bic
    per = []
    cur = t0
    if bti_end is not None:
        per.append(Period('BTI', t0, bti_end))
        cur = Fr(bti_end)
        if bic.abft_present:
            s = cur + MBIFS
            e = s + bic.abft_slots * ss_slot_time(bic.fss_frames, t_ssw, t_ssw_fb)
            per.append(Period('A-BFT', s, e))
            cur = e
    if bic.ati_present:
        s = cur + max(cfg.ati_guard, MBIFS) if per else t0
        if cfg.ati_start is not None:
            s = max(s, full_tsf(cfg.ati_start, t0))
        per.append(Period('ATI', s, s + cfg.ati_duration))
        cur = s + cfg.ati_duration
    if cfg.params.cbap_only:
        g = guard_between(False, True, bi) if cfg.cbap_only_guard is None else Fr(cfg.cbap_only_guard)
        per.append(Period(CBAP, cur + g, t1, cbap_only=True))
    else:
        for a in cfg.allocations:
            for s, e in a.blocks(t0):
                if e > t0 and s < t1:
                    per.append(Period(a.alloc_type, s, e, a, a.src_aid, a.dst_aid))
    per.sort(key=lambda p: (p.start, p.end))
    return per


def bhi_end(periods, k, bi_tu):
    """Конец BHI = конец последнего из BTI/A-BFT/ATI (10.39.2: «The BHI comprises the BTI, A-BFT and ATI»)."""
    ends = [p.end for p in periods if p.kind in ('BTI', 'A-BFT', 'ATI')]
    return max(ends) if ends else tbtt(k, bi_tu)


def period_at(periods, t):
    """Период, содержащий момент t (полуинтервал [start, end)); None — вне периодов (guard/нераспределённое)."""
    t = Fr(t)
    hit = [p for p in periods if p.start <= t < p.end]
    return hit[0] if hit else None


# ====================== проверка расписания ======================
def check_schedule(k, bi_tu, cfg, bti_end=None, by_ap=True, max_lost=DOT11_MAX_LOST_BEACONS, guard_d=None,
                   strict_cbap_only=False):
    """Инварианты расписания BI k. Возвращает [(rule, msg)].
    guard_d — D для непсевдостатичных распределений в guard time (None — BI, см. guard_between).
    strict_cbap_only — правило 10.39.6.3 «When only one CBAP is present and no other allocations exist … shall
    announce … CBAP Only field to 1». СПОРНО: там же «shall set the CBAP Only field to 0 … if the DMG Beacon frame
    contains at least one Extended Schedule element» — единственный CBAP в Extended Schedule противоречит одному из
    двух правил; по умолчанию не проверяется."""
    out = []
    bi = bi_tu * TU
    if bi > aMaxBIDuration:
        out.append(('bi_max', f'BI {bi} мкс > aMaxBIDuration (11.1.3.3.1)'))
    out += cfg.bic.validate(max_lost)
    p = cfg.params
    if p.cbap_only and cfg.has_es_in_beacon:
        out.append(('cbap_only_es', 'CBAP Only = 1 при Extended Schedule в DMG Beacon (10.39.6.3)'))
    if p.cbap_only and cfg.bic.ati_present:
        out.append(('cbap_only_ati', 'CBAP Only = 1 и ATI Present = 1 (10.39.4)'))
    if not p.cbap_only and p.cbap_source:
        # 9.4.1.46: «CBAP Source subfield is valid only if the CBAP Only subfield is 1 … set to 0 otherwise» — то
        # же правило в fields.check_dmg_params (PLAN.md «Принятые трактовки»)
        out.append(('cbap_source', 'CBAP Source = 1 при CBAP Only = 0'))
    al = cfg.allocations
    if strict_cbap_only and not p.cbap_only and len(al) == 1 and al[0].alloc_type == CBAP and al[0].n_blocks == 1:
        out.append(('cbap_only_single', 'единственный CBAP без CBAP Only = 1 (10.39.6.3)'))
    for a in al:
        out += [(r, f'{a}: {m}') for r, m in a.validate(by_ap)]
    # 9.4.2.131: «Allocation fields are ordered by increasing allocation start time»
    t0 = tbtt(k, bi_tu)
    starts = [full_tsf(a.start, t0) for a in al]
    if starts != sorted(starts):
        out.append(('es_order', 'поля Allocation не по возрастанию Allocation Start (9.4.2.131)'))
    # 10.39.6.1: «The same Allocation field shall not appear more than once»; 9.4.2.131: кортеж уникален
    if len({a.fields() for a in al}) != len(al):
        out.append(('es_dup', 'одинаковое поле Allocation дважды (10.39.6.1)'))
    keys = [a.key() for a in al if not (a.alloc_type == CBAP and a.src_aid == a.dst_aid == AID_BROADCAST)]
    if len(set(keys)) != len(keys):
        out.append(('es_dup', 'повтор (Source AID, Destination AID, Allocation ID) (9.4.2.131)'))
    per = layout(k, bi_tu, cfg, bti_end)
    hb = bhi_end(per, k, bi_tu)
    t1 = tbtt(k + 1, bi_tu)
    blocks = [q for q in per if q.kind in (SP, CBAP)]
    for q in blocks:
        if q.start < hb:
            out.append(('in_bhi', f'{q} начинается до конца BHI {float(hb)} (10.39.6.1)'))
        if q.end > t1:
            out.append(('cross_bi', f'{q} пересекает TBTT {float(t1)} (9.4.2.131: «cannot cross beacon interval '
                                    f'boundaries»)'))
        if q.alloc is not None and not q.alloc.pseudo_static and cfg.es_tx_tsf is not None and \
                (q.alloc.src_aid not in (AID_AP_PCP, AID_BROADCAST) or
                 q.alloc.dst_aid not in (AID_AP_PCP, AID_BROADCAST)):
            if q.start < Fr(cfg.es_tx_tsf) + aMinAllocationDeliveryTime:
                out.append(('alloc_delivery', f'{q}: начало < ES + aMinAllocationDeliveryTime (10.39.6.1)'))
    # BHI-периоды тоже участвуют в guard перед CBAP Only (10.39.6.5); между блоками — guard для всех соседних
    for a, b in zip(blocks, blocks[1:]):
        if b.start < a.end:
            out.append(('overlap', f'{a} и {b} перекрываются (10.39.6.5)'))
            continue
        pa = bool(a.alloc.pseudo_static) if a.alloc else True
        pb = bool(b.alloc.pseudo_static) if b.alloc else True
        g = guard_between(pa, pb, bi, guard_d, guard_d, max_lost)
        if b.start - a.end < g:
            out.append(('guard', f'{a}→{b}: {float(b.start - a.end)} мкс < guard {float(g)} (10.39.6.5)'))
    return out


# ====================== журнал эфира ======================
MGMT_KINDS = frozenset({'Mgmt', 'Action', 'Announce', 'Probe Request', 'Probe Response', 'Association Request',
                        'Association Response', 'Reassociation Request', 'Reassociation Response', 'Authentication',
                        'Deauthentication', 'Disassociation'})
# 10.39.3: запросы и ответы в ATI — Management, Ack, Grant/Poll/RTS/DMG CTS как запрос, SPR/DMG CTS как ответ, Data
# — только для RSNA-аутентификации ('EAPOL' в журнале)
ATI_REQUEST = MGMT_KINDS | {'Ack', 'Grant', 'Poll', 'RTS', 'DMG CTS', 'EAPOL'}
ATI_RESPONSE = MGMT_KINDS | {'Ack', 'SPR', 'DMG CTS', 'EAPOL'}


class Bss:
    """Параметры check_air_log.
      ap — MAC AP/PCP; aids — MAC → AID (AP — 0, 9.4.1.8); bi_tu — dot11BeaconPeriod;
      configs — dict k → BiConfig (или callable k → BiConfig); отсутствующий BI — BiConfig();
      sectors — множество секторов TXSS AP (None — не проверять покрытие, 11.1.2.1);
      max_lost — dot11MaxLostBeacons; sifs_tol — допуск ответа (10.3.2.3.3);
      abft_start_tol — допуск начала первой SSW относительно начала слота, abft_fb_tol — опоздание SSW-Feedback
        (рис. 10-76 задаёт слот без допуска; СПОРНО → принято, PLAN.md №4: timing.ABFT_SSW_START_TOL / ABFT_FB_TOL — те
        же, что в abft.check_abft_log);
      dynamic — [(start, end, {MAC, …})] окна, выделенные Grant (10.39.7, 10.39.8, 10.39.9): в них передающие
        из множества не нарушают 'sp_foreign'/'cbap_member';
      t_ssw/t_ssw_fb — TXTIME SSW / SSW-Feedback для aSSSlotTime."""
    def __init__(self, ap, aids, bi_tu=100, configs=None, sectors=None, max_lost=DOT11_MAX_LOST_BEACONS,
                 sifs_tol=SIFS_TOL, abft_start_tol=ABFT_SSW_START_TOL, abft_fb_tol=ABFT_FB_TOL, dynamic=(),
                 t_ssw=T_SSW, t_ssw_fb=T_SSW_FB):
        self.ap, self.aids, self.bi_tu = ap, dict(aids), bi_tu
        self.aids.setdefault(ap, AID_AP_PCP)
        self.configs = configs or {}
        self.sectors = None if sectors is None else set(sectors)
        self.max_lost, self.sifs_tol = max_lost, Fr(sifs_tol)
        self.abft_start_tol, self.abft_fb_tol = Fr(abft_start_tol), Fr(abft_fb_tol)
        self.dynamic = [(Fr(s), Fr(e), set(m)) for s, e, m in dynamic]
        self.t_ssw, self.t_ssw_fb = t_ssw, t_ssw_fb

    def cfg(self, k):
        c = self.configs(k) if callable(self.configs) else self.configs.get(k)
        return c or BiConfig()


def _ev(e):
    e = tuple(e)
    info = e[6] if len(e) > 6 and e[6] else {}
    return dict(ts=Fr(e[0]), te=Fr(e[1]), src=e[2], dst=e[3], kind=e[4], dur=e[5] if len(e) > 5 else None,
                sector=info.get('sector'), cdown=info.get('cdown'), antenna=info.get('antenna'))


def check_air_log(events, bss):
    """Проверка журнала эфира на инварианты BI.

    events — кортежи (t_start, t_end, src, dst, kind[, duration_field[, info]]): моменты на эфире (10.3.7), TSF AP;
      kind — 'DMG Beacon' | 'SSW' | 'SSW-Feedback' | 'SSW-Ack' | 'BRP' | 'Announce' | 'Mgmt' | … (MGMT_KINDS) | 'Ack'
      | 'RTS' | 'DMG CTS' | 'CF-End' | 'Grant' | 'Poll' | 'SPR' | 'Data' | 'A-MPDU' | 'BlockAck' | 'EAPOL' | …;
      info — dict(sector=, cdown=) для DMG Beacon.
    BTI каждого BI определяется по журналу: цепочка DMG Beacon AP от первого маяка BI, конец — конец последнего
    маяка + его Duration (10.42.5.1: «BTI is completed at the expiration of the value within the Duration field of
    the last DMG Beacon frame»); без Duration — конец последнего маяка. Остальные периоды — layout() по bss.cfg(k).

    rule:
      'beacon_src'       — DMG Beacon не от AP/PCP (11.1.2.1, 10.39.1);
      'beacon_outside_bti' — DMG Beacon вне BTI (10.39.2: BTI — период передачи DMG Beacon);
      'beacon_gap'       — промежуток маяков BTI не SBIFS…SBIFS+aSBIFSAccuracy (10.42.2.2.2, 10.3.2.3.8);
      'beacon_sector_dup' — один сектор дважды в BTI (11.1.3.3.1);
      'beacon_cdown'     — CDOWN не убывает на 1 внутри BTI (10.42.4, 10.42.2.2.2);
      'beacon_dur'       — Duration маяка ≠ остаток BTI (9.3.4.2, 11.1.3.3.1);
      'sector_coverage'  — сектор без маяка за dot11MaxLostBeacons BI подряд (11.1.2.1);
      'bti_sta'          — передача non-AP STA в BTI (10.39.2);
      'bti_kind'         — в BTI не DMG Beacon (10.42.4: «does not transmit SSW frames in the BTI»; 10.39.2);
      'abft_kind'        — в A-BFT не SSW от STA / SSW-Feedback от AP (10.42.5.2: только RSS и SSW feedback; «BRP
                           phase shall not be performed», «shall not initiate an SSW ack»);
      'abft_slot_start'  — первая SSW в слоте не в начале слота (10.42.5.2: «initiate the RSS only at the start of
                           the SSW slot»);
      'abft_fss'         — больше FSS кадров SSW в слоте (10.42.5.2);
      'abft_ss_end'      — SSW после aAirPropagationTime + aSSDuration от начала слота (рис. 10-76);
      'abft_sbifs'       — SSW одного ответчика не через SBIFS [aSBIFSTime, +aSBIFSAccuracy] и не через LBIFS
                           [LBIFS, +LBIFS_TOL] при смене DMG-антенны (10.42.2.3, рис. 10-75, 10.3.2.3.8/11; так же
                           abft.check_abft_log; антенна — info['antenna'], без неё LBIFS допускается);
      'abft_fb_time'     — SSW-Feedback не за aSSFBDuration + MBIFS до конца слота (10.42.5.2);
      'ati_sta'          — non-AP в ATI не ответом через SIFS на индивидуальный кадр AP к нему (10.39.3);
      'ati_resp_dst'     — ответ в ATI не AP (10.39.3: «individually addressed to the AP or PCP»);
      'ati_kind'         — вид кадра не из списка 10.39.3;
      'ati_noack'        — индивидуальный запрос Action No Ack в ATI (10.39.3);
      'no_period'        — передача вне периодов доступа (guard, нераспределённое DTI; 10.39.4, 10.39.6.5);
      'period_end'       — кадр выходит за конец своего периода (10.39.4, 10.39.5, 10.39.6.2);
      'sp_foreign'       — в SP передаёт не источник/назначение (10.39.6.2);
      'sp_pcp_inactive'  — передача к PCP в SP с PCP Active = 0, где PCP не участник (10.39.6.2);
      'cbap_member'      — начало обмена в CBAP STA, не допущенной 10.39.5."""
    ev = sorted((_ev(e) | {'i': i} for i, e in enumerate(events)), key=lambda r: (r['ts'], r['te']))
    out = []
    bi_tu, ap = bss.bi_tu, bss.ap

    def v(r, rule, msg):
        out.append(Violation(r['i'], rule, msg))

    def aid(mac):
        return bss.aids.get(mac)

    def prev_of(j):
        r = ev[j]
        c = [q for q in ev[:j] if q['te'] <= r['ts']]
        return max(c, key=lambda q: q['te']) if c else None

    def is_response(j):
        r, p = ev[j], prev_of(j)
        return p is not None and p['dst'] == r['src'] and p['dst'] != BCAST and \
            SIFS <= r['ts'] - p['te'] <= SIFS + bss.sifs_tol

    def dynamic_ok(r):
        return any(s <= r['ts'] and r['te'] <= e and r['src'] in m for s, e, m in bss.dynamic)

    # --- BTI по журналу ---
    by_bi = {}
    for j, r in enumerate(ev):
        by_bi.setdefault(bi_index(r['ts'], bi_tu), []).append(j)
    bti = {}                                 # k → (start, end, [индексы маяков цепочки])
    chain_of = set()
    for k, js in sorted(by_bi.items()):
        bj = [j for j in js if ev[j]['kind'] == 'DMG Beacon' and ev[j]['src'] == ap]
        if not bj:
            continue
        chain = [bj[0]]
        for j in bj[1:]:
            # цепочка: следующий маяк через межкадровый интервал BTI (с запасом до LBIFS); дальше — вне BTI
            if ev[j]['ts'] - ev[chain[-1]]['te'] <= LBIFS + LBIFS_TOL:
                chain.append(j)
            else:
                break
        last = ev[chain[-1]]
        end = last['te'] + (Fr(last['dur']) if last['dur'] is not None else 0)
        bti[k] = (ev[chain[0]]['ts'], end, chain)
        chain_of.update(chain)
        secs = []
        for a, b in zip(chain, chain[1:]):
            g = ev[b]['ts'] - ev[a]['te']
            if not SBIFS <= g <= SBIFS_MAX:
                v(ev[b], 'beacon_gap', f'промежуток {float(g)} мкс ≠ SBIFS')
            ca, cb = ev[a]['cdown'], ev[b]['cdown']
            if ca is not None and cb is not None and cb != ca - 1:
                v(ev[b], 'beacon_cdown', f'CDOWN {ca} → {cb}')
        for j in chain:
            s = ev[j]['sector']
            if s is not None:
                if s in secs:
                    v(ev[j], 'beacon_sector_dup', f'сектор {s} второй раз в BTI')
                secs.append(s)
            if ev[j]['dur'] is not None and ev[j]['dur'] != D.duration_dmg_beacon(end - ev[j]['te']):
                v(ev[j], 'beacon_dur', f'Duration {ev[j]["dur"]} ≠ остаток BTI {float(end - ev[j]["te"])}')
        bti[k] = (bti[k][0], end, chain, set(secs))

    # --- покрытие секторов за dot11MaxLostBeacons BI (11.1.2.1) ---
    if bss.sectors is not None and by_bi:
        ks = sorted(by_bi)
        lo, hi = ks[0], ks[-1]
        for k0 in range(lo, hi - bss.max_lost + 2):
            seen = set()
            for k in range(k0, k0 + bss.max_lost):
                if k in bti:
                    seen |= bti[k][3]
            miss = bss.sectors - seen
            if miss:
                j = by_bi.get(k0, [None])[0]
                out.append(Violation(ev[j]['i'] if j is not None else -1, 'sector_coverage',
                                     f'BI {k0}..{k0 + bss.max_lost - 1}: нет маяков через {sorted(miss)}'))

    # --- периоды и кадры ---
    lay = {}
    for k in by_bi:
        lay[k] = layout(k, bi_tu, bss.cfg(k), bti[k][1] if k in bti else None, bss.t_ssw, bss.t_ssw_fb)
    abft_slots = {}                          # (k, slot) → {src: [индексы SSW]}
    for j, r in enumerate(ev):
        k = bi_index(r['ts'], bi_tu)
        cfg = bss.cfg(k)
        x, kind = r['src'], r['kind']
        if kind == 'DMG Beacon':
            if x != ap:
                v(r, 'beacon_src', 'DMG Beacon не от AP/PCP')
            elif j not in chain_of:
                v(r, 'beacon_outside_bti', 'DMG Beacon вне BTI')
            continue
        p = period_at(lay[k], r['ts'])
        if p is None:
            v(r, 'no_period', f'{kind} {x} в {float(r["ts"])} вне периодов доступа')
            continue
        if r['te'] > p.end:
            v(r, 'period_end', f'{kind} {x} кончается в {float(r["te"])} > конца {p}')
        if p.kind == 'BTI':
            v(r, 'bti_sta' if x != ap else 'bti_kind', f'{kind} от {x} в BTI')
        elif p.kind == 'A-BFT':
            fss = cfg.bic.fss_frames
            sst = ss_slot_time(fss, bss.t_ssw, bss.t_ssw_fb)
            n = floor((r['ts'] - p.start) / sst)
            s0, s1 = p.start + n * sst, p.start + (n + 1) * sst
            if kind == 'SSW' and x != ap:
                abft_slots.setdefault((k, n), {}).setdefault(x, []).append(j)
                if r['te'] > s0 + bss.abft_start_tol + ss_duration(fss, bss.t_ssw):
                    v(r, 'abft_ss_end', f'SSW за пределом aSSDuration слота {n}')
            elif kind == 'SSW-Feedback' and x == ap:
                want = ssw_fb_start(s1, bss.t_ssw_fb)
                if not 0 <= r['ts'] - want <= bss.abft_fb_tol:
                    v(r, 'abft_fb_time', f'SSW-Feedback в {float(r["ts"])} ≠ {float(want)}')
            else:
                v(r, 'abft_kind', f'{kind} от {x} в A-BFT')
        elif p.kind == 'ATI':
            if x == ap:
                if kind not in ATI_REQUEST:
                    v(r, 'ati_kind', f'{kind} от AP в ATI')
                if kind == 'Action No Ack' and r['dst'] != BCAST:
                    v(r, 'ati_noack', 'индивидуальный Action No Ack в ATI')
            else:
                pr = prev_of(j)
                if not (is_response(j) and pr['src'] == ap):
                    v(r, 'ati_sta', f'{kind} от {x} в ATI не ответ на кадр AP')
                if r['dst'] != ap:
                    v(r, 'ati_resp_dst', f'ответ {x} в ATI адресован {r["dst"]}')
                if kind not in ATI_RESPONSE:
                    v(r, 'ati_kind', f'{kind} от STA в ATI')
        elif p.kind == SP:
            a = aid(x)
            src, dst = p.src_aid, p.dst_aid
            if src == dst == AID_BROADCAST:
                # 9.4.2.131: «a non-AP and non-PCP STA does not transmit unless it receives a Poll or Grant»
                ok = x == ap or is_response(j) or dynamic_ok(r)
            elif dst == AID_BROADCAST:
                # СПОРНО: «Only a STA identified as the source … or destination» при broadcast Destination AID —
                # либо любая STA, либо только ответы на кадры источника; принято второе (10.39.6.2: «all STAs …
                # should be in the receive state … to receive transmissions from the source»)
                pr = prev_of(j)
                ok = a == src or (is_response(j) and aid(pr['src']) == src) or dynamic_ok(r)
            else:
                ok = a in (src, dst) or dynamic_ok(r)
            if not ok:
                v(r, 'sp_foreign', f'{kind} от {x} (AID {a}) в {p}')
            al = p.alloc
            if al is not None and not al.pcp_active and AID_AP_PCP not in (src, dst) and r['dst'] == ap and x != ap:
                v(r, 'sp_pcp_inactive', f'{kind} к PCP в {p} при PCP Active = 0')
        elif p.kind == CBAP:
            if is_response(j) or dynamic_ok(r):
                continue
            a = aid(x)
            if p.cbap_only:
                # 10.39.5: CBAP Only = 1, CBAP Source = 0 — любая STA; CBAP Source = 1 — AP. СПОРНО: для non-AP при
                # CBAP Source = 1 ни одно условие списка 10.39.5 явно не выполняется, но 9.4.1.46 говорит лишь о
                # «higher priority» AP (PIFS-доступ), а не исключительности; принято: CBAP Only — Source AID
                # broadcast, т. е. доступ всем.
                continue
            if not (p.src_aid == AID_BROADCAST or a in (p.src_aid, p.dst_aid)):
                v(r, 'cbap_member', f'{kind} от {x} (AID {a}) начинает обмен в {p} (10.39.5)')
    # A-BFT: слоты
    for (k, n), per_src in abft_slots.items():
        cfg = bss.cfg(k)
        fss = cfg.bic.fss_frames
        pa = [p for p in lay[k] if p.kind == 'A-BFT'][0]
        s0 = pa.start + n * ss_slot_time(fss, bss.t_ssw, bss.t_ssw_fb)
        for x, js in per_src.items():
            if not 0 <= ev[js[0]]['ts'] - s0 <= bss.abft_start_tol:
                v(ev[js[0]], 'abft_slot_start', f'первая SSW {x} не в начале слота {n}')
            if len(js) > fss:
                v(ev[js[fss]], 'abft_fss', f'{len(js)} SSW > FSS {fss} в слоте {n}')
            for a, b in zip(js, js[1:]):
                g = ev[b]['ts'] - ev[a]['te']
                if SBIFS <= g <= SBIFS_MAX:
                    continue
                # 10.3.2.3.11: LBIFS — между передачами через разные DMG-антенны (RSS ответчика с несколькими
                # антеннами, 10.42.2.3.2); найдено сверкой с генератором abft (test_consistency)
                ant_a, ant_b = ev[a]['antenna'], ev[b]['antenna']
                if LBIFS <= g <= LBIFS + LBIFS_TOL and (ant_a is None or ant_b is None or ant_a != ant_b):
                    continue
                v(ev[b], 'abft_sbifs', f'промежуток SSW {float(g)} ≠ SBIFS/LBIFS')
    out.sort(key=lambda w: w.idx)
    return out


# ====================== генератор эталонного BI ======================
def generate_bi(k, bss, beacon_entries, t_beacon, abft_ssw=(), ati=(), dur=True):
    """Эталонный журнал BI k по стандарту: маяки BTI (bti_beacons), в A-BFT для (slot, STA, n_ssw) — n SSW через
    SBIFS с начала слота и SSW-Feedback от AP за aSSFBDuration + MBIFS до конца слота (10.42.5.2); в ATI для
    (sta, kind_req, len_req, kind_resp, len_resp) — запрос AP и ответ STA через SIFS (10.39.3), следующий запрос —
    через SIFS после ответа. Длины кадров ATI → TXTIME control mode."""
    cfg = bss.cfg(k)
    bi_tu = bss.bi_tu
    t0 = tbtt(k, bi_tu)
    bea, end = bti_beacons(t0, beacon_entries, t_beacon)
    log = [(a, b, bss.ap, BCAST, 'DMG Beacon', d if dur else None, dict(sector=s, cdown=c)) for a, b, s, c, d in bea]
    per = layout(k, bi_tu, cfg, end, bss.t_ssw, bss.t_ssw_fb)
    pa = [p for p in per if p.kind == 'A-BFT']
    for slot, sta, n in abft_ssw:
        s0, s1 = abft_slot(pa[0].start, slot, cfg.bic.fss_frames, t_ssw=bss.t_ssw, t_ssw_fb=bss.t_ssw_fb)
        t = s0
        for i in range(n):
            log.append((t, t + bss.t_ssw, sta, bss.ap, 'SSW'))
            t += bss.t_ssw + SBIFS
        fb = ssw_fb_start(s1, bss.t_ssw_fb)
        log.append((fb, fb + bss.t_ssw_fb, bss.ap, sta, 'SSW-Feedback'))
    pt = [p for p in per if p.kind == 'ATI']
    if ati:
        t = pt[0].start
        for sta, kq, lq, kr, lr in ati:
            log.append((t, t + txtime_control(lq), bss.ap, sta, kq))
            t += txtime_control(lq) + SIFS
            log.append((t, t + txtime_control(lr), sta, bss.ap, kr))
            t += txtime_control(lr) + SIFS
    return log, per
