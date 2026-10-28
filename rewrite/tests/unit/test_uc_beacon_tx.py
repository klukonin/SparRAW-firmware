# SPDX-License-Identifier: AGPL-3.0-or-later
"""DMG Beacon на передаче (AP/PCP) против 802.11-2020: поле Beacon Interval Control (9.3.4.2, рис. 9-77), развёртка
маяков BTI (10.42.4: CDOWN, сектор на маяк, Duration до конца BTI), Next A-BFT / N BIs A-BFT / A-BFT Count по BI
(10.42.5.1, 9.3.4.2) и сетка A-BFT AP (10.42.5.2: aSSSlotTime, Table 11-22).

Сценарий — как в работе: LMAC 0x0b (ucode_cmd_0x0b_handler: bi_cfg, план секторов, длительности слота) → развёртка BTI
(bti_worker_bti_transmitter_beacon_sweep_flow целиком: bi_ctrl_program_mac_bcon, txss_set_sweep_param,
bcon_txss_sweep_step, bi_cfg_tick_counters, программирование сетки A-BFT). Ожидания MAC и передача в эфир — заглушки.

Факты о MAC (не о стандарте), на которые опираются разборы команд:
  * 0x2a / 0x2b — поле BI Control маяка: 0x2a [19:0] → B0..B19, [23:20] → B44..B47; 0x2b [23:0] → B20..B43 (uc/bi.c,
    bi_cfg_pack_words_78_7c: «w1 б23 = B43», «w0 б20 → в эфире B44»);
  * 0x2d — поле SSW кадра развёртки в раскладке рис. 9-846 (б0 Direction, б1..9 CDOWN, б10..15 Sector ID);
  * 0x15 — Duration: в буквальном режиме маяка (0x14000007) Duration = значение 0x15 − d, d = ⌈TXTIME/1 мкс⌉
    (uc/abft.h, H-DUR/H-LIT2); у SSW вне BTI — значение 0x15 буквально.
Эталоны (TXTIME, aSSSlotTime, поля) считаются здесь по тексту стандарта, не из кода uc."""
import math
from fractions import Fraction as F

import pytest

# ---------------- эталон по тексту 802.11-2020 ----------------
CLK = 165                                   # такт MAC/uc на мкс (Timer1 165 МГц, факт о железе)
TC = F(1, 1760)                             # мкс, 20.4.3 (Tc = 1/1760 МГц)
SIFS, SBIFS = 3, 1                          # Table 20-30
MBIFS = 3 * SIFS                            # 10.3.2.3.10
AIRPROP = F(1, 10)                          # aAirPropagationTime 100 нс, Table 20-30
SSW_LEN, SSW_FB_LEN = 26, 28                # 9.3.1.15 рис. 9-54; 9.3.1.16 рис. 9-55 (с FCS)
SS_FRAMES_PER_SLOT = 4                      # aSSFramesPerSlot, Table 11-22


def ctrl_txtime(length):
    """TXTIME DMG control mode, мкс (20.11.3, N_CW — 20.4.3.3.3); T_STF = 50·128·Tc, T_CE = 9·128·Tc."""
    ncw = 1 + math.ceil(F((length - 6) * 8, 168))
    return (50 * 128 + 9 * 128 + (11 * 8 + (length - 6) * 8 + ncw * 168) * 32) * TC


def ss_duration(fss_field):
    """aSSDuration = (FSS − 1)·SBIFS + FSS·TXTIME(SSW), FSS — число кадров = поле + 1 (Table 11-22, 9.3.4.2)."""
    n = fss_field + 1
    return (n - 1) * SBIFS + n * ctrl_txtime(SSW_LEN)


def ss_slot_time(fss_field):
    """aSSSlotTime = aAirPropagationTime + aSSDuration + MBIFS + aSSFBDuration + MBIFS (10.42.5.2)."""
    return AIRPROP + ss_duration(fss_field) + MBIFS + ctrl_txtime(SSW_FB_LEN) + MBIFS


def bits(v, lo, n):
    return (v >> lo) & ((1 << n) - 1)


