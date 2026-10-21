/* SPDX-License-Identifier: AGPL-3.0-or-later */
#ifndef UC_ABFT_H
#define UC_ABFT_H
/* Тайминг A-BFT (802.11-2020 10.42.5): величины стандарта в тактах MAC/uc (165 МГц, 1 мкс = 165 тактов)
 * и константы vendor 6.2 (сборка с флагами отказа UC_ABFT_*_VENDOR).
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
 * Рабочая сборка — тайминг по стандарту; vendor 6.2 — по флагам отказа (UC_DBG или CFLAGS):
 *   UC_ABFT_STA_VENDOR — станция как vendor 6.2 (GP0 = Duration − 4 мкс, слот 0 через 0x3de после конца
 *                        GP0, первый SSW — по готовности кадра);
 *   UC_ABFT_AP_VENDOR  — AP как vendor 6.2 (слот 0 = GP2 0x339, SSW-Feedback — сразу по GP1 = aSSDuration
 *                        + 1 мкс, сторож SIFS_CNT ≥ 0x700).
 *   UC_ABFT_STA_LASTBCN — опыт, по умолчанию выключен: перевзвод GP0 по каждому маяку BTI (H-REARM).
 *
 * Стандартный тайминг:
 *   станция — GP0 = Duration − 0x284 от конца GP2 (= конец приёма маяка + 3,903 мкс) кончается в конец
 *     BTI; граница слота (GP1) за UC_ABFT_STA_PREP_CLK до начала слота (конец BTI + MBIFS), первый SSW
 *     выдаётся по GP_CLK2 ровно в начало слота; конец A-BFT (GP2) = начало + n·aSSSlotTime + 3 мкс;
 *   AP — слот 0 = txop_event + MBIFS (GP2/GP0 с триггером 0x03 стартуют через ~SIFS после txop_event),
 *     SSW-Feedback по GP_CLK2 в точке aAirPropagationTime + aSSDuration + MBIFS от начала слота.
 *
 * Что известно о железе (стенд A2, 2026-10-21, vendor-станция → наш AP, один слот с пачкой):
 *   H-CLK2 [подтверждено]: GP_CLK2_TIMER — остаток хода GP2, счёт вниз, перезагрузка на границе слота
 *            (t от границы + GP_CLK2 = aSSSlotTime с точностью 9 тактов);
 *   H-GP9  [подтверждено у AP]: пуск 0x…090c — по концу GP2 (GP1 AP: событие через aSSDuration + 1,0 мкс
 *            от границы слота); у GP0 станции (0x5200090c) — то же (не измерено);
 *   H-GP3  [замер]: GP2 = 0x339 (5 мкс) с пуском 0x5400030c дал границу через 8,05 мкс после txop_event
 *            (7,6 мкс после команды), т. е. пуск ≈ через SIFS (3 мкс) после txop_event, а не по команде;
 *            ABFT_AP_TRIG03_CLK — эта задержка;
 *   H-GP5  [гипотеза]: GP2 станции = 0x284 (3,903 мкс) с пуском 0x54000508 стартует концом приёма кадра —
 *            отсюда vendor «Duration − 4 мкс» (0x284 + 16 тактов) и пропуск A-BFT по r54.8 после взвода
 *            GP0 (стенд A1: 64 из 64 попыток в 6 загрузках из 8 кончились так — bcn_rx.x1c);
 *   H-GO   [вывод]: без занятой среды кадр уходит по 0x19; занятую среду MAC пережидает: Feedback AP ушёл
 *            через ~1 мкс после конца последнего SSW (0x19 → tx_end 8,78 мкс вместо 1,45) — MBIFS из
 *            0x886d00 на этот direct TX не действует;
 *   H-TXOP [замер]: txop_event — через 74,2 мкс после tx_end последнего маяка: TXOP BTI = n·(d + SBIFS),
 *            где d из r47 округлено вверх до мкс (20 при TXTIME 19,13) — ≈ 55 мкс простоя на 64 маяка.
 *            Что Duration маяков объявляет конец BTI = txop_event — не проверено (UC_ABFT_AP_BTI_END_CLK);
 *   H-T1   [подтверждено]: Timer1 = 165 МГц (период SSW 2626 тактов = 15,92 мкс).
 */

#define ABFT_CLK_PER_US     165u
#define ABFT_SIFS_CLK       495u        /* aSIFSTime 3 мкс (Table 20-30) */
#define ABFT_MBIFS_CLK      1485u       /* MBIFS = 3 × aSIFSTime = 9 мкс (10.3.2.3.10) = 0x5cd */
#define ABFT_AIRPROP_CLK    17u         /* aAirPropagationTime 0,1 мкс = 16,5 такта (Table 20-30), вверх */
#define ABFT_SSFB_CLK       3012u       /* aSSFBDuration = TXTIME(SSW-Feedback, 28 Б, control PHY) = 18,255 мкс */

/* ---- vendor 6.2 (UC_ABFT_*_VENDOR): те же числа, что были литералами ---- */
/* Станция: GP0 = (Duration − 4 мкс)·165, пуск по концу GP2 (0x284 после конца маяка, H-GP5); GP1 (граница слота 0) = 0x3de = 6 мкс после конца GP0 (не MBIFS); GP2 (конец A-BFT) =
 * n·aSSSlotTime + MBIFS после конца GP0 — на 0x1ef = 3 мкс позже конца последнего слота по сетке GP1. */
#define ABFT_V62_STA_GP0_ADV_US 4u
#define ABFT_V62_STA_SLOT0_CLK  0x3deu
#define ABFT_V62_STA_END_CLK    ABFT_MBIFS_CLK
/* AP: GP2 = 0x339 = 5 мкс от пуска (≈ txop_event + 3 мкс, H-GP3) — начало слота 0 = txop + 8 мкс, GP0 = n·aSSSlotTime + 0x1ef (3 мкс: конец A-BFT
 * на 2 мкс раньше последней границы GP2, чтобы mac_mode_kick вышел по GP0, а не начал слот n), GP1 =
 * aSSDuration + 0xa5 (1 мкс) от начала слота — решение о SSW-Feedback. */
#define ABFT_V62_AP_SLOT0_CLK   0x339u
#define ABFT_V62_AP_END_CLK     0x1efu
#define ABFT_V62_AP_FB_CLK      0xa5u

/* ---- стандартный тайминг (по умолчанию) ---- */
#ifndef UC_ABFT_STA_VENDOR
#define ABFT_STA_STD 1
#endif
#ifndef UC_ABFT_AP_VENDOR
#define ABFT_AP_STD 1
#endif
/* Станция. */
#define ABFT_STA_GP2_RXEND_CLK  0x284u  /* GP2 станции от конца приёма кадра (bti_reset_sweep_state, H-GP5) */
#ifndef UC_ABFT_STA_EVT_CLK
#define UC_ABFT_STA_EVT_CLK   0u        /* задержка пуска GP2 после конца маяка в эфире (H-GP5), уточнить опытом */
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
#define ABFT_AP_TRIG03_CLK    502u      /* пуск GP0/GP2 (0x…030c/0x…0308) после txop_event: стенд A2 8,05 − 5,00 мкс */
#ifndef UC_ABFT_AP_BTI_END_CLK
#define UC_ABFT_AP_BTI_END_CLK 0u       /* объявленный (Duration) конец BTI позже txop_event (H-TXOP) */
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

#if defined(UC_ABFT_STA_LASTBCN) && !defined(ABFT_STA_STD)
#error "UC_ABFT_STA_LASTBCN — только со стандартным таймингом станции"
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
