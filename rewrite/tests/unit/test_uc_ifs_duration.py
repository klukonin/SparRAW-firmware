# SPDX-License-Identifier: AGPL-3.0-or-later
"""Duration кадров, которые строит uc, против 802.11-2020: SSW (9.3.1.15), SSW-Feedback (9.3.1.16), SSW-Ack
(9.3.1.17), Grant Ack (9.3.1.18), ответный CF-End DMG (9.3.1.6, 10.23.2.10); округление вверх и 0 вместо
отрицательного — 9.2.5.1. TXTIME — формула control mode (20.11.3), IFS — Table 20-30 / 10.3.2.3.

Duration в эфир задаёт команда MAC 0x15 (значение [15:0], биты 24/26/28) с последующей 0x14000007 — «буквально»
(uc/abft.h). Эталон считается здесь из стандарта (дроби, без тактов uc), а не из макросов uc/ifs.h."""
from fractions import Fraction
import pytest

from test_uc_ifs_mac import (A_SIFS_US, A_SBIFS_US, MBIFS_US, ctrl_txtime_us, ceil_us, lmac_mac_cfg)

SSW_LEN, SSW_FB_LEN, SSW_ACK_LEN, CF_END_LEN, GRANT_ACK_LEN = 26, 28, 28, 20, 27   # 9.3.1.15/16/17/6/18 (с FCS)
LBIFS_US = ctrl_txtime_us(SSW_LEN) + 2 * A_SBIFS_US                                # 10.3.2.3.11

TXSS_SS, SS_SZ = 0x802b68, 0x4c        # txss_ss[sta]: struct ss_cfg_s (include/lmac_cmd.h)
STA_TAB, STA_SZ = 0x801104, 0x50
BF_STA = 0x801ffc
RX_BUF_DURATION = 0x804012
SLS_MAINT = 0x80212c + 0x68
HW_MAC_USEC_TO_TBTT = 0x886ec0
MAC_MON_SLOT_IDX = 0x801080


def durations(uc):
    """Значения Duration из команд 0x15 за последний вызов."""
    out = []
    for c in uc.mac_cmds:
        if c >> 24 == 0x15:
            assert c & 0xff0000 == 0, 'мусор в [23:16] команды Duration: %#x' % c
            out.append(c & 0xffff)
    return out


def frame_duration_ok(d):
    assert 0 <= d < 0x8000, 'Duration %#x вне 0..32767 (Table 9-9)' % d


# ---- SSW в ISS/RSS -------------------------------------------------------------------------------------------

SWEEP_STUBS = {n: 0 for n in (
    'direct_tx_program_cmd34', 'mac_program_tx_common', 'mac_evt_enable_bit_sync_b', 'mac_evt_enable_bit_sync',
    'uc_spin_until_event', 'uc_spin_until_event4', 'mac_set_rf_chain_state_with_sta_sector', 'bcon_tx_ack_cmds',
    'mac_evt_select_timer_group', 'uc_send_evt_ps_awake_peer', 'uc_wait_event_busy', 'mac_cmd_29000001',
    'mac_select_all_sectors_and_wait', 'mac_program_rx_window', 'mac_program_tx_beacon')}


CDOWN_U8 = ('802.11-2020 9.5.1 (CDOWN — 9 бит, 0..511), 10.42.2.2.2 (CDOWN — все оставшиеся передачи ко всем антеннам '
            'пира, с LBIFS): 64 сектора × 4 антенны пира = 259 передач; uc держит CDOWN в u8 (dccm.h ss_plan_cdown, '
            'txss.c txss_program_tx_frame «(u8)((r14 − 1) + n_frames·r14)») — CDOWN 258 → 2, развёртка короче и '
            'Duration неверны')


def sweep(uc, n_sectors, peer_ant, mode, sta=0):
    """Развёртка SSW (txss_program_tx_frame): mode 5 — ISS инициатора, 1 — RSS ответчика. Возвращает [(CDOWN, сектор,
    Duration)] по кадрам: на каждый кадр uc выдаёт 0x2d (CDOWN [9:1], сектор [15:10]) и 0x15 (Duration)."""
    lmac_mac_cfg(uc)
    ss = TXSS_SS + SS_SZ * sta
    uc.w32(ss, 0)
    uc.w32(ss + 4, 0)
    for i in range(64):
        uc.w8(ss + 8 + i, (63 - i) if i < n_sectors else 0xff)   # Sector ID 0..63 (9.5.1)
    uc.w8(ss + 0x48, n_sectors)
    uc.w8(ss + 0x49, 0)
    uc.w8(STA_TAB + STA_SZ * sta + 0x4c, peer_ant)
    uc.w32(BF_STA + 20 * sta, 0)
    uc.w32(0x8014c0, 0)                 # uc_role_ap: STA (один набор RF)
    uc.w8(MAC_MON_SLOT_IDX, 0)          # индекс слота счётчиков MAC-монитора (иначе мусор эмулятора пишет мимо таблицы)
    uc.ext.update({42: 0, 43: 1 << 31})
    r = uc.call('txss_program_tx_frame', sta, mode, 0, 3, 0, stub=SWEEP_STUBS, max_steps=20_000_000)
    assert r == 1
    cd = [((c >> 1) & 0x1ff, (c >> 10) & 0x3f) for c in uc.mac_cmds if c >> 24 == 0x2d]
    du = durations(uc)
    assert len(cd) == len(du), 'кадров с CDOWN %d, с Duration %d' % (len(cd), len(du))
    return [(c, s, d) for (c, s), d in zip(cd, du)]


