// SPDX-License-Identifier: AGPL-3.0-or-later
/* Тела LMAC-команд fw → uc (lmac_if_post_cmd(buf, id, len, 0) → ucode_cmd_dispatch(hdr, body))
 * и событий uc → fw.
 *
 * Раскладка — по чтениям ucode (uc/cmd.c) и записям отправителей fw (fw/lmac*.c, radio_mgr.c,
 * discovery.c, l2mgr.c, vring.c, action.c, wmi_h_bf.c, link_sm.c). Ширина
 * полей — как у доступов vendor (ldb/ldw/ld); слово, которое одна сторона пишет целиком, а
 * другая читает по байтам, — анонимный union. Неизвестные места — rsvN.
 * Общий заголовок fw и uc: имена полей не должны совпадать с макросами uc/dccm.h. */
#ifndef LMAC_CMD_H
#define LMAC_CMD_H
#include "types.h"
#include "fwsh.h"

#define LMAC_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

/* Конфигурация развёртки секторов (SS), 0x4c Б: txss_ss[9] по станциям (8 — маяк/широковещ.),
 * bti_sw.bcn_ss (0x802a20) для маяка, 0x801694 — omni. Тело LMAC 0x0b/0x0c (с +4), 0x35 (с +0),
 * WMI txss_set_sectors_*. */
struct ss_cfg_s {
    u32  x0;                            /* +0x00 != 0 — не принуждать порядок */
    u32  host_set;                      /* +0x04 1 — число кадров задано хостом */
    u8   order[64];                     /* +0x08 порядок секторов, 0xff — конец */
    u8   n_frames;                      /* +0x48 число кадров SSW (≤ длины order) */
    u8   x49;                           /* +0x49 параметр txss_set_sweep_param */
    u8   _4a[2];
};
_Static_assert(sizeof(struct ss_cfg_s) == 0x4c, "ss_cfg");
LMAC_OFF(struct ss_cfg_s, n_frames, 0x48);

/* Параметры MAC из LMAC 0x00 (+0, 0x30 Б): копия в mac_cfg (0x802588) → mac_program_886e0c_20b. */
struct lmac_mac_regs {
    union {
        u8   b[0x14];                   /* 0x00 байты → MAC 0x886e08..0x886e18 (перестановка) */
        struct {
            u8   b0[0xc];               /* 0x00 fw: memcpy 0xc Б из cfg */
            u32  w0c;                   /* 0x0c fw пишет словом (cfg +0xc) */
            u32  w10;                   /* 0x10 fw пишет словом (cfg +0x10) */
        };
    };
    u32  w14[6];                        /* 0x14 fw: cfg +0x14..+0x20 → +0x1c..+0x28; +0x14/+0x18 не пишет */
    u32  qset_mode;                     /* 0x2c б0..б3 → маска qset (mac_build_qset_mask), б1 →
                                           mac_replicate_bit_mask; fw: [0,4) = 8 */
};
LMAC_OFF(struct lmac_mac_regs, qset_mode, 0x2c);
_Static_assert(sizeof(struct lmac_mac_regs) == 0x30, "lmac_mac_regs");

/* LMAC 0x00 — конфигурация MAC (lmac_if_send_cmd_0x00 → ucode_cmd_0x00_handler), 0x44 Б. */
struct lmac_cmd_mac_cfg {
    struct lmac_mac_regs regs;          /* 0x00 → mac_cfg (ucode_cmd_apply_mac_cfg) */
    u16  ifs_us[6];                     /* 0x30 → ifs_cfg_us (txrx_api_step_b_uc): SIFS, …, slot, … */
    u16  x3c;                           /* 0x3c fw: 4; ucode не читает */
    u16  x3e;                           /* 0x3e fw: 2; ucode не читает */
    u32  rf_chain;                      /* 0x40 байт rf_obj.rf_idx → rf_chain_cfg */
};
LMAC_OFF(struct lmac_cmd_mac_cfg, ifs_us, 0x30);
LMAC_OFF(struct lmac_cmd_mac_cfg, rf_chain, 0x40);
_Static_assert(sizeof(struct lmac_cmd_mac_cfg) == 0x44, "lmac_cmd_mac_cfg");

/* Источник конфигурации MAC для LMAC 0x00 (lmac_if_send_init_cfg, 0x24 Б на стеке fw →
 * lmac_if_send_cmd_0x00): байты 0..0xb, слова 0xc/0x10 → regs.w0c/w10, w[0..3] → regs.w14[2..5]. */
struct lmac_mac_cfg_src {
    union {
        u8   head[0x14];                /* 0x00 */
        struct {
            u8   b0[0xc];               /* 0x00 */
            u32  w0c;                   /* 0x0c */
            u32  w10;                   /* 0x10 */
        };
    };
    u32  w[4];                          /* 0x14 */
};
_Static_assert(sizeof(struct lmac_mac_cfg_src) == 0x24, "lmac_mac_cfg_src");

/* LMAC 0x01 — включить RX на канале (lmac_if_build_rx_on_cmd → ucode_cmd_0x01_handler,
 * txrx_api_cmd_step), 0x28 Б. */
