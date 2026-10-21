/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* RF kill (W_DISABLE): автомат rf_mgmt_sm (vendor sm_802338; объект 0x804c34, init —
 * rf_kill_sm_init в fw/l2mgr.c, действия — fw/rf_kill.c). Имена состояний и событий — из
 * таблиц строк vendor (0x800ff0 / 0x800ffc). */
#ifndef RF_KILL_H
#define RF_KILL_H
#include "types.h"
#include "basic_sm.h"

enum { RF_MGMT_ENABLED = 0, RF_MGMT_DISABLED = 1, RF_MGMT_PENDING_DISABLED = 2 };
enum {
    RF_MGMT_EV_W_ENABLE = 0, RF_MGMT_EV_W_DISABLE = 1, RF_MGMT_EV_DISABLE_DONE = 2,
    RF_MGMT_EV_ENABLE_SELF = 3,
};

/* Описатель (ид [0x10] пишет ctor_sm_802338_id) и таблица переходов — fw/rf_kill.c. */
extern struct sm_desc rf_mgmt_sm_desc;                        /* 0x802338 */
extern const struct sm_trans rf_mgmt_sm_table[4][3];          /* 0x80234c */
/* Объект автомата (0x804c34, 8 Б; в образе нули) — fw/l2mgr.c. */
extern struct basic_sm rf_mgmt_sm;

#endif
