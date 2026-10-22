// SPDX-License-Identifier: AGPL-3.0-or-later
/* BTI (beacon transmission interval) / ABFT / AW (окно опроса ATI; имя vendor — awake window) uCode. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "abft.h"
/* Условия Discovery Mode (abft.h) — отдельными функциями, чтобы не менять код rx_flow_handle_frame на пути ответа. */
__attribute__((noinline)) u32 abft_discovery_ok_call(void) { return abft_discovery_ok(); }
__attribute__((noinline)) u32 abft_discovery_addressed_call(void) { return abft_bcn_addressed_to_us(); }
#ifndef UC_PATHT
#define UC_PATHT(i) do { } while (0)                 /* точки Timer1 опыта gp0path — только в exp/abft-stamps */
#endif
#include "ifs.h"
static u32 abft_sta_arm_gp0(void);
static u32 bti_bi2_event_step_chk(struct bi_ctx_s *c, u32 chk);





/* ---- Внешние подфункции, вызываемые портированными ниже функциями ---- */

/* Вращение вправо (ARC ror). */
static inline u32 ror32(u32 x, u32 n) { return (x >> n) | (x << (32 - n)); }

/* ---- Локальные stub-ы глубоких подфункций ---- */
/* set_tsf_event — в tail.c (0x935680). */
u32 uc_wait_event1_or_event4(u32 a, u32 b, u32 c)
{
    /* Ожидание события 1 (aux42) или 4 (aux54), 6.2 asm 0x9367e4. */
    if (arc_core_rd(42) & a)
        return 1;
    if (arc_core_rd(54) & b)
        return 1;
    u32 r4 = a;
    if (c != 0) {
        uc_mac_cmd(c | 0x23010000);
        uc_mac_cmd(0x2000200);
        r4 = a | (1u << 9);
    }
    /* vendor L_936838: 2×nop + mov 0,0 (цель beq.d — выполняется на обоих путях) */
    arc_nops_nop(2);
    while (!(arc_core_rd(42) & r4) && !(arc_core_rd(54) & b))
        ;
    return ((arc_core_rd(42) & a) || (arc_core_rd(54) & b)) ? 1 : 0;
}

/* ===== Мелкие хелперы ===== */

u32 aw_worker_read_dma_881c84(void)
{
    return MMIO32(HW_DMA_RINGS_WITH_DATA);
}

u32 bti_bi2_gp2_end_flag(void)
{
    return arc_core_rd(54) & 0x100u;
}

u32 bti_r54_event_bit6(void)
{
    return arc_core_rd(54) & 0x40u;
}

void bti_clear_cid_sweep_counters(void)
{
    bti_cnt.cid[0] = 0; bti_cnt.cid[1] = 0; bti_cnt.cid[2] = 0; bti_cnt.cid[3] = 0;
}

void bti_clear_sweep_counters(u32 a)
{
    (void)a;
    memset0_words_uc((void *)&bti_cnt, 0x24);
}

void bti_request_bf_metric(void)
{
    uc_mac_cmd(0x5200000e);
}

void aw_open_event_mask(void)
{
    mac_ddc_mask_all_on();
    pm_event_mask_save_all_on();
}

u32 abft_arm_response_window(void)
{
    uc_mac_cmd(0x4d00000a);
    arc_nops(3);
    u32 r0 = abft_slot_clk(ABFT_SS_FRAMES_PER_SLOT);   /* наименьший слот: целого слота не осталось */
    u32 r2 = arc_core_rd(55);
    return (r2 < r0) ? 1 : 0;      /* 0x930610: cmp r2,r0; rlc r0,0 = C = (r2 < r0) */
}

void aw_compute_tbtt_from_hw(u32 a, u32 *out)
{
    mac_read_bi_start_tsf64_uc(a, out, 0);
    u64 add = (u32)(u16)MMIO32(HW_MAC_BEACON_INTERVAL) << 10; /* extw (беззнаковое) + asl 10 */
    u64 v = ((u64)out[1] << 32) | out[0];
    v += add;
    out[0] = (u32)v;
    out[1] = (u32)(v >> 32);
}

/* GP1 станции — событие границы слота (пуск 0x5300070e — по концу GP0). Первый SSW MAC начинает через
 * IFS из 0x886d00 (у станции SIFS) + ~0,55 мкс после этого события, если команды uc успели (H-ORIGIN, см.
 * abft.h); a — на сколько тактов конец GP0 позже конца BTI. vendor 0x3de = 6 мкс = MBIFS − SIFS: SSW в
 * конец BTI + 9,45 мкс; стандарт — MBIFS − SIFS − задержка MAC: SSW ровно в конец BTI + MBIFS. */
void bti_tx_program_bi2_regs(u32 a)
{
    u32 v = ABFT_STA_STD_GP1_CLK;
    uc_mac_cmd(((a < v) ? v - a : 1u) | 0x50000000u);
    uc_mac_cmd(0x5300070e);
    uc_mac_cmd(0x49000080);
}

void aw_fold_peer_masks(u32 a, u32 b, u32 c)
{
    while (b != 0) {
        u32 bit = (30 - arc_norm(b));
        u32 r6 = 1u << bit;
        if (VOL(link_stat[bit].bf_reasons) != 0) {
            *(u8 *)a |= r6;
            *(u8 *)c |= r6;
            aw_peer_stats[10] += 1;
        }
        b = (b & ~r6) & 0xff;                    /* bic + extb.f: дальше только младший байт */
    }
}

/* СРОК: на пути между соседними SSW ответчика (SBIFS) — см. abft_ssw_burst. */
void abft_send_ssw_feedback(u32 a)
{
    (void)a;
    direct_tx_program_cmd34(0x10, 0x16);
    tx_fifo_write_bytes((u32)&ssw_tpl_fc, 0xa);
    tx_fifo_free -= 9;                  /* ld_s [gp,-20] / st.as [gp,-5] */
    uc_mac_cmd(0x330004c3);
    uc_wait_direct_tx_ready();
    arc_core_wr(34, ssw_tpl_fb_sector);
    arc_core_wr(34, ssw_tpl_fb_snr);
    arc_core_wr(34, ssw_tpl_fb_b2);
    tx_fifo_free -= 3;
    direct_tx_issue_cmd_33();
}

void aw_start_window(struct aw_win_s *w, u32 b)
{
    /* 6.2 asm 0x935ae4. b (r1) не используется collect_awake_peers. */
    (void)b;
    if (FWSH(ese_slot_tbl, mode) != 0)
        uc_mac_cmd(0x5a000000);
    internal_tx_check_idle(0);
    sxd_hal_write_qset_field(0, w->qset_val);
    aw_open_event_mask();
    w->cur_bit = 0;
    w->round = 0;
    aw_worker_collect_awake_peers(w);
    w->atim_armed = 0;
}

/* ===== Средние ===== */

void bti_count_sweep_round(struct bi_ctx_s *c)
{
    bti_cnt.rounds++;
    bti_cnt.cid[2] = bti_cnt.cid[2] + 1;
    c->round += 1;
    uc_mac_cmd(0x2000020);
    u8 r8 = fwsh_n_sets;
    if (r8 >= 2 && c->round == r8) {
        c->round = 0;
        c->status = 5;
    } else {
        c->status = 2;
    }
}

void bti_reset_sweep_state(struct bi_ctx_s *c)
{
    u8 v = 0;
    for (u32 i = 0; i < 0x40; i++) {
        ss_rfset.order[i] = v;
        v++;
    }
    memset0_words_uc(&bcn_rx, 0x1c);                /* до x1c */
    uc_mac_cmd(0x54u << 24);
    uc_mac_cmd(0x54u << 24);
    uc_mac_cmd(0x49000100);
    uc_mac_cmd(0x51000284);
    uc_mac_cmd(0x54000508);
    memset0_words_uc((void *)&bti_sw, 0x58);
    c->round = 0;
}

void bti_dispatch_sweep_step(struct bi_ctx_s *c, u32 b)
{
    /* 6.2 asm 0x92b7dc: диспетчер по статусу BTI. */
    u32 r14 = bti_prepare_sweep_set(c, b);   /* возврат ctx->status (c->status) */
    uc_read_tsf_lo();                         /* результат отбрасывается */
    if (r14 >= 7) {
        uc_assert((u32)__builtin_return_address(0), 0x76);
        return;
    }
    /* jump-таблица 0x801bc4: [0]=0x92b806, [1]=0x92b824, [2]=0x92b806,
     * [3]=0x92b838, [4]=0x92b806, [5]=0x92b81c, [6]=0x92b850 */
    switch (r14) {
    case 1: bi_run_bti_cycle(c); break;
    case 3: uc_assert((u32)__builtin_return_address(0), 0x76); break;
    case 5: l1_task_dispatch(6, 0); break;
    case 6: break; /* return */
    default: l1_task_dispatch(1, 0); break; /* 0, 2, 4 */
    }
}

void bti_measure_frame_duration(u32 a)
{
    u32 r14 = a;
    uc_mac_cmd(0x1500ffff);
    uc_mac_cmd(0x14000007);
    mac_program_tx_beacon();
    u32 r43, r51, r45, r47;
    do { r43 = arc_core_rd(43); } while (!(r43 & 0x80000000u));
    r51 = arc_core_rd(51);
    mtp_desc_lo = r51 & 0xf;                     /* bmsk 0x3 */
    mtp_desc_hi = r51 >> 4;
    u32 r13 = MMIO32(HW_MAC_IFS_RIFS_SBIFS) >> 24;
    do { r45 = arc_core_rd(45); } while (!(r45 & 0x80000000u));
    u32 cfg = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = cfg | (1u << 19);
    uc_mac_cmd(cfg | 0x1d080000);
    arc_nops(3);
    do { r47 = arc_core_rd(47); } while (!(r47 & 0x80000000u));
    u32 r47b = arc_core_rd(47);                  /* mov_s r1,r47 — перечитать */
    u32 d = (u32)(u16)r47b;
    u32 mul = bti_sw.bcn_ss.n_frames;
    d = (d + r13) * mul - r13;
    struct ss_timing *t = (struct ss_timing *)r14;
    t->total = (u16)d;
    t->frame = (u16)r47b;                       /* stw_s r1,[r14,2] */
    t->gap = (u16)r13;
}

