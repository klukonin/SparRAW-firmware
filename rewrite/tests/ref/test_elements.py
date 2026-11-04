# SPDX-License-Identifier: AGPL-3.0-or-later
"""Эталон элементов и тел кадров управления DMG: ожидания — из текста 802.11-2020 (9.4.2.1 и табл. 9-92, 10.28,
9.4.1.x, 9.4.2.2/24/25/48, 9.4.2.126–9.4.2.135, 9.3.3 табл. 9-33…9-42): номера ID, позиции бит по рисункам,
примеры RSNE из NOTE 9.4.2.24.1, номера Order из таблиц тел кадров."""
from fractions import Fraction as Fr

import pytest

from . import elements as E

AP_MAC = '02:11:22:33:44:55'
STA_MAC = '02:aa:bb:cc:dd:ee'


# ---- 9.4.2.1 / табл. 9-92 ----
@pytest.mark.parametrize('name,key', [
    ('SSID', (0, None)), ('RSN', (48, None)), ('Timeout Interval', (56, None)), ('Management MIC', (76, None)),
    ('Extended Schedule', (144, None)), ('Next DMG ATI', (147, None)), ('DMG Capabilities', (148, None)),
    ('DMG Operation', (151, None)), ('DMG BSS Parameter Change', (152, None)),
    ('Antenna Sector ID Pattern', (190, None)), ('Vendor Specific', (221, None)), ('Fragment', (242, None)),
    ('FILS Session', (255, 4)), ('MSCS Descriptor', (255, 88)), ('OCI', (255, 54)),
])
def test_element_ids_table_9_92(name, key):
    assert E.element_key(name) == key


def test_dmg_elements_extensible_not_fragmentable():
    for n in ('DMG Capabilities', 'DMG Operation', 'Extended Schedule', 'Next DMG ATI', 'DMG BSS Parameter Change'):
        _, ext, frag = E.ELEMENT_INFO[E.element_key(n)]
        assert ext == 'Y' and frag is False      # табл. 9-92: Extensible Yes, Fragmentable No
    assert E.ELEMENT_INFO[(0, None)][1:] == ('N', False)   # SSID: No / No


def test_ssid_element_fig_9_146():
    assert E.encode_ssid('abc') == bytes([0, 3]) + b'abc'
    assert E.encode_ssid(b'') == bytes([0, 0])          # wildcard SSID
    assert len(E.encode_ssid(b'x' * 32)) == 34
    with pytest.raises(ValueError):
        E.encode_ssid(b'x' * 33)


def test_extension_element_length_counts_ext_octet():
    # 9.4.2.1: Length — все октеты после Length, включая Element ID Extension
    assert E.encode_element(255, b'\x01\x02', ext=4) == bytes([255, 3, 4, 1, 2])
    with pytest.raises(ValueError):
        E.encode_element(255, b'')                       # 255 без Extension
    with pytest.raises(ValueError):
        E.encode_element(0, b'', ext=1)
    assert E.parse_elements(bytes([255, 3, 4, 1, 2])) == [E.Element(255, 4, b'\x01\x02')]


def test_element_too_long():
    E.encode_element(221, b'\0' * 255)
    with pytest.raises(ValueError):
        E.encode_element(221, b'\0' * 256)
    with pytest.raises(ValueError):
        E.encode_element(255, b'\0' * 255, ext=1)        # 254 + Extension


def test_parse_truncated():
    with pytest.raises(ValueError):
        E.parse_elements(bytes([0, 5, 1, 2]))
    with pytest.raises(ValueError):
        E.parse_elements(bytes([0]))


def test_unknown_element_kept_for_skip():
    # 10.28.6: неизвестный (зарезервированный) ID пропускается, разбор продолжается
    els = E.parse_elements(bytes([2, 1, 0xAA, 0, 1, 0x41]))
    assert [e.eid for e in els] == [2, 0] and els[1].info == b'A'


# ---- 10.28.11 / 10.28.12: фрагментация ----
def test_fragmentation_fig_10_40():
    info = bytes(range(256)) + bytes(44)                 # L = 300
    b = E.encode_fragmented(221, info)
    # ведущий: 255 октетов; M = ⌊300/255⌋ = 1 → 0 Fragment по 255; N = 1 → остаток 300 mod 255 = 45
    assert b[:2] == bytes([221, 255]) and b[257:259] == bytes([242, 45]) and len(b) == 2 + 255 + 2 + 45
    assert E.parse_elements(b) == [E.Element(221, None, info)]


def test_fragmentation_fig_10_41_with_ext():
    info = bytes(300)
    b = E.encode_fragmented(255, info, ext=5)
    # с Extension: ведущий 254 октета информации, остаток (L − 254) mod 255 = 46
    assert b[:3] == bytes([255, 255, 5]) and b[257:259] == bytes([242, 46])
    assert E.parse_elements(b) == [E.Element(255, 5, info)]


def test_fragmentation_exact_multiple_and_fit():
    b = E.encode_fragmented(221, bytes(510))             # M = 2, N = 0: ведущий + один Fragment по 255
    assert len(b) == 2 * 257 and b[255 + 2] == 242 and b[255 + 3] == 255
    assert E.encode_fragmented(221, bytes(255)) == E.encode_element(221, bytes(255))   # помещается — без фрагментов
    # Fragment после короткого элемента — не продолжение (10.28.11 NOTE)
    els = E.parse_elements(bytes([221, 1, 0, 242, 1, 9]))
    assert [e.eid for e in els] == [221, 242]


