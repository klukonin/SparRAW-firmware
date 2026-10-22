// SPDX-License-Identifier: AGPL-3.0-or-later
/* Карта DCCM uc: типы и имена глобалов (рантайм-адреса 0x800000..).
 *
 * Имя — макрос на фиксированный адрес: (*(u32 *)0x8004cc). Так сгенерированный код тот же,
 * что с числовым адресом (с extern-символами GCC теряет общую базу и короткие смещения —
 * код растёт, в т.ч. в путях с таймингом без запаса). Начальные значения — объекты с теми
 * же именами в uc/data.c (там макросы выключены: UC_DCCM_OBJECTS); совпадение адресов
 * проверяет tools/check_dccm.py после компоновки. */
#ifndef UC_DCCM_H
#define UC_DCCM_H
#include "../include/types.h"
/* Общая память с fw (0x85xxxx): типы и имена — include/fwsh.h; в uc — макросы на адрес
 * (FWSH_UC — до первого включения fwsh.h, в т. ч. через lmac_cmd.h). */
#define FWSH_UC 1
#include "../include/fwsh.h"
#include "../include/lmac_cmd.h"
#include "../include/ieee80211.h"

/* Защита рабочей памяти fw от записи ucode (ucode_cmd_0x41_handler → arc_protect_addr_uc):
 * action point на адрес 0x848000 с маской 0x7fff — 0x848000..0x84ffff (кадры TX tx_pkt_mem,
 * буферы RX fw). */
#define UC_WPROT_FW_SRAM       0x848000u
#define UC_WPROT_FW_SRAM_MASK  0x7fffu

/* Запись автомата: действие и следующее состояние. */
struct __attribute__((packed)) bi_sm_entry {
    u32 action;
    u8 next;
};

/* Дескриптор автомата (basic_sm_bind_descriptor_uc, uc_sm_handle_event). */
struct sm_desc {
    u8 n_events;
    u8 n_states;
    u8 init_state;
    u8 pad;
    u32 table;                          /* struct bi_sm_entry[n_events × n_states] */
    u32 state_names;                    /* u32[n_states] — указатели на строки */
    u32 event_names;                    /* u32[n_events] */
    u32 name;
};

/* Экземпляр автомата: состояние и дескриптор (basic_sm_bind_descriptor_uc, uc_sm_handle_event). */
struct sm_obj {
    u8   state;                         /* +0 текущее состояние */
    u8   x1;                            /* +1 не используется */
    u8   prev;                          /* +2 0xff при привязке */
    u8   active;                        /* +3 1 — obj_vt801adc_ctor */
    const struct sm_desc *desc;         /* +4 */
};

/* Дескриптор BF-запроса (bf_req_enqueue): done_cb вызывается по завершении. */
struct bf_req_desc {
    u32 done_cb;
    u32 cb2;
    u32 x8;
    u32 xc;
    u32 x10;
    u32 x14;
    u32 x18;
};

/* DMG-кадр управления (расширение 0x6: Grant 0x464, 0x764 — rx_send_dmg_cts) для direct TX,
 * 0x18 Б на стеке (frame_hdr_init, direct_tx_init_rx_desc → direct_tx_send_from_desc):
 * FC/Duration — в r33/команду MAC, RA/TA MAC подставляет сам, с +0x10 — тело в TX FIFO. */
struct dtx_ctrl_frame {
    u16  fc;                            /* 0x00 Frame Control */
    u16  duration;                      /* 0x02 → команда MAC (direct_tx_send_from_desc) */
    u8   ra_ta[12];                     /* 0x04 не заполняются */
    u32  alloc;                         /* 0x10 Dynamic Allocation Info: [4,7) тип, [7,15) src AID,
                                           [15,23) dst AID, [23,32) длительность [8:0] */
    union {                             /* 0x14 слово (bf_set32) и байты */
        u32  w14;                       /* [0,7) длительность [15:9] */
        struct {
            u8   alloc_hi;              /* 0x14 */
            u8   bf_ctl0;               /* 0x15 BF Control: б0 1, б1/б2 — аргументы */
            u8   bf_ctl1;               /* 0x16 */
            u8   bf_ctl2;               /* 0x17 */
        };
    };
};
_Static_assert(__builtin_offsetof(struct dtx_ctrl_frame, alloc) == 0x10, "dtx_ctrl_frame.alloc");
_Static_assert(__builtin_offsetof(struct dtx_ctrl_frame, bf_ctl0) == 0x15, "dtx_ctrl_frame.bf_ctl0");
_Static_assert(sizeof(struct dtx_ctrl_frame) == 0x18, "dtx_ctrl_frame");

/* Кадр SSW-Ack (DMG control ext 0xa), 0x18 Б на стеке: sls_build_ssw_ack → rx_funcs_send_direct_frame
 * (10 Б FC/Dur/RA в FIFO, хвост — uc_fifo_frame_tail). */
struct ssw_ack_frame {
    u16  fc;                            /* 0x00 [2,4) тип 1, [4,8) подтип 6, [8,12) расширение 0xa */
    u16  duration;                      /* 0x02 */
    u16  ra[3];                         /* 0x04 MAC станции */
    u16  ta[3];                         /* 0x0a не заполняется */
    u8   fb_sector;                     /* 0x10 SSW-Feedback: сектор | антенна << 6 */
    u8   fb_snr;                        /* 0x11 (SNR_dB − 19) · 4 */
    u8   fb_b2;                         /* 0x12 */
    u8   brp_req[4];                    /* 0x13 BRP Request: [0] [0,5) = 0x10 у станции на поддержании */
    u8   bf_maint;                      /* 0x17 BF Link Maintenance */
};
_Static_assert(__builtin_offsetof(struct ssw_ack_frame, fb_sector) == 0x10, "ssw_ack_frame.fb_sector");
_Static_assert(sizeof(struct ssw_ack_frame) == 0x18, "ssw_ack_frame");

/* Кадр SSW (DMG control ext 0x8), 0x16 Б без FCS: принятый в rx_buf (mac_mode_program_c — A-BFT)
 * и шаблон ssw_tpl_* (0x802b4c, txss_program_tx_frame). */
struct dmg_ssw_frame {
    u16  fc;                            /* 0x00 */
    u16  duration;                      /* 0x02 */
    union mac_addr ra;                  /* 0x04 */
    union mac_addr ta;                  /* 0x0a MAC передатчика (пира) */
    u8   ssw[3];                        /* 0x10 SSW: б0 Direction, б10..15 Sector ID, б16..17 антенна */
    u8   fb[3];                         /* 0x13 SSW-Feedback: [0] сектор | антенна << 6, [1] SNR report */
};
_Static_assert(__builtin_offsetof(struct dmg_ssw_frame, ta) == 0x0a, "dmg_ssw_frame.ta");
_Static_assert(__builtin_offsetof(struct dmg_ssw_frame, fb) == 0x13, "dmg_ssw_frame.fb");
_Static_assert(sizeof(struct dmg_ssw_frame) == 0x16, "dmg_ssw_frame");

/* Параметры Grant для frame_hdr_init / direct_tx_send_ctrl_frame (fsched_tx_ctrl_frame, 12 Б). */
struct dtx_grant_req {
    u16  alloc_dur;                     /* 0x00 длительность выделения */
    u8   sta;                           /* 0x02 станция (sta_tab) */
    u8   rsv03;
    u32  alloc_type;                    /* 0x04 1 → тип выделения 1, иначе 0 */
    u8   src_aid;                       /* 0x08 */
    u8   dst_aid;                       /* 0x09 */
    u8   rsv0a[2];
};
_Static_assert(__builtin_offsetof(struct dtx_grant_req, src_aid) == 8, "dtx_grant_req.src_aid");
_Static_assert(sizeof(struct dtx_grant_req) == 12, "dtx_grant_req");

/* Параметры автозаполнения RFC (rf_utils_auto_fill_uc, hwd_rfc_auto_fill_verify; «p_fill_info»),
 * 16 Б: шаблон rf_fill_template (0x801820) с байтом RF-маски (rf_utils_auto_fill_with_byte). */
struct rf_fill_info {
    u8   rf_mask;                       /* 0x00 RF-модули (rfca_select_rf_uc) */
    u8   bank;                          /* 0x01 < 2: регистры RFC 0x53c/0x524 + bank·0x20 */
    u8   sec_first;                     /* 0x02 первый сектор */
    u8   sec_last;                      /* 0x03 последний сектор */
    u32  vals;                          /* 0x04 адрес 6 слов значений (0 — без них) */
    u32  verify;                        /* 0x08 ≠ 0 — сверить записанное */
    u8   val_mask;                      /* 0x0c биты значений vals[0..5] для записи/сверки */
    u8   rsv0d[3];
};
_Static_assert(__builtin_offsetof(struct rf_fill_info, val_mask) == 0xc, "rf_fill_info.val_mask");
_Static_assert(sizeof(struct rf_fill_info) == 16, "rf_fill_info");

/* Параметры action point ARC (arc_program_action_point; arc_protect_addr_uc), 0x20 Б:
 * AP_AMV/AP_AMM/AP_AC номера idx = aux 0x220/0x221/0x222 + 3·idx. */
struct arc_ap_cfg {
    u32  idx;                           /* 0x00 номер action point (< 2) */
    u32  amv;                           /* 0x04 → AP_AMV (значение адреса) */
    u32  amm;                           /* 0x08 → AP_AMM (маска) */
    u32  at;                            /* 0x0c AP_AC [3:0] цель (2 — адрес load/store) */
    u32  tt;                            /* 0x10 AP_AC [5:4] тип обращения (1 — запись) */
    u32  mode;                          /* 0x14 AP_AC [6] (0 — внутри диапазона) */
    u32  paired;                        /* 0x18 AP_AC [7] */
    u32  action;                        /* 0x1c AP_AC [8] (1 — исключение) */
};
_Static_assert(sizeof(struct arc_ap_cfg) == 0x20, "arc_ap_cfg");

/* Номера AUX-регистров таймера ARC и рабочее слово. */
struct uc_timer_aux {
    u32 count;
    u32 ctrl;
    u32 limit;
    u32 xc;
};

/* rf_modules (0x8006b4): RF-модули. */
struct __attribute__((packed)) rf_modules_cfg {
    u16 count;                          /* +0 LMAC (cmd.c) */
    u8 cur;                             /* +2 индекс выбранного модуля (rfca_select_rf_uc) */
    u8 mask;                            /* +3 маска всех модулей */
    u8 x4;                              /* +4 */
    u8 cur_mask;                        /* +5 бит текущего модуля (brp_read_rf_id, 30 − norm) */
};
_Static_assert(__builtin_offsetof(struct rf_modules_cfg, count) == 0, "rf_modules.count");
_Static_assert(__builtin_offsetof(struct rf_modules_cfg, cur) == 2, "rf_modules.cur");
_Static_assert(__builtin_offsetof(struct rf_modules_cfg, mask) == 3, "rf_modules.mask");
_Static_assert(__builtin_offsetof(struct rf_modules_cfg, x4) == 4, "rf_modules.x4");
_Static_assert(__builtin_offsetof(struct rf_modules_cfg, cur_mask) == 5, "rf_modules.cur_mask");

/* Шаблон BRP-кадра: заголовок 10 Б с начала, тело с +0x18. */
struct brp_frame_tpl {
    u16 fc;
    u16 dur;                            /* +0x02 */
    u16 ra[3];                          /* +0x04 адрес пира (sta_tab[].mac) */
    u8 hdr_rest[0xc];                   /* +0x0a в эфир не уходит: заголовок 10 Б, затем seq_ctrl и тело */
    u16 seq_ctrl;                       /* +0x16 номер последовательности << 4 (0x886544) */
    u8 category;
    u8 action;
    u8 token;
    u8 brp_req[4];
    u8 elem_id;
    u8 body_tail[6];                    /* до конца тела (14 Б с +0x18); +0x24 — u16, его пишет brp_* */
};

/* Запись станции: 9 записей по 0x50 Б с 0x801104 (8 — широковещательная). */
struct sta_entry {
    u16 state;                          /* +0x00 смысл не установлен */
    u16 flags;                          /* +0x02 бит 0 — запись валидна */
    u32 rx_sel;                         /* +0x04 RX-сектор/цепи */
    u32 tx_sel;                         /* +0x08 TX-сектор/цепи */
    u32 omni_rx_sel;                    /* +0x0c сектор «направленного omni» */
    u32 cfg_10;                         /* +0x10 смысл не установлен */
    u32 qid_mask_q4;                    /* +0x14 маски qid по qset 4/6/5 */
    u32 qid_mask_q6;                    /* +0x18 */
    u32 qid_mask_q5;                    /* +0x1c */
    u32 qid_mask_all;                   /* +0x20 OR масок */
    u32 qid_top_q5;                     /* +0x24 */
    u32 cfg_28;                         /* +0x28 смысл не установлен */
    u32 x2c;                            /* +0x2c */
    u16 mac[3];                         /* +0x30 MAC станции */
    u16 x36;
    u8 tx_key[16];                      /* +0x38 ключ */
    u8 fixed_link;                      /* +0x48 фиксированные параметры (OOB) */
    u8 fixed_mcs;                       /* +0x49 */
    u8 fixed_sector;                    /* +0x4a */
    u8 key_valid;                       /* +0x4b */
    u8 peer_n_ant;                      /* +0x4c */
    u8 peer_n_sectors;                  /* +0x4d */
    u8 x4e[2];
};
_Static_assert(sizeof(struct sta_entry) == 0x50, "sta_entry");
_Static_assert(__builtin_offsetof(struct brp_frame_tpl, seq_ctrl) == 0x16 && __builtin_offsetof(struct brp_frame_tpl, brp_req) == 0x1b, "brp_frame_tpl");

/* qset_shadow (0x800400). База теневых масок наборов очередей (qset) MAC; 0x28 Б. bf_pause_sta_tx (vendor 0x92ba88: mov_s r1,0x800400; ld/st [r1,0 */
struct qset_shadow_s {
    u8 _pad0[16];
    u32  qset4_range;               /* +0x10 Маска диапазона qid из LMAC 0x07 подкод 1 (байты lo/hi в +4 тела): (1<<hi)|((1<<hi)-(1<<lo */
    u32  qset4_mask;                /* +0x14 Тень маски qid набора qset 4 (LMAC 0x08 тип 0/1, +0x14 записи соседа); mac_publish_masks к */
    u32  qset5_range;               /* +0x18 Вторая маска диапазона qid LMAC 0x07 подкод 1 (байты +6/+7 тела); только запись в ucode_cm */
    u32  qset5_mask;                /* +0x1c Тень маски qid qset 5 (+0x18/+0x1c записи соседа): bf_pause_sta_tx вычитает очереди соседа */
    u32  qset6_range;               /* +0x20 Маска диапазона qid LMAC 0x07 подкод 2 (байты +8/+9 тела); только запись. */
    u32  qset6_mask;                /* +0x24 Тень маски qid qset 6 = очереди данных (LMAC 0x08 тип 3, +0x14 соседа); снимается при BF-п */
};
_Static_assert(__builtin_offsetof(struct qset_shadow_s, qset4_range) == 0x10, "qset_shadow.qset4_range");
_Static_assert(__builtin_offsetof(struct qset_shadow_s, qset4_mask) == 0x14, "qset_shadow.qset4_mask");
_Static_assert(__builtin_offsetof(struct qset_shadow_s, qset5_range) == 0x18, "qset_shadow.qset5_range");
_Static_assert(__builtin_offsetof(struct qset_shadow_s, qset5_mask) == 0x1c, "qset_shadow.qset5_mask");
_Static_assert(__builtin_offsetof(struct qset_shadow_s, qset6_range) == 0x20, "qset_shadow.qset6_range");
_Static_assert(__builtin_offsetof(struct qset_shadow_s, qset6_mask) == 0x24, "qset_shadow.qset6_mask");

/* g800610 (0x800610). В data.c — g800610_init (UCD_BYTES 18), в dccm.h нет. boot_uc_init_g800610 пишет те же значения, что в образе; читателей */
struct g800610_s {
    u16  h0;                        /* +0x00 = 6. */
    u16  h2;                        /* +0x02 = 2. */
    u16  h4;                        /* +0x04 = 0. */
    u8 _pad0[2];
    u32  w8;                        /* +0x08 = 0x3e8 (1000; возможно, мс/мкс). */
    u8   b0c;                       /* +0x0c = 0x1b. */
    u8   b0d;                       /* +0x0d = 0x24. */
    u8   b0e;                       /* +0x0e = 0x0f. */
    u8   b0f;                       /* +0x0f = 0x1e. */
    u8   b10;                       /* +0x10 = 1. */
    u8   b11;                       /* +0x11 = 0x13. */
};
_Static_assert(__builtin_offsetof(struct g800610_s, h0) == 0x0, "g800610.h0");
_Static_assert(__builtin_offsetof(struct g800610_s, h2) == 0x2, "g800610.h2");
_Static_assert(__builtin_offsetof(struct g800610_s, h4) == 0x4, "g800610.h4");
_Static_assert(__builtin_offsetof(struct g800610_s, w8) == 0x8, "g800610.w8");
_Static_assert(__builtin_offsetof(struct g800610_s, b0c) == 0xc, "g800610.b0c");
_Static_assert(__builtin_offsetof(struct g800610_s, b0d) == 0xd, "g800610.b0d");
_Static_assert(__builtin_offsetof(struct g800610_s, b0e) == 0xe, "g800610.b0e");
_Static_assert(__builtin_offsetof(struct g800610_s, b0f) == 0xf, "g800610.b0f");
_Static_assert(__builtin_offsetof(struct g800610_s, b10) == 0x10, "g800610.b10");
_Static_assert(__builtin_offsetof(struct g800610_s, b11) == 0x11, "g800610.b11");

/* busy_acct (0x800634). Учёт занятости канала: база r13=0x800634 в l1_task_entry; +0xc busy_gap_us и +0xd adc_gain_thresh уже названы (data.c: « */
struct busy_acct_s {
    u32  sig_start_tsf;             /* +0x00 TSF, когда сигнал АЦП в диапазоне (phy_signal_gain_adc_in_range); при сбросе, если прошло  */
    u32  busy_start_tsf;            /* +0x04 TSF события r42.б19 (l1_task_main_step/step_fixed_sched); rx_flow_run → rx_flow_accumulate */
    u32  last_end_tsf;              /* +0x08 Конец предыдущего busy-интервала; склейка, если промежуток ≤ busy_gap_us (rx_flow_accumula */
};
_Static_assert(__builtin_offsetof(struct busy_acct_s, sig_start_tsf) == 0x0, "busy_acct.sig_start_tsf");
_Static_assert(__builtin_offsetof(struct busy_acct_s, busy_start_tsf) == 0x4, "busy_acct.busy_start_tsf");
_Static_assert(__builtin_offsetof(struct busy_acct_s, last_end_tsf) == 0x8, "busy_acct.last_end_tsf");

/* fsched_ctx (0x80064c). Контекст фиксированного расписания; поле +0x18 fsched_max_cnt уже названо (data.c: «структура 0x80064c (+0x18)»). 0x20 Б */
struct fsched_ctx_s {
    u32  state;                     /* +0x00 +0 фаза автомата слота (0..7: 1 arm_from_cfg, 2 arm_timer, 4 run_tx_twice/ AP-слот, 5, 6 a */
    u8   rx_slot_active;            /* +0x04 +4 = 1 на время rx_flow_run_and_check_bf_abort в RX-слоте (fsched_rx_slot, l1_fixed_sched_ */
    u8   engaged;                   /* +0x05 +5: l1_fixed_sched_ap_sm ставит 1 при выходе из фазы 4/7, fixed_sched_is_engaged возвращае */
    u8   slot_cnt;                  /* +0x06 +6: ++ в l1_fixed_sched_ap_ev4_state2, 0 в ap_sm; fsched_time_left_class при ≥1 сравнивает */
    u8 _pad0[1];
    u32  slot_start_tsf;            /* +0x08 +8 TSF начала AP-слота (ev4_state2); в ev4_state4 разность добавляется к 0x857748+4·sta. */
    u32  slot_end_tsf;              /* +0x0c +0xc TSF конца слота (ev4_state4). BF-ENGINE.md «0x800658[cid] — MCS на соседа» — другое ( */
    u8   flush_cnt[8];              /* +0x10 по станциям: подряд слотов с flush (бит в 0x857248); ≥ max_cnt → бит в 0x85724c */
    u8   max_cnt;                   /* +0x18 порог flush_cnt; образ 0xc8 (data.c fsched_max_cnt) */
    u8 _pad1[3];
    u32  tbtt_left_prev;            /* +0x1c +0x1c: предыдущее время до TBTT (fsched_time_left_class). */
};
_Static_assert(__builtin_offsetof(struct fsched_ctx_s, state) == 0x0, "fsched_ctx.state");
_Static_assert(__builtin_offsetof(struct fsched_ctx_s, rx_slot_active) == 0x4, "fsched_ctx.rx_slot_active");
_Static_assert(__builtin_offsetof(struct fsched_ctx_s, engaged) == 0x5, "fsched_ctx.engaged");
_Static_assert(__builtin_offsetof(struct fsched_ctx_s, slot_cnt) == 0x6, "fsched_ctx.slot_cnt");
_Static_assert(__builtin_offsetof(struct fsched_ctx_s, slot_start_tsf) == 0x8, "fsched_ctx.slot_start_tsf");
_Static_assert(__builtin_offsetof(struct fsched_ctx_s, slot_end_tsf) == 0xc, "fsched_ctx.slot_end_tsf");
_Static_assert(__builtin_offsetof(struct fsched_ctx_s, flush_cnt) == 0x10, "fsched_ctx.flush_cnt");
_Static_assert(__builtin_offsetof(struct fsched_ctx_s, max_cnt) == 0x18, "fsched_ctx.max_cnt");
_Static_assert(__builtin_offsetof(struct fsched_ctx_s, tbtt_left_prev) == 0x1c, "fsched_ctx.tbtt_left_prev");

/* brp_rf_cfg (0x80066c). Конфигурация BRP RF (data.c: «структура 0x80066c (BRP RF)»); +4/+8/+9 уже названы (brp_rf_cfg_enable/_rf/_mask), +0xc —  */
struct brp_rf_cfg_s {
    u32  override_en;               /* +0x00 +0: ≠0 — config_brp_rf (фаза 6) пишет фиксированные шаблоны фаз для RF == +8 («HH Overridi */
    u32  enable;                    /* +0x04 ≠0 — config_brp_rf сохраняет конфигурацию (brp_rf_store_cfg/_module_byte); образ 1 */
    u8   rf;                        /* +0x08 RF для шаблонов override_en; образ 5 */
    u8   mask;                      /* +0x09 RF, для которых конфигурация пишется в регистры; образ 0xff */
    u8 _pad0[2];
    u8   sta_sel[8];                /* +0x0c по станциям (LMAC 0x32): б7..6 режим (≠0 — фиксированное число подполей, 2 — флаг в config_brp_rf), б5..0 число */
    u32  last_cfg_mask;             /* +0x14 +0x14: итоговая маска конфигураций (r13) в config_brp_rf. */
    u32  cfg_cnt;                   /* +0x18 +0x18: ++ при каждом config_brp_rf. */
};
_Static_assert(__builtin_offsetof(struct brp_rf_cfg_s, override_en) == 0x0, "brp_rf_cfg.override_en");
_Static_assert(__builtin_offsetof(struct brp_rf_cfg_s, enable) == 0x4, "brp_rf_cfg.enable");
_Static_assert(__builtin_offsetof(struct brp_rf_cfg_s, rf) == 0x8, "brp_rf_cfg.rf");
_Static_assert(__builtin_offsetof(struct brp_rf_cfg_s, sta_sel) == 0xc, "brp_rf_cfg.sta_sel");
_Static_assert(__builtin_offsetof(struct brp_rf_cfg_s, last_cfg_mask) == 0x14, "brp_rf_cfg.last_cfg_mask");
_Static_assert(__builtin_offsetof(struct brp_rf_cfg_s, cfg_cnt) == 0x18, "brp_rf_cfg.cfg_cnt");

/* mac_mode_sw (0x8006a8). Состояние mac_mode_switch_sequence (u8 *r13 = 0x8006a8). 3 Б. */
struct mac_mode_sw_s {
    u8   halted;                    /* +0x00 +0 = 1 после останова MAC (a≠0); l1_task_entry/main_step при ≠0 — assert 0x1313/0x1314. */
    u8   halt_cnt;                  /* +0x01 +1: ++ при a≠0 (останов). */
    u8   resume_cnt;                /* +0x02 +2: ++ при a==0 (выход из сна). */
};
_Static_assert(__builtin_offsetof(struct mac_mode_sw_s, halted) == 0x0, "mac_mode_sw.halted");
_Static_assert(__builtin_offsetof(struct mac_mode_sw_s, halt_cnt) == 0x1, "mac_mode_sw.halt_cnt");
_Static_assert(__builtin_offsetof(struct mac_mode_sw_s, resume_cnt) == 0x2, "mac_mode_sw.resume_cnt");

/* itx_pending (0x8006cc). Маски внутренних передач: +0 pending, +4 вторая, +8 исключение (NAMES-EXTRA «Структура: +0 маска pending, +4 вторая маск */
struct itx_pending_s {
    u32  mask;                      /* +0x00 +0 биты потоков sm (1 bcast, 2 KA, 3 BF, 4 sm4 — FTM, только SparRAW-pro; 6 TxSS, 5…); internal_tx_check_idle ст */
    u32  mask2;                     /* +0x04 +4: проверяется вместе с +0 в internal_tx_check_idle (обе пусты → internal_tx_set_pending_ */
    u32  exclude;                   /* +0x08 +8 маска-исключение; internal_tx_clear_exclude_mask обнуляет. 6.4: g_exclude_mask. */
    u32  txss_postponed;            /* +0x0c TxSS отложен в прошлый раз (internal_tx_isr, мало времени до конца BI) */
    u32  txss_postpone_cnt;         /* +0x10 откладываний подряд */
};
_Static_assert(__builtin_offsetof(struct itx_pending_s, mask) == 0x0, "itx_pending.mask");
_Static_assert(__builtin_offsetof(struct itx_pending_s, mask2) == 0x4, "itx_pending.mask2");
_Static_assert(__builtin_offsetof(struct itx_pending_s, exclude) == 0x8, "itx_pending.exclude");

