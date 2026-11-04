# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сопровождение луча (ref/beamtrack): 802.11-2020 10.42.7 [p. 1964–1966], табл. 10-31, 9.4.2.127.4 [p. 1240],
dot11BeamTrackingTimeLimit (C.3: 0..65535 мкс, DEFVAL 10000). Ожидания — из текста стандарта."""
from fractions import Fraction as Fr

import pytest

from . import beamtrack as B
from . import timing as T

I, R = 'ini', 'resp'


@pytest.mark.parametrize('a,b,want', [
    (0, 0, None), (100, 0, None), (0, 100, None),            # строки «Transmit beam tracking is not supported»
    (300, 200, 300), (200, 300, 300), (250, 250, 250),       # «A ≥ B → A», «A < B → B»
    (65535, 400, 400), (400, 65535, 400),                    # «65 535 | >0 and < 65 535 → B», «… 65 535 → A»
    (65535, 65535, 10000),                                   # «Default dot11BeamTrackingTimeLimit value»
])
def test_table_10_31(a, b, want):
    assert B.bt_time_limit(a, b) == want


def test_mib_and_missing_field():
    assert T.DOT11_BEAM_TRACKING_TIME_LIMIT == 10000
    # NOTE 1: поле не передано — инициатор не может определить неудачу
    assert B.bt_time_limit(None, 10000) is None
    ini = B.Initiator(None)
    ini.sent_tx_request(0)
    assert not ini.failed(10 ** 6)


def test_request_kinds_and_vector():
    # 10.42.7: TRN-R — BEAM_TRACKING_REQUEST = REQUESTED, PPDU_TYPE TRN-R, TRN_LEN = число запрошенных
    p = B.Ppdu(0, 10, I, R, 4, B.REQUESTED, B.TRN_R, 4)
    assert B.request_kind(p) == 'rx' and B.check_request_vector(p) == []
    assert B.check_request_vector(p._replace(trn_len=0))
    # TRN-T — «append an AGC field and TRN-T subfields to the PPDU»
    p = B.Ppdu(0, 10, I, R, 4, B.REQUESTED, B.TRN_T, 4, trn=True)
    assert B.request_kind(p) == 'tx' and B.check_request_vector(p) == []
    assert B.check_request_vector(p._replace(trn=False))
    # приёмное сопровождение ответчиком: NOT_REQUESTED, TRN_LEN > 0, TRN-R, AGC + TRN-R добавлены
    p = B.Ppdu(0, 10, I, R, 4, B.NOT_REQUESTED, B.TRN_R, 2, trn=True)
    assert B.request_kind(p) == 'resp_rx' and B.check_request_vector(p) == []
    assert B.request_kind(B.Ppdu(0, 10, I, R, 4)) is None


def test_initiator_may_request_tx_conditions():
    ini = B.Initiator(500, 500)                    # предел 500 мкс
    assert ini.may_request_tx(0)
    ini.sent_tx_request(100)
    # «greater than the beam tracking time limit plus BRPIFS»
    assert not ini.may_request_tx(100 + 500 + T.BRPIFS)
    assert ini.may_request_tx(100 + 500 + T.BRPIFS + Fr(1, 10))
    # «A BRP frame with the channel measurement feedback … has been received»
    ini.feedback(300)
    assert ini.may_request_tx(301)
    # «shall not initiate transmit beam tracking if … Time Limit field to zero»
    assert not B.Initiator(0).may_request_tx(0)


def test_initiator_failure_and_ignore():
    ini = B.Initiator(500, 500)
    ini.sent_tx_request(0)
    assert not ini.failed(499) and ini.failed(500)          # «less than the beam tracking time limit» → неудача в 500
    assert ini.feedback(499) == 'ok'
    ini.sent_tx_request(1000)
    assert ini.feedback(1500) == 'ignore'                   # «greater than or equal to … limit … should ignore it»


def test_responder_feedback_type_and_deadline():
    r = B.Responder(400, 400)
    # «never received a BRP frame … with TX-TRN-REQ equal to 1» → FBCK-TYPE все 0 и BS-FBCK
    assert r.feedback_type() == (0, True)
    r.rx_brp(B.Ppdu(0, 10, I, R, 0, brp=True, tx_trn_req=1, fbck_type=0x123))
    assert r.feedback_type() == (0x123, False)
    r.rx_brp(B.Ppdu(20, 30, I, R, 0, brp=True, tx_trn_req=0, fbck_type=0x7))      # без TX-TRN-REQ — не меняет
    assert r.feedback_type() == (0x123, False)
    # «shall not transmit a BRP frame with feedback … if the time period … is longer than the beam tracking time limit»
    assert r.may_send_feedback(0, 400) and not r.may_send_feedback(0, 400 + Fr(1, 10))


def test_judge_trn_r_obligation_same_allocation_mcs_gt0():
    f = {I: 1000, R: 1000}
    req = B.Ppdu(0, 10, I, R, 6, B.REQUESTED, B.TRN_R, 4, alloc=1)
    ok = B.Ppdu(20, 40, R, I, 6, ptype=B.TRN_R, trn_len=4, trn=True, alloc=1)
    assert B.check_bt_log([req, ok], f) == []
    # MCS 0 (control) не обязан нести TRN-R — обязанность переходит на следующий PPDU с MCS > 0
    ctl = B.Ppdu(20, 30, R, I, 0, alloc=1)
    bad = B.Ppdu(40, 60, R, I, 6, alloc=1)
    v = B.check_bt_log([req, ctl, bad], f)
    assert [x.rule for x in v] == ['bt_trn_r'] and v[0].idx == 2
    # другой TRN_LEN — нарушение; другое распределение — обязанности нет («in the same allocation»)
    assert B.check_bt_log([req, ok._replace(trn_len=2)], f)[0].rule == 'bt_trn_r'
    assert B.check_bt_log([req, bad._replace(alloc=2)], f) == []


def test_judge_tx_tracking_rules():
    f = {I: 1000, R: 500}
    req = B.Ppdu(0, 10, I, R, 6, B.REQUESTED, B.TRN_T, 2, trn=True)
    fb = B.Ppdu(100, 120, R, I, 1, brp=True, fbck=True, fbck_type=0, bs_fbck=3)
    assert B.check_bt_log([req, fb], f) == []
    # предел ответчика: A = поле инициатора 1000, B = свой MIB (по умолчанию — своё поле 500) → 1000
    late = fb._replace(t=1000, te=1011)
    assert [x.rule for x in B.check_bt_log([req, late], f)] == ['bt_fb_late']
    # FBCK-TYPE ≠ типу последнего BRP с TX-TRN-REQ = 1
    brp = B.Ppdu(-100, -90, I, R, 0, brp=True, tx_trn_req=1, fbck_type=0x40)
    assert [x.rule for x in B.check_bt_log([brp, req, fb], f)] == ['bt_fb_type']
    assert B.check_bt_log([brp, req, fb._replace(fbck_type=0x40)], f) == []
    # пир объявил 0 → запрос TRN-T запрещён
    assert [x.rule for x in B.check_bt_log([req], {I: 1000, R: 0})] == ['bt_tx_unsup']
    # повтор без обратной связи раньше предела + BRPIFS
    req2 = req._replace(t=200, te=210)
    assert [x.rule for x in B.check_bt_log([req, req2], f)] == ['bt_tx_early']
    req3 = req._replace(t=10 + 1000 + T.BRPIFS + 1, te=10 + 1000 + T.BRPIFS + 11)
    assert B.check_bt_log([req, req3], f) == []
