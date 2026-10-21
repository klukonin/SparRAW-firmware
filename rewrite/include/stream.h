/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* STREAM_MGR / Block Ack (fw/stream_mgr.c, fw/ba.c): контекст стрима (TX vring хоста ↔
 * соединение/TID) с вложенными автоматами — stream_sm (описатель 0x80296c, «ba_sm»),
 * ba_setup_sm (инициатор ADDBA, 0x802b50) и wait_sm (DELBA, 0x802ba0); таблица методов
 * контекста (0x800888). Раскладка — как у vendor 6.2: элементы пула stream_pool (0x847b34)
 * — 9 × 0x78 Б с 0x847b48, за ними таблица стримов по номеру vring (0x847f80, 10 слотов);
 * смещения закреплены _Static_assert. */
#ifndef STREAM_H
#define STREAM_H
#include "types.h"
#include "basic_sm.h"

#define STR_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

struct conn;
struct stream_ctx;
struct stream_sm;

/* ba_setup_sm (описатель 0x802b50; 7 состояний × 13 событий), stream_sm + 8 = ctx + 0x18:
 * инициатор ADDBA — попытки, таймеры, запрошенные и согласованные параметры. */
struct ba_setup_sm {
    struct basic_sm hdr;                       /* 0x00 */
    u8  tries;                                 /* 0x08: попытки ADDBA Request (до 30) */
    u8  token;                                 /* 0x09: dialog token последнего запроса */
    u8  rsv_0a[2];
    u32 resp_timer;                            /* 0x0c: задача u_schd — ожидание ADDBA Response */
    u32 retry_timer;                           /* 0x10: задача — пауза перед повтором запроса */
    u32 global_timer;                          /* 0x14: задача — общий таймаут установки */
    u8  req_win;                               /* 0x18: запрошенное окно (BA_EN) */
    u8  win;                                   /* 0x19: согласованное окно (ответ пира) */
    u8  req_amsdu;                             /* 0x1a */
    u8  amsdu;                                 /* 0x1b: согласованный A-MSDU */
    u16 req_timeout;                           /* 0x1c: запрошенный таймаут BA */
    u16 timeout;                               /* 0x1e: согласованный таймаут */
    struct stream_sm *sm;                      /* 0x20: владелец */
};
STR_OFF(struct ba_setup_sm, resp_timer, 0x0c);
STR_OFF(struct ba_setup_sm, req_win, 0x18);
STR_OFF(struct ba_setup_sm, sm, 0x20);
_Static_assert(sizeof(struct ba_setup_sm) == 0x24, "ba_setup_sm");

/* wait_sm (описатель 0x802ba0; 3 состояния × 4 события), stream_sm + 0x2c = ctx + 0x3c:
 * отправка DELBA (по флагу) при разрыве BA и уведомление stream_sm. */
struct ba_wait_sm {
    struct basic_sm hdr;                       /* 0x00 */
    u8  rsv_08;                                /* 0x08: обнуляет wait_sm__init, больше никто */
    u8  rsv_09;
    u16 reason;                                /* 0x0a: причина DELBA */
    u8  send_delba;                            /* 0x0c: != 0 — отправить DELBA */
    u8  rsv_0d[3];
    struct stream_sm *sm;                      /* 0x10: владелец */
};
STR_OFF(struct ba_wait_sm, reason, 0x0a);
STR_OFF(struct ba_wait_sm, sm, 0x10);
_Static_assert(sizeof(struct ba_wait_sm) == 0x14, "ba_wait_sm");

/* stream_sm (описатель 0x80296c; 5 состояний × 12 событий), ctx + 0x10. Состояния:
 * 0 NOT_BA_AGR, 1 BA_SETUP, 2 BA_AGREED, 3 BA_TEARDOWN, 4 WAIT_REMOVE_STREAM. */
