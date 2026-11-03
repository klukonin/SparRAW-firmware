# SPDX-License-Identifier: AGPL-3.0-or-later
"""Кадр Grant (uc/misc.c frame_hdr_init, fsched_tx_ctrl_frame) и Grant Ack (rx_send_grant_ack) против 802.11-2020:
поле Dynamic Allocation Info 9.5.2 (рис. 9-847) — TID B0..B3, AllocationType B4..B6, Source AID B7..B14,
Destination AID B15..B22, Allocation Duration B23..B38 (младший бит — B23), B39 Reserved; BF Control 9.5.5
(рис. 9-851/9-852: B0 Beamforming Training; при 0 прочие подполя зарезервированы). Тело кадра с +0x10 (struct
dtx_ctrl_frame): Dynamic Allocation Info — 5 октетов little-endian с +0x10, BF Control — 2 октета с +0x15."""
import pytest

DST = 0x807e00                      # struct dtx_ctrl_frame (0x18 Б) — свободная область стека в эмуляторе
SRC = 0x807f00                      # struct dtx_grant_req (0x0c Б)
FSCHED_CUR_IDX = 0x801be8 + 0x28    # fsched_peers.cur_idx
PEER_AID = 0x857964                 # fwsh_peer_aid.aid[cid] (include/fwsh.h)
RX_BUF = 0x804010                   # принятый кадр


def dyn_alloc(v):
    return dict(tid=v & 0xf, type=(v >> 4) & 7, src=(v >> 7) & 0xff, dst=(v >> 15) & 0xff, dur=(v >> 23) & 0xffff,
                rsv=(v >> 39) & 1)


@pytest.mark.parametrize('dur, typ, src, dst', [
    (1000, 1, 3, 1), (0x1ff, 0, 1, 2), (0x200, 1, 0xff, 0), (0x7fff, 0, 0x12, 0x34), (1, 1, 0, 0), (32768, 1, 5, 0),
])
def test_grant_dynamic_allocation_info(uc, dur, typ, src, dst):
    for i in range(0x18):
        uc.w8(DST + i, 0xee)
    for i in range(0x0c):
        uc.w8(SRC + i, 0)
    uc.w16(SRC, 0x1234)                                 # Duration кадра
    uc.w32(SRC + 4, typ)
    uc.w8(SRC + 8, src)
    uc.w8(SRC + 9, dst)
    uc.w16(SRC + 0xa, dur)                              # Allocation Duration
    uc.call('frame_hdr_init', DST, 0, SRC)
    assert uc.r16(DST) == 0x464                         # Frame Control: Control Frame Extension, Grant
    assert uc.r16(DST + 2) == 0x1234
    f = dyn_alloc(int.from_bytes(uc.rbytes(DST + 0x10, 5), 'little'))
    assert f == dict(tid=0, type=1 if typ == 1 else 0, src=src, dst=dst, dur=dur, rsv=0)
    assert uc.rbytes(DST + 0x15, 2) == bytes(2)         # BF Control: без обучения — все подполя 0


@pytest.mark.parametrize('cid, aid', [(0, 1), (3, 4), (7, 0x2a)])
def test_fsched_grant_fields(uc, cid, aid):
    """Grant фиксированного расписания — передача TXOP станции (10.39.7.3): Source AID — AID станции (ответчика),
    Destination AID — AID AP (держателя TXOP, 0 по 9.4.1.8), AllocationType CBAP (табл. 9-257: B4 = 1),
    Allocation Duration 32768 (9.5.2 b), Beamforming Training = 0 (обучение в начале выделения не планируется — BF
    Control целиком 0, 9.5.5). Duration — длительность слота."""
    uc.w8(FSCHED_CUR_IDX, cid)
    for i in range(8):
        uc.w8(PEER_AID + i, 0xc0 + i)
    uc.w8(PEER_AID + cid, aid)
    uc.call('fsched_tx_ctrl_frame', stub={'gp0_timer_arm_usec': 0, 'fsched_virtual_slot_us': 700,
                                          'direct_tx_send_from_desc': 0})
    args = [a for n, a in uc.calls if n == 'direct_tx_send_from_desc']
    assert len(args) == 1 and args[0][1] == cid
    d = args[0][0]
    assert uc.r16(d) == 0x464 and uc.r16(d + 2) == 700
    f = dyn_alloc(int.from_bytes(uc.rbytes(d + 0x10, 5), 'little'))
    assert f == dict(tid=0, type=1, src=aid, dst=0, dur=32768, rsv=0), f
    assert uc.rbytes(d + 0x15, 2) == bytes(2)


def test_grant_ack_body_reserved(uc):
    """Grant Ack (802.11-2020 9.3.1.18, рис. 9-57): FC 0x0764; после TA — 5 октетов Reserved (нули), затем BF Control."""
    for bf in (0b111, 0):
        for i in range(0x18):
            uc.w8(DST + i, 0xa5)
        uc.call('direct_tx_init_grant_ack', DST, bf)
        assert uc.r16(DST) == 0x764
        assert uc.rbytes(DST + 0x10, 5) == bytes(5), uc.rbytes(DST + 0x10, 5).hex()
        assert uc.r8(DST + 0x15) == bf and uc.r8(DST + 0x16) == 0


@pytest.mark.parametrize('grant_bf0, ack_bf0', [(0x00, 0x00), (0x06, 0x00), (0x01, 0x07), (0x07, 0x07)])
def test_grant_ack_copies_beamforming_training(uc, grant_bf0, ack_bf0):
    """10.39.4: в Grant Ack Beamforming Training копируется из Grant; при 0 IsInitiatorTXSS, IsResponderTXSS и прочие
    подполя BF Control зарезервированы (9.5.5) — 0."""
    uc.w16(RX_BUF + 2, 100)
    uc.w8(RX_BUF + 0x15, grant_bf0)
    uc.w8(RX_BUF + 0x16, 0)
    uc.call('rx_send_grant_ack', stub={'tx_send_imm_response': 0, 'uc_wait_direct_tx_ready': 0, 'direct_tx_commit': 0,
                                       'tx_fifo_write_bytes': 0})
    args = [a for n, a in uc.calls if n == 'tx_fifo_write_bytes']
    assert len(args) == 1 and args[0][1] == 7
    body = uc.rbytes(args[0][0], 7)
    assert body[:5] == bytes(5) and body[5] == ack_bf0 and body[6] == 0, body.hex()
