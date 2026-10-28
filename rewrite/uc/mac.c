// SPDX-License-Identifier: AGPL-3.0-or-later
/* MAC-хелперы uCode. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"



/* СРОК: r40 читается не раньше 3 тактов после 0x1d (аппаратный, задержка локального чтения):
 * 5 инструкций (st.ab, bclr, 3×nop), vendor 0x9356cc так же; запас — единицы инструкций; то же
 * правило у всех «0x1d … arc_nops(3); r40/r41/r47». TSF_LOW и TSF_HIGH — разные выборки (~12
 * инструкций между чтениями): при переносе через 2^32 мкс между ними результат ошибочен на 2^32,
 * если MAC не защёлкивает TSF_HIGH при выборке TSF_LOW (не проверено). */
/* Чтение 64-битного TSF (0x9356cc) — через aux-регистр r40 (MAC TSF). */
void mac_read_tsf64_uc(u32 *out)
{
    u32 cfg = mac_sel_shadow;
    cfg = (cfg & 0xffff0fff) | 0x5000;
    mac_sel_shadow = cfg;
    uc_mac_cmd(cfg | 0x1d005000);   /* mailbox uc->fw */
    arc_nops(3);
    __asm__ volatile("st r40,[%0]" :: "r"(out) : "memory");

    u32 cfg2 = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = cfg2 | 0x6000;
    uc_mac_cmd(cfg2 | 0x1d006000);   /* mailbox */
    arc_nops(3);
    __asm__ volatile("st r40,[%0]" :: "r"(out + 1) : "memory");
}


void mac_ddc_mask_all_on(void)
{
    MMIO32(HW_FW2UC_IMV) = 0xf;
}

void mac_cfg_set_gp20_default_15748(void)
{
    rf_gain_cb = VENDOR_CB(935748);       /* rf_gain_adjust_cb */
}

void mac_set_sector_arg_and_select_all(u32 a)
{
    MMIO32(HW_MAC_TIMED_WAIT_US) = a;
    mac_select_all_sectors_and_wait();
}

u32 mac_read_time_88c120(void)
{
    return MMIO32(HW_MAC_EXT_WINDOW_REMAIN) & 0xffffff; /* bmsk 0x17 — 24 бита */
}

void mac_core_write_3d_0200(void)
{
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x3d000200;
}

void mac_set_rf_chain_state_with_sta_sector(void)
{
    mac_set_rf_chain_state(1, rf_chain_word);
}

/* СРОК: выход по MAC_EVT1_PPDU_REPORT (ppdu_report_event) или MAC_PHYSIG_CCA_PPDU_COMP (cca_ppdu_comp) в приёмном потоке (rx.c) —
 * опрос 6 инструкций на проход (vendor 0x93675c: 5), без ограничения; задержка реакции — единицы
 * инструкций. Срыв: зависание приёмного потока, если не придёт ни одно событие. */
void mac_wait_event_r42_or_r40(u32 a, u32 b)
{
    /* 0x93675c: tst r42,r0 / tst r40,r1 — core-регистры MAC, не aux. */
    for (;;) {
        if (mac_evt1() & a)
            return;
        if (mac_status_sel() & b)
            return;
    }
}

u16 mac_get_beacon_interval_tu_uc(void)
{
    return (u16)MMIO32(HW_MAC_BEACON_INTERVAL); /* extw — беззнаковое */
}

u32 macq_read_hw_queue_word(u32 q)
{
    u32 addr = ((q << 8) + 0x440c0c0) >> 3;
    addr &= ~3u;
    return MMIO32(addr);
}

void mac_clk_div165(u32 a, u32 out)
{
    /* 0x936b94: out[0] = a % 165, out[1] = a / 165 (по байту). */
    u32 n = 0;
    while (a >= 0xa5) {
        n++;
        a -= 0xa5;
    }
    u8 *o = (u8 *)out;                  /* пара {остаток, частное} (struct ifs_timing) */
    o[1] = (u8)n;
    o[0] = (u8)a;
}

void mac_core_write_3e_then_3d_0007(void)
{
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x3e000000;
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x3d000007;
}

u32 mac_read_usec_to_tbtt_uc(u32 a)
{
    if (a != 0) {
        while (!(MMIO32(HW_MAC_TIMING_STATUS) & 0x80000000u))
            ;
    }
    return MMIO32(HW_MAC_USEC_TO_TBTT) & 0x3ffffff; /* bmsk 0x19 — 26 бит */
}

