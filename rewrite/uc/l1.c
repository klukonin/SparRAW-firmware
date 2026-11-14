// SPDX-License-Identifier: AGPL-3.0-or-later
/* L1/L2 task-слой uCode. */
#include "../include/sta_max.h"
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/macq_desc.h"




u32 l1_task_rx_flow_run(void)
{
    return rx_flow_main();
}

u32 l1_task_rx_flow_thunk_b(void)
{
    return rx_flow_main();
}

void l1_task_mask_halt_req_and_defer(void)
{
    MMIO32(HW_FW2UC_IMS) = 2;
    arc_sync();
    bg_task_set_pending_bit(3);
}

void l1_task_mask_wake_req_and_defer(void)
{
    MMIO32(HW_FW2UC_IMS) = 4;
    arc_sync();
    bg_task_set_pending_bit(4);
}

void l1_task_dispatch_evt1(void)
{
    u32 r0 = dti_qset_mode;
    if (r0 == 0)
        l1_task_on_evt1();
    else if (r0 == 1 || r0 == 2)
        l1_task_on_evt1_fixed_sched();
}


void l2_task_entry(u32 a)
{
#ifdef UC_STAMP_MASK
    if ((UC_STAMP_MASK) & (1u << STAMP_L2_ENTRY)) {
        u32 ret;
        __asm__ volatile("mov %0, ilink2" : "=r"(ret));
        UC_STAMP(STAMP_L2_ENTRY, a, ret);
    }
#endif
    if (a == 0) { l2_task_report_error_bits(); return; }
    if (a == 1 || a == 2) { arc_core_wr(32, 0x21000009); return; }   /* vendor 0x92d026: без лога */
    if (a == 3) { l2_handle_watchdog(); }
}
void l2_task_kick_mac_events(void)
{
    /* 0x92cf60 */
    MMIO32(HW_MAC_HW_ICR_IMS) = 0x80;
    arc_sync();
    MMIO32(HW_MAC_SXD_MAC_HW_ICR) = 0x80;
    arc_sync();
    MMIO32(HW_MAC_HW_ICR_IMC) = 0x80;
    arc_sync();
}


/* ---- fixed_sched accessors ---- */

u32 fixed_sched_kick_slot_queue(struct fsched_peer_ctx *p)
{
    if (p->slot_kicked != 0)
        uc_assert((u32)__builtin_return_address(0), 0x158e);
    u32 qid = fsched_cur_entry_qid(p);
    u32 arg = fixed_sched_slot_mac_buff_size(p);
    macq_kick_queue_tx(qid, 0, arg);
    p->slot_kicked = 1;
    return 1;
}

u32 fixed_sched_slot_mac_buff_size(struct fsched_peer_ctx *p)
{
    return FWSH(fwsh_sets, fsched_tbl)->mcs[fsched_cur_entry_cfg_idx(p)].mac_buff_size;
}
u16 fixed_sched_slot_stop_vring_us(struct fsched_peer_ctx *p)
{
    /* 0x927d94 */
    return FWSH(fwsh_sets, fsched_tbl)->mcs[fsched_cur_entry_cfg_idx(p)].stop_vring_us;
}

/* Завершить отложенное снятие пира (peer_masks_update_sta_bit): снять бит, событие 0x2e. */
u32 fixed_sched_complete_peer_off(struct fsched_peer_ctx *p)
{
    u8 id = p->pend_off_qid;
    if (id == 0xff)
        return id;
    p->active_mask &= ~(1u << (p->pend_off_idx & 0x1f));
    u32 desc = qh_read_desc_start(id);
    uc_evt_send_vring_ssn(id, 0, desc);
    p->pend_off_qid = 0xff;
    return id;
}

void fixed_sched_manager_decrement_curr_sta_rd_counter(struct fsched_peer_ctx *p)
{
    /* 6.2 asm 0x92574c: ноль — лог вместо декремента. */
    struct fsched_peer_ent *e = &p->ent[p->cur_idx];
    if ((s32)e->rd_counter >= 1)
        e->rd_counter -= 1;
    else
        uc_log_emit_snapshot(0x10, 0x1000738);
}

/* ---- L1 task-слой ---- */
void l1_task_check_bf_req_timeout(void)
{
    u32 r0 = bf_req.head % BF_REQ_FIFO_N;
    u8 r13 = bf_req.fifo[r0];
    if (bf_sta[r13].state != 0x12)
        return;
    u32 tsf = uc_read_tsf_lo();
    u32 delta = tsf - bf_rep.start_tsf;
    bf_rep.elapsed_us = delta;
    u32 saved = bf_tmo_tick;
    if (delta > 0x3e8) {
        bf_tmo_tick = 0;
        bf_tmo_tick_last = saved;
        if (bf_failure_policy == 1 && lmac_personality != 1)
            bf_sm_set_sta_state(r13, 0x2);
        else
            bf_sm_set_sta_state(r13, 0x11);
        bf_sm_schedule(r13);
    }
    bf_tmo_tick += 1;
}

