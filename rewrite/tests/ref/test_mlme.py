# SPDX-License-Identifier: AGPL-3.0-or-later
"""Эталон DMG MLME: ожидания — из текста 802.11-2020 (табл. 11-22, MIB DEFVAL, 11.1.3.1, 11.1.3.4, 11.1.3.7,
11.1.4.2.2, 11.1.4.3.3, 11.1.4.3.4, 11.1.4.3.10, 11.1.4.4.2, 11.1.4.5, 10.39.3, 11.3.1–11.3.5, 11.3.7,
12.3.3.1, 9.4.1.8, 9.4.2.128, 11.27.2.3)."""
from fractions import Fraction as Fr

import pytest

from . import mlme as M

AP, AP2 = '02:00:00:00:00:01', '02:00:00:00:00:02'
STA, STA2, STA3 = '02:00:00:00:00:11', '02:00:00:00:00:12', '02:00:00:00:00:13'
BC = 'ff:ff:ff:ff:ff:ff'
TU = 1024


# ---------------- постоянные ----------------
def test_constants():
    assert M.aMinChannelTime == 1000 * TU               # табл. 11-22: aMinChannelTime = aMaxBIDuration = 1000 TU (мкс)
    assert M.tu(1000) == M.aMaxBIDuration == 1024000
    assert (M.DOT11_MAX_LOST_BEACONS, M.DOT11_IMPLICIT_HANDOVER_LOST_BEACONS) == (4, 8)
    assert (M.DOT11_MIN_BHI_DURATION, M.DOT11_PS_REQUEST_SUSPENSION_INTERVAL, M.DOT11_BROADCAST_STA_INFO_DURATION,
            M.DOT11_MIN_PP_DURATION, M.DOT11_SP_IDLE_TIMEOUT) == (5000, 8, 32, 200, 200)
    assert M.DOT11_ASSOC_SA_QUERY_MAX_TIMEOUT == 1000
    assert M.RETRY_HOLDOFF == 2 * 10**6                 # «2 s»
    assert M.DISCOVERY_BI_TU == (10, 199)               # 11.1.3.4
    assert M.PERSONAL_START_TU == 4000                  # 4 × aMaxBIDuration
    assert M.PIFS == 8                                  # (10-5): 3 + 5


# ---------------- 11.3.3: классы кадров ----------------
@pytest.mark.parametrize('kind', ['RTS', 'CTS', 'DMG CTS', 'Ack', 'Grant', 'SSW', 'SSW-Feedback', 'SSW-Ack',
                                  'Grant Ack', 'CF-End', 'Probe Request', 'Probe Response', 'Beacon',
                                  'Authentication', 'Deauthentication', 'ATIM', 'Public Action',
                                  'Self-protected Action', 'Announce', 'BRP', 'DMG Beacon'])
def test_class1(kind):
    assert M.frame_class(kind, 'infra') == 1


@pytest.mark.parametrize('kind', ['Association Request', 'Association Response', 'Reassociation Request',
                                  'Reassociation Response', 'Disassociation'])
def test_class2(kind):
    assert M.frame_class(kind, 'infra') == 2 and M.frame_class(kind, 'pbss') == 2


def test_class3_and_bss_dependent():
    for k in ('PS-Poll', 'Poll', 'SPR', 'DMG DTS'):
        assert M.frame_class(k, 'infra') == 3
    # BlockAck/BlockAckReq: класс 1 в IBSS и в PBSS без RSNA, иначе 3
    assert M.frame_class('BlockAck', 'infra') == 3
    assert M.frame_class('BlockAck', 'pbss', rsna=False) == 1
    assert M.frame_class('BlockAckReq', 'pbss', rsna=True) == 3
    assert M.frame_class('BlockAck', 'ibss') == 1
    # Data: внутри PBSS — класс 1, в инфраструктуре — 3
    assert (M.frame_class('Data', 'infra'), M.frame_class('Data', 'pbss'), M.frame_class('Data', 'ibss')) == (3, 1, 1)
    # Action: PBSS без RSNA — класс 1, кроме ADDTS Request/Response и DELTS
    assert M.frame_class('Information Request', 'infra') == 3
    assert M.frame_class('Information Request', 'pbss') == 1
    assert M.frame_class('ADDTS Request', 'pbss') == 3
    assert M.frame_class('ADDBA Request', 'pbss', rsna=True) == 3
    with pytest.raises(ValueError):
        M.frame_class('Foo')


