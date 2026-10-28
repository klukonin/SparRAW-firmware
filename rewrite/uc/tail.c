// SPDX-License-Identifier: AGPL-3.0-or-later
/* Последний батч uCode — остаток ~101 функции (структурные порты). */
#include "../include/types.h"
#include "../include/bitfield.h"
#include "ifs.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/sta_max.h"
#include "abft.h"


#include "evt17.h"









/* ---- forward: подвызовы (stub ниже) ---- */

/* ISR: internal_tx_isr (0x92bbfc). jump-table по коду pending-бита. */

/* Обычная функция (vendor: push_s blink, вызывается bl). Таблица 0x801a94 (знаковая) по sm-1:
 * 0 → noop_hook, 1 → sm2, 2 → TxSS-sweep, 3 (sm4: передача FTM — только SparRAW-pro) и 4 → ничего,
 * 5 → sm6 (UPM — вырезан вместе с PS, см. fw/action.c psc_req_reject). */
void internal_tx_isr(void)
{
    if (itx_pending.mask == 0)
        uc_assert((u32)__builtin_return_address(0), 0x61);
    u32 pending = itx_pending.mask & ~itx_pending.exclude;                        /* 0x8006cc & ~0x8006d4 */
    u32 sm = 30 - arc_norm(pending);                   /* norm(0)=0 → 30 (vendor без проверки на 0) */
    internal_tx_clear_exclude_mask();
    uc_log_emit1(0x21, 0x10018cc, sm);
    u32 idx = sm - 1;                                  /* sub_s r13,1 */
    if (idx <= 5) {
        switch (idx) {
        case 5: break;                         /* sm6 (UPM) — энергосбережение вырезано, бит 6 не ставится */
        case 0: internal_tx_noop_isr_hook(); break;
        case 1: internal_tx_flow_sm2(0); break;
        case 2: {
            /* бит 6: TxSS-sweep — возможно отложить, если мало времени. */
            u32 cfg = mac_sel_shadow & 0xffff0fff;
            mac_sel_shadow = cfg | (1u << 14);
            uc_mac_cmd(cfg | 0x1d004000);
            arc_nops(3);
            u32 bi = mac_status_sel() & MAC_BI_COUNTER;          /* bmsk 0x19 */
            u32 dur = txss_sweep_duration_for_sta(bf_cur_sta);
            u32 ok = 1;
            if (uc_role_ap != 0 || maint_sta_mask != 0) {
                u32 rem = bcn_bi.bi_len_us;
                if (rem != 0 && (rem - bi) < dur) {
                    uc_log_emit3(0x21, 0x10018e8, bf_cur_sta, bi, dur);
                    if (itx_pending.txss_postponed == 1)
                        itx_pending.txss_postpone_cnt += 1;
                    else
                        itx_pending.txss_postpone_cnt = 1;
                    itx_pending.txss_postponed = 1;
                    ok = 0;
                }
            }
            if (ok != 0) {
                bf_sm_run_sta(bf_cur_sta);
                internal_tx_clear_pending_bit(3);
                bf_pending_set_bit(1);
                itx_pending.txss_postponed = 0;
            }
            bi_tx_check_idle_and_start_uc(2);
            break;
        }
        case 4: break;                                 /* 0x92bd2c: возврат */
        }
    }
}

/* ---- Простые thunk/accessor ---- */
void dti_alloc_scheduled_event_thunk(u32 *wake) { dti_worker_scheduled_dti_allocation_event(wake); }

/* noinline: vendor — отдельная функция (0x928308); с полем struct gcc иначе встраивает её
 * в l1_fixed_sched_ap_ev4_state2 (codecmp). */
__attribute__((noinline))
u32 get_mem_857744_x2_928308(void)
{
    return FWSH(fwsh_sets, fsched_tbl)->virtual_slot_us;
}

/* ucode_cmd_load_table_803124_803128 - в другом файле. */

void rate_search_commit_mcs(struct tx_ctx_s *a)
{
    /* 6.2 asm 0x92fd8c. */
    struct rs_sta_stats *rs = &rs_stats[*(u8 *)&a->sta];
    memset0_words_uc(rs->back_fail, sizeof(rs->back_fail));
    if (rs->mcs_best != 0)
        rs->mcs_try = rs->mcs_best;
}

void irq_init_event_masks(void)
{
    irq_evt_mask = 0x98f3f;
    MMIO32(HW_MAC_SXD_MAC_HW_ICR) = ~0u;
    MMIO32(HW_MAC_SXD_ERRORS_ICR) = ~0u;
    MMIO32(HW_MAC_HW_ICR_IMV) = ~irq_evt_mask;
    MMIO32(HW_MAC_SXD_ERRORS_IMV) = ~0u;
    uc_irq_set_level(6, 1);
}

void pmc_stop_recording(void)
{
    MMIO32(HW_MAC_MAC_RGF_PMC_GENERAL_0) &= 0xffffffu;
    arc_zol_nops2(0x50);   /* vendor L_936142: lp 0x50 × 2×nop_s */
    arc_zol_nops2(0x50);   /* vendor L_936152: lp 0x50 × 2×nop_s */
    arc_zol_nops2(0x50);   /* vendor L_936162: lp 0x50 × 2×nop_s */
    MMIO32(HW_MAC_MAC_RGF_PMC_GENERAL_0) |= (1u << 17);
}

/* uc_sysassert_snapshot_mac - в другом файле. */

void set_tsf_event(u32 a)
{
    uc_log_emit_snapshot(0x20, 0x1000f80);
    u32 r2 = 0x40 | (1u << 25);
    uc_mac_cmd(r2);
    const u32 *tsf = (const u32 *)a;            /* TSF64 {lo, hi} */
    MMIO32(HW_MAC_TSF_EVENT_LO) = tsf[0];
    MMIO32(HW_MAC_TSF_EVENT_HI) = tsf[1];
    MMIO32(HW_MAC_TSF_EVENT_CTRL) = 0xc0050;
}

void rx_flow_latch_phy_8014e8(u32 a)
{
    (void)a;
    u32 r0 = phy_read_signal_gain_adc_db_sfd_locked();
    sel_nbr.cur_gain_db = (u8)r0;
    if (r0 > 0x3f)
        sel_nbr.cur_gain_db = 0;
}


void disable_tsf_event(void)
{
    uc_log_emit_snapshot(0x20, 0x1000f90);
    *(volatile u32 *)HW_MAC_TSF_EVENT_CTRL = 0xc0010;
    uc_mac_cmd(0x40 | (1u << 25));
}

/* ---- arc_program_action_point (0x920f10) ---- */
void arc_program_action_point(const struct arc_ap_cfg *a)
{
    u32 idx = a->idx;
    arc_sr(0x1000000, 5);
    if (idx >= 2)
        uc_assert((u32)__builtin_return_address(0), 0xf6);
    u32 r4 = a->tt << 4;
    u32 r5 = a->at;
    u32 r3 = a->mode << 6;
    u32 r2 = a->paired << 7;
    u32 r1 = a->action << 8;
    u32 val = r1 | (r2 | (r3 | (r4 | r5)));
    u32 base = idx * 3;                 /* add1_s r0,r0,r0 = ×3 */
    arc_sr(a->amv, base + 0x220);
    arc_sr(a->amm, base + 0x221);
    arc_sr(val, base + 0x222);
}

void arc_protect_addr_uc(u32 a, u32 b, u32 c)
{
    uc_log_emit3(0, 0x10005f0, a, b, c);
    struct arc_ap_cfg ap;
    ap.idx = a;
    ap.amv = b;
    ap.amm = c;
    ap.at = 2;
    ap.tt = 1;
    ap.mode = 0;
    ap.paired = 0;
    ap.action = 1;
    arc_program_action_point(&ap);
}

/* ---- abif/rfca ---- */
void abif_set_enable_bit(u32 a)
{
    if (a & ~1u)
        uc_assert((u32)__builtin_return_address(0), 0xac);
    MMIO32(HW_ABIF_CAF_PWDN_MODE) = (MMIO32(HW_ABIF_CAF_PWDN_MODE) & ~1u) | a;
}

void abif_set_88a204_field(u32 a, u32 b)
{
    /* 6.2 asm 0x928cd8. */
    if (a & ~1u)
        uc_assert((u32)__builtin_return_address(0), 0xad);
    if (b & ~0x3fu)
        uc_assert((u32)__builtin_return_address(0), 0xae);
    u32 old = MMIO32(HW_ABIF_RX_TABLE_CTRL);
    MMIO32(HW_ABIF_RX_TABLE_CTRL) = (b << 1) | (((old & ~1u) | a) & ~0x7e);
}

void rfca_access_sector_other_rf(u32 a)
{
    if (rf_modules.count < 2)
        return;
    if (rf_modules.x4 != 0)
        return;
    u8 r13 = rfca_get_rf_mask_uc();
    u8 r0 = (u8)(r13 & ~rf_modules.mask);
    rfca_select_rf_uc((u8)r0, 0);
    sector_mem_addr_of(a);
    rfca_select_rf_uc((u8)r13, 0);
}

void rfca_select_rf_uc(u32 a, u32 b)
{
    /* Выбор RF-ядра (6.2 asm 0x928b8c). Полный порт:
     * 0x8004e4/0x800004 → poll aux47[17] → читать 0x889488 (прежний RF-id)
     * → совпал → выход; иначе poll 0x8890cc[29] → записать 0x889488/0x8006a0.
     * Внимание: ld.as/st.as — смещение ×4. */
    u32 r15 = a;
    u32 r2 = mac_sel_shadow;         /* [gp,-0x11] (ld.as ×4) */
    u32 r14 = b;
    r2 &= 0xfff0ffff;
    mac_sel_shadow = r2 | 0x30000;
    uc_mac_cmd(r2 | 0x1d030000);   /* mailbox */
    arc_nops_nop(2);
    while (mac_txctl_sel() & MAC_RFC_ACCESS_BUSY)
        ;
    u32 r3 = MMIO32(HW_ABIF_DVS_RF_CTRL) >> 8; /* [0x889800,-0xde] (ld.as ×4) */
    u32 r10 = (u8)r3;
    if (r14 != 0)
        *(u8 *)r14 = (u8)r3;           /* прежний RF-id */
    if (r15 == r10)
        return;                        /* уже выбран */
    for (u32 i = 0; i < 0x30d40; i++) {
        if (!(MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)))
            break;
    }
    if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {
        uc_log_emit_snapshot(0, 0x1002f00);
        uc_assert((u32)__builtin_return_address(0), 0x136e);   /* vendor продолжает */
    }
    u32 r4 = MMIO32(HW_ABIF_DVS_RF_CTRL) & 0xffff00ff;
    r15 = (r15 << 8) | r4;
    abif_dvs_rf_ctrl_shadow = r15;            /* [gp,0x5e] (st.as ×4) */
    MMIO32(HW_ABIF_DVS_RF_CTRL) = r15;
}

void gp0_arm_usec_b(u32 usec)
{
    u32 m = usec * 0xa5;
    uc_mac_cmd(0x52000000);
    uc_mac_cmd(0x52000000);
    uc_mac_cmd(0x49000040);
    uc_mac_cmd(m | 0x4f000000);
    uc_mac_cmd(0x52000408);
}


void gp_timer_arm(u32 a, u32 b, u32 c, u32 d)
{
    (void)c; (void)d;
    if (b & 0xff000000)
        uc_assert((u32)__builtin_return_address(0), 0x51);
    uc_mac_cmd((a + 0x52) << 24);
    uc_mac_cmd(0x49000000 | (1u << (a + 6)));
    uc_mac_cmd(0x49000000 | (1u << (a + 6)));
    uc_mac_cmd(((a + 0x4f) << 24) | b);
    arc_nops(3);
    uc_mac_cmd(((a + 0x52) << 24) | 0xb);
}

/* ---- handle triggers ---- */
void handle_bf_triggers(u32 cid, u32 set)
{
    /* 6.2 asm 0x928750: триггеры = *(u8*)(0x857e49+cid*20);
     * если (triggers & 0xbf) != 0 → лог + bf_trigger_for_mid(cid). */
    u32 triggers = VOL(link_stat[cid].bf_reasons);
    if ((triggers & 0xbf) != 0) {          /* bic -0xc0 = & 0xbf */
        uc_log_emit3(0x20, 0x1000d94, cid, set, triggers);
        bf_trigger_for_mid(cid);
    }
}

void handle_pmc_triggers(u32 trigger, u32 param)
{
    /* 6.2 asm 0x9289c0: pmc-стейт @0x801458. */
    if (pmc_trig.armed == 0)
        return;
    if (pmc_trig.recording == 0) {
        if (trigger == pmc_trig.start_trigger && param == pmc_trig.start_param) {
            uc_log_emit2(0x20, 0x10016a4, trigger, param);
            MMIO32(HW_MAC_MAC_RGF_PMC_GENERAL_0) |= (1u << 16);
            pmc_trig.recording = 1;
            pmc_trig.event_cnt = 0;
            uc_evt_send_2c_tsf(0, 0, pmc_trig.tag);
        }
    } else {
        if (trigger == pmc_trig.stop_trigger && param == pmc_trig.stop_param) {
            pmc_stop_recording();
            uc_log_emit2(0x20, 0x10016e0, trigger, param);
            pmc_trig.armed = 0;
            uc_evt_send_2c_tsf(1, pmc_trig.event_cnt, pmc_trig.tag);
        }
    }
    pmc_trig.event_cnt += 1;
}

/* ---- pm ---- */
void pm_event_mask_save_all_on(void)
{
    /* 6.2 asm 0x92dc6c. */
    rx_nav.ev_mask_saved = rx_nav.ev_mask;      /* сохранить маску событий */
    rx_nav.ev_mask = 0xffffffff;
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    uc_mac_cmd(mac_chain_mask | (1u << 27));   /* [gp,-0xd4] */
    mac_rf_switch_cmd1f(1);
    arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
}

void pm_event_mask_restore(void)
{
    if (rx_nav.flags & 1u) {                    /* NAV активен — вернуть сохранённую маску */
        rx_nav.ev_mask = rx_nav.ev_mask_saved;
        u32 saved = arc_lr(ARC_STATUS32);
        arc_flag(saved & ~(1u << 1));
        u32 r0 = (mac_chain_mask & rx_nav.ev_mask) | (1u << 27);
        uc_mac_cmd(r0);
        mac_rf_switch_cmd1f(1);
        arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
    }
    rx_nav.ev_mask_saved = ~0u;
}

/* ---- sysassert ---- */
/* uc_sysassert (0x926618) — в misc.c как uc_assert (полный порт). */

/* uc_sysassert_scan_stack - в другом файле. */

/* uc_sysassert_idle_hist - в другом файле. */

/* ---- прочее ---- */
void qh_write_while_dma_open_check(u32 a)
{
    (void)a;
    if (qh_dma_open == 0)
        return;
    struct qh_write_cmd *q = &fsched_peers.qh_pend;
    u8 r0 = fsched_peers.slot_kicked;
    u8 r2b = q->qid;                            /* L_92685c: r2 читается до ветки */
    if (r0 != 0) {
        u8 r3 = (u8)(vring_dbg.qh_write_dma_open_cnt + 1);
        vring_dbg.qh_write_dma_open_cnt = r3;
        uc_log_emit2(0, 0x1000704, r2b, r3);
    }
    qh_write_by_flags(q->qid, q->flags, (u32)q->win, q->desc_arg);
    qh_dma_open = 0;
}

void sched_cfg_merge_update(const struct lmac_cmd_write_qh *sr)   /* тело LMAC 0x45 */
{
    struct qh_write_cmd *q = &fsched_peers.qh_pend;
    u8 flags = sr->flags;
    if (qh_dma_open == 0) {
        memcpy_uc(q, sr, sizeof(*q));
        qh_dma_open = 1;
        return;
    }
    if (flags & 0x10) {
        q->desc_arg = sr->n;                    /* L_9268d8: stw [r14,0x3a] */
        memcpy_uc(q->desc_b, sr->desc + 0x40, sizeof(q->desc_b));
    }
    if (flags & 0x21)
        memcpy_uc(q->win[0], sr->desc, 0x10);
    if (flags & 0x2)
        memcpy_uc(q->win[1], sr->desc + 0x10, 0x10);
    if (flags & 0x4)
        memcpy_uc(q->win[2], sr->desc + 0x20, 0x10);
    if (flags & 0x8)
        memcpy_uc(q->win[3], sr->desc + 0x30, 0x10);
    q->flags |= flags;
}

/* Опубликовать текущую запись кольца (sync = 1) и сдвинуться (6.2 asm 0x926984).
 * entry — запись с заголовком; vendor проверяет только != 0 (адрес в desc уже стоит). */
void list_push_locked(struct uc_ring *r, u32 entry)
{
    if (entry == 0)
        uc_assert((u32)__builtin_return_address(0), 0xca);
    if (r->cur->sync != 0)
        uc_assert((u32)__builtin_return_address(0), 0xcb);
    u32 saved = arc_irq_disable();
    r->cur->sync = 1;
    struct mbox_ring_desc *next = r->cur + 1;
    if (r->end < next)
        uc_assert((u32)__builtin_return_address(0), 0xcc);
    r->cur = (next != r->end) ? next : r->base;
    arc_irq_restore(saved);
}

void evt_queue_take_locked(struct uc_mbox_ctx *a, u32 a1, u32 a2, u32 a3)
{
    (void)a, (void)a2, (void)a3;
    if (a1 == 0)
        uc_assert((u32)__builtin_return_address(0), 0xc2);
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    evt_queue_noop_lock_hook();             /* vendor передаёт (a+4,a1,a2,a3), хук пустой */
    arc_flag((saved & 2u) | arc_lr(ARC_STATUS32));
}

void dti_alloc_dispatch(struct bi_ctx_s *c)
{
    u32 r1 = c->phase;
    if (r1 == 0)
        uc_assert((u32)__builtin_return_address(0), 0xab);   /* L_92b778: только 0xab */
    else if (r1 == 1 || r1 == 2)
        dti_alloc_scheduled_event_thunk(&c->dti_wake);
    else
        uc_assert((u32)__builtin_return_address(0), 0x88);
}

void l2_handle_watchdog(void) {
    /* 6.2 asm 0x92cf90 (вектор L2, r0 = 3). */
    FWSH(fwsh_diag, uc_wd_pm_ms[0]) = power_manager_scale_counters_ms();
    power_mngr_stats_calc_delta(uc_read_tsf_lo());       /* r0 = TSF */
    u32 il1 = arc_core_rd(29), il2 = arc_core_rd(30);    /* ilink1/ilink2 */
    FWSH(fwsh_diag, uc_wd_pm_ms[1]) = power_manager_scale_counters_ms();
    uc_log_emit2(0, 0x1000638, il1, il2);
    uc_log_emit3(0, 0x1000668, power_manager_scale_counters_ms(),
                 txrx_state1, txrx_state2);
    uc_sysassert_scan_stack(1);
    arc_sr(uc_timer[1].xc, uc_timer[1].ctrl);
    arc_sr(0, uc_timer[1].count);
    l2_task_kick_mac_events();
    l2_wd_fired = 1;
    power_mngr_stats_mark_base(uc_read_tsf_lo());
}


/* memset_uc — в mem.c (скорость важна для таймингов MAC). */

/* 0x92d9d4. Таблица 0x801aa8 (слова): 0,1 → 0x92da06 (c<<16, проверка очереди),
 * 2,4 → assert 0x8c, 3 → 0x92d9fe (0x103), 5 → 0x92da0a (проверка очереди без c). */
void mtp_service_dispatch(u32 a, u32 b, u32 c, u32 d)
{
    u32 r13 = (a << 8) | 0x1f0022;
    u32 r14 = 0;
    if (a >= 6 || a == 2 || a == 4) {
        uc_assert((u32)__builtin_return_address(0), 0x8c);
    } else if (a == 3) {
        r14 = 0x103;
    } else {
        if (a != 5)
            r14 = c << 16;
        if ((txrx_state1 & 2u) && rs_state[b].active != 0)
            r14 |= ((u32)mtp_queue_byte_by_index(b) << 8) | 3;
        else if (d != 0xff)
            r14 |= (d << 8) | 3;
    }
    uc_mac_cmd(0x1b001111);
    uc_mac_cmd(r13 | 0x16000000);
    uc_mac_cmd(r14 | 0x17000000);
    arc_nops(3);
}

u32 grant_detect_step(u32 a, u32 b, u32 c) {
    /* 6.2 asm 0x92db88. */
    u32 r14 = b, r15 = 0;
    u32 r0 = uc_read_tsf_lo() + a;
    u32 r2 = rx_nav.flags;                               /* vendor читает после uc_read_tsf_lo */
    if ((r2 & 3) == 3) {
        r0 -= rx_nav.end_tsf;
        if (r0 & (1u << 31))
            goto done;
    }
    r15 = 1;
    if (r2 & 1u) {
        rx_nav.flags = r2 & ~1u;
        rx_nav.ev_mask = 0xffffffff;
        nav_late_cnt = 0;
        r14 = r15;
    }
done:
    if (c != 0 && r14 != 0) {
        u32 saved = arc_lr(ARC_STATUS32);
        arc_flag(saved & ~(1u << 1));
        uc_mac_cmd((mac_chain_mask & rx_nav.ev_mask) | (1u << 27));
        mac_rf_switch_cmd1f(1);
        arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
    }
    if (r15 == 0)
        uc_stats.grant_fail = uc_stats.grant_fail + 1;
    return r15;
}


