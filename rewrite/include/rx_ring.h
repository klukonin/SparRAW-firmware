/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* RX-кольцо DMA с пулом буферов (fw/rx.c, fw/rx_chain.c, fw/mbox.c, fw/l2mgr.c): объект
 * 0x805fe4 (0x30 Б), таблица методов 0x800714. Раскладка — как у vendor 6.2. */
#ifndef RX_RING_H
#define RX_RING_H
#include "types.h"
#include "llist.h"
#include "mem_pool.h"
#include "ring_idx.h"

#define RXR_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

/* Кольцо дескрипторов (+4 в rx_ring; аргумент fwq_tx__handle_completion 0x8cc7c4). */
struct rx_dma_ring {
    struct ring_idx r;                         /* 0x00: дескрипторы 32 Б, хвост — снимаемый */
    u32 dma_ring;                              /* 0x10: номер кольца DMA (4) */
    u32 pended;                                /* 0x14: 1 — снятие остановлено («RING PENDED»,
                                                *       пул исчерпан); mem_pool__put_block
                                                *       по нему снимает маску кольца */
};
RXR_OFF(struct rx_dma_ring, dma_ring, 0x10);
_Static_assert(sizeof(struct rx_dma_ring) == 0x18, "rx_dma_ring");

struct rx_ring;

/* Таблица методов (vendor 0x800714). */
struct rx_ring_vt {
    u32 rsv0;
    void (*drain)(struct rx_ring *o, struct llist *list);  /* [1] fwq_tx__handle_completion_thunk */
};

/* Объект RX-кольца (vendor 0x805fe4). */
struct rx_ring {
    const struct rx_ring_vt *vt;               /* 0x00 */
    struct rx_dma_ring ring;                   /* 0x04 */
    struct mem_pool pool;                      /* 0x1c: RX-буферы (0xc × 0x538, 0x84a940);
                                                *       pool.used — число занятых */
};
RXR_OFF(struct rx_ring, ring, 0x04);
RXR_OFF(struct rx_ring, pool, 0x1c);
_Static_assert(sizeof(struct rx_ring) == 0x30, "rx_ring");

/* Экземпляр и таблица методов (DCCM, fw/rx.c). */
extern struct rx_ring rx_ring;                 /* 0x805fe4 */
extern const struct rx_ring_vt rx_ring_vtbl;   /* 0x800714 */

#endif