/* vring_dbg (0x8006ec). Диагностика сброса vring/DMA; поля по базе 0x8006ec (vring_disconnect_flush) +0..+0x24, строки журнала uc. Поля +0x18..+ */
struct vring_dbg_s {
    u32  flush_wa_cnt;              /* +0x00 +0: ++ при обходе (WA) — «After VRing flush (… WA cnt %d)». */
    u32  pring_idle_cnt;            /* +0x04 +4: «Vring disconnect flow timeout: PRING is idle …». */
    u32  pring_idle_ptp_cnt;        /* +0x08 +8: тот же таймаут с «ptp_was_reset %d». */
    u32  ptp_reset_cnt;             /* +0x0c +0xc: ptp_sm == 5 → «PTP was reset to Idle». */
    u32  ptp_stuck_on_sm_other;     /* +0x10 +0x10: vendor-имя g_ptp_stuck_on_sm_other из строки «PTP stuck (but PFIFO2 sm != 5)… %d». */
    u32  dma_ch_reset_cnt;          /* +0x14 +0x14: ++ на каждом vring_dma_ch_reset в цикле ожидания PTP idle. */
    u32  macq_busy_a;               /* +0x18 +0x18: macq_is_idle — r41 по селектору 0xb (биты занятости очередей). NAMES-EXTRA (macq__i */
    u32  macq_busy_b;               /* +0x1c +0x1c: r41 по селектору 0xc. */
    u8   b20;                       /* +0x20 +0x20: база для vendor stb_s [0x80070c,0x2]; сами 0x80070c/0x80070d в uc не трогаются. */
    u8 _pad0[1];
    u8   tx_pipe_idle_cases;        /* +0x22 +0x22: dma_is_tx_pipe_idle — битовый статус (r19..r0 << 1..7); vendor-имя g_tx_pipe_idle_c */
    u8   qh_write_dma_open_cnt;     /* +0x23 +0x23: qh_write_while_dma_open_check — «QH Write while DMA is open (qid %d, write times %d */
    u8   max_flush_tries;           /* +0x24 +0x24: максимум попыток сброса («Max tries %d»). Доступ только как 0x8006ec+0x24. */
};
_Static_assert(__builtin_offsetof(struct vring_dbg_s, flush_wa_cnt) == 0x0, "vring_dbg.flush_wa_cnt");
_Static_assert(__builtin_offsetof(struct vring_dbg_s, pring_idle_cnt) == 0x4, "vring_dbg.pring_idle_cnt");
_Static_assert(__builtin_offsetof(struct vring_dbg_s, pring_idle_ptp_cnt) == 0x8, "vring_dbg.pring_idle_ptp_cnt");
_Static_assert(__builtin_offsetof(struct vring_dbg_s, ptp_reset_cnt) == 0xc, "vring_dbg.ptp_reset_cnt");
_Static_assert(__builtin_offsetof(struct vring_dbg_s, ptp_stuck_on_sm_other) == 0x10, "vring_dbg.ptp_stuck_on_sm_other");
_Static_assert(__builtin_offsetof(struct vring_dbg_s, dma_ch_reset_cnt) == 0x14, "vring_dbg.dma_ch_reset_cnt");
_Static_assert(__builtin_offsetof(struct vring_dbg_s, macq_busy_a) == 0x18, "vring_dbg.macq_busy_a");
_Static_assert(__builtin_offsetof(struct vring_dbg_s, macq_busy_b) == 0x1c, "vring_dbg.macq_busy_b");
_Static_assert(__builtin_offsetof(struct vring_dbg_s, b20) == 0x20, "vring_dbg.b20");
_Static_assert(__builtin_offsetof(struct vring_dbg_s, tx_pipe_idle_cases) == 0x22, "vring_dbg.tx_pipe_idle_cases");
_Static_assert(__builtin_offsetof(struct vring_dbg_s, qh_write_dma_open_cnt) == 0x23, "vring_dbg.qh_write_dma_open_cnt");
_Static_assert(__builtin_offsetof(struct vring_dbg_s, max_flush_tries) == 0x24, "vring_dbg.max_flush_tries");


/* cmdq_desc (0x800730). Дескриптор очереди команд, кладётся в 0x802470+0x44 (uc_init_cb_cmdq); +4 cmdq_desc_handler уже назван. 8 Б. */
struct cmdq_handler_desc {
    u32  link;                      /* +0x00 +0: вероятно, ссылка/ключ списка; в uc явно не трогается. */
};
_Static_assert(__builtin_offsetof(struct cmdq_handler_desc, link) == 0x0, "cmdq_desc.link");

/* power_stats (0x8007b8). power_mngr_stats_*: +0 база, +4 база времени, +8 дельта, +0xc дельта времени. 16 Б. NAMES-EXTRA, MISC-UC.md. */
struct power_stats_s {
    u32  base;                      /* +0x00 +0 = r0 (power_mngr_stats_mark_base); power_manager_tick_if_elapsed: now − base ≥ 0x17ed0. */
    u32  base_time;                 /* +0x04 +4 = [0x802308] (= 0x8022c8+0x40). */
    u32  delta;                     /* +0x08 +8 = a − base; power_manager_scale_counters_ms делит на 1000. */
    u32  delta_time;                /* +0x0c +0xc = [0x802308] − base_time. */
};
_Static_assert(__builtin_offsetof(struct power_stats_s, base) == 0x0, "power_stats.base");
_Static_assert(__builtin_offsetof(struct power_stats_s, base_time) == 0x4, "power_stats.base_time");
_Static_assert(__builtin_offsetof(struct power_stats_s, delta) == 0x8, "power_stats.delta");
_Static_assert(__builtin_offsetof(struct power_stats_s, delta_time) == 0xc, "power_stats.delta_time");

/* Init-дескриптор / узел списка таймеров {ключ, fn, next} (init_desc_globals 0x8007c8 и др.;
 * uc_list_insert_by_prio → timer_list_insert_sorted, timer_list_init вызывает fn). Раскладка —
 * по коду (ключ сортировки +0, fn +4, ссылка +8) и образу data.c (fn по +4). */
struct init_desc {
    u32  key;                       /* +0x00 ключ сортировки (timer_list_insert_sorted) */
    u32  fn;                        /* +0x04 обработчик: fn(fn, timer_list_head) */
    union {
        u32  next;                  /* +0x08 следующий узел списка (0 — конец) */
        u8   prio;                  /* +0x08 до вставки: приоритет (индекс timer_list_head) */
    };
};
_Static_assert(__builtin_offsetof(struct init_desc, fn) == 0x4, "init_desc.fn");
_Static_assert(__builtin_offsetof(struct init_desc, next) == 0x8, "init_desc.next");
_Static_assert(sizeof(struct init_desc) == 0xc, "init_desc");

/* fsched_flush_stats (0x800814). Статистика flush фиксированного расписания AP, 8×u16 (0x800814..0x800823). Отдаёт и обнуляет ucode_cmd_0x48_handler (cmd */
struct fsched_flush_stats_s {
    u16  slots;                     /* +0x00 +0: число TX-слотов AP (++ в l1_fixed_sched_ap_ev4_state4, tail.c 1973); в событии d[0] */
    u16  flushes;                   /* +0x02 +2: число flush по таймауту слота (++ перед vring_disconnect_flush, tail.c 2005); d[1] */
    u16  qword_start;               /* +0x04 +4: слово HW-очереди (macq_read_hw_queue_word) в начале слота (ev4_state2, tail.c 1942); в */
    u16  qword_end;                 /* +0x06 +6: слово HW-очереди в конце слота (tail.c 1994) */
    u16  last_sent;                 /* +0x08 +8: продвижение очереди за слот, закончившийся flush (tail.c 2000, vendor stw [0x800814,8] */
    u16  last_flushed;              /* +0x0a +0xa: продвижение очереди за сам flush (hw2 − qword_end, tail.c 2007); d[4] */
    u16  sum_sent;                  /* +0x0c +0xc: сумма продвижений очереди за все слоты (tail.c 1996); d[5] */
    u16  sum_flushed;               /* +0x0e +0xe: сумма продвижений при flush (tail.c 2008); d[6] */
};
_Static_assert(__builtin_offsetof(struct fsched_flush_stats_s, slots) == 0x0, "fsched_flush_stats.slots");
_Static_assert(__builtin_offsetof(struct fsched_flush_stats_s, flushes) == 0x2, "fsched_flush_stats.flushes");
_Static_assert(__builtin_offsetof(struct fsched_flush_stats_s, qword_start) == 0x4, "fsched_flush_stats.qword_start");
_Static_assert(__builtin_offsetof(struct fsched_flush_stats_s, qword_end) == 0x6, "fsched_flush_stats.qword_end");
_Static_assert(__builtin_offsetof(struct fsched_flush_stats_s, last_sent) == 0x8, "fsched_flush_stats.last_sent");
_Static_assert(__builtin_offsetof(struct fsched_flush_stats_s, last_flushed) == 0xa, "fsched_flush_stats.last_flushed");
_Static_assert(__builtin_offsetof(struct fsched_flush_stats_s, sum_sent) == 0xc, "fsched_flush_stats.sum_sent");
_Static_assert(__builtin_offsetof(struct fsched_flush_stats_s, sum_flushed) == 0xe, "fsched_flush_stats.sum_flushed");

/* brp_ctx (0x800824). Контекст BRP 0x800824..0x80088b (до brp_snr_cfg 0x80088c). Базы u32* /u8* = 0x800824 в brp.c (brp_rf_module_done, brp_ini */
struct brp_ctx_s {
    u32  cfg;                       /* +0x00 +0: = brp_ctx_cfg (dccm.h), битовые поля 15..20 (число лучших секторов → 0x801ff4) и 24..2 */
    u8   rf_mask_all;               /* +0x04 +4: маска всех RF-модулей (копия 0x8006b4+3 = 0x8006b7: boot.c 211, brp_init_reset_ctx/brp */
    u8 _pad0[3];
    u32  trn_bits[8][2];            /* +0x08 по RF-модулю: 64-битная маска, по 2 бита на TRN-подполе (r40 & 3);
                                       config_brp_rf пишет её в RF-регистры и в 0x8008c0 */
    u8   init_sta;                  /* +0x48 +0x48: станция инициатора BRP (brp_init_reset_ctx c[72]=a; читают brp_initiator_brp_transa */
    u8 _pad1[3];
    u32  init_rf_pending;           /* +0x4c +0x4c: маска RF-модулей, ещё не прошедших приём тренировки инициатора (= 0x8006b7 при сбро */
    u32  init_flags;                /* +0x50 +0x50: флаги инициатора: б0 активен (снимается когда +0x4c = 0), б1..8 маска выполненных R */
    u32  init_peer_req;             /* +0x54 +0x54: разобранное поле BRP-запроса соседа (brp_parse_request_fields: б0, б1 TX-TRN-REQ, б */
    u8   resp_sta;                  /* +0x58 +0x58: станция ответчика BRP (brp_init_ctx), аргумент config_brp_rf/bf_flow_exit; сравнива */
    u8 _pad2[3];
    u32  resp_rf_pending;           /* +0x5c +0x5c: маска RF-модулей, ожидающих тренировки ответчика (= 0x8006b7 в brp_init_ctx; снимае */
    u32  resp_flags;                /* +0x60 +0x60: флаги ответчика: б0 активен (ставит brp_init_ctx, снимает brp_rf_module_done при пу */
    u32  resp_peer_req;             /* +0x64 +0x64: разобранное поле BRP-запроса инициатора (brp_responder_flow_enter, ctx[0x64/4]); б2 */
};
_Static_assert(__builtin_offsetof(struct brp_ctx_s, cfg) == 0x0, "brp_ctx.cfg");
_Static_assert(__builtin_offsetof(struct brp_ctx_s, rf_mask_all) == 0x4, "brp_ctx.rf_mask_all");
_Static_assert(__builtin_offsetof(struct brp_ctx_s, init_sta) == 0x48, "brp_ctx.init_sta");
_Static_assert(__builtin_offsetof(struct brp_ctx_s, init_rf_pending) == 0x4c, "brp_ctx.init_rf_pending");
_Static_assert(__builtin_offsetof(struct brp_ctx_s, init_flags) == 0x50, "brp_ctx.init_flags");
_Static_assert(__builtin_offsetof(struct brp_ctx_s, init_peer_req) == 0x54, "brp_ctx.init_peer_req");
_Static_assert(__builtin_offsetof(struct brp_ctx_s, resp_sta) == 0x58, "brp_ctx.resp_sta");
_Static_assert(__builtin_offsetof(struct brp_ctx_s, resp_rf_pending) == 0x5c, "brp_ctx.resp_rf_pending");
_Static_assert(__builtin_offsetof(struct brp_ctx_s, resp_flags) == 0x60, "brp_ctx.resp_flags");
_Static_assert(__builtin_offsetof(struct brp_ctx_s, resp_peer_req) == 0x64, "brp_ctx.resp_peer_req");


/* pmc_trig (0x801458). конфигурация триггеров PMC-записи: txrx_umac_if_config_pmc_triggers_handler копирует 0xc Б команды (cmd.c 717), handle_p */
struct pmc_trigger_cfg {
    u8   start_trigger;             /* +0x00 триггер старта (сравнение с trigger, tail.c 331) */
    u8   stop_trigger;              /* +0x01 триггер останова (tail.c 339) */
    u8 _pad0[1];
    u8   start_param;               /* +0x03 параметр старта (pmc[3]) */
    u8   stop_param;                /* +0x04 параметр останова (pmc[4]) */
    u8 _pad1[3];
    u32  tag;                       /* +0x08 слово +8 из команды, передаётся в uc_evt_send_2c_tsf */
    u32  event_cnt;                 /* +0x0c счётчик вызовов после старта (обнуляется при старте, ++ в конце), уходит в событие останов */
    u8   armed;                     /* +0x10 1 — конфигурация задана (cmd.c 711/713/718); 0 — стоп (также ucode_cmd_0x19 vendor 0x93a80 */
    u8   recording;                 /* +0x11 0 — ждём старта, 1 — запись идёт (tail.c 330/336; cmd.c 719) */
};
_Static_assert(__builtin_offsetof(struct pmc_trigger_cfg, start_trigger) == 0x0, "pmc_trig.start_trigger");
_Static_assert(__builtin_offsetof(struct pmc_trigger_cfg, stop_trigger) == 0x1, "pmc_trig.stop_trigger");
_Static_assert(__builtin_offsetof(struct pmc_trigger_cfg, start_param) == 0x3, "pmc_trig.start_param");
_Static_assert(__builtin_offsetof(struct pmc_trigger_cfg, stop_param) == 0x4, "pmc_trig.stop_param");
_Static_assert(__builtin_offsetof(struct pmc_trigger_cfg, tag) == 0x8, "pmc_trig.tag");
_Static_assert(__builtin_offsetof(struct pmc_trigger_cfg, event_cnt) == 0xc, "pmc_trig.event_cnt");
_Static_assert(__builtin_offsetof(struct pmc_trigger_cfg, armed) == 0x10, "pmc_trig.armed");
_Static_assert(__builtin_offsetof(struct pmc_trigger_cfg, recording) == 0x11, "pmc_trig.recording");

/* rx_nav (0x80146c). состояние NAV/событий 0x80146c..0x80148b: rx_nav_clear_flags/arm_flag (rx.c 26–50), rx_nav_set_from_duration (rx.c 2294) */
struct rx_nav_state {
    u32  flags;                     /* +0x00 бит 0 — NAV активен (до +4), бит 1 — флаг arm (rx_nav_arm_flag_if_enabled =2); (flags&3)== */
    u32  end_tsf;                   /* +0x04 TSF конца NAV (rx.c 2329); bi_remaining_time_us / L_92dc44 = end_tsf − TSF, ограничено rx_ */
    u32  ev_mask;                   /* +0x08 маска событий MAC (с mac_chain_mask → команда 0x08…); образ: ~0 (data.c rx_nav_ev_mask) */
    u32  ev_mask_saved;             /* +0x0c сохранённая маска (NAV в AW, сон: tail.c) */
    u16  nav_ta[3];                 /* +0x10 TA кадра, установившего NAV; уходит в ответ DTS (rx.c) */
    u16  enable;                    /* +0x16 = rx_nav_enable (data.c) */
    u16  max_us;                    /* +0x18 = rx_nav_max_us (dccm.h) */
    u16  clip_cnt;                  /* +0x1a счётчик усечений длительности NAV до max_us (rx.c 2304) */
    u8   tsf_adjust;                /* +0x1c поправка (мкс), прибавляемая к TSF при расчёте end_tsf (rx.c 2310); писатель не найден (0  */
};
_Static_assert(__builtin_offsetof(struct rx_nav_state, flags) == 0x0, "rx_nav.flags");
_Static_assert(__builtin_offsetof(struct rx_nav_state, end_tsf) == 0x4, "rx_nav.end_tsf");
_Static_assert(__builtin_offsetof(struct rx_nav_state, ev_mask) == 0x8, "rx_nav.ev_mask");
_Static_assert(__builtin_offsetof(struct rx_nav_state, nav_ta) == 0x10, "rx_nav.nav_ta");
_Static_assert(__builtin_offsetof(struct rx_nav_state, enable) == 0x16, "rx_nav.enable");
_Static_assert(__builtin_offsetof(struct rx_nav_state, max_us) == 0x18, "rx_nav.max_us");
_Static_assert(__builtin_offsetof(struct rx_nav_state, clip_cnt) == 0x1a, "rx_nav.clip_cnt");
_Static_assert(__builtin_offsetof(struct rx_nav_state, tsf_adjust) == 0x1c, "rx_nav.tsf_adjust");

/* sel_nbr (0x8014e8). «избирательный сосед»/слежение за слабейшим соседом (0x8014e8..0x8014fd); начальные значения +1..+0x14 — sel_nbr_init в  */
struct sel_nbr_state {
    u8   cur_gain_db;               /* +0x00 ADC-gain дБ текущего кадра (phy_read_signal_gain_adc_db_sfd_locked, >0x3f → 0): rx.c 63, t */
    u8   min_gain_db;               /* +0x01 минимум cur_gain_db по кадрам от станций без [0x802610+12·sta] (rx.c 954–957, 1473–1475);  */
    u8   min_sta;                   /* +0x02 станция с минимумом; 0xff — замеров нет (l1_task_check_pending выходит) */
    u8   last_min_gain;             /* +0x03 копия min_gain_db на расчёте (r2[3]) */
    u8   updated;                   /* +0x04 =1 после расчёта (r2[4]) */
    u8   gain_snapshot;             /* +0x05 копия cur_gain_db при rx_mode_flags бит0 == 0 (rx.c 380) */
    u8   result;                    /* +0x06 min(cap, f(margin)) — итог расчёта (r2[6]) */
    u8   margin;                    /* +0x07 max(0, min_gain − threshold) (r2[7]); init 0x50 */
    u8   holdoff;                   /* +0x08 обратный счётчик пропуска расчётов (r2[8]--), init 5 */
    u8   cap;                       /* +0x09 верхний предел result: selective_neighbor_cfg: байт 0 команды == 1 → [+0xf], иначе 0 (cmd. */
    u8   cfg_a;                     /* +0x0a байт +2 команды selective_neighbor_cfg */
    u8   cfg_b;                     /* +0x0b байт +3 команды; init 0x2d */
    u8   fallback;                  /* +0x0c значение при малом запасе (r2[0xc]) */
    u8   threshold;                 /* +0x0d порог вычитания из min_gain (r2[0xd]), байт +1 команды; init 0x10 */
    u8 _pad0[1];
    u8   cap_default;               /* +0x0f значение cap при включении (r2[0xf]); init 0x14 */
    u8 _pad1[2];
    u8   out_floor;                 /* +0x12 нижняя граница out (r2[0x12]); init 6 */
    u8   out;                       /* +0x13 max(out_floor, margin + offset) (r2[0x13]); init 0x7f */
    u8 _pad2[1];
    s8   offset;                    /* +0x15 знаковая добавка к margin (ldb.x r2[21]); вне образа data.c (рантайм 0) */
};
_Static_assert(__builtin_offsetof(struct sel_nbr_state, cur_gain_db) == 0x0, "sel_nbr.cur_gain_db");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, min_gain_db) == 0x1, "sel_nbr.min_gain_db");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, min_sta) == 0x2, "sel_nbr.min_sta");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, last_min_gain) == 0x3, "sel_nbr.last_min_gain");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, updated) == 0x4, "sel_nbr.updated");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, gain_snapshot) == 0x5, "sel_nbr.gain_snapshot");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, result) == 0x6, "sel_nbr.result");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, margin) == 0x7, "sel_nbr.margin");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, holdoff) == 0x8, "sel_nbr.holdoff");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, cap) == 0x9, "sel_nbr.cap");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, cfg_a) == 0xa, "sel_nbr.cfg_a");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, cfg_b) == 0xb, "sel_nbr.cfg_b");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, fallback) == 0xc, "sel_nbr.fallback");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, threshold) == 0xd, "sel_nbr.threshold");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, cap_default) == 0xf, "sel_nbr.cap_default");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, out_floor) == 0x12, "sel_nbr.out_floor");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, out) == 0x13, "sel_nbr.out");
_Static_assert(__builtin_offsetof(struct sel_nbr_state, offset) == 0x15, "sel_nbr.offset");

/* brp_rf (0x801504). Замеры/калибровка BRP 0x801504..0x80152b (0x80150e уже brp_rf_gain_ref, 0x80152c — lin_to_db8_48). Заполняет brp_program */
struct brp_rf_meas {
    u8   agc_row;                   /* +0x00 +0: PHY 0x883aa4[5:0] после BRP; в brp_rf_store_cfg вычитается [0x8025dc] (строка AGC по R */
    u8   meas_8837f4;               /* +0x01 +1: PHY 0x8837f4[6:0]; индекс ((v+1)>>1) в lin_to_db8_48 (brp.c 244) — линейная величина ( */
    u8   snr;                       /* +0x02 +2: PHY 0x883800[4:0]; сравнивается с порогом brp_snr_cfg+9 в brp_pick_sector_cfg (brp.c 1 */
    u8 _pad0[1];
    u32  meas_8836c8;               /* +0x04 +4: PHY 0x8836c8[21:0] (brp.c 928); читателей в uc нет */
    u16  metric_sum;                /* +0x08 +8: сумма метрик c лучших секторов из 0x801c94[rf] (brp_rf_store_cfg, brp.c 236..239) */
    s16  gain_ref;                  /* +0x0a +0xa: = brp_rf_gain_ref (dccm.h) */
    u16  sta_gain[9];               /* +0x0c по станциям 0..8: gain_ref − 4·(agc_row − agc_start) − lin_to_db8_48[метрика] + lin_to_db8_48[8837f4] (brp_rf_store_cfg) */
    s8   omni_offset;               /* +0x1e +0x1e: s8, читает bf.c 253 (vendor 0x92f5a6 ldb.x [0x801504,30]) на пути «по таблице станц */
    s8   module_byte[8];            /* +0x1f по RF: копия brp_rf_module_byte (brp_rf_store_module_byte); знаковая добавка в rx_mode_configure */
    u8 _pad2[1];
};
_Static_assert(__builtin_offsetof(struct brp_rf_meas, agc_row) == 0x0, "brp_rf.agc_row");
_Static_assert(__builtin_offsetof(struct brp_rf_meas, meas_8837f4) == 0x1, "brp_rf.meas_8837f4");
_Static_assert(__builtin_offsetof(struct brp_rf_meas, snr) == 0x2, "brp_rf.snr");
_Static_assert(__builtin_offsetof(struct brp_rf_meas, meas_8836c8) == 0x4, "brp_rf.meas_8836c8");
_Static_assert(__builtin_offsetof(struct brp_rf_meas, metric_sum) == 0x8, "brp_rf.metric_sum");
_Static_assert(__builtin_offsetof(struct brp_rf_meas, gain_ref) == 0xa, "brp_rf.gain_ref");
_Static_assert(__builtin_offsetof(struct brp_rf_meas, omni_offset) == 0x1e, "brp_rf.omni_offset");
_Static_assert(__builtin_offsetof(struct brp_rf_meas, sta_gain) == 0xc, "brp_rf.sta_gain");
_Static_assert(__builtin_offsetof(struct brp_rf_meas, module_byte) == 0x1f, "brp_rf.module_byte");
_Static_assert(sizeof(struct brp_rf_meas) == 0x28, "brp_rf_meas");

/* fsched_peers (0x801be8). Контекст пиров фиксированного расписания, 0xac Б (0x801be8..0x801c93), начало BSS
 * (обнуляется uc_main при холодном старте; uc_init_globals: ent[] = 0, cur_idx = active_mask = 0,
 * pend_off_qid = 0xff). Указатель на него получают все fsched_* / fixed_sched_* / peer_* (vendor — r0). */
struct fsched_peer_ent {                /* шаг 5 Б (add2 r,r,r = ×5), индекс — станция 0..7 */
    u8   qid;                           /* +0 data-очередь пира (0xff — нет): ucode_cmd_0x08_handler, sta_find_by_byte */
    u8   cfg_idx;                       /* +1 индекс записи fwsh_sets.fsched_tbl->mcs[] */
    u8   slot_cnt;                      /* +2 слотов пира (fsched_slot_inc_f2), предел fwsh_sets.fsched_tbl->ap_slots_initiate_grant */
    u8   rd_counter;                    /* +3 счётчик RD (fixed_sched_manager::decrement_curr_sta_rd_counter) */
    u8   miss_cnt;                      /* +4 неудачных слотов подряд; ≥7 — бит в bf_req_mask */
};
_Static_assert(sizeof(struct fsched_peer_ent) == 5, "fsched_peer_ent");

/* Окно 2 QH — буфер MAC очереди, 16 Б (qh_read/write_desc_window, a2 = 2). Имена — по журналу
 * dump_mac_buffer_bases: «MAC buffer: base mac pal», «MAC desc: base mac pal». */
struct qh_buf_win {
    u16  buf_mac;                       /* 0x00 указатель MAC в буфере */
    u16  buf_pal;                       /* 0x02 указатель PAL */
    u16  buf_len8;                      /* 0x04 macq_kick_queue_tx: (длина + 7) / 8 */
    u16  buf_base;                      /* 0x06 база буфера (ожидается 0x2000) */
    union {
        u32  w8;                        /* 0x08 [12,24) desc mac */
        struct {
            u8   rsv08[3];
            u8   desc_pal_lo;           /* 0x0b desc pal [7:0] */
        };
    };
    u32  wc;                            /* 0x0c [0,4) desc pal [11:8], [16,28) desc base */
};
_Static_assert(__builtin_offsetof(struct qh_buf_win, buf_base) == 6, "qh_buf_win.buf_base");
_Static_assert(__builtin_offsetof(struct qh_buf_win, desc_pal_lo) == 0xb, "qh_buf_win.desc_pal_lo");
_Static_assert(sizeof(struct qh_buf_win) == 16, "qh_buf_win");

/* Окно 3 QH (desc_b команды fwif_write_qh, qh_build_descriptor), 16 Б: [0,12) слов +4/+8 —
 * начало/конец (начало — из окна 2 +4); байты +6 и +0xa vendor пишет отдельно (stb). */
struct qh_desc3_win {
    u32  w0;                            /* 0x00 */
    union {
        u32  start;                     /* 0x04 [0,12) начало */
        struct { u8 rsv04[2]; u8 start_b2; u8 rsv07; };   /* 0x06 — 0 */
    };
    union {
        u32  end;                       /* 0x08 [0,12) конец = начало + n − 1 */
        struct { u8 rsv08[2]; u8 n_m1; u8 rsv0b; };       /* 0x0a — n − 1 */
    };
    u32  wc;                            /* 0x0c */
};
_Static_assert(__builtin_offsetof(struct qh_desc3_win, start_b2) == 6, "qh_desc3_win.start_b2");
_Static_assert(__builtin_offsetof(struct qh_desc3_win, n_m1) == 0xa, "qh_desc3_win.n_m1");
_Static_assert(sizeof(struct qh_desc3_win) == 16, "qh_desc3_win");

