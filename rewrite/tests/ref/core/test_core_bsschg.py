# SPDX-License-Identifier: AGPL-3.0-or-later
"""Этап 4, п. 5: смена канала по ECSA (11.8.8.6, MLME-EXTCHANNELSWITCH 6.3.35) и смена длительности BI (11.29.3) в
ядре — точка + станция с данными, судьи — 0 нарушений (при смене BI — по участкам до и после вступления: сетка BI судей
постоянна; ряд маяков — правило bss_params по всему журналу)."""
import pytest

from .. import chswitch as CS
from .. import elements as E
from ..timing import TU
from . import sap_mlme as ML
from .conftest import fmt, judge_all
from .judge_run import air, air_violations, bridge
from .scenario import AP_ADDR, Bss


def _ev(mac, *names):
    return [(t, w, kw) for t, w, kw in mac.events if w in names]


def _bss():
    b = Bss(seed=6, bf='dti', ul_bytes=1_500_000, dl_bytes=1_500_000).trickle(8, 6000)
    b.ap.ecs_activated = True
    b.run_bis(3)
    return b


@pytest.fixture(scope='module')
def ecsa_run(RB):
    b = _bss()
    b.ap.mlme_request(ML.MlmeExtChannelSwitchRequest(NewChannelNumber=3, ChannelSwitchCount=3))
    b.run_bis(9)
    c, rules, va, evs, found = judge_all(b, RB)
    assert not va and not found, fmt(c, va, evs, found, RB)
    return b, {r.rid: r for r in rules}


def test_ecsa_switch(ecsa_run):
    b, st = ecsa_run
    t_ap = [t for t, w, kw in _ev(b.ap, 'channel')]
    t_sta = [t for t, w, kw in _ev(b.sta, 'channel')]
    # объявление в BI 3 с Count 3 — смена перед TBTT BI 6 у обеих сторон (11.8.8.6)
    assert t_ap == [6 * 100 * TU] and t_sta and abs(t_sta[0] - t_ap[0]) < 2
    assert b.ap.channel == b.sta.channel == 3
    assert any(isinstance(p, ML.MlmeExtChannelSwitchIndication) for p in b.sta_sme.log)
    # ECSA в каждом маяке BI 3–5, Count 3, 2, 1
    counts = {}
    for r in b.journal.recs:
        if r.kind == 'DMG Beacon':
            from .. import fields as F
            bb = F.parse_dmg_beacon(r.mpdus[0], with_fcs=False)
            x = [CS.parse_ecsa(d) for eid, ext, d in bb.elements if eid == CS.EID_ECSA]
            counts.setdefault(int(r.t // (100 * TU)), set()).add(x[0].count if x else None)
    assert counts[3] == {3} and counts[4] == {2} and counts[5] == {1} and counts[6] == {None}
    # данные идут и после смены канала
    assert any(r.kind == 'A-MPDU' and r.t > 6 * 100 * TU for r in b.journal.recs)
    assert st['ecsa'].checked > 0


def test_ext_cap_ecs_bit(ecsa_run):
    """11.9.1: Extended Channel Switching = 1 в Extended Capabilities точки."""
    b, _ = ecsa_run
    r = next(r for r in b.journal.recs if r.kind == E.ASSOC_RESP)
    _, els = E.parse_body(E.ASSOC_RESP, r.mpdus[0][24:])
    assert any(e.eid == CS.EID_EXT_CAP and CS.ext_cap_bit(e.info, CS.EXT_CAP_ECS_BIT) for e in els)


def test_bi_change(RB):
    """11.29.3: dot11NbrOfChangeBeacons (5) TBTT с DMG BSS Parameter Change, на TBTT N+1 — новый BI и сброс TSF;
    станция следует (поле Beacon Interval, Timestamp), данные идут."""
    b = _bss()
    b.ap.request_bss_change(new_bi_tu=50)
    b.run_bis(11)
    eff = _ev(b.ap, 'bss_change_effective')
    assert eff and _ev(b.sta, 'bss_bi_change') and b.sta.bi_tu == 50
    t_eff = eff[0][0]
    assert t_eff == 3 * 100 * TU + 5 * 100 * TU               # 5 объявлений, затем вступление
    assert any(r.kind == 'A-MPDU' and r.t > t_eff for r in b.journal.recs)
    # ряд маяков — правило bss_params по всему журналу
    c, rules = air(b.journal, AP_ADDR)
    st = {r.rid: r for r in rules}
    assert st['bss_params'].checked > 0 and not st['bss_params'].viol, st['bss_params'].viol
    # участки до и после вступления — все судьи
    for v in (b.journal.view(t_to=t_eff), b.journal.view(t_from=t_eff, shift=b.ap.tsf_off, bi_tu=50)):
        c, rules = air(v, AP_ADDR)
        va = [x for x in air_violations(rules) if x.rule != 'bss_params']
        evs, found = bridge(v, AP_ADDR, RB)
        assert not va and not found, fmt(c, va, evs, found, RB)


def test_neg_ecsa_dropped_early(RB, monkeypatch):
    """Объявление оборвано до смены — судья ecsa (11.8.8.6: «until the intended channel switch time»)."""
    b = _bss()
    b.ap.mlme_request(ML.MlmeExtChannelSwitchRequest(NewChannelNumber=3, ChannelSwitchCount=4))
    orig = b.ap._ecsa_element
    monkeypatch.setattr(b.ap, '_ecsa_element', lambda k: orig(k) if k < 5 else None)
    b.run_bis(9)
    c, rules, va, evs, found = judge_all(b, RB)
    assert any(v.rule == 'ecsa' for v in va), fmt(c, va, evs, found, RB)
