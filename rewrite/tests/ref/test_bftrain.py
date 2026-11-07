# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/bftrain: MLME-BF-TRAINING (6.3.91, 11.36) — SME над моделью SLS/BRP."""
import pytest

from . import bftrain as B

P = '02:00:00:00:00:02'


def test_request_plan_sls_then_brp_iff_requested():
    s = B.BfTrainingSme('02:00:00:00:00:01')
    assert s.request(P, False) == [('SLS', 'DTI')]
    s2 = B.BfTrainingSme('02:00:00:00:00:01')
    assert s2.request(P, True, peer_is_ap=True, in_abft=True) == [('SLS', 'A-BFT'), ('BRP', 'DTI')]
    with pytest.raises(ValueError):
        s.request('01:00:5e:00:00:01', False)                 # PeerSTAAddress — индивидуальный


def test_confirm_and_indication():
    s = B.BfTrainingSme('a')
    s.request(P, True)
    assert s.sls_done(P) is None                              # BRP ещё впереди
    assert s.brp_done(P) == B.Primitive('MLME-BF-TRAINING.confirm', P, B.SUCCESS)
    r = B.BfTrainingSme('b')
    r.peer_started('a')
    assert r.sls_done('a') == B.Primitive('MLME-BF-TRAINING.indication', 'a', B.SUCCESS)
    t = B.BfTrainingSme('a')
    t.request(P, False)
    assert t.timeout(P).result == B.BF_TIMEOUT
    u = B.BfTrainingSme('a')
    u.request(P, True)
    with pytest.raises(ValueError):
        u.brp_done(P)                                         # «shall start with the SLS»


def test_timeout_dot11maxbftime():
    assert not B.timed_out(0, 4 * 102400, 102400) and B.timed_out(0, 4 * 102400 + 1, 102400)


def test_air_brp_needs_sls_first_11_36():
    ok = [(0, 'SSW', 'a', 'b'), (10, 'SSW-Feedback', 'b', 'a'), (20, 'BRP', 'a', 'b')]
    assert B.check_air(ok) == []
    bad = [(0, 'BRP', 'a', 'b'), (10, 'BRP', 'b', 'a')]
    assert [(i, v) for i, _, v in B.check_air(bad)] == [(0, 'model')]
    # после повторной ассоциации снова нужен SLS
    re = ok + [(30, 'BRP', 'a', 'b')]
    assert [i for i, _, _ in B.check_air(re, assoc_times=[25])] == [3]
