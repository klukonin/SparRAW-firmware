# SPDX-License-Identifier: AGPL-3.0-or-later
"""Развёртка секторов SLS (ISS инициатора, RSS ответчика) — txss_program_tx_frame → bcon_txss_sweep_step →
ss_plan_next_sector → abft_send_ssw_feedback, против 802.11-2020: 9.3.1.15 (кадр SSW), 9.5.1 (поле SSW, рис. 9-846),
9.5.3 (поле SSW Feedback, рис. 9-848/9-849), 10.42.2.2 (CDOWN, LBIFS), 9.2.5.1 (Duration).

Кадр собирается из того, что uc отдаёт MAC:
- FIFO direct-TX (r33 — слово, r34 — байт): FC, Duration, RA (10 Б), затем 3 Б поля SSW Feedback; длина MPDU без FCS —
  команда 0x34 (b0..15); TA и поле SSW вставляет MAC;
- поле SSW — команда 0x2d, биты 0..23 в раскладке рис. 9-846 (Direction б0, CDOWN б1..9, Sector ID б10..15,
  DMG Antenna ID б16..17, RXSS Length б18..23);
- Duration — команда 0x15 (б24/26/28 — «буквально», abft.h H-LIT), значение в мкс в б0..23.
Эталон — формулы стандарта (TXTIME Control PHY 20.11.3, MBIFS/SBIFS/LBIFS 10.3.2.3), а не план развёртки uc."""
import math, os, re
import pytest

import ucemu

HERE = os.path.dirname(os.path.abspath(__file__))
REW = os.path.dirname(os.path.dirname(HERE))
A = ucemu.dccm_addrs(os.path.join(REW, 'uc', 'dccm.h'))


def _sta_max():
    """include/sta_max.h: SPARRAW_MAX_STA, SPARRAW_PEER_UNKNOWN (= MAX), SPARRAW_STA_SLOTS (= MAX + 1)."""
    t = open(os.path.join(REW, 'include', 'sta_max.h')).read()
    mx = int(re.search(r'#define\s+SPARRAW_MAX_STA\s+(\d+)u?', t).group(1))
    assert re.search(r'#define\s+SPARRAW_PEER_UNKNOWN\s+SPARRAW_MAX_STA\b', t)
    assert re.search(r'#define\s+SPARRAW_STA_SLOTS\s+\(SPARRAW_MAX_STA \+ 1u\)', t)
    return mx, mx, mx + 1


SPARRAW_MAX_STA, SPARRAW_PEER_UNKNOWN, SPARRAW_STA_SLOTS = _sta_max()

STA_TAB, STA_SZ = A['sta_tab'], 0x50          # struct sta_entry: +0x30 mac, +0x4c peer_n_ant
TXSS_SS, SS_SZ = A['txss_ss'], 0x4c           # struct ss_cfg_s: +0x08 order[64], +0x48 n_frames
SLS = A['sls']                                # struct sls_ctx_s: +0 best (sector_rec), +0x5c peer_mac, +0x68 maint
FWSH_N_RX_ANT, FWSH_TOTAL_SECTORS = 0x85728c, 0x85728d     # include/fwsh.h FWSH_A_*
HW_MAC_IFS_RIFS_SBIFS = 0x886d0c              # include/hw.h: SBIFS (мкс) в б24..31
FWSH_N_SETS = 0x857730 + 4 + 8                # fwsh_sets.n_sec[1][0] (RF_SETS_MAX 8) — число наборов RF
FWSH_SET_RANGES = 0x857730 + 0x80             # fwsh_sets.set_ranges — указатель на {первый, последний} по набору
SET_RANGES_TAB = 0x857f00                     # свободное место общей памяти под таблицу (нули)
PEER = bytes.fromhex('24181d243b0b')

# --- 802.11-2020: времена в тактах Tc = 1/1760 мкс (20.11.3, Table 20-30, 10.3.2.3) ---
TC_US = 1760
SBIFS, SIFS = 1 * TC_US, 3 * TC_US
MBIFS = 3 * SIFS                              # 10.3.2.3.10


