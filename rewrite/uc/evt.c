// SPDX-License-Identifier: AGPL-3.0-or-later
/* Отправка событий ucode -> fw (uc_send_evt__*). */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/hw.h"
#include "dbg.h"


void uc_send_evt_mac_monitor(u32 a)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    *(u32 *)evt = a;
    uc_evt_enqueue(evt, 0x17, 4, 0);
}

void uc_send_evt_ps_awake_peer(u32 a)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    memcpy_uc((void *)evt, (const void *)a, 0xc);
    uc_evt_enqueue(evt, 0x16, 0xc, 0);
}

void uc_send_evt_get_rf_sector_done(u32 a)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    memcpy_uc((void *)evt, (const void *)a, 0x10);
    uc_evt_enqueue(evt, 0x27, 0x10, 0);
}

void uc_send_evt_link_lost(const void *a)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    memcpy_uc((void *)evt, a, 0xc);
    uc_evt_enqueue(evt, 0x9, 0xc, 0);
}

void uc_send_evt_rs_done(const void *a)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    memcpy_uc((void *)evt, a, 0x30);
    uc_evt_enqueue(evt, 0x14, 0x30, 0);
}

void uc_send_evt_rs_started(u32 a)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    *(u32 *)evt = a;
    uc_evt_enqueue(evt, 0x13, 4, 0);
}

void uc_send_evt_set_rf_sector_done(u32 a)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    memcpy_uc((void *)evt, (const void *)a, 4);
    uc_evt_enqueue(evt, 0x28, 4, 0);
}

void uc_send_evt_sta_update_field_rsp(u32 a, u32 b)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    struct lmac_evt_field_rsp *e = (struct lmac_evt_field_rsp *)evt;
    e->cid = a;
    e->type = b;
    uc_evt_enqueue(evt, 0x11, sizeof(*e), 0);
}

void uc_send_evt_tsf_val(u32 a, u32 b)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    struct lmac_evt_typed *e = (struct lmac_evt_typed *)evt;
    e->w0 = uc_read_tsf_lo();
    e->val = b;
    uc_evt_enqueue(evt, (u16)a, sizeof(*e), 0);
}

/* uc_evt__send_XX — отправка типовых событий uc->fw. */



void uc_evt_send_pmc(u32 a, u32 b, u32 c)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    struct uc_evt_pmc *e = (struct uc_evt_pmc *)evt;
    e->stop = a;
    e->tag = c;
    e->tsf = uc_read_tsf_lo();
    e->n_events = b;
    uc_evt_enqueue(evt, 0x2c, sizeof(*e), 0);
}

void uc_evt_send_sp_slots_reload(u32 a)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    *(u32 *)evt = *(u32 *)a;
    uc_evt_enqueue(evt, 0x29, 4, 0);
    evt_queue_take_locked(&uc_mbox, evt, 0, 0);
}

void uc_evt_send_channel_estimation(u8 a)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    *(u8 *)evt = a;
    uc_evt_enqueue(evt, 0x2b, 1, 0);
}

void uc_evt_send_energy_stats_ready(u32 a)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    *(u32 *)evt = a;
    uc_evt_enqueue(evt, 0x20, 4, 0);
}

void uc_evt_send_rx_pkt_data(u32 src)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    memcpy_uc((void *)evt, (const void *)src, 0x24);
    uc_evt_enqueue(evt, 0x23, 0x24, 0);
}

void uc_evt_send_phy_stats_ready(u32 a)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    *(u32 *)evt = a;
    uc_evt_enqueue(evt, 0x26, 4, 0);
}

void uc_evt_send_plcp_header_ready(u8 a0, const void *a1)
{
    u32 evt = uc_evt_write_slot(&uc_mbox);
    *(u8 *)evt = a0;                  /* stb.ab r14,[r0,4]: пишет в evt+0, затем r0+=4 */
    memcpy_uc((void *)(evt + 4), a1, 0x20);
    uc_evt_enqueue(evt, 0x21, 0x24, 0);
}

/* Получить поле 0x4 очереди событий (0x927320). */
u32 uc_mbox_evt_write_slot(void)
{
    return uc_evt_write_slot(&uc_mbox);
}


/* Поставить событие в кольцо uc → fw: тело уже в слоте evt (uc_evt_write_slot), за ним — заголовок uc_evt_hdr.
 *
 * Стенд 2026-10-29 (метки STAMP_EVT): прежний путь (vendor 0x927958 → 0x9349dc → 0x926984) — 2,5–3 мкс на событие,
 * событие 0x17 (монитор MAC) идёт сотнями в секунду, на завершении BF — по одному-два. Дорого чтение памяти fw
 * (0x84xxxx, ~30 тактов), запись — нет. Здесь одно такое чтение (позиция читателя ctl->tail) вместо трёх:
 *  - предел тела ctl->entry_size fw задаёт константой — проверен один раз в uc_mailbox_init_rings;
 *  - флаг sync текущей записи не перечитывается: fw снимает его до сдвига tail (fw/lmac.c), поэтому «следующая
 *    запись не догоняет tail» (проверка ниже) уже значит, что текущая свободна;
 *  - чтение 64-битного TSF, которое vendor делал и выбрасывал (поле ts заголовка = 0), убрано.
 * Заголовок пишется 4 словами. Публикация (seq, sync, курсор) — с запрещёнными прерываниями, как у vendor. */
void uc_evt_enqueue(u32 evt, u32 type, u32 size, u32 mid)
{
    struct uc_ring *r = &uc_mbox.evt;
    struct mbox_ring_desc *cur = r->cur;
    struct mbox_ring_desc *next = cur + 1;
    if (next == r->end)
        next = r->base;
    if ((u32)next == r->ctl->tail) {
        mailbox_debug_dump_uc(r);
        uc_assert((u32)__builtin_return_address(0), 0xc4);
    }
    u32 *h = (u32 *)(evt - sizeof(struct uc_evt_hdr));
    u32 saved = arc_irq_disable();
    u32 seq = uc_mbox.evt_seq;
    h[0] = (seq & 0xffff) | size << 16;                 /* seq, len */
    h[1] = (type & 0xffff) | (size & 0xff) << 24;       /* type, flags = 0, len_lo */
    h[2] = mid & 0xff;                                  /* mid, _9 = 0, cmd_id = 0 */
    h[3] = 0;                                           /* ts */
    uc_mbox.evt_seq = seq + 1;
    cur->sync = 1;
    r->cur = next;
    arc_irq_restore(saved);
    r->ctl->head = (u32)next;
    MMIO32(HW_RGF_USER_USER_ICR_ICS) = 0x200;
    arc_sync();
    UC_STAMP(STAMP_EVT, 1u << 16 | type, 0);
}
