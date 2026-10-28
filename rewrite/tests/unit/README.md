# Юнит-тесты uc/fw (без стенда)

```sh
ARC_DIR=<тулчейн> python3 -m pytest tests/unit          # сборка uc.elf во временный каталог + тесты
SPARRAW_UNIT_BUILD=build python3 -m pytest tests/unit   # без пересборки — готовый каталог сборки
python3 -m pytest tests -m unit                          # в составе общего прогона
```

Функция uc исполняется в эмуляторе ARC (`tools/arcemu/cpu.py`) прямо из `uc.elf`: DCCM — по настоящим адресам,
начальные данные — из ELF. Обвязка `ucemu.py`:

- `uc.call('fn', *args, stub={'callee': r0})` — вызов до возврата; заглушка не исполняет callee;
- `uc.ext[n]` — значение чтения r32..r56 (порты MAC; число или `callable(n, k)` по номеру чтения); по умолчанию
  MAC «свободен» — все циклы опроса готовности выходят сразу;
- `uc.mac_cmds` — команды MAC (запись r32) за вызов; `uc.r8/r16/r32/w*/rbytes/wbytes` — DCCM;
- вечное ожидание (2000 чтений одного регистра в одной точке) — сразу ошибка с функцией и регистром.

Правило: эталон в тесте — текст 802.11-2020 (поля разбираются из байт кадра по рисункам стандарта, пункт — в
docstring), а не наш код и не vendor. Тест проверяет итог сценария (кадр, команды MAC, состояние станции), а
цепочки функций — целиком: ошибки состояния между функциями пофункциональная сверка (`tools/arcemu/eqcheck.py`)
не видит.

| файл | что |
|---|---|
| `test_uc_brp_frame.py` | BRP-кадр инициатора: BRP Request (9.5.4), DMG Beam Refinement (9.4.2.129), TRN-R по запросу пира |
| `test_uc_brp_chain.py` | SSW-Feedback/SSW-Ack пира → запрос BRP-RX → наш BRP-кадр; резерв L-RX 17..31, MID/BC, чужой TA |
| `test_uc_sls_sweep.py` | SSW ISS/RSS (9.3.1.15, поле SSW 9.5.1): CDOWN/Sector ID/Direction, Duration при 1..64 секторах и повторах по антеннам (LBIFS), SSW Feedback ISS/не-ISS (9.5.3), SNR Report |
| `test_uc_sls_feedback.py` | SSW-Feedback/SSW-Ack (9.3.1.16/17), Feedback AP в A-BFT, приём развёртки → лучший сектор → обратная связь, SSW станции в A-BFT (10.42.5.2: FSS, CDOWN, Duration до конца слота) |
| `test_uc_beacon_tx.py` | DMG Beacon AP (9.3.4.2): BI Control (A-BFT Length, FSS, IsResponderTXSS, CC/Discovery, PCP Association Ready B43, Next A-BFT, A-BFT Count), развёртка 1..64 секторов, Duration до конца BTI |
| `test_uc_beacon_rx.py` | приём маяка станцией: участие в A-BFT (Next A-BFT, длина, FSS), выбор слота, Discovery Mode (10.42.5.1), пропуск aMaxABFTAccessPeriod |
| `test_uc_beacon_abft_resp.py` | маяк → ответ в A-BFT (10.42.5.2): FSS+1 SSW, CDOWN, Duration до конца слота, IsResponderTXSS |
| `test_uc_ifs_mac.py` | IFS в MAC (табл. 20-30, 10.3.2.3): SIFS/slot/PIFS/MBIFS/RIFS/SBIFS в тактах 165 МГц, таймауты ответа |
| `test_uc_ifs_sls_phases.py` | IFS по фазам SLS/BRP: MBIFS только где нужен, после BF всегда SIFS |
| `test_uc_ifs_duration.py` | Duration SSW/SSW-Feedback/SSW-Ack/Grant Ack/CF-End (9.2.5.1 округление вверх), CDOWN с LBIFS |
| `test_uc_nav_update.py` | NAV по Duration (10.3.2.4): длиннее/короче, 0, ≥ 32768, CF-End, DMG Beacon |