def txtime_ctrl(length):
    """TXTIME Control PHY (MCS0), length — октеты PSDU с FCS (20.11.3; N_CW — 20.4.3.3.3), в Tc."""
    ncw = 1 + -(-((length - 6) * 8) // 168)
    return 6400 + 1152 + (11 * 8 + (length - 6) * 8 + ncw * 168) * 32


T_SSW = txtime_ctrl(26)                       # рис. 9-54: 2+2+6+6+3+3 + FCS 4
T_SSW_FB = txtime_ctrl(28)                    # рис. 9-55
T_SSW_ACK = txtime_ctrl(28)                   # рис. 9-56
LBIFS = T_SSW + 2 * SBIFS                     # 10.3.2.3.11


def ceil_us(tc):
    return -(-tc // TC_US)


def bits(v, lo, n):
    return (v >> lo) & ((1 << n) - 1)


def fc(v):
    """Frame Control (9.2.4.1, Table 9-2: Control Frame Extension в б8..11 при type 1 / subtype 6)."""
    return dict(type=bits(v, 2, 2), subtype=bits(v, 4, 4), ext=bits(v, 8, 4))


def ssw_field(v):
    """Рис. 9-846."""
    return dict(direction=bits(v, 0, 1), cdown=bits(v, 1, 9), sector=bits(v, 10, 6), antenna=bits(v, 16, 2),
                rxss_len=bits(v, 18, 6))


def fb_iss(b):
    """Рис. 9-848 (SSW Feedback в кадре ISS)."""
    v = int.from_bytes(b, 'little')
    return dict(total_sectors=bits(v, 0, 9), n_rx_ant=bits(v, 9, 2), res1=bits(v, 11, 5), poll=bits(v, 16, 1),
                res2=bits(v, 17, 7))


def fb_sel(b):
    """Рис. 9-849 (SSW Feedback вне ISS); SNR Report — 8-битное в доп. коде, 4×(SNR − 19) (9.5.3)."""
    v = int.from_bytes(b, 'little')
    snr = bits(v, 8, 8)
    return dict(sector=bits(v, 0, 6), antenna=bits(v, 6, 2), snr_q=snr - 256 if snr > 127 else snr,
                poll=bits(v, 16, 1), res=bits(v, 17, 7))


def snr_report_db(q):
    return q / 4 + 19


def tx_frames(uc):
    """Кадры direct-TX за последний вызов: [{'len': из 0x34, 'fifo': bytes}] между 0x33000001 и 0x33000002.
    r33 — слово FIFO; запись r33 после чтения r33 («or r33,r33,x», uc_fifo_frame_tail) дописывает то же слово."""
    out, cur, rmw = [], None, False
    for e in uc.last_trace:
        if e[0] != 'extreg':
            continue
        _, d, n, _, v = e
        if d == 'r':
            if n == 33:
                rmw = True
            continue
        if n == 32:
            if v == 0x33000001:
                cur = {'len': None, 'fifo': bytearray()}
            elif (v >> 24) == 0x34 and cur is not None and cur['len'] is None:
                cur['len'] = v & 0xffff
            elif v == 0x33000002 and cur is not None:
                cur['fifo'] = bytes(cur['fifo'])
                out.append(cur)
                cur = None
        elif n == 33 and cur is not None:
            if rmw:
                w = int.from_bytes(cur['fifo'][-4:], 'little') | v
                cur['fifo'][-4:] = w.to_bytes(4, 'little')
            else:
                cur['fifo'] += v.to_bytes(4, 'little')
            rmw = False
        elif n == 34 and cur is not None:
            cur['fifo'].append(v & 0xff)
    return out


def cmds(uc, op):
    return [c & 0xffffff for c in uc.mac_cmds if (c >> 24) == op]


# Ожидания событий/эфира — в юнит-тесте не исполняются. MAC «свободен»: r43/r45 б31 (MTP/TX готов), r47 б0 (FIFO
# direct-TX готов), r42 б15 (tx_end).
SWEEP_STUBS = {n: 0 for n in ('uc_wait_event_busy', 'mac_evt_enable_bit_sync_b', 'mac_evt_enable_bit_sync',
                              'uc_spin_until_event', 'uc_spin_until_event4', 'mac_set_rf_chain_state_with_sta_sector',
                              'mac_select_all_sectors_and_wait')}


def mac_ready(uc):
    uc.ext.update({42: 1 << 15, 43: 1 << 31, 45: 1 << 31, 47: 1})
    uc.w32(HW_MAC_IFS_RIFS_SBIFS, 1 << 24)       # aSBIFSTime = 1 мкс (Table 20-30)
    uc.w8(A['mac_mon_slot_idx'], 0)               # не инициализирована в эмуляторе (0/1 в работе): иначе счётчик
                                                  # mac_mon_slot[idx].tx_bcon пишет в ss_order_cur
    one_rf_set(uc)


def one_rf_set(uc):
    """Один набор RF, роль не AP: неинициализированная память эмулятора — не нули, задать явно."""
    uc.w32(A['uc_role_ap'], 0)
    uc.w8(FWSH_N_SETS, 1)
    uc.w32(FWSH_SET_RANGES, SET_RANGES_TAB)
    uc.wbytes(SET_RANGES_TAB, bytes(16))


def setup_sweep(uc, sta, order, peer_n_ant=1, total_sectors=None, n_rx_ant=1, mac=PEER):
    e = STA_TAB + STA_SZ * sta
    uc.wbytes(e + 0x30, mac)
    uc.w8(e + 0x4c, peer_n_ant)
    ss = TXSS_SS + SS_SZ * sta
    uc.wbytes(ss + 8, bytes(order) + (b'\xff' if len(order) < 64 else b''))
    uc.w8(ss + 0x48, len(order))
    uc.w8(FWSH_TOTAL_SECTORS, len(order) if total_sectors is None else total_sectors)
    uc.w8(FWSH_N_RX_ANT, n_rx_ant)
    mac_ready(uc)


def set_best(uc, sector, antenna, snr_db, snr_lin=1000):
    uc.w8(SLS, sector)
    uc.w8(SLS + 1, antenna)
    uc.w32(SLS + 4, snr_lin)
    uc.w32(SLS + 8, snr_db)


def sweep(uc, sta, responder):
    """ISS инициатора (b = 5, c = 0) или RSS ответчика (b = 1, c = 1); d = 0 — кадр SSW с RA = sta_tab[sta].mac."""
    r = uc.call('txss_program_tx_frame', sta, 1 if responder else 5, 1 if responder else 0, 0, 0, stub=SWEEP_STUBS)
    assert r == 1
    fr = tx_frames(uc)
    ssw = [ssw_field(c) for c in cmds(uc, 0x2d)]
    dur = cmds(uc, 0x15)
    assert len(fr) == len(ssw) == len(dur), (len(fr), len(ssw), len(dur))
    return fr, ssw, dur


def expected_cdown_and_duration(n, m):
    """Последовательность из n·m SSW (m повторов по n секторов через LBIFS, внутри — SBIFS; 10.42.2.2):
    CDOWN — «число оставшихся передач, включая LBIFS» (последний 0), Duration — до конца SSW с CDOWN 0 + MBIFS
    (9.3.1.15), мкс вверх (9.2.5.1)."""
    gaps = []                                   # зазор после кадра k
    for p in range(m):
        gaps += [SBIFS] * (n - 1) + ([LBIFS] if p < m - 1 else [])
    total = n * m
    rest = [0] * total
    for k in range(total - 2, -1, -1):
        rest[k] = rest[k + 1] + gaps[k] + T_SSW
    dur = [ceil_us(r + MBIFS) for r in rest]
    cd = []
    for k in range(total):
        cd.append((total - 1 - k) + (m - 1 - k // n))   # оставшиеся кадры + оставшиеся LBIFS
    return cd, dur


SECTOR_COUNTS = [1, 2, 4, 16, 32, 63, 64]


@pytest.mark.parametrize('n', SECTOR_COUNTS)
def test_iss_ssw_field_cdown_sector_direction(uc, n):
    """10.42.2.2: ISS из n секторов — n кадров SSW, CDOWN n−1 … 0 (0 в последнем, 9.5.1), Sector ID — сектор
    передачи по плану, Direction = 0 (инициатор), RXSS Length вне CBAP — резерв = 0 (9.5.1, 9.2.2)."""
    order = [(7 * i + 3) % 64 for i in range(n)] if n < 64 else list(range(63, -1, -1))
    setup_sweep(uc, 2, order)
    fr, ssw, _ = sweep(uc, 2, responder=False)
    assert len(ssw) == n
    assert [s['cdown'] for s in ssw] == list(range(n - 1, -1, -1))
    assert [s['sector'] for s in ssw] == order
    assert all(s['direction'] == 0 and s['antenna'] == 0 and s['rxss_len'] == 0 for s in ssw)


@pytest.mark.parametrize('n', [1, 16, 64])
def test_iss_ssw_frame_header(uc, n):
    """9.3.1.15: кадр SSW — Control Frame Extension 1000 (Table 9-2), RA — адрес ответчика, длина без FCS 22 октета
    (рис. 9-54)."""
    setup_sweep(uc, 3, list(range(n)))
    fr, _, _ = sweep(uc, 3, responder=False)
    for f in fr:
        assert f['len'] == 22
        assert len(f['fifo']) == 13                      # FC, Duration, RA + SSW Feedback (TA и SSW — MAC)
        assert fc(int.from_bytes(f['fifo'][0:2], 'little')) == dict(type=1, subtype=6, ext=8)
        assert f['fifo'][4:10] == PEER


@pytest.mark.parametrize('n', SECTOR_COUNTS)
@pytest.mark.parametrize('m', [1, 2, 3])
def test_ssw_duration_any_sector_count(uc, n, m):
    """9.3.1.15: Duration SSW (не A-BFT) — до конца SSW с CDOWN 0 плюс MBIFS; 9.2.5.1 — мкс вверх. Должно быть
    точно для любого числа секторов (1..64) и повторов ISS по антеннам ответчика (LBIFS, 10.42.2.2)."""
    setup_sweep(uc, 1, list(range(n)), peer_n_ant=m)
    _, ssw, dur = sweep(uc, 1, responder=False)
    _, want = expected_cdown_and_duration(n, m)
    assert dur == want


@pytest.mark.parametrize('n', [1, 4, 64])
@pytest.mark.parametrize('m', [2, 3])
def test_iss_repetition_per_responder_antenna(uc, n, m):
    """10.42.2.2: ответчик с m DMG-антеннами — ISS повторяется m раз (LBIFS между повторами), CDOWN — «total number
    of transmissions remaining … including any LBIFS», последний кадр CDOWN = 0; сектора каждого повтора — тот же
    план."""
    order = list(range(n))
    setup_sweep(uc, 0, order, peer_n_ant=m)
    _, ssw, _ = sweep(uc, 0, responder=False)
    assert len(ssw) == n * m
    want_cd, _ = expected_cdown_and_duration(n, m)
    assert [s['cdown'] for s in ssw] == want_cd
    assert ssw[-1]['cdown'] == 0
    assert [s['sector'] for s in ssw] == order * m


@pytest.mark.parametrize('n,m', [(1, 1), (16, 1), (64, 1), (32, 2), (64, 3), (32, 4)])
def test_iss_feedback_field_total_sectors(uc, n, m):
    """9.5.3 рис. 9-848: в кадрах ISS — Total Sectors in ISS = число секторов ISS «including any repetition» − 1
    (0..511 ↔ 1..512), Number of RX DMG Antennas = число своих RX-антенн для RSS − 1; Poll Required и резерв = 0."""
    setup_sweep(uc, 2, list(range(n)), peer_n_ant=m, n_rx_ant=2)
    fr, ssw, _ = sweep(uc, 2, responder=False)
    for f in fr:
        fb = fb_iss(f['fifo'][10:13])
        assert fb['total_sectors'] == len(ssw) - 1 == n * m - 1
        assert fb['n_rx_ant'] == 1
        assert (fb['res1'], fb['poll'], fb['res2']) == (0, 0, 0)


@pytest.mark.xfail(strict=True, reason='9.5.3: Total Sectors in ISS берётся из fwsh_total_sectors (Capability), '
                   'а не из числа секторов этой ISS (txss_ss[].n_frames) — uc/txss.c:538')
@pytest.mark.parametrize('n,cap', [(16, 64), (8, 32), (64, 32)])
def test_iss_total_sectors_matches_actual_sweep(uc, n, cap):
    """9.5.3: «The Total Sectors in ISS subfield indicates the total number of sectors that the initiator uses in the
    ISS». План ISS сокращён (wmi txss_set_sectors_number / update_sector_sweep_frames_number) — поле должно
    описывать фактическую ISS (n кадров), а не Total Number of Sectors из DMG Capabilities (cap)."""
    setup_sweep(uc, 2, list(range(n)), total_sectors=cap)
    fr, ssw, _ = sweep(uc, 2, responder=False)
    assert len(ssw) == n
    assert all(fb_iss(f['fifo'][10:13])['total_sectors'] == n - 1 for f in fr)


@pytest.mark.parametrize('sta', [0, SPARRAW_MAX_STA - 1, SPARRAW_PEER_UNKNOWN])
@pytest.mark.parametrize('n', [1, 8, 64])
def test_rss_responder_sweep(uc, sta, n):
    """10.42.2.3 (RSS): Direction = 1, CDOWN n−1 … 0 при одной антенне инициатора, Sector ID — план; RA — адрес
    инициатора (у неизвестного пира — запись SPARRAW_PEER_UNKNOWN, куда txss_resp_flow кладёт sls.peer_mac).
    SSW Feedback — рис. 9-849: Sector Select / DMG Antenna Select — лучший кадр ISS, SNR Report = 4×(SNR−19)."""
    mac = bytes.fromhex('26181d26d47b')
    order = list(range(64 - n, 64))
    setup_sweep(uc, sta, order, mac=mac)
    set_best(uc, 45, 2, 27)
    fr, ssw, dur = sweep(uc, sta, responder=True)
    assert [s['cdown'] for s in ssw] == list(range(n - 1, -1, -1))
    assert [s['sector'] for s in ssw] == order
    assert all(s['direction'] == 1 and s['rxss_len'] == 0 for s in ssw)
    assert dur == expected_cdown_and_duration(n, 1)[1]
    for f in fr:
        assert f['len'] == 22
        assert fc(int.from_bytes(f['fifo'][0:2], 'little')) == dict(type=1, subtype=6, ext=8)
        assert f['fifo'][4:10] == mac
        fb = fb_sel(f['fifo'][10:13])
        assert (fb['sector'], fb['antenna'], fb['poll'], fb['res']) == (45, 2, 0, 0)
        assert snr_report_db(fb['snr_q']) == 27


@pytest.mark.parametrize('n,m', [(4, 2), (64, 2)])
def test_rss_cdown_multi_antenna_initiator(uc, n, m):
    """10.42.2.3: «… multiplied by the number of DMG antennas at the initiator …», последний SSW RSS — CDOWN 0,
    между полными развёртками на разные антенны инициатора — LBIFS (CDOWN считает и его)."""
    setup_sweep(uc, 4, list(range(n)), peer_n_ant=m)
    set_best(uc, 1, 0, 19)
    _, ssw, dur = sweep(uc, 4, responder=True)
    want_cd, want_dur = expected_cdown_and_duration(n, m)
    assert [s['cdown'] for s in ssw] == want_cd
    assert dur == want_dur


@pytest.mark.parametrize('snr_db', [-13, 0, 19, 20, 50])
def test_rss_snr_report_in_range(uc, snr_db):
    """9.5.3: SNR Report — 8 бит доп. код, 4×(SNR−19); диапазон −13 … 50,75 дБ."""
    setup_sweep(uc, 0, [5])
    set_best(uc, 5, 0, snr_db)
    fr, _, _ = sweep(uc, 0, responder=True)
    assert snr_report_db(fb_sel(fr[0]['fifo'][10:13])['snr_q']) == snr_db


@pytest.mark.xfail(strict=True, reason='9.5.3: SNR Report не насыщается — (u8)((snr_db − 19) << 2) переполняется '
                   'вне −13…50,75 дБ и сообщает SNR другого знака (uc/txss.c:535, тот же код в txss.c:772, tail.c:3034)')
@pytest.mark.parametrize('snr_db', [51, 63, -14, -40])
def test_rss_snr_report_out_of_range_saturates(uc, snr_db):
    """9.5.3: «encoded as 8-bit 2s complement value of 4×(SNR−19) … This covers from –13 dB to 50.75 dB». SNR вне
    диапазона кодируется ближайшим представимым (50,75 / −13 дБ), а не по модулю 256 (SNR 63 дБ → −92 → «−4 дБ»).
    snr_db −64…63 даёт rx_flow_measure_snr_select_best (9-битный отсчёт PHY / 4)."""
    setup_sweep(uc, 0, [5])
    set_best(uc, 5, 0, snr_db)
    fr, _, _ = sweep(uc, 0, responder=True)
    got = snr_report_db(fb_sel(fr[0]['fifo'][10:13])['snr_q'])
    assert got == (50.75 if snr_db > 50 else -13)


@pytest.mark.parametrize('sector', [0, 1, 31, 62, 63])
def test_ssw_sector_id_full_range(uc, sector):
    """9.5.1: Sector ID — 6 бит (0..63) — не задевает соседние CDOWN и DMG Antenna ID."""
    setup_sweep(uc, 0, [sector, 63 - sector])
    _, ssw, _ = sweep(uc, 0, responder=False)
    assert [s['sector'] for s in ssw] == [sector, 63 - sector]
    assert [s['cdown'] for s in ssw] == [1, 0]
    assert all(s['antenna'] == 0 and s['rxss_len'] == 0 for s in ssw)


@pytest.mark.xfail(strict=True, reason='9.5.1: CDOWN — 9 бит (0..511), а счётчик развёртки u8: при 64 секторах × 4 '
                   'антеннах пира (256 SSW + 3 LBIFS) начальный CDOWN усекается до 259 & 0xff — uc/txss.c:505, '
                   'uc/txss.c:564 ((u8)(…)), ss_plan_cdown u8 (uc/dccm.h:1927, uc/tail.c:3553)')
@pytest.mark.parametrize('responder', [False, True], ids=['iss', 'rss'])
def test_cdown_beyond_255_frames(uc, responder):
    """9.5.1: «Possible values range from 0 to 511»; 10.42.2.2/10.42.2.3: 64 сектора × 4 DMG-антенны пира (Number of
    RX DMG Antennas до 4, рис. 9-848) — 256 SSW, CDOWN считает и LBIFS; последний CDOWN 0, Duration до него (9.3.1.15).
    Развёртка не должна обрываться/путаться на любом числе секторов и антенн."""
    n, m = 64, 4
    setup_sweep(uc, 1, list(range(n)), peer_n_ant=m)
    if responder:
        set_best(uc, 0, 0, 19)
    _, ssw, dur = sweep(uc, 1, responder=responder)
    want_cd, want_dur = expected_cdown_and_duration(n, m)
    assert len(ssw) == n * m
    assert [s['cdown'] for s in ssw] == want_cd
    assert dur == want_dur
