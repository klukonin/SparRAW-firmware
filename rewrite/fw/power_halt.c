// SPDX-License-Identifier: AGPL-3.0-or-later
/* power_halt_seq (0x8d78cc) и его транзитивное замыкание: HW-modes/RF/PHY/PCIe
 * power-halt/RF-секвенция. Перенесено из vendor __asm__ (6.2.0.1000) в C11.
 *
 * Всё кладём в .textlate — секция .text переполнена. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/rf_obj.h"
#include "../include/fwdata.h"

/* --- уже портированные каллее (extern-прототипы) --- */


/* Размножить нибл режима на все 8 тетрад: m | m<<4 | … | m<<28 — vendor строит слово
 * сдвигами/OR (не умножением), так и для m >= 16 (после вернувшегося сисассерта). */
static inline u32 mode_nibbles(u32 m)
{
    return m | (m << 4) | (m << 8) | (m << 12) | (m << 16) | (m << 20) | (m << 24) | (m << 28);
}

/* --- forward-объявления функций из этого файла (используются выше) --- */
__attribute__((section(".textlate"))) void hwd_dma_set_power_mode_map(u32 mode);
__attribute__((section(".textlate"))) void hwd_mac_set_power_mode_map(u32 mode);
__attribute__((section(".textlate"))) void hwd_pcie_set_mode_map(u32 mode);
__attribute__((section(".textlate"))) void hwd_phy_uses_rgf_880c00_8d1d34(u32 mode);
__attribute__((section(".textlate"))) void mac_set_880bf0_mode_fw(u32 mode);
__attribute__((section(".textlate"))) void mac_set_880afc_bits26_31_fw(u32 on);
__attribute__((section(".textlate"))) void pcie_apply_mode_fw_8825c0(u32 mode);
__attribute__((section(".textlate"))) void hwd_phy_enable_880a80(u32 on);
__attribute__((section(".textlate"))) void hwd_phy_enable_880b00(u32 on);
__attribute__((section(".textlate"))) void hwd_phy_uses_rgf_880c00_8d1d04(u32 on);
__attribute__((section(".textlate"))) void hwd_pcie_set_clk_gating(u32 on);
__attribute__((section(".textlate"))) void hwd_abif_rgf_880b00(u32 on);
__attribute__((section(".textlate"))) void hwd_phy_power_up_seq(u32 on);
__attribute__((section(".textlate"))) void hwd_phy_pwr_fw(u32 value);

/* ============================ power_halt_seq ============================ */
__attribute__((section(".textlate"))) u32 hwd_dma_get_881bf0_bit27(void)
{
    return (MMIO32(HW_RGF_DMA_EP_MISC_ICR_ICR) >> 27) & 1u;
}

__attribute__((section(".textlate"))) void abif_mask_pll_unlock_irq(void)
{
    MMIO32(HW_RGF_CAF_ICR_IMS) = 4u;            /* бит 2 — PLL5 UNLOCK */
}

__attribute__((section(".textlate"))) void hwd_abif_bgap_ctrl(u32 on)
{
    if (on == 1)
        MMIO32(ABIF_SENSOR_BGAP_CTRL) |= 1u;
    else
        MMIO32(ABIF_SENSOR_BGAP_CTRL) &= ~1u;
}

__attribute__((section(".textlate"))) void abif_set_ctrl48_bit18(u32 on)
{
    if (on == 1)
        MMIO32(HW_ABIF_ADC_SAR_VREG_CTRL) |= (1u << 18);
    else
        MMIO32(HW_ABIF_ADC_SAR_VREG_CTRL) &= ~(1u << 18);
}


/* ============================ HW-modes ============================ */

__attribute__((section(".textlate"))) void abif_mode_switch(u32 on)
{
    if (on == 1) {
        hwm_apply_channel_config(0);
        hwd_abif_caf_pwdn_mode(1);
    } else {
        hwd_abif_caf_pwdn_mode(0);
        MMIO32(HW_ABIF_RX_TABLE_CTRL) |= 0x7e000u;
        hwm_apply_channel_config(1);
    }
}

