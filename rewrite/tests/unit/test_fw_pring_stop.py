# SPDX-License-Identifier: AGPL-3.0-or-later
"""Остановка pring при разрыве, когда очередь MAC не опустошается (стенд 2026-11-03, поток станции → AP встал, через
5 с потеря связи по старению TX): «PRING: TIMEOUT HANDLER: DMA is not Empty» × 5 и фатальный assert 0x12aa
(fw/vring.c sm_pring_timeout) — дескриптор очереди MAC пуст, указатели DMA очереди (dma_is_idle) не сходятся: кадры,
перенесённые DMA, MAC не отправил (основной поток uc висел). Ассерт сбрасывал всё устройство.

Модель: fwflows.host_tx_pending (данные хоста в кольце, vring привязан к pring), dma_is_idle — заглушка 0 (DMA
очереди «не пуст» всё время), tx_macq_is_empty — 1 (как у fwflows). Срок — (vring_pring_stop_max_polls + 1) ×
pring_stop_timeout из fw.elf."""
import struct

import fwemu
import fwflows as F

CID = 0
WMI_ECHO, WMI_ECHO_RSP = 0x803, 0x1803
IGNORE = ('tx_api_mgmt.state', 'tx_api_2.state', 'tx_api_data.state', 'll_ctx.ka_cnt[cid]')


def _stop_bound_us(fw):
    return (fw.r8(fw.a('vring_pring_stop_max_polls')) + 2) * fw.r32(fw.a('pring_stop_timeout'))


def _sta_with_data(fw_elf):
    fw = fwemu.FW(fw_elf).boot()
    F.run_tsf(fw)
    F.track_event_times(fw)
    w = F.Fw(fw)
    boot = F.idle_state(fw)
    uc0 = F.uc_station(fw.boot_lmac_cmds, CID)
    w.sta_connect()
    w.sta_add_vring()
    F.host_tx_pending(fw, 0)
    fw.default_stubs['dma_is_idle'] = 0                  # DMA очереди не сходится до конца теста
    return w, boot, uc0


def test_sta_disconnect_dma_stuck_no_fatal(fw_elf):
    """Хост разрывает соединение (WMI_DISCONNECT), DMA очереди «не пуст» всё время: остановка vring по команде
    (suspend_vring, enabled = 0) после (max_polls + 1) проверок завершается принудительно — без assert 0x12aa,
    журнал PRING_STOP_FORCED; хост получает WMI_DISCONNECT_EVENT, состояние — «после загрузки», uc о станции ничего
    не держит, WMI_ECHO отвечает. Прежде — FwAssert 0x12aa."""
    w, boot, uc0 = _sta_with_data(fw_elf)
    fw = w.fw
    n0 = len(fw.wmi_evts)
    fw.wmi(F.WMI_DISCONNECT)
    F.settle(fw)
    fw.advance(_stop_bound_us(fw) + F.BI_US, between=F.settle)
    assert [e for e in fw.wmi_evts[n0:] if e.id == F.EV_DISCONNECT], [hex(e.id) for e in fw.wmi_evts[n0:]]
    assert fw.logged('PRING_STOP_FORCED'), 'остановка pring не принудительная — DMA в модели не застрял?'
    fw.advance(1_000_000, between=F.settle)
    diff = F.state_diff(boot, F.idle_state(fw), IGNORE)
    assert not diff, diff
    assert F.uc_station(list(fw.boot_lmac_cmds) + list(fw.lmac_cmds), CID) == uc0
    ev = fw.wmi(WMI_ECHO, struct.pack('<I', 0x5a5a1234))
    assert [(e.id, struct.unpack_from('<I', e.body, 0)[0]) for e in ev] == [(WMI_ECHO_RSP, 0x5a5a1234)]


def test_sta_reconnect_after_forced_pring_stop(fw_elf):
    """После принудительной остановки — следующее подключение и привязка того же кольца к pring проходят (окно MACQ
    и указатели TXQ сбрасывает привязка, sm_pring_bind_vring)."""
    w, boot, uc0 = _sta_with_data(fw_elf)
    fw = w.fw
    fw.wmi(F.WMI_DISCONNECT)
    F.settle(fw)
    fw.advance(_stop_bound_us(fw) + F.BI_US, between=F.settle)
    fw.default_stubs['dma_is_idle'] = 1
    fw._uc_seen = len(fw.lmac_cmds)
    n0 = len(fw.wmi_evts)
    w.sta_connect()
    w.sta_add_vring()
    F.host_tx_pending(fw, 0)
    assert [e for e in fw.wmi_evts[n0:] if e.id == F.EV_CONNECT]
