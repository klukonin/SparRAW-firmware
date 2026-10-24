/* SPDX-License-Identifier: AGPL-3.0-or-later */
#ifndef UC_IFS_H
#define UC_IFS_H
/* Межкадровые интервалы и длительности кадров DMG по 802.11-2020 — в тактах MAC/uc (165 МГц,
 * 1 мкс = 165 тактов). Константы стандарта, а не подобранные значения: где код отходит от них,
 * это сказано у места использования.
 *
 * aSIFSTime 3 мкс, aSBIFSTime 1 мкс, aSlotTime 5 мкс (Table 20-30); PIFS = aSIFSTime + aSlotTime
 * (10-5); MBIFS = 3·aSIFSTime (10.3.2.3.10); LBIFS = TXTIME(SSW) + 2·SBIFS (10.3.2.3.11). */
#define DMG_CLK_PER_US   165u
#define DMG_SIFS_CLK     (3u * DMG_CLK_PER_US)
#define DMG_SBIFS_CLK    (1u * DMG_CLK_PER_US)
#define DMG_SLOT_CLK     (5u * DMG_CLK_PER_US)
#define DMG_PIFS_CLK     (DMG_SIFS_CLK + DMG_SLOT_CLK)
#define DMG_MBIFS_CLK    (3u * DMG_SIFS_CLK)

/* TXTIME кадра control PHY (MCS0) длиной L байт (с FCS), 20.11.3 (N_CW — 20.4.3.3.3):
 *   TXTIME = T_STF + T_CE + (11·8 + (L − 6)·8 + N_CW·168)·32·Tc,  N_CW = 1 + ⌈(L − 6)·8 / 168⌉,
 *   Tc = 1/1760 МГц, T_STF = 6400·Tc (3,636 мкс), T_CE = 1152·Tc (0,655 мкс).
 * 165 МГц / 1760 МГц = 3/32 такта на чип; результат округлён вверх. */
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
#define DMG_LBIFS_CLK    (DMG_TXTIME_SSW_CLK + 2u * DMG_SBIFS_CLK)     /* 2790 = 16,909 мкс */

_Static_assert(DMG_TXTIME_SSW_CLK == 2460, "TXTIME(SSW)");
_Static_assert(DMG_TXTIME_SSW_ACK_CLK == 3012, "TXTIME(SSW-Ack)");
_Static_assert(DMG_TXTIME_SSW_FB_CLK == 3012, "TXTIME(SSW-Feedback)");
_Static_assert(DMG_LBIFS_CLK == 2790, "LBIFS");

/* LBIFS при смене DMG-антенны (802.11-2020 10.3.2.3.11, 10.42.2.2.2) — по стандарту, безусловно.
 * Действует только при смене антенны внутри развёртки: повтор ISS для каждой приёмной антенны пира
 * (sta_tab[].peer_n_ant ≥ 2) и наборы секторов fwsh_n_sets ≥ 2 в BTI. На стенде (один RF-модуль у обеих
 * сторон) эти пути не исполняются — НЕ ПРОВЕРЕНО на эфире.
 *
 *  1. Таймер между повторами (bcon_txss_sweep_step, GP группы 3, старт по tx_end — [гипотеза]): LBIFS = 2790
 *     тактов (DMG_LBIFS_CLK). Зазор в эфире = таймер + путь uc/MAC после r54.16 (~100 инструкций до 0x19 +
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
 * HW_MAC_IFS_SLOT = ifs_cfg_us[2] = 825 тактов, гипотеза H-SLOT2, проверяется опытом lat1) — до занятости эфира
 * (начало приёма). Число слотов = ⌈тайм-аут / aSlotTime⌉ = 4 (vendor 2 = 10 мкс — меньше AckTimeout: при позднем
 * ответе — ложный повтор). Long range — vendor 10, отдельно (не меняется). */
