# SPDX-License-Identifier: AGPL-3.0-or-later
"""Правила судьи волны 5 (ref/air_wave5) по журналу из событий (AirEv), без pcap: addr, data_hdr, action_fmt, wnm,
tpc, tclas, sta_avail, addba_ext, asid_pattern, timestamp, sp_recovery, ecs, bf_training."""
from types import SimpleNamespace as NS

from . import addbaext as AX
from . import air_judge as J
from . import air_wave5 as W
from . import blockack as BA
from . import capelems as CE
from . import chswitch as CS
from . import ecs as EC
from . import elements as E
from . import fields as F
from . import sectorpat as SPAT
from . import staavail as SA
from . import tclas as TC
from . import tpc as TP
from .test_air_judge_c import AP, STA, Air
from .test_air_wave3 import act, dmg_caps, hdr, mgmt, viol
from .timing import BCAST

FOREIGN = '02:00:00:00:00:77'
BI_US = 102400


def bcn(a, t, ts=None, elements=(), sector=0, cdown=0):
    p = NS(bic=F.Bic(), beacon_interval=100, bssid=AP, timestamp=t if ts is None else ts,
           ssw=NS(sector_id=sector, antenna_id=0, cdown=cdown),
           params=NS(bss_type=3, cbap_only=1, cbap_source=0, privacy=0, ecapc=0), cc=None,
           elements=[(x[0], None, bytes(x[2:])) if x[0] != 255 else (255, x[2], bytes(x[3:])) for x in elements])
    return a.add('DMG Beacon', AP, BCAST, t, length=46, p=p, tx='AP')


def ctl(a, subtype, ra, ta, t, tx='AP'):
    raw = F.encode_fc(F.FrameControl(type=F.TYPE_CTRL, subtype=subtype)) + bytes(2) + F.mac_bytes(ra) + \
        F.mac_bytes(ta)
    return a.add('RTS', ta, ra, t, length=20, raw=raw, tx=tx)


def probe_resp(a, t, capinfo=None, els=(), ts=None):
    return mgmt(a, E.PROBE_RESP, AP, STA, t, {'capability': capinfo or {}, 'timestamp': ts if ts is not None else t},
                [dmg_caps(AP)] + list(els))


# ---------------------------------------------------------------------------------------------------- addr
def test_addr_ta_group_and_ok():
    a = Air()
    ctl(a, 11, STA, AP, 1000)
    ctl(a, 11, STA, '03:00:00:00:00:00', 2000)
    r = W.r_addr(a.ctx())
    assert len(viol(r, 'bandwidth signaling')) == 1 and len(viol(r, 'Address 2')) == 1      # TA ≠ узел-передатчик
    assert r.checked == 3


# ---------------------------------------------------------------------------------------------------- data_hdr
def test_data_hdr_qos_null_length_synthetic():
    a = Air()
    a.add('QoS Null', STA, AP, 1000, length=30, synth=True, rx=('AP',))
    a.add('QoS Null', STA, AP, 2000, length=44, synth=True, rx=('AP',))
    r = W.r_data_hdr(a.ctx())
    assert len(viol(r, 'тело QoS Null пустое')) == 1 and r.checked == 2


# ---------------------------------------------------------------------------------------------------- action_fmt
def test_action_fmt_noack_and_brp():
    a = Air()
    act(a, AP, STA, 1000, BA.encode_addba_req(BA.AddbaReq(1, BA.BAParams(0, 1, 0, 64), 0, 0)))
    raw = hdr(STA, AP, AP, subtype=14) + BA.encode_addba_req(BA.AddbaReq(2, BA.BAParams(0, 1, 0, 64), 0, 0))
    a.add('Action No Ack', AP, STA, 2000, length=len(raw) + 4, raw=raw, tx='AP')
    act(a, STA, AP, 3000, bytes([20, 1, 0]) + bytes(11), tx='STA')            # BRP как Action
    r = W.r_action_fmt(a.ctx())
    assert len(viol(r, 'как Action No Ack')) == 1
    assert len(viol(r, '9.6.21.3')) == 1
    assert r.info['by_status'] == {'open': 3}


