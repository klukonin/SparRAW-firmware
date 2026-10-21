// SPDX-License-Identifier: AGPL-3.0-or-later
/* Память, деление и 64-битный сдвиг uc.
 *
 * Скорость важна: побайтная memset_uc на железе уже ломала временные окна (ассоциации не
 * было, найдено бисекцией гибридов). Поэтому копирование/заполнение — словами, O2, а
 * распознавание циклов как memcpy/memset выключено (иначе GCC подставит вызов самого себя). */
#include "../include/types.h"
#include "../include/arc.h"

#define MEM_FAST __attribute__((optimize("O2", "no-tree-loop-distribute-patterns")))

/* Копирование. При выровненных dst и src — словами: блоки по 16 Б (4 чтения, затем
 * 4 записи), затем 8 Б, 4 Б, хвост байтами; иначе побайтно. Порядок чтений/записей
 * важен для перекрывающихся областей (dst > src) — он тот же, что у прежней реализации. */
MEM_FAST
void *memcpy_uc(void *dst, const void *src, u32 len)
{
    u8 *d = dst;
    const u8 *s = src;

    if (len == 0)
        return dst;
    if ((((u32)d | (u32)s) & 3) == 0) {
        u32 *dw = (u32 *)d;
        const u32 *sw = (const u32 *)s;
        u32 n = len >> 4;
        if (n) {
            /* Блоки по 16 Б: цикл без накладных расходов, 8 инструкций на блок (GCC даёт
             * 10 и сохраняет r13..r15). Сначала 4 чтения, потом 4 записи. */
            __asm__ volatile("mov lp_count,%2\n\t"
                             "nop_s\n\t"
                             "lp 1f\n\t"
                             "ld.ab r4,[%0,4]\n\t"
                             "ld.ab r5,[%0,4]\n\t"
                             "ld.ab r6,[%0,4]\n\t"
                             "ld.ab r7,[%0,4]\n\t"
                             "st.ab r4,[%1,4]\n\t"
                             "st.ab r5,[%1,4]\n\t"
                             "st.ab r6,[%1,4]\n\t"
                             "st.ab r7,[%1,4]\n"
                             "1:"
                             : "+r"(sw), "+r"(dw)
                             : "r"(n)
                             : "r4", "r5", "r6", "r7", "lp_count", "memory");
        }
        if (len & 8) {
            u32 a = sw[0], b = sw[1];
            dw[0] = a;
            dw[1] = b;
            dw += 2;
            sw += 2;
        }
        if (len & 4)
            *dw++ = *sw++;
        d = (u8 *)dw;
        s = (const u8 *)sw;
        len &= 3;
    }
    while (len--)
        *d++ = *s++;
    return dst;
}

/* Заполнение байтом v: голова байтами до выравнивания, середина словами, хвост байтами
 * (при n < 8 — всё байтами). */
MEM_FAST
void *memset_uc(void *dst, u8 v, u32 n)
{
    u8 *d = dst;
    u32 w = v * 0x01010101u;

    if (n >= 8) {
        while ((u32)d & 3) {
            *d++ = v;
            n--;
        }
        u32 *dw = (u32 *)d;
        for (u32 k = n >> 2; k; k--)
            *dw++ = w;
        d = (u8 *)dw;
        n &= 3;
    }
    while (n--)
        *d++ = v;
    return dst;
}

/* Обнуление len байт. Выровненные адрес и длина — словами по 8 за проход (сначала
 * остаток len/4 mod 8), иначе — memset_uc. */
MEM_FAST
void *memset0_words_uc(void *dst, u32 len)
{
    if (len == 0)
        return dst;
    if (((u32)dst | len) & 3)
        return memset_uc(dst, 0, len);
    u32 *d = dst;
    u32 n = len >> 2;
    for (u32 k = n & 7; k; k--)
        *d++ = 0;
    for (u32 k = n >> 3; k; k--) {
        d[0] = 0; d[1] = 0; d[2] = 0; d[3] = 0;
        d[4] = 0; d[5] = 0; d[6] = 0; d[7] = 0;
        d += 8;
    }
    return dst;
}

/* Кадр в TX FIFO (ХРУПКО — см. ниже): слова через r33, хвост 1..3 байта через r34; счётчик свободного места
 * 0x800514 уменьшается на len. src обязан быть выровнен на 4 (иначе assert 0x37 и
 * продолжение, как раньше). */
