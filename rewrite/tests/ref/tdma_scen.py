# SPDX-License-Identifier: AGPL-3.0-or-later
"""Генератор сценариев DTI по расписанию для тестов эталона (schedule, sp, dynalloc) и судьи эфира (air_sched):
позитивный BI по стандарту (scenario) и негативные варианты (NEGATIVE: имя → (изменение, ожидаемое правило)).

Позитивный BI k = 0, BI = 100 TU, BHI до 2000 мкс (BTI/A-BFT/ATI не моделируются — расписание начинается после них):
  SP1  A → AP, Truncatable, Extendable: Data/Ack от A, продление SPR → Grant AP (+ Grant Ack, A поддерживает);
  SP2  broadcast/broadcast, Truncatable: PP (Poll A, Poll B → SPR), GP (Grant B, Grant A + Grant Ack), обмен A → B в
       выделенном;
  SP3  A → B, Beamforming Training = 1 (ISS TXSS, RSS RXSS), у B Heartbeat = 1: SSW ISS/RSS, RTS/DMG CTS, Data/Ack;
  CBAP A ↔ B: Data/Ack от A.
Генераторы — sp.sp_exchange / extension / truncation_*, dynalloc.pp / gp; расписание — schedule.plan."""
from fractions import Fraction as Fr

from . import bi as BI
from . import dynalloc as DA
from . import fields as F
from . import schedule as S
from . import sp as SPm
from .timing import ALLOC_SP, SIFS

AP, A, B, C = '02:00:00:00:00:00', '02:00:00:00:00:01', '02:00:00:00:00:02', '02:00:00:00:00:03'
AIDS = {AP: 0, A: 1, B: 2, C: 3}
MAC_OF = {v: k for k, v in AIDS.items()}
BI_TU, BHI_END = 100, 2000
BF_SP3 = F.BfControl(bt=1, is_init_txss=1, is_resp_txss=0)


def requests(sp2_truncatable=1, sp3_pcp_active=1, sp3_extendable=0):
    return [S.Req(S.SP, 1, 0, 3000, truncatable=1, extendable=1),
            S.Req(S.SP, 255, 255, 8000, truncatable=sp2_truncatable),
            S.Req(S.SP, 1, 2, 3000, bfc=BF_SP3, extendable=sp3_extendable),
            S.Req(S.CBAP, 1, 2, 2000)]


def scenario(sp2_truncatable=1, sp3_extendable=0, gp_dur=3000, ext=(500, 400)):
    """Позитивный BI: dict(events, entries, aids, ap, caps, pp_available, k, bi_tu, periods, window)."""
    ent = S.plan(0, BI_TU, BHI_END, requests(sp2_truncatable, sp3_extendable=sp3_extendable))
    per = BI.layout(0, BI_TU, BI.BiConfig(allocations=[e.alloc for e in ent]), None)
    sp1, sp2, sp3, cb = per
    evs = SPm.sp_exchange(sp1, A, AP, 3)
    if ext:
        evs += SPm.extension(evs[-1][1] + 3, A, AP, AP, sp1.end, ext[0], ext[1], grant_ack=True)
    pp, pe = DA.pp(sp2.start + 500, AP, [A, B])
    g, w = DA.gp(pe + SIFS, AP, [B, A], F.Dai(0, ALLOC_SP, 1, 2, gp_dur), grant_ack={A}, mac_of=MAC_OF)
    evs += pp + g
    evs += SPm.sp_exchange(BI.Period(S.SP, w.start + SIFS, w.end), A, B, 3)
    evs += SPm.sp_exchange(sp3, A, B, 3, heartbeat=True, bf=BF_SP3)
    evs += SPm.sp_exchange(cb, A, B, 2)
    return dict(events=sorted(evs, key=lambda e: (e[0], e[1])), entries=ent, aids=dict(AIDS), ap=AP,
                caps={A: {'grant_ack': 1}, B: {'grant_ack': 0, 'heartbeat': 1}, C: {}}, pp_available={}, k=0,
                bi_tu=BI_TU, periods=per, window=w)


def judge(sc):
    """sp.check_dti над сценарием → (нарушения, окна)."""
    v, w, _ = SPm.check_dti(sc['events'], sc['k'], sc['bi_tu'], sc['entries'], sc['aids'], sc['ap'], caps=sc['caps'],
                            pp_available=sc['pp_available'])
    return v, w


# ---------------------------------------------------------------------------------------- изменения
def _find(sc, kind, src=None, dst=None, n=0, after=None):
    hits = [i for i, e in enumerate(sc['events']) if e[4] == kind and (src is None or e[2] == src) and
            (dst is None or e[3] == dst) and (after is None or e[0] >= after)]
    return hits[n]


