/* SPDX-License-Identifier: AGPL-3.0-or-later */
#ifndef UC_ABFT_H
#define UC_ABFT_H
#include "ifs.h"
/* Тайминг A-BFT (802.11-2020 10.42.5): величины стандарта в тактах MAC/uc (165 МГц, 1 мкс = 165 тактов)
 * — эталон 802.11-2020 и замеры стенда (vendor 6.2 — только источник фактов о регистрах и командах MAC).
 * Цифры ниже — замеры на стенде (две платы wil6210, Timer1 165 МГц), 2026-10-21…22.
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
 * Флагов совместимости таймингом с vendor 6.2 нет (удалены, cleanup/no-vendor-timing): сравнение с vendor —
 * только с его прошивкой на узле стенда.
 *
 * Тайминг:
 *   станция — GP0 = Duration − 0x284 от конца GP2 (= конец приёма маяка + 3,903 мкс) кончается в конец
 *     BTI (B) по первому маяку, GP1/GP2 поправляются по каждому следующему маяку (10.42.5.1); событие GP1 — в B + MBIFS − SIFS − задержка MAC, первый SSW MAC начинает сам ровно в
 *     B + MBIFS; конец A-BFT (GP2) = B + MBIFS + n·aSSSlotTime. Вход в BTI с пути приёма (kind 1) —
 *     GP0 по следующему маяку развёртки; GP0 не взводится, если GP2 этого маяка уже не идёт;
 *   AP — слот 0 = txop_event + MBIFS (GP2/GP0 с пуском 0x…030c/0x…0308 стартуют через ~SIFS после
 *     txop_event), событие GP1 в слоте — за MBIFS + задержку MAC до точки SSW-Feedback, Feedback MAC
 *     начинает сам в aAirPropagationTime + aSSDuration + MBIFS от начала слота.
 *
 * Что известно о железе (стенд с 2026-10-21):
 *   H-ORIGIN [3 замера AP + метки станции]: прямую передачу (SSW ответчика, SSW-Feedback) MAC начинает
 *            через IFS из 0x886d00 + ~0,55 мкс (UC_ABFT_MACLAT_CLK; включает неточность ctx 1,45 мкс)
 *            после последнего GP-события (начало отсчёта SIFS_CNT), если uc успел выдать команды; иначе —
 *            «поздняя команда» (MAC_HW_ICR б4/б5 → INT6 → assert 0x26). AP: 0x886d00 = MBIFS
 *            (mac_mode_kick) — Feedback = GP1 + 9,55 мкс (264,1 при GP1 254,56; 268,23 при 258,66);
 *            станция: 0x886d00 = SIFS — первый SSW = GP1 + 3,55 мкс (метки A-BFT: 0,94 + 2,69 + …).
 *            Сторожа SIFS_CNT ≥ 0x160 (станция) и ≥ 0x700 (AP) — срок выдачи команд относительно этого IFS
 *            (значения из 6.2, срок MAC не измерен). Ожидание uc до точки (прежний вариант: подготовка
 *            заранее и спин по GP_CLK2 перед 0x2008000) нарушало срок — FWERR 0x26 у станции
 *            (MAC_HW_ICR = 0x30038), а Feedback AP всё равно уходил по GP1 + MBIFS (+5,69 мкс);
 *   H-CLK2 [подтверждено]: GP_CLK2_TIMER — остаток хода GP2, счёт вниз, перезагрузка на границе слота
 *            (t от границы + GP_CLK2 = aSSSlotTime с точностью 9 тактов);
 *   H-GP9  [подтверждено у AP]: пуск 0x…090c — по концу GP2 (GP1 AP: событие через aSSDuration + 1,0 мкс
 *            от границы слота); у GP0 станции (0x5200090c) — то же (не измерено);
 *   H-GP3  [замер]: GP2 = 0x339 (5 мкс) с пуском 0x5400030c дал границу через 8,05 мкс после txop_event
 *            (7,6 мкс после команды), т. е. пуск ≈ через SIFS (3 мкс) после txop_event, а не по команде;
 *            ABFT_AP_TRIG03_CLK — эта задержка;
 *   H-GP5  [гипотеза]: GP2 станции = 0x284 (3,903 мкс) с пуском 0x54000508 стартует концом приёма кадра;
 *            GP0, взведённый после конца GP2, пропускает A-BFT по r54.8 (стенд A1: 64 из 64 попыток в 6
 *            загрузках из 8 кончились так — bcn_rx.x1c);
 *   H-GO   [опровергнута]: «кадр уходит по 0x19» — нет, старт задаёт MAC (H-ORIGIN), 0x19 должна лишь
 *            успеть; 0x19 → tx_end 7,0–8,8 мкс у Feedback — это ожидание точки GP1 + MBIFS;
 *   H-TXOP [замер]: при TXOP BTI = n·(d + SBIFS) (d из r47, целые мкс вверх; запасной путь, если длина маяка
 *            не сошлась) txop_event — через 74,2 мкс после tx_end последнего маяка; запись 0x15 перед каждым
 *            маяком перезадаёт TXOP: txop_event = E + δb − MACLAT (замер на стенде);
 *   H-T1   [подтверждено]: Timer1 = 165 МГц (период SSW 2626 тактов = 15,92 мкс).
 *   H-DUR  [маяки, стенд]: код 0x15 = «биты 24/26/28»; без б1 в 0x14 (0x14000005) MAC пишет в Duration
 *            маяка остаток TXOP с отбрасыванием дробной части, с б1 (0x14000007) — 0x15 − d буквально (rnd1);
 *            вне BTI 0x15 — Duration буквально (SSW/SSW-Feedback/SSW-Ack, замер на стенде).
 *   H-HDR  [стенд std2]: rx_frame_event (r42.12) приходит после разбора заголовка MPDU — через ~9,06 мкс от
 *            начала кадра (r42.19 → r42.12 у SSW-Feedback 9,01–9,12 мкс), а не в конце кадра: у маяка 34 Б
 *            за 10,07 мкс до конца, у маяка vendor 38 Б — за 10,65. Окно взвода GP0 станции (до конца GP2) —
 *            ~14 мкс от r42.12; станция по стандарту на стенде: первый SSW = конец BTI + 8,73 мкс (оба AP).
 */

