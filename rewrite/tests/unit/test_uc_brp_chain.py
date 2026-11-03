# SPDX-License-Identifier: AGPL-3.0-or-later
"""Цепочка SLS → BRP (10.42.6.4): BRP Request пира в SSW-Feedback/SSW-Ack (9.3.1.16/17, поле 9.5.4) разбирается
приёмом (rx_handle_ppdu_report), инициатор BRP строит контекст (brp_init_reset_ctx) и кадр (brp_init_tx_request).
Проверяется итог в кадре, а не отдельные функции: так ловятся ошибки состояния между ними."""
import os

import pytest

import ucemu

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
            'bf_rep_record_snr_level': 0, 'sta_set_tx_sector': 0, 'sta_tbl_find_by_mac': 0}


def receive_feedback(uc, l_rx, tx_trn_req=0, mid_req=0, bc_req=0, phase=1 << 23):
    """Принят SSW-Feedback (phase 1<<23, r37 б25) или SSW-Ack (phase 1<<22, r37 б26) от пира текущего SLS."""
    uc.wbytes(TA, PEER)
    uc.wbytes(SLS_PEER_MAC, PEER)
    uc.wbytes(FB_BRP_REQ, [l_rx | tx_trn_req << 5 | mid_req << 6 | bc_req << 7, 0, 0, 0])
    uc.w32(TXRX_STATE2, phase)
    uc.ext.update({38: 0, 36: 1 << 6, 37: (1 << 25) if phase == 1 << 23 else (1 << 26), 39: 0})
    uc.call('rx_handle_ppdu_report', stub=RX_STUBS)
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
    uc.call('rx_handle_ppdu_report', stub=RX_STUBS)
    assert uc.r8(BF_STA + 9) == 7


# ---------------------------------------------------------------- BRP-кадр пира на приёме

_A = ucemu.dccm_addrs(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))),
                                   'uc', 'dccm.h'))
BF_STA_MASK, BF_BRP_REQ_MASK = _A['bf_sta_mask'], _A['bf_brp_req_mask']     # u16: станции BF / с запросом BRP
INIT_PEER_REQ = 0x800824 + 0x54                      # brp_ctx.init_peer_req — разобранный запрос пира


def peer_brp_frame(l_rx=0, tx_trn_req=0, rx_train_response=0, tx_train_response=0, cap_req=0, mid_ext=0,
                   fbck_type=0, fbck_req=0):
    """BRP-кадр пира (9.6.21.3, Table 9-488) — Action No Ack: заголовок 24 октета (FC подтип 14, Duration, A1..A3,
    Sequence Control), Category 20 (Unprotected DMG), Unprotected DMG Action 1 (BRP, Table 9-486), Dialog Token,
    BRP Request (рис. 9-850), DMG Beam Refinement element (рис. 9-558: Element ID 153, Length 5, поля B16..B55)."""
    hdr = (0x00e0).to_bytes(2, 'little') + bytes(2) + bytes(6) + PEER + PEER + bytes(2)
    req = l_rx | tx_trn_req << 5
    el = (rx_train_response << 18 | tx_train_response << 17 | fbck_req << 29 | fbck_type << 34 | mid_ext << 52 |
          cap_req << 53) >> 16
    return hdr + bytes([20, 1, 7]) + req.to_bytes(4, 'little') + bytes([153, 5]) + el.to_bytes(5, 'little')


def parse_peer_brp(uc, frame, sta=0):
    """brp_parse_request_fields(sta) по кадру в буфере приёма → слово запроса (uc/dccm.h brp_ctx.init_peer_req:
    б0 RX-train-response пира, б1 TX-TRN-REQ, б2 «пир просит BRP-RX», б3 Capability Request, б4..8 L-RX)."""
    uc.wbytes(RX_BUF, frame)
    uc.w16(BF_STA_MASK, 0xffff)
    uc.w16(BF_BRP_REQ_MASK, 0)
    return uc.call('brp_parse_request_fields', sta)


@pytest.mark.parametrize('cap,mid_ext,fbck_type', [(1, 0, 0), (0, 0, 1 << 16), (0, 0, (1 << 18) - 1), (0, 1, 0),
                                                   (1, 1, (1 << 18) - 1)],
                         ids=['cap', 'B50', 'fbck_type_all', 'mid_ext', 'all'])
def test_rx_capability_request_is_b53(uc, cap, mid_ext, fbck_type):
    """9.4.2.129 рис. 9-558: Capability Request — B53 элемента DMG Beam Refinement (FBCK-TYPE B34..B51, MID Extension
    B52). Биты FBCK-TYPE (в том числе B50 — Number of Beams, рис. 9-560) и MID Extension запросом возможностей не
    считаются."""
    w = parse_peer_brp(uc, peer_brp_frame(l_rx=4, cap_req=cap, mid_ext=mid_ext, fbck_type=fbck_type))
    assert bits(w, 3, 1) == cap, hex(w)
    assert bits(w, 4, 5) == 4


@pytest.mark.parametrize('rx_resp,tx_trn', [(0, 0), (1, 0), (0, 1), (1, 1)])
def test_rx_brp_request_fields(uc, rx_resp, tx_trn):
    """RX-train-response B18 элемента (пир подтверждает наш запрос BRP-RX — дальше измеряем TRN-R, 10.42.6.4.3),
    TX-TRN-REQ B5 поля BRP Request (9.5.4); TX-train-response B17 рядом — не путается с RX-train-response. Запрос BRP
    отмечен в маске станции."""
    w = parse_peer_brp(uc, peer_brp_frame(rx_train_response=rx_resp, tx_trn_req=tx_trn, tx_train_response=1), sta=2)
    assert (bits(w, 0, 1), bits(w, 1, 1)) == (rx_resp, tx_trn), hex(w)
    assert uc.r16(BF_BRP_REQ_MASK) & (1 << 2) and not uc.r16(BF_STA_MASK) & (1 << 2)


@pytest.mark.parametrize('cap', [0, 1])
@pytest.mark.parametrize('l_rx', [1, 8, 16])
def test_rx_brp_l_rx_served_unless_capability_request(uc, cap, l_rx):
    """Цепочка BRP пира → наш BRP-кадр (10.42.6.3.1, 10.42.6.4.2): L-RX > 0 — пиру нужна приёмная тренировка, наш
    следующий BRP отвечает RX-train-response = 1 и несёт 4·L-RX TRN-R; в фазе установки (Capability Request = 1 —
    ответ полями BRP Request, тренировки ещё нет) L-RX — объявление, а не запрос TRN-R."""
    w = parse_peer_brp(uc, peer_brp_frame(l_rx=l_rx, cap_req=cap))
    assert bits(w, 2, 1) == (0 if cap else 1), hex(w)
    uc.w8(0x800824 + 0x48, 0)                      # brp_ctx.init_sta
    uc.w32(0x800824 + 0x50, 0)                     # init_flags: своя приёмная тренировка не нужна
    uc.w32(INIT_PEER_REQ, w)
    uc.ext.update({36: 0, 37: 0})
    uc.w32(STA_TAB + 0x08, 0x21 << 8)
    uc.call('brp_init_tx_request', stub=WAITS)
    e = dmg_br(uc.rbytes(BR_ELEM, 7))
    assert e['rx_train_response'] == (0 if cap else 1)
    assert trn_r_units(uc.mac_cmds) == (0 if cap else l_rx)