def _set(sc, i, **kw):
    e = list(sc['events'][i])
    info = dict(e[6]) if len(e) > 6 and e[6] else {}
    for k, v in kw.items():
        if k in ('ts', 'te'):
            continue
        if k == 'dur':
            e[5] = v
            if info.get('frame') is not None:
                info['frame'] = info['frame']._replace(duration=v)
        elif k == 'frame':
            info['frame'] = v
        else:
            info[k] = v
    if 'ts' in kw:
        d = Fr(kw['ts']) - e[0]
        e[0], e[1] = e[0] + d, e[1] + d
    e[6] = info
    sc['events'][i] = tuple(e)
    sc['events'].sort(key=lambda x: (x[0], x[1]))


def _add(sc, ev):
    sc['events'].append(ev)
    sc['events'].sort(key=lambda x: (x[0], x[1]))


def _del(sc, i):
    del sc['events'][i]


def _sp(sc, n):
    return sc['periods'][n]


def m_foreign(sc):
    p = _sp(sc, 0)
    _add(sc, SPm._ev(p.end - 200, 'Data', B, A, 200, 8))


def m_first_not_src(sc):
    # первый кадр SP3 — от получателя, источник начинает на 40 мкс позже
    p = _sp(sc, 2)
    for i, e in enumerate(sc['events']):
        if e[2] == A and p.start <= e[0] < p.start + 1:
            sc['events'][i] = (e[0] + 40, e[1] + 40) + e[2:]
    _add(sc, SPm._ev(p.start + Fr(1, 10), 'RTS', B, A, 20))


def m_heartbeat(sc):
    sc['caps'][AP] = {'heartbeat': 1}


def m_bf_missing(sc):
    for _ in range(2):
        _del(sc, _find(sc, 'SSW'))


def m_sp_end(sc):
    p = _sp(sc, 2)
    _add(sc, SPm._ev(p.end - 3, 'Data', A, B, 4000, 8))


def m_retx(sc):
    """Ack на Data SP3 потерян, источник повторяет через SIFS (< PIFS)."""
    i = _find(sc, 'Ack', src=B, dst=A, after=_sp(sc, 2).start)
    d = sc['events'][i - 1]
    _del(sc, i)
    j = _find(sc, 'Data', src=A, dst=B, after=d[1])
    _set(sc, j, ts=d[1] + SIFS)


def m_lp_sc(sc):
    i = _find(sc, 'Data', src=A, dst=AP)
    _set(sc, i, mcs=26)


def m_trunc_not_truncatable(sc):
    p = _sp(sc, 2)
    _add(sc, SPm._ev(p.end - 300, 'CF-End', A, AP, 20, dur=0))
    _add(sc, SPm._ev(p.end - 280, 'CF-End', A, B, 20, dur=0))


def m_ext_not_extendable(sc):
    p = _sp(sc, 2)
    for e in SPm.extension(p.end - 400, A, AP, B, p.end, 300, 0):
        _add(sc, e)


def m_poll_dur(sc):
    i = _find(sc, 'Poll')
    _set(sc, i, dur=sc['events'][i][5] + 4)


def m_poll_ro(sc):
    i = _find(sc, 'Poll', n=1)
    f = sc['events'][i][6]['frame']
    _set(sc, i, frame=f._replace(response_offset=f.response_offset + 7))


def m_spr_alt_time(sc):
    i = _find(sc, 'SPR', src=A, after=_sp(sc, 1).start)
    _set(sc, i, ts=sc['events'][i][0] + SIFS)


def m_spr_alt_dur(sc):
    i = _find(sc, 'SPR', src=A, after=_sp(sc, 1).start)
    _set(sc, i, dur=sc['events'][i][5] - 3)


def m_grant_same(sc):
    i = _find(sc, 'Grant', src=AP, after=_sp(sc, 1).start)
    f = sc['events'][i][6]['frame']
    _set(sc, i, frame=f._replace(dai=f.dai._replace(tid=5)))


def m_grant_dur(sc):
    i = _find(sc, 'Grant', src=AP, after=_sp(sc, 1).start)
    _set(sc, i, dur=sc['events'][i][5] + 6)


def m_grant_ack_missing(sc):
    _del(sc, _find(sc, 'Grant Ack', src=A, after=_sp(sc, 1).start))


def m_grant_ack_unsupported(sc):
    i = _find(sc, 'Grant', src=AP, dst=B, after=_sp(sc, 1).start)
    e = sc['events'][i]
    ga = F.GrantAck(0, AP, B, F.BfControl())
    _add(sc, (e[1] + SIFS, e[1] + SIFS + DA.T_GRANT_ACK, B, AP, 'Grant Ack', 0, dict(mcs=0, frame=ga)))


