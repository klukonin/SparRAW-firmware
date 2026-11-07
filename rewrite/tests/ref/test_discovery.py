# SPDX-License-Identifier: AGPL-3.0-or-later
"""Information Request/Response и обнаружение пиров DMG (11.28 [p. 2359–2360], 9.6.19.4/5 [p. 1571–1572], 9.4.2.9
[p. 962])."""
import pytest

from . import discovery as D
from . import elements as E
from .timing import BCAST

AP, S1, S2, X = '02:00:00:00:00:0a', '02:00:00:00:00:01', '02:00:00:00:00:02', '02:00:00:00:00:99'


def caps_el(mac, aid=0, handover=0):
    sc = {n: 0 for n, _ in E.DMG_STA_CAP}
    ap = {n: 0 for n, _ in E.DMG_AP_PCP_CAP}
    ap['pcp_handover'] = handover
    return E.encode_dmg_capabilities(E.DmgCapabilities(mac, aid, sc, ap, 0, {n: 0 for n, _ in E.EXT_SC_MCS}, 0, 0))


EXT_SCHED = E.encode_element(E.EID_EXTENDED_SCHEDULE, bytes(15))
DMG_OP = E.encode_element(E.EID_DMG_OPERATION, bytes(10))


def ap_station(**kw):
    return D.InfoStation(AP, caps_el(AP), is_ap=True, bssid=AP, ssid=b'net',
                         members={S1: caps_el(S1, 1), S2: caps_el(S2, 2)},
                         supported={(E.EID_EXTENDED_SCHEDULE, None): EXT_SCHED, (E.EID_DMG_OPERATION, None): DMG_OP},
                         **kw)


def test_request_format_and_rules():
    body = D.encode_request(S2, [E.EID_EXTENDED_SCHEDULE, E.EID_DMG_OPERATION], dmg_caps=[caps_el(S1)])
    f, _ = D.parse(body)
    assert f.subject == S2 and f.request == [E.EID_EXTENDED_SCHEDULE, E.EID_DMG_OPERATION] and f.dmg_caps
    assert D.check_request(body, S1, S2, dst_is_ap=False) == []
    unsorted = bytes([16, 2]) + bytes(6) + D.encode_request_el([151, 144])
    assert any('по возрастанию' in m for m in D.check_request(unsorted, S1, AP, True))
    dup = bytes([16, 2]) + bytes(6) + D.encode_request_el([144, 144])
    assert any('at most once' in m for m in D.check_request(dup, S1, AP, True))
    # DMG Capabilities ответ несёт и так — в Request его не просят (9.4.2.9)
    assert any('несёт его и так' in m for m in D.check_request(D.encode_request(S2, [148]), S1, AP, True))
    assert any('Element ID Extension' in m for m in D.check_request(D.encode_request(S2, [255]), S1, AP, True))
    no_req = bytes([16, 2]) + bytes(6) + caps_el(S1)
    assert any('нет элемента Request' in m for m in D.check_request(no_req, S1, AP, True))


def test_broadcast_subject_only_to_ap_and_no_foreign_caps():
    assert any('AP and PCP' in m for m in D.check_request(D.encode_request(BCAST), S1, S2, dst_is_ap=False))
    assert D.check_request(D.encode_request(BCAST), S1, AP, dst_is_ap=True) == []
    foreign = D.encode_request(S2, dmg_caps=[caps_el(S2)])
    assert any('другой STA' in m for m in D.check_request(foreign, S1, AP, True))
    assert D.check_request(foreign, AP, S1, False, src_is_ap=True) == []      # точка может
    with pytest.raises(ValueError):
        D.InfoStation(S1, caps_el(S1)).request(BCAST, dst_is_ap=False)


def test_presence_probe():
    f, _ = D.parse(D.InfoStation(S1, caps_el(S1)).presence_probe(S2))
    assert D.is_presence_probe(f)
    assert not D.is_presence_probe(D.parse(D.encode_request(S2, [144]))[0])