/* Команда записи QH (тело LMAC fwif_write_qh), 0x74 Б. */
struct qh_write_cmd {
    u8   qid;                           /* +0 */
    u8   flags;                         /* +1 б0..б3 — окна 0..3, б4 — desc_b, б5 — упакованный дескриптор окна 0 */
    u16  desc_arg;                      /* +2 4-й аргумент qh_write_by_flags */
    u8   win[4][16];                    /* +4 окна дескрипторов */
    u8   desc_b[0x30];                  /* +0x44 */
};
_Static_assert(sizeof(struct qh_write_cmd) == 0x74, "qh_write_cmd");

struct fsched_peer_ctx {
    struct fsched_peer_ent ent[8];      /* +0x00 */
    u8   cur_idx;                       /* +0x28 Индекс текущей станции слота (0..7); fsched_ap_next_station ведёт от него кольцевой поиск */
    u8   active_mask;                   /* +0x29 Станции в расписании: ставят ucode_cmd_05_index и peer_masks_update_sta_bit(set) */
    u8   pend_off_qid;                  /* +0x2a Отложенное снятие пира (снимаемая станция — текущая): qid, 0xff — нет */
    u8   pend_off_idx;                  /* +0x2b Индекс станции отложенного снятия (бит в active_mask) */
    u8   bf_req_mask;                   /* +0x2c Станции, которым в слоте нужен BF (bf_sm_set_sta_state, miss_cnt ≥ 7) */
    u8   slot_kicked;                   /* +0x2d «Очередь слота запущена»: fixed_sched_check_slot_flag (assert 0x158e, если уже 1) */
    u8 _pad0[2];
    u32  rx_tsf[2];                     /* +0x30 TSF64 (lo, hi) перевода приёма в режим 2 (rx_mode_configure(2, sta)) */
    struct qh_write_cmd qh_pend;        /* +0x38 Отложенная запись QH пира в слоте (sched_cfg_merge_update) */
};
_Static_assert(sizeof(struct fsched_peer_ctx) == 0xac, "fsched_peer_ctx");
_Static_assert(__builtin_offsetof(struct fsched_peer_ctx, cur_idx) == 0x28, "fsched_peers.cur_idx");
_Static_assert(__builtin_offsetof(struct fsched_peer_ctx, slot_kicked) == 0x2d, "fsched_peers.slot_kicked");
_Static_assert(__builtin_offsetof(struct fsched_peer_ctx, rx_tsf) == 0x30, "fsched_peers.rx_tsf");
_Static_assert(__builtin_offsetof(struct fsched_peer_ctx, qh_pend) == 0x38, "fsched_peers.qh_pend");

/* Rate search по станциям 0..7: rs_state (0x802610, 12 Б), rs_stats (0x802670, 0x2c Б), rs_cfg (0x8027d0, 0x26 Б).
 * Массивы идут вплотную: индекс 8 у rs_state попадает в rs_stats[0], у rs_stats — в rs_cfg[0]. */
#define RS_NUM_MCS 13
struct rs_sta_state {
    u32  active;                        /* +0 1 — поиск идёт (rs_start), 2 — дошли до MCS 10 (tx_flow_substep), 0 — нет */
    u32  phase;                         /* +4 решение шага: 1 — нет, 2..5 — tx_flow_substep / rate_search_pick_tx_params */
    u32  phase_prev;                    /* +8 предыдущее phase (tx_initiator_reset_slot_counters) */
};
_Static_assert(sizeof(struct rs_sta_state) == 12, "rs_sta_state");

struct rs_sta_stats {
    u8   tx_cnt[RS_NUM_MCS];            /* +0x00 MPDU по MCS (r53 [14:8], bap_q_avail_check) */
    u8   fail_cnt[RS_NUM_MCS];          /* +0x0d неудачные MPDU по MCS (r53 [22:16]): PER = fail_cnt / tx_cnt */
    u8   mcs_best;                      /* +0x1a последний прошедший MCS (0 — нет) */
    u8   mcs_meas;                      /* +0x1b MCS, по которому копится статистика текущего окна */
    u8   mcs_try;                       /* +0x1c MCS-кандидат поиска */
    u8   mcs_cur;                       /* +0x1d MCS, выставленный в MAC (rate_search_apply_mcs) */
    u8   mcs_final;                     /* +0x1e итог (rs_end, rs_abort); исходная точка следующего rs_start */
    u8   warmup;                        /* +0x1f 1 после rs_start, пока очереди не опустеют (bap_q_avail_check) */
    u32  warmup_cnt;                    /* +0x20 BA-ответов за время warmup */
    u32  back_fail[2];                  /* +0x24 история неудач {биты, число} (bitstream_push) */
};
_Static_assert(sizeof(struct rs_sta_stats) == 0x2c, "rs_sta_stats");

/* Тело LMAC 0x13 со 2-го байта = struct wmi_rs_cfg драйвера wil6210 (wmi.h): те же поля и 38 Б.
 * u32-поля в записи по 0x26 Б не выровнены — по два u16, как читает vendor. */
struct rs_sta_cfg {
    u8   per_threshold[RS_NUM_MCS];     /* +0x00 предельный PER по MCS, % */
    u8   min_frame_cnt[RS_NUM_MCS];     /* +0x0d минимум MPDU для решения по MCS */
    u8   stop_th;                       /* +0x1a предельный PER не верхнего MCS, % */
    u8   mcs1_fail_th;                  /* +0x1b предел для MCS 1, % */
    u8   max_back_failure_th;           /* +0x1c предел числа неудач в back_failure_mask-окне */
    u8   dbg_disable_internal_trigger;  /* +0x1d != 0 — не запускать RS по завершению BF */
    u16  back_failure_mask[2];          /* +0x1e */
    u16  mcs_en_vec[2];                 /* +0x22 разрешённые MCS */
};
_Static_assert(sizeof(struct rs_sta_cfg) == 0x26, "rs_sta_cfg");

static inline u32 rs_cfg_mcs_en(const struct rs_sta_cfg *c)
{
    return c->mcs_en_vec[0] | ((u32)c->mcs_en_vec[1] << 16);
}

/* bcn_rx (0x802f14). Принятый маяк сети и решение об A-BFT в текущем BI, 0x30 Б. rx_flow_handle_frame
 * заполняет по маяку/SSW от сети; bi_manager_step_a обнуляет первые 0x1c Б; bcn_sent/abft_go —
 * bi_ctx_clear_state_words. */
struct bcn_rx_s {
    u8   my_bss;                        /* +0x00 маяк своей BSS (r38 б0) → свой BTI отменяется; bti: =1 при старте */
    u8   abft_here;                     /* +0x01 в этом BI есть A-BFT (длина FSS ≥ 4 у чужого маяка; у своего — bcn_bi.abft_bi_left == 0) */
    u8   bi_ctrl[6];                    /* +0x02 Beacon Interval Control маяка (кадр +0x17..): (b1<<8|b0)>>7 &7 — A-BFT Length,
                                           b1>>2 &0xf — FSS, b0 б1 — discovery */
    u32  bss_type;                      /* +0x08 DMG Parameters & 3 (3 — без A-BFT) */
    u8   sector;                        /* +0x0c Sector ID из SSW маяка */
    u8   antenna;                       /* +0x0d DMG Antenna ID */
    u8 _pad0[2];
    s32  metric;                        /* +0x10 метрика лучшего маяка (r40 [10:0] со знаком) */
    u16  bssid[3];                      /* +0x14 */
    u8 _pad1[2];
    u16  x1c;                           /* +0x1c ++ в bti (смысл не установлен) */
    u8   bcn_sent;                      /* +0x1e свой маяк отправлен в этом BI */
    u8   abft_go;                       /* +0x1f решено отвечать в A-BFT */
    u16  abft_ok_cnt;                   /* +0x20 A-BFT ответчик: получен SSW-Feedback */
    u16  abft_nofb_cnt;                 /* +0x22 feedback не получен → новый случайный слот */
    u16  abft_skip_mode;                /* +0x24 маяк пропущен по abft_cfg.responder_mode */
    u16  abft_skip_type;                /* +0x26 пропуск по abft_cfg.beacon_type (бит discovery) */
    u16  abft_skip_relax;               /* +0x28 пропуск по relaxation (abft_cfg.relax_cnt > 0) */
    u16  abft_try;                      /* +0x2a решено отвечать */
    u16  abft_direct_rep;               /* +0x2c mac_mode_program_c: отчёт после прямой передачи */
    u8   abft_direct_cnt;               /* +0x2e mac_mode_program_c: проход прямой передачи */
    u8 _pad2;
};
_Static_assert(sizeof(struct bcn_rx_s) == 0x30, "bcn_rx");
_Static_assert(__builtin_offsetof(struct bcn_rx_s, metric) == 0x10, "bcn_rx.metric");
_Static_assert(__builtin_offsetof(struct bcn_rx_s, x1c) == 0x1c, "bcn_rx.x1c");
_Static_assert(__builtin_offsetof(struct bcn_rx_s, abft_skip_mode) == 0x24, "bcn_rx.abft_skip_mode");

/* Поле FSS (байт 1 BI Control, биты 2..5). */
static inline u32 bcn_rx_fss(const struct bcn_rx_s *b) { return (b->bi_ctrl[1] >> 2) & 0xf; }
/* Первые два байта BI Control как u16. */
static inline u32 bcn_rx_bic16(const struct bcn_rx_s *b) { return b->bi_ctrl[0] | ((u32)b->bi_ctrl[1] << 8); }

/* Результат SLS по пиру (bi_ctx.rec, 0x802f4c, 0x18 Б). Пишут два пути: прямая передача
 * (mac_mode_program_c: лучший SSW пира, поля +0..+0xb, +0x10, +0x12) и ответчик A-BFT
 * (abft_resp_parse_fdbk: SSW-Feedback, +0xd..+0x10); читает uc_evt_build_and_post_report. */
struct sls_peer_rec {
    u8   sta;                           /* +0x00 станция по r38[10:8] (8 — неизвестна → new_link) */
    u8 _pad0[3];
    s32  rx_metric;                     /* +0x04 метрика лучшего SSW (r40 [19:9] со знаком); младший байт — в кадр SSW-FB */
    u8   rx_antenna;                    /* +0x08 антенна пира из SSW (+0x12 & 3) */
    u8   rx_sector;                     /* +0x09 сектор пира из SSW (>> 10) */
    u8   fb_antenna;                    /* +0x0a SSW-Feedback пира: наша лучшая антенна */
    u8   fb_sector;                     /* +0x0b SSW-Feedback пира: наш лучший сектор (+ поправка RF) */
    u8   x0c;                           /* +0x0c w[0] отчёта при flag = 1 (vendor ldb [r0,0xc]); писателей не найдено */
    u8   abft_sta;                      /* +0x0d A-BFT: станция-ответчик (r38[10:8] или 8) */
    u8   abft_sector;                   /* +0x0e A-BFT: Sector Select из SSW-Feedback (+ поправка RF) */
    u8   abft_antenna;                  /* +0x0f A-BFT: Antenna Select */
    u8   snr;                           /* +0x10 SNR report (SSW-Feedback +1 / кадр +0x14) */
    u8 _pad1;
    u16  peer_mac[3];                   /* +0x12 TA пира (кадр +0xa) */
};
_Static_assert(sizeof(struct sls_peer_rec) == 0x18, "sls_peer_rec");
_Static_assert(__builtin_offsetof(struct sls_peer_rec, rx_metric) == 0x4, "sls_peer_rec.rx_metric");
_Static_assert(__builtin_offsetof(struct sls_peer_rec, x0c) == 0xc, "sls_peer_rec.x0c");
_Static_assert(__builtin_offsetof(struct sls_peer_rec, snr) == 0x10, "sls_peer_rec.snr");
_Static_assert(__builtin_offsetof(struct sls_peer_rec, peer_mac) == 0x12, "sls_peer_rec.peer_mac");

/* Окно бодрствования (bi_ctx.aw, 0x802f68, 0x14 Б): пиры с отложенным трафиком и обход их по ATIM. */
struct aw_win_s {
    union {
        u32  pend;                      /* +0x00 биты 0..15 — пиры к обходу (bi_manager_eval_bcon_slot) */
        u8   pend_b[4];                 /*       байт 0 — бодрствующие с трафиком, 1 — без сопоставления */
    };
    u8   cur_bit;                       /* +0x04 курсор обхода 0..15 */
    u8   round;                         /* +0x05 номер круга (< 5) */
    u8 _pad0[2];
    u32  atim_armed;                    /* +0x08 AP: задержка перед первым ATIM выдержана */
    u32  qset_val;                      /* +0x0c поле qset (sxd_hal_write_qset_field): 0x28488 (vendor: dur_tu · 0xa5 по Awake Window — PS вырезан) */
    u16 _ps_cut_dur;                    /* +0x10 dur_tu (Awake Window, LMAC 0x25) — вырезано */
    u8 _pad1[2];
};
_Static_assert(sizeof(struct aw_win_s) == 0x14, "aw_win_s");
_Static_assert(__builtin_offsetof(struct aw_win_s, qset_val) == 0xc, "aw_win.qset_val");

/* bi_ctx (0x802f44). Контекст BI для L1: BTI-развёртка, SLS-результат пира, DTI, окно
 * бодрствования и фаза BI; 0x3c Б — до pm_ctx (0x802f80). Объект передают bi_sm_action_*,
 * l1_task_*, bi_ctx_set_active (boot), dti_alloc_dispatch. */
struct bi_ctx_s {
    u32  kind;                          /* +0x00 вид развёртки BTI (bti_prepare_sweep_set: 0 — свой маяк, 1 — BI2) */
    u8   status;                        /* +0x04 состояние BTI: 1, 2, 4, 5, 6 (= STARTED), возврат bti_prepare_sweep_set */
    u8   round;                         /* +0x05 счётчик кругов развёртки */
    u8   fast_done;                     /* +0x06 (наше, у vendor — выравнивание) ответ A-BFT станции уже сделан
                                         * из bti_bi2_track_best_metric (abft_responder_fast); сброс — bi_run_bti_cycle */
    u8 _pad0[1];
    struct sls_peer_rec rec;            /* +0x08 */
    u32  dti_wake;                      /* +0x20 DTI-аллокация: пир просил бодрствование (событие 29 при снятии) */
    struct aw_win_s aw;                 /* +0x24 */
    u32  phase;                         /* +0x38 фаза BI: 1 — DTI, 2 — AW (bi_state_from_g800600) */
};
_Static_assert(sizeof(struct bi_ctx_s) == 0x3c, "bi_ctx_s");
_Static_assert(__builtin_offsetof(struct bi_ctx_s, rec) == 0x8, "bi_ctx.rec");
_Static_assert(__builtin_offsetof(struct bi_ctx_s, dti_wake) == 0x20, "bi_ctx.dti_wake");
_Static_assert(__builtin_offsetof(struct bi_ctx_s, aw) == 0x24, "bi_ctx.aw");
_Static_assert(__builtin_offsetof(struct bi_ctx_s, phase) == 0x38, "bi_ctx.phase");

/* pm (0x802f80). Контекст энергосбережения ucode (в 4.1 — 0x801ed0), 0x17c Б: TBTT, маски
 * бодрствующих пиров по опросу ATI («ATIM»; ими пользуются link_loss и fwq_tx), тело события
 * ps_awake_peer. Расписания (LMAC 0x22), Awake Window (LMAC 0x25), UPM (LMAC 0x33/0x34) и
 * отсрочка трафика при D3 PCIe (LMAC 0x27) вырезаны. */
struct ps_evt_body {                    /* тело события ps_awake_peer (uc_send_evt_ps_awake_peer, 0xc Б) */
    u8   arg;
    u8   doze_bi;                       /* vendor: psc.state == 2; у нас всегда 0 */
    u8   awake;                         /* бодрствующие пиры (0xff — все) */
    u8   no_tx;
    u8   doze_info;                     /* 0 (vendor: AP — upm_vector, STA — in_doze; fw не читает) */
    u8 _pad[3];
    u32  type;                          /* 1 — PS_EVT_CLEAR_PEER, 2, 3 */
};
struct pm_ctx_s {
    /* Энергосбережение (расписания PS, Awake Window, UPM-doze STA, x18/x1c) вырезано сознательно —
     * см. fw/action.c psc_req_reject. Раскладка vendor сохранена: вырезанные поля — заполнители. */
    u8 _ps_cut0[0x12c];                 /* +0x00 x18/x1c, psc/psc_req, aw_ie, sta[8]/sta_req[8], nodoze/idle_mask */
    u32  tbtt[2];                       /* +0x12c TBTT64 */
    u32  awake_mask;                    /* +0x134 бодрствующие пиры: байты 0 и 1 (op 3 — бит << 8) */
    u32  no_tx_mask;                    /* +0x138 */
    u32 _ps_cut_bits;                   /* +0x13c ps_bits (op 4 при отсрочке трафика) — вырезано */
    u32  ps_active;                     /* +0x140 */
    u32 _ps_cut_td;                     /* +0x144 td_enabled (отсрочка трафика, LMAC 0x27) — вырезано */
    u8  _ps_cut_td_sub;                 /* +0x148 td_sub */
    u8 _pad2[3];
    u8 _ps_cut1[0xc];                   /* +0x14c bi_phase, next_start */
    struct ps_evt_body evt;             /* +0x158 */
    u8 _ps_cut2[0x14];                  /* +0x164 UPM: enable/saved/doze_req, timeout, hold*, itx6_active */
    u8 _ps_cut3[2];                     /* +0x178 upm_vector (AP: бит PM станций), in_doze */
    u8 _pad6[2];
};
_Static_assert(sizeof(struct ps_evt_body) == 12, "ps_evt_body");
_Static_assert(__builtin_offsetof(struct pm_ctx_s, tbtt) == 0x12c, "pm.tbtt");
_Static_assert(__builtin_offsetof(struct pm_ctx_s, evt) == 0x158, "pm.evt");
_Static_assert(sizeof(struct pm_ctx_s) == 0x17c, "pm");

/* Состояние BF по станциям 0..8 (8 — неизвестный пир) и очередь запросов BF, 0x801ffc..0x8020c3
 * (0xc8 Б; bf_init_sm обнуляет целиком). Шаг записи — 20 Б. */
struct bf_sta_s {
    u32  state;                         /* +0x00 ucode_bf_state_e: 0 idle, 3 TXSS_INIT, 4 TXSS_RESP, 9 BRP_INIT,
                                           10 BRP_RESP, 0xb abort, 0x11 «нужен BF», 0x12 таймаут */
    u32  flow_status;                   /* +0x04 итог потока (1 ENERGY_FAILURE_SS, 9 успех, 0x30/0x35 ...) */
    u8   _8;
    u8   peer_l_rx;                     /* +0x09 L-RX из BRP-запроса пира (SSW-Feedback/Ack, & 0x1f) */
    u8   brp_flags;                     /* +0x0a б0 — пир просил BRP-RX без MID/BC; AoA (LMAC 0x31, только SparRAW-pro) ставил */
    u8   _b;
    struct bf_req_desc *req_desc;       /* +0x0c дескриптор запроса (bf_req_desc_default; AoA — только SparRAW-pro) */
    u32  done_cb2;                      /* +0x10 второй колбэк завершения (из req_desc->cb2) */
};
_Static_assert(sizeof(struct bf_sta_s) == 20, "bf_sta");
struct bf_req_q_s {
    u32  pending_mask;                  /* +0x00 станции с запросом в очереди (б8 — неизвестный пир) */
    u8   fifo[8];                       /* +0x04 номера станций, индекс & 7 */
    u32  head;                          /* +0x0c счётчик головы */
    u32  tail;                          /* +0x10 счётчик хвоста; tail − head ≥ 9 → assert 0x12 */
};
_Static_assert(sizeof(struct bf_req_q_s) == 0x14, "bf_req_q");

/* TX-контексты (0x802978): двойной буфер по 0x3c Б, tx_ctx_alloc_next берёт следующий слот (seq & 1)
 * и делает его текущим (tx_ctx_cur). DATAPATH.md §3.2–3.3. */
struct tx_ctx_s {
    u32  sta;                           /* +0x00 станция/cid */
    u32  qid;                           /* +0x04 очередь (0xff при выделении) */
    u32  resp_ctx8;                     /* +0x08 */
    u32  flags;                         /* +0x0c б0, б1, б8, б9, б11 (ключ загружен) ... */
    u32  x10, x14;                      /* +0x10 */
    u32  ack_mask;                      /* +0x18 маска сверяется с r45 [7:0] (разрешение передачи / ответа) */
    u32  x1c;
    u32  x20;                           /* +0x20 */
    u32  mtp_state;                     /* +0x24 2 — ждёт сервиса MTP */
    u32  chan_access;                   /* +0x28 & 3: 0 немедленно, 1 RTS, 2 self-CTS, 3 по мощности;
                                           mtp_get_tx_permission кладёт r43 [7:4] */
    u32  rf_word;                       /* +0x2c слово RF/сектора станции (sta_tab[].rx_sel) */
    u32  x30, x34, x38;
};
_Static_assert(sizeof(struct tx_ctx_s) == 0x3c, "tx_ctx");
_Static_assert(__builtin_offsetof(struct tx_ctx_s, ack_mask) == 0x18, "tx_ctx.ack_mask");
_Static_assert(__builtin_offsetof(struct tx_ctx_s, rf_word) == 0x2c, "tx_ctx.rf_word");
struct tx_ctx_pool_s {
    struct tx_ctx_s slot[2];            /* +0x00 */
    struct tx_ctx_s *cur;               /* +0x78 текущий */
    u32  x7c;
    u32  seq;                           /* +0x80 счётчик выделений */
};
_Static_assert(__builtin_offsetof(struct tx_ctx_pool_s, seq) == 0x80, "tx_ctx_pool.seq");

/* fsched_log (0x8007d4): кольцевой журнал фиксированного расписания, 16 записей, индекс fsched_log_idx. */
struct fsched_log_ent {
    u8   state;                         /* fsched_ctx.state */
    u8   phase;                         /* fsched_log_phase */
    u8   step;                          /* точка в автомате слота (1..0xf) */
    u8   arg;                           /* 0xff или номер станции */
};
_Static_assert(sizeof(struct fsched_log_ent) == 4, "fsched_log_ent");


/* sls (0x80212c): контекст SLS/TXSS, 0x8c Б — лучший сектор, топ-5 по SNR и их порядок, MAC соседа,
 * маски станций, счётчики попыток BF. g_80212c_reset чистит best/top и ставит rank[i] = i. */
struct sector_rec {
    u8   sector;
    u8   antenna;                       /* DMG-антенна (<<6 в поле SSW-Feedback) */
    u16  _pad;
    u32  snr_lin;                       /* сумма db_to_lin по отсчётам — ключ сортировки */
    s32  snr_db;                        /* SSW-Feedback: SNR = (v − 19)·4 */
};
_Static_assert(sizeof(struct sector_rec) == 12, "sector_rec");
struct sls_ctx_s {
    struct sector_rec best;             /* +0x00 */
    struct sector_rec top[5];           /* +0x0c */
    u32  rank[5];                       /* +0x48 перестановка top[]: rank[0] — худший, rank[4] — лучший */
    u16  peer_mac[3];                   /* +0x5c MAC соседа текущего SLS */
    u16  _62;
    u16  x64;                           /* +0x64 только запись 0 */
    u8   rank_valid_mask;               /* +0x66 станции с рейтингом секторов в 0x857c1c */
    u8   rank_valid_mask2;              /* +0x67 */
    u8   maint_sta_mask;                /* +0x68 станции «на поддержании» (LMAC 0x0f) */
    u8   maint_sta_mask_prev;           /* +0x69 */
    u8   _6a[2];
    u32  attempts[8];                   /* +0x6c попыток BF по станциям (bf_init_sm) */
};
_Static_assert(sizeof(struct sls_ctx_s) == 0x8c, "sls_ctx");
_Static_assert(__builtin_offsetof(struct sls_ctx_s, maint_sta_mask) == 0x68, "sls.maint_sta_mask");

/* struct ss_cfg_s — include/lmac_cmd.h (тело LMAC 0x0b/0x0c/0x35). */

struct brp_rank_ent {
    u8   metric;
    u8   idx;                           /* индекс TRN-подполя / AWV 0..31 */
};

/* qid_cfg (0x802228): по qid, 3 Б, 32 записи — пишет ucode_cmd_0x08_handler. DATAPATH.md §8. */
struct qid_cfg_s {
    u8   ctrl_b6;                       /* слово +0xc тела б6: код управляющего кадра 0xf вместо 0xc */
    u8   null_b5;                       /* б5 (null_status): при r43.null_status ctx->flags |= 2, ctx->x20 = 0 */
    u8   cid;                           /* станция очереди */
};
_Static_assert(sizeof(struct qid_cfg_s) == 3, "qid_cfg");
/* qset_slot (0x8015a4): слоты очередей qset 9..12, шаг 4. */
struct qset_slot_s {
    u8   init;                          /* начальное число слотов */
    u8   max;
    u8   cur;                           /* растёт до max (tx_pick_slot_for_peer), сброс к init */
    u8   _3;
};
_Static_assert(sizeof(struct qset_slot_s) == 4, "qset_slot");

/* brp_stats (0x801e94). Счётчики/снимки BRP 0x801e94..0x801ef3. Vendor адресует хвост от второй базы 0x801ed4 (= +0x40); единый объект: элемент  */
struct brp_stats_s {
    u8   meas_started;              /* +0x00 +0: cnt[0]++ при запуске измерения (brp_program_and_measure) */
    u8   meas_timeout;              /* +0x01 +1: нет r54.1 (метрика не пришла), vendor 0x9237de */
    u8   meas_not_ready;            /* +0x02 +2: r49 б13 не взведён на входе */
    u8 _pad0[1];
    u32  trn_copy[8][2];            /* +0x04 копия brp_ctx.trn_bits[rf] после измерения */
    u8   meas_done;                 /* +0x44 +0x44 (0x801ed4+4): число завершённых измерений (brp.c 930) */
    u8   restore_cnt[8];            /* +0x45 по RF: восстановлений секторов (brp_restore_sectors) */
    u8 _pad1[1];
    u16  init_req_noresp;           /* +0x4e +0x4e (0x801ed4+0xe): 3 попытки обмена запросом без ответа (brp_init_exchange_request, brp */
    u16  init_trn_ok;               /* +0x50 +0x50 (+0x10): успешная тренировка инициатора; инкремент в двух местах подряд (transaction */
    u16  init_meas_fail;            /* +0x52 +0x52 (+0x12): 10 неудачных измерений подряд (brp.c 306) */
    u16  init_timeout10;            /* +0x54 +0x54 (+0x14): 10 таймаутов r54.6 (brp.c 332) */
    u16  init_timeout_idle;         /* +0x56 +0x56 (+0x16): таймаут при снятом б0 init_flags (brp.c 324) */
    u16  resp_start;                /* +0x58 +0x58 (+0x18): запуски ответчика (brp_init_ctx, brp.c 1000) */
    u16  resp_rf_done;              /* +0x5a +0x5a (+0x1a): завершённые RF-модули ответчика (brp_rf_module_done, brp.c 133) */
};
_Static_assert(__builtin_offsetof(struct brp_stats_s, meas_started) == 0x0, "brp_stats.meas_started");
_Static_assert(__builtin_offsetof(struct brp_stats_s, meas_timeout) == 0x1, "brp_stats.meas_timeout");
_Static_assert(__builtin_offsetof(struct brp_stats_s, meas_not_ready) == 0x2, "brp_stats.meas_not_ready");
_Static_assert(__builtin_offsetof(struct brp_stats_s, meas_done) == 0x44, "brp_stats.meas_done");
_Static_assert(__builtin_offsetof(struct brp_stats_s, init_req_noresp) == 0x4e, "brp_stats.init_req_noresp");
_Static_assert(__builtin_offsetof(struct brp_stats_s, init_trn_ok) == 0x50, "brp_stats.init_trn_ok");
_Static_assert(__builtin_offsetof(struct brp_stats_s, init_meas_fail) == 0x52, "brp_stats.init_meas_fail");
_Static_assert(__builtin_offsetof(struct brp_stats_s, init_timeout10) == 0x54, "brp_stats.init_timeout10");
_Static_assert(__builtin_offsetof(struct brp_stats_s, init_timeout_idle) == 0x56, "brp_stats.init_timeout_idle");
_Static_assert(__builtin_offsetof(struct brp_stats_s, resp_start) == 0x58, "brp_stats.resp_start");
_Static_assert(__builtin_offsetof(struct brp_stats_s, resp_rf_done) == 0x5a, "brp_stats.resp_rf_done");

