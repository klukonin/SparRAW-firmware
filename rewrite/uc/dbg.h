/* SPDX-License-Identifier: AGPL-3.0-or-later */
#ifndef UC_DBG_H
#define UC_DBG_H
/* Отладочные вставки для замера запаса по срокам (план тестов СРОК/ХРУПКО). В рабочей сборке
 * (без -D ниже) оба макроса пусты и код не меняется; сборки с флагами — только для стенда.
 *
 * UC_PAD(site): K команд nop в точке site, если сборка с -DUC_PAD_SITE=site -DUC_PAD_K=K
 * (UC_DBG="-DUC_PAD_SITE=… -DUC_PAD_K=…"). Ветка с ложным условием удаляется компилятором до
 * кодогенерации, поэтому остальные точки не влияют на код. K — из таблицы UC_NOPS_* ниже
 * (1, 2, 4, 8, 12, 16, 20, 24, 28, 32, 40, 48, 56, 64, 96, 128). Серия K = 0, 4, 8, 16, 32, 64 даёт
 * запас пути в инструкциях (tools/stand_tests/pad_sweep.sh).
 *
 * UC_STAMP(id, a0, a1): запись в кольцо журнала uc (формат записи с 2 аргументами, токен
 * 0xfff00 | id) — вместо TSF счётчик тактов Timer1 (AUX 0x100 COUNT1, 165 МГц, период
 * 0x13ab6680 тактов ≈ 2 с), затем a0, a1. Только при -DUC_STAMP_MASK с битом id; стоит ~14
 * инструкций. Разбор — tools/hwdbg/stamps.py. */

/* Точки вставки nop (номер = UC_PAD_SITE). */
#define PAD_RESP_CMD      1   /* rx: начало rx_frame_tx_resp_seq, перед запросом MTP (ответ Ack/BA) */
#define PAD_RESP_ENTRY    2   /* rx: вход rx_flow_handle_frame */
#define PAD_TXOP          3   /* rx: перед 0x1b001111 в rx_txop_continue (прежний UC_DBG_TXOP_PAD) */
#define PAD_TRN_LOOP      4   /* brp: тело цикла метрик TRN */
#define PAD_ABFT_SSW      5   /* bti: между SSW в abft_ssw_burst (сейчас не используется) */
#define PAD_IMM_RESP      6   /* tx: перед командой в tx_send_imm_response (DMG CTS, Grant Ack, CF-End) */
/* 7 — свободен (была mac_mode_switch_after_ppdu, путь DMG DTS) */
#define PAD_SSWFB_ABFT    8   /* tail: direct_tx_ssw_feedback (SSW-Feedback в A-BFT) */
#define PAD_D10_WRITE     9   /* rx: перед записью 0x886d10 в rx_flow_step */
#define PAD_ABFT_SIFSCHK 10   /* bti: перед проверкой SIFS_CNT в abft_ssw_go */
#define PAD_EARLY_REQ    11   /* rx: rx_fast_resp_early — после отчёта, перед запросом MTP (стенд 2026-11-16: 64 — без сдвига, 128 — обрыв) */

/* Номера меток UC_STAMP (бит в UC_STAMP_MASK). */
#define STAMP_CCA_DET        0   /* l1: вход по busy_event (~каждый 8-й) — опрос PHY_SIGNALS и r42 до rx_frame_event (≤ 15 мкс):
                                      * a0 = признаки «уже было на входе» (б31 cca_ppdu_comp снят, б30 sfd_sync, б29
                                      * rx_frame_event) | такты до cca ≠ 0 [28:16] (0x1fff — нет) | до rx_frame_event [15:0];
                                      * a1 = такты до снятия cca_ppdu_comp [31:16] | до sfd_sync [15:0] (0xffff — не дождались).
                                      * Стенд 2026-10-30: phy_rx_frame поднимается вместе с rx_frame_event; sfd_sync за
                                      * 815–832 такта до него. */
