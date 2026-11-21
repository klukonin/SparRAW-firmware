# SPDX-License-Identifier: AGPL-3.0-or-later
"""Значения команд хоста вне допустимых: fw отказывает (журнал WMI_BAD_PARAM «wmi cmd 0x%x: invalid value %u at
+0x%x» / событие со статусом отказа) и не падает фатальным ассертом, не пишет за массивами, не передаёт значение
дальше в uc. Стендовые случаи — tests/test_sta_robust.py; здесь те же без стенда и новые: cid ≥ SPARRAW_MAX_STA,
номер кольца вне STREAM_VR_N, tid, канал, длины.

Проверка каждой команды (send): нет FwAssert/SmError, нет обращений вне карты памяти (fw.wild), состояние покоя
соединений (fwflows.idle_state) не изменилось, кроме ожидаемого.
"""
import struct

import pytest

import fwemu
import fwflows as F
from fwflows import SPARRAW_MAX_STA, SPARRAW_STA_SLOTS

STREAM_VR_N = 10                       # include/stream.h: число vring (не число станций)
BL_READY = 0x880a3c                    # include/hw.h: 1 — ASIC (platform_is_asic)
Z = bytes(32)

WMI_SET_APPIE, WMI_SET_SSID = 0x3f, 0x827
WMI_RCP_ADDBA_RESP, WMI_RCP_DELBA = 0x825, 0x826
WMI_SET_PCP_CHANNEL, WMI_BF_TRIG, WMI_SET_SECTORS = 0x829, 0x83a, 0x849
WMI_LINK_MAINTAIN_CFG_WRITE, WMI_LINK_MAINTAIN_CFG_READ = 0x842, 0x843
WMI_RF_MGMT, WMI_SET_ACTIVE_SILENT_RSSI_TABLE = 0x853, 0x85c
WMI_UNIT_TEST, WMI_P2P_CFG, WMI_DISCOVERY_START = 0x900, 0x910, 0x916
WMI_GET_DETAILED_RS_RES, WMI_BRP_SET_ANT_LIMIT = 0x922, 0x924
WMI_CFG_RX_CHAIN = 0x820


def send(fw, cmd, body, mid=0):
    """Команда хоста + покой (ответы uc, кадры TX). Возврат — события хосту этого шага."""
    before = F.idle_state(fw)
    fw.clear()
    fw._uc_seen = 0
    evts = fw.wmi(cmd, body, mid=mid)
    F.settle(fw)
    evts = list(fw.wmi_evts)
    assert not fw.wild, 'обращения вне карты памяти: %s' % fw.wild[:4]
    send.diff = F.state_diff(before, F.idle_state(fw))
    return evts


def rejected(fw, cmd, val):
    """Отказ записан: wmi_reject_param(cmd, val, …) и строка журнала WMI_BAD_PARAM с теми же значениями."""
    return any(r[0] == cmd and r[1] == val for r in fw.rejects) and \
        any(l[2] == cmd and l[3] == val for l in fw.logged('WMI_BAD_PARAM'))


@pytest.fixture
def conn_fw(fw):
    """fw с подключённой STA (cid 0) и кольцом данных 0 — команды с cid/кольцом бьют по живым объектам."""
    w = F.Fw(fw)
    w.sta_connect()
    w.sta_add_vring()
    fw.clear()
    return fw


# ---- стендовые случаи (tests/test_sta_robust.py) ----

@pytest.mark.parametrize('cmd,body,val', [
    (F.WMI_VRING_BA_DIS, b'\x0c\0\0\0' + Z, 0xc),                   # ringid 12
    (WMI_SET_PCP_CHANNEL, b'\x07\0\0\0' + Z, 7),                     # канал 7 (WMI — с 0, допустимо 0..3)
    (WMI_BF_TRIG, b'\x05\0\0\0' + bytes(12) + Z, 5),                # тип BF 5
    (WMI_RF_MGMT, b'\x09\0\0\0' + Z, 9),                             # тип 9
], ids=['ba_dis_ring12', 'pcp_channel7', 'bf_trig5', 'rf_mgmt9'])
def test_stand_bad_values_rejected(conn_fw, cmd, body, val):
    send(conn_fw, cmd, body)
    assert rejected(conn_fw, cmd, val)
    assert send.diff == []


