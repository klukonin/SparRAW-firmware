# SPDX-License-Identifier: AGPL-3.0-or-later
"""DMG TSPEC (9.4.2.133 [p. 1251–1253]), DMG ADDTS (9.6.3.1–9.6.3.3 [p. 1447–1451]), DELTS (9.6.3.4), 11.4 для DMG
(11.4.1, 11.4.4.4, 11.4.9.2, 11.4.13)."""
import pytest

from . import elements as E
from . import tspec as T
from .timing import AID_BROADCAST

STA_AID, PEER_AID = 1, 2


def ts(**kw):
    base = dict(allocation_id=kw.pop('aid_', 3), src_aid=STA_AID, dst_aid=PEER_AID)
    base.update(kw.pop('info', {}))
    info = T.alloc_info(**base)
    d = dict(info=info, bf_control=0, period=1, min_alloc=200, max_alloc=400, min_duration=100, constraints=[])
    d.update(kw)
    return T.DmgTspec(**d)


def test_allocation_info_bits():
    """Рис. 9-569: B0–B3 ID, B4–B6 тип, B7 формат, B8 псевдостатика, B9 Truncatable, B10 Extendable, B11 LP SC,
    B12–B14 UP, B15–B22 Destination AID, B23–B30 Source AID, B31 Reserved."""
    b = T.encode_alloc_info(T.alloc_info(allocation_id=5, allocation_type=1, allocation_format=1, up=6, dst_aid=0x12,
                                         src_aid=0x34))
    v = int.from_bytes(b, 'little')
    assert v & 15 == 5 and v >> 4 & 7 == 1 and v >> 7 & 1 == 1 and v >> 12 & 7 == 6
    assert v >> 15 & 0xFF == 0x12 and v >> 23 & 0xFF == 0x34 and v >> 31 == 0


def test_element_roundtrip_and_length():
    t = ts(constraints=[T.Constraint(123456, 50, 0x8001, 'ff:ff:ff:ff:ff:ff')])
    el = T.encode_dmg_tspec(t)
    assert el[0] == 146 and el[1] == 15 + 14                # рис. 9-568 (4+2+2+2+2+2+1) + рис. 9-571
    assert T.parse_dmg_tspec(E.parse_elements(el)[0].info) == t
    with pytest.raises(ValueError):
        T.parse_dmg_tspec(E.parse_elements(el)[0].info[:20])


def test_period_table_9_261():
    assert T.period_us(2, 100000) == 200000 and T.period_us(0x8004, 100000) == 25000
    assert T.period_us(0x8000, 100000) is None
    with pytest.raises(ValueError):
        T.period_us(0, 100000)


def test_tspec_rules():
    assert T.check_dmg_tspec(ts(), 'req') == []
    assert any('nonzero' in m for m in T.check_dmg_tspec(ts(aid_=0), 'req'))
    assert any('успешном' in m for m in T.check_dmg_tspec(ts(aid_=0), 'resp', 0))
    assert any('failed' in m for m in T.check_dmg_tspec(ts(), 'resp', T.REQUEST_DECLINED))
    assert T.check_dmg_tspec(ts(aid_=0), 'resp', T.REQUEST_DECLINED) == []
    assert any('CBAP' in m for m in T.check_dmg_tspec(ts(info=dict(allocation_type=1, truncatable=1))))
    asyn = ts(info=dict(allocation_format=T.ASYNCHRONOUS), period=0x8002, max_alloc=10)
    v = T.check_dmg_tspec(asyn)
    assert any('integer multiple' in m for m in v) and any('reserved' in m for m in v)
    assert any('Reserved' in m for m in T.check_dmg_tspec(ts(period=0)))
    assert any('32 767' in m for m in T.check_dmg_tspec(ts(min_duration=40000)))
    sc = {n: 0 for n, _ in E.DMG_STA_CAP}
    rx = E.DmgCapabilities('02:00:00:00:00:02', 2, sc, {n: 0 for n, _ in E.DMG_AP_PCP_CAP}, 0,
                           {n: 0 for n, _ in E.EXT_SC_MCS}, 0, 0)
    assert any('low-power' in m for m in T.check_dmg_tspec(ts(info=dict(lp_sc_used=1)), rx_caps=rx))
    rep = ts(constraints=[T.Constraint(1, 2, 0, 'ff:ff:ff:ff:ff:ff')])
    assert T.check_dmg_tspec(rep, interference_report=True) == []          # PLAN.md №70
    assert any('Reserved' in m for m in T.check_dmg_tspec(rep))


def test_addts_variant_and_elements():
    tclas = E.encode_element(T.EID_TCLAS, bytes(3))
    tspec = E.encode_element(T.EID_TSPEC, bytes(55))
    f = T.parse_addts(T.encode_addts_req(4, ts(), tspec=tspec, tclas=[tclas]))
    assert f.variant == 'dmg' and f.token == 4 and f.tspec is not None and T.check_addts(f, src_is_ap=False) == []
    g = T.parse_addts(T.encode_addts_req(4, ts(), tclas=[tclas]))
    assert any('TCLAS без TSPEC' in m for m in T.check_addts(g))
    h = T.parse_addts(T.encode_addts_req(4, ts(), tspec=tspec, tclas=[tclas, tclas]))
    assert any('без TCLAS Processing' in m for m in T.check_addts(h))
    up = T.parse_addts(T.encode_addts_req(4, ts(), others=[E.encode_element(T.EID_UPID, bytes(2))]))
    assert any('U-PID без TSPEC' in m for m in T.check_addts(up))
    assert any('от AP/PCP' in m for m in T.check_addts(f, src_is_ap=True))
    assert any('не-DMG' in m for m in T.check_addts(f, dmg_sta=False))


