/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Дескрипторы MAC-очередей (MACQ) в памяти fw: дескриптор окна очереди (16 Б, пишется в
 * окно MACQ 0x886600 через macq_desc_write / читается macq_desc_read) и набор дескрипторов
 * TX-очереди (0x70 Б на стеке: tx_macq_setup, ba_sm_build_addba_params, ...), который
 * qh_write_by_flags_fw раздаёт по флагам (0x1..0x20) или LMAC-командой 0x45 (копия 0x70 Б).
 * Поля окна — из txq_ring_param_config_queue / stream_params_copy_hdr (журнал vendor
 * 0x101346c: payload_length_lines, max_msdu_size_bytes, PTP_PAYLOAD_PIPE_LEN_BYTE). */
#ifndef MACQ_DESC_H
#define MACQ_DESC_H
#include "types.h"

#define MACQ_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

/* Дескриптор окна очереди (16 Б): строки по 8 Б. */
struct macq_desc {
    u16 rd;                                    /* 0x00: = начало окна */
    u16 wr;                                    /* 0x02: = начало окна */
    u16 lines;                                 /* 0x04: payload_length_lines (размер окна) */
    u16 base;                                  /* 0x06: начало окна (строка) */
    union {
        u32 w2;                                /* 0x08: [11:0] MSDU в строках, [23:12] param_a */
        struct {
            u8 w2_b[3];
            u8 param_a_lo;                     /* 0x0b: (u8)param_a */
        };
    };
    union {
        u32 w3;                                /* 0x0c: [3:0] param_a >> 8, [15:4] param_b (окно BA),
                                                *       [27:16] param_a, [31:28] 0 */
        u8  w3_b[4];
    };
};
MACQ_OFF(struct macq_desc, base, 0x06);
MACQ_OFF(struct macq_desc, w2, 0x08);
MACQ_OFF(struct macq_desc, param_a_lo, 0x0b);
MACQ_OFF(struct macq_desc, w3, 0x0c);
_Static_assert(sizeof(struct macq_desc) == 0x10, "macq_desc");

/* Секторный дескриптор очереди (16 Б, +0x10 набора): rf_chain__program_sector_desc
 * (0x8fa398) по режиму очереди. */
struct macq_sector_desc {
    u32 w0;                                    /* 0x00: [3:0], [7:4], [15:14], [20:16], 21,
                                                *       [23:22] mode_field, [25:24] индекс ключа,
                                                *       [30:29], 31 */
    u32 w1;                                    /* 0x04: бит 0, 1, [3:2], [8:4], 9 */
    u32 w2;                                    /* 0x08: 0 */
    u32 w3;                                    /* 0x0c: 0xa0a0a0a0 (режим 10 — 0x1c36ffe0) */
};
_Static_assert(sizeof(struct macq_sector_desc) == 0x10, "macq_sector_desc");

/* Дескриптор режима TX-очереди (16 Б, +0x20 набора): tx_queue__config_by_mode (0x8f9fb0). */
struct macq_mode_desc {
    u32 w0;                                    /* 0x00: [2:0], 3, 4, 5, [19:6] длина MPDU,
                                                *       [29:20], 30 */
    u32 w1;                                    /* 0x04: [12:0], 13, [16:14], [20:17] */
    u32 w2;                                    /* 0x08 */
    u16 w3_lo;                                 /* 0x0c */
    u16 field0e;                               /* 0x0e: режим 4 — macq_desc_field0e, 10 — 0xaf23 */
};
MACQ_OFF(struct macq_mode_desc, field0e, 0x0e);
_Static_assert(sizeof(struct macq_mode_desc) == 0x10, "macq_mode_desc");

/* Дескриптор типа/BA очереди (3 строки по 16 Б, +0x40 набора): qdesc__build_by_type
 * (0x8fa224) обнуляет 0x30 Б; qh_write_by_flags_fw (флаг 0x10) пишет его в MACQ тремя
 * строками (macq_desc_write …, 3). */
struct macq_ba_desc {
    u32 w0;                                    /* 0x00: бит 0 — флаг, [10:8], 1, [19:16] TID, 2,
                                                *       [30:24] */
    union {
        u32 w1;                                /* 0x04: [11:0] начало окна (номер блока) */
        u8  w1_b[4];                           /* 0x06: байт 2 */
    };
    union {
        u32 w2;                                /* 0x08: [11:0] конец окна, 12 */
        u8  w2_b[4];                           /* 0x0a: байт 2 — размер окна − 1 */
    };
    union {
        u32 w3;                                /* 0x0c */
        u8  w3_b[4];
    };
    u32 line1[4];                              /* 0x10: вторая строка */
    u32 line2[4];                              /* 0x20: третья строка (тип 10: [0], [1] = −1) */
};
MACQ_OFF(struct macq_ba_desc, line1, 0x10);
MACQ_OFF(struct macq_ba_desc, line2, 0x20);
_Static_assert(sizeof(struct macq_ba_desc) == 0x30, "macq_ba_desc");

