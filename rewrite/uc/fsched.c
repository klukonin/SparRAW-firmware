// SPDX-License-Identifier: AGPL-3.0-or-later
/* Frame-планировщик uCode (fsched). */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "ifs.h"
#include "../include/sta_max.h"



u8 fsched_get_cur_idx(struct fsched_peer_ctx *p)
{
    return p->cur_idx;
}

/* qid пира текущего слота. */
u8 fsched_cur_entry_qid(struct fsched_peer_ctx *p)
{
    return p->ent[p->cur_idx].qid;
}

/* Индекс записи конфигурации слота текущего пира. */
u8 fsched_cur_entry_cfg_idx(struct fsched_peer_ctx *p)
{
    return p->ent[p->cur_idx].cfg_idx;
}

void fsched_slot_clear_rd_counter(struct fsched_peer_ctx *p)
{
    p->ent[p->cur_idx].rd_counter = 0;
}

void fsched_slot_clear_miss_cnt(struct fsched_peer_ctx *p)
{
    p->ent[p->cur_idx].miss_cnt = 0;
}

void fsched_slot_clear_slot_cnt(struct fsched_peer_ctx *p)
{
    p->ent[p->cur_idx].slot_cnt = 0;
}

void fsched_slot_inc_slot_cnt(struct fsched_peer_ctx *p)
{
    p->ent[p->cur_idx].slot_cnt += 1;
}
u32 fsched_slot_rd_counter_nonzero(struct fsched_peer_ctx *p)
{
    /* 0x92be0c: ldb (беззнаковый) > 0. */
    return p->ent[p->cur_idx].rd_counter != 0;
}

u8 fsched_slot_time_before_tx_us(struct fsched_peer_ctx *p)
{
    return FWSH(fwsh_sets, fsched_tbl)->mcs[fsched_cur_entry_cfg_idx(p)].time_before_tx_us;
}
u32 fixed_sched_is_engaged(void)
{
    /* 0x92bda4 */
    if (fsched_ctx.state == 4)
        return 1;
    return fsched_ctx.engaged != 0;
}

u32 fsched_bf_req_mask_bit(struct fsched_peer_ctx *p, u32 bit)
{
    return (p->bf_req_mask & (1u << bit)) != 0;
}

u16 fsched_slot_flush_to_us(struct fsched_peer_ctx *p)
{
    return FWSH(fwsh_sets, fsched_tbl)->mcs[fsched_cur_entry_cfg_idx(p)].flush_to_us;
}

u32 fsched_slot_inc_miss_cnt_reached_7(struct fsched_peer_ctx *p)
{
    struct fsched_peer_ent *e = &p->ent[p->cur_idx];
    u8 v = e->miss_cnt + 1;
    e->miss_cnt = v;
    return (v < 7) ? 0 : 1;
}

void fsched_ap_init_slot_rd_counter(struct fsched_peer_ctx *p)
{
    /* 6.2 asm 0x92ec28: начальный счётчик RD пира — из записи конфигурации. */
    u8 rd = FWSH(fwsh_sets, fsched_tbl)->mcs[fsched_cur_entry_cfg_idx(p)].rd_count;
    p->ent[p->cur_idx].rd_counter = rd;
}
u32 fsched_ap_station_done(struct fsched_peer_ctx *p)
{
    /* 0x92bddc: текущей станции нет в active_mask — готово; иначе сравнить счётчик слотов с пределом. */
    u32 i = p->cur_idx;
    if (!(p->active_mask & (1u << (i & 31))))
        return 1;
    return (p->ent[i].slot_cnt < FWSH(fwsh_sets, fsched_tbl)->ap_slots_initiate_grant) ? 0 : 1;
}
void fsched_drop_station(u32 bit)
{
    /* 0x92ed00 */
    u32 m = ~(1u << (bit & 31));
    FWSH(ll_ctx, fsched_flush_mask) &= m;
    fsched_ctx.flush_cnt[bit] = 0;
    FWSH(ll_ctx, fsched_flush_over) &= m;
}
u32 fsched_rx_slot(void)
{
    /* 0x92843c: возврат fsched_arm_slot_timer (следующее состояние) */
    fsched_ctx.rx_slot_active = 1;
    rx_flow_run_and_check_bf_abort(1);
    fsched_ctx.rx_slot_active = 0;
    return fsched_arm_slot_timer(0xf);
}
void fsched_log_phase(u32 phase, u32 idx)
{
    /* 0x92b398: индекс записи — байт [gp,-238] = 0x80043a. */
    (void)idx;
    struct fsched_log_ent *e = &fsched_log[fsched_log_idx];
    e->state = (u8)fsched_ctx.state;
    e->phase = (u8)phase;
    e->arg = 0xff;
    e->step = 0;
}

