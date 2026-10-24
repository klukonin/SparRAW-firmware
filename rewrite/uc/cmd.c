// SPDX-License-Identifier: AGPL-3.0-or-later
/* Обработчики ucode-команд от драйвера. */
#include "../include/types.h"
#include "../include/bitfield.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/sta_max.h"
#include "abft.h"



void keep_alive_arm_slot(u32 a)          /* 6.2 asm 0x939484 */
{
    itx_ka_pending |= 1u << a;
    internal_tx_check_idle(2);
    uc_res_vote_acquire(2);
    if (bf_req.pending_mask != 0)
        FWSH(ll_ctx, pending_mask) |= 1u << a;
    VOL(link_stat[a].ka_fail) = 0;
    VOL(link_stat[a].ka_cca_busy) = 0;
}
/* a == 8 проходит проверку и адресует rs_state[8] = rs_stats[0], rs_stats[8] = rs_cfg[0],
 * rs_start_cnt[8] = rs_end_cnt[0]. Достижимость не доказана: единственный отправитель LMAC 0x30
 * в fw 6.2 (hw_sysapi_force_mcs 0x8cdde8) шлёт только cid < 8, у LMAC 0x12 отправителя нет;
 * остаётся путь bf_req_dequeue_head → sta_apply_bf_result (номер станции из очереди BF). */
u32 rs_start(u32 a, u32 b)              /* 6.2 asm 0x9300ec */
{
    /* 0x9300f6: breq r0,0x8 → return 0. Индекс 8 (широковещательный vring, только AP/PCP)
     * вышел бы за массивы rs_state/rs_stats (8 станций) в rs_stats[0]/rs_cfg[0]; было
     * `a != 8 && …` — AP не отвечал на probe (стенд 2026-10-19, uc_bisect --goal ap). */
    if (a == SPARRAW_PEER_UNKNOWN || rs_is_sta_enabled(a) == 0)
        return 0;
    if (b != 0)
        return 0;
    struct rs_sta_state *st = &rs_state[a];
    if (st->active != 0)
        uc_assert((u32)__builtin_return_address(0), 0x66);
    mac_program_qset_slots();
    rs_start_cnt[a] += 1;
    u32 r17 = arc_lr(ARC_STATUS32);
    arc_flag(r17 & ~2u);
    struct rs_sta_stats *rs = &rs_stats[a];
    u32 mcs = sched_bitmap_prev_set_bit(a, rs->mcs_final);
    memset0_words_uc(rs, sizeof(*rs));
    memset0_words_uc(st, sizeof(*st));
    st->active = 1;
    rs->mcs_final = (u8)mcs;
    rs->warmup = 1;
    if (mcs == 0)
        mcs = sched_bitmap_next_set_bit(a, 1);
    rs->mcs_try = (u8)mcs;
    memset0_words_uc(rs->back_fail, sizeof(rs->back_fail));
    arc_flag((r17 & 2u) | arc_lr(ARC_STATUS32));
    uc_log_emit2(0x20, 0x1001380, a, rs->mcs_try);
    rate_search_apply_mcs(rs->mcs_try, a);
    if (rs_sta_flags[a] & 0x80) {
        rs_pending_mask = 1u << a;
        st->phase = 1;
        st->phase_prev = 1;
        st->active = 0;
        rs_end();
    }
    return 1;
}
/* СРОК: r40 (BACKOFF_IFS_STATUS) читается не раньше 3 тактов после 0x1d (аппаратный: задержка
 * локального чтения MAC); idle_detect == 5 ждётся без ограничения. От mov r32 до первого чтения r40
 * 9 инструкций (vendor 0x92c5e4: 9), опрос 7 инструкций на проход (vendor 6); запас по задержке
 * чтения — единицы инструкций. Срыв: раннее чтение даёт значение прежнего селектора (ложный выход
 * при совпадении с 5); если MAC не придёт в 5 — uc висит до сторожевого L2 (в ucode_cmd_0x01_handler
 * — с запрещёнными прерываниями). Вызывается на пути RX→TX ответа (mac_mode_switch_core_and_rf). */
void mac_rf_switch_cmd1f(u32 a)          /* 6.2 asm 0x92c5e4 */
{
    uc_mac_cmd(0x1f000601);
    u32 g = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = g;
    uc_mac_cmd(g | 0x1d000000);
    arc_nops_nop(2);   /* vendor L_92c628: 2×nop_s + mov 0,0 */
    do {
        VOL(rf_switch_wait_cnt) += 1;   /* vendor: ld/st на каждой итерации */
    } while ((arc_core_rd(40) & 0x7) != 5);
    if (a == 1)
        uc_mac_cmd(0x1f003000);
    rf_switch_wait_cnt = 0;
}



void ucode_cmd08_noop_hook(void)
{
}

void ucode_cmd_0x26_handler(u32 a)
{
    keep_alive_arm_slot(*(u8 *)a);
}

void ucode_cmd_0x49_handler(u32 a)
{
    ctrl_frame_mcs = *(u8 *)a;
}

void ucode_cmd_0x23_handler(u32 a)
{
    ucode_cmd_load_table_803124_803128((u32)&bi_ctx, a);
}

void ucode_cmd_0x3b_handler(u32 a)
{
    brp_snr_cfg_enable = a;
}

void ucode_cmd_0x4a_handler(u32 a)
{
    l1_time_thresh = *(u32 *)a << 4;
}

void ucode_cmd_0x47_handler(const struct lmac_cmd_fsched_peer *c)
{
    peer_masks_update_sta_bit(&fsched_peers, c->vr, c->on);
}

void ucode_cmd_0x11_handler(u32 a)
{
    memcpy_uc((void *)&agc_cfg, (const void *)a, sizeof(agc_cfg));
}

void ucode_cmd_0x16_handler(u32 a)
{
    memcpy_uc((void *)&calib_gain_ofs, (const void *)a, 4);
}

void ucode_cmd_0x12_handler_uc(u32 a)
{
    rs_abort(*(u8 *)a);
    rs_start(*(u8 *)a, 0);
}


void bi_latch_tsf_and_reset(u32 a)     /* 6.2 asm 0x92b9d4 */
{
    if (a == 0)
        mac_rx_off_seq();
    else if (a == 1)
        uc_pm_enter_idle(1);
    else
        uc_assert((u32)__builtin_return_address(0), 0x80);
    rx_on_tsf = uc_read_tsf_lo();
    rx_on_state = 0;
    uc_set_evt_id_5c(1);
}

void ucode_cmd_0x03_handler(u32 a)
{
    if (rx_on_state != 0)                           /* ldh.as [gp,74]: ×2 = 0x8005bc */
        bi_latch_tsf_and_reset(*(u32 *)a);
    uc_send_evt_typed(3, 0);                             /* ответ на команду */
}


void ucode_cmd_apply_mac_cfg(u32 a)
{
    memcpy_uc(mac_cfg, (const void *)a, 0x30);
    mac_program_886e0c_20b((u32)mac_cfg);
}

void ucode_cmd_0x21_set_txop_limits(u32 a)
{
    for (u32 i = 0; i < 4; i++)
        txop_limit_us[i] = *(u16 *)(a + i * 2);   /* ldw.as=×2, dest 0x80294c+i*4 */
    txop_apply_limits_regs(0);
}

void ucode_cmd_0x20_handler(u32 a)
{
    memcpy_uc(cmd20_cfg, (const void *)a, 0x24);
}


void ucode_cmd_echo(u32 a)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    ((struct lmac_cmd_echo *)evt)->value = ((const struct lmac_cmd_echo *)a)->value;
    uc_evt_enqueue(evt, 2, 4, 0);
}


/* 0x93cbf0 */
void ucode_cmd_selective_neighbor_cfg(const struct lmac_cmd_sel_nbr *c)
{
    sel_nbr.cap = (c->cap_en == 1) ? sel_nbr.cap_default : 0;
    sel_nbr.cfg_a = c->b_en;
    sel_nbr.threshold = c->threshold;
    sel_nbr.cfg_b = c->b_val;
    short_txop_en = c->short_txop;                   /* st.as [gp,8] */
    sel_nbr_rs_param = c->rs_param;
}

