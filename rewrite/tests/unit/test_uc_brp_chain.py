# SPDX-License-Identifier: AGPL-3.0-or-later
"""Цепочка SLS → BRP (10.42.6.4): BRP Request пира в SSW-Feedback/SSW-Ack (9.3.1.16/17, поле 9.5.4) разбирается
приёмом (rx_funcs_handle_ppdu_report), инициатор BRP строит контекст (brp_init_reset_ctx) и кадр (brp_init_tx_request).
Проверяется итог в кадре, а не отдельные функции: так ловятся ошибки состояния между ними."""
import pytest

from test_uc_brp_frame import BRP_REQ, BR_ELEM, WAITS, brp_request, dmg_br, bits

RX_BUF = 0x804010
TA = RX_BUF + 0x0a                 # адрес 2
FB_BRP_REQ = RX_BUF + 0x13         # SSW-Feedback/SSW-Ack: FC 2, Duration 2, RA 6, TA 6, SSW Feedback 3 → BRP Request
SLS_PEER_MAC = 0x80212c + 0x5c
TXRX_STATE2 = 0x8005f8
BF_STA = 0x801ffc                  # bf_sta[sta]: +9 L-RX пира, +0xa б0 «пир просил BRP-RX без MID/BC»
STA_TAB = 0x801104
PEER = bytes.fromhex('24181d243b0b')

RX_STUBS = {'uc_wait_event_busy': 0, 'rx_parse_ssw_field': 0, 'rx_end_switch_to_tx': 0,
            'rx_funcs_record_level_8020f8_8020fc': 0, 'sta_set_tx_sector': 0, 'sta_tbl_find_by_mac': 0}


def receive_feedback(uc, l_rx, tx_trn_req=0, mid_req=0, bc_req=0, phase=1 << 23):
    """Принят SSW-Feedback (phase 1<<23, r37 б25) или SSW-Ack (phase 1<<22, r37 б26) от пира текущего SLS."""
    uc.wbytes(TA, PEER)
    uc.wbytes(SLS_PEER_MAC, PEER)
    uc.wbytes(FB_BRP_REQ, [l_rx | tx_trn_req << 5 | mid_req << 6 | bc_req << 7, 0, 0, 0])
    uc.w32(TXRX_STATE2, phase)
    uc.ext.update({38: 0, 36: 1 << 6, 37: (1 << 25) if phase == 1 << 23 else (1 << 26), 39: 0})
    uc.call('rx_funcs_handle_ppdu_report', stub=RX_STUBS)
    return uc.r8(BF_STA + 9), uc.r8(BF_STA + 0xa) & 1


def build_brp(uc, sta=0):
    uc.ext.update({36: 0, 37: 0})
    e = STA_TAB + 0x50 * sta
    uc.w32(e + 0x08, 0x21 << 8)
    uc.call('brp_init_reset_ctx', sta)
    uc.call('brp_init_tx_request', stub=WAITS)
    return brp_request(uc.rbytes(BRP_REQ, 4)), dmg_br(uc.rbytes(BR_ELEM, 7)), uc.mac_cmds


def trn_r_units(cmds):
    t = [c for c in cmds if (c >> 24) == 0x20 and c & (1 << 10)]
    return bits(t[-1], 4, 5) if t else 0


@pytest.mark.parametrize('phase', [1 << 23, 1 << 22], ids=['ssw_feedback', 'ssw_ack'])
@pytest.mark.parametrize('l_rx', [0, 1, 16])
def test_peer_rx_training_request_is_served(uc, phase, l_rx):
    """L-RX пира 1..16 без MID/BC — наш BRP-кадр отвечает RX-train-response = 1 и несёт 4·L-RX TRN-R."""
    got_lrx, flag = receive_feedback(uc, l_rx, phase=phase)
    assert got_lrx == l_rx and flag == 1
    r, e, cmds = build_brp(uc)
    assert e['rx_train_response'] == (1 if l_rx else 0)
    assert trn_r_units(cmds) == l_rx


@pytest.mark.parametrize('l_rx', [17, 24, 31])
def test_reserved_l_rx_not_served(uc, l_rx):
    """9.5.4: L-RX вне 0..16 — резерв; запрос не выполняется (не больше 64 TRN-R)."""
    receive_feedback(uc, l_rx)
    _, e, cmds = build_brp(uc)
    assert e['rx_train_response'] == 0
    assert trn_r_units(cmds) == 0


@pytest.mark.parametrize('mid,bc', [(1, 0), (0, 1)])
def test_mid_or_bc_request_is_not_rx_training(uc, mid, bc):
    """MID-REQ/BC-REQ = 1: L-RX — число TRN-units на AWV в MID/BC (9.5.4), а не запрос BRP-RX (10.42.6.4.3/4)."""
    _, flag = receive_feedback(uc, 16, mid_req=mid, bc_req=bc)
    assert flag == 0
    _, e, cmds = build_brp(uc)
    assert e['rx_train_response'] == 0
    assert trn_r_units(cmds) == 0


def test_feedback_from_other_station_ignored(uc):
    """Кадр не от пира текущего SLS (TA ≠ sls.peer_mac) не меняет его запрос."""
    uc.w8(BF_STA + 9, 7)
    uc.wbytes(TA, bytes.fromhex('26181d26d47b'))
    uc.wbytes(SLS_PEER_MAC, PEER)
    uc.wbytes(FB_BRP_REQ, [16, 0, 0, 0])
    uc.w32(TXRX_STATE2, 1 << 23)
    uc.ext.update({38: 0, 36: 1 << 6, 37: 1 << 25, 39: 0})
    uc.call('rx_funcs_handle_ppdu_report', stub=RX_STUBS)
    assert uc.r8(BF_STA + 9) == 7