u32 fsched_arm_slot_from_cfg(void)
{
    /* 6.2 asm 0x935a6c: длительность слота (единицы 165) -> поле qset 0; флаг 0x80064c=1.
     * (vendor передаёт r0=0x801be8 в fsched_assoc_slot_us, который его не использует.) */
    sxd_hal_write_qset_field(0, fsched_assoc_slot_us() * DMG_CLK_PER_US);
    fsched_ctx.state = 1;
    return 0;
}
u32 fsched_arm_slot_timer(u32 a)
{
    /* 0x925014: состояние 2; при a != 0 — таймер слота a*165 (мкс → тики).
     * Возврат: 4 при a == 0, иначе 0 (вызывающие используют как следующее состояние). */
    fsched_ctx.state = 2;
    if (a == 0)
        return 4;
    sxd_hal_write_qset_field(0, a * DMG_CLK_PER_US);
    return 0;
}


u32 fsched_ap_next_station(struct fsched_peer_ctx *p)
{
    /* 6.2 asm 0x920d04: кольцевой поиск следующей станции после cur_idx (шаг 1..8):
     * бит в maint_sta_mask и непустая sta_tab[i].qid_mask_q6 → запомнить, опросить, вернуть 1. */
    for (u32 k = 1; k < SPARRAW_STA_SLOTS; k++) {
        u32 i = (p->cur_idx + k) % SPARRAW_MAX_STA;
        if (!(maint_sta_mask & (1u << i)))
            continue;
        if (sta_tab[i].qid_mask_q6 == 0)
            continue;
        p->cur_idx = (u8)i;
        fsched_ap_poll_station(p);
        return 1;
    }
    p->cur_idx = 0;
    return 0;
}
u32 fsched_time_left_class(u32 a)
{
    /* 0x924f48: 2 — мало времени до TBTT, 1 — средне, 0 — достаточно. */
    u32 t = mac_read_usec_to_tbtt_uc(0);
    if (fsched_ctx.slot_cnt >= 1 && t >= fsched_ctx.tbtt_left_prev)
        return 2;
    fsched_ctx.tbtt_left_prev = t;
    if (a == 0)
        return (t < 0xbb8) ? 2 : 0;
    if (t >= fsched_slot_flush_to_us(&fsched_peers))
        return 0;
    return (t > 0x64) ? 1 : 2;
}

/* 0x938a18: слот TX дважды с паузой 800 тактов.
 * СРОК (выдержка): пауза между двумя TX-слотами фиксированного расписания (не 802.11: собственная
 * схема опроса vendor) — 800 тактов ≈ 4,85 мкс, как vendor 0x938a3c (lp 400 × 2×nop_s); что она
 * ждёт, не установлено (IFS стандарта ей не соответствует), поэтому длительность прежняя, но по
 * часам ядра (uc_delay_clk), а не по скорости цикла. */
void fsched_run_tx_slot_twice(void)
{
    fsched_get_cur_idx(&fsched_peers);
    mac_set_sector_arg_and_select_all(mac_read_usec_to_tbtt_uc(0));
    fsched_slot_clear_rd_counter(&fsched_peers);
    fixed_sched_run_tx_slot();
    uc_delay_clk(UC_NS_TO_CLK(4848u));   /* vendor 0x938a3c: lp 0x190 × 2×nop_s = 800 тактов при 165 */
    fixed_sched_run_tx_slot();
    fsched_ctx.state = 4;
}

