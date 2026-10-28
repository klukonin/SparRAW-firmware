# SPDX-License-Identifier: AGPL-3.0-or-later
"""Смена SIFS ↔ MBIFS вокруг фаз SLS (802.11-2020 10.3.2.3.10: «MBIFS shall be used between the BTI and the A-BFT
and between the ISS, RSS, SSW-Feedback, and SSW-Ack»; 10.42.2.2: RSS — MBIFS после ISS, SSW-Feedback — MBIFS после
RSS, SSW-Ack — MBIFS после SSW-Feedback; вне SLS ответы — через SIFS, 10.3.2.3.3).

MAC отсчитывает ответ/прямую передачу от регистра 0x886d00 (uc/bf.c txss_resp_flow, uc/abft.h H-ORIGIN), поэтому
проверяется значение этого регистра в момент передачи кадра SLS (вызов функции передачи в трассе) и после выхода из
потока: MBIFS, оставленный после BF, растянул бы SIFS-ответы (Ack/BA/DMG CTS) до 9 мкс и сорвал бы их у пира.
Сценарии — целые потоки (txss_init_flow, txss_resp_flow, txss_init_send_fdbk_wait_ack, mac_mode_kick) с заглушками
ожиданий эфира."""
import pytest

from test_uc_ifs_mac import (A_SIFS_US, MBIFS_US, CLK_PER_US, HW_MAC_IFS_SIFS, MAC_IFS_SHADOW, IFS, TXSS_IFS_RESTORE,
                             lmac_mac_cfg, ifs_clk, reg_at, call_events)

SIFS_CLK = A_SIFS_US * CLK_PER_US
MBIFS_CLK = MBIFS_US * CLK_PER_US

TXRX_STATE1, TXRX_STATE2 = 0x8005f4, 0x8005f8
SLS_RX_FLAGS = 0x8021e0
SLS = 0x80212c
SLS_PEER_MAC, SLS_RANK_VALID = SLS + 0x5c, SLS + 0x66
BF_REQ_PENDING = 0x8020b0
BF_STA = 0x801ffc
RXF_STA = 0x802288
UC_ROLE_AP = 0x8014c0
RX_BUF = 0x804010
RX_BUF_TA = RX_BUF + 0x0a
RX_BUF_DURATION = RX_BUF + 2
RX_BUF_SSW = 0x804020
STA_TAB = 0x801104
HW_MAC_USEC_TO_TBTT = 0x886ec0
PEER = bytes.fromhex('24181d243b0b')

# передача SSW-Ack (sls_send_ssw_ack) без эфира: FIFO, RF и ожидания событий не исполняются
ACK_TX_STUBS = {'direct_tx_program_cmd34': 0, 'mac_program_tx_common': 0, 'rx_funcs_send_direct_frame': 0,
                'mac_evt_enable_bit_sync_b': 0, 'mac_set_rf_chain_state_with_sta_sector': 0}


def idle(uc):
    """MAC сконфигурирован (fw: lmac_if_send_init_cfg), регистр и тень — SIFS."""
    lmac_mac_cfg(uc)
    assert ifs_clk(uc.r16(MAC_IFS_SHADOW)) == SIFS_CLK
    return uc


def mbifs_loaded(uc):
    """Состояние после приёма первого SSW ISS (txss.c sls_rx_ssw_frame / rx.c фаза ISS): MBIFS в регистре и тени."""
    idle(uc)
    m = uc.r16(IFS + 0xc)
    uc.w16(MAC_IFS_SHADOW, m)
    uc.w32(HW_MAC_IFS_SIFS, m | 0x1730000)
    return m | 0x1730000


def ifs_at_call(uc, fn, initial):
    ev = call_events(uc, fn)
    assert ev, '%s не вызывалась' % fn
    return [ifs_clk(reg_at(uc, HW_MAC_IFS_SIFS, i, initial) & 0xffff) for i in ev]


def ifs_after(uc, initial):
    return ifs_clk(reg_at(uc, HW_MAC_IFS_SIFS, len(uc.last_trace), initial) & 0xffff)


def assert_back_to_sifs(uc, initial):
    assert ifs_after(uc, initial) == SIFS_CLK, 'после потока в MAC остался IFS ≠ SIFS'
    assert ifs_clk(uc.r16(MAC_IFS_SHADOW)) == SIFS_CLK, 'тень IFS не SIFS — следующая смена IFS будет пропущена'