def test_may_transmit():
    assert not M.may_transmit(1, 'Association Request')     # класс 2 — только в State 2/3/4
    assert M.may_transmit(2, 'Association Request')
    assert not M.may_transmit(2, 'Data')                     # класс 3 — только в State 3/4
    assert not M.may_transmit(3, 'Data')                     # 11.3.1: Controlled Port заблокирован
    assert M.may_transmit(3, 'EAPOL')
    assert M.may_transmit(4, 'Data')
    assert M.may_transmit(2, 'Data', bss='pbss')             # Data внутри PBSS — класс 1


def test_rx_filter():
    # 11.3.4.1: класс 2/3 от STA в State 1, индивидуальный A1 → отбросить + Deauthentication
    assert M.rx_filter(1, 'Association Request', AP)[:2] == ('discard', 'Deauthentication')
    # 11.3.5.1 (DMG): класс 3 от STA в State 2 → отбросить + Disassociation
    d, reply, reason = M.rx_filter(2, 'Data', AP)
    assert (d, reply, reason) == ('discard', 'Disassociation', 7)
    assert M.rx_filter(2, 'Data', BC) == ('discard', None, None)          # групповой A1 — без ответа
    assert M.rx_filter(2, 'Association Request', AP) == ('accept', None, None)
    assert M.rx_filter(1, 'Association Request', AP, bss='ibss') == ('ignore', None, None)
    assert M.rx_filter(2, 'Data', AP, bss='pbss') == ('accept', None, None)
    assert M.rx_filter(2, 'Poll', AP, bss='pbss') == ('discard', None, None)


# ---------------- 11.3.1/11.3.2: состояния ----------------
def test_peer_initial_states():
    assert M.Peer(dmg=True).state == 2                   # DMG без 802.11-аутентификации
    assert M.Peer(dmg=True, auth80211=True).state == 1
    assert M.Peer(dmg=False).state == 1


def test_peer_transitions():
    p = M.Peer(dmg=True)
    p.assoc_ok(rsna=True)
    assert p.state == 3
    p.protection()
    assert p.state == 4
    assert p.deauth(originator=False) == 4 and p.state == 4      # 11.3.4.5: DMG без аутентификации
    assert p.deauth(originator=True) == 4 and p.state == 4       # рис. 11-17 (СПОРНО, режим 'figure')
    q = M.Peer(dmg=True, deauth_dmg='text')
    q.assoc_ok(rsna=False)
    q.deauth(originator=True)
    assert q.state == 1                                          # 11.3.4.4 c) буквально
    a = M.Peer(dmg=True, auth80211=True)
    a.auth_ok()
    assert a.state == 2
    a.assoc_ok(rsna=False)
    assert a.state == 4
    a.disassoc()
    assert a.state == 2
    a.assoc_ok(rsna=False)
    a.deauth(originator=False)
    assert a.state == 1
    f = M.Peer(dmg=True, fils=True)
    f.assoc_ok(rsna=True)
    assert f.state == 4                                          # 11.3.5.1: FILS → State 4
    f.disassoc()
    assert f.state == 1


# ---------------- non-AP STA: аутентификация и ассоциация ----------------
def test_dmg_no_open_system():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    with pytest.raises(M.Refused) as e:
        s.authenticate(AP, M.AUTH_OPEN_SYSTEM, 0, ok=True)
    assert e.value.rule == 'dmg_open_system'                     # 12.3.3.1


def test_auth_failure_timeout():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    assert s.authenticate(AP, 3, 0, ok=True, t_done=100 * TU + 1, failure_timeout_tu=100) == 1
    assert s.authenticate(AP, 3, 0, ok=True, t_done=100 * TU, failure_timeout_tu=100) == 2


def test_associate_success_adopts_mib():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    assert s.associate(AP, 0)
    assert s.out[-1][:3] == ('tx', 'Association Request', AP)
    cfg = dict(ps_request_suspension_interval=4, min_bhi_duration=3000, broadcast_sta_info_duration=16,
               assoc_resp_confirm_time=2, min_pp_duration=100, sp_idle_timeout=150, max_lost_beacons=6)
    assert s.on_assoc_resp(AP, 1000, M.SUCCESS, dmg_op_cfg=cfg) == 4
    assert s.mib['dot11MaxLostBeacons'] == 6 and s.mib['dot11MinBHIDuration'] == 3000
    assert s.mib['dot11SPIdleTimeout'] == 150 and s.mib['dot11BroadcastSTAInfoDuration'] == 16
    assert s.confirms[-1] == ('MLME-ASSOCIATE.confirm', AP, M.SUCCESS)
    assert s.resets[-1] == (AP, M.RESET_ALL) and len(M.RESET_ALL) == 28   # 15 + 13 пунктов 11.3.5.4 c)


