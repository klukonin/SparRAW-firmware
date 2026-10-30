// SPDX-License-Identifier: AGPL-3.0-or-later
/* Цепочка загрузки uCode (второй CPU).
 * _uc_reset (start.S) → uc_init → uc_main → boot_uc_init_structs →
 * boot_uc_init_and_run → idle-петля. */
#include "../include/types.h"
#include "../include/arc.h"
#include "dbg.h"
#include "../include/hw.h"


/* Многоядерный handshake при старте (0x93e2c0). */
void uc_init(void)
{
    if (uc_skip_core_check == 1)
        return;
    u32 cpu = arc_lr(0x7b) & 0xff;
    if (cpu != 1 && cpu != 4) {
        arc_flag(1);
        for (;;)
            __asm__ volatile("");
    }
    if ((arc_lr(0x7d) & 0xff) != 0)
        return;
    arc_flag(1);
    for (;;)
        __asm__ volatile("");
}

/* Инициализация структур boot (0x920114). */
void boot_uc_init_structs(void)
{
    uc_list_insert_by_prio((u32)&init_desc_globals);
    uc_list_insert_by_prio((u32)&uc_init_desc_key);
    uc_list_insert_by_prio((u32)&init_desc_cmdq);
    uc_list_insert_by_prio((u32)&init_desc_801aec);
    uc_list_insert_by_prio((u32)&init_desc_more);
    arc_nop_s();   /* vendor L_92014a: 1×nop */
    timer_list_init();
}

/* Главная точка входа uCode (0x920900). */
void uc_main(void)
{
    if (uc_cold_boot != 0) {
        memset0_words_uc((void *)&fsched_peers, (u32)&uc_log - (u32)&fsched_peers);   /* весь BSS 0x801be8..0x803234 */
        memset0_words_uc((void *)0, 0);
    }
    g_800428 = 0;
    boot_uc_init_structs();
    boot_uc_init_and_run();
}

/* Инициализация данных 0x800610 (0x920a10). */
void boot_uc_init_and_run(void)
{
    uc_log_init_ring();
    g800610.h0 = 6;
    g800610.h2 = 2;
    g800610.h4 = 0;
    g800610.w8 = 0x3e8;
    g800610.b0c = 0x1b;
    g800610.b0d = 0x24;
    g800610.b0e = 0xf;
    g800610.b0f = 0x1e;
    g800610.b10 = 1;
    g800610.b11 = 0x13;
    boot_uc_publish_mac_cmd_log((u32)mac_cmd_log);   /* начало кольца MAC-команд — хосту */
    boot_uc_publish_mac_cmd_log_snap((u32)&mac_trace_ptr_snap);   /* MMIO 0x880010 = адрес снимка указателя кольца MAC-команд */
    bi_mode_init_sequence();
    uc_timers_start_with_irq();
#ifdef UC_STAMP_MASK
    if ((UC_STAMP_MASK) & (1u << STAMP_L1_EVT)) {               /* регистры масок прерываний MAC — один раз */
        static const u32 regs[] = { 0x886d3c, 0x886d40, 0x886d44, 0x886fbc, 0x886fc0, HW_MAC_SXD_MAC_HW_ICR,
                                    HW_MAC_SXD_MAC_HW_ICR + 4, HW_MAC_HW_ICR_IMV, HW_MAC_SXD_ERRORS_ICR,
                                    HW_MAC_SXD_ERRORS_ICR + 4, HW_MAC_SXD_ERRORS_IMV };
        for (u32 i = 0; i < sizeof(regs) / sizeof(regs[0]); i++)
            UC_STAMP(STAMP_L1_EVT, 0xffu << 24 | regs[i], MMIO32(regs[i]));
    }
#endif
    uc_send_evt_ucode_ready();
    uc_irq_enable_e1_e2();
    boot_uc_init_tail();
}

/* Запись в 0x88000c (0x92a6e4). */
void boot_uc_publish_mac_cmd_log(u32 v)
{
    MMIO32(HW_RGF_USER_USAGE_3) = v;
}

/* Включить IRQ (STATUS32 |= 6) (0x9202f4). */
void uc_irq_enable_e1_e2(void)
{
    arc_flag(arc_lr(ARC_STATUS32) | 0x6);
}

/* Сигнал fw "ucode ready" (0x927508). */

void uc_send_evt_ucode_ready(void)
{
    uc_mailbox_init_rings(&uc_mbox);
    mac_fw2uc_irq_unmask_cmd_halt_wake();
    u32 evt = uc_evt_write_slot(&uc_mbox);
    uc_evt_enqueue(evt, 0, 0, 0);
}

/* Запись в 0x880010 (0x92a6f0, "boot_uc_publish_mac_cmd_log_snap"). */
void boot_uc_publish_mac_cmd_log_snap(u32 v)
{
    MMIO32(HW_RGF_USER_USAGE_4) = v;
}



/* Программирование таймеров MAC (0x93c8e0). */
void uc_timers_start_with_irq(void)
{
    uc_timer_start(1, 0, 0x13ab6680, 2);
    uc_timer_start(0, 0, 0x672, 1);
}