void l1_snapshot_bi_counter(void)
{
    mac_read_tsf64_uc(bi_win.aw_tsf);
    u64 delta = bi_tsf_delta64(bi_win.bti_tsf[0], bi_win.bti_tsf[1]);
    u8 idx = mac_mon_slot_idx;
    mac_mon_slot[idx].bti_duration = (u32)delta;
    u32 r4 = mac_sel_shadow & ~MAC_SEL_FIELD;
    mac_sel_shadow = r4 | (1u << 14);
    uc_mac_cmd(r4 | MAC_CMD_STATUS_SEL | MAC_SEL_BI_COUNTER);
    arc_nops(3);
    bi_pos_snap = mac_status_sel() & MAC_BI_COUNTER;
}
void l1_task_kick_and_dispatch_uc(void)
{
    /* 0x927378: разобрать кольцо команд, затем пнуть MAC. */
    MMIO32(HW_FW2UC_IMS) = 1;
    arc_sync();
    MMIO32(HW_FW2UC_ICR) = 1;
    arc_sync();
    while (uc_cmd_ring_pending(&uc_mbox) != 0)
        uc_queue_dispatch_and_commit(&uc_mbox);
    MMIO32(HW_FW2UC_IMC) = 1;
    arc_sync();
}

u32 l1_rx_then_check_bf_abort(void)
{
    u32 r14 = rx_flow_main();
    if (r14 == 1) {
        u32 r0 = rxf.sta;
        if (bf_abort_unexpected(r0, 0xa) != 0) {
            r0 = rxf.sta;
            bf_store_flow_status(r0, 0);
            bf_sm_run_sta(r0);
        }
    }
    return r14;
}

void l1_enter_fixed_sched(u32 a)
{
    l1_fsched_flag = 0;
    mac_set_slot_mask_924000();
    rx_nav_clear_flags();
    dti_qset_mode = (uc_role_ap == 0) ? 2 : 1;
    u32 e30[2] = {0, 0};
    uc_evt_send_fixed_sched_enabled(e30);
    if (uc_role_ap == 0) {
        rx_mode_configure(2, a);
        mac_read_tsf64_uc(fsched_peers.rx_tsf);
    }
}
void l1_task_on_evt4(void)
{
    /* 0x92cd20: r54 перечитывается перед каждой проверкой. */
    if (mac_evt4() & MAC_EVT4_EXT_GP012_END) {
        uc_mac_cmd(0x49008000);
        l1_task_dispatch(4, 0);
    } else if (mac_evt4() & MAC_EVT4_SP0) {
        uc_mac_cmd(0x49000010);
        dti_alloc_dispatch(&bi_ctx);
    } else if (mac_evt4() & MAC_EVT4_EXT_GP6789_END) {
        uc_mac_cmd(0x49020000);                 /* таймер простоя UPM: PS вырезан, не взводится */
    } else {
        uc_assert((u32)__builtin_return_address(0), 0x2c);
    }
}
void l1_fixed_sched_event_entry(void)
{
    /* 0x92cd94 */
    if (mac_evt4() & MAC_EVT4_EXT_GP012_END) {
        uc_mac_cmd(0x49008000);
        if (dti_qset_mode == 1)
            l1_fixed_sched_ap_sm(4);
        else
            l1_fixed_sched_sta_sm(4);
    } else if (mac_evt4() & MAC_EVT4_EXT_GP6789_END) {
        uc_mac_cmd(0x49020000);
    }
}
void l1_task_reset_units(void)
{
    /* 0x92ec50 */
    gp_timer_stop(0);
    gp_timer_stop(1);
    gp_timer_stop(2);
    uc_mac_cmd(0x54000000);
    uc_mac_cmd(0x54000000);
    uc_mac_cmd(0x49000100);
    uc_mac_cmd(0x51000284);
    uc_mac_cmd(0x54000508);
}
void l1_task_sel_nbr_update(void)
{
    /* 0x930d44: байты 0x8014e8.. (ldb — беззнаковые, кроме ldb.x [21]); max/min — знаковые. */
    if (sel_nbr.min_sta == 0xff)
        return;
    if (sel_nbr.holdoff != 0) {
        sel_nbr.holdoff -= 1;
    } else {
        u32 r3 = sel_nbr.min_gain_db;
        s32 d = (s32)r3 - (s32)sel_nbr.threshold;
        if (d < 0)
            d = 0;
        u32 r1 = (u8)d;
        sel_nbr.margin = (u8)d;
        u32 r0b = calib_gain_ofs;
        u32 r13 = (u8)(r0b + r1);
        if ((s32)(r0b + 3) >= (s32)r13)
            r13 = sel_nbr.fallback;
        sel_nbr.last_min_gain = (u8)r3;
        sel_nbr.result = (u8)(((s32)sel_nbr.cap < (s32)r13) ? sel_nbr.cap : r13);
        sel_nbr.updated = 1;
        s32 v = (s32)r1 + (s32)sel_nbr.offset;
        s32 m = sel_nbr.out_floor;
        sel_nbr.out = (u8)((m > v) ? m : v);
    }
    sel_nbr.min_gain_db = 0x7f;
    sel_nbr.min_sta = 0xff;
}