def test_associate_rsna_then_protection():
    s = M.StaMlme(STA, assoc_timeout_tu=100, rsna=True)
    s.associate(AP, 0)
    assert s.on_assoc_resp(AP, 10, M.SUCCESS) == 3
    assert not M.may_transmit(s.state(AP), 'Data')
    s.set_protection(AP)
    assert s.state(AP) == 4


def test_associate_other_ap_to_state2():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    s.associate(AP, 0)
    s.on_assoc_resp(AP, 10, M.SUCCESS)
    s.associate(AP2, 100)
    s.on_assoc_resp(AP2, 110, M.SUCCESS)
    assert (s.state(AP), s.state(AP2)) == (2, 4)                  # 11.3.5.2 e)


def test_mib_out_of_range():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    s.associate(AP, 0)
    with pytest.raises(ValueError):
        s.on_assoc_resp(AP, 10, M.SUCCESS, dmg_op_cfg={'max_lost_beacons': 0})   # MIB SYNTAX 1..32


def test_assoc_timeout():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    s.associate(AP, 0)
    assert not s.tick(100 * TU)                                  # ровно на границе — ещё «within»
    assert s.on_assoc_resp(AP, 100 * TU, M.SUCCESS) == 4
    s2 = M.StaMlme(STA, assoc_timeout_tu=100)
    s2.associate(AP, 0)
    assert s2.tick(100 * TU + 1)
    assert s2.state(AP) == 2 and s2.confirms[-1][2] == 'TIMEOUT'
    assert s2.on_assoc_resp(AP, 100 * TU + 2, M.SUCCESS) is None       # опоздавший ответ игнорируется


def test_assoc_resp_confirm_time():
    s = M.StaMlme(STA, assoc_timeout_tu=1)
    assert s.adopt_assoc_resp_confirm_time(2) == 98             # 2 × 50 мс = 100000 мкс → ⌈97,66⌉ TU
    s.on_auth_assoc_delay(200)
    assert s.assoc_timeout_tu == 200


def test_assoc_fail_holdoff_2s():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    s.associate(AP, 0)
    assert s.on_assoc_resp(AP, 1000, M.DENIED_NO_MORE_STAS) == 2      # 17: не конфигурация
    with pytest.raises(M.Refused):
        s.associate(AP, 1000 + 2 * 10**6 - 1)
    assert s.associate(AP, 1000 + 2 * 10**6)


def test_assoc_fail_tie_comeback():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    s.associate(AP, 0)
    s.on_assoc_resp(AP, 0, M.REFUSED_TEMPORARILY, tie=(3, 500))
    assert s.can_request(AP, 500 * TU - 1) == (False, 'holdoff')
    assert s.can_request(AP, 500 * TU) == (True, None)


def test_assoc_fail_config():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    s.associate(AP, 0)
    s.on_assoc_resp(AP, 0, 18)                                   # REFUSED_BASIC_RATES_MISMATCH
    assert s.can_request(AP, 10**9) == (False, 'misconfig')
    s.config_corrected(AP)
    assert s.can_request(AP, 10**9) == (True, None)


def test_pcp_association_ready():
    s = M.StaMlme(STA, assoc_timeout_tu=100, bss='pbss')
    with pytest.raises(M.Refused) as e:
        s.associate(AP, 0, pcp_assoc_ready=0)                    # 11.1.3.7
    assert e.value.rule == 'pcp_assoc_ready'
    assert s.associate(AP, 0, pcp_assoc_ready=1)


def test_associate_state1_fails():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    s.peer(AP, auth80211=True)                                   # State 1: аутентификация нужна, не выполнена
    assert not s.associate(AP, 0)
    assert s.confirms[-1] == ('MLME-ASSOCIATE.confirm', AP, 'FAILURE') and not s.out


