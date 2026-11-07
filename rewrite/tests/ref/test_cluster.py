# SPDX-License-Identifier: AGPL-3.0-or-later
"""Кластеризация AP/PCP (ref/cluster): ожидания — из 10.40, 9.4.2.146/154/155, 9.3.4.2 (числа формул и полей)."""
from fractions import Fraction as Fr

import pytest

from . import cluster as CL
from . import elements as E
from . import fields as F
from . import schedule as SC
from . import tspec as TS
from .timing import AID_BROADCAST, TU, aMinChannelTime

A, B, C, D = ('02:00:00:00:00:0a', '02:00:00:00:00:0b', '02:00:00:00:00:0c', '02:00:00:00:00:0d')
BI = 100                      # TU → 102 400 мкс
BI_US = 102400


def cc(cid, role, maxmem=4, sp=75):
    return F.ClusteringControl(beacon_sp_duration=sp, cluster_id=cid, member_role=role, cluster_max_mem=maxmem, spsh=0)


# ----------------------------------------------------------------------------------------------- время (10.40.1)
def test_cluster_time_offset_formula():
    # ClusterTimeOffset_{n−1} = 1024 × (dot11BeaconPeriod/ClusterMaxMem) × (n−1)
    assert CL.cluster_time_offset(0, BI, 4) == 0
    assert CL.cluster_time_offset(1, BI, 4) == 25600
    assert CL.cluster_time_offset(3, BI, 4) == 76800
    with pytest.raises(CL.ClusterError):
        CL.cluster_time_offset(4, BI, 4)
    assert CL.beacon_sp(2, 1000, BI, 4, 75) == (26600, 27200)          # 75 × 8 = 600 мкс
    assert CL.beacon_sp_field(CL.DOT11_BEACON_SP_DURATION) == 75 and CL.beacon_sp_field(601) == 76


def test_maxmem_integer_and_reserved():
    assert CL.maxmem_ok(BI, 4) and not CL.maxmem_ok(BI, 3)              # 102400/3 — не целое
    assert CL.check_cluster_params(BI, 4, 75, ecapc=0) == []
    assert any('не целое' in m for m in CL.check_cluster_params(BI, 3, 75, ecapc=0))
    assert any('1…7' in m for m in CL.check_cluster_params(BI, 8, 75, ecapc=0))
    assert CL.check_cluster_params(BI, 8, 75, ecapc=1) == []            # при ECAPC = 1 до 31
    # предел Beacon SP Duration = BI/ClusterMaxMem: BI 1 TU / 4 = 256 мкс → поле 32 можно, 33 — нет
    assert CL.check_cluster_params(1, 4, 32, ecapc=0) == []
    assert any('maximum size' in m for m in CL.check_cluster_params(1, 4, 33, ecapc=0))


def test_beacon_sp_of_and_overlap():
    assert CL.beacon_sp_of(25700, 25800, 0, BI, 4, 75) == 2
    assert CL.beacon_sp_of(BI_US + 100, BI_US + 200, 0, BI, 4, 75) == 1   # по модулю BI
    assert CL.beacon_sp_of(26000, 26300, 0, BI, 4, 75) is None            # выходит за 600 мкс
    assert CL.overlaps_beacon_sps(51000, 51300, 0, BI, 4, 75) == {3}
    assert CL.overlaps_beacon_sps(51000, 51300, 0, BI, 4, 75, skip={3}) == set()


