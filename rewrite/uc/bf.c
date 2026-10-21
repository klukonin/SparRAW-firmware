// SPDX-License-Identifier: AGPL-3.0-or-later
/* BF (Beamforming) — request-FIFO и state-машина uCode.
 * Портировано из 6.2/src/asm/uc (эталон 6.4/src/c/uc (cpp)).
 * Состояние BF по станциям — bf_sta[9] (20 Б), очередь запросов — bf_req (dccm.h). */
#include "../include/bitfield.h"
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "abft.h"


/* ---- Портированные в других файлах ---- */

/* ---- Forward-декларации функций этого файла ---- */

/* ---- Локальные stub-ы глубоких подфункций ---- */
void peer_masks_or_sta_bit_into_8571c4(u32 a)
{
    u32 mask = 1u << a;
    u32 r1 = itx_ka_pending & mask;   /* ld.as [gp,0x12] */
    FWSH(ll_ctx, pending_mask) |= r1;
}
void g_80212c_reset(void)
{
    memset0_words_uc(sls.top, sizeof(sls.top));
    memset0_words_uc(&sls.best, sizeof(sls.best));
    for (s32 r1 = 4; r1 >= 0; r1--)
        sls.rank[r1] = (u32)r1;
}
void rs_abort(u32 a)
{
    struct rs_sta_state *st = &rs_state[a];
    if (st->active != 0) {
        u8 mcs = rs_stats[a].mcs_try;
        rs_stats[a].mcs_final = mcs;
        uc_log_emit2(0x20, 0x10013b8, a, mcs);
    }
    st->phase = 1;
    st->phase_prev = 1;
    st->active = 0;
}
void bi_tx_check_idle_and_start_uc(u32 a)
{
    /* 0x93696c: ждать устойчивого r40; если хоть один полубайт цепей = 0 — 0x1f000601. */
    u32 r0 = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = r0;
    uc_mac_cmd(r0 | 0x1d000000);
    arc_nops(3);
    u32 r13;
    do {
        r13 = arc_core_rd(40);
        u32 n0 = (arc_core_rd(40) >> 16) & 0xf;
        u32 n2 = (arc_core_rd(40) >> 20) & 0xf;
        u32 n1 = (arc_core_rd(40) >> 24) & 0xf;
        u32 n3 = arc_core_rd(40) >> 28;
        if (n0 == 0 || n2 == 0 || n1 == 0 || n3 == 0)   /* цепочка cmp.ne: Z = «хотя бы один 0» */
            uc_mac_cmd(0x1f000601);
    } while (r13 != arc_core_rd(40));
    mac_set_chain_modes(a);
}
void mac_publish_masks(void)
{
    mac_pub_mask4 = qset_shadow.qset4_mask;
    mac_pub_mask5 = qset_shadow.qset5_mask;
    mac_pub_mask6 = qset_shadow.qset6_mask;
    for (u32 r2 = 4; r2 < 8; r2++) {
        u32 val = ((qset_enable_mask & (1u << r2)) == 0)
                      ? 0 : mac_pub_mask[r2];
        MMIO32(HW_QSET0_MASK_VECTOR + r2 * 4) = val; /* add2 — ×4 */
    }
}
void mac_mode_kick(struct sls_peer_rec *a)
{
    struct sls_peer_rec *r13 = a;
    u32 r3 = mac_ifs_shadow;           /* ldw.as [gp,0x4b] */
    u32 r1 = ifs.mbifs;
    if (r3 != r1) {
        mac_ifs_shadow = (u16)r1;
        MMIO32(HW_MAC_IFS_SIFS) = r1 | 0x1730000;
        arc_sync();
        uc_mac_cmd(0x38000200);
    }
    for (;;) {                                  /* L_92c05c */
        uc_spin_until_event4(0x140);
        if (arc_core_rd(54) & (1u << 6)) {
            mac_ifs_restore_sifs();             /* bl.d L_92bfc0 — и выход */
            return;
        }
        uc_mac_cmd(0x49000100);
        mac_mode_program_c(r13);                /* затем b_s L_92c05c — снова ждать */
    }
}
void uc_spin_until_event4_r0_100(void)
{
    uc_spin_until_event4(0x100);
}
void txss_init_flow(u32 a)
{
    u32 r13 = a;
    rate_search_apply_mcs(1, r13);
    uc_mac_cmd(0x00bf0000);
    u32 tsf = arc_lr(uc_timer[1].count) & 0xffffff;
    uc_mac_cmd(tsf);
    txrx_state1 = 0x20;             /* st.as [gp,0x33] */
    txrx_state2 = 0x80000;          /* st.as [gp,0x34] */
    u32 r0 = sls_rx.flags;
    sls_rx.flags = r0 & ~2u;         /* L_93bcda: bclr_s r0,r0,0x1 — бит 1 */
    txss_ifs_restore = 1;                /* st.as [gp,-0x6] = [gp,-0x18] */
    u32 cur = mac_ifs_shadow;          /* ldw [gp,0x96] = [gp,0x4b] */
    u32 want = ifs.mbifs;
    if (cur != want) {
        mac_ifs_shadow = (u16)want;    /* stw.as [gp,0x4b] */
        MMIO32(HW_MAC_IFS_SIFS) = want | 0x1730000;
        arc_sync();
        uc_mac_cmd(0x38000200);
    }
    u32 r = txss_program_tx_frame(r13, 5, 0, 0, 0);
    if (r == 1) {
        txrx_state2 = 0x200000;
        u32 rss = rss_wait_get(r13);
        r = txss_init_wait_rss(r13, rss);          /* mov_s r1,r0 (rss_wait_get) */
        /* СРОК: конец RSS → SSW-Feedback инициатора через MBIFS (9 мкс, 802.11-2020 10.42.2.2,
         * 10.3.2.3.10). Событие — r54.txss_end_ind / флаг 0x8021e0 б1 в txss_init_wait_rss (там же
         * RF уже переведён на TX); здесь ~6 инструкций до txss_init_send_fdbk_wait_ack, основной
         * путь — txss_init_send_ssw_fdbk (tail.c, задержка MAC 0x15 = 0x8015a0 + SIFS). Запас
         * здесь большой. Срыв: SSW-Feedback позже MBIFS; ответчик ждёт его GP0 (txss_resp_wait_fdbk)
         * → подсостояние 0xa. */
        if (r == 1) {
            bti_cnt.last_ant = sls.best.antenna;
            bti_cnt.last_sector = sls.best.sector;        /* stw [r1,0x22] */
            txss_init_send_fdbk_wait_ack(r13);
            if (txss_rank_needed == 1)
                txss_rank_best_sector();
            txss_store_sector_ranking(r13, 0);
        }
    } else {
        bf_store_flow_status(r13, 1);
    }
    txrx_state1 = 0;
    txrx_state2 = 0;
    if (txss_ifs_restore != 0) {
        u32 c2 = mac_ifs_shadow;
        u32 w2 = ifs.sifs;
        if (c2 != w2) {
            mac_ifs_shadow = (u16)w2;
            MMIO32(HW_MAC_IFS_SIFS) = w2 | 0x1730000;
            arc_sync();
            uc_mac_cmd(0x38000200);
        }
        /* vendor L_93bdbe: 3×nop (цель breq — выполняется на обоих путях) */
        arc_nops(3);
        uc_mac_cmd(0x1f000601);
        txss_ifs_restore = 0;
    }
    uc_mac_cmd(0x49000001);
}
void txss_resp_flow(u32 a)
{
    u32 r13 = a;
    rate_search_apply_mcs(1, r13);
    txss_ifs_restore = 1;
    txrx_state1 = 0x40;
    if (r13 == 8) {
        sta_tab[8].mac[0] = sls.peer_mac[0];
        sta_tab[8].mac[1] = sls.peer_mac[1];
        sta_tab[8].mac[2] = sls.peer_mac[2];
    }
    txrx_state2 = 0x200000;
    u32 rss = rss_wait_get(r13);
    u32 r = txss_resp_wait_iss_end(r13, rss);
    if (r == 1) {
        r = txss_resp_wait_fdbk(r13);
        /* SSW-Feedback → SSW-Ack через MBIFS (802.11-2020 10.42.2.2, 10.3.2.3.10). MAC отсчитывает
         * ответ по 0x886d00: в нём MBIFS (3×SIFS) с начала SLS. Vendor возвращал SIFS ещё в
         * txss_resp_wait_fdbk — Ack уходил через 5,0 мкс; с MBIFS до отправки Ack — 9,05 мкс
         * (стенд 2026-10-21, опыт E1, двусторонний замер, notes/timing/IFS-MEASURED.md). */
        if (r == 1) {
            sls_send_ssw_ack(r13, 0);
            bf_store_flow_status(r13, 9);
        }
        /* SIFS обратно — после SSW-Ack (или после неудачного ожидания Feedback), как vendor делал
         * в txss_resp_wait_fdbk: без 0x1f000601. */
        if (txss_ifs_restore != 0) {
            u16 w = ifs.sifs;
            if (mac_ifs_shadow != w) {
                mac_ifs_shadow = w;
                MMIO32(HW_MAC_IFS_SIFS) = w | 0x1730000;
                arc_sync();
                uc_mac_cmd(0x38000200);
            }
            txss_ifs_restore = 0;
        }
        if (txss_rank_needed == 1)
            txss_rank_best_sector();
        txss_store_sector_ranking(r13, 0);
    } else {
        bf_store_flow_status(r13, 0xb);
    }
    bf_flow_exit(r13);
    if (txss_ifs_restore != 0) {
        u32 c2 = mac_ifs_shadow;
        u32 w2 = ifs.sifs;
        if (c2 != w2) {
            mac_ifs_shadow = (u16)w2;
            MMIO32(HW_MAC_IFS_SIFS) = w2 | 0x1730000;
            arc_sync();
            uc_mac_cmd(0x38000200);
        }
        /* vendor L_93c0b4: 3×nop (цель breq — выполняется на обоих путях) */
        arc_nops(3);
        uc_mac_cmd(0x1f000601);
        txss_ifs_restore = 0;
    }
}
void fsched_bf_req_set(struct fsched_peer_ctx *p, u32 idx)
{
    /* 6.2 asm 0x9351f8 */
    p->bf_req_mask |= (u8)(1u << idx);
}
void rx_mode_configure(u32 a, u32 b)
{
    u32 r16 = a, r17 = b;
    u32 r18, r19, r15;
    u32 r0, r1, r2, r3;

    uc_mac_cmd(r16 | 0x80d00000);

    /* Кольцевой буфер последних режимов RX: 16 слотов по 0x8025fc..0x80260b. */
    r0 = rx_mode_hist_idx;
    rx_mode_hist[r0] = (u8)r16;
    r0 = (r0 + 1) & 0xf;                 /* bmsk_s 0x3 = & 0xf */
    rx_mode_hist_idx = (u8)r0;
    rx_mode_hist[r0] = 0xff;

    if (r16 == 2 || r16 == 3) {
        /* ---- режимы 2/3 ---- */
        r1 = 0;
        r15 = 8;
        r0 = dti_qset_mode;
        r18 = 0;
        if (r0 == 2) {
            r0 = maint_sta_mask;
            if (r0 != 0) {
                /* norm + rsub 0x1e -> индекс старшего бита */
                r15 = (30 - arc_norm(r0));
                r0 = VOL(link_stat[r15].bf_reasons);   /* asl 2 + add2_s = *20 */
                r18 = (r0 == 0) ? 1u : 0u;
            }
        }

        if (r18 == 0) {
            /* ---- L_92f554: путь по sta-таблице ---- */
            if (r17 < 8) {
                struct sta_entry *sta = &sta_tab[r17];
                r1 = sta->flags;
                if (r1 & 1u) {
                    r3 = sta->omni_rx_sel;
                    r1 = r3 & 0x7fff00;
                    if (r1 == 0x7fff00) {
                        /* три установки бит-полей в [0x801024]
                         * (регистры: r0=ptr=0x801024, r1=значение) */
                        bf_set32((u32)&rf_chain_word, 8, 15, bti_sweep_set);
                        bf_set32((u32)&rf_chain_word, 4, 4, (r3 >> 4) & 0xf);
                        bf_set32((u32)&rf_chain_word, 0, 4, r3 & 0xf);
                    } else {
                        rf_chain_word = r3;
                    }
                }
            }
            /* L_92f5a0 */
            r19 = (u32)brp_rf.omni_offset;
            r17 = FWSH(fwsh_sets, rx_gain_ofs_lo_mcs);
            r0 = rx_mode_flags;
            r0 |= 1u;
            rx_mode_flags = r0;
        } else {
            /* ---- L_92f5c2: путь по цепочке r15 ---- */
            if (r15 >= 8)
                uc_assert((u32)__builtin_return_address(0), 0x12f0);
            r19 = (u32)brp_rf.module_byte[r15];
            r0 = rate_search_current_mcs_b(r15);
            if ((s32)r0 < 9)
                r0 = FWSH(fwsh_sets, rx_gain_ofs_lo_mcs);
            else
                r0 = 0;
            r17 = r0;
            r0 = rx_mode_flags;
            r0 &= ~1u;
            rx_mode_flags = r0;
            r1 = sta_tab[r15].rx_sel;
            tx_ctx_pool.cur->rf_word = r1;
        }

        /* ---- L_92f618 ---- */
        if (r16 == 2)
            (void)mac_set_mode_a000(r0);

        if (r18 == 0) {
            /* L_92f624 */
            hwd_phy_rx_set_agc_start_val_and_gain_array_uc(agc_cfg.agc_start,
                                                           agc_cfg.gain_arr);
            r0 = calib_gain_ofs + agc_cfg.agc_start;
            if (r0 >= 0x3f)                  /* mov.cc -> clamp down */
                r0 = 0x3f;
            phy_set_88306c_field(r0);
            r2 = rf_gain_cb;
            ((void (*)(u32, u32))r2)(r19, r17);
            r0 = rf_chain_word;
        } else {
            /* L_92f650 */
            hwd_phy_rx_set_agc_start_val_and_gain_array_uc(agc_cfg.agc_start_b,
                                                           agc_cfg.gain_arr_b);
            r0 = calib_gain_ofs + agc_cfg.agc_start_b;
            if (r0 >= 0x3f)
                r0 = 0x3f;
            phy_set_88306c_field(r0);
            r2 = rf_gain_cb;
            ((void (*)(u32, u32))r2)(r19, r17);
            r0 = sta_tab[r15].rx_sel;
        }

        /* ---- L_92f67e ---- */
        (void)brp_split_id(r0);
        if (r16 == 2)
            uc_mac_cmd(0x3d000400);
        /* L_92f696 */
        r0 = rx_mode_flags;
        r0 |= 2u;
        rx_mode_flags = r0;
    } else {
        /* ---- L_92f69e: остальные режимы ---- */
        if (r17 >= 8)
            uc_assert((u32)__builtin_return_address(0), 0x12f0);
        r18 = (u32)brp_rf.module_byte[r17];
        r0 = rate_search_current_mcs_b(r17);
        if ((s32)r0 < 9)
            r15 = FWSH(fwsh_sets, rx_gain_ofs_lo_mcs);
        else
            r15 = 0;
        /* L_92f6d0 */
        r0 = rx_mode_flags;
        r0 &= ~3u;                           /* bic r0,r0,0x3 */
        rx_mode_flags = r0;
        r1 = sta_tab[r17].rx_sel;
        tx_ctx_pool.cur->rf_word = r1;
        hwd_phy_rx_set_agc_start_val_and_gain_array_uc(agc_cfg.agc_start_b,
                                                       agc_cfg.gain_arr_b);
        r0 = calib_gain_ofs + agc_cfg.agc_start_b;
        if (r0 >= 0x3f)
            r0 = 0x3f;
        phy_set_88306c_field(r0);
        r2 = rf_gain_cb;
        ((void (*)(u32, u32))r2)(r18, r15);
    }

    /* ---- L_92f718: общий хвост ---- */
    r1 = rx_mode_flags;
    r0 = r16 | 0xd10000;
    r0 |= (r1 & 1u) << 4;
    r0 |= (1u << 31);
    uc_mac_cmd(r0);
}
void uc_log_emit1(u32 lvl, u32 token, u32 a0)
{
    u32 r9 = lvl & 0xf;
    if (!(uc_log.lvl_mask[r9] & (1u << ((lvl >> 4) & 3))))
        return;
    u32 idx = uc_log.wr_idx;
    uc_log.ring[(u8)(idx + 2)] = a0;
    u32 ts[2];
    uc_sysassert_snapshot_mac(0, (u32)ts, 0);
    uc_log.ring[(u8)(idx + 1)] = ts[0];
    u32 hdr = (token & 0xfffff) | 0xa4000000;
    u8 len = (u8)((ts[1] >= 0xff) ? 0xff : ts[1]);
    hdr |= (u32)len << 0x12;
    uc_log.ring[(u8)idx] = hdr;   /* extb: кольцо 256 слов */
    uc_log.wr_idx = idx + 3;
}
void uc_log_emit2(u32 lvl, u32 token, u32 a0, u32 a1)
{
    u32 r9 = lvl & 0xf;
    if (!(uc_log.lvl_mask[r9] & (1u << ((lvl >> 4) & 3))))
        return;
    u32 idx = uc_log.wr_idx;
    uc_log.ring[(u8)(idx + 3)] = a1;
    uc_log.ring[(u8)(idx + 2)] = a0;
    u32 ts[2];
    uc_sysassert_snapshot_mac(0, (u32)ts, 0);
    uc_log.ring[(u8)(idx + 1)] = ts[0];
    u32 hdr = (token & 0xfffff) | 0xa8000000;
    u8 len = (u8)((ts[1] >= 0xff) ? 0xff : ts[1]);
    hdr |= (u32)len << 0x12;
    uc_log.ring[(u8)idx] = hdr;   /* extb: кольцо 256 слов */
    uc_log.wr_idx = idx + 4;
}