struct lmac_cmd_rx_on {
    u32  start_lo;                      /* 0x00 TSF64 начала BI (млад.) */
    u32  start_hi;                      /* 0x04 (стар.) */
    u8   rsv08[8];
    u32  flags;                         /* 0x10 б0 — задать BI (bi_len_us, TSF начала) */
    u8   rsv14[4];
    u32  bi_len_us;                     /* 0x18 длина BI, мкс (fw: TU << 10) */
    u32  role_bits;                     /* 0x1c б0, б1 — роль STA (fw пишет оба), б2 — 0 */
    u32  rx_mode;                       /* 0x20 0 — omni RX, 1 — RX с цепями (fw: 1) */
    u8   rf_mask;                       /* 0x24 маска RF-модулей → rf_modules.cur */
    u8   omni_rf_mask;                  /* 0x25 → rf_modules.cur_mask (если +0x26 ≠ 0) */
    u8   rf_sets_mask;                  /* 0x26 rf_mask при sets_mode 3, иначе 0 → rf_modules.x4 */
    u8   rsv27;
};
LMAC_OFF(struct lmac_cmd_rx_on, flags, 0x10);
LMAC_OFF(struct lmac_cmd_rx_on, bi_len_us, 0x18);
LMAC_OFF(struct lmac_cmd_rx_on, rx_mode, 0x20);
LMAC_OFF(struct lmac_cmd_rx_on, rf_sets_mask, 0x26);
_Static_assert(sizeof(struct lmac_cmd_rx_on) == 0x28, "lmac_cmd_rx_on");

/* LMAC 0x05 — конфигурация станции (lmac_if_send_sta_cfg_05 → ucode_cmd_0x05_handler), 0x28 Б.
 * Сектор/цепь: байт — RF-модуль (rf_obj.rf_idx), полуслово — сектор. */
struct lmac_cmd_sta_cfg {
    u8   tx_rf;                         /* 0x00 → sta_entry.tx_sel [0,4) */
    u8   rsv01;
    u16  tx_sector;                     /* 0x02 → tx_sel [8,23) */
    u8   rx_rf;                         /* 0x04 → rx_sel [0,4) */
    u8   rsv05;
    u16  rx_sector;                     /* 0x06 → rx_sel [8,23); 0xff — 0x60 + cid */
    u8   omni_rf;                       /* 0x08 → omni_rx_sel [0,4) */
    u8   rsv09;
    u16  omni_sector;                   /* 0x0a → omni_rx_sel; 0xffff — нет (AP/PCP) */
    u8   cid;                           /* 0x0c */
    u8   rsv0d;
    u16  cfg_10;                        /* 0x0e → sta_entry.cfg_10 (fw: 0) */
    u32  op;                            /* 0x10 0 — включить, 1 — выключить, 2 — обновить секторы */
    u32  cfg_28;                        /* 0x14 → sta_entry.cfg_28 */
    u8   rsv18[4];
    union {                             /* 0x1c MAC станции: ucode читает полусловами, */
        u16  peer_mac[3];               /*      fw пишет словом + полусловом */
        struct {
            u32  peer_lo;               /* 0x1c */
            u16  peer_hi;               /* 0x20 */
            u8   rsv22[2];
        };
    };
    u8   fixed_link;                    /* 0x24 l2_oob_r1_mode */
    u8   fixed_mcs;                     /* 0x25 OOB-параметры */
    u8   fixed_sector;                  /* 0x26 */
    u8   rsv27;
};
LMAC_OFF(struct lmac_cmd_sta_cfg, omni_sector, 0x0a);
LMAC_OFF(struct lmac_cmd_sta_cfg, op, 0x10);
LMAC_OFF(struct lmac_cmd_sta_cfg, peer_mac, 0x1c);
LMAC_OFF(struct lmac_cmd_sta_cfg, fixed_link, 0x24);
_Static_assert(sizeof(struct lmac_cmd_sta_cfg) == 0x28, "lmac_cmd_sta_cfg");

/* LMAC 0x07 — диапазоны qid наборов очередей (lmac_if_send_qset_ranges →
 * ucode_cmd_0x07_handler), 0x10 Б. Диапазон — байты {lo, hi} (по 5 бит). */
struct lmac_cmd_qset_ranges {
    u8   rsv00[4];
    u32  range_q4_q5;                   /* 0x04 подкод 1: [0..4]/[8..12] qset4, [16..20]/[24..28] qset5 */
    u32  range_q6;                      /* 0x08 подкод 2: [0..4]/[8..12] qset6 */
    u32  sub;                           /* 0x0c подкод 1/2 (0 — только сброс масок) */
};
LMAC_OFF(struct lmac_cmd_qset_ranges, sub, 0x0c);
_Static_assert(sizeof(struct lmac_cmd_qset_ranges) == 0x10, "lmac_cmd_qset_ranges");

