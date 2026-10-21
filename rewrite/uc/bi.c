// SPDX-License-Identifier: AGPL-3.0-or-later
/* BI-mode (Beacon Interval) uCode. */
#include "../include/types.h"
#include "../include/bitfield.h"
#include "../include/hw.h"
#include "../include/arc.h"


/* Уже портированы в boot.c / stubs.c / mac.c — не переопределять. */

/* ---- Локальные stub-ы глубоких подфункций ---- */
u32 bi_state_from_g800600(void)
{
    u8 r0 = bi_sm.state;
    if (r0 == 0) return 0;
    if (r0 == 2) return 1;
    if (r0 == 3) return 2;
    uc_assert((u32)__builtin_return_address(0), 0x5f);
    return 0;
}
void pm_wake_sequence(void)
{
    internal_tx_clear_pending_bit(0);
    uc_mac_cmd(0x49008000);
    mac_ddc_mask_bit3();
    pm_event_mask_restore();
}
void gp_timer_stop(u32 a)
{
    uc_mac_cmd((a + 0x52) << 24);
    uc_mac_cmd((0x49u << 24) | (1u << (a + 6)));
}
void field_set_0x00_934998(u32 a)
{
    *(u32 *)a = 0;
}

/* ---- bits_set_u8_*: поле байта (include/bitfield.h). ---- */
void bits_set_u8_s0_w5_uc(u32 ptr, u32 value) { bf_set8(ptr, 0, 5, value); }
void bits_set_u8_s0_w6_uc(u32 ptr, u32 value) { bf_set8(ptr, 0, 6, value); }
void bits_set_u8_s0_w7_uc(u32 ptr, u32 value) { bf_set8(ptr, 0, 7, value); }
void bits_set_u8_s3_w5_uc(u32 ptr, u32 value) { bf_set8(ptr, 3, 5, value); }
void bits_set_u8_s6_w2_uc(u32 ptr, u32 value) { bf_set8(ptr, 6, 2, value); }
/* 0x9263c8 — не функция: хвост цикла aw__walk_peer_bits_noop (переход на 0x9263ba). */

/* ---- Простые accessors ---- */
u32 bit_iter_has_more_uc(u32 a) { return (*(u32 *)a != 0) ? 1 : 0; }

void bi_mode_set_1000_units165(struct aw_win_s *w) { w->qset_val = 0x28488; }

void bi_init_set_mac_arg_pair(u32 a, u32 b)
{
    MMIO32(HW_MAC_BI_INIT_ARG1) = b;
    MMIO32(HW_MAC_BI_INIT_ARG0) = a;
}

void bi_ctx_clear_state_words(void) { memset0_words_uc(&bcn_rx.bcn_sent, 2); }   /* bcn_sent, abft_go */

void bi_ctx_clear_word0(u32 a) { field_set_0x00_934998(a); }

/* no-store-merging: x2/next_beacon — два stb, как у vendor (иначе gcc сливает в stw [r0,2]). */
__attribute__((optimize("no-store-merging")))
void bi_cfg_fill_slot_desc(u32 a, u32 b)
{
    /* 0x92af98 */
    struct bcn_bi_state *d = (struct bcn_bi_state *)a;           /* bcn_bi */
    const struct fui_bi_cfg_params *c = (const void *)b;         /* bi_cfg */
    d->abft_bi_left = c->n_bi_abft - 1;
    d->x2 = 1;
    d->next_beacon = 0;
    u8 n = c->x8;
    d->x5_cdown = n ? (u8)(n - 1) : 0xf;
    d->abft_idx = 0;
}

void bi_cfg_pack_words_thunk(u32 a) { bi_cfg_pack_words_78_7c(a, 0); /* 6.2 asm 0x938000 → 0x938004 */ }

u64 bi_tsf_delta64(u32 a, u32 b)
{
    u32 tsf[2];
    mac_read_tsf64_uc(tsf);
    u64 now = ((u64)tsf[1] << 32) | tsf[0];
    u64 ref = ((u64)b << 32) | a;
    return now - ref;
}

