/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* vring_schd — планировщик TX-vring хоста (fw/vring.c): объект 0x804dbc с массивом
 * аппаратных TX-очередей pring, вариант 0x804e64 (режим пар [0x80006c] == 1), записи vring
 * (пул 0x804da8, элементы 0x804c40) и таблица vring_tbl (0x806014). Раскладка — как у
 * vendor 6.2 (всё в DCCM); смещения закреплены _Static_assert. */
#ifndef VRING_SCHD_H
#define VRING_SCHD_H
#include "types.h"
#include "llist.h"

struct stream_ctx;
struct wmi_sw_ring_cfg;
struct wmi_vring_cfg_schd;

#define VRS_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

/* Запись vring (0x28 Б): элемент пула 0x804da8, узел списков планировщика. */
struct vring_rec {
    u32 next;                                  /* 0x00: узел llist */
    u32 owner;                                 /* 0x04: список-владелец */
    u8  pring_type;                            /* 0x08: номер pring, к которому годится vring */
    u8  vr;                                    /* 0x09: номер vring (DMA) */
    u8  pring;                                 /* 0x0a: pring-id (cid; bcast — 8) */
    u8  prio;                                  /* 0x0b: очередь готовых 0/1 */
    u16 slot;                                  /* 0x0c: timeslot, мкс */
    u8  rsv0e[2];                              /* 0x0e */
    u32 bcast;                                 /* 0x10 */
    u32 tsf_lo;                                /* 0x14: TSF начала работы */
    u32 tsf_hi;                                /* 0x18 */
    u32 time;                                  /* 0x1c: накопленное время работы */
    u32 enabled;                               /* 0x20: 1 — разрешён */
    u32 state;                                 /* 0x24: 1 ждёт DMA, 2 в очереди, 3 привязан, 4 останавливается */
};
VRS_OFF(struct vring_rec, slot, 0x0c);
VRS_OFF(struct vring_rec, bcast, 0x10);
VRS_OFF(struct vring_rec, state, 0x24);
_Static_assert(sizeof(struct vring_rec) == 0x28, "vring_rec");

/* pring — аппаратная TX-очередь (0x3c Б). Поля, которые vendor читает разной шириной
 * (пишет словом, читает полусловом/байтом), — анонимные объединения. */
struct pring {
    u16 id;                                    /* 0x00: номер pring (кольцо DMA) */
    union {                                    /* 0x02: MACQ привязанного vring; 0x18 — нет */
        u16 vr;
        u8  vr8;
    };
    union {                                    /* 0x04: начало окна MACQ */
        u32 win_start;
        u16 win_start16;
    };
    union {                                    /* 0x08: размер окна MACQ */
        u32 win_size;
        u16 win_size16;
    };
    u32 polls;                                 /* 0x0c: перевзводы таймера остановки */
    u32 tx_cnt;                                /* 0x10: счётчик TX MAC при привязке */
    struct vring_rec *bound;                   /* 0x14: привязанная запись vring */
    u32 state;                                 /* 0x18: 1 свободен, 2 работает, 3/4 останавливается */
    u32 stop_timer;                            /* 0x1c: таймер остановки (sm_pring_timeout_task) */
    u32 l1_hold;                               /* 0x20: PCIe L1 удерживается */
    u32 dma_timer;                             /* 0x24: таймер ожидания DMA (бит 8 статуса) */
    u32 conn_timer;                            /* 0x28: таймер «окна связи» */
    u32 slot_timer;                            /* 0x2c: таймер slot_optimized */
    u32 bind_time;                             /* 0x30: время привязки (u_schd_now << 4) */
    u32 stop_start;                            /* 0x34: начало остановки */
    u32 stop_end;                              /* 0x38: запрос остановки от DMA (бит 8) */
};
VRS_OFF(struct pring, vr, 0x02);
VRS_OFF(struct pring, win_start, 0x04);
VRS_OFF(struct pring, polls, 0x0c);
VRS_OFF(struct pring, bound, 0x14);
VRS_OFF(struct pring, state, 0x18);
VRS_OFF(struct pring, stop_timer, 0x1c);
VRS_OFF(struct pring, l1_hold, 0x20);
VRS_OFF(struct pring, dma_timer, 0x24);
VRS_OFF(struct pring, conn_timer, 0x28);
VRS_OFF(struct pring, slot_timer, 0x2c);
VRS_OFF(struct pring, stop_end, 0x38);
_Static_assert(sizeof(struct pring) == 0x3c, "pring");

#define VRING_SCHD_NPRING  2                   /* vring_schd_add_sniffer_vring: ассерт при 3 */

struct vring_schd_vt;

/* Общее начало объектов vring_schd и варианта: указатель на таблицу методов.
 * vring_active_ring_table() отдаёт его; методы получают его же. */
struct vring_schd_if {
    const struct vring_schd_vt *vt;            /* 0x00 */
};

