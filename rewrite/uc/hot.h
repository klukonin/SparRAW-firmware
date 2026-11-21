/* SPDX-License-Identifier: AGPL-3.0-or-later */
#ifndef UC_HOT_H
#define UC_HOT_H
/* Тела примитивов MAC / direct-TX для путей без запаса по сроку. Одноимённые функции (mac.c, tx.c, mem.c,
 * uutil.c) — обёртки над этими телами с точкой перехвата на входе (nop, -fpatchable-function-entry); здесь —
 * те же команды без вызова. Применение — пачка SSW ответчика в A-BFT (abft_ssw_burst, bti.c): соседние SSW через
 * SBIFS = 1 мкс ± aSBIFSAccuracy 0,03 мкс (802.11-2020 10.3.2.3.8), запас пути 0…2 такта (ХРУПКО там же). Семь
 * вызовов на отрезке «передатчик свободен → 0x19» с точкой перехвата каждый дали зазор 1,061–1,079 мкс
 * (эмулятор, test_ref_diff::test_abft_feedback). Перехват внутри пачки — только на входе abft_ssw_burst. */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/hw.h"
#include "dccm.h"
#include "mac_regs.h"
#include "mac_cmd.h"
#include "proto.h"

#define UC_INL static inline __attribute__((always_inline))

UC_INL u32 uc_spin_until_event_i(u32 mask)
{
    u32 v;
    do {
        v = mac_evt1();                    /* 0x9366dc: tst r42,r0 */
    } while (!(v & mask));
    return mask;
}

/* СРОК — см. mac_evt_enable_bit_sync (mac.c). */
UC_INL void mac_evt_enable_bit_sync_i(u32 a)
{
    u32 mask = (1u << a) << 8;
    u32 r1 = mac_evt_en_shadow | (mask | 0x27000000u);
    uc_mac_cmd(r1);
    uc_mac_cmd(0x2004000);
    arc_nops(3);
    uc_spin_until_event_i(MAC_EVT1_BUSY2);
}

UC_INL void direct_tx_program_desc_i(u32 a, u32 b)
{
    uc_mac_cmd(0x33000001);
    tx_fifo_free = b;
    direct_tx_cmd34_hi = a;
    uc_mac_cmd((a << 16) | (b | 0x34000000));
}

/* ХРУПКО — см. tx_fifo_write_bytes (mem.c): слова через r33 циклом lp, хвост 1..3 байта загрузкой в r34. */
UC_INL void tx_fifo_write_bytes_i(u32 src, u32 len)
{
    if (src & 3)
        uc_assert((u32)__builtin_return_address(0), 0x37);
    const u32 *w = (const u32 *)src;
    u32 n = len >> 2;
    if (n) {
        __asm__ volatile("mov lp_count,%1\n\t"
                         "nop_s\n\t"
                         "lp 1f\n\t"
                         "ld.ab r33,[%0,4]\n\t"
                         "mov 0,0\n"
                         "1:"
                         : "+r"(w)
                         : "r"(n)
                         : "lp_count", "memory");
    }
    const u8 *b = (const u8 *)w;
    switch (len & 3) {
    case 3:
        __asm__ volatile("ldb.ab r34,[%0,1]\n\tldb.ab r34,[%0,1]\n\tldb r34,[%0]" : "+r"(b) :: "memory");
        break;
    case 2:
        __asm__ volatile("ldb.ab r34,[%0,1]\n\tldb r34,[%0]" : "+r"(b) :: "memory");
        break;
    case 1:
        __asm__ volatile("ldb r34,[%0]" :: "r"(b) : "memory");
        break;
    }
    tx_fifo_free -= len;
}

/* СРОК — см. uc_wait_direct_tx_ready (uutil.c). */
UC_INL void uc_wait_direct_tx_ready_i(void)
{
    u32 r0 = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = r0;
    uc_mac_cmd(r0 | MAC_CMD_STATUS_SEL);
    arc_nops_nop(2);
    u32 v;
    do {
        v = mac_txctl_sel();
    } while (!(v & MAC_DTX_CMD_READY));
}

UC_INL void direct_tx_commit_i(void)
{
    uc_mac_cmd(0x33000002);
    if (tx_fifo_free != 0)
        uc_assert((u32)__builtin_return_address(0), 0x36);
}

UC_INL void mac_program_tx_common_i(void)
{
    /* 0x92d990 */
    MTP_REQUEST(MTP_W16(0x1f0040u), MTP_W17(MTP_RATE(0u)));
}

UC_INL void tx_program_vector_rf_i(u32 b)
{
    uc_mac_cmd(0x38000200);
    uc_mac_cmd(b | 0x3f000000);
    uc_mac_cmd(0x3e000000);
    uc_mac_cmd(0x37000020);
    uc_stats.tx_start += 1;
    u32 r0 = abif_dvs_rf_ctrl_shadow & 0xfcffffff;
    r0 |= rf_set_tx << 24;
    abif_dvs_rf_ctrl_shadow = r0;
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r0;
}

#endif
