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
 * Maintenance 1 + FCS 4 = 28 Б (9.3.1.17). */
#define DMG_SSW_LEN      26u
#define DMG_SSW_ACK_LEN  28u
#define DMG_TXTIME_SSW_CLK      DMG_CTRL_TXTIME_CLK(DMG_SSW_LEN)       /* 2460 = 14,909 мкс */
#define DMG_TXTIME_SSW_ACK_CLK  DMG_CTRL_TXTIME_CLK(DMG_SSW_ACK_LEN)   /* 3012 = 18,255 мкс */
#define DMG_LBIFS_CLK    (DMG_TXTIME_SSW_CLK + 2u * DMG_SBIFS_CLK)     /* 2790 = 16,909 мкс */

_Static_assert(DMG_TXTIME_SSW_CLK == 2460, "TXTIME(SSW)");
_Static_assert(DMG_TXTIME_SSW_ACK_CLK == 3012, "TXTIME(SSW-Ack)");
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

/* ---- Сторожа опоздания по SIFS_CNT ----
 * SIFS_CNT — r55 после команды 0x4d000000: [15:8] целые мкс, [7:0] такты 0…164 (165 МГц); сравнение — по сырому
 * коду (монотонен). Отсчёт — от последнего «события начала IFS» MAC: в A-BFT — от события GP-таймера (стенд
 * 2026-10-21: 0,94 мкс у сторожа станции через ~0,9 мкс пути после GP1, 0,98 у AP при SSW в эфире), на пути
 * ответа в DTI — от события раньше конца принятого кадра (3,9–6,1 мкс перед запросом в MTP без сбоев,
 * UC-REGISTERS §2.16; вероятно, r42.12 — разбор заголовка, ~9 мкс от начала кадра). Значения — vendor; каждое
 * выражено как срок стандарта минус путь uc после проверки. Прямую передачу MAC начинает через IFS из 0x886d00
 * (+ ~0,55 мкс) после события, если команды успели (H-ORIGIN, uc/abft.h); опоздание — MAC_HW_ICR б4/б5. */
#define SIFS_CNT_CODE(us, clk)  (((us) << 8) | (clk))
/* Станция, SSW в A-BFT (abft_ssw_go/abft_ssw_burst): RSS — с начала слота (802.11-2020 10.42.5.2); MAC стартует первый
 * SSW в GP1 + SIFS + 0,55 мкс; путь сторож → 0x19 ≈ 2,7 мкс (метки A-BFT): позже 1,58 мкс — 0x19 после старта. */
#define SIFS_CNT_ABFT_SSW_LATE   SIFS_CNT_CODE(1u, 96u)     /* 0x160 = 1,58 мкс */
/* AP, SSW-Feedback в A-BFT (mac_mode_program_c): точка — aSSFBDuration + MBIFS до конца слота (10.42.5.2); MAC
 * стартует в GP1 + MBIFS (0x886d00) + 0,55; путь сторож → 0x19 ≈ 2,2 мкс: 7 мкс оставляют ~0,3 мкс до срока. */
#define SIFS_CNT_ABFT_FB_LATE    SIFS_CNT_CODE(7u, 0u)      /* 0x700 = 7,00 мкс */
/* Приём в DTI (rx_flow_run, состояние MAC 5): ответ Ack/BA/CTS — через SIFS 3 мкс −0/+0,49 (10.3.2.3.3);
 * отсчёт от события раньше конца кадра (см. выше), поэтому порог не равен SIFS: 1,19 мкс — vendor, опоздавший
 * вход не перевзводит окно приёма (rx_not_ready). Стандартного значения нет — оставлено. */
#define SIFS_CNT_RX_ENTRY_LATE   SIFS_CNT_CODE(1u, 32u)     /* 0x120 = 1,19 мкс */
/* Переключение на приём перед ответом (rx_switch_to_rx_mode, RTS/CF-End): за 5 мкс — ответ через SIFS
 * (CTS, 10.3.2.9) заведомо позже SIFS + 0,49 и у инициатора истекает CTSTimeout (SIFS + aSlotTime + задержка
 * PHY, 10.3.2.9) — отмена 0x1f000601. Отсчёт как у Ack (раньше конца кадра) — оставлено. */
#define SIFS_CNT_RESP_LATE       SIFS_CNT_CODE(5u, 0u)      /* 0x500 = 5,00 мкс */

#endif
