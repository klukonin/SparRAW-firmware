# SPDX-License-Identifier: AGPL-3.0-or-later
"""Ответчик RD теряет CF-End держателя и следующие RTS (стенд 2026-11-04, PMC обоих узлов: CF-End держателя без
ответа в 2679 из 3335 TXOP станции с данными точки в RD и 1370 из 2729 у точки, без RD — ни одного; RTS держателя через
150–250 мкс после пропущенного CF-End — без DMG CTS). Цепочка (эмулятор, test_air test_live_rd_*):
1) BlockAck держателя на данные RD ответчик разбирает дольше SIFS; CF-End держателя через SIFS уже идёт, когда
   rx_flow_main (0x2080002) и sxd_hal_wait_slot2_busy (0x2080000) сбрасывают busy_event — событие начала кадра стёрто;
2) счётчик PPDU uc (ppdu_evt_cnt) отстаёт от PHY: следующий PPDU (RTS держателя) входит в rx_flow_run по busy_event до
   разбора заголовка, ветка 0xeeee04 его отбрасывает, и его конец снова уводит счётчик.

Здесь — по функции: счётчик стенда mac_mon_report.rx_busy_race (+0x3e) — после сброса busy_event идёт приём PPDU,
начавшегося до сброса; накопительный: публикация MAC_MON (peer_slots_scan_by_masks) его не сбрасывает. Отставание
счётчика PPDU на стенде видно по rx_flow_noevt_cnt (0x800574, ветка 0xeeee04, был и прежде)."""

MAC_MON = 0x801084
RX_BUSY_RACE = MAC_MON + 0x3e
MAC_MON_ARMED = 0x800500

EVT_SLOT2, EVT_BUSY = 1 << 8, 1 << 19
PHYSIG_CCA_PPDU_COMP = 1 << 24


def physig(cca_cnt, ppdu_cnt, cca=0, rx_frame=0):
    """PHY_SIGNALS (r40 сел. 0xa): cca [2:0], phy_rx_frame б3, концы PPDU [13:8], начала CCA [21:16]; cca_ppdu_comp
    (б24) до разбора заголовка ещё стоит (H-PHYRX, стенд STAMP_CCA_DET) — здесь по cca/phy_rx_frame."""
    return (cca & 7) | (rx_frame << 3) | (ppdu_cnt & 0x3f) << 8 | (cca_cnt & 0x3f) << 16 | \
        (0 if rx_frame else PHYSIG_CCA_PPDU_COMP)


def test_busy_race_counted(uc):
    """Кадр начался до сброса busy_event (0x2080000): события нет (r42 б19 = 0), но PHY принимает — начало CCA
    посчитано, конца PPDU нет. Возврат 1 (занято), rx_busy_race + 1."""
    uc.ext[40] = physig(cca_cnt=5, ppdu_cnt=4, cca=2)
    uc.ext[42] = EVT_SLOT2
    n0 = uc.r16(RX_BUSY_RACE)
    assert uc.call('sxd_hal_wait_slot2_busy', 2) == 1          # «занято» сразу, без ожидания slot2: rx_flow_run разберёт
    assert 0x2080000 in uc.mac_cmds
    assert uc.r16(RX_BUSY_RACE) == (n0 + 1) & 0xffff


def test_busy_race_not_counted(uc):
    """Нет начатого PPDU (счётчики равны) или разница счётчиков без занятого PHY (ложный CCA без конца PPDU) —
    rx_busy_race не меняется; обычное ожидание n слотов slot2 (здесь slot2 сразу) → 0."""
    for sig in (physig(4, 4), physig(4, 4, cca=2), physig(5, 4)):
        uc.ext[40] = sig
        uc.ext[42] = EVT_SLOT2
        n0 = uc.r16(RX_BUSY_RACE)
        assert uc.call('sxd_hal_wait_slot2_busy', 2) == 0
        assert uc.r16(RX_BUSY_RACE) == n0


def test_busy_event_still_works(uc):
    """busy_event после сброса (кадр начался в ожидании) — 1, как прежде."""
    uc.ext[40] = physig(4, 4)
    uc.ext[42] = EVT_BUSY
    assert uc.call('sxd_hal_wait_slot2_busy', 2) == 1


def test_counters_survive_publish(uc):
    """Публикация MAC_MON раз в BI (peer_slots_scan_by_masks: копия в mac_mon_pub, отчёт обнуляется) — счётчик стенда
    остаётся (накопительный) и попадает в опубликованную копию."""
    uc.w16(RX_BUSY_RACE, 0x1234)
    uc.w32(MAC_MON + 0x5a, 0x77)                             # tx_rts — обычный счётчик за BI: сбрасывается
    uc.w32(MAC_MON_ARMED, 1)
    uc.call('peer_slots_scan_by_masks', 0, stub={'uc_send_evt_mac_monitor': 0, 'uc_read_tsf_lo': 0})
    assert uc.r16(RX_BUSY_RACE) == 0x1234
    assert uc.r16(MAC_MON + 0x5a) == 0
    pub = 0x853940
    assert uc.r16(pub + 0x3e) == 0x1234


# ---- RD отключён намеренно: держатель RDG не даёт (MAC-STAND «Ответчик RD глохнет») --------------------------------

TXRX_STATE1 = 0x8005f4
MTP_RESP_VALID, MTP_RESP_RD_SUPP = 1 << 31, 1 << 26
GO18_RDG = 1 << 11                                         # б11 пуска 0x18 — RDG/More PPDU (vendor: = RD_SUPP r43)
SCRATCH = 0x807f00                                         # mtp_resp_info для txop_await_cts_ppdu (нули)


def _go18(cmds):
    return [c for c in cmds if c >> 24 == 0x18 and c & (1 << 27)]


def test_txop_open_no_rdg(uc):
    """Первый PPDU TXOP (txop_await_cts_ppdu): MTP сообщает RD_SUPP — пуск 0x18 без б11 (RDG не даём; 802.11-2020
    10.29.3 — RDG по усмотрению держателя). vendor: б11 = RD_SUPP."""
    uc.ext[43] = MTP_RESP_VALID | MTP_RESP_RD_SUPP
    uc.ext[40] = PHYSIG_CCA_PPDU_COMP                       # mac_cca_ok: среда свободна
    uc.ext[42] = 0
    assert uc.call('txop_await_cts_ppdu', 0, SCRATCH, stub={'mac_select_all_sectors_and_wait': 0,
                                                              'mac_program_tx_vector': 0}) == 1
    go = _go18(uc.mac_cmds)
    assert go and not [hex(c) for c in go if c & GO18_RDG], [hex(c) for c in go]


def test_txop_continue_no_rdg(uc):
    """Следующий PPDU TXOP (mtp_get_tx_permission, хвост при txrx_state1 б1): RD_SUPP в r43 — пуск без б11."""
    uc.w32(TXRX_STATE1, 2)
    uc.ext[43] = MTP_RESP_VALID | MTP_RESP_RD_SUPP
    uc.ext[45] = (1 << 31) | 0xff                          # разрешение, ack_mask совпал — без ветки ответа
    ctx = 0x802978
    uc.w32(ctx + 0xc, 0)
    uc.call('mtp_get_tx_permission', ctx, 0, stub={'tx_crypto_ctl_arm': 0, 'mtp_service_dispatch': 0,
                                                   'tx_send_and_await_rx_frame': 0})
    go = _go18(uc.mac_cmds)
    assert go and not [hex(c) for c in go if c & GO18_RDG], [hex(c) for c in go]