/* brp_pick (0x801ff4). Выбор секторов BRP 0x801ff4..0x801ffb: пишет brp_pick_sector_cfg (brp.c 165), использует config_brp_rf (tail.c 1284, r23 */
struct brp_pick_s {
    u8   count;                     /* +0x00 +0: число лучших подполей (brp_ctx_cfg[20:15] или brp_snr_cfg+8, или sector_cfg 0x80066c+0 */
    u8   snr_cfg;                   /* +0x01 +1: brp_snr_cfg+5/+6 по порогу SNR или 0; аргумент brp_select_cfg_by_snr (tail.c 1301) */
    u8   selected;                  /* +0x02 +2: число реально выбранных подполей (config_brp_rf ++); в отчёт BF w[10] (tail.c 623, ven */
    u8 _pad0[1];
    u32  keep_mask;                 /* +0x04 +4: маска «добивки» подполей до максимума по группам (config_brp_rf, tail.c 1371); читател */
};
_Static_assert(__builtin_offsetof(struct brp_pick_s, count) == 0x0, "brp_pick.count");
_Static_assert(__builtin_offsetof(struct brp_pick_s, snr_cfg) == 0x1, "brp_pick.snr_cfg");
_Static_assert(__builtin_offsetof(struct brp_pick_s, selected) == 0x2, "brp_pick.selected");
_Static_assert(__builtin_offsetof(struct brp_pick_s, keep_mask) == 0x4, "brp_pick.keep_mask");

/* brp_rf_regs (0x8008c0): теневые копии RF-регистров BRP по (RF, станция), [8][8] × 0x1c Б —
 * до таблицы log 0x800fc0. Пишет config_brp_rf, восстанавливает в RF brp_restore_sectors
 * (brp.c). Имя поля — смещение регистра в блоке сектора (0xc0·(станция + 0x60) + 0x10000). */
struct brp_rf_regs_s {
    u32  reg_20;                        /* +0x00 trn_bits[rf][0] */
    u32  reg_00;                        /* +0x04 trn_bits[rf][1] */
    u32  reg_60;                        /* +0x08 config_brp_rf r17: выбор по SNR, набор 0 (+ keep_mask) */
    u32  reg_40;                        /* +0x0c набор 1 */
    u32  reg_a0;                        /* +0x10 набор 2 */
    u32  reg_80;                        /* +0x14 маска групп (3 бита на группу, б28/б29) */
    u32 _pad;                           /* +0x18 не используется */
};
_Static_assert(sizeof(struct brp_rf_regs_s) == 0x1c, "brp_rf_regs_s");

/* bf_rep (0x8020f0). Контекст отчёта SLS/BF (0x20 Б, 0x8020f0..0x80210f): из него uc_evt__build_and_post_report и notify_aoa собирают события */
struct bf_report_ctx {
    u32  start_tsf;                 /* +0x00 TSF старта текущего BF: l1_task_select_by_mode считает delta=tsf−[0x8020f0]; >1000 мкс в с */
    u32  elapsed_us;                /* +0x04 Последняя дельта tsf−start_tsf (l1_task_select_by_mode), только запись. */
    s32  link_snr;                  /* +0x08 min(порог, уровень) — SNR линка для отчёта: rx_funcs__record_level_8020f8_8020fc; сброс −2 */
    s8   peer_snr;                  /* +0x0c Уровень SNR из SSW-Feedback соседа ((a>>2)+0x13, s8); ldb.x в отчётах. */
    s8   own_snr;                   /* +0x0d Порог = (s8)best.snr (0x802134) на момент записи; ldb.x в отчётах. */
    u8   ssw_rx_cnt;                /* +0x0e Число принятых кадров развёртки (++ в phy_params__snapshot), сброс в bf_txss__reset_report */
    u8   _f;
    u32  sect_seen[2][2];           /* +0x10 карты увиденных секторов: [0] — 0..63, [1] — 64..127 (u64 как lo, hi) */
};
_Static_assert(__builtin_offsetof(struct bf_report_ctx, sect_seen) == 0x10, "bf_rep.sect_seen");
_Static_assert(__builtin_offsetof(struct bf_report_ctx, start_tsf) == 0x0, "bf_rep.start_tsf");
_Static_assert(__builtin_offsetof(struct bf_report_ctx, elapsed_us) == 0x4, "bf_rep.elapsed_us");
_Static_assert(__builtin_offsetof(struct bf_report_ctx, link_snr) == 0x8, "bf_rep.link_snr");
_Static_assert(__builtin_offsetof(struct bf_report_ctx, peer_snr) == 0xc, "bf_rep.peer_snr");
_Static_assert(__builtin_offsetof(struct bf_report_ctx, own_snr) == 0xd, "bf_rep.own_snr");
_Static_assert(__builtin_offsetof(struct bf_report_ctx, ssw_rx_cnt) == 0xe, "bf_rep.ssw_rx_cnt");

/* bf_res (0x802110). Итоги BF (0x1c Б, 0x802110..0x80212b; memset0 в bf_init_sm, затем 0x80211c восстанавливается из 0x8004f8). vendor адресу */
struct bf_result {
    u8   tx_sector;                 /* +0x00 Последний выставленный TX-сектор (sta__set_tx_sector копирует 0x8021cc); sta__apply_bf_res */
    u8   rx_sector;                 /* +0x01 Последний RX-сектор (sta__set_rx_sector копирует 0x8021d4); → [0x80046e], поле отчёта noti */
    u8 _pad0[10];
    u32  done_cnt;                  /* +0x0c Счётчик завершённых запросов BF (bf_req__dequeue_head ++, копия в 0x8004f8 переживает mems */
    u32  diag;                      /* +0x10 Диагностика: state | substate<<4 текущей станции (bf_sm__run_sta, bf_sm__process_request_f */
    u32  diag_last;                 /* +0x14 Копия diag при завершении (process_request_fifo); notify_aoa раскладывает в b[0x3a]=&0xf,  */
    u32  fail_reasons;              /* +0x18 Копия байта причин BF 0x857e49[sta] при построении отчёта (notify_aoa); только запись. */
};
_Static_assert(__builtin_offsetof(struct bf_result, tx_sector) == 0x0, "bf_res.tx_sector");
_Static_assert(__builtin_offsetof(struct bf_result, rx_sector) == 0x1, "bf_res.rx_sector");
_Static_assert(__builtin_offsetof(struct bf_result, done_cnt) == 0xc, "bf_res.done_cnt");
_Static_assert(__builtin_offsetof(struct bf_result, diag) == 0x10, "bf_res.diag");
_Static_assert(__builtin_offsetof(struct bf_result, diag_last) == 0x14, "bf_res.diag_last");
_Static_assert(__builtin_offsetof(struct bf_result, fail_reasons) == 0x18, "bf_res.fail_reasons");

/* bf_ctrl (0x8021b8). Настройки BF/управляющих кадров (0x8021b8..0x8021df): поля из LMAC 0x10 (16 Б = копия fw 0x8014b0, WMI_BF_CONTROL), 0x14 */
struct bf_ctrl_cfg {
    u8   snr_samples;               /* +0x00 Число отсчётов SNR для выбора сектора (цикл r9 < [0x8021b8], шаг 8; rx_flow__measure_snr_s */
    u8 _pad0[3];
    u32  cmd10_w0;                  /* +0x04 Слово +0 тела LMAC 0x10 (ucode_cmd_0x10_handler); читателей нет. */
    u8   ctrl_code_tx;              /* +0x08 Код/параметр управляющего кадра для TX (tx_sta__run_txop, internal_tx__flow_sm2; у vendor и sm6 — UPM, вырезан), альт */
    u8   ctrl_code_rx;              /* +0x09 То же для приёма/статистики (rx__handle_status_flags, tx_sta__flow_loop: bitstream_push(.. */
    u8   ctrl_code_tx_alt;          /* +0x0a Вариант 0x8021c0 при txrx_cfg_flags (0x8014a0) бит 9. LMAC 0x10 +0xa. */
    u8   ctrl_code_rx_alt;          /* +0x0b Вариант 0x8021c1 при бите 9. LMAC 0x10 +0xb. */
    u32  stat_bit;                  /* +0x0c 1<<((0x20−b)&31) из LMAC 0x10 +0xc; параметр bitstream_push (окно статистики CTS). */
    u32  tx_sector_force;           /* +0x10 1 — TX-сектор задан хостом (set_selected_rf_sector_index, sub=1, v≠0xffff); sta__set_tx_se */
    u8   tx_sector;                 /* +0x14 TX-сектор: принудительный (хост) или последний выставленный (sta__set_tx_sector). */
    u8 _pad1[3];
    u32  rx_sector_force;           /* +0x18 1 — RX-сектор задан хостом (sub=0); sta__set_rx_sector берёт 0x8021d4. */
    u8   rx_sector;                 /* +0x1c RX-сектор: принудительный или последний (sta__set_rx_sector); sls__rx_ssw_frame читает. */
    u8 _pad2[3];
    u32  triggers;                  /* +0x20 «Triggers enable dword» из LMAC 0x14 (встроен в ucode_cmd_dispatch, case 0x14; fw: «Updati */
    u8   txss_mode;                 /* +0x24 txss_mode из LMAC 0x10 +0xd (ucode_cmd_0x10_handler). BF-ENGINE §6. */
    u8   brp_mode;                  /* +0x25 brp_mode из LMAC 0x10 +0xe: ==1 и бит в 0x802194 → после SLS BRP_INIT (9), иначе DONE; bf_ */
};
_Static_assert(__builtin_offsetof(struct bf_ctrl_cfg, snr_samples) == 0x0, "bf_ctrl.snr_samples");
_Static_assert(__builtin_offsetof(struct bf_ctrl_cfg, cmd10_w0) == 0x4, "bf_ctrl.cmd10_w0");
_Static_assert(__builtin_offsetof(struct bf_ctrl_cfg, ctrl_code_tx) == 0x8, "bf_ctrl.ctrl_code_tx");
_Static_assert(__builtin_offsetof(struct bf_ctrl_cfg, ctrl_code_rx) == 0x9, "bf_ctrl.ctrl_code_rx");
_Static_assert(__builtin_offsetof(struct bf_ctrl_cfg, ctrl_code_tx_alt) == 0xa, "bf_ctrl.ctrl_code_tx_alt");
_Static_assert(__builtin_offsetof(struct bf_ctrl_cfg, ctrl_code_rx_alt) == 0xb, "bf_ctrl.ctrl_code_rx_alt");
_Static_assert(__builtin_offsetof(struct bf_ctrl_cfg, stat_bit) == 0xc, "bf_ctrl.stat_bit");
_Static_assert(__builtin_offsetof(struct bf_ctrl_cfg, tx_sector_force) == 0x10, "bf_ctrl.tx_sector_force");
_Static_assert(__builtin_offsetof(struct bf_ctrl_cfg, tx_sector) == 0x14, "bf_ctrl.tx_sector");
_Static_assert(__builtin_offsetof(struct bf_ctrl_cfg, rx_sector_force) == 0x18, "bf_ctrl.rx_sector_force");
_Static_assert(__builtin_offsetof(struct bf_ctrl_cfg, rx_sector) == 0x1c, "bf_ctrl.rx_sector");
_Static_assert(__builtin_offsetof(struct bf_ctrl_cfg, triggers) == 0x20, "bf_ctrl.triggers");
_Static_assert(__builtin_offsetof(struct bf_ctrl_cfg, txss_mode) == 0x24, "bf_ctrl.txss_mode");
_Static_assert(__builtin_offsetof(struct bf_ctrl_cfg, brp_mode) == 0x25, "bf_ctrl.brp_mode");

/* sls_rx (0x8021e0). Состояние приёма SLS/BRP (init-размер 0x18: 0x8021e0..0x8021f7). 83 обращения vendor; сбрасывает sls__clear_rx_state. */
struct sls_rx_state {
    u32  flags;                     /* +0x00 Флаги: б0 ISS соседа, б1 развёртка соседа окончена (zero_cdown + ролевой гейт), б2 SSW-Fee */
    u8 _pad0[8];
    u8   brp_lrx;                   /* +0x0c L-RX (число запрошенных TRN-R) из BRP Request 0x80402b & 0x1f (rx__handle_brp_frame), +0xc */
    u8 _pad1[5];
    u16  x12;                       /* +0x12 +0x12: bi_manager_step_a сравнивает с 0x802a8c (антенна последнего SLS); записей в vuc.dis */
    u16  x14;                       /* +0x14 +0x14: сравнивается с 0x802a8e (сектор последнего SLS); записей не найдено. Не литерал. */
};
_Static_assert(__builtin_offsetof(struct sls_rx_state, flags) == 0x0, "sls_rx.flags");
_Static_assert(__builtin_offsetof(struct sls_rx_state, brp_lrx) == 0xc, "sls_rx.brp_lrx");
_Static_assert(__builtin_offsetof(struct sls_rx_state, x12) == 0x12, "sls_rx.x12");
_Static_assert(__builtin_offsetof(struct sls_rx_state, x14) == 0x14, "sls_rx.x14");

/* ba_stats (0x802210). Счётчики BlockAck/окон (0x18 Б, 0x802210..0x802227): memset0 + штамп TSF в bf_metrics__reset_and_stamp; потребитель bap_ */
struct ba_stats_s {
    u32  tx_pkts;                   /* +0x00 += r53.num_of_tx_pkts (б8..14) — rx__dispatch_by_g_8005f8, rx_flow__handle_frame. UC-REGIS */
    u32  non_acked;                 /* +0x04 += r53.num_of_non_acked_pkts (б16..22). */
    u32  ba_cnt;                    /* +0x08 Число принятых BA/отчётов r53 (++ рядом с 0x802210). */
    u32  no_busy_cnt;               /* +0x0c +0xc: ++ когда окно ответа истекло без занятости (mac_prepare_txrx_window(…,2)) — rx_nav_u */
    u32  reset_tsf;                 /* +0x10 TSF момента сброса (bf_metrics__reset_and_stamp). */
    u32  active;                    /* +0x14 Флаг «был трафик/уровень>0» (=1 в rx-путях при lvl≥1); проверяется перед инкрементом счётч */
};
_Static_assert(__builtin_offsetof(struct ba_stats_s, tx_pkts) == 0x0, "ba_stats.tx_pkts");
_Static_assert(__builtin_offsetof(struct ba_stats_s, non_acked) == 0x4, "ba_stats.non_acked");
_Static_assert(__builtin_offsetof(struct ba_stats_s, ba_cnt) == 0x8, "ba_stats.ba_cnt");
_Static_assert(__builtin_offsetof(struct ba_stats_s, no_busy_cnt) == 0xc, "ba_stats.no_busy_cnt");
_Static_assert(__builtin_offsetof(struct ba_stats_s, reset_tsf) == 0x10, "ba_stats.reset_tsf");
_Static_assert(__builtin_offsetof(struct ba_stats_s, active) == 0x14, "ba_stats.active");

/* rxf (0x802288). Состояние разбора принятого кадра (0x802288..0x80229b). */
struct rx_frame_state {
    u32  sta;                       /* +0x00 Индекс станции текущего кадра (8 — неизвестна/сброс): rx_flow__*, rx_funcs__rx_flow, sls__ */
    u32  key_sta;                   /* +0x04 Станция, чей TX-ключ/вектор сейчас загружен (0xff — нет): при смене mac_load_tx_key и 0x88 */
    u32  sta_word4;                 /* +0x08 Слово +4 записи станции 0x801104+80·idx, снятое mtp_queue__release_mgmt (копия в ctx+0x2c  */
    u32  resp_type;                 /* +0x0c Тип требуемого ответа (результат rx_get_required_response: 2,3,7,8,9…; 3 → MAC 0x2000080). */
    u32  flags;                     /* +0x10 Флаги приёма: б1 ответ/NAV, б2 кадр обработан, б3 RD от известной станции ((r38&0x8800)==0 */
};
_Static_assert(__builtin_offsetof(struct rx_frame_state, sta) == 0x0, "rxf.sta");
_Static_assert(__builtin_offsetof(struct rx_frame_state, key_sta) == 0x4, "rxf.key_sta");
_Static_assert(__builtin_offsetof(struct rx_frame_state, sta_word4) == 0x8, "rxf.sta_word4");
_Static_assert(__builtin_offsetof(struct rx_frame_state, resp_type) == 0xc, "rxf.resp_type");
_Static_assert(__builtin_offsetof(struct rx_frame_state, flags) == 0x10, "rxf.flags");

/* bcn_bi (0x80229c). Счётчики BI для маяка (12 Б, 0x80229c..0x8022a7): bi_cfg__tick_counters/bi_cfg_fill_slot_desc (L_92af98) из bi_cfg; bi_c */
struct bcn_bi_state {
    u8   abft_bi_left;              /* +0x00 Обратный счёт BI до A-BFT (перезагрузка bi_cfg+4−1); 0 → A-BFT в этом BI (bti: 0x802f15 =  */
    u8   abft_idx;                  /* +0x01 Номер A-BFT по модулю bi_cfg+5. Не литерал. */
    u8   x2;                        /* +0x02 =1 в bi_cfg_fill_slot_desc; << 14 в первое слово конфигурации маяка (bi_bcon_cfg) */
    u8   next_beacon;               /* +0x03 +3 = 0 (fill_slot_desc), <<2 в слово BI Control (поле Next Beacon?) bi_cfg__pack_words_78_ */
    u8 _pad1[1];
    u8   x5_cdown;                  /* +0x05 обратный счёт с перезагрузкой bi_cfg.x8 (bi_cfg_tick_counters); 0 → бит 6 в конфигурации маяка */
    u8 _pad2[2];
    u32  bi_len_us;                 /* +0x08 +8: длительность BI/окна из txrx_api_cmd_step (a+0x18; >>10 → 0x886d64); uc_bi_counter_in_ */
};
_Static_assert(__builtin_offsetof(struct bcn_bi_state, abft_bi_left) == 0x0, "bcn_bi.abft_bi_left");
_Static_assert(__builtin_offsetof(struct bcn_bi_state, abft_idx) == 0x1, "bcn_bi.abft_idx");
_Static_assert(__builtin_offsetof(struct bcn_bi_state, next_beacon) == 0x3, "bcn_bi.next_beacon");
_Static_assert(__builtin_offsetof(struct bcn_bi_state, bi_len_us) == 0x8, "bcn_bi.bi_len_us");

/* bi_cfg (0x8022a8). Блок fui_bi_cfg_params_s (0x20 Б, копия из тела LMAC 0x0b +0x50; ucode_cmd_0x0b_handler). BEACONING.md §1 (4.1: 0x801438 */
struct fui_bi_cfg_params {
    u32  bi_mode;                   /* +0x00 bi_mode («bcon_kind»): 2 — discovery-маяк с рандомизатором (гейт 0x923cda), ≠0 — l1/bti ра */
    u8   n_bi_abft;                 /* +0x04 +4: период A-BFT в BI (перезагрузка bcn_bi[0]); <<7 в слово BI Control 2. */
    u8   abft_cnt_mod;              /* +0x05 +5: модуль счётчика A-BFT; <<17 в слово 2. */
    u8 _pad0[1];
    u8   fss;                       /* +0x07 +7: FSS (кадров SSW в слоте A-BFT, индекс таблиц 0x80165c/0x801674 → 0x802a14/0x802a18); < */
    u8   x8;                        /* +0x08 +8: период ATI/окна (bcn_bi[5]). Не литерал. */
    u8   x9;                        /* +0x09 +9: младшие биты слова 2 BI Control. */
    u8   abft_len;                  /* +0x0a +0xa: длина A-BFT (слотов−1): 0x802a1c=(v+1)·slot; <<7 в BI Control (поле A-BFT Length). */
    u8 _pad1[9];
    u32  flags;                     /* +0x14 +0x14: б0 CC present, б1 discovery, б2, б3 → биты слов BI Control (bi_cfg__pack_words_78_7 */
};
_Static_assert(__builtin_offsetof(struct fui_bi_cfg_params, bi_mode) == 0x0, "bi_cfg.bi_mode");
_Static_assert(__builtin_offsetof(struct fui_bi_cfg_params, n_bi_abft) == 0x4, "bi_cfg.n_bi_abft");
_Static_assert(__builtin_offsetof(struct fui_bi_cfg_params, abft_cnt_mod) == 0x5, "bi_cfg.abft_cnt_mod");
_Static_assert(__builtin_offsetof(struct fui_bi_cfg_params, fss) == 0x7, "bi_cfg.fss");
_Static_assert(__builtin_offsetof(struct fui_bi_cfg_params, x8) == 0x8, "bi_cfg.x8");
_Static_assert(__builtin_offsetof(struct fui_bi_cfg_params, x9) == 0x9, "bi_cfg.x9");
_Static_assert(__builtin_offsetof(struct fui_bi_cfg_params, abft_len) == 0xa, "bi_cfg.abft_len");
_Static_assert(__builtin_offsetof(struct fui_bi_cfg_params, flags) == 0x14, "bi_cfg.flags");

/* uc_stats (0x8022c8). Блок статистических счётчиков ucode (0x8c Б, 0x8022c8..0x802353): ~30 полей u32 «++» + 3 байтовых. ПРОТИВОРЕЧИЕ: UCODE-T */
struct uc_stats_s {
    u32  fsched_tx_slot;            /* +0x00 +0x00: запусков TX-слота фиксированного расписания (fixed_sched__run_tx_slot). */
    u32  txop_fail;                 /* +0x04 +0x04: TX-поток не начат/TXOP не открыт (busy при выборе сектора; tx_slot__dispatch, tx_mt */
    u32  tx_no_queue;               /* +0x08 +0x08: tx_slot__pick_queue вернул «нет очереди» (tx_slot__dispatch, tx_initiator_flow_fixe */
    u32  tx_start;                  /* +0x0c +0x0c: запусков передачи (последовательность 0x37000020…; tx__program_vector_rf, itx_tx_fr */
    u32  nav_x10;                   /* +0x10 +0x10: rx_nav_update — кадр без обновления NAV (ветка перед prep). */
    u32  macq_ppdu;                 /* +0x14 +0x14: PPDU, запущенных из MAC-очереди (mac_q__tx_ppdu/_3009/_cmd08, tx_bcast_flow, vring_ */
    u32  bcn_sweep;                 /* +0x18 +0x18: завершённых развёрток маяка BTI (bti_worker__bti_transmitter_beacon_sweep_flow). */
    u32  txop_rts_fail;             /* +0x1c +0x1c: TXOP не открыт после RTS/CTS (txop_initiator_open_txop_flow L_93a420). UC-REGISTERS */
    u32  txop_short;                /* +0x20 +0x20: мало времени REMAINING_TIME_RD ≤ 0x30 (txop_initiator_open_txop_flow L_93a440). UC- */
    u8 _pad0[4];
    u32  grant_fail;                /* +0x28 +0x28: grant_detect_step без успеха. */
    u32  dmg_cts_tx;                /* +0x2c +0x2c: отправлено DMG CTS (rx__send_dmg_cts). DATAPATH §3. */
    u32  ctrl_tx;                   /* +0x30 +0x30: отправлено управляющих кадров direct_tx__send_ctrl_frame. */
    u32  slot_grow;                 /* +0x34 +0x34: tx__pick_slot_for_peer — увеличение окна слота. */
    u32  slot_reset;                /* +0x38 +0x38: tx__pick_slot_for_peer — сброс окна слота. */
    u32  rx_arm;                    /* +0x3c +0x3c: взведений окна приёма/ожиданий ответа (rx__arm_window*, rx__ppdu_is_ack/cts*, tx__a */
    u32  rx_ppdu;                   /* +0x40 +0x40: принятых PPDU с совпавшим seq (rx_flow__run; зеркало 0x853924); power_mngr__stats_c */
    u32  rx_type_err;               /* +0x44 +0x44: rx_flow__run — тип ≠2 после ожидания. Не литерал. */
    u32  rx_not_ready;              /* +0x48 +0x48: rx_flow__run — нет условий (st==0 или r55≥288). Не литерал. */
    u32  rx_no_frame;               /* +0x4c +0x4c: rx_flow__run — кадр не пришёл. Не литерал. */
    u32  rx_cnt[4];                 /* +0x50 счётчики вида кадра (rx_flow_run): [0] — прочее, [1]/[2] — rx_mode_flags б1 и 0x8025d8 б1 = 0/1,
                                       [3] — 0x8025d8 б0; зеркала 0x853800 + 4·(75, 77, 79, 76) */
    u32  rx_bcn_resp;               /* +0x60 +0x60: rx_flow__handle_frame, ветка маяка/SSW с ответом (0x5f8|=1<<24). */
    u32  nav_dts;                   /* +0x64 +0x64: обновлений NAV по DTS (r37.mmWaveDTS, rx_nav_update). */
    u32  rx_x68;                    /* +0x68 +0x68: rx_flow__handle_frame — кадр сети вне фазы (0x5f8|=1<<10). */
    u32  ssw_drop_role;             /* +0x6c +0x6c: SSW отброшен, роль [gp+0xcc] б3=0 (sls__rx_ssw_frame). BF-ENGINE §8.1. */
    u32  rts_rx;                    /* +0x70 +0x70: принят RTS → нужен CTS (rx_get_required_response), зеркало 0x85702c. */
    u32  ppdu_resp;                 /* +0x74 +0x74: rx_funcs__handle_ppdu_report — отправлен ответ. Не литерал. */
    u32  grant_rx;                  /* +0x78 +0x78: принят Grant (r37 б10) — rx_get_required_response, ответ 9. */
    u32  cfg1_rx;                   /* +0x7c +0x7c: r37.cfg1 (б17) → brp_split_id. */
    u32  ra_known;                  /* +0x80 +0x80: rx_flow__handle_frame — no-ack mgmt (0x33) с RA=свой, станция найдена; ВНИМАНИЕ: br */
    u32  ra_unknown;                /* +0x84 +0x84: то же, станция не найдена. Не литерал. */
    u8   brp_rx_txn;                /* +0x88 +0x88 (байт): BRP-кадров в brp_initiator_brp_transaction_flow. Не литерал (база 0x802348). */
    u8 _pad2[1];
    u8   brp_rx_req;                /* +0x8a +0x8a (байт): BRP-кадров в brp_init__exchange_request. */
    u8   brp_rx;                    /* +0x8b +0x8b (байт): BRP-кадров в rx_flow__handle_frame. */
};
_Static_assert(__builtin_offsetof(struct uc_stats_s, fsched_tx_slot) == 0x0, "uc_stats.fsched_tx_slot");
_Static_assert(__builtin_offsetof(struct uc_stats_s, txop_fail) == 0x4, "uc_stats.txop_fail");
_Static_assert(__builtin_offsetof(struct uc_stats_s, tx_no_queue) == 0x8, "uc_stats.tx_no_queue");
_Static_assert(__builtin_offsetof(struct uc_stats_s, tx_start) == 0xc, "uc_stats.tx_start");
_Static_assert(__builtin_offsetof(struct uc_stats_s, nav_x10) == 0x10, "uc_stats.nav_x10");
_Static_assert(__builtin_offsetof(struct uc_stats_s, macq_ppdu) == 0x14, "uc_stats.macq_ppdu");
_Static_assert(__builtin_offsetof(struct uc_stats_s, bcn_sweep) == 0x18, "uc_stats.bcn_sweep");
_Static_assert(__builtin_offsetof(struct uc_stats_s, txop_rts_fail) == 0x1c, "uc_stats.txop_rts_fail");
_Static_assert(__builtin_offsetof(struct uc_stats_s, txop_short) == 0x20, "uc_stats.txop_short");
_Static_assert(__builtin_offsetof(struct uc_stats_s, grant_fail) == 0x28, "uc_stats.grant_fail");
_Static_assert(__builtin_offsetof(struct uc_stats_s, dmg_cts_tx) == 0x2c, "uc_stats.dmg_cts_tx");
_Static_assert(__builtin_offsetof(struct uc_stats_s, ctrl_tx) == 0x30, "uc_stats.ctrl_tx");
_Static_assert(__builtin_offsetof(struct uc_stats_s, slot_grow) == 0x34, "uc_stats.slot_grow");
_Static_assert(__builtin_offsetof(struct uc_stats_s, slot_reset) == 0x38, "uc_stats.slot_reset");
_Static_assert(__builtin_offsetof(struct uc_stats_s, rx_arm) == 0x3c, "uc_stats.rx_arm");
_Static_assert(__builtin_offsetof(struct uc_stats_s, rx_ppdu) == 0x40, "uc_stats.rx_ppdu");
_Static_assert(__builtin_offsetof(struct uc_stats_s, rx_type_err) == 0x44, "uc_stats.rx_type_err");
_Static_assert(__builtin_offsetof(struct uc_stats_s, rx_not_ready) == 0x48, "uc_stats.rx_not_ready");
_Static_assert(__builtin_offsetof(struct uc_stats_s, rx_no_frame) == 0x4c, "uc_stats.rx_no_frame");
_Static_assert(__builtin_offsetof(struct uc_stats_s, rx_cnt) == 0x50, "uc_stats.rx_cnt");
_Static_assert(__builtin_offsetof(struct uc_stats_s, rx_bcn_resp) == 0x60, "uc_stats.rx_bcn_resp");
_Static_assert(__builtin_offsetof(struct uc_stats_s, nav_dts) == 0x64, "uc_stats.nav_dts");
_Static_assert(__builtin_offsetof(struct uc_stats_s, rx_x68) == 0x68, "uc_stats.rx_x68");
_Static_assert(__builtin_offsetof(struct uc_stats_s, ssw_drop_role) == 0x6c, "uc_stats.ssw_drop_role");
_Static_assert(__builtin_offsetof(struct uc_stats_s, rts_rx) == 0x70, "uc_stats.rts_rx");
_Static_assert(__builtin_offsetof(struct uc_stats_s, ppdu_resp) == 0x74, "uc_stats.ppdu_resp");
_Static_assert(__builtin_offsetof(struct uc_stats_s, grant_rx) == 0x78, "uc_stats.grant_rx");
_Static_assert(__builtin_offsetof(struct uc_stats_s, cfg1_rx) == 0x7c, "uc_stats.cfg1_rx");
_Static_assert(__builtin_offsetof(struct uc_stats_s, ra_known) == 0x80, "uc_stats.ra_known");
_Static_assert(__builtin_offsetof(struct uc_stats_s, ra_unknown) == 0x84, "uc_stats.ra_unknown");
_Static_assert(__builtin_offsetof(struct uc_stats_s, brp_rx_txn) == 0x88, "uc_stats.brp_rx_txn");
_Static_assert(__builtin_offsetof(struct uc_stats_s, brp_rx_req) == 0x8a, "uc_stats.brp_rx_req");
_Static_assert(__builtin_offsetof(struct uc_stats_s, brp_rx) == 0x8b, "uc_stats.brp_rx");

