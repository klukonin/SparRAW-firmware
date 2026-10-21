/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Индексы кольца DMA-дескрипторов (32 Б каждый) — общие для колец TX (include/fwq_tx.h) и
 * RX (include/rx_ring.h): tx_desc_by_index, tx_ring_advance_index, rx_pool_set_fields. */
#ifndef RING_IDX_H
#define RING_IDX_H
#include "types.h"

struct ring_idx {
    u32 base;                                  /* 0x00: база дескрипторов */
    u32 size;                                  /* 0x04: число дескрипторов */
    u32 tail;                                  /* 0x08 */
    u32 head;                                  /* 0x0c */
};
_Static_assert(sizeof(struct ring_idx) == 0x10, "ring_idx");

#endif