def air_schedule(n_sectors, peer_ant):
    """Эталон по 10.42.2.2.2: ISS повторяется для каждой приёмной DMG-антенны пира, повторы разделены LBIFS, внутри —
    SBIFS; CDOWN считает оставшиеся передачи, включая LBIFS (Figure 10-70: последний кадр — CDOWN 0).
    Возвращает [(CDOWN, интервал до следующего кадра)]."""
    frames = []
    total = n_sectors * peer_ant + (peer_ant - 1)               # передачи вместе с LBIFS
    k = total - 1
    for a in range(peer_ant):
        for s in range(n_sectors):
            last_of_ant = s == n_sectors - 1
            gap = (LBIFS_US if last_of_ant else A_SBIFS_US) if a < peer_ant - 1 or not last_of_ant else None
            frames.append((k, gap))
            k -= 2 if (last_of_ant and a < peer_ant - 1) else 1
    return frames


def expected_ssw_duration(sched, i):
    """9.3.1.15: до конца SSW с CDOWN 0 + MBIFS (от конца этого кадра), мкс вверх (9.2.5.1)."""
    t = Fraction(0)
    for _, gap in sched[i:-1]:
        t += gap + ctrl_txtime_us(SSW_LEN)
    return ceil_us(t + MBIFS_US)


@pytest.mark.parametrize('mode', [5, 1], ids=['iss', 'rss'])
@pytest.mark.parametrize('n,ant', [(1, 1), (4, 1), (16, 1), (64, 1), (3, 2), (16, 4), (63, 4),
                                   pytest.param(64, 4, marks=pytest.mark.xfail(strict=True, reason=CDOWN_U8))])
def test_ssw_duration_and_cdown_over_sweep(uc, mode, n, ant):
    """Каждый SSW развёртки: CDOWN — число оставшихся передач (с LBIFS), Duration — до конца SSW с CDOWN 0 + MBIFS
    (9.3.1.15), для любого числа секторов и антенн пира (64 сектора × 4 антенны — CDOWN до 258)."""
    got = sweep(uc, n, ant, mode)
    sched = air_schedule(n, ant)
    assert [c for c, _, _ in got] == [c for c, _ in sched]
    assert got[-1][0] == 0
    for i, (c, _, d) in enumerate(got):
        frame_duration_ok(d)
        assert d == expected_ssw_duration(sched, i), 'CDOWN %d' % c
    assert [s for _, s, _ in got] == [63 - i % n for i in range(n * ant)]    # каждая антенна пира — все секторы


# ---- SSW-Feedback (DTI) -------------------------------------------------------------------------------------

FB_STUBS = {'direct_tx_program_cmd34': 0, 'mac_program_tx_common': 0, 'tx_fifo_write_bytes': 0,
            'uc_wait_direct_tx_ready': 0, 'direct_tx_issue_cmd_33': 0,
            'mac_evt_enable_bit_sync_b': 0, 'mac_set_rf_chain_state_with_sta_sector': 0, 'uc_spin_until_event': 0}


def send_feedback(uc, sta, brp):
    lmac_mac_cfg(uc)
    uc.w8(SLS_MAINT, (1 << sta) if brp else 0)
    uc.w32(0x8005f4, 0)
    uc.call('txss_init_send_ssw_fdbk', 1, sta, 0, stub=FB_STUBS)
    buf = [a for n, a in uc.calls if n == 'tx_fifo_write_bytes'][-1][0]
    brp_req = int.from_bytes(uc.rbytes(buf + 0x13, 4), 'little')       # Figure 9-55: BRP Request после SSW Feedback
    return durations(uc), brp_req


@pytest.mark.parametrize('brp', [False, True], ids=['no_brp', 'brp'])
def test_ssw_feedback_duration_dti(uc, brp):
    """9.3.1.16 (DTI): BRP-фаза запрошена полем BRP Request (L-RX > 0 или TX-TRN-REQ) — TXTIME(SSW-Ack) + 2×MBIFS,
    иначе TXTIME(SSW-Ack) + MBIFS; вверх."""
    d, req = send_feedback(uc, 0, brp)
    requested = (req & 0x1f) != 0 or (req >> 5) & 1
    assert requested == brp
    want = ceil_us(ctrl_txtime_us(SSW_ACK_LEN) + (2 if requested else 1) * MBIFS_US)
    assert d == [want]


