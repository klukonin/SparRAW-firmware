/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Калибровка RF/PHY: прототипы fw/calib.c и fw/calib_hw.c (порт vendor 6.2). */
#ifndef CALIB_H
#define CALIB_H
#include "types.h"
struct rf_reg_pair;
struct rf_obj;
struct calib_obj;
struct calib_silent_rssi;
struct calib_est;
struct calib_engine;
struct if_gain_meas;

typedef struct { _Alignas(4) u8 v[4]; } calib_u8x4_t;      /* 4 байта: индексы/лимиты по столбцам 1..4 */
typedef struct { _Alignas(4) u8 v[8]; } calib_row8_t;      /* строка кодов усиления столбца (индексы 1..8) */
typedef struct { s32 val; u8 b[4]; } calib_vga_pt_t;       /* мощность + 4 байта (индексы / флаги lo_power) */
/* Флаги результата calib_lo_power_measure / calib_battery_phy_step в calib_vga_pt_t.b[]. */
#define CALIB_LOP_SAT   0                       /* b[0] ([4]): насыщение A или B */
#define CALIB_LOP_WEAK  1                       /* b[1] ([5]): «слабый» B или C */
/* Одно измерение rx_cal_corr (calib_battery__prepare 0x8d6e20): I, Q и флаги. */
typedef struct {
    s32 i;                                     /* 0x00 */
    s32 q;                                     /* 0x04 */
    u8  sat;                                   /* 0x08: |I| > 0x1d << (shift+2) */
    u8  weak;                                  /* 0x09: |I| < [gp,147] << (shift+2) */
    u8  rsv_0a[2];
} calib_batt_meas_t;
_Static_assert(sizeof(calib_batt_meas_t) == 0xc, "calib_batt_meas_t");
typedef struct {                                           /* таблица 0x801930 (fw_data, 0x24 Б) */
    calib_u8x4_t lim;                                      /* {8,4,4,4}: число строк в каждом столбце */
    calib_row8_t row[4];                                   /* коды усиления столбцов 1..4 */
} calib_vga_cfg_t;

/* 0x801930: таблица VGA-калибровки (Calib::Measure_VGA_Gains). */
extern calib_vga_cfg_t calib_vga_cfg;

/* Таблица температурных классов silent RSSI (0xa0 Б). Текущая — указатель [0x800408]
 * (в образе — таблица 0); WMI_SET_ACTIVE_SILENT_RSSI_TABLE (calib_start_scheme4) с
 * таблицей 1 ставит таблицу 1, её же загружает WMI_SET_HIGH_POWER_TABLE_PARAMS
 * (rf_cfg_load_800d04, раскладка тела — struct wmi_set_high_power_table_params_cmd, но
 * rx_2_tx_offs здесь сразу за 3-байтовыми порогами). calib_classify_by_thresholds
 * сравнивает температуру модуля RF с тремя знаковыми порогами (°C) каждой пары
 * {temp, conf} и кладёт класс 0..3 в cls[пара][модуль]; temp_ofs = rx_2_tx_offs[класс]. */