# ---------------- реассоциация ----------------
def _assoc(s, ap, t=0, ssid='net'):
    s.associate(ap, t, ssid=ssid)
    s.on_assoc_resp(ap, t + 1, M.SUCCESS)


def test_reassoc_same_ap_resets():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    _assoc(s, AP)
    assert s.reassociate(AP, AP, 10, ssid='net')
    assert s.on_assoc_resp(AP, 20, M.SUCCESS) == 4
    assert s.resets[-1] == (AP, M.RESET_ON_REASSOC_SAME) and len(M.RESET_ON_REASSOC_SAME) == 15
    assert 'DMG SP and CBAP allocations' in M.KEPT_ON_REASSOC_SAME


def test_reassoc_other_ap():
    s = M.StaMlme(STA, assoc_timeout_tu=100, rsna=True)
    _assoc(s, AP)
    s.set_protection(AP)
    assert s.reassociate(AP2, AP, 10, ssid='net')
    assert s.on_assoc_resp(AP2, 20, M.SUCCESS) == 3              # RSNA, не FT
    assert s.state(AP) == 2 and s.resets[-1] == (AP2, M.RESET_ALL)


def test_reassoc_ft_state4():
    s = M.StaMlme(STA, assoc_timeout_tu=100, rsna=True)
    _assoc(s, AP)
    s.reassociate(AP2, AP, 10, ft=True, ssid='net')
    assert s.on_assoc_resp(AP2, 20, M.SUCCESS) == 4              # 11.3.5.4 c): FT → State 4


def test_reassoc_requires_same_ess():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    assert not s.reassociate(AP2, AP, 0)                         # не ассоциирована
    _assoc(s, AP, ssid='net')
    assert not s.reassociate(AP2, AP, 10, ssid='other')          # другое ESS
    assert s.confirms[-1] == ('MLME-REASSOCIATE.confirm', AP2, 'FAILURE')


def test_reassoc_fail():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    _assoc(s, AP)
    s.reassociate(AP, AP, 10)
    assert s.on_assoc_resp(AP, 20, 1) == 2                       # 11.3.5.4 f) 1)
    s2 = M.StaMlme(STA, assoc_timeout_tu=100)
    _assoc(s2, AP)
    s2.reassociate(AP, AP, 10, ft=True)
    assert s2.on_assoc_resp(AP, 20, 1) == 4                      # FT — без изменения


# ---------------- дизассоциация / деаутентификация (STA) ----------------
def test_sta_disassociate():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    assert s.disassociate(AP, 8) == 2 and not s.out             # State 2: кадр не передаётся
    _assoc(s, AP)
    assert s.disassociate(AP, 8) == 2
    assert s.out[-1][:3] == ('tx', 'Disassociation', AP)


def test_sta_disassoc_receipt():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    _assoc(s, AP)
    assert s.on_disassoc(AP, 5000, 8) == 2                       # LEAVING_NETWORK_DISASSOC
    assert s.can_request(AP, 5000 + 2 * 10**6 - 1)[0] is False   # 11.3.5.7 e): 2 с
    assert s.can_request(AP, 5000 + 2 * 10**6)[0] is True
    _assoc(s, AP, t=10**7)
    s.on_disassoc(AP, 2 * 10**7, 10)                             # UNACCEPTABLE_POWER_CAPABILITY
    assert s.can_request(AP, 10**9) == (False, 'misconfig')      # d)


def test_sta_disassoc_ignored_in_state2():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    assert s.on_disassoc(AP, 0, 8) == 2 and not s.confirms


def test_sta_deauth():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    _assoc(s, AP)
    assert s.on_deauth(AP, 3) == 4                               # 11.3.4.5: DMG без аутентификации
    assert s.deauthenticate(AP, 3) == 4
    assert s.out[-1][:3] == ('tx', 'Deauthentication', AP)


def test_sta_rx_reply():
    s = M.StaMlme(STA, assoc_timeout_tu=100)
    assert s.rx(AP, 'Data', STA) == 'discard'
    assert s.out[-1][:3] == ('tx', 'Disassociation', AP)


# ---------------- AP / PCP ----------------
def test_ap_does_not_initiate():
    a = M.ApMlme(AP)
    with pytest.raises(M.Refused):
        a.associate(STA)
    with pytest.raises(M.Refused):
        a.authenticate(STA)


def test_ap_open_system_refused():
    a = M.ApMlme(AP)
    assert a.on_auth_req(STA, M.AUTH_OPEN_SYSTEM) == 13
    assert a.state(STA) == 2


