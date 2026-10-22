/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Общая память fw ↔ uc (SRAM вне DCCM обоих ядер; раскладка vendor 6.2). Одно имя на адрес:
 * типы и имена здесь — общие для fw и uc.
 *
 *  - 0x853800 — блок статистики fw (fw_stats_blk, 0x1c0 Б, адрес — boot_diag.fw_stats_addr):
 *    заголовок fw_stats_hdr, снимок температур, журналы калибровки (fw-only, include/sys_cfg.h,
 *    calib.h, calib_engine.h); здесь — его общая с uc часть: сводка соединений fw_stats_dash
 *    (0x853910) и опубликованный отчёт MAC_MON mac_mon_pub (0x853940, 0x80 Б).
 *  - 0x857000..0x857828 — общий блок (обнуляет crt0 fw, fw/start.S): fwsh_diag, fwq_tx_avail,
 *    ll_ctx, ese_slot_tbl, байты STA-capability, отсчёты энергии fwsh_energy, статистика PHY
 *    fwsh_phy, наборы RF fwsh_sets (результаты и шаблон FTM — только SparRAW-pro).
 *    Дальше (0x857a00..) — только uc: рейтинги секторов, link_stat (uc/dccm.h).
 *  - fixed_sched (0x847a3c) — объект fw (символ fw/fw.ld); uc читает его по указателю
 *    fwsh_sets.fsched_tbl.
 *
 * fw: объекты — символы fw/fw.ld (extern ниже). uc: те же имена — макросы на литеральный
 * адрес (uc/dccm.h определяет FWSH_UC до включения): с extern-символами gcc теряет общую базу
 * и короткие смещения, а в uc тайминг без запаса. Совпадение адресов fw.ld и макросов uc
 * проверяет tools/check_fwsh.py при компоновке fw.elf. Квалификаторы: обращения uc — volatile
 * (макросы на volatile-объект), у fw — как у vendor (обычные; где vendor перечитывает — VOL()).
 * Смещения закреплены _Static_assert. */
#ifndef FWSH_H
#define FWSH_H
#include "types.h"

#define FWSH_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

/* ---------------- блок статистики fw 0x853800: общая с uc часть ---------------- */

/* Сводка соединений и счётчики (0x853910, 0x30 Б; vendor dashboard__add_connection 0x8eabfc,
 * dashboard__on_disconnect 0x8eab88, calib_engine__accumulate_if_enabled 0x8eaa20). */
struct fw_stats_dash {
    u32 conn_time;                             /* 0x00 (0x853910): время с соединением (+= dt при conn_mask ≠ 0;
                                                *       обнуляется первым соединением) */
    u32 nav_time;                              /* 0x04 (0x853914): uc — младшее слово nav_accum64 (NAV, мкс);
                                                *       fw — занятость эфира скана (scan.c) */
    u32 state;                                 /* 0x08 (0x853918): [31:29] число соединений, [27:24] = 0xf
                                                *       при загрузке, б21/б22/б15 — флаги LMAC 0x1e (link_sm.c) */
    u32 pm_idle_cnt;                           /* 0x0c (0x85391c): uc — входы в idle (uc_pm_enter_idle) */
    u8  conn_mask;                             /* 0x10 (0x853920): cid с соединением */
    u8  rsv_11[3];
    u32 rx_ppdu;                               /* 0x14 (0x853924): uc — принятых PPDU (uc_stats.rx_ppdu) */
    u32 fa_cnt[6];                             /* 0x18 (0x853928..0x85393c): ложные тревоги (FA_IN/OUT_TXOP_*);
                                                *       uc пишет [1]/[2]/[3]/[5] (rx_flow), fw — в журнал
                                                *       (link_lost_diag__dump_false_alarms) */
};
FWSH_OFF(struct fw_stats_dash, state, 0x08);
FWSH_OFF(struct fw_stats_dash, conn_mask, 0x10);
FWSH_OFF(struct fw_stats_dash, fa_cnt, 0x18);
_Static_assert(sizeof(struct fw_stats_dash) == 0x30, "fw_stats_dash");

/* Слот BTI отчёта MAC_MON (0x28 Б): двойной буфер uc mac_mon_slot (0x801030) и часть отчёта
 * (+4). docs/MAC-MON.md. */