void ucode_cmd_0x10_handler(const struct lmac_cmd_bf_ctrl *c)
{
    /* 0x9220d4: копия полей команды в 0x8021b8. */
    bf_ctrl.ctrl_code_tx = c->ctrl_code_tx;
    bf_ctrl.ctrl_code_tx_alt = c->ctrl_code_tx_alt;
    bf_ctrl.ctrl_code_rx = c->ctrl_code_rx;
    bf_ctrl.ctrl_code_rx_alt = c->ctrl_code_rx_alt;
    /* rsub r2,r1,0x20; bset r1,r1,r2  → бит (0x20 - байт) mod 32 */
    bf_ctrl.stat_bit = 1u << ((0x20 - c->stat_shift) & 0x1f);
    bf_ctrl.cmd10_w0 = c->w0;
    bf_ctrl.txss_mode = c->txss_mode;
    bf_ctrl.brp_mode = c->brp_mode;
}

/* 0x921990 */
void ucode_cmd_trigger_bf(u32 a)
{
    if (lmac_personality != 1) {                        /* ld_s [gp,180] */
        bf_init_sm(a, 1);
        return;
    }
    ucode_pm_set_busy_flag(0);
    uc_tx_is_idle();
    VOL(link_stat[((const struct lmac_cmd_trigger_bf *)a)->cid].bf_reasons) |= 1u << 4;
}

/* Общая часть обработчиков 0x2a/0x2e/0x3c (vendor 0x935de4/0x92811c/0x924dcc):
 * ucode_cmd_28_apply(a, kind); при 0 — assert (но продолжение); 5 байт параметров → a+0x24;
 * [a+0x20] = 0-базовый указатель обработчика завершения. */
static void ucode_cmd_28_family(struct rx_meas_ctx *m, u32 b, u32 kind, u32 acode, u32 cb)
{
    if (ucode_cmd_28_apply(m, kind) == 0)
        uc_assert((u32)__builtin_return_address(0), acode);
    u8 *f = (u8 *)&m->filt;
    for (u32 i = 0; i < sizeof(m->filt); i++)
        f[i] = *(u8 *)(b + i);
    m->report_cb = cb;
}
void ucode_cmd_0x37_handler(struct rx_meas_ctx *m, u32 b)
{
    /* 0x92e47c */
    ucode_cmd_28_apply(m, RX_MEAS_PHYSTAT);
    memcpy_uc(&m->filt, (const void *)b, sizeof(m->filt));
    m->report_cb = VENDOR_CB(92e468);           /* bf_req_report_26_cb */
    memset0_words_uc((void *)&fwsh_phy.st, sizeof(fwsh_phy.st));
    phy_stats_clear_counters_883960();
}

void ucode_cmd_0x19_handler(const struct lmac_cmd_rf_chain *c)
{
    /* 0x93a7a0: собрать слово в 0x801024 из 3 битовых полей. */
    u32 buf = 0;
    bf_set32((u32)&buf, 8, 15, c->sector & 0x7fff);
    bf_set32((u32)&buf, 0, 4, c->rf & 0xf);
    bf_set32((u32)&buf, 4, 4, 2);
    rf_chain_word = buf;
    rf_chain_word_host_set = 1;
}

void ucode_cmd_0x3c_handler(struct rx_meas_ctx *m, u32 b)
{
    ucode_cmd_28_family(m, b, RX_MEAS_CHEST, 0xf4, VENDOR_CB(924e9c));   /* bf_req_claim_and_report_2b */
}
void ucode_cmd_0x2e_handler(struct rx_meas_ctx *m, u32 b)
{
    ucode_cmd_28_family(m, b, RX_MEAS_PKT, 0xa1, VENDOR_CB(9281f8));   /* bf_req_claim_and_report_23 */
    memset0_words_uc(&m->pkt, sizeof(m->pkt));
}
void ucode_cmd_0x2a_handler(struct rx_meas_ctx *m, u32 b)
{
    ucode_cmd_28_family(m, b, RX_MEAS_PLCP, 0xa8, VENDOR_CB(92490c));   /* bf_req_report_21_cb */
    memset0_words_uc(&m->plcp, sizeof(m->plcp));
}

void ucode_cmd_0b_apply(struct ss_cfg_s *d, const struct ss_cfg_s *s)
{
    if (d->x0 == 1)
        return;
    u8 r13 = s->n_frames;
    if (d->host_set == 1)
        r13 = (r13 < d->n_frames) ? r13 : d->n_frames;
    memcpy_uc(d->order, s->order, sizeof(d->order));
    d->n_frames = r13;
    d->x49 = s->x49;
}

void ucode_cmd_0x41_handler(u32 a)
{
    (void)a;
    uc_log_emit_snapshot(0x20, 0x10015e0);
    u16 v = (fwsh_long_range != 0) ? 10 : DMG_RESP_TIMEOUT_SLOTS;   /* AckTimeout/CTSTimeout в слотах (ifs.h); long range — 10 */
    resp_wait_slots = v;                                /* sth.as [gp,-16] */
    busy_wait_slots = v;                                /* sth.as [gp,-15] */
    arc_protect_addr_uc(0, UC_WPROT_FW_SRAM, UC_WPROT_FW_SRAM_MASK);
}

u32 ucode_cmd_28_apply(struct rx_meas_ctx *m, u32 b)
{
    /* 6.2 asm 0x935e30: занято (busy && !done) -> 0; иначе инициализировать запрос
     * (вид b, ждёт кадра) и снять TSF -> 1. */
    if (m->busy != 0 && m->done == 0)
        return 0;
    buf_fill_ff(m);
    m->kind = b;
    m->state = 2;
    m->busy = 1;
    m->done = 0;
    mac_read_tsf64_uc(m->tsf);
    return 1;
}

u32 ucode_cmd_0x28_handler(struct rx_meas_ctx *m, u32 b, u32 c)
{
    /* 6.2 asm 0x935d90: b = команда (фильтр), c = [b+8] — число отсчётов. */
    if (ucode_cmd_28_apply(m, RX_MEAS_ENERGY) == 0)
        uc_assert((u32)__builtin_return_address(0), 0x99);
    m->n_max = (c >= 0x15) ? 0x14 : c;
    const struct lmac_cmd_meas_filter *f = (const void *)b;
    m->filt.no_mcs = f->no_mcs;
    m->filt.mcs = f->mcs;
    m->filt.mode = f->mode;
    m->filt.cid = f->cid;
    m->filt.rx_mode = f->rx_mode;
    m->report_cb = VENDOR_CB(924898);           /* bf_req_report_20_cb */
    m->n = 0;
    return 0;
}

void ucode_cmd_0x48_handler(u32 a)
{
    (void)a;
    u16 *d = (u16 *)irq_safe_deref_field_04(&uc_mbox);
    d[0] = VOL(fsched_flush_stats.slots);
    d[1] = VOL(fsched_flush_stats.flushes);
    d[2] = VOL(fsched_flush_stats.qword_end) - VOL(fsched_flush_stats.qword_start);
    d[3] = VOL(fsched_flush_stats.last_sent);
    d[4] = VOL(fsched_flush_stats.last_flushed);
    d[5] = VOL(fsched_flush_stats.sum_sent);
    d[6] = VOL(fsched_flush_stats.sum_flushed);
    uc_evt_enqueue((u32)d, 0x2f, 0xe, 0);
    memset0_words_uc((void *)&fsched_flush_stats, 0x10);
}
void wmi_cmd_txss_set_sectors_order(const struct lmac_cmd_ss_order *c)
{
    /* 0x93e1c0: скопировать 76-байтный порядок секторов в набор c->set (< 9). */
    if (c->target == 1)
        return;
    u8 set = c->set;
    uc_log_emit1(0x20, 0x10019d0, set);
    if (c->set >= 9)
        uc_assert((u32)__builtin_return_address(0), 0x136c);
    /* исправлено (vendor): n_frames не проверялся — 0 давал SSW с сектором 0xff (терминатор плана), > 64 —
     * CDOWN от полного числа при плане из 64 (CDOWN 0 не доходил до пира, 10.42.2.2). */
    if (c->ss.n_frames == 0)
        return;
    memcpy_uc(&txss_ss[c->set], &c->ss, sizeof(struct ss_cfg_s));
    if (txss_ss[c->set].n_frames > 0x40)
        txss_ss[c->set].n_frames = 0x40;
}
void wmi_cmd_txss_set_sectors_number(u32 a)
{
    /* 0x93e168: a[1] — число секторов, a[2] — индекс набора txss_ss (< 9). */
    u8 *p = (u8 *)a;
    if (p[1] == 0)
        return;
    uc_log_emit2(0x20, 0x1001a04, p[2], p[1]);
    if (p[2] >= 9)
        uc_assert((u32)__builtin_return_address(0), 0x136d);
    update_sector_sweep_frames_number((u32)&txss_ss[p[2]], p[1]);
    txss_ss[p[2]].host_set = 1;
}