#define STAMP_ABFT_SLOT      1   /* bf: AP, граница слота A-BFT (конец GP2) или конец A-BFT (GP0); a0 = события r54 */
#define STAMP_ABFT_SSW_RX    2   /* tail: AP, принят SSW станции в слоте; a0 = поле SSW (CDOWN [9:1], сектор [15:10]) */
#define STAMP_ABFT_FDBK_CMD  3   /* tail: AP, команда SSW-Feedback в A-BFT */
#define STAMP_SSW_TX_EVT     4   /* bti: станция, пачка SSW — tx_end_event (r42.15) кадра; a0 = CDOWN следующего */
#define STAMP_SSW_TX_FREE    5   /* bti: станция, пачка SSW — «передатчик свободен» (mac_evt_enable_bit_sync(5)) */
#define STAMP_SWEEP_TX_EVT   6   /* tail: развёртка (маяки/RSS) — tx_end_event кадра; a0 = CDOWN, a1 = f<<16 | длина маяка */
#define STAMP_FB_GO          8   /* tail: SSW-Feedback инициатора в DTI — после 0x19/0x18 (до записи FIFO); a0 = повтор */
#define STAMP_FB_COMMIT      9   /* tail: то же — FIFO закрыт (direct_tx_commit) */
#define STAMP_FB_TX_EVT     10   /* tail: то же — tx_end_event (r42.15) */
#define STAMP_RESP_SIFS_CNT 12   /* rx: ответ через SIFS — после 0x37000020/0x19: a0 = SIFS_CNT (от конца приёма), a1 = вид */
#define STAMP_LONG_TASK     13   /* l1/sched: задача дольше STAMP_LONG_CLK; a0 = номер фоновой | 0x100 + режим L1, a1 = такты */
#define STAMP_LONG_CLK      330  /* 2 мкс */
#define STAMP_BF_SEG        15   /* bf: bf_sm_process_request_fifo — отрезок; a0 = номер | состояние << 8, a1 = такты от входа */
#define STAMP_FW_CMD        14   /* misc: команда fw (ящик) дольше STAMP_LONG_CLK; a0 = код команды, a1 = такты */
#define STAMP_EVT           16   /* boot/evt: отправка события в fw; a0 = 0 — взят слот (uc_evt_write_slot), 1 << 16 | тип —
                                      * событие поставлено, прерывание fw выдано (2026-10-29: 2,5–3 мкс, из них ~1,6 — кольцо) */
#define STAMP_BENCH         17   /* bench: микротест цены операций (uc/bench.c, -DUC_BENCH); a0 = номер | n << 8 |
                                      * мс TSF << 16, a1 = такты */
#define STAMP_L2_ENTRY      11   /* l1: вход в задачу L2; a0 = номер задачи, a1 = ilink2 (где вытеснен код) */
#define STAMP_SWEEP_TX_FREE  7   /* tail: развёртка — «передатчик свободен» (mac_evt_enable_bit_sync(5)); a0 = CDOWN */
#define STAMP_MTP_LAT       18   /* rx/tx: запрос MTP 0x1b001111 → MAC_MTP_RESP_VALID; a0 = место << 16 | такты, a1 — такты
                                      * до MAC_MTP_PERM_VALID (tx_submit_frame) или 0. Место: 1 — rx_txop_continue,
                                      * 2 — tx_submit_frame */
#define STAMP_IRQ_LAT       19   /* l1: тик таймера 0 (вектор 3) — COUNT0 на входе и выходе l1_task_entry(3) (COUNT0 = 0 в
                                      * момент срабатывания таймера): a0 — задержка входа, a1 − a0 — длительность тика */
#define STAMP_L1_EVT        20   /* l1: вход L1 режимов 1/2 (векторы 9/12): a0 = режим << 24 | r42[23:0], a1 = r54; при
                                      * загрузке (после запуска таймеров) — a0 = 0xff << 24 | адрес, a1 = значение регистров
                                      * масок прерываний MAC (источники векторов 6/9/12/14) */
