/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Простой TDMA точки (open): время DTI поровну между связанными станциями (решение пользователя
 * 2026-10-23). Включается сам при TDMA_MIN_STA и более станциях, при меньшем числе снимается —
 * весь DTI снова CBAP (CBAP Only = 1).
 *
 * Расписание — Extended Schedule в маяке (802.11-2020 9.4.2.131, 10.39.6), псевдостатическое (B7 = 1,
 * один блок): каждый BI одинаково.
 *  - Окна начинаются после BTI и A-BFT: T0 = n·(TXTIME(маяк) + SBIFS) + MBIFS + L·aSSSlotTime(FSS) + MBIFS
 *    (10.39.2, 10.42.5.2; A-BFT закладывается в каждый BI — окна обходят его и там, где его нет).
 *  - Первое — общее CBAP {Source = Destination = 255}: вход новых станций (запрос ассоциации, SLS) —
 *    без него у станции без своего окна нет права начать обмен (10.39.5).
 *  - Затем по одному CBAP {Source = AID станции i, Destination = AID точки} равной длины: по 10.39.5
 *    начинать обмен в окне могут только станция i и точка — трафик в обе стороны без опросов и RD.
 *  - Между соседними окнами — Tguard (10.39.6.5), A = dot11MaxLostBeacons = 4 (псевдостатические),
 *    C = aDMGTSFAccuracy = 20 ppm, D = BI, + aSIFSTime 3 мкс + aAirPropagationTime 0,1 мкс + aTSFResolution 1 мкс.
 * Своя таблица окон точки (ese_slot_tbl, 3 записи) не заполняется: точка — назначение каждого окна и по
 * 10.39.5 может начинать обмен в любом; при N ≥ 3 таблица переполнилась бы (фатал 0x11bb).
 * ESE добавляется в блок IE маяка (тип 0) к IE хоста, а не вместо них (vendor-сборщик блок заменял). */
#include "../include/types.h"
#include "../include/mid.h"
#include "../include/conn.h"
#include "../include/fwsh.h"
#include "../include/sched_scheme.h"
#include "../include/abft_cfg.h"
#include "../uc/ifs.h"                      /* только макросы TXTIME/IFS в тактах 165 МГц */

/* aSSSlotTime (10.42.5.2) в тактах — та же формула, что abft_slot_clk() в uc/abft.h (тот заголовок в fw не
 * включается: в нём функции uc): aAirPropagationTime (17) + aSSDuration + MBIFS + aSSFBDuration + MBIFS,
 * aSSDuration = (поле FSS + 1)·(TXTIME(SSW) + SBIFS) − SBIFS, aSSFBDuration = TXTIME(SSW-Feedback). */
#define TDMA_ABFT_SLOT_CLK(fss) (((fss) + 1u) * (DMG_TXTIME_SSW_CLK + DMG_SBIFS_CLK) - DMG_SBIFS_CLK + \
                                 17u + DMG_MBIFS_CLK + DMG_TXTIME_SSW_ACK_CLK + DMG_MBIFS_CLK)

#ifndef TDMA_MIN_STA
#define TDMA_MIN_STA 2u                     /* станций для включения (стенд: FW_DBG=-DTDMA_MIN_STA=1) */
#endif
#define TDMA_COMMON_US     2000u            /* общее окно CBAP 255→255 */
#define TDMA_MAX_STA       8u               /* CONN_MAX */
#define EID_EXT_SCHED_IE   0x90u
#define ESE_FIELD_LEN      15u
#define MAX_LOST_BEACONS   4u               /* dot11MaxLostBeacons, DEFVAL (Annex C) */
#define TSF_ACC_PPM        20u              /* aDMGTSFAccuracy (Table 20-30) */

/* Tguard (10.39.6.5) для двух соседних псевдостатических окон, мкс (вверх). */
static u32 tdma_guard_us(u32 bi_us)
{
    u32 drift = 2u * (MAX_LOST_BEACONS + 1u) * TSF_ACC_PPM * bi_us;      /* ·10^-6 мкс */
    u32 us = (drift + 999999u) / 1000000u;
    return us + 3u /* SIFS */ + 1u /* T_P 0,1 → вверх */ + 1u /* T_TR */;
}

/* Конец BTI + A-BFT от TBTT, мкс (вверх): ese_len — сколько байт ESE добавится к маяку. */
static u32 tdma_dti_start_us(const struct mid *mid, u32 ese_len)
{
    u32 n = fwsh_total_sectors != 0 ? fwsh_total_sectors : 1u;
    u32 ant = fwsh_n_rx_ant > 1 ? fwsh_n_rx_ant : 1u;
    u32 L = FWSH(fwsh_diag, bcn_psdu_len) + ese_len;
    if (L < 6u)
        L = 6u;
    u32 bcn_clk = DMG_CTRL_TXTIME_CLK(L) + DMG_SBIFS_CLK;
    u32 bti_clk = n * ant * bcn_clk;
    u32 slots = (u32)mid->bss.abft_len + 1u;
    u32 abft_clk = DMG_MBIFS_CLK + slots * TDMA_ABFT_SLOT_CLK(ABFT_FSS_FIELD);
    return (bti_clk + abft_clk + DMG_MBIFS_CLK + DMG_CLK_PER_US - 1u) / DMG_CLK_PER_US;
}

