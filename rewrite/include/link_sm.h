/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Записи линк-менеджера соединения (vendor 6.2, рабочая память 0x841c28, 8 × 0xa4 по cid,
 * до списка «ждущих» кадров управления 0x842148): автомат lm_sm (описатель 0x802da0) с
 * вложенным maintain_sm (0x802cc4, BF/RS-сопровождение) и в нём автоматом статистики
 * линка sm_802f58 (link_stats). Конструкторы — fw/discovery.c (obj_vt802da0__ctor 0x8d8b30,
 * obj_vt802cc4__ctor 0x8f52bc, obj_vt802f58__ctor 0x8d8dc0), действия — fw/link_sm.c.
 * Запись выбирает lm_if__set_cid (0x8e63a4): lm_if.lm_sm = &lm_sm_recs[cid]. Таблиц
 * методов у объектов нет (только описатели автоматов в fw_data). Смещения закреплены
 * _Static_assert. */
#ifndef LINK_SM_H
#define LINK_SM_H
#include "types.h"
#include "basic_sm.h"

#define LSM_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

struct lm_if;
struct lm_sm;
struct maintain_sm;
struct rm_req;

/* Автомат статистики линка sm_802f58 (maintain_sm + 0x2c, 0x40 Б): TX/RX goodput, PER,
 * LED; таймеры задержки (период [0x8003c0]) и отчёта (100 мс). */
struct link_stats_sm {
    struct basic_sm hdr;                       /* 0x00 */
    u32 latency_timer;                         /* 0x08: таймер отметок задержки */
    u32 report_timer;                          /* 0x0c: таймер отчёта */
    struct maintain_sm *msm;                   /* 0x10: владелец */
    u32 tx_base[2];                            /* 0x14: счётчик TX байт (u64) на прошлом отчёте */
    u32 tx_goodput;                            /* 0x1c: TX goodput (WMI: [lm_sm+0x58]) */
    u32 rx_base[2];                            /* 0x20: счётчик RX байт (u64) на прошлом отчёте */
    u32 rx_goodput;                            /* 0x28: RX goodput (WMI: [lm_sm+0x64]) */
    u32 tx_ok;                                 /* 0x2c: счётчик TX ok на прошлом отчёте */
    u32 tx_fail;                               /* 0x30: счётчик TX fail */
    u32 snap_853924;                           /* 0x34: снимок fw_stats_dash.rx_ppdu (0x853924) */
    u32 last_time;                             /* 0x38: время прошлого отчёта (u_schd) */
    u8  report_cnt;                            /* 0x3c: отчётов (журнал раз в 100) */
    u8  high_per_cnt;                          /* 0x3d: отчётов подряд с PER > 90 % */
    u8  rsv_3e[2];
};
LSM_OFF(struct link_stats_sm, msm, 0x10);
LSM_OFF(struct link_stats_sm, tx_goodput, 0x1c);
LSM_OFF(struct link_stats_sm, rx_goodput, 0x28);
LSM_OFF(struct link_stats_sm, last_time, 0x38);
LSM_OFF(struct link_stats_sm, high_per_cnt, 0x3d);
_Static_assert(sizeof(struct link_stats_sm) == 0x40, "link_stats_sm");

/* maintain_sm (описатель 0x802cc4, lm_sm + 0x10, 0x84 Б): первый BF (FBF), затем окно
 * BF-ответов, долгосрочный BF по таймеру и RS. События: 0 START_MAINTAIN, 3 STOP,
 * 4 TIMER, 5 SELF_FBF_FAIL, 6 SELF_FIRST_FBF_SUCCESS, 8 PAUSE, 9 RESUME_MAINTAIN. */