/* txr (0x80242c). Счётчики/флаг обмена кадр→ответ (0x80242c..0x802437, u16). ПРОТИВОРЕЧИЕ: UCODE-TASKS §3.2 связывает 0x80242c с fw stream */
struct tx_resp_stats {
    u16  imm_resp;                  /* +0x00 +0: немедленных ответов (rx_flow__send_imm_response). */
    u16  submit;                    /* +0x02 +2: кадров, поданных tx__send_and_await_rx_frame. */
    u16  rx_wait;                   /* +0x04 +4: окон ожидания ответа (tx__send_and_await_rx_frame). */
    u16  cf_end_rx;                 /* +0x06 +6: принят CF-End с нулевой длительностью (rx_get_required_response, r37 б16). */
    u16  awaiting;                  /* +0x08 +8: флаг «ждём ответ/канал занят» (=0/1 в tx__send_and_await_rx_frame, tx_initiator_flow_f */
};
_Static_assert(__builtin_offsetof(struct tx_resp_stats, imm_resp) == 0x0, "txr.imm_resp");
_Static_assert(__builtin_offsetof(struct tx_resp_stats, submit) == 0x2, "txr.submit");
_Static_assert(__builtin_offsetof(struct tx_resp_stats, rx_wait) == 0x4, "txr.rx_wait");
_Static_assert(__builtin_offsetof(struct tx_resp_stats, cf_end_rx) == 0x6, "txr.cf_end_rx");
_Static_assert(__builtin_offsetof(struct tx_resp_stats, awaiting) == 0x8, "txr.awaiting");


/* uc_mbox (0x802470). Почтовый ящик fw↔uc, 0x48 Б: кольцо событий uc→fw и кольцо команд LMAC fw→uc.
 * Формат колец — как у почтового ящика хост↔fw драйвера wil6210 (wil6210_mbox_ring / _ring_desc /
 * _hdr): fw описывает кольцо структурой mbox_ring_ctl в своей памяти (uc_mailbox_init_rings берёт
 * их по указателю из 0x8802bc+0x24), записи кольца — пары {sync, addr}, addr — запись с заголовком
 * 16 Б (uc_evt_hdr), тело — за ним. */
struct mbox_ring_desc {
    u32  sync;                          /* != 0 — запись заполнена (для читателя) */
    u32  addr;                          /* адрес записи: заголовок uc_evt_hdr + тело */
};
struct mbox_ring_ctl {                  /* в памяти fw */
    u32  base;                          /* +0 массив mbox_ring_desc */
    u16  entry_size;                    /* +4 предел тела записи */
    u16  size;                          /* +6 размер массива, Б */
    u32  tail;                          /* +8 читатель */
    u32  head;                          /* +0xc писатель */
};
struct uc_ring {
    struct mbox_ring_desc *cur;         /* +0 текущая запись (писатель — следующая свободная, читатель — следующая к разбору) */
    struct mbox_ring_desc *base;        /* +4 */
    struct mbox_ring_desc *end;         /* +8 base + ctl->size */
    struct mbox_ring_ctl *ctl;          /* +0xc */
    u32  arg_e;                         /* +0x10 uc_ring_init_desc: аргумент 5 (у обоих колец 0) */
    u32  arg_g;                         /* +0x14 аргумент 7 (0) */
    u32  _18, _1c;                      /* обнуляются при инициализации */
};
_Static_assert(sizeof(struct uc_ring) == 0x20, "uc_ring");
/* Тело события 0x2c (PMC: начало/конец записи, handle_pmc_triggers → uc_evt_send_2c_tsf), 0x10 Б. */
struct uc_evt_pmc {
    u32  stop;                          /* 0x00 0 — запись начата, 1 — остановлена */
    u32  tag;                           /* 0x04 pmc_trig.tag */
    u32  tsf;                           /* 0x08 TSF (мл.) */
    u32  n_events;                      /* 0x0c pmc_trig.event_cnt (при остановке) */
};
_Static_assert(sizeof(struct uc_evt_pmc) == 0x10, "uc_evt_pmc");

struct uc_evt_hdr {                     /* wil6210_mbox_hdr (8 Б) + wmi_cmd_hdr (8 Б) */
    u16  seq;                           /* +0 */
    u16  len;                           /* +2 длина тела */
    u16  type;                          /* +4 код события uc */
    u8   flags;                         /* +6 б1..б3 — аргументы c, d, e uc_evt_queue_put */
    u8   len_lo;                        /* +7 младший байт len */
    u8   mid;                           /* +8 */
    u8   _9;
    u16  cmd_id;                        /* +0xa */
    u32  ts;                            /* +0xc 0 */
};
_Static_assert(sizeof(struct uc_evt_hdr) == 0x10, "uc_evt_hdr");
struct cmdq_handler_desc;
struct uc_mbox_ctx {
    u16  evt_seq;                       /* +0x00 номер следующего события */
    u16 _pad0;
    struct uc_ring evt;                 /* +0x04 события uc → fw */
    struct uc_ring cmd;                 /* +0x24 команды fw → uc */
    struct cmdq_handler_desc *cmd_desc;         /* +0x44 = &cmdq_desc (uc_init_cb_cmdq): обработчик команд — поле +4 */
};
_Static_assert(sizeof(struct uc_mbox_ctx) == 0x48, "uc_mbox_ctx");


/* agc_cfg (0x8025dc). Копия 0x20 Б тела LMAC 0x11 (6.2: AGC-старт/таблица усиления, silent_rssi__report_agc_tables), 0x8025dc..0x8025fb. */
struct agc_cfg_s {
    u32  agc_start;                 /* +0x00 старт AGC (0x88306c на время замера SNR; rx_mode_configure при r18 == 0), слово в событии */
    u32  agc_start_b;               /* +0x04 старт AGC для остальных веток rx_mode_configure */
    u32  gain_arr;                  /* +0x08 массив усиления в паре с agc_start (hwd_phy_rx_set_agc_start_val_and_gain_array_uc) */
    u32  gain_arr_b;                /* +0x0c в паре с agc_start_b */
    u8   gain_lo_ofs[8];            /* +0x10 по RF: поправка младшего ниббла усиления (rf_gain_adjust_cb, итог 1..15) */
    u8   gain_hi_ofs[8];            /* +0x18 по RF: поправка старшего ниббла */
};
_Static_assert(sizeof(struct agc_cfg_s) == 0x20, "agc_cfg_s");
_Static_assert(__builtin_offsetof(struct agc_cfg_s, gain_arr) == 0x8, "agc_cfg.gain_arr");
_Static_assert(__builtin_offsetof(struct agc_cfg_s, gain_lo_ofs) == 0x10, "agc_cfg.gain_lo_ofs");

/* ifs (0x802968). Пары {такты, мкс} (по 2 байта, mac_clk__div165) для регистров IFS: txrx_api_step_b_uc. 0x802968..0x802975. */
struct ifs_timing {
    u16  sifs;                      /* +0x00 +0: SIFS {clk,us} → 0x886d00|0x1730000 (mac_ifs_restore_sifs, после SLS обратно сюда). */
    u16  slot;                      /* +0x02 +2: slot {clk,us} → 0x886d04. */
    u16  pifs;                      /* +0x04 +4: SIFS+slot → 0x886d08 lo. Не литерал. */
    u16  two_slot;                  /* +0x06 +6: 2·slot → 0x886d08 hi. Не литерал. */
    u16  c3;                        /* +0x08 +8: ifs_cfg[3] → 0x886d0c lo. Не литерал. */
    u16  c4;                        /* +0x0a +0xa: ifs_cfg[4] → 0x886d0c hi. Не литерал. */
    u16  mbifs;                     /* +0x0c +0xc: 3·SIFS (MBIFS) — пишется в 0x886d00 на время SLS (txss_init__flow, sls__rx_ssw_frame */
};
_Static_assert(__builtin_offsetof(struct ifs_timing, sifs) == 0x0, "ifs.sifs");
_Static_assert(__builtin_offsetof(struct ifs_timing, slot) == 0x2, "ifs.slot");
_Static_assert(__builtin_offsetof(struct ifs_timing, pifs) == 0x4, "ifs.pifs");
_Static_assert(__builtin_offsetof(struct ifs_timing, two_slot) == 0x6, "ifs.two_slot");
_Static_assert(__builtin_offsetof(struct ifs_timing, c3) == 0x8, "ifs.c3");
_Static_assert(__builtin_offsetof(struct ifs_timing, c4) == 0xa, "ifs.c4");
_Static_assert(__builtin_offsetof(struct ifs_timing, mbifs) == 0xc, "ifs.mbifs");

/* bti_sw (0x802a14). Параметры развёртки маяка/A-BFT (0x58 Б, 0x802a14..0x802a6b; memset0 в bti__reset_sweep_state). */
struct bti_sweep_cfg {
    u32  ssw_slot_a;                /* +0x00 +0: из таблицы 0x80165c[fss] (cmd 0x0b); +0xa5 → GP-таймер 0x50 в BTI. */
    u32  ssw_slot_b;                /* +0x04 +4: 0x801674[fss] — длительность слота A-BFT (тактов); MAC 0x51000000|v. */
    u32  abft_dur;                  /* +0x08 +8: (abft_len+1)·slot_b — длительность A-BFT; +0x1ef → GP 0x4f. */
    struct ss_cfg_s bcn_ss;         /* +0x0c план секторов развёртки маяка (LMAC 0x0b/0x0c, WMI txss_set_sectors) */
};
_Static_assert(sizeof(struct bti_sweep_cfg) == 0x58, "bti_sweep_cfg");
_Static_assert(__builtin_offsetof(struct bti_sweep_cfg, ssw_slot_a) == 0x0, "bti_sw.ssw_slot_a");
_Static_assert(__builtin_offsetof(struct bti_sweep_cfg, ssw_slot_b) == 0x4, "bti_sw.ssw_slot_b");
_Static_assert(__builtin_offsetof(struct bti_sweep_cfg, abft_dur) == 0x8, "bti_sw.abft_dur");

/* bti_cnt (0x802a6c). Счётчики развёртки (0x24 Б, 0x802a6c..0x802a8f; memset0 в bti__clear_sweep_counters). */
struct bti_sweep_cnt {
    u32  rounds;                    /* +0x00 +0: раундов развёртки (bti__count_sweep_round). */
    u32  x04;                       /* +0x04 vendor не использовал; стандартный A-BFT станции: итог взвода GP0 в
                                       bti_bi2_event_step (1 вовремя, 2 поздно, 0 не взводился) для bti_transmitter_bi2_flow */
    u32  net_bcn_rx;                /* +0x08 +8: принято маяков/SSW сети (rx_flow__handle_frame, r36 б7). Не литерал. */
    u32  bi2_tsf;                   /* +0x0c +0xc: TSF события BI2 (bti__bi2_event_step). */
    u32  cid[4];                    /* +0x10 счётчики по CID: [0], [1] — сбрасываются при смене лучшего сектора (bi_manager_step_a),
                                       [1] ++ без смены, [2] ++ на раунд (bti_count_sweep_round), [3]; bti_clear_cid_sweep_counters */
    u16  last_ant;                  /* +0x20 +0x20: антенна лучшего сектора последнего SLS (= 0x80212d; txss_init__flow, txss_resp__wai */
    u16  last_sector;               /* +0x22 +0x22: сектор (= 0x80212c). */
};
_Static_assert(__builtin_offsetof(struct bti_sweep_cnt, rounds) == 0x0, "bti_cnt.rounds");
_Static_assert(__builtin_offsetof(struct bti_sweep_cnt, net_bcn_rx) == 0x8, "bti_cnt.net_bcn_rx");
_Static_assert(__builtin_offsetof(struct bti_sweep_cnt, bi2_tsf) == 0xc, "bti_cnt.bi2_tsf");
_Static_assert(__builtin_offsetof(struct bti_sweep_cnt, cid) == 0x10, "bti_cnt.cid");
_Static_assert(__builtin_offsetof(struct bti_sweep_cnt, last_ant) == 0x20, "bti_cnt.last_ant");
_Static_assert(__builtin_offsetof(struct bti_sweep_cnt, last_sector) == 0x22, "bti_cnt.last_sector");

/* itx (0x802aa0). Состояние internal TX (0x4c Б, 0x802aa0..0x802aeb). */
struct itx_state {
    u32  abif_overridden;           /* +0x00 +0: 1 — ABIF переопределён на время обмена (internal_tx__flow_sm4); базой r19 vendor адрес */
    u32  rx_pending;                /* +0x04 +4: 1 — принят кадр (CTS/ACK) → перед выходом rx_mac_prepare (itx__wait_ack_rf/cts_rf). */
    u32  ack_timeout;               /* +0x08 +8: таймаутов ожидания ACK (itx__wait_ack_rf, r54 б6). */
    u32  phy_regs[16];              /* +0x0c снимок PHY 0x883844.. (phy_read_regs_883844) в internal_tx_flow_sm4 */
};
_Static_assert(sizeof(struct itx_state) == 0x4c, "itx_state");
_Static_assert(__builtin_offsetof(struct itx_state, abif_overridden) == 0x0, "itx.abif_overridden");
_Static_assert(__builtin_offsetof(struct itx_state, rx_pending) == 0x4, "itx.rx_pending");
_Static_assert(__builtin_offsetof(struct itx_state, ack_timeout) == 0x8, "itx.ack_timeout");

/* bcast (0x802eac). Счётчики широковещательного потока tx_bcast_flow (0x802eac..0x802ebf). */
struct bcast_stats {
    u8   cca_fail;                  /* +0x00 +0: занят эфир (CCA) — отказ. */
    u8   done;                      /* +0x01 +1: поток завершён. Не литерал. */
    u8   tx_end;                    /* +0x02 +2: конец передачи. Не литерал. */
    u8   tx1;                       /* +0x03 +3: первая передача. Не литерал. */
    u8   tx2;                       /* +0x04 +4: вторая передача. Не литерал. */
    u8 _pad0[7];
    u32  x0c;                       /* +0x0c +0xc (r13[3]). Не литерал. */
    u32  rx_sector;                 /* +0x10 +0x10: сектор окна приёма (<<8 в mac_program_rx_window). Не литерал. */
};
_Static_assert(__builtin_offsetof(struct bcast_stats, cca_fail) == 0x0, "bcast.cca_fail");
_Static_assert(__builtin_offsetof(struct bcast_stats, done) == 0x1, "bcast.done");
_Static_assert(__builtin_offsetof(struct bcast_stats, tx_end) == 0x2, "bcast.tx_end");
_Static_assert(__builtin_offsetof(struct bcast_stats, tx1) == 0x3, "bcast.tx1");
_Static_assert(__builtin_offsetof(struct bcast_stats, tx2) == 0x4, "bcast.tx2");
_Static_assert(__builtin_offsetof(struct bcast_stats, x0c) == 0xc, "bcast.x0c");
_Static_assert(__builtin_offsetof(struct bcast_stats, rx_sector) == 0x10, "bcast.rx_sector");

/* bi_win (0x802ec0). Блок счётчиков окон BI и тайминга BI (0x802ec0..0x802f13). Счётчики — по действиям автомата bi_sm (таблица 0x8015dc: соб */
struct bi_win_ctx {
    u16  tbtt_cnt;                  /* +0x00 +0: TBTT/bi1_event (l1_task__main_step, l1_task_step_fixed_sched). UCODE-TASKS §2 («счётчи */
    u16  bi2_cnt;                   /* +0x02 +2: событий BI2 (bti__bi2_event_step). */
    u16  dti_to_bti;                /* +0x04 +4: DTI_TO_BTI (bi_sm__action_935b4c). */
    u16  bti_to_abft;               /* +0x06 +6: BTI_TO_ABFT (935a08). */
    u16  to_dti;                    /* +0x08 +8: BHI_TO_DTI и AW_TO_DTI из AW (935d0c). */
    u16  bhi_to_aw;                 /* +0x0a +0xa: BHI_TO_AW (935a94; взводит DTI-объект 0x802f44). */
    u16  aw_to_dti_in_bti;          /* +0x0c +0xc: AW_TO_DTI в состоянии BTI (923a5c, маркер 0xcaf440). */
    u16  evt_in_dti;                /* +0x0e +0xe: события 1..4 в состоянии DTI (9262e8, маркер 0xcaf550). */
    u16  evt_in_aw;                 /* +0x10 +0x10: DTI_TO_BTI/BHI_TO_DTI/BHI_TO_AW в состоянии AW (92156c/53c/50c, маркеры 0xcaf660..6 */
    u8   state;                     /* +0x12 +0x12: текущее окно (0 BTI, 1 ABFT, 2 DTI, 3 AW); пишут 4 «настоящих» действия. */
    u8 _pad0[1];
    u16  dti_to_bti_in_aw;          /* +0x14 +0x14: DTI_TO_BTI в AW (92156c). */
    u8 _pad1[2];
    u32  bti_tsf[2];                /* +0x18 TSF64 начала BTI (bi_timing_snapshot_b) */
    u32  bi_len_us;                 /* +0x20 длина последнего BI: TSF − bti_tsf (bi_tsf_delta64, мл. слово) */
    u32  bi_short_cnt;              /* +0x24 BI < 92,4 мс (0x168f0) */
    u32  bi_long_cnt;               /* +0x28 BI > 112,4 мс (0x1b710) */
    u32  bi_len_min;                /* +0x2c минимум (сброс в ~0 до первого BI) */
    u32  bi_len_max;                /* +0x30 максимум */
    u32  bti_pos;                   /* +0x34 позиция в BI на старте BTI (r40 & 0x3ffffff) */
    u32  bti_seen;                  /* +0x38 =1 после первого BTI (с него считаются длины) */
    u32  aw_tsf[2];                 /* +0x3c TSF64 конца BTI/старта окна (l1_snapshot_bi_counter) */
    u32  delta_lo;                  /* +0x44 +0x44: младшее слово дельты (mac_prog__cmd02_body). Не литерал. */
    u32  x48;                       /* +0x48 +0x48: счётчик (mac_prog__cmd02_body). Не литерал. */
    u32  x4c;                       /* +0x4c +0x4c (mac_prog__cmd02_body). Не литерал. */
};
_Static_assert(__builtin_offsetof(struct bi_win_ctx, tbtt_cnt) == 0x0, "bi_win.tbtt_cnt");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, bi2_cnt) == 0x2, "bi_win.bi2_cnt");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, dti_to_bti) == 0x4, "bi_win.dti_to_bti");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, bti_to_abft) == 0x6, "bi_win.bti_to_abft");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, to_dti) == 0x8, "bi_win.to_dti");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, bhi_to_aw) == 0xa, "bi_win.bhi_to_aw");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, aw_to_dti_in_bti) == 0xc, "bi_win.aw_to_dti_in_bti");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, evt_in_dti) == 0xe, "bi_win.evt_in_dti");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, evt_in_aw) == 0x10, "bi_win.evt_in_aw");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, state) == 0x12, "bi_win.state");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, dti_to_bti_in_aw) == 0x14, "bi_win.dti_to_bti_in_aw");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, bti_tsf) == 0x18, "bi_win.bti_tsf");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, bi_len_us) == 0x20, "bi_win.bi_len_us");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, bti_seen) == 0x38, "bi_win.bti_seen");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, aw_tsf) == 0x3c, "bi_win.aw_tsf");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, delta_lo) == 0x44, "bi_win.delta_lo");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, x48) == 0x48, "bi_win.x48");
_Static_assert(__builtin_offsetof(struct bi_win_ctx, x4c) == 0x4c, "bi_win.x4c");

/* abft_cfg (0x803124). Конфигурация ответчика A-BFT из LMAC 0x23 (ucode_cmd__load_table_803124_803128 0x920b1c: 3 слова → +4/+8/+0xc, счётчик=0 */
struct abft_resp_cfg {
    u16  relax_cnt;                 /* +0x00 Рабочий счётчик relaxation (декремент на пропущенный маяк, перезаряжается из relaxation_pe */
    u8 _pad0[2];
    u32  responder_mode;            /* +0x04 0 UNASSOCIATED_ONLY, 1 ASSOCIATED_ONLY, 2 ALWAYS, 3 DISABLED (MAC-COMMANDS §…). */
    u32  beacon_type;               /* +0x08 0 NOT_DISCOVERY, 1 DISCOVERY, ≥2 ALL (сверяется с битом discovery BI Control). */
    u32  relax_period;              /* +0x0c relaxation_period (читается как u16). */
};
_Static_assert(__builtin_offsetof(struct abft_resp_cfg, relax_cnt) == 0x0, "abft_cfg.relax_cnt");
_Static_assert(__builtin_offsetof(struct abft_resp_cfg, responder_mode) == 0x4, "abft_cfg.responder_mode");
_Static_assert(__builtin_offsetof(struct abft_resp_cfg, beacon_type) == 0x8, "abft_cfg.beacon_type");
_Static_assert(__builtin_offsetof(struct abft_resp_cfg, relax_period) == 0xc, "abft_cfg.relax_period");

