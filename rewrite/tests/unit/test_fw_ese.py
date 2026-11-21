# SPDX-License-Identifier: AGPL-3.0-or-later
"""Extended Schedule element в DMG Beacon точки (802.11-2020 9.4.2.131, рис. 9-562/9-563/9-564, Table 9-257) — два
пути fw: расписание хоста WMI_SCHEDULING_SCHEME (0xa01, fw/wmi_h_bf.c sched_build_alloc_entry) и простой TDMA точки
при двух и более станциях (fw/tdma.c). Кадр — маяк, поставленный в кольцо маяка (fw.tx_frames); элемент ищется в
IE после фиксированной части (9.3.4.2), поля разбираются по рисункам стандарта.

Время — регистры MAC в эмуляторе: интервал маяков (TU) и TSF начала текущего BI; Allocation Start по 9.4.2.131 —
младшие 4 октета TSF начала окна (окна fw объявляет на следующий BI)."""
import math
import struct
from fractions import Fraction as F

import pytest

import fwflows as Fl
from test_uc_beacon_tx import ctrl_txtime, ss_slot_time

HW_MAC_BEACON_INTERVAL = 0x886d64          # include/hw.h: интервал маяков, TU
HW_MAC_BI_START_TSF_LO = 0x886fc4          # include/hw.h: TSF начала текущего BI, мкс (младшие 32 бита)
WMI_SCHEDULING_SCHEME = 0xa01
EID_EXT_SCHED = 144                         # Table 9-92: Extended Schedule
BI_TU = 100
BI_US = BI_TU * 1024                        # TU = 1024 мкс (3.1)
BI_START = 0x00100000
SIFS, MBIFS, SBIFS = 3, 9, 1                # Table 20-30, 10.3.2.3
A_PSEUDO = 4                                # dot11MaxLostBeacons DEFVAL (Annex C)
C_PPM = 20                                  # aDMGTSFAccuracy (Table 20-30)
T_P, T_TR = F(1, 10), 1                     # aAirPropagationTime, aTSFResolution (Table 20-30)


def bits(v, lo, n):
    return (v >> lo) & ((1 << n) - 1)


def alloc_fields(a):
    """Allocation field (рис. 9-563) и Allocation Control (рис. 9-564, DMG)."""
    ctl, bf, src, dst, start, dur, nblk, per = struct.unpack('<HHBBIHBH', a)
    return dict(id=bits(ctl, 0, 4), type=bits(ctl, 4, 3), pseudo=bits(ctl, 7, 1), trunc=bits(ctl, 8, 1),
                ext=bits(ctl, 9, 1), pcp_active=bits(ctl, 10, 1), lp_sc=bits(ctl, 11, 1), res=bits(ctl, 12, 4),
                bf=bf, src=src, dst=dst, start=start, dur=dur, nblk=nblk, period=per)


def ese_of(frame):
    """Extended Schedule из DMG Beacon (9.3.4.2): заголовок 10 октетов, Timestamp 8, SSW 3, Beacon Interval 2,
    BI Control 6, DMG Parameters 1, Clustering Control 8 (если CC Present, B0 BI Control) — затем элементы."""
    assert int.from_bytes(frame[:2], 'little') & 0xff == 0x0c, frame[:2].hex()      # Extension, подтип 0
    i = 0x1e + (8 if frame[0x17] & 1 else 0)
    found = []
    while i + 2 <= len(frame):
        eid, ln = frame[i], frame[i + 1]
        assert i + 2 + ln <= len(frame), 'элемент за концом кадра: %s' % frame.hex()
        if eid == EID_EXT_SCHED:
            found.append(frame[i + 2:i + 2 + ln])
        i += 2 + ln
    if not found:
        return None
    assert len(found) == 1, 'несколько ESE: %s' % found
    body = found[0]
    assert len(body) % 15 == 0 and body, 'Length %d не кратна 15 (рис. 9-562)' % len(body)
    return [alloc_fields(body[k:k + 15]) for k in range(0, len(body), 15)]


