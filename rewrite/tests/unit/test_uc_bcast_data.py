# SPDX-License-Identifier: AGPL-3.0-or-later
"""Групповые данные точки (tx_bcast_flow — широковещательное кольцо, очередь fsched_peer_id) без DMG CTS-to-self.

802.11-2020 защиты группового кадра не требует: NAV distribution (10.3.2.15) — «the node may first transmit … DMG
CTS-to-self», в TXOP — «any frames required for protection» (10.23.2.8 c); групповой кадр без ответа (Ack Policy —
No Ack у групповых, 10.3.2.11) уходит по доступу к среде (CBAP, 10.39.5; EDCA 10.23.2). vendor перед каждым групповым
кадром слал DMG CTS-to-self с TA = MAC станции (9.3.1.13 требует адрес группы следующего кадра, его uc до пуска не
знает); стенд 2026-11-04…06 (PMC): TA станции или 06:00:00:00:00:00 — CTS-to-self убран.

Слой 1 — tx_bcast_flow отдельно (команды MAC, кадры FIFO): ни одного кадра FIFO, один пуск 0x19000001 — групповой кадр
из очереди, режим доступа 5 (первый кадр после CCA), сектор станции из обхода x0c (sta_tab[].tx_sel), пустая маска —
сектор 1. Слой 2 — два узла в живом эфире (fw + uc, air.Air): AP шлёт групповые кадры кольца WMI_BCAST_VRING_CFG,
станция одновременно шлёт данные точке — групповые кадры у станции приняты, перед ними нет DMG CTS-to-self точки."""
import struct

import pytest

import fwflows as F

STA_TAB = 0x801104                     # struct sta_entry[SPARRAW_STA_SLOTS], 0x50 Б: tx_sel +0x08, MAC +0x30
MAINT_STA_MASK = 0x80212c + 0x68       # sls.maint_sta_mask
FSCHED_PEER_ID = 0x800468
BCAST_X0C = 0x802eac + 0xc
BCAST_TX1 = 0x802eac + 3
TX_BCAST_DESC_ID = 0x8005b0
RF_CHAIN_CFG = 0x80051c
BCAST_QID = 0x1a                       # широковещательное кольцо (любое qid ≠ 0x1f/0xff)

STA = [bytes.fromhex('24181d26d47b'), bytes.fromhex('26181d2600aa'), bytes.fromhex('02aabbccdd03')]
SECTOR = [0x12, 0x07, 0x2c]            # TX-сектор станции: tx_sel [22:8]

STUBS = {n: 0 for n in ('mac_select_all_sectors_and_wait', 'mac_set_rf_chain_state',
                        'uc_spin_until_event', 'uc_wait_one_event', 'mac_evt_enable_bit_sync_b',
                        'uc_log_emit_snapshot', 'mac_program_tx_with_qid', 'qh_read_desc_window', 'macq_desc_read_uc',
                        'macq_desc_write_uc', 'tx_ctx_alloc_next', 'uc_assert', 'uc_wait_direct_tx_ready')}
STUBS.update(macq_probe_empty=1)


def run(uc, mask, x0c=0):
    """Один вызов tx_bcast_flow: команды MAC (r32) и записи портов FIFO (r33/r34)."""
    uc.ext.update({47: 1 << 31, 43: (1 << 31) | (1 << 8), 53: 1 << 2})   # MTP_AGGREGATION, ответ MTP (MCS 1), BAP
    for i, mac in enumerate(STA):
        uc.wbytes(STA_TAB + i * 0x50 + 0x30, mac)
        uc.w32(STA_TAB + i * 0x50 + 8, 0x30 | SECTOR[i] << 8)
    uc.w32(RF_CHAIN_CFG, 0)
    uc.w8(MAINT_STA_MASK, mask)
    uc.w32(FSCHED_PEER_ID, BCAST_QID)
    uc.w32(BCAST_X0C, x0c)
    uc.w8(BCAST_TX1, 0)
    uc.w16(TX_BCAST_DESC_ID, 0)
    for i in range(4):
        uc.w32(TXOP_LIMIT_US + 4 * i, 2000)
    start = len(uc.cpu.trace)
    uc.call('tx_bcast_flow', 0, stub=STUBS, max_steps=400_000)
    seq = uc.cpu.trace[start:]
    tr = [e for e in seq if e[0] == 'extreg' and e[1] == 'w']
    cmds = [e[4] for e in tr if e[2] == 32]
    fifo = [(e[2], e[4]) for e in tr if e[2] in (33, 34)]
    lim = [(i, e) for i, e in enumerate(seq) if e[0] == 'mmio' and e[1] == 'w']
    first_cmd = next(i for i, e in enumerate(seq) if e[0] == 'extreg' and e[1] == 'w' and e[2] == 32)
    assert lim and lim[0][0] < first_cmd, 'лимит TXOP 0 — до первой команды MAC (CCA, MTP)'
    assert not [c for c in cmds if c >> 24 == 0x15], [hex(c) for c in cmds]
    check_txop_limit(lim)
    return cmds, fifo


