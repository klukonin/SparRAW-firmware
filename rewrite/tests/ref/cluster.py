# SPDX-License-Identifier: AGPL-3.0-or-later
"""Кластеризация DMG AP/PCP (802.11-2020 10.40 [p. 1908–1919], 11.29.4 [p. 2363], 11.1.3.3.1 [p. 2052]).

Охват:
  10.40.1   — Beacon SP_n кластера: ClusterTimeOffset_{n−1} = 1024 × (dot11BeaconPeriod / ClusterMaxMem) × (n − 1) мкс
              от TBTT S-AP/S-PCP (n = 1 — S-AP), предел Beacon SP Duration ≤ BI / ClusterMaxMem, Cluster ID = MAC S-AP,
              роль 0 у не-члена, Clustering Control в каждом DMG Beacon члена;
  10.40.2.1 — децентрализованное образование: S-AP (ECAPC Policy Enforced = 0, маяк не реже aMinBTIPeriod BI),
              прослушивание Beacon SP ≥ aMinChannelTime, пустой Beacon SP, вход члена (BI = BI S-AP, копии полей),
              Beacon SP других членов в своём расписании (SP с Source/Destination AID 255), запрет передач в чужих
              Beacon SP («should»);
  10.40.2.2 — централизованное образование: шаги конфигурации/проверки S-AP (CCSR — внешний, «not defined»), ECAPC
              Policy Enforced = 1 на всё время BSS, ECAPC Policy в (Re)Association Response/Announce/Information
              Response (битовая карта занятых Cluster Time Offset, кроме получателя), выбор Cluster Time Offset членом
              (пересечение пустых Beacon SP и Available Cluster Time Offset Bitmap), Information Response с Cluster Time
              Offset от второй STA (MM-SME), «слепой» AP/PCP (300 × aMinChannelTime), уход из децентрализованного
              кластера;
  10.40.3   — сопровождение: потеря S-AP (4 × aMinBTIPeriod BI), периоды мониторинга, передача роли S-AP (наименьший
              MAC), dot11MaxNumberOfClusteringMonitoringPeriods, встреча двух S-AP (меньший MAC остаётся S-AP);
              централизованный — обновление полей от S-AP, потеря S-AP — варианты a)/b)/c);
  10.40.3.4 — BHI до TBTT + 8 × Beacon SP Duration (BHI Enforced), окна TXSS CBAP (T_Start/T_End);
  10.40.4   — Cluster Report от non-AP STA (условия «should send» / «shall not send», копии полей, по элементу на каждый
              Extended Schedule маяка); 10.40.5 — Cluster Request, dot11ClusterEnableTime;
  11.29.4   — Clustering Control вместе с DMG BSS Parameter Change; 11.1.3.3.1 — случайная задержка маяка при ECAPC = 1.
Элементы: Cluster Report (9.4.2.146, рис. 9-589/9-590 [p. 1266]), ECAPC Policy (9.4.2.154, рис. 9-601/9-602 [p. 1274]),
Cluster Time Offset (9.4.2.155, рис. 9-603 [p. 1275]); поле Clustering Control (9.3.4.2, рис. 9-78) — кодек ref/fields.

Не моделируется: CDMG-кластеризация (10.41, Cluster Probe/Extended Cluster Report, SPSH Measurement Enabled — резерв у
не-CDMG), CMMG; обмен S-AP с CCSR («not defined in this standard») — конфигурация передаётся параметром; Channel Usage
(11.21.15); выбор канала при уходе («implementation dependent»). Время — мкс, Fraction; TBTT — в TSF того узла, чьё
время передано (для члена — TSF S-AP в момент TBTT S-AP приводится смещением ClusterTimeOffset)."""
from collections import namedtuple
from fractions import Fraction as Fr

from . import elements as E
from . import fields as F
from . import schedule as SC
from . import tspec as TS
from .timing import AID_BROADCAST, DOT11_MIN_BHI_DURATION, TU, aMinBTIPeriod, aMinChannelTime

# табл. 9-92: Element ID
EID_CLUSTER_REPORT, EID_ECAPC_POLICY, EID_CLUSTER_TIME_OFFSET = 166, 182, 183
# 9.3.4.2: Cluster Member Role
ROLE_NONE, ROLE_SAP, ROLE_MEMBER = 0, 1, 2
CC_UNIT = 8                                   # 9.3.4.2: Beacon SP Duration — «in units of 8 µs»
MAXMEM_DECENTRALIZED = 7                      # 9.3.4.2: «Values 8 and above are reserved if … ECAPC … 0»
MAXMEM_FIELD = 31                             # рис. 9-78: 5 бит
CC_MONITOR_BIS = 4 * aMinBTIPeriod            # 10.40.3.2/10.40.3.3: «4×aMinBTIPeriod beacon intervals»
ECAPC_BLIND_US = 300 * aMinChannelTime        # 10.40.2.2: «for 300×aMinChannelTime»
# MIB (C.3) DEFVAL, только этого модуля
DOT11_BEACON_SP_DURATION = 600                # мкс, dot11BeaconSPDuration DEFVAL { 600 }
DOT11_MAX_CLUSTERING_MONITORING_PERIODS = 3   # dot11MaxNumberOfClusteringMonitoringPeriods DEFVAL { 3 }
DOT11_CLUSTER_ENABLE_TIME = 8                 # BI, dot11ClusterEnableTime DEFVAL { 8 }
DOT11_DMG_ECSS_POLICY_DETAIL_UPDATE_DURATION_MAX = 1000   # TU, DEFVAL { 1000 }
DOT11_DMG_ECSS_CLUSTER_REPORT_DURATION_MIN = 1000         # TU, DEFVAL { 1000 }
# 9.4.2.146: Cluster Channel Number — 0 «common 2.16 GHz channel», 1/2 — каналы 1,08 ГГц (CDMG), 3 — Reserved
CH_2G16, CH_1G08_LOW, CH_1G08_HIGH = 0, 1, 2


class ClusterError(ValueError):
    pass


# ============================================================================================ время Beacon SP (10.40.1)
def bi_us(bi_tu):
    return TU * bi_tu


def maxmem_ok(bi_tu, maxmem):
    """10.40.2.1: «ClusterMaxMem … chosen to keep the result of (beacon interval length/ClusterMaxMem) as an integer
    number of microseconds»; 10.40.2.2 (шаг конфигурации) — то же."""
    return maxmem > 0 and (Fr(bi_us(bi_tu)) / maxmem).denominator == 1


def cluster_time_offset(i, bi_tu, maxmem):
    """ClusterTimeOffset_i = 1024 × (dot11BeaconPeriod / ClusterMaxMem) × i мкс, i = n − 1 ∈ [0, ClusterMaxMem − 1]
    (10.40.1; i = 0 — Beacon SP_1 S-AP)."""
    if not 0 <= i < maxmem:
        raise ClusterError(f'ClusterTimeOffset_{i}: индекс вне 0…{maxmem - 1} (10.40.1: n = 1…ClusterMaxMem)')
    return Fr(1024) * Fr(bi_tu, maxmem) * i


def beacon_sp_us(field):
    """9.3.4.2: Beacon SP Duration × 8 мкс."""
    return Fr(CC_UNIT * field)