u32 abft_resp_parse_fdbk(struct sls_peer_rec *dst)
{
    /* 6.2 asm 0x93061c. Парсинг ABFT-фидбека. */
    uc_wait_event_busy(1u << 16, 0);
    if (rx_buf_toggle_dis == 0) {
        uc_mac_cmd((rx_buf_toggle_cnt & 1) | 0x32000000);
        rx_buf_toggle_cnt += 1;
    }
    ppdu_evt_cnt += 1;                  /* ld_s [gp,80] / st.as [gp,20] — один адрес */
    uc_stats.rx_arm += 1;
    uc_mac_cmd(0x2011000);
    if (!(arc_core_rd(37) & (1u << 25)))
        return 0;
    const u8 *a = (const u8 *)bcn_rx.bssid, *b = rx_buf;
    if (a[0] != b[0xa] || a[1] != b[0xb] || a[2] != b[0xc] ||
        a[3] != b[0xd] || a[4] != b[0xe] || a[5] != b[0xf])
        return 0;
    u32 r2 = *(u32 *)&rx_buf_ssw & 0x3f;           /* SSW-Feedback словом */
    if (fwsh_n_sets >= 2) {
        u32 idx = (rf_chain_word >> 8) & 0x7fff;
        r2 = (u8)(r2 + *(u8 *)(fwsh_set_ranges + idx * 2));   /* 0x8577b0 — указатель */
    }
    dst->abft_sector = (u8)r2;
    dst->abft_antenna = (*(u32 *)&rx_buf_ssw >> 6) & 3;
    dst->snr = *(u8 *)&rx_buf_fb_snr;
    if (arc_core_rd(38) & (1u << 11))
        dst->abft_sta = (arc_core_rd(38) >> 8) & 7;
    else
        dst->abft_sta = 8;
    return 1;
}

/* ===== Крупные ===== */

u32 bti_worker_bi2_step(u32 a, u32 b)
{
    uc_wait_event_busy(1u << 16, 0);
    if (rx_buf_toggle_dis == 0) {
        uc_mac_cmd((rx_buf_toggle_cnt & 1u) | 0x32000000);   /* bset 25/28/29 — u32, не u8 */
        rx_buf_toggle_cnt += 1;
    }
    ppdu_evt_cnt += 1;                      /* [gp,0x50] → st.as [gp,0x14] */
    (uc_stats.rx_arm)++;
    uc_mac_cmd(0x2011000);
    u8 match = 0;
    if (a != 0 || b == 0) {
        if (((u8 *)bcn_rx.bssid)[0] == ((u8 *)rx_buf_ra)[0] &&
            ((u8 *)bcn_rx.bssid)[1] == ((u8 *)rx_buf_ra)[1] &&
            ((u8 *)bcn_rx.bssid)[2] == ((u8 *)rx_buf_ra)[2] &&
            ((u8 *)bcn_rx.bssid)[3] == ((u8 *)rx_buf_ra)[3] &&
            ((u8 *)bcn_rx.bssid)[4] == ((u8 *)rx_buf_ra)[4] &&
            ((u8 *)bcn_rx.bssid)[5] == ((u8 *)rx_buf_ra)[5])
            match = 1;
    } else {
        u32 r38; r38 = arc_core_rd(38);
        match = r38 & 1;
    }
    if (match) {
        struct mac_mon_slot_s *e = &mac_mon_slot[mac_mon_slot_idx];
        e->rx_bcon += 1;
        e->detected = 1;
    }
    return match;   /* extb_s r0,r0 */
}

void bti_transmitter_bi2_flow(struct bi_ctx_s *c)
{
    if (c->kind == 1) {
        /* Вход в BTI с пути приёма (l1_task_phase_of → rx_flow → автомат BI, аргумент 1): маяк уже
         * разобран rx_flow, GP2 (0x284 от конца его приёма) давно кончился — vendor взводил GP0 по
         * этому маяку и отказывался по r54.8 на каждом маяке BTI (стенд: bcn_rx.x1c = 64 = число маяков,
         * GP_CLK2 = 0 при отказе; так же и в vendor-коде — путь тот же). Стандартно: конец BTI — по
         * Duration маяка, принятого так, что GP0 взведён в окне GP2. Поэтому GP2 перевзводится на конец
         * следующего принятого кадра и следующий маяк BTI ловится в bti_bi2_event_step, как при входе по
         * TBTT (kind 0). Последовательность GP2 — как в bti_reset_sweep_state. Только если за этим маяком
         * развёртка продолжается (CDOWN > 0): иначе ждать в bti_bi2_event_step было бы нечего до конца BI
         * (r42.5), и uc не обслуживал бы приём — тогда как vendor.
         * Без проверок окна BI и синхронизации BI (uc_bi_counter_in_window, uc_read_bi_sync): они нужны
         * входу по TBTT (kind 0 — убедиться, что сейчас начало BI по счётчику MAC), а здесь BTI доказан
         * принятым маяком. До синхронизации счётчика BI с AP (сканирование, ассоциация — как раз когда
         * станция отвечает в A-BFT) проверка окна почти всегда ложна: стенд std4 — 63 входа подряд кончались
         * в err без ожидания маяка (bi_win.dti_to_bti +63, bi2_cnt 0, abft_try 64), и только на CDOWN 0 —
         * взвод по уже разобранному маяку и отказ (x1c). */
        if (((rx_buf_bcn_ssw >> 1) & 0x1ff) != 0) {
            uc_mac_cmd(0x54000000);
            uc_mac_cmd(0x54000000);
            uc_mac_cmd(0x49000100);
            uc_mac_cmd(ABFT_STA_GP2_RXEND_CLK | 0x51000000);
            uc_mac_cmd(0x54000508);
            if (bti_bi2_event_step_chk(c, 0) == 0)
                return;
        }
    } else if (bti_bi2_event_step(c) == 0) {
        return;
    }
    /* СРОК: GP0 стартует по концу GP2 (0x284 = 3,903 мкс от конца приёма маяка, H-GP5, uc/abft.h), поэтому
     * путь uc в конец BTI не входит, но взвести GP0 нужно, пока GP2 идёт: от r42.12 маяка через
     * bti_bi2_event_step + bti_worker_bi2_step (ожидание ppdu_report r42.16, сверка BSSID) до 0x5200090c
     * — меньше 3,9 мкс. При входе с пути приёма (kind 1) маяк уже разобран rx_flow и окно пропущено
     * (стенд 2026-10-21: отказ на каждом маяке BTI, у vendor-кода путь тот же). */
    /* GP0 взведён в bti_bi2_event_step сразу после сверки BSSID (abft_sta_arm_gp0); без него (kind 1 при
     * CDOWN = 0) — здесь, с той же проверкой окна GP2. */
    u32 st = bti_cnt.x04 >> 30;
    bti_cnt.x04 &= 0x3fffffffu;                     /* остаётся «конец BTI» первого маяка (Timer1) */
    if (st == 0) {
        st = abft_sta_arm_gp0();
        bti_cnt.x04 = 0;                            /* t маяка нет — без поправки по последнему маяку */
    }
    if (st != 1) {
        bcn_rx.x1c += 1;
        c->status = 4;
        return;
    }
    if (bcn_rx.abft_here != 0) {
        u32 off = 0;                            /* конец GP0 = конец BTI (аппаратная привязка) */
        bf_gpc_program_mac_by_mode_b(off);
        if (bcn_rx.abft_go != 0)
            bti_tx_program_bi2_regs(off);
        if (bti_r54_event_bit6())
            uc_assert((u32)__builtin_return_address(0), 0x86);
    }
    bti_bi2_track_best_metric(c);
}