/* ---- Крупные хендлеры (структурные порты) ---- */

/* 0x93a8d0: конфигурация MAC (команда 0). */
void ucode_cmd_0x00_handler(const struct lmac_cmd_mac_cfg *c)
{
    rf_chain_cfg = c->rf_chain;                     /* st.as [gp,-3] */
    ucode_cmd_apply_mac_cfg((u32)c);
    memcpy_uc(ifs_cfg_us, c->ifs_us, sizeof(c->ifs_us));
    txrx_api_step_b_uc((u32)ifs_cfg_us);
    u16 v = (fwsh_long_range != 0) ? 10 : DMG_RESP_TIMEOUT_SLOTS;   /* AckTimeout/CTSTimeout в слотах (ifs.h); long range — 10 */
    resp_wait_slots = v;                               /* sth.as [gp,-16] */
    busy_wait_slots = v;                               /* sth.as [gp,-15] */
    mac_cfg_set_gp20_default_15748();
    u32 r0 = MMIO32(HW_PRS_MCAST_ADDR_LO);
    u32 r1 = MMIO32(HW_PRS_MCAST_ADDR_HI);
    ((u16 *)prs_mcast_addr)[0] = (u16)r0;                         /* sth.as [gp,94] */
    ((u16 *)prs_mcast_addr)[1] = (u16)(r0 >> 16);                 /* sth.as [gp,95] */
    ((u16 *)prs_mcast_addr)[2] = (u16)r1;                         /* sth.as [gp,96] (слот bl.d) */
    mac_cmd_56_57();
    sta_tab[SPARRAW_PEER_UNKNOWN].peer_n_ant = 1;
    sta_tab[SPARRAW_PEER_UNKNOWN].peer_n_sectors = 0x40;
    rss_wait_clk[SPARRAW_PEER_UNKNOWN] = 0x29528;
    abif_dvs_rf_ctrl_shadow = MMIO32(HW_ABIF_DVS_RF_CTRL);     /* st.as [gp,94] (слот bl.d) */
    rf_compute_tx_rx_sets();
}

void ucode_cmd_0x04_handler_uc(u32 a)
{
    for (u32 i = 0; i < 4; i++) {                    /* записи по 12 байт (asl 2 + add1) */
        u32 v = *(u32 *)(a + i * 12);
        if (v < 4)                                   /* blc: беззнаковое < */
            txrx_api_step_c(v, a + i * 12);
    }
}

void ucode_cmd_0x07_handler(const struct lmac_cmd_qset_ranges *c)
{
    u32 sub = c->sub;
    if (sub == 1) {
        u32 v = c->range_q4_q5;
        u32 lo = v & 0x1f, hi = (v >> 8) & 0x1f;
        qset_shadow.qset4_range = (1u << hi) | ((1u << hi) - (1u << lo));
        lo = (v >> 16) & 0x1f; hi = (v >> 24) & 0x1f;
        qset_shadow.qset5_range = (1u << hi) | ((1u << hi) - (1u << lo));
    } else if (sub == 2) {
        u32 v = c->range_q6;
        u32 lo = v & 0x1f, hi = (v >> 8) & 0x1f;
        qset_shadow.qset6_range = (1u << hi) | ((1u << hi) - (1u << lo));
    } else if (sub != 0) {
        uc_assert((u32)__builtin_return_address(0), 0x82);
    }
    mac_qset_reset_masks();
}

void ucode_cmd_0x18_handler(const struct lmac_cmd_sta_field *c)
{
    u32 sta = c->sta;
    struct sta_entry *base = &sta_tab[sta];
    u32 dst = c->offset + (u32)base;                /* смещение поля в записи (ключ — +0x38) */
    u32 len = c->len;
    if (len >= 0x11)                            /* vendor: assert и копирует исходную длину */
        uc_assert((u32)__builtin_return_address(0), 0x81);
    memcpy_uc((void *)dst, c->data, len);
    u32 mode = c->mode;
    if (mode == 0 || mode == 4)
        sta_tab[sta].key_valid = 1;
    else if (mode == 1)
        sta_tab[sta].key_valid = 0;
    else if (mode == 8) {
        u32 b = sta_tab[sta].peer_n_sectors;
        u32 m = b * 0xa40;
        u32 c = fwsh_n_rx_ant;
        rss_wait_clk[sta] = c * (m + 0x528);   /* add2_s — ×4 */
    }
    uc_send_evt_sta_update_field_rsp(sta, mode);
}

/* 0x93b924 */
void ucode_cmd_0x0c_handler(u32 a)
{
    u32 idx = *(u8 *)a;
    if (idx >= SPARRAW_STA_SLOTS)
        uc_assert((u32)__builtin_return_address(0), 0xfd);   /* возвращается, индекс прежний */
    struct ss_cfg_s *ss = &txss_ss[idx];
    ucode_cmd_0b_apply(ss, &((const struct lmac_cmd_sta_sweep *)a)->ss);
    u32 b = sta_tab[idx].peer_n_ant;
    u32 e2 = (u32)txss_timing[idx];                    /* add3 */
    txss_sweep_timing(e2, ss->n_frames, b);
    u32 r = (u8)((b - 1) + ss->n_frames * b);
    txss_set_sweep_param(e2, ss, b, 0, r, ss->x49);
    sta_mode_word[idx] = (ss_plan_rf_sector << 8) | (rf_chain_cfg | 0x30);   /* [gp,-12] */
}

/* 0x93a830 */
void ucode_cmd_0x24_handler(const struct lmac_cmd_discovery *c)
{
    u32 v = c->type;
    discovery_type = (u8)v;                            /* stb [gp,-240] */
    u32 mode = c->mode;
    if (mode == 1) {
        uc_log_emit3(0x20, 0x1001444, (u8)v, bf_req.tail, bf_req.head);
        uc_log_emit1(0x20, 0x1001488, bf_req.pending_mask);
        discovery_on = 1;                           /* vendor здесь же снимал UPM на время discovery */                           /* st.as [gp,-32] */
    } else if (mode == 0) {
        uc_log_emit3(0x20, 0x10014a4, (u8)v, bf_req.tail, bf_req.head);
        uc_log_emit1(0x20, 0x1001488, bf_req.pending_mask);
        discovery_on = 0;
        if (bf_req.tail > bf_req.head)
            bf_clear_all_sta();
    } else {
        uc_assert((u32)__builtin_return_address(0), 0x104);
    }
}

void ucode_cmd_0x30_handler_uc(const struct lmac_cmd_sta_byte2 *c)
{
    rs_abort(c->cid);                                   /* vendor: сначала abort */
    u32 bit = c->mode & 1;
    u8 *p = &rs_sta_flags[c->cid];
    *p = (*p & ~(1u << 7)) | (bit << 7);
    bits_set_u8_s0_w7_uc((u32)p, c->val & 0x7f);       /* bmsk 6 */
    rs_start(c->cid, 0);
}

void ucode_cmd_0x32_handler(const struct lmac_cmd_sta_byte2 *c)
{
    u32 sta = c->cid;
    u32 b1 = c->mode & 3;
    bits_set_u8_s6_w2_uc((u32)&brp_rf_cfg.sta_sel[sta], b1);
    u32 b2 = c->val & 0x3f;
    bits_set_u8_s0_w6_uc((u32)&brp_rf_cfg.sta_sel[sta], b2);
}