/* rx_meas (0x803134). Контекст измерительных запросов/захвата кадров (LMAC 0x28/0x29/0x2a/0x2b/0x2e/0x2f/0x37/0x38/0x3c/0x3d — ucode_cmd_dispa */
/* Вид запроса (LMAC запуск / съём → событие fw): */
#define RX_MEAS_ENERGY   1              /* 0x28 / 0x29 → SYSAPI_ENERGY_STATISTICS_READY (0x20): отсчёты */
#define RX_MEAS_PLCP     2              /* 0x2a / 0x2b → SYSAPI_ENERGY_PLCP_HEADER_READY (0x21): 0x8830ec */
#define RX_MEAS_PKT      3              /* 0x2e / 0x2f → SYSAPI_GET_RX_PKT_DATA (0x23): кадр */
#define RX_MEAS_PHYSTAT  4              /* 0x37 / 0x38 → 0x26: статистика PHY в 0x8576ac */
#define RX_MEAS_CHEST    5              /* 0x3c / 0x3d → SYSAPI_CHANNEL_ESTIMATION (0x2b): снимок r40 */
struct rx_meas_filter {                 /* 0xff — любое значение */
    u8   cid;                           /* r38 [10:8] при б11, иначе 8 */
    u8   mode;                          /* rx_capture_defaults_mode */
    u8   no_mcs;                        /* MCS == 0 */
    u8   mcs;                           /* r38 [24:20] */
    u8   rx_mode;                       /* rx_mode_flags б0 */
};
struct rx_meas_ctx {
    u32  kind;                          /* +0x00 RX_MEAS_* */
    u32  busy;                          /* +0x04 */
    u32  done;                          /* +0x08 busy && !done — запрос занят (ucode_cmd_28_apply) */
    union {                             /* +0x0c 2 — ждёт кадра, 1 — снят */
        u32  state;
        u8   state_b;                   /* младший байт — статус в событиях 0x20/0x21/0x23/0x2b */
    };
    u32  tsf[2];                        /* +0x10 TSF64 запуска */
    u32  snap_sel5;                     /* +0x18 r40 при селекторе 0x5000 */
    u32  snap_sel6;                     /* +0x1c r40 при селекторе 0x6000 */
    u32  report_cb;                     /* +0x20 отчёт fw (bg_task_call_cb20), адрес vendor */
    struct rx_meas_filter filt;         /* +0x24 условие захвата */
    struct rx_meas_filter got;          /* +0x29 значения совпавшего кадра */
    u8 _pad0[2];
    struct {                            /* +0x30 RX_MEAS_PKT (обнуляет LMAC 0x2e, 0x24 Б) */
        u32  sel5;                      /* +0x30 r40 / 0x5000 */
        u32  sel6;                      /* +0x34 r40 / 0x6000 */
        u32  sample;                    /* +0x38 rx_meas_read_sample */
        u32  plcp_hi;                   /* +0x3c 0x8830ec [22:5] */
        s32  r8837dc;                   /* +0x40 */
        s32  r8837d8;                   /* +0x44 */
        u32  r88306c;                   /* +0x48 & 0x3f */
        u32  rf_byte;                   /* +0x4c 0x80141c[активный RF] */
        u8   sector;                    /* +0x50 */
        u8   cid;                       /* +0x51 */
        u8   plcp_lo;                   /* +0x52 0x8830ec [4:0] */
        u8   state;                     /* +0x53 копия state_b (bf_req_claim_and_report_23) */
    } pkt;
    u32  plcp;                          /* +0x54 RX_MEAS_PLCP: 0x8830ec */
    u32  n;                             /* +0x58 RX_MEAS_ENERGY: отсчётов */
    u32  sample[20];                    /* +0x5c */
    u32  sample_88306c[20];             /* +0xac */
    u32  n_max;                         /* +0xfc ≤ 20 */
};
_Static_assert(sizeof(struct rx_meas_filter) == 5, "rx_meas_filter");
_Static_assert(__builtin_offsetof(struct rx_meas_ctx, state_b) == 0x0c, "rx_meas.state_b");
_Static_assert(__builtin_offsetof(struct rx_meas_ctx, filt) == 0x24, "rx_meas.filt");
_Static_assert(__builtin_offsetof(struct rx_meas_ctx, pkt.state) == 0x53, "rx_meas.pkt.state");
_Static_assert(__builtin_offsetof(struct rx_meas_ctx, n) == 0x58, "rx_meas.n");
_Static_assert(__builtin_offsetof(struct rx_meas_ctx, sample_88306c) == 0xac, "rx_meas.sample_88306c");
_Static_assert(__builtin_offsetof(struct rx_meas_ctx, got) == 0x29, "rx_meas.got");
_Static_assert(__builtin_offsetof(struct rx_meas_ctx, pkt) == 0x30, "rx_meas.pkt");
_Static_assert(__builtin_offsetof(struct rx_meas_ctx, plcp) == 0x54, "rx_meas.plcp");
_Static_assert(__builtin_offsetof(struct rx_meas_ctx, sample) == 0x5c, "rx_meas.sample");
_Static_assert(sizeof(struct rx_meas_ctx) == 0x100, "rx_meas");

/* uc_log (0x803234). Журнал ucode: верх BSS (обнуление 0x801be8..0x803234 в uc_main не трогает его). uc_log__init_ring пишет MMIO 0x880008 =  */
struct uc_log_s {
    u32  wr_idx;                    /* +0x00 +0: индекс записи в словах (кольцо 256 слов, индекс &0xff), +2/+N на запись. */
    u8   lvl_mask[16];              /* +0x04 по уровню (lvl & 0xf): биты разрешённых подуровней ((lvl >> 4) & 3); init 7 */
    u32  ring[256];                 /* +0x14 кольцо записей: заголовок 0xa4…|len<<18|token, TSF, аргументы */
};
_Static_assert(sizeof(struct uc_log_s) == 0x414, "uc_log_s");
_Static_assert(__builtin_offsetof(struct uc_log_s, wr_idx) == 0x0, "uc_log.wr_idx");

/* link_stat (0x857e38, общая память с fw): запись связи по станциям, [8] × 0x14 Б (обнуляет bf.c блоком 0xa0).
 * Читает и fw. Доступы ucode в основном volatile (VOL()), часть — обычные, как у vendor. DATAPATH.md §3, §7. */
struct link_stat_s {
    u16  ka_sent;                       /* +0x00 keep-alive отправлено (internal_tx_flow_sm2) */
    u16  ka_ok;                         /* +0x02 keep-alive подтверждено; обнуляет link_stat_reset_ka (uutil) */
    u8   x4;                            /* +0x04 ≠ 0 (или x5) — станция в обмене: idle только при ka_ok ≥ bg_bi_thr_b */
    u8   x5;                            /* +0x05 */
    u8   ka_bf_trig;                    /* +0x06 срабатываний порога ka_fail (bf_ctrl.ctrl_code_tx) */
    u8   ka_fail;                       /* +0x07 KA не отправлен (нет окна); ≥ порога → причина BF б5 */
    u8   ka_noack;                      /* +0x08 KA без ACK */
    u8   ka_cca_busy;                   /* +0x09 KA: эфир занят (CCA) */
    u8 _pad0[2];
    u32  stamp_tsf;                     /* +0x0c TSF сброса счётчиков KA */
    u8   cts_fail;                      /* +0x10 неудач CTS в TXOP подряд; ≥ порога → причина BF б2 (MAX_CTS_FAILURE_IN_TXOP) */
    u8   bf_reasons;                    /* +0x11 причины BF (б0..б6; б6 — смысл неизвестен, DATAPATH.md §7), handle_bf_triggers */
    u8 _ps_cut_upm[2];                  /* +0x12 счётчики UPM (sm6) — PS вырезан */
};
_Static_assert(sizeof(struct link_stat_s) == 0x14, "link_stat_s");
_Static_assert(__builtin_offsetof(struct link_stat_s, stamp_tsf) == 0xc, "link_stat.stamp_tsf");
_Static_assert(__builtin_offsetof(struct link_stat_s, bf_reasons) == 0x11, "link_stat.bf_reasons");


/* Кольцо журнала MAC-команд 0x800000..0x8003ff (1 КБ): uc_mac_cmd пишет по r25. Макрос (константа —
 * gcc собирает её короче limm); то же имя — символ uc/uc.ld для uc/start.S. */
#define mac_cmd_log                  ((u32 *)0x800000)

#ifndef UC_DCCM_OBJECTS
#define rx_buf_bcn_bi_ctrl0          (*(u8 *)0x804027)    /* [в] +0x17: у маяка — байт 0 BI Control (bti: bcn_rx.bi_ctrl[0]). */
#define sta_tab                      ((struct sta_entry *)0x801104)
#define link_stat                    ((struct link_stat_s *)0x857e38)   /* [8] общая память с fw */
#define fwsh_sls_rank                ((volatile u8 (*)[0x3c])0x857c1c)   /* [9] рейтинг секторов SLS по станции (5 × sector_rec; txss_store_sector_ranking b = 0) */
#define fwsh_sls_rank_b1             ((volatile u8 (*)[0x3c])0x857a00)   /* [9] вторая таблица (txss_store_sector_ranking b = 1 — в uc не вызывается); [0] — в отчёте notify_aoa */
#define bcn_rx                       (*(struct bcn_rx_s *)0x802f14)
#define bi_ctx                       (*(struct bi_ctx_s *)0x802f44)
#define sls_cand                     (*(struct sector_rec *)0x8021f8)   /* сектор последнего кадра развёртки — кандидат в sls.top */
#define sls_meas                     (*(struct sector_rec *)0x802204)   /* текущее измерение (phy_params_snapshot, rx_flow_measure_snr_select_best) */
#define qid_cfg                      ((struct qid_cfg_s *)0x802228)
#define qset_slot                    ((struct qset_slot_s *)0x8015a4)
#define bcast_ctx                    (*(struct tx_ctx_s *)0x802b10)   /* TX-контекст широковещания/маяка */
#define init_desc_cmdq               (*(struct init_desc *)0x8013e8)
#define init_desc_801aec             (*(struct init_desc *)0x801640)
#define init_desc_more               (*(struct init_desc *)0x8016e0)
#define brp_rank                     ((struct brp_rank_ent (*)[32])0x801c94)   /* [8 RF][32] {metric, idx} по убыванию */
#define brp_trn_metric               ((u8 (*)[32])0x801ef4)   /* [8 RF][32] метрика TRN-подполя ((r40[23:14] + 2) >> 2) */
#define txss_ss                      ((struct ss_cfg_s *)0x802b68)
#define sls                          (*(struct sls_ctx_s *)0x80212c)
#define mac_mon_slot                 ((struct mac_mon_slot_s *)0x801030)
#define fsched_log                   ((struct fsched_log_ent *)0x8007d4)
#define tx_ctx_pool                  (*(struct tx_ctx_pool_s *)0x802978)
#define tx_ctx_cur                   (tx_ctx_pool.cur)
#define bf_sta                       ((struct bf_sta_s *)0x801ffc)
#define bf_req                       (*(struct bf_req_q_s *)0x8020b0)
#define pm_ctx                       (*(struct pm_ctx_s *)0x802f80)
#define rs_sta_flags                 ((u8 *)0x8006ac)     /* [в] на станцию: б7 — принудительный MCS (LMAC 0x30), б6:0 — MCS */
#define rs_state                     ((struct rs_sta_state *)0x802610)
#define rs_stats                     ((struct rs_sta_stats *)0x802670)
#define rs_cfg                       ((struct rs_sta_cfg *)0x8027d0)
#define rs_start_cnt                 ((u32 *)0x802900)    /* [в] запусков rate search по станциям (rs_start) */
#define rs_end_cnt                   ((u32 *)0x802920)    /* [в] завершений (rs_end) */
#define rf_normal_abif_field         (*(u8 *)0x800429)
#define ctrl_frame_mcs               (*(u8 *)0x80043c)
#define phy_mode_fields              ((u8 *)0x80043d)    /* [4] поля 6 бит PHY 0x8831c0/0x8831c4 (hwd_phy_set_mode_uc, режим ≠ 1): [0] → 1c0[5:0], [2] → 1c4[5:0], [1] → 1c0[11:6], [3] → 1c4[11:6]; образ data.c */
#define itx_rr_a                     (*(u8 *)0x800441)
#define itx_rr_b                     (*(u8 *)0x800442)
#define rx_nav_update_en             (*(u8 *)0x800445)
#define rfc_txrx_set                 (*(u8 *)0x800446)
#define uc_cold_boot                 (*(u32 *)0x80044c)
#define mac_chain_mask               (*(u32 *)0x800454)
#define l1_fsched_flag               (*(u32 *)0x80045c)
#define fsched_peer_id               (*(u32 *)0x800468)
#define assert_reset_ina_det         (*(u32 *)0x800474)
#define macq_cmd08_en                (*(u32 *)0x80047c)
#define pm_cfg_flag                  (*(u32 *)0x8004dc)
#define rx_resp_wait_en              (*(u32 *)0x8004ec)
#define txop_limit_shift             (*(u32 *)0x800504)
#define rx_flow_timeout_us           (*(u32 *)0x800518)
#define bg_bi_thr_a                  (*(u32 *)0x80057c)
#define bg_bi_thr_b                  (*(u32 *)0x800580)
#define bg_task_mask                 (*(u32 *)0x800584)
#define bi_sm_name_ptr               (*(u32 *)0x8005ac)
#define bf_sta_mask                  (*(u16 *)0x8005b8)
#define mac_ifs_shadow               (*(u16 *)0x8005be)
#define busy_gap_us                  (*(u8 *)0x800640)
#define adc_gain_thresh              (*(u8 *)0x800641)
#define l1_time_thresh               (*(u32 *)0x800644)
#define bg_task_pending              (*(u32 *)0x800648)
#define rf_modules                   (*(struct rf_modules_cfg *)0x8006b4)
#define bcast_mac                    ((u16 *)0x8006c4)
#define prs_mcast_addr               ((u8 *)0x8005e4)   /* [6] Копия MAC-адреса фильтра 0x886018/0x88601c (prs_mcast_addr_lo/hi), пишется u16×3 в LMAC 0x00; rx_flow_handle_f… */
#define qsel_last_qid_c              ((u32 *)0x8005ec)   /* [2] tx_slot_pick_queue, набор qset 7..8: [r1] = qid+1 последней выбранной очереди; команда v = [0]|[1]<<8|0x130000… */
#define txss_retry_cnt               ((u8 *)0x8005fc)   /* [3] bf_sm_txss_init_result: счётчики повторов TXSS по виду статуса ([0] — 1, [1] — 2/3, [2] — 4; до 4); sta_reset_… */
#define sysassert_idle_sm_hist       ((u16 *)0x800758)   /* [8] uc_sysassert_idle_hist: гистограмма r40[2:0] (состояния SXD idle detect) за 20000 итераций; vendor-имя g_sysas… */
#define sysassert_cca_hist           ((u32 *)0x800768)   /* [4] uc_sysassert_idle_hist: гистограмма PHY_RX_CCA (0,1,2,≥3); vendor-имя g_sysassert_cca_hist. */
#define rf_rx_gain_hi                ((u8 *)0x80141c)   /* [8] по-RF (индекс = номер бита в 0x8006b7) 4-битное усиление, старший ниббл RF-регистра 1284: rf_gain_adjust_cb (c… */
#define rf_rx_gain_lo                ((u8 *)0x801450)   /* [8] по-RF 4-битное усиление, младший ниббл регистра 1284 (cmd.c 1587, clamp 1..15 от 0x8025e8+i+4); читателей кром… */
#define mac_pub_mask                 ((u32 *)0x80156c)   /* [8] Тени масок qset для MAC 0x886d8c+4·i; mac_publish_masks (bf.c 64–74) пишет только [i] при бите i в 0x8004ac, i… */
#define rfc_write_cnt                ((u32 *)0x8016ec)   /* [8] Счётчики записей в RFC по индексу a (hwd_rfc_write_core, txss.c 972); 8 слов до 0x80170b (далее g80170c из dat… */
#define timer_list_head              ((u32 *)0x8017b8)   /* [4] Головы списков init/таймеров по prio (timer_list_insert_sorted: 0x8017b8+prio·4, stubs.c 18); timer_list_init … */
#define rx_capture_defaults          ((u8 *)0x8017c8)   /* [5] Шаблон 5 байт для rx_capture_match_filter (rx.c 2519–2523): sp[0..4] {станция, режим, «MCS0», MCS, бит rx_mode… */
#define rss_wait_clk                 ((u32 *)0x8020c4)   /* [9] Окно ожидания RSS по станциям 0..8, такты MAC: [0x857280+0xc]×(N×0xa40+0x528); пишут ucode_cmd_0x18 (тип 8), c… */
#define cts_rx_cnt                   ((u32 *)0x802450)   /* [8] Принятых CTS по станциям (++0x802450[sta] в rx__dispatch_by_g_8005f8, r37.mmWaveCTS). UC-REGISTERS §4.2 (0x600… */
#define cmd20_cfg                    ((u8 *)0x8025b8)   /* [36] Копия 0x24 Б тела LMAC 0x20 (ucode_cmd_0x20_handler); 0x8025b8..0x8025db. */
#define rx_mode_hist                 ((u8 *)0x8025fc)   /* [16] Кольцо последних режимов RX (rx_mode__configure: hist[idx]=mode, idx=(idx+1)&0xf, hist[idx]=0xff как маркер). … */
#define txop_limit_us                ((u32 *)0x80294c)   /* [4] 4 лимита TXOP (u16 из LMAC 0x21 → u32), txop__apply_limits_regs: [1]→сдвиг/мин, [2]|[3]<<16 → 0x886f74. LMAC-P… */
#define ifs_cfg_us                   ((u16 *)0x80295c)   /* [6] 12 Б из тела LMAC 0x00 +0x30 (u16: [0] SIFS, [2] slot, [3], [4]); вход txrx_api_step_b_uc. Не литерал (0x80294… */
#define txq_slot_a                   ((u32 *)0x8029fc)   /* [3] Длины/номера слотов очередей группы A (0..2), tx_slot__pick_queue → MAC-команда v|b24|b28 (A[0] | A[1]<<8 | A[… */
#define txq_slot_b                   ((u32 *)0x802a08)   /* [3] То же для группы B (3..5), команда с b25|b28. */
#define tx_dis_mask                  ((u16 *)0x802a90)   /* [8] Маска запрета передачи по станциям (бит — причина): bf__pause_sta_tx / bf__resume_sta_tx; вендорское g_sm_disa… */
#define sta_mode_word                ((u32 *)0x802aec)   /* [9] Слово режима MAC/RF по станциям (ucode_cmd_0x0c: [0x80051c]|0x30|sector<<8): mac_mode_switch_core_and_rf на SL… */
#define ss_order_cur                 ((u8 *)0x802e14)   /* [64] Рабочий порядок секторов текущей развёртки (0x802e14..0x802e53): txss__set_sweep_param копирует n байт из ss_c… */
#define aw_peer_stats                ((u8 *)0x803118)   /* [12] Счётчики сбора бодрствующих пиров (aw_worker__collect_awake_peers, aw__fold_peer_masks): [0..7] по пиру, [8] з… */
#define rx_buf                       ((u8 *)0x804010)     /* [в] принятый кадр (заголовок 802.11 и тело) */
#define rx_buf_ra                    ((u16 *)0x804014)    /* [в] адрес 1 (у маяка — BSSID) */
#define rx_buf_ta                    ((u16 *)0x80401a)    /* [в] адрес 2 (TA) */
#define sta_miss_cnt                 ((u8 *)0x8005c4)    /* [с] слотов без приёма от станции; ≥0xb → станция пропала (peer_slots_scan_by_masks) */
#define sta_slot_fail_cnt            ((u8 *)0x8005cc)    /* [н] bi_rx_slot_handler ++ (неудача), разрешает счёт sta_miss_cnt */
#define sta_slot_ok_cnt              ((u8 *)0x8005d4)    /* [н] bi_rx_slot_handler ++ (успех), сбрасывает sta_miss_cnt */
#define aw_collect_en                (*(u32 *)0x800718)
#define g800728                      (*(u32 *)0x800728)
#define cmdq_desc_handler            (*(u32 *)0x800734)
#define uc_timer                     ((struct uc_timer_aux *)0x800738)
#define uc_log_module_tab            ((u32 *)0x800778)
#define init_desc_globals_fn         (*(u32 *)0x8007cc)
#define brp_snr_cfg_enable           (*(u32 *)0x80088c)
#define brp_snr_cfg_flags            (*(u8 *)0x800890)
#define brp_snr_cfg_lo_sel           (*(u8 *)0x800891)   /* [с] +5: brp_pick.snr_cfg, когда SNR ниже порога */
#define brp_snr_cfg_hi_sel           (*(u8 *)0x800892)   /* [с] +6: brp_pick.snr_cfg, когда SNR не ниже порога */
#define brp_snr_cfg_thr              ((u8 *)0x800893)    /* [с] +7..+9: [1] — brp_pick.count при SNR не ниже порога, [2] — порог SNR */
#define brp_frame                    (*(struct brp_frame_tpl *)0x800898)
#define init_desc_copy_8006b7_fn     (*(u32 *)0x800fe4)
#define bf_req_desc_default          (*(struct bf_req_desc *)0x800fec)
#define phy_snap_min                 (*(u8 *)0x801020)
#define rf_chain_word                (*(u32 *)0x801024)
#define init_desc_cmdq_fn            (*(u32 *)0x8013ec)
#define rx_mode_flags                (*(u32 *)0x801424)
#define rf_gain_cb                   (*(u32 *)0x8005a8)   /* [в] обратный вызов подстройки усиления RF после смены RF-цепи (bf.c: (r19, r17)); mac.c ставит rf_gain_adjust_cb (VENDOR_CB 0x935748) */
#define tsf_evt_target               ((u32 *)0x8022c0)    /* [2] TSF64 цели set_tsf_event: bti_worker_bti_transmitter_beacon_sweep_flow (bi_mode 2) прибавляет (случайная задержка) << 10 */
#define g80148c                      (*(u32 *)0x80148c)
#define g801490                      (*(u32 *)0x801490)
#define g801495                      (*(u8 *)0x801495)
#define txrx_cfg_flags               (*(u32 *)0x8014a0)
#define pm_idle_flags                (*(u32 *)0x8014bc)
#define rf_power_seq_mask            (*(u32 *)0x8014d8)
#define mac_pub_mask7                (*(u32 *)0x801588)
#define txss_timing_base             (*(u32 *)0x801598)
#define txss_timing_x10              (*(u32 *)0x80159c)
#define txss_timing_add              (*(u32 *)0x8015a0)
#define qset_slots_en                (*(u32 *)0x8015b4)
#define bi_state_names               ((u32 *)0x8015b8)
#define bi_event_names               ((u32 *)0x8015c8)
#define bi_sm_table                  ((struct bi_sm_entry *)0x8015dc)
#define init_desc_801aec_fn          (*(u32 *)0x801644)
#define init_desc_more_fn            (*(u32 *)0x8016e4)
#define mcs_tab_886c70               ((u16 *)0x80178c)
#define rf_fill_template             ((u32 *)0x801820)
#define db_to_lin_tab                ((u32 *)0x80183c)
#define lin_to_db8_32                ((u8 *)0x800fc0)    /* [32] round(80·log10 n) — образ data.c (brp_select_cfg_by_snr) */
#define lin_to_db8_48                ((u8 *)0x80152c)    /* [48] образ data.c (brp_rf_store_cfg) */
#define mcs_tab_886c74               ((u8 *)0x8017a8)    /* [13] байт MCS → MMIO 0x886c74 (mac_set_cid_mcs_uc); образ data.c */
#define bi_sm_desc                   (*(struct sm_desc *)0x801adc)
#define bi_sm                        (*(struct sm_obj *)0x800600)   /* [в] автомат BI (gp+0xd8), дескриптор bi_sm_desc */
/* bi_state_name_bti — строка в data.c (0x801af0) */
/* bi_state_name_abft — строка в data.c (0x801b00) */
/* bi_state_name_dti — строка в data.c (0x801b10) */
/* bi_state_name_aw — строка в data.c (0x801b20) */
/* bi_event_name_dti_to_bti — строка в data.c (0x801b2c) */
/* bi_event_name_bti_to_abft — строка в data.c (0x801b40) */
/* bi_event_name_bhi_to_dti — строка в data.c (0x801b58) */
/* bi_event_name_bhi_to_aw — строка в data.c (0x801b6c) */
/* bi_event_name_aw_to_dti — строка в data.c (0x801b80) */
/* bi_sm_name — строка в data.c (0x801b94) */

/* ---- Рантайм-переменные (без начальных значений; имена — по чтениям vendor и нашего кода).
 * Уверенность в смысле: [в] высокая, [с] средняя, [н] низкая. ---- */
#define brp_ctx_resp_sta_alias       (*(u8 *)0x800864)   /* [в] Не объект: brp.c 744 читает *(u8*)(0x800864+0x18) = 0x80087c = brp_ctx.resp_sta (vendor база+смещение). */
#define rf_chain_word_host_set       (*(u32 *)0x80102c)   /* [н] ucode_cmd_0x19_handler (cmd.c 289; vendor 0x93a7cc st [0x801024+8]) ставит 1 после записи rf_chain_word из команды; статических читателей не найден... */
#define mac_mon_slot_idx             (*(u8 *)0x801080)   /* [в] индекс рабочего слота mac_mon_slot (= [0x801030+0x50]); переключает l1_task_dispatch case 0 (l1.c 295), читают l1.c 141, misc.c 430, tail.c 1010/27... */
#define sta_tab_bcast_40             (*(u8 *)0x8013c4)   /* [в] Адрес = sta_tab[8]+0x40 (внутри ключа); используется только как база: cmd.c 424–425 пишут +0xc/+0xd = sta_tab[8].peer_n_ant=1 и .peer_n_sectors=0x4... */
#define sel_nbr_rs_param             (*(u8 *)0x801494)   /* [н] = [0x80148c+8]: ucode_cmd_selective_neighbor_cfg пишет байт +5 команды (cmd.c 230); rs_end читает его при бите 8 txrx_cfg_flags (tail.c 3361–3365).... */
#define nav_accum64_lo               (*(u32 *)0x801498)   /* [в] Младшее слово nav_accum64 (сумма длительностей NAV, мкс; → MMIO 0x853914) */
#define nav_accum64_hi               (*(u32 *)0x80149c)   /* [в] Старшее слово nav_accum64 (rx.c 2341–2344, cmd.c 1465). */
#define uc_role_ap                   (*(u32 *)0x8014c0)   /* [в] 1 — роль AP/PCP (ucode_cmd_0x1b: режим 2 или 3, power.c 48); читают ~25 мест (bi, bti, brp, cmd, fsched, l1, mac, rx, tx, txss, tail), tx.c 582 ком... */
#define uc_role                      (*(u32 *)0x8014c4)   /* [в] сырой режим из cmd 0x1b байт 0 (power.c 49); rx.c 851 сравнивает с 3; BENCH.md: у станции == 1 */
#define pm_idle_enter_cnt            (*(u32 *)0x8014c8)   /* [в] счётчик входов в idle (uc_pm_enter_idle, uutil.c 246), зеркалится в 0x85391c */
#define rx_listen_enter_cnt          (*(u32 *)0x8014cc)   /* [в] счётчик входов в режим приёма (rx_enter_listen_mode, rx.c 268) */
#define fsched_slot_skip_cnt         (*(u32 *)0x8014d4)   /* [с] fixed_sched_run_tx_slot: ++ когда [0x800588] != 1 (не в listen) и слот пропускается (l1.c 621) */
#define mac_pub_mask4                (*(u32 *)0x80157c)   /* [в] mac_pub_mask[4] ← 0x800414 (qset 4) в mac_publish_masks (bf.c 66). */
#define mac_pub_mask5                (*(u32 *)0x801580)   /* [в] mac_pub_mask[5] ← 0x80041c (qset 5) (bf.c 67). */
#define mac_pub_mask6                (*(u32 *)0x801584)   /* [в] mac_pub_mask[6] ← 0x800424 (qset 6) (bf.c 68). */
#define rx_capture_defaults_2        (*(u8 *)0x8017ca)   /* [н] rx_capture_defaults[2] (rx.c 2521), сразу перезаписывается. */
#define rx_capture_defaults_3        (*(u8 *)0x8017cb)   /* [н] rx_capture_defaults[3] (rx.c 2522), сразу перезаписывается. */
#define rx_capture_defaults_4        (*(u8 *)0x8017cc)   /* [н] rx_capture_defaults[4] (rx.c 2523), сразу перезаписывается. */
#define rf_fill_template_1           (*(u32 *)0x801824)   /* [в] Псевдоним rf_fill_template[1] (dccm.h 0x801820); rf_utils_auto_fill_with_byte (brp.c 19). */
#define rf_fill_template_2           (*(u32 *)0x801828)   /* [в] Псевдоним rf_fill_template[2] (brp.c 20). */
#define rf_fill_template_3           (*(u32 *)0x80182c)   /* [в] Псевдоним rf_fill_template[3] (brp.c 21). */
#define g801a9c                      (*(u32 *)0x801a9c)   /* [н] Слово 0 в образе, писателей нет (vendor — единственная ссылка @0x939d00); txss_sweep_duration_for_sta копирует a9c/aa0 в буфер, который txss_sweep_... */
#define g801aa0                      (*(u32 *)0x801aa0)   /* [н] Пара к 0x801a9c (txss.c 1242), то же — мёртвое чтение. */
#define qset_ack_cfg_default         (*(u32 *)0x801aa4)   /* [н] 4 байта по qset 0..3 (по 2 бита в MAC-команде 1<<27 | b0 | b1<<2 | b2<<4 | b3<<6), выбранный класс q получает 2 (tx_pick_slot_for_peer, tx.c 622–62... */
#define bi_sm_desc_name              (*(u32 *)0x801aec)   /* [в] Псевдоним поля bi_sm_desc.name (0x801adc+0x10; dccm.h): boot.c 223 копирует bi_sm_name_ptr; никем не читается. */
#define brp_stats_base40             (*(u32 *)0x801ed4)   /* [в] Не объект: вторая база vendor внутри brp_stats (= 0x801e94+0x40); обращения от неё идут со смещения +4 (meas_done, restore_cnt, u16-счётчики +0xe..... */

