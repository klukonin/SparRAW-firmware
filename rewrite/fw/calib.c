// SPDX-License-Identifier: AGPL-3.0-or-later
/* Калибровка RF/PHY (порт vendor 6.2.0.1000): движок калибровки (методы классов
 * if_gain / silent_rssi / VGA / LO power / DC-SAR / LO leakage — цели указателей vtable
 * fw_data), SAR и VGA DC, LO power и battery, таблица baseband-gain, IF gain,
 * silent RSSI (sparrow), RF-запись блоками, LO leakage / BER, hwf_calib_all.
 * Листовой доступ к регистрам ABIF/PHY/RFC — fw/calib_hw.c; прототипы — include/calib.h. */
#include "types.h"
#include "brd_if.h"
#include "hw.h"
#include "arc.h"
#include "calib.h"
#include "rf_obj.h"
#include "../include/mbox.h"
#include "fwdata.h"
#include "calib_engine.h"
#include "../include/lmac_cmd.h"
#include "../include/rf_sets.h"

/* Внешние функции (другие файлы fw/). */
struct mem_pool;

/* gp-переменные (gp = 0x800184). */

/* 0x801930: таблица VGA-калибровки (Calib::Measure_VGA_Gains): лимиты строк по столбцам
 * и коды усиления столбцов 1..4 (0xff — нет строки). */
FWDATA(801930) calib_vga_cfg_t calib_vga_cfg = {
    .lim = { { 0x08, 0x04, 0x04, 0x04 } },
    .row = {
        { { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 } },
        { { 0x00, 0x01, 0x03, 0x05, 0xff, 0xff, 0xff, 0xff } },
        { { 0x00, 0x01, 0x03, 0x05, 0xff, 0xff, 0xff, 0xff } },
        { { 0x00, 0x01, 0x03, 0x05, 0xff, 0xff, 0xff, 0xff } },
    },
};

/* 0x80197c: коды IF ctrl (поля 1..3 iftx_ctrl/ifrx_ctrl) по индексу усиления g. */
FWDATA(80197c) u8 calib_if_ctrl_tbl[16][3] = {
    { 0x00, 0x00, 0x00 }, { 0x01, 0x01, 0x08 }, { 0x02, 0x02, 0x08 }, { 0x03, 0x03, 0x08 },
    { 0x04, 0x04, 0x08 }, { 0x05, 0x05, 0x08 }, { 0x06, 0x06, 0x08 }, { 0x07, 0x07, 0x08 },
    { 0x08, 0x08, 0x08 }, { 0x09, 0x09, 0x09 }, { 0x0a, 0x0a, 0x0a }, { 0x0b, 0x0b, 0x0b },
    { 0x0c, 0x0c, 0x0c }, { 0x0d, 0x0d, 0x0d }, { 0x0e, 0x0e, 0x0e }, { 0x0f, 0x0f, 0x0f },
};

/* 0x802224: поправка цели silent RSSI по (число RF − 1). */
FWDATA(802224) calib_row8_t calib_srssi_target_ofs = { { 0x00, 0x03, 0x05, 0x06, 0x07, 0x08, 0x08, 0x09 } };
/* 0x80222c: начальный список модулей (run_calibration_fragment). */
FWDATA(80222c) calib_row8_t calib_srssi_module_list0 = { { 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 } };

/* 0x800c64: таблицы температурных классов silent RSSI 0 и 1 (0x800d04); значения — vendor-образ,
 * классы cls — нули (заполняет calib_classify_by_thresholds). */
FWDATA(800c64) struct calib_srssi_temp_tbl calib_srssi_temp_tbl[2] = {
    {
        .tx_dtype_temp = { 10, 50, 70 },
        .tx_dtype_conf = { 0x40044, 0x40066, 0x40088, 0x400aa },
        .tx_etype_temp = { 0, 0, 0 },
        .tx_etype_conf = { 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0 },
        .rx_dtype_temp = { 10, 50, 70 },
        .rx_dtype_conf = { 0x13059, 0x11088, 0x1005d, 0x100cc },
        .rx_etype_temp = { 10, 50, 70 },
        .rx_etype_conf = { 0x8035, 0x8035, 0x8035, 0x8045, 0x805a, 0x8079, 0x80ab, 0x80cc },
        .rx_2_tx_temp = { 10, 50, 70 },
        .rx_2_tx_offs = { -5, -10, -15, -15 },
    },
    {
        .tx_dtype_temp = { 10, 50, 70 },
        .tx_dtype_conf = { 0x40044, 0x400cc, 0x400cc, 0x400ff },
        .tx_etype_temp = { 10, 50, 70 },
        .tx_etype_conf = { 0x7000, 0x7000, 0x7000, 0x7000, 0x8444, 0x8999, 0x8bbb, 0x8ccc },
        .rx_dtype_temp = { 10, 50, 70 },
        .rx_dtype_conf = { 0x13059, 0x11088, 0x1005d, 0x100cc },
        .rx_etype_temp = { 10, 50, 70 },
        .rx_etype_conf = { 0x8035, 0x8035, 0x8035, 0x8045, 0x805a, 0x8079, 0x80ab, 0x80cc },
        .rx_2_tx_temp = { 10, 50, 70 },
        .rx_2_tx_offs = { 2, 3, 3, 2 },
    },
};

/* 0x801824: дробная часть log2 в единицах шага (if_gain_scale_value: e·0x60546 + tbl[f]·8). */
FWDATA(801824) const u16 if_gain_log2_frac[128] = {
    0x0000, 0x022a, 0x044f, 0x0670, 0x088e, 0x0aa7, 0x0cbc, 0x0ecd,
    0x10da, 0x12e3, 0x14e9, 0x16ea, 0x18e8, 0x1ae3, 0x1cda, 0x1ecd,
    0x20bd, 0x22a9, 0x2492, 0x2678, 0x285a, 0x2a3a, 0x2c16, 0x2dee,
    0x2fc4, 0x3197, 0x3366, 0x3533, 0x36fc, 0x38c3, 0x3a87, 0x3c48,
    0x3e06, 0x3fc1, 0x417a, 0x4330, 0x44e3, 0x4693, 0x4841, 0x49ed,
    0x4b95, 0x4d3c, 0x4edf, 0x5081, 0x5220, 0x53bc, 0x5556, 0x56ee,
    0x5884, 0x5a17, 0x5ba8, 0x5d36, 0x5ec3, 0x604d, 0x61d5, 0x635b,
    0x64de, 0x6660, 0x67e0, 0x695d, 0x6ad9, 0x6c52, 0x6dca, 0x6f3f,
    0x70b3, 0x7224, 0x7394, 0x7502, 0x766e, 0x77d8, 0x7940, 0x7aa7,
    0x7c0b, 0x7d6e, 0x7ecf, 0x802f, 0x818d, 0x82e8, 0x8443, 0x859b,
    0x86f2, 0x8847, 0x899b, 0x8aed, 0x8c3e, 0x8d8c, 0x8eda, 0x9025,
    0x9170, 0x92b8, 0x93ff, 0x9545, 0x9689, 0x97cc, 0x990d, 0x9a4d,
    0x9b8b, 0x9cc8, 0x9e04, 0x9f3e, 0xa077, 0xa1ae, 0xa2e4, 0xa419,
    0xa54c, 0xa67e, 0xa7af, 0xa8de, 0xaa0d, 0xab39, 0xac65, 0xad8f,
    0xaeb9, 0xafe0, 0xb107, 0xb22c, 0xb351, 0xb474, 0xb596, 0xb6b6,
    0xb7d6, 0xb8f4, 0xba11, 0xbb2d, 0xbc48, 0xbd62, 0xbe7b, 0xbf92,
};

/* 0x800508: строка «0 дБ» RX-таблицы (образ 0x2a) и её уровень. */
FWDATA(800508) volatile struct calib_zero_db calib_zero_db = { .row = 0x2a, .level = 0 };

/* 0x8067bc: состояние калибровки IF gain (в образе нули). */
FWDATA(8067bc) struct if_gain_state if_gain_state = { 0 };


/* Задержка vendor `mov r0,n; mov lp_count,r0; nop_s; lp; nop_s; nop_s` (n > 0;
 * 0x8d57b2, 0x8d586a, 0x8d58c0, 0x8d58d6, 0x8d592a, 0x8dc5e4, 0x8e4d48). */
static inline __attribute__((always_inline)) void calib_nop_delay(u32 n)
{
    arc_zol_nops2(n);
}

static s32 calib_abs32(s32 v)
{
    return (v < 0) ? (s32)(0u - (u32)v) : v;   /* ARC abs: |0x80000000| = 0x80000000 */
}

/* lo_power_calib__get_param_d0 (0x8cc390): байт [gp,208] = 0x800254. */
u32 lo_power_calib_get_param_d0(void)
{
    return (calib_lo_power_gc_ctrl);
}

/* calib__results_addr_800a34 (0x8cc394): адрес таблицы результатов 0x800a34. */
u32 *calib_results_addr_800a34(void)
{
    return calib_lo_power_rfc_saved;
}

/* calib__results_addr_800a28 (0x8cc39c): адрес таблицы результатов 0x800a28. */
u32 *calib_results_addr_800a28(void)
{
    return calib_lo_power_rfc_packed;
}

/* lo_power_calib__get_state_obj (0x8cc3a4): байт [gp,209] = 0x800255. */
u32 lo_power_calib_get_state_obj(void)
{
    return (calib_lo_power_stg2_bias);
}

/* lo_power_calib__get_table_idx (0x8cc3a8): байт [gp,210] = 0x800256. */
u32 lo_power_calib_get_table_idx(void)
{
    return (calib_lo_power_xif_gc);
}

/* calib_lo_power__save_level (0x8d3ef4): [gp,175] = 0x800233 = уровень. */
void calib_lo_power_save_level(u32 v)
{
    (calib_lo_power_level) = (u8)v;
}

/* calib_sar_step2 (0x8d47e4): одно SAR-измерение, среднее 8 сэмплов (>>3, 64 бит),
 * коррекция = -(среднее >> (shift-2)), ограниченная запасом SAR DC по всем 8 столбцам
 * (max/min разности половин 0/1 поля 0x88af10), и запись её во все 8 столбцов. */
void calib_sar_step2(u32 shift)
{
    s8 mx[2], mn[2];
    u32 sh = (u8)(shift - 2);
    s64 acc0 = 0, acc1 = 0;
    u32 i, k;
    s32 c0, c1, lim_hi0, lim_lo0, lim_hi1, lim_lo1;
    s8 d0, d1;

    /* vendor: ldw из fw_data 0x803810 (e1 e1) и 0x803812 (1f 1f) — начальные max/min */
    mx[0] = calib_sar_dc_init_max0;
    mx[1] = calib_sar_dc_init_max1;
    mn[0] = calib_sar_dc_init_min0;
    mn[1] = calib_sar_dc_init_min1;
    hwd_phy_rx_sar_measurement_start();
    hwd_phy_rx_sar_measurement_completed();
    for (i = 0; i < 8; i++) {
        s32 s[4];
        hwd_phy_read_sar_sample((u8)i, (u32 *)s);
        acc0 += ((s64)(((u64)(u32)s[1] << 32) | (u32)s[0])) >> 3;
        acc1 += ((s64)(((u64)(u32)s[3] << 32) | (u32)s[2])) >> 3;
    }
    for (i = 0; i < 8; i++) {
        for (k = 0; k < 2; k++) {
            s32 d = (s8)(hwd_abif_rx_rgf_read_sar_dc((u8)i, k, 0) - hwd_abif_rx_rgf_read_sar_dc((u8)i, k, 1));
            if (d > mx[k]) mx[k] = (s8)d;
            if (d < mn[k]) mn[k] = (s8)d;
        }
    }
    c0 = (s8)(0u - (u32)(s32)(acc0 >> sh));
    c1 = (s8)(0u - (u32)(s32)(acc1 >> sh));
    lim_hi0 = (s8)(0x1f - mx[0]);
    lim_lo0 = (s8)(0u - (u32)(mn[0] + 0x1f));
    lim_hi1 = (s8)(0x1f - mx[1]);
    lim_lo1 = (s8)(0u - (u32)(mn[1] + 0x1f));
    if (c0 >= 1)
        d0 = (s8)((lim_hi0 < c0) ? lim_hi0 : c0);
    else
        d0 = (s8)((lim_lo0 > c0) ? lim_lo0 : c0);
    if (c1 >= 1)
        d1 = (s8)((lim_hi1 < c1) ? lim_hi1 : c1);
    else
        d1 = (s8)((lim_lo1 > c1) ? lim_lo1 : c1);
    for (i = 0; i < 8; i++) {
        hwd_abif_rx_rgf_update_sar_dc((u8)i, 0, (u32)(s32)d0);
        hwd_abif_rx_rgf_update_sar_dc((u8)i, 1, (u32)(s32)d1);
    }
}

/* calib__setup_loopback_rx_path (0x8d4d90): захват HW и RX-петля: PHY выкл, петля ABIF
 * выкл, self-режим сброшен; маска RF → hwd__args_to_regs_default, ifrx_pwdn=7,
 * rx_cal_corr_config(0x2000,1,0), self-RX, шаги AGC выкл, INA-детектор 0, петля вкл,
 * форс индекса RX-таблицы 1, swap I/Q RX = 0. */
void calib_setup_loopback_rx_path(void)
{
    hwf_calib_acquire_hw();
    hwd_phy_rx_enable(0);
    hwd_phy_tx_enable(0);
    hwd_abif_caf_lpbk_mode(0);
    hwm_calib_set_loopback_mode(0);
    hwd_phy_self_mode_exit();
    hwd_args_to_regs_default(rf_cfg_get_rf_mask_45e(&rf_obj));
    hwd_abif_rx_prepare_ifrx_pwdn(7);
    hwd_phy_rx_cal_corr_config(1u << 13, 1, 0);
    hwd_phy_self_rx_mode_entry();
    hwd_phy_rx_agc_steps_disable(1);
    hwd_phy_rx_ina_det_mode(0);
    hwm_calib_set_loopback_mode(1);
    hwd_abif_rx_table_index_force_mode(0, 0);
    hwd_abif_rx_table_index_force_mode(1, 1);
    hwd_phy_set_rx_swap_iq(0);
}

/* calib__release_hw_thunk (0x8d4e04): b hwf_calib__release_hw. */
void calib_release_hw_thunk(void)
{
    hwf_calib_release_hw();
}

/* calib_lo_power_substep (0x8d530c): поиск индекса RX-таблицы, при котором измеренная
 * LO-мощность (округлённая >>16, s8) равна цели. Шаг ±1 по знаку ошибки; стоп при
 * точном попадании, ухудшении |ошибки| (откат к прошлому индексу) или осцилляции
 * (ошибка = -прошлая, откат). out[0] = индекс (vendor пишет байт в стек и читает
 * слово — старшие байты там мусор стека; вызывающие берут младший байт), out[1] = мощность. */
void calib_lo_power_substep(u32 *out, u32 idx, u32 target)
{
    u32 base = (calib_lo_power_meas_shift);
    u32 done = 0, prev_idx = 0xff, best = 0xff;
    s32 val = 0, saved = 0xff, prev_d = 0;

    idx = (u8)idx;
    while (done == 0) {
        calib_vga_pt_t meas;
        s32 v, p, d;
        u32 ad;

        hwd_abif_rx_table_index_force_mode(0, 0);
        hwd_abif_rx_table_index_force_mode(1, idx);
        calib_lo_power_measure(idx, base, &meas);
        v = meas.val;
        if (v >= 0)
            p = (v + 0x8000) >> 16;
        else
            p = -((0x8000 - v) >> 16);
        p = (s8)p;
        d = (s8)(target - (u32)p);
        ad = (u8)calib_abs32(d);
        if (d == 0) {
            saved = v;
            done = 1;
        } else if ((s32)best < (s32)ad || d == -prev_d) {
            idx = prev_idx;            /* хуже прошлого или колебание — откат */
            done = 1;
        } else {
            u32 nidx = (d >= 1) ? (u8)(idx - 1) : (u8)(idx + 1);
            saved = v;
            prev_idx = idx;
            idx = nidx;
        }
        val = saved;
        best = ad;
        prev_d = d;
    }
    out[0] = (u8)idx;
    out[1] = (u32)val;
}

/* hwf_calib__restore_path (0x8d5eec): аналоговый путь в исходное, бит 0xb 0x886200 = 0,
 * освободить HW калибровки. */
void hwf_calib_restore_path(void)
{
    hwm_set_analog_path(0, 0, 0);
    hwd_mac_uses_rgf_886200(0);
    hwf_calib_release_hw();
}

/* calib_lo_power__step (0x8d5f78): применить шаг LO-power: 3-битное поле во все цепочки,
 * полубайт во все цепочки, уровень → [gp,175] и поле 0x8894a0, RFC-поля 0x1e4..0x1ec. */
void calib_lo_power_step(u32 bits3, u32 nibble, u32 *fields, u32 level)
{
    abif_set_3bit_all_chains(bits3);
    abif_set_nibble_all_chains(nibble);
    calib_lo_power_save_level(level);
    rf_set_8894a0_field(level);
    rfc_write_field_484(0, fields);
}

/* hwf_calib_lo_power_flow (0x8d5fa8): проверка параметров (режим 0/4/5/6/7, уровни ≤0xe,
 * три поля 1..0xf), чтение RFC-полей 0x484 модуля rf, упаковка трёх полей и шаг. */
u32 hwf_calib_lo_power_flow(u32 mode, u32 nibble, u32 f0, u32 f1, u32 f2, u32 level, u32 rf)
{
    u32 cur[3], packed[3];

    if ((mode != 0 && mode != 4 && mode != 5 && mode != 6 && mode != 7) ||
        (s32)nibble > 0xe || (s32)level > 0xe ||
        f0 == 0 || f1 == 0 || f2 == 0 ||
        f0 > 0xf || f1 > 0xf || f2 > 0xf) {
        fw_log_emit0(0, 0x101bd48);   /* "hwf_calib_lo_power_flow invalid parameters input" */
        return 0;
    }
    memcpy_fw(cur, calib_lo_power_cur_init, 0xc);      /* исходные значения из fw_data */
    memcpy_fw(packed, calib_lo_power_packed_init, 0xc);
    rfc_read_field_484(rf, cur);
    rfc_pack_field_value(rf, cur, packed, f0, f1, f2);
    calib_lo_power_step(mode, nibble, packed, level);
    return 1;
}

/* calib_sar_step (0x8d6134): итерация SAR-калибровки. 8 сэмплов (две 64-битные половины);
 * поштучно (v + 2^idx) >> (idx+1) пишутся в журнал 0x853830/0x853838; при avg != 0 копится
 * среднее (v+4)>>3. Затем для каждого сэмпла поправка = round((avg - v) >> (idx-n)),
 * max|поправки| → сошлось (1), если thr >= 2*max; иначе поправки 8 столбцов уходят в SAR DC
 * (0x88af10) и результат 0. В конце — загрузка SAR DC. */
u32 calib_sar_step(u32 idx, u32 n, u32 avg, u32 thr)
{
    u32 sh = (u8)(idx - n);
    s64 acc0 = 0, acc1 = 0;
    s64 smp[8][2];
    s8 cor0[8], cor1[8];
    u32 i, maxv = 0, res;
    s32 rnd1 = (s32)(1u << (idx & 31));

    for (i = 0; i < 8; i++) {
        s32 s[4];
        s64 v0, v1;
        s32 r;

        hwd_phy_read_sar_sample((u8)i, (u32 *)s);
        v0 = (s64)(((u64)(u32)s[1] << 32) | (u32)s[0]);
        v1 = (s64)(((u64)(u32)s[3] << 32) | (u32)s[2]);
        smp[i][0] = v0;
        smp[i][1] = v1;
        if (v0 >= 0)
            r = (s8)(s32)((v0 + rnd1) >> (idx + 1));
        else
            r = (s8)(0u - (u32)(s32)(((s64)rnd1 - v0) >> (idx + 1)));
        calib_sar_dc_log[0][i] = (u8)r;
        if (v1 >= 0)
            r = (s8)(s32)((v1 + rnd1) >> (idx + 1));
        else
            r = (s8)(0u - (u32)(s32)(((s64)rnd1 - v1) >> (idx + 1)));
        calib_sar_dc_log[1][i] = (u8)r;
        if (avg == 0)
            continue;
        acc0 += (v0 >= 0) ? ((v0 + 4) >> 3) : -((4 - v0) >> 3);
        acc1 += (v1 >= 0) ? ((v1 + 4) >> 3) : -((4 - v1) >> 3);
    }
    for (i = 0; i < 8; i++) {
        s32 rnd = (s32)(1u << ((sh - 1) & 31));
        s64 d;
        s32 r;

        d = acc0 - smp[i][0];
        if (d >= 0)
            r = (s8)(s32)((d + rnd) >> sh);
        else
            r = (s8)(0u - (u32)(s32)((smp[i][0] - acc0 + rnd) >> sh));
        cor0[i] = (s8)r;
        if ((u32)calib_abs32(r) > maxv)
            maxv = (u8)calib_abs32(r);
        d = acc1 - smp[i][1];
        if (d >= 0)
            r = (s8)(s32)((d + rnd) >> sh);
        else
            r = (s8)(0u - (u32)(s32)((smp[i][1] - acc1 + rnd) >> sh));
        cor1[i] = (s8)r;
        if ((u32)calib_abs32(r) > maxv)
            maxv = (u8)calib_abs32(r);
    }
    res = ((s32)thr < (s32)(maxv << 1)) ? 0 : 1;
    if (res == 0) {
        for (i = 0; i < 8; i++) {
            hwd_abif_rx_rgf_update_sar_dc((u8)i, 0, (u32)(s32)cor0[i]);
            hwd_abif_rx_rgf_update_sar_dc((u8)i, 1, (u32)(s32)cor1[i]);
        }
    }
    hwd_abif_rx_rgf_sar_dc_load();
    return res;
}

