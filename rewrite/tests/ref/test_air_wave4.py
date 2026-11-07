# SPDX-License-Identifier: AGPL-3.0-or-later
"""Правила судьи волны 4 (ref/air_wave4): cluster (10.40) и opt_caps — по журналу из событий (AirEv), без pcap."""
from types import SimpleNamespace as NS

from . import air_judge as J
from . import air_wave4 as W
from . import capelems as CE
from . import cluster as CL
from . import elements as E
from . import fields as F
from .test_air_judge_c import AP, STA, Air
from .test_air_wave3 import act, dmg_caps, mgmt, viol
from .timing import BCAST, aMinChannelTime

SAP = '02:00:00:00:00:01'          # чужой S-AP (MAC меньше нашего)
OTHER = '02:00:00:00:00:77'
BI_US = 102400


def cc(cid, role, maxmem=4, sp=75):
    return F.ClusteringControl(beacon_sp_duration=sp, cluster_id=cid, member_role=role, cluster_max_mem=maxmem, spsh=0)


def bcn(a, src, t, timestamp, c=None, ecapc=0, cbap_only=1, elements=(), tx='AP', rx=()):
    p = NS(bic=F.Bic(cc_present=int(c is not None)), beacon_interval=100, bssid=src, timestamp=timestamp,
           ssw=NS(sector_id=0, antenna_id=0, cdown=0),
           params=NS(bss_type=3, cbap_only=cbap_only, cbap_source=0, privacy=0, ecapc=ecapc), cc=c,
           elements=[(x[0], None, bytes(x[2:])) for x in elements])
    return a.add('DMG Beacon', src, BCAST, t, length=46, p=p, tx=tx, rx=rx)


def caps_ap(dec=0, cen=0):
    sc = {n: 0 for n, _ in E.DMG_STA_CAP}
    sc.update(max_ampdu_len_exp=5, max_sc_rx_mcs=12, max_sc_tx_mcs=12)
    ap = {n: 0 for n, _ in E.DMG_AP_PCP_CAP}
    ap.update(decentralized_clustering=dec, centralized_clustering=cen)
    return E.encode_dmg_capabilities(E.DmgCapabilities(AP, 0, sc, ap, 0, {n: 0 for n, _ in E.EXT_SC_MCS}, 0, 0))


DMG_OP = E.encode_element(E.EID_DMG_OPERATION, bytes(10))


def assoc(a, t=50, dec=0, cen=0, extra=()):
    mgmt(a, E.ASSOC_REQ, STA, AP, t, {}, [dmg_caps(STA)])
    mgmt(a, E.ASSOC_RESP, AP, STA, t + 20, {'status': 0, 'aid': 1}, [caps_ap(dec, cen), DMG_OP] + list(extra))


# ---------------------------------------------------------------------------------------------------- cluster
def test_cluster_not_used():
    a = Air()
    assoc(a)
    for k in range(3):
        bcn(a, AP, 1000 + k * BI_US, 1000 + k * BI_US)
    r = W.r_cluster(a.ctx())
    assert r.viol == [] and r.checked == 3
    assert 'не используется' in r.info['кластеризация точки']
    assert any('Clustering Control' in k for k in r.unchecked)


def test_cluster_cc_without_capability_and_ecapc_without_cc():
    a = Air()
    assoc(a)
    bcn(a, AP, 1000, 1000, c=cc(AP, 0))
    bcn(a, AP, 1000 + BI_US, 1000 + BI_US, ecapc=1)
    r = W.r_cluster(a.ctx())
    assert [v for _, v in viol(r, 'DMG Capabilities')] == ['model']
    assert [v for _, v in viol(r, 'без Clustering Control')] == ['ours']