# ---- 9.4.2.24.1: примеры RSNE из NOTE ----
CCMP = bytes.fromhex('000fac04')
DOT1X = bytes.fromhex('000fac01')


def test_rsne_note_example_1():
    want = bytes.fromhex('30 14 0100 000fac04 0100 000fac04 0100 000fac01 0000'.replace(' ', ''))
    assert E.encode_rsne(group_data=CCMP, pairwise=[CCMP], akm=[DOT1X], capabilities=0) == want
    r = E.parse_rsne(want[2:])
    assert r == {'version': 1, 'group_data': CCMP, 'pairwise': [CCMP], 'akm': [DOT1X], 'capabilities': 0}


def test_rsne_note_example_no_caps():
    want = bytes.fromhex('3012' '0100' '000fac01' '0100' '000fac00' '0100' '000fac01')
    assert E.encode_rsne(group_data=bytes.fromhex('000fac01'), pairwise=[bytes.fromhex('000fac00')],
                         akm=[DOT1X]) == want


def test_rsne_note_example_pmkid():
    pmkid = bytes(range(1, 17))
    want = bytes.fromhex('3026' '0100' '000fac04' '0100' '000fac04' '0100' '000fac01' '0100' '0100') + pmkid
    assert E.encode_rsne(group_data=CCMP, pairwise=[CCMP], akm=[DOT1X], capabilities=1, pmkids=[pmkid]) == want
    assert E.parse_rsne(want[2:])['pmkids'] == [pmkid]


def test_rsne_note_example_bip():
    want = bytes.fromhex('301a' '0100' '000fac04' '0100' '000fac04' '0100' '000fac01' '8000' '0000' '000fac06')
    assert E.encode_rsne(group_data=CCMP, pairwise=[CCMP], akm=[DOT1X], capabilities=0x80, pmkids=[],
                         group_mgmt=bytes.fromhex('000fac06')) == want
    assert E.parse_rsne(want[2:])['group_mgmt'] == bytes.fromhex('000fac06')


def test_rsne_gap_forbidden():
    # «If any nonzero-length field is absent, then none of the subsequent fields are included»
    with pytest.raises(ValueError):
        E.encode_rsne(group_data=CCMP, akm=[DOT1X])


# ---- 9.4.2.25, 9.4.2.48 ----
def test_vendor_specific():
    assert E.encode_vendor(b'\x00\x50\xf2', b'\x01') == bytes([221, 4, 0, 0x50, 0xf2, 1])
    with pytest.raises(ValueError):
        E.encode_vendor(b'\x00\x50')


def test_tie_fig_9_364():
    assert E.encode_tie(E.TIE_ASSOC_COMEBACK, 100) == bytes([56, 5, 3, 100, 0, 0, 0])
    assert E.parse_tie(bytes([3, 100, 0, 0, 0])) == (3, 100)
    assert E.tie_value_us(3, 100) == 102400          # TU = 1024 мкс
    assert E.tie_value_us(2, 1) == 1000000           # Key lifetime — секунды
    for t in (0, 5, 255):
        with pytest.raises(ValueError):
            E.encode_tie(t, 1)


# ---- 9.4.2.126 DMG BSS Parameter Change ----
def test_bss_param_change_fig_9_547():
    b = E.encode_bss_param_change(move=1, size=1, tbtt_offset=0x12345678, bi_duration=100)
    assert b == bytes([152, 7, 0b11, 0x78, 0x56, 0x34, 0x12, 100, 0])
    assert E.parse_bss_param_change(b[2:])['bi_duration'] == 100
    assert E.encode_bss_param_change(1, 0, 5)[2] == 0b01
    with pytest.raises(ValueError):
        E.encode_bss_param_change(1, 0, 5, bi_duration=100)   # BI Duration зарезервирован при Size = 0


# ---- 9.4.2.127 DMG Capabilities ----
def _cap(**over):
    sc = dict(max_sc_rx_mcs=12, max_sc_tx_mcs=12, code_rate_13_16=1)
    sc.update(over.pop('sc', {}))
    kw = dict(sta_address=STA_MAC, aid=0, sta_cap=sc, ap_pcp_cap={}, beam_tracking_time_limit=0,
              ext_sc_mcs={}, max_basic_amsdu=0, max_short_amsdu=0)
    kw.update(over)
    return E.DmgCapabilities(**kw)


def _stacap_int(el):
    return int.from_bytes(el[2 + 7:2 + 15], 'little')


def test_dmg_cap_length_fig_9_549():
    b = E.encode_dmg_capabilities(_cap())
    assert b[0] == 148 and b[1] == 22 and len(b) == 24
    assert b[2:8] == bytes.fromhex('02aabbccddee')