def test_ba_dis_without_stream_logged(fw):
    send(fw, F.WMI_VRING_BA_DIS, b'\x05\0\0\0' + Z)
    assert fw.logged('BA_DIS_NO_STREAM')


def test_silent_rssi_table0_does_not_crash(fw):
    """WMI_SET_ACTIVE_SILENT_RSSI_TABLE(0): у vendor — фатальный ассерт 0x1588."""
    send(fw, WMI_SET_ACTIVE_SILENT_RSSI_TABLE, b'\0\0\0\0' + Z)


def test_ut_calib_bad_engine(fw):
    """UT calib_mgr_ut с индексом движка 9 (движков 6) — отказ, не чтение за массивом. Движки калибровки работают только
    на ASIC (platform_is_asic: BL_READY = 1) — на время команды."""
    fw.mmio[BL_READY] = 1
    send(fw, WMI_UNIT_TEST, struct.pack('<HHI', 7, 1, 9) + bytes(28))
    fw.mmio[BL_READY] = 0
    assert fw.logged('CALIB_UT_BAD_ENGINE')


# ---- кольца: номер ≥ STREAM_VR_N, tid, действие ----

def _vring_done(evts):
    return [(e.body[0], e.body[1]) for e in evts if e.id == F.EV_VRING_CFG_DONE]


@pytest.mark.parametrize('ringid', [STREAM_VR_N, 0xff])
def test_vring_cfg_ringid_out_of_range(conn_fw, ringid):
    evts = send(conn_fw, F.WMI_VRING_CFG, F.vring_cfg_cmd(ringid, 0))
    assert rejected(conn_fw, F.WMI_VRING_CFG, ringid)
    assert _vring_done(evts) == [(ringid, 1)]
    assert send.diff == []


@pytest.mark.parametrize('tid', [7, 0xf])
def test_vring_cfg_tid_out_of_range(conn_fw, tid):
    evts = send(conn_fw, F.WMI_VRING_CFG, F.vring_cfg_cmd(1, 0, tid=tid))
    assert rejected(conn_fw, F.WMI_VRING_CFG, tid << 4)
    assert _vring_done(evts) == [(1, 1)]
    assert send.diff == []


@pytest.mark.parametrize('cid', [SPARRAW_MAX_STA, SPARRAW_STA_SLOTS, 0xf])
def test_vring_cfg_cid_without_station(conn_fw, cid):
    """cid ≥ SPARRAW_MAX_STA (поле cidxtid — 4 бита): соединения нет — VRING_CFG_DONE со статусом 1, стрим не заведён,
    uc команды очереди (LMAC 0x08) не получает."""
    evts = send(conn_fw, F.WMI_VRING_CFG, F.vring_cfg_cmd(1, cid))
    assert _vring_done(evts) == [(1, 1)]
    assert not [c for c in conn_fw.lmac_cmds if c.type == 0x08]
    assert send.diff == []


@pytest.mark.parametrize('action', [1, 3])
def test_vring_cfg_bad_action(conn_fw, action):
    evts = send(conn_fw, F.WMI_VRING_CFG, F.vring_cfg_cmd(1, 0, action=action))
    assert rejected(conn_fw, F.WMI_VRING_CFG, action)
    assert _vring_done(evts) == [(1, 1)]


@pytest.mark.parametrize('ringid', [STREAM_VR_N, 0xff])
def test_vring_ba_en_ringid_out_of_range(conn_fw, ringid):
    send(conn_fw, F.WMI_VRING_BA_EN, struct.pack('<BBHB3x', ringid, 32, 0, 0))
    assert rejected(conn_fw, F.WMI_VRING_BA_EN, ringid)
    assert send.diff == []


@pytest.mark.parametrize('ringid', [STREAM_VR_N, 0xff])
def test_bcast_vring_cfg_ringid_out_of_range(fw, ringid):
    b = bytearray(0x14)
    b[4 + 0xc] = ringid
    evts = send(fw, F.WMI_BCAST_VRING_CFG, bytes(b))
    assert rejected(fw, F.WMI_BCAST_VRING_CFG, ringid)
    assert _vring_done(evts) == [(ringid, 1)]