void bti_worker_bti_transmitter_beacon_sweep_flow(struct bi_ctx_s *c)
{
    /* 6.2 asm 0x923cb4. */
    u8 sp[8];
    txrx_state1 = 0x10;                 /* st.as [gp,0x33] */

    txrx_state2 = 0;                    /* st.as [gp,0x34] — delay-слот bne.d, всегда */
    if (bi_cfg.bi_mode == 2) {             /* cmp r9,0x2; bne → L_923d84 */
        if (c->kind == 0) {                /* brne r10,0x0 → L_923d84 */
            u32 r4 = mac_sel_shadow & 0xfff0ffff;
            mac_sel_shadow = r4 | (1u << 17);
            uc_mac_cmd(r4 | 0x1d020000);
            arc_nops(3);
            u32 r14 = (u32)(((u64)arc_core_rd(47) * 0xbd) >> 32) + 0xa;   /* mulu64+mhi */
            uc_mac_cmd(r14 | 0x30000000);
            u32 tsf = uc_read_tsf_lo();
            u64 v = uc_shl64(r14, 0, 0xa);
            u64 cur = ((u64)tsf_evt_target[1] << 32) | tsf_evt_target[0];
            u64 sum = cur + v;
            tsf_evt_target[0] = (u32)sum;
            tsf_evt_target[1] = (u32)(sum >> 32);
            set_tsf_event((u32)tsf_evt_target);
            uc_log_emit3(0x20, 0x1001d88, tsf, tsf_evt_target[0], r14);
        }
    }

    /* L_923d84 */
    if (fsched_enabled == 0) {              /* ldb [gp,-0xdf]; brne → L_923df8 */
        rx_nav_arm_flag_if_enabled();
        if (bi_remaining_time_us() != 0) {   /* breq → L_923df8 */
            FWSH(fwsh_diag, bcn_nav) += 1;
            if (bti_defer_active == 0) {     /* brne r1,0x0 → L_923de0 */
                bcn_nav_wait_tsf = uc_read_tsf_lo();
                bti_defer_active = 1;
                return;
            }
            u32 d = uc_read_tsf_lo() - bcn_nav_wait_tsf;   /* L_923de0 */
            bcn_nav_wait_us = d;
            if ((s32)d < 0x7530)             /* blt → L_9241f8 */
                return;
        }
    }

    /* L_923df8 */
    uc_mac_cmd(mac_evt_en_shadow | 0x27007e00);
    uc_mac_cmd(0x2004002);
    struct tx_ctx_s *tx_ctx = tx_ctx_alloc_next(1);
    tx_ctx->qid = 0x1e;
    if (fwsh_n_sets >= 2) {              /* brlt r6,0x2 */
        const u8 *range = (const u8 *)(fwsh_set_ranges) + (bti_sweep_set) * 2;
        bti_sw.bcn_ss.n_frames = (u8)(range[1] - range[0] + 1);
    }
    bti_measure_frame_duration((u32)sp);
    bi_ctrl_program_mac_bcon();
    /* TXOP BTI и Duration маяков (abft.h, «TXOP BTI»): длина PSDU — от fw (fwsh_diag.bcn_psdu_len), TXTIME — формула
     * Control PHY в тактах, сверка с d (r47). Буквальный режим (Duration ⌈⌉ до E, 9.2.5.1) — при любом n ≥ 1 (формула
     * проверена перебором n = 1…64, L = 14…299), одном наборе антенн и сошедшейся длине. Иначе — запасной путь:
     * TXOP — план развёртки, Duration — ⌊остатка TXOP⌋ MAC, сетка A-BFT — по правилу abft.h (ABFT_AP_FALLBACK_FRAC_CLK).
     * Считается до ожидания slot_event (путь slot_event → первый маяк — одно присваивание ниже), без делений. */
    u32 bt_std = 0, bt_frac = ABFT_AP_FALLBACK_FRAC_CLK, bt_txop = 0;
    ((struct ss_timing *)sp)->_6 = 0;                /* sp — стек: без расчёта ниже буквального режима нет */
    {
        struct ss_timing *tw = (struct ss_timing *)sp;
        u32 n = bti_sw.bcn_ss.n_frames, L = FWSH(fwsh_diag, bcn_psdu_len);
        u32 d165 = tw->frame * ABFT_CLK_PER_US;
        u32 T = (L >= 14u && L < 2048u) ? dmg_ctrl_txtime_clk_rt(L) : 0;
        if (n >= 1u && n <= 64u && fwsh_n_sets < 2 && T <= d165 && T + ABFT_CLK_PER_US > d165) {
            u32 p = T + tw->gap * ABFT_CLK_PER_US;
            /* D_last = BCN_DUR_DLAST_US: TXOP BTI (первая 0x15 = Duration первого маяка + d) = ⌈(n − 1)·P/165⌉ + d +
             * D_last; D_last в Duration входит через план и K (abft.h). */
            bt_txop = clk_to_us_floor((n - 1u) * p + ABFT_CLK_PER_US - 1u) + tw->frame + BCN_DUR_DLAST_US;
            u32 m = clk_to_us_floor((d165 - T) * 65536u + ABFT_CLK_PER_US - 1u);  /* ⌈δb·2^16/165⌉ */
            /* Сетка A-BFT (стенд bcn1): запись 0x15 на маяк перезадаёт TXOP — txop_event пришёл на 1,35 мкс раньше
             * (tx_end последнего маяка → txop_event 17,85 вместо 19,20). Модель H-TXOP: MAC начинает TXOP заново от
             * команды пуска каждого кадра (за UC_ABFT_MACLAT_CLK до начала кадра в эфире, как прямая передача в
             * A-BFT, H-ORIGIN) длиной 0x15: txop_event = начало последнего маяка − MACLAT + (D_last + d)·165 =
             * E + δb − MACLAT (не зависит от D_last и n; 144 − 91 = 53 такта = 0,32 мкс — ровно сдвиг bcn1:
             * 1,67 − 1,35). Сетка — от E: bt_frac = δb − MACLAT (может быть < 0). */
            bt_frac = (d165 - T) - UC_ABFT_MACLAT_CLK;
            bt_std = 1;
            tw->total = (u16)(((n - 1u) * m) >> 16);                            /* K */
            tw->_6 = (u16)(m + 1u);              /* ≠ 0 — буквальный режим; m + 1 ≤ 65137 (точно, abft.h) */
        } else {
            FWSH(fwsh_diag, bti_txop_fallback) += 1;    /* запасной путь: длина ≠ r47, n вне 1…64 или наборов ≥ 2 */
        }
    }
    /* СРОК: конец пути «bi1_event (до TBTT) → маяк» — см. l1_task_main_step: всё от входа до этого
     * ожидания slot_event (bti_measure_frame_duration с тремя спинами MTP, bi_ctrl_program_mac_bcon)
     * должно уложиться в упреждение bi1_event. */
    uc_wait_event_busy(0x2u | (1u << 14), 0);   /* 0x4002 */
    if (arc_core_rd(42) & (1u << 14)) {           /* bbit0 r4,0xe → L_923ea4 */
        bti_busy_cancel_cnt += 1;               /* L_923e8a */
        return;
    }

    /* L_923ea4 */
    bti_busy_cancel_cnt = 0;
    u32 r3;
    if (bti_sw.bcn_ss.x0 != 0)               /* ld_s r1,[r2,0xc]; brne → L_923ec4 */
        r3 = 0;
    else if (fwsh_n_sets < 2)             /* brlt r4,0x2 → L_923ecc (r4 zero-ext) */
        r3 = 1;
    else
        r3 = 0;
    txss_set_sweep_param((u32)sp, &bti_sw.bcn_ss, 1, r3, bti_sw.bcn_ss.n_frames, bti_sweep_set);
    ss_plan_tx_dur += ((const struct ss_timing *)sp)->gap + ((const struct ss_timing *)sp)->frame;
    if (bt_std)
        ss_plan_tx_dur = bt_txop;             /* рассчитан до ожидания slot_event (ниже по тексту — выше по ходу) */
    uc_mac_cmd(0x14000100);
    if (bcon_txss_sweep_step((u32)tx_ctx, 5, (u32)sp, 0, 0, 0) == 0)   /* beq → L_9241a8 */
        goto done;

    /* L_923f38 */
    bcn_rx.abft_here = (bcn_bi.abft_bi_left == 0) ? 1 : 0;   /* rsub.f + mov.cs */
    bti_defer_active = 0;                    /* st r14,[0x800714] (r14=0) */
    bcn_rx.bcn_sent = 1;            /* delay-слот bi_cfg_tick_counters */
    bi_cfg_tick_counters();
    uc_mac_cmd(0x2040010);
    uc_stats.bcn_sweep += 1;
    c->status = 1;
    if (bcn_rx.abft_here != 0) {              /* beq → L_9241a0 */
        uc_mac_cmd(0x3c000004);
        uc_mac_cmd(0x14000400);
        if (arc_core_rd(42) & (1u << 7))          /* btst r3,0x7; bne → L_9241c8 */
            uc_assert((u32)__builtin_return_address(0), 0x75);
        /* СРОК: GP0/GP1/GP2 (сетка A-BFT AP: конец A-BFT, границы SSW-слотов) отсчитываются от команд
         * 0x4f/0x50, а не от события: A-BFT — через MBIFS после BTI, допуск −0/+10 %×(aSlotTime −
         * aAirPropagationTime) ≈ +0,49 мкс (802.11-2020 10.3.2.3.10, 10.42.5.1). От txop_event (r42.7)
         * до 0x4f ~21 инструкция, до 0x50 ~43 (vendor 0x923fd4 — та же последовательность); запас:
         * десятки. Код между спином и командами или вытеснение L2 сдвигают сетку слотов AP позже сетки
         * станции (она строит её по Duration маяка) — SSW станций ложатся на край слота. */
        while (!(arc_core_rd(42) & (1u << 7)))    /* L_923fd4: bbit0 → spin */
            ;
        /* Сетка A-BFT от конца BTI (10.42.5.1): GP0/GP2 с триггером 0x03 стартуют не по команде, а через
         * ~SIFS после txop_event (стенд A2: граница слота = txop + 8,05 мкс при GP2 = 5 мкс), поэтому
         * путь uc сюда не входит и Timer1 не нужен. Слот 0 = конец BTI, объявленный маяками, + MBIFS, а этот
         * конец раньше txop_event на bt_frac (abft.h). GP1 (триггер 0x09 — по концу GP2, т. е. от
         * начала каждого слота; стенд: событие в aSSDuration + 1,0 мкс): Feedback MAC начинает через MBIFS
         * (0x886d00, mac_mode_kick) + ~0,55 мкс после события GP1 (H-ORIGIN: стенд 264,1 при GP1 254,56 и
         * 268,23 при 258,66), поэтому GP1 = точка Feedback (aAirPropagationTime + aSSDuration + MBIFS,
         * 10.42.5.2) − MBIFS − задержка MAC. */
        u32 slot0 = ABFT_MBIFS_CLK - ABFT_AP_TRIG03_CLK - bt_frac;         /* по модулю 2^32: bt_frac может быть < 0 */
        uc_mac_cmd(0x14000000);
        u32 r13 = slot0 + bti_sw.abft_dur - ABFT_AP_STD_END_GUARD_CLK;
        uc_mac_cmd(0x52000000);
        uc_mac_cmd(0x52000000);
        uc_mac_cmd(0x49000040);
        uc_mac_cmd(r13 | 0x4f000000);
        uc_mac_cmd(0x52000308);
        r13 = ABFT_AIRPROP_CLK + bti_sw.ssw_slot_a - UC_ABFT_MACLAT_CLK;   /* + 0x886d00 = MBIFS (mac_mode_kick) */
        uc_mac_cmd(0x53000000);
        uc_mac_cmd(0x53000000);
        uc_mac_cmd(0x49000080);
        uc_mac_cmd(r13 | 0x50000000);
        uc_mac_cmd(0x5300090c);
        uc_mac_cmd(0x54000000);
        uc_mac_cmd(0x54000000);
        uc_mac_cmd(0x49000100);
        uc_mac_cmd(slot0 | 0x51000000);
        uc_mac_cmd(0x5400030c);
        u32 r8 = mac_sel_shadow & 0xffff0fff;
        mac_sel_shadow = r8;
        uc_mac_cmd(r8 | 0x1d000000);
        arc_nops_nop(2);
        if ((arc_core_rd(40) & 7) != 5)           /* bmsk 0x2; brne → L_9241d8 */
            uc_assert((u32)__builtin_return_address(0), 0x77);
        uc_wait_two_events(5, 5, 4);         /* L_924144 */
        arc_nops(3);   /* vendor: 3×nop до чтения r42 */
        if (!(arc_core_rd(42) & (1u << 14)))      /* bbit0 r2,0xe → L_9241e8 */
            uc_assert((u32)__builtin_return_address(0), 0x84);
        uc_mac_cmd(bti_sw.ssw_slot_b | 0x51000000);   /* L_92415c */
        uc_mac_cmd(0x5400090a);
        uc_mac_cmd(0x5200000e);
    } else {
        while (!(arc_core_rd(42) & (1u << 7)))    /* L_9241a0: bbit0 → spin */
            ;
    }

done:                                        /* L_9241a8 */
    txrx_state1 = 0;
    txrx_state2 = 0;
}

