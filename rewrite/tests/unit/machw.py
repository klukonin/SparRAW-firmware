# SPDX-License-Identifier: AGPL-3.0-or-later
"""Модель MAC во времени для юнит-тестов uc: железо, которое отвечает на команды uc не мгновенно, а в моменты, которые
задают часы, длительности кадров в эфире и межкадровые интервалы.

    hw = HW(uc)                         # подключить к эмулятору (до uc.call)
    hw.air_rx(t_us, frame, ...)         # кадр пира в эфире (сценарий приёма)
    uc.call('txss_resp_flow', sta)      # исполнение uc идёт во времени модели
    hw.air_log                          # [(начало, конец, 'tx'|'rx', описание)] в тактах 165 МГц
    hw.late                             # поздние команды (железо: MAC_HW_ICR б4/б5 → assert 0x26)

Часы: `now` — такты 165 МГц (H-T1). Каждый шаг CPU продвигает их по модели стоимости costmodel.py (та же, что у
тестов сроков; цены — микротесты стенда uc/bench.c).
Таймеры ARC 0/1 (COUNT/CONTROL/LIMIT; COUNT1 — Timer1), TSF, SIFS_CNT, GP-таймеры, события r42/r54 — производные
этих часов. Прерывания (irqs=True, по умолчанию): линии векторов поднимают таймеры (3 — тик L1, 7 — сторож L2), ящик
fw → uc (8, L1) и пробуждение (10, L2); ядро (tools/arcemu/cpu.py) доставляет их по правилам ARC600 — уровни, E1/E2,
вытеснение L1 со стороны L2 — с ценой входа H-IRQ. `sleep` uc переводит часы по событиям железа до готового
прерывания; irqs=False — прежняя модель (будит любое событие, прерываний нет). Опрос порта, который никакое будущее
событие не изменит, — SpinError (зависание).

Каждое допущение о железе — константа или ветка с меткой H-*: H-ORIGIN, H-ORIGIN-RX, H-CLK2, H-GP3, H-GP5, H-GP9, H-HDR, H-PHYRX, H-T1,
H-MTP, H-IRQ, H-TRN, H-TXOPGO, H-RESULTGO, H-SLOT2, H-SLOT (своя передача), H-DATAMCS (MCS 8 — STAMP_TXOP_CONT) — замеры стенда (uc/abft.h, метки
uc/dbg.h); H-TVEC, H-WAKE, H-FW2UC — по коду и документации; H-GP4, H-T23, H-E27, H-BUSY (режим 2 — по исходу стенда),
H-QSEL, H-QEMPTY, H-TXGO18F, H-TXAFTERACK, H-RETRY, H-AMPDU (форма — стенд), H-TXOPEVT-CFEND, H-HDR-SC — по смыслу кода и стандарту (непроверено, см. notes вне
репозитория); H-DURG — стенд (RX-запись станции); H-DURLIM0 (лимит TXOP 0 — Duration группового кадра 0) —
стенд (bdur1).
Неизвестная семантика (триггеры GP 07/08, неопознанные события движка 0x27) — ModelGap: модель не угадывает.

Замеры стенда, на которых стоят H-TRN, H-TXOPGO, H-RESULTGO, H-SLOT2, H-SLOT (своя передача), H-DATAMCS, сроки ответа и PHY_RX_STATUS, —
docs/MAC-STAND.md.

Регистры, которые читает сама модель (IFS, маски наборов очередей, ящик), — мимо журнала обращений CPU (_raw): чтение
через c.read внутри шага uc модель стоимости засчитывала инструкции uc как её обращение к шине.
"""
import heapq
import random

M32 = 0xffffffff
CLK_PER_US = 165                     # H-T1: Timer1 = 165 МГц
T1_LIMIT = 0x13ab6680

# ---- модель стоимости (шаг CPU → такты): tests/unit/costmodel.py (H-COST — микротесты стенда uc/bench.c) ----
from costmodel import Cost                                     # noqa: E402

# ---- константы железа ----
MACLAT_CLK = 91                      # H-ORIGIN: прямая передача — IFS(0x886d00) + 0,55 мкс после точки отсчёта
# H-ORIGIN-RX: прямая передача, отсчитанная от конца принятого PPDU (ответ SLS в DTI: RSS после ISS, SSW-Feedback после
# RSS, SSW-Ack после SSW-Feedback; продолжение TXOP после Ack), — IFS(0x886d00) + 0,05 мкс. Стенд, опыт E1 (2026-10-21,
# notes IFS-MEASURED, uc/bf.c txss_resp_flow): SSW-Ack через 9,05 мкс после конца SSW-Feedback при 0x886d00 = MBIFS —
# в той же калибровке (начало кадра = tx_end − 1,45 мкс), что и 0,55 мкс H-ORIGIN после события GP сетки A-BFT. 0,55 —
# задержка от события GP, к отсчёту от конца приёма она не относится (прежде модель давала ответы SLS через 9,55 мкс).
MACLAT_RX_CLK = 8
GP3_DELAY_CLK = 7                    # H-GP3: пуск по триггеру 03 — IFS(0x886d00) + 7 тактов после txop_event
HDR_CLK = 1495                       # H-HDR: rx_frame_event через 9,06 мкс от начала кадра
# H-PHYRX (стенд, метка STAMP_CCA_DET, 2026-10-30): поле cca PHY_SIGNALS ненулевое уже на входе L1 по busy_event;
# sfd_sync (r42 б11) — за 823–848 тактов до rx_frame_event (≈ 4,0 мкс от начала кадра); phy_rx_frame (б3) поднимается и
# cca_ppdu_comp (б24) снимается вместе с rx_frame_event — до разбора заголовка PHY_SIGNALS показывает «приёма нет».
SFD_BEFORE_HDR_CLK = 830
ACK_CLK = 3                          # подтверждение команды MAC (комментарий mac_evt_enable_bit_sync: ~3 такта)
# H-SIFSRESP: срок команды ответа 0x37000020 от конца принятого PPDU (кадр с sifs_resp). Калибровка стенда (тесты
# сроков, uc/rx.c:682): vendor-путь Ack проходит, +12..18 тактов дают assert 0x26. Наша команда Ack в модели — через
# 700 тактов от конца кадра (test_sifs_response_in_time, с ответом MTP H-MTP); vendor-путь в модели costmodel.py
# длиннее нашего на 42 такта (lat.py, пары одной ветки, test_uc_deadlines VENDOR_ACK_CLK) ⇒ срок 700 + 42 + 12 = 754.
RESP_CMD_DEADLINE_CLK = 754
# Ответ на кадр SC (данные; BlockAck/Ack): стенд 2026-10-30 (метка STAMP_RESP_SIFS_CNT + nop в пути ответа PAD_RESP_CMD,
# TCP): при 32 nop команды BlockAck — SIFS_CNT до 1074 (после 0x19 и защёлки, ~30 тактов после 0x37000020) без
# ошибок; 48 nop — ошибка уже на кадрах подключения (control PHY, срок выше). Нижняя граница срока для SC — 1074 − 30.
# Ноль SIFS_CNT — конец PPDU, ответ на железе выходит позже SIFS: захват PMC 2026-11-04 (H-RESPCMD, _hw_response,
# docs/MAC-STAND.md «Эфир: ответы через SIFS»)
RESP_CMD_DEADLINE_SC_CLK = 1044
# DMG CTS на RTS: путь длиннее (переход RX→TX ждёт конца PPDU), точка отказа на стенде не измерена; vendor-путь
# работает — нижняя граница срока. Наша команда — через 737 тактов от конца кадра; vendor-путь длиннее на 59 тактов
# (lat.py, прямой счёт, test_uc_deadlines VENDOR_PATH_CLK) ⇒ 796.
RESP_CMD_DEADLINE_CTS_CLK = 796
# H-TXEVT: tx_end_event (r42 б15) — не конец кадра, а ~1,4 мкс после его начала в эфире: стенд (IFS-MEASURED, пачка
# SSW) 0x19 → r42.15 = 218 тактов при периоде пуска TXTIME + SBIFS; A-BFT 0x19 → r42.15 = 1,32–1,50 мкс, Feedback A-BFT
# «tx_end − 1,45 = начало». uc готовит следующий кадр развёртки во время текущего, SBIFS держит MAC (замер 1,01 мкс).
TX_EVT_AFTER_START_CLK = 231
# H-TXEND: прочие события конца своей передачи («передатчик свободен», 0x27 маски, триггер GP 04) — раньше конца кадра.
# Калибровка по двум замерам стенда: повтор SSW-Feedback через 35,25–35,37 мкс после конца Feedback при GP1 = 5092
# и пути GP1 → эфир ~708 тактов (опыт fbr) — на взвод GP1 после tx_end остаётся 0–36 тактов при пути uc
# ~167 (опережение 131–167); зазор маяков в эфире ровно 1,000 мкс (E4) — модель развёртки маяков требует ≥ 143.
# Пересечение 143–167; 140 — обе проверки в пределах MODEL_TOL_CLK. Конец кадра в журнале эфира — истинный.
TX_END_LEAD_CLK = 140
# Точность модели во времени эфира: калибровки по стенду (H-TXEND, H-ORIGIN, путь uc ±5 %) сходятся с замерами в
# пределах ~20 тактов — проверки по эфиру допускают это отклонение (меньше — не нарушение, а погрешность модели).
MODEL_TOL_CLK = 20
# H-MTP: ответ MTP (r43.valid) и разрешение (r45.valid) после запроса 0x1b001111 — стенд (метка STAMP_MTP_LAT,
# 2026-10-29, ~85 запросов): ответ 38 тактов от команды (rx_txop_continue 38–41, tx_submit_frame 44 с вызовом),
# разрешение 57 (tx_submit_frame 63–71 с вызовом).
MTP_LAT_CLK = 38
MTP_PERM_LAT_CLK = 57
# H-TXSTART: инициирующая прямая передача — начало кадра через ~230 тактов после закрытия FIFO (0x33000002). Стенд
# (метки 2026-10-28): повтор Feedback 35,25–35,37 мкс = −75 (взвод GP1 после «свободен») + 5092 + 414 (GP1 → 0x19) +
# 164 (0x19 → FIFO) + x ⇒ x = 220–240; станция: FIFO → r42.15 от 430 = x + 218 (H-TXEVT). Прежнее 91 — по аналогии с
# H-ORIGIN, не замер.
TX_START_CLK = 230

# ---- прерывания ядра uc (ARC600: tools/arcemu/cpu.py — уровни, E1/E2, AUX_IRQ_LV12) ----
# H-TVEC: таймер ARC n — вектор 3 + 4n (uc_timer_start ставит уровень IRQ a·4 + 3): таймер 0 — 3 (L1, тик
# l1_task_entry(3), 1650 тактов), таймер 1 — 7 (L2, сторож l2_handle_watchdog, 2 с). COUNT растёт с часами, на LIMIT
# → 0 и IP; линия — IP·IE; запись CONTROL снимает IP (обработчики пишут CONTROL), NH/W не моделируются.
TIMER_VEC = (3, 7)
TIMER_AUX = ((0x21, 0x22, 0x23), (0x100, 0x101, 0x102))     # COUNT / CONTROL / LIMIT
# H-WAKE: пробуждение из sleep — L2 вектор 10 (l2_task_entry(1) квитирует командой 0x21000009): линия = взвод
# (команда 0x21000002 в uc_sleep_until_event) и r42 & маска 0x886d3c. Стенд (метка STAMP_L2_ENTRY, iperf 90 с): все
# 7473 входа L2 — задача 1, все в uc_sleep_until_event.
WAKE_VEC = 10
# H-TXVEC5 (стенд 2026-11-06, точка на bnc.fw, групповые данные: uc assert 0x26 «поздняя команда» 4 раза в
# test_ap_no_fw_error/test_ap_stop, FWERR 8 на 15 широковещательных ping): программа TX режима 5 (первый кадр после
# слота CBAP) должна прийти вскоре после проверки CCA (0x29000001). Граница на железе не снята; в модели рабочие пути
# (tx_cca_check_and_send, keep-alive, прежний tx_bcast_flow с CTS-to-self) выдают её через 42–52 такта, путь первого варианта (2026-11-06)
# (ключ + запрос MTP с ожиданием r43 до программы TX) — через 122. Срок — между: 100 тактов (0,61 мкс), запас 48 над
# рабочими путями.
TXVEC5_LATE_CLK = 100
FSCHED_PEER_ID = 0x800468              # uc DCCM: очередь широковещательного кольца точки (0xff — нет)
HW_UC_SLEEP_WAKE_MASK = 0x886d3c
# H-FW2UC: прерывание fw → uc — L1 вектор 8 (l1_task_entry(0)): блок RGF_ICR fw2uc с 0x886dcc (ICC, ICR W1C, ICM =
# ICR & ~IMV, ICS — установка, IMV — маска (1 = закрыто), IMS/IMC — установка/снятие маски; HARDWARE-BLOCKS
# «struct RGF_ICR», UC-REGISTERS §4); линия — ICM ≠ 0. Причины: б0 команда в кольце, б1 смена режима, б2 выход из сна.
# Маска после сброса — всё закрыто (uc открывает б0..2 записью IMV = 8 в uc_send_evt_ucode_ready).
FW2UC_VEC = 8
HW_FW2UC_BASE = 0x886dcc
# H-MACERR: ошибки MAC — L2 вектор 6 (l2_task_entry(0) → l2_task_report_error_bits: assert по txrx_state2 или 0x26):
# линия — ICM блоков MAC_HW_ICR (0x886e20) и SXD_ERRORS (0x886e3c); маски — irq_init_event_masks (IMV = ~0x98f3f и
# все закрыты). H-LATE: поздняя команда (ответ через SIFS, прямая передача — hw.late) взводит MAC_HW_ICR б4 (документ:
# «MAC_HW_ICR б4/б5 → assert 0x26»; какой из двух — не установлено).
MACERR_VEC = 6
HW_MAC_HW_ICR_BASE, HW_MAC_SXD_ERRORS_BASE = 0x886e20, 0x886e3c
MAC_HW_ICR_LATE = 1 << 4
HW_DMA_RINGS_WITH_DATA = 0x881c84     # DMA: битовая маска колец хоста с непрочитанными дескрипторами
# H-BI1: интервал маяков. После команды 0x0d (запуск BI, txrx_api_cmd_step) MAC поднимает bi1_event (r42 б4) перед
# каждым TBTT; TBTT — сетка TSF с шагом [0x886d64]·1024 мкс (по умолчанию bi_us), один из узлов — tbtt_us. Упреждение —
# по перезарядке: (период − [0x886d18]) мкс минус [0x886d1c] тактов = 8 мкс − 85 тактов = 1235 тактов. Стенд (метка
# STAMP_BI1_LEAD, 350 TBTT): на входе L1 с bi1_event до TBTT 7 мкс (270 раз), 4–6 при задержанном входе; шаг TBTT
# 102400 ± 1 мкс, TBTT кратен 102400.
HW_MAC_BI_PERIOD_TU, HW_MAC_BI_RELOAD_US, HW_MAC_BI_RELOAD_CLK = 0x886d64, 0x886d18, 0x886d1c
BI1_LEAD_DEFAULT_CLK = 8 * CLK_PER_US - 85
# Вектор 14 (L2, l2_task_entry(2)) — второй канал событий r42 с маской 0x886fbc (bi_mode_init_event_timers пишет 0;
# стенд при загрузке — 0): не срабатывает. Ненулевая маска — ModelGap (взвод канала не известен).
HW_EVT_CH2_MASK = 0x886fbc
# H-EVT1: EVENT1 (r42) → L1 вектор 9 (l1_task_entry(1): l1_task_on_evt1 крутится while r42 & 0xc0010): линия —
# r42 & (bi1_event б4 | backoff_event б18 | busy_event б19). Регистр маски не найден; стенд (метка STAMP_L1_EVT,
# 2026-10-29): на всех 1486 входах режима 1 взведён один из этих битов, а б2/3/7/8/20–23 взведены всегда.
EVT1_VEC, EVT1_IRQ_MASK = 9, 0xc0010
# H-EVT4: EVENT4 (r54) → L1 вектор 12 (l1_task_entry(2): l1__on_event4 разбирает б4/15/17): линия — r54 & регистр
# 0x886d44 (bi_mode_init_event_timers пишет 0x28010 = б4|15|17; стенд — то же значение; на всех 239 входах режима 2
# r54 б15 взведён, б1 — всегда, и маской закрыт).
EVT4_VEC, HW_EVT4_IRQ_MASK = 12, 0x886d44
# H-IRQ: от подъёма линии (готовности прерывания) до первой инструкции слота вектора. Стенд (метка STAMP_IRQ_LAT,
# 2026-10-29, 2154 тика, загрузка и iperf): COUNT0 на входе тика L1 — 49 (674 раза, ядро спало), минимум 46 (ядро
# работало), хвост 50…1644 — ожидание участков с запрещёнными прерываниями и других обработчиков; модель того же
# пути без цены входа — 41 ⇒ вход 5, из sleep ещё 3. Период тика — LIMIT + 1 = 1651 (пары соседних меток: P − d =
# 1609, кратные — 2P − d = 3260 и т. д. ⇒ P = 1651, d = 42; модель d = 41).
IRQ_ENTRY_CLK = 5
IRQ_WAKE_CLK = 3