u32 macq_hw_read_wptr(u32 q)
{
    u32 raw = ((q * 7) << 7) + 0x44098c0;
    return (u16)(MMIO32((raw >> 3) & ~3u) >> (raw & 0x1f));
}

u32 macq_hw_read_rptr(u32 q)
{
    u32 raw = ((q * 7) << 7) + 0x4409880;
    return (u16)(MMIO32((raw >> 3) & ~3u) >> (raw & 0x1f));   /* lsr по биту, extw */
}

void macq_hw_clear_2d8(u32 q)
{
    u32 addr = (((q * 7) << 7) + 0x44096c0) >> 3;
    MMIO32(addr & ~3u) = 0;
    arc_sync();
}

u32 macq_hw_read_state0(u32 q)
{
    u32 raw = (q * 7) << 7;
    u32 addr = (raw + 0x4409800) >> 3;
    u32 shift = (raw + 0x4409800) & 0x1f;
    return (MMIO32(addr) >> shift) & 0xf;
}

u32 macq_hw_read_state1(u32 q)
{
    u32 raw = (q * 7) << 7;
    u32 addr = (raw + 0x4409820) >> 3;
    u32 shift = (raw + 0x4409820) & 0x1f;
    return (MMIO32(addr) >> shift) & 0xf;
}


void mac_cmd_0f_step(struct pm_ctx_s *p)
{
    /* 0x92e438 */
    aw_set_new_tbtt(p);
    p->ps_active = 0;                           /* st.as 0,[r13,80] */
}

void mac_cmd_29000001(void)
{
    uc_mac_cmd(0x29000001);   /* mailbox uc->fw */
    arc_nops(3);
}

void mac_set_slot_timing_886f60(void)
{
    uc_mac_cmd(0x4a000018);   /* mailbox */
    MMIO32(HW_MAC_SLOT_TIMING) = 0x3780378;
}

void mac_program_13ab6680_b(void)
{
    /* 0x93c904 */
    uc_timer_start(1, 0, 0x13ab6680, 0);
    uc_timer_start(0, 0, 1650, 0);
}
u32 mac_program_deadline_slack(u32 a, u32 b, u32 c)
{
    /* 0x934de4 */
    u32 r3 = 0;
    if (c != 0) {
        a = a - b - 1;
        r3 = 0xa5 - c;
    } else {
        a = (b == 0) ? 0 : a - b;
    }
    MMIO32(HW_MAC_BI_RELOAD_CLK) = r3;
    MMIO32(HW_MAC_BI_RELOAD_US) = a;
    return a;
}

void mac_select_rf_module_cmd31(u32 a, u32 b)
{
    mac_cmd31_mode = (u8)a;
    u32 cmd = 0x31000000u | (a << 4) | (b << 9);
    uc_mac_cmd(cmd);
}

void mac_load_tx_key(const u32 *key)     /* ключ 16 Б (sta_entry.tx_key) */
{
    MMIO32(HW_TX_KEY_0) = key[0];
    MMIO32(HW_TX_KEY_1) = key[1];
    MMIO32(HW_TX_KEY_2) = key[2];
    MMIO32(HW_TX_KEY_3) = key[3];
}
u32 mac_replicate_bit_mask(const struct lmac_mac_regs *a)
{
    /* 0x92f400: бит 1 qset_mode размножен в биты 1,2,5,6,9,10,13,14. */
    u32 b = (a->qset_mode >> 1) & 1;
    return b * 0x6666;
}
void mac_cmd_56_57(void)
{
    /* 0x9368ac */
    uc_mac_cmd((rf_chain_cfg & 0xf) | 0x563f0020u);   /* ld_s [gp,-12] — байты */
    uc_mac_cmd(0x57000002);
}
void mac_set_880afc_bits(u32 a)
{
    /* 0x928dcc */
    if (a != 0)
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) = (MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) & 0x43ffffffu) | (0xbcu << 24);
    else
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_2) &= 0x43ffffffu;
}

