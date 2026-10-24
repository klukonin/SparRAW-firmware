// SPDX-License-Identifier: AGPL-3.0-or-later
/* Разные функции uCode (TX-контекст, mailbox, TSF, ...). Имя файла историческое: заглушек здесь нет. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/sta_max.h"


#include "../include/hw.h"
#include "../include/arc.h"


/* uc_list_insert_by_prio — в util.c. */
void timer_list_insert_sorted(u32 obj, u32 prio, u32 order)
{
    /* Вставка в отсортированный список таймеров (6.2 asm 0x92e788).
     * head-массив 0x8017b8 (u32 указатели), add2_s = ×4. */
    /* Узлы — struct init_desc (key, next). */
    struct init_desc *o = (struct init_desc *)obj;
    u32 *head = &timer_list_head[prio];
    struct init_desc *node = (struct init_desc *)*head;
    u32 val = o->key;
    struct init_desc *prev = 0;
    while (node != 0) {
        u32 nval = node->key;
        int stop = (order == 0) ? (val >= nval) : (nval >= val);
        if (stop)
            break;
        struct init_desc *next = (struct init_desc *)node->next;
        if (next == 0) {
            o->next = 0;
            node->next = obj;
            return;
        }
        prev = node;
        node = next;
    }
    o->next = (u32)node;
    if (prev == 0)
        *head = obj;
    else
        prev->next = obj;
}
/* timer_list_init — в util.c. */
/* (L_9202ac = __ld_r13_to_r13_ret — эпилог, не функция) */
/* memset0_words_uc — в util.c. */
void uc_log_init_ring(void)
{
    if (uc_log_module_tab[0] == 0)
        uc_assert((u32)__builtin_return_address(0), 0xf8);
    uc_log.wr_idx = 0;
    u8 *p = uc_log.lvl_mask;
    for (int i = 0; i < 16; i++)
        *p++ = 7;
    memset0_words_uc(uc_log.ring, sizeof(uc_log.ring));
    MMIO32(HW_RGF_USER_USAGE_2) = (u32)&uc_log;
}
/* boot_uc_set_88000c — в boot.c. */
/* vring_is_empty_uc — в boot.c. */
/* bi_mode_init_sequence — в boot.c. */
void bi_mode_load_cmd1e_operand(void)
{
    MMIO32(HW_MAC_CMD1E_OPERAND) = 0xc0a0f1e;
    uc_mac_cmd(0x1e010004);
    uc_mac_cmd(0x1e010001);
}
void bi_mode_program_mac_timing(void)
{
    MMIO32(HW_MAC_TIMING_CONST_5C) = 0x40063;
    MMIO32(HW_MAC_TIMING_CONST_60) = 0x10001;
    MMIO32(HW_MAC_TIMING_CONST_E8) = 0x60025;
    MMIO32(HW_MAC_TIMING_CONST_EC) = 0x2000b;
    MMIO32(HW_MAC_USEC_CLK_DIV) = 0x5300a5;
}
/* bf_init_globals — в bf.c. */
/* mac_set_slot_timing_886f60 — в mac.c. */
struct tx_ctx_s *tx_ctx_alloc_next(u32 a)
{
    /* 6.2 asm 0x9384d4: следующий слот; a != 0 — сделать его текущим. */
    u32 seq = tx_ctx_pool.seq + 1;
    struct tx_ctx_s *c = &tx_ctx_pool.slot[seq & 1];
    if (a != 0) {
        tx_ctx_pool.seq = seq;
        tx_ctx_pool.cur = c;
    }
    c->qid = 0xff;
    c->x20 = 0;
    c->flags = 0;
    u32 r0 = c->sta;
    c->mtp_state = 0;
    if (r0 < 8) {
        struct sta_entry *idx = &sta_tab[r0];
        if (idx->flags & 1) {
            u32 r2 = idx->omni_rx_sel;
            if ((r2 & 0x7fff00) != 0x7fff00)
                rf_chain_word = r2;
        }
    }
    u32 r0v;
    if (dti_qset_mode != 0)
        r0v = sta_tab[fsched_get_cur_idx(&fsched_peers)].rx_sel;
    else
        r0v = rf_chain_word;
    c->rf_word = r0v;
    c->x30 = 0;
    c->x1c = 0xf;
    c->x34 = 0;
    return c;
}
/* 0x936398: маски событий, два таймерных канала (0x886d3c/40, 0x886fbc/c0)
 * с уровнями IRQ 0xa/0xe и программированием MAC. */