# 802.11-2020 Table 20-30 (DMG): интервалы — по регистрам MAC 0x886d00/0x886d0c, ниже значения по умолчанию
SIFS_CLK, SBIFS_CLK, SLOT_CLK = 495, 165, 825
# H-SLOT2 (стенд 2026-10-30, метка STAMP_TXOP_WAIT, iperf через наш AP: 318 тайм-аутов ожидания ответа держателем TXOP,
# sxd_hal_wait_slot2_busy2 с двумя slot2 — 3606–3624 такта): slot2_event — через ~1806 тактов после взвода 0x02000100
# (≈ 2 × 888 — поля HW_MAC_SLOT_TIMING 0x3780378 — + 30), не через aSlotTime. Ответ на кадр TXOP на стенде приходит
# через 516–1050 тактов от начала ожидания
SLOT2_CLK = 1806
# H-BACKOFF (арбитр очередей MAC, DTI): backoff_event (r42 б18) — через AIFS + случайные 0…CW слотов свободной среды
# после NAV, пока есть включённая непустая очередь. Стенд 2026-10-29 (метки 28/29, STA): события — с ~1,35 мс от начала
# BI (конец BTI vendor-AP) и дальше; от события до чтения выбора uc 1,5 мкс. AIFS/CW не сняты — EDCA AC_BE по 802.11-2020
# (AIFSN 3, CWmin 15; aSIFSTime 3 мкс, aSlotTime 5 мкс).
AIFS_CLK, BACKOFF_CW = SIFS_CLK + 3 * SLOT_CLK, 15
ORIGIN_TRIGS = (0x03, 0x05, 0x07, 0x09)          # H-ORIGIN: триггеры GP сетки A-BFT (подтверждено стендом)
HW_MAC_TX_QID_ENABLE_MASK = 0x886f5c
# r41 селектор 0 (QUEUE_SEL_STATUS), раскладка со стенда (метка 28): qid [20:16], набор [11:8], бит набора [7:0]
QSET_INTERNAL, QSET_MGMT = 8, 5
# H-QSEL: набор в QUEUE_SEL_STATUS — номер маски QSETn_MASK_VECTOR + 1 (стенд: 0x1a в маске 4 → набор 5, 0x1f в маске
# 7 → 8); кольца хоста uc включает в маске 6 (ucode_cmd_0x08_handler, тип 3) → набор 7. Из нескольких наборов с
# кадрами — меньший (lowest_queue_set_found), внутри набора — меньший qid (не снято)
HW_QSET0_MASK_VECTOR = 0x886d8c
HW_MAC_TXOP_LIMIT_0 = 0x886f70    # [31:16] лимит TXOP, мкс (uc txop_apply_limits_regs, LMAC 0x21)
QSET_DATA_MASK = 6
HW_MAC_IFS_SIFS = 0x886d00           # [15:0] IFS ответа (SIFS или MBIFS): мкс << 8 | такты (живьём 0x01730300 = 3 мкс)
HW_MAC_IFS_RIFS_SBIFS = 0x886d0c     # [31:24] SBIFS, мкс
HW_MAC_TSF_LO, HW_MAC_TSF_HI = 0x886eb8, 0x886ebc
HW_MAC_USEC_TO_TBTT = 0x886ec0
HW_MAC_BI_START_TSF_LO = 0x886fc4
HW_RGF_USER_USER_SCRATCH_PAD = 0x8802bc


def ctrl_txtime_clk(psdu_len):
    """TXTIME control PHY (802.11-2020 20.4.3.3), такты 165 МГц вверх — как DMG_CTRL_TXTIME_CLK (uc/ifs.h)."""
    ncw = 1 + ((psdu_len - 6) * 8 + 167) // 168
    tc = 6400 + 1152 + (88 + (psdu_len - 6) * 8 + ncw * 168) * 32       # Tc = 1/1760 мкс
    return (tc * 3 + 31) // 32                                          # 165/1760 = 3/32


# DMG SC (802.11-2020 Table 20-15): MCS → (N_CBPS, повтор ρ, код R = num/den)
SC_MCS = {1: (1, 2, 1, 2), 2: (1, 1, 1, 2), 3: (1, 1, 5, 8), 4: (1, 1, 3, 4), 5: (1, 1, 13, 16), 6: (2, 1, 1, 2),
          7: (2, 1, 5, 8), 8: (2, 1, 3, 4), 9: (2, 1, 13, 16), 10: (4, 1, 1, 2), 11: (4, 1, 5, 8), 12: (4, 1, 3, 4)}
SC_HDR_TC = 2176 + 1152 + 1024                   # STF 17·128 + CE 9·128 + заголовок 2·512 Tc (Table 20-4)
# H-DATAMCS: MCS кадров данных из очередей колец хоста — параметр узла (data_mcs); на стенде не снят (дескриптор
# драйвера MCS не задаёт, mcs_en = 0 — MCS из таблицы MAC). H-HDR-SC: rx_frame_event кадра SC — после заголовка PHY
# (STF + CE + заголовок, 2,47 мкс; у control PHY по стенду 9,06 мкс), по стандарту, не снято.
DATA_MCS = 8
RESULT_GO_TX_END_CLK = 85                        # H-RESULTGO
# H-AMPDU (стенд 2026-10-30, iperf, метки STAMP_RESP_WAIT/STAMP_TXOP_WAIT/STAMP_RESP_REP — docs/MAC-STAND.md): очередь
# с соглашением BA (окно — из дескриптора очереди fw, H-QDESC) — ответ MTP с AGG_EN (r43 б27; на стенде 0x8c080010),
# кадры очереди уходят одним A-MPDU (не больше окна; на стенде 1…32 MPDU на BlockAck), у отправителя r53 — число MPDU
# [14:8].
# H-RD (reverse direction, 802.11-2020 10.29; стенд 2026-10-30/11-04 — docs/MAC-STAND.md): ответ MTP очереди с
# соглашением BA — RD_SUPP (r43 б26; на стенде 0x8c080010), A-MPDU данных держателя TXOP несёт RDG — у приёмника r38
# б15 (стенд 0xe2809800) — RDG ставит MAC по б11 команды пуска 0x18 (uc: б11 = RD_SUPP r43, vendor; с 2026-11-04
# наш uc RDG не даёт — б11 = 0). Ответчик RD, которому uc запросил в MTP данные очереди вместе с ответом (0x16: qid ≠ 0x1f,
# б1 — ответ BA/Ack, rx_txop_continue из rx_flow_handle_frame), шлёт через SIFS один PPDU: BlockAck + A-MPDU данных
# (у держателя r36 0x203, без б15 — стенд, PMC: ответ RD r38 0xe2801800); держатель подтверждает данные BlockAck
# (ответ через SIFS, как на A-MPDU). RDG в кадрах-ответах не ставится; включается полем узла rd_supp (по умолчанию
# выкл.: прежние сценарии — без RD).
# H-RESPMCS: MCS ответа через SIFS без явного MCS в 0x17 ([1:0] ≠ 3) — на кадр SC MCS 1 (стенд: BlockAck на A-MPDU
# MCS 8 — r38 received_mcs 1, наш uc до 2026-10-30 и vendor-AP), на кадр control PHY — control; явный — из 0x17 [12:8].
RESP_MCS_DEFAULT_SC = 1
BA_LEN = 32                                      # Compressed BlockAck (9.3.1.8): 28 Б + FCS


def ampdu_psdu_len(frames):
    """Длина PSDU A-MPDU (802.11-2020 10.12): разделитель 4 Б + MPDU (с FCS), дополнение до 4 Б у всех, кроме последнего."""
    n = 0
    for i, f in enumerate(frames):
        n += 4 + len(f) + 4
        if i != len(frames) - 1:
            n = (n + 3) & ~3
    return n