void aw_worker_collect_awake_peers(struct aw_win_s *w)
{
    /* 6.2 asm 0x927a44. Локальный буфер sp[0..11]; здесь b0..b3 — байты
     * sp[0..3], w4 — слово sp[4..7] (байт sp[5] пишется отдельно). */
    u8 b0 = 0, b1 = 0, b2 = 0, b3 = 0;
    u32 w4 = 0;
    w->pend = 0;                        /* st r21,[r0] */

    peer_masks_apply_op(&pm_ctx, 0, 0);
    u8 r18 = maint_sta_mask;
    u32 r14 = aw_worker_read_dma_881c84();

    if (r14 != 0) {
        while (r14 != 0) {
            u32 bit = (30 - arc_norm(r14));   /* norm; rsub 0x1e */
            u32 out;
            u32 sector = sta_get_sweep_byte(bit, (u32)&out);
            r14 &= ~(1u << bit);                 /* bclr r14,r14,r15 (delay) */
            if (out != 0) {                      /* match */
                if (sector >= 8)                 /* brge r13,0x8 (r13 беззнаков.) */
                    uc_assert((u32)__builtin_return_address(0), 0x141f);
                u32 m = 1u << sector;
                w->pend_b[0] |= m;
                b0 |= m;
                aw_peer_stats[sector] += 1;
            } else {                             /* no match */
                w->pend_b[1] |= r18;
                if (r18 != 0)
                    w4 |= 1u << 25;              /* bset 0x19 */
                aw_peer_stats[9] += 1;
            }
        }
    }

    /* L_927b50 */
    u32 r5 = FWSH(fwq_tx_avail, mask);
    if (r5 != 0) {
        w->pend_b[0] |= r5;
        u32 r4 = FWSH(fwq_tx_avail, mask);
        w4 = ror32((ror32(w4, 16) & 0xfffffe00u) | (r4 & 0xff), 16);
        if (r4 & (1u << 8)) {                    /* bbit0 r4,0x8 */
            w->pend_b[1] |= r18;
            u32 rr = ((w4 >> 16) & 0x1ff) | (1u << 8);   /* bmsk 0x8 + bset 0x8 */
            w4 = ror32((ror32(w4, 16) & 0xfffffe00u) | rr, 16);
        }
        aw_peer_stats[8] += 1;
    }

    /* L_927bd0 */
    aw_fold_peer_masks((u32)&w->pend_b[0], r18, (u32)&b3);
    u32 r9 = itx_ka_pending;
    if (r9 != 0) {
        if (uc_role_ap != 0)
            w->pend_b[0] |= r9;
        r9 = itx_ka_pending;
        b2 = (u8)r9;
        aw_peer_stats[0xb] += 1;
    }

    /* L_927c1c */
    if (aw_collect_en != 0) {
        u8 r3 = aw_tx_peer_mask;
        w->pend_b[0] |= r3;
        b1 = r3;
        aw_tx_peer_mask = 0;
    }

    /* L_927c48 */
    /* nodoze_mask ≡ 0xff (станций в BI сна нет: PS вырезан, см. fw/action.c psc_req_reject);
     * vendor маскировал им pend_b[0..1], а при своём BI сна (psc.state == 2) гасил обход. */
    w4 = (w4 & 0xffff00ffu) | (0xffu << 8);     /* stb r13,[sp,0x5] */
    peer_masks_or_into_8571c4(0xff);

    /* L_927cbc */
    FWSH(fwsh_diag, aw_peers_w) = (u32)b0 | ((u32)b1 << 8) | ((u32)b2 << 16) | ((u32)b3 << 24);
    FWSH(fwq_tx_avail, aw_info) = w4;
}


/* ===== Ответ станции в A-BFT (прежний путь abft_responder_respond_flow/_tx_ssw удалён) =====
 * Стенд gp0path (UC_PATH_T, сборка с метками, прежний путь): вход → mac_set_mode_a000 119 тактов,
 * → ожидание слота ещё 51–60, событие слота → tx_ssw 112, → чтение SIFS_CNT 41, SIFS_CNT → первая 0x19 469;
 * событие слота → 0x19 = 622 такта (3,77 мкс). До события делается всё, что от него не зависит:
 *  - выбор слота (r47) и mac_set_mode_a000 + 0x3d000002 — после маяка с CDOWN 0 (приём завершён), в цикле
 *    bti_bi2_track_best_metric; маяк CDOWN 0 не принят — на пути конца GP0, как раньше;
 *  - ответ A-BFT — прямо из ветки «конец GP0», без пяти возвратов и диспетчера; переход автомата BI BTI→A-BFT
 *    (l1_task_dispatch(2)) — после пачки SSW, uc_read_tsf_lo — после A-BFT (bti_dispatch_sweep_step, как был);
 *  - для своего слота: tx_ctx_alloc_next, норм/маска секторов, Duration SSW, шаблон — до ожидания события.
 * RF на передачу и кадр — только после события и сторожа: выданная до события 0x19 — обязательство MAC, её не
 * отменить (опыт: 0x3d000400+0x3d000200, 0x29000002, 0x3d000004 — «поздняя команда», assert 0x26; 0x18001000 —
 * кадр всё равно уходит в эфир). */
struct abft_ssw_st {
    u32 r13, r16, r15, r19, fss, rf;
};

static u32 abft_sta_pick_slot(void)
{
    /* число слотов = поле A-BFT Length + 1 (802.11-2020 9.3.4.2; 10.42.5.2 — случайный слот из [0, число слотов);
     * в 6.2 было & 7 без +1); r47 — случайное */
    u32 r14 = (((((u32)bcn_rx.bi_ctrl[1] << 8) | bcn_rx.bi_ctrl[0]) >> 7) & 7) + 1;
    u32 g = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = g | (1u << 17);
    uc_mac_cmd(g | 0x1d020000);
    arc_nops_nop(2);
    return (u32)(((u64)arc_core_rd(47) * r14) >> 32);
}

/* Программная часть ответа до цикла кадров — не зависит от момента события слота. */
static void abft_ssw_prep_sw(struct abft_ssw_st *s, u32 a)
{
    u32 r11 = 0x7fffffff, n;
    __asm__ volatile("norm %0, %1" : "=r"(n) : "r"(r11));
    s->r19 = a;
    s->r13 = (u8)(n + 1);
    s->r16 = r11 & ~(1u << (0x1f - s->r13));
    s->rf = 0;
    struct bcn_rx_s *r18 = &bcn_rx;
    s->fss = bcn_rx_fss(r18);
    if (s->fss < ABFT_SS_FRAMES_PER_SLOT)
        return;                                     /* не участвуем (abft_ssw_go не передаёт) */
    s->r15 = (u32)(((u64)abft_slot_clk(s->fss) * ABFT_CLK2FX_MUL) >> 10) - ABFT_SSW_TXTIME_FX;
    ssw_tpl_fc = 0x864;
    ssw_tpl_fb_sector = (r18->antenna << 6) | r18->sector;
    ssw_tpl_fb_snr = r18->metric;
    ssw_tpl_fb_b2 = 0;
    ssw_tpl_ra[0] = r18->bssid[0];
    ssw_tpl_ra[1] = r18->bssid[1];
    ssw_tpl_ra[2] = r18->bssid[2];
}

