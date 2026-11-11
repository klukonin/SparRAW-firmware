# SPDX-License-Identifier: AGPL-3.0-or-later
"""Мост эмулятор → эталон (tests/ref), версия 2: журнал эфира cosim (air.Air.frames) → разобранные события модели и
судьи модели над ними (BI/A-BFT, SLS, поля, элементы, Duration, доступ CBAP).

    snap = snapshot(air)                # журнал эфира без объектов эмулятора (можно сохранить pickle)
    evs = events(snap, ap_mac)          # [Ev]: время — Fraction мкс по TSF точки, кадр разобран ref/fields, ref/elements
    v = judge_all(evs, ap_mac)          # [Finding(judge, rule, clause, msg, idx)]

Вид кадра — по Frame Control (802.11-2020 9.2.4.1.3, табл. 9-1; Control Frame Extension — табл. 9-2), тело кадра
управления — по табл. 9-31…9-42 (ref/elements), DMG Beacon и кадры Control Frame Extension — рис. 9-49…9-57, 9-76
(ref/fields). FCS в журнале эфира нет (MAC добавляет его сам, air.py) — разбор с with_fcs=False.

Время: такты 165 МГц эмулятора → мкс (Fraction). Ось — TSF точки доступа (11.1.3.3.1: «Time value zero of the TSF is
defined to be a TBTT»), сдвинутая так, чтобы TBTT модели MAC приходился на кратное BI: в эмуляторе первый TBTT задаёт
сценарий (first_tbtt_us), а не fw/uc, и TSF0 = 1 с — сетка TBTT не кратна BI (на стенде TBTT кратен 102 400 мкс,
machw H-BI1). Сдвиг — допущение моста, не проверка прошивки.

Что строит не прошивка, а модель MAC эмулятора (air.py, machw.py), — судьи это помечают (Ev.by_mac): Ack, DMG CTS,
BlockAck (ответы MAC), Duration кадров очередей и RTS (H-DURQ), TA/SSW-поле кадров FIFO (H-TAMAC), Timestamp/BIC
маяка (H-BIC)."""
import os
import sys
from collections import namedtuple
from fractions import Fraction as Fr

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))

from ref import abft as A                                         # noqa: E402
from ref import bi as BI                                          # noqa: E402
from ref import blockack as BA                                    # noqa: E402
from ref import cbap as C                                         # noqa: E402
from ref import duration as D                                     # noqa: E402
from ref import elements as E                                     # noqa: E402
from ref import fields as F                                       # noqa: E402
from ref import sls as S                                          # noqa: E402
from ref import timing as T                                       # noqa: E402

CLK = T.CLK_MHZ
BCAST = T.BCAST

# ---- Frame Control → вид (табл. 9-1, 9-2) ----
CFE_NAME = {'poll': 'Poll', 'spr': 'SPR', 'grant': 'Grant', 'dmg_cts': 'DMG CTS', 'dmg_dts': 'DMG DTS',
            'grant_ack': 'Grant Ack', 'ssw': 'SSW', 'ssw_fb': 'SSW-Feedback', 'ssw_ack': 'SSW-Ack'}
CFE_KEY = {v: k for k, v in CFE_NAME.items()}
CTL_NAME = {8: 'BlockAckReq', 9: 'BlockAck', 11: 'RTS', 12: 'CTS', 13: 'Ack', 14: 'CF-End'}    # табл. 9-1, тип 01
MGMT_NAME = {0: E.ASSOC_REQ, 1: E.ASSOC_RESP, 2: E.REASSOC_REQ, 3: E.REASSOC_RESP, 4: E.PROBE_REQ,
             5: E.PROBE_RESP, 6: 'Timing Advertisement', 8: 'Beacon', 9: 'ATIM', 10: E.DISASSOC, 11: E.AUTH,
             12: E.DEAUTH, 13: 'Action', 14: 'Action No Ack'}                                   # табл. 9-1, тип 00
BODY_FRAMES = (E.PROBE_REQ, E.PROBE_RESP, E.ASSOC_REQ, E.ASSOC_RESP, E.REASSOC_REQ, E.REASSOC_RESP, E.AUTH,
               E.DEAUTH, E.DISASSOC)
# Action (9.6): категория (табл. 9-51) и действие
CAT_BLOCK_ACK, CAT_UNPROT_DMG = 3, 20
ACTION_NAME = {(CAT_BLOCK_ACK, 0): 'ADDBA Request', (CAT_BLOCK_ACK, 1): 'ADDBA Response', (CAT_BLOCK_ACK, 2): 'DELBA',
               (CAT_UNPROT_DMG, 1): 'BRP'}                         # табл. 9-376 (Block Ack), табл. 9-486
