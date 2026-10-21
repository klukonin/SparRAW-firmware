// SPDX-License-Identifier: AGPL-3.0-or-later
/* Ящики хоста/ucode (include/mbox.h): экземпляры в DCCM, инициализация ящика хоста —
 * mbox__init_descriptor (0x8f942c), возврат буферов WMI-событий и RX-кадров. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/fwdata.h"
#include "../include/mbox.h"
#include "../include/rx_ring.h"

/* Ящики в DCCM (include/mbox.h); в образе нули, таблицы методов ставят конструкторы
 * (fw/ctors.c) и функции инициализации (fw/stubs.c, fw/lmac.c). Отладочный ящик 0x843040 —
 * вне DCCM (fw/fw.ld). */
/* vendor 0x8041f0 */
FWDATA(8041f0) struct operational_mbox operational_mbox = { 0 };
/* vendor 0x804280 */
FWDATA(804280) struct lmac_mbox lmac_mbox = { 0 };


/* --- WMI-события: освобождение --- */

/* mem_pool__put_block (0x8c6414): снятие RX-кольца было остановлено (пул исчерпан) —
 * снова разрешить его прерывание. */
void mem_pool_put_block(struct rx_ring *o)
{
    if (mem_pool_get_field14(&o->ring))
        tx_api_mask_from_queue(&o->ring);
}

/* 0x8cb19c: вернуть RX-кадр в пул RX-кольца. */
void mem_pool_free_8cb19c(u32 obj)
{
    stream_mgr_check_vring(&rx_ring.pool, (void *)obj);   /* obj — по контракту free_cb (u32) */
    mem_pool_put_block(&rx_ring);
}

/* Колбэк освобождения WMI-события (0x8cb07c). */
void wmi_evt_alloc_and_fill(u32 a0)
{
    if (a0 == 0)
        fw_sysassert_fatal((void *)0, 0x1003);
    mem_pool_free_8cb19c(a0 - 0x28);
}

/* mbox__init_descriptor (0x8f942c): ящик хоста m — описатели колец hw[0] (команды хоста,
 * кольцо rx) и hw[1] (события, кольцо tx), записи rx_n/tx_n штук, пулы буферов. desc —
 * vendor-аргументы на стеке ([sp,0x24..0x30] после сохранения регистров): [0]/[1] — число
 * буферов rx/tx, [2]/[3] — их размер. */
void mbox_init_descriptor(struct wmi_mbox *m, struct mbox_ring_hw *hw, u32 rx_base, u32 tx_base,
                          void *rx_buf, void *tx_buf, u32 rx_n, u32 tx_n, u32 desc[4])
{
    u32 rx_len = rx_n * 8;
    u32 tx_len = tx_n * 8;

    hw[0].base = rx_base;
    hw[0].tail = rx_base;
    hw[0].head = rx_base;
    hw[0].size = (u16)rx_len;
    hw[0].entry_size = (u16)desc[2];

    mem_pool_init(&m->rx_pool, rx_buf, desc[2], desc[0]);  /* add3 r20,r14,0x9 → +0x48 */
    ring_init_desc(&m->mb.rx, (struct mbox_entry *)rx_base, rx_len, &hw[0], &m->rx_pool, 1, 1);

    hw[1].base = tx_base;
    hw[1].tail = tx_base;
    hw[1].head = tx_base;
    hw[1].size = (u16)tx_len;
    hw[1].entry_size = 0x510;

    mem_pool_init(&m->tx_pool, tx_buf, desc[3], desc[1]);  /* add2 r17,r14,0x17 → +0x5c */
    ring_init_desc(&m->mb.tx, (struct mbox_entry *)tx_base, tx_len, &hw[1], &m->tx_pool, 0, 1);  /* add r16,r14,0x4 */

    /* Колбэки возврата буферов событий — в кольцо tx ([r16,0x18]/[r16,0x1c]). Прежде писались
     * в m[10]/m[11] — это rx.base/rx.end (0x804218/0x80421c), ломало wrap курсора. */
    m->mb.tx.free_cb = wmi_evt_alloc_and_fill;
    m->mb.tx.free_cb2 = tx_api_free_memory;
    /* vendor 0x8f94cc..0x8f94d6: [mbox+0x70] = 3-й, [mbox+0x74] = 4-й элемент desc. Прежде
     * писались desc[1]/desc[2] (сдвиг на одно слово). */
    m->rx_entry_size = desc[2];
    m->tx_entry_size = desc[3];

    /* vt[2]: снять маску своего бита user-ICR — 18 у operational, 19 у debug. Прежде здесь
     * всегда писалось 0x80000 (бит 19), и прерывание команд хоста (бит 18) не
     * размаскировалось никогда. */
    m->vt->unmask_irq(m);
}
