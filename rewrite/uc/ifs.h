/* SPDX-License-Identifier: AGPL-3.0-or-later */
#ifndef UC_IFS_H
#define UC_IFS_H
/* Межкадровые интервалы и длительности кадров DMG по 802.11-2020 — в тактах ядра (MAC/uc/fw). Такт — текущий
 * (include/clk.h; uc — CLKK, значения вписывает fw при старте, uc/clkk.h; fw — CLK_MHZ по множителю PLL): интервалы заданы в мкс и
 * пересчитываются от него (X_AT(f) — при такте f МГц, X — при текущем); _Static_assert сверяют значения при такте
 * сброса PLL (CLK_MHZ_RESET, 165 МГц). Длительности кадров (TXTIME) — в тактах без пересчёта: чиповая частота PHY идёт
 * от той же PLL (3/32 такта на чип при любом множителе, include/clk.h). Константы стандарта, а не подобранные значения:
 * где код отходит от них, это сказано у места использования.
 *
 * aSIFSTime 3 мкс, aSBIFSTime 1 мкс, aSlotTime 5 мкс (Table 20-30); PIFS = aSIFSTime + aSlotTime
 * (10-5); MBIFS = 3·aSIFSTime (10.3.2.3.10); LBIFS = TXTIME(SSW) + 2·SBIFS (10.3.2.3.11). */
#include "../include/clk.h"
#if !defined(CLK_MHZ) && !defined(UC_CLKK)
#error "CLK_MHZ — такт ядра fw в МГц (до включения ifs.h); у uc такт — CLKK (uc/clkk.h, -DUC_CLKK)"
#endif
#define CLK_MHZ_RESET    (CLK_REF_MHZ * CLK_PLL_N_RESET / 32u)   /* 165 */
#ifdef UC_CLKK
#define DMG_CLK_PER_US   CLKK(MHZ)
#else
#define DMG_CLK_PER_US   CLK_MHZ
#endif
#define DMG_SIFS_CLK_AT(f)   (3u * (f))
#define DMG_SBIFS_CLK_AT(f)  (1u * (f))
#define DMG_SLOT_CLK_AT(f)   (5u * (f))
#define DMG_PIFS_CLK_AT(f)   (DMG_SIFS_CLK_AT(f) + DMG_SLOT_CLK_AT(f))
#define DMG_MBIFS_CLK_AT(f)  (3u * DMG_SIFS_CLK_AT(f))
#define DMG_SIFS_CLK     DMG_SIFS_CLK_AT(DMG_CLK_PER_US)
#define DMG_SBIFS_CLK    DMG_SBIFS_CLK_AT(DMG_CLK_PER_US)
#define DMG_SLOT_CLK     DMG_SLOT_CLK_AT(DMG_CLK_PER_US)
#define DMG_PIFS_CLK     DMG_PIFS_CLK_AT(DMG_CLK_PER_US)
#define DMG_MBIFS_CLK    DMG_MBIFS_CLK_AT(DMG_CLK_PER_US)
/* aPPDUMaxTime DMG — 2 мс (Table 20-30): PPDU (с полем TRN) не длиннее. Предел ожиданий событий конца/отчёта
 * принимаемого PPDU: за aPPDUMaxTime от любого момента приёма PPDU заведомо кончился (uc_spin_until_event_tmo). */
#define DMG_PPDU_MAX_US  2000u
#define DMG_PPDU_MAX_CLK (DMG_PPDU_MAX_US * DMG_CLK_PER_US)

/* TXTIME кадра control PHY (MCS0) длиной L байт (с FCS), 20.11.3 (N_CW — 20.4.3.3.3):
 *   TXTIME = T_STF + T_CE + (11·8 + (L − 6)·8 + N_CW·168)·32·Tc,  N_CW = 1 + ⌈(L − 6)·8 / 168⌉,
 *   Tc = 1/1760 МГц, T_STF = 6400·Tc (3,636 мкс), T_CE = 1152·Tc (0,655 мкс).
 * Такт ядра / чиповая частота = 3/32 при любом множителе PLL (обе — от одной PLL, include/clk.h); результат вверх. */
#define DMG_CTRL_NCW(L)        (1u + (((L) - 6u) * 8u + 167u) / 168u)
#define DMG_CTRL_TXTIME_TC(L)  (6400u + 1152u + (88u + ((L) - 6u) * 8u + DMG_CTRL_NCW(L) * 168u) * 32u)
#define DMG_CTRL_TXTIME_CLK(L) ((DMG_CTRL_TXTIME_TC(L) * 3u + 31u) / 32u)

/* SSW: FC 2 + Duration 2 + RA 6 + TA 6 + SSW 3 + SSW Feedback 3 + FCS 4 = 26 Б (9.3.1.15);
 * SSW-Ack: FC 2 + Duration 2 + RA 6 + TA 6 + SSW Feedback 3 + BRP Request 4 + Beamformed Link
 * Maintenance 1 + FCS 4 = 28 Б (9.3.1.17); SSW-Feedback — те же поля, 28 Б (9.3.1.16, Figure 9-55). */
#define DMG_SSW_LEN      26u
#define DMG_SSW_ACK_LEN  28u
#define DMG_SSW_FB_LEN   28u
#define DMG_TXTIME_SSW_CLK      DMG_CTRL_TXTIME_CLK(DMG_SSW_LEN)       /* 2460 = 14,909 мкс */
#define DMG_TXTIME_SSW_ACK_CLK  DMG_CTRL_TXTIME_CLK(DMG_SSW_ACK_LEN)   /* 3012 = 18,255 мкс */
#define DMG_TXTIME_SSW_FB_CLK   DMG_CTRL_TXTIME_CLK(DMG_SSW_FB_LEN)    /* 3012 = 18,255 мкс */
/* Duration ответов через SIFS (9.3.1.6, 9.3.1.18): Duration пира минус TXTIME(ответа) + SIFS, результат вверх
 * (9.2.5.1): для целого D ⌈D − x⌉ = D − ⌊x⌋ — вычитаемое вниз (было вверх → Duration на 1 мкс меньше, NAV соседей
 * кончался раньше конца последовательности; tests/unit/test_uc_ifs_duration.py).
 * CF-End — FC, Duration, RA, TA, FCS = 20 Б; Grant Ack — FC, Duration, RA, TA, 7 Б тела, FCS = 27 Б. */
