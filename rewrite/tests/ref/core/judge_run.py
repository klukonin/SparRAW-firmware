# SPDX-License-Identifier: AGPL-3.0-or-later
"""Судьи над журналом ядра — те же правила, что над эмулятором и записью PMC стенда:

  air(journal, ap)            — ref/air_judge.judge над journal.to_air() (все правила air_judge и волн air_wave*);
  bridge(journal, ap, RB)     — судьи моста эмулятора unit/ref_bridge2 (RB — модуль, передаёт вызывающий: ядро не
                                импортирует tests/unit) над journal.to_snapshot(): поля, элементы, Duration, BI, A-BFT,
                                SLS, ADDBA и доступ CBAP.

Отличия от RB.judge_all (мост рассчитан на эмулятор, где всё идёт одной AC):
  1) доступ CBAP (judge_cbap): мост берёт AIFSN = 3 для всех кадров и не передаёт
границы CBAP, а ядро (по стандарту) шлёт кадры управления на AC_VO (10.2.3.2, AIFSN 2 по табл. 9-155 / EDCA Parameter
Set) и начинает отсчёт AIFS в начале CBAP (10.39.5: EDCAF возобновляется в начале CBAP). Здесь cbap.check_air_log
получает AIFSN по AC кадра и окна CBAP из расписания маяков (bi.layout) — иначе судья мерил бы первый доступ CBAP от
последнего кадра прошлого BI;
  2) Duration кадров управления и TXOP (judge_duration) — по AC кадра и с TPENDING без следующего доступа
     (duration_ac);
  3) TXNAV держателя после BRP setup и SLS в DTI (10.23.2.2: Duration последнего переданного держателем кадра) —
     cbap.LogParams.txnav_kinds;
  4) SLS в DTI — последовательности по парам (sls_pairs), а не одним потоком."""
from collections import namedtuple

from .. import air_judge as AJ
from .. import bi as BI
from .. import cbap as C
from .. import elements as E
from . import frames as FR

V = namedtuple('V', 'judge rule idx msg verdict')


def air(journal, ap, edca=None):
    """→ (Ctx, [Rule]) air_judge.judge."""
    return AJ.judge(journal.to_air(ap), edca=edca)


def air_violations(rules):
    return [V('air_judge', r.rid, i, m, v) for r in rules for i, m, v in r.viol]


def air_summary(rules):
    return {r.rid: dict(status=r.status, checked=r.checked, violations=len(r.viol), unchecked=dict(r.unchecked))
            for r in rules}


def _aifsn_of(evs, idx, ap):
    """AIFSN кадра по AC (10.2.3.2): кадр управления (Type 00) — AC_VO; прочее — AC_BE. Значения — EDCA Parameter Set
    точки (Association Response), иначе табл. 9-155."""
    vo, be = C.DEFAULT_EDCA[C.AC_VO].aifsn, C.DEFAULT_EDCA[C.AC_BE].aifsn
    for e in evs:
        if e.src == ap and e.kind in (E.ASSOC_RESP, E.PROBE_RESP):
            for el in E.parse_body(e.kind, e.raw[24:])[1]:
                if el.eid == 12:
                    p = FR.parse_edca_parameter_set(el.info)
                    vo, be = p[3][0], p[0][0]

    def f(src, i):
        e = evs[idx[i]]
        return vo if (e.raw[0] >> 2) & 3 == 0 else be
    return f


def _holder_bf(e):
    """Кадр BF/BRP держателя TXOP (инициатора обмена): BRP с Initiator = 1 (9.4.2.129), SSW ISS (Direction 0),
    SSW-Feedback (передаёт инициатор SLS, 10.42.2.1)."""
    from .. import brp as BRP
    if e.kind == 'BRP':
        return bool(BRP.BeamRefinement.parse(e.raw[31:38]).initiator)
    if e.kind == 'SSW':
        return e.raw[16] & 1 == 0
    return e.kind == 'SSW-Feedback'


def cbap_ac(evs, ap, sched, RB, txop_limit=0, rx_err=None, sensed=None):
    """RB.judge_cbap с AIFSN по AC кадра и окнами CBAP (см. докстроку модуля); rx_err — {индекс события: STA с ошибкой
    приёма} (журнал ядра: EIFS, 10.3.2.3.7)."""
    rx_err, sensed = rx_err or {}, sensed or {}
    ev, idx, wins = [], [], set()
    for e in evs:
        per = sched.period_of(e.t)
        if per is None or per.kind != BI.CBAP:
            continue
        wins.add((per.start, per.end))
        kind = e.kind
        if (e.raw[0] >> 2) & 3 == 0 and kind not in ('BRP', 'Action No Ack') and e.dst != C.BCAST:
            kind = 'Data'
        ev.append((e.t, e.te, e.src, e.dst, kind, e.dur, per.end, rx_err.get(e.i, ()), sensed.get(e.i)))
        idx.append(e.i)
    for k in list(sched.bti):
        for per in sched.periods(k):
            if per.kind == BI.CBAP:
                wins.add((per.start, per.end))
    p = C.LogParams(aps=(ap,), txop_limit=txop_limit or 0, cbaps=sorted(wins), aifsn=_aifsn_of(evs, idx, ap),
                    txnav_kinds=lambda i: _holder_bf(evs[idx[i]]))
    return [RB.Finding('cbap', v.rule, RB.CBAP_CLAUSE.get(v.rule, '10.23'), v.msg, idx[v.idx])
            for v in C.check_air_log(ev, p)]


