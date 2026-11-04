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
    'direct_tx_program_desc', 'mac_program_tx_common', 'mac_evt_enable_bit_sync_b', 'mac_evt_enable_bit_sync',
    'uc_spin_until_event', 'uc_spin_until_event4', 'mac_set_rf_chain_state_with_sta_sector', 'bcon_tx_ack_cmds',
    'mac_evt_select_timer_group', 'uc_send_evt_ps_awake_peer', 'uc_wait_event_busy', 'mac_cmd_29000001',
    'mac_select_all_sectors_and_wait', 'mac_program_tx_vector', 'mac_program_tx_beacon')}


def sweep(uc, n_sectors, peer_ant, mode, sta=0, alloc_left_us=None):
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
    stub = dict(SWEEP_STUBS)
    if alloc_left_us is not None:       # остаток выделения при подготовке развёртки: до TBTT, окна ESE нет
        uc.w32(HW_MAC_USEC_TO_TBTT, alloc_left_us)
        stub['ese_dti_us_to_window_end'] = 0xffffffff
    r = uc.call('txss_program_tx_frame', sta, mode, 0, 3, 0, stub=stub, max_steps=20_000_000)
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
@pytest.mark.parametrize('n,ant', [(1, 1), (4, 1), (16, 1), (64, 1), (3, 2), (16, 4), (63, 4), (64, 4)])
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


SSW_FRAME_ALLOWANCE_US = 17     # от чтения остатка до конца первого SSW: ⌈TXTIME(SSW)⌉ 15 + путь + округление регистра


@pytest.mark.parametrize('mode', [5, 1], ids=['iss', 'rss'])
@pytest.mark.parametrize('short', [0, 1, 5, 9, 30])
def test_ssw_duration_capped_by_allocation_end(uc, mode, short):
    """9.3.1.15: Duration SSW — до конца SSW с CDOWN 0 + MBIFS «or until the end of the current allocation, whichever
    comes first». Выделение кончается на short мкс раньше конца последовательности: каждый Duration меньше эталона на
    short (не больше MBIFS — Duration последнего SSW не уходит ниже 0), с допуском на путь в безопасную сторону."""
    n = 16
    sched = air_schedule(n, 1)
    want = [expected_ssw_duration(sched, i) for i in range(len(sched))]
    got = sweep(uc, n, 1, mode, alloc_left_us=want[0] + SSW_FRAME_ALLOWANCE_US - short)
    cut = min(short, MBIFS_US)
    assert [d for _, _, d in got] == [w - cut for w in want]


# ---- SSW-Feedback (DTI) -------------------------------------------------------------------------------------

