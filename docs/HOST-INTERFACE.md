# Управляющая плоскость и хостовый интерфейс

Как прошивка исполняет команды хоста: подключение станции, запуск PCP/AP, скан,
обнаружение (P2P Find), отключение. Адреса — 4.1.0.1000, если не помечено **[6.2]**.
Номера команд и событий WMI обеих версий — [WMI.md](WMI.md); автоматы —
[STATE-MACHINES.md](STATE-MACHINES.md) и `4.1/ref/SM-TABLES.txt`; внутреннее устройство
MLME, скана и P2P Find с адресами обеих версий — [MLME.md](MLME.md), радио-менеджер —
[RADIO-MANAGER.md](RADIO-MANAGER.md), связь без ролей и режим OOB —
[ROLELESS-LINK.md](ROLELESS-LINK.md).

Метки: **[код]**, **[железо]**, **[гипотеза]**.

## Каркас

* Вход WMI: `host_if__wmi_cmd_dispatch` @0x8da54c (2356 Б) — большой switch по id;
  каждая ветка печатает имя команды и зовёт обработчик. Выход событий:
  `operational_if__alloc_evt` @0x8c2b68 → заполнение → `operational_if__send_evt`
  @0x8e0874 (id события в r1). **[код]**
* Один vif: `mid` = 0x8058f0 (список 0x8058d0), `bss` = mid+0x48,
  `m_bss_mode` = [mid+0x50] (1 станция / 2 PBSS-PCP / 3 AP). Раскладка —
  [4.1/docs/STRUCTS.md](../4.1/docs/STRUCTS.md).
* Связь с соседом — объект `conn` (0x198 Б, пул 0x8046f0 с конца, таблица CID
  0x8046a0+cid·8). Внутри: CONN_MSM (conn+0xfc), MLME_SM (conn+0xb0). LM и
  MAINTAIN — в fw_peri (0x841b84+cid·0x110, +0x34).
* Радио — единственный ресурс, им владеет RADIO_MANAGER_MAIN_SM: потоки
  берут его `RADIO_MGR__lock_primary` @0x8d9288 с колбэком и отдают
  `RADIO_MGR__unlock` @0x8e54d8. Вторичный захват (скан, температура,
  калибровки) — `lock_secondary`. **[код]**

## Подключение станции (WMI_CONNECT 0x1)

1. `wmi_handler_connect` @0x8e7730 → `validate_connect` @0x8f295c — отказ,
   если: канал 4 (64,8 ГГц) не поддержан, ошибка MAC, **узел в режиме PCP**
   («WMI Connect is not allowed in PCP mode»), MID уже подключён, идёт скан.
2. `l2_mgr__connect_setup` @0x8f0284: безопасность (`m_wpa_offload`,
   `auth_mode`), параметры DMG по умолчанию.
3. `l2_mgr__connect` @0x8ea758: тип сети, MAC, BSSID (`wmi_connect_cmd`+0x2a
   → bss+0x0c), SSID, `set_primary_channel`, `lock_primary`. PBC — «obsolete».
4. Колбэк захвата канала `l2_mgr__channel_locked_cb` @0x8ea128 → `mid__connect`
   @0x8c6354 → `mid__link_acquisition_action` с **following_connect = 1** →
   `[conn+0x18]=1`; радио сразу отпускается.
5. CONN_MSM: `OWN_START_LINK` в UNRESOURCED → LMAC 0x05 → WAIT_FOR_BCON_RX.
6. Маяк координатора (`SM_EVT_BCON_RX`) → `linkup__check_pcp_assoc_ready`
   @0x8c3e40: при сброшенном бите PCP Association Ready — «LINKUP Failure PCP
   Assoc ready = 0!!!», иначе `lm_if__on_linkup_ready` → BF → WAIT_FOR_LINKUP.
7. `NTF_LINKUP` → `conn_main_sm__linkup_ntf` (гейт `status==0 && [conn+0x18]==1`)
   → OWN_ASSOC → `conn_main_sm__send_assoc_resp_pbss` @0x8c3210 (требует
   `m_bss_mode==1`). При `[conn+0x18]==0` `send_assoc_resp_pbss` уходит в фатальный
   ассерт (строка 351) — гейт `linkup_ntf` и обработчик согласованы.
8. При `[conn+0x1c]==0` в MLME уходит EVT_CONNECT; его обработчик
   `mlme_sm__assoc_req_handle` @0x8e9940 — разбор ПРИНЯТОГО Assoc-Req на стороне PCP
   со сборкой Assoc-Resp (`mgmt_tx__build_assoc_resp`). Сам кадр строит и шлёт
   `mlme_sm__send_assoc` @0x8c4f08 — обработчик MLME `EVT_DATA_PORT_OPEN` в
   UNASSOCIATE: `mgmt_tx__build_assoc_req` @0x8f1b00 («Send ASSOC REQ») либо
   `mgmt_tx__build_assoc_resp` («Send ASSOC RESP»), затем `tx_api__send_mgmt_with_cb`
   и таймер. **[код]** В `assoc_req_handle` есть ветка «Handle associate event
   State %d» с `RADIO_MGR__lock_primary`.
