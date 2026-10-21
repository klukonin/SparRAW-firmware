/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* TX_API / fwq_tx (fw/fwq_tx.c): очереди собственных кадров fw, кольцо TX, объект повторов.
 * Раскладка — как у vendor 6.2 (объекты в рабочей памяти 0x84xxxx, таблицы методов в DCCM);
 * смещения закреплены _Static_assert. */
#ifndef FWQ_TX_H
#define FWQ_TX_H
#include "types.h"
#include "llist.h"
#include "ring_idx.h"

#define FWQ_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

struct bcon_post_info;

/* Обработчик завершения TX кадра (tx_pkt.done; a9 TX_API::send_packet): payload, статус,
 * соединение (struct conn * числом — так передаёт fwq_tx). */
typedef void (*tx_done_fn)(u32 payload, u32 status, u32 conn);
/* Колбэк отправки маяка (tx_pkt.sent_cb; TX_API__send_dband_bcon): info, sent. */
typedef void (*tx_sent_fn)(struct bcon_post_info *info, u32 sent);

/* Кадр TX — элемент пула 0x842304 (0x524 Б): заголовок 0x24 Б + данные 0x500 Б. */
struct tx_pkt {
    u32 next;                                  /* 0x00: узел llist */
    u32 owner;                                 /* 0x04 */
    u16 len;                                   /* 0x08 */
    u8  cid;                                   /* 0x0a */
    u8  prio_ch;                               /* 0x0b: приоритет [5:0], канал [7:6] */
    union {
        struct {
            u16 cat;                           /* 0x0c: флаги категории (tx_op) */
            u16 cat_hi;                        /* 0x0e */
        };
        u32 cat_w;                             /* 0x0c: словом (TX_API_send_packet: |=) */
    };
    u8  retry_limit;                           /* 0x10 */
    u8  status;                                /* 0x11: 0 ok, 0xfd буфер ошибки, 0xfe повтор, 0xff flush */
    u8  retry_backoff;                         /* 0x12: пауза повтора, ×1024 мкс */
    u8  retries_left;                          /* 0x13 */
    u32 retry_timer;                           /* 0x14 */
    tx_sent_fn sent_cb;                        /* 0x18: колбэк отправки */
    struct bcon_post_info *sent_info;          /* 0x1c */
    tx_done_fn done;                           /* 0x20: обработчик завершения */
    u8  payload[0x500];                        /* 0x24 */
};
FWQ_OFF(struct tx_pkt, cid, 0x0a);
FWQ_OFF(struct tx_pkt, retry_timer, 0x14);
FWQ_OFF(struct tx_pkt, done, 0x20);
FWQ_OFF(struct tx_pkt, payload, 0x24);
#define TX_PKT_PRIO(p)  ((p)->prio_ch & 0x3fu)
#define TX_PKT_CHAN(p)  ((p)->prio_ch >> 6)
#define TX_PKT_HDR     0x24u                    /* payload − заголовок = struct tx_pkt */
#define TX_PKT_OF(pl)  ((struct tx_pkt *)((u32)(pl) - TX_PKT_HDR))

/* SW TX (кадр управления от хоста, SW_TX_MGMT_API 0x8e577c): тот же заголовок 0x24 Б перед
 * payload, но до постановки в очередь в нём контекст кадра — длина, адресат, mid. */
struct sw_tx_hdr {
    u8  rsv_00[8];
    u16 len;                                   /* 0x08: = tx_pkt.len */
    u16 rsv_0a;
    u8  dst[6];                                /* 0x0c: MAC адресата */
    u16 mid;                                   /* 0x12 */
    u8  rsv_14[0x10];
    u8  payload[0x500];                        /* 0x24 */
};
FWQ_OFF(struct sw_tx_hdr, len, 0x08);
FWQ_OFF(struct sw_tx_hdr, dst, 0x0c);
FWQ_OFF(struct sw_tx_hdr, mid, 0x12);
FWQ_OFF(struct sw_tx_hdr, payload, 0x24);
#define SW_TX_HDR_OF(pl)  ((struct sw_tx_hdr *)((u32)(pl) - TX_PKT_HDR))
/* Колбэк владельца кадра SW TX: статус (0 / 2), mid. */
typedef void (*sw_tx_done_fn)(u32 status, u32 mid);
extern struct sw_tx_hdr *volatile sw_tx_mgmt_ctx;  /* 0x8000c4: кадр SW TX, один за раз (0 — нет) */
extern volatile sw_tx_done_fn sw_tx_mgmt_cb;       /* 0x800184: колбэк завершения кадра SW TX */

/* Аппаратный TX-дескриптор кольца DMA (32 Б; wil6210 txrx.h struct vring_tx_desc:
 * vring_tx_mac + vring_tx_dma). Биты полей — по tx_desc_init_32 / tx_desc_build. */