/* notify_aoa (0x92de8c): вынуть очередной установленный бит маски-указателя и
 * вернуть его индекс (31 для bit31, иначе 30-clz). Маска сдвинута на 1: бит N
 * кодирует индекс N-1, бит 0 не используется. */
u32 notify_aoa(u32 a)
{
    u32 r2 = *(u32 *)a;
    if (r2 == 0)
        return (u32)-1;
    u32 idx;
    if (r2 & (1u << 31)) {
        idx = 31;
        r2 &= 0x7fffffffu;               /* bmsk 0x1e */
    } else {
        idx = (30 - arc_norm(r2));    /* norm + rsub 0x1e */
        r2 &= ~(1u << (idx & 31));       /* bclr */
    }
    *(u32 *)a = r2;
    return idx;
}


/* Третий вход блока notify_aoa (0x92df38): построить отчёт и разослать как
 * bf_done (arg1 != 8) либо new_link (arg1 == 8). */
void notify_aoa_build(u32 arg0, u32 arg1, u32 arg2)
{
    /* 0x92df38: отчёт 0x44 Б (vendor sp+0x34..0x77) → bf_done / new_link (arg1 == 8). */
    union {
        u32 w[17];
        struct lmac_evt_bf_done e;
    } r;
    memset0_words_uc(r.w, 0x44);
    r.e.status = arg2;                                            /* sp+0x60 */
    u32 st = VOL(link_stat[arg1].bf_reasons);
    bf_res.fail_reasons = st;                                        /* [0x802110+0x18] */
    r.e.fail_reasons = st;                                        /* sp+0x70 */
    r.e.cid = (u8)arg1;                                           /* sp+0x38 */
    u32 r0 = bf_res.diag_last;
    r.e.diag_lo = r0 & 0xf;                                       /* sp+0x6e */
    r.e.diag_hi = (r0 & 0x3f0) >> 4;                              /* bic -0x3f1; lsr 4 */
    if (arg0 != 0) {
        if (maint_sta_mask & (1u << arg1)) {
            r.e.snr = brp_rf.snr;
            r.e.type = 1;
        } else {
            r.e.snr = (u32)bf_rep.link_snr;
            r.e.type = 0;
        }
        r.e.peer_snr = (u8)bf_rep.peer_snr;                       /* sp+0x40 (ldb.x → stb) */
        r.e.sect_seen[0][0] = bf_rep.sect_seen[0][0];             /* sp+0x48 */
        r.e.own_snr = (s32)bf_rep.own_snr;                        /* sp+0x44, ldb.x */
        r.e.rf_sector = (rf_chain_word >> 8) & 0x7fff;            /* sp+0x3e */
        r.e.sect_seen[1][0] = bf_rep.sect_seen[1][0];             /* sp+0x50 */
        r.e.ssw_rx_cnt = bf_rep.ssw_rx_cnt;                       /* sp+0x3d */
        r.e.sect_seen[0][1] = bf_rep.sect_seen[0][1];             /* sp+0x4c */
        r.e.sect_seen[1][1] = bf_rep.sect_seen[1][1];             /* sp+0x54 */
        r.e.brp_selected = brp_pick.selected;                     /* sp+0x5c */
        r.e.brp_snr = brp_rf.snr;                                 /* sp+0x58 */
        r.e.rx_sector = bf_res.rx_sector;                         /* sp+0x39 */
        r.e.peer_mac[0] = sls.peer_mac[0];                        /* sp+0x68 */
        r.e.peer_mac[1] = sls.peer_mac[1];                        /* sp+0x6a */
        r.e.peer_mac[2] = sls.peer_mac[2];                        /* sp+0x6c */
    }
    r.e.tx_sector_b1 = fwsh_sls_rank_b1[arg1][0];                 /* sp+0x3a */
    r.e.tx_sector = fwsh_sls_rank[arg1][0];                       /* sp+0x3c */
    r.e.tsf = uc_read_tsf_lo();                                   /* sp+0x74 */
    if (arg1 == 8)
        uc_send_evt_new_link(EVT17(r.w));
    else
        uc_send_evt_bf_done(EVT17(r.w));
}

void phy_stats_accumulate_to_shared(struct rx_meas_ctx *m, u32 b)
{
    (void)m;
    u32 buf[30];
    volatile struct phy_rx_stats *vst = &fwsh_phy.st;
    u32 r14 = rate_search_current_mcs(b);
    phy_stats_clear_counters_88395c();
    hwd_phy_uses_rgf_883800_929b94(buf);
    hwd_phy_uses_rgf_883800_929af4(buf + 0xe);
    phy_stats_clear_counters_883960();

    for (u32 i = 0; i < 14; i++)
        vst->cnt[i] += buf[i];

    /* 8 независимых 64-битных сумм (add.f lo; adc hi — перенос между парами не идёт) */
    for (u32 k = 0; k < 8; k++) {
        u64 sum = (((u64)vst->acc[k][1] << 32) | vst->acc[k][0])
                + (((u64)buf[15 + 2 * k] << 32) | buf[14 + 2 * k]);
        vst->acc[k][0] = (u32)sum;
        vst->acc[k][1] = (u32)(sum >> 32);
    }
    /* max_mcs/rx_sector/rx_gain — обычными (не volatile) обращениями, как у vendor. */
    struct phy_rx_stats *st = (struct phy_rx_stats *)vst;
    u32 r0 = st->max_mcs;
    if (r0 > r14)
        r14 = r0;
    st->max_mcs = r14;
    st->rx_sector = bf_res.rx_sector;
    u32 idx = (30 - arc_norm(rf_modules.mask));
    st->rx_gain = rf_rx_gain_hi[idx];
}

u32 queue_sel_get_qset4(u32 a)
{
    /* 0x92e9e8: *a = поле qset (r41 24..28); возврат r41 >> 31 (второе чтение). */
    uc_mac_cmd(0xf000001u);
    u32 r1 = mac_sel_shadow & 0xfffff0ffu;
    mac_sel_shadow = r1 | (1u << 8);
    uc_mac_cmd(r1 | 0x1d000100u);
    arc_nops(3);
    *(u32 *)a = MAC_QSET4_QID_OF(mac_queue_sel());
    return MAC_QSET4_VALID_OF(mac_queue_sel());
}

void sends_pmc_mark_aaab20(u32 a)
{
    uc_mac_cmd(0x80aaab20);
    fsched_slot_clear_f4(&fsched_peers);
    if (bf_ctrl.triggers & (1u << 2)) {
        u8 b = VOL(link_stat[a].bf_reasons);
        VOL(link_stat[a].bf_reasons) = b | (1u << 2);
    }
    handle_bf_triggers(a, 3);
}

void buf_fill_ff(struct rx_meas_ctx *m)
{
    m->kind = 0;                                /* st.ab r14,[r0,36]: запись по dst, затем r0 += 36 */
    memset_uc(&m->filt, 0xff, sizeof(m->filt));
    memset_uc(&m->got, 0xff, sizeof(m->got));
    m->busy = 0;
    m->done = 0;
    m->state = 0;
    m->tsf[0] = 0;
    m->tsf[1] = 0;
    m->snap_sel5 = 0;
    m->snap_sel6 = 0;
    m->report_cb = 0;
}

u32 rf_utils_auto_fill_uc(const struct rf_fill_info *f, u32 b)
{
    u32 r18 = b;
    if (f == 0 || (u8)f->bank >= 2) {
        uc_log_emit1(0, 0x1000e6c, (u32)f);
        return 1;
    }
    u32 r10 = (f->bank << 8) + (0x53c << 3);   /* add3 r10,r10,0x53c */
    u32 r14 = (r10 >> 3) & ~3u;
    u32 r11 = f->sec_last << 8;
    u32 r7 = (f->sec_first | r11) | (f->val_mask << 16);
    u32 r3 = f->vals;
    u32 r15 = 0;
    u32 buf[0x40];
    if (r3 != 0) {
        for (u32 i = 0; i < 6; i++)
            buf[i] = *(u32 *)(r3 + i * 4);
        r15 = 6;
        u32 r9 = (f->bank << 8) + (0x524 << 3);   /* add3 */
        r14 = (r9 >> 3) & ~3u;
    }
    buf[r15] = r7;
    r15 += 1;
    buf[r15] = 1;
    r15 += 1;
    u8 r17 = f->rf_mask;
    {
        u32 *r13 = buf;                         /* ld.ab r2,[r13,4] — с начала буфера */
        while (r15 >= 1) {
            rf_utils_fill_step(r17, r14, *r13++, 0);
            r15 -= 1;
            r14 += 4;
        }
    }
    u32 r19 = 0;
    if (r17 != 0) {
        u32 t = r17;
        do {
            t &= t - 1;
            r19++;
        } while (t != 0);
        r19 &= 0xffff;
    }
    if (r19 < 1)
        return 1;
    r15 = 1;
    do {
        u32 r16 = r17;
        for (u32 i = 1; i < r15; i++)
            r16 &= r16 - 1;
        r16 = (u8)(r16 & ~(r16 - 1));
        rfca_select_rf_uc(r16, 0);
        u32 r0, r13 = 0;
        do {
            r0 = hwd_rfc_read_rgf_uc(0, 0x4f0);
            if (r0 == 0xdeadbeef) {
                uc_log_emit1(0, 0x1000eac, r16);
                if (r18 != 0)
                    uc_assert((u32)__builtin_return_address(0), 0x1565);
                return 0;
            }
            r13 = (u16)(r13 + 1);
        } while ((s32)r13 < 2 && (r0 & 1));
        if (r0 & 1) {
            uc_log_emit_snapshot(0, 0x1000ef4);
            if (r18 != 0)
                uc_assert((u32)__builtin_return_address(0), 0x1566);
            return 0;
        }
        u32 v = hwd_rfc_auto_fill_verify(f, r16, r18);
        if (r18 == 0 && v == 0)                 /* cmp r18,0; cmp.eq r0,0; beq */
            return 0;
        r19--;
        r15 = (u16)(r15 + 1);
    } while (r19 >= 1);
    return 1;
}

void rf_utils_fill_step(u32 a0, u32 a1, u32 a2, u32 a3)
{
    u8 buf = 0;
    rfca_select_rf_uc(a0, (u32)&buf);
    hwd_rfc_write_core(0, a3, a1, a2);
    if (a0 != buf)
        rfca_select_rf_uc(buf, 0);
}

void hw_power_step(u32 a0)
{
    u8 buf = 0;
    rfca_select_rf_uc(a0, (u32)&buf);
    hwd_rfc_write_core(0, 1, 0, 0);
    if (a0 != buf)
        rfca_select_rf_uc(buf, 0);
}

void hw_bring_up_phy_dma(u32 a0, u32 a1)
{
    u32 *cfg = (u32 *)a1;
    u32 v = *cfg;
    if (a0 != 0) {
        if (v & 1u) {
            hwd_phy_uses_rgf_881000_929730(4);
            dma_mac_cfg_880c2c(1);
            dma_mac_cfg_880c28(1);
            hwd_phy_uses_rgf_881000_9296e0(1);
            hwd_phy_pwr(0);
            v = *cfg;
        }
        if (v & 2u) {
            u32 w = cfg[1];
            if (w & 1u) hwd_dma_set_mode_map(4);
            if (w & 4u) hwd_phy_uses_rgf_881000_929730(4);
            if (w & 8u) mac_fill_mode_nibbles(4);
            if (w & 0x10u) mac_set_880bf0_mode(4);
            v = *cfg;
        }
        if (v & 8u) {
            u32 w = cfg[2];
            if (w & 1u) mac_set_880afc_bits(1);
            if (w & 4u) dma_mac_cfg_880c28(1);
            if (w & 8u) dma_mac_cfg_880c14(1);
            if (w & 0x10u) clk_gate_880b00(1);
        }
    } else {
        if (v & 8u) {
            u32 w = cfg[2];
            if (w & 1u) mac_set_880afc_bits(0);
            if (w & 4u) dma_mac_cfg_880c28(0);
            if (w & 8u) dma_mac_cfg_880c14(0);
            if (w & 0x10u) clk_gate_880b00(0);
            v = *cfg;
        }
        if (v & 1u) {
            hwd_phy_pwr(1);
            hwd_phy_uses_rgf_881000_9296e0(0);
            dma_mac_cfg_880c28(0);
            dma_mac_cfg_880c2c(0);
            hwd_phy_uses_rgf_881000_929730(0);
            hwd_phy_init_2();
            v = *cfg;
        }
        if (v & 2u) {
            u32 w = cfg[1];
            if (w & 1u) hwd_dma_set_mode_map(0);
            if (w & 4u) hwd_phy_uses_rgf_881000_929730(0);
            if (w & 8u) mac_fill_mode_nibbles(0);
            if (w & 0x10u) mac_set_880bf0_mode(0);
        }
    }
}

void hw_power_sequence_rf(u32 a0, u32 a1)
{
    u32 v = *(u32 *)a1;
    if (a0 != 0) {
        if (v & 1) { hw_power_step(rf_modules.cur); v = *(u32 *)a1; }
        if (v & 2) { hwd_rfc_powerdown_deep_all_rfs(); v = *(u32 *)a1; }
        if (v & 8) { rf_set_normal_mode(1); v = *(u32 *)a1; }
        if (v & 0x20) hw_bring_up_phy_dma(1, a1 + 4);
    } else {
        if (v & 0x20) { hw_bring_up_phy_dma(0, a1 + 4); v = *(u32 *)a1; }
        if (v & 8) { rf_set_normal_mode(0); v = *(u32 *)a1; }
        if (v & 2) hwd_rfc_powerup_deep_all_rfs();
    }
}

void boot_uc_init_more(struct rx_meas_ctx *m)
{
    buf_fill_ff(m);
    memset0_words_uc(m->sample, sizeof(m->sample));
    memset0_words_uc(m->sample_88306c, sizeof(m->sample_88306c));
    m->n = 0;
    memset0_words_uc(&m->plcp, sizeof(m->plcp));
}

void mac_mem_addr_of_slot(u32 a, u32 b, u32 c)
{
    macq_hw_set_ctrl_bit(a);
    u32 base = a * 7 * 128;   /* (a*8 - a) << 7 */

    u32 r1 = (base + 0x4409980) >> 3;
    r1 &= ~3u;
    *(u32 *)r1 = b;

    u32 r2 = base + 0x44099c0;
    u32 r0 = (r2 >> 3) & ~3u;
    u32 r8 = *(u32 *)r0;
    u32 bit = (u32)(1u << (r2 & 0x1f));
    *(u32 *)r0 = (r8 & ~bit) | bit;

    *(u32 *)((base + 0x44096c0) >> 3) = ((c << 16) & 0x1f0000u) | 0xf;
    arc_sync();
    arc_nops_nop(2);   /* vendor L_928eec: 2×nop + mov 0,0 */
    *(u32 *)((base + 0x4409700) >> 3) = 1;
    arc_sync();
    arc_nops(3);     /* vendor L_928f18: 3×nop */
    *(u32 *)((base + 0x4409700) >> 3) = 0;
    arc_sync();
    arc_nops(3);     /* vendor L_928f38: 3×nop */
    *(u32 *)((base + 0x44096c0) >> 3) = ((c << 16) & 0x1f0000u) | 0x1f;
    arc_sync();
}

void mac_program_886e0c_20b(u32 a)
{
    u8 *b = (u8 *)a;
    u32 mask = mac_build_qset_mask((const struct lmac_mac_regs *)a);
    u32 repl = mac_replicate_bit_mask((const struct lmac_mac_regs *)a);
    *(volatile u32 *)HW_MAC_LMAC0_TIMING_0 = (u32)b[0] << 16 | (u32)b[1] << 24 | b[4] | (u32)b[5] << 8;
    *(volatile u32 *)HW_MAC_LMAC0_TIMING_1 = b[2] | (u32)b[3] << 8 | (u32)b[6] << 16 | (u32)b[7] << 24;
    *(volatile u32 *)HW_MAC_LMAC0_TIMING_2 = b[8] | (u32)b[9] << 8 | (u32)b[0xa] << 16 | (u32)b[0xb] << 24;
    *(volatile u32 *)HW_MAC_LMAC0_TIMING_3 = b[0xc] | (u32)b[0xd] << 8 | (u32)b[0x12] << 16 | (u32)b[0x13] << 24;
    *(volatile u32 *)HW_MAC_LMAC0_TIMING_4 = b[0xe] | (u32)b[0xf] << 8 | (u32)b[0x10] << 16 | (u32)b[0x11] << 24;
    uc_mac_cmd(mask | 0x35000000);
    uc_mac_cmd(repl | 0x39000000);
    uc_mac_cmd(0x38000200);
    uc_mac_cmd(0x3c000200);
    *(volatile u32 *)HW_MAC_LMAC0_TIMING_CONST = 0xbe41190;
    uc_mac_cmd(0x4e00000d);
}

void mac_program_rx_window(u32 a, u32 b, u32 c)
{
    uc_mac_cmd(0x1f006000u);
    uc_mac_cmd(0x38000300);
    uc_mac_cmd(0x3600003f);
    uc_mac_cmd(a | (1u << 8) | (1u << 25) | (1u << 26));
    uc_mac_cmd(0x37000005);
    uc_mac_cmd(0x37000002);
    uc_mac_cmd(b | 0x3f000000);
    uc_mac_cmd((c << 4) | 0x3e000000);
    uc_mac_cmd(0x37000020);
    uc_stats.tx_start += 1;
    u32 r0 = abif_dvs_rf_ctrl_shadow;
    r0 &= ~(1u << 24);
    r0 &= ~(1u << 25);
    r0 |= rf_set_tx << 24;
    abif_dvs_rf_ctrl_shadow = r0;
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r0;
}

void mac_prepare_txrx_window(struct tx_ctx_s *a, u32 b)
{
    u32 r5 = txrx_state2 & ~0x1f;
    u32 r10 = txrx_state1;
    r5 |= (1u << 7);
    txrx_state2 = r5;
    if (!(r10 & 2)) {
        mac_select_rf_module_cmd31(0, 0);
        if (a->flags & 2)   /* btst 0x1 / bbit0 0x1 — бит 1 */
            mac_q_tx_ppdu(a, 2);
        return;
    }
    mac_select_rf_module_cmd31(0, 0);
    u32 r8 = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = r8 | 0x3000;
    uc_mac_cmd(r8 | 0x1d003000);
    arc_nops_nop(2);
    u32 r7 = (u16)mac_status_sel();              /* extw r7,r40 — delay-слот, читается всегда */
    if (b == 2) {
        u32 r6 = ((u8 *)&ifs.slot)[1];
        if ((r6 << 1) < r7 && (r7 - (r6 << 1)) >= 0xc && !(mac_evt1() & MAC_EVT1_TXOP)) {   /* sub1 */
            uc_mac_cmd(0x14000002);
        } else {
            txrx_state2 |= (1u << 10);
            rx_mac_prepare();
        }
    } else {
        txrx_state2 |= (1u << 10);
        rx_mac_prepare();
    }
    if (a->flags & 2)   /* btst 0x1 / bbit0 0x1 — бит 1 */
        mac_q_tx_ppdu(a, 2);
    uc_mac_cmd(mac_evt_en_shadow | 0x27000e00);
    uc_mac_cmd(0x2004000);
    arc_nops(3);
    uc_wait_event_busy(MAC_EVT1_SLOT | MAC_EVT1_BUSY2, 0);
    if (mac_evt1() & MAC_EVT1_BUSY2)
        txrx_state2 &= ~(1u << 8);
}

/* mac_prog_cmd02_body (0x921460): пересчитать BI-дельту и запрограммировать
 * контекст по таблице в 0x801040. */
void mac_prog_cmd02_body(void)
{
    u32 r0 = (u32)bi_tsf_delta64(bi_win.aw_tsf[0], bi_win.aw_tsf[1]);   /* lo-слово дельты */
    bi_win.delta_lo = r0;                                        /* 0x802f04 */
    u32 r8 = r0;
    /* add3 r0,r0,0x3e8 = +(0x3e8<<3) = +0x1f40; vendor прибавлял ещё длительность Awake Window
     * (aw_win.dur_tu из LMAC 0x25) — PS вырезан, она всегда 0. */
    u32 sum = 0x1f40;
    if (sum < r8)
        bi_win.x48 += 1;                                    /* 0x802f08 */
    u32 r4 = bi_win.x4c;                                    /* 0x802f0c */
    u32 r3 = (r4 <= r8) ? r8 : r4;                         /* max(беззнак.) */
    bi_win.x4c = r3;
    u32 r6 = bi_win.aw_tsf[0];
    u32 r5 = bi_win.aw_tsf[1];
    mac_mon_report.aw_start_lo = r6;                                         /* 0x8010b0 */
    u32 r1 = mac_mon_slot_idx;
    mac_mon_report.aw_duration = r8;                                         /* 0x8010b8 */
    u32 r2 = mac_mon_slot[r1].bti_duration;
    mac_mon_report.aw_start_hi = r5;                                         /* 0x8010b4 */
    mac_mon_report.dti_duration = bi_win.bi_len_us - r2 - r8;                           /* 0x8010cc */
    u64 a64 = ((u64)bi_win.bti_tsf[1] << 32) | bi_win.bti_tsf[0];
    u64 res = a64 + (u64)r2 + (u64)r8;                     /* add.f/adc цепочка */
    mac_mon_report.dti_start_lo = (u32)res;                                   /* 0x8010c4 */
    mac_mon_report.dti_start_hi = (u32)(res >> 32);                           /* 0x8010c8 */
}