9. Ответ → `mlme_sm__assoc_resp_event` → `mlme_notify(4)` → NTF_ASSOC_DONE →
   `pcp_ap__set_aid` @0x8c3294 (`lm_if__on_aid_assigned`, мощность TX) →
   WAIT_FOR_LM_START → LM MAINTAINING → NTF_LM_STARTED → ASSOCIATED →
   `l2mgr__publish_assoc_done` @0x8e9bc0 → `WMI_CONNECT_EVENTID` (или 0x15
   `WMI_PBSS_JOINED_EVENTID` при `[conn+0x1c]`).

Поле `[conn+0x18]` — «связь заведена своим connect»: `mid__acquire_link`
(все пути без WMI_CONNECT: find/discovery, новая связь от LMAC, скан,
sw_tx_mgmt) записывает 0. **[код]**

Поле `[conn+0x1c]` — признак режима Direct Connection (событие 0x15 вместо
`WMI_CONNECT_EVENTID`). В 6.2 событие 0x15 шлёт `l2mgr__send_pbss_joined_evt` **[6.2]**.

## Запуск PCP/AP (WMI_PCP_START 0x918)

`wmi_handler_pcp_start` → `l2_mgr__pcp_start_flow` @0x8dc544: проверка MAC и
канала («BSS not ready or channel is not valid»), `set_primary_channel`,
канал в bss+0x4c, `bss_set_mode` (0x10 AP → 3, иначе → 2), `pcp_start`
@0x8eef18 (печатает discovery_mode и PCP_assoc_ready, строит маяк
`tx_bcon__update_bcon`, шлёт настройку ответчика A-BFT LMAC 0x23), событие
`WMI_PCP_STARTED_EVENTID`. Для PBSS отдельная строка «PBSS PCP Start DMG
Information flow start». **[код]**

`assoc_ready_check_trig` @0x8c33f4 (зовётся и из отключения) пересчитывает
бит PCP Association Ready по свободным ресурсам: «No resources» → ready=0;
при смене — `bss_bi_ctrl_PCP_ready_set` и `pcp_restart`. **[код]**

## Скан (WMI_START_SCAN 0x7)

`low_sme__wmi_scan_cmd_handler` @0x8e7b18 → `l2_mgr__validate_scan` @0x8f29dc —
отказ, если: MID не существует, **уже подключён**, ошибка MAC, **режим PCP/AP**,
другой скан, идёт подключение или отключение, MID в потоке ассоциации. Затем
`l2_mgr__wmi_scan_cmd` @0x8f3710: `vring_schd__prohibit_cids` (запрет TX
соседям MID на время скана), `lm_if__inject_evt9`. Завершение —
`WMI_SCAN_COMPLETE_EVENTID` (`tx_probe__send_scan_complete` @0x8f0980).
Каналы обходит CHANNELS_SWITCH_SM через вторичный захват радио.

