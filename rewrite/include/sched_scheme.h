/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Расписание (vendor 6.2): схема расписания записи mid (schedule_scheme_builder, ESE —
 * Extended Schedule Element) и фиксированное расписание (fixed_sched).
 *
 * Схема расписания (0x805234, DCCM; mid.sched): сборщик распределений из WMI_SCHEDULING_SCHEME
 * (fw/wmi_h_bf.c) или из Extended Schedule бикона (fw/rx.c); свои слоты — в таблице ESE
 * (0x8052e4 → 0x857264), её обходит lmac_if__evt_walk и программирует регистры
 * alloc-слота. Конструкторы — fw/ctors.c (0x8c18bc, 0x8c18a0), привязка к mid —
 * mid__init_sched_scheme (0x8d96fc, fw/mid.c).
 *
 * Фиксированное расписание (0x847a3c, рабочая память; символ fw/fw.ld): параметры по MCS
 * и общие длительности из WMI_FIXED_SCHEDULING_CONFIG (fw/wmi_h_bf.c); адрес таблицы
 * fixed_sched__start пишет в общую с uc ячейку 0x857744 (fwsh_sets.fsched_tbl, include/fwsh.h).
 * Смещения закреплены _Static_assert. */
#ifndef SCHED_SCHEME_H
#define SCHED_SCHEME_H
#include "types.h"
#include "fwsh.h"

#define SCHED_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

struct mid;

/* struct ese_slot, struct ese_slot_tbl (0x857264, общая с uc) — include/fwsh.h. */

/* Курсор ESE (0x8052e4, 8 Б): текущий слот обхода и таблица. */
struct ese_sched {
    u8  cur;                                   /* 0x00: текущий слот (по модулю count) */
    u8  rsv_01[3];
    struct ese_slot_tbl *tbl;                  /* 0x04: 0x857264 */
};
_Static_assert(sizeof(struct ese_sched) == 8, "ese_sched");

/* Схема расписания записи mid (0x805234, 0x2c Б; ctor 0x8c18bc). */
struct sched_scheme {
    struct ese_sched *ese;                     /* 0x00: 0x8052e4 */
    u8  seq;                                   /* 0x04: номер распределения (полубайт) */
    u8  rsv_05[3];
    u32 next_bi_tsf;                           /* 0x08: TSF начала следующего BI */
    u32 built;                                 /* 0x0c: != 0 — распределения собраны */
    struct mid *mid;                           /* 0x10 */
    u32 start_acc;                             /* 0x14: накопитель начала слота (ESE-режим) */
    u8  same_cnt;                              /* 0x18: биконов подряд без изменений (до 0x10) */
    u8  rsv_19[3];
    /* 0x1c: шаблон 15-байтового поля Allocation IE (биты 4..6 = 1, бит 7; [0xc] = 1 —
     * mid__init_sched_scheme) */
    union {
        u32 ctrl;
        u8  b[16];
    } alloc_tpl;
};
SCHED_OFF(struct sched_scheme, built, 0x0c);
SCHED_OFF(struct sched_scheme, mid, 0x10);
SCHED_OFF(struct sched_scheme, same_cnt, 0x18);
SCHED_OFF(struct sched_scheme, alloc_tpl, 0x1c);
_Static_assert(sizeof(struct sched_scheme) == 0x2c, "sched_scheme");

/* Экземпляры (DCCM, fw/rx.c) и таблица слотов (рабочая память, fw.ld). */
extern struct sched_scheme sched_scheme;      /* 0x805234 */
extern struct ese_sched ese_sched;            /* 0x8052e4 */

/* struct fixed_sched_mcs, struct fixed_sched — include/fwsh.h (uc читает по указателю
 * fwsh_sets.fsched_tbl). */

extern struct fixed_sched fixed_sched;                        /* 0x847a3c (fw.ld) */

#endif