void bi_mode_init_substep(void)
{
    u32 v;
    irq_init_event_masks();
    MMIO32(HW_MAC_BI_INIT_ZERO_28) = 0;
    mac_evt_en_shadow = 0xc;              /* st.as [gp,-18] */
    uc_mac_cmd(0x2700000c);
    uc_mac_cmd(0x2ffffff);
    uc_mac_cmd(0x49ffffff);
    MMIO32(HW_UC_SLEEP_WAKE_MASK) = 0;
    uc_irq_set_level(0xa, 1);
    MMIO32(HW_MAC_BI_INIT_ONES_40) = 0xffffffff;
    v = mac_sel_shadow & ~0xf0u;       /* ld_s [gp,-68]; bic 240 */
    mac_sel_shadow = v | (1u << 5);
    uc_mac_cmd(v | 0x1d000020);
    arc_nops(3);
    uc_mac_cmd(0x21000009);
    uc_mac_cmd(0x1ffffff);
    MMIO32(HW_MAC_BI_INIT_CONST_44) = 0x28010;
    MMIO32(HW_MAC_886FBC) = 0;
    uc_irq_set_level(0xe, 1);
    MMIO32(HW_MAC_886FC0) = 0xffffffff;
    v = mac_sel_shadow & 0xff0fffffu;
    mac_sel_shadow = v | (1u << 21);
    uc_mac_cmd(v | 0x1d200000);
    arc_nops(3);
    uc_mac_cmd(0x48ffffff);
}
void bi_mode_init_sta_table(void)
{
    bcast_ctx_qid = 0x1f;
    bcast_ctx_flags = 0x11;
    memset0_words_uc(txss_ss, SPARRAW_STA_SLOTS * sizeof(struct ss_cfg_s));
}
/* bti_clear_sweep_counters — в bti.c. */
/* mac_program_13ab6680 — в boot.c. */
/* uc_timer_start — в boot.c. */
/* uc_send_evt_ucode_ready — в boot.c. */
void uc_mailbox_init_rings(struct uc_mbox_ctx *m)
{
    /* 6.2 asm 0x9359b8: fw кладёт в [0x8802bc+0x24] указатель на пару mbox_ring_ctl —
     * [0] кольцо событий, [1] кольцо команд. Аргумент vendor не использует (адреса прямые). */
    (void)m;
    u32 r0 = uc_mailbox_ring_reg_addr();
    struct mbox_ring_ctl *ctl = *(struct mbox_ring_ctl **)(r0 + 0x24);
    if (ctl[0].base == 0)
        return;
    uc_ring_init_desc(&uc_mbox.cmd, ctl[1].base, ctl[1].size, &ctl[1], 0, 0, 0);
    uc_ring_init_desc(&uc_mbox.evt, ctl[0].base, ctl[0].size, &ctl[0], 0, 0, 0);
}
/* mac_ddc_mask_bit3 — в boot.c. */
/* irq_safe_deref_field_04 — в boot.c. */
/* uc_list_head_field4 — в uutil.c. */
/* uc_evt_enqueue (L_927958) — в evt.c-хелперах. */
/* uc_evt_enqueue — в evt.c. */
/* mac_read_tsf64_uc — в mac.c. */
/* uc_evt_queue_put — в evt.c. */
/* 1 — следующая запись не догоняет читателя (ctl->tail). */
u32 mailbox_free_space(struct uc_ring *r)
{
    struct mbox_ring_desc *next = r->cur + 1;
    if (next == r->end)
        next = r->base;
    return ((u32)next != r->ctl->tail) ? 1 : 0;
}
void mailbox_debug_dump_uc(struct uc_ring *r)
{
    uc_log_emit2(0, 0x10011e0, r->ctl->tail, r->ctl->head);
    uc_log_emit2(0, 0x1001230, (u32)r->cur, (u32)r->base);
    uc_log_emit_snapshot(0, 0x100126c);
    for (struct mbox_ring_desc *d = r->base; d < r->end; d++)
        uc_log_emit2(0, 0x100128c, d->sync, d->addr);
}
/* list_push_locked — в tail.c (0x926984). */
/* memcpy_uc — в util.c. */
/* СРОК: r55 читается не раньше 3 тактов после 0x4d000005 (аппаратный; r55 не защёлкивается — до
 * выборки там значение прежнего селектора): 5 инструкций, vendor 0x9364c8 так же; запас — единицы.
 * Все расчёты сроков от TSF (окна BI/A-BFT, rx_flow_timeout_us, uc_tsf_elapsed) несут эту задержку
 * плюс путь вызывающего от чтения до использования. */
