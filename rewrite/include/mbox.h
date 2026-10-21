/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Почтовые ящики fw (vendor fw_mailbox / operational_if / debug mbox / lmac_if): кольца записей
 * {sync, addr} в памяти второй стороны (хост — RGF 0x8802bc.., ucode — SRAM 0x840130..),
 * описатели колец и объекты-ящики. Раскладка — как у vendor 6.2; смещения закреплены
 * _Static_assert. Код: fw/mbox.c, fw/tx_helpers.c (кольца, события), fw/wmi_cmd.c (методы
 * ящиков хоста, разбор команд), fw/stubs.c (инициализация), fw/lmac.c (ящик ucode). */
#ifndef MBOX_H
#define MBOX_H
#include "types.h"
#include "mem_pool.h"

#define MBOX_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

/* Запись кольца (struct wil6210_mbox_ring_desc драйвера): sync != 0 — запись занята. */
struct mbox_entry {
    u32 sync;                                  /* 0x00 */
    u32 addr;                                  /* 0x04: буфер (struct mbox_hdr) */
};
_Static_assert(sizeof(struct mbox_entry) == 8, "mbox_entry");

/* Описатель кольца для второй стороны (struct wil6210_mbox_ring драйвера). Поля volatile:
 * их читает/пишет хост или ucode; кроме того, gcc иначе сливает две записи u16 (size,
 * entry_size) в одну u32, а vendor пишет их по отдельности (stw, 0x8f9504..0x8f950a). */
struct mbox_ring_hw {
    volatile u32 base;                         /* 0x00 */
    volatile u16 entry_size;                   /* 0x04: размер буфера записи */
    volatile u16 size;                         /* 0x06: размер кольца, байт */
    volatile u32 tail;                         /* 0x08: курсор читателя (адрес записи) */
    volatile u32 head;                         /* 0x0c: курсор писателя (адрес записи) */
};
MBOX_OFF(struct mbox_ring_hw, tail, 0x08);
_Static_assert(sizeof(struct mbox_ring_hw) == 0x10, "mbox_ring_hw");

/* Кольцо ящика (vendor ring__init_desc 0x8d8b00, 0x20 Б). */
struct mbox_ring {
    struct mbox_entry *cur;                    /* 0x00: текущая запись */
    struct mbox_entry *base;                   /* 0x04 */
    struct mbox_entry *end;                    /* 0x08 */
    struct mbox_ring_hw *hw;                   /* 0x0c */
    struct mem_pool *pool;                     /* 0x10: буферы записей */
    u32 pooled;                                /* 0x14: 1 — буферы записей из pool (выделение
                                                *       mem_pool__alloc_cell, возврат при записи) */
    void (*free_cb)(u32 payload);              /* 0x18: возврат буфера с флагом 1 */
    void (*free_cb2)(u32 payload);             /* 0x1c: возврат буфера с флагом 2 */
};
MBOX_OFF(struct mbox_ring, pool, 0x10);
MBOX_OFF(struct mbox_ring, free_cb, 0x18);
_Static_assert(sizeof(struct mbox_ring) == 0x20, "mbox_ring");

/* Заголовок буфера записи (0x10 Б): mbox-заголовок драйвера + wmi-заголовок; тело с +0x10. */
struct mbox_hdr {
    u16 seq;                                   /* 0x00 */
    u16 len;                                   /* 0x02 */
    u16 type;                                  /* 0x04 */
    union {
        u16 flags;                             /* 0x06: бит 1 — free_cb, 2 — free_cb2,
                                                *       3 — пропустить free_cb один раз */
        struct {
            u8 flags_lo;                       /* 0x06 */
            u8 len_lo;                         /* 0x07: vendor пишет младший байт длины */
        };
    };
    u8  mid;                                   /* 0x08 */
    u8  rsv_09;                                /* 0x09 */
    u16 id;                                    /* 0x0a: WMI id */
    u32 timestamp;                             /* 0x0c */
};
MBOX_OFF(struct mbox_hdr, flags, 0x06);
MBOX_OFF(struct mbox_hdr, id, 0x0a);
_Static_assert(sizeof(struct mbox_hdr) == 0x10, "mbox_hdr");

/* Общая часть ящика (0x44 Б): счётчик и два кольца. */
struct fw_mailbox {
    union {
        u16 seq;                               /* 0x00: номер следующего события */
        u32 seq_word;
    };
    struct mbox_ring tx;                       /* 0x04: fw → хост/ucode */
    struct mbox_ring rx;                       /* 0x24: хост/ucode → fw */
};
MBOX_OFF(struct fw_mailbox, tx, 0x04);
MBOX_OFF(struct fw_mailbox, rx, 0x24);
_Static_assert(sizeof(struct fw_mailbox) == 0x44, "fw_mailbox");

struct wmi_mbox;

/* Таблица методов ящиков хоста (vendor 0x800790 operational, 0x8006fc debug). */
struct wmi_mbox_vt {
    u32 rsv0;
    void (*dispatch)(struct wmi_mbox *mb, u8 *buf);    /* [1] разбор записи */
    void (*unmask_irq)(struct wmi_mbox *mb);           /* [2] после разбора всех записей */
    void (*evt_posted)(struct wmi_mbox *mb);           /* [3] событие хосту отправлено */
};