static void ucode_cmd_snap_r40(struct rx_meas_ctx *m, u32 b, u32 mode);
void ucode_cmd_0x38_handler(struct rx_meas_ctx *m, u32 b) { ucode_cmd_snap_r40(m, b, RX_MEAS_PHYSTAT); }
/* Обработчики 0x29/0x2b/0x2f/0x38/0x3d (vendor 0x936014 и т. д.): для режима mode и
 * состояния 2 — снимок r40 в группах 0x5000/0x6000 → a+0x18/0x1c, [a+0xc] = b. */
/* СРОК: st r40 не раньше 3 тактов после 0x1d (аппаратный): между mov r32 и чтением 5 инструкций
 * (st.ab, bclr, 3×nop — как vendor 0x936014); запас — единицы инструкций. TSF_LOW и TSF_HIGH —
 * разные выборки (~12 инструкций между чтениями), см. mac_read_tsf64_uc. */
static void ucode_cmd_snap_r40(struct rx_meas_ctx *m, u32 b, u32 mode)
{
    if (!(m->kind == mode && m->state == 2))
        return;
    u32 cfg = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = cfg | (1u << 12) | (1u << 14);
    uc_mac_cmd(cfg | 0x1d005000);
    arc_nops(3);
    __asm__ volatile("st r40,[%0]" :: "r"(&m->snap_sel5) : "memory");
    cfg = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = cfg | (1u << 13) | (1u << 14);
    uc_mac_cmd(cfg | 0x1d006000);
    arc_nops(3);
    __asm__ volatile("st r40,[%0]" :: "r"(&m->snap_sel6) : "memory");
    m->state = b;
    bf_pending_set_bit(0);
}

void ucode_cmd_0x29_handler(struct rx_meas_ctx *m, u32 b) { ucode_cmd_snap_r40(m, b, RX_MEAS_ENERGY); }
void ucode_cmd_0x2b_handler(struct rx_meas_ctx *m, u32 b) { ucode_cmd_snap_r40(m, b, RX_MEAS_PLCP); }
void ucode_cmd_0x2f_handler(struct rx_meas_ctx *m, u32 b) { ucode_cmd_snap_r40(m, b, RX_MEAS_PKT); }
void ucode_cmd_0x3d_handler(struct rx_meas_ctx *m, u32 b) { ucode_cmd_snap_r40(m, b, RX_MEAS_CHEST); }

/* 0x92fcc4 */
void ucode_cmd_0x13_handler(const struct lmac_cmd_rs_cfg *c)
{
    u32 r14 = 0;
    if (c->enable != 0) {
        uc_log_emit1(0x20, 0x10013d0, c->enable);
        u32 sta = c->cid;
        if (rs_state[sta].active != 0) {
            uc_log_emit1(0x20, 0x10013e0, sta);
            rs_abort(c->cid);
            r14 = 1;
        }
        rs_enabled_mask |= 1u << c->cid;             /* [gp,-8] */
        memcpy_uc(&rs_cfg[c->cid], c->cfg, sizeof(struct rs_sta_cfg));
        if (r14 == 1) {
            uc_log_emit1(0x20, 0x1001400, r14);
            rs_start(c->cid, 0);
        }
    } else {
        uc_log_emit1(0x20, 0x1001414, c->cid);
        rs_enabled_mask &= ~(1u << c->cid);
        ucode_pm_set_busy_flag(r14);
    }
}


void get_selected_rf_sector_index_cmd_handler(const struct lmac_cmd_rf_sector_sel *c)
{
    /* 0x928224 */
    u8 buf[16];
    memset0_words_uc(buf, 0x10);
    u32 sub = c->sub;
    u32 sta = c->cid;
    if (sub == 1 || sub == 0) {
        u32 sel = (sub == 1) ? sta_tab[sta].tx_sel : sta_tab[sta].rx_sel;
        *(u16 *)buf = (sel >> 8) & 0x7fff;          /* bmsk 0xe */
    } else {
        uc_log_emit2(0, 0x1001530, sub, sta);
        uc_assert((u32)__builtin_return_address(0), 261);
    }
    mac_read_tsf64_uc((u32 *)(buf + 8));
    buf[2] = 0;
    uc_send_evt_get_rf_sector_done((u32)buf);
}

void set_selected_rf_sector_index_cmd_handler(const struct lmac_cmd_rf_sector_sel *c)
{
    u32 buf[4] = {0};
    u32 sub = c->sub;
    u32 sta = c->cid;
    u16 v = c->sector;
    if (sub == 1) {
        if (v != 0xffff) {
            bf_ctrl.tx_sector_force = 1;
            bf_ctrl.tx_sector = (u8)v;
            sta_set_tx_sector(sta, v, *(volatile u8 *)((u32)fwsh_sls_rank_b1 + 1 + sta * 0x3c), 1);
        } else {
            bf_ctrl.tx_sector_force = 0;
            bf_ctrl.tx_sector = 0;
        }
    } else if (sub == 0) {
        if (v != 0xffff) {
            bf_ctrl.rx_sector_force = 1;
            bf_ctrl.rx_sector = (u8)v;
            sta_set_rx_sector(sta, v);
        } else {
            bf_ctrl.rx_sector_force = 0;
            bf_ctrl.rx_sector = 0;
        }
    } else {
        uc_log_emit2(0x20, 0x1001588, sub, sta);
        uc_assert((u32)__builtin_return_address(0), 0x106);
    }
    uc_send_evt_set_rf_sector_done((u32)buf);
}

void txrx_umac_if_config_pmc_triggers_handler(u32 a)
{
    const struct lmac_cmd_meas_filter *c = (const void *)a;
    /* cid отдельным чтением: в одном выражении gcc сливает два ldb соседних полей в ldw. */
    u8 cid = c->cid;
    if (cid == 0xff && c->mode == 0xff) {
        uc_log_emit_snapshot(0x10, 0x1001620);
        pmc_stop_recording();
        pmc_trig.armed = 0;
    } else {
        if (pmc_trig.armed != 0) {
            uc_log_emit_snapshot(0x10, 0x100165c);
            pmc_stop_recording();
        }
        memcpy_uc((void *)&pmc_trig, c, sizeof(*c));
        pmc_trig.armed = 1;
        pmc_trig.recording = 0;
    }
}

void fwif_write_qh(const struct lmac_cmd_write_qh *c)
{
    u32 sta = c->q;
    u32 sub = c->flags;
    uc_log_emit2(0x20, 0x10011b4, sta, sub);
    (void)sub;
    if (peer_lookup_if_fixed_sched(c->q) == 0)       /* bl.d L_926890; brne_s r0,0 */
        qh_write_by_flags(c->q, c->flags, (u32)c->desc, c->n);
    else
        sched_cfg_merge_update(c);
}

void ss_copy_cfg_from_cmd(const struct lmac_cmd_ss_order *c)
{
    /* L_93e152: r1 = c (сама команда), target ≠ 0 — конфиг и для маяка */
    if (c->target != 0)
        memcpy_uc(&bti_sw.bcn_ss, &c->ss, sizeof(bti_sw.bcn_ss));
}

void ss_update_frames_number(u32 a)
{
    u32 en = *(u8 *)a;
    if (en != 0) {
        bti_sw.bcn_ss.host_set = 1;
        update_sector_sweep_frames_number((u32)&bti_sw.bcn_ss, *(u8 *)a);
    }
}

