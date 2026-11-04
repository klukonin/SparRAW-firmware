# Эталонная модель DMG MAC (802.11-2020) — план полной реализации

Цель: исполняемая спецификация DMG MAC (Clause 9, 10.39–10.42, 11) для дифференциальной проверки прошивки
(fw + uc в эмуляторе cosim) и для генерации эталонного поведения. Правила — только из текста стандарта
(`docs/80211-2020.txt`, формулы — `docs/80211-2020.formulas.jsonl`), с номером пункта/таблицы/рисунка в
комментарии; код fw/uc и vendor не источник (иначе проверка становится тавтологией). Расхождения 2020/2024 —
отмечать, нормой считать 2020. Время — `fractions.Fraction`, мкс, моменты «на эфире» (10.3.7); такты 165 МГц —
только на границе с эмулятором (`timing.us_to_clk`).

## Модули

Готово (этап 1):
- `timing.py` — DMG PHY-тайминги (табл. 20-30, 20-4, TXTIME 20.11.3), IFS (10.3.2.3).
- `cbap.py` — EDCA backoff, NAV, TXOP, CBAP-окна, дискретно-событийный эфир «все слышат всех», `check_air_log`.
- `blockack.py` — Block Ack HT-immediate для DMG (10.25), кодеки ADDBA/DELBA/BA/BAR.
- `duration.py` — поле Duration/ID всех кадров DMG (9.2.5, 9.3.1.x, 10.39), `check_duration`.

Волна A (независимые модули, свой файл + свой test_*.py):
- `fields.py` — поля BF и управления DMG бит-в-бит: SSW field (9.5.1), SSW Feedback field (9.5.2), BRP Request
  field (9.5.3), BF Control field (9.5.5), Beamformed Link Maintenance (9.5.6), Dynamic Allocation Info (9.5.4?),
  Beacon Interval Control, Clustering Control, DMG Parameters (9.3.4.2), кадры управления DMG с Control Frame
  Extension (Poll, SPR, Grant, DMG CTS, DMG DTS, SSW, SSW-Feedback, SSW-Ack, Grant Ack, TDD…) и DMG Beacon
  (9.3.4.2) — encode/parse/validate.
- `elements.py` — элементы и тела кадров управления, нужные DMG: DMG Capabilities (9.4.2.127), DMG Operation
  (9.4.2.128), Extended Schedule (9.4.2.131) с Allocation, Next DMG ATI, DMG BSS Parameter Change, Relay/
  Multi-band — по мере нужды; тела Probe Request/Response, Association/Reassociation, Authentication,
  Disassociation/Deauthentication (9.3.3), порядок элементов (табл. 9-xx).
- `bi.py` — структура BI DMG (10.39.1–10.39.6): TBTT, BTI, A-BFT, ATI, DTI, CBAP/SP по Extended Schedule,
  длительности и границы, псевдостатичные SP, проверка журнала эфира на инварианты BI.
- `sls.py` — SLS (10.42.2, 10.42.4, 10.42.6.2): ISS/RSS/Feedback/Ack, CDOWN, выбор сектора, MBIFS/SBIFS/LBIFS,
  повторы и тайм-ауты; автоматы инициатора и ответчика.
- `abft.py` — A-BFT (10.42.5): слоты, FSS, выбор слота, счётчики неудач, повторы, ответ точки, несколько антенн.
- `brp.py` — BRP (10.42.3, 10.42.6.4): BRP setup, BRP-кадры, TRN, BRPIFS, транзакции уточнения; MIDC (10.42.6.3).
- `mlme.py` — DMG MLME: сканирование (11.1.4), ATI (10.39.3), аутентификация/ассоциация (11.3), состояния
  STA (11.3.1), тайм-ауты.

Волна B (интеграция):
- `medium.py` — направленный эфир: сектор передачи × конфигурация приёма → принят/не принят, квази-омни.
- `dmg_sta.py` — станция DMG (AP/PCP и non-AP) из модулей: BI, BF, доступ, MLME, BA; режимы «генератор» (ведёт
  себя по стандарту) и «судья» (проверяет поток событий).
