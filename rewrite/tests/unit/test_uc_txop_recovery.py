# SPDX-License-Identifier: AGPL-3.0-or-later
"""Поток вверх станция → наша точка вставал через ~1 с (стенд 2026-11-03: MAC станции idle, кадров от станции нет,
через 5 с потеря связи по старению TX, assert fw 0x12aa). Цепочка: точка теряет RTS станции, станция после RTS без
DMG CTS закрывает TXOP, которого не получала, — CF-End (802.11-2020 10.23.2.10) — и ждёт событий MAC о нём без срока.

Здесь — по функции:
- tx_sta_wait_slot_and_tx / tx_sta_run_txop: RTS без DMG CTS — передача RTS не удалась (10.3.2.9): backoff, без
  закрытия TXOP (ни запроса итога, ни CF-End);
- uc_wait_txop_end: ожидание txop_event (конец TXOP у MAC) — не дольше лимита TXOP + запас, счётчик
  mac_mon_report.txop_end_tmo; tx_send_and_await_rx_frame после CF-End без txop_event возвращается."""
import pytest

CLK = 165
M32 = 0xffffffff
PATH = 2 * CLK
TXOP_LIMIT_CUR = 0x800478
MAC_MON = 0x801084
TXOP_END_TMO = MAC_MON + 0x6a
TXRX_STATE2 = 0x8005f8
TX_CTX0 = 0x802978
TX_CTX_CUR = 0x802978 + 0x78
LINK_STAT = 0x857e38
CTS_FAIL = LINK_STAT + 0x10
DTI_QSET_MODE = 0x8004f4
BF_CTRL = 0x8021b8

EVT_TXOP, EVT_BUSY2, EVT_TX_END = 1 << 7, 1 << 14, 1 << 15


# ---- uc_wait_txop_end: ожидание конца TXOP со сроком ------------------------------------------------------------

def test_wait_txop_end_event(uc):
    uc.ext[42] = EVT_TXOP
    uc.w32(TXOP_LIMIT_CUR, 2000)
    n0 = uc.r8(TXOP_END_TMO)
    assert uc.call('uc_wait_txop_end') == 1
    assert uc.r8(TXOP_END_TMO) == n0


@pytest.mark.parametrize('limit_us', [2000, 300])
def test_wait_txop_end_bounded(uc, limit_us):
    """txop_event не приходит (у MAC нет TXOP): выход не раньше лимита TXOP (TXOP не бывает длиннее) и не позже
    лимит + 100 мкс + путь; mac_mon_report.txop_end_tmo + 1. Прежде — uc_spin_until_event без срока (SpinError)."""
    uc.ext[42] = 0
    uc.w32(TXOP_LIMIT_CUR, limit_us)
    n0 = uc.r8(TXOP_END_TMO)
    t0 = uc.t1()
    assert uc.call('uc_wait_txop_end', max_steps=4_000_000) == 0
    dt = uc.t1() - t0
    assert limit_us * CLK <= dt <= (limit_us + 100) * CLK + PATH, dt / CLK
    assert uc.r8(TXOP_END_TMO) == (n0 + 1) & 0xff


HOLDER_STUBS = {n: 0 for n in (
    'cf_end_send_frame', 'uc_sleep_until_event', 'gp0_timer_arm_usec', 'mac_set_rf_chain_state', 'uc_wait_one_event',
    'rx_mode_configure', 'mac_program_tx_vector')}


def test_cf_end_without_txop_event_returns(uc):
    """Держатель TXOP послал CF-End (Duration 18), ответа нет (тайм-аут GP0 — tx_await_rx_or_timeout = 1), txop_event
    MAC не поднимает: tx_send_and_await_rx_frame возвращается не позже лимита TXOP + запас, txop_end_tmo + 1.
    Прежде основной поток uc висел здесь навсегда (команды LMAC ещё обслуживались прерыванием, приём и TX — нет)."""
    uc.w32(TX_CTX0, 0)
    uc.w32(DTI_QSET_MODE, 0)
    uc.w32(TXOP_LIMIT_CUR, 300)
    uc.ext.update({40: 0xffff, 42: EVT_BUSY2 | EVT_TX_END})   # остаток TXOP большой; txop_event нет
    n0 = uc.r8(TXOP_END_TMO)
    uc.call('tx_send_and_await_rx_frame', TX_CTX0, 0, 0, 0, stub=dict(HOLDER_STUBS, tx_await_rx_or_timeout=1),
            max_steps=4_000_000)
    assert [n for n, _ in uc.calls].count('cf_end_send_frame') == 1
    assert uc.r8(TXOP_END_TMO) == (n0 + 1) & 0xff


# ---- RTS без DMG CTS: backoff, без закрытия TXOP ---------------------------------------------------------------

RUN_TXOP_STUBS = {n: 0 for n in ('txop_pick_ctrl_code_by_peer', 'handle_bf_triggers', 'tx_cca_check_and_send',
                                 'mac_select_rf_module_cmd31', 'rx_flow_run', 'bf_metrics_reset_and_stamp',
                                 'rx_check_mode_2')}


@pytest.mark.parametrize('rx_mode_flags', [3, 1])
def test_rts_without_cts_no_cf_end(uc, rx_mode_flags):
    """802.11-2020 10.3.2.9: RTS ушёл, DMG CTS за CTSTimeout нет — передача RTS не удалась, backoff (окно слотов
    растёт — tx_pick_slot_for_peer(1), cts_fail + 1); TXOP не получен — 10.23.2.10: «A non-AP STA that is not the TXOP
    holder shall not transmit a CF-End frame». tx_sta_run_txop не закрывает TXOP: ни tx_cca_check_and_send (запрос
    итога передачи + CF-End), ни ожиданий конца TXOP. Прежде (rx_mode_flags б1 = 1 — по умолчанию) — закрывал."""
    uc.w32(TX_CTX0 + 0, 0)                                   # sta 0
    uc.w32(TX_CTX0 + 4, 0)                                   # qid 0
    uc.w32(TX_CTX_CUR, TX_CTX0)
    uc.w32(0x801424, rx_mode_flags)                          # rx_mode_flags
    uc.w8(CTS_FAIL, 0)
    uc.w8(BF_CTRL + 8, 0xff)                                 # порог cts_fail → BF (ctrl_code_tx) — не достигнут
    uc.w8(BF_CTRL + 0xa, 0xff)
    uc.w32(TXRX_STATE2, 0x104)                               # б8 ждём ответ, б2 — открыли RTS
    uc.ext[42] = 0
    uc.call('tx_sta_run_txop', TX_CTX0, stub=dict(RUN_TXOP_STUBS, txop_initiator_open_txop_flow=1,
                                                   sxd_hal_wait_slot2_busy2=0))
    names = [n for n, _ in uc.calls]
    assert 'tx_cca_check_and_send' not in names, names
    assert uc.r8(CTS_FAIL) == 1
