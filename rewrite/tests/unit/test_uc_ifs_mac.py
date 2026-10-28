# SPDX-License-Identifier: AGPL-3.0-or-later
"""IFS, которые uc программирует в MAC (LMAC 0x00 → ucode_cmd_0x00_handler → txrx_api_step_b_uc), против
802.11-2020: Table 20-30 (aSIFSTime 3 мкс, aSlotTime 5 мкс, aSBIFSTime 1 мкс, aRIFSTime 1 мкс, aRxPHYStartDelay),
10.3.2.3.4 PIFS = aSIFSTime + aSlotTime, 10.3.2.3.10 MBIFS = 3×aSIFSTime, 10.3.2.11/10.3.2.9 AckTimeout/CTSTimeout
= aSIFSTime + aSlotTime + aRxPHYStartDelay.

Такт MAC/uc — 165 МГц; значение IFS в регистре — пара {целые мкс [15:8], остаток в тактах [7:0]} (как SIFS_CNT,
uc/ifs.h), т. е. такты = мкс·165 + остаток. Здесь же — общие помощники остальных test_uc_ifs_*/test_uc_nav_*."""
from fractions import Fraction
import math
import pytest

# ---- 802.11-2020, Table 20-30 (DMG PHY characteristics) ----
CLK_PER_US = 165                     # такт MAC 165 МГц (политика проекта: IFS в тактах 165 МГц)
A_SIFS_US = 3
A_SLOT_US = 5
A_SBIFS_US = 1
A_RIFS_US = 1
A_RX_PHY_START_DELAY_CTRL_US = 10    # DMG control mode
MBIFS_US = 3 * A_SIFS_US             # 10.3.2.3.10
PIFS_US = A_SIFS_US + A_SLOT_US      # 10.3.2.3.4

# ---- MAC/DCCM ----
HW_MAC_IFS_SIFS = 0x886d00
HW_MAC_IFS_SLOT = 0x886d04
HW_MAC_IFS_PIFS_2SLOT = 0x886d08
HW_MAC_IFS_RIFS_SBIFS = 0x886d0c
IFS = 0x802968                       # struct ifs_timing: sifs +0, slot +2, pifs +4, two_slot +6, c3 +8, c4 +0xa, mbifs +0xc
MAC_IFS_SHADOW = 0x8005be
TXSS_IFS_RESTORE = 0x800510
RESP_WAIT_SLOTS, BUSY_WAIT_SLOTS = 0x800508, 0x80050a
FWSH_LONG_RANGE = 0x85728e             # include/fwsh.h: ≠ 0 — режим дальней связи (WMI_SET_LONG_RANGE)
FWSH_N_SETS, FWSH_SET_RF_MASK, FWSH_SET_TX_MASK = 0x857768, 0x85778c, 0x8577a4   # include/fwsh.h fwsh_sets
SCRATCH = 0x806800                   # свободная часть разделяемой области DCCM (тело LMAC-команды)


def ceil_us(x):
    return math.ceil(Fraction(x))


def ctrl_txtime_us(length):
    """TXTIME PPDU control mode без TRN, мкс (20.11.3; N_CW — 20.4.3.3.3; T_STF-CM = 50·128 Tc, T_CE-CM = 9·128 Tc,
    Tc = 1/1760 мкс, Table 20-4)."""
    ncw = 1 + math.ceil(Fraction((length - 6) * 8, 168))
    chips = 50 * 128 + 9 * 128 + (11 * 8 + (length - 6) * 8 + ncw * 168) * 32
    return Fraction(chips, 1760)


def ifs_clk(code):
    """Код IFS {мкс [15:8], такты [7:0]} → такты 165 МГц."""
    us, rem = (code >> 8) & 0xff, code & 0xff
    assert rem < CLK_PER_US, 'остаток %d ≥ 165 тактов — код не нормализован' % rem
    return us * CLK_PER_US + rem


def mmio_writes(trace, addr):
    return [(i, e[4]) for i, e in enumerate(trace) if e[0] == 'mmio' and e[1] == 'w' and e[2] == addr]


def reg_at(uc, addr, idx, initial):
    """Значение регистра addr к событию idx последнего вызова (последняя запись раньше idx, иначе initial)."""
    v = initial
    for i, val in mmio_writes(uc.last_trace, addr):
        if i >= idx:
            break
        v = val
    return v


def call_events(uc, name):
    """Индексы событий вызова функции name в трассе последнего uc.call (в т. ч. заглушки)."""
    a = uc.sym[name] & 0x1ffff
    return [i for i, e in enumerate(uc.last_trace) if e[0] == 'call' and (e[1] & 0x1ffff) == a]