def beacon_sp_field(us):
    """dot11BeaconSPDuration (мкс) → подполе (единицы 8 мкс). СПОРНО → принято PLAN.md №80: вверх (Beacon SP не
    короче MIB)."""
    return -(-int(us) // CC_UNIT)


def beacon_sp(n, sap_tbtt, bi_tu, maxmem, sp_field):
    """[начало, конец) Beacon SP_n BI с TBTT S-AP sap_tbtt (10.40.1)."""
    s = sap_tbtt + cluster_time_offset(n - 1, bi_tu, maxmem)
    return s, s + beacon_sp_us(sp_field)


def beacon_sp_of(t0, t1, sap_tbtt, bi_tu, maxmem, sp_field):
    """Номер n Beacon SP, целиком содержащего [t0, t1) (по модулю BI от TBTT S-AP), или None."""
    per = bi_us(bi_tu)
    a = (t0 - sap_tbtt) % per
    b = a + (t1 - t0)
    for n in range(1, maxmem + 1):
        s = cluster_time_offset(n - 1, bi_tu, maxmem)
        if s <= a and b <= s + beacon_sp_us(sp_field):
            return n
    return None


def overlaps_beacon_sps(t0, t1, sap_tbtt, bi_tu, maxmem, sp_field, skip=()):
    """Номера Beacon SP (кроме skip), с которыми пересекается [t0, t1)."""
    per = bi_us(bi_tu)
    out = set()
    k0 = (t0 - sap_tbtt) // per
    for k in (k0 - 1, k0, k0 + 1):
        for n in range(1, maxmem + 1):
            if n in skip:
                continue
            s, e = beacon_sp(n, sap_tbtt + k * per, bi_tu, maxmem, sp_field)
            if t0 < e and s < t1:
                out.add(n)
    return out


def check_cluster_params(bi_tu, maxmem, sp_field, ecapc, sap=True):
    """Нарушения параметров Clustering Control (10.40.1, 10.40.2.1, 10.40.2.2, 9.3.4.2): ClusterMaxMem 1…7 при
    ECAPC = 0 (1…31 при 1), BI / ClusterMaxMem — целое число мкс, Beacon SP Duration S-AP ≤ BI / ClusterMaxMem."""
    v = []
    if maxmem == 0 or maxmem > MAXMEM_FIELD or (not ecapc and maxmem > MAXMEM_DECENTRALIZED):
        v.append(f'ClusterMaxMem = {maxmem}: допустимо 1…{MAXMEM_DECENTRALIZED if not ecapc else MAXMEM_FIELD} при '
                 f'ECAPC Policy Enforced = {ecapc} (9.3.4.2)')
        return v
    if not maxmem_ok(bi_tu, maxmem):
        v.append(f'BI {bi_tu} TU / ClusterMaxMem {maxmem} = {float(Fr(bi_us(bi_tu)) / maxmem):.3f} мкс — не целое '
                 '(10.40.2.1, 10.40.2.2)')
    if sap and beacon_sp_us(sp_field) > Fr(bi_us(bi_tu)) / maxmem:
        v.append(f'Beacon SP Duration {sp_field}×8 мкс > BI / ClusterMaxMem = {float(Fr(bi_us(bi_tu)) / maxmem)} мкс '
                 '(10.40.1: «maximum size of the Beacon SP Duration field»)')
    return v


def beacon_sp_entries(own_tbtt, own_n, bi_tu, maxmem, sp_field, which=None, min_dur_us=None):
    """Extended Schedule: Beacon SP других AP/PCP кластера в BI своего TBTT own_tbtt (10.40.2.1: «shall schedule a
    Beacon SP … at each of ClusterTimeOffset_n»; 10.40.2.2: «at each in use ClusterTimeOffset_{n−1}»). Source и
    Destination AID = 255 (10.40.3.4: «SP that has source and destination DMG AIDs set to 255 (such as for a Beacon
    SP)»). which — номера n (по умолчанию все, кроме own_n; СПОРНО → принято PLAN.md №83 — Beacon SP_1 S-AP у члена
    включается); Allocation ID — 1, 2, … по порядку начала в BI;
    длительность — Beacon SP Duration S-AP (или min_dur_us). Начало — младшие 32 бита TSF."""
    per = bi_us(bi_tu)
    sap_tbtt = own_tbtt - cluster_time_offset(own_n - 1, bi_tu, maxmem)
    dur = int(min_dur_us if min_dur_us is not None else beacon_sp_us(sp_field))
    starts = []
    for n in sorted(which if which is not None else set(range(1, maxmem + 1)) - {own_n}):
        s = sap_tbtt + cluster_time_offset(n - 1, bi_tu, maxmem)
        while s < own_tbtt:
            s += per
        while s >= own_tbtt + per:
            s -= per
        starts.append(int(s))
    # кортеж (Source AID, Destination AID, Allocation ID) уникален (9.4.2.131), Allocation ID SP — 1…15 (4 бита, 0 —
    # не идентифицирует SP): Beacon SP нумеруются по порядку в BI; больше 15 — не помещаются отдельными SP
    if len(starts) > 15:
        raise ClusterError(f'{len(starts)} Beacon SP > 15 Allocation ID для SP 255→255 (9.4.2.131)')
    return [SC.sp(AID_BROADCAST, AID_BROADCAST, s, dur, alloc_id=i + 1) for i, s in enumerate(sorted(starts))]


def check_beacon_sps_scheduled(entries, own_tbtt, own_n, bi_tu, maxmem, sp_field, which=None, centralized=False):
    """[(сообщение, вердикт)]: в расписании BI есть SP 255→255, покрывающий каждый Beacon SP_n (n ∈ which, по
    умолчанию все, кроме своего). Нет SP — нарушение («shall schedule»); короче Beacon SP Duration — децентрализованный:
    «should» (вердикт 'model'), централизованный: «shall» ('ours')."""
    out = []
    want = beacon_sp_entries(own_tbtt, own_n, bi_tu, maxmem, sp_field, which)
    have = [e.alloc for e in entries or () if e.alloc.alloc_type == 'SP' and e.alloc.src_aid == AID_BROADCAST
            and e.alloc.dst_aid == AID_BROADCAST]
    for w in want:
        s = w.alloc.start
        cover = [a for a in have if a.start <= s < a.start + a.block_dur]
        n = (round((s - own_tbtt) / (Fr(bi_us(bi_tu)) / maxmem)) + own_n - 1) % maxmem + 1
        if not cover:
            out.append((f'нет Beacon SP (SP 255→255) на ClusterTimeOffset_{n - 1} = TBTT + {s - own_tbtt} мкс '
                        '(10.40.2.1/10.40.2.2: «shall schedule a Beacon SP»)', 'ours'))
        elif max(a.start + a.block_dur for a in cover) < s + w.alloc.block_dur:
            out.append((f'Beacon SP_{n} короче Beacon SP Duration {w.alloc.block_dur} мкс (10.40.2.1 «should» / '
                        '10.40.2.2 «shall»)', 'ours' if centralized else 'model'))
    return out


# ================================================================================ ECAPC Policy element (9.4.2.154)
ECAPC_DETAIL = [('bhi', 1), ('txss_cbap', 1), ('pp', 1), ('_r3', 5)]           # рис. 9-602
EcapcPolicy = namedtuple('EcapcPolicy', 'bhi txss_cbap pp ccsr_id bitmap txss_offset txss_duration txss_maxmem',
                         defaults=(None, None, None))
ECAPC_LEN, ECAPC_LEN_TXSS = 1 + 6 + 4, 1 + 6 + 4 + 2 + 1 + 1                    # рис. 9-601: 11 / 15 октетов


def encode_ecapc_policy(p, _r3=0):
    info = (bytes([E.pack(ECAPC_DETAIL, dict(bhi=p.bhi, txss_cbap=p.txss_cbap, pp=p.pp, _r3=_r3))])
            + E.mac_bytes(p.ccsr_id) + E.le(p.bitmap, 4))
    # 9.4.2.154: «If TXSS CBAP Enforced field is set to 0, then the TXSS CBAP Offset …, Duration …, MaxMem … are not
    # present in the element; otherwise, they are present»
    if p.txss_cbap:
        info += E.le(p.txss_offset, 2) + bytes([p.txss_duration, p.txss_maxmem])
    return E.encode_element(EID_ECAPC_POLICY, info)


def parse_ecapc_policy(info):
    """Информация элемента → (EcapcPolicy, резерв Detail B3–B7)."""
    b = bytes(info)
    if not b:
        raise ClusterError('ECAPC Policy: пустой элемент (рис. 9-601)')
    d = E.unpack(ECAPC_DETAIL, b[0])
    need = ECAPC_LEN_TXSS if d['txss_cbap'] else ECAPC_LEN
    if len(b) < need:
        raise ClusterError(f'ECAPC Policy: {len(b)} октетов < {need} при TXSS CBAP Enforced = {d["txss_cbap"]} '
                           '(рис. 9-601)')
    tx = (int.from_bytes(b[11:13], 'little'), b[13], b[14]) if d['txss_cbap'] else (None, None, None)
    return EcapcPolicy(d['bhi'], d['txss_cbap'], d['pp'], F.mac_str(b[1:7]), int.from_bytes(b[7:11], 'little'),
                       *tx), d['_r3']


def bitmap_valid_bits(maxmem):
    """Биты n − 1 Available Cluster Time Offset Bitmap, не зарезервированные: n = 2…ClusterMaxMem (СПОРНО → принято
    PLAN.md №81)."""
    return set(range(1, maxmem))


def check_ecapc_policy(p, rsv=0, maxmem=None, sender_role=ROLE_SAP, bi_tu=None):
    """Нарушения ECAPC Policy. sender_role — роль передающего AP/PCP в кластере (ROLE_SAP: карта по 10.40.2.2;
    ROLE_MEMBER: карта «reserved» — 0); maxmem — ClusterMaxMem кластера; bi_tu — для шага конфигурации TXSS."""
    v = []
    if rsv:
        v.append(f'ECAPC Policy Detail: резерв B3–B7 = {rsv} ≠ 0 (рис. 9-602, 9.2.2)')
    if p.bitmap >> 32:
        v.append('Available Cluster Time Offset Bitmap шире 32 бит (рис. 9-601)')
    if sender_role == ROLE_MEMBER and p.bitmap:
        v.append(f'Available Cluster Time Offset Bitmap = {p.bitmap:#x} у члена: «with the Available Cluster Time '
                 'Offset Bitmap field reserved» (10.40.2.2)')
    elif maxmem is not None:
        bad = [i for i in range(32) if p.bitmap >> i & 1 and i not in bitmap_valid_bits(maxmem)]
        if bad:
            v.append(f'Available Cluster Time Offset Bitmap: биты {bad} зарезервированы при ClusterMaxMem = {maxmem} '
                     '(9.4.2.154: n = 1 и n > ClusterMaxMem; PLAN.md №81)')
    if p.txss_cbap:
        if not p.txss_maxmem:
            v.append('TXSS CBAP MaxMem = 0 при TXSS CBAP Enforced = 1: N в T_Start (10.40.3.4) не определён')
        elif bi_tu is not None and Fr(bi_tu, p.txss_maxmem).denominator != 1 \
                and Fr(p.txss_maxmem, bi_tu).denominator != 1:
            v.append(f'ни BI/TXSS CBAP MaxMem ({bi_tu}/{p.txss_maxmem}), ни обратное не целое (10.40.2.2, шаг '
                     'конфигурации)')
    return v


def available_bitmap(maxmem, in_use, recipient=None):
    """10.40.2.2: S-AP — бит n − 1 = 0 у Cluster Time Offset «determined to be already in use», «excluding the
    recipient if sent within an individually addressed frame»; прочие действительные — 1; резерв — 0. in_use —
    индексы n − 1; recipient — индекс получателя или None."""
    m = 0
    for i in bitmap_valid_bits(maxmem):
        if i not in in_use or i == recipient:
            m |= 1 << i
    return m


def in_use_offsets(bitmap, maxmem):
    """Индексы n − 1, помеченные в карте занятыми (бит 0) — для Beacon SP в расписании (10.40.2.2)."""
    return {i for i in bitmap_valid_bits(maxmem) if not bitmap >> i & 1}


# ========================================================================= Cluster Time Offset element (9.4.2.155)
def encode_cto(index):
    return E.encode_element(EID_CLUSTER_TIME_OFFSET, bytes([index]))


def parse_cto(info):
    b = E.known_info(bytes(info), 1, 'Cluster Time Offset')
    return b[0]


def check_cto(index, maxmem=None):
    """9.4.2.155: «set to n–1 for a member … that adopted the n^th Beacon SP»; 0 — резерв; верхняя граница —
    ClusterMaxMem − 1 (СПОРНО → принято PLAN.md №81; дословно «greater than ClusterMaxMem»)."""
    if index == 0:
        return ['Cluster Time Offset Index = 0 зарезервирован (9.4.2.155)']
    if maxmem is not None and index >= maxmem:
        return [f'Cluster Time Offset Index = {index} ≥ ClusterMaxMem {maxmem}: Beacon SP_{index + 1} нет (10.40.1, '
                '9.4.2.155; PLAN.md №81)']
    return []


def select_cto(empty, bitmap, maxmem):
    """10.40.2.2: индекс из пересечения пустых Beacon SP (номера n) и доступных по карте; пустое пересечение —
    индекс пустого Beacon SP; нет пустых — None (не входить). Генератор берёт наименьший."""
    idx = {n - 1 for n in empty if 2 <= n <= maxmem}
    both = idx & {i for i in bitmap_valid_bits(maxmem) if bitmap >> i & 1}
    pick = both or idx
    return min(pick) if pick else None


# ============================================================================ Cluster Report element (9.4.2.146)
CR_CTRL = [('request', 1), ('report', 1), ('schedule_present', 1), ('tsconst_present', 1), ('ecapc_enforced', 1),
           ('ecapc_present', 1), ('channel', 2)]                                   # рис. 9-590
ClusterReport = namedtuple('ClusterReport', 'request report ecapc_enforced channel bssid ref_ts cc ecapc schedule '
                                            'constraints', defaults=(0, CH_2G16, None, None, None, None, None, None))


def encode_cluster_report(r):
    """ClusterReport → элемент. ecapc — EcapcPolicy или None; schedule — информация одного элемента Extended Schedule
    (bytes) или None; constraints — [tspec.Constraint] или None (СПОРНО → принято PLAN.md №82: Number of Constraints
    — при TSCONST Present = 1)."""
    rep = bool(r.report)
    if not rep and (r.cc or r.schedule is not None or r.constraints is not None or r.ecapc is not None):
        raise ClusterError('Cluster Report = 0: Reported BSSID … Traffic Scheduling Constraint Set отсутствуют '
                           '(9.4.2.146)')
    ctrl = dict(request=r.request, report=r.report, schedule_present=int(r.schedule is not None),
                tsconst_present=int(r.constraints is not None), ecapc_enforced=r.ecapc_enforced if rep else 0,
                ecapc_present=int(r.ecapc is not None), channel=r.channel)
    info = bytes([E.pack(CR_CTRL, ctrl)])
    if rep:
        info += E.mac_bytes(r.bssid) + E.le(r.ref_ts & 0xFFFFFFFF, 4) + F.encode_cc(r.cc)
        if r.ecapc is not None:
            info += encode_ecapc_policy(r.ecapc)
        if r.schedule is not None:
            info += E.encode_element(E.EID_EXTENDED_SCHEDULE, r.schedule)
        if r.constraints is not None:
            if len(r.constraints) > TS.MAX_CONSTRAINTS:
                raise ClusterError(f'Number of Constraints {len(r.constraints)} > 15 (9.4.2.146)')
            info += bytes([len(r.constraints)])
            for c in r.constraints:
                info += E.le(c.start, 4) + E.le(c.duration, 2) + E.le(c.period, 2) + F.mac_bytes(c.interferer)
    return E.encode_element(EID_CLUSTER_REPORT, info)


def parse_cluster_report(info):
    """Информация элемента → (ClusterReport, ctrl dict — сырые биты Control)."""
    b = bytes(info)
    if not b:
        raise ClusterError('Cluster Report: нет Cluster Report Control (рис. 9-589)')
    c = E.unpack(CR_CTRL, b[0])
    if not c['report']:
        return ClusterReport(c['request'], 0, c['ecapc_enforced'], c['channel']), c
    if len(b) < 1 + 6 + 4 + 8:
        raise ClusterError(f'Cluster Report: {len(b)} октетов — нет Reported BSSID/Reference Timestamp/Clustering '
                           'Control при Cluster Report = 1 (9.4.2.146)')
    bssid, ts = F.mac_str(b[1:7]), int.from_bytes(b[7:11], 'little')
    try:
        cc = F.parse_cc(b[11:19], 0)
    except F.FieldError as x:
        raise ClusterError(f'Cluster Report: Clustering Control: {x}') from None
    i, ecapc, sched, cons = 19, None, None, None
    if c['ecapc_present']:
        if len(b) < i + 2 or b[i] != EID_ECAPC_POLICY:
            raise ClusterError('Cluster Report: ECAPC Policy Present = 1, а элемента ECAPC Policy нет (9.4.2.146)')
        ecapc = parse_ecapc_policy(b[i + 2:i + 2 + b[i + 1]])[0]
        i += 2 + b[i + 1]
    if c['schedule_present']:
        if len(b) < i + 2 or b[i] != E.EID_EXTENDED_SCHEDULE:
            raise ClusterError('Cluster Report: Schedule Present = 1, а элемента Extended Schedule нет (9.4.2.146)')
        sched = b[i + 2:i + 2 + b[i + 1]]
        i += 2 + b[i + 1]
    if c['tsconst_present']:
        if len(b) < i + 1:
            raise ClusterError('Cluster Report: TSCONST Present = 1, нет Number of Constraints (9.4.2.146)')
        n = b[i]
        i += 1
        if len(b) < i + n * TS.CONSTRAINT_LEN:
            raise ClusterError(f'Cluster Report: {n} Constraint не помещаются (9.4.2.146)')
        cons = []
        for k in range(n):
            o = i + k * TS.CONSTRAINT_LEN
            cons.append(TS.Constraint(int.from_bytes(b[o:o + 4], 'little'), int.from_bytes(b[o + 4:o + 6], 'little'),
                                      int.from_bytes(b[o + 6:o + 8], 'little'), F.mac_str(b[o + 8:o + 14])))
    return ClusterReport(c['request'], 1, c['ecapc_enforced'], c['channel'], bssid, ts, cc, ecapc, sched, cons), c


def check_cluster_report(r, ctrl=None, cdmg=False):
    """Нарушения формата Cluster Report (9.4.2.146, рис. 9-590)."""
    v = []
    if ctrl is not None and not ctrl['report']:
        for k in ('schedule_present', 'tsconst_present', 'ecapc_enforced', 'ecapc_present'):
            if ctrl[k]:
                v.append(f'Cluster Report Control: {k} = 1 при Cluster Report = 0 — «otherwise, it is reserved» '
                         '(9.4.2.146)')
    if r.channel == 3:
        v.append('Cluster Channel Number = 3 зарезервировано (9.4.2.146)')
    elif r.channel and not cdmg:
        v.append(f'Cluster Channel Number = {r.channel} (канал 1,08 ГГц) у DMG STA — DMG-кластер на канале 2,16 ГГц '
                 '(9.4.2.146, табл. E-4)')
    if not r.request and not r.report:
        v.append('Cluster Report: Cluster Request = 0 и Cluster Report = 0 — элемент ничего не несёт (10.40.4, '
                 '10.40.5)')
    if r.report:
        if isinstance(r.cc, F.ClusteringControl):
            v += [f'Cluster Report: {m}' for m in F.check_cc(r.cc, ecapc=r.ecapc_enforced)]
        if r.constraints is not None and len(r.constraints) > TS.MAX_CONSTRAINTS:
            v.append('Number of Constraints > 15 (9.4.2.146)')
        if r.ecapc is not None and not r.ecapc_enforced:
            # ECAPC Policy выдают только члены централизованного кластера (10.40.2.2), а у них ECAPC = 1
            v.append('Cluster Report: ECAPC Policy при ECAPC Policy Enforced = 0 (10.40.2.2, 10.40.4)')
    if len(encode_cluster_report(r)) > 2 + E.ELEMENT_MAX_INFO:
        v.append('Cluster Report > 255 октетов (9.4.2.146: «can split the content of the Extended Schedule»)')
    return v


def report_condition(beacon_bssid, cc, own_ap, own_ap_ecapc, tbtt_gap_us, bi_tu):
    """10.40.4: должна ли non-AP STA слать Cluster Report по принятому DMG Beacon (True — «should send»; False —
    «shall not send»). cc — Clustering Control маяка (None — поля нет); tbtt_gap_us — расстояние между TBTT двух BSS;
    own_ap_ecapc — ECAPC Policy Enforced последнего маяка своей точки; bi_tu — dot11BeaconPeriod своей BSS. Порог
    dot11BeaconPeriod / (2 × ClusterMaxMem) — с ClusterMaxMem принятого маяка, в мкс (СПОРНО → принято PLAN.md №84)."""
    if beacon_bssid == own_ap or not isinstance(cc, F.ClusteringControl):
        return False
    if cc.cluster_id != own_ap:
        return True
    if tbtt_gap_us is None or not cc.cluster_max_mem:
        return False
    return abs(tbtt_gap_us) < Fr(bi_us(bi_tu), 2 * cc.cluster_max_mem) and own_ap_ecapc == 1


def make_reports(beacon_bssid, cc, ecapc_enforced, schedules, rx_tsf, ecapc=None, constraints=None):
    """Cluster Report по принятому маяку (10.40.4): по элементу на каждый элемент Extended Schedule маяка («transmit a
    Cluster Report element corresponding to each Extended Schedule element entry»); без расписания — один без него.
    schedules — [информация Extended Schedule]; rx_tsf — TSF приёма (младшие 4 октета — Reference Timestamp)."""
    base = dict(request=0, report=1, ecapc_enforced=ecapc_enforced, channel=CH_2G16, bssid=beacon_bssid,
                ref_ts=rx_tsf & 0xFFFFFFFF, cc=cc, ecapc=ecapc, constraints=constraints)
    return [ClusterReport(schedule=s, **base) for s in schedules] if schedules else [ClusterReport(**base)]


def check_sta_report(r, frame, dst, own_ap, heard, own_ap_ecapc=0, bi_tu=None):
    """[(сообщение, вердикт)] для Cluster Report, переданного non-AP STA (10.40.4, 10.40.5).
    frame — 'Announce' | 'Information Response' | иное; dst — RA; heard — {BSSID: dict(cc, ecapc, schedules, gap)}
    последних принятых STA маяков (None — приём STA не записан)."""
    out = []
    if dst != own_ap:
        out.append((f'Cluster Report к {dst}, а не к своей точке {own_ap} (10.40.4: «sent to the STA’s AP or PCP»)',
                    'ours'))
    if frame not in ('Announce', 'Information Response'):
        out.append((f'Cluster Report в {frame}: «shall be transmitted in an Announce or Information Response frame» '
                    '(10.40.4)', 'ours'))
    if not r.report:
        return out
    if r.bssid == own_ap:
        out.append(('Cluster Report о маяке своей точки — «shall not send» (10.40.4)', 'ours'))
    if heard is None:
        return out
    h = heard.get(r.bssid)
    if h is None:
        out.append((f'Cluster Report о {r.bssid}: маяк этого BSSID STA не принимала (запись приёма есть)', 'capture'))
        return out
    if isinstance(h['cc'], F.ClusteringControl) and h['cc'].cluster_id == own_ap and (h.get('gap') is None
                                                                                       or bi_tu is None):
        out.append(('Cluster Report о члене кластера своей точки: расстояние TBTT двух BSS не записано (10.40.4)',
                    'capture'))
        return out
    if not report_condition(r.bssid, h['cc'], own_ap, own_ap_ecapc, h.get('gap'), bi_tu):
        out.append(('Cluster Report по маяку, не отвечающему условиям 10.40.4 — «shall not send»', 'ours'))
        return out
    if r.cc != h['cc']:
        out.append(('Clustering Control отчёта ≠ принятому маяку (10.40.4: «set … to the corresponding field values»)',
                    'ours'))
    if r.ecapc_enforced != h['ecapc']:
        out.append(('ECAPC Policy Enforced отчёта ≠ маяку (10.40.4)', 'ours'))
    if r.schedule is not None and bytes(r.schedule) not in [bytes(s) for s in h.get('schedules') or ()]:
        out.append(('Extended Schedule отчёта ≠ ни одному элементу принятого маяка (10.40.4)', 'ours'))
    if r.schedule is None and h.get('schedules'):
        out.append(('у маяка есть Extended Schedule, а отчёт без него (10.40.4: «shall repeat … corresponding to each '
                    'Extended Schedule element entry»)', 'model'))
    return out


# ========================================================= BHI, TXSS CBAP, случайная задержка (10.40.3.4, 11.1.3.3.1)
def bhi_deadline(tbtt, sp_field):
    """10.40.3.4: при BHI Enforced = 1 BTI, A-BFT и ATI — «before TBTT + (8×Beacon SP duration)» (подполе — единицы
    8 мкс)."""
    return tbtt + CC_UNIT * sp_field


def txss_cbap_windows(tbtt, bi_tu, p, exclude=()):
    """10.40.3.4: n-е окно TXSS CBAP [T_Start, T_End), n = 1…N: T_Start = T_TBTT + 8·T_o + (n − 1)·1024·T_BI / N,
    T_End = T_Start + 8·T_d (T_o, T_d — значения полей, СПОРНО → принято PLAN.md №85); из окон вычитаются exclude —
    BHI и SP с AID 255/255."""
    if not p.txss_cbap:
        return []
    out = []
    for n in range(1, p.txss_maxmem + 1):
        s = tbtt + 8 * p.txss_offset + Fr((n - 1) * 1024 * bi_tu, p.txss_maxmem)
        segs = [(s, s + 8 * p.txss_duration)]
        for a, b in exclude:
            nxt = []
            for x, y in segs:
                if b <= x or y <= a:
                    nxt.append((x, y))
                    continue
                if x < a:
                    nxt.append((x, a))
                if b < y:
                    nxt.append((b, y))
            segs = nxt
        out += segs
    return out


def beacon_random_delay_max(txtime_beacon, min_bhi_us=DOT11_MIN_BHI_DURATION):
    """11.1.3.3.1 (ECAPC = 1, маяк одной передачей): задержка «up to min(4×TXTIME(DMG Beacon),
    1024×dot11MinBHIDuration) µs». dot11MinBHIDuration — уже мкс (MIB UNITS «microseconds»): множитель 1024 — как для
    TU; СПОРНО → принято PLAN.md №86 — берётся min(4·TXTIME, dot11MinBHIDuration)."""
    return min(4 * txtime_beacon, Fr(min_bhi_us))


# ================================================================== децентрализованный кластер (10.40.2.1, 10.40.3.2)
def empty_beacon_sps(heard, sap_tbtt, bi_tu, maxmem, sp_field, listened_us):
    """10.40.2.1: пустые Beacon SP (номера n ≥ 2) — без принятого DMG Beacon за прослушивание ≥ aMinChannelTime.
    heard — [(начало, конец)] принятых DMG Beacon. Прослушивание короче aMinChannelTime — ClusterError."""
    if listened_us < aMinChannelTime:
        raise ClusterError(f'прослушивание {float(listened_us)} мкс < aMinChannelTime {float(aMinChannelTime)} '
                           '(10.40.2.1)')
    busy = set()
    for t0, t1 in heard:
        busy |= overlaps_beacon_sps(t0, t1, sap_tbtt, bi_tu, maxmem, sp_field)
    return set(range(2, maxmem + 1)) - busy


class DecentralizedAp:
    """AP/PCP с децентрализованной кластеризацией (10.40.2.1, 10.40.3.2). Состояние: role, cluster_id, n (свой
    Beacon SP), sap_tbtt (TBTT S-AP в своём времени), bi_tu, maxmem, sp_field. Решения «may» генератор принимает в
    пользу продолжения работы в кластере (стать S-AP); «should» — исполняет."""

    def __init__(self, mac, bi_tu, maxmem=4, sp_us=DOT11_BEACON_SP_DURATION):
        self.mac, self.bi_tu, self.maxmem, self.sp_field = mac, bi_tu, maxmem, beacon_sp_field(sp_us)
        self.role, self.cluster_id, self.n, self.sap_tbtt = ROLE_NONE, None, None, None
        self.lost_bis, self.periods, self.monitoring = 0, 0, False
        self._period_bis, self._seen_sap, self._seen_same, self._seen_any = 0, None, set(), False

    # ---- образование
    def start_sap(self, tbtt=0):
        """Стать S-AP (10.40.2.1): Cluster ID = свой MAC, роль 1, Beacon SP_1 (TBTT S-AP = свой)."""
        v = check_cluster_params(self.bi_tu, self.maxmem, self.sp_field, ecapc=0)
        if v:
            raise ClusterError('; '.join(v))
        self.role, self.cluster_id, self.n, self.sap_tbtt = ROLE_SAP, self.mac, 1, Fr(tbtt)
        self.lost_bis, self.periods, self.monitoring = 0, 0, False
        return self

    def join(self, sap_mac, sap_cc, sap_bi_tu, sap_tbtt, empty):
        """Вход членом в пустой Beacon SP (10.40.2.1); empty — empty_beacon_sps. Нет пустых — False («shall not become
        a member»: S-AP нового кластера или уход с канала — решение вызывающего)."""
        if not empty:
            return False
        self.bi_tu = sap_bi_tu                    # «beacon interval length … equal to … its S-AP»
        self.maxmem, self.sp_field = sap_cc.cluster_max_mem, sap_cc.beacon_sp_duration
        self.role, self.cluster_id, self.n, self.sap_tbtt = ROLE_MEMBER, sap_mac, min(empty), Fr(sap_tbtt)
        self.lost_bis, self.periods, self.monitoring = 0, 0, False
        return True

    def own_tbtt(self, k=0):
        """TBTT своего BI k во времени S-AP: TBTT S-AP + ClusterTimeOffset_{n−1} (свой маяк — в своём Beacon SP)."""
        return self.sap_tbtt + k * bi_us(self.bi_tu) + cluster_time_offset(self.n - 1, self.bi_tu, self.maxmem)

    def cc(self):
        """Clustering Control своих маяков (рис. 9-78) или None до образования (роль 0 — 10.40.1 у включённой, но не
        члена: см. cc_idle)."""
        if self.role == ROLE_NONE:
            return None
        return F.ClusteringControl(beacon_sp_duration=self.sp_field, cluster_id=self.cluster_id,
                                   member_role=self.role, cluster_max_mem=self.maxmem, spsh=0)

    def cc_idle(self):
        """10.40.1: «A clustering enabled AP … not a member of any cluster shall set the Cluster Member Role subfield
        to 0»."""
        return F.ClusteringControl(beacon_sp_duration=self.sp_field, cluster_id=self.mac, member_role=ROLE_NONE,
                                   cluster_max_mem=self.maxmem, spsh=0)

    def schedule(self, k=0):
        """Beacon SP других членов в расписании своего BI k (10.40.2.1); начала — в своём TSF (TBTT BI k = k·BI,
        11.1.3.3.1: «Time value zero of the TSF is defined to be a TBTT»)."""
        return beacon_sp_entries(k * bi_us(self.bi_tu), self.n, self.bi_tu, self.maxmem, self.sp_field)

    def may_tx(self, t0, t1):
        """10.40.2.1 «should not transmit … during a Beacon SP that is not its own»."""
        return not overlaps_beacon_sps(t0, t1, self.sap_tbtt, self.bi_tu, self.maxmem, self.sp_field, skip={self.n})

    # ---- сопровождение (10.40.3.2)
    def on_beacon(self, src, cc, ecapc):
        """Принятый DMG Beacon. Возвращает действие: None | 'join_lower_sap' (другой S-AP с меньшим MAC — «should
        become a member», 10.40.3.2) | 'rejoin' (S-AP найден в периоде мониторинга) | 'quit_for_ecapc' (S-AP
        централизованного кластера: уйти до TBTT + BI, 10.40.2.2; слепота — вне этого класса)."""
        if not isinstance(cc, F.ClusteringControl):
            return None
        if ecapc and cc.member_role == ROLE_SAP:
            return 'quit_for_ecapc'
        if ecapc:
            return None
        self._seen_any = True
        if cc.member_role == ROLE_SAP:
            if self.role == ROLE_SAP and src != self.mac and src < self.mac:
                return 'join_lower_sap'
            if self.role == ROLE_MEMBER and cc.cluster_id == self.cluster_id and src == self.cluster_id:
                self.lost_bis = 0
                if self.monitoring:
                    self.monitoring, self.periods = False, 0
                return None
            if self.monitoring:
                self._seen_sap = src
                return 'rejoin'
        elif self.role == ROLE_MEMBER and cc.cluster_id == self.cluster_id:
            self._seen_same.add(src)
        return None

    def end_bi(self):
        """Конец своего BI. Действие: None | 'monitor' (начат период мониторинга — передача S-AP) | 'become_sap' |
        'become_sap_may' | 'monitor_again' | 'may_reform' (> dot11MaxNumberOfClusteringMonitoringPeriods — «may cease
        cluster maintenance and initiate cluster formation»). СПОРНО → принято PLAN.md №90: первый период входит в
        счёт; без маяков кластеризующих STA — shall стать S-AP, с чужими — may (генератор становится S-AP)."""
        if self.role != ROLE_MEMBER:
            return None
        if not self.monitoring:
            self.lost_bis += 1
            if self.lost_bis >= CC_MONITOR_BIS:                  # первый период мониторинга без S-AP
                self.monitoring, self.periods, self._period_bis = True, 1, 0
                self._seen_same, self._seen_any = set(), False
                return 'monitor'
            return None
        self._period_bis += 1
        if self._period_bis < CC_MONITOR_BIS:
            return None
        self.periods += 1
        same, any_seen = self._seen_same, self._seen_any
        self._period_bis, self._seen_same, self._seen_any = 0, set(), False
        if same:
            # «compares the MAC addresses of all such received DMG Beacons with its own … If its MAC address is the
            # lowest, … shall become an S-AP»
            if self.mac < min(same):
                return self._become_sap()
            if self.periods > DOT11_MAX_CLUSTERING_MONITORING_PERIODS:
                return 'may_reform'
            return 'monitor_again'
        # нет ни S-AP, ни своего кластера: «no DMG Beacons from clustering enabled STAs» — shall; иначе — may
        self._become_sap()
        return 'become_sap' if not any_seen else 'become_sap_may'

    def _become_sap(self):
        tb = self.own_tbtt()
        self.start_sap(tb)
        return 'become_sap'


# ==================================================================== централизованный кластер (10.40.2.2, 10.40.3.3)
CcsrConfig = namedtuple('CcsrConfig', 'ccsr policy bi_tu maxmem sp_field start excluded ch2_allowed')


def check_ccsr_config(cfg):
    """Шаг конфигурации (10.40.2.2): адрес CCSR, ECAPC Policy Detail, BI, ClusterMaxMem, Beacon SP Duration, TXSS
    CBAP, непустой список исключённых каналов; канал 2 исключён, если разрешён; BI / ClusterMaxMem — целое мкс; BI/N
    или N/BI — целое. Возвращает причины неуспеха (пусто — успех)."""
    v = []
    if not cfg.ccsr:
        v.append('нет MAC-адреса CCSR')
    if not cfg.excluded:
        v.append('список исключённых каналов пуст («nonempty list of excluded channels»)')
    if cfg.ch2_allowed and 2 not in (cfg.excluded or ()):
        v.append('канал 2 разрешён, но не в списке исключённых')
    v += check_cluster_params(cfg.bi_tu, cfg.maxmem, cfg.sp_field, ecapc=1)
    v += check_ecapc_policy(cfg.policy, maxmem=cfg.maxmem, bi_tu=cfg.bi_tu)
    return v


def verification_ok(beacons, same_ccss):
    """Шаг проверки (10.40.2.2): beacons — [(cluster_id, ecapc, role)] за aMinChannelTime; same_ccss — Cluster ID
    S-AP своего CCSS. Неуспех — маяк ECAPC = 1 с ролью 1/2 из другого ECAPC."""
    return not [c for c, ec, role in beacons if ec and role in (ROLE_SAP, ROLE_MEMBER) and c not in same_ccss]


def ecapc_blind(sap_channels_heard, supported_channels):
    """10.40.2.2: маяки ECAPC = 1 от S-AP на каждом поддерживаемом канале класса за aMinChannelTime — AP/PCP
    «слепой» на 300 × aMinChannelTime (ECAPC Policy Enforced принимаемых маяков считается 0)."""
    return set(supported_channels) <= set(sap_channels_heard)


def must_react_to_ecapc(sap_seen, sap_channels_heard, supported_channels, blind, centralized_enabled):
    """10.40.2.2: AP/PCP (любой, не только кластеризующий), принявший маяк S-AP с ECAPC = 1, не слепой и не принявший
    таких маяков на всех каналах за aMinChannelTime, «shall either join … if centralized clustering enabled or cease
    its activity on this channel». Возвращает None | 'join' | 'cease'."""
    if not sap_seen or blind or ecapc_blind(sap_channels_heard, supported_channels):
        return None
    return 'join' if centralized_enabled else 'cease'


class CentralizedSap:
    """S-AP централизованного кластера (10.40.2.2, 10.40.3.3). cfg — CcsrConfig; members — {MAC: индекс n − 1}."""

    def __init__(self, mac, cfg):
        why = check_ccsr_config(cfg)
        if why:
            raise ClusterError('шаг конфигурации: ' + '; '.join(why))
        self.mac, self.cfg, self.members = mac, cfg, {}
        self.ecapc = 1                      # «shall set the ECAPC Policy Enforced subfield … to 1 for the lifetime»

    def cc(self):
        return F.ClusteringControl(beacon_sp_duration=self.cfg.sp_field, cluster_id=self.mac, member_role=ROLE_SAP,
                                   cluster_max_mem=self.cfg.maxmem, spsh=0)

    def policy(self, recipient=None):
        """ECAPC Policy для (Re)Association Response/Announce/Information Response; recipient — MAC получателя
        индивидуального кадра (его индекс в карте не считается занятым)."""
        p = self.cfg.policy
        bm = available_bitmap(self.cfg.maxmem, set(self.members.values()), self.members.get(recipient))
        return p._replace(bitmap=bm)

    def on_cto(self, member, index):
        """Information Response с Cluster Time Offset от второй STA члена (10.40.2.2, 10.40.3.3)."""
        v = check_cto(index, self.cfg.maxmem)
        if v:
            raise ClusterError('; '.join(v))
        self.members[member] = index

    def schedule(self, tbtt):
        """Beacon SP на каждом занятом ClusterTimeOffset последней переданной карты (10.40.2.2)."""
        used = in_use_offsets(self.policy().bitmap, self.cfg.maxmem)
        return beacon_sp_entries(tbtt, 1, self.cfg.bi_tu, self.cfg.maxmem, self.cfg.sp_field,
                                 which={i + 1 for i in used})

    def reconfigure(self, cfg, stas):
        """10.40.3.3: смена Beacon SP Duration/ECAPC Policy от CCSR — обновить поле и разослать индивидуальные
        Announce/Information Response станциям BSS. Возвращает [(получатель, ECAPC Policy)]."""
        self.cfg = cfg
        return [(s, self.policy(s)) for s in stas]


class CentralizedMember:
    """Член централизованного кластера (10.40.2.2, 10.40.3.3, 10.40.3.4). Требует MM-SME со второй non-AP STA,
    ассоциированной с S-AP: её Announce даёт ECAPC Policy, её Information Response несёт Cluster Time Offset."""

    def __init__(self, mac):
        self.mac, self.role, self.ecapc = mac, ROLE_NONE, 0
        self.sap = self.cc_sap = self.policy_sap = self.index = None
        self.lost_bis = 0

    def join(self, sap, sap_cc, sap_policy, empty, second_sta_associated=True):
        """Шаги входа (10.40.2.2): пустые Beacon SP за aMinChannelTime (empty), ассоциация второй STA и Announce с
        ECAPC Policy, выбор индекса; возвращает Cluster Time Offset (элемент для Information Response второй STA) или
        None («shall not become a member»)."""
        if not empty or not second_sta_associated:
            return None
        idx = select_cto(empty, sap_policy.bitmap, sap_cc.cluster_max_mem)
        if idx is None:
            return None
        self.sap, self.cc_sap, self.policy_sap, self.index = sap, sap_cc, sap_policy, idx
        self.role, self.ecapc, self.lost_bis = ROLE_MEMBER, 1, 0
        return encode_cto(idx)

    def cc(self):
        """Копии полей последнего маяка S-AP, роль 2 (10.40.2.2); после ухода — None."""
        if self.role != ROLE_MEMBER:
            return None
        c = self.cc_sap
        return F.ClusteringControl(beacon_sp_duration=c.beacon_sp_duration, cluster_id=self.sap,
                                   member_role=ROLE_MEMBER, cluster_max_mem=c.cluster_max_mem, spsh=0)

    def policy(self):
        """ECAPC Policy члена: поля S-AP, карта «reserved» (0) (10.40.2.2); после ухода — не передаётся."""
        return self.policy_sap._replace(bitmap=0) if self.role == ROLE_MEMBER else None

    def on_sap_beacon(self, cc):
        """Маяк своего S-AP: обновить поля (10.40.3.3 «shall update the Clustering Control field sent in subsequent
        frames»)."""
        self.cc_sap, self.lost_bis = cc, 0

    def end_bi(self, centralized_saps_heard=False, blind=False, decentral_capable=False, decentral_present=False):
        """10.40.3.3: S-AP не слышен > 4 × aMinBTIPeriod BI — вариант b): S-AP с ECAPC = 1 слышны — войти (не слепой);
        иначе — децентрализованный кластер (если способен и есть) или роль 0; c) ECAPC = 0, без ECAPC Policy."""
        if self.role != ROLE_MEMBER:
            return None
        self.lost_bis += 1
        if self.lost_bis <= CC_MONITOR_BIS:
            return None
        self.role, self.ecapc = ROLE_NONE, 0
        if centralized_saps_heard and not blind:
            return 'join_other_sap'
        if centralized_saps_heard and blind:
            return 'may_join_other_sap'
        return 'join_decentralized' if decentral_capable and decentral_present else 'role_0'


# ============================================================== Cluster Request (10.40.5), смена параметров (11.29.4)
def clustering_enabled(cc, discovery=0):
    """10.40.1: AP/PCP «clustering enabled», если передаёт Clustering Control (формат рис. 9-78)."""
    return isinstance(cc, F.ClusteringControl) and not discovery


def cluster_request_expired(bi_sent, bi_now, enabled_seen):
    """10.40.5: после Cluster Report с Cluster Request = 1 STA «may transmit an Announce frame including the last
    Extended Schedule element», если маяка своей точки с включённой кластеризацией нет dot11ClusterEnableTime BI."""
    return not enabled_seen and bi_now - bi_sent >= DOT11_CLUSTER_ENABLE_TIME


def check_broadcast_announce(mcs):
    """10.40.5: Announce с TA = broadcast «shall use MCS 0»."""
    return [] if mcs == 0 else [f'Announce с широковещательным TA на MCS {mcs} — «shall use MCS 0» (10.40.5)']


def change_moves_beacon_sps(change):
    """11.29.4: перенос TBTT S-AP или смена BI меняет размещение Beacon SP (ClusterTimeOffset — от TBTT S-AP и BI)."""
    return bool(change and (change['move'] or change['size']))


def member_change(sap_change, sap_to_own_us, index, maxmem, bi_tu_new):
    """11.29.4: элемент DMG BSS Parameter Change члена по изменению S-AP («immediately insert the appropriate …»):
    тот же Move/Size, BI Duration S-AP; TBTT Offset — первый изменённый TBTT члена в своём TSF: TBTT S-AP (в TSF S-AP)
    + sap_to_own_us (сдвиг TSF члена относительно TSF S-AP) + ClusterTimeOffset_index при новом BI."""
    off = cluster_time_offset(index, bi_tu_new, maxmem)
    return dict(move=sap_change['move'], size=sap_change['size'],
                tbtt_offset=int(sap_change['tbtt_offset'] + sap_to_own_us + off) & 0xFFFFFFFF,
                bi_duration=sap_change['bi_duration'])


def check_change_beacons(bis):
    """[(BI, сообщение)] ряда своих маяков [(k, cc, change)] (11.29.4): S-AP передаёт Clustering Control в каждом
    маяке с DMG BSS Parameter Change, меняющим Beacon SP."""
    out, role = [], None
    for k, cc, ch in bis:
        if isinstance(cc, F.ClusteringControl):
            role = cc.member_role
        elif role == ROLE_SAP and change_moves_beacon_sps(ch):
            out.append((k, 'S-AP: DMG BSS Parameter Change без Clustering Control (11.29.4: «shall transmit the '
                           'updated Clustering Control field in every DMG Beacon frame in which the DMG BSS Parameter '
                           'Change element is transmitted»)'))
    return out


# ============================================================================== проверки записей (для air_judge)
def tbtt_from_beacon(t_rx, timestamp, bi_tu):
    """TBTT передатчика в шкале t_rx по его маяку: Timestamp — TSF передатчика в начале кадра (11.1.3.1), TSF 0 —
    TBTT (11.1.3.3.1): TBTT = t_rx − (Timestamp mod BI)."""
    return t_rx - Fr(timestamp % int(bi_us(bi_tu)))


def check_own_beacon(own_mac, cc, ecapc, cbap_only, discovery=0, caps=None):
    """[(сообщение, вердикт)] одного DMG Beacon своей точки: согласованность Clustering Control, ECAPC Policy
    Enforced и бит кластеризации DMG Capabilities (caps — dict DMG AP Or PCP Capability Information или None)."""
    out = []
    if cc is None or discovery:
        if ecapc:
            out.append(('ECAPC Policy Enforced = 1 без Clustering Control: S-AP и члены централизованного кластера '
                        'включают поле (10.40.1, 10.40.2.2), после ухода ECAPC = 0 (10.40.3.3 c))', 'ours'))
        return out
    if caps is not None:
        if not (caps.get('decentralized_clustering') or caps.get('centralized_clustering')):
            out.append(('Clustering Control в маяке при Decentralized/Centralized AP or PCP Clustering = 0 в DMG '
                        'Capabilities (10.40.1: поле передаёт «clustering capable» AP/PCP; PLAN.md №87)', 'model'))
        if ecapc and not caps.get('centralized_clustering'):
            out.append(('ECAPC Policy Enforced = 1 при Centralized AP or PCP Clustering = 0 (10.40.1, 10.40.2.2)',
                        'ours'))
    if ecapc and cc.member_role not in (ROLE_SAP, ROLE_MEMBER):
        out.append((f'ECAPC Policy Enforced = 1 при Cluster Member Role = {cc.member_role} (10.40.3.3 c): вне кластера '
                    'ECAPC = 0)', 'ours'))
    if cc.member_role == ROLE_SAP and cc.cluster_id != own_mac:
        out.append((f'роль S-AP, а Cluster ID {cc.cluster_id} ≠ своему MAC {own_mac} (10.40.1, 9.3.4.2)', 'ours'))
    if cc.member_role == ROLE_MEMBER and cc.cluster_id == own_mac:
        out.append(('роль члена, а Cluster ID = свой MAC (Cluster ID — MAC S-AP, 10.40.1)', 'ours'))
    if cc.member_role in (ROLE_SAP, ROLE_MEMBER) and cbap_only:
        out.append(('член кластера с CBAP Only = 1: Beacon SP других членов задаются в Extended Schedule (10.40.2.1/'
                    '10.40.2.2 «shall schedule a Beacon SP»), а при CBAP Only весь DTI — CBAP (9.4.1.46)', 'ours'))
    return out


def check_beacon_series(bis):
    """[(BI, сообщение, вердикт)] по ряду BTI одной точки: bis — [(k, cc | None, ecapc)] по возрастанию k (BI с
    маяком). Член кластера — Clustering Control в каждом маяке (10.40.1); S-AP децентрализованного — маяк с полем не
    реже aMinBTIPeriod BI (10.40.2.1); S-AP централизованного — ECAPC = 1 до конца BSS (10.40.2.2)."""
    out = []
    member, sap_ec, last_sap = False, False, None
    for k, cc, ec in bis:
        role = cc.member_role if isinstance(cc, F.ClusteringControl) else None
        if member and role is None:
            out.append((k, 'маяк члена кластера без Clustering Control (10.40.1: «shall include … in each DMG Beacon»)',
                        'ours'))
        if sap_ec and role == ROLE_SAP and not ec:
            out.append((k, 'S-AP централизованного кластера сбросил ECAPC Policy Enforced (10.40.2.2: «for the '
                           'lifetime of the BSS»)', 'ours'))
        if role == ROLE_SAP and not ec and last_sap is not None and k - last_sap > aMinBTIPeriod:
            out.append((k, f'S-AP: маяки с Clustering Control через {k - last_sap} BI > aMinBTIPeriod (10.40.2.1)',
                        'ours'))
        if role is not None:
            member = role in (ROLE_SAP, ROLE_MEMBER)
        if role == ROLE_SAP:
            last_sap, sap_ec = k, sap_ec or bool(ec)
    return out


def check_member_vs_sap(m, s, sp_tol=Fr(0)):
    """[(сообщение, вердикт)] маяка члена m против маяка его S-AP s (оба — dict: src, t, te, timestamp, bi_tu, cc,
    ecapc). Поля по 10.40.2.1/10.40.2.2: BI, Beacon SP Duration, ClusterMaxMem, Cluster ID, ECAPC; маяк члена — в
    Beacon SP_n, n ≥ 2, по TBTT S-AP из его Timestamp."""
    out = []
    mc, sc = m['cc'], s['cc']
    if mc.cluster_id != s['src']:
        out.append((f'Cluster ID {mc.cluster_id} ≠ MAC S-AP {s["src"]} (10.40.1)', 'ours'))
    if m['bi_tu'] != s['bi_tu']:
        out.append((f'BI члена {m["bi_tu"]} TU ≠ BI S-AP {s["bi_tu"]} TU (10.40.2.1/10.40.2.2)', 'ours'))
    if mc.cluster_max_mem != sc.cluster_max_mem:
        out.append((f'ClusterMaxMem {mc.cluster_max_mem} ≠ S-AP {sc.cluster_max_mem} (10.40.2.1/10.40.2.2)', 'ours'))
    if mc.beacon_sp_duration != sc.beacon_sp_duration:
        out.append((f'Beacon SP Duration {mc.beacon_sp_duration} ≠ S-AP {sc.beacon_sp_duration} (10.40.2.1/10.40.2.2)',
                    'ours'))
    if bool(m['ecapc']) != bool(s['ecapc']):
        out.append((f'ECAPC Policy Enforced члена {m["ecapc"]} ≠ S-AP {s["ecapc"]} (10.40.2.1: 0 / 10.40.2.2: 1)',
                    'ours'))
    if out or not maxmem_ok(s['bi_tu'], sc.cluster_max_mem):
        return out
    tb = tbtt_from_beacon(s['t'], s['timestamp'], s['bi_tu'])
    n = beacon_sp_of(m['t'] + sp_tol, m['te'] - sp_tol, tb, s['bi_tu'], sc.cluster_max_mem, sc.beacon_sp_duration)
    if n is None or n == 1:
        out.append(('маяк члена не в Beacon SP_n (n ≥ 2) по TBTT S-AP (10.40.1: «shall transmit its DMG Beacon frame '
                    'during one of the Beacon SPs»)', 'ours'))
    return out