# ---- инициатор TXSS -------------------------------------------------------------------------------------------

INIT_STUBS = {'rate_search_apply_mcs': 0, 'rss_wait_get': 0, 'txss_init_send_fdbk_wait_ack': 0,
              'txss_rank_best_sector': 0, 'txss_store_sector_ranking': 0, 'bf_store_flow_status': 0}


@pytest.mark.parametrize('iss_ok,rss_ok', [(0, 0), (1, 0), (1, 1)], ids=['iss_fail', 'no_rss', 'success'])
def test_initiator_txss_uses_mbifs_and_restores_sifs(uc, iss_ok, rss_ok):
    """ISS идёт с MBIFS в MAC (RSS пира — через MBIFS, SSW-Feedback — через MBIFS после RSS); при любом исходе потока
    (ISS не ушёл, нет RSS, успех) после выхода — снова SIFS."""
    idle(uc)
    init = uc.r32(HW_MAC_IFS_SIFS)
    uc.call('txss_init_flow', 0, stub=dict(INIT_STUBS, txss_program_tx_frame=iss_ok, txss_init_wait_rss=rss_ok))
    assert ifs_at_call(uc, 'txss_program_tx_frame', init) == [MBIFS_CLK]
    if iss_ok:
        assert ifs_at_call(uc, 'txss_init_wait_rss', init) == [MBIFS_CLK]
    if rss_ok:
        assert ifs_at_call(uc, 'txss_init_send_fdbk_wait_ack', init) == [MBIFS_CLK]
    assert_back_to_sifs(uc, init)
    assert uc.r32(TXSS_IFS_RESTORE) == 0


FDBK_STUBS = {'txss_init_send_ssw_fdbk': 0, 'bf_store_flow_status': 0, 'mac_evt_enable_bit_sync': 0,
              'mac_evt_enable_bit_sync_b': 0, 'gp_timer_arm': 0, 'uc_wait_event1_or_event4': 0, 'rx_flow_run': 0,
              'mac_mode_switch_core_and_rf': 0, 'ese_dti_us_to_window_end': 100000}


@pytest.mark.parametrize('ack', [True, False], ids=['ack', 'no_ack_retries'])
def test_ssw_feedback_after_mbifs_then_sifs(uc, ack):
    """SSW-Feedback инициатора уходит с MBIFS в MAC (10.42.2.2); после него — SIFS (ожидание SSW-Ack/повторы по
    таймеру PIFS после ожидаемого конца Ack, 10.42.6.2, отсчитываются GP1, а не регистром IFS). После выхода — SIFS."""
    init = mbifs_loaded(uc)
    uc.w32(HW_MAC_USEC_TO_TBTT, 0x3ffffff)                   # до TBTT далеко: повторы помещаются в выделение
    uc.w32(SLS_RX_FLAGS, 4 if ack else 0)                    # rx_flow_run (заглушка) «принял» SSW-Ack
    uc.ext[42] = (1 << 19) if ack else 0
    uc.ext[54] = 1 << 7                                      # GP1 — тайм-аут ожидания Ack
    uc.call('txss_init_send_fdbk_wait_ack', 0, stub=FDBK_STUBS)
    seen = ifs_at_call(uc, 'txss_init_send_ssw_fdbk', init)
    assert seen[0] == MBIFS_CLK
    if not ack:                                              # повторы: не больше dot11BFRetryLimit (8, 10.42.6.2)
        assert 1 < len(seen) <= 1 + 8
    assert_back_to_sifs(uc, init)


# ---- ответчик TXSS --------------------------------------------------------------------------------------------

RESP_STUBS = {'rate_search_apply_mcs': 0, 'rss_wait_get': 0, 'sls_send_ssw_ack': 0, 'bf_store_flow_status': 0,
              'txss_rank_best_sector': 0, 'txss_store_sector_ranking': 0, 'bf_flow_exit': 0}


@pytest.mark.parametrize('iss_ok,fb_ok', [(0, 0), (1, 0), (1, 1)], ids=['iss_fail', 'no_feedback', 'success'])
def test_responder_txss_ack_after_mbifs_and_restores_sifs(uc, iss_ok, fb_ok):
    """Ответчик: MBIFS загружен приёмом ISS; SSW-Ack уходит с MBIFS в MAC (10.42.2.2 «responder shall begin an SSW ack
    procedure an MBIFS following the reception of an SSW-Feedback frame»); при любом исходе после потока — SIFS."""
    init = mbifs_loaded(uc)
    uc.call('txss_resp_flow', 0, stub=dict(RESP_STUBS, txss_resp_wait_iss_end=iss_ok, txss_resp_wait_fdbk=fb_ok))
    if fb_ok:
        assert ifs_at_call(uc, 'sls_send_ssw_ack', init) == [MBIFS_CLK]
    assert_back_to_sifs(uc, init)
    assert uc.r32(TXSS_IFS_RESTORE) == 0