/* hwf_calib_sar_alg (0x8d60bc): до 5 SAR-итераций (сдвиг n = 1, 0, -1, ...), пока
 * calib_sar_step не сойдётся; при skip_step2 == 0 — финальный шаг calib_sar_step2(0xd).
 * Возврат: 2 — не сошлось, 1 — сошлось не с первой итерации, 0 — с первой. */
u32 hwf_calib_sar_alg(u32 skip_step2, u32 thr, u32 idx)
{
    u32 ok = 0, it = 0;
    s32 n = 1;

    while (ok == 0 && (s32)it < 5) {
        it = (u8)(it + 1);
        hwd_phy_rx_sar_measurement_start();
        hwd_phy_rx_sar_measurement_completed();
        ok = calib_sar_step(idx, (u32)n, 1, thr);
        n = (s8)(n - 1);
    }
    if (it == 5)
        fw_log_emit1(0x16, 0x101c968, it);
    if (skip_step2 == 0)
        calib_sar_step2(0xd);
    if (ok == 0) {
        fw_log_emit0(0x16, 0x101c99c);
        return 2;
    }
    return ((s32)it > 1) ? 1 : 0;
}

/* calib__setup_loopback_hw (0x8d63b0): по флагам — захват HW; петля ABIF (маска RF →
 * args_to_regs_default, write_core_fw_mode1(0), ifrx_pwdn=7, петля, SAR DC из RGF,
 * очистка/загрузка SAR DC, форс индекса RX 0x3f); PHY в self-RX с отладочным тактом;
 * конфиг SAR-измерения с 64-битным периодом 1 << shift. */
void calib_setup_loopback_hw(u32 acquire, u32 abif, u32 phy, u32 sar, u32 shift)
{
    if (acquire != 0)
        hwf_calib_acquire_hw();
    if (abif != 0) {
        hwd_abif_caf_lpbk_mode(0);
        hwm_calib_set_loopback_mode(0);
        hwd_args_to_regs_default(rf_cfg_get_rf_mask_45e(&rf_obj));
        hwd_rfc_write_core_fw_mode1(0);
        hwd_abif_rx_prepare_ifrx_pwdn(7);
        hwm_calib_set_loopback_mode(1);
        hwd_abif_sar_dc_config_rgf_mode(1);
        hwd_abif_sar_cal_dc_rgf_clear_all();
        hwd_abif_rx_rgf_sar_dc_load();
        hwd_abif_rx_table_index_force_mode(0, 0x3f);
        hwd_abif_rx_table_index_force_mode(1, 0x3f);
    }
    if (phy != 0) {
        hwd_phy_rx_enable(0);
        hwd_phy_tx_enable(0);
        hwd_phy_self_mode_exit();
        hwd_phy_self_rx_mode_entry();
        hwd_phy_rx_agc_steps_disable(1);
        hwd_phy_rx_ina_det_mode(0);
        hwd_phy_dbg_clk_enable(1);
        hwd_phy_rx_enable(1);
    }
    if (sar != 0) {
        u32 lo = 1u << (shift & 31);
        hwd_phy_rx_sar_cal_measurement_config(1, 0, 1, 0, lo, (u32)((s32)lo >> 31));
    }
}

/* calib_sar__enable_path (0x8d6460): выключить SAR-измерение (en=0, период 0x2000) и/или
 * освободить HW калибровки. */
void calib_sar_enable_path(u32 sar_off, u32 release)
{
    if (sar_off != 0)
        hwd_phy_rx_sar_cal_measurement_config(0, 0, 1, 0, 0x2000, 0);
    if (release != 0)
        hwf_calib_release_hw();
}

/* 0x8036dc: таблица переходов vendor hwf_calib__release_hw (0x8d64c0): ldb.x, 16 записей, цель = 0x8d6534 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(8036dc) __attribute__((aligned(1))) const u8 hwf_calib_release_hw_jt[16] = {
    0x07, 0x10, 0x2a, 0x30, 0x2a, 0x2a, 0x2a, 0x2a, 0x2a, 0x2a, 0x2a, 0x2a,
    0x2a, 0x2a, 0x2a, 0x16,
};

/* hwf_calib__release_hw (0x8d64c0): вернуть RF/PHY из снимка calib_hw_snap (0x842390, см. acquire);
 * режим петли lpbk_mode: 1 — SXD TX-петля, 2 — калибровочная петля, 4 — ничего,
 * 0x10 — аналоговый путь / ut_hw_modes. */
void hwf_calib_release_hw(void)
{
    if (calib_hw_snap.acquired != 1)
        fw_sysassert_fatal(__builtin_return_address(0), 0x12df);
    calib_hw_snap.acquired = 0;
    hwd_phy_rx_enable(0);
    hwd_phy_tx_enable(0);
    hwd_abif_caf_lpbk_mode(0);
    hwm_calib_set_loopback_mode(0);
    hwd_phy_self_mode_exit();
    hwd_abif_rx_prepare_ifrx_pwdn(calib_hw_snap.ifrx_pwdn);
    hwd_phy_dbg_clk_enable(calib_hw_snap.dbg_clk_en);
    hwd_phy_rx_ina_det_mode(calib_hw_snap.ina_det_mode);
    hwd_abif_sar_dc_config_rgf_mode(calib_hw_snap.sar_dc_rgf_mode);
    hwd_phy_rx_agc_index_force_mode(calib_hw_snap.agc_force_en, calib_hw_snap.agc_force_idx_lo);   /* vendor: ldb младшего байта u16-поля */
    hwd_phy_rx_agc_steps_disable(calib_hw_snap.agc_steps_dis);
    switch (calib_hw_snap.lpbk_mode) {
    case 1:
        hw_modes_set_loopback(1, 1);
        if (calib_hw_snap.self_tx_mode != 0)
            hwd_phy_self_tx_mode_entry();
        break;
    case 2:
        hwm_calib_set_loopback_mode(1);
        if (calib_hw_snap.self_rx_mode != 0)
            hwd_phy_self_rx_mode_entry();
        break;
    case 4:
        break;
    case 0x10:
        if (calib_hw_snap.abif_88af00 != 0)
            ut_hw_modes_step(1, 0, 0);
        else
            hwm_set_analog_path(1, 0, 0);
        if (calib_hw_snap.self_rx_mode != 0)
            hwd_phy_self_tx_mode_entry();
        if (calib_hw_snap.self_tx_mode != 0)
            hwd_phy_self_rx_mode_entry();
        break;
    default:
        fw_sysassert_fatal(__builtin_return_address(0), 0x115c);
        break;
    }
    hwd_phy_tx_enable(calib_hw_snap.tx_en);
    hwd_phy_rx_enable(calib_hw_snap.rx_en);
    hwd_abif_rx_table_index_force_mode(0, calib_hw_snap.rx_tbl_force_val);
    hwd_abif_rx_table_index_force_mode(calib_hw_snap.rx_tbl_force_en, calib_hw_snap.rx_tbl_force_val);
    hwd_abif_tx_table_index_force_mode(0, calib_hw_snap.tx_tbl_force_val);
    hwd_abif_tx_table_index_force_mode(calib_hw_snap.tx_tbl_force_en, calib_hw_snap.tx_tbl_force_val);
    hwd_phy_set_tx_swap_iq(calib_hw_snap.tx_swap_iq);
    hwd_phy_set_rx_swap_iq(calib_hw_snap.rx_swap_iq);
    hwd_phy_tx_predist_atten_man_config(calib_hw_snap.predist_atten[0], calib_hw_snap.predist_atten[1], calib_hw_snap.predist_atten[2]);
    hwd_phy_tx_ctrl_884070(calib_hw_snap.tx_ctrl);
}

/* 0x8036cc: таблица переходов vendor hwf_calib__acquire_hw (0x8d65e8): ldb.x, 16 записей, цель = 0x8d6652 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(8036cc) __attribute__((aligned(1))) const u8 hwf_calib_acquire_hw_jt[16] = {
    0x06, 0x06, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x06,
};

/* hwf_calib__acquire_hw (0x8d65e8): снимок состояния RF/PHY в 0x842390:
 *  +0x00 флаг захвата, +0x04 режим INA-детектора, +0x08 SAR DC из RGF, +0x0c отладочный
 *  такт PHY, +0x10/+0x14(байт) форс индекса RX-таблицы, +0x18 0x8831c0==0x21,
 *  +0x1c/+0x20(u16) форс AGC-индекса 0x883048, +0x24 режим петли ABIF (1/2/4/0x10),
 *  +0x28 0x88af40, +0x2c(байт) ifrx_pwdn, +0x30 0x883010 б2, +0x34 0x883004 б1,
 *  +0x38/+0x3c swap I/Q RX/TX, +0x40 0x883010 б0, +0x44 0x884008 б0,
 *  +0x48..+0x4a 0x884130/0x884134, +0x4b(байт) 0x884070&3, +0x4c/+0x50(байт) форс TX-таблицы. */
void hwf_calib_acquire_hw(void)
{
    u32 m;

    if (calib_hw_snap.acquired != 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x12de);
    calib_hw_snap.acquired = 1;
    calib_hw_snap.ina_det_mode = phy_get_rx_ina_det_mode();
    calib_hw_snap.sar_dc_rgf_mode = hwd_abif_sar_dc_config_rgf_mode_get();
    calib_hw_snap.dbg_clk_en = hwd_phy_dbg_clk_enable_get();
    calib_hw_snap.rx_tbl_force_en = hwd_abif_rx_table_index_force_en_get();
    calib_hw_snap.rx_tbl_force_val = (u8)abif_get_rx_table_index_force_val();
    calib_hw_snap.agc_steps_dis = hwd_phy_get_883180();
    calib_hw_snap.agc_force_en = (MMIO32(PHY_RX_AGC_INDEX_FORCE) >> 15) & 1u;
    calib_hw_snap.agc_force_idx = (u16)(MMIO32(PHY_RX_AGC_INDEX_FORCE) & 0x7fffu);
    m = hwd_abif_uses_rgf_88af80_8ce614();
    calib_hw_snap.lpbk_mode = m;
    if (!(m == 1 || m == 2 || m == 4 || m == 0x10))   /* jump-таблица 0x8036cc */
        fw_sysassert_fatal(__builtin_return_address(0), 0x142b);
    calib_hw_snap.abif_88af00 = hwd_abif_get_88af00();
    calib_hw_snap.ifrx_pwdn = (u8)hwd_abif_rx_prepared_ifrx_pwdn_get();
    calib_hw_snap.self_rx_mode = (MMIO32(HW_PHY_RX_CTL) >> 2) & 1u;
    calib_hw_snap.self_tx_mode = (MMIO32(PHY_SELF_MODE_CTL_TX) >> 1) & 1u;
    calib_hw_snap.rx_swap_iq = hwd_phy_get_rx_swap_iq();
    calib_hw_snap.tx_swap_iq = hwd_phy_get_tx_swap_iq();
    calib_hw_snap.rx_en = MMIO32(HW_PHY_RX_CTL) & 1u;
    calib_hw_snap.tx_en = MMIO32(HW_PHY_TX_EN) & 1u;
    hwd_phy_get_884100(calib_hw_snap.predist_atten);
    calib_hw_snap.tx_ctrl = (u8)(MMIO32(PHY_TX_CTRL_884070) & 3u);
    calib_hw_snap.tx_tbl_force_en = hwd_abif_tx_table_index_force_en_get();
    calib_hw_snap.tx_tbl_force_val = (u8)hwd_abif_tx_table_index_force_val_get();
}

/* calib_vga_gain_step (0x8d66cc): для строк lo..hi RX-таблицы: VGA DC всех столбцов = 0xf,
 * усиление столбцов = [gp,250] (или аттенюатор при [gp,250] < 0), затем по половинам 0/1
 * восстановить столбец c и откалибровать DC столбца c+1 (для c = 4 — снова 4).
 * Возврат — результат последнего hwf_vga_dc__calibrate (1, если lo > hi). */
u32 calib_vga_gain_step(u32 lo, u32 hi)
{
    u32 res = 1, n, idx = lo, col, sel;
    u8 gain[4];

    if ((s32)hi < (s32)lo)
        return 1;
    n = (u8)(hi - lo) + 1;
    do {
        for (col = 1; col < 5; col++) {
            hwd_abif_rx_table_config_vga_dc(idx, col, 0, 0xf);
            hwd_abif_rx_table_config_vga_dc(idx, col, 1, 0xf);
            if ((s8)(calib_vga_dc_fixed_gain) < 0) {
                hwd_abif_rx_table_config_vga_atten(idx, col, 0, 0);
                hwd_abif_rx_table_config_vga_atten(idx, col, 1, 0);
            } else {
                gain[col - 1] = (u8)hwd_abif_rx_table_read_vga_gain(idx, col, 0);
                hwd_abif_rx_table_config_vga_gain(idx, col, 0, (calib_vga_dc_fixed_gain));
                hwd_abif_rx_table_config_vga_gain(idx, col, 1, (calib_vga_dc_fixed_gain));
            }
        }
        for (sel = 0; sel < 2; sel++) {
            for (col = 1; col < 5; col++) {
                if ((s8)(calib_vga_dc_fixed_gain) < 0)
                    hwd_abif_rx_table_config_vga_atten(idx, col, sel, 1);
                else
                    hwd_abif_rx_table_config_vga_gain(idx, col, sel, gain[col - 1]);
                res = hwf_vga_dc_calibrate(idx, sel, (calib_vga_dc_shift), (calib_vga_dc_thr), (col >= 4) ? col : col + 1);
            }
        }
        idx = (u8)(idx + 1);
    } while (--n >= 1);
    return res;
}

/* hwf_vga_dc__calibrate (0x8d67d8): подбор 5-битного VGA DC строки idx (половина sel),
 * начиная со столбца col и спускаясь к столбцу 1: шаг ±1 против знака измеренного DC,
 * при смене знака/нуле/упоре 0 или 0x1f — откат к лучшему значению и переход к столбцу
 * ниже. Остаток DC (s8) пишется в журнал 0x853840 + sel*64 + idx-1.
 * Возврат: 0 — уже был в пределах thr, 1 — довели до thr, 2 — не довели. */
u32 hwf_vga_dc_calibrate(u32 idx, u32 sel, u32 shift, u32 thr, u32 col)
{
    u8 dc[4];
    s32 m, pm;
    u32 neg, pneg, am, pam, cur, prev, need, more, c;

    for (c = 1; c < 5; c++)
        dc[c - 1] = (u8)hwd_abif_rx_table_read_vga_dc(idx, c, (u8)sel);
    hwd_abif_rx_table_index_force_mode(0, 0);
    hwd_abif_rx_table_index_force_mode(1, idx);
    m = hwf_vga_dc_measure(sel, shift);
    neg = (u32)m >> 31;
    am = (u8)calib_abs32(m);
    need = ((s32)thr >= (s32)am) ? 0 : 1;
    more = need;
    cur = dc[col - 1];
    for (;;) {
        pm = m;
        pneg = neg;
        pam = am;
        prev = cur;
        if (more != 1)
            break;
        if (pneg == 0)
            cur = (prev + 1 < 0x1f) ? prev + 1 : 0x1f;
        else
            cur = ((s32)prev - 1 > 0) ? prev - 1 : 0;
        cur = (u8)cur;
        hwd_abif_rx_table_config_vga_dc(idx, col, (u8)sel, cur);
        hwd_abif_rx_table_index_force_mode(0, 0);
        hwd_abif_rx_table_index_force_mode(1, idx);
        m = hwf_vga_dc_measure(sel, shift);
        neg = (u32)m >> 31;
        am = (u8)calib_abs32(m);
        if (neg != pneg || m == 0 || cur == 0x1f || cur == 0) {
            if ((s32)pam < (s32)am) {
                /* прошлое значение было ближе — вернуть его */
                hwd_abif_rx_table_config_vga_dc(idx, col, (u8)sel, prev);
                am = pam;
                neg = pneg;
                m = pm;
            }
            col = (u8)(col - 1);
            if ((s32)col >= 1)
                cur = dc[col - 1];
        }
        if ((s32)am <= (s32)thr)
            more = 0;
        else
            more = ((s32)col > 0) ? 1 : 0;
    }
    if (need == 1) {
        for (c = 1; c < 5; c++)
            (void)hwd_abif_rx_table_read_vga_dc(idx, c, (u8)sel);   /* vendor: чтения без использования */
        if ((s32)idx < 1 || (s32)idx > 0x3f)
            fw_sysassert_fatal(__builtin_return_address(0), 0x12f2);
        calib_vga_dc_log[sel][idx - 1] = (u8)pm;
    }
    if ((s32)thr < (s32)pam)
        return 2;
    return (need == 1) ? 1 : 0;
}

/* hwf_dc_calib_fix_dac1 (0x8d6948): для строк lo..hi RX-таблицы: (mode 1) DC столбцов 2..4
 * обеих половин = 0xf, форс строки, калибровка DC половин 0 и 1 (столбец 1, сдвиг 0xa,
 * порог 2), измерение остатка rx_cal_corr и журнал (I, Q округлённые >>11).
 * mode 2 — без сброса столбцов; иной mode — ассерт 0x117a. */
void hwf_dc_calib_fix_dac1(u32 lo, u32 hi, u32 mode)
{
    s32 res[5];
    u32 cnt, cur, sel;

    if (mode != 1 && mode != 2)
        fw_sysassert_fatal(__builtin_return_address(0), 0x117a);
    if (hi < lo)
        return;
    cnt = hi - lo + 1;
    cur = lo;
    do {
        u32 idx = (u8)cur;
        s32 i, q, ri, rq;

        if (mode == 1) {
            hwd_abif_rx_table_config_vga_dc(idx, 2, 0, 0xf);
            hwd_abif_rx_table_config_vga_dc(idx, 3, 0, 0xf);
            hwd_abif_rx_table_config_vga_dc(idx, 4, 0, 0xf);
            hwd_abif_rx_table_config_vga_dc(idx, 2, 1, 0xf);
            hwd_abif_rx_table_config_vga_dc(idx, 3, 1, 0xf);
            hwd_abif_rx_table_config_vga_dc(idx, 4, 1, 0xf);
        }
        hwd_abif_rx_table_index_force_mode(0, idx);
        hwd_abif_rx_table_index_force_mode(1, idx);
        hwd_phy_rx_cal_corr(res);
        for (sel = 0; sel < 2; sel++)
            hwf_vga_dc_calibrate(idx, sel, 0xa, 2, 1);
        hwd_phy_rx_cal_corr(res);
        i = res[0];
        q = res[1];
        ri = (i >= 0) ? (s8)((i + 1024) >> 11) : (s8)(0u - (u32)((1024 - i) >> 11));
        rq = (q >= 0) ? (s8)((q + 1024) >> 11) : (s8)(0u - (u32)((1024 - q) >> 11));
        fw_log_emit3(0x26, 0x101c8c4, cur, (u32)ri, (u32)rq);
        cur++;
    } while (--cnt >= 1);
}

/* calib__setup_loopback_hw_b (0x8d6a64): как calib__setup_loopback_hw, но без
 * write_core_fw_mode1/SAR DC в ABIF-части и без отладочного такта/AGC в PHY-части
 * (только self-RX и swap I/Q RX = 0); вместо SAR — rx_cal_corr_config(1 << shift, 1, 0). */
void calib_setup_loopback_hw_b(u32 acquire, u32 abif, u32 phy, u32 corr, u32 shift)
{
    if (acquire != 0)
        hwf_calib_acquire_hw();
    if (abif != 0) {
        hwd_abif_caf_lpbk_mode(0);
        hwm_calib_set_loopback_mode(0);
        hwd_args_to_regs_default(rf_cfg_get_rf_mask_45e(&rf_obj));
        hwd_abif_rx_prepare_ifrx_pwdn(7);
        hwm_calib_set_loopback_mode(1);
    }
    if (phy != 0) {
        hwd_phy_rx_enable(0);
        hwd_phy_tx_enable(0);
        hwd_phy_self_mode_exit();
        hwd_phy_self_rx_mode_entry();
        hwd_phy_set_rx_swap_iq(0);
    }
    if (corr != 0)
        hwd_phy_rx_cal_corr_config(1u << (shift & 31), 1, 0);
}

/* hwf_vga_dc__measure (0x8d6ad4): DC через rx_cal_corr (период 1 << shift): Q при sel != 0,
 * иначе I; округление (v ± 2^(shift-1)) >> shift, результат s8. */
s32 hwf_vga_dc_measure(u32 sel, u32 shift)
{
    s32 v[2];
    s32 x, r;
    u32 h = 1u << ((shift - 1) & 31);

    hwd_phy_rx_cal_corr_config(1u << (shift & 31), 1, 0);
    hwd_phy_rx_cal_corr(v);
    x = (sel != 0) ? v[1] : v[0];
    if (x >= 0)
        r = (s32)(h + (u32)x) >> shift;
    else
        r = (s32)(0u - (u32)((s32)(h - (u32)x) >> shift));
    return (s8)r;
}

/* calib__log_if_nonzero (0x8d6b20): при flag != 0 — hwf_calib__release_hw. */
void calib_log_if_nonzero(u32 a, u32 flag)
{
    (void)a;   /* vendor: r0 не читается */
    if (flag != 0)
        hwf_calib_release_hw();
}

/* calib_battery_phy_step (0x8d6b2c): три измерения rx_cal_corr при battery_config 3/2/1
 * (A, B, C; C — в meas), разности |A-B|, |B-C|, |A-C| в лог-шкале против опорных
 * 0x26924925/0x15c92492/0x3c5b6db7 (>> (26-shift)). out: [0] s32 = d(|A-C|) или d(|B-C|),
 * [4] = насыщение A или B, [5] = «слабый» B или C. */