def check_group_tx(cmds, fifo, sector):
    """Групповой кадр — без кадра FIFO (DMG CTS-to-self): FIFO не открывался (0x33000001), портов r33/r34 нет; один
    пуск 0x19000001 после программы TX режимом 5 (команда 0x06 режима: a | б8 | б25 | б26) на сектор sector."""
    assert 0x33000001 not in cmds and 0x33000002 not in cmds and not fifo, \
        'кадр FIFO перед групповым кадром (DMG CTS-to-self): %s' % [hex(c) for c in cmds if c >> 24 == 0x33]
    go = [i for i, c in enumerate(cmds) if c == 0x19000001]
    assert len(go) == 1, [hex(c) for c in cmds]
    mode = [c for c in cmds[:go[0]] if c & ~0xff == (1 << 8) | (1 << 25) | (1 << 26)]
    assert mode and mode[-1] & 0xff == 5, 'режим пуска %s — не 5 (первый кадр после CCA)' % [hex(c) for c in mode]
    sel = [c & 0xffffff for c in cmds[:go[0]] if c >> 24 == 0x3f]
    assert sel and (sel[-1] >> 8) & 0x7fff == sector, (hex(sel[-1]) if sel else None, sector)
    # H-TXVEC5 (стенд 2026-11-06: ключ и запрос MTP между CCA и программой TX — uc assert 0x26): программа TX
    # (mac_program_tx_vector: 0x1f006000 … команда режима) — сразу после проверки CCA 0x29000001
    cca = cmds.index(0x29000001)
    assert cmds[cca + 1] == 0x1f006000 and cmds[cca + 4] & 0xff0001ff == 0x06000105, \
        'после CCA до программы TX: %s' % [hex(c) for c in cmds[cca + 1:cca + 8]]


TXOP_LIMIT_US = 0x80294c                # txop_limit_us[4] (LMAC 0x21)
HW_MAC_TXOP_LIMIT_0, HW_MAC_TXOP_LIMIT_1 = 0x886f70, 0x886f74


def check_txop_limit(lim):
    """9.2.5.2 a) 6) i): Duration группового кадра — 0. H-DURG: MAC ставит групповому кадру очереди остаток лимита TXOP
    (стенд 2026-11-07: 1997; 0x15 перед кадром не действует — стенд bdur0). H-DURLIM0: на время вызова лимит 0 в обоих
    регистрах — до CCA и запроса MTP; после кадра — значения LMAC 0x21; 0x15 в пути нет."""
    w = [(i, e[2], e[4]) for i, e in lim if e[2] in (HW_MAC_TXOP_LIMIT_0, HW_MAC_TXOP_LIMIT_1)]
    assert [(a, v) for _, a, v in w[:2]] == [(HW_MAC_TXOP_LIMIT_0, 0), (HW_MAC_TXOP_LIMIT_1, 0)], w
    assert [(a, v) for _, a, v in w[2:]] == [(HW_MAC_TXOP_LIMIT_0, 2000 << 16 | 2000),
                                             (HW_MAC_TXOP_LIMIT_1, 2000 | 2000 << 16)], w


@pytest.mark.parametrize('mask,idx', [(0x1, 0), (0x2, 1), (0x5, 2), (0x7, 2)])
def test_group_data_without_cts_to_self(uc, mask, idx):
    """Копия группового кадра — на TX-сектор старшей станции обхода (x0c = maint_sta_mask), без DMG CTS-to-self."""
    cmds, fifo = run(uc, mask)
    check_group_tx(cmds, fifo, SECTOR[idx])
    assert uc.r8(BCAST_TX1) == 0
    assert uc.r32(BCAST_X0C) == mask & ~(1 << idx)


