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


# ---- команды fw → uc с номером станции / очереди за массивом (H2–H4) ----

SCRATCH = 0x806800                       # свободная часть разделяемой области DCCM (тело LMAC-команды)
DCCM_LO, DCCM_HI = 0x800000, 0x803c00    # DCCM uc без стека (вершина 0x804000, вызов обработчика — сотни байт)
CASES = [                                # (обработчик, тело, код останова)
    ('keep_alive_arm_slot', None, 0x15a0),
    ('ucode_cmd_0x12_handler_uc', bytes([8]), 0x15a1),
    ('ucode_cmd_0x30_handler_uc', bytes([8, 1, 3, 0]), 0x15a3),
    ('ucode_cmd_0x32_handler', bytes([0xc8, 1, 3, 0]), 0x15a4),
    ('ucode_cmd_0x13_handler', bytes([8, 1]) + bytes(0x26), 0x15a5),
    ('ucode_cmd_0x05_handler', bytes(0xc) + bytes([9]) + bytes(0x1b), 0x15a8),        # cid +0x0c, op 0
    ('ucode_cmd_0x0f_handler', bytes([8, 0, 0, 0, 1, 0]), 0x15a9),
    ('ucode_cmd_0x08_handler', bytes([40, 0]) + bytes(0x1e), 0x15aa),
]


@pytest.mark.parametrize('fn,body,code', CASES, ids=[c[0] for c in CASES])
def test_lmac_index_out_of_range_halts_without_write(uc, fn, body, code):
    """vendor индексировал таблицы uc номером из команды fw без проверки (запись по DCCM uc и в общую с fw память).
    Теперь — uc_assert со своим кодом до любой записи."""
    if body is None:
        arg = PEER_UNKNOWN
    else:
        uc.cpu.write(SCRATCH, body)
        arg = SCRATCH
    before = bytes(uc.cpu.read(a, 1) for a in range(DCCM_LO, DCCM_HI))
    uc.calls.clear()
    lo = uc.sym[fn] & 0x1ffff                # хвостовой «b» в uc_assert cpu.py ловит только при заданном func_range
    uc.cpu.func_range = (lo, min(a & 0x1ffff for a in uc.sym.values() if (a & 0x1ffff) > lo))
    try:
        uc.call(fn, arg, stub={'uc_assert': 0})
    finally:
        uc.cpu.func_range = None
    assert [c[1][1] for c in uc.calls if c[0] == 'uc_assert'] == [code]
    after = bytes(uc.cpu.read(a, 1) for a in range(DCCM_LO, DCCM_HI))
    diff = [hex(DCCM_LO + i) for i in range(len(before)) if before[i] != after[i]]
    assert not diff, diff[:8]


BF_REQ = 0x8020b0                        # struct bf_req_q_s: pending_mask, fifo[8], head (+0xc), tail (+0x10)


def test_bf_clear_all_sta_empty_mask_resyncs(uc):
    """FIFO запросов BF не пуста, а маска пуста (рассинхрон): vendor bf_reset_sta(30 − norm(0) = −1) — запись перед
    bf_sta, и цикл не кончался. Теперь FIFO сбрасывается."""
    uc.w32(BF_REQ, 0)
    uc.w32(BF_REQ + 0xc, 3)
    uc.w32(BF_REQ + 0x10, 5)
    uc.call('bf_clear_all_sta', max_steps=200_000)
    assert uc.r32(BF_REQ + 0xc) == uc.r32(BF_REQ + 0x10)


@pytest.mark.parametrize('ac,ecw_min,ecw_max,aifsn', [(4, 4, 10, 3), (0, 24, 10, 3), (0, 4, 32, 3), (0, 4, 10, 16)])
def test_edca_fields_out_of_range_halt(uc, ac, ecw_min, ecw_max, aifsn):
    """LMAC 0x04: индекс AC < 4, ECWmin/ECWmax/AIFSN — 4-битные поля (9.4.2.28). vendor: ECW ≥ 24 — маска в коде
    команды MAC, ≥ 32 — сдвиг за слово. Теперь — останов 0x15ac до записи регистров EDCA."""
    import struct
    uc.cpu.write(SCRATCH, struct.pack('<IHHH2x', ac, ecw_min, ecw_max, aifsn))
    lo = uc.sym['txrx_api_program_edca_ac'] & 0x1ffff
    uc.cpu.func_range = (lo, min(a & 0x1ffff for a in uc.sym.values() if (a & 0x1ffff) > lo))
    uc.calls.clear()
    try:
        uc.call('txrx_api_program_edca_ac', ac, SCRATCH, stub={'uc_assert': 0})
    finally:
        uc.cpu.func_range = None
    assert [c[1][1] for c in uc.calls if c[0] == 'uc_assert'] == [0x15ac]
