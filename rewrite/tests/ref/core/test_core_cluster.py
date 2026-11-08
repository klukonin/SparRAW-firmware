# SPDX-License-Identifier: AGPL-3.0-or-later
"""Этап 4, п. 4: децентрализованная кластеризация AP (10.40.1, 10.40.2.1) в ядре — две точки (S-AP и член) и по
станции, судьи (по журналу каждого BSS, TSF его точки) — 0 нарушений."""
import pytest

from .. import cluster as CL
from .. import fields as F
from .. import schedule as S
from ..timing import aMinChannelTime
from .conftest import fmt
from .judge_run import air, air_violations, bridge
from .scenario import ClusterNet


def _judge(n, RB):
    out = {}
    for ap, keep, foreign in ((n.ap, {'AP', 'STA1'}, {'AP2'}), (n.ap2, {'AP2', 'STA2'}, {'AP'})):
        j = n.journal.view(keep, foreign, shift=ap.tsf_off)
        c, rules = air(j, ap.addr)
        va = air_violations(rules)
        evs, found = bridge(n.journal.view(keep, (), shift=ap.tsf_off), ap.addr, RB, bi_tu=n.bi_tu)
        out[ap.name] = (c, rules, va, evs, found)
    return out


@pytest.fixture(scope='module')
def net(RB):
    n = ClusterNet(seed=1)
    assert n.run(max_us=3_000_000)
    return n, _judge(n, RB)


def test_member_joins_empty_beacon_sp(net):
    n, _ = net
    assert n.ap.cl.role == CL.ROLE_SAP and n.ap2.cl.role == CL.ROLE_MEMBER
    # 10.40.2.1: прослушивание aMinChannelTime без своих маяков, затем вход в пустой Beacon SP (n = 2)
    first2 = min(r.t for r in n.journal.recs if r.node == 'AP2')
    assert first2 >= aMinChannelTime
    off = CL.cluster_time_offset(n.ap2.cl.n - 1, n.bi_tu, n.ap.cl.maxmem)
    # TBTT S-AP — по Timestamp (целые мкс, 11.1.3.1): точность — доля мкс
    assert n.ap2.cl.n == 2 and abs(n.ap2.tsf_off + off) < 1
    # маяки каждой точки — в своём Beacon SP (по времени S-AP = время модели)
    for name, k in (('AP', 1), ('AP2', 2)):
        for r in (r for r in n.journal.recs if r.node == name and r.kind == 'DMG Beacon'):
            assert CL.beacon_sp_of(r.t, r.te, 0, n.bi_tu, n.ap.cl.maxmem, n.ap.cl.sp_field) == k


def test_clustering_control_fields(net):
    n, _ = net
    for name, role in (('AP', CL.ROLE_SAP), ('AP2', CL.ROLE_MEMBER)):
        r = next(r for r in n.journal.recs if r.node == name and r.kind == 'DMG Beacon')
        b = F.parse_dmg_beacon(r.mpdus[0], with_fcs=False)
        assert b.bic.cc_present and b.cc.member_role == role and b.cc.cluster_id == n.ap.addr
        assert b.cc.cluster_max_mem == n.ap.cl.maxmem and b.cc.beacon_sp_duration == n.ap.cl.sp_field
        assert not b.params.cbap_only and not b.params.ecapc
        # Extended Schedule: Beacon SP других AP кластера — SP 255→255 (10.40.2.1, PLAN №83)
        ent = S.from_elements(b.elements)
        sps = [e for e in ent if e.alloc.alloc_type == S.SP]
        assert len(sps) == n.ap.cl.maxmem - 1 and all(e.alloc.src_aid == e.alloc.dst_aid == 255 for e in sps)


def test_no_tx_in_foreign_beacon_sp(net):
    """10.40.2.1: S-AP и член «should not transmit … during a Beacon SP that is not its own»."""
    n, _ = net
    own = {'AP': 1, 'STA1': 1, 'AP2': 2, 'STA2': 2}
    for r in n.journal.recs:
        hit = CL.overlaps_beacon_sps(r.t, r.te, 0, n.bi_tu, n.ap.cl.maxmem, n.ap.cl.sp_field, skip={own[r.node]})
        assert not hit, (r, hit)


def test_judges_zero(net, RB):
    n, res = net
    for name, (c, rules, va, evs, found) in res.items():
        assert not va and not found, (name, fmt(c, va, evs, found, RB))
        st = {r.rid: r for r in rules}
        assert st['cluster'].checked > 0 and st['schedule'].checked > 0, name


def test_no_empty_sp_becomes_sap(RB):
    """ClusterMaxMem = 1: пустых Beacon SP нет — точка 2 становится S-AP своего кластера (10.40.2.1 «may», PLAN №90)."""
    n = ClusterNet(seed=2, maxmem=1, bytes_=20_000)
    n.run(max_us=1_600_000)
    assert n.ap2.cl.role == CL.ROLE_SAP and n.ap2.cl.cluster_id == n.ap2.addr
    assert any(w == 'cluster_sap' for _, w, _ in n.ap2.events)


def test_neg_member_outside_beacon_sp(RB, monkeypatch):
    """Член передаёт маяки не в своём Beacon SP (TBTT без ClusterTimeOffset) — судья cluster (10.40.2.1)."""
    n = ClusterNet(seed=1, bytes_=20_000)
    orig = n.ap2._cluster_begin_bi

    def wrong():
        if n.ap2.cl.role == CL.ROLE_MEMBER:
            n.ap2.tsf_off += 3000                  # маяки на 3 мс раньше начала Beacon SP_2
        orig()
    monkeypatch.setattr(n.ap2, '_cluster_begin_bi', wrong)
    n.run(max_us=1_600_000)
    res = _judge(n, RB)
    c, rules, va, evs, found = res['AP2']
    assert any(v.rule == 'cluster' for v in va), fmt(c, va, evs, found, RB)
