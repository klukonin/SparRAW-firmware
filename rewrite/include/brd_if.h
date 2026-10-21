/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Интерфейс board-файла brd_if_multi_array (vendor 6.2) — вложен в объект RF rf_obj (+4,
 * include/rf_obj.h). Две таблицы методов в DCCM: базовая 0x8005c4 (board-файла нет: read —
 * нули, поиск секций/блоков/порций — 0) и наследника 0x8005e4 (brd_if_multi_array).
 * Методы и разбор board-файла — fw/brd_if.c; конструкторы — fw/ctors.c (0x8c187c, 0x8c180c).
 * Раскладка — как у vendor; смещения закреплены _Static_assert. */
#ifndef BRD_IF_H
#define BRD_IF_H
#include "types.h"

#define BRD_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

/* Запись RF-регистра {адрес (поле RFC), значение} — порции board-файла, таблицы усилений. */
struct rf_reg_pair {
    u32 addr;                                  /* 0x00 */
    u32 val;                                   /* 0x04 */
};

/* Описатель секции board-файла (0x18 Б; brd_section_info__reset 0x8c67a4,
 * find_section 0x8caab8). */
struct brd_section_info {
    u32 id;                                    /* 0x00: номер секции (-1 — пусто) */
    u32 num_blocks;                            /* 0x04: число блоков (elem_bits) */
    u32 off;                                   /* 0x08: смещение секции (от board+8) */
    u32 size;                                  /* 0x0c: размер секции, Б */
    u32 rf_base;                               /* 0x10: rf_base_address (формат «только данные») */
    u8  rf_vector;                             /* 0x14: маска RF-модулей секции */
    u8  type;                                  /* 0x15: физический тип секции */
    u8  rsv_16[2];
};
BRD_OFF(struct brd_section_info, rf_base, 0x10);
BRD_OFF(struct brd_section_info, rf_vector, 0x14);
BRD_OFF(struct brd_section_info, type, 0x15);
_Static_assert(sizeof(struct brd_section_info) == 0x18, "brd_section_info");

/* Описатель блока секции (0x18 Б; brd_if__clear_block_info 0x8c6790, get_block_info 0x8cb978). */
struct brd_block_info {
    u32 id;                                    /* 0x00: номер секции (-1 — пусто) */
    u32 blk_idx;                               /* 0x04: номер блока (-1 — пусто) */
    u32 chip;                                  /* 0x08: номер RF-модуля */
    u32 num_entries;                           /* 0x0c: число записей */
    u32 off;                                   /* 0x10: смещение блока (от board+8) */
    u32 len;                                   /* 0x14: длина блока, Б */
};
BRD_OFF(struct brd_block_info, num_entries, 0x0c);
BRD_OFF(struct brd_block_info, len, 0x14);
_Static_assert(sizeof(struct brd_block_info) == 0x18, "brd_block_info");

/* Окно адресов RF-регистров для сверки порций (brd_if__bounds_check 0x8e2188, 24 Б):
 * записи в [lo, hi] — в массив пар pairs (вместимость cap, счётчик cnt); без массива
 * запоминается первая (указатель на данные board-файла — first, формат — mode). */
struct brd_win {
    u32 lo;                                    /* 0x00 */
    u32 hi;                                    /* 0x04 */
    struct rf_reg_pair *pairs;                 /* 0x08 */
    const u32 *first;                          /* 0x0c */
    u16 cap;                                   /* 0x10 */
    u16 cnt;                                   /* 0x12 */
    u32 mode;                                  /* 0x14: 0 — пары адрес/данные, 1 — только данные */
};
BRD_OFF(struct brd_win, first, 0x0c);
BRD_OFF(struct brd_win, cap, 0x10);
BRD_OFF(struct brd_win, cnt, 0x12);
BRD_OFF(struct brd_win, mode, 0x14);
_Static_assert(sizeof(struct brd_win) == 0x18, "brd_win");

/* Набор окон (brd_if__parse_chunk_header 0x8c7444): число окон — u16, но вызывающие
 * (rf.c: шаблоны 0x801fe8 / 0x802060) пишут его словом. */