#define ABFT_CLK_PER_US     165u
#define ABFT_SIFS_CLK       495u        /* aSIFSTime 3 мкс (Table 20-30) */
#define ABFT_MBIFS_CLK      1485u       /* MBIFS = 3 × aSIFSTime = 9 мкс (10.3.2.3.10) = 0x5cd */
#define ABFT_AIRPROP_CLK    17u         /* aAirPropagationTime 0,1 мкс = 16,5 такта (Table 20-30), вверх */
#define ABFT_SSFB_CLK       3012u       /* aSSFBDuration = TXTIME(SSW-Feedback, 28 Б, control PHY) = 18,255 мкс */

/* ---- тайминг A-BFT ---- */
/* Станция. */
#define ABFT_STA_GP2_RXEND_CLK  0x284u  /* GP2 станции от конца приёма кадра (bti_reset_sweep_state, H-GP5) */
#ifndef UC_ABFT_STA_GP0_TRIM_CLK
#define UC_ABFT_STA_GP0_TRIM_CLK 41u    /* стенд std2: конец GP0 на 0,25 мкс раньше конца BTI (GP2 стартует до конца кадра в эфире) */
#endif
#ifndef UC_ABFT_MACLAT_CLK
#define UC_ABFT_MACLAT_CLK    91u       /* старт прямой передачи после события GP + IFS(0x886d00): стенд 0,55 мкс (H-ORIGIN) */
#endif
/* Событие GP1 станции после конца GP0 (= конец BTI): первый SSW в B + MBIFS при IFS ответа = SIFS. */
#define ABFT_STA_STD_GP1_CLK  (ABFT_MBIFS_CLK - ABFT_SIFS_CLK - UC_ABFT_MACLAT_CLK)
/* AP. */
#define ABFT_AP_TRIG03_CLK    502u      /* пуск GP0/GP2 (0x…030c/0x…0308) после txop_event: стенд 8,05 − 5,00 мкс; std-сборка дала 8,98 */
#ifndef UC_ABFT_AP_BTI_END_CLK
/* Конец BTI, объявленный в Duration ПОСЛЕДНЕГО маяка нашего AP, относительно txop_event (H-TXOP). MAC пишет
 * Duration = остаток TXOP BTI в целых мкс с отбрасыванием дробной части (TXOP = n·(20 + 1) от начала первого
 * маяка, d из r47 округлено вверх; запасной путь): стенд std2/std3 (64 маяка × 34 Б), сверка станции и AP: по последнему
 * маяку (Duration 56) конец BTI = txop − 0,64 мкс, по первому — txop − 1,97 (стабильно от загрузки к
 * загрузке). Сетка A-BFT — от объявленного конца BTI (станция берёт последний маяк, 10.42.5.1). Нужна только
 * на запасном пути (длина маяка не сошлась с r47 → TXOP BTI = n·(d + SBIFS)); основной путь — bt_frac (bti.c). */