def lmac_mac_cfg(uc, sifs=A_SIFS_US * CLK_PER_US, slot=A_SLOT_US * CLK_PER_US,
                 rifs=A_RIFS_US * CLK_PER_US, sbifs=A_SBIFS_US * CLK_PER_US, rf_chain=0, long_range=0):
    """LMAC 0x00 (include/lmac_cmd.h struct lmac_cmd_mac_cfg, 0x44 Б): ifs_us[] @0x30 — значения в тактах 165 МГц
    (SIFS, предел добавки, slot, RIFS, SBIFS); регистровая часть 0x00..0x2f — нули."""
    for i in range(0, 0x44, 4):
        uc.w32(SCRATCH + i, 0)
    for i, v in enumerate((sifs, 10, slot, rifs, sbifs, 0)):
        uc.w16(SCRATCH + 0x30 + 2 * i, v)
    uc.w32(SCRATCH + 0x40, rf_chain)
    # Наборы RF (хвост обработчика, rf_compute_tx_rx_sets) — один набор; регистровая часть (ucode_cmd_apply_mac_cfg)
    # к IFS не относится и требует состояния RF — заглушка.
    uc.w8(FWSH_LONG_RANGE, long_range)
    uc.w32(FWSH_N_SETS, 1)
    uc.w8(FWSH_SET_RF_MASK, 1)
    uc.w8(FWSH_SET_TX_MASK, 1)
    uc.call('ucode_cmd_0x00_handler', SCRATCH, stub={'ucode_cmd_apply_mac_cfg': 0})


# ---------------------------------------------------------------------------------------------------------------

def test_mac_ifs_registers_match_table_20_30(uc):
    """Table 20-30 + 10.3.2.3.4: SIFS 3, slot 5, PIFS 8, 2·slot 10 (DIFS = SIFS + 2·slot, 10.3.2.3.5), RIFS 1,
    SBIFS 1 мкс — в тактах 165 МГц точно."""
    lmac_mac_cfg(uc)
    w = {a: v for a in (HW_MAC_IFS_SIFS, HW_MAC_IFS_SLOT, HW_MAC_IFS_PIFS_2SLOT, HW_MAC_IFS_RIFS_SBIFS)
         for _, v in mmio_writes(uc.last_trace, a)[-1:]}
    assert ifs_clk(w[HW_MAC_IFS_SIFS] & 0xffff) == A_SIFS_US * CLK_PER_US
    assert ifs_clk(w[HW_MAC_IFS_SLOT] & 0xffff) == A_SLOT_US * CLK_PER_US
    assert ifs_clk(w[HW_MAC_IFS_PIFS_2SLOT] & 0xffff) == PIFS_US * CLK_PER_US
    assert ifs_clk(w[HW_MAC_IFS_PIFS_2SLOT] >> 16) == 2 * A_SLOT_US * CLK_PER_US
    assert ifs_clk(w[HW_MAC_IFS_RIFS_SBIFS] & 0xffff) == A_RIFS_US * CLK_PER_US
    # [31:24] — SBIFS в целых мкс: его читают txss_sweep_timing / bti_measure_frame_duration как «gap» развёртки
    assert ifs_clk(w[HW_MAC_IFS_RIFS_SBIFS] >> 16) == A_SBIFS_US * CLK_PER_US
    assert w[HW_MAC_IFS_RIFS_SBIFS] >> 24 == A_SBIFS_US


def test_mbifs_is_three_sifs(uc):
    """10.3.2.3.10: MBIFS = 3×aSIFSTime = 9 мкс (значение, которое uc грузит в регистр SIFS на время SLS)."""
    lmac_mac_cfg(uc)
    assert ifs_clk(uc.r16(IFS + 0xc)) == MBIFS_US * CLK_PER_US
    assert ifs_clk(uc.r16(IFS + 0xc)) == 3 * ifs_clk(uc.r16(IFS))


def test_idle_state_is_sifs_and_shadow_coherent(uc):
    """После конфигурации MAC в регистре SIFS и в его тени (по ней uc пропускает повторную запись) — aSIFSTime."""
    lmac_mac_cfg(uc)
    reg = mmio_writes(uc.last_trace, HW_MAC_IFS_SIFS)[-1][1] & 0xffff
    assert ifs_clk(reg) == A_SIFS_US * CLK_PER_US
    assert uc.r16(MAC_IFS_SHADOW) == reg


@pytest.mark.parametrize('clk', [1, 164, 165, 166, 495, 496, 659, 660, 824, 825, 826, 1650, 255 * 165 + 164])
def test_clock_to_ifs_code_is_exact(uc, clk):
    """Пересчёт тактов в код {мкс, такты} без потерь: 10.3.2.3 задаёт IFS с допуском −0 (никакого усечения)."""
    lmac_mac_cfg(uc, sifs=clk if clk * 3 < 256 * 165 else 495, slot=clk)
    slot = mmio_writes(uc.last_trace, HW_MAC_IFS_SLOT)[-1][1] & 0xffff
    assert ifs_clk(slot) == clk


def test_ack_timeout_covers_standard_interval(uc):
    """10.3.2.11 / 10.3.2.9: AckTimeout = CTSTimeout = aSIFSTime + aSlotTime + aRxPHYStartDelay (control mode 10 мкс)
    = 18 мкс. uc ждёт начала приёма resp_wait_slots/busy_wait_slots событий слота (по aSlotTime): окно не короче
    тайм-аута стандарта и не длиннее его больше чем на слот."""
    lmac_mac_cfg(uc)
    timeout_us = A_SIFS_US + A_SLOT_US + A_RX_PHY_START_DELAY_CTRL_US
    for a in (RESP_WAIT_SLOTS, BUSY_WAIT_SLOTS):
        n = uc.r16(a)
        assert n * A_SLOT_US >= timeout_us
        assert (n - 1) * A_SLOT_US < timeout_us