void l1_task_report_link_lost(void)
{
    (link_lost_cnt)++;
    l1_task_dispatch(1, 0);
    uc_pm_enter_idle(1);
    u32 r0 = uc_read_tsf_lo();
    rx_on_state = 0;
    rx_on_tsf = r0;
    uc_set_bg_task_mask(1);

    u8 r3 = maint_sta_mask;
    u32 buf[3];
    buf[2] = 1;                                 /* st r13(=1),[sp,8] в delay-слоте */
    buf[0] = (r3 == 0) ? SPARRAW_PEER_UNKNOWN : (30 - arc_norm(r3));
    buf[1] = agc_cfg.agc_start;
    uc_send_evt_link_lost(buf);
}

/* Начало BI: смена слота MAC_MON (публикуется неактивный — прошлого BI) и снимок TSF/счётчика BI в слот. Ровно один
 * раз за BI: по bi1_event (случай 0) или, если BTI начался раньше разбора bi1_event, по маяку из rx_flow (случай 5). */
static void l1_bi_start(void)
{
    mac_mon_slot_idx = (mac_mon_slot_idx == 0) ? 1 : 0;
    bi_timing_snapshot();
}

/* Диспетчер L1-таска (0x934e30) — портировано. */
void l1_task_dispatch(u32 a, u32 b)
{
    /* 0x934e30: таблица 0x801ac0 — 0:e4c 1:e80 2:ea0 3:eb8 4:f08 5:f14 6:ea8. */
    switch (a) {
    case 0:
        if (bi_ctx.bi_start_rx == 0)
            l1_bi_start();
        uc_sm_handle_event(&bi_sm, 0, b);
        return;
    case 1: {
        u32 r = uc_sm_handle_event(&bi_sm, 2, 0);
        peer_slots_scan_by_masks(r);
        l1_task_reset_units();
        return;
    }
    case 2:
        uc_sm_handle_event(&bi_sm, 1, 0);
        return;
    case 3:
        peer_slots_scan_by_masks(a);
        l1_snapshot_bi_counter();
        if (l1_fsched_flag != 0 && g_800494 == 0 && bi_cfg.bi_mode != 2) {
            uc_sm_handle_event(&bi_sm, 3, 0);
        } else {
            mac_compute_bi_mon_timings();
            uc_sm_handle_event(&bi_sm, 2, 0);
        }
        return;
    case 4:
        mac_compute_bi_mon_timings();
        uc_sm_handle_event(&bi_sm, 4, 0);
        return;
    case 5:
        if (b == 0) {
            /* исправлено: rx_flow DTI принял маяк своей BSS (BTI уже идёт, bi1_event не разобран) — автомат BI
             * переходит в BTI отсюда, минуя случай 0. vendor здесь не менял слот MAC_MON: под нагрузкой (приём DTI
             * накрывает TBTT) так проходит каждый BI, маяки копятся в одном слоте, fw получает опубликованный
             * пустой (detected = 0) и через bcn_thr BI рвёт связь «lost link: no beacons» (стенд 2026-11-13, AP .12 /
             * STA .11: ~55 BI подряд без смены слота перед разрывом, в каждом BTI маяк принят). */
            if (bi_ctx.bi_start_rx == 0) {
                l1_bi_start();
                bi_ctx.bi_start_rx = 1;
            }
            uc_sm_handle_event(&bi_sm, 0, 1);
        }
        return;
    case 6:
        peer_slots_scan_by_masks(a);
        l1_task_reset_units();
        uc_sm_handle_event(&bi_sm, 2, 0);
        return;
    default:
        uc_assert((u32)__builtin_return_address(0), 92);
        return;
    }
}

/* Точка входа L1-таска (0x92c974).
 * СРОК (задержка L1): режим 0 (вектор 8) разбирает всё кольцо команд fw внутри прерывания уровня 1 —
 * bi1_event (вектор 9) и GP-события r54 того же уровня ждут конца разбора; длина ограничена только
 * числом команд в кольце (vendor — так же). Добавляется к пути TBTT → маяк (l1_task_on_evt1). */
