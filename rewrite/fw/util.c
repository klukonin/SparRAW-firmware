// SPDX-License-Identifier: AGPL-3.0-or-later
/* Базовые утилиты: memset, битовые поля. */
#include "../include/types.h"
#include "../include/fwdata.h"

/* Побайтовый memset (val — байт). */
void memset_fw(void *dst, u32 val, u32 len)
{
    u8 *p = (u8 *)dst;
    while (len--)
        *p++ = (u8)val;
}

/* 0x803b68: таблица переходов vendor memset0_words (0x8c1cd8): ldb.x, 8 записей, цель = 0x8c1d1c + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803b68) __attribute__((aligned(1))) const u8 memset0_words_jt[8] = {
    0x0e, 0x00, 0x02, 0x04, 0x06, 0x08, 0x0a, 0x0c,
};

/* Обнуление словами: быстрый путь по 4 байта, байтовый fallback при
 * невыравненных dst/len. Семантика — как у вендорского memset0_words. */
void memset0_words(void *dst, u32 len)
{
    if (len == 0)
        return;
    if (((u32)dst & 3) || (len & 3)) {
        memset_fw(dst, 0, len);
        return;
    }
    u32 *p = (u32 *)dst;
    u32 n = len >> 2;
    while (n--)
        *p++ = 0;
}

/* Установить битовое поле в слове [start .. start+width-1]. */
void bits_set_word(u32 *p, u32 start, u32 width, u32 v)
{
    u32 mask = ((1u << width) - 1) << start;
    *p = (*p & ~mask) | ((v << start) & mask);
}

/* Побайтовый memcpy. */
void memcpy_fw(void *dst, const void *src, u32 len)
{
    u8 *d = (u8 *)dst;
    const u8 *s = (const u8 *)src;
    while (len--)
        *d++ = *s++;
}