def test_ap_answers_all_members_with_requested_elements():
    ap = ap_station()
    req = D.encode_request(BCAST, [E.EID_EXTENDED_SCHEDULE, 46])          # 46 — не поддержан
    ra, body = ap.on_request(req, S1, bssid_field=AP, da=AP)
    f, _ = D.parse(body)
    assert ra == S1 and f.subject == BCAST
    assert {c.sta_address for c in f.dmg_caps} == {AP, S1, S2}
    assert [(e.eid, e.ext) for e in f.provided] == [(E.EID_EXTENDED_SCHEDULE, None)]      # неподдержанного нет
    assert D.check_response(body, AP, S1, req=D.parse(req)[0], src_is_ap=True, members={S1, S2}) == []
    v, info = D.check_answer_content(req, body, supported={(E.EID_EXTENDED_SCHEDULE, None)})
    assert v == [] and info['answered'] == [(E.EID_EXTENDED_SCHEDULE, None)]


def test_empty_answer_cases_11_28_1():
    ap = ap_station()
    _, body = ap.on_request(D.encode_request(X, [E.EID_EXTENDED_SCHEDULE]), S1, bssid_field=AP)
    f, _ = D.parse(body)
    assert f.provided == [] and [c.sta_address for c in f.dmg_caps] == [AP]          # PLAN.md №60
    sta = D.InfoStation(S2, caps_el(S2, 2), supported={(E.EID_DMG_OPERATION, None): DMG_OP})
    _, body = sta.on_request(D.encode_request(S1, [E.EID_DMG_OPERATION]), S1)
    assert D.parse(body)[0].provided == []
    _, body = sta.on_request(D.encode_request(S2, [E.EID_DMG_OPERATION]), S1)
    assert [e.eid for e in D.parse(body)[0].provided] == [E.EID_DMG_OPERATION]
    # ответ, который должен быть пустым, с элементами — нарушение
    bad = D.encode_response(S1, [caps_el(S2)], [DMG_OP])
    v = D.check_response(bad, S2, S1, req=D.parse(D.encode_request(S1, [151]))[0])
    assert any('без requested/provided' in m for m in v)


def test_ap_responds_only_on_criteria_11_28_2():
    ap = ap_station()
    req = D.encode_request(S2, [144])
    assert ap.on_request(req, S1, bssid_field='02:00:00:00:00:77') is None       # b) чужой BSSID
    assert ap.on_request(req, S1, bssid_field=AP, da=X) is None                   # c) DA не точки
    other = D.encode_request(S2, [144], provided=[E.encode_ssid(b'other')])
    assert ap.on_request(other, S1, bssid_field=AP) is None                       # a) чужой SSID (PLAN.md №61)
    wild = D.encode_request(S2, [144], provided=[E.encode_ssid(b'')])
    assert ap.on_request(wild, S1, bssid_field=BCAST) is not None
    assert ap.on_request(req, S1, bssid_field=BCAST) is not None


def test_rcpi_rsni_not_available():
    ap = ap_station(radio_measurement=True)
    _, body = ap.on_request(D.encode_request(S1, [D.EID_RCPI, D.EID_RSNI]), S1)
    got = {e.eid: e.info for e in D.parse(body)[0].provided}
    assert got == {D.EID_RCPI: bytes([255]), D.EID_RSNI: bytes([255])}        # табл. 9-176, 9.4.2.40
    _, body = ap_station().on_request(D.encode_request(S1, [D.EID_RCPI]), S1)
    assert D.parse(body)[0].provided == []                                     # dot11RadioMeasurementActivated false


def test_response_checks():
    req = D.parse(D.encode_request(S1, [144]))[0]
    assert any('One or more' in m for m in D.check_response(D.encode_response(S1, []), AP, S1, req=req,
                                                            src_is_ap=True))
    assert any('Action No Ack' in m for m in D.check_response(D.encode_response(BCAST, [caps_el(AP)]), AP, BCAST,
                                                              src_is_ap=True))
    assert D.check_response(D.encode_response(BCAST, [caps_el(AP)]), AP, BCAST, src_is_ap=True,
                            frame_kind='Action No Ack') == []
    assert any('Subject Address ответа' in m for m in D.check_response(D.encode_response(S2, [caps_el(AP)]), AP, S1,
                                                                       req=req, src_is_ap=True))
    order = bytes([16, 3]) + bytes(6) + EXT_SCHED + caps_el(AP)
    assert any('порядок' in m for m in D.check_response(order, AP, S1, src_is_ap=True))
    v, _ = D.check_answer_content(D.encode_request(S1, [144, 151]), D.encode_response(S1, [caps_el(AP)], [EXT_SCHED]),
                                  supported={(144, None), (151, None)})
    assert any('DMG Operation' in m for m in v)
