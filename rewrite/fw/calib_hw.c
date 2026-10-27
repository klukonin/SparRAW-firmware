// SPDX-License-Identifier: AGPL-3.0-or-later
/* Калибровка RF/PHY: листовые аксессоры регистров (порт vendor 6.2.0.1000) — ABIF
 * (таблицы RX/TX 0x88a000/0x88a208, SAR DC 0x88af10, 0x88ae../0x88af..), PHY (0x883xxx/
 * 0x884xxx/0x885xxx: корреляция, SAR, self-режимы, singen), MAC (0x886200/0x886dc8),
 * RFC-поля и hw_modes. Прототипы — include/calib.h. */
#include "types.h"
#include "hw.h"
#include "arc.h"
#include "calib.h"
#include "dbg.h"
#include "rf_obj.h"
#include "fwdata.h"

/* Внешние функции (другие файлы fw/). */

#define CALLER() ((void *)__builtin_return_address(0))

/* hwd_abif_battery_config (0x8ce534): выбрать порог battery-детектора calib_battery_thr[a]
 * ([gp+0xf4+a]) в поле
 * 0x88afbc[7:4] (b != 1) или [3:0] (b == 1; другое поле — 0), одна запись, затем
 * задержка lp 800 × 2 nop. */
void hwd_abif_battery_config(u32 a, u32 b)
{
    u32 lo, hi, v;

    if (a >= 4) {
        fw_log_emit1(6, 0x101ef34, a);
        fw_sysassert_fatal(CALLER(), 0x1306);
    }
    if (b == 1) {
        hi = calib_battery_thr[a];
        lo = 0;
    } else {
        lo = calib_battery_thr[a];
        hi = 0;
    }
    if (lo & ~0xfu)
        fw_sysassert_fatal(CALLER(), 0xad);
    if (hi & ~0xfu)
        fw_sysassert_fatal(CALLER(), 0xae);
    v = MMIO32(ABIF_BATTERY_CONFIG);
    v = (v & ~0xf0u) | (lo << 4);
    v = (v & ~0xfu) | hi;
    MMIO32(ABIF_BATTERY_CONFIG) = v;
    arc_zol_nops2(800);                     /* vendor 0x8ce59a: lp 800 × 2 nop_s */
}

/* hwd_abif__get_88af00 (0x8ce5d8): инверсия бита 0 регистра 0x88af40. */
u32 hwd_abif_get_88af00(void)
{
    return (MMIO32(ABIF_CTRL_40) ^ 1u) & 1u;
}

/* 0x803934: таблица переходов vendor hwd_abif__uses_rgf_88af80_8ce614 (0x8ce614): ldb.x, 16 записей, цель = 0x8ce638 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803934) __attribute__((aligned(1))) const u8 hwd_abif_uses_rgf_88af80_8ce614_jt[16] = {
    0x05, 0x05, 0x00, 0x05, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x05,
};

/* hwd_abif__uses_rgf_88af80_8ce614 (0x8ce614): поле 0x88aff0[4:0]; допустимы 1/2/4/8/16
 * (таблица переходов 0x803934: смещение 5 → без ассерта), иначе ассерт 0x10ad.
 * Возвращает поле в любом случае. */
u32 hwd_abif_uses_rgf_88af80_8ce614(void)
{
    u32 v = MMIO32(ABIF_STAT_F0) & 0x1fu;

    if (v != 1 && v != 2 && v != 4 && v != 8 && v != 16)
        fw_sysassert_fatal(CALLER(), 0x10ad);
    return v;
}

/* hwd_abif__rx_prepare_ifrx_pwdn (0x8cee2c): биты a[2:0] → 0x88ae60[13:11]. */
void hwd_abif_rx_prepare_ifrx_pwdn(u32 a)
{
    u32 b0 = a & 1u;
    u32 b1 = (a & 2u) >> 1;
    u32 b2 = (a & 4u) >> 2;
    u32 v;

    if (b0 & ~1u)
        fw_sysassert_fatal(CALLER(), 0xaf);
    if (b1 & ~1u)
        fw_sysassert_fatal(CALLER(), 0xb0);
    if (b2 & ~1u)
        fw_sysassert_fatal(CALLER(), 0xb1);
    v = MMIO32(ABIF_RX_PREPARE_PWDN);
    v &= ~((1u << 11) | (1u << 12));
    v |= b0 << 11;
    v |= b1 << 12;
    v &= ~(1u << 13);
    v |= b2 << 13;
    MMIO32(ABIF_RX_PREPARE_PWDN) = v;
}

/* hwd_abif__rx_prepared_ifrx_pwdn_get (0x8ceec0): 0x88ae60[13:11]. */
u32 hwd_abif_rx_prepared_ifrx_pwdn_get(void)
{
    return (MMIO32(ABIF_RX_PREPARE_PWDN) >> 11) & 7u;
}

/* hwd_abif__rx_rgf_read_sar_dc (0x8cefa0): 5-битное SAR DC поле канала a (0..7),
 * банк b, половина c: слово 0x88af10[(7-a)/4 + 4b + 2c], байт (7-a)%4. */
u32 hwd_abif_rx_rgf_read_sar_dc(u32 a, u32 b, u32 c)
{
    u32 r3 = (u8)(7 - a);
    u32 idx = (u8)((r3 >> 2) + (b << 2) + (c << 1));
    u32 shift = (r3 & 3u) << 3;

    return (MMIO32(ABIF_SAR_DC + idx * 4) >> shift) & 0x1fu;
}

/* hwd_abif__rx_rgf_sar_dc_load (0x8cefc8): строб загрузки SAR DC — 0x88a204 бит 0: 0, затем 1. */
void hwd_abif_rx_rgf_sar_dc_load(void)
{
    MMIO32(HW_ABIF_RX_TABLE_CTRL) &= ~1u;
    MMIO32(HW_ABIF_RX_TABLE_CTRL) |= 1u;
}

/* hwd_abif__rx_rgf_update_sar_dc (0x8cefdc): добавить дельту c к разности полей SAR DC
 * канала a банка b: lo = слово 4b+(7-a)/4, hi = слово 4b+2+(7-a)/4, байт (7-a)%4.
 * d = clamp(lo - hi + c, -31, 31); d >= 1 → hi = 0, lo = d & 0x3f; иначе lo = 0,
 * hi = (u8)(0x40 - (d & 0x3f)) (при d = 0 это 0x40 — бит 6 байта; так у vendor). */
void hwd_abif_rx_rgf_update_sar_dc(u32 a, u32 b, u32 c)
{
    u32 r1, sh, mask, lo_v, hi_v, w_lo, w_hi;
    volatile u32 *p_lo, *p_hi;
    s32 d;

    if ((s32)a >= 8)
        fw_sysassert_fatal(CALLER(), 0x10b1);
    if ((s32)b >= 2)
        fw_sysassert_fatal(CALLER(), 0x10b2);
    r1 = (u8)(7 - a);
    p_hi = (volatile u32 *)((s32)ABIF_SAR_DC + (u8)((b << 2) + 2 + (r1 >> 2)) * 4);   /* знаковая сумма, как в vendor-коде */
    p_lo = (volatile u32 *)((s32)ABIF_SAR_DC + (u8)((r1 >> 2) + (b << 2)) * 4);
    sh = (r1 & 3u) << 3;
    hi_v = *p_hi;
    lo_v = *p_lo;
    d = (s32)((lo_v >> sh) & 0x1fu) - (s32)((hi_v >> sh) & 0x1fu) + (s32)c;
    if (d < -31)
        d = -31;
    if (d > 0x1f)
        d = 0x1f;
    mask = ~(0x1fu << sh);
    w_hi = hi_v & mask;
    w_lo = lo_v & mask;
    if (d >= 1) {
        *p_hi = w_hi;
        *p_lo = (((u32)d & 0x3fu) << sh) | w_lo;
    } else {
        *p_lo = w_lo;
        *p_hi = w_hi | ((u32)(u8)(0x40 - ((u32)d & 0x3fu)) << sh);
    }
}

