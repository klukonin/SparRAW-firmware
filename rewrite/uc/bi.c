// SPDX-License-Identifier: AGPL-3.0-or-later
/* BI-mode (Beacon Interval) uCode. */
#include "../include/types.h"
#include "../include/bitfield.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "abft.h"


/* Уже портированы в boot.c / stubs.c / mac.c — не переопределять. */

/* ---- Локальные stub-ы глубоких подфункций ---- */
u32 bi_phase_from_sm_state(void)
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
    mac_fw2uc_irq_unmask_cmd_halt_wake();
    pm_event_mask_restore();
}
void gp_timer_stop(u32 a)
{
    uc_mac_cmd((a + 0x52) << 24);
    uc_mac_cmd((0x49u << 24) | (1u << (a + 6)));
}
void mem_clear_word(u32 a)
{
    *(u32 *)a = 0;
}

/* ---- bits_set_u8_*: поле байта (include/bitfield.h). ---- */
void bits_set_u8_s0_w5_uc(u32 ptr, u32 value) { bf_set8(ptr, 0, 5, value); }
void bits_set_u8_s0_w6_uc(u32 ptr, u32 value) { bf_set8(ptr, 0, 6, value); }
void bits_set_u8_s0_w7_uc(u32 ptr, u32 value) { bf_set8(ptr, 0, 7, value); }
void bits_set_u8_s6_w2_uc(u32 ptr, u32 value) { bf_set8(ptr, 6, 2, value); }
/* 0x9263c8 — не функция: хвост цикла aw__walk_peer_bits_noop (переход на 0x9263ba). */

/* ---- Простые accessors ---- */
u32 bit_iter_has_more_uc(u32 a) { return (*(u32 *)a != 0) ? 1 : 0; }

void bi_aw_set_qset_1ms(struct aw_win_s *w) { w->qset_val = 0x28488; }

void bi_init_set_mac_arg_pair(u32 a, u32 b)
{
    MMIO32(HW_MAC_BI_INIT_ARG1) = b;
    MMIO32(HW_MAC_BI_INIT_ARG0) = a;
}

void bi_ctx_clear_state_words(void) { memset0_words_uc(&bcn_rx.bcn_sent, 2); }   /* bcn_sent, abft_go */

void bi_ctx_clear_word0(u32 a) { mem_clear_word(a); }

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
    bi_aw_set_qset_1ms(&c->aw);
    bi_ctx_clear_word0((u32)&c->dti_wake);
}

/* ---- State-machine действия ---- */
void bi_sm_init(void) { bi_sm_obj_init(&bi_sm); /* 6.2 asm 0x92acf8 → 0x92aeb4 */ }

void bi_sm_action_invalid(u32 a) { (void)a; uc_assert((u32)__builtin_return_address(0), 0x1033); }

void bi_dispatch_by_role(struct bi_ctx_s *c)
{
    u32 role = c->phase;
    if (role == 0)
        uc_assert((u32)__builtin_return_address(0), 0x67);
    else if (role == 1)
        bi_dti_start_tx_slot();
    else if (role == 2)
        bi_rx_slot_handler(&c->aw);
    else
        uc_assert((u32)__builtin_return_address(0), 0x68);
}

void bi_dti_start_tx_slot(void)
{
    /* vendor: при своём расписании PS (psc.state ≠ 0) — особый путь; PS вырезан */
    sp_run_tx_slot();
    ese_dti_sp_src_cycle();                         /* своё SP: следующие доступы без отсрочки (uc/ese_dti.c) */
}

void bi_after_enter_aw(struct bi_ctx_s *c)
{
    u32 st = bi_phase_from_sm_state();
    c->phase = st;
    if (st != 2)
        uc_assert((u32)__builtin_return_address(0), 0x64);
    aw_start_window(&c->aw, uc_read_tsf_lo());
}

void bi_after_enter_dti(struct bi_ctx_s *c)
{
    u32 st = bi_phase_from_sm_state();
    c->phase = st;
    if (st != 1)
        uc_assert((u32)__builtin_return_address(0), 0x62);
    (void)uc_read_tsf_lo();                     /* vendor bl L_9364c8: MAC-команда 0x4d000005 */
    bi_dti_step();
}

/* bi__remaining_time_us (6.2 asm 0x92dc44): остаток NAV, max(·, 0) и знаковый min с max_us —
 * как у vendor (max/min). */
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
    uc_mac_cmd(0x5a000000);
    ese_dti_on_dti_start();                        /* расписание ESE: DTI закрыт вне разрешённых окон */
}

void bi_bti_end_reset_timers(struct sls_peer_rec *r)
{
    /* 0x922258 */
    (void)r;
    memset0_words_uc(&bcn_rx.bcn_sent, 2);      /* bcn_sent, abft_go */
    gp_timer_stop(0);
    gp_timer_stop(1);
    gp_timer_stop(2);
    bti_gp2_arm_rx_end();
}