def bic_decode(v):
    """Beacon Interval Control, рис. 9-77."""
    return dict(cc_present=bits(v, 0, 1), discovery=bits(v, 1, 1), next_beacon=bits(v, 2, 4), ati_present=bits(v, 6, 1),
                abft_len=bits(v, 7, 3), fss=bits(v, 10, 4), is_resp_txss=bits(v, 14, 1), next_abft=bits(v, 15, 4),
                frag_txss=bits(v, 19, 1), txss_span=bits(v, 20, 7), n_bis_abft=bits(v, 27, 4), abft_count=bits(v, 31, 6),
                n_abft_in_ant=bits(v, 37, 6), pcp_assoc_ready=bits(v, 43, 1), reserved=bits(v, 44, 4))


def ssw_field(v):
    """SSW field, рис. 9-846 (9.5.1)."""
    return dict(direction=bits(v, 0, 1), cdown=bits(v, 1, 9), sector=bits(v, 10, 6))


# ---------------- DCCM / LMAC ----------------
CMD = 0x803c00                       # тело LMAC 0x0b (struct lmac_cmd_bcn_sweep, 0x70 Б) — свободная DCCM
BCN_BI = 0x80229c                    # bcn_bi: +0 abft_bi_left, +1 abft_idx, +2 x2, +3 next_beacon, +5 x5_cdown
BI_CFG = 0x8022a8
BTI_SW = 0x802a14                    # ssw_slot_a (aSSDuration), ssw_slot_b (aSSSlotTime), abft_dur, bcn_ss
FWSH0, FWSH1 = 0x857000, 0x857964    # общий блок fw (обнуляет crt0 fw)
FWSH_N_SETS = 0x85773c               # fwsh_sets.n_sec[1][0]
FWSH_SET_RANGES = 0x8577b0           # указатель на диапазоны наборов
FWSH_BCN_PSDU_LEN = 0x857008         # fwsh_diag.bcn_psdu_len
RANGES = 0x803d00
HW_MAC_IFS_RIFS_SBIFS = 0x886d0c     # [31:24] SBIFS, мкс
MAINT_STA_MASK = 0x802194
TX_CTX = 0x803e00
BI_CTX = 0x803f00

SWEEP_WAITS = ['bi_remaining_time_us', 'rx_nav_arm_flag_if_enabled', 'mac_program_tx_beacon', 'uc_wait_event_busy',
               'mac_select_all_sectors_and_wait', 'mac_cmd_29000001', 'mac_program_rx_window', 'mac_evt_enable_bit_sync_b',
               'bcon_tx_ack_cmds', 'uc_spin_until_event', 'mac_evt_enable_bit_sync', 'mac_set_rf_chain_state_with_sta_sector',
               'mac_evt_select_timer_group', 'uc_assert', 'uc_wait_two_events', 'uc_read_tsf_lo', 'uc_spin_until_event4',
               'bcon_txss_program_sector', 'rf_store_last_module_index', 'ucode_cmd_rf_program', 'macq_probe_empty']


MAC_CMD_LOG = 0x800000                # кольцо журнала MAC-команд: uc_mac_cmd пишет по r25 (uc/start.S, dccm.h mac_cmd_log)


@pytest.fixture(autouse=True)
def mac_log_ptr(uc):
    """r25 — глобальный указатель кольца журнала MAC-команд (ставит start.S). Обвязка его не задаёт: с r25 = 0 запись
    журнала идёт по произвольному адресу и портит DCCM (так испорчен ss_plan_tx_dur в развёртке маяков)."""
    uc.cpu.regs[25] = MAC_CMD_LOG
    return uc


def stubs(uc, names, **over):
    s = {n: 0 for n in names if n in uc.sym}
    s.update(over)
    return s


def zero(uc, a, n):
    for i in range(0, n, 4):
        uc.w32(a + i, 0)


def clean_shadows(uc):
    """Тени регистров MAC, которые uc OR-ит в команды (в эмуляторе неинициализированная память — не 0): иначе их
    случайные старшие биты дают ложные коды команд в разборе."""
    for a in (0x8004e0, 0x8004e4, 0x80051c, 0x8006a0, 0x802940, 0x802944):   # evt_en, sel, rf_chain_cfg, abif, rf_set_tx/rx
        uc.w32(a, 0)
    uc.w8(0x801080, 0)          # mac_mon_slot_idx: случайный индекс уводит mac_mon_slot[idx].tx_bcon++ в чужие переменные
    uc.w32(0x803134, 0)         # rx_meas.state: измерений нет


