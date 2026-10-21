// SPDX-License-Identifier: AGPL-3.0-or-later
/* Прочие функции uCode: утилиты, поля, DMA, frame_hdr, peer_masks. */
#include "../include/types.h"
#include "../include/bitfield.h"
#include "../include/hw.h"
#include "../include/arc.h"


#include "evt17.h"



/* 64-битный сдвиг влево (0x920458): (hi<<32|lo) << (sh&0x1f). */

/* Чтение triggered-маски AP (0x920f9c). */
/* uc_ap_read_triggered_mask — в uutil.c. */

/* 0x9215c4 — не функция, а метка цикла внутри background_task_dispatch
 * (восстановление STATUS32 из r13 и переход к 0x9215d2); см. sched.c. */

/* qid пира idx (ucode_cmd_0x08_handler, тип 3). */
void fsched_peer_set_qid(struct fsched_peer_ctx *p, u32 idx, u32 qid)
{
    /* 6.2 asm 0x920cd4 */
    p->ent[idx].qid = (u8)qid;
}

void fsched_peer_clear_qid(struct fsched_peer_ctx *p, u32 idx)
{
    /* 6.2 asm 0x92ebe0 */
    p->ent[idx].qid = 0xff;
}

void field_set_0x00_934b8c(u32 a, u32 b)
{
    *(u32 *)a = b;
}

void fsched_bf_req_clear(struct fsched_peer_ctx *p, u32 idx)
{
    /* 6.2 asm 0x924fb4 */
    p->bf_req_mask &= ~(1u << idx);
}

void fsched_peer_deactivate(struct fsched_peer_ctx *p, u32 idx)
{
    /* 6.2 asm 0x92ebec */
    p->active_mask &= ~(1u << idx);
}

/* frame_hdr bits-примитивы — thunk'и к bf_set_field_word, 2-арг. */

/* Инициализация заголовка кадра (0x9246fc): dst,arg1,arg2,src (4 рег. арг.). */
void frame_hdr_init(struct dtx_ctrl_frame *dst, u32 arg1, u32 arg2, const struct dtx_grant_req *src)
{
    dst->fc = 0x464;                               /* stw_s r0,[r14] */
    dst->duration = src->alloc_dur;                /* ldw_s r0,[r3]; stw_s [r14,0x2] */
    dst->alloc = 0;                                /* st_s r0,[r14,0x10] */
    dst->bf_ctl0 = 0;                              /* stb_s r0,[r14,0x15] */
    dst->bf_ctl1 = 0;                              /* stb_s r0,[r14,0x16] */

    /* alloc [23,32) = длительность >> 7 */
    bf_set32((u32)&dst->alloc, 23, 9, src->alloc_dur >> 7);
    /* w14 [0,7) = длительность & 0x7f */
    bf_set32((u32)&dst->w14, 0, 7, src->alloc_dur & 0x7f);
    /* alloc [4,7) = (alloc_type == 1) */
    bf_set32((u32)&dst->alloc, 4, 3, (src->alloc_type == 1) ? 1 : 0);
    /* alloc [15,23) = dst AID */
    bf_set32((u32)&dst->alloc, 15, 8, src->dst_aid);
    /* alloc [7,15) = src AID */
    bf_set32((u32)&dst->alloc, 7, 8, src->src_aid);

    /* bf_ctl0 = 1 | (arg1&1)<<1 | (arg2&1)<<2 */
    dst->bf_ctl0 = (u8)(1u | ((arg1 & 1) << 1) | ((arg2 & 1) << 2));
}

/* СРОК: импульс сброса указателей TXQ (|=3, sync, &=~3, sync — ~6 инструкций, vendor 0x925a48 так
 * же; аппаратная минимальная ширина не известна), затем два запроса MTP с ожиданием r43.31/r45.31
 * без ограничения. Срыв: при молчании MAC — зависание uc. */