/* hw_modes__program_rf_clocks (0x8d7c3c): vendor зовёт 0x8ced4c (0x8894a0/0x8894a4 б5),
 * не 0x8cebac (0x889488 б27) — прежний порт путал. */
__attribute__((section(".textlate"))) void hw_modes_program_rf_clocks(u32 on)
{
    if (on == 1) {
        hwd_program_889_group(0);
        hwd_abif_fs_off(0);
        hwd_abif_uses_rgf_889480_8ced4c(1);
    } else {
        hwd_abif_uses_rgf_889480_8ced4c(0);
        hwd_abif_fs_on(radio_get_channel(&rf_obj));
        hwd_program_889_group(1);
    }
}

__attribute__((section(".textlate"))) void ut_hw_modes_cmd_0x30b(u32 on)
{
    abif_set_ctrl48_bit18(on == 1 ? 1u : 0u);
}

__attribute__((section(".textlate"))) void hw_modes_enable_pll(void)
{
    abif_mask_pll_unlock_irq();
    hwd_wait_pll_lock();
    hwd_abif_adc_clk_ctrl(0);
    abif_power_up_analog(0);
}

/* СРОК: при reload — загрузка прочитанного TSF обратно (0x0d000006 в mac_reload_tsf64) должна
 * последовать за чтением 0x886eb8 как можно быстрее: всё время между ними TSF теряет
 * (аппаратный срок — 1 мкс, шаг TSF). Путь ~15 инструкций (vendor 0x8e99dc ~15) — потеря
 * < 1 мкс; прерывания НЕ запрещены — ISR между чтением и загрузкой отнимет у TSF всё своё
 * время (десятки мкс): у AP сдвиг TBTT, у STA — до следующего бикона. Достижим только через
 * power_halt_seq с флагами 6 и 10 (UT 0x309), штатные пути его не зовут. */
__attribute__((section(".textlate"))) void mac_set_usec_clk_div(u32 div, u32 reload)
{
    u32 v = (((div >> 1) + 1u) << 16) | div;
    if (reload != 0) {
        u32 tsf[2];
        mac_read_tsf64(0, tsf, 0);
        MMIO32(HW_MAC_USEC_CLK_DIV) = v;
        mac_reload_tsf64(tsf[0], tsf[1]);
    } else {
        MMIO32(HW_MAC_USEC_CLK_DIV) = v;
    }
}

__attribute__((section(".textlate"))) void hw_modes_pll_bypass(void)
{
    hwd_abif_rosc_ctrl(1);
    ut_hw_drivers_cmd_0x203();
    hwd_abif_xtal_ctrl(0);
}

__attribute__((section(".textlate"))) void hw_modes_pll_engage(void)
{
    hwd_abif_xtal_ctrl(1);
    hwd_wait_pll_lock();
    hwd_abif_rosc_ctrl(0);
}

__attribute__((section(".textlate"))) void hw_pll_mode_switch(u32 on, u32 arg)
{
    if (on == 1) {
        if (arg != 0) {
            u32 v = MMIO16(HW_RGF_USER_FW_REV_ID);
            mac_set_usec_clk_div((v == 5) ? 0x28u : 0x26u, 1);
        }
        hw_modes_enable_pll();
    } else {
        hwm_reset_analog_block();
        if (arg != 0)
            mac_set_usec_clk_div(0xa5, 0);
    }
}

__attribute__((section(".textlate"))) void ut_hw_modes_cmd_0x304_fw(u32 on, u32 arg)
{
    if (arg == 0) {
        if (on == 1) {
            hw_modes_pll_bypass();
            MMIO32(HW_ABIF_DVS_CTRL_24) |= 1u;
            hwd_abif_bgap_ctrl(0);
        } else {
            hwd_abif_bgap_ctrl(1);
            MMIO32(HW_ABIF_DVS_CTRL_24) &= ~1u;
            hw_modes_pll_engage();
        }
    }
}