# ---- cid ≥ SPARRAW_MAX_STA в командах станции ----

@pytest.mark.parametrize('cid', [SPARRAW_MAX_STA, 0xf])
def test_rcp_addba_resp_cid_without_station(conn_fw, cid):
    """ADDBA Response получателя для cid без соединения: событие 0x1825 со статусом 1, кадр не уходит, кадр
    TX-пула возвращён."""
    evts = send(conn_fw, WMI_RCP_ADDBA_RESP, struct.pack('<BBHHH', cid, 1, 0, 32 << 6, 0))
    assert [struct.unpack_from('<H', e.body, 2)[0] for e in evts if e.id == 0x1825] == [1]   # status
    assert not conn_fw.tx_frames
    assert send.diff == []


@pytest.mark.parametrize('cid', [SPARRAW_MAX_STA, 0xf])
def test_rcp_delba_cid_without_station(conn_fw, cid):
    send(conn_fw, WMI_RCP_DELBA, struct.pack('<BBH', cid, 0, 1))
    assert conn_fw.logged('RCP_DELBA_NO_CONN')
    assert not conn_fw.tx_frames
    assert send.diff == []


@pytest.mark.parametrize('cid', [SPARRAW_MAX_STA, 0xff])
def test_brp_set_ant_limit_cid_out_of_range(conn_fw, cid):
    evts = send(conn_fw, WMI_BRP_SET_ANT_LIMIT, struct.pack('<BBBB', cid, 0, 0, 0))
    assert [e.body[0] for e in evts if e.id == 0x1924] == [1]
    assert not [c for c in conn_fw.lmac_cmds if c.type == 0x32]


@pytest.mark.parametrize('cid', [SPARRAW_MAX_STA, 0xfffffffe])
def test_link_maintain_cfg_cid_out_of_range(conn_fw, cid):
    ll = conn_fw.a('ll_ctx')
    cfg_before = conn_fw.rbytes(ll, 0x24 * SPARRAW_MAX_STA)
    evts = send(conn_fw, WMI_LINK_MAINTAIN_CFG_WRITE, struct.pack('<II', 4, cid) + bytes(0x24))
    assert [struct.unpack_from('<I', e.body, 4)[0] for e in evts if e.id == 0x1842] == [1]
    assert conn_fw.rbytes(ll, 0x24 * SPARRAW_MAX_STA) == cfg_before
    evts = send(conn_fw, WMI_LINK_MAINTAIN_CFG_READ, struct.pack('<I', cid))
    assert [struct.unpack_from('<I', e.body, 4)[0] for e in evts if e.id == 0x1843] == [1]   # status


@pytest.mark.parametrize('period', [0, 0x10, 0x80000000])
def test_link_maintain_cfg_short_period_no_recursion(conn_fw, period):
    """WMI_LINK_MAINTAIN_CFG_WRITE с периодом меньше минимальной задержки u_schd (0x11) или со знаковым переполнением:
    vendor periodic_service_tick запускал прогон сразу, прогон — снова tick: рекурсия без конца, стек — по DCCM.
    Теперь прогон ставится в планировщик не раньше минимальной задержки."""
    cfg = struct.pack('<IIIIIiiIi', 3, period, 1000, 1000, 1000, 0, 0, 10, 0)    # детекторы старения и keep-alive
    send(conn_fw, WMI_LINK_MAINTAIN_CFG_WRITE, struct.pack('<II', 4, 0xffffffff) + cfg)
    conn_fw.advance(2000, between=F.settle)


@pytest.mark.parametrize('cid', [SPARRAW_MAX_STA, 0xff])
def test_bf_trig_by_cid_out_of_range(conn_fw, cid):
    send(conn_fw, WMI_BF_TRIG, struct.pack('<II', 1, cid) + bytes(16))
    assert not [c for c in conn_fw.lmac_cmds if c.type == 0x09]


@pytest.mark.parametrize('cid', [SPARRAW_MAX_STA, 0xff])
def test_get_detailed_rs_res_cid_out_of_range(conn_fw, cid):
    evts = send(conn_fw, WMI_GET_DETAILED_RS_RES, struct.pack('<B3x', cid))
    assert [(e.body[0], e.body[1]) for e in evts if e.id == 0x1922] == [(cid, 1)]