# Длины MPDU без FCS у кадров управления (не Control Frame Extension), рис. 9-28 (Ack), 9-26 (RTS), 9-34 (CF-End),
# 9-35/9-41 (Compressed BAR/BA)
CTL_LEN = {'Ack': 10, 'RTS': 16, 'CF-End': 16, 'BlockAckReq': 20, 'BlockAck': 28}

Finding = namedtuple('Finding', 'judge rule clause msg idx')


def mac(b):
    return F.mac_str(bytes(b))


# =====================================================================================================================
# журнал эфира эмулятора → снимок
# =====================================================================================================================
def snapshot(air, t0_clk=0):
    """air.Air → dict: frames — кадры эфира (начало/конец в тактах, отправитель — MAC узла, байты MPDU без FCS,
    MPDU A-MPDU, Duration, MCS, описание MAC), nodes — MAC → TSF0/TBTT/BI модели MAC узла."""
    frames = []
    for f in air.frames:
        if f['start'] < t0_clk:
            continue
        frames.append(dict(start=f['start'], end=f['end'], src=bytes(f['src'].mac), frame=bytes(f['frame']),
                           mpdus=f['mpdus'], dur_us=f['dur_us'], mcs=f['mcs'], what=f['what'],
                           lost=[bytes(d.mac) for d, t in f.get('rx', ()) if t.get('lost')]))   # H-COLL: у кого потерян
    nodes = {bytes(n.mac): dict(tsf0_us=n.hw.tsf0_us, tbtt_us=n.hw.tbtt_us, bi_us=n.hw._bi_period_us())
             for n in air.nodes}
    return dict(frames=frames, nodes=nodes)


# =====================================================================================================================
# снимок → события
# =====================================================================================================================
class Ev:
    """Кадр на эфире. t/te — начало/конец PPDU, мкс (TSF точки, сетка TBTT кратна BI); src — TA (узел-передатчик),
    dst — A1/RA (у DMG Beacon — BCAST: в A1 BSSID, кадр широковещательный, 9.3.4.2); kind — вид по Frame Control;
    dur — Duration; mcs — 0 control, 1… SC; raw — MPDU без FCS; fc — FrameControl; p — разбор ref/fields (кадры
    Control Frame Extension, DMG Beacon) или (fixed, [Element]) ref/elements (тела 9.3.3), err — ошибка разбора;
    action — имя действия кадра Action; by_mac — кадр целиком собирает модель MAC эмулятора (ответы через SIFS)."""
    __slots__ = ('i', 't', 'te', 'src', 'dst', 'kind', 'dur', 'mcs', 'raw', 'fc', 'p', 'err', 'action', 'by_mac',
                 'what', 'mpdus', 'length')

    def __init__(self, **kw):
        for k in self.__slots__:
            setattr(self, k, kw.get(k))

    def __repr__(self):
        return f'#{self.i} {self.kind} {self.src}->{self.dst} @{float(self.t):.3f}'

    # для ref/bi.check_air_log, ref/cbap.check_air_log
    def info(self):
        if self.kind == 'DMG Beacon' and self.p is not None:
            return dict(sector=self.p.ssw.sector_id, cdown=self.p.ssw.cdown, antenna=self.p.ssw.antenna_id)
        if self.kind == 'SSW' and self.p is not None:
            return dict(sector=self.p.ssw.sector_id, cdown=self.p.ssw.cdown, antenna=self.p.ssw.antenna_id)
        return {}


def time_base(snap, ap_mac):
    """Сдвиг тактов модели → мкс TSF точки с сеткой TBTT, кратной BI (см. докстроку модуля)."""
    n = snap['nodes'][bytes(ap_mac)]
    phase = n['tbtt_us'] % n['bi_us']
    return Fr(n['tsf0_us'] - phase), n['bi_us']