- мосты cosim → эталон для BTI/A-BFT/SLS/BRP/ассоциации (как `unit/ref_bridge.py` для CBAP); дифференциальные
  тесты на сценариях: старт AP, вход STA (A-BFT → SLS → ассоциация → BA → данные), потеря и восстановление связи.
- `beamtrack.py` — сопровождение луча и поддержание связи (10.42.7, 10.42.9?), если нужно прошивке.

Эфир стенда (захват сниффером узлов, rewrite/docs/CAPTURE.md):
- `air_pcap.py` — pcap wilmon одного или двух узлов → журнал эфира `AirEv` (вид `unit/ref_bridge2.Ev` + что известно:
  время, Duration, тело, MCS); слияние по TSF точки, кадр TX одного узла и синтетический RX другого — одно событие;
  калибровка точки метки и сдвига TSF по парам кадров; `to_cbap_log`/`to_bi_log` — кортежи судей cbap/bi.
- `air_judge.py` — судья над захватом: каждое правило модели, проверяемое по записанному (поля 9.x, Duration, MCS
  10.6.7, SIFS, продолжение TXOP, CF-End 10.23.2.10, доступ, BI, SLS), — проверено / нарушения с примерами и вердиктом
  (наше / трактовка модели / запись) / «не проверяемо» с причиной. `python3 -m ref.air_judge ap.pcap:AP sta.pcap:STA`
  `[--edca-from assoc_ap.pcap]`; при записях данных (`rxqos,txqos`) — Ack Policy, RD (10.29), окно BlockAck, Duration
  MPDU A-MPDU (9.7.3); с ассоциацией — тела кадров управления, ADDBA, EDCA Parameter Set → AIFSN и лимит TXOP.

Волна C (покрытие стандарта — `COVERAGE.md`: каждый DMG-пункт 9/10/11 со статусом модель/судья/нет/вне охвата):
- `nav.py` — несколько NAV (10.39.10, псевдокод буквально), виртуальный CS при нескольких NAV (10.3.2.1), сброс по
  NAVTimeout и CF-End, NAV_DTSCANCELABLE и конец SP (10.39.6.6.5); правила единого NAV DMG (10.3.2.4) и судья журнала
  узла `check_nav_log`.
- `beamtrack.py` — сопровождение луча (10.42.7): предел времени по табл. 10-31, условия запроса TRN-T, неудача и
  «опоздавший» ответ, обязанности ответчика (TRN-R на следующем PPDU с MCS > 0 в том же распределении, тип обратной
  связи), судья `check_bt_log`.
- `linkmaint.py` — поддержание направленной связи (11.27.1): согласование dot11BeamLinkMaintenanceTime (табл. 9-345),
  таймер связи с остановками (BTI, A-BFT, чужие SP/CBAP), события установки, судья `check_blm_log`.
- `air_judge` — правила `abft` (BIC по BI через abft.check_bic_sequence и кадры в объявленной A-BFT через
  abft.check_abft_log), `ati`, `assoc_state` (mlme.check_assoc_log: классы кадров 11.3.3, Disassociation 11.3.5.1),
  `brp_role` (10.42.3.1, 10.42.6.4.2–3), `nav_rx` (единый NAV узла по его RX-записям), `cts_self` (9.3.1.13),
  `blm` (11.27.1), `beam_track` (поле Beam Tracking Time Limit, табл. 10-31). Тесты правил — `test_air_judge_c.py`
  (журнал из событий, без pcap).

## Правила для каждого модуля
- Заголовок `# SPDX-License-Identifier: AGPL-3.0-or-later`, докстрока: охват (пункты) и что НЕ моделируется.
- Комментарии по-русски, у каждого правила — пункт/таблица/рисунок; цитаты из стандарта не длиннее строки.
- Тесты `test_<модуль>.py`: ожидания из текста стандарта (числа из таблиц и формул, примеры рисунков), не из кода.
- Только своя пара файлов; общие (`timing.py`, `__init__.py`, `cbap.py`) не править — нужное добавить в свой модуль
  и отметить «перенести в timing.py» в отчёте.