void macq_hw_set_ctrl_bit(u32 q)
{
    u32 raw = ((q * 7) << 7) + 0x44099c3;
    u32 addr = (raw >> 3) & ~3u;
    u32 mask = 1u << (raw & 0x1f);
    u32 val = MMIO32(addr);
    MMIO32(addr) = (val & ~mask) | mask;
}
/* СРОК: при wait ≠ 0 — ожидание 0x886eb4.31 (готовность снимка начала BI) без ограничения
 * (аппаратный); vendor 0x9374e8 так же. Срыв — зависание uc. */
void mac_read_bi_start_tsf64_uc(u32 a, u32 *out, u32 wait)
{
    /* 0x9374e8: ждать готовности (0x886eb4 bit31), затем 64-бит 0x886fc4/0x886fc8
     * с перечитыванием младшего слова до совпадения. */
    (void)a;
    if (wait != 0) {
        while (!(MMIO32(HW_MAC_TIMING_STATUS) & 0x80000000u))
            ;
    }
    for (;;) {
        u32 lo = MMIO32(HW_MAC_BI_START_TSF_LO);
        out[0] = lo;
        out[1] = MMIO32(HW_MAC_BI_START_TSF_HI);
        if (MMIO32(HW_MAC_BI_START_TSF_LO) == lo)
            return;
    }
}

void mac_rx_off_seq(void)
{
    mac_cmd_29000001();
    mac_evt_enable_bit_sync_b(0);
    uc_mac_cmd(0x3d000004);
    uc_mac_cmd(0x29000002);
}

void mac_set_slot_mask_924000(void)
{
    mac_chain_mask = 0x924000;
    uc_mac_cmd(0x8924000);
    mac_rf_switch_cmd1f(1);
    uc_mac_cmd(0x81u << 18);
}

void mac_set_chain_mask_924f00(void)
{
    mac_chain_mask = 0x924f00;
    u32 r0 = (rx_nav.ev_mask & 0x924f00) | (1u << 27);
    uc_mac_cmd(r0);
    uc_mac_cmd(0x81u << 18);
    mac_rf_switch_cmd1f(1);
}

/* СРОК: 0x27007e00 → 0x02004002 → 3 nop → ждать r42 (slot_event | busy2_event) без тайм-аута; MAC
 * должен применить маску до первого опроса (аппаратный, ~3 такта): между mov r32 и опросом 5
 * инструкций + переход в uc_wait_event_busy (vendor 0x936870 так же); запас — единицы инструкций.
 * После выхода по slot_event вызывающий (tx.c, tail.c) запускает TX в слоте; задержка реакции опроса
 * 3 инструкции. Срыв: устаревший бит — преждевременный выход; молчание MAC — зависание. */
void mac_select_all_sectors_and_wait(void)
{
    u32 r1 = mac_evt_en_shadow | 0x27007e00u;
    uc_mac_cmd(r1);
    uc_mac_cmd(0x2004002);
    arc_nops(3);
    uc_wait_event_busy(MAC_EVT1_SLOT | MAC_EVT1_BUSY2, 0);
}

void mac_program_4f_52(u32 a, u32 b)
{
    uc_mac_cmd(a | 0x4f000000u);
    uc_mac_cmd((b << 8) | 0x52000008u);
}

void macq_hw_sync_dma_wptr(u32 a, u32 q, u32 dma)
{
    (void)dma;   /* 3-й аргумент (r2) перезаписывается в asm, не используется */
    u32 raw = ((q * 7) << 7) + 0x44098c0;
    u32 wptr = (u16)(MMIO32((raw >> 3) & ~3u) >> (raw & 0x1f));   /* extw */
    u32 dma_addr = (((a << 8) + 0x440c140) >> 3) & ~3u;
    MMIO32(dma_addr) = wptr;
    MMIO32(dma_addr) = wptr | (1u << 31);
}


/* СРОК: 0x27 (разрешение события) → 0x02004000 → 3 nop → ждать MAC_EVT1_BUSY2 (busy2_event — подтверждение)
 * без ограничения; MAC должен обновить MAC_EVT1_BUSY2 до первого опроса (аппаратный, ~3 такта): между mov r32
 * и опросом 5 инструкций + переход (vendor 0x9361bc/0x936544 так же); запас — единицы инструкций.
 * Срыв: устаревший бит 14 — выход до применения маски; молчание MAC — зависание. То же в _b. */