`scan_mngr__start_scan` @0x8f1474: тип скана × discovery mode («Not supported scan
type»), `discovery__tsf_wa`, время пребывания на канале, список каналов; результат
A-BFT во время скана — `scan_mngr__handle_abft_bf_result_in_scan` @0x8ebda8
(«Added entry to m_scan_pend_list»). Адрес `direct_scan_mac_addr[6]` из тела
`WMI_START_SCAN_CMDID` уходит в поле Clustering Control discovery-маяка —
[STANDARD-MAPPING.md](STANDARD-MAPPING.md#clustering-control-в-41).

## Обнаружение: P2P Find (FIND_MAIN_SM) — штатный безролевой путь

Автомат FIND_MAIN_SM (`4.1/ref/SM-TABLES.txt` стр. 674): IDLE → (EVT_START_LISTEN /
EVT_START_SEARCH) → ALLOCATE_RADIO_LSN/SRC (вторичный захват радио,
`radio_mgr__reset_and_lock_secondary`) → LISTENING / SEARCHING; переходы
LISTEN ⇄ SEARCH напрямую; EVT_STOP → IDLE. **[код]**

* **SEARCH** — `find_mngr__search_start` @0x8e0030: LMAC режима discovery
  (`lmac_if_discovery_mode_cfg_handler`), таймер «Search for %d msec»;
  `find_mng__add_bcon` @0x8c225c: «ADD DMG DISCOVERY BEACON», в активном
  скане `add_discovery_bcon` + **настройка ответчика A-BFT**
  (`lmac_if__send_abft_resp_ctrl`, LMAC 0x23). Ищущий узел сам маячит
  discovery-маяками с окном A-BFT.
* **LISTEN** — `find_mngr__listen_start` @0x8d7de4: то же с таймером
  «Listen for %d msec». Принятый DMG-маяк → **`find_main_sm__bcon` @0x8e9d48**:
  запись в список dband (пул; «dband info pool is empty»), затем
  **`mid__acquire_link`** — создаётся conn (following_connect = 0), дальше
  BF в A-BFT ищущего.
* **BF в SEARCH** — `find_main_sm__bf_ntf` @0x8e9e60: при успехе ищущий шлёт
  **Probe Request с широковещательным BSSID** (`mgmt_tx__build_probe_req`),
  при неудаче «FIND_SM:: BF with FAIL status». Ответ в LISTEN —
  `find_main_sm__probe_req` @0x8ef244; при типе сети ADHOC ответ не шлётся
  («Should be handled by HOST»).

P2P Find — полное обнаружение без ролей: один узел маячит discovery-маяками с A-BFT,
другой слушает и сам наводит луч. Связь создаётся с `following_connect = 0` и
останавливается в READY_FOR_ASSOC. Штатное продвижение дальше в P2P-сценарии —
ассоциация, запускаемая хостом (wpa_supplicant P2P) **[гипотеза]**. Запуск Find
штатно — только через P2P-device интерфейс.

Безролевой линк, получаемый четырьмя записями с хоста (два PCP, событие новой связи
после A-BFT, вероятно `l2_mgr__lmac_new_link_evt_handler`), входит другим путём, но
через ту же `mid__acquire_link`.

## Отключение и CONN_MSM

Полная таблица — `4.1/ref/SM-TABLES.txt` строки 257–356. Существенное:
* `OWN_DISC` из любого состояния → `conn_main_sm__start_disc` @0x8e275c →
  WAIT_FOR_DISCONN, **кроме READY_FOR_ASSOC — там пустой обработчик**:
  связь, остановившуюся на READY_FOR_ASSOC, штатное отключение не снимает.
* `NTF_DISC_COMPLETE` → `conn_msm__on_ntf_disc_complete` @0x8c79f4 →
  **READY_FOR_ASSOC** (не UNRESOURCED), с пересчётом PCP ready и мощности.
* `NTF_ASSOC_DONE` принимается в WAIT_FOR_LINKUP, READY_FOR_ASSOC и
  WAIT_FOR_ASSOC_DONE — во всех трёх → `pcp_ap__set_aid` → WAIT_FOR_LM_START.

## Приём кадров управления

Таблица подтипов 0x802624 **[4.1]** / 0x802c58 **[6.2]**, что прошивка обрабатывает
сама и что отдаёт хосту событием 0x1840 — [DATAPATH.md](DATAPATH.md).

## Отличия 6.2

* Диспетчер `wmi__host_cmd_dispatch`, 102 команды против 68 — [WMI.md](WMI.md).
* Режим Direct Connection присутствует: событие 0x15 шлёт `l2mgr__send_pbss_joined_evt`.
* Период маяка станции 6.2 берётся из WMI 0x803 в `l2_mgr__connect` —
  [STANDARD-MAPPING.md](STANDARD-MAPPING.md#интервал-маяка-и-потеря-связи-у-станции).

## Замечания

* Имя `conn_main_sm__send_assoc_resp_pbss` (0x8c3210) неточно: это обработчик
  OWN_ASSOC, ветвь «ASSOC_RESPONSE» в нём — лишь случай `[conn+0x1c]`; точнее
  `conn_main_sm__own_assoc_start`.
* Имя `mlme_sm__assoc_req_handle` (0x8e9940) верно: разбор принятого Assoc-Req (PCP).
* Имена 6.2 `discovery__rx_pkt_handler` и `channels_switch_sm__action_pop_ch_and_tune`
  стоят на местах 4.1 `rx_pkt_handler` и `rx_mgmt__action_no_ack` — вероятен ложный
  перенос имени.

## Не установлено

1. Где станция шлёт Assoc-Req; что делает EVT_CONNECT при `m_bss_mode==1`; кто
   впрыскивает EVT_DATA_PORT_OPEN после EVT_CONNECT и по какому признаку выбирается
   Assoc-Req или Assoc-Resp.
2. Смысл LMAC 0x05 на OWN_START_LINK.
3. Писатель `[conn+0x1c]` в 6.2.
4. Полная таблица событий прошивка → хост для 4.1 (для 6.2 — [WMI.md](WMI.md)).