void bi_ctx_set_active(struct bi_ctx_s *c)
{
    /* 0x92ad00 */
    c->phase = 1;
    bti_reset_sweep_state(c);
    bi_ctx_clear_state_words();                 /* vendor передаёт a+8, функция его не использует */
    bi_mode_set_1000_units165(&c->aw);
    bi_ctx_clear_word0((u32)&c->dti_wake);
}

/* ---- State-machine действия ---- */
void bi_sm_init(void) { obj_vt801adc_ctor(&bi_sm); /* 6.2 asm 0x92acf8 → 0x92aeb4 */ }

void bi_sm_action_92646c(u32 a) { (void)a; uc_assert((u32)__builtin_return_address(0), 0x1033); }

void bi_dispatch_by_role(struct bi_ctx_s *c)
{
    u32 role = c->phase;
    if (role == 0)
        uc_assert((u32)__builtin_return_address(0), 0x67);
    else if (role == 1)
        bi_manager_start_tx_or_initiator();
    else if (role == 2)
        bi_rx_slot_handler(&c->aw);
    else
        uc_assert((u32)__builtin_return_address(0), 0x68);
}

void bi_manager_start_tx_or_initiator(void)
{
    /* vendor: при своём расписании PS (psc.state ≠ 0) — особый путь; PS вырезан */
    fixed_sched_run_tx_slot();
}

void bi_after_enter_aw(struct bi_ctx_s *c)
{
    u32 st = bi_state_from_g800600();
    c->phase = st;
    if (st != 2)
        uc_assert((u32)__builtin_return_address(0), 0x64);
    aw_start_window(&c->aw, uc_read_tsf_lo());
}

void bi_after_enter_dti(struct bi_ctx_s *c)
{
    u32 st = bi_state_from_g800600();
    c->phase = st;
    if (st != 1)
        uc_assert((u32)__builtin_return_address(0), 0x62);
    (void)uc_read_tsf_lo();                     /* vendor bl L_9364c8: MAC-команда 0x4d000005 */
    bi_dti_step();
}

/* bi__remaining_time_us (6.2 asm 0x92dc44): остаток NAV, max(·, 0) и знаковый min с max_us —
 * как у vendor (max/min); стоит на пути ответа (rx_send_response_frame). */
u32 bi_remaining_time_us(void)
{
    if (!(rx_nav.flags & 1u))
        return 0;
    u32 tsf = uc_read_tsf_lo();
    s32 d = (s32)(rx_nav.end_tsf - tsf);
    if (d < 0)
        d = 0;
    u32 r0 = rx_nav.max_us;
    return (d < (s32)r0) ? (u32)d : r0;
}

void bi_dti_step(void)
{
    pm_wake_sequence();
    if (dti_qset_mode == 0) {
        uc_mac_cmd(0x5a000000);
    } else {
        sxd_hal_write_qset_field(0, 0);
    }
}

void bi_manager_step_b(struct sls_peer_rec *r)
{
    /* 0x922258 */
    (void)r;
    memset0_words_uc(&bcn_rx.bcn_sent, 2);      /* bcn_sent, abft_go */
    gp_timer_stop(0);
    gp_timer_stop(1);
    gp_timer_stop(2);
    uc_mac_cmd(0x54000000);
    uc_mac_cmd(0x54000000);
    uc_mac_cmd(0x49000100);
    uc_mac_cmd(0x51000284);
    uc_mac_cmd(0x54000508);
}

/* ---- BI state-machine действия (bi_sm_action_*) ---- */
void bi_sm_action_92150c(u32 obj)
{
    uc_mac_cmd(0xcaf662);
    (void)obj;
    bi_win.evt_in_aw += 1;
    bi_aw_flag = 1;                       /* st.as 1,[gp,-52]: ×4 = 0x800458 */
}

void bi_sm_action_92153c(u32 obj)
{
    uc_mac_cmd(0xcaf661);
    (void)obj;
    bi_win.evt_in_aw += 1;
    bi_aw_flag = 1;                       /* st.as 1,[gp,-52]: ×4 = 0x800458 */
}

void bi_sm_action_92156c(void)
{
    uc_mac_cmd(0xcaf660);
    uc_mac_cmd(0x2000010);
    bi_win.dti_to_bti_in_aw += 1;
    bi_win.evt_in_aw += 1;
    bi_aw_flag = 1;
}

