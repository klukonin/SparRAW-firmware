# SPDX-License-Identifier: AGPL-3.0-or-later
"""Правила судьи волны 3 (ref/air_wave3) по журналу из событий (AirEv), без pcap: 11.28, 11.35, 11.27.2, 10.39.6.6,
11.4, 11.30, RSNE/Extended Capabilities/Supported Operating Classes, пределы A-MPDU, QoS Control."""
from types import SimpleNamespace as NS

from . import air_judge as J
from . import air_wave3 as W
from . import amsdu as AM
from . import capelems as CE
from . import discovery as DS
from . import elements as E
from . import fields as F
from . import handover as HO
from . import protperiod as PP
from . import qab as QB
from . import spsh as SS
from . import tspec as TS
from .test_air_judge_c import AP, STA, Air
from .timing import BCAST, TU

FOREIGN = '02:00:00:00:00:77'


def hdr(a1, a2, a3, subtype=13, protected=0):
    fc = F.encode_fc(F.FrameControl(type=F.TYPE_MGMT, subtype=subtype, protected=protected))
    return fc + bytes(2) + F.mac_bytes(a1) + F.mac_bytes(a2) + F.mac_bytes(a3) + bytes(2)


def act(a, src, dst, t, body, a3=None, kind='Action', tx=None):
    raw = hdr(dst, src, a3 or AP) + bytes(body)
    return a.add(kind, src, dst, t, length=len(raw) + 4, raw=raw, tx=tx or ('AP' if src == AP else 'STA'))


def mgmt(a, kind, src, dst, t, fixed, els):
    sub = {E.PROBE_RESP: 5, E.ASSOC_REQ: 0, E.ASSOC_RESP: 1}[kind]
    raw = hdr(dst, src, AP, subtype=sub) + E.encode_body(kind, fixed, els)
    return a.add(kind, src, dst, t, length=len(raw) + 4, raw=raw, tx='AP' if src == AP else 'STA')


def dmg_caps(mac, exp=5, handover=0):
    sc = {n: 0 for n, _ in E.DMG_STA_CAP}
    sc['max_ampdu_len_exp'] = exp
    ap = {n: 0 for n, _ in E.DMG_AP_PCP_CAP}
    ap['pcp_handover'] = handover
    return E.encode_dmg_capabilities(E.DmgCapabilities(mac, 0, sc, ap, 0, {n: 0 for n, _ in E.EXT_SC_MCS}, 0, 0))


DMG_OP = E.encode_element(E.EID_DMG_OPERATION, bytes(10))


def assoc(a, t=100, sta_els=(), aid=1, exp=5):
    mgmt(a, E.ASSOC_REQ, STA, AP, t, {}, [dmg_caps(STA, exp)] + list(sta_els))
    mgmt(a, E.ASSOC_RESP, AP, STA, t + 50, {'status': 0, 'aid': aid}, [dmg_caps(AP), DMG_OP])


def beacon(a, t, elements=(), bss_type=3, cbap_only=1):
    p = NS(bic=None, beacon_interval=100, bssid=AP, ssw=NS(sector_id=0, antenna_id=0, cdown=0),
           params=NS(bss_type=bss_type, cbap_only=cbap_only, cbap_source=0, privacy=0, ecapc=0),
           elements=[(x[0], None, bytes(x[2:])) for x in elements])
    return a.add('DMG Beacon', AP, BCAST, t, length=46, p=p, tx='AP')


def viol(r, key=None):
    return [(m, v) for _, m, v in r.viol if key is None or key in m]


# ---------------------------------------------------------------------------------------------------- 11.28
def test_info_req_pair_and_foreign_bssid():
    a = Air()
    act(a, STA, AP, 1000, DS.encode_request(BCAST, [E.EID_EXTENDED_SCHEDULE], dmg_caps=[dmg_caps(STA)]))
    act(a, AP, STA, 2000, DS.encode_response(BCAST, [dmg_caps(AP), dmg_caps(STA)]))
    r = W.r_info_req(a.ctx())
    assert r.viol == [] and r.checked == 2
    b = Air()
    act(b, STA, AP, 1000, DS.encode_request(STA, [151]), a3=FOREIGN)
    act(b, AP, STA, 2000, DS.encode_response(STA, [dmg_caps(AP)]))
    assert viol(W.r_info_req(b.ctx()), '11.28.2 b)')
    c = Air()
    act(c, STA, AP, 1000, DS.encode_request(STA, [151]))
    act(c, AP, STA, 2000, DS.encode_response(STA, []))
    assert viol(W.r_info_req(c.ctx()), 'One or more')


