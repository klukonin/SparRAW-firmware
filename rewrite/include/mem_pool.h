/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Пул фиксированных блоков (fw/pool.c): count блоков по elem_size байт, свободные связаны в
 * односвязный список (голова — free_head, в свободном блоке слово 0 — следующий). Раскладка —
 * как у vendor 6.2 (0x14 Б): mem_pool__init 0x8c7cf8, mem_pool__allocate 0x8c354c, проверяющий
 * mem_pool__free 0x8caed0 (у нас stream_mgr_check_vring; mem_pool_free — без проверок). */
#ifndef MEM_POOL_H
#define MEM_POOL_H
#include "types.h"

struct mem_pool {
    void *free_head;  /* 0x00: первый свободный блок (0 — пул пуст) */
    u8 *base;         /* 0x04: начало памяти блоков */
    u32 elem_size;    /* 0x08: размер блока, Б */
    u32 used;         /* 0x0c: число выданных блоков (== count — пул исчерпан) */
    u32 count;        /* 0x10: число блоков */
};
_Static_assert(__builtin_offsetof(struct mem_pool, used) == 0x0c, "mem_pool.used");
_Static_assert(sizeof(struct mem_pool) == 0x14, "mem_pool");

/* Пулы по фиксированным адресам: DCCM — FWDATA (fw/pool.c, vring_rec_pool — fw/vring.c), вне
 * DCCM — символы fw/fw.ld. В скобках — где пул инициализируется. */
extern struct mem_pool sm_defer_pool;       /* 0x803cbc: отложенные события автоматов (stubs.c) */
extern struct mem_pool dband_info_pool;     /* 0x805524: dband-info 0x10 × 0x4c (mid.c) */
extern struct mem_pool bcon_info_pool;      /* 0x805a98: post-send-info бикона 8 × 0x14 (stubs.c) */
/* Post-send-info бикона (0x14 Б; add_bcon → bcon_post_send_cb → lmac_if_send_bcon_mgt). */
struct bcon_post_info {
    u32 cfg;                                   /* 0x00: б1 — PCP запущен (bss.state == 2) */
    union {
        u8  bi_ctrl[6];                        /* 0x04: Beacon Interval Control */
        u32 bi_ctrl_w[2];                      /* 0x04: им же словами (w0/w1 команды) */
    };
    u32 bi_mode;                               /* 0x0c: 1 */
    const u8 *mac;                             /* 0x10: 0 — без MAC */
};
_Static_assert(__builtin_offsetof(struct bcon_post_info, bi_mode) == 0xc, "bcon_post_info.bi_mode");
_Static_assert(sizeof(struct bcon_post_info) == 0x14, "bcon_post_info");
extern struct bcon_post_info bcon_info_static;  /* 0x805aac: ячейка post-send-info при пустом пуле */
extern struct bcon_post_info bcon_info_mem[8];  /* 0x8059f8: память bcon_info_pool */
extern struct mem_pool vring_rec_pool;      /* 0x804da8: записи vring 9 × 0x28 (vring.c) */
extern struct mem_pool scan_ch_pool;        /* 0x842c74: элементы списка каналов 10 × 0xc (l2mgr.c) */
extern struct mem_pool tx_pkt_pool;         /* 0x842304: кадры TX 8 × 0x524 (fwq_tx.c) */
extern struct mem_pool stream_pool;         /* 0x847b34: контексты стримов 9 × 0x78 (l2mgr.c) */

#endif
