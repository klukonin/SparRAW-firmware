# Автоматы состояний `basic_sm`

Все автоматы прошивки и микрокода обеих версий построены на одном движке
`basic_sm`: таблица переходов «состояние × событие → обработчик + следующее
состояние» в данных и массивы имён состояний и событий (вендорские строки
прошивки). Документ описывает движок и описатель, инвентарь автоматов 4.1, 6.2
и сборки UBNT, а также обработчики переходов. Метки версий: **[4.1]**,
**[6.2]**, **[обе]**. Переходы в таблицах — **[код]**-факт таблиц переходов.

Полные выгрузки таблиц: `4.1/ref/SM-TABLES.txt`, `4.1/ref/SM-TABLES-UC.txt`,
`6.2/ref/SM-TABLES.txt`, `6.2/ref/SM-TABLES-UC.txt`. Классы C++, реализующие
автоматы, — [FW-OBJECTS.md](FW-OBJECTS.md#3-карточки-классов-62).

## 1. Движок

### Таблица переходов **[обе]**
Запись — **5 байт**: 4 байта обработчика и байт следующего состояния.
Индекс ячейки = `состояние + событие * число_состояний`.

| | 4.1 | 6.2 |
|---|---|---|
| установка автомата | `basic_sm__setup` fw 0x8d6478 (40 Б), `uc_basic_sm__setup` uc 0x928174 (32 Б) | `basic_sm__bind_descriptor` fw 0x8d94e0 (16 Б), `basic_sm__bind_descriptor_uc` uc 0x92af0c (20 Б) |
| параметры setup | r0…r7: `(obj, имя, нач. состояние, таблица, имена_событий, n_событий, имена_состояний, n_состояний)` | адрес описателя в r1 |
| где хранятся таблица и имена | пишутся прямо в объект автомата | в отдельном описателе в данных |
| 4 байта обработчика в записи | адрес обработчика | смещение обработчика от базы сегмента кода |
| имена автоматов | массив указателей 0x800150…0x8001d8 | имён нет; имя выводится (см. ниже) |
| обработчик «недопустимое событие» | `basic_sm__error_handler` (fw), `basic_sm__assert_bad_event_uc` uc 0x925214 | — |
| общий пустой обработчик | `stub_ret_8db264`, `stub_ret_8db260` | `sm__action_nop` 0x8df510 (таблицы указывают на 0x8df514 внутри блока) |

### Объект автомата ucode **[4.1, код]**
По `basic_sm__dispatch_loop` 0x9287ec:

| смещ. | поле |
|---|---|
| +0x00 | текущее состояние |
| +0x02 | число состояний |
| +0x04 | флаг повторного перехода |
| +0x08…+0x14 | событие и аргументы |
| +0x18 | таблица переходов |

Цикл диспетчера — не более 20 переходов подряд, затем аварийная остановка.

### Объект автомата **[4.1]**
По `rm_sm` (0x80641c), сверено с живым дампом ([4.1/docs/STRUCTS.md](../4.1/docs/STRUCTS.md), раздел 3):

| смещ. | значение в `rm_sm` | смысл |
|---|---|---|
| +0x18 | 0x802b24 | таблица переходов |
| +0x1c | 0x8015c4 | имена состояний |
| +0x20 | 0x801594 | имена событий |
| +0x28 | 1 | — |
| +0x2c | 0x80640c | llist владельца |
| +0x30 | 0x8063f4 | владелец (`radio_mgr`) |

Вложенный автомат (`rm_chan_sw_sm`) лежит внутри объекта родителя
(`rm_sm+0x34`, его таблица 0x802c8c — по 0x806468).

### Описатель **[6.2]**
20 байт; таблица переходов обычно идёт сразу за описателем
(шаг между соседними описателями = 0x14 + таблица, выровненная до 4).

| смещение | поле |
|---|---|
| +0 (u8) | число **событий** |
| +1 (u8) | число **состояний** |
| +2 (u8) | начальное состояние |
| +4 | адрес таблицы переходов |
| +8 | массив указателей на имена состояний |
| +12 | массив указателей на имена событий |

Перестановка +0/+1 проходит без сбоя разбора, но даёт неверные пары
«событие в состоянии»; внешний признак — массив имён состояний продолжается
именами событий. Контрольный автомат — `mlme_sm` (описатель 0x802458):
14 событий и ровно 3 состояния UNASSOCIATE/ASSOCIATE/ASSOCIATED.

**Имя автомата в 6.2** — общий префикс имён состояний, а при его отсутствии —
голосование по уже названным обработчикам, из которого исключены обработчики,
стоящие у нескольких автоматов (пустая заглушка, «неожиданное событие»).
Совпадающие имена различаются адресом описателя (`ps_sm_801bec`).

### Метод
Скан описателей по формату `{u8 ne, u8 ns, u16, u32 trans, u32 state_names,
u32 event_names}` (6.2 и UBNT) или вызовов `basic_sm__setup` / `uc_basic_sm__setup` (4.1) →
разбор таблицы → пары «событие в состоянии → обработчик, следующее
состояние». Если запись таблицы указывает внутрь блока, в выгрузке стоит
пометка «не начало блока!» — это граница блока, требующая исправления, или
общий обработчик. Инструмент выгрузки 4.1 — `sm_tables.py`.

## 2. Инвентарь автоматов

4.1: 21 автомат в fw + 1 в ucode. 6.2: 24 в fw + 1 в ucode. Автоматы
сопоставлены по размерности и именам состояний/событий. Адреса 6.2 —
линкерные (0x80xxxx); в сравнении с UBNT те же описатели фигурируют как
0x90xxxx (на 0x100000 выше).

| 4.1 имя | 4.1 init | 4.1 trans | 4.1 события × n | 4.1 состояния × n | 6.2 имя | 6.2 описатель | 6.2 сост. × соб. | 6.2 старт | 6.2 setup из | UBNT |
|---|---|---|---|---|---|---|---|---|---|---|
| LM_MAIN_SM | `lm_main_sm__init` 0x8d58c8 | 0x802690 | 0x8012c0 ×12 | 0x8012f0 ×7 | `lm_sm` | 0x802da0 | 7×12 | LM_STATE_IDLE | 8d8b3e | есть |
| PCP_PSC_SM | `pcp_psc_sm__init` 0x8d5924 | 0x801b4c | 0x800ac8 ×6 | 0x80048c ×2 | `pcp_psc_sm` | 0x801eac | 2×6 | IDLE | 8d8b7e | **нет** |
| PS_MODE_SM | `ps_mode_sm__init` 0x8d596c | 0x801a0c | 0x800a74 ×6 | 0x800a8c ×8 | `sm_801d64` | 0x801d64 | 8×6 | AM | 8d8ba4 | **нет** |
| RADIO_MANAGER_MAIN_SM | `radio_manager_main_sm__init` 0x8d59b8 | 0x802b24 | 0x801594 ×12 | 0x8015c4 ×6 | `rm_sm` | 0x803210 | 6×12 | RM_ST_IDLE | 8d8c44 | есть |
| STA_PSC_SM | `sta_psc_sm__init` 0x8d5a0c | 0x801b04 | 0x800aac ×7 | 0x800484 ×2 | `sta_psc_sm` | 0x801f08 | 2×7 | IDLE | 8d8c66 | **нет** |
| PS_ASSOC_SM | `ps_assoc_sm__init` 0x8d5ad4 | 0x801900 | 0x800a24 ×5 | 0x800a38 ×4 | `ps_sm_801c30` | 0x801c30 | 4×5 | PS_DISABLED | 8d8d12 | **нет** |
| CONN_MSM | `conn_msm__init` 0x8d5b1c | 0x802008 | 0x801050 ×11 | 0x80107c ×9 | `conn_main_sm` | 0x802744 | 9×11 | UNRESOURCED | 8d8d44 | есть |
| LINK_STATS_SM | `link_stats_sm__init` 0x8d5bcc | 0x802834 | 0x80133c ×6 | 0x8004bc ×2 | `sm_802f58` | 0x802f58 | 2×6 | IDLE | 8d8dce | есть |
| BA_TD_subSM | `ba_td_subsm__init` 0x8d5c4c | 0x802568 | 0x801148 ×4 | 0x801158 ×3 | `wait_sm` | 0x802ba0 | 3×4 | WAIT_FOR_START | 8d8e2e | есть |
| PS_NONASSOC_SM | `ps_nonassoc_sm__init` 0x8d5c7c | 0x8018d0 | 0x800a0c ×3 | 0x800a18 ×3 | `ps_sm_801bec` | 0x801bec | 3×3 | PS_DISABLED | 8d8e3e | **нет** |
| CALIB_ENGINE | `calib_engine__init` 0x8d5cc4 | 0x801d20 | 0x800db4 ×6 | 0x800dcc ×4 | `sm_802234` **[гипотеза]** по размерности | 0x802234 | 4×6 | IDLE | 8d8e72 | см. замечания |
| RM_CHAN_SW_SM | `rm_chan_sw_sm__init` 0x8d5d48 | 0x802c8c | 0x8015dc ×7 | 0x8015f8 ×3 | `rm_ch_switch_sm` | 0x80338c | 3×7 | IDLE | 8d8ebc | есть |
| PCIE_DEVICE_POWER_SM | `pcie_device_power_sm__init` 0x8d6050 | 0x801964 | 0x800a48 ×6 | 0x800a60 ×5 | `pcie_device_power_sm` | 0x801ca8 | 5×6 | D0 | 8d910a | **нет** |
| BA_SM | `ba_sm__init` 0x8d61f0 | 0x8022cc | 0x8010bc ×12 | 0x8010ec ×5 | `ba_sm` | 0x80296c | 5×12 | NOT_BA_AGR_STATE | 8d9254 | есть |
| RF_KILL_SM | `rf_kill_sm__init` 0x8ecf84 | 0x801e10 | 0x800f4c ×4 | 0x800f5c ×3 | `sm_802338` (RF management) | 0x802338 | 3×4 | ENABLED | 8d8bca | есть |
| BA_SETUP_SM | `ba_setup_sm__init` 0x8ed0d0 | 0x802400 | 0x801100 ×12 | 0x801130 ×6 | `ba_setup_sm` | 0x802b50 | **7×13** | WAIT_FOR_START_STATE | 8f5296 | есть (0x90270c) |
| MAINTAIN_SM | `maintain_sm__init` 0x8ed114 | 0x80287c | 0x801388 ×10 | 0x8013b0 ×4 | `maintain_sm` | 0x802cc4 | 4×10 | STOPPED | 8f52ca | есть |
| DISCONN_SM | `disconn_sm__init` 0x8ed188 | 0x8021f8 | 0x8010a0 ×7 | 0x8004b4 ×2 | `sm_8027a0` | 0x8027a0 | 2×7 | INITIAL | 8f531c | есть |
| FIND_MAIN_SM | `find_main_sm__init` 0x8ed1c0 | 0x802a5c | 0x801440 ×7 | 0x80145c ×5 | `state_sm_8030f4` | 0x8030f4 | 5×7 | STATE_IDLE | 8f533a | есть |
| CHANNELS_SWITCH_SM | `channels_switch_sm__init` 0x8ed244 | 0x802944 | 0x8013f8 ×8 | 0x801418 ×7 | `state_sm_802fb4` | 0x802fb4 | 7×8 | STATE_IDLE | 8d9068 | есть |
| MLME_SM | `mlme_sm__init` 0x8ed454 | 0x801f6c | 0x801020 ×9 | 0x801044 ×3 | `sm_802458` (`mlme_sm`) | 0x802458 | 3×**14** | UNASSOCIATE | 8f56b2 | есть (0x90201c) |
| — | — | — | — | — | `state_sm_8030e0` (`swc_psc_sm`, скан под PS) | 0x8030e0 | 3×4 | STATE_SCAN_IDLE | 8c17a6 | см. замечания |
| — | — | — | — | — | `state_sm_803424` (сеанс FTM) | 0x803424 | 3×9 | STATE_READY | 8f53c6 | см. замечания |
| — | — | — | — | — | `state_sm_8034c0` (`ftm_main_sm`) | 0x8034c0 | 5×8 | STATE_IDLE | 8f52ae | см. замечания |
| BI_AP_MONITOR_SM (uc) | `bi_ap_mon__init` uc 0x928130 | 0x800adc | 0x800b40 ×5 | 0x800b54 ×4 | `bi_sm` (uc) | 0x801adc | 4×5 | BI_STATE_DTI | uc 92aec4 | — |

Различия версий:
* **MLME_SM**: 9 событий в 4.1, 14 в 6.2.
* **BA_SETUP_SM**: 6 состояний × 12 событий в 4.1, 7 × 13 в 6.2. В 4.1 имена
  состояний `ADDBAREQ_CHECKING_MAX_RETRY_STATE` и `WAIT_ADDBAREQ_SENT_STATE`
  слиты в одну строку `ADDBAREQ_CHECKING_MAX_RETRY_STATEWAIT_ADDBAREQ_SENT_STATE`;
  безымянные индексы выводятся как `ST5`, `EVT11`.
* В 6.2 добавлены `swc_psc_sm`, сеанс FTM и `ftm_main_sm`.

### Состояния и события (6.2 = 4.1, если не указано иное)
- **MLME_SM** — states `0=UNASSOCIATE, 1=ASSOCIATE, 2=ASSOCIATED`; events
  `0=CONNECT, 1=DISCONNECT, 2=DISASSOCIAT, 3=ASSOC_RESPONSE_START,
  4=ASSOC_RESPONSE, 5=ASSOC_REJECT, 6=ASSOC_TIMEOUT, 7=RM_CHANNEL_LOCKED,
  8=DATA_PORT_OPEN, 9=WAITFOR_CTRL_ASSOC_RES, 10=CTRL_ASSOC_RESPONSE_RET,
  11=CTRL_NEW_STA, 12=WAITFOR_CTRL_DEL_STA, 13=CTRL_DEL_STA` (6.2).
- **BA_SETUP_SM** (полный ADDBA-автомат; BA_SM 5×12 — отдельный,
  уровня соглашения) — states `WAIT_FOR_START, WAIT_FOR_PERMIT,
  ADDBAREQ_CHECKING_MAX_RETRY, WAIT_ADDBAREQ_SENT, WAIT_FOR_ADDBARSP,
  ABORT_PENDING, WAIT_FOR_VRING_STOP`; events START, READY_TO_RUN,
  VRING_STOPPED, TX_PERMITTED, ADDBAREQ_TX_COMPLETE/FAILED,
  ADDBARSP_TIMEOUT/ARRIVED, ACCEPT/DISCARD_RECEIVED_ADDBARSP,
  MAX_RETRY_TH_PASS, BA_SETUP_GLOBAL_TIMEOUT, ABORT (6.2).
- **PS_MODE_SM** — states `AM, AM_PENDING_WEB, WEB, WEB_PENDING_SOB, SOB,
  SOB_PENDING_WEB, WEB_PENDING_AM, SOB_PENDING_AM`; events `INCREASE_PS,
  DECREASE_PS, PSC_AGREED, PSC_REJECTED, ABORT, DISABLE_PS`.
- **PCP_PSC_SM** / **STA_PSC_SM** — PCP- и STA-сторона согласования PSC.
- **PS_NONASSOC_SM** — `PS_DISABLED/PS_ALLOWED/PS_REENTER`; ev
  `PS_ENABLE/PS_DISABLE/PS_SLEEP_EXIT`.
- **PS_ASSOC_SM** — те же + `PS_NOT_ALLOWED`; ev + `DEEP_SLEEP_EXIT,
  SHALLOW_SLEEP_ENTER/EXIT`.
- **PCIE_DEVICE_POWER_SM** — `D0, PENDING_D3_HOT, D3_HOT, D3_COLD,
  D0_UNINITIALIZED`; ev `TRAFFIC_DEFERRAL, D0_D3_INT, PERST_ASSERT/DEASSERT,
  D3_D0_INT, TRAFFIC_RESUME`.
- **RF_KILL_SM** / `sm_802338` — события W_ENABLE/W_DISABLE =
  `WMI_RF_MGMT_W_*`, статус хосту шлёт `low_sme__send_rf_mgmt_status`
  (к `channels_switch_sm` отношения не имеет).

## 3. Подсистема энергосбережения

Шесть автоматов — PS_MODE_SM, PCP_PSC_SM, STA_PSC_SM, PS_NONASSOC_SM,
PS_ASSOC_SM, PCIE_DEVICE_POWER_SM — образуют слой DMG power management:
режимы `AM` / `WEB` / `SOB`, протокол согласования PSC в ролях PCP и STA,
PS в ассоциированном и неассоциированном состоянии, PCIe D-states. Слой
присутствует в 4.1 и 6.2 (лог-строки `POWER_MNGR::`, `ps_assoc_mgr::`,
`PS_CONNECTION::assoc_ntf/disassoc_ntf`, `psc_if::psc_req_tx_wb_cb`,
`ps_connection::psc_complete`); классы — `PS_CONNECTION`, `psc_if`,
`sta_psc_sm`, `PS_CFG_SCHEME`, `POWER_MNGR` ([FW-OBJECTS.md](FW-OBJECTS.md)).

## 4. Сборка UBNT: сравнение инвентаря

Скан описателей в сборке UBNT даёт **17** автоматов против **23**
дескрипторов того же скана в 6.2. 17 имеют точное соответствие (diff графа
≤ 2, в основном 0), в том числе:

| автомат | UBNT | 6.2 (адрес скана) | diff |
|---|---|---|---|
| MLME_SM 3×14 | 0x90201c | 0x902458 | 0/42 |
| BA_SETUP_SM 7×13 | 0x90270c | 0x902b50 | 0/91 |

Шесть автоматов power-save (раздел 3) в UBNT отсутствуют: у четырёх из них
размерности в UBNT не встречаются вовсе, у двух размерности есть, но графы не
совпадают (diff 8 и 4).

| 6.2 (адрес скана) | автомат | dims |
|---|---|---|
| 0x901d64 | PS_MODE_SM | 8×6 |
| 0x901eac | PCP_PSC_SM | 2×6 |
| 0x901f08 | STA_PSC_SM | 2×7 |
| 0x901bec | PS_NONASSOC_SM | 3×3 |
| 0x901c30 | PS_ASSOC_SM | 4×5 |
| 0x901ca8 | PCIE_DEVICE_POWER_SM | 5×6 |

Сборка MikroTik (образ 6.2) ближе к референсной прошивке: своих
WMI-команд не добавляет (0 шт.) и сохраняет стандартные power-save автоматы;
UBNT их удаляет и добавляет проприетарное (`WMI_WBE_LINKDOWN` для GBE-бэкхола,
`WMI_EAPOL_RX` offload) — см. [WMI.md](WMI.md).

## 5. Обработчики переходов **[6.2]**

Для каждого блока — все пары «событие в состоянии → новое состояние», где он
указан обработчиком. Блок, обслуживающий переходы нескольких автоматов, —
общий (`sm__action_nop`). Разбор смысла — [MLME.md](MLME.md), [RADIO-MANAGER.md](RADIO-MANAGER.md),
[L2-MANAGER.md](L2-MANAGER.md), [ROLELESS-LINK.md](ROLELESS-LINK.md), [6.2/docs/MISC-FW.md](../6.2/docs/MISC-FW.md).
Перечислены блоки, не разобранные в тематических документах; полные таблицы —
`6.2/ref/SM-TABLES.txt`.

**ps_sm_801bec** — PS неассоциированный

| адрес | блок | переходы |
|---|---|---|
| 0x8e1308 | `ps_sm_801bec__on_ps_disable_in_ps_reenter` | PS_DISABLE в PS_REENTER -> PS_DISABLED |
| 0x8e1698 | `ps_sm_801bec__action_8e1698` | PS_SLEEP_EXIT в PS_REENTER -> PS_REENTER |

**ps_sm_801c30** — PS ассоциированный

| адрес | блок | переходы |
|---|---|---|
| 0x8e12e4 | `PS_ASSOC_SM__ps_cancel_schd_reenter` | PS_ENABLE в PS_REENTER -> PS_ALLOWED; PS_DISABLE в PS_REENTER -> PS_DISABLED; PS_SHALLOW_SLEEP_EXIT в PS_REENTER -> PS_NOT_ALLOWED |
| 0x8e1574 | `ps_sm_801c30__action_8e1574` | PS_DEEP_SLEEP_EXIT в PS_ALLOWED -> PS_REENTER |
| 0x8e1688 | `ps_sm_801c30__action_8e1688` | PS_DEEP_SLEEP_EXIT в PS_REENTER -> PS_REENTER |

**pcie_device_power_sm** — `pcie_device_power_sm`

| адрес | блок | переходы |
|---|---|---|
| 0x8e075c | `pcie_device_power_sm__pcie_traffic_resume_req_8e075c` | D3_D0_INT в D3_HOT -> D0; TRAFFIC_RESUME в PENDING_D3_HOT -> D0; TRAFFIC_RESUME в D0_UNINITIALIZED -> D0 |

**sm_801d64** — `ps_mode_sm` (AM/WEB/SOB)

| адрес | блок | переходы |
|---|---|---|
| 0x8c81e4 | `sm_801d64__action_8c81e4` | PSC_AGREED в AM -> AM |
| 0x8c81f0 | `sm_801d64__action_8c81f0` | INCREASE_PS в SOB_PENDING_WEB -> SOB_PENDING_WEB; INCREASE_PS в WEB_PENDING_AM -> WEB_PENDING_AM; INCREASE_PS в SOB_PENDING_AM -> SOB_PENDING_AM |
| 0x8c81fc | `sm_801d64__action_8c81fc` | PSC_REJECTED в AM -> AM |
| 0x8e1744 | `sm_801d64__action_8e1744` | DECREASE_PS в WEB -> WEB_PENDING_AM; DISABLE_PS в WEB -> WEB_PENDING_AM; DISABLE_PS в SOB -> SOB_PENDING_AM |
| 0x8e175c | `sm_801d64__action_8e175c` | INCREASE_PS в WEB -> WEB_PENDING_SOB |

**pcp_psc_sm** — `pcp_psc_sm`

| адрес | блок | переходы |
|---|---|---|
| 0x8c69d0 | `pcp_psc_sm__action_8c69d0` | CLOSE в ACTIVE -> IDLE |
| 0x8e1910 | `pcp_psc_sm__psc_done` | RECEIVED_DPM0 в IDLE -> IDLE; RECEIVED_DPM0 в ACTIVE -> IDLE; PSC_RSP_TX_COMPLETE в ACTIVE -> IDLE |
| 0x8e1c14 | `pcp_psc_sm__psc_start_flow_8e1c14` | RECEIVED_DPM1 в IDLE -> ACTIVE |
| 0x8e5d90 | `pcp_psc_sm__send_usol_psc_resp_sm_8e5d90` | SWITCH_STA_TO_ACTIVE в IDLE -> ACTIVE |

**sta_psc_sm** — `sta_psc_sm`

| адрес | блок | переходы |
|---|---|---|
| 0x8c318c | `sta_psc_sm__action_8c318c` | AGREED в ACTIVE -> IDLE |
| 0x8c69d4 | `sta_psc_sm__action_8c69d4` | CLOSE в ACTIVE -> IDLE |
| 0x8ddd30 | `sta_psc_sm__max_retry_handler_8ddd30` | MAX_RETRY в ACTIVE -> IDLE |
| 0x8e19c0 | `sta_psc_sm__psc_req_tx_complete_8e19c0` | PSC_REQ_TX_COMPLETE в ACTIVE -> ACTIVE |
| 0x8e1c44 | `sta_psc_sm__psc_start_flow` | PSC_CMD в IDLE -> ACTIVE |
| 0x8ea864 | `sta_psc_sm__action_8ea864` | RECEIVED_UNSOLICITED в IDLE -> IDLE |

**sm_802338** — **RF management** (события W_ENABLE/W_DISABLE = `WMI_RF_MGMT_W_*`; шлёт `low_sme__send_rf_mgmt_status`) — не channels_switch

| адрес | блок | переходы |
|---|---|---|
| 0x8c6010 | `rf_mgmt_sm__action_8c6010` | W_ENABLE в DISABLED -> DISABLED; W_ENABLE в PENDING_DISABLED -> PENDING_DISABLED |
| 0x8e247c | `rf_mgmt_sm__action_8e247c` | W_DISABLE в DISABLED -> DISABLED |
| 0x8e248c | `rf_mgmt_sm__action_8e248c` | W_ENABLE в ENABLED -> ENABLED |
| 0x8eaaa8 | `rf_mgmt_sm__action_8eaaa8` | W_DISABLE в PENDING_DISABLED -> PENDING_DISABLED |

**sm_802458** — MLME ассоциации (`mlme_sm`)

| адрес | блок | переходы |
|---|---|---|
| 0x8c5cfc | `mlme_sm_802458__action_8c5cfc` | EVT_RM_CHANNEL_LOCKED в UNASSOCIATE -> UNASSOCIATE |
| 0x8c7e88 | `mlme_sm_802458__action_8c7e88` | EVT_CTRL_NEW_STA в UNASSOCIATE -> UNASSOCIATE |
| 0x8df510 | `sm__action_nop` | EVT_ASSOC_RESPONSE в ASSOCIATE -> ASSOCIATE; EVT_ASSOC_RESPONSE в ASSOCIATED -> ASSOCIATED; EVT_ASSOC_REJECT в ASSOCIATED -> ASSOCIATED |
| 0x8ec00c | `mlme_sm_802458__action_8ec00c` | EVT_WAITFOR_CTRL_DEL_STA в UNASSOCIATE -> UNASSOCIATE; EVT_WAITFOR_CTRL_DEL_STA в ASSOCIATE -> ASSOCIATE; EVT_WAITFOR_CTRL_DEL_STA в ASSOCIATED -> ASSOCIATED |
| 0x8f0eb4 | `mlme_sm__assoc_reject_ev_handle` | EVT_ASSOC_REJECT в UNASSOCIATE -> UNASSOCIATE; EVT_ASSOC_REJECT в ASSOCIATE -> UNASSOCIATE |
| 0x8f0f4c | `mlme_sm_802458__action_8f0f4c` | EVT_ASSOC_RESPONSE в UNASSOCIATE -> ASSOCIATE |
| 0x8f102c | `mlme_sm_802458__action_8f102c` | EVT_ASSOC_RESPONSE_START в UNASSOCIATE -> UNASSOCIATE |
| 0x8f1080 | `mlme_sm_802458__action_8f1080` | EVT_CONNECT в UNASSOCIATE -> UNASSOCIATE |
| 0x8f131c | `mlme_sm__association_timeout_ev_handle` | EVT_ASSOC_TIMEOUT в UNASSOCIATE -> UNASSOCIATE; EVT_ASSOC_TIMEOUT в ASSOCIATE -> UNASSOCIATE |
| 0x8f26a8 | `mlme_sm__disconnect_ev_handle_8f26a8` | EVT_CONNECT в ASSOCIATE -> UNASSOCIATE; EVT_CONNECT в ASSOCIATED -> UNASSOCIATE; EVT_DISCONNECT в UNASSOCIATE -> UNASSOCIATE |
| 0x8fb430 | `mlme_sm_802458__action_8fb430` | EVT_WAITFOR_CTRL_ASSOC_RES в UNASSOCIATE -> UNASSOCIATE |

**conn_main_sm** — главный автомат соединения

| адрес | блок | переходы |
|---|---|---|
| 0x8c475c | `conn_main_sm__action_8c475c` | SM_EVT_BCON_RX в WAIT_FOR_BCON_RX -> WAIT_FOR_LINKUP |
| 0x8c4804 | `conn_main_sm__bcon_rx_timeout_evt_8c4804` | SM_EVT_BCON_RX в KEY_ASSOC -> KEY_ASSOC |
| 0x8c4898 | `conn_main_sm__action_8c4898` | SM_EVT_NTF_LINKUP в READY_FOR_ASSOC -> READY_FOR_ASSOC |
| 0x8da6b0 | `conn_main_sm__action_8da6b0` | SM_EVT_NTF_KEY_INSTALLED в ASSOCIATED -> KEY_ASSOC |
| 0x8db038 | `conn_main_sm__action_8db038` | SM_EVT_NTF_LM_STARTED в WAIT_FOR_LM_START -> ASSOCIATED |
| 0x8df500 | `conn_main_sm__action_8df500` | SM_EVT_BCON_RX в UNRESOURCED -> UNRESOURCED; SM_EVT_OWN_DISC в READY_FOR_ASSOC -> READY_FOR_ASSOC; SM_EVT_OWN_DISC в WAIT_FOR_DISCONN -> WAIT_FOR_DISCONN |
| 0x8e2554 | `conn_main_sm__action_8e2554` | SM_EVT_NTF_LM_STARTED в WAIT_FOR_ASSOC_DONE -> WAIT_FOR_ASSOC_DONE |
| 0x8e2aac | `conn_msm__on_own_start_link__ready_for_assoc` | SM_EVT_OWN_START_LINK в WAIT_FOR_BCON_RX -> WAIT_FOR_BCON_RX; SM_EVT_OWN_START_LINK в WAIT_FOR_LINKUP -> WAIT_FOR_BCON_RX; SM_EVT_OWN_START_LINK в READY_FOR_ASSOC -> WAIT_FOR_BCON_RX |
| 0x8e797c | `conn_main_sm__start_disc_8e797c` | SM_EVT_OWN_DISC в UNRESOURCED -> WAIT_FOR_DISCONN; SM_EVT_OWN_DISC в WAIT_FOR_BCON_RX -> WAIT_FOR_DISCONN; SM_EVT_OWN_DISC в WAIT_FOR_LINKUP -> WAIT_FOR_DISCONN |
| 0x8e7a3c | `conn_main_sm__action_8e7a3c` | SM_EVT_OWN_START_LINK в UNRESOURCED -> WAIT_FOR_BCON_RX |

**sm_8027a0** — автомат разъединения (DISC SM, строки «DISC SM»)

| адрес | блок | переходы |
|---|---|---|
| 0x8f3314 | `mlme_sm_8027a0__action_8f3314` | SM_EVT_NTF_FW_TX_STOPPED в WAIT_FOR_DISC_DONE -> WAIT_FOR_DISC_DONE |
| 0x8f6230 | `mlme_sm_8027a0__action_8f6230` | SM_EVT_NTF_LMS_STOPPED в WAIT_FOR_DISC_DONE -> WAIT_FOR_DISC_DONE |
| 0x8f6b94 | `mlme_sm_8027a0__action_8f6b94` | SM_EVT_NTF_MLME_DISC_DONE в INITIAL -> INITIAL; SM_EVT_READY_FOR_FLUSH в INITIAL -> INITIAL |
| 0x8f9ca8 | `mlme_sm_8027a0__action_8f9ca8` | SM_EVT_NTF_SW_DATA_STOPPED в WAIT_FOR_DISC_DONE -> WAIT_FOR_DISC_DONE |

**ba_sm** — `ba_sm`

| адрес | блок | переходы |
|---|---|---|
| 0x8c3110 | `ba_sm__action_8c3110` | EVT_ADDBAREQ_TX_COMPLETE в BA_SETUP_STATE -> BA_SETUP_STATE; EVT_ADDBAREQ_TX_COMPLETE в WAIT_REMOVE_STREAM_STATE -> WAIT_REMOVE_STREAM_STATE |
| 0x8c3154 | `ba_sm__action_8c3154` | EVT_ADDBARSP_ARRIVED в BA_SETUP_STATE -> BA_SETUP_STATE |
| 0x8c4314 | `ba_sm__action_8c4314` | EVT_BA_SETUP_SUCCESS_NTF в BA_SETUP_STATE -> BA_AGREED_STATE; EVT_BA_SETUP_FAIL_NTF в BA_SETUP_STATE -> NOT_BA_AGR_STATE |
| 0x8c437c | `ba_sm__action_8c437c` | EVT_REMOVE_STREAM в BA_SETUP_STATE -> WAIT_REMOVE_STREAM_STATE |
| 0x8c438c | `ba_sm__action_8c438c` | EVT_BA_SETUP_SM_ABORT_DONE в WAIT_REMOVE_STREAM_STATE -> WAIT_REMOVE_STREAM_STATE |
| 0x8c4394 | `ba_sm__action_8c4394` | EVT_VRING_STOPPED в WAIT_REMOVE_STREAM_STATE -> NOT_BA_AGR_STATE; EVT_BA_TEARDOWN_DONE_NTF в BA_TEARDOWN_STATE -> NOT_BA_AGR_STATE |
| 0x8c8d5c | `ba_sm__action_8c8d5c` | EVT_DELBA_TX_COMPLETE в BA_TEARDOWN_STATE -> BA_TEARDOWN_STATE |
| 0x8e0d9c | `ba_sm__action_8e0d9c` | EVT_START_BA_SETUP в NOT_BA_AGR_STATE -> BA_SETUP_STATE |
| 0x8e0ddc | `ba_sm__prepare_ba_td_8e0ddc` | EVT_START_BA_TEARDOWN в BA_AGREED_STATE -> BA_TEARDOWN_STATE; EVT_REMOVE_STREAM в NOT_BA_AGR_STATE -> WAIT_REMOVE_STREAM_STATE; EVT_REMOVE_STREAM в BA_AGREED_STATE -> WAIT_REMOVE_STREAM_STATE |
| 0x8e21c4 | `ba_sm__action_8e21c4` | EVT_RCP_DELBA_ARRIVED в BA_TEARDOWN_STATE -> BA_TEARDOWN_STATE |
| 0x8e2a30 | `ba_sm__action_8e2a30` | EVT_RCP_DELBA_ARRIVED в BA_AGREED_STATE -> BA_TEARDOWN_STATE |
| 0x8e7938 | `ba_sm__action_8e7938` | EVT_VRING_STOPPED в BA_TEARDOWN_STATE -> BA_TEARDOWN_STATE |
| 0x8ea754 | `ba_sm__action_8ea754` | EVT_START_BA_SETUP в BA_SETUP_STATE -> BA_SETUP_STATE; EVT_START_BA_SETUP в BA_AGREED_STATE -> BA_AGREED_STATE; EVT_START_BA_SETUP в BA_TEARDOWN_STATE -> BA_TEARDOWN_STATE |
| 0x8ea780 | `ba_sm__action_8ea780` | EVT_START_BA_TEARDOWN в NOT_BA_AGR_STATE -> NOT_BA_AGR_STATE; EVT_START_BA_TEARDOWN в BA_SETUP_STATE -> BA_SETUP_STATE; EVT_START_BA_TEARDOWN в BA_TEARDOWN_STATE -> BA_TEARDOWN_STATE |
| 0x8ebfe8 | `ba_sm__action_8ebfe8` | EVT_VRING_STOPPED в BA_SETUP_STATE -> BA_SETUP_STATE |

**ba_setup_sm** — `ba_setup_sm`

| адрес | блок | переходы |
|---|---|---|
| 0x8f0aec | `ba_setup_sm__addba_req_sent` | EVT_ADDBAREQ_TX_COMPLETE в WAIT_ADDBAREQ_SENT_STATE -> WAIT_FOR_ADDBARSP_STATE |
| 0x8f0c54 | `ba_setup_sm__action_8f0c54` | EVT_BA_SETUP_GLOBAL_TIMEOUT в ADDBAREQ_CHECKING_MAX_RETRY_STATE -> WAIT_FOR_START_STATE; EVT_BA_SETUP_GLOBAL_TIMEOUT в WAIT_ADDBAREQ_SENT_STATE -> WAIT_FOR_START_STATE; EVT_BA_SETUP_GLOBAL_TIMEOUT в WAIT_FOR_ADDBARSP_STATE -> WAIT_FOR_START_STATE |
| 0x8f1a48 | `ba__retry_flow` | EVT_ADDBARSP_TIMEOUT в WAIT_FOR_ADDBARSP_STATE -> ADDBAREQ_CHECKING_MAX_RETRY_STATE |
| 0x8f7fdc | `ba_setup_sm__action_8f7fdc` | EVT_ADDBAREQ_TX_COMPLETE в ABORT_PENDING_STATE -> WAIT_FOR_START_STATE; EVT_ADDBAREQ_TX_FAILED в ABORT_PENDING_STATE -> WAIT_FOR_START_STATE; EVT_ABORT в ADDBAREQ_CHECKING_MAX_RETRY_STATE -> WAIT_FOR_START_STATE |
| 0x8f866c | `ba_setup_sm__action_8f866c` | EVT_TX_PERMITTED в ADDBAREQ_CHECKING_MAX_RETRY_STATE -> WAIT_ADDBAREQ_SENT_STATE |
| 0x8f95b0 | `scan_mngr__start_connection_cb` | EVT_ACCEPT_RECEIVED_ADDBARSP в WAIT_FOR_ADDBARSP_STATE -> WAIT_FOR_VRING_STOP_STATE |
| 0x8f99e4 | `ba_setup_sm__action_8f99e4` | EVT_READY_TO_RUN в WAIT_FOR_PERMIT_STATE -> ADDBAREQ_CHECKING_MAX_RETRY_STATE |

**wait_sm** — ожидание DELBA

| адрес | блок | переходы |
|---|---|---|
| 0x8e2b8c | `wait_sm__action_8e2b8c` | DELBA_TX_COMPLETE в WAIT_FOR_DELBA_TX_COMPLETE -> WAIT_FOR_START |
| 0x8e7cd4 | `wait_sm__action_8e7cd4` | READY_TO_RUN в WAIT_FOR_PERMIT -> WAIT_FOR_DELBA_TX_COMPLETE |

**maintain_sm** — `maintain_sm` (поддержание луча)

| адрес | блок | переходы |
|---|---|---|
| 0x8c48f8 | `maintain_sm__action_8c48f8` | EVT_BF_RESULTS в BEFORE_FIRST_FBF -> BEFORE_FIRST_FBF |
| 0x8c494c | `maintain_sm__action_8c494c` | EVT_BF_RESULTS в FBF_DONE -> FBF_DONE; EVT_BF_RESULTS в ACTIVE -> ACTIVE |
| 0x8c7348 | `maintain_sm__action_8c7348` | EVT_CONSECUTIVE_HIGH_PER в ACTIVE -> ACTIVE |
| 0x8cab64 | `maintain_sm__action_8cab64` | EVT_TIMER в FBF_DONE -> ACTIVE |
| 0x8cdbd8 | `maintain_sm__action_8cdbd8` | EVT_RS_RESULTS в ACTIVE -> ACTIVE |
| 0x8dcf84 | `maintain_sm__action_8dcf84` | EVT_TIMER в ACTIVE -> ACTIVE |
| 0x8e0004 | `maintain_sm__action_8e0004` | EVT_PAUSE в ACTIVE -> ACTIVE |
| 0x8e2520 | `maintain_sm__release_radio_after_bf_evt` | EVT_BF_RESULTS в STOPPED -> STOPPED |
| 0x8e2b9c | `maintain_sm__action_8e2b9c` | EVT_RESUME_MAINTAIN в ACTIVE -> ACTIVE |
| 0x8f2dc8 | `maintain_sm__fbf_failed` | EVT_SELF_FBF_FAIL в BEFORE_FIRST_FBF -> STOPPED |
| 0x8f2f0c | `maintain_sm__action_8f2f0c` | EVT_SELF_FIRST_FBF_SUCCESS в BEFORE_FIRST_FBF -> FBF_DONE |
| 0x8f96c4 | `maintain_sm__action_8f96c4` | EVT_START_MAINTAIN в STOPPED -> BEFORE_FIRST_FBF |
| 0x8f9a78 | `maintain_sm__action_8f9a78` | EVT_STOP в BEFORE_FIRST_FBF -> STOPPED; EVT_STOP в FBF_DONE -> STOPPED; EVT_STOP в ACTIVE -> STOPPED |

**lm_sm** — `lm_sm` (link maintain)

| адрес | блок | переходы |
|---|---|---|
| 0x8dab0c | `lm_sm__action_8dab0c` | LM_EVT_LINK_LOST в LM_STATE_WAIT_MAINTAIN -> LM_STATE_CONFIGURED; LM_EVT_LINK_LOST в LM_STATE_MAINTAINING -> LM_STATE_CONFIGURED; LM_EVT_LINK_LOST в LM_STATE_PAUSED -> LM_STATE_CONFIGURED |
| 0x8dabdc | `lm_sm__action_8dabdc` | LM_EVT_LINK_STAT_UPDATE в LM_STATE_MAINTAINING -> LM_STATE_MAINTAINING; LM_EVT_LINK_STAT_UPDATE в LM_STATE_PAUSED -> LM_STATE_PAUSED |
| 0x8dad54 | `lm_sm__action_8dad54` | LM_EVT_SELF_LINKUP_DONE в LM_STATE_WAIT_LINK -> LM_STATE_CONFIGURED |
| 0x8dad74 | `lm_main_sm__linkup_failed` | LM_EVT_SELF_LINKUP_FAIL в LM_STATE_WAIT_LINK -> LM_STATE_WAIT_LINK |
| 0x8daed8 | `lm_sm__action_8daed8` | LM_EVT_LINKUP_REQ в LM_STATE_IDLE -> LM_STATE_WAIT_LINK |
| 0x8daf2c | `lm_sm__action_8daf2c` | LM_EVT_LINKUP_REQ в LM_STATE_CONFIGURED -> LM_STATE_WAIT_LINK |
| 0x8ddb58 | `lm_sm__action_8ddb58` | LM_EVT_MAINTAIN_STARTED в LM_STATE_WAIT_MAINTAIN -> LM_STATE_MAINTAINING |
| 0x8df614 | `lm_sm__action_8df614` | LM_EVT_BF_RESULTS в LM_STATE_CONFIGURED -> LM_STATE_CONFIGURED |
| 0x8dfff4 | `lm_sm__action_8dfff4` | LM_EVT_PAUSE в LM_STATE_MAINTAINING -> LM_STATE_PAUSED |
| 0x8e11c8 | `lm_sm__action_8e11c8` | LM_EVT_BF_RESULTS в LM_STATE_WAIT_LINK -> LM_STATE_WAIT_LINK |
| 0x8e2c64 | `lm_sm__action_8e2c64` | LM_EVT_RESUME_MAINTAIN_REQ в LM_STATE_PAUSED -> LM_STATE_MAINTAINING |
| 0x8e7acc | `lm_sm__action_8e7acc` | LM_EVT_START_MAINTAIN_REQ в LM_STATE_CONFIGURED -> LM_STATE_WAIT_MAINTAIN |
| 0x8e7f94 | `lm_sm__action_8e7f94` | LM_EVT_STOP_LINK в LM_STATE_WAIT_LINK -> LM_STATE_WAIT_LINK |
| 0x8e7f9c | `lm_sm__action_8e7f9c` | LM_EVT_STOP_LINK в LM_STATE_IDLE -> LM_STATE_IDLE; LM_EVT_STOP_LINK в LM_STATE_CONFIGURED -> LM_STATE_CONFIGURED; LM_EVT_MAINTAIN_STOPPED в LM_STATE_WAIT_STOP -> LM_STATE_CONFIGURED |
| 0x8e8004 | `lm_sm__action_8e8004` | LM_EVT_STOP_LINK в LM_STATE_WAIT_MAINTAIN -> LM_STATE_WAIT_STOP; LM_EVT_STOP_LINK в LM_STATE_MAINTAINING -> LM_STATE_WAIT_STOP; LM_EVT_STOP_LINK в LM_STATE_PAUSED -> LM_STATE_WAIT_STOP |

**sm_802f58** — `link_stats_sm`

| адрес | блок | переходы |
|---|---|---|
| 0x8da73c | `sm_802f58__on_evt_latency_timer_in_active` | EVT_LATENCY_TIMER в ACTIVE -> ACTIVE |
| 0x8e0048 | `sm_802f58__action_8e0048` | EVT_PAUSE в ACTIVE -> IDLE |
| 0x8e2be4 | `sm_802f58__action_8e2be4` | EVT_RESUME в IDLE -> ACTIVE |
| 0x8e774c | `sm_802f58__action_8e774c` | EVT_START в IDLE -> ACTIVE |
| 0x8e7e60 | `sm_802f58__action_8e7e60` | EVT_STOP в ACTIVE -> IDLE |

**state_sm_802fb4** — `channels_switch_sm` — обход каналов скана

| адрес | блок | переходы |
|---|---|---|
| 0x8c2018 | `channels_switch_sm__action_abort_allocate` | EVT_STOP_SCAN в STATE_ALLOCATING_RADIO -> STATE_ALLOCATING_RADIO |
| 0x8c203c | `channels_switch_sm__action_abort_dwelling` | EVT_STOP_SCAN в STATE_DWELLING -> STATE_DWELLING |
| 0x8c209c | `channels_switch_sm__scan_abort_tunning` | EVT_STOP_SCAN в STATE_TUNNING -> STATE_TUNNING |
| 0x8c20b8 | `channels_switch_sm__action_allocate_radio` | EVT_START_SCAN в STATE_IDLE -> STATE_ALLOCATING_RADIO |
| 0x8c2174 | `channels_switch_sm__action_dwelling_stopped` | EVT_STOP_DWELL в STATE_DWELLING -> STATE_STOPPING |
| 0x8c2228 | `channels_switch_sm__action_pop_ch_and_tune_8c2228` | EVT_RADIO_ALLOCATED в STATE_ALLOCATING_RADIO -> STATE_TUNNING; EVT_SM_STOPPED в STATE_STOPPING -> STATE_TUNNING; EVT_SM_STOPPED в STATE_ABORTING -> STATE_TUNNING |
| 0x8c22ec | `channels_switch_sm__action_radio_tunned` | EVT_CHANNEL_TUNED в STATE_TUNNING -> STATE_TUNED |
| 0x8c230c | `channels_switch_sm__action_scan_complete` | EVT_SCAN_COMPLETED в STATE_ALLOCATING_RADIO -> STATE_IDLE; EVT_SCAN_COMPLETED в STATE_TUNNING -> STATE_IDLE |
| 0x8c2354 | `channels_switch_sm__action_start_dwelling` | EVT_START_DWELLING в STATE_TUNED -> STATE_DWELLING |

**state_sm_8030e0** — `swc_psc_sm` — скан под PS (ждёт начала SOB)

| адрес | блок | переходы |
|---|---|---|
| 0x8c2068 | `swc_psc_sm__action_abort_scan` | EVT_SCAN_ABORT в STATE_WAIT_SOB_START -> STATE_SCAN_IDLE |
| 0x8c2144 | `swc_psc_sm__action_complete_scan` | EVT_DWELLING_DONE в STATE_DWELLING -> STATE_SCAN_IDLE |
| 0x8c21a0 | `swc_psc_sm__action_kick_channel_sw_sm` | EVT_SOB_STARTED в STATE_WAIT_SOB_START -> STATE_DWELLING |
| 0x8c23ac | `swc_psc_sm__action_start_scan` | EVT_SCAN_START в STATE_SCAN_IDLE -> STATE_WAIT_SOB_START |
| 0x8c23f4 | `swc_psc_sm__action_stop_dwelling` | EVT_SCAN_ABORT в STATE_DWELLING -> STATE_DWELLING |

**state_sm_8030f4** — `find_main_sm` — P2P Find (LISTEN/SEARCH)

| адрес | блок | переходы |
|---|---|---|
| 0x8f0dd4 | `state_sm_8030f4__action_8f0dd4` | EVT_START_LISTEN в STATE_IDLE -> STATE_ALLOCATE_RADIO_LSN; EVT_START_SEARCH в STATE_IDLE -> STATE_ALLOCATE_RADIO_SRC |
| 0x8f14d0 | `state_sm_8030f4__action_8f14d0` | EVT_BCON в STATE_SEARCHING -> STATE_SEARCHING |
| 0x8f76d8 | `state_sm_8030f4__action_8f76d8` | EVT_PROBE_REQ в STATE_LISTENING -> STATE_LISTENING |
| 0x8f96a8 | `state_sm_8030f4__action_8f96a8` | EVT_RADIO_READY в STATE_ALLOCATE_RADIO_LSN -> STATE_LISTENING |
| 0x8f9994 | `state_sm_8030f4__action_8f9994` | EVT_START_SEARCH в STATE_LISTENING -> STATE_SEARCHING; EVT_RADIO_READY в STATE_ALLOCATE_RADIO_SRC -> STATE_SEARCHING |
| 0x8f9ac8 | `find_main_sm__stop` | EVT_STOP в STATE_LISTENING -> STATE_IDLE |
| 0x8f9b84 | `find_main_sm__stop_searching` | EVT_STOP в STATE_SEARCHING -> STATE_IDLE |
| 0x8f9ce0 | `state_sm_8030f4__action_8f9ce0` | EVT_START_LISTEN в STATE_SEARCHING -> STATE_LISTENING |

**rm_sm** — `rm_main_sm` — радио-менеджер

| адрес | блок | переходы |
|---|---|---|
| 0x8c59c4 | `rm_main_sm__call_cb` | RM_EVT_CALLBCK в RM_ST_IDLE -> RM_ST_IDLE; RM_EVT_CALLBCK в RM_ST_SWITCH_2_PRIM -> RM_ST_SWITCH_2_PRIM; RM_EVT_CALLBCK в RM_ST_PRIM_NON_LOCKED -> RM_ST_PRIM_NON_LOCKED |
| 0x8c9950 | `rm_main_sm__enter_primary_non_locked` | RM_EVT_UNLOCK_PRIMARY в RM_ST_PRIM_LOCKED -> RM_ST_PRIM_NON_LOCKED |
| 0x8cc5a8 | `rm_main_sm__get_next_prim_request` | RM_EVT_GET_NEXT_REQ в RM_ST_PRIM_LOCKED -> RM_ST_PRIM_LOCKED |
| 0x8cc5e0 | `rm_main_sm__get_next_request_8cc5e0` | RM_EVT_GET_NEXT_REQ в RM_ST_IDLE -> RM_ST_IDLE; RM_EVT_GET_NEXT_REQ в RM_ST_PRIM_NON_LOCKED -> RM_ST_PRIM_NON_LOCKED |
| 0x8cd0a0 | `rm_sm__action_8cd0a0` | RM_EVT_GOTO_IDLE в RM_ST_PRIM_NON_LOCKED -> RM_ST_IDLE |
| 0x8dc9a4 | `rm_main_sm__lock_primary` | RM_EVT_LOCK_PRIMARY в RM_ST_PRIM_NON_LOCKED -> RM_ST_PRIM_LOCKED |
| 0x8ddcec | `rm_main_sm__mark_as_pending_removal` | RM_EVT_LOCK_FREE в RM_ST_SWITCH_2_SEC -> RM_ST_SWITCH_2_SEC |
| 0x8e0e58 | `rm_main_sm__primary_handle_free` | RM_EVT_LOCK_FREE в RM_ST_PRIM_LOCKED -> RM_ST_PRIM_LOCKED |
| 0x8e0eb0 | `rm_sm__action_8e0eb0` | RM_EVT_CH_SWITCH_DONE в RM_ST_SWITCH_2_PRIM -> RM_ST_PRIM_NON_LOCKED |
| 0x8e4e48 | `rm_main_sm__secondary_handle_free` | RM_EVT_LOCK_FREE в RM_ST_SECONDARY -> RM_ST_SECONDARY |
| 0x8e4ee4 | `rm_sm__action_8e4ee4` | RM_EVT_SEC_TUNE в RM_ST_SECONDARY -> RM_ST_SWITCH_2_SEC |
| 0x8e4f18 | `rm_main_sm__secondary_tune_done` | RM_EVT_CH_SWITCH_DONE в RM_ST_SWITCH_2_SEC -> RM_ST_SECONDARY |
| 0x8e83d4 | `switch_2_secondary` | RM_EVT_SWITCH_2_PRIMARY в RM_ST_PRIM_NON_LOCKED -> RM_ST_SWITCH_2_PRIM; RM_EVT_SWITCH_2_PRIMARY в RM_ST_SECONDARY -> RM_ST_SWITCH_2_PRIM |
| 0x8e83f4 | `rm_sm__action_8e83f4` | RM_EVT_LOCK_SEC в RM_ST_IDLE -> RM_ST_SWITCH_2_SEC; RM_EVT_LOCK_SEC в RM_ST_PRIM_NON_LOCKED -> RM_ST_SWITCH_2_SEC; RM_EVT_LOCK_SEC в RM_ST_SECONDARY -> RM_ST_SWITCH_2_SEC |
| 0x8e9ac0 | `rm_sm__action_8e9ac0` | RM_EVT_PRIMARY_UNSET в RM_ST_PRIM_NON_LOCKED -> RM_ST_SWITCH_2_PRIM |
| 0x8e9ad4 | `rm_sm__action_8e9ad4` | RM_EVT_PRIMARY_SET в RM_ST_IDLE -> RM_ST_SWITCH_2_PRIM; RM_EVT_PRIMARY_SET в RM_ST_PRIM_NON_LOCKED -> RM_ST_SWITCH_2_PRIM |
| 0x8ea8b0 | `rm__invalidate_tune_slot` | RM_EVT_PRIMARY_UNSET в RM_ST_IDLE -> RM_ST_IDLE; RM_EVT_PRIMARY_UNSET в RM_ST_SWITCH_2_PRIM -> RM_ST_SWITCH_2_PRIM; RM_EVT_PRIMARY_UNSET в RM_ST_PRIM_LOCKED -> RM_ST_PRIM_LOCKED |

**rm_ch_switch_sm** — `rm_ch_switch_sm` — переключение канала (RX_OFF/RX_ON ucode)

| адрес | блок | переходы |
|---|---|---|
| 0x8c5bb8 | `rm_ch_switch_sm__notify_ch_switch_done_8c5bb8` | CH_SWITCH_COMPLETED в TURN_OFF -> IDLE; CH_SWITCH_COMPLETED в TURN_ON -> IDLE |
| 0x8c5be8 | `rm_ch_switch_sm__action_8c5be8` | CH_SWITCH_KICK в IDLE -> TURN_OFF |
| 0x8c7f14 | `rm_ch_switch_sm__action_8c7f14` | DATA_STOPPED в TURN_OFF -> TURN_OFF |
| 0x8cb6e8 | `rm_ch_switch_sm__fwtx_channel_stopped_8cb6e8` | FW_TX_CHANNEL_STOPPED в TURN_OFF -> TURN_OFF |
| 0x8e3a9c | `rm_ch_switch_sm__action_8e3a9c` | UCODE_RX_OFF_EVT в TURN_OFF -> TURN_OFF |
| 0x8e3ac8 | `rm_ch_switch_sm__action_8e3ac8` | UCODE_RX_ON_EVT в TURN_ON -> TURN_ON |

**state_sm_803424** — сеанс FTM

| адрес | блок | переходы |
|---|---|---|
| 0x8f0534 | `state_sm_803424__action_8f0534` | EVT_FTM_SESSION_TO в STATE_BURST -> STATE_READY; EVT_FTM_SESSION_ABORT в STATE_BURST -> STATE_READY |
| 0x8f0584 | `state_sm_803424__action_8f0584` | EVT_FTM_SESSION_BURST_START в STATE_READY -> STATE_READY; EVT_FTM_SESSION_TO в STATE_WAIT -> STATE_READY; EVT_FTM_SESSION_ABORT в STATE_WAIT -> STATE_READY |
| 0x8f05f4 | `state_sm_803424__action_8f05f4` | EVT_FTM_SESSION_BURST в STATE_READY -> STATE_BURST |
| 0x8f064c | `state_sm_803424__action_8f064c` | EVT_FTM_SESSION_START в STATE_READY -> STATE_READY |
| 0x8f0750 | `state_sm_803424__action_8f0750` | EVT_FTM_SESSION_STARTED в STATE_READY -> STATE_BURST |
| 0x8f09f4 | `state_sm_803424__action_8f09f4` | EVT_FTM_SESSION_BURST_START в STATE_BURST -> STATE_BURST |
| 0x8f0a10 | `state_sm_803424__action_8f0a10` | EVT_FTM_SESSION_DONE в STATE_BURST -> STATE_READY; EVT_FTM_SESSION_DONE в STATE_WAIT -> STATE_READY |
| 0x8f0a1c | `state_sm_803424__action_8f0a1c` | EVT_FTM_SESSION_NEXT_REQ в STATE_BURST -> STATE_WAIT |

**state_sm_8034c0** — `ftm_main_sm`

| адрес | блок | переходы |
|---|---|---|
| 0x8f0588 | `state_sm_8034c0__action_8f0588` | EVT_FTM_ALL_SESSIONS_DONE в STATE_IDLE -> STATE_IDLE; EVT_FTM_ALL_SESSIONS_DONE в STATE_TUNED -> STATE_IDLE |
| 0x8f058c | `state_sm_8034c0__action_8f058c` | EVT_FTM_RADIO_ALLOCATE в STATE_TUNNING -> STATE_ALLOCATE_RADIO; EVT_FTM_DO_TUNNING в STATE_IDLE -> STATE_ALLOCATE_RADIO |
| 0x8f0a24 | `state_sm_8034c0__action_8f0a24` | EVT_FTM_START_SESSION в STATE_IDLE -> STATE_TUNED; EVT_FTM_START_SESSION в STATE_TUNED -> STATE_TUNED; EVT_FTM_START_SESSION в STATE_LINK -> STATE_TUNED |

## 6. Обработчики переходов **[4.1]**

Имена автоматов, состояний и событий — вендорские строки прошивки 4.1.
Перечислены блоки, не разобранные в документах 4.1; полные таблицы —
`4.1/ref/SM-TABLES.txt`, `4.1/ref/SM-TABLES-UC.txt`. Префикс «fw»/«uc» —
сегмент.

**LM_MAIN_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8d7d78 | `lm_main_sm__on_linkup_req__lm_state_idle` | LM_EVT_LINKUP_REQ в LM_STATE_IDLE → LM_STATE_WAIT_LINK |
| fw 0x8d7dd0 | `lm_main_sm__on_linkup_req__lm_state_configured` | LM_EVT_LINKUP_REQ в LM_STATE_CONFIGURED → LM_STATE_WAIT_LINK |
| fw 0x8d7c14 | `lm_main_sm__on_self_linkup_done` | LM_EVT_SELF_LINKUP_DONE в LM_STATE_WAIT_LINK → LM_STATE_CONFIGURED |
| fw 0x8e2eac | `lm_main_sm__set_bf_cfg` | LM_EVT_STOP_LINK в LM_STATE_IDLE → LM_STATE_IDLE; LM_EVT_STOP_LINK в LM_STATE_CONFIGURED → LM_STATE_CONFIGURED; LM_EVT_MAINTAIN_STOPPED в LM_STATE_WAIT_STOP → LM_STATE_CONFIGURED |
| fw 0x8e2ea8 | `ret_one_8e2ea8` | LM_EVT_STOP_LINK в LM_STATE_WAIT_LINK → LM_STATE_WAIT_LINK |
| fw 0x8e2f1c | `lm_main_sm__on_stop_link` | LM_EVT_STOP_LINK в LM_STATE_WAIT_MAINTAIN → LM_STATE_WAIT_STOP; LM_EVT_STOP_LINK в LM_STATE_MAINTAINING → LM_STATE_WAIT_STOP; LM_EVT_STOP_LINK в LM_STATE_PAUSED → LM_STATE_WAIT_STOP |
| fw 0x8db264 | `stub_ret_8db264` | LM_EVT_BF_RESULTS в LM_STATE_IDLE → LM_STATE_IDLE; LM_EVT_BF_RESULTS в LM_STATE_WAIT_MAINTAIN → LM_STATE_WAIT_MAINTAIN; LM_EVT_BF_RESULTS в LM_STATE_MAINTAINING → LM_STATE_MAINTAINING (+13) |
| fw 0x8dd054 | `lm_main_sm__on_bf_results__lm_state_wait_link` | LM_EVT_BF_RESULTS в LM_STATE_WAIT_LINK → LM_STATE_WAIT_LINK |
| fw 0x8db384 | `lm_main_sm__on_bf_results__lm_state_configured` | LM_EVT_BF_RESULTS в LM_STATE_CONFIGURED → LM_STATE_CONFIGURED |
| fw 0x8e28c8 | `lm_main_sm__on_start_maintain_req` | LM_EVT_START_MAINTAIN_REQ в LM_STATE_CONFIGURED → LM_STATE_WAIT_MAINTAIN |
| fw 0x8d79f0 | `link_lost_ntf__disconnect` | LM_EVT_LINK_LOST в LM_STATE_WAIT_MAINTAIN → LM_STATE_CONFIGURED; LM_EVT_LINK_LOST в LM_STATE_MAINTAINING → LM_STATE_CONFIGURED; LM_EVT_LINK_LOST в LM_STATE_PAUSED → LM_STATE_CONFIGURED |
| fw 0x8dbf24 | `lm_main_sm__on_pause` | LM_EVT_PAUSE в LM_STATE_MAINTAINING → LM_STATE_PAUSED |
| fw 0x8de7cc | `lm_main_sm__on_resume_maintain_req` | LM_EVT_RESUME_MAINTAIN_REQ в LM_STATE_PAUSED → LM_STATE_MAINTAINING |

**PCP_PSC_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8db264 | `stub_ret_8db264` | RECEIVED_DPM1 в ACTIVE → ACTIVE; PSC_RSP_TX_COMPLETE в IDLE → IDLE; PSC_RSP_TIMEOUT в IDLE → IDLE (+2) |

**PS_MODE_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8db264 | `stub_ret_8db264` | INCREASE_PS в AM_PENDING_WEB → AM_PENDING_WEB; INCREASE_PS в WEB_PENDING_SOB → WEB_PENDING_SOB; INCREASE_PS в SOB → SOB (+22) |
| fw 0x8c6fb4 | `ps_mode_sm__ignored_ps_trigger_` | INCREASE_PS в SOB_PENDING_WEB → SOB_PENDING_WEB; INCREASE_PS в WEB_PENDING_AM → WEB_PENDING_AM; INCREASE_PS в SOB_PENDING_AM → SOB_PENDING_AM (+8) |
| fw 0x8c6fa8 | `ps_mode_sm__ignored_agreed` | PSC_AGREED в AM → AM |
| fw 0x8c6fc4 | `ps_mode_sm__ignored_rejected` | PSC_REJECTED в AM → AM |

**RADIO_MANAGER_MAIN_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8e4a1c | `radio_manager_main_sm__on_primary_set__rm_st_idle` | RM_EVT_PRIMARY_SET в RM_ST_IDLE → RM_ST_SWITCH_2_PRIM; RM_EVT_PRIMARY_SET в RM_ST_PRIM_NON_LOCKED → RM_ST_SWITCH_2_PRIM |
| fw 0x8e1f24 | `radio_manager_main_sm__on_primary_set__rm_st_prim_locked` | RM_EVT_PRIMARY_SET в RM_ST_SWITCH_2_PRIM → RM_ST_SWITCH_2_PRIM; RM_EVT_PRIMARY_SET в RM_ST_PRIM_LOCKED → RM_ST_PRIM_LOCKED; RM_EVT_PRIMARY_SET в RM_ST_SWITCH_2_SEC → RM_ST_SWITCH_2_SEC (+1) |
| fw 0x8e32d0 | `radio_manager_main_sm__on_switch_2_primary` | RM_EVT_SWITCH_2_PRIMARY в RM_ST_PRIM_NON_LOCKED → RM_ST_SWITCH_2_PRIM; RM_EVT_SWITCH_2_PRIMARY в RM_ST_SECONDARY → RM_ST_SWITCH_2_PRIM |
| fw 0x8dcb9c | `radio_manager_main_sm__on_ch_switch_done` | RM_EVT_CH_SWITCH_DONE в RM_ST_SWITCH_2_PRIM → RM_ST_PRIM_NON_LOCKED |
| fw 0x8db264 | `stub_ret_8db264` | RM_EVT_GET_NEXT_REQ в RM_ST_SWITCH_2_PRIM → RM_ST_SWITCH_2_PRIM; RM_EVT_GET_NEXT_REQ в RM_ST_SWITCH_2_SEC → RM_ST_SWITCH_2_SEC; RM_EVT_GET_NEXT_REQ в RM_ST_SECONDARY → RM_ST_SECONDARY |
| fw 0x8e559c | `radio_manager_main_sm__on_primary_unset__rm_st_idle` | RM_EVT_PRIMARY_UNSET в RM_ST_IDLE → RM_ST_IDLE; RM_EVT_PRIMARY_UNSET в RM_ST_SWITCH_2_PRIM → RM_ST_SWITCH_2_PRIM; RM_EVT_PRIMARY_UNSET в RM_ST_PRIM_LOCKED → RM_ST_PRIM_LOCKED (+2) |
| fw 0x8e4a08 | `radio_manager_main_sm__on_primary_unset__rm_st_prim_non_locked` | RM_EVT_PRIMARY_UNSET в RM_ST_PRIM_NON_LOCKED → RM_ST_SWITCH_2_PRIM |
| fw 0x8cad50 | `radio_manager_main_sm__on_goto_idle` | RM_EVT_GOTO_IDLE в RM_ST_PRIM_NON_LOCKED → RM_ST_IDLE |
| fw 0x8e0350 | `radio_manager_main_sm__on_sec_tune` | RM_EVT_SEC_TUNE в RM_ST_SECONDARY → RM_ST_SWITCH_2_SEC |

**STA_PSC_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8db264 | `stub_ret_8db264` | PSC_REQ_TX_COMPLETE в IDLE → IDLE; MAX_RETRY в IDLE → IDLE; RECEIVED_UNSOLICITED в ACTIVE → ACTIVE (+1) |
| fw 0x8c29f0 | `sta_psc_sm__on_agreed` | AGREED в ACTIVE → IDLE |
| fw 0x8e5550 | `tail_sta_psc_sm__psc_done_sm` | RECEIVED_UNSOLICITED в IDLE → IDLE |
| fw 0x8c5c38 | `sta_psc_sm__on_close` | CLOSE в ACTIVE → IDLE |

**PS_ASSOC_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8db264 | `stub_ret_8db264` | PS_ENABLE в PS_DISABLED → PS_NOT_ALLOWED; PS_ENABLE в PS_NOT_ALLOWED → PS_NOT_ALLOWED; PS_ENABLE в PS_ALLOWED → PS_ALLOWED (+12) |
| fw 0x8dd398 | `ps_assoc_sm__on_ps_deep_sleep_exit` | PS_DEEP_SLEEP_EXIT в PS_ALLOWED → PS_REENTER |

**CONN_MSM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8e282c | `conn_msm__on_own_start_link__unresourced` | SM_EVT_OWN_START_LINK в UNRESOURCED → WAIT_FOR_BCON_RX |
| fw 0x8db264 | `stub_ret_8db264` | SM_EVT_OWN_START_LINK в WAIT_FOR_ASSOC_DONE → WAIT_FOR_ASSOC_DONE; SM_EVT_OWN_START_LINK в ASSOCIATED → ASSOCIATED; SM_EVT_OWN_START_LINK в WAIT_FOR_LM_START → WAIT_FOR_LM_START (+33) |
| fw 0x8de19c | `conn_msm__on_ntf_lm_started__wait_for_assoc_done` | SM_EVT_NTF_LM_STARTED в WAIT_FOR_ASSOC_DONE → WAIT_FOR_ASSOC_DONE |
| fw 0x8d7ee8 | `conn_msm__on_ntf_lm_started__wait_for_lm_start` | SM_EVT_NTF_LM_STARTED в WAIT_FOR_LM_START → ASSOCIATED |
| fw 0x8d75a8 | `conn_msm__on_ntf_key_installed` | SM_EVT_NTF_KEY_INSTALLED в ASSOCIATED → KEY_ASSOC |

**LINK_STATS_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8e24f8 | `link_stats_sm__started` | EVT_START в IDLE → ACTIVE |
| fw 0x8db264 | `stub_ret_8db264` | EVT_LATENCY_TIMER в IDLE → IDLE; EVT_STATS_TIMER в IDLE → IDLE; EVT_STOP в IDLE → IDLE (+1) |
| fw 0x8d7638 | `link_stats_sm__on_latency_timer` | EVT_LATENCY_TIMER в ACTIVE → ACTIVE |
| fw 0x8e2d58 | `link_stats_sm__on_stop` | EVT_STOP в ACTIVE → IDLE |
| fw 0x8dbf34 | `link_stats_sm__on_pause` | EVT_PAUSE в ACTIVE → IDLE |
| fw 0x8de74c | `link_stats_sm__on_resume` | EVT_RESUME в IDLE → ACTIVE |

**BA_TD_subSM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8e1c24 | `frag_8e1c24` | START в WAIT_FOR_START → WAIT_FOR_PERMIT; RCP_DELBA_ARRIVED в WAIT_FOR_START → WAIT_FOR_PERMIT |
| fw 0x8e2ac0 | `ba_td_subsm__on_ready_to_run` | READY_TO_RUN в WAIT_FOR_PERMIT → WAIT_FOR_DELBA_TX_COMPLETE |
| fw 0x8db264 | `stub_ret_8db264` | DELBA_TX_COMPLETE в WAIT_FOR_PERMIT → WAIT_FOR_PERMIT; RCP_DELBA_ARRIVED в WAIT_FOR_PERMIT → WAIT_FOR_PERMIT; RCP_DELBA_ARRIVED в WAIT_FOR_DELBA_TX_COMPLETE → WAIT_FOR_START |
| fw 0x8de73c | `ba_td_subsm__on_delba_tx_complete` | DELBA_TX_COMPLETE в WAIT_FOR_DELBA_TX_COMPLETE → WAIT_FOR_START |

**PS_NONASSOC_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8db264 | `stub_ret_8db264` | PS_ENABLE в PS_DISABLED → PS_ALLOWED; PS_ENABLE в PS_ALLOWED → PS_ALLOWED; PS_ENABLE в PS_REENTER → PS_ALLOWED (+3) |
| fw 0x8dd3bc | `ps_nonassoc_sm__on_ps_sleep_exit` | PS_SLEEP_EXIT в PS_ALLOWED → PS_REENTER |
| fw 0x8dd4c0 | `tail_u_schd__add_8dd4c0` | PS_SLEEP_EXIT в PS_REENTER → PS_REENTER |

**CALIB_ENGINE**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8db264 | `stub_ret_8db264` | EVT_ABORT в IDLE → IDLE |

**RM_CHAN_SW_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8c6d30 | `rm_ch_switch_sm__turn_step` | DATA_STOPPED в TURN_OFF → TURN_OFF |
| fw 0x8deed8 | `rm_chan_sw_sm__on_ucode_rx_off_evt` | UCODE_RX_OFF_EVT в TURN_OFF → TURN_OFF |
| fw 0x8def0c | `rm_chan_sw_sm__on_ucode_rx_on_evt` | UCODE_RX_ON_EVT в TURN_ON → TURN_ON |

**PCIE_DEVICE_POWER_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8db264 | `stub_ret_8db264` | TRAFFIC_DEFERRAL в D0 → PENDING_D3_HOT; D0_D3_INT в PENDING_D3_HOT → D3_HOT; PERST_ASSERT в D3_HOT → D3_COLD (+2) |

**BA_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8dcab0 | `ba_sm__on_start_ba_setup__not_ba_agr_state` | EVT_START_BA_SETUP в NOT_BA_AGR_STATE → BA_SETUP_STATE |
| fw 0x8e5424 | `ba_sm__on_start_ba_setup__ba_agreed_state` | EVT_START_BA_SETUP в BA_SETUP_STATE → BA_SETUP_STATE; EVT_START_BA_SETUP в BA_AGREED_STATE → BA_AGREED_STATE; EVT_START_BA_SETUP в BA_TEARDOWN_STATE → BA_TEARDOWN_STATE (+1) |
| fw 0x8e5454 | `ba_sm__on_start_ba_teardown` | EVT_START_BA_TEARDOWN в NOT_BA_AGR_STATE → NOT_BA_AGR_STATE; EVT_START_BA_TEARDOWN в BA_SETUP_STATE → BA_SETUP_STATE; EVT_START_BA_TEARDOWN в BA_TEARDOWN_STATE → BA_TEARDOWN_STATE (+1) |
| fw 0x8e26f8 | `ba_sm__on_ready_to_run__ba_setup_state` | EVT_READY_TO_RUN в BA_SETUP_STATE → BA_SETUP_STATE |
| fw 0x8e2718 | `ba_sm__on_ready_to_run__ba_teardown_state` | EVT_READY_TO_RUN в BA_TEARDOWN_STATE → BA_TEARDOWN_STATE |
| fw 0x8c39f4 | `vtbl__call_212_4` | EVT_READY_TO_RUN в WAIT_REMOVE_STREAM_STATE → NOT_BA_AGR_STATE; EVT_BA_TEARDOWN_DONE_NTF в BA_TEARDOWN_STATE → NOT_BA_AGR_STATE |
| fw 0x8db264 | `stub_ret_8db264` | EVT_ADDBAREQ_TX_COMPLETE в NOT_BA_AGR_STATE → NOT_BA_AGR_STATE; EVT_ADDBAREQ_TX_COMPLETE в BA_AGREED_STATE → BA_AGREED_STATE; EVT_ADDBAREQ_TX_COMPLETE в BA_TEARDOWN_STATE → BA_TEARDOWN_STATE (+12) |
| fw 0x8c2930 | `ba_sm__on_addbareq_tx_complete` | EVT_ADDBAREQ_TX_COMPLETE в BA_SETUP_STATE → BA_SETUP_STATE; EVT_ADDBAREQ_TX_COMPLETE в WAIT_REMOVE_STREAM_STATE → WAIT_REMOVE_STREAM_STATE |
| fw 0x8c2984 | `addba_rsp_handler` | EVT_ADDBARSP_ARRIVED в BA_SETUP_STATE → BA_SETUP_STATE |
| fw 0x8c770c | `ba_sm__on_delba_tx_complete` | EVT_DELBA_TX_COMPLETE в BA_TEARDOWN_STATE → BA_TEARDOWN_STATE |
| fw 0x8de64c | `ba_sm__on_rcp_delba_arrived` | EVT_RCP_DELBA_ARRIVED в BA_AGREED_STATE → BA_TEARDOWN_STATE |
| fw 0x8ddd44 | `rcp__on_delba` | EVT_RCP_DELBA_ARRIVED в BA_TEARDOWN_STATE → BA_TEARDOWN_STATE |
| fw 0x8c39d8 | `ba_sm__on_remove_stream` | EVT_REMOVE_STREAM в BA_SETUP_STATE → WAIT_REMOVE_STREAM_STATE |
| fw 0x8c39e8 | `ba_sm__on_ba_setup_sm_abort_done` | EVT_BA_SETUP_SM_ABORT_DONE в WAIT_REMOVE_STREAM_STATE → WAIT_REMOVE_STREAM_STATE |

**RF_KILL_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8efc68 | `rf_kill_sm__on_w_enable__enabled` | W_ENABLE в ENABLED → ENABLED |
| fw 0x8ea1ac | `rf_kill_sm__on_w_enable__disabled` | W_ENABLE в DISABLED → DISABLED; W_ENABLE в PENDING_DISABLED → PENDING_DISABLED |
| fw 0x8eafd0 | `rf_kill_sm__on_w_disable__enabled` | W_DISABLE в ENABLED → PENDING_DISABLED |
| fw 0x8efc58 | `rf_kill_sm__on_w_disable__disabled` | W_DISABLE в DISABLED → DISABLED |
| fw 0x8f2940 | `rf_kill_sm__on_w_disable__pending_disabled` | W_DISABLE в PENDING_DISABLED → PENDING_DISABLED |
| fw 0x8db264 | `stub_ret_8db264` | DISABLE_DONE в ENABLED → ENABLED |

**BA_SETUP_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8ed558 | `ba_setup_sm__on_start` | EVT_START в WAIT_FOR_START_STATE → WAIT_FOR_PERMIT_STATE |
| fw 0x8f169c | `ba_setup_sm__on_ready_to_run` | EVT_READY_TO_RUN в WAIT_FOR_PERMIT_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATEWAIT_ADDBAREQ_SENT_STATE |
| fw 0x8f031c | `ba_setup_sm__on_tx_permitted` | EVT_TX_PERMITTED в ADDBAREQ_CHECKING_MAX_RETRY_STATEWAIT_ADDBAREQ_SENT_STATE → WAIT_FOR_ADDBARSP_STATE |
| fw 0x8db264 | `stub_ret_8db264` | EVT_ADDBAREQ_TX_COMPLETE в WAIT_FOR_START_STATE → WAIT_FOR_START_STATE; EVT_ADDBAREQ_TX_COMPLETE в WAIT_FOR_PERMIT_STATE → WAIT_FOR_PERMIT_STATE; EVT_ADDBAREQ_TX_COMPLETE в ADDBAREQ_CHECKING_MAX_RETRY_STATEWAIT_ADDBAREQ_SENT_STATE → ADDBAREQ_CHECKING_MAX_RETRY_STATEWAIT_ADDBAREQ_SENT_STATE (+13) |
| fw 0x8efc34 | `ba_setup_sm__abort` | EVT_ADDBAREQ_TX_COMPLETE в ST5 → WAIT_FOR_START_STATE; EVT_ADDBAREQ_TX_FAILED в ST5 → WAIT_FOR_START_STATE; EVT11 в ADDBAREQ_CHECKING_MAX_RETRY_STATEWAIT_ADDBAREQ_SENT_STATE → WAIT_FOR_START_STATE (+2) |
| fw 0x8e91f8 | `ba_setup_sm__arm_timer` | EVT_ADDBAREQ_TX_FAILED в WAIT_FOR_ADDBARSP_STATE → ABORT_PENDING_STATE; EVT_MAX_RETRY_TH_PASS в ABORT_PENDING_STATE → ABORT_PENDING_STATE |
| fw 0x8e9410 | `ba_setup_sm__addba_session_success` | EVT_DISCARD_RECEIVED_ADDBARSP в ABORT_PENDING_STATE → WAIT_FOR_START_STATE |
| fw 0x8e93f4 | `ba_setup_sm__on_abort` | EVT_ABORT в ADDBAREQ_CHECKING_MAX_RETRY_STATEWAIT_ADDBAREQ_SENT_STATE → WAIT_FOR_START_STATE; EVT_ABORT в WAIT_FOR_ADDBARSP_STATE → WAIT_FOR_START_STATE; EVT_ABORT в ABORT_PENDING_STATE → WAIT_FOR_START_STATE |

**MAINTAIN_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8c3f80 | `bf__fail_retrying` | EVT_BF_RESULTS в FBF_DONE → FBF_DONE; EVT_BF_RESULTS в ACTIVE → ACTIVE |
| fw 0x8db264 | `stub_ret_8db264` | EVT_RS_RESULTS в STOPPED → STOPPED; EVT_RS_RESULTS в BEFORE_FIRST_FBF → BEFORE_FIRST_FBF; EVT_RS_RESULTS в FBF_DONE → FBF_DONE (+6) |
| fw 0x8cb5b4 | `maintain_sm__on_rs_results` | EVT_RS_RESULTS в ACTIVE → ACTIVE |
| fw 0x8f16e0 | `maintain_sm__on_stop` | EVT_STOP в BEFORE_FIRST_FBF → STOPPED; EVT_STOP в FBF_DONE → STOPPED; EVT_STOP в ACTIVE → STOPPED |
| fw 0x8c8e64 | `MAINTAIN_SM__FBF_DELAYED` | EVT_TIMER в FBF_DONE → ACTIVE |
| fw 0x8d946c | `rs__need_long_term` | EVT_TIMER в ACTIVE → ACTIVE |
| fw 0x8eb908 | `MAINTAIN_SM__OPEN` | EVT_SELF_FIRST_FBF_SUCCESS в BEFORE_FIRST_FBF → FBF_DONE |
| fw 0x8c63b0 | `maintain_sm__on_consecutive_high_per` | EVT_CONSECUTIVE_HIGH_PER в ACTIVE → ACTIVE |
| fw 0x8eea24 | `maintain_sm__on_pause` | EVT_PAUSE в ACTIVE → ACTIVE |
| fw 0x8efc78 | `maintain_sm__on_resume_maintain` | EVT_RESUME_MAINTAIN в ACTIVE → ACTIVE |

**DISCONN_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8eb11c | `l2mgr__disconnect_flow` | SM_EVT_OWN_START в INITIAL → WAIT_FOR_DISC_DONE |
| fw 0x8db264 | `stub_ret_8db264` | SM_EVT_OWN_START в WAIT_FOR_DISC_DONE → WAIT_FOR_DISC_DONE; SM_EVT_NTF_SW_DATA_STOPPED в INITIAL → INITIAL; SM_EVT_NTF_LMS_STOPPED в INITIAL → INITIAL (+2) |
| fw 0x8edf18 | `lms_stopped` | SM_EVT_NTF_LMS_STOPPED в WAIT_FOR_DISC_DONE → WAIT_FOR_DISC_DONE |
| fw 0x8ebbac | `disconn_sm__on_ntf_fw_tx_stopped` | SM_EVT_NTF_FW_TX_STOPPED в WAIT_FOR_DISC_DONE → WAIT_FOR_DISC_DONE |
| fw 0x8eb104 | `disconn_sm__on_own_disc_done` | SM_EVT_OWN_DISC_DONE в WAIT_FOR_DISC_DONE → INITIAL |

**FIND_MAIN_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8db264 | `stub_ret_8db264` | EVT_START_LISTEN в STATE_ALLOCATE_RADIO_LSN → STATE_ALLOCATE_RADIO_LSN; EVT_START_LISTEN в STATE_ALLOCATE_RADIO_SRC → STATE_ALLOCATE_RADIO_LSN; EVT_START_SEARCH в STATE_ALLOCATE_RADIO_LSN → STATE_ALLOCATE_RADIO_SRC (+14) |
| fw 0x8f194c | `find_main_sm__on_start_listen` | EVT_START_LISTEN в STATE_SEARCHING → STATE_LISTENING |

**MLME_SM**

| адрес | блок | переходы |
|---|---|---|
| fw 0x8eb094 | `mlme_sm__handle_disassoc` | EVT_DISASSOCIAT в ASSOCIATE → UNASSOCIATE; EVT_DISASSOCIAT в ASSOCIATED → UNASSOCIATE |
| fw 0x8e98ec | `mlme_sm__assoc_resp_start` | EVT_ASSOC_RESPONSE_START в UNASSOCIATE → UNASSOCIATE |
| fw 0x8db260 | `stub_ret_8db260` | EVT_ASSOC_RESPONSE в ASSOCIATE → ASSOCIATE; EVT_ASSOC_RESPONSE в ASSOCIATED → ASSOCIATED; EVT_ASSOC_REJECT в ASSOCIATED → ASSOCIATED (+2) |
| fw 0x8ea9cc | `mlme_sm__on_evt8` | EVT8 в ASSOCIATE → ASSOCIATED |

**BI_AP_MONITOR_SM**

| адрес | блок | переходы |
|---|---|---|
| uc 0x925214 | `basic_sm__assert_bad_event_uc` | BI_EVENT_DTI_TO_BTI в BI_STATE_ABFT → BI_STATE_ABFT; BI_EVENT_BTI_TO_ABFT в BI_STATE_ABFT → BI_STATE_ABFT; BI_EVENT_BTI_TO_ABFT в BI_STATE_AW → BI_STATE_AW (+1) |

## Замечания
- Скан описателей для сравнения с UBNT насчитал в 6.2 **23** описателя,
  выгрузка `6.2/ref/SM-TABLES.txt` содержит **24** автомата fw. Какой из них не
  вошёл в сравнение, не установлено; отметка «см. замечания» в колонке UBNT
  стоит у кандидатов, не названных в сравнении явно.
- `sm_802234` сопоставлен с CALIB_ENGINE только по размерности 4×6 и
  начальному состоянию IDLE.
- В описателе 6.2 байт +2 — начальное состояние; при скане по формату
  `{u8 ne, u8 ns, u16, …}` он входит в u16.

## Не установлено
- Наличие CALIB_ENGINE, `swc_psc_sm`, автоматов FTM в сборке UBNT.
- Смысл поля +0x28 объекта автомата 4.1 (в `rm_sm` = 1).

## Источники
- `4.1/ref/SM-TABLES.txt`, `4.1/ref/SM-TABLES-UC.txt`
- `6.2/ref/SM-TABLES.txt`, `6.2/ref/SM-TABLES-UC.txt`
- [FW-OBJECTS.md](FW-OBJECTS.md), [4.1/docs/STRUCTS.md](../4.1/docs/STRUCTS.md),
  [6.2/docs/MISC-FW.md](../6.2/docs/MISC-FW.md), [WMI.md](WMI.md)