def test_addts_response_ts_delay_and_pair():
    """9.6.3.3.2: TS Delay — только при REJECTED_FOR_DELAY_PERIOD; вариант — по первому элементу после TS Delay
    (PLAN.md №71)."""
    r = T.parse_addts(T.encode_addts_resp(4, T.REJECTED_FOR_DELAY_PERIOD, ts(aid_=0), ts_delay=1000))
    assert r.variant == 'dmg' and r.ts_delay == 1000 and T.check_addts(r, src_is_ap=True) == []
    bad = T.parse_addts(T.encode_addts_resp(4, 0, ts(), ts_delay=5))
    assert any('TS Delay есть' in m for m in T.check_addts(bad))
    miss = T.parse_addts(T.encode_addts_resp(4, T.REJECTED_FOR_DELAY_PERIOD, ts(aid_=0)))
    assert any('TS Delay нет' in m for m in T.check_addts(miss))
    assert any('85' in m for m in T.check_addts(T.parse_addts(T.encode_addts_resp(4, 85, ts()))))
    req = T.parse_addts(T.encode_addts_req(4, ts(), others=[E.encode_element(T.EID_UPID, bytes(2))],
                                           tspec=E.encode_element(T.EID_TSPEC, bytes(55))))
    ok = T.parse_addts(T.encode_addts_resp(4, 0, ts(), tspec=E.encode_element(T.EID_TSPEC, bytes(55)),
                                           others=[E.encode_element(T.EID_UPID, bytes(2))]))
    assert T.check_addts_pair(req, ok) == []
    no_upid = T.parse_addts(T.encode_addts_resp(4, 0, ts(), tspec=E.encode_element(T.EID_TSPEC, bytes(55))))
    assert any('U-PID' in m for m in T.check_addts_pair(req, no_upid))
    assert any('Dialog Token' in m for m in T.check_addts_pair(req, ok._replace(token=5)))
    plain = T.parse_addts(T.encode_addts_req(4, ts()))
    extra = T.parse_addts(T.encode_addts_resp(4, 0, ts(), others=[E.encode_element(T.EID_UPID, bytes(2))]))
    assert any('без U-PID в запросе' in m for m in T.check_addts_pair(plain, extra))


def test_allocation_table_and_delts():
    tab = T.AllocationTable()
    r = tab.admit(ts(), T.SUCCESS)
    assert T.allocation_key(r.info) in tab.allocs
    assert tab.admit(ts(), T.REQUEST_DECLINED).info['allocation_id'] == 0
    assert T.response_targets(r.info, STA_AID) == {STA_AID, PEER_AID}
    assert tab.on_delts(r.info, STA_AID) == [PEER_AID] and not tab.allocs        # 11.4.9.2
    tab.admit(ts())
    assert tab.on_delts(ts().info, PEER_AID) == [STA_AID]
    b = ts(info=dict(dst_aid=AID_BROADCAST))
    tab.admit(b)
    assert tab.on_delts(b.info, STA_AID) == []
    tab.admit(ts())
    assert tab.on_disassoc(STA_AID) == [(PEER_AID, ts().info)] and not tab.allocs
    d = T.parse_delts(T.encode_delts(32, ts().info))
    assert d.alloc_info == ts().info and T.check_delts(d, True) == []
    nd = T.parse_delts(T.encode_delts(32, ts_info=0x21))
    assert nd.alloc_info is None and any('без DMG Allocation Info' in m for m in T.check_delts(nd, True))
    mb = T.parse_delts(T.encode_delts(32, ts_info=1) + E.encode_element(T.EID_MULTIBAND, bytes(22)))
    assert mb.alloc_info is None
    z = T.parse_delts(T.encode_delts(32, T.alloc_info(src_aid=1), ts_info=1))
    assert any('≠ 0' in m for m in T.check_delts(z, False))


def test_schedule_and_isochronous():
    info = ts().info
    ctrl = dict(allocation_id=3, allocation_type=0, pseudo_static=0, truncatable=0, extendable=0, pcp_active=1,
                lp_sc_used=0, _r12=0)
    a = E.Allocation(ctrl, 0, STA_AID, PEER_AID, 0, 300, 1, 0)
    assert T.check_schedule_has(info, [a]) == [] and T.check_schedule_has(info, [])
    t = ts(period=1, min_alloc=300, min_duration=100)                 # период = BI
    assert T.check_isochronous(t, [(0, 150), (500, 650), (1000, 1300)], 1000) == []
    v = T.check_isochronous(t, [(0, 50), (1000, 1200), (2000, 2300)], 1000)
    assert any('короче Minimum Duration' in m for m in v) and any('< Minimum Allocation' in m for m in v)