def test_ap_assoc_ack_and_aid():
    a = M.ApMlme(AP, rsna=False)
    st, aid, tie = a.on_assoc_req(STA)
    assert (st, aid, tie) == (0, 1, None)
    assert a.state(STA) == 2                                     # до Ack — без изменений (n)
    assert a.on_resp_acked(STA) == 4
    assert a.on_assoc_req(STA2)[1] == 2
    r = M.ApMlme(AP, rsna=True)
    r.on_assoc_req(STA)
    assert r.on_resp_acked(STA) == 3


def test_ap_aid_limit():
    a = M.ApMlme(AP, max_sta=2)
    a.on_assoc_req(STA)
    a.on_assoc_req(STA2)
    assert a.on_assoc_req(STA3)[:2] == (17, None)               # DENIED_NO_MORE_STAS
    b = M.ApMlme(AP)
    aids = [b.on_assoc_req(f'02:00:00:00:{i // 256:02x}:{i % 256:02x}')[1] for i in range(255)]
    assert aids[0] == 1 and aids[253] == 254 and aids[254] is None   # 9.4.1.8: 1…254


def test_ap_refusal_state():
    a = M.ApMlme(AP)
    a.on_assoc_req(STA)
    a.on_resp_acked(STA)
    a.on_assoc_req(STA, result=1)
    assert a.state(STA) == 3                                     # o): без MFP 4 → 3
    b = M.ApMlme(AP, rsna=True)
    b.on_assoc_req(STA)
    b.on_resp_acked(STA)
    b.set_protection(STA)
    b.pmf.add(STA)
    st, aid, tie = b.on_assoc_req(STA)
    assert (st, tie) == (30, (3, 1000)) and b.state(STA) == 4    # e): REFUSED_TEMPORARILY, TIE тип 3
    st, aid, tie = b.on_assoc_req(STA, sa_query_remaining_tu=300)
    assert tie == (3, 300)


def test_ap_disassoc_releases_aid():
    a = M.ApMlme(AP)
    a.on_assoc_req(STA)
    a.on_resp_acked(STA)
    prev = a.disassociate(STA, 8)
    assert a.state(STA) == 2 and a.out[-1][1] == 'Disassociation'
    assert STA in a.aid
    a.on_mgmt_done(STA, prev)
    assert STA not in a.aid
    a.on_assoc_req(STA2)
    a.on_resp_acked(STA2)
    assert a.on_disassoc(STA2) == 2 and STA2 not in a.aid        # 11.3.5.9 e)


def test_ap_deauth_dmg():
    a = M.ApMlme(AP)
    a.on_assoc_req(STA)
    a.on_resp_acked(STA)
    assert a.on_deauth(STA) == 4 and STA in a.aid                # 11.3.4.5


def test_ap_rx_class3_from_unassociated():
    a = M.ApMlme(AP)
    assert a.rx(STA, 'Data', AP) == 'discard'
    assert a.out[-1][:3] == ('tx', 'Disassociation', STA)


def test_pbss_info_distribution():
    d = M.PbssInfoDistribution()
    assert d.deadline() == 32 and not d.overdue(32) and d.overdue(33)
    d.on_sent(10)
    d.on_assoc(12)
    assert d.deadline() == 42
    a = M.ApMlme(AP, bss='pbss')
    a.on_assoc_req(STA)
    a.on_resp_acked(STA, k_bi=5)
    assert a.info.owed_since == 5


# ---------------- 10.39.3: ATI ----------------
def test_ati_start():
    assert M.ati_start_earliest(100, guard=5) == 109             # MBIFS = 3·aSIFSTime = 9
    assert M.ati_start_earliest(100, guard=12) == 112


def test_ati_sta_response():
    f = M.AirFrame('Announce', AP, STA, 0, 50)
    assert M.ati_sta_response(f, STA, AP) == 53                  # через SIFS
    assert M.ati_sta_response(M.AirFrame('Announce', AP, BC, 0, 50), STA, AP) is None
    assert M.ati_sta_response(M.AirFrame('Announce', AP2, STA, 0, 50), STA, AP) is None