#ifdef UC_STAMP_MASK
/* Метка длинных задач L1 (UC_STAMP STAMP_LONG_TASK, a0 = 0x100 | mode): обёртка поверх тела. */
void l1_task_entry_impl(u32 mode);
void l1_task_entry(u32 mode)
{
    u32 c0 = ((UC_STAMP_MASK) & (1u << STAMP_IRQ_LAT)) && mode == 3 ? arc_lr(0x21) : 0;   /* COUNT0 на входе тика */
    u32 t0 = arc_lr(0x100);
    l1_task_entry_impl(mode);
    if (mode == 3)
        UC_STAMP(STAMP_IRQ_LAT, c0, arc_lr(0x21));     /* и на выходе: длительность тика */
    u32 d = arc_lr(0x100) - t0;
    if (mode != 1 && d > STAMP_LONG_CLK && d < 0x1000000u)      /* приём (режим 1) — сам путь ответа, не помеха */
        UC_STAMP(STAMP_LONG_TASK, 0x100u | mode, d);
}
#define l1_task_entry l1_task_entry_impl
#endif
/* Приём раньше тика L1. исправлено (vendor: тик таймера 0 — вектор 3, тот же уровень L1, что busy_event — вектор 9,
 * — исполняется целиком, ~330 тактов, и начало PPDU ждёт его конца). ХРУПКО: ответ через SIFS (802.11-2020
 * 10.3.2.11 Ack, 10.25.3 BlockAck, 10.3.2.9 DMG CTS) на короткий кадр SC (3,4 мкс у ADDBA Response на MCS 1) — срок
 * от его конца, а путь uc от прерывания до проверки счётчиков PPDU в rx_flow_run ~460 тактов (эмулятор): тик, начатый
 * перед кадром, сдвигает вход так, что кадр кончается раньше проверки, и ответ уже не укладывается в срок
 * (SIFS_CNT_RX_LATE_END_SC, ifs.h). Поэтому между шагами тика (и сразу после перевзвода таймеров) — проверка
 * busy_event (r42 б19): начался приём — сначала обработчик событий L1 (тот же, что вызвал бы вектор 9 сразу после
 * тика: l1_task_dispatch_evt1), затем оставшиеся шаги тика — каждый ровно один раз за тик, порядок шагов прежний,
 * всё на уровне L1 (как у vendor, без вложенных прерываний). Задержка начала приёма тиком — не больше самого длинного
 * шага (rx_nav_check_idle, ~90 тактов) вместо всего тика. Проверка — чтение r42, 3–4 инструкции.
 * Только при включённом приёме и не остановленном MAC — предусловия l1_task_on_evt1 (uc_assert 0x27 / 0x1314): busy_event
 * (r42 б19) бывает взведён и при RX OFF (стенд 2026-11-10: загрузка, до LMAC 0x01 — uc_assert 0x27 из тика на обоих узлах),
 * а вектор 9 тогда не срабатывает (open без этой проверки грузится); при RX OFF ответа через SIFS нет — тик как прежде.
 * Проверки состояния — в отдельной функции: в теле тика только чтение r42 (без busy тик не меняется). */