/* macq_kick_queue_tx (0x925a48). */
void macq_kick_queue_tx(u32 q, u32 b, u32 c)
{
    if (macq_is_idle(q) == 0) {
        dump_mac_buffer_bases(q, q);
        uc_assert((u32)__builtin_return_address(0), 0x157a);
    }
    MMIO32(HW_TXQ_PTR_RESET) |= 3;
    arc_sync();
    MMIO32(HW_TXQ_PTR_RESET) &= ~3u;
    arc_sync();

    u8 sp[0x18];
    struct qh_buf_win *w = (struct qh_buf_win *)(sp + 4);   /* окно — с sp+4, как у vendor */
    qh_read_desc_window((u32)w, q, 2, 0, 1);
    u16 v = w->buf_base;
    w->buf_mac = v;
    w->buf_pal = v;
    w->buf_len8 = (u16)((c + 7) >> 3);
    qh_write_desc_window((u32)w, q, 2, 0, 0, 0, 0, 1);

    struct tx_ctx_s *ctx = tx_ctx_alloc_next(1);
    ctx->qid = q;
    mac_program_tx_with_qid(q);
    while (!(arc_core_rd(43) & (1u << 31)))
        ;
    u32 r51 = arc_core_rd(51);
    mtp_desc_lo = r51 & 0xf;
    mtp_desc_hi = r51 >> 4;
    while (!(arc_core_rd(45) & (1u << 31)))
        ;

    /* 2-я половина (0x925afc..): addr_of_slot + kick + повторный alloc/program. */
    mac_mem_addr_of_slot(b, 0, q);
    MMIO32(HW_TXQ_RING_ENABLE) |= 1u << q;
    MMIO32(HW_TXQ_REQ_SELECT) = 1u << q;
    MMIO32(HW_TXQ_REQ_VALUE) = 1u << q;
    MMIO32(HW_TXQ_REQ_APPLY) = 1;

    ctx = tx_ctx_alloc_next(1);
    ctx->qid = q;
    mac_program_tx_with_qid(q);
    while (!(arc_core_rd(43) & (1u << 31)))
        ;
    r51 = arc_core_rd(51);
    mtp_desc_lo = r51 & 0xf;
    mtp_desc_hi = r51 >> 4;
    while (!(arc_core_rd(45) & (1u << 31)))
        ;
}
void dump_mac_buffer_bases(u32 a, u32 b)
{
    /* 0x925c0c: дамп баз MAC-буфера + контроль 0x2000. */
    struct qh_buf_win buf;
    dump_vring_pring_info(a);
    qh_read_desc_window((u32)&buf, b, 2, 0, 1);
    uc_log_emit3(0x21, 0x1001ac8, buf.buf_base, buf.buf_mac, buf.buf_pal);   /* «MAC buffer: base mac pal» */
    u32 v = buf.wc;
    uc_log_emit3(0x21, 0x1001af0, (v >> 16) & 0xfff,          /* «MAC desc: base mac pal»; bmsk 0xb = 12 бит */
                 (buf.w8 >> 12) & 0xfff,
                 buf.desc_pal_lo | ((v & 0xf) << 8));
    if (buf.buf_base != 0x2000)
        uc_assert((u32)__builtin_return_address(0), 0x1583);
}
/* СРОК: окно наблюдения «труба TX пуста» задаётся скоростью цикла (аппаратный: DMA/MAC должны
 * успеть показать незавершённый перенос): на проход — lp 0x28 × 2 nop (~80 тактов) + тело (~9 вызовов
 * чтения MMIO, ~100–150 инструкций), c проходов (c = 10/15 у вызывающих) ≈ 1,5–2 мкс × c. vendor
 * 0x926184 — та же петля и те же вызовы; запас не оценён. Ускорение тела сокращает окно — ложное
 * «idle» и отключение vring при недокачанном кадре. */