# ----------------------------------------------------------------------------------- децентрализованный (10.40.2.1)
def test_decentralized_join_empty_sp_and_schedule():
    sap = CL.DecentralizedAp(A, BI).start_sap(0)
    assert sap.cc() == cc(A, CL.ROLE_SAP)
    # B слышит маяки S-AP (SP_1) и C (SP_2) за aMinChannelTime → пустые 3, 4
    heard = [(10, 60), (25610, 25660)]
    with pytest.raises(CL.ClusterError):
        CL.empty_beacon_sps(heard, 0, BI, 4, 75, aMinChannelTime - 1)
    empty = CL.empty_beacon_sps(heard, 0, BI, 4, 75, aMinChannelTime)
    assert empty == {3, 4}
    b = CL.DecentralizedAp(B, 50)
    assert not b.join(A, sap.cc(), BI, 0, set())                        # нет пустых — «shall not become a member»
    assert b.join(A, sap.cc(), BI, 0, empty) and b.n == 3 and b.bi_tu == BI
    assert b.cc() == cc(A, CL.ROLE_MEMBER)
    assert b.own_tbtt() == 51200
    ents = b.schedule()
    # своё TSF: TBTT = 0; Beacon SP 1, 2, 4: (0 − 51200), (25600 − 51200), (76800 − 51200) по модулю BI
    assert [(e.alloc.start, e.alloc.block_dur) for e in ents] == [(25600, 600), (51200, 600), (76800, 600)]
    assert [e.alloc.start for e in b.schedule(2)] == [2 * BI_US + 25600, 2 * BI_US + 51200, 2 * BI_US + 76800]
    assert all(e.alloc.src_aid == e.alloc.dst_aid == AID_BROADCAST for e in ents)
    assert CL.check_beacon_sps_scheduled(ents, 0, 3, BI, 4, 75) == []
    miss = CL.check_beacon_sps_scheduled(ents[1:], 0, 3, BI, 4, 75)
    assert len(miss) == 1 and miss[0][1] == 'ours'
    short = [SC.sp(255, 255, e.alloc.start, 300, alloc_id=e.alloc.alloc_id) for e in ents]
    assert all(v == 'model' for _, v in CL.check_beacon_sps_scheduled(short, 0, 3, BI, 4, 75))
    assert not b.may_tx(51200 + 25600 + 100, 51200 + 25600 + 200)       # в Beacon SP_4
    assert b.may_tx(51200 + 100, 51200 + 300)                           # свой Beacon SP_3


def test_decentralized_sap_handover_lowest_mac():
    b = CL.DecentralizedAp(B, BI)
    b.join(A, cc(A, CL.ROLE_SAP), BI, 0, {2})
    acts = [b.end_bi() for _ in range(CL.CC_MONITOR_BIS)]
    assert acts[-1] == 'monitor' and acts[:-1] == [None] * (CL.CC_MONITOR_BIS - 1)
    b.on_beacon(C, cc(A, CL.ROLE_MEMBER), 0)                            # другой член того же кластера, MAC выше
    acts = [b.end_bi() for _ in range(CL.CC_MONITOR_BIS)]
    assert acts[-1] == 'become_sap' and b.role == CL.ROLE_SAP and b.cluster_id == B


def test_decentralized_monitor_again_then_reform():
    d = CL.DecentralizedAp(D, BI)
    d.join(A, cc(A, CL.ROLE_SAP), BI, 0, {4})
    for _ in range(CL.CC_MONITOR_BIS):
        d.end_bi()
    out = []
    for _ in range(4):
        d.on_beacon(B, cc(A, CL.ROLE_MEMBER), 0)                       # у B MAC меньше — S-AP станет B
        out.append([d.end_bi() for _ in range(CL.CC_MONITOR_BIS)][-1])
    assert out == ['monitor_again', 'monitor_again', 'may_reform', 'may_reform']   # периодов > 3 (с первым)


def test_decentralized_rejoin_and_lower_sap_and_ecapc():
    b = CL.DecentralizedAp(B, BI)
    b.join(A, cc(A, CL.ROLE_SAP), BI, 0, {2})
    for _ in range(CL.CC_MONITOR_BIS):
        b.end_bi()
    assert b.on_beacon(C, cc(C, CL.ROLE_SAP), 0) == 'rejoin'
    s = CL.DecentralizedAp(C, BI).start_sap()
    assert s.on_beacon(A, cc(A, CL.ROLE_SAP), 0) == 'join_lower_sap'   # 10.40.3.2: S-AP с большим MAC — членом
    assert s.on_beacon(D, cc(D, CL.ROLE_SAP), 0) is None
    assert s.on_beacon(D, cc(D, CL.ROLE_SAP), 1) == 'quit_for_ecapc'
    lone = CL.DecentralizedAp(D, BI)
    lone.join(A, cc(A, CL.ROLE_SAP), BI, 0, {2})
    for _ in range(2 * CL.CC_MONITOR_BIS - 1):
        lone.end_bi()
    assert lone.end_bi() == 'become_sap'                                 # маяков кластеризующих STA нет — shall