void mac_evt_enable_bit_sync(u32 a)
{
    u32 mask = (1u << a) << 8;
    u32 r1 = mac_evt_en_shadow | (mask | 0x27000000u);
    uc_mac_cmd(r1);
    uc_mac_cmd(0x2004000);
    arc_nops(3);
    uc_spin_until_event(MAC_EVT1_BUSY2);
}

/* 0x936544 */
void mac_evt_enable_bit_sync_b(u32 a)
{
    uc_mac_cmd(mac_evt_en_shadow | ((1u << a) << 8) | 0x27000000);   /* ld.as [gp,-18] */
    uc_mac_cmd(0x2004000);
    arc_nops(3);
    uc_spin_until_event(MAC_EVT1_BUSY2);
}

void mac_program_tx_common(void)
{
    /* 0x92d990 */
    uc_mac_cmd(0x1b001111);
    uc_mac_cmd(0x161f0040);
    uc_mac_cmd(0x17000003);
    arc_nops(3);
}

void mac_program_tx_beacon(void)
{
    /* 0x92d8a4 */
    uc_mac_cmd(0x1b001111);
    uc_mac_cmd(0x161e0001);
    uc_mac_cmd(0x17000003);
    arc_nops(3);
}
void mac_set_880bf0_mode(u32 mode)
{
    /* 0x928d78: режимы 0,1,2,4; иначе assert и всё равно запись. */
    if (!(mode == 0 || mode == 1 || mode == 2 || mode == 4))
        uc_assert((u32)__builtin_return_address(0), 0x12d7);
    MMIO32(HW_PWR_MODE_MAP_BF0) = (MMIO32(HW_PWR_MODE_MAP_BF0) & ~0xffu) | (u8)(mode | (mode << 4));
}
void mac_program_tx_with_rate(u32 rate)
{
    /* 0x92d8e8 */
    uc_mac_cmd(0x1b001111);
    uc_mac_cmd(0x161f0040);
    uc_mac_cmd(((rate << 8) | 3) | 0x17000000);
    arc_nops(3);
}
void mac_program_tx_with_qid(u32 qid)
{
    /* 0x92d93c */
    uc_mac_cmd(0x1b001111);
    uc_mac_cmd(((qid << 16) | 1) | 0x16000000);
    uc_mac_cmd(0x17000003);
    arc_nops(3);
}

/* СРОК: при r40[2:0] = 5 MAC должен подтвердить смену режима (MAC_EVT1_BUSY2) за тайм-аут 0xa GP-таймера
 * (uc_wait_two_events → uc_wait_event_busy, 0x23010000|0xa) — иначе assert 0x3f (аппаратный).
 * Паузы выборки r40 (5 инструкций) и после ожидания (3 nop) — как vendor 0x93e0dc; запас не оценён. */
void mac_set_mode_0000(void)
{
    /* 0x93e0dc: при состоянии r40&7 == 5 дождаться событий и проверить r42 bit14. */
    u32 r0 = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = r0;
    uc_mac_cmd(r0 | 0x1d000000);
    arc_nops(3);
    if ((mac_status_sel() & MAC_BIFS_IDLE_DETECT) != 5)
        return;
    uc_wait_two_events(5, 5, 0xa);
    arc_nops(3);
    if (!(mac_evt1() & MAC_EVT1_BUSY2))
        uc_assert((u32)__builtin_return_address(0), 0x3f);
}
/* СРОК: 0x49000040 квитирует MAC_EVT4_GP0_END (gp0_end_ind), и уже через ~8 инструкций (вызов
 * uc_wait_event1_or_event4) MAC_EVT4_GP0_END опрашивается снова — без паузы, как vendor 0x93e084; запас —
 * единицы инструкций (аппаратная задержка квитирования не измерена). Срыв: устаревший MAC_EVT4_GP0_END —
 * ложный возврат 0 (тайм-аут вместо busy2). */
u32 mac_arm_events_0xc00(void)
{
    /* 0x93e084: 1 — событие r42 bit14, 0 — r54 bit6. */
    uc_mac_cmd(mac_evt_en_shadow | 0x27000c00);
    uc_mac_cmd(0x2004000);
    uc_mac_cmd(0x49000040);
    for (;;) {
        uc_wait_event1_or_event4(MAC_EVT1_BUSY2, MAC_EVT4_GP0_END, 0);
        if (mac_evt1() & MAC_EVT1_BUSY2)
            return 1;
        if (mac_evt4() & MAC_EVT4_GP0_END)
            return 0;
    }
}