/* RF на передачу (после сторожа SIFS_CNT). */
static void abft_ssw_rf_tx(struct abft_ssw_st *s)
{
    uc_mac_cmd(0x3d000100);
    u32 r14 = (s->r13 << 8) | (rf_chain_cfg | 0x30);
    uc_mac_cmd(0x38000200);
    uc_mac_cmd(0x36000038);
    uc_mac_cmd(0x6000101);
    uc_mac_cmd(r14 | 0x3f000000);
    uc_mac_cmd(0x3e000000);
    uc_mac_cmd(0x37000020);
    uc_stats.tx_start += 1;
    u32 r3 = (rf_set_tx << 24) | (abif_dvs_rf_ctrl_shadow & 0xfcffffff);
    abif_dvs_rf_ctrl_shadow = r3;
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r3;
    s->rf = 1;
}

/* RF обратно на приём без передачи (как конец пачки, но без ожидания события 5 — кадра не было). */
static void abft_ssw_rf_back(struct abft_ssw_st *s)
{
    if (!s->rf)
        return;
    mac_set_rf_chain_state_with_sta_sector();
    u32 r = (rf_set_rx << 24) | (abif_dvs_rf_ctrl_shadow & 0xfcffffff);
    abif_dvs_rf_ctrl_shadow = r;
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r;
    s->rf = 0;
}

/* Пачка SSW с первого кадра (0x2d …); вызов — только stage 0. Ветки stage 1/3 (первый кадр выдан до события) —
 * от снятого опыта; оставлены, пока их удаление меняет раскладку цикла (ХРУПКО, см. СРОК ниже). */
static u32 abft_ssw_burst(struct abft_ssw_st *s, u32 stage)
{
    u32 r13 = s->r13, r16 = s->r16, r15 = s->r15, r19 = s->r19, r14 = s->fss, n;
    struct bcn_rx_s *r18 = &bcn_rx;
    u32 r17 = 1;
#ifdef UC_PATH_T
    u32 pt12 = 1;
#endif
    /* СРОК: соседние SSW ответчика — через SBIFS = 1 мкс, допуск aSBIFSAccuracy 0,03 мкс (802.11-2020
     * 10.3.2.3.8, 10.42.2.3.2); FSS кадров должны уложиться в aSSDuration (10.42.5.2). Путь между кадрами (от
     * tx_end r42.15 до запроса 0x19 и спина r45: шаблон, mac_evt_enable_bit_sync, 0x2d, abft_send_ssw_feedback —
     * 10 Б в FIFO и ожидание direct TX, mac_program_tx_common, спин MTP r43) ~230 инструкций ≈ 1,5–2 мкс +
     * задержки MTP; запас: нет — SBIFS программно не выдерживается. Хвост пачки уходит за aSSDuration и может
     * наехать на SSW-Feedback AP (через MBIFS после aSSDuration). Удлинение пути — меньше SSW в слоте. */
    if (stage == 1) {
        r17 = 0;
#ifdef UC_PATH_T
        pt12 = 0;                                   /* первая 0x19 уже выдана до события (точка 12 — там) */
#endif
        goto after_go;
    }
    do {
        uc_mac_cmd((*(u8 *)&rf_chain_cfg << 16) |
                           ((r14 << 1) | 0x2d000001 | (r13 << 10)));
        abft_send_ssw_feedback(0);
        uc_mac_cmd(((r15 + 1023u) >> 10) | 0x15000000);
        uc_mac_cmd(0x14000007);
        r15 -= ABFT_SSW_STEP_FX;
        mac_program_tx_common();
        while (!(arc_core_rd(43) & (1u << 31)))
            ;
        u32 aux51 = arc_core_rd(51);
        mtp_desc_lo = aux51 & 0xf;
        mtp_desc_hi = aux51 >> 4;
        mac_evt_enable_bit_sync_b(6);
        if (r17 != 0) {
            u32 r4 = mac_sel_shadow & 0xfff0ffff;
            mac_sel_shadow = r4 | (1u << 18);
            uc_mac_cmd(r4 | 0x1d040000);
            arc_nops_nop(2);
            uc_mac_cmd(0x38000200);
            uc_mac_cmd(0x36000038);
            uc_mac_cmd(0x6000103);
            r17 = 0;
        }
        uc_mac_cmd(0x2008000);
        {
            u32 v;
            if (txrx_state1 & 0x10) {
                v = (((mtp_desc_lo & 2) == 2) ? 1u : 0u) << 6;
                v |= 0x19800830;
                v |= mtp_desc_hi << 14;
            } else {
                v = 0x19000001;
            }
            uc_mac_cmd(v);
        }
#ifdef UC_PATH_T
        if (pt12) { UC_PATHT(12); pt12 = 0; }
#endif
        if (stage == 3) {                           /* первый кадр выдан до события — вернуться (не вызывается) */
            s->r13 = r13; s->r16 = r16; s->r15 = r15; s->fss = r14;
            return 1;
        }
after_go:
        while (!(arc_core_rd(45) & (1u << 31)))
            ;
        uc_mac_cmd((txrx_state1 & 0x10) ? 0x18000000 : 0x18001000);
        if (r14 == 0)
            break;
        r14 -= 1;
        __asm__ volatile("norm %0, %1" : "=r"(n) : "r"(r16));
        r13 = (u8)(n + 1);
        r16 = r16 & ~(1u << ((0x1f - r13) & 31));
        tx_program_vector_rf(r19, (rf_chain_cfg | 0x30) | (r13 << 8));
        while (!(arc_core_rd(42) & (1u << 15)))
            ;
        ssw_tpl_fc = 0x864;
        ssw_tpl_fb_sector = (r18->antenna << 6) | r18->sector;
        ssw_tpl_fb_snr = r18->metric;
        ssw_tpl_fb_b2 = 0;
        ssw_tpl_ra[0] = r18->bssid[0];
        ssw_tpl_ra[1] = r18->bssid[1];
        ssw_tpl_ra[2] = r18->bssid[2];
        mac_evt_enable_bit_sync(5);
        stage = 0;
    } while (1);
    mac_set_rf_chain_state_with_sta_sector();
    mac_evt_enable_bit_sync(5);
    u32 r = (rf_set_rx << 24) | (abif_dvs_rf_ctrl_shadow & 0xfcffffff);
    abif_dvs_rf_ctrl_shadow = r;
    *(volatile u32 *)HW_ABIF_DVS_RF_CTRL = r;
    s->rf = 0;
    return 1;
}

/* Подготовка своего слота до события (всё, что не зависит от момента): программная часть. */
static void abft_ssw_prep(struct abft_ssw_st *s, u32 a)
{
    tx_ctx_alloc_next(1);
    abft_ssw_prep_sw(s, a);
}

/* СРОК: SSW ответчика — в начале своего слота (802.11-2020 10.42.5.2): от события слота (r54.7) до 0x19 —
 * сторож SIFS_CNT (0x4d000000, 3 nop, r55), RF и кадр. Было (gp0path): 622 такта; без RF и шаблона на этом
 * отрезке — меньше на ~программную часть. */
static u32 abft_ssw_go(struct abft_ssw_st *s)
{
    UC_PAD(PAD_ABFT_SIFSCHK);
    uc_mac_cmd(0x4d000000);
    arc_nops(3);
    u32 aux55 = arc_core_rd(55);
    UC_PATHT(11);
    if (aux55 >= SIFS_CNT_ABFT_SSW_LATE || aux55 == 0) {
        abft_ssw_rf_back(s);
        return 0;
    }
    if (!s->rf)
        abft_ssw_rf_tx(s);
    if (s->fss < ABFT_SS_FRAMES_PER_SLOT) {        /* сюда не доходит: такой A-BFT отсеян решением (rx.c, bti.c) */
        abft_ssw_rf_back(s);
        return 0;
    }
    return abft_ssw_burst(s, 0);
}

/* Ответ A-BFT станции, вызов из ветки «конец GP0» bti_bi2_track_best_metric. pre — выбор слота и
 * mac_set_mode_a000 уже сделаны после маяка CDOWN 0 (slot — выбранный слот). */