# ----------------------------------------------------------------------------------------- элементы (9.4.2.154/155)
def test_ecapc_policy_codec():
    p = CL.EcapcPolicy(1, 0, 1, C, 0b1100)
    el = CL.encode_ecapc_policy(p)
    assert el[0] == 182 and el[1] == 11 and len(el) == 13              # рис. 9-589: «0, 13 or 17»
    assert CL.parse_ecapc_policy(el[2:]) == (p, 0)
    q = CL.EcapcPolicy(0, 1, 0, C, 0b0110, 10, 25, 4)
    el = CL.encode_ecapc_policy(q)
    assert len(el) == 17 and CL.parse_ecapc_policy(el[2:])[0] == q
    with pytest.raises(CL.ClusterError):
        CL.parse_ecapc_policy(el[2:13])                                 # TXSS CBAP Enforced = 1 без полей TXSS


def test_ecapc_policy_checks():
    assert CL.check_ecapc_policy(CL.EcapcPolicy(0, 0, 0, C, 0b1110), maxmem=4) == []
    assert any('[0]' in m for m in CL.check_ecapc_policy(CL.EcapcPolicy(0, 0, 0, C, 0b1), maxmem=4))
    assert any('[4]' in m for m in CL.check_ecapc_policy(CL.EcapcPolicy(0, 0, 0, C, 0b10000), maxmem=4))
    assert CL.check_ecapc_policy(CL.EcapcPolicy(0, 0, 0, C, 2), sender_role=CL.ROLE_MEMBER)
    assert CL.check_ecapc_policy(CL.EcapcPolicy(0, 0, 0, C, 0), sender_role=CL.ROLE_MEMBER) == []
    assert CL.check_ecapc_policy(CL.EcapcPolicy(0, 0, 0, C, 0), rsv=1)
    # шаг конфигурации: BI/N или N/BI целое
    assert CL.check_ecapc_policy(CL.EcapcPolicy(0, 1, 0, C, 0, 0, 1, 4), bi_tu=BI) == []
    assert CL.check_ecapc_policy(CL.EcapcPolicy(0, 1, 0, C, 0, 0, 1, 200), bi_tu=BI) == []
    assert CL.check_ecapc_policy(CL.EcapcPolicy(0, 1, 0, C, 0, 0, 1, 3), bi_tu=BI)
    assert CL.check_ecapc_policy(CL.EcapcPolicy(0, 1, 0, C, 0, 0, 1, 0))


def test_cto_and_bitmap_selection():
    assert CL.parse_cto(CL.encode_cto(3)[2:]) == 3
    assert CL.check_cto(0) and CL.check_cto(4, 4) and CL.check_cto(3, 4) == []
    # S-AP: занятые 1, 2; получатель — 2 (индивидуальный кадр): 1 — 0; 2, 3 — 1; бит 0 и ≥ 4 — резерв (0)
    assert CL.available_bitmap(4, {1, 2}, recipient=2) == 0b1100
    assert CL.in_use_offsets(0b1100, 4) == {1}
    assert CL.select_cto({3, 4}, 0b1000, 4) == 3                         # пересечение: n = 4
    assert CL.select_cto({3}, 0b1000, 4) == 2                            # пусто — индекс пустого Beacon SP
    assert CL.select_cto(set(), 0b1110, 4) is None


