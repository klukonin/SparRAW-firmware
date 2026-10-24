/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Детекторы потери линка (vendor 6.2): на каждый cid — запись ll_detectors (рабочая
 * память 0x854dd4, 8 × 0xa4, сразу за conn_mgr) из трёх детекторов: старение TX PPDU
 * (tx_ppdu_ageing_timeout_detector, +0), необходимость keep-alive (ka_necessity_detector,
 * +0x54) и плохие биконы (bad_beacons_detector, +0x98). Первые два — периодические службы
 * (struct psvc, база детекторов; та же база у монитора PHY 0x84e7e0) с таблицами методов
 * 0x8008c4 / 0x80075c. Параметры и счётчики по cid — общий контекст поддержания линка
 * ll_ctx (0x857064, 0x200 Б). Конструктор массива — fw/ctors.c (0x8ed15c), привязка к cid —
 * fw/l2mgr.c (link_loss_detectors__init 0x8d94f0), lm_if.detectors = &ll_detectors[cid]
 * (lm_if__set_cid 0x8e63a4); методы — fw/link_loss.c, fw/discovery.c, fw/l2mgr.c.
 * Смещения закреплены _Static_assert. */
#ifndef LINK_LOSS_H
#define LINK_LOSS_H
#include "types.h"
#include "fwsh.h"

#define LL_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

struct psvc;

/* Таблица методов периодической службы (vendor 0x8008c4 / 0x80075c; у монитора PHY
 * 0x8007a0 — ещё слот 0x14 on_system_state). */
struct psvc_vt {
    u32 rsv0;
    void (*start)(struct psvc *o, u32 mode);   /* 0x04: periodic_service__start 0x8e77c4 */
    void (*stop)(struct psvc *o);              /* 0x08: detector__arm_timer 0x8e7e8c (останов) */
    void (*task)(struct psvc *o, u32 count);   /* 0x0c: задача прогона */
    void (*run)(struct psvc *o);               /* 0x10: periodic_service__run 0x8cdc18 */
};
_Static_assert(sizeof(struct psvc_vt) == 0x14, "psvc_vt");

/* Периодическая служба (0x30 Б; detector__init_common 0x8d8fa0). */
struct psvc {
    u32 period;                                /* 0x00: период (тики u_schd << 4) */
    u32 timer_arg;                             /* 0x04: a2 задачи таймера u_schd */
    u32 catch_up;                              /* 0x08: «догонять» — остаток от начала прогона */
    u32 type;                                  /* 0x0c: тип/приоритет */
    u32 timer;                                 /* 0x10: задача-таймер u_schd (0 — нет) */
    u32 run_start;                             /* 0x14: время начала прогона (-1 — не было) */
    u32 run_end;                               /* 0x18: время конца прогона (-1 — не было) */
    u32 end_tsf[2];                            /* 0x1c: TSF конца прогона (0xffffffff — не задан) */
    u8  runs;                                  /* 0x24: счётчик прогонов (0..254) */
    u8  rsv_25[3];
    u32 stopped;                               /* 0x28: 1 — остановлена */
    const struct psvc_vt *vt;                  /* 0x2c */
};
LL_OFF(struct psvc, timer, 0x10);
LL_OFF(struct psvc, end_tsf, 0x1c);
LL_OFF(struct psvc, runs, 0x24);
LL_OFF(struct psvc, vt, 0x2c);
_Static_assert(sizeof(struct psvc) == 0x30, "psvc");

/* struct ll_cid_cfg, struct ll_ctx (0x857064, общий с uc) — include/fwsh.h. */

/* Детектор старения TX PPDU (0x54 Б, таблица методов 0x8008c4). */
struct ll_ageing_det {
    struct psvc svc;                           /* 0x00 */
    u8  cid;                                   /* 0x30: 0xff — не привязан */
    u8  rsv_31[3];
    struct ll_ctx *ctx;                        /* 0x34 */
    u32 last_traffic;                          /* 0x38: ctx->traffic[cid] на прошлом прогоне */
    u32 last_pring_time;                       /* 0x3c: время pring (vring_schd time_of_pring) */
    u32 last_act;                              /* 0x40: ctx->act_140[cid] */
    u32 last_scan_step;                        /* 0x44: шаг скана соединения */
    u32 last_hook;                             /* 0x48: tx_ppdu_ageing__hook_ret0 (0) */
    u32 log_tsf[2];                            /* 0x4c: TSF последнего журнала состояния */
};
LL_OFF(struct ll_ageing_det, cid, 0x30);
LL_OFF(struct ll_ageing_det, ctx, 0x34);
LL_OFF(struct ll_ageing_det, log_tsf, 0x4c);
_Static_assert(sizeof(struct ll_ageing_det) == 0x54, "ll_ageing_det");

/* Детектор необходимости keep-alive (0x44 Б, таблица методов 0x80075c). */
struct ll_ka_det {
    struct psvc svc;                           /* 0x00 */
    u8  cid;                                   /* 0x30: 0xff — не привязан */
    u8  rsv_31[3];
    struct ll_ctx *ctx;                        /* 0x34 */
    u32 last_traffic;                          /* 0x38 */
    u32 log_tsf[2];                            /* 0x3c: TSF последнего журнала состояния */
};
LL_OFF(struct ll_ka_det, cid, 0x30);
LL_OFF(struct ll_ka_det, log_tsf, 0x3c);
_Static_assert(sizeof(struct ll_ka_det) == 0x44, "ll_ka_det");

/* Детектор плохих биконов (0xc Б). */
struct ll_bcn_det {
    u8  cid;                                   /* 0x00: 0xff — не привязан */
    u8  rsv_01[3];
    struct ll_ctx *ctx;                        /* 0x04 */
    u32 armed;                                 /* 0x08: мониторинг включён */
};
_Static_assert(sizeof(struct ll_bcn_det) == 0xc, "ll_bcn_det");

/* Детекторы cid (0xa4 Б). */
struct ll_detectors {
    struct ll_ageing_det ageing;               /* 0x00 */
    struct ll_ka_det ka;                       /* 0x54 */
    struct ll_bcn_det bcn;                     /* 0x98 */
};
LL_OFF(struct ll_detectors, ka, 0x54);
LL_OFF(struct ll_detectors, bcn, 0x98);
_Static_assert(sizeof(struct ll_detectors) == 0xa4, "ll_detectors");

/* Экземпляры — символы fw/fw.ld (рабочая память, не DCCM). */
extern struct ll_detectors ll_detectors[SPARRAW_MAX_STA];   /* 0x854dd4 */
/* Наборы параметров поддержания линка 0..3 (fw_data 0x801518, fw/l2mgr.c): 0/1 — есть
 * соединение (флаг 0/1), 2/3 — нет. */
extern const struct ll_cid_cfg ll_cfg_presets[4];
/* Таблицы методов — DCCM (fw/link_loss.c). */
extern const struct psvc_vt ll_ka_det_vtbl;    /* 0x80075c */
extern const struct psvc_vt ll_ageing_det_vtbl;/* 0x8008c4 */

#endif
