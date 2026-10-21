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

/* LBIFS при смене DMG-антенны (аудит IFS, P11). Сборка с UC_DBG=-DUC_LBIFS_STD согласует три
 * константы со стандартом; без флага они как у vendor. Действует только при смене антенны внутри
 * развёртки: повтор ISS для каждой приёмной антенны пира (sta_tab[].peer_n_ant ≥ 2) и наборы
 * секторов fwsh_n_sets ≥ 2 в BTI. С одним RF-модулем у обеих сторон (стенд) код этих путей не
 * исполняется и поведение не меняется ни с флагом, ни без.
 *
 *  1. Таймер между повторами (bcon_txss_sweep_step, GP группы 3, старт по tx_end — [гипотеза]):
 *     vendor 0xa40 = 2624 такта = TXTIME(SSW) + SBIFS − 1 такт; UC_LBIFS_STD — LBIFS = 2790.
 *     Зазор в эфире = таймер + путь uc/MAC после r54.16 (~100 инструкций до 0x19 + старт TX, не
 *     измерен). С vendor-значением зазор = LBIFS, только если этот путь ≥ 1,00 мкс; со стандартным
 *     нижняя граница (−0 %) выполнена при любом пути, а верхняя (+0,49 мкс) — если путь ≤ 0,49 мкс.
 *     Точное значение (LBIFS − путь) — только по замеру на плате с несколькими RF-модулями.
 *  2. Длительность ISS (txss_sweep_timing): vendor добавляет 17 мкс на каждую смену антенны пира;
 *     по стандарту смена заменяет SBIFS на LBIFS, т. е. добавляет LBIFS − SBIFS = TXTIME(SSW) +
 *     SBIFS = frame + gap (15 + 1 = 16 мкс, frame = ⌈14,909⌉). CDOWN уже считает LBIFS одной
 *     передачей (txss_program_tx_frame: (N − 1) + n·N, 10.42.2.2.2); с флагом Duration
 *     (ss_plan_tx_dur) на смене антенны уменьшается ещё на frame + gap (ss_plan_next_sector),
 *     и к концу развёртки остаётся то же, что при одной антенне, — у vendor остаётся +17·(N − 1).
 *  3. BTI (bti_measure_frame_duration): vendor добавляет 10 мкс при fwsh_n_sets ≥ 2. AP не меняет
 *     DMG-антенну внутри BTI (10.42.4), и у нас один набор секторов на BTI (passes = 1 в
 *     bti_dispatch_sweep_step), значит LBIFS в BTI нет; с флагом добавка 0. Если +10 у vendor
 *     покрывает что-то другое (переключение набора в начале TXOP BTI), без неё сработает assert
 *     0x75 — проверять только на плате с несколькими RF-модулями. */

#endif