def last_beacon(fw, t0=0):
    b = [f for _, f in fw.tx_frames[t0:] if int.from_bytes(f[:2], 'little') & 0xff == 0x0c]
    assert b, 'маяк не поставлен'
    return b[-1]


def ap(fw):
    w = Fl.Fw(fw)
    w.set_mac(Fl.AP_MAC)
    w.ap_start(bi=BI_TU)
    fw.mmio[HW_MAC_BEACON_INTERVAL] = BI_TU
    fw.mmio[HW_MAC_BI_START_TSF_LO] = BI_START
    return w


def tguard(a1, a2):
    """10.39.6.5: Tguard = ⌈((A_i + 1)·C·D_i + (A_i+1 + 1)·C·D_i+1)/10^6 + SIFS + T_P + T_TR⌉, A — dot11MaxLostBeacons
    у псевдостатического окна (0 иначе), D — BI у псевдостатического."""
    term = lambda a: (A_PSEUDO + 1) * C_PPM * BI_US if a['pseudo'] else C_PPM * 0
    return math.ceil(F(term(a1) + term(a2), 10 ** 6) + SIFS + T_P + T_TR)


def common_alloc_checks(al):
    """Общие правила 9.4.2.131 для любого Allocation field точки."""
    for a in al:
        assert a['type'] in (0, 1), a                              # Table 9-257: SP 000 / CBAP 100 (B4 — младший)
        assert a['pcp_active'] == 1, a                             # «set to 1 … transmitted by an AP»
        assert (a['lp_sc'], a['res']) == (0, 0), a
        if a['type'] == 1:
            assert (a['trunc'], a['ext']) == (0, 0), a             # для CBAP — резерв
        bcast = a['src'] == 255 and a['dst'] == 255
        if a['type'] == 1 and bcast:
            assert a['id'] == 0, a                                  # CBAP 255→255 — Allocation ID 0
        else:
            assert 1 <= a['id'] <= 15, a
        assert a['nblk'] >= 1, a
        if a['nblk'] == 1:
            assert a['period'] == 0, a                              # Block Period — резерв при одном блоке
        assert 1 <= a['dur'] <= (32767 if a['type'] == 0 else 65535), a
    ids = [(a['src'], a['dst'], a['id']) for a in al if a['id'] != 0]
    assert len(ids) == len(set(ids)), 'кортеж (Source AID, Destination AID, Allocation ID) не уникален: %s' % ids


# ---------------- WMI_SCHEDULING_SCHEME ----------------

def slot(tbtt_offset, typ, dur, src, dst, nblk=1, period=0):
    """struct wmi_sched_scheme_slot (include/wmi.h, 20 октетов)."""
    return struct.pack('<IBBHHHBBBBI', tbtt_offset, 0, typ, dur, 0, period, nblk, 0, src, dst, 0)


def scheme_cmd(slots, flags=1 | 8):
    """struct wmi_scheduling_scheme_cmd: serial, ese_advertisment = 1, флаги (б0 — схема, б3 — в маяк), число."""
    return struct.pack('<BBHB3xII', 5, 1, flags, len(slots), 0, 0) + b''.join(slots)


@pytest.mark.parametrize('typ', [0, 1], ids=['sp', 'cbap'])
def test_wmi_scheme_ese_fields(fw, typ):
    """Расписание хоста: окно CBAP 255→255 и окно typ станции AID 1 → точке (AID 0, 9.4.1.8). В маяке: Allocation Type
    по Table 9-257, Allocation ID (0 только у CBAP 255→255), PCP Active = 1, Source/Destination AID, Allocation Start =
    TSF начала окна (начало следующего BI + смещение хоста), Allocation Block Duration — длительность хоста."""
    ap(fw)
    t0 = len(fw.tx_frames)
    fw.wmi(WMI_SCHEDULING_SCHEME, scheme_cmd([slot(5000, 1, 3000, 255, 255), slot(20000, typ, 4000, 1, 0)]))
    Fl.settle(fw)
    al = ese_of(last_beacon(fw, t0))
    assert al is not None, 'в маяке нет Extended Schedule'
    common_alloc_checks(al)
    assert [(a['type'], a['src'], a['dst'], a['dur']) for a in al] == [(1, 255, 255, 3000), (typ, 1, 0, 4000)]
    assert [a['start'] for a in al] == [(BI_START + BI_US + o) & 0xffffffff for o in (5000, 20000)]
    assert al[0]['id'] == 0 and al[1]['id'] != 0
    assert [a['bf'] for a in al] == [0, 0]                         # BF Control (9.5.5): обучения в окне нет