void calib_battery_phy_step(u32 shift, calib_vga_pt_t *out, calib_batt_meas_t *meas)
{
    calib_batt_meas_t a, b;
    s32 dbc, dab, dac, r18, r17, r0;
    u32 sat, weak, big;
    s32 bias = (s32)(1u << ((0x19 - shift) & 31));
    u32 sh = (0x1a - shift) & 31;

    hwd_phy_rx_cal_corr_config(1u << (shift & 31), 1, 0);
    hwd_abif_battery_config(3, 0);
    calib_battery_prepare(&a, shift);
    hwd_abif_battery_config(2, 0);
    calib_battery_prepare(&b, shift);
    hwd_abif_battery_config(1, 0);
    calib_battery_prepare(meas, shift);
    hwd_abif_battery_config(0, 0);

    dbc = calib_abs32(b.i - meas->i);
    weak = (b.weak != 0 || meas->weak != 0) ? 1 : 0;
    dab = calib_abs32(a.i - b.i);
    sat = (a.sat != 0 || b.sat != 0) ? 1 : 0;
    dac = calib_abs32(a.i - meas->i);

    r18 = calib_delta((u32)(dbc >> 2), (u32)((s32)(bias + 0x15c92492) >> sh), shift);
    r17 = calib_delta((u32)(dac >> 2), (u32)((s32)(bias + 0x3c5b6db7) >> sh), shift);
    r0 = calib_delta((u32)(dab >> 2), (u32)((s32)(bias + 0x26924925) >> sh), shift);
    out->val = r17;
    out->b[CALIB_LOP_SAT] = (u8)sat;
    out->b[CALIB_LOP_WEAK] = (u8)weak;
    big = (calib_abs32(r18 - r0) > 0x8000) ? 1 : 0;
    if ((a.sat == 0) && big)
        out->val = r18;
    if (a.sat == 1 && b.sat == 0 && meas->weak == 0) {
        out->val = r18;
        out->b[CALIB_LOP_SAT] = 0;
    }
}

/* calib__delta (0x8d6c7c): if_gain__scale_value(a, c) - if_gain__scale_value(b, c). */
s32 calib_delta(u32 a, u32 b, u32 c)
{
    s32 x = (s32)if_gain_scale_value(a, c);
    return x - (s32)if_gain_scale_value(b, c);
}

/* calib_lo_power_measure (0x8d6ca0): LO-мощность строки idx (idx > 0x3f — одно измерение
 * battery без коррекции). Иначе: измерения, пока out[5]/out[4] == 1; при out[5] == 1 первый
 * раз — временная коррекция VGA DC столбца 1 на corr = [gp,147]+2 - (B >> (shift+2))
 * (с подгонкой ±1 по фактическому полю); out[5] == 0 и мощность < -15 — out[5] = 1, стоп.
 * В конце временная коррекция снимается. out: s32 мощность, [4], [5] — флаги. */
void calib_lo_power_measure(u32 idx, u32 shift, calib_vga_pt_t *res)
{
    u8 *out = res->b;      /* флаги: out[CALIB_LOP_SAT] / out[CALIB_LOP_WEAK] */
    calib_batt_meas_t tmp;
    u32 applied = 0, stop = 0;
    s32 corr = 0;
    u32 ref;

    if ((s32)idx > 0x3f) {
        calib_battery_phy_step(shift, res, &tmp);
        return;
    }
    out[CALIB_LOP_WEAK] = 1;
    out[CALIB_LOP_SAT] = 1;
    ref = (u8)((calib_lo_power_low_thr) + 2);
    hwd_abif_rx_table_index_force_mode(0, 0);
    hwd_abif_rx_table_index_force_mode(1, idx);
    while ((out[CALIB_LOP_WEAK] == 1 || out[CALIB_LOP_SAT] == 1) && stop == 0) {
        calib_battery_phy_step(shift, res, &tmp);
        if (out[CALIB_LOP_WEAK] == 1 && applied == 0) {
            s32 dc, d;
            corr = (s8)(ref - (u32)(tmp.i >> (shift + 2)));
            dc = (s32)hwd_abif_rx_table_read_vga_dc(idx, 1, 0);
            if (dc - corr == -1)
                corr = (s8)(corr - 1);
            d = dc - corr;
            if (d < 0) {
                stop = 1;
                continue;
            }
            if (d >= 3)
                corr = (s8)(corr + 1);
            abif_agc_field_rmw(idx, 1, 0, (u32)corr);
            hwd_abif_rx_table_index_force_mode(0, 0);
            hwd_abif_rx_table_index_force_mode(1, idx);
            applied = 1;
            continue;
        }
        if (out[CALIB_LOP_SAT] == 1 || (out[CALIB_LOP_WEAK] == 1 && applied == 1)) {
            stop = 1;
            continue;
        }
        if (out[CALIB_LOP_WEAK] == 0 && applied == 1) {
            s32 v = res->val, p;
            if (v >= 0)
                p = (v + 0x8000) >> 16;
            else
                p = -((0x8000 - v) >> 16);
            if (p < -15) {
                out[CALIB_LOP_WEAK] = 1;
                stop = 1;
            }
        }
    }
    if (applied != 1)
        return;
    abif_agc_field_rmw(idx, 1, 0, (u32)(s32)(s8)(0u - (u32)corr));
    hwd_abif_rx_table_index_force_mode(0, 0);
    hwd_abif_rx_table_index_force_mode(1, idx);
}

/* calib_battery__prepare (0x8d6e20): одно rx_cal_corr: out[0..7] = (I, Q),
 * out[8] = |I| > 0x1d << (shift+2) (насыщение), out[9] = |I| < [gp,147] << (shift+2). */
void calib_battery_prepare(calib_batt_meas_t *out, u32 shift)
{
    s32 v[2];
    s32 a;
    u32 sh = shift + 2;

    out->sat = 0;
    out->weak = 0;
    hwd_phy_rx_cal_corr(v);
    a = calib_abs32(v[0]);
    if (!((s32)(0x1du << sh) >= a))
        out->sat = 1;
    if (!(a >= (s32)((u32)(calib_lo_power_low_thr) << sh)))
        out->weak = 1;
    out->i = v[0];
    out->q = v[1];
}

/* calib_lo_power__step_save_mode (0x8dc64c): запомнить указатель полей в [gp,-34*4]
 * = 0x8000fc и выполнить шаг LO-power. */
void calib_lo_power_step_save_mode(u32 bits3, u32 nibble, u32 *fields, u32 level)
{
    calib_lo_power_fields = (u32)fields;
    calib_lo_power_step(bits3, nibble, fields, level);
}

/* calib_lo__set_result (0x8f1d08): p[0..3] = a, b, c, d. */
void calib_lo_set_result(u32 *p, u32 a, u32 b, u32 c, u32 d)
{
    p[0] = a;
    p[1] = b;
    p[2] = c;
    p[3] = d;
}

/* Типы аргументов VGA/BB-калибровки. vendor передаёт их ПО ЗНАЧЕНИЮ (4/8-байтные
 * структуры в парах регистров и на стеке): лимиты столбцов, 4 строки по 8 кодов
 * усиления, точка измерения {мощность, 4 индекса}. */

/* Calib::Measure_VGA_Gains (0x8d4a08): до 3 попыток hwf_calib_bb_gain_rows по таблице
 * 0x801930; при успехе (1) — построить таблицу усиления (0x8423e4 → RX-таблица VGA).
 * Возврат: 1 — успех, 2 — не сошлось. */
u32 Calib_Measure_VGA_Gains(void)
{
    const calib_vga_cfg_t *cfg = &calib_vga_cfg;
    calib_vga_pt_t res;
    u32 st = 2;
    u8 n = 0;

    while (st == 2 && n < 3) {
        n++;
        st = hwf_calib_bb_gain_rows(cfg->lim, cfg->row[0], cfg->row[1], cfg->row[2], cfg->row[3],
                                    &res, calib_bb_gain_delta);
        if (st == 2)
            fw_log_emit1(0x16, 0x101cb68, n);
    }
    if (st == 2) {
        /* vendor 0x8d4a5e: после исчерпания попыток лог выдаётся ещё раз */
        fw_log_emit1(0x16, 0x101cb68, n);
        return st;
    }
    if (st == 1)
        hwf_calib_bb_gain_create_table(calib_bb_gain_delta, res, cfg->lim, cfg->row[0], cfg->row[1],
                                       cfg->row[2], cfg->row[3]);
    return st;
}

/* hwf_calib_bb_gain_create_table (0x8d4ac8): по таблице дельт мощности tbl[4][8]
 * (u32, столбец × индекс) и опорной точке best перебрать все сочетания индексов,
 * для каждого уровня 0..62 запомнить ближайшую комбинацию кодов (calib__keep_closest),
 * выставить базу calib_zero_db (0x800508: строка/уровень) и записать коды в RX-таблицу VGA для индексов
 * AGC 63..1. При режиме RF 3 и флаге [gp+0x99] — только лог. */
void hwf_calib_bb_gain_create_table(u32 *tbl, calib_vga_pt_t best, calib_u8x4_t lim, calib_row8_t r1,
                                    calib_row8_t r2, calib_row8_t r3, calib_row8_t r4)
{
    /* arr[0..63] — точки по уровням (sp+0..0x1ff у vendor), arr[64] — текущая комбинация
     * (sp+0x200). vendor читает arr[64 + base] (0x8d4d12): при base > 0 это за пределами кадра —
     * у vendor мусор стека; base здесь отрицателен/ноль по смыслу (уровень мощности). */
    calib_vga_pt_t arr[65];
    u32 off, v, e;
    s32 base;
    u8 i0, i1, i2, i3, i, last, c;

    if (rf_obj.sets_mode == 3 && calib_bb_gain_tbl_skip_mode3 != 0) {
        fw_log_emit0(0x26, 0x101caf4);
        return;
    }
    for (i = 0; i < 0x3f; i++)
        arr[i].val = 0x7fffffff;

    off = (u32)best.val - (tbl[best.b[0] - 1] + tbl[8 + best.b[1] - 1] + tbl[16 + best.b[2] - 1] +
                           tbl[24 + best.b[3] - 1]);
    v = tbl[0] + off + tbl[8] + tbl[16] + tbl[24];
    arr[63].b[0] = 0;
    arr[63].b[1] = 0;
    arr[63].val = (s32)v;
    arr[63].b[2] = 0;
    arr[63].b[3] = 0;
    if ((s32)v >= 0)
        base = (s32)(v + 0x8000) >> 16;
    else
        base = -((s32)(0x8000 - v) >> 16);
    base += 1;

    for (i3 = 1; i3 <= lim.v[3]; i3++) {
        for (i2 = 1; i2 <= lim.v[2]; i2++) {
            for (i1 = 1; i1 <= lim.v[1]; i1++) {
                for (i0 = 1; i0 <= lim.v[0]; i0++) {
                    s32 lo, hi;
                    u8 k, j, n;
                    e = tbl[i0 - 1] + off + tbl[8 + i1 - 1] + tbl[16 + i2 - 1] + tbl[24 + i3 - 1];
                    arr[64].b[0] = r1.v[i0 - 1];
                    arr[64].b[1] = r2.v[i1 - 1];
                    arr[64].b[2] = r3.v[i2 - 1];
                    arr[64].b[3] = r4.v[i3 - 1];
                    k = (u8)(((s32)(e + 0x8000) >> 16) - base);
                    if (k >= 0x40)
                        continue;
                    lo = 0x3e - (s32)k;
                    if (lo < 0)
                        lo = 0;
                    lo = (u8)lo;
                    hi = 0x42 - (s32)k;
                    if (hi > 0x3e)
                        hi = 0x3e;
                    hi = (u8)hi;
                    if (hi < lo)
                        continue;
                    n = (u8)(hi - lo) + 1;
                    j = (u8)lo;
                    do {
                        calib_u8x4_t g;
                        g.v[0] = arr[64].b[0];
                        g.v[1] = arr[64].b[1];
                        g.v[2] = arr[64].b[2];
                        g.v[3] = arr[64].b[3];
                        calib_keep_closest(&arr[j], (s32)e, g, (s32)((u32)((0x40 - (s32)j) + base) << 16));
                        n--;
                        j++;
                    } while (n != 0);
                }
            }
        }
    }

    calib_zero_db.row8 = (u8)(base + 0x40);
    calib_zero_db.level = (s32)arr[64 + base].val;

    last = 0x3f;
    for (i = 0x3f; i >= 1; i--) {
        s32 a = arr[i].val;
        if (a != 0x7fffffff)
            last = i;
        if (i < 0x3f && a < arr[i + 1].val)
            fw_log_emit1(0x16, 0x101cb20, i);
        for (c = 1; c <= 4; c++) {
            hwd_abif_rx_table_config_vga_gain(i, c, 0, arr[last].b[c - 1]);
            hwd_abif_rx_table_config_vga_gain(i, c, 1, arr[last].b[c - 1]);
        }
    }
}

/* calib_row_step (0x8d4e08): выбрать коды 4 столбцов по индексам idx, записать их в строку
 * RX-таблицы VGA row; mode 1 — calib_vga_gain_step(row,row), иначе калибровка VGA DC
 * (столбцов до col+1, ≤ 4) и измерение LO-мощности в *meas. Затем снять 4 поля VGA DC
 * строки 1 в dc[0..3]. */
void calib_row_step(u32 row, const calib_u8x4_t *idx, calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2,
                    calib_row8_t r3, calib_row8_t r4, u32 mode, u32 col, calib_vga_pt_t *meas, u8 *dc)
{
    calib_u8x4_t g;
    u32 n;

    bytes_pick4_by_index(idx, lim, r1, r2, r3, r4, &g);
    hwd_abif_config_vga_rows(row, g.v);
    if ((u8)mode == 1) {
        calib_vga_gain_step(row, row);
    } else {
        n = (u32)(u8)col + 1;
        if (n > 4)
            n = 4;
        hwf_vga_dc_calibrate(row, 0, 0xd, 0, n);
        calib_lo_power_measure(row, 0xd, meas);
    }
    /* vendor 0x8d4e78: индекс строки — константа 1 (не row) */
    dc[0] = (u8)hwd_abif_rx_table_read_vga_dc(1, 1, 0);
    dc[1] = (u8)hwd_abif_rx_table_read_vga_dc(1, 2, 0);
    dc[2] = (u8)hwd_abif_rx_table_read_vga_dc(1, 3, 0);
    dc[3] = (u8)hwd_abif_rx_table_read_vga_dc(1, 4, 0);
}

/* 0x803814: следующий столбец VGA-поиска по столбцу c (индекс c − 2: 2→4, 3→2, 4→3; [3] — выравнивание). */
FWDATA(803814) const u8 calib_vga_next_col[4] = { 0x04, 0x02, 0x03, 0x00 };
/* 0x803818: стартовые индексы строк по столбцам 1..4 для VGA-поиска. */
FWDATA(803818) const calib_u8x4_t calib_vga_start_idx = { { 0x04, 0x03, 0x03, 0x03 } };

/* hwf_calib_bb_gain_rows (0x8d4eb4): подбор индексов кодов усиления по столбцам.
 * Столбец 1 — грубый поиск (calib_vga_coarse, ≤ 0x14 шагов) до попадания мощности в окно;
 * результат (мощность + индексы) → *out. Затем для каждого столбца 1..4 и каждого индекса
 * 1..lim измерить LO-мощность и записать дельту относительно опорной в tbl[(col-1)*8 + i-1].
 * Возврат: 1 — успех, 2 — ошибка (флаги насыщения/не сошлось). */
u32 hwf_calib_bb_gain_rows(calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4,
                           calib_vga_pt_t *out, u32 *tbl)
{
    calib_u8x4_t start, cur, keep, prev, dc80, dc84, dc88, dc8c;
    calib_vga_pt_t meas, best;
    u32 status, retry, res;
    s32 ref;
    u8 col, it, col_out, next_col;

    col = 1;
    start = calib_vga_start_idx;               /* стартовые индексы {4,3,3,3} (fw_data) */
    status = 1;
    col_out = 0;
    calib_row_step(1, &start, lim, r1, r2, r3, r4, 1, 0, &meas, dc80.v);

    for (; col <= 4 && status == 1; col++) {
        ref = 1;
        best.b[0] = 1;
        best.b[1] = 1;
        best.val = 0;
        keep = start;
        prev = start;
        hwd_abif_set_agc_column(1, 0, dc80.v);
        col_out = col;
        retry = 0;
        next_col = (col == 4) ? 3 : 4;

        if (col == 1) {
            it = 0;
            res = 0;
            while (res == 0 && status == 1) {
                it++;
                cur = keep;
                calib_row_step(1, &cur, lim, r1, r2, r3, r4, 0, col_out, &meas, dc84.v);
                hwf_calib_bb_gain_args(meas, &cur, lim, r1, r2, r3, r4);
                res = calib_vga_coarse(lim, r1, r2, r3, r4, meas, best, &prev, &cur, &keep, &dc88, &retry,
                                       &next_col, col, &col_out, (u32)ref, &status);
                prev = cur;
                best = meas;
                dc88 = dc84;
                ref = 0;
                if (it == 0x14) {
                    fw_log_emit3(6, 0x101ca5c, it, calib_bb_gain_pack_row(cur.v, 1),
                                 calib_bb_gain_pack_row(dc84.v, 0));
                    status = 2;
                }
            }
            ref = meas.val;
            out->val = meas.val;
            out->b[0] = cur.v[0];
            out->b[1] = cur.v[1];
            out->b[2] = cur.v[2];
            out->b[3] = cur.v[3];
            dc8c = dc84;
        } else {
            cur.v[0] = out->b[0];
            cur.v[1] = out->b[1];
            cur.v[2] = out->b[2];
            cur.v[3] = out->b[3];
            ref = out->val;
            dc84 = dc8c;
        }

        for (it = 1; it <= lim.v[col - 1] && status == 1; it++) {
            u8 refidx = out->b[col - 1];
            if (it == refidx) {
                tbl[(col - 1) * 8 + it - 1] = 0;
                continue;
            }
            /* vendor 0x8d5140: на 4-м индексе столбцов 2..4 при опорном 1/2 — уменьшить
             * индекс соседнего столбца с бо́льшим кодом и переснять опорную мощность */
            if (col >= 2 && it == 4 && (refidx == 2 || refidx == 1)) {
                u8 a, b;
                cur.v[0] = out->b[0];
                cur.v[1] = out->b[1];
                cur.v[2] = out->b[2];
                cur.v[3] = out->b[3];
                dc84 = dc8c;
                if (col == 4) {
                    a = 3;
                    b = 2;
                } else {
                    a = 4;
                    b = (col == 3) ? 2 : 3;
                }
                if (cur.v[a - 1] >= cur.v[b - 1]) {
                    next_col = a;
                    b = a;
                } else {
                    next_col = b;
                }
                if (cur.v[b - 1] >= 1) {
                    cur.v[b - 1]--;
                    col_out = b;
                    calib_row_step(1, &cur, lim, r1, r2, r3, r4, 0, b, &meas, dc84.v);
                    hwf_calib_bb_gain_args(meas, &cur, lim, r1, r2, r3, r4);
                    ref = meas.val;
                }
            }
            col_out = col;
            cur.v[col - 1] = it;
            calib_row_step(1, &cur, lim, r1, r2, r3, r4, 0, col, &meas, dc84.v);
            hwf_calib_bb_gain_args(meas, &cur, lim, r1, r2, r3, r4);
            if (meas.b[0] != 0 || meas.b[1] != 0) {
                fw_log_emit3(0x16, 0x101caa0, col, calib_bb_gain_pack_row(cur.v, 1),
                             ((u32)meas.b[0] << 4) + meas.b[1]);
                status = 2;
            }
            tbl[(col - 1) * 8 + it - 1] = (u32)meas.val - (u32)ref;
        }
    }
    return status;
}

/* calib__keep_closest (0x8d52d0): если |val - target| < |best->val - target| (беззнаково,
 * как abs+rlc у vendor) — запомнить val и 4 байта g. */
void calib_keep_closest(calib_vga_pt_t *best, s32 val, calib_u8x4_t g, s32 target)
{
    u32 d1 = (u32)val - (u32)target;
    u32 d2 = (u32)best->val - (u32)target;
    if ((s32)d1 < 0)
        d1 = 0u - d1;
    if ((s32)d2 < 0)
        d2 = 0u - d2;
    if (d1 < d2) {
        best->val = val;
        best->b[0] = g.v[0];
        best->b[1] = g.v[1];
        best->b[2] = g.v[2];
        best->b[3] = g.v[3];
    }
}

/* calib_vga_coarse (0x8d53b8): шаг грубого поиска. Окно мощности [lo, hi] — по текущему
 * индексу столбца (col 1 или индекс 2/3: [-0x20000, 0x50000]; индекс 1: [-0x80000, -0x10000];
 * иначе статус 2). Внутри окна — готово (*col_out = 0, возврат 1); вне — сдвиг индекса через
 * calib_vga_coarse_limit (возврат 0) либо откат к предыдущим индексам. first — первый шаг. */
u32 calib_vga_coarse(calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4,
                     calib_vga_pt_t meas, calib_vga_pt_t best, calib_u8x4_t *prev, calib_u8x4_t *cur,
                     calib_u8x4_t *keep, calib_u8x4_t *dc, u32 *retry, u8 *next_col, u32 col, u8 *col_out,
                     u32 first, u32 *status)
{
    s32 hi = 0, lo;
    u8 c = (u8)col;
    u8 fl = (u8)first;

    if (c == 1) {
        hi = 0x50000;
        lo = -0x20000;
    } else {
        u8 x = cur->v[c - 1];
        if (x == 1) {
            hi = (s32)0xffff0000u;
            lo = (s32)0xfff80000u;
        } else if (x == 2 || x == 3) {
            hi = 0x50000;
            lo = -0x20000;
        } else {
            *status = 2;
            lo = hi;
        }
    }

    if (meas.b[0] == 1) {
        if (fl != 0)
            goto step_fwd;
        goto rollback;
    }
    if (meas.b[1] == 1) {
        calib_vga_coarse_limit(lim, r1, r2, r3, r4, keep, *retry, next_col, c, 0, col_out, status);
        return 0;
    }
    if (meas.val > hi) {
        if (fl != 0 || best.val >= hi)
            goto step_fwd;
        goto rollback;
    }
    /* meas.val <= hi */
    if (meas.val >= lo) {
        *col_out = 0;
        return 1;
    }
    if (fl == 0 && c >= 2 && (best.b[0] == 1 || best.val > hi)) {
        *retry = 1;
        calib_vga_coarse_limit(lim, r1, r2, r3, r4, keep, 1, next_col, c, 0, col_out, status);
        return 0;
    }
    if (fl == 1 || (best.b[0] == 0 && best.val < hi)) {
        calib_vga_coarse_limit(lim, r1, r2, r3, r4, keep, *retry, next_col, c, 0, col_out, status);
        return 0;
    }
    *col_out = 0;
    return 1;

rollback:
    if (best.b[0] != 0)
        goto step_fwd;
    memcpy_fw(keep, prev, 4);
    hwd_abif_set_agc_column(1, 0, dc->v);
    if (c >= 2 || *retry == 1) {
        *retry = 1;
        calib_vga_coarse_limit(lim, r1, r2, r3, r4, keep, 1, next_col, c, 0, col_out, status);
        return 0;
    }
    *col_out = 0;
    return 1;

step_fwd:
    calib_vga_coarse_limit(lim, r1, r2, r3, r4, keep, *retry, next_col, c, 1, col_out, status);
    return 0;
}