#define UC_ABFT_AP_BTI_END_CLK (-105)
#endif
#define ABFT_AP_STD_END_GUARD_CLK 330u  /* GP0 (конец A-BFT у AP) за 2 мкс до последней границы GP2: mac_mode_kick
                                         * выходит по GP0, а не начинает слот n (значение из 6.2, не проверено) */

/* Конец BTI станции — по последнему маяку (поправка GP1/GP2, bti_bi2_track_best_metric, 10.42.5.1). */
/* Поправка станции по последнему маяку успевает, только если конец GP0 (конец BTI по ПЕРВОМУ маяку) позже конца
 * последнего маяка на ~1,4 мкс: отчёт о его приёме (r42.16) — через ~0,3 мкс после конца, затем путь цикла
 * (стенд bcn2: команды поправки через 1,40 мкс после конца маяка). Удлинять GP0 станции нельзя: путь uc от конца
 * GP0 до ожидания границы слота ~3,4 мкс (bcn2, r3std_3: при GP0 + 3 мкс отказ tx_ssw по сторожу SIFS_CNT 1,68 мкс),
 * а GP1 = 5,45 мкс − запас. Поэтому запас даёт AP: BCN_DUR_DLAST_US (ниже). */

/* Duration кадров SLS (9.3.1.15–17). */
#define ABFT_CLK2FX_MUL      6355u      /* такты → 1/1024 мкс: 1024/165 = 6,2061 ≈ 6355/1024 */
#define ABFT_SSW_TXTIME_FX   15267u     /* TXTIME(SSW 26 Б) = 14,909 мкс в 1/1024 мкс */
#define ABFT_SSW_STEP_FX     16291u     /* TXTIME(SSW) + SBIFS = 15,909 мкс */
/* Duration кадров SLS вне BTI. Команда 0x15 (код = биты 24/26/28) с последующей 0x14000007 — значение
 * Duration БУКВАЛЬНО (стенд, метка 3, std4/std5/bti1: SSW vendor-станции в ISS/RSS — CDOWN 1/0 → 17/1 =
 * ss_plan_tx_dur; SSW-Feedback vendor — 20 = txss_timing_add 17 + SIFS 3; A-BFT — 254/275). Остаток
 * «TXOP» MAC пишет только у маяков BTI (перед ними 0x14000005; стенд). Округление — вверх
 * (9.2.5.1): ⌈x / 1 мкс⌉ из тактов ifs.h.
 *
 * SSW в ISS/RSS (9.3.1.15): до конца SSW с CDOWN 0 + MBIFS. ss_plan_tx_dur = gap + cdown·(frame + gap)
 * (txss_set_sweep_param / ss_plan_next_sector; frame = txss_timing_base = ⌈TXTIME(SSW)⌉ мкс, gap = SBIFS
 * из 0x886d0c), поэтому
 *   Duration = ⌈(cdown·(TXTIME(SSW) + gap) + MBIFS) / 165⌉ = ss_plan_tx_dur − gap + MBIFS − ⌊cdown·δ / 165⌋,
 *   δ = frame·165 − TXTIME(SSW) (тактов, на которые frame в плане длиннее кадра; 15 при frame 15).
 * Тождество верно, пока MBIFS — целое число мкс. ⌊cdown·δ/165⌋ — умножением: m = δ·101681 ≥ δ·2^24/165,
 * (cdown·m) >> 24; точно при cdown ≤ 255, δ ≤ 164 (проверено перебором; cdown·m < 2^32), без деления на пути
 * между SSW. При смене
 * антенны (несколько DMG-антенн у пира) план добавляет на неё frame + gap (LBIFS, ifs.h) —
 * эту часть Duration берёт из плана как есть (на стенде путь не исполняется). Конец выделения
 * («whichever comes first») не учитывается — как и раньше. */