/* hwd_abif__set_agc_column (0x8cf080): VGA DC колонок 1..4 строки idx (банк sel) из val[0..3]. */
void hwd_abif_set_agc_column(u32 idx, u32 sel, const u8 *val)
{
    u32 col;

    for (col = 1; col <= 4; col++)
        hwd_abif_rx_table_config_vga_dc(idx, col, sel, val[col - 1]);
}

/* hwd_abif__config_vga_rows (0x8cf0ac): VGA gain колонок 1..4 строки idx (оба банка) из
 * gain[0..3], затем форсировать индекс RX-таблицы idx. */
void hwd_abif_config_vga_rows(u32 idx, const u8 *gain)
{
    u32 col;

    for (col = 1; col <= 4; col++) {
        hwd_abif_rx_table_config_vga_gain(idx, col, 0, gain[col - 1]);
        hwd_abif_rx_table_config_vga_gain(idx, col, 1, gain[col - 1]);
    }
    hwd_abif_rx_table_index_force_mode(0, 0);
    hwd_abif_rx_table_index_force_mode(1, idx);
}

/* hwd_abif__rx_table_config_ifrx_ctrl (0x8cf0f8): 4-битное поле IF RX ctrl
 * (field 1/2/3 → биты 17/21/25) в слове 0x88a214 + idx*16. */
void hwd_abif_rx_table_config_ifrx_ctrl(u32 idx, u32 field, u32 val)
{
    u32 shift, v;
    volatile u32 *reg;

    if ((s32)idx >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x10fd);
    if (field == 1)
        shift = 0x11;
    else if (field == 2)
        shift = 0x15;
    else if (field == 3)
        shift = 0x19;
    else {
        fw_sysassert_fatal(CALLER(), 0x10fe);
        shift = 0;
    }
    reg = (volatile u32 *)(ABIF_RX_TABLE + ((idx << 2) + 3) * 4);
    v = *reg;
    v &= ~(0xfu << shift);
    v |= val << shift;
    *reg = v;
}

/* hwd_abif__rx_table_config_vga_atten (0x8cf250): бит аттенюатора колонки col (2..4, для 1 —
 * ничего) в слове 0x88a208 + (idx*4 + sel + 1)*4; номер бита — abif_rx_vga_atten_sh[(4-col) + 4*sel]
 * (0x800534). */
void hwd_abif_rx_table_config_vga_atten(u32 idx, u32 col, u32 sel, u32 val)
{
    u32 bit, v;
    volatile u32 *reg;

    if ((s32)col >= 5 || (s32)col < 1)
        fw_sysassert_fatal(CALLER(), 0x1300);
    if ((s32)sel >= 2)
        fw_sysassert_fatal(CALLER(), 0x1301);
    if ((s32)idx >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x1302);
    if (col == 1)
        return;
    bit = abif_rx_vga_atten_sh[(u8)(4 - col) + (sel << 2)];
    reg = (volatile u32 *)(ABIF_RX_TABLE + ((idx << 2) + sel + 1) * 4);
    v = *reg;
    v &= ~(1u << bit);
    v |= val << bit;
    *reg = v;
}

/* hwd_abif__rx_table_config_vga_dc (0x8cf36c): 5-битное поле VGA DC колонки col (1..4),
 * банк sel, строка idx: слово 0x88a208 + (idx*4 + w)*4, w/бит — abif_rx_vga_dc_word/_sh
 * (0x800554/0x80055c). */
void hwd_abif_rx_table_config_vga_dc(u32 idx, u32 col, u32 sel, u32 val)
{
    u32 k, word, bit, v;
    volatile u32 *reg;

    if ((s32)col >= 5 || (s32)col < 1)
        fw_sysassert_fatal(CALLER(), 0x10f7);
    if ((s32)sel >= 2)
        fw_sysassert_fatal(CALLER(), 0x10f8);
    if ((s32)idx >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x10f9);
    k = (u8)(4 - col) + (sel << 2);
    word = abif_rx_vga_dc_word[k];
    bit = abif_rx_vga_dc_sh[k];
    reg = (volatile u32 *)(ABIF_RX_TABLE + (word + (idx << 2)) * 4);
    v = *reg;
    v &= ~(0x1fu << bit);
    v |= val << bit;
    *reg = v;
}

/* 0x803944: таблица переходов vendor hwd_abif_rx_table_config_vga_gain (0x8cf418): ldb.x, 6 записей, цель = 0x8cf45e + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803944) __attribute__((aligned(1))) const u8 hwd_abif_rx_table_config_vga_gain_jt[6] = {
    0x12, 0x14, 0x16, 0x18, 0x1a, 0x1c,
};

/* hwd_abif_rx_table_config_vga_gain (0x8cf418): 3-битное поле VGA gain колонки col, банк sel,
 * строка idx. Для колонок 2..4 значение 0..5 переводится в код усилителя (switch по таблице
 * переходов 0x803944): 0→2, 1→1, 2→6, 3→3, 4→5, 5→7; val >= 6 — журнал + ассерт 0x12f9 и
 * запись как есть. Колонка 1 — без перевода. Слово/бит — abif_rx_vga_gain_word/_sh
 * (0x800544/0x80054c). */
void hwd_abif_rx_table_config_vga_gain(u32 idx, u32 col, u32 sel, u32 val)
{
    static const u8 code[6] = { 2, 1, 6, 3, 5, 7 };
    u32 k, word, bit, v;
    volatile u32 *reg;

    if ((s32)col >= 5 || (s32)col < 1)
        fw_sysassert_fatal(CALLER(), 0x10c4);
    if ((s32)sel >= 2)
        fw_sysassert_fatal(CALLER(), 0x10c5);
    if ((s32)idx >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x10f6);
    if (col == 2 || col == 3 || col == 4) {
        if (val < 6) {
            val = code[val];
        } else {
            fw_log_emit3(0x16, 0x101ef7c, idx, col, sel);
            fw_log_emit1(0x16, 0x101efd8, val);
            fw_sysassert_fatal(CALLER(), 0x12f9);
        }
    }
    k = (u8)(4 - col) + (sel << 2);
    word = abif_rx_vga_gain_word[k];
    bit = abif_rx_vga_gain_sh[k];
    reg = (volatile u32 *)(ABIF_RX_TABLE + (word + (idx << 2)) * 4);
    v = *reg;
    v &= ~(7u << bit);
    v |= val << bit;
    *reg = v;
}

/* hwd_abif__rx_table_index_force_en_get (0x8cf59c): 0x88a204 бит 0. */
u32 hwd_abif_rx_table_index_force_en_get(void)
{
    return MMIO32(HW_ABIF_RX_TABLE_CTRL) & 1u;
}

/* abif__get_rx_table_index_force_val (0x8cf5ec): 0x88a204[6:1]. */
u32 abif_get_rx_table_index_force_val(void)
{
    return (MMIO32(HW_ABIF_RX_TABLE_CTRL) >> 1) & 0x3fu;
}

/* hwd_abif__rx_table_read_vga_dc (0x8cf718): прочитать 5-битное поле VGA DC
 * (слово/бит — abif_rx_vga_dc_rd_word/_sh, 0x800584/0x80058c). */
u32 hwd_abif_rx_table_read_vga_dc(u32 idx, u32 col, u32 sel)
{
    u32 k, word, bit;

    if ((s32)col >= 5 || (s32)col < 1)
        fw_sysassert_fatal(CALLER(), 0x1525);
    if ((s32)sel >= 2)
        fw_sysassert_fatal(CALLER(), 0x12d3);
    if ((s32)idx >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x12cf);
    k = (u8)(4 - col) + (sel << 2);
    word = abif_rx_vga_dc_rd_word[k];
    bit = abif_rx_vga_dc_rd_sh[k];
    return (MMIO32(ABIF_RX_TABLE + (word + (idx << 2)) * 4) >> bit) & 0x1fu;
}

