// SPDX-License-Identifier: AGPL-3.0-or-later
/* Power-менеджер uCode. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"


u32 power_manager_scale_counters_ms(void)
{
    /* 0x92e6c0: q = [0x8007c0]/1000; результат [0x8007c4]/q (0, если q = 0). */
    u32 q = uc_divmod_unsigned(power_stats.delta, 1000);
    if (q == 0)
        return 0;
    return uc_divmod_unsigned(power_stats.delta_time, q);
}

u32 power_mngr_stats_calc_delta(u32 a)
{
    /* 0x92e6e8 */
    power_stats.delta = a - power_stats.base;
    u32 d = uc_stats.rx_ppdu - power_stats.base_time;
    power_stats.delta_time = d;
    return d;
}

void power_mngr_stats_mark_base(u32 a)
{
    power_stats.base_time = uc_stats.rx_ppdu;
    power_stats.base = a;
}

void power_manager_tick_if_elapsed(void)
{
    u32 now = uc_read_tsf_lo();
    if (now - power_stats.base >= 0x17ed0) {
        power_mngr_stats_calc_delta(now);
        power_mngr_stats_mark_base(now);
    }
}

/* Обработчик ucode-команды 0x1b (0x92e748). */
void ucode_cmd_0x1b_handler(const struct lmac_cmd_role *c)
{
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    pm_cfg_flag = c->pm_cfg;
    u32 v = c->mode;
    uc_role_ap = (v == 2 || v == 3) ? 1 : 0;
    uc_role = c->mode;
    arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
}
