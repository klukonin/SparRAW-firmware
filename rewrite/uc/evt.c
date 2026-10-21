// SPDX-License-Identifier: AGPL-3.0-or-later
/* Отправка событий ucode -> fw (uc_send_evt__*). */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/hw.h"


void uc_send_evt_mac_monitor(u32 a)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    *(u32 *)evt = a;
    uc_evt_enqueue(evt, 0x17, 4, 0);
}

void uc_send_evt_ps_awake_peer(u32 a)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    memcpy_uc((void *)evt, (const void *)a, 0xc);
    uc_evt_enqueue(evt, 0x16, 0xc, 0);
}

/* Отчёт BF (0x9275a8) / новый линк (0x9276bc): структура 0x44 Б передаётся по
 * значению — слова 0..7 в r0..r7, 8..16 на стеке вызывающего (ABI GCC = vendor). */
static void uc_send_evt_report44(u32 type, const u32 *w)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    memcpy_uc((void *)evt, w, 0x44);
    uc_evt_enqueue(evt, type, 0x44, 0);
}

void uc_send_evt_bf_done(u32 w0, u32 w1, u32 w2, u32 w3, u32 w4, u32 w5, u32 w6, u32 w7,
                         u32 w8, u32 w9, u32 w10, u32 w11, u32 w12, u32 w13, u32 w14, u32 w15, u32 w16)
{
    u32 w[17] = {w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16};
    uc_send_evt_report44(0x6, w);
}

void uc_send_evt_get_rf_sector_done(u32 a)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    memcpy_uc((void *)evt, (const void *)a, 0x10);
    uc_evt_enqueue(evt, 0x27, 0x10, 0);
}

void uc_send_evt_link_lost(const void *a)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    memcpy_uc((void *)evt, a, 0xc);
    uc_evt_enqueue(evt, 0x9, 0xc, 0);
}

void uc_send_evt_new_link(u32 w0, u32 w1, u32 w2, u32 w3, u32 w4, u32 w5, u32 w6, u32 w7,
                         u32 w8, u32 w9, u32 w10, u32 w11, u32 w12, u32 w13, u32 w14, u32 w15, u32 w16)
{
    u32 w[17] = {w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16};
    uc_send_evt_report44(0x5, w);
}

void uc_send_evt_rs_done(const void *a)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    memcpy_uc((void *)evt, a, 0x30);
    uc_evt_enqueue(evt, 0x14, 0x30, 0);
}

void uc_send_evt_rs_started(u32 a)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    *(u32 *)evt = a;
    uc_evt_enqueue(evt, 0x13, 4, 0);
}

void uc_send_evt_set_rf_sector_done(u32 a)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    memcpy_uc((void *)evt, (const void *)a, 4);
    uc_evt_enqueue(evt, 0x28, 4, 0);
}

void uc_send_evt_sta_update_field_rsp(u32 a, u32 b)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    struct lmac_evt_field_rsp *e = (struct lmac_evt_field_rsp *)evt;
    e->cid = a;
    e->type = b;
    uc_evt_enqueue(evt, 0x11, sizeof(*e), 0);
}

void uc_send_evt_typed(u32 a, u32 b)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    struct lmac_evt_typed *e = (struct lmac_evt_typed *)evt;
    e->w0 = uc_read_tsf_lo();
    e->val = b;
    uc_evt_enqueue(evt, (u16)a, sizeof(*e), 0);
}

/* uc_evt__send_XX — отправка типовых событий uc->fw. */



void uc_evt_send_2c_tsf(u32 a, u32 b, u32 c)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    struct uc_evt_pmc *e = (struct uc_evt_pmc *)evt;
    e->stop = a;
    e->tag = c;
    e->tsf = uc_read_tsf_lo();
    e->n_events = b;
    uc_evt_enqueue(evt, 0x2c, sizeof(*e), 0);
}

void uc_evt_send_30(const u32 *a)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    struct lmac_evt_typed *e = (struct lmac_evt_typed *)evt;
    e->w0 = a[0];
    e->val = a[1];
    uc_evt_enqueue(evt, 0x30, sizeof(*e), 0);
}