struct calib_srssi_temp_tbl {
    u8  tx_dtype_temp[3];                      /* 0x00 */
    u8  rsv_03;
    u32 tx_dtype_conf[4];                      /* 0x04 */
    u8  tx_etype_temp[3];                      /* 0x14 */
    u8  rsv_17;
    u32 tx_etype_conf[8];                      /* 0x18 */
    u8  rx_dtype_temp[3];                      /* 0x38 */
    u8  rsv_3b;
    u32 rx_dtype_conf[4];                      /* 0x3c */
    u8  rx_etype_temp[3];                      /* 0x4c */
    u8  rsv_4f;
    u32 rx_etype_conf[8];                      /* 0x50 */
    u8  rx_2_tx_temp[3];                       /* 0x70 */
    s8  rx_2_tx_offs[4];                       /* 0x73: поправка temp_ofs по классу rx_2_tx */
    u8  cls[5][8];                             /* 0x77: класс модуля 0..7 по порогам пар 0..4 */
};
_Static_assert(__builtin_offsetof(struct calib_srssi_temp_tbl, rx_2_tx_offs) == 0x73, "srssi_temp_tbl");
_Static_assert(__builtin_offsetof(struct calib_srssi_temp_tbl, cls) == 0x77, "srssi_temp_tbl.cls");
_Static_assert(sizeof(struct calib_srssi_temp_tbl) == 0xa0, "srssi_temp_tbl");
/* 0x800c64: таблицы 0 (по умолчанию) и 1 (высокая мощность, 0x800d04). */
extern struct calib_srssi_temp_tbl calib_srssi_temp_tbl[2];
/* 0x801824: дробная часть log2 (if_gain_scale_value): 128 значений u16. */
extern const u16 if_gain_log2_frac[128];
/* 0x80197c: коды IF ctrl (поля 1..3 iftx_ctrl/ifrx_ctrl) по индексу усиления g 0..15. */
extern u8 calib_if_ctrl_tbl[16][3];
/* 0x802224: поправка цели silent RSSI по (число RF − 1), 0..7 (режимы наборов 1/2). */
extern calib_row8_t calib_srssi_target_ofs;
/* 0x80222c: начальный список модулей для bitmap_expand_byte4_to_list ({0xff, 0, …}). */
extern calib_row8_t calib_srssi_module_list0;
/* 0x8423e4 (вне DCCM, fw.ld): дельты мощности строк VGA tbl[4][8] (hwf_calib_bb_gain_rows). */
extern u32 calib_bb_gain_delta[32];
/* Журналы калибровки в блоке статистики fw 0x853800 (вне DCCM, fw.ld). */
extern volatile u8 calib_sar_dc_log[2][8];     /* 0x853830: сэмплы SAR половин 0/1 (calib_sar_step) */
extern volatile u8 calib_vga_dc_log[2][64];    /* 0x853840: остаток VGA DC [sel][idx − 1] */
extern u32 calib_lo_leak_xy[2];                /* 0x8538c8: итог LO leakage x, y */
extern u32 calib_srssi_agc_word;               /* 0x8538d0: старт AGC [5:0], const_4 [15:12], const_2 [19:16] */
/* Температура RF по индексу (0x847fa8, рабочая SRAM, fw.ld): м°C, -1 — нет. Обновляет
 * fw/temp_service.c (обращения volatile — VOL), сбрасывает fw_init_link_defaults. */
extern u32 temp_rf_mdeg[8];

/* Измерение IF gain — аргумент out IF_GAIN::GAIN (0x8d565c), в состоянии if_gain_state+4
 * (0x8067c0). Вход: индексы строк, аттенюаторов, g, шаг, цель, допуск; остальное — результат. */
struct if_gain_meas {
    u8  tx_idx;                                /* 0x00: строка TX-таблицы ABIF (0x1d) */
    u8  rx_idx;                                /* 0x01: строка RX-таблицы (индекс оценки RX-усиления) */
    u8  predist_idx;                           /* 0x02: индекс calib_if_predist_atten_tbl (< 0x13) */
    u8  predist_atten;                         /* 0x03: результат: аттенюатор предыскажения */
    u8  fssel_idx;                             /* 0x04: индекс calib_if_dac_fssel_tbl (< 0x12) */
    u8  fssel;                                 /* 0x05: результат: DAC fssel */
    u8  g;                                     /* 0x06: индекс усиления calib_if_ctrl_tbl */
    u8  step;                                  /* 0x07: шаг двоичного поиска g */
    u8  meas;                                  /* 0x08: результат: измерение (sub 0) */
    u8  scaled;                                /* 0x09: результат: RSSI ADC (if_gain__get_scaled) */
    u8  ina;                                   /* 0x0a: результат: INA 0x883708[5:0] */
    u8  rsv0b;                                 /* 0x0b */
    u16 cnt;                                   /* 0x0c: результат: счётчик RX (sub 2) */
    u8  target;                                /* 0x0e: цель */
    u8  tol;                                   /* 0x0f: допуск */
    u8  iter;                                  /* 0x10: результат: число итераций */
    u8  rsv11;                                 /* 0x11 */
};
_Static_assert(__builtin_offsetof(struct if_gain_meas, cnt) == 0x0c, "if_gain_meas");
_Static_assert(__builtin_offsetof(struct if_gain_meas, iter) == 0x10, "if_gain_meas");
_Static_assert(sizeof(struct if_gain_meas) == 0x12, "if_gain_meas");