/* LMAC 0x08 — конфигурация vring/очереди (lmac_if_send_cmd_0x08 → ucode_cmd_0x08_handler), 0x14 Б. */
struct lmac_cmd_vring_cfg {
    u8   qid;                           /* 0x00 vring (qid MAC) */
    u8   cid;                           /* 0x01 станция (pring) */
    u8   rsv02[2];
    u32  qset;                          /* 0x04 0/1 — qset 4, 3 — qset 6 */
    u32  op;                            /* 0x08 0 — добавить, 1 — снять, 3/4 — PPDU в очередь */
    u32  qflags;                        /* 0x0c б5 — null_status, б6 — код управляющего кадра */
    union {                             /* 0x10 fw обнуляет байт, затем |= словом */
        u32  flags;                     /* б1 — отправить PPDU перед снятием */
        u8   flags_b0;
    };
};
LMAC_OFF(struct lmac_cmd_vring_cfg, qset, 0x04);
LMAC_OFF(struct lmac_cmd_vring_cfg, qflags, 0x0c);
_Static_assert(sizeof(struct lmac_cmd_vring_cfg) == 0x14, "lmac_cmd_vring_cfg");

/* LMAC 0x09 — запуск BF к станции (lmac_if_trigger_bf → ucode_cmd_trigger_bf), 0xc Б. */
struct lmac_cmd_trigger_bf {
    u32  kind;                          /* 0x00 fw: 1 */
    u32  arg;                           /* 0x04 */
    u32  cid;                           /* 0x08 */
};
_Static_assert(sizeof(struct lmac_cmd_trigger_bf) == 0xc, "lmac_cmd_trigger_bf");

/* Параметры BI маяка (+0x50 тела LMAC 0x0b, 0x20 Б) → копия ucode bi_cfg (0x8022a8, struct
 * fui_bi_cfg_params в uc/dccm.h — там те же смещения). Пишут bcn_tx_init_bi_cfg и
 * lmac_if_send_bcon_mgt (fw/pcp_ext.c), tx_bcon_del_bcon (fw/discovery.c). */
struct lmac_bi_params {
    u32  bi_mode;                       /* 0x00 a1 lmac_if_send_bcon_mgt; 0 — снять маяк */
    u8   n_bi_abft;                     /* 0x04 s[3] >> 5 */
    u8   abft_cnt_mod;                  /* 0x05 (u16 s[4..5] >> 6) & 0x3f */
    u8   rsv06;
    u8   fss;                           /* 0x07 (s[1] >> 2) & 0xf */
    u8   x8;                            /* 0x08 fw: 0 */
    u8   x9;                            /* 0x09 (u16 s[2..3] >> 6) & 0x7f */
    u8   abft_len;                      /* 0x0a (u16 s[0..1] >> 7) & 7 */
    u8   mac[6];                        /* 0x0b MAC (если задан) */
    u8   rsv11[3];
    u32  flags;                         /* 0x14 б0 CC present, б1 discovery, б2, б3 */
    u8   rsv18[8];
};
LMAC_OFF(struct lmac_bi_params, mac, 0x0b);
LMAC_OFF(struct lmac_bi_params, flags, 0x14);
_Static_assert(sizeof(struct lmac_bi_params) == 0x20, "lmac_bi_params");

/* LMAC 0x0b — развёртка маяка и BI (ucode_cmd_0x0b_handler), 0x70 Б. */
struct lmac_cmd_bcn_sweep {
    u32  op;                            /* 0x00 0/1/2 */
    struct ss_cfg_s ss;                 /* 0x04 → bti_sw.bcn_ss (ucode_cmd_0b_apply) */
    struct lmac_bi_params bi;           /* 0x50 → bi_cfg (0x20 Б) */
};
LMAC_OFF(struct lmac_cmd_bcn_sweep, ss, 0x04);
LMAC_OFF(struct lmac_cmd_bcn_sweep, bi, 0x50);
_Static_assert(sizeof(struct lmac_cmd_bcn_sweep) == 0x70, "lmac_cmd_bcn_sweep");

/* LMAC 0x0c — развёртка секторов станции (ucode_cmd_0x0c_handler), 0x50 Б. */
struct lmac_cmd_sta_sweep {
    u8   sta;                           /* 0x00 индекс txss_ss (< 9) */
    u8   rsv01[3];
    struct ss_cfg_s ss;                 /* 0x04 → txss_ss[sta] (ucode_cmd_0b_apply) */
};
LMAC_OFF(struct lmac_cmd_sta_sweep, ss, 0x04);
_Static_assert(sizeof(struct lmac_cmd_sta_sweep) == 0x50, "lmac_cmd_sta_sweep");

/* LMAC 0x10 — параметры BF (lm_main_sm_config_lmac_bf_sm, wmi_h_bf; шаблон fw 0x8014b0 →
 * ucode_cmd_0x10_handler → bf_ctrl), 0x10 Б. */
