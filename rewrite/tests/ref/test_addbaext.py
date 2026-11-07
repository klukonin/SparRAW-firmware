# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/addbaext: ADDBA Extension (9.4.2.139), фрагментация DMG по соглашению Block Ack (10.2.6)."""
import pytest

from . import addbaext as X
from . import blockack as BA
from . import elements as E


def req_body(extra=b''):
    return BA.encode_addba_req(BA.AddbaReq(1, BA.BAParams(0, 1, 0, 64), 0, 0)) + extra


def resp_body(extra=b''):
    return BA.encode_addba_resp(BA.AddbaResp(1, 0, BA.BAParams(0, 1, 0, 64), 0)) + extra


def test_codec_fig_9_579_9_580():
    el = X.encode(1)
    assert el == bytes([159, 1, 1])
    assert X.parse(el[2:]) == X.AddbaExt(1, 0)
    with pytest.raises(ValueError):
        X.parse(b'')


def test_reserved_bits_and_length():
    assert X.check(b'\x01') == []
    assert X.check(b'\x03')                                      # B1 ≠ 0 (HE Fragmentation — не 802.11-2020)
    assert X.check(b'\x01\x00')                                  # Length 2


def test_frame_order_tables_9_360_9_361():
    v, ext = X.check_frame(req_body(X.encode(1)), response=False)
    assert v == [] and ext.no_frag == 1
    tclas = E.encode_element(14, bytes([255, 0, 2]) + bytes(14))
    v, _ = X.check_frame(resp_body(X.encode(0) + tclas), response=True)
    assert any('порядку' in m for m in v)                         # TCLAS (9) после ADDBA Extension (10)
    v, _ = X.check_frame(resp_body(X.encode(0) + X.encode(1)), response=True)
    assert any('2 раза' in m for m in v)


def test_fragmentation_rule_10_2_6():
    assert X.Agreement(None, X.AddbaExt(0, 0)).check_fragment(False, 0) == []
    assert X.Agreement(None, None).may_fragment()                                         # PLAN №101: нет элемента
    assert X.Agreement(None, X.AddbaExt(1, 0)).check_fragment(False, 0)                   # «shall not be fragmented»
    assert X.Agreement(X.AddbaExt(1, 0), None).check_fragment(False, 0)                   # обещание originator
    assert X.Agreement(None, None).check_fragment(True, 0)                                # в A-MPDU
    assert X.Agreement(None, None).check_fragment(False, 3)                               # не Normal Ack
