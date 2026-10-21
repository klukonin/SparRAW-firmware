// SPDX-License-Identifier: AGPL-3.0-or-later
/* SXD HAL uCode. */
#include "../include/types.h"
#include "../include/arc.h"


/* СРОК: программирование GP-таймера: 0x68 (группа) → 3 nop → 0x67 (данные) → 3 nop → 0x68|0xb
 * (применить); паузы — аппаратные (MAC применяет слово за ~3 такта), vendor 0x934f54 так же; запас —
 * единицы инструкций. Срыв: 0x67 попадёт в прежнюю группу — таймер окна BI/слота с чужим значением. */
/* Запись поля qset через mailbox (0x934f54). */
void sxd_hal_write_qset_field(u32 a, u32 b)
{
    if (b & 0xff000000u)
        uc_assert((u32)__builtin_return_address(0), 0x53);
    mac_evt_select_timer_group(a);
    u32 field = (a << 0x14) & 0xf00000u;
    uc_mac_cmd(field | 0x68000000u);
    arc_nops(3);
    uc_mac_cmd(b | 0x67000000u);
    arc_nops(3);
    uc_mac_cmd(field | 0x6800000bu);
}

/* СРОК: n слотов по slot2_event: 0x02000100 → 3 nop → ждать r42 без тайм-аута (vendor 0x936cc8 и
 * 0x936d64 ниже так же); выдержку задаёт число слотов n; запас по паузе — единицы инструкций. */
/* Ожидание занятости slot2 (0x936cc8). */
u32 sxd_hal_wait_slot2_busy2(u32 n)
{
    if (n == 0)
        uc_assert((u32)__builtin_return_address(0), 0x157f);
    uc_mac_cmd(mac_evt_en_shadow | 0x27000c00u);
    uc_mac_cmd(0x2004000u);
    while (n >= 1) {
        uc_mac_cmd(0x2000100u);
        arc_nops(3);
        uc_wait_event_busy(0x4100, 0);
        if (arc_core_rd(42) & (1u << 14))
            return 1;
        n--;
    }
    return 0;
}

/* Ожидание занятости slot2 (0x936d64). */
u32 sxd_hal_wait_slot2_busy(u32 n)
{
    if (n == 0)
        uc_assert((u32)__builtin_return_address(0), 0x52);
    uc_mac_cmd(0x41u << 0x13);
    while (n >= 1) {
        uc_mac_cmd(0x2000100u);
        arc_nops(3);
        uc_wait_event_busy(0x80100, 0);
        if (arc_core_rd(42) & (1u << 0x13))
            return 1;
        n--;
    }
    return 0;
}