def test_cluster_sap_schedule_and_series():
    a = Air()
    assoc(a, dec=1)
    from . import schedule as SC
    ents = CL.beacon_sp_entries(0, 1, 100, 4, 75)
    bcn(a, AP, 1000, 1000, c=cc(AP, 1), cbap_only=0, elements=[SC.encode(ents)])
    es6 = SC.encode(CL.beacon_sp_entries(6 * BI_US, 1, 100, 4, 75))     # расписание BI 6 — от его TBTT
    bcn(a, AP, 1000 + 6 * BI_US, 1000 + 6 * BI_US, c=cc(AP, 1), cbap_only=0, elements=[es6])
    r = W.r_cluster(a.ctx())
    assert viol(r, 'Beacon SP (SP 255') == []
    assert len(viol(r, 'aMinBTIPeriod')) == 1                             # 6 BI между маяками S-AP
    b = Air()
    assoc(b, dec=1)
    bcn(b, AP, 1000, 1000, c=cc(AP, 1), cbap_only=0, elements=[SC.encode(ents[1:])])
    assert len(viol(W.r_cluster(b.ctx()), 'shall schedule')) == 1


def test_cluster_member_vs_foreign_sap():
    a = Air()
    assoc(a, dec=1)
    # S-AP: TSF S-AP 5·BI + 300 в t = 10 300 → TBTT S-AP = 10 000; наш маяк в Beacon SP_2 (+25 600)
    bcn(a, SAP, 10300, 5 * BI_US + 300, c=cc(SAP, 1), tx=None, rx=('AP',))
    ents = CL.beacon_sp_entries(0, 2, 100, 4, 75)
    from . import schedule as SC
    bcn(a, AP, 10000 + 25600 + 50, 25600 + 50, c=cc(SAP, 2), cbap_only=0, elements=[SC.encode(ents)])
    r = W.r_cluster(a.ctx())
    assert viol(r, 'член ↔ S-AP') == []
    n = Air()
    assoc(n, dec=1)
    bcn(n, SAP, 10300, 5 * BI_US + 300, c=cc(SAP, 1), tx=None, rx=('AP',))
    bcn(n, AP, 10000 + 25600 + 50, 25600 + 50, c=cc(SAP, 2), cbap_only=0, elements=[SC.encode(ents[1:])])
    assert len(viol(W.r_cluster(n.ctx()), 'shall schedule')) == 1          # нет Beacon SP_1 S-AP
    b = Air()
    assoc(b, dec=1)
    bcn(b, SAP, 10300, 5 * BI_US + 300, c=cc(SAP, 1), tx=None, rx=('AP',))
    bcn(b, AP, 10000 + 40000, 40000, c=cc(SAP, 2, sp=80), cbap_only=0)
    ms = [m for m, _ in viol(W.r_cluster(b.ctx()), 'член ↔ S-AP')]
    assert any('Beacon SP Duration' in m for m in ms)


def test_cluster_member_follows_sap_change_11_29_4():
    from . import schedule as SC
    ch = E.encode_bss_param_change(1, 0, 5000)
    a = Air()
    assoc(a, dec=1)
    bcn(a, SAP, 10300, 5 * BI_US + 300, c=cc(SAP, 1), tx=None, rx=('AP',), elements=[ch])
    es = SC.encode(CL.beacon_sp_entries(0, 2, 100, 4, 75))
    bcn(a, AP, 10000 + 25600 + 50, 25600 + 50, c=cc(SAP, 2), cbap_only=0, elements=[es])
    assert len(viol(W.r_cluster(a.ctx()), '11.29.4')) == 1
    b = Air()
    assoc(b, dec=1)
    bcn(b, SAP, 10300, 5 * BI_US + 300, c=cc(SAP, 1), tx=None, rx=('AP',), elements=[ch])
    bcn(b, AP, 10000 + 25600 + 50, 25600 + 50, c=cc(SAP, 2), cbap_only=0, elements=[es, ch])
    assert viol(W.r_cluster(b.ctx()), '11.29.4') == []


def test_cluster_ecapc_sap_heard_ap_stays():
    a = Air()
    assoc(a)
    bcn(a, SAP, 2000, 2000, c=cc(SAP, 1, maxmem=8), ecapc=1, tx=None, rx=('AP',))
    bcn(a, AP, 1000, 1000)
    bcn(a, AP, 2000 + aMinChannelTime + 1000, 3000)
    r = W.r_cluster(a.ctx())
    assert [v for _, v in viol(r, 'join или cease')] == ['capture']


