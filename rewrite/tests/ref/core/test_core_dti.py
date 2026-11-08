# SPDX-License-Identifier: AGPL-3.0-or-later
"""Этап 4, п. 2: расписание DTI в ядре — Extended Schedule точки, SP (источник, получатель), PP/GP, продление,
усечение, восстановление SP, CBAP-распределения; точка + станции в идеальной среде, судьи — 0 нарушений."""
import pytest

from .. import bi as BI
from .. import schedule as S
from ..timing import AID_AP_PCP, AID_BROADCAST, TU
from .conftest import fmt, judge_all
from .dti import policy_cbap_split, policy_sp
from .scenario import Bss

BI_TU = 20


def _ev(mac, *names):
    return [(t, w, kw) for t, w, kw in mac.events if w in names]


def _bss(policy, n_sta=1, ul=3_000_000, dl=3_000_000, seed=4):
    b = Bss(seed=seed, n_sta=n_sta, bi_tu=BI_TU, bf='dti', ul_bytes=ul, dl_bytes=dl)
    b.ap.sched_policy = policy
    return b


def _judge(b, RB):
    c, rules, va, evs, found = judge_all(b, RB)
    assert not va and not found, fmt(c, va, evs, found, RB)
    return {r.rid: r for r in rules}


# ===================================================================================================== юниты
def test_policy_sp_entries_valid():
    """Расписание политики «SP на станцию» — по schedule.check (9.4.2.131, 10.39.6.1–10.39.6.5): guard time,
    aDMGPPMinListeningTime между SP с общей STA, не за TBTT."""
    class M:
        bi_tu = BI_TU

        def assoc_aids(self):
            return [1, 2]
    m = M()
    pol = policy_sp(ul_us=2000, dl_us=2000, dyn_us=4000, cbap_first_us=2000)
    from .dti import DtiMixin
    m.sched_policy = pol
    ent = DtiMixin._dti_entries(m, 5, BI.tbtt(5, BI_TU) + 4000)
    kinds = [(e.alloc.alloc_type, e.alloc.src_aid, e.alloc.dst_aid) for e in ent]
    assert kinds[0] == (S.CBAP, AID_BROADCAST, AID_BROADCAST)
    assert (S.SP, 1, AID_AP_PCP) in kinds and (S.SP, AID_AP_PCP, 2) in kinds
    assert (S.SP, AID_BROADCAST, AID_BROADCAST) in kinds and kinds[-1][0] == S.CBAP
    vv = [x for x in S.check(ent, 5, BI_TU, bti_end=BI.tbtt(5, BI_TU) + 1000) if not x[0].startswith('should_')]
    assert not vv, vv
    assert ent[-1].alloc.blocks(BI.tbtt(5, BI_TU))[-1][1] <= BI.tbtt(6, BI_TU)


def test_policy_cbap_split_like_fw():
    """Простой TDMA (как прошивка open): общее CBAP, затем CBAP {STA → AP} поровну; одна станция — CBAP Only."""
    class M:
        bi_tu = BI_TU
        aids = [1]

        def assoc_aids(self):
            return self.aids
    m = M()
    m.sched_policy = policy_cbap_split()
    from .dti import DtiMixin
    assert DtiMixin._dti_entries(m, 3, BI.tbtt(3, BI_TU) + 1500) is None
    m.aids = [1, 2]
    ent = DtiMixin._dti_entries(m, 3, BI.tbtt(3, BI_TU) + 1500)
    assert [(e.alloc.src_aid, e.alloc.dst_aid) for e in ent] == [(255, 255), (1, 0), (2, 0)]
    assert ent[1].alloc.block_dur == ent[2].alloc.block_dur and all(e.alloc.pseudo_static for e in ent)