/* ================================================================== */

/* Запись битовых полей — include/bitfield.h. */

/* ================================================================== */

void bf_pending_clear_bit(u32 bit)
{
    bg_task_pending &= ~(1u << bit);
}

void bf_pending_set_bit(u32 bit)
{
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    bg_task_pending |= 1u << bit;
    arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
}

void bf_store_flow_status(u32 idx, u32 v)
{
    bf_sta[idx].flow_status = v;
}

void bf_abort_noop_hook(u32 a) { (void)a; }
void bf_sm_brp_noop_hook_a(void) { }
void bf_sm_brp_noop_hook_b(void) { }

u32 bf_sm_clear_slot_diag(void)
{
    txrx_state1 = 0;
    txrx_state2 = 0;
    return 0;                                   /* r0 = 0 */
}

void bf_enter_mode3(u32 a, u32 b)
{
    /* 6.2 asm 0x920cb8: a не используется, b (r1) -> [0x8004f0], bf_pause_sta_tx(3, b). */
    (void)a;
    bf_cur_sta = b;
    internal_tx_check_idle(3);
    bf_pause_sta_tx(3, b);
}

void bf_abort_step(u32 a)
{
    bf_pending_set_bit(1);
    peer_masks_or_sta_bit_into_8571c4(a);
    bf_abort_noop_hook(a);
}

