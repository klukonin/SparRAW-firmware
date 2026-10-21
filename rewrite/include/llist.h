/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Список llist (vendor): {число, голова, хвост}; узел — {next, owner} в начале элемента
 * (sched.c: list_find_entry_d, llist_pop_front; vring.c: tx_list_remove, iter_*). Функции sched.c
 * принимают список и узел как void * — и struct llist / объект с узлом в начале, и (u32 *). */
#ifndef LLIST_H
#define LLIST_H
#include "types.h"

struct llist {
    u32 count;
    u32 head;
    u32 tail;
};
_Static_assert(sizeof(struct llist) == 12, "llist");

/* Узел списка — в начале элемента. */
struct llist_node {
    u32 next;                                  /* 0x00: следующий элемент (0 — конец) */
    u32 owner;                                 /* 0x04: список-владелец (0 — не в списке) */
};
_Static_assert(sizeof(struct llist_node) == 8, "llist_node");

#endif