#define DMG_CF_END_LEN           20u
#define DMG_GRANT_ACK_LEN        27u
#define DMG_RESP_DUR_SUB_US_AT(len, f) ((DMG_CTRL_TXTIME_CLK(len) + DMG_SIFS_CLK_AT(f)) / (f))
/* CF-End в ответ на CF-End (9.3.1.6): принят Duration d = ⌈(i − 1)·x⌉, x = TXTIME(CF-End) + SIFS, ответ — ⌈(i − 2)·x⌉.
 * Разность двух округлений вверх — то ⌊x⌋, то ⌈x⌉, вычитанием точно не получить: k = i − 1 восстанавливается
 * округлением d/x (ошибка < 1 мкс при x ≈ 17 мкс). d ≤ 32767 — d·f в 32 битах. */
#define DMG_CF_END_X_CLK_AT(f) (DMG_CTRL_TXTIME_CLK(DMG_CF_END_LEN) + DMG_SIFS_CLK_AT(f))
_Static_assert(DMG_CF_END_X_CLK_AT(CLK_MHZ_RESET) == 2811u, "x при 165 МГц");
/* Путь ответа в сроке SIFS: деления — умножением на обратное (mulu64, сдвиг 36). Обратные m = ⌈2^36/делитель⌉ для x и
 * для f — CLKK(CF_END_MX/MF) (uc/clkk.h, вписывает fw при старте) — правило проверено перебором всех d = 0…32767 при
 * множителях PLL 108…140 (tests/unit/test_clk_cfg.py); при 165 МГц — прежние 24446630 (÷ 2811) и 416481678 (÷ 165). */
static inline __attribute__((always_inline)) u32 dmg_cf_end_resp_dur_us_with(u32 d, u32 f, u32 x, u32 mx, u32 mf)
{
    u32 k = (u32)(((u64)(d * f + x / 2u) * mx) >> 36);          /* ÷ x */
    return k < 2u ? 0u : (u32)(((u64)((k - 1u) * x + f - 1u) * mf) >> 36);   /* ⌈÷ f⌉ */
}
/* CF-End держателя TXOP (tx_send_and_await_rx_frame), 9.3.1.6: первый кадр усечения, на который отвечают CF-End
 * (10.23.2.10, 10.39.8.1), — i = 2: Duration = ⌈TXTIME(CF-End) + SIFS⌉ = 18 мкс (9.2.5.1); ответный — i = 1, 0
 * (dmg_cf_end_resp_dur_us). TXTIME — ответного CF-End (control PHY, tx_send_imm_response с rate 0).
 * 10.23.2.10: ненулевой Duration — только при остатке ≥ 2·T(CF-End) + 2·SIFS, CF-End вообще — пока остатка хватает на
 * сам кадр. Остаток (REMAINING_TIME_RD, мкс) читается до своего CF-End: к порогам — свой TXTIME(CF-End) и запас
 * DMG_CF_END_PATH_US на путь от чтения до начала кадра (не измерен; vendor брал +4 к своему порогу). */
#define DMG_TXTIME_CF_END_CLK       DMG_CTRL_TXTIME_CLK(DMG_CF_END_LEN)                           /* 2316 = 14,036 мкс */
#define DMG_CF_END_HOLDER_DUR_US_AT(f) ((DMG_CF_END_X_CLK_AT(f) + (f) - 1u) / (f))   /* i = 2: 18 при 165 */
#define DMG_CF_END_PATH_US          4u
#define DMG_CF_END_MIN_REM_US_AT(f) ((DMG_TXTIME_CF_END_CLK + (f) - 1u) / (f) + DMG_CF_END_PATH_US)
#define DMG_CF_END_NZ_REM_US_AT(f)  ((3u * DMG_TXTIME_CF_END_CLK + 2u * DMG_SIFS_CLK_AT(f) + (f) - 1u) / (f) \
                                     + DMG_CF_END_PATH_US)
_Static_assert(DMG_CF_END_HOLDER_DUR_US_AT(CLK_MHZ_RESET) == 18u, "Duration CF-End i = 2");
_Static_assert(DMG_CF_END_MIN_REM_US_AT(CLK_MHZ_RESET) == 19u && DMG_CF_END_NZ_REM_US_AT(CLK_MHZ_RESET) == 53u,
               "пороги CF-End по остатку");
/* TXTIME кадра DMG SC MCS 1 длиной L байт (с FCS), 20.11.3 и 20.5.3.2.3.3 (Table 20-15: N_CBPS 1, ρ = 2, R = 1/2;
 * L_CW 672, N_CBPB 448): N_CW = ⌈8·L / ((L_CW/ρ)·R)⌉ = ⌈L/21⌉, N_BLKS = ⌈N_CW·L_CW / N_CBPB⌉,
 * TXTIME = T_STF 2176·Tc + T_CE 1152·Tc + T_header 1024·Tc + (N_BLKS·512 + 64)·Tc; такты вверх (·3/32). */
#define DMG_SC1_NBLKS(L)        (((((L) + 20u) / 21u) * 672u + 447u) / 448u)
#define DMG_SC1_TXTIME_CLK(L)   (((2176u + 1152u + 1024u + DMG_SC1_NBLKS(L) * 512u + 64u) * 3u + 31u) / 32u)
_Static_assert(DMG_SC1_TXTIME_CLK(DMG_CF_END_LEN) == 510u, "TXTIME(CF-End, SC MCS 1) = 3,09 мкс");
/* Запись Duration командой 0x15 (H-DUR18, стенд 2026-11-04, PMC обоих узлов, docs/MAC-STAND.md «Duration в эфире»):
 * в режиме 0x14000007 у кадра FIFO, пущенного 0x18 без б12, MAC пишет в поле Duration 0x15 − ⌈TXTIME своего PPDU⌉
 * (CF-End держателя: 0x15 34 → 19, 18 → 3; ATIM 38 → 19; RTS keep-alive 40 → 25), с б12 (0x18001000, SLS в DTI) —
 * 0x15 буквально. Поэтому в 0x15 держателя — Duration плюс ⌈TXTIME⌉ своего CF-End на его MCS (rate tx_send_and_await_
 * rx_frame: 0 — control PHY, 1 — SC MCS 1). vendor: 0x22 = 19 + 15 и 0x17 = 19 + 4 — то же правило, другой Duration. */