struct mac_mon_slot_s {
    u32  bcon_bitmap_lo;                /* +0x00 писателя в uc нет */
    u32  bcon_bitmap_hi;                /* +0x04 */
    u32  bti_start[2];                  /* +0x08 TSF начала BTI */
    u32  bti_duration;                  /* +0x10 */
    u8   rssi_valid;                    /* +0x14 */
    u8   _15[3];
    s32  rssi;                          /* +0x18 максимум метрики маяка; сброс 0xffffff00 */
    u8   snr_valid;                     /* +0x1c пишет fw (lmac_if__update_pct_stats) */
    u8   _1d[3];
    s32  snr;                           /* +0x20 сброс 0xffffff00; пишет fw (индекс LUT по rssi) */
    u8   tx_bcon;                       /* +0x24 передано маяков в развёртке */
    u8   rx_bcon;                       /* +0x25 принято совпавших маяков */
    u8   detected;                      /* +0x26 маяк принят */
    u8   _27;
};
FWSH_OFF(struct mac_mon_slot_s, rssi, 0x18);
FWSH_OFF(struct mac_mon_slot_s, snr, 0x20);
FWSH_OFF(struct mac_mon_slot_s, detected, 0x26);
_Static_assert(sizeof(struct mac_mon_slot_s) == 0x28, "mac_mon_slot");

/* Отчёт MAC_MON (0x80 Б): рабочая копия uc mac_mon_report (0x801084) и опубликованная —
 * mac_mon_pub (0x853940): peer_slots_scan_by_masks копирует её memcpy и шлёт событие 0x17. */