def duration_ac(evs, found, RB, txop_limit=None, sched=None):
    """Duration по AC кадра. RB.judge_duration (а) применяет к кадрам управления лимит TXOP AC_BE, (б) считает
    «обменом» держателя кадры пары с промежутками ≤ SIFS + 10 мкс — туда попадает и следующий доступ на
    AIFS[AC_VO] = 13 мкс (новый TXOP), что завышает TPENDING. Здесь:
      - кадры управления (AC_VO, TXOP Limit 0 в EDCA Parameter Set точки): 9.2.5.2 b) 1) — D = TSINGLE-MSDU − TPPDU =
        SIFS + Ack (= 9.2.5.2 a) 5) i));
      - RTS/данные (AC_BE, лимит > 0): 9.2.5.2 b) 3)/4), TPENDING — кадры пары с промежутками < AIFS[AC_VO] (внутри
        TXOP промежутки — SIFS, после сбоя — PIFS, 10.23.2.8; новый доступ — не раньше AIFS).
    Находки RB по этим кадрам заменяются; остальные (ответы, CF-End, SSW, маяки) — как у RB."""
    from .. import duration as D
    from ..timing import PIFS, SIFS, txtime
    from fractions import Fraction as Fr
    data_kinds = ('RTS', 'Data', 'A-MPDU')
    out = [f for f in found if not (f.judge == 'duration' and evs[f.idx].kind != 'BRP' and
                                    ((evs[f.idx].raw[0] >> 2) & 3 == 0 or evs[f.idx].kind in data_kinds))]
    gap_max = PIFS + 1                       # < AIFS[AC_VO] = 13 мкс

    def exchange_end(e):
        end, peer = e.te, {e.src, e.dst}
        per0 = sched.period_of(e.t) if sched is not None else None
        for q in evs[e.i + 1:]:
            if q.t - end > gap_max or {q.src, q.dst} != peer or q.kind in ('CF-End', 'DMG Beacon'):
                break
            if sched is not None and sched.period_of(q.t) is not per0:
                break                         # другой период расписания (SP после CBAP) — уже не этот TXOP
            end = q.te
        return end
    txop = {}
    ext = sp_ext_windows(evs, _ap_of(evs), sched) if sched is not None else []
    for e in evs:
        per = sched.period_of(e.t) if sched is not None else None
        if per is not None and per.kind == BI.SP and e.kind in data_kinds:
            # SP — не TXOP EDCA (лимит TXOP не действует): Duration покрывает немедленный ответ (9.2.5.2 a))
            resp = D.response_txtime('ba' if e.kind == 'A-MPDU' else 'ack', e.mcs, 32 if e.kind == 'A-MPDU' else 14)
            sp_end = max([per.end] + [en for s0, en, m in ext if s0 == per.end and e.src in m])
            if e.dur < D.field(SIFS + resp) or e.te + e.dur > sp_end + 1:
                out.append(RB.Finding('duration', e.kind, '9.2.5.2 a)', f'{e.kind} в SP: Duration {e.dur} не покрывает '
                                      f'SIFS + ответ или выходит за конец SP', e.i))
            continue
        if (e.raw[0] >> 2) & 3 == 0 and e.kind not in ('BRP', 'Action No Ack') and e.dst != C.BCAST:
            t_ack = txtime(14, D.response_mcs('ack', e.mcs))
            m = D.check_duration('mgmt', e.dur, {'resp_txtime': t_ack})
            if m is not None:
                out.append(RB.Finding('duration', e.kind, '9.2.5.2 a) 5)', m, e.i))
            continue
        if e.kind == 'CF-End':
            txop.pop(e.src, None)
            continue
        if e.kind not in data_kinds or not txop_limit:
            continue
        tppdu, lim = e.te - e.t, Fr(txop_limit)
        h = txop.get(e.src)
        if h is None or e.kind == 'RTS' or e.t >= h[0] + lim:
            lo, hi = D.duration_multi_range(tppdu, lim, 0, t_pending=exchange_end(e) - e.te)
            txop[e.src] = (e.t, e.te + e.dur)
        else:
            t0, nav_end = h
            lo, hi = D.field(nav_end - e.t - tppdu), D.field(t0 + lim - e.t - tppdu)
            txop[e.src] = (t0, max(nav_end, e.te + e.dur))
        if not lo <= e.dur <= hi:
            out.append(RB.Finding('duration', e.kind, '9.2.5.2 b)', f'{e.kind}: Duration {e.dur} вне [{lo}, {hi}] '
                                  f'(TXOP {txop_limit} мкс)', e.i))
    return out