_Static_assert(DMG_MBIFS_CLK % DMG_CLK_PER_US == 0, "MBIFS — целое число мкс");
#define SLS_MBIFS_US          (DMG_MBIFS_CLK / DMG_CLK_PER_US)
static inline __attribute__((always_inline)) u32 sls_ssw_dur_mul(u32 frame_us)
{
    s32 d = (s32)(frame_us * DMG_CLK_PER_US) - (s32)DMG_TXTIME_SSW_CLK;
    return d > 0 ? (u32)d * 101681u : 0u;
}
/* Duration SSW с этим cdown; add = SLS_MBIFS_US − gap (считается до развёртки). */
#define SLS_SSW_DUR(plan, add, cdown, mul) \
    ((plan) + (add) - (((u32)(cdown) * (mul)) >> 24))
/* SSW-Feedback в DTI (9.3.1.16 a/b): TXTIME(SSW-Ack) + MBIFS; при запросе BRP — + 2·MBIFS; вверх. 28 / 37. */
#define SSWFB_DUR_US      ((DMG_TXTIME_SSW_ACK_CLK + DMG_MBIFS_CLK + DMG_CLK_PER_US - 1u) / DMG_CLK_PER_US)
#define SSWFB_DUR_BRP_US  ((DMG_TXTIME_SSW_ACK_CLK + 2u * DMG_MBIFS_CLK + DMG_CLK_PER_US - 1u) / DMG_CLK_PER_US)
/* SSW-Ack (9.3.1.17): Duration SSW-Feedback − MBIFS − TXTIME(SSW-Ack), вверх; для целого D:
 * ⌈D − x⌉ = D − ⌊x⌋ → D − 27 (28 → 1, 37 → 10). */
#define SSWACK_DUR_SUB    ((DMG_MBIFS_CLK + DMG_TXTIME_SSW_ACK_CLK) / DMG_CLK_PER_US)
_Static_assert(SSWFB_DUR_US == 28u && SSWFB_DUR_BRP_US == 37u && SSWACK_DUR_SUB == 27u, "Duration SLS");

/* ---- TXOP BTI (802.11-2020 10.42.4, 9.2.5.1): Duration маяков и конец BTI по эфиру ---- */
/* TXTIME маяка — по формуле Control PHY (ifs.h) от длины PSDU, которую fw кладёт в fwsh_diag.bcn_psdu_len при
 * постановке шаблона (TX_API_send_dband_bcon); P = TXTIME + SBIFS; TXOP = ⌈((n − 1)·P + d·165) / 165⌉ мкс (d —
 * длительность маяка из r47, MTP_AGGREGATION, целые мкс вверх) — у последнего маяка остаток TXOP ≥ d. Сверка:
 * ⌈TXTIME/165⌉ должно совпасть с d из r47 (иначе MAC считает кадр иначе — не Control PHY, другая длина) — тогда
 * запасной путь: TXOP = n·(d + SBIFS) (план развёртки; ~55 мкс пустого эфира после 64 маяков) и счётчик
 * fwsh_diag.bti_txop_fallback. */