/* Состояние калибровки IF gain (0x8067bc, DCCM, 0x18 Б; в образе нули) — if_gain (0x8d5b64). */
struct if_gain_state {
    s8  agc_delta;                             /* 0x00: сдвиг индекса оценки RX-усиления (calib_corr) → старт AGC */
    u8  rsv01[3];                              /* 0x01 */
    struct if_gain_meas m;                     /* 0x04: измерение IF_GAIN::GAIN */
    u8  rsv16[2];                              /* 0x16 */
};
_Static_assert(__builtin_offsetof(struct if_gain_state, m) == 0x04, "if_gain_state");
_Static_assert(sizeof(struct if_gain_state) == 0x18, "if_gain_state");
extern struct if_gain_state if_gain_state;     /* 0x8067bc */

/* Результат калибровки IF gain (0x842464, вне DCCM — символ fw.ld): if_gain,
 * if_gain__compute_correction, calib_corr__estimate_and_apply_rx_gain. */
struct if_gain_res {
    u8  dvs70[3];                              /* 0x00: поля [15:12]/[19:16]/[23:20] abif_dvs_stat_70 (0x8894f0) */
    u8  tx_atten;                              /* 0x03: phy_tx_atten_val (0x884134) [7:0] */
    u8  dvs64;                                 /* 0x04: поле [21:16] abif_dvs_stat_64 (0x8894e4) */
    u8  atten_sum;                             /* 0x05: fssel_idx − 26 − predist_idx */
    u8  agc_idx;                               /* 0x06: индекс оценки RX-усиления */
    u8  lo_level;                              /* 0x07: уровень LO-мощности (round >> 16) */
    u8  level;                                 /* 0x08: уровень a0 (if_gain_meas.scaled) */
    u8  err;                                   /* 0x09 */
    u8  gain;                                  /* 0x0a: итоговое усиление (против rf_if_gain_rssi_ofs) */
    u8  g;                                     /* 0x0b: индекс усиления IF (→ hwf_if_gain_apply_agc_table) */
    u8  gain_half;                             /* 0x0c: (gain − 10) / 2 + 10 */
    u8  rsv0d;                                 /* 0x0d */
    u16 cnt;                                   /* 0x0e: if_gain_meas.cnt */
    u32 result;                                /* 0x10: итог 0/1/2 */
};
_Static_assert(__builtin_offsetof(struct if_gain_res, cnt) == 0x0e, "if_gain_res");
_Static_assert(sizeof(struct if_gain_res) == 0x14, "if_gain_res");
extern struct if_gain_res if_gain_res;         /* 0x842464 */

/* Строка RX-таблицы «0 дБ» и её уровень (0x800508, DCCM, 8 Б; журнал vendor «g_zero_db_row»):
 * ставит hwf_calib_bb_gain_create_table (база + 0x40), уточняет calib_corr (calib_lo_power_substep
 * пишет оба слова); читают RSSI/энергия (rx_energy__calc_rssi_q4), silent RSSI, IF gain. */
struct calib_zero_db {
    union {
        u32 row;                               /* 0x00: слово (calib_lo_power_substep out[0]) */
        u8  row8;                              /* 0x00: читают младший байт (ldb) */
    };
    s32 level;                                 /* 0x04: уровень LO-мощности строки (Q16) */
};
_Static_assert(sizeof(struct calib_zero_db) == 8, "calib_zero_db");
/* volatile: vendor перечитывает строку при каждом использовании и пишет строку до уровня;
 * с именованным объектом gcc иначе схлопывает чтения и переставляет записи. */
extern volatile struct calib_zero_db calib_zero_db;   /* 0x800508 (fw/calib.c) */

/* Результат APU PHY (hwd_phy__rx_apu_calc 0x8d2314, 12 Б; UT 12/0x42a). */
struct phy_apu_res {
    u16 out_i;                                 /* 0x00: phy_apu_out [15:0] (0x883a78) */
    u16 out_q;                                 /* 0x02: phy_apu_out [31:16] */
    u32 div_man;                               /* 0x04: phy_apu_div_out_man (0x883a7c) */
    u8  div_exp;                               /* 0x08: phy_apu_div_out_exp [3:0] (0x883a80) */
    u8  rsv09[3];                              /* 0x09 */
};
_Static_assert(sizeof(struct phy_apu_res) == 0xc, "phy_apu_res");