struct stream_sm {
    struct basic_sm hdr;                       /* 0x00 */
    struct ba_setup_sm setup;                  /* 0x08 */
    struct ba_wait_sm wait;                    /* 0x2c */
    struct stream_ctx *ctx;                    /* 0x40: владелец */
};
STR_OFF(struct stream_sm, setup, 0x08);
STR_OFF(struct stream_sm, wait, 0x2c);
STR_OFF(struct stream_sm, ctx, 0x40);
_Static_assert(sizeof(struct stream_sm) == 0x44, "stream_sm");

/* Таблица методов контекста стрима (vendor 0x800888, слоты 1..8 — sw_vring::*). */
struct stream_ctx_vt {
    u32 rsv0;
    void (*ba_teardown)(struct stream_ctx *c, u32 a0, u32 a1);         /* 0x04 */
    void (*suspend)(struct stream_ctx *c);                             /* 0x08 */
    void (*suspend_b)(struct stream_ctx *c);                           /* 0x0c */
    void (*ready)(struct stream_ctx *c);                               /* 0x10 */
    void (*status)(struct stream_ctx *c, u32 status);                  /* 0x14 */
    void (*ba_agreed)(struct stream_ctx *c, u32 win, u32 timeout, u32 amsdu); /* 0x18 */
    void (*ba_failed)(struct stream_ctx *c, u32 resume);               /* 0x1c */
    void (*remove)(struct stream_ctx *c);                              /* 0x20 */
};
_Static_assert(sizeof(struct stream_ctx_vt) == 0x24, "stream_ctx_vt");

/* Контекст стрима (0x78 Б): элемент stream_pool; конструктор элемента 0x8ed190 ставит vt,
 * поля — sm_obj__store_desc (0x8d96c0) из vring__configure_tx. */
struct stream_ctx {
    struct conn *conn;                         /* 0x00: соединение (bcast — 0) */
    u8  tid;                                   /* 0x04 */
    u8  tbl_vr;                                /* 0x05: номер записи vring_tbl / MAC-очереди */
    u8  pring_type;                            /* 0x06 */
    u8  vr;                                    /* 0x07: номер vring (9 — особый) */
    u32 mid;                                   /* 0x08: номер записи mid */
    u32 bcast;                                 /* 0x0c: != 0 — широковещательный */
    struct stream_sm sm;                       /* 0x10 */
    u32 ba_en;                                 /* 0x54: 1 — BA_EN хоста, 0 — BA_DIS/DELBA */
    u32 removing;                              /* 0x58: стрим удаляется */
    u16 ssn;                                   /* 0x5c: начало окна (SSN ADDBA Request) */
    u8  configured;                            /* 0x5e: vring настроен (снимает remove) */
    u8  rsv_5f;
    u32 rm_flag;                               /* 0x60: флаг удаления соединения (link_sm) */
    u32 rm_reason;                             /* 0x64: его причина */
    const struct stream_ctx_vt *vt;            /* 0x68 */
    u8  rsv_6c[0xc];
};
STR_OFF(struct stream_ctx, sm, 0x10);
STR_OFF(struct stream_ctx, ba_en, 0x54);
STR_OFF(struct stream_ctx, ssn, 0x5c);
STR_OFF(struct stream_ctx, configured, 0x5e);
STR_OFF(struct stream_ctx, vt, 0x68);
_Static_assert(sizeof(struct stream_ctx) == 0x78, "stream_ctx");

#define STREAM_CTX_N  9
#define STREAM_VR_N   10

/* Экземпляры (адреса — fw/fw.ld) и таблица методов (fw/ba.c, в fw_data). */
extern struct stream_ctx stream_ctxs[STREAM_CTX_N];    /* 0x847b48: элементы stream_pool */
extern struct stream_ctx *stream_by_vr[STREAM_VR_N];   /* 0x847f80: стрим по номеру vring */
extern const struct stream_ctx_vt stream_ctx_vtbl;     /* 0x800888 */

/* Описатели автоматов в DCCM (FWDATA, fw/ba.c; ид [0x10] пишет статический конструктор). */
extern struct sm_desc stream_sm_desc;                /* 0x80296c */
extern struct sm_desc ba_setup_sm_desc;              /* 0x802b50 */
extern struct sm_desc wait_sm_desc;                  /* 0x802ba0 */

#endif
