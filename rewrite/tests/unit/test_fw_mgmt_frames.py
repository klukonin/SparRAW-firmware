# SPDX-License-Identifier: AGPL-3.0-or-later
"""Тела кадров управления, которые собирает fw, против рисунков и таблиц 802.11-2020 (биты: B0 — младший бит первого
октета, поля little-endian). Ожидания выведены из стандарта и из того, что fw на деле делает (TDMA точки — fw/tdma.c,
энергосбережения нет), а не из формул fw.

  * Association Response точки (9.3.3.6, табл. 9-35): Capability Information (9.4.1.4, рис. 9-86; DMG Parameters —
    9.4.1.46), Status Code, AID (9.4.1.8), порядок элементов, DMG Capabilities (9.4.2.127, рис. 9-549..9-553),
    DMG Operation (9.4.2.128, рис. 9-555..9-556);
  * то же при TDMA точки (ESE в маяке): CBAP Only = 0, TDDTI / Pseudo-static allocations = 1;
  * Probe Response (9.3.3.10, табл. 9-39) — Capability Information как в Association Response;
  * Association Request станции (9.3.3.5, табл. 9-34) — резервные подполя DMG Parameters.
"""
import struct

import pytest

import fwflows as F

EID_EDCA, EID_EXT_SCHED, EID_DMG_CAP, EID_DMG_OP, EID_VS = 12, 144, 148, 151, 221
HW_MAC_BEACON_INTERVAL = 0x886d64                           # include/hw.h, TU


def elements(body):
    """[(eid, тело)] — элементы подряд (9.4.2.1: Element ID, Length, тело); хвост короче заголовка — ошибка."""
    out, i = [], 0
    while i < len(body):
        assert i + 2 <= len(body) and i + 2 + body[i + 1] <= len(body), 'элемент за концом кадра: %s' % body[i:].hex()
        out.append((body[i], bytes(body[i + 2:i + 2 + body[i + 1]])))
        i += 2 + body[i + 1]
    return out


def bits(v, lo, hi):
    """Подполе B<lo>..B<hi> целого v (B0 — младший бит)."""
    return (v >> lo) & ((1 << (hi - lo + 1)) - 1)


def tx_mgmt(fw, stype):
    """Кадры управления подтипа stype, ушедшие в кольца TX (FC: тип 0, подтип B4..B7)."""
    return [f for _, f in fw.tx_frames if f[0] == stype << 4 and f[1] & 0x0f == 0]


def assoc_resp_for(w, peer, cid):
    fw = w.fw
    fw.tx_frames.clear()
    w.ap_sta_join(peer=peer, cid=cid)
    resp = [f for f in tx_mgmt(fw, 1) if f[4:10] == bytes(peer)]
    assert len(resp) == 1, [f.hex() for f in tx_mgmt(fw, 1)]
    return resp[0]


def sta_mac(i):
    return bytes([0x04, 0xd4, 0xc4, 0x55, 0x66, 0x10 + i])


@pytest.fixture
def ap(fw):
    w = F.Fw(fw)
    w.set_mac(F.AP_MAC)
    w.ap_start()
    return w


def check_dmg_caps(body, own_mac, max_sta):
    """DMG Capabilities точки (9.4.2.127): 22 октета (рис. 9-549)."""
    assert len(body) == 22, body.hex()
    assert body[0:6] == own_mac                               # STA Address — передающая станция
    assert body[6] == 0                                       # AID передающей станции: 0 — AP/PCP (9.4.1.8)
    sta = int.from_bytes(body[7:15], 'little')                # DMG STA Capability Information (рис. 9-550)
    assert bits(sta, 4, 5) == 0                               # Number of RX DMG Antennas − 1: одна антенна
    assert bits(sta, 7, 13) == 32 - 1                         # Total Number of Sectors − 1 (board-файл: 32)
    assert bits(sta, 27, 27) == 0                             # BA with Flow Control: нет (10.42.9)
    assert bits(sta, 53, 53) == 0                             # Reserved
    # Heartbeat: станция ждёт кадр DMG Control в начале TXOP/SP (10.23.2, 10.39.6.2) — приёмник наводится по RTS
    # (docs/MAC-STAND.md, H-RXSTEER); Heartbeat Elapsed Indication 0 → T_HE = 0 мс: кадр Control — всегда.
    assert bits(sta, 54, 54) == 1 and bits(sta, 57, 59) == 0
    assert bits(sta, 60, 60) == 1                             # Grant Ack Supported (uc отвечает Grant Ack)
    assert bits(sta, 63, 63) == 0                             # Reserved
    ap_cap = int.from_bytes(body[15:17], 'little')            # DMG AP Or PCP Capability Information (рис. 9-553)
    # TDDTI = 0: «способна к 10.39.6 и 11.4» — DMG ADDTS (11.4) нет, обязательство Poll Required в A-BFT
    # (10.42.5) — нет; Pseudo-static Allocations при TDDTI = 0 — резерв (0); PCP Handover (11.27.2) нет.
    assert bits(ap_cap, 0, 2) == 0
    assert bits(ap_cap, 3, 10) == max_sta                     # MAX Associated STA Number
    assert bits(ap_cap, 11, 11) == 1                          # Power Source: не от батареи (power_source 1)
    assert bits(ap_cap, 12, 15) == 0                          # кластеризации и PCP Forwarding нет, Reserved
    assert body[17:22] == bytes(5)                            # Beam Tracking Time Limit, Ext SC MCS, A-MSDU — 0