@pytest.mark.parametrize('field,val,bit', [
    ('reverse_direction', 1, 0), ('tpc', 1, 2), ('num_rx_dmg_antennas', 3, 4), ('fast_link_adaptation', 1, 6),
    ('total_num_sectors', 127, 7), ('rxss_length', 63, 14), ('dmg_antenna_reciprocity', 1, 20),
    ('max_ampdu_len_exp', 5, 21), ('min_mpdu_start_spacing', 7, 24), ('ba_flow_control', 1, 27),
    ('low_power_sc', 1, 48), ('code_rate_13_16', 1, 49), ('pi2_8psk', 1, 50), ('appdu', 1, 53),
    ('heartbeat', 1, 54), ('supports_other_aid', 1, 55), ('antenna_pattern_reciprocity', 1, 56),
    ('heartbeat_elapsed', 7, 57), ('grant_ack', 1, 60), ('rxss_tx_rate', 1, 61), ('epd', 1, 62),
])
def test_dmg_sta_cap_bits_fig_9_550(field, val, bit):
    base = _stacap_int(E.encode_dmg_capabilities(_cap(sc={'code_rate_13_16': 0})))
    got = _stacap_int(E.encode_dmg_capabilities(_cap(sc={'code_rate_13_16': 0, field: val})))
    assert got ^ base == val << bit


def test_supported_mcs_set_fig_9_552():
    # B28–B32 Maximum SC Rx MCS, B38–B42 Maximum SC Tx MCS (внутри DMG STA Capability Information)
    v = _stacap_int(E.encode_dmg_capabilities(_cap(sc={'max_sc_rx_mcs': 12, 'max_sc_tx_mcs': 9,
                                                       'code_rate_13_16': 0})))
    assert (v >> 28) & 31 == 12 and (v >> 38) & 31 == 9


def test_ap_pcp_cap_fig_9_553():
    b = E.encode_dmg_capabilities(_cap(ap_pcp_cap={'tddti': 1, 'pseudo_static': 1, 'max_associated_sta': 254,
                                                   'power_source': 1, 'centralized_clustering': 1}))
    v = int.from_bytes(b[2 + 15:2 + 17], 'little')
    assert v == 1 | 2 | 254 << 3 | 1 << 11 | 1 << 14


def test_ext_sc_mcs_fig_9_554_and_amsdu():
    b = E.encode_dmg_capabilities(_cap(ext_sc_mcs={'max_ext_sc_tx_mcs': 7, 'code_rate_7_8_tx': 1,
                                                   'max_ext_sc_rx_mcs': 2}, max_basic_amsdu=7, max_short_amsdu=6,
                                       beam_tracking_time_limit=0x1234))
    assert b[2 + 17:2 + 19] == bytes([0x34, 0x12])
    assert b[2 + 19] == 7 | 1 << 3 | 2 << 4
    assert b[2 + 20:] == bytes([7, 6])


def test_dmg_cap_roundtrip_and_extensible_tail():
    c = _cap(aid=5, sc={'reverse_direction': 1, 'rxss_length': 3}, ap_pcp_cap={'tddti': 1})
    b = E.encode_dmg_capabilities(c)
    assert E.parse_dmg_capabilities(b[2:]) == E.parse_dmg_capabilities(b[2:] + b'\xff\xff')   # 10.28.8
    p = E.parse_dmg_capabilities(b[2:])
    assert p.aid == 5 and p.sta_address == STA_MAC and p.sta_cap['rxss_length'] == 3
    with pytest.raises(ValueError):
        E.parse_dmg_capabilities(b[2:-1])


def test_dmg_cap_derived_values():
    assert E.rxss_sectors({'rxss_length': 0}) == 2 and E.rxss_sectors({'rxss_length': 63}) == 128
    assert E.total_sectors({'total_num_sectors': 63}) == 64
    assert E.rx_dmg_antennas({'num_rx_dmg_antennas': 0}) == 1
    assert E.max_ampdu_length({'max_ampdu_len_exp': 0}) == 8191           # 2^13 − 1
    assert E.max_ampdu_length({'max_ampdu_len_exp': 5}) == 262143         # 2^18 − 1
    assert E.heartbeat_elapsed_ms(0) == 0 and E.heartbeat_elapsed_ms(1) == Fr(1, 2)
    assert E.heartbeat_elapsed_ms(7) == 32
    assert E.MAX_BASIC_AMSDU[7] == 256 and E.MAX_SHORT_AMSDU[6] == 1024 and E.MIN_MPDU_SPACING_NS[7] == 1024


def test_supported_sc_mcs():
    sc = {'max_sc_rx_mcs': 12, 'max_sc_tx_mcs': 8, 'code_rate_13_16': 0}
    ext = {'max_ext_sc_rx_mcs': 3, 'code_rate_7_8_rx': 0, 'max_ext_sc_tx_mcs': 0, 'code_rate_7_8_tx': 0}
    # табл. 20-15: кодовая скорость 13/16 — MCS 5, 9, 12.1, 12.5; без 7/8 нет MCS 9.1 и 12.2 (9.4.2.127.5)
    assert E.supported_sc_mcs(sc, ext, 'rx') == {str(m) for m in range(1, 13)} - {'5', '9'}
    assert E.supported_sc_mcs(sc, ext, 'tx') == {'1', '2', '3', '4', '6', '7', '8'}
    ext['code_rate_7_8_rx'] = 1
    assert E.supported_sc_mcs(sc, ext, 'rx') >= {'9.1', '12.2'} and '12.1' not in E.supported_sc_mcs(sc, ext, 'rx')
    sc['code_rate_13_16'] = 1
    ext.update(max_ext_sc_tx_mcs=7, code_rate_7_8_tx=0)
    assert E.supported_sc_mcs(sc, ext, 'tx') == {str(m) for m in range(1, 9)} | {'12.1', '12.3', '12.4', '12.5',
                                                                                  '12.6'}


