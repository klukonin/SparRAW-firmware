/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* RADIO_MGR (fw/radio_mgr.c): радио-менеджер — очередь запросов радио (основной канал /
 * вторичный канал), автомат rm_main_sm и вложенный rm_ch_switch_sm (смена канала).
 * Раскладка — как у vendor 6.2 (объект 0x806214 в DCCM, пул запросов 0x8062d8, таблица
 * методов 0x800848, указатель на объект [gp,-0x40] = 0x800144); смещения закреплены
 * _Static_assert. */
#ifndef RADIO_MGR_H
#define RADIO_MGR_H
#include "types.h"
#include "basic_sm.h"
#include "mem_pool.h"
#include "fwq_tx.h"

#define RM_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

struct radio_mgr;
struct rm_main_sm;
struct rm_req;

/* Колбэк запроса радио: cb(запрос, arg) — радио выдано (основной канал захвачен или
 * настроен вторичный). Вызывается задачей u_schd (radio_mgr_req_callback_task →
 * событие CALLBCK → rm_main_sm_call_cb). */
typedef void (*rm_req_cb)(struct rm_req *req, u32 arg);

/* Состояние запроса (rm_req.state). */
enum {
    RM_REQ_FREE = 0,          /* свободен (в пуле) */
    RM_REQ_QUEUED = 1,        /* в очереди */
    RM_REQ_GRANTED = 2,       /* выдан, колбэк вызван */
    RM_REQ_CB_PENDING = 3,    /* выдан, колбэк ждёт задачи u_schd */
    RM_REQ_FREE_PENDING = 4,  /* освобождён во время переключения — к удалению */
};

/* Тип запроса (rm_req.type). */
enum { RM_REQ_PRIMARY = 0, RM_REQ_SECONDARY = 1 };

/* Запрос радио — элемент пула (0x24 Б, 0x10 шт. в 0x8062d8). */
struct rm_req {
    struct rm_req *next;                       /* 0x00: узел llist */
    struct llist *list;                        /* 0x04: список, где стоит (очередь / держатели) */
    u32 state;                                 /* 0x08: RM_REQ_* */
    rm_req_cb cb;                              /* 0x0c */
    u32 arg;                                   /* 0x10 */
    u32 type;                                  /* 0x14: RM_REQ_PRIMARY / RM_REQ_SECONDARY */
    u32 ch;                                    /* 0x18: канал (вторичный) */
    u32 param;                                 /* 0x1c: параметр канала (вторичный) */
    u8  mid;                                   /* 0x20 */
    u8  rsv_21[3];
};
RM_OFF(struct rm_req, cb, 0x0c);
RM_OFF(struct rm_req, mid, 0x20);
_Static_assert(sizeof(struct rm_req) == 0x24, "rm_req");

/* Параметры канала (0x28 Б): основной канал (rm_main_sm.primary — из set_primary) и
 * текущее переключение (rm_main_sm.cur — копия основного или из вторичного запроса). */
struct rm_chan {
    u32 ch;                                    /* 0x00: канал (0xffff — не задан) */
    u32 param;                                 /* 0x04: 0 — не задан (радио не включать), основной — 1 */
    u32 tx_chan;                               /* 0x08: канал очередей TX_API (основной 0, вторичный 1) */
    u32 sta_role;                              /* 0x0c: 1 — STA (CONNECT, обход TSF), 0 — PCP; бит 0 [0x1c] LMAC 0x01 */
    u32 rsv_10;                                /* 0x10: vendor не заполняет и не читает */
    u32 changed;                               /* 0x14: основной канал изменён; бит 0 [0x10] LMAC 0x01 */
    u32 rx_on_w0;                              /* 0x18: слово [0] LMAC 0x01 (CONNECT: [0x805168]) */
    u32 rx_on_w4;                              /* 0x1c: слово [4] LMAC 0x01 (CONNECT: [0x80516c]) */
    u32 bcn_int;                               /* 0x20: интервал маяка, ТЕ (LMAC 0x01 [0x18] = ×1024) */
    u8  mid;                                   /* 0x24 */
    u8  rsv_25[3];
};
RM_OFF(struct rm_chan, changed, 0x14);
RM_OFF(struct rm_chan, mid, 0x24);
_Static_assert(sizeof(struct rm_chan) == 0x28, "rm_chan");

/* Очередь запросов radio_mgr: llist + владелец (radio_mgr_init_list). */
struct rm_queue {
    struct llist l;                            /* 0x00 */
    struct radio_mgr *owner;                   /* 0x0c */
};
_Static_assert(sizeof(struct rm_queue) == 0x10, "rm_queue");

/* Биты ожидаемых/пришедших событий rm_ch_switch_sm (expect/got). */
enum {
    RM_CS_FWTX_STOPPED = 1u << 0,
    RM_CS_DATA_STOPPED = 1u << 1,
    RM_CS_UCODE_RX_OFF = 1u << 2,
    RM_CS_MAC_SET      = 1u << 3,
    RM_CS_UCODE_RX_ON  = 1u << 4,
};

