# SPDX-License-Identifier: AGPL-3.0-or-later
"""Окно бодрствования (BI_STATE_AW, bi_rx_slot_handler) без ATIM. ATIM в DMG BSS — только для станций в режиме PS,
в Awake Window, объявленном элементом Awake Window (802.11-2020 11.2.7.1: «During the awake window, a STA shall
transmit only ATIM frames»; 11.2.8 a/c). Энергосбережение вырезано (PS-запросы отклоняются, Awake Window никто не
объявляет) — ATIM не шлём; стенд 2026-11-04 (PMC обоих узлов): vendor-путь слал ~6 ATIM в секунду с каждого узла
(Duration 19). Пиры с трафиком — бодрствующие с передачей сразу (как после успешного ATIM)."""
import pytest

BI_AW = 0x802f44 + 0x24                 # bi_ctx.aw (struct aw_win_s)
PM_CTX = 0x802f80
AWAKE, NO_TX = PM_CTX + 0x134, PM_CTX + 0x138
UC_ROLE_AP = 0x8014c0
MAC_MON = 0x801084
TX_ATIM_PASS, TX_ATIM_FAIL, TX_ATIM_CNT = MAC_MON + 0x39, MAC_MON + 0x3a, MAC_MON + 0x3b
STUBS = {n: 0 for n in ('mac_backoff_settle_set_chain_modes', 'internal_tx_clear_pending_bit',
                        'mac_read_bi_start_tsf64_uc')}


@pytest.mark.parametrize('ap', [1, 0])
@pytest.mark.parametrize('pend', [0x1, 0x5, 0x100, 0])
def test_awake_window_sends_no_atim(uc, ap, pend):
    uc.w32(UC_ROLE_AP, ap)
    uc.w32(BI_AW, pend)                 # pend: б0..7 — станции с трафиком, б8..15 — без сопоставления
    uc.w32(BI_AW + 4, 0)                # cur_bit, round
    uc.w32(AWAKE, 0)
    uc.w32(NO_TX, pend & 0xffff)
    for a in (TX_ATIM_PASS, TX_ATIM_FAIL, TX_ATIM_CNT):
        uc.w8(a, 0)
    uc.call('bi_rx_slot_handler', BI_AW, stub=STUBS, max_steps=200_000)
    tx = [c for c in uc.mac_cmds if c >> 24 in (0x19, 0x34, 0x33, 0x37, 0x15)]
    assert not tx, 'передача в окне бодрствования: %s' % [hex(c) for c in tx]
    assert [uc.r8(a) for a in (TX_ATIM_PASS, TX_ATIM_FAIL, TX_ATIM_CNT)] == [0, 0, 0]
    assert uc.r32(BI_AW) & 0xffff == 0, 'обход не закончен'
    assert uc.r32(AWAKE) & pend == pend and uc.r32(NO_TX) & pend == 0