def test_dmg_cap_validate():
    assert E.validate_dmg_capabilities(_cap(), E.ASSOC_REQ, E.ROLE_STA) == []
    assert any('AID' in s for s in E.validate_dmg_capabilities(_cap(aid=3), E.ASSOC_REQ, E.ROLE_STA))
    assert E.validate_dmg_capabilities(_cap(aid=3), E.ASSOC_RESP, E.ROLE_AP) == []
    assert any('4…12' in s for s in E.validate_dmg_capabilities(_cap(sc={'max_sc_rx_mcs': 3})))
    assert any('9.4.2.127.5' in s for s in E.validate_dmg_capabilities(
        _cap(sc={'max_sc_tx_mcs': 11}, ext_sc_mcs={'max_ext_sc_tx_mcs': 2})))
    assert E.validate_dmg_capabilities(_cap(sc={'max_sc_tx_mcs': 11}, ext_sc_mcs={'max_ext_sc_tx_mcs': 1})) == []
    assert any('Pseudo-static' in s for s in E.validate_dmg_capabilities(_cap(ap_pcp_cap={'pseudo_static': 1})))
    assert any('9-253' in s for s in E.validate_dmg_capabilities(_cap(max_basic_amsdu=8)))
    assert any('9-254' in s for s in E.validate_dmg_capabilities(_cap(max_short_amsdu=7)))
    assert any('9.2.2' in s for s in E.validate_dmg_capabilities(_cap(sc={'_r52': 1})))


# ---- 9.4.2.128 DMG Operation ----
def test_dmg_operation_fig_9_555():
    b = E.encode_dmg_operation({'tddti': 1, 'pseudo_static': 1, 'pcp_handover': 1},
                               {'ps_request_suspension_interval': 2, 'min_bhi_duration': 0x1234,
                                'broadcast_sta_info_duration': 3, 'assoc_resp_confirm_time': 4,
                                'min_pp_duration': 5, 'sp_idle_timeout': 6, 'max_lost_beacons': 7})
    assert b == bytes([151, 10, 0b111, 0, 2, 0x34, 0x12, 3, 4, 5, 6, 7])
    op, cfg = E.parse_dmg_operation(b[2:])
    assert op['pcp_handover'] == 1 and cfg['min_bhi_duration'] == 0x1234
    assert E.assoc_resp_confirm_time_us(cfg) == 200000       # 4 × 50 мс
    assert E.validate_dmg_operation(op, cfg) == []
    assert E.validate_dmg_operation({'tddti': 0, 'pseudo_static': 1, 'pcp_handover': 0, '_r3': 0}, cfg)


# ---- 9.4.2.131 Extended Schedule ----
def _alloc(type_=E.ALLOC_CBAP, aid=0, src=255, dst=255, start=0, dur=1000, n=1, per=0, **ctrl):
    c = {'allocation_id': aid, 'allocation_type': type_, 'pcp_active': 1}
    c.update(ctrl)
    return E.Allocation(c, 0, src, dst, start, dur, n, per)


def test_allocation_fig_9_563_564():
    a = E.Allocation({'allocation_id': 3, 'allocation_type': E.ALLOC_SP, 'pseudo_static': 1, 'truncatable': 1,
                      'extendable': 1, 'pcp_active': 1, 'lp_sc_used': 1}, 0xBEEF, 1, 2, 0x11223344, 500, 4, 25000)
    b = E.encode_allocation(a)
    assert len(b) == 15
    assert int.from_bytes(b[:2], 'little') == 3 | 1 << 7 | 1 << 8 | 1 << 9 | 1 << 10 | 1 << 11
    assert b[2:] == bytes([0xEF, 0xBE, 1, 2, 0x44, 0x33, 0x22, 0x11, 0xF4, 0x01, 4, 0xA8, 0x61])
    assert E.parse_allocation(b) == E.Allocation({**a.ctrl, '_r12': 0}, *a[1:])


def test_allocation_type_table_9_257():
    # Бит 4 = 1, биты 5, 6 = 0 → CBAP; бит 5 = 1 → 1,08 ГГц
    for t, bits in ((E.ALLOC_SP, 0), (E.ALLOC_CBAP, 0x10), (E.ALLOC_SP_1G08, 0x20), (E.ALLOC_CBAP_1G08, 0x30)):
        assert int.from_bytes(E.encode_allocation(_alloc(t, pcp_active=0))[:2], 'little') == bits


def test_extended_schedule_split():
    allocs = [_alloc(start=i * 2000, src=1, dst=2, aid=i % 16, type_=E.ALLOC_SP) for i in range(18)]
    b = E.encode_extended_schedule(allocs)
    # 255 // 15 = 17 полей в первом элементе, 1 — во втором
    assert b[0] == 144 and b[1] == 255 and b[257] == 144 and b[258] == 15 and len(b) == 257 + 17
    els = E.parse_elements(b)
    assert E.parse_extended_schedule([e.info for e in els]) == \
        [E.Allocation({**a.ctrl, 'pseudo_static': 0, 'truncatable': 0, 'extendable': 0, 'lp_sc_used': 0,
                       '_r12': 0}, *a[1:]) for a in allocs]
    with pytest.raises(ValueError):
        E.encode_extended_schedule([])