void uc_evt_send_29_sync(u32 a)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    *(u32 *)evt = *(u32 *)a;
    uc_evt_enqueue(evt, 0x29, 4, 0);
    evt_queue_take_locked(&uc_mbox, evt, 0, 0);
}

void uc_evt_send_2b(u8 a)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    *(u8 *)evt = a;
    uc_evt_enqueue(evt, 0x2b, 1, 0);
}

void uc_evt_send_20(u32 a)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    *(u32 *)evt = a;
    uc_evt_enqueue(evt, 0x20, 4, 0);
}

void uc_evt_send_23(u32 src)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    memcpy_uc((void *)evt, (const void *)src, 0x24);
    uc_evt_enqueue(evt, 0x23, 0x24, 0);
}

void uc_evt_send_26(u32 a)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    *(u32 *)evt = a;
    uc_evt_enqueue(evt, 0x26, 4, 0);
}

void uc_evt_send_21(u8 a0, const void *a1)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    *(u8 *)evt = a0;                  /* stb.ab r14,[r0,4]: пишет в evt+0, затем r0+=4 */
    memcpy_uc((void *)(evt + 4), a1, 0x20);
    uc_evt_enqueue(evt, 0x21, 0x24, 0);
}

void uc_evt_send_2e(u32 a, u32 b, u32 c)
{
    u32 evt = irq_safe_deref_field_04(&uc_mbox);
    struct lmac_evt_ba_timeout *e = (struct lmac_evt_ba_timeout *)evt;
    e->vr = (u8)a;
    e->kind = (u8)b;
    e->ssn = (u16)c;
    uc_evt_enqueue(evt, 0x2e, sizeof(*e), 0);
}

/* Получить поле 0x4 очереди событий (0x927320). */
u32 uc_evt_queue_peek_field04(void)
{
    return irq_safe_deref_field_04(&uc_mbox);
}


/* Постановка события в очередь (0x927958). */
void uc_evt_enqueue(u32 evt, u32 type, u32 size, u32 a)
{
    u32 tsf[2];
    mac_read_tsf64_uc(tsf);
    uc_evt_queue_put(&uc_mbox, evt, type, 0, size, a, 0, 0, 0);
    MMIO32(HW_RGF_USER_USER_ICR_ICS) = 0x200;
    arc_sync();
}

/* Постановка в кольцевой буфер событий (0x9349dc) — портировано. */

/* Заполнить заголовок записи события evt (тело уже на месте), опубликовать её и сообщить fw
 * новую позицию писателя. len > ctl->entry_size допустим только при c или d. */
void uc_evt_queue_put(struct uc_mbox_ctx *m, u32 evt, u32 type, u32 cmd_id, u32 len, u32 mid, u32 c, u32 d, u32 e)
{
    /* 6.2 asm 0x9349dc. */
    if (evt == 0)
        uc_assert((u32)__builtin_return_address(0), 0xc3);
    if (mailbox_free_space(&m->evt) == 0) {
        mailbox_debug_dump_uc(&m->evt);
        uc_assert((u32)__builtin_return_address(0), 0xc4);
    }
    struct uc_evt_hdr *h = (struct uc_evt_hdr *)(evt - sizeof(struct uc_evt_hdr));
    struct mbox_ring_ctl *ctl = m->evt.ctl;
    if ((s32)ctl->entry_size < (s32)len && c == 0 && d == 0)   /* brge; breq r14; brne r13 */
        uc_assert((u32)__builtin_return_address(0), 0xc5);
    h->type = (u16)type;
    h->seq = m->evt_seq;
    h->len = (u16)len;
    h->len_lo = (u8)len;
    h->mid = (u8)mid;
    h->_9 = 0;
    h->cmd_id = (u16)cmd_id;
    h->ts = 0;
    h->flags = ((c & 1u) << 1) | ((d & 1u) << 2) | ((e & 1u) << 3);
    m->evt_seq++;
    list_push_locked(&m->evt, (u32)h);
    ctl->head = (u32)m->evt.cur;
}
