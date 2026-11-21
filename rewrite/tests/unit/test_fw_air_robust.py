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


def _dispatch(fw, frame):
    fw.call('rx_pkt_srvs_dispatch', fw.a('rx_pkt_srvs'), fw.rx_pkt(frame))
    fw.run_tasks()
    F.settle(fw)


def test_unhandled_mgmt_subtypes_freed(fw):
    """Подтипы управления, которые fw не разбирает (Beacon 8, ATIM 9, Authentication 11, Deauthentication 12,
    Timing Advertisement 6, резерв 7, 15): буфер приёма освобождается. vendor только писал журнал — пул приёма (12)
    кончался, кольцо кадров управления вставало до перезагрузки."""
    f = F.Fw(fw)
    f.ap_start()
    own = f.own_mac()
    used = _rx_used(fw)
    for stype in (6, 7, 8, 9, 11, 12, 15) * 3:
        _dispatch(fw, fw.mgmt_frame(stype, own, F.STA_MAC, own, bytes(8)))
    assert _rx_used(fw) == used


def test_extension_subtypes_other_than_dmg_beacon_freed(fw):
    """Кадр Extension (тип 3) подтипа ≠ 0 (не DMG Beacon; 9.2.4.1.3 — резерв): буфер освобождается."""
    f = F.Fw(fw)
    f.ap_start()
    used = _rx_used(fw)
    for stype in range(1, 16):
        fc = (3 << 2) | (stype << 4)
        _dispatch(fw, struct.pack('<HH', fc, 0) + bytes(F.STA_MAC) * 3 + bytes(10))
    assert _rx_used(fw) == used


WMI_P2P_CFG, WMI_DISCOVERY_START = 0x910, 0x916


def test_p2p_search_probe_req_from_unknown_peer(fw):
    """P2P поиск (find_sm STATE_SEARCHING): Probe Request с адреса, для которого нет соединения (cid не наш), —
    vendor: фатальный ассерт 0x1447/0x1448 (соединение искалось по cid дескриптора). Теперь — журнал и отброс."""
    f = F.Fw(fw)
    fw.wmi(WMI_P2P_CFG, struct.pack('<BBH', 1, 2, 100))
    F.settle(fw)
    fw.wmi(WMI_DISCOVERY_START, b'')
    F.settle(fw)
    fw.advance(20_000, between=F.settle)
    used = _rx_used(fw)
    bc = b'\xff' * 6
    for _ in range(3):
        fw.call('rx_pkt_srvs_dispatch', fw.a('rx_pkt_srvs'),
                fw.rx_pkt(fw.mgmt_frame(4, bc, F.STA_MAC, bc, bytes([0, 0])), cid=F.SPARRAW_PEER_UNKNOWN))
        fw.run_tasks()
        F.settle(fw)
    assert _rx_used(fw) == used