/* mac_mode_switch_sequence (0x9273c0): вход/выход из режима (a!=0 — норма,
 * a==0 — сброс секторов и восстановление). */
void mac_mode_switch_sequence(u32 a)
{
    uc_mac_cmd(a | 0xaa00u);
    uc_mac_cmd(arc_lr(uc_timer[1].count) & 0xffffffu);   /* bmsk 0x17 */
    if (a != 0) {
        mac_mode_sw.halt_cnt += 1;                                       /* 0x8006a9 */
        mac_program_13ab6680_b();
        rf_power_seq_and_save(1);
        uc_mac_cmd(1u << 24);
        uc_mac_cmd(0x20c0010);
        MMIO32(HW_FW2UC_ICR) = 2;
        arc_sync();
        MMIO32(HW_FW2UC_IMC) = 2;
        arc_sync();
        MMIO32(HW_FW2UC_IMC) = 4;
        arc_sync();
        mac_mode_sw.halted = 1;                                        /* 0x8006a8 */
    } else {
        mac_mode_sw.resume_cnt += 1;                                       /* 0x8006aa */
        mac_program_13ab6680();
        if (rx_on_state != 0)                         /* ldw_s [gp,0x94] */
            uc_mac_cmd(0x1ffffff);
        rf_power_seq_and_save(0);
        u32 r13b = rf_modules.x4;                        /* [0x8006b4+4] */
        while (r13b != 0) {
            u32 r14 = (u32)(u8)(u8)((30 - arc_norm(r13b))); /* norm+rsub0x1e */
            brp_restore_sectors(r14);
            r13b = (u32)(u8)(u8)(r13b & ~(1u << (r14 & 31)));  /* bclr+extb_s */
        }
        MMIO32(HW_FW2UC_ICR) = 4;
        arc_sync();
        MMIO32(HW_FW2UC_IMC) = 4;
        arc_sync();
        mac_mode_sw.halted = 0;                                        /* 0x8006a8 = r15 */
    }
}

/* mac_mode_program_c (0x92c09c): цикл программирования MAC-режима 'c' —
 * ожидание событий, заполнение конфигурации станции из 0x804010 и выдача
 * отчёта. */
void mac_mode_program_c(struct sls_peer_rec *a)
{
    u32 first = 0;                         /* r15 */
    const struct dmg_ssw_frame *cfg = (const struct dmg_ssw_frame *)rx_buf;   /* r13: кадр SSW */
    uc_mac_cmd(0x2011000u);
    uc_mac_cmd(0x3d000400u);
    for (;;) {
        /* L_92c13c */
        u32 evt = uc_wait_event1_or_event4(MAC_EVT1_RX_FRAME, MAC_EVT4_GP1_END, 0);
        if (mac_evt4() & MAC_EVT4_GP1_END) {
            /* L_92c230: выход по событию 4. */
            /* СРОК: SSW-Feedback инициатора A-BFT (direct_tx_step) — через MBIFS (9 мкс, допуск
             * −0/+0.49 мкс) после SSW ответчика (802.11-2020 10.42.5.2, 10.3.2.3.10). Vendor-
             * защита ниже: SIFS_CNT (r55 после 0x4d000000) ≥ 0x700 (7 мкс) — не отвечать; значит
             * от чтения r55 до старта передачи остаётся ≤ ~2 мкс (~330 тактов) минус задержка
             * PHY. Путь чтение r55 → 0x19000001 (direct_tx_step: mac_program_rx_window(1),
             * 0x15/0x14, direct_tx_build_desc, cmd34, mac_program_tx_common, 0x2008000)
             * ~169 инструкций (vendor 0x92c25a.. ~191); запас: десятки инструкций при r55 у
             * порога. Срыв: Feedback вне окна aSSFBDuration — ответчик его не ждёт, A-BFT-
             * ассоциация срывается. Не добавлять код между чтением r55 и 0x19000001. */
            uc_mac_cmd(0x49000080u);
            mac_set_mode_a000(evt);
            uc_mac_cmd(0x4d000000u);
            arc_nops(3);
            u32 r55 = mac_timer_sel();
            if (r55 >= SIFS_CNT_ABFT_FB_LATE)
                return;
            if (r55 == 0 || first == 0)
                return;
            /* L_92c27e */
            bcn_rx.abft_direct_cnt += 1;
            u32 r9 = rf_chain_cfg;                     /* ld.as [gp,-0x3] */
            u32 r2 = a->rx_sector;
            u32 r6 = r9 | 0x30u | (r2 << 8);
            sta_tab[a->sta].tx_sel = r6;       /* asl4+add2 = *80 */
            direct_tx_step(a);
            uc_mac_cmd(0x3c000004u);
            bcn_rx.abft_direct_rep += 1;
            uc_evt_build_and_post_report(a, 1);   /* vendor 0x92c2f0: (r14, 1) */
            u32 r6b = mac_sel_shadow & 0xfff0ffffu;
            mac_sel_shadow = r6b | 0x50000u;
            uc_mac_cmd(r6b | 0x1d050000u);
            arc_nops_nop(2);
            for (;;) {                             /* один цикл: любая неудача — с начала */
                if (!(mac_txctl_sel() & MAC_RFC2RX_ANALOG_TX_OFF)) continue;
                if (!(mac_txctl_sel() & MAC_RFC2RX_ANALOG_RX_ON)) continue;
                if (!(mac_txctl_sel() & MAC_RFC2RX_RX_AWV_CFG)) continue;
                break;
            }
            u32 r5 = abif_dvs_rf_ctrl_shadow & 0xfcffffffu;
            u32 r6c = (rf_set_rx << 24) | r5;
            abif_dvs_rf_ctrl_shadow = r6c;
            MMIO32(HW_ABIF_DVS_RF_CTRL) = r6c;
            return;
        }
        if (!(mac_evt1() & MAC_EVT1_RX_FRAME))
            continue;
        /* L_92c15c */
        if (rx_arm_window_c() == 0)
            continue;
        /* L_92c166 */
        u32 cfg0 = mac_sel_shadow & 0xffff0fffu;
        mac_sel_shadow = cfg0 | 0xd000u;
        uc_mac_cmd(cfg0 | 0x1d00d000u);
        arc_nops(3);
        u32 r9 = MAC_BF_METRIC_OF(mac_status_sel());
        u32 r0b = (r9 > 0x3ff) ? (r9 - 0x800) : r9;
        if (!(rx_buf_ssw & 1u))
            continue;
        /* L_92c1c0 */
        if (first == 0) {
            /* L_92c370: первый проход — скопировать конфигурацию. */
            a->peer_mac[0] = cfg->ta.h[0];
            a->peer_mac[1] = cfg->ta.h[1];
            a->peer_mac[2] = cfg->ta.h[2];
            a->rx_metric = (s32)r0b;
            first = 1;
            if (mac_rx_rep3() & MAC_RX_REP3_ADDR2_VALID) {
                a->sta = MAC_RX_REP3_ADDR2_IDX_OF(mac_rx_rep3());          /* L_92c0d0 */
            } else {
                a->sta = SPARRAW_PEER_UNKNOWN;
            }
            /* L_92c0dc */
            a->rx_antenna = rx_buf_bcn_ssw & 3u;
            a->rx_sector = rx_buf_ssw >> 10;
            a->fb_antenna = rx_buf_ssw_fb0 >> 6;
            u32 r10 = fwsh_n_sets;                     /* 0x857800-0xc4 */
            u32 r8 = rx_buf_ssw_fb0 & 0x3fu;
            if (r10 >= 2) {
                u32 r0c = (rf_chain_word >> 8) & 0x7fffu;
                u32 r11 = fwsh_set_ranges + r0c * 2;      /* add1 = +r0*2 */
                r8 = (u32)(s8)(u8)(r8 + *(u8 *)r11);       /* add + extb */
            }
            a->fb_sector = (u8)r8;
            a->snr = cfg->fb[1];                /* SNR report; ldb.x */
            continue;
        } else {
            /* первый проход уже был: обновлять только при совпадении полей. */
            if (((u8 *)a->peer_mac)[0] != cfg->ta.b[0]) continue;
            if (((u8 *)a->peer_mac)[1] != cfg->ta.b[1]) continue;
            if (((u8 *)a->peer_mac)[2] != cfg->ta.b[2]) continue;
            if (((u8 *)a->peer_mac)[3] != cfg->ta.b[3]) continue;
            if (((u8 *)a->peer_mac)[4] != cfg->ta.b[4]) continue;
            if (((u8 *)a->peer_mac)[5] != cfg->ta.b[5]) continue;
            if (a->rx_metric >= (s32)r0b) continue; /* brge */
            a->rx_metric = (s32)r0b;
            a->rx_antenna = rx_buf_bcn_ssw & 3u;
            a->rx_sector = rx_buf_ssw >> 10;
            continue;
        }
    }
}

void mac_q_tx_ppdu(struct tx_ctx_s *a, u32 b)
{
    if (a->flags & 2) {                  /* btst_s r0,0x1 — бит 1 */
        u32 r15 = a->x20;
        u32 r13 = a->qid;
        u32 r16 = a->sta;
        if (r15 == 0 && macq_probe_empty(r13) == 0)
            uc_assert((u32)__builtin_return_address(0), 0x7);
        if (*(volatile u32 *)HW_TX_ENGINE_STATE & 0xf)
            uc_assert((u32)__builtin_return_address(0), 0x3);
        uc_mac_cmd(0x1c000006);
        uc_mac_cmd((b << 12) | (r13 << 4) | (r15 | 0x46000008));
        uc_stats.macq_ppdu += 1;
        while (!(mac_bap_if() & MAC_BAP_REL_DONE))
            ;
        u32 r0 = mac_sel_shadow & 0xfff0ffff;
        mac_sel_shadow = r0 | (1u << 16);
        uc_mac_cmd(r0 | 0x1d010000);
        arc_nops(3);
        while (mac_txctl_sel() & MAC_CNT_IF_BUSY)
            ;
        uc_mac_cmd(r13 | (r16 << 8) | (1u << 26) | (1u << 30) | (1u << 19) | (1u << 21));
        uc_mac_cmd(0x45000001);
        uc_mac_cmd(0x460001f1);
        mac_program_tx_with_qid(a->qid);
        while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
            ;
        { u32 _r51 = mac_mtp_desc(); mtp_desc_lo = _r51 & 0xf; mtp_desc_hi = _r51 >> 4; }
        while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
            ;
    }
    a->flags &= ~7u;
}

void mac_q_tx_ppdu_3009(struct tx_ctx_s *a)
{
    /* 6.2 asm 0x921760. */
    u32 r13 = a->qid;
    u32 r14 = a->sta;
    if (*(volatile u32 *)HW_TX_ENGINE_STATE & 0xf)
        uc_assert((u32)__builtin_return_address(0), 0x3);
    uc_mac_cmd(0x1c000006);
    uc_mac_cmd((r13 << 4) | 0x46003009);
    uc_stats.macq_ppdu += 1;
    while (!(mac_bap_if() & MAC_BAP_REL_DONE))
        ;
    u32 g = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = g | (1u << 16);
    uc_mac_cmd(g | 0x1d010000);
    arc_nops(3);
    while (mac_txctl_sel() & MAC_CNT_IF_BUSY)
        ;
    uc_mac_cmd(r13 | (r14 << 8) | (1u << 26) | (1u << 30) | (1u << 19) | (1u << 21));
    uc_mac_cmd(0x45000001);
    uc_mac_cmd(0x460001f1);
}

void mac_q_tx_ppdu_cmd08(u32 a, u32 b) {
    /* 6.2 asm 0x93a6d8. */
    if (macq_cmd08_en == 0)
        return;
    if (*(volatile u32 *)HW_TX_ENGINE_STATE & 0xf)
        uc_assert((u32)__builtin_return_address(0), 0x3);
    uc_mac_cmd(0x1c000006);
    uc_mac_cmd((a << 4) | 0x4600400b);
    uc_stats.macq_ppdu += 1;
    while (!(mac_bap_if() & MAC_BAP_REL_DONE))
        ;
    u32 g = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = g | (1u << 16);
    uc_mac_cmd(g | 0x1d010000);
    arc_nops(3);
    while (mac_txctl_sel() & MAC_CNT_IF_BUSY)
        ;
    uc_mac_cmd(a | (b << 8) | (1u << 26) | (1u << 30) | (1u << 19) | (1u << 21));
    uc_mac_cmd(0x45000001);
    uc_mac_cmd(0x460001f1);
}



void config_brp_rf(u32 a, u32 b)
{
    /* 6.2 asm 0x925050. */
    u32 flag = ((brp_rf_cfg.sta_sel[b] >> 6) == 2) ? 1 : 0;
    u32 mask = rfca_get_rf_mask_uc();
    u32 sel = 1u << a;
    rfca_select_rf_uc((u8)sel, 0);             /* extb_s r0,r0 */
    uc_log_emit3(0x20, 0x100089c, a, sel, b);

    u32 r24 = 0, r17 = 0, r13 = 0, r14 = 0;
    u32 s14 = 0;                                /* [sp+0x14]: OR только buf[2] */
    u32 buf[3] = {0, 0, 0};
    brp_pick.selected = 0;                      /* delay-слот brhs.d — всегда */
    /* исправлено (vendor): записей в brp_rank[a] не больше разрешённых подполей маски RF (brp_rank_insert берёт только
     * их); при count больше — читались пустые записи {0,0} (подполе 0 «выбиралось»). */
    u32 navail = 0, cnt;
    for (u32 m = FWSH(fwsh_sets, brp_cfg_mask)[a]; m != 0; m &= m - 1)
        navail++;
    cnt = brp_pick.count < navail ? brp_pick.count : navail;
    if (cnt >= 1) {                             /* brhs.d r0,0x1 → цикл */
        const struct brp_rank_ent *rk = brp_rank[a];
        for (r14 = 0; r14 < cnt; r14++) {
            u32 r4 = brp_snr_cfg_enable;
            u8 trn = rk[r14].idx;               /* индекс TRN-подполя (не SNR) */
            if (r4 == 0) {
                r13 |= 1u << trn;               /* L_9251d6 → L_925130: счётчик++ */
                brp_pick.selected += 1;
                continue;
            }
            brp_select_cfg_by_snr((u32)buf, rk[0].metric, rk[r14].metric,
                                  1u << trn, brp_pick.snr_cfg, flag);
            r17 |= buf[0];
            r24 |= buf[1];
            s14 |= buf[2];
            r13 |= buf[0] | buf[1] | buf[2];    /* or_s r13,r13,(b0|b1|b2) */
            if (buf[0] | buf[1] | buf[2])
                brp_pick.selected += 1;
        }
    }
    brp_rf_cfg.last_cfg_mask = r13;
    brp_rf_cfg.cfg_cnt += 1;

    /* Faza 2 (0x92516a). */
    if (!(FWSH(fwsh_sets, brp_cfg_mask)[a] & r13))
        uc_assert((u32)__builtin_return_address(0), 0x1400);
    u32 found = 0, maxv = 0, r16 = 0, ri = 0, rj = 0;
    u8 tbl[8];
    while (ri < 0x20) {
        u32 byte_idx = ri >> 2;
        tbl[byte_idx] = 0;
        if (!((0xfu << ri) & r13)) {
            ri += 4; rj += 3;
            continue;
        }
        found |= 1u << byte_idx;
        if (brp_snr_cfg_enable == 0) {
            r16 |= ((brp_ctx.cfg >> 24) & 0x7) << rj;
            ri += 4; rj += 3;
            continue;
        }
        u32 count = 0;
        for (u32 k = ri; k < ri + 4; k++)
            if (r13 & (1u << k))
                count++;
        tbl[byte_idx] = (u8)count;
        if (maxv < count)
            maxv = count;
        ri += 4; rj += 3;
    }
    brp_cfg_max_per_grp = (u8)maxv;

    /* Faza 3 (0x9251f6). */
    u32 r19 = 0, r20 = 0, r22 = 0;
    r14 = 0;
    u32 keep = 0, off = 0;
    if (brp_snr_cfg_enable != 0) {
        for (r19 = 0; r19 < 8; r19++) {
            u8 c = tbl[r19];
            if (c >= 1) {
                if (r19 < 4) r20++;
                else r22++;
                r16 |= brp_snr_cfg_thr[0] << off;
            }
            s32 r21 = (s8)((s32)maxv - (s32)c);
            for (u32 r15 = 0; ; ) {
                if (r21 < 1)
                    break;
                if ((s32)c < 1)
                    break;
                u32 bit = 1u << (r15 + r19 * 4);
                if (!(r13 & bit)) {
                    keep |= bit;
                    r21--;
                }
                r15++;                          /* vendor: проверка после инкремента */
                if (r15 > 4)
                    uc_assert((u32)__builtin_return_address(0), 0x13fd);
            }
            off += 3;
        }
        brp_pick.keep_mask = keep;
        if (((s14 | r24 | r17) & keep) != 0)
            uc_assert((u32)__builtin_return_address(0), 0x13fc);
        r17 |= keep;
        if (r22 < r20) {
            if (r22 >= 1) {
                s32 r21v = (s32)(found & 0xf0) >> 4;
                s32 cnt = (s8)((s32)r20 - (s32)r22);
                for (u32 r15 = 0; cnt >= 1; ) {
                    if (!((r21v >> r15) & 1u)) {
                        r14 |= 1u << (r15 + 4);
                        cnt--;
                    }
                    r15++;                      /* L_92530c: инкремент, затем brhs r15,5 */
                    if (r15 >= 5)
                        uc_assert((u32)__builtin_return_address(0), 0x13fe);
                }
            }
            r19 = r14;
        } else if (r20 < r22) {
            if (r20 >= 1) {
                u32 r20m = found & 0xf;
                s32 cnt = (s8)((s32)r22 - (s32)r20);
                for (u32 r15 = 0; cnt >= 1; ) {
                    if (!(r20m & (1u << r15))) {
                        r14 |= 1u << r15;
                        cnt--;
                    }
                    r15++;                      /* L_92535a: инкремент, затем brhs r15,5 */
                    if (r15 >= 5)
                        uc_assert((u32)__builtin_return_address(0), 0x13ff);
                }
            }
            r19 = r14;
            r20 = r22;
        } else {
            r19 = r14;
            r20 = r22;
        }
    }
    brp_cfg_sel_mask = (u8)r20;

    /* Faza 4 (0x92536a). */
    u32 r15v = 0;
    for (u32 r14v = 0; r14v < 8; r14v++, r15v += 3) {
        if (!(r19 & (1u << r14v)))              /* bbit0 r19,r14 → пропуск */
            continue;
        if (r16 & (0x7u << r15v))
            uc_assert((u32)__builtin_return_address(0), 0x13fb);
        r16 |= 1u << r15v;
    }
    {
        u32 v = r16 | (1u << 28);
        if ((u16)r13 == 0)
            v = r16;
        if (r13 & 0xffff0000)
            v |= 1u << 29;
        r15v = v;
    }
    if (brp_snr_cfg_enable != 0) {
        r13 = s14;                              /* ld_s r13,[sp,0x14] */
    } else {
        u32 q = brp_ctx.cfg;
        r17 = (q & (1u << 21)) ? r13 : 0;
        r24 = ((q >> 21) & 2u) ? r13 : 0;
        r13 = ((q >> 21) & 4u) ? r13 : 0;
    }
    r16 = r15v;

    /* Faza 5 (0x9253fa). */
    if (brp_rf_cfg.enable != 0)
        brp_rf_store_cfg(a, b, brp_pick.selected);
    if (brp_rf_cfg.enable != 0)
        brp_rf_store_module_byte(b);
    u32 *tbits = brp_ctx.trn_bits[a];
    if (!(brp_rf_cfg.mask & sel)) {
        tbits[0] = 0;
        tbits[1] = 0;
        r15v = 0; r13 = 0; r24 = 0; r17 = 0;
    }
    if (FWSH(fwsh_sets, bi_hi) == 0 && popcount8(rf_modules.x4) < 2) {
        s32 s = (u8)(sta_tab[b].tx_sel >> 8);   /* lsr 8; extb_s */
        u32 m0 = (u32)(s * 0xc0);
        brp_write_reg_pair((((m0 + 0x8020) >> 3) & ~3u), tbits[0]);
        brp_write_reg_pair((((m0 + 0x8000) >> 3) & ~3u), tbits[1]);
    }
    u32 m2 = (u32)((u8)(b + 0x60) * 0xc0);      /* extb_s — байт без знака */
    brp_write_reg_pair((((m2 + 0x10020) >> 3) & ~3u), tbits[0]);
    brp_write_reg_pair((((m2 + 0x10000) >> 3) & ~3u), tbits[1]);
    struct brp_rf_regs_s *sh = &brp_rf_regs[a][b];
    sh->reg_20 = tbits[0];
    sh->reg_00 = tbits[1];
    brp_write_reg_pair((((m2 + 0x10060) >> 3) & ~3u), r17);
    sh->reg_60 = r17;
    brp_write_reg_pair((((m2 + 0x10040) >> 3) & ~3u), r24);
    sh->reg_40 = r24;
    brp_write_reg_pair((((m2 + 0x100a0) >> 3) & ~3u), r13);
    sh->reg_a0 = r13;
    brp_write_reg_pair((((m2 + 0x10080) >> 3) & ~3u), r15v);
    sh->reg_80 = r15v;
    {
        u32 g = mac_sel_shadow & 0xfff0ffff;
        mac_sel_shadow = g | (1u << 16) | (1u << 17);
        uc_mac_cmd(g | 0x1d030000);
        arc_nops(3);
    }
    while (mac_txctl_sel() & MAC_RFC_ACCESS_BUSY)
        ;

    /* Faza 6 (0x92557c). */
    if (brp_rf_cfg.override_en != 0) {
        u32 r14c, r16c, r17c, r15c;
        if (a == brp_rf_cfg.rf) {
            r14c = 0xe40c2275;
            r16c = 0xb1cca053;
            r17c = 0x30ffffff;
            r15c = 0xfbf1fbf5;
        } else {
            r14c = 0;
            r16c = 0;
            r17c = 0;
            r15c = 0;
        }
        uc_log_emit3(0x20, 0x10008cc, a, r14c, r15c);
        u32 b3 = (u32)((u8)(b + 0x60) * 0xc0);  /* extb_s; asl 6 + add1 = ×0xc0 */
        brp_write_reg_pair((((b3 + 0x10060) >> 3) & ~3u), 0);
        brp_write_reg_pair((((b3 + 0x10040) >> 3) & ~3u), r15c);
        brp_write_reg_pair((((b3 + 0x100a0) >> 3) & ~3u), r15c);
        brp_write_reg_pair((((b3 + 0x10000) >> 3) & ~3u), r14c);
        brp_write_reg_pair((((b3 + 0x10020) >> 3) & ~3u), r16c);
        brp_write_reg_pair((((b3 + 0x10080) >> 3) & ~3u), r17c);
        {
            u32 g2 = mac_sel_shadow & 0xfff0ffff;
            mac_sel_shadow = g2 | (1u << 16) | (1u << 17);
            uc_mac_cmd(g2 | 0x1d030000);
            arc_nops(3);
        }
        while (mac_txctl_sel() & MAC_RFC_ACCESS_BUSY)
            ;
    }
    rfca_select_rf_uc(mask, 0);                 /* ld_s r0,[sp,8] — как вернула rfca_get_rf_mask_uc */
}