struct lmac_cmd_bf_ctrl {
    u32  w0;                            /* 0x00 → bf_ctrl.cmd10_w0 */
    u32  cid;                           /* 0x04 */
    u8   ctrl_code_tx;                  /* 0x08 */
    u8   ctrl_code_rx;                  /* 0x09 */
    u8   ctrl_code_tx_alt;              /* 0x0a */
    u8   ctrl_code_rx_alt;              /* 0x0b */
    u8   stat_shift;                    /* 0x0c bf_ctrl.stat_bit = 1 << (32 − v) */
    u8   txss_mode;                     /* 0x0d */
    u8   brp_mode;                      /* 0x0e */
    u8   rsv0f;
};
LMAC_OFF(struct lmac_cmd_bf_ctrl, ctrl_code_tx, 0x08);
LMAC_OFF(struct lmac_cmd_bf_ctrl, brp_mode, 0x0e);
_Static_assert(sizeof(struct lmac_cmd_bf_ctrl) == 0x10, "lmac_cmd_bf_ctrl");
/* Шаблон LMAC 0x10 в DCCM fw (0x8014b0; wmi_bf_control правит, config_lmac_bf_sm копирует). */
extern struct lmac_cmd_bf_ctrl lmac_bf_ctrl_tpl;

/* LMAC 0x18 — запись поля записи станции sta_tab (lmac_if_install_key, l2_mgr_set_rf_params →
 * ucode_cmd_0x18_handler), 0x20 Б. */
struct lmac_cmd_sta_field {
    u32  sta;                           /* 0x00 */
    u32  mode;                          /* 0x04 0/4 — ключ действителен, 1 — нет, 8 — RF-параметры */
    u32  offset;                        /* 0x08 смещение в sta_entry (0x38 — ключ, 0x4c — peer_n_ant) */
    u32  len;                           /* 0x0c ≤ 16 */
    u8   data[16];                      /* 0x10 */
};
LMAC_OFF(struct lmac_cmd_sta_field, data, 0x10);
_Static_assert(sizeof(struct lmac_cmd_sta_field) == 0x20, "lmac_cmd_sta_field");

/* LMAC 0x19 — RF-цепь хоста (hw_sysapi_rx_alloc_and_store → ucode_cmd_0x19_handler), 4 Б. */
struct lmac_cmd_rf_chain {
    u8   rf;                            /* 0x00 */
    u8   rsv01;
    u16  sector;                        /* 0x02 */
};
_Static_assert(sizeof(struct lmac_cmd_rf_chain) == 4, "lmac_cmd_rf_chain");



/* LMAC 0x35 — порядок секторов (WMI txss_set_sectors_order → wmi_cmd_txss_set_sectors_order,
 * ss_copy_cfg_from_cmd), 0x54 Б. */
struct lmac_cmd_ss_order {
    struct ss_cfg_s ss;                 /* 0x00 */
    u32  target;                        /* 0x4c 0 — набор set, 1 — маяк (bti_sw.bcn_ss), 2 — оба (fw < 3) */
    u8   set;                           /* 0x50 индекс txss_ss (< 9) */
    u8   rsv51[3];
};
LMAC_OFF(struct lmac_cmd_ss_order, target, 0x4c);
LMAC_OFF(struct lmac_cmd_ss_order, set, 0x50);
_Static_assert(sizeof(struct lmac_cmd_ss_order) == 0x54, "lmac_cmd_ss_order");

/* ---- Прочие команды fw → uc (тела по записям отправителей fw и чтениям uc/cmd.c) ---- */

/* LMAC 0x02 — эхо (wmi_deep_echo → ucode_cmd_echo: значение возвращается событием 0x02),
 * 4 Б. Тело события 0x02 — тот же формат. */
struct lmac_cmd_echo {
    u32  value;                         /* 0x00 */
};
_Static_assert(sizeof(struct lmac_cmd_echo) == 4, "lmac_cmd_echo");

/* LMAC 0x03 — выключить RX (radio_mgr lmac_if_send_cmd_0x03 → ucode_cmd_0x03_handler), 4 Б. */
struct lmac_cmd_rx_off {
    u32  mode;                          /* 0x00 0 — mac_rx_off_seq, 1 — uc_pm_enter_idle (fw: 1) */
};
_Static_assert(sizeof(struct lmac_cmd_rx_off) == 4, "lmac_cmd_rx_off");

/* Запись AC в LMAC 0x04 (0xc Б; txrx_api_step_c). */
struct lmac_edca_ac {
    u32  ac;                            /* 0x00 индекс AC (< 4) */
    u16  ecw_min;                       /* 0x04 CW = (1 << v) − 1 */
    u16  ecw_max;                       /* 0x06 */
    u16  aifsn;                         /* 0x08 → 0x886d68 [31:28] (fw: 3) */
    u8   rsv0a[2];
};
_Static_assert(sizeof(struct lmac_edca_ac) == 0xc, "lmac_edca_ac");

/* LMAC 0x04 — таблица EDCA (lmac_if_send_cmd_0x04 → ucode_cmd_0x04_handler_uc), 0x30 Б. */
struct lmac_cmd_edca {
    struct lmac_edca_ac ac[4];          /* 0x00 */
};
_Static_assert(sizeof(struct lmac_cmd_edca) == 0x30, "lmac_cmd_edca");

/* LMAC 0x0f — станция на поддержании (lmac_if_send_cmd_0x0f → ucode_cmd_0x0f_handler), 8 Б. */
struct lmac_cmd_maint_sta {
    u32  cid;                           /* 0x00 бит в maint_sta_mask */
    u16  on;                            /* 0x04 ≠ 0 — поставить, 0 — снять */
    u8   rsv06[2];
};
LMAC_OFF(struct lmac_cmd_maint_sta, on, 0x04);
_Static_assert(sizeof(struct lmac_cmd_maint_sta) == 8, "lmac_cmd_maint_sta");

