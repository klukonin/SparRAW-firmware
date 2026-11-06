# SPDX-License-Identifier: AGPL-3.0-or-later
"""DMG CTS-to-self точки перед групповым кадром данных (tx_bcast_flow) против 802.11-2020 9.3.1.13 (рис. 9-52):
«A DMG CTS-to-self frame is a DMG CTS frame in which the RA field is equal to the transmitter's MAC address» и «For
DMG CTS-to-self frames, the TA field is set to the individual address of the recipient or the group address of the
recipients of the frame that the DMG STA intends to transmit after the DMG CTS-to-self frame». Следующий кадр —
групповой кадр широковещательного кольца точки (fsched_peer_id), значит TA — групповой адрес (бит I/G = 1, 9.2.4.3.2),
а не адрес станции. Стенд 2026-11-04/05 (PMC обоих узлов, assoc2/assoc3): TA = MAC станции (16 из 18) или
06:00:00:00:00:00 (первый CTS-to-self серии после простоя) перед 01:00:5e:7f:ff:fa, 33:33:00:00:00:16 и
ff:ff:ff:ff:ff:ff.

Кадр — из записей FIFO прямой передачи: r33 — слово FC + Duration, команда 0x33000443 — свой адрес (RA, MAC вставляет
адрес записи парсера 0x886018), r34 с б24 — полуслова после неё (TA)."""
import struct

import pytest

STA_TAB = 0x801104                     # struct sta_entry[SPARRAW_STA_SLOTS], 0x50 Б, MAC — +0x30
MAINT_STA_MASK = 0x80212c + 0x68       # sls.maint_sta_mask
FSCHED_PEER_ID = 0x800468
BCAST_X0C = 0x802eac + 0xc
TX_BCAST_DESC_ID = 0x8005b0
BCAST_QID = 0x1a                       # широковещательное кольцо (любое qid ≠ 0x1f/0xff)

STA = [bytes.fromhex('24181d26d47b'), bytes.fromhex('26181d2600aa'), bytes.fromhex('02aabbccdd03')]

STUBS = {n: 0 for n in ('mac_select_all_sectors_and_wait', 'mac_cmd_29000001', 'mac_program_tx_vector',
                        'mac_program_tx_with_rate', 'mac_set_rf_chain_state', 'uc_spin_until_event',
                        'uc_wait_one_event', 'mac_evt_enable_bit_sync_b', 'uc_log_emit_snapshot',
                        'mac_program_tx_with_qid', 'qh_read_desc_window', 'macq_desc_read_uc',
                        'macq_desc_write_uc', 'tx_ctx_alloc_next', 'uc_assert', 'uc_wait_direct_tx_ready')}
STUBS.update(macq_probe_empty=1)


def frames(uc, start=0):
    """Кадры FIFO прямой передачи за вызов: [(FC, TA-байты после 0x33000443)]."""
    out, cur = [], None
    for e in uc.cpu.trace[start:]:
        if e[0] != 'extreg' or e[1] != 'w':
            continue
        reg, v = e[2], e[4]
        if reg == 32 and v == 0x33000001:
            cur = dict(fc=None, after_own=None, hw=b'')
        elif cur is None:
            continue
        elif reg == 33 and cur['fc'] is None:
            cur['fc'] = v & 0xffff
        elif reg == 32 and v == 0x33000443:
            cur['after_own'] = len(cur['hw'])
        elif reg == 34 and v & (1 << 24):
            cur['hw'] += struct.pack('<H', v & 0xffff)
        elif reg == 32 and v == 0x33000002:
            out.append((cur['fc'], cur['hw'][cur['after_own']:] if cur['after_own'] is not None else None))
            cur = None
    return out


def run(uc, mask, x0c=0):
    uc.ext.update({47: 1 << 31, 43: (1 << 31) | (1 << 8), 53: 1 << 2})   # MTP_AGGREGATION, ответ MTP (MCS 1), BAP_REL_DONE
    for i, mac in enumerate(STA):
        uc.wbytes(STA_TAB + i * 0x50 + 0x30, mac)
    uc.w8(MAINT_STA_MASK, mask)
    uc.w32(FSCHED_PEER_ID, BCAST_QID)
    uc.w32(BCAST_X0C, x0c)
    uc.w16(TX_BCAST_DESC_ID, 0)
    start = len(uc.cpu.trace)
    uc.call('tx_bcast_flow', 0, stub=STUBS, max_steps=400_000)
    return frames(uc, start)


def is_dmg_cts(fc):
    """9.2.4.1.3 / табл. 9-1, 9-2: Type 1 (Control), Subtype 6 (Control Frame Extension), Control Frame Extension 5."""
    return (fc >> 2) & 3 == 1 and (fc >> 4) & 0xf == 6 and (fc >> 8) & 0xf == 5


@pytest.mark.parametrize('mask', [0x1, 0x2, 0x5, 0x80, 0])
def test_cts_to_self_before_group_data_ta_is_group_address(uc, mask):
    """9.3.1.13: TA DMG CTS-to-self перед групповым кадром — групповой адрес (бит I/G первого октета = 1), не адрес
    станции, на чей сектор идёт копия; маска станций 0 (обход без станций) — так же."""
    fr = run(uc, mask)
    cts = [(fc, ta) for fc, ta in fr if fc is not None and is_dmg_cts(fc)]
    assert len(cts) == 1, 'ожидался один DMG CTS-to-self: %s' % fr
    fc, ta = cts[0]
    assert ta is not None and len(ta) == 6, 'TA не записан после RA (0x33000443): %r' % ta
    assert ta[0] & 1, 'TA %s — индивидуальный адрес, следующий кадр групповой (9.3.1.13)' % ta.hex(':')
    assert ta not in STA
    assert ta == b'\xff' * 6, 'TA %s: групповой адрес кольца — широковещательный' % ta.hex(':')


def test_cts_to_self_ta_same_for_each_station_copy(uc):
    """Две станции: копии группового кадра на секторы обеих — у обоих CTS-to-self один и тот же групповой TA
    (адрес получателей кадра, 9.3.1.13), а не адрес очередной станции."""
    tas = []
    x0c = 0
    for _ in range(2):
        fr = run(uc, 0x3, x0c)
        tas += [ta for fc, ta in fr if fc is not None and is_dmg_cts(fc)]
        x0c = uc.r32(BCAST_X0C)
    assert len(tas) == 2 and tas[0] == tas[1] == b'\xff' * 6, [t.hex(':') for t in tas]