/* Сброс 4 DMA-каналов 0x886a38/44/3c/48: 0, затем 0x40000000 (sync после каждой записи). */
static void vring_dma_ch_reset(void)
{
    *(volatile u32 *)HW_TXQ_FIFO_SM_A = 0;
    *(volatile u32 *)HW_TXQ_FIFO_SM_C = 0;
    *(volatile u32 *)HW_TXQ_FIFO_SM_B = 0;
    *(volatile u32 *)HW_TXQ_PTP_SM = 0;
    arc_sync();
    *(volatile u32 *)HW_TXQ_FIFO_SM_A = 0x40000000;
    arc_sync();
    *(volatile u32 *)HW_TXQ_FIFO_SM_C = 0x40000000;
    arc_sync();
    *(volatile u32 *)HW_TXQ_FIFO_SM_B = 0x40000000;
    arc_sync();
    *(volatile u32 *)HW_TXQ_PTP_SM = 0x40000000;
    arc_sync();
}

/* vring_disconnect_flush (6.2 asm 0x925c8c): слив очереди a / DMA-кольца b
 * перед отключением vring. Цикл, пока dma_is_tx_pipe_idle(a,b,10)==0
 * (не более 15 итераций), затем отчёт и flush. */
void vring_disconnect_flush(u32 a, u32 b, u32 c, u32 d)
{
    u32 r17 = c;
    u32 r13 = 0, r19 = 1, r16 = 0, r18 = 0, r15 = 0;
    uc_log_emit1(0x21, 0x1001b5c, a);
    dump_mac_buffer_bases(a, r17);
    struct tx_ctx_s *r20 = tx_ctx_alloc_next(1);
    r20->qid = r17;

    while (dma_is_tx_pipe_idle(a, b, 0xa) == 0) {          /* L_92600a */
        if (r16 >= 0xf)
            break;
        u32 busy = macq_is_idle(a);                          /* L_925cce */
        r16++;
        if (busy != 0 && dma_is_idle_uc(b, 1) == 0) {
            /* L_925d02: DMA-кольцо не пусто */
            r18++;
            if (r18 < 8) {
                arc_zol_nops2_shl(0x7d, 6);   /* vendor L_925e54→L_92607c: mov_s 0x7d; asl_s 6; lp × 2×nop_s */
                continue;
            }
            /* Выдержка перед L_925e52 (vendor L_925e44: mov lp_count,r0; lp × 2×nop_s): после
             * commit_rptr — 0x7d << 6 (L_925e40), после сброса PTP — 0x5dc0 (r0 из L_925da6),
             * после сброса DMA-канала — нет (b_s L_925e52). Загрузки — в своих ветвях, как у
             * vendor (иначе gcc держит константу в регистре и выдержка короче vendor). */
            if (dump_pring_hw(b) != 0) {
                vring_dbg.pring_idle_cnt += 1;
                uc_log_emit1(1, 0x1001b6c, b);
                macq_hw_commit_rptr(b);                      /* L_925e3a */
                arc_zol_nops2_shl(0x7d, 6);
            } else {
                /* L_925d32: PRING рассинхронизирован — проверить канал 0x886a48 */
                *(volatile u32 *)HW_TXQ_PTP_SM = 0x80000000;
                arc_sync();
                u32 st = *(volatile u32 *)HW_TXQ_PTP_SM & 7;
                uc_log_emit1(1, 0x1001bc4, st);
                if (st == 5) {
                    vring_dbg.ptp_reset_cnt += 1;
                    *(volatile u32 *)HW_TXQ_PTP_SM = 0;
                    arc_sync();
                    *(volatile u32 *)HW_TXQ_PTP_SM = 0x40000000;
                    arc_sync();
                    arc_zol_nops2(0x50);   /* vendor L_925d7e: lp 0x50 × 2×nop_s */
                    *(volatile u32 *)HW_TXQ_PTP_SM = 0x80000000;
                    arc_sync();
                    uc_log_emit1(1, 0x1001bf4, *(volatile u32 *)HW_TXQ_PTP_SM & 7);
                    r13++;
                    arc_zol_nops2(0x5dc0);   /* vendor mov_s r0,0x5dc0 → L_925e44: lp × 2×nop_s */
                } else if (txq_fifo_ptp_idle_snapshot() == 0) {   /* L_925db4 */
                    u32 n = ++vring_dbg.ptp_stuck_on_sm_other;
                    uc_log_emit1(1, 0x1001c38, n);
                    vring_dma_ch_reset();
                    arc_zol_nops2(0x5dc0);   /* vendor L_925e0c: lp 0x5dc0 × 2×nop_s */
                    r13++;
                } else {                                     /* L_925e24 */
                    vring_dbg.pring_idle_ptp_cnt += 1;
                    uc_log_emit2(1, 0x1001c84, b, r13);
                    macq_hw_commit_rptr(b);
                    arc_zol_nops2_shl(0x7d, 6);
                }
            }
            r15 = 1;                                         /* L_925e52 */
            arc_zol_nops2_shl(0x7d, 6);   /* vendor L_925e54 (mov_s 0x7d; b.d; asl_s 6) → L_92607c: lp × 2×nop_s */
            continue;
        }

        /* L_925cec */
        if (macq_is_idle(a) == 0) {
            /* L_925e5c: очередь пуста — перепрограммировать MAC-очередь */
            if (*(volatile u32 *)HW_TX_ENGINE_STATE & 0xf)
                uc_assert((u32)__builtin_return_address(0), 3);
            uc_mac_cmd(0x1c000006);
            uc_mac_cmd((r17 << 4) | (r19 << 3) | 0x46000003u | (1u << 14));
            uc_stats.macq_ppdu += 1;
            while (!(mac_bap_if() & MAC_BAP_REL_DONE))
                ;
            u32 g = mac_sel_shadow & 0xfff0ffffu;
            mac_sel_shadow = g | (1u << 16);
            uc_mac_cmd(g | 0x1d010000u);
            arc_nops(3);
            while (mac_txctl_sel() & MAC_CNT_IF_BUSY)
                ;
            uc_mac_cmd((d << 8) | r17 | (1u << 19) | (1u << 21) | (1u << 26) | (1u << 30));
            uc_mac_cmd(0x45000001);
            uc_mac_cmd(0x460001f1);
            mac_program_tx_with_qid(r20->qid);
            while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
                ;
            u32 v = mac_mtp_desc();
            mtp_desc_lo = v & 0xf;
            mtp_desc_hi = v >> 4;
            while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
                ;
            for (u32 k = 0; k < 10; k++) {
                arc_zol_nops2(800);   /* vendor L_925f4c: lp 0x320 × 2×nop_s */
                u32 s0 = macq_hw_read_state0(b);
                if (s0 == macq_hw_read_state1(b))
                    break;
            }
            r19 = 0;
            continue;
        }
        if (r13 == 0) {                                      /* L_926078 */
            arc_zol_nops2(800);   /* vendor L_926078: lp 0x320 × 2×nop_s */
            continue;
        }
        while (txq_fifo_ptp_idle_snapshot() == 0) {          /* L_926002 */
            vring_dma_ch_reset();                            /* L_925f78 */
            r13++;
            vring_dbg.dma_ch_reset_cnt += 1;
            dump_pring_hw(b);
            uc_mac_cmd(r13);
            uc_mac_cmd(0xff22);
        }
    }

    /* L_92601a */
    if (r16 >= 0xf)
        uc_assert((u32)__builtin_return_address(0), 0x158f);
    if (vring_dbg.max_flush_tries < r16)
        vring_dbg.max_flush_tries = (u8)r16;
    u32 r13b = vring_dbg.flush_wa_cnt;
    if (r15 != 0)
        vring_dbg.flush_wa_cnt = ++r13b;
    uc_log_emit3(0x11, 0x1001cec, r16, vring_dbg.max_flush_tries, r13b);
    dump_mac_buffer_bases(a, r17);
    macq_flush_queue(a, b, r17);
    uc_log_emit_snapshot(0x11, 0x1001d2c);
    dump_mac_buffer_bases(a, r17);
}

void direct_tx_step(struct sls_peer_rec *a)
{
    UC_PAD(PAD_SSWFB_ABFT);
    u32 r9 = rf_chain_cfg;
    u8 r10 = a->fb_sector;
    mac_program_rx_window(1, r9 | 0x30 | (r10 << 8), 0);
    uc_mac_cmd(0x15000000);
    uc_mac_cmd(0x14000007);

    u32 buf[6];
    direct_tx_build_desc(a, buf);
    direct_tx_program_cmd34(0x10, 0x18);
    mac_program_tx_common();
    uc_mac_cmd(0x2008000);

    if (txrx_state1 & 0x10) {
        u32 flag = (mtp_desc_lo & 2u) ? 1 : 0;   /* bic r,r,-3 == & 2 */
        uc_mac_cmd((flag << 6) | 0x19800830 | (mtp_desc_hi << 14));
    } else {
        uc_mac_cmd(0x19000001);
    }
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    if (txrx_state1 & 0x10)
        uc_mac_cmd(0x18000000);
    else
        uc_mac_cmd(0x18001000);

    tx_fifo_write_bytes((u32)buf, 0xa);
    tx_fifo_free -= 6;
    uc_mac_cmd(0x33000443);
    uc_wait_direct_tx_ready();
    uc_fifo_frame_tail((u32)buf);              /* vendor: байты 0x10..0x17 в FIFO (r34/r33) */
    direct_tx_issue_cmd_33();
    mac_evt_enable_bit_sync_b(6);
    mac_set_rf_chain_state_with_sta_sector();
    uc_spin_until_event(MAC_EVT1_TX_END);
}

void l1_fixed_sched_ap_sm(u32 a) {
    /* 6.2 asm 0x92c66c. Состояние — значение аргумента; таблица 0x8017e0 по (r14 - 1):
     * 1 → 0x92c694, 2 → 0x92c6d0, 3 → assert, 4 → 0x92c710, 5 → 0x92c77c.
     * Следующее состояние после вызова помощника — его возврат (L_92c76c: r14 = r0). */
    volatile u32 *st = &fsched_ctx.state;
    u32 r14 = a;
    u32 r13 = 1;
    for (;;) {
        fsched_log_phase(r14, 0);
        switch (r14) {
        case 1:
            r13 = 0;
            peer_masks_apply_op(&pm_ctx, 1, 0);
            if (*st == 4 || *st == 7) {
                fsched_log[fsched_log_idx].step = 9;
                fsched_ctx.engaged = 1;
            }
            *st = 0;
            fsched_ctx.slot_cnt = 0;
            r14 = 0;
            break;
        case 2:
            if (*st == 1) {
                fsched_ctx.rx_slot_active = 1;
                rx_flow_run_and_check_bf_abort(1);
                fsched_ctx.rx_slot_active = 0;
                r13 = 0; r14 = 0;
            } else if (*st == 6) {
                r14 = fsched_rx_slot();
                r13 = 0;
            } else {
                fsched_log[fsched_log_idx].step = 0xf;
                fsched_ctx.rx_slot_active = 0;
                rx_flow_run_and_check_bf_abort(fsched_log_idx);
                r13 = 0; r14 = 0;
            }
            break;
        case 4:
            r14 = 4;
            if (rx_on_state == 0) {                  /* ldw_s [gp,148] */
                fsched_log[fsched_log_idx].step = 0xa;
                r13 = 0;
                sxd_hal_write_qset_field(0, 0x9ab);
                r14 = 0;
                break;
            }
            switch (*st) {
            case 2: r14 = l1_fixed_sched_ap_ev4_state2(2); r13 = 0; break;
            case 4: r14 = l1_fixed_sched_ap_ev4_state4(4); r13 = 0; break;
            case 0: r14 = fsched_arm_slot_from_cfg(); r13 = 0; break;
            case 1:
                if (fsched_ctx.engaged != 0) {
                    *st = 4;
                    fsched_ctx.engaged = 0;
                } else {
                    *st = 2;
                }
                r14 = 4; r13 = 0;
                break;
            case 6:
                *st = 2;
                r14 = l1_fixed_sched_ap_ev4_state2(2); r13 = 0;
                break;
            case 7:
                fsched_run_tx_slot_twice();
                r14 = 0; r13 = 0;                          /* возврат fsched_run_tx_slot_twice = 0 */
                break;
            default:
                break;                                     /* r13 прежний → assert */
            }
            break;
        case 5:
            r14 = 5;
            if (rx_on_state == 0) {
                r13 = 0;
                sxd_hal_write_qset_field(0, 0x9ab);
                r14 = 0;
            } else if (*st == 5) {
                r14 = fsched_ap_start_slot();
                r13 = 0;
            }
            break;
        default:
            break;                                         /* 3 и вне диапазона → assert */
        }
        /* L_92c7a6 */
        if (r13 != 0) {
            uc_log_emit2(0, 0x10007b8, r14, *st);
            uc_assert((u32)__builtin_return_address(0), 0x1578);
        } else {
            r13 = 1;
        }
        u32 c = (u8)(fsched_log_idx + 1);
        fsched_log_idx = (u8)c;
        if (!((s32)c < 0x10))
            fsched_log_idx = 0;
        if (r14 == 0)
            return;
    }
}


void l1_fixed_sched_sta_sm(u32 a) {
    /* 6.2 asm 0x92c840. Состояние — значение аргумента; таблица 0x8017e8 по (r13 - 1):
     * 1 → 0x92c86c, 2 → 0x92c872, 3 → 0x92c8cc, 4 → 0x92c8e2. r15 = «ошибка» (assert). */
    volatile u32 *st = &fsched_ctx.state;
    u32 r13 = a;
    u32 r15 = 1;
    for (;;) {
        fsched_log_phase(r13, 0);
        u32 idx;
        switch (r13) {
        case 1:
            r15 = 0;
            *st = 0;
            r13 = r15;
            break;
        case 2:
            if (*st == 2) {
                fsched_ctx.rx_slot_active = 1;                    /* слот bl.d */
                idx = rx_flow_run_and_check_bf_abort(1);
                fsched_ctx.rx_slot_active = 0;
            } else {
                fsched_ctx.rx_slot_active = 0;
                fsched_log[fsched_log_idx].step = 0xf;
                idx = rx_flow_run_and_check_bf_abort(fsched_log_idx);
            }
            if (idx != 2) {
                r13 = 0;
                r15 = 0;
            } else {
                *st = 4;
                fsched_log[fsched_log_idx].step = 1;
                uc_mac_cmd(0x20d2800);
                r15 = 0;
                r13 = 3;
            }
            break;
        case 3:
            r13 = 3;
            if (*st == 4) {
                r15 = 0;
                delay_800_iters();
                r13 = 0;                                /* возврат delay_800_iters = 0 */
                *st = 2;
            }
            break;
        case 4:
            r13 = 4;
            if (*st == 0) {
                r15 = 0;
                u32 v = get_mem_857744_x2();
                sxd_hal_write_qset_field(0, (v - 200) * 165);
                *st = 1;
                r13 = r15;
            } else if (*st == 1 || *st == 2) {
                r15 = 0;
                *st = 2;
                r13 = r15;
            }
            break;
        default:
            break;
        }
        /* L_92c91a */
        if (r15 != 0) {
            uc_log_emit2(0, 0x10007f4, r13, *st);
            uc_assert((u32)__builtin_return_address(0), 0x1579);
        } else {
            r15 = 1;
        }
        u32 c = (u8)(fsched_log_idx + 1);              /* [gp,-238] */
        fsched_log_idx = (u8)c;
        if (!((s32)c < 0x10))
            fsched_log_idx = 0;
        uc_mac_cmd(dti_qset_mode | (1u << 22) | (1u << 23) | (r13 << 4) | (1u << 31));
        if (r13 == 0)
            return;
    }
}


u32 l1_fixed_sched_ap_ev4_state2(u32 a) {
    /* 6.2 asm 0x935e74. */
    (void)a;
    qh_write_while_dma_open_check(0);
    fixed_sched_read_slot_id(&fsched_peers);
    u32 sp_buf[4];                            /* vendor: кадр 16 Б, буфер sp+4..sp+0xc */
    u32 r0 = fsched_pick_ready_queue((u32)&sp_buf[1]);
    if (r0 != 0) {
        mac_set_sector_arg_and_select_all(0xbb8);
        tx_non_data_flow_fixed_scheduling(sp_buf[1]);
        fsched_log[fsched_log_idx].step = 4;
        fsched_arm_slot_timer(0xf);
        return 0;
    }
    if (fsched_ap_next_station(&fsched_peers) != 0) {
        u32 r17 = fsched_time_left_class(1);
        if (r17 == 2) {
            fsched_log[fsched_log_idx].step = 7;
            fsched_ctx.state = 0;
            return 0;
        }
        u8 r15 = fsched_get_cur_idx(&fsched_peers);
        u32 sp0 = fsched_cur_entry_byte0(&fsched_peers);
        fsched_cur_entry_byte1(&fsched_peers);
        u8 r13v = (u8)r15;
        fsched_log[fsched_log_idx].arg = r15;
        if (fsched_test_mask2c_bit(&fsched_peers, r13v) != 0) {
            sends_pmc_mark_aaab20(r15);
            fsched_bf_req_clear(&fsched_peers, r13v);
            fsched_arm_slot_timer(0xf);
            return 0;
        }
        u32 *r13 = &fsched_ctx.state;
        fsched_ctx.slot_cnt += 1;
        rx_cfg_select_sta(r15);
        fsched_slot_inc_f2(&fsched_peers);
        u32 r18 = vring_is_empty_uc_quiet(sp0);
        u32 r0b = fsched_ap_station_done(&fsched_peers);
        if (r18 != 0 || r0b != 0) {
            fsched_log[fsched_log_idx].step = 8;
            fsched_slot_clear_f2(&fsched_peers);
            *r13 = 5;
            if (r18 != 0) {
                u32 mask = 1u << r15;
                if (FWSH(ll_ctx, fsched_flush_mask) & mask) {
                    u8 *p = &fsched_ctx.flush_cnt[r15];
                    u8 c = (u8)*p;
                    if (c >= 1) {
                        c = (u8)(c + 1);
                        *p = (u8)c;
                        if (c >= fsched_ctx.max_cnt)
                            FWSH(ll_ctx, fsched_flush_over) |= mask;
                    }
                }
            }
            return 5;
        }
        u32 hw = macq_read_hw_queue_word(sp0);
        fsched_flush_stats.qword_start = hw;
        fixed_sched_check_slot_flag(&fsched_peers);
        fsched_ctx.slot_start_tsf = uc_read_tsf_lo();
        sxd_hal_write_qset_field(0, fsched_slot_byte0(&fsched_peers) * 0xa5);
        *r13 = (r17 == 1) ? 7 : 4;                       /* cmp 1; mov 7; mov.ne 4 */
        return 0;
    }
    if (fsched_time_left_class(0) == 2) {
        fsched_log[fsched_log_idx].step = 7;
        fsched_ctx.state = 0;
        return 0;
    }
    fsched_log[fsched_log_idx].step = 5;
    mac_set_sector_arg_and_select_all(0xbb8);
    fixed_sched_run_tx_slot();
    return fsched_arm_slot_timer(get_mem_857744_x2_928308());   /* r0 = возврат get_mem */
}