class MacTimeline:
    """r42 по истории команд MAC: б7 (txop_event) — кроме первого чтения сразу после 0x14000400 (сверка «ещё не
    пришёл» перед ожиданием, assert 0x75), б14 (событие слота A-BFT) — после пуска сетки 0x5400030c."""

    def __init__(self, uc):
        self.uc, self.pos, self.seen, self.after = uc, 0, set(), None

    def __call__(self, n, k):
        t = self.uc.cpu.trace
        for e in t[self.pos:]:
            if e[0] == 'extreg' and e[1] == 'w' and e[2] == 32:
                self.seen.add(e[4])
                self.after = e[4]
            elif e[0] == 'extreg' and e[2] == 42:
                self.after = None
        self.pos = len(t)
        b7 = 0 if self.after == 0x14000400 else 1 << 7
        b14 = (1 << 14) if 0x5400030c in self.seen else 0
        return b7 | b14


def lmac_0x0b(uc, n_frames=16, order=None, abft_len=1, fss=15, n_bi_abft=1, abft_cnt_mod=0, txss_span=1,
              flags=0, bi_mode=1):
    """LMAC 0x0b op 0 (новая конфигурация маяка) — как шлёт fw (lmac_if_send_bcon_mgt)."""
    zero(uc, CMD, 0x70)
    zero(uc, BCN_BI, 0xc)
    zero(uc, BTI_SW + 0xc, 0x4c)                  # bcn_ss: x0 = 0, host_set = 0
    order = list(range(64)) if order is None else list(order)
    uc.wbytes(CMD + 4 + 8, bytes(order[:64]) + b'\xff' * (64 - len(order[:64])))
    uc.w8(CMD + 4 + 0x48, n_frames)
    bi = CMD + 0x50
    uc.w32(bi, bi_mode)
    uc.w8(bi + 4, n_bi_abft)
    uc.w8(bi + 5, abft_cnt_mod)
    uc.w8(bi + 7, fss)
    uc.w8(bi + 8, 0)                              # x8: fw ставит 0
    uc.w8(bi + 9, txss_span)
    uc.w8(bi + 0xa, abft_len)
    uc.w32(bi + 0x14, flags)
    uc.call('ucode_cmd_0x0b_handler', CMD, stub=stubs(uc, SWEEP_WAITS))


def bic_of(cmds):
    """BI Control из пары команд 0x2a/0x2b (раскладка — факт о MAC, см. docstring модуля)."""
    a = [c & 0xffffff for c in cmds if c >> 24 == 0x2a]
    b = [c & 0xffffff for c in cmds if c >> 24 == 0x2b]
    assert len(a) == 1 and len(b) == 1, [hex(c) for c in cmds]
    return bic_decode((a[0] & 0xfffff) | (b[0] << 20) | ((a[0] >> 20) << 44))


def program_bic(uc):
    uc.call('bi_ctrl_program_mac_bcon')
    return bic_of(uc.mac_cmds)


def bti_sweep(uc, psdu_len=34):
    """Одна развёртка BTI AP (бит A-BFT в этом BI — по текущему bcn_bi.abft_bi_left). → команды MAC."""
    zero(uc, FWSH0, FWSH1 - FWSH0)
    uc.w8(FWSH_N_SETS, 1)
    uc.w32(FWSH_SET_RANGES, RANGES)
    uc.wbytes(RANGES, [0, 63])
    uc.w32(FWSH_BCN_PSDU_LEN, psdu_len)
    d = math.ceil(ctrl_txtime(psdu_len))       # r47: длительность кадра MAC в целых мкс вверх
    uc.ext.update({47: (1 << 31) | d, 43: 1 << 31, 42: MacTimeline(uc)})
    uc.w32(HW_MAC_IFS_RIFS_SBIFS, SBIFS << 24)
    uc.w8(0x800449, 0)                         # fsched_enabled
    uc.w32(0x800714, 0)                        # bti_defer_active
    uc.w8(0x800431, 0)                         # bti_sweep_set
    uc.w8(MAINT_STA_MASK, 0)
    uc.w32(0x8005f4, 0)                        # txrx_state1
    clean_shadows(uc)
    zero(uc, BI_CTX, 0x40)
    uc.call('bti_worker_bti_transmitter_beacon_sweep_flow', BI_CTX,
            stub=stubs(uc, SWEEP_WAITS, tx_ctx_alloc_next=TX_CTX))
    asserts = [a for n, a in uc.calls if n == 'uc_assert']
    assert not asserts, 'uc_assert: %s' % [hex(a[1]) for a in asserts]
    return uc.mac_cmds, d