void bf_clear_pending_and_notify(u32 a)
{
    internal_tx_clear_pending_bit(3);
    bf_resume_sta_tx(3, a);
}

void bf_abort_to_state11(u32 a)
{
    bf_clear_pending_and_notify(a);
    bf_sm_set_sta_state(a, 0x11);
}

void bf_txss_reset_report_ctx(void)
{
    bf_rep.link_snr = -20;
    bf_rep.ssw_rx_cnt = 0;
    bf_rep.sect_seen[0][0] = 0;
    bf_rep.sect_seen[0][1] = 0;
    bf_rep.sect_seen[1][0] = 0;
    bf_rep.sect_seen[1][1] = 0;
}

void bf_metrics_reset_and_stamp(void)
{
    memset0_words_uc((void *)&ba_stats, 0x18);
    ba_stats.reset_tsf = uc_read_tsf_lo();
}

void bf_clear_sta_bit_state34(u32 bit, u32 st)
{
    if (st != 3 && st != 4)
        return;
    u32 mask = ~(1u << bit);
    sls_rank_valid_mask &= mask;
    sls_rank_valid_mask2 &= mask;
}

void bf_clear_all_sta(void)
{
    while (bf_req.head < bf_req.tail) {
        u32 v = bf_req.pending_mask;
        uc_log_emit3(0x20, 0x1000d3c, bf_req.tail, bf_req.head, v);
        bf_reset_sta(30 - arc_norm(v), 0);           /* norm + rsub 0x1e */
    }
}