def test_wmi_scheme_ese_ordered_by_start(fw):
    """Записи хоста не по порядку начала — в элементе поля всё равно по возрастанию Allocation Start (9.4.2.131)."""
    ap(fw)
    t0 = len(fw.tx_frames)
    fw.wmi(WMI_SCHEDULING_SCHEME, scheme_cmd([slot(40000, 1, 3000, 1, 0), slot(5000, 1, 3000, 2, 0)]))
    Fl.settle(fw)
    st = [a['start'] for a in ese_of(last_beacon(fw, t0))]
    assert st == sorted(st), st


def test_wmi_scheme_multi_block_rejected(fw):
    """Number of Blocks > 1 (9.4.2.131) точка не выполняет (таблица слотов — один блок на выделение): команда
    отвергается ненулевым статусом, маяк без нового ESE — не объявлять того, что точка не делает."""
    ap(fw)
    t0 = len(fw.tx_frames)
    ev = fw.wmi(WMI_SCHEDULING_SCHEME, scheme_cmd([slot(5000, 1, 3000, 1, 0, nblk=2, period=10000)]))
    Fl.settle(fw)
    st = [e.body[0] for e in ev if e.id == 0x1a01]
    assert st and st[0] != 0, st
    assert not [f for _, f in fw.tx_frames[t0:] if int.from_bytes(f[:2], 'little') & 0xff == 0x0c and ese_of(f)]


def test_wmi_scheme_allocation_ids_unique(fw):
    """Четыре окна станций (WMI_SCHED_MAX_ALLOCS_PER_CMD): Allocation ID 1..15, кортеж (Source, Destination, ID)
    уникален (9.4.2.131)."""
    ap(fw)
    t0 = len(fw.tx_frames)
    fw.wmi(WMI_SCHEDULING_SCHEME, scheme_cmd([slot(5000 + 10000 * i, 0, 3000, 1, 0) for i in range(4)]))
    Fl.settle(fw)
    al = ese_of(last_beacon(fw, t0))
    common_alloc_checks(al)
    assert len({a['id'] for a in al}) == 4


# ---------------- TDMA точки ----------------

def sta_mac(i):
    return bytes([0x04, 0xd4, 0xc4, 0x00, 0x10, i])