def sls_pairs(evs, ap, sched, RB):
    """RB.judge_sls, но последовательности SLS — по каждой паре отдельно (RB.sls_runs ведёт один поток на весь
    журнал: при одновременных ISS двух станций — коллизия на одной границе слота — кадры пар чередуются и поток
    рвётся на одиночные кадры)."""
    from .. import sls as S
    per_pair, runs = {}, []
    for e in evs:
        if e.kind not in ('SSW', 'SSW-Feedback', 'SSW-Ack') or e.p is None:
            continue
        per = sched.period_of(e.t)
        if per is not None and per.kind in ('A-BFT', 'BTI'):
            continue
        pair = frozenset((e.src, e.dst))
        cur = per_pair.get(pair)
        iss = e.kind == 'SSW' and e.p.ssw.direction == 0
        # новый SLS: ISS после других кадров пары или повтор ISS (CDOWN снова растёт — новая попытка, 10.42.6.2)
        if iss and (cur is None or cur[-1].kind != 'SSW' or cur[-1].p.ssw.direction != 0 or cur[-1].src != e.src
                    or e.p.ssw.cdown >= cur[-1].p.ssw.cdown):
            cur = per_pair[pair] = [e]
            runs.append(cur)
        elif cur is not None:
            cur.append(e)
    out = []
    for run in runs:
        per = sched.period_of(run[0].t)
        ctx = {'access': S.CBAP if per is not None and per.kind == BI.CBAP else S.SP,
               'alloc_end': per.end if per is not None else None}
        for m in S.check_sls_log([RB.bf_frame(e) for e in run], ctx):
            if 'передан через' in m:
                continue
            out.append(RB.Finding('sls', 'sls', RB._clause(m, '10.42.2'), f'SLS @{float(run[0].t):.1f}: {m}',
                                  run[0].i))
    return out


def _ap_of(evs):
    """MAC точки — передатчик DMG Beacon."""
    return next((e.src for e in evs if e.kind == 'DMG Beacon'), None)


def _aids(evs, ap):
    """MAC → AID по Association Response точки (9.4.1.8; AP — 0)."""
    out = {ap: 0}
    for e in evs:
        if e.kind in (E.ASSOC_RESP, E.REASSOC_RESP) and e.src == ap:
            try:
                fx, _ = E.parse_body(e.kind, e.raw[24:])
            except (ValueError, KeyError, IndexError):
                continue
            if fx.get('status') == 0:
                out[e.dst] = fx['aid'] & 0x3fff
    return out


def bi_ac(evs, ap, sched, RB):
    """RB.judge_bi с AID станций (Association Response) и окнами динамического распределения (Grant, 10.39.7) и
    возвращённого времени SP (10.39.8.1, 10.39.6.7) по ref/sp.check_dti — иначе ответы получателя SP и передачи в
    выделенном Grant окне — «чужие» (мост рассчитан на CBAP Only)."""
    from .. import bi as BIm
    from .. import sp as SPm
    aids = _aids(evs, ap)
    dyn = []
    for k, c in list(sched.cfg.items()):
        if not c.allocations:
            continue
        t0, t1 = BIm.tbtt(k, sched.bi_tu), BIm.tbtt(k + 1, sched.bi_tu)
        log = [(e.t, e.te, e.src, e.dst, e.kind, e.dur,
                dict(e.info(), mcs=e.mcs, frame=e.p if e.kind in ('Poll', 'SPR', 'Grant', 'Grant Ack') else None))
               for e in evs if t0 <= e.t < t1 and e.kind != 'DMG Beacon']
        if not log:
            continue
        b = sched.bti.get(k)
        try:
            _, wins, per = SPm.check_dti(log, k, sched.bi_tu, [_entry(a) for a in c.allocations], aids, ap,
                                         bti_end=b[1] if b else None, bic=c.bic, params=c.params)
        except (ValueError, KeyError, AttributeError):
            continue
        dyn += [(w.start, w.end, set(w.members) | ({ap} if w.everyone else set())) for w in wins]
    ev = [(e.t, e.te, e.src, e.dst, e.kind, e.dur, e.info()) for e in evs]
    secs = {e.p.ssw.sector_id for e in evs if e.kind == 'DMG Beacon' and e.src == ap and e.p is not None}
    ext = sp_ext_windows(evs, ap, sched)
    bss = BIm.Bss(ap, aids, bi_tu=sched.bi_tu, configs=lambda k: sched.config(k), sectors=secs or None,
                  dynamic=dyn + ext)
    out = []
    for v in BIm.check_air_log(ev, bss):
        e = evs[v.idx]
        if v.rule == 'period_end' and any(s <= e.te <= en and e.src in m for s, en, m in ext):
            continue                          # продлённый SP (10.39.9): конец — с продлением
        if v.rule == 'sp_foreign' and e.kind == 'SPR' and any(
                q.kind == 'Poll' and q.src == ap and q.dst == e.src and 0 <= e.t - q.te <= 1000 for q in evs[:v.idx]):
            continue                          # SPR на Poll (10.39.7.2) — через Response Offset; сроки — dynalloc
        out.append(RB.Finding('bi', v.rule, RB._bi_clause(v.rule), v.msg, v.idx))
    return out