/* rm_ch_switch_sm (описатель 0x80338c; 3 состояния × 7 событий), rm_main_sm + 0x10. */
struct rm_ch_switch_sm {
    struct basic_sm hdr;                       /* 0x00 */
    struct rm_main_sm *sm;                     /* 0x08: владелец */
    struct rm_chan *params;                    /* 0x0c: параметры переключения (= &sm->cur) */
    u32 expect;                                /* 0x10: ожидаемые события RM_CS_* */
    u32 got;                                   /* 0x14: пришедшие */
    u32 ch;                                    /* 0x18: канал (0xffff — не задан) */
};
_Static_assert(sizeof(struct rm_ch_switch_sm) == 0x1c, "rm_ch_switch_sm");

/* rm_main_sm (описатель 0x803210; 6 состояний × 12 событий), radio_mgr + 0x28. */
struct rm_main_sm {
    struct basic_sm hdr;                       /* 0x00 */
    struct rm_queue *queue;                    /* 0x08: очередь запросов radio_mgr */
    struct radio_mgr *rm;                      /* 0x0c */
    struct rm_ch_switch_sm cs;                 /* 0x10 */
    struct rm_chan primary;                    /* 0x2c: основной канал */
    struct rm_chan cur;                        /* 0x54: текущее переключение */
    struct llist holders;                      /* 0x7c: запросы, удерживающие радио */
    u32 cur_ch;                                /* 0x88: канал после переключения (0xffff — нет) */
    u32 cur_param;                             /* 0x8c: его параметр */
    u8  cur_mid;                               /* 0x90: его mid */
    u8  rsv_91[3];
    u32 alt_kick;                              /* 0x94: альтернативный путь kick — vendor не пишет, 0 */
    u32 alt_kick_defer;                        /* 0x98: то же */
};
RM_OFF(struct rm_main_sm, cs, 0x10);
RM_OFF(struct rm_main_sm, primary, 0x2c);
RM_OFF(struct rm_main_sm, cur, 0x54);
RM_OFF(struct rm_main_sm, holders, 0x7c);
RM_OFF(struct rm_main_sm, cur_ch, 0x88);
RM_OFF(struct rm_main_sm, cur_mid, 0x90);
RM_OFF(struct rm_main_sm, alt_kick, 0x94);
_Static_assert(sizeof(struct rm_main_sm) == 0x9c, "rm_main_sm");

/* Таблица методов radio_mgr (vendor 0x800848). */
struct radio_mgr_vt {
    u32 rsv0;
    void (*set_primary)(struct radio_mgr *rm, u32 set, u32 ch, u32 rx_on_w0, u32 rx_on_w4,
                        u32 bcn_int, u32 sta_role, u32 mid);
    struct rm_req *(*request_primary)(struct radio_mgr *rm, rm_req_cb cb, u32 arg, u32 mid);
    struct rm_req *(*request_secondary)(struct radio_mgr *rm, rm_req_cb cb, u32 arg,
                                        u32 param, u32 ch, u32 mid);
    void (*lock_free)(struct radio_mgr *rm, struct rm_req *req);
    void (*sec_tune)(struct radio_mgr *rm, rm_req_cb cb, u32 arg, struct rm_req *req,
                     u32 param, u32 ch, u32 mid);
    void (*release)(struct radio_mgr *rm, struct rm_req *req);
    u32 (*get_channel)(struct radio_mgr *rm, u32 *ch);
    u32 (*cur_mid)(struct radio_mgr *rm);
    void (*callback)(struct radio_mgr *rm, struct rm_req *req);
    void (*inject_lock_evt)(struct radio_mgr *rm, u32 evt);
};
_Static_assert(sizeof(struct radio_mgr_vt) == 0x2c, "radio_mgr_vt");

/* Объект radio_mgr (0xc4 Б). */
struct radio_mgr {
    const struct radio_mgr_vt *vt;             /* 0x00 */
    struct mem_pool req_pool;                  /* 0x04: пул запросов (rm_req_pool) */
    struct rm_queue queue;                     /* 0x18: очередь запросов */
    struct rm_main_sm sm;                      /* 0x28 */
};
RM_OFF(struct radio_mgr, req_pool, 0x04);
RM_OFF(struct radio_mgr, queue, 0x18);
RM_OFF(struct radio_mgr, sm, 0x28);
_Static_assert(sizeof(struct radio_mgr) == 0xc4, "radio_mgr");

/* Объекты DCCM (fw/radio_mgr.c, в fw_data). */
extern struct radio_mgr radio_mgr;                     /* 0x806214 */
extern struct rm_req rm_req_pool[0x10];                /* 0x8062d8 */
extern const struct radio_mgr_vt radio_mgr_vtbl;       /* 0x800848 */
/* [gp,-0x40]: указатель на объект; vendor читает его при каждом вызове метода. */
extern struct radio_mgr *volatile radio_mgr_obj;       /* 0x800144 */

/* Описатели автоматов в DCCM (FWDATA, fw/radio_mgr.c; ид [0x10] пишет статический конструктор). */
extern struct sm_desc rm_main_sm_desc;               /* 0x803210 */
extern struct sm_desc rm_ch_switch_sm_desc;          /* 0x80338c */

#endif
