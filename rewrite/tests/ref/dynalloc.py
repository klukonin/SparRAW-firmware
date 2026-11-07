# SPDX-License-Identifier: AGPL-3.0-or-later
"""Динамическое распределение SP (802.11-2020 10.39.7): Polling Period (10.39.7.2, ур. (10-18), Response Offset, SPR в
ответ на Poll), Grant Period (10.39.7.3: где начинается, Duration Grant, одинаковый Dynamic Allocation Info, «последний
Grant — источнику», начало выделения = PHY-TXEND Grant + Duration, без перекрытия с чужими SP), Grant Ack (10.39.4,
9.3.1.18), Grant в CBAP (9.3.1.12, 9.5.2 a)/b): уступка TXOP 10.39.7.3), Poll в ATI (10.39.3: Response Offset = 0),
использование выделенного (10.39.7.1 «shall not transmit longer than the time granted»; Allocation Duration = 0 — один
PPDU + ответ + одно RTS/DMG CTS, 9.5.2), поведение non-AP в SP broadcast/broadcast (9.4.2.131: только после Poll/Grant).

Состав:
  pp / gp / relinquish_grant / txop_relinquish_grant — генераторы эталонных последовательностей (кортежи журнала, как
    bi.check_air_log, с info = {mcs, frame: fields.Poll/Spr/Grant/GrantAck});
  Window — выделенное время (начало, конец, участники, тип), его дают Grant;
  check_dyn_log — судья журнала BI: список cbap.Violation и окна выделений (для sp.py/bi.Bss.dynamic).

Принятые трактовки — PLAN.md (№45–№49, №52): начало отсчёта Response Offset (10.39.7.2 против 9.3.1.10) и Duration
SPR, A_k и O_j в (10-18), начало GP после PP (текст против рис. 10-60), Duration последнего Grant GP, копирование AID в
Grant Ack (поля нет в рис. 9-57), Grant AP в SP с индивидуальным AID — не GP.

Не моделируется: STA Availability (9.4.2.132) как элемент — поле PP Available передаётся параметром pp_available;
D-BI/A-BI и doze (power save удалён); MMSL-кластеры; CMMG (Channel Band, CONTROL_TRAILER); NAV-исключение Grant
(10.39.7.3 «shall not update its NAV» — это ref/nav, по журналу эфира не наблюдаемо)."""
from fractions import Fraction as Fr

from . import duration as D
from . import fields as F
from .cbap import Violation
from .schedule import BF_NONE, CBAP, events, SP
from .timing import (AID_AP_PCP, AID_BROADCAST, ALLOC_CBAP, ALLOC_SP, BCAST, DOT11_MIN_PP_DURATION,
                     SBIFS, SBIFS_MAX, SIFS, SIFS_TOL)

T_POLL, T_SPR, T_GRANT, T_GRANT_ACK = D.tx('poll'), D.tx('spr'), D.tx('grant'), D.tx('grant_ack')
TYPE_OF_DAI = {ALLOC_SP: SP, ALLOC_CBAP: CBAP}


class Window:
    """Выделенное Grant время: [start, end) для участников members (MAC), kind — SP | CBAP (DAI AllocationType);
    zero — Allocation Duration = 0 (9.5.2: один PPDU + ответ + одно RTS/DMG CTS); everyone — CBAP broadcast (доступ
    всем); src — источник (начинает обмен)."""
    __slots__ = ('start', 'end', 'members', 'kind', 'zero', 'everyone', 'src', 'why')

    def __init__(self, start, end, members, kind=SP, zero=False, everyone=False, src=None, why=''):
        self.start, self.end, self.members, self.kind = Fr(start), Fr(end), set(members), kind
        self.zero, self.everyone, self.src, self.why = zero, everyone, src, why

    def has(self, t):
        return self.start <= Fr(t) < self.end

    def allows(self, mac):
        return self.everyone or mac in self.members

    def __repr__(self):
        return f'Window({self.kind} [{float(self.start)}, {float(self.end)}) {sorted(self.members)} {self.why})'


def _ev(ts, kind, src, dst, frame, length):
    t = Fr(ts)
    return (t, t + D.T.txtime_control(length), src, dst, kind, frame.duration, dict(mcs=0, frame=frame))