@pytest.mark.parametrize('cid', [SPARRAW_STA_SLOTS, 0xff])
def test_set_sectors_cid_out_of_range(conn_fw, cid):
    send(conn_fw, WMI_SET_SECTORS, struct.pack('<III', cid, 0x15, 0x25))
    assert not [c for c in conn_fw.lmac_cmds if c.type == 0x05 and c.body[0xc] >= SPARRAW_MAX_STA]
    assert rejected(conn_fw, WMI_SET_SECTORS, cid)


# ---- длины ----

def test_set_appie_too_long_rejected(fw):
    send(fw, WMI_SET_APPIE, struct.pack('<BBH', 1, 0, 1025) + bytes(64))
    assert rejected(fw, WMI_SET_APPIE, 1025)


def test_set_appie_frame_type_out_of_range_rejected(fw):
    """Тип кадра вне 0..4 (wmi_mgmt_frame_type): vendor — фатальный ассерт 0x11f4."""
    send(fw, WMI_SET_APPIE, struct.pack('<BBH', 5, 0, 4) + bytes([0xdd, 2, 0, 0]))
    assert rejected(fw, WMI_SET_APPIE, 5)


def test_set_appie_long_rsn_rejected(fw):
    """RSN IE длиннее буфера своего RSN (0x28 Б) — по 9.4.2.24 законен (до 257 Б: несколько AKM, PMKID, Group
    Management Cipher): vendor падал фатальным ассертом 0x1482. Отказ в журнал, свой RSN не ставится, поля за буфером
    не тронуты."""
    mid = F.Fw(fw).mid0
    rsn = bytes([0x30, 42]) + bytes(range(42))                     # 44 Б
    nxt = fw.rbytes(mid + F.MID_BSS + 0x1a8, 8)
    send(fw, WMI_SET_APPIE, struct.pack('<BBH', 2, 0, len(rsn)) + rsn)       # 2 — Probe Response
    assert rejected(fw, WMI_SET_APPIE, len(rsn))
    assert fw.rbytes(mid + F.MID_BSS + 0x181, 1) == b'\x00'       # mid_bss.rsn_ie[1]: длина своего RSN — 0
    assert fw.rbytes(mid + F.MID_BSS + 0x1a8, 8) == nxt


@pytest.mark.parametrize('n', [33, 0xffffffff])
def test_set_ssid_too_long_ignored(fw, n):
    mid = F.Fw(fw).mid0
    send(fw, WMI_SET_SSID, struct.pack('<I', n) + bytes(range(32)))
    assert fw.r32(mid + F.MID_BSS + 0x48) == 0             # mid_bss.ssid_len: недопустимая длина — SSID нет


def test_connect_ssid_too_long_no_overflow(fw):
    w = F.Fw(fw)
    c = bytearray(F.connect_cmd())
    c[7] = 0xff
    nxt = fw.rbytes(w.mid0 + F.MID_BSS + 0x4c, 8)           # поля за ssid_len: channel, bcon_int…
    send(fw, F.WMI_CONNECT, bytes(c))
    assert fw.r32(w.mid0 + F.MID_BSS + 0x48) == 0
    assert fw.rbytes(w.mid0 + F.MID_BSS + 0x4c, 8) == nxt


# ---- найденные отказы fw на значения хоста (фатальный ассерт = перезагрузка fw драйвером) ----

def _fatal(code, where, what):
    """xfail: тест падает именно этим ассертом (fwflows.known_fatal) — другой сбой xfail не засчитывается."""
    def deco(fn):
        import functools

        @functools.wraps(fn)
        def wrapped(*a, **k):
            with F.known_fatal(code):
                return fn(*a, **k)
        return pytest.mark.xfail(strict=True, raises=F.KnownFatal, reason='фатальный ассерт %#x на значение хоста: '
                                 '%s — %s; нужен отказ (wmi_reject_param) и ответ хосту' % (code, where, what))(wrapped)
    return deco


@pytest.mark.parametrize('nt', [0, 0x08, 0x40])
def test_connect_bad_network_type(fw, nt):
    send(fw, F.WMI_CONNECT, F.connect_cmd(network_type=nt))
    assert [e.id for e in fw.wmi_evts].count(F.EV_DISCONNECT) == 1