def sp_ext_windows(evs, ap, sched):
    """Продления SP (10.39.9): Grant точки с Allocation Duration > 0 через SIFS после SPR в SP → [(конец SP, конец +
    продление, {пара SP})]."""
    from .. import bi as BIm
    out = []
    for j, e in enumerate(evs):
        if e.kind != 'Grant' or e.src != ap or e.p is None or not e.p.dai.alloc_duration or j == 0:
            continue
        q = evs[j - 1]
        if q.kind != 'SPR' or q.src != e.dst or e.t - q.te > 4:
            continue
        per = sched.period_of(q.t)
        if per is None or per.kind != BIm.SP:
            continue
        out.append((per.end, per.end + e.p.dai.alloc_duration, {e.dst, ap, q.dst}))
    return out


def _entry(a):
    from .. import schedule as S
    return S.Entry(a, S.BF_NONE)


def _schedule_allocations(sched, evs, ap, bi_tu):
    """Мост строит периоды BI по BIC и DMG Parameters маяка без Extended Schedule (эмулятор раньше — только CBAP Only):
    добавить распределения Extended Schedule первого маяка каждого BI (9.4.2.131, 10.39.6.1) — иначе при CBAP Only = 0
    весь DTI — «вне периодов» (одни правила для ядра и прошивки: простой TDMA прошивки — тоже Extended Schedule)."""
    from .. import schedule as S
    seen = set()
    for e in evs:
        if e.kind != 'DMG Beacon' or e.src != ap or e.p is None:
            continue
        k = BI.bi_index(e.t, bi_tu)
        if k in seen or k not in sched.cfg:
            continue
        seen.add(k)
        try:
            ent = S.from_elements(e.p.elements)
        except ValueError:
            continue
        if ent:
            sched.cfg[k].allocations = [x.alloc for x in ent]
            sched.cfg[k].has_es_in_beacon = True


def bridge(journal, ap, RB, bi_tu=None):
    """→ (события RB.Ev, [RB.Finding]) — все судьи RB.judge_all, доступ CBAP — cbap_ac."""
    bi_tu = bi_tu or journal.bi_tu
    return bridge_snapshot(journal.to_snapshot(ap, bi_tu), ap, RB, bi_tu)


def bridge_snapshot(snap, ap, RB, bi_tu):
    """bridge над снимком эфира (journal.to_snapshot или ref_bridge2.snapshot эмулятора) — одни правила для ядра и
    прошивки (этап 2, diff_compare)."""
    from .. import fields as F
    evs = RB.events(snap, F.mac_bytes(ap))
    # ошибки приёма по узлам (снимок журнала ядра несёт rx_err; эмулятора — нет): порядок RB.events — по (start, end)
    srt = sorted(snap['frames'], key=lambda f: (f['start'], f['end']))
    rx_err = {i: {F.mac_str(m) for m in f.get('rx_err', ())} for i, f in enumerate(srt) if f.get('rx_err')}
    sensed = {i: {F.mac_str(m) for m in f['sensed']} for i, f in enumerate(srt) if 'sensed' in f}
    sched = RB.Schedule(evs, ap, bi_tu)
    _schedule_allocations(sched, evs, ap, bi_tu)
    lim = RB.edca_txop_limit(evs, ap)
    found = (RB.judge_fields(evs, ap, sched) + RB.judge_elements(evs, ap) +
             duration_ac(evs, RB.judge_duration(evs, ap, sched, lim), RB, lim, sched) +
             bi_ac(evs, ap, sched, RB) + RB.judge_abft(evs, ap, sched) + sls_pairs(evs, ap, sched, RB) +
             cbap_ac(evs, ap, sched, RB, lim, rx_err, sensed) + RB.judge_addba(evs, ap))
    return evs, found