struct mac_mon_report_s {
    u32  size;                      /* +0x00 =0x80 после публикации (misc.c 438) */
    union {                         /* +0x04 копия неактивного mac_mon_slot при публикации */
        u32  slot[10];              /*       словами (публикатор) */
        struct mac_mon_slot_s bti;  /*       полями (fw: link_loss.c, lmac_evt.c) */
    };
    u32  aw_start_lo;               /* +0x2c AW start TSF lo (отчёт +0x2c), tail.c 1009 r7[0x20] ← 0x802efc */
    u32  aw_start_hi;               /* +0x30 AW start TSF hi (+0x30), tail.c 1014 r7[0x21] */
    u32  aw_duration;               /* +0x34 длительность AW (+0x34), tail.c 1011 r7[0x22] */
    u8   aw_backoff;                /* +0x38 backoff AW (+0x38): bi_rx_slot_handler ++[0x801030+0x8c] (bi.c 611) */
    u8   tx_atim_pass;              /* +0x39 tx atim pass (+0x39) — по MAC-MON.md; в C адресом не встречается */
    u8   tx_atim_fail;              /* +0x3a tx atim fail (+0x3a) — по MAC-MON.md */
    u8   tx_atim_cnt;               /* +0x3b tx atim counter (+0x3b): bi.c 517 ++[0x8010b0+0xf] после bi_rx_send_response */
    u8   rx_atim;                   /* +0x3c rx atim (+0x3c): rx.c 1650 ++ при приёме ATIM (peer_masks_apply_op 0x802f80 op 3) */
    u8   bcons_atim_fail_vec;       /* +0x3d битовый вектор станций (+0x3d): публикатор сохраняет/пишет (misc.c 399/414/444); fw — запрос разрыва (link_loss.c) */
    u8 _pad1[2];
    u32  dti_start_lo;              /* +0x40 DTI start lo (+0x40): r7[0x25] (tail.c 1018). Комментарий в tail.c «0x8010d4» неверен: r7  */
    u32  dti_start_hi;              /* +0x44 DTI start hi (+0x44): r7[0x26]; комментарий «0x8010d8» в tail.c 1019 неверен */
    u32  dti_duration;              /* +0x48 длительность DTI (+0x48): r7[0x27]; комментарий «0x8010dc» в tail.c 1015 неверен */
    u32  nav_accum;                 /* +0x4c накопитель NAV (+0x4c): rx_nav_set_from_duration += r13 (rx.c 2352) */
    u32  rx_listen_time;            /* +0x50 +0x50 (только 6.2, смысл по MAC-MON.md не установлен): l1.c 660 += TSF − [0x8006e0] (метка */
    u32  busy_time;                 /* +0x54 +0x54 занятость среды [гипотеза MAC-MON.md]: l1_task_entry += 0xa при [0x800634] != 0 (l1. */
    u16  dti_backoff;               /* +0x58 backoff DTI (+0x58): fixed_sched_run_tx_slot ++ (l1.c 616) */
    u16  tx_rts;                    /* +0x5a tx rts (+0x5a): tail.c 2561 */
    u16  rx_cts;                    /* +0x5c rx cts (+0x5c): tx_sta_wait_slot_and_tx, обычная передача (tx.c 1112) */
    u16  rx_dts;                    /* +0x5e rx dts (+0x5e): tx.c 1105 */
    u16  rx_rts;                    /* +0x60 rx rts (+0x60): rx_get_required_response (rx.c 1681) */
    u16  tx_cts;                    /* +0x62 tx cts (+0x62): по MAC-MON.md (rx_flow__handle_frame); абсолютным адресом в C не встречает */
    u16  tx_dts;                    /* +0x64 tx dts (+0x64): rx_send_response_frame (rx.c 325) */
    u16  cf_end;                    /* +0x66 cf end (+0x66): tx.c 869 (tx__send_and_await_rx_frame) */
    u8   ka_pass;                   /* +0x68 keep-alive pass (+0x68): internal_tx_flow_sm2, ACK получен (tx.c 1194) */
    u8   ka_fail;                   /* +0x69 keep-alive fail (+0x69): tx.c 1197/1203 */
    u8 _pad2[1];
    u8   itx_rf_fail;               /* +0x6b +0x6b, в MAC-MON.md нет: internal_tx_flow_sm4 ++ при неудаче itx_wait_cts_rf / itx_wait_ac */
    u32  rx_off_duration;           /* +0x6c rx off duration (+0x6c): ucode_cmd_0x01 += TSF − [0x800540] (cmd.c 974) */
    u32  fs_evt14_cnt;              /* +0x70 +0x70 (fixed scheduling, MAC-MON.md): ++ когда после mac_select_all_sectors_and_wait пришл */
    u32  fs_no_slot_cnt;            /* +0x74 +0x74 (fixed scheduling): ++ при sp == 0x1f — нет слота (tx.c 703, tail.c 2252/2296) */
    u32  bi2_events;                /* +0x78 +0x78 события BI2: bti.c 863 ++[0x801030+0xcc] */
    u32  aw_tbtt_state;             /* +0x7c всегда 0: писал aw_tbtt__count_intervals (расписание PS) — PS вырезан; fw не читает */
};
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, size) == 0x0, "mac_mon_report.size");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, bti) == 0x4, "mac_mon_report.bti");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, aw_start_lo) == 0x2c, "mac_mon_report.aw_start_lo");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, aw_start_hi) == 0x30, "mac_mon_report.aw_start_hi");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, aw_duration) == 0x34, "mac_mon_report.aw_duration");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, aw_backoff) == 0x38, "mac_mon_report.aw_backoff");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, tx_atim_pass) == 0x39, "mac_mon_report.tx_atim_pass");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, tx_atim_fail) == 0x3a, "mac_mon_report.tx_atim_fail");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, tx_atim_cnt) == 0x3b, "mac_mon_report.tx_atim_cnt");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, rx_atim) == 0x3c, "mac_mon_report.rx_atim");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, bcons_atim_fail_vec) == 0x3d, "mac_mon_report.bcons_atim_fail_vec");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, dti_start_lo) == 0x40, "mac_mon_report.dti_start_lo");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, dti_start_hi) == 0x44, "mac_mon_report.dti_start_hi");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, dti_duration) == 0x48, "mac_mon_report.dti_duration");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, nav_accum) == 0x4c, "mac_mon_report.nav_accum");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, rx_listen_time) == 0x50, "mac_mon_report.rx_listen_time");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, busy_time) == 0x54, "mac_mon_report.busy_time");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, dti_backoff) == 0x58, "mac_mon_report.dti_backoff");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, tx_rts) == 0x5a, "mac_mon_report.tx_rts");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, rx_cts) == 0x5c, "mac_mon_report.rx_cts");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, rx_dts) == 0x5e, "mac_mon_report.rx_dts");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, rx_rts) == 0x60, "mac_mon_report.rx_rts");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, tx_cts) == 0x62, "mac_mon_report.tx_cts");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, tx_dts) == 0x64, "mac_mon_report.tx_dts");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, cf_end) == 0x66, "mac_mon_report.cf_end");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, ka_pass) == 0x68, "mac_mon_report.ka_pass");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, ka_fail) == 0x69, "mac_mon_report.ka_fail");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, itx_rf_fail) == 0x6b, "mac_mon_report.itx_rf_fail");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, rx_off_duration) == 0x6c, "mac_mon_report.rx_off_duration");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, fs_evt14_cnt) == 0x70, "mac_mon_report.fs_evt14_cnt");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, fs_no_slot_cnt) == 0x74, "mac_mon_report.fs_no_slot_cnt");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, bi2_events) == 0x78, "mac_mon_report.bi2_events");
_Static_assert(__builtin_offsetof(struct mac_mon_report_s, aw_tbtt_state) == 0x7c, "mac_mon_report.aw_tbtt_state");
_Static_assert(sizeof(struct mac_mon_report_s) == 0x80, "mac_mon_report");

/* ---------------- общий блок 0x857000 ---------------- */

/* Диагностика и счётчики (0x857000, 0x40 Б; в 6.2 переложен относительно 4.1 —
 * docs/LINK-STATS-PHY.md). */