# --------------------------------------------------------------------------------------------- Cluster Report
def test_cluster_report_codec():
    es = SC.encode([SC.sp(1, 2, 1000, 500)])[2:]
    r = CL.ClusterReport(0, 1, 1, 0, D, 0x123456789, cc(D, CL.ROLE_SAP, maxmem=8), CL.EcapcPolicy(0, 0, 0, C, 2), es,
                         [TS.Constraint(100, 200, 0x8001, C)])
    el = CL.encode_cluster_report(r)
    assert el[0] == 166
    got, ctrl = CL.parse_cluster_report(el[2:])
    assert got == r._replace(ref_ts=0x23456789)                          # младшие 4 октета TSF
    assert ctrl == dict(request=0, report=1, schedule_present=1, tsconst_present=1, ecapc_enforced=1, ecapc_present=1,
                        channel=0)
    assert CL.check_cluster_report(got, ctrl) == []
    req = CL.ClusterReport(1, 0)
    got, ctrl = CL.parse_cluster_report(CL.encode_cluster_report(req)[2:])
    assert got == req and CL.check_cluster_report(got, ctrl) == []
    bad_ctrl = dict(ctrl, schedule_present=1)
    assert any('reserved' in m for m in CL.check_cluster_report(got, bad_ctrl))
    assert CL.check_cluster_report(CL.ClusterReport(1, 0, channel=3))
    assert CL.check_cluster_report(CL.ClusterReport(1, 0, channel=1))                 # 1,08 ГГц у DMG
    with pytest.raises(CL.ClusterError):
        CL.encode_cluster_report(CL.ClusterReport(0, 0, cc=cc(D, 1)))
    big = CL.ClusterReport(0, 1, 0, 0, D, 0, cc(D, 1), None, None, [TS.Constraint(0, 0, 1, C)] * 16)
    with pytest.raises(CL.ClusterError):
        CL.encode_cluster_report(big)


def test_report_conditions_10_40_4():
    own = A
    assert not CL.report_condition(own, cc(own, 1), own, 0, 0, BI)                  # маяк своей точки
    assert not CL.report_condition(D, None, own, 0, 0, BI)                          # без Clustering Control
    assert CL.report_condition(D, cc(D, 1), own, 0, None, BI)                       # другой кластер
    # тот же Cluster ID: TBTT ближе BI/(2·ClusterMaxMem) = 12 800 мкс и ECAPC своей точки = 1
    assert CL.report_condition(D, cc(own, 2), own, 1, 12799, BI)
    assert not CL.report_condition(D, cc(own, 2), own, 1, 12800, BI)
    assert not CL.report_condition(D, cc(own, 2), own, 0, 100, BI)
    rs = CL.make_reports(D, cc(D, 1), 0, [b'\x01', b'\x02'], 0x1_0000_0005)
    assert len(rs) == 2 and rs[1].schedule == b'\x02' and rs[0].ref_ts == 5


def test_sta_report_checks():
    heard = {D: dict(cc=cc(D, 1), ecapc=0, schedules=[], gap=None)}
    r = CL.make_reports(D, cc(D, 1), 0, [], 0)[0]
    assert CL.check_sta_report(r, 'Information Response', A, A, heard) == []
    assert [v for _, v in CL.check_sta_report(r, 'Probe Request', B, A, heard)] == ['ours', 'ours']
    assert CL.check_sta_report(r._replace(cc=cc(D, 1, sp=10)), 'Announce', A, A, heard)
    own_rep = CL.make_reports(A, cc(A, 1), 0, [], 0)[0]
    assert any('shall not' in m for m, _ in CL.check_sta_report(own_rep, 'Announce', A, A, heard))
    nocc = {D: dict(cc=None, ecapc=0, schedules=[], gap=None)}
    assert any('shall not' in m for m, _ in CL.check_sta_report(r, 'Announce', A, A, nocc))


# ---------------------------------------------------------------------------------------- 10.40.3.4, 11.1.3.3.1
def test_bhi_and_txss_cbap_windows():
    assert CL.bhi_deadline(1000, 75) == 1600
    p = CL.EcapcPolicy(0, 1, 0, C, 0, 10, 25, 4)
    w = CL.txss_cbap_windows(0, BI, p)
    assert w == [(80, 280), (25680, 25880), (51280, 51480), (76880, 77080)]
    w = CL.txss_cbap_windows(0, BI, p, exclude=[(100, 150), (25600, 25700)])
    assert w[:3] == [(80, 100), (150, 280), (25700, 25880)]
    assert CL.txss_cbap_windows(0, BI, p._replace(txss_cbap=0)) == []
    assert CL.beacon_random_delay_max(Fr(30)) == 120
    assert CL.beacon_random_delay_max(Fr(2000)) == 5000


# ------------------------------------------------------------------------------------ централизованный (10.40.2.2)
def cfg(**kw):
    d = dict(ccsr=D, policy=CL.EcapcPolicy(1, 0, 0, D, 0), bi_tu=BI, maxmem=8, sp_field=75, start=0, excluded=[2],
             ch2_allowed=True)
    d.update(kw)
    return CL.CcsrConfig(**d)


