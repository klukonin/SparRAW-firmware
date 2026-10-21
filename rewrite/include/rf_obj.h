/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Объект RF marlon_r_if_class (vendor rf_if) — единственный экземпляр rf_obj в DCCM 0x8042c8
 * (0x574 Б, до объекта 0x80483c). В образе fw_data — нули; статический конструктор 0x8c17c0
 * (fw/ctors.c) строит вложенный brd_if_multi_array (+4) и задаёт начальные поля.
 * Раскладка — как у vendor 6.2; смещения закреплены _Static_assert. */
#ifndef RF_OBJ_H
#define RF_OBJ_H
#include "types.h"
#include "brd_if.h"

#define RF_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

/* Порция board-файла: per_chunk у всех вызывающих — 0x80 записей. */
#define RF_CHUNK_MAX 0x80

/* marlon_r_if_class (0x8042c8). */
struct rf_obj {
    u8  rf_idx;                                /* 0x000: индекс RF для RFC (0 — Sparrow-R; 0xa — RF нет) */
    u8  rsv_001[3];
    struct brd_if brd;                         /* 0x004: интерфейс board-файла */
    struct brd_if *brd_if;                     /* 0x058: &brd после проверки board-файла, иначе 0 */
    struct rf_reg_pair chunk[RF_CHUNK_MAX];    /* 0x05c: порция записей секции board-файла */
    u8  tx_mask;                               /* 0x45c: маска TX-модулей (rf_vector секции 3) */
    u8  rx_mask;                               /* 0x45d: маска RX-модулей (rf_vector секции 2) */
    u8  rf_mask;                               /* 0x45e: маска рабочих RF-модулей */
    u8  rsv_45f;
    u32 channel;                               /* 0x460: текущий канал (0..3), config_channel */
    u8  sector_cfg_idx;                        /* 0x464: выбранная конфигурация секторов (скан) */
    u8  rsv_465;
    u16 sector_cfg_cnt;                        /* 0x466: число конфигураций секторов (omni) */
    u32 sets_mode;                             /* 0x468: режим наборов RF: 0, 1, 2 (несколько), 3 */
    u32 role_pwr_flag;                         /* 0x46c: board-файл, секция 1: второе слово ≠ 0 */
    u8  omni_rf_mask;                          /* 0x470: RF с ненулевыми данными omni-секторов */
    u8  comm_test_cnt;                         /* 0x471: счётчик RF-комм-теста (чётность — регистр) */
    u8  rsv_472[2];
    struct rf_reg_pair gain2_tbl[16];          /* 0x474: таблица второго усиления (board-файл) */
    struct rf_reg_pair gain_tbl[16];           /* 0x4f4: таблица RF-усилений (board-файл) */
};
RF_OFF(struct rf_obj, brd, 0x004);
RF_OFF(struct rf_obj, brd_if, 0x058);
RF_OFF(struct rf_obj, chunk, 0x05c);
RF_OFF(struct rf_obj, tx_mask, 0x45c);
RF_OFF(struct rf_obj, rx_mask, 0x45d);
RF_OFF(struct rf_obj, rf_mask, 0x45e);
RF_OFF(struct rf_obj, channel, 0x460);
RF_OFF(struct rf_obj, sector_cfg_idx, 0x464);
RF_OFF(struct rf_obj, sector_cfg_cnt, 0x466);
RF_OFF(struct rf_obj, sets_mode, 0x468);
RF_OFF(struct rf_obj, role_pwr_flag, 0x46c);
RF_OFF(struct rf_obj, omni_rf_mask, 0x470);
RF_OFF(struct rf_obj, comm_test_cnt, 0x471);
RF_OFF(struct rf_obj, gain2_tbl, 0x474);
RF_OFF(struct rf_obj, gain_tbl, 0x4f4);
_Static_assert(sizeof(struct rf_obj) == 0x574, "rf_obj");

/* Экземпляр (fw/rf.c, FWDATA(8042c8); в fw/dccm_names.txt — ext[1396]). */
extern struct rf_obj rf_obj;

/* Дескриптор rf_utils__auto_fill (0x8e3060), 16 Б: заполнение RF-регистров блока
 * (0x53c/0x524 + block·0x20) словом {first, last, word_mask} и, при pat, сверка шаблона. */
struct rf_auto_fill {
    u8  rf_mask;                               /* 0x00: маска RF */
    u8  block;                                 /* 0x01: блок 0/1 */
    u8  first;                                 /* 0x02: первый индекс */
    u8  last;                                  /* 0x03: последний индекс */
    const u32 *pat;                            /* 0x04: 6 слов шаблона или 0 */
    u32 verify;                                /* 0x08: != 0 — сверять шаблон с RF-регистрами 0x1000/0x2000+ */
    u8  word_mask;                             /* 0x0c: маска слов шаблона 0..5 */
    u8  rsv0d[3];                              /* 0x0d */
};
RF_OFF(struct rf_auto_fill, pat, 0x04);
RF_OFF(struct rf_auto_fill, word_mask, 0x0c);
_Static_assert(sizeof(struct rf_auto_fill) == 0x10, "rf_auto_fill");

/* Шаблоны в DCCM (fw/rf.c, FWDATA). */
extern struct rf_auto_fill rf_auto_fill_dflt_tpl;   /* 0x802004: блок 0, 0..0x7f, сверка, 0x3f */
extern struct rf_auto_fill rf_auto_fill_brp_tpl;    /* 0x8021c8: блок 1, 0x40..0x5f, 0x3f */

#endif
