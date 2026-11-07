# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/addrs: 9.2.4.3 (адреса), 9.3.3.1 c) (Address 3 управления), 11.17, 9.3.2.1 (заголовок данных DMG, табл. 9-30)."""
from . import addrs as AD
from . import fields as F
from .timing import BCAST

AP, STA, STA2 = '02:00:00:00:00:01', '02:00:00:00:00:02', '02:00:00:00:00:03'
GRP = '01:00:5e:00:00:01'


def mgmt(a1, a2, a3, subtype=13, body=b'\x03\x00'):
    return F.encode_fc(F.FrameControl(type=F.TYPE_MGMT, subtype=subtype)) + bytes(2) + F.mac_bytes(a1) + \
        F.mac_bytes(a2) + F.mac_bytes(a3) + bytes(2) + body


def data(a1, a2, a3, to_ds=0, from_ds=0, subtype=8, qos=0, a4=None, htc=0):
    v = 2 << 2 | subtype << 4 | to_ds << 8 | from_ds << 9 | htc << 15
    h = v.to_bytes(2, 'little') + bytes(2) + F.mac_bytes(a1) + F.mac_bytes(a2) + F.mac_bytes(a3) + bytes(2)
    if a4:
        h += F.mac_bytes(a4)
    return h + qos.to_bytes(2, 'little')


def ctl(subtype, ra, ta):
    return F.encode_fc(F.FrameControl(type=F.TYPE_CTRL, subtype=subtype)) + bytes(2) + F.mac_bytes(ra) + \
        F.mac_bytes(ta)


def ours(v):
    return [m for m, x in v if x == 'ours']


def test_ta_group_bit_9_2_4_3_8():
    assert ours(AD.check_addresses(ctl(11, AP, '03:00:00:00:00:02'), 'RTS', AP))
    assert AD.check_addresses(ctl(11, AP, STA), 'RTS', AP) == []


def test_ra_individual_for_control_9_3_1():
    assert ours(AD.check_addresses(ctl(11, BCAST, STA), 'RTS', AP))
    assert ours(AD.check_addresses(ctl(14, GRP, AP), 'CF-End', AP))           # DMG CF-End: индивидуальный или broadcast
    assert AD.check_addresses(ctl(14, BCAST, AP), 'CF-End', AP) == []


def test_dmg_cts_to_self_ta_exception_9_3_1_13():
    raw = F.encode_fc(F.FrameControl(type=F.TYPE_CTRL, subtype=6, cfe=8)) + bytes(2) + F.mac_bytes(AP) + \
        F.mac_bytes(GRP)
    assert AD.check_addresses(raw, 'DMG CTS', AP, src=AP) == []                # TA — получатели следующего кадра


def test_address2_is_transmitter():
    assert ours(AD.check_addresses(ctl(11, AP, STA2), 'RTS', AP, src=STA))


def test_mgmt_address3_9_3_3_1():
    assert AD.check_addresses(mgmt(STA, AP, AP), 'Action', AP) == []          # c) 4) i): AP — A3 = A2
    assert ours(AD.check_addresses(mgmt(STA, AP, STA2), 'Action', AP))
    assert AD.check_addresses(mgmt(AP, STA, AP), 'Action', AP) == []          # c) 4) ii)
    assert ours(AD.check_addresses(mgmt(AP, STA, STA), 'Action', AP))
    assert ours(AD.check_addresses(mgmt(AP, STA, BCAST), 'Action', AP))       # wildcard — не разрешён
    assert AD.check_addresses(mgmt(BCAST, STA, BCAST, subtype=4, body=b''), 'Probe Request', AP) == []


def test_public_action_11_17():
    pub = b'\x04\x04'
    assert AD.check_addresses(mgmt(AP, STA, AP, body=pub), 'Action', AP) == []
    assert ours(AD.check_addresses(mgmt(AP, STA, STA2, body=pub), 'Action', AP))
    assert AD.check_addresses(mgmt(BCAST, AP, BCAST, body=pub), 'Action', AP) == []   # групповой: BSSID или wildcard


def test_mgmt_ds_bits_table_9_4():
    raw = bytearray(mgmt(AP, STA, AP))
    raw[1] |= 2                                                                # From DS = 1 — Reserved
    assert ours(AD.check_addresses(bytes(raw), 'Action', AP))


def test_data_table_9_30_infra():
    assert AD.check_data_header(data(STA, AP, '02:00:00:00:00:99', from_ds=1), 32, AP) == []
    assert AD.check_data_header(data(AP, STA, '02:00:00:00:00:99', to_ds=1), 32, AP) == []
    assert ours(AD.check_data_header(data(STA2, STA, AP, to_ds=1), 32, AP))        # RA ≠ BSSID при To DS
    assert ours(AD.check_data_header(data(STA, AP, AP, to_ds=1), 32, AP))          # AP — только 0/1
    assert ours(AD.check_data_header(data(AP, STA, AP, from_ds=1), 32, AP))        # non-AP с From DS
    assert AD.check_data_header(data(STA2, STA, AP), 32, AP) == []                 # напрямую в BSS: A3 = BSSID
    assert ours(AD.check_data_header(data(STA2, STA, STA), 32, AP))
    four = AD.check_data_header(data(AP, STA, AP, 1, 1, a4=STA), 38, AP)
    assert [x for _, x in four] == ['model']                                       # 4 адреса у DMG не определены


def test_data_pbss_only_00():
    assert AD.check_data_header(data(STA2, STA, AP), 32, AP, pbss=True) == []
    assert ours(AD.check_data_header(data(AP, STA, STA2, to_ds=1), 32, AP, pbss=True))


def test_data_subtypes_and_htc_9_3_2_1_5():
    assert ours(AD.check_data_header(data(STA, AP, AP, from_ds=1, subtype=0)[:24], 28, AP))   # Data без QoS
    assert ours(AD.check_data_header(data(STA, AP, AP, from_ds=1, htc=1), 36, AP))


def test_qos_null_has_no_body_9_3_2_1_4():
    assert AD.check_data_header(data(STA, AP, AP, from_ds=1, subtype=12), 30, AP) == []
    assert ours(AD.check_data_header(data(STA, AP, AP, from_ds=1, subtype=12), 40, AP))
    assert AD.check_data_header(data(STA, AP, AP, from_ds=1, subtype=12), 40, AP, agg=True) == []