#define STAMP_BI1_LEAD      21   /* l1: вход L1 режима 1 с bi1_event (r42 б4): a0 = мкс до TBTT (0x886ec0), a1 = TSF[31:0] */
#define STAMP_BCN_REP       22   /* bti: станция приняла маяк своей BSS (после взвода GP0): две метки подряд — a0/a1 = r36/r37,
                                      * затем r38/r39 (отчёт о кадре для модели эфира) */
#define STAMP_SSW_REP       23   /* abft_rx_ssw_tx_feedback (AP, слот A-BFT): по MAC_EVT1_RX_FRAME, до проверки «SSW» — две метки
                                      * подряд: r36/r37, затем r38/r39 (готов ли отчёт на rx_frame_event и его значения) */
#define STAMP_FB_REP        24   /* приём SSW-Feedback: abft_resp_parse_fdbk (станция в A-BFT, после ppdu_report) и
                                      * sls_rx_ssw_frame (SLS) — две метки: r36/r37, затем r38/r39 */
#define STAMP_BCN_TSF       25   /* станция, маяк: a0 = TSF[31:0] − начало текущего BI (HW_MAC_BI_START_TSF_LO), мкс; a1 = б31 путь
                                      * (0 — BTI по bi1_event, bti_beacon_rx_step; 1 — путь приёма rx_flow), б30 my_bss, [8:0] CDOWN */
#define STAMP_BCN_GO        26   /* развёртка (tail.c), разрешение MTP первого кадра: a0 = TSF[31:0] − начало BI, мкс; a1 = r40
                                      * PHY_SIGNALS проверки «канал свободен» (счётчик CCA [21:16], PPDU [13:8], cca_ppdu_comp б24) | б31 f.
                                      * Метка прямо после чтения r40 (до проверки) роняла AP: FWERR 6 за загрузку, коды 0/0 (стенд). */
#define STAMP_BCN_SLOT      27   /* bti (AP), перед ожиданием slot_event: a0 = TSF[31:0] − начало BI, a1 = мкс до TBTT (0x886ec0).
                                      * Переключение селектора r40 здесь (замер CCA) роняло AP — не делать. */
#define STAMP_QSEL          28   /* tx_slot_pick_queue: a0 = r41 сел. 0 (QUEUE_SEL_STATUS: набор [11:8], qid [20:16]), a1 = TSF − начало BI */
#define STAMP_BACKOFF       29   /* L1 по backoff_event (r42 б18): a0 = TSF − начало BI, a1 = mac_tx_qid_en_shadow (б31 — внутренняя) */
#define STAMP_RESP_REP      30   /* rx_get_required_response (вход): две метки — r36/r37, затем r38/r39 (отчёт кадра «для нас») */
#define STAMP_BAP_RX        31   /* rx_get_required_response после ожидания MAC_BAP_RX_UPDATE: a0 = r53 (BAP), a1 = r36 */
/* 32.. — бит (id − 32) в UC_STAMP_MASK2 */
#define STAMP_BRP_TRN       32   /* brp: инициатор, принятый кадр BRP ответчика — две метки после цикла метрик TRN
                                  * (brp_program_and_measure): a0 = метрик | итог << 8 | r54 последний [15:0] << 16, a1 = такты
                                  * от входа в измерение; затем a0 = последнее слово метрики (r40 BF_METRIC), a1 = r49 (EE2);
                                  * и после измерения (brp_initiator_brp_transaction_flow): a0 = r49 на rx_frame_event,
                                  * a1 = такты от rx_frame_event */
#define STAMP_CTS_PATH      33   /* rx: ответ DMG CTS на RTS (rx_flow_handle_frame), Timer1 от входа: a0 = до отчёта PPDU |
                                  * до конца rx_end_switch_to_tx << 16, a1 = до запроса MTP | до записи (после 0x19000001) << 16 */
#define STAMP_TXOP_CTS      34   /* txop_await_cts_ppdu (открытие TXOP), удачный пуск — две метки после команды 0x18: a0 = r42 на
                                  * выходе из ожидания слота/busy2, a1 = PHY_SIGNALS [31:16] | такты ожидания [15:0]; затем
                                  * a0 = SIFS_CNT (r55 сел. 0), a1 = такты от выхода из ожидания. До пуска — только три чтения:
                                  * отрезок «слот → пуск» критичен (метка с защёлкой r55 перед пуском — станция не ассоциируется,
                                  * стенд 2026-10-30) */
