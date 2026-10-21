/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Заголовок автомата basic_sm (fw/power.c: basic_sm_bind_descriptor, basic_sm_handle_event,
 * basic_sm_do_transition) — первые 8 Б любого объекта-автомата vendor 6.2. Описатель
 * (desc): [0] число событий, [1] число состояний, [2] начальное состояние, [4] таблица
 * переходов, [8] имена состояний, [0xc] имена событий, [0x10] ид автомата. */
#ifndef BASIC_SM_H
#define BASIC_SM_H
#include "types.h"

/* Описатель автомата (0x14 Б; в DCCM, ид [0x10] пишут конструкторы fw/ctors.c). Таблица
 * переходов — записи по 5 Б без выравнивания {действие (u32), следующее состояние (u8)},
 * индекс = состояние + число_состояний · событие. Имена — массивы адресов строк журнала. */
/* Действие перехода автомата: (автомат, a0, a1, a2) — basic_sm__do_transition зовёт все
 * действия так; у действий с меньшим числом параметров лишние аргументы игнорируются. */
typedef void (*sm_action_fn)(u32 sm, u32 a0, u32 a1, u32 a2);
/* через void (*)(void): действия пока с «родными» сигнатурами (struct X *, меньше
 * параметров) — без этого -Wcast-function-type на каждую запись таблицы. */
#define SM_ACT(fn) ((sm_action_fn)(void (*)(void))(fn))

/* Запись таблицы переходов (5 Б, без выравнивания): индекс = состояние + n_states * событие,
 * то есть таблица — [событие][состояние]. */
struct __attribute__((packed)) sm_trans {
    sm_action_fn action;                       /* 0x00 */
    u8 next;                                   /* 0x04: следующее состояние */
};
_Static_assert(sizeof(struct sm_trans) == 5, "sm_trans");

struct sm_desc {
    u8 n_events;                               /* 0x00 */
    u8 n_states;                               /* 0x01 */
    u8 init_state;                             /* 0x02 */
    u8 rsv_03;
    const struct sm_trans *table;              /* 0x04: таблица переходов [событие][состояние] */
    const u32 *state_names;                    /* 0x08 */
    const u32 *event_names;                    /* 0x0c */
    u32 id;                                    /* 0x10: ид автомата (для журнала) */
};
_Static_assert(__builtin_offsetof(struct sm_desc, table) == 4, "sm_desc.table");
_Static_assert(__builtin_offsetof(struct sm_desc, id) == 0x10, "sm_desc.id");
_Static_assert(sizeof(struct sm_desc) == 0x14, "sm_desc");
#define SM_TRANS_SIZE 5

struct basic_sm {
    u8 state;                                  /* 0x00: текущее состояние */
    u8 event;                                  /* 0x01: последнее событие */
    u8 deferred;                               /* 0x02: отложенное событие (0xff — нет) */
    u8 trace;                                  /* 0x03: != 0 — журнал переходов и действий */
    const struct sm_desc *desc;                /* 0x04: описатель */
};
_Static_assert(sizeof(struct basic_sm) == 8, "basic_sm");

/* Отложенное событие автомата (sm__defer_call 0x8e7044, basic_sm__handle_event): элемент пула
 * sm_defer_pool (0x803cbc, 4 × 0x10 с 0x803cd0); номер элемента — в basic_sm.deferred. */
struct sm_defer_node {
    u32 event;                                 /* 0x00 */
    u32 a0;                                    /* 0x04 */
    u32 a1;                                    /* 0x08 */
    u32 a2;                                    /* 0x0c */
};
_Static_assert(sizeof(struct sm_defer_node) == 0x10, "sm_defer_node");
#define SM_DEFER_NODES 4

extern struct sm_defer_node sm_defer_nodes[SM_DEFER_NODES];   /* 0x803cd0 (fw/pool.c) */

#endif