def sc_txtime_clk(psdu_len, mcs):
    """TXTIME DMG SC (802.11-2020 20.11.3, 20.5.3.2.3.3): N_CW = ⌈8·Length / (L_CW/ρ · R)⌉, L_CW 672;
    N_BLKS = ⌈N_CW · L_CW / N_CBPB⌉, N_CBPB = 448·N_CBPS; T_Data = (N_BLKS · 512 + 64) Tc; такты вверх."""
    ncbps, rho, num, den = SC_MCS[mcs]
    ncw = -(-(psdu_len * 8 * rho * den) // (672 * num))
    nblks = -(-(ncw * 672) // (448 * ncbps))
    return -(-(SC_HDR_TC + nblks * 512 + 64) * 3 // 32)


def resp_mcs(mcs):
    """MCS Ack/BlockAck на кадр SC (802.11-2020 10.6.7.2): обязательный MCS SC (1–4), не быстрее кадра-запроса,
    с кратчайшей передачей."""
    return min(mcs, 4)


# H-TRN (стенд 2026-10-30, метка STAMP_BRP_TRN, инициатор BRP, 21 кадр ответчика): поле TRN-R за данными кадра BRP
# (control PHY) — длина N из команды 0x20 [8:4] (б10 — TRN-R), 0x20000000 — снять. Структура по 802.11-2020 20.9.2.2:
# AGC 4N подполей × 320 Tc, затем N блоков × (CE 1152 Tc + 4 подполя TRN по 640 Tc). Стенд: r49 б13 (BRP-стадия) на
# rx_frame_event ещё снят, к входу в измерение (конец данных, отчёт PPDU — через 2026 тактов от rx_frame_event) уже
# поднят; ровно 32 метрики (r54 б1, слово r40 BF_METRIC: номер [30:24] подряд, метрика [23:14]) за 7528 тактов от
# входа — при N = 16 это весь TRN (по стандарту 45,4 мкс = 7488 тактов): метрика на каждую пару подполей; в конце
# r49 б5 (BRP_DONE) поднят, б13 снят. Распределение 32 метрик при другом N не снято — равномерно по подполям.
TRN_AGC_TC, TRN_CE_TC, TRN_SUB_TC, TRN_METRICS = 320, 1152, 640, 32
TRN_METRIC = 0x66                                # метрика [23:14] (стенд: 0x46…0x6f)


def trn_tc(n):
    return n * (4 * TRN_AGC_TC + TRN_CE_TC + 4 * TRN_SUB_TC)


def trn_clk(n):
    return -(-trn_tc(n) * 3 // 32)


def trn_metric_clk(n, k):
    """Такт метрики k (0..31) от конца данных кадра: конец подполя TRN (k + 1) · 4N / 32 − 1."""
    sf = (k + 1) * 4 * n // TRN_METRICS - 1
    return -(-(4 * n * TRN_AGC_TC + (sf // 4 + 1) * TRN_CE_TC + (sf + 1) * TRN_SUB_TC) * 3 // 32)


# H-E27: смысл busy2 (r42 б14) после 0x27<маска> + 0x02004000 — по месту ожидания в uc (поле [14:8] маски; номера
# событий движка 2 и полярность у железа не установлены: «ждать событие 6» записано и 0x4000, и 0x3f00 — вход и выход).
#   'mtp'     — кадр пошёл / ответ MTP готов (mac_evt_enable_bit_sync_b(6) после запроса MTP или пуска кадра);
#   'tx_done' — передача завершена (uc_wait_one_event(6) после tx_end: CTS-to-self, ATIM, BRP);
#   'tx_free' — передатчик свободен (mac_evt_enable_bit_sync(5): GP1 Feedback, uc_wait_two_events(5,5,…) A-BFT);
#   'rx_end'  — конец принятого PPDU (rx_flow_run ХРУПКО, brp.c);
#   'rx_busy' — начало приёма / среда занята (sxd_hal_wait_slot2_busy2, развёртка маяка, rx_flow_run случай 1).
#   'mode_ack' — MAC подтвердил смену режима (uc_wait_two_events(5,5,…): mac_wait_mode_ack_if_idle, сетка A-BFT в bti —
#                вступает вместе с пуском сетки через IFS + 7 тактов после txop_event, H-GP3).
E27 = {0x40: 'mtp', 0x3f: 'tx_done', 0x20: 'tx_free', 0x5f: 'mode_ack', 0x73: 'rx_end',
       0x0c: 'rx_busy', 0x7e: 'rx_busy', 0x0e: 'rx_busy', 0x7d: 'rx_busy'}


def ifs_code(clk):
    """Такты → код регистра IFS 0x886d00 / SIFS_CNT (мкс << 8 | такты 0..164)."""
    return (clk // CLK_PER_US) << 8 | (clk % CLK_PER_US)


class ModelGap(RuntimeError):
    """uc опирается на поведение железа, которого модель не знает (не угадывать — изучить/замерить)."""


class _Ev:
    __slots__ = ('t', 'n', 'fn', 'tag', 'dead')

    def __init__(self, t, n, fn, tag):
        self.t, self.n, self.fn, self.tag, self.dead = t, n, fn, tag, False

    def __lt__(self, o):
        return (self.t, self.n) < (o.t, o.n)


class RgfIcr:
    """Блок прерываний RGF_ICR (HARDWARE-BLOCKS «struct RGF_ICR»): ICC +0, ICR +4 (W1C), ICM +8 = ICR & ~IMV,
    ICS +0xc (установка причин), IMV +0x10 (маска, 1 = закрыто), IMS +0x14 / IMC +0x18 (установка / снятие маски).
    Линия — ICM ≠ 0; при изменении вызывается on_change()."""

    def __init__(self, base, on_change, imv=M32):
        self.base, self.icr, self.imv, self.on_change = base, 0, imv, on_change

    def icm(self):
        return self.icr & ~self.imv & M32

    def set(self, icr=None, imv=None):
        if icr is not None:
            self.icr = icr & M32
        if imv is not None:
            self.imv = imv & M32
        self.on_change()

    def attach(self, c):
        b = self.base
        c.io_hooks[b + 4] = (lambda cpu, a: self.icr, lambda cpu, a, v: self.set(icr=self.icr & ~v))
        c.io_hooks[b + 8] = (lambda cpu, a: self.icm(), None)
        c.io_hooks[b + 0xc] = (None, lambda cpu, a, v: self.set(icr=self.icr | v))
        c.io_hooks[b + 0x10] = (lambda cpu, a: self.imv, lambda cpu, a, v: self.set(imv=v))
        c.io_hooks[b + 0x14] = (lambda cpu, a: self.imv, lambda cpu, a, v: self.set(imv=self.imv | v))
        c.io_hooks[b + 0x18] = (lambda cpu, a: self.imv, lambda cpu, a, v: self.set(imv=self.imv & ~v))


class ArcTimer:
    """Таймер ARC600 (COUNT/CONTROL/LIMIT) в часах модели: COUNT = (now − t0) mod (LIMIT + 1)."""

    def __init__(self, hw, n, limit=0xffffffff):
        self.hw, self.vec = hw, TIMER_VEC[n]
        self.t0, self.limit, self.ctrl, self.ip, self.ev = 0, limit, 0, False, None

    def count(self):
        return (self.hw.now - self.t0) % (self.limit + 1)

    def _line(self):
        if self.ip and self.ctrl & 1:
            self.hw.c.irq_lines.add(self.vec)
        else:
            self.hw.c.irq_lines.discard(self.vec)

    def _arm(self):
        self.hw.cancel(self.ev)
        p = self.limit + 1
        self.ev = self.hw.at(self.t0 + ((self.hw.now - self.t0) // p + 1) * p, self._fire, 'timer%d' % (self.vec // 4))

    def _fire(self):
        self.ip = True
        self._line()
        self._arm()

    def write(self, reg, v):
        if reg == 0:                                     # COUNT
            self.t0 = self.hw.now - (v & M32)
        elif reg == 1:                                   # CONTROL: IE б0, NH б1, W б2; запись снимает IP
            self.ctrl, self.ip = v & 7, False
            self._line()
        else:                                            # LIMIT
            self.limit = v & M32
        self._arm()

    def read(self, reg):
        return self.count() if reg == 0 else (self.ctrl | (self.ip << 3)) if reg == 1 else self.limit


class GPTimer:
    __slots__ = ('val', 'mode', 'trig', 'start', 'end', 'ev', 'arms', 'fired', 'next')

    def __init__(self):
        self.val, self.mode, self.trig = 0, 0, 0
        self.fired = False
        self.next = None                  # (режим, триггер) со следующего периода (H-GPRUN)
        self.start = self.end = None
        self.ev = None
        self.arms = []                    # (момент пуска, длительность)


class HW:
    def __init__(self, uc, tsf0_us=1_000_000, tbtt_us=None, bi_us=102_400, ifs=SIFS_CLK, sbifs_us=1, mailbox=True,
                 irqs=True):
        self.costm = Cost()               # модель стоимости; costm.parts — счётчики статей (разбор путей против стенда)
        self.cnt = self.costm.parts
        self.profile = False              # True — снимки cnt в marks: (имя, такт, Counter) на командах MAC и событиях
        self.marks = []
        self.uc = uc
        c = self.c = uc.cpu
        self.now = 0
        self.bound = None                 # эфир нескольких узлов: часы этого узла не дальше bound (None — без границы)
        self.on_tx = None                 # эфир: on_tx(dict(start, dur, what, ssw, dur_us)) при постановке передачи
        self._q = []
        self._n = 0
        # прерывания: irqs=False — прежняя модель (sleep будит любое событие железа, прерываний нет)
        self.irqs = irqs
        self.irq_log = []                 # (такт, вектор) доставленных прерываний
        self.wake_armed = False           # H-WAKE: взвод пробуждения (0x21000002 … 0x21000009)
        self.timers = [ArcTimer(self, 0), ArcTimer(self, 1, T1_LIMIT)]
        self.f2u = RgfIcr(HW_FW2UC_BASE, lambda: self._icr_line(FW2UC_VEC, self.f2u))      # H-FW2UC
        self.mac_hw_icr = RgfIcr(HW_MAC_HW_ICR_BASE, self._macerr_line)                    # H-MACERR
        self.sxd_errors = RgfIcr(HW_MAC_SXD_ERRORS_BASE, self._macerr_line)
        self.timers[1].t0 = -uc.t1_base
        # события
        self.r42 = 0
        self.r54 = 0
        self.r49 = 0
        self.data_mcs = DATA_MCS
        self.trn_tx = 0                   # H-TRN: длина TRN следующей прямой передачи (команда 0x20)
        self.busy2_armed = False
        # GP
        # 0..2 — GP0..GP2 (0x4f/0x52), 3..9 — группа 0x67/0x68, 10..12 — ext GP 0..2 той же группы (H-GP68)
        self.gp = [GPTimer() for _ in range(13)]
        self.gp_sel = 0
        self.gp_wait = None               # тайм-аут gp_timers_event (0x23010000|t)
        # точка отсчёта IFS: конец приёма/передачи или событие GP (H-ORIGIN); SIFS_CNT считает от неё
        self.ifs_ref = 0
        self.ifs_ref_kind = 'boot'
        self.txop_event_at = None
        # селекторы
        self.sel40 = 0
        self.sel47 = 0
        # MTP
        self.mtp_req_at = None
        self.perm_req_at = None
        # эфир
        self.tx = None                    # текущая передача: dict(start, end, what)
        self.tx_pending = None            # кадр закрыт, ждёт старта
        self.rx = None
        self.air_log = []
        self.late = []
        self.sweep_late = []
        self.cmd_log = []                 # (такт, команда)
        self.dtx_len = 0
        self.ppdu_cnt = 0
        self.cca_cnt = 0
        self.rx_queue = []                # сценарий приёма
        # TSF
        self.tsf0_us = tsf0_us
        self.bi_us = bi_us
        self.tbtt_us = tbtt_us if tbtt_us is not None else tsf0_us + bi_us
        self.sel41 = 0
        self.mac_q_model = False          # H-MACQ: r41 селектор 0x3 — из mac_q_pending (иначе — как задал тест)
        self.mac_q_pending = 0            # очереди MAC с кадрами: б30 — маяк (fw: tx_api_2 → очередь MAC 0x1e)
        self.collisions = None            # эфир: список столкновений (None — столкновение = ModelGap, один узел)
        self.late_rx = []                 # поздние прямые передачи от конца приёма (H-LATE-RX, без ошибки MAC)
        self.mac_q = {}                   # H-MACQ2: очередь MAC → [кадр (MPDU от fw)]; кадры управления/данных fw
        self.q_done = []                  # (qid, статус) — завершённые кадры очередей (DMA → fw: tx_complete)
        self.q_retry = {}                 # H-RETRY: очередь → повторов головного кадра
        self.q_agg = {}                   # H-AMPDU: очередь → окно BA (из дескриптора очереди fw)
        self.q_last_hdr = {}              # H-QNULL: очередь → заголовок последнего выданного кадра (24 Б)
        self.bap_tx = None                # H-AMPDU: MPDU в последнем принятом BlockAck
        self.retry_log = []               # (такт, очередь, номер повтора)
        self.mtp_qid = None               # очередь MTP (0x16 qid << 16 | 1)
        self.ack_wait = None              # переданный кадр очереди ждёт Ack
        self.bap_rel = False              # H-BAPREL: освобождение очереди 0x46 выполнено (r53 б2)
        self.q_hold = None                # H-BAPREL: очередь, чей переданный групповой кадр ждёт освобождения 0x46
        self.cca_cmd_at = None            # H-TXVEC5: такт проверки CCA (0x29000001), программа TX ещё не выдана
        self.bi_ev = None                 # H-BI1: следующее bi1_event (интервал маяков запущен командой 0x0d)
        self.tbtt_log = []                # (такт bi1_event, TBTT в мкс TSF)
        c.write(HW_MAC_IFS_SIFS, (0x0173 << 16 | ifs_code(ifs)).to_bytes(4, 'little'))
        c.write(HW_MAC_IFS_RIFS_SBIFS, ((sbifs_us << 24) | (1 << 8)).to_bytes(4, 'little'))
        # исходное состояние регистров, которые uc опрашивает (иначе — детерминированный мусор эмулятора):
        c.write(0x8890cc, (0).to_bytes(4, 'little'))      # HW_RFC_CORE_CTRL: б29 — RF-контроллер занят → свободен
        # HW_PHY_RX_STATUS_8837B0: стенд 2026-10-30 (метка STAMP_SNR_SEL, iperf, 5656 чтений у двух узлов) — всегда 0x2
        # (rx_flow_run запускает выбор сектора по SNR на каждом кадре); мусор эмулятора включал его у одного узла
        c.write(0x8837b0, (2).to_bytes(4, 'little'))
        # HW_TX_ENGINE_STATE (0x88656c) [3:0] — состояние TX-движка MAC; uc перед освобождением очереди (0x1c/0x46,
        # tx_bcast_flow, sxd …) требует 0 (иначе assert 3). Состояния движка модель не ведёт — простой,
        # 0 (мусор эмулятора давал assert 3 в tx_bcast_flow, test_uc_bcast_data)
        c.write(0x88656c, (0).to_bytes(4, 'little'))
        # маски линий событий — поля модели (после сброса 0); чтение и запись uc — через крючки ввода-вывода
        self.evt_mask = {HW_UC_SLEEP_WAKE_MASK: 0, HW_EVT4_IRQ_MASK: 0, HW_EVT_CH2_MASK: 0}
        for a in self.evt_mask:
            c.io_hooks[a] = ((lambda a: lambda cpu, x: self.evt_mask[a])(a),
                             (lambda a: lambda cpu, x, v: self.evt_mask.__setitem__(a, v & M32))(a))
        # H-DMA: DMA колец хоста не моделируется — колец с данными нет (DMA_RINGS_WITH_DATA = 0; сценарий с трафиком
        # задаёт его сам). Мусор эмулятора здесь — «кольца» несуществующих станций (aw_collect_awake_peers: assert 0x141f)
        c.write(HW_DMA_RINGS_WITH_DATA, bytes(4))
        self._attach()
        if mailbox:
            self._mailbox_init()

    # кольца ящика fw ↔ uc, как после загрузки: fw кладёт пару mbox_ring_ctl (события, команды) и указатель на неё в
    # RGF_USER_USER_SCRATCH_PAD + 0x24; uc_mailbox_init_rings строит по ним свои uc_ring. Пустые описатели (sync 0) —
    # команд fw нет (иначе ucode_cmdq_handler разбирал бы мусор DCCM).
    MBOX_CTL = 0x85f000               # пара mbox_ring_ctl (вне DCCM uc)
    MBOX_DESC = 0x85f100              # описатели: события 16 × 8 Б, команды 16 × 8 Б
    MBOX_BUF = 0x85f200               # буферы записей кольца событий: 16 × 0x74 Б (заголовок 0x10 + тело ≤ 0x64, как fw/lmac.c)
    MBOX_CMD_BUF = 0x85d800           # буферы команд fw → uc (lmac_cmd): 16 × 0x100 Б (fw/lmac.c: tx_hw.entry_size 0x100)
    CMD_ENTRY = 0x100

    def _mailbox_init(self):
        c, a = self.c, self.MBOX_CTL
        w = lambda addr, v, n=4: c.write(addr, (v & M32).to_bytes(n, 'little'))
        for i in range(0x100):
            w(self.MBOX_DESC + 4 * i, 0)
        for i in range(16):                               # события: у каждой записи свой буфер (fw выделяет при загрузке)
            w(self.MBOX_DESC + 8 * i + 4, self.MBOX_BUF + 0x74 * i)
        for k in range(2):
            base = self.MBOX_DESC + k * 0x80
            w(a + 16 * k, base)
            w(a + 16 * k + 4, 0x64 if k == 0 else self.CMD_ENTRY, 2)   # entry_size: события 0x64, команды 0x100 (fw/lmac.c)
            w(a + 16 * k + 6, 0x80, 2)
            w(a + 16 * k + 8, base)
            w(a + 16 * k + 12, base)
        w(HW_RGF_USER_USER_SCRATCH_PAD + 0x24, a)
        self.uc.call('uc_mailbox_init_rings', 0x802470)
        self._cmd_wr = self._cmd_seq = self._evt_rd = 0
        # обратный вызов подстройки усиления после смены RF-цепи (rf_gain_cb) — ставит обработчик LMAC 0x00 при
        # настройке MAC; без него rx_mode_configure вызывает указатель 0
        self.uc.call('mac_install_rf_gain_cb')
        self.uc._spin = {}

    # ================================================================ часы и очередь
    def at(self, t, fn, tag=''):
        self._n += 1
        e = _Ev(t, self._n, fn, tag)
        heapq.heappush(self._q, e)
        return e

    def after(self, dt, fn, tag=''):
        return self.at(self.now + dt, fn, tag)

    @staticmethod
    def cancel(e):
        if e is not None:
            e.dead = True

    def _run_due(self):
        while self._q and (self._q[0].dead or self._q[0].t <= self.now):
            e = heapq.heappop(self._q)
            if not e.dead:
                self.uc._spin = {}                        # железо что-то сделало — опрос не вечный
                e.fn()

    def pending(self):
        return any(not e.dead for e in self._q)

    def _sleep_wait(self):
        """Сон: часы идут по событиям железа, пока прерывание не станет доставляемым; не дальше bound (эфир
        нескольких узлов: узел не уходит вперёд других, чтобы не пропустить их кадр)."""
        c = self.c
        while c.irq_ready() is None:
            nxt = self._next_t()
            if self.bound is not None and (nxt is None or nxt > self.bound):
                self.now = max(self.now, self.bound)
                return
            if not self.advance_to_next():
                raise ModelGap('sleep без прерывания в будущем в %s (линии %s, STATUS32 %#x)' % (
                    self.uc.where(getattr(self, '_sleep_pc', c.pc)), sorted(c.irq_lines), c.read_aux(0x0a)))
            self._evt_lines()

    def _next_t(self):
        while self._q and self._q[0].dead:
            heapq.heappop(self._q)
        return self._q[0].t if self._q else None

    def advance_to_next(self):
        """Перевести часы к ближайшему событию (sleep uc / опрос без изменений). False — событий нет."""
        while self._q and self._q[0].dead:
            heapq.heappop(self._q)
        if not self._q:
            return False
        self.now = max(self.now, self._q[0].t)
        self._run_due()
        return True

    def us(self, clk=None):
        return (self.now if clk is None else clk) / CLK_PER_US

    def tsf_us(self):
        return self.tsf0_us + self.now // CLK_PER_US

    # ================================================================ подключение к CPU
    def _attach(self):
        c, uc = self.c, self.uc
        uc.hw = self
        orig_step = c.step
        hw = self

        def step():
            if c.sleeping and hw.irqs and c.irq_ready() is None:
                hw._sleep_wait()                          # часы — по событиям до прерывания или до границы bound
                if c.irq_ready() is None:
                    return
            if hw.irqs and (c.irq_lines or c.irq_pending) and c.aux.get(0x0a, 0) & 6:   # E1/E2 закрыты — не доставить
                was_asleep = c.sleeping
                n = c.deliver_irq()
                if n is not None:
                    hw.now += IRQ_ENTRY_CLK + (IRQ_WAKE_CLK if was_asleep else 0)
                    hw.irq_log.append((hw.now, n))
                    hw._run_due()
            if c.halted:
                return
            pc0 = c.pc & M32
            k = len(c.trace)
            i0 = c.insns
            lp_start, lp_end = c.aux.get(0x02, 0), c.aux.get(0x03, 0)
            ins = c.fetch(pc0)
            orig_step()
            if (c.pc & 0x1ffff) < 0x100 and (pc0 & 0x1ffff) >= 0x100:
                # переход в область векторов (сброс) из кода — вызов незаданного указателя на функцию (0)
                raise RuntimeError('переход на вектор %#x из %s — незаданный указатель функции?' % (c.pc, uc.where(pc0)))
            n = c.insns - i0
            new = c.trace[k:]
            cost = hw.costm.step(c, pc0, ins, n, new, (lp_start, lp_end), hw.now)
            sleeping = any(e[0] == 'sleep' for e in new)
            hw.now += cost
            hw._run_due()
            if hw.irqs:
                hw._evt_lines()
            if sleeping and not hw.irqs:
                # прежняя модель: sleep будит любое событие железа
                c.halted = c.sleeping = False
                if not hw.advance_to_next():
                    raise ModelGap('sleep без будущих событий железа в %s' % uc.where(pc0))
            elif sleeping:
                hw._sleep_pc = pc0
                hw._sleep_wait()                          # sleep: ждать прерывания (будит его доставка)

        c.step = step
        uc.ext_hook = self._read_port
        uc.fifo_hook = self._fifo_write
        uc.cmd_hook = self._cmd
        c.irq_auto = not self.irqs
        if self.irqs:
            uc.t1_hook = self.timers[1].count
        else:
            uc.t1_hook = lambda: (uc.t1_base + self.now) % (T1_LIMIT + 1)
        if self.irqs:
            for blk in (self.f2u, self.mac_hw_icr, self.sxd_errors):
                blk.attach(c)
            for t, regs in zip(self.timers, TIMER_AUX):
                for k, a in enumerate(regs):
                    c.aux_hooks[a] = ((lambda t, k: lambda cpu: t.read(k))(t, k),
                                      (lambda t, k: lambda cpu, v: t.write(k, v))(t, k))
        for a, fn in ((HW_MAC_TSF_LO, lambda cpu, a: self.tsf_us() & M32),
                      (HW_MAC_TSF_HI, lambda cpu, a: self.tsf_us() >> 32),
                      (HW_MAC_USEC_TO_TBTT, lambda cpu, a: max(0, self.tbtt_us - self.tsf_us()) & 0x3ffffff),
                      (HW_MAC_BI_START_TSF_LO, lambda cpu, a: (self.tbtt_us - self.bi_us) & M32)):
            c.io_hooks[a] = (fn, None)
        c.io_hooks[HW_MAC_TX_QID_ENABLE_MASK] = (lambda cpu, a: self.qid_en,
                                                 lambda cpu, a, v: (setattr(self, 'qid_en', v & M32), self._backoff_kick()))
        # uc → fw: причина прерывания fw (RGF_USER_USER_ICR.ICS, б9 — событие в ящике) — флаг для CoSim.pump
        c.io_hooks[0x880b58] = (None, lambda cpu, a, v: setattr(self, 'uc2fw', self.uc2fw | v))

    uc2fw = 0
    rd_supp = False                   # H-RD: RD_SUPP у очередей с соглашением BA, RDG в A-MPDU
    rdg_force = False                 # сценарий: RDG в A-MPDU при любом б11 0x18 — пир, дающий RD (vendor и др.)
    mtp_resp_data = False             # H-RD: последний запрос MTP — данные очереди вместе с ответом через SIFS
    late_rx = ()
    rx_mode = None
    bap_rx = False

    # ---- арбитр очередей (H-BACKOFF) ----
    qid_en = 0
    nav_end = 0
    medium_busy_end = 0                # конец последнего кадра в эфире (свой или чужой, включая TRN) — для AIFS
    backoff_ev = None
    backoff_seed = 1                  # seed генератора отсрочки (свой у каждого узла — воспроизводимо и независимо)
    backoff_log = None

    def _qsel(self):
        """Выбор арбитра: (qid, набор) или None. Внутренняя очередь (б31 маски) — 0x1f, набор 8; очередь управления
        fw 0x1a (кадр в очереди, H-MACQ) — набор 5."""
        if self.qid_en & (1 << 31):
            return 0x1f, QSET_INTERNAL
        if self.mac_q_model and self.mac_q_pending & (1 << 0x1a):
            return 0x1a, QSET_MGMT
        if self.mac_q_model:
            m = self.mac_q_pending & self._raw(HW_QSET0_MASK_VECTOR + 4 * QSET_DATA_MASK) & 0x00ffffff
            if m:
                return (m & -m).bit_length() - 1, QSET_DATA_MASK + 1
        return None

    def _backoff_kick(self):
        if self.backoff_ev is not None or self._qsel() is None or self.r42 & (1 << 18):
            return
        if not hasattr(self, 'backoff_rng'):
            self.backoff_rng = random.Random(self.backoff_seed)
        t = max(self.now, self.nav_end, self.medium_busy_end) + AIFS_CLK + self.backoff_rng.randint(0, BACKOFF_CW) * SLOT_CLK
        self.backoff_ev = self.at(t, self._backoff_fire, 'backoff')

    def _backoff_fire(self):
        self.backoff_ev = None
        if self._qsel() is None:
            return
        # Среда занята — отсрочка заново. Отсчёт backoff идёт только после AIFS свободной среды (802.11-2020 10.23.2.4):
        # промежуток короче AIFS (SBIFS 1 мкс между своими SSW TXSS, кадрами развёртки маяков) отсрочку не завершает.
        # Прежде событие ставилось на момент без проверки — backoff кончался внутри своей TXSS (test_live_data).
        if self.rx is not None or self.tx is not None or self.now < self.nav_end or \
                self.now < self.medium_busy_end + AIFS_CLK:
            self._backoff_kick()
            return
        if self.backoff_log is not None:
            self.backoff_log.append((self.now, self._qsel()))
        self._set42(18)

    def ifs_clk(self):
        v = self._raw(HW_MAC_IFS_SIFS, 2)
        return (v >> 8) * CLK_PER_US + (v & 0xff)

    def sbifs_clk(self):
        return self._raw(HW_MAC_IFS_RIFS_SBIFS + 3, 1) * CLK_PER_US

    # ================================================================ порты r36..r56
    # ---- FIFO прямой передачи (H-FIFO) ----
    fifo = None                       # байты кадра между 0x33000001 и 0x33000002 (None — FIFO не открыт)
    fifo_rmw = False
    fifo_frame = None                 # последний закрытый кадр FIFO

    def _fifo_write(self, n, v):
        """H-FIFO: r33 — слово (4 байта LE), r34 — байт (с б24 — полуслово, tx.c RA, mac.c Sequence Control); запись r33 сразу после чтения r33 («or r33,r33,x»,
        uc_fifo_frame_tail) дописывает биты в последнее слово (как tx_frames в test_uc_sls_sweep)."""
        if self.fifo is None:
            return
        if n == 33:
            if self.fifo_rmw and len(self.fifo) >= 4:
                w = int.from_bytes(self.fifo[-4:], 'little') | v
                self.fifo[-4:] = w.to_bytes(4, 'little')
            else:
                self.fifo += v.to_bytes(4, 'little')
        elif v & (1 << 24):
            self.fifo += (v & 0xffff).to_bytes(2, 'little')   # r34 с б24 — полуслово (RA RTS, Sequence Control BRP)
        else:
            self.fifo.append(v & 0xff)
        self.fifo_rmw = False

    def _read_port(self, n):
        """Значение порта или None — тогда uc.ext (тест задал сам)."""
        if n == 33:
            self.fifo_rmw = True
            return None
        if n == 42:
            return self.r42
        if n == 54:
            return self.r54
        if n == 55:
            return self.r55
        if n == 40:
            return self._r40()
        if n == 43:                                       # ответ MTP: valid б31, MCS кадра очереди [20:16] (H-DATAMCS)
            if not self._mtp_valid():
                return 0
            q = self._q_avail(self.mtp_qid) if self.mtp_qid is not None and self.mtp_qid < 0x18 else None
            agg = (1 << 27) if self.q_agg.get(self.mtp_qid) else 0                       # H-AMPDU: AGG_EN
            # H-PKTMODE (стенд 2026-10-30, метка STAMP_TXOP_OPEN, iperf и ping 84 Б): у очередей колец данных packet_mode
            # [7:4] = 1 — TXOP через RTS при любой длине и с BA и без (≈1850 пусков на сторону), у очереди 0x1a — 0;
            # qid_agg_mask на стенде всегда 0. Источник — поле [7:4] дескриптора сектора очереди (fw txq_pkt_mode = 1 для
            # режимов 5/6; у 0x1a дескриптор сектора не пишется — 0), стенд 2026-10-31 — docs/MAC-STAND.md
            pkt = (1 << 4) if self.mtp_qid is not None and self.mtp_qid < 0x18 else 0
            rd = (1 << 26) if agg and self.rd_supp else 0                                   # H-RD: RD_SUPP
            return (1 << 31) | ((self.data_mcs << 16) if q else 0) | agg | pkt | rd
        if n == 45:
            if not (self.perm_req_at is not None and self.now >= self.perm_req_at + MTP_PERM_LAT_CLK):
                return 0
            # H-QEMPTY: null_status б1 — очередь MTP пуста (vendor-лог «MTP Queue is empty»): для очередей колец модели
            # (fw/хост → mac_q), запрошенных 0x16
            q = self.mtp_qid
            empty = self.mac_q_model and q is not None and q < 0x1e and not self._q_avail(q)
            return (1 << 31) | (2 if empty else 0)
        if n == 47:
            return self._r47()
        if n == 49 and self.mac_q_model:
            return self.r49                               # EVENT_ENGINE2_STATUS: б13 BRP-стадия, б5 BRP_DONE (H-TRN)
        if n == 53 and self.mac_q_model:
            # H-BAP-RX (стенд, метка STAMP_BAP_RX у AP: 31 из 31 — 0x12e): после приёма кадра «для нас» BAP отмечает
            # приём (MAC_BAP_RX_UPDATE); до конца такого кадра — 0
            rel = 4 if self.bap_rel else 0                 # H-BAPREL: bap_rel_done_ind
            if self.bap_tx is not None:                    # H-AMPDU: BlockAck принят — TX_UPDATE б0, число MPDU [14:8]
                return 0x2f | (self.bap_tx & 0x7f) << 8 | rel
            return (0x12e if self.bap_rx else 0) | rel
        if n == 41 and self.sel41 == 0 and self.irqs and self.mac_q_model:
            q = self._qsel()
            return 0 if q is None else (q[0] << 16) | (q[1] << 8) | (1 << (q[1] - 1))
        if n == 41 and self.sel41 == 1 and self.mac_q_model:
            # H-QSET4 (по имени полей QUEUE_SEL_FOUND_SET1_4_R41, не снято): очередь с кадрами в маске 3 (QSET4 —
            # очереди станции, которую rx_flow_main пишет в HW_QSET3_MASK_VECTOR): б31 valid, qid [28:24] — меньший.
            # Нужен ответчику RD (rx_flow_main → rx_qset4_hit → ответ с данными, H-RD)
            m = self.mac_q_pending & self._raw(HW_QSET0_MASK_VECTOR + 4 * 3) & 0x00ffffff
            return 0 if not m else (1 << 31) | ((m & -m).bit_length() - 1) << 24
        if n == 41 and self.sel41 == 3 and self.mac_q_model:
            return self.mac_q_pending                     # H-MACQ: QSET_1_MASK_VECTOR — очереди с кадрами (б30 — маяк)
        if n == 41 and self.sel41 == 0xb and self.mac_q_model:
            # H-QAVAIL (по имени поля MTP_Q_AVAIL_R41 mtp_q_avail_vec, не снято): очереди колец, где у MTP есть ещё не
            # выданный кадр (указатель чтения MAC — _q_avail); 0xc BAP_Q_AVAIL — 0 (кадров, ждущих повтора BA, модель
            # не держит вне _q_avail)
            return sum(1 << q for q in self.mac_q if q < 0x1e and self._q_avail(q))
        if n == 41 and self.sel41 == 0xc and self.mac_q_model:
            return 0
        return None

    def _mtp_valid(self):
        return self.mtp_req_at is not None and self.now >= self.mtp_req_at + MTP_LAT_CLK

    def poll_may_change(self, n):
        """Может ли будущее событие железа изменить порт n (иначе опрос — зависание)."""
        return self.pending() or n in (43, 45)

    def _r40(self):
        f = (self.sel40 >> 12) & 0xf
        rx_on = self.rx is not None
        if f == 0xa:                                      # PHY_SIGNALS: счётчики PPDU (концы) [13:8], CCA (начала) [21:16]
            v = (self.ppdu_cnt & 0x3f) << 8 | (self.cca_cnt & 0x3f) << 16
            if rx_on:
                v |= 2                                    # cca = 2 (приём) — с начала кадра
            if rx_on and self.rx.get('hdr'):
                v |= 1 << 3                               # phy_rx_frame — с разбора заголовка (H-PHYRX)
            else:
                v |= 1 << 24                              # cca_ppdu_comp — до разбора заголовка ещё стоит (H-PHYRX)
            return v
        if f == 0x0:                                      # BACKOFF_IFS idle_detect: 5 — свободна, 2 — приём (H-IDLE)
            if rx_on:
                return 2
            return 6 if self.tx else 5
        if f == 0x5:
            return self.tsf_us() & M32
        if f == 0x6:
            return self.tsf_us() >> 32
        if f == 0xd:                                      # BF_METRIC: метрика последнего кадра (сценарий; по умолчанию 0x100)
            return self.bf_metric
        if f == 0xb:                                      # PHY_PLCP_RX: sifs_resp [15] — последний кадр требует ответа
            return (1 << 15) if self.last_rx_sifs_resp else 0
        if f == 0x3:                                      # REMAINING_TIME_RD — без сессии: максимум
            return 0xffff
        if f == 0x4:                                      # H-BICNT: BI_COUNTER — мкс от последнего TBTT [25:0], bi_sync б31
            if self.bi_ev is None:
                return 0
            p = self._bi_period_us()
            return ((self.tsf_us() - (self.tbtt_us - p)) % p & 0x3ffffff) | (1 << 31)   # tbtt_us — ближайший будущий
        raise ModelGap('r40: селектор %#x не моделируется' % self.sel40)

    def _r47(self):
        f = (self.sel47 >> 16) & 0xf
        if f == 0:                                        # DIRECT_TX_CMD_STATUS: cmd_ready
            return 1
        if f in (1, 3):                                   # COUNTER_EVENT / RFC_SWITCH_ERROR: интерфейс счётчиков и RF-контроллер
            return 0                                      # не заняты (RF-контроллер без очереди — команды мгновенны)
        if f == 8:                                        # MTP_AGGREGATION: valid [31], длительность кадра [15:0] мкс вверх
            return (1 << 31) | -(-ctrl_txtime_clk(self.sweep_len) // CLK_PER_US)
        if f == 2:                                        # LFSR
            return (self.now * 1103515245 + 12345) & 0xffff
        if f == 5:                                        # RFC_SWITCH2RX: analog_tx_off [3:0], analog_rx_on [7:4], rx_awv_cfg [15:12]
            return 0xf0ff if self.tx is None else 0       # RF переключён на приём сразу после передачи (без задержки)
        raise ModelGap('r47: селектор %#x не моделируется' % self.sel47)

    # ================================================================ команды r32
    def _cmd(self, v):
        v &= M32
        self.cmd_log.append((self.now, v))
        if self.profile:
            self.marks.append(('cmd %08x' % v, self.now, self.cnt.copy()))
        op, arg = v >> 24, v & 0xffffff
        if op == 0x18:                                    # H-DUR18: пуск кадра; б12 — Duration кадра буквально
            self.go18 = arg
            self._rdg_from_go18(arg)
        elif op == 0x33 and arg == 1:                     # новый кадр FIFO: пуска 0x18 для него ещё не было
            self.go18 = None
        if op == 0x02:                                    # взвод (сброс) битов r42
            self.r42 &= ~arg
            if arg & (1 << 8):                            # H-SLOT2: slot2_event — через SLOT2_CLK от взвода
                self.cancel(self.slot2_ev)
                self.slot2_ev = self.after(SLOT2_CLK, self._slot2, 'slot2')
            if arg & (1 << 1):                            # H-SLOT: slot_event (начало слота) — так же
                self.cancel(self.slot1_ev)
                self.slot1_ev = self.at(self._slot1_time(), self._slot1, 'slot1')
            if arg & (1 << 18):                           # backoff_event снят — следующая отсрочка, если есть что слать
                self._backoff_kick()
            if arg & (1 << 14):
                self.busy2_armed = True
                self._busy2_check()
        elif op == 0x17:                                  # MTP: скорость — [12:8] MCS при флагах [1:0] = 3, иначе MAC сам
            self.mtp_rate = (arg >> 8) & 0x1f if arg & 3 == 3 else None
        elif op == 0x16:                                  # MTP: очередь кадра (qid [20:16]; 0x1f — FIFO прямой передачи)
            self.mtp_qid = (arg >> 16) & 0x1f
            self.mtp_result = bool(arg & 0x10)            # H-RESULTGO: б4 — запрос итога (mac_program_tx_result_ctx_uc)
            self.mtp_resp_data = self.mtp_qid < 0x1e and bool(arg & 2)   # H-RD: данные очереди вместе с ответом
            # H-MTPRESP: запрос ответа через SIFS (mtp_service_dispatch: qid 0x1f, [1] и [5], вид [10:8] — Ack 0,
            # BlockAck 1, DMG CTS 5) — ответ собирает MAC, кадр в FIFO прямой передачи (0x161f0040 —
            # mac_program_tx_with_rate) им не пускается. Прежде модель пускала любой закрытый кадр FIFO: RTS, оставшийся
            # в FIFO после провала пробы CCA (txop_await_cts_ppdu → 0x29000002), уходил вместо DMG CTS на RTS пира.
            # Стенд: захваты PMC обоих узлов (back, bis_5ef_A_slot, t2; ~100 тыс. RTS) — ни одного RTS в ответ на RTS
            # пира в пределах 12 мкс, только DMG CTS. Что 0x29000002 делает с самим кадром FIFO — не установлено
            # (кадр остаётся в модели; следующая прямая передача uc открывает FIFO заново: 0x33000001).
            self.mtp_resp_req = self.mtp_qid == 0x1f and arg & 0x22 == 0x22
        elif op == 0x80 and (arg >> 16) == 0xd0:          # режим приёма (rx_mode_configure: 0x80d00000 | режим)
            self.rx_mode = arg & 0xff
        elif op == 0x27:                                  # H-E27: что поднимет busy2 (таблица E27)
            bits = (arg >> 8) & 0x7f
            if bits == 0:
                self.e27 = None                           # инициализация (0x2700000c): событий нет
            elif bits not in E27:
                raise ModelGap('0x27: маска %#04x не моделируется (%#x)' % (bits, v))
            else:
                self.e27 = E27[bits]
        elif v == 0x21000002:                             # H-WAKE: взвод пробуждения (uc_sleep_until_event)
            self.wake_armed = True
        elif v == 0x21000009:                             # H-WAKE: квитирование (l2_task_entry(1/2), инициализация)
            self.wake_armed = False
            self.c.irq_lines.discard(WAKE_VEC)
        elif op == 0x0d:                                  # H-BI1: запуск интервала маяков
            if self.bi_ev is None:
                self._bi_arm()
        elif op == 0x20:                                  # H-TRN: TRN-R в заголовке PHY следующей передачи
            self.trn_tx = (arg >> 4) & 0x1f if arg & 0x400 else 0
        elif op == 0x49:                                  # квитирование r54
            self.r54 &= ~arg
        elif 0x4f <= op <= 0x51:
            self.gp[op - 0x4f].val = arg
        elif 0x52 <= op <= 0x54:
            self._gp_cmd(op - 0x52, arg)
        elif op == 0x68:                                  # группа GP: [23:20] индекс; младший байт ≠ 0 — пуск, [12:8] триггер
            # H-GP68: индексы 0..2 — ext GP 0..2 (mac_evt_select_timer_group квитирует их r54 б15), не GP0..GP2
            idx = (arg >> 20) & 0xf
            if idx > 9:
                raise ModelGap('0x68: индекс таймера %d' % idx)
            self.gp_sel = idx + 10 if idx < 3 else idx
            if arg & 0xff:
                self._gp_cmd(self.gp_sel, (arg & 0xff) | (((arg >> 8) & 0x1f) << 8))
        elif op == 0x67:
            self.gp[self.gp_sel].val = arg
        elif op == 0x23 and (arg >> 16) == 1:            # H-T23: тайм-аут gp_timers_event через t мкс
            self.cancel(self.gp_wait)
            self.gp_wait = self.after((arg & 0xffff) * CLK_PER_US, lambda: self._set42(9), 'gp_wait')
        elif op == 0x1d:                                  # теневое слово селекторов: R41 [11:8], R40 [15:12], R47 [19:16]
            self.sel41 = (arg >> 8) & 0xf
            self.sel40 = arg & 0xf000
            self.sel47 = arg & 0xf0000
        elif op == 0x4d:
            self._latch_r55(arg & 0xff)
        elif op == 0x1b and arg == 0x001111:              # запрос MTP: ответ r43, затем разрешение r45 (UC-REGISTERS §2.9)
            self.go19 = False
            self.mtp_req_at = self.now
            self.perm_req_at = self.now
            self.after(MTP_LAT_CLK, lambda: self._eng('mtp'), 'mtp_resp')
        elif op == 0x19:                                  # запрос разрешения передачи — пуск кадра (H-TXGO)
            self.go19 = True
            if arg & 0xb00 == 0xb00:
                # H-TXOPGO (стенд 2026-10-30, метка STAMP_TXOP_CTS, 99 TXOP): 0x19000b00 открытия TXOP в эфир ничего не
                # выпускает — uc после неё ждёт слот (на стенде 81–303 такта, всегда slot_event при свободной среде,
                # SIFS_CNT после пуска 0) и пускает кадр очереди парой 0x19000001/0x18 (txop_await_cts_ppdu). RTS — только
                # в режиме доступа 1, кадром FIFO (direct_tx_send_after_delay)
                return
            self.perm_req_at = self.now
            self._go()
        elif v == 0x29000001:                             # проверка CCA после слота (mac_cmd_29000001) — отсчёт H-TXVEC5
            self.cca_cmd_at = self.now
        elif v == 0x29000002:                             # CCA не прошла — передачи по этому слоту нет
            self.cca_cmd_at = None
        elif op == 0x06 and arg & 0x100 and self.cca_cmd_at is not None:
            # H-TXVEC5: программа TX режима 5 (mac_program_tx_vector(5): команда режима a | б8 | б25 | б26) — первой после
            # проверки CCA, иначе поздняя команда (assert 0x26); программа любого режима закрывает окно
            dt, self.cca_cmd_at = self.now - self.cca_cmd_at, None
            if arg & 0xff == 5 and dt > TXVEC5_LATE_CLK:
                self._late((self.now, 'программа TX режима 5 через %d тактов после CCA (H-TXVEC5)' % dt,
                            dt - TXVEC5_LATE_CLK, 'tx'))
        elif op == 0x1c:                                  # H-BAPREL: начало освобождения очереди MTP/BAP (0x1c000006)
            self.bap_rel = False
        elif op == 0x46:
            # H-BAPREL (по имени поля bap_rel_done_ind, не снято): освобождение очереди 0x46… (после 0x1c000006) —
            # BAP отвечает r53 б2; uc ждёт его (tx_bcast_flow, mac_q_tx_ppdu …), без модели — вечное ожидание
            self.bap_rel = True
            if self.q_hold is not None and (arg >> 4) & 0x1f == self.q_hold:
                self.q_hold = None
                self._q_done((arg >> 4) & 0x1f, 0)
        elif op == 0x34:                                  # описатель прямой передачи: [15:0] длина в FIFO
            self.dtx_len = arg & 0xffff
        elif op == 0x33 and arg == 1:                     # FIFO прямой передачи открыт (direct_tx_program_desc)
            self.fifo, self.fifo_rmw = bytearray(), False
            if self.frame_ready is not None and 'fifo' in self.frame_ready:
                # H-FIFO1: FIFO прямой передачи держит один кадр — новый кадр (0x33000001) заменяет закрытый, но не
                # пущенный (RTS после провала пробы CCA, txop_await_cts_ppdu → 0x29000002). Стенд: захваты PMC обоих
                # узлов (back, bis_5ef_A_slot) — ни одного RTS в ответ на CF-End/RTS/данные пира в пределах 12 мкс
                # (ответный CF-End uc собирает в FIFO заново, tx_send_imm_response); модель пускала старый RTS.
                self.frame_ready = None
        elif op == 0x33 and arg == 2:                     # кадр загружен в FIFO прямой передачи
            if self.fifo is not None:
                self.fifo_frame, self.fifo = bytes(self.fifo), None
            what = 'direct %d B' % (self.dtx_len + 4)
            if self.ssw_field is not None:
                what = 'sweep CDOWN %d sector %d' % self.ssw_field
            self.ssw_field = None
            self.frame_ready = dict(what=what, dur=ctrl_txtime_clk(self.dtx_len + 4), fifo=self.fifo_frame,
                                    mpdu_len=self.dtx_len)
            self._tx_try()
        elif op == 0x18 and arg & 0x8000 and self.mtp_result:
            # H-RESULTGO / H-QNULL. Пуск 0x18008000 после запроса MTP с б4 (mac_program_tx_result_ctx_uc — tx_submit_frame
            # в tx_send_and_await_rx_frame, закрытие TXOP держателем перед CF-End). Стенд 2026-11-06 (PMC точки, вход
            # станции; asb_11 — open, asm5_11 — без продолжения TXOP после кадра очереди 0x1a): между Ack на последний
            # кадр очереди и CF-End держателя MAC выпускает QoS Null (FC 0x00c8, 30 Б с FCS, MCS данных; A1..A3 — как
            # у последнего кадра очереди, Sequence Number — следующий: Probe Response SN 0 → 1, Association Response 1 →
            # 2, Action 4 → 5; QoS Control 0x0020 — TID 0, Ack Policy No Ack; Duration — остаток TXOP); без продолжения
            # TXOP — на 5 мкс позже (путь tx_cca_check_and_send), то есть по этому пуску. uc после пуска ждёт busy2
            # (без него assert 0x92) и tx_end. Прежний вывод «в эфир ничего не выпускает» (метка STAMP_MTP_RESULT,
            # tx_end через 80–89 тактов от t_go) — события busy2/tx_end, оставшиеся от приёма Ack и своего кадра: метка
            # ставится после пуска, ожидания проходят сразу. Очередь с невыданными кадрами — не снята: прежнее поведение.
            q = self._q_avail(self.mtp_qid) if self.mtp_qid is not None and self.mtp_qid < 0x1e else None
            h = self.q_last_hdr.get(self.mtp_qid)
            # своя передача ещё идёт (A-MPDU данных, ответ ждёт BlockAck) — порядок PPDU не снят: прежнее поведение
            if self.mac_q_model and q is not None and not q and h is not None and self.tx is None and \
                    self.tx_pending is None:
                sn = ((int.from_bytes(h[22:24], 'little') >> 4) + 1) & 0xfff
                f = (0x00c8).to_bytes(2, 'little') + bytes(2) + h[4:22] + (sn << 4).to_bytes(2, 'little') + \
                    (0x0020).to_bytes(2, 'little')
                self.q_last_hdr[self.mtp_qid] = f[:24]
                self.frame_ready = dict(what='queue %#x QoS Null (MAC, запрос итога) MCS %d' % (self.mtp_qid,
                                                                                                self.data_mcs),
                                        dur=sc_txtime_clk(len(f) + 4, self.data_mcs), qframe=f, qid=None,
                                        mcs=self.data_mcs)
                self.go = True
                self._tx_try()
            else:
                self.at(self.now + RESULT_GO_TX_END_CLK, lambda: self._set42(15), 'result_go')
        elif op == 0x18 and self.mtp_qid == 0x1f and not self.go19:
            # H-TXGO18F: кадр FIFO без 0x19 после запроса MTP (CF-End держателя TXOP, cf_end_send_frame: 0x1b/0x161f…/
            # 0x17 → 0x18000000 → FIFO → 0x33000002) — пуск разрешает 0x18; по коду uc (порядок команд стенда — тот же код)
            self.go = True
            self._tx_try()
        elif op == 0x18:                                  # пуск — уже по 0x19 (H-TXGO); 0x18 — выпуск очереди MTP
            pass
        elif v == 0x37000020 and self.resp_due is not None and self.resp_cmd_at is None:
            self.resp_cmd_at = self.now                   # команда ответа (H-SIFSRESP)
            dl = self.resp_due['end'] + self.resp_due['deadline']
            if self.now > dl:
                self._late((self.now, 'ответ через SIFS на %s' % self.resp_due['what'], self.now - dl, 'rx'))
            else:
                # H-SIFSRESP: момент ответа держит MAC — команда в срок, ответ (Ack/BA, собирает MAC) стартует в точке
                # IFS сам, не дожидаясь 0x19 (стенд, метка STAMP_RESP_SIFS_CNT под TCP: 0x19 после 0x37000020 —
                # SIFS_CNT 723–966, обмен без сбоев)
                r = self.resp_due

                def auto(r=r):
                    fifo_free = (self.frame_ready is None and not self.fifo) or self.mtp_resp_req   # H-MTPRESP
                    if self.resp_due is r and fifo_free and self.tx is None and self.tx_pending is None:
                        self._hw_response()
                self.at(max(self.now, r['end'] + self.ifs_clk() + MACLAT_CLK), auto, 'resp_auto')
        elif op == 0x15:                                  # Duration следующего кадра, мкс (H-DUR)
            self.dur_us = arg & 0xffff
            self.dur_new = True                           # H-TXOP: кадр после записи 0x15 начинает TXOP заново
            self.durq_new = True                          # H-DURG: конец TXOP для следующего группового кадра
        elif op == 0x14 and arg in (5, 7):                # режим Duration маяка: б1 — 0x15 − d буквально, иначе ⌊остаток TXOP⌋
            self.dur_literal = bool(arg & 2)
        elif op == 0x2a:                                  # BI Control: [19:0] → B0..B19, [23:20] → B44..B47
            self.bic_a = arg
        elif op == 0x2b:                                  # BI Control: [23:0] → B20..B43
            self.bic_b = arg
        elif op == 0x2d:                                  # поле SSW: CDOWN [9:1], сектор [15:10]
            self.ssw_field = ((arg >> 1) & 0x1ff, (arg >> 10) & 0x3f)
            self.ssw_raw = arg                            # поле SSW целиком (3 октета, 9.5.1) — для эфира

    slot2_ev = None
    slot1_ev = None
    slot_grid = None                  # H-SLOTGRID: None — slot_event через aSlotTime от команды; иначе — такт начала сетки
                                      # слотов (конец последней занятости среды), событие — первая граница сетки
                                      # не раньше команды + aSlotTime.
    # Стенд 2026-10-29 (метки 26/27, AP, 681 BI): от входа в ожидание slot_event в bti (за 1 мкс до TBTT) до проверки
    # канала после второго ожидания (mac_select_all_sectors_and_wait) — окна равномерные шириной 5 мкс: 5–10 (~20 %),
    # 15–19 (~8 %), 19,5–25 (~66 %), 26–29 (~3 %); фаза к TSF случайна; CCA == PPDU (ложных CCA нет). Модель: по
    # умолчанию — одно значение ~12,7 мкс; с сеткой — одно окно 12,3–17,1. Ни то, ни другое разброс не объясняет:
    # MAC добавляет 0…4 слота по неизвестному правилу (похоже на собственную отсрочку). Не моделируется.

    def _slot1_time(self):
        t = self.now + SLOT_CLK
        if self.slot_grid is None:
            return t
        k = -(-(t - self.slot_grid) // SLOT_CLK)
        return self.slot_grid + max(k, 0) * SLOT_CLK

    def _slot_defer(self):
        """H-SLOT: такт переноса slot_event, None — событие пропадает. Слоты отсчитываются по свободной среде: на
        приёме чужого кадра событие переносится на его конец + aSlotTime (раньше пропадало, и brp_init_tx_request,
        ждущий slot_event без тайм-аута, висел — живой эфир, seed 2/3/6). Во время своей передачи и ожидания Ack —
        приходит в срок: стенд 2026-10-30 (метка STAMP_CCA_SLOT, iperf, 1972 ожидания в tx_cca_check_and_send) — slot
        после своего кадра TXOP приходит через 35–534 такта, ни одного принятого PPDU за ожидание; следующий кадр MAC
        выпускает только после ответа (H-TXAFTERACK)."""
        return max(self.rx['end'], self.now) + SLOT_CLK

    def _slot1(self):
        self.slot1_ev = None
        if self.rx is None:
            self._set42(1)
            return
        t = self._slot_defer()
        if t is not None:
            self.slot1_ev = self.at(t, self._slot1, 'slot1')

    def _slot2(self):
        self.slot2_ev = None
        if self.rx is None:
            self._set42(8)
            return
        t = self._slot_defer()
        if t is not None:
            self.slot2_ev = self.at(t, self._slot2, 'slot2')

    def _go(self):
        """H-TXGO: запрос разрешения 0x19 — пуск кадра, когда он готов (закрыт FIFO или задано поле шаблона маяка);
        ответ через SIFS без кадра в FIFO собирает MAC. Стенд: зазор маяков ровно SBIFS при пути tx_end → 0x19 ~276
        тактов (0x18 приходит позже и срок не задаёт)."""
        self.go = True
        if self.resp_due is not None and (self.frame_ready is None or self.mtp_resp_req):
            self._hw_response()                       # ответ через SIFS собирает MAC (Ack/BA/CTS) — без FIFO (H-MTPRESP)
            return
        if self.mtp_resp_req:
            self.go = False                           # H-MTPRESP: 0x19 ответа (уже начатого по 0x37000020) — не кадр FIFO
            return
        q = self._q_avail(self.mtp_qid) if self.mtp_qid not in (None, 0x1e, 0x1f) else None
        if self.frame_ready is None and self.ssw_field is None and q:
            # H-MACQ2: кадр из очереди MAC (кольцо fw → DMA → очередь) — целиком, как собрал fw; скорость — control
            # PHY (MCS дескриптора не моделируется)
            f = q[0]
            win = self.q_agg.get(self.mtp_qid, 0)
            if win and (f[0] >> 2) & 3 == 2:              # H-AMPDU
                fs = list(q[:win])
                self.frame_ready = dict(what='queue %#x A-MPDU %d MPDU %d B MCS %d' % (
                    self.mtp_qid, len(fs), ampdu_psdu_len(fs), self.data_mcs),
                    dur=sc_txtime_clk(ampdu_psdu_len(fs), self.data_mcs), qframe=fs, qid=self.mtp_qid,
                    mcs=self.data_mcs)                             # RDG — по пуску 0x18 б11 (H-RD, _cmd)
                self.q_last_hdr[self.mtp_qid] = bytes(fs[-1][:24])
                self._tx_try()
                return
            if (f[0] >> 2) & 3 == 2:                      # данные — SC (H-DATAMCS)
                what, dur = 'queue %#x %d B MCS %d' % (self.mtp_qid, len(f), self.data_mcs), \
                    sc_txtime_clk(len(f) + 4, self.data_mcs)
            else:
                what, dur = 'queue %#x %d B' % (self.mtp_qid, len(f)), ctrl_txtime_clk(len(f) + 4)
            self.frame_ready = dict(what=what, dur=dur, qframe=f, qid=self.mtp_qid,
                                    mcs=self.data_mcs if (f[0] >> 2) & 3 == 2 else 0)
            self.q_last_hdr[self.mtp_qid] = bytes(f[:24])
            self._tx_try()
            return
        if self.frame_ready is None and self.ssw_field is not None:
            # кадр из шаблона без FIFO (маяк: поле SSW 0x2d, длина — sweep_len)
            self.frame_ready = dict(what='sweep CDOWN %d sector %d' % self.ssw_field,
                                    dur=ctrl_txtime_clk(self.sweep_len))
            self.ssw_field = None
        self._tx_try()

    def _bi_period_us(self):
        tu = self._mmio32(HW_MAC_BI_PERIOD_TU) & 0xffff
        return tu * 1024 if tu else self.bi_us

    def _bi_lead_clk(self):
        period = self._bi_period_us()
        reload_us = self._mmio32(HW_MAC_BI_RELOAD_US)
        if not 0 < period - reload_us < 1000:                # перезарядка ещё не записана (0x0d идёт раньше неё)
            return BI1_LEAD_DEFAULT_CLK
        return (period - reload_us) * CLK_PER_US - (self._mmio32(HW_MAC_BI_RELOAD_CLK) & 0xff)

    def _bi_arm(self):
        """Следующее bi1_event: ближайший TBTT сетки (tbtt_us — ближайший будущий), до которого больше упреждения."""
        p, lead = self._bi_period_us(), self._bi_lead_clk()
        tbtt = self.tbtt_us
        while (tbtt - self.tsf0_us) * CLK_PER_US - lead <= self.now:
            tbtt += p
        self.tbtt_us = tbtt
        self.bi_ev = self.at((tbtt - self.tsf0_us) * CLK_PER_US - lead, self._bi1, 'bi1_event')

    def _bi1(self):
        """bi1_event; в момент TBTT ближайшим TBTT становится следующий (0x886ec0, BI_COUNTER)."""
        tbtt = self.tbtt_us
        self.tbtt_log.append((self.now, tbtt))
        self._set42(4)

        def at_tbtt():
            self.tbtt_us = tbtt + self._bi_period_us()
            self._bi_arm()
        self.bi_ev = self.at((tbtt - self.tsf0_us) * CLK_PER_US, at_tbtt, 'tbtt')

    def _set42(self, bit):
        self.r42 |= 1 << bit

    def _icr_line(self, vec, *blocks):
        (self.c.irq_lines.add if any(b.icm() for b in blocks) else self.c.irq_lines.discard)(vec)

    def _macerr_line(self):
        if hasattr(self, 'sxd_errors'):
            self._icr_line(MACERR_VEC, self.mac_hw_icr, self.sxd_errors)

    def fw2uc(self, bits):
        """Сторона fw: причина прерывания uc (ICS) — б0 команда в кольце, б1 смена режима, б2 выход из сна."""
        self.f2u.set(icr=self.f2u.icr | bits)

    # ---- ящик fw ↔ uc: сторона fw (fw/tx_helpers.c wmi_evt_build_and_post, lmac_if_post_cmd; include/mbox.h) ----
    def _w(self, a, v, n=4):
        self.c.write(a, (v & M32).to_bytes(n, 'little'))

    def lmac_cmd(self, type_, body=b'', mid=0):
        """Команда LMAC fw → uc: запись кольца команд (sync = 1, буфер: struct mbox_hdr + тело), head кольца,
        причина fw2uc б0 (как lmac_if_post_cmd: ICS = 1)."""
        if len(body) > self.CMD_ENTRY - 0x10:
            raise ValueError('тело команды > %#x Б' % (self.CMD_ENTRY - 0x10))
        i = self._cmd_wr
        e = self.MBOX_DESC + 0x80 + 8 * i
        if self._mmio32(e):
            raise ModelGap('кольцо команд uc полно (запись %d не прочитана)' % i)
        buf = self.MBOX_CMD_BUF + self.CMD_ENTRY * i
        hdr = (self._cmd_seq.to_bytes(2, 'little') + len(body).to_bytes(2, 'little') + type_.to_bytes(2, 'little')
               + bytes([0, len(body) & 0xff, mid, 0]) + bytes(2) + bytes(4))
        for k, x in enumerate(hdr + bytes(body)):
            self.c.write(buf + k, bytes([x]))
        self._w(e + 4, buf)
        self._w(e, 1)
        self._cmd_wr = (i + 1) % 16
        self._cmd_seq = (self._cmd_seq + 1) & 0xffff
        self._w(self.MBOX_CTL + 16 + 12, self.MBOX_DESC + 0x80 + 8 * self._cmd_wr)     # head
        self.fw2uc(1)

    def uc_events(self):
        """События uc → fw, записанные с прошлого вызова: [(тип, тело)]; записи освобождаются (sync = 0, tail)."""
        out = []
        while True:
            e = self.MBOX_DESC + 8 * self._evt_rd
            if not self._mmio32(e):
                return out
            buf = self._mmio32(e + 4)
            ln = self._mmio32(buf) >> 16
            out.append((self._mmio32(buf + 4) & 0xffff, self._raw_bytes(buf + 0x10, ln)))
            self._w(e, 0)
            self._evt_rd = (self._evt_rd + 1) % 16
            self._w(self.MBOX_CTL + 8, self.MBOX_DESC + 8 * self._evt_rd)                 # tail

    def _late(self, rec):
        """Поздняя команда: запись в hw.late и причина MAC_HW_ICR (H-LATE) — у железа она приводит к assert 0x26."""
        self.late.append(rec)
        if self.irqs:
            self.mac_hw_icr.set(icr=self.mac_hw_icr.icr | MAC_HW_ICR_LATE)

    def _evt_lines(self):
        """Линии событий MAC: 9 (H-EVT1), 12 (H-EVT4), 10 (H-WAKE); 14 — только проверка, что канал закрыт."""
        lines = self.c.irq_lines
        m = self.evt_mask
        if self.r42 and m[HW_EVT_CH2_MASK]:
            raise ModelGap('вектор 14: маска 0x886fbc = %#x — второй канал событий не моделируется' % m[HW_EVT_CH2_MASK])
        (lines.add if self.r42 & EVT1_IRQ_MASK else lines.discard)(EVT1_VEC)
        (lines.add if self.r54 & m[HW_EVT4_IRQ_MASK] else lines.discard)(EVT4_VEC)
        self._wake_line()

    def _mmio32(self, a):
        return self._raw(a)

    def _raw_bytes(self, a, n):
        """Память/регистры глазами модели MAC — мимо журнала обращений CPU: чтение через c.read внутри шага uc
        (крючки портов, команд) модель стоимости засчитывала бы инструкции uc как её обращение к шине."""
        c = self.c
        a = c._alias_addr(a & M32)
        return bytes(c.mem.get(a + i, 0) for i in range(n))

    def _raw(self, a, n=4):
        return int.from_bytes(self._raw_bytes(a, n), 'little')

    def _wake_line(self):
        """H-WAKE: линия вектора 10 — взвод и событие из маски пробуждения."""
        if self.wake_armed and self.r42 & self.evt_mask[HW_UC_SLEEP_WAKE_MASK]:
            self.c.irq_lines.add(WAKE_VEC)
        else:
            self.c.irq_lines.discard(WAKE_VEC)

    def _set54(self, bit):
        self.r54 |= 1 << bit

    # ---- busy2 (H-E27) ----
    e27 = None

    def _eng(self, kind):
        """Произошло событие kind ('mtp', 'tx_done', 'tx_free', 'rx_end', 'rx_busy'): при взводе и маске — busy2."""
        if self.busy2_armed and self.e27 == kind:
            self.after(ACK_CLK, lambda: self._set42(14), 'busy2')
            self.busy2_armed = False

    def _busy2_check(self):
        """Уровни на момент взвода 0x02004000."""
        lvl = set()
        if self.tx is None and self.tx_pending is None:
            lvl |= {'tx_free', 'tx_done'}
        if self._mtp_valid():
            lvl.add('mtp')
        if self.rx is not None:
            lvl.add('rx_busy')
        else:
            # H-E27 rx_end — уровень «приёма нет»: взвод после конца кадра (второе ожидание rx_flow_run, ХРУПКО-цикл без
            # тайм-аута) сразу даёт busy2; на железе этот цикл не виснет (по коду uc, на стенде не снималось)
            lvl.add('rx_end')
        if self.e27 == 'mode_ack':
            t = self.trig03_at if (self.trig03_at is not None and self.trig03_at > self.now) else self.now
            self.busy2_armed = False
            self.at(t + ACK_CLK, lambda: self._set42(14), 'busy2_mode_ack')
            return
        if self.e27 in lvl:
            self._eng(self.e27)

    # ---- r55 ----
    def _latch_r55(self, sel):
        if sel == 0:                                      # SIFS_CNT: us<<8 | такты от точки отсчёта IFS
            d = self.now - self.ifs_ref
            self.r55 = ((d // CLK_PER_US) & 0xff) << 8 | (d % CLK_PER_US)
        elif sel == 5:                                    # G2_TSF_LOW
            self.r55 = self.tsf_us() & M32
        elif sel == 0xa:                                  # GP_CLK2_TIMER — остаток GP2 (H-CLK2)
            g = self.gp[2]
            self.r55 = max(0, g.end - self.now) & 0xffffff if g.end is not None else 0
        else:
            raise ModelGap('0x4d: селектор %#x не моделируется' % sel)

    r55 = 0

    # ---- GP ----
    def _gp_cmd(self, i, arg):
        g = self.gp[i]
        mode, trig = arg & 0xff, (arg >> 8) & 0xff
        running = g.start is not None and g.end is not None and g.end > self.now
        waiting = g.mode & 0x08 and g.trig and not g.fired and g.start is None
        if mode & 0x08 and (running or waiting):
            # H-GPRUN: работающий или ждущий своего триггера таймер команда с разрешением не перезапускает и пуск не
            # отменяет — режим и условие действуют со следующего периода (bti: GP2 по txop_event, затем, ещё до пуска,
            # 0x5400090a — дальше по своему концу; H-CLK2 — перезагрузка на границе слота; стенд: сетка A-BFT работает).
            g.next = (mode, trig)
            return
        self.cancel(g.ev)
        g.ev, g.start, g.end = None, None, None
        g.mode, g.trig = mode, trig
        g.fired = False
        g.next = None
        if not mode & 0x08:                               # стоп
            g.mode = 0
            return
        if trig == 0x00:
            self._gp_start(i, self.now)
        elif trig in (0x03, 0x04, 0x05, 0x07, 0x09):
            pass                                          # ждёт своего триггера (_gp_trigger)
        else:
            raise ModelGap('GP%d: триггер пуска %#04x не моделируется (команда %#x)' % (i, trig, (0x52 + i) << 24 | arg))

    def _gp_start(self, i, t):
        g = self.gp[i]
        g.start, g.end = t, t + g.val
        g.arms.append((t, g.val))
        g.ev = self.at(g.end, lambda i=i: self._gp_end(i), 'gp%d' % i)

    def _gp_end(self, i):
        g = self.gp[i]
        if self.profile:
            self.marks.append(('gp%d' % i, self.now, self.cnt.copy()))
        # GP0..2 → r54 б6..8; группа 3..5 → б16, 6..9 → б17, ext GP 0..2 (10..12) → б15 (ext_gp_0_1_2_end_ind)
        self._set54(6 + i if i < 3 else 16 if i <= 5 else 17 if i <= 9 else 15)
        # H-ORIGIN: событие GP — точка отсчёта IFS (SIFS_CNT); как точка старта ответа — только у таймеров с аппаратным
        # пуском (A-BFT: триггеры 03/05/09, замеры стенда). Программный пуск (00: повтор Feedback в DTI) — нет: на стенде
        # повтор уходит в срок, хотя кадр закрыт позже события GP1 + IFS.
        # H-ORIGIN — только у сетки A-BFT (триггеры 03/05/07/09, стенд); таймер с иным триггером (04 — тайм-аут от конца
        # своей передачи: ожидание ответа BRP) точкой ответа не считается (эфир двух узлов, seed 5: иначе — ложный 0x26)
        origin = g.trig in ORIGIN_TRIGS
        self.ifs_ref, self.ifs_ref_kind = self.now, ('gp%d' % i if origin else 'gp_sw')
        if origin:
            self.gp_hw_ref = self.now                     # последнее событие GP с аппаратным пуском (H-ORIGIN)
        g.ev = None
        wait = False
        if g.next:
            g.mode, g.trig = g.next
            g.next = None
            # H-GPNEXT: отложенный режим с аппаратным триггером (кроме GP2 «по своему концу», 09) ждёт свой триггер,
            # а не перезапускается периодом: станция A-BFT 0x5400070e при идущем GP2 (H-GP5, 644 такта) — конец A-BFT
            # от конца GP0, как в расчёте abft_sta_arm_abft_end_timer (иначе A-BFT станции кончался через 98 мкс)
            wait = g.trig != 0x00 and not (i == 2 and g.trig == 0x09)
            g.fired = False
        if wait:
            g.start = g.end = None
        elif g.mode & 0x04 or (i == 2 and g.mode and g.trig == 0x09):
            # период: перезапуск (H-CLK2: перезагрузка на границе слота); GP2 с триггером 09 — от своего же конца
            self._gp_start(i, self.now)
        else:
            g.start = g.end = None
        if i == 0:
            self._gp_trigger(0x07, self.now)              # H-GP7: пуск по концу GP0 (станция A-BFT: GP1 0x5300070e, GP2 0x5400070e)
        if i == 2:
            self._gp_trigger(0x09, self.now)              # H-GP9: пуск по концу GP2 (и самого GP2 с триггером 09)

    gp_retrigger = False              # H-GP-ONESHOT: пуск по триггеру — один раз до перепрограммирования (0x52..)

    def _gp_trigger(self, trig, t):
        """Пуск ждущих триггера таймеров. H-GP-ONESHOT (не проверено на железе): триггер срабатывает один раз; с
        gp_retrigger = True — на каждом событии (таймер перезапускается, как если бы аппаратный пуск был фронтом)."""
        for j, h in enumerate(self.gp):
            if h.mode and h.trig == trig and (h.start is None or self.gp_retrigger) and \
                    (self.gp_retrigger or not h.fired):
                self.cancel(h.ev)
                h.fired = True
                self._gp_start(j, t)

    # ================================================================ передача

    mtp_result = False
    mtp_rate = None                   # MCS из 0x17 (явный) — для ответа через SIFS
    mtp_resp_req = False              # H-MTPRESP: последний запрос MTP — ответ через SIFS (собирает MAC)
    go19 = False                      # H-TXGO18F: после последнего запроса MTP была 0x19
    sweep_len = 26                    # длина кадра шаблона (маяк — fwsh bcn_psdu_len, задаёт сценарий)
    gp_hw_ref = None
    ssw_field = None
    frame_ready = None
    go = False

    def _tx_try(self):
        """H-TXGO: передача начинается, когда есть и кадр в FIFO (0x33000002), и пуск после разрешения (0x19 → 0x18) —
        по последнему из двух (Feedback, первый кадр RSS: разрешение раньше — пуск по закрытию FIFO; кадры развёртки
        после первого: FIFO готов заранее — пуск по 0x18)."""
        if self.frame_ready is None or not self.go:
            return
        f, self.frame_ready, self.go = self.frame_ready, None, False
        self._tx_close(f['what'], f['dur'], f.get('fifo'), f.get('mpdu_len'), f.get('qframe'), f.get('qid'),
                       f.get('mcs', 0), f.get('rdg', False))

    def _rdg_from_go18(self, arg):
        """H-RD: RDG/More PPDU в A-MPDU держателя — б11 команды пуска 0x18 (после 0x19, до начала кадра; позже — не
        действует) при RD_SUPP очереди (rd_supp); у приёмника — r38 б15 в отчёте, который он прочтёт на заголовке."""
        p = self.tx_pending
        rec = p.get('rec') if p is not None and isinstance(p.get('qframe'), list) and not p.get('rd_resp') else None
        if rec is None:
            return
        rec['rdg'] = bool(self.rd_supp and (arg & (1 << 11) or self.rdg_force))
        for d in rec.get('reports', ()):
            d[38] = (d[38] | (1 << 15)) if rec['rdg'] else (d[38] & ~(1 << 15))

    def _tx_close(self, what, dur, fifo=None, mpdu_len=None, qframe=None, qid=None, mcs=0, rdg=False):
        """Кадр закрыт командой uc: старт — в точке ответа (после приёма/события GP) или сразу (инициатор)."""
        if self.ack_wait is not None and not what.startswith('sweep'):
            # H-TXAFTERACK: свой кадр ждёт Ack — следующий MAC выпускает после ответа (через IFS от его конца) или
            # тайм-аута; uc закрывает его раньше (стенд: slot_event во время своего кадра, запрос итога — 50–350
            # тактов, столкновений с ответом нет)
            self.deferred_close = (what, dur, fifo, mpdu_len, qframe, qid, mcs, rdg)
            return
        trn = 0 if what.startswith('sweep') else self.trn_tx
        dur += trn_clk(trn)                               # H-TRN: поле TRN-R — часть PPDU
        if self.tx_pending is not None or (self.tx is not None and not (what.startswith('sweep') and
                                                                         self.tx['what'].startswith('sweep'))):
            raise ModelGap('закрыт кадр %r, пока идёт передача' % what)
        resp_point = self.ifs_ref + self.ifs_clk() + MACLAT_CLK
        last = self.air_log[-1] if self.air_log else None
        if self.tx is not None:                           # кадр развёртки в эфире — следующий встаёт за ним (H-TXEVT)
            last = (self.tx['start'], self.tx['end'], 'tx', self.tx['what'])
        if what.startswith('sweep') and last and last[2] == 'tx' and last[3].startswith('sweep') and \
                not last[3].startswith('sweep CDOWN 0 ') and self.now - last[1] < 50 * SLOT_CLK:
            # H-SWEEP: следующий кадр развёртки — через SBIFS (0x886d0c) после конца предыдущего, если пуск раньше
            # (стенд E4: зазор 1,000 мкс); позже — по пуску, опоздание в sweep_late (срок от tx_end у железа не
            # установлен: путь uc от tx_end длиннее SBIFS, а зазор в эфире точный — H-E4)
            start = last[1] + self.sbifs_clk()
            if self.now > start:
                self.sweep_late.append((self.now, what, self.now - start))
                start = self.now + ACK_CLK
            self.tx_pending = dict(start=start, dur=dur, what=what, fifo=fifo, mpdu_len=mpdu_len, qframe=qframe, qid=qid,
                                   trn=trn, mcs=mcs)
            self.at(start, self._tx_start, 'tx_start')
            self._notify_tx()
            return
        ref, kind = self.ifs_ref, self.ifs_ref_kind
        if self.gp_hw_ref is not None and kind == 'rx' and self.ifs_ref - self.gp_hw_ref < self.ifs_clk():
            # H-ORIGIN: прямая передача после события GP с аппаратным пуском отсчитывается от него, даже если приём
            # кончился позже (стенд A-BFT: Feedback = GP1 + MBIFS + 0,55 мкс при конце SSW станции после GP1)
            ref, kind = self.gp_hw_ref, 'gp'
        if kind in ('rx', 'gp', 'gp0', 'gp1', 'gp2') and self.now - ref < 4 * self.ifs_clk():
            resp_point = ref + self.ifs_clk() + (MACLAT_RX_CLK if kind == 'rx' else MACLAT_CLK)   # H-ORIGIN-RX / H-ORIGIN
            start = resp_point                            # ответная передача: MAC держит IFS от точки отсчёта
            if self.now > resp_point:
                rec = (self.now, what, self.now - resp_point, self.ifs_ref_kind)
                if kind == 'rx':
                    # H-LATE-RX: прямая передача, закрытая позже точки IFS от конца приёма, — MAC начинает её позже,
                    # без ошибки (стенд: BRP после BRP идёт без FWERR; 802.11-2020: BRP — BRPIFS, не SIFS). Ошибка
                    # MAC (H-LATE) — у ответа через SIFS, который собирает MAC (0x37000020), и у передач от события GP
                    # (стенд A-BFT: FWERR 0x26)
                    self.late_rx.append(rec)
                else:
                    self._late(rec)
                start = self.now + TX_START_CLK
        else:
            start = self.now + TX_START_CLK
        self.tx_pending = dict(start=start, dur=dur, what=what, fifo=fifo, mpdu_len=mpdu_len, qframe=qframe, qid=qid,
                                   trn=trn, mcs=mcs, rdg=rdg)
        self.at(start, self._tx_start, 'tx_start')
        self._notify_tx()

    dur_new = False
    dur_literal = True
    go18 = None                       # H-DUR18: последний пуск 0x18 кадра (None — для кадра FIFO его ещё не было)

    def _dur_minus_txtime(self):
        """H-DUR18: в режиме 0x14000007 Duration = 0x15 − ⌈TXTIME⌉, если кадр пущен 0x18 без б12."""
        return self.dur_literal and self.go18 is not None and not self.go18 & 0x1000
    txop_end = None
    bic_a = bic_b = 0

    def bic_bytes(self):
        """BI Control (6 октетов, 9.3.4.2) из 0x2a/0x2b — раскладка MAC (test_uc_beacon_tx)."""
        v = (self.bic_a & 0xfffff) | (self.bic_b << 20) | ((self.bic_a >> 20) << 44)
        return v.to_bytes(6, 'little')

    txopq_end = None                  # H-DURQ: конец TXOP по лимиту MAC (такты)
    durq_new = False                  # H-DURG: 0x15 записана, своего кадра после неё ещё не было
    txopg_end = None                  # H-DURG: конец TXOP по 0x15 предыдущего своего кадра (такты) — для группового

    def _dur_field(self, p):
        """Duration кадра в эфире и TXOP (H-DUR, H-TXOP, uc/abft.h). Кадр развёртки после записи 0x15 начинает TXOP
        заново за MACLAT до своего начала, длиной 0x15 (стенд bcn1: сдвиг txop_event 53 такта = δb − MACLAT). Duration
        маяка: буквальный режим (0x14000007) — 0x15 − ⌈TXTIME⌉; иначе (0x14000005) — ⌊остаток TXOP после кадра⌋.
        H-DUR18 (стенд 2026-11-04, PMC обоих узлов): в режиме 0x14000007 MAC вычитает из 0x15 ⌈TXTIME⌉ своего PPDU,
        если кадр пущен 0x18 без б12 (CF-End держателя 34 → 19 и 18 → 3, ATIM 38 → 19, RTS keep-alive 40 → 25, маяки
        BTI — 0x18000000, 0x15 − 20); с б12 (0x18001000 — SLS в DTI: SSW 1012, SSW-Feedback 37, SSW-Ack 10) — 0x15
        буквально. Кадр FIFO без 0x18 (ответ uc через SIFS, tx_send_imm_response) — буквально (не снято).
        H-LITSSW: SSW развёртки (кадр FIFO с полем SSW 0x2d — ISS/RSS в DTI и пачка A-BFT) в буквальном режиме несёт
        0x15 как есть, без вычета TXTIME: стенд dur3 (2026-10-22) — SSW CDOWN 1/0 = 25/9 при 0x15 = 25/9 (SLS_SSW_DUR,
        uc/abft.h), vendor 17/1 при 0x15 = ss_plan_tx_dur 17/1; std4 — первый SSW в A-BFT 275 при 0x15 = 275. Вычет
        ⌈TXTIME⌉ — только у маяка (шаблон без FIFO; rnd1/bcn1: 1269 = 1289 − 20). Вне развёртки — 0x15 буквально."""
        durq_new, self.durq_new = self.durq_new, False   # H-DURG: 0x15 — кадру FIFO, первому после записи
        if not p['what'].startswith('sweep'):
            # H-DURQ (стенд 2026-10-31, STAMP_RX_DUR): Duration RTS и кадров очереди ставит MAC — остаток лимита TXOP
            # (HW_MAC_TXOP_LIMIT_0 [31:16], мкс) от начала TXOP − SIFS: RTS 2000 − SIFS − TXTIME(RTS) = 1982; запись 0x15
            # на них не действует. Прочие кадры FIFO uc (CF-End, ATIM, BRP …) — 0x15 по H-DUR18
            fifo = p.get('fifo')
            rts = fifo is not None and len(fifo) >= 2 and fifo[0] == 0xb4 and fifo[1] == 0
            lim = self._raw(HW_MAC_TXOP_LIMIT_0) >> 16
            qf = p.get('qframe')
            if isinstance(qf, (bytes, bytearray)) and len(qf) >= 10 and qf[4] & 1:
                # H-DURG (стенд 2026-11-07 bcbnc2/bcm9 и 2026-11-04…06 bcm7/bcm2u, RX-запись станции): Duration
                # группового кадра очереди — остаток TXOP MAC на НАЧАЛО кадра (свой TXTIME не вычитается): по лимиту —
                # лимит − SIFS (1997 у кадров 118 и 194 Б); после своего кадра FIFO с 0x15 в этом доступе — конец TXOP =
                # начало того кадра + 0x15 (прежний путь: 0x15 DMG CTS-to-self 48/71 → групповой кадр 30/53 = 0x15 −
                # ⌈TXTIME(CTS)⌉ − SIFS). 0x15 перед самим кадром очереди не действует (стенд 2026-11-07, bdur0:
                # 0x15 = 0 — 15 × 1997).
                # H-DURLIM0 (стенд 2026-11-07, bdur1: 14 из 14 групповых кадров — 0): лимит TXOP 0 —
                # Duration 0 (802.11-2020 9.2.5.2 b) 1): T_TXOP = 0, NAV держателя
                # нет — D = T_SINGLE-MSDU − T_PPDU, у группового кадра 0); кадр MAC отдаёт (10.23.2.9)
                if self.txopg_end is not None and p['start'] < self.txopg_end:
                    end = self.txopg_end
                elif lim:
                    end = p['start'] - SIFS_CLK + lim * CLK_PER_US
                else:
                    end = p['start']
                self.txopg_end = None
                return max(0, (end - p['start']) // CLK_PER_US)
            if durq_new and fifo is not None:
                self.txopg_end = p['start'] + self.dur_us * CLK_PER_US      # H-DURG: 0x15 своего кадра — конец TXOP
            if (rts or qf is not None) and lim:
                if rts or self.txopq_end is None or p['start'] >= self.txopq_end:
                    self.txopq_end = p['start'] - SIFS_CLK + lim * CLK_PER_US
                return max(0, (self.txopq_end - (p['start'] + p['dur'])) // CLK_PER_US)
            if fifo is not None and self._dur_minus_txtime():
                return max(0, self.dur_us - -(-p['dur'] // CLK_PER_US))      # H-DUR18
            return self.dur_us
        if self.dur_new or self.txop_end is None:
            self.txop_end = p['start'] - MACLAT_CLK + self.dur_us * CLK_PER_US
            self.dur_new = False
        if self.dur_literal:
            if p.get('fifo') is not None:                 # H-LITSSW: SSW развёртки из FIFO — 0x15 как есть
                return self.dur_us
            return max(0, self.dur_us - -(-p['dur'] // CLK_PER_US))   # маяк из шаблона (H-DUR18: 0x15 − 20)
        return max(0, (self.txop_end - (p['start'] + p['dur'])) // CLK_PER_US)

    ACK_WAIT_CLK = SIFS_CLK + ctrl_txtime_clk(14) + 2 * SLOT_CLK   # конец кадра → конец Ack (+ запас 2 слота)

    def _q_sent(self, t):
        """Кадр очереди ушёл (H-MACQ2): групповой — сразу завершён (статус 0); одноадресный — ждёт Ack: пришёл
        (ack_rx) — статус 0, нет за ACK_WAIT_CLK — статус 1 (повторы MAC не моделируются)."""
        f, qid = t['qframe'], t['qid']
        if qid is None:                                   # H-QNULL: QoS Null MAC (No Ack) — не кадр очереди
            return
        n = 1
        if isinstance(f, list):                           # A-MPDU — ждёт BlockAck
            n, f = len(f), f[0]
        if f[4] & 1:
            if qid == self._raw(FSCHED_PEER_ID) & 0xff:
                # H-BAPREL: кадр широковещательного кольца точки (fsched_peer_id, tx_bcast_flow) остаётся в очереди
                # до освобождения 0x46 — копии на секторы станций обхода (uc: перед освобождением очередь не пуста,
                # иначе assert 7)
                self.q_hold = qid
                return
            self._q_done(qid, 0)
            return
        self.ack_wait = dict(qid=qid, ra=bytes(f[4:10]), n=n)
        self.ack_wait['ev'] = self.at(t['end'] + self.ACK_WAIT_CLK, lambda: self._ack_timeout(), 'ack_wait')

    deferred_close = None

    def _resume_deferred(self, after_ack):
        d, self.deferred_close = self.deferred_close, None
        if d is None:
            return
        if after_ack:
            self.ifs_ref, self.ifs_ref_kind = self.now, 'rx'   # от конца Ack — как продолжение TXOP
        self._tx_close(*d)

    RETRY_LIMIT = 7                   # H-RETRY: dot11ShortRetryLimit (DEFVAL 7), предел MAC на железе не снят

    def _ack_timeout(self):
        """H-RETRY (802.11-2020 10.23.2.12): нет Ack — кадр остаётся в очереди MAC с битом Retry (Frame Control б11)
        и счётчиком повторов; после RETRY_LIMIT неудач — завершение со статусом 1."""
        if self.ack_wait is not None and self.rx is not None:
            # 802.11-2020 10.23.2.2: PHY-RXSTART в пределах тайм-аута — ждать конца этого PPDU (ответ RD — BlockAck
            # в одном PPDU с данными ответчика, длиннее одиночного BlockAck)
            self.ack_wait['ev'] = self.at(self.rx['end'] + 1, self._ack_timeout, 'ack_wait')
            return
        w, self.ack_wait = self.ack_wait, None
        if w is not None:
            q = self.mac_q.get(w['qid'])
            n = self.q_retry.get(w['qid'], 0) + 1
            if q and n < self.RETRY_LIMIT:
                self.q_retry[w['qid']] = n
                for i in range(min(w.get('n', 1), len(q))):
                    f = bytearray(q[i])
                    f[1] |= 0x08
                    q[i] = bytes(f)
                self.retry_log.append((self.now, w['qid'], n))
                self._backoff_kick()
            else:
                for _ in range(w.get('n', 1)):
                    self._q_done(w['qid'], 1)
        self._resume_deferred(False)

    def ba_rx(self):
        """Принят BlockAck на A-MPDU (вызывает эфир): все MPDU подтверждены (H-AMPDU: потерь в эфире нет)."""
        w, self.ack_wait = self.ack_wait, None
        if w is not None:
            self.cancel(w['ev'])
            self.bap_tx = w.get('n', 1)
            for _ in range(w.get('n', 1)):
                self._q_done(w['qid'], 0)
        self._resume_deferred(True)

    rd_auto_ba = False                # H-RD-BA: ответ RD принят — MAC сам подтверждает его данные BlockAck
    resume_after_tx = False           # H-RD-BA: отложенный кадр (CF-End держателя) — после своего BlockAck

    def rd_resp_rx(self):
        """Принят ответ RD (BlockAck на свой A-MPDU + данные ответчика, вызывает эфир в конце PPDU). H-RD-BA (стенд
        2026-11-04, PMC обоих узлов, наш fw): после ответа RD держатель шлёт BlockAck на данные ответчика, через
        ~16 мкс от него — CF-End (3335 TXOP станции с данными точки в RD, у точки-держателя — так же), хотя uc держателя
        при пустой очереди закрывает CF-End ещё до ответа (H-TXAFTERACK) и команды ответа на данные RD не даёт. Модель:
        BlockAck — MAC через SIFS после ответа RD (если uc не запросил ответ сам), отложенный кадр — через SIFS после него.
        Не проверено и, вероятно, расходится с железом: на стенде этот BlockAck — на MCS 8/7 (MCS данных по выбору
        скорости, т. е. запрос uc в MTP, а не ответ MAC по умолчанию — MCS 1, H-RESPMCS), Duration на 1–7 мкс короче
        9.2.5.7 в 5069 из 11 774, CF-End — через 10,4 мкс после него, не через SIFS (ref.air_judge по тем же PMC). В модели
        после ответного CF-End держатель отстаёт счётчиком PPDU (кадр RD uc не разбирал) и теряет следующий DMG CTS — на
        стенде этого нет (после DMG CTS держатель шлёт данные: 6 повторов RTS из 17 989)."""
        w, self.ack_wait = self.ack_wait, None
        if w is not None:
            self.cancel(w['ev'])
            self.bap_tx = w.get('n', 1)
            for _ in range(w.get('n', 1)):
                self._q_done(w['qid'], 0)
        self.rd_auto_ba = True

    def ack_rx(self):
        """Принят Ack на кадр очереди (вызывает эфир)."""
        w, self.ack_wait = self.ack_wait, None
        if w is not None:
            self.cancel(w['ev'])
            self._q_done(w['qid'], 0)
        self._resume_deferred(True)

    def _q_avail(self, qid):
        """H-QREAD: кадры очереди qid, ещё не выданные в эфир. Кадр в эфире или в ожидании Ack/BlockAck остаётся в
        очереди (повтор при тайм-ауте — H-RETRY), но указатель чтения MAC уже за ним: MTP его не предлагает и при
        отсутствии остальных отвечает «очередь пуста» (r45 null_status б1 → uc закрывает TXOP CF-End). Иначе следующий
        кадр TXOP, закрытый до Ack предыдущего (H-TXAFTERACK), повторял бы неподтверждённый."""
        q = self.mac_q.get(qid) or []
        busy = 0
        for t in (self.tx_pending, self.tx):
            if t is not None and t.get('qid') == qid and t.get('qframe') is not None:
                busy += len(t['qframe']) if isinstance(t['qframe'], list) else 1
        if self.ack_wait is not None and self.ack_wait['qid'] == qid:
            busy += self.ack_wait.get('n', 1)
        return q[busy:]

    def _q_done(self, qid, status):
        self.q_retry.pop(qid, None)
        q = self.mac_q.get(qid)
        if q:
            q.pop(0)
            if not q:
                self.mac_q_pending &= ~(1 << qid)
        self.q_done.append((qid, status))
        self._backoff_kick()

    def _notify_tx(self):
        p = self.tx_pending
        p['dur_field'] = self._dur_field(p)
        if self.on_tx is not None:
            p['rec'] = dict(start=p['start'], dur=p['dur'], what=p['what'], dur_us=p['dur_field'], fifo=p.get('fifo'),
                            mpdu_len=p.get('mpdu_len'), ssw=getattr(self, 'ssw_raw', 0), bic=self.bic_bytes(),
                            qframe=p.get('qframe'), trn=p.get('trn', 0), mcs=p.get('mcs', 0), rdg=p.get('rdg', False),
                            rd_resp=p.get('rd_resp', False))
            self.on_tx(p['rec'])

    dur_us = 0

    def _tx_start(self):
        p, self.tx_pending = self.tx_pending, None
        t0 = p['start']                                   # время MAC, а не конец инструкции uc, в которую попал пуск
        self.tx = dict(start=t0, end=t0 + p['dur'], what=p['what'], dur_us=self.dur_us, qframe=p.get('qframe'),
                       qid=p.get('qid'))
        self.medium_busy_end = max(self.medium_busy_end, self.tx['end'])
        self.air_log.append((self.tx['start'], self.tx['end'], 'tx', self.tx['what']))   # кадр в журнале с пуска
        f = p.get('fifo')
        if f is not None and len(f) >= 2 and f[0] == 0xe4 and f[1] == 0:
            # H-TXOPEVT-CFEND: CF-End держателя TXOP (tx_send_and_await_rx_frame: 0x15 — Duration обмена усечения,
            # 10.39.8) — txop_event в конце этого TXOP (H-TXOP: от начала кадра − MACLAT + Duration); после ответного
            # CF-End или тайм-аута uc ждёт его (uc_spin_until_event(MAC_EVT1_TXOP)). По коду uc, на стенде не снято
            self.txop_event(t0 - MACLAT_CLK + self.dur_us * CLK_PER_US)
        self._eng('mtp')
        self.at(t0 + min(TX_EVT_AFTER_START_CLK, p['dur'] // 2), lambda: self._set42(15), 'tx_end_event')
        self.at(self.tx['end'] - min(TX_END_LEAD_CLK, p['dur'] // 2), self._tx_end, 'tx_end')

    def _tx_end(self):
        """События конца передачи (H-TXEND: раньше конца кадра в эфире на TX_END_LEAD_CLK)."""
        if self.profile:
            self.marks.append(('tx_free', self.now, self.cnt.copy()))
        t = self.tx
        if t['what'].startswith('sweep CDOWN 0 '):
            # H-TXOP: txop_event — в конце TXOP последнего перезапуска (_dur_field)
            self.txop_event(self.txop_end)
            self.txop_end = None
        if t.get('qframe') is not None:
            self._q_sent(t)
        self.tx = None
        self.perm_req_at = None
        self.ifs_ref, self.ifs_ref_kind = self.now, 'tx'     # SIFS_CNT = 0 после передачи (UC-REGISTERS §2.16)
        self._gp_trigger(0x04, self.now)                  # H-GP4: пуск по концу своей передачи
        if self.resume_after_tx:                          # H-RD-BA: CF-End держателя — через SIFS после BlockAck
            self.resume_after_tx = False
            self._resume_deferred(True)
        self._backoff_kick()
        self._eng('tx_done')
        self._eng('tx_free')

    # ================================================================ приём (сценарий)
    last_rx_sifs_resp = False
    bf_metric = 0x100
    resp_due = None                   # принятый кадр, на который MAC ждёт ответ через SIFS
    resp_cmd_at = None

    def _hw_response(self):
        """Ответ собирает MAC: старт — конец принятого PPDU + SIFS (0x886d00) + задержка MAC (H-ORIGIN), если команда
        ответа 0x37000020 пришла раньше этой точки; позже точки, но в срок (H-SIFSRESP) — команда + та же задержка MAC
        (H-RESPCMD); без команды или после срока — запись в late уже есть, старт — через TX_START_CLK.
        H-RESPCMD (захват PMC обоих узлов 2026-11-04, судья tests/ref/air_judge, docs/MAC-STAND.md «Эфир: ответы через
        SIFS»): DMG CTS в эфире через 4,93 мкс (AP) / 4,96 (станция) после RTS, команда 0x37000020 на стенде — при
        SIFS_CNT ≈ 720 (метка 12: 0x19 при 754–761, 0x19 на ~30 тактов позже) ⇒ 4,93·165 − 720 ≈ 93 ≈ MACLAT_CLK.
        BlockAck (команда 840–1056) — 5,5–6,0 мкс с разбросом команды. Прежде модель ставила TX_START_CLK (230, старт
        прямой передачи после FIFO) — ответ на ~0,85 мкс позже железа."""
        r, self.resp_due = self.resp_due, None
        self.go = False
        start = r['end'] + self.ifs_clk() + MACLAT_CLK
        if self.resp_cmd_at is None or self.resp_cmd_at > r['end'] + r['deadline']:
            start = max(start, self.now + TX_START_CLK)
        else:
            start = max(start, self.resp_cmd_at + MACLAT_CLK, self.now)
        self.resp_cmd_at = None
        mcs = r.get('mcs', 0)
        if self.mtp_rate is not None:
            mcs = self.mtp_rate                           # явный MCS ответа от uc (rx_frame_tx_resp_seq, 10.6.7.2)
        q = self._q_avail(self.mtp_qid) if self.mtp_resp_data and self.q_agg.get(self.mtp_qid) else None
        if q and r['resp_len'] == BA_LEN:
            # H-RD: ответ RD — BlockAck + A-MPDU данных очереди (окно BA) одним PPDU на MCS данных
            fs = list(q[:self.q_agg[self.mtp_qid]])
            n = ampdu_psdu_len([bytes(BA_LEN - 4)] + fs)
            self.tx_pending = dict(start=start, dur=sc_txtime_clk(n, self.data_mcs), qframe=fs, qid=self.mtp_qid,
                                   what='ответ на %s + RD A-MPDU %d MPDU %d B MCS %d' % (r['what'], len(fs), n,
                                                                                         self.data_mcs),
                                   mcs=self.data_mcs, rd_resp=True)
            self.mtp_resp_data = False
            self.at(start, self._tx_start, 'tx_start')
            self._notify_tx()
            return
        dur = sc_txtime_clk(r['resp_len'], mcs) if mcs else ctrl_txtime_clk(r['resp_len'])
        self.tx_pending = dict(start=start, dur=dur, what='ответ на ' + r['what'], mcs=mcs)
        self.at(start, self._tx_start, 'tx_start')
        self._notify_tx()

    def air_rx(self, t_clk, psdu_len, what='', on_hdr=None, on_end=None, report=None, txss_end=False, sifs_resp=False,
               resp_len=14, resp_deadline=RESP_CMD_DEADLINE_CLK, dur=None, report_at_hdr=False, nav_us=0, trn=0, mcs=0, rmcs=None):
        """Кадр пира в эфире с такта t_clk длиной psdu_len (control PHY). on_hdr(hw) — по rx_frame_event (H-HDR,
        заголовок разобран: заполнить буфер приёма), on_end(hw) — в конце; report — {36..39: значение}."""
        dur = ctrl_txtime_clk(psdu_len) if dur is None else dur
        if report_at_hdr and report:
            # H-RXREP-HDR (стенд, метка STAMP_SSW_REP): отчёт r36..r39 готов уже на rx_frame_event
            hdr0, rep = on_hdr, report                   # значения — на заголовке (RDG ставит пуск 0x18, H-RD)

            def on_hdr(hw, hdr0=hdr0, rep=rep):
                if hdr0:
                    hdr0(hw)
                for n, v in rep.items():
                    hw.uc.ext[n] = v
        if nav_us:                                        # NAV: кадр не мне — до конца кадра + Duration (802.11-2020 10.3.2.4)
            end0 = on_end

            def on_end(hw, end0=end0):
                hw.nav_end = max(hw.nav_end, hw.now + nav_us * CLK_PER_US)
                if end0:
                    end0(hw)
        self.at(t_clk, lambda: self._rx_start(dur, what, on_hdr, on_end, report or {}, txss_end, sifs_resp, resp_len,
                                              resp_deadline, trn, mcs, rmcs),
                'rx_start')
        return t_clk + dur

    def _rx_start(self, dur, what, on_hdr, on_end, report, txss_end=False, sifs_resp=False, resp_len=14,
                  resp_deadline=RESP_CMD_DEADLINE_CLK, trn=0, mcs=0, rmcs=None):
        if self.tx is not None:
            if self.collisions is None:
                raise ModelGap('приём %r во время своей передачи (%r)' % (what, self.tx['what']))
            # H-COLL (эфир нескольких узлов): полудуплекс — кадр, начавшийся во время своей передачи, не принимается
            self.collisions.append((self.now, what, self.tx['what']))
            return
        self.rx = dict(start=self.now, end=self.now + dur, what=what, trn=trn)
        self.medium_busy_end = max(self.medium_busy_end, self.rx['end'])
        dur -= trn_clk(trn)                               # данные; поле TRN — после них (H-TRN)
        self.r49 &= ~(1 << 5)
        self.bap_rx = False
        self.bap_tx = None
        if self.rx_mode in (1, 2, 3):
            # H-BUSY: в режимах приёма 1–3 (1 — после своего DMG CTS, rx_resp_finish_restore_rx: ждёт данные держателя
            # TXOP в sxd_hal_wait_slot2_busy; стенд: RTS → CTS → A-MPDU → BlockAck работает); 2/3 — одной веткой rx_mode_configure (3 — rx_enter_listen_mode, 2 —
            # после своего TXOP, tx_send_and_await_rx_frame) начало PPDU — busy_event (r42 б19), по нему L1 запускает
            # rx_flow (l1_task_on_evt1; вне прослушивания uc ставит assert 0x28 — флаг rx_listen_active режим 2 не
            # снимает). Режим 2: стенд 2026-10-30 — станция после TXOP с CF-End (STAMP_MTP_RESULT) подтверждает Assoc
            # Response. Время события на стенде не снималось
            self._set42(19)
        self.cca_cnt += 1
        rx = self.rx

        def sfd():
            if self.rx is rx:
                self._set42(11)                           # sfd_sync (H-PHYRX)
        hdr_clk = -(-SC_HDR_TC * 3 // 32) if mcs else HDR_CLK          # H-HDR-SC
        sfd_clk = -(-2176 * 3 // 32) if mcs else max(min(HDR_CLK, dur) - SFD_BEFORE_HDR_CLK, 0)   # SC: конец STF
        self.after(sfd_clk, sfd, 'rx_sfd')
        self._eng('rx_busy')

        def hdr():
            if self.rx is rx:
                rx['hdr'] = True                          # phy_rx_frame, cca_ppdu_comp снят (H-PHYRX)
            if on_hdr:
                on_hdr(self)
            self._set42(12)                               # rx_frame_event (H-HDR)
        self.after(min(hdr_clk, dur), hdr, 'rx_hdr')
        self.after(dur, lambda: self._rx_end(on_end, report, txss_end, sifs_resp, resp_len, what, resp_deadline,
                                             rmcs if rmcs is not None else RESP_MCS_DEFAULT_SC if mcs else 0), 'rx_end')

    def _rx_end(self, on_end, report, txss_end=False, sifs_resp=False, resp_len=14, what='',
                resp_deadline=RESP_CMD_DEADLINE_CLK, rmcs=0):
        r = self.rx
        self.air_log.append((r['start'], r['end'], 'rx', r['what']))
        if r.get('trn'):
            self._trn_start(r)                            # среда занята до конца TRN
        else:
            self.rx = None
        self.ppdu_cnt += 1
        self.last_rx_sifs_resp = sifs_resp
        if sifs_resp:
            self.bap_rx = True
        if rmcs:
            resp_deadline = max(resp_deadline, RESP_CMD_DEADLINE_SC_CLK)
        self.resp_due = dict(end=self.now, what=what, resp_len=resp_len, deadline=resp_deadline, mcs=rmcs) \
            if sifs_resp else None
        self.resp_cmd_at = None
        if self.rd_auto_ba:
            self.rd_auto_ba = False
            if sifs_resp:                                 # H-RD-BA: BlockAck на данные ответа RD — MAC сам
                r = self.resp_due

                def auto_ba(r=r):
                    if self.resp_due is r and self.tx is None and self.tx_pending is None:
                        self.mtp_resp_data = False
                        self.resume_after_tx = self.deferred_close is not None
                        self.resp_cmd_at = self.now
                        self._hw_response()
                    elif self.deferred_close is not None and self.tx is None and self.tx_pending is None:
                        self._resume_deferred(True)
                self.at(self.now + self.ifs_clk() + MACLAT_CLK, auto_ba, 'rd_auto_ba')
            else:
                self._resume_deferred(True)
        for n, v in report.items():
            self.uc.ext[n] = v
        if on_end:
            on_end(self)
        self._eng('rx_end')
        self._set42(16)                                   # ppdu_report_event
        if txss_end:
            self._set54(0)                                # txss_end_ind: развёртка пира кончилась (CDOWN 0)
        self.ifs_ref, self.ifs_ref_kind = self.now, 'rx'
        self._gp_trigger(0x05, self.now)                  # H-GP5: пуск по концу приёма
        self._backoff_kick()

    def _trn_start(self, r):
        """H-TRN: поле TRN-R принятого кадра — BRP-стадия (r49 б13), 32 метрики (r54 б1 + слово r40 BF_METRIC),
        в конце BRP_DONE (r49 б5)."""
        n, t0 = r['trn'], self.now
        self.r49 |= 1 << 13

        def metric(k):
            if self.rx is r:
                self.bf_metric = (k << 24) | (TRN_METRIC << 14)
                self._set54(1)
        for k in range(TRN_METRICS):
            self.at(t0 + trn_metric_clk(n, k), lambda k=k: metric(k), 'trn_metric')

        def end():
            if self.rx is r:
                self.rx = None
            self.r49 = (self.r49 & ~(1 << 13)) | (1 << 5)
            self._backoff_kick()
        self.at(t0 + trn_clk(n), end, 'trn_end')

    # ================================================================ разное
    trig03_at = None

    def txop_event(self, t_clk):
        """txop_event (r42 б7) в такт t_clk; триггер 03 GP — через IFS + 7 тактов (H-GP3)."""
        def ev():
            self._set42(7)
            self.txop_event_at = self.now
            self.trig03_at = self.now + self.ifs_clk() + GP3_DELAY_CLK
            self.at(self.trig03_at, lambda: self._gp_trigger(0x03, self.now), 'gp_trig03')
        self.at(t_clk, ev, 'txop')

    def log_air(self):
        return ['%9.3f..%9.3f мкс %s %s' % (s / CLK_PER_US, e / CLK_PER_US, k, w) for s, e, k, w in self.air_log]
