# SPDX-License-Identifier: AGPL-3.0-or-later
"""Кадры из эфира, которые узел не ждёт: fw отбрасывает их и освобождает буфер приёма и запись разбора — без утечек и
фатальных ассертов (удалённое падение / глухота от любого передатчика рядом). Аудит границ 2026-11-21."""
import struct

import fwflows as F

RX_POOL_USED = 0xc                        # struct mem_pool: used


def _rx_used(fw):
    return fw.r32(fw.a('rx_ring') + 0x1c + RX_POOL_USED)


def _rx(fw, f, stype, body, cid=0):
    own = f.own_mac()
    fw.call('rx_pkt_handler', fw.rx_pkt(fw.mgmt_frame(stype, own, F.STA_MAC, own, body), cid=cid))
    fw.run_tasks()
    F.settle(fw)


def test_ap_drops_assoc_response(fw):
    """AP/PCP: Association Response станции (11.3.5 — ответ на ассоциацию получает только станция). vendor отдавал
    его автомату MLME, который у точки пакет не хранит и не освобождает: после пяти — фатальный ассерт 0x10a2
    на следующем кадре управления."""
    f = F.Fw(fw)
    f.ap_start(secure=True)                       # с RSN автомат MLME станции держит ASSOCIATE (busy) до ключей
    f.ap_sta_join()
    used = _rx_used(fw)
    for status in (1, 0, 1, 0, 1, 0, 1, 0):
        _rx(fw, f, 1, struct.pack('<HHH', 0x10, status, 0xc001))       # Capability, Status Code, AID
    assert _rx_used(fw) == used
    _rx(fw, f, 0, struct.pack('<HH', 0x10, 1))                         # следующий кадр управления разбирается