RX_STUBS = {'uc_wait_event_busy': 0, 'rx_parse_ssw_field': 0, 'rx_switch_to_rx_mode': 0,
            'rx_funcs_record_level_8020f8_8020fc': 0, 'sta_set_tx_sector': 0, 'sta_tbl_find_by_mac': 0}


def test_iss_reception_loads_mbifs(uc):
    """Первый SSW ISS у ответчика (фаза приёма ISS) загружает MBIFS: следующий кадр ответчика — первый SSW RSS через
    MBIFS после конца ISS (10.42.2.2)."""
    idle(uc)
    init = uc.r32(HW_MAC_IFS_SIFS)
    uc.wbytes(RX_BUF_TA, PEER)
    uc.wbytes(SLS_PEER_MAC, PEER)
    uc.w32(TXRX_STATE2, 0x100000)
    uc.w16(RX_BUF_SSW, 0)
    uc.ext.update({38: 0, 36: 1 << 6, 37: 1 << 24, 39: 0})
    uc.call('rx_funcs_handle_ppdu_report', stub=RX_STUBS)
    assert ifs_after(uc, init) == MBIFS_CLK
    assert ifs_clk(uc.r16(MAC_IFS_SHADOW)) == MBIFS_CLK


def test_chain_iss_reception_then_responder_flow_ends_in_sifs(uc):
    """Цепочка ответчика: приём ISS (MBIFS) → поток ответчика с успешным SSW-Ack → после BF SIFS."""
    test_iss_reception_loads_mbifs(uc)
    init = uc.r32(HW_MAC_IFS_SIFS)
    uc.call('txss_resp_flow', 0, stub=dict(RESP_STUBS, txss_resp_wait_iss_end=1, txss_resp_wait_fdbk=1))
    assert ifs_at_call(uc, 'sls_send_ssw_ack', init) == [MBIFS_CLK]
    assert_back_to_sifs(uc, init)


@pytest.mark.xfail(strict=True, reason='802.11-2020 10.42.2.2/10.3.2.3.10: SSW-Ack на повтор SSW-Feedback, '
                   'отправленный из обработчика приёма (txss.c sls_rx_ssw_frame → sls_send_ssw_ack, ветка r37.25), '
                   'уходит при SIFS в 0x886d00: MBIFS грузится только при приёме SSW (r37.24), а поток ответчика '
                   'уже вернул SIFS')
def test_ack_to_retried_feedback_after_mbifs(uc):
    """Инициатор не получил SSW-Ack и повторил SSW-Feedback (10.42.6.2) уже после конца потока ответчика (рейтинг
    секторов сохранён, sls_rank_valid_mask): ответчик в цикле приёма DTI (txrx_state1 = 8) отвечает SSW-Ack прямо из
    обработчика. По 10.42.2.2 SSW-Ack — через MBIFS после SSW-Feedback; в MAC в этот момент должен быть MBIFS."""
    idle(uc)
    init = uc.r32(HW_MAC_IFS_SIFS)
    uc.w32(TXRX_STATE1, 8)
    uc.w32(BF_REQ_PENDING, 0)
    uc.w32(UC_ROLE_AP, 1)
    uc.w32(RXF_STA, 0)
    uc.w32(BF_STA, 0)
    uc.w8(SLS_RANK_VALID, 1)
    uc.wbytes(RX_BUF_TA, PEER)
    uc.wbytes(STA_TAB + 0x30, PEER)
    uc.w16(RX_BUF_DURATION, 28)
    uc.ext.update({36: 1 << 6, 37: 1 << 25, 42: 1 << 15})
    uc.call('sls_rx_ssw_frame', stub=dict(ACK_TX_STUBS, rx_parse_ssw_field=0, rx_funcs_record_level_8020f8_8020fc=0,
                                          sta_set_tx_sector=0))
    tx = [i for i, e in enumerate(uc.last_trace)
          if e[0] == 'extreg' and e[1] == 'w' and e[2] == 32 and (e[4] >> 24) == 0x19]
    assert tx, 'SSW-Ack не передан'
    assert ifs_clk(reg_at(uc, HW_MAC_IFS_SIFS, tx[0], init) & 0xffff) == MBIFS_CLK


