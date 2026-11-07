# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сравнитель поведения по эфиру (этап 2, rewrite/docs/ARCHITECTURE.md): два журнала одного сценария — проверяемая
сторона A (прошивка в эмуляторе или ядро) и эталонная сторона B (ядро в идеальной среде) — сравниваются по смыслу, не
по байтам. Вход — air_pcap.Air (ядро: journal.to_air(); эмулятор: snapshot_air(ref_bridge2.snapshot)) и снимок для судей
моста (journal.to_snapshot() / ref_bridge2.snapshot). Модуль моста (unit/ref_bridge2) передаёт вызывающий — ядро
tests/unit не импортирует.

Аспекты сравнения (каждое расхождение — Diff с классом и доказательством):
  судьи      — air_judge и судьи моста (judge_run) над обоими журналами: правило нарушено у одной стороны / у обеих;
  обмены     — последовательности обменов DTI (SLS, BRP, ассоциация, ADDBA, TXOP данных, CF-End) по виду и сигнатуре
               (кто → кому, какие кадры, повторы свёрнуты), порядок фаз каждой станции;
  поля       — смысловые поля кадров: BI Control, DMG Parameters, DMG Capabilities, адреса и биты DS, Ack Policy,
               Retry, Sequence Number, ADDBA, BRP, MCS по виду кадра;
  Duration   — смысл поля: сдвиг конца NAV внутри обмена (ответ сохраняет NAV держателя), значение у кадров вне обмена;
  промежутки — SIFS/SBIFS/MBIFS внутри обменов против номинала с допуском 10.3.2.3; доступ — AIFS[AC] + k·aSlotTime
               от конца занятости;
  роли       — кто начинает обмен каждого вида;
  счётчики   — кадров по видам, повторов, SLS, развёрток, MPDU в A-MPDU, маяков в BTI;
  параметры BSS — BI, BIC, EDCA Parameter Set, число секторов (сценарий их не навязывает прошивке).