/* LMAC 0x11 — таблицы AGC (silent_rssi_report_agc_tables → ucode_cmd_0x11_handler, копия в
 * agc_cfg 0x8025dc), 0x20 Б. Пары {старт, таблица} — agc_get_table_pair(eng, 1/0, …). */
struct lmac_cmd_agc_tables {
    u32  start[2];                      /* 0x00 [0] — пара 1, [1] — пара 0 */
    u32  table[2];                      /* 0x08 */
    u8   param4[8];                     /* 0x10 silent_rssi_agc_param_const_4 по RF-модулям */
    u8   param2[8];                     /* 0x18 silent_rssi_agc_param_const_2 */
};
LMAC_OFF(struct lmac_cmd_agc_tables, param4, 0x10);
_Static_assert(sizeof(struct lmac_cmd_agc_tables) == 0x20, "lmac_cmd_agc_tables");

/* LMAC 0x12 — перезапуск RS станции (field_set_0x00_8dbc94 → ucode_cmd_0x12_handler_uc), 1 Б.
 * LMAC 0x49 (wmi_set_grant_mcs → ctrl_frame_mcs) — тоже один байт. */
struct lmac_cmd_u8 {
    u8   val;                           /* 0x00 */
};

/* LMAC 0x13 — параметры RS станции (lmac_if_send_cmd_0x13 → ucode_cmd_0x13_handler), 0x28 Б. */
struct lmac_cmd_rs_cfg {
    u8   cid;                           /* 0x00 */
    u8   enable;                        /* 0x01 ≠ 0 — включить RS (копия cfg → rs_cfg[cid]) */
    u8   cfg[0x26];                     /* 0x02 struct rs_sta_cfg ucode */
};
LMAC_OFF(struct lmac_cmd_rs_cfg, cfg, 0x02);
_Static_assert(sizeof(struct lmac_cmd_rs_cfg) == 0x28, "lmac_cmd_rs_cfg");

/* LMAC 0x14 — триггеры BF (lmac_if_send_cmd_0x14, wmi_bf_control → bf_ctrl.triggers), 4 Б. */
struct lmac_cmd_bf_triggers {
    u32  triggers;                      /* 0x00 биты 0..5 */
};
_Static_assert(sizeof(struct lmac_cmd_bf_triggers) == 4, "lmac_cmd_bf_triggers");

/* LMAC 0x15 — параметры RS/BF (lmac_if_send_cmd_0x15 → lmac_personality, bf_failure_policy), 8 Б. */
struct lmac_cmd_rs_params {
    u32  personality;                   /* 0x00 */
    u32  failure_policy;                /* 0x04 */
};
_Static_assert(sizeof(struct lmac_cmd_rs_params) == 8, "lmac_cmd_rs_params");

/* LMAC 0x16 — калибровка (lmac_if_send_cmd_0x16_calib_b4 → calib_gain_ofs, 4 Б копии). */
struct lmac_cmd_calib_gain {
    u8   target;                        /* 0x00 calib_silent_rssi.target */
    u8   rsv01[3];
};
_Static_assert(sizeof(struct lmac_cmd_calib_gain) == 4, "lmac_cmd_calib_gain");

/* LMAC 0x1b — роль (conn_alloc_and_link → ucode_cmd_0x1b_handler), 3 Б. */
struct lmac_cmd_role {
    u8   mode;                          /* 0x00 bss.mode записи mid (2/3 — AP/PCP) → uc_role */
    u8   pm_cfg;                        /* 0x01 → pm_cfg_flag */
    u8   rsv02;
};

/* LMAC 0x1e — избирательный сосед (lmac_if_send_selective_neighbor_cfg →
 * ucode_cmd_selective_neighbor_cfg), 8 Б. */
struct lmac_cmd_sel_nbr {
    u8   cap_en;                        /* 0x00 1 — sel_nbr.cap = cap_default */
    u8   threshold;                     /* 0x01 (0x2d — по умолчанию) */
    u8   b_en;                          /* 0x02 */
    u8   b_val;                         /* 0x03 → sel_nbr.cfg_b (0x2d) */
    u8   short_txop;                    /* 0x04 → short_txop_en */
    u8   rs_param;                      /* 0x05 */
    u8   rsv06[2];
};
_Static_assert(sizeof(struct lmac_cmd_sel_nbr) == 8, "lmac_cmd_sel_nbr");

/* LMAC 0x20 — конфигурация PHY INA-детектора (lmac_if_send_phy_ina_det_cfg из 0x800bdc →
 * cmd20_cfg), 0x24 Б. */
struct lmac_cmd_ina_det {
    u8   cfg[0x20];                     /* 0x00 */
    u32  flags;                         /* 0x20 б0, б1 — в журнал */
};
LMAC_OFF(struct lmac_cmd_ina_det, flags, 0x20);
_Static_assert(sizeof(struct lmac_cmd_ina_det) == 0x24, "lmac_cmd_ina_det");
extern const struct lmac_cmd_ina_det phy_ina_det_cfg;   /* 0x800bdc (fw/lmac.c) */