void bf_init_globals(void)
{
    g_80212c_reset();
    bf_tx_sector = 0x21;                    /* sth.as [gp,-93] */
    bf_rx_sector = 0x21;                    /* sth.as [gp,-94] */
    bf_ctrl.snr_samples = 0x80;
    memset0_words_uc((void *)link_stat, 8 * sizeof(struct link_stat_s));
}

void bf_flow_exit(u32 a0)
{
    if (sta_link_byte_by_index(a0) == 0) {
        if (VOL(link_stat[a0].bf_reasons) & 0xbf)     /* bic r0,r0,-0xc0 == & 0xbf */
            rs_abort(a0);
    }
    internal_tx_clear_pending_bit(3);
    bf_pause_sta_tx(3, a0);
    bi_tx_check_idle_and_start_uc(2);
    bf_pending_set_bit(1);
    txrx_state1 = 0;
    txrx_state2 = 0;
}

void bf_reset_sta(u32 a0, u32 a1)
{
    if (bf_req.pending_mask & (1u << (a0 & 0x1f))) {
        bf_sm_set_sta_state(a0, 0);
        bf_clear_pending_and_notify(a0);
        bf_req_dequeue_head(0, 0);
    }
    VOL(link_stat[a0].bf_reasons) = 0;
    memset0_words_uc(&bf_sta[a0], sizeof(struct bf_sta_s));
    if (a1 == 1)
        bf_sm_set_sta_state(a0, 0x11);
}

u32 bf_req_try_claim(struct rx_meas_ctx *m, u32 kind)
{
    u32 r = (m->busy != 0 && m->done == 0) ? 1 : 0;
    if (kind != 0 && r != 0)
        r = (m->kind == kind) ? 1 : 0;
    if (r == 0 || m->state == 2)
        return 0;
    return 1;
}

void bf_req_claim_and_report_2b(struct rx_meas_ctx *m)
{
    if (bf_req_try_claim(m, 5) == 0)
        uc_assert((u32)__builtin_return_address(0), 0xf5);   /* vendor продолжает */
    uc_evt_send_2b(m->state_b);
}

void bf_req_claim_and_report_23(struct rx_meas_ctx *m)
{
    if (bf_req_try_claim(m, 3) == 0)
        uc_assert((u32)__builtin_return_address(0), 0xa2);
    m->pkt.state = (u8)m->state;                /* stb [r13,83] = [r13,0xc] */
    uc_evt_send_23((u32)&m->pkt);
}

void bf_trigger_for_mid(u32 a0)
{
    u32 buf[3];
    bf_pause_sta_tx(3, a0);
    if (lmac_personality != 1) {
        buf[0] = 1;
        buf[1] = 0;
        buf[2] = a0;
        bf_init_sm((u32)buf, 0);
    }
}

