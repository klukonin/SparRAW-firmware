// SPDX-License-Identifier: AGPL-3.0-or-later
/* Утилиты uCode (uc_*): divmod, сдвиги, IRQ, события, ring, ap/tsf. */
#include "../include/types.h"
#include "../include/arc.h"

#include "../include/hw.h"


/* 64-битный сдвиг влево (0x920458). */


/* Голова списка: [[a] + 4] (0x920da4). */
u32 uc_list_head_field4(struct uc_ring *r)
{
    return r->cur->addr;
}

/* Косвенное [a+0x24] == 0 (0x920dac). */
/* 1 — в кольце команд есть запись. */
u32 uc_field_0x24_is_zero(struct uc_mbox_ctx *m)
{
    /* 0x920dac */
    return uc_indirect_is_zero(&m->cmd) == 0;
}

/* (u8)(aux[5] >> 3) — триггерная маска AP (0x920f9c). */
u8 uc_ap_read_triggered_mask(void)
{
    return (u8)(arc_lr(5) >> 3);
}

/* aux[a*2 + 0x220] — значение совпадения AP (0x920fa8). */
u32 uc_ap_read_match_value(u32 a)
{
    return arc_lr(a * 3 + 0x220);   /* add1_s r0,r0,r0 = ×3 */
}

/* Установка уровня IRQ (0x921018). */
void uc_irq_set_level(u32 a, u32 b)
{
    /* 6.2 asm 0x921018: bclr + (b << a) без маски b; сдвиг — младшие 5 бит. */
    u32 v = arc_lr(0x200);
    v = (v & ~(1u << (a & 31))) | (b << (a & 31));
    arc_sr(v, 0x200);
}

/* Истёкшее TSF (0x92483c). */
u32 uc_tsf_elapsed(u32 a)
{
    return uc_read_tsf_lo() - a;
}

/* Косвенная проверка на ноль (0x92be20). */
/* 1 — текущая запись кольца пуста. */
u32 uc_indirect_is_zero(struct uc_ring *r)
{
    /* 0x92be20 */
    return r->cur->sync == 0;
}

/* Голова очереди: [[a] + 4] (0x927f64). */
u32 uc_queue_peek_head_word1(struct uc_ring *r)
{
    return r->cur->addr;
}

/* Запись кода ошибки в 0x884804 (0x929d04). */
void uc_sysassert_write_code(u32 a)
{
    MMIO32(HW_UC_ASSERT_CODE) = a << 4;
}

/* Адрес ring-регистра mailbox (0x92a6dc). */
u32 uc_mailbox_ring_reg_addr(void)
{
    return HW_RGF_USER_USER_SCRATCH_PAD;
}

/* Инициализация ring-дескриптора (0x92adf0). */
void uc_ring_init_desc(struct uc_ring *r, u32 base, u32 size, struct mbox_ring_ctl *ctl, u32 e, u32 f, u32 g)
{
    (void)f;
    r->cur = (struct mbox_ring_desc *)base;
    r->base = (struct mbox_ring_desc *)base;
    r->end = (struct mbox_ring_desc *)(base + size);
    r->ctl = ctl;
    r->arg_e = e;
    r->arg_g = g;
    r->_18 = 0;
    r->_1c = 0;
}

/* Ожидание одного события (0x936588). */
void uc_wait_one_event(u32 a)
{
    uc_wait_two_events(a, a, 0);
}

/* СРОК: опрос r54 3 инструкции на проход (vendor 0x9366d0: 3), без ограничения (конец GP-таймера
 * окна BI/слота). Срыв: зависание, если таймер не взведён. */
/* Spin до события aux r54 (0x9366d0). */
void uc_spin_until_event4(u32 a)
{
    u32 v;
    do {
        v = arc_core_rd(54);
    } while (!(v & a));
}

/* Диспетчер L1-события по режиму 0x8004f4 (0x92cd0c, зовётся из l1_task_entry(2)):
 * 0 → l1_on_event4, 1/2 → l1_fixed_sched_event_entry (хвостовые переходы), иначе ничего. */
void uc_check_g8004f4_0_1_2(void)
{
    u32 v = dti_qset_mode;
    if (v == 0)
        l1_on_event4();
    else if (v == 1 || v == 2)
        l1_fixed_sched_event_entry();
}