#define STAMP_MTP_RESULT    35   /* tx_send_and_await_rx_frame (b ≠ 0, TXOP при пустой очереди: запрос MTP с б4, пуск 0x18008000),
                                  * после tx_end: a0 = r43 (ответ MTP), a1 = r45 [15:0] | r51 << 16; затем a0 = такты от пуска до
                                  * tx_end, a1 = qid | sta << 8 */
#define STAMP_RESP_WAIT     37   /* rx_flow_run, держатель TXOP принял ответ (ветка rx_flow_step), после неё: a0 = SIFS_CNT на
                                  * входе rx_flow_run (rx_flow_r55_snap — от конца своей передачи) | r36 [15:0] << 16,
                                  * a1 = txrx_state2 [15:0] | продолжение TXOP отправлено << 31; затем a0 = r37, a1 = r38;
                                  * a0 = r39, a1 = r53 (BAP) */
#define STAMP_TXOP_WAIT     38   /* tx_sta_wait_slot_and_tx: держатель TXOP ждёт ответ (sxd_hal_wait_slot2_busy2) — a0 = такты
                                  * ожидания | б31 «приём начался» (иначе тайм-аут слотов); a1 = txrx_state2 [15:0] | r36 << 16
                                  * (после rx_flow_run) */
#define STAMP_SNR_SEL       39   /* rx_flow_measure_snr_select_best, выход из цикла отсчётов: a0 = проходов | busy2 (r42 б14) << 16,
                                  * a1 = такты цикла от входа (стенд: HW_PHY_RX_STATUS_8837B0 всегда 0x2 — цикл на каждом кадре) */
#define STAMP_CCA_SLOT      40   /* tx_cca_check_and_send: ожидание slot_event перед пробой CCA — после функции: a0 = счётчик
                                  * PPDU (PHY_SIGNALS [13:8]) до | после << 8 | счётчик CCA после << 16 | cca_ppdu_comp << 24,
                                  * a1 = такты ожидания [15:0] | r36 << 16 */
#define STAMP_BUSY_LOST     41   /* rx_flow_main: busy_event (r42 б19) уже поднят перед его сбросом — 0x02080002 в начале итерации
                                  * (a0 = 1) или 0x02080000 в sxd_hal_wait_slot2_busy (a0 = 2); a1 = r42. Только при поднятом б19 (стенд: б19 обычно защёлкнут от уже обработанного кадра) */
#define STAMP_TXOP_OPEN     42   /* txop_initiator_open_txop_flow: выбор доступа (до пуска, до ожидания слота): a0 = qid |
                                  * режим (0 немедленно, 1 RTS, …) << 8 | бит qid_agg_mask << 12, a1 = r43 (packet_mode [7:4]) */
#define STAMP_BCN_SNR       43   /* bti (post:), каждый принятый маяк: a0 = метрика BF r40 [19:9] со знаком, a1 = HW_PHY_RX_SNR_883AEC
                                  * (сырое; [17:9] — SNR в четвертях дБ со знаком) — калибровка SNR Report (9.5.3) по метрике */
#define STAMP_RX_DUR        44   /* rx_flow_main, после rx_flow_handle_frame (ответ уже запрошен): a0 = Frame Control | Duration << 16
                                  * принятого кадра (rx_buf), a1 = TA [31:0] — поле Duration в эфире (эталон tests/ref/duration) */
#define STAMP_TXOP_REM      45   /* txop_initiator_open_txop_flow, рядом с STAMP_TXOP_OPEN (до ожидания слота): a0 = TSF[31:0],
                                  * a1 = REMAINING_TIME_RD (r15, мкс) | мкс до TBTT (0x886ec0) << 16 — сверка плана TXOP MAC с
                                  * NAV RTS в захвате PMC (802.11-2020 10.39.5; docs/MAC-STAND.md «Эфир: NAV RTS и TBTT») */
