# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/staavail: STA Availability (9.4.2.132), 10.39.7.1 (Poll и PP Available)."""
import pytest

from . import staavail as S


def test_codec_fig_9_566_9_567():
    el = S.encode([(3, 1, 0), (5, 0, 1)])
    assert el[:2] == bytes([145, 4])
    assert S.parse(el[2:]) == [S.StaInfo(3, 1, 0, 0), S.StaInfo(5, 0, 1, 0)]
    with pytest.raises(ValueError):
        S.encode([])                                         # «one or more»
    with pytest.raises(ValueError):
        S.parse(b'\x03')                                     # не n × 2


def test_checks():
    assert S.check([S.StaInfo(3, 1, 1, 0)], sender_is_ap=False, own_aid=3) == []
    assert [x for _, x in S.check([S.StaInfo(3, 1, 1, 1)], False, 3)] == ['ours']          # Reserved
    assert [x for _, x in S.check([S.StaInfo(0, 1, 1, 0)], True)] == ['ours']              # AID AP
    assert [x for _, x in S.check([S.StaInfo(4, 1, 1, 0), S.StaInfo(4, 1, 1, 0)], True)] == ['ours']
    assert [x for _, x in S.check([S.StaInfo(4, 1, 1, 0)], False, own_aid=3)] == ['model']   # чужой AID (PLAN №100)
    assert [x for _, x in S.check([S.StaInfo(3, 0, 1, 0)], False, own_aid=3)] == ['model']   # CBAP = 0 без PS
    assert S.check([S.StaInfo(3, 0, 1, 0)], False, own_aid=3, ps=True) == []
    assert [x for _, x in S.check([S.StaInfo(9, 1, 1, 0)], True, assoc_aids={3})] == ['model']


def test_poll_after_pp_unavailable_10_39_7_1():
    st = S.PpAvailability()
    assert st.poll_allowed('b')                              # «may transmit Poll … not received … equal to 0»
    st.on_element('b', 3, [S.StaInfo(3, 1, 0, 0)])
    assert not st.poll_allowed('b')
    st.on_element('b', 3, [S.StaInfo(3, 1, 1, 0)])
    assert st.poll_allowed('b')
    st.on_element('b', 3, [S.StaInfo(7, 1, 0, 0)])           # чужой AID в сообщении STA — не о ней
    assert st.poll_allowed('b')