u32 dma_is_tx_pipe_idle(u32 a, u32 b, u32 c)
{
    /* 0x926184: c итераций опроса; 1 если все условия «idle» на каждой. */
    u32 r24 = macq_hw_read_rptr(b);
    if (c == 0)
        return 1;
    u32 r22 = c;
    for (;;) {
        u32 r19 = dma_is_idle_uc(b, 0);              /* L_9290f4 */
        u32 rptr = macq_hw_read_rptr(b);             /* L_929088 */
        u32 r16 = (r24 == rptr) ? 1 : 0;
        u32 trig = macq_hw_trigger_read_state(b);    /* L_928fcc */
        u32 r17 = (trig == 0) ? 1 : 0;
        u32 dma881 = dma_read_881c28();              /* L_928fa8 */
        u32 r18 = (dma881 & (1u << ((b + 8) & 0x1f))) ? 1 : 0;
        u32 r20 = txq_fifo_ptp_idle_snapshot();      /* L_92e8a8 */
        u32 r15 = macq_is_idle(a);                   /* L_92609c */
        u32 s0 = macq_hw_read_state0(b);             /* L_929020 */
        u32 s1 = macq_hw_read_state1(b);             /* L_929044 */
        u32 r0 = (s0 == s1) ? 1 : 0;
        u32 r13 = (r19 && r16 && r17 && r18 && r20 && r15 && r0) ? 1 : 0;
        u8 status = (u8)((r0 << 7) | (r15 << 6) | (r20 << 5) | (r18 << 4) |
                         (r17 << 3) | (r16 << 2) | (r19 << 1));
        vring_dbg.tx_pipe_idle_cases = status;              /* stb_s r0,[0x80070c,0x2] */
        if (r13 == 0) {
            uc_log_emit1(0x21, 0x1001b18, (u32)(u8)status);
            return 0;
        }
        arc_zol_nops2(0x28);           /* vendor L_926264..L_926272: lp 0x28 × 2×nop_s */
        r22 -= 1;
        if (r22 == 0)
            return 1;
    }
}
void peer_masks_or_into_8571c4(u32 a)
{
    /* 0x9263d0: для каждого установленного бита маски a взять бит из 0x800570
     * и OR-нуть в 0x8571c4. norm r0,r1; rsub r2,r0,0x1e = 30 - clz. */
    u32 r1 = a;                             /* vendor: без extb на входе (extb только после bclr) */
    while (r1 != 0) {
        u32 bit = (30 - arc_norm(r1)) & 0x1f;  /* bset/bclr: low 5 бит */
        u32 mask = 1u << bit;
        u32 r0 = itx_ka_pending & mask;   /* ld_s r0,[gp,0x48] (s9 byte → 0x800570) */
        FWSH(ll_ctx, pending_mask) |= r0;             /* [0x857180+0x44] */
        r1 &= ~mask;                        /* bclr r1,r1,r2 */
        r1 = (u32)(u8)(u8)r1;               /* extb_s r1,r1 */
    }
}
void peer_masks_update_sta_bit(struct fsched_peer_ctx *p, u32 sta, u32 set)
{
    /* 6.2 asm 0x926404 (отдельная функция внутри блока peer_masks__or_into_8571c4;
     * вход из ucode_cmd_0x47_handler). Пир по qid sta — в active_mask или из неё; снятие
     * текущего пира откладывается до конца слота (fixed_sched_read_slot_id). */
    u32 idx = sta_find_by_byte(p, sta);
    if (idx >= 8)
        uc_assert((u32)__builtin_return_address(0), 0x1584);
    if (set != 0) {
        p->active_mask |= (u8)(1u << (idx & 31));
        uc_evt_send_2e(sta, 1, qh_build_descriptor_b(sta));
    } else if (idx == p->cur_idx) {
        p->pend_off_qid = (u8)sta;
        p->pend_off_idx = (u8)idx;
    } else {
        p->active_mask &= (u8)~(1u << (idx & 31));
        uc_evt_send_2e(sta, 0, qh_build_descriptor_b(sta));
    }
}
/* СРОК: пауза между импульсом FS_CTRL.3 и пуском делителя RFC — 160 тактов ≈ 0,97 мкс, как vendor
 * 0x928c78 (lp 0x50 × 2×nop_s). Это время установления железа с неизвестным минимумом, поэтому
 * длительность прежняя, но по часам ядра (uc_delay_clk): прерывание её не удлиняет, ускорение кода
 * не укорачивает. Сокращение может оставить делитель RF-такта в неопределённом состоянии. */
