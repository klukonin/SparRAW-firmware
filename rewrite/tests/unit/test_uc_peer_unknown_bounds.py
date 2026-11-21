# SPDX-License-Identifier: AGPL-3.0-or-later
"""Неизвестный пир (SPARRAW_PEER_UNKNOWN = 8: SLS до ассоциации, SSW незнакомого TA) — у него нет записей выбора
скорости и маски запрета передачи (массивы на SPARRAW_MAX_STA станций). vendor индексировал их восьмёркой: rate_search_
abort(8) писал rs_state[8] = rs_stats[0], bf_resume_sta_tx_masks(…, 8) — tx_dis_mask[8] = itx.abif_overridden
(аудит границ 2026-11-21)."""
import pytest

PEER_UNKNOWN = 8
RS_STATS, RS_STATS_SZ = 0x802670, 0x2c
TX_DIS_MASK = 0x802a90


@pytest.mark.parametrize('ok', [0, 1])
def test_bf_result_unknown_peer_keeps_station0(uc, ok):
    for i in range(RS_STATS_SZ):                        # rs_state[8] накладывается на rs_stats[0]: «активен»
        uc.w8(RS_STATS + i, 0x5a)
    uc.w32(TX_DIS_MASK + 2 * PEER_UNKNOWN, 0xffffffff)
    uc.call('sta_apply_bf_result', ok, PEER_UNKNOWN)
    assert [uc.r8(RS_STATS + i) for i in range(RS_STATS_SZ)] == [0x5a] * RS_STATS_SZ
    assert uc.r32(TX_DIS_MASK + 2 * PEER_UNKNOWN) == 0xffffffff


def test_exit_tx_pause_unknown_peer(uc):
    uc.w32(TX_DIS_MASK + 2 * PEER_UNKNOWN, 0xffffffff)
    uc.call('bf_exit_sta_tx_pause', PEER_UNKNOWN)
    assert uc.r32(TX_DIS_MASK + 2 * PEER_UNKNOWN) == 0xffffffff