void mac_ifs_restore_sifs(void)
{
    u16 r0 = ifs.sifs;
    if (mac_ifs_shadow != r0) {
        mac_ifs_shadow = r0;
        *(volatile u32 *)HW_MAC_IFS_SIFS = r0 | 0x1730000;
        arc_sync();
        uc_mac_cmd(0x38000200);
    }
    uc_mac_cmd(0x3d000400);
}
u32 macq_hw_trigger_read_state(u32 q)
{
    /* 0x928fcc */
    u32 base = q * 0x380;
    MMIO32((base + 0x44097a0) >> 3) = 1u << ((base + 0x44097bf) & 0x1f);
    arc_sync();
    return MMIO32(((base + 0x44097a0) >> 3) & ~3u) & 7;
}

void macq_hw_commit_rptr(u32 q)
{
    /* 0x92a640: прочитать 16-бит rptr очереди q и записать его на 0x60 бит (0xc Б) дальше — DESCQ+0x44 (затем с bit31). */
    u32 raw = ((q * 7) << 7) + 0x4409880;
    u32 rptr = (u16)(MMIO32((raw >> 3) & ~3u) >> (raw & 0x1f));
    u32 addr = (((q * 7) << 7) + 0x44098e0) >> 3;
    MMIO32(addr) = rptr;
    arc_sync();
    MMIO32(addr) = rptr | (1u << 31);
    arc_sync();
}

u32 mac_build_qset_mask(const struct lmac_mac_regs *a)
{
    u32 r2 = a->qset_mode;
    u32 r0 = r2 & 1;                         /* bit0 */
    u32 r1 = (r2 & (1u << 3)) ? 1 : r0;      /* bit3 ? 1 : bit0 */
    r2 = (r2 >> 2) & 1;                      /* bit2 */
    u32 m = (r1 << 1) | r2;
    m = (r1 << 2) | m;
    m = m | (r2 << 4);
    m = (r1 << 5) | m;
    m = m | (r1 << 6);
    m = (r0 << 9) | m;
    m = (r0 << 10) | m;
    m = (r0 << 13) | m;
    m = (r0 << 14) | m;
    m = (r0 << 17) | m;
    m = (r0 << 18) | m;
    m = (r0 << 21) | m;
    m = (r0 << 22) | m;
    mac_cmd35_mask = m;   /* st.as [gp,0xb] */
    return m;
}
void macq_hw_disable_queue(u32 q)
{
    /* 0x9292a8: сбросить бит очереди в двух регистрах (адрес/бит из битового смещения). */
    u32 raw = q * 0x380 + 0x44099c0;
    MMIO32((raw >> 3) & ~3u) &= ~(1u << (raw & 0x1f));
    arc_sync();
    raw = q * 0x380 + 0x44096c4;
    MMIO32((raw >> 3) & ~3u) &= ~(1u << (raw & 0x1f));
    arc_sync();
}
/* СРОК: запрос MTP 0x1b/0x16/0x17 → 3 инструкции (2×nop + mov 0,0, vendor 0x92dafc) → ждать MAC_MTP_PERM_VALID
 * без ограничения (аппаратный: до обработки запроса r45 держит прошлый ответ с valid = 1). Запас —
 * единицы инструкций. Срыв: «пустота» очереди по прошлому запросу или зависание uc. */
u32 macq_probe_empty(u32 q)
{
    /* 0x92dab8: MAC_MTP_PERM_Q_EMPTY = 1 — очередь пуста (vendor mtp_queue__release_mgmt пишет
     * «MTP Queue is empty»), возврат !MAC_MTP_PERM_Q_EMPTY = 1 — очередь НЕ пуста. */
    uc_mac_cmd(0x1b001111);
    uc_mac_cmd(((q << 16) | 1) | 0x16000000);
    uc_mac_cmd(0x17000000);
    arc_nops_nop(2);   /* vendor L_92dafc: 2×nop + mov 0,0 */
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    return MAC_MTP_PERM_Q_EMPTY_OF(mac_mtp_perm()) ^ 1;
}
void mac_qset_reset_masks(void)
{
    /* 0x92ea48 */
    MMIO32(HW_QSET0_MASK_VECTOR) = ~0u;
    for (u32 i = 0; i < 6; i++)
        MMIO32(HW_QSET1_MASK_VECTOR + i * 4) = 0;
    uc_mac_cmd(0x10f000f0);
    qset_enable_mask = 0x70;
    u32 g = mac_sel_shadow & 0xfffff0ff;
    mac_sel_shadow = g;
    uc_mac_cmd(g | 0x1d000000);
    arc_nops(3);
    uc_mac_cmd(0x1a000002);
}


