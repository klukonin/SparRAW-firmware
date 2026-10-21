// SPDX-License-Identifier: AGPL-3.0-or-later
/* Диспетчер фоновых задач uCode (0x9215d2) — главный цикл uc. */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/hw.h"


/* 0x9215d2. Биты задач 0x800648 & маска 0x800584 ([gp,92]); старший бит —
 * индекс по знаковой байтовой таблице 0x8017d8 (база 0x921624):
 *   0 → 0x92168c  bg_task_call_cb20(&rx_meas)
 *   1 → 0x9215ba  bf_sm_process_request_fifo
 *   2 → 0x921630  rs_end
 *   3 → 0x92163c  mac_mode_switch_sequence(1) (assert 0x1318, если 0x886dd0 бит 0)
 *   4 → 0x921664  mac_mode_switch_sequence(0) (assert 0x1319, если 0x886dd0 бит 1)
 *   5 → 0x921624  l1_task_kick_and_dispatch_uc
 * Каждому предшествует bf_pending_clear_bit(n). Иначе — assert 0x31.
 * СРОК (задержка L1): фоновые задачи и background_bi_step идут со снятым E1 (STATUS32 бит 1) —
 * прерывания L1 (ilink1: bi1_event/TBTT, GP-события r54 A-BFT и AW→DTI) ждут конца задачи (vendor
 * 0x9215d2 — так же). Длина задачи (l1_task_kick_and_dispatch_uc — всё кольцо команд fw,
 * mac_mode_switch_sequence, bf_sm_process_request_fifo) прямо добавляется к пути TBTT → маяк
 * (l1_task_main_step); запас не оценён. Удлинять участки под снятым E1 нельзя. */
void background_task_dispatch(void)
{
    volatile u32 *tasks = &bg_task_pending;
    for (;;) {
        u32 s;
        if (!(VOL(bg_task_mask) & *tasks)) {
            /* L_9216a8: простой — фоновый шаг BI, затем сон, если задач всё ещё нет */
            s = arc_lr(ARC_STATUS32);
            arc_flag(s & ~(1u << 1));
            background_bi_step();
            arc_flag(arc_lr(ARC_STATUS32) | (s & (1u << 1)));
            s = arc_lr(ARC_STATUS32);
            arc_flag(s & ~(1u << 1));
            if (!(*tasks & VOL(bg_task_mask))) {
                arc_flag(arc_lr(ARC_STATUS32) | 0x6);
                __asm__ volatile("sleep 0");
            }
            arc_flag(arc_lr(ARC_STATUS32) | (s & (1u << 1)));
            continue;
        }

        bg_task_running = 0;                           /* st.as [gp,25] */
        s = arc_lr(ARC_STATUS32);
        arc_flag(s & ~(1u << 1));

        u32 pending = VOL(bg_task_mask) & *tasks;
        u32 bit = 0;
        if (pending != 0) {
            bit = 30 - arc_norm(pending);
            bg_task_running |= 1u << bit;
        }

        switch (bit) {
        case 0:
            bf_pending_clear_bit(0);
            bg_task_call_cb20(&rx_meas);
            break;
        case 1:
            bf_pending_clear_bit(1);
            bf_sm_process_request_fifo();
            break;
        case 2:
            bf_pending_clear_bit(2);
            rs_end();
            break;
        case 3:
            if (MMIO32(HW_FW2UC_ICR) & 1u)
                uc_assert((u32)__builtin_return_address(0), 0x1318);
            bf_pending_clear_bit(3);
            mac_mode_switch_sequence(1);
            break;
        case 4:
            if (MMIO32(HW_FW2UC_ICR) & 2u)
                uc_assert((u32)__builtin_return_address(0), 0x1319);
            bf_pending_clear_bit(4);
            mac_mode_switch_sequence(0);
            break;
        case 5:
            bf_pending_clear_bit(5);
            l1_task_kick_and_dispatch_uc();
            break;
        default:
            uc_assert((u32)__builtin_return_address(0), 0x31);
            break;
        }
        /* L_9215c4 */
        arc_flag(arc_lr(ARC_STATUS32) | (s & (1u << 1)));
    }
}

/* boot_uc_init_tail = хвостовой переход в главный цикл. */
void boot_uc_init_tail(void)
{
    background_task_dispatch();
}
