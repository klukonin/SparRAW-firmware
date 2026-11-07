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


def cbap_ac(evs, ap, sched, RB, txop_limit=0):
    """RB.judge_cbap с AIFSN по AC кадра и окнами CBAP (см. докстроку модуля)."""
    ev, idx, wins = [], [], set()
    for e in evs:
        per = sched.period_of(e.t)
        if per is None or per.kind != BI.CBAP:
            continue
        wins.add((per.start, per.end))
        kind = e.kind
        if (e.raw[0] >> 2) & 3 == 0 and kind not in ('BRP', 'Action No Ack') and e.dst != C.BCAST:
            kind = 'Data'
        ev.append((e.t, e.te, e.src, e.dst, kind, e.dur, per.end))
        idx.append(e.i)
    for k in list(sched.bti):
        for per in sched.periods(k):
            if per.kind == BI.CBAP:
                wins.add((per.start, per.end))
    p = C.LogParams(aps=(ap,), txop_limit=txop_limit or 0, cbaps=sorted(wins), aifsn=_aifsn_of(evs, idx, ap),
                    txnav_kinds=lambda i: _holder_bf(evs[idx[i]]))
    return [RB.Finding('cbap', v.rule, RB.CBAP_CLAUSE.get(v.rule, '10.23'), v.msg, idx[v.idx])
            for v in C.check_air_log(ev, p)]


def duration_ac(evs, found, RB, txop_limit=None):
    """Duration по AC кадра. RB.judge_duration (а) применяет к кадрам управления лимит TXOP AC_BE, (б) считает
    «обменом» держателя кадры пары с промежутками ≤ SIFS + 10 мкс — туда попадает и следующий доступ на
    AIFS[AC_VO] = 13 мкс (новый TXOP), что завышает TPENDING. Здесь:
      - кадры управления (AC_VO, TXOP Limit 0 в EDCA Parameter Set точки): 9.2.5.2 b) 1) — D = TSINGLE-MSDU − TPPDU =
        SIFS + Ack (= 9.2.5.2 a) 5) i));
      - RTS/данные (AC_BE, лимит > 0): 9.2.5.2 b) 3)/4), TPENDING — кадры пары с промежутками < AIFS[AC_VO] (внутри
        TXOP промежутки — SIFS, после сбоя — PIFS, 10.23.2.8; новый доступ — не раньше AIFS).
    Находки RB по этим кадрам заменяются; остальные (ответы, CF-End, SSW, маяки) — как у RB."""
    from .. import duration as D
    from ..timing import PIFS, txtime
    from fractions import Fraction as Fr
    data_kinds = ('RTS', 'Data', 'A-MPDU')
    out = [f for f in found if not (f.judge == 'duration' and evs[f.idx].kind != 'BRP' and
                                    ((evs[f.idx].raw[0] >> 2) & 3 == 0 or evs[f.idx].kind in data_kinds))]
    gap_max = PIFS + 1                       # < AIFS[AC_VO] = 13 мкс

    def exchange_end(e):
        end, peer = e.te, {e.src, e.dst}
        for q in evs[e.i + 1:]:
            if q.t - end > gap_max or {q.src, q.dst} != peer or q.kind in ('CF-End', 'DMG Beacon'):
                break
            end = q.te
        return end
    txop = {}
    for e in evs:
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


def bridge(journal, ap, RB, bi_tu=None):
    """→ (события RB.Ev, [RB.Finding]) — все судьи RB.judge_all, доступ CBAP — cbap_ac."""
    bi_tu = bi_tu or journal.bi_tu
    from .. import fields as F
    evs = RB.events(journal.to_snapshot(ap, bi_tu), F.mac_bytes(ap))
    sched = RB.Schedule(evs, ap, bi_tu)
    lim = RB.edca_txop_limit(evs, ap)
    found = (RB.judge_fields(evs, ap, sched) + RB.judge_elements(evs, ap) +
             duration_ac(evs, RB.judge_duration(evs, ap, sched, lim), RB, lim) +
             RB.judge_bi(evs, ap, sched) + RB.judge_abft(evs, ap, sched) + sls_pairs(evs, ap, sched, RB) +
             cbap_ac(evs, ap, sched, RB, lim) + RB.judge_addba(evs, ap))
    return evs, found