void mac_mode_send_direct_frame(u32 a)
{
    (void)a;
    tx_fifo_write_bytes((u32)&brp_frame, 0xa);
    tx_fifo_free -= 6;
    uc_mac_cmd(0x33000443);
    uc_wait_direct_tx_ready();
    tx_fifo_free -= 6;
    uc_mac_cmd(0x33000123);
    uc_wait_direct_tx_ready();
    arc_core_wr(34, brp_frame.seq_ctrl | (1u << 24));   /* ldw_s — полуслово */
    tx_fifo_free -= 2;
    tx_fifo_write_bytes((u32)&brp_frame.category, 0xe);
    direct_tx_issue_cmd_33();
}

/* СРОК: RX-сектор/AWV пира (0x3a/0x3b/слово с б30) должен встать до приёма ответа Ack/BA/CTS через
 * SIFS = 3 мкс (802.11-2020 10.3.2.3.3, Table 20-30) после конца своей передачи (MAC_EVT1_TX_END в
 * tx_send_and_await_rx_frame, brp.c). Путь: выход из uc_spin_until_event ~3 + вызов + 7 команд ≈
 * 30 инструкций (vendor 0x92f42c ≈ 38 с millicode-прологом); запас по коду — сотни тактов из 495,
 * время исполнения 0x3b/0x40 в RFC не известно. Срыв: ответ принимается прежним сектором — потеря
 * Ack/CTS, повтор. */
void mac_set_rf_chain_state(u32 a, u32 b)
{
    uc_mac_cmd(0x1f003000);
    uc_mac_cmd(0x3c000300);
    uc_mac_cmd(0x3a00000f);
    uc_mac_cmd((a << 4) | (1u << 9) | (1u << 25) | (1u << 26));
    uc_mac_cmd(0x3b000001);
    uc_mac_cmd(0x3b000006);
    uc_mac_cmd(b | (1u << 30));
    rf_cur_sector_word = b;
}

/* 0x929568 */
void mac_set_cid_mcs_uc(u32 a, u32 b)
{
    volatile u16 *h = (volatile u16 *)&mcs_tab_886c70[a];
    if (*h & 0xffff0000u)                       /* ldh беззнаковый: никогда (как у vendor) */
        uc_assert((u32)__builtin_return_address(0), 0xac);
    MMIO32(HW_MAC_TX_MCS_PARAM16) = (MMIO32(HW_MAC_TX_MCS_PARAM16) & 0xffff0000u) | *h;
    MMIO32(HW_MAC_TX_MCS_PARAM8) = mcs_tab_886c74[a];
    *(volatile u32 *)((((b << 5) + 0x4435800u) >> 3) & ~3u) = a;
}
void mac_fill_mode_nibbles(u32 mode)
{
    /* 0x9294d8: режим во все 8 полубайтов; запись в 0x8860fc, 0x886100..0x886110. */
    if (!(mode == 0 || mode == 1 || mode == 2 || mode == 4))
        uc_assert((u32)__builtin_return_address(0), 0x12db);
    u32 v = mode | mode << 4 | mode << 8 | mode << 12 | mode << 16 | mode << 20 | mode << 24 | mode << 28;
    MMIO32(HW_MAC_MODE_MAP_0) = v;
    MMIO32(HW_MAC_MODE_MAP_1) = v;
    MMIO32(HW_MAC_MODE_MAP_2) = v & 0xfffff;
    MMIO32(HW_MAC_MODE_MAP_3) = v;
    MMIO32(HW_MAC_MODE_MAP_4) = v;
    MMIO32(HW_MAC_MODE_MAP_5) = v & 0xffffff;
}

void mac_program_qset_slots(void)
{
    if (qset_slots_en == 0)
        return;
    for (u32 i = 0; i < 4; i++) {
        u8 b = qset_slot[i].init;
        uc_mac_cmd(((1u << (b & 0x1f)) - 1) | ((i + 9) << 24));
    }
    uc_mac_cmd((mac_chain_mask & rx_nav.ev_mask) | 0x80000aa);
}