struct tx_desc {
    u32 mac_d0;                                /* 0x00: [9:0] lifetime, [26:22] MCS, 27 MCS_EN */
    u32 mac_d1;                                /* 0x04: [3:0] PKT_MODE, 4 PKT_MODE_EN, [19:16] cid,
                                                *       20 DST_INDEX_EN, 23 lifetime_en,
                                                *       [30:24] число повторов, 31 retry_en */
    union {
        u32 mac_d2;                            /* 0x08 */
        u8  num_desc;                          /* 0x08: [7:0] число дескрипторов кадра */
    };
    u32 ucode_cmd;                             /* 0x0c: флаги из категории (fwq_tx_vt_send_next) */
    u32 dma_d0;                                /* 0x10: 8 EOP, 9 MARK_WB, 10 DMA_IT, [20:16] QID (MACQ) */
    u32 addr_lo;                               /* 0x14: адрес данных, 18 бит (окно 0x84xxxx) */
    u16 addr_hi;                               /* 0x18 */
    u8  ip_length;                             /* 0x1a */
    u8  b11;                                   /* 0x1b */
    union {
        u32 status_w;                          /* 0x1c: [2:0] error, 8 DU (дескриптор отдан) */
        struct {
            u8  error;                         /* 0x1c */
            u8  status;                        /* 0x1d: бит 0 DU */
            u16 length;                        /* 0x1e */
        };
    };
};
FWQ_OFF(struct tx_desc, ucode_cmd, 0x0c);
FWQ_OFF(struct tx_desc, dma_d0, 0x10);
FWQ_OFF(struct tx_desc, addr_lo, 0x14);
FWQ_OFF(struct tx_desc, status_w, 0x1c);
FWQ_OFF(struct tx_desc, length, 0x1e);
_Static_assert(sizeof(struct tx_desc) == 0x20, "tx_desc");
#define TX_DESC_DU  (1u << 8)                  /* status_w: дескриптор завершён (DU) */


struct tx_ring;
struct tx_retry;
struct fwq_tx;

/* Таблица методов кольца TX (vendor 0x8008ac). */
struct tx_ring_vt {
    u32 rsv0;
    u32 (*post_frame)(struct tx_ring *tr, u32 payload, u32 len, u32 a3, u32 retry,
                      u32 lifetime, u32 a6, u32 prio, u32 cid, u32 flags);
    void (*init)(struct tx_ring *tr, u32 macq, u32 dma, u32 base, u32 size);
    void (*complete)(struct tx_ring *tr, struct llist *done, struct llist *sent);
    void (*enable)(struct tx_ring *tr, u32 a1);
    u32 (*dma_ring)(struct tx_ring *tr);
};

/* Таблица методов объекта повторов (vendor 0x800778). */
struct tx_retry_vt {
    u32 rsv0;
    u32 (*try_next)(struct tx_retry *o);
    void (*init)(struct tx_retry *o, u32 macq, u32 dma, u32 base, u32 size);
    u32 (*drain)(struct tx_retry *o, struct llist *done, struct llist *src);
    void (*nop)(struct tx_retry *o);
    u32 (*dma_ring)(struct tx_retry *o);
};

/* Таблица методов очереди fwq_tx (vendor 0x80071c). */
struct fwq_tx_vt {
    u32 rsv0;
    void (*handle_completion)(struct fwq_tx *q, struct llist *done);
    u32 (*send_next)(struct fwq_tx *q);
    void (*enable_ring)(struct fwq_tx *q);
};

/* Кольцо TX (+0x50 в fwq_tx). */
struct tx_ring {
    const struct tx_ring_vt *vt;               /* 0x00 */
    struct ring_idx r;                         /* 0x04 */
    u32 macq;                                  /* 0x14 */
    u32 dma_ring;                              /* 0x18 */
};
FWQ_OFF(struct tx_ring, macq, 0x14);
_Static_assert(sizeof(struct tx_ring) == 0x1c, "tx_ring");

/* Объект повторов (+0x6c в fwq_tx). */
struct tx_retry {
    const struct tx_retry_vt *vt;              /* 0x00 */
    u32 pending;                               /* 0x04 */
    u32 credit;                                /* 0x08: не больше pending */
    u16 max;                                   /* 0x0c */
    s16 ok_credit;                             /* 0x0e */
    u32 dma_ring;                              /* 0x10 */
    u32 backoff_en;                            /* 0x14 */
    u32 tries;                                 /* 0x18 */
    u32 extra;                                 /* 0x1c */
};
_Static_assert(sizeof(struct tx_retry) == 0x20, "tx_retry");