/* bytes__pick4_by_index (0x8d5578): out[k] = код столбца k+1 с 1-базным индексом idx[k].
 * У vendor строки лежат подряд в кадре (sp+4..0x23), поэтому индекс 0 даёт последний байт
 * предыдущей строки (индекс столбца уходит в 0 при шаге вниз в calib_vga_coarse_limit);
 * буфер повторяет эту раскладку. Индексы > 8 у vendor выходят за кадр — по построению
 * (лимиты 0x801930 ≤ 8) не встречаются. */
void bytes_pick4_by_index(const calib_u8x4_t *idx, calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2,
                          calib_row8_t r3, calib_row8_t r4, calib_u8x4_t *out)
{
    u8 buf[0x24];
    u32 i;

    (void)lim;
    buf[0] = 0;   /* у vendor sp+0..3 не инициализированы (достижимо только индексом 0 столбца 1) */
    buf[1] = 0;
    buf[2] = 0;
    buf[3] = 0;
    for (i = 0; i < 8; i++) {
        buf[4 + i] = r1.v[i];
        buf[0xc + i] = r2.v[i];
        buf[0x14 + i] = r3.v[i];
        buf[0x1c + i] = r4.v[i];
    }
    out->v[0] = buf[idx->v[0] + 3];
    out->v[1] = buf[idx->v[1] + 0xb];
    out->v[2] = buf[idx->v[2] + 0x13];
    out->v[3] = buf[idx->v[3] + 0x1b];
}

/* calib_vga_coarse_limit (0x8d8604): сдвинуть индекс столбца.
 * flag 0 — вверх (+1, предел lim), flag != 0 — вниз (−1, предел 0).
 * val == 1: сначала столбец 1 (на пределе — сброс в 2/6 и переход к столбцу *next_col,
 * иначе шаг и *col_out = 1). Затем шаг столбца *next_col; на пределе — лог и *status = 2;
 * следующий столбец — по таблице 0x803814 {4,2,3} (2→4→3→2, минуя col). */
void calib_vga_coarse_limit(calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4,
                            calib_u8x4_t *idx, u32 val, u8 *next_col, u32 col, u32 flag, u8 *col_out, u32 *status)
{
    u8 tmp[3];
    u8 cmpv, resetv, c, g, n;
    s32 step;

    (void)r1;
    (void)r2;
    (void)r3;
    (void)r4;
    if (flag != 0) {
        step = -1;
        resetv = 6;
        cmpv = 0;
    } else {
        cmpv = lim.v[0];
        resetv = 2;
        step = 1;
    }
    c = *next_col;
    if (val == 1) {
        if (cmpv == idx->v[0]) {
            idx->v[0] = resetv;
            val = 0;
        } else {
            idx->v[0] = (u8)(idx->v[0] + step);
            *col_out = 1;
        }
    }
    if (val != 0)
        return;

    g = idx->v[c - 1];
    if ((g == 0 && flag == 1) || (g == lim.v[c - 1] && flag == 0)) {
        fw_log_emit2(6, 0x101ca2c, c, g);
        *status = 2;
        return;
    }
    memcpy_fw(tmp, calib_vga_next_col, 3);
    g = (u8)(g + step);
    /* c ∈ {2,3,4} по построению (bb_gain_rows/таблица 0x803814): tmp[c - 2] в пределах */
    n = tmp[c - 2];
    idx->v[c - 1] = g;
    *col_out = n;
    if (n == (u8)col)
        n = tmp[n - 2];
    *next_col = n;
}

/* hwf_calib_bb_gain__args (0x8dcb6c): bytes__pick4_by_index в локальный буфер, результат
 * у vendor отбрасывается (возврата нет, r0 не загружается) — наблюдаемого эффекта нет. */
void hwf_calib_bb_gain_args(calib_vga_pt_t meas, const calib_u8x4_t *idx, calib_u8x4_t lim, calib_row8_t r1,
                            calib_row8_t r2, calib_row8_t r3, calib_row8_t r4)
{
    calib_u8x4_t out;

    (void)meas;
    bytes_pick4_by_index(idx, lim, r1, r2, r3, r4, &out);
}

/* calib_bb_gain__pack_row (0x8e97bc): упаковать 4 байта (flag: по 4 бита, иначе по 8). */
u32 calib_bb_gain_pack_row(const u8 *src, u32 flag)
{
    if (flag != 0)
        return ((u32)src[0] << 12) + ((u32)src[1] << 8) + ((u32)src[2] << 4) + src[3];
    return ((u32)src[0] << 24) + ((u32)src[1] << 16) + ((u32)src[2] << 8) + src[3];
}

/* Округление со сдвигом, как в vendor: x >= 0 → (x + half) asr sh, иначе −((half − x) asr sh);
 * арифметика 32-битная с переносом (u32), сдвиг арифметический. */
static s32 ifg_round_asr(s32 x, u32 sh)
{
    u32 half = 1u << (sh - 1);
    if (x >= 0)
        return (s32)((u32)x + half) >> sh;
    return -((s32)(half - (u32)x) >> sh);
}

/* if_gain__compute_correction (0x8d55b4): по результату IF_GAIN::GAIN (a1 = 0x8067c0) и
 * уровню a0 считает итоговое RX-усиление в 0x842464 и классифицирует его против порога
 * [gp+0xa3]: 1 — в окне [g-1, g+1], 2 — вне. */
u32 if_gain_compute_correction(u32 a0, const struct if_gain_meas *a1)
{
    struct if_gain_res *s = &if_gain_res;
    s32 r15 = (s8)((s8)s->lo_level - 0x1d);
    s32 r14 = (s32)(0xffffffe6u - a1->predist_idx);              /* rsub r14,r3,-26 */
    s32 r3 = (s8)(a0 - 0x26);
    s32 r2 = (s8)(a1->fssel_idx + r14);
    u32 g, v;
    r3 = (s8)(r3 - r2);
    r14 = r3 - r15;                                     /* без sexb: в s->gain уходит байт */
    r15 = (s8)r14;
    r15 -= 0xa;
    if (r15 < 0)
        r15 += 1;                                       /* add.n: деление на 2 к нулю */
    r15 = (r15 >> 1) + 0xa;
    s->atten_sum = (u8)r2;
    s->level = (u8)a0;
    s->err = (u8)r3;
    s->gain = (u8)r14;
    s->gain_half = (u8)r15;
    s->cnt = a1->cnt;
    v = (u8)r14;                                        /* extb: сравнение беззнакового байта */
    g = rf_if_gain_rssi_ofs;
    if ((s32)v < (s32)(g - 1))
        return 2;
    if ((s32)v <= (s32)(g + 1))
        return 1;
    return 2;
}

/* if_gain__apply_delta (0x8d561c): перенести |delta| между полями out[2] и out[4]
 * (delta >= 0 — уменьшить out[2], излишек добавить к out[4]; delta < 0 — наоборот). */
void if_gain_apply_delta(s32 delta, struct if_gain_meas *out)
{
    u32 lo = out->predist_idx, hi = out->fssel_idx;
    u32 ad = (u8)(delta < 0 ? -(u32)delta : (u32)delta);
    if (delta >= 0) {
        if ((s32)ad < (s32)lo) {
            lo = (u8)(lo - ad);
        } else {
            hi = (u8)(hi + (ad - lo));
            lo = 0;
        }
    } else {
        if ((s32)ad < (s32)hi) {
            hi = (u8)(hi - ad);
        } else {
            lo = (u8)(lo + (ad - hi));
            hi = 0;
        }
    }
    out->predist_idx = (u8)lo;
    out->fssel_idx = (u8)hi;
}

/* IF_GAIN::GAIN (0x8d565c): итеративный подбор IF-усиления (индекс g = out[6] в таблице
 * 0x80197c по 3 байта) по измерению:
 *   mode 0 — синусоидальный генератор, 1 — self-transmit (sub==1);
 *   sub  0 — rx_cal_corr → амплитуда → if_gain__scale_value, 1 — RSSI ADC (if_gain__get_scaled),
 *        2 — self-transmit + счётчики RX + RSSI;
 *   act  0/255 — один проход, 3 — коррекция out[2]/out[4] (if_gain__apply_delta),
 *        6 — двоичный поиск g с шагом out[7] (с откатом на предыдущий g при ухудшении
 *        или осцилляции).
 * До 7 итераций. out: [0] TX-индекс, [1] RX-индекс, [2]/[4] индексы аттенюаторов, [6] g,
 * [7] шаг, [0xe] цель, [0xf] допуск; результат — [3],[5],[8],[9],[0xa],[0xc..0xd],[0x10]. */
void IF_GAIN_GAIN(u32 mode, u32 sub, u32 act, struct if_gain_meas *out)
{
    u32 buf[14];                     /* sp+0x34: rx_cal_corr (2 слова) / счётчики RX (14 слов) */
    u32 tx_idx = out->tx_idx;             /* r16 */
    u32 rx_idx = out->rx_idx;             /* r22 */
    u32 v2 = out->predist_idx;                 /* r24 */
    u32 v4 = out->fssel_idx;                 /* sp+0xc */
    u32 g = out->g;                  /* r20 */
    u32 step = out->step;               /* r23 */
    u32 target = out->target;           /* sp+0x10 */
    u32 tol = out->tol;              /* sp+0x14 */
    u32 att1, att2;                  /* sp+0x18, sp+0x1c */
    s32 prev_d = 0x7f;               /* sp+0x20 */
    u32 prev_ad = 0xff;              /* sp+0x24 */
    u32 meas = 0;                    /* r13 */
    u32 prev_g = 0;                  /* r19 */
    u32 prev_scaled = 0;             /* r25 */
    u32 iter = 0;                    /* sp+0x28 */
    u32 conv = 0;                    /* r21 */
    u32 cnt16 = 0;                   /* sp+0x2c */
    u32 ina = 0;                     /* sp+0x30 */
    u32 scaled = 0;                  /* r17 */
    s32 d = 0;                       /* r15 */
    u32 ad = 0;                      /* r18 */
    u32 neg = 0;                     /* r1 */
    u8 *t;

    if (v2 >= 0x13)
        fw_sysassert_fatal((void *)0, 0x147e);
    if (v4 >= 0x12)
        fw_sysassert_fatal((void *)0, 0x147f);
    att1 = calib_if_predist_atten_tbl[v2];
    att2 = calib_if_dac_fssel_tbl[v4];

    if (mode == 0) {
        hwd_phy_tx_singen_transmit(1);
    } else if (mode == 1) {
        hwd_phy_tx_enable(1);
        if (sub == 1)
            hwd_phy_tx_self_transmit(0xffff, 7, 0xa, 0x4d2);
    } else {
        fw_sysassert_fatal((void *)0, 0x1309);
    }

    for (;;) {
        /* L_8d597c: голова цикла */
        if (conv != 0 || (s32)iter >= 7)
            break;

        iter = (u8)(iter + 1);
        hwd_phy_tx_predist_atten_man_config(1, att1, att1);
        hwd_abif_tx_table_config_dac_fssel(tx_idx, att2);
        t = calib_if_ctrl_tbl[g];
        hwd_abif_tx_table_config_iftx_ctrl(tx_idx, 1, t[0]);
        hwd_abif_tx_table_config_iftx_ctrl(tx_idx, 2, t[1]);
        hwd_abif_tx_table_config_iftx_ctrl(tx_idx, 3, t[2]);
        hwd_abif_rx_table_config_ifrx_ctrl(rx_idx, 1, t[0]);
        hwd_abif_rx_table_config_ifrx_ctrl(rx_idx, 2, t[1]);
        hwd_abif_rx_table_config_ifrx_ctrl(rx_idx, 3, t[2]);
        hwd_abif_caf_lpbk_mode(0);
        hwd_abif_caf_lpbk_mode(1);
        {
            u32 n = calib_if_gain_settle_delay;
            if (n != 0)
                calib_nop_delay(n * 80);
        }

        if (sub == 0) {
            s32 i, q, sv;
            hwd_phy_rx_enable(0);
            hwd_phy_rx_cal_corr((s32 *)buf);
            i = ifg_round_asr((s16)buf[0], 2);
            q = ifg_round_asr((s16)buf[1], 2);
            sv = if_gain_scale_value(approx_magnitude((u32)i, (u32)q), 0x10);
            meas = (u32)(s8)ifg_round_asr(sv, 16);
            d = (s8)(target - meas);
            ad = (u8)(d < 0 ? -d : d);
            neg = (u32)d >> 31;
            conv = ((s32)tol >= (s32)ad) ? 1u : 0u;
        } else if (sub == 1) {
            hwd_phy_rx_ina_det_mode(0);
            hwd_phy_rx_enable(1);
            calib_nop_delay(0xf0);
            scaled = if_gain_get_scaled(4);
            d = (s8)(target - scaled);
            ad = (u8)(d < 0 ? -d : d);
            neg = (u32)d >> 31;
            conv = ((s32)tol < (s32)ad) ? 0u : 1u;
        } else if (sub == 2) {
            hwd_phy_rx_ina_det_mode(2);
            hwd_phy_rx_enable(1);
            hwd_phy_rx_statistics_clear();
            hwd_phy_tx_self_transmit(3, 495, 0xa, 1234);
            calib_nop_delay(320);
            hwd_phy_tx_self_transmit_wait_completion();
            calib_nop_delay(320);
            hwd_phy_rx_enable(0);
            hwd_phy_rx_statistics_lock();
            phy_read_rx_counters(buf);
            hwd_phy_rx_statistics_clear();
            ina = MMIO32(HW_PHY_RX_INA_RSSI_ADC_DB_SFD_LOCKED) & 0x3fu;
            cnt16 = (u16)buf[5];                         /* ldh [sp,0x48] беззнаково */
            hwd_phy_tx_self_transmit(0xffff, 7, 0xa, 1234);
            hwd_phy_rx_ina_det_mode(0);
            hwd_phy_rx_enable(1);
            calib_nop_delay(0xa0);
            scaled = if_gain_get_scaled(4);
            hwd_phy_tx_self_transmit(1, 0xa, 1, 0x64);
            hwd_phy_tx_self_transmit_wait_completion();
            d = (s8)(target - scaled);
            ad = (u8)(d < 0 ? -d : d);
            neg = (u32)d >> 31;
            if (buf[5] == 3)                             /* ld [sp,0x48] — всё слово */
                conv = ((s32)tol < (s32)ad) ? 0u : 1u;
            else
                conv = 0;
        } else {
            fw_sysassert_fatal((void *)0, 0x130a);
            ad = 0;
            neg = 0;
            d = 0;
        }

        /* L_8d5978 */
        if (conv == 1)
            continue;                                    /* голова цикла → выход */
        if (iter == 7) {
            fw_log_emit3(0x16, 0x101cc2c, scaled, ina, iter);
            continue;
        }
        if (act == 3) {
            if_gain_apply_delta(d, out);
            v2 = out->predist_idx;
            v4 = out->fssel_idx;
            if (v2 >= 0x13)
                fw_sysassert_fatal((void *)0, 0x1529);
            if (v4 >= 0x12)
                fw_sysassert_fatal((void *)0, 0x1553);
            att1 = calib_if_predist_atten_tbl[v2];
            att2 = calib_if_dac_fssel_tbl[v4];
        } else if (act == 6) {
            if (step == 1 && ((s32)prev_ad < (s32)ad || d == -prev_d)) {
                /* ухудшение или осцилляция при шаге 1: вернуть предыдущий g и закончить */
                t = calib_if_ctrl_tbl[prev_g];
                conv = 1;
                hwd_abif_tx_table_config_iftx_ctrl(tx_idx, 1, t[0]);
                hwd_abif_tx_table_config_iftx_ctrl(tx_idx, 2, t[1]);
                hwd_abif_tx_table_config_iftx_ctrl(tx_idx, 3, t[2]);
                hwd_abif_rx_table_config_ifrx_ctrl(rx_idx, 1, t[0]);
                hwd_abif_rx_table_config_ifrx_ctrl(rx_idx, 2, t[1]);
                hwd_abif_rx_table_config_ifrx_ctrl(rx_idx, 3, t[2]);
                hwd_abif_caf_lpbk_mode(0);
                hwd_abif_caf_lpbk_mode(conv);
                g = prev_g;
                scaled = prev_scaled;
            } else {
                s32 ng;
                s32 h = (s32)(step >> 1);
                step = (u8)(h > 1 ? h : 1);
                if (neg == 0) {
                    ng = (s32)(step + g);
                    if (ng > 0xf)
                        ng = 0xf;
                } else {
                    ng = (s8)(g - step);
                    if (ng < 1)
                        ng = 1;
                }
                prev_g = g;
                prev_scaled = scaled;
                g = (u8)ng;
            }
            prev_d = d;
            prev_ad = ad;
        } else if (act == 0 || act == 255) {
            conv = 1;
        } else {
            fw_sysassert_fatal((void *)0, 0x130b);
        }
    }

    /* L_8d5988: выход */
    if (act != 255) {
        hwd_phy_rx_enable(0);
        hwd_phy_tx_singen_transmit(0);
        if (mode == 1 && sub == 1) {
            hwd_phy_tx_self_transmit(2, 0xa, 0xa, 1234);
            hwd_phy_tx_self_transmit_wait_completion();
        }
        hwd_phy_tx_enable(0);
    } else if (mode == 1) {
        hwd_phy_tx_self_transmit(0xffff, 0xa, 0xa, 0x4d2);
    }
    out->scaled = (u8)scaled;
    out->ina = (u8)ina;
    out->meas = (u8)meas;
    out->cnt = (u16)cnt16;
    out->predist_idx = (u8)v2;
    out->predist_atten = (u8)att1;
    out->g = (u8)g;
    out->fssel_idx = (u8)v4;
    out->step = (u8)step;
    out->fssel = (u8)att2;
    out->iter = (u8)iter;
}

/* if_gain (0x8d5b64): калибровка IF-усиления (a0: 0 — полная с начальными параметрами,
 * 1 — повторная). Состояние в 0x8067bc, результат в 0x842464 (+0x10 — итог 0/1/2). */
u32 if_gain(u32 a0)
{
    struct if_gain_state *st = &if_gain_state;
    struct if_gain_res *res = &if_gain_res;
    u32 r13 = 0, ok = 0, v;

    st->m.tx_idx = 0x1d;
    st->m.rx_idx = res->agc_idx;
    st->m.target = calib_if_gain_ref;
    if (a0 == 0) {
        /* vendor 0x8d5b92..0x8d5ba4: шесть stb_s по порядку; через volatile — gcc иначе сливает
         * их в sth/st (store merging) */
        volatile struct if_gain_meas *vm = &st->m;
        vm->predist_idx = 5;
        vm->predist_atten = 0x48;
        vm->fssel_idx = 0;
        vm->fssel = 0;
        vm->g = 8;
        vm->step = 8;
        calib_if_gain_retry_count = 0;
    } else if (a0 == 1) {
        st->m.step = 1;
        calib_if_gain_retry_count += 1;
    }
    (void)u_schd_now();
    (void)u_schd_now();
    (void)u_schd_now();

    if (a0 == 1) {
        st->m.tol = 0;
        IF_GAIN_GAIN(1, 2, 6, &st->m);
        r13 = if_gain_compute_correction(st->m.scaled, &st->m);
        if (r13 == 2) {
            fw_log_emit1(0x16, 0x101cc88, st->m.iter);
            ok = 0;
        } else {
            ok = (r13 == 1 && st->m.iter == 1) ? 1u : 0u;
        }
    } else if (a0 == 0) {
        st->m.tol = 3;
        IF_GAIN_GAIN(1, 1, 6, &st->m);
        r13 = if_gain_compute_correction(st->m.scaled, &st->m);
        ok = 0;
    } else {
        r13 = 0;
        ok = 0;
    }

    if (a0 == 0 || (a0 == 1 && r13 == 2)) {
        (void)u_schd_now();
        st->m.tol = 1;
        IF_GAIN_GAIN(1, 2, 3, &st->m);
        r13 = if_gain_compute_correction(st->m.scaled, &st->m);
    }

    {
        u32 x = (u32)rf_if_gain_rssi_ofs - res->gain;
        u32 y = (u32)st->m.target - (u32)(s32)(s8)st->m.scaled;
        s32 delta = (s8)-(s32)(s8)(x - y);
        if_gain_apply_delta(delta, &st->m);
    }

    if (r13 == 2) {
        (void)u_schd_now();
        st->m.tol = 0;
        IF_GAIN_GAIN(1, 2, 6, &st->m);
        r13 = if_gain_compute_correction(st->m.scaled, &st->m);
    }

    if (ok != 0)
        r13 = 0;
    else if (r13 == 2)
        fw_log_emit0(0x16, 0x101ccd0);

    v = st->m.g;
    res->g = (u8)v;
    res->dvs70[0] = (u8)((MMIO32(ABIF_DVS_STAT_70) >> 12) & 0xfu);
    res->dvs70[1] = (u8)((MMIO32(ABIF_DVS_STAT_70) >> 16) & 0xfu);
    res->dvs70[2] = (u8)((MMIO32(ABIF_DVS_STAT_70) >> 20) & 0xfu);
    res->tx_atten = (u8)MMIO32(PHY_TX_ATTEN_VAL);
    res->dvs64 = (u8)((MMIO32(ABIF_DVS_STAT_64) >> 16) & 0x3fu);
    res->result = r13;

    if (a0 == 0 || calib_if_gain_always_apply == 1) {
        hwf_if_gain_apply_agc_table(v);
    } else if (a0 == 1) {
        if ((s8)st->agc_delta != 0) {
            if (rf_obj.sets_mode != 0) {
                u32 pair[2];
                struct calib_silent_rssi *obj;
                u32 val, m, n = 0;
                pair[0] = 0;
                pair[1] = 0;
                obj = calib_obj4_reset_d4();
                agc_get_table_pair(obj, 1, &pair[0], &pair[1]);
                val = pair[0] + (u32)(s32)(s8)st->agc_delta;
                m = rf_cfg_get_rf_mask_45e(&rf_obj);
                while (m != 0) {
                    m &= m - 1;
                    n = (u16)(n + 1);
                }
                calib_silent_rssi_sparrow_set_agc_start_val(obj, val, (u8)n);
            }
            st->agc_delta = 0;
        }
        if (r13 == 1)
            hwf_if_gain_apply_agc_table(res->g);
    }

    if (rf_obj.sets_mode == 3) {
        u32 g = calib_if_gain_force_agc_idx;
        if ((s32)g >= 1) {
            fw_log_emit1(0x26, 0x101cd0c, g);
            hwf_if_gain_apply_agc_table(calib_if_gain_force_agc_idx);
        }
    }
    return r13;
}