def classify(raw, mpdus=None):
    """Frame Control → (FrameControl, вид, имя действия)."""
    fc = F.parse_fc(raw[:2])
    if F.fc_is_cfe(fc):
        k = F.CFE_KIND.get(fc.cfe)
        return fc, CFE_NAME.get(k, f'CFE {fc.cfe}'), None
    if fc.type == F.TYPE_EXT:
        return fc, 'DMG Beacon' if fc.subtype == F.SUBTYPE_DMG_BEACON else f'Extension {fc.subtype}', None
    if fc.type == F.TYPE_CTRL:
        return fc, CTL_NAME.get(fc.subtype, f'Control {fc.subtype}'), None
    if fc.type == F.TYPE_DATA:
        return fc, 'A-MPDU' if mpdus else 'Data', None
    name = MGMT_NAME.get(fc.subtype, f'Mgmt {fc.subtype}')
    act = None
    if name in ('Action', 'Action No Ack') and len(raw) >= 26:
        act = ACTION_NAME.get((raw[24], raw[25]), f'Action {raw[24]}/{raw[25]}')
        if act == 'BRP':
            name = 'BRP'
    return fc, name, act


def parse(kind, raw, fc):
    """Разбор по виду: (p, err)."""
    try:
        if kind == 'DMG Beacon':
            return F.parse_dmg_beacon(raw, with_fcs=False), None
        if kind in CFE_KEY:
            return F.parse_frame(raw, with_fcs=False), None
        if kind in BODY_FRAMES:
            return E.parse_body(kind, raw[24:]), None
    except (F.FieldError, ValueError, NotImplementedError) as e:
        return None, str(e)
    return None, None


def events(snap, ap_mac):
    base, _ = time_base(snap, ap_mac)
    out = []
    for f in sorted(snap['frames'], key=lambda f: (f['start'], f['end'])):
        raw = bytes(f['frame'])
        fc, kind, act = classify(raw, f['mpdus'])
        dst = BCAST if kind == 'DMG Beacon' else mac(raw[4:10])
        p, err = parse(kind, raw, fc)
        w = f['what']
        out.append(Ev(i=len(out), t=Fr(f['start'], CLK) + base, te=Fr(f['end'], CLK) + base, src=mac(f['src']),
                      dst=dst, kind=kind, dur=int.from_bytes(raw[2:4], 'little'), mcs=f['mcs'] or 0, raw=raw, fc=fc,
                      p=p, err=err, action=act, by_mac=w.startswith('ответ на'), what=w, mpdus=f['mpdus'],
                      length=(sum(len(m) + 8 for m in f['mpdus']) if f['mpdus'] else len(raw) + 4)))
    return out


# =====================================================================================================================
# расписание BI из DMG Beacon (для bi/abft/cbap)
# =====================================================================================================================
def bic_bi(b):
    """fields.Bic (сырые поля рис. 9-77) → bi.BeaconIntervalControl."""
    return BI.BeaconIntervalControl(
        cc_present=b.cc_present, discovery_mode=b.discovery, next_beacon=b.next_beacon, ati_present=b.ati_present,
        abft_length=b.abft_length, fss=b.fss, is_responder_txss=b.is_resp_txss, next_abft=b.next_abft,
        fragmented_txss=b.fragmented_txss, txss_span=b.txss_span, n_bis_abft=b.n_bis_abft, abft_count=b.abft_count,
        n_abft_in_ant=b.n_abft_in_ant, pcp_association_ready=b.pcp_assoc_ready)


class Schedule:
    """BI по журналу: k → конфигурация (BIC и DMG Parameters первого маяка BI; BI без маяка — как предыдущий: AP
    объявляет расписание маяками, без новых — действует прежнее), BTI (начало, конец по Duration последнего маяка
    цепочки, 10.42.5.1), периоды bi.layout."""
    def __init__(self, evs, ap, bi_tu):
        self.ap, self.bi_tu = ap, bi_tu
        self.cfg, self.bti = {}, {}
        by = {}
        for e in evs:
            if e.kind == 'DMG Beacon' and e.src == ap and e.p is not None:
                by.setdefault(BI.bi_index(e.t, bi_tu), []).append(e)
        for k, bs in by.items():
            p = bs[0].p
            self.cfg[k] = BI.BiConfig(bic=bic_bi(p.bic), params=BI.DmgParameters(
                p.params.bss_type, p.params.cbap_only, p.params.cbap_source, p.params.privacy, p.params.ecapc))
            chain = [bs[0]]
            for b in bs[1:]:
                if b.t - chain[-1].te <= T.LBIFS + T.LBIFS_TOL:
                    chain.append(b)
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