static __attribute__((noinline)) void l1_tick_rx_dispatch(void)
{
    if (rx_on_state != 0 && mac_mode_sw.halted == 0)
        l1_task_dispatch_evt1();
}
static inline __attribute__((always_inline)) void l1_tick_rx_first(void)
{
    if (mac_evt1() & MAC_EVT1_BUSY)
        l1_tick_rx_dispatch();
}
void l1_task_entry(u32 mode)
{
    if (mode == 1 || mode == 2)
        UC_STAMP(STAMP_L1_EVT, mode << 24 | (mac_evt1() & 0xffffff), mac_evt4());
#ifdef UC_STAMP_MASK
    if (((UC_STAMP_MASK) & (1u << STAMP_BI1_LEAD)) && mode == 1 && (mac_evt1() & MAC_EVT1_BI1))
        UC_STAMP(STAMP_BI1_LEAD, MMIO32(HW_MAC_USEC_TO_TBTT), MMIO32(HW_MAC_TSF_LO));
#endif
    if (mode == 0) {
        uc_mac_cmd(0xcafcaf);
        u32 r13 = MMIO32(HW_FW2UC_ICM);
        uc_mac_cmd(r13 | 0xf000);
        do {                                    /* 0x92ca8e: do-while — при 0 сработает assert */
            if (r13 & 1u) {
                r13 &= ~1u;
                l1_task_kick_and_dispatch_uc();
            } else if (r13 & 2u) {
                r13 &= ~2u;
                l1_task_mask_halt_req_and_defer();
            } else if (r13 & 4u) {
                r13 &= ~4u;
                l1_task_mask_wake_req_and_defer();
            } else {
                uc_assert((u32)__builtin_return_address(0), 0x1315);
            }
        } while (r13 != 0);
        return;
    }
    if (mode == 1) {
        l1_task_dispatch_evt1();
        return;
    }
    if (mode == 2) {
        l1_task_dispatch_evt4();
        return;
    }
    if (mode != 3)                              /* cmp_s r0,3; bne_s L_92cacc — выход */
        return;
    if (mac_mode_sw.halted != 0)
        uc_assert((u32)__builtin_return_address(0), 0x1313);
    arc_sr(uc_timer[0].xc, uc_timer[0].ctrl);   /* sr r3,[r0] */
    arc_sr(0, uc_timer[1].count);               /* sr 0,[r0] */
    l1_tick_rx_first();
    u32 *r13 = &busy_acct.sig_start_tsf;
    if (*r13 != 0) {
        mac_mon_report.busy_time = mac_mon_report.busy_time + 0xa;
        *r13 = 0;
    }
    if (phy_signal_gain_adc_in_range() == 1)
        *r13 = uc_read_tsf_lo();
    l1_tick_rx_first();
    l1_task_check_bf_req_timeout();
    l1_tick_rx_first();
    power_manager_tick_if_elapsed();
    l1_tick_rx_first();
    rx_nav_check_idle(0, 0, 1);
    l1_tick_rx_first();
    l1_task_sel_nbr_update();
    if (*r13 == 0 && phy_signal_gain_adc_in_range() == 1)
        *r13 = uc_read_tsf_lo();
    if (rx_on_state != 0 && dti_qset_mode == 2 &&
        !(rx_mode_flags & 1u) && maint_sta_mask != 0) {
        u64 d = bi_tsf_delta64(fsched_peers.rx_tsf[0], fsched_peers.rx_tsf[1]);
        if (l1_time_thresh < (u32)d) {
            u32 n;
            n = arc_norm((u32)maint_sta_mask);
            u32 idx = 0x1e - n;
            volatile struct link_stat_s *r0 = &link_stat[idx];
            if (r0->bf_reasons == 0) {
                r0->bf_reasons |= 0x4;
                rx_mode_configure(2, idx);      /* r1 = индекс станции */
            }
        }
    }
}
#ifdef UC_STAMP_MASK
#undef l1_task_entry
#endif

/* Главный шаг L1 (0x92caf4) — портировано.
 * СРОК: путь TBTT → маяк. bi1_event (MAC_EVT1_BI1) — пробуждение до TBTT (упреждение по перезарядке 0x886d18
 * ≈ 8 мкс — гипотеза, HARDWARE-BLOCKS.md); BTI начинается в TBTT (802.11-2020 10.39.2). От bi1_event до
 * ожидания slot_event (uc_wait_event_busy(MAC_EVT1_SLOT | MAC_EVT1_BUSY2) в bti_ap_beacon_sweep_tx):
 * 3 трассировочные команды здесь, l1_task_dispatch(0) → bi_timing_snapshot (2× TSF64) → автомат BI →
 * bti_prepare_sweep_set (aw_set_new_tbtt) → развёртка (tx_ctx_alloc_next, bti_measure_frame_duration
 * с тремя спинами MTP r43/r45/r47, bi_ctrl_program_mac_bcon) ~600 инструкций + задержки MTP (vendor
 * ~ так же; aw_set_new_tbtt у нас короче — PS вырезан); запас: не установлен (единицы мкс, если
 * упреждение 8 мкс). busy_event (MAC_EVT1_BUSY) проверяется раньше bi1_event: rx_flow в той же итерации
 * откладывает TBTT. Срыв — маяк позже TBTT (сдвиг BTI и A-BFT), при busy2 — маяк в этом BI пропущен. */
#ifdef UC_STAMP_MASK
/* Метка STAMP_CCA_DET: когда после busy_event поднимаются phy_rx_frame (PHY_SIGNALS б3), sfd_sync (r42 б11) и
 * rx_frame_event (r42 б12, заголовок разобран — 9,06 мкс от начала кадра, H-HDR). Опрос держит L1 до заголовка —
 * только в сборке с меткой, примерно каждый 8-й вход (по младшим битам Timer1: у uc нет .bss). */
