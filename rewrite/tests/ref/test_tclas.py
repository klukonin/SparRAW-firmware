# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/tclas: TCLAS 9.4.2.30, типы 0–10 (табл. 9-164) — кодек, проверки, сопоставление."""
import ipaddress

import pytest

from . import amsdu as AM
from . import dms as DM
from . import fields as F
from . import tclas as T

A, B = '02:00:00:00:00:01', '02:00:00:00:00:02'
SNAP = b'\xaa\xaa\x03\x00\x00\x00'


def p(el):
    return T.parse(el[2:])


def ours(v):
    return [m for m, x in v if x == 'ours']


def ip4_packet(src, dst, proto=17, sport=1000, dport=2000, dscp=0, tail=b''):
    hdr = bytes([0x45, dscp << 2, 0, 28 + len(tail), 0, 0, 0, 0, 64, proto, 0, 0]) + \
        ipaddress.IPv4Address(src).packed + ipaddress.IPv4Address(dst).packed
    return SNAP + b'\x08\x00' + hdr + sport.to_bytes(2, 'big') + dport.to_bytes(2, 'big') + bytes(4) + tail


def ip6_packet(src, dst, nh=17, ext=b'', tail=b''):
    hdr = bytes([0x60, 0, 0, 0, 0, 8, nh, 64]) + ipaddress.IPv6Address(src).packed + \
        ipaddress.IPv6Address(dst).packed
    return SNAP + b'\x86\xdd' + hdr + ext + tail


def test_type0_ethernet_fig_9_304():
    t = p(T.eth(B, A, 0x0800))
    assert t.ctype == 0 and t.params['da'] == B and t.params['sa'] == A
    assert T.check(t) == []
    msdu = AM.Msdu(B, A, SNAP + b'\x08\x00' + bytes(20), 0)
    assert T.match(t, msdu) is True
    assert T.match(t, AM.Msdu(A, B, msdu.data, 0)) is False
    with pytest.raises(ValueError):
        T.parse(bytes([255, 0, 7]) + bytes(10))                         # не 16 октетов поля


def test_type1_and_type4_ip_fig_9_305_9_310():
    t1 = p(T.ip4(1, '10.0.0.2', '10.0.0.1', 1000, 2000, 0, 17, mask=0x7f))
    assert T.check(t1) == []
    m = AM.Msdu(B, A, ip4_packet('10.0.0.1', '10.0.0.2'), 0)
    assert T.match(t1, m) is True
    assert T.match(t1, AM.Msdu(B, A, ip4_packet('10.0.0.1', '10.0.0.3'), 0)) is False
    t4 = p(T.ip6('ff02::1', mask=0x05))
    assert T.check(t4) == []
    assert T.match(t4, AM.Msdu(B, A, ip6_packet('fe80::1', 'ff02::1'), 0)) is True
    # тип 4 без бита Version — недействителен; DSCP со старшими битами; Flow Label > 20 бит
    assert ours(T.check(p(T.ip4(4, '10.0.0.2', mask=0x04))))
    assert ours(T.check(p(T.ip4(4, '10.0.0.2', dscp=0xc0, mask=0x25))))
    assert ours(T.check(p(T.ip6('ff02::1', flow=0x100000, mask=0x85))))


def test_type1_ipv6_deprecated_and_mask_reserved():
    el = T.encode(255, 1, 0x07, bytes([6]) + bytes(16) + ipaddress.IPv6Address('ff02::1').packed + bytes(7))
    v = T.check(p(el))
    assert [x for _, x in v] == ['model']                               # «deprecated and replaced by … Type 4»
    assert ours(T.check(p(T.encode(255, 1, 0x47, bytes([6]) + bytes(16) + bytes(16) + bytes(7)))))  # бит 6 — Reserved