void txrx_api_cmd_step(const struct lmac_cmd_rx_on *a)
{
    u32 v0 = a->start_lo;
    u32 v1 = a->start_hi;
    u32 c = a->role_bits;
    u32 d = a->bi_len_us;
    u32 r19 = c & 1;
    u32 r18 = (c >> 2) & 1;
    u32 r17 = (c >> 1) & 1;
    u32 flags = a->flags;
    u32 cmd;
    if (flags & 1) {
        rx_nav_set_flag_b1_if_enabled(0);
        bcn_bi.bi_len_us = d;
        if (v1 == 0 && v0 < d) {                     /* 64-бит {v1,v0} < {0,d} */
            u64 t = ((u64)v1 << 32 | v0) + d;
            v0 = (u32)t;
            v1 = (u32)(t >> 32);
        }
        *(volatile u32 *)HW_MAC_BEACON_INTERVAL = d >> 0xa;
        *(volatile u32 *)HW_MAC_CMD0D_TIME_LO = v0;
        *(volatile u32 *)HW_MAC_CMD0D_TIME_HI = v1;
        arc_sync();
        uc_mac_cmd(0xd000006);
        cmd = 0xd000053u | (r19 << 9) | (r17 << 10) | (r18 << 11);
        cmd |= (1u << 12) | (1u << 17) | (1u << 19);
        uc_mac_cmd(cmd);
        mac_program_deadline_slack(*(volatile u32 *)&bcn_bi.bi_len_us, 7, 0x50);   /* vendor перечитывает [0x8022a4] */
    } else {
        cmd = 0xd000053u | (r19 << 9) | (r17 << 10) | (r18 << 11);
        cmd |= (1u << 12) | (1u << 17) | (1u << 19);
        uc_mac_cmd(cmd);
    }
}

/* 0x9368d8 */
void txrx_api_step_c(u32 a, u32 b)
{
    const struct lmac_edca_ac *e = (const void *)b;
    u32 i = a;
    u32 mask = (1u << e->ecw_min) - 1;
    MMIO32(HW_MAC_EDCA_AIFS + i * 4) = ((u32)e->aifsn << 28) | 0x201ff;   /* add2 = ×4 */
    MMIO32(HW_MAC_EDCA_SEED + i * 4) = 0xc0adc0adu << i;
    uc_mac_cmd(((i + 9) << 24) | mask);
    u32 bits = (1u << (i + 0x14)) | (1u << (i + 8));
    u32 m = (edca_ac_en_shadow & ~bits) | bits;          /* ld_s [gp,-28] / st.as [gp,-7] */
    edca_ac_en_shadow = m;
    uc_mac_cmd(m | (1u << 24) | (1u << 25) | (1u << 26));
    u8 *p = (u8 *)&qset_slot[i];
    p[0] = (u8)e->ecw_min;
    p[2] = (u8)e->ecw_min;
    p[1] = (u8)e->ecw_max;
}

void txrx_api_step_b_uc(u32 a)
{
    /* 0x936acc: входы — u16 (ldw_s), выход — пары {mod,div} по 2 байта в 0x802968. */
    u16 *c = (u16 *)a;
    mac_clk_div165(c[0], (u32)&ifs.sifs);
    mac_clk_div165(c[0] * 3, (u32)&ifs.mbifs);   /* add1_s r0,r0,r0 = ×3 */
    mac_clk_div165(c[2], (u32)&ifs.slot);        /* ldw_s [r13,4] = c[2] */
    *(volatile u32 *)HW_MAC_IFS_SIFS = ifs.sifs | 0x1730000;
    *(volatile u32 *)HW_MAC_IFS_SLOT = ifs.slot | (1u << 22) | (1u << 24) | (1u << 25);
    *(volatile u32 *)HW_MAC_IFS_CONST_452 = 0x452;
    mac_clk_div165(c[0] + c[2], (u32)&ifs.pifs);
    mac_clk_div165(c[2] << 1, (u32)&ifs.two_slot);
    *(volatile u32 *)HW_MAC_IFS_PIFS_2SLOT = ifs.pifs | ((u32)ifs.two_slot << 16);
    mac_clk_div165(c[3], (u32)&ifs.c3);
    mac_clk_div165(c[4], (u32)&ifs.c4);
    *(volatile u32 *)HW_MAC_IFS_RIFS_SBIFS = ifs.c3 | ((u32)ifs.c4 << 16);
    *(volatile u32 *)HW_MAC_RX2TX_RESP_START = 0x100;
}

/* ---- Главный диспетчер ucode-команд (0x93c928) ---- */

void ucode_cmd_dispatch(u32 a, u32 b)
{
    /* 6.2 asm 0x93c928: id = [a+4] (u16), таблица 0x8019dc (75 записей); b — тело команды. */
    u32 *c = (u32 *)b;
    u32 tsf[2];
    const struct uc_evt_hdr *h = (const void *)a;
    uc_mac_cmd(h->type | 0xcd0000u);
    mac_read_tsf64_uc(tsf);
    switch (h->type) {
    case 0x00: ucode_cmd_0x00_handler((const struct lmac_cmd_mac_cfg *)b); break;
    case 0x01: ucode_cmd_0x01_handler((const struct lmac_cmd_rx_on *)b); break;
    case 0x02: ucode_cmd_echo(b); break;
    case 0x03: ucode_cmd_0x03_handler(b); break;
    case 0x04: ucode_cmd_0x04_handler_uc(b); break;
    case 0x05: ucode_cmd_0x05_handler((const struct lmac_cmd_sta_cfg *)b); break;
    case 0x06: uc_assert((u32)__builtin_return_address(0), 0xa3); break;
    case 0x07: ucode_cmd_0x07_handler((const struct lmac_cmd_qset_ranges *)b); break;
    case 0x08: ucode_cmd_0x08_handler((const struct lmac_cmd_vring_cfg *)b); break;
    case 0x09: ucode_cmd_trigger_bf(b); break;
    case 0x0b: ucode_cmd_0x0b_handler(b); break;
    case 0x0c: ucode_cmd_0x0c_handler(b); break;
    case 0x0f: ucode_cmd_0x0f_handler((const struct lmac_cmd_maint_sta *)b); break;
    case 0x10: ucode_cmd_0x10_handler((const struct lmac_cmd_bf_ctrl *)b); break;
    case 0x11: ucode_cmd_0x11_handler(b); break;
    case 0x12: ucode_cmd_0x12_handler_uc(b); break;
    case 0x13: ucode_cmd_0x13_handler((const struct lmac_cmd_rs_cfg *)b); break;
    case 0x14: bf_ctrl.triggers = c[0]; break;
    case 0x15: lmac_personality = c[0]; bf_failure_policy = c[1]; break;
    case 0x16: ucode_cmd_0x16_handler(b); break;
    case 0x18: ucode_cmd_0x18_handler((const struct lmac_cmd_sta_field *)b); break;
    case 0x19: ucode_cmd_0x19_handler((const struct lmac_cmd_rf_chain *)b); break;
    case 0x1b: ucode_cmd_0x1b_handler((const struct lmac_cmd_role *)b); break;
    case 0x1e: ucode_cmd_selective_neighbor_cfg((const struct lmac_cmd_sel_nbr *)b); break;
    case 0x20: ucode_cmd_0x20_handler(b); break;
    case 0x21: ucode_cmd_0x21_set_txop_limits(b); break;
    case 0x23: ucode_cmd_0x23_handler(b); break;
    case 0x24: ucode_cmd_0x24_handler((const struct lmac_cmd_discovery *)b); break;
    case 0x26: ucode_cmd_0x26_handler(b); break;
    case 0x28: ucode_cmd_0x28_handler(&rx_meas, b, c[2]); break;
    case 0x29: ucode_cmd_0x29_handler(&rx_meas, c[0]); break;
    case 0x2a: ucode_cmd_0x2a_handler(&rx_meas, b); break;
    case 0x2b: ucode_cmd_0x2b_handler(&rx_meas, c[0]); break;
    case 0x2e: ucode_cmd_0x2e_handler(&rx_meas, b); break;
    case 0x2f: ucode_cmd_0x2f_handler(&rx_meas, c[0]); break;
    case 0x30: ucode_cmd_0x30_handler_uc((const struct lmac_cmd_sta_byte2 *)b); break;
    case 0x32: ucode_cmd_0x32_handler((const struct lmac_cmd_sta_byte2 *)b); break;
    case 0x35: wmi_cmd_txss_set_sectors_order((const struct lmac_cmd_ss_order *)b);
               ss_copy_cfg_from_cmd((const struct lmac_cmd_ss_order *)b); break;
    case 0x36: wmi_cmd_txss_set_sectors_number(b); ss_update_frames_number(b); break;
    case 0x37: ucode_cmd_0x37_handler(&rx_meas, b); break;
    case 0x38: ucode_cmd_0x38_handler(&rx_meas, c[0]); break;
    case 0x39: get_selected_rf_sector_index_cmd_handler((const struct lmac_cmd_rf_sector_sel *)b); break;
    case 0x3a: set_selected_rf_sector_index_cmd_handler((const struct lmac_cmd_rf_sector_sel *)b); break;
    case 0x3b: ucode_cmd_0x3b_handler(c[0]); break;
    case 0x3c: ucode_cmd_0x3c_handler(&rx_meas, b); break;
    case 0x3d: ucode_cmd_0x3d_handler(&rx_meas, c[0]); break;
    case 0x3e: fsched_enabled = 1; fsched_qh_mode = 1; break;
    case 0x41: ucode_cmd_0x41_handler(b); break;
    case 0x42: txrx_umac_if_config_pmc_triggers_handler(b); break;
    case 0x45: fwif_write_qh((const struct lmac_cmd_write_qh *)b); break;
    case 0x47: ucode_cmd_0x47_handler((const struct lmac_cmd_fsched_peer *)b); break;
    case 0x48: ucode_cmd_0x48_handler(b); break;
    case 0x49: ucode_cmd_0x49_handler(b); break;
    case 0x4a: ucode_cmd_0x4a_handler(b); break;
    default:                                    /* 0x22,0x25,0x33,0x34 (расписание PS, Awake Window, UPM —
                                                   энергосбережение вырезано, см. fw/action.c psc_req_reject),
                                                   0x27 (отсрочка трафика при D3 PCIe — см. fw/vectors.c
                                                   pcie_pm_event_unsupported),
                                                   0x0a,0x0d,0x0e,0x17,0x1a,0x1c,0x1d,0x1f,0x3f,0x40,
                                                   0x2c,0x2d,0x31 (TOF/FTM/AoA — только SparRAW-pro),
                                                   0x43,0x44,0x46, > 0x4a */
        uc_assert((u32)__builtin_return_address(0), 0xa4);
        break;
    }
}