/* LMAC 0x21 — лимиты TXOP (lmac_if_send_txop_limits → txop_limit_us), 8 Б. */
struct lmac_cmd_txop_limits {
    u16  limit_us[4];                   /* 0x00 по AC */
};
_Static_assert(sizeof(struct lmac_cmd_txop_limits) == 8, "lmac_cmd_txop_limits");


/* LMAC 0x23 — параметры A-BFT-ответчика (lmac_if_send_cmd_0x23 →
 * ucode_cmd_load_table_803124_803128 → abft_cfg 0x803124), 0xc Б. */
struct lmac_cmd_bi_tbl {
    u32  responder_mode;                /* 0x00 → abft_cfg.responder_mode; OOB: 2, иначе (a ≠ 0) << 1 */
    u32  beacon_type;                   /* 0x04 → abft_cfg.beacon_type; OOB: 2, иначе 1 + (a == 0) */
    union {                             /* 0x08 → abft_cfg.relax_period */
        u16  relax_period;              /*      fw пишет полуслово: 1 */
        u32  relax_word;                /*      ucode читает словом: [31:16] — что было в буфере пула */
    };
};
LMAC_OFF(struct lmac_cmd_bi_tbl, relax_word, 0x08);
_Static_assert(sizeof(struct lmac_cmd_bi_tbl) == 0xc, "lmac_cmd_bi_tbl");

/* LMAC 0x24 — режим discovery (lmac_if_discovery_mode_cfg → ucode_cmd_0x24_handler), 8 Б. */
struct lmac_cmd_discovery {
    u32  mode;                          /* 0x00 1 — вкл, 0 — выкл */
    u32  type;                          /* 0x04 → discovery_type (байт) */
};
_Static_assert(sizeof(struct lmac_cmd_discovery) == 8, "lmac_cmd_discovery");




/* LMAC 0x30 — фиксированный MCS станции для RS (lmac_if_send_cmd_0x30 → ucode_cmd_0x30_handler_uc),
 * 3 Б. LMAC 0x32 (wmi_brp_alloc_and_store → ucode_cmd_0x32_handler: brp_rf_cfg.sta_sel) — тот же
 * вид {станция, режим, значение}. */
struct lmac_cmd_sta_byte2 {
    u8   cid;                           /* 0x00 */
    u8   mode;                          /* 0x01 0x30: б0 → rs_sta_flags б7; 0x32: 2 бита */
    u8   val;                           /* 0x02 0x30: MCS (7 бит); 0x32: лимит (6 бит) */
};



/* LMAC 0x39/0x3a — прочитать/задать выбранный RF-сектор станции
 * (lmac_if_send_get/set_selected_rf_sector_index: копия 4 Б запроса WMI →
 * get/set_selected_rf_sector_index_cmd_handler), 4 Б. */
struct lmac_cmd_rf_sector_sel {
    u8   cid;                           /* 0x00 станция (sta_tab) */
    u8   sub;                           /* 0x01 1 — TX-сектор, 0 — RX-сектор, иначе ассерт */
    u16  sector;                        /* 0x02 только 0x3a: сектор; 0xffff — снять принуждение */
};
LMAC_OFF(struct lmac_cmd_rf_sector_sel, sector, 0x02);
_Static_assert(sizeof(struct lmac_cmd_rf_sector_sel) == 4, "lmac_cmd_rf_sector_sel");

/* LMAC 0x36 — число секторов развёртки (ss_sectors_number, копия тела WMI →
 * wmi_cmd_txss_set_sectors_number), 3 Б. */
struct lmac_cmd_ss_number {
    u8   x0;                            /* 0x00 ≤ 0x40 */
    u8   n_frames;                      /* 0x01 ≤ 0x40; 0 — без изменений */
    u8   set;                           /* 0x02 индекс txss_ss (< 9) */
};

/* LMAC 0x42 — триггеры PMC (sched_alloc_entry → txrx_umac_if_config_pmc_triggers_handler) и
 * команды измерений RX (channel_est_stack_args, 0x28/0x2a/…: фильтр + число отсчётов),
 * 0xc Б. Байты 5..7 fw не пишет. */
struct lmac_cmd_meas_filter {
    u8   cid;                           /* 0x00 */
    u8   mode;                          /* 0x01 */
    u8   no_mcs;                        /* 0x02 */
    u8   mcs;                           /* 0x03 */
    u8   rx_mode;                       /* 0x04 */
    u8   rsv05[3];
    u32  count;                         /* 0x08 0x28: число отсчётов; 0x42: TSF */
};
LMAC_OFF(struct lmac_cmd_meas_filter, count, 0x08);
_Static_assert(sizeof(struct lmac_cmd_meas_filter) == 0xc, "lmac_cmd_meas_filter");

