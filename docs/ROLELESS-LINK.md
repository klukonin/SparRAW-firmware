# Режим OOB и связь без ролей

Механизмы, которые определяют, может ли пара узлов 802.11ad найти друг друга и поднять
связь без распределения ролей PCP/STA: режим OOB (`pf_mode_en`, параметр драйвера
`oob_mode`), `special_flags`, маска классов принятого кадра и ролевой гейт развёртки
в ucode, ответчик A-BFT, связь без ролей до `READY_FOR_ASSOC`, автомат CONN_MSM,
распределители управляющих кадров, IBSS и BSSID. Задаются телами команд LMAC
([LMAC-PROTOCOL.md](LMAC-PROTOCOL.md)) и записями с хоста. Путь WMI-команд хоста —
[HOST-INTERFACE.md](HOST-INTERFACE.md); автомат MLME и приём маяков —
[MLME.md](MLME.md); соответствие стандарту — [STANDARD-MAPPING.md](STANDARD-MAPPING.md).

Метки: **[железо]** — проверено на стенде, **[код]** — по листингу,
**[пак]** — по вендорским именам пака 11ad, **[гипотеза]** — не проверено.
Адреса без пометки — 4.1.0.1000; сведения 6.2 — в §1.7 и §4.7. Host-адреса (для
`mem_write` драйвера): данные ucode — host = A + 0x140000 (0x801438 → 0x941438), данные
fw — host = A + 0x100000 (0x803474 → 0x903474), fw_peri — host = 0x908000 + (A − 0x840000).

## 1. Режим OOB (`pf_mode_en`)

### 1.1. Гейт и его источник **[код] [железо]**

Глобал **0x803468** = поле `+0xc` подструктуры 0x80345c, которая сама — `+0x80`
объекта с базой **0x8033dc** (там же `security_en` = +0x6c = 0x803448). Вендорское
имя — **`pf_mode_en`** [пак]; `oob_mode` — имя со стороны драйвера. Лог-строки
соседних читателей: `scan_mngr::config_dwell_time() pf_mode_en` (0x8ea5a4),
`OOB mode force to MAX MSDU size = %d` (`encap_trans_type` @0x8f3900).

Читатель регистра — `oob_mode__read_bit` @0x8d7238; адрес строится сдвигом, а не
литералом:

    8d7238 mov_s r0,0x11        ; 0x11
    8d723a asl_s r0,r0,0x13     ; << 19 = 0x880000
    8d723c ld_s  r0,[r0,0x18]   ; [0x880018] = RGF_USER_USAGE_6
    8d723e j_s.d blink
    8d7240 _lsr_s r0,r0,0x1f    ; бит 31

Гейт пишут два места:

| адрес | блок | запись | база |
|---|---|---|---|
| 0x8ed05a | `boot__init_subsystems` | `st_s r0,[r14,0xc]` | r14 = r15 + 0x80 (`add3 r14,r15,0x10`), r15 = 0x8033dc |
| 0x8ed3ae | `l2mgr__init` | `st r0,[r14,0x8c]` | r14 = 0x8033dc литералом |

Инициализация в `boot__init_subsystems`:

    8ed04c  [0x80345c] = 1
    8ed050  [0x803460] = 1
    8ed058  [0x803464] = 0
    8ed05a  [0x803468] = (0x880018 >> 31)      <-- гейт OOB
    8ed05c  [0x80346c] = 0x04 (байт)           pf_mcs_value
    8ed060  [0x80346d] = 0x43 (байт)           pf_rx_sector_value
    8ed064  [0x803478] = 0x5b8d80 = 6 000 000
    8ed06c  [0x803474] &= ~0x2f & 0xffffe03f   <-- special_flags
    8ed08e+ [0x80347c…] таблица LED-схем, u16 × 3 на запись, шаг 6

0x04 и 0x43 — константы образа (0x8ed05c/0x8ed060). Живой дамп подтверждает базу:
0x803478 = 0x005b8d80 (`st 0x5b8d80,[r14,0x1c]` @0x8ed064), 0x80346c = `04 43`
(`stb 0x4,[r14,0x10]` / `stb 0x43,[r14,0x11]`). Из 37 загрузок базы: +0xc (гейт) —
29 загрузок в 24 блоках, +0x18 (`special_flags`) — 9 блоков; `led_scheme__apply`
@0x8d777e использует базу только как начало массива. Гейт — одиночный бит 0/1.
Бит 30 (`BIT_USER_OOB_R2_MODE`) не читает никто.

Цепочка от хоста **[железо]**:

    insmod wil6210.ko oob_mode=1
      -> wil_set_oob_mode() (драйвер, main.c) ставит BIT_USER_OOB_MODE (бит 31)
         в RGF_USER_USAGE_6 = 0x880018 до загрузки прошивки
      -> 0x880018 = 0x80000001
      -> [0x803468] = 1
      -> команда 0x23 с (mode=ALWAYS, beacon_type=ALL, relax=1)
      -> 0x802090 = 2, 0x802094 = 2, 0x802098 = 1

`oob_mode` — параметр модуля только для чтения (0444), задаётся при загрузке
(`rmmod wil6210; insmod …/wil6210.ko oob_mode=1`); kmodloader OpenWrt (`modprobe`)
параметры отбрасывает; после перезагрузки узла не сохраняется. `oob_mode=2`
на Sparrow не действует: поля `pf_mode_en_r2` в 4.1 нет (§1.4).

| | `oob_mode=0` | `oob_mode=1` |
|---|---|---|
| 0x880018 | — | 0x80000001 |
| [0x803468] | 0 | 1 |
| mode (PCP) | 2 ALWAYS | 2 ALWAYS |
| beacon_type (PCP) | 1 DISCOVERY | 2 ALL |
| relaxation | 1 | 1 |

В OOB узел работает как AP штатно (станция подключается, `wmi_evt_connect … cid 0`).

### 1.2. Что меняет OOB **[код]**

