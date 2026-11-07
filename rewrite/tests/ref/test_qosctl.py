# SPDX-License-Identifier: AGPL-3.0-or-later
"""Генератор QoS Control DMG (9.2.4.5 [p. 771–777], табл. 9-11…9-13, рис. 9-10)."""
import pytest

from . import amsdu as AM
from . import qosctl as Q


def f(b):
    return AM.parse_qos(int.from_bytes(b, 'little'))


def test_tid_by_access_policy_table_9_12():
    assert f(Q.generate(5)).tid == 5
    assert f(Q.generate(9, access=Q.SPCA)).tid == 9
    with pytest.raises(ValueError):
        Q.generate(9)                                 # EDCA — UP 0–7
    with pytest.raises(ValueError):
        Q.generate(3, access=Q.SEMM)                  # SEMM — TSID 8–15


def test_ack_policy_table_9_13():
    assert f(Q.generate(0, group=True)).ackpol == Q.ACK_NOACK          # групповые без BA — No Ack
    assert f(Q.generate(0)).ackpol == Q.ACK_NORMAL
    assert f(Q.generate(0, ba=True, in_ampdu=True)).ackpol == Q.ACK_NORMAL       # Implicit BAR
    assert f(Q.generate(0, ba=True, block_ack=True)).ackpol == Q.ACK_BLOCK
    assert f(Q.generate(0, no_ack=True)).ackpol == Q.ACK_NOACK
    with pytest.raises(ValueError):
        Q.generate(0, ba=True, no_ack=True)           # «not used for QoS Data frames with a TID for which a BA exists»
    with pytest.raises(ValueError):
        Q.generate(0, block_ack=True)
    with pytest.raises(ValueError):
        Q.generate(0, in_ampdu=True)


def test_eosp_only_last_frame_of_individual_allocation():
    """9.2.4.5.3: EOSP = 1 — последний кадр SP или CBAP с индивидуальным Destination AID; иначе 0."""
    assert f(Q.generate(0, last_in_alloc=True, alloc_dst_individual=True)).eosp == 1
    assert f(Q.generate(0, last_in_alloc=True, alloc_dst_individual=False)).eosp == 0
    assert f(Q.generate(0)).eosp == 0


def test_fields_amsdu_buffered_rd():
    q = f(Q.generate(2, amsdu=AM.SHORT, buffered=('AC_VO', 'AC_BK')))
    assert q.amsdu == 1 and q.amsdu_type == 1 and q.buffered_ac == 0b1001 and q.rdg == 0 and q.acc == 0
    assert q.rsv14 == 0
    with pytest.raises(ValueError):
        Q.generate(0, null=True, amsdu=AM.BASIC)


def test_generated_passes_check():
    for kw in (dict(), dict(group=True), dict(ba=True, in_ampdu=True), dict(no_ack=True), dict(amsdu=AM.BASIC)):
        b = Q.generate(1, **kw)
        assert Q.check(b, group=kw.get('group', False), ba=kw.get('ba', False), ts_tids=set(),
                       dst_broadcast_alloc=True) == []


def test_check_violations():
    raw = lambda **kw: AM.encode_qos(**kw)                        # noqa: E731
    assert any('EOSP' in m for m in Q.check(raw(tid=0, eosp=1), dst_broadcast_alloc=True))
    assert Q.check(raw(tid=0, eosp=1), dst_broadcast_alloc=False) == []
    assert any('TSID' in m for m in Q.check(raw(tid=9), ts_tids=set()))
    assert Q.check(raw(tid=9), ts_tids={9}) == []
    assert any('No Ack' in m for m in Q.check(raw(tid=0, ackpol=0), group=True, ba=False))
    assert any('Block Ack без' in m for m in Q.check(raw(tid=0, ackpol=3), ba=False))
    assert any('PSMP' in m for m in Q.check(raw(tid=0, ackpol=2)))
    assert any('RDG' in m for m in Q.check(raw(tid=0, rdg=1)))
    assert Q.check(raw(tid=0, rdg=1), rd=True) == []
    assert any('B14' in m for m in Q.check(1 << 14))
    assert any('A-MSDU Type' in m for m in Q.check(1 << 8))