/* Режимы питания 0..4: у всех *_set_power_mode_map vendor проверяет режим через
 * таблицу переходов (ldb.x; 0x80381c/0x803830/0x803958/0x803b60/0x8038f4/0x8038ec —
 * в образе все = {06 06 06 00 06}): режим 3 и режим >= 5 идут на сисассерт, после
 * которого код продолжается с тем же режимом. */
#define POWER_MODE_BAD(m) ((m) >= 5u || (m) == 3u)

/* 0x80381c: таблица переходов vendor hw_modes__apply_power_mode (0x8d7ac0): ldb.x, 5 записей, цель = 0x8d7ae0 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(80381c) __attribute__((aligned(1))) const u8 hw_modes_apply_power_mode_jt[5] = {
    0x06, 0x06, 0x06, 0x00, 0x06,
};

/* hw_modes__apply_power_mode (0x8d7ac0): флаги перечитываются перед каждой проверкой
 * (ld_s r0,[r14,0] перед каждым btst). */
__attribute__((section(".textlate"))) void hw_modes_apply_power_mode(u32 mode, u32 *flags)
{
    volatile u32 *fl = flags;
    if (POWER_MODE_BAD(mode))
        fw_sysassert_fatal((void *)0, 0x12dd);
    if (fl[0] & 1u)  hwd_dma_set_power_mode_map(mode);
    if (fl[0] & 2u)  hwd_pcie_set_mode_map(mode);
    if (fl[0] & 4u)  hwd_phy_uses_rgf_880c00_8d1d34(mode);
    if (fl[0] & 8u)  hwd_mac_set_power_mode_map(mode);
    if (fl[0] & 16u) mac_set_880bf0_mode_fw(mode);
}

/* 0x803830: таблица переходов vendor hwd_dma__set_power_mode_map (0x8d0908): ldb.x, 5 записей, цель = 0x8d0924 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803830) __attribute__((aligned(1))) const u8 hwd_dma_set_power_mode_map_jt[5] = {
    0x06, 0x06, 0x06, 0x00, 0x06,
};

/* hwd_dma__set_power_mode_map (0x8d0908): 0x880bec — extb (нулевое расширение),
 * 0x880c0c — bmsk 0x1b (биты 0..27). */
__attribute__((section(".textlate"))) void hwd_dma_set_power_mode_map(u32 mode)
{
    if (POWER_MODE_BAD(mode))
        fw_sysassert_fatal((void *)0, 0x12dc);
    u32 p = mode_nibbles(mode);
    MMIO32(HW_PWR_MODE_MAP_BE8) = p;
    MMIO32(HW_PWR_MODE_MAP_BEC) = p & 0xffu;
    MMIO32(HW_PWR_MODE_MAP_C0C) = p & 0x0fffffffu;
}

/* 0x803b60: таблица переходов vendor hwd_mac__set_power_mode_map (0x8d0f40): ldb.x, 5 записей, цель = 0x8d0f5c + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803b60) __attribute__((aligned(1))) const u8 hwd_mac_set_power_mode_map_jt[5] = {
    0x06, 0x06, 0x06, 0x00, 0x06,
};

/* hwd_mac__set_power_mode_map (0x8d0f40): 0x886104 — bmsk 0x13 (биты 0..19),
 * 0x886110 — bmsk 0x17 (биты 0..23). */
__attribute__((section(".textlate"))) void hwd_mac_set_power_mode_map(u32 mode)
{
    if (POWER_MODE_BAD(mode))
        fw_sysassert_fatal((void *)0, 0x12db);
    u32 p = mode_nibbles(mode);
    MMIO32(HW_MAC_MODE_MAP_0) = p;
    MMIO32(HW_MAC_MODE_MAP_1) = p;
    MMIO32(HW_MAC_MODE_MAP_2) = p & 0x000fffffu;
    MMIO32(HW_MAC_MODE_MAP_3) = p;
    MMIO32(HW_MAC_MODE_MAP_4) = p;
    MMIO32(HW_MAC_MODE_MAP_5) = p & 0x00ffffffu;
}