/* calib_corr__estimate_and_apply_rx_gain (0x8d5d98): оценить RX-усиление по LO-мощности
 * (режим [gp+0x9e]: 1 — два поиска calib_lo_power_substep, 0 — из сохранённого calib_zero_db.level,
 * 2 — одно измерение calib_lo_power_measure), записать индекс/уровень в 0x842464[6]/[7]
 * и включить петлю PHY с синусоидальным генератором для IF-калибровки. */
void calib_corr_estimate_and_apply_rx_gain(void)
{
    u32 buf[2];
    struct if_gain_res *res = &if_gain_res;
    u32 mode, base;

    hwf_calib_acquire_hw();
    hwd_phy_rx_enable(0);
    hwd_phy_tx_enable(0);
    hwd_abif_caf_lpbk_mode(0);
    hwm_calib_set_loopback_mode(0);
    hwd_phy_self_mode_exit();
    hwd_args_to_regs_default(rf_cfg_get_rf_mask_45e(&rf_obj));
    hwm_calib_set_loopback_mode(1);
    hwd_phy_self_rx_mode_entry();

    mode = calib_rx_gain_est_mode;
    base = calib_zero_db.row8;
    if (mode == 1) {
        u32 nb, off;
        calib_lo_power_substep((u32 *)&calib_zero_db.row, base, 0);
        nb = calib_zero_db.row8;
        if_gain_state.agc_delta = (s8)(u8)(nb - base);
        off = calib_rx_gain_est_offset;
        calib_lo_power_substep(buf, (u8)(nb - off), (s8)off);
        res->agc_idx = (u8)buf[0];
        res->lo_level = (u8)ifg_round_asr((s32)buf[1], 16);
    } else if (mode == 0) {
        u32 off = calib_rx_gain_est_offset;
        s32 lvl = calib_zero_db.level;
        res->agc_idx = (u8)(base - off);
        res->lo_level = (u8)(off + (u32)ifg_round_asr(lvl, 16));
    } else if (mode == 2) {
        u32 idx = (u8)(base - calib_rx_gain_est_offset);
        res->agc_idx = (u8)idx;
        calib_lo_power_measure(idx, calib_lo_power_meas_shift, (calib_vga_pt_t *)buf);   /* buf — общий с substep */
        res->lo_level = (u8)ifg_round_asr((s32)buf[0], 16);
    }

    hwd_phy_self_mode_exit();
    hwd_abif_rx_table_index_force_mode(0, 0);
    hwm_calib_set_loopback_mode(0);
    hwd_phy_tx_singen_config(0xb, 0xb, 6);
    hwd_phy_tx_ctrl_884070(1);
    hwd_phy_rx_cal_corr_config(0x10000, 1, 0xb);
    hwd_phy_self_tx_mode_entry();
    hwd_phy_self_rx_mode_entry();
    hwd_phy_dbg_clk_enable(1);
    hwd_phy_rx_agc_index_force_mode(1, res->agc_idx);
    hwd_phy_rx_agc_steps_disable(1);
    hwd_mac_uses_rgf_886200(1);
    hwm_set_analog_path(1, 0x1d, res->agc_idx);
}

/* hwf_if_gain__apply_agc_table (0x8d5f08): записать тройку IF-управления из таблицы
 * 0x80197c (по 3 байта на индекс) в TX-строку 0 и RX-строки 1..0x3f. */
void hwf_if_gain_apply_agc_table(u32 a0)
{
    const u8 *t = calib_if_ctrl_tbl[a0];
    u32 i, row;
    hwd_abif_tx_table_config_iftx_ctrl(0, 1, t[0]);
    hwd_abif_tx_table_config_iftx_ctrl(0, 2, t[1]);
    hwd_abif_tx_table_config_iftx_ctrl(0, 3, t[2]);
    for (i = 0x3f, row = 1; i >= 1; i--, row = (u8)(row + 1)) {
        hwd_abif_rx_table_config_ifrx_ctrl(row, 1, t[0]);
        hwd_abif_rx_table_config_ifrx_ctrl(row, 2, t[1]);
        hwd_abif_rx_table_config_ifrx_ctrl(row, 3, t[2]);
    }
}

/* 0x8036ec: дБ → линейная величина, round(10^(i/10)), i = 0..63 (if_gain__get_scaled читает
 * младшие 16 бит записи; vendor адресует от 0x8036cc + 0x20). */
FWDATA(8036ec) const u32 if_gain_db_to_lin[64] = {
    1, 1, 2, 2, 3, 3, 4, 5,
    6, 8, 10, 13, 16, 20, 25, 32,
    40, 50, 63, 79, 100, 126, 158, 200,
    251, 316, 398, 501, 631, 794, 1000, 1259,
    1585, 1995, 2512, 3162, 3981, 5012, 6310, 7943,
    10000, 12589, 15849, 19953, 25119, 31623, 39811, 50119,
    63096, 79433, 100000, 125893, 158489, 199526, 251189, 316228,
    398107, 501187, 630957, 794328, 1000000, 1258925, 1584893, 1995262,
};

/* if_gain__get_scaled (0x8d6064): сумма (1<<n) отсчётов RSSI ADC через таблицу 0x8036ec
 * (u16 по индексу*4) → if_gain__scale_value → округление >>17 → байт.
 * ХРУПКО: число итераций vendor берёт как extb(extw(1<<n)); при 8 <= n <= 15 это 0, а цикл
 * do-while с декрементом u32 тогда крутится ~2^32 раз. Все вызовы vendor — с n = 4. */
u32 if_gain_get_scaled(u32 n)
{
    u32 cnt = (u16)(1u << (n & 31));
    u32 acc = 0;
    if ((s32)cnt >= 1) {
        cnt = (u8)cnt;
        do {
            u32 idx;
            cnt--;
            idx = (u8)phy_get_ina_rssi_adc_db();
            acc += *(const u16 *)&if_gain_db_to_lin[idx];
        } while (cnt >= 1);
    }
    return (u8)ifg_round_asr(if_gain_scale_value(acc, n), 17);
}

/* approx_magnitude (0x8d6490): |I|,|Q| → max(63*max+13*min, 54*max+36*min) >> 6. */
u32 approx_magnitude(u32 a0, u32 a1)
{
    u32 x = (s32)a0 < 0 ? -a0 : a0;
    u32 y = (s32)a1 < 0 ? -a1 : a1;
    u32 ma = ((s32)y > (s32)x) ? y : x;                /* max/min знаковые */
    u32 mi = ((s32)y < (s32)x) ? y : x;
    u32 r0 = (ma * 0x3fu + mi * 0xdu) >> 6;
    u32 r1 = (mi * 0x24u + ma * 0x36u) >> 6;
    return (r1 > r0) ? r1 : r0;
}

/* if_gain__scale_value (0x8d6dcc): масштабированный log2(a) с дробной частью по таблице
 * if_gain_log2_frac (0x801824, u16, 128 элементов): e*0x60546 + tbl[f]*8, e = 0x1f-c-нормировка. */
s32 if_gain_scale_value(u32 a, u32 c)
{
    u32 v = (a != 0) ? a : 1u;
    s32 e = (s8)(0x1f - c);
    u32 f;
    while (!(v >> 31)) {
        e = (s8)(e - 1);
        v <<= 1;
    }
    f = ((v + 0x800000u) >> 24) - 0x80u;
    f = (f < 0x7fu) ? f : 0x7fu;
    f = (u8)f;
    return (s32)((u32)e * 0x60546u + ((u32)if_gain_log2_frac[f] << 3));
}

/* approx_magnitude_b (0x8dc660): то же, что approx_magnitude, для (b, c); a не используется. */
u32 approx_magnitude_b(struct calib_obj *obj, u32 b, u32 c)
{
    (void)obj;
    return approx_magnitude(b, c);
}

/* Объект silent_rssi (0x804b5c, calib_silent_rssi_vtbl) — struct calib_silent_rssi
 * (include/calib_engine.h). */

/* calib_req__fill (0x8c182c): запрос коррекции {вердикт val, маска RF byte, фрагментов val2}. */
void calib_req_fill(struct calib_est *dst, u32 unused, u32 val, u32 byte, u32 val2)
{
    (void)unused;
    dst->verdict = val;
    dst->rf_mask = (u8)byte;
    dst->nfrag = val2;
}

/* calib_silent_rssi_sparrow::calibrate_baseband_gain (0x8c5708): загрузить набор
 * параметров (A/B по mask), для каждого RF-модуля маски 0x45e выставить усиление
 * (2/4), затем найти AGC-старт (если нужно по режиму калибровки) и применить его.
 * Возврат: результат find_agc_start (1/2) или 1, если поиск не нужен. */
u32 calibrate_baseband_gain(struct calib_silent_rssi *obj, u32 mask, const struct calib_est *rfm)
{
    u32 it;
    u32 start;
    u32 rfca, rf, m, n, r15;
    u8 cnt, ok;

    (void)rfm;
    if (mask & 0xfff00000u)
        silent_rssi_load_params_b(obj);
    else
        silent_rssi_load_params_a(obj);
    rfca = rfca_get_rf_mask();
    rf = rf_cfg_get_rf_mask_45e(&rf_obj);
    if (rf == 0) {
        fw_log_emit3(0, 0x10099f0, rf, 0, 0);
        fw_sysassert_fatal(__builtin_return_address(0), 0x1459);
    }
    field_set_0x00_8e5dfc(&it, rf);
    while (bit_iter_has_more(&it)) {
        u32 bit = bitmap_alloc_bit(&it);
        if (bit >= 8)
            fw_sysassert_fatal(__builtin_return_address(0), 0x1487);
        hwd_abif_dvs_rfca_cmd_enable((u8)(1u << bit), 0);
        silent_rssi_set_rf_gain_index(obj, 0, 2, 0, 4, 0);
    }
    hwd_abif_dvs_rfca_cmd_enable(rfca, 0);

    start = obj->start_idx;
    m = rf_cfg_get_rf_mask_45e(&rf_obj);
    for (n = 0; m != 0; n = (u16)(n + 1))
        m &= m - 1;
    cnt = (u8)n;

    if (rf_obj.sets_mode == 3) {
        r15 = 1;
    } else if (rf_obj.sets_mode == 2 || rf_obj.sets_mode == 1) {
        ok = 0;
        field_set_0x00_8e5dfc(&it, rf_cfg_get_rf_mask_45e(&rf_obj));
        r15 = 0;
        while (bit_iter_has_more(&it)) {
            u32 bit = bitmap_alloc_bit(&it);
            u8 v = obj->rf_gain[bit];
            if (v == 0xf) {
                r15 = 1;
                fw_log_emit2(0x26, 0x1009a78, bit, 0xf);
                break;
            }
            if (v == 1)
                ok = (u8)(ok + 1);
        }
        /* vendor 0x8c5838: все модули с усилением 1 → поиск нужен */
        if (cnt == ok) {
            r15 = 1;
            fw_log_emit2(0x26, 0x1009adc, rf_obj.omni_rf_mask, 1);
        }
    } else {
        u8 v = obj->rf_gain[0];
        r15 = 0;
        if (v == 1 || v == 0xf) {
            r15 = 1;
            fw_log_emit1(0x26, 0x1009b48, v);
        }
    }

    if (r15 == 0)
        r15 = 1;
    else
        r15 = calib_silent_rssi_sparrow_find_agc_start(obj, obj->target, obj->start_idx, 1, &start);

    for (n = 0; rf != 0; n = (u16)(n + 1))
        rf &= rf - 1;
    calib_silent_rssi_sparrow_set_agc_start_val(obj, start, (u8)n);
    obj->calib_count += 1;
    return r15;
}

/* silent_rssi__calibrate_single_rf_module (0x8c58c4): откалибровать один RF-модуль:
 * при >=2 модулях — выключить остальные и перевести RF в пару, классифицировать
 * по температуре, вычислить цель по режиму калибровки, find_rf_gain; затем вернуть
 * все модули (chain_3 + restore + поле 0x44c) и прежнюю маску rfca. */
u32 silent_rssi_calibrate_single_rf_module(struct calib_silent_rssi *obj, u32 mask, u32 module_idx, const struct calib_est *rfm)
{
    u8 prev = 0;                 /* sp[0]: прежняя маска rfca (заполняет cmd_enable) */
    u8 *pprev = &prev;
    u32 bitmask = 1u << module_idx;
    u32 rf, t, cnt, ret;
    s32 target;

    (void)rfm;
    rf = rf_cfg_get_rf_mask_45e(&rf_obj);
    for (cnt = 0, t = rf; t != 0; cnt = (u16)(cnt + 1))
        t &= t - 1;
    if ((s32)cnt >= 2) {
        hwd_abif_dvs_rfca_cmd_enable((u8)(rf & ~bitmask), pprev);
        hwd_setup_pair(0, 0);
        pprev = 0;               /* vendor 0x8c591a: второй cmd_enable уже без сохранения */
    }
    hwd_abif_dvs_rfca_cmd_enable((u8)bitmask, pprev);
    calib_classify_by_thresholds(obj, module_idx);

    if (rf_obj.sets_mode == 3) {
        target = (s32)obj->target + (s8)calib_silent_rssi_target_ofs_mode3;
    } else if (rf_obj.sets_mode == 2 || rf_obj.sets_mode == 1) {
        calib_row8_t tbl;   /* копия calib_srssi_target_ofs: два слова (выравнивание ARC600) */
        u32 n;
        s32 i;
        for (n = 0, t = rf; t != 0; n = (u16)(n + 1))
            t &= t - 1;
        i = (s8)(n - 1);
        if (i < 0)
            i = 0;
        else if (i > 7)
            i = 7;
        tbl = calib_srssi_target_ofs;
        target = (s32)obj->target - tbl.v[i];
    } else {
        target = obj->target;
    }

    ret = calib_silent_rssi_sparrow_find_rf_gain(obj, module_idx, mask >> 20, target);
    if ((s32)cnt >= 2) {
        ut_hw_modes_chain_3(rf);
        rfc_restore_txrx_sets_fw();
        rfc_field_write(0, 0x44c, 1, 0);
    }
    hwd_abif_dvs_rfca_cmd_enable(prev, 0);
    return ret;
}

/* silent_rssi__set_rf_gain_index (0x8c6c2c): RF-усиление 0x504 = (clamp(a2+a3,1..15), a4)
 * + выбор RX-сектора idx. При a5 — сперва запись строки таблицы усилений a2 из
 * rf_obj.gain_tbl (при сбое — подготовка аналога и повтор с fatal), усиление тогда 0xf.
 * Объект vendor не читает — всё через RF-объект rf_obj (0x8042c8). */
void silent_rssi_set_rf_gain_index(struct calib_silent_rssi *obj, u32 idx, u32 a2, u32 a3, u32 a4, u32 a5)
{
    s32 g = (s32)(a3 + a2);
    struct rf_reg_pair buf[1];

    (void)obj;
    if (g < 1)
        g = 1;
    if (g > 0xf)
        g = 0xf;
    if (a5 != 0) {
        buf[0].addr = rf_obj.gain_tbl[15].addr;
        buf[0].val = rf_obj.gain_tbl[a2].val;
        if (marlon_r_if_class_rf_write_with_block_retries(&rf_obj, 0, buf, 1, 1, 5,
                                                          chsw_single_attempt) == 0) {
            chsw_config_fail_count += 1;
            hwm_analog_prepare_buf(1);
            marlon_r_if_class_rf_write_with_block_retries(&rf_obj, 0, buf, 1, 1, 5, 1);
        }
        g = 0xf;
    }
    rfc_write_gain_idx_reg504(&rf_obj, (u32)g, a4);
    txrx_sel(&rf_obj, rf_obj.rf_idx, 1, idx);
}

/* calib_silent_rssi_sparrow::find_agc_start (0x8ca5e8): итерационный поиск
 * индекса RX-таблицы, при котором окно гистограммы RSSI = val (± thr).
 * Индекс ограничен снизу [obj+0xbd], сверху max AGC ([0x883138]&0x3f); итераций
 * не больше [obj+0xbf]. Возврат 1 — сошлось, 2 — нет (+ проверка RF). *out = индекс. */
u32 calib_silent_rssi_sparrow_find_agc_start(struct calib_silent_rssi *obj, u32 val, u32 idx, u32 thr, u32 *out)
{
    u32 amax = MMIO32(PHY_RX_AGC_MAX_INDEX) & 0x3fu;
    u32 hist, it, ret;
    s32 cur, diff;
    u32 ad;

    hist = silent_rssi_hist_window_index(obj, idx);
    obj->last_hist = hist;
    diff = (s8)(hist - val);
    it = 0;
    cur = (s32)idx;
    for (;;) {
        ad = (u32)(diff < 0 ? -diff : diff);
        if (!(obj->cur.max_iter > it && ad > thr))
            break;
        cur += diff;
        if (cur < (s32)obj->min_idx) {
            fw_log_emit2(0x16, 0x1009cd4, (u32)cur, obj->min_idx);
            cur = obj->min_idx;
        } else if (!(amax >= (u32)cur)) {
            fw_log_emit2(0x16, 0x1009d44, (u32)cur, amax);
            cur = (s32)amax;
        }
        hist = silent_rssi_hist_window_index(obj, (u32)cur);
        diff = (s8)(hist - val);
        it++;
    }
    ad = (u32)(diff < 0 ? -diff : diff);
    if (thr < ad) {
        if (cur == (s32)obj->min_idx || (u32)cur == amax) {
            fw_log_emit2(0x16, 0x1009e1c, thr, (u32)cur);
        } else {
            hist = silent_rssi_hist_window_index(obj, (u32)cur);
            diff = (s8)(hist - val);
            fw_log_emit2(0x6, 0x1009e9c, thr, (u32)cur);
        }
        rf_check_state(obj);
        ret = 2;
    } else {
        ret = 1;
    }
    *out = (u32)cur;
    fw_log_emit3(0x26, 0x1009db4, (u32)cur, idx, val);
    fw_log_emit3(0x26, 0x1009c80, hist, (u32)diff, obj->last_hist);
    return ret;
}

/* calib_silent_rssi_sparrow::find_rf_gain (0x8ca8fc): подбор RF-усиления модуля idx
 * (шаг ±1 в 1..15) так, чтобы окно гистограммы на индексе [obj+0x4c]+[0x800508]
 * совпало с target; при смене знака ошибки остаётся лучшее из двух. Затем
 * поправка второго усиления по температуре ([obj+0x4d]) и числу наборов RF (fwsh_sets.n_sets),
 * перезапись таблиц усилений и итоговое усиление. Возврат 1 — |ошибка|<=1, иначе 2. */
u32 calib_silent_rssi_sparrow_find_rf_gain(struct calib_silent_rssi *obj, u32 idx, u32 mode, s32 target)
{
    u8 g[2];                    /* sp[0] — второе усиление (a4), sp[1] — RF-усиление */
    u8 base;
    u32 it = 0, m;
    s32 d, nd, nxt, v, cur;

    g[0] = obj->rf_gain2[idx];
    g[1] = obj->rf_gain[idx];
    base = (u8)((s8)obj->base_ofs + calib_zero_db.row8);
    obj->start_idx = base;
    if (mode != 0) {
        silent_rssi_load_params_b(obj);
        obj->module_count[idx] = obj->module_count[idx] + 1;
    } else {
        silent_rssi_load_params_a(obj);
        obj->module_count[idx] = 0;
    }
    if (!(obj->cur.flags_w & 2u)) {
        g[1] = 8;
        g[0] = 8;
    }
    (void)u_schd_now();          /* vendor 0x8ca96c: результат не используется */
    silent_rssi_set_rf_gain_index(obj, obj->rf_idx, g[1], 0, g[0], 1);
    d = (s8)(silent_rssi_hist_window_index(obj, base) - (u32)target);

    for (;;) {
        cur = g[1];
        if (it >= obj->cur.max_iter)
            break;
        if (d < 1) {
            if (d >= 0)
                break;
            nxt = cur - 1;
            if (nxt < 1)
                nxt = 1;
        } else {
            nxt = cur + 1;
            if (nxt > 0xf)
                nxt = 0xf;
        }
        if (nxt == cur)
            break;
        g[1] = (u8)nxt;
        silent_rssi_set_rf_gain_index(obj, obj->rf_idx, (u8)nxt, 0, g[0], 1);
        nd = (s8)(silent_rssi_hist_window_index(obj, base) - (u32)target);
        if ((nd < 0 && d >= 1) || (nd >= 1 && d < 0)) {
            /* ошибка сменила знак: оставить ближайшее из двух (vendor 0x8caa0a) */
            s32 ad = d < 0 ? -d : d, an = nd < 0 ? -nd : nd;
            if (ad >= an) {
                d = nd;
            } else {
                g[1] = (u8)cur;
                silent_rssi_set_rf_gain_index(obj, obj->rf_idx, (u8)cur, 0, g[0], 1);
            }
            break;
        }
        if (nd == 0) {
            d = nd;
            break;
        }
        it++;
        d = nd;
    }

    v = (s8)((s8)g[1] + (s8)obj->temp_ofs);
    m = fwsh_sets.n_sets;
    if (m == 2)
        v = (s8)(v - 1);
    else if (m == 3)
        v = (s8)(v - 2);
    else if (m == 4)
        v = (s8)(v - 3);
    if (v < 1)
        v = 1;
    if (v > 0xf)
        v = 0xf;
    g[0] = (u8)v;
    if (g[1] == 1 || g[1] == 0xf)
        fw_log_emit0(0x16, 0x1009ba4);
    d = d < 0 ? -d : d;
    update_rf_xx_gains_tables(obj, idx, &g[1], &g[0]);
    silent_rssi_set_rf_gain_index(obj, obj->rf_idx, g[1], 0, g[0], 0);
    return (d <= 1 ? 0u : 1u) + 1;
}

