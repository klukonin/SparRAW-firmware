/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Монитор PHY (vendor 6.2): периодическая служба (struct psvc, include/link_loss.h) с
 * тремя флагами; объект 0x84e7e0 (рабочая память, символ fw/fw.ld), таблица методов
 * 0x8007a0 (DCCM, fw/phy_monitor.c) — таблица psvc_vt и слот 0x14 on_system_state.
 * Инициализация — l2mgr__init_periodic_detector (0x8d8ce0, fw/l2mgr.c), таблица — ctor
 * 0x8c19a8 (fw/ctors.c); флаг dump_off — WMI статистики PHY (fw/mac_ext.c, fw/phy_ext.c). */
#ifndef PHY_MONITOR_H
#define PHY_MONITOR_H
#include "types.h"
#include "link_loss.h"

struct phy_monitor;

/* Таблица методов монитора PHY (0x8007a0, 0x18 Б). */
struct phy_monitor_vt {
    struct psvc_vt psvc;                       /* 0x00: start/stop/task (phy_stats__dump)/run */
    void (*on_system_state)(struct phy_monitor *o, u32 st, u32 idle, u32 conn);   /* 0x14: 0x8e889c */
};
_Static_assert(sizeof(struct phy_monitor_vt) == 0x18, "phy_monitor_vt");

/* Монитор PHY (0x3c Б). */
struct phy_monitor {
    struct psvc svc;                           /* 0x00 */
    u32 enabled;                               /* 0x30: разрешён по системному состоянию */
    u32 freeze_stats;                          /* 0x34: замораживать и сбрасывать статистику PHY вокруг снимка */
    u32 dump_off;                              /* 0x38: 1 — дамп запрещён (идёт WMI-статистика PHY) */
};
LL_OFF(struct phy_monitor, enabled, 0x30);
LL_OFF(struct phy_monitor, freeze_stats, 0x34);
LL_OFF(struct phy_monitor, dump_off, 0x38);
_Static_assert(sizeof(struct phy_monitor) == 0x3c, "phy_monitor");

extern struct phy_monitor phy_monitor;                  /* 0x84e7e0 (fw.ld) */
extern const struct phy_monitor_vt phy_monitor_vtbl;    /* 0x8007a0 (DCCM) */

#endif