/* 0x8038f4: таблица переходов vendor hwd_pcie__set_mode_map (0x8d18e8): ldb.x, 5 записей, цель = 0x8d1904 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(8038f4) __attribute__((aligned(1))) const u8 hwd_pcie_set_mode_map_jt[5] = {
    0x06, 0x06, 0x06, 0x00, 0x06,
};

/* hwd_pcie__set_mode_map (0x8d18e8): 0x882f6c — extw, 0x882f84 — extb (нулевое
 * расширение), 0x882f70..7c — bmsk 0x17 (биты 0..23). */
__attribute__((section(".textlate"))) void hwd_pcie_set_mode_map(u32 mode)
{
    if (POWER_MODE_BAD(mode))
        fw_sysassert_fatal((void *)0, 0x12d8);
    u32 p = mode_nibbles(mode);
    MMIO32(HW_PCIE_PWR_MODE_MAP_0) = p & 0xffff0000u;
    MMIO32(HW_PCIE_PWR_MODE_MAP_1) = p;
    MMIO32(HW_PCIE_PWR_MODE_MAP_2) = p & 0xffffu;
    u32 m = p & 0x00ffffffu;
    MMIO32(HW_PCIE_PWR_MODE_MAP_3) = m;
    MMIO32(HW_PCIE_PWR_MODE_MAP_4) = m;
    MMIO32(HW_PCIE_PWR_MODE_MAP_5) = m;
    MMIO32(HW_PCIE_PWR_MODE_MAP_6) = m;
    MMIO32(HW_PCIE_PWR_MODE_MAP_7) = p;
    MMIO32(HW_PCIE_PWR_MODE_MAP_8) = p & 0xffu;
}

/* 0x8038ec: таблица переходов vendor hwd_phy__uses_rgf_880c00_8d1d34 (0x8d1d34): ldb.x, 5 записей, цель = 0x8d1d50 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(8038ec) __attribute__((aligned(1))) const u8 hwd_phy_uses_rgf_880c00_8d1d34_jt[5] = {
    0x06, 0x06, 0x06, 0x00, 0x06,
};

/* hwd_phy__set_power_mode_map (0x8d1d34): 0x880c08 — bmsk 0x1b (биты 0..27). */
__attribute__((section(".textlate"))) void hwd_phy_uses_rgf_880c00_8d1d34(u32 mode)
{
    if (POWER_MODE_BAD(mode))
        fw_sysassert_fatal((void *)0, 0x12da);
    u32 p = mode_nibbles(mode);
    MMIO32(HW_PWR_MODE_MAP_C04) = p;
    MMIO32(HW_PWR_MODE_MAP_C08) = p & 0x0fffffffu;
}

/* 0x803958: таблица переходов vendor mac__set_880bf0_mode_fw (0x8d0144): ldb.x, 5 записей, цель = 0x8d0160 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803958) __attribute__((aligned(1))) const u8 mac_set_880bf0_mode_fw_jt[5] = {
    0x06, 0x06, 0x06, 0x00, 0x06,
};

/* (0x8d0144): младший байт 0x880bf0 = extb(mode<<4 | mode) (нулевое расширение). */
__attribute__((section(".textlate"))) void mac_set_880bf0_mode_fw(u32 mode)
{
    if (POWER_MODE_BAD(mode))
        fw_sysassert_fatal((void *)0, 0x12d7);
    MMIO32(HW_PWR_MODE_MAP_BF0) = (MMIO32(HW_PWR_MODE_MAP_BF0) & ~0xffu) | ((mode | (mode << 4)) & 0xffu);
}

/* hwm__apply_mode_flags (0x8d7818): флаги перечитываются перед каждой проверкой. */
__attribute__((section(".textlate"))) void hwm_apply_mode_flags(u32 mode, u32 *flags)
{
    volatile u32 *fl = flags;
    if (fl[0] & 1u)  mac_set_880afc_bits26_31_fw(mode);
    if (fl[0] & 2u)  pcie_apply_mode_fw_8825c0(mode);
    if (fl[0] & 4u)  hwd_phy_enable_880a80(mode);
    if (fl[0] & 8u)  hwd_pcie_set_clk_gating(mode);
    if (fl[0] & 16u) hwd_abif_rgf_880b00(mode);
}