u32 l1_fixed_sched_ap_ev4_state4(u32 a) {
    /* 6.2 asm 0x938880. */
    (void)a;
    u32 sp_buf[3];
    mac_read_tsf64_uc(&sp_buf[1]);
    u8 r15 = fsched_get_cur_idx(&fsched_peers);
    fsched_ap_poll_station(&fsched_peers);
    fsched_log[fsched_log_idx].arg = r15;
    u16 r16 = fsched_slot_half4(&fsched_peers);
    mac_set_sector_arg_and_select_all(r16);
    fsched_ap_copy_slot_byte1(&fsched_peers);
    fixed_sched_run_tx_slot();
    fsched_flush_stats.slots += 1;
    u32 sp0 = fsched_cur_entry_byte0(&fsched_peers);
    if (fsched_peers.slot_kicked != 0)
        fixed_sched_slot_setup(&fsched_peers);
    u32 r17;
    for (;;) {
        if (dma_is_tx_pipe_idle(sp0, 0, 0xf) != 0) {
            r17 = 0;
            break;
        }
        u32 d = (u32)bi_tsf_delta64(sp_buf[1], sp_buf[2]);
        if (d >= (u32)r16 - 100) {             /* sub2 r0,r16,0x19 = r16 - (0x19 << 2) */
            r16 = 1;
            mac_select_rf_module_cmd31(0, sp0);
            r17 = r16;
            break;
        }
        mac_set_sector_arg_and_select_all(r16 - d);
        fixed_sched_run_tx_slot();
    }
    u32 hw = macq_read_hw_queue_word(sp0);
    fsched_flush_stats.qword_end = (u16)hw;
    u32 r16v = (u32)(u16)((u16)hw - fsched_flush_stats.qword_start);
    fsched_flush_stats.sum_sent += (u16)r16v;
    if (r17 != 0) {
        u8 b0 = fsched_cur_entry_byte0(&fsched_peers);
        qid_agg_mask |= 1u << b0;
        fsched_flush_stats.last_sent = (u16)r16v;           /* stw [0x800814,8] */
        fsched_log[fsched_log_idx].step = 0xb;
        u16 qw = fsched_flush_stats.qword_end;
        vring_disconnect_flush(sp0, 0, sp0, r15);
        u32 hw2 = macq_read_hw_queue_word(sp0);
        fsched_flush_stats.flushes += 1;
        u16 d2 = (u16)((u16)hw2 - qw);
        fsched_flush_stats.last_flushed = (u16)d2;
        fsched_flush_stats.sum_flushed += (u16)d2;
        if (r16v == 0) {
            u32 mask = 1u << r15;
            FWSH(ll_ctx, fsched_flush_mask) |= mask;
            u8 *p = &fsched_ctx.flush_cnt[r15];
            u8 c = (u8)(*p + 1);
            *p = (u8)c;
            if (c >= fsched_ctx.max_cnt)
                FWSH(ll_ctx, fsched_flush_over) |= mask;
        } else {
            fsched_drop_station(r15);
        }
    } else {
        fsched_drop_station(r15);
        fixed_sched_slot_prepare(sp0);
    }
    u32 tsf = uc_read_tsf_lo();
    fsched_ctx.slot_end_tsf = tsf;
    u32 r2 = fsched_ctx.slot_start_tsf;
    u32 d = (tsf > r2) ? (tsf - r2) : (tsf + (0xffffffff - r2));
    /* fwsh_sets.fsched_airtime[r15] (0x857748). Запись — целым адресом (FWSH_AT): с индексом gcc даёт
     * ld.aw [r13,0x857748] вместо (r15 + 0x215dd2) << 2 — код меняется (codecmp). */
    FWSH_AT(fwsh_sets, fsched_airtime, r15) += d;
    return fsched_arm_slot_timer(0);
}


void tx_bcast_flow(u32 a) {
    /* 6.2 asm 0x937844. */
    (void)a;
    txrx_state1 = 2;
    u32 r1 = bcast.x0c;
    txrx_state2 = 0;
    if (r1 == 0) {
        r1 = maint_sta_mask;
        bcast.x0c = r1;
    }
    u32 n;
    n = arc_norm(r1);
    u32 r15 = 0x1e - n;
    u32 v0;
    if (r1 == 0) {
        v0 = 1;
    } else {
        v0 = (sta_tab[r15].tx_sel >> 8) & 0x7fff;   /* bmsk_s 0xe */
    }
    bcast.rx_sector = v0;
    if (macq_probe_empty(fsched_peer_id) == 0) {
        bcast.x0c = 0;
        tx_bcast_desc_id = 0;
        struct tx_ctx_s *ctx = tx_ctx_alloc_next(1);
        ctx->qid = fsched_peer_id;
        mac_program_tx_with_qid(fsched_peer_id);
        while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
            ;
        u32 r51 = mac_mtp_desc();
        mtp_desc_lo = r51 & 0xf;
        mtp_desc_hi = r51 >> 4;
        while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
            ;
        uc_log_emit_snapshot(0x21, 0x1001a6c);
        return;
    }
    u32 g1 = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = g1 | (1u << 19);
    uc_mac_cmd(g1 | 0x1d080000);
    arc_nops(3);
    while (!(mac_txctl_sel() & MAC_MTP_AGG_VALID))
        ;
    u32 r13v = (u32)(u16)mac_txctl_sel();
    u32 g2 = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = g2 | (1u << 13) | (1u << 15);
    uc_mac_cmd(g2 | 0x1d00a000);
    mac_select_all_sectors_and_wait();
    mac_cmd_29000001();
    if (!mac_cca_ok()) {
        while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
            ;
        uc_mac_cmd(0x29000002);
        bcast.cca_fail += 1;
        txrx_state2 = 0x800;
        return;
    }
    mac_program_rx_window(5, (rf_chain_cfg | 0x30) | (bcast.rx_sector << 8), 0);
    r13v = (r13v + 3) | (1u << 24) | (1u << 26) | (1u << 28);
    uc_mac_cmd(r13v);
    uc_mac_cmd(0x14000007);
    direct_tx_program_cmd34(0x10, 0x10);
    mac_program_tx_with_rate(0);
    while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
        ;
    u32 r51b = mac_mtp_desc();
    mtp_desc_lo = r51b & 0xf;
    mtp_desc_hi = r51b >> 4;
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    uc_mac_cmd(0x18001000);
    direct_tx_send_after_delay(r15, 6, 5);
    uc_mac_cmd(0x2008000);
    uc_mac_cmd(0x19000001);
    mac_evt_enable_bit_sync_b(6);
    if (sta_tab[SPARRAW_PEER_UNKNOWN].key_valid != 0) {
        mac_load_tx_key((const u32 *)sta_tab[SPARRAW_PEER_UNKNOWN].tx_key);
        tx_flow_arm_88606c_0x102();
    }
    uc_spin_until_event(MAC_EVT1_TX_END);
    uc_wait_one_event(6);
    /* СРОК: широковещательные данные (0x19000001 ниже) через SIFS (3 мкс, допуск −0/+0.49 мкс)
     * после CTS-to-self (802.11-2020 10.3.2.3.3, 10.23.2.8). Путь от выхода из ожидания
     * события 6 (конец CTS-to-self, точный смысл события не установлен): 0x14000000, запрос MTP
     * (0x1b/0x16/0x17 + 3 nop), r43, mac_program_rx_window(1), 0x2008000 → 0x19000001
     * ~109 инструкций + ответ MTP (vendor ~ так же); запас: десятки–сотни тактов (не измерен).
     * Срыв: пауза > SIFS — среду может занять сосед, NAV из CTS-to-self (r47-длительность + 3)
     * кончится раньше конца данных. */
    bcast.tx1 += 1;
    uc_mac_cmd(0x14000000);
    u32 r13b = (fsched_peer_id << 16) | 1u;
    uc_mac_cmd(0x1b001111);
    r13b |= (1u << 25) | (1u << 26) | (1u << 28);
    uc_mac_cmd(r13b);
    uc_mac_cmd(0x17000000);
    arc_nops(3);
    while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
        ;
    u32 r51c = mac_mtp_desc();
    mtp_desc_lo = r51c & 0xf;
    mtp_desc_hi = r51c >> 4;
    u32 r2 = MAC_MTP_RESP_MCS_OF(mac_mtp_resp());
    if (r2 == 0)
        r2 = 1;
    mac_program_rx_window(1, (rf_chain_cfg | 0x30) | (bcast.rx_sector << 8), r2);
    uc_mac_cmd(0x2008000);
    uc_mac_cmd(0x19000001);
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    uc_mac_cmd(0x18001000);
    mac_evt_enable_bit_sync_b(6);
    bcast.tx2 += 1;
    mac_set_rf_chain_state(1, rf_chain_word);
    uc_spin_until_event(MAC_EVT1_TX_END);
    bcast.tx_end += 1;
    uc_wait_one_event(6);
    u32 v = (abif_dvs_rf_ctrl_shadow & ~(1u << 24) & ~(1u << 25)) | (rf_set_rx << 24);
    abif_dvs_rf_ctrl_shadow = v;
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = v;
    tx_rx_flow_ran = 1;
    u32 m = bcast.x0c & ~(1u << r15);
    bcast.x0c = m;
    if (m != 0) {
        if (tx_bcast_desc_id == 0) {                 /* ldw_s [gp,136] */
            u32 sp_buf[4];
            qh_read_desc_window((u32)sp_buf, fsched_peer_id, 2, 0, 1);   /* r4 = r13 = 1 */
            tx_bcast_desc_id = (sp_buf[2] >> 12) & 0xfff;               /* bmsk 0xb; sth.as [gp,68] */
        }
        u32 d = macq_desc_read_uc(tx_bcast_desc_id, 0);
        macq_desc_write_uc(tx_bcast_desc_id, d | (1u << 19));
        return;
    }
    tx_bcast_desc_id = 0;
    struct tx_ctx_s *ctx2 = tx_ctx_alloc_next(1);
    ctx2->qid = fsched_peer_id;
    if (macq_probe_empty(fsched_peer_id) == 0)
        uc_assert((u32)__builtin_return_address(0), 7);
    if (*(volatile u32 *)HW_TX_ENGINE_STATE & 0xf)
        uc_assert((u32)__builtin_return_address(0), 3);
    uc_mac_cmd(0x1c000006);
    uc_mac_cmd((fsched_peer_id << 4) | 0x46000008);
    uc_stats.macq_ppdu += 1;
    while (!(mac_bap_if() & MAC_BAP_REL_DONE))
        ;
    u32 g3 = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = g3 | (1u << 16);
    uc_mac_cmd(g3 | 0x1d010000);
    arc_nops(3);
    while (mac_txctl_sel() & MAC_CNT_IF_BUSY)
        ;
    uc_mac_cmd(fsched_peer_id | 0x44280800);
    uc_mac_cmd(0x45000001);
    uc_mac_cmd(0x460001f1);
    mac_program_tx_with_qid(ctx2->qid);
    while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
        ;
    u32 r51d = mac_mtp_desc();
    mtp_desc_lo = r51d & 0xf;
    mtp_desc_hi = r51d >> 4;
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    bcast.done += 1;
}


u32 cf_end_send_frame(struct tx_ctx_s *a, u32 b, u32 c, u32 d, u32 e) {
    /* 6.2 asm 0x938568. */
    direct_tx_program_cmd34(0x10, 0x10);
    mac_program_tx_with_rate(b);
    *(u32 *)e = b;
    while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
        ;
    u32 r51 = mac_mtp_desc();
    mtp_desc_lo = r51 & 0xf;
    mtp_desc_hi = r51 >> 4;
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    if (d != 0)
        uc_mac_cmd(0x18000000);
    direct_tx_send_after_delay(a->sta, c, 0);
    return (((u8)mac_mtp_perm() & a->ack_mask) == 0) ? 1 : 0;
}


void tx_initiator_flow_fixed_scheduling(u32 a) {
    /* 6.2 asm 0x938f10. */
    (void)a;
    struct tx_ctx_s *r13 = tx_ctx_alloc_next(1);
    u32 sp_buf[4];                            /* vendor: кадр 16 Б, буфер sp+4..sp+0xc */
    u32 r1 = fsched_pick_queue_r41((u32)sp_buf);
    if (uc_role_ap == 0 && r1 == 0 && fsched_ctx.state == 4) {   /* ld_s [gp,0x124] — байты */
        u32 g = mac_sel_shadow & 0xffff0fff;
        mac_sel_shadow = g | (1u << 12) | (1u << 13);
        uc_mac_cmd(g | 0x1d003000);
        arc_nops(3);
        u32 r0 = (u32)(u16)mac_status_sel();
        if (r0 > 0xb)
            tx_cca_check_and_send(r13, 1, 0, 1);
        txr.awaiting = 1;
        fsched_log[fsched_log_idx].step = 2;
        return;
    }
    if (r1 != 0) {
        uc_log_emit_snapshot(0x21, 0x1001808);
        mac_select_all_sectors_and_wait();
        if (mac_evt1() & MAC_EVT1_BUSY2) {
            uc_stats.txop_fail = uc_stats.txop_fail + 1;
            txrx_state2 = 0x800;
            mac_mon_report.fs_evt14_cnt = mac_mon_report.fs_evt14_cnt + 1;
            fsched_log[fsched_log_idx].step = 0xc;
            uc_log_emit_snapshot(0x21, 0x1001738);
            return;
        }
        u32 r1v = sp_buf[0];
        r13->qid = r1v;
        r13->flags |= 1u;
        if (qid_agg_mask & (1u << r1v))
            txrx_state2 |= 1u << 30;
        u32 r1b = r13->qid;
        if (r1b == 0x1f) {
            uc_mac_cmd(0x80 | (1u << 25));
            fsched_log[fsched_log_idx].step = 0xd;
            uc_log_emit_snapshot(0x21, 0x1001874);
            uc_mac_cmd(0xeeee03);
            internal_tx_isr();
            uc_mac_cmd(mac_evt_en_shadow | 0x27003f00);
            mac_mon_report.fs_no_slot_cnt = mac_mon_report.fs_no_slot_cnt + 1;
            return;
        }
        if (r1b == fsched_peer_id && fsched_peer_id != 0xff) {
            fsched_log[fsched_log_idx].step = 0xe;
            uc_log_emit_snapshot(0x21, 0x1001840);
            tx_bcast_flow(0);
            return;
        }
        u32 spc = 0;
        u8 sv = sta_get_sweep_byte((u8)sp_buf[0], (u32)&spc);
        struct sta_entry *r0 = &sta_tab[sv];
        if (r0->key_valid != 0 && (r0->qid_mask_q6 & (1u << sp_buf[0])))   /* bbit0 → пропуск */
            r13->flags |= 1u << 11;
        tx_sta_run_txop(r13);
        return;
    }
    uc_stats.tx_no_queue = uc_stats.tx_no_queue + 1;
    fsched_log[fsched_log_idx].step = 3;
    uc_mac_cmd(0xeeee01);
}


void tx_non_data_flow_fixed_scheduling(u32 a) {
    /* 6.2 asm 0x939594. */
    u32 r14 = a;
    uc_mac_cmd(0x14000100);
    struct tx_ctx_s *r13 = tx_ctx_alloc_next(1);
    mac_select_all_sectors_and_wait();
    if (mac_evt1() & MAC_EVT1_BUSY2) {
        uc_stats.txop_fail = uc_stats.txop_fail + 1;
        txrx_state2 = 0x800;
        mac_mon_report.fs_evt14_cnt = mac_mon_report.fs_evt14_cnt + 1;
        uc_log_emit_snapshot(0x21, 0x1001738);
        return;
    }
    r13->qid = r14;
    r13->flags |= 1u;
    if (r14 == 0x1f) {
        uc_mac_cmd(0x80 | (1u << 25));
        uc_log_emit_snapshot(0x21, 0x10017cc);
        uc_mac_cmd(0xeeee03);
        internal_tx_isr();
        uc_mac_cmd(mac_evt_en_shadow | 0x27003f00);
        mac_mon_report.fs_no_slot_cnt = mac_mon_report.fs_no_slot_cnt + 1;
        return;
    }
    if (r14 == fsched_peer_id && fsched_peer_id != 0xff) {
        uc_log_emit_snapshot(0x21, 0x1001798);
        tx_bcast_flow(0);
        return;
    }
    tx_sta_run_txop(r13);
    if (!(txrx_state2 & (1u << 9)))
        uc_mac_cmd(0x14000100);
    mac_set_mode_0000();
    txrx_state1 = 0;
    txrx_state2 = 0;
    tx_ctx_pool.slot[0].flags = 0;
    tx_ctx_pool.slot[1].flags = 0;
}


u32 tx_flow_substep(struct tx_ctx_s *a) {
    /* 6.2 asm 0x92fbc0. */
    /* PER = fail_cnt / tx_cnt текущего MCS против порогов rs_cfg (в %). */
    u32 sta = *(u8 *)&a->sta;
    struct rs_sta_stats *rs = &rs_stats[sta];
    const struct rs_sta_cfg *cfg = &rs_cfg[sta];
    struct rs_sta_state *st = &rs_state[sta];
    u8 mcs = rs->mcs_try;
    rs->mcs_meas = mcs;
    u8 tx = rs->tx_cnt[mcs];
    if (tx < cfg->min_frame_cnt[mcs])
        return st->phase;
    if (mcs == 1) {
        s32 m0 = (u8)cfg->mcs1_fail_th * (u8)rs->tx_cnt[1];
        s32 m1 = (u8)rs->fail_cnt[1] * 100;
        if (m0 < m1) {
            st->phase = 2;
            return 2;
        }
    }
    u8 r7 = rs->mcs_try;
    u32 n;
    n = arc_norm(rs_cfg_mcs_en(cfg));
    u32 top = 0x1e - n;                         /* старший разрешённый MCS */
    u8 per_th = (top == r7) ? cfg->per_threshold[mcs] : cfg->stop_th;
    u32 fail100 = rs->fail_cnt[mcs] * 100;
    s32 m2 = (u8)per_th * (u8)tx;
    if (m2 < (s32)fail100) {
        rate_search_commit_mcs(a);
        st->phase = 3;
        rs_pending_mask |= 1u << sta;
        return 3;
    }
    s32 m3 = (u8)cfg->per_threshold[mcs] * (u8)tx;
    u32 flag = ((s32)fail100 <= m3) ? 1 : 0;
    u32 r0 = rate_search_reset_stats(a, flag);
    if (r0 == 1) {
        st->phase = 5;
        rs_pending_mask |= 1u << sta;
        return 5;
    }
    if (rs->mcs_try == 0xa)
        st->active = 2;
    return st->phase;
}


void tx_mtp_queue_gate(u32 a) {
    /* 6.2 asm 0x939aa4. */
    (void)a;
    struct tx_ctx_s *r13 = tx_ctx_pool.cur;
    u32 c = 0;                                    /* r2: 1, если бит станции в 0x800564 */
    if (txop_qid_mask & (1u << r13->qid)) {
        r13->resp_ctx8 = rx_resp_ctx8;
        c = 1;
    }
    u32 sp_buf[4];                            /* vendor: кадр 16 Б, буфер sp+4..sp+0xc */
    u32 flag = (txrx_state2 & 0x40000000u) ? 1 : 0;
    u32 r0 = mtp_queue_release_mgmt(r13, (u32)&sp_buf[1], c, flag);
    if (r0 != 0) {
        u32 idx = r13->sta;
        u32 v0 = rs_state[idx].active;
        u32 v1 = rs_state[idx].phase;
        u32 ok = (v0 == 2 || v1 == 3 || v1 == 4 || v1 == 5) ? 1 : 0;
        if (ok == 0 && !(mac_evt1() & MAC_EVT1_TXOP)) {
            /* L_939b2c */
            u32 f0 = (mtp_desc_lo & 2u) ? 1 : 0;   /* bic r0,r0,-3 == & 2 */
            uc_mac_cmd((f0 << 6) | 0x19000b00 | (mtp_desc_hi << 14));
            if (txop_await_cts_ppdu(r13, (u32)&sp_buf[1]) == 0) {
                uc_stats.txop_fail += 1;
                txrx_state2 = 0x800;
                return;
            }
            uc_mac_cmd(mac_evt_en_shadow | 0x27004000);
            uc_mac_cmd(0x2004000);
            if (!(txrx_state2 & 0x20004)) {
                /* vendor перечитывает текущий ctx из 0x8029f0 ([0x802978,0x78]) */
                if (qid_cfg[VOL(tx_ctx_pool.cur)->qid].null_b5 != 0 &&
                    MAC_MTP_PERM_NULL_B5_OF(mac_mtp_perm())) {     /* lsr+bxor+bbit1 → пропуск при бите 5 == 0 */
                    VOL(tx_ctx_pool.cur)->flags |= 1u << 1;
                    VOL(tx_ctx_pool.cur)->x20 = 0;
                }
                if (!(VOL(tx_ctx_pool.cur)->flags & (1u << 8))) {
                    u32 bit = MAC_MTP_RESP_ACK_POLICY_OF(mac_mtp_resp());   /* bmsk.f r0,r0,1 — два бита */
                    if (bit == 1) {
                        VOL(tx_ctx_pool.cur)->flags |= 0xe;
                    } else if (bit == 0) {                /* 2, 3 — ничего */
                        u32 r43 = mac_mtp_resp();
                        if (r43 & MAC_MTP_RESP_AGG_EN)
                            txrx_state2 |= 1u << 1;
                        else
                            txrx_state2 |= 1u << 0;
                        if (!(txrx_state2 & (1u << 18)))
                            mac_select_rf_module_cmd31(1, VOL(tx_ctx_pool.cur)->qid);
                    }
                }
            }
            uc_spin_until_event(MAC_EVT1_BUSY2);
            sp_buf[0] = 0;
            if (!(txrx_state1 & 2u) || ((txrx_state2 & 0x11fu) != 0x100)) {   /* bic -3 / bic -0x120 */
                sp_buf[0] = 1;
                u32 sta = r13->sta;                 /* ld_s r1,[r13] до ветки */
                if (rx_cts_rf_restore != 0)
                    VOL(tx_ctx_pool.cur)->rf_word = sta_tab[sta].rx_sel;
                mac_set_rf_chain_state(1, VOL(tx_ctx_pool.cur)->rf_word);
                if (rx_cts_rf_restore != 0)
                    rx_cts_rf_restore = 0;              /* st.as r14(=0),[gp,0x11] */
            }
            /* СРОК: перевод RF на приём (rf_set_rx в 0x889488) до прихода ACK/BA — SIFS (3 мкс)
             * после конца переданного PPDU (802.11-2020 10.3.2.3.3) минус время переключения RF.
             * Между r42.tx_end и записью стоит mac_q_tx_ppdu (при ctx.flags б3): 0x1c/0x46, опрос
             * r53.bap_rel_done, 0x1d + 3 nop, опрос r47, 0x44/0x45/0x46, запрос MTP, r43, r45 —
             * ~100..125 инструкций + 4 аппаратных квитирования (vendor — тот же порядок). Если
             * событие 6 приходит вскоре после tx_end, запас — десятки–сотни тактов, не измерен.
             * Срыв: начало ответа принимается на TX-настройке RF — BA/ACK потерян, повтор.
             * То же — в txop_initiator_open_txop_flow и rx_program_mac_and_wait (rx.c). */
            uc_spin_until_event(MAC_EVT1_TX_END);
            if (r13->flags & (1u << 3))
                mac_q_tx_ppdu(r13, 0);                 /* sub_s.ne r1,r1,r1 */
            uc_wait_one_event(6);
            if (sp_buf[0] == 1) {
                u32 v = (abif_dvs_rf_ctrl_shadow & ~(1u << 24) & ~(1u << 25)) | (rf_set_rx << 24);
                abif_dvs_rf_ctrl_shadow = v;
                *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = v;
            }
            return;
        }
        /* L_939b1e */
        tx_cca_check_and_send(r13, sp_buf[1], 1, 0);
        return;
    }
    /* r0 == 0 */
    tx_cca_check_and_send(r13, sp_buf[1], 1, 0);
}