/* ---- BI state-machine действия (bi_sm_action_*) ---- */
void bi_sm_on_bhi_to_aw_in_aw(u32 obj)
{
    uc_mac_cmd(0xcaf662);
    (void)obj;
    bi_win.evt_in_aw += 1;
    bi_aw_flag = 1;                       /* st.as 1,[gp,-52]: ×4 = 0x800458 */
}

void bi_sm_on_bhi_to_dti_in_aw(u32 obj)
{
    uc_mac_cmd(0xcaf661);
    (void)obj;
    bi_win.evt_in_aw += 1;
    bi_aw_flag = 1;                       /* st.as 1,[gp,-52]: ×4 = 0x800458 */
}

void bi_sm_on_dti_to_bti_in_aw(void)
{
    uc_mac_cmd(0xcaf660);
    uc_mac_cmd(0x2000010);
    bi_win.dti_to_bti_in_aw += 1;
    bi_win.evt_in_aw += 1;
    bi_aw_flag = 1;
}

void bi_sm_on_aw_to_dti_in_bti(void)
{
    uc_mac_cmd(0xcaf440);
    bi_win.aw_to_dti_in_bti += 1;
}

void bi_sm_on_event_in_dti(void)
{
    uc_mac_cmd(0xcaf550);
    bi_win.evt_in_dti += 1;
}

void bi_sm_on_bti_to_abft(u32 obj)
{
    u8 state = *(u8 *)obj;
    uc_mac_cmd((state & 0xf) | 0xcaf000);
    bi_win.state = state;
    bi_win.bti_to_abft += 1;
}

void bi_sm_on_enter_aw(u32 obj)
{
    u8 state = *(u8 *)obj;
    uc_mac_cmd((state & 0xf) | 0xcaf220);
    bi_win.state = state;
    bi_win.bhi_to_aw += 1;
    bi_aw_flag = 0;
    bi_after_enter_aw(&bi_ctx);                 /* 6.2: 0x92b798 */
}

void bi_sm_on_dti_to_bti(u32 obj, u32 a)
{
    u8 state = *(u8 *)obj;
    uc_mac_cmd((state & 0xf) | 0xcaf000);
    bi_win.state = state;
    bi_win.dti_to_bti += 1;
    bti_dispatch_sweep_step(&bi_ctx, a);        /* 6.2: 0x92b7dc */
}

void bi_sm_on_enter_dti(u32 obj)
{
    u8 state = *(u8 *)obj;
    uc_mac_cmd((state & 0xf) | 0xcaf110);
    bi_win.state = state;
    bi_win.to_dti += 1;
    mac_mon_armed = 1;
    bi_ctx.bi_start_rx = 0;
    bi_after_enter_dti(&bi_ctx);                /* 6.2: 0x92b85c */
}