def test_ati_ap_heartbeat():
    p = M.AtiAp()
    p.set_heartbeat(STA, True)
    p.set_heartbeat(STA2, False)
    assert p.must_schedule() == [STA]
    p.on_no_response(STA)
    assert p.modulation(STA) == 'control'
    p.on_valid_frame(STA)
    assert p.modulation(STA) == 'any'
    assert M.AtiAp.next_tx_earliest(100, same_sta=False) == 108  # PIFS


def test_check_ati_frame():
    assert M.check_ati_frame(M.AirFrame('Poll', AP, STA, 0, 5, response_offset=3), AP, True)[0][0] == \
        'ati_poll_offset'
    assert M.check_ati_frame(M.AirFrame('Data', AP, STA, 0, 5), AP, True)[0][0] == 'ati_kind'
    assert M.check_ati_frame(M.AirFrame('Action No Ack', AP, STA, 0, 5, no_ack=True), AP, True)[0][0] == \
        'ati_no_ack'
    req = M.AirFrame('Announce', AP, STA, 0, 50)
    assert M.check_ati_frame(M.AirFrame('Ack', STA, AP, 53, 60), AP, False, req) == []
    assert M.check_ati_frame(M.AirFrame('Ack', STA, AP, 54, 60), AP, False, req)[0][0] == 'ati_resp_sifs'
    assert M.check_ati_frame(M.AirFrame('Ack', STA, AP, 53, 60), AP, False, None)[0][0] == 'ati_unsolicited'
    assert 'ati_kind' in [r for r, _ in M.check_ati_frame(M.AirFrame('Poll', STA, AP, 53, 60), AP, False, req)]


# ---------------- 11.1.4.2.2: пассивное сканирование ----------------
def test_passive_scan():
    req = M.ScanRequest('passive', [1, 2], min_ct=1000, ssid='net')
    ps = M.PassiveScan(req)
    b1 = M.BssDesc(AP, 'net', 'infra')
    b2 = M.BssDesc(AP2, 'other', 'infra')
    b3 = M.BssDesc('02:00:00:00:00:03', None, 'infra')
    ps.visit(1, 0, 1000 * TU, rx=[b1, b2, b3, 'Data'])
    ps.visit(2, 1000 * TU, 1000 * TU + 1000 * TU - 1)
    assert [d.bssid for d in ps.confirm()] == [AP]
    assert [r for r, _ in ps.violations()] == ['scan_dwell']
    ps.tx('Probe Response')
    assert 'scan_passive_tx' in [r for r, _ in ps.violations()]


def test_passive_scan_all_and_discovery():
    req = M.ScanRequest('passive', [1, 2], min_ct=10)
    ps = M.PassiveScan(req)
    ps.visit(1, 0, 10 * TU, rx=[M.BssDesc(AP, None, 'pbss', discovery_mode=1)])
    d = ps.confirm()[0]
    assert d.bss_type is None and d.channel == 1                # 11.1.3.7: BSS Type игнорируется
    assert [r for r, _ in ps.violations()] == ['scan_missed']


# ---------------- 11.1.4.3.3: активное сканирование DMG ----------------
def test_active_scan_timer_and_probe():
    req = M.ScanRequest('active', [2], min_ct=5, max_ct=10, probe_delay=100)
    s = M.DmgActiveScan(req, STA, ch=2)
    s.start(0)
    assert not s.may_tx(50)
    s.on_rx_start(40)                                             # a): PHY-RXSTART раньше ProbeDelay
    assert s.may_tx(40)
    assert s.on_dmg_beacon(40 + 10 * TU - 1)
    assert not s.on_dmg_beacon(40 + 10 * TU)                      # d): только до MaxChannelTime
    assert s.probe_plan() == (False, {BC}, False)                 # g)
    s.on_ssw_feedback('tx', AP)
    assert s.probe_plan() == (True, {BC, AP}, False)              # f) 1)
    assert s.on_probe_response(1000, M.BssDesc(AP, 'net', 'infra'))
    assert not s.on_probe_response(40 + 10 * TU, M.BssDesc(AP2, 'net', 'infra'))
    assert [d.bssid for d in s.end()] == [AP] and s.nav == 0      # j)


def test_active_scan_discovery_beacons():
    req = M.ScanRequest('active', [2], min_ct=5, max_ct=10, discovery_mode=1, ssid_list=('a', 'b'))
    s = M.DmgActiveScan(req, STA)
    s.start(0)
    assert s.may_beacon(10 * TU) and not s.may_beacon(10 * TU + 1)   # c): «no longer than MaxChannelTime»
    assert s.probe_plan()[2] is True
    with pytest.raises(ValueError):
        M.ScanRequest('active', [1], min_ct=10, max_ct=5)