@pytest.mark.parametrize('k', [2, 3])
def test_tdma_ese_windows(fw, k):
    """TDMA точки при k станциях (fw/tdma.c): общее окно CBAP 255→255 и по окну CBAP станция → точка (AID 0). Окна:
    после BTI и A-BFT этого маяка (BTI — n маяков развёртки через SBIFS, TXTIME — Control PHY от длины маяка с FCS;
    A-BFT — через MBIFS, L·aSSSlotTime, 10.42.5), по возрастанию начала (9.4.2.131), между соседними — не меньше
    Tguard (10.39.6.5), ни одно не пересекает конец BI (9.4.2.131: блок «cannot cross beacon interval boundaries»)."""
    w = ap(fw)
    for i in range(k):
        w.ap_sta_join(peer=sta_mac(i + 1), cid=i)
    bcn = last_beacon(fw)
    al = ese_of(bcn)
    assert al is not None, 'TDMA при %d станциях не объявлен' % k
    common_alloc_checks(al)
    assert len(al) == k + 1
    assert (al[0]['type'], al[0]['src'], al[0]['dst']) == (1, 255, 255)
    aids = [a['src'] for a in al[1:]]
    assert all(1 <= x <= 254 for x in aids) and len(set(aids)) == k, aids     # 9.4.1.8: AID станции 1..254
    assert all(a['type'] == 1 and a['dst'] == 0 for a in al[1:]), al          # точка — AID 0

    base = (BI_START + BI_US) & 0xffffffff                                      # окна — на следующий BI
    rel = [(a['start'] - base) & 0xffffffff for a in al]
    assert rel == sorted(rel), rel
    sweep = [c for c in fw.lmac_cmds if c.type == 0x0b][-1].body           # развёртка, которую выполнит uc
    n, fss, abft_len = sweep[4 + 0x48], sweep[0x50 + 7], sweep[0x50 + 0xa]
    bti = n * (ctrl_txtime(len(bcn) + 4) + SBIFS)
    abft = MBIFS + (abft_len + 1) * ss_slot_time(fss)
    assert rel[0] >= bti + abft + MBIFS, (rel[0], float(bti + abft + MBIFS))
    for a, b, ra, rb in zip(al, al[1:], rel, rel[1:]):
        assert rb - (ra + a['dur']) >= tguard(a, b), (ra, a['dur'], rb, tguard(a, b))
    assert rel[-1] + al[-1]['dur'] <= BI_US, (rel[-1], al[-1]['dur'])


# ---------------- порядок элементов маяка, DMG Operation ----------------

WMI_SET_APPIE = 0x3f
RANK = {148: 7, 0x90: 8, 48: 9, 151: 11, 0: 18, 12: 22, 221: 0x101}    # табл. 9-45 (DMG Beacon)
RSN = bytes([48, 20, 1, 0]) + bytes([0x00, 0x0f, 0xac, 8]) + bytes([1, 0, 0x00, 0x0f, 0xac, 8]) + \
    bytes([1, 0, 0x00, 0x0f, 0xac, 2]) + bytes(2)
VS = bytes([221, 5, 0x00, 0x50, 0xf2, 4, 0x10])


def bcn_elements(frame):
    i = 0x1e + (8 if frame[0x17] & 1 else 0)
    out = []
    while i + 2 <= len(frame):
        out.append((frame[i], frame[i + 2:i + 2 + frame[i + 1]]))
        i += 2 + frame[i + 1]
    return out


def host_beacon_ies(fw, ies):
    """IE хоста для маяка (WMI_SET_APPIE, кадр 0) и пересборка маяка (add_bcon: маяк собирается при старте точки и
    по смене расписания)."""
    fw.wmi(WMI_SET_APPIE, struct.pack('<BBH', 0, 0, len(ies)) + ies)
    Fl.settle(fw)
    fw.call('add_bcon', fw.call('mid_list_by_mid_fw', 0))
    Fl.settle(fw)


def test_beacon_dmg_operation_cbap_only(fw):
    """11.1.3.3.1: маяк AP с CBAP Only = 1 содержит DMG Operation (TDDTI 0 — без расписания, MaxLostBeacons 4)."""
    ap(fw)
    t0 = len(fw.tx_frames)
    host_beacon_ies(fw, RSN + VS)
    el = bcn_elements(last_beacon(fw, t0))
    ops = [b for e, b in el if e == 151]
    assert len(ops) == 1 and ops[0][0] & 3 == 0 and ops[0][9] == 4, el
    assert [e for e, _ in el] == [48, 151, 221], el


