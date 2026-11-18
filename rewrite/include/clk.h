/* SPDX-License-Identifier: AGPL-3.0-or-later */
#ifndef SPARRAW_CLK_H
#define SPARRAW_CLK_H
#include "types.h"
/* Такт ядра — единственный источник всех счётов тактов fw и uc. ARC fw, uc, MAC, таймер планировщика fw (0x880254) и
 * чиповая частота PHY тактируются от одной PLL baseband: f = f_опоры · N / 32, N — множитель в 0x8893f8 (сброс 132:
 * 40 МГц · 132 / 32 = 165 МГц). Стенд 2026-11-18: темп TSF по часам хоста = N/132 на
 * N 111…137; линк — только при равном N у обоих узлов (PHY меняется вместе с ядром). Интервалы 802.11-2020 задаются в
 * мкс и переводятся в такты от этой частоты, а не литералами «165». open работает на N = 132 (165 МГц).
 * Опора 40 МГц — у плат B0 (делитель мкс MAC в обходе PLL 0x28 = 40, fw hw_pll_mode_switch); у прочих vendor ставит 0x26 —
 * опора таких плат не установлена. */
#define CLK_PLL_N_REG    0x8893f8u      /* множитель PLL baseband (никто не пишет: значение сброса) */
#define CLK_REF_MHZ      40u
#define CLK_PLL_N_RESET  132u

/* Такт ядра в МГц по множителю: целое при N ≡ 0 (mod 4) — делитель мкс MAC целый, дробных МГц нет. */
static inline __attribute__((always_inline)) u32 clk_mhz_of_n(u32 n)
{
    return CLK_REF_MHZ * n / 32u;
}
#endif