# =====================================================================================================================
# судьи
# =====================================================================================================================
def judge_fields(evs, ap, sched):
    """Поля MPDU бит-в-бит (ref/fields): Frame Control (9.2.4.1) у каждого кадра; DMG Beacon и кадры Control Frame
    Extension — fields.check_mpdu с контекстом (A-BFT/CBAP, передатчик AP); длины кадров управления — рисунки 9.3.1."""
    out = []
    for e in evs:
        for m in F.check_fc(e.fc):
            out.append(Finding('fields', 'fc', '9.2.4.1', m, e.i))
        if e.kind == 'DMG Beacon':
            ctx = dict(role='ap', pcp=False)
        elif e.kind in CFE_KEY:
            per = sched.period_of(e.t)
            ctx = dict(sender_ap_pcp=(e.src == ap))
            if e.kind == 'SSW':
                ctx['in_cbap'] = per is not None and per.kind == BI.CBAP
            if e.kind == 'SSW-Feedback':
                ctx['abft'] = per is not None and per.kind == 'A-BFT'
        else:
            n = CTL_LEN.get(e.kind)
            if n is not None and len(e.raw) != n:
                out.append(Finding('fields', 'length', '9.3.1', f'{e.kind}: {len(e.raw) + 4} октетов с FCS '
                                   f'≠ {n + 4}', e.i))
            if e.kind == 'BlockAck' and len(e.raw) >= 18:
                ctl = int.from_bytes(e.raw[16:18], 'little')
                # табл. 9-28: DMG — Compressed (Multi-TID 0, Compressed 1, GCR 0); 10.25.1 (DMG — HT-immediate)
                if (ctl >> 1) & 7 != 2:
                    out.append(Finding('fields', 'ba_variant', '9.3.1.8.1 табл. 9-28', f'BA Control {ctl:#06x}', e.i))
            continue
        for m in F.check_mpdu(e.raw, with_fcs=False, **ctx):
            out.append(Finding('fields', e.kind, _clause(m, '9.3'), m, e.i))
    return out


def _clause(msg, default):
    import re
    m = re.findall(r'\b(\d+\.\d+(?:\.\d+)*(?:\.\d+)?|табл\. [\d-]+|рис\. [\d-]+)', msg)
    return m[-1] if m else default


ROLE_OF = {E.PROBE_REQ: E.ROLE_STA, E.ASSOC_REQ: E.ROLE_STA, E.REASSOC_REQ: E.ROLE_STA}


def judge_elements(evs, ap):
    """Тела кадров управления (ref/elements.check_body: порядок табл. 9-33…9-42, обязательные/запрещённые для DMG,
    поля DMG Capabilities/Operation, Capability Information) и порядок элементов DMG Beacon (табл. 9-45 — внутри
    fields.check_dmg_beacon, judge_fields)."""
    out = []
    for e in evs:
        if e.kind not in BODY_FRAMES:
            continue
        if e.err is not None:
            out.append(Finding('elements', 'parse', '9.3.3', f'{e.kind}: {e.err}', e.i))
            continue
        role = E.ROLE_AP if e.src == ap else E.ROLE_STA
        for m in E.check_body(e.kind, e.p, role):
            out.append(Finding('elements', e.kind, _clause(m, '9.3.3'), m, e.i))
    return out


def edca_txop_limit(evs, ap, ac_index=0):
    """TXOP Limit AC_BE (мкс) из EDCA Parameter Set (9.4.2.28: QoS Info 1, Update EDCA Info 1, AC_BE Parameter Record
    4: ACI/AIFSN, ECWmin/ECWmax, TXOP Limit 2 в единицах 32 мкс) Association Response точки; None — не объявлен."""
    for e in evs:
        if e.kind == E.ASSOC_RESP and e.src == ap and e.p is not None:
            for el in e.p[1]:
                if el.eid == 12 and len(el.info) >= 2 + 4 * (ac_index + 1):
                    r = el.info[2 + 4 * ac_index:6 + 4 * ac_index]
                    return int.from_bytes(r[2:4], 'little') * 32
    return None


def _prev(evs, e):
    c = [q for q in evs if q.te <= e.t and q is not e]
    return max(c, key=lambda q: q.te) if c else None