@pytest.mark.parametrize('nt', [0, 0x40])
def test_pcp_start_bad_network_type(fw, nt):
    b = bytearray(0x10)
    struct.pack_into('<H', b, 0, 100)
    b[2], b[0xc], b[0xd], b[0xf] = 8, nt, 2, 1
    send(fw, F.WMI_PCP_START, bytes(b))
    assert [e.body[0] for e in fw.wmi_evts if e.id == 0x1918] == [1]


@pytest.mark.parametrize('cmd', ['connect', 'pcp_start'])
def test_bad_channel_rejected(fw, cmd):
    if cmd == 'connect':
        send(fw, F.WMI_CONNECT, F.connect_cmd(channel=7))
        assert F.EV_DISCONNECT in [e.id for e in fw.wmi_evts]
    else:
        b = bytearray(0x10)
        struct.pack_into('<H', b, 0, 100)
        b[2], b[0xc], b[0xd], b[0xf] = 8, 0x10, 7, 1
        send(fw, F.WMI_PCP_START, bytes(b))
        fw.advance(0x7530)
        assert [e.body[0] for e in fw.wmi_evts if e.id == 0x1918] == [1]
    assert not [c for c in fw.lmac_cmds if c.type == 0x01], 'канал включён'


@pytest.mark.parametrize('n, bad_ch', [(8, None), (2, 7)])
def test_start_scan_bad_channel_list_rejected(fw, n, bad_ch):
    """Каналов больше 4 (мест в scan_mngr.ch_order) или канал вне 0..3: WMI_SCAN_COMPLETE со статусом REJECTED (3)."""
    b = bytearray(0x12 + 2 * n)
    b[0x10] = 0                                              # WMI_ACTIVE_SCAN
    b[0x11] = n
    for i in range(n):
        b[0x12 + 2 * i] = i % 4
    if bad_ch is not None:
        b[0x12 + 2 * (n - 1)] = bad_ch
    evts = send(fw, F.WMI_START_SCAN, bytes(b))
    assert [e.body[0] for e in evts if e.id == 0x100a] == [3]
    assert rejected(fw, F.WMI_START_SCAN, bad_ch if bad_ch is not None else n)


def test_rx_chain_bad_max_pl(fw):
    """max_rx_pl_per_desc ≥ 3 не степень двойки: CFG_RX_CHAIN_DONE со status 0 (не SUCCESS), запись отказа."""
    b = bytearray(fwemu.FW.rx_chain_cmd())
    struct.pack_into('<h', b, 0x34, 3)
    evts = send(fw, WMI_CFG_RX_CHAIN, bytes(b))
    assert [e.body[4] for e in evts if e.id == 0x1820] == [0]
    assert rejected(fw, WMI_CFG_RX_CHAIN, 3)


def test_rx_chain_again_rejected(fw):
    """Второй CFG_RX_CHAIN за загрузку (кольца уже заданы): отказ, status 0; цепочка остаётся рабочей."""
    evts = send(fw, WMI_CFG_RX_CHAIN, fwemu.FW.rx_chain_cmd())
    assert [e.body[4] for e in evts if e.id == 0x1820] == [0]
    assert rejected(fw, WMI_CFG_RX_CHAIN, 1)


def test_vring_cfg_zero_timeslot(conn_fw):
    """schd_params.timeslot_us = 0: VRING_CFG_DONE со статусом отказа (1), запись отказа."""
    send(conn_fw, F.WMI_VRING_CFG, F.vring_cfg_cmd(1, 0, timeslot_us=0))
    assert _vring_done(conn_fw.wmi_evts) == [(1, 1)]
    assert rejected(conn_fw, F.WMI_VRING_CFG, 0)


def test_rcp_addba_resp_tid_out_of_range(conn_fw):
    """TID ≥ 8 (правил ключа MAC — 8): ADDBA Response пиру не уходит, RCP_ADDBA_RESP_SENT со статусом 1."""
    evts = send(conn_fw, WMI_RCP_ADDBA_RESP, struct.pack('<BBHHH', 0x80, 1, 0, 32 << 6, 0))
    assert [(e.body[0], e.body[2]) for e in evts if e.id == 0x1825] == [(0x80, 1)]
    assert rejected(conn_fw, WMI_RCP_ADDBA_RESP, 0x80)