- Общие постоянные — только в `timing.py` (TU, табл. 11-22, MIB DEFVAL нескольких модулей, длины/TXTIME SSW-кадров,
  IFS и допуски, BRP-времена, aSSDuration/aSSSlotTime, пределы общих подполей, AID, коды AllocationType); модуль их
  импортирует и не определяет заново — это проверяет `test_consistency.py` (список `MODULES`: новый модуль добавить
  туда после сведения его постоянных; `medium.py` пока не сведён — свои MAX_SECTORS_PER_ANT/…_PER_STA).
- Спорное место: «СПОРНО:» в коде; если вопрос решается в двух модулях — одно решение здесь, в «Принятых
  трактовках», а в коде «СПОРНО → принято (PLAN.md №N)».

## Принятые трактовки

Норма — 802.11-2020; 802.11-2024 — для разрешения неоднозначностей (пункты 2024 на 1 меньше: 10.42 → 10.41).
Сводная проверка — `test_consistency.py`.

| № | Вопрос | Решение (модули) | Пункт | Почему (2020 / 2024) |
|---|---|---|---|---|
| 1 | FSS: число кадров или значение поля в aSSDuration/aSSSlotTime и в «no less than aSSFramesPerSlot» | Число кадров = поле + 1 везде; минимум — ≥ 4 кадров (поле ≥ 3) (bi, abft, fields; формулы — `timing.ss_*`) | 9.3.4.2, 10.42.5.2, табл. 11-22, рис. 10-75 | 2020: поле — «number of SSW frames allowed minus one», рисунок «value of FSS is 8» при 8 SSW (и «A-BFT LENGTH = 8» при 8 слотах — рисунок везде считает количества). 2024: тот же рис. 10-89; табл. 10-36 «Value of the FSS subfield» — сырое поле, но только для Short SSW (EDMG) |
| 2 | CDOWN «including any LBIFS if required» | LBIFS — одна передача (CDOWN −2 через LBIFS); альтернатива — `sls.slots_cdown(lbifs_in_cdown=False)` (sls, abft) | 10.42.2.2.2, 10.42.2.3.2, 10.3.2.3.11 | Текст 2020 = 2024. LBIFS = TXTIME(SSW) + 2·SBIFS — ровно один шаг сетки TXTIME(SSW)+SBIFS, поэтому «expected end time» по CDOWN вычислим из любого кадра |
| 3 | Total Sectors in ISS: поле = N или N − 1 (пример «set to 24») | Поле = N − 1, модель хранит N; альтернатива — `fields.total_sectors_raw_alt` (fields, sls) | 9.5.3, 10.42.2.2.1 | 9.5.3 «0 to 511, representing 1 to 512 sectors» — определение кодирования; пример называет количество. 2024 — оба текста без изменений |
| 4 | Допуски слота A-BFT на эфире | Одна формула aSSSlotTime (`timing.ss_slot_time`); первая SSW — [начало слота, +aAirPropagationTime]; последняя — до начала + aAirPropagationTime + aSSDuration; SSW-Feedback — [точка рис. 10-76, +MBIFS_TOL] (bi, abft) | 10.42.5.2, рис. 10-76, 10.3.2.3.10 | Стандарт (2020 = 2024) задаёт точку без допуска; слагаемое aAirPropagationTime «accounts for the propagation delay»; MBIFS — «−0% or +10%» |
| 5 | Конец BTI | Конец последнего DMG Beacon + его Duration; генераторы — запас 0, Duration через `duration.duration_dmg_beacon` (bi, abft, sls) | 10.42.5.1, 9.3.4.2 | «BTI is completed at the expiration of the value within the Duration field of the last DMG Beacon» — 2020 = 2024 |
| 6 | Округление SNR Report | К ближайшему шагу 0,25 дБ, половина — вверх, насыщение −13…50,75 дБ (`fields.snr_quantize`; sls вызывает его) | 9.5.3 | Округление не задано ни в 2020, ни в 2024; ранее sls округлял половину вниз, fields — вверх |
| 7 | TX Sector ID «set to 0x63» в 6-битном поле | 63 (все единицы) (fields, brp; `timing.TX_SECTOR_NOT_SWEPT`) | 9.5.4 | 0x63 = 99 не кодируется в 6 бит; 2024 — тот же текст |
| 8 | Допуск PIFS в DMG | Как SIFS/MBIFS: −0 … +10 %·(aSlotTime − aAirPropagationTime) (`timing.PIFS_TOL`; sls) | 10.3.2.3.4 | Не задан ни в 2020, ни в 2024 |
| 9 | CBAP Source при CBAP Only = 0 | Должен быть 0 (bi, fields; `fields.check_dmg_params(cbap_source_strict=False)` — мягкое чтение) | 9.4.1.46 | «valid only if the CBAP Only subfield is 1 … set to 1 to indicate that the AP or PCP has higher priority … set to 0 otherwise» — 2020 = 2024; без CBAP Only приоритета нет → «otherwise». Ранее fields не проверял |
| 10 | dot11MaxLostBeacons: DEFVAL или aMinBTIPeriod | 4 — одно значение (`timing.DOT11_MAX_LOST_BEACONS`) (bi, mlme) | 11.1.3.3.3, MIB | DEFVAL { 4 } и «A DMG AP shall set dot11MaxLostBeacons to … aMinBTIPeriod» (= 4) совпадают |
| 11 | «within dot11MaxBFTime beacon intervals» | N·BI от начала SLS/BRP (sls T2, brp `bf_brp_expired`) | 10.42.1 | Граница N-го TBTT требовала бы сетки BI; текст 2020 = 2024 |
| 12 | Переход младших 32 бит TSF (Allocation Start) | Ближайшее к опорному TSF значение / сравнение по модулю 2³² (разность < 2³¹ — «не раньше») (bi `full_tsf`, elements) | 9.4.2.131, 10.39.6.1 | Поле — «lower 4 octets of the TSF», о переходе текст молчит |
| 13 | Единицы постоянных табл. 11-22 | В мкс (aMaxBIDuration = aMinChannelTime = 1000 TU = 1 024 000 мкс); MIB-значения в TU — целые TU (bi, mlme) | 3.1, табл. 11-22 | Раньше mlme держал aMaxBIDuration в TU, bi — в мкс |
| 14 | LBIFS между SSW ответчика в A-BFT | Допустим при смене DMG-антенны (иначе — только SBIFS) — судья bi приведён к abft | 10.3.2.3.11, 10.42.2.3.2, 10.42.5.2 | 2020 = 2024; расхождение найдено сверкой генератора abft с судьёй bi |
| 15 | Порядок Service Hash / RSN Extension в Probe Response | RSN Extension — 92, после Service Hash (91) (elements) | табл. 9-39 (2020) / 9-69 (2024) | 2020: у обоих номер 91 (опечатка); 2024 исправляет на 91/92 — следуем уточнению |
| 16 | Точка метки TSF записи PMC в PPDU (захват стенда) | Метка TX = точка Timestamp DMG Beacon (на стенде Timestamp == метке TX у всех маяков) = начало символа данных с первым битом кадра: начало PPDU + T_STF + T_CE + T_header (SC) / + 40·32·Tc (control) (`air_pcap.PRE`); метка RX и сдвиг TSF второго узла — по парам кадров (air_pcap) | 11.1.3.1, 20.11.3 | Документации нет; промежутки внутри класса модуляции от выбора не зависят, control ↔ SC — ±0,75 мкс (`air_judge.PRE_UNCERT`); суммы SIFS двух узлов (`air_judge.sifs_sum`) не зависят ни от чего |
| 17 | Допуск сравнения времени в захвате | Номинал ± (1 мкс кванта меток + 0,25 мкс калибровки [+ 0,75 control ↔ SC]); средние по многим кадрам — без кванта (BTI: ±2/(n−1)) | 10.3.2.3.x | Метки TSF — целые мкс; допуски стандарта (SIFS +0,49, SBIFS +0,03) меньше кванта |
| 18 | BA Control B0 | Reserved — должен быть 0 (air_judge `ba_control`) | рис. 9-42, 9.2.2 | 2016: B0 — BA Ack Policy; 2020 и 2024 — Reserved |
| 19 | Duration DMG CTS: номинальный SIFS (9.3.1.13) или измеренный промежуток (9.2.5.7) | 9.3.1.13 — DMG-правило; разность с 9.2.5.7 — в info судьи (`dur_cts`) | 9.3.1.13, 9.2.5.7 | 9.2.5.7 — общее правило для CTS, 9.3.1.13 — частное для DMG CTS |
| 20 | Initiator в BRP после SLS: правило бита (10.42.6.4.1: 1, если «the previous received frame was not a BRP frame») или роль (10.42.3.1: в том же распределении «the SLS initiator is the beam refinement initiator») | Роль: ответчик SLS не шлёт BRP с Initiator = 1 в распределении SLS; правило бита — следствие роли (ответчик, не получивший BRP инициатора, ждёт, а не начинает свою транзакцию). «Распределение» в CBAP-only DTI — до следующего BTI (air_judge `brp_role`) | 10.42.3.1, 10.42.6.4.1–3, 9.4.2.129 | 2020 = 2024 (10.41.3.1). 10.42.6.4.2: «A beam refinement transaction starts with the beamforming initiator STA sending a BRP frame with the Initiator field set to 1» |
| 21 | Поиск таймера в NAV_TIMER_UPDATE: ветка «Ack \|\| NAVSRC(x)=R_DST» делает обратную пару недостижимой | Буквально (`nav.MultiNav(literal=True)`); `literal=False` — обратная пара совпадает (nav) | 10.39.10 | Текст 2020 = 2024 (10.38.10) |
| 22 | Исключение «DMG CTS с TA = свой — NAV не обновлять» при нескольких NAV | Только для единого NAV (10.3.2.4 — «DMG STAs that support a single NAV»); псевдокод 10.39.10 исключения не содержит (nav, air_judge `nav_rx` — единый NAV) | 10.3.2.4, 10.39.10 | 2020 = 2024 |
| 23 | A-BFT на эфире для судьи | BI с Next A-BFT = 0: начало — конец BTI (Duration последнего маяка, №5) + MBIFS (10.42.5.1), длина — (A-BFT Length + 1)·aSSSlotTime(FSS + 1) (№1); кадры в ней — abft.check_abft_log (air_judge `abft`) | 10.42.5.1, 10.42.5.2 | 2020 = 2024 |
| 24 | Вид синтетической RX-записи данных (FC по слоту парсера) для класса кадра | Тип Data → класс 3 в инфраструктуре при любом подтипе (11.3.3 c) 1)); подтип QoS Null — по длине 30 октетов (air_judge `assoc_state`) | 11.3.3 | Запись не несёт FC синтетических кадров (air_pcap) |
| 25 | Свой dot11BeamTrackingTimeLimit в табл. 10-31, если MIB не виден | = своему полю DMG STA Beam Tracking Time Limit (9.4.2.127.4: поле «contains the value of dot11BeamTrackingTimeLimit»), при 0/нет поля — DEFVAL 10 000 мкс (beamtrack, air_judge `beam_track`) | 9.4.2.127.4, табл. 10-31 | 2020 = 2024 |

Вопросы одного модуля (решение — в докстроке у «СПОРНО»): sls — момент старта ISS после Grant (чтение А), отсчёт
T1, Feedback в следующем распределении, слоты молчащих антенн, SSW-Ack после RXSS; abft — нет повторного прохода
для антенн инициатора в A-BFT, продолжение RSS только в A-BFT того же типа; bi — guard для непсевдостатичных
(D = BI), guard перед ATI, CBAP Only при одном CBAP в Extended Schedule, доступ non-AP при CBAP Source = 1,
broadcast-адресат SP, восстановление старших бит TSF; brp — BS-FBCK ≤ 63, ответ на кадр без запросов, MID через
SIFS или SBIFS, TRN-R единицами по 4, немедленный TRN-R после setup, ответ «филлером»; fields — BF Control в
Extended Schedule «but not both» буквально, повтор строк табл. 9-45, Dynamic Allocation Info 0…32 767; elements —
MCS 13/16 и 7/8, остаток Extended Schedule < 15 октетов, 
повтор элементов, AID при отказе, Multi-band в Authentication; mlme — Deauthentication по рис. 11-17, перевод
50 мс → TU вверх, Open System у DMG AP, PBSS BSSID, JOIN по DMG Beacon, «конфигурационные» коды статуса.