void hwd_abif_rfc_divider_restart_uc(void)
{
    MMIO32(HW_RFC_DIVIDER_CTRL) &= ~1u;          /* ld.as [r6,0xe5] = 0x889000+0xe5*4 */
    MMIO32(HW_ABIF_FS_CTRL) |= 1u << 3;          /* ld.as [r5,-0xf9] = 0x889800-0xf9*4 */
    MMIO32(HW_ABIF_FS_CTRL) &= ~(1u << 3);       /* vendor перечитывает регистр */
    uc_delay_clk(0x50 * 2);        /* vendor L_928cb0..L_928cbc: lp 0x50 × 2×nop_s */
    MMIO32(HW_RFC_DIVIDER_CTRL) |= 1;
}
/* dma_is_idle_uc — ниже. */
void hwd_dma_set_mode_map(u32 a)
{
    if (a != 1 && a != 2 && a != 4)
        uc_assert((u32)__builtin_return_address(0), 0x12dc);
    u32 pat = a | (a << 4) | (a << 8) | (a << 12)
            | (a << 16) | (a << 20) | (a << 24) | (a << 28);
    MMIO32(HW_PWR_MODE_MAP_BE8) = pat;
    MMIO32(HW_PWR_MODE_MAP_BEC) = (u8)pat;
    MMIO32(HW_PWR_MODE_MAP_C0C) = pat & 0x0fffffffu;
}
u32 dump_pring_hw(u32 q)
{
    /* 0x9291d8: прочитать 4 поля PRING HW, сверить, вернуть 1 если все равны. */
    u32 base = q * 896;                     /* asl3; sub; asl7 = q*7*128 */
    u32 f1 = (MMIO32(((base + 0x4409800) >> 3) & ~3u) >> ((base + 0x4409800) & 0x1f)) & 0xf;
    u32 f2 = (MMIO32(((base + 0x4409840) >> 3) & ~3u) >> ((base + 0x4409840) & 0x1f)) & 0xf;
    u32 f3 = (MMIO32(((base + 0x4409820) >> 3) & ~3u) >> ((base + 0x4409820) & 0x1f)) & 0xf;
    u32 f4 = (MMIO32(((base + 0x4409860) >> 3) & ~3u) >> ((base + 0x4409860) & 0x1f)) & 0xf;
    if (f1 == f2 && f3 == f4 && f1 == f3)
        return 1;
    uc_log_emit2(0x20, 0x1002e88, f1, f2);
    uc_log_emit2(0x20, 0x1002de0, f3, f4);
    return 0;
}
void dump_vring_pring_info(u32 q)
{
    u32 r13 = q;
    uc_log_emit2(0x20, 0x1002d40, r13, 0);

    /* MMIO 0x8818xx: vendor L_929354/L_929372/L_92938e — 32-бит ld по порядку v1,v2,v3 */
    u32 r5 = (r13 << 8) + 0x440c0c0;
    u32 v1 = (u16)(MMIO32((r5 >> 3) & ~3u) >> (r5 & 0x1f));
    u32 r4 = (r13 << 8) + 0x440c120;
    u32 v2 = (u16)(MMIO32((r4 >> 3) & ~3u) >> (r4 & 0x1f));
    u32 r13b = (r13 << 8) + 0x440c100;
    u32 v3 = (u16)(MMIO32((r13b >> 3) & ~3u) >> (r13b & 0x1f));
    uc_log_emit3(0x20, 0x1002d60, v1, v2, v3);

    volatile u32 *r13c = (volatile u32 *)HW_PRING_BASE;
    uc_log_emit3(0x20, 0x1002d90, (u16)r13c[0xc4], (u16)r13c[0xc6], (u16)r13c[0xba]);
    uc_log_emit2(0x20, 0x1002dc0, r13c[0xc0] & 0xf, r13c[0xc2] & 0xf);
    uc_log_emit2(0x20, 0x1002de0, r13c[0xc1] & 0xf, r13c[0xc3] & 0xf);
    uc_log_emit1(0x20, 0x1002e04, r13c[0x4d] & 0xf);
}
/* dma_mac_cfg_880c14 — ниже. */
/* dma_mac_cfg_880c28 — ниже. */
void hwd_phy_rx_set_agc_start_val_and_gain_array_uc(u32 a, u32 b)
{
    u32 r4 = b & 0x3f;
    u32 r17 = b & 0xfc0;
    u32 r16 = b & 0x3f000;
    u32 r15 = b & 0xfc0000;
    if (!(a <= r4 && a <= r17 && a <= r16 && a <= r15)) {
        uc_log_emit3(0, 0x10027e8, b, a, r4);
        uc_log_emit3(0, 0x100286c, r17, r16, r15);
        uc_assert((u32)__builtin_return_address(0), 0x146c);   /* возвращается — запись ниже всё равно */
    }
    MMIO32(HW_PHY_RX_INA_AGC_START) = a;
    MMIO32(HW_PHY_RX_INA_AGC_GAIN_ARRAY) = b;
}
void hwd_rfc_powerdown_deep_all_rfs(void)
{
    /* 0x929fa0: снапшот → выбрать RF0xff → выключить ядра → восстановить RF → лог. */
    u8 saved = 0;
    uc_log_emit_snapshot(0x29, 0x10020bc);
    rfca_select_rf_uc(0xff, (u32)&saved);
    hwd_rfc_write_core(0, 6, 1, 0);
    hwd_rfc_write_core(0, 8, 0, 0);
    uc_log_emit_snapshot(0x29, 0x100209c);
    rfca_select_rf_uc(saved, 0);
    uc_log_emit1(0x29, 0x10020dc, saved);
}
void hwd_rfc_powerup_deep_all_rfs(void)
{
    /* 0x92a0a0: пробуждение всех RF-ядер с повтором по таймауту. */
    u8  saved_rf = 0;                 /* [sp+0] */
    u32 res = 0;                      /* [sp+4] — флаг rfc_read_core_result */
    u32 mask = 0;                     /* [sp+8] */
    u32 r16 = 0xa;
    rfc_txrx_set = 0xa;
    u8 r17 = rf_modules.cur;
    uc_log_emit1(0x29, 0x1002000, r17);

    u32 r15 = r16;
    for (;;) {
        rfca_select_rf_uc(0xff, (u32)&saved_rf);
        rfc_restore_txrx_sets();
        rfca_select_rf_uc(saved_rf, 0);
        field_set_0x00_934b8c((u32)&mask, r17);   /* mask = r17 */
        if (bit_iter_has_more_uc((u32)&mask)) {
            for (;;) {
                /* notify_aoa (0x92de8c): взять и сбросить старший бит маски */
                u32 bit = (30 - arc_norm(mask));       /* norm + rsub 0x1e */
                mask &= ~(1u << (bit & 0x1f));            /* bclr */
                rfca_select_rf_uc((u8)(1u << bit), 0);    /* asl r3,0x1,r0 = 1<<bit; extb */
                rfc_read_core_result(0, 0x428, (u32)&res);
                rfca_select_rf_uc(saved_rf, 0);
                if (res == 0) {
                    rfc_txrx_set = 0xa;
                    r15 += 0xa;
                    break;
                }
                if (!bit_iter_has_more_uc((u32)&mask))
                    break;
            }
        }
        if ((u8)r15 >= 0x33)
            break;
        if (res == 0)
            continue;
        break;
    }
    uc_log_emit2(0x29, 0x100202c, res, r15);
    if (res == 0)
        uc_log_emit_snapshot(0x9, 0x1002060);
    rfca_select_rf_uc(saved_rf, 0);
    rfc_txrx_set = (u8)r15;
}
void peer_masks_apply_op(struct pm_ctx_s *p, u32 op, u32 val)
{
    u8 *aw = (u8 *)&p->awake_mask, *nt = (u8 *)&p->no_tx_mask;

    switch (op) {
    case 0:
        p->awake_mask = 0; p->no_tx_mask = 0; p->ps_active = 1;
        break;
    case 1:
        p->no_tx_mask &= (u8)~val;
        /* fallthrough */
    case 3:
        p->awake_mask |= val;
        break;
    case 2:
        p->no_tx_mask |= val;
        break;
    /* op 4 (ps_bits) — только при отсрочке трафика: вырезана вместе с энергосбережением PCIe */
    default:
        break;
    }

    if (uc_role_ap != 0) {
        u8 r7 = maint_sta_mask;                 /* & idle_mask (≡ 0xff: PS вырезан) */
        aw[0] |= r7;
        aw[1] |= r7;
        nt[0] &= ~r7;
        nt[1] &= ~r7;
        return;
    }

    u32 spv[2];
    mac_read_bi_start_tsf64_uc(0, spv, 1);
    /* cmp_s hi; cmp.eq lo; mov r8,1; sub.ls r8 — r8 = (tsf64 пира > начало BI), беззнаково */
    u64 pt = ((u64)p->tbtt[1] << 32) | p->tbtt[0];
    u64 bt = ((u64)spv[1] << 32) | spv[0];
    u32 r8 = (pt > bt) ? 1 : 0;
    u32 r9 = FWSH(fwq_tx_avail, aw_info);
    r9 = (r9 & ~(1u << 27)) | (r8 << 27);
    FWSH(fwq_tx_avail, aw_info) = r9;

    /* vendor: при своём расписании PS (psc.state ≠ 0) в BI сна — иначе; PS вырезан */
    u8 r10 = maint_sta_mask;                    /* & idle_mask (≡ 0xff) */
    aw[0] |= r10;
    aw[1] |= r10;
    nt[0] = 0;
    nt[1] = 0;
}
void peer_slots_scan_by_masks(u32 a)
{
    (void)a;
    if (mac_mon_armed != 1)
        return;
    uc_read_tsf_lo();
    u8 r6 = 0xff;                               /* idle_mask (≡ 0xff: PS вырезан) */
    u8 r14 = mac_mon_report.bcons_atim_fail_vec;

    for (u32 r1 = 0; r1 < 8; r1++) {
        int clear_9c = 0;
        if (sta_slot_ok_cnt[r1] == 0) {
            u8 r5 = maint_sta_mask;
            u32 r0 = 1u << r1;
            if ((r5 & r0) != 0 && (r0 & r6) == 0) {
                if (sta_slot_fail_cnt[r1] != 0) {
                    u8 r3b = sta_miss_cnt[r1] + 1;
                    sta_miss_cnt[r1] = r3b;
                    if ((u8)r3b >= 0xb) {
                        r0 |= r14;
                        r14 = (u8)r0;
                        mac_mon_report.bcons_atim_fail_vec = (u8)r0;
                        clear_9c = 1;
                    }
                }
            } else {
                clear_9c = 1;
            }
        } else {
            clear_9c = 1;
        }
        if (clear_9c)
            sta_miss_cnt[r1] = 0;
        sta_slot_ok_cnt[r1] = 0;
        sta_slot_fail_cnt[r1] = 0;
    }

    u8 r8 = mac_mon_slot_idx;
    struct mac_mon_slot_s *src = &mac_mon_slot[(r8 == 0) ? 1 : 0];   /* опубликовать неактивный слот */
    for (u32 i = 0; i < 10; i++)
        mac_mon_report.slot[i] = ((u32 *)src)[i];
    memcpy_uc((void *)&mac_mon_pub, (void *)&mac_mon_report, 0x80);   /* add2 r1,r15,0x15 = 0x801084 */
    memset0_words_uc(src, sizeof(*src));
    memset0_words_uc((void *)&mac_mon_report, 0x80);   /* add2 r0,r15,0x15 = 0x801084 */
    mac_mon_report.size = 0x80;
    src->detected = 0;
    src->rssi_valid = 0;
    src->rssi = (s32)0xffffff00;
    src->snr_valid = 0;
    src->snr = (s32)0xffffff00;
    mac_mon_report.bcons_atim_fail_vec = r14;
    mac_mon_snap = FWSH(mac_mon_pub, nav_accum);
    uc_send_evt_mac_monitor(1);
    mac_mon_armed = 0;
    tx_busy_start_tsf = 0;
    busy_acct.sig_start_tsf = 0;
    busy_acct.busy_start_tsf = 0;
    busy_acct.last_end_tsf = 0;
}
void uc_evt_build_and_post_report(const struct sls_peer_rec *p, u32 flag)
{
    /* 0x93e624: собрать отчёт BF (0x44 Б, 17 слов) и отослать bf_done/new_link.
     * Слова 0..7 — регистры, 8..16 — стек (sp+0x44..0x64 vendor). Байты, которые
     * vendor не пишет (неинициализированный стек), здесь 0. */
    u32 r14 = (flag != 0) ? p->sta : p->abft_sta;          /* тип события */
    u32 r13 = (flag != 0) ? p->x0c : p->snr;
    u32 r2  = (flag != 0) ? p->fb_sector : p->abft_sector;
    u32 h3  = (flag != 0) ? p->peer_mac[0] : bcn_rx.bssid[0];
    u32 h4  = (flag != 0) ? p->peer_mac[1] : bcn_rx.bssid[1];
    u32 h5  = (flag != 0) ? p->peer_mac[2] : bcn_rx.bssid[2];
    u32 r9  = (flag != 0) ? 3 : 4;
    u32 r10 = (rf_chain_word >> 8) & 0x7fff;
    u32 w[17];
    w[0] = r13;
    w[1] = r14 | (0xffu << 8) | (r2 << 16);                       /* sp+0x28 */
    w[2] = ((u32)bf_rep.ssw_rx_cnt << 8) | (r10 << 16);                     /* sp+0x2c */
    w[3] = (u8)bf_rep.peer_snr;                                               /* sp+0x30 */
    w[4] = (u32)(s32)bf_rep.own_snr;                                 /* ldb.x */
    w[5] = bf_rep.sect_seen[0][0];
    w[6] = bf_rep.sect_seen[0][1];
    w[7] = bf_rep.sect_seen[1][0];
    w[8] = bf_rep.sect_seen[1][1];                                   /* sp+0x44 */
    w[9] = 0xff;                                                  /* sp+0x48 */
    w[10] = 0xff;                                                 /* sp+0x4c */
    w[11] = 1;                                                    /* sp+0x50 */
    w[12] = 2;                                                    /* sp+0x54 */
    w[13] = h3 | (h4 << 16);                                      /* sp+0x58 */
    w[14] = h5 | (r9 << 16);                                      /* sp+0x5c, [0x5f] = 0 */
    w[15] = 0;                                                    /* sp+0x60: vendor не пишет */
    w[16] = uc_read_tsf_lo();                                     /* sp+0x64 */
    if (r14 == 8)
        uc_send_evt_new_link(EVT17(w));
    else
        uc_send_evt_bf_done(EVT17(w));
}
u32 hwd_rfc_auto_fill_verify(const struct rf_fill_info *f, u32 b, u32 c)
{
    u32 r20 = b, r21 = c;
    if (f->verify == 0 || f->vals == 0)
        return 1;
    u32 r14 = (f->bank == 1) ? 1 : 0;
    u8 r18 = f->sec_first;
    u8 r7 = f->sec_last;
    r14 <<= 12;
    if ((u8)r7 < (u8)r18)
        return 1;
    r14 += 0x1000;   /* add3 r14,r14,0x200 = +0x200*8 = +0x1000 */
    u32 r13 = f->vals;
    do {
        u32 r15 = 1;
        u32 r16 = 6;
        do {
            u8 r5 = f->val_mask;
            if (r5 & r15) {
                u32 r0 = hwd_rfc_read_rgf_uc(0, r14);
                if (r0 != *(u32 *)r13) {
                    /* L_93e83c: brne.d r0,r6 / mov r4,r0 — 5-й арг = прочитанное значение */
                    uc_log_emit3(0, 0x1000e14, r20, r18, r0);
                    if (r21 != 0)
                        uc_assert((u32)__builtin_return_address(0), 0x1567);
                    return 0;
                }
            }
            r15 <<= 1;
            r16--;
            r14 += 4;
            r13 += 4;
        } while (r16 >= 1);
        r18++;
    } while (f->sec_last >= r18);   /* перечитывается на каждом проходе */
    return 1;
}

