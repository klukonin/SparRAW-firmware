# SPDX-License-Identifier: AGPL-3.0-or-later
"""Настройка ответчика A-BFT uc (LMAC 0x23, include/lmac_cmd.h struct lmac_cmd_bi_tbl: responder_mode, beacon_type;
uc/dccm.h abft_resp_cfg) по фазам fw против 802.11-2020 10.42.5: вне поиска (discovery) станция может отвечать в A-BFT
любого маяка — с Discovery Mode = 0 и = 1 (10.42.5.1 «Allocation of A-BFT», 10.42.5.2)."""
import struct

import pytest

import fwflows as F

WMI_P2P_CFG, WMI_START_LISTEN, WMI_START_SEARCH = 0x910, 0x914, 0x915
WMI_DISCOVERY_START, WMI_DISCOVERY_STOP = 0x916, 0x917
BEACON_TYPE_ALL = 2                     # uc/dccm.h: 0 — только не Discovery, 1 — только Discovery, ≥ 2 — любые маяки


def abft_cfgs(cmds):
    """[(responder_mode, beacon_type)] команд LMAC 0x23 по порядку."""
    return [struct.unpack_from('<II', c.body) for c in cmds if c.type == 0x23]


def step(fw, cmd, body=b''):
    fw.wmi(cmd, body)
    F.settle(fw)


def search(fw):
    step(fw, WMI_P2P_CFG, struct.pack('<BBH', 1, 1, 100))
    step(fw, WMI_DISCOVERY_START)
    step(fw, WMI_START_SEARCH)


@pytest.mark.parametrize('end', ['listen', 'stop'])
def test_abft_cfg_restored_after_search(fw, end):
    """Поиск (START_SEARCH) ставит свою настройку A-BFT; его конец — START_LISTEN или DISCOVERY_STOP — возвращает
    настройку загрузки: снова ответ в A-BFT маяков любого типа (beacon_type ≥ 2)."""
    boot = abft_cfgs(fw.boot_lmac_cmds)[-1]
    assert boot[1] >= BEACON_TYPE_ALL
    fw.clear()
    search(fw)
    assert abft_cfgs(fw.lmac_cmds), 'поиск не настроил A-BFT'
    if end == 'listen':
        step(fw, WMI_START_LISTEN)
    step(fw, WMI_DISCOVERY_STOP)
    assert abft_cfgs(fw.lmac_cmds)[-1] == boot