u32 txop_initiator_open_txop_flow(struct tx_ctx_s *a) {
    /* 6.2 asm 0x93a250. */
    (void)a;
    u32 sp_buf[4] = {0, 0, 0, 0};             /* vendor: кадр 16 Б, буфер sp+4..sp+0xc */
    u32 r14 = (txrx_state2 & 0x40000000u) ? 1 : 0;
    struct tx_ctx_s *r13 = tx_ctx_pool.cur;
    r13->ack_mask = 0x13;
    if (qid_cfg[r13->qid].ctrl_b6 != 0)
        r13->ack_mask |= 1u << 6;
    u32 g = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = g | (1u << 12) | (1u << 13);
    uc_mac_cmd(g | 0x1d003000);
    arc_nops(3);
    u32 r15 = (u32)(u16)mac_status_sel();
    u32 r0 = mtp_queue_release_mgmt(r13, (u32)&sp_buf[1], 0, r14);
    if (r0 != 0) {
        /* L_93a314 */
        /* mov_s r14,1; mov.eq r14,[r13+0x28]&3 — при сброшенном бите станции в 0x802948 */
        u32 r14v = (qid_agg_mask & (1u << r13->qid)) ? 1 : (r13->chan_access & 3u);
        if (r14v == 0) {
            /* L_93a458 */
            if ((mac_mtp_resp() & MAC_MTP_RESP_ACK_POLICY) && !(mac_mtp_resp() & MAC_MTP_RESP_RD_SUPP))
                goto rts_txop_start;                         /* bbit0 r43,26 → без команды */
            uc_mac_cmd(0x20000400);
            goto rts_txop_start;
        }
        if (r15 <= 0x30) {
            /* L_93a440 */
            txrx_state2 |= 1u << 15;
            uc_stats.txop_short += 1;
            return 0;
        }
        if (r14v != 1) {
            uc_assert((u32)__builtin_return_address(0), 0x7a);
            r0 = 0;
        } else {
            /* L_93a340 */
            txrx_state2 |= 1u << 2;
            direct_tx_program_cmd34(0x10, 0x10);
            sp_buf[1] = 0;                             /* st_s r15(=0),[sp,4]: mcs для txop_await */
            mac_program_tx_with_rate(0);
            while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
                ;
            u32 r51 = mac_mtp_desc();
            mtp_desc_lo = r51 & 0xf;
            mtp_desc_hi = r51 >> 4;
            while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
                ;
            direct_tx_send_after_delay(r13->sta, 0xb, 0);
            r0 = ((r13->ack_mask & (u8)mac_mtp_perm()) == 0) ? 1 : 0;
        }
        /* L_93a39a */
        if (r0 == 0)
            goto rts_txop_fail;
        rts_txop_start:   /* L_93a39e */
        if (dti_qset_mode != 0 && (r13->flags & (1u << 11))) {
            mac_load_tx_key((const u32 *)sta_tab[r13->sta].tx_key);
            tx_flow_arm_88606c_0x102();
            r13->flags &= ~(1u << 11);
        }
        u32 f = (mtp_desc_lo & 2u) ? 1 : 0;      /* bic r,r,-3 == & 2 */
        uc_mac_cmd((f << 6) | 0x19000b00 | (mtp_desc_hi << 14));
        if (dti_qset_mode == 1)
            rx_mode_configure(0, r13->sta);
        if (txop_await_cts_ppdu(r13, (u32)&sp_buf[1]) != 0) {
            /* L_93a47a */
            uc_mac_cmd(mac_evt_en_shadow | 0x27004000);
            uc_mac_cmd(0x2004000);
            if (r14v == 0) {                           /* r14 здесь — r14v */
                /* vendor перечитывает текущий ctx из 0x8029f0 ([0x802978,0x78]) */
                if (qid_cfg[VOL(tx_ctx_pool.cur)->qid].null_b5 != 0 &&
                    MAC_MTP_PERM_NULL_B5_OF(mac_mtp_perm())) {     /* lsr+bxor+bbit1 → пропуск при бите 5 == 0 */
                    VOL(tx_ctx_pool.cur)->flags |= 1u << 1;
                    VOL(tx_ctx_pool.cur)->x20 = 0;
                }
                if (!(VOL(tx_ctx_pool.cur)->flags & (1u << 8))) {
                    u32 bit = MAC_MTP_RESP_ACK_POLICY_OF(mac_mtp_resp());   /* bmsk.f r0,r0,1 — два бита */
                    if (bit == 0) {
                        u32 r43 = mac_mtp_resp();
                        if (r43 & MAC_MTP_RESP_AGG_EN)
                            txrx_state2 |= 1u << 1;
                        else
                            txrx_state2 |= 1u << 0;
                        if (!(txrx_state2 & (1u << 18)))
                            mac_select_rf_module_cmd31(1, VOL(tx_ctx_pool.cur)->qid);
                    } else if (bit == 1) {
                        VOL(tx_ctx_pool.cur)->flags |= 0xe;
                    }
                }
            }
            uc_spin_until_event(MAC_EVT1_BUSY2);
            sp_buf[0] = 0;
            if (!(txrx_state1 & 2u) || ((txrx_state2 & 0x11fu) != 0x100)) {   /* bic -3 / bic -0x120 */
                sp_buf[0] = 1;
                u32 sta = r13->sta;                 /* ld_s r1,[r13] до ветки */
                if (rx_cts_rf_restore != 0)
                    VOL(tx_ctx_pool.cur)->rf_word = sta_tab[sta].rx_sel;
                mac_set_rf_chain_state(1, VOL(tx_ctx_pool.cur)->rf_word);
                if (rx_cts_rf_restore != 0)
                    rx_cts_rf_restore = 0;              /* st.as r14(=0),[gp,0x11] */
            }
            tx_busy_start_tsf = uc_read_tsf_lo();
            uc_mac_cmd(0xeeee02);
            /* СРОК: tx_end → mac_q_tx_ppdu → событие 6 → rf_set_rx до ответа через SIFS — как
             * в tx_mtp_queue_gate (см. там). */
            uc_spin_until_event(MAC_EVT1_TX_END);
            if (r13->flags & (1u << 3))
                mac_q_tx_ppdu(r13, 0);                 /* sub_s.ne r1,r1,r1 */
            txrx_state1 = 2;
            txrx_state2 |= 1u << 8;
            uc_wait_one_event(6);
            if (sp_buf[0] == 1) {
                u32 v = (abif_dvs_rf_ctrl_shadow & ~(1u << 24) & ~(1u << 25)) | (rf_set_rx << 24);
                abif_dvs_rf_ctrl_shadow = v;
                *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = v;
            }
            mac_mon_report.tx_rts += 1;
            return 1;
        }
        uc_stats.txop_fail += 1;
        txrx_state2 = 0x800;
        return 0;
    }
    /* L_93a2ce: r0 == 0 */
    if (((u8)mac_mtp_perm() & (r13->ack_mask & 0x40)) == 0)   /* r0 = (… == 0) → bne L_93a420 */
        goto rts_txop_fail;
    r13->x20 = 1;
    mac_q_tx_ppdu_3009(r13);
    mac_program_tx_with_qid(r13->qid);
    while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
        ;
    u32 r51 = mac_mtp_desc();
    mtp_desc_lo = r51 & 0xf;
    mtp_desc_hi = r51 >> 4;
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    goto rts_txop_fail;
    rts_txop_fail:   /* L_93a420 */
    bi_tx_check_idle_and_start_uc(2);
    uc_stats.txop_rts_fail += 1;
    txrx_state2 |= 1u << 13;
    return 0;
}


void rx_funcs_send_direct_frame(u32 a) {
    /* 6.2 asm 0x93b2b8. */
    tx_fifo_write_bytes(a, 0xa);
    tx_fifo_free -= 6;
    uc_mac_cmd(0x33000443);
    uc_wait_direct_tx_ready();
    uc_fifo_frame_tail(a);
    direct_tx_issue_cmd_33();
}


/* Хвост ответа TX (0x93b75e..0x93b7ec и аналоги): ожидание r43, r51, 0x19/0x18. */
static inline __attribute__((always_inline)) void uc_mac_sel(u32 sel)
{
    u32 g = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = g | sel;
    uc_mac_cmd(g | 0x1d000000 | sel);
}

static void bcon_tx_resp_tail(void)
{
    while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
        ;
    u32 r51 = mac_mtp_desc();
    mtp_desc_lo = r51 & 0xf;
    mtp_desc_hi = r51 >> 4;
    mac_evt_enable_bit_sync_b(6);
}

static void bcon_tx_ack_cmds(void)
{
    uc_mac_cmd(0x2008000);
    if (txrx_state1 & 0x10)
        uc_mac_cmd((((mtp_desc_lo & 2) == 2) << 6) | 0x19800830 | (mtp_desc_hi << 14));
    else
        uc_mac_cmd(0x19000001);
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    uc_mac_cmd((txrx_state1 & 0x10) ? 0x18000000 : 0x18001000);
}

/* СРОК: следующий кадр развёртки (маяк в BTI / SSW в ISS) — через SBIFS (1 мкс ±0.03,
 * 802.11-2020 10.3.2.3.8; при смене антенны — LBIFS, 10.3.2.3.11) после конца предыдущего.
 * Сам интервал отмеряет MAC (0x886d0c [31:24] = SBIFS, ss_timing.gap); uc обязан успеть
 * перепрограммировать кадр до этого момента. Путь одного прохода цикла (маяк, f = 0, d = 0,
 * без смены RF): r42.tx_end → 0x2d (CDOWN/сектор) → mac_evt_enable_bit_sync(5) [ожидание] →
 * 0x3f/0x3e/0x37000020, RF tx, счётчик → mac_program_tx_beacon → r43 → bit_sync_b(6)
 * [ожидание] → 0x2008000 → 0x19000001: ~132 инструкции без ожиданий (vendor 0x93b604.. ~125;
 * у нас bcon_tx_ack_cmds — вызов, +2). Это больше SBIFS в тактах (165), значит фактический
 * срок задают события 5/6 MAC и/или опережение tx_end относительно эфира — не установлено;
 * запас: не определён, участок после события 6 — ~10 инструкций (единицы). Колбэк d (TXSS,
 * txss.c) стоит на этом же пути. У SSW (f ≠ 0) Duration по стандарту (SLS_SSW_DUR) — +ldb/mul64/сдвиг/sub
 * против vendor (+5 инструкций на кадр), до ожидания события 5 (поглощается им, если ожидание ненулевое).
 * У маяка (f = 0) вход функции до первой 0x15 — +4 инструкции (сравнение f и два обнуления, objdump).
 * Буквальный Duration маяков: у маяка 0x15 + 0x14000007 на каждом кадре (как у SSW) — +22 инструкции на маяк (ldb CDOWN,
 * mul64, r57, сдвиг, два add/sub, две команды), до ожидания события 5; вход — ещё +4 и 2 сохранения регистров.
 * Признак опоздания — рост замеренного P (метка 1 опытной ветки) и FWERR 0x26. Срыв: интервал > SBIFS, кадры развёртки съезжают против
 * Duration/CDOWN (ss_plan_tx_dur уменьшается на frame + gap за кадр) — развёртка вылезает
 * за BTI/слот, приёмник считает время до конца ISS неверно. */
u32 bcon_txss_sweep_step(u32 a, u32 b, u32 c, u32 d, u32 e, u32 f)
{
    /* 6.2 asm 0x93b430. b — режим (1 — без ре-программы TX, 5 — с приёмом ответа),
     * c — план секторов, d — обратный вызов на каждый сектор, e — биты команды 0x2d,
     * f — 0: маяк, иначе обычный кадр. */
    (void)a;
    typedef void (*cb_t)(u32, u32, u32, u32);
    u32 first = 1;                              /* r15 */
    u32 rxw0 = 0, rxw1 = 0;                     /* [sp,4], [sp,8] */
    u32 sect = 0;                               /* [sp,0x10] — флаг смены RF-модуля */
    u32 h5c = (u32)ss_plan_cdown << 1;

    /* Маяк (f = 0): Duration буквально, ⌈⌉ до конца BTI (abft.h, Duration маяков BTI): bti.c положил m + 1 в _6 и K в
     * total; 0x15 = ss_plan_tx_dur + K − ⌊CDOWN·δb/165⌋ — тот же SLS_SSW_DUR, что у SSW. У первого маяка это TXOP. */
    u32 bmul = 0, badd = 0;
    if (f == 0 && ((const struct ss_timing *)c)->_6 != 0) {
        bmul = (u32)((const struct ss_timing *)c)->_6 << 8;
        badd = ((const struct ss_timing *)c)->total;
    }
    /* Duration SSW в ISS/RSS (f ≠ 0) — до конца SSW с CDOWN 0 + MBIFS, вверх (9.3.1.15, 9.2.5.1), буквально:
     * SLS_SSW_DUR (abft.h).
     * У маяка (f = 0) 0x15 — TXOP BTI, не трогать; множитель и слагаемое считаются только при f ≠ 0, чтобы
     * не удлинять путь slot_event → первый маяк (остаток: +4 инструкции, см. СРОК выше). */
    const struct ss_timing *tmg = (const struct ss_timing *)c;
    u32 dmul = 0, dadd = 0;
    if (f != 0) {
        dmul = sls_ssw_dur_mul(tmg->frame);
        dadd = SLS_MBIFS_US - tmg->gap;
    }
    if (b != 1) {
        if (f == 0)
            uc_mac_cmd(ss_plan_tx_dur | (1u << 24) | (1u << 26) | (1u << 28));
        else
            uc_mac_cmd(SLS_SSW_DUR(ss_plan_tx_dur, dadd, ss_plan_cdown, dmul) | (1u << 24) | (1u << 26) | (1u << 28));
        uc_mac_cmd(0x14000007);
    }
    {
        u32 r1 = e | 0x2d000000 | h5c;
        u32 cmd = ((u32)ss_plan_sector << 10) | r1;
        uc_mac_cmd(cmd);
        if (d != 0)
            ((cb_t)d)(cmd, r1, h5c, d);
    }
    if (b == 5) {
        if (f == 0)
            mac_program_tx_beacon();
        else
            mac_program_tx_common();
        uc_mac_sel(0xa000);
        mac_select_all_sectors_and_wait();
        mac_cmd_29000001();
        u32 r40 = mac_status_sel();
        if ((mac_evt1() & MAC_EVT1_BUSY2) || !(r40 & MAC_PHYSIG_CCA_PPDU_COMP)) {
            uc_mac_cmd(0x29000002);
            while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
                ;
            return 0;
        }
        mac_program_rx_window(b, (rf_chain_cfg | 0x30) | ((u32)ss_plan_rf_sector << 8), rxw0);
        (void)rxw1;
        mac_evt_enable_bit_sync_b(6);
        if (f == 0) {
            uc_mac_cmd(bmul != 0 ? 0x14000007 : 0x14000005);   /* б1 — Duration = 0x15 − d буквально (abft.h) */
            uc_mac_cmd(0x2000080);
        }
        bcon_tx_ack_cmds();
    }
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    sect = 0;
    for (;;) {                                  /* 0x93b74a */
        if (first) {
            first = 0;
        } else {
            if (f == 0)
                mac_program_tx_beacon();
            else
                mac_program_tx_common();
            bcon_tx_resp_tail();
            bcon_tx_ack_cmds();
        }
        if (ss_plan_next_sector(c, (u32)&sect) == 0)
            break;
        uc_mac_cmd(0x3c000200);
        if (sect == 0) {
            uc_mac_cmd(0x38000200);
            uc_mac_cmd(0x36000038);
            uc_mac_cmd(0x6000103);
        } else {
            bcon_txss_program_sector(3, DMG_LBIFS_CLK, 4);   /* смена антенны: LBIFS (ifs.h, P11) */
            uc_mac_cmd(0x83u << 25);
        }
        uc_spin_until_event(MAC_EVT1_TX_END);
        h5c = (u32)ss_plan_cdown << 1;       /* ldb_s r2,[0x802e5c] — перечитывается */
        u32 r1 = e | 0x2d000000 | h5c | ((u32)ss_plan_sector << 10);
        u32 r0 = (u32)ss_plan_sector << 10;
        uc_mac_cmd(r1);
        if (f != 0) {
            uc_mac_cmd(SLS_SSW_DUR(ss_plan_tx_dur, dadd, ss_plan_cdown, dmul) | (1u << 24) | (1u << 26) | (1u << 28));
            uc_mac_cmd(0x14000007);
            r0 = 0x14000007;
        }
        else if (bmul != 0) {                /* маяк: Duration ⌈⌉ буквально, путь как у SSW выше */
            uc_mac_cmd(SLS_SSW_DUR(ss_plan_tx_dur, badd, ss_plan_cdown, bmul) | (1u << 24) | (1u << 26) | (1u << 28));
            uc_mac_cmd(0x14000007);
        }
        if (d != 0)
            ((cb_t)d)(r0, r1, h5c, d);
        u32 r16 = ((u32)ss_plan_rf_sector << 8) | (rf_chain_cfg | 0x30);
        mac_evt_enable_bit_sync(5);
        if (sect != 0) {
            uc_mac_cmd(0x49010000);
            uc_spin_until_event4(MAC_EVT4_EXT_GP345_END);
            mac_evt_select_timer_group(3);
            uc_mac_cmd(0x38000200);
            uc_mac_cmd(0x36000038);
            uc_mac_cmd(0x6000103);
        }
        uc_mac_cmd(r16 | 0x3f000000);
        uc_mac_cmd((rxw0 << 4) | 0x3e000000);
        uc_mac_cmd(0x37000020);
        uc_stats.tx_start += 1;
        u32 v = (abif_dvs_rf_ctrl_shadow & ~(3u << 24)) | (rf_set_tx << 24);
        abif_dvs_rf_ctrl_shadow = v;
        MMIO32(HW_ABIF_DVS_RF_CTRL) = v;
        mac_mon_slot[mac_mon_slot_idx].tx_bcon += 1;
    }
    mac_set_rf_chain_state_with_sta_sector();
    mac_evt_select_timer_group(3);
    uc_spin_until_event(MAC_EVT1_TX_END);
    return 1;
}


void bcon_txss_program_sector(u32 a, u32 b, u32 c) {
    /* 6.2 asm 0x934ff0. */
    mac_evt_select_timer_group(a);              /* r0 = a (r2 только сохраняется в r15) */
    uc_mac_cmd(((a << 20) & 0xf00000) | 0x68000000);
    arc_nops(3);
    uc_mac_cmd(b | 0x67000000);
    arc_nops(3);
    uc_mac_cmd(((a << 20) & 0xf00000) | ((c << 8) & 0x1f00) | 0x6800000e);
}