/* Снимок состояния RF/PHY на время калибровки (0x842390, 0x54 Б, вне DCCM — символ fw.ld):
 * пишет hwf_calib__acquire_hw (0x8d65e8), восстанавливает hwf_calib__release_hw (0x8d64c0). */
struct calib_hw_snap {
    u32 acquired;                              /* 0x00: флаг захвата (ассерты 0x12de/0x12df) */
    u32 ina_det_mode;                          /* 0x04: режим INA-детектора PHY RX */
    u32 sar_dc_rgf_mode;                       /* 0x08: SAR DC из RGF (ABIF) */
    u32 dbg_clk_en;                            /* 0x0c: отладочный такт PHY */
    u32 rx_tbl_force_en;                       /* 0x10: форс индекса RX-таблицы ABIF (0x88a204 б0) */
    u8  rx_tbl_force_val;                      /* 0x14: значение форса (0x88a204[6:1]) */
    u8  rsv15[3];                              /* 0x15 */
    u32 agc_steps_dis;                         /* 0x18: 0x8831c0 == 0x21 (hwd_phy_get_883180) */
    u32 agc_force_en;                          /* 0x1c: форс AGC-индекса (0x883048 б15) */
    union {                                    /* 0x20: 0x883048[14:0]; vendor пишет u16, читает ldb */
        u16 agc_force_idx;
        u8  agc_force_idx_lo;
    };
    u8  rsv22[2];                              /* 0x22 */
    u32 lpbk_mode;                             /* 0x24: режим петли ABIF (1/2/4/0x10) */
    u32 abif_88af00;                           /* 0x28: hwd_abif_get_88af00 (0x88af40) */
    u8  ifrx_pwdn;                             /* 0x2c: ifrx_pwdn RX */
    u8  rsv2d[3];                              /* 0x2d */
    u32 self_rx_mode;                          /* 0x30: 0x883010 б2 */
    u32 self_tx_mode;                          /* 0x34: 0x883004 б1 */
    u32 rx_swap_iq;                            /* 0x38 */
    u32 tx_swap_iq;                            /* 0x3c */
    u32 rx_en;                                 /* 0x40: 0x883010 б0 */
    u32 tx_en;                                 /* 0x44: 0x884008 б0 */
    u8  predist_atten[3];                      /* 0x48: 0x884130 б0, 0x884134 [7:0]/[15:8] */
    u8  tx_ctrl;                               /* 0x4b: 0x884070 & 3 */
    u32 tx_tbl_force_en;                       /* 0x4c: форс индекса TX-таблицы */
    u8  tx_tbl_force_val;                      /* 0x50 */
    u8  rsv51[3];                              /* 0x51 */
};
_Static_assert(__builtin_offsetof(struct calib_hw_snap, agc_force_idx) == 0x20, "calib_hw_snap");
_Static_assert(__builtin_offsetof(struct calib_hw_snap, lpbk_mode) == 0x24, "calib_hw_snap");
_Static_assert(__builtin_offsetof(struct calib_hw_snap, predist_atten) == 0x48, "calib_hw_snap");
_Static_assert(__builtin_offsetof(struct calib_hw_snap, tx_tbl_force_val) == 0x50, "calib_hw_snap");
_Static_assert(sizeof(struct calib_hw_snap) == 0x54, "calib_hw_snap");
extern struct calib_hw_snap calib_hw_snap;     /* 0x842390 */

/* Текущая таблица порогов/поправок silent RSSI (0x800408, fw/calib.c): 0x800c64, после
 * calib__start_scheme4 с таблицей 1 — 0x800d04 (раскладка — calib_classify_by_thresholds). */
extern u8 *calib_silent_rssi_tbl;