/* ---- Рантайм-переменные (без начальных значений; имена — по чтениям vendor и нашего кода).
 * Уверенность в смысле: [в] высокая, [с] средняя, [н] низкая. ---- */
#define g_800428                     (*(u8 *)0x800428)   /* [н] Только обнуляется в uc_main после очистки BSS (vendor stb [gp,-256] — единственное обращение); читателей в uc нет. Возможно, читает хост/fw. */
#define rf_normal_abif_en            (*(u8 *)0x80042a)   /* [с] rf_set_normal_mode: != 0 — записать поле abif 0x88a204 значением rf_normal_abif_field (0x800429), иначе 0. Только чтение (ldb [gp,-254]); в образе ... */
#define rf_normal_phy_mode           (*(u8 *)0x80042b)   /* [с] rf_set_normal_mode: (b != 0) → аргумент hwd_phy_set_mode_uc (режим PHY 0/1). Только чтение (ldb [gp,-253]). */
#define rx_resp_abort_t1             (*(u8 *)0x80042c)   /* [н] Ставится в 1 в rx_flow_handle_frame, когда ответ отменён командой 0x14000000 при ctx[9]==1 (тип ответа 1 из rx_get_required_response); 0x80042d — т... */
#define rx_resp_abort_t2             (*(u8 *)0x80042d)   /* [н] Пара к 0x80042c: ответ типа 2 (ctx[9]==2) отменён. Те же писатели/читатели (vendor stb/ldb [gp,-251]). */
#define brp_rf_module_byte           (*(s8 *)0x80042e)   /* [н] Знаковый байт (vendor ldb.x [gp,-250]) — brp_rf_store_module_byte копирует его в 0x801523+rf. Только чтение, писатель вне uc; смысл значения не уст... */
#define rx_buf_toggle_cnt            (*(u8 *)0x80042f)   /* [в] Счётчик чётности: MAC-команда 0x32000000|(b&1) (+бит 25/28/29 в bi_mode_init), затем ++ — переключение двух буферов приёма. 16 мест (rx_arm_window*... */
#define brp_init_retry_cnt           (*(u8 *)0x800430)   /* [в] Счётчик повторов BRP-инициатора (bf_sm_brp_init_result: статус 0x31 → ++, ≥4 → отказ; статус 0 → 0). Комментарий в bf.c и vendor 0x922494. */
#define bti_sweep_set                (*(u8 *)0x800431)   /* [в] Номер набора развёртки маяка BTI (= число RF-модулей−1 из 0x85773c, ++ в bti_prepare_sweep_set); индекс в таблице 0x8577b0 (×2) и аргумент txss_set... */
#define bi_rx_tx_refused_cnt         (*(u8 *)0x800432)   /* [н] ++ в bi_rx_start_rx_window на ветке L_9212dc, где txrx_state2 = 0x800 (поток TX начат/отказ); читателей нет (диагностика). */
#define mac_a000_fast                (*(u8 *)0x800433)   /* [н] mac_set_mode_a000: 1 — переход сразу (стадия r49[19:16] < 6), 0 — после ожидания стадии BRP. Только запись (vendor stb [gp,-245]). */
#define brp_cfg_sel_mask             (*(u8 *)0x800434)   /* [н] config_brp_rf, фаза 3: итоговая маска r20 выбранных конфигураций; только запись (vendor 0x92536a). */
#define brp_cfg_max_per_grp          (*(u8 *)0x800435)   /* [н] config_brp_rf, фаза 2: максимум числа конфигураций в 4-битной группе маски (по SNR); только запись (vendor 0x9251fa). */
#define rx_buf_toggle_dis            (*(u8 *)0x800436)   /* [с] ≠ 0 — не выдавать команду 0x32 переключения буфера (и не ++ 0x80042f); 12 проверок в rx/bti/brp/boot, писателя в uc нет (задаётся извне, в образе 0). */
#define bf_abort_nonhead_cnt         (*(u8 *)0x800437)   /* [с] ucode_cmd_0x0f_handler: BF станции прерван, но станция не в голове кольца запросов BF → ++ (иначе ставится фоновая задача 1). Только счётчик. */
#define discovery_type               (*(u8 *)0x800438)   /* [в] Байт +4 команды LMAC 0x24 (discovery_mode_cfg, «DISCOVERY ON/OFF (Type: %d)»); ucode_cmd_0x0b_handler при ==1 вызывает disable_tsf_event. */
#define abft_gp0_armed               (*(u8 *)0x800439)   /* [с] bti_arm_period_gp0 ставит 1 после программирования периода (команды 0x50/0x53/0x49); abft_responder_fast при ≠0 корректирует номер слота на... */
#define fsched_log_idx               (*(u8 *)0x80043a)   /* [в] Индекс записи журнала fsched_log 0x8007d4 (+4·idx), ++ в l1_fixed_sched_*_sm, 0 при ≥16; аргумент rx_flow_run_and_check_bf_abort. NAMES-EXTRA («Инд... */
#define qh_dma_open                  (*(u8 *)0x80043b)   /* [с] sched_cfg_merge_update ставит 1 (если 0); qh_write_while_dma_open_check при ≠0 считает «QH Write while DMA is open» (счётчик 0x80070f) и сбрасывает... */
#define abft_gp0_periods             (*(u8 *)0x800443)   /* [с] bti_arm_period_gp0: число целых периодов, прошедших до программирования (цикл вычитания) — stb [gp,-0xe5]; abft_responder_fast вычитает (n+... */
#define mac_cmd31_mode               (*(u8 *)0x800444)   /* [с] Аргумент a последней MAC-команды 0x31 (mac_select_rf_module_cmd31: 0x31000000|a<<4|sta<<9); ≠0 включает ожидание BAP (r53.0, команды 0x23010003/0x2... */
#define rx_last_mcs                  (*(u8 *)0x800447)   /* [в] r38[24:20] received_mcs последнего кадра (rx_flow_handle_frame); ≥2 и RS не включён → событие rs_started (rx_funcs_rx_flow). UC-REGISTERS §2 r38. */
#define aw_tx_peer_mask              (*(u8 *)0x800448)   /* [с] Битовая карта станций (<8), которым была передача в слоте фикс. расписания (fixed_sched_run_tx_slot при 0x8006c0≠0); aw_worker_collect_awake_peers ... */
#define fsched_enabled               (*(u8 *)0x800449)   /* [в] Фиксированное расписание включено: LMAC 0x3e (fixed_sched__start) ставит 1 вместе с 0x80044a; проверяют bi_manager_step_a, bti beacon sweep, l1_tas... */
#define fsched_qh_mode               (*(u8 *)0x80044a)   /* [с] Второй байт LMAC 0x3e; ≠0 — окно дескрипторов QH 0x886608 в режиме 0x40000000 (иначе 0xc0000000), qh_reset_desc_window не сбрасывает окно, qh_wait_... */
#define txop_dma_bit1_pending        (*(u8 *)0x80044b)   /* [с] ucode_cmd_0x08_handler ставит 1 (тип 3, +8==0); tx_sta_run_txop при qid станции снимает бит 1 DMA (txop_clear_dma_ctl_bit1) и сбрасывает в 0. */
#define bi_aw_flag                   (*(u32 *)0x800458)   /* [н] bi_sm_action_92150c/53c/56c ставят 1 (трассы 0xcaf66x, переход BHI→AW), 935a94 — 0. В 6.2 uc читателей нет; гейт «AW разрешён» по этому адресу опис... */
#define bap_tx_up_status             (*(u32 *)0x800460)   /* [в] r53 & 0x10 (bap_tx_up_status) при приёме ACK/BA; при ≠0 BA не учитывается (rx_dispatch_by_g_8005f8, rx_nav_update). UC-REGISTERS §2.14. */
#define rx_resp_ackcts_cnt           (*(u32 *)0x800464)   /* [н] ++ в rx_get_required_response перед веткой ack_cts (L_9331c4); читателей нет. DATAPATH.md называет [gp-0xc4]=0x800464 «bcast qid» — это 4.1, в 6.2 ... */
#define bf_rx_sector                 (*(u16 *)0x80046c)   /* [с] Сектор для слова +8 записи станции (0x80110c: (cfg|0x30)|s<<8) в sta_apply_bf_result; = байт 0x802110 результата BF; по умолчанию 0x21 (bf_init_glo... */
#define bf_tx_sector                 (*(u16 *)0x80046e)   /* [с] Сектор для слова +4 записи станции (0x801108: (cfg|0x20)|s<<8); = байт 0x802111; по умолчанию 0x21. Пара к 0x80046c. */
#define bf_cur_sta                   (*(u32 *)0x800470)   /* [в] Станция текущего BF-потока: пишут bf_sm_process_request_fifo, bf_enter_mode3 (через 0x800528-0xb8); internal_tx_isr («Postpone TxSS for sta_id %d»)... */
#define txop_limit_cur               (*(u32 *)0x800478)   /* [с] txop_apply_limits_regs: предел TXOP после сдвига txop_limit_shift (из 0x802950); тот же a уходит в 0x886f70[31:16]. Только запись. */
#define rx_resp_skip_cnt             (*(u32 *)0x800480)   /* [с] Обратный счётчик в rx_get_required_response: при ==1 перезаряжается из 0x800484 и ответ не формируется (return 0), при ≥2 — декремент. Периодически... */
#define rx_resp_skip_period          (*(u32 *)0x800484)   /* [с] Период перезарядки 0x800480; только чтение, задаётся извне (в образе 0 → механизм выключен). */
#define sleep_ilink2                 (*(u32 *)0x800488)   /* [в] uc_sleep_until_event: ilink2 (r30) перед sleep. UC-REGISTERS.md (§3, «в 0x800488 перед sleep»). */
#define mac_mon_snap                 (*(u32 *)0x80048c)   /* [н] peer_slots_scan_by_masks: копия 0x85398c при публикации MAC-монитора (перед uc_send_evt_mac_monitor). Только запись. */
#define nav_late_cnt                 (*(u32 *)0x800490)   /* [н] rx_nav_set_from_duration: ++, если NAV включён и новое значение позже старого более чем на 0x32; grant_detect_step обнуляет при снятии флага. */
#define g_800494                     (*(u32 *)0x800494)   /* [н] l1_task_dispatch, событие 3: при l1_fsched_flag≠0 и [0x800494]==0 (и 0x8022a8≠2) — событие 3 автомата BI, иначе mac_prog_cmd02_body. Только чтение,... */
#define r49_snap                     (*(u32 *)0x80049c)   /* [с] Снимок r49 (EVENT_ENGINE2 PHY BRP) в mac_set_mode_a000 после смены режима. UC-REGISTERS §2.12. Только запись (в 4.1 по этому адресу — гейт AW, друг... */
#define mac_a000_waited              (*(u32 *)0x8004a0)   /* [н] mac_set_mode_a000: 0 на входе, 1 перед ожиданием окончания стадии BRP r49[19:16] (6..13). Только запись. SCHEDULER/FW-OBJECTS про 0x8004a0 — адрес ... */
#define txss_rank_needed             (*(u32 *)0x8004a4)   /* [н] 1 — после TXSS выполнить txss_rank_best_sector (txss_init_flow/txss_resp_flow); ставят txss_init_wait_rss (бит 1 статуса), sls_rx_ssw_frame, txss_r... */
#define discovery_on                 (*(u32 *)0x8004a8)   /* [в] LMAC 0x24: 1 — DISCOVERY ON, 0 — OFF (ucode_cmd_0x24_handler). Только запись в uc. */
#define qset_enable_mask             (*(u32 *)0x8004ac)   /* [в] Маска включённых qset 4..7 для mac_publish_masks (0x70 при сбросе; б7 — internal TX; uc_res_vote снимает/ставит 0x70). DATAPATH.md §8: 6.2 = [gp-0x... */
#define rx_wait_slot_acc             (*(u32 *)0x8004b0)   /* [с] rx_funcs_rx_flow: накопитель (+ байт 0x80296b) при ожидании ответа; ≥0x1f → таймаут (txrx_state2 б16); обнуляется при приёме. UC-REGISTERS §4.2 б16... */
#define assert_caller                (*(u32 *)0x8004b4)   /* [в] uc_assert: адрес вызвавшего (st.as [gp,-29]). В 4.1/DATAPATH этот адрес — маска qset (6.2: 0x8004ac). */
#define assert_code                  (*(u32 *)0x8004b8)   /* [в] uc_assert: код ассерта (первая копия). */
#define irq_evt_mask                 (*(u32 *)0x8004bc)   /* [в] irq_init_event_masks: 0x98f3f; в MMIO 0x886e30 пишется ~mask. */
#define assert_code2                 (*(u32 *)0x8004c0)   /* [в] uc_assert: вторая копия кода ассерта. */
#define sleep_evt_arg                (*(u32 *)0x8004c4)   /* [в] uc_sleep_until_event: аргумент (маска событий, тот же пишется в 0x886d3c) перед sleep. */
#define mac_tx_qid_en_shadow         (*(u32 *)0x8004c8)   /* [в] Тень 0x886f5c mac_tx_qid_enable_mask: бит на qid, б31 — internal TX; tx_sta_run_txop |= / &= ~0x800564. UC-REGISTERS §4.4. */
#define bti_bi2_bi_counter           (*(u32 *)0x8004d4)   /* [с] bti_bi2_event_step: снимок BI_COUNTER (r40 по селектору 4, 26 бит) при событии «BI2 event». */
#define bi_pos_us                    (*(u32 *)0x8004d8)   /* [с] uc_bi_counter_in_window: снимок BI_COUNTER (r40 & 0x3ffffff); 6.4: g_bi_pos_us. */
#define mac_evt_en_shadow            (*(u32 *)0x8004e0)   /* [в] Тень разрешения событий MAC (команда 0x27: [0x8004e0]|0x27000000|(маска)<<8); инициализация 0xc. UC-REGISTERS §4.4. */
#define mac_sel_shadow               (*(u32 *)0x8004e4)   /* [в] Тень селекторов локального чтения (команда 0x1d, полубайты [11:8] r41, [15:12] r40, [19:16] r47…). UC-REGISTERS §2.3, §4.4; 6.4: g_mac_select_shado... */
#define rx_ppdu_report_seen          (*(u32 *)0x8004e8)   /* [с] rx_flow_run обнуляет; rx_funcs_handle_ppdu_report и sls_rx_ssw_frame ставят 1; rx_flow_run при ≠0 пропускает обработку кадра (goto done). */
#define fsched_rx_resp_seen          (*(u32 *)0x8004f0)   /* [н] Ставят rx_flow_step и tx_send_and_await_rx_frame; fixed_sched_run_tx_slot при 0 (и rx_resp_wait_en==1) шлёт 0x1f000601, затем обнуляет. (Комментари... */
#define dti_qset_mode                (*(u32 *)0x8004f4)   /* [в] Режим фикс. расписания: 0 — нет, 1 — AP/PCP, 2 — STA (l1_enter_fixed_sched: 0x8014c0==0 ? 2 : 1); выбор автомата и потока в l1/rx/bf. 6.4: g_dti_qs... */
#define bf_done_cnt_pub              (*(u32 *)0x8004f8)   /* [с] bf_req_dequeue_head: копия счётчика завершённых BF-запросов 0x80211c. Только запись (вероятно, для хоста). NAMES-EXTRA про 0x8004f8/fc — fw-адреса. */
#define rf_cur_sector_word           (*(u32 *)0x8004fc)   /* [с] Текущее слово RF/сектора (биты 3:0 — RF, 22:8 — сектор): brp_split_id, brp_program_and_measure (= rf_chain_word), mac_set_rf_chain_state; читают rx... */
#define mac_mon_armed                (*(u32 *)0x800500)   /* [в] Флаг взвода MAC-монитора: ставит bi_sm_action_935d0c, peer_slots_scan_by_masks работает только при ==1 и сбрасывает. MAC-MON.md (6.2: [gp-0x28]). */
#define resp_wait_slots              (*(u16 *)0x800508)   /* [с] Число ожиданий слота для sxd_hal_wait_slot2_busy2 при ожидании ответа (bi_rx_start_rx_window, tx_sta_wait_slot_and_tx, txss_resp_wait_fdbk); = 2, и... */
#define busy_wait_slots              (*(u16 *)0x80050a)   /* [с] То же значение, второй набор мест: rx_funcs_rx_flow (sxd_hal_wait_slot2_busy), rx_handle_status_flags, tx_sta_flow_loop. */
#define edca_ac_en_shadow            (*(u32 *)0x80050c)   /* [с] txrx_api_step_c (LMAC 0x04 EDCA): тень битов (i+8) и (i+20) по AC; уходит в MAC-команду m|0x07000000. */
#define txss_ifs_restore             (*(u32 *)0x800510)   /* [с] txss_init_flow/txss_resp_flow ставят 1 после смены IFS (0x802974); в конце потока при ≠0 восстанавливают IFS из 0x802968 и шлют 0x1f000601; txss_*_... */
#define tx_fifo_free                 (*(u32 *)0x800514)   /* [в] Свободное место FIFO TX в байтах (уменьшается при записи r33/r34; direct_tx_program_cmd34 задаёт длину). UC-REGISTERS §2.2. */
#define rf_chain_cfg                 (*(u32 *)0x80051c)   /* [в] Конфигурация RF-цепи из LMAC 0x00 (+0x40): &0xf → 0x563f0020; |0x30 в векторы TX/RX (0x41000000, mac_program_rx_window). 21 обращение; один раз чит... */
#define rs_enabled_mask              (*(u32 *)0x800520)   /* [в] Маска станций с включённым rate search (LMAC 0x13 enable/disable); rs_is_sta_enabled. */
#define rs_pending_mask              (*(u32 *)0x800524)   /* [с] Станции с ожидающим шагом rate search: rs_start (=1<<sta), tx_flow_substep, rate_search_pick_tx_params ставят; rs_end перебирает и снимает. (LINK-S... */
#define rx_qset4_hit                 (*(u32 *)0x800528)   /* [н] Адрес gp. Как переменная: rx_funcs_rx_flow ставит 1, если queue_sel_get_qset4 нашёл очередь (иначе 0); rx_flow_handle_frame использует для бита 4 0... */
#define rx_mode_bad_r55_cnt          (*(u32 *)0x80052c)   /* [с] rx_switch_to_rx_mode: ++, если r55 (группа R55 после 0x4d000000) > 0x500 или 0 — тогда MAC 0x1f000601. Только счётчик. */
#define rx_flow_mac_state            (*(u32 *)0x800530)   /* [с] rx_flow_run: r40 & 7 (состояние MAC) на входе; при 5 перечитывается после проверки r55. */
#define rx_flow_r55_snap             (*(u32 *)0x800534)   /* [н] rx_flow_run: снимок r55. Только запись. */
#define rx_resp_ctx8                 (*(u32 *)0x800538)   /* [н] Значение для ctx[8] / frame+8 при ответе типа 2 (qid в 0x800564 или RD от известной станции): rx_flow_step, rx_get_required_response, tx_mtp_queue_... */
#define rx_wait_start_tsf            (*(u32 *)0x80053c)   /* [в] TSF начала ожидания ответа (rx_flow_handle_frame, rx_program_mac_and_wait, rx_resp_finish_restore_rx, fsched_ap_start_slot); rx_funcs_rx_flow: TSF ... */
#define rx_on_tsf                    (*(u32 *)0x800540)   /* [с] TSF при сбросе BI-защёлки (bi_latch_tsf_and_reset, LMAC 0x03 / RX ON) и при link lost; ucode_cmd_0x01_handler вычисляет прошедшее время. NAMES-EXTR... */
#define rx_bap_rx_up                 (*(u32 *)0x800544)   /* [с] rx_get_required_response: r53.б5 bap_rx_up_status (после ожидания bap_rx_update_ind) либо 0/1 по ветке пира; ==1 → разбор ответа по BAP. */
#define short_txop_en                (*(u32 *)0x800548)   /* [с] Байт +4 LMAC 0x1e (ucode_cmd_selective_neighbor_cfg, vendor 0x93cc12 st.as [gp,8]); txop_apply_limits_regs при ≠0 сдвигает предел TXOP на txop_limi... */
#define calib_gain_ofs               (*(u8 *)0x80054c)   /* [с] LMAC 0x16: memcpy 4 Б (байт +0xb4 калибровочного объекта fw); читается байтом: rx_mode_configure прибавляет к усилению (клип 0x3f, phy_set_88306c_f... */
#define res_vote_mask                (*(u32 *)0x800550)   /* [в] uc_res_vote_acquire/release: маска голосов за ресурс (бит на причину: 2 — keep-alive, 4 — FTM); первый голос снимает qset 4..6 (0x8004ac &= ~0x70),... */
#define mac_cmd35_mask               (*(u32 *)0x800554)   /* [н] mac_build_qset_mask: маска из битов +0x2c конфигурации, уходит в MAC-команду 0x35 (L_92f1a0 / mac_program_886e0c_20b). Только запись. DATAPATH.md н... */
#define mac_trace_ptr_snap           (*(u32 *)0x800558)   /* [с] Снимок указателя кольца MAC-команд r25 (uc_assert, l1_task_main_step); адрес 0x800558 при загрузке пишется в MMIO 0x880010 (vendor add_s r0,gp,48) ... */
#define assert_active                (*(u32 *)0x80055c)   /* [в] uc_assert: защита от рекурсии (≠0 → выход, затем =1). */
#define snr_best_buf                 (*(u32 *)0x800560)   /* [с] Указатель на буфер лучшего измерения SNR (0x80212c или 0x802204 по сравнению с 0x802130) — rx_flow_measure_snr_select_best; phy_params_snapshot чит... */
#define txop_qid_mask                (*(u32 *)0x800564)   /* [с] Маска qid станции на время TXOP (tx_sta_run_txop: OR в 0x8004c8 и обратно; LMAC 0x08 снимает бит); при бите qid ответ типа 2 с ctx[8]=[0x800538]. U... */
#define rx_ack_rcvd                  (*(u32 *)0x800568)   /* [с] rx_dispatch_by_g_8005f8 (режим 1 — ACK) ставит 1; rx_nav_update при ≠0 и r37.б9 переходит в RD (б3), сбрасывает; rx_flow_run обнуляет. */
#define rx_cts_rf_restore            (*(u32 *)0x80056c)   /* [н] rx_nav_update ставит 1 при ожидании CTS (режим 4) и r37.б1; тогда rx_resp_finish_restore_rx / rx_program_mac_and_wait / tx_mtp_queue_gate / txop_in... */
#define itx_ka_pending               (*(u32 *)0x800570)   /* [с] Маска станций с ожидающей внутренней передачей keep-alive (keep_alive_arm_slot; check_idle(2)); itx_rr_pick_pending_b, aw_worker (OR в вектор), пуб... */
#define rx_flow_noevt_cnt            (*(u32 *)0x800574)   /* [н] rx_flow_run: ++ на раннем выходе (трасса 0xeeee04). Только счётчик. */
#define ppdu_evt_cnt                 (*(u32 *)0x800578)   /* [в] Тень r40[13:8] ppdu_event_counter: ++ при каждом взводе приёма (rx_arm_window*, rx_ppdu_is_*, abft, bti); mac_set_mode_a000 перечитывает; rx_flow_r... */
#define rx_listen_active             (*(u32 *)0x800588)   /* [с] rx_listen_set_flag_and_stamp_tsf ставит 1, uc_pm_enter_idle — 0; проверяют l1_task_main_step (assert 0x28), fixed_sched_run_tx_slot, background_bi_... */
#define bg_task_running              (*(u32 *)0x80058c)   /* [в] Выполняемая фоновая задача: background_task_dispatch обнуляет, затем ставит бит выбранной (из bg_task_mask & bg_task_pending). UC-REGISTERS §4.3. */
#define mac_a000_fast_cnt            (*(u32 *)0x800590)   /* [н] mac_set_mode_a000: ++ на быстром пути, если r40.б3 был поднят. */
#define mac_a000_slow_cnt            (*(u32 *)0x800594)   /* [н] mac_set_mode_a000: ++ на пути с ожиданием стадии BRP. */
#define g_800598                     (*(u32 *)0x800598)   /* [н] bti_bi2_event_step и bti_bi2_track_best_metric сравнивают (≠0) с rx_mode_flags.б0 (режим SLS). Только чтение, писатель вне uc. */
#define bti_kind_nonzero             (*(u32 *)0x80059c)   /* [с] bti_prepare_sweep_set: 0 — свой маяк (kind 0: 0x802f14=1, mac_cmd_0f_step), 1 — иначе. 6.4: g_bti_kind_nonzero. Только запись в нашем коде. */
#define bi_bcon_cfg_w0               (*(u32 *)0x8005a0)   /* [с] bi_cfg_pack_words_78_7c: упакованное слово конфигурации маяка; bi_ctrl_program_mac_bcon OR-ит в MAC-команду. */
#define bi_bcon_cfg_w1               (*(u32 *)0x8005a4)   /* [с] Второе слово: bi_ctrl_program_mac_bcon → MAC 0x2b000000|w1|(r13<<11). */
#define tx_bcast_desc_id             (*(u16 *)0x8005b0)   /* [н] tx_bcast_flow: id дескриптора MAC-очереди (sp_buf[2]>>12 & 0xfff); пока ≠0 — дескриптору ставится б19 (macq_desc_write_uc), затем 0. */
#define snr_meas_new                 (*(u16 *)0x8005b2)   /* [с] rx_flow_measure_snr_select_best ставит 1, phy_params_snapshot при ≠0 снимает параметры и обнуляет. */
#define brp_frame_rx_cnt             (*(u16 *)0x8005b4)   /* [с] rx_handle_brp_frame: ++ (vendor ldh.as/sth.as [gp,70]). */
#define bf_brp_req_mask              (*(u16 *)0x8005b6)   /* [с] Бит станции: brp_parse_request_fields ставит (запрос BRP от пира); bf_sm_process_request_fifo при отказе BF не снимает бит в bf_sta_mask, если бит ... */
#define direct_tx_cmd34_hi           (*(u16 *)0x8005ba)   /* [н] direct_tx_program_cmd34: поле a (биты 31:16 MAC-команды 0x34; длина — в 0x800514). Только запись. */
#define rx_on_state                  (*(u16 *)0x8005bc)   /* [с] LMAC 0x01 (RX ON): 1 или 2; 0 — bi_latch_tsf_and_reset (RX OFF) и link lost; проверяют l1_task_*, mac_mode_switch_sequence, uc_tx_is_idle, ucode_cm... */
#define rx_resp_dur                  (*(u16 *)0x8005c0)   /* [н] rx_get_required_response: копия u16 кадра 0x804012 (поле duration) при «нужен ответ» (б12 txrx_state2); delay_800_iters передаёт её в mac_set_secto... */
#define lmac_personality             (*(u32 *)0x8005dc)   /* [в] LMAC 0x15 слово +0 personality (1 = LMAC_PASSIVE: BF не запускается); ucode_cmd_trigger_bf, bf_trigger_for_mid, bf_sm_process_request_fifo. LMAC-PR... */
#define bf_failure_policy            (*(u32 *)0x8005e0)   /* [в] LMAC 0x15 слово +4 failure_policy (1 = BF_RETRY_FOREVER); l1_task_select_by_mode. BF-ENGINE.md даёт 0x8005f0 — это адрес 4.1. */
#define txrx_state1                  (*(u32 *)0x8005f4)   /* [в] txrx_state, слово 1 — контекст потока (0x2 TXOP, 0x4/0x8 RX, 0x10 BTI, 0x20/0x40 TXSS, 0x2000, 0x4000). UC-REGISTERS §4.1. 3 чтения полусловом (тра... */
#define txrx_state2                  (*(u32 *)0x8005f8)   /* [в] txrx_state, слово 2 — ожидаемый ответ и фаза (биты 0..4 режим, б8 ждём, фазы BF). UC-REGISTERS §4.2. 104 обращения, 3 полусловом. */
#define mtp_desc_lo                  (*(u32 *)0x800608)   /* [в] r51 & 0xf (MTP_DESCRIPTOR_SCRATCHPAD); б1 → бит 6 команды 0x19000b00/0x19800830. UC-REGISTERS §4.5. 39 обращений. */
#define mtp_desc_hi                  (*(u32 *)0x80060c)   /* [в] r51 >> 4; <<14 в ту же команду 0x19. UC-REGISTERS §4.5. */
#define l2_wd_fired                  (*(u32 *)0x800624)   /* [в] l2_handle_watchdog ставит 1; l1_task_main_step / l1_task_step_fixed_sched при ≠0 обнуляют и сообщают link lost. UCODE-TASKS.md, VERSION-DIFF.md, NA... */
#define uc_wait_marker               (*(u32 *)0x800628)   /* [в] Метка текущего ожидания для отладки (0xff2f/0xff30 в mac_set_mode_a000, 0xff31 в rx_get_required_response; 0 после выхода). volatile. */
#define bti_busy_cancel_cnt          (*(u32 *)0x80062c)   /* [в] bti_worker_bti_transmitter_beacon_sweep_flow: ++ при отмене развёртки маяка по busy2 (r42.б14), обнуляется при успехе. BEACONING.md («счётчик 0x800... */
#define rf_switch_wait_cnt           (*(u32 *)0x800630)   /* [с] mac_rf_switch_cmd1f: ++ на каждой итерации ожидания r40[2:0]==5, затем 0. UCODE-TASKS §1.3 называет 0x800630 маской фоновых задач — это 4.1 (в 6.2 ... */
#define bf_tmo_tick                  (*(u32 *)0x800688)   /* [н] l1_task_select_by_mode: ++ при каждом вызове, пока голова кольца BF в состоянии 0x12; при таймауте (>1000 мкс) сохраняется в 0x80068c и обнуляется.... */
#define bf_tmo_tick_last             (*(u32 *)0x80068c)   /* [н] Значение 0x800688 на момент таймаута BF-запроса. Только запись. */
#define bf_reset_sta_cnt             (*(u32 *)0x800690)   /* [н] bf_reset_sta_slot: ++ (сброс слота станции BF). */
#define abif_dvs_rf_ctrl_shadow      (*(u32 *)0x8006a0)   /* [в] Тень 0x889488 abif_dvs_rf_ctrl: uc меняет [25:24] (набор RF на TX/RX) и [23:16]. UC-REGISTERS §4.4. 82 обращения. */
#define rx_flow_hit                  (*(u32 *)0x8006a4)   /* [н] rx_flow_run: ++ при совпадении seq (трасса 0xeeee07), в конце перезаписывается r13 (итог прохода). Только запись. */
#define tx_resp_sent                 (*(u32 *)0x8006bc)   /* [н] 1 — в слоте передан управляющий кадр/ответ (rx_handle_status_flags, tx_sta_flow_loop, rx_funcs_rx_flow); fixed_sched_run_tx_slot при ≠0 ждёт событи... */
#define tx_rx_flow_ran               (*(u32 *)0x8006c0)   /* [н] 1 — после TX выполнен rx_flow_run (tx_sta_flow_loop, tx_bcast_flow, rx_handle_status_flags); fixed_sched_run_tx_slot при ≠0 ставит бит станции в 0x... */
#define tx_busy_start_tsf            (*(u32 *)0x8006e0)   /* [с] TSF начала TX/TXOP (txop_initiator_open_txop_flow, internal_tx_flow_sm2/4/6, rx_get_required_response: tsf−0xe); rx_funcs_rx_flow / fixed_sched_run... */
#define sls_ssw_ta_ok_cnt            (*(u32 *)0x8006e4)   /* [в] sls_rx_ssw_frame: счётчик SSW с TA старшей ожидаемой станции (TA запоминается в 0x802188). BF-ENGINE.md (живьём 72000+). */
#define sls_ssw_ta_mismatch_cnt      (*(u32 *)0x8006e8)   /* [в] sls_rx_ssw_frame: несовпадение TA при пустой маске BF. BF-ENGINE.md. */
#define bti_defer_active             (*(u32 *)0x800714)   /* [н] bti_worker_bti_transmitter_beacon_sweep_flow: 0 → запомнить TSF в 0x803110 и =1 (отложить), ≠0 → вычислить задержку; 0 после развёртки. */
#define uc_skip_core_check           (*(u8 *)0x80072c)   /* [с] uc_init: ==1 — пропустить проверку MULTIPLY_BUILD (AUX 0x7b ∈ {1,4}, иначе flag 1). Только чтение. UC-REGISTERS §3. (ucdata_report относит 0x80072c... */
#define rss_wait_clk_x10             (*(u32 *)0x8020ec)   /* [с] = 0x8020c4+0x28 (индекс 10, за концом таблицы из 9). Единственное обращение — ld в txss_resp__wait_iss_end → mac_program_4f_52(v,4) (GP4). В vuc.di... */
#define maint_sta_mask               (sls.maint_sta_mask)   /* [в] Маска станций «на поддержании»/ассоциированных (LMAC 0x0f, карта 0x80218c+8): BRP после SLS, ответчик A-BFT, AW, link-lost (старшая станция), fixed... */
#define maint_sta_mask_prev          (sls.maint_sta_mask_prev)   /* [в] Прошлое значение 0x802194 (cmd 0x0f пишет перед обновлением); rx_get_required_response: AP отбрасывает кадр, если бит снят сейчас, но был раньше. D... */
#define rx_sw_sifs_cnt               (*(u32 *)0x802448)   /* [с] Снимок R55 (SIFS_CNT после MAC 0x4d) в rx__switch_to_rx_mode; >0x500 или 0 → MAC 0x1f000601. Только запись. */
#define link_lost_cnt                (*(u32 *)0x80244c)   /* [в] Счётчик срабатываний l1_task__report_link_lost (=0x80242c+0x20; UCODE-TASKS §2.1). Перед событием link_lost в fw. */
#define rx_mode_hist_idx             (*(u8 *)0x80260c)   /* [в] Индекс записи кольца rx_mode_hist (0..15). Не литерал. */
#define rf_set_tx                    (*(u32 *)0x802940)   /* [в] Набор RF (2 бита dvs_if_splitter_enable) на время TX: (0x8006a0 & 0xfcffffff) | v<<24 → 0x889488 (rf__compute_tx_rx_sets пишет; ~40 читателей). UC-... */
#define rf_set_rx                    (*(u32 *)0x802944)   /* [в] То же для RX (возврат после передачи). */
#define qid_agg_mask                 (*(u32 *)0x802948)   /* [в] Маска qid с агрегацией (BlockAck): ставит ucode_cmd_0x08 (r43.aggregation_enabled), l1_fixed_sched_ap__ev4_state4; снимает cmd 0x08 и rx__dispatch_... */
#define tx_ctx_seq                   (*(u32 *)0x8029f8)   /* [в] Счётчик выделений (номер слота = seq&1), tx_ctx__alloc_next. Не литерал (0x802978+0x80). */
#define bi_pos_snap                  (*(u32 *)0x802f10)   /* [с] Позиция в BI (r40 & 0x3ffffff при селекторе 0x1d004000), снимок в l1__snapshot_bi_counter; только запись. */
#define bcn_nav_wait_tsf             (*(u32 *)0x803110)   /* [с] TSF начала ожидания маяка из-за NAV (bti_worker…: «Beacons delay due to NAV»), +4 = прошедшее; ≥30000 мкс → передавать. */
#define bcn_nav_wait_us              (*(u32 *)0x803114)   /* [с] Прошедшее время ожидания (0x803110+4). Не литерал. */