struct maintain_sm {
    struct basic_sm hdr;                       /* 0x00 (hdr.trace = 1 на время FBF) */
    struct lm_sm *lm_sm;                       /* 0x08: владелец */
    u32 rs_mode;                               /* 0x0c: режим RS (LMAC 0x15; 1 — без BF-радио; 2 после ctor) */
    u32 rs_val;                                /* 0x10: параметр RS */
    u32 txss_timeout;                          /* 0x14: таймаут TXSS (ctor — maint_initial_txss_timeout) */
    u8  fbf_tries;                             /* 0x18: попытки первого BF */
    u8  mcs;                                   /* 0x19: MCS последнего RS (1 — неудача) */
    u8  rsv_1a[2];
    u32 lt_timer;                              /* 0x1c: таймер долгосрочного BF */
    u32 win_timer;                             /* 0x20: таймер окна BF-ответов */
    struct rm_req *radio_req;                  /* 0x24: запрос радио под BF */
    u32 radio_locked;                          /* 0x28: радио выдано */
    struct link_stats_sm stats;                /* 0x2c */
    u32 win_max_mcs;                           /* 0x6c: максимум MCS RS в окне (1 — окно с начала) */
    u32 win_ok;                                /* 0x70: успешных BF в окне */
    u32 win_bad;                               /* 0x74: неудачных BF/RS в окне */
    u32 lt_fails;                              /* 0x78: неудач подряд (множитель периода долгосрочного BF) */
    u32 mid_ap;                                /* 0x7c: mid в состоянии 2/3 при старте */
    u32 lt_paused;                             /* 0x80: таймер долгосрочного BF снят паузой */
};
LSM_OFF(struct maintain_sm, lm_sm, 0x08);
LSM_OFF(struct maintain_sm, fbf_tries, 0x18);
LSM_OFF(struct maintain_sm, mcs, 0x19);
LSM_OFF(struct maintain_sm, radio_req, 0x24);
LSM_OFF(struct maintain_sm, stats, 0x2c);
LSM_OFF(struct maintain_sm, win_max_mcs, 0x6c);
LSM_OFF(struct maintain_sm, lt_paused, 0x80);
_Static_assert(sizeof(struct maintain_sm) == 0x84, "maintain_sm");

/* lm_sm (описатель 0x802da0, 0xa4 Б): ведение линка. Состояния: 0 LM_STATE_IDLE,
 * LM_STATE_WAIT_LINK, LM_STATE_CONFIGURED, сопровождение; события: 0 LINKUP_REQ,
 * 1/2 SELF_LINKUP_FAIL/DONE (отложенные), 3 STOP_LINK, 4 бикон, 5 START_MAINTAIN_REQ,
 * 6 SELF_LINKUP_FAIL от maintain_sm, 7 MAINTAIN_STARTED, 8 остановлено, 9 PAUSE,
 * 0xb RESUME_MAINTAIN_REQ. */
struct lm_sm {
    struct basic_sm hdr;                       /* 0x00 */
    struct lm_if *lm;                          /* 0x08: lm_if соединения */
    u32 stop_pending;                          /* 0x0c: STOP_LINK во время ожидания линка */
    struct maintain_sm msm;                    /* 0x10 */
    u8  linkup_fails;                          /* 0x94: неудачных BF линк-апа подряд */
    u8  rsv_95[3];
    u32 link_stat;                             /* 0x98: LM_EVT_LINK_STAT_UPDATE (1 при старте сопровождения) */
    u32 lm_mode;                               /* 0x9c: режим (maintain_ctx__set_field_9c: 2 — инициатор, 1, 0) */
    s8  rsv_a0;                                /* 0xa0: -2 (ctor; vendor не читает) */
    s8  rsv_a1;                                /* 0xa1: -5 (ctor) */
    u8  rsv_a2[2];
};
LSM_OFF(struct lm_sm, lm, 0x08);
LSM_OFF(struct lm_sm, msm, 0x10);
LSM_OFF(struct lm_sm, msm.stats, 0x3c);
LSM_OFF(struct lm_sm, msm.stats.tx_goodput, 0x58);
LSM_OFF(struct lm_sm, msm.stats.rx_goodput, 0x64);
LSM_OFF(struct lm_sm, linkup_fails, 0x94);
LSM_OFF(struct lm_sm, lm_mode, 0x9c);
LSM_OFF(struct lm_sm, rsv_a0, 0xa0);
_Static_assert(sizeof(struct lm_sm) == 0xa4, "lm_sm");