/* LMAC 0x45 — запись QH станции (conn_alloc_and_fill → fwif_write_qh), 0x74 Б. */
struct lmac_cmd_write_qh {
    u8   q;                             /* 0x00 */
    u8   flags;                         /* 0x01 */
    u16  n;                             /* 0x02 */
    u8   desc[0x70];                    /* 0x04 */
};
LMAC_OFF(struct lmac_cmd_write_qh, desc, 0x04);
_Static_assert(sizeof(struct lmac_cmd_write_qh) == 0x74, "lmac_cmd_write_qh");

/* LMAC 0x47 — бит станции в fsched_peers (lmac_if_send_cmd_0x47 → ucode_cmd_0x47_handler), 2 Б. */
struct lmac_cmd_fsched_peer {
    u8   vr;                            /* 0x00 */
    u8   on;                            /* 0x01 */
};

/* Однословные команды: 0x3b (brp_snr_cfg_enable), 0x4a (l1_time_thresh >> 4), field_set_0x00_8dbe88
 * (тип задаёт вызывающий); 0x3e, 0x41, 0x48 — тело ucode не читает. */
struct lmac_cmd_u32 {
    u32  val;                           /* 0x00 */
};
_Static_assert(sizeof(struct lmac_cmd_u32) == 4, "lmac_cmd_u32");

/* ---- События uc → fw ---- */

/* Отчёт BF: события bf_done / new_link (uc_send_evt_bf_done/new_link, 17 слов по значению —
 * uc/evt17.h; строят notify_aoa_build, uc_evt_build_and_post_report; разбирают
 * lmac_if_bf_done_evt / lmac_if_abft_notify_evt), 0x44 Б. */
struct lmac_evt_bf_done {
    u32  snr;                           /* 0x00 SNR связи (bf_rep.link_snr / brp_rf.snr) */
    u8   cid;                           /* 0x04 станция; 8 — новая связь (new_link) */
    u8   rx_sector;                     /* 0x05 bf_res.rx_sector (A-BFT: 0xff) */
    u8   tx_sector_b1;                  /* 0x06 рейтинг fw b1 [cid][0] (A-BFT: сектор SSW-Feedback) */
    u8   rsv07;
    u8   tx_sector;                     /* 0x08 рейтинг fw [cid][0] */
    u8   ssw_rx_cnt;                    /* 0x09 bf_rep.ssw_rx_cnt */
    u16  rf_sector;                     /* 0x0a rf_chain_word [22:8] → conn->rx_sector */
    u8   peer_snr;                      /* 0x0c bf_rep.peer_snr → conn->bf_byte */
    u8   rsv0d[3];
    s32  own_snr;                       /* 0x10 bf_rep.own_snr */
    u32  sect_seen[2][2];               /* 0x14 bf_rep.sect_seen */
    u32  brp_snr;                       /* 0x24 brp_rf.snr (A-BFT: 0xff) */
    u32  brp_selected;                  /* 0x28 brp_pick.selected (A-BFT: 0xff) */
    u32  status;                        /* 0x2c 1 — BF_DONE_OK */
    u32  type;                          /* 0x30 0/1 — станция на поддержании (maint), 2 — A-BFT */
    union {
        u16  peer_mac[3];               /* 0x34 */
        struct {
            u32  peer_lo;               /* 0x34 fw (scan_mngr_handle_abft_bf_result_in_scan) читает словом */
            u16  peer_hi;               /* 0x38 */
            u8   diag_lo;               /* 0x3a bf_res.diag_last [3:0] (A-BFT: 3/4) */
            u8   diag_hi;               /* 0x3b bf_res.diag_last [9:4] */
        };
    };
    u32  fail_reasons;                  /* 0x3c link_stat.bf_reasons */
    u32  tsf;                           /* 0x40 TSF (мл.) */
};
LMAC_OFF(struct lmac_evt_bf_done, rf_sector, 0x0a);
LMAC_OFF(struct lmac_evt_bf_done, own_snr, 0x10);
LMAC_OFF(struct lmac_evt_bf_done, status, 0x2c);
LMAC_OFF(struct lmac_evt_bf_done, peer_mac, 0x34);
LMAC_OFF(struct lmac_evt_bf_done, fail_reasons, 0x3c);
_Static_assert(sizeof(struct lmac_evt_bf_done) == 0x44, "lmac_evt_bf_done");

/* LMAC 0x09 — потеря связи (uc_send_evt_link_lost ← l1_task_report_link_lost →
 * lmac_if_link_lost_evt_handler), 0xc Б. */
struct lmac_evt_link_lost {
    u32  cid;                           /* 0x00 8 — широковещательная (нет станций) */
    u32  agc_start;                     /* 0x04 agc_cfg.agc_start */
    u32  confirmed;                     /* 0x08 1 — потеря подтверждена */
};
_Static_assert(sizeof(struct lmac_evt_link_lost) == 0xc, "lmac_evt_link_lost");

/* События с одним словом по +0: 0x04 FLUSH_Q_DONE (vring), 0x13 RS_STARTED (cid), 0x20 (код). */
struct lmac_evt_u32 {
    u32  val;                           /* 0x00 */
};

/* LMAC 0x08 QUEUE_DELETED (ucode_cmd_0x08_handler, 0xc Б): MAC-очередь в байте +0
 * (ucode пишет словом, fw читает байт). */