/* ---- Рантайм-переменные (без начальных значений; имена — по чтениям vendor и нашего кода).
 * Уверенность в смысле: [в] высокая, [с] средняя, [н] низкая. ---- */
#define brp_frame_category           (*(u8 *)0x8008b0)   /* [в] уже поле brp_frame (dccm.h); начало 14-байтового тела BRP-кадра, mac.c 489 tx_fifo_write_bytes(0x8008b0, 0xe) → тело 0x8008b0..0x8008bd */
#define brp_frame_dmg_br_elem        (*(u32 *)0x8008b8)   /* [с] +0x20 — ЗА концом struct brp_frame_tpl (0x20 Б), но внутри передаваемого тела: байт 0 = длина элемента (=5; elem_id 0x99 в 0x8008b7), б8 (Initiator... */
#define brp_frame_dmg_br_tail        (*(u16 *)0x8008bc)   /* [с] +0x24: последние 2 байта элемента DMG Beam Refinement (обнуляет brp_init_tx_request, brp.c 535 stw_s [r2,0x24]); входит в 14 Б тела */
#define uc_init_desc_key             (*(u32 *)0x800fe0)   /* [в] +0x0: ключ сортировки (timer_list_insert_sorted: val=*(u32*)obj). */
#define uc_init_desc_next            (*(u32 *)0x800fe8)   /* [в] +0x8: следующий в списке; до вставки младший байт = prio (uc_list_insert_by_prio читает *(u8*)(obj+8)). */
#define snr_meas_stats_cnt_ok        (*(u32 *)0x801014)   /* [с] счётчик замеров с 1..0x7f отсчётами (+0xd в 1..0x7f); tail.c 3147 */
#define snr_meas_stats_cnt_ge128     (*(u32 *)0x801018)   /* [с] счётчик замеров с ≥0x80 отсчётами; tail.c 3149 */
#define snr_meas_stats_cnt_zero      (*(u16 *)0x80101c)   /* [с] счётчик замеров с 0 отсчётов (+0xd == 0); tail.c 3144–3145 */
#define snr_meas_stats_cnt_no_meas   (*(u16 *)0x80101e)   /* [с] счётчик снимков без замера (0x8005b2 == 0, т.е. rx_flow_measure_snr_select_best не вызывался); tail.c 3136 */
#define snr_meas_stats_last_samples  (*(u8 *)0x801021)   /* [в] число отсчётов SNR (r9, шаг 8, ≤ [0x8021b8]) последнего замера: rx.c 2446 rx_flow_measure_snr_select_best (vendor 0x92d7a8 stb r9,[0x801021]); чита... */
#define pm_busy                      (*(u32 *)0x8014b4)   /* [в] флаг занятости PM (ucode_pm_set_busy_flag, uutil.c 254 [+0x10]); 0 → вход в listen / разрешение сна (tail.c 3032, 3047) */
#define pm_idle_veto_reason          (*(u32 *)0x8014b8)   /* [в] причина отказа от idle в background_bi_step: 1 — r41, 2 — r42 бит 19, 3 — мало времени с listen, 4 — у станции мало (bg_bi_thr_b) пакетов, 0 — не п... */
#define ss_rfset                     (*(struct ss_cfg_s *)0x801694)   /* план секторов развёртки по набору RF (bti_prepare_sweep_set: order[], n_frames = ss_plan_n_sectors, x49 = ss_plan_set); txss_program_tx_frame — для AP с ≥2 наборами RF и omni-пиром */
#define ss_plan_n_sectors            (*(u8 *)0x8016dc)   /* [в] +0x48: число секторов в развёртке (bti.c 1183/1187; txss.c 472 r15+8). */
#define ss_plan_set                  (*(u8 *)0x8016dd)   /* [в] +0x49: индекс набора секторов/RF-сета (bti.c 1189; txss.c 469 r15+9). */
#define rx_capture_defaults_mode     (*(u8 *)0x8017c9)   /* [н] [1]: значение «режим» для сравнения с фильтром +0x25 (rx.c 2520); единственный значимый байт шаблона. */
#define sls_x64                      (sls.x64)   /* [н] u16, только запись 0 (bf_sm__on_brp_resp, bf_sm__set_state ×2). Читателей не найдено. */
#define sls_rank_valid_mask          (sls.rank_valid_mask)   /* [в] Биты станций, для которых сохранён рейтинг секторов в 0x857c1c (txss__store_sector_ranking |=, bf__clear_sta_bit_state34 &=~); sls__rx_ssw_frame ра... */
#define sls_rank_valid_mask2         (sls.rank_valid_mask2)   /* [с] Парная маска, сбрасывается вместе с 0x802192 (bf__clear_sta_bit_state34); установщиков в коде не найдено. */
#define mac_cfg                      ((u8 *)0x802588)    /* [0x30] копия тела LMAC-команды настройки MAC (ucode_cmd_apply_mac_cfg): +0/+1 — mac_cfg_sifs_*, +0..+0x13 → MAC 0x886e08..0x886e18 (L_92f1a0) */
#define mac_cfg_sifs_clk_adj         (*(u8 *)0x802588)   /* [в] +0: добавка тактов к SIFS: clks = SIFS_CNT.clks + [0x802588] + 13 (rx_flow_step → mac_clk__div165); живьём 4. LMAC-PROTOCOL.md L306-309. */
#define mac_cfg_sifs_us_adj          (*(u8 *)0x802589)   /* [в] +1: добавка микросекунд к SIFS (usec = SIFS_CNT.usec + [0x802589] + перенос); живьём 1. */
#define cmd20_cfg_rx_flags           (*(u32 *)0x8025d8)   /* [с] +0x20 тела LMAC 0x20: б0/б1 выбирают, какой из счётчиков uc_stats+0x50..0x5c растёт (rx_flow__run). UC-REGISTERS §4.7. */
#define bcast_ctx_qid                (*(u32 *)0x802b14)   /* [н] +4 = 0x1f (bi_mode__init_sta_table). */
#define bcast_ctx_flags              (*(u32 *)0x802b1c)   /* [н] +0xc = 0x11 (bi_mode__init_sta_table). */
#define ssw_tpl_ra                   ((u16 *)0x802b50)    /* [в] +4: RA шаблона SSW (3×u16) */
#define ssw_tpl_fc                   (*(u16 *)0x802b4c)   /* [в] +0: Frame Control (=0x864: управляющий, Control Frame Extension). */
#define ssw_tpl_fb_sector            (*(u8 *)0x802b5f)   /* [в] +0x13: SSW-Feedback байт0 = sector | antenna<<6; в FIFO через arc_core_wr(34). */
#define ssw_tpl_fb_snr               (*(u8 *)0x802b60)   /* [в] +0x14: SNR report. */
#define ssw_tpl_fb_b2                (*(u8 *)0x802b61)   /* [в] +0x15: третий байт поля (0/poll). */
#define ssw_tpl_fb_w14               (*(u16 *)0x802b60)  /* [в] +0x14: байты 1–2 SSW-Feedback полусловом (ISS): б0 — Total Sectors б8, б1–2 — RX DMG-антенн − 1 (txss_program_tx_frame). */
/* Разбор поля SSW принятого кадра на стеке (txss.c: rx_parse_ssw_field → {сектор, антенна,
 * SNR}; phy_params_snapshot пишет первые два слова). 0xc Б. */
struct ssw_parse {
    u32  sector;                        /* +0 сектор (+ база набора RF) */
    u32  antenna;                       /* +4 DMG-антенна [7:6] */
    u8   snr;                           /* +8 байт SNR (знаковый уровень) */
    u8   _9[3];
};
_Static_assert(sizeof(struct ssw_parse) == 0xc, "ssw_parse");

/* Итог отправки управляющего PPDU (mtp_queue_release_mgmt → txop_await_cts_ppdu): буфер на
 * стеке вызывающего (tail.c sp_buf[1..3]), 0xc Б. */
struct mtp_resp_info {
    u32  mcs;                           /* +0 r43 [20:16] */
    u32  cfg_10;                        /* +4 sta_tab[r43 [11:8]].cfg_10 */
    u32  tx_sel;                        /* +8 sta_tab[…].tx_sel → окно приёма CTS */
};
_Static_assert(sizeof(struct mtp_resp_info) == 0xc, "mtp_resp_info");

/* Тайминг развёртки (8 Б): запись txss_timing[] (txss_sweep_timing), буфер на стеке
 * (bti_measure_frame_duration, txss_sweep_duration_for_sta). Читают txss_set_sweep_param
 * (ss_plan_tx_dur = total + gap), ss_plan_next_sector (−= frame + gap), BTI (+= frame + gap). */
struct ss_timing {
    u16  total;                         /* +0 длительность всей развёртки */
    u16  frame;                         /* +2 кадр SSW: txss_timing_base или замер r47 (маяк) */
    u16  gap;                           /* +4 MMIO 0x886d0c [31:24] */
    u16  _6;
};
_Static_assert(sizeof(struct ss_timing) == 8, "ss_timing");
#define txss_timing                  ((u16 (*)[4])0x802e64)   /* [9][4] тайминги развёртки по станциям (txss_sweep_timing: {B, A, ...}), ucode_cmd_0x0b_handler; до bcast 0x802eac */
#define pm_idle_tsf                  ((u32 *)0x8014a4)   /* [2] TSF64 входа в idle (uc_pm_enter_idle); data.c: +0x18 б0 */
#define rx_listen_tsf                ((u32 *)0x8014ac)   /* [2] TSF64 начала прослушивания (rx_listen_set_flag_and_stamp_tsf); l1: uc_tsf_elapsed(lo) */
#define ss_plan_tx_dur               (*(u32 *)0x802e54)   /* [в] Длительность передачи кадра (MAC v|b24|b26|b28): = A+B из тайминга (txss__set_sweep_param), += в BTI, −= в ss_plan__next_sector. */
#define ss_plan_cdown                (*(u8 *)0x802e5c)   /* [в] CDOWN (оставшиеся кадры): <<1 в поле команды 0x2d; декремент в ss_plan__next_sector. */
#define ss_plan_sector               (*(u8 *)0x802e5d)   /* [в] Текущий сектор: <<10 в команде 0x2d. */
#define ss_plan_rf_sector            (*(u8 *)0x802e5e)   /* [в] Сектор + смещение набора (sector + 0x802e60): <<8 в окне приёма/слове режима (0x802aec). */
#define ss_plan_passes_left          (*(u8 *)0x802e5f)   /* [с] Оставшиеся проходы по порядку (a2 из txss__set_sweep_param; при исчерпании порядка −1 и индекс в 0, <2 → конец развёртки). */
#define ss_plan_set_base             (*(u8 *)0x802e60)   /* [с] Базовый номер сектора набора из таблицы [0x8577b0]+2·a5. */
#define ss_plan_idx                  (*(u8 *)0x802e61)   /* [в] Индекс в ss_order_cur. */
#define rx_buf_status1               (*(u32 *)0x804004)   /* [с] +4: слово статуса; б23 → rx__update_nav_from_frame передаёт FC (DATAPATH «при бите 23 0x804004 передаёт FC»). */
#define rx_buf_fc                    (*(u16 *)0x804010)   /* [в] Frame Control принятого кадра (rx_nav__set_from_duration(1,fc,dur,ta), rx__update_nav_from_frame); 0x804010 также база u8 *f в rx_flow__handle_fram... */
#define rx_buf_duration              (*(u16 *)0x804012)   /* [в] +2: Duration/ID (NAV; −0x14 в rx__send_dmg_cts; ≠0 у CF-End → ответ 8; → 0x8005c0 у Grant; bti_transmitter_bi2_flow). */
#define rx_buf_ssw                   (*(u16 *)0x804020)   /* [в] +0x10: SSW (у SSW-кадра: б0 Direction, б10..15 Sector ID; u16>>10) или SSW-Feedback (у SSW-FB/кадра A-BFT: &0x3f Sector Select, >>6&3 Antenna Selec... */
#define rx_buf_fb_snr                (*(s8 *)0x804021)   /* [в] +0x11: SNR Report поля SSW-Feedback (ldb.x). */
#define rx_buf_bcn_ssw               (*(u16 *)0x804022)   /* [в] +0x12: у DMG Beacon — поле SSW: >>10 Sector ID (у SSW-кадра +0x12 &3 — антенна). */
#define rx_buf_ssw_fb0               (*(u8 *)0x804023)   /* [в] +0x13: SSW-Feedback у SSW-кадра (&0x3f сектор, >>6 антенна) — phy_params__snapshot, rx_funcs__handle_ppdu_report. Не литерал. */
#define rx_buf_bcn_ssw_hi            (*(u16 *)0x804024)   /* [в] +0x14: у маяка байт SSW: &3 DMG Antenna ID. */
#define rx_buf_body18                (*(u8 *)0x804028)   /* [в] +0x18: у action-кадра — Category (0x14 = BRP-кадр по rx__is_brp_frame/rx__handle_brp_frame; STANDARD-MAPPING: 20); у маяка — байт 1 BI Control; u16... */
#define rx_buf_body19                (*(u8 *)0x804029)   /* [в] +0x19: Action (==1 — BRP) / байт 2 BI Control. */
#define rx_buf_body1a                (*(u8 *)0x80402a)   /* [с] +0x1a: Dialog Token / байт 3 BI Control. */
#define rx_buf_brp_req               (*(u8 *)0x80402b)   /* [в] +0x1b: BRP Request, байт 0: &0x1f L-RX (rx__handle_brp_frame, brp__parse_request_fields) / байт 4 BI Control. */
#define rx_buf_body1c                (*(u8 *)0x80402c)   /* [с] +0x1c: байт 5 BI Control / BRP Request. */
#define rx_buf_bcn_dmg_params        (*(u8 *)0x80402d)   /* [в] +0x1d: DMG Parameters маяка (&3 BSS Type). */
#define rx_buf_brp_elem              (*(u16 *)0x804030)   /* [с] +0x20..+0x21: поле элемента DMG Beam Refinement (бит 10 → sls_rx.flags|=0xa00); байтовый доступ к 0x804030/31. */
#define rx_buf_brp_x24               (*(u16 *)0x804034)   /* [н] +0x24 (brp__parse_request_fields). Не литерал. */
#define qset_shadow                  (*(struct qset_shadow_s *)0x800400)
#define g800610                      (*(struct g800610_s *)0x800610)
#define busy_acct                    (*(struct busy_acct_s *)0x800634)
#define fsched_ctx                   (*(struct fsched_ctx_s *)0x80064c)
#define brp_rf_cfg                   (*(struct brp_rf_cfg_s *)0x80066c)
#define mac_mode_sw                  (*(struct mac_mode_sw_s *)0x8006a8)
#define itx_pending                  (*(struct itx_pending_s *)0x8006cc)
#define vring_dbg                    (*(struct vring_dbg_s *)0x8006ec)
#define cmdq_desc                    (*(struct cmdq_handler_desc *)0x800730)
#define power_stats                  (*(struct power_stats_s *)0x8007b8)
#define init_desc_globals            (*(struct init_desc *)0x8007c8)
#define fsched_flush_stats           (*(struct fsched_flush_stats_s *)0x800814)
#define brp_ctx                      (*(struct brp_ctx_s *)0x800824)
#define brp_rf_regs                  ((struct brp_rf_regs_s (*)[8])0x8008c0)   /* [8 RF][8 станций] */
#define mac_mon_report               (*(struct mac_mon_report_s *)0x801084)
#define pmc_trig                     (*(struct pmc_trigger_cfg *)0x801458)
#define rx_nav                       (*(struct rx_nav_state *)0x80146c)
#define sel_nbr                      (*(struct sel_nbr_state *)0x8014e8)
#define brp_rf                       (*(struct brp_rf_meas *)0x801504)
#define fsched_peers                 (*(struct fsched_peer_ctx *)0x801be8)
#define brp_stats                    (*(struct brp_stats_s *)0x801e94)
#define brp_pick                     (*(struct brp_pick_s *)0x801ff4)
#define bf_rep                       (*(struct bf_report_ctx *)0x8020f0)
#define bf_res                       (*(struct bf_result *)0x802110)
#define bf_ctrl                      (*(struct bf_ctrl_cfg *)0x8021b8)
#define sls_rx                       (*(struct sls_rx_state *)0x8021e0)
#define ba_stats                     (*(struct ba_stats_s *)0x802210)
#define rxf                          (*(struct rx_frame_state *)0x802288)
#define bcn_bi                       (*(struct bcn_bi_state *)0x80229c)
#define bi_cfg                       (*(struct fui_bi_cfg_params *)0x8022a8)
#define uc_stats                     (*(struct uc_stats_s *)0x8022c8)
#define txr                          (*(struct tx_resp_stats *)0x80242c)
#define uc_mbox                      (*(struct uc_mbox_ctx *)0x802470)
#define agc_cfg                      (*(struct agc_cfg_s *)0x8025dc)
#define ifs                          (*(struct ifs_timing *)0x802968)
#define bti_sw                       (*(struct bti_sweep_cfg *)0x802a14)
#define bti_cnt                      (*(struct bti_sweep_cnt *)0x802a6c)
#define itx                          (*(struct itx_state *)0x802aa0)
#define bcast                        (*(struct bcast_stats *)0x802eac)
#define bi_win                       (*(struct bi_win_ctx *)0x802ec0)
#define abft_cfg                     (*(struct abft_resp_cfg *)0x803124)
#define rx_meas                      (*(struct rx_meas_ctx *)0x803134)
#define uc_log                       (*(struct uc_log_s *)0x803234)
#endif /* UC_DCCM_OBJECTS */

#endif