# ============================================================================================ генераторы
def pp(t0, ap, stas, ant_switch=None, order=None, dai_of=None, bfc=BF_NONE):
    """Эталонный PP (10.39.7.2): n индивидуальных Poll от AP подряд через SBIFS (+ A_k при смене антенны), Duration и
    Response Offset — duration.pp_schedule (ур. (10-18)); SPR каждого STA — через Response Offset от конца его Poll
    (PLAN.md №45), Duration SPR = Duration Poll − Response Offset − TXTIME(SPR) (10.39.7.2).
    stas — [MAC]; order — позиции j SPR (по умолчанию j = i); dai_of — {MAC: fields.Dai} запроса.
    Возвращает (события, конец PP = конец последнего Poll + его Response Offset + TXTIME(SPR) + SIFS)."""
    n = len(stas)
    a = list(ant_switch) if ant_switch is not None else [0] * n
    # СПОРНО → принято (PLAN.md №46): A_k в D_i,n — переключение антенны перед Poll_k (между k−1 и k), т. е. тот же
    # промежуток, что SBIFS слагаемого k; буквально «frame k and frame k+1» — сдвиг на один кадр (последний A_n — после
    # последнего Poll, где Poll нет). При одинаковом A_k оба чтения совпадают. a[i] — переключение после Poll i+1.
    sched = D.pp_schedule([T_POLL] * n, [T_SPR] * n, [0] + a[:-1])
    order = list(order) if order is not None else list(range(1, n + 1))
    if sorted(order) != list(range(1, n + 1)):
        raise ValueError('order — перестановка 1..n')
    out, t, ends = [], Fr(t0), []
    for i, sta in enumerate(stas):
        dur, ro_i = sched[i]
        # Response Offset_i = D_i,n + O_j(i): D_i,n = (значение при j = i) − O_i
        ro = ro_i - _o(i + 1) + _o(order[i])
        out.append(_ev(t, 'Poll', ap, sta, F.Poll(dur, sta, ap, int(ro)), F.FRAME_LEN['poll']))
        ends.append(t + T_POLL)
        t = t + T_POLL + SBIFS + a[i]
    for i, sta in enumerate(stas):
        f = out[i][6]['frame']
        dai = (dai_of or {}).get(sta) or F.Dai(0, ALLOC_SP, 0, AID_AP_PCP, 0)
        spr = F.Spr(D.duration_spr_response(f.duration, f.response_offset, T_SPR), ap, sta, dai, bfc)
        out.append(_ev(ends[i] + f.response_offset, 'SPR', sta, ap, spr, F.FRAME_LEN['spr']))
    lf = out[n - 1][6]['frame']
    return sorted(out, key=lambda e: e[0]), ends[n - 1] + lf.response_offset + T_SPR + SIFS


def _o(j, spr=T_SPR):
    """O_j (10.39.7.2): O_1 = SIFS; O_j = O_{j−1} + Ceil(TXTIME(SPR_j) + SIFS, T_TR) — SPR одной длины."""
    o = SIFS
    for _ in range(2, j + 1):
        o += D.ceil_to(spr + SIFS, D.aTSFResolution)
    return o


def gp(t0, ap, grants, dai, bfc=BF_NONE, grant_ack=(), mac_of=None):
    """Эталонный GP (10.39.7.3): Grant каждому RA из grants подряд, один Dynamic Allocation Info на всех; после Grant к
    STA с Grant Ack Supported = 1 (grant_ack) — Grant Ack через SIFS (10.39.4), следующий Grant AP — через SIFS после
    него, иначе через SBIFS (рис. 10-60). Duration Grant — остаток GP до начала выделения (все следующие Grant/Grant Ack
    и IFS), последнего — 0 или SIFS + TXTIME(Grant Ack) (PLAN.md №48). Начало выделения = PHY-TXEND Grant + Duration.
    mac_of — {AID: MAC} для участников окна. Возвращает (события, Window)."""
    seq, t = [], Fr(t0)
    for k, ra in enumerate(grants):
        seq.append(['Grant', t, ra])
        t += T_GRANT
        if ra in grant_ack:
            seq.append(['Grant Ack', t + SIFS, ra])
            t += SIFS + T_GRANT_ACK
        if k + 1 < len(grants):
            t += SIFS if ra in grant_ack else SBIFS
    out = []
    for x in seq:
        kind, ts, ra = x
        if kind == 'Grant':
            g = F.Grant(D.field(t - (ts + T_GRANT)), ra, ap, dai, bfc)
            out.append(_ev(ts, 'Grant', ap, ra, g, F.FRAME_LEN['grant']))
            last_dur = g.duration
        else:
            ga = F.GrantAck(D.duration_grant_ack(last_dur, T_GRANT_ACK), ap, ra, F.BfControl(bt=bfc.bt))
            out.append(_ev(ts, 'Grant Ack', ra, ap, ga, F.FRAME_LEN['grant_ack']))
    lg = [e for e in out if e[4] == 'Grant'][-1]
    start = lg[1] + lg[5]                             # 10.39.7.3: PHY-TXEND последнего Grant + его Duration
    m = mac_of or {}
    mem = {m.get(dai.src_aid), m.get(dai.dst_aid)} - {None}
    w = Window(start, start + dai.alloc_duration, mem, TYPE_OF_DAI.get(dai.alloc_type, SP),
               zero=dai.alloc_duration == 0, everyone=dai.alloc_type == ALLOC_CBAP and dai.src_aid == AID_BROADCAST,
               src=m.get(dai.src_aid), why='GP')
    return out, w