/* agc__get_table_pair (0x8cb804): пара (старт, массив) AGC: flag=1 — абсолютная
 * (agc_start/agc_gain_arr), flag=0 — по режиму (agc_start_mode/agc_gain_arr_mode). */
void agc_get_table_pair(const struct calib_silent_rssi *p, u32 flag, u32 *out1, u32 *out2)
{
    if (flag != 0) {
        *out1 = p->agc_start;
        *out2 = p->agc_gain_arr;
    } else {
        *out1 = p->agc_start_mode;
        *out2 = p->agc_gain_arr_mode;
    }
}

/* silent_rssi__agc_param_const_2 (0x8cca84): метод-константа (аргументы не читает). */
u32 silent_rssi_agc_param_const_2(const struct calib_silent_rssi *obj, u32 idx)
{
    (void)obj;
    (void)idx;
    return 2;
}

/* bitmap__expand_byte4_to_list (0x8ccafc): номера установленных бит маски
 * rfm->rf_mask → list[0..]; хвост в 0x8c4bb4. Возврат — число элементов (u8). */
u32 bitmap_expand_byte4_to_list(const struct calib_est *rfm, u8 *list)
{
    u32 it;
    u32 n = 0;

    field_set_0x00_8e5dfc(&it, rfm->rf_mask);
    while (bit_iter_has_more(&it)) {
        list[n] = (u8)bitmap_alloc_bit(&it);
        n++;
    }
    return (u8)n;
}

/* rf_mask__count_modules (0x8ccb04): число бит в маске rfm->rf_mask (u8). */
u32 rf_mask_count_modules(const struct calib_est *rfm)
{
    u32 m = rfm->rf_mask;
    u32 n = 0;

    while (m != 0) {
        m &= m - 1;
        n = (u16)(n + 1);
    }
    return (u8)n;
}

/* silent_rssi__agc_param_const_4 (0x8ccb18): метод-константа (аргументы не читает). */
u32 silent_rssi_agc_param_const_4(const struct calib_silent_rssi *obj, u32 idx)
{
    (void)obj;
    (void)idx;
    return 4;
}

/* calib_silent_rssi__flag_step (0x8d33c4): hwd__program_rf_regs_seq(a0, a1, a2, 0 x6,
 * (a3 == 0) ? 0x10 : 0). Результат vendor не возвращает (r0 вызываемой — мусор). */
void calib_silent_rssi_flag_step(u32 a0, u32 a1, u32 a2, u32 a3)
{
    hwd_program_rf_regs_seq(a0, a1, a2, 0, 0, 0, 0, 0, 0, (u8)((a3 == 0 ? 1u : 0u) << 4));
}

/* silent_rssi__set_agc_search_window (0x8d49d0): старт/массив AGC в PHY + окно
 * поиска 0x800512 = max(start - [0x800510], 1) (беззн.), 0x800513 = min([0x800511] +
 * start - 1, 0x3f), флаг 0x800514 = 1. */
void silent_rssi_set_agc_search_window(u32 start, u32 arr)
{
    u32 lo, hi;

    hwd_phy_rx_set_agc_start_val_and_gain_array(start, arr);
    lo = start - calib_agc_win_below;
    if (!(lo > 1))
        lo = 1;
    calib_vga_dc_win_lo = (u8)lo;
    hi = calib_agc_win_above + start - 1;
    if (hi >= 0x3f)
        hi = 0x3f;
    calib_vga_dc_win_hi = (u8)hi;
    calib_vga_dc_fine_force = 1;
}

/* silent_rssi__report_agc_tables (0x8dbec8): при готовом LMAC ([0x8003c8]) собрать
 * отчёт AGC (обе пары старт/массив + константы по 8 модулям) в буфер пула 0x804280,
 * обновить поля слова 0x8538d0 и отправить LMAC-командой 0x11 (длина 0x20). */
void silent_rssi_report_agc_tables(void)
{
    struct lmac_cmd_agc_tables *buf;
    struct calib_silent_rssi *eng;
    u32 i, act;

    if (lmac_ucode_ready == 0)
        return;
    buf = mem_pool_alloc_locked(&lmac_mbox.mb);
    eng = calib_obj4_reset_d4();   /* возвращает объект движка 4 */
    agc_get_table_pair(eng, 1, &buf->start[0], &buf->table[0]);
    agc_get_table_pair(eng, 0, &buf->start[1], &buf->table[1]);
    for (i = 0; i < 8; i++) {
        buf->param4[i] = (u8)silent_rssi_agc_param_const_4(eng, i);
        buf->param2[i] = (u8)silent_rssi_agc_param_const_2(eng, i);
    }
    act = rf_get_active_index();
    silent_rssi_bits_set32_s0_w6(&calib_srssi_agc_word, buf->start[0] & 0x3fu);
    silent_rssi_bits_set32_s12_w4(&calib_srssi_agc_word, silent_rssi_agc_param_const_4(eng, act) & 0xfu);
    bits_set32_s16_w4_ptr(&calib_srssi_agc_word, silent_rssi_agc_param_const_2(eng, act) & 0xfu);
    lmac_if_post_cmd(buf, 0x11, 0x20, 0);
}

/* silent_rssi__hist_window_index (0x8dde0c): гистограмма RSSI ([0x883700], значение
 * ≤0x1f) на RX-индексе idx: cur.n_meas замеров (b0 флагов — по одному с паузой 20
 * циклов, иначе по 4 подряд); если hist[0] > порога cur.thr — RF-комм-тест.
 * Скользящее окно win бинов: первый k, где сумма > порога →
 * win_base + (k - окно + 1) (если неотрицательно); не нашли — 0. */
u32 silent_rssi_hist_window_index(struct calib_silent_rssi *obj, u32 idx)
{
    u16 *hist = obj->hist;
    s32 n = 0, k;
    s32 acc;

    memset0_words(hist, 0x40);
    idx = (u8)idx;
    hwd_abif_rx_table_index_force_mode(0, idx);
    hwd_abif_rx_table_index_force_mode(1, idx);
    if (obj->cur.flags_w & 1u) {
        while (n < (s32)obj->cur.n_meas) {
            u32 v;
            arc_zol_nops2(0x14);                 /* vendor 0x8dde42: lp 0x14 × 2 nop_s */
            v = MMIO32(HW_PHY_RX_INA_RSSI_ADC_DB);
            n++;
            if (v >= 0x1f)
                v = 0x1f;
            hist[v] = (u16)(hist[v] + 1);
        }
    } else {
        while (n < ((s32)obj->cur.n_meas >> 2)) {
            s32 v0 = (s32)MMIO32(HW_PHY_RX_INA_RSSI_ADC_DB);
            s32 v1 = (s32)MMIO32(HW_PHY_RX_INA_RSSI_ADC_DB);
            s32 v2 = (s32)MMIO32(HW_PHY_RX_INA_RSSI_ADC_DB);
            s32 v3 = (s32)MMIO32(HW_PHY_RX_INA_RSSI_ADC_DB);
            /* vendor: min — знаковое (в отличие от ветки b0, где mov.nc) */
            if (v0 > 0x1f) v0 = 0x1f;
            if (v1 > 0x1f) v1 = 0x1f;
            if (v2 > 0x1f) v2 = 0x1f;
            if (v3 > 0x1f) v3 = 0x1f;
            hist[v0] = (u16)(hist[v0] + 1);
            hist[v1] = (u16)(hist[v1] + 1);
            n++;
            hist[v2] = (u16)(hist[v2] + 1);
            hist[v3] = (u16)(hist[v3] + 1);
        }
    }
    if (!((s32)obj->cur.thr >= (s32)hist[0]))
        rf_comm_test(&rf_obj, rf_obj.rf_idx);

    acc = 0;
    for (k = 0; k < 0x20; k++) {
        s32 w = obj->win;
        if (k >= w)
            acc -= hist[k - w];
        acc += hist[k];
        if (!((s32)obj->cur.thr >= acc)) {
            s32 r = k - w + 1;
            u32 res = obj->win_base;
            if (r >= 0)
                res += (u32)r;
            return res;
        }
    }
    return 0;
}

/* Классификатор температуры t против трёх знаковых порогов → 0..3 (тело vendor 0x8e2d5c). */
static u8 calib_classify3(s32 t, const u8 *thr)
{
    if (t < (s8)thr[0])
        return 0;
    if (t < (s8)thr[1])
        return 1;
    return (t < (s8)thr[2]) ? 2 : 3;
}

/* 0x800408 ([gp,0x284]): текущая таблица silent RSSI — образ 0x800c64, calib__start_scheme4
 * (таблица 1) ставит 0x800d04 (include/calib.h). */
FWDATA(800408) u8 *calib_silent_rssi_tbl = (u8 *)&calib_srssi_temp_tbl[0];

/* calib__classify_by_thresholds (0x8e2d5c): температура модуля → 5 классов в таблице
 * calib_silent_rssi_tbl (+0x77/+0x7f/+0x87/+0x8f/+0x97 + модуль; пороги +0/+0x14/+0x38/+0x4c/+0x70),
 * touch модуля, obj->temp_ofs = s8 поправка из таблицы (+0x73 + класс5). */
void calib_classify_by_thresholds(struct calib_silent_rssi *obj, u32 module_idx)
{
    s32 t = (s32)temp_get_rf_by_index(module_idx, 1);
    u8 *b;

    b = calib_silent_rssi_tbl;
    b[0x77 + module_idx] = calib_classify3(t, b + 0x00);
    b = calib_silent_rssi_tbl;
    b[0x7f + module_idx] = calib_classify3(t, b + 0x14);
    b = calib_silent_rssi_tbl;
    b[0x87 + module_idx] = calib_classify3(t, b + 0x38);
    b = calib_silent_rssi_tbl;
    b[0x8f + module_idx] = calib_classify3(t, b + 0x4c);
    b = calib_silent_rssi_tbl;
    b[0x97 + module_idx] = calib_classify3(t, b + 0x70);
    rfca_touch_rf_module(obj, module_idx, 0);
    b = calib_silent_rssi_tbl;
    obj->temp_ofs = (s8)b[0x73 + (s8)b[0x97 + module_idx]];
}

/* marlon_r_if_class::rf_hw_write_buffer (0x8e33d8): len пар {поле, значение} (8 Б) → RF. */
void marlon_r_if_class_rf_hw_write_buffer(struct rf_obj *obj, u32 a1, const struct rf_reg_pair *buf, u32 len)
{
    u32 i;

    (void)obj;
    (void)a1;
    if (len == 0) {
        fw_log_emit1(0x20, 0x10054e4, 0);
        return;
    }
    for (i = 0; i < len; i++)
        rfc_field_write(0, buf[i].addr, buf[i].val, 0);
}

/* Ожидание снятия busy RFC (бит 29 [0x8890cc]): 2000 опросов (не дождались —
 * лог с адресом возврата), затем ещё 200000 (не дождались — ассерт 0x1349).
 * Тело vendor повторено inline трижды в 0x8e3418. */
static void rf_write_wait_idle(void *ra)
{
    u32 i;

    for (i = 0; i < 2000; i++)
        if (!(MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)))
            break;
    if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29))
        fw_log_emit1(0, 0x1004fbc, (u32)ra);
    for (i = 0; i < 0x30d40; i++)
        if (!(MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)))
            break;
    if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {
        fw_log_emit0(0, 0x1004f9c);
        fw_sysassert_fatal(ra, 0x1349);
    }
}

/* marlon_r_if_class::rf_write_with_block_retries (0x8e3418): записать len пар буфера
 * блоками по blk с проверкой счётчика команд RFC [0x8890d8]: после блока счётчик
 * должен вырасти на chunk+1 (записи + commit 0x428). Промах — повтор блока (до retries
 * попыток) с перезапуском делителя RFC и новой базой. Статистика 0x8003e0/e4/e8.
 * Неудача → 0 (и ассерт 0x1344 при fatal), успех → 1. */
u32 marlon_r_if_class_rf_write_with_block_retries(struct rf_obj *obj, u32 a1, const struct rf_reg_pair *buf,
                                                  u32 len, u32 blk, u32 retries, u32 fatal)
{
    void *ra = __builtin_return_address(0);
    u32 rf = (u8)a1;             /* vendor extb (не sexb) */
    u32 off, chunk, n, base, cur, delta;
    const struct rf_reg_pair *blkp;

    hwd_rfc_write_core_fw(rf, 4, 0x428, 0);
    rf_write_wait_idle(ra);
    cur = MMIO32(HW_RFC_CORE_DATA);
    for (off = 0; len > off; off += blk) {
        blkp = buf + off;
        chunk = (blk >= len - off) ? len - off : blk;
        n = 0;
        for (;;) {
            if (n == 0) {
                base = cur;
            } else {
                fw_log_emit0(0x10, 0x1005538);
                hwd_abif_rfc_divider_restart(1);
                hwd_rfc_write_core_fw(rf, 4, 0x428, 0);
                rf_write_wait_idle(ra);
                base = MMIO32(HW_RFC_CORE_DATA);
                fw_log_emit2(0x10, 0x1005588, n, buf->addr);
            }
            marlon_r_if_class_rf_hw_write_buffer(obj, a1, blkp, chunk);
            hwd_rfc_write_core_fw(rf, 4, 0x428, 0);
            rf_write_wait_idle(ra);
            cur = MMIO32(HW_RFC_CORE_DATA);
            delta = cur - base - 1;
            if (delta == chunk || !(n + 1 < retries))
                break;
            n++;
        }
        rf_blkwr_retry_count += n;
        if (delta != chunk) {
            rf_blkwr_fail_count += 1;
            rf_blkwr_last_fail_addr = blkp->addr;
            fw_log_emit3(0, 0x10055ec, blkp->addr, delta, chunk);
            if (fatal != 0)
                fw_sysassert_fatal(ra, 0x1344);
            return 0;
        }
    }
    return 1;
}

/* calib_silent_rssi_sparrow::run_calibration_fragment (0x8e3864): шаг idx из count
 * (count = модулей + 1): idx < count — модуль list[idx-1], idx == count — baseband
 * gain, иначе ассерт. rfm — запрос коррекции (маска RF — rfm->rf_mask). */
u32 calib_silent_rssi_sparrow_run_calibration_fragment(struct calib_silent_rssi *obj, u32 mask,
                                                       u32 idx, u32 count,
                                                       const struct calib_est *rfm)
{
    calib_row8_t list;   /* копия calib_srssi_module_list0: два слова (выравнивание ARC600) */
    u32 r, t0, t1, module;

    if (count != rf_mask_count_modules(rfm) + 1) {
        fw_log_emit3(0, 0x10097e4, count, rf_mask_count_modules(rfm), rfm->rf_mask);
        fw_sysassert_fatal(__builtin_return_address(0), 0x1458);
    }
    list = calib_srssi_module_list0;
    bitmap_expand_byte4_to_list(rfm, list.v);
    if (idx < count) {
        module = list.v[idx - 1];
        t0 = u_schd_now();
        r = silent_rssi_calibrate_single_rf_module(obj, mask, module, rfm);
        t1 = u_schd_now();
        fw_log_emit2(0x26, 0x10096f8, (t1 - t0) << 4, module);
        if (r != 1)
            fw_log_emit3(0x16, 0x100973c, module, rf_mask_count_modules(rfm), rfm->rf_mask);
        return r;
    }
    if (idx == count) {
        fw_log_emit0(0x26, 0x1009864);
        r = calibrate_baseband_gain(obj, mask, rfm);
        if (r != 1)
            fw_log_emit3(0x16, 0x10098dc, 1, rf_mask_count_modules(rfm), rfm->rf_mask);
        return r;
    }
    fw_log_emit3(0, 0x1009974, idx, count, rfm->rf_mask);
    fw_sysassert_fatal(__builtin_return_address(0), 0x145a);
    return 2;
}

/* calib_silent_rssi__step (0x8e3988): все фрагменты 1..модулей+1 подряд; результат —
 * последний отличный от 1 (иначе 1). */
u32 calib_silent_rssi_step(struct calib_silent_rssi *obj, u32 mask, const struct calib_est *rfm)
{
    u32 cnt = (u8)(rf_mask_count_modules(rfm) + 1);
    u32 res = 1, i, r;

    if ((s32)cnt >= 1) {
        for (i = 1; i <= cnt; i++) {
            r = calib_silent_rssi_sparrow_run_calibration_fragment(obj, mask, (u8)i, cnt, rfm);
            if (r != 1)
                res = r;
        }
    }
    return res;
}

/* silent_rssi__load_params_b (0x8e62a4): набор B (set[1]) → рабочие параметры cur:
 * флаги b0/b1, max_iter, n_meas, thr. Доступ через volatile: vendor копирует n_meas и thr
 * двумя ldw/stw, а gcc при известном выравнивании (0xcc → 0xc0) склеивал их в одно
 * слово ld/st. */
void silent_rssi_load_params_b(struct calib_silent_rssi *o)
{
    volatile struct calib_silent_rssi *obj = o;
    u32 v = obj->set[1].flags_w;
    u32 w = obj->cur.flags_w;

    w = (w & ~1u) | (v & 1u);
    w = (w & ~2u) | (((v >> 1) & 1u) << 1);
    obj->cur.flags_w = (u16)w;
    obj->cur.max_iter = obj->set[1].max_iter;
    obj->cur.n_meas = obj->set[1].n_meas;
    obj->cur.thr = obj->set[1].thr;
}

/* silent_rssi__load_params_a (0x8e7200): набор A (+0xc4..0xc9) → рабочие параметры. */
void silent_rssi_load_params_a(struct calib_silent_rssi *obj)
{
    u32 v = obj->set_w[0];
    u32 w = obj->cur.flags_w;

    w = (w & ~1u) | (v & 1u);
    w = (w & ~2u) | (((v >> 1) & 1u) << 1);
    obj->cur.flags_w = (u16)w;
    obj->cur.max_iter = obj->set[0].max_iter;
    obj->cur.n_meas = obj->set[0].n_meas;
    obj->cur.thr = obj->set[0].thr;
}

/* calib_silent_rssi_sparrow::set_agc_start_val (0x8ea8d8): старт AGC val для idx
 * (1..8) модулей: +0x38 = val, +0x3c = по режиму (3: [0x800508]-11+s8[0x800246];
 * 1/2: val - таблица 0x802224[idx-1]; иначе val), упакованные массивы +0x40/+0x44,
 * окно поиска и отчёт LMAC. */
void calib_silent_rssi_sparrow_set_agc_start_val(struct calib_silent_rssi *obj, u32 val, u32 idx)
{
    u32 v, mode;

    if ((s32)idx < 1 || (s32)idx >= 9) {
        fw_log_emit3(0, 0x1009468, idx, 8, val);
        fw_sysassert_fatal(__builtin_return_address(0), 0x145c);
    }
    mode = rf_obj.sets_mode;
    obj->agc_start = val;
    if (mode == 3) {
        v = calib_zero_db.row8 - 0xbu + (u32)(s32)(s8)calib_silent_rssi_agc_ofs_mode3;
        obj->agc_start_mode = v;
    } else if (mode == 2 || mode == 1) {
        calib_row8_t tbl;   /* копия calib_srssi_target_ofs: два слова (выравнивание ARC600) */
        s32 i = (s8)(idx - 1);
        if (i < 0)
            i = 0;
        else if (i > 7)
            i = 7;
        tbl = calib_srssi_target_ofs;
        v = val - tbl.v[i];
        obj->agc_start_mode = v;
    } else {
        obj->agc_start_mode = val;
        v = val;
    }
    fw_log_emit2(0x26, 0x10094dc, val, v);
    obj->agc_gain_arr = hwd_phy_uses_rgf_883100(obj->agc_start_b, obj->delta[0], obj->delta[1],
                                             obj->delta[2], obj->delta[3]);
    obj->agc_gain_arr_mode = hwd_phy_uses_rgf_883100(obj->agc_start_mode_b, obj->delta[0], obj->delta[1],
                                             obj->delta[2], obj->delta[3]);
    silent_rssi_set_agc_search_window(obj->agc_start, obj->agc_gain_arr);
    silent_rssi_report_agc_tables();
}

/* bf__set_field_word_fw (0x8edcb8) с фиксированными полями: *p, биты [lo, lo+w). */
static void calib_bf_set_word(u32 *p, u32 v, u32 lo, u32 w)
{
    u32 m = (w >= 32) ? 0xffffffffu : ((1u << w) - 1u);

    *p = (*p & ~(m << lo)) | ((v & m) << lo);
}

/* silent_rssi__bits_set32_s0_w6 (0x8ed388): *p биты 0..5 = v. */
void silent_rssi_bits_set32_s0_w6(u32 *p, u32 v)
{
    calib_bf_set_word(p, v, 0, 6);
}

