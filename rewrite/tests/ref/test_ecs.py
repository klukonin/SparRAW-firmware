# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/ecs: Max Channel Switch Time (9.4.2.217) и OCV/SA Query после смены канала (11.9.3.2)."""
import pytest

from . import chswitch as CS
from . import ecs as X
from . import elements as E
from .timing import TU


def test_mcst_codec_9_4_2_217():
    el = X.encode_mcst(300)
    assert el[:3] == bytes([255, 4, 52])                         # «The Length field is set to 4»
    assert X.parse_mcst(el[3:]) == X.Mcst(300)
    with pytest.raises(ValueError):
        X.parse_mcst(b'\x01\x02')


def test_mcst_in_frames():
    ecsa = CS.Ecsa(0, 180, 2, 3)
    assert X.check_mcst_in_frame(E.PROBE_RESP, X.encode_mcst(100)[3:], ecsa) == []
    assert [v for _, v in X.check_mcst_in_frame(E.PROBE_RESP, X.encode_mcst(100)[3:], None)] == ['ours']
    assert [v for _, v in X.check_mcst_in_frame(E.PROBE_RESP, X.encode_mcst(100)[3:], CS.Ecsa(0, 180, 2, 0))] == \
        ['model']                                               # Count 0 — «shall not include» (PLAN №104)
    assert [v for _, v in X.check_mcst_in_frame('DMG Beacon', X.encode_mcst(100)[3:], ecsa)] == ['model']


def test_switch_gap():
    assert X.check_switch_gap(0, 100 * TU, 100) == []
    assert X.check_switch_gap(0, 150 * TU, 100)


def test_ocv_after_switch_11_9_3_2():
    assert X.ocv_required(1, 1) and not X.ocv_required(1, 0) and not X.ocv_required(0, 1)
    sq = [(1500, 'Action', (8, 0), False)]
    assert X.check_after_switch(1000, sq, True) == []
    data = [(1500, 'Data', None, False)]
    assert [v for _, v in X.check_after_switch(1000, data, True)] == ['ours']
    assert [v for _, v in X.check_after_switch(1000, [(1500, 'Action', None, True)], True)] == ['capture']
    assert X.check_after_switch(1000, data, False) == []
    assert X.check_sa_query_timing(1000, 900) and X.check_sa_query_timing(1000, 7000) == []