#define DMG_CLK_TO_US_CEIL_AT(c, f)      (((c) + (f) - 1u) / (f))
#define DMG_CF_END_HOLDER_CMD_CTRL_AT(f) (DMG_CF_END_HOLDER_DUR_US_AT(f) + DMG_CLK_TO_US_CEIL_AT(DMG_TXTIME_CF_END_CLK, f))
#define DMG_CF_END_HOLDER_CMD_SC1_AT(f)  (DMG_CF_END_HOLDER_DUR_US_AT(f) + \
                                          DMG_CLK_TO_US_CEIL_AT(DMG_SC1_TXTIME_CLK(DMG_CF_END_LEN), f))
_Static_assert(DMG_CF_END_HOLDER_CMD_CTRL_AT(CLK_MHZ_RESET) == 33u && DMG_CF_END_HOLDER_CMD_SC1_AT(CLK_MHZ_RESET) == 22u,
               "0x15 CF-End держателя");
/* RTS keep-alive (internal_tx_keepalive_flow): FC, Duration, RA, TA, FCS = 20 Б (9.3.1.2); Duration 40 мкс — tx.c. */
#define DMG_RTS_LEN         20u
#define DMG_KA_RTS_DUR_US   40u
#define DMG_KA_RTS_CMD_AT(f)  (DMG_KA_RTS_DUR_US + DMG_CLK_TO_US_CEIL_AT(DMG_CTRL_TXTIME_CLK(DMG_RTS_LEN), f))
_Static_assert(DMG_KA_RTS_CMD_AT(CLK_MHZ_RESET) == 55u, "0x15 RTS keep-alive");
#define DMG_LBIFS_CLK_AT(f)  (DMG_TXTIME_SSW_CLK + 2u * DMG_SBIFS_CLK_AT(f))   /* 2790 = 16,909 мкс при 165 */
#define DMG_LBIFS_CLK        DMG_LBIFS_CLK_AT(DMG_CLK_PER_US)

_Static_assert(DMG_TXTIME_SSW_CLK == 2460, "TXTIME(SSW)");
_Static_assert(DMG_TXTIME_SSW_ACK_CLK == 3012, "TXTIME(SSW-Ack)");
_Static_assert(DMG_TXTIME_SSW_FB_CLK == 3012, "TXTIME(SSW-Feedback)");
_Static_assert(DMG_LBIFS_CLK_AT(CLK_MHZ_RESET) == 2790, "LBIFS");

/* LBIFS при смене DMG-антенны (802.11-2020 10.3.2.3.11, 10.42.2.2.2) — по стандарту, безусловно.
 * Действует только при смене антенны внутри развёртки: повтор ISS для каждой приёмной антенны пира
 * (sta_tab[].peer_n_ant ≥ 2) и наборы секторов fwsh_n_sets ≥ 2 в BTI. На стенде (один RF-модуль у обеих
 * сторон) эти пути не исполняются — НЕ ПРОВЕРЕНО на эфире.
 *
 *  1. Таймер между повторами (bcon_txss_sweep_step, GP группы 3, старт по tx_end — [гипотеза]): LBIFS = 2790
 *     тактов (DMG_LBIFS_CLK). Зазор в эфире = таймер + путь uc/MAC после MAC_EVT4_EXT_GP345_END (~100 инструкций до 0x19 +
 *     старт TX, не измерен): нижняя граница (−0 %) выполнена при любом пути, верхняя (+0,49 мкс) — если путь
 *     ≤ 0,49 мкс; точное значение (LBIFS − путь) — только по замеру на плате с несколькими RF-модулями.
 *  2. Длительность ISS (txss_sweep_timing): смена антенны заменяет SBIFS на LBIFS, т. е. добавляет
 *     LBIFS − SBIFS = TXTIME(SSW) + SBIFS = frame + gap (16 мкс). CDOWN считает LBIFS одной передачей
 *     (txss_program_tx_frame: (N − 1) + n·N, 10.42.2.2.2); Duration (ss_plan_tx_dur) на смене антенны
 *     уменьшается ещё на frame + gap (ss_plan_next_sector) — к концу развёртки остаётся то же, что при одной
 *     антенне.
 *  3. BTI (bti_measure_frame_duration): AP не меняет DMG-антенну внутри BTI (10.42.4), у нас один набор
 *     секторов на BTI (passes = 1 в bti_dispatch_sweep_step) — LBIFS в BTI нет, добавки к длительности нет. Если
 *     на плате с несколькими RF-модулями переключение набора в начале TXOP BTI потребует времени — признак
 *     assert 0x75. (В 6.2 было: таймер 0xa40 = TXTIME(SSW) + SBIFS − 1 такт, +17 мкс к ISS на смену, +10 мкс к
 *     BTI при fwsh_n_sets ≥ 2.) */

/* TXTIME Control PHY в тактах для длины, известной только во время работы (= DMG_CTRL_TXTIME_CLK(L)
 * без деления: N_CW = 1 + ⌈(L − 6)·8/168⌉ = 1 + ⌈(L − 6)/21⌉ — умножением с поправкой; ·165/1760 = ·3/32).
 * Проверено на хосте против макроса для L = 6…2000. */
static inline __attribute__((always_inline)) u32 dmg_ctrl_txtime_clk_rt(u32 L)
{
    u32 a = L - 6u, b = a + 20u;
    u32 q = (b * 3121u) >> 16;
    while (q * 21u > b)
        q--;
    while ((q + 1u) * 21u <= b)
        q++;
    u32 tc = 7552u + (88u + a * 8u + (1u + q) * 168u) * 32u;
    return (tc * 3u + 31u) >> 5;
}