void bf_ctx_dispatch_by_role(struct sls_peer_rec *a)
{
    if (bcn_rx.bcn_sent != 0) {
        mac_mode_kick(a);
        return;
    }
    if (bcn_rx.abft_go != 0) {
        abft_responder_respond_flow(a);
        return;
    }
    uc_spin_until_event4_r0_100();
}

u32 bf_sm_brp_init_result(u32 a0)
{
    /* 6.2 asm 0x922494. [0x800430] — счётчик повторов BRP (байт). */
    u32 v = bf_sta[a0].flow_status;
    if (v == 0) {
        brp_init_retry_cnt = 0;
        bf_enter_mode3(9, a0);
        return 0;
    }
    if (v == 0x30)
        return 1;
    if (v == 0x31) {
        u8 c = (u8)(brp_init_retry_cnt + 1);
        brp_init_retry_cnt = c;
        return (c >= 4) ? 2 : 4;
    }
    return 2;
}

u32 bf_sm_on_brp_init(u32 a0)
{
    u32 v = bf_sta[a0].flow_status;
    u32 r;
    if (v == 0) {
        bf_sm_brp_noop_hook_a();
        brp_init_flow(a0);              /* r0 не меняется noop-хуком */
        r = 0;
    } else if (v == 0x30) {
        r = 1;
    } else {
        r = 2;
    }
    if (r != 0) {
        bf_sm_brp_noop_hook_b();
        g_80212c_reset();
    }
    return r;
}

u32 bf_sm_brp_resp_result(u32 a)
{
    u32 v = bf_sta[a].flow_status;
    u32 r = (v == 0x33) ? 1 : 2;
    g_80212c_reset();
    return r;
}

u32 bf_sm_on_brp_resp(u32 a0)
{
    u32 v = bf_sta[a0].flow_status;
    u32 r;
    if (v == 0) {
        bf_sm_set_state(a0, 0xa);
        bf_sm_brp_noop_hook_a();
        brp_responder_flow_enter(a0);
        r = 0;
    } else if (v == 0x33) {
        r = 1;
    } else {
        r = 2;
    }
    if (r != 0) {
        bf_sm_brp_noop_hook_b();
        g_80212c_reset();
        sls_x64 = 0;
    }
    return r;
}

u32 bf_sm_txss_init_result(u32 a0)
{
    /* 6.2 asm 0x93b840 (таблица 0x801830). Счётчики повторов 0x8005fc..fe: до 4 — r=0. */
    u32 v = bf_sta[a0].flow_status;
    u32 r = 0;
    u8 *cnt = 0;
    switch (v) {
    case 0:
        bf_sm_set_state(a0, 3);
        bf_enter_mode3(3, a0);
        break;
    case 1:
        cnt = &txss_retry_cnt[0];
        break;
    case 2: case 3:
        cnt = &txss_retry_cnt[1];
        break;
    case 4:
        cnt = &txss_retry_cnt[2];
        break;
    case 5:
        r = 1;
        break;
    case 6: case 7: case 8:
        r = 2;
        break;
    default:
        uc_assert((u32)__builtin_return_address(0), 0x19);
        break;
    }
    if (cnt) {
        u8 c = (u8)(*cnt + 1);
        *cnt = c;
        if (c >= 4)
            r = 2;
    }
    if (r == 0) {
        internal_tx_check_idle(3);
        bf_store_flow_status(a0, 0);
    }
    return r;
}

u32 bf_sm_on_txss_init(u32 a0)
{
    u32 v = bf_sta[a0].flow_status;
    u32 r;
    if (v == 0) {
        bf_txss_reset_report_ctx();
        txss_init_flow(a0);
        r = 0;
    } else if (v == 5) {
        r = 1;
    } else {
        r = 2;
    }
    if (r != 0)
        g_80212c_reset();
    return r;
}

u32 bf_sm_txss_resp_result(u32 a0)
{
    u32 v = bf_sta[a0].flow_status;
    switch (v) {
    case 0x9: return 1;
    case 0xa: return 3;
    case 0xb: return 2;
    default:
        uc_assert((u32)__builtin_return_address(0), 0x1a);
        return 0;
    }
}

u32 bf_sm_on_txss_resp(u32 a0)
{
    u32 v = bf_sta[a0].flow_status;
    u32 r;
    if (v == 0) {
        bf_sm_set_state(a0, 4);
        bf_txss_reset_report_ctx();
        txss_resp_flow(a0);
        r = 0;
    } else if (v == 9) {
        r = 1;
    } else {
        r = 2;
    }
    if (r != 0)
        g_80212c_reset();
    return r;
}

/* bf_sm_set_state: переключение состояния (0x92af2c). */
void bf_sm_set_state(u32 sta, u32 state)
{
    /* Таблица 0x801818 (state-3, 0..7): 3 — [0x24]=0 + копия; 9 — копия;
     * 4,10 — только [0x24]=0; 5..8 и вне 3..10 — ничего. */
    u32 r3 = state;
    if (state == 3 || state == 9) {
        if (state == 3)
            sls_x64 = 0;
        struct sta_entry *src = &sta_tab[sta];
        sls.peer_mac[0] = src->mac[0];
        sls.peer_mac[1] = src->mac[1];
        sls.peer_mac[2] = src->mac[2];
    } else if (state == 4 || state == 10) {
        sls_x64 = 0;
    }
    bf_clear_sta_bit_state34(sta, r3);
}

/* bf_sm_set_sta_state: запись состояния станции (0x92b220). */
void bf_sm_set_sta_state(u32 sta, u32 state)
{
    if (dti_qset_mode == 1 && state == 0x11)   /* ld_s [gp,-52] — байты */
        fsched_bf_req_set(&fsched_peers, (u8)sta);
    struct bf_sta_s *e = &bf_sta[sta];
    e->state = state;
    e->flow_status = 0;
}