static void l1_stamp_cca_det(void)
{
    u32 t0 = arc_lr(0x100), sel = mac_sel_shadow;
    u32 g = sel & ~MAC_SEL_FIELD, t_cca = 0x1fff, t_comp = 0xffff, t_sfd = 0xffff, t_hdr = 0xffff, f = 0, d = 0, v;
    uc_mac_cmd(g | MAC_CMD_STATUS_SEL | MAC_SEL_PHY_SIGNALS);
    arc_nops(3);
    v = mac_status_sel();
    if (!(v & MAC_PHYSIG_CCA_PPDU_COMP))
        f |= 1u << 31, t_comp = 0;
    if (v & MAC_PHYSIG_CCA)
        t_cca = 0;
    if (mac_evt1() & MAC_EVT1_SFD_SYNC)
        f |= 1u << 30, t_sfd = 0;
    if (mac_evt1() & MAC_EVT1_RX_FRAME)
        f |= 1u << 29, t_hdr = 0;
    while (t_hdr == 0xffff && d < 2500) {
        d = arc_lr(0x100) - t0;
        v = mac_status_sel();
        if (t_comp == 0xffff && !(v & MAC_PHYSIG_CCA_PPDU_COMP))
            t_comp = d;
        if (t_cca == 0x1fff && (v & MAC_PHYSIG_CCA))
            t_cca = d;
        if (t_sfd == 0xffff && (mac_evt1() & MAC_EVT1_SFD_SYNC))
            t_sfd = d;
        if (mac_evt1() & MAC_EVT1_RX_FRAME)
            t_hdr = d;
    }
    uc_mac_cmd(sel | MAC_CMD_STATUS_SEL);
    arc_nops(3);
    UC_STAMP(STAMP_CCA_DET, f | t_cca << 16 | t_hdr, t_comp << 16 | t_sfd);
}
#endif

void l1_task_on_evt1(void)
{
    /* 6.2 asm 0x92caf4. */
    uc_mac_cmd(0xcafcaa);
    uc_mac_cmd(mac_evt1() & MAC_EVT1_ALL);
    uc_mac_cmd(arc_lr(uc_timer[1].count) & 0xffffff);
    if (mac_mode_sw.halted != 0)
        uc_assert((u32)__builtin_return_address(0), 0x1314);
    if (rx_on_state == 0)
        uc_assert((u32)__builtin_return_address(0), 0x27);
    for (;;) {
        if (mac_evt1() & MAC_EVT1_BUSY) {            /* r42 перечитывается на каждой проверке */
            u32 tsf = uc_read_tsf_lo();
            busy_acct.busy_start_tsf = tsf;
            if (busy_acct.sig_start_tsf != 0) {
                if (tsf - busy_acct.sig_start_tsf >= 0xa)
                    mac_mon_report.busy_time += 0xa;
                busy_acct.sig_start_tsf = 0;
            }
            if (rx_listen_active != 1)
                uc_assert((u32)__builtin_return_address(0), 0x28);
#ifdef UC_STAMP_MASK
            if (((UC_STAMP_MASK) & (1u << STAMP_CCA_DET)) && (arc_lr(0x100) & 0x70) == 0)
                l1_stamp_cca_det();
#endif
            l1_task_run_bi_phase(&bi_ctx);
        } else if (mac_evt1() & MAC_EVT1_BI1) {
            if (fsched_enabled != 0) {
                if (uc_role_ap == 1) {
                    l1_enter_fixed_sched(0);
                    return;
                }
                if (maint_sta_mask != 0) {
                    u32 idx = 30 - arc_norm(maint_sta_mask);
                    if (sta_tab[idx].qid_mask_q6 != 0) {
                        l1_enter_fixed_sched(idx);      /* r0 = индекс станции */
                        return;
                    }
                }
            }
            bi_win.tbtt_cnt += 1;
            l1_task_dispatch(0, 0);
        } else if (mac_evt1() & MAC_EVT1_BACKOFF) {
            UC_STAMP(STAMP_BACKOFF, uc_read_tsf_lo() - MMIO32(HW_MAC_BI_START_TSF_LO), mac_tx_qid_en_shadow);
            if (busy_acct.sig_start_tsf != 0) {
                mac_mon_report.busy_time += 0xa;
                busy_acct.sig_start_tsf = 0;
            }
            bi_dispatch_by_role(&bi_ctx);
        }
        mac_trace_ptr_snap = uc_trace_ptr();      /* st.as r25,[gp,12] */
        if (l2_wd_fired != 0) {
            l2_wd_fired = 0;
            l1_task_report_link_lost();
        }
        if (!(mac_evt1() & (MAC_EVT1_BI1 | MAC_EVT1_BACKOFF | MAC_EVT1_BUSY)))
            return;
    }
}

/* 6.2 asm 0x92cc48: шаг L1 в режимах 1/2 (отдельная функция внутри блока
 * l1_task__main_step; вход из l1_task_dispatch_evt1). Событие -> фаза SM fixed-sched. */