struct fwsh_diag {
    u32 ka_cnt;                                /* 0x00: uc — отправлено keep-alive (internal_tx_flow_sm2) */
    u32 ka_fail_cnt;                           /* 0x04: uc — keep-alive без ответа до порога BF */
    u32 bcn_psdu_len;                          /* 0x08: fw — длина PSDU DMG Beacon (MPDU + FCS 4 Б), TX_API_send_dband_bcon;
                                                *       uc — TXOP BTI по TXTIME (bti.c) */
    u32 fw_assert_code;                        /* 0x0c: fw_sysassert_fatal — код */
    u32 fw_assert_caller;                      /* 0x10: … и место вызова */
    u32 uc_assert_code;                        /* 0x14: uc_assert — код (fw: вектор 6, sysassert_dump_ucode_int6) */
    u32 uc_assert_caller;                      /* 0x18: … и место вызова */
    u32 uc_wd_pm_ms[2];                        /* 0x1c: uc L2-сторож — счётчики PM (мс) до/после пересчёта */
    u32 bti_txop_fallback;                     /* 0x24: uc — TXOP BTI по r47 (vendor): длина маяка не сходится с r47 */
    u32 rsv_28;
    u32 rts_rx;                                /* 0x2c: uc — принят RTS в TXOP (rx_txop_rts) */
    u32 bcn_nav;                               /* 0x30: uc — развёртка маяка при NAV (beacon_nav) */
    u32 rx_arm;                                /* 0x34: uc — обработанные PPDU (зеркало uc_stats.rx_arm) */
    u32 brp_cfg_x;                             /* 0x38: fw — слово board-файла за масками BRP (читателей нет) */
    union {                                    /* 0x3c: uc — маски пиров окна пробуждения */
        u8  aw_peers[4];
        u32 aw_peers_w;                        /*       пишутся одним словом (aw_worker_collect_awake_peers) */
    };
};
FWSH_OFF(struct fwsh_diag, fw_assert_code, 0x0c);
FWSH_OFF(struct fwsh_diag, uc_assert_code, 0x14);
FWSH_OFF(struct fwsh_diag, uc_wd_pm_ms, 0x1c);
FWSH_OFF(struct fwsh_diag, rts_rx, 0x2c);
FWSH_OFF(struct fwsh_diag, aw_peers, 0x3c);
_Static_assert(sizeof(struct fwsh_diag) == 0x40, "fwsh_diag");

/* FWQ_TX_AVAILABILITY (0x24 Б, 0x857040): кадры в очередях по cid (0..8) — всего и
 * приоритетных, и маски cid с ненулевым счётчиком (fw); слово 0 пишет uc. */
struct fwq_tx_avail {
    u32 aw_info;                               /* 0x00: uc — [7:0] копия mask, б25..27 — флаги окна
                                                *       пробуждения (aw_worker_collect_awake_peers, misc.c) */
    volatile u8 count[9];                      /* 0x04 */
    u8  rsv_0d[3];
    volatile u32 mask;                         /* 0x10: cid с count ≠ 0 */
    volatile u8 prio_count[9];                 /* 0x14 */
    u8  rsv_1d[3];
    volatile u32 prio_mask;                    /* 0x20: cid с prio_count ≠ 0 */
};
FWSH_OFF(struct fwq_tx_avail, mask, 0x10);
FWSH_OFF(struct fwq_tx_avail, prio_count, 0x14);
FWSH_OFF(struct fwq_tx_avail, prio_mask, 0x20);
_Static_assert(sizeof(struct fwq_tx_avail) == 0x24, "fwq_tx_avail");

/* Параметры поддержания линка cid (0x24 Б; WMI: link_maintain_cfg_apply / lm_cfg_read). */
struct ll_cid_cfg {
    u32 flags;                                 /* 0x00: б0 — старение TX, б1 — keep-alive, б2 — плохие биконы */
    u32 period;                                /* 0x04: период прогона детекторов */
    u32 ageing_thr;                            /* 0x08: порог простоя TX до разрыва */
    u32 ka_period_hi;                          /* 0x0c: период keep-alive (по умолчанию / высокий SNR) */
    u32 ka_period_lo;                          /* 0x10: период keep-alive при низком SNR */
    s32 snr_lo;                                /* 0x14: порог низкого SNR (знаковый) */
    s32 snr_hi;                                /* 0x18: порог высокого SNR (знаковый) */
    u32 bcn_thr;                               /* 0x1c: порог BI без бикона (× conn_multi_omni_count) */
    s32 bcn_snr;                               /* 0x20: SNR «хорошего» линка для детектора биконов */
};
FWSH_OFF(struct ll_cid_cfg, ka_period_hi, 0x0c);
FWSH_OFF(struct ll_cid_cfg, bcn_snr, 0x20);
_Static_assert(sizeof(struct ll_cid_cfg) == 0x24, "ll_cid_cfg");

/* Контекст поддержания линка (0x857064, 0x200 Б; include/link_loss.h — детекторы). Счётчики
 * и маски по cid пишет и uc. */