void bi_sm_action_923a5c(void)
{
    uc_mac_cmd(0xcaf440);
    bi_win.aw_to_dti_in_bti += 1;
}

void bi_sm_action_9262e8(void)
{
    uc_mac_cmd(0xcaf550);
    bi_win.evt_in_dti += 1;
}

void bi_sm_action_935a08(u32 obj)
{
    u8 state = *(u8 *)obj;
    uc_mac_cmd((state & 0xf) | 0xcaf000);
    bi_win.state = state;
    bi_win.bti_to_abft += 1;
}

void bi_sm_action_935a94(u32 obj)
{
    u8 state = *(u8 *)obj;
    uc_mac_cmd((state & 0xf) | 0xcaf220);
    bi_win.state = state;
    bi_win.bhi_to_aw += 1;
    bi_aw_flag = 0;
    bi_after_enter_aw(&bi_ctx);                 /* 6.2: 0x92b798 */
}

void bi_sm_action_935b4c(u32 obj, u32 a)
{
    u8 state = *(u8 *)obj;
    uc_mac_cmd((state & 0xf) | 0xcaf000);
    bi_win.state = state;
    bi_win.dti_to_bti += 1;
    bti_dispatch_sweep_step(&bi_ctx, a);        /* 6.2: 0x92b7dc */
}

void bi_sm_action_935d0c(u32 obj)
{
    u8 state = *(u8 *)obj;
    uc_mac_cmd((state & 0xf) | 0xcaf110);
    bi_win.state = state;
    bi_win.to_dti += 1;
    mac_mon_armed = 1;
    bi_after_enter_dti(&bi_ctx);                /* 6.2: 0x92b85c */
}

void bi_cfg_tick_counters(void)
{
    if (bcn_bi.abft_bi_left == 0) {
        u8 prev = bi_cfg.n_bi_abft;
        u8 n = bcn_bi.abft_idx + 1;
        bcn_bi.abft_bi_left = prev;
        bcn_bi.abft_idx = n;
        if (n == bi_cfg.abft_cnt_mod)
            bcn_bi.abft_idx = 0;
    }
    bcn_bi.abft_bi_left--;
    if (bi_cfg.x8 != 0) {
        u8 w = bcn_bi.x5_cdown;
        if (w == 0)
            w = bi_cfg.x8;
        w--;
        bcn_bi.x5_cdown = w;
    }
}

void bi_cfg_pack_words_78_7c(u32 a, u32 b)
{
    (void)b;
    u32 r2 = bi_cfg.flags;
    u32 r15 = (r2 >> 1) & 1;
    u32 r7 = (r2 >> 2) & 1;
    u32 r14 = r2 & 1;
    u32 r2c = (r2 >> 3) & 1;
    u32 r13 = bcn_bi.next_beacon;
    u32 r4 = bi_cfg.abft_len;
    u32 r8 = bi_cfg.fss;
    u32 r5 = bi_cfg.x9;
    u32 r6 = bi_cfg.n_bi_abft;
    u32 r9 = bi_cfg.abft_cnt_mod;

    u32 w0 = (r2c << 20) | (r7 << 19) | (r8 << 10) | (r4 << 7)
           | (r13 << 2) | (r15 << 1) | r14;
    bi_bcon_cfg_w0 = w0;

    u32 w1 = (r2c << 23) | (r9 << 17) | (r6 << 7) | r5;
    bi_bcon_cfg_w1 = w1;

    if (a != 0)
        bi_cfg_fill_slot_desc((u32)&bcn_bi, (u32)&bi_cfg);   /* r0/r1 перезаписаны до bl.ne */
}

/* 0x9381c4 */
void bi_ctrl_program_mac_bcon(void)
{
    u32 r2 = ((VOL(bcn_bi.x5_cdown) == 0) ? 0x40u : 0) | (1u << 25) | (1u << 27) | (1u << 29);
    u32 r1 = ((u32)VOL(bcn_bi.x2) << 14) | r2 | ((u32)VOL(bcn_bi.abft_bi_left) << 15);
    u32 r13 = VOL(bcn_bi.abft_idx);
    uc_mac_cmd(bi_bcon_cfg_w0 | r1);                    /* ld_s [gp,120] */
    uc_mac_cmd(bi_bcon_cfg_w1 | (r13 << 11) | 0x2b000000);   /* ld_s [gp,124] */
}