/* СРОК: переход RX→TX после принятого PPDU (ждать MAC_PHYSIG_CCA_PPDU_COMP и снятия MAC_PHYSIG_PHY_RX_FRAME,
 * 0x3d000004, снимок r49, 0x02093800) на пути ответа: SSW-Feedback/SSW-Ack через MBIFS
 * (mac_mode_switch_core_and_rf, 10.3.2.3.10, 10.42.2.4/10.42.2.5: 9 мкс −0/+0,49); также
 * rx_switch_to_rx_mode. Быстрая ветка ~80 инструкций без ожиданий (vendor 0x92a754 ~80, тот же
 * порядок и nop); запас по коду — сотни тактов, остальное съедает ожидание конца приёма в железе.
 * Срыв: ответ позже MBIFS — партнёр не принимает SSW-FB/SSW-Ack, повтор. */
UC_HOT
u32 mac_set_mode_a000(u32 a)
{
    /* 6.2 asm 0x92a754. Возврат 1 — переход из состояния r49[19:16] < 6, иначе 0. */
    (void)a;
#define NOP3() arc_nops(3)
#define NOP2M() arc_nops_nop(2)
    u32 g;
    mac_a000_waited = 0;
    g = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = g | 0xa000;
    uc_mac_cmd(g | 0x1d00a000);
    NOP3();
    if (MAC_EE2_PHY_STATE_OF(mac_evt_eng2()) < 6) {
        VOL(uc_wait_marker) = 0xff2f;   /* метка ожидания: gcc выкидывал запись как мёртвую */
        while (!(mac_status_sel() & MAC_PHYSIG_CCA_PPDU_COMP))
            ;
        VOL(uc_wait_marker) = 0;
        arc_nops_mb(1);   /* vendor L_92a7c2: 1×nop */
        u32 r13 = mac_status_sel();
        while (mac_status_sel() & MAC_PHYSIG_PHY_RX_FRAME)
            ;
        arc_nop_mb();   /* vendor L_92a7d0: пустой слот */
        uc_mac_cmd(0x3d000004);
        NOP3();
        r49_snap = mac_evt_eng2();
        if (mac_status_sel() & MAC_PHYSIG_PHY_RX_FRAME)
            uc_assert((u32)__builtin_return_address(0), 147);
        if (!(mac_status_sel() & MAC_PHYSIG_CCA_PPDU_COMP))
            uc_assert((u32)__builtin_return_address(0), 148);
        uc_mac_cmd(0x2093800);
        mac_a000_fast = 1;
        g = mac_sel_shadow & 0xffff0fff;
        mac_sel_shadow = g | 0xa000;
        uc_mac_cmd(g | 0x1d00a000);
        NOP2M();   /* vendor L_92a84c: 2×nop + mov 0,0 */
        ppdu_evt_cnt = MAC_PHYSIG_PPDU_EVT_CNT_OF(mac_status_sel());
        if (r13 & MAC_PHYSIG_PHY_RX_FRAME)
            mac_a000_fast_cnt += 1;
        return 1;
    }
    mac_a000_waited = 1;
    for (;;) {
        u32 r2 = MAC_EE2_PHY_STATE_OF(mac_evt_eng2());
        if (r2 < 6 || r2 >= 0xe)
            break;
    }
    VOL(uc_wait_marker) = 0xff30;   /* метка ожидания: gcc выкидывал запись как мёртвую */
    while (!(mac_status_sel() & MAC_PHYSIG_CCA_PPDU_COMP))
        ;
    VOL(uc_wait_marker) = 0;
    arc_nops_mb(1);   /* vendor L_92a8c2: 1×nop */
    while (mac_status_sel() & MAC_PHYSIG_PHY_RX_FRAME)
        ;
    NOP2M();   /* vendor L_92a8cc: 2×nop + mov 0,0 */
    uc_mac_cmd(0x3d000004);
    NOP2M();   /* vendor L_92a8e8: 2×nop + mov 0,0 */
    if (!(mac_status_sel() & MAC_PHYSIG_CCA_PPDU_COMP) || (mac_status_sel() & MAC_PHYSIG_PHY_RX_FRAME))   /* bbit0 24 → assert; bbit0 3 → мимо */
        uc_assert((u32)__builtin_return_address(0), 141);
    uc_mac_cmd(0x2093800);
    mac_a000_fast = 0;
    g = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = g | 0xa000;
    uc_mac_cmd(g | 0x1d00a000);
    NOP3();
    ppdu_evt_cnt = MAC_PHYSIG_PPDU_EVT_CNT_OF(mac_status_sel());
    mac_a000_slow_cnt += 1;
    return 0;
#undef NOP3
#undef NOP2M
}