# ---------------------------------------------------------------------------------------------------- 11.35
def test_qab_from_sta_and_quiet_tx():
    a = Air()
    body = QB.encode_frame(QB.ACT_QAB_REQ, 1, STA, FOREIGN, [QB.encode_qp_req(QB.QpReq(1, 0, 10, 1, 1, FOREIGN))])
    act(a, STA, FOREIGN, 1000, body)
    assert viol(W.r_qab(a.ctx()), 'non-AP')
    b = Air()
    req = QB.encode_frame(QB.ACT_QAB_REQ, 4, FOREIGN, AP, [QB.encode_qp_req(QB.QpReq(2, 1, 10, 1, 1, AP))])
    e = act(b, FOREIGN, AP, 0, req, tx=None)
    e.tx_node = None
    resp = QB.QabResponder(AP).on_request(req, 0)
    act(b, AP, FOREIGN, 200, resp)
    b.add('Data', AP, STA, 1 * TU + 100, length=200, mcs=4, tx='AP')      # в тихом интервале [1 TU, 2 TU)
    r = W.r_qab(b.ctx())
    assert viol(r, 'тихом интервале') and not viol(r, 'non-AP')


# ---------------------------------------------------------------------------------------------------- 11.27.2
def test_pcp_handover_beacons():
    a = Air()
    beacon(a, 0, [HO.encode_pcp_handover(HO.PcpHandover(AP, STA, 3))])
    assert viol(W.r_pcp_handover(a.ctx()), 'не PBSS')
    b = Air()
    for k, rem in enumerate((3, 2, 1)):
        beacon(b, k * 100 * TU, [HO.encode_pcp_handover(HO.PcpHandover(AP, STA, rem))], bss_type=2)
    r = W.r_pcp_handover(b.ctx())
    assert r.viol == [] and r.checked >= 1
    c = Air()
    for k, rem in enumerate((3, 3, 1)):
        beacon(c, k * 100 * TU, [HO.encode_pcp_handover(HO.PcpHandover(AP, STA, rem))], bss_type=2)
    assert [v for _, v in viol(W.r_pcp_handover(c.ctx()), 'ожидалось')] == ['model']
    d = Air()
    act(d, AP, STA, 50, HO.encode_request(HO.REASON_LEAVING, 4))
    assoc(d)
    assert viol(W.r_pcp_handover(d.ctx()), 'неспособной')


# ---------------------------------------------------------------------------------------------------- 10.39.6.6
def sp_beacon(a, t, start, dur, src_aid=1, dst_aid=0, alloc_id=1):
    ctrl = dict(allocation_id=alloc_id, allocation_type=0, pseudo_static=0, truncatable=0, extendable=0, pcp_active=1,
                lp_sc_used=0, _r12=0)
    es = E.encode_extended_schedule([E.Allocation(ctrl, 0, src_aid, dst_aid, start, dur, 1, 0)])
    return beacon(a, t, [es], cbap_only=0)


def test_prot_period_rts_duration_beyond_sp():
    a = Air()
    assoc(a, t=10)
    sp_beacon(a, 1000, 5000, 2000)
    a.add('RTS', STA, AP, 5100, length=20, dur=1000, tx='STA')
    assert viol(W.r_prot_period(a.ctx())) == []
    a.add('RTS', STA, AP, 6000, length=20, dur=1900, tx='STA')
    assert viol(W.r_prot_period(a.ctx()), 'за концом SP')
    b = Air()
    b.add('DMG DTS', None, STA, 5000, length=26, tx='AP')
    assert [v for _, v in viol(W.r_prot_period(b.ctx()), 'без SP')] == ['model']


# ---------------------------------------------------------------------------------------------------- 11.4
def test_addts_dmg_pair():
    t = TS.DmgTspec(TS.alloc_info(allocation_id=3, src_aid=1, dst_aid=0), 0, 1, 100, 200, 50, [])
    a = Air()
    act(a, STA, AP, 1000, TS.encode_addts_req(5, t))
    act(a, AP, STA, 2000, TS.encode_addts_resp(5, TS.SUCCESS, t._replace(info=dict(t.info, allocation_id=0))))
    r = W.r_addts(a.ctx())
    assert viol(r, 'успешном') and any('Extended Schedule' in m or 'маяков' in m for m in
                                       list(r.unchecked) + [m for m, _ in viol(r)])
    b = Air()
    act(b, STA, AP, 1000, TS.encode_addts_req(5, t))
    act(b, AP, STA, 2000, TS.encode_addts_resp(5, TS.SUCCESS, t))
    sp_beacon(b, 100 * TU, 0, 300, alloc_id=3)
    sp = viol(W.r_addts(b.ctx()))
    assert sp == [], sp