def test_type2_and_type5_vlan():
    t2 = p(T.encode(255, 2, 1, (0x2005).to_bytes(2, 'big')))
    assert [x for _, x in T.check(t2)] == ['model']                     # «Classifier Type 2 is deprecated»
    tagged = AM.Msdu(B, A, SNAP + b'\x81\x00' + (0x2005).to_bytes(2, 'big') + b'\x08\x00', 0)
    assert T.match(t2, tagged) is True
    t5 = p(T.vlan(1, 0, 5))
    assert T.check(t5) == [] and T.match(t5, tagged) is True
    assert ours(T.check(p(T.vlan(0x11, 0, 5))))                         # старшие биты PCP — Reserved


def test_type3_filter_offset_fig_9_308():
    t = p(T.offset_filter(8, b'\x45\x00', b'\xff\x00'))
    assert t.params['offset'] == 8 and T.check(t) == []
    assert T.match(t, AM.Msdu(B, A, ip4_packet('1.1.1.1', '2.2.2.2'), 0)) is True
    assert ours(T.check(p(T.encode(255, 3, 1, (0).to_bytes(2, 'little') + b'\x01\xff'))))   # маска — Reserved
    with pytest.raises(ValueError):
        T.parse(bytes([255, 3, 0, 0, 0, 1, 2, 3]))                      # нечётная длина Value/Mask


def test_type6_mac_header_and_pv1_types():
    f = {'Address 1': (F.mac_bytes(B), None), 'QoS Control': (b'\x05\x00', b'\x0f\x00')}
    t = p(T.mac_header(f))
    assert set(t.params) == {'Address 1', 'QoS Control'} and T.check(t) == []
    mpdu = (0x0288).to_bytes(2, 'little') + bytes(2) + F.mac_bytes(B) + F.mac_bytes(A) + F.mac_bytes(A) + bytes(2) + \
        b'\x05\x00'
    assert T.match(t, mpdu=mpdu) is True
    assert T.match(t, mpdu=mpdu[:-2] + b'\x06\x00') is False
    ht = p(T.mac_header({'HT Control': (bytes(4), None)}))
    assert [x for _, x in T.check(ht)] == ['model']                     # HT Control у DMG нет
    for ct in (7, 8, 9):
        tt = p(T.mac_header({'Frame Control': (b'\x00\x00', None)}, ctype=ct))
        assert [x for _, x in T.check(tt)] == ['model']                 # PV1 — S1G
        assert T.match(tt, mpdu=mpdu) is None
    with pytest.raises(ValueError):
        T.parse(bytes([255, 6]) + (2 << 4).to_bytes(3, 'little'))       # Filter Mask без сравнения поля


def test_type10_ip_extensions_fig_9_327():
    t = p(T.ip_ext(17, b'\x03\xe8\x07\xd0', b'\xff\xff\xff\xff'))          # UDP: порты 1000 → 2000
    assert t.params['proto'] == 17 and T.check(t) == []
    assert T.match(t, AM.Msdu(B, A, ip4_packet('1.1.1.1', '2.2.2.2'), 0)) is True
    # IPv6 с Hop-by-Hop перед UDP
    hbh = bytes([17, 0]) + bytes(6)
    udp = (1000).to_bytes(2, 'big') + (2000).to_bytes(2, 'big') + bytes(4)
    assert T.match(t, AM.Msdu(B, A, ip6_packet('::1', 'ff02::1', nh=0, ext=hbh, tail=udp), 0)) is True
    assert T.match(p(T.ip_ext(17, b'\x03\xe8', b'\xff\xff', instance=1)),
                   AM.Msdu(B, A, ip4_packet('1.1.1.1', '2.2.2.2'), 0)) is False      # второго UDP нет


def test_reserved_up_and_type():
    assert ours(T.check(T.Tclas(12, 0, 2, {'sa': A, 'da': B, 'type': 0})))
    assert ours(T.check(T.Tclas(255, 11, 0, {})))


def test_dms_frame_types_and_dms_codec_agree():
    t = DM.tclas_eth('01:00:5e:00:00:01')
    mine = T.parse(DM.encode_tclas(t)[2:])
    assert mine.params['da'] == '01:00:5e:00:00:01'
    assert T.check_in_frame(mine, 'dms') == []
    assert ours(T.check_in_frame(p(T.vlan(1)), 'dms'))                  # DMS — только 0, 1, 4 (11.21.16.2)