/* Ожидание SSW-Ack и повтор SSW-Feedback. 802.11-2020 10.42.6.2: если SSW-Ack не
 * принят, инициатор повторяет SSW-Feedback (до dot11BFRetryLimit раз) «PIFS following the expected
 * end of the SSW-Ack frame»: ответчик начинает Ack через MBIFS после Feedback (10.42.2.5, 10.42.6.2),
 * значит повтор — через MBIFS + TXTIME(SSW-Ack) + PIFS = 9 + 18,255 + 8 = 35,255 мкс (5817 тактов)
 * после конца Feedback. GP1 — ожидание Ack и момент повтора (в 6.2 было 0x2087 = 50,47 мкс — на ~15 мкс позже
 * стандарта). GP1 взводится через ~40 инструкций и ожидание события 5 после tx_end Feedback, а после
 * срабатывания до 0x19 повтора ещё txss_init_send_ssw_fdbk и MAC; этот путь (замер ниже) вычитается из GP1
 * (SSWFB_GP1_CLK). Ack ответчика по стандарту начинается через MBIFS и кончается через 27,26 + 0,49 мкс (наш
 * ответчик — 9,05 мкс + 18,26, vendor 6.2 — 5,03 + 18,26); uc видит начало приёма задолго до GP1 (ниже).
 *
 * Остаток выделения перед повтором (10.42.6.2): «The initiator shall restart the SSW feedback procedure PIFS
 * following the expected end of the SSW-Ack frame by the responder, provided there is sufficient time left in
 * the allocation for the initiator to begin the SSW feedback procedure followed by an SSW ack procedure from the
 * responder in an MBIFS. If there is not sufficient time left ..., the initiator may restart the SSW feedback
 * procedure in the following allocation». Иначе — нарушение 10.39.4/10.39.5/10.39.6.2 (последовательность «не
 * дальше конца CBAP/SP»).
 *  Нужно от момента взвода GP1: SSWFB_GP1_CLK (до срабатывания) + путь до эфира SSWFB_RETRY_PATH_CLK (max) +
 *  TXTIME(SSW-Feedback) + MBIFS + TXTIME(SSW-Ack) = 5092 + 744 + 3012 + 1485 + 3012 = 13345 тактов = 80,88 мкс →
 *  SSWFB_RETRY_NEED_US = 81 (вверх).
 *  SSWFB_RETRY_PATH_CLK — замер (опыт fbr, образ fbr_a3: ответчик шлёт первые 3 SSW-Ack с чужим RA; оба узла
 *  наши, AP .12 + STA .11, n = 82 повтора, 2026-10-24): конец Feedback → начало повтора в эфире 39,65 / 39,74 /
 *  39,76 мкс (min/med/max; по разности возвратов txss_init_send_ssw_fdbk минус TXTIME(Feedback)); из них взвод →
 *  GP1 35,36 мкс (5817 тактов + задержка таймера), GP1 → команда 0x19 2,51 мкс (путь uc), остальное — задержка
 *  события конца TX до взвода и MAC от 0x19 до эфира. GP1 взводится после mac_evt_enable_bit_sync(5), который
 *  ждёт подтверждения MAC (MAC_EVT1_BUSY2) — MAC занят до конца кадра, т. е. взвод (и проверка) не раньше конца Feedback;
 *  отсюда от проверки до начала повтора не больше max = 39,76 мкс = 6561 такт: 6561 − 5817 = 744.
 *  Поэтому GP1 взводится раньше на минимальный путь SSWFB_RETRY_PATH_MIN_CLK = 39,65 мкс − 35,255 = 725 тактов:
 *  повтор в эфире — не раньше 35,255 мкс и не позже ~35,37 мкс после конца Feedback (без сдвига было 39,65–39,76,
 *  на ~4,5 мкс позже стандарта — почти DIFS 13 мкс после ожидаемого конца Ack, когда среду могут занять другие).
 *  Окно Ack это не сокращает по сути: событие приёма (MAC_EVT1_BUSY) — начало приёма Ack, uc видит его через 9,3–9,5 мкс
 *  после взвода (Ack сразу, n = 44) и 5,2–5,7 мкс на повторах (n = 42; опыт fbr 2026-10-24), дальше rx_flow_run
 *  дочитывает кадр; срабатывание GP1 (через ~30,9 мкс) во время приёма не мешает — запас ~21 мкс.
 *  Конец выделения — меньшее из двух: следующий TBTT (DTI кончается началом BTI следующего BI, любое выделение
 *  DTI кончается не позже; при CBAP Only = 1 это и есть конец CBAP) и конец текущей записи ESE своей таблицы
 *  (ese_slot_tbl: CBAP/SP, где узел участвует — TDMA точки, расписание станции; ese_dti_us_to_window_end).
 *  Источник — HW_MAC_USEC_TO_TBTT (0x886ec0): обратный отсчёт до TBTT в мкс, 26 бит, у AP и у станции (стенд
 *  2026-09-28, 6.2/ref/REGS-62.md); при выключенном MAC — 0x3ffffff (проверка проходит, как раньше). Одно
 *  чтение MMIO, без деления. Округление регистра (вниз или вверх) неизвестно: строгое «> 86» верно при любом
 *  (истинный остаток > значение − 1 ≥ 81 ≥ 80,88). Читается после взвода GP1 — остаток занижен, в безопасную
 *  сторону.
 *  Проверка — сразу после взвода GP1 (ожидание Ack, до события ≥ 9 мкс), а не после срабатывания GP1: путь
 *  GP1 → 0x19 повтора не удлиняется (objdump: 10 инструкций от r54 до вызова txss_init_send_ssw_fdbk против 11
 *  прежде — r14 += 1 ушло за взвод GP1). sswfb_retry_fits — noinline: встроенная держала бы адрес регистра в
 *  лишнем сохраняемом регистре (+1 инструкция пролога до первого Feedback, СРОК в bf.c txss_init_flow).
 *  Не хватает — r14 = DOT11_BF_RETRY_LIMIT + 1, выход как при исчерпании попыток (подсостояние 4; Ack,
 *  пришедший в окне, по-прежнему принимается).
 *  Запись ESE: проверка в ней — цикл не длиннее ESE_SLOTS_N, укладывается в окно ожидания Ack (≥ 9 мкс).
 */
#define SSWFB_ACK_WAIT_CLK  (DMG_MBIFS_CLK + DMG_TXTIME_SSW_ACK_CLK + DMG_PIFS_CLK)  /* 5817 */
#define SSWFB_RETRY_PATH_CLK 744u      /* замер fbr 2026-10-24 (выше): max(конец Feedback → повтор) − SSWFB_ACK_WAIT_CLK */
#define SSWFB_RETRY_PATH_MIN_CLK 725u  /* то же, min: 39,65 мкс = 6542 такта − 5817 */
#define SSWFB_GP1_CLK (SSWFB_ACK_WAIT_CLK - SSWFB_RETRY_PATH_MIN_CLK)  /* 5092: повтор в эфире не раньше 35,255 мкс */
#define SSWFB_RETRY_NEED_CLK (SSWFB_GP1_CLK + SSWFB_RETRY_PATH_CLK + DMG_TXTIME_SSW_FB_CLK + DMG_MBIFS_CLK + \
                              DMG_TXTIME_SSW_ACK_CLK)
#define SSWFB_RETRY_NEED_US  ((SSWFB_RETRY_NEED_CLK + DMG_CLK_PER_US - 1u) / DMG_CLK_PER_US)
_Static_assert(SSWFB_GP1_CLK == 5092u && SSWFB_RETRY_NEED_CLK == 13345u && SSWFB_RETRY_NEED_US == 81u,
               "повтор SSW-Feedback: взвод GP1 и остаток выделения");
#define USEC_TO_TBTT_MASK    0x3ffffffu                                     /* [25:0] */
static __attribute__((noinline)) u32 sswfb_retry_fits(void)
{
    u32 rem = MMIO32(HW_MAC_USEC_TO_TBTT) & USEC_TO_TBTT_MASK;
    u32 win = ese_dti_us_to_window_end();
    if (win < rem)
        rem = win;
    return rem > SSWFB_RETRY_NEED_US;
}
void txss_init_send_fdbk_wait_ack(u32 a) {
    /* 6.2 asm 0x93b9c0. */
    txrx_state2 = 0x400000;
    bf_store_flow_status(a, 4);
    txss_init_send_ssw_fdbk(1, a, 0);
    u16 seq = ifs.sifs;
    if (mac_ifs_shadow != seq) {
        mac_ifs_shadow = seq;
        *(volatile u32 *)HW_MAC_IFS_SIFS = seq | 0x1730000;
        arc_sync();
        uc_mac_cmd(0x38000200);
    }
    u32 v = (abif_dvs_rf_ctrl_shadow & ~(1u << 24) & ~(1u << 25)) | (rf_set_rx << 24);
    abif_dvs_rf_ctrl_shadow = v;
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = v;
    txss_ifs_restore = 0;
    uc_mac_cmd(0x41 << 19);
    mac_evt_enable_bit_sync(5);
    u32 r14 = 1;
    gp_timer_arm(r14, SSWFB_GP1_CLK, 0, 0);
    if (!sswfb_retry_fits())
        r14 = DOT11_BF_RETRY_LIMIT + 1;             /* до конца выделения повтор не помещается (10.42.6.2) */
    for (;;) {
        uc_wait_event1_or_event4(MAC_EVT1_BUSY, MAC_EVT4_GP1_END, 0);
        u32 r42 = mac_evt1();
        if (r42 & MAC_EVT1_BUSY) {
            rx_flow_run();
            u32 e = sls_rx.flags;
            if (e & (1u << 3))
                bf_store_flow_status(a, 5);
            else if (e & 1u)
                bf_store_flow_status(a, 6);
            else if (e & (1u << 2))
                bf_store_flow_status(a, 7);
            else
                continue;
            txrx_state1 = 0;
            txrx_state2 = 0;
            return;
        }
        u32 r54 = mac_evt4();
        if (!(r54 & MAC_EVT4_GP1_END)) {
            uc_assert((u32)__builtin_return_address(0), 0xd);
            continue;
        }
        if (r14 > DOT11_BF_RETRY_LIMIT) {           /* r14 — попыток; повторов r14 − 1 ≤ dot11BFRetryLimit (ifs.h) */
            sls_clear_rx_state();
            txrx_state1 = 0;
            txrx_state2 = 0;
            return;
        }
        mac_mode_switch_core_and_rf(sta_tab[a].tx_sel);
        txss_init_send_ssw_fdbk(1, a, 1);
        mac_evt_enable_bit_sync_b(5);
        u32 v2 = (abif_dvs_rf_ctrl_shadow & ~(1u << 24) & ~(1u << 25)) | (rf_set_rx << 24);
        abif_dvs_rf_ctrl_shadow = v2;
        *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = v2;
        gp_timer_arm(1, SSWFB_GP1_CLK, 0, 0);
        r14 += 1;
        if (!sswfb_retry_fits())
            r14 = DOT11_BF_RETRY_LIMIT + 1;         /* как выше */
    }
}


u32 txss_init_wait_rss(u32 a, u32 b) {
    /* 6.2 asm 0x93bb18. r54/r42 перечитываются перед каждой проверкой (как vendor). */
    u32 r14 = a, r15 = b;
    u32 r13 = 0;
    volatile u32 *e = (volatile u32 *)&sls_rx.flags;
    uc_mac_cmd(0x20d2200);
    uc_mac_cmd(0x49000001);
    mac_evt_enable_bit_sync_b(5);
    gp_timer_arm(0, r15, 0, 0);
    gp_timer_arm(1, 0x1489b5, 0, 0);
    for (;;) {
        uc_wait_event1_or_event4(MAC_EVT1_BUSY, MAC_EVT4_TXSS_END | MAC_EVT4_GP0_END | MAC_EVT4_GP1_END, 0);
        if (!(mac_evt4() & MAC_EVT4_TXSS_END)) {
            if (mac_evt1() & MAC_EVT1_BUSY) {
                rx_flow_run();
                u32 v = *e;
                if (v & (1u << 2)) {
                    if (r13 != 0)
                        uc_assert((u32)__builtin_return_address(0), 0x89);
                    bf_store_flow_status(r14, 7);
                    return 0;
                }
                if (v & (1u << 4)) {
                    bf_store_flow_status(r14, 8);
                    return 0;
                }
            } else if (mac_evt4() & MAC_EVT4_GP0_END) {
                if (r13 != 0)
                    uc_assert((u32)__builtin_return_address(0), 0x102);
                bf_store_flow_status(r14, 2);
                return 0;
            }
            /* L_93bbb6 */
            if ((mac_evt4() & MAC_EVT4_GP1_END) && !(*e & (1u << 1))) {
                gp_timer_stop(1);
                bf_store_flow_status(r14, 3);
                return 0;
            }
        }
        /* L_93bbc8 */
        u32 flag = ((mac_evt4() & MAC_EVT4_TXSS_END) || (*e & (1u << 1))) ? 1 : 0;
        u32 v = *e;
        if (flag == 0) {
            if (v & 1u) {
                *e = v & ~1u;
                txss_rank_best_sector();
                r13 = 1;
                gp_timer_stop(0);
            }
            continue;
        }
        if (v & (1u << 1)) {
            txss_rank_needed = 1;
        } else {
            mac_mode_switch_core_and_rf(sta_tab[r14].tx_sel);
            txss_rank_needed = 0;
        }
        uc_mac_cmd(0x3e000000);
        uc_mac_cmd(0x37000020);
        uc_stats.tx_start += 1;
        u32 g = (abif_dvs_rf_ctrl_shadow & ~((1u << 24) | (1u << 25))) | (rf_set_tx << 24);
        abif_dvs_rf_ctrl_shadow = g;
        *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = g;
        return 1;
    }
}


u32 txss_resp_wait_fdbk(u32 a) {
    /* 6.2 asm 0x93be68. */
    u32 r15 = (sls_rx.flags >> 2) & 1u;
    txrx_state2 = 1u << 23;         /* значение фазы, не адрес */
    mac_evt_enable_bit_sync_b(5);
    u32 r13 = 0;
    for (;;) {
        r13 = sxd_hal_wait_slot2_busy2(resp_wait_slots);
        /* Vendor (0x93be68) здесь, до приёма SSW-Feedback, возвращал в 0x886d00 SIFS — и SSW-Ack
         * уходил через ~5 мкс вместо MBIFS. MBIFS держится до отправки SSW-Ack (txss_resp_flow). */
        if (r13 != 0) {
            rx_flow_run();
            r15 = 0;
        }
        u32 e = sls_rx.flags;
        if (e & 1u) {
            bf_store_flow_status(a, 0xb);
            break;
        }
        if (e & (1u << 3)) {
            uc_assert((u32)__builtin_return_address(0), 0xe);
            continue;
        }
        if (e & (1u << 2)) {
            r15 = 1;
            break;
        }
        if (mac_evt4() & MAC_EVT4_GP0_END) {
            bf_store_flow_status(a, 0xa);
            break;
        }
    }
    if (r13 == 0)
        sls_clear_rx_state();
    return r15;
}


u32 txss_resp_wait_iss_end(u32 a, u32 rss) {
    /* 6.2 asm 0x93bf1c. rss (r1) — таймаут от rss_wait_get, сквозь в gp_timer_arm. */
    u32 r13 = a;
    gp_timer_arm(1, rss, 0, 0);
    for (;;) {
        u32 r54 = mac_evt4();
        u32 e = sls_rx.flags;
        if ((r54 & MAC_EVT4_TXSS_END) || (e & (1u << 1))) {
            txrx_state2 = 0x80000;
            txss_rank_needed = (e >> 1) & 1u;
            if (!(e & (1u << 1)))                   /* bbit1 r1,1 → пропуск */
                mac_mode_switch_core_and_rf(sta_mode_word[r13]);
            bti_cnt.last_ant = sls.best.antenna;
            bti_cnt.last_sector = sls.best.sector;
            mac_program_4f_52(rss_wait_clk_x10, 4);
            txss_program_tx_frame(r13, 1, 1, 0, 0);
            uc_mac_cmd(0x49000040);
            return 1;
        }
        if (mac_evt4() & MAC_EVT4_GP1_END)       /* mov_s r0,r54 — перечитать */
            return 0;
        u32 r0 = sls_rx.flags;
        if (r0 & 1u) {
            sls_rx.flags = r0 & ~1u;
            txss_rank_best_sector();
        }
        uc_wait_event1_or_event4(MAC_EVT1_BUSY, MAC_EVT4_TXSS_END | MAC_EVT4_GP1_END, 0);
        if (mac_evt4() & MAC_EVT4_TXSS_END)
            continue;
        if (mac_evt4() & MAC_EVT4_GP1_END)
            continue;
        rx_flow_run();
        if ((sls_rx.flags & 0xc) == 0)
            continue;
        return 0;
    }
}


void txss_init_send_ssw_fdbk(u32 a, u32 b, u32 c) {
    /* 6.2 asm 0x93c0d4. */
    (void)a;
    u8 buf[0x18];
    uc_mac_cmd(0x20000400);
    if (c != 0) {
        uc_mac_cmd(0x3e000000);
        uc_mac_cmd(0x37000020);
        uc_stats.tx_start += 1;
        u32 v = (abif_dvs_rf_ctrl_shadow & ~(1u << 24) & ~(1u << 25)) | (rf_set_tx << 24);
        abif_dvs_rf_ctrl_shadow = v;
        *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = v;
    }
    /* Duration SSW-Feedback в DTI (9.3.1.16 a/b): TXTIME(SSW-Ack) + MBIFS, + ещё MBIFS при запросе BRP (L-RX
     * ниже — у станции на поддержании); 0x15 вне BTI — буквально (abft.h): 28 / 37. */
    u32 r0 = (maint_sta_mask & (1u << b)) ? SSWFB_DUR_BRP_US : SSWFB_DUR_US;
    r0 |= (1u << 24) | (1u << 26) | (1u << 28);
    uc_mac_cmd(r0);
    uc_mac_cmd(0x14000007);
    /* Vendor пишет только buf[0..1] (stw r3,[sp]): Duration (buf[2..3]) уходит в эфир
     * мусором стека — в отличие от кадров из шаблонов DCCM (ssw_tpl, brp_frame), где оно 0.
     * Перезаписывает ли его MAC, не установлено; здесь 0, как в остальных кадрах. */
    *(u32 *)buf = 0;
    bf_set32((u32)buf, 0, 2, 0);
    bf_set32((u32)buf, 2, 2, 1);
    bf_set32((u32)buf, 4, 4, 6);
    bf_set32((u32)buf, 8, 4, 9);
    buf[0x10] = sls.best.sector | (sls.best.antenna << 6);
    buf[0x11] = (sls.best.snr_db - 0x13) << 2;
    buf[0x12] = 0;
    buf[0x13] = 0;
    buf[0x14] = 0;
    buf[0x15] = 0;
    buf[0x16] = 0;
    if (maint_sta_mask & (1u << b))
        bits_set_u8_s0_w5_uc((u32)(buf + 0x13), 0x10);
    buf[0x17] = 0;
    struct sta_entry *p = &sta_tab[b];
    struct ssw_ack_frame *fr = (struct ssw_ack_frame *)buf;   /* та же раскладка: RA +4, SSW-Feedback +0x10 */
    fr->ra[0] = p->mac[0];
    fr->ra[1] = p->mac[1];
    fr->ra[2] = p->mac[2];
    direct_tx_program_cmd34(0x10, 0x18);
    mac_program_tx_common();
    uc_mac_cmd(0x2008000);
    if (txrx_state1 & 0x10) {
        u32 f = (mtp_desc_lo & 2u) ? 1 : 0;      /* bic r,r,-3 == & 2 */
        uc_mac_cmd((f << 6) | 0x19800830 | (mtp_desc_hi << 14));
    } else {
        uc_mac_cmd(0x19000001);
    }
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    uc_mac_cmd((txrx_state1 & 0x10) ? (0x18 << 24) : 0x18001000);
    tx_fifo_write_bytes((u32)buf, 0xa);
    tx_fifo_free -= 6;
    uc_mac_cmd(0x33000443);
    uc_wait_direct_tx_ready();
    uc_fifo_frame_tail((u32)buf);
    direct_tx_issue_cmd_33();
    mac_evt_enable_bit_sync_b(6);
    mac_set_rf_chain_state_with_sta_sector();
    uc_spin_until_event(MAC_EVT1_TX_END);
}


u32 qset1_mask_any_pending_uc(u32 a) {
    u32 r13 = a;
    uc_mac_cmd(0xf000001u);
    u32 r0 = mac_sel_shadow & 0xfffff0ff;
    mac_sel_shadow = r0 | (1u << 8) | (1u << 9);
    uc_mac_cmd(r0 | 0x1d000300);
    arc_nops(3);
    if ((mac_queue_sel() & MAC_QSET1_Q0_29) != 0 || pm_busy == 0)
        r13 = 1;
    if (r13 != 0)
        rx_enter_listen_mode();
    return r13;
}


u32 background_bi_step(void)
{
    u32 r14 = 1;
    if (rx_listen_active == 0)
        return r14;
    u32 st = bi_state_from_g800600();
    if (st == 1 && pm_cfg_flag != 0 && pm_busy != 0) {
        uc_mac_cmd(0xf000001);
        u32 r0 = mac_sel_shadow & 0xfffff0ff;
        mac_sel_shadow = r0 | (1u << 8) | (1u << 9);
        uc_mac_cmd(r0 | 0x1d000300);
        arc_nops(3);
        if (mac_queue_sel() & ~MAC_QSET1_Q30) {
            pm_idle_veto_reason = 1;
            return 0;
        }
        if (mac_evt1() & MAC_EVT1_BUSY) {
            pm_idle_veto_reason = 2;
            return 0;
        }
        if (uc_role_ap != 0) {
            r14 = 0;
        } else {
            u32 r0 = uc_tsf_elapsed(rx_listen_tsf[0]);
            u32 r1 = bg_bi_thr_a;
            if (r0 < r1) {
                pm_idle_veto_reason = 3;
                return 0;
            }
            r14 = 1;
            for (u32 i = 0; i < SPARRAW_MAX_STA; i++) {
                const struct link_stat_s *ls = &link_stat[i];
                if (ls->x4 != 0 || ls->x5 != 0) {
                    u16 r2 = ls->ka_ok;
                    if (r2 < bg_bi_thr_b) {
                        pm_idle_veto_reason = 4;
                        r14 = 0;
                        break;
                    }
                }
            }
        }
        if (r14 != 0)
            uc_pm_enter_idle(0);
    } else {
        r14 = 0;
        pm_idle_veto_reason = 0;
    }
    return r14;
}

