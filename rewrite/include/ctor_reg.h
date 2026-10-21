/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Регистрация статического конструктора vendor 6.2 (C++ global ctors): 49 объектов
 * 0x8009a8..0x801b2c в fw_data. vendor 0x8fc364 вставляет каждый в список 0x801b1c
 * (list__insert_obj 0x8c1cc0 → 0x8e1174: номер списка — байт +8 до вставки, ключ — prio
 * по возрастанию), затем 0x8c1ca0 зовёт ctor каждого. У нас список не исполняется:
 * конструкторы по порядку зовёт static_ctors_run (fw/ctors.c), объекты — только образ. */
#ifndef CTOR_REG_H
#define CTOR_REG_H
#include "types.h"

struct ctor_reg {
    u32 prio;                                  /* 0x00: ключ сортировки списка */
    void (*ctor)(void);                        /* 0x04: конструктор */
    struct ctor_reg *next;                     /* 0x08: следующий в списке; до вставки —
                                                * младший байт = номер списка (0) */
};
_Static_assert(sizeof(struct ctor_reg) == 12, "ctor_reg");

#endif