/* Счётчики очереди ([q+0]). */
struct fwq_tx_stats {
    u32 added;                                 /* 0x00 */
    u32 sent;                                  /* 0x04 */
    u32 completed;                             /* 0x08 */
    u32 st_ok;                                 /* 0x0c: статус 0 */
    u32 st_4;                                  /* 0x10 */
    u32 st_255;                                /* 0x14 */
    u32 st_2;                                  /* 0x18 */
    u32 stopped;                               /* 0x1c */
    u32 flush_done;                            /* 0x20 */
    u32 rsv24;                                 /* 0x24: шаг массива 0x842318 — 0x28 */
};
_Static_assert(sizeof(struct fwq_tx_stats) == 0x28, "fwq_tx_stats");

/* Очередь fwq_tx / объект TX_API (0x90 Б). */
struct fwq_tx {
    struct fwq_tx_stats *stats;                /* 0x00 */
    u32 mode;                                  /* 0x04: 1 — управление (доступность PS) */
    u32 state;                                 /* 0x08: 0 выкл., 1 вкл., 2 остановка */
    u32 channel;                               /* 0x0c */
    u32 flush_timer;                           /* 0x10 */
    u32 flush_cid_mask;                        /* 0x14 */
    struct llist chq[2];                       /* 0x18, 0x24: очереди по каналам */
    struct llist *cur;                         /* 0x30: текущая очередь */
    struct llist sent;                         /* 0x34: переданные (в кольце) */
    struct llist retry;                        /* 0x40: на повтор */
    const struct fwq_tx_vt *vt;                /* 0x4c */
    struct tx_ring ring;                       /* 0x50 */
    struct tx_retry retry_obj;                 /* 0x6c */
    struct tx_ring *ring_p;                    /* 0x8c */
};
FWQ_OFF(struct fwq_tx, chq, 0x18);
FWQ_OFF(struct fwq_tx, cur, 0x30);
FWQ_OFF(struct fwq_tx, sent, 0x34);
FWQ_OFF(struct fwq_tx, retry, 0x40);
FWQ_OFF(struct fwq_tx, vt, 0x4c);
FWQ_OFF(struct fwq_tx, ring, 0x50);
FWQ_OFF(struct fwq_tx, retry_obj, 0x6c);
FWQ_OFF(struct fwq_tx, ring_p, 0x8c);
_Static_assert(sizeof(struct fwq_tx) == 0x90, "fwq_tx");

/* Экземпляры (адреса — fw/fw.ld) и таблицы методов (fw/fwq_tx.c, в fw_data). */
extern struct fwq_tx tx_api_mgmt;              /* 0x842154: управление, кольцо DMA 6, MACQ 0x1a */
extern struct fwq_tx tx_api_2;                 /* 0x8421e4: кольцо 3, MACQ 0x1e */
extern struct fwq_tx tx_api_data;              /* 0x842274: данные, кольцо 5, MACQ 0x19 */
extern struct llist tx_pending;                /* 0x842148: «ждущие» кадры управления (статус 5) —
                                                * сразу перед tx_api_mgmt (vendor адресует его поля
                                                * от 0x842148: +0x14 = state, +0x20 = flush_cid_mask) */
/* Счётчики очередей (0x842318, сразу за tx_pkt_pool; tx_api_init_pools обнуляет 3 × 0x28 Б). */
#define TX_STATS_MGMT  0
#define TX_STATS_DATA  1
#define TX_STATS_2     2
extern struct fwq_tx_stats tx_api_stats[3];    /* 0x842318 */
extern struct tx_desc tx_ring_mem_data[2];     /* 0x840000: кольцо DMA 5 (tx_api_data) */
extern struct tx_desc tx_ring_mem_mgmt[2];     /* 0x842800: кольцо DMA 6 (tx_api_mgmt) */
extern struct tx_desc tx_ring_mem_2[2];        /* 0x843000: кольцо DMA 3 (tx_api_2) */
#define TX_PKT_N 8
extern struct tx_pkt tx_pkt_mem[TX_PKT_N];     /* 0x848020: память tx_pkt_pool */
extern struct tx_pkt tx_err_buf;               /* 0x805ac0 (DCCM): буфер ошибки, статус 0xfd */
/* Режим TX-очереди DMA по MACQ (0x8031c8, 32 × 2 Б, только чтение; в образе mode 2 у
 * 0x18, 0x1b..0x1f, у остальных 0). dma_mgr_queue_state_is_0/1, tx_macq_setup (флаги). */
struct txq_dma_mode {
    u8 q;                                      /* 0x00: номер MACQ (= индекс) */
    u8 mode;                                   /* 0x01 */
};
extern struct txq_dma_mode txq_dma_mode_tbl[32];         /* 0x8031c8 */
extern const struct fwq_tx_vt fwq_tx_vtbl;     /* 0x80071c */
extern const struct tx_retry_vt tx_retry_vtbl; /* 0x800778 */
extern const struct tx_ring_vt tx_ring_vtbl;   /* 0x8008ac */

#endif