@pytest.mark.xfail(strict=True, reason='802.11-2020 9.3.1.16 b): Duration SSW-Feedback без BRP — «TXTIME(SSW-Ack) + '
                   'MBIFS or the time until the end of the current allocation, whichever comes earlier»; uc '
                   '(tail.c txss_init_send_ssw_fdbk, SSWFB_DUR_US) конец выделения не учитывает (abft.h: «Конец '
                   'выделения не учитывается»)')
def test_ssw_feedback_duration_capped_by_allocation_end(uc):
    """Остаток выделения 10 мкс (до TBTT и до конца окна DTI — как его считает sswfb_retry_fits) — Duration ≤ 10."""
    uc.w32(HW_MAC_USEC_TO_TBTT, 10)
    lmac_mac_cfg(uc)
    uc.w8(SLS_MAINT, 0)
    uc.w32(0x8005f4, 0)
    uc.call('txss_init_send_ssw_fdbk', 1, 0, 0, stub=dict(FB_STUBS, ese_dti_us_to_window_end=10))
    assert durations(uc)[0] <= 10


# ---- SSW-Ack ------------------------------------------------------------------------------------------------

ACK_STUBS = {'direct_tx_program_cmd34': 0, 'mac_program_tx_common': 0, 'rx_funcs_send_direct_frame': 0,
             'mac_evt_enable_bit_sync_b': 0, 'mac_set_rf_chain_state_with_sta_sector': 0}


@pytest.mark.parametrize('d_fb', [0, 1, 27, 28, 29, 37, 100, 32767])
def test_ssw_ack_duration(uc, d_fb):
    """9.3.1.17: Duration SSW-Ack = Duration принятого SSW-Feedback − MBIFS − TXTIME(SSW-Ack); вверх, не меньше 0
    (9.2.5.1). 28 → 1, 37 → 10."""
    lmac_mac_cfg(uc)
    uc.w32(0x802288, 0)                     # rxf.sta
    uc.w16(RX_BUF_DURATION, d_fb)
    uc.w32(0x8005f4, 0)
    uc.ext[42] = 1 << 15
    uc.call('sls_send_ssw_ack', 0, 0, stub=ACK_STUBS)
    want = max(0, ceil_us(d_fb - MBIFS_US - ctrl_txtime_us(SSW_ACK_LEN)))
    assert durations(uc) == [want]


# ---- ответы через SIFS: Grant Ack, CF-End -------------------------------------------------------------------

RESP_STUBS = {'direct_tx_program_cmd34': 0, 'mac_program_tx_with_rate': 0, 'tx_fifo_write_bytes': 0,
              'uc_wait_direct_tx_ready': 0, 'direct_tx_issue_cmd_33': 0}


def grant_ack_duration(uc, d_grant):
    lmac_mac_cfg(uc)
    uc.w16(RX_BUF_DURATION, d_grant)
    uc.call('rx_send_dmg_cts', stub=RESP_STUBS)
    return durations(uc)


@pytest.mark.parametrize('d', [0, 5, 18])
def test_grant_ack_duration_never_negative(uc, d):
    """9.3.1.18 + 9.2.5.1: Grant с Duration меньше TXTIME(Grant Ack) + SIFS — Grant Ack с Duration 0 (а не ~32 мс)."""
    assert grant_ack_duration(uc, d) == [0]


@pytest.mark.parametrize('d', [19, 20, 100, 32767])
def test_grant_ack_duration_rounded_up(uc, d):
    want = max(0, ceil_us(d - ctrl_txtime_us(GRANT_ACK_LEN) - A_SIFS_US))
    assert grant_ack_duration(uc, d) == [want]


def cf_end_response(uc, d_rx):
    lmac_mac_cfg(uc)
    uc.w16(RX_BUF_DURATION, d_rx)
    ret = uc.call('rx_flow_send_imm_response', stub=RESP_STUBS)
    return durations(uc), ret


def cf_end_seq_duration(i):
    """9.3.1.6: Duration CF-End DMG = (i − 1)·(TXTIME(CF-End) + SIFS), вверх (9.2.5.1)."""
    return ceil_us((i - 1) * (ctrl_txtime_us(CF_END_LEN) + A_SIFS_US))


def test_cf_end_response_last_in_sequence_is_zero(uc):
    """Принят CF-End с i = 2 — ответный CF-End последний в последовательности усечения (i = 1): Duration 0."""
    d, ret = cf_end_response(uc, cf_end_seq_duration(2))
    assert d == [0] and ret == 0


def test_cf_end_response_middle_of_sequence(uc):
    d, ret = cf_end_response(uc, cf_end_seq_duration(3))
    assert d == [cf_end_seq_duration(2)]
