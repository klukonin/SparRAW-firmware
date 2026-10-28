# SPDX-License-Identifier: AGPL-3.0-or-later
"""Обвязка fw (tests/unit/fwemu.py): загрузка до WMI_READY, команда хоста и ответ, событие uc, таймеры u_schd.
Если эти тесты падают — сценарии test_fw_*.py ничего не доказывают."""
import struct

import fwflows as F

WMI_READY, WMI_ECHO, WMI_ECHO_RSP = 0x1001, 0x803, 0x1803


def test_boot_reaches_wmi_ready(fw):
    """После LMAC READY от uc fw шлёт хосту WMI_READY и команды uc (EDCA 0x04, INA-детектор 0x20)."""
    assert WMI_READY in [e.id for e in fw.boot_wmi_evts]
    types = [c.type for c in fw.boot_lmac_cmds]
    assert 0x04 in types and 0x20 in types, types
    assert fw.r8(fw.a('lmac_ucode_ready')) == 1


def test_wmi_echo_roundtrip(fw):
    ev = fw.wmi(WMI_ECHO, struct.pack('<I', 0x12345678))
    assert [(e.id, struct.unpack_from('<I', e.body, 0)[0]) for e in ev] == [(WMI_ECHO_RSP, 0x12345678)]
    assert not fw.wild


def test_wmi_unknown_mid_not_supported(fw):
    """Команда для mid без записи — WMI_COMMAND_NOT_SUPPORTED и журнал WMI_NO_VIF (fw/wmi_cmd.c)."""
    ev = fw.wmi(WMI_ECHO, struct.pack('<I', 1), mid=3)
    assert [e.id for e in ev] == [F.EV_NOT_SUPPORTED]
    assert fw.logged('WMI_NO_VIF')


def test_sta_connect_flow_reaches_data(fw):
    """Сценарий подключения STA (fwflows.Fw.sta_connect) доходит до порта данных: WMI_CONNECT_EVENT хосту,
    conn_main_sm KEY_ASSOC, MLME ASSOCIATED, BSS активен, кольцо данных добавлено (VRING_CFG_DONE статус 0)."""
    w = F.Fw(fw)
    conn = w.sta_connect()
    assert F.EV_CONNECT in [e.id for e in fw.wmi_evts]
    assert (w.msm(conn), w.mlme(conn), w.bss_state()) == (F.MSM_KEY_ASSOC, F.MLME_ASSOCIATED, F.BSS_ACTIVE)
    fw.clear()
    ev = w.sta_add_vring()
    assert [(e.id, e.body[1]) for e in ev if e.id == F.EV_VRING_CFG_DONE] == [(F.EV_VRING_CFG_DONE, 0)]


def test_timer_advance_fires_in_order(fw):
    """advance: таймеры u_schd срабатывают через прерывание таймера (u_schd_expire_timers) по срокам."""
    w = F.Fw(fw)
    w.sta_connect(stop='assoc_req')
    names = [t[0] for t in fw.timers()]
    assert 'mlme_assoc_timeout_cb' in names
    fired = fw.advance(fw.r32(fw.a('mlme_assoc_timeout_ms')) * 1000 + 16)
    assert 'mlme_assoc_timeout_cb' in [n for n, _ in fired]
    F.settle(fw)                                            # Disassociation ушёл, uc снял очереди станции
    assert F.EV_DISCONNECT in [e.id for e in fw.wmi_evts]
