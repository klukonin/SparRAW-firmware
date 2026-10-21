/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* POWER_MNGR (fw/power.c, fw/power_halt.c): PS-контекст шагов останова питания (struct ps_ctx,
 * power_halt_seq — нужен hwm_analog_prepare_buf и UT_HW_MODES) и счётчики доступности кадров по
 * cid (FWQ_TX_AVAILABILITY). Менеджер питания vendor (0x803d10: автомат питания PCIe, PS-менеджеры,
 * счётчики deep sleep) и схема профилей PS (0x803d5c) вырезаны вместе с энергосбережением — см.
 * fw/action.c psc_req_reject и fw/vectors.c pcie_pm_event_unsupported. Смещения закреплены
 * _Static_assert. */
#ifndef POWER_H
#define POWER_H
#include "types.h"
#include "basic_sm.h"
#include "fwsh.h"

#define PWR_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)


/* Режимы hw_modes PS-контекста (ut_hw_modes_cmd_0x308): flags — биты 0 PHY, 1 режим
 * питания (power_mode), 2 PCIe low power, 3 apply_flags (hwm_apply_mode_flags). */
struct ps_hw_modes {
    u32 flags;                                 /* 0x00 */
    u32 power_mode;                            /* 0x04: аргумент hw_modes_apply_power_mode */
    u32 apply_flags;                           /* 0x08: биты hwm_apply_mode_flags */
};

/* PS-контекст (0x10 Б): шаги останова/пробуждения питания (power_halt_seq). */
struct ps_ctx {
    volatile u32 flags;                        /* 0x00: биты 0..9 — шаги power_halt_seq; 10 — PLL;
                                                * 11 — сигнал ucode; 12 — пробуждение по TSF */
    struct ps_hw_modes hw;                     /* 0x04 */
};
PWR_OFF(struct ps_ctx, hw.apply_flags, 0x0c);
_Static_assert(sizeof(struct ps_ctx) == 0x10, "ps_ctx");



/* FWQ_TX_AVAILABILITY (struct fwq_tx_avail, 0x857040, общая с uc) — include/fwsh.h. */

/* Объекты (определения: power.c). */

#endif
