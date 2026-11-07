# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/tpc: TPC Request/Report (9.6.2.4/9.6.2.5), TPC Report (9.4.2.16), 11.7.7."""
import pytest

from . import elements as E
from . import tpc as T


def test_report_element_roundtrip_twos_complement_9_4_2_16():
    el = T.encode_tpc_report(-5, 0)
    assert el[:2] == bytes([35, 2])
    assert T.parse_tpc_report(el[2:]) == T.TpcReport(-5, 0)
    with pytest.raises(ValueError):
        T.parse_tpc_report(b'\x00')
    with pytest.raises(ValueError):
        T.encode_tpc_report(200)


def test_frames_and_token_9_6_2():
    req = T.parse_tpc_frame(T.encode_tpc_request_frame(7))
    assert req == T.TpcFrame('request', 7, None) and T.check_request(req) == []
    assert T.check_request(T.parse_tpc_frame(T.encode_tpc_request_frame(0)))      # «nonzero value»
    rep = T.respond(req, 10, 3)
    assert T.check_report(req, rep) == []
    body = T.encode_tpc_report_frame(rep.token, 10, 3)
    assert T.parse_tpc_frame(body).report == T.TpcReport(10, 3)
    assert T.check_report(req, T.TpcFrame('report', 8, rep.report))
    with pytest.raises(ValueError):
        T.parse_tpc_frame(bytes([0, 2, 1]) + E.encode_element(34, b'\x00'))       # TPC Request с Length ≠ 0


def test_must_respond_11_7_1():
    assert T.must_respond(1, 0) is True
    assert T.must_respond(0, 1) is None
    assert T.must_respond(0, 0) is False


def test_report_in_ap_frames_11_7_7():
    assert T.check_frame_element('DMG Beacon', None, 1, 0)                         # Spectrum Management — обязателен
    assert T.check_frame_element('DMG Beacon', None, 0, 1)                         # Radio Measurement — табл. 9-45
    assert T.check_frame_element('Announce', None, 0, 1) == []                     # Announce — только по 11.7.7
    assert T.check_frame_element('Announce', None, 1, 0)
    assert T.check_frame_element(E.PROBE_RESP, None, 0, 0) == []
    ok = T.encode_tpc_report(10, 0)[2:]
    assert T.check_frame_element('DMG Beacon', ok, 1, 0) == []
    assert T.check_frame_element('DMG Beacon', T.encode_tpc_report(10, 4)[2:], 1, 0)   # Link Margin ≠ 0