def test_beacon_order_with_host_schedule(fw):
    """Расписание хоста (WMI_SCHEDULING_SCHEME) с IE хоста: ESE встаёт к IE хоста (RSN и Vendor Specific сохраняются),
    порядок — табл. 9-45 (ESE 8, RSN 9, DMG Operation 11, Vendor Specific — последний), DMG Operation TDDTI = 1."""
    ap(fw)
    host_beacon_ies(fw, VS + RSN)
    t0 = len(fw.tx_frames)
    fw.wmi(WMI_SCHEDULING_SCHEME, scheme_cmd([slot(5000, 1, 3000, 255, 255)]))
    Fl.settle(fw)
    el = bcn_elements(last_beacon(fw, t0))
    ids = [e for e, _ in el]
    assert ids == [0x90, 48, 151, 221], ids
    assert dict(el)[151][0] & 1 == 1


# Element ID (табл. 9-92) → порядковый номер в теле DMG Beacon (табл. 9-45) — выписано из стандарта, не из fw
BCN_TABLE_ORDER = {
    148: 7,     # DMG Capabilities
    144: 8,     # Extended Schedule
    48: 9,      # RSN
    71: 10,     # Multiple BSSID
    151: 11,    # DMG Operation
    147: 12,    # Next DMG ATI
    152: 13,    # DMG BSS Parameter Change
    158: 14,    # Multi-band
    143: 16,    # DMG Wakeup Schedule
    200: 17,    # UPSIM
    0: 18,      # SSID
    7: 20,      # Country
    12: 22,     # EDCA Parameter Set
    52: 24,     # Neighbor Report
    46: 26,     # QoS Capability
    60: 27,     # Extended Channel Switch Announcement
    145: 34,    # STA Availability
    160: 35,    # Next PCP List
    161: 36,    # PCP Handover
    190: 37,    # Antenna Sector ID Pattern
    221: 1000,  # Vendor Specific — последние
}


def test_beacon_host_ies_table_order(fw):
    """Элементы хоста маяка в обратном порядке (все известные табл. 9-45, кроме Awake Window — энергосбережения нет,
    и IBSS Parameter Set — не IBSS) — в маяке в порядке табл. 9-45 по Element ID табл. 9-92: Next DMG ATI (147) —
    после DMG Operation, DMG BSS Parameter Change (152) — до Multi-band, UPSIM (200) — до SSID, STA Availability
    (145), Next PCP List (160), PCP Handover (161) — после EDCA и до Antenna Sector ID Pattern."""
    ap(fw)
    order = sorted(BCN_TABLE_ORDER, key=BCN_TABLE_ORDER.get)
    host = b''.join(bytes([e, 2, e, 0x5a]) for e in reversed(order) if e not in (151, 144))
    t0 = len(fw.tx_frames)
    host_beacon_ies(fw, host)
    ids = [e for e, _ in bcn_elements(last_beacon(fw, t0))]
    assert ids == [e for e in order if e != 144], ids


def test_beacon_fits_control_phy_psdu(fw):
    """IE хоста маяка до предела WMI_SET_APPIE (1024 Б) и TDMA точки при SPARRAW_MAX_STA станциях (ESE до 257 Б):
    vendor собирал бикон без предела — запись за буфер TX 0x500 (указатель done следующего буфера) и бикон длиннее
    PSDU control PHY. PSDU бикона с FCS — не длиннее 1023 октетов (20.4.3.2.1: Length — 10 бит); не поместившиеся
    элементы — младшие по табл. 9-45 (Vendor Specific — последние); RSN и DMG Operation остаются."""
    w = ap(fw)
    vs = b''.join(bytes([221, 0xfd, 0x00, 0x50, 0xf2, i]) + bytes(0xf9) for i in range(3))   # 3 × 255 Б
    ies = RSN + vs
    ies += bytes([221, 1024 - len(ies) - 2]) + bytes(1024 - len(ies) - 2)
    assert len(ies) == 1024
    host_beacon_ies(fw, ies)
    for i in range(Fl.SPARRAW_MAX_STA):
        w.ap_sta_join(peer=sta_mac(i + 1), cid=i)
    bcn = last_beacon(fw)
    assert len(bcn) + 4 <= 1023, len(bcn)
    ids = [e for e, _ in bcn_elements(bcn)]
    assert 48 in ids and 151 in ids, ids
    assert not fw.wild
