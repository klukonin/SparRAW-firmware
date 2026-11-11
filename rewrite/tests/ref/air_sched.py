# SPDX-License-Identifier: AGPL-3.0-or-later
"""Правила судьи эфира (ref/air_judge) для DTI по расписанию: 'schedule' (Extended Schedule в DMG Beacon — поле,
согласованность с BI, CBAP Only, повтор внутри BI, псевдостатика по BI — ref/schedule), 'sp_access' (правила SP и
CBAP-распределений расписания — ref/sp.check_dti), 'dynalloc' (Poll/SPR/Grant/Grant Ack — ref/dynalloc). Если в
захвате нет расписания с SP или кадров динамического распределения — «не проверяемо» с причиной.

Журнал строится из AirEv с известным временем; Duration — только у кадров с записанным Duration; поля Poll/SPR/Grant/
Grant Ack — разбор air_pcap (fields.parse_frame). Допуск времени — квант меток + калибровка + точка метки control
(air_judge.Q + CAL_UNCERT + PRE_UNCERT); Announce (ATI) с Extended Schedule не разбирается — расписание берётся из
маяков BTI. Импорт air_judge — внутри функций (air_judge импортирует этот модуль)."""
from collections import Counter, defaultdict

from . import bi as BI
from . import elements as E
from . import schedule as S
from . import sp as SPm
from .timing import AID_AP_PCP, AID_BROADCAST, BCAST

PAGE = {'10.39.6.1': 1884, '10.39.6.2': 1885, '10.39.7': 1896, '10.39.6.4': 1887}
DYN_KINDS = ('Poll', 'SPR', 'Grant', 'Grant Ack')


def _j():
    from . import air_judge as J
    return J


def _beacons(c):
    J = _j()
    by, bi_tu = J._btis(c)
    return by, bi_tu


def _sched(c):
    """{k: (маяк, [Entry] | None, ошибка)} по первому маяку BTI с телом; кэш в контексте."""
    if getattr(c, '_sched', None) is not None:
        return c._sched
    by, bi_tu = _beacons(c)
    out = {}
    for k, bs in by.items():
        b = bs[0]
        try:
            ent = S.from_elements(b.p.elements)
            out[k] = (b, ent, None, bs)
        except ValueError as x:
            out[k] = (b, None, str(x), bs)
    c._sched = (out, bi_tu)
    return c._sched


def _q():
    J = _j()
    return J.Q + J.CAL_UNCERT + J.PRE_UNCERT


def _log(c, k, bi_tu):
    t0, t1 = BI.tbtt(k, bi_tu), BI.tbtt(k + 1, bi_tu)
    out, idx = [], []
    for e in c.k:
        if not t0 <= e.t < t1 or e.kind == 'DMG Beacon':
            continue
        frame = e.p if e.kind in DYN_KINDS else None
        out.append((e.t, e.te, e.src, e.dst or BCAST, e.kind, e.dur if e.dur_ok else None,
                    dict(mcs=e.mcs, frame=frame)))
        idx.append(e)
    return out, idx


def _aids(c):
    """MAC → AID: AP — 0 (9.4.1.8); STA — из Association/Reassociation Response точки в захвате (иначе неизвестен —
    правила с AID её не опознают как участника); air.aids — явная подсказка {MAC: AID}."""
    aids = {c.ap: AID_AP_PCP}
    aids.update(getattr(c.air, 'aids', None) or {})      # подсказка вызывающего (тесты, известный AID)
    for e in c.evs:
        if e.kind in (E.ASSOC_RESP, E.REASSOC_RESP) and e.src == c.ap and e.body_ok and e.raw is not None:
            try:
                fx, _ = E.parse_body(e.kind, e.raw[24:])
            except (ValueError, KeyError, IndexError):
                continue
            if fx.get('status') == 0:
                aids[e.dst] = fx['aid'] & 0x3fff
    _aids_from_schedule(c, aids)
    return aids


AID_VOTE_MIN, AID_VOTE_SHARE = 3, 0.9     # вывод AID по SP пары с AP: кадров не меньше, доля одного MAC не ниже