/* ---- Тайм-ауты ответа (802.11-2020 10.3.2.9 CTSTimeout, 10.3.2.11 AckTimeout) ----
 * AckTimeout = CTSTimeout = aSIFSTime + aSlotTime + aRxPHYStartDelay (Table 20-30: aRxPHYStartDelay — 10 мкс в DMG
 * control mode, 3,6 мкс в SC; берётся худший — control: ответ может прийти в control mode) = 3 + 5 + 10 = 18 мкс.
 * Ожидание ответа в uc (sxd_hal_wait_slot2_busy2 / _busy) считает события slot2 — по одному на aSlotTime (слот MAC
 * HW_MAC_IFS_SLOT = ifs_cfg_clk[2] = 825 тактов, гипотеза H-SLOT2, проверяется опытом lat1) — до занятости эфира
 * (начало приёма). Число слотов = ⌈тайм-аут / aSlotTime⌉ = 4 (vendor 2 = 10 мкс — меньше AckTimeout: при позднем
 * ответе — ложный повтор). Long range — vendor 10, отдельно (не меняется). */
#define DMG_SLOT_US              5u
#define DMG_RX_PHY_START_DELAY_CTRL_US  10u   /* aRxPHYStartDelay, DMG control mode */
#define DMG_RX_PHY_START_DELAY_CTRL_CLK (DMG_RX_PHY_START_DELAY_CTRL_US * DMG_CLK_PER_US)
#define DMG_RESP_TIMEOUT_US      (3u + DMG_SLOT_US + DMG_RX_PHY_START_DELAY_CTRL_US)   /* 18 мкс */
#define DMG_RESP_TIMEOUT_CLK     (DMG_RESP_TIMEOUT_US * DMG_CLK_PER_US)               /* 2970 при 165 */
#define DMG_RESP_TIMEOUT_SLOTS   ((DMG_RESP_TIMEOUT_US + DMG_SLOT_US - 1u) / DMG_SLOT_US)   /* 4 — от такта не зависит */
/* Ожидание ответа BRP (10.3.2.3.9, 10.42.6.4 b): ответ начинается не позже BRPIFS (aBRPIFS 40 мкс + 10 %) после конца
 * нашей PPDU; транзакция кончается, если за BRPIFS + aSlotTime ответа нет; + aRxPHYStartDelay до обнаружения — как
 * AckTimeout. 44 + 5 + 10 = 59 мкс (GP0 от конца передачи запроса). Было (vendor) 8250 тактов = 50 мкс — ответ,
 * начатый в пределах BRPIFS, обнаруживался позже срока. */
#define DMG_BRPIFS_US            44u
#define DMG_BRPIFS_CLK           (DMG_BRPIFS_US * DMG_CLK_PER_US)
#define DMG_BRP_RESP_TIMEOUT_CLK ((DMG_BRPIFS_US + DMG_SLOT_US + DMG_RX_PHY_START_DELAY_CTRL_US) * DMG_CLK_PER_US)   /* 9735 при 165 */
_Static_assert(DMG_RESP_TIMEOUT_SLOTS == 4u, "AckTimeout в слотах");
/* dot11BFRetryLimit (MIB, DEFVAL 8): инициатор может повторить SSW-Feedback до этого числа раз (10.42.6.2, «may restart
 * the SSW feedback procedure up to dot11BFRetryLimit times»). vendor — 2 повтора (3 попытки). */
#define DOT11_BF_RETRY_LIMIT     8u
/* dot11MaxBFTime (MIB, DEFVAL 4 BI): T2 автомата инициатора SLS (10.42.8, рис. 10-91 [p. 1966]). Из Idle инициатор
 * начинает ISS заново, только пока не превышен dot11BFRetryLimit; после тайм-аута в Sector Selector (ответа на ISS нет)
 * — снова Idle. Подряд ISS без ответа пиру — не больше 1 + dot11BFRetryLimit; дальше новая развёртка тому же пиру — не
 * раньше T2 от первого ISS без ответа этой серии (процедура BF длится не дольше dot11MaxBFTime). vendor повторял ISS
 * по каждому новому триггеру BF (CTS failure) без предела: при молчащем пире — шторм развёрток (стенд 2026-11-06,
 * ~300 ISS/с у точки). */
#define DOT11_MAX_BF_TIME_BI     4u
/* Ожидание ответчиком SLS SSW-Feedback после своей RSS (GP0 из txss_resp_wait_iss_end — взводится до RSS, к сроку
 * прибавляется её длительность; выход txss_resp_wait_fdbk по r54.6): Feedback начинается через MBIFS после RSS (10.42.2.2), инициатор может повторить его dot11BFRetryLimit раз,
 * каждый цикл — Feedback, MBIFS, SSW-Ack, PIFS (10.42.6.2). Срок покрывает все попытки: 9 × 8829 = 79461 такт ≈ 482 мкс.
 * vendor брал слово за концом таблицы rss_wait_clk[9] (индекс 10, 0x8020ec), никем не записываемое: срок 0. */
#define DMG_SSW_FB_CYCLE_CLK_AT(f) (DMG_TXTIME_SSW_FB_CLK + DMG_MBIFS_CLK_AT(f) + DMG_TXTIME_SSW_ACK_CLK + DMG_PIFS_CLK_AT(f))
#define DMG_RESP_FDBK_WAIT_CLK_AT(f) ((1u + DOT11_BF_RETRY_LIMIT) * DMG_SSW_FB_CYCLE_CLK_AT(f))
#define DMG_RESP_FDBK_WAIT_CLK   DMG_RESP_FDBK_WAIT_CLK_AT(DMG_CLK_PER_US)
_Static_assert(DMG_RESP_FDBK_WAIT_CLK_AT(CLK_MHZ_RESET) == 79461u, "срок Feedback при 165");
_Static_assert(DMG_RESP_FDBK_WAIT_CLK_AT(255u) < (1u << 24), "срок Feedback в поле GP при любом такте до 255 МГц");