MEM_FAST
void tx_fifo_write_bytes(u32 src, u32 len)
{
    if (src & 3)
        uc_assert((u32)__builtin_return_address(0), 0x37);
    const u32 *w = (const u32 *)src;
    u32 n = len >> 2;
    if (n) {
        /* Слово прямо в r33 (порт FIFO), цикл без накладных расходов: 2 инструкции на
         * слово, как раньше (C-цикл с ld + mov r33 — в 2,5 раза медленнее). Пустая
         * инструкция после записи в r33 — как было; убирать без проверки на железе нельзя. */
        __asm__ volatile("mov lp_count,%1\n\t"
                         "nop_s\n\t"
                         "lp 1f\n\t"
                         "ld.ab r33,[%0,4]\n\t"
                         "mov 0,0\n"
                         "1:"
                         : "+r"(w)
                         : "r"(n)
                         : "lp_count", "memory");
    }
    /* ХРУПКО: хвост 1..3 байта — загрузкой прямо в порт r34 («ldb.ab r34,[src,1]», одна
     * инструкция на байт, как vendor 0x9257f4); функция на пути подачи кадра в FIFO во время
     * передачи (см. fifo_write_chunked в txss.c) — не замедлять. */
    const u8 *b = (const u8 *)w;
    switch (len & 3) {
    case 3:
        __asm__ volatile("ldb.ab r34,[%0,1]\n\tldb.ab r34,[%0,1]\n\tldb r34,[%0]" : "+r"(b) :: "memory");
        break;
    case 2:
        __asm__ volatile("ldb.ab r34,[%0,1]\n\tldb r34,[%0]" : "+r"(b) :: "memory");
        break;
    case 1:
        __asm__ volatile("ldb r34,[%0]" :: "r"(b) : "memory");
        break;
    }
    tx_fifo_free -= len;
}

/* Число ведущих нулей x != 0 через norm (без __clzsi2 из libgcc). */
static inline u32 clz32(u32 x)
{
    return (s32)x < 0 ? 0 : arc_norm(x) + 1;
}

/* Деление без знака с остатком: возврат (остаток << 32) | частное. Делитель
 * выравнивается под делимое по старшему биту, дальше — вычитание со сдвигом
 * (не больше 32 шагов, быстрее побитного __udivsi3 из libgcc).
 * Деление на 0: частное 0x7fffffff (делимое < 2^31) или 0x80000000, остаток = делимое —
 * вызывающие на это полагаются (например, rx.c: «vendor: деление на 0»). */
MEM_FAST
u64 uc_divmod_unsigned_qr(u32 n, u32 d)
{
    if (d == 0)
        return ((u64)n << 32) | ((s32)n < 0 ? 0x80000000u : 0x7fffffffu);
    u32 q = 0;
    if (n >= d) {
        u32 sh = clz32(d) - clz32(n);
        d <<= sh;
        for (u32 bit = 1u << sh; bit; bit >>= 1, d >>= 1) {
            if (n >= d) {
                n -= d;
                q |= bit;
            }
        }
    }
    return ((u64)n << 32) | q;
}

/* Деление со знаком (усечение к нулю, остаток со знаком делимого): возврат
 * (остаток << 32) | частное. Деление на 0 — как у беззнакового от модуля делимого:
 * остаток = |a|, частное 0x7fffffff или 0x80000000 (при a = INT_MIN), без знаков. */
u64 uc_divmod_signed_qr(s32 a, s32 b)
{
    u32 ua = a < 0 ? 0u - (u32)a : (u32)a;
    u32 ub = b < 0 ? 0u - (u32)b : (u32)b;
    u64 r = uc_divmod_unsigned_qr(ua, ub);
    if (ub == 0)
        return r;
    u32 q = (u32)r, m = (u32)(r >> 32);
    if ((a < 0) != (b < 0))
        q = 0u - q;
    if (a < 0)
        m = 0u - m;
    return ((u64)m << 32) | q;
}

u32 uc_divmod_unsigned(u32 n, u32 d)
{
    return (u32)uc_divmod_unsigned_qr(n, d);
}

/* (hi:lo) << (shift mod 64). */
u64 uc_shl64(u32 lo, u32 hi, u32 shift)
{
    shift &= 63;
    if (shift == 0)
        return ((u64)hi << 32) | lo;
    if (shift < 32) {
        hi = (hi << shift) | (lo >> (32 - shift));
        lo <<= shift;
    } else {
        hi = lo << (shift - 32);
        lo = 0;
    }
    return ((u64)hi << 32) | lo;
}