def test_extended_schedule_validate():
    ok = [_alloc(start=0, dur=65535), _alloc(E.ALLOC_SP, aid=1, src=0, dst=1, start=70000, dur=32767)]
    assert E.validate_extended_schedule(ok) == []
    bad = {
        'id0': [_alloc(aid=1)],                                                 # широковещательный CBAP, ID ≠ 0
        'dur': [_alloc(E.ALLOC_SP, aid=1, src=0, dst=1, dur=32768)],            # SP > 32 767
        'zero': [_alloc(dur=0)],
        'type': [_alloc(4)],                                                    # табл. 9-257: зарезервирован
        'dup': [_alloc(E.ALLOC_SP, 1, 1, 2, 0), _alloc(E.ALLOC_SP, 1, 1, 2, 5000)],
        'order': [_alloc(start=5000), _alloc(E.ALLOC_SP, 1, 1, 2, start=1000)],
        'trunc_cbap': [_alloc(truncatable=1)],
        'period': [_alloc(per=100)],
        'pcp_active_ap': [_alloc(pcp_active=0)],
        'sp_src_bcast': [_alloc(E.ALLOC_SP, 1, 255, 3)],
    }
    for k, a in bad.items():
        assert E.validate_extended_schedule(a), k
    # PCP: PCP Active не обязателен для CBAP без участия PCP и без Truncatable/Extendable
    assert E.validate_extended_schedule([_alloc(pcp_active=0)], role=E.ROLE_PCP) == []
    assert E.validate_extended_schedule([_alloc(E.ALLOC_SP, 1, 1, 2, pcp_active=0, extendable=1)], role=E.ROLE_PCP)
    assert E.validate_extended_schedule([_alloc(E.ALLOC_SP, 1, 0, 2, pcp_active=0)], role=E.ROLE_PCP)
    # SP с обоими широковещательными AID допустим (9.4.2.131)
    assert E.validate_extended_schedule([_alloc(E.ALLOC_SP, 1, 255, 255)]) == []


def test_extended_schedule_order_wrap():
    # СПОРНО-правило: переход младших 32 бит TSF через 2^32 — не нарушение порядка
    a = [_alloc(start=2 ** 32 - 100), _alloc(E.ALLOC_SP, 1, 1, 2, start=50)]
    assert E.validate_extended_schedule(a) == []


def test_allocation_blocks():
    a = _alloc(E.ALLOC_SP, 1, 1, 2, start=1000, dur=200, n=3, per=500)
    assert E.allocation_blocks(a) == [(1000, 1200), (1500, 1700), (2000, 2200)]


# ---- 9.4.2.135 Next DMG ATI ----
def test_next_dmg_ati_fig_9_574():
    b = E.encode_next_dmg_ati(0x01020304, 0x0506)
    assert b == bytes([147, 6, 4, 3, 2, 1, 6, 5])
    assert E.parse_next_dmg_ati(b[2:]) == (0x01020304, 0x0506)


# ---- 9.4.1.4 / 9.4.1.46: Capability Information (DMG) ----
def test_capinfo_dmg_fig_9_86_133():
    ci = {'dmg_params': {'bss_type': 3, 'cbap_only': 1, 'cbap_source': 1, 'dmg_privacy': 1,
                         'ecapc_policy_enforced': 1}, 'spectrum_mgmt': 1, 'triggered_unscheduled_ps': 1,
          'radio_measurement': 1, 'epd': 1}
    assert int.from_bytes(E.encode_capinfo_dmg(ci), 'little') == 0b111111 | 1 << 8 | 1 << 9 | 1 << 12 | 1 << 13
    p = E.parse_capinfo_dmg(E.encode_capinfo_dmg(ci))
    assert p['dmg_params']['bss_type'] == 3 and p['epd'] == 1


@pytest.mark.parametrize('frame,role,bss_type', [
    (E.PROBE_RESP, E.ROLE_AP, 3), (E.ASSOC_RESP, E.ROLE_AP, 3), (E.REASSOC_RESP, E.ROLE_PCP, 2),
    (E.PROBE_RESP, E.ROLE_PCP, 2), (E.PROBE_RESP, E.ROLE_IBSS, 1), (E.ASSOC_REQ, E.ROLE_STA, 0),
])
def test_capinfo_bss_type_table_9_68(frame, role, bss_type):
    ci = E.parse_capinfo_dmg(E.encode_capinfo_dmg({'dmg_params': {'bss_type': bss_type}}))
    assert E.validate_capinfo_dmg(ci, frame, role) == []
    ci['dmg_params']['bss_type'] = (bss_type + 1) % 4
    assert E.validate_capinfo_dmg(ci, frame, role)


def test_capinfo_tups_needs_rd():
    ci = E.parse_capinfo_dmg(E.encode_capinfo_dmg({'triggered_unscheduled_ps': 1}))
    assert E.validate_capinfo_dmg(ci, E.ASSOC_REQ, E.ROLE_STA, rd=0)
    assert E.validate_capinfo_dmg(ci, E.ASSOC_REQ, E.ROLE_STA, rd=1) == []