/* Duration маяка MAC пишет как остаток TXOP с отбрасыванием дробной части (H-DUR) в конце кадра; маяки в эфире
 * идут на ~0,18 мкс позже, чем по формуле от начала TXOP (TXOP начинается раньше первого маяка): сверка станции
 * и AP — «txop − конец BTI по последнему маяку» 0,64 мкс при TXOP 1344 (std5) и 0,68 при 1289 (bti1), формула
 * без сдвига даёт 0,855 в обоих, со сдвигом 30 тактов — 0,67. Нужна, чтобы сетка A-BFT шла от конца BTI,
 * объявленного последним маяком, так же, как его считает станция. Остаток у последнего маяка целым числом мкс
 * сделать нельзя: TXOP задаётся в целых мкс, а (n − 1)·P + TXTIME — от длины маяка, доля фиксирована. */
#ifndef UC_BTI_DUR_REF_CLK
#define UC_BTI_DUR_REF_CLK  30u
#endif
/* Duration маяков BTI по 9.2.5.1 (вверх) — буквально (на запасном пути TXOP — ⌊остатка TXOP⌋ MAC).
 * Стенд (exp/dur-round, rnd1, 2026-10-22): 0x14 с б1 перед маяками (0x14000007 вместо 0x14000005) — Duration
 * = значение 0x15 минус d (у всех маяков 1269 = 1289 − 20 при одном значении 0x15 = TXOP), txop_event и A-BFT
 * AP живы; без б1 MAC пишет ⌊остатка TXOP⌋. Гипотеза H-LIT2: в буквальном режиме Duration маяка = 0x15 − d,
 * d — длительность кадра MAC в целых мкс вверх (r47 = ss_timing.frame), проверена только при d = 20.
 *
 * Конец BTI E выбирается так, чтобы первый маяк получил 0x15 = TXOP (то же значение, что сейчас ставит TXOP
 * BTI, — TXOP не меняется ни при какой модели защёлкивания 0x15): E = конец последнего маяка + D_last,
 * D_last = TXOP − d − ⌈(n − 1)·P / 165⌉ (TXOP поднимается так, чтобы D_last = BCN_DUR_DLAST_US). Маяк с CDOWN j несёт
 * Duration = ⌈(j·P + D_last·165) / 165⌉ = D_last + ⌈j·P/165⌉ — точное округление вверх до E (9.2.5.1); станция
 * по последнему маяку (10.42.5.1) получает ровно E. В 0x15 пишется Duration + d. Через план развёртки
 * (ss_plan_tx_dur = TXOP − (d + gap)·(n − 1 − j), ss_plan_next_sector) и δb = d·165 − TXTIME (0…164):
 *   0x15 = ss_plan_tx_dur + K − ⌊j·δb/165⌋,   K = ⌊(n − 1)·δb/165⌋
 * (тождество ⌈j·P/165⌉ = (d + gap)·j − ⌊j·δb/165⌋) — та же форма, что SLS_SSW_DUR у SSW, тот же путь цикла.
 * ⌊j·δb/165⌋ = (j·m) >> 16, m = ⌈δb·2^16/165⌉; в цикле — SLS_SSW_DUR с dmul = (m + 1) << 8 (перебором: точно
 * при j ≤ 222, δb ≤ 164 — у маяков j ≤ 63; произведение < 2^32). bti.c кладёт m + 1 в ss_timing._6 и K в ss_timing.total (total
 * читает только txss_set_sweep_param, а план затем заменяется TXOP); _6 = 0 — буквального режима нет (запасной
 * путь TXOP, наборы секторов ≥ 2). */
/* D_last в буквальном режиме: конец BTI на 3 мкс после конца последнего маяка (TXOP BTI = ⌈(n − 1)·P/165⌉ + d +
 * D_last). Нужен станции (по стандарту 10.42.5.1 — последний маяк): её GP0 кончается в конце BTI по первому маяку
 * = E + доля ⌈⌉ ≥ конец последнего + 3 мкс — поправка по последнему маяку (через ~1,4 мкс после его конца) успевает
 * с запасом ≥ 1,6 мкс. Стенд bcn1/bcn2 (D_last = 0): GP0 кончался за ~0,35 мкс до конца последнего маяка, станция
 * стояла по маяку CDOWN 1 (+0,87). Цена — 3 мкс эфира в BTI; txop_event = E + δb − MACLAT (H-TXOP) — сетка та же. */
#ifndef BCN_DUR_DLAST_US
#define BCN_DUR_DLAST_US 3u
#endif

