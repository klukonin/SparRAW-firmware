// SPDX-License-Identifier: AGPL-3.0-or-later
/* Базовые целые типы. */
#ifndef REWRITE_TYPES_H
#define REWRITE_TYPES_H

typedef unsigned char      u8;
typedef unsigned short     u16;
typedef unsigned int       u32;
typedef unsigned long long u64;

typedef signed char        s8;
typedef signed short       s16;
typedef signed int         s32;
typedef signed long long   s64;

typedef unsigned int       uintptr;
typedef u32                size_t_unused;

/* Подсказки вероятности ветвей для GCC. При -Os раскладку блоков НЕ гарантируют —
 * для путей, критичных по времени, — optimize("O2") или inline-__asm__ (RAG, урок 59). */
#define likely(x)   __builtin_expect(!!(x), 1)
#define unlikely(x) __builtin_expect(!!(x), 0)

/* Обращение к объекту как к volatile (опрос из прерываний/железа/другого ядра): VOL(itx_mcs). */
#define VOL(x) (*(volatile __typeof__(x) *)&(x))

#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))

#endif