/* 0x80394c: таблица переходов vendor hwd_abif_rx_table_read_vga_gain (0x8cf788): ldb.x, 7 записей, цель = 0x8cf7ec + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(80394c) __attribute__((aligned(1))) const u8 hwd_abif_rx_table_read_vga_gain_jt[7] = {
    0x17, 0x15, 0x1b, 0x21, 0x1d, 0x19, 0x1f,
};

/* hwd_abif_rx_table_read_vga_gain (0x8cf788): прочитать 3-битный код VGA gain
 * (слово/бит — abif_rx_vga_gain_rd_word/_sh, 0x800574/0x80057c). Колонки 2..4: обратный перевод кода (switch по
 * таблице 0x80394c): 1→1, 2→0, 3→3, 5→4, 6→2, 7→5; коды 0 и 4 — журнал, результат 7.
 * Колонка 1 — код как есть. */
u32 hwd_abif_rx_table_read_vga_gain(u32 idx, u32 col, u32 sel)
{
    u32 r3, k, word, bit, v;

    if ((s32)col >= 5 || (s32)col < 1)
        fw_sysassert_fatal(CALLER(), 0x12d0);
    if ((s32)sel >= 2)
        fw_sysassert_fatal(CALLER(), 0x12d1);
    if ((s32)idx >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x12cd);
    r3 = (u8)(4 - col);
    k = r3 + (sel << 2);
    word = abif_rx_vga_gain_rd_word[k];
    bit = abif_rx_vga_gain_rd_sh[k];
    v = (MMIO32(ABIF_RX_TABLE + (word + (idx << 2)) * 4) >> bit) & 7u;
    if (r3 != 0 && r3 != 1 && r3 != 2)
        return v;
    switch (v) {
    case 1: return 1;
    case 2: return 0;
    case 3: return 3;
    case 5: return 4;
    case 6: return 2;
    case 7: return 5;
    default:                                 /* 0, 4 */
        /* vendor передаёт в журнал (u8)(4 - col), а не col */
        fw_log_emit3(0x16, 0x101f010, idx, r3, sel);
        return 7;
    }
}

/* abif__agc_field_rmw (0x8cf894): VGA DC := clamp(VGA DC - d, 0, 0x1f) (знаково). */
void abif_agc_field_rmw(u32 idx, u32 col, u32 sel, u32 d)
{
    s32 t = (s32)(hwd_abif_rx_table_read_vga_dc(idx, col, sel) - d);

    if (t < 0)
        t = 0;
    if (t > 0x1f)
        t = 0x1f;
    hwd_abif_rx_table_config_vga_dc(idx, col, sel, (u8)t);
}

/* hwd_abif__sar_cal_dc_rgf_clear_all (0x8cf900): обнулить 8 слов 0x88af10..0x88af2c. */
void hwd_abif_sar_cal_dc_rgf_clear_all(void)
{
    u32 i;

    for (i = 0; i < 8; i++)
        MMIO32(ABIF_SAR_DC + i * 4) = 0;
}

/* hwd_abif__sar_dc_config_rgf_mode (0x8cf91c): 0x88a204 бит 25 := v. */
void hwd_abif_sar_dc_config_rgf_mode(u32 v)
{
    if (v & ~1u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(HW_ABIF_RX_TABLE_CTRL) = (v << 0x19) | (MMIO32(HW_ABIF_RX_TABLE_CTRL) & ~(1u << 0x19));
}

/* hwd_abif__sar_dc_config_rgf_mode_get (0x8cf948): 0x88a204 бит 25. */
u32 hwd_abif_sar_dc_config_rgf_mode_get(void)
{
    return (MMIO32(HW_ABIF_RX_TABLE_CTRL) >> 0x19) & 1u;
}

/* hwd_abif__tx_table_config_dac_fssel (0x8cfc80): 0x88a004 + idx*16, биты [5:0] := v. */
void hwd_abif_tx_table_config_dac_fssel(u32 idx, u32 v)
{
    volatile u32 *reg;

    if ((s32)idx >= 0x20)
        fw_sysassert_fatal(CALLER(), 0x1105);
    reg = (volatile u32 *)(ABIF_TX_TABLE + (idx << 2) * 4);
    *reg = v | (*reg & ~0x3fu);
}

/* hwd_abif__tx_table_config_iftx_ctrl (0x8cfcb4): 4-битное поле IF TX ctrl
 * (field 1/2/3 → биты 5/9/13) в слове 0x88a010 + idx*16. */
void hwd_abif_tx_table_config_iftx_ctrl(u32 idx, u32 field, u32 val)
{
    u32 shift, v;
    volatile u32 *reg;

    if ((s32)idx >= 0x40)
        fw_sysassert_fatal(CALLER(), 0x1120);
    if (field == 1)
        shift = 5;
    else if (field == 2)
        shift = 9;
    else if (field == 3)
        shift = 0xd;
    else {
        fw_sysassert_fatal(CALLER(), 0x1121);
        shift = 0;
    }
    reg = (volatile u32 *)(ABIF_TX_TABLE + ((idx << 2) + 3) * 4);
    v = *reg;
    v &= ~(0xfu << shift);
    v |= val << shift;
    *reg = v;
}

/* hwd_abif__tx_table_config_lo_leak_ctrl (0x8cfd50): 7-битное поле LO-leak ctrl
 * (field 0 → бит 12, 1 → бит 21) в слове 0x88a00c + idx*16. */
void hwd_abif_tx_table_config_lo_leak_ctrl(u32 idx, u32 field, u32 val)
{
    u32 shift, v;
    volatile u32 *reg;

    if ((s32)idx >= 0x20)
        fw_sysassert_fatal(CALLER(), 0x1116);
    if ((s32)field >= 2)
        fw_sysassert_fatal(CALLER(), 0x1117);
    if ((s32)val >= 0x80)
        fw_sysassert_fatal(CALLER(), 0x111c);
    shift = (field == 0) ? 0xc : 0x15;
    reg = (volatile u32 *)(ABIF_TX_TABLE + ((idx << 2) + 2) * 4);
    v = *reg;
    v &= ~(0x7fu << shift);
    v |= val << shift;
    *reg = v;
}

/* hwd_abif__tx_table_config_lo_leak_gain (0x8cfdbc): 2-битное поле LO-leak gain
 * (field 0 → бит 19, 1 → бит 28) в слове 0x88a00c + idx*16. */
void hwd_abif_tx_table_config_lo_leak_gain(u32 idx, u32 field, u32 val)
{
    u32 shift, v;
    volatile u32 *reg;

    if ((s32)idx >= 0x20)
        fw_sysassert_fatal(CALLER(), 0x1106);
    if ((s32)field >= 2)
        fw_sysassert_fatal(CALLER(), 0x110b);
    if ((s32)val >= 4)
        fw_sysassert_fatal(CALLER(), 0x110c);
    shift = (field == 0) ? 0x13 : 0x1c;
    reg = (volatile u32 *)(ABIF_TX_TABLE + ((idx << 2) + 2) * 4);
    v = *reg;
    v &= ~(3u << shift);
    v |= val << shift;
    *reg = v;
}

/* hwd_abif__tx_table_config_xif_gain (0x8cfe9c): биты [19:17] слова 0x88a010 + idx*16 := v. */
void hwd_abif_tx_table_config_xif_gain(u32 idx, u32 v)
{
    volatile u32 *reg;

    if ((s32)idx >= 0x20)
        fw_sysassert_fatal(CALLER(), 0x1127);
    reg = (volatile u32 *)(ABIF_TX_TABLE + ((idx << 2) + 3) * 4);
    *reg = (v << 0x11) | (*reg & ~(7u << 0x11));
}

/* hwd_abif__tx_table_index_force_en_get (0x8cfeec): 0x88a000 бит 0. */
u32 hwd_abif_tx_table_index_force_en_get(void)
{
    return MMIO32(ABIF_TX_TABLE_CTRL) & 1u;
}

/* hwd_abif__tx_table_index_force_mode (0x8cfef8): 0x88a000: бит 0 := mode, [5:1] := idx. */
void hwd_abif_tx_table_index_force_mode(u32 mode, u32 idx)
{
    u32 v;

    if (mode & ~1u)
        fw_sysassert_fatal(CALLER(), 0xad);
    if (idx & ~0x1fu)
        fw_sysassert_fatal(CALLER(), 0xae);
    v = MMIO32(ABIF_TX_TABLE_CTRL);
    v &= ~1u;
    v |= mode;
    v &= ~0x3eu;
    MMIO32(ABIF_TX_TABLE_CTRL) = (idx << 1) | v;
}

/* hwd_abif__tx_table_index_force_val_get (0x8cff3c): 0x88a000[5:1]. */
u32 hwd_abif_tx_table_index_force_val_get(void)
{
    return (MMIO32(ABIF_TX_TABLE_CTRL) >> 1) & 0x1fu;
}

/* hwd_abif__txrx_table_index_lpbk_mode (0x8cff68): индекс TX-таблицы для петли
 * 0x88a000[20:16] := a0, индекс RX-таблицы 0x88a204[24:19] := a1. */
void hwd_abif_txrx_table_index_lpbk_mode(u32 a0, u32 a1)
{
    if (a0 & ~0x1fu)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(ABIF_TX_TABLE_CTRL) = (a0 << 16) | (MMIO32(ABIF_TX_TABLE_CTRL) & 0xffe0ffffu);
    if (a1 & ~0x3fu)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(HW_ABIF_RX_TABLE_CTRL) = (MMIO32(HW_ABIF_RX_TABLE_CTRL) & 0xfe07ffffu) | (a1 << 0x13);
}

/* rf__set_8894a0_field (0x8d0198): 0x8894a0[20:17] := v. */
void rf_set_8894a0_field(u32 v)
{
    if (v & ~0xfu)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(HW_ABIF_DVS_CLK_CFG) = (v << 0x11) | (MMIO32(HW_ABIF_DVS_CLK_CFG) & 0xffe1ffffu);
}

/* abif__set_nibble_all_chains (0x8d01c8): биты [7:4] := v в 0x88af64, 0x88af70, 0x88af7c
 * (проверка v перед каждой записью, как у vendor). */
void abif_set_nibble_all_chains(u32 v)
{
    u32 bad = v & ~0xfu;

    if (bad)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(ABIF_CTRL_64) = (MMIO32(ABIF_CTRL_64) & ~0xf0u) | (v << 4);
    if (bad)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(ABIF_CTRL_70) = (MMIO32(ABIF_CTRL_70) & ~0xf0u) | (v << 4);
    if (bad)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(ABIF_CTRL_7C) = (MMIO32(ABIF_CTRL_7C) & ~0xf0u) | (v << 4);
}

/* abif__set_3bit_all_chains (0x8d0228): xif_gain строк 0 и 1 := v, затем биты [2:0] := v
 * в 0x88af6c, 0x88af78, 0x88af84. */
void abif_set_3bit_all_chains(u32 v)
{
    u32 bad;

    hwd_abif_tx_table_config_xif_gain(0, v);
    hwd_abif_tx_table_config_xif_gain(1, v);
    bad = v & ~7u;
    if (bad)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(ABIF_CTRL_6C) = (MMIO32(ABIF_CTRL_6C) & ~7u) | v;
    if (bad)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(ABIF_CTRL_78) = (MMIO32(ABIF_CTRL_78) & ~7u) | v;
    if (bad)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(ABIF_CTRL_84) = (MMIO32(ABIF_CTRL_84) & ~7u) | v;
}

/* hwd_mac__uses_rgf_886200 (0x8d0fb4): бит 11 регистра 0x886200 = v (0/1). */
void hwd_mac_uses_rgf_886200(u32 v)
{
    if (v & ~1u)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_MAC_PRS_CTRL_0) = (v << 11) | (MMIO32(HW_MAC_PRS_CTRL_0) & ~(1u << 11));
}

