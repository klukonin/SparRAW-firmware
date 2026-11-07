# SPDX-License-Identifier: AGPL-3.0-or-later
"""Spatial sharing (11.30 [p. 2364–2367]), Directional Channel Quality request/report (9.4.2.20.16 [p. 995],
9.4.2.21.15 [p. 1044]), Radio Measurement Request/Report (9.6.6.2/3 [p. 1459])."""
import pytest

from . import spsh as S
from .timing import AID_BROADCAST, aMaxSwitchInterval, aMinBTIPeriod, aMinSwitchInterval


def req(method=S.METHOD_ANIPI, aid=2, blocks=4, sub=b'', op=180, ch=2, token=1):
    r = S.DcqReq(op, ch, aid, 0, method, 0, 10, blocks, sub)
    return S.encode_meas(S.EID_MEAS_REQ, token, S.req_mode(), S.TYPE_DCQ, S.encode_dcq_req(r))


def meas(b):
    return S.parse_rm(S.encode_rm_request(1, [b]))[3][0]


def test_layouts():
    r = S.DcqReq(180, 2, 5, 0, 1, 0x1122334455667788, 20, 4, b'')
    assert len(S.encode_dcq_req(r)) == 16 and S.parse_dcq_req(S.encode_dcq_req(r)) == r      # рис. 9-216
    p = S.DcqRep(180, 2, 5, 0, 1, 7, 20, 3, [10, 20, 30], b'')
    assert len(S.encode_dcq_rep(p)) == 16 + 3 and S.parse_dcq_rep(S.encode_dcq_rep(p)) == p   # рис. 9-277
    body = S.encode_rm_request(9, [req()], repetitions=65535)
    act, tok, reps, ms = S.parse_rm(body)
    assert (act, tok, reps, len(ms), ms[0].type) == (S.ACT_RM_REQ, 9, 65535, 1, 13)
    assert aMinSwitchInterval == 2 * aMinBTIPeriod == 8 and aMaxSwitchInterval == 128      # табл. 11-22


def test_request_checks():
    assert S.check_dcq_req(meas(req())) == []
    assert any('Reserved' in m for m in S.check_dcq_req(meas(req(method=2))))
    assert any('Number of Time Blocks = 0' in m for m in S.check_dcq_req(meas(req(blocks=0))))
    assert any('канал 7' in m for m in S.check_dcq_req(meas(req(ch=7))))
    assert any('табл. 9-121' in m for m in S.check_dcq_req(meas(req(sub=S.dcq_reporting(3, 0)))))
    assert S.check_dcq_req(meas(req(sub=S.dcq_reporting(S.COND_GE, 40)))) == []
    assert any('табл. 9-120' in m for m in S.check_dcq_req(meas(req(sub=bytes([5, 0])))))
    assert any('Token = 0' in m for m in S.check_dcq_req(meas(req(token=0))))


def test_report_mirrors_request():
    q = meas(req(blocks=3))
    rep = S.answer(q, [1, 2, 3])
    assert S.check_rm_pair(S.encode_rm_request(4, [req(blocks=3)]), S.encode_rm_report(4, [rep])) == []
    with pytest.raises(ValueError):
        S.answer(q, [1, 2])
    bad = S.encode_meas(S.EID_MEAS_REP, 1, S.rep_mode(), S.TYPE_DCQ,
                        S.encode_dcq_rep(S.DcqRep(180, 2, 9, 0, 0, 0, 10, 3, [1, 2, 3], b'')))
    v = S.check_rm_pair(S.encode_rm_request(4, [req(blocks=3)]), S.encode_rm_report(5, [bad]))
    assert any('Dialog Token' in m for m in v) and any('aid 9' in m for m in v)
    late = S.encode_meas(S.EID_MEAS_REP, 1, S.rep_mode(late=1), S.TYPE_DCQ, b'')
    assert any('Late' in m for m in S.check_rm_pair(S.encode_rm_request(4, [req()]), S.encode_rm_report(4, [late])))
    refused = S.answer(q, [], refused=True)
    assert S.check_rm_pair(S.encode_rm_request(4, [req(blocks=3)]), S.encode_rm_report(4, [refused])) == []


def test_ap_requests_and_antenna():
    cand, exist = S.SpPair(1, 2), S.SpPair(3, 4)
    out = S.assessment_requests(cand, exist)
    got = [(me, S.parse_dcq_req(meas(m).body)) for me, m in out]
    assert [(me, r.aid, r.method) for me, r in got] == [(1, 2, 0), (2, 1, 0), (3, 4, 0), (4, 3, 0)]   # ANIPI
    assert S.parse_dcq_req(meas(S.monitor_request(cand, 2)).body)[2:5] == (1, 0, S.METHOD_RSNI)
    assert S.measurement_antenna(2, {2}) == 'peer'
    assert S.measurement_antenna(AID_BROADCAST, {2}) == 'quasi-omni' == S.measurement_antenna(7, {2})


def test_overlap_requires_reports():
    cand, exist = S.SpPair(1, 2), S.SpPair(3, 4)
    assert S.check_overlap_allowed(cand, exist, {1, 2}, False) == []
    assert S.check_overlap_allowed(cand, exist, {1}, False)
    assert S.check_overlap_allowed(cand, exist, {1, 2}, True)          # кандидат уже был — нужны и 3, 4
    assert S.check_overlap_allowed(cand, exist, {1, 2, 3, 4}, True) == []


def test_switch_backoff_11_30_4():
    seq = iter([7, 0, 15])
    b = S.SwitchBackoff(lambda n: next(seq))
    assert b.switch(0) == 7 and b.interval == 16
    assert not b.may_switch(6) and b.may_switch(7)
    with pytest.raises(ValueError):
        b.switch(5)
    b.switch(7)
    assert b.interval == 32
    b.switch(10)
    for _ in range(5):
        b.interval = min(2 * b.interval, aMaxSwitchInterval)
    assert b.interval == 128
    b.tick(10 + 127)
    assert b.interval == 128
    b.tick(10 + 128)
    assert b.interval == aMinSwitchInterval
    with pytest.raises(ValueError):
        S.SwitchBackoff(lambda n: n).switch(0)                          # N вне [0, SwitchInterval − 1]