# ---- A-BFT (AP) -----------------------------------------------------------------------------------------------

def test_abft_ap_mbifs_during_abft_then_sifs(uc):
    """AP в A-BFT (mac_mode_kick): SSW-Feedback на SSW станции — через MBIFS (10.42.5.2: Feedback начинается за
    aSSFBDuration + MBIFS до конца слота; MAC отсчитывает его от 0x886d00), по окончании A-BFT (r54.6) — SIFS."""
    idle(uc)
    init = uc.r32(HW_MAC_IFS_SIFS)
    uc.ext[54] = lambda n, k: 0 if k == 0 else 1 << 6       # один слот A-BFT, затем конец
    uc.call('mac_mode_kick', 0x806900, stub={'uc_spin_until_event4': 0, 'mac_mode_program_c': 0})
    assert ifs_at_call(uc, 'mac_mode_program_c', init) == [MBIFS_CLK]
    assert_back_to_sifs(uc, init)


# ---- после BF: следующие ответы через SIFS, BRP — в [SIFS, BRPIFS] ---------------------------------------------

def tx_cmd_indices(uc):
    return [i for i, e in enumerate(uc.last_trace)
            if e[0] == 'extreg' and e[1] == 'w' and e[2] == 32 and (e[4] >> 24) == 0x19]


GRANT_ACK_STUBS = {'direct_tx_program_cmd34': 0, 'mac_program_tx_with_rate': 0, 'tx_fifo_write_bytes': 0,
                   'uc_wait_direct_tx_ready': 0, 'direct_tx_issue_cmd_33': 0}


@pytest.mark.parametrize('flow,stubs', [
    ('txss_init_flow', dict(INIT_STUBS, txss_program_tx_frame=1, txss_init_wait_rss=1)),
    ('txss_init_flow', dict(INIT_STUBS, txss_program_tx_frame=1, txss_init_wait_rss=0)),
    ('txss_resp_flow', dict(RESP_STUBS, txss_resp_wait_iss_end=1, txss_resp_wait_fdbk=1)),
    ('txss_resp_flow', dict(RESP_STUBS, txss_resp_wait_iss_end=1, txss_resp_wait_fdbk=0)),
], ids=['init_ok', 'init_no_rss', 'resp_ok', 'resp_no_fb'])
def test_sifs_response_after_bf_uses_sifs(uc, flow, stubs):
    """Цепочка: поток BF (любой исход) → принят Grant → Grant Ack через SIFS (10.39.4, 10.3.2.3.3): в момент передачи
    в MAC — aSIFSTime, а не оставшийся от SLS MBIFS."""
    if flow == 'txss_resp_flow':
        mbifs_loaded(uc)                                     # ответчик: MBIFS загружен приёмом ISS
    else:
        idle(uc)
    uc.call(flow, 0, stub=stubs)
    init = uc.r32(HW_MAC_IFS_SIFS)
    uc.w16(RX_BUF_DURATION, 100)
    uc.call('rx_send_dmg_cts', stub=GRANT_ACK_STUBS)
    tx = tx_cmd_indices(uc)
    assert tx
    assert ifs_clk(reg_at(uc, HW_MAC_IFS_SIFS, tx[0], init) & 0xffff) == SIFS_CLK


def test_brp_after_sls_within_sifs_brpifs(uc):
    """Цепочка SLS инициатора (успех) → BRP-кадр инициатора (brp_init_tx_request): Figure 10-85 / 10.3.2.3.9 — между
    SSW-Ack и BRP не меньше SIFS и не больше BRPIFS (aBRPIFS 40 мкс + 10 %); в MAC — IFS из этого диапазона."""
    from test_uc_brp_frame import run as brp_run
    idle(uc)
    uc.call('txss_init_flow', 0, stub=dict(INIT_STUBS, txss_program_tx_frame=1, txss_init_wait_rss=1))
    init = uc.r32(HW_MAC_IFS_SIFS)
    brp_run(uc)
    tx = tx_cmd_indices(uc)
    assert tx
    ifs = ifs_clk(reg_at(uc, HW_MAC_IFS_SIFS, tx[0], init) & 0xffff)
    assert SIFS_CLK <= ifs <= 44 * CLK_PER_US