#define DMG_SLOT_US              5u
#define DMG_RX_PHY_START_DELAY_CTRL_CLK  (10u * DMG_CLK_PER_US)   /* aRxPHYStartDelay, DMG control mode */
#define DMG_RESP_TIMEOUT_CLK     (DMG_SIFS_CLK + DMG_SLOT_CLK + DMG_RX_PHY_START_DELAY_CTRL_CLK)   /* 2970 = 18 мкс */
#define DMG_RESP_TIMEOUT_SLOTS   ((DMG_RESP_TIMEOUT_CLK + DMG_SLOT_CLK - 1u) / DMG_SLOT_CLK)       /* 4 */
_Static_assert(DMG_RESP_TIMEOUT_SLOTS == 4u, "AckTimeout в слотах");
/* dot11BFRetryLimit (MIB, DEFVAL 8): инициатор может повторить SSW-Feedback до этого числа раз (10.42.6.2, «may restart
 * the SSW feedback procedure up to dot11BFRetryLimit times»). vendor — 2 повтора (3 попытки). */
#define DOT11_BF_RETRY_LIMIT     8u

/* ---- Сторожа опоздания по SIFS_CNT ----
 * SIFS_CNT — r55 после команды 0x4d000000: [15:8] целые мкс, [7:0] такты 0…164 (165 МГц); сравнение — по сырому
 * коду (монотонен). Отсчёт — от последнего «события начала IFS» MAC: в A-BFT — от события GP-таймера (стенд
 * 2026-10-21: 0,94 мкс у сторожа станции через ~0,9 мкс пути после GP1, 0,98 у AP при SSW в эфире), на пути
 * ответа в DTI — от события раньше конца принятого кадра (3,9–6,1 мкс перед запросом в MTP без сбоев,
 * UC-REGISTERS §2.16; вероятно, r42.12 — разбор заголовка, ~9 мкс от начала кадра). SIFS_CNT_ABFT_SSW_LATE и
 * SIFS_CNT_ABFT_FB_LATE — из замера срока MAC; SIFS_CNT_RX_ENTRY_LATE и SIFS_CNT_RESP_LATE — значения vendor,
 * подтверждённые замером срока (опыт rg). Каждое выражено как срок минус путь uc после
 * проверки. Прямую передачу MAC начинает через IFS из 0x886d00
 * (+ ~0,55 мкс) после события, если команды успели (H-ORIGIN, uc/abft.h); опоздание — MAC_HW_ICR б4/б5. */
#define SIFS_CNT_CODE(us, clk)  (((us) << 8) | (clk))
/* СРОК. Станция, SSW в A-BFT (abft_ssw_go/abft_ssw_burst): ответчик начинает RSS с начала своего слота (802.11-2020
 * 10.42.5.2), то есть первый SSW должен уйти в эфир целиком и вовремя. Замер (стенд, развёртка 0,1 мкс выдачи 0x19 после
 * события слота, отсчёт по SIFS_CNT при проверке, 3 загрузки): 0x19 через ≤ 4,34 мкс после события (SIFS_CNT при
 * проверке ≤ 1,70–1,72) — пачка полная, у AP первый SSW с CDOWN = FSS; 4,45 мкс (SIFS_CNT 1,82) — старт по времени тот
 * же, но первый SSW у AP теряется; с 4,57 (1,93) старт кадра сдвигается 1:1; с 2,51 MAC переносит пачку в следующий слот;
 * поздняя команда (assert 0x26) — недетерминированно с 1,90. Путь «чтение SIFS_CNT → 0x19» P = 2,61–2,64 мкс (с меткой
 * опыта; здесь короче). Порог = D − P − шаг: 4,34 − 2,64 − 0,10 = 1,60 мкс → [15:8] 1, [7:0] 0,60 × 165 = 99 тактов.
 * Удлинение пути от проверки до 0x19 (abft_ssw_go → abft_ssw_burst) на ΔP требует уменьшить порог на ΔP. */