/* bf_sm_run_sta: диспетчер по состоянию станции (0x921940). */
u32 bf_sm_run_sta(u32 sta)
{
    /* 0x921940: крутить автомат станции, пока шаг не вернёт 2/3. */
    u32 r;
    do {
        r = bf_sm_dispatch_by_state(sta);
        struct bf_sta_s *e = &bf_sta[sta];
        bf_res.diag = e->state | (e->flow_status << 4);  /* диагностика: состояние|подсостояние */
    } while (r != 2 && r != 3);
    return bf_sm_clear_slot_diag();
}

/* bf_sm_dispatch_by_state: диспетчер по состоянию (0x921fa8). */
u32 bf_sm_dispatch_by_state(u32 sta)
{
    /* 0x921fa8: состояния 3 txss_init, 4 txss_resp, 9 brp_init, 10 brp_resp (таблица 0x8019c4). */
    struct bf_sta_s *e = &bf_sta[sta];
    u32 bit = 1u << (sta & 31);
    u32 r;
    uc_mac_cmd(((e->state | (e->flow_status << 4)) & 0xfff) | 0xfcf000);
    switch (e->state) {
    case 3:
        r = bf_sm_on_txss_init(sta);
        if (r != 1)
            break;
        if (sta_tab[sta].fixed_link != 0) {
            sta_apply_rx_sector_and_mcs(sta);
            r = 3;
        } else if ((bf_sta_mask & bit) || bf_ctrl.brp_mode != 1 || !(maint_sta_mask & bit)) {
            r = 3;
        } else {
            bf_sm_set_sta_state(sta, 9);
        }
        break;
    case 4:
        r = bf_sm_on_txss_resp(sta);
        if (r != 1)
            break;
        if (sta_tab[sta].fixed_link != 0) {
            sta_apply_rx_sector_and_mcs(sta);
            r = 3;
        } else if (bf_sta[sta].peer_l_rx < 1 || (bf_sta_mask & bit)) {
            r = 3;
        } else {
            bf_sm_set_sta_state(sta, 0xa);
        }
        break;
    case 9:
        r = bf_sm_on_brp_init(sta);
        if (r == 1)
            r = 3;
        break;
    case 10:
        r = bf_sm_on_brp_resp(sta);
        if (r == 1)
            r = 3;
        break;
    default:
        r = 2;
        break;
    }
    uc_mac_cmd((((e->flow_status << 4) | e->state) & 0xfff) | 0xfcc000);
    uc_mac_cmd(0x52000000);
    uc_mac_cmd(0x53000000);
    return r;
}

/* bf_pause_sta_tx (0x92ba54). */
void bf_pause_sta_tx(u32 a0, u32 a1)
{
    if (a1 == 8)
        return;
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    struct sta_entry *slot = &sta_tab[a1];
    if (slot->flags & 1u) {
        u16 *m = &tx_dis_mask[a1];
        *m |= 1u << (a0 & 0x1f);
        qset_shadow.qset5_mask &= ~slot->qid_mask_q5;
        qset_shadow.qset6_mask &= ~slot->qid_mask_q6;
        mac_publish_masks();
        arc_sync();
        uc_mac_cmd(0x81 << 0x12);
    }
    arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
}

/* bf_resume_sta_tx (0x92bb34) — по эталону. */
void bf_resume_sta_tx(u32 a0, u32 a1)
{
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    u16 *pm = &tx_dis_mask[a1];       /* add1_s r2,r2,r1 */
    u16 v = *pm & ~(1u << (a0 & 0x1f));         /* bclr r13,r13,r0 */
    u16 w = sta_tab[a1].flags;
    *pm = v;                                    /* stw_s r13,[r2] */
    if ((w & 1) && v == 0) {
        qset_shadow.qset5_mask |= sta_tab[a1].qid_mask_q5;
        qset_shadow.qset6_mask = sta_tab[a1].qid_mask_q6 | qset_shadow.qset6_mask;
        mac_publish_masks();
    }
    arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
}

/* bf_req_enqueue (0x921bd4). */
u32 bf_req_enqueue(u32 a0, u32 a1, u32 a2)
{
    struct bf_req_q_s *q = &bf_req;
    u32 was_empty = (q->pending_mask == 0) ? 1 : 0;
    q->pending_mask |= 1u << a0;
    struct bf_sta_s *e = &bf_sta[a0];
    e->state = a1;
    e->flow_status = 0;
    e->brp_flags = 0;
    e->req_desc = (struct bf_req_desc *)a2;
    q->fifo[q->tail & 7] = a0;
    q->tail++;
    if (q->tail - q->head >= 9)
        uc_assert((u32)__builtin_return_address(0), 0x12);
    return was_empty;
}

/* bf_req_dequeue_head (0x921b38). */
u32 bf_req_dequeue_head(u32 a0, u32 a1)
{
    struct bf_req_q_s *q = &bf_req;
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~2u);
    u32 head = q->head & 7;
    u32 sta = q->fifo[head];
    q->head++;
    q->pending_mask &= ~(1u << sta);
    struct bf_sta_s *e = &bf_sta[sta];
    e->state = 0;
    if (q->pending_mask != 0) {
        u32 nx = q->fifo[q->head & 7];
        *(u32 *)sls.peer_mac = *(u32 *)sta_tab[nx].mac;
        sls.peer_mac[2] = sta_tab[nx].mac[2];
        bf_abort_step(nx);
    }
    if (a1 == 0) {
        sta_apply_bf_result(a0, sta);
        bf_res.done_cnt = bf_res.done_cnt + 1;
        bf_done_cnt_pub = bf_res.done_cnt;
    }
    u32 cur = arc_lr(ARC_STATUS32);
    arc_flag((saved & 2u) | cur);
    return cur;
}