def _aids_from_schedule(c, aids):
    """AID non-AP STA, ассоциация которой в захват не попала (запись начата позже), — по SP пары «AP — STA x» из
    Extended Schedule (9.4.2.131: Source/Destination AID; 10.39.6.2: в SP передают только источник и получатель):
    кадры между AP и STA x внутри блоков такого SP. AID x получает MAC, у которого в этих SP не меньше
    AID_VOTE_MIN кадров с AP и не меньше AID_VOTE_SHARE всех таких кадров, если этот MAC ещё не сопоставлен. Иначе
    AID остаётся неизвестен (правила с AID её не опознают). Выведенные — c.aids_inferred (в отчёт sp_access)."""
    c.aids_inferred = {}
    sched, bi_tu = _sched(c)
    known = set(aids.values())
    evs = sorted((e for e in c.k if e.src is not None), key=lambda e: e.t)
    ts = [e.t for e in evs]
    from bisect import bisect_left
    votes = defaultdict(Counter)
    for k, (b, ent, err, bs) in sched.items():
        if not ent:
            continue
        ref = BI.tbtt(k, bi_tu)
        for x in ent:
            a = x.alloc
            pair = {a.src_aid, a.dst_aid}
            if a.alloc_type != S.SP or AID_AP_PCP not in pair or len(pair) != 2 or AID_BROADCAST in pair:
                continue
            sta = (pair - {AID_AP_PCP}).pop()
            if sta in known:
                continue
            for t0, t1 in a.blocks(ref):
                for e in evs[bisect_left(ts, t0):bisect_left(ts, t1)]:
                    if e.src == c.ap and e.dst not in (None, BCAST):
                        votes[sta][e.dst] += 1
                    elif e.dst == c.ap and e.src != c.ap:
                        votes[sta][e.src] += 1
    taken = set(aids)
    for sta, cnt in sorted(votes.items()):
        mac, n = cnt.most_common(1)[0]
        if n >= AID_VOTE_MIN and n >= AID_VOTE_SHARE * sum(cnt.values()) and mac not in taken:
            aids[mac] = sta
            c.aids_inferred[mac] = sta
            taken.add(mac)


def _dti(c):
    """Результат sp.check_dti по каждому BI (кэш): {k: (нарушения, события журнала)}."""
    if getattr(c, '_dti', None) is not None:
        return c._dti
    sched, bi_tu = _sched(c)
    aids = _aids(c)
    out = {}
    for k, (b, ent, err, bs) in sched.items():
        if err is not None:
            continue
        log, idx = _log(c, k, bi_tu)
        if not log:
            continue
        J = _j()
        p0 = b.p
        params = BI.DmgParameters(p0.params.bss_type, p0.params.cbap_only, p0.params.cbap_source, p0.params.privacy,
                                  p0.params.ecapc)
        bti_end = bs[-1].te + (bs[-1].dur or 0)
        from . import air_wave5 as W5
        try:
            rec = W5.reclaimed_keys(c, k, bi_tu, aids)      # 10.39.6.7: SP между STA, которые AP может забрать
            v, wins, per = SPm.check_dti(log, k, bi_tu, ent or [], aids, c.ap, bti_end=bti_end, bic=J._bic(p0.bic),
                                         params=params, q=_q(), reclaimed=rec)
        except (ValueError, KeyError, AttributeError) as x:
            out[k] = (None, idx, str(x), [])
            continue
        out[k] = (v, idx, None, per)
    c._dti = out
    return out


def r_schedule(c):
    J = _j()
    r = J.Rule('schedule', '10.39.6.1', 'расписание DTI: Extended Schedule в DMG Beacon (поле Allocation, BF Control, '
               'DTI, перекрытия, guard time, CBAP Only — 9.4.2.131, 10.39.6.1–10.39.6.5), повтор внутри BI, '
               'псевдостатика')
    sched, bi_tu = _sched(c)
    if not sched:
        r.skip('нет DMG Beacon AP с телом и временем')
        return r
    kinds, should = Counter(), Counter()
    hist = {}
    for k, (b, ent, err, bs) in sorted(sched.items()):
        if err is not None:
            r.bad(b, f'Extended Schedule не разбирается: {err}')
            continue
        co = b.p.params.cbap_only
        if ent is None:
            kinds['CBAP Only = 1, ES нет' if co else 'ES нет, CBAP Only = 0 (DTI без распределений)'] += 1
            r.ok()
            continue
        kinds['Extended Schedule'] += 1
        hist[k] = ent
        params = BI.DmgParameters(b.p.params.bss_type, co, b.p.params.cbap_source, b.p.params.privacy,
                                  b.p.params.ecapc)
        bti_end = bs[-1].te + (bs[-1].dur or 0)
        vv = S.check(ent, k, bi_tu, bti_end=bti_end, bic=J._bic(b.p.bic), params=params, has_es_in_beacon=True)
        for rule, msg in vv:
            if rule.startswith('should_'):
                should[rule] += 1
            else:
                r.bad(b, f'{rule}: {msg}')
        r.ok()
        tr = [S.from_elements(x.p.elements) for x in bs if x.p is not None]
        for rule, msg in S.check_repeats([t for t in tr if t is not None]):
            r.bad(b, f'{rule}: {msg}')
    for rule, msg in S.check_history(hist, bi_tu):
        if rule.startswith('should_'):
            should[rule] += 1
        else:
            r.bad(None, f'{rule}: {msg}')
    r.info['by_bi'] = dict(kinds)
    if should:
        r.info['should_not_followed'] = dict(should)
    if not hist:
        r.skip('Extended Schedule в маяках нет — поле Allocation, guard time и перекрытия не проверяемы по этому '
               'захвату (расписание — CBAP Only)')
    return r