struct ll_ctx {
    struct ll_cid_cfg cfg[8];                  /* 0x000 */
    u32 traffic[8];                            /* 0x120: счётчик активности очереди cid (uc: ++ по ответу/ACK) */
    u32 act_140[8];                            /* 0x140: счётчик активности (старение TX; uc: += NAV пира) */
    u32 pending_mask;                          /* 0x160: маска cid с отложенными данными (uc: itx_ka_pending) */
    u32 idle[8];                               /* 0x164: накопленный простой TX (старение) */
    u32 ka_acc[8];                             /* 0x184: накопленное время без трафика (keep-alive) */
    u32 ka_period[8];                          /* 0x1a4: текущий период keep-alive */
    u32 ka_cnt[8];                             /* 0x1c4: срабатываний keep-alive */
    u32 fsched_flush_mask;                     /* 0x1e4: uc — станции, у которых слот fixed-sched кончился
                                                *       flush (fsched_ctx.flush_cnt); fw — «есть ожидающее» и
                                                *       запрос keep-alive по cid */
    u32 fsched_flush_over;                     /* 0x1e8: uc — flush_cnt ≥ fsched_ctx.max_cnt; fw — запрос
                                                *       keep-alive при fixed_sched.enabled */
    u16 bcn_cnt[8];                            /* 0x1ec: BI без бикона подряд */
    u8  drop_req;                              /* 0x1fc: запрос разрыва по cid (детектор старения) */
    u8  rsv_1fd[3];
};
FWSH_OFF(struct ll_ctx, traffic, 0x120);
FWSH_OFF(struct ll_ctx, act_140, 0x140);
FWSH_OFF(struct ll_ctx, pending_mask, 0x160);
FWSH_OFF(struct ll_ctx, idle, 0x164);
FWSH_OFF(struct ll_ctx, ka_acc, 0x184);
FWSH_OFF(struct ll_ctx, ka_period, 0x1a4);
FWSH_OFF(struct ll_ctx, ka_cnt, 0x1c4);
FWSH_OFF(struct ll_ctx, fsched_flush_mask, 0x1e4);
FWSH_OFF(struct ll_ctx, bcn_cnt, 0x1ec);
FWSH_OFF(struct ll_ctx, drop_req, 0x1fc);
_Static_assert(sizeof(struct ll_ctx) == 0x200, "ll_ctx");

/* Слот ESE (12 Б; ese__alloc_to_slot 0x8c7d4c, schedule__build_allocation_entry 0x8c2cf8).
 * Слово 0: биты 0..3 — номер распределения, 4..5 — тип, 6 — 0, 7 — источник — мы (или
 * 0xff); байты 1..3 пишутся отдельно — union. */
struct ese_slot {
    union {
        u32 ctrl;                              /* 0x00 */
        u16 ctrl_lo;                           /* 0x00: lmac_if__evt_walk читает ldw */
        struct {
            u8 ctrl_b0;                        /* 0x00 */
            u8 peer_cid;                       /* 0x01: маска cid пира (ese__peer_cid_by_aid) */
            u8 src_aid;                        /* 0x02 */
            u8 dst_aid;                        /* 0x03 */
        };
    };
    u32 start;                                 /* 0x04: начало от начала BI (мкс) */
    u16 dur;                                   /* 0x08: длительность (мкс) */
    u16 rsv_0a;
};
FWSH_OFF(struct ese_slot, peer_cid, 1);
FWSH_OFF(struct ese_slot, dst_aid, 3);
FWSH_OFF(struct ese_slot, dur, 8);
_Static_assert(sizeof(struct ese_slot) == 0xc, "ese_slot");
#define ESE_SLOTS_N 3

/* Таблица слотов ESE (0x857264, 0x28 Б): пишет fw (include/sched_scheme.h), байты 2..3
 * ведёт uc (dti_worker_scheduled_dti_allocation_event). */
struct ese_slot_tbl {
    u8  mode;                                  /* 0x00: 1 — без IE, 2 — с Allocation IE / из бикона */
    u8  count;                                 /* 0x01: число слотов (≤ 3) */
    u8  uc_alloc_end;                          /* 0x02: uc — 1 после начала выделения (следующее событие —
                                                *       его конец); fw обнуляет в конструкторе */
    u8  uc_cur_slot;                           /* 0x03: uc — текущий слот (по модулю count) */
    struct ese_slot slot[ESE_SLOTS_N];         /* 0x04 */
};
FWSH_OFF(struct ese_slot_tbl, slot, 4);
_Static_assert(sizeof(struct ese_slot_tbl) == 0x28, "ese_slot_tbl");

/* Отсчёты статистики энергии (0x857290, 0xb4 Б): пишет uc (bf_req_report_20_cb, событие LMAC
 * 0x20), читает fw (energy_statistics_complete, fw/phy_ext.c). Последнее слово gain[19]
 * (0x857340). Область 0x857344..0x8576a0 (счётчик и записи FTM) — только SparRAW-pro. */