/* СРОК: RX→TX для SSW-Feedback/SSW-Ack через MBIFS = 9 мкс −0/+0,49 (802.11-2020 10.3.2.3.10,
 * 10.42.2.4, 10.42.2.5) после последнего SSW (MAC_RX_MISC_ZERO_CDOWN CDOWN = 0; txss.c, tail.c). Путь:
 * mac_set_mode_a000 (~80) + mac_rf_switch_cmd1f (ожидание idle_detect = 5 без ограничения) + 7 команд
 * (~28); vendor 0x92e0e4 — тот же состав; запас по коду — около тысячи тактов из 1485, ожидания
 * железа не ограничены. Срыв: SSW-FB/SSW-Ack позже MBIFS — SLS не завершается, повтор. */
void mac_mode_switch_core_and_rf(u32 a)
{
    mac_set_mode_a000(a);
    mac_rf_switch_cmd1f(0);
    uc_mac_cmd(0x1f006000);
    uc_mac_cmd(0x38000300);
    uc_mac_cmd(0x3600003f);
    uc_mac_cmd(0x6000101);
    uc_mac_cmd(0x37000005);
    uc_mac_cmd(0x37000002);
    uc_mac_cmd(a | 0x3f000000);
}
void mac_set_chain_modes(u32 a)
{
    /* 0x9369e0: четыре отдельных чтения r40 (полубайты 16/20/24/28). */
    u32 r0 = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = r0;
    uc_mac_cmd(r0 | 0x1d000000);
    arc_nops(3);
    u32 c0 = MAC_BIFS_REM_SLOT_AC1_OF(mac_status_sel()) <= 2;
    u32 c1 = MAC_BIFS_REM_SLOT_AC2_OF(mac_status_sel()) <= 2;
    u32 c2 = MAC_BIFS_REM_SLOT_AC3_OF(mac_status_sel()) <= 2;
    u32 c3 = MAC_BIFS_REM_SLOT_AC4_OF(mac_status_sel()) <= 2;
    u32 mask = (c0 ? a : 0) | (1u << 27);
    mask |= (c1 ? a : 0) << 2;
    mask |= (c2 ? a : 0) << 4;
    mask |= (c3 ? a : 0) << 6;
    uc_mac_cmd((mac_chain_mask & rx_nav.ev_mask) | mask);
}

void mac_mode_enter_idle_seq(u32 a)
{
    mac_set_mode_a000(a);
    if (pm_idle_flags & 1u) {
        uc_mac_cmd(0x83u << 25);
        arc_nops(3);
        rfc_issue_cmd_10(rf_chain_cfg);
    }
    uc_mac_cmd(0x3d000001);
    arc_nops(3);
    uc_mac_cmd(0x3d000002);
    arc_nops(3);
    if (a != 0) {
        if (uc_role_ap == 0 && maint_sta_mask == 0) {
            uc_mac_cmd(1u << 24);
            uc_mac_cmd(0x20c0010);
        } else {
            uc_mac_cmd(0x10 | (1u << 24));
            uc_mac_cmd(0x83u << 18);
            MMIO32(HW_MAC_TSF_EVENT_CTRL) = 0;
        }
    }
}

/* СРОК: выход по r42 (обычно б15 tx_end_event) — дальше на пути ответа через SIFS переключение на RX
 * (mac_set_rf_chain_state). Опрос 3 инструкции на проход (vendor 0x9366dc: 3), без ограничения;
 * задержка реакции — единицы тактов. Срыв: зависание при молчании MAC. */
u32 uc_spin_until_event(u32 mask)
{
    u32 v;
    do {
        v = mac_evt1();                    /* 0x9366dc: tst r42,r0 */
    } while (!(v & mask));
    return mask;                                /* r0 не меняется */
}
