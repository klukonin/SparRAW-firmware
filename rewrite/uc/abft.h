/* SPDX-License-Identifier: AGPL-3.0-or-later */
#ifndef UC_ABFT_H
#define UC_ABFT_H
/* Тайминг A-BFT (802.11-2020 10.42.5): величины стандарта в тактах MAC/uc (165 МГц, 1 мкс = 165 тактов)
 * и константы vendor 6.2, которые рабочая сборка сохраняет до проверки на стенде.
 * Разбор цепочки и отклонений — отчёт abft-timing.md (рядом с ifs-audit.md).
 *
 * Стандарт:
 *   * BTI кончается по истечении Duration ПОСЛЕДНЕГО принятого в нём DMG Beacon (10.42.5.1);
 *   * A-BFT начинается через MBIFS после конца BTI (10.42.5.1); первый SSW-слот — в начале A-BFT,
 *     слоты смежны (10.42.5.2);
 *   * aSSSlotTime = aAirPropagationTime + aSSDuration + MBIFS + aSSFBDuration + MBIFS (10.42.5.2) —
 *     таблица period_tab (data.c), aSSDuration — ssw_tab_b;
 *   * первый символ SSW-Feedback — за aSSFBDuration + MBIFS до конца слота (10.42.5.2), то есть через
 *     aAirPropagationTime + aSSDuration + MBIFS от начала слота, а не от последнего SSW.
 *
 * Рабочая сборка (без флагов) = vendor 6.2. Флаги ниже — стандартный тайминг; каждый опирается на
 * гипотезы о железе, перечисленные при флаге (проверка — опыты A1–A5 в abft-timing.md):
 *   H-GP:    GP0 станции (0x5200090c) и GP0/GP2 AP (0x52000308/0x5400030c) стартуют в момент команды;
 *            GP1/GP2 станции (0x5300070e/0x5400070e) — по концу GP0; GP1 станции с 0x5300080e — по своему
 *            концу (период слота); GP1 AP (0x5300090c) — по концу GP2 (граница слота). Байт [15:8] = 0x09
 *            у GP0 станции и у GP1 AP тогда значит «по концу GP2, если он идёт, иначе сразу» — не проверено;
 *   H-CLK2:  GP_CLK2_TIMER (r55 после 0x4d00000a) — остаток хода GP2 (счёт вниз), такты;
 *   H-T1:    Timer1 (AUX 0x100) идёт с частотой тактов GP-таймеров (165 МГц);
 *   H-GO:    первый кадр уходит в эфир по команде 0x19 (если MAC не держит IFS), задержка GO → эфир
 *            мала (по E1 и меткам A-BFT: tx_end r42.15 ≈ начало кадра + 1,3…1,45 мкс, GO → tx_end
 *            1,32…1,50 мкс);
 *   H-TXOP:  txop_event AP (r42.7) — конец BTI в смысле Duration маяков (TXOP BTI = n·(кадр + SBIFS) от
 *            начала первого маяка, Duration последнего = SBIFS).
 *
 * Флаги (UC_DBG или CFLAGS; по умолчанию все выключены):
 *   UC_ABFT_STA_STD    — станция: конец BTI = событие приёма маяка + Duration·165 − задержка события
 *                        (самокомпенсация пути по Timer1 вместо «− 4 мкс»), начало слота 0 = конец BTI +
 *                        MBIFS, первый SSW — по GP_CLK2 ровно в начало слота (кадр готовится заранее,
 *                        GP1 взводится на UC_ABFT_STA_PREP_CLK раньше границы).
 *   UC_ABFT_STA_LASTBCN — (с UC_ABFT_STA_STD) перевзвод GP0 по каждому маяку своей BSS в BTI: конец BTI по
 *                        последнему принятому маяку (10.42.5.1). Доп. гипотеза H-REARM: повторная запись
 *                        GP0 перезапускает его и не даёт события конца GP0 (r54.6) для GP1/GP2.
 *   UC_ABFT_AP_STD     — AP: начало A-BFT = txop_event + MBIFS (самокомпенсация по Timer1), SSW-Feedback —
 *                        по GP_CLK2 в точке aAirPropagationTime + aSSDuration + MBIFS от начала слота;
 *                        сторож SIFS_CNT ≥ 0x700 заменён проверкой опоздания по GP_CLK2.
 */

#define ABFT_CLK_PER_US     165u
#define ABFT_SIFS_CLK       495u        /* aSIFSTime 3 мкс (Table 20-30) */
#define ABFT_MBIFS_CLK      1485u       /* MBIFS = 3 × aSIFSTime = 9 мкс (10.3.2.3.10) = 0x5cd */
#define ABFT_AIRPROP_CLK    17u         /* aAirPropagationTime 0,1 мкс = 16,5 такта (Table 20-30), вверх */
#define ABFT_SSFB_CLK       3012u       /* aSSFBDuration = TXTIME(SSW-Feedback, 28 Б, control PHY) = 18,255 мкс */

/* ---- vendor 6.2 (рабочая сборка): те же числа, что были литералами ---- */
/* Станция: GP0 = (Duration − 4 мкс)·165 от команды 0x4f — «−4 мкс» списывает путь rx_frame_event маяка →
 * 0x4f; GP1 (граница слота 0) = 0x3de = 6 мкс после конца GP0 (не MBIFS); GP2 (конец A-BFT) =
 * n·aSSSlotTime + MBIFS после конца GP0 — на 0x1ef = 3 мкс позже конца последнего слота по сетке GP1. */