void bi_ctx_clear_counters(struct pm_ctx_s *p)
{
    p->ps_active = 0;
    /* vendor здесь же: расписания PS, UPM включён по умолчанию (простой 30 мс) — энергосбережение
     * вырезано (см. fw/action.c psc_req_reject); все станции всегда бодрствуют. */
}


u32 bi_manager_eval_bcon_slot(struct aw_win_s *w, u8 *out, u32 *out_word)
{
    u8 r3 = w->round;
    if (r3 >= 5)
        return 0;
    u32 r8 = 0;
    u8 r7 = w->cur_bit;
    do {
        u32 r6 = w->pend;
        if (r6 & (1u << r7)) {
            *out = r7 & 7;
            *out_word = (w->cur_bit >= 8) ? 0 : 1;
            r7 = w->cur_bit;
            r8 = 1;
        }
        r7++;
        w->cur_bit = r7;
        if (r7 == 0x10) {
            r7 = 0;                         /* L_927e2c: mov r7,0 — следующий круг с бита 0 */
            w->cur_bit = 0;
            w->round += 1;
        }
        if (r8 != 0)
            break;
    } while (w->round < 5);
    return r8;
}

void bi_run_bti_cycle(struct bi_ctx_s *c)
{
    if (mac_ifs_shadow != 0x300)
        uc_assert((u32)__builtin_return_address(0), 0x59);
    struct sls_peer_rec *r13 = &c->rec;
    if (bcn_rx.abft_here != 0) {
        l1_task_dispatch(2, 0);
        bf_ctx_dispatch_by_role(r13);
    }
    bi_manager_step_a(c);
    bi_manager_step_b(r13);
    if (mac_ifs_shadow != 0x300)
        uc_assert((u32)__builtin_return_address(0), 0x60);
    l1_task_dispatch(3, 0);
}

/* 0x92e7c8. Таблица 0x801ba8: 0,2,4 → l1_task_dispatch(1,0); 1 → bi_run_bti_cycle(a);
 * 3 → assert 0x76; 5 → l1_task_dispatch(6,0); 6 → ничего. */
void bi_bti_timer_step(u32 a, u32 b)
{
    uc_read_tsf_lo();
    switch (b) {
    case 0: case 2: case 4:
        l1_task_dispatch(1, 0);
        break;
    case 1:
        bi_run_bti_cycle((struct bi_ctx_s *)a);
        break;
    case 5:
        l1_task_dispatch(6, 0);
        break;
    case 6:
        break;
    default:
        uc_assert((u32)__builtin_return_address(0), 0x76);
        break;
    }
}

/* 0x939530: r0 = a, r1 = rate, r2 = b, r3 = flag. */
void bi_rx_send_response(u32 a, u32 rate, u32 b, u32 flag)
{
    u32 v;
    direct_tx_program_cmd34(0x16, 0x18);
    mac_program_tx_with_rate(rate);
    while (!(arc_core_rd(43) & (1u << 31)))
        ;
    v = arc_core_rd(51);
    mtp_desc_lo = v & 0xf;
    mtp_desc_hi = v >> 4;
    while (!(arc_core_rd(45) & (1u << 31)))
        ;
    uc_mac_cmd(flag ? 0x18000000 : 0x18002100);
    direct_tx_send_with_seq(a, b, flag);
}