#define FWSH_ENERGY_N 20
struct fwsh_energy {
    u32 tsf_start[2];                          /* 0x00: TSF64 запуска измерения */
    u32 tsf_last[2];                           /* 0x08: TSF последнего отсчёта (снимок r40, селекторы 5/6) */
    u32 n;                                     /* 0x10: число отсчётов (< 0x15) */
    u32 adc[FWSH_ENERGY_N];                    /* 0x14 (0x8572a4): ADC */
    u32 gain[FWSH_ENERGY_N];                   /* 0x64 (0x8572f4): усиление */
};
FWSH_OFF(struct fwsh_energy, n, 0x10);
FWSH_OFF(struct fwsh_energy, adc, 0x14);
FWSH_OFF(struct fwsh_energy, gain, 0x64);
_Static_assert(sizeof(struct fwsh_energy) == 0xb4, "fwsh_energy");

/* Статистика PHY RX (0x84 Б): итог команды 9 (fw_sysapi__send_measure_evt); копит uc
 * (phy_stats_accumulate_to_shared), обнуляет LMAC 0x37. */
struct phy_rx_stats {
    u32 cnt[14];                               /* 0x00: счётчики PHY RX (hwd_phy_uses_rgf_883800_929b94) */
    u32 acc[8][2];                             /* 0x38: суммы u64 {мл., ст.} (…_929af4) */
    u32 max_mcs;                               /* 0x78: наибольший MCS (индекс mcs_phy_rate_mbps 0x8012f0) */
    u32 rx_sector;                             /* 0x7c: bf_res.rx_sector */
    u32 rx_gain;                               /* 0x80: rf_rx_gain_hi[текущий RF] */
};
FWSH_OFF(struct phy_rx_stats, acc, 0x38);
_Static_assert(sizeof(struct phy_rx_stats) == 0x84, "phy_rx_stats");

/* Блок PHY/TOF (0x8576a0; vendor fw адресует от 0x857680). */
struct fwsh_phy_blk {
    u32  x0;                                   /* 0x00 */
    u32  x4;                                   /* 0x04 */
    volatile u32 tof_req;                      /* 0x08 (0x8576a8): запрос TOF/ABIF — только SparRAW-pro (здесь не используется);
                                                *       uc: 1 — сохранить и переопределить, 2 — восстановить,
                                                *       затем 0 (rx_funcs_rx_flow, l1) */
    struct phy_rx_stats st;                    /* 0x0c (0x8576ac) */
};
FWSH_OFF(struct fwsh_phy_blk, tof_req, 0x08);
FWSH_OFF(struct fwsh_phy_blk, st, 0x0c);
_Static_assert(sizeof(struct fwsh_phy_blk) == 0x90, "fwsh_phy_blk");

/* Параметры фиксированного расписания по MCS (12 Б). uc (по чтениям): byte0 — длительность
 * слота (×165 → поле qset), byte1 — начальный счётчик RD пира, +2/+4 — границы слота (+4
 * сравнивается с мкс до TBTT), +8 — 3-й аргумент macq_kick_queue_tx. */
struct fixed_sched_mcs {
    u8  time_before_tx_us;                     /* 0x00: time_in_usec_before_initiate_tx */
    u8  rd_count;                              /* 0x01: rd_enabled / rd_count_per_slot (UL) */
    u16 stop_vring_us;                         /* 0x02: time_in_usec_to_stop_vring */
    u16 flush_to_us;                           /* 0x04: flush_to_in_usec */
    u16 rsv_06;
    u32 mac_buff_size;                         /* 0x08: mac_buff_size_in_bytes */
};
_Static_assert(sizeof(struct fixed_sched_mcs) == 0xc, "fixed_sched_mcs");
#define FIXED_SCHED_MCS_N 13

/* Фиксированное расписание (0x847a3c, 0xa8 Б; дальше — calib_lo_power_obj 0x847ae4). Объект
 * fw (WMI_FIXED_SCHEDULING_CONFIG), uc читает по указателю fwsh_sets.fsched_tbl. */
struct fixed_sched {
    struct fixed_sched_mcs mcs[FIXED_SCHED_MCS_N]; /* 0x00 */
    u16 max_sta_rd_ppdu_us;                    /* 0x9c */
    u16 max_sta_grant_ppdu_us;                 /* 0x9e */
    u16 assoc_slot_us;                         /* 0xa0: uc — длительность слота (×165) */
    u16 virtual_slot_us;                       /* 0xa2: 0 — таблица не настроена; uc — длительность Grant/слота */
    u8  ap_slots_initiate_grant;               /* 0xa4: uc — предел slot_cnt станции (fsched_ap_station_done) */
    u8  enabled;                               /* 0xa5: 1 — фиксированное расписание включено */
    u8  rsv_a6[2];
};
FWSH_OFF(struct fixed_sched, max_sta_rd_ppdu_us, 0x9c);
FWSH_OFF(struct fixed_sched, assoc_slot_us, 0xa0);
FWSH_OFF(struct fixed_sched, virtual_slot_us, 0xa2);
FWSH_OFF(struct fixed_sched, ap_slots_initiate_grant, 0xa4);
FWSH_OFF(struct fixed_sched, enabled, 0xa5);
_Static_assert(sizeof(struct fixed_sched) == 0xa8, "fixed_sched");