def test_cluster_report_from_sta():
    a = Air()
    assoc(a)
    bcn(a, AP, 1000, 1000)
    bcn(a, OTHER, 3000, 3000, c=cc(OTHER, 1), tx=None, rx=('STA',))
    rep = CL.encode_cluster_report(CL.make_reports(OTHER, cc(OTHER, 1), 0, [], 0)[0])
    from . import discovery as DS
    act(a, STA, AP, 5000, DS.encode_response(STA, [dmg_caps(STA)], [rep]))
    r = W.r_cluster(a.ctx())
    assert viol(r, 'Information Response') == [] and r.checked >= 2
    b = Air()
    assoc(b)
    bcn(b, AP, 1000, 1000)
    bcn(b, OTHER, 3000, 3000, tx=None, rx=('STA',))                      # маяк без Clustering Control
    act(b, STA, AP, 5000, DS.encode_response(STA, [dmg_caps(STA)], [rep]))
    assert any('shall not' in m for m, _ in viol(W.r_cluster(b.ctx()), 'Information Response'))


def test_cluster_ecapc_policy_in_assoc_resp():
    a = Air()
    pol = CL.encode_ecapc_policy(CL.EcapcPolicy(0, 0, 0, OTHER, 0b10))
    bcn(a, AP, 10, 10)
    assoc(a, t=100, extra=[E.parse_elements(pol)[0]])
    r = W.r_cluster(a.ctx())
    assert [v for _, v in viol(r, 'ECAPC Policy Enforced = 0')] == ['model']
    b = Air()
    bcn(b, AP, 10, 10, c=cc(AP, 1, maxmem=8), ecapc=1, cbap_only=0)
    assoc(b, t=100, cen=1)
    assert viol(W.r_cluster(b.ctx()), 'shall include')


# ---------------------------------------------------------------------------------------------------- opt_caps
def test_opt_caps_clean_and_violations():
    a = Air()
    assoc(a)
    bcn(a, AP, 1000, 1000)
    r = W.r_opt_caps(a.ctx())
    assert r.viol == [] and r.checked == 3
    b = Air()
    mgmt(b, E.ASSOC_REQ, STA, AP, 100, {'capability': {'triggered_unscheduled_ps': 1}},
         [dmg_caps(STA), E.parse_elements(CE.encode_ext_cap(bits=['WNM Sleep Mode']))[0],
          E.Element(158, None, bytes(20))])
    act(b, AP, STA, 200, bytes([16, 1, 1]) + (0).to_bytes(2, 'little'))           # PSC-RSP SUCCESS
    act(b, STA, AP, 300, bytes([16, 8, 1]))                                        # Relay Search Request
    act(b, AP, STA, 400, bytes([16, 1, 1]) + (37).to_bytes(2, 'little'))          # отказ — норма
    r = W.r_opt_caps(b.ctx())
    assert r.info['нарушения по группам'] == {'ps': 3, 'fst': 1, 'relay': 1}
    assert all(v == 'ours' for _, _, v in r.viol)


def test_opt_caps_pm_bit_and_foreign_ignored():
    a = Air()
    fc = F.encode_fc(F.FrameControl(type=F.TYPE_MGMT, subtype=13, pm=1))
    raw = fc + bytes(2) + F.mac_bytes(AP) + F.mac_bytes(STA) + F.mac_bytes(AP) + bytes(2) + bytes([16, 2, 1])
    e = a.add('Action', STA, AP, 100, length=len(raw) + 4, raw=raw, tx='STA')
    e.fc = F.parse_fc(raw[:2])
    raw2 = hdr_from(OTHER) + bytes([16, 8, 1])
    a.add('Action', OTHER, BCAST, 200, length=len(raw2) + 4, raw=raw2, rx=('STA',))
    r = W.r_opt_caps(a.ctx())
    assert [m for _, m, _ in r.viol] and all('Power Management' in m for _, m, _ in r.viol)


def hdr_from(src):
    fc = F.encode_fc(F.FrameControl(type=F.TYPE_MGMT, subtype=13))
    return fc + bytes(2) + F.mac_bytes(BCAST) + F.mac_bytes(src) + F.mac_bytes(src) + bytes(2)


def test_wave4_registered():
    names = {f.__name__ for f in J.RULES}
    assert {'r_cluster', 'r_opt_caps'} <= names
    ids = [x[0] for x in J.NOT_CHECKABLE]
    assert {'cluster_monitor', 'cluster_blind', 'cluster_handover'} <= set(ids) and len(ids) == len(set(ids))