/* fw/calib_hw.c */
void abif_agc_field_rmw(u32 idx, u32 col, u32 sel, u32 d);
u32 abif_get_rx_table_index_force_val(void);
void abif_set_3bit_all_chains(u32 v);
void abif_set_nibble_all_chains(u32 v);
void hw_modes_set_loopback(u32 on, u32 b);
void hwd_abif_battery_config(u32 a, u32 b);
void hwd_abif_config_vga_rows(u32 idx, const u8 *gain);
u32 hwd_abif_get_88af00(void);
void hwd_abif_rx_prepare_ifrx_pwdn(u32 a);
u32 hwd_abif_rx_prepared_ifrx_pwdn_get(void);
u32 hwd_abif_rx_rgf_read_sar_dc(u32 a, u32 b, u32 c);
void hwd_abif_rx_rgf_sar_dc_load(void);
void hwd_abif_rx_rgf_update_sar_dc(u32 a, u32 b, u32 c);
void hwd_abif_rx_table_config_ifrx_ctrl(u32 idx, u32 field, u32 val);
void hwd_abif_rx_table_config_vga_atten(u32 idx, u32 col, u32 sel, u32 val);
void hwd_abif_rx_table_config_vga_dc(u32 idx, u32 col, u32 sel, u32 val);
void hwd_abif_rx_table_config_vga_gain(u32 idx, u32 col, u32 sel, u32 val);
u32 hwd_abif_rx_table_index_force_en_get(void);
u32 hwd_abif_rx_table_read_vga_dc(u32 idx, u32 col, u32 sel);
u32 hwd_abif_rx_table_read_vga_gain(u32 idx, u32 col, u32 sel);
void hwd_abif_sar_cal_dc_rgf_clear_all(void);
void hwd_abif_sar_dc_config_rgf_mode(u32 v);
u32 hwd_abif_sar_dc_config_rgf_mode_get(void);
void hwd_abif_set_agc_column(u32 idx, u32 sel, const u8 *val);
void hwd_abif_tx_table_config_dac_fssel(u32 idx, u32 v);
void hwd_abif_tx_table_config_iftx_ctrl(u32 idx, u32 field, u32 val);
void hwd_abif_tx_table_config_lo_leak_ctrl(u32 idx, u32 field, u32 val);
void hwd_abif_tx_table_config_lo_leak_gain(u32 idx, u32 field, u32 val);
void hwd_abif_tx_table_config_xif_gain(u32 idx, u32 v);
u32 hwd_abif_tx_table_index_force_en_get(void);
void hwd_abif_tx_table_index_force_mode(u32 mode, u32 idx);
u32 hwd_abif_tx_table_index_force_val_get(void);
void hwd_abif_txrx_table_index_lpbk_mode(u32 a0, u32 a1);
u32 hwd_abif_uses_rgf_88af80_8ce614(void);
void hwd_args_to_regs_default(u32 a);
void hwd_mac_trigger_sxd_tx_mode(u32 a);
void hwd_mac_uses_rgf_886200(u32 v);
void hwd_phy_dbg_clk_enable(u32 on);
u32 hwd_phy_dbg_clk_enable_get(void);
u32 hwd_phy_get_883180(void);
void hwd_phy_get_884100(u8 *out);
u32 hwd_phy_get_rx_swap_iq(void);
u32 hwd_phy_get_tx_swap_iq(void);
void hwd_phy_read_sar_sample(u32 idx, u32 *out);
void hwd_phy_rx_agc_index_force_mode(u32 en, u32 idx);
void hwd_phy_rx_cal_corr(s32 *out);
void hwd_phy_rx_cal_corr_config(u32 period, u32 en, s32 freq);
void hwd_phy_rx_ina_det_mode(u32 v);
void hwd_phy_rx_sar_cal_measurement_config(u32 en, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5);
void hwd_phy_rx_sar_measurement_completed(void);
void hwd_phy_rx_sar_measurement_start(void);
void hwd_phy_rx_set_agc_start_val_and_gain_array(u32 start, u32 arr);
void hwd_phy_rx_statistics_clear(void);
void hwd_phy_rx_statistics_lock(void);
void hwd_phy_self_mode_exit(void);
void hwd_phy_self_rx_mode_entry(void);
void hwd_phy_self_tx_mode_entry(void);
void hwd_phy_set_rx_swap_iq(u32 mode);
void hwd_phy_set_tx_swap_iq(u32 mode);
void hwd_phy_tx_ctrl_884070(u32 v);
void hwd_phy_tx_predist_atten_man_config(u32 en, u32 a1, u32 a2);
void hwd_phy_tx_self_transmit(u32 n, u32 a1, u32 a2, u32 a3);
void hwd_phy_tx_self_transmit_wait_completion(void);
void hwd_phy_tx_singen_config(s32 f0, s32 f1, u32 amp);
void hwd_phy_tx_singen_transmit(u32 v);
u32 hwd_phy_uses_rgf_883100(u32 base, u32 d1, u32 d2, u32 d3, u32 d4);
void hwd_program_rf_regs_seq(u32 rf, u32 idx, u32 sel, u32 v0, u32 v1, u32 v2, u32 v3, u32 v4, u32 v5, u8 v6);
void hwm_set_analog_path(u32 on, u32 tx_idx, u32 rx_idx);
u32 phy_get_ina_rssi_adc_db(void);
u32 phy_get_rx_ina_det_mode(void);
void phy_read_rx_counters(u32 *out);
void rf_sector_commit_rx(u32 a, u32 b);
void rf_sector_commit_tx(u32 a, u32 b);
void rf_set_8894a0_field(u32 v);
void rfc_pack_field_value(u32 unused, const u32 *src, u32 *dst, u32 a, u32 b, u32 c);
void rfc_read_field_484(u32 rf, u32 *out);
void rfc_write_gain_idx_reg504(const struct rf_obj *p, u32 a, u32 b);
void txrx_sel(struct rf_obj *obj, u32 rf, u32 dir, u32 sector);
void ut_hw_drivers_cmd_0x508(u32 rf, u32 idx, u32 v);
void ut_hw_modes_step(u32 on, u32 tx_idx, u32 rx_idx);