def test_p2p_cfg_zero_interval(fw):
    """WMI_P2P_CFG bcon_interval = 0: P2P_CFG_DONE со статусом 1, запись отказа."""
    evts = send(fw, WMI_P2P_CFG, struct.pack('<BBH', 1, 2, 0))
    assert [e.body[0] for e in evts if e.id == 0x1910] == [1]
    assert rejected(fw, WMI_P2P_CFG, 0)


def test_discovery_start_while_connected(conn_fw):
    """WMI_DISCOVERY_START при подключённой STA (BSS не в состоянии 1): отказ без запуска поиска."""
    evts = send(conn_fw, WMI_DISCOVERY_START, b'')
    assert 0x1916 not in [e.id for e in evts]
    assert rejected(conn_fw, WMI_DISCOVERY_START, 2)


def test_bcast_vring_on_busy_ring(conn_fw):
    """WMI_BCAST_VRING_CFG на кольцо, занятое кольцом данных станции: VRING_CFG_DONE (1), кольцо данных цело."""
    b = bytearray(0x14)
    struct.pack_into('<IIH', b, 4, 0x30000000, 0, 0x400)
    b[4 + 0xc] = 0                                           # кольцо 0 — данные станции cid 0
    evts = send(conn_fw, F.WMI_BCAST_VRING_CFG, bytes(b))
    assert _vring_done(evts) == [(0, 1)]
    assert rejected(conn_fw, F.WMI_BCAST_VRING_CFG, 0)


def test_bcast_vring_before_bss(fw):
    """WMI_BCAST_VRING_CFG до PCP_START/CONNECT (тип сети записи не задан): VRING_CFG_DONE (1)."""
    b = bytearray(0x14)
    struct.pack_into('<IIH', b, 4, 0x30000000, 0, 0x400)
    b[4 + 0xc] = 1
    evts = send(fw, F.WMI_BCAST_VRING_CFG, bytes(b))
    assert _vring_done(evts) == [(1, 1)]


WMI_ADD_DEBUG_TX_PCKT = 0x808


@pytest.mark.parametrize('n', [0x500 - 0x1a + 1, 0xffff])
def test_add_debug_tx_pckt_too_long_rejected(conn_fw, n):
    """WMI_ADD_DEBUG_TX_PCKT: длина тестовой последовательности больше данных буфера TX (0x500 − заголовок QoS Data
    0x1a) — vendor писал её за буфер (соседние элементы пула, указатель done, DCCM). Отказ, кадр не ставится."""
    body = struct.pack('<IIH2xB7x', n, 0, 1, 0)
    send(conn_fw, WMI_ADD_DEBUG_TX_PCKT, body)
    assert rejected(conn_fw, WMI_ADD_DEBUG_TX_PCKT, n)


WMI_SW_TX_REQ, WMI_SW_TX_COMPLETE = 0x82b, 0x182b
SYSCFG_AP_SME_OFFLOAD = 0x80 + 0x28           # dashboard.cfg.ap_sme_offload_mode (include/sys_cfg.h)


@pytest.fixture
def splitmac_ap(fw):
    """AP в режиме split MAC (SME точки на хосте): Assoc Request станции cid 0 ушёл хосту, MLME ждёт его ответ."""
    f = F.Fw(fw)
    f.ap_start()
    fw.w8(fw.a('dashboard') + SYSCFG_AP_SME_OFFLOAD, 1)
    f.ap_sta_join()
    return f


def _sw_tx(fw, frame):
    return send(fw, WMI_SW_TX_REQ, F.STA_MAC + struct.pack('<H', len(frame)) + frame)


@pytest.mark.parametrize('body_len', [0, 2, 5])
def test_splitmac_assoc_resp_too_short_rejected(splitmac_ap, body_len):
    """Assoc Response хоста с телом короче Capability + Status + AID (6 Б): vendor — длина IE хоста через 0
    ((len − 2) & 0xffff − 4 ≈ 0xfffa), слияние читало ~64 КБ и писало за буфер TX. Отказ, SW_TX_COMPLETE (1)."""
    fw = splitmac_ap.fw
    own = splitmac_ap.own_mac()
    evts = _sw_tx(fw, fw.mgmt_frame(1, F.STA_MAC, own, own, bytes(body_len)))
    assert [e.body[0] for e in evts if e.id == WMI_SW_TX_COMPLETE] == [1]