def judge_duration(evs, ap, sched, txop_limit=None):
    """Поле Duration (ref/duration.check_duration) по виду кадра и контексту журнала:
      DMG Beacon — остаток BTI (9.3.4.2); SSW — A-BFT: до конца слота, DTI: CDOWN·(SBIFS + TXTIME) + MBIFS или конец
      распределения (9.3.1.15); SSW-Feedback — A-BFT 0, DTI: SSW-Ack + MBIFS(·2 при BRP) (9.3.1.16); SSW-Ack — из
      Duration SSW-Feedback (9.3.1.17); Ack/BlockAck/DMG CTS — из Duration вызвавшего кадра (9.2.5.7, 9.3.1.13);
      RTS/Data/A-MPDU/управление в TXOP с лимитом — 9.2.5.2 b) (TEND-NAV = 0: первый кадр TXOP; иначе — NAV,
      установленный держателем); CF-End — 9.3.1.6 и 10.23.2.10."""
    out = []

    def chk(e, kind, ctx, clause):
        m = D.check_duration(kind, e.dur, ctx)
        if m is not None:
            out.append(Finding('duration', e.kind, clause, m + ('' if not e.by_mac else ' [кадр модели MAC]'), e.i))

    txop = {}           # держатель → (начало TXOP, конец NAV держателя)
    fb_of = {}
    for e in evs:
        per = sched.period_of(e.t)
        pk = per.kind if per is not None else None
        pr = _prev(evs, e)
        if e.kind == 'DMG Beacon':
            b = sched.bti.get(BI.bi_index(e.t, sched.bi_tu))
            if b is not None and e in b[2]:
                chk(e, 'dmg_beacon', {'bti_remaining': b[1] - e.te}, '9.3.4.2')
        elif e.kind == 'SSW' and e.p is not None:
            if pk == 'A-BFT':
                c = sched.config(BI.bi_index(e.t, sched.bi_tu)).bic
                sst = T.ss_slot_time(c.fss_frames)
                n = (e.t - per.start) // sst
                chk(e, 'ssw', {'abft_slot_remaining': per.start + (n + 1) * sst - e.te}, '9.3.1.15')
            else:
                ctx = {'cdown': e.p.ssw.cdown, 'ssw_txtime': e.te - e.t}
                if per is not None:
                    ctx['alloc_remaining'] = per.end - e.te
                chk(e, 'ssw', ctx, '9.3.1.15')
        elif e.kind == 'SSW-Feedback' and e.p is not None:
            ctx = {'in_abft': pk == 'A-BFT', 'brp_requested': S.brp_requested(_brp_dict(e.p.brp))}
            if pk != 'A-BFT' and per is not None:
                ctx['alloc_remaining'] = per.end - e.te
            chk(e, 'ssw_fb', ctx, '9.3.1.16')
            fb_of[e.src] = e
        elif e.kind == 'SSW-Ack':
            fb = fb_of.get(e.dst)
            if fb is not None:
                chk(e, 'ssw_ack', {'fb_duration': fb.dur}, '9.3.1.17')
        elif e.kind in ('Ack', 'BlockAck') and pr is not None and pr.dst == e.src:
            chk(e, 'ack' if e.kind == 'Ack' else 'ba', {'elicit_duration': pr.dur, 'elicit_mcs': pr.mcs,
                                                        'mcs': e.mcs, 'length': e.length}, '9.2.5.7')
        elif e.kind == 'DMG CTS' and pr is not None and pr.kind == 'RTS':
            chk(e, 'dmg_cts', {'rts_duration': pr.dur, 'elicit_mcs': 0}, '9.3.1.13')
        elif e.kind == 'CF-End':
            # 9.3.1.6: Duration = (i − 1)·(TXTIME(CF-End) + SIFS), i — номер в последовательности усечения с конца
            # (i = 1 — последний); первый CF-End держателя TXOP, на который отвечают CF-End (10.23.2.10, 10.39.8.1), —
            # i = 2, ответ — i = 1; ответ определяется по предыдущему CF-End с RA = TA этого кадра через ≤ SIFS + 10 мкс
            resp = pr is not None and pr.kind == 'CF-End' and pr.dst == e.src and e.t - pr.te <= T.SIFS + 10
            i = 1 if resp else 2
            m = D.check_duration('cf_end', e.dur, {'i': i})
            if m is not None and not (not resp and e.dur == 0):
                out.append(Finding('duration', e.kind, '9.3.1.6', f'CF-End ({"ответ" if resp else "держатель TXOP"}, '
                                   f'i = {i}): {m}', e.i))
            h = txop.get(e.src)
            if not resp and e.dur and h is not None:
                m = D.cf_end_check(e.dur, i, h[1] - e.te)
                if m is not None and 'остатке' in m:
                    out.append(Finding('duration', e.kind, '10.23.2.10', m, e.i))
            txop.pop(e.src, None)
        elif e.kind in ('RTS', 'Data', 'A-MPDU') or (e.raw[0] >> 2) & 3 == 0 and e.kind not in ('BRP',):
            if not txop_limit:
                continue
            tppdu = e.te - e.t
            h = txop.get(e.src)
            first = h is None or e.kind == 'RTS' or e.t >= h[0] + txop_limit
            if first:
                # T_END-NAV = 0 (9.2.5.2 b 3): T_PENDING — фактический остаток обмена держателя в этом TXOP
                end = _exchange_end(evs, e)
                lo, hi = D.duration_multi_range(tppdu, Fr(txop_limit), 0, t_pending=end - e.te)
                txop[e.src] = (e.t, e.te + e.dur)
            else:
                t0, nav_end = h
                lo, hi = D.field(nav_end - e.t - tppdu), D.field(t0 + txop_limit - e.t - tppdu)
                txop[e.src] = (t0, max(nav_end, e.te + e.dur))
            if not first and e.kind != 'BRP' and e.dur == lo - 1 and lo <= hi:
                # H-DURQ: Duration кадров очереди ставит MAC — остаток TXOP с отбрасыванием дробной микросекунды (стенд
                # 2026-10-31: RTS 1982 = ⌊2000 − SIFS − TXTIME(RTS)⌋, при округлении вверх по 9.2.5.1 было бы 1983); NAV
                # прежнего кадра (тоже ⌊…⌋ от того же конца TXOP) с округлением вверх выходит на 1 мкс дальше — отклонение
                # MAC, не прошивки (значение пишет MAC, uc его не задаёт)
                continue
            if not lo <= e.dur <= hi:
                out.append(Finding('duration', e.kind, '9.2.5.2 b)', f'{e.kind}: Duration {e.dur} вне [{lo}, {hi}] '
                                   f'(TXOP {txop_limit} мкс){" [Duration ставит модель MAC, H-DURQ]" if e.kind != "BRP" else ""}',
                                   e.i))
    return out