void abft_responder_fast(struct sls_peer_rec *r, u32 pre, u32 slot)
{
    UC_PATHT(6);
    if (!pre) {
        mac_set_mode_a000((u32)r);
        uc_mac_cmd(0x3d000002);
        slot = abft_sta_pick_slot();
    }
    UC_PATHT(7);
    u32 r17 = arc_core_rd(54);
    u32 r16 = 0x180;
    u32 r14 = slot;
    u32 r15 = 0x100;
    u32 sm_done = 0, prepped = 0;
    struct abft_ssw_st st;
    if ((r17 & (1u << 7)) && r14 == 0) {
        if (((((u32)bcn_rx.bi_ctrl[1] << 8) | bcn_rx.bi_ctrl[0]) & 0x380) == 0)
            uc_spin_until_event4(r15);
        else
            r14 = 1;
    } else if (abft_gp0_armed != 0) {
        u32 r4 = abft_gp0_periods;
        if (r4 < r14) {
            r14 -= r4 + 1;
            abft_gp0_armed = 0;
        }
    }
#ifdef UC_PATH_T
    u32 pt_first = 1;
#endif
    for (;;) {
        /* Подготовка — только пока ждём слоты (r16 б7): после принятого Feedback (r16 = 0x100, ждём конца
         * A-BFT) кадров больше не будет — без лишнего tx_ctx_alloc_next (он трогает rf_chain_word) и без RF.
         * fp1: без этого условия fp_rf/fp_tx держали RF на передаче от Feedback до конца A-BFT. */
        if (r14 == 0 && !prepped && (r16 & (1u << 7))) {
            abft_ssw_prep(&st, (u32)r);
            prepped = 1;
        }
#ifdef UC_PATH_T
        if (pt_first) UC_PATHT(8);
#endif
        uc_spin_until_event4(r16);
#ifdef UC_PATH_T
        if (pt_first) { UC_PATHT(9); pt_first = 0; }
#endif
        if (arc_core_rd(54) & r15) {
            if (prepped)
                abft_ssw_rf_back(&st);
            uc_mac_cmd(0x3d000400);
            uc_mac_cmd(0x3d000200);
            if (!sm_done)
                l1_task_dispatch(2, 0);             /* BTI → A-BFT в автомате BI (было до ответа) */
            return;
        }
        uc_mac_cmd(0x49000080);
        if (abft_arm_response_window() != 0) {
            r15 = 0x100;
            continue;
        }
        if (r14 != 0) {
            r14 -= 1;
            r15 = 0x100;
            continue;
        }
        r14 = 0;
        UC_PATHT(10);
        u32 sent = abft_ssw_go(&st);
        prepped = 0;
        if (!sm_done) {
            l1_task_dispatch(2, 0);                 /* после пачки — вне срока */
            sm_done = 1;
        }
        if (sent != 0) {
            for (;;) {
                uc_wait_event1_or_event4(1u << 12, 0x80, 0);
                if (arc_core_rd(42) & (1u << 12)) {
                    if (abft_resp_parse_fdbk(r) == 0)
                        continue;
                    u32 v = ((u32)r->abft_sector << 8) | rf_chain_cfg | 0x30;
                    sta_tab[r->abft_sta].tx_sel = v;
                    bcn_rx.abft_ok_cnt += 1;
                    abft_cfg.relax_cnt = *(u16 *)&abft_cfg.relax_period;
                    /* 10.42.5.2: Feedback в A-BFT маяка с Discovery Mode = 1 — не пытаться следующие
                     * aMaxABFTAccessPeriod (2) A-BFT */
                    if ((bcn_rx.bi_ctrl[0] & 2u) && abft_cfg.relax_cnt < ABFT_MAX_ACCESS_PERIOD)
                        abft_cfg.relax_cnt = ABFT_MAX_ACCESS_PERIOD;
                    uc_evt_build_and_post_report(r, 0);
                    r16 = 0x100;
                    goto fdbk_done;
                }
                if (arc_core_rd(54) & (1u << 7))
                    break;
            }
        }
        bcn_rx.abft_nofb_cnt += 1;
        r14 = abft_sta_pick_slot();
fdbk_done:
        mac_set_mode_a000((u32)r);
        uc_mac_cmd(0x3d000002);
        r15 = 0x100;
    }
}

/* GP0 станции: конец BTI по Duration принятого маяка (802.11-2020 10.42.5.1).
 * Пуск 0x5200090c — по концу GP2 (H-GP9), GP2 = 0x284 = 3,903 мкс стартует концом приёма кадра (H-GP5):
 * GP0 = Duration − 0x284 + UC_ABFT_STA_GP0_TRIM_CLK кончается в конец BTI. Стенд std2 (5 пачек, оба AP):
 * конец GP0 − конец BTI = −0,25 мкс при TRIM = 0 (r42.12 — через 9,06 мкс от начала кадра, не в конце).
 * ХРУПКО: взвести до конца GP2 = конец маяка + 3,903 − 0,25 мкс = r42.12 + (TXTIME − 9,06) + 3,65: 13,72 мкс у
 * маяка 34 Б (наш AP), 14,30 у 38 Б (vendor). Граница жёсткая: GP0, взведённый после конца GP2, ждал бы конца
 * следующего GP2, а GP2 сразу перепрограммируется на конец A-BFT (0x5400070e) — GP0, GP1, GP2 не стартуют;
 * отсюда проверка ниже. Путь r42.12 → 0x4f (стенд std3, взвод здесь, сразу после сверки BSSID): 11,34 мкс
 * (наш AP), 11,92 (vendor) — запас 2,4 мкс ≈ 400 тактов. Почти весь путь — ожидание ppdu_report (r42.16) в
 * bti_worker_bi2_step: rx_buf (BSSID, Duration) читается после переключения буфера по r42.16, раньше взводить
 * нечем. Вытеснение прерываниями L1/L2 на этом отрезке не ограничено (кандидат: запрет прерываний от r42.12
 * до взвода). Отказ в std3 (r2std_3) — не это окно: вход kind 1 на последнем маяке (CDOWN 0). Порядок команд:
 * квитирование r54.8 (0x49000100) до взвода (иначе r54.8 прошлого GP2 читается как опоздание). Возврат: 1 — GP2 идёт, GP0 стартует по его концу;
 * 2 — опоздание (r54.8 после квитирования или GP_CLK2 = 0: GP2 не идёт) — A-BFT в этом BI не начинать. */
static u32 abft_sta_arm_gp0(void)
{
    u32 sub = ABFT_STA_GP2_RXEND_CLK - UC_ABFT_STA_GP0_TRIM_CLK;
    u32 d165 = (u32)rx_buf_duration * ABFT_CLK_PER_US;
    u32 v = (d165 >= sub + ABFT_CLK_PER_US) ? d165 - sub : ABFT_CLK_PER_US;
    uc_mac_cmd(0x52000000);
    uc_mac_cmd(0x52000000);
    uc_mac_cmd(0x49000040);
    uc_mac_cmd(v | 0x4f000000);
    uc_mac_cmd(0x5200090c);
    return (bti_bi2_gp2_end_flag() != 0 || abft_gp_clk2() == 0) ? 2u : 1u;
}