/* hwd_mac__trigger_sxd_tx_mode (0x8d1008): три команды в SXD-регистр 0x886dc8. */
void hwd_mac_trigger_sxd_tx_mode(u32 a)
{
    if ((s32)a >= 0x20)
        fw_sysassert_fatal((void *)0, 0x10d9);
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x3d000100u;
    MMIO32(HW_SXD_LOCAL_WR_DATA) = (a << 4) | 0x3e000000u;
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x3d001000u;
}

/* hwd_phy_dbg_clk_enable (0x8d1bc0): бит 0 регистра 0x883d60 = !on (0 = такт включён).
 * Если задана задержка [gp+0x17c] = 0x800300 (≠0): журнал, пауза 80*N циклов по 2 nop,
 * затем задержка сбрасывается (одноразовая). */
void hwd_phy_dbg_clk_enable(u32 on)
{
    u32 v = (on == 0) ? 1u : 0u;
    u32 n;

    if (v & 0xfeu)                       /* bic.f r12,r12,0xffffff01 */
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(PHY_DBG_CLK_GATE) = (MMIO32(PHY_DBG_CLK_GATE) & ~1u) | v;
    if (phy_dbg_clk_delay != 0) {
        fw_log_emit1(0x21, 0x101d6e4, on);
        n = phy_dbg_clk_delay * 80u;   /* asl 4 + add2 = ×80; lp_count */
        arc_zol_nops2(n);              /* vendor 0x8d1bfc: lp n × 2 nop_s (n != 0) */
        phy_dbg_clk_delay = 0;
    }
}

/* hwd_phy__dbg_clk_enable_get (0x8d1c20): инверсия бита 0 регистра 0x883d60. */
u32 hwd_phy_dbg_clk_enable_get(void)
{
    return (MMIO32(PHY_DBG_CLK_GATE) ^ 1u) & 1u;
}

/* hwd_phy_get_rx_swap_iq (0x8d1c30): режим swap IQ приёма по битам 0/1 0x883038
 * (регистр читается дважды: бит 0 из первого чтения, бит 1 — из второго).
 * 0: оба 0; 1: оба 1; 4: только бит 1; 5: только бит 0 (обратно hwd_phy_set_rx_swap_iq). */
u32 hwd_phy_get_rx_swap_iq(void)
{
    u32 v0 = MMIO32(PHY_RX_SWAP_IQ);
    u32 v1 = MMIO32(PHY_RX_SWAP_IQ);
    u32 b0 = v0 & 1u, b1 = (v1 >> 1) & 1u;

    if (b0 == 0 && b1 == 0)
        return 0;
    if (b0 == 1 && b1 == 1)
        return 1;
    if (b1 == 1 && b0 == 0)
        return 4;
    if (b0 == 1 && b1 == 0)
        return 5;
    fw_log_emit2(0x11, 0x101d9a0, b0, b1);   /* недостижимо, как у vendor */
    return 3;
}

/* hwd_phy_get_tx_swap_iq (0x8d1c90): режим swap IQ передачи (биты 0/1 0x884028
 * из двух чтений); биты разные — журнал и 3. */
u32 hwd_phy_get_tx_swap_iq(void)
{
    u32 v0 = MMIO32(PHY_TX_SWAP_IQ);
    u32 v1 = MMIO32(PHY_TX_SWAP_IQ);
    u32 b0 = v0 & 1u, b1 = (v1 >> 1) & 1u;

    if (b0 != b1) {
        fw_log_emit2(0x11, 0x101d950, b0, b1);
        return 3;
    }
    return (v0 & 1u) ? 1u : 0u;
}

/* hwd_phy__rx_agc_index_force_mode (0x8d2218): 0x883048: бит 15 = en, биты 0..14 = индекс
 * (старшие 16 бит регистра сохраняются, кроме бита 15). */
void hwd_phy_rx_agc_index_force_mode(u32 en, u32 idx)
{
    u32 v;

    if (en & ~1u)
        fw_sysassert_fatal((void *)0, 0xad);
    if (idx & 0xffff8000u)
        fw_sysassert_fatal((void *)0, 0xae);
    v = (en << 15) | (MMIO32(PHY_RX_AGC_INDEX_FORCE) & ~(1u << 15));
    MMIO32(PHY_RX_AGC_INDEX_FORCE) = idx | (v & 0xffff8000u);
}

