/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Динамическое распределение SP (802.11-2020 10.39.7): расчёт полей Polling Period и Grant Period и кадры Poll / SPR
 * (основа PP/GP строгого TDMA, docs/TDMA.md §6). Обмен PP/GP в эфир — следующий шаг; здесь только то, что
 * однозначно задаёт стандарт, — в целых мкс поля Duration / Response Offset, сверено с ref/duration и ref/dynalloc
 * (tests/unit/test_tdma_dynalloc.py).
 *
 * PP (10.39.7.2, ур. (10-18)), n Poll подряд через SBIFS, SPR_j — через Response Offset от конца своего Poll
 * (PLAN.md №45: O_1 = SIFS), одна антенна (A_k = 0, №46), SPR одной длины:
 *   D_i,n = Ceil(Σ_{k=i+1..n} (TXTIME(Poll_k) + SBIFS + A_k + S), T_TR), S = aSBIFSAccuracy (0,03 мкс);
 *   O_1 = SIFS, O_j = O_{j−1} + Ceil(TXTIME(SPR) + SIFS, T_TR);
 *   Duration_i = D_i,n + O_n + Ceil(TXTIME(SPR_n), T_TR), Response Offset_i = D_i,n + O_i.
 * SPR (10.39.7.2): Duration = Duration Poll − Response Offset − TXTIME(SPR) (вверх, 9.2.5.1; не меньше 0).
 * GP (10.39.7.3, PLAN.md №48): Grant подряд через SBIFS (после Grant Ack — SIFS); Duration Grant k — до начала
 * выделения (все следующие Grant, Grant Ack и IFS), последнего — 0 или SIFS + TXTIME(Grant Ack).
 * Время — сотые такта 165 МГц (S = 4,95 такта — не целое), вверх до мкс. Не на путях со сроком. */
#include "../include/types.h"
#include "ifs.h"

#define DYN_POLL_LEN      22u                   /* рис. 9-49 (с FCS) */
#define DYN_SPR_LEN       27u                   /* рис. 9-50 */
#define DYN_GRANT_LEN     27u                   /* рис. 9-51 */
#define DYN_GRANT_ACK_LEN 27u                   /* рис. 9-57 */
#define DYN_CC(clk)       ((clk) * 100u)        /* такты → сотые такта */
#define DYN_S_CC          495u                  /* aSBIFSAccuracy 0,03 мкс = 4,95 такта */
#define DYN_US_CC         (DMG_CLK_PER_US * 100u)
#define DYN_TX_POLL_CC    DYN_CC(DMG_CTRL_TXTIME_CLK(DYN_POLL_LEN))
#define DYN_TX_SPR_CC     DYN_CC(DMG_CTRL_TXTIME_CLK(DYN_SPR_LEN))
#define DYN_TX_GRANT_CC   DYN_CC(DMG_CTRL_TXTIME_CLK(DYN_GRANT_LEN))
#define DYN_TX_GACK_CC    DYN_CC(DMG_CTRL_TXTIME_CLK(DYN_GRANT_ACK_LEN))
#define DYN_SIFS_CC       DYN_CC(DMG_SIFS_CLK)
#define DYN_SBIFS_CC      DYN_CC(DMG_SBIFS_CLK)
_Static_assert(DMG_CTRL_TXTIME_CLK(DYN_POLL_LEN) == 2364u && DMG_CTRL_TXTIME_CLK(DYN_SPR_LEN) == 2484u,
               "TXTIME(Poll) 14,327 мкс, TXTIME(SPR) 15,055 мкс (Control PHY)");

static u32 dyn_ceil_us(u32 cc)
{
    return (cc + DYN_US_CC - 1u) / DYN_US_CC;
}

/* O_j, мкс (j ≥ 1). */
u32 dyn_pp_o_us(u32 j)
{
    return 3u + (j - 1u) * dyn_ceil_us(DYN_TX_SPR_CC + DYN_SIFS_CC);
}

/* Poll i из n (1 ≤ i ≤ n): Duration, мкс; *ro — Response Offset, мкс (SPR j = i). */
u32 dyn_pp_poll(u32 i, u32 n, u32 *ro)
{
    u32 din = dyn_ceil_us((n - i) * (DYN_TX_POLL_CC + DYN_SBIFS_CC + DYN_S_CC));
    *ro = din + dyn_pp_o_us(i);
    return din + dyn_pp_o_us(n) + dyn_ceil_us(DYN_TX_SPR_CC);
}

/* Duration SPR в ответ на Poll (10.39.7.2). */
u32 dyn_spr_duration(u32 poll_dur, u32 ro)
{
    u32 a = DYN_CC(DMG_CLK_PER_US) * poll_dur, b = DYN_CC(DMG_CLK_PER_US) * ro + DYN_TX_SPR_CC;
    return a > b ? dyn_ceil_us(a - b) : 0u;
}

/* Grant k из n (0 ≤ k < n) в GP; ack_mask — б j: за Grant j следует Grant Ack (Grant Ack Supported, 10.39.4).
 * Duration — до начала выделения: остаток GP после этого Grant (10.39.7.3). */
u32 dyn_gp_grant_duration(u32 k, u32 n, u32 ack_mask)
{
    u32 rest = 0;                               /* сотые такта от конца Grant k до начала выделения */
    for (u32 j = k; j < n; j++) {
        if (j != k)
            rest += DYN_TX_GRANT_CC;
        if (ack_mask & (1u << j))
            rest += DYN_SIFS_CC + DYN_TX_GACK_CC;
        if (j + 1u < n)
            rest += (ack_mask & (1u << j)) ? DYN_SIFS_CC : DYN_SBIFS_CC;
    }
    return dyn_ceil_us(rest);
}

/* Кадр Poll (9.3.1.10, рис. 9-49) в формате прямой передачи (struct dtx_ctrl_frame: RA/TA вставляет MAC): FC
 * Control Frame Extension 2, Duration, Response Offset — 2 октета после TA. */
void dyn_poll_frame_init(struct dtx_ctrl_frame *dst, u32 dur, u32 ro)
{
    dst->fc = 0x0264;
    dst->duration = (u16)dur;
    dst->alloc = ro & 0xffffu;
    dst->w14 = 0;
}

/* Кадр SPR (9.3.1.11, рис. 9-50): Dynamic Allocation Info (9.5.2) и BF Control (0) — как у Grant (frame_hdr_init,
 * uc/misc.c), FC Control Frame Extension 3. */
void dyn_spr_frame_init(struct dtx_ctrl_frame *dst, const struct dtx_grant_req *src)
{
    frame_hdr_init(dst, 0, src);
    dst->fc = 0x0364;
}