void bi_cfg_tick_counters(void)
{
    if (bcn_bi.abft_bi_left == 0) {
        u8 prev = bi_cfg.n_bi_abft;
        u8 n = bcn_bi.abft_idx + 1;
        bcn_bi.abft_bi_left = prev;
        bcn_bi.abft_idx = n;
        /* A-BFT Count (B31–B36) — по модулю N A-BFT in Ant (B37–B42 = abft_cnt_mod). vendor сравнивал «==»: при модуле 0
         * (одна RX-антенна, оба поля зарезервированы, 9.3.4.2 — передавать 0) счётчик рос до 255, заходя в B37–B38.
         * «≥» при модуле 0 держит 0, при ненулевом — то же, что «==». */
        if (n >= bi_cfg.abft_cnt_mod)
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

void bi_cfg_pack_bcon_cfg(u32 a, u32 b)
{
    (void)b;
    u32 r2 = bi_cfg.flags;
    u32 r15 = (r2 >> 1) & 1;
    u32 r7 = (r2 >> 2) & 1;
    u32 r14 = r2 & 1;
    u32 r2c = (r2 >> 3) & 1;
    /* Поля — по ширине рис. 9-77 (9.3.4.2): Next Beacon B2..B5 (4), A-BFT Length B7..B9 (3), FSS B10..B13 (4), TXSS Span
     * B20..B26 (7), N BIs A-BFT B27..B30 (4), N A-BFT in Ant B37..B42 (6). исправлено (vendor): байты из LMAC 0x0b шли
     * без маски — значение шире поля заходило в соседние (TXSS Span 128 → N BIs A-BFT + 1), а из w0 б20..23 — в
     * Reserved B44..B47, из w1 б24.. — в код команды MAC 0x2b. */
    u32 r13 = bcn_bi.next_beacon & 0xfu;
    u32 r4 = bi_cfg.abft_len & 7u;
    u32 r8 = bi_cfg.fss & 0xfu;
    u32 r5 = bi_cfg.x9 & 0x7fu;
    u32 r6 = bi_cfg.n_bi_abft & 0xfu;
    u32 r9 = bi_cfg.abft_cnt_mod & 0x3fu;

    /* PCP Association Ready (flags б3) — только в w1 б23 = B43. исправлено (vendor): тот же флаг ставил и w0 б20 —
     * в эфире Reserved B44 = 1 (9.3.4.2, рис. 9-77: B44–B47 Reserved) */
    u32 w0 = (r7 << 19) | (r8 << 10) | (r4 << 7)
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
    /* IsResponderTXSS B14 (1 бит), Next A-BFT B15..B18 (4), A-BFT Count B31..B36 (6) — по ширине (рис. 9-77).
     * исправлено (vendor): без маски — при N BIs A-BFT = 0 счётчик abft_bi_left = 0xff уходил в Next A-BFT = 15,
     * Fragmented TXSS = 1 и Reserved B44..B46 = 1. */
    u32 r1 = (((u32)VOL(bcn_bi.x2) & 1u) << 14) | r2 | (((u32)VOL(bcn_bi.abft_bi_left) & 0xfu) << 15);
    u32 r13 = VOL(bcn_bi.abft_idx) & 0x3fu;
    uc_mac_cmd(bi_bcon_cfg_w0 | r1);                    /* ld_s [gp,120] */
    uc_mac_cmd(bi_bcon_cfg_w1 | (r13 << 11) | 0x2b000000);   /* ld_s [gp,124] */
}

void bi_ctx_clear_counters(struct pm_ctx_s *p)
{
    p->ps_active = 0;
    /* vendor здесь же: расписания PS, UPM включён по умолчанию (простой 30 мс) — энергосбережение
     * вырезано (см. fw/action.c psc_req_reject); все станции всегда бодрствуют. */
}


void bi_run_bti_cycle(struct bi_ctx_s *c)
{
    /* Инвариант: вне SLS в MAC — SIFS. исправлено (vendor: сравнение с литералом 0x300 = {0 тактов, 3 мкс}): любое
     * другое значение SIFS из настройки IFS (команда 0, txrx_api_program_ifs_timing) давало assert 0x59/0x60 через
     * ~0,4 с после старта — стенд 2026-11-21, опыт sadv (uCode assert 0x60 at bi_run_bti_cycle, точка и станция). */
    if (mac_ifs_shadow != ifs.sifs)
        uc_assert((u32)__builtin_return_address(0), 0x59);
    struct sls_peer_rec *r13 = &c->rec;
    if (bcn_rx.abft_here != 0) {
        if (c->fast_done != 0) {
            c->fast_done = 0;                   /* A-BFT станции пройден в abft_responder_fast, автомат BI — там же */
        } else {
            l1_task_dispatch(2, 0);
            bf_ctx_dispatch_by_role(r13);
        }
    }
    bi_bti_end_update_counters(c);
    bi_bti_end_reset_timers(r13);
    if (mac_ifs_shadow != ifs.sifs)
        uc_assert((u32)__builtin_return_address(0), 0x60);
    l1_task_dispatch(3, 0);
}

void bi_bti_end_update_counters(struct bi_ctx_s *c)
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
        MMIO32(HW_PRS_BSSID_HI) |= (1u << 31);
    }
    if (uc_read_bi_sync() != 0)
        rx_nav_arm_flag_if_enabled();
    memset0_words_uc(&bcn_rx, 0x1c);            /* до x1c */
}
void bi_timing_snapshot(void)
{
    bi_win.bi_len_us = bi_tsf_delta64(bi_win.bti_tsf[0], bi_win.bti_tsf[1]);
    mac_read_tsf64_uc(bi_win.bti_tsf);
    u32 r2 = mac_sel_shadow & ~MAC_SEL_FIELD;
    mac_sel_shadow = r2 | (1u << 14);
    uc_mac_cmd(r2 | MAC_CMD_STATUS_SEL | MAC_SEL_BI_COUNTER);
    arc_nops_nop(2);
    u32 r5 = mac_status_sel() & MAC_BI_COUNTER;      /* bmsk r5,r40,0x19 — биты 0..25 */
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
/* Окно бодрствования (Awake Window, BI_STATE_AW): обход пиров с отложенным трафиком (aw_collect_awake_peers).
 * исправлено (vendor/энергосбережение): vendor слал каждому пиру ATIM (mgmt 9, Duration 0x15 38 − ⌈TXTIME⌉ = 19, ждал
 * Ack) и по итогу помечал пира бодрствующим / без передачи (peer_masks_apply_op 1/2). ATIM в DMG BSS — только для
 * станций в PS, в Awake Window, объявленном элементом Awake Window (802.11-2020 11.2.7.1, 11.2.8 a/c); энергосбережение
 * вырезано (fw/action.c psc_req_reject), Awake Window никто не объявляет — ATIM не шлём (стенд 2026-11-04, PMC: ~6 ATIM
 * в секунду с каждого узла). Все пиры бодрствуют: пиры с трафиком — сразу бодрствующие с передачей (op 1), как после
 * успешного ATIM; обход окна закончен. */
void bi_rx_slot_handler(struct aw_win_s *w)
{
    mac_mon_report.aw_backoff += 1;
    u32 m = w->pend & 0xffffu;
    if (m != 0) {
        peer_masks_apply_op(&pm_ctx, 1, m);
        w->pend &= ~m;
    }
    mac_backoff_settle_set_chain_modes(2);
    uc_mac_cmd(0x81u << 18);
    internal_tx_clear_pending_bit(0);
}