/* hwd_phy__rx_cal_corr (0x8d23a0): запустить корреляционное измерение (0x883010 бит 3),
 * ждать готовности 0x8836ec бит 0 (не более 200000 опросов), прочитать I/Q-суммы
 * 0x8836e4/0x8836e8 в out[0..1]. Таймаут — журнал + ассерт 0x1559 (результат всё равно читается). */
void hwd_phy_rx_cal_corr(s32 *out)
{
    u32 i;

    if (out == 0)
        fw_sysassert_fatal((void *)0, 0x10e0);
    memset0_words(out, 8);
    MMIO32(HW_PHY_RX_CTL) |= 1u << 3;
    for (i = 0; i < 0x30d40; i++)
        if (MMIO32(PHY_RX_CAL_CORR_DONE) & 1u)
            break;
    if (!(MMIO32(PHY_RX_CAL_CORR_DONE) & 1u)) {
        fw_log_emit0(0, 0x101d828);
        fw_sysassert_fatal((void *)0, 0x1559);
    }
    out[0] = (s32)MMIO32(PHY_RX_CAL_CORR_RESULT_I);
    out[1] = (s32)MMIO32(PHY_RX_CAL_CORR_RESULT_Q);
    MMIO32(HW_PHY_RX_CTL) &= ~(1u << 3);
}

/* hwd_phy__rx_cal_corr_config (0x8d2418): [0x883058] = период; 0x883054: бит 1 = en,
 * биты 2..17 = частота коррелятора round((freq << 16) / 2640) (знаковое деление 0x8c02dc). */
void hwd_phy_rx_cal_corr_config(u32 period, u32 en, s32 freq)
{
    s32 n = (s32)((u32)freq << 16);
    s32 q;
    u32 v;

    n = (freq > 0) ? n + 1320 : n - 1320;
    q = fw_divmod_signed(n, 0xa5 << 4);
    MMIO32(PHY_RX_CAL_CORR_LENGTH) = period;
    if (en & ~1u)
        fw_sysassert_fatal((void *)0, 0xad);
    v = MMIO32(PHY_RX_CAL_CORR_CFG);
    v = (v & ~(1u << 1)) | (en << 1);
    v &= 0xfffc0003u;
    MMIO32(PHY_RX_CAL_CORR_CFG) = ((u32)(u16)q << 2) | v;
}

/* hwd_phy__read_sar_sample (0x8d2474): два 32-битных знаковых SAR-отсчёта idx
 * (lo16 из 0x885010/0x885050 + hi16 из 0x885014/0x885054), каждый расширен до s64:
 * out[0..1] = отсчёт A (младшее, знак), out[2..3] = отсчёт B. */
void hwd_phy_read_sar_sample(u32 idx, u32 *out)
{
    u32 lo = MMIO32(PHY_SAR_SAMPLE_A_LO + idx * 8);
    u32 v = (MMIO32(PHY_SAR_SAMPLE_A_HI + idx * 8) << 16) + (u16)lo;

    out[0] = v;
    out[1] = (u32)((s32)v >> 31);
    lo = MMIO32(PHY_SAR_SAMPLE_B_LO + idx * 8);
    v = (MMIO32(PHY_SAR_SAMPLE_B_HI + idx * 8) << 16) + (u16)lo;
    out[2] = v;
    out[3] = (u32)((s32)v >> 31);
}

/* hwd_phy__uses_rgf_883100 (0x8d2568): упаковать 4 индекса AGC (base + d1..d4, каждый
 * ограничен сверху [0x883138] & 0x3f) в поля по 6 бит. */
u32 hwd_phy_uses_rgf_883100(u32 base, u32 d1, u32 d2, u32 d3, u32 d4)
{
    u32 max = MMIO32(PHY_RX_AGC_MAX_INDEX) & 0x3fu;
    u32 v1 = d1 + base, v2 = d2 + base, v3 = d3 + base, v4 = base + d4;

    if (v1 >= max) v1 = max;
    if (v2 >= max) v2 = max;
    if (v3 >= max) v3 = max;
    if (v4 >= max) v4 = max;
    return (v4 << 18) | (v3 << 12) | v1 | (v2 << 6);
}

/* phy__read_rx_counters (0x8d25e8): снимок 14 счётчиков приёма PHY в out[0..13]. */
void phy_read_rx_counters(u32 *out)
{
    out[0]  = MMIO32(PHY_INA_SYNC_COUNTER_DP);
    out[1]  = MMIO32(PHY_SFD_SYNC_COUNTER_SC);
    out[2]  = MMIO32(PHY_SFD_TIMEOUT_COUNTER_DP);
    out[3]  = MMIO32(PHY_CRC_OK_COUNTER_SC);
    out[4]  = MMIO32(HW_PHY_CRC_ERROR_COUNTER_SC);
    out[5]  = MMIO32(PHY_BER_LAST_ZERO_COUNTER_SC);
    out[6]  = MMIO32(PHY_BER_LAST_NON_ZERO_COUNTER_SC);
    out[7]  = MMIO32(PHY_INA_SYNC_COUNTER_CP);
    out[8]  = MMIO32(PHY_SFD_SYNC_COUNTER_CP);
    out[9]  = MMIO32(PHY_SFD_TIMEOUT_COUNTER_CP);
    out[10] = MMIO32(PHY_CRC_OK_COUNTER_CP);
    out[11] = MMIO32(HW_PHY_CRC_ERROR_COUNTER_CP);
    out[12] = MMIO32(PHY_BER_LAST_ZERO_COUNTER_CP);
    out[13] = MMIO32(PHY_BER_LAST_NON_ZERO_COUNTER_CP);
}

/* hwd_phy__rx_ina_det_mode (0x8d2630): режим детектора INA = v (0x883150). */
void hwd_phy_rx_ina_det_mode(u32 v)
{
    MMIO32(HW_PHY_RX_INA_DET_MODE) = v;
}

/* phy__get_rx_ina_det_mode (0x8d263c). */
u32 phy_get_rx_ina_det_mode(void)
{
    return MMIO32(HW_PHY_RX_INA_DET_MODE);
}

/* phy__get_ina_rssi_adc_db (0x8d2648): 6-битный RSSI ADC (0x883700). */
u32 phy_get_ina_rssi_adc_db(void)
{
    return MMIO32(HW_PHY_RX_INA_RSSI_ADC_DB) & 0x3fu;
}

/* hwd_phy__get_883180 (0x8d26bc): 1, если ([0x8831c0] & 0x3f) == 0x21. */
u32 hwd_phy_get_883180(void)
{
    return ((MMIO32(PHY_RX_AGC_STEPS_A) & 0x3fu) == 0x21u) ? 1u : 0u;
}

/* hwd_phy__rx_sar_cal_measurement_config (0x8d28ec): en=0 — сброс бита 0 0x885000;
 * иначе [0x885008]=a4, [0x88500c]=a5, [0x885000] = (a1<<1)+1 + (a2<<4) + (a3<<5) + 0x80. */
void hwd_phy_rx_sar_cal_measurement_config(u32 en, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5)
{
    if (en == 0) {
        MMIO32(PHY_SAR_MEAS_CTL) &= ~1u;
        return;
    }
    MMIO32(PHY_SAR_MEAS_LENGTH_LO) = a4;
    MMIO32(PHY_SAR_MEAS_LENGTH_HI) = a5;
    MMIO32(PHY_SAR_MEAS_CTL) = (a1 << 1) + 1u + (a2 << 4) + (a3 << 5) + 0x80u;
}

/* hwd_phy__rx_sar_measurement_completed (0x8d2920): ждать 0x885004 бит 13 (не более
 * 0x1000000 опросов); таймаут — журнал + ассерт 0x1333 (по последнему прочитанному значению). */