/* Наборы RF (RF-сеты) и параметры развёртки секторов (0x857730, 0x88 Б; include/rf_sets.h).
 * Заполняет разбор board-файла (handle_rf_sets_info / build_tx_sector_list, fw/brd_if.c) и
 * RF-объект (fw/rf.c); uc читает. */
#define RF_SETS_MAX 8

/* Диапазон секторов конфигурации набора {первый, последний}. */
struct rf_sec_range {
    u8 first;
    u8 last;
};

struct fwsh_sets {
    u32 rx_gain_ofs_lo_mcs;                    /* 0x00 (0x857730): fw_main −3; второй аргумент rf_gain_cb ucode при MCS < 9 */
    /* 0x04 (0x857734): [0][s] — число TX-секторов набора s, [1][s] — число конфигураций
     * (диапазонов rf_set_ranges[s]) набора; n_sec[1][0] — «число наборов» ucode (fwsh_n_sets),
     * его же пишет rf.c (sector_cfg_cnt). */
    u8  n_sec[2][RF_SETS_MAX];
    struct fixed_sched *volatile fsched_tbl;   /* 0x14 (0x857744): таблица fixed-sched (fixed_sched__start) */
    u32 fsched_airtime[8];                     /* 0x18 (0x857748): uc — время слотов fixed-sched по станции, TSF-мкс */
    u32 n_sets;                                /* 0x38 (0x857768): число наборов RF (2/3 — также поправка silent RSSI) */
    u32 brp_cfg_mask[RF_SETS_MAX];             /* 0x3c (0x85776c): по RF — разрешённые конфигурации BRP */
    union {                                    /* 0x5c (0x85778c): маска RF-модулей набора */
        u8  set_rf_mask[RF_SETS_MAX];
        u32 set_rf_mask_w[2];                  /* build_tx_sector_list проверяет словами */
    };
    u8  start[2][RF_SETS_MAX];                 /* 0x64 (0x857794): начальный сектор [тип][набор] */
    u8  set_tx_mask[RF_SETS_MAX];              /* 0x74 (0x8577a4): маска набора ∩ tx_mask */
    u8  multi_cfg;                             /* 0x7c (0x8577ac): биты наборов с ≥ 2 конфигурациями */
    u8  rsv7d[3];                              /* 0x7d */
    struct rf_sec_range (*set_ranges)[32];     /* 0x80 (0x8577b0): = rf_set_ranges (ctors.c) */
    u8  abft_sectors;                          /* 0x84 (0x8577b4): WMI_PCP_START pcp_max_assoc_sta (ABFT_SECTORS);
                                                *       uc: ≥ 2 у AP — omni-сектор не трогать, RF-маска не сводится к 1 */
    u8  bi_hi;                                 /* 0x85 (0x8577b5): старший байт значения WMI_ECHO (wmi_cmd.c);
                                                *       uc: 0 (и < 2 RF) — писать биты TRN в регистры RF */
    u8  rsv86[2];                              /* 0x86 */
};
FWSH_OFF(struct fwsh_sets, n_sec, 0x04);
FWSH_OFF(struct fwsh_sets, fsched_tbl, 0x14);
FWSH_OFF(struct fwsh_sets, fsched_airtime, 0x18);
FWSH_OFF(struct fwsh_sets, n_sets, 0x38);
FWSH_OFF(struct fwsh_sets, brp_cfg_mask, 0x3c);
FWSH_OFF(struct fwsh_sets, set_rf_mask, 0x5c);
FWSH_OFF(struct fwsh_sets, start, 0x64);
FWSH_OFF(struct fwsh_sets, set_tx_mask, 0x74);
FWSH_OFF(struct fwsh_sets, set_ranges, 0x80);
FWSH_OFF(struct fwsh_sets, abft_sectors, 0x84);
_Static_assert(sizeof(struct fwsh_sets) == 0x88, "fwsh_sets");



/* ---------------- объекты ---------------- */

/* Адреса объектов литералами (FWSH_A_<имя>): у uc — основа имён-макросов, у fw — для мест, где
 * символ меняет порядок доступов (stubs.c); tools/check_fwsh.py сверяет их с fw/fw.ld. */
#define FWSH_A_fw_stats_dash      0x853910u
#define FWSH_A_mac_mon_pub        0x853940u
#define FWSH_A_fwsh_diag          0x857000u
#define FWSH_A_fwq_tx_avail       0x857040u
#define FWSH_A_ll_ctx             0x857064u
#define FWSH_A_ese_slot_tbl       0x857264u
#define FWSH_A_fwsh_n_rx_ant      0x85728cu
#define FWSH_A_fwsh_total_sectors 0x85728du
#define FWSH_A_fwsh_long_range    0x85728eu
#define FWSH_A_fwsh_energy        0x857290u
#define FWSH_A_fwsh_phy           0x8576a0u
#define FWSH_A_fwsh_sets          0x857730u