def beacons(cmds):
    """[(SSW field, Duration-команда 0x15)] маяков развёртки по порядку."""
    i0 = cmds.index(0x14000100)                # развёртка начинается после замера длины кадра
    out, dur = [], None
    for c in cmds[i0:]:
        if c >> 24 == 0x15:
            if out and out[-1][1] is None:
                out[-1] = (out[-1][0], c & 0xffffff)
            else:
                dur = c & 0xffffff
        elif c >> 24 == 0x2d:
            out.append((ssw_field(c & 0xffffff), dur))
            dur = None
    return out


# ---------------- Beacon Interval Control ----------------

@pytest.mark.parametrize('fss', [4, 7, 15])
def test_bic_abft_length_and_fss(uc, fss):
    """9.3.4.2: A-BFT Length = число слотов − 1 (0..7), FSS = число SSW в слоте − 1; IsResponderTXSS — A-BFT для TXSS
    ответчика. Длительность A-BFT, по которой AP строит сетку (bti_sw.abft_dur), — A-BFT Length+1 слотов aSSSlotTime."""
    for abft_len in range(8):
        lmac_0x0b(uc, abft_len=abft_len, fss=fss)
        f = program_bic(uc)
        assert (f['abft_len'], f['fss'], f['is_resp_txss']) == (abft_len, fss, 1)
        slot = uc.r32(BTI_SW + 4)
        assert abs(slot - ss_slot_time(fss) * CLK) < 1
        assert abs(uc.r32(BTI_SW) - ss_duration(fss) * CLK) < 1
        assert uc.r32(BTI_SW + 8) == (abft_len + 1) * slot


@pytest.mark.parametrize('cc,disc,pcp_ready', [(0, 0, 0), (1, 0, 1), (0, 1, 0), (1, 1, 1), (1, 1, 0)])
def test_bic_flags_and_reserved(uc, cc, disc, pcp_ready):
    """9.3.4.2 рис. 9-77: CC Present B0, Discovery Mode B1, PCP Association Ready B43, B44..B47 Reserved = 0.
    Next Beacon = 0 (маяк в каждом BI), Fragmented TXSS = 0 (полная развёртка в одном BI)."""
    lmac_0x0b(uc, flags=cc | disc << 1 | pcp_ready << 3, txss_span=1)
    f = program_bic(uc)
    assert (f['cc_present'], f['discovery'], f['pcp_assoc_ready']) == (cc, disc, pcp_ready)
    assert f['reserved'] == 0
    assert (f['next_beacon'], f['frag_txss'], f['txss_span']) == (0, 0, 1)


@pytest.mark.parametrize('n_bi', [1, 2, 4, 7])
def test_next_abft_countdown_over_bis(uc, n_bi):
    """10.42.5.1: после BTI AP уменьшает Next A-BFT на 1, если он не 0; A-BFT — за BTI с Next A-BFT = 0.
    9.3.4.2: N BIs A-BFT — период A-BFT в BI (1 — A-BFT в каждом BI). Подряд 3·N BI."""
    lmac_0x0b(uc, n_bi_abft=n_bi)
    seq = []
    for _ in range(3 * n_bi):
        f = program_bic(uc)
        assert f['n_bis_abft'] == n_bi
        seq.append(f['next_abft'])
        uc.call('bi_cfg_tick_counters')
    for a, b in zip(seq, seq[1:]):
        if a != 0:
            assert b == a - 1, seq
    abft_bis = [i for i, v in enumerate(seq) if v == 0]
    assert len(abft_bis) == 3 and all(b - a == n_bi for a, b in zip(abft_bis, abft_bis[1:])), seq


@pytest.mark.parametrize('m', [0, 1, 3])
def test_abft_count_modulo_n_abft_in_ant(uc, m):
    """9.3.4.2: A-BFT Count — число A-BFT с последней смены RX-антенны (0 — антенна сменилась); N A-BFT in Ant — A-BFT на
    антенну. При одной RX-антенне (m = 0) оба поля зарезервированы — 0. Счёт — 0..m−1 по A-BFT."""
    lmac_0x0b(uc, n_bi_abft=1, abft_cnt_mod=m)
    cnt = []
    for _ in range(7):
        f = program_bic(uc)
        assert f['n_abft_in_ant'] == m
        cnt.append(f['abft_count'])
        uc.call('bi_cfg_tick_counters')
    assert cnt == [(i % m) if m else 0 for i in range(7)]


# ---------------- развёртка маяков BTI ----------------

