/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Запись битового поля [shift, shift + width) по адресу — чтение-изменение-запись.
 * Значение обрезается до width бит; соседние биты не меняются. */
#ifndef BITFIELD_H
#define BITFIELD_H
#include "types.h"

static inline __attribute__((always_inline)) u32 bf_put(u32 word, unsigned shift, unsigned width, u32 v)
{
    u32 m = width >= 32 ? ~0u : (1u << width) - 1u;
    return (word & ~(m << shift)) | ((v & m) << shift);
}

static inline __attribute__((always_inline)) void bf_set32(u32 addr, unsigned shift, unsigned width, u32 v)
{
    u32 *p = (u32 *)addr;
    *p = bf_put(*p, shift, width, v);
}

static inline __attribute__((always_inline)) void bf_set16(u32 addr, unsigned shift, unsigned width, u32 v)
{
    u16 *p = (u16 *)addr;
    *p = (u16)bf_put(*p, shift, width, v);
}

static inline __attribute__((always_inline)) void bf_set8(u32 addr, unsigned shift, unsigned width, u32 v)
{
    u8 *p = (u8 *)addr;
    *p = (u8)bf_put(*p, shift, width, v);
}

/* Слово по невыровненному адресу (little-endian, побайтно). */
static inline __attribute__((always_inline)) void bf_set32_unaligned(u32 addr, unsigned shift, unsigned width, u32 v)
{
    u8 *p = (u8 *)addr;
    u32 w = bf_put(p[0] | (p[1] << 8) | (p[2] << 16) | ((u32)p[3] << 24), shift, width, v);
    p[0] = (u8)w;
    p[1] = (u8)(w >> 8);
    p[2] = (u8)(w >> 16);
    p[3] = (u8)(w >> 24);
}

#endif