u32 bit_index_lsb(u32 a)
{
    /* 6.2 asm 0x92d034: несмотря на имя (из blocks.json) — индекс МЛАДШЕГО
     * установленного бита (двоичный поиск по нижним 16/8/4/2/1 битам); 0 -> 0. */
    u32 n = 0;
    if (a == 0)
        return 0;
    if ((a & 0xffff) == 0) { n += 16; a >>= 16; }
    if ((a & 0xff) == 0)   { n += 8;  a >>= 8; }
    if ((a & 0xf) == 0)    { n += 4;  a >>= 4; }
    if ((a & 0x3) == 0)    { n += 2;  a >>= 2; }
    if ((a & 0x1) == 0)    n += 1;
    return n;
}

u32 bit_hist_push(u32 a, u32 b, u32 c, u32 d)
{
    /* 6.2 asm 0x93cd00: сдвиг буфера, при c!=0 вставка d|buf, возврат b<=count. */
    u32 *bs = (u32 *)a;                 /* {биты, число единиц} (rs_sta_state.back_fail и др.) */
    u32 r14 = bs[0];
    u32 r13 = bs[1];
    if (r14 & (1u << 31))
        r13--;
    bs[1] = r13;
    r14 <<= 1;
    bs[0] = r14;
    if (c != 0) {
        bs[0] = d | r14;
        r13++;
        bs[1] = r13;
    }
    return (b <= r13) ? 1 : 0;
}


u32 fsched_ap_start_slot(void)
{
    if (fsched_tx_ctrl_frame() != 0) {
        uc_mac_cmd(0x14000100);
        fsched_slot_clear_miss_cnt(&fsched_peers);
        fsched_ctx.state = 6;
        rx_wait_start_tsf = uc_read_tsf_lo();
        return 2;
    } else {
        mac_rf_switch_wait_idle(1);
        uc_mac_cmd(0x2040000);
        u32 cur = fsched_get_cur_idx(&fsched_peers);
        rx_mode_configure(2, cur);
        u32 r0 = fsched_log_idx;
        fsched_log[r0].step = 6;
        if (fsched_slot_inc_miss_cnt_reached_7(&fsched_peers) != 0) {
            u8 c2 = fsched_get_cur_idx(&fsched_peers);
            fsched_bf_req_set(&fsched_peers, (u8)c2);
        }
        return fsched_arm_slot_timer(0xf);
    }
}

u32 fsched_pick_ready_queue(u32 a)
{
    u32 r14 = a;
    u32 r0 = mac_sel_shadow & 0xfffff0ff;
    mac_sel_shadow = r0 | (1u << 8) | (1u << 9) | (1u << 11);
    uc_mac_cmd(r0 | 0x1d000b00);
    arc_nops(3);
    u32 r13 = mac_queue_sel();
    r0 = mac_sel_shadow & 0xfffff0ff;
    mac_sel_shadow = r0 | (1u << 10) | (1u << 11);
    uc_mac_cmd(r0 | 0x1d000c00);
    arc_nops(3);
    r13 |= mac_queue_sel();
    u32 r0b = uc_role_ap;
    if (r0b != 0) {
        u32 r1 = fsched_peer_id;
        if (r13 & (1u << r1)) {
            *(u32 *)r14 = r1;
            return 1;
        }
    }
    r0b = itx_pending.mask;
    if (r0b != 0) {
        *(u32 *)r14 = 0x1f;
        return 1;
    }
    if (r13 & (1u << 26)) {
        *(u32 *)r14 = 0x1a;
        return 1;
    }
    return 0;                                   /* 0x92bf1c: без записи */
}