def test_splitmac_assoc_resp_long_ies_fit_tx_buffer(splitmac_ap):
    """Assoc Response хоста с IE до предела: слитый кадр (IE хоста + свои ≤ 0x100 + WFA 0x11) не выходит за буфер TX;
    длиннее предела — отказ (vendor: слияние за буфер 0x500)."""
    fw = splitmac_ap.fw
    own = splitmac_ap.own_mac()
    ies = b''.join(bytes([0xdd, 0xfd]) + bytes([0x00, 0x11, 0x22, i]) + bytes(0xf9) for i in range(4))   # 4 × 255 Б
    evts = _sw_tx(fw, fw.mgmt_frame(1, F.STA_MAC, own, own, struct.pack('<HHH', 0x10, 0, 0xc001) + ies))
    assert [e.body[0] for e in evts if e.id == WMI_SW_TX_COMPLETE] == [1]
    _sw_tx(fw, fw.mgmt_frame(1, F.STA_MAC, own, own, struct.pack('<HHH', 0x10, 0, 0xc001) + ies[:0x3ef - 0x1e]))


def _wmi_raw(fw, cmd_id, body, rec_len, fill=0xa5):
    """Команда хоста с длиной записи rec_len (WMI-заголовок 8 Б + тело) в слоте, заполненном fill (остаток прошлых
    команд)."""
    for i in range(0x800):
        fw.cpu.mem[fw.WMI_BUF + i] = fill
    fw.wbytes(fw.WMI_BUF, struct.pack('<HHHHBBHI', 0, rec_len, 0, 0, 0, 0, cmd_id, 0) + body)
    fw.call('wmi_host_cmd_dispatch', fw.a('operational_mbox'), fw.WMI_BUF)
    fw.run_tasks()
    F.settle(fw)


def test_short_command_reads_zeros_not_previous(fw):
    """Короткая запись хоста: SET_APPIE с ie_len = 40, но длиной записи на 4 Б тела. vendor длину записи не читал —
    40 Б IE брались из остатка прошлых команд слота (ключи, пароли — в кадры). Теперь хвост слота — нули."""
    f = F.Fw(fw)
    _wmi_raw(fw, WMI_SET_APPIE, struct.pack('<BBH', 2, 0, 40), 8 + 4)
    blk = fw.call('mid_app_ie_block', f.mid0 + F.MID_BSS, 2)
    buf, n = fw.r32(blk), fw.r16(blk + 4)
    assert n == 0 or set(fw.rbytes(buf, n)) <= {0}, fw.rbytes(buf, n).hex()


@pytest.mark.parametrize('rec_len', [0, 7, 0x2000])
def test_record_length_outside_slot_rejected(fw, rec_len):
    """Длина записи меньше WMI-заголовка или больше слота ящика — «не поддерживается», обработчик не вызывается."""
    _wmi_raw(fw, WMI_SET_SSID, struct.pack('<I', 4) + b'abcd', rec_len, fill=0)
    assert fw.logged('WMI_BAD_LEN')


@pytest.mark.parametrize('n', [0xf0, 0xf8, 0x1000])
def test_ut_xpm_read_block_len_limit(fw, n):
    """UT 9/0x98b (чтение блока XPM): длина больше данных ответа (0xe8 Б) — отказ, ответ только с заголовком. vendor:
    предел tx_entry_size − 8 (на 16 Б больше — запись в соседний элемент пула событий), при отказе длина ответа n + 8
    (> 0x100 — фатальный ассерт 0x10ce)."""
    evts = send(fw, WMI_UNIT_TEST, struct.pack('<HHIII', 9, 0x98b, 0, 0, n) + bytes(0x50))
    rsp = [e for e in evts if e.id == 0x1900]
    assert rsp and all(len(e.body) <= 8 + 0xe8 for e in rsp), [len(e.body) for e in rsp]

