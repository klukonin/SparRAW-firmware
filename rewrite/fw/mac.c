// SPDX-License-Identifier: AGPL-3.0-or-later
/* Управление MAC-регистрами. */
#include "../include/types.h"
#include "../include/hw.h"


/* Взвести бит 0 регистра 0x880bc0 (значение 0/1). */
void mac_set_880bc0_b0(u32 v)
{
    if (v & ~1u)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_RNG_CTL) = v | (MMIO32(HW_RNG_CTL) & ~1u);
}

void mac_enable_880bc0_b0(void)
{
    mac_set_880bc0_b0(1);
}

/* Установка битов 0x880af4/0x880af8/0x880afc (0x8d19a4). vendor пишет v << n без
 * маски (bclr только у старого значения) — при v & ~1 != 0 (после вернувшегося
 * сисассерта 0xac) лишние биты v тоже попадают в регистр; так и здесь. */
void mac_set_bits_880af4_f8_fc(u32 v)
{
    if (v & ~1u)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) = (v << 8) | (MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) & ~(1u << 8));
    if (v & ~1u)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_CLKS_CTL_SW_CLK_VEC_1) = (v << 19) | (MMIO32(HW_CLKS_CTL_SW_CLK_VEC_1) & ~(1u << 19));
    if (v & ~1u)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) = (v << 4) | (MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) & ~(1u << 4));
}

/* (0x8d1a34): 0x880af8 бит 25, 0x880afc бит 5 (v << n без маски, как vendor). */
void mac_set_880af8_afc_b25_b5(u32 v)
{
    if (v & ~1u)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_CLKS_CTL_SW_CLK_VEC_1) = (v << 25) | (MMIO32(HW_CLKS_CTL_SW_CLK_VEC_1) & ~(1u << 25));
    if (v & ~1u)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) = (v << 5) | (MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) & ~(1u << 5));
}

/* (0x8d1250): 0x880af8 бит 30, 0x880afc бит 6 (v << n без маски, как vendor). */
void mac_set_880af8_afc_b30_b6(u32 v)
{
    if (v & ~1u)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_CLKS_CTL_SW_CLK_VEC_1) = (v << 30) | (MMIO32(HW_CLKS_CTL_SW_CLK_VEC_1) & ~(1u << 30));
    if (v & ~1u)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) = (v << 6) | (MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) & ~(1u << 6));
}

/* (0x8d1ac0): три отдельных RMW 0x880afc — биты 9, 10, 11 по одному (как vendor). */
void mac_set_880afc_bits9_11(u32 on)
{
    if (on != 0) {
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) |= 1u << 9;
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) |= 1u << 10;
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) |= 1u << 11;
    } else {
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) &= ~(1u << 9);
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) &= ~(1u << 10);
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) &= ~(1u << 11);
    }
}

/* SXD RX-режим: [0x886dc8] (0x8d0ff8). */
void hwd_mac_sxd_rx_mode_entry(void)
{
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x3d000200;
}

/* SXD нейтральный режим (0x8d0fe0). */
void hwd_mac_sxd_mode_neutral(void)
{
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x3e000000;
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x3d000007;
}

/* mac__read_tsf64 (0x8e9900): 64-битный TSF без разрыва hi/lo — (unused, out, wait).
 * wait != 0: ждать бит 31 [0x886eb4]. Возврат — hi ([0x886ebc]). */
u32 mac_read_tsf64(u32 unused, u32 *out, u32 wait)
{
    (void)unused;
    if (wait) {
        while (!(MMIO32(HW_MAC_TIMING_STATUS) & 0x80000000u))
            ;
    }

    u32 hi, lo;
    do {
        hi = MMIO32(HW_MAC_TSF_HI);
        lo = MMIO32(HW_MAC_TIMING_INDIRECT_REG_5);
    } while (hi != MMIO32(HW_MAC_TSF_HI));

    out[1] = hi;
    out[0] = lo;
    return hi;
}

/* Прочитать старшее слово TSF (0x8e9aa0). */
u32 mac_read_tsf_hi(u32 a)
{
    (void)a;
    u32 buf[2];
    return mac_read_tsf64(0, buf, 0);
}

/* Переключить бит 1 регистра 0x880288 (0x8c7044). */
void mac_toggle_880288_b1(void)
{
    for (;;) {
        u32 cur = MMIO32(HW_RF_KILL_PIN);
        if (cur & 1u) {
            MMIO32(HW_RF_KILL_PIN) = cur & ~2u;
            if (MMIO32(HW_RF_KILL_PIN) & 1u)
                break;
        } else {
            MMIO32(HW_RF_KILL_PIN) = cur | 2u;
            if (!(MMIO32(HW_RF_KILL_PIN) & 1u))
                break;
        }
    }
}

/* Чтение 4 регистров 0x880a2c..0x880a38 (0x8f3570). */
void mac_read_880a2c_38(u32 *a, u32 *b, u32 *c, u32 *d)
{
    if (d) *d = MMIO32(HW_FW_VERSION_BUILD);
    if (c) *c = MMIO32(HW_FW_VERSION_SUBMINOR);
    if (b) *b = MMIO32(HW_FW_VERSION_MINOR);
    if (a) *a = MMIO32(HW_FW_VERSION_MAJOR);
}