def perm(n):
    return [(i * 37 + 11) % 64 for i in range(64)][:n] if n < 64 else [(i * 37 + 11) % 64 for i in range(64)]


@pytest.mark.parametrize('n', [1, 2, 16, 32, 63, 64])
def test_sweep_one_beacon_per_sector_cdown(uc, n):
    """10.42.4 / 9.5.1: n секторов — n маяков в BTI, по одному на сектор из плана, CDOWN n−1 … 0 (последний — 0),
    Direction = 0 (передаёт инициатор), Sector ID — сектор, через который идёт кадр."""
    order = perm(n)
    lmac_0x0b(uc, n_frames=n, order=order, n_bi_abft=2)    # BI без A-BFT: только развёртка
    uc.w8(BCN_BI, 1)
    cmds, _ = bti_sweep(uc)
    b = beacons(cmds)
    assert [x['cdown'] for x, _ in b] == list(range(n - 1, -1, -1))
    assert [x['sector'] for x, _ in b] == order[:n]
    assert all(x['direction'] == 0 for x, _ in b)


@pytest.mark.parametrize('n,psdu', [(1, 34), (2, 38), (16, 34), (32, 60), (64, 34), (64, 38), (64, 60)])
def test_sweep_duration_to_end_of_bti(uc, n, psdu):
    """10.42.4: Duration каждого маяка — время до конца BTI; 9.2.5.1: дробные мкс — вверх. Маяки идут через SBIFS
    (10.3.2.3.8), поэтому маяк с CDOWN j объявляет конец BTI на ⌈j·(TXTIME + SBIFS)⌉ позже своего конца, чем
    маяк с CDOWN 0: Duration(j) − Duration(0) = ⌈j·P + Duration(0)⌉ − Duration(0), P = TXTIME(маяк) + SBIFS."""
    lmac_0x0b(uc, n_frames=n, order=perm(n), n_bi_abft=2)
    uc.w8(BCN_BI, 1)
    cmds, d = bti_sweep(uc, psdu)
    b = beacons(cmds)
    assert len(b) == n
    p = ctrl_txtime(psdu) + SBIFS
    dur = {x['cdown']: v - d for x, v in b}
    d0 = dur[0]
    assert d0 >= 0
    for j, v in dur.items():
        assert v == math.ceil(j * p + d0), (j, v, float(j * p + d0))


@pytest.mark.parametrize('n,abft_len,fss', [(1, 0, 4), (2, 7, 15), (16, 1, 15), (32, 3, 9), (64, 7, 4), (64, 1, 15)])
def test_ap_abft_grid_matches_announced_fields(uc, abft_len, fss, n):
    """10.42.5.2: A-BFT из A-BFT Length+1 смежных слотов aSSSlotTime (поле FSS — кадров в слоте); SSW-Feedback AP
    начинается за aSSFBDuration + MBIFS до конца слота; конец A-BFT AP (GP0) — после конца последнего Feedback
    (конец A-BFT − MBIFS) и не позже конца A-BFT. Сетка — те же поля, что в маяке этого BTI.
    Таймеры GP0/GP2 стартуют одним триггером (0x…0308/0x…030c), GP1 — от границы слота (0x…090c); старт
    Feedback MAC — через IFS 0x886d00 (= MBIFS у AP) + UC_ABFT_MACLAT_CLK (91) после GP1 (uc/abft.h, H-ORIGIN)."""
    lmac_0x0b(uc, n_frames=n, order=perm(n), abft_len=abft_len, fss=fss, n_bi_abft=1)
    f = program_bic(uc)
    assert f['next_abft'] == 0
    cmds, _ = bti_sweep(uc)
    assert bic_of(cmds) == f                        # поля маяка этого BTI
    gp = lambda op: [c & 0xffffff for c in cmds if c >> 24 == op]
    gp0, gp1, gp2 = gp(0x4f), gp(0x50), gp(0x51)
    assert len(gp0) == 1 and len(gp1) == 1 and len(gp2) == 2, [hex(c) for c in cmds]
    slot0, period = gp2
    assert abs(period - ss_slot_time(f['fss']) * CLK) < 1
    end = slot0 + (f['abft_len'] + 1) * period
    assert end - MBIFS * CLK <= gp0[0] < end
    fb = (AIRPROP + ss_duration(f['fss']) + MBIFS) * CLK
    assert abs(gp1[0] + MBIFS * CLK + 91 - fb) < 1