u32 fsched_tx_ctrl_frame(void)
{
    gp0_timer_arm_usec(0x20);
    /* Grant станции текущего слота — AP занимает среду (Duration — слот) и отдаёт TXOP станции: после Grant AP слушает.
     * По 802.11-2020 10.39.7.3 (передача остатка TXOP ответчику): Source AID — AID ответчика (станции; fwsh_peer_aid,
     * пишет fw при ассоциации), Destination AID — AID держателя TXOP (AP/PCP = 0, 9.4.1.8), AllocationType — CBAP,
     * Allocation Duration — 32768 («в текущем TXOP», 9.5.2 b), Beamforming Training = 0 (смена ролей — только при 0).
     * исправлено (vendor): Source AID 0, Destination AID 1 (AID произвольной станции), Allocation Duration = длине слота
     * (по 9.5.2 a — «AP начнёт доступ через столько-то», не то), BF Control = 7.
     * TID 0: опрос не привязан к TS, станция шлёт из любой своей очереди. */
    struct dtx_grant_req req;
    u32 sta = fsched_get_cur_idx(&fsched_peers);
    req.dur = (u16)fsched_virtual_slot_us();            /* r0 = 0x801be8 не используется */
    req.sta = (u8)sta;
    req.rsv03 = 0;
    req.alloc_type = 1;
    req.src_aid = FWSH_AT(fwsh_peer_aid, aid, sta % SPARRAW_MAX_STA);
    req.dst_aid = 0;
    req.alloc_dur = DMG_ALLOC_DUR_IN_TXOP;
    u32 r0 = direct_tx_send_ctrl_frame(&req);
    if (r0 == 0)
        return 0;
    uc_spin_until_event(MAC_EVT1_TX_END);
    uc_wait_one_event(6);
    u32 r0b = abif_dvs_rf_ctrl_shadow;
    u32 r1 = rf_set_rx;
    r0b &= ~(1u << 24);
    r0b &= ~(1u << 25);
    r0b |= r1 << 24;
    abif_dvs_rf_ctrl_shadow = r0b;
    MMIO32(HW_ABIF_DVS_RF_CTRL) = r0b;
    return mac_wait_busy2_or_gp0_timeout();             /* хвост: результат arm_events */
}
u32 fsched_pick_any_ready_queue(u32 a)
{
    /* 0x9397f0: в режиме STA ([0x8014c0]==0) — сначала pick_ready_queue. */
    if (uc_role_ap == 0 && fsched_pick_ready_queue(a) != 0)
        return 1;
    u32 g = mac_sel_shadow & 0xfffff0ff;
    mac_sel_shadow = g | (1u << 8) | (1u << 9) | (1u << 11);
    uc_mac_cmd(g | 0x1d000b00);
    arc_nops(3);
    u32 r14 = mac_queue_sel();
    g = mac_sel_shadow & 0xfffff0ff;
    mac_sel_shadow = g | (1u << 10) | (1u << 11);
    uc_mac_cmd(g | 0x1d000c00);
    arc_nops(3);
    u32 m = (mac_queue_sel() | r14) & 0x3ff;
    if (m != 0) {
        *(u32 *)a = 30 - arc_norm(m);
        return 1;
    }
    *(u32 *)a = 0;
    return 0;
}

u32 fsched_ap_poll_station(struct fsched_peer_ctx *p)
{
    u8 r1 = p->cur_idx;
    u32 r0 = rs_state[r1].active;
    if (r0 != 0) {
        p->ent[r1].cfg_idx = 1;
        return 1;
    }
    MTP_REQUEST(MTP_W16_Q(fsched_cur_entry_qid(p), 1u), MTP_W17(0));
    while (!(mac_mtp_resp() & MAC_MTP_RESP_VALID))
        ;
    u32 r51 = mac_mtp_desc();
    mtp_desc_lo = r51 & 0xf;
    mtp_desc_hi = MTP_DESC_HI_OF(r51);
    u32 r1b = MAC_MTP_RESP_MCS_OF(mac_mtp_resp());
    /* исправлено (vendor): MCS из MAC 5-битный (0..31), таблица fixed_sched.mcs — MCS 0..12; вне её (OFDM / LP SC)
     * vendor читал за массивом. Берём запись MCS 1 — самую медленную SC, самые длинные сроки */
    if (r1b >= FIXED_SCHED_MCS_N)
        r1b = 1;
    u8 r0c = p->cur_idx;
    p->ent[r0c].cfg_idx = (u8)r1b;
    return r0c * 5;                             /* vendor: r0 = смещение записи (не используется) */
}