/* ---- Сторожа опоздания по SIFS_CNT ----
 * SIFS_CNT — r55 после команды 0x4d000000: [15:8] целые мкс, [7:0] такты 0…164 (165 МГц); сравнение — по сырому
 * коду (монотонен). Отсчёт — от последнего «события начала IFS» MAC: в A-BFT — от события GP-таймера (стенд
 * 2026-10-21: 0,94 мкс у сторожа станции через ~0,9 мкс пути после GP1, 0,98 у AP при SSW в эфире), на пути
 * ответа в DTI — от события раньше конца принятого кадра (3,9–6,1 мкс перед запросом в MTP без сбоев,
 * UC-REGISTERS §2.16; вероятно, MAC_EVT1_RX_FRAME — разбор заголовка, ~9 мкс от начала кадра). SIFS_CNT_ABFT_SSW_LATE и
 * SIFS_CNT_ABFT_FB_LATE — из замера срока MAC; SIFS_CNT_RX_ENTRY_LATE и SIFS_CNT_RESP_LATE — значения vendor,
 * подтверждённые замером срока (опыт rg). Каждое выражено как срок минус путь uc после
 * проверки. Прямую передачу MAC начинает через IFS из 0x886d00
 * (+ ~0,55 мкс) после события, если команды успели (H-ORIGIN, uc/abft.h); опоздание — MAC_HW_ICR б4/б5. */
#define SIFS_CNT_CODE(us, clk)  (((us) << 8) | (clk))
/* Порог, заданный временем t (нс), в коде SIFS_CNT при такте f: [15:8] целые мкс, [7:0] остаток в тактах (вниз). Пороги
 * ниже — время, при котором код при 165 МГц равен прежнему (замеры стенда — в мкс эфира на 165 МГц). Срок D — время MAC,
 * путь uc P — такты: при другом такте порог = D − P/f, а не D·165/f — разложение по частям при другом такте не измерено,
 * поэтому порог пересчитывается как время целиком. */
#define SIFS_CNT_CODE_NS_AT(ns, f)  SIFS_CNT_CODE((ns) / 1000u, ((ns) % 1000u) * (f) / 1000u)
/* СРОК. Станция, SSW в A-BFT (abft_ssw_go/abft_ssw_burst): ответчик начинает RSS с начала своего слота (802.11-2020
 * 10.42.5.2), то есть первый SSW должен уйти в эфир целиком и вовремя. Замер (стенд, развёртка 0,1 мкс выдачи 0x19 после
 * события слота, отсчёт по SIFS_CNT при проверке, 3 загрузки): 0x19 через ≤ 4,34 мкс после события (SIFS_CNT при
 * проверке ≤ 1,70–1,72) — пачка полная, у AP первый SSW с CDOWN = FSS; 4,45 мкс (SIFS_CNT 1,82) — старт по времени тот
 * же, но первый SSW у AP теряется; с 4,57 (1,93) старт кадра сдвигается 1:1; с 2,51 MAC переносит пачку в следующий слот;
 * поздняя команда (assert 0x26) — недетерминированно с 1,90. Путь «чтение SIFS_CNT → 0x19» P = 2,61–2,64 мкс (с меткой
 * опыта; здесь короче). Порог = D − P − шаг: 4,34 − 2,64 − 0,10 = 1,60 мкс → [15:8] 1, [7:0] 0,60 × 165 = 99 тактов.
 * Удлинение пути от проверки до 0x19 (abft_ssw_go → abft_ssw_burst) на ΔP требует уменьшить порог на ΔP. */
#define SIFS_CNT_ABFT_SSW_LATE_NS  1600u
#define SIFS_CNT_ABFT_SSW_LATE  SIFS_CNT_CODE_NS_AT(SIFS_CNT_ABFT_SSW_LATE_NS, DMG_CLK_PER_US)   /* 0x163 = 1,60 мкс при 165 МГц */
_Static_assert(SIFS_CNT_CODE_NS_AT(SIFS_CNT_ABFT_SSW_LATE_NS, CLK_MHZ_RESET) == SIFS_CNT_CODE(1u, 99u), "SIFS_CNT_ABFT_SSW_LATE при 165");
/* СРОК. AP, SSW-Feedback в A-BFT (abft_rx_ssw_tx_feedback → direct_tx_ssw_feedback): начало Feedback — за aSSFBDuration + MBIFS
 * до конца слота (802.11-2020 10.42.5.2), точку держит MAC (GP1 + MBIFS из 0x886d00 + 0,55 мкс; от 0x19 не зависит).
 * Срок для uc — последняя выдача команд direct_tx_ssw_feedback, которую MAC ещё принимает. Замер (стенд, развёртка задержки
 * перед direct_tx_ssw_feedback, отсчёт по SIFS_CNT у проверки; 6 проходов, шаг 0,25 и 0,1): естественный путь — 2,58–2,68;
 * при SIFS_CNT до 6,91–7,85 Feedback уходит в свою точку (сдвиг ≤ 0,06), станция принимает его через 275,3 мкс после
 * события слота; дальше — поздняя команда в direct_tx_ssw_feedback / mac_program_tx_vector (MAC_HW_ICR б4/б5, assert 0x26) или
 * потеря Feedback у станции, граница от прохода к проходу 7,0…7,9. Худший проход: последняя удачная — SIFS_CNT 6,91.
 * Порог = последняя удачная − шаг = 6,91 − 0,10 = 6,81 мкс → [15:8] 6, [7:0] ⌊0,81 × 165⌋ = 133 такта. SIFS_CNT
 * считается от события GP1, а точка Feedback = GP1 + MBIFS + 0,55: при смене длины слота (формула aSSDuration,
 * +16 тактов к таблице vendor, замер был на ней) обе сдвигаются вместе — порог от длины слота и FSS не зависит. */