/* Пир idx в расписание: запись обнулить, бит в active_mask (LMAC 0x05 CREATE). */
void fsched_peer_add(struct fsched_peer_ctx *p, u32 idx)
{
    /* 6.2 asm 0x920cdc */
    memset0_words_uc(&p->ent[idx], sizeof(p->ent[idx]));
    p->active_mask |= (1u << idx);
}

/* uc_sysassert_emit_mac_trace (0x92f2f0). */
void uc_sysassert_emit_mac_trace(u32 a)
{
    u32 r0 = ((a << 4) & 0x1f0u) | 0x3e000000u;   /* bic -0x1f1 = &0x1f0 */
    uc_mac_cmd(r0);
    uc_mac_cmd(0x3d001000);
}

/* 0x920484 — на деле 64-бит multiply-хелпер (__muldi3) + sign-ror; имя в blocks.json неточное; libgcc даёт эквивалент (мёртвый код). */


/* DMA простаивает — rptr == wptr (0x9290f4). */
u32 dma_is_idle_uc(u32 q, u32 verbose)
{
    u32 base = (q * 7) << 7;
    u32 rptr = MMIO32(((base + 0x4409880) >> 3) & ~3u);
    u32 wptr = MMIO32(((base + 0x44098c0) >> 3) & ~3u);
    if (verbose != 0)
        uc_log_emit2(0x20, 0x1002ce4, rptr, wptr);
    return (rptr == wptr) ? 1 : 0;
}