__attribute__((section(".textlate"))) void ut_hw_modes_cmd_0x308(u32 on, u32 *flags)
{
    u32 f = *flags;
    if (on != 0) {
        if (f & 1u) hwd_phy_power_up_seq(1);
        if (f & 2u) hw_modes_apply_power_mode(4, flags + 1);
        if (f & 8u) hwm_apply_mode_flags(1, flags + 2);
    } else {
        if (f & 8u) hwm_apply_mode_flags(0, flags + 2);
        if (f & 1u) hwd_phy_power_up_seq(0);
        if (f & 4u) hwd_pcie_set_low_power(0);
        if (f & 2u) hw_modes_apply_power_mode(0, flags + 1);
    }
}

/* ============================ PHY ============================ */

/* (0x8d2158) */
__attribute__((section(".textlate"))) void hwd_phy_enable_880b00(u32 on)
{
    if (on != 0) {
        MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_1) |= 0x3fu;
        MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_0) = (MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_0) & 0x3ffffu) | 0xfffc0000u;
        MMIO32(HW_RGF_USER_CLKS_CTL_EXT_SW_RST_VEC_1) |= 0xfu;
    } else {
        MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_1) &= ~0x3fu;
        MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_0) &= 0x3ffffu;
        MMIO32(HW_RGF_USER_CLKS_CTL_EXT_SW_RST_VEC_1) &= ~0xfu;
    }
}

/* (0x8d1b2c) */
__attribute__((section(".textlate"))) void hwd_phy_enable_880a80(u32 on)
{
    if (on != 0) {
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) = (MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) & 0x3ffffu) | 0xfffc0000u;
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_1) |= 0x3fu;
        MMIO32(HW_CLKS_CTL_EXT_CLK_VEC_1) |= 0xfu;
    } else {
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) &= 0x3ffffu;
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_1) &= ~0x3fu;
        MMIO32(HW_CLKS_CTL_EXT_CLK_VEC_1) &= ~0xfu;
    }
}

/* (0x8d1d04): три отдельных RMW 0x880c78 — биты 3, 4, 5 по одному (как vendor). */
__attribute__((section(".textlate"))) void hwd_phy_uses_rgf_880c00_8d1d04(u32 on)
{
    if (on != 0) {
        MMIO32(HW_PHY_PWR_CTL) &= ~(1u << 3);
        MMIO32(HW_PHY_PWR_CTL) &= ~(1u << 4);
        MMIO32(HW_PHY_PWR_CTL) &= ~(1u << 5);
    } else {
        MMIO32(HW_PHY_PWR_CTL) |= 1u << 3;
        MMIO32(HW_PHY_PWR_CTL) |= 1u << 4;
        MMIO32(HW_PHY_PWR_CTL) |= 1u << 5;
    }
}

/* hwd_phy__power_up_seq (0x8d7b84). on != 0: режим 4, включить 0x880b00/0x880a80/
 * 0x880c78[5:3], hwd_phy_pwr_fw(0); on == 0: hwd_phy_pwr_fw(1), всё обратно, режим 0,
 * hwd_phy_init (0x8d1ccc) последним. */
__attribute__((section(".textlate"))) void hwd_phy_power_up_seq(u32 on)
{
    if (on != 0) {
        hwd_phy_uses_rgf_880c00_8d1d34(4);
        hwd_phy_enable_880b00(1);
        hwd_phy_enable_880a80(1);
        hwd_phy_uses_rgf_880c00_8d1d04(1);
        hwd_phy_pwr_fw(0);
    } else {
        hwd_phy_pwr_fw(1);
        hwd_phy_uses_rgf_880c00_8d1d04(0);
        hwd_phy_enable_880a80(0);
        hwd_phy_enable_880b00(0);
        hwd_phy_uses_rgf_880c00_8d1d34(0);
        hwd_phy_init();
    }
}