def test_action_fmt_echo_10_28_4():
    a = Air()
    raw = hdr(AP, FOREIGN, AP) + bytes([40, 1, 2])
    a.add('Action', FOREIGN, AP, 1000, length=len(raw) + 4, raw=raw, tx=None, rx=('AP',))
    assert viol(W.r_action_fmt(a.ctx()), '10.28.4')
    act(a, AP, FOREIGN, 2000, bytes([40 | 0x80, 1, 2]))
    r = W.r_action_fmt(a.ctx())
    assert viol(r, '10.28.4') == [] and viol(r, 'Error') == []


# ---------------------------------------------------------------------------------------------------- wnm
def test_wnm_caps_and_request():
    a = Air()
    mgmt(a, E.ASSOC_REQ, STA, AP, 100, {'capability': {}}, [dmg_caps(STA), CE.encode_ext_cap([19])])
    mgmt(a, E.ASSOC_RESP, AP, STA, 200, {'status': 0, 'aid': 1}, [dmg_caps(AP), CE.encode_ext_cap([])])
    act(a, STA, AP, 1000, bytes([10, 6, 1, 0]), tx='STA')                      # BTM Query к AP без бита 19
    r = W.r_wnm(a.ctx())
    assert viol(r, 'Extended Channel Switching (бит 2) = 0')
    assert viol(r, 'shall not request')


# ---------------------------------------------------------------------------------------------------- tpc
def test_tpc_report_in_beacon_and_response():
    a = Air()
    probe_resp(a, 50, {'spectrum_mgmt': 1}, els=[TP.encode_tpc_report(10, 0)])
    bcn(a, 1000)
    bcn(a, 1000 + BI_US, elements=[TP.encode_tpc_report(10, 0)])
    act(a, STA, AP, 5000, TP.encode_tpc_request_frame(3), tx='STA')
    r = W.r_tpc(a.ctx())
    assert len(viol(r, 'без TPC Report —')) == 1                              # первый маяк
    assert len(viol(r, 'shall respond')) == 1
    act(a, AP, STA, 6000, TP.encode_tpc_report_frame(3, 10, 5))
    r = W.r_tpc(a.ctx())
    assert viol(r, 'shall respond') == []


# ---------------------------------------------------------------------------------------------------- tclas
def test_tclas_in_addts():
    a = Air()
    good = TC.eth('01:00:5e:00:00:01')
    bad = TC.encode(255, 11, 0, b'')
    act(a, STA, AP, 1000, bytes([1, 0, 1]) + bytes([146, 0]) + good + bad, tx='STA')
    r = W.r_tclas(a.ctx())
    assert r.checked == 2 and len(viol(r, 'Reserved (табл. 9-164)')) == 1


# ---------------------------------------------------------------------------------------------------- sta_avail
def test_sta_avail_poll_after_pp_zero():
    a = Air()
    mgmt(a, E.ASSOC_REQ, STA, AP, 100, {}, [dmg_caps(STA)])
    mgmt(a, E.ASSOC_RESP, AP, STA, 200, {'status': 0, 'aid': 1}, [dmg_caps(AP)])
    from . import discovery as DS
    act(a, STA, AP, 1000, DS.encode_request(STA, [], provided=[SA.encode([(1, 1, 0)])]), tx='STA')
    a.add('Poll', AP, STA, 2000, length=22, tx='AP')
    r = W.r_sta_avail(a.ctx())
    assert viol(r, 'PP Available = 0')


# ---------------------------------------------------------------------------------------------------- addba_ext
def _qos_data(src, dst, tid=0, fn=1, more=0):
    fc = (2 << 2 | 8 << 4 | 1 << 8 | more << 10).to_bytes(2, 'little')
    return fc + bytes(2) + F.mac_bytes(dst) + F.mac_bytes(src) + F.mac_bytes(dst) + bytes([fn, 0]) + bytes([tid, 0])


def test_addba_ext_no_frag():
    a = Air()
    act(a, STA, AP, 100, BA.encode_addba_req(BA.AddbaReq(5, BA.BAParams(0, 1, 0, 64), 0, 0)), tx='STA')
    act(a, AP, STA, 200, BA.encode_addba_resp(BA.AddbaResp(5, 0, BA.BAParams(0, 1, 0, 64), 0)) + AX.encode(1))
    raw = _qos_data(STA, AP)
    a.add('Data', STA, AP, 1000, length=len(raw) + 100, raw=raw, tx='STA')
    r = W.r_addba_ext(a.ctx())
    assert r.info['agreements'] == 1 and viol(r, 'shall not be')