def test_assoc_resp_body(ap):
    """Association Response точки одной станции (весь DTI — CBAP): поля и элементы по табл. 9-35."""
    w = ap
    f = assoc_resp_for(w, F.STA_MAC, 0)
    assert f[10:16] == F.AP_MAC and f[16:22] == F.AP_MAC     # SA, BSSID — точка
    cap, status, aid = struct.unpack_from('<HHH', f, 24)
    # Capability Information (рис. 9-86): B0..B7 DMG Parameters (рис. 9-133)
    assert bits(cap, 0, 1) == 3                               # BSS Type: AP (табл. 9-68)
    assert bits(cap, 2, 2) == 1                               # CBAP Only: ESE нет, весь DTI — CBAP
    assert bits(cap, 3, 3) == 0                               # CBAP Source
    assert bits(cap, 4, 4) == 0                               # DMG Privacy: открытая сеть
    assert bits(cap, 5, 7) == 0                               # ECAPC Policy Enforced, Reserved
    assert bits(cap, 8, 15) == 0                              # Spectrum Mgmt, Triggered Unscheduled PS, RM, EPD — нет
    assert status == 0
    assert aid == 1                                           # 9.4.1.8: DMG AID 1..254, старшие 8 бит — резерв
    el = elements(f[30:])
    ids = [e for e, _ in el]
    # порядок табл. 9-35: EDCA Parameter Set (6), DMG Capabilities (25), DMG Operation (26), Vendor Specific — последние
    assert ids[:3] == [EID_EDCA, EID_DMG_CAP, EID_DMG_OP], ids
    assert all(e == EID_VS for e in ids[3:]), ids
    check_dmg_caps(dict(el)[EID_DMG_CAP], F.AP_MAC, F.SPARRAW_MAX_STA)
    op = dict(el)[EID_DMG_OP]
    assert len(op) == 10                                      # рис. 9-555: Operation Information 2 + BSS Parameter 8
    info = int.from_bytes(op[0:2], 'little')
    assert info == 0                                          # TDDTI 0 (без ESE), Pseudo-static — резерв, Handover 0
    # рис. 9-557: MaxLostBeacons = dot11MaxLostBeacons (DEFVAL 4, Annex C) — то же A, что в Tguard (10.39.6.5)
    assert op[9] == 4
    # MinBHIDuration — наименьший BHI (A-BFT не в каждом BI, ATI нет): один BTI — n маяков через SBIFS (1 мкс), TXTIME —
    # Control PHY (20.4.3.3) от длины маяка; AssocRespConfirmTime (50 мс) — ответ в ближайшем DTI: ⌈BI / 50 мс⌉
    import machw
    fw = ap.fw
    n = fw.r8(fw.a('fwsh_total_sectors')) or 1
    L = max(fw.r32(fw.a('fwsh_diag') + 8), 6)
    assert int.from_bytes(op[3:5], 'little') == (n * (machw.ctrl_txtime_clk(L) + 165) - 165) // 165
    assert op[6] == -(-100 * 1024 // 50000)
    assert op[2] == op[5] == op[7] == op[8] == 0              # PS, рассылка сведений о станциях, PP/GP — нет


def test_assoc_resp_with_tdma_schedule(ap):
    """При TDMA точки (≥ 2 станций — ESE в маяке, аллокации псевдостатические) Association Response объявляет то же
    расписание: CBAP Only = 0 (9.4.1.46), TDDTI = 1, Pseudo-static allocations = 1 (рис. 9-556)."""
    w = ap
    w.fw.mmio[HW_MAC_BEACON_INTERVAL] = 100                  # BI 100 TU (ap_start): по нему fw/tdma.c режет DTI
    for i in range(2):
        w.ap_sta_join(peer=sta_mac(i), cid=i)
    bss = w.mid0 + F.MID_BSS
    blk = w.fw.call('mid_app_ie_block', bss, 0)
    buf, n = w.fw.r32(blk), w.fw.r16(blk + 4)
    ese = [b for e, b in elements(w.fw.rbytes(buf, n)) if e == EID_EXT_SCHED]
    assert len(ese) == 1 and ese[0][0] & 0x80, 'нет ESE TDMA с псевдостатическими аллокациями'
    f = assoc_resp_for(w, sta_mac(2), 2)
    cap = struct.unpack_from('<H', f, 24)[0]
    assert bits(cap, 0, 1) == 3 and bits(cap, 2, 2) == 0      # CBAP Only = 0: DTI распределён ESE
    op = dict(elements(f[30:]))[EID_DMG_OP]
    assert bits(int.from_bytes(op[0:2], 'little'), 0, 2) == 0b011   # TDDTI 1, Pseudo-static 1, PCP Handover 0


def test_probe_resp_capability_matches_beacon(ap):
    """Probe Response: CBAP Only в Capability Information — как в DMG Parameters маяка (9.4.1.46)."""
    w = ap
    fw = w.fw
    conn = w.ap_sta_join()
    pl, ln = fw.call('TX_API_alloc_tx_payload'), fw._scratch_alloc(4)

    def cap():
        fw.call('mgmt_tx_build_probe_resp', pl, ln, w.mid0, conn, 0)
        return struct.unpack_from('<H', fw.rbytes(pl, 0x24), 0x22)[0]   # после Timestamp (8) и Beacon Interval (2)
    assert bits(cap(), 2, 2) == 1
    fw.w32(fw.r32(w.mid0 + MID_SCHED) + SCHED_BUILT, 1)      # схема ESE собрана (WMI_SCHEDULING_SCHEME / TDMA)
    assert bits(cap(), 0, 1) == 3 and bits(cap(), 2, 2) == 0


MID_SCHED = 0x290            # struct mid: sched (include/mid.h)
SCHED_BUILT = 0x0c           # struct sched_scheme: built (include/sched_scheme.h)


def test_assoc_req_capability_reserved(fw):
    """Association Request станции: BSS Type, CBAP Only, CBAP Source, ECAPC Policy Enforced — резерв (9.4.1.46: только
    в DMG Beacon / Probe Response / (Re)Association Response), передаются нулём."""
    w = F.Fw(fw)
    w.sta_connect(stop='assoc_req')
    req = tx_mgmt(fw, 0)
    assert req, 'Association Request не ушёл'
    cap = struct.unpack_from('<H', req[-1], 24)[0]
    assert bits(cap, 0, 3) == 0 and bits(cap, 5, 7) == 0, hex(cap)


def test_assoc_req_listen_interval_zero(fw):
    """Listen Interval (9.4.1.6, в BI) — 0: станция не уходит в энергосбережение («The value 0 might be used by a STA
    that never enters power save mode»)."""
    w = F.Fw(fw)
    w.rx_beacon(F.dmg_beacon(F.AP_MAC, bi=200))
    w.sta_connect(stop='assoc_req')
    req = tx_mgmt(fw, 0)
    assert req and struct.unpack_from('<H', req[-1], 26)[0] == 0


# ---- порядок и состав элементов Probe Response / Probe Request / Association Request ----

WMI_SET_APPIE, APPIE_PROBE_RESP = 0x3f, 2                   # enum wmi_mgmt_frame_type: 2 — Probe Response
EID_SSID, EID_RSN, EID_QOS_CAP, EID_EXT_CAP, EID_MULTI_BAND, EID_ANT_SECTOR = 0, 48, 46, 127, 158, 190
# Порядковые номера табл. 9-39 (Probe Response) для элементов, что встречаются в тесте; Vendor Specific — последние
PROBE_RESP_ORDER = {EID_SSID: 4, EID_RSN: 16, EID_EDCA: 18, EID_EXT_CAP: 35, EID_MULTI_BAND: 53, EID_DMG_CAP: 54,
                    EID_DMG_OP: 55, EID_ANT_SECTOR: 57, EID_VS: 1000}


def build(fw, fn, *args):
    pl, ln = fw.call('TX_API_alloc_tx_payload'), fw._scratch_alloc(4)
    fw.call(fn, pl, ln, *args)
    return fw.rbytes(pl, fw.r32(ln))


def probe_resp_ids(w, conn):
    f = build(w.fw, 'mgmt_tx_build_probe_resp', w.mid0, conn, 0)
    return [e for e, _ in elements(f[24 + 12:])]               # после заголовка и Timestamp/Beacon Interval/Capability


def assert_table_order(ids, order):
    ranks = [order[e] for e in ids]
    assert ranks == sorted(ranks), ids


@pytest.mark.parametrize('rsn', [False, True], ids=['open', 'rsna'])
def test_probe_resp_element_order(ap, rsn):
    """Свои элементы Probe Response — по порядку табл. 9-39 (SSID 4, RSN 16, EDCA 18, DMG Capabilities 54, DMG
    Operation 55, Antenna Sector ID Pattern 57, Vendor Specific — последние); QoS Capability в табл. 9-39 нет."""
    w = ap
    conn = w.ap_sta_join()
    if rsn:
        w.fw.call('mid_set_default_rsn_ie', w.mid0)
    ids = probe_resp_ids(w, conn)
    assert EID_QOS_CAP not in ids, ids
    assert (EID_RSN in ids) == rsn and EID_EDCA in ids and EID_DMG_OP in ids, ids
    assert_table_order(ids, PROBE_RESP_ORDER)


def test_probe_resp_merged_with_host_ies_order(ap):
    """IE хоста для Probe Response (WMI_SET_APPIE: Extended Capabilities, Multi-band, Vendor Specific) сливаются со
    своими по порядку табл. 9-39, а не по Element ID: Multi-band (53, eid 158) — до DMG Capabilities (54, eid 148),
    RSN (16, eid 48) — до EDCA (18, eid 12)."""
    w = ap
    fw = w.fw
    conn = w.ap_sta_join()
    fw.call('mid_set_default_rsn_ie', w.mid0)
    host = (bytes([EID_EXT_CAP, 8]) + bytes(8) + bytes([EID_MULTI_BAND, 22]) + bytes(22) +
            bytes([EID_VS, 4, 0x00, 0x50, 0xf2, 0x04]))
    w.fw.wmi(WMI_SET_APPIE, struct.pack('<BBH', APPIE_PROBE_RESP, 0, len(host)) + host)
    ids = probe_resp_ids(w, conn)
    assert EID_EXT_CAP in ids and EID_MULTI_BAND in ids and EID_RSN in ids, ids
    assert_table_order(ids, PROBE_RESP_ORDER)


def test_probe_req_without_rsn(fw):
    """Probe Request (табл. 9-38) RSN не содержит — и при заданном RSN станции (WPA2-PSK)."""
    w = F.Fw(fw)
    conn = w.sta_connect(stop='assoc_req')
    fw.call('mid_set_default_rsn_ie', w.mid0)
    ssid = fw._scratch_alloc(4)
    fw.wbytes(ssid, b'test')
    f = build(fw, 'mgmt_tx_build_probe_req', w.mid0, conn, ssid, 4)
    ids = [e for e, _ in elements(f[24:])]
    assert EID_RSN not in ids and EID_SSID in ids and EID_DMG_CAP in ids, ids


def test_assoc_req_qos_info_no_uapsd(fw):
    """Association Request: QoS Capability (табл. 9-34, порядок 9) — QoS Info станции (9.4.1.17, рис. 9-101): U-APSD
    (B0..B3), Q-Ack, Max SP Length, More Data Ack — 0: энергосбережения нет."""
    w = F.Fw(fw)
    w.sta_connect(stop='assoc_req')
    req = tx_mgmt(fw, 0)[-1]
    qos = [b for e, b in elements(req[24 + 4:]) if e == EID_QOS_CAP]
    assert qos == [b'\x00'], qos


# ---- приём: AID, Extended Schedule станции, разбор элементов; маяк discovery; RSN по умолчанию ----

def test_sta_assoc_resp_aid_reserved_bits_ignored(fw):
    """AID DMG (9.4.1.8): 1..254 в младшем октете, старшие 8 бит — резерв. AID поля 0x0101 — AID 1, ассоциация
    успешна (маска 0x3fff не-DMG брала 257 и отвергала ответ)."""
    w = F.Fw(fw)
    w.sta_connect(aid=0x0101)
    assert F.EV_CONNECT in [e.id for e in fw.wmi_evts]
    assert fw.r8(w.mid0 + 8) == 1                             # struct mid: aid


ESE_TBL_SLOT, ESE_SLOT_LEN, ESE_SLOT_START, ESE_SLOT_DUR = 4, 0xc, 4, 8   # include/fwsh.h: ese_slot_tbl / ese_slot


def ese_windows(fw):
    """[(начало от начала BI, длительность)] записей таблицы ESE станции (общая с uc)."""
    t = fw.a('ese_slot_tbl')
    return [(fw.r32(t + ESE_TBL_SLOT + ESE_SLOT_LEN * i + ESE_SLOT_START),
             fw.r16(t + ESE_TBL_SLOT + ESE_SLOT_LEN * i + ESE_SLOT_DUR)) for i in range(fw.r8(t + 1))]


def test_sta_ese_all_blocks_of_allocation(fw):
    """Аллокация ESE (9.4.2.131) — Number of Blocks окон длиной Allocation Block Duration с шагом Allocation Block
    Period от Allocation Start: SP станции AID 1 из 3 блоков — 3 окна; окна по возрастанию начала (поле с более ранним
    окном после — тоже)."""
    w = F.Fw(fw)
    fw.mmio[HW_MAC_BEACON_INTERVAL] = 100                     # BI 102 400 мкс; начало BI (TSF) — 0
    w.sta_connect(aid=1)
    w.sta_add_vring()
    w.rx_beacon(F.dmg_beacon(F.AP_MAC, [F.ese_alloc(1, src_aid=1, start=30000, dur=400),
                                        F.ese_alloc(2, src_aid=1, start=1000, dur=500, nblk=2, period=50000)]))
    assert ese_windows(fw) == [(1000, 500), (30000, 400), (51000, 500)]


def test_rx_mgmt_last_zero_length_element_parsed(fw):
    """Элемент нулевой длины (9.4.2.1: Length 0..255) последним в кадре разбирается: Probe Request только с SSID
    шириной 0 (wildcard, 9.4.2.2) — запись SSID есть, длина 0."""
    pkt = fw.rx_pkt(fw.mgmt_frame(4, b'\xff' * 6, F.STA_MAC, b'\xff' * 6, bytes([EID_SSID, 0])))
    fw.call('rx_mgmt_parse_frame', fw.a('rx_pkt_srvs'), pkt)
    ei = fw.r32(pkt + 0x0c)
    assert fw.r32(ei + 0x08 + 4) != 0 and fw.r8(ei + 0x08 + 1) == 0   # ei.ssid: тело есть, длина 0


def test_discovery_beacon_clustering_control_reserved(fw):
    """DMG Beacon с CC Present и Discovery Mode (рис. 9-77): Clustering Control по рис. 9-79 — A-BFT Responder Address
    (B0..B47), Reserved B48..B63 = 0 (не остаток буфера)."""
    w = F.Fw(fw)
    bi = w.mid0 + F.MID_BSS + 0x107                           # mid_bss.bi_ctrl
    fw.w8(bi, fw.r8(bi) | 3)                                  # CC Present (B0), Discovery Mode (B1)
    pl = fw.call('TX_API_alloc_tx_payload')
    fw.wbytes(pl, b'\xff' * 64)
    n = fw.call('tx_mgmt_build_dmg_bcon_fixed', pl, w.mid0)
    f = fw.rbytes(pl, n)
    # FC, Duration, BSSID (10), Timestamp 8, SSW 3, Beacon Interval 2, BI Control 6, DMG Parameters 1 → +30
    assert n == 38 and f[36:38] == b'\0\0', f.hex()


def test_default_rsn_capabilities_zero(fw):
    """RSN по умолчанию (WMI_CONNECT, WPA2-PSK): RSN Capabilities (9.4.2.24.4, рис. 9-289) — 0, включая OCVC (B14) и
    Reserved (B15), что бы ни лежало в буфере до того."""
    w = F.Fw(fw)
    rsn = w.mid0 + F.MID_BSS + 0x180                          # mid_bss.rsn_ie
    fw.wbytes(rsn, b'\xff' * 0x28)
    fw.call('mid_set_default_rsn_ie', w.mid0)
    assert fw.rbytes(rsn, 2) == bytes([48, 20]) and fw.rbytes(rsn + 0x14, 2) == b'\0\0', fw.rbytes(rsn, 0x16).hex()