/* silent_rssi__bits_set32_s12_w4 (0x8ed3ac): *p биты 12..15 = v. */
void silent_rssi_bits_set32_s12_w4(u32 *p, u32 v)
{
    calib_bf_set_word(p, v, 12, 4);
}

/* bits__set32_s16_w4 (0x8ed3f4): *p биты 16..19 = v. Имя с _ptr: в macq.c уже есть
 * bits_set32_s16_w4 с другой (возвращающей) сигнатурой. */
void bits_set32_s16_w4_ptr(u32 *p, u32 v)
{
    calib_bf_set_word(p, v, 16, 4);
}

/* calib__bits_set32_s20_w12 (0x8ed430): *p биты 20..31 = v. */
void calib_bits_set32_s20_w12(u32 *p, u32 v)
{
    calib_bf_set_word(p, v, 20, 12);
}

/* 0x804adc: копия таблицы усилений RF со сдвигом (16 записей; в образе нули). */
FWDATA(804adc) struct rf_reg_pair calib_rf_gain_tbl[16] = { { 0 } };

/* update_rf_xx_gains_tables (0x8ed9cc): если RF-усиление модуля idx не изменилось
 * и счётчик obj->tbl_rewrite = 0 — только переписать строку rf_obj.gain_tbl[15]. Иначе:
 * копия таблицы усилений rf_obj.gain_tbl (16 записей по 8 Б) в calib_rf_gain_tbl со сдвигом
 * на (*a - 2) (края заполняются крайним значением), запись 16 строк в RF, затем двух
 * строк второго усиления (*b) из rf_obj.gain2_tbl; запомнить *a и *b в объекте и
 * перевести их в «нормальные» 2/4. */
void update_rf_xx_gains_tables(struct calib_silent_rssi *obj, u32 idx, u8 *a, u8 *b)
{
    struct rf_reg_pair buf[2];

    fw_log_emit3(0x26, 0x1009410, idx, *a, obj->rf_gain[idx]);
    if (*a == obj->rf_gain[idx] && obj->tbl_rewrite == 0) {
        buf[0].addr = rf_obj.gain_tbl[15].addr;
        buf[0].val = rf_obj.gain_tbl[15].val;
        if (marlon_r_if_class_rf_write_with_block_retries(&rf_obj, 0, buf, 1, 1, 5,
                                                          chsw_single_attempt) == 0) {
            chsw_config_fail_count += 1;
            hwm_analog_prepare_buf(1);
            marlon_r_if_class_rf_write_with_block_retries(&rf_obj, 0, buf, 1, 1, 5, 1);
        }
        return;
    }
    if (obj->tbl_rewrite != 0)
        obj->tbl_rewrite = (u8)(obj->tbl_rewrite - 1);
    memcpy_fw(calib_rf_gain_tbl, rf_obj.gain_tbl, 0x80);
    {
        s16 r19 = (s16)(*a - 2);
        if (r19 != 0) {
            u32 edge = calib_rf_gain_tbl[15].val;
            s16 src = (s16)(r19 + 1);
            s16 cnt = (s16)(0x10 - src);
            s16 step = 1;
            s32 dst;

            (void)u_schd_now();  /* vendor 0x8eda4e: результат не используется */
            if ((s32)*a >= 2) {
                dst = 1;
            } else {
                edge = calib_rf_gain_tbl[1].val;
                r19 = (s16)(-r19);
                dst = 0xf;
                cnt = (s16)(0xf - r19);
                src = cnt;
                step = -1;
            }
            if (cnt >= 1) {
                u32 n = (u32)(s32)cnt;
                for (;;) {
                    if ((u32)(s32)src >= 0x10 || (u32)dst >= 0x10)
                        fw_sysassert_fatal(__builtin_return_address(0), 0x1488);
                    calib_rf_gain_tbl[dst].val = calib_rf_gain_tbl[src].val;
                    src = (s16)(src + step);
                    n--;
                    dst = (s16)(step + dst);
                    if (n < 1)
                        break;
                }
            }
            src = (s16)(src - step);
            if (r19 >= 2) {
                u32 r0 = (u32)(s32)r19 - 1;
                do {
                    src = (s16)(src - step);
                    r19 = (s16)r0;
                    if ((u32)(s32)src >= 0x10)
                        fw_sysassert_fatal(__builtin_return_address(0), 0x1582);
                    r0 = (u32)(s32)r19 - 1;
                    calib_rf_gain_tbl[src].val = edge;
                } while (r0 >= 1);
            }
        }
    }
    if (marlon_r_if_class_rf_write_with_block_retries(&rf_obj, idx, calib_rf_gain_tbl, 0x10,
                                                      0x10, 5,
                                                      chsw_single_attempt) == 0) {
        chsw_config_fail_count += 1;
        hwm_analog_prepare_buf(1);
        marlon_r_if_class_rf_write_with_block_retries(&rf_obj, idx, calib_rf_gain_tbl, 0x10,
                                                      0x10, 5, 1);
    }
    {
        const struct rf_reg_pair *t = rf_obj.gain2_tbl;
        u32 j = ((s32)*b < 4) ? 1u : (u8)(*b - 3);
        buf[0].addr = t[4].addr;
        buf[0].val = t[*b].val;
        buf[1].addr = t[1].addr;
        buf[1].val = t[j].val;
        if (marlon_r_if_class_rf_write_with_block_retries(&rf_obj, idx, buf, 2, 2, 5,
                                                          chsw_single_attempt) == 0) {
            chsw_config_fail_count += 1;
            hwm_analog_prepare_buf(1);
            /* vendor 0x8edb86: повтор пишет не buf, а 16 строк 0x804adc (r2 = r13) —
             * так у vendor; не меняем (вторые усиления допишутся следующей калибровкой). */
            marlon_r_if_class_rf_write_with_block_retries(&rf_obj, idx, calib_rf_gain_tbl, 0x10,
                                                          0x10, 5, 1);
        }
    }
    obj->rf_gain[idx] = *a;
    obj->rf_gain2[idx] = *b;
    *a = 2;
    *b = 4;
}

/* calib_silent_rssi__ctor (0x8f0004): начальное состояние объекта silent_rssi
 * (calib_silent_rssi_vtbl). Порядок записей как у vendor: перекрывающиеся поля
 * (флаги/max_iter рабочих параметров и наборов, набор A словом) пишутся в той же
 * последовательности. Доступ через volatile: vendor пишет байтами/полусловами, а gcc при
 * известном выравнивании объекта склеивал соседние записи констант в слова. */
void calib_silent_rssi_ctor(struct calib_silent_rssi *obj)
{
    volatile struct calib_silent_rssi *o = obj;
    u32 i, base;
    u32 v;

    o->agc_gain_arr = 0;
    o->agc_gain_arr_mode = 0;
    o->last_hist = 0;
    o->base_ofs = (u8)-11;
    o->temp_ofs = 3;
    o->rsv_4e = 0;
    o->calib_count = 0;
    o->tbl_rewrite = 0;
    o->rf_idx = 0;
    o->base.vt = &calib_silent_rssi_vtbl;
    base = calib_zero_db.row8 - 0xbu;
    o->agc_start = base;
    o->agc_start_mode = base;
    for (i = 0; i < 8; i++) {
        o->rf_gain2[i] = 0;
        o->rf_gain[i] = 0;
        o->module_count[i] = 0;
    }
    o->target = 0x10;
    o->rsv_b5 = 0;
    o->win = 3;
    o->win_base = 3;
    o->delta[0] = 0;
    o->delta[1] = 0xc;
    o->delta[2] = 0x18;
    o->delta[3] = 0x18;
    o->start_idx = (u8)(calib_zero_db.row8 - 0xb);
    o->min_idx = 1;
    v = o->cur.flags_w;
    o->cur.thr = 0x32;
    v = (v | 1u) & ~2u;
    o->cur.flags_w = (u16)v;
    o->cur.max_iter = 9;
    o->cur.n_meas = 0xc00;
    v = o->set_w[0];
    o->set[0].thr = 0x32;
    v = (v | 1u) & ~2u;
    o->set_w[0] = v;
    o->set[0].n_meas = 0xc00;
    v = o->set[1].flags_w;
    o->set[0].max_iter = 9;
    v = (v & ~3u) | 2u;
    o->set[1].flags_w = (u16)v;
    o->set[1].max_iter = 7;
    o->set[1].n_meas = 0x400;
    o->set[1].thr = 0x1e;
}







/* calib_engine__on_ready_for_correction (0x8c75c0): действие автомата движка (таблица
 * 0x802234: EVT_READY_FOR_CORRECTION в CHECK_CORRECTION_NEEDED/WAIT_FOR_RADIO_LOCK ->
 * CORRECTION): следующий фрагмент коррекции объекта движка. Счётчики:
 * calib_engine_corr_count[idx], calib_eng_stats[idx * CE_STAT_NUM + CE_STAT_MAIN_RET0 + результат]. */
void calib_engine_on_ready_for_correction(struct calib_engine *sm)
{
    u32 t0 = u_schd_now();
    u32 idx, r;

    sm->frag += 1;
    calib_engine_corr_count[sm->idx] += 1;
    r = calib_silent_rssi_sparrow_correction_alg(sm->obj, sm->mask, sm->frag, sm->nfrag, &sm->est);
    if (r <= 2) {
        idx = sm->idx;
        calib_eng_stats[idx * CE_STAT_NUM + CE_STAT_MAIN_RET0 + r] += 1;
    } else {
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x140a);
    }
    calib_engine_accumulate_if_enabled((u_schd_now() - t0) << 4);
    sm_defer_call(sm, CE_EV_FRAG_DONE, 0, 0, 0);
}

/* calib_silent_rssi_sparrow__correction_alg (0x8c766c): pre/main/post по vtable объекта. */
u32 calib_silent_rssi_sparrow_correction_alg(struct calib_obj *obj, u32 mask, u32 frag, u32 nfrag,
                                             struct calib_est *est)
{
    u32 r;

    if (nfrag == 0)
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x1081);
    obj->vt->pre(obj, mask);
    r = obj->vt->main(obj, mask, frag, nfrag, est);
    obj->vt->post(obj, mask);
    return r;
}

/* calib_sar_main (0x8c76c0): [vt 0x8006c4 + 0x1c] — SAR-алгоритм с параметрами 0x800518..51a. */
u32 calib_sar_main(struct calib_obj *obj, u32 mask, u32 a2, u32 a3,
                                         struct calib_est *a4)
{
    (void)obj; (void)mask; (void)a2; (void)a3; (void)a4;
    return hwf_calib_sar_alg(calib_sar_skip_step2, calib_sar_thr, calib_sar_idx);
}

/* calib_lo_power_main (0x8c76dc): [vt 0x800694 + 0x1c] — шаг LO power: выбор индекса таблицы
 * и таблицы результатов (0x800a34 / 0x800a28) по режиму объекта (calib_lo_power.mode). */
u32 calib_lo_power_main(struct calib_obj *obj, u32 mask, u32 a2, u32 a3,
                                         struct calib_est *a4)
{
    u32 state = lo_power_calib_get_state_obj();      /* [gp+209] */
    u32 param = lo_power_calib_get_param_d0();       /* [gp+208] */
    u32 mode = ((struct calib_lo_power *)obj)->mode;
    u32 tidx;
    void *tbl;

    (void)mask; (void)a2; (void)a3; (void)a4;
    if (mode == 0) {
        tidx = lo_power_calib_get_table_idx();
        if (tidx == 0 && state == 0xe)
            tbl = calib_results_addr_800a34();
        else
            tbl = calib_results_addr_800a28();
    } else if (mode == 1) {
        tidx = calib_lo_power_tidx_map[lo_power_calib_get_table_idx()];
        tbl = calib_results_addr_800a28();
    } else {
        fw_log_emit1(6, 0x100a2f0, mode);
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x142c);
        return 2;
    }
    calib_lo_power_step_save_mode(tidx, state, tbl, param);
    return 1;
}

/* calib_lo_leakage_main (0x8c7750): [vt 0x80072c + 0x1c] — поиск LO-leakage (I/Q) двумя
 * проходами sweep (крупные шаги 0x20..1, затем мелкие 0x10..1 с форсированным индексом 0x1c),
 * затем запись найденной пары во все 0x1e строк TX-таблицы. */
u32 calib_lo_leakage_main(struct calib_obj *obj, u32 mask, u32 a2, u32 a3,
                                         struct calib_est *a4)
{
    /* sp-кадр vendor: [0]/[1] — текущие x/y (старт 0x40), [2..0xf] — шаги грубого прохода
     * {шаг, множитель}, до нуля; [0x10..0x1d] — шаги точного прохода. */
    static const u32 f_init[30] = {
        0x40, 0x40,
        0x20, 1, 0x10, 1, 8, 1, 4, 1, 2, 1, 1, 1, 0, 0,
        0x10, 1, 8, 1, 4, 1, 2, 1, 1, 1, 0, 0, 0, 0,
    };
    u32 f[30];
    u32 fine, i, cnt;

    memcpy_fw(f, f_init, sizeof(f));   /* vendor заполняет кадр непосредственными st_s */

    (void)mask; (void)a4;
    if (!(a2 == 1 && a3 == 1))
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x1162);
    calib_lo_leakage_sweep(obj, &f[0], &f[1], &f[2]);
    if (f[0] < 4 || f[0] > 0x7b || f[1] < 4 || f[1] > 0x7b) {
        hwd_abif_rx_table_index_force_mode(0, 0);
        hwd_abif_rx_table_index_force_mode(1, 0x3f);
        hwd_abif_tx_table_config_lo_leak_gain(0x1c, 0, 1);
        hwd_abif_tx_table_config_lo_leak_gain(0x1c, 1, 1);
        hwd_abif_tx_table_config_lo_leak_ctrl(0x1c, 0, (u8)f[0]);
        hwd_abif_tx_table_config_lo_leak_ctrl(0x1c, 1, (u8)f[1]);
        hwd_abif_tx_table_index_force_mode(0, 0);
        hwd_abif_tx_table_index_force_mode(1, 0x1c);
        calib_lo_leakage_sweep(obj, &f[0], &f[1], &f[0x10]);
        fine = 1;
    } else {
        fine = 0;
    }
    for (i = 0, cnt = 0x1e; cnt != 0; cnt--, i = (u8)(i + 1)) {
        hwd_abif_tx_table_config_lo_leak_gain(i, 0, fine);
        hwd_abif_tx_table_config_lo_leak_gain(i, 1, fine);
        hwd_abif_tx_table_config_lo_leak_ctrl(i, 0, (u8)f[0]);
        hwd_abif_tx_table_config_lo_leak_ctrl(i, 1, (u8)f[1]);
    }
    fw_log_emit3(0x26, 0x101c848, f[0], f[1], fine);
    return 1;
}

/* calib_if_gain_main (0x8c7898): [vt 0x800604 + 0x1c] — if_gain(mask >> 20). */
u32 calib_if_gain_main(struct calib_obj *obj, u32 mask, u32 a2, u32 a3,
                                         struct calib_est *a4)
{
    (void)obj; (void)a2; (void)a3; (void)a4;
    return if_gain(mask >> 20);
}

/* calib_vga_main (0x8c78ac): [vt 0x800664 + 0x1c] — VGA: при маске без режима — измерение
 * VGA-усилений, шаг VGA-gain и LO power по 0xb индексам 0x1e..0x28; режим 0xdc — только шаг
 * VGA-gain; режим 1 — VGA DC по своей части окна [0x800512..0x800513] (a2 — номер части,
 * a3 — число частей). */
u32 calib_vga_main(struct calib_obj *obj, u32 mask, u32 a2, u32 a3,
                                         struct calib_est *a4)
{
    u32 mode = mask >> 20;
    u32 r = 1;
    u32 buf[2];

    (void)obj; (void)a4;
    if ((mask & 0xfff00000u) == 0) {
        u32 idx = 0x1e, n;
        Calib_Measure_VGA_Gains();
        calib_setup_loopback_hw_b(0, 0, 0, 1, calib_vga_dc_shift);
        r = calib_vga_gain_step(1, 0x3f);
        for (n = 0xb; n != 0; n--, idx = (u8)(idx + 1)) {
            hwd_abif_rx_table_index_force_mode(0, 0);
            hwd_abif_rx_table_index_force_mode(1, idx);
            calib_lo_power_measure(0xff, 0xd, (calib_vga_pt_t *)buf);   /* результат не читается */
        }
    } else if (mode == 0xdc) {
        calib_setup_loopback_hw_b(0, 0, 0, 1, calib_vga_dc_shift);
        r = calib_vga_gain_step(1, 0x3f);
    } else if (mode == 1) {
        u32 hi, lo, span, per, cnt;
        calib_setup_loopback_hw_b(0, 0, 0, 1, calib_vga_dc_shift);
        hi = calib_vga_dc_win_hi;
        lo = calib_vga_dc_win_lo;
        span = (u8)(hi - lo + 1);
        per = (u8)(span / a3);                       /* 0x8c02d4, затем extb */
        per = (u8)(per + ((span - per * a3) != 0 ? 1u : 0u));   /* округление вверх */
        if (span != 1)
            lo = (u8)(lo + (a2 - 1) * per);
        {
            s32 last = (s32)(per + lo - 1);
            if (last > (s32)hi)
                last = (s32)hi;                      /* min (знаковый) */
            last = (u8)last;
            if (last < (s32)lo)
                return r;
            cnt = (u32)(u8)(last - lo) + 1;
        }
        do {
            u32 col;
            for (col = 0; (s32)col < 2; col = (u8)(col + 1)) {
                r = hwf_vga_dc_calibrate(lo, col, calib_vga_dc_shift, calib_vga_dc_thr, 4);
                if (r != 0 && r != 1)
                    fw_log_emit1(0x16, 0x100a254, lo);
            }
            lo = (u8)(lo + 1);
        } while (--cnt >= 1);
    }
    return r;
}

/* calib_silent_rssi_main (0x8c79ec): [vt 0x800634 + 0x1c] — шаг silent RSSI. Без режима в маске:
 * запрос {3, маска RF, число RF}; если calib_count == 0 — предварительный flag_step на всех RF
 * (сохранив/восстановив маску RFCA) и дальше работать с этим запросом; затем
 * calib_silent_rssi__step. С режимом — run_calibration_fragment. Возврат — результат шага. */
u32 calib_silent_rssi_main(struct calib_obj *o, u32 mask, u32 a2, u32 a3,
                                         struct calib_est *a4)
{
    struct calib_silent_rssi *obj = (struct calib_silent_rssi *)o;
    struct {
        struct calib_est est;   /* sp: запрос */
        u8 rfca;                /* sp+0xc: сохранённая маска RFCA */
    } req;
    u32 t0, r, rf, t;
    u32 cnt;
    struct calib_est *rq = a4;

    fw_log_emit3(0x26, 0x1009524, mask, a2, a3);
    if (a4 == 0) {
        fw_log_emit3(0, 0x10095d4, mask, a2, a3);
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x145b);
    }
    t0 = u_schd_now();
    if ((mask & 0xfff00000u) == 0) {
        rf = rf_cfg_get_rf_mask_45e(&rf_obj);
        cnt = 0;
        for (t = rf; t != 0; t &= t - 1)
            cnt = (u16)(cnt + 1);
        calib_req_fill(&req.est, 0, 3, rf, cnt);
        if (obj->calib_count == 0) {
            req.rfca = 0;
            hwd_abif_dvs_rfca_cmd_enable(rf, &req.rfca);
            calib_silent_rssi_flag_step(0, 0x7f, 0, 0);
            hwd_abif_dvs_rfca_cmd_enable(req.rfca, 0);
            rq = &req.est;
        }
        fw_log_emit2(0x26, 0x100955c, rq->rf_mask, mask);
        r = calib_silent_rssi_step(obj, mask, rq);
    } else {
        fw_log_emit3(0x26, 0x100964c, a3, a2, mask);
        r = calib_silent_rssi_sparrow_run_calibration_fragment(obj, mask, a2, a3, a4);
    }
    fw_log_emit1(0x26, 0x10096d0, (u_schd_now() - t0) << 4);
    return r;
}

/* calib_sar_pre (0x8c7b08): [vt 0x8006c4 + 0x18] — петля с PHY-тактом, фиксация DAC1 по
 * индексу 0x3f, освобождение HW, режим SAR DC из RGF, затем петля для SAR (маска 1<<[0x800518]).
 * Результат hwf_dc_calib_fix_dac1 vendor затирает (mov_s r0,1 перед mov_s r1,r0 в слоте) —
 * освобождение HW безусловное. */
void calib_sar_pre(struct calib_obj *obj, u32 mask)
{
    (void)obj; (void)mask;
    calib_setup_loopback_hw_b(1, 1, 1, 1, 0xa);
    (void)hwf_dc_calib_fix_dac1(0x3f, 0x3f, 1);
    calib_log_if_nonzero(1, 1);
    hwd_abif_sar_dc_config_rgf_mode(1);
    calib_setup_loopback_hw(1, 1, 1, 1, calib_sar_idx);
}

/* calib_lo_power_pre (0x8c7b50): [vt 0x800694 + 0x18] — пусто. */
void calib_lo_power_pre(struct calib_obj *obj, u32 mask)
{
    (void)obj; (void)mask;
}

/* calib_lo_leakage_pre (0x8c7b58): [vt 0x80072c + 0x18] — TX-петля для LO-leakage: строка
 * TX 0x1c (gain 0), self TX/RX, RX-индекс 0x3f, корреляция 0x8000/0x65, синус 0x65, swap IQ 4. */