struct brd_bounds {
    struct brd_win *win;                       /* 0x00 */
    union {
        u16 n;                                 /* 0x04: число окон */
        u32 n_w;
    };
};
BRD_OFF(struct brd_bounds, n, 0x04);
_Static_assert(sizeof(struct brd_bounds) == 8, "brd_bounds");

/* Запись таблицы секций board-файла (DCCM 0x8022c0, 10 × 12 Б; find_section 0x8caab8):
 * номер записи в таблице board-файла и две допустимые метки ({-1, -1} — секции нет). */
struct brd_section_map {
    u32 entry;                                 /* 0x00 */
    u32 tag[2];                                /* 0x04 */
};
_Static_assert(sizeof(struct brd_section_map) == 12, "brd_section_map");

struct brd_if;

/* Таблица методов (базовая 0x8005c4: слоты 2..4 — 0; наследник 0x8005e4). */
struct brd_if_vt {
    u32 rsv0;                                  /* [0] у vendor 0 */
    /* [1] маски RF-модулей секций 2k+3/2k+2 → out[0]/out[1] */
    u32 (*read)(struct brd_if *o, u32 k, u8 *out);
    /* [2] описатель секции id */
    u32 (*get_section_info)(struct brd_if *o, u32 id, struct brd_section_info *info);
    /* [3] описатель блока blk_idx секции */
    u32 (*get_block_info)(struct brd_if *o, const struct brd_section_info *info, u32 blk_idx,
                          struct brd_block_info *blk);
    /* [4] порция idx блока: записи {адрес, данные} в out, число записей */
    u32 (*get_chunk)(struct brd_if *o, const struct brd_section_info *info,
                     const struct brd_block_info *blk, u32 idx, struct rf_reg_pair *out,
                     u32 per_chunk, const struct brd_bounds *bounds);
    /* [5] список TX-секторов (байты +0..+0x3f объекта) */
    const u8 *(*tx_sectors)(struct brd_if *o);
    /* [6] число TX-секторов */
    u32 (*num_tx_sectors)(struct brd_if *o);
    /* [7] база адресов набора RF-модуля блока blk_idx → info->rf_base */
    void (*module_rf_base)(struct brd_if *o, struct brd_section_info *info, u32 blk_idx);
};
_Static_assert(sizeof(struct brd_if_vt) == 0x20, "brd_if_vt");

/* Объект brd_if_multi_array (0x54 Б; ctor 0x8c180c поверх базового 0x8c187c). */
struct brd_if {
    u8  tx_sectors[0x40];                      /* 0x00: список TX-секторов (0xff — свободно) */
    u8  num_tx_sectors;                        /* 0x40 */
    u8  rsv_41[3];
    const struct brd_if_vt *vt;                /* 0x44: brd_if_vtbl (до ctor наследника — base) */
    const u8 *data;                            /* 0x48: board-файл (0x84f800) */
    u32 size;                                  /* 0x4c: его размер (0x2400) */
    u32 valid;                                 /* 0x50: 1 — формат и размер проверены */
};
BRD_OFF(struct brd_if, num_tx_sectors, 0x40);
BRD_OFF(struct brd_if, vt, 0x44);
BRD_OFF(struct brd_if, data, 0x48);
BRD_OFF(struct brd_if, valid, 0x50);
_Static_assert(sizeof(struct brd_if) == 0x54, "brd_if");

/* Таблицы методов и таблица секций (fw/brd_if.c; в fw/dccm_names.txt — ext[N]). */
extern const struct brd_if_vt brd_if_base_vtbl;               /* 0x8005c4 */
extern const struct brd_if_vt brd_if_vtbl;                    /* 0x8005e4 */
extern const struct brd_section_map brd_section_map[10];      /* 0x8022c0 */
/* Образ board-файла, который кладёт хост (рабочая SRAM, символ fw/fw.ld; до op_mbox_tx_bufs). */
#define BRD_FILE_BUF_SIZE 0x2400
extern u8 brd_file_buf[BRD_FILE_BUF_SIZE];                     /* 0x84f800 */

#endif