`xfail(strict=True)` — найденное отклонение от стандарта (пункт и место в коде — в reason); после исправления
кода тест начинает проходить и strict-xfail падает — пометку снять.
| `test_uc_liveness.py` | живучесть ожиданий ответа пира при его молчании (модель GP0..GP2 по командам 0x4f/0x52/0x49): CTS/Ack/ответ TXOP — CTSTimeout/AckTimeout (10.3.2.9, 10.3.2.11), BRP-запрос — BRPIFS (10.3.2.3.9), SLS в DTI — RSS, повторы Feedback ≤ dot11BFRetryLimit (10.42.2, 10.42.6.2), ожидание Feedback ответчиком, слот A-BFT AP |
| `test_uc_bti_rx_entry.py` | живучесть: вход в BTI с пути приёма — ожидание следующего маяка не дольше конца BTI (Duration, 9.3.4.2), заворот Timer1 |

Timer1 (COUNT1, AUX 0x100) в эмуляторе идёт: такт на инструкцию, заворот на 0x13ab6680 (`uc.t1()`, `uc.t1_base`).
Цикл, читающий Timer1, считается ограниченным сроком; ожидание события пира без срока даёт `SpinError` — так
тест живучести и ловит «вечное ожидание».

## Два класса тестов времени: «вечное ожидание» и «срок»

| класс | что ловит | как | файлы |
|---|---|---|---|
| **вечное ожидание** (живучесть) | ожидание события MAC/пира без ограничения: при молчании пира или железа uc висит | ожидание исполняется (не заглушка), событие не приходит; > 2000 чтений одного r32..r56 в одной точке — `SpinError` с функцией и регистром; ожидание, ограниченное Timer1/GP-таймером, должно выйти не позже срока стандарта | `test_uc_liveness.py`, `test_uc_bti_rx_entry.py` |
| **срок** (deadline, бюджет тактов) | путь конечен, но от события до команды-действия дольше, чем дают стандарт и железо | функция ведётся по худшей ветке; точка события — чтение регистра события, выпустившее ожидание; действие — команда MAC (r32) или запись MMIO; такты между ними — по модели стоимости ARC600 | `test_uc_deadlines.py` |

**Правило запаса (срок).** Путь проходит, если `W ≤ B − max(MARGIN_PCT·B, MARGIN_FLOOR_CLK)`, `MARGIN_PCT = 0,20`,
`MARGIN_FLOOR_CLK = 100` (≈ 0,6 мкс: разброс задержки очереди команд MAC 0,55 мкс + aAirPropagationTime 0,1 мкс +
дрожание выхода из опроса r42); константы — в одном месте, `test_uc_deadlines.py`. `B` — срок: интервал стандарта
минус документированная задержка железа (источник — в docstring и сообщении теста), `W` — худший путь по модели.
Не прошедший правило путь — `xfail(strict=True)`, в reason — путь, W, B, источник B, фактический и требуемый запас.
`-s` печатает для каждого пути W, B и запасы.

**Модель стоимости** (`COST` в `test_uc_deadlines.py`; эмулятор считает инструкции, `Meter` — такты по шагам):
1 такт на инструкцию (и delay-слот); +1 на 8-байтную инструкцию (limm, выборка 32 бит/такт); взятый
переход/вызов/возврат +2 (+1 с `.d`), возврат zero-overhead loop — 0 (PRM ARCompact гл. 8, «ARC 600 Loop Operation»);
загрузка из памяти +1 (load-use); чтение порта MAC r33..r63 +1; команда MAC (запись r32) +2; чтение MMIO (AHB) +8,
запись MMIO +2 (последние три — допущения, не измерены). Ожидания железа (MTP, подтверждения) эмулятор проходит за
один опрос — W только программная часть. Калибровка по стенду (`test_cost_model_calibration_abft_sta`): A-BFT
станции, событие слота → 0x19: модель 505 / стенд 531 тактов; SIFS_CNT → 0x19: 449 / 431–436 (≈ 1,64 такта на
инструкцию).

| файл | что |
|---|---|
| `test_uc_deadlines.py` | сроки: A-BFT станции (событие слота → первый SSW, сторож SIFS_CNT → SSW, SSW → SSW через SBIFS, взвод GP0 в окне GP2, фаза GP1 поздней ветки), A-BFT AP (сетка до триггера, SSW-Feedback после сторожа), ответы через SIFS (Ack/BA/BAR/DMG CTS/CF-End/Grant Ack, продолжение TXOP, РЧ на приём после ответа), SLS через MBIFS (SSW-Ack, RSS после ISS, 64 сектора), итерация цикла метрик TRN BRP, развёртка 64 маяков через SBIFS, слот CBAP → пуск TX, калибровка модели |