static void tdma_put_field(u8 *f, u32 id, u32 src, u32 dst, u32 start, u32 dur)
{
    for (u32 i = 0; i < ESE_FIELD_LEN; i++)
        f[i] = 0;
    f[0] = (u8)((id & 0xfu) | (1u << 4) /* CBAP */ | (1u << 7) /* pseudo-static */);
    f[4] = (u8)src;
    f[5] = (u8)dst;
    f[6] = (u8)start;
    f[7] = (u8)(start >> 8);
    f[8] = (u8)(start >> 16);
    f[9] = (u8)(start >> 24);
    f[10] = (u8)dur;
    f[11] = (u8)(dur >> 8);
    f[12] = 1;                              /* Number of Blocks */
}

/* Блок IE маяка (тип 0): все IE, кроме прежнего ESE, плюс ese (len 0 — только убрать ESE). */
static void tdma_set_beacon_ese(struct mid *mid, const u8 *ese, u32 len)
{
    struct app_ies *blk = mid_app_ie_block(&mid->bss, 0);
    const u8 *old = (const u8 *)blk->buf;
    u32 olen = old != 0 ? blk->len : 0u;
    u32 buf = TX_API_alloc_tx_payload();
    u8 *d = (u8 *)buf;
    u32 n = 0;
    for (u32 i = 0; i + 2u <= olen && i + 2u + old[i + 1] <= olen; i += 2u + old[i + 1]) {
        if (old[i] == EID_EXT_SCHED_IE)
            continue;
        memcpy_fw(d + n, old + i, 2u + old[i + 1]);
        n += 2u + old[i + 1];
    }
    memcpy_fw(d + n, ese, len);
    n += len;
    if (n == 0) {
        TX_API_free_memory(buf);
        buf = 0;
    }
    mid_set_app_ie_block(&mid->bss, 0, n, buf);
}

/* Пересобрать расписание точки: связь или разрыв станции (exclude — разрываемое соединение). */
void tdma_ap_update(struct mid *mid, const struct conn *exclude)
{
    u8 aid[TDMA_MAX_STA];
    u32 n = 0, it;
    struct sched_scheme *ss = mid->sched;
    if (mid->bss.mode != 2 && mid->bss.mode != 3)
        return;                             /* только AP/PCP */
    iter_init(&it, &mid->conns);
    while (list_has_items(&it) && n < TDMA_MAX_STA) {
        struct conn *c = (struct conn *)iter_next(&it);
        u32 st = c->msm.sm.state;
        /* связанная станция: состояние 5..7 (ASSOCIATED, WAIT_FOR_LM_START, KEY_ASSOC). AID: при SME
         * хоста — из его ответа (conn->aid, mlme_sm_on_ctrl_assoc_response_ret); при SME прошивки
         * conn->aid = 0, а в Assoc Response уходит cid + 1 (mgmt_tx_build_assoc_resp). */
        if (c != exclude && st >= 5 && st <= 7)
            aid[n++] = c->aid != 0 ? c->aid : (u8)(c->cid + 1u);
    }
    if (n < TDMA_MIN_STA) {
        if (ss->built != 0) {
            fw_log_emit0(0x2b, 0x1014510);  /* «Clearing scheme» */
            ss->built = 0;                  /* CBAP Only = 1 (builder_push_dmg_parameters) */
            tdma_set_beacon_ese(mid, 0, 0);
            add_bcon(mid);
        }
        return;
    }
    u8 ie[2u + (TDMA_MAX_STA + 1u) * ESE_FIELD_LEN];
    u32 ese_len = 2u + (n + 1u) * ESE_FIELD_LEN;
    u32 bi = mac_get_beacon_interval_us();
    u32 g = tdma_guard_us(bi);
    u32 t0 = tdma_dti_start_us(mid, ese_len) + g;
    u32 need = t0 + TDMA_COMMON_US + (n + 1u) * g + n * 1000u;   /* окно станции — не меньше 1 мс */
    if (need >= bi)
        return;                             /* BI мал для расписания — DTI остаётся как есть */
    u32 w = (bi - t0 - TDMA_COMMON_US - (n + 1u) * g) / n;
    u32 base = mac_get_bi_start_tsf() + bi;  /* Allocation Start — TSF в следующем BI */
    ie[0] = EID_EXT_SCHED_IE;
    ie[1] = (u8)(ese_len - 2u);
    u32 t = t0;
    tdma_put_field(&ie[2], 0, 0xff, 0xff, base + t, TDMA_COMMON_US);
    t += TDMA_COMMON_US + g;
    for (u32 i = 0; i < n; i++) {
        tdma_put_field(&ie[2u + (i + 1u) * ESE_FIELD_LEN], i + 1u, aid[i], mid->aid, base + t, w);
        t += w + g;
    }
    ss->built = 1;                          /* CBAP Only = 0 */
    tdma_set_beacon_ese(mid, ie, ese_len);
    add_bcon(mid);
    fw_log_emit1(0x2b, 0x1014450, n + 1u); /* «Number of slots in cmd» */
}