def _exchange_end(evs, e, gap=T.SIFS + 10):
    """Конец обмена держателя TXOP, начатого кадром e: кадры пары подряд с промежутками ≤ gap до CF-End (CF-End и
    ответ на него — не «pending MPDU» 9.2.5.2 b) — не входят)."""
    end, peer = e.te, {e.src, e.dst}
    for q in evs[e.i + 1:]:
        if q.t - end > gap or {q.src, q.dst} != peer or q.kind in ('CF-End', 'DMG Beacon'):
            break
        end = q.te
    return end


def _brp_dict(b):
    return {'L-RX': b.l_rx, 'TX-TRN-REQ': b.tx_trn_req, 'MID-REQ': b.mid_req, 'BC-REQ': b.bc_req}


def judge_bi(evs, ap, sched, aids=None):
    """ref/bi.check_air_log: BTI (цепочка маяков, SBIFS, CDOWN, Duration, сектора), A-BFT (слоты, FSS, моменты),
    периоды DTI (CBAP Only — один CBAP после guard, 10.39.6.3)."""
    ev = [(e.t, e.te, e.src, e.dst, e.kind, e.dur, e.info()) for e in evs]
    # 11.1.2.1: покрытие — все сектора, через которые точка вообще передавала маяки в журнале
    secs = {e.p.ssw.sector_id for e in evs if e.kind == 'DMG Beacon' and e.src == ap and e.p is not None}
    bss = BI.Bss(ap, aids or {}, bi_tu=sched.bi_tu, configs=lambda k: sched.config(k), sectors=secs or None)
    return [Finding('bi', v.rule, _bi_clause(v.rule), v.msg, v.idx) for v in BI.check_air_log(ev, bss)]


BI_CLAUSE = {'beacon_src': '11.1.2.1', 'beacon_outside_bti': '10.39.2', 'beacon_gap': '10.42.2.2.2/10.3.2.3.8',
             'beacon_sector_dup': '11.1.3.3.1', 'beacon_cdown': '10.42.4', 'beacon_dur': '9.3.4.2',
             'sector_coverage': '11.1.2.1', 'bti_sta': '10.39.2', 'bti_kind': '10.42.4', 'abft_kind': '10.42.5.2',
             'abft_slot_start': '10.42.5.2', 'abft_fss': '10.42.5.2', 'abft_ss_end': '10.42.5.2 рис. 10-76',
             'abft_sbifs': '10.3.2.3.8', 'abft_fb_time': '10.42.5.2', 'ati_sta': '10.39.3', 'ati_resp_dst': '10.39.3',
             'ati_kind': '10.39.3', 'ati_noack': '10.39.3', 'no_period': '10.39.4/10.39.6.5',
             'period_end': '10.39.4/10.39.5', 'sp_foreign': '10.39.6.2', 'sp_pcp_inactive': '10.39.6.2',
             'cbap_member': '10.39.5'}