# ---- 9.3.3: таблицы порядка ----
@pytest.mark.parametrize('frame,name,order', [
    (E.ASSOC_REQ, 'SSID', 3), (E.ASSOC_REQ, 'RSN', 8), (E.ASSOC_REQ, 'DMG Capabilities', 20),
    (E.ASSOC_REQ, 'Fast BSS Transition', 42), (E.ASSOC_REQ, 'MSCS Descriptor', 45),
    (E.ASSOC_RESP, 'Timeout Interval', 14), (E.ASSOC_RESP, 'DMG Capabilities', 25),
    (E.ASSOC_RESP, 'DMG Operation', 26), (E.ASSOC_RESP, 'Neighbor Report', 28),
    (E.ASSOC_RESP, 'MSCS Descriptor', 56),
    (E.REASSOC_REQ, 'SSID', 4), (E.REASSOC_REQ, 'DMG Capabilities', 25), (E.REASSOC_REQ, 'OCI', 46),
    (E.REASSOC_RESP, 'DMG Capabilities', 28), (E.REASSOC_RESP, 'DMG Operation', 29),
    (E.REASSOC_RESP, 'MSCS Descriptor', 60),
    (E.PROBE_REQ, 'SSID', 1), (E.PROBE_REQ, 'Multi-band', 14), (E.PROBE_REQ, 'DMG Capabilities', 15),
    (E.PROBE_REQ, 'Supplemental Class 2 Capabilities', 33),
    (E.PROBE_RESP, 'SSID', 4), (E.PROBE_RESP, 'RSN', 16), (E.PROBE_RESP, 'DMG Capabilities', 54),
    (E.PROBE_RESP, 'DMG Operation', 55), (E.PROBE_RESP, 'Antenna Sector ID Pattern', 57),
    (E.PROBE_RESP, 'Service Hash', 91), (E.PROBE_RESP, 'RSN Extension', 92),   # 2020: оба 91; 2024 — 92
    (E.AUTH, 'Challenge text', 10), (E.AUTH, 'Timeout Interval', 14), (E.AUTH, 'Neighbor Report', 17),
    (E.AUTH, 'Anti-Clogging Token Container', 24),
])
def test_order_numbers(frame, name, order):
    assert E.ORDER_RANK[frame][E.element_key(name)] == order


def test_vendor_specific_last():
    assert E.ORDER_RANK[E.ASSOC_REQ][(221, None)] > 45
    assert E.ORDER_RANK[E.PROBE_RESP][(221, None)] > 91
    assert E.ORDER_RANK[E.DEAUTH][(221, None)] < E.ORDER_RANK[E.DEAUTH][(76, None)]   # Last − 1 < Last (MME)


# ---- тела кадров ----
def _ci(bss_type=0, privacy=0):
    return {'dmg_params': {'bss_type': bss_type, 'dmg_privacy': privacy}}


def _caps_el(aid=0):
    return E.encode_dmg_capabilities(_cap(aid=aid))


OP_EL = E.encode_dmg_operation({}, {'assoc_resp_confirm_time': 2})
VS_EL = E.encode_vendor(b'\x00\x11\x22', b'x')


def test_assoc_request_body():
    body = E.encode_body(E.ASSOC_REQ, {'capability': _ci(), 'listen_interval': 10},
                         [E.encode_ssid('net'), _caps_el(), VS_EL])
    assert body[:4] == bytes([0, 0, 10, 0])
    fx, els = E.parse_body(E.ASSOC_REQ, body)
    assert fx['listen_interval'] == 10 and [e.eid for e in els] == [0, 148, 221]
    assert E.check_body(E.ASSOC_REQ, body, E.ROLE_STA) == []


@pytest.mark.parametrize('elements,needle', [
    ([_caps_el()], 'SSID'),                                                        # SSID обязателен
    ([E.encode_ssid('n')], 'DMG Capabilities'),                                    # DMG Capabilities обязателен
    ([_caps_el(), E.encode_ssid('n')], 'порядок'),
    ([E.encode_ssid('n'), VS_EL, _caps_el()], 'порядок'),                          # Vendor Specific — последним
    ([E.encode_ssid('n'), bytes([1, 1, 0x82]), _caps_el()], 'не передаётся DMG'),  # Supported Rates
    ([E.encode_ssid('n'), bytes([50, 1, 0x82]), _caps_el()], 'не передаётся DMG'),
    ([E.encode_ssid('n'), _caps_el(), OP_EL], 'не предусмотрен'),                  # DMG Operation не в 9-34
    ([E.encode_ssid('n'), _caps_el(), _caps_el()], 'повторяется'),
    ([E.encode_ssid('n'), _caps_el(aid=7)], 'AID'),                                # AID зарезервирован
])
def test_assoc_request_violations(elements, needle):
    body = E.encode_body(E.ASSOC_REQ, {'capability': _ci()}, elements)
    v = E.check_body(E.ASSOC_REQ, body, E.ROLE_STA)
    assert any(needle in s for s in v), v


def test_assoc_request_rsna_privacy():
    rsn = E.encode_rsne(group_data=CCMP, pairwise=[CCMP], akm=[DOT1X], capabilities=0)
    body = E.encode_body(E.ASSOC_REQ, {'capability': _ci(privacy=1)}, [E.encode_ssid('n'), rsn, _caps_el()])
    assert E.check_body(E.ASSOC_REQ, body, E.ROLE_STA, rsna=True) == []
    assert E.check_body(E.ASSOC_REQ, body, E.ROLE_STA, rsna=False)
    body = E.encode_body(E.ASSOC_REQ, {'capability': _ci(privacy=1)}, [E.encode_ssid('n'), _caps_el()])
    assert any('RSNE' in s for s in E.check_body(E.ASSOC_REQ, body, E.ROLE_STA, rsna=True))