/* chk = 0 — без проверок окна BI и синхронизации BI (вход в BTI с пути приёма, см. bti_transmitter_bi2_flow). */
static u32 bti_bi2_event_step_chk(struct bi_ctx_s *c, u32 chk)
{
    /* 6.2 asm 0x936e40. */
    u32 r16 = 0, r17 = 0, r5 = 0, metric = 0;

    uc_mac_cmd(0x2051030);
    bti_cnt.bi2_tsf = uc_read_tsf_lo();
    if (chk != 0) {
        if (!uc_bi_counter_in_window((u32)c))
            goto err;
        if (!uc_read_bi_sync())
            goto err;
    }

    u32 t_bcn = 0;
    for (;;) {                                        /* L_936e90 */
        uc_wait_event_busy(0x20u | (1u << 12), 0);
        t_bcn = abft_t1();                           /* r42.12 первого маяка: конец BTI для поправки по последнему маяку */
        if (!(arc_core_rd(42) & (1u << 12))) {
            /* L_937298 */
            u32 r1 = mac_sel_shadow & 0xffff0fff;
            mac_sel_shadow = r1 | (1u << 14);
            uc_mac_cmd(r1 | 0x1d004000);
            arc_nops(3);
            bti_bi2_bi_counter = arc_core_rd(40) & 0x3ffffff;
            bi_win.bi2_cnt += 1;
            uc_log_emit_snapshot(0x20, 0x1001d5c);
            mac_mon_report.bi2_events += 1;
            bti_count_sweep_round(c);
            return 0;
        }
        if (bti_worker_bi2_step(c->kind, 1) != 0) {   /* breq_s → L_936e90 */
            break;
        }
    }

    uc_mac_cmd(0x49000100);
    {
        /* б31..30 — итог взвода GP0 (для bti_transmitter_bi2_flow), б29..0 — Timer1 «конца BTI» по этому маяку
         * (t r42.12 + Duration; для поправки по последнему маяку в bti_bi2_track_best_metric). Timer1 < 2^29. */
        u32 st = abft_sta_arm_gp0();
        bti_cnt.x04 = ((t_bcn + (u32)rx_buf_duration * ABFT_CLK_PER_US) & 0x3fffffffu) | (st << 30);
    }
    bcn_rx.my_bss = arc_core_rd(38) & 1;                 /* bmsk r1,r38,0x0 */
    u32 r3 = (rx_buf_body18 | ((u32)rx_buf_body19 << 8)) & 0x780;

    if (r3 == 0) {
        bcn_rx.bi_ctrl[0] = rx_buf_bcn_bi_ctrl0;
        bcn_rx.bi_ctrl[1] = rx_buf_body18;
        bcn_rx.bi_ctrl[2] = rx_buf_body19;
        bcn_rx.bi_ctrl[3] = rx_buf_body1a;
        bcn_rx.bi_ctrl[4] = rx_buf_brp_req;
        bcn_rx.bi_ctrl[5] = rx_buf_body1c;
        bcn_rx.bss_type = rx_buf_bcn_dmg_params & 3;   /* bmsk 0x1 */
        r3 = (bcn_rx.bi_ctrl[1] >> 2) & 0xf;
        if (r3 >= 4)                                   /* bcc → L_937118 */
            goto counter_machine;
        bcn_rx.abft_here = 0;
        bcn_rx.abft_go = 0;
        r16 = 0x800;
        r17 = 1;
        goto post;                                     /* → L_936fe8 */
    }
    /* L_936f4c */
    r5 = 0;
    bcn_rx.abft_here = 0;

sweep_body:                                            /* L_936f54 */
    bcn_rx.abft_go = r5;
    r16 = 0x800;
    r17 = 1;
    if (r5 != 0) {
        u32 r10 = mac_sel_shadow & 0xffff0fff;
        mac_sel_shadow = r10 | 0xd000;
        uc_mac_cmd(r10 | 0x1d00d000);
        arc_nops(3);
        u32 r11 = arc_core_rd(40);
        metric = r11;                                  /* sp[0] = сырое */
        u32 r11s = (r11 >> 9) & 0x7ff;
        bcn_rx.metric = (r11s <= 0x3ff) ? r11s : (r11s - 0x800);
        bcn_rx.sector = (u8)(rx_buf_bcn_ssw >> 10);
        bcn_rx.antenna = (u8)(rx_buf_bcn_ssw_hi & 3);
    }
    /* L_936fd0 */
    bcn_rx.bssid[0] = rx_buf_ra[0];
    bcn_rx.bssid[1] = rx_buf_ra[1];
    bcn_rx.bssid[2] = rx_buf_ra[2];

post:                                                  /* L_936fe8 */
    MMIO32(HW_PRS_OWN_ADDR_HI) &= 0x7fffffffu;
    {
        u32 r0 = mac_sel_shadow & 0xffff0fff;
        mac_sel_shadow = r0 | 0xd000;
        uc_mac_cmd(r0 | 0x1d00d000);
        arc_nops(3);
    }
    {
        u32 r8 = (arc_core_rd(40) >> 9) & 0x7ff;
        metric = (r8 <= 0x3ff) ? r8 : (r8 - 0x800);    /* sp[0] = знаковое */
    }

    if (rx_meas.state == 2) {
        u32 kind = rx_meas.kind;
        if (kind != 0 && kind <= 6 && rx_capture_match_filter(&rx_meas)) {
            switch (kind) {
            case RX_MEAS_ENERGY: rx_meas_append_sample(&rx_meas, (u32)&metric); break;
            case RX_MEAS_PLCP: rx_meas_finish_with_8830ec(&rx_meas); break;
            case RX_MEAS_PKT: rx_meas_capture_frame(&rx_meas, (u32)&metric); break;
            case 5: {
                u32 r6 = mac_sel_shadow & 0xffff0fff;
                mac_sel_shadow = r6 | 0x5000;
                uc_mac_cmd(r6 | 0x1d005000);
                arc_nops(3);
                rx_meas.snap_sel5 = arc_core_rd(40);
                r6 = mac_sel_shadow & 0xffff0fff;
                mac_sel_shadow = r6 | 0x6000;
                uc_mac_cmd(r6 | 0x1d006000);
                arc_nops_nop(2);
                rx_meas.snap_sel6 = arc_core_rd(40);
                rx_meas.state = r17;
                bf_pending_set_bit(0);
                break;
            }
            default: break;   /* 4, 6 */
            }
        }
    }

    /* L_937224 */
    {
        u32 r1 = g_800598;
        u32 bit0 = rx_mode_flags & 1u;
        if ((r1 != 0) == (bit0 != 0)) {
            u32 idx = mac_mon_slot_idx;
            struct mac_mon_slot_s *r8 = &mac_mon_slot[idx];
            if (r8->rssi < (s32)metric) {
                r8->rssi = metric;
                r8->rssi_valid = 1;
            }
        }
    }
    c->round = r16;
    return 1;

counter_machine:                                       /* L_937118 */
    bcn_rx.abft_here = 1;
    {
        u32 r9 = abft_cfg.responder_mode;
        u32 r3c = abft_cfg.beacon_type;
        if (r9 == 3)
            goto inc_0x24;
        if (r9 == 0) {
            if (maint_sta_mask != 0)
                goto inc_0x24;
        } else if (r9 == 1) {
            if (maint_sta_mask == 0)
                goto inc_0x24;
        }
        /* L_937164 */
        if (r3c == 0) {
            u32 r9b = bcn_rx.bi_ctrl[0] | ((u32)bcn_rx.bi_ctrl[1] << 8);
            if (r9b & 2)
                goto inc_0x26;
        }
        /* L_93717c */
        if (r3c == 1) {
            u32 r0 = bcn_rx.bi_ctrl[0] | ((u32)bcn_rx.bi_ctrl[1] << 8);
            if (r0 & 2)
                goto disc_check;
        } else {
            goto disc_check;
        }
        goto inc_0x26;                                 /* r3c==1 && бит1 сброшен */
    }
disc_check:
    if (((bcn_rx.bi_ctrl[1] >> 2) & 0xfu) < ABFT_SS_FRAMES_PER_SLOT)
        goto inc_0x26;                                 /* поле FSS < aSSFramesPerSlot (10.42.5.2): не участвуем */
    if (!abft_discovery_ok())                          /* 10.42.5.1: условия Discovery Mode не выполнены */
        goto inc_0x26;
    goto dec_counter;

inc_0x24:
    bcn_rx.abft_skip_mode += 1;
    r5 = 0;
    goto sweep_body;
inc_0x26:
    bcn_rx.abft_skip_type += 1;
    r5 = 0;
    goto sweep_body;
dec_counter:                                           /* L_9371c8 */
    /* relaxation: после Feedback пропускать следующие A-BFT; маяк, адресующий нас (Discovery, CC, A-BFT Responder
     * Address = наш MAC), — без пропуска (10.42.5.2, aMaxABFTAccessPeriod) */
    if (abft_cfg.relax_cnt >= 1 && !abft_bcn_addressed_to_us()) {   /* brlt r7,0x1 → знаков. на zero-ext */
        abft_cfg.relax_cnt -= 1;
        bcn_rx.abft_skip_relax += 1;
        r5 = 0;
        goto sweep_body;
    }
    bcn_rx.abft_try += 1;                             /* L_9371e8 */
    r5 = 1;
    goto sweep_body;

err:                                                   /* L_937328 */
    uc_log_emit_snapshot(0x20, 0x1001d68);
    c->status = 0;
    return 0;
}

u32 bti_bi2_event_step(struct bi_ctx_s *c)
{
    return bti_bi2_event_step_chk(c, 1);
}

void bti_bi2_track_best_metric(struct bi_ctx_s *c)
{
    /* 6.2 asm 0x93dc80. */
    u32 r16 = 0x140;
    u32 metric = 0;                           /* sp[0] */
    u32 fp_pre = 0, fp_slot = 0;              /* выбор слота и mac_set_mode_a000 сделаны после маяка CDOWN 0 */

    uc_mac_cmd(0x2011000);

    for (;;) {
        /* L_93dcbc */
        uc_wait_event1_or_event4(1u << 12, r16, 0);  /* r1 = r16 (биты r54), r2 = 0 */
        if (arc_core_rd(42) & (1u << 12)) {        /* btst r3,0xc */
            u32 t_bcn = abft_t1();
            if (bti_worker_bi2_step(c->kind, 0) == 0)   /* breq → цикл */
                continue;
            /* Конец BTI — по Duration ПОСЛЕДНЕГО принятого маяка (802.11-2020 10.42.5.1). GP0 не трогаем (он
             * стартовал по концу GP2 первого маяка); границы слотов (GP1) и конец A-BFT (GP2) ещё не
             * стартовали — их значения сдвигаются на разницу «конец BTI по этому маяку − по первому»
             * (Timer1 r42.12 + Duration; задержка r42.12 от начала кадра у маяков одной длины одинакова).
             * Стенд std2/std3: у нашего AP разница до +1,33 мкс (CDOWN 0), у vendor до +1,0. Разница вне
             * ±5 мкс (обнуление Timer1 тиком L1) — не трогать. */
            if (bcn_rx.abft_here != 0 && !(arc_core_rd(54) & 0x40u) && bti_cnt.x04 != 0) {
                s32 dl = (s32)(((t_bcn + (u32)rx_buf_duration * ABFT_CLK_PER_US) & 0x3fffffffu) - bti_cnt.x04);
                u32 fss = (bcn_rx.bi_ctrl[1] >> 2) & 0xf;
                if (dl > -(s32)(5 * ABFT_CLK_PER_US) && dl < (s32)(5 * ABFT_CLK_PER_US) && fss >= ABFT_SS_FRAMES_PER_SLOT) {
                    if (bcn_rx.abft_go != 0) {       /* как bti_tx_program_bi2_regs, без квитирования r54.7 */
                        uc_mac_cmd((u32)((s32)ABFT_STA_STD_GP1_CLK + dl) | 0x50000000u);
                        uc_mac_cmd(0x5300070e);
                    }
                    u32 n = ((((u32)bcn_rx.bi_ctrl[1] << 8) | bcn_rx.bi_ctrl[0]) >> 7 & 7) + 1;
                    /* как bf_gpc_program_mac_by_mode_b, без квитирования r54.8 (его ждёт этот цикл, r16) */
                    uc_mac_cmd((u32)((s32)(n * abft_slot_clk(fss) + ABFT_MBIFS_CLK) + dl) | 0x51000000u);
                    uc_mac_cmd(0x5400070e);
                }
            }

            u32 r8 = mac_sel_shadow & 0xffff0fff;
            mac_sel_shadow = r8 | 0xd000;
            uc_mac_cmd(r8 | 0x1d00d000);
            arc_nops(3);

            u32 r7 = (arc_core_rd(40) >> 9) & 0x7ff;
            metric = (r7 <= 0x3ff) ? r7 : (r7 - 0x800);   /* mov.ls r9,r7 */

            if (rx_meas.state == 2) {         /* cmp r10,0x2; bne */
                u32 kind = rx_meas.kind;
                if (kind != 0 && kind <= 6) {             /* beq + bhi */
                    if (rx_capture_match_filter(&rx_meas)) {
                        switch (kind) {
                        case RX_MEAS_ENERGY:
                            rx_meas_append_sample(&rx_meas, (u32)&metric);
                            break;
                        case RX_MEAS_PLCP:
                            rx_meas_finish_with_8830ec(&rx_meas);
                            break;
                        case RX_MEAS_PKT:
                            rx_meas_capture_frame(&rx_meas, (u32)&metric);
                            break;
                        case 5: {
                            u32 r6 = mac_sel_shadow & 0xffff0fff;
                            mac_sel_shadow = r6 | 0x5000;
                            uc_mac_cmd(r6 | 0x1d005000);
                            arc_nops_nop(2);
                            rx_meas.snap_sel5 = arc_core_rd(40);
                            r6 = mac_sel_shadow & 0xffff0fff;
                            mac_sel_shadow = r6 | 0x6000;
                            uc_mac_cmd(r6 | 0x1d006000);
                            arc_nops(3);
                            rx_meas.snap_sel6 = arc_core_rd(40);
                            rx_meas.state = 1;
                            bf_pending_set_bit(0);
                            break;
                        }
                        default: break;   /* 4, 6 */
                        }
                    }
                }
            }

            /* L_93de2c */
            if (bcn_rx.abft_go == 1) {        /* breq r9,0x1 */
                if ((s32)bcn_rx.metric < (s32)metric) {   /* brge r0,r7 */
                    bcn_rx.metric = metric;
                    bcn_rx.sector = (u8)(rx_buf_bcn_ssw >> 10);
                    bcn_rx.antenna = (u8)(rx_buf_bcn_ssw_hi & 3);
                }
            }

            /* L_93de3c */
            {
                u32 r10 = g_800598;
                u32 bit0 = rx_mode_flags & 1u;
                if ((r10 != 0 && bit0) || (r10 == 0 && !bit0)) {
                    /* L_93de64 */
                    u32 idx = mac_mon_slot_idx;
                    struct mac_mon_slot_s *r5p = &mac_mon_slot[idx];
                    if ((s32)metric > r5p->rssi) {   /* ble → цикл */
                        r5p->rssi = metric;  /* L_93dcb0 */
                        r5p->rssi_valid = 1;
                    }
                }
            }
            /* Маяк с CDOWN 0 — последний в BTI, приём завершён: подготовка ответа A-BFT до конца GP0
             * — выбор слота (r47) и mac_set_mode_a000 + 0x3d000002 (ожидания r40.24/r40.3 уже выполнены).
             * Путь цикла после маяка удлиняется на ~100 инструкций, но до конца GP0 у нашего AP ≥ 1,6 мкс
             * (D_last = 3), у vendor-AP ~19 мкс. Маяк CDOWN 0 не принят — всё на пути конца GP0, как раньше. */
            if (bcn_rx.abft_go != 0 && !fp_pre && ((rx_buf_bcn_ssw >> 1) & 0x1ff) == 0) {
                mac_set_mode_a000((u32)&c->rec);
                uc_mac_cmd(0x3d000002);
                fp_slot = abft_sta_pick_slot();
                fp_pre = 1;
            }
        } else {
            /* L_93dec4 */
            if (arc_core_rd(54) & (1u << 6)) {             /* bbit1 r6,0x6 */
                if (bcn_rx.abft_here != 0) {     /* brne r5,0x0 → L_93df18 */
                    uc_mac_cmd(0x49000040);
                    uc_mac_cmd(0x49000100);
                }
                /* L_93def0 */
                if (bcn_rx.abft_go != 0)   /* bl.ne L_9307bc */
                    bti_arm_period_gp0();
                c->status = 1;
                if (bcn_rx.abft_go != 0) {
                    /* ответ A-BFT сразу, без возврата через bti_transmitter_bi2_flow/bti_prepare_sweep_set/
                     * bti_dispatch_sweep_step/bi_run_bti_cycle; bi_run_bti_cycle его не повторит (fast_done) */
                    abft_responder_fast(&c->rec, fp_pre, fp_slot);
                    c->fast_done = 1;
                }
                return;
            } else {
                if (arc_core_rd(54) & (1u << 8)) {         /* bbit0 r3,0x8 → assert */
                    bti_request_bf_metric();
                    r16 = 0x40;
                } else {
                    uc_assert((u32)__builtin_return_address(0), 0x5a);
                }
            }
        }
    }
}