/* Установка evt-id 0x5c (0x921724): a==0 → 0xffffffff, иначе 0x39, в 0x800584
 * под блокировкой IRQ. */
void uc_set_evt_id_5c(u32 a)
{
    u32 saved = arc_irq_disable();
    bg_task_mask = (a == 0) ? 0xffffffff : 0x39;
    arc_irq_restore(saved);
}

/* Состояние TX (0x93c658): 0x8005bc==0 или 0x800588!=0 → 0 (не idle),
 * иначе pending-check → 1. */
u32 uc_tx_is_idle(void)
{
    if (rx_on_state == 0)         /* [gp,0x94] (ldw_s, 16-bit) */
        return 0;
    if (rx_listen_active != 0)         /* [gp,0x60] (ld_s, 32-bit) */
        return 0;
    qset1_mask_any_pending_uc(1);
    return 1;
}


/* СРОК: как mac_evt_enable_bit_sync (3 nop после 0x02004200 до опроса r42.14), но с тайм-аутом c
 * GP-таймера (uc_wait_event_busy); vendor 0x936594 так же; запас — единицы инструкций. */
/* Ожидание двух событий (0x936594). */
void uc_wait_two_events(u32 a, u32 b, u32 c)
{
    u32 mask = (1u << a) | (1u << b);
    u32 v = ((mask ^ 0x7f) << 8) | 0x27000000;
    uc_mac_cmd(mac_evt_en_shadow | v);
    uc_mac_cmd(0x2004200);
    arc_nops(3);
    uc_wait_event_busy(1u << 14, c);
}

/* СРОК: проверка r42 & a и «sleep» разделены ~16 инструкциями (тайм-аут 0x23/0x02, маска
 * пробуждения 0x886d3c, 0x21000002, сохранение ilink2); событие в этом окне разбудит ядро, только
 * если пробуждение — по уровню маски 0x886d3c (не проверено). На пути TX→ожидание busy2 (tx.c,
 * тайм-аут 0xa). vendor 0x93676c — тот же порядок; запас не определён. Срыв: сон до тайм-аута GP
 * (при b = 0 — без конца). */
/* Сон до события (0x93676c). */
void uc_sleep_until_event(u32 a, u32 b)
{
    if (arc_core_rd(42) & a)
        return;
    if (b != 0) {
        uc_mac_cmd(b | 0x23010000);
        uc_mac_cmd(0x2000200);
        a |= 1u << 9;
    }
    *(volatile u32 *)HW_UC_SLEEP_WAKE_MASK = a;
    uc_mac_cmd(0x21000002);
    sleep_evt_arg = a;
    sleep_ilink2 = arc_core_rd(30);   /* ilink2 (vendor: st.as r30,[gp,-40]) */
    __asm__ volatile("nop_s\n\tsleep 0");
    *(volatile u32 *)HW_UC_SLEEP_WAKE_MASK = 0;
}

/* Чтение BI-синхронизации (0x936b60). */
u32 uc_read_bi_sync(void)
{
    u32 r0 = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = r0 | (1u << 14);
    uc_mac_cmd(r0 | 0x1d004000u);
    arc_nops(3);
    return arc_core_rd(40) >> 31;              /* lsr r0,r40,0x1f */
}

/* Счётчик BI в окне (0x937474). */
u32 uc_bi_counter_in_window(u32 a)
{
    (void)a;
    u32 r2 = mac_sel_shadow & 0xffff0fff;
    mac_sel_shadow = r2 | (1u << 14);
    uc_mac_cmd(r2 | 0x1d004000);
    arc_nops(3);
    u32 r1 = arc_core_rd(40) & 0x3ffffff;
    bi_pos_us = r1;
    u32 r3 = bcn_bi.bi_len_us - 25;
    return !(r3 >= r1 && r1 >= 0x9c4);
}

/* Голосование за ресурс: захват (0x92bac8). */
void uc_res_vote_acquire(u32 a)
{
    /* 6.2 asm 0x92bac8. */
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    if (res_vote_mask == 0) {
        qset_enable_mask = qset_enable_mask & ~0x70;
        mac_publish_masks();
    }
    res_vote_mask |= 1u << a;
    uc_mac_cmd(0x81 << 18);
    arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
}