/* Обработчик кольца команд (0x92d880; cmdq_desc_handler): ucode_cmd_dispatch(запись, тело),
 * освободить запись, сдвинуться. */
void ucode_cmdq_handler(struct uc_mbox_ctx *m, u32 item)
{
    ucode_cmd_dispatch(item, item + sizeof(struct uc_evt_hdr));
    m->cmd.cur->sync = 0;                         /* st_s r2,[r1,0] в слоте bl.d */
    buf_check_bounds(&m->cmd);
}

/* Разобрать одну команду и сообщить fw новую позицию читателя (0x92fb40). */
void uc_queue_dispatch_and_commit(struct uc_mbox_ctx *m)
{
    u32 item = uc_queue_peek_head_word1(&m->cmd);      /* L_927f64 */
    struct cmdq_handler_desc *d = m->cmd_desc;
    void (*fn)(struct uc_mbox_ctx *, u32, struct cmdq_handler_desc *) =
        *(void (**)(struct uc_mbox_ctx *, u32, struct cmdq_handler_desc *))((u32)d + 4);   /* cmdq_desc_handler */
    fn(m, item, d);
    m->cmd.ctl->tail = (u32)m->cmd.cur;
}

/* Конфиг DMA/MAC 0x880c14 (0x929424). */
void dma_mac_cfg_880c14(u32 a)
{
    if (a != 0) {
        MMIO32(HW_CLKS_CTL_EXT_CLK_VEC_0) = (MMIO32(HW_CLKS_CTL_EXT_CLK_VEC_0) & 0xffc00800) | 0x3ff7ff;
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) = (MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) & 0xfffc5fff) | 0x3a000;
    } else {
        MMIO32(HW_CLKS_CTL_EXT_CLK_VEC_0) &= 0xffc00800;
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) &= 0xfffc5fff;
    }
}