def test_group_data_copy_per_station(uc):
    """Две станции — две копии кадра (два вызова), каждая на сектор своей станции, ни перед одной CTS-to-self нет."""
    cmds, fifo = run(uc, 0x3)
    check_group_tx(cmds, fifo, SECTOR[1])
    cmds, fifo = run(uc, 0x3, uc.r32(BCAST_X0C))
    check_group_tx(cmds, fifo, SECTOR[0])
    assert uc.r32(BCAST_X0C) == 0


def test_group_data_empty_mask(uc):
    """Станций в обходе нет (maint_sta_mask = 0): один пуск на сектор 1, без CTS-to-self и без чтения sta_tab за
    концом (индекс 30)."""
    cmds, fifo = run(uc, 0)
    check_group_tx(cmds, fifo, 1)


# ---- два узла: групповые данные точки и встречные данные станции ----

def bcast_vring_cfg_cmd(ringid, size=0x400, mpdu=0x800):
    """WMI_BCAST_VRING_CFG (struct wmi_bcast_vring_cfg_cmd): ADD, кольцо ringid, 802.3."""
    b = bytearray(0x14)
    struct.pack_into('<IQHH', b, 0, 0, 0x20000000 + 0x10000 * ringid, size, mpdu)
    b[0x10] = ringid
    return bytes(b)


BCAST_VR = 2
GROUP = [b'\xff' * 6, bytes.fromhex('01005e7ffffa'), bytes.fromhex('333300000016')]


HOST_IE = bytes([70, 5, 1, 0, 0, 0, 0])   # элемент хоста 7 Б (RM Enabled Capabilities) в кадрах ассоциации