void calib_lo_leakage_pre(struct calib_obj *obj, u32 mask)
{
    (void)obj; (void)mask;
    hwf_calib_acquire_hw();
    hwd_phy_rx_enable(0);
    hwd_phy_tx_enable(0);
    hwd_abif_caf_lpbk_mode(0);
    hwm_calib_set_loopback_mode(0);
    hwd_phy_self_mode_exit();
    ut_hw_modes_step(1, 0x1c, 0x3f);
    hwd_abif_tx_table_config_lo_leak_gain(0x1c, 0, 0);
    hwd_abif_tx_table_config_lo_leak_gain(0x1c, 1, 0);
    hwd_phy_self_tx_mode_entry();
    hwd_phy_tx_enable(1);
    hwd_abif_tx_table_index_force_mode(0, 0x1c);
    hwd_abif_tx_table_index_force_mode(1, 0x1c);
    hwd_phy_self_rx_mode_entry();
    hwd_abif_rx_table_index_force_mode(0, 0x3f);
    hwd_abif_rx_table_index_force_mode(1, 0x3f);
    hwd_phy_dbg_clk_enable(1);
    hwd_phy_rx_cal_corr_config(0x8000, 1, 0x65);
    hwd_phy_tx_singen_config(0x65, 0, 6);
    hwd_phy_tx_singen_transmit(1);
    hwd_phy_set_rx_swap_iq(4);
}

/* calib_if_gain_pre (0x8c7bf8): [vt 0x800604 + 0x18]. vendor передаёт mask>>20 в r0, но
 * calib_corr__estimate_and_apply_rx_gain r0 не читает. */
void calib_if_gain_pre(struct calib_obj *obj, u32 mask)
{
    (void)obj; (void)mask;
    calib_corr_estimate_and_apply_rx_gain();
}

/* calib_vga_pre (0x8c7c0c): [vt 0x800664 + 0x18] — calib__setup_loopback_rx_path (r0 = mask>>20
 * не читается). */
void calib_vga_pre(struct calib_obj *obj, u32 mask)
{
    (void)obj; (void)mask;
    calib_setup_loopback_rx_path();
}

/* calib_silent_rssi_pre (0x8c7c20): [vt 0x800634 + 0x18] — захват HW и RX-петля для silent RSSI. */
void calib_silent_rssi_pre(struct calib_obj *obj, u32 mask)
{
    (void)obj; (void)mask;
    hwf_calib_acquire_hw();
    hwd_phy_rx_enable(0);
    hwd_phy_tx_enable(0);
    hwd_abif_caf_lpbk_mode(0);
    hwm_calib_set_loopback_mode(0);
    hwd_phy_self_mode_exit();
    hwd_phy_self_rx_mode_entry();
    hwm_calib_set_loopback_mode(1);
    hwd_phy_rx_enable(1);
    hwd_phy_rx_ina_det_mode(0);
}

/* calib_sar_post (0x8c7c60): [vt 0x8006c4 + 0x20] — calib_sar__enable_path(1, 1). */
void calib_sar_post(struct calib_obj *obj, u32 mask)
{
    (void)obj; (void)mask;
    calib_sar_enable_path(1, 1);
}

/* calib_lo_power_post (0x8c7c74): [vt 0x800694 + 0x20] — пусто. */
void calib_lo_power_post(struct calib_obj *obj, u32 mask)
{
    (void)obj; (void)mask;
}

/* calib_lo_leakage_post (0x8c7c7c): [vt 0x80072c + 0x20] — снять петлю, выключить синус,
 * освободить HW. */
void calib_lo_leakage_post(struct calib_obj *obj, u32 mask)
{
    (void)obj; (void)mask;
    ut_hw_modes_step(0, 0, 0);
    hwd_phy_tx_singen_transmit(0);
    hwf_calib_release_hw();
}

/* calib_if_gain_post (0x8c7c9c): [vt 0x800604 + 0x20] — hwf_calib__restore_path (r0 не читает). */
void calib_if_gain_post(struct calib_obj *obj, u32 mask)
{
    (void)obj; (void)mask;
    hwf_calib_restore_path();
}

/* calib_vga_post (0x8c7cb0): [vt 0x800664 + 0x20] — calib__release_hw_thunk. */
void calib_vga_post(struct calib_obj *obj, u32 mask)
{
    (void)obj; (void)mask;
    calib_release_hw_thunk();
}

/* calib_silent_rssi_post (0x8c7cc4): [vt 0x800634 + 0x20] — hwf_calib__release_hw. */
void calib_silent_rssi_post(struct calib_obj *obj, u32 mask)
{
    (void)obj; (void)mask;
    hwf_calib_release_hw();
}

/* calib_lo_leakage_step (0x8c839c): подбор VGA DC (колонки 4..1, sel 1) по корреляции Q:
 * r = round(Q / 2^15); пока |r| > 5 и есть колонки — сдвинуть DC колонки на ±1 по знаку r
 * (клампы 0..0x1f); если |r| не уменьшилось — вернуть исходное значение колонки.
 * dc[0..3] — исходные DC колонок 1..4 (читаются здесь). */
void calib_lo_leakage_step(struct calib_obj *obj, u8 *dc)
{
    u32 res[2];
    u32 idx, col, best, more;
    s32 v, r;

    (void)obj;
    idx = abif_get_rx_table_index_force_val();
    hwd_phy_rx_cal_corr_config(0x8000, 1, 0);
    hwd_abif_rx_table_index_force_mode(0, 0);
    hwd_abif_rx_table_index_force_mode(1, idx);
    hwd_phy_rx_cal_corr((s32 *)res);
    v = (s32)res[1];
    r = (v >= 0) ? ((v + 0x4000) >> 15) : -((0x4000 - v) >> 15);
    best = (u32)(r < 0 ? -r : r);
    more = (best > 5) ? 1u : 0u;
    for (col = 1; col <= 4; col++)
        dc[col - 1] = (u8)hwd_abif_rx_table_read_vga_dc(idx, col, 1);
    col = 4;
    while (more != 0) {
        s32 c;
        u32 a;
        best = (u8)best;
        v = (s32)res[1];
        r = (v >= 0) ? ((v + 0x4000) >> 15) : -((0x4000 - v) >> 15);
        c = dc[col - 1];
        if (r > 5) {
            c = c + 1;
            if (c > 0x1f)
                c = 0x1f;
        } else {
            c = c - 1;
            if (c < 0)
                c = 0;
        }
        hwd_abif_rx_table_config_vga_dc(idx, col, 1, (u8)c);
        hwd_abif_rx_table_index_force_mode(0, 0);
        hwd_abif_rx_table_index_force_mode(1, idx);
        hwd_phy_rx_cal_corr((s32 *)res);
        v = (s32)res[1];
        r = (v >= 0) ? ((v + 0x4000) >> 15) : -((0x4000 - v) >> 15);
        a = (u32)(r < 0 ? -r : r);
        if (best >= a)
            best = a;
        else
            hwd_abif_rx_table_config_vga_dc(idx, col, 1, dc[col - 1]);
        col = (u8)(col - 1);
        more = (best < 6) ? 0u : (((s32)col > 0) ? 1u : 0u);
    }
    hwd_phy_rx_cal_corr_config(0x8000, 1, 0x65);
}

/* calib_lo_leakage_substep (0x8dc5bc): AGC-индекс по RSSI ADC (одно измерение после задержки
 * 0x32×2 nop): idx' = clamp(rssi - 0x14 + idx), сравнение с 0xa беззнаковое, затем min 0x3f;
 * форсировать idx', затем вернуть DC колонок 1..4 (sel 1) строки idx из dc[]. */
void calib_lo_leakage_substep(struct calib_obj *obj, const u8 *dc)
{
    u32 idx, v, agc, col, n;

    (void)obj;
    idx = abif_get_rx_table_index_force_val();
    hwd_phy_rx_agc_steps_disable(1);
    hwd_phy_rx_ina_det_mode(0);
    hwd_phy_rx_enable(0);
    hwd_phy_rx_enable(1);
    calib_nop_delay(0x32);
    v = phy_get_ina_rssi_adc_db() - 0x14 + idx;
    agc = (v > 0xa) ? v : 0xa;
    agc = (u8)agc;
    if ((s32)agc > 0x3f)
        agc = 0x3f;
    hwd_abif_rx_table_index_force_mode(0, 0);
    hwd_abif_rx_table_index_force_mode(1, agc);
    hwd_phy_rx_agc_steps_disable(0);
    hwd_phy_rx_enable(0);
    for (col = 1, n = 4; n != 0; n--, col = (u8)(col + 1))
        hwd_abif_rx_table_config_vga_dc(idx, col, 1, dc[col - 1]);
}

/* calib_lo_leakage__sweep (0x8e4cd4): поиск минимума LO-утечки по сетке x/y (ctrl I/Q строки
 * TX 0x1c). steps — пары {шаг, множитель} до нулевого шага; на каждом шаге — окно вокруг
 * текущей точки (prepare_ctx), обход окна ber_test__measure (минимум approx_magnitude_b).
 * Старт x/y — из 0x8037ec/0x8037f0, исходные DC колонок — 0x8037f4. Итог: 0x8538c8/0x8538cc,
 * out_x/out_y; DC колонок 1..4 строки RX-индекса восстанавливаются из сохранённых. */
void calib_lo_leakage_sweep(struct calib_obj *obj, u32 *out_x, u32 *out_y, const u32 *steps)
{
    u32 xy[2];          /* sp+0 */
    s32 ctx[14];        /* sp+8: окно/счётчики обхода (0x38 Б) */
    u32 best[2];        /* sp+0x40 */
    u8 dc[4];           /* sp+0x48 */
    u32 i, idx, col, n;

    xy[0] = calib_lo_leak_start_x;
    xy[1] = calib_lo_leak_start_y;
    best[0] = 0xffffffffu;
    best[1] = 0xffffffffu;
    *(u32 *)dc = calib_lo_leak_init_dc;
    calib_lo_leakage_step(obj, dc);
    calib_lo_set_result((u32 *)ctx, 0, 0x7f, 0, 0x7f);
    for (i = 0; steps[i * 2] != 0; i++) {
        calib_lo_leakage_prepare_ctx(ctx, (s32)xy[0], (s32)xy[1], (s32)steps[i * 2],
                                     (s32)steps[i * 2 + 1], (s32)steps[i * 2 + 1]);
        hwf_set_agc_index_1c(obj, xy[0], xy[1]);
        calib_lo_leakage_substep(obj, dc);
        calib_lo_leakage_step(obj, dc);
        calib_nop_delay(800);
        calib_lo_leakage_substep(obj, dc);
        calib_lo_leakage_step(obj, dc);
        ber_test_measure(obj, (u32 *)ctx, xy, best);
    }
    calib_lo_leak_xy[0] = xy[0];
    calib_lo_leak_xy[1] = xy[1];
    *out_x = xy[0];
    *out_y = xy[1];
    idx = abif_get_rx_table_index_force_val();
    for (col = 1, n = 4; n != 0; n--, col = (u8)(col + 1))
        hwd_abif_rx_table_config_vga_dc(idx, col, 1, dc[col - 1]);
}

/* hwf__set_agc_index_1c (0x8e67a4): LO-leak ctrl строки TX 0x1c: поле 1 = y, поле 0 = x
 * (младшие байты), затем перезапуск CAF-петли. */
void hwf_set_agc_index_1c(struct calib_obj *obj, u32 x, u32 y)
{
    (void)obj;
    hwd_abif_tx_table_config_lo_leak_ctrl(0x1c, 1, (u8)y);
    hwd_abif_tx_table_config_lo_leak_ctrl(0x1c, 0, (u8)x);
    hwd_abif_caf_lpbk_mode(0);
    hwd_abif_caf_lpbk_mode(1);
}

/* sm__defer_call (0x8e7044): отложить событие автомата (узел sm_defer_pool {ev, a2, a3, a4});
 * индекс узла — в basic_sm.deferred (+2). Ассерты vendor возвращаются: при пустом
 * пуле запись идёт в узел 0 — как у vendor. */
void sm_defer_call(void *obj, u32 event, u32 a2, u32 a3, u32 a4)
{
    struct basic_sm *sm = obj;
    struct sm_defer_node *node;

    if (sm->deferred != 0xff)
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x16a2);
    node = mem_pool_allocate(&sm_defer_pool);
    if (node == 0)
        fw_sysassert_fatal((void *)__builtin_return_address(0), 0x1032);
    node->event = event;
    node->a0 = a2;
    node->a1 = a3;
    node->a2 = a4;
    sm->deferred = (u8)((s32)((u32)node - (u32)sm_defer_nodes) >> 4);
}

/* ber_test__measure (0x8e8360): обход окна ctx; в каждой точке (x, y) — LO-leak ctrl, корреляция,
 * approx_magnitude_b; минимум (64-бит сравнение {hi, mag}, старт {-1, -1}) → best_xy и
 * best_metric = {mag, 0}. */
void ber_test_measure(struct calib_obj *obj, u32 *ctx, u32 *best_xy, u32 *best_metric)
{
    u32 res[2], xy[2];
    u32 mag = 0xffffffffu, hi = 0xffffffffu;

    ber_stats_snapshot(ctx);
    while (ber_test_accumulate_counters(ctx) != 0) {
        u32 m;
        ber_test_copy_counters(xy, ctx);
        hwf_set_agc_index_1c(obj, xy[0], xy[1]);
        hwd_phy_rx_cal_corr((s32 *)res);
        m = approx_magnitude_b(obj, res[0], res[1]);
        if (hi > 0 || (hi == 0 && mag > m)) {
            best_xy[0] = xy[0];
            best_xy[1] = xy[1];
            mag = m;
            hi = 0;
        }
    }
    best_metric[0] = mag;
    best_metric[1] = hi;
}

/* calib_engine__accumulate_if_enabled (0x8eaa20): при включённом учёте ([0x853920]) добавить
 * dt к сумме [0x853910]. */
void calib_engine_accumulate_if_enabled(u32 dt)
{
    if (fw_stats_dash.conn_mask != 0)
        fw_stats_dash.conn_time += dt;
}

/* hwf_calib_all (0x8f448c): полная последовательная калибровка RX (не через автомат):
 * температура; при [gp+155] — сброс результатов LO power (первый раз) или прогон его движка
 * 0x80676c; DC (DAC1), SAR, VGA-усиления, VGA-gain + LO power по 0xb индексам, IF-усиление;
 * при [gp+157]==1 — silent RSSI движка 4 по всем RF. */
void hwf_calib_all(void)
{
    u32 t0, mask, cnt, idx, n;
    u32 sp0;            /* sp+0 */
    struct calib_est req;   /* sp+4 */
    u32 buf[2];

    t0 = u_schd_now();
    fw_log_emit0(0x26, 0x101c5bc);
    fw_log_emit0(0x26, 0x101c5e8);
    temp_sense_get_cached(0, 0);
    if (calib_all_lo_power_en != 0) {
        fw_log_emit0(0x26, 0x101c614);
        if (calib_all_lo_power_reset_done == 0) {
            calib_obj_reset_results(&calib_all_lo_power_obj.base);
            calib_all_lo_power_reset_done = 1;
        } else {
            sp0 = 0;
            calib_bits_set32_s20_w12(&sp0, 0);
            calib_silent_rssi_sparrow_correction_alg(&calib_all_lo_power_obj.base, sp0, 1, 1, 0);
        }
    }
    fw_log_emit0(0x26, 0x101c640);
    calib_setup_loopback_hw_b(1, 1, 1, 1, 0xa);
    (void)hwf_dc_calib_fix_dac1(0x3f, 0x3f, 1);
    calib_log_if_nonzero(1, 1);          /* vendor: r0=1 затирает результат до mov_s r1,r0 */
    fw_log_emit0(0x26, 0x101c674);
    calib_setup_loopback_hw(1, 1, 1, 1, 0xd);
    (void)hwf_calib_sar_alg(calib_sar_skip_step2, calib_sar_thr, calib_sar_idx);
    calib_sar_enable_path(1, 1);         /* то же: r1 = r0 = 1 */
    fw_log_emit0(0x26, 0x101c6a8);
    calib_setup_loopback_rx_path();
    Calib_Measure_VGA_Gains();
    calib_release_hw_thunk();
    fw_log_emit0(0x26, 0x101c6dc);
    calib_setup_loopback_hw_b(1, 1, 1, 1, 0xa);
    (void)calib_vga_gain_step(1, 0x3f);
    for (idx = 0x1e, n = 0xb; n != 0; n--, idx = (u8)(idx + 1)) {
        hwd_abif_rx_table_index_force_mode(0, 0);
        hwd_abif_rx_table_index_force_mode(1, idx);
        calib_lo_power_measure(0xff, 0xd, (calib_vga_pt_t *)buf);   /* результат не читается */
    }
    calib_log_if_nonzero(1, 1);
    fw_log_emit0(0x26, 0x101c710);
    calib_corr_estimate_and_apply_rx_gain();
    (void)if_gain(0);
    hwf_calib_restore_path();
    if (calib_all_silent_rssi_en == 1) {
        fw_log_emit0(0x26, 0x101c744);
        sp0 = 0;
        calib_bits_set32_s20_w12(&sp0, 0);
        mask = rf_cfg_get_rf_mask_45e(&rf_obj);
        calib_req_fill(&req, 0, 3, mask, 0xffffffffu);   /* r4 = r2 - 4 в слоте */
        if (rf_obj.sets_mode != 0) {
            struct calib_silent_rssi *obj;
            obj = calib_obj4_reset_d4();   /* объект движка 4 (r0) */
            for (cnt = 0; mask != 0; mask &= mask - 1)
                cnt = (u16)(cnt + 1);
            calib_silent_rssi_sparrow_correction_alg(&obj->base, sp0, 1, cnt, &req);
        }
    } else {
        fw_log_emit0(0x16, 0x101c780);
    }
    fw_log_emit1(0x26, 0x101c7c8, (u_schd_now() - t0) << 4);
}

/* calib_obj__reset_results (0x8f5438): calib_lo_power_vtbl.reset — обнулить результаты
 * объекта LO power (rf_state[], bb_state, mode), прочитать RF-поля 484/488/492 в таблицу
 * 0x800a34, упаковать их с 0xc в 0x800a28, затем main своего класса.
 * vendor передаёт в main маской (r1) неинициализированное слово кадра [sp,0] — main
 * класса LO power (0x8c76dc) r1 не читает; здесь 0. */
void calib_obj_reset_results(struct calib_obj *o)
{
    struct calib_lo_power *obj = (struct calib_lo_power *)o;
    u32 i;

    for (i = 0; i < 8; i++)
        obj->rf_state[i] = 0;
    obj->bb_state = 0;
    obj->mode = 0;
    rfc_read_field_484(rf_obj.rf_idx, calib_results_addr_800a34());
    {
        const u32 *src = calib_results_addr_800a34();
        u32 *dst = calib_results_addr_800a28();
        rfc_pack_field_value(rf_obj.rf_idx, src, dst, 0xc, 0xc, 0xc);
    }
    o->vt->main(o, 0, 0, 0, 0);
}

/* ber_stats__snapshot (0x8f5a40): начало обхода окна: x = xlo - step, y = ylo, done = 0. */
void ber_stats_snapshot(u32 *ctx)
{
    ctx[0x2c / 4] = ctx[0x18 / 4] - ctx[0x28 / 4];
    ctx[0x30 / 4] = ctx[0x20 / 4];
    ctx[0x34 / 4] = 0;
}

/* ber_test__copy_counters (0x8f5cd0): текущая точка обхода {x, y}. */
void ber_test_copy_counters(u32 *dst, const u32 *ctx)
{
    u32 x = ctx[0x2c / 4];
    u32 y = ctx[0x30 / 4];
    dst[0] = x;
    dst[1] = y;
}

/* ber_test__accumulate_counters (0x8f5cdc): следующая точка обхода окна (x += step; за xhi —
 * x = xlo, y += step); 0 — обход завершён (последней была точка {xhi, yhi}). */
u32 ber_test_accumulate_counters(u32 *ctx)
{
    u32 step, x, xhi;

    if (ctx[0x34 / 4] == 1)
        return 0;
    step = ctx[0x28 / 4];
    x = ctx[0x2c / 4] + step;
    xhi = ctx[0x1c / 4];
    ctx[0x2c / 4] = x;
    if (x == xhi && ctx[0x30 / 4] == ctx[0x24 / 4])
        ctx[0x34 / 4] = 1;
    if ((s32)xhi < (s32)x) {
        ctx[0x2c / 4] = ctx[0x18 / 4];
        ctx[0x30 / 4] = ctx[0x30 / 4] + step;
    }
    return 1;
}

/* calib_lo_leakage__prepare_ctx (0x8f8f9c): окно обхода вокруг (x, y): шаг step,
 * полуширина step*kx / step*ky (mul64_s, младшее слово); окно сдвигается целиком, чтобы
 * уложиться в [ctx0..ctx1] / [ctx2..ctx3], центр сдвигается вместе с ним.
 * ctx: 0 xmin, 1 xmax, 2 ymin, 3 ymax, 4 x, 5 y, 6 xlo, 7 xhi, 8 ylo, 9 yhi, 10 step. */
void calib_lo_leakage_prepare_ctx(s32 *ctx, s32 x, s32 y, s32 step, s32 kx, s32 ky)
{
    s32 m, lo, hi, d;

    m = (s32)(u32)((s64)step * kx);
    ctx[10] = step;
    ctx[4] = x;
    ctx[5] = y;
    lo = x - m;
    hi = m + x;
    ctx[6] = lo;
    ctx[7] = hi;
    if (lo < ctx[0]) {
        d = ctx[0] - lo;
        lo += d;
        ctx[6] = lo;
        hi += d;
        ctx[7] = hi;
        ctx[4] = x + d;
    }
    if (ctx[1] < hi) {
        d = hi - ctx[1];
        lo -= d;
        hi -= d;
        ctx[7] = hi;
        ctx[6] = lo;
        ctx[4] = ctx[4] - d;
    }
    m = (s32)(u32)((s64)step * ky);
    lo = y - m;
    hi = y + m;
    ctx[8] = lo;
    ctx[9] = hi;
    if (lo < ctx[2]) {
        d = ctx[2] - lo;
        lo += d;
        ctx[8] = lo;
        hi += d;
        ctx[9] = hi;
        ctx[5] = d + ctx[5];
    }
    if (ctx[3] < hi) {
        d = hi - ctx[3];
        lo -= d;
        ctx[8] = lo;
        hi -= d;
        ctx[9] = hi;
        ctx[5] = ctx[5] - d;
    }
}