/* ---- Крупные хендлеры (структурные порты) ---- */
void ucode_cmd_0x01_handler(const struct lmac_cmd_rx_on *c)
{
    u32 r0 = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = r0 | (1u << 13) | (1u << 15);
    uc_mac_cmd(r0 | 0x1d00a000);
    arc_nops(3);   /* vendor: MAC обновляет r40 не сразу */
    u32 r15 = (arc_core_rd(40) >> 8) & 0x3f;
    u32 r13 = (arc_core_rd(40) >> 16) & 0x3f;
    uc_mac_cmd(r13);
    uc_mac_cmd(r15);
    if (r15 != r13)
        uc_assert((u32)__builtin_return_address(0), 0x7d);

    u8 v = c->rf_mask;
    rf_modules.cur = v;
    u32 r13b = v;
    u32 r15b = 0;
    while (r13b != 0) {
        r13b &= r13b - 1;
        r15b++;
    }
    rf_modules.count = (u16)r15b;
    rf_modules.x4 = c->rf_sets_mask;
    u8 r3 = c->rf_sets_mask;
    if (r3 != 0)
        rf_modules.cur_mask = c->omni_rf_mask;
    rfca_select_rf_uc(v, 0);

    if (rx_on_state != 0) {   /* [gp,0x94] = 0x8005bc */
        /* L_93aa90 */
    } else {
        u32 t = uc_read_tsf_lo();
        t -= rx_on_tsf;
        t += mac_mon_report.rx_off_duration;
        mac_mon_report.rx_off_duration = t;
    }

    u32 r0m = c->rx_mode;
    if (r0m == 0) {
        rx_mode_configure(3, 0xff);
        u32 r0b = mac_chain_mask & 0xfffff0ff;
        uc_mac_cmd(r0b | (1u << 27));
        mac_rf_switch_cmd1f(1);
        rx_on_state = 1;
    } else if (r0m == 1) {
        rx_mode_configure(3, 0xff);
        mac_rf_switch_cmd1f(1);
        u32 r0c = rx_mode_flags;
        u32 r1c;
        if (r0c & 1u)
            r1c = rf_chain_word;
        else
            r1c = tx_ctx_pool.cur->rf_word;
        mac_set_rf_chain_state(1, r1c);
        /* СРОК: прерывания запрещены на время двух MAC-команд и mac_rf_switch_cmd1f — ожидания
         * idle_detect == 5 без ограничения (как vendor 0x93ab0c…0x93ab50). Реакция L1/L2
         * (TBTT, GP-таймеры) задерживается на всё ожидание (аппаратный срок реакции не установлен);
         * запас не оценён. Срыв: опоздание BTI/окон BI на время ожидания. */
        u32 saved = arc_lr(ARC_STATUS32);
        arc_flag(saved & ~2u);
        u32 r0d = (rx_nav.ev_mask & mac_chain_mask) | (1u << 27);
        uc_mac_cmd(r0d);
        uc_mac_cmd(0x2040000);
        mac_rf_switch_cmd1f(1);
        arc_flag((saved & 2u) | arc_lr(ARC_STATUS32));
        u32 r0e = abif_dvs_rf_ctrl_shadow;
        u32 r1e = rf_set_rx;
        r0e &= ~(1u << 24);
        r0e &= ~(1u << 25);
        r0e |= r1e << 24;
        abif_dvs_rf_ctrl_shadow = r0e;
        MMIO32(HW_ABIF_DVS_RF_CTRL) = r0e;
        grant_detect_step(0, 0, 0);
        rx_on_state = 2;
    } else {
        uc_assert((u32)__builtin_return_address(0), 0x7e);
    }

    txrx_api_cmd_step(c);
    if (uc_role_ap == 0 && maint_sta_mask == 0)
        uc_mac_cmd(0x20c0011);
    else
        uc_mac_cmd(0x20c0001);
    MMIO32(HW_MAC_TSF_EVENT_CTRL) = 0xc0010;
    uc_mac_cmd(0x1ffffff);
    rx_listen_set_flag_and_stamp_tsf();
    uc_send_evt_typed(1, 0);
    uc_set_evt_id_5c(0);
    mac_set_mode_0000();
}

void ucode_cmd_0x05_handler(const struct lmac_cmd_sta_cfg *c)
{
    u8 r15 = c->cid;
    u32 r0 = c->op;
    struct sta_entry *st = &sta_tab[r15];

    if (r0 == 1) {
        /* disable: выключение станции */
        st->flags &= ~1u;
        mac_mon_report.bcons_atim_fail_vec &= ~(1u << r15);
        sta_miss_cnt[r15] = 0;
        u32 saved = arc_lr(10);
        arc_flag(saved & ~(1u << 1));
        bf_reset_sta(r15, 1);
        sta_ctx_reset_counters(&pm_ctx, r15);
        arc_flag((saved & (1u << 1)) | arc_lr(10));
        fsched_peer_deactivate(&fsched_peers, r15);
        return;
    }
    if (r0 == 0) {
        /* enable: инициализация станции */
        mac_mon_report.bcons_atim_fail_vec &= ~(1u << r15);
        sta_miss_cnt[r15] = 0;
        fsched_peer_add(&fsched_peers, r15);
        memset0_words_uc(st, sizeof(*st));
        st->flags |= 3;
        st->cfg_10 = c->cfg_10;
        st->cfg_28 = c->cfg_28;
        st->mac[0] = c->peer_mac[0];
        st->mac[1] = c->peer_mac[1];
        st->mac[2] = c->peer_mac[2];
        st->fixed_link = c->fixed_link;
        st->fixed_mcs = c->fixed_mcs;
        st->fixed_sector = c->fixed_sector;
        st->peer_n_ant = 1;
        st->peer_n_sectors = 0x40;
        rss_wait_clk[r15] = 0x29528;   /* add2 = ×4 */
        st->state = 5;
    }

    /* общий хвост (r0==0 попадает сюда, r0==2 прыгает сюда) */
    r0 = c->op;
    u32 skip = (r0 == 2 && c->omni_sector != 0xffff);
    if (!skip) {
        bf_set32((u32)&st->tx_sel, 8, 15, c->tx_sector & 0x7fff);
        bf_set32((u32)&st->tx_sel, 0, 4, c->tx_rf & 0xf);
        bf_set32((u32)&st->tx_sel, 4, 4, 3);

        u32 r1 = c->rx_sector;
        if (r1 == 0xff)
            r1 = r15 + 0x60;   /* add3 = r15 + 0xc*8 */
        r1 &= 0x7fff;
        bf_set32((u32)&st->rx_sel, 8, 15, r1);
        bf_set32((u32)&st->rx_sel, 0, 4, c->rx_rf & 0xf);
        bf_set32((u32)&st->rx_sel, 4, 4, 2);
    }
    bf_set32((u32)&st->omni_rx_sel, 8, 15, c->omni_sector & 0x7fff);
    bf_set32((u32)&st->omni_rx_sel, 0, 4, c->omni_rf & 0xf);
    bf_set32((u32)&st->omni_rx_sel, 4, 4, 2);
}