def _live_group(fw_elf, build_dir, uc_fw, host_ie=False, max_us=20000):
    """Два узла: AP шлёт групповые кадры кольца WMI_BCAST_VRING_CFG, станция одновременно — данные точке.
    host_ie — элемент хоста (WMI_SET_APPIE) в Probe/Assoc Request/Response обоих узлов: длиннее кадры ассоциации —
    другое взаимное время дальнейшего обмена (на нём групповой кадр попадал станции в rx_get_required_response)."""
    import test_air
    mp = pytest.MonkeyPatch()
    if host_ie:
        orig = F.Fw.set_mac

        def set_mac(self, mac):
            orig(self, mac)
            for t in (2, 3, 4):                             # WMI_SET_APPIE: Probe Response, Assoc Request/Response
                self.fw.wmi(0x3f, struct.pack('<BBH', t, 0, len(HOST_IE)) + HOST_IE)
        mp.setattr(F.Fw, 'set_mac', set_mac)
    try:
        r = test_air._live_data(fw_elf, build_dir, uc_fw)
    finally:
        mp.undo()
    air, ap, sta = r['air'], r['ap'], r['sta']
    n_ev = len(ap.fw.wmi_evts)
    ap.wmi(F.WMI_BCAST_VRING_CFG, bcast_vring_cfg_cmd(BCAST_VR))
    done = [e for e in ap.fw.wmi_evts[n_ev:] if e.id == F.WMI_VRING_CFG_DONE]
    air.run_us(2000)
    t0 = ap.hw.now
    n_rx, n_ap_rx, n_frames = len(sta.host_rx), len(ap.host_rx), len(air.frames)
    group = [bytes([0x40 + i]) * (200 + 50 * i) for i in range(len(GROUP))]
    up = [bytes([0x80 + i]) * 1200 for i in range(4)]
    nav = []                                                # NAV станции по кадрам точки (air → machw.air_rx)
    rx0 = sta.hw.air_rx

    def air_rx(t, n, what='', nav_us=0, **kw):
        nav.append((t, what, nav_us))
        return rx0(t, n, what, nav_us=nav_us, **kw)
    sta.hw.air_rx = air_rx
    for da, p in zip(GROUP, group):
        ap.host_tx(BCAST_VR, da, p)
    for p in up:                                            # встречный поток: станция → точка в то же время
        sta.host_tx(0, ap.mac, p)
    ap.pump()
    sta.pump()
    for _ in range(max_us // 500):
        air.run_us(500)
        if len(sta.host_rx) - n_rx >= len(group) and len(ap.host_rx) - n_ap_rx >= len(up):
            break
    sta.hw.air_rx = rx0
    return dict(air=air, ap=ap, sta=sta, done=done, t0=t0, group=group, up=up, nav=nav,
                rx=sta.host_rx[n_rx:], ap_rx=ap.host_rx[n_ap_rx:], frames=air.frames[n_frames:])


@pytest.fixture(scope='module')
def live_group(fw_elf, build_dir, uc_fw):
    return _live_group(fw_elf, build_dir, uc_fw)


pytestmark_live = pytest.mark.xdist_group('live_group')


@pytestmark_live
def test_live_group_data_delivered(live_group):
    """Групповые кадры кольца WMI_BCAST_VRING_CFG точки приняты станцией (RA — группа, From DS), встречные данные
    станции — точкой; MAC без поздних ответов."""
    r = live_group
    assert r['done'] and r['done'][0].body[1] == 0, r['done']
    got = [f for _, f in r['rx']]
    for da, p in zip(GROUP, r['group']):
        assert any(f[4:10] == da and f.endswith(p) for f in got), ('групповой кадр %s не принят' % da.hex(':'),
                                                                   [f[:24].hex() for f in got])
    ap_got = [f for _, f in r['ap_rx']]
    assert all(any(f.endswith(p) for f in ap_got) for p in r['up']), len(ap_got)
    assert not r['ap'].hw.late and not r['sta'].hw.late


@pytestmark_live
def test_live_group_data_no_cts_to_self(live_group):
    """9.3.1.13 / 10.3.2.15: в эфире нет DMG CTS-to-self точки (DMG CTS: FC Type 1, Subtype 6, Control Frame
    Extension 5; RA = свой адрес) — ни перед групповыми кадрами, ни вообще."""
    r = live_group
    ap = r['ap']
    cts_self = [f for f in r['frames'] if f['src'] is ap and len(f['frame']) >= 16 and
                int.from_bytes(f['frame'][0:2], 'little') & 0xfff == 0x564 and f['frame'][4:10] == bytes(ap.mac)]
    assert not cts_self, [(f['start'], f['frame'].hex()) for f in cts_self]
    grp = [f for f in r['frames'] if f['src'] is ap and f.get('mpdus') is None and len(f['frame']) >= 24 and
           (f['frame'][0] >> 2) & 3 == 2 and f['frame'][4] & 1]
    assert len(grp) >= len(GROUP), [f['what'] for f in r['frames'] if f['src'] is ap]


@pytestmark_live
def test_live_group_data_duration_zero(live_group):
    """802.11-2020 9.2.5.2 a) 6) i): групповой кадр — последний кадр TXOP (за доступ точка шлёт один кадр), Duration —
    0; станция по нему NAV не ставит (10.3.2.4: NAV — по Duration кадра не себе). Стенд 2026-11-07 до правки: 1997
    (остаток лимита TXOP MAC, H-DURG) — станции молчали ~2 мс после каждого группового кадра. Одноадресные TXOP
    станции и точки при этом идут (данные приняты, test_live_group_data_delivered)."""
    r = live_group
    ap = r['ap']
    grp = [f for f in r['frames'] if f['src'] is ap and f.get('mpdus') is None and len(f['frame']) >= 24 and
           (f['frame'][0] >> 2) & 3 == 2 and f['frame'][4] & 1]
    assert grp
    durs = [int.from_bytes(f['frame'][2:4], 'little') for f in grp]
    assert durs == [0] * len(grp), list(zip([f['what'] for f in grp], durs))
    starts = {f['start'] for f in grp}
    nav = [n for t, _, n in r['nav'] if t in starts]
    assert len(nav) == len(grp) and not any(nav), (nav, len(grp))
    sta = r['sta']
    uni = [int.from_bytes(f['frame'][2:4], 'little') for f in r['frames'] if f['src'] is sta and
           len(f['frame']) >= 24 and (f['frame'][0] >> 2) & 3 == 2 and not f['frame'][4] & 1]
    assert uni and all(uni), uni                            # одноадресные данные станции — Duration MAC (H-DURQ)


# ---- групповой кадр станции при другом времени обмена; ожидание BAP с пределом ----

from fwsh_addr import UC_WAIT          # noqa: E402  include/fwsh.h fwsh_uc_wait: +0 tmo_cnt, +4 last_marker, +8 last_tsf
UC_WAIT_MARKER = 0x800628               # uc_wait_marker


def _group_ok(r):
    got = [f for _, f in r['rx']]
    lost = [da.hex(':') for da, p in zip(GROUP, r['group']) if not any(f[4:10] == da and f.endswith(p) for f in got)]
    ap_got = [f for _, f in r['ap_rx']]
    up_lost = [i for i, p in enumerate(r['up']) if not any(f.endswith(p) for f in ap_got)]
    return lost, up_lost


@pytestmark_live
def test_live_group_data_shifted(fw_elf, build_dir, uc_fw):
    """Тот же обмен, кадры ассоциации длиннее на элемент хоста (7 Б) — иное взаимное время. Прежде групповой кадр
    точки станция принимала как адресованный ей (модель MAC не ставила r38 mcast/bcast — H-RXGRP), ждала
    MAC_BAP_RX_UPDATE (r53 б3) без предела и висела в rx_get_required_response (метка 0xff31); дальше станция ничего
    не передавала. Теперь: групповые кадры приняты, встречные данные доставлены, срывов ожиданий нет."""
    r = _live_group(fw_elf, build_dir, uc_fw, host_ie=True)
    sta = r['sta']
    assert _group_ok(r) == ([], []), (_group_ok(r), sta.uc.where(sta.uc.cpu.pc))
    assert sta.uc.r32(UC_WAIT) == 0 and r['ap'].uc.r32(UC_WAIT) == 0
    assert not r['ap'].hw.late and not sta.hw.late


@pytestmark_live
def test_live_bap_rx_wait_bounded(fw_elf, build_dir, uc_fw, monkeypatch):
    """Ожидание MAC_BAP_RX_UPDATE (r53 б3) с пределом: событие не приходит — групповой кадр без битов mcast/bcast в
    отчёте (прежний пробел модели, H-RXGRP снят), BAP его не отмечает. uc станции выходит по пределу (aPPDUMaxTime +
    SIFS), метка 0xff31 и счётчик в fwsh_uc_wait, ответа на кадр нет, связь идёт дальше: встречные данные станции
    доставлены точке (без пересчёта тени счётчика PPDU по r40 после срыва — нет: кадры, принятые PHY за время
    ожидания, uc не видел, и каждый следующий DMG CTS точки принимал за «нет события»). Прежде — вечный опрос (uc
    станции больше ничего не передавал)."""
    import air
    monkeypatch.setattr(air, 'r38_group', lambda ra: 0)
    r = _live_group(fw_elf, build_dir, uc_fw, host_ie=True, max_us=40000)
    sta = r['sta']
    # _live_group кончает прогон, как только всё доставлено; станция могла войти в ожидание незадолго до этого (open
    # с fix/uc-spin-bound, 2026-11-07, и позже: одно ожидание с 22557 мкс, прогон кончился в 23165 — предел не успевал истечь, тест падал).
    # Предел — BAP_RX_WAIT_PASSES проходов, задуман как нижняя граница aPPDUMaxTime + SIFS (проход ≥ 4 тактов); в модели
    # проход с чтением r53 дороже — выход по пределу через ~3,5 мс (26066 мкс). Досчитываем эфир, пока станция в
    # ожидании, до 10 мс: одно ожидание, выход по пределу, повторного входа нет.
    for _ in range(20):
        if sta.uc.r32(UC_WAIT_MARKER) != 0xff31:
            break
        r['air'].run_us(500)
    assert sta.uc.r32(UC_WAIT) >= 1, 'предел не сработал: %s' % sta.uc.where(sta.uc.cpu.pc)
    assert sta.uc.r32(UC_WAIT + 4) == 0xff31
    assert sta.uc.r32(UC_WAIT_MARKER) == 0
    assert 'rx_get_required_response' not in sta.uc.where(sta.uc.cpu.pc)
    assert _group_ok(r)[1] == [], _group_ok(r)