def _resp(**k):
    r = dict(role='ap', dmg=True, mac=AP, bssid=AP, ssid='net', bss='infra', trained=lambda ta: True)
    r.update(k)
    return r


def test_probe_response_criteria():
    pq = dict(ta=STA, ra=BC, bssid=BC, ssid='')
    assert M.should_respond_probe(_resp(), pq) == (True, None)
    assert M.should_respond_probe(_resp(role='pcp', bss='pbss'), pq) == (True, None)
    # c): non-AP STA в DMG-инфраструктуре на широковещательный запрос не отвечает
    assert M.should_respond_probe(_resp(role='sta', mac=STA2, active_scan=True), dict(pq, ta=STA3)) == \
        (False, 'c')
    # a) 4): DMG STA вне PBSS, активно сканирующая, без BSS — отвечает
    lone = _resp(role='sta', mac=STA2, bssid=None, ssid=None, bss=None, active_scan=True)
    assert M.should_respond_probe(lone, pq) == (True, None)
    assert M.should_respond_probe(dict(lone, active_scan=False), pq) == (False, 'a')      # пассивно — нет
    assert M.should_respond_probe(dict(lone, pbss_member=True), pq) == (False, 'a')
    assert M.should_respond_probe(_resp(), dict(pq, ra=AP2)) == (False, 'b')
    assert M.should_respond_probe(_resp(), dict(pq, ssid='x')) == (False, 'g')
    assert M.should_respond_probe(_resp(), dict(pq, ssid='x', ssid_list=('net',))) == (True, None)
    assert M.should_respond_probe(_resp(), dict(pq, bssid=AP2)) == (False, 'h')
    assert M.should_respond_probe(_resp(trained=lambda ta: False), pq) == (False, 'k')
    assert M.should_respond_probe(_resp(role='ibss', bss='ibss'), pq) == (False, 'e')
    assert M.probe_response_ra(pq) == STA                         # 11.1.4.3.9


# ---------------- 11.1.3.4: DMG Beacon до BSS ----------------
def test_discovery_beaconing():
    D = M.DiscoveryBeaconing
    assert D.bi_ok(10) and D.bi_ok(199) and not D.bi_ok(9) and not D.bi_ok(200)
    d = D()
    b = dict(discovery_mode=1, next_abft=0, bi_tu=50)
    assert d.check_bti(0, [b, b]) == []
    assert d.check_bti(50 * TU, [b]) == [] and d.tsf_resets == [0]
    assert [r for r, _ in d.check_bti(100 * TU, [dict(b, bi_tu=60), dict(b, next_abft=1, bi_tu=60)])] == \
        ['disc_next_abft']
    assert d.tsf_resets == [0, 100 * TU]                          # TSF = 0 при смене Beacon Interval
    assert [r for r, _ in d.check_bti(0, [b, dict(b, bi_tu=51)])][0] == 'disc_bi_same'
    assert D.next_bti(1000, 50) == 1000 + 50 * TU
    assert D.should_cease('rx_dmg_beacon') and D.should_cease('probe_resp_acked') and not D.should_cease('x')


# ---------------- 11.1.4.3.10, 11.1.4.4.2 ----------------
def test_pcp_factor_bits():
    assert M.pcp_factor({'max_associated_sta': 1}) == 1 << 7
    assert M.pcp_factor({'total_sectors': 1}) == 1 << 15
    assert M.pcp_factor({'pseudo_static': 1}) == 1 << 22
    assert M.pcp_factor({'tddti': 1}) == 1 << 23
    assert M.pcp_factor({'decentralized_clustering': 1}) == 1 << 24
    assert M.pcp_factor({'power_source': 1}) == 1 << 25
    with pytest.raises(ValueError):
        M.pcp_factor({'total_sectors': 128})


def test_candidate_pcp():
    assert M.candidate_pcp(1 << 25, STA, 255 << 7, AP)            # Power Source старше Max Associated
    assert not M.candidate_pcp(5, STA, 6, AP)
    # равные PCP factor — сравнение MAC (12.7.1: первый октет — старший)
    assert M.candidate_pcp(7, '02:00:00:00:00:00', 7, '01:ff:ff:ff:ff:ff')
    assert not M.candidate_pcp(7, '01:ff:ff:ff:ff:ff', 7, '02:00:00:00:00:00')