/* Конфиг DMA/MAC 0x880c28 (0x92961c). */
void dma_mac_cfg_880c28(u32 a)
{
    if (a != 0) {
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) = (MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) & 0x3ffff) | 0xfffc0000;
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_1) |= 0x3f;
        MMIO32(HW_CLKS_CTL_EXT_CLK_VEC_1) |= 0xf;
    } else {
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) &= 0x3ffff;
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_1) &= ~0x3fu;
        MMIO32(HW_CLKS_CTL_EXT_CLK_VEC_1) &= ~0xfu;
    }
}

/* ISR-обёртки L1/L2 task (контекст сохраняет компилятор). */
void uc_isr_l1_task0(void);   /* tail.c */
void uc_isr_l1_task2(void);   /* tail.c */
void uc_isr_l2_task2(void);   /* tail.c */
void uc_isr_l2_task3(void);   /* tail.c */

/* Загрузка таблицы 0x803124..0x803130 (0x920b1c). */
void ucode_cmd_load_table_803124_803128(u32 a, u32 b)
{
    (void)a;
    const struct lmac_cmd_bi_tbl *c = (const void *)b;
    abft_cfg.responder_mode = c->responder_mode;
    abft_cfg.beacon_type = c->beacon_type;
    abft_cfg.relax_period = c->relax_word;
    abft_cfg.relax_cnt = 0;
}

/* Снапшот MAC (0x93756c): консистентный TSF 0x886eb8/lo + 0x886ebc/hi. */
void uc_sysassert_snapshot_mac(u32 a, u32 b, u32 wait)
{
    (void)a;
    u32 *out = (u32 *)b;
    if (wait != 0) {
        while (!(MMIO32(HW_MAC_TIMING_STATUS) & (1u << 31)))
            ;
    }
    for (;;) {
        u32 hi = MMIO32(HW_MAC_TSF_HI);
        u32 lo = MMIO32(HW_MAC_TIMING_INDIRECT_REG_5);
        if (MMIO32(HW_MAC_TSF_HI) == hi) {
            out[0] = lo;
            out[1] = hi;
            return;
        }
    }
}

