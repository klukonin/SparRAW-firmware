// SPDX-License-Identifier: AGPL-3.0-or-later
/* Диспетчер фоновых задач uCode (0x9215d2) — главный цикл uc. */
#include "../include/sta_max.h"
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/hw.h"


/* 0x9215d2. Биты задач 0x800648 & маска 0x800584 ([gp,92]); старший бит —
 * индекс по знаковой байтовой таблице 0x8017d8 (база 0x921624):
 *   0 → 0x92168c  bg_task_call_report_cb(&rx_meas)
 *   1 → 0x9215ba  bf_sm_process_request_fifo
 *   2 → 0x921630  rs_end
 *   3 → 0x92163c  mac_mode_switch_sequence(1) (assert 0x1318, если 0x886dd0 бит 0)
 *   4 → 0x921664  mac_mode_switch_sequence(0) (assert 0x1319, если 0x886dd0 бит 1)
 *   5 → 0x921624  l1_task_kick_and_dispatch_uc
 * Каждому предшествует bg_task_clear_pending_bit(n). Иначе — assert 0x31.
 * СРОК (задержка L1): фоновые задачи и pm_idle_try_enter идут со снятым E1 (STATUS32 бит 1) —
 * прерывания L1 (ilink1: bi1_event/TBTT, GP-события r54 A-BFT и AW→DTI) ждут конца задачи (vendor
 * 0x9215d2 — так же). Длина задачи (l1_task_kick_and_dispatch_uc — всё кольцо команд fw,
 * mac_mode_switch_sequence, bf_sm_process_request_fifo) прямо добавляется к пути TBTT → маяк
 * (l1_task_on_evt1); запас не оценён. Удлинять участки под снятым E1 нельзя. */
void background_task_dispatch(void)
{
    volatile u32 *tasks = &bg_task_pending;
    for (;;) {
        u32 s;
        if (!(VOL(bg_task_mask) & *tasks)) {
            /* L_9216a8: простой — фоновый шаг BI, затем сон, если задач всё ещё нет */
            s = arc_lr(ARC_STATUS32);
            arc_flag(s & ~(1u << 1));
            pm_idle_try_enter();
            arc_flag(arc_lr(ARC_STATUS32) | (s & (1u << 1)));
            uc_rssi_sample();                           /* SparRAW: RSSI станций — с разрешёнными прерываниями L1 */
#ifdef UC_BENCH
            uc_bench_tick();                            /* микротесты цены операций (uc/bench.c) */
#endif
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

#ifdef UC_STAMP_MASK
        u32 st0 = arc_lr(0x100);
#endif
        switch (bit) {
        case 0:
            bg_task_clear_pending_bit(0);
            bg_task_call_report_cb(&rx_meas);
            break;
        case 1:
            bg_task_clear_pending_bit(1);
            bf_sm_process_request_fifo();
            break;
        case 2:
            bg_task_clear_pending_bit(2);
            rs_end();
            break;
        case 3:
            if (MMIO32(HW_FW2UC_ICR) & 1u)
                uc_assert((u32)__builtin_return_address(0), 0x1318);
            bg_task_clear_pending_bit(3);
            mac_mode_switch_sequence(1);
            break;
        case 4:
            if (MMIO32(HW_FW2UC_ICR) & 2u)
                uc_assert((u32)__builtin_return_address(0), 0x1319);
            bg_task_clear_pending_bit(4);
            mac_mode_switch_sequence(0);
            break;
        case 5:
            bg_task_clear_pending_bit(5);
            l1_task_kick_and_dispatch_uc();
            break;
        default:
            uc_assert((u32)__builtin_return_address(0), 0x31);
            break;
        }
        /* L_9215c4 */
#ifdef UC_STAMP_MASK
        {
            u32 d = arc_lr(0x100) - st0;
            if (d > STAMP_LONG_CLK && d < 0x1000000u)
                UC_STAMP(STAMP_LONG_TASK, bit, d);          /* фоновая задача (L1 запрещены) */
        }
#endif
        arc_flag(arc_lr(ARC_STATUS32) | (s & (1u << 1)));
    }
}

/* boot_uc_init_tail = хвостовой переход в главный цикл. */
void boot_uc_init_tail(void)
{
    background_task_dispatch();
}

/* RSSI станций (fwsh_rssi, include/fwsh.h): в простое, после нового PPDU (ppdu_evt_cnt изменился) — если последний
 * принятый кадр от известной станции (r38 б11, cid [10:8]), отсчёт «RSSI АЦП (0x883bec[9:0], знак., Q4 дБ) + 16·строка
 * AGC (0x88306c[5:0])» — входы rx_energy__calc_rssi_q4 — в скользящее среднее станции (вес 1/16). Кадр станции
 * принимается её RX-сектором (rx_sel), т. е. отсчёт — по лучу, предназначенному станции. Вне сроков: прерывания
 * разрешены, ответы через SIFS не затрагиваются. */
void uc_rssi_sample(void)
{
    u32 n = ppdu_evt_cnt;
    if (n == FWSH(fwsh_rssi, last_ppdu))
        return;
    FWSH(fwsh_rssi, last_ppdu) = n;
    u32 r38 = mac_rx_rep3();
    if (!(r38 & MAC_RX_REP3_ADDR2_VALID))
        return;
    u32 sta = MAC_RX_REP3_ADDR2_IDX_OF(r38);
    if (sta >= SPARRAW_MAX_STA)
        return;
    s32 adc = (s32)(MMIO32(HW_PHY_RX_RSSI_ADC_LOCKED) << 22) >> 22;
    s32 raw = adc + (s32)((MMIO32(HW_PHY_RX_AGC_ROW) & 0x3fu) << 4);
    u32 c = FWSH_AT(fwsh_rssi, cnt, sta);
    s32 q = FWSH_AT(fwsh_rssi, q4x16, sta);
    q = (c == 0) ? raw * 16 : q + ((raw * 16 - q) >> 4);
    FWSH_AT(fwsh_rssi, q4x16, sta) = q;
    if (c != 0xffffu)
        FWSH_AT(fwsh_rssi, cnt, sta) = (u16)(c + 1u);
}