/* Поле общего объекта по его собственному литеральному адресу (целая константа «адрес
 * объекта + offsetof») — кодоген как с числом. Форма obj.field даёт у gcc адрес «база
 * объекта + смещение»: база держится в регистре, смещение уходит в ld/st (codecmp: ld.as
 * [r2,88] от 0x857064 вместо ld [r2,0] от 0x8571c4), а &obj.arr[i] — масштабируемую
 * адресацию ld.aw [ri,база]. Тип и volatile — от поля: FWSH(ll_ctx, pending_mask) |= m. У fw — где символ меняет порядок
 * или число доступов (gcc знает, что объект не пересекается с соседними). */
#define FWSH_ADDR(obj, fld)   (FWSH_A_##obj + __builtin_offsetof(__typeof__(obj), fld))
#define FWSH(obj, fld)        (*(__typeof__(obj.fld) *)(FWSH_A_##obj + __builtin_offsetof(__typeof__(obj), fld)))
/* Элемент массива с переменным индексом: целый адрес «поле + i·размер». */
#define FWSH_AT(obj, arr, i)  (*(__typeof__(obj.arr[0]) *)(FWSH_A_##obj + __builtin_offsetof(__typeof__(obj), arr) \
                                                          + (i) * sizeof(obj.arr[0])))
/* (FWSH/FWSH_AT не через FWSH_ADDR: аргумент obj внутри вложенного макроса раскрылся бы до
 * склейки FWSH_A_##obj.) */

#ifndef FWSH_UC
/* fw: символы fw/fw.ld. */
extern struct fw_stats_dash fw_stats_dash;     /* 0x853910 */
extern struct mac_mon_report_s mac_mon_pub;    /* 0x853940 */
extern struct fwsh_diag fwsh_diag;             /* 0x857000 */
extern struct fwq_tx_avail fwq_tx_avail;       /* 0x857040 */
extern struct ll_ctx ll_ctx;                   /* 0x857064 */
extern struct ese_slot_tbl ese_slot_tbl;       /* 0x857264 */
extern volatile u8 fwsh_n_rx_ant;              /* 0x85728c: число RX DMG-антенн своей STA Capability + 1 */
extern volatile u8 fwsh_total_sectors;         /* 0x85728d: Total Number of Sectors своей STA Capability + 1 */
extern volatile u8 fwsh_long_range;            /* 0x85728e: 1 — режим дальней связи (WMI_SET_LONG_RANGE) */
extern struct fwsh_energy fwsh_energy;         /* 0x857290 */
extern struct fwsh_phy_blk fwsh_phy;           /* 0x8576a0 */
extern struct fwsh_sets fwsh_sets;             /* 0x857730 */
#else
/* uc: имена — макросы на литеральный адрес. */
#define fw_stats_dash      (*(volatile struct fw_stats_dash *)FWSH_A_fw_stats_dash)
#define mac_mon_pub        (*(volatile struct mac_mon_report_s *)FWSH_A_mac_mon_pub)
#define fwsh_diag          (*(volatile struct fwsh_diag *)FWSH_A_fwsh_diag)
#define fwq_tx_avail       (*(volatile struct fwq_tx_avail *)FWSH_A_fwq_tx_avail)
#define ll_ctx             (*(volatile struct ll_ctx *)FWSH_A_ll_ctx)
#define ese_slot_tbl       (*(volatile struct ese_slot_tbl *)FWSH_A_ese_slot_tbl)
#define fwsh_n_rx_ant      (*(volatile u8 *)FWSH_A_fwsh_n_rx_ant)   /* множитель окна RSS (LMAC 0x18 тип 8, txss) */
#define fwsh_total_sectors (*(volatile u8 *)FWSH_A_fwsh_total_sectors)
#define fwsh_long_range    (*(volatile u8 *)FWSH_A_fwsh_long_range) /* ≠ 0 — окна ответа/занятости 10 слотов вместо 2 (LMAC 0x00/0x41), задержка gp0 0x30 */
#define fwsh_energy        (*(volatile struct fwsh_energy *)FWSH_A_fwsh_energy)
#define fwsh_phy           (*(volatile struct fwsh_phy_blk *)FWSH_A_fwsh_phy)
#define fwsh_sets          (*(volatile struct fwsh_sets *)FWSH_A_fwsh_sets)


/* Псевдонимы uc. «Число наборов» развёртки = n_sec[1][0] (≥ 2 — по набору своя база сектора). */
#define fwsh_n_sets        FWSH(fwsh_sets, n_sec[1][0])
/* fwsh_sets.set_ranges как целое (адрес таблицы u8[2] {первый, последний} по набору). */
#define fwsh_set_ranges    (*(volatile u32 *)FWSH_ADDR(fwsh_sets, set_ranges))
#endif

#endif