#define SIFS_CNT_ABFT_FB_LATE_NS  6810u
#define SIFS_CNT_ABFT_FB_LATE  SIFS_CNT_CODE_NS_AT(SIFS_CNT_ABFT_FB_LATE_NS, DMG_CLK_PER_US)   /* 0x685 = 6,81 мкс при 165 МГц */
_Static_assert(SIFS_CNT_CODE_NS_AT(SIFS_CNT_ABFT_FB_LATE_NS, CLK_MHZ_RESET) == SIFS_CNT_CODE(6u, 133u), "SIFS_CNT_ABFT_FB_LATE при 165");
/* СРОК. Вход rx_flow_run при состоянии MAC 5: опоздавший вход не выдаёт 0x1f006000…0x6000101 (rx_not_ready).
 * Путь редкий — служебные обмены (ассоциация, BF), приём данных DTI через него не идёт (опыт rg, 2026-10-24: 13 входов
 * за загрузку, 0 под UDP 71 тыс. кадров, ~30 за 70 с TCP 942 Мбит/с); естественный SIFS_CNT 0…2,8, после
 * ассоциации обычно 1,3–1,5 мкс — сторож срабатывает часто. Отсчёт SIFS_CNT — от события раньше конца кадра,
 * стандартного значения нет. Замер (сторож снят, спин по SIFS_CNT до цели 1,0…3,0 мкс с шагом 0,1, 3 загрузки,
 * .11 vendor шлёт WMI_BF_TRIG): последний удачный вход 1,33 мкс, первые неудачные 1,35 / 1,41 / 1,51 (uc assert 0x26 —
 * поздняя команда MAC; без сторожа естественный вход 2,02 мкс тоже даёт 0x26). Срок D ≈ 1,34 мкс; порог 1,19 ниже
 * последнего удачного на 0,14 мкс (> шага развёртки) — подтверждён, оставлен. */
#define SIFS_CNT_RX_ENTRY_LATE_NS  1194u
#define SIFS_CNT_RX_ENTRY_LATE  SIFS_CNT_CODE_NS_AT(SIFS_CNT_RX_ENTRY_LATE_NS, DMG_CLK_PER_US)   /* 0x120 = 1,19 мкс при 165 МГц */
_Static_assert(SIFS_CNT_CODE_NS_AT(SIFS_CNT_RX_ENTRY_LATE_NS, CLK_MHZ_RESET) == SIFS_CNT_CODE(1u, 32u), "SIFS_CNT_RX_ENTRY_LATE при 165");
/* СРОК (ХРУПКО). rx_flow_run: принятый PPDU кончился раньше проверки счётчиков PPDU (короткий кадр SC: заголовок
 * разобран через 2,47 мкс, 20.4.3, а путь uc от busy_event до проверки ~460 тактов), ответ через SIFS обязателен
 * (802.11-2020 10.3.2.11 Ack, 10.25.3 BlockAck). Разбирать его можно, только если команда ответа 0x37000020 ещё
 * успеет: срок — SIFS_CNT ≤ 1044 у команды ответа на кадр SC (стенд 2026-10-30, PAD_RESP_CMD 32 nop под TCP:
 * BlockAck при SIFS_CNT до 1074 у 0x19, ~30 тактов после 0x37000020, без ошибок; machw RESP_CMD_DEADLINE_SC_CLK) —
 * нижняя граница, в тех же единицах SIFS_CNT, что и снимок на проверке (оба от одной точки отсчёта MAC, «раньше конца
 * кадра», SIFS_CNT_RX_ENTRY_LATE). Путь от чтения снимка (rx_flow_r55_snap) до 0x37000020 по худшей ветке (ожидание
 * BAP, старший индекс станции) W = 566 тактов модели (test_uc_deadlines test_sifs_response_late_end_sc). Предел =
 * 1044 − запас правила сроков max(20 %, 100) = 209 − W = 269 тактов; порог — 1,55 мкс = 255 тактов → [15:8] 1,
 * [7:0] 90 (вниз до шага 0,05 мкс; 14 тактов — на дрейф кодогена). Удлинение пути от проверки до 0x37000020 на ΔW
 * требует уменьшить порог на ΔW (тест сроков это ловит).
 * Control PHY (MCS 0) — не разбирается: срок ответа на кадр control PHY короче (machw RESP_CMD_DEADLINE_CLK 754 от
 * конца, vendor-путь Ack + 12 тактов — assert 0x26), W одного пути съедает его целиком; и случая нет — PPDU control
 * PHY не короче 13 мкс (Ack 14 Б, 20.4.3.3), путь uc от busy_event до проверки много короче. */
#define SIFS_CNT_RX_LATE_END_SC_NS  1546u
#define SIFS_CNT_RX_LATE_END_SC  SIFS_CNT_CODE_NS_AT(SIFS_CNT_RX_LATE_END_SC_NS, DMG_CLK_PER_US)   /* 0x15a = 1,55 мкс при 165 МГц */
_Static_assert(SIFS_CNT_CODE_NS_AT(SIFS_CNT_RX_LATE_END_SC_NS, CLK_MHZ_RESET) == SIFS_CNT_CODE(1u, 90u), "SIFS_CNT_RX_LATE_END_SC при 165");
/* СРОК. Переключение с приёма на передачу после конца принятого PPDU (rx_end_switch_to_tx): опоздание — отмена 0x1f000601. Места вызова: rx_flow_handle_frame
 * (RTS / CF-End с Duration / sifs_resp), rx_flow_step (продолжение TXOP), rx_handle_ppdu_report (ответчик TXSS
 * и разбор SSW в BF). Естественный SIFS_CNT под TCP 1,9–2,1 мкс (95 %), 2,5–2,8 изредка, единицы 5,4 / 6,3 на 2700.
 * Замер (опыт rg, 2026-10-24; сторож снят, спин по SIFS_CNT до цели, шаг 0,1): RTS/CF-End и TXOP — цель до 8,0 мкс,
 * ~1900 переключений на каждом, TCP 925/945 Мбит/с — без сбоев (срок > 8 мкс); BF (ответчик TXSS, .11 vendor шлёт
 * WMI_BF_TRIG) — последние удачные 5,28 / 5,33 мкс, первые неудачные 5,39 / 5,45 / 5,79 (uc assert 0x6019 в
 * txss_resp_wait_iss_end), 3 загрузки. Порог общий, задаёт самый строгий путь (BF, D ≈ 5,3): 5,00 ниже последнего
 * удачного на 0,28 мкс — подтверждён, оставлен. */