def _bi_clause(rule):
    return BI_CLAUSE.get(rule, '10.39')


def judge_abft(evs, ap, sched):
    """ref/abft.check_abft_log на каждой A-BFT журнала (границы — AbftLayout по BIC маяков и концу BTI)."""
    out = []
    for k, (b0, bend, chain) in sorted(sched.bti.items()):
        c = sched.config(k)
        if not c.bic.abft_present:
            continue
        L = A.AbftLayout(A.abft_start(bend), c.bic.abft_slots, c.bic.fss_frames, bool(c.bic.is_responder_txss))
        frs, idx = [], []
        for e in evs:
            if L.start <= e.t < L.end and e.kind != 'DMG Beacon':
                frs.append(_air_frame(e))
                idx.append(e.i)
        for v in A.check_abft_log(frs, L, ap):
            out.append(Finding('abft', v.rule, '10.42.5.2', f'BI {k}: {v.msg}', idx[v.idx]))
    return out


def _air_frame(e):
    kw = dict(mcs=e.mcs, duration=e.dur)
    if e.kind == 'SSW' and e.p is not None:
        s, fb = e.p.ssw, e.p.fb
        kw.update(direction=s.direction, cdown=s.cdown, sector_id=s.sector_id, ant_id=s.antenna_id)
        if isinstance(fb, F.SswFb):
            kw.update(sector_select=fb.sector_select, ant_select=fb.antenna_select, snr=fb.snr_report,
                      poll=fb.poll_required)
    elif e.kind == 'SSW-Feedback' and e.p is not None:
        kw.update(sector_select=e.p.fb.sector_select, ant_select=e.p.fb.antenna_select, snr=e.p.fb.snr_report)
    f = A.AirFrame(e.kind, e.t, e.src, e.dst, **kw)
    f.length = e.length
    return f


def bf_frame(e):
    """Ev → sls.BfFrame (SSW / SSW-Feedback / SSW-Ack). Total Sectors in ISS: поле = N − 1 (PLAN.md №3)."""
    kw = dict(length=e.length, mcs=e.mcs, dur=e.dur)
    p = e.p
    if e.kind == 'SSW':
        kw.update(direction=p.ssw.direction, cdown=p.ssw.cdown, sector_id=p.ssw.sector_id,
                  antenna_id=p.ssw.antenna_id, rxss_len=p.ssw.rxss_length or None)
        if isinstance(p.fb, F.SswFbIss):
            kw['fb'] = {'total': p.fb.total_sectors + 1, 'n_rx_ant': p.fb.rx_antennas, 'poll': p.fb.poll_required}
        else:
            kw['fb'] = {'sector': p.fb.sector_select, 'antenna': p.fb.antenna_select, 'snr': p.fb.snr_report,
                        'poll': p.fb.poll_required}
    else:
        kw['fb'] = {'sector': p.fb.sector_select, 'antenna': p.fb.antenna_select, 'snr': p.fb.snr_report,
                    'poll': p.fb.poll_required}
        kw['brp'] = _brp_dict(p.brp)
    # сектор передачи эмулятор не моделирует (air.py: канал идеальный, антенн нет) — tx неизвестен
    kw['tx'] = (None, None) if e.kind != 'SSW' else None
    return S.BfFrame(e.kind, e.src, e.dst, e.t, **kw)


def sls_runs(evs, sched):
    """SLS в DTI: от SSW ISS (Direction 0) пары до последнего кадра SLS этой пары перед следующим ISS той же пары."""
    bf = [e for e in evs if e.kind in ('SSW', 'SSW-Feedback', 'SSW-Ack') and e.p is not None and
          (lambda p: p is not None and p.kind not in ('A-BFT', 'BTI'))(sched.period_of(e.t))]
    runs = []
    cur = None
    for e in bf:
        new = e.kind == 'SSW' and e.p.ssw.direction == 0 and (
            cur is None or {e.src, e.dst} != cur['pair'] or cur['last'].kind != 'SSW' or
            cur['last'].p.ssw.direction != 0 or cur['last'].src != e.src)
        if new:
            cur = dict(pair={e.src, e.dst}, frames=[e], last=e)
            runs.append(cur)
        elif cur is not None and {e.src, e.dst} == cur['pair']:
            cur['frames'].append(e)
            cur['last'] = e
    return [r['frames'] for r in runs]