/* BI-mode инициализация (0x9365fc) — портировано. */

void bi_mode_init_sequence(void)
{
    /* 6.2 asm 0x9365fc. */
    bi_mode_load_cmd1e_operand();
    MMIO32(HW_MAC_CMD0D_TIME_LO) = 0xfa; /* st.as [0x887000,-0x90] */
    MMIO32(HW_MAC_BI_INIT_ZERO_AC) = 0;  /* st.as [0x887000,-0x95] */
    MMIO32(HW_MAC_TIMED_WAIT_US) = 0x7d0; /* st.as [0x887000,-0xac] */
    MMIO32(HW_MAC_BI_INIT_ZERO_F78) = 0;                /* st [0x887000,-0x88] */
    MMIO32(HW_MAC_BI_INIT_ZERO_F7C) = 0;                /* st [0x887000,-0x84] */
    bi_mode_program_mac_timing();
    bf_init_globals();
    mac_set_default_slot_timing();
    tx_ctx_alloc_next(1);
    bi_mode_init_event_timers();
    bi_mode_init_sta_table();
    if (rx_buf_toggle_dis == 0) {
        u32 r0 = (rx_buf_toggle_cnt & 1) | (1u << 25) | (1u << 28) | (1u << 29);
        uc_mac_cmd(r0);   /* mailbox uc->fw */
        rx_buf_toggle_cnt = rx_buf_toggle_cnt + 1;
    }
    __asm__ volatile("mov r25,%0" :: "r"((u32)mac_cmd_log) : "memory");   /* mov_s r25,r0 (delay-слот): сброс кольца MAC-команд */
    bti_clear_sweep_counters((u32)mac_cmd_log);   /* vendor: r0 = то же значение (аргумент не читается) */
    rx_nav_reset_flags_arm(1);
    MMIO32(HW_MAC_BEACON_INTERVAL) = 0x64;
    bi_init_set_mac_arg_pair(0x1388, 1);
    MMIO32(HW_PRS_RX_CTRL_886250) &= ~(1u << 16);
    uc_mac_cmd(0x280000e1);   /* mailbox */
    bi_sm_init();
    bi_ctx_set_active(&bi_ctx);
    bi_ctx_clear_counters(&pm_ctx);
    uc_mac_cmd(0x3000030);
}

/* Маска DDC бит 3 (0x92735c). */
void mac_fw2uc_irq_unmask_cmd_halt_wake(void)
{
    MMIO32(HW_FW2UC_IMV) = 8;
}

/* Старт таймера uc (0x937354). */
void uc_timer_start(u32 a, u32 b, u32 c, u32 d)
{
    struct uc_timer_aux *t = &uc_timer[a];
    u32 r7 = t->ctrl;
    arc_sr(0, r7);
    arc_sr(c, t->limit);                        /* delay-слот brne.d — всегда */
    if (d == 3) {
        t->xc = 4;
        arc_sr(4, r7);
    } else if (d == 0) {
        t->xc = 2;
        arc_sr(2, r7);
    } else {
        uc_irq_set_level(a * 4 + 3, (d == 2) ? 1 : 0);
        t->xc = 3;
        arc_sr(3, t->ctrl);                     /* vendor перечитывает [r13,4] */
    }
    arc_sr(b, t->count);
}

/* Безопасное (IRQ-off) чтение [a+4] (0x920d4c). */
/* Тело следующей свободной записи кольца событий (адрес за заголовком uc_evt_hdr). */
u32 uc_evt_write_slot(struct uc_mbox_ctx *m)
{
    UC_STAMP(STAMP_EVT, 0, 0);
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    u32 r14 = uc_ring_cur_addr(&m->evt);
    arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
    if (r14 != 0)
        r14 += 0x10;
    else
        uc_assert((u32)__builtin_return_address(0), 0xc1);
    return r14;
}

/* Колбэки init-дескрипторов из uc_data (поле +4; вызываются timer_list_init).
 * vendor хранил их 0-базовыми адресами; tools/build_fw.py перенаправляет на эти. */

/* 0x92097c (дескриптор 0x8007c8). */
void uc_init_cb_globals(void)
{
    uc_init_globals(&fsched_peers);
}

/* 0x920968 (дескриптор 0x800fe0). */
void uc_init_cb_copy_rf_mask(void)
{
    brp_ctx.rf_mask_all = rf_modules.mask;
}

/* 0x920988 (дескриптор 0x8016e0): b.d 0x920948 → b rx_meas_ctx_init, r0 = 0x803134. */
void uc_init_cb_rx_meas(void)
{
    rx_meas_ctx_init(&rx_meas);
}

/* 0x920994 (дескриптор 0x801640): ld.as r1,[gp,33] = [0x8005ac]. */
void uc_init_cb_bi_sm_name(void)
{
    bi_sm_desc_name = bi_sm_name_ptr;
}

/* 0x9209a4 (дескриптор 0x8013e8): обработчик кольца команд. */
void uc_init_cb_cmdq(void)
{
    uc_mbox.cmd_desc = &cmdq_desc;
}