void l1_task_on_evt1_fixed_sched(void)
{
    do {
        u32 phase = 0;
        if (mac_evt1() & MAC_EVT1_BUSY) {          /* vendor перечитывает r42 на каждой проверке */
            u32 tsf = uc_read_tsf_lo();
            busy_acct.busy_start_tsf = tsf;
            if (busy_acct.sig_start_tsf != 0) {
                if (tsf - busy_acct.sig_start_tsf >= 0xa)
                    mac_mon_report.busy_time += 0xa;
                busy_acct.sig_start_tsf = 0;
            }
            phase = 2;
        } else if (mac_evt1() & MAC_EVT1_BI1) {
            bi_win.tbtt_cnt += 1;
            uc_log_emit1(0x20, 0x10006dc, uc_read_tsf_lo());
            l1_task_dispatch(0, 0);
            phase = 1;
        } else if (mac_evt1() & MAC_EVT1_BACKOFF) {
            if (busy_acct.sig_start_tsf != 0) {
                mac_mon_report.busy_time += 0xa;
                busy_acct.sig_start_tsf = 0;
            }
            phase = 6;
        }
        if (l2_wd_fired != 0) {
            phase = 0;
            l2_wd_fired = 0;
            l1_task_report_link_lost();
        }
        if (phase != 0) {
            if (dti_qset_mode == 1)
                l1_fixed_sched_ap_sm(phase);
            else
                l1_fixed_sched_sta_sm(phase);
        }
    } while (mac_evt1() & (MAC_EVT1_BI1 | MAC_EVT1_BACKOFF | MAC_EVT1_BUSY));
}

/* Отчёт об ошибках L2 (0x92cdd8) — портировано. */
void l2_task_report_error_bits(void)
{
    u32 r0 = txrx_state2;
    static const u16 codes[30] = {
        [0] = 0x6000, [1] = 0x6001, [2] = 0x6002, [3] = 0x6003,
        [5] = 0x6005, [7] = 0x6007, [9] = 0x6009, [10] = 0x6010,
        [11] = 0x6011, [13] = 0x6013, [14] = 0x6014, [15] = 0x6015,
        [16] = 0x6016, [17] = 0x6017, [18] = 0x6018, [19] = 0x6019,
        [20] = 0x6020, [21] = 0x6021, [22] = 0x6022, [23] = 0x6023,
        [26] = 0x6026, [27] = 0x6027, [28] = 0x6028, [29] = 0x6029,
    };
    for (u32 i = 0; i < 30; i++) {
        if (codes[i] && (r0 & (1u << i))) {
            uc_assert((u32)__builtin_return_address(0), codes[i]);
            return;
        }
    }
    uc_assert((u32)__builtin_return_address(0), 0x26);   /* 0x92cf56: нет бита — код 0x26 */
}

void macq_flush_queue(u32 a, u32 b, u32 c)  /* 6.2 asm 0x925b7c */
{
    macq_hw_sync_dma_wptr(a, b, c);
    volatile u32 *q = (volatile u32 *)HW_TXQ_REGS;
    u32 bit = 1u << c;
    u32 r3 = q[7] & ~bit;                   /* чтение 0x886a1c до записей (как vendor) */
    q[6] = bit;                             /* 0x886a18 */
    q[7] = r3;                              /* 0x886a1c */
    q[8] = 1;                               /* 0x886a20 */
    arc_sync();
    u32 wptr = macq_hw_read_wptr(b);
    for (;;) {
        uc_mac_cmd(0xaaad00);
        uc_mac_cmd(arc_lr(uc_timer[1].count) & 0xffffff);
        if (dmaq_hw_read_ptr(a) != wptr)
            continue;
        if (macq_read_hw_queue_word(a) != macq_hw_read_rptr(b))
            continue;
        break;
    }
    arc_sync();
    macq_hw_clear_2d8(b);
    arc_sync();
}

u32 macq_is_idle(u32 a)                     /* 6.2 asm 0x92609c */
{
    u32 g = mac_sel_shadow & 0xfffff0ff;
    mac_sel_shadow = g | (1u << 8) | (1u << 9) | (1u << 11);
    uc_mac_cmd(g | 0x1d000b00);
    arc_nops(3);
    vring_dbg.macq_busy_a = mac_queue_sel();
    g = mac_sel_shadow & 0xfffff0ff;
    mac_sel_shadow = g | (1u << 10) | (1u << 11);
    uc_mac_cmd(g | 0x1d000c00);
    arc_nops(3);
    vring_dbg.macq_busy_b = mac_queue_sel();
    u32 bit = 1u << a;
    if ((bit & vring_dbg.macq_busy_a) || (bit & vring_dbg.macq_busy_b))
        return 0;
    u32 sp[4];
    qh_read_desc_window((u32)sp, a, 2, 0, 1);
    const struct macq_desc *d = (const struct macq_desc *)sp;   /* окно очереди */
    u32 computed = ((d->w3 & 0xf) << 8) | d->param_a_lo;
    u32 masked = (d->w2 >> 12) & 0xfff;
    u32 m1 = (computed == masked) ? 1 : 0;
    u32 m2 = (d->rd == d->wr) ? 1 : 0;
    return (m1 && m2) ? 1 : 0;
}
void macq_disable_queue_and_ack_irq(u32 a, u32 b)   /* 6.2 asm 0x9262a0 */
{
    (void)a;
    dma_fw_icr_c24_write(1u << (b + 8));
    macq_hw_disable_queue(b);
}