/* fw/calib.c */
u32 Calib_Measure_VGA_Gains(void);
void IF_GAIN_GAIN(u32 mode, u32 sub, u32 act, struct if_gain_meas *out);
void agc_get_table_pair(const struct calib_silent_rssi *p, u32 flag, u32 *out1, u32 *out2);
u32 approx_magnitude(u32 a0, u32 a1);
u32 approx_magnitude_b(struct calib_obj *obj, u32 b, u32 c);
void ber_stats_snapshot(u32 *ctx);
u32 ber_test_accumulate_counters(u32 *ctx);
void ber_test_copy_counters(u32 *dst, const u32 *ctx);
void ber_test_measure(struct calib_obj *obj, u32 *ctx, u32 *best_xy, u32 *best_metric);
u32 bitmap_expand_byte4_to_list(const struct calib_est *rfm, u8 *list);
void bits_set32_s16_w4_ptr(u32 *p, u32 v);
void bytes_pick4_by_index(const calib_u8x4_t *idx, calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4, calib_u8x4_t *out);
void calib_battery_phy_step(u32 shift, calib_vga_pt_t *out, calib_batt_meas_t *meas);
void calib_battery_prepare(calib_batt_meas_t *out, u32 shift);
u32 calib_bb_gain_pack_row(const u8 *src, u32 flag);
void calib_bits_set32_s20_w12(u32 *p, u32 v);
void calib_classify_by_thresholds(struct calib_silent_rssi *obj, u32 module_idx);
void calib_corr_estimate_and_apply_rx_gain(void);
s32 calib_delta(u32 a, u32 b, u32 c);
void calib_engine_accumulate_if_enabled(u32 dt);
void calib_engine_on_ready_for_correction(struct calib_engine *sm);
u32 calib_if_gain_main(struct calib_obj *obj, u32 mask, u32 a2, u32 a3, struct calib_est *a4);
void calib_if_gain_post(struct calib_obj *obj, u32 mask);
void calib_if_gain_pre(struct calib_obj *obj, u32 mask);
void calib_keep_closest(calib_vga_pt_t *best, s32 val, calib_u8x4_t g, s32 target);
u32 calib_lo_leakage_main(struct calib_obj *obj, u32 mask, u32 a2, u32 a3, struct calib_est *a4);
void calib_lo_leakage_post(struct calib_obj *obj, u32 mask);
void calib_lo_leakage_pre(struct calib_obj *obj, u32 mask);
void calib_lo_leakage_prepare_ctx(s32 *ctx, s32 x, s32 y, s32 step, s32 kx, s32 ky);
void calib_lo_leakage_step(struct calib_obj *obj, u8 *dc);
void calib_lo_leakage_substep(struct calib_obj *obj, const u8 *dc);
void calib_lo_leakage_sweep(struct calib_obj *obj, u32 *out_x, u32 *out_y, const u32 *steps);
u32 calib_lo_power_main(struct calib_obj *obj, u32 mask, u32 a2, u32 a3, struct calib_est *a4);
void calib_lo_power_measure(u32 idx, u32 shift, calib_vga_pt_t *res);
void calib_lo_power_post(struct calib_obj *obj, u32 mask);
void calib_lo_power_pre(struct calib_obj *obj, u32 mask);
void calib_lo_power_save_level(u32 v);
void calib_lo_power_step(u32 bits3, u32 nibble, u32 *fields, u32 level);
void calib_lo_power_step_save_mode(u32 bits3, u32 nibble, u32 *fields, u32 level);
void calib_lo_power_substep(u32 *out, u32 idx, u32 target);
void calib_lo_set_result(u32 *p, u32 a, u32 b, u32 c, u32 d);
void calib_log_if_nonzero(u32 a, u32 flag);
void calib_obj_reset_results(struct calib_obj *o);
void calib_release_hw_thunk(void);
void calib_req_fill(struct calib_est *dst, u32 unused, u32 val, u32 byte, u32 val2);
u32 *calib_results_addr_800a28(void);
u32 *calib_results_addr_800a34(void);
void calib_row_step(u32 row, const calib_u8x4_t *idx, calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4, u32 mode, u32 col, calib_vga_pt_t *meas, u8 *dc);
void calib_sar_enable_path(u32 sar_off, u32 release);
u32 calib_sar_main(struct calib_obj *obj, u32 mask, u32 a2, u32 a3, struct calib_est *a4);
void calib_sar_post(struct calib_obj *obj, u32 mask);
void calib_sar_pre(struct calib_obj *obj, u32 mask);
u32 calib_sar_step(u32 idx, u32 n, u32 avg, u32 thr);
void calib_sar_step2(u32 shift);
void calib_setup_loopback_hw(u32 acquire, u32 abif, u32 phy, u32 sar, u32 shift);
void calib_setup_loopback_hw_b(u32 acquire, u32 abif, u32 phy, u32 corr, u32 shift);
void calib_setup_loopback_rx_path(void);
void calib_silent_rssi_ctor(struct calib_silent_rssi *o);
void calib_silent_rssi_flag_step(u32 a0, u32 a1, u32 a2, u32 a3);
u32 calib_silent_rssi_main(struct calib_obj *o, u32 mask, u32 a2, u32 a3, struct calib_est *a4);
void calib_silent_rssi_post(struct calib_obj *obj, u32 mask);
void calib_silent_rssi_pre(struct calib_obj *obj, u32 mask);
u32 calib_silent_rssi_sparrow_correction_alg(struct calib_obj *obj, u32 mask, u32 frag, u32 nfrag, struct calib_est *est);
u32 calib_silent_rssi_sparrow_find_agc_start(struct calib_silent_rssi *obj, u32 val, u32 idx, u32 thr, u32 *out);
u32 calib_silent_rssi_sparrow_find_rf_gain(struct calib_silent_rssi *obj, u32 idx, u32 mode, s32 target);
u32 calib_silent_rssi_sparrow_run_calibration_fragment(struct calib_silent_rssi *obj, u32 mask, u32 idx, u32 count, const struct calib_est *rfm);
void calib_silent_rssi_sparrow_set_agc_start_val(struct calib_silent_rssi *obj, u32 val, u32 idx);
u32 calib_silent_rssi_step(struct calib_silent_rssi *obj, u32 mask, const struct calib_est *rfm);
u32 calib_vga_coarse(calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4, calib_vga_pt_t meas, calib_vga_pt_t best, calib_u8x4_t *prev, calib_u8x4_t *cur, calib_u8x4_t *keep, calib_u8x4_t *dc, u32 *retry, u8 *next_col, u32 col, u8 *col_out, u32 first, u32 *status);
void calib_vga_coarse_limit(calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4, calib_u8x4_t *idx, u32 val, u8 *next_col, u32 col, u32 flag, u8 *col_out, u32 *status);
u32 calib_vga_gain_step(u32 lo, u32 hi);
u32 calib_vga_main(struct calib_obj *obj, u32 mask, u32 a2, u32 a3, struct calib_est *a4);
void calib_vga_post(struct calib_obj *obj, u32 mask);
void calib_vga_pre(struct calib_obj *obj, u32 mask);
u32 calibrate_baseband_gain(struct calib_silent_rssi *obj, u32 mask, const struct calib_est *rfm);
void hwf_calib_acquire_hw(void);
void hwf_calib_all(void);
void hwf_calib_bb_gain_args(calib_vga_pt_t meas, const calib_u8x4_t *idx, calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4);
void hwf_calib_bb_gain_create_table(u32 *tbl, calib_vga_pt_t best, calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4);
u32 hwf_calib_bb_gain_rows(calib_u8x4_t lim, calib_row8_t r1, calib_row8_t r2, calib_row8_t r3, calib_row8_t r4, calib_vga_pt_t *out, u32 *tbl);
u32 hwf_calib_lo_power_flow(u32 mode, u32 nibble, u32 f0, u32 f1, u32 f2, u32 level, u32 rf);
void hwf_calib_release_hw(void);
void hwf_calib_restore_path(void);
u32 hwf_calib_sar_alg(u32 skip_step2, u32 thr, u32 idx);
void hwf_dc_calib_fix_dac1(u32 lo, u32 hi, u32 mode);
void hwf_if_gain_apply_agc_table(u32 a0);
void hwf_set_agc_index_1c(struct calib_obj *obj, u32 x, u32 y);
u32 hwf_vga_dc_calibrate(u32 idx, u32 sel, u32 shift, u32 thr, u32 col);
s32 hwf_vga_dc_measure(u32 sel, u32 shift);
u32 if_gain(u32 a0);
void if_gain_apply_delta(s32 delta, struct if_gain_meas *out);
u32 if_gain_compute_correction(u32 a0, const struct if_gain_meas *a1);
u32 if_gain_get_scaled(u32 n);
s32 if_gain_scale_value(u32 a, u32 c);
u32 lo_power_calib_get_param_d0(void);
u32 lo_power_calib_get_state_obj(void);
u32 lo_power_calib_get_table_idx(void);
void marlon_r_if_class_rf_hw_write_buffer(struct rf_obj *obj, u32 a1, const struct rf_reg_pair *buf, u32 len);
u32 marlon_r_if_class_rf_write_with_block_retries(struct rf_obj *obj, u32 a1, const struct rf_reg_pair *buf, u32 len,
                                                  u32 blk, u32 retries, u32 fatal);