void ucode_cmd_0x08_handler(const struct lmac_cmd_vring_cfg *c)
{
    /* cid (+1) читается через целый адрес: с c->cid gcc иначе раскладывает блоки функции
     * (и сливает qid|cid<<8 в ldw в ветке 4) — код пути с ожиданиями MAC меняется (codecmp). */
    u32 cidp = (u32)c + 1;
    struct tx_ctx_s *r15 = tx_ctx_alloc_next(1);
    r15->qid = c->qid;
    u32 r0 = c->op;
    u32 r13 = 0;

    /* СРОК: та же последовательность MTP/BAP с ожиданиями без ограничения и паузой выборки r47,
     * что в ucode_cmd_rf_program (см. там), с qid из команды. */
    if (r0 == 4) {
        u8 r13b = c->qid;
        u8 r16 = *(u8 *)cidp;
        if (macq_probe_empty(r13b) == 0)
            uc_assert((u32)__builtin_return_address(0), 7);
        if (*(volatile u32 *)HW_TX_ENGINE_STATE & 0xf)
            uc_assert((u32)__builtin_return_address(0), 3);
        uc_mac_cmd(0x1c000006);
        uc_mac_cmd((r13b << 4) | 0x46004008);
        (uc_stats.macq_ppdu)++;
        while (!(arc_core_rd(53) & (1u << 2)))
            ;
        u32 r0b = mac_sel_shadow & 0xfff0ffff;
        mac_sel_shadow = r0b | (1u << 16);
        uc_mac_cmd(r0b | 0x1d010000);
        arc_nops(3);
        while (arc_core_rd(47) & 1u)                /* bbit1 r47,0: ждать сброса */
            ;
        u32 r13c = r13b | (r16 << 8) | (1u << 26) | (1u << 30) | (1u << 19) | (1u << 21);
        uc_mac_cmd(r13c);
        uc_mac_cmd(0x45000001);
        uc_mac_cmd(0x460001f1);
        mac_program_tx_with_qid(r15->qid);
        while (!(arc_core_rd(43) & (1u << 31)))
            ;
        u32 r51 = arc_core_rd(51);
        mtp_desc_lo = r51 & 0xf;
        mtp_desc_hi = r51 >> 4;
        while (!(arc_core_rd(45) & (1u << 31)))
            ;
        if (arc_core_rd(43) & (1u << 27))
            ucode_cmd08_noop_hook();
        return;                                     /* vendor: b L_93b1f4, хвост не выполняется */
    } else if (r0 == 3) {
        mac_q_tx_ppdu_cmd08(c->qid, *(u8 *)cidp);
        mac_program_tx_with_qid(r15->qid);
        while (!(arc_core_rd(43) & (1u << 31)))
            ;
        u32 r51 = arc_core_rd(51);
        mtp_desc_lo = r51 & 0xf;
        mtp_desc_hi = r51 >> 4;
        while (!(arc_core_rd(45) & (1u << 31)))
            ;
        if (c->qset == 3 && (arc_core_rd(43) & (1u << 27))) {
            u32 m = qid_agg_mask;
            qid_agg_mask = m | (1u << c->qid);
        }
        return;                                     /* vendor: b L_93b1f4, хвост не выполняется */
    } else if (r0 == 1) {
        if (dti_qset_mode == 2) {                /* L_93b020: brne r0,2 → пропуск */
            mac_set_chain_mask_924f00();
            dti_qset_mode = 0;
        }
        if (c->flags & (1u << 1)) {
            mac_q_tx_ppdu_cmd08(c->qid, *(u8 *)cidp);
            mac_program_tx_with_qid(r15->qid);
            while (!(arc_core_rd(43) & (1u << 31)))
                ;
            u32 r51 = arc_core_rd(51);
            mtp_desc_lo = r51 & 0xf;
            mtp_desc_hi = r51 >> 4;
            while (!(arc_core_rd(45) & (1u << 31)))
                ;
        }
        if (c->qset == 3) {
            u8 r0b = *(u8 *)cidp;
            u32 m = qid_agg_mask;
            qid_agg_mask = m & ~sta_tab[r0b].qid_mask_all;
        }
        u32 r13d = uc_evt_queue_peek_field04();
        struct lmac_evt_queue_deleted *ev = (void *)r13d;
        ev->q_word = c->qid;
        ev->tsf = uc_read_tsf_lo();
        ev->rsv08 = 0;
        uc_evt_enqueue(r13d, 8, 0xc, 0);
        r13 = 1;
    }

    /* общий хвост L_93b09c */
    u8 q0 = c->qid;
    qid_cfg[q0].ctrl_b6 = (c->qflags >> 6) & 1;
    qid_cfg[q0].null_b5 = (c->qflags >> 5) & 1;
    qid_cfg[q0].cid = *(u8 *)cidp;

    u32 r0m = c->qset;
    struct sta_entry *st = &sta_tab[*(u8 *)cidp];
    u32 *r18, *r17, r16v;
    if (r0m == 0 || r0m == 1) {
        r18 = &qset_shadow.qset4_mask;
        r17 = &st->qid_mask_q4;
        r16v = 4;
    } else if (r0m == 3) {
        u8 r0t = *(u8 *)cidp;
        if (r0t == 8) {
            if (r13 != 0)                           /* L_93b118: brne_s r13,0 → 0xff */
                fsched_peer_id = 0xff;
            else
                fsched_peer_id = c->qid;
        }
        r18 = &qset_shadow.qset6_mask;
        r17 = &st->qid_mask_q6;
        r16v = 6;
        if (r0t < 8) {
            u32 r0c = c->op;
            if (r0c == 0)
                fsched_peer_set_qid(&fsched_peers, r0t, c->qid);
            else if (r0c == 1)
                fsched_peer_clear_qid(&fsched_peers, r0t);
        }
    } else {
        uc_assert((u32)__builtin_return_address(0), 0x83);
        return;
    }

    u32 r3 = 1u << c->qid;
    if (r13 != 0)
        txop_qid_mask &= ~r3;
    u32 r3b = *r18;
    if (r13 != 0)
        r3b &= ~r3;
    else
        r3b |= r3;
    *r18 = r3b;
    MMIO32(HW_QSET0_MASK_VECTOR + r16v * 4) = r3b;

    u32 r0u = *r17;
    u32 r1u = 1u << c->qid;
    if (r13 != 0)
        r0u &= ~r1u;
    else
        r0u |= r1u;
    *r17 = r0u;

    st->qid_mask_all = st->qid_mask_q4 | st->qid_mask_q5 | st->qid_mask_q6;
    st->qid_top_q5 = bit_scan_msb(st->qid_mask_q5);

    if (c->op == 0 && c->qset == 3)
        txop_dma_bit1_pending = 1;
}

/* СРОК: порядок и паузы MTP/BAP (аппаратный): 0x1c000006 → 0x46… → ждать r53.2 (bap_rel_done_ind)
 * → селектор r47[1] → 3 nop → ждать r47.0 = 0 (counter_interface_busy) → 0x44/0x45/0x46 → запрос MTP
 * (0x1b/0x16/0x17 + 3 nop) → r43.31 → r51 → r45.31. Все ожидания без ограничения; выборка r47 —
 * 5 инструкций после mov r32 (vendor 0x937e38… так же); запас — единицы инструкций. Срыв: чтение
 * r47 прежней группы, ответ MTP прошлого запроса; при молчании MAC — зависание uc. */