/* Таблица методов (vendor 0x8008e8 — основной объект, 0x800918 — вариант). */
struct vring_schd_vt {
    u32 rsv0;                                                              /* 0x00 */
    void (*reset_irq)(struct vring_schd_if *o);                            /* 0x04 */
    void (*reset)(struct vring_schd_if *o);                                /* 0x08 */
    void (*add_vring)(struct vring_schd_if *o, const struct wmi_sw_ring_cfg *cfg,
                      struct stream_ctx *ctx, const struct wmi_vring_cfg_schd *schd,
                      u32 en);                                             /* 0x0c */
    void (*delete_vring)(struct vring_schd_if *o, u32 vr);                 /* 0x10 */
    void (*suspend_vring)(struct vring_schd_if *o, u32 vr);                /* 0x14 */
    void (*resume_vring)(struct vring_schd_if *o, u32 vr);                 /* 0x18 */
    u32 (*prohibit)(struct vring_schd_if *o, u32 mask);                    /* 0x1c */
    void (*allow)(struct vring_schd_if *o, u32 mask);                      /* 0x20 */
    u32 (*vring_of_pring)(struct vring_schd_if *o, u32 pr);                /* 0x24 */
    u32 (*time_of_pring)(struct vring_schd_if *o, u32 pr);                 /* 0x28 */
    void (*clear_time)(struct vring_schd_if *o, u32 pr);                   /* 0x2c */
};
_Static_assert(sizeof(struct vring_schd_vt) == 0x30, "vring_schd_vt");

/* Планировщик vring_schd (0xa8 Б). */
struct vring_schd {
    struct vring_schd_if base;                 /* 0x00 */
    struct llist waiting;                      /* 0x04: зарегистрированные vring без данных */
    struct llist ready[2];                     /* 0x10, 0x1c: готовые по приоритету */
    struct pring pring[VRING_SCHD_NPRING];     /* 0x28 */
    u32 n_pring;                               /* 0xa0 */
    u32 blocked;                               /* 0xa4: запрещённые pring-id (бит = pring) */
};
VRS_OFF(struct vring_schd, waiting, 0x04);
VRS_OFF(struct vring_schd, ready, 0x10);
VRS_OFF(struct vring_schd, pring, 0x28);
VRS_OFF(struct vring_schd, n_pring, 0xa0);
VRS_OFF(struct vring_schd, blocked, 0xa4);
_Static_assert(sizeof(struct vring_schd) == 0xa8, "vring_schd");

/* Вариант для режима пар (0xc Б): только карта pring-id → vring. */
struct vring_schd_alt {
    struct vring_schd_if base;                 /* 0x00 */
    u8 vr_of_pring[8];                         /* 0x04 */
};
_Static_assert(sizeof(struct vring_schd_alt) == 0xc, "vring_schd_alt");

/* Запись vring_tbl (16 Б, по номеру vring/MACQ): окно TX MACQ (tx_macq_config_ring_params,
 * поля — как в struct txq_ring_param, include/macq_desc.h), тип и параметры очереди. */
struct vring_tbl_entry {
    u16 win_start;                             /* 0x00: начало окна (строка 8 Б) */
    u16 param_a;                               /* 0x02 */
    u16 win_lines;                             /* 0x04: payload_length_lines */
    u16 max_mpdu;                              /* 0x06 */
    u16 param_b;                               /* 0x08 */
    u8  macq;                                  /* 0x0a: номер TX MACQ */
    u8  mode;                                  /* 0x0b: тип очереди (5/6 — с MAC-очередью) */
    u8  state;                                 /* 0x0c: 0 — нет, 1 — окно задано, 2 — настроена */
    u8  sector_mode;                           /* 0x0d: tx_macq_setup_params a1 */
    union {
        u16 ctl;                               /* 0x0e: бит 1 — tx_macq_setup_params a2 */
        struct {
            u8 ctl_lo;                         /* 0x0e */
            u8 to_res;                         /* 0x0f: tx_macq_setup_params a3 */
        };
    };
};
VRS_OFF(struct vring_tbl_entry, param_b, 0x08);
VRS_OFF(struct vring_tbl_entry, macq, 0x0a);
VRS_OFF(struct vring_tbl_entry, state, 0x0c);
VRS_OFF(struct vring_tbl_entry, ctl, 0x0e);
VRS_OFF(struct vring_tbl_entry, to_res, 0x0f);
_Static_assert(sizeof(struct vring_tbl_entry) == 0x10, "vring_tbl_entry");

#define VRING_TBL_N   32
#define VRING_RECS_N  9

/* Экземпляры (DCCM, FWDATA): vring.c, tx_helpers.c. */
extern struct vring_schd vring_schd;                       /* 0x804dbc */
extern struct vring_schd_alt vring_schd_alt;               /* 0x804e64 */
extern struct vring_rec vring_recs[VRING_RECS_N];          /* 0x804c40: элементы пула 0x804da8 */
extern struct vring_tbl_entry vring_tbl[VRING_TBL_N];      /* 0x806014 */
extern const struct vring_schd_vt vring_schd_vtbl;         /* 0x8008e8 */
extern const struct vring_schd_vt vring_schd_alt_vtbl;     /* 0x800918 */

/* Обработчик завершения остановки pring (pring__set_done_handler 0x8e7334): id pring и
 * аргумент [0x80018c]. */
typedef void (*pring_done_fn)(u32 id, u32 arg);
extern pring_done_fn pring_done_handler;                   /* 0x800188 */

#endif