def test_reassoc_request_current_ap():
    body = E.encode_body(E.REASSOC_REQ, {'capability': _ci(), 'listen_interval': 1, 'current_ap': AP_MAC},
                         [E.encode_ssid('n'), _caps_el()])
    assert body[4:10] == bytes.fromhex('021122334455')
    fx, _ = E.parse_body(E.REASSOC_REQ, body)
    assert fx['current_ap'] == AP_MAC
    assert E.check_body(E.REASSOC_REQ, body, E.ROLE_STA) == []


def test_assoc_response_body():
    body = E.encode_body(E.ASSOC_RESP, {'capability': _ci(3), 'status': 0, 'aid': 1}, [_caps_el(1), OP_EL])
    assert body[:6] == bytes([3, 0, 0, 0, 1, 0])
    assert E.check_body(E.ASSOC_RESP, body, E.ROLE_AP) == []
    for aid in (0, 255, 0xC001):     # 9.4.1.8: DMG — 1…254, без двух старших бит non-DMG
        b = E.encode_body(E.ASSOC_RESP, {'capability': _ci(3), 'status': 0, 'aid': aid}, [_caps_el(), OP_EL])
        assert any('AID' in s for s in E.check_body(E.ASSOC_RESP, b, E.ROLE_AP)), aid
    b = E.encode_body(E.ASSOC_RESP, {'capability': _ci(3), 'status': E.DENIED_NO_MORE_STAS}, [_caps_el(), OP_EL])
    assert E.check_body(E.ASSOC_RESP, b, E.ROLE_AP) == []
    b = E.encode_body(E.ASSOC_RESP, {'capability': _ci(3), 'status': 0, 'aid': 1}, [OP_EL, _caps_el()])
    assert E.check_body(E.ASSOC_RESP, b, E.ROLE_AP)
    b = E.encode_body(E.ASSOC_RESP, {'capability': _ci(3), 'status': 0, 'aid': 1}, [_caps_el()])
    assert any('DMG Operation' in s for s in E.check_body(E.ASSOC_RESP, b, E.ROLE_AP))
    b = E.encode_body(E.ASSOC_RESP, {'capability': _ci(2), 'status': 0, 'aid': 1}, [_caps_el(), OP_EL])
    assert E.check_body(E.ASSOC_RESP, b, E.ROLE_AP)                  # AP с BSS Type = 2
    assert E.check_body(E.ASSOC_RESP, b, E.ROLE_PCP) == []


def test_assoc_response_comeback_tie():
    tie = E.encode_tie(E.TIE_ASSOC_COMEBACK, 1000)
    fx = {'capability': _ci(3, 1), 'status': E.REFUSED_TEMPORARILY}
    good = E.encode_body(E.ASSOC_RESP, fx, [tie, _caps_el(), OP_EL])     # TIE (14) раньше DMG Capabilities (25)
    assert E.check_body(E.ASSOC_RESP, good, E.ROLE_AP, rsna=True, pmf=True) == []
    miss = E.encode_body(E.ASSOC_RESP, fx, [_caps_el(), OP_EL])
    assert any('TIE' in s for s in E.check_body(E.ASSOC_RESP, miss, E.ROLE_AP, rsna=True, pmf=True))
    late = E.encode_body(E.ASSOC_RESP, fx, [_caps_el(), OP_EL, tie])
    assert E.check_body(E.ASSOC_RESP, late, E.ROLE_AP, rsna=True, pmf=True)
    wrong = E.encode_body(E.ASSOC_RESP, fx, [E.encode_tie(E.TIE_REASSOC_DEADLINE, 1), _caps_el(), OP_EL])
    assert E.check_body(E.ASSOC_RESP, wrong, E.ROLE_AP, rsna=True, pmf=True)


def test_probe_request_body():
    body = E.encode_body(E.PROBE_REQ, {}, [E.encode_ssid(b''), _caps_el()])
    assert body[:2] == bytes([0, 0])                         # wildcard SSID первым (Order 1)
    assert E.check_body(E.PROBE_REQ, body, E.ROLE_STA) == []
    body = E.encode_body(E.PROBE_REQ, {}, [_caps_el(), E.encode_ssid(b'')])
    assert E.check_body(E.PROBE_REQ, body, E.ROLE_STA)


def _probe_resp(elements, bss_type=3):
    return E.encode_body(E.PROBE_RESP, {'timestamp': 0x0102030405060708, 'beacon_interval': 100,
                                        'capability': _ci(bss_type)}, elements)


def test_probe_response_body():
    asp = E.encode_element(E.EID_ANTENNA_SECTOR_ID_PATTERN, b'\0\0\0\0')
    body = _probe_resp([E.encode_ssid('n'), _caps_el(), OP_EL, asp, VS_EL])
    assert body[:8] == bytes([8, 7, 6, 5, 4, 3, 2, 1]) and body[8:10] == bytes([100, 0])
    assert E.check_body(E.PROBE_RESP, body, E.ROLE_AP) == []
    # Antenna Sector ID Pattern (57) раньше DMG Operation (55) — нарушение
    assert E.check_body(E.PROBE_RESP, _probe_resp([E.encode_ssid('n'), _caps_el(), asp, OP_EL]), E.ROLE_AP)
    # CSA — только для non-DMG STA (табл. 9-39, 10)
    csa = E.encode_element(37, b'\0\0\0')
    assert any('не передаётся DMG' in s for s in
               E.check_body(E.PROBE_RESP, _probe_resp([E.encode_ssid('n'), csa, _caps_el(), OP_EL]), E.ROLE_AP))
    assert E.check_body(E.PROBE_RESP, _probe_resp([E.encode_ssid('n'), _caps_el()]), E.ROLE_AP)