# ===================================================================================================== SP
@pytest.fixture(scope='module')
def sp_run(RB):
    b = _bss(policy_sp(ul_us=3000, dl_us=3000, cbap_rest=False, cbap_first_us=2000))
    b.run(max_bis=30)
    b.run_bis(b.sim.now // (BI_TU * TU) + 2)              # и ещё BI: SP без данных — усечение
    return b, _judge(b, RB)


def test_sp_exchanges(sp_run):
    b, st = sp_run
    assert b.done()
    # SP по расписанию: источник начинает в начале SP (10.39.6.2) — без RTS; A-MPDU + BlockAck
    sps = [kw for t, w, kw in _ev(b.ap, 'sp_start')] + [kw for t, w, kw in _ev(b.sta, 'sp_start')]
    assert len(sps) >= 3
    k, periods = b.ap.dti_log[-1]
    ul = [p for p in periods if p.kind == S.SP and p.src_aid == b.sta.aid]
    dl = [p for p in periods if p.kind == S.SP and p.dst_aid == b.sta.aid]
    assert ul and dl
    in_sp = [r for r in b.journal.recs if r.kind == 'A-MPDU' and any(p.start <= r.t < p.end for p in ul + dl)]
    rts_in_sp = [r for r in b.journal.recs if r.kind == 'RTS' and any(p.start <= r.t < p.end for p in ul + dl)]
    assert not rts_in_sp
    # очередь пуста — усечение Truncatable SP (10.39.8.1): CF-End к AP (пир — AP)
    assert _ev(b.sta, 'sp_truncate')
    assert st['sp_access'].checked > 0 and st['schedule'].checked > 0
    del in_sp


def test_sp_end_respected(sp_run):
    """10.39.6.2: «In no case … beyond the end» — ни один кадр пары SP не кончается после конца SP."""
    b, _ = sp_run
    for k, periods in b.ap.dti_log:
        for p in periods:
            if p.kind != S.SP:
                continue
            frames = [r for r in b.journal.recs if p.start <= r.t < p.end and r.kind != 'DMG Beacon']
            assert all(r.te <= p.end for r in frames), p


# ===================================================================================================== PP/GP
@pytest.fixture(scope='module')
def gp_run(RB):
    b = _bss(policy_sp(ul_us=0, dl_us=3000, dyn_us=8000, cbap_rest=False, cbap_first_us=2000), n_sta=2,
             ul=6_000_000)
    b.run(max_bis=30)
    return b, _judge(b, RB)


def test_pp_gp_executes(gp_run):
    b, st = gp_run
    assert b.done()
    k = b.journal.kinds()
    assert k['Poll'] >= 2 and k['SPR'] >= 2 and k['Grant'] >= 2
    grants = _ev(b.ap, 'gp_grant')
    assert {kw['sta'] for _, _, kw in grants} == {s.addr for s in b.stas}
    # станция передаёт в выделенном окне (начало — PHY-TXEND Grant + Duration, 10.39.7.3)
    for s in b.stas:
        g = _ev(s, 'grant_rx')
        assert g and _ev(s, 'sp_start')
    assert st['dynalloc'].checked > 0 and not st['dynalloc'].viol


# ===================================================================================================== продление
def test_sp_extension(RB):
    """10.39.9: SPR в Extendable SP, следующий SP — broadcast/broadcast длиннее запрошенного → Grant точки; продлённый
    конец соблюдается."""
    b = _bss(policy_sp(ul_us=2000, dl_us=0, dyn_us=8000, cbap_rest=False, cbap_first_us=2000, extendable=1),
             ul=12_000_000)
    b.run_bis(14)
    req, ext = _ev(b.sta, 'sp_extend_request'), _ev(b.sta, 'sp_extended')
    assert req and ext and _ev(b.ap, 'sp_extend_reply')
    st = _judge(b, RB)
    assert st['sp_access'].checked > 0


# ===================================================================================================== восстановление
def test_sp_recovery(RB):
    """10.39.6.7: станция не приняла Extended Schedule BI (маяки BTI затенены) и молчит в своём SP; точка-получатель
    Truncatable SP через dot11SPIdleTimeout отдаёт остаток источнику Grant-ом (10.39.7)."""
    b = _bss(policy_sp(ul_us=3000, dl_us=0, cbap_rest=False, cbap_first_us=2000), ul=12_000_000, dl=1_000_000)
    k = 12
    b.medium.block('AP', 'STA', k * BI_TU * TU, k * BI_TU * TU + 1500)
    b.run_bis(16)
    rec = _ev(b.ap, 'sp_recovery')
    assert rec and k * BI_TU * TU < rec[0][0] < (k + 1) * BI_TU * TU
    assert any(t >= rec[0][0] for t, _, _ in _ev(b.sta, 'grant_rx'))
    _judge(b, RB)


# ===================================================================================================== CBAP-распределения
def test_cbap_split_two_sta(RB):
    """CBAP {Source = STA i, Destination = AP}: начинать обмен в окне могут только STA i и точка (10.39.5)."""
    b = _bss(policy_cbap_split(), n_sta=2)
    b.run(max_bis=30)
    assert b.done()
    k, periods = b.ap.dti_log[-1]
    mine = {s.aid: s for s in b.stas}
    for p in periods:
        if p.kind == S.CBAP and p.src_aid in mine:
            other = [s for a, s in mine.items() if a != p.src_aid][0]
            starts = [r for r in b.journal.recs if p.start <= r.t < p.end and r.node == other.name and
                      r.kind in ('RTS', 'Action', 'A-MPDU')]
            assert not starts
    st = _judge(b, RB)
    assert st['schedule'].checked > 0


# ===================================================================================================== негативные
def test_neg_foreign_sp_caught(RB, monkeypatch):
    """Станция передаёт в чужом SP — судья sp_access (10.39.6.2)."""
    b = _bss(policy_sp(ul_us=3000, dl_us=0, cbap_rest=False, cbap_first_us=2000), n_sta=2, ul=6_000_000)
    s2 = b.stas[1]
    orig = s2._dti_apply

    def greedy(k, periods, margin=0):
        aid = s2.my_aid()
        if aid:
            periods = [BI.Period(p.kind, p.start, p.end, p.alloc, aid if p.kind == S.SP and p.dst_aid == 0 else
                                 p.src_aid, p.dst_aid, p.cbap_only) for p in periods]
        return orig(k, periods, margin)
    monkeypatch.setattr(s2, '_dti_apply', greedy)
    b.run_bis(10)
    c, rules, va, evs, found = judge_all(b, RB)
    assert any(v.rule == 'sp_access' and 'sp_foreign' in v.msg for v in va), fmt(c, va, evs, found, RB)


def test_neg_sp_overrun_caught(RB, monkeypatch):
    """Обмен источника за концом SP — судья sp_access (10.39.6.2 «In no case …»)."""
    b = _bss(policy_sp(ul_us=3000, dl_us=0, cbap_rest=False, cbap_first_us=2000), ul=12_000_000)
    orig = b.sta._sp_run
    monkeypatch.setattr(b.sta, '_sp_run', lambda peer, end, alloc, why='SP': orig(peer, end + 600, alloc, why))
    b.run_bis(10)
    c, rules, va, evs, found = judge_all(b, RB)
    assert any(v.rule == 'sp_access' and 'sp_end' in v.msg for v in va), fmt(c, va, evs, found, RB)