void fixed_sched_slot_prepare(u32 a)
{
    macq_flush_queue(a, 0, a);
    if (macq_is_idle(a) != 0)
        return;
    dump_mac_buffer_bases(a, a);
    uc_assert((u32)__builtin_return_address(0), 0x157b);
}

void fixed_sched_slot_setup(struct fsched_peer_ctx *p)
{
    u32 qid = fsched_cur_entry_qid(p);
    macq_disable_queue_and_ack_irq(qid, 0);          /* vendor: r0 = qid, не используется */
    p->slot_kicked = 0;
}

/* 0x92b648: возвращаемое значение (r0 после l1_task_dispatch) вызывающий не использует. */
void l1_task_run_bi_phase(struct bi_ctx_s *c)
{
    u32 r = c->phase;
    u32 v;
    if (r == 0)
        v = l1_task_rx_flow_run();
    else if (r == 1)
        v = l1_rx_then_check_bf_abort();
    else if (r == 2)
        v = l1_task_rx_flow_thunk_b();
    else {
        uc_assert((u32)__builtin_return_address(0), 0x65);
        v = 0;
    }
    l1_task_dispatch(5, v);
}

/* Запуск TX-слота fixed-sched (0x93768c) — портировано. */
void fixed_sched_run_tx_slot(void)
{
    /* 6.2 asm 0x93768c. */
    mac_mon_report.dti_backoff = mac_mon_report.dti_backoff + 1;
    if (rx_listen_active != 1) {
        mac_set_chain_modes(2);
        uc_mac_cmd(0x81 << 18);
        uc_tx_is_idle();
        fsched_slot_skip_cnt = fsched_slot_skip_cnt + 1;
        return;
    }
    uc_stats.fsched_tx_slot = uc_stats.fsched_tx_slot + 1;
    tx_resp_sent = 0;
    tx_rx_flow_ran = 0;
    rx_cts_rf_restore = 0;
    uc_mac_cmd(0x14000100);
    if (dti_qset_mode == 0)
        tx_slot_dispatch(0);
    else
        tx_initiator_flow_fixed_scheduling(dti_qset_mode);
    /* своё SP: обмен без CF-End, план TXOP MAC кончается сам внутри SP — не ждать (uc/ese_dti.c ese_dti_sp_src_end) */
    if (tx_resp_sent != 0 && FWSH(fwsh_sp_gate, init_sp) == 0) {
        uc_wait_txop_end();                     /* исправлено (vendor): без срока — см. uc_wait_txop_end (mac.c) */
        if (rx_resp_wait_en == 1 && fsched_rx_resp_seen == 0)
            uc_mac_cmd(0x1f000601);
    }
    fsched_rx_resp_seen = 0;
    if (tx_rx_flow_ran != 0) {
        u32 r1 = tx_ctx_pool.cur->sta;
        if (r1 < 8)
            aw_tx_peer_mask |= 1u << r1;
    }
    if (!(txrx_state2 & (1u << 9)))
        uc_mac_cmd(0x14000100);
    uc_mac_cmd(*(u16 *)&txrx_state1 | 0xdb0000);
    uc_mac_cmd((txrx_state1 >> 16) | 0xdb0000);
    uc_mac_cmd(*(u16 *)&txrx_state2 | 0xdb0000);
    uc_mac_cmd((txrx_state2 >> 16) | 0xdb0000);
    uc_mac_cmd(0x81 << 18);
    mac_wait_mode_ack_if_idle();
    if (txr.awaiting == 0 && !(rx_mode_flags & 1u))
        rx_mode_configure(2, rxf.sta);
    txr.awaiting = 0;
    tx_ctx_pool.slot[0].flags = 0;
    tx_ctx_pool.slot[1].flags = 0;
    txrx_state1 = 0;
    txrx_state2 = 0;
    if (tx_busy_start_tsf != 0) {
        mac_mon_report.rx_listen_time = uc_read_tsf_lo() - tx_busy_start_tsf + mac_mon_report.rx_listen_time;
        tx_busy_start_tsf = 0;
    }
}