#define STAMP_HDR_EARLY     46   /* rx_flow_run, опыт E-R3 (только чтение), после rx_flow_handle_frame — шесть меток, такты от выхода
                                  * из ожидания sfd_sync (б31 — событие было): 1) конец кадра | замер SNR; 2) первый r42 б10 |
                                  * первый б12; 3) смена FC/Duration в rx_buf | PLCP 0x8830ec на б12; 4–5) смены r49 [19:16]
                                  * (состояние << 28 | такты); 6) r37 | r38 б25 << 31, PLCP 0x8830ec в конце */
#define STAMP_RESP_PATH     47   /* rx_flow_handle_frame, ответ быстрым путём (Ack/BA/DMG CTS), после STAMP_CTS_PATH: a0 = такты от
                                  * входа до выхода из rx_get_required_response | до конца ожидания BAP << 16, a1 = вид (r5) */
#define STAMP_SIFS_PTS      48   /* rx: SIFS_CNT (от конца приёма, мкс << 8 | такты) в точках пути ответа: a0 = точка (1 — вход в
                                  * rx_flow_handle_frame, 2 — после MAC_MTP_RESP_VALID) | вид << 8, a1 = SIFS_CNT */
#define STAMP_ISS_END       50   /* txss_resp_wait_iss_end: вход — a0 = r54, a1 = sls_rx.flags | 1 << 31; выход по концу ISS —
                                  * a0 = r54, a1 = sls_rx.flags | такты от входа << 16; уступка инициатора (BF_FLOW_INIT_PEER_ISS) —
                                  * a0 = 0xfeed0000 | r54, a1 = sls_rx.flags */
#define STAMP_CTS_FAST      49   /* rx_fast_cts, после пуска: a0 = такты от входа до конца перехода RX→TX | до запроса MTP << 16,
                                  * a1 = SIFS_CNT на входе (от конца RTS; чтение — +~10 тактов на пути) */
#define STAMP_TXOP_CONT     36   /* mtp_get_tx_permission (продолжение TXOP / пуск по разрешению): SIFS_CNT перед
                                  * 0x19000001 (защёлка сдвигает команду на ~8 тактов); после r45: a0 = SIFS_CNT | r36 [15:0] << 16,
                                  * a1 = r43 (ответ MTP: MCS [20:16]) */

#if defined(UC_PAD_SITE) && defined(UC_PAD_K) && UC_PAD_K > 0
/* nop строками, а не .rept: GCC оценивает длину вставки по числу строк шаблона, и с .rept
 * короткие переходы вокруг вставки выходили за допустимую дальность (ошибка ассемблера). */
#define UC_NOPS_1   "nop\n\t"
#define UC_NOPS_2   UC_NOPS_1 UC_NOPS_1
#define UC_NOPS_4   UC_NOPS_2 UC_NOPS_2
#define UC_NOPS_8   UC_NOPS_4 UC_NOPS_4
#define UC_NOPS_12  UC_NOPS_8 UC_NOPS_4
#define UC_NOPS_16  UC_NOPS_8 UC_NOPS_8
#define UC_NOPS_20  UC_NOPS_16 UC_NOPS_4
#define UC_NOPS_24  UC_NOPS_16 UC_NOPS_8
#define UC_NOPS_28  UC_NOPS_24 UC_NOPS_4
#define UC_NOPS_32  UC_NOPS_16 UC_NOPS_16
#define UC_NOPS_40  UC_NOPS_32 UC_NOPS_8
#define UC_NOPS_48  UC_NOPS_32 UC_NOPS_16
#define UC_NOPS_56  UC_NOPS_48 UC_NOPS_8
#define UC_NOPS_64  UC_NOPS_32 UC_NOPS_32
#define UC_NOPS_96  UC_NOPS_64 UC_NOPS_32
#define UC_NOPS_128 UC_NOPS_64 UC_NOPS_64
#define UC_NOPS_CAT(k)  UC_NOPS_##k
#define UC_NOPS_XCAT(k) UC_NOPS_CAT(k)
#define UC_PAD(site) do { \
        if ((site) == UC_PAD_SITE) \
            __asm__ volatile(UC_NOPS_XCAT(UC_PAD_K)); \
    } while (0)
