// SPDX-License-Identifier: AGPL-3.0-or-later
/* Rate-search uCode. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"



/* MCS-кандидат поиска станции. */
UC_HOT
u8 mtp_queue_byte_by_index(u32 idx)
{
    return rs_stats[idx].mcs_try;
}

u8 sta_link_byte_by_index(u32 idx)
{
    return rs_cfg[idx].dbg_disable_internal_trigger;
}

u8 rate_search_current_mcs(u32 a)
{
    if (rs_state[a].active != 0)
        return rs_stats[a].mcs_best;
    return rs_stats[a].mcs_cur;
}

u8 rate_search_current_mcs_b(u32 a)
{
    if (rs_state[a].active != 0)
        return rs_stats[a].mcs_try;
    return rs_stats[a].mcs_cur;
}

u32 rs_is_sta_enabled(u32 a)
{
    u32 mask = 1u << a;
    return ((rs_enabled_mask & mask) == mask) ? 1 : 0;
}

void rate_search_apply_mcs(u32 a, u32 b)
{
    if (b == 8)
        return;
    rs_stats[b].mcs_cur = (u8)a;
    mac_set_cid_mcs_uc(a, b);
}

/* Предыдущий установленный бит в bitmap станции (0x92ffec). */
u32 sched_bitmap_prev_set_bit(u32 a, u32 b)
{
    while (b != 0) {
        b--;
        if (rs_cfg_mcs_en(&rs_cfg[a]) & (1u << b))
            break;
    }
    return b;
}

/* Следующий установленный бит в bitmap станции (0x92ff78). */
u32 sched_bitmap_next_set_bit(u32 a, u32 b)
{
    (void)b;
    u32 start = rs_stats[a].mcs_try + 1;
    u32 mask = 0xffffffffu >> ((32 - start) & 31);
    const struct rs_sta_cfg *cfg = &rs_cfg[a];
    u32 bitmap = rs_cfg_mcs_en(cfg);
    bitmap &= ~mask;
    u32 r14 = 0;
    for (;;) {
        r14++;
        u32 pos = (30 - arc_norm(rs_cfg_mcs_en(cfg)));
        if (pos < r14)
            uc_assert((u32)__builtin_return_address(0), 1);
        if (bitmap & 2u)
            return r14;
        bitmap >>= 1;
    }
}