def m_dyn_use_foreign(sc):
    w = sc['window']
    _add(sc, SPm._ev(w.end - 300, 'Data', C, B, 200, 8))


def m_dyn_use_overrun(sc):
    w = sc['window']
    _add(sc, SPm._ev(w.end - 3, 'Data', A, B, 4000, 8))


def m_bcast_sp_sta(sc):
    p = _sp(sc, 1)
    _add(sc, SPm._ev(p.end - 300, 'Data', B, AP, 200, 8))


def m_pp_unavailable(sc):
    sc['pp_available'] = {B: 0}


def m_pp_in_individual_sp(sc):
    p = _sp(sc, 2)
    _add(sc, (p.end - 100, p.end - 100 + DA.T_POLL, AP, A, 'Poll', 0, dict(mcs=0, frame=F.Poll(0, A, AP, 3))))


def m_gp_start(sc):
    for i, e in enumerate(sc['events']):
        if e[4] in ('Grant', 'Grant Ack') and _sp(sc, 1).start <= e[0] < _sp(sc, 1).end and e[0] < sc['window'].start:
            sc['events'][i] = (e[0] + 6, e[1] + 6) + e[2:]


def m_grant_overlap(sc):
    for i, e in enumerate(sc['events']):
        if e[4] == 'Grant' and _sp(sc, 1).start <= e[0] < sc['window'].start:
            f = e[6]['frame']
            _set(sc, i, frame=f._replace(dai=f.dai._replace(alloc_duration=9000)))


def m_cbap_member(sc):
    p = _sp(sc, 3)
    _add(sc, SPm._ev(p.end - 300, 'Data', C, A, 200, 8))


def m_pcp_inactive(sc):
    sc['entries'][2].alloc.pcp_active = 0
    p = _sp(sc, 2)
    _add(sc, SPm._ev(p.end - 300, 'Data', A, AP, 200, 8))


def m_sp2_not_truncatable(sc):
    sc['entries'][1].alloc.truncatable = 0


# имя → (изменение сценария, правило, которое должно сработать)
NEGATIVE = {
    'foreign': (m_foreign, 'sp_foreign'),
    'first_not_src': (m_first_not_src, 'sp_first_src'),
    'heartbeat': (m_heartbeat, 'sp_heartbeat'),
    'bf_missing': (m_bf_missing, 'sp_bf'),
    'sp_end': (m_sp_end, 'sp_end'),
    'retx': (m_retx, 'sp_retx'),
    'lp_sc': (m_lp_sc, 'sp_lp_sc'),
    'trunc_not_truncatable': (m_trunc_not_truncatable, 'sp_trunc'),
    'ext_not_extendable': (m_ext_not_extendable, 'sp_ext'),
    'poll_dur': (m_poll_dur, 'dyn_poll_dur'),
    'poll_ro': (m_poll_ro, 'dyn_poll_ro'),
    'spr_alt_time': (m_spr_alt_time, 'dyn_spr_time_9.3.1.10'),
    'spr_alt_dur': (m_spr_alt_dur, 'dyn_spr_dur_9.3.1.11'),
    'grant_same': (m_grant_same, 'dyn_grant_same'),
    'grant_dur': (m_grant_dur, 'dyn_grant_dur'),
    'grant_ack_missing': (m_grant_ack_missing, 'grant_ack'),
    'grant_ack_unsupported': (m_grant_ack_unsupported, 'grant_ack'),
    'dyn_use_foreign': (m_dyn_use_foreign, 'dyn_use'),
    'dyn_use_overrun': (m_dyn_use_overrun, 'dyn_use'),
    'bcast_sp_sta': (m_bcast_sp_sta, 'dyn_bcast_sp_sta'),
    'pp_unavailable': (m_pp_unavailable, 'dyn_pp_unavail'),
    'pp_in_individual_sp': (m_pp_in_individual_sp, 'dyn_where'),
    'gp_start': (m_gp_start, 'dyn_gp_start'),
    'grant_overlap': (m_grant_overlap, 'dyn_grant_alloc'),
    'cbap_member': (m_cbap_member, 'cbap_member'),
    'pcp_inactive': (m_pcp_inactive, 'sp_pcp_inactive'),
    'sp2_not_truncatable': (m_sp2_not_truncatable, 'dyn_sp_truncatable'),
}


def negative(name):
    """Сценарий с нарушением name → (сценарий, ожидаемое правило)."""
    sc = scenario()
    f, rule = NEGATIVE[name]
    f(sc)
    return sc, rule