#else
#define UC_PAD(site) do { } while (0)
#endif

/* UC_EVM(n): метка uc в записи событий PMC 0xff (PMC_CTL б28, захват mask=…,evucmd; docs/CAPTURE.md 4.3) — команда
 * MAC 0x80e50000 | n: б31 и код команды [30:24] = 0, как у меток vendor (0x80d0…, 0x80eeeeee), MAC её не исполняет
 * (с кодом 0x0e исполняет — образ с 0x8e5e…: «нет маяков», TX stalled, стенд 2026-11-15). Одна инструкция (mov r32),
 * метка до такта 165 МГц. Точки: 0x00 sfd_sync, 0x01 конец PPDU, 0x02 вход rx_flow_handle_frame, 0x03 отчёт о PPDU,
 * 0x04 rx_fast_resp, 0x08|вид запрос MTP, 0x06|вид MTP готов, 0x07|вид после 0x19000001; держатель TXOP: 0x10 вход
 * rx_flow_step, 0x11 отчёт, 0x12 после rx_match_expected_response, 0x13 запрос MTP rx_txop_continue, 0x14 MTP готов,
 * 0x15 перед 0x19000001 (mtp_get_tx_permission), 0x16 разрешение MTP; rx_flow_run: 0x18 кадр принят, 0x19 после
 * rx_mode_configure (txrx_state2 б2); rx_flow_step: 0x1a после rx_end_switch_to_tx, 0x1b перед
 * rx_match_expected_response. Только при -DUC_EVM_MARKS. */
#ifdef UC_EVM_MARKS
#define UC_EVM(n) uc_mac_cmd_nl(0x80e50000u | (u32)(n))
#else
#define UC_EVM(n) do { } while (0)
#endif

#if defined(UC_STAMP_MASK) && !defined(UC_DCCM_OBJECTS)   /* data.c: объекты DCCM без макросов, меток там нет */
#ifndef UC_STAMP_MASK2
#define UC_STAMP_MASK2 0
#endif
#define UC_STAMP_ON(id) ((id) < 32 ? ((UC_STAMP_MASK) >> ((id) & 31)) & 1u : ((UC_STAMP_MASK2) >> ((id) & 31)) & 1u)
#define UC_STAMP(id, a0, a1) do { \
        if (UC_STAMP_ON(id)) \
            uc_stamp((id), (u32)(a0), (u32)(a1)); \
    } while (0)
/* начало отрезка для метки id: COUNT1 в переменную v (в сборке без метки id — 0, без UC_STAMP_MASK — ничего) */
#define UC_STAMP_T0(id, v) UC_STAMP_V(id, v, arc_lr(0x100))
/* значение для метки id: v = expr (в сборке без метки id — 0, без UC_STAMP_MASK — ничего) */
#define UC_STAMP_V(id, v, expr) u32 v = UC_STAMP_ON(id) ? (u32)(expr) : 0
static inline __attribute__((always_inline)) void uc_stamp(u32 id, u32 a0, u32 a1)
{
    u32 t = arc_lr(0x100);                       /* COUNT1: такты */
    u32 idx = uc_log.wr_idx;
    uc_log.ring[(u8)(idx + 3)] = a1;
    uc_log.ring[(u8)(idx + 2)] = a0;
    uc_log.ring[(u8)(idx + 1)] = t;
    uc_log.ring[(u8)idx] = 0xa8000000u | 0xfff00u | id;
    uc_log.wr_idx = idx + 4;
}
#else
#define UC_STAMP(id, a0, a1) do { } while (0)
#define UC_STAMP_T0(id, v) do { } while (0)
#define UC_STAMP_V(id, v, expr) do { } while (0)
#endif

#endif