void hwd_phy_rx_sar_measurement_completed(void)
{
    u32 n = 1u << 24;
    u32 v;

    do {
        v = MMIO32(PHY_SAR_MEAS_STATUS);
        n--;
    } while (!(v & (1u << 13)) && n != 0);
    if (!(v & (1u << 13))) {
        fw_log_emit0(0, 0x101d828);
        fw_sysassert_fatal((void *)0, 0x1333);
    }
}

/* hwd_phy__rx_sar_measurement_start (0x8d2958): 0x885000 |= 0x40. */
void hwd_phy_rx_sar_measurement_start(void)
{
    MMIO32(PHY_SAR_MEAS_CTL) |= 0x40u;
}

/* hwd_phy_rx_set_agc_start_val_and_gain_array (0x8d2a6c): [0x88312c] = старт AGC,
 * [0x8831cc] = массив усиления (4 поля). Старт не может превышать ни одно поле
 * (поля сравниваются немаскированными по месту, как у vendor). */
void hwd_phy_rx_set_agc_start_val_and_gain_array(u32 start, u32 arr)
{
    u32 f0 = arr & 0x3fu, f1 = arr & 0xfc0u, f2 = arr & 0x3f000u, f3 = arr & 0xfc0000u;

    if (start > f0 || start > f1 || start > f2 || start > f3) {
        fw_log_emit3(0, 0x101d71c, arr, start, f0);
        fw_log_emit3(0, 0x101d7a0, f1, f2, f3);
        fw_sysassert_fatal((void *)0, 0x146c);
    }
    MMIO32(HW_PHY_RX_INA_AGC_START) = start;
    MMIO32(HW_PHY_RX_INA_AGC_GAIN_ARRAY) = arr;
}

/* hwd_phy__rx_statistics_clear (0x8d2ae4): сброс статистики приёма (0x883960 = 1),
 * время сброса — в 0x800524. */
void hwd_phy_rx_statistics_clear(void)
{
    MMIO32(HW_PHY_RX_STATISTICS_CLEAR) = 1;
    phy_rx_stats_clear_time = u_schd_now();
}

/* hwd_phy__rx_statistics_lock (0x8d2b00): 0x88395c = 1. */
void hwd_phy_rx_statistics_lock(void)
{
    MMIO32(HW_PHY_RX_STATISTICS_LOCK) = 1;
}

/* hwd_phy__self_mode_exit (0x8d2b38): выход из self-TX/RX режимов (импульсы в 0x883004/0x883000). */
void hwd_phy_self_mode_exit(void)
{
    MMIO32(PHY_SELF_MODE_CTL_TX) |= 1u << 1;
    MMIO32(PHY_SELF_MODE_CTL_TX) &= ~1u;
    MMIO32(PHY_SELF_MODE_CTL_TX) |= 1u;
    MMIO32(PHY_SELF_MODE_CTL_TX) &= ~1u;
    MMIO32(PHY_SELF_MODE_CTL_TX) &= ~(1u << 1);
    MMIO32(PHY_SELF_MODE_CTL_RX) |= 1u << 1;
    MMIO32(PHY_SELF_MODE_CTL_RX) &= ~1u;
    MMIO32(PHY_SELF_MODE_CTL_RX) |= 1u;
    MMIO32(PHY_SELF_MODE_CTL_RX) &= ~1u;
    MMIO32(PHY_SELF_MODE_CTL_RX) &= ~(1u << 1);
    MMIO32(PHY_SELF_MODE_CTL_RX) |= 1u << 3;
    MMIO32(PHY_SELF_MODE_CTL_RX) &= ~(1u << 2);
    MMIO32(PHY_SELF_MODE_CTL_RX) |= 1u << 2;
    MMIO32(PHY_SELF_MODE_CTL_RX) &= ~(1u << 2);
    MMIO32(PHY_SELF_MODE_CTL_RX) &= ~(1u << 3);
    MMIO32(HW_PHY_RX_CTL) &= ~0x6u;
}

/* hwd_phy__self_rx_mode_entry (0x8d2ba4): вход в self-RX (0x883000; затем 0x883010 |= 4). */
void hwd_phy_self_rx_mode_entry(void)
{
    MMIO32(PHY_SELF_MODE_CTL_RX) |= 1u << 1;
    MMIO32(PHY_SELF_MODE_CTL_RX) &= ~1u;
    MMIO32(PHY_SELF_MODE_CTL_RX) |= 1u;
    MMIO32(PHY_SELF_MODE_CTL_RX) &= ~1u;
    MMIO32(PHY_SELF_MODE_CTL_RX) |= 1u << 3;
    MMIO32(PHY_SELF_MODE_CTL_RX) &= ~(1u << 2);
    MMIO32(PHY_SELF_MODE_CTL_RX) |= 1u << 2;
    MMIO32(PHY_SELF_MODE_CTL_RX) &= ~(1u << 2);
    MMIO32(HW_PHY_RX_CTL) |= 1u << 2;
}

/* hwd_phy__self_tx_mode_entry (0x8d2be4): вход в self-TX (импульсы 0x883004, затем 0x883000). */
void hwd_phy_self_tx_mode_entry(void)
{
    MMIO32(PHY_SELF_MODE_CTL_TX) |= 1u << 1;
    MMIO32(PHY_SELF_MODE_CTL_TX) &= ~1u;
    MMIO32(PHY_SELF_MODE_CTL_TX) |= 1u;
    MMIO32(PHY_SELF_MODE_CTL_TX) &= ~1u;
    MMIO32(PHY_SELF_MODE_CTL_RX) |= 1u << 3;
    MMIO32(PHY_SELF_MODE_CTL_RX) &= ~(1u << 2);
    MMIO32(PHY_SELF_MODE_CTL_RX) |= 1u << 2;
    MMIO32(PHY_SELF_MODE_CTL_RX) &= ~(1u << 2);
}

/* 0x8038e4: таблица переходов vendor hwd_phy__set_rx_swap_iq (0x8d2c1c): ldb.x, 6 записей, цель = 0x8d2c38 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(8038e4) __attribute__((aligned(1))) const u8 hwd_phy_set_rx_swap_iq_jt[6] = {
    0x00, 0x02, 0x04, 0x0c, 0x07, 0x0a,
};

/* hwd_phy__set_rx_swap_iq (0x8d2c1c): биты 0/1 регистра 0x883038 по режиму (таблица 0x8038e4):
 * 0 → 0/0, 1 → 1/1, 2 → оба = [gp+0xdc] (phy_default_rx_swap_iq), 4 → б0=0,б1=1, 5 → б0=1,б1=0;
 * 3 и ≥6 — ассерт 0x1134, затем 0/0. */
void hwd_phy_set_rx_swap_iq(u32 mode)
{
    u32 b0, b1;

    switch (mode) {
    case 0: b0 = 0; b1 = 0; break;
    case 1: b0 = 1; b1 = 1; break;
    case 2: b0 = (u8)phy_default_rx_swap_iq; b1 = b0; break;   /* vendor ldb: младший байт */
    case 4: b0 = 0; b1 = 1; break;
    case 5: b0 = 1; b1 = 0; break;
    default:
        fw_sysassert_fatal((void *)0, 0x1134);
        b0 = 0; b1 = 0;
        break;
    }
    if (b0 & ~1u)
        fw_sysassert_fatal((void *)0, 0xad);
    if (b1 & ~1u)
        fw_sysassert_fatal((void *)0, 0xae);
    MMIO32(PHY_RX_SWAP_IQ) = (b1 << 1) | (((MMIO32(PHY_RX_SWAP_IQ) & ~1u) | b0) & ~2u);
}

/* hwd_phy__set_tx_swap_iq (0x8d2c98): оба бита 0/1 регистра 0x884028 = v:
 * 0 → 0, 1 → 1, 2 → [gp+0xe0] (phy_default_tx_swap_iq), иначе ассерт 0x112c и 0. */