Классы (CLASSES):
  «прошивка ≠ стандарт» — судья/номинал отвергает сторону A, сторона B проходит, часть — не разгрузка модели MAC;
  «ядро ≠ стандарт»     — судья/номинал отвергает сторону B (ядро);
  «модель MAC эмулятора» — расхождение в том, что делает модель MAC эмулятора (точки разгрузки ARCHITECTURE.md §2 и
                           допущения H-*: ответ через SIFS, Duration RTS/кадров очереди, отсрочка EDCA, содержимое
                           ответов MAC, вставка TA/Timestamp/BIC, RA CF-End в эфире > 2 узлов);
  «трактовка»           — нарушение зависит от трактовки (вердикт судьи 'model', ref/PLAN.md);
  «неопределённо»       — обе стороны в рамках стандарта (выбор реализации) или стандарт не даёт номинала."""
import difflib
from collections import Counter, defaultdict
from dataclasses import asdict, dataclass, field
from fractions import Fraction as Fr

from .. import air_judge as AJ
from .. import air_pcap as AP
from .. import bi as BI
from .. import blockack as BA
from .. import elements as E
from .. import fields as F
from ..timing import (BCAST, CLK_MHZ, MBIFS, MBIFS_TOL, SBIFS, SBIFS_MAX, SIFS, SIFS_TOL, aifs, aSlotTime,
                      BRPIFS_MAX)
from . import judge_run as JR
from .sap_phy import data_symbol_offset

FW_STD, CORE_STD, MODEL, INTERP, UNDEF = ('прошивка ≠ стандарт', 'ядро ≠ стандарт', 'модель MAC эмулятора',
                                          'трактовка', 'неопределённо')
CLASSES = (FW_STD, CORE_STD, MODEL, INTERP, UNDEF)
ASPECTS = ('прогон', 'судьи', 'обмены', 'поля', 'Duration', 'промежутки', 'доступ', 'роли', 'счётчики', 'параметры BSS')

GAP_EXCH = Fr(12)                 # кадры одного обмена: промежуток < AIFS[AC_VO] = 13 мкс (10.3.2.3, 10.23.2.4)


# =====================================================================================================================
# журнал → Air
# =====================================================================================================================
def time_base(snap, ap_mac):
    """Сдвиг тактов → мкс TSF точки с сеткой TBTT, кратной BI (как unit/ref_bridge2.time_base)."""
    n = snap['nodes'][bytes(ap_mac)]
    phase = n['tbtt_us'] % n['bi_us']
    return Fr(n['tsf0_us'] - phase), n['bi_us']


def snapshot_air(snap, ap_mac, names):
    """Снимок эфира (ref_bridge2.snapshot / journal.to_snapshot) → air_pcap.Air. names — {MAC (bytes): имя узла};
    приёмники — все прочие узлы (канал эмулятора идеальный, air.py), кадр с 'dropped' — никто."""
    base, _ = time_base(snap, ap_mac)
    evs = []
    for f in sorted(snap['frames'], key=lambda f: (f['start'], f['end'])):
        raw = bytes(f['frame'])
        agg = bool(f.get('mpdus'))
        fc, kind, first, act = AP.classify(raw, agg)
        dst = BCAST if first == 'DMG Beacon' else F.mac_str(raw[4:10])
        p, err = AP._parse(first, raw) if not agg else (None, None)
        src = F.mac_str(bytes(f['src']))
        node = names.get(bytes(f['src']), src)
        mpdus = [bytes(m) for m in f['mpdus']] if agg else [raw]
        rx = () if f.get('dropped') else tuple(sorted(n for m, n in names.items() if n != node))
        t, te = Fr(f['start'], CLK_MHZ) + base, Fr(f['end'], CLK_MHZ) + base
        w = f.get('what', '')
        evs.append(AP.AirEv(
            i=len(evs), t=t, te=te, src=src, dst=dst, kind=kind, first=first, dur=int.from_bytes(raw[2:4], 'little'),
            mcs=f.get('mcs') or 0, raw=raw, fc=fc, p=p, err=err, action=act, by_mac=w.startswith('ответ на'), what=w,
            mpdus=mpdus, length=(sum(len(m) + 8 for m in mpdus) if agg else len(raw) + 4), agg=agg, t_ok=True,
            t_lo=t, t_hi=t, t_from='tx', dur_ok=True, body_ok=True, synth=False, mcs_ok=True, tx_node=node,
            rx_nodes=rx, recs=[], cal_ok=True))
    nodes = {n: F.mac_str(m) for m, n in names.items()}
    return AP.Air(evs, nodes, F.mac_str(bytes(ap_mac)), None, {'events': len(evs)}, {})


# =====================================================================================================================
# расписание BI по маякам (как unit/ref_bridge2.Schedule, над AirEv)
# =====================================================================================================================
class Schedule:
    def __init__(self, evs, ap, bi_tu):
        from ..timing import LBIFS as _LB, LBIFS_TOL as _LBT
        self.ap, self.bi_tu = ap, bi_tu
        self.cfg, self.bti = {}, {}
        by = {}
        for e in evs:
            if e.kind == 'DMG Beacon' and e.src == ap and e.p is not None:
                by.setdefault(BI.bi_index(e.t, bi_tu), []).append(e)
        for k, bs in by.items():
            p = bs[0].p
            b = p.bic
            bic = BI.BeaconIntervalControl(
                cc_present=b.cc_present, discovery_mode=b.discovery, next_beacon=b.next_beacon,
                ati_present=b.ati_present, abft_length=b.abft_length, fss=b.fss, is_responder_txss=b.is_resp_txss,
                next_abft=b.next_abft, fragmented_txss=b.fragmented_txss, txss_span=b.txss_span,
                n_bis_abft=b.n_bis_abft, abft_count=b.abft_count, n_abft_in_ant=b.n_abft_in_ant,
                pcp_association_ready=b.pcp_assoc_ready)
            self.cfg[k] = BI.BiConfig(bic=bic, params=BI.DmgParameters(
                p.params.bss_type, p.params.cbap_only, p.params.cbap_source, p.params.privacy, p.params.ecapc))
            chain = [bs[0]]
            for x in bs[1:]:
                if x.t - chain[-1].te <= _LB + _LBT:
                    chain.append(x)
            self.bti[k] = (chain[0].t, chain[-1].te + chain[-1].dur, chain)

    def config(self, k):
        ks = [j for j in self.cfg if j <= k]
        return self.cfg[max(ks)] if ks else None

    def periods(self, k):
        c = self.config(k)
        if c is None:
            return []
        b = self.bti.get(k)
        return BI.layout(k, self.bi_tu, c, b[1] if b else None)

    def period_of(self, t):
        return BI.period_at(self.periods(BI.bi_index(t, self.bi_tu)), t)

    def phase(self, e):
        if e.kind == 'DMG Beacon':
            return 'BTI'
        per = self.period_of(e.t)
        if per is None:
            return 'вне BI'
        return per.kind if per.kind in ('BTI', 'A-BFT') else 'DTI'


# =====================================================================================================================
# сторона сравнения
# =====================================================================================================================
@dataclass
class Viol:
    judge: str
    rule: str
    idx: int
    msg: str
    verdict: str = 'ours'


class Side:
    """Журнал одной стороны с разбором: роли узлов, фазы, обмены, нарушения судей.
    emulator=True — сторона идёт на модели MAC эмулятора (атрибуция точек разгрузки и H-*)."""
    def __init__(self, label, air, snap, ap, bi_tu, RB=None, emulator=False, meta=None):
        self.label, self.air, self.snap, self.ap, self.bi_tu = label, air, snap, ap, bi_tu
        self.emulator, self.meta = emulator, meta or {}
        self.evs = air.events
        # TSF узла = время журнала + сдвиг (журнал эмулятора — ось с TBTT, кратным BI; ref_bridge2.time_base)
        self.tsf_shift = 0
        if snap is not None and snap.get('nodes'):
            n = snap['nodes'].get(F.mac_bytes(ap))
            if n:
                self.tsf_shift = Fr(n['tbtt_us'] % n['bi_us'])
        stas = [m for n, m in air.nodes.items() if m != ap]
        self.role = {ap: 'AP', BCAST: '*'}
        for i, m in enumerate(stas):
            self.role[m] = 'STA' if len(stas) == 1 else f'STA{i + 1}'
        self.sched = Schedule(self.evs, ap, bi_tu)
        self.phase = [self.sched.phase(e) for e in self.evs]
        self.exchanges = split_exchanges(self)
        self.exchange_of = {e.i: x for x in self.exchanges for e in x.evs}
        self.viol = self._judge(RB)
        for v in self.viol:
            if v.rule == 'busy' and _hidden(self, v):
                v.verdict = 'hidden'              # направленная скрытая станция: CCA передатчика свободна
        self.viol_by_ev = defaultdict(list)
        for v in self.viol:
            if v.idx is not None and v.idx >= 0:
                self.viol_by_ev[v.idx].append(v)

    def rc(self, mac):
        r = self.role.get(mac, '?')
        return 'STA' if r.startswith('STA') else r

    def _judge(self, RB):
        out = []
        _, rules = AJ.judge(self.air)
        for r in rules:
            for i, m, v in r.viol:
                out.append(Viol('air_judge', r.rid, i, m, v))
        self.air_rules = rules
        out = self._brp_recheck(out)
        if RB is not None and self.snap is not None:
            bevs, found = JR.bridge_snapshot(self.snap, self.ap, RB, self.bi_tu)
            # индекс события моста → индекс AirEv (оба упорядочены по (начало, конец), сверка по времени и передатчику)
            pos = {(e.t, e.src): e.i for e in self.evs}
            for f in found:
                b = bevs[f.idx] if 0 <= f.idx < len(bevs) else None
                idx = pos.get((b.t, b.src), -1) if b is not None else -1
                out.append(Viol('мост/' + f.judge, f.rule, idx, f.msg, 'ours'))
        return out

    def _brp_recheck(self, viol):
        """air_judge.r_brp считает конец PPDU BRP по длине без полей TRN (в записи PMC их нет), журнал ядра и эмулятора
        знает настоящий конец (te, с TRN): «нет ответа в пределах BRPIFS» перепроверяется от te (10.3.2.3.9: BRPIFS — от
        конца «training field if present»); снятые — в self.judge_notes."""
        from ..timing import BRPIFS
        out, self.judge_notes = [], []
        for v in viol:
            if v.judge == 'air_judge' and v.rule == 'brp' and v.msg.startswith('no-response') and 0 <= v.idx < len(
                    self.evs):
                e = self.evs[v.idx]
                nxt = next((q for q in self.evs[e.i + 1:e.i + 30] if q.src == e.dst), None)
                if nxt is not None and SIFS - SIFS_TOL <= nxt.t - e.te <= BRPIFS:
                    self.judge_notes.append(f'снято air_judge/brp no-response #{e.i}: ответ через '
                                            f'{float(nxt.t - e.te):.2f} мкс после конца PPDU с TRN')
                    continue
            out.append(v)
        return out


# =====================================================================================================================
# обмены
# =====================================================================================================================
def token(side, e):
    k = e.kind
    if k in ('Action', 'Action No Ack'):
        k = e.action or k
    elif k == 'SSW':
        k = 'SSW-ISS' if e.p is not None and e.p.ssw.direction == 0 else 'SSW-RSS'
    return f'{side.rc(e.src)}>{side.rc(e.dst)} {k}'


class Exchange:
    __slots__ = ('evs', 'kind', 'sig', 'pair', 'init')

    def __init__(self, side, evs):
        self.evs = evs
        toks = [token(side, e) for e in evs]
        self.sig = signature(toks)
        kinds = [t.split(' ', 1)[1] for t in toks]
        self.kind = exchange_kind(kinds)
        self.init = side.rc(evs[0].src)
        macs = {e.src for e in evs} | {e.dst for e in evs}
        stas = sorted(side.role[m] for m in macs if m in side.role and side.role[m].startswith('STA'))
        self.pair = stas[0] if stas else None

    @property
    def t(self):
        return self.evs[0].t


def signature(toks):
    """Свёртка повторов: подряд одинаковые кадры → «…+», подряд повторяющиеся пары (A-MPDU/BlockAck) → «(… → …)+»."""
    run = []
    for t in toks:
        if run and run[-1][0] == t:
            run[-1][1] += 1
        else:
            run.append([t, 1])
    out = [t + ('+' if n > 1 else '') for t, n in run]
    i = 0
    while i + 3 < len(out):
        if out[i:i + 2] == out[i + 2:i + 4]:
            pair = out[i:i + 2]
            j = i + 2
            while out[j:j + 2] == pair:
                del out[j:j + 2]
            out[i:i + 2] = ['(' + ' → '.join(pair) + ')+']
        i += 1
    return ' → '.join(out)


def exchange_kind(kinds):
    s = set(kinds)
    if s & {'SSW-ISS', 'SSW-RSS', 'SSW-Feedback', 'SSW-Ack'}:
        return 'SLS'
    if 'BRP' in s:
        return 'BRP'
    for k in (E.PROBE_REQ, E.PROBE_RESP, E.ASSOC_REQ, E.ASSOC_RESP, 'ADDBA Request', 'ADDBA Response', 'DELBA'):
        if k in s:
            return k
    if s & {'RTS', 'A-MPDU', 'Data'}:
        return 'TXOP данных'
    if s <= {'CF-End'}:
        return 'CF-End'
    return kinds[0]


def split_exchanges(side):
    """Кадры DTI → обмены: соседние с промежутком < GAP_EXCH (внутри обмена — SBIFS/SIFS/MBIFS, новый доступ — не
    раньше AIFS[AC_VO] = 13 мкс)."""
    out, cur = [], []
    for e, ph in zip(side.evs, side.phase):
        if ph != 'DTI':
            if cur:
                out.append(cur)
                cur = []
            continue
        if cur and e.t - max(x.te for x in cur) >= GAP_EXCH:
            out.append(cur)
            cur = []
        cur.append(e)
    if cur:
        out.append(cur)
    return [Exchange(side, x) for x in out]


# =====================================================================================================================
# расхождение и класс
# =====================================================================================================================
@dataclass
class Diff:
    aspect: str
    key: str
    a: object
    b: object
    cls: str = UNDEF
    clause: str = ''
    why: str = ''
    hyp: str = ''
    examples: list = field(default_factory=list)

    def as_dict(self):
        d = asdict(self)
        d['a'], d['b'] = _jsonable(self.a), _jsonable(self.b)
        return d


def _jsonable(x):
    if isinstance(x, Fr):
        return float(x)
    if isinstance(x, dict):
        return {str(k): _jsonable(v) for k, v in x.items()}
    if isinstance(x, (list, tuple, set, frozenset)):
        return [_jsonable(v) for v in (sorted(x, key=str) if isinstance(x, (set, frozenset)) else x)]
    if isinstance(x, (int, float, str, bool)) or x is None:
        return x
    return str(x)


def classify(a_bad, b_bad, hyp='', interp=''):
    """Класс по доказательствам: b_bad — стандарт отвергает ядро; hyp — расхождение в работе модели MAC эмулятора;
    interp — зависит от трактовки; a_bad — стандарт отвергает сторону A."""
    if b_bad:
        return CORE_STD
    if hyp:
        return MODEL
    if interp:
        return INTERP
    if a_bad:
        return FW_STD
    return UNDEF


# Точки разгрузки / допущения модели MAC эмулятора (ARCHITECTURE.md §2, air.py, machw.py, MAC-STAND.md)
H_RESP = 'немедленный ответ через SIFS — модель MAC (air.py собирает Ack/DMG CTS/BlockAck; срок — H-SIFSRESP/H-RESPCMD)'
H_DURQ = 'Duration RTS и кадров очереди MAC — остаток лимита TXOP (H-DURQ, machw._dur_field)'
H_BACKOFF = 'доступ EDCA/отсрочка — арбитр очередей модели MAC (H-BACKOFF: AIFS = SIFS + 3·слот для всех очередей)'
H_TXOP = 'продолжение TXOP после ответа — очередь MAC (H-TXAFTERACK, H-SLOT)'
H_BIC = 'BI Control и Timestamp маяка вставляет MAC (H-BIC)'
H_CFEND = 'RA CF-End держателя вставляет MAC — в эфире > 2 узлов широковещательный (H-FIFO-CFEND, air.py)'
H_NAV = 'NAV — модель MAC'
H_ABFT = ('развёртка SSW / сетка A-BFT — uc + GP-таймеры MAC (точка разгрузки): в эмуляции пачка A-BFT начинается на '
          '~0,31 мкс позже начала слота (H-ORIGIN 0,55 мкс от события GP), стенд std4/5 — −0,03…+0,04 мкс; '
          'Duration SSW uc считает от номинального начала слота (xfail test_ref_diff.test_abft_slot_start/ssw_duration)')
ABFT_RULES = ('abft', 'ssw_dur', 'ssw_start', 'abft_slot_start', 'abft_ss_end', 'SSW')
H_AMPDU = ('окно BA очереди — модель MAC (H-AMPDU: cosim._qdesc_op берёт окно из слова 1 дескриптора очереди [15:6]; '
           'при слове 0x20002800 — 160 MPDU); стенд — 1…32 MPDU на BlockAck (machw H-AMPDU)')
H_DURQ_CF = ('CF-End держателя усекает NAV, который поставил MAC по остатку лимита TXOP (H-DURQ) на кадре управления '
             'одиночного обмена')


def ev_hyp(side, e):
    """Допущение модели MAC эмулятора, которое строит кадр e стороны side (пусто — кадр строит прошивка/uc)."""
    if not side.emulator:
        return ''
    if e.by_mac:
        return H_RESP
    if e.kind == 'CF-End' and e.dst == BCAST:
        return H_CFEND
    return ''


def ev_dur_hyp(side, e):
    """Кто ставит Duration кадра e в эмуляторе: ответ — модель; RTS и кадры очередей (данные, управление из очереди
    0x1a) — H-DURQ; маяк, SSW/SSW-Feedback/SSW-Ack, BRP, CF-End — значение uc (0x15, H-DUR18/H-LITSSW)."""
    if not side.emulator:
        return ''
    if e.by_mac:
        return H_RESP
    if e.kind == 'RTS' or e.what.startswith('queue'):
        return H_DURQ
    return ''


RULE_HYP = {
    # air_judge
    'ifs_sifs': H_RESP, 'dur_resp': H_RESP, 'dur_cts': H_RESP, 'mcs_response': H_RESP, 'ba_control': H_RESP,
    'access': H_BACKOFF, 'edca': '', 'nav_txop': H_DURQ, 'ampdu_dur': H_DURQ, 'holder_gap': H_TXOP,
    'resp_seq': H_RESP, 'nav_rx': H_NAV, 'timestamp': H_BIC,
    # мост
    'aifs': H_BACKOFF, 'slot': H_BACKOFF, 'sifs': H_RESP, 'Ack': H_RESP, 'BlockAck': H_RESP, 'DMG CTS': H_RESP,
    'RTS': H_DURQ, 'A-MPDU': H_DURQ, 'Data': H_DURQ, 'nav': H_NAV, 'txnav': H_DURQ, 'txop_limit': H_DURQ,
    'ba_window': H_AMPDU, 'ampdu_limits': H_AMPDU,
}


RULE_INTERP = {
    'supp_channels': 'ref/PLAN.md №41: Supported Channels DMG STA обязателен по 11.8.2.2 (против условия табл. 9-34)',
    'dur_cts': 'ref/PLAN.md №19: Duration DMG CTS — по 9.3.1.13 (номинальный SIFS), не по 9.2.5.7',
    'brp_role': 'ref/PLAN.md №20: Initiator в BRP после SLS — по роли инициатора SLS',
    'abft_slot_start': 'ref/PLAN.md №4: допуски слота A-BFT', 'ssw_start': 'ref/PLAN.md №4: допуски слота A-BFT',
    'abft_ss_end': 'ref/PLAN.md №4: допуски слота A-BFT',
}


def viol_hyp(side, v):
    if not side.emulator:
        return ''
    e = side.evs[v.idx] if v.idx is not None and 0 <= v.idx < len(side.evs) else None
    if e is not None and e.kind == 'SSW' and side.phase[e.i] == 'A-BFT' and v.rule in ABFT_RULES and \
            ('Duration' in v.msg or 'ssw_dur' in v.msg or 'ssw_start' in v.msg or 'слот' in v.msg or v.rule != 'abft'):
        return H_ABFT
    if e is not None:
        h = ev_hyp(side, e)
        if h:
            return h
        if v.judge == 'мост/duration' or v.rule.startswith('dur') or 'Duration' in v.msg:
            h = ev_dur_hyp(side, e)
            if h:
                return h
    if e is not None and e.kind == 'CF-End' and v.rule in ('aifs', 'cf_end', 'cf_end_dur', 'cf_end_rules', 'access'):
        # последний свой кадр перед CF-End (кроме CF-End) — кадр управления из очереди MAC с Duration по H-DURQ
        own = next((q for q in reversed(side.evs[max(0, e.i - 30):e.i]) if q.src == e.src and q.kind != 'CF-End'),
                   None)
        if own is not None and e.t - own.te < 200 and ev_dur_hyp(side, own) == H_DURQ and \
                own.kind not in ('RTS', 'A-MPDU', 'Data'):
            return H_DURQ_CF
    h = RULE_HYP.get(v.rule, '')
    if h == H_DURQ and e is not None and not ev_dur_hyp(side, e):
        return ''
    if h == H_BACKOFF and e is not None and not (e.what.startswith('queue') or e.kind == 'RTS'):
        return ''                                       # доступ кадра uc (FIFO) — не арбитр очередей MAC
    return h


# =====================================================================================================================
# аспекты
# =====================================================================================================================
def _norm_msg(m):
    return AJ._msg_kind(m)


def cmp_judges(A, B):
    """Правила судей, нарушенные хотя бы у одной стороны. Группа — (судья, правило, вид сообщения, допущение)."""
    out = []
    ga, gb = defaultdict(list), defaultdict(list)
    for v in A.viol:
        ga[(v.judge, v.rule, _norm_msg(v.msg))].append(v)
    for v in B.viol:
        gb[(v.judge, v.rule, _norm_msg(v.msg))].append(v)
    rules_b = defaultdict(int)
    for (j, r, _), vs in gb.items():
        rules_b[(j, r)] += len(vs)
    for key in sorted(set(ga) | set(gb), key=str):
        va, vb = ga.get(key, []), gb.get(key, [])
        j, r, mk = key
        hyps = Counter(viol_hyp(A, v) for v in va)
        hyp = hyps.most_common(1)[0][0] if hyps else ''
        interp = 'вердикт судьи «model» — зависит от трактовки (ref/PLAN.md)' if va and all(
            v.verdict == 'model' for v in va) else RULE_INTERP.get(r, '')
        if vb and all(v.verdict == 'model' for v in vb):
            interp = interp or 'вердикт судьи «model» у ядра — зависит от трактовки (ref/PLAN.md)'
            cls = INTERP
        elif r == 'busy' and all(v.verdict == 'hidden' for v in va + vb):
            interp = ('судья моста считает, что все узлы слышат все кадры; передатчик кадра не принимал занявший '
                      'среду кадр (направленная развёртка — скрытая станция, rx_nodes журнала): CCA у него свободна '
                      '(10.3.2.1)')
            cls = INTERP
        else:
            cls = classify(bool(va), bool(vb), hyp, interp)
        ex = [(A.label, A.evs[v.idx].where() if 0 <= v.idx < len(A.evs) else '-', v.msg) for v in va[:3]]
        ex += [(B.label, B.evs[v.idx].where() if 0 <= v.idx < len(B.evs) else '-', v.msg) for v in vb[:3]]
        out.append(Diff('судьи', f'{j}/{r}: {mk}', len(va), len(vb), cls, _clause_of(r, va + vb),
                        f'нарушений: {A.label} {len(va)}, {B.label} {len(vb)}' +
                        (f'; трактовка: {interp}' if interp and cls == INTERP else ''), hyp, ex))
    return out


def _hidden(side, v):
    """Нарушение «начат во время чужого кадра»: передатчик кадра v не принимал ни один кадр, идущий в момент начала."""
    if not 0 <= v.idx < len(side.evs):
        return False
    e = side.evs[v.idx]
    over = [q for q in side.evs[max(0, e.i - 20):e.i] if q.t < e.t < q.te and q.src != e.src]
    return bool(over) and all(e.tx_node not in q.rx_nodes for q in over)


def _clause_of(rule, vs):
    import re
    for v in vs:
        m = re.findall(r'\b(\d+\.\d+(?:\.\d+)+)', v.msg)
        if m:
            return m[-1]
    return ''


def cmp_exchanges(A, B):
    out = []
    ka, kb = defaultdict(list), defaultdict(list)
    for x in A.exchanges:
        ka[x.kind].append(x)
    for x in B.exchanges:
        kb[x.kind].append(x)
    for kind in sorted(set(ka) | set(kb)):
        xa, xb = ka.get(kind, []), kb.get(kind, [])
        sa, sb = Counter(x.sig for x in xa), Counter(x.sig for x in xb)
        if not xa or not xb:
            xs, side = (xa, A) if xa else (xb, B)
            bad_a = _x_bad(A, xa)
            bad_b = _x_bad(B, xb)
            out.append(Diff('обмены', f'вид «{kind}» только у {side.label}', dict(sa), dict(sb),
                            classify(bad_a, bad_b, _x_hyp(A, xa), ''), '',
                            'обмены этого вида есть только у одной стороны' + _bad_note(A, xa, B, xb),
                            _x_hyp(A, xa), [(side.label, _xwhere(x), x.sig) for x in xs[:2]]))
            continue
        only_a = [s for s in sa if s not in sb]
        only_b = [s for s in sb if s not in sa]
        if only_a or only_b:
            xa1 = [x for x in xa if x.sig in only_a]
            xb1 = [x for x in xb if x.sig in only_b]
            ta = {token(B, e) for x in xb for e in x.evs}      # кадры, которые есть и у другой стороны, — не довод
            tb = {token(A, e) for x in xa for e in x.evs}
            bad_a, bad_b = _x_bad(A, xa1, ta), _x_bad(B, xb1, tb)
            hyp = _x_hyp(A, xa1, ta)
            out.append(Diff('обмены', f'«{kind}»: сигнатуры различаются', {s: sa[s] for s in only_a},
                            {s: sb[s] for s in only_b}, classify(bad_a, bad_b, hyp, ''), '',
                            'сигнатура — кто → кому и кадры обмена, повторы свёрнуты; доводы — нарушения судей на '
                            'кадрах, которых у другой стороны в обменах этого вида нет' +
                            _bad_note(A, xa1, B, xb1, ta, tb),
                            hyp, [(A.label, _xwhere(x), x.sig) for x in xa1[:2]] +
                            [(B.label, _xwhere(x), x.sig) for x in xb1[:2]]))
    # порядок фаз каждой станции
    for sta in sorted({x.pair for x in A.exchanges + B.exchanges if x.pair}):
        qa, qb = _phases(A, sta), _phases(B, sta)
        if qa != qb:
            sm = difflib.SequenceMatcher(a=qa, b=qb, autojunk=False)
            ops = [f'{op}: {A.label} {qa[i1:i2]} / {B.label} {qb[j1:j2]}' for op, i1, i2, j1, j2 in sm.get_opcodes()
                   if op != 'equal']
            out.append(Diff('обмены', f'порядок фаз {sta}', qa, qb, UNDEF, '',  # noqa: E501
                            'порядок первых появлений видов обменов станции; ' + '; '.join(ops[:6])))
    return out


def _phases(side, sta):
    """Порядок первых появлений видов обменов станции (фазы: BF → ассоциация → ADDBA → данные); повторы и чередование
    независимых потоков (ADDBA второго направления против первого TXOP) порядок фаз не меняют; BRP (setup после A-BFT,
    уточнение после SLS) идёт независимо от ассоциации — в аспекте «обмены»."""
    q = []
    for x in side.exchanges:
        if x.pair == sta and x.kind not in ('CF-End', 'BRP') and x.kind not in q:
            q.append(x.kind)
    return q


def _xwhere(x):
    return x.evs[0].where()


EXCH_RULES = ('ifs_sifs', 'holder_gap', 'access', 'responder_tx', 'resp_seq', 'nav_txop', 'cbap_end', 'sls', 'rd',
              'cf_end_rules', 'cf_end_lost', 'brp', 'brp_role', 'abft', 'assoc_state', 'aifs', 'slot', 'busy', 'nav',
              'txnav', 'timeout', 'txop_limit', 'cbap_end', 'cf_end', 'cf_end_dur', 'sifs', 'cts_nav')


def _x_evs(side, xs, other_toks=None):
    """Кадры обменов, которых нет в сигнатурах другой стороны (other_toks — множество токенов другой стороны)."""
    for x in xs:
        for e in x.evs:
            if other_toks is None or token(side, e) not in other_toks:
                yield e


def _x_bad(side, xs, other_toks=None):
    """Нарушения судей (правила обмена и времени) на отличающихся кадрах обменов — доказательство «не по стандарту»."""
    return sorted({f'{v.judge}/{v.rule}' for e in _x_evs(side, xs, other_toks) for v in side.viol_by_ev.get(e.i, ())
                   if v.rule in EXCH_RULES and v.verdict not in ('hidden', 'model')})


def _x_hyp(side, xs, other_toks=None):
    """Допущение модели MAC, если им объясняются все нарушения на отличающихся кадрах (иначе пусто)."""
    if not side.emulator:
        return ''
    hs, n = Counter(), 0
    for e in _x_evs(side, xs, other_toks):
        for v in side.viol_by_ev.get(e.i, ()):
            if v.rule in EXCH_RULES and v.verdict not in ('hidden', 'model'):
                n += 1
                h = viol_hyp(side, v)
                if h:
                    hs[h] += 1
    return hs.most_common(1)[0][0] if hs and sum(hs.values()) == n else ''


def _bad_note(A, xa, B, xb, ta=None, tb=None):
    ba, bb = _x_bad(A, xa, ta), _x_bad(B, xb, tb)
    s = ''
    if ba:
        s += f'; судьи у {A.label}: {", ".join(ba[:6])}'
    if bb:
        s += f'; судьи у {B.label}: {", ".join(bb[:6])}'
    return s


# ---------------------------------------------------------------------------------------------------------- поля
def field_profile(side):
    """{(вид, поле): Counter(значение)} и пример события на каждое (ключ, значение)."""
    prof, ex = defaultdict(Counter), {}

    def put(kind, name, val, e):
        prof[(kind, name)][val] += 1
        ex.setdefault((kind, name, val), e)

    for e in side.evs:
        k = e.kind
        r = side.rc
        if k == 'DMG Beacon' and e.p is not None:
            for n, v in e.p.bic._asdict().items():
                if n not in ('abft_count', 'next_abft'):       # Next A-BFT меняется по BI — «параметры BSS»
                    put(k, f'BIC.{n}', v, e)
            for n, v in e.p.params._asdict().items():
                put(k, f'DMG Parameters.{n}', v, e)
            put(k, 'Beacon Interval', e.p.beacon_interval, e)
            put(k, 'элементы', tuple(el[0] for el in e.p.elements), e)
            put(k, 'MCS', e.mcs, e)
            put(k, 'Timestamp − TSF начала символа данных (мкс)',
                int(round(e.p.timestamp - (e.t + side.tsf_shift + data_symbol_offset(e.mcs)))), e)
            continue
        if k in AP.MGMT_NAME.values() or k in (E.ASSOC_REQ, E.ASSOC_RESP, E.PROBE_REQ, E.PROBE_RESP):
            kk = e.action or k
            put(kk, 'адреса A1/A2/A3', (r(F.mac_str(e.raw[4:10])), r(F.mac_str(e.raw[10:16])),
                                        r(F.mac_str(e.raw[16:22])) if len(e.raw) >= 22 else None), e)
            put(kk, 'MCS', e.mcs, e)
            put(kk, 'Retry', e.fc.retry, e)
            if k in (E.ASSOC_REQ, E.ASSOC_RESP, E.PROBE_RESP, E.PROBE_REQ):
                try:
                    fx, els = E.parse_body(k, e.raw[24:])
                except (ValueError, NotImplementedError):
                    put(k, 'тело', 'не разбирается', e)
                    continue
                put(k, 'элементы', tuple(el.eid for el in els), e)
                for n, v in fx.items():
                    if n in ('timestamp',):
                        continue
                    if n == 'aid':
                        v = 'AID 1…254' if 1 <= v <= 254 else v
                    put(k, n, _hashable(v), e)
                for el in els:
                    if el.eid == E.EID_DMG_CAPABILITIES:
                        c = E.parse_dmg_capabilities(el.info)
                        for n, v in c.sta_cap.items():
                            if not n.startswith('_'):
                                put(k, f'DMG Capabilities.{n}', v, e)
                        for n, v in c.ap_pcp_cap.items():
                            if not n.startswith('_'):
                                put(k, f'DMG Capabilities.AP.{n}', v, e)
                        put(k, 'DMG Capabilities.STA Address = TA', c.sta_address == e.src, e)
                        put(k, 'DMG Capabilities.max A-MSDU', (c.max_basic_amsdu, c.max_short_amsdu), e)
            if e.action == 'ADDBA Request':
                try:
                    q = BA.parse_addba_req(e.raw[24:])
                    put(kk, 'параметры', (q.params.amsdu, q.params.policy, q.params.tid), e)
                    put(kk, 'Buffer Size', q.params.buffer_size, e)
                    put(kk, 'Timeout', q.timeout, e)
                except ValueError as x:
                    put(kk, 'разбор', str(x), e)
            if e.action == 'ADDBA Response':
                try:
                    q = BA.parse_addba_resp(e.raw[24:])
                    put(kk, 'параметры', (q.params.amsdu, q.params.policy, q.params.tid), e)
                    put(kk, 'Status', q.status, e)
                    put(kk, 'Timeout', q.timeout, e)
                except ValueError as x:
                    put(kk, 'разбор', str(x), e)
            continue
        if k == 'BRP' and len(e.raw) >= 38:
            from .. import brp as BRP
            try:
                br = BRP.BeamRefinement.parse(e.raw[31:38])
                put(k, f'{r(e.src)}>{r(e.dst)} Initiator/CapReq/TXSS-FBCK-REQ',
                    (br.initiator, br.cap_req, br.txss_fbck_req), e)
            except AssertionError:
                put(k, 'разбор', 'не разбирается', e)
            continue
        if k in ('A-MPDU', 'Data', 'QoS Null'):
            for m in e.mpdus:
                fc = int.from_bytes(m[:2], 'little')
                put(k, f'{r(e.src)}>{r(e.dst)} To/From DS', ((fc >> 8) & 1, (fc >> 9) & 1), e)
                put(k, f'{r(e.src)}>{r(e.dst)} адреса A1/A2/A3', (r(F.mac_str(m[4:10])), r(F.mac_str(m[10:16])),
                                                                  r(F.mac_str(m[16:22]))), e)
                if len(m) >= 26 and fc & 0x80:
                    put(k, 'Ack Policy', (m[24] >> 5) & 3, e)
                    put(k, 'TID', m[24] & 15, e)
                put(k, 'Retry', (fc >> 11) & 1, e)
            put(k, 'MCS > 0 (SC)', e.mcs > 0, e)
            continue
        if k in ('SSW', 'SSW-Feedback', 'SSW-Ack') and e.p is not None:
            ph = side.phase[e.i]
            if k == 'SSW':
                d = 'ISS' if e.p.ssw.direction == 0 else 'RSS'
                put(k, f'{ph} {d} {r(e.src)}>{r(e.dst)}: Antenna ID', e.p.ssw.antenna_id, e)
                if isinstance(e.p.fb, F.SswFbIss):
                    put(k, f'{ph} {d}: Total Sectors in ISS (поле)', e.p.fb.total_sectors, e)
                    put(k, f'{ph} {d}: Poll Required', e.p.fb.poll_required, e)
            else:
                put(k, f'{ph} {r(e.src)}>{r(e.dst)}: BRP Request (L-RX, TX-TRN-REQ, MID-REQ, BC-REQ)',
                    (e.p.brp.l_rx, e.p.brp.tx_trn_req, e.p.brp.mid_req, e.p.brp.bc_req), e)
            continue
        if k == 'BlockAck' and len(e.raw) >= 18:
            put(k, 'BA Control', int.from_bytes(e.raw[16:18], 'little') & 0x0fff, e)
            put(k, 'MCS', e.mcs, e)
            continue
        if k in ('RTS', 'DMG CTS', 'Ack', 'CF-End'):
            put(k, 'MCS', e.mcs, e)
            if k == 'CF-End':
                put(k, f'{r(e.src)}> RA', r(F.mac_str(e.raw[4:10])), e)
    # RA CF-End держателя — партнёр обмена (9.3.1.6) и число MPDU в A-MPDU против окна BA соглашения (10.25.2)
    win = {}
    for e in side.evs:
        if e.action == 'ADDBA Response':
            try:
                q = BA.parse_addba_resp(e.raw[24:])
                win[(e.dst, e.src)] = q.params.buffer_size or 64
            except ValueError:
                pass
        elif e.kind == 'A-MPDU' and (e.src, e.dst) in win:
            put('A-MPDU', 'MPDU в A-MPDU ≤ окна BA', len(e.mpdus) <= win[(e.src, e.dst)], e)
    for x in side.exchanges:
        peers = set()
        for e in x.evs:
            if e.kind == 'CF-End':
                if not peers:
                    continue
                ra = F.mac_str(e.raw[4:10])
                partner = ({p for p in peers if p != e.src})
                v = 'партнёр' if ra in partner else 'широковещательный' if ra == BCAST else 'другой узел'
                put('CF-End', 'RA = партнёр обмена', v, e)
                peers = set()
                continue
            peers |= {e.src, e.dst}
    return prof, ex


def _hashable(v):
    if isinstance(v, dict):
        return tuple(sorted((k, _hashable(x)) for k, x in v.items() if not str(k).startswith('_')))
    if isinstance(v, list):
        return tuple(_hashable(x) for x in v)
    return v


def _ok(v):
    return None


# Собственные проверки поля по стандарту (значение → сообщение о нарушении или None)
FIELD_STD = {
    'RA = партнёр обмена': lambda v: None if v in ('партнёр', 'широковещательный') else
    '9.3.1.6: RA CF-End DMG — адресат индивидуальных данных/управления обмена или широковещательный',
}
FIELD_CLAUSE = {'RA = партнёр обмена': '9.3.1.6', 'MPDU в A-MPDU ≤ окна BA': '10.25.2, 10.12.2',
                'Ack Policy': '9.2.4.5.4', 'BA Control': '9.3.1.8.1'}
# Правила судей, относящиеся к полю (префикс имени поля → правила); остальные нарушения на кадре полем не объясняются
FIELD_RULES = (
    ('элементы', ('supp_channels', 'mgmt_body', 'elements', 'parse') + tuple(E.BODY_FRAMES if hasattr(E, 'BODY_FRAMES')
                                                                           else ())),
    ('DMG Capabilities', ('mgmt_body', 'elements', 'capelems', 'opt_caps')),
    ('MCS', ('mcs_control', 'mcs_response')),
    ('BIC', ('beacon_fields', 'DMG Beacon', 'bi')),
    ('DMG Parameters', ('beacon_fields', 'DMG Beacon')),
    ('Ack Policy', ('ack_policy',)),
    ('BA Control', ('ba_control', 'ba_variant')),
    ('адреса', ('addrs', 'fc', 'assoc_state')),
    ('To/From DS', ('fc', 'addrs')),
    ('параметры', ('addba',)), ('Buffer Size', ('addba',)), ('Status', ('addba',)), ('Timeout', ('addba',)),
    ('Timestamp', ('timestamp',)),
)


def field_evidence(side, evs, kind, name):
    rules = ()
    for pre, rs in FIELD_RULES:
        if name.startswith(pre) or name.split(' ', 2)[-1].startswith(pre):
            rules = rs
            break
    sub = name.split('.', 1)[1] if '.' in name else ''
    out = set()
    for e in evs:
        for v in side.viol_by_ev.get(e.i, ()):
            if v.rule in rules and (not sub or sub in v.msg or v.rule not in ('mgmt_body', 'elements')):
                out.add(f'{v.judge}/{v.rule}')
    return sorted(out)


# Поля, где различие — допустимый выбор реализации (стандарт задаёт диапазон, не значение) → «неопределённо»;
# прочие различия классифицируются по судьям на кадрах со значением.
def cmp_fields(A, B):
    out = []
    pa, ea = field_profile(A)
    pb, eb = field_profile(B)
    for key in sorted(set(pa) | set(pb), key=str):
        va, vb = pa.get(key, Counter()), pb.get(key, Counter())
        if not va or not vb:
            continue                         # вид кадра есть только у одной стороны — аспект «обмены»/«счётчики»
        if set(va) == set(vb):
            continue
        kind, name = key
        oa = [v for v in va if v not in vb]
        ob = [v for v in vb if v not in va]
        evs_a = [ea[(kind, name, v)] for v in oa]
        evs_b = [eb[(kind, name, v)] for v in ob]
        bad_a = field_evidence(A, evs_a, kind, name) + [m for v in oa for m in [FIELD_STD.get(name, _ok)(v)] if m]
        bad_b = field_evidence(B, evs_b, kind, name) + [m for v in ob for m in [FIELD_STD.get(name, _ok)(v)] if m]
        hyp = ''
        if A.emulator:
            if any(e.by_mac for e in evs_a):
                hyp = H_RESP
            elif kind == 'DMG Beacon' and name.startswith('Timestamp'):
                hyp = H_BIC
            elif kind == 'CF-End' and 'RA' in name and all(e.dst == BCAST for e in evs_a):
                hyp = H_CFEND
            elif kind == 'A-MPDU' and name.startswith('MPDU'):
                hyp = H_AMPDU
        rules_a = {b.split('/')[-1] for b in bad_a if '/' in b}
        interp = '; '.join(sorted({RULE_INTERP[r] for r in rules_a if r in RULE_INTERP})) \
            if rules_a and all(r in RULE_INTERP for r in rules_a) and len(rules_a) == len(bad_a) else ''
        out.append(Diff('поля', f'{kind}: {name}', dict(va), dict(vb), classify(bool(bad_a), bool(bad_b), hyp, interp),
                        FIELD_CLAUSE.get(name, ''),
                        ('значения только у ' + A.label + f': {oa}; только у ' + B.label + f': {ob}') +
                        (f'; судьи на кадрах {A.label}: {bad_a}' if bad_a else '') +
                        (f'; судьи на кадрах {B.label}: {bad_b}' if bad_b else '') +
                        (f'; трактовка: {interp}' if interp else ''), hyp,
                        [(A.label, e.where(), '') for e in evs_a[:2]] + [(B.label, e.where(), '') for e in evs_b[:2]]))
    return out


# ------------------------------------------------------------------------------------------------------ Duration
def duration_profile(side):
    """Смысл Duration: внутри обмена — сдвиг конца NAV относительно предыдущего кадра (ответ сохраняет NAV держателя:
    9.2.5.7, 9.3.1.13 — сдвиг = промежуток − SIFS с округлением вверх до 1 мкс); первый кадр обмена — значение
    (кадры управления: SIFS + TXTIME(Ack) при TXOP Limit 0 у AC_VO; RTS/данные — по лимиту TXOP)."""
    prof, ex = defaultdict(list), {}
    for x in side.exchanges:
        for i, e in enumerate(x.evs):
            t = token(side, e)
            if i == 0:
                key = ('первый кадр обмена', t)
                val = Fr(e.dur)
            else:
                p = x.evs[i - 1]
                if not AJ.is_response_pair(p, e):
                    continue                   # Duration прочих кадров обмена — по своим формулам (судьи)
                key = ('сдвиг конца NAV ответом', f'{token(side, p)} → {t}')
                val = (e.te + e.dur) - (p.te + p.dur)
            prof[key].append(val)
            ex.setdefault(key, []).append(e)
    return prof, ex


def cmp_duration(A, B):
    out = []
    pa, ea = duration_profile(A)
    pb, eb = duration_profile(B)
    for key in sorted(set(pa) & set(pb), key=str):
        a, b = pa[key], pb[key]
        sa, sb = _stat(a), _stat(b)
        if abs(sa['median'] - sb['median']) <= 1 and abs(sa['min'] - sb['min']) <= 1 and \
                abs(sa['max'] - sb['max']) <= 1:
            continue
        evs_a, evs_b = ea[key], eb[key]
        bad_a = sorted({f'{v.judge}/{v.rule}' for e in evs_a for v in A.viol_by_ev.get(e.i, ())
                        if 'dur' in v.rule or 'duration' in v.judge or 'Duration' in v.msg})
        bad_b = sorted({f'{v.judge}/{v.rule}' for e in evs_b for v in B.viol_by_ev.get(e.i, ())
                        if 'dur' in v.rule or 'duration' in v.judge or 'Duration' in v.msg})
        hyps = Counter(ev_dur_hyp(A, e) for e in evs_a)
        hyp = hyps.most_common(1)[0][0] if hyps else ''
        out.append(Diff('Duration', f'{key[0]}: {key[1]}', sa, sb, classify(bool(bad_a), bool(bad_b), hyp, ''),
                        '9.2.5', 'мкс: min/медиана/max' + (f'; судьи у {A.label}: {bad_a}' if bad_a else '') +
                        (f'; судьи у {B.label}: {bad_b}' if bad_b else ''), hyp,
                        [(A.label, evs_a[0].where(), ''), (B.label, evs_b[0].where(), '')]))
    return out


def _stat(v):
    v = sorted(v)
    return dict(n=len(v), min=v[0], median=v[len(v) // 2], max=v[-1])


# ----------------------------------------------------------------------------------------------------- промежутки
def nominal_gap(side, p, e):
    """Номинал промежутка p → e внутри обмена (10.3.2.3): (имя, мин, макс, пункт, кто строит у эмулятора) или None."""
    kp, ke = p.kind, e.kind
    if AJ.is_response_pair(p, e) or (kp in ('A-MPDU', 'Data') and ke == 'BlockAck' and e.dst == p.src):
        return 'SIFS (ответ)', SIFS, SIFS + SIFS_TOL, '10.3.2.3.3', H_RESP
    if kp == 'SSW' and ke == 'SSW' and p.src == e.src and p.p is not None and e.p is not None and \
            p.p.ssw.direction == e.p.ssw.direction:
        return 'SBIFS (развёртка)', SBIFS, SBIFS_MAX, '10.3.2.3.8', ''
    if kp in ('SSW', 'SSW-Feedback') and ke in ('SSW', 'SSW-Feedback', 'SSW-Ack') and p.src != e.src:
        return 'MBIFS (фаза SLS)', MBIFS, MBIFS + MBIFS_TOL, '10.42.2.2, 10.3.2.3.10', ''
    if kp == 'DMG CTS' and ke in ('A-MPDU', 'Data') and e.src == p.dst:
        return 'SIFS (данные после DMG CTS)', SIFS, SIFS + SIFS_TOL, '10.3.2.9, 10.23.2.8', H_TXOP
    if kp in ('BlockAck', 'Ack') and ke in ('A-MPDU', 'Data', 'CF-End') and e.src == p.dst:
        return 'SIFS…PIFS (продолжение TXOP)', SIFS, SIFS + aSlotTime + SIFS_TOL, '10.23.2.8', H_TXOP
    if kp == 'BRP' or ke == 'BRP':
        return 'SIFS…BRPIFS (BRP)', SIFS, BRPIFS_MAX, '10.3.2.3.9, 10.42.3.2', ''
    return None


def gap_profile(side):
    prof, ex = defaultdict(list), defaultdict(list)
    for x in side.exchanges:
        for p, e in zip(x.evs, x.evs[1:]):
            key = f'{token(side, p)} → {token(side, e)}'
            prof[key].append(e.t - p.te)
            ex[key].append((p, e))
    return prof, ex


def cmp_gaps(A, B):
    out = []
    pa, ea = gap_profile(A)
    pb, eb = gap_profile(B)
    for key in sorted(set(pa) | set(pb), key=str):
        a, b = pa.get(key), pb.get(key)
        pairs = (ea.get(key) or eb.get(key))
        p, e = pairs[0]
        nom = nominal_gap(A if ea.get(key) else B, p, e)
        sa, sb = (_stat(a) if a else None), (_stat(b) if b else None)
        if nom is None:
            if a and b and abs(sa['median'] - sb['median']) > 1:
                out.append(Diff('промежутки', key, sa, sb, UNDEF, '', 'мкс; номинала стандарта нет (не ответ, не '
                                'SLS/BRP) — различие медиан > 1 мкс',
                                examples=[(A.label, ea[key][0][1].where(), ''), (B.label, eb[key][0][1].where(), '')]))
            continue
        name, lo, hi, clause, h = nom
        out_a = [g for g in (a or ()) if not lo <= g <= hi]
        out_b = [g for g in (b or ()) if not lo <= g <= hi]
        if not out_a and not out_b:
            continue
        hyp = h if (A.emulator and out_a) else ''
        exa = [(A.label, ea[key][i][1].where(), f'{float(g):.3f} мкс') for i, g in enumerate(a or ())
               if not lo <= g <= hi][:2]
        exb = [(B.label, eb[key][i][1].where(), f'{float(g):.3f} мкс') for i, g in enumerate(b or ())
               if not lo <= g <= hi][:2]
        note = f'номинал {name} [{float(lo):.2f}, {float(hi):.2f}] мкс; вне номинала: {A.label} {len(out_a)}/' \
               f'{len(a or ())}, {B.label} {len(out_b)}/{len(b or ())}'
        if A.emulator and out_a and not h:
            note += '; момент передачи uc в эмуляторе зависит от H-ORIGIN/H-ORIGIN-RX (machw)'
        out.append(Diff('промежутки', f'{key} ({name})', sa, sb, classify(bool(out_a), bool(out_b), hyp, ''), clause,
                        note, hyp, exa + exb))
    return out


# --------------------------------------------------------------------------------------------------------- доступ
ACCESS_WINDOW = 15 * aSlotTime + SIFS_TOL   # отсрочка с CWmin = 15 (табл. 9-155) — дальше не сравнивается
ACCESS_RULES = ('aifs', 'slot', 'busy', 'nav', 'txnav', 'access', 'edca', 'nav_rx', 'nav_txop', 'cbap_end')


def access_profile(side):
    """Начало обмена в CBAP: остаток r = промежуток от конца последнего кадра в эфире − AIFS[AC] (кадр управления и
    BF — AC_VO, данные/RTS — AC_BE, 10.2.3.2; AIFSN — EDCA Parameter Set стороны). По 10.23.2.4 при свободных NAV/TXNAV
    r = k·aSlotTime ≥ 0; опорная точка с NAV — у судей (cbap, air_judge access), здесь — только сравнение сторон.
    Первый обмен после BTI/A-BFT пропускается (опорная точка — начало CBAP)."""
    e_vo, e_be = _edca(side)
    prof, ex = defaultdict(list), defaultdict(list)
    for x in side.exchanges:
        e = x.evs[0]
        prev = [q for q in side.evs[max(0, e.i - 40):e.i] if q.te <= e.t]
        if not prev:
            continue
        p = max(prev, key=lambda q: q.te)
        if side.phase[p.i] != 'DTI':
            continue
        ac = 'AC_VO' if (e.raw[0] >> 2) & 3 == 0 or e.kind in ('SSW', 'SSW-Feedback') else 'AC_BE'
        r = e.t - p.te - aifs(e_vo if ac == 'AC_VO' else e_be)
        if r > ACCESS_WINDOW:
            continue                           # кадр пришёл в очередь позже (хост, таймер) — отсчёт не от занятости
        prof[(ac, token(side, e))].append(r)
        ex[(ac, token(side, e))].append(e)
    return prof, ex


def _edca(side):
    edca, _ = AJ.edca_from(side.evs, side.ap)
    if edca:
        return edca.get('AC_VO', {}).get('aifsn', 2), edca.get('AC_BE', {}).get('aifsn', 3)
    return 2, 3


def _phase5(r):
    """Остаток по модулю aSlotTime, округлённый до 0,5 мкс (−0 → 0)."""
    k = r - (r // aSlotTime) * aSlotTime
    v = round(float(k) * 2) / 2
    return 0.0 if v in (5.0, -0.0) else v


def cmp_access(A, B):
    out = []
    pa, ea = access_profile(A)
    pb, eb = access_profile(B)
    for key in sorted(set(pa) & set(pb), key=str):
        a, b = pa[key], pb[key]
        fa, fb = Counter(_phase5(r) for r in a), Counter(_phase5(r) for r in b)
        early_a, early_b = min(a) < -SIFS_TOL, min(b) < -SIFS_TOL
        if early_a == early_b:
            continue                    # отсрочка случайна: сравнимо только «раньше AIFS»; прочее — судьи доступа
        evs_a, evs_b = ea[key], eb[key]
        bad_a = sorted({f'{v.judge}/{v.rule}' for e in evs_a for v in A.viol_by_ev.get(e.i, ())
                        if v.rule in ACCESS_RULES})
        bad_b = sorted({f'{v.judge}/{v.rule}' for e in evs_b for v in B.viol_by_ev.get(e.i, ())
                        if v.rule in ACCESS_RULES})
        hyp = ''
        if A.emulator and all(e.what.startswith('queue') or e.kind == 'RTS' for e in evs_a):
            hyp = H_BACKOFF
        note = (f'остаток = промежуток от конца занятости − AIFS[{key[0]}]; min: {A.label} {float(min(a)):.2f}, '
                f'{B.label} {float(min(b)):.2f} мкс; остаток mod aSlotTime: {A.label} {dict(fa)}, {B.label} {dict(fb)}')
        if bad_a:
            note += f'; судьи у {A.label}: {bad_a}'
        if bad_b:
            note += f'; судьи у {B.label}: {bad_b}'
        if A.emulator and not hyp:
            note += '; кадр uc (FIFO) — доступ решает uc, не арбитр очередей MAC'
        bad_a = bad_a or (['раньше AIFS'] if early_a else [])
        bad_b = bad_b or (['раньше AIFS'] if early_b else [])
        out.append(Diff('доступ', f'{key[0]}: {key[1]}', _stat(a), _stat(b),
                        classify(bool(bad_a), bool(bad_b), hyp, ''),
                        '10.23.2.4', note, hyp, [(A.label, evs_a[0].where(), ''), (B.label, evs_b[0].where(), '')]))
    return out


# ---------------------------------------------------------------------------------------------------------- роли
def cmp_roles(A, B):
    out = []
    ra, rb = defaultdict(Counter), defaultdict(Counter)
    for x in A.exchanges:
        ra[x.kind][x.init] += 1
    for x in B.exchanges:
        rb[x.kind][x.init] += 1
    for kind in sorted(set(ra) & set(rb)):
        if set(ra[kind]) != set(rb[kind]):
            out.append(Diff('роли', f'инициатор «{kind}»', dict(ra[kind]), dict(rb[kind]), UNDEF, '',
                            'кто передаёт первый кадр обмена'))
    return out


# ------------------------------------------------------------------------------------------------------ счётчики
def counters(side):
    c = Counter()
    for e in side.evs:
        c[f'кадров: {e.kind}' if e.kind not in ('Action', 'Action No Ack') else f'кадров: {e.action}'] += 1
        if e.kind in ('A-MPDU', 'Data') or (e.raw[0] >> 2) & 3 == 0:
            c['повторов (Retry = 1)'] += sum((int.from_bytes(m[:2], 'little') >> 11) & 1 for m in e.mpdus)
    for x in side.exchanges:
        c[f'обменов: {x.kind}'] += 1
    sls = [x for x in side.exchanges if x.kind == 'SLS']
    c['SLS в DTI'] = len(sls)
    c['SLS в DTI без SSW-Ack'] = sum(1 for x in sls if not any(e.kind == 'SSW-Ack' for e in x.evs))
    bti = side.sched.bti
    c['маяков в BTI (макс.)'] = max((len(v[2]) for v in bti.values()), default=0)
    c['BI с маяками'] = len(bti)
    c['MPDU в A-MPDU (макс.)'] = max((len(e.mpdus) for e in side.evs if e.kind == 'A-MPDU'), default=0)
    sweeps = Counter()
    for x in sls:
        for e in x.evs:
            if e.kind == 'SSW':
                sweeps[(x.t, e.src, e.p.ssw.direction if e.p else None)] += 1
    c['SSW в развёртке DTI (макс.)'] = max(sweeps.values(), default=0)
    abft = [e for e, ph in zip(side.evs, side.phase) if ph == 'A-BFT']
    c['кадров в A-BFT'] = len(abft)
    c['RTS без DMG CTS'] = sum(1 for x in side.exchanges for i, e in enumerate(x.evs)
                               if e.kind == 'RTS' and not (i + 1 < len(x.evs) and x.evs[i + 1].kind == 'DMG CTS'))
    return c


COUNTER_STD = {
    # счётчик → (функция «по стандарту ли значение» при идеальном канале, пункт); None — номинала нет
    'RTS без DMG CTS': (lambda v, n_sta: v == 0 or n_sta > 1, '10.3.2.9'),
    'повторов (Retry = 1)': (lambda v, n_sta: v == 0 or n_sta > 1, '10.23.2.12'),
}


def cmp_counters(A, B, n_sta=1):
    out = []
    ca, cb = counters(A), counters(B)
    for k in sorted(set(ca) | set(cb)):
        va, vb = ca.get(k, 0), cb.get(k, 0)
        if va == vb:
            continue
        std = COUNTER_STD.get(k)
        a_bad = std is not None and not std[0](va, n_sta)
        b_bad = std is not None and not std[0](vb, n_sta)
        out.append(Diff('счётчики', k, va, vb, classify(a_bad, b_bad, '', ''), std[1] if std else '',
                        'идеальный канал: потерь нет' if std else 'число зависит от длительности прогона и выбора '
                        'реализации — справочно'))
    return out


# ------------------------------------------------------------------------------------------------- параметры BSS
def bss_params(side):
    out = {}
    bs = [e for e in side.evs if e.kind == 'DMG Beacon' and e.src == side.ap and e.p is not None]
    if bs:
        b = bs[0].p
        out['Beacon Interval (TU)'] = b.beacon_interval
        out['секторов в BTI'] = max((len(v[2]) for v in side.sched.bti.values()), default=0)
        out['A-BFT: слотов × FSS'] = (b.bic.abft_length + 1, b.bic.fss + 1)
        out['A-BFT: N BIs A-BFT'] = b.bic.n_bis_abft
        out['A-BFT: Next A-BFT по BI'] = tuple(sorted({e.p.bic.next_abft for e in bs}))
        out['ATI Present'] = b.bic.ati_present
        out['DMG Parameters (BSS Type, CBAP Only, CBAP Source)'] = (b.params.bss_type, b.params.cbap_only,
                                                                    b.params.cbap_source)
    edca, src = AJ.edca_from(side.evs, side.ap)
    if edca:
        for ac in ('AC_BE', 'AC_BK', 'AC_VI', 'AC_VO'):
            d = edca.get(ac)
            if d:
                out[f'EDCA {ac} (AIFSN, ECWmin, ECWmax, TXOP мкс)'] = (d['aifsn'], d['ecwmin'], d['ecwmax'],
                                                                       d['txop_us'])
    iss = Counter()
    for x in side.exchanges:
        for e in x.evs:
            if e.kind == 'SSW' and e.p is not None and e.p.ssw.direction == 0:
                iss[(x.t, e.src)] += 1
    if iss:
        out['секторов в ISS станции/точки (макс.)'] = max(iss.values())
    return out


def cmp_bss(A, B):
    out = []
    pa, pb = bss_params(A), bss_params(B)
    for k in sorted(set(pa) | set(pb)):
        if pa.get(k) != pb.get(k):
            bad_a = [v for v in A.viol if v.rule == 'edca'] if k.startswith('EDCA') else []
            bad_b = [v for v in B.viol if v.rule == 'edca'] if k.startswith('EDCA') else []
            out.append(Diff('параметры BSS', k, pa.get(k), pb.get(k), classify(bool(bad_a), bool(bad_b), '', ''),
                            '', 'выбор точки/станции; сценарий задаёт его только ядру (diff_scenario.Scenario.limits)'))
    return out


# =====================================================================================================================
def compare(A, B, n_sta=1):
    """→ [Diff] по всем аспектам."""
    return (cmp_judges(A, B) + cmp_exchanges(A, B) + cmp_fields(A, B) + cmp_duration(A, B) + cmp_gaps(A, B) +
            cmp_access(A, B) + cmp_roles(A, B) + cmp_counters(A, B, n_sta) + cmp_bss(A, B))


def summary(diffs):
    by = Counter(d.cls for d in diffs)
    return {c: by.get(c, 0) for c in CLASSES}