def test_probe_response_service_hash_before_rsnx():
    """Табл. 9-39 (2020) даёт обоим номер 91; 802.11-2024 табл. 9-69 уточняет: Service Hash 91, RSN Extension 92 —
    следуем уточнению 2024 (PLAN.md «Принятые трактовки» №15)."""
    sh = E.encode_element(255, b'\0' * 6, ext=16)
    rsnx = E.encode_element(244, b'\x20')
    body = _probe_resp([E.encode_ssid('n'), _caps_el(), OP_EL, sh, rsnx])
    assert E.check_body(E.PROBE_RESP, body, E.ROLE_AP) == []
    body = _probe_resp([E.encode_ssid('n'), _caps_el(), OP_EL, rsnx, sh])
    assert E.check_body(E.PROBE_RESP, body, E.ROLE_AP) != []


def test_probe_response_requested_elements_tail():
    tim = E.encode_element(5, b'\0\0\0\0')         # не из табл. 9-39 — допустим только как запрошенный, в конце
    body = _probe_resp([E.encode_ssid('n'), _caps_el(), OP_EL, VS_EL, tim])
    assert E.check_body(E.PROBE_RESP, body, E.ROLE_AP) == []
    assert E.check_body(E.PROBE_RESP, body, E.ROLE_AP, requested={(5, None)}) == []
    assert E.check_body(E.PROBE_RESP, body, E.ROLE_AP, requested=set())
    body = _probe_resp([E.encode_ssid('n'), _caps_el(), tim, OP_EL])
    assert E.check_body(E.PROBE_RESP, body, E.ROLE_AP, requested={(5, None)})


def test_auth_open_system():
    b1 = E.encode_body(E.AUTH, {'algorithm': 0, 'seq': 1, 'status': 0})
    assert b1 == bytes([0, 0, 1, 0, 0, 0])
    assert E.check_body(E.AUTH, b1, E.ROLE_STA) == []
    assert E.check_body(E.AUTH, E.encode_body(E.AUTH, {'seq': 1, 'status': 1}), E.ROLE_STA)
    assert E.check_body(E.AUTH, E.encode_body(E.AUTH, {'seq': 3}), E.ROLE_AP)
    nr = E.encode_element(52, bytes(13))
    st82 = {'seq': 2, 'status': E.REJECTED_WITH_SUGGESTED_BSS_TRANSITION}
    assert E.check_body(E.AUTH, E.encode_body(E.AUTH, st82, [nr]), E.ROLE_AP) == []
    assert E.check_body(E.AUTH, E.encode_body(E.AUTH, st82), E.ROLE_AP)
    assert E.check_body(E.AUTH, E.encode_body(E.AUTH, {'seq': 2}, [nr]), E.ROLE_AP)
    assert E.check_body(E.AUTH, E.encode_body(E.AUTH, {'seq': 2}, [VS_EL]), E.ROLE_AP) == []
    mb = E.encode_element(158, bytes(22))
    assert E.check_body(E.AUTH, E.encode_body(E.AUTH, {'seq': 2}, [mb]), E.ROLE_AP)   # СПОРНО: табл. 9-41


def test_auth_shared_key_challenge():
    ct = E.encode_element(16, bytes(128))
    assert E.check_body(E.AUTH, E.encode_body(E.AUTH, {'algorithm': 1, 'seq': 2}, [ct]), E.ROLE_AP) == []
    assert E.check_body(E.AUTH, E.encode_body(E.AUTH, {'algorithm': 1, 'seq': 2}), E.ROLE_AP)
    assert E.check_body(E.AUTH, E.encode_body(E.AUTH, {'algorithm': 1, 'seq': 1}, [ct]), E.ROLE_STA)


def test_auth_sae_not_modelled():
    with pytest.raises(NotImplementedError):
        E.parse_body(E.AUTH, bytes([3, 0, 1, 0, 0, 0]))


@pytest.mark.parametrize('frame', [E.DEAUTH, E.DISASSOC])
def test_deauth_disassoc(frame):
    mme = E.encode_element(76, bytes(16))
    b = E.encode_body(frame, {'reason': E.LEAVING_NETWORK_DEAUTH}, [VS_EL, mme])
    assert b[:2] == bytes([3, 0])
    assert E.check_body(frame, b, E.ROLE_STA) == []
    assert E.check_body(frame, E.encode_body(frame, {'reason': 3}, [mme, VS_EL]), E.ROLE_STA)
    assert E.check_body(frame, E.encode_body(frame, {'reason': 0}), E.ROLE_STA)          # 0 — Reserved
    assert E.check_body(frame, E.encode_body(frame, {'reason': 3}, [E.encode_ssid('x')]), E.ROLE_STA)


def test_body_short():
    with pytest.raises(ValueError):
        E.parse_body(E.ASSOC_RESP, bytes(5))