# ---------------------------------------------------------------------------------------------------- asid_pattern
def test_asid_pattern_sequence():
    p = SPAT.Pattern(0, 0b110000, 5, 0b10111000, 1)
    want = SPAT.sectors(p, 8, 8)
    a = Air()
    probe_resp(a, 50, els=[SPAT.encode(p)])
    for i, s in enumerate(want):
        bcn(a, 1000 + 30 * i, sector=s, cdown=7 - i)
    r = W.r_asid_pattern(a.ctx())
    assert r.viol == [] and r.checked == 1
    b = Air()
    probe_resp(b, 50, els=[SPAT.encode(p)])
    for i in range(8):
        bcn(b, 1000 + 30 * i, sector=i, cdown=7 - i)
    assert viol(W.r_asid_pattern(b.ctx()), 'расхождений')
    z = Air()
    probe_resp(z, 50, els=[SPAT.encode(SPAT.Pattern(0, 0, 0, 0, 0))])
    bcn(z, 1000)
    rz = W.r_asid_pattern(z.ctx())
    assert viol(rz, 'Tap 1 = 0') and viol(rz, 'расхождений') == []


# ---------------------------------------------------------------------------------------------------- timestamp
def test_timestamp_rules():
    from . import air_pcap as P
    pre = int(P.PRE['control']) + 1
    a = Air()
    bcn(a, 10 * BI_US, ts=10 * BI_US + pre)
    bcn(a, 11 * BI_US, ts=11 * BI_US + pre)
    r = W.r_timestamp(a.ctx())
    assert r.viol == []
    b = Air()
    bcn(b, 10 * BI_US, ts=10 * BI_US)                                          # Timestamp = TBTT: раньше преамбулы
    bcn(b, 11 * BI_US, ts=10 * BI_US - 50)                                     # TSF назад
    rb = W.r_timestamp(b.ctx())
    assert viol(rb, 'TBTT') and viol(rb, 'increments')


def test_timestamp_probe_response_zero():
    a = Air()
    bcn(a, 10 * BI_US)
    e = probe_resp(a, 10 * BI_US + 5000, ts=0)
    e.mcs = 0
    r = W.r_timestamp(a.ctx())
    assert viol(r, 'Probe Response: Timestamp 0')


# ---------------------------------------------------------------------------------------------------- sp_recovery
def test_sp_recovery_not_applicable_without_sp():
    a = Air()
    bcn(a, 1000)
    r = W.r_sp_recovery(a.ctx())
    assert r.status == 'unchecked'


# ---------------------------------------------------------------------------------------------------- ecs
def test_ecs_mcst_with_count_zero():
    a = Air()
    ecsa = CS.encode_ecsa(CS.Ecsa(0, 180, 3, 0))
    probe_resp(a, 50, els=[ecsa, EC.encode_mcst(100)])
    r = W.r_ecs(a.ctx())
    assert [v for _, v in viol(r, 'Count 0')] == ['model']
    b = Air()
    probe_resp(b, 50, els=[EC.encode_mcst(100)])
    assert [v for _, v in viol(W.r_ecs(b.ctx()), 'без ECSA')] == ['ours']


# ---------------------------------------------------------------------------------------------------- bf_training
def test_bf_training_brp_without_sls():
    a = Air()
    a.add('BRP', AP, STA, 1000, length=40, tx='AP')
    r = W.r_bf_training(a.ctx())
    assert [v for _, v in viol(r, 'shall start with the SLS')] == ['model']
    b = Air()
    b.add('SSW', AP, STA, 500, length=26, tx='AP')
    b.add('BRP', AP, STA, 1000, length=40, tx='AP')
    assert W.r_bf_training(b.ctx()).viol == []


def test_rules_registered_and_pages():
    ids = {f.__name__ for f in J.RULES}
    assert {f.__name__ for f in W.RULES} <= ids
    assert all(J.PAGE.get(k) for k in W.PAGE)
    assert {x[0] for x in W.NOT_CHECKABLE} <= {x[0] for x in J.NOT_CHECKABLE}
