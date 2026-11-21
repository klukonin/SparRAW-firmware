/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Расписание (vendor 6.2): схема расписания записи mid (schedule_scheme_builder, ESE —
 * Extended Schedule Element).
 *
 * Схема расписания (0x805234, DCCM; mid.sched): сборщик распределений из WMI_SCHEDULING_SCHEME
 * (fw/wmi_h_bf.c) или из Extended Schedule бикона (fw/rx.c); свои слоты — в таблице ESE
 * (0x8052e4 → 0x857264), её обходит lmac_if__evt_walk и программирует регистры
 * alloc-слота. Конструкторы — fw/ctors.c (0x8c18bc, 0x8c18a0), привязка к mid —
 * mid__init_sched_scheme (0x8d96fc, fw/mid.c).
 *
 * Фиксированное расписание vendor (WMI 0xa02/0xa03, таблица 0x847a3c) удалено 2026-11-21: собственная схема опроса
 * vendor, не 802.11-2020; драйвер её не включал.
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
    u8  tdma_off;                              /* 0x01: TDMA точки выключен хостом (WMI_SPARRAW_TDMA_CFG, fw/tdma.c) */
    u8  tdma_min_sta;                          /* 0x02: порог включения TDMA (станций); 0 — по умолчанию (TDMA_MIN_STA) */
    u8  tdma_mode;                             /* 0x03: режим TDMA точки (WMI_SPARRAW_TDMA_MODE_*, fw/tdma.c) */
    struct ese_slot_tbl *tbl;                  /* 0x04: таблица обхода — ese_slot_tbl (0x857264) или ese_own_tbl
                                                *       (0x857978, строгий TDMA точки) */
};
_Static_assert(sizeof(struct ese_sched) == 8, "ese_sched");

/* Схема расписания записи mid (0x805234, 0x2c Б; ctor 0x8c18bc). */
struct sched_scheme {
    struct ese_sched *ese;                     /* 0x00: 0x8052e4 */
    u8  seq;                                   /* 0x04: номер распределения (полубайт) */
    u8  ese_n;                                 /* 0x05: число полей последнего ESE маяка (sched_alloc_changed); у точки
                                                *       в строгом TDMA — число окон ese_own_tbl в аппаратном массиве SP */
    u8  tdma_armed;                            /* 0x06: таймер обновления расписания TDMA взведён (fw/tdma.c) */
    u8  tdma_owned;                            /* 0x07: расписание построено TDMA точки, а не хостом (WMI 0xa01) */
    u32 next_bi_tsf;                           /* 0x08: TSF начала следующего BI */
    u32 built;                                 /* 0x0c: != 0 — распределения собраны */
    struct mid *mid;                           /* 0x10 */
    u32 start_acc;                             /* 0x14: накопитель начала слота (ESE-режим) */
    u8  same_cnt;                              /* 0x18: биконов подряд без изменений (до 0x10) */
    u8  ese_hash[3];                           /* 0x19: 24-битный отпечаток последнего ESE маяка (sched_alloc_changed); у
                                                *       точки в строгом TDMA — отпечаток окон ese_own_tbl (fw/tdma.c) */
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

#endif