def judge_sls(evs, ap, sched):
    """ref/sls.check_sls_log на каждом SLS в DTI (доступ — CBAP, конец распределения — конец периода)."""
    out = []
    for run in sls_runs(evs, sched):
        per = sched.period_of(run[0].t)
        ctx = {'access': S.CBAP if per is not None and per.kind == BI.CBAP else S.SP,
               'alloc_end': per.end if per is not None else None}
        for m in S.check_sls_log([bf_frame(e) for e in run], ctx):
            if 'передан через' in m:
                continue        # сектор передачи эмулятор не моделирует (air.py: канал идеальный, антенн нет)
            out.append(Finding('sls', 'sls', _clause(m, '10.42.2'), f'SLS @{float(run[0].t):.1f}: {m}', run[0].i))
    return out


def judge_cbap(evs, ap, sched, txop_limit=0, sifs_tol=None, slot_tol=None, t0=None):
    """ref/cbap.check_air_log над кадрами DTI: конец CBAP — конец периода bi.layout; кадр управления, адресованный
    одной STA (кроме Action No Ack), требует Ack так же, как Data (10.3.2.11) — в модели cbap это вид 'Data'."""
    ev, idx = [], []
    for e in evs:
        if t0 is not None and e.t < t0:
            continue
        per = sched.period_of(e.t)
        if per is None or per.kind != BI.CBAP:
            continue
        kind = e.kind
        if (e.raw[0] >> 2) & 3 == 0 and kind not in ('BRP', 'Action No Ack') and e.dst != BCAST:
            kind = 'Data'
        ev.append((e.t, e.te, e.src, e.dst, kind, e.dur, per.end))
        idx.append(e.i)
    p = C.LogParams(aps=(ap,), txop_limit=txop_limit or 0)
    if sifs_tol is not None:
        p.sifs_tol = Fr(sifs_tol)
    if slot_tol is not None:
        p.slot_tol = Fr(slot_tol)
    return [Finding('cbap', v.rule, CBAP_CLAUSE.get(v.rule, '10.23'), v.msg, idx[v.idx])
            for v in C.check_air_log(ev, p)]


CBAP_CLAUSE = {'busy': '10.3.2.1', 'nav': '10.3.2.4', 'aifs': '10.23.2.4', 'slot': '10.23.2.4', 'sifs': '10.3.2.3.3',
               'cts_nav': '10.3.2.9', 'timeout': '10.3.2.11', 'txnav': '10.23.2.8', 'txop_limit': '10.23.2.9',
               'cbap_end': '10.39.5', 'cf_end': '10.23.2.10', 'cf_end_dur': '10.23.2.10'}


def judge_addba(evs, ap):
    """ADDBA Request/Response (ref/blockack): разбор тела (табл. 9-360/9-361, 9.6.4.2: Fragment Number 0, Dialog
    Token ≠ 0) и ответ на запрос (9.6.4.3, 10.25.2, 10.25.6.2); DMG — Block Ack Policy immediate (10.25.1)."""
    out, reqs = [], {}
    for e in evs:
        if e.action not in ('ADDBA Request', 'ADDBA Response'):
            continue
        try:
            if e.action == 'ADDBA Request':
                r = BA.parse_addba_req(e.raw[24:])
                if r.token == 0:
                    out.append(Finding('addba', 'token', '9.6.4.2', 'Dialog Token = 0', e.i))
                reqs[(e.src, e.dst)] = r
            else:
                r = BA.parse_addba_resp(e.raw[24:])
                q = reqs.get((e.dst, e.src))
                if q is None:
                    out.append(Finding('addba', 'resp', '10.25.2', 'ADDBA Response без запроса', e.i))
                else:
                    BA.check_addba_response(q, r)
        except ValueError as x:
            out.append(Finding('addba', e.action, _clause(str(x), '9.6.4'), str(x), e.i))
    return out


def judge_all(evs, ap, **kw):
    sched = Schedule(evs, ap, kw.get('bi_tu', 100))
    lim = edca_txop_limit(evs, ap)
    return (judge_fields(evs, ap, sched) + judge_elements(evs, ap) + judge_duration(evs, ap, sched, lim) +
            judge_bi(evs, ap, sched) + judge_abft(evs, ap, sched) + judge_sls(evs, ap, sched) +
            judge_cbap(evs, ap, sched, lim) + judge_addba(evs, ap))


def report(evs, found, n=40):
    return '\n'.join(f'[{f.judge}/{f.rule} {f.clause}] {evs[f.idx] if 0 <= f.idx < len(evs) else "-"}: {f.msg}'
                     for f in found[:n])