#define SIFS_CNT_ABFT_SSW_LATE   SIFS_CNT_CODE(1u, 99u)     /* 0x163 = 1,60 мкс */
/* СРОК. AP, SSW-Feedback в A-BFT (mac_mode_program_c → direct_tx_step): начало Feedback — за aSSFBDuration + MBIFS
 * до конца слота (802.11-2020 10.42.5.2), точку держит MAC (GP1 + MBIFS из 0x886d00 + 0,55 мкс; от 0x19 не зависит).
 * Срок для uc — последняя выдача команд direct_tx_step, которую MAC ещё принимает. Замер (стенд, развёртка задержки
 * перед direct_tx_step, отсчёт по SIFS_CNT у проверки; 6 проходов, шаг 0,25 и 0,1): естественный путь — 2,58–2,68;
 * при SIFS_CNT до 6,91–7,85 Feedback уходит в свою точку (сдвиг ≤ 0,06), станция принимает его через 275,3 мкс после
 * события слота; дальше — поздняя команда в direct_tx_step / mac_program_rx_window (MAC_HW_ICR б4/б5, assert 0x26) или
 * потеря Feedback у станции, граница от прохода к проходу 7,0…7,9. Худший проход: последняя удачная — SIFS_CNT 6,91.
 * Порог = последняя удачная − шаг = 6,91 − 0,10 = 6,81 мкс → [15:8] 6, [7:0] ⌊0,81 × 165⌋ = 133 такта. SIFS_CNT
 * считается от события GP1, а точка Feedback = GP1 + MBIFS + 0,55: при смене длины слота (формула aSSDuration,
 * +16 тактов к таблице vendor, замер был на ней) обе сдвигаются вместе — порог от длины слота и FSS не зависит. */
#define SIFS_CNT_ABFT_FB_LATE    SIFS_CNT_CODE(6u, 133u)    /* 0x685 = 6,81 мкс */
/* СРОК. Вход rx_flow_run при состоянии MAC 5: опоздавший вход не выдаёт 0x1f006000…0x6000101 (rx_not_ready).
 * Путь редкий — служебные обмены (ассоциация, BF), приём данных DTI через него не идёт (опыт rg, 2026-10-24: 13 входов
 * за загрузку, 0 под UDP 71 тыс. кадров, ~30 за 70 с TCP 942 Мбит/с); естественный SIFS_CNT 0…2,8, после
 * ассоциации обычно 1,3–1,5 мкс — сторож срабатывает часто. Отсчёт SIFS_CNT — от события раньше конца кадра,
 * стандартного значения нет. Замер (сторож снят, спин по SIFS_CNT до цели 1,0…3,0 мкс с шагом 0,1, 3 загрузки,
 * .11 vendor шлёт WMI_BF_TRIG): последний удачный вход 1,33 мкс, первые неудачные 1,35 / 1,41 / 1,51 (uc assert 0x26 —
 * поздняя команда MAC; без сторожа естественный вход 2,02 мкс тоже даёт 0x26). Срок D ≈ 1,34 мкс; порог 1,19 ниже
 * последнего удачного на 0,14 мкс (> шага развёртки) — подтверждён, оставлен. */
#define SIFS_CNT_RX_ENTRY_LATE   SIFS_CNT_CODE(1u, 32u)     /* 0x120 = 1,19 мкс */
/* СРОК. Переключение на приём (rx_switch_to_rx_mode): опоздание — отмена 0x1f000601. Места вызова: rx_flow_handle_frame
 * (RTS / CF-End с Duration / sifs_resp), rx_flow_step (продолжение TXOP), rx_funcs_handle_ppdu_report (ответчик TXSS
 * и разбор SSW в BF). Естественный SIFS_CNT под TCP 1,9–2,1 мкс (95 %), 2,5–2,8 изредка, единицы 5,4 / 6,3 на 2700.
 * Замер (опыт rg, 2026-10-24; сторож снят, спин по SIFS_CNT до цели, шаг 0,1): RTS/CF-End и TXOP — цель до 8,0 мкс,
 * ~1900 переключений на каждом, TCP 925/945 Мбит/с — без сбоев (срок > 8 мкс); BF (ответчик TXSS, .11 vendor шлёт
 * WMI_BF_TRIG) — последние удачные 5,28 / 5,33 мкс, первые неудачные 5,39 / 5,45 / 5,79 (uc assert 0x6019 в
 * txss_resp_wait_iss_end), 3 загрузки. Порог общий, задаёт самый строгий путь (BF, D ≈ 5,3): 5,00 ниже последнего
 * удачного на 0,28 мкс — подтверждён, оставлен. */
#define SIFS_CNT_RESP_LATE       SIFS_CNT_CODE(5u, 0u)      /* 0x500 = 5,00 мкс */

#endif
