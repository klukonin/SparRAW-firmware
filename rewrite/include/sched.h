/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Планировщик fw (u_schd, fw/sched.c): задачи, ready-очереди по приоритетам, очереди таймеров
 * с таблицами методов (база времени), пул задач. Раскладка — как у vendor 6.2 (объект в DCCM
 * 0x803c54..0x803cbc, элементы пула задач — SRAM 0x844914); смещения закреплены _Static_assert. */
#ifndef SCHED_H
#define SCHED_H
#include "types.h"
#include "llist.h"
#include "mem_pool.h"

#define SCHED_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

/* Задача u_schd (u_schd_add) и таймер (u_schd_schedule) вызываются как cb(a0, a1). */
typedef void (*u_schd_fn)(u32 a0, u32 a1);

/* Сравнение моментов времени (time_cmp 0x8e91bc): 1 — b не позже a (с переполнением), иначе -1.
 * Компаратор сортированной вставки list_find_entry. */
typedef s32 (*u_schd_cmp_fn)(u32 a, u32 b);

/* Задача / таймер (0x1c Б): элемент пула u_schd.task_pool, узел llist ready-очереди или очереди
 * таймеров. Описатель таймера, который возвращает u_schd_schedule и принимает u_schd_cancel, —
 * адрес задачи (u32). */
struct u_schd_task {
    struct u_schd_task *next;                  /* 0x00: узел llist */
    struct llist *owner;                       /* 0x04: список-владелец (0 — не в списке) */
    u32 deadline;                              /* 0x08: момент срабатывания (база очереди) */
    u_schd_fn cb;                              /* 0x0c */
    u32 a0;                                    /* 0x10 */
    u32 a1;                                    /* 0x14 */
    u8  prio;                                  /* 0x18: ready-очередь по срабатыванию */
    u8  armed;                                 /* 0x19: 1 — таймер (u_schd_cancel проверяет) */
    u8  rsv_1a[2];                             /* 0x1a */
};
SCHED_OFF(struct u_schd_task, deadline, 0x08);
SCHED_OFF(struct u_schd_task, cb, 0x0c);
SCHED_OFF(struct u_schd_task, prio, 0x18);
SCHED_OFF(struct u_schd_task, armed, 0x19);
_Static_assert(sizeof(struct u_schd_task) == 0x1c, "u_schd_task");

struct u_schd_tq;

/* Таблица методов очереди таймеров (vendor 0x8008d8 / 0x8008e0). */
struct u_schd_tq_vt {
    u32 rsv0;
    u32 (*time_base)(struct u_schd_tq *q, u32 t);   /* [1] момент t (время u_schd) в базе очереди */
};
_Static_assert(sizeof(struct u_schd_tq_vt) == 8, "u_schd_tq_vt");

/* Очередь таймеров (0x14 Б): задачи по возрастанию deadline (list_find_entry с time_cmp). */
struct u_schd_tq {
    struct llist list;                         /* 0x00 */
    u32 now;                                   /* 0x0c: «сейчас» в базе очереди при последнем
                                                *       пересчёте (vt->time_base(q, 0)) */
    const struct u_schd_tq_vt *vt;             /* 0x10 */
};
SCHED_OFF(struct u_schd_tq, now, 0x0c);
SCHED_OFF(struct u_schd_tq, vt, 0x10);
_Static_assert(sizeof(struct u_schd_tq) == 0x14, "u_schd_tq");

#define U_SCHD_NPRIO  3                        /* ready-очереди (ассерт 0x1064/0x1065) */
#define U_SCHD_NTQ    2                        /* очереди таймеров */
#define U_SCHD_NTASKS 0x78                     /* пул задач (l2mgr__init_frame_pool) */

/* Объект планировщика (DCCM 0x803c54, vendor r13 = 0x803c54 в l2mgr__init_frame_pool). */
struct u_schd {
    struct u_schd_tq *tq[U_SCHD_NTQ];          /* 0x00: очередь 0 — tq_obj[1] (база TSF/16),
                                                *       очередь 1 — tq_obj[0] (время u_schd) */
    struct llist ready[U_SCHD_NPRIO];          /* 0x08: ready-очереди (0x803c5c + prio * 12) */
    struct mem_pool task_pool;                 /* 0x2c: пул задач (0x803c80) */
    struct u_schd_tq tq_obj[U_SCHD_NTQ];       /* 0x40: 0x803c94 (add3 r13,8), 0x803ca8 (add2 r13,0x15) */
};
SCHED_OFF(struct u_schd, ready, 0x08);
SCHED_OFF(struct u_schd, task_pool, 0x2c);
SCHED_OFF(struct u_schd, tq_obj, 0x40);
_Static_assert(sizeof(struct u_schd) == 0x68, "u_schd");

/* Описатель аппаратного таймера ARC (vendor 0x800948, 2 × 0x10; timer__start): номера
 * вспомогательных регистров COUNT/CONTROL/LIMIT и последний режим. */
struct arc_timer_cfg {
    u32 count_aux;                             /* 0x00: 0x21 / 0x100 */
    u32 ctrl_aux;                              /* 0x04: 0x22 / 0x101 */
    u32 limit_aux;                             /* 0x08: 0x23 / 0x102 */
    u32 mode;                                  /* 0x0c: записанный режим CONTROL (2/3/4) */
};
_Static_assert(sizeof(struct arc_timer_cfg) == 0x10, "arc_timer_cfg");

/* Экземпляры: DCCM — FWDATA в fw/sched.c, вне DCCM — fw/fw.ld. */
extern struct u_schd u_schd;                                  /* 0x803c54 */
extern struct u_schd_task u_schd_tasks[U_SCHD_NTASKS];        /* 0x844914 (SRAM) */
extern const struct u_schd_tq_vt u_schd_tq_local_vtbl;        /* 0x8008d8 */
extern const struct u_schd_tq_vt u_schd_tq_tsf_vtbl;          /* 0x8008e0 */
extern struct arc_timer_cfg arc_timer_cfg[2];                 /* 0x800948 */

#endif