#define SIFS_CNT_RESP_LATE_NS  5000u
#define SIFS_CNT_RESP_LATE  SIFS_CNT_CODE_NS_AT(SIFS_CNT_RESP_LATE_NS, DMG_CLK_PER_US)   /* 0x500 = 5,00 мкс при 165 МГц */
_Static_assert(SIFS_CNT_CODE_NS_AT(SIFS_CNT_RESP_LATE_NS, CLK_MHZ_RESET) == SIFS_CNT_CODE(5u, 0u), "SIFS_CNT_RESP_LATE при 165");

/* Величины A-BFT/SLS от такта f (uc/abft.h, uc/clkk.h). */
#define ABFT_AIRPROP_CLK_AT(f) (((f) + 9u) / 10u)   /* aAirPropagationTime 0,1 мкс (Table 20-30), вверх: 17 при 165 */
#define ABFT_CLK2FX_MUL_AT(f)    ((1048576u + (f) / 2u) / (f))
#define ABFT_SSW_TXTIME_FX_AT(f) ((DMG_TXTIME_SSW_CLK * 1024u + (f) / 2u) / (f))
#define ABFT_SSW_STEP_FX_AT(f)   (((DMG_TXTIME_SSW_CLK + DMG_SBIFS_CLK_AT(f)) * 1024u + (f) / 2u) / (f))
#define SLS_DUR_MUL_AT(f)     ((16777216u + (f) - 1u) / (f))
#define SSWFB_DUR_US_AT(f)     ((DMG_TXTIME_SSW_ACK_CLK + DMG_MBIFS_CLK_AT(f) + (f) - 1u) / (f))
#define SSWFB_DUR_BRP_US_AT(f) ((DMG_TXTIME_SSW_ACK_CLK + 2u * DMG_MBIFS_CLK_AT(f) + (f) - 1u) / (f))
#define SSWACK_DUR_SUB_AT(f) ((DMG_MBIFS_CLK_AT(f) + DMG_TXTIME_SSW_ACK_CLK) / (f))
#define CLK_US_MUL22_AT(f)    ((4194304u + (f) - 1u) / (f))

/* Повтор SSW-Feedback инициатора (uc/tail.c): ожидание SSW-Ack — MBIFS + TXTIME(SSW-Ack) + PIFS; путь повтора — замер
 * fbr 2026-10-24 в тактах (744 max, 725 min; [гип] путь uc — такты при любом такте). */
#define SSWFB_ACK_WAIT_CLK_AT(f)  (DMG_MBIFS_CLK_AT(f) + DMG_TXTIME_SSW_ACK_CLK + DMG_PIFS_CLK_AT(f))   /* 5817 при 165 */
#define SSWFB_RETRY_PATH_CLK      744u
#define SSWFB_RETRY_PATH_MIN_CLK  725u
#define SSWFB_GP1_CLK_AT(f)       (SSWFB_ACK_WAIT_CLK_AT(f) - SSWFB_RETRY_PATH_MIN_CLK)
#define SSWFB_RETRY_NEED_CLK_AT(f) (SSWFB_GP1_CLK_AT(f) + SSWFB_RETRY_PATH_CLK + DMG_TXTIME_SSW_FB_CLK + DMG_MBIFS_CLK_AT(f) + \
                                    DMG_TXTIME_SSW_ACK_CLK)
#define SSWFB_RETRY_NEED_US_AT(f) ((SSWFB_RETRY_NEED_CLK_AT(f) + (f) - 1u) / (f))
#define SSWFB_FRAME_US_AT(f)      ((DMG_TXTIME_SSW_FB_CLK + (f) - 1u) / (f) + 2u)
#define SSW_FRAME_US_AT(f)        ((DMG_TXTIME_SSW_CLK + (f) - 1u) / (f) + 2u)
/* Предел ожидания MAC_BAP_RX_UPDATE (uc/rx.c): проходов по ≥ 4 тактов на aPPDUMaxTime + SIFS. */
#define BAP_RX_WAIT_PASSES_AT(f)  ((DMG_PPDU_MAX_US * (f) + DMG_SIFS_CLK_AT(f)) / 4u + 2u)

/* Таймеры ARC uc (AUX Timer0/Timer1, такты ядра): предел Timer1 — 2 с (vendor 0x13ab6680 при 165), тик L1 Timer0 —
 * 10 мкс (vendor 0x672 = 1650). Метки UC_STAMP и util.c считают по пределу Timer1. */
#define UC_TIMER1_LIMIT_US   2000000u
#define UC_TIMER0_TICK_US    10u
#define UC_TIMER1_LIMIT_CLK  (UC_TIMER1_LIMIT_US * DMG_CLK_PER_US)
#define UC_TIMER0_TICK_CLK   (UC_TIMER0_TICK_US * DMG_CLK_PER_US)
_Static_assert(UC_TIMER1_LIMIT_US * CLK_MHZ_RESET == 0x13ab6680u && UC_TIMER0_TICK_US * CLK_MHZ_RESET == 0x672u,
               "таймеры uc при 165");

/* Выдержки, заданные временем (нс), в тактах ядра — до ближайшего (паузы vendor без основы в стандарте: длительность
 * при 165 МГц сохранена, переводится по такту). */
#define UC_NS_TO_CLK(ns)  (((ns) * DMG_CLK_PER_US + 500u) / 1000u)
_Static_assert((9697u * CLK_MHZ_RESET + 500u) / 1000u == 1600u && (4848u * CLK_MHZ_RESET + 500u) / 1000u == 800u &&
               (970u * CLK_MHZ_RESET + 500u) / 1000u == 160u && (12u * CLK_MHZ_RESET + 500u) / 1000u == 2u,
               "паузы vendor при 165");

/* Поправки отметок времени MAC {мкс[31:16], такты[15:0]} (uc/stubs.c bi_mode_program_mac_timing; стенд 2026-11-17 при
 * 165 МГц, MAC-STAND «Отметки времени»): поправка TSF при приёме маяка 1,70 мкс, задержка метки TX Control PHY 6,22 и
 * SC PHY 2,07 мкс. Это тракт PHY (преамбула, фильтры) — в чипах, а частота чипов идёт от такта ядра (notes: скорость
 * TSF и полоса ∝ N), поэтому величины хранятся в тактах [гип, при другом такте не калибровалось]; поле — от такта. */