FB_STUBS = {'direct_tx_program_desc': 0, 'mac_program_tx_common': 0, 'tx_fifo_write_bytes': 0,
            'uc_wait_direct_tx_ready': 0, 'direct_tx_commit': 0,
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


def test_ssw_feedback_duration_capped_by_allocation_end(uc):
    """Остаток выделения 10 мкс (до TBTT и до конца окна DTI — как его считает sswfb_retry_fits) — Duration ≤ 10."""
    uc.w32(HW_MAC_USEC_TO_TBTT, 10)
    lmac_mac_cfg(uc)
    uc.w8(SLS_MAINT, 0)
    uc.w32(0x8005f4, 0)
    uc.call('txss_init_send_ssw_fdbk', 1, 0, 0, stub=dict(FB_STUBS, ese_dti_us_to_window_end=10))
    assert durations(uc)[0] <= 10


# ---- SSW-Ack ------------------------------------------------------------------------------------------------

ACK_STUBS = {'direct_tx_program_desc': 0, 'mac_program_tx_common': 0, 'direct_tx_send_frame': 0,
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

RESP_STUBS = {'direct_tx_program_desc': 0, 'mac_program_tx_with_rate': 0, 'tx_fifo_write_bytes': 0,
              'uc_wait_direct_tx_ready': 0, 'direct_tx_commit': 0}


def grant_ack_duration(uc, d_grant):
    lmac_mac_cfg(uc)
    uc.w16(RX_BUF_DURATION, d_grant)
    uc.call('rx_send_grant_ack', stub=RESP_STUBS)
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
    ret = uc.call('rx_send_cf_end_response', stub=RESP_STUBS)
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


# ---- CF-End держателя TXOP (tx_send_and_await_rx_frame) -----------------------------------------------------

HOLDER_STUBS = {n: 0 for n in (
    'cf_end_send_frame', 'uc_sleep_until_event', 'gp0_timer_arm_usec', 'uc_spin_until_event', 'mac_set_rf_chain_state',
    'uc_wait_one_event', 'tx_await_rx_or_timeout', 'rx_mode_configure', 'mac_program_tx_vector', 'uc_wait_txop_end')}
TX_CTX0 = 0x802978
DTI_QSET_MODE = 0x8004f4
ITX_KA_PENDING = 0x800570


def sc1_txtime_us(length):
    """TXTIME DMG SC MCS 1 (20.11.3, 20.5.3.2.3.3; Table 20-15: N_CBPS 1, ρ 2, R 1/2, L_CW 672, N_CBPB 448)."""
    ncw = -(-(length * 8) // (336 // 2))                  # ⌈8·L / ((L_CW/ρ)·R)⌉
    nblks = -(-(ncw * 672) // 448)
    return Fraction(2176 + 1152 + 1024 + nblks * 512 + 64, 1760)


def air_duration(cmd, txtime_us):
    """H-DUR18 (docs/MAC-STAND.md, стенд 2026-11-04): кадр FIFO, пущенный 0x18 без б12 (cf_end_send_frame:
    0x18000000), после 0x15 + 0x14000007 несёт в эфире 0x15 − ⌈TXTIME своего PPDU⌉, не меньше 0."""
    return max(0, cmd - ceil_us(txtime_us))


def holder_cf_end(uc, rem_us, peer_flags=0, qset_mode=0):
    """CF-End после TXOP в CBAP: остаток REMAINING_TIME_RD (r40) rem_us. Возвращает (значения 0x15, MCS CF-End —
    аргумент rate cf_end_send_frame, срок ответа GP0 в мкс или None, если CF-End не ушёл)."""
    lmac_mac_cfg(uc)
    uc.w32(TX_CTX0, 0)                          # tx_ctx_s.sta = 0
    uc.w16(STA_TAB + 2, peer_flags)             # sta_tab[0].flags: б1 = 0 — CF-End на SC MCS 1, б1 = 1 — control
    uc.w32(DTI_QSET_MODE, qset_mode)
    uc.ext.update({40: rem_us, 42: 1 << 14})    # busy2 (подтверждение передачи), txop_event не поднят
    k = len(uc.calls)                           # журнал вызовов заглушек копится между вызовами
    uc.call('tx_send_and_await_rx_frame', TX_CTX0, 0, 0, 0, stub=HOLDER_STUBS)
    sent = [a for n, a in uc.calls[k:] if n == 'cf_end_send_frame']
    gp0 = [a[0] for n, a in uc.calls[k:] if n == 'gp0_timer_arm_usec']
    return durations(uc), (sent[0][1] if sent else None), (gp0[-1] if sent else None)


def t_cf_end(mcs=0):
    return ctrl_txtime_us(CF_END_LEN) if mcs == 0 else sc1_txtime_us(CF_END_LEN)


@pytest.mark.parametrize('peer_flags,mcs', [(0, 1), (2, 0)])
@pytest.mark.parametrize('rem', [100, 1000, 0xffff])
def test_cf_end_holder_duration_is_i2(uc, rem, peer_flags, mcs):
    """9.3.1.6: CF-End держателя TXOP — первый в последовательности усечения из двух (ответный CF-End пира — i = 1):
    i = 2, Duration в эфире = ⌈TXTIME(CF-End) + SIFS⌉ = 18 (было 34/23 в 0x15 — 19 в эфире; затем 18 в 0x15 — 3 в
    эфире, стенд 2026-11-04). В 0x15 — Duration + ⌈TXTIME своего CF-End⌉ на его MCS (H-DUR18); ответ ждём."""
    d, rate, gp0 = holder_cf_end(uc, rem, peer_flags)
    assert rate == mcs
    assert [air_duration(x, t_cf_end(mcs)) for x in d] == [cf_end_seq_duration(2)] == [18]
    assert gp0 == 0x12
    # ответ пира на этот CF-End — последний (i = 1), Duration 0
    assert cf_end_response(uc, 18) == ([0], 0)


def test_cf_end_holder_nonzero_needs_room_for_response(uc):
    """10.23.2.10: ненулевой Duration — только если после CF-End остаётся ≥ 2·T(CF-End) + 2·SIFS; меньше — Duration 0
    и ответа не ждём; не хватает на сам кадр — CF-End не шлём. Остаток читается до своего CF-End (+ его TXTIME)."""
    nz = t_cf_end() + 2 * t_cf_end() + 2 * A_SIFS_US        # 48,1 мкс до начала своего CF-End
    for rem in range(0, 80):
        d, rate, gp0 = holder_cf_end(uc, rem, 2)
        if gp0 is None:                           # CF-End не ушёл: только если не хватает на кадр (+ путь ≤ 4 мкс)
            assert rem < t_cf_end() + 5, rem
        elif d == [0]:                            # Duration 0 — ответа нет: остаток мал для ответного CF-End
            assert t_cf_end() <= rem < nz + 5 and gp0 == 1, rem
        else:
            assert [air_duration(x, t_cf_end()) for x in d] == [18] and rem >= nz and gp0 == 0x12, rem
    assert holder_cf_end(uc, 60, 2)[0] != [0] and holder_cf_end(uc, 40, 2)[0] == [0]
    assert holder_cf_end(uc, 10, 2)[2] is None


def test_cf_end_fixed_schedule_zero(uc):
    """Усечение SP (фиксированное расписание): CF-End с Duration 0 (i = 1, ответа нет)."""
    assert holder_cf_end(uc, 1000, qset_mode=1) == ([0], 1, 1)


# ---- RTS keep-alive (internal_tx_keepalive_flow) ---------------------------------------------------------------

def test_keepalive_rts_duration_on_air(uc):
    """RTS keep-alive — кадр FIFO, пущенный 0x18000000: MAC кладёт в Duration 0x15 − ⌈TXTIME(RTS)⌉ (H-DUR18; стенд
    2026-11-04: 0x15 40 → в эфире 25, 11 RTS точки за 30 с). Duration в эфире — 40 мкс (выбор uc, tx.c: кадр
    keep-alive SC + DMG CTS + Ack + 3·SIFS), в 0x15 — 40 + ⌈TXTIME(RTS 20 Б, control PHY)⌉."""
    lmac_mac_cfg(uc)
    uc.w8(0x800442, 8)                  # itx_rr_b — обход с 8
    uc.w32(ITX_KA_PENDING, 1)           # keep-alive ждёт станция 0
    uc.w32(STA_TAB + 0x18, 1)           # sta_tab[0].qid_mask_q6
    uc.w32(DTI_QSET_MODE, 0)
    uc.ext.update({40: 0, 42: 0, 43: 1 << 31, 45: 1 << 31})       # CCA занят — RTS не пускается, 0x15 уже записан
    uc.call('internal_tx_keepalive_flow', 0, stub={n: 0 for n in (
        'direct_tx_send_after_delay', 'mac_select_all_sectors_and_wait', 'mac_cmd_29000001', 'gp0_timer_arm_usec')})
    d = durations(uc)
    assert [air_duration(x, ctrl_txtime_us(20)) for x in d] == [40], d