/* Экземпляр — символ fw/fw.ld (рабочая память, не DCCM). */
extern struct lm_sm lm_sm_recs[8];             /* 0x841c28 */

/* fw_data (fw/link_sm.c): период долгосрочного BF по MCS 0..12 (мкс; WMI_BF_CONTROL и
 * fixed_sched_start переписывают). */
#define MAINTAIN_LT_PERIOD_N 13
extern volatile u32 maintain_lt_period[MAINTAIN_LT_PERIOD_N];   /* 0x801448 */

/* События автоматам (basic_sm_handle_event и sm_defer_call из fw/proto.h принимают объект
 * указателем). */
static inline void lm_sm_event(struct lm_sm *l, u32 ev, u32 a0, u32 a1, u32 a2)
{
    basic_sm_handle_event(l, ev, a0, a1, a2);
}

static inline void lm_sm_defer(struct lm_sm *l, u32 ev, u32 a0, u32 a1, u32 a2)
{
    sm_defer_call(l, ev, a0, a1, a2);
}

static inline void maintain_sm_event(struct maintain_sm *m, u32 ev, u32 a0, u32 a1, u32 a2)
{
    basic_sm_handle_event(m, ev, a0, a1, a2);
}

static inline void maintain_sm_defer(struct maintain_sm *m, u32 ev, u32 a0, u32 a1, u32 a2)
{
    sm_defer_call(m, ev, a0, a1, a2);
}

static inline void link_stats_event(struct link_stats_sm *s, u32 ev, u32 a0, u32 a1, u32 a2)
{
    basic_sm_handle_event(s, ev, a0, a1, a2);
}

/* Описатели автоматов в DCCM (FWDATA, fw/link_sm.c; ид [0x10] пишет статический конструктор). */
extern struct sm_desc lm_sm_desc;                    /* 0x802da0 */
extern struct sm_desc maintain_sm_desc;              /* 0x802cc4 */
extern struct sm_desc link_stats_sm_desc;            /* 0x802f58 */

/* Конфигурация CMD_SELECTIVE_NEIGHBOR_CFG (0x80026c, fw/link_sm.c): байты 0/1 — пороги
 * («threshold» selective_detection / selective_nav), байт 2 — биты разрешений (в слове
 * 16..18). Образ: пороги 0x10/0x14, разрешён только short_txop. */
union sel_nbr_cfg {
    u32 w;
    struct {
        u8 det_threshold;                      /* 0x00 */
        u8 nav_threshold;                      /* 0x01 */
        u8 en;                                 /* 0x02: биты SEL_NBR_*_EN >> 16 */
        u8 rsv3;
    } b;
};
_Static_assert(sizeof(union sel_nbr_cfg) == 4, "sel_nbr_cfg");
#define SEL_NBR_DET_EN        (1u << 16)       /* selective_detection_en */
#define SEL_NBR_NAV_EN        (1u << 17)       /* selective_nav_en */
#define SEL_NBR_SHORT_TXOP_EN (1u << 18)       /* short_txop_en */
extern const volatile union sel_nbr_cfg sel_nbr_cfg;

/* Имена состояний автоматов разрыва и статистики линка (токены строк журнала; описатели
 * 0x8027a0 / 0x802f58 — sm_desc.state_names), fw/link_sm.c. */
extern const u32 disconn_sm_state_names[2];              /* 0x8004d4 */
extern const u32 link_stats_sm_state_names[2];           /* 0x8004dc */

#endif