/* Запись конфигурации RX-MACQ (16 Б; 4 записи с 0x843188 — rx_macq__entry_addr 0x8ccb68;
 * пишет rx_macq__setup 0x8d93a0). */
struct rx_macq_cfg {
    u8  queue;                                 /* 0x00: номер очереди MACQ */
    u8  type;                                  /* 0x01: тип очереди (0..5) */
    u16 payload;                               /* 0x02: размер полезной нагрузки (окно BA) */
    u8  decap;                                 /* 0x04: тип декапсуляции offload (b4) */
    u8  rsv_05[3];
    u32 sniffer;                               /* 0x08: 1 — режим sniffer (WMI_CFG_RX_CHAIN) */
    u32 reorder;                               /* 0x0c: 1 — переупорядочивание (offload) */
};
MACQ_OFF(struct rx_macq_cfg, decap, 0x04);
MACQ_OFF(struct rx_macq_cfg, reorder, 0x0c);
_Static_assert(sizeof(struct rx_macq_cfg) == 0x10, "rx_macq_cfg");
#define RX_MACQ_N 4
extern struct rx_macq_cfg rx_macq_cfgs[RX_MACQ_N];     /* 0x843188 (fw.ld) */

/* Параметры окна BA RX-MACQ (12 Б на стеке: rx_macq__program_ba_win 0x8e37fc →
 * rx_macq__build_ba_desc 0x8e4448). */
struct rx_ba_win_params {
    u8  queue;                                 /* 0x00 */
    u8  rsv_01[3];
    u16 start;                                 /* 0x04: начало окна (строка) */
    u16 size;                                  /* 0x06: размер окна (строки) */
    u16 param_a;                               /* 0x08 */
    u16 param_b;                               /* 0x0a */
};
_Static_assert(sizeof(struct rx_ba_win_params) == 0xc, "rx_ba_win_params");

/* Буферы дескрипторов RX-MACQ для macq_desc_read / macq_desc_write (0x847fc8, 0x58 Б;
 * дальше — tx_pkt_mem 0x848020). */
struct rx_macq_bufs {
    struct macq_desc ba_win;                   /* 0x00 (0x847fc8): окно BA (тип 1, дескр. 0) */
    u32 offload[4];                            /* 0x10 (0x847fd8): offload (ese_set_alloc_type) */
    union {
        u32 w[12];                             /* 0x20 (0x847fe8): цепочка (тип 1, дескр. 3) */
        u8  b[0x30];                           /*       [0xb]/[0xd] — указатели очереди (опустошение) */
    } chain;
    u32 ctl[2];                                /* 0x50 (0x848018): управление (тип 1, дескр. 2) */
};
MACQ_OFF(struct rx_macq_bufs, offload, 0x10);
MACQ_OFF(struct rx_macq_bufs, chain, 0x20);
MACQ_OFF(struct rx_macq_bufs, ctl, 0x50);
_Static_assert(sizeof(struct rx_macq_bufs) == 0x58, "rx_macq_bufs");
extern struct rx_macq_bufs rx_macq_bufs;               /* 0x847fc8 (fw.ld) */

/* Набор дескрипторов TX-очереди (0x70 Б). Флаги qh_write_by_flags_fw: 0x1 win, 0x2 sector,
 * 0x4 mode, 0x8 addr, 0x10 ba, 0x20 — win как «типизированный». */
struct macq_qdesc {
    struct macq_desc win;                      /* 0x00: окно (stream_params_copy_hdr) */
    struct macq_sector_desc sector;            /* 0x10: секторный (rf_chain_program_sector_desc) */
    struct macq_mode_desc mode;                /* 0x20: режим (tx_queue_config_by_mode) */
    u32 addr[4];                               /* 0x30: RA/TA (tx_dma_build_desc) */
    struct macq_ba_desc ba;                    /* 0x40: тип/BA (qdesc_build_by_type) */
};
MACQ_OFF(struct macq_qdesc, sector, 0x10);
MACQ_OFF(struct macq_qdesc, mode, 0x20);
MACQ_OFF(struct macq_qdesc, addr, 0x30);
MACQ_OFF(struct macq_qdesc, ba, 0x40);
_Static_assert(sizeof(struct macq_qdesc) == 0x70, "macq_qdesc");

/* Параметры окна для txq_ring_param_config_queue (на стеке tx_macq_config_ring_params). */
struct txq_ring_param {
    u32 macq;                                  /* 0x00 */
    u16 start;                                 /* 0x04: начало окна (строка) */
    u16 lines;                                 /* 0x06: payload_length_lines */
    u16 param_a;                               /* 0x08 */
    u16 param_b;                               /* 0x0a: не меньше 6 */
};
_Static_assert(sizeof(struct txq_ring_param) == 0xc, "txq_ring_param");

#endif