/* 0x9210b0: окно приёма BI. gp+204 = 0x8005f4, gp+208 = 0x8005f8. */
u32 bi_rx_start_rx_window(u32 a, u32 b)
{
    u32 r14 = b;
    u32 r13;
    u32 limit = (r14 != 0) ? 0x1ef0 : 0x13fb;
    if (mac_read_time_88c120() < limit) {
        r13 = 0;
        goto tail;
    }
    r13 = (r14 != 0) ? 0x26 : 0x15;
    u32 r15 = sta_tab[a].tx_sel;
    txrx_state2 = 0;                                   /* st.as [gp,52] */
    txrx_state1 = (1u << 13) | 2;                      /* st.as [gp,51] */
    u32 cfg = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = cfg | (1u << 13) | (1u << 15);
    uc_mac_cmd(cfg | 0x1d00a000);
    mac_select_all_sectors_and_wait();
    mac_cmd_29000001();
    uc_mac_cmd(0x1f006000);
    uc_mac_cmd(0x38000300);
    uc_mac_cmd(0x3600003f);
    uc_mac_cmd(0x6000105);
    if (!mac_cca_ok()) {
        uc_mac_cmd(0x29000002);
        rx_mac_prepare();
        while (!(arc_core_rd(45) & (1u << 31)))
            ;
        /* L_9212dc */
        txrx_state2 = 0x800;
        bi_rx_tx_refused_cnt += 1;                               /* ldb [gp,-246] */
        r13 = 0;
        goto tail;
    }
    if (r14 != 0)
        uc_mac_cmd(0x20000400);
    uc_mac_cmd(0x37000005);
    uc_mac_cmd(0x37000002);
    uc_mac_cmd(r15 | 0x3f000000);
    uc_mac_cmd(0x3e000000);
    uc_mac_cmd(0x37000020);
    uc_stats.tx_start += 1;
    r13 |= 1u << 24;
    u32 reg = abif_dvs_rf_ctrl_shadow & ~((1u << 24) | (1u << 25));
    reg |= rf_set_tx << 24;
    abif_dvs_rf_ctrl_shadow = reg;
    MMIO32(HW_ABIF_DVS_RF_CTRL) = reg;
    r13 |= (1u << 26) | (1u << 28);
    uc_mac_cmd(r13);
    uc_mac_cmd(0x14000007);
    uc_mac_cmd(0x2008000);
    uc_mac_cmd(0x19000001);
    bi_rx_send_response(a, 0, 9, r14);
    mac_evt_enable_bit_sync_b(6);
    uc_spin_until_event(1u << 15);
    mac_mon_report.tx_atim_cnt += 1;
    uc_wait_one_event(6);
    uc_mac_cmd(0x14000000);
    mac_set_rf_chain_state(1, sta_tab[a].rx_sel);
    reg = abif_dvs_rf_ctrl_shadow & ~((1u << 24) | (1u << 25));
    reg |= rf_set_rx << 24;
    abif_dvs_rf_ctrl_shadow = reg;
    MMIO32(HW_ABIF_DVS_RF_CTRL) = reg;
    if (r14 != 0) {
        if (sxd_hal_wait_slot2_busy2(resp_wait_slots)) {
            r13 = (rx_flow_run() != 0 && (arc_core_rd(36) & (1u << 8))) ? 1 : 0;
        } else {
            tx_pick_slot_for_peer(1, a, 0x1f);
            r13 = 0;
        }
        uc_mac_cmd(1u << 29);
    } else {
        r13 = 1;
    }
tail:
    uc_mac_cmd(0x14000100);
    uc_mac_cmd(*(u16 *)&txrx_state1 | 0xdc0000);
    uc_mac_cmd((txrx_state1 >> 16) | 0xdc0000);
    uc_mac_cmd(*(u16 *)&txrx_state2 | 0xdc0000);
    uc_mac_cmd((txrx_state2 >> 16) | 0xdc0000);
    txrx_state1 = 0;
    txrx_state2 = 0;
    tx_ctx_pool.slot[0].flags = 0;
    tx_ctx_pool.slot[1].flags = 0;
    uc_mac_cmd(0x81u << 18);
    mac_set_mode_0000();
    return r13;
}
void bi_manager_step_a(struct bi_ctx_s *c)
{
    /* 0x92218c */
    (void)c;
    gp_timer_stop(0);
    if (maint_sta_mask != 0 && uc_role_ap == 0 && bcn_rx.my_bss != 0) {
        struct bti_sweep_cnt *r9 = &bti_cnt;
        r9->cid[2] = 0;
        if (r9->last_sector == sls_rx.x14 && r9->last_ant == sls_rx.x12) {
            r9->cid[1] = 0;
            r9->cid[0] = 0;
            r9->cid[3] = 0;
        } else if (r9->cid[0] == 0) {
            r9->cid[1] += 1;
        } else {
            r9->cid[1] = 0;
            r9->cid[0] = 0;
            r9->cid[3] = 0;
        }
        MMIO32(HW_PRS_OWN_ADDR_HI) |= (1u << 31);
    }
    if (uc_read_bi_sync() != 0 && fsched_enabled == 0)
        rx_nav_arm_flag_if_enabled();
    memset0_words_uc(&bcn_rx, 0x1c);            /* до x1c */
}
void bi_timing_snapshot_b(void)
{
    bi_win.bi_len_us = bi_tsf_delta64(bi_win.bti_tsf[0], bi_win.bti_tsf[1]);
    mac_read_tsf64_uc(bi_win.bti_tsf);
    u32 r2 = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = r2 | (1u << 14);
    uc_mac_cmd(r2 | 0x1d004000);
    arc_nops_nop(2);
    u32 r5 = arc_core_rd(40) & 0x3ffffff;      /* bmsk r5,r40,0x19 — биты 0..25 */
    bi_win.bti_pos = r5;                   /* delay-слот breq.d — всегда */
    if (bi_win.bti_seen == 0) {
        bi_win.bi_len_min = ~0u;
    } else {
        u32 r0 = bi_win.bi_len_us;
        if (r0 < 0x168f0)
            bi_win.bi_short_cnt += 1;
        else if (r0 > 0x1b710)                  /* brhs 0x1b710,r0 → пропуск */
            bi_win.bi_long_cnt += 1;
        u32 r3 = bi_win.bi_len_min;
        bi_win.bi_len_min = (r3 < r0) ? r3 : r0;   /* mov.cc r0 / mov.cs r3 — минимум */
        u32 r4 = bi_win.bi_len_max;
        bi_win.bi_len_max = (r4 < r0) ? r0 : r4;   /* mov.hi — максимум */
    }
    u8 r3 = mac_mon_slot_idx;
    bi_win.bti_seen = 1;
    u32 r6 = bi_win.bti_tsf[0];
    mac_mon_slot[r3].bti_start[0] = r6;
    mac_mon_slot[r3].bti_start[1] = bi_win.bti_tsf[1];
}
void bi_rx_slot_handler(struct aw_win_s *w)
{
    mac_mon_report.aw_backoff += 1;
    u32 sp0 = 0, sp1 = 0;
    u32 r0 = bi_manager_eval_bcon_slot(w, (u8 *)&sp0, (u32 *)&sp1);
    if (r0 == 0) {
        bi_tx_check_idle_and_start_uc(2);
        uc_mac_cmd(0x81u << 18);
        internal_tx_clear_pending_bit(0);
        return;
    }
    if (uc_role_ap != 0 && w->atim_armed == 0) {   /* breq.d r10,0 → пропуск */
        /* vendor L_92b51e..L_92b52e: mov_s r2,0x4b; asl r2,r2,5; mov lp_count,r2; lp 0x960 × 2×nop_s */
        arc_zol_nops2_shl(0x4b, 5);
        w->atim_armed = 1;
    }
    u32 r = bi_rx_start_rx_window(sp0, sp1);
    if (r != 0) {
        uc_read_tsf_lo();
        u32 mask = (sp1 == 0) ? (1u << sp0) << 8 : (1u << sp0);   /* cmp r16,0; mov.eq r15,bit<<8 */
        peer_masks_apply_op(&pm_ctx, 1, mask);
        w->pend &= ~mask;
        mac_mon_report.tx_atim_pass += 1;
        sta_slot_ok_cnt[sp0] += 1;
    } else {
        uc_read_tsf_lo();
        u32 mask = (sp1 == 0) ? (1u << sp0) << 8 : (1u << sp0);   /* cmp r16,0; mov.eq r2,bit<<8 */
        peer_masks_apply_op(&pm_ctx, 2, mask);
        mac_mon_report.tx_atim_fail += 1;
        sta_slot_fail_cnt[sp0] += 1;
    }
}