def _has_sp(c):
    sched, _ = _sched(c)
    return any(ent and any(e.alloc.alloc_type == S.SP for e in ent) for _, ent, _, _ in sched.values())


def r_sp_access(c):
    J = _j()
    r = J.Rule('sp_access', '10.39.6.2', 'доступ в SP по расписанию (источник начинает, только источник/получатель, '
               'конец SP, Heartbeat, BF, LP SC, PCP Active, усечение 10.39.8, продление 10.39.9, восстановление '
               '10.39.6.7) и в CBAP-распределениях расписания (10.39.5)')
    if not _has_sp(c):
        r.skip('в расписании нет SP: Extended Schedule в маяках нет (CBAP Only = 1) — правила SP не применимы')
        return r
    by = Counter()
    for k, (v, idx, err, per) in _dti(c).items():
        if err is not None:
            r.skip(f'BI {k}: журнал не разобран ({err})')
            continue
        ev = {i: e for i, e in enumerate(idx)}
        n_sp = sum(1 for e in idx if BI.period_at(per, e.t) is not None and BI.period_at(per, e.t).kind in
                   (S.SP, S.CBAP))
        # AP в SP между STA без условий 10.39.6.7 — правило sp_recovery (air_wave5)
        for x in v:
            if x.rule == 'sp_unseen_trigger':
                r.skip('первый кадр SP — Ack/BlockAck получателя на кадр источника, которого нет в захвате (данные не '
                       'записаны): начало SP источником и 10.39.6.7 по нему не проверяемы')
        bad = [x for x in v if not (x.rule.startswith('dyn_') or x.rule in ('grant_ack', 'should_grant_last_src',
                                                                            'sp_unseen_trigger')
                                    or (x.rule == 'sp_foreign' and '10.39.6.7' in x.msg))]
        for x in bad:
            by[x.rule] += 1
            r.bad(ev.get(x.idx), f'{x.rule}: {x.msg}')
        r.ok(max(0, n_sp - len(bad)))
    r.info['rules'] = dict(by)
    if getattr(c, 'aids_inferred', None):
        r.info['aid_inferred'] = {m: a for m, a in c.aids_inferred.items()}
        r.verdict_note = ('AID STA без ассоциации в захвате выведен по SP пары с AP в Extended Schedule (10.39.6.2: в SP '
                          'передают только источник и получатель): ' +
                          ', '.join(f'{m} → {a}' for m, a in c.aids_inferred.items()))
    return r


def r_dynalloc(c):
    J = _j()
    r = J.Rule('dynalloc', '10.39.7', 'динамическое распределение: PP (Poll, Response Offset, SPR), GP (Grant, '
               'Duration, одно выделение), Grant Ack (10.39.4), использование выделенного, Grant в CBAP')
    frames = [e for e in c.evs if e.kind in DYN_KINDS]
    if not frames:
        r.skip('кадров Poll/SPR/Grant/Grant Ack в захвате нет (динамическое распределение не использовалось) — '
               '10.39.7 по этому захвату не проверяемо')
        return r
    unk = [e for e in frames if not e.t_ok]
    if unk:
        r.skip('кадр динамического распределения без времени', len(unk))
    by = Counter()
    nf = defaultdict(int)
    for k, (v, idx, err, per) in _dti(c).items():
        if err is not None:
            r.skip(f'BI {k}: журнал не разобран ({err})')
            continue
        ev = {i: e for i, e in enumerate(idx)}
        nf[k] = sum(1 for e in idx if e.kind in DYN_KINDS)
        bad = [x for x in v if x.rule.startswith('dyn_') or x.rule in ('grant_ack', 'should_grant_last_src')]
        for x in bad:
            by[x.rule] += 1
            verdict = 'model' if x.rule.endswith(('9.3.1.10', '9.3.1.11', '_fig')) else 'ours'
            if x.rule.startswith('should_'):
                continue
            r.bad(ev.get(x.idx), f'{x.rule}: {x.msg}', verdict)
        r.ok(max(0, nf[k] - len(bad)))
    r.info['rules'] = dict(by)
    r.info['frames'] = dict(Counter(e.kind for e in frames))
    return r


RULES = (r_schedule, r_sp_access, r_dynalloc)
NOT_CHECKABLE = [
    ('grant_nav', '10.39.7.3', 'Grant с AID STA в Source/Destination AID не обновляет её NAV — NAV узла в записи не '
     'виден (модель — ref/nav)'),
    ('sp_rx_state', '10.39.6.2, 10.39.8.1', 'приёмное состояние / квази-омни получателя и PCP в SP, dot11MinPPDuration '
     'бодрствования (10.39.7.1) — по эфиру не наблюдаемо'),
]