/* scan_stack (0x92635c). */
void uc_sysassert_scan_stack(u32 a)
{
    (void)a;
    u32 r13 = MMIO32(HW_UCPU_SP) + 0x140000;
    u32 r14 = 0x944000;
    uc_log_emit2(0x20, 0x1000610, r13, r14);
    while (r13 < r14) {
        u32 v = *(u32 *)r13;
        if (v >= 0x160 && v <= 0x20000)          /* brlo 0x20000,r3 → пропуск только при v > 0x20000 */
            uc_log_emit2(0x20, 0x1000628, r13, v);
        r13 += 4;
    }
}

/* idle_hist (0x926478). */
void uc_sysassert_idle_hist(void)
{
    u32 r8 = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = r8;
    uc_mac_cmd(r8 | 0x1d000000);
    arc_nops(3);

    u16 *r15 = sysassert_idle_sm_hist;
    u32 *r13 = sysassert_cca_hist;
    for (u32 r14 = 0x4e20; r14 >= 1; r14--) {
        arc_nops(16);
        u32 idx = arc_core_rd(40) & 7;
        r15[idx] += 1;
        s32 st = (s32)uc_sysassert_read_hw_state3();
        if (st >= 3)
            r13[3] += 1;
        else
            r13[st] += 1;
    }

    uc_log_emit1(0x20, 0x10002f4, 0x4e20);
    uc_log_emit1(0x20, 0x1000338, r15[0]);
    uc_log_emit1(0x20, 0x1000374, r15[1]);
    uc_log_emit1(0x20, 0x10003b0, r15[2]);
    uc_log_emit1(0x20, 0x10003ec, r15[3]);
    uc_log_emit1(0x20, 0x1000428, r15[4]);
    uc_log_emit1(0x20, 0x1000464, r15[5]);
    uc_log_emit1(0x20, 0x10004a0, r15[6]);
    uc_log_emit1(0x20, 0x10004dc, r15[7]);
    uc_log_emit1(0x20, 0x1000518, 0x4e20);
    uc_log_emit1(0x20, 0x1000560, r13[0]);
    uc_log_emit1(0x20, 0x1000584, r13[1]);
    uc_log_emit1(0x20, 0x10005a8, r13[2]);
    uc_log_emit1(0x20, 0x10005cc, r13[3]);
}

/* Главный assert uCode (0x926618). */
void uc_assert(u32 caller, u32 code)
{
    if (assert_active != 0)
        return;                 /* уже в assert (рекурсия) */
    assert_active = 1;

    u32 tsf[2];
    uc_sysassert_snapshot_mac(0, (u32)tsf, 0);
    uc_log_emit3(0x20, 0x10001e8, tsf[1], tsf[0], code);

    FWSH(fwsh_diag, uc_assert_code) = code;
    FWSH(fwsh_diag, uc_assert_caller) = caller;

    /* метка assert в кольце MAC-команд: 0x80eeeeee, код | бит 31, ror(1) = 0x80000000 */
    uc_mac_cmd(0x80eeeeee);
    uc_mac_cmd(code | (1u << 31));
    uc_mac_cmd(0x80000000);

    u32 blink = (u32)__builtin_return_address(0);
    u32 ilink1, ilink2;
    __asm__ volatile("mov %0, r29" : "=r"(ilink1));
    __asm__ volatile("mov %0, r30" : "=r"(ilink2));
    uc_log_emit3(0, 0x1000218, caller, blink, code);
    uc_log_emit3(0, 0x1000264, (u32)tsf, ilink1, ilink2);

    uc_log_emit1(0x20, 0x100029c, MMIO32(HW_PRS_ICR));
    uc_log_emit1(0x20, 0x10002ac, *(volatile u32 *)HW_MRFC_SWITCH2TX_STATUS_BUS);
    uc_log_emit1(0x20, 0x10002d0, *(volatile u32 *)HW_MRFC_SWITCH2RX_STATUS_BUS);

    uc_sysassert_idle_hist();
    if (assert_reset_ina_det == 1)
        phy_rx_set_ina_det_mode_uc(0);
    uc_sysassert_emit_mac_trace(0xd);
    uc_sysassert_write_code(1);

    assert_code = code;
    assert_code2 = code;
    assert_caller = caller;
    mac_trace_ptr_snap = uc_trace_ptr();   /* st.as r25,[gp,12]: указатель кольца MAC-команд */
    *(volatile u32 *)HW_MAC_SXD_ERRORS_IMC = 0x40;
    *(volatile u32 *)HW_MAC_SXD_ERRORS_ICS = 0x40;

    __asm__ volatile(ARC_NOPS_4 "\n\tflag 1\n\t" ARC_NOPS_3 "\n\tnop" ::: "memory");
    /* vendor: после flag 1 (останов) — возврат, если ядро снова запущено */
}