| место | что |
|---|---|
| `lmac_if__send_abft_resp_ctrl` 0x8d7efc | ответчик A-BFT: ALWAYS + ALL ([LMAC-PROTOCOL §3.6](LMAC-PROTOCOL.md#36-команда-0x23-fui_abft_resp_ctrl_s-код-пак-железо)) |
| `lmac_if__abft_notify_evt` 0x8d81c2 | путь Discovery A-BFT ([LMAC-PROTOCOL §4.3](LMAC-PROTOCOL.md#43-событие-0x06-bf_done_evt-и-discovery-a-bft-код)) существует только в OOB |
| `l2mgr__build_mac_config` 0x8e17d8…0x8e17ea | B0 первого октета STA Capability (`[r14,0x7]`): вне OOB 1, в OOB 0; B1..B3 гасятся всегда. Позиция доказана, имя (B0 = Reverse Direction) [гипотеза] |
| `discovery__handle_rx_frame` 0x8c7cbc | принятый маяк всегда уходит в `scan_mngr__dband_beacon_ind` |
| `tx_queue_mgr__create_queue` 0x8d691a | размер кадра/MSDU очереди = 7976 (0x1f28) |
| `wmi_handler_cfg_rx_chain` 0x8f3068 | лог «OOB mode force RX MAX MSDU to %d», rx_msdu = 0x1f28 |
| `encap_trans_type` 0x8f3906 | лог «OOB mode force to MAX MSDU size», MSDU = 0x1f28 |
| `scan_mngr__config_dwell_time` 0x8ea5b0 | dwell = `[0x8004cc]` = 1 500 000 вместо 120/180/500 мс |
| `lmac_if_trigger_bf` 0x8d8cc8 | body[+4] = реальный `bf_cmd_type` (вне OOB обнуляется) |
| `tx_mgmt_build_step` 0x8ec904 | элемент Awake Window (ID 157) попадает в DMG Beacon даже при выключенной фиче |
| `rf_chain__program_sector_desc` 0x8f2586 / 0x8f275a | бит 0 слова [desc+4] = 0 вместо `[0x80001c]` = 1 (вероятно `is_x16_on`) |
| `l2mgr__send_ready_evt` 0x8ed8bc | только лог «WMI_READY_EVENTID … (is OOB = %d)» |
| `pcp_stop__flow` 0x8dc6dc | при PCP-stop снимается периодика Information flow |
| `install_key_index_stub` 0x8e945e | подмена `sta_index` на 8 — мёртвая ветка ([LMAC-PROTOCOL §3.9](LMAC-PROTOCOL.md#39-прочие-тела-код)) |
| `schedule_long_term_trigger` 0x8dfaa4 | сразу возвращается — long-term адаптация MCS не планируется |
| команда 0x21 | пределы TXOP 2000 → 1280 мкс ([LMAC-PROTOCOL §3.7](LMAC-PROTOCOL.md#37-команда-0x21-пределы-txop-код-железо)) |
| команда 0x14 | маска причин ретриггера BF = 0 ([LMAC-PROTOCOL §3.9](LMAC-PROTOCOL.md#39-прочие-тела-код)) |
| команда 0x05 | фиксированные MCS 4 / сектор 0x43 ([LMAC-PROTOCOL §3.8](LMAC-PROTOCOL.md#38-команда-0x05-запись-соседа-код-железо)) |

**Таймеры разрыва связи в OOB выключены**: три детектора возвращают «не включён»:

| блок | адрес гейта | следствие |
|---|---|---|
| `bad_beacons_detector__is_bad` | 0x8d7128 | разрыва по потере маяков нет (единственный вызывающий 0x8caec0 при 0 выходит) |
| `ka_detector__get_state` | 0x8d717c | keep-alive не вооружается |
| `ageing_detector__get_state` | 0x8d71d0 | таймаут старения TX-PPDU выключен |

**Power Save в OOB выключен**: `l2mgr__init` зовёт `set_g_80040c_x2(0)`
(0x8ed3c2 → 0x8c7984), обнуляя `[0x80040c]` и `[0x800424]`; первый гасит флаг
включённости во всех пяти автоматах PS.

**Шифрование OOB не выключает**: единственная функция безопасности, читающая гейт,
— `install_key_index_stub`, её ветка инертна; `security_en` (0x803448) пишется
только из WMI-обработчика beacon-control.

Полный список побочных эффектов 27 читателей гейта (скан, инкапсуляция,
программирование секторов, схема светодиодов, детектор плохих маяков) не составлен.

### 1.3. Сведения о составе PBSS — только в OOB **[код]**

`stream_mgr__rx_action` @0x8c1c0a: Action-кадры категории 16 (DMG) в OOB уходят на
вторую таблицу 0x801f24, добавляющую Action 2 = Information Request
(`stream_mgr__info_req` @0x8d5428) и Action 3 = Information Response
(`pbss_sta_list_update` @0x8d5560). Без OOB живут только Action 0/1 (Power Save
Config Req/Resp), остальное отбрасывается.

`pbss_sta_list_update` @0x8d5774: состояние 2 → `pbss__add_sta` («ADD PBSS AID %d,
MAC…»), состояние 3 → `pbss__del_sta`. Записи — элементы ID 148 (DMG Capabilities),
19 байт: MAC[0..5] + AID[6]. У всех четырёх функций по одному вызывающему, все в
OOB-ветках. Периодику (период `[0x803478]` = 6 000 000 мкс вместо `[0x800058]` =
60 000 000) запускает единственная точка — гейт @0x8f04fc в
`l2mgr__send_data_port_open_evt`.

Запросчик Information Request должен быть PCP/AP по установленным соединениям
(`info_flow__start_periodic` требует `[conn+0xb0] == 2`, лог «Is either NULL or not
associated»; `info_flow__run` требует `mid__state_is_2_or_3`, лог «Not PCP AP»).
Отвечающая сторона (Action 2) в OOB работает на любом узле.

### 1.4. Вендорские имена полей конфигурации **[пак]**

Порядок полей в паке 11ad (адреса 0xa090xx) совпадает с 4.1, смещения различаются:

| пак 11ad | адрес в паке | 4.1 | значение на стенде |
|---|---|---|---|
| `pf_mode_en` | 0xa09090 | 0x803468 | 1 при `oob_mode=1` |
| `pf_mode_en_r2` | 0xa09094 | отсутствует | — |
| `pf_psc_ok` | 0xa09098 | отсутствует | — |
| `pf_mcs_value` (u8) | 0xa0909c | 0x80346c | 0x04 |
| `pf_rx_sector_value` (u8) | 0xa0909d | 0x80346d | 0x43 |
| `special_flags` | 0xa090b4 | 0x803474 | 0 |

### 1.5. `special_flags` = 0x803474 (`special_mode_flags_s`) **[пак] [код] [железо]**

| бит | поле пака | читатель 4.1 | следствие |
|---|---|---|---|
| 0 | `force_test_mode` | `l2_mgr__connect` 0x8ea784 | источник network type; то же даёт `wmi_connect_cmd.reserved1[0] = 1` (+0x3a тела) |
| 1 | `disable_all_link_losts` | `lmac_if_link_lost_handler` 0x8d862c; `lm_main_sm__on_link_stat_update` 0x8d7ace (1 или 2) | глушит обработчик `Ucode->LINK_LOST_EVT` (нет блокировки вторичного радио по «high false alarm» и записей LLD); связь удерживают ka/ageing/bad_beacons, не он |
| 2 | `relaxed_link_losts` | 0x8d7ace | не сбрасывать sta_ctx при потере линка |
| 3 | `disable_bad_link_detection` | `maintain_sm__check_bad_link` 0x8c5122 | пороги 20/200 → 200000/200000 (детектор выключен) |
| 4 | `reserved1` | — | единственный, переживающий инициализацию |
| 5 | `enable_bf_triggers_on_start` | — | не читается |
| 6 | `enable_immediate_rs` | `maintain_sm__init` 0x8ed166 | таймер maintain_sm = 10000 |
| 7 | `use_increased_dwell_time` | `scan_mngr__config_dwell_time` 0x8ea5ce | dwell скана 500 мс |
| 8 | `immediate_open_pci_stub` | — | не читается |
| 9 | `allow_scan_to_already_assoc_pcp` | `discovery__handle_rx_frame` 0x8c7cb0 | принудительная индикация всех маяков (ниже) |
| 10 | `disconnect_dock_upon_probe` | `discovery_handle_probe_req` 0x8eb576 | при состоянии соединения 5 или 7: «Disconnecting all MIDs due to special configuration», все MID рвутся по Probe Request без ответа |
| 11 | `enable_light_test_mode` | — | не читается |
| 12 | `enable_boost_test_mode` | `boot__publish_ids` 0x8e355e | другие ID |
| 13..14 | `force_device_identity` | `hw_personality_detect` 0x8dffea | == 1 → «HW personality is DEVICE» |
| 15..31 | `reserved` | — | — |

Инициализация (`boot__init_subsystems` @0x8ed06c, единственный писатель):

    8ed070 bic r0,r0,0x2f          ; биты 0,1,2,3,5   (бит 4 не в маске)
    8ed074 and r0,r0,0xffffe03f    ; биты 6..12
    8ed082 bf_w_s13_w2(ptr, 0)     ; биты 13,14
    8ed088 bf_w_s15_w17(ptr, 0)    ; биты 15..31

В образе (`fw_data.bin`, смещение 0x3474) и на железе — 0. Host-адрес **0x903474**;
запись 0x00000200 держится (runtime-писателя нет) **[железо]**. Писать после загрузки
прошивки. С хоста действуют биты 0, 1, 2, 3, 6, 7, 9, 10; биты 12 и 13..14 читаются
при загрузке. Комбинация битов 1, 3, 7, 9 = 0x28a; только бит 9 = 0x200.

**Бит 9.** `discovery__handle_rx_frame` @0x8c7ca4 разбирает BI-Control принятого
DMG-маяка: байт 5 бит 3 = PCP Association Ready (`linkup__check_pcp_assoc_ready`
@0x8c3e96 читает тот же бит и при нуле печатает `LINKUP Failure PCP Assoc ready =
0!!!`). Гейт 0x8c7d40 (`cmp r1,0; cmp.eq r2,0; beq`) отбрасывает маяк соседа, не
объявляющего готовность к ассоциации. Бит 9 форсирует `pcp_assoc_ready = 1` и
смежное 2-битное поле → `scan_mngr__dband_beacon_ind` вызывается всегда (то же
делает `pf_mode_en`, но вместе с остальными эффектами OOB).

### 1.6. Decentralized PCP/AP Clustering не объявляется **[код] [железо]**

`l2mgr__build_mac_config` @0x8e1882: безусловный `bic r0,r0,0x38` по байту
`[r14,0xe]`. Соседний аксессор 0x8e8168 (сдвиг 3, ширина 8 = B3–B10 Max Associated
STA Number) закрепляет выравнивание: гасятся B11, B12, B13 поля DMG AP or PCP
Capability Information — Power Source, **Decentralized PCP/AP Clustering**, PCP
Forwarding. Элемент DMG Capabilities (ID 148, 17 байт) на узле-PCP (`bss+0x5e`):

    26 18 1d 24 3b 0b | 01 | 11 d1 b7 06 00 00 40 10 | 00 00
    MAC                 AID  DMG STA Capability Info   AP/PCP Cap = 0x0000

Механизм распределённого биконинга 802.11ad (патент US8520648B2) в эфир не заявляется.

### 1.7. Режим OOB в 6.2 **[код]**

`l2mgr__init` 0x8f55b8 ([L2-MANAGER §1](L2-MANAGER.md#1-инициализация-l2-код)) читает режим
через `boot__read_oob_strap_bits` 0x8cc2ac: **биты 31..29 регистра 0x880018** —
`RGF_USER_USAGE_6` драйвера (`wil_set_oob_mode`, main.c:950: бит 31
`BIT_USER_OOB_MODE`, бит 30 `BIT_USER_OOB_R2_MODE`; сверено с исходником
backports-7.2). Сравнение идёт с полем из трёх бит целиком, так что взведённый
бит 29 выключил бы оба режима.

| значение поля | режим | действие |
|---|---|---|
| 4 (бит 31, `oob_mode=1`) | «R1 OOB mode: disable power management» | `0x803c00+0x0c = 1`, выключение PM |
| 2 | «R2 OOB mode» | `0x803c00+0x10 = 1` (меняет разбор ESE, [ESE.md](ESE.md)) |

Флаг `0x803c00+0x0c` (R1 OOB) и бит 9 `special_flags` (в 6.2 — `0x803c00+0x20`, в
`g_sys_config`) принудительно пропускают принятый DMG-маяк дальше независимо от
битов BI-Control — шаг 1 `dmg_bcon__rx_handler` 0x8c9404
([MLME §5](MLME.md#5-приём-management-кадра-discovery-и-dmg-маяка-код)); в 4.1 то же делает
`discovery__handle_rx_frame` (§1.5).

---

## 2. Маска классов принятого кадра 0x801038 и ролевой гейт развёртки

### 2.1. Структура **[код]**

24 байта, обнуляются `memset0_words_uc(0x801038, 0x18)` из `rx_flow__run` @0x92cf18
на каждый принятый PPDU.

| смещ. | адрес | что |
|---|---|---|
| +0x00 | 0x801038 | маска классов кадра |
| +0x0c | 0x801044 | 5-битное L-RX из BRP (пишет 0x92aac8; в ucode не читается) |
| +0x12 / +0x14 | 0x80104a / 0x80104c | читает `bi_manager_step_a` (сверка с antenna_id/sector_id); писателя нет |

Поля 0x80104a / 0x80104c мертвы: единственный писатель — `memset0_words_uc(0x801038, 24)`;
читают `bi_manager_step_a` @0x922a94 и @0x922a80, сравнивая с текущей парой
antenna/sector, — сравнение вырождается в «== 0». Во всём образе прошивки одно
обращение в host-окно 0x940000+ (`link_lost_diag__dump_mac_rx` читает 0x944004). В 6.2
то же: структура на 0x8021e0, читатели есть, писателей нет.

Классификатор (`rx_funcs__identify_peer` @0x926608, `rx_funcs__handle_ppdu_report`
@0x92d740):

    r36 бит 6 ss_detected ?
       r37 бит 24 (ss_bitmap[0]) -> бит 0
       r37 бит 25 (ss_bitmap[1]) -> бит 2
       r37 бит 26 (ss_bitmap[2]) -> бит 3
       иначе -> uc_sysassert
    иначе r36 бит 25 no_action_mgmt_detected ? -> биты 9/10/11
    иначе r37 бит 0 rts ? -> бит 4

| бит | смысл | читатели / следствие |
|---|---|---|
| 0 | принят SSW | `txss__init_sweep` 0x936030 → подсост. 6; `txss_rx_step` 0x9364c0 и `txss__prepare_frames` 0x936170 → зачесть SSW (`txss_copy_step`) и сбросить бит |
| 1 | развёртка встречной стороны окончена | §2.2 |
| 2 | SSW-Feedback | `txss__init_sweep_b` 0x936462 → возврат 1; `txss_rx_step` (`mask & 0xC`) → выход из цикла |
| 3 | SSW-ACK | `txss__init_sweep_b` 0x93645e → ассерт |
| 4 | DMG RTS | `txss__prepare_frames` 0x9360e0 → подсост. 8 |
| 5 | не ставит никто, читается трижды | — |
| 9 / 10 / 11 | BRP / BRP просит RX-тренировку / второй запрос BRP | `handle_ppdu_report` |

`mask & 0x221` (биты 0, 5, 9) = «кадр относится к beamforming», при 0
`rx_flow__handle_frame` @0x92e400 откатывает РЧ; `mask & 0xC` — выход из приёмного
цикла. На железе в простое все 24 байта нулевые.

### 2.2. Бит 1 подменяет аппаратный `txss_end_ind` **[код]**

Ставится в трёх местах, все при `zero_cdown` (r39 бит 15, последний кадр развёртки):
`rx_flow__run` @0x92d30c, `handle_ppdu_report` @0x92da1e, `identify_peer` @0x926776.

    92d2e0 mov   r11,r37
    92d2e4 bbit1 r11,0x18,0x92d2f0   ; ss_bitmap[0] -> пропустить проверку ниже
    92d2e8 mov   r10,r38
    92d2ec bbit0 r10,0x0,0x92d314    ; my_bssid_beacon_detected == 0 -> мимо
    92d2f0 mov   r9,r39
    92d2f4 bbit0 r9,0xf,0x92d314     ; zero_cdown == 0 -> мимо
    92d2f8 mov   r8,r42
    92d2fc bbit0 r8,0x10,0x92d314    ; ppdu_report_event (r42 бит 16) == 0 -> мимо
    92d300 mov   r6,0x801038
    92d308 ld    r5,[r6]
    92d30c bset  r5,r5,0x1
    92d310 st    r5,[r6]
    92d314 ...

Условие: `(ss_bitmap[0] ∨ my_bssid_beacon_detected) ∧ zero_cdown ∧ ppdu_report_event`;
кадр идёт дальше в любом случае. `my_bssid_beacon_detected` (r38 бит 0) проверяется
в ucode только на 0x92d2ec; `other_beacon_detected` (r38 бит 1) — нигде.

`txss_rx_step` @0x9364a0:

    9364a8 ld_s   r1,[r0,0]      ; маска
    9364aa btst_s r2,0           ; Z = !txss_end_ind   (r54 бит 0)
    9364ac btst.eq r1,0x1        ; при txss_end_ind==0: Z = !(маска бит 1)
    9364b0 bne_s  0x9364cc       ; выход при (txss_end_ind ИЛИ маска бит 1)

Читатели бита 1: `txss__prepare_frames` @0x93611a (`bbit0`) и @0x93612c (`bbit1`),
`txss_rx_step` @0x9364ac (`btst`) и @0x9364dc (`bbit1`).
Бит 1 — единственный программный способ завершить приёмную развёртку. На выходе
(0x9364cc): `0x8004b0 = маска бит 1`; при бите 1 пропускается
`mac_mode__switch_core_and_rf` (РЧ-конфигурация сохраняется), читается
сектор/антенна из 0x800fcc, программируются GP-таймеры и передаётся свой секторный
кадр (`txss__tx_sector_frame`). В `txss__prepare_frames` бит 1 превращает «таймаут
gp1 → аборт в подсостояние 3» (0x93615a) в возврат 1, запрещает откат РЧ-режима
(0x93617c), ставит `0x8004b0 = 1`.

`0x8004b0` = «зачесть развёртку»: пишут 0x92677c, 0x936196, 0x9364d8; читают
`txss__flow_body` @0x9362dc и `txss_flow_step_b` @0x9365e0 (`cmp r0,1; bleq
txss_copy_step`, затем `txss_func__reorder_sectors`). `txss_copy_step` @0x930f44
сравнивает метрику `0x800fcc + idx*12 + 0xc` с 0x8010d4 и при улучшении копирует
12 байт в **0x8010d0** (лучший сектор пира), затем ранжирует 4 записи. Без бита 1
цикл уходит в аборт по gp1, `txss_copy_step` не зовётся.

На железе после A-BFT-линка **[железо]**: `0x8004b0 = 1`, `0x8010d0` =
`3f 00 00 00 | c6 2c 01 00 | 07 00 00 00` (сектор 0x3f, метрика 76998, поле 7).

Следствие: при разных BSSID ветка 0x92d2e0 по чужому маяку не исполняется; путь к
биту 1 без совпадения BSSID — `ss_bitmap[0]`, то есть настоящий SSW-кадр (путь
ответчика A-BFT). Другие препятствия приёму маяков соседа: расписание (оба
инициаторы, каждый в своём BTI); `identify_peer` зовётся только для SSW и
Action-No-Ack и только при бите 0 слова 0x800540; «пировый» путь 0x92e304 требует
`r38 & 0x30006800 == 0x20000800` (`addr2_match_valid ∧ fcs_ok_partial ∧ ¬mcast ∧
¬bcast ∧ ¬neighbour_indication`), а `addr2_match_valid` — MAC соседа в таблице
адресов MAC. Аппаратные биты отчёта PPDU (r37/r38/r39/r42) записью в память не
подделываются.

### 2.3. Ролевой гейт: направление × роль **[код] [железо]**

`rx_funcs__handle_ppdu_report`, контекст 0x200000:

    92d9ce mov_s r0,0x804010
    92d9d4 ldw_s r3,[r0,0x10]      ; поле SSW, бит 0 = Direction
    92d9d8 bbit1 r3,0x0,0x92d9e2
    92d9dc ld_s  r0,[gp,0xdc]      ; слово роли = 0x800604
    92d9de bbit1 r0,0x6,0x92d9ec   ; Direction==0 и ответчик -> принять
    92d9e2 bbit0 r3,0x0,0x92da72   ; Direction==0 и не ответчик -> отклонить
    92d9e6 ld_s  r0,[gp,0xdc]
    92d9e8 bbit0 r0,0x5,0x92da72   ; Direction==1 и не инициатор -> отклонить
    92d9ec bset_s r1,r1,0x0        ; принять

`принять ⟺ (Direction==0 ∧ 0x800604 бит 6) ∨ (Direction==1 ∧ 0x800604 бит 5)`.
Слово роли пишется на входе в поток: 0x20 = инициатор (0x93620c), 0x40 = ответчик
(0x936592), сбрасывается на выходе; на железе в момент снимка `0x800604 = 0x10`
(поток передачи развёртки маяка).

Снятие гейта — две однобайтовые правки (байты сверены с живым `blob_uc_code`,
смещение = адрес − 0x920000):

    0x93620c:  20 d8  ->  60 d8     (mov_s r0,0x20 -> 0x60)
    0x936592:  40 d8  ->  60 d8     (mov_s r0,0x40 -> 0x60)

Далее `37 1a` = `st.as r0,[gp,0xdc]`; при 0x60 взведены оба бита.

### 2.4. Попутные структуры ucode **[код]**

* **0x804010** — принятый кадр: `+0x04` адрес (маяк), `+0x0a` адрес (SSW), `+0x10`
  32-битное поле Sector Sweep (бит 0 = Direction), `+0x13` метрика/SNR с битами
  ошибок 6/7, `+0x18` Action Category, `+0x19` Action Value, `+0x1b` L-RX, `+0x20`
  слово запроса BRP.
* **0x800604** — слово роли/потока: 0x8 и 0x4 `rx_funcs__rx_flow`, 0x10
  `bti_worker__…beacon_sweep_flow`, 0x20 = бит 5 TXSS-инициатор, 0x40 = бит 6
  TXSS-ответчик, 0x2 TXOP-инициатор, 0x2002 `bi_manager__rx_flow_body`.
* **0x800608** — контекст потока: 0x80000 `txss_rx_step`, 0x100000/0x200000
  TXSS-приём, 0x400000 `txss__init_sweep`, 0x800000 `txss__init_sweep_b`,
  0x4000000…0x20000000 — BRP.
* **0x800ef4** — массив BF-состояний по индексу пира, шаг 12.
* **0x801418** — индекс пира текущего кадра, 8 = неизвестный (8 в простое).
  Таблицы по нему: 0x801198 шаг 72, 0x801b3c шаг 4, 0x800ef4 шаг 12, 0x801bc6 шаг 28.
* `rx_funcs__on_rx_type_0x14` — обработчик BRP (Unprotected DMG Action No Ack,
  Category 0x14, Action 1).

---

## 3. Ответчик A-BFT и линк без ролей

### 3.1. Фильтры ответчика **[код]**

Ответчик гейтится `abft_responder_mode`, `beacon_type`, `relaxation_period`;
фильтра по BSS нет. `abft_responder_substep` @0x92c90e проверяет
`addr2_match_valid` (r38 бит 11), но обе ветки возвращают 1:

    92c90e bbit0 r7,0xb,0x92c948   ; нет совпадения -> 0x92c948
    92c912 lsr r2,r38,0x8
    92c916 bmsk r2,r2,0x2          ; addr2_match_index (0..7)
    92c918 b.d 0x92c950
    92c91c _stb r2,[r13,0xd]
    ...
    92c948 mov r6,0x8
    92c94c stb r6,[r13,0xd]        ; 8 = «нет совпадения»
    92c950 b.d 0x92c95c
    92c954 _mov r0,0x1

Совпадение адреса лишь помечает соседа. Оба теста бита 28 `neighbour_indication`
(0x92dd5c в `rx_flow_step`, 0x92e708 в `rx_flow__handle_frame`) относятся к путям
NAV. `addr3_my_bssid` (r39 бит 4) тестируется в `rx_flow__handle_frame` @0x92e74a
вместе с `bcast_indication` (r38 бит 14) — путь широковещательных кадров со своим
BSSID. SSID на этом уровне не разбирается.

### 3.2. Счётчики ответчика 0x801e68 **[железо]**

Станция, ассоциированная с PCP, окно 10 с:

| счётчик | `oob_mode=0` | `oob_mode=1` |
|---|---|---|
| конфигурация | mode=0 UNASSOCIATED_ONLY, type=2 ALL, relax=1 | mode=2 ALWAYS, type=2 ALL, relax=1 |
| +0x1c отправлено SSW | +0 | +12 |
| +0x20 отказ по mode | +24 | +0 |
| +0x24 тик relaxation | +0 | +13 |
| +0x26 принято | +0 | +12 |

Без OOB станция доходит до проверки ~2.4 раза/с и отказывает по `mode` (узел
ассоциирован, 0x801034 = 1). `+0x24` — служебный тик на каждую отправку при
включённом прореживании, а не отказ: при `relaxation_period = 0` (host 0x942098)
он стоит в нуле, а темп отправки SSW не меняется (+36/+37 за 15 с).

Два PCP в OOB (свои BSSID, без ассоциации), окно 15 с:

| счётчик | узел A | узел B |
|---|---|---|
| чужие маяки `beacon_neighbor` | +6955 | +7024 |
| +0x1c отправлено SSW | +36 | +37 |
| +0x20 отказ по mode | 0 | 0 |
| +0x22 отказ по beacon_type | 0 | 0 |
| +0x24 тик relaxation | +36 | +37 |
| +0x26 принято | +36 | +37 |

С одинаковым SSID результат тот же в пределах шума (SSW +37/+36, чужих маяков
+6912/+7119): существенно только то, что оба маячат под своими BSSID.

### 3.3. Темп ответов задаёт `n_bis_abft` **[железо]**

Окно A-BFT бывает раз в `n_bis_abft` интервалов маяка (стенд: 4). BI = 100 TU =
102.4 мс → 9.766 BI/с, / 4 = 2.44 окна/с; измерено 37/15 = 2.47. Запись с хоста
`n_bis_abft: 4 → 1` (слово 0x94143c = 0x0f000001, сохраняя `fss = 0x0f`) действует
немедленно:

| | n_bis_abft = 4 | n_bis_abft = 1 |
|---|---|---|
| узел A, отправлено SSW | +36 (2.40/с) | +147 (9.80/с) |
| узел B, отправлено SSW | +37 (2.47/с) | +146 (9.73/с) |
| отказы mode / beacon_type | 0 / 0 | 0 / 0 |
| `Discovery A-BFT link up` в окне лога | 3 | 8 |

### 3.4. Линк без ролей до READY_FOR_ASSOC **[железо]**

Два PCP в OOB без ассоциации находят друг друга через A-BFT, проходят beamforming,
получают CID и доводят CONN_MSM до `READY_FOR_ASSOC` на стоковой прошивке. Лог
прошивки (кольцо 0x843900, `blob_fw_peri`), одинаково на обоих узлах, циклически:

    SYSTEM   INFO Ucode->BF_DONE_EVT      : type 0x06
    SYSTEM   INFO BF DONE: OK. Flow type: BF_SUBFLOWS_DONE_ABFT_TXSS
    SYSTEM   INFO [NNL] CID= 0 STATE=  3 SUBSTATE=  0
    SYSTEM   INFO     DSH DBG: TX Sector: 11 RX Sector: 0
    MOD13    INFO conn::linkup_ntf status=0
    INFRA    INFO Inject SM_EVT_NTF_LINKUP event to CONN_MSM. Next state: READY_FOR_ASSOC
    CONN_MGR INFO conn_main_sm:: bf_ntf for CID 0 with status 0.
    MOD9     INFO scan_mngr::handle_link_up_event() SM STATE = 0, m_active_probs = 0
    SYSTEM   INFO Discovery ABFT Notify status 1 (BF_DONE_OK = 1)
    MOD12    INFO handle_abft_event() Discovery A-BFT link up status 0 (BF Status 1) for CID 0.

Хост о результате не узнаёт: `wil->sta[cid].addr` заполняется только в обработчике
`WMI_CONNECT_EVENTID` драйвера (`wmi.c`), а это событие прошивка не присылает.
Результат A-BFT идёт в `scan_mngr` (`handle_link_up_event`; исходная строка
`scan_mngr::handle_abft_bf_result_in_scan() Added entry to m_scan_pend_list after
ABFT BF flow during scan`) — механизм обнаружения соседа, за которым по замыслу
следует обычная ассоциация.

---

## 4. CONN_MSM: почему связь стоит в READY_FOR_ASSOC

### 4.1. Переходы и источники событий **[код]**

Таблица переходов CONN_MSM (trans=0x802008, события 0x801050 × 11, состояния
0x80107c × 9; см. [STATE-MACHINES.md](STATE-MACHINES.md), `4.1/ref/SM-TABLES.txt`):

    READY_FOR_ASSOC × SM_EVT_OWN_ASSOC       -> conn_main_sm__send_assoc_resp_pbss -> WAIT_FOR_ASSOC_DONE
    READY_FOR_ASSOC × SM_EVT_NTF_ASSOC_START -> pcp_ap__set_aid                    -> WAIT_FOR_ASSOC_DONE
    READY_FOR_ASSOC × SM_EVT_NTF_ASSOC_DONE  -> pcp_ap__set_aid                    -> WAIT_FOR_LM_START
    WAIT_FOR_LM_START × SM_EVT_NTF_LM_STARTED -> conn_msm__on_ntf_lm_started__…    -> ASSOCIATED

События: 0 OWN_START_LINK, 1 BCON_RX, 2 NTF_LINKUP, 3 OWN_ASSOC, 4 NTF_ASSOC_START,
5 NTF_ASSOC_DONE, 6 NTF_LM_STARTED, 7 NTF_KEY_INSTALLED, 8 OWN_DISC,
9 NTF_DISC_COMPLETE, 10 — abort. Объект: conn_msm = conn + 0xfc (`add2 r0,r14,0x3f`
в `conn__linkup_ntf` @0x8edba6; `conn_msm__init` @0x8d5b1c кладёт родителя в sm+0x2c).

| адрес | блок | событие |
|---|---|---|
| 0x8f1384 | `conn__bind_cid_to_lm` | 0 OWN_START_LINK |
| 0x8c3ee2 | `discovery__inject_sm_event` | 1 BCON_RX |
| 0x8edbb0 | `conn__linkup_ntf` | 2 NTF_LINKUP |
| 0x8da48a | `mlme__inject_evt4` | 4 NTF_ASSOC_START |
| 0x8da474 | `conn_msm__inject_ntf_assoc_done` (0x8da460) | 5 NTF_ASSOC_DONE |
| 0x8d9cb6 | `mbox__notify_sm` | 6 NTF_LM_STARTED |
| 0x8ed5e4 | `l2mgr__notify_key_ready` | 7 NTF_KEY_INSTALLED |
| 0x8eb1c2 | `conn__disconnect` | 8 OWN_DISC |
| 0x8e8dea | `conn__abort` | 10 |

Событие 3 прямой инъекцией не впрыскивает никто: все 14 мест вызова
`basic_sm__inject_event` с событием 3 принадлежат другим автоматам (`find_mngr+0x1c`,
`radio_mgr+0x28`, `ba_sm+0x74`, `lm+0x34`, `maintain+0x50`, psc, rf_kill, scan_mngr,
pcie_power; у 3–5 мест объект приходит косвенно, принадлежность — по контексту);
`conn_main_sm__send_assoc_resp_pbss` @0x8c3210 в коде не упомянут, достижим только
через таблицу. Единственный путь — отложенное событие ниже.

### 4.2. Объектная модель **[код] [железо]**

    conn = 0x8046f0 + i*0x198  (8 штук; mem_pool__init @0x8d64c6: r2=0x198, r3=8)  fw_data
      +0x08 cid  +0x09 aid  +0x0c ptr mid  +0x10 MAC соседа
      +0x18 u32 «надо ассоциироваться» (following_connect)   <- главный гейт
      +0x1c u32 «direct PBSS member» (ассоциация без кадров)
      +0x20 u32 «линк готов немедленно»
      +0x64 lm_if  +0xb0 MLME_SM  +0xfc CONN_MSM  +0x12c DISCONN_SM
    таблица CID: 0x80469c + cid*8 = { busy, ptr conn }

    lm (LM_MAIN_SM) = 0x841b84 + cid*0x110   -> fw_peri, host 0x909b84 + cid*0x110
      lm_if__set_cid @0x8e1636: `mul64 r1,0x110 ; add r0,mlo,0x841b84`
      lm+0x34 = MAINTAIN_SM, lm+0x84 = LINK_STATS_SM

`basic_sm`: +0x00 состояние, +0x01 число событий, +0x02 число состояний, +0x04 флаг
отложенного события, +0x18 таблица переходов, +0x28 флаг трассировки.

На железе: `0x909b84 = 0x00070c02` (LM: состояние 2 CONFIGURED, 12 событий,
7 состояний), `0x909bb8 = 0x00040a00` (MAINTAIN: 0 STOPPED, 10 событий, 4 состояния).

### 4.3. Причина **[код] [железо]**

`mid__acquire_link` @0x8d7814 — единственный путь создания conn из BF-события:

    8d781a mov_s  r13,0x0
    8d7822 bl.d   0x8d7838        ; mid__link_acquisition_action
    8d7826 _mov_s r3,r13          ; r3 = 0  ->  [conn+0x18] = 0

Гейт в `conn_main_sm__linkup_ntf` @0x8d7cd8:

    8d7cda brne_s r15,0,0x8d7cf8  ; status != 0 -> мимо
    8d7cdc ld_s   r0,[r0,0x18]
    8d7cde cmp_s  r0,0x1
    8d7ce4 mov.eq r1,0x3          ; SM_EVT_OWN_ASSOC
    8d7cf0 bleq.d 0x8e20c0        ; store_pending_event

`OWN_ASSOC` ставится только при status == 0 и `[conn+0x18] == 1`. При 0 MLME не даёт
`ASSOC_DONE` → `lm_if__on_aid_assigned` не зовётся → LM не получает
`START_MAINTAIN_REQ` → MAINTAIN_SM остаётся в `STOPPED`, где `EVT_BF_RESULTS` уходит
в пустышку. Наблюдаемый цикл — повторные `NTF_LINKUP` → `conn_main_sm__bf_ntf`
@0x8c3f20.

Штатно `[conn+0x18] = 1` ставят `mid__connect` @0x8c6354 (команда хоста CONNECT) и
`mid__add_connection` @0x8dc03c из `pbss__add_sta` (под гейтом «MLME уже ASSOCIATED»).

Правка 2 байта: `0x8d7826: _mov_s r3,r13` → `mov_s r3,0x1` (`MOV_S b,u8`); r13
дальше используется как ноль (`mov.eq r0,r13` @0x8d782a).

Ограничение: `conn_main_sm__send_assoc_resp_pbss` @0x8c3214 начинается с

    8c321e ld_s  r0,[r0,0x50]    ; m_bss_mode
    8c3220 cmp_s r0,0x1
    8c322a beq_s 0x8c3250        ; != 1 -> fw_sysassert_fatal(conn_main_sm.cpp, 4549)

`[mid+0x50]` — `m_bss_mode` (`bss_set_mode` 0x8c4594): 1 — станция, 2 — PBSS-PCP, 3 — AP
([HOST-INTERFACE](HOST-INTERFACE.md)); это не роль порта `WMI_PORT_*`. У AP-узла стенда
`[0x805940] = 3` (`bss+0x08`); инъекция `OWN_ASSOC` допустима только при `m_bss_mode = 1`
**[код] [железо]**.

### 4.4. Трассировка автоматов **[код] [железо]**

`basic_sm__inject_event` @0x8d6a4c при `[sm+0x28] != 0` печатает `Inject %s event
to %s. Next state: %s` (модуль 5 INFRA, уровень 2). CONN_MSM трассируется в стоке
(`conn_msm__init` @0x8d5b56); `basic_sm__setup` @0x8d649c для остальных пишет 0.

| автомат | host (cid=0) | формула |
|---|---|---|
| LM_MAIN_SM | 0x909bac | 0x909bac + cid*0x110 |
| MAINTAIN_SM | 0x909be0 | 0x909be0 + cid*0x110 |
| LINK_STATS_SM | 0x909c30 | + cid*0x110 |
| MLME_SM (conn+0xd8) | 0x9047c8 | + i*0x198 |

Запись 1 принимается; обмен A-BFT при этом не нарушается.

### 4.5. Маркеры в логе

| строка | адрес | означает |
|---|---|---|
| `mid::link_acquisition_action() following_connect: %d.` | 0x100b620 | будущее `[conn+0x18]` |
| `LINKUP Failure PCP Assoc ready = 0!!!` | 0x100f704 | маяк соседа не даёт разрешения |
| `conn::linkup_ntf status=%d` | 0x100e2e4 | впрыск NTF_LINKUP, status должен быть 0 |
| `conn_main_sm:: bf_ntf for CID %d with status %d.` | 0x100f75c | наблюдаемый цикл |
| `Sending mlme_sm::ASSOC_RESPONSE for direct STA PBSS member` | 0x100f790 | ассоциация без кадров |
| `PCP AP after association. Set conection ID: %d, AID: %d` | 0x100f7cc | `pcp_ap__set_aid` отработал |
| `MAINTAIN_SM::OPEN BF Triggers` | 0x1011f3c | OPEN дошёл до конца |
| `MAINTAIN_SM::FBF_DELAYED END - Start Rate Search` | 0x1011fb0 | MAINTAIN в ACTIVE |
| `[L2MGR] publish association_done_evt CID: %d` | 0x100c5ec | ASSOCIATED |
| `data_port_open_timeout_cb` | 0x100f240 | 3 с истекли → disconnect |

Таймаут data-port `[0x800088]` = 3000 мс (host 0x900088); лимит неудачных FBF —
байт `[0x80023a]` = 3 (host 0x90023a).

### 4.6. Мёртвые события **[код]**

* `LM_EVT_LINK_STAT_UPDATE` (10) не впрыскивается нигде (перебраны 138 сайтов
  `inject_event` и 19 сайтов `store_pending_event`) ⇒
  `lm_main_sm__on_link_stat_update` @0x8d7ac0 мёртв, `[lm+0x104]` write-only.
* MAINTAIN_SM событие 7 `EVT_CONSECUTIVE_HIGH_PER` — без впрысков.

### 4.7. Прямой PBSS в 6.2 **[код]**

SM_EVT_OWN_ASSOC в READY_FOR_ASSOC (автомат соединения) → `conn_main_sm__action_8c3bf4` 0x8c3bf4: требует `mid+0x50 == 1`
(m_bss_mode, иначе фатал 0x11c5 — тот же гейт, что на пути к ассоциации по
лучу в 4.1) и ненулевой conn+0x24 (иначе 0x11c6); если в conn+0x28 уже лежит
принятый запрос — «Sending mlme_sm::ASSOC_RESPONSE for direct STA PBSS
member» и событие 4 в MLME (объект conn+0xf0), иначе событие 0 (сам начинает
ассоциацию). В прямом PBSS роль «кто отвечает» решает наличие встречного
Assoc Req, а не роль PCP.
Событие хосту — `WMI_PBSS_JOINED` 0x15 (`l2mgr__send_pbss_joined_evt`,
[MLME §1](MLME.md#1-mlme-ассоциации--автомат-0x802458-unassociateassociateassociated-14-событий)).

---

## 5. Управляющие кадры: распределители fw **[код] [железо]**

**Верхний: `rx_mgmt_srvs__distribute` @0x8df014**, таблица 0x802624, 15 записей,
база 0x8df03e, множитель 2 (`add1 r0,r0,r10`), подтип ≥ 15 → 0x8df0b0.
Байты: `00 00 00 00 0d 0d 39 39 39 39 00 39 39 21 2d`.

| подтип | 802.11 | цель |
|---|---|---|
| 0, 1, 2, 3, 10 | Assoc Req/Resp, Reassoc Req/Resp, Disassoc | 0x8df03e → `rx_pkt_handler` |
| 4, 5 | Probe Req/Resp | 0x8df058 (путь discovery) |
| 6, 7, 8, 9, 11, 12, ≥15 | Timing Adv, reserved, Beacon, ATIM, Authentication, Deauth | 0x8df0b0 |
| 13 | Action | 0x8df080 |
| 14 | Action No Ack | 0x8df098 |

0x8df0b0 передаёт кадр хосту:

    8df0b0 mov  r2,0x1010a6c      ; строка
    8df0b8 bl   fw_log (уровень 1, модуль 13)
    8df0d0 mov  r1,0x61 ; asl r1,0x6   ; = 0x1840
    8df0da bl   0x8e0874           ; событие хосту

Строка 0x1010a6c: `<<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID UNHANDLED MGMT,
sub type = 0x%x !!!!`; 0x1840 = `WMI_RX_MGMT_PACKET_EVENTID`. Принятый
Authentication прошивка не обрабатывает, а поднимает хосту.

**Нижний: `rx_pkt_handler` @0x8df208**, таблица 0x801ff4, подтипы 0..10
(`brhs r6,0xb,0x8df30a`), база 0x8df260, множитель 2. Байты:
`00 42 55 55 55 55 55 55 55 55 51`. Подтип 0 → 0x8df260, 1 → 0x8df2e4, 10 →
0x8df302, 2..9 и ≥ 11 → 0x8df30a: строка `Unknown stype... cid %d, stype %x, length
%d` и `fw_sysassert_fatal` (0x8c82c0, `mlme_sm.cpp`, строка 4608). Единственный
вызывающий — 0x8df050 (ветка подтипов 0/1/2/3/10).

Строки настройки аутентификации: `auth_mode=%d, crypt_mode=%d, offload_mode=%d`
0x100a148, `Config Security Mid[%d] configured: ... auth_mode = %x` 0x100efc8.

Сырой Association Request (57 Б: FC subtype 0, Capability 0x0021, Listen Interval
10, SSID, IE 148 DMG Capabilities 17 Б) через debugfs `tx_mgmt` → `wil_cfg80211_mgmt_tx`
→ `wmi_mgmt_tx` (`WMI_SW_TX_REQ`) уходит в эфир, подтип не фильтруется **[железо]**:

    CONN_MGR INFO HOST SW TX: Sending [type = 0, sub_type = 0]
    MOD7     INFO SW TX MGMT: send packet 57 bytes, complete cb 0x30b44

Приёмник заводит под кадр новое соединение (CID 1, не CID 0 от A-BFT) и разрывает
его с reason 6 = `CLASS2_FRAME_FROM_NONAUTH_STA`
(`WMI_DISCONNECT_EVENTID wmi reason 6, protocol reason 1`). С предварительным
Authentication (subtype 11, Open System, 30 Б) появляется
`lm_main_sm::config_lmac_bf_sm CID=1`, узел строит и шлёт Disassociate (26 Б,
`mlme_notify: CID 1 protocol_reason 3`), итог — разрыв.

---

## 6. IBSS и BSSID в 4.1 **[код]**

WMI (`wmi.h`): `WMI_NETTYPE_INFRA = 0x01`, `ADHOC = 0x02`, `ADHOC_CREATOR = 0x04`,
`AP = 0x10`, `P2P = 0x20`. `mid__type_of` @0x8cabe4 читает `mid+0x14`:

| возврат | типы |
|---|---|
| 0 | ADHOC (2), ADHOC_CREATOR (4), P2P (0x20) |
| 1 | INFRA (1) |
| 2 | AP (0x10) |
| ассерт `mid.cpp` | прочее |

Adhoc-код делегирует хосту: `find_main_sm__probe_req` @0x8ef2a4 (`brne r0,0x2`) при
ADHOC печатает строку 0x10149c4 `FIND_SM:: DO NOT reply to this Probe REQ <<<<<<
Should be handled by HOST >>>>>` и выходит; @0x8ef3e8 и
`find_main_sm__probe_req_in_search` @0x8ef5ee (`breq r0,0x2`) при ADHOC пропускают
`memcpy` адреса назначения (DA остаётся широковещательным). IBSS-биконинга и слияния
TSF в прошивке нет.

`mid__copy_bssid` @0x8c9ae4:

    ld r1,[bss+0x04]
    brne r1,0x2 -> memcpy(dst, bss+0x0c, 6)        ; сохранённый BSSID
    иначе      -> memcpy(dst, [bss+0x00]+0x0a, 6)  ; mid+0x0a = свой MAC

`bss+0x0c` пишет 0x8e15f0 (`memcpy(bss+0x0c, arg1, 6)`), три вызывающих; в
`l2_mgr__connect`:

    8ea7c2 add3 r0,r16,0x9   ; r0 = mid+0x48 = bss (вызов @0x8ea7c8)
    8ea7c8 bl.d 0x8e15f0
    8ea7cc _add r1,r14,0x2a  ; тело команды хоста + 0x2a

0x2a — смещение `bssid[6]` в `struct wmi_connect_cmd` (8 байт полей + `ssid[32]`
0x08..0x27, `channel` 0x28, `edmg_channel` 0x29). Чужой BSSID задаётся хостом при
connect; в маячащей роли PCP/AP BSSID — свой MAC.

## Прежние имена функций

| адрес | прежнее имя | текущее имя |
|---|---|---|
| 0x8d7238 | `boot__read_chip_id` | `oob_mode__read_bit` |
| 0x8ed398 | `l2mgr__oob_mode` | `l2mgr__init` (layer2_mgr.cpp) |
| 0x8da460 | `mlme__on_link_lost` | `conn_msm__inject_ntf_assoc_done` |

## Замечания

* Наличие кода нельзя выводить по отсутствию лог-строк: отсутствие строк
  про Authentication не означает отсутствия пути (§5).
* Адреса констант могут строиться сдвигом (0x880018 = `0x11 << 19` + 0x18; поиск
  литералов `0x880018`/`0x8800xx` их не находит), а писатели структуры — идти через
  другую базу со смещением (0x8033dc + 0x8c).

## Не установлено

* Полный перечень эффектов 27 читателей гейта OOB.
* Биты 1, 2, 3, 6, 10, 12, 13 `special_flags` — следствия по первичному разбору
  читателей, по одному не проверены.
* Что делают `txss__prepare_frames`/`txss_rx_step` по биту 1 маски в конфигурации с
  общим BSSID; имена r37 бит 24 / r42 бит 16 в вендорском файле регистров
  (здесь — `ss_bitmap[0]` и `ppdu_report_event`).
* Какое условие `mlme_sm__assoc_req_handle` @0x8e9940 даёт reason 6 и достижимо ли
  оно с хоста; дошёл ли принятый Authentication до `rx_mgmt_srvs__distribute`.
* Попадает ли сосед, найденный через A-BFT (`m_scan_pend_list`), в результаты скана
  хоста.
* Имя `rx_funcs__on_rx_type_0x14` (обработчик BRP) требует уточнения.

## Источники

* `4.1/src/asm/fw/blocks.json`, `4.1/src/asm/uc/blocks.json`, `blobs/insns/INSNS-4100.txt`,
  `4.1/ref/SM-TABLES.txt`, `6.2/src/asm/fw/blocks.json`.
* [LMAC-PROTOCOL.md](LMAC-PROTOCOL.md), [MAC-REGISTERS.md](MAC-REGISTERS.md),
  [STATE-MACHINES.md](STATE-MACHINES.md), [BF-ENGINE.md](BF-ENGINE.md), [WMI.md](WMI.md),
  [HOST-INTERFACE.md](HOST-INTERFACE.md), [MLME.md](MLME.md), [L2-MANAGER.md](L2-MANAGER.md).
* Пак 11ad: `special_mode_flags_s` и `pf_*` из `fw_image_globals.xml`.
* Исходник драйвера wil6210 backports-7.2 (`wil_set_oob_mode`, main.c).