/* hwd_phy__pwr (0x8d1e68): 0x880c78[2:0] = value, ожидание того же в 0x880c7c[2:0]
 * (до 200 опросов). vendor трижды проверяет value & ~1 (0xaf/0xb0/0xb1 — после
 * вернувшегося сисассерта идут следующие), после журнала/ассерта 0x1334 ещё раз
 * сравнивает и пишет emit3(1, 0x101d9f0, b0, b1, b2). */
__attribute__((section(".textlate"))) void hwd_phy_pwr_fw(u32 value)
{
    u32 bad = value & ~1u;
    if (bad != 0)
        fw_sysassert_fatal((void *)0, 0xaf);
    if (bad != 0)
        fw_sysassert_fatal((void *)0, 0xb0);
    if (bad != 0)
        fw_sysassert_fatal((void *)0, 0xb1);
    u32 t = (MMIO32(HW_PHY_PWR_CTL) & ~1u) | value;
    t = (t & ~2u) | (value << 1);
    t = (t & ~4u) | (value << 2);
    MMIO32(HW_PHY_PWR_CTL) = t;
    u32 b0 = 0, b1 = 0, b2 = 0, i;
    for (i = 0; i < 0xc8; i++) {
        u32 v = MMIO32(HW_PHY_PWR_STATUS);
        b0 = v & 1u;
        b1 = (v >> 1) & 1u;
        b2 = (v >> 2) & 1u;
        if (value == b0 && value == b1 && value == b2)
            break;
    }
    if (!(value == b0 && value == b1 && value == b2)) {
        fw_log_emit0(0, 0x101d828);
        fw_log_emit3(0, 0x101d9f0, b0, b1, b2);   /* vendor печатал биты после ассерта — недостижимо */
        fw_sysassert_fatal((void *)0, 0x1334);
    }
    if (!(value == b0 && value == b2 && value == b1))
        fw_log_emit3(1, 0x101d9f0, b0, b1, b2);
}

/* ============================ PCIe/mac apply-mode ============================ */

/* (0x8d04b8) */
__attribute__((section(".textlate"))) void mac_set_880afc_bits26_31_fw(u32 on)
{
    if (on != 0)
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) = (MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) & 0x43ffffffu) | 0xbc000000u;
    else
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) &= 0x43ffffffu;
}

/* (0x8d00cc) */
__attribute__((section(".textlate"))) void hwd_abif_rgf_880b00(u32 on)
{
    if (on != 0)
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_3) = (MMIO32(HW_CLKS_CTL_SW_CLK_VEC_3) & ~0x1b0u) | 0x1b0u;
    else
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_3) &= ~0x1b0u;
}

/* hwd_pcie__set_clk_gating (0x8d0e5c): 0x880af4 |= 0x1d << 13 = 0x3a000. */
__attribute__((section(".textlate"))) void hwd_pcie_set_clk_gating(u32 on)
{
    if (on != 0) {
        MMIO32(HW_CLKS_CTL_EXT_CLK_VEC_0) = 0x3ff7ffu | (MMIO32(HW_CLKS_CTL_EXT_CLK_VEC_0) & 0xffc00800u);
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) = (MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) & 0xfffc5fffu) | (0x1du << 13);
    } else {
        MMIO32(HW_CLKS_CTL_EXT_CLK_VEC_0) &= 0xffc00800u;
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) &= 0xfffc5fffu;
    }
}

/* (0x8d10c8): [0x8825c0] читается сразу после hwd_pcie_is_ep_under_serdes — и тогда,
 * когда дальше выход. */
__attribute__((section(".textlate"))) void pcie_apply_mode_fw_8825c0(u32 mode)
{
    u32 serdes = hwd_pcie_is_ep_under_serdes();
    u32 r14 = MMIO32(HW_PCIE_MODE_FLAGS);
    if (serdes != 0)
        return;
    u32 flag = ((r14 >> 2) & 1u) || ((r14 >> 3) & 1u);
    mac_set_880afc_bits9_11(flag & mode);
    mac_set_bits_880af4_f8_fc((r14 & 1u) & mode);
    u32 b1 = (r14 >> 1) & 1u;
    mac_set_880af8_afc_b25_b5(b1 & mode);
    mac_set_880af8_afc_b30_b6(b1 & mode);
}