u32 rf_mask_count_modules(const struct calib_est *rfm);
u32 silent_rssi_agc_param_const_2(const struct calib_silent_rssi *obj, u32 idx);
u32 silent_rssi_agc_param_const_4(const struct calib_silent_rssi *obj, u32 idx);
void silent_rssi_bits_set32_s0_w6(u32 *p, u32 v);
void silent_rssi_bits_set32_s12_w4(u32 *p, u32 v);
u32 silent_rssi_calibrate_single_rf_module(struct calib_silent_rssi *obj, u32 mask, u32 module_idx, const struct calib_est *rfm);
u32 silent_rssi_hist_window_index(struct calib_silent_rssi *obj, u32 idx);
void silent_rssi_load_params_a(struct calib_silent_rssi *obj);
void silent_rssi_load_params_b(struct calib_silent_rssi *obj);
void silent_rssi_report_agc_tables(void);
void silent_rssi_set_agc_search_window(u32 start, u32 arr);
void silent_rssi_set_rf_gain_index(struct calib_silent_rssi *obj, u32 idx, u32 a2, u32 a3, u32 a4, u32 a5);
void sm_defer_call(void *obj, u32 event, u32 a2, u32 a3, u32 a4);
void update_rf_xx_gains_tables(struct calib_silent_rssi *obj, u32 idx, u8 *a, u8 *b);

#endif