# ---------------------------------------------------------------------------------------------------- 11.30
def test_spsh_report_mismatch():
    r_ = SS.DcqReq(180, 2, 1, 0, SS.METHOD_ANIPI, 0, 10, 2, b'')
    q = SS.encode_meas(SS.EID_MEAS_REQ, 1, SS.req_mode(), SS.TYPE_DCQ, SS.encode_dcq_req(r_))
    rep = SS.encode_meas(SS.EID_MEAS_REP, 1, SS.rep_mode(), SS.TYPE_DCQ,
                         SS.encode_dcq_rep(SS.DcqRep(180, 2, 1, 0, SS.METHOD_RSNI, 0, 10, 2, [3, 4], b'')))
    a = Air()
    act(a, AP, STA, 1000, SS.encode_rm_request(7, [q]))
    act(a, STA, AP, 2000, SS.encode_rm_report(7, [rep]))
    assert viol(W.r_spsh(a.ctx()), 'method')


# -------------------------------------------------------------------------------------------------- RSNE / ExtCap / SOC
def test_rsne_selection_and_caps():
    g, c = CE.sel(CE.GCMP128), CE.sel(CE.CCMP128)
    ap_rsn = E.encode_rsne(group_data=g, pairwise=[g], akm=[CE.sel(2)], capabilities=0)
    a = Air()
    mgmt(a, E.PROBE_RESP, AP, STA, 50, {}, [ap_rsn, dmg_caps(AP), DMG_OP])
    assoc(a, sta_els=[E.encode_rsne(group_data=g, pairwise=[c], akm=[CE.sel(2)], capabilities=0)])
    assert viol(W.r_rsne(a.ctx()), 'не из объявленных')
    b = Air()
    assoc(b, sta_els=[CE.encode_ext_cap(['QAB Capability'])])
    assert viol(W.r_ext_caps(b.ctx()), 'non-AP')
    c2 = Air()
    assoc(c2, sta_els=[CE.encode_soc(81, [81])])
    assert [v for _, v in viol(W.r_op_classes(c2.ctx()))] == ['model']


# ---------------------------------------------------------------------------------------------------- A-MPDU, QoS
def test_ampdu_length_limit():
    a = Air()
    assoc(a, exp=0)
    e = a.add('A-MPDU', AP, STA, 1000, length=9000, mcs=4, tx='AP')
    e.agg = True
    assert viol(W.r_ampdu_limits(a.ctx()), 'предела 8191')


def test_qos_ctl_eosp_and_tsid():
    a = Air()
    beacon(a, 0)                                                   # CBAP Only = 1
    raw = AM.encode_mpdu(STA, AP, AP, bytes(40), tid=0, amsdu=0, from_ds=1)
    q = bytearray(raw)
    q[24] |= 1 << 4                                                # EOSP
    e = a.add('Data', AP, STA, 1000, length=len(q) + 4, mcs=4, raw=bytes(q), tx='AP')
    e.mpdus = [bytes(q)]
    raw9 = AM.encode_mpdu(STA, AP, AP, bytes(40), tid=9, amsdu=0, from_ds=1)
    e9 = a.add('Data', AP, STA, 2000, length=len(raw9) + 4, mcs=4, raw=raw9, tx='AP')
    e9.mpdus = [raw9]
    g = AM.encode_mpdu('01:00:5e:00:00:01', AP, AP, bytes(40), tid=0, amsdu=0, from_ds=1, ackpol=0)
    eg = a.add('Data', AP, '01:00:5e:00:00:01', 3000, length=len(g) + 4, mcs=4, raw=g, tx='AP')
    eg.mpdus = [g]
    r = W.r_qos_ctl(a.ctx())
    assert viol(r, 'EOSP') and [v for _, v in viol(r, 'TSID')] == ['capture']
    assert viol(r, 'групповой кадр')                    # табл. 9-13: групповые — No Ack


def test_wave3_registered():
    ids = {f.__name__ for f in J.RULES}
    assert {f.__name__ for f in W.RULES} <= ids
    nc = {x[0] for x in J.NOT_CHECKABLE}
    assert {'info_resp_supported', 'pp_listening', 'ampdu_spacing', 'qab_peer'} <= nc
    assert 'prot_period' in J.TIMING_RULES
    assert PP.T_DTS > 0