/* Голосование за ресурс: освобождение (0x92bb94). */
void uc_res_vote_release(u32 a)
{
    /* 6.2 asm 0x92bb94. */
    u32 saved = arc_lr(ARC_STATUS32);
    arc_flag(saved & ~(1u << 1));
    u32 r1 = res_vote_mask & ~(1u << a);
    res_vote_mask = r1;
    if (r1 == 0) {
        qset_enable_mask = qset_enable_mask | 0x70;
        mac_publish_masks();
        bi_tx_check_idle_and_start_uc(2);
    }
    arc_flag((saved & (1u << 1)) | arc_lr(ARC_STATUS32));
}

/* State-machine: обработка события (0x92b6fc). */
/* Автомат (BI и др.): obj = {u8 состояние, ..., +4 дескриптор}. Запись таблицы —
 * {действие, следующее состояние}, индекс = состояние + n_states × событие. Новое
 * состояние записывается до вызова действия (хвостовой вызов). */
u32 uc_sm_handle_event(struct sm_obj *obj, u32 ev, u32 a2)
{
    const struct sm_desc *desc = obj->desc;
    u32 state = obj->state;
    const struct bi_sm_entry *e = (const struct bi_sm_entry *)desc->table + state + desc->n_states * ev;
    obj->state = e->next;
    return ((u32 (*)(u32, u32, u32, u32))e->action)((u32)obj, a2, 0, 0);
}

/* Вход в idle (0x93c7d4). */
void uc_pm_enter_idle(u32 a)
{
    mac_read_tsf64_uc(pm_idle_tsf);
    rx_listen_active = 0;
    mac_mode_enter_idle_seq(a);
    uc_mac_cmd(0x20c0010);
    u32 r0 = pm_idle_enter_cnt + 1;
    pm_idle_enter_cnt = r0;
    FWSH(fw_stats_dash, pm_idle_cnt) = r0;
}

/* Флаг занятости PM (0x93c874). */
void ucode_pm_set_busy_flag(u32 a)
{
    pm_busy = a;
    if (a != 0)
        ucode_pm_stamp_tsf_slots();
}

/* Штампование TSF-слотов (0x93c7a8). */
void ucode_pm_stamp_tsf_slots(void)
{
    for (u32 r13 = 0; r13 < 8; r13++) {
        struct link_stat_s *r15 = &link_stat[r13];
        u32 tsf = uc_read_tsf_lo();
        r15->ka_ok = 0;                  /* stw_s r0(=0),[r15,2] в delay-слоте */
        r15->stamp_tsf = tsf;
    }
}

/* СРОК: селектор r47[0] → 3 инструкции (2×nop + mov 0,0) → опрос DIRECT_TX_CMD_STATUS.cmd_ready
 * (r47.0) без ограничения, на пути подачи direct-TX кадра (BRP, SSW, CF-End) между командами 0x33;
 * vendor 0x925874 так же; запас по задержке выборки — единицы инструкций. Срыв: чтение r47 прежней
 * группы (ложная готовность) или зависание. */
/* Ожидание готовности direct-TX (0x925874). */
void uc_wait_direct_tx_ready(void)
{
    u32 r0 = mac_sel_shadow & 0xfff0ffff;
    mac_sel_shadow = r0;
    uc_mac_cmd(r0 | 0x1d000000u);
    arc_nops_nop(2);
    u32 v;
    do {
        v = arc_core_rd(47);
    } while (!(v & 1u));
}

/* Инициализация глобалов (0x92094c). */
void uc_init_globals(struct fsched_peer_ctx *p)
{
    /* 6.2 asm 0x92094c */
    memset0_words_uc(p->ent, sizeof(p->ent));
    p->cur_idx = 0;
    p->active_mask = 0;
    p->pend_off_qid = 0xff;
}

/* memset: gcc сам вставляет вызов для инициализации локальных массивов/структур.
 * no-tree-loop-distribute-patterns — чтобы цикл не превратился обратно в memset. */
__attribute__((optimize("no-tree-loop-distribute-patterns")))
void *memset(void *d, int c, unsigned int n)
{
    u8 *p = d;
    while (n--)
        *p++ = (u8)c;
    return d;
}
