# SPDX-License-Identifier: AGPL-3.0-or-later
"""Основа динамического распределения (uc/dynalloc.c) против эталона 802.11-2020: Duration и Response Offset Poll
по ур. (10-18) (10.39.7.2, ref/duration.pp_schedule; PLAN.md №45–46), Duration SPR (10.39.7.2,
ref/duration.duration_spr_response), Duration Grant GP (10.39.7.3, ref/dynalloc.gp; PLAN.md №48), кадры Poll и SPR
(9.3.1.10, 9.3.1.11, ref/fields.parse_frame)."""
import os
import sys
from fractions import Fraction as Fr

import pytest

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
from ref import duration as D                  # noqa: E402
from ref import dynalloc as DA                 # noqa: E402
from ref import fields as F                    # noqa: E402
from ref.timing import ALLOC_SP                # noqa: E402

RO = 0x807f80                       # u32 *ro — свободная область стека в эмуляторе (как test_uc_grant_frame)
DST = 0x807e00                      # struct dtx_ctrl_frame
SRC = 0x807f00                      # struct dtx_grant_req
RA, TA = bytes.fromhex('04d4c4556677'), bytes.fromhex('04d4c4112233')


@pytest.mark.parametrize('n', range(1, 9))
def test_pp_poll_duration_and_offset(uc, n):
    """Poll i из n: (Duration, Response Offset) — как ref/duration.pp_schedule при одной антенне и SPR одной длины."""
    want = D.pp_schedule([D.tx('poll')] * n, [D.tx('spr')] * n)
    got = []
    for i in range(1, n + 1):
        d = uc.call('dyn_pp_poll', i, n, RO)
        got.append((d, uc.r32(RO)))
    assert got == want


@pytest.mark.parametrize('dur, ro', [(19, 3), (54, 19), (38, 22), (88, 34), (57, 41), (10, 3), (0, 0)])
def test_spr_duration(uc, dur, ro):
    """Duration SPR = Duration Poll − Response Offset − TXTIME(SPR), вверх, не меньше 0 (10.39.7.2, 9.2.5.1)."""
    assert uc.call('dyn_spr_duration', dur, ro) == D.duration_spr_response(dur, ro)


@pytest.mark.parametrize('n, ack', [(1, 0), (1, 1), (2, 0), (2, 0b01), (2, 0b10), (3, 0b101), (4, 0b1111)])
def test_gp_grant_durations(uc, n, ack):
    """Duration каждого Grant GP — до начала выделения (одна точка для всех Grant; последний — 0 или SIFS +
    TXTIME(Grant Ack)) — как эталонный GP ref/dynalloc.gp (10.39.7.3)."""
    stas = ['02:00:00:00:00:%02x' % (i + 1) for i in range(n)]
    acks = {s for i, s in enumerate(stas) if ack >> i & 1}
    evs, _ = DA.gp(Fr(1000), 'ap', stas, F.Dai(0, ALLOC_SP, 1, 0, 3000), grant_ack=acks)
    want = [e[5] for e in evs if e[4] == 'Grant']
    got = [uc.call('dyn_gp_grant_duration', k, n, ack) for k in range(n)]
    assert got == want


def _frame(uc, body_len):
    """struct dtx_ctrl_frame → кадр в эфире: FC, Duration, RA, TA (вставляет MAC), тело с +0x10."""
    b = uc.rbytes(DST, 0x18)
    return b[0:4] + RA + TA + b[0x10:0x10 + body_len]


@pytest.mark.parametrize('dur, ro', [(54, 19), (19, 3), (0x7fff, 0x1234)])
def test_poll_frame(uc, dur, ro):
    """Poll (рис. 9-49): Control Frame Extension 2, Duration, Response Offset — ref/fields.parse_frame."""
    for i in range(0x18):
        uc.w8(DST + i, 0xee)
    uc.call('dyn_poll_frame_init', DST, dur, ro)
    p = F.parse_frame(_frame(uc, 2), with_fcs=False)
    assert isinstance(p, F.Poll) and (p.duration, p.response_offset) == (dur, ro), p


def test_spr_frame(uc):
    """SPR (рис. 9-50): Control Frame Extension 3, Dynamic Allocation Info (9.5.2: SP, Source/Destination AID,
    Allocation Duration), BF Control 0 — ref/fields.parse_frame и check_dai."""
    for i in range(0x18):
        uc.w8(DST + i, 0xee)
    for i in range(0x0c):
        uc.w8(SRC + i, 0)
    uc.w16(SRC, 37)
    uc.w32(SRC + 4, 0)                                  # SP
    uc.w8(SRC + 8, 1)
    uc.w8(SRC + 9, 0)
    uc.w16(SRC + 0xa, 2500)
    uc.call('dyn_spr_frame_init', DST, SRC)
    p = F.parse_frame(_frame(uc, 7), with_fcs=False)
    assert isinstance(p, F.Spr), p
    assert p.duration == 37
    assert (p.dai.alloc_type, p.dai.src_aid, p.dai.dst_aid, p.dai.alloc_duration) == (ALLOC_SP, 1, 0, 2500)
    assert F.check_dai(p.dai, frame='spr') == []
    assert not p.bfc.bt