def test_personal_start_window():
    assert M.personal_start_window(10, True) == (10, 10 + 4000 * TU)
    assert M.personal_start_window(10, False) == (10 + 4000 * TU, None)


# ---------------- 11.1.4.5, 11.1.3.1, 11.27.2.3 ----------------
def test_join():
    j = M.Join(AP, 100, 3, t0=0)
    assert j.on_beacon(10, AP2, 5, 100) is None                   # чужой BSSID
    assert j.on_beacon(10, AP, 5, 100, discovery_mode=1) is None
    assert j.on_beacon(20, AP, 777, 100) == 'SUCCESS' and j.tsf == 777
    k = M.Join(AP, 100, 3)
    assert k.tick(300 * TU) is None and k.tick(300 * TU + 1) == 'FAILURE'


def test_link_monitor():
    m = M.LinkMonitor(AP, 100, 'infra', max_lost=4, t0=0)
    assert m.window() == 400 * TU
    assert not m.lost(400 * TU) and m.lost(400 * TU + 1)
    assert not m.on_rx(1000, 'Announce', AP)                      # инфраструктура: только DMG Beacon
    assert m.on_rx(1000, 'DMG Beacon', AP) and m.deadline() == 1000 + 400 * TU
    assert not m.on_rx(2000, 'DMG Beacon', AP2)
    p = M.LinkMonitor(AP, 100, 'pbss', max_lost=2)
    assert p.on_rx(5, 'Announce', AP) and p.deadline() == 5 + 200 * TU
    with pytest.raises(AssertionError):
        M.LinkMonitor(AP, 100, max_lost=33)


def test_handover_and_bhi():
    assert M.implicit_handover_trigger_bis(2) == 16              # i × dot11ImplicitHandoverLostBeacons (8)
    assert M.bhi_listen_until(1000) == 6000                       # + dot11MinBHIDuration (5000)


# ---------------- судья журнала ----------------
def E(t, kind, ta, ra, **info):
    return M.LogEvent(Fr(t), kind, ta, ra, info)


def rules(v):
    return [x.rule for x in v]


def test_log_clean_association():
    log = [E(0, 'Association Request', STA, AP), E(10, 'Ack', AP, STA),
           E(100, 'Association Response', AP, STA, status=0, aid=1, acked=True),
           E(200, 'Data', STA, AP), E(300, 'Disassociation', STA, AP, reason=8)]
    assert M.check_assoc_log(log, AP) == []


def test_log_class3_before_assoc():
    log = [E(0, 'Data', STA, AP)]
    assert rules(M.check_assoc_log(log, AP)) == ['class_tx', 'missing_reply']
    log.append(E(10, 'Disassociation', AP, STA, reason=7))
    assert rules(M.check_assoc_log(log, AP)) == ['class_tx']


def test_log_aid_and_open_system_and_initiator():
    log = [E(0, 'Authentication', STA, AP, alg=0), E(5, 'Association Request', AP, STA),
           E(10, 'Association Response', AP, STA, status=0, aid=255)]
    assert rules(M.check_assoc_log(log, AP)) == ['open_system', 'ap_initiates', 'aid_range']
    dup = [E(0, 'Association Response', AP, STA, status=0, aid=1),
           E(1, 'Association Response', AP, STA2, status=0, aid=1)]
    assert rules(M.check_assoc_log(dup, AP)) == ['aid_dup']


def test_log_holdoff():
    log = [E(0, 'Association Response', AP, STA, status=17),
           E(10**6, 'Association Request', STA, AP)]
    assert rules(M.check_assoc_log(log, AP)) == ['holdoff']
    log[1] = E(2 * 10**6, 'Association Request', STA, AP)
    assert M.check_assoc_log(log, AP) == []
    tie = [E(0, 'Association Response', AP, STA, status=30, tie=(3, 10)), E(10 * TU, 'Association Request', STA, AP)]
    assert M.check_assoc_log(tie, AP) == []


def test_log_port_blocked():
    log = [E(0, 'Association Response', AP, STA, status=0, aid=1), E(5, 'EAPOL', STA, AP), E(6, 'Data', STA, AP)]
    assert rules(M.check_assoc_log(log, AP, rsna=True)) == ['port_blocked']