def test_centralized_configuration_and_verification():
    assert CL.check_ccsr_config(cfg()) == []
    assert CL.check_ccsr_config(cfg(ccsr=None))
    assert CL.check_ccsr_config(cfg(excluded=[]))
    assert CL.check_ccsr_config(cfg(excluded=[4]))                       # канал 2 разрешён, но не исключён
    assert CL.check_ccsr_config(cfg(excluded=[4], ch2_allowed=False)) == []
    assert CL.check_ccsr_config(cfg(maxmem=3))
    with pytest.raises(CL.ClusterError):
        CL.CentralizedSap(A, cfg(ccsr=None))
    assert CL.verification_ok([(B, 1, 1)], same_ccss={B})
    assert not CL.verification_ok([(C, 1, 2)], same_ccss={B})
    assert CL.verification_ok([(C, 0, 1)], same_ccss=set())             # ECAPC = 0 — не ECAPC
    assert CL.must_react_to_ecapc(True, {2}, {1, 2, 3}, False, False) == 'cease'
    assert CL.must_react_to_ecapc(True, {2}, {1, 2, 3}, False, True) == 'join'
    assert CL.must_react_to_ecapc(True, {1, 2, 3}, {1, 2, 3}, False, True) is None     # слепой
    assert CL.ECAPC_BLIND_US == 300 * aMinChannelTime


def test_centralized_sap_member_flow():
    sap = CL.CentralizedSap(A, cfg())
    assert sap.ecapc == 1 and sap.cc() == cc(A, CL.ROLE_SAP, maxmem=8)
    assert sap.policy().bitmap == 0b11111110                             # n = 2…8 свободны
    m = CL.CentralizedMember(B)
    el = m.join(A, sap.cc(), sap.policy(B), {3, 5})
    assert el == CL.encode_cto(2) and m.cc() == cc(A, CL.ROLE_MEMBER, maxmem=8) and m.policy().bitmap == 0
    assert CL.CentralizedMember(C).join(A, sap.cc(), sap.policy(), {3}, second_sta_associated=False) is None
    sap.on_cto(B, 2)
    assert sap.policy().bitmap == 0b11111010 and sap.policy(B).bitmap == 0b11111110
    ents = sap.schedule(0)
    assert [(e.alloc.start, e.alloc.block_dur) for e in ents] == [(2 * 12800, 600)]   # только занятый n = 3
    with pytest.raises(CL.ClusterError):
        sap.on_cto(C, 8)
    sent = sap.reconfigure(cfg(sp_field=80), [B, C])
    assert [s for s, _ in sent] == [B, C] and sap.cc().beacon_sp_duration == 80
    m.on_sap_beacon(cc(A, CL.ROLE_SAP, maxmem=8, sp=80))
    assert m.cc().beacon_sp_duration == 80
    acts = [m.end_bi() for _ in range(CL.CC_MONITOR_BIS + 1)]
    assert acts[-1] == 'role_0' and m.role == CL.ROLE_NONE and m.ecapc == 0 and m.policy() is None


# ----------------------------------------------------------------------------------------- проверки записей
def test_check_own_beacon():
    caps0 = dict(decentralized_clustering=0, centralized_clustering=0)
    caps_d = dict(decentralized_clustering=1, centralized_clustering=0)
    assert CL.check_own_beacon(A, None, 0, 1, caps=caps0) == []
    assert [v for _, v in CL.check_own_beacon(A, None, 1, 1)] == ['ours']
    assert [v for _, v in CL.check_own_beacon(A, cc(A, 0), 0, 1, caps=caps0)] == ['model']
    assert CL.check_own_beacon(A, cc(A, 1), 0, 0, caps=caps_d) == []
    assert CL.check_own_beacon(A, cc(B, 1), 0, 0, caps=caps_d)          # S-AP с чужим Cluster ID
    assert CL.check_own_beacon(A, cc(A, 2), 0, 0, caps=caps_d)          # член со своим Cluster ID
    assert CL.check_own_beacon(A, cc(B, 2), 0, 1, caps=caps_d)          # член с CBAP Only
    assert CL.check_own_beacon(A, cc(A, 1), 1, 0, caps=caps_d)          # ECAPC без Centralized
    assert CL.check_own_beacon(A, cc(A, 0), 1, 0)                       # ECAPC при роли 0


