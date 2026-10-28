# SPDX-License-Identifier: AGPL-3.0-or-later
"""BRP-кадр инициатора (brp_init_tx_request) против 802.11-2020: 9.5.4 BRP Request, 9.4.2.129 DMG Beam Refinement,
10.42.6.4 (запрос/ответ тренировки). Эталон — поля, разобранные из байт тела кадра по рисункам стандарта."""
import pytest

BODY = 0x8008b0                   # тело BRP-кадра в DCCM (14 Б, mac.c tx_fifo_write_bytes(0x8008b0, 0xe))
BRP_REQ = BODY + 3                # BRP Request field, 4 октета (Category, Action, Dialog Token перед ним)
BR_ELEM = BODY + 7                # DMG Beam Refinement element: ID, Length, 5 октетов полей
BRP_CTX = 0x800824
INIT_STA, INIT_FLAGS, INIT_PEER_REQ = BRP_CTX + 0x48, BRP_CTX + 0x50, BRP_CTX + 0x54
STA_TAB, STA_SZ = 0x801104, 0x50

# Вызовы, которые ждут событий MAC или передачу в эфир: в юнит-тесте не исполняются.
WAITS = {'uc_spin_until_event': 0, 'uc_wait_one_event': 0, 'mac_mode_send_direct_frame': 0,
         'mac_set_rf_chain_state': 0, 'mac_evt_enable_bit_sync_b': 0, 'rfca_select_rf_uc': 0}


def bits(v, lo, n):
    return (v >> lo) & ((1 << n) - 1)


def brp_request(b):
    """Рис. 9-850."""
    v = int.from_bytes(b, 'little')
    return dict(l_rx=bits(v, 0, 5), tx_trn_req=bits(v, 5, 1), mid_req=bits(v, 6, 1), bc_req=bits(v, 7, 1),
                mid_grant=bits(v, 8, 1), bc_grant=bits(v, 9, 1), chan_fbck_cap=bits(v, 10, 1),
                tx_sector_id=bits(v, 11, 6), other_aid=bits(v, 17, 8), tx_antenna_id=bits(v, 25, 2))


def dmg_br(b):
    """Рис. 9-558 (биты от начала элемента: ID B0..7, Length B8..15)."""
    v = int.from_bytes(b, 'little')
    return dict(eid=bits(v, 0, 8), length=bits(v, 8, 8), initiator=bits(v, 16, 1), tx_train_response=bits(v, 17, 1),
                rx_train_response=bits(v, 18, 1), tx_trn_ok=bits(v, 19, 1), txss_fbck_req=bits(v, 20, 1),
                bs_fbck=bits(v, 21, 6), fbck_req=bits(v, 29, 5), fbck_type=bits(v, 34, 18),
                mid_extension=bits(v, 52, 1), capability_request=bits(v, 53, 1))


def run(uc, sta=0, tx_sector=0x21, own_rx_training=True, peer_l_rx=0):
    """Инициатор BRP для станции sta: own_rx_training — init_flags б0 (своя приёмная тренировка не закончена),
    peer_l_rx — L-RX из запроса пира (init_peer_req б2 и б4..8, brp_init_reset_ctx)."""
    uc.w8(INIT_STA, sta)
    uc.w32(INIT_FLAGS, 1 if own_rx_training else 0)
    uc.w32(INIT_PEER_REQ, ((1 << 2) | (peer_l_rx << 4)) if peer_l_rx else 0)
    e = STA_TAB + STA_SZ * sta
    uc.w32(e + 0x08, tx_sector << 8)
    for i, w in enumerate((0x1824, 0x241d, 0x0b3b)):
        uc.w16(e + 0x30 + 2 * i, w)
    uc.call('brp_init_tx_request', stub=WAITS)
    return brp_request(uc.rbytes(BRP_REQ, 4)), dmg_br(uc.rbytes(BR_ELEM, 7))


def test_initiator_field_and_length(uc):
    _, e = run(uc)
    assert e['length'] == 5                      # 9.4.2.129: поля элемента — 40 бит
    assert e['initiator'] == 1


def test_tx_sector_id_is_current_tx_sector(uc):
    r, _ = run(uc, tx_sector=0x2a)
    assert r['tx_sector_id'] == 0x2a


@pytest.mark.parametrize('own', [True, False])
def test_l_rx_requests_rx_training_only_while_needed(uc, own):
    """10.42.6.4.2: L-RX > 0 — запрос приёмной тренировки; L-RX — число TRN-units (×4 TRN-R), 0..16 (9.5.4)."""
    r, _ = run(uc, own_rx_training=own)
    assert r['l_rx'] == (16 if own else 0)
    assert r['l_rx'] <= 16


@pytest.mark.parametrize('peer_l_rx', [0, 1, 16])
def test_rx_train_response_when_peer_requested(uc, peer_l_rx):
    """9.4.2.129 RX-train-response = 1 — кадр отвечает на запрос приёмной тренировки пира (и несёт TRN-R)."""
    _, e = run(uc, peer_l_rx=peer_l_rx)
    assert e['rx_train_response'] == (1 if peer_l_rx else 0)


@pytest.mark.parametrize('peer_l_rx', [1, 8, 16])
def test_trn_r_length_command_matches_peer_l_rx(uc, peer_l_rx):
    """Ответ на запрос пира: к PPDU добавляется 4·L-RX TRN-R (9.5.4) — команда MAC с длиной TRN (биты 4..8 = L-RX)."""
    run(uc, peer_l_rx=peer_l_rx)
    trn = [c for c in uc.mac_cmds if (c >> 24) == 0x20 and c & (1 << 10)]
    assert trn, 'нет команды длины TRN-R: %s' % [hex(c) for c in uc.mac_cmds]
    assert bits(trn[-1], 4, 5) == peer_l_rx


def test_no_trn_r_without_peer_request(uc):
    run(uc, peer_l_rx=0)
    assert not [c for c in uc.mac_cmds if (c >> 24) == 0x20 and bits(c, 4, 5)]


def test_unused_fields_zero(uc):
    """Инициатор без MID/BC: MID-REQ, BC-REQ, гранты, TX-TRN-REQ, FBCK-REQ = 0 (10.42.6.4)."""
    r, e = run(uc, peer_l_rx=16)
    assert (r['tx_trn_req'], r['mid_req'], r['bc_req'], r['mid_grant'], r['bc_grant']) == (0, 0, 0, 0, 0)
    assert (e['tx_train_response'], e['txss_fbck_req'], e['fbck_req']) == (0, 0, 0)