/* Общая RF-последовательность программирования (sub-cmd 1/2 в 0x0b). */
static void ucode_cmd_rf_program(void)
{
    u32 r0 = *(volatile u32 *)HW_TX_ENGINE_STATE;
    if (r0 & 0xf)
        uc_assert((u32)__builtin_return_address(0), 3);
    uc_mac_cmd(0x1c000006);
    uc_mac_cmd(0x460001e8);
    (uc_stats.macq_ppdu)++;
    while (!(arc_core_rd(53) & (1u << 2)))
        ;
    u32 r0b = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = r0b | (1u << 16);
    uc_mac_cmd(r0b | 0x1d010000);
    arc_nops(3);
    while (arc_core_rd(47) & 1u)                    /* bbit1 r47,0: ждать сброса бита 0 */
        ;
    uc_mac_cmd(0x4428001e);
    uc_mac_cmd(0x45000001);
    uc_mac_cmd(0x460001f1);
    mac_program_tx_with_qid(0x1e);
    while (!(arc_core_rd(43) & (1u << 31)))
        ;
    u32 r51 = arc_core_rd(51);
    mtp_desc_lo = r51 & 0xf;
    mtp_desc_hi = r51 >> 4;
    while (!(arc_core_rd(45) & (1u << 31)))
        ;
}

void ucode_cmd_0x0b_handler(u32 a)
{
    rf_store_last_module_index();
    memcpy_uc((void *)&bi_cfg, (void *)(a + 0xa * 8), 0x20);
    ucode_cmd_0b_apply(&bti_sw.bcn_ss, &((const struct lmac_cmd_bcn_sweep *)a)->ss);
    u32 r0 = *(u32 *)a;
    if (r0 == 0) {
        bi_cfg_pack_words_78_7c(1, 0);
    } else if (r0 == 1) {
        if (discovery_type == 1)
            disable_tsf_event();
        if (macq_probe_empty(0x1e) == 0)
            uc_assert((u32)__builtin_return_address(0), 7);
        ucode_cmd_rf_program();
    } else if (r0 == 2) {
        bi_cfg_pack_words_78_7c(0, 0);
        if (macq_probe_empty(0x1e) == 0)
            uc_assert((u32)__builtin_return_address(0), 7);
        ucode_cmd_rf_program();
    }
    if (r0 == 0 || r0 == 2) {
        u32 r3 = bi_cfg.fss;                          /* fw ставит поле ≥ aSSFramesPerSlot (stubs.c) */
        u32 v1 = abft_slot_clk(r3);                    /* aSSSlotTime (abft.h, 10.42.5.2) */
        bti_sw.ssw_slot_a = abft_ssdur_clk(r3);        /* aSSDuration */
        bti_sw.ssw_slot_b = v1;
        u8 r0c = bi_cfg.abft_len + 1;
        bti_sw.abft_dur = r0c * v1;
    }
}



void ucode_cmd_0x0f_handler(const struct lmac_cmd_maint_sta *c)
{
    /* 0x93477c: установить/снять бит STA в 0x802194 и сопроводить BF/AoA. */
    u32 sta = c->cid;                       /* ld_s r14,[r0] */
    u8  r1  = maint_sta_mask;
    maint_sta_mask_prev = r1;
    u16 v = c->on;                          /* ldw_s r0,[r0,0x4] */

    if (v != 0) {
        if (maint_sta_mask == 0) {
            nav_accum64_lo = 0;
            nav_accum64_hi = 0;
        }
        r1 |= (u8)(1u << sta);              /* bset r1,r1,r14 */
        maint_sta_mask = r1;
        bti_clear_cid_sweep_counters();     /* L_92b184 */
        /* L_92b210: vendor при [0x800498] ≠ 0 на STA ставил своё расписание PS «1 из 1» (вход в
         * UPM) — энергосбережение вырезано (см. fw/action.c psc_req_reject). */
    } else {
        u32 mask  = 1u << sta;              /* bset r13,r13,r14 */
        u32 nmask = ~mask;                  /* not r17,r13 */
        maint_sta_mask = r1 & (u8)nmask;
        if (bf_req.pending_mask & mask) {
            bf_abort_to_state11(sta);       /* L_9258c8 */
            u32 idx = bf_req.head & 0x7;
            if (sta == bf_req.fifo[idx])
                bf_pending_set_bit(1);      /* L_9216f8 */
            else
                bf_abort_nonhead_cnt += 1;       /* ldb [gp,-0xf1]; add 1 */
        }
        /* L_93d980: vendor здесь гасил UPM-удержание STA — энергосбережение вырезано */
        internal_tx_clear_pending(sta);     /* L_9394d0 */
        bf_sta_mask = (u16)(bf_sta_mask | mask);   /* stw.as [gp,0x48] = 0x8005b8 */
        bf_brp_req_mask = (u16)(bf_brp_req_mask & nmask);  /* stw.as [gp,0x47] = 0x8005b6 */
    }
}

/* ---- Колбэки, на которые vendor ссылается по указателю (скрытые входы блоков) ---- */

void bf_req_report_20_cb(struct rx_meas_ctx *m)  /* 6.2 asm 0x924898 (скрытый вход) */
{
    if (bf_req_try_claim(m, 1) == 0)
        uc_assert((u32)__builtin_return_address(0), 0x9a);
    u32 n = m->n;
    if (n != 0 && n < 0x15) {
        memcpy_uc((void *)FWSH(fwsh_energy, adc), m->sample, n * 4);
        memcpy_uc((void *)FWSH(fwsh_energy, gain), m->sample_88306c, n * 4);
        FWSH(fwsh_energy, n) = m->n;
    }
    FWSH(fwsh_energy, tsf_start[1]) = m->tsf[1];
    FWSH(fwsh_energy, tsf_start[0]) = m->tsf[0];
    FWSH(fwsh_energy, tsf_last[1]) = m->snap_sel6;
    FWSH(fwsh_energy, tsf_last[0]) = m->snap_sel5;
    uc_evt_send_20(m->state_b);
}

void bf_req_report_21_cb(struct rx_meas_ctx *m)  /* 6.2 asm 0x92490c (скрытый вход) */
{
    u32 buf[8];
    if (bf_req_try_claim(m, 2) == 0)
        uc_assert((u32)__builtin_return_address(0), 0x9b);
    memset0_words_uc(buf, 0x20);
    ppdu_unpack_desc_word(m->plcp, &buf[2], &buf[3], &buf[4], &buf[5], &buf[6], &buf[7]);
    buf[0] = m->snap_sel5;
    buf[1] = m->snap_sel6;
    uc_evt_send_21(m->state_b, buf);
}

void bf_req_report_26_cb(struct rx_meas_ctx *m)  /* 6.2 asm 0x92e468 (скрытый вход) */
{
    bf_req_try_claim(m, 4);
    uc_evt_send_26(1);
}

void direct_tx_short_frame0_cb(void)             /* 6.2 asm 0x93b3fc (скрытый вход) */
{
    direct_tx_send_short_frame(0);
}

void direct_tx_short_frame2_cb(void)             /* 6.2 asm 0x93b404 (скрытый вход) */
{
    direct_tx_send_short_frame(2);
}

void rf_gain_adjust_cb(u32 a, u32 b)             /* 6.2 asm 0x935748 (скрытый вход, [0x8005a8]) */
{
    u8 prev = 0;
    rfca_select_rf_uc(rf_modules.cur, (u32)&prev);
    u32 i = (u8)(30 - arc_norm(rf_modules.mask));
    s32 g = (s32)b + agc_cfg.gain_lo_ofs[i];
    if (g < 1) g = 1;
    if (g > 0xf) g = 0xf;
    rf_rx_gain_lo[i] = (u8)g;
    if (a != 0x7fffff) {
        s32 h = (s32)agc_cfg.gain_hi_ofs[i] + (s32)a;
        if (h < 1) h = 1;
        if (h > 0xf) h = 0xf;
        rf_rx_gain_hi[i] = (u8)h;
    }
    brp_write_reg_pair(1284, (u8)g | (rf_rx_gain_hi[i] << 4));
    rfca_select_rf_uc(prev, 0);
}