def test_check_beacon_series():
    s = [(1, cc(A, 1), 0), (2, cc(A, 1), 0), (8, cc(A, 1), 0)]
    assert [k for k, _, _ in CL.check_beacon_series(s)] == [8]          # 6 BI > aMinBTIPeriod
    m = [(1, cc(B, 2), 0), (2, None, 0)]
    assert [k for k, _, _ in CL.check_beacon_series(m)] == [2]
    e = [(1, cc(A, 1), 1), (2, cc(A, 1), 0)]
    assert any('lifetime' in x for _, x, _ in CL.check_beacon_series(e))


def test_check_member_vs_sap():
    ts = 5 * BI_US + 300                       # TSF S-AP в начале маяка: TBTT S-AP = t − 300
    s = dict(src=A, t=Fr(10300), te=Fr(10340), timestamp=ts, bi_tu=BI, cc=cc(A, 1), ecapc=0)
    good = dict(src=B, t=Fr(10000 + 25600 + 50), te=Fr(10000 + 25600 + 90), timestamp=0, bi_tu=BI, cc=cc(A, 2), ecapc=0)
    assert CL.check_member_vs_sap(good, s) == []
    assert CL.check_member_vs_sap(dict(good, t=Fr(10050), te=Fr(10090)), s)          # в Beacon SP_1 S-AP
    assert CL.check_member_vs_sap(dict(good, t=Fr(10000 + 30000), te=Fr(10000 + 30040)), s)
    assert CL.check_member_vs_sap(dict(good, bi_tu=50), s)
    assert CL.check_member_vs_sap(dict(good, cc=cc(A, 2, maxmem=2)), s)
    assert CL.check_member_vs_sap(dict(good, cc=cc(C, 2)), s)
    assert CL.tbtt_from_beacon(Fr(10300), ts, BI) == 10000
    assert TU * BI == BI_US


def test_element_ids_table_9_92():
    assert E.element_key('Cluster Report') == (CL.EID_CLUSTER_REPORT, None)
    assert E.element_key('ECAPC Policy') == (CL.EID_ECAPC_POLICY, None)
    assert E.element_key('Cluster Time Offset') == (CL.EID_CLUSTER_TIME_OFFSET, None)


def test_cluster_request_and_bss_change_11_29_4():
    assert not CL.cluster_request_expired(10, 17, False)
    assert CL.cluster_request_expired(10, 10 + CL.DOT11_CLUSTER_ENABLE_TIME, False)
    assert not CL.cluster_request_expired(10, 30, True)
    assert CL.check_broadcast_announce(0) == [] and CL.check_broadcast_announce(1)
    ch = dict(move=1, size=0, tbtt_offset=1000, bi_duration=0)
    assert CL.change_moves_beacon_sps(ch) and not CL.change_moves_beacon_sps(dict(ch, move=0))
    # член с индексом 2 (Beacon SP_3), ClusterMaxMem 4, BI 100 TU: + 51 200 мкс; TSF члена = TSF S-AP + 7
    assert CL.member_change(ch, 7, 2, 4, BI) == dict(move=1, size=0, tbtt_offset=1000 + 7 + 51200, bi_duration=0)
    seq = [(1, cc(A, 1), None), (2, None, ch), (3, None, None)]
    assert [k for k, _ in CL.check_change_beacons(seq)] == [2]
    assert CL.check_change_beacons([(1, cc(A, 1), ch)]) == []


def test_beacon_sp_entries_pass_schedule_check():
    m = CL.DecentralizedAp(B, BI)
    m.join(A, cc(A, CL.ROLE_SAP), BI, 0, {3})
    ents = m.schedule()
    assert [e.alloc.alloc_id for e in ents] == [1, 2, 3]
    assert SC.check(ents, 0, BI) == []
    with pytest.raises(CL.ClusterError):
        CL.beacon_sp_entries(0, 1, 1000, 20, 75)                          # 19 Beacon SP > 15 Allocation ID