def relinquish_grant(t, holder, peer, holder_aid, peer_aid, remaining_end, kind=SP, bfc=BF_NONE):
    """Уступка остатка SP (10.39.6.2, 10.39.7.3) или TXOP (kind=CBAP): DAI Source AID = AID получателя, Destination
    AID = AID источника, AllocationType SP/CBAP, Allocation Duration = 32 768; Duration = остаток − TXTIME(Grant) −
    aSIFSTime (remaining_end — конец SP/TXOP)."""
    t = Fr(t)
    dai = F.Dai(0, ALLOC_SP if kind == SP else ALLOC_CBAP, peer_aid, holder_aid, F.ALLOC_DUR_SPECIAL)
    g = F.Grant(D.duration_grant_relinquish(Fr(remaining_end) - t, T_GRANT), peer, holder, dai, bfc)
    return _ev(t, 'Grant', holder, peer, g, F.FRAME_LEN['grant'])


# ============================================================================================ судья
def _period(periods, t):
    hit = [p for p in periods if p.start <= t < p.end]
    return hit[0] if hit else None


def _bcast_sp(p):
    return p is not None and p.kind == SP and p.src_aid == AID_BROADCAST and p.dst_aid == AID_BROADCAST


def _frame(r):
    return r.get('frame')


def check_dyn_log(evs, periods, aids, ap, caps=None, pp_available=None, relinquished=(), sifs_tol=SIFS_TOL, q=0,
                  ant_switch=0, windows=()):
    """Судья 10.39.7 / 10.39.4 (Grant Ack) / 10.39.3 (Poll в ATI) по журналу одного или нескольких BI.

    evs — кортежи журнала (schedule.events): Poll/SPR/Grant/Grant Ack с info['frame'] (fields.*) — без разбора кадра
      проверяются только времена; periods — bi.layout (периоды BI, SP/CBAP с alloc); aids — {MAC: AID}; ap — MAC
      AP/PCP; caps — {MAC: {'grant_ack': 0/1}} (DMG Capabilities, 9.4.2.127.2); pp_available — {MAC: 0/1} (STA
      Availability, 10.39.7.1); relinquished — [(start, end)] — время, возвращённое AP усечением SP (sp.py);
      q — допуск сравнения времени/Duration (квант меток захвата; 0 — эталонный журнал); ant_switch — A_k;
      windows — уже выделенное время (продления SP из sp.py: [Window]).
    Возвращает (нарушения, окна выделений [Window]).

    rule:
      'dyn_where'        — PP/GP не в SP broadcast/broadcast, не в CBAP с broadcast Destination AID, не во
                           времени после усечения SP, не в ATI (10.39.7.2, 10.39.7.3, 10.39.3) или во уже выделенном;
      'dyn_sp_truncatable' — PP/GP в SP broadcast/broadcast с Truncatable = 0 (10.39.7.1);
      'dyn_poll_ra'      — Poll не индивидуальный / не от AP (10.39.7.2, 9.3.1.10);
      'dyn_pp_unavail'   — Poll STA с PP Available = 0 (10.39.7.1);
      'dyn_poll_gap'     — промежуток Poll в PP ≠ SBIFS (+A_k) (10.39.7.2, рис. 10-60);
      'dyn_poll_dur'     — Duration Poll ≠ (10-18);
      'dyn_poll_ro'      — Response Offset ≠ D_i,n + O_j (10.39.7.2); в ATI — ≠ 0 (10.39.3);
      'dyn_spr_time'     — SPR не через Response Offset после конца Poll (10.39.7.2); 'dyn_spr_time_9.3.1.10' —
                           совпадает лишь с чтением 9.3.1.10 (+SIFS);
      'dyn_spr_dur'      — Duration SPR ≠ Duration Poll − Response Offset − TXTIME(SPR); 'dyn_spr_dur_9.3.1.11' —
                           совпадает лишь с чтением 9.3.1.11 (− SIFS);
      'dyn_spr_ra'       — SPR не к AP / не от опрошенного (9.3.1.11, 10.39.7.2);
      'dyn_pp_end'       — кадр PP/GP выходит за конец исходного SP/CBAP (10.39.7.2, 10.39.7.3);
      'dyn_gp_start'     — первый Grant GP после PP не через SIFS после конца PP (10.39.7.3); 'dyn_gp_start_fig' —
                           совпадает лишь с рис. 10-60 (SIFS после конца последнего SPR);
      'dyn_grant_same'   — Dynamic Allocation Info Grant одного GP различаются (10.39.7.3);
      'dyn_grant_dur'    — Duration Grant GP не покрывает остаток GP до начала выделения (10.39.7.3);
      'dyn_grant_alloc'  — Allocation Duration вне 0…32 767 (9.5.2) или выделение перекрывает SP с индивидуальным
                           Source/Destination AID (10.39.7.3);
      'should_grant_last_src' — последний Grant GP не источнику (10.39.7.3, «should»);
      'grant_ack'        — Grant Ack нет/лишний/не через SIFS/не к TA Grant/BT не скопирован/Duration (10.39.4,
                           9.3.1.18);
      'dyn_use'          — передача в выделенном не участником, после конца выделенного или сверх «одного PPDU»
                           при Allocation Duration = 0 (10.39.7.1, 9.5.2);
      'dyn_bcast_sp_sta' — non-AP передаёт в SP broadcast/broadcast не в ответ на Poll/Grant и не в выделенном
                           (9.4.2.131);
      'dyn_txop_grant'   — Grant уступки TXOP в CBAP: DAI (Source AID = ответчик, Destination AID = держатель, CBAP,
                           32 768) (10.39.7.3)."""
    ev = events(evs)
    out, wins = [], list(windows)
    caps = caps or {}
    pp_available = pp_available or {}
    mac_of = {a: m for m, a in aids.items()}
    mac_of.setdefault(AID_AP_PCP, ap)
    relq = [(Fr(s), Fr(e)) for s, e in relinquished]

    def v(r, rule, msg):
        out.append(Violation(r['i'], rule, msg))

    def ctx_ok(r, kind):
        """Где AP может начать PP/GP; → (ok, исходный период)."""
        t = r['ts']
        p = _period(periods, t)
        if any(s <= t < e for s, e in relq):
            return True, p
        if p is None:
            v(r, 'dyn_where', f'{kind} в {float(t)} вне периодов доступа')
            return False, p
        if p.kind == 'ATI':
            return True, p
        if any(w.has(t) and ap not in w.members and not w.everyone for w in wins):
            v(r, 'dyn_where', f'{kind} во времени, уже выделенном динамически')
            return False, p
        if _bcast_sp(p):
            if p.alloc is not None and not p.alloc.truncatable:
                v(r, 'dyn_sp_truncatable', f'{kind} в {p} с Truncatable = 0 (10.39.7.1)')
            return True, p
        if p.kind == CBAP and p.dst_aid == AID_BROADCAST:
            return True, p
        v(r, 'dyn_where', f'{kind} в {p}: не SP broadcast/broadcast, не CBAP с broadcast Destination AID, не '
                          f'возвращённое усечением время (10.39.7.2, 10.39.7.3)')
        return False, p

    def end_ok(r, p):
        if p is not None and p.kind in (SP, CBAP) and r['te'] > p.end + q:
            # 10.39.7.3: GP — до конца исходного SP/CBAP или следующего SP broadcast/broadcast, что позже
            nxt = [x for x in periods if _bcast_sp(x) and abs(x.start - p.end) <= q + 1000 and x.start >= p.end]
            lim = max([p.end] + [x.end for x in nxt]) if r['kind'] == 'Grant' else p.end
            if r['te'] > lim + q:
                v(r, 'dyn_pp_end', f'{r["kind"]} кончается в {float(r["te"])} > конца {p}')

    used = set()
    n = len(ev)
    j = 0
    pp_end_of = {}                                # индекс первого Grant GP → (конец PP по формуле, конец посл. SPR)
    while j < n:
        r = ev[j]
        if r['kind'] == 'Poll' and r['src'] == ap and j not in used:
            # ---------------- PP: Poll подряд через SBIFS
            polls = [j]
            k = j + 1
            while k < n and ev[k]['kind'] == 'Poll' and ev[k]['src'] == ap and \
                    ev[k]['ts'] - ev[polls[-1]]['te'] <= SBIFS_MAX + ant_switch + q:
                polls.append(k)
                k += 1
            used.update(polls)
            ok, p0 = ctx_ok(r, 'PP')
            in_ati = p0 is not None and p0.kind == 'ATI'
            ps = [ev[x] for x in polls]
            for a, b in zip(ps, ps[1:]):
                g = b['ts'] - a['te']
                if not SBIFS - q <= g <= SBIFS_MAX + ant_switch + q:
                    v(b, 'dyn_poll_gap', f'Poll через {float(g)} мкс ≠ SBIFS (10.39.7.2)')
            for x in ps:
                if x['dst'] == BCAST or x['dst'] is None:
                    v(x, 'dyn_poll_ra', 'Poll не индивидуальный (10.39.7.2: «individually addressed Poll»)')
                if pp_available.get(x['dst'], 1) == 0:
                    v(x, 'dyn_pp_unavail', f'Poll к {x["dst"]} с PP Available = 0 (10.39.7.1)')
                end_ok(x, p0)
            if not in_ati:
                txt = [x['te'] - x['ts'] for x in ps]
                sched = D.pp_schedule(txt, [T_SPR] * len(ps), [ant_switch] * len(ps))
            last_spr_end = None
            for i, x in enumerate(ps):
                f = _frame(x)
                if f is None:
                    continue
                if in_ati:
                    if f.response_offset != 0:
                        v(x, 'dyn_poll_ro', f'Poll в ATI: Response Offset {f.response_offset} ≠ 0 (10.39.3)')
                else:
                    want_d = sched[i][0]
                    if abs(x['dur'] - want_d) > q:
                        v(x, 'dyn_poll_dur', f'Duration Poll {x["dur"]} ≠ {want_d} (10-18)')
                    # Response Offset: D_i,n + O_j при некотором j (порядок SPR — выбор AP)
                    din = sched[i][1] - _o(i + 1)
                    cands = {din + _o(jj) for jj in range(1, len(ps) + 1)}
                    if not any(abs(f.response_offset - c) <= q for c in cands):
                        v(x, 'dyn_poll_ro', f'Response Offset {f.response_offset} ∉ D_i,n + O_j = '
                                            f'{sorted(int(c) for c in cands)} (10.39.7.2)')
                # SPR опрошенного
                sp_ = [y for y in ev[k:k + 4 * len(ps) + 4]
                       if y['kind'] == 'SPR' and y['src'] == x['dst'] and y['ts'] >= x['te']]
                if not sp_:
                    continue
                y = sp_[0]
                used.add(ev.index(y))
                if y['dst'] != ap:
                    v(y, 'dyn_spr_ra', f'SPR от {y["src"]} адресован {y["dst"]}, не AP (9.3.1.11)')
                base = x['te'] + (SIFS if in_ati else f.response_offset)
                g = y['ts'] - base
                if not -q <= g <= sifs_tol + q:
                    alt = y['ts'] - (x['te'] + f.response_offset + SIFS)
                    if not in_ati and -q <= alt <= sifs_tol + q:
                        v(y, 'dyn_spr_time_9.3.1.10', f'SPR через RO + SIFS после Poll (чтение 9.3.1.10, PLAN.md №45)')
                    else:
                        v(y, 'dyn_spr_time', f'SPR в {float(y["ts"])} ≠ конец Poll + '
                                             f'{"SIFS (ATI)" if in_ati else "Response Offset"} = {float(base)}')
                yf = _frame(y)
                if y['dur'] is not None and not in_ati:
                    t_spr = y['te'] - y['ts']
                    a1 = D.duration_spr_response(x['dur'], f.response_offset, t_spr, '10.39.7.2')
                    a2 = D.duration_spr_response(x['dur'], f.response_offset, t_spr, '9.3.1.11')
                    if abs(y['dur'] - a1) > q:
                        if abs(y['dur'] - a2) <= q:
                            v(y, 'dyn_spr_dur_9.3.1.11', f'Duration SPR {y["dur"]} = {a2} по 9.3.1.11 (− SIFS), по '
                                                         f'10.39.7.2 — {a1} (PLAN.md №45)')
                        else:
                            v(y, 'dyn_spr_dur', f'Duration SPR {y["dur"]} ≠ {a1} (10.39.7.2)')
                if yf is not None:
                    out.extend(Violation(y['i'], 'dyn_spr_fields', m)
                               for m in F.check_dai(yf.dai, frame='spr'))
                last_spr_end = y['te'] if last_spr_end is None else max(last_spr_end, y['te'])
            if not in_ati and ps and _frame(ps[-1]) is not None:
                lf = _frame(ps[-1])
                pe = ps[-1]['te'] + lf.response_offset + T_SPR + SIFS
                # первый Grant после PP
                for kk in range(k, min(n, k + 4 * len(ps) + 6)):
                    if ev[kk]['kind'] == 'Grant' and ev[kk]['src'] == ap:
                        pp_end_of[kk] = (pe, last_spr_end)
                        break
                    if ev[kk]['kind'] not in ('SPR',):
                        break
            j = k
            continue
        if r['kind'] == 'Grant' and r['src'] == ap and j not in used and \
                not (_in_sp_individual(periods, r) and not any(s <= r['ts'] < e for s, e in relq)):
            # ---------------- GP: Grant AP подряд (с Grant Ack между ними)
            gs = [j]
            k = j + 1
            while k < n:
                y = ev[k]
                if y['kind'] == 'Grant Ack':
                    k += 1
                    continue
                if y['kind'] == 'Grant' and y['src'] == ap and y['ts'] - ev[k - 1]['te'] <= SIFS + sifs_tol + q:
                    gs.append(k)
                    k += 1
                    continue
                break
            used.update(gs)
            g0 = ev[j]
            if j in pp_end_of:
                pe, lse = pp_end_of[j]
                want = pe + SIFS
                if abs(g0['ts'] - want) > sifs_tol + q:
                    if lse is not None and -q <= g0['ts'] - (lse + SIFS) <= sifs_tol + q:
                        v(g0, 'dyn_gp_start_fig', 'первый Grant через SIFS после последнего SPR (рис. 10-60), по '
                                                  'тексту — SIFS после конца PP (PLAN.md №47)')
                    else:
                        v(g0, 'dyn_gp_start', f'первый Grant в {float(g0["ts"])} ≠ конец PP + SIFS = {float(want)} '
                                              f'(10.39.7.3)')
                p0 = _period(periods, g0['ts'])
            else:
                ok, p0 = ctx_ok(g0, 'GP')
            frs = [_frame(ev[x]) for x in gs]
            for x in gs:
                end_ok(ev[x], p0)
            if all(f is not None for f in frs):
                if len({f.dai for f in frs}) > 1:
                    v(ev[gs[-1]], 'dyn_grant_same', 'Dynamic Allocation Info Grant одного GP различаются (10.39.7.3)')
                dai = frs[-1].dai
                in_ati = p0 is not None and p0.kind == 'ATI'
                for x, f in zip(gs, frs):
                    out.extend(Violation(ev[x]['i'], 'dyn_grant_alloc', m)
                               for m in F.check_dai(f.dai, frame='grant', grant_ctx='ati_gp'))
                last = ev[gs[-1]]
                # начало выделения — PHY-TXEND последнего Grant + его Duration; все Grant — к одной точке
                start = last['te'] + (last['dur'] or 0)
                for x in gs[:-1]:
                    y = ev[x]
                    if y['dur'] is not None and abs(y['te'] + y['dur'] - start) > 1 + q:
                        v(y, 'dyn_grant_dur', f'Duration Grant {y["dur"]}: начало выделения {float(y["te"] + y["dur"])}'
                                              f' ≠ {float(start)} по последнему Grant GP (10.39.7.3)')
                ga = [y for y in ev[gs[-1] + 1:gs[-1] + 2] if y['kind'] == 'Grant Ack']
                if last['dur'] is not None:
                    if ga:
                        need = ga[0]['te'] - last['te']
                        if last['dur'] + q < D.field(need) - 1:
                            v(last, 'dyn_grant_dur', f'Duration последнего Grant {last["dur"]} не покрывает Grant Ack '
                                                     f'({float(need)} мкс) (10.39.7.3)')
                    elif not (last['dur'] <= q or SIFS - q <= last['dur'] <= SIFS + sifs_tol + 1 + q):
                        v(last, 'dyn_grant_dur', f'Duration последнего Grant {last["dur"]} ∉ {{0, SIFS}} — после него '
                                                 f'кадров GP нет (10.39.7.3, PLAN.md №48)')
                src_mac = mac_of.get(dai.src_aid)
                if dai.src_aid not in (AID_AP_PCP, AID_BROADCAST) and src_mac is not None and \
                        last['dst'] != src_mac and not in_ati:
                    v(last, 'should_grant_last_src', f'последний Grant GP к {last["dst"]}, не к источнику {src_mac} '
                                                     f'(10.39.7.3, «should»)')
                w = Window(start, start + dai.alloc_duration,
                           {mac_of.get(dai.src_aid), mac_of.get(dai.dst_aid)} - {None},
                           TYPE_OF_DAI.get(dai.alloc_type, SP), zero=dai.alloc_duration == 0,
                           everyone=dai.alloc_type == ALLOC_CBAP and dai.src_aid == AID_BROADCAST,
                           src=src_mac, why='GP')
                # 10.39.7.3: выделение не перекрывает другой SP с индивидуальным Source или Destination AID (свой
                # SP — тот, в возвращённом времени которого идёт GP, — не «another SP»)
                for p in periods:
                    if p is _period(periods, last['ts']):
                        continue
                    if p.kind == SP and not (p.src_aid == AID_BROADCAST and p.dst_aid == AID_BROADCAST) and \
                            p.start < w.end and w.start < p.end and not w.zero:
                        v(last, 'dyn_grant_alloc', f'выделение [{float(w.start)}, {float(w.end)}) перекрывает {p} '
                                                   f'(10.39.7.3)')
                wins.append(w)
            j = k
            continue
        j += 1

    # ---------------- Grant Ack (10.39.4, 9.3.1.18) — для всех Grant
    for j, r in enumerate(ev):
        if r['kind'] != 'Grant':
            continue
        nx = ev[j + 1] if j + 1 < n else None
        group = r['dst'] in (BCAST, None)
        is_ga = nx is not None and nx['kind'] == 'Grant Ack' and (nx['src'] == r['dst'] or group) and \
            nx['ts'] - r['te'] <= SIFS + sifs_tol + q + 20
        sup = caps.get(r['dst'], {}).get('grant_ack')
        if group and is_ga:
            v(nx, 'grant_ack', 'Grant Ack на групповой Grant (10.39.4)')
            continue
        if not group and sup == 1 and not is_ga:
            v(r, 'grant_ack', f'нет Grant Ack от {r["dst"]} (Grant Ack Supported = 1, 10.39.4)')
            continue
        if not group and sup == 0 and is_ga:
            v(nx, 'grant_ack', f'Grant Ack от {r["dst"]} при Grant Ack Supported = 0 (10.39.4)')
            continue
        if not is_ga:
            continue
        g = nx['ts'] - r['te']
        if not SIFS - q <= g <= SIFS + sifs_tol + q:
            v(nx, 'grant_ack', f'Grant Ack через {float(g)} мкс ≠ SIFS (10.39.4)')
        if nx['dst'] != r['src']:
            v(nx, 'grant_ack', 'RA Grant Ack ≠ Address 2 (TA) Grant (9.3.1.18)')
        fg, fa = _frame(r), _frame(nx)
        if fg is not None and fa is not None:
            if fa.bfc.bt != fg.bfc.bt:
                v(nx, 'grant_ack', 'Beamforming Training не скопирован из Grant (10.39.4)')
            out.extend(Violation(nx['i'], 'grant_ack', m)
                       for m in F.check_bf_control(fa.bfc, frame='grant_ack', grant_bt=fg.bfc.bt))
        if r['dur'] is not None and nx['dur'] is not None:
            want = D.duration_grant_ack(r['dur'], nx['te'] - nx['ts'])
            if abs(nx['dur'] - want) > q:
                v(nx, 'grant_ack', f'Duration Grant Ack {nx["dur"]} ≠ {want} (9.3.1.18)')

    # ---------------- уступка TXOP в CBAP (10.39.7.3) и Grant non-AP в CBAP
    for j, r in enumerate(ev):
        if r['kind'] != 'Grant' or r['src'] == ap and j in used:
            continue
        p = _period(periods, r['ts'])
        f = _frame(r)
        if p is None or p.kind != CBAP or f is None or r['dst'] in (BCAST, None):
            continue
        if f.dai.alloc_duration == F.ALLOC_DUR_SPECIAL:
            exp = (aids.get(r['dst']), aids.get(r['src']), ALLOC_CBAP)
            got = (f.dai.src_aid, f.dai.dst_aid, f.dai.alloc_type)
            if None not in exp and got != exp:
                v(r, 'dyn_txop_grant', f'Grant уступки TXOP: (Source AID, Destination AID, AllocationType) = {got} ≠ '
                                       f'{exp} (10.39.7.3)')
            # остаток TXOP — ответчику (роли меняются при BT = 0)
            nav = [y['te'] + y['dur'] for y in ev[:j] if y['src'] == r['src'] and y['dur'] and
                   r['ts'] - y['te'] < 5000]
            end = max(nav) if nav else r['te'] + (r['dur'] or 0) + SIFS
            wins.append(Window(r['te'], end, {r['src'], r['dst']}, CBAP, src=r['dst'], why='TXOP'))

    # ---------------- использование выделенного (10.39.7.1, 9.5.2) и SP broadcast/broadcast (9.4.2.131)
    for w in wins:
        inside = [r for r in ev if w.start - q <= r['ts'] < w.end + (1 if w.zero else 0)]
        if w.zero:
            # 9.5.2: «one PPDU followed by any relevant acknowledgment plus one RTS/DMG CTS handshake»
            ppdus = [r for r in ev if r['ts'] >= w.start - q and r['src'] == w.src and
                     r['kind'] not in ('RTS',)][:3]
            data = [r for r in ppdus if r['ts'] < w.start + 3000]
            if len([r for r in data if r['kind'] not in ('Grant', 'Poll')]) > 1:
                gaps_ok = all(data[i + 1]['ts'] - data[i]['te'] > 0 for i in range(len(data) - 1))
                if gaps_ok and data[1]['ts'] - data[0]['te'] <= SIFS + sifs_tol + q + 200:
                    v(data[1], 'dyn_use', 'Allocation Duration = 0: больше одного PPDU источника (9.5.2)')
            continue
        for r in inside:
            if r['kind'] in ('Poll', 'Grant', 'Grant Ack', 'SPR') and r['src'] == ap:
                continue
            if not w.allows(r['src']):
                if _is_response(ev, r, sifs_tol, q):
                    continue
                v(r, 'dyn_use', f'{r["kind"]} от {r["src"]} в выделенном {w} — не участник (10.39.7.1)')
            elif r['te'] > w.end + q:
                v(r, 'dyn_use', f'{r["kind"]} кончается в {float(r["te"])} > конца выделенного {float(w.end)} '
                                f'(10.39.7.1: «shall not transmit longer than the time granted»)')
    for j, r in enumerate(ev):
        p = _period(periods, r['ts'])
        if not _bcast_sp(p) or r['src'] == ap:
            continue
        if any(w.has(r['ts']) and w.allows(r['src']) for w in wins):
            continue
        if r['kind'] == 'SPR' and j in used:
            continue                                  # ответ на Poll
        if r['kind'] == 'Grant Ack' or _is_response(ev, r, sifs_tol, q):
            continue
        v(r, 'dyn_bcast_sp_sta', f'{r["kind"]} от {r["src"]} в {p} без Poll/Grant (9.4.2.131)')
    out.sort(key=lambda x: x.idx)
    return out, wins


def _is_response(ev, r, sifs_tol, q):
    """r — ответ через SIFS на кадр, адресованный передатчику r."""
    prev = [y for y in ev if y['te'] <= r['ts'] + q and y is not r]
    if not prev:
        return False
    p = max(prev, key=lambda y: y['te'])
    return p['dst'] == r['src'] and SIFS - q <= r['ts'] - p['te'] <= SIFS + sifs_tol + q


def _in_sp_individual(periods, r):
    """Grant AP в SP с индивидуальным AID: продление 10.39.9 / уступка / чужая передача — правила sp.py, не GP (GP —
    только в SP broadcast/broadcast, CBAP, ATI и во времени, возвращённом усечением)."""
    p = _period(periods, r['ts'])
    return p is not None and p.kind == SP and not (p.src_aid == AID_BROADCAST and p.dst_aid == AID_BROADCAST)


def min_pp_awake(sp_start):
    """10.39.7.1: STA, участвующая в динамическом распределении, бодрствует dot11MinPPDuration от начала каждого
    усекаемого SP broadcast/broadcast и каждого CBAP; 10.39.7.3: может заснуть, если Grant нет за это время. → момент,
    до которого STA обязана слушать."""
    return Fr(sp_start) + DOT11_MIN_PP_DURATION

