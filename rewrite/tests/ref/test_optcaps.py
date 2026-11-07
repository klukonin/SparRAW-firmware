# SPDX-License-Identifier: AGPL-3.0-or-later
"""Необязательные возможности не open (ref/optcaps): биты и элементы по табл. 9-153, рис. 9-86, 9-592, табл. 9-92,
9-457, 9-479, 9-425, 9-434."""
from . import capelems as CE
from . import elements as E
from . import optcaps as OC

C = '02:00:00:00:00:0c'


def groups(v):
    return sorted(g for g, _ in v)


def test_ext_cap_ps_bits_by_table_9_153():
    # биты, чьё описание ссылается на 11.2 (Power management) или PSMP (10.30)
    assert sorted(OC.EXT_CAP_OFF) == [4, 6, 11, 17, 18, 28, 29, 45]
    for b in OC.EXT_CAP_OFF:
        assert b in CE.EXT_CAP_BIT.values()
    assert CE.EXT_CAP_BIT['WNM Sleep Mode'] == 17 and CE.EXT_CAP_BIT['TIM Broadcast'] == 18
    assert CE.EXT_CAP_BIT['U-APSD Coexistence'] == 45 and CE.EXT_CAP_BIT['TDLS Peer PSM Support'] == 29
    el = CE.encode_ext_cap(bits=['BSS Transition', 'WNM Sleep Mode', 'TIM Broadcast', 'Interworking'])
    v = OC.check_ext_cap(el[2:])
    assert groups(v) == ['ps', 'ps'] and 'бит 17' in v[0][1] and 'бит 18' in v[1][1]
    assert OC.check_ext_cap(CE.encode_ext_cap(bits=['BSS Transition', 'TFS', 'Extended Channel Switching'])[2:]) == []


def test_capinfo_triggered_unscheduled_ps():
    ci = E.parse_capinfo_dmg(E.encode_capinfo_dmg({'triggered_unscheduled_ps': 1, 'radio_measurement': 1}))
    assert groups(OC.check_capinfo(ci)) == ['ps']
    assert OC.check_capinfo(E.parse_capinfo_dmg(E.encode_capinfo_dmg({'radio_measurement': 1}))) == []


def test_dmg_capabilities_has_no_off_bits():
    # 9.4.2.127.2/.3: в DMG Capabilities битов relay/MMS/FST/PS нет; Heartbeat, Power Source и др. — не ограничиваются
    names = {n for n, _ in E.DMG_STA_CAP} | {n for n, _ in E.DMG_AP_PCP_CAP}
    assert set(OC.DMG_CAP_NOT_OFF) <= names
    sc = {n: 0 for n, _ in E.DMG_STA_CAP}
    sc.update(heartbeat=1, heartbeat_elapsed=3, max_sc_rx_mcs=12, max_sc_tx_mcs=12)
    ap = {n: 0 for n, _ in E.DMG_AP_PCP_CAP}
    ap.update(power_source=1, pcp_forwarding=1, decentralized_clustering=1)
    el = E.encode_dmg_capabilities(E.DmgCapabilities(C, 0, sc, ap, 0, {n: 0 for n, _ in E.EXT_SC_MCS}, 0, 0))
    assert OC.check_elements(E.parse_elements(el), 'Association Request') == []


def test_elements_off():
    els = [E.Element(158, None, bytes(20)), E.Element(170, None, bytes(7)), E.Element(167, None, bytes([0b11, 0])),
           E.Element(157, None, bytes(2)), E.Element(143, None, bytes(10)), E.Element(163, None, bytes(10)),
           E.Element(E.EID_SSID, None, b'x')]
    v = OC.check_elements(els, 'Probe Request')
    assert groups(v) == ['fst', 'fst', 'mms', 'ps', 'ps', 'relay', 'relay', 'relay']    # Relay: элемент + 2 бита
    assert any('relay_supporter' in m for _, m in v) and any('relay_client' in m for _, m in v)
    assert all('решение 2026-11-07' in m or 'pro, будущее' in m or 'не делаем' in m for _, m in v)


def test_actions_off():
    assert groups(OC.check_action(bytes([16, 8, 1]), src_is_ap=False)) == ['relay']        # Relay Search Request
    assert groups(OC.check_action(bytes([16, 22, 1]), src_is_ap=True)) == ['relay']        # ROC Response
    assert OC.check_action(bytes([16, 2, 1]), src_is_ap=False) == []                       # Information Request
    assert groups(OC.check_action(bytes([18, 0, 1]), src_is_ap=False)) == ['fst']          # FST Setup Request
    assert groups(OC.check_action(bytes([10, 16, 1]), src_is_ap=False)) == ['ps']          # WNM Sleep Mode Request
    assert groups(OC.check_action(bytes([11, 0]), src_is_ap=True)) == ['ps']               # Unprotected WNM TIM
    assert OC.check_action(bytes([10, 23, 1]), src_is_ap=False) == []                      # DMS Request — не PS
    assert groups(OC.check_action(bytes([16, 0, 1]), src_is_ap=False)) == ['ps']           # PSC-REQ от STA
    reject = bytes([16, 1, 1]) + (37).to_bytes(2, 'little')
    assert OC.check_action(reject, src_is_ap=True) == []                                  # точка: отказ — норма
    ok = bytes([16, 1, 1]) + (0).to_bytes(2, 'little')
    assert groups(OC.check_action(ok, src_is_ap=True)) == ['ps']
    wake = reject + E.encode_element(143, bytes(10))
    assert groups(OC.check_action(wake, src_is_ap=True)) == ['ps']
    assert groups(OC.check_action(reject, src_is_ap=False)) == ['ps']


def test_frames_and_pm_bit():
    from types import SimpleNamespace as NS
    assert groups(OC.check_frame_kind('PS-Poll')) == ['ps'] and OC.check_frame_kind('RTS') == []
    assert groups(OC.check_fc_pm(NS(pm=1), 'QoS Data')) == ['ps'] and OC.check_fc_pm(NS(pm=0), 'QoS Data') == []