struct lmac_evt_queue_deleted {
    union {
        u32  q_word;                    /* 0x00 ucode: qid */
        u8   q;                         /* 0x00 fw: stream_mgr_macq_removed */
    };
    u32  tsf;                           /* 0x04 TSF (мл.); fw не читает */
    u32  rsv08;                         /* 0x08 0 */
};
_Static_assert(sizeof(struct lmac_evt_queue_deleted) == 0xc, "lmac_evt_queue_deleted");

/* LMAC 0x11 — ответ на запись поля sta_tab (uc_send_evt_sta_update_field_rsp → return_field_type), 8 Б. */
struct lmac_evt_field_rsp {
    u32  cid;                           /* 0x00 */
    u32  type;                          /* 0x04 режим команды 0x18 (0/1/4/8/0x10) */
};
_Static_assert(sizeof(struct lmac_evt_field_rsp) == 8, "lmac_evt_field_rsp");

/* Итог RS (+0x20 события 0x14, 0x10 Б). */
struct lmac_rs_result {
    u32  tx_total;                      /* 0x00 */
    u32  fail_total;                    /* 0x04 */
    u32  status;                        /* 0x08 0 — успех */
    u8   cid;                           /* 0x0c */
    u8   mcs;                           /* 0x0d итоговый MCS */
    u8   rsv0e[2];
};
_Static_assert(sizeof(struct lmac_rs_result) == 0x10, "lmac_rs_result");

/* LMAC 0x14 — RS_DONE (uc_send_evt_rs_done → lmac_if_rs_done_evt), 0x30 Б. Поля +0x1a/+0x1c
 * перед обработчиком заполняет dispatch fw (TSF). */
struct lmac_evt_rs_done {
    u8   tx_cnt[13];                    /* 0x00 MPDU по MCS */
    u8   fail_cnt[13];                  /* 0x0d */
    u16  tsf_lo;                        /* 0x1a fw: TSF [15:0] */
    u16  tsf_hi;                        /* 0x1c fw: TSF [31:16] */
    u8   mcs_final;                     /* 0x1e */
    u8   rsv1f;
    struct lmac_rs_result res;          /* 0x20 */
};
LMAC_OFF(struct lmac_evt_rs_done, tsf_lo, 0x1a);
LMAC_OFF(struct lmac_evt_rs_done, res, 0x20);
_Static_assert(sizeof(struct lmac_evt_rs_done) == 0x30, "lmac_evt_rs_done");


/* LMAC 0x16 — ps_awake_peer (uc_send_evt_ps_awake_peer; ucode struct ps_evt_body), 0xc Б. */
struct lmac_evt_ps_peer {
    u8   arg;                           /* 0x00 */
    u8   doze_bi;                       /* 0x01 всегда 0 (BI сна по расписанию — PS вырезан) */
    u8   awake;                         /* 0x02 бодрствующие пиры */
    u8   no_tx;                         /* 0x03 → ps_lmac_evt_cid_mask */
    u8   doze_info;                     /* 0x04 всегда 0 (upm_vector / in_doze — PS вырезан) */
    u8   rsv05[3];
    u32  type;                          /* 0x08 5 — mid_lookup_step */
};
LMAC_OFF(struct lmac_evt_ps_peer, type, 0x08);
_Static_assert(sizeof(struct lmac_evt_ps_peer) == 0xc, "lmac_evt_ps_peer");

/* LMAC 0x30 EVT_FIXED_SCHEDULING_ENABLED — {TSF/слово, значение}, 8 Б (у vendor так же 0x18
 * PS_TRAFFIC_DEFERRAL_CFG — отсрочка трафика вырезана). */
struct lmac_evt_typed {
    u32  w0;                            /* 0x00 TSF (мл.) у uc_send_evt_typed */
    u32  val;                           /* 0x04 */
};
_Static_assert(sizeof(struct lmac_evt_typed) == 8, "lmac_evt_typed");

/* LMAC 0x21 — {байт, 0x20 Б} (uc_evt_send_21), 0x24 Б. LMAC 0x23 (uc_evt_send_23, 0x24 Б) —
 * id запроса в байте +0x23. */
struct lmac_evt_sysapi {
    u8   id;                            /* 0x00 (0x21) */
    u8   rsv01[3];
    u8   data[0x1f];                    /* 0x04 */
    u8   id23;                          /* 0x23 (0x23) */
};
LMAC_OFF(struct lmac_evt_sysapi, id23, 0x23);
_Static_assert(sizeof(struct lmac_evt_sysapi) == 0x24, "lmac_evt_sysapi");



/* LMAC 0x2e — таймаут BA (uc_evt_send_2e → ba_on_uc_timeout_evt), 4 Б. */
struct lmac_evt_ba_timeout {
    u8   vr;                            /* 0x00 */
    u8   kind;                          /* 0x01 0 — обновить SSN */
    u16  ssn;                           /* 0x02 */
};
_Static_assert(sizeof(struct lmac_evt_ba_timeout) == 4, "lmac_evt_ba_timeout");

/* Байты общей памяти fwsh_n_rx_ant / fwsh_total_sectors / fwsh_long_range — include/fwsh.h. */

#endif