void bti_arm_period_gp0(void)
{
    /* 6.2 asm 0x9307bc. */
    u8 r5 = (bcn_rx.bi_ctrl[1] >> 2) & 0xf;
    if (r5 < ABFT_SS_FRAMES_PER_SLOT)        /* поле FSS ниже aSSFramesPerSlot: в таком A-BFT не участвуем */
        return;

    u32 r14 = abft_slot_clk(r5);

    /* СРОК: остаток до следующей границы SSW-слота считается по GP_CLK2_TIMER (r55, 0x4d00000a) и
     * пишется в GP1 (0x50) от момента команды; слоты смежны (802.11-2020 10.42.5.2), сетка станции
     * должна совпадать с сеткой AP с точностью ~aAirPropagationTime (0,1 мкс). От чтения r55 до 0x50
     * ~11 инструкций + 4 на каждый уже прошедший слот в цикле вычитания (vendor 0x930838 — тот же
     * цикл); запас: десятки. Каждый такт здесь сдвигает границы слотов станции позже AP. */
    if (arc_core_rd(54) & 0x80u) {
        /* Поздно: первая граница GP1 уже прошла. Прошло от конца GP0 e = (ход GP2) − остаток (H-CLK2);
         * границы GP1 — first + k·P. vendor (ветка ниже) считал фазу от конца GP0 + MBIFS, а не от своей
         * границы слота 0 (+0x3de): границы после поздней ветки — на 0x1ef (3 мкс) позже обычных. */
        u32 n = ((((u32)bcn_rx.bi_ctrl[0] | ((u32)bcn_rx.bi_ctrl[1] << 8)) >> 7) & 7) + 1;
        u32 first = ABFT_STA_STD_GP1_CLK;
        u32 total = n * r14 + ABFT_MBIFS_CLK;
        u32 clk2 = abft_gp_clk2();
        u32 x = (total > clk2 + first) ? total - clk2 - first : 0;
        u32 r6 = 0;
        while (x >= r14) {
            x -= r14;
            r6++;
        }
        abft_gp0_periods = (u8)r6;
        uc_mac_cmd((r14 - x) | 0x50000000u);
        uc_mac_cmd(0x5300080e);
        uc_mac_cmd(0x49000080);
        abft_gp0_armed = 1;
    }
    uc_mac_cmd(r14 | 0x50000000u);
    uc_mac_cmd(0x5300080e);
    uc_mac_cmd(0x49000080);
}

u32 bti_prepare_sweep_set(struct bi_ctx_s *c, u32 kind)
{
    /* 6.2 asm 0x935b9c. */
    u8 set = (u8)(bti_sweep_set + 1);      /* ldb [gp,-0xf7]; add 1 */
    u8 nsets = fwsh_n_sets;              /* ldb [0x857800-0xc4] */
    if (set == nsets)                        /* brne r2,r7 → пропустить сброс */
        set = 0;
    bti_sweep_set = set;                   /* stb [gp,-0xf7] */

    if (uc_role_ap != 0 && nsets >= 2) {  /* breq r8,0 + brlt r7,2 */
        u32 word = rf_chain_word;
        u32 r9 = ror32(word, 8) & 0xffff8000u;
        rf_chain_word = ror32((u32)(set & 0x7fff) | r9, 24);
    }

    u8 prev = ss_plan_n_sectors;               /* sweep_list.count */
    ss_rfset.order[prev] = prev;         /* sector[prev] = prev */
    const u8 *range = (const u8 *)(fwsh_set_ranges) + set * 2;
    u8 count = (u8)(range[1] - range[0] + 1);
    ss_plan_n_sectors = count;                 /* sweep_list.count */
    ss_rfset.order[count] = 0xff;        /* sector[count] = 0xff */
    ss_plan_set = set;                   /* sweep_list.set */

    c->kind = kind;
    c->status = 6;                           /* STARTED */
    if (kind == 0) {
        bcn_rx.my_bss = 1;                 /* g_bti_rx_bcon_mine = 1 */
        uc_tx_is_idle();
        mac_cmd_0f_step(&pm_ctx);           /* bl L_92e438: aw_set_new_tbtt + [a+0x140]=0 */
        bti_kind_nonzero = 0;                /* [gp,0x1d] = 0 */
    } else {
        bti_kind_nonzero = 1;                /* [gp,0x1d] = 1 */
    }

    u32 sweep = 0;
    if (bi_cfg.bi_mode != 0) {             /* ld r0,[0x8022a8]; breq → skip */
        uc_mac_cmd(0xf000001);
        u32 r5 = mac_sel_shadow & 0xfffff0ff;
        mac_sel_shadow = r5 | 0x300;
        uc_mac_cmd(r5 | 0x1d000300);
        arc_nops(3);
        if (arc_core_rd(41) & (1u << 30)) {       /* bbit0 r7,0x1e */
            if (c->kind != 1)              /* ld_s r1,[r13]; brne r1,0x1 */
                sweep = 1;
        }
    }

    if (!sweep)
        bti_transmitter_bi2_flow(c);         /* L_923b50 */
    else
        bti_worker_bti_transmitter_beacon_sweep_flow(c);   /* L_923cb4 */

    return c->status;                        /* ldb_s r0,[r13,0x4] */
}

void aw_set_new_tbtt(struct pm_ctx_s *p)
{
    /* 6.2 asm 0x93520c. */
    u32 tsf = uc_read_tsf_lo();
    aw_compute_tbtt_from_hw(0, p->tbtt);
    if (p->tbtt[0] - tsf > 0x2710) {
        /* TBTT ушёл вперёд дальше 10 мс — откат на один BI (64 бит) */
        u32 bi = (u32)mac_get_beacon_interval_tu_uc() << 10;
        u64 t = ((u64)p->tbtt[1] << 32 | p->tbtt[0]) - bi;
        p->tbtt[0] = (u32)t;
        p->tbtt[1] = (u32)(t >> 32);
    }
    /* vendor дальше применял на этом TBTT запросы расписаний PS (своё и станций, LMAC 0x22) и
     * Awake Window из IE (LMAC 0x25) — энергосбережение вырезано (см. fw/action.c psc_req_reject). */
}