void hwd_phy_set_tx_swap_iq(u32 mode)
{
    u32 v = 0;

    if (mode == 1)
        v = 1;
    else if (mode == 2)
        v = (u8)phy_default_tx_swap_iq;   /* vendor ldb: младший байт */
    else if (mode != 0)
        fw_sysassert_fatal((void *)0, 0x112c);
    if (v & ~1u)
        fw_sysassert_fatal((void *)0, 0xad);
    if (v & ~1u)
        fw_sysassert_fatal((void *)0, 0xae);
    MMIO32(PHY_TX_SWAP_IQ) = (v << 1) | (((MMIO32(PHY_TX_SWAP_IQ) & ~1u) | v) & ~2u);
}

/* hwd_phy__tx_predist_atten_man_config (0x8d2e48): [0x884130] = en; 0x884134: биты 0..7 = a1,
 * 8..15 = a2 (старшие 16 бит сохраняются). */
void hwd_phy_tx_predist_atten_man_config(u32 en, u32 a1, u32 a2)
{
    MMIO32(PHY_TX_MAN_ATTEN_ENABLE) = en;
    if (a1 & 0xffffff00u)
        fw_sysassert_fatal((void *)0, 0xad);
    if (a2 & 0xffffff00u)
        fw_sysassert_fatal((void *)0, 0xae);
    MMIO32(PHY_TX_ATTEN_VAL) = (a2 << 8) | (a1 & 0xffff00ffu) | (MMIO32(PHY_TX_ATTEN_VAL) & 0xffff0000u);
}

/* hwd_phy__get_884100 (0x8d2ea0): out[0] = бит 0 0x884130, out[1..2] = байты 0/1 0x884134
 * (одно чтение). */
void hwd_phy_get_884100(u8 *out)
{
    u32 v;

    out[0] = (u8)(MMIO32(PHY_TX_MAN_ATTEN_ENABLE) & 1u);
    v = MMIO32(PHY_TX_ATTEN_VAL);
    out[1] = (u8)v;
    out[2] = (u8)(v >> 8);
}

/* hwd_phy__tx_self_transmit (0x8d2f88): self-TX: [0x88400c]=a1 (после фиктивного чтения),
 * 0x884074 биты 0..4 = a2, биты 5..22 = a3, 0x884054 биты 0..15 = n (≥1), [0x884058]=1 (старт). */
void hwd_phy_tx_self_transmit(u32 n, u32 a1, u32 a2, u32 a3)
{
    u32 v;

    if ((s32)n < 1)
        fw_sysassert_fatal((void *)0, 0x10da);
    if (a3 == 0)
        fw_sysassert_fatal((void *)0, 0x10db);
    (void)MMIO32(PHY_TX_SELF_SILENCE);
    MMIO32(PHY_TX_SELF_SILENCE) = a1;
    if (a2 & ~0x1fu)
        fw_sysassert_fatal((void *)0, 0xac);
    v = MMIO32(PHY_TX_SELF_PLCP);
    MMIO32(PHY_TX_SELF_PLCP) = a2 | (v & ~0x1fu);
    if (a3 & 0xfffc0000u)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(PHY_TX_SELF_PLCP) = (MMIO32(PHY_TX_SELF_PLCP) & 0xff80001fu) | (a3 << 5);
    if (n & 0xffff0000u)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(PHY_TX_SELF_NFRAMES) = n | (MMIO32(PHY_TX_SELF_NFRAMES) & 0xffff0000u);
    MMIO32(PHY_TX_SELF_START) = 1;
}

/* hwd_phy__tx_self_transmit_wait_completion (0x8d3024): ждать окончания self-TX:
 * счётчик 0x8840f0 (16 бит) до 0, затем 0x8840ec (22 бита) до 0; пауза 80×2 nop между опросами.
 * ХРУПКО: у vendor оба опроса без предела. На стенде (2026-10-18) после
 * IF_GAIN::GAIN sub 2 — self_transmit(0xffff) (бесконечно) и сразу self_transmit(1) — счётчик
 * иногда не обнуляется: fw висел здесь (DBG_TIMER0_PC в этой функции, стек
 * calib_silent_rssi → if_gain → IF_GAIN_GAIN), скан не завершался, ассоциации нет —
 * 3 прогона из 23 (vendor 0 из 16; код идентичен, вероятно иная длительность между стартами).
 * Поэтому предел: SELFTX_POLL_MAX опросов (~20 мс, на порядки дольше штатного завершения), по
 * таймауту — счётчик в DBG_SELFTX_TO и выход; передачу гасит штатный выход калибровки
 * (hwd_phy_tx_enable(0)). Пауза между опросами — как у vendor (lp 0x50 × 2 nop_s, 0x8d304e /
 * 0x8d306e). До 2026-10-20 она была C-циклом ≈ в 2,5 раза длиннее vendor, и «~20 мс» выше
 * оценено с ней; с паузой vendor предел по времени соответственно короче, но всё ещё на
 * порядки дольше штатного завершения. */
#define SELFTX_POLL_MAX 20000u
void hwd_phy_tx_self_transmit_wait_completion(void)
{
    u32 n;

    if ((u16)MMIO32(PHY_TX_SELF_NFRAMES) == 0xffffu)
        fw_sysassert_fatal((void *)0, 0x10dc);
    for (n = 0; (u16)MMIO32(PHY_TX_SELF_REMAINING) != 0; n++) {
        if (n >= SELFTX_POLL_MAX)
            goto timeout;
        arc_zol_nops2(0x50);           /* vendor 0x8d304e / 0x8d306e: lp 0x50 × 2 nop_s */
    }
    for (n = 0; MMIO32(PHY_TX_SELF_BUSY) & 0x3fffffu; n++) {
        if (n >= SELFTX_POLL_MAX)
            goto timeout;
        arc_zol_nops2(0x50);           /* vendor 0x8d304e / 0x8d306e: lp 0x50 × 2 nop_s */
    }
    return;
timeout:
    fw_log_emit2(0, LS_FW(SELFTX_TIMEOUT), MMIO32(PHY_TX_SELF_REMAINING) & 0xffffu, MMIO32(PHY_TX_SELF_BUSY));
    *(volatile u32 *)DBG_SELFTX_TO += 1;
    *(volatile u32 *)(DBG_SELFTX_TO + 4) = (MMIO32(PHY_TX_SELF_REMAINING) & 0xffffu) | (MMIO32(PHY_TX_SELF_BUSY) << 16);
}

/* hwd_phy__tx_singen_config (0x8d3090): генератор тона: частоты f0/f1 → round((f << 16) / 2640)
 * в 0x88406c (младшие/старшие 16 бит), амплитуда — 0x884068. */
void hwd_phy_tx_singen_config(s32 f0, s32 f1, u32 amp)
{
    s32 n0 = (s32)((u32)f0 << 16), n1 = (s32)((u32)f1 << 16);
    s32 q0, q1;
    u32 v;

    n0 = (f0 >= 1) ? n0 + 1320 : n0 - 1320;
    q0 = fw_divmod_signed(n0, 0xa5 << 4);
    n1 = (f1 > 0) ? n1 + 1320 : n1 - 1320;
    q1 = fw_divmod_signed(n1, 0xa5 << 4);
    MMIO32(PHY_TX_SINGEN_CONFIG) = amp;
    v = MMIO32(PHY_TX_SINGEN_FREQ);                  /* читается, но старшие биты затираются (extw) */
    v = (u16)((v & 0xffff0000u) | (u32)q0);
    MMIO32(PHY_TX_SINGEN_FREQ) = v | ((u32)(u16)q1 << 16);
}

/* hwd_phy__tx_ctrl_884070 (0x8d30f4). */
void hwd_phy_tx_ctrl_884070(u32 v)
{
    MMIO32(PHY_TX_CTRL_884070) = v;
}

/* hwd_phy__tx_singen_transmit (0x8d3100): включить/выключить генератор тона (0x884064). */
void hwd_phy_tx_singen_transmit(u32 v)
{
    MMIO32(PHY_TX_SINGEN_TRANSMIT) = v;
}