/* L_9364c8 = uc_read_tsf_lo. */
u32 uc_read_tsf_lo(void)
{
    uc_mac_cmd(0x4d000005);   /* mailbox */
    arc_nops(3);
    u32 r0;
    r0 = arc_core_rd(55);
    return r0;
}
/* evt_queue_take_locked — в tail.c (0x926a3c). */
/* cpu_aux28_set_bits12 — в boot.c. */
/* boot_uc_init_tail — в sched.c. */
/* bf_pending_clear_bit — в bf.c. */
/* uc_assert — в misc.c (uc_sysassert). */

void uc_log_emit_snapshot(u32 a, u32 b)
{
    u32 r11 = a & 0xf;
    u32 r0 = (a >> 4) & 3;
    u8 r4 = uc_log.lvl_mask[r11];
    if (!(r4 & (1u << r0)))
        return;
    u32 sp[2];
    uc_sysassert_snapshot_mac(0, (u32)sp, 0);
    u32 r2 = (sp[1] < 0xff) ? sp[1] : 0xff;     /* min: mov.cc 0xff / mov.cs r8 */
    u32 r1 = uc_log.wr_idx;
    uc_log.ring[(u8)(r1 + 1)] = sp[0];
    u32 r3 = (b & 0xfffff) | 0xa0000000;
    r2 = ((u8)r2 << 18) | r3;
    uc_log.ring[(u8)r1] = r2;
    uc_log.wr_idx = r1 + 2;
}
void uc_log_emit3(u32 lvl, u32 token, u32 a0, u32 a1, u32 a2)
{
    /* Запись в кольцевой журнал (3 аргумента), 6.2 asm 0x92d338.
     * level = lvl&0xf (bmsk 0x3), bit = (lvl>>4)&3 (bmsk 0x1),
     * len = min(ts[1],0xff) (mov.cc/mov.cs → carry: C=0 ⟺ >=). */
    u32 r9 = lvl & 0xf;
    if (!(uc_log.lvl_mask[r9] & (1u << ((lvl >> 4) & 3))))
        return;
    u32 idx = uc_log.wr_idx;
    uc_log.ring[(u8)(idx + 4)] = a2;
    uc_log.ring[(u8)(idx + 3)] = a1;
    uc_log.ring[(u8)(idx + 2)] = a0;
    u32 ts[2];
    uc_sysassert_snapshot_mac(0, (u32)ts, 0);
    uc_log.ring[(u8)(idx + 1)] = ts[0];
    u32 hdr = (token & 0xfffff) | 0xac000000u;
    u8 len = (u8)((ts[1] >= 0xff) ? 0xff : ts[1]);
    hdr |= (u32)len << 0x12;
    uc_log.ring[(u8)idx] = hdr;   /* extb: кольцо 256 слов */
    uc_log.wr_idx = idx + 5;
}
void mac_evt_select_timer_group(u32 a)
{
    u32 r14 = 0;
    u32 cmd = ((a << 20) & 0xf00000) | 0x68000000;
    uc_mac_cmd(cmd);
    if (a < 3)
        r14 = 0x49008000;
    else if (a < 6)
        r14 = 0x49010000;
    else if (a < 0xa)
        r14 = 0x49020000;
    else {
        uc_assert((u32)__builtin_return_address(0), 0x69);
        r14 = 0x49000000;
    }
    uc_mac_cmd(r14);
}
/* СРОК: общее ожидание r42 с тайм-аутом: 0x23010000|b взводит GP-таймер, 0x02000200 добавляет
 * gp_timers_event (б9); 3 инструкции (2×nop + mov 0,0) до первого опроса — чтобы не увидеть б9
 * прошлого тайм-аута (аппаратный). Опрос 3 инструкции на проход (vendor 0x9366e8: 2); при b = 0 —
 * без ограничения. Запас — единицы инструкций. Срыв: ложный тайм-аут или зависание при b = 0. */
u32 uc_wait_event_busy(u32 a, u32 b)
{
    u32 r2;
    if (arc_core_rd(42) & a)
        return 1;
    if (b == 0) {
        r2 = a;
    } else {
        uc_mac_cmd(b | 0x23010000);
        uc_mac_cmd(0x2000200);
        r2 = a | 0x200;
        arc_nops_nop(2);   /* vendor: до опроса r42 */
    }
    while (!(arc_core_rd(42) & r2))
        ;
    return ((arc_core_rd(42) & a) != 0) ? 1 : 0;
}