#define ABFT_V62_STA_GP0_ADV_US 4u
#define ABFT_V62_STA_SLOT0_CLK  0x3deu
#define ABFT_V62_STA_END_CLK    ABFT_MBIFS_CLK
/* AP: от txop_event GP2 = 0x339 = 5 мкс (начало слота 0), GP0 = n·aSSSlotTime + 0x1ef (3 мкс: конец A-BFT
 * на 2 мкс раньше последней границы GP2, чтобы mac_mode_kick вышел по GP0, а не начал слот n), GP1 =
 * aSSDuration + 0xa5 (1 мкс) от начала слота — решение о SSW-Feedback. */
#define ABFT_V62_AP_SLOT0_CLK   0x339u
#define ABFT_V62_AP_END_CLK     0x1efu
#define ABFT_V62_AP_FB_CLK      0xa5u

/* ---- стандартный тайминг (флаги) ---- */
/* Станция. */
#ifndef UC_ABFT_STA_EVT_CLK
#define UC_ABFT_STA_EVT_CLK   0u        /* задержка rx_frame_event (r42.12) после конца маяка в эфире; по E1 ≤ ~1,9 мкс, уточнить опытом A1 */
#endif
#ifndef UC_ABFT_STA_PREP_CLK
#define UC_ABFT_STA_PREP_CLK  825u      /* GP1 на 5 мкс раньше границы слота: подготовка первого SSW (по меткам ~3,6 мкс) + запас */
#endif
#ifndef UC_ABFT_STA_GOLAT_CLK
#define UC_ABFT_STA_GOLAT_CLK 0u        /* задержка «0x19 → начало кадра в эфире» (H-GO) */
#endif
#define ABFT_STA_STD_SLOT0_CLK  ABFT_MBIFS_CLK          /* граница слота 0 после конца BTI */
#define ABFT_STA_STD_TAIL_CLK   0x1efu                  /* GP2 позже конца последнего слота (как vendor: 3 мкс) —
                                                         * abft_arm_response_window сравнивает остаток с period_tab[0] */
/* AP. */
#ifndef UC_ABFT_AP_EVT_CLK
#define UC_ABFT_AP_EVT_CLK    0u        /* задержка txop_event (r42.7) после конца BTI */
#endif
#ifndef UC_ABFT_AP_FB_PREP_CLK
#define UC_ABFT_AP_FB_PREP_CLK 660u     /* GP1 на 4 мкс раньше точки Feedback: путь direct_tx_step до 0x19 (~169 инструкций + ожидания) + запас */
#endif
#ifndef UC_ABFT_AP_FB_LATE_CLK
#define UC_ABFT_AP_FB_LATE_CLK 82u      /* опоздание к точке Feedback, после которого Feedback не шлётся (0,5 мкс) */
#endif
#ifndef UC_ABFT_AP_GOLAT_CLK
#define UC_ABFT_AP_GOLAT_CLK  0u
#endif
#define ABFT_AP_STD_END_GUARD_CLK 330u  /* GP0 (конец A-BFT у AP) за 2 мкс до последней границы GP2 — как vendor, см. выше */
/* Остаток хода GP2 (слот AP) в точке начала SSW-Feedback: aSSFBDuration + MBIFS до конца слота. */
#define ABFT_AP_STD_FB_REM_CLK  (ABFT_SSFB_CLK + ABFT_MBIFS_CLK)

#if defined(UC_ABFT_STA_LASTBCN) && !defined(UC_ABFT_STA_STD)
#error "UC_ABFT_STA_LASTBCN требует UC_ABFT_STA_STD"
#endif

/* Timer1 (AUX 0x100 COUNT1) одной инструкцией; предел 0x13ab6680 (mac_program_13ab6680), счётчик
 * обнуляют l1.c и tail.c — разность за пределом ABFT_T1_SANE считается недостоверной. */
#define ABFT_T1_SANE  (200u * ABFT_CLK_PER_US)
static inline __attribute__((always_inline)) u32 abft_t1(void)
{
    u32 v;
    __asm__ volatile("lr %0,[0x100]" : "=r"(v) :: "memory");
    return v;
}
/* GP_CLK2_TIMER: остаток хода GP2 в тактах (H-CLK2), 24 бита. */
static inline __attribute__((always_inline)) u32 abft_gp_clk2(void)
{
    uc_mac_cmd(0x4d00000a);
    __asm__ volatile("nop\n\tnop\n\tnop" ::: "memory");
    return arc_core_rd(55) & 0xffffffu;
}

/* Ждать, пока остаток GP2 не станет ≤ tgt (выдача команды в заданную точку слота). Выход по Timer1 через
 * max_clk — безопасный выход при неверной гипотезе о GP_CLK2 (политика hot-path: без зависания). */
static inline __attribute__((always_inline)) void abft_wait_clk2(u32 tgt, u32 max_clk)
{
    u32 t0 = abft_t1();
    while (abft_gp_clk2() > tgt) {
        if (abft_t1() - t0 > max_clk)
            break;
    }
}

#endif