/* Ящик хоста (mbox__init_descriptor 0x8f942c, 0x78 Б). */
struct wmi_mbox {
    struct fw_mailbox mb;                      /* 0x00 */
    const struct wmi_mbox_vt *vt;              /* 0x44 */
    struct mem_pool rx_pool;                   /* 0x48: буферы команд */
    struct mem_pool tx_pool;                   /* 0x5c: буферы событий */
    u32 rx_entry_size;                         /* 0x70 */
    u32 tx_entry_size;                         /* 0x74 */
};
MBOX_OFF(struct wmi_mbox, vt, 0x44);
MBOX_OFF(struct wmi_mbox, rx_pool, 0x48);
MBOX_OFF(struct wmi_mbox, tx_pool, 0x5c);
MBOX_OFF(struct wmi_mbox, rx_entry_size, 0x70);
_Static_assert(sizeof(struct wmi_mbox) == 0x78, "wmi_mbox");

/* Отправка события хосту (operational_if_evt_send, fw/discovery.c). */
typedef void (*mbox_evt_send_fn)(u32 payload, u32 evt, u32 len, u32 mid, u32 a4, u32 a5, u32 a6);

/* Операционный ящик (operational_if__mbox_init 0x8d9f00, 0x7c Б). */
struct operational_mbox {
    struct wmi_mbox wm;                        /* 0x00 */
    mbox_evt_send_fn evt_send;                 /* 0x78: low_sme__send_evt2sw */
};
MBOX_OFF(struct operational_mbox, evt_send, 0x78);
_Static_assert(sizeof(struct operational_mbox) == 0x7c, "operational_mbox");

struct lmac_mbox;

/* Таблица методов ящика ucode (vendor 0x800770). */
struct lmac_mbox_vt {
    u32 rsv0;
    void (*dispatch)(struct lmac_mbox *mb, u8 *evt);   /* [1] lmac_if__ucode_event_dispatch */
};

/* Ящик ucode (lmac_if__build_cmd_rings 0x8f94e4, 0x48 Б): пулы — в SRAM 0x840130/0x840144. */
struct lmac_mbox {
    struct fw_mailbox mb;                      /* 0x00 */
    const struct lmac_mbox_vt *vt;             /* 0x44 */
};
_Static_assert(sizeof(struct lmac_mbox) == 0x48, "lmac_mbox");

/* Пулы и описатели колец ящика ucode в SRAM (0x840130, видна ucode; lmac_if__build_cmd_rings).
 * Сразу за ним — записи колец: команды 0x840178 (20), события 0x840218 (12). */
struct lmac_mbox_shm {
    struct mem_pool tx_pool;                   /* 0x00: команды, 0x15 × 0x100 (0x840278) */
    struct mem_pool rx_pool;                   /* 0x14: события, 0xc × 0x64 (0x841778) */
    struct mbox_ring_hw rx_hw;                 /* 0x28: 0x840158 → RGF 0x8802e0 */
    struct mbox_ring_hw tx_hw;                 /* 0x38: 0x840168 */
};
MBOX_OFF(struct lmac_mbox_shm, rx_hw, 0x28);
MBOX_OFF(struct lmac_mbox_shm, tx_hw, 0x38);
_Static_assert(sizeof(struct lmac_mbox_shm) == 0x48, "lmac_mbox_shm");

/* Запрос GET/SET_SELECTED_RF_SECTOR_INDEX, ждущий ответа ucode (vendor 0x804914/0x80491c). */
struct rf_sector_sel_req {
    u8  req[4];                                /* 0x00: тело команды WMI */
    u32 mbox;                                  /* 0x04: ящик для ответа (0 — запроса нет) */
};
_Static_assert(sizeof(struct rf_sector_sel_req) == 8, "rf_sector_sel_req");
#define RF_SECTOR_SEL_GET 0
#define RF_SECTOR_SEL_SET 1

/* Экземпляры: DCCM — FWDATA (fw/stubs.c, fw/lmac.c), вне DCCM — fw/fw.ld. */
extern struct operational_mbox operational_mbox;          /* 0x8041f0 */
extern struct operational_mbox *operational_mbox_ref;     /* 0x804c3c: = &operational_mbox (sched__step) */
extern struct lmac_mbox lmac_mbox;                        /* 0x804280 */
extern struct wmi_mbox debug_mbox;                        /* 0x843040 */
extern struct lmac_mbox_shm lmac_mbox_shm;                /* 0x840130 */
/* Память колец и пулов буферов ящиков (рабочая SRAM, символы fw/fw.ld). */
#define LMAC_CMD_RING_N 20
#define LMAC_EVT_RING_N 12
extern struct mbox_entry lmac_cmd_ring[LMAC_CMD_RING_N];  /* 0x840178: команды fw → ucode */
extern struct mbox_entry lmac_evt_ring[LMAC_EVT_RING_N];  /* 0x840218: события ucode → fw */
extern u8 lmac_cmd_bufs[0x15][0x100];                     /* 0x840278: lmac_mbox_shm.tx_pool */
extern u8 lmac_evt_bufs[0xc][0x64];                       /* 0x841778: lmac_mbox_shm.rx_pool */
extern u8 op_mbox_rx_bufs[5][0x518];                      /* 0x845634: команды хоста operational_mbox */
extern u8 dbg_mbox_rx_bufs[4][0x64];                      /* 0x846fac: команды debug_mbox */
extern u8 dbg_mbox_tx_bufs[7][0x100];                     /* 0x84713c: события debug_mbox */
extern u8 op_mbox_tx_bufs[0x1b][0x100];                   /* 0x851c00: события operational_mbox */
extern struct rf_sector_sel_req rf_sector_sel[2];         /* 0x804914 */
extern const struct wmi_mbox_vt operational_mbox_vtbl;    /* 0x800790 */
extern const struct wmi_mbox_vt debug_mbox_vtbl;          /* 0x8006fc */
extern const struct lmac_mbox_vt lmac_mbox_vtbl;          /* 0x800770 */

#endif