/* bf_init_sm (0x9219f4). */
void bf_init_sm(u32 a, u32 b)
{
    u32 *req = (u32 *)a;
    u32 sta = req[2];   /* r13 = [a+8] */
    uc_log_emit3(0x20, 0x1000d14, req[0], sta, b);
    if (req[0] == 0) {
        /* полный сброс */
        memset0_words_uc((void *)&bf_res, 0x1c);
        memset0_words_uc(bf_sta, 9 * sizeof(struct bf_sta_s) + sizeof(struct bf_req_q_s));   /* bf_sta[9] и bf_req */
        bf_res.done_cnt = bf_done_cnt_pub;
        return;
    }
    /* инициализация одной станции */
    u32 r16 = 1u << sta;
    if (bf_req.pending_mask & r16) {
        volatile struct link_stat_s *sl = &link_stat[sta];
        u8 bv = sl->bf_reasons;
        if ((bv & 0x10) != (bv & 0xBF)) {
            bv &= (u8)~0x10;
            sl->bf_reasons = bv;
        }
        if (!(bv & 0x40))
            return;                     /* vendor 0x921a80: beq -> эпилог */
        bf_reset_sta_slot(sta);
    }
    /* счётчик попыток */
    sls.attempts[sta] += 1;
    if (b == 1)
        VOL(link_stat[sta].bf_reasons) |= 0x10;
    /* код состояния */
    u32 r1;
    u32 t = req[1];
    if (t == 0)
        r1 = 2;
    else if (t == 1)
        r1 = (bf_ctrl.brp_mode == 0) ? 0x11 : 9;
    else {
        uc_assert((u32)__builtin_return_address(0), 0x16);
        r1 = 0;
    }
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    u32 r0;
    if (!(bf_req.pending_mask & r16)) {
        r0 = bf_req_enqueue((u8)sta, r1, (u32)&bf_req_desc_default);
    } else {
        bf_sm_set_sta_state(sta, r1);
        r0 = 1;
    }
    if (r0 != 0) {
        *(u32 *)sls.peer_mac = *(u32 *)sta_tab[sta].mac;
        sls.peer_mac[2] = sta_tab[sta].mac[2];
        bf_abort_step(sta);
    }
    arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
}

/* bf_sm_process_request_fifo (0x921d50). */
void bf_sm_process_request_fifo(void)
{
    /* 6.2 asm 0x921d50; переходы по байтовой таблице 0x801804 (от 0x921dc8). */
    struct bf_req_q_s *q = &bf_req;
    if (q->pending_mask == 0)
        return;
    ucode_pm_set_busy_flag(0);
    uc_tx_is_idle();
    u32 sta = q->fifo[q->head & 7];
    struct bf_sta_s *e = &bf_sta[sta];
    if (e->flow_status != 0 && e->state != 3)
        uc_log_emit3(0x20, 0x1000c3c, e->state, e->flow_status, q->pending_mask);
    bf_cur_sta = sta;

    u32 r15 = 0, r16 = 0, r;
    switch (e->state) {
    case 0: case 0x12:
        goto reprog;
    case 2:
        sta_reset_link_state(sta, 0, 1);
        bf_pause_sta_tx(3, sta);
        bf_sm_set_sta_state(sta, 3);
        goto abort;
    case 3:
        r = bf_sm_txss_init_result(sta);
        if (r == 2)
            bf_sm_set_sta_state(sta, 0xb);
        else if (r == 1)
            goto pick;
        goto pending;
    case 4:
        r = bf_sm_txss_resp_result(sta);
        if (r == 2 || r == 3)
            bf_sm_set_sta_state(sta, 0xb);
        else if (r == 1)
            goto pick;
        goto pending;
    case 5:
        sta_reset_link_state(sta, 0, 1);
        bf_sm_set_sta_state(sta, 9);
        goto abort;
    case 9:
        r = bf_sm_brp_init_result(sta);
        if (r == 0)
            goto reprog;
        if (r == 2)
            bf_sm_set_sta_state(sta, 0xe);
        else if (r == 1)
            bf_sm_set_sta_state(sta, 0xd);
        goto abort;
    case 0xa:
        r = bf_sm_brp_resp_result(sta);
        if (r == 2)
            bf_sm_set_sta_state(sta, 0xe);
        else if (r == 1)
            bf_sm_set_sta_state(sta, 0xd);
        else
            uc_assert((u32)__builtin_return_address(0), 0x14);
        goto abort;
    case 0xb: case 0xd: case 0xe:
        r15 = 1;
        r16 = 1;
        break;
    case 0x11:
        break;
    default:                                    /* 1, 6..8, 0xc, 0xf, 0x10, > 0x12 */
        uc_assert((u32)__builtin_return_address(0), 0x15);
        goto reprog;
    }

    /* 0x921e98: завершение запроса */
    if (e->state == 0x11) {
        if (lmac_personality == 1)
            bf_pause_sta_tx(3, sta);
        u32 bit = 1u << (sta & 31);
        if (bf_brp_req_mask & bit) {
            uc_log_emit1(0x20, 0x1000c6c, sta);
        } else {
            uc_log_emit1(0x10, 0x1000ca8, sta);
            bf_sta_mask = bf_sta_mask & ~bit;
        }
    }
    bf_sm_set_sta_state(sta, 0);
    bf_clear_pending_and_notify(sta);
    if (e->req_desc == 0) {
        uc_log_emit1(0x20, 0x1000cdc, sta);
    } else {
        u32 cb = e->req_desc->done_cb;
        u32 cb2 = e->done_cb2;
        if (cb != 0)
            ((void (*)(u32, u32, u32))cb)(r15, sta, r16);
        if (cb2 != 0) {
            ((void (*)(u32, u32, u32))cb2)(1, sta, 0);
            e->done_cb2 = 0;
        }
    }
    bf_req_dequeue_head(r15, 0);
    bf_res.diag = e->state | (e->flow_status << 4);
    if (dti_qset_mode == 2 && maint_sta_mask != 0 && r16 == 1) {
        rx_mode_configure(2, sta);
        mac_read_tsf64_uc(fsched_peers.rx_tsf);
    }
    goto reprog;

pick:                                           /* 0x921e08 */
    if (bf_ctrl.brp_mode == 1 && (maint_sta_mask & (1u << (sta & 31))))
        bf_sm_set_sta_state(sta, 9);
    else
        bf_sm_set_sta_state(sta, 0xd);
pending:                                        /* 0x921e3a */
    bf_pending_set_bit(1);
    goto reprog;
abort:                                          /* 0x921e8a */
    bf_abort_step(sta);
reprog:                                         /* 0x921f7e */
    uc_mac_cmd(((e->state | (e->flow_status << 4)) & 0xfff) | 0xfaa000);
    bf_res.diag_last = bf_res.diag;
}