/* rfc__read_field_484 (0x8d32b0): три RGF-регистра RF-модуля rf (484/488/492) в out[0..2]. */
void rfc_read_field_484(u32 rf, u32 *out)
{
    rf = (u8)rf;
    out[0] = hwd_rfc_read_rgf(rf, 484);
    out[1] = hwd_rfc_read_rgf(rf, 488);
    out[2] = hwd_rfc_read_rgf(rf, 492);
}

/* rfc__pack_field_value (0x8d32e4): dst[i] = src[i] с замененными тетрадами: значение
 * a (4 бита) повторено в тетрадах 0..2 (dst[0], dst[1]) и 0..3 (dst[2]). a0 не используется. */
void rfc_pack_field_value(u32 unused, const u32 *src, u32 *dst, u32 a, u32 b, u32 c)
{
    (void)unused;
    dst[0] = (src[0] & 0xfffff000u) | (a & 0xfu) | ((a << 4) & 0xf0u) | ((a << 8) & 0xf00u);
    dst[1] = (src[1] & 0xfffff000u) | (b & 0xfu) | ((b << 4) & 0xf0u) | ((b << 8) & 0xf00u);
    dst[2] = (src[2] & 0xffff0000u) | (c & 0xfu) | ((c << 4) & 0xf0u) | ((c << 8) & 0xf00u)
             | ((c << 12) & 0xf000u);
}

/* hwd__args_to_regs_default (0x8d3380): hwd__args_to_regs(a, 0, 0, 1). */
void hwd_args_to_regs_default(u32 a)
{
    hwd_args_to_regs(a, 0, 0, 1);
}

/* rf_sector_commit_rx (0x8d37dc): RX-сектор b (≤ 0x7f) RF-модулю a (core-fw команда 2). */
void rf_sector_commit_rx(u32 a, u32 b)
{
    if ((s32)b > 0x7f)
        fw_sysassert_fatal((void *)0, 0x114d);
    hwd_rfc_write_core_fw(a, 2, b, 0);
}

/* rf_sector_commit_tx (0x8d40d8): TX-сектор b (≤ 0x7f) RF-модулю a (core-fw команда 3). */
void rf_sector_commit_tx(u32 a, u32 b)
{
    if ((s32)b > 0x7f)
        fw_sysassert_fatal((void *)0, 0x1150);
    hwd_rfc_write_core_fw(a, 3, b, 0);
}

/* ut_hw_drivers_cmd_0x508 (0x8d4104): core-fw команда 0xa: биты 0..6 = idx (≤ 0x7f),
 * биты 7..10 = v (< 0x10). */
void ut_hw_drivers_cmd_0x508(u32 rf, u32 idx, u32 v)
{
    if ((s32)idx > 0x7f)
        fw_sysassert_fatal((void *)0, 0x1556);
    if ((s32)v >= 0x10)
        fw_sysassert_fatal((void *)0, 0x115b);
    hwd_rfc_write_core_fw(rf, 0xa, (idx & 0x7fu) | ((v & 0xfu) << 7), 0);
}

/* hwd__program_rf_regs_seq (0x8d4338): шесть RF-полей строки idx (шаг 192 бита) в банке
 * sel ? 0x8000 : 0x10000 (адрес поля = ((бит) >> 3) & ~3), порядок смещений
 * 0x00/0x20/0x60/0x40/0xa0/0x80; затем, если v6 < 0x10, — команда 0x508(idx, v6). */
void hwd_program_rf_regs_seq(u32 rf, u32 idx, u32 sel, u32 v0, u32 v1, u32 v2, u32 v3, u32 v4,
                             u32 v5, u8 v6)
{
    u32 b = idx * 192u + (sel != 0 ? 0x8000u : 0x10000u);

    rfc_field_write(rf, ((b + 0x00) >> 3) & ~3u, v0, 0);
    rfc_field_write(rf, ((b + 0x20) >> 3) & ~3u, v1, 0);
    rfc_field_write(rf, ((b + 0x60) >> 3) & ~3u, v2, 0);
    rfc_field_write(rf, ((b + 0x40) >> 3) & ~3u, v3, 0);
    rfc_field_write(rf, ((b + 0xa0) >> 3) & ~3u, v4, 0);
    rfc_field_write(rf, ((b + 0x80) >> 3) & ~3u, v5, 0);
    if (v6 < 0x10)
        ut_hw_drivers_cmd_0x508(rf, (u8)idx, v6);
}

/* ut_hw_modes_step (0x8d7358): вкл/выкл аналоговую петлю TX→RX: индексы таблиц петли,
 * 0x88af40, переключатели, 0x88ae6c биты 11..13, 0x88aeb0 биты 7..8, CAF-петля. */
void ut_hw_modes_step(u32 on, u32 tx_idx, u32 rx_idx)
{
    hwd_abif_txrx_table_index_lpbk_mode(tx_idx, rx_idx);
    if (on != 0) {
        u32 v = MMIO32(ABIF_CTRL_40) & 0xfffff0ffu;
        v &= ~1u;
        v |= 1u << 10;
        v |= 1u << 11;
        v &= ~(1u << 4);
        MMIO32(ABIF_CTRL_40) = v;
        hwd_abif_lpbk_mode_switches_config(2, 1, 0);
        MMIO32(ABIF_LPBK_CTRL_6C) |= 0x3800u;
        MMIO32(ABIF_LPBK_SWITCH_0) |= 0x180u;
        hwd_abif_caf_lpbk_mode(1);
    } else {
        hwd_abif_caf_lpbk_mode(0);
        MMIO32(ABIF_CTRL_40) = (MMIO32(ABIF_CTRL_40) & 0xfffff0ffu) | 0x11u;
        hwd_abif_lpbk_mode_switches_config(3, 2, 0);
        MMIO32(ABIF_LPBK_CTRL_6C) &= ~0x3800u;
        MMIO32(ABIF_LPBK_SWITCH_0) &= ~0x180u;
    }
}

/* hwm__set_analog_path (0x8d7528): аналоговая петля калибровки (индексы TX/RX таблиц + переключатели). */
void hwm_set_analog_path(u32 on, u32 tx_idx, u32 rx_idx)
{
    hwd_abif_txrx_table_index_lpbk_mode(tx_idx, rx_idx);
    if (on != 0) {
        hwd_abif_lpbk_mode_switches_config(3, 3, 0);
        hwd_abif_caf_lpbk_mode(1);
    } else {
        hwd_abif_caf_lpbk_mode(0);
        hwd_abif_lpbk_mode_switches_config(3, 2, 0);
    }
}

/* hw_modes__set_loopback (0x8d76ec): on — CAF-петля выкл, переключатели (3,2), SXD TX-режим b;
 * иначе — SXD нейтральный. */
void hw_modes_set_loopback(u32 on, u32 b)
{
    if (on != 0) {
        hwd_abif_caf_lpbk_mode(0);
        hwd_abif_lpbk_mode_switches_config(3, 2, 0);
        hwd_mac_trigger_sxd_tx_mode(b);
    } else {
        hwd_mac_sxd_mode_neutral();
    }
}

/* rfc__write_gain_idx_reg504 (0x8e62dc): RF-регистр 0x504 модуля *p = (a << 4) | b (с проверкой, 6). */
void rfc_write_gain_idx_reg504(const struct rf_obj *p, u32 a, u32 b)
{
    hwd_rfc_write_verify(p->rf_idx, 0x504, (a << 4) | b, 6);
}

/* txrx_sel (0x8ea5f0): RF нет — журнал; dir 0 — TX-сектор, 1 — RX-сектор (байты rf/сектор
 * беззнаковые, extb: сектор ≥ 0x80 даёт ассерт в commit). obj не используется (rf__is_present). */
void txrx_sel(struct rf_obj *obj, u32 rf, u32 dir, u32 sector)
{
    (void)obj;
    if (rf_is_present() == 0) {
        fw_log_emit0(0x10, 0x100522c);
        return;
    }
    if (dir == 0)
        rf_sector_commit_tx((u8)rf, (u8)sector);
    else if (dir == 1)
        rf_sector_commit_rx((u8)rf, (u8)sector);
}
