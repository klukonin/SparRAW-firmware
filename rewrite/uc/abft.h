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
 *   UC_ABFT_STA_VENDOR — станция как vendor 6.2 (GP0 = Duration − 4 мкс, GP1 = 0x3de, вход в BTI с пути
 *                        приёма — без ожидания следующего маяка);
 *   UC_ABFT_AP_VENDOR  — AP как vendor 6.2 (слот 0 = GP2 0x339, GP1 = aSSDuration + 1 мкс).
 *   UC_ABFT_STA_LASTBCN — опыт, по умолчанию выключен: перевзвод GP0 по каждому маяку BTI (H-REARM).
 *
 * Стандартный тайминг:
 *   станция — GP0 = Duration − 0x284 от конца GP2 (= конец приёма маяка + 3,903 мкс) кончается в конец
 *     BTI (B); событие GP1 — в B + MBIFS − SIFS − задержка MAC, первый SSW MAC начинает сам ровно в
 *     B + MBIFS; конец A-BFT (GP2) = B + MBIFS + n·aSSSlotTime. Вход в BTI с пути приёма (kind 1) —
 *     GP0 по следующему маяку развёртки; GP0 не взводится, если GP2 этого маяка уже не идёт;
 *   AP — слот 0 = txop_event + MBIFS (GP2/GP0 с пуском 0x…030c/0x…0308 стартуют через ~SIFS после
 *     txop_event), событие GP1 в слоте — за MBIFS + задержку MAC до точки SSW-Feedback, Feedback MAC
 *     начинает сам в aAirPropagationTime + aSSDuration + MBIFS от начала слота.
 *
 * Что известно о железе (стенд 2026-10-21: A1/A2 и сеанс std/ven, наш AP ↔ vendor-станция, 2 слота):
 *   H-ORIGIN [3 замера AP + метки станции]: прямую передачу (SSW ответчика, SSW-Feedback) MAC начинает
 *            через IFS из 0x886d00 + ~0,55 мкс (UC_ABFT_MACLAT_CLK; включает неточность ctx 1,45 мкс)
 *            после последнего GP-события (начало отсчёта SIFS_CNT), если uc успел выдать команды; иначе —
 *            «поздняя команда» (MAC_HW_ICR б4/б5 → INT6 → assert 0x26). AP: 0x886d00 = MBIFS
 *            (mac_mode_kick) — Feedback = GP1 + 9,55 мкс (264,1 при GP1 254,56; 268,23 при 258,66);
 *            станция: 0x886d00 = SIFS — первый SSW = GP1 + 3,55 мкс (метки A-BFT: 0,94 + 2,69 + …).
 *            Сторожа vendor SIFS_CNT ≥ 0x160 (станция) и ≥ 0x700 (AP) — это срок выдачи команд
 *            относительно этого IFS, они сохранены. Ожидание uc до точки (вариант ef4be28e: подготовка
 *            заранее и спин по GP_CLK2 перед 0x2008000) нарушало срок — FWERR 0x26 у станции
 *            (MAC_HW_ICR = 0x30038), а Feedback AP всё равно уходил по GP1 + MBIFS (+5,69 мкс);
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
 *   H-GO   [опровергнута]: «кадр уходит по 0x19» — нет, старт задаёт MAC (H-ORIGIN), 0x19 должна лишь
 *            успеть; 0x19 → tx_end 7,0–8,8 мкс у Feedback — это ожидание точки GP1 + MBIFS;
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
/* Станция: GP0 = (Duration − 4 мкс)·165, пуск по концу GP2 (0x284 после конца маяка, H-GP5) — конец GP0
 * на 0,1 мкс раньше конца BTI; GP1 = 0x3de = 6 мкс = MBIFS − SIFS после конца GP0 (с SIFS из 0x886d00
 * первый SSW — в конец BTI + 9,45 мкс, H-ORIGIN); GP2 (конец A-BFT) = n·aSSSlotTime + MBIFS. */
#define ABFT_V62_STA_GP0_ADV_US 4u
#define ABFT_V62_STA_SLOT0_CLK  0x3deu
#define ABFT_V62_STA_END_CLK    ABFT_MBIFS_CLK
/* AP: GP2 = 0x339 = 5 мкс от пуска (≈ txop_event + 3 мкс, H-GP3) — начало слота 0 = txop + 8 мкс;
 * GP0 = n·aSSSlotTime + 0x1ef (3 мкс: конец A-BFT на 2 мкс раньше последней границы GP2, чтобы
 * mac_mode_kick вышел по GP0, а не начал слот n); GP1 = aSSDuration + 0xa5 (1 мкс) от начала слота —
 * решение о SSW-Feedback, сам Feedback через MBIFS + 0,55 мкс после него (+1,45 мкс к стандарту). */
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
#ifndef UC_ABFT_MACLAT_CLK
#define UC_ABFT_MACLAT_CLK    91u       /* старт прямой передачи после события GP + IFS(0x886d00): стенд 0,55 мкс (H-ORIGIN) */
#endif
/* Событие GP1 станции после конца GP0 (= конец BTI): первый SSW в B + MBIFS при IFS ответа = SIFS. */
#define ABFT_STA_STD_GP1_CLK  (ABFT_MBIFS_CLK - ABFT_SIFS_CLK - UC_ABFT_MACLAT_CLK)
/* AP. */
#define ABFT_AP_TRIG03_CLK    502u      /* пуск GP0/GP2 (0x…030c/0x…0308) после txop_event: стенд 8,05 − 5,00 мкс; std-сборка дала 8,98 */
#ifndef UC_ABFT_AP_BTI_END_CLK
#define UC_ABFT_AP_BTI_END_CLK 0u       /* объявленный (Duration) конец BTI позже txop_event (H-TXOP) */
#endif
#define ABFT_AP_STD_END_GUARD_CLK 330u  /* GP0 (конец A-BFT у AP) за 2 мкс до последней границы GP2 — как vendor, см. выше */

#if defined(UC_ABFT_STA_LASTBCN) && !defined(ABFT_STA_STD)
#error "UC_ABFT_STA_LASTBCN — только со стандартным таймингом станции"
#endif

/* GP_CLK2_TIMER: остаток хода GP2 в тактах (H-CLK2), 24 бита. */
static inline __attribute__((always_inline)) u32 abft_gp_clk2(void)
{
    uc_mac_cmd(0x4d00000a);
    __asm__ volatile("nop\n\tnop\n\tnop" ::: "memory");
    return arc_core_rd(55) & 0xffffffu;
}

#endif