/* bf_reset_sta_slot (0x92484c). */
void bf_reset_sta_slot(u32 a0)
{
    /* вариант 1: сброс слота */
    struct bf_sta_s *e = &bf_sta[a0];
    struct bf_req_desc *r15 = e->req_desc;
    if (a0 == bf_cur_sta)
        internal_tx_clear_pending_bit(3);
    e->done_cb2 = r15->cb2;
    e->req_desc = &bf_req_desc_default;
    VOL(link_stat[a0].bf_reasons) &= ~0x40;
    bf_reset_sta_cnt += 1;
}

/* СРОК (расчёт времени): GP2 = длина A-BFT (поле маяка × таблица C) + 0x5cd (1485 тактов =
 * 9 мкс = MBIFS между BTI и A-BFT, 802.11-2020 10.3.2.3.10, 10.42.5) − a0 — отсчёт от момента
 * команды 0x5400070e, а не от конца маяка. Вызывающий (bti.c) компенсирует задержку «конец
 * маяка → эта команда» фиксированными 4 мкс (a0 = (4 − Duration)·0xa5, GP0 = (Duration − 4)·0xa5).
 * Здесь ~25 инструкций (mul64, без деления); весь путь от r42.12 — в bti.c. Запас: не оценён;
 * отклонение нашего пути от vendor-ских ~4 мкс сдвигает границы A-BFT станции на ту же величину. */
void bf_gpc_program_mac_by_mode_b(u32 a0)
{
    u32 mode = (bcn_rx.bi_ctrl[1] >> 2) & 0xf;
    if (mode < 4) {
        uc_assert((u32)__builtin_return_address(0), 0x1471);
        mode = (bcn_rx.bi_ctrl[1] >> 2) & 0xf;  /* vendor продолжает после assert */
    }
    u32 r3 = period_tab[mode - 4];   /* ldw.as = x2 */
    u32 f = ((bcn_rx.bi_ctrl[1] << 8) | bcn_rx.bi_ctrl[0]) >> 7;
    u32 v = (f & 7) + 1;
#ifdef UC_ABFT_STA_STD
    /* Конец A-BFT станции: граница слота 0 (MBIFS) + n·aSSSlotTime + хвост 3 мкс (как vendor, см. abft.h). */
    u32 r4 = (v * r3 + ABFT_STA_STD_SLOT0_CLK + ABFT_STA_STD_TAIL_CLK - a0) | 0x51000000;
#else
    u32 r4 = (v * r3 + ABFT_V62_STA_END_CLK - a0) | 0x51000000;
#endif
    uc_mac_cmd(r4);
    uc_mac_cmd(0x5400070e);
    uc_mac_cmd(0x49000100);
}

u32 bf_abort_unexpected(u32 a0, u32 a1)
{
    u32 r13 = a0;
    u8 *tbl = bf_req.fifo;

    if (bf_req.pending_mask == 0) {
        bf_req_enqueue((u32)(u8)r13, a1, (u32)&bf_req_desc_default);   /* L_92b384: r1 = a1 не тронут */
        return 1;
    }

    u8 r0 = tbl[bf_req.head & 0x7];
    if (r13 == r0) {
        bf_sta[r13].state = a1;
        bf_sta[r13].flow_status = 0;
        if ((VOL(link_stat[r13].bf_reasons) & 0x40) != 0)
            bf_reset_sta_slot(r13);
        return 1;
    }

    u32 r0d = 0;
    u32 r2 = bf_req.pending_mask;
    if ((r2 & (1u << 8)) != 0) {
        u32 r3 = bf_req.pending_mask;
        if ((r3 & (1u << r13)) == 0) {      /* 0x92b290: bbit1 → пропуск */
            u8 r3c = tbl[bf_req.head & 0x7];
            if (r3c == 8)
                r0d = 1;
        }
    }

    if (r0d != 0) {
        bf_req.pending_mask = (bf_req.pending_mask & ~(1u << 8)) | (1u << r13);
        tbl[bf_req.head & 0x7] = (u8)r13;
        bf_sta[r13].state = a1;
        bf_sta[r13].flow_status = 0;
        if ((VOL(link_stat[r13].bf_reasons) & 0x40) != 0)
            bf_reset_sta_slot(r13);
        return 1;
    }

    u8 r16 = tbl[bf_req.head & 0x7];
    volatile struct bf_sta_s *e = &bf_sta[r16];   /* vendor пишет flow_status дважды (0, 0x35) */
    if (r13 == 8) {
        uc_log_emit2(0x21, 0x1000bf8, r13, r16);
        e->state = 0xb; e->flow_status = 0; e->flow_status = 0x35;
        bf_abort_step(r16);
        sls_clear_rx_state();
        return 0;
    }

    uc_log_emit2(0x21, 0x1000bb8, r13, r16);
    bf_req.pending_mask = (bf_req.pending_mask & ~(1u << r16)) | (1u << r13);
    tbl[bf_req.head & 0x7] = (u8)r13;
    volatile struct bf_sta_s *f = &bf_sta[r13];
    f->state = 0xb; f->flow_status = 0; f->flow_status = 0x35;
    e->state = 0xb; e->flow_status = 0; e->flow_status = 0x35;
    bf_abort_step(r13);
    sls_clear_rx_state();
    return 0;
}