#define UC_TSF_RX_ADJ_CLK        281u
#define UC_TX_STAMP_CTRL_CLK     1027u
#define UC_TX_STAMP_SC_CLK       341u
#define MAC_US_CLK_CODE_AT(c, f) ((((c) / (f)) << 16) | ((c) % (f)))
_Static_assert(MAC_US_CLK_CODE_AT(UC_TSF_RX_ADJ_CLK, CLK_MHZ_RESET) == 0x10074u &&
               MAC_US_CLK_CODE_AT(UC_TX_STAMP_CTRL_CLK, CLK_MHZ_RESET) == 0x60025u &&
               MAC_US_CLK_CODE_AT(UC_TX_STAMP_SC_CLK, CLK_MHZ_RESET) == 0x2000bu, "поправки отметок при 165");

#ifndef UC_ABFT_MACLAT_CLK
#define UC_ABFT_MACLAT_CLK    91u       /* старт прямой передачи после события GP + IFS(0x886d00): стенд 0,55 мкс (H-ORIGIN) */
#endif
/* A-BFT (uc/abft.h): aAirPropagationTime 0,1 мкс вверх (17 при 165); хвост слота; GP1 станции после конца GP0; пуск GP AP
 * триггером 0x03 — SIFS + 7 тактов замера (стенд A2). */
#define ABFT_AIRPROP_CLK_AT(f)     (((f) + 9u) / 10u)
#define ABFT_SLOT_TAIL_CLK_AT(f)   (ABFT_AIRPROP_CLK_AT(f) + DMG_MBIFS_CLK_AT(f) + DMG_TXTIME_SSW_FB_CLK + DMG_MBIFS_CLK_AT(f))
#define ABFT_STA_STD_GP1_CLK_AT(f) (DMG_MBIFS_CLK_AT(f) - DMG_SIFS_CLK_AT(f) - UC_ABFT_MACLAT_CLK)
#define ABFT_AP_TRIG03_CLK_AT(f)   (DMG_SIFS_CLK_AT(f) + 7u)
/* Хвосты окна ESE (uc/ese_dti.c): TXOP — 2·aSlotTime + SIFS + TXTIME(BlockAck 32 Б); SLS — 3·MBIFS + Feedback + Ack +
 * 2·(BRPIFS + кадр BRP ≤ ESE_BRP_FRAME_US). */
#define ESE_BA_LEN          32u
#define ESE_BRP_FRAME_US    100u
#define ESE_TXOP_TAIL_US_AT(f) DMG_CLK_TO_US_CEIL_AT(2u * DMG_SLOT_CLK_AT(f) + DMG_SIFS_CLK_AT(f) + DMG_CTRL_TXTIME_CLK(ESE_BA_LEN), f)
#define ESE_SLS_TAIL_US_AT(f) (DMG_CLK_TO_US_CEIL_AT(3u * DMG_MBIFS_CLK_AT(f) + DMG_TXTIME_SSW_FB_CLK + DMG_TXTIME_SSW_ACK_CLK + \
                                                 2u * DMG_BRPIFS_US * (f), f) + 2u * ESE_BRP_FRAME_US)

#include "clkk.h"

#ifdef UC_CLKK
/* uc: величины от такта — непосредственные значения в коде, вписанные при старте (uc/clkk.h), а не произведения по месту. */
#undef DMG_SIFS_CLK
#undef DMG_SBIFS_CLK
#undef DMG_SLOT_CLK
#undef DMG_PIFS_CLK
#undef DMG_MBIFS_CLK
#undef DMG_LBIFS_CLK
#undef DMG_PPDU_MAX_CLK
#undef DMG_RX_PHY_START_DELAY_CTRL_CLK
#undef DMG_RESP_TIMEOUT_CLK
#undef DMG_BRPIFS_CLK
#undef DMG_BRP_RESP_TIMEOUT_CLK
#undef DMG_RESP_FDBK_WAIT_CLK
#undef UC_TIMER1_LIMIT_CLK
#undef UC_TIMER0_TICK_CLK
#undef SIFS_CNT_ABFT_SSW_LATE
#undef SIFS_CNT_ABFT_FB_LATE
#undef SIFS_CNT_RX_ENTRY_LATE
#undef SIFS_CNT_RX_LATE_END_SC
#undef SIFS_CNT_RESP_LATE
#define DMG_SIFS_CLK      CLKK(SIFS)
#define DMG_SBIFS_CLK     CLKK(SBIFS)
#define DMG_SLOT_CLK      CLKK(SLOT)
#define DMG_PIFS_CLK      CLKK(PIFS)
#define DMG_MBIFS_CLK     CLKK(MBIFS)
#define DMG_LBIFS_CLK     CLKK(LBIFS)
#define DMG_PPDU_MAX_CLK  CLKK(PPDU_MAX)
#define DMG_RX_PHY_START_DELAY_CTRL_CLK  CLKK(RX_PHY_START_CTRL)
#define DMG_RESP_TIMEOUT_CLK      CLKK(RESP_TIMEOUT)
#define DMG_BRPIFS_CLK            CLKK(BRPIFS)
#define DMG_BRP_RESP_TIMEOUT_CLK  CLKK(BRP_RESP_TIMEOUT)
#define DMG_RESP_FDBK_WAIT_CLK    CLKK(RESP_FDBK_WAIT)
#define UC_TIMER1_LIMIT_CLK       CLKK(TIMER1_LIMIT)
#define UC_TIMER0_TICK_CLK        CLKK(TIMER0_TICK)
#define SIFS_CNT_ABFT_SSW_LATE    CLKK(SIFS_CNT_ABFT_SSW_LATE)
#define SIFS_CNT_ABFT_FB_LATE     CLKK(SIFS_CNT_ABFT_FB_LATE)
#define SIFS_CNT_RX_ENTRY_LATE    CLKK(SIFS_CNT_RX_ENTRY_LATE)
#define SIFS_CNT_RX_LATE_END_SC   CLKK(SIFS_CNT_RX_LATE_END_SC)
#define SIFS_CNT_RESP_LATE        CLKK(SIFS_CNT_RESP_LATE)
#endif

#endif