void sends_pmc_mark_aaab02(struct fsched_peer_ctx *p, u32 b) {
    if (fsched_ctx.state != 4)
        return;
    if (p->slot_kicked == 0)
        return;
    u32 r2 = fsched_slot_half4(p) - fixed_sched_slot_cfg_u16_2(p);
    if (b >= r2)
        return;
    fixed_sched_slot_setup(p);
    handle_pmc_triggers(-1, 0);
    uc_mac_cmd(0x80aaab02);
}


void phy_params_snapshot(u32 a, u32 b)
{
    u32 r17 = a, r16 = b;

    sls_meas.antenna = rx_buf_bcn_ssw & 3u;
    sls_meas.sector = (u8)(VOL(rx_buf_ssw) >> 0xa);
    u32 r2 = VOL(rx_buf_ssw) >> 0xa;  /* L_93cf04: vendor перечитывает */
    bf_rep.ssw_rx_cnt += 1;

    u64 v = uc_shl64(1, 0, r2 >= 0x40 ? r2 - 0x40 : r2);
    u32 *seen = bf_rep.sect_seen[r2 >= 0x40];
    seen[0] |= (u32)v;
    seen[1] |= (u32)(v >> 32);

    u32 r0 = rx_buf_ssw_fb0 & 0x3f;
    if (fwsh_n_sets >= 2) {
        u32 t = rf_chain_word >> 8 & 0x7fff;
        r0 += *(u8 *)(fwsh_set_ranges + t * 2);   /* add1 — индекс ×2 */
    }
    *(u32 *)r17 = r0;
    *(u32 *)r16 = rx_buf_ssw_fb0 >> 6;

    memcpy_uc(&sls_cand, &sls_meas, sizeof(sls_cand));

    if (snr_meas_new == 0) {
        u32 t = snr_meas_stats_cnt_no_meas + 1;
        snr_meas_stats_cnt_no_meas = (u16)t;
    } else {
        u32 r15b = snr_best_buf;
        u32 sct = sls_cand.sector & 0x7fu;          /* SparRAW: SNR по секторам (fwsh_sect_snr) */
        FWSH_AT(fwsh_sect_snr, snr, sct) = (s8)sls_cand.snr_db;
        FWSH_AT(fwsh_sect_snr, cnt, sct) += 1;
        FWSH(fwsh_sect_snr, seq) += 1;
        memcpy_uc(&sls.best, (void *)r15b, sizeof(sls.best));
        bf_rep.link_snr = ((struct sector_rec *)r15b)->snr_db;
        u8 r0 = snr_meas_stats_last_samples;
        if (r0 == 0) {
            u32 t = snr_meas_stats_cnt_zero + 1;
            snr_meas_stats_cnt_zero = (u16)t;
        } else if (r0 < 0x80) {
            snr_meas_stats_cnt_ok += 1;
        } else {
            snr_meas_stats_cnt_ge128 += 1;
        }
        u8 r1 = phy_snap_min;
        u8 mn = r1 < r0 ? r1 : r0;
        phy_snap_min = mn;
    }
    snr_meas_new = 0;                       /* stw.as [gp,0x45]: halfword ×2 → 0x8005b2 */
}

void sta_ctx_reset_counters(struct pm_ctx_s *p, u32 a1)
{
    p->ps_active = 0;
    (void)a1;
    /* vendor здесь же сбрасывал расписание PS станции, её бит в upm_vector и UPM-doze —
     * энергосбережение вырезано (см. fw/action.c psc_req_reject) */
}

void update_sector_sweep_frames_number(u32 a, u32 b) {
    /* 6.2 asm 0x93d100. */
    struct ss_cfg_s *ss = (struct ss_cfg_s *)a;
    u32 r3 = 0;
    while (r3 < 0x40 && ss->order[r3] != 0xff)
        r3++;
    u32 v = ((s32)b >= (s32)r3) ? r3 : b;      /* brge — знаковое */
    if (v == 0)                                 /* исправлено: 0 (пустой план или запрос) — SSW с сектором 0xff; прежнее число */
        return;
    ss->n_frames = (u8)v;
    uc_log_emit1(0x20, 0x1001978, v);
}




void mtp_get_tx_permission(struct tx_ctx_s *a, u32 b) {
    /* 6.2 asm 0x93e8c4. */
    uc_mac_cmd(0x2008000);
    uc_mac_cmd(0x19000001);
    u32 r13 = MAC_MTP_RESP_RD_SUPP_OF(mac_mtp_resp());
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    u32 perm = ((a->ack_mask & (u8)mac_mtp_perm()) == 0) ? 1 : 0;
    u32 proceed = 1;                 /* beq_s L_93e942 при perm == 0 */
    if (perm != 0) {
        u32 idx = a->sta;
        u32 v0 = rs_state[idx].active;
        u32 v1 = rs_state[idx].phase;
        proceed = (v0 == 2 || v1 == 3 || v1 == 4 || v1 == 5);   /* иначе L_93e9e6 */
    }
    if (proceed) {
        u32 done = 0;
        if (a->mtp_state == 2 && (a->flags & 1u)) {
            u32 idx = a->sta;
            u32 v0 = rs_state[idx].active;
            u32 v1 = rs_state[idx].phase;
            if (!(v0 == 2 || v1 == 3 || v1 == 4 || v1 == 5)) {
                mtp_service_dispatch(1, a->sta, a->resp_ctx8, b);   /* r1=[r14], r2=[r14,8], r3=r15 */
                while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
                    ;
                u32 r51 = mac_mtp_desc();
                mtp_desc_lo = r51 & 0xf;
                mtp_desc_hi = r51 >> 4;
                while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
                    ;
                uc_mac_cmd(0x18000000);
                if (!(txop_qid_mask & (1u << a->qid)) ||
                    !(txrx_state1 & (1u << 1)))
                    a->flags |= 1u << 8;
                done = 1;
            }
        }
        if (done)
            return;
        /* L_93e9cc */
        if (txrx_state1 & (1u << 1)) {
            tx_send_and_await_rx_frame(a, 1, 0, 0);
            txrx_state2 |= 1u << 9;
            return;
        }
        /* bbit0 → L_93e9f6: дальше общий хвост (команда 0x18000000) */
    } else if (a->flags & (1u << 12)) {   /* L_93e9e6 */
        tx_flow_arm_88606c_0x102();
        a->flags &= ~(1u << 11);
    }
    /* L_93e9f6 */
    if (txrx_state1 & (1u << 1)) {
        if (dti_qset_mode != 0) {
            u32 f3 = fsched_slot_f3_positive(&fsched_peers);
            r13 &= f3;
            if (f3 != 0)
                fixed_sched_manager_decrement_curr_sta_rd_counter(&fsched_peers);
        }
        uc_mac_cmd((r13 << 11) | (1u << 14) | (1u << 27) | (1u << 28));
    } else {
        uc_mac_cmd(0x18000000);
    }
}


u32 mtp_queue_release_mgmt(struct tx_ctx_s *a, u32 b, u32 c, u32 d) {
    /* 6.2 asm 0x93ea40. */
    u32 flag = ((c != 0) ? 1 : 0) << 1;
    u32 r13 = 0, r15, r1;
    if (d != 0) {
        r15 = a->qid << 16;
        r15 |= 1u << 2;
        r1 = a->sta;
        if (rs_state[r1].active != 0)
            r13 = (mtp_queue_byte_by_index(r1) << 8) | 0x3;
    } else {
        r15 = a->qid << 16;
        u32 r2 = a->resp_ctx8;
        if (flag == 2) {
            r15 |= 0x103;
            r13 = r2 << 16;
        } else if (flag == 1) {
            r15 |= 0x3;
            r13 = r2 << 16;
        } else {
            r15 |= 1u;
        }
        if (txrx_state1 & (1u << 1)) {
            u32 r1v = a->sta;
            if (rs_state[r1v].active != 0)
                r13 |= (mtp_queue_byte_by_index(r1v) << 8) | 0x3;
        }
    }
    uc_mac_cmd(0x1b001111);
    r15 |= (1u << 25) | (1u << 26) | (1u << 28);
    uc_mac_cmd(r15);
    uc_mac_cmd(r13 | 0x17000000);
    arc_nops(3);
    while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
        ;
    u32 r51 = mac_mtp_desc();
    mtp_desc_lo = r51 & 0xf;
    mtp_desc_hi = r51 >> 4;
    u32 r43 = mac_mtp_resp();
    struct mtp_resp_info *ri = (struct mtp_resp_info *)b;
    ri->mcs = MAC_MTP_RESP_MCS_OF(r43);
    uc_mac_cmd(0xeeee0d);
    while (!(mac_mtp_perm() & MAC_MTP_PERM_VALID))
        ;
    u32 bit1 = MAC_MTP_PERM_Q_EMPTY_OF(mac_mtp_perm());  /* lsr r0,r45 + bxor + bbit1 */
    u32 ret = ((a->ack_mask & (u8)mac_mtp_perm()) == 0) ? 1 : 0;
    if (bit1) {                              /* idx-путь (L_93eb6c) — при СБРОШЕННОМ бите 1 */
        uc_log_emit_snapshot(6, 0x10006a4);
        return ret;
    }
    u32 idx = MAC_MTP_RESP_DEST_ID_OF(mac_mtp_resp());   /* vendor читает r43 заново */
    a->sta = idx;
    if (idx >= SPARRAW_MAX_STA)
        uc_assert((u32)__builtin_return_address(0), 8);
    struct sta_entry *p = &sta_tab[idx];
    ri->cfg_10 = p->cfg_10;
    ri->tx_sel = p->tx_sel;
    u32 v = p->rx_sel;
    rxf.sta_word4 = v;
    if (!(rx_mode_flags & 1u))
        a->rf_word = v;
    a->chan_access = MAC_MTP_RESP_PKT_MODE_OF(mac_mtp_resp());   /* vendor читает r43 заново */
    return ret;
}


void rs_end(void)
{
    if (rs_pending_mask == 0)
        uc_assert((u32)__builtin_return_address(0), 0x131b);
    do {                                        /* vendor: тело хотя бы раз (после assert — тоже) */
        u32 r0 = rs_pending_mask;
        u32 r14 = (30 - arc_norm(r0));   /* norm + rsub 0x1e */
        u32 r15 = (u8)r14;                      /* extb_s r15,r14 */
        struct rs_sta_stats *rs = &rs_stats[r15];
        u32 r13 = rs->mcs_best;
        if (r13 == 0)
            r13 = rs->mcs_try;
        u32 r0b = txrx_cfg_flags;
        if (!(r0b & (1u << 8)))
            r0b = 0;
        else
            r0b = sel_nbr_rs_param;
        if (r0b != 0) {
            s32 r1 = (s32)r13 - (s32)r0b;
            if (r1 == 5 || r1 == 9) {
                r13 = (u8)(r13 - (r0b + 1));
            } else if (r1 >= 1) {
                r13 = (u8)r1;
            } else {
                r13 = 1;
            }
        }
        u8 r0c = rs_sta_flags[r15];
        if (r0c & 0x80)
            r13 = r0c & 0x7f;
        if (r14 >= 8)
            uc_assert((u32)__builtin_return_address(0), 0x1472);
        if (r13 >= 0xd)
            uc_assert((u32)__builtin_return_address(0), 0x1473);
        rs_state[r14].active = 0;
        uc_log_emit2(0, 0x10013a0, r14, r13);
        rs_stats[r14].mcs_final = r13;
        rate_search_apply_mcs((u8)r13, r14);
        rs_end_cnt[r14] += 1;
        u32 buf[12];
        memset0_words_uc(buf, 0x30);
        struct lmac_evt_rs_done *e = (struct lmac_evt_rs_done *)buf;
        memcpy_uc(e->tx_cnt, rs->tx_cnt, sizeof(rs->tx_cnt));
        memcpy_uc(e->fail_cnt, rs->fail_cnt, sizeof(rs->fail_cnt));
        e->mcs_final = r13;
        e->res.cid = (u8)r14;
        e->res.mcs = r13;
        /* 6.2 asm 0x92feba..0x92fec6: r18 = extb(r13), r0 = r18 + 0x802670, ldb [r0,r15] / ldb [r0+r15,0xd] —
         * счётчики итогового MCS r13, а не MCS 0 (было [0]: в rs_done уходили нули/MCS 0). */
        e->res.fail_total = rs->fail_cnt[(u8)r13];
        e->res.tx_total = rs->tx_cnt[(u8)r13];
        e->res.status = 0;
        uc_send_evt_rs_done(buf);
        rs_pending_mask &= ~(1u << r14);
    } while (rs_pending_mask != 0);            /* bclr.f; bne L_92fdcc */
}

u32 rate_search_reset_stats(struct tx_ctx_s *a, u32 b)
{
    /* 6.2 asm 0x93003c. rate=*(u8*)a; norm = число ведущих нулей. */
    u8 r14 = *(u8 *)&a->sta;
    struct rs_sta_stats *rs = &rs_stats[r14];
    memset0_words_uc(rs->back_fail, sizeof(rs->back_fail));
    if (b == 1)
        rs->mcs_best = rs->mcs_meas;
    const struct rs_sta_cfg *cfg = &rs_cfg[r14];
    u32 n;
    __asm__ volatile("norm %0, %1" : "=r"(n) : "r"(rs_cfg_mcs_en(cfg)));
    u32 r2 = 30 - n;
    if (rs->mcs_try != r2)
        rs->mcs_try = (u8)sched_bitmap_next_set_bit(r14, 0);
    u32 r2b = rs->mcs_best;
    __asm__ volatile("norm %0, %1" : "=r"(n) : "r"(rs_cfg_mcs_en(cfg)));
    u32 r1 = 30 - n;
    return (r2b == r1) ? 1 : 0;
}

u32 rate_search_pick_tx_params(struct tx_ctx_s *a, u32 b)
{
    /* 6.2 asm 0x9301fc. rate=*(u8*)a; b — флаг вставки для bitstream_push. */
    u8 r14 = *(u8 *)&a->sta;
    struct rs_sta_stats *rs = &rs_stats[r14];
    const struct rs_sta_cfg *cfg = &rs_cfg[r14];
    u32 value = ((u32)cfg->back_failure_mask[1] << 16) | cfg->back_failure_mask[0];
    u32 r0 = bitstream_push((u32)rs->back_fail, cfg->max_back_failure_th, b, value);
    u32 *phase = &rs_state[r14].phase;
    if (r0 != 1)
        return *phase;
    rate_search_commit_mcs(a);
    *phase = 4;
    if (rs->mcs_meas == 1)
        *phase = 2;
    else
        rs_pending_mask |= (1u << r14);
    return *phase;
}

void bap_q_avail_check(u32 a, u32 b, u32 c) {
    /* 6.2 asm 0x930268. */
    struct rs_sta_stats *rs = &rs_stats[a];
    if (rs->warmup != 0) {
        u32 g = mac_sel_shadow & 0xfffff0ff;
        mac_sel_shadow = g | (1u << 10) | (1u << 11);
        uc_mac_cmd(g | 0x1d000c00);
        arc_nops(3);
        if ((mac_queue_sel() << 2) != 0)        /* asl.f 0,r41,2 — биты 0..29 */
            rs->warmup_cnt += 1;
        else
            rs->warmup = 0;
    } else {
        rs->tx_cnt[rs->mcs_meas] += b;
        rs->fail_cnt[rs->mcs_meas] += c;
    }
}


void dti_worker_scheduled_dti_allocation_event(u32 *wake)
{
    /* 6.2 asm 0x934854.  sp[0x10]: событие ps_awake_peer = sp[0..0xb], код 6 в sp+8. */
    u32 r17 = MMIO32(HW_MAC_TIMING_INDIRECT_REG_5); /* ld.as [0x887000,-0x52] */
    struct {
        struct ps_evt_body ev;              /* sp+0 событие ps_awake_peer */
        union {                             /* sp+0xc тело события 0x29 / слово 0x886f8c */
            u32  w;
            u16  h;
            u8   b[4];
        } e29;
    } sp;
    memset0_words_uc(&sp.ev, sizeof(sp.ev));
    /* Начало или конец окна — по TSF (uc/ese_dti.c), а не чередованием, как у vendor: событие SP —
     * один бит r54 (4); два события ближе, чем uc успевает заметить первое (конец окна и начало
     * соседнего через Tguard 26 мкс, 10.39.6.5), сливаются, и чередование сдвигалось навсегда —
     * передача станции и кольца хоста открывались вне окон и закрывались в них (стенд 2026-10-23,
     * TDMA точки: станция передавала только после конца своего окна). */
    u32 win = ese_dti_window_now();
    if (win == 0) {
        FWSH(ese_slot_tbl, uc_alloc_end) = 0;
        uc_log_emit1(0x21, 0x1001e44, r17);
        /* Пустая таблица (расписание снято): конец окна несёт вектор «все CID» — иначе fw
         * (ps_assoc_mgr, vring_schd) оставляла запрет всех колец хоста навсегда (docs/ESE.md §3). */
        if (FWSH(ese_slot_tbl, count) == 0)
            sp.ev.awake = 0xff;
        ese_dti_slot_end();
        if (*wake != 0) {
            *wake = 0;
            memset0_words_uc(&sp.e29, sizeof(sp.e29));
            uc_evt_send_29_sync((u32)&sp.e29);
        }
        sp.ev.type = 6;
        uc_send_evt_ps_awake_peer((u32)&sp.ev);
        return;
    }
    if (*wake != 0) {
        /* конец прошлого окна слился с этим началом — его подкачка записей (событие 0x29) здесь,
         * иначе аппаратный массив SP остался бы без следующих записей */
        *wake = 0;
        memset0_words_uc(&sp.e29, sizeof(sp.e29));
        uc_evt_send_29_sync((u32)&sp.e29);
    }
    u32 r14 = MMIO32(HW_MAC_SCHED_SLOT_STATUS); /* ld [0x887000,-0x74] — без .as, смещение в байтах */
    sp.e29.h = (u16)r14;
    FWSH(ese_slot_tbl, uc_alloc_end) = 1;
    FWSH(ese_slot_tbl, uc_cur_slot) = (u8)(win - 1u);   /* vendor: (+1) % count — чередованием */
    u32 r16 = r14 & 0xffff;
    uc_log_emit2(0x21, 0x1001df4, r14 & 0xf, r17);
    ese_dti_slot_start(r16);                    /* открыть передачу на разрешённое окно (uc/ese_dti.c) */
    if (r16 & (1u << 7)) {
        sp.ev.awake = sp.e29.b[1];
        uc_mac_cmd(0x1f000601);
    }
    if (r16 & (1u << 6))
        *wake = 1;
    sp.ev.type = 6;
    uc_send_evt_ps_awake_peer((u32)&sp.ev);
}


u32 sta_tbl_find_by_mac(u32 a) {
    u16 *mac = (u16 *)a;
    for (u32 i = 0; i < SPARRAW_MAX_STA; i++) {
        struct sta_entry *r2 = &sta_tab[i];
        if (r2->mac[0] == mac[0] &&
            r2->mac[1] == mac[1] &&
            r2->mac[2] == mac[2] &&
            (r2->flags & 1u))
            return i;
    }
    return SPARRAW_PEER_UNKNOWN;
}


u32 ss_plan_next_sector(u32 a, u32 b) {
    /* 6.2 asm 0x935878. */
    if (b != 0)
        *(u32 *)b = 0;
    u8 r13 = ss_plan_cdown;
    u8 r2 = ss_plan_idx;
    if (r13 != 0 && r2 != 0x40 && ss_order_cur[r2] != 0xff) {
        u8 r3 = ss_order_cur[r2];
        ss_plan_sector = r3;
        ss_plan_rf_sector = (u8)(r3 + ss_plan_set_base);
        ss_plan_idx = (u8)(r2 + 1);
    } else {
        u8 r3 = ss_plan_passes_left;
        ss_plan_idx = 0;                    /* delay-слот brlt.d 0x9358b0 — пишется и при выходе с 0 */
        if (r3 < 2)
            return 0;
        ss_plan_passes_left = (u8)(r3 - 1);
        if (b != 0) {
            ss_plan_cdown = (u8)(r13 - 1);
            *(u32 *)b = 1;
            /* LBIFS — одна передача в CDOWN и frame + gap в Duration (ifs.h, P11) */
            ss_plan_tx_dur -= ((const struct ss_timing *)a)->frame + ((const struct ss_timing *)a)->gap;
        }
        u8 r1 = ss_plan_idx;
        u8 r2v = ss_order_cur[r1];
        ss_plan_sector = r2v;
        ss_plan_rf_sector = (u8)(r2v + ss_plan_set_base);
        ss_plan_idx = (u8)(r1 + 1);
        r13 = ss_plan_cdown;
    }
    ss_plan_cdown = (u8)(r13 - 1);
    ss_plan_tx_dur -= ((const struct ss_timing *)a)->frame + ((const struct ss_timing *)a)->gap;
    return 1;
}