/* x/165 без деления (Timer1/MAC: 165 тактов в мкс), точно для x < 2^26 */
static inline __attribute__((always_inline)) u32 clk_to_us_floor(u32 x)
{
    u32 q = (u32)(((u64)x * 25421u) >> 22);
    while (q * 165u > x)
        q--;
    while ((q + 1u) * 165u <= x)
        q++;
    return q;
}

/* Timer1 (AUX 0x100 COUNT1) одной инструкцией; предел 0x13ab6680, обнуляется тиком L1. */
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

/* ---- Discovery Mode в A-BFT (802.11-2020 10.42.5.1, 9.3.4.2 рис. 9-77/9-79, 9.4.1.46 табл. 9-69) ----
 * Маяк: BI Control (кадр +23, bcn_rx.bi_ctrl[0]): б0 CC Present, б1 Discovery Mode; DMG Parameters (+29) &3 — BSS
 * Type (bcn_rx.bss_type); при CC Present = 1 и Discovery Mode = 1 Clustering Control (+30..+37) = A-BFT Responder
 * Address (6 Б) + резерв. При Discovery Mode = 1 станция передаёт в A-BFT, только если: CC Present = 0; или адрес —
 * индивидуальный и равен нашему; или адрес групповой, мы в группе и наша роль совпадает с BSS Type (табл. 9-69:
 * 3 — AP, 2 — PCP, 1 — не-AP STA, 0 — любая). Членство в группах uc не знает, кроме широковещательной (в ней все):
 * прочие групповые адреса — консервативно «не в группе», не передавать. Буфер приёма rx_buf (0x804010) держит
 * не меньше +0x26 Б кадра (+0x24 читает BRP), +30..+35 в нём. */
#define ABFT_BCN_RA_OFF  30u
#define ABFT_MAX_ACCESS_PERIOD 2u        /* aMaxABFTAccessPeriod (802.11-2020 Table 11-22, DMG MAC sublayer attribute values: 2) */
static inline __attribute__((always_inline)) u32 abft_bcn_ra_is_own(const u8 *a)
{
    u32 lo = (u32)a[0] | ((u32)a[1] << 8) | ((u32)a[2] << 16) | ((u32)a[3] << 24);
    u32 hi = (u32)a[4] | ((u32)a[5] << 8);
    return lo == MMIO32(HW_MAC_OWN_ADDR_LO) && hi == (MMIO32(HW_MAC_OWN_ADDR_HI) & 0xffffu);
}
/* Маяк этого BTI — с Discovery Mode = 1, CC Present = 1 и A-BFT Responder Address = наш MAC (обход aMaxABFTAccessPeriod). */
static inline __attribute__((always_inline)) u32 abft_bcn_addressed_to_us(void)
{
    return (bcn_rx.bi_ctrl[0] & 3u) == 3u && abft_bcn_ra_is_own(rx_buf + ABFT_BCN_RA_OFF);
}
/* 1 — передача в A-BFT разрешена условиями Discovery Mode (10.42.5.1). */
static inline __attribute__((always_inline)) u32 abft_discovery_ok(void)
{
    u32 bic0 = bcn_rx.bi_ctrl[0];
    if (!(bic0 & 2u))
        return 1;                                   /* Discovery Mode = 0 — условия не действуют */
    if (!(bic0 & 1u))
        return 1;                                   /* CC Present = 0 */
    const u8 *a = rx_buf + ABFT_BCN_RA_OFF;
    if (!(a[0] & 1u))
        return abft_bcn_ra_is_own(a);               /* индивидуальный адрес */
    if ((a[0] & a[1] & a[2] & a[3] & a[4] & a[5]) != 0xffu)
        return 0;                                   /* группа, членство неизвестно — не передавать */
    u32 bt = bcn_rx.bss_type & 3u;                  /* широковещательный: все в группе — сверка роли (табл. 9-69) */
    if (bt == 0)
        return 1;
    u32 role = uc_role_ap ? (uc_role == 3 ? 2u : 3u) : 1u;   /* cmd 0x1b: режим 2 — AP, 3 — PCP, иначе не-AP STA */
    return bt == role;
}

#endif
