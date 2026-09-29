# Структуры 4.1: RX-пул, vif/mid, bss, radio_manager

Разметка по членам объектов прошивки 4.1.0.1000. Назначение объектов и общая
для версий модель (пулы `mem_pool`, vif/mid, bss, RX-пул, radio_manager) —
[docs/FW-OBJECTS.md](../../docs/FW-OBJECTS.md#4-общие-объекты-vifmid-bss-rx-пул-radio_manager).
Уровень доказанности по умолчанию — **[код]**; значения «живое» сняты с
памяти узла в роли PCP (SSID `WL60TEST`, BI 100 TU, связь со станцией
26:18:1d:26:d4:7b) — **[железо]**.

## 1. RX-пул кадров (`rx_pool`)

База пула **0x84af54**, **12** элементов, шаг **0x538** (конец 0x84edf4):

    0x84af54 0x84b48c 0x84b9c4 0x84befc 0x84c434 0x84c96c
    0x84cea4 0x84d3dc 0x84d914 0x84de4c 0x84e384 0x84e8bc

### Создание
`rx_pool__init` @**0x8d626c**:

    8d6272 mov  r13,0x84af54          ; база пула
    8d6278 mov  r1,0x3ea0             ; 16032 = 12*0x538
    8d627e bl   memset0_words
    8d6284 mov  r14,0x8062c4          ; объект rx_pool в fw_data
    8d628a add  r0,r14,0x1c           ; дескриптор mem_pool = 0x8062e0
    8d6290 mov  r2,0x538              ; размер элемента
    8d6294 bl   mem_pool__init        ; r3 = 0xc  (12 элементов)
    8d629a bl   rx_macq__init
    8d629e mov  r13,0x843800 ; memset 0x100
    8d62b4 bl   rx_pool__configure_ring(0x8062c4, 0x843800, 8, 4)

`mem_pool__init` @0x8c6c70 заполняет дескриптор (`+0x04` база, `+0x08` размер,
`+0x10` кол-во, `+0x0c` = 0, `+0x00` head), `mem_pool__link_free_list`
@0x8c487c прошивает свободный список.

Живое: `0x8062e0 = {head=0x84c96c, base=0x84af54, elem=0x538, used=8, total=12}` **[железо]**.

Кольцо: `rx_pool__configure_ring` @0x8d5dbc → `dma_mgr__configure_ring`
(ring_id=4, phys=0x43800, n=8); кольцо **0x843800, 8 дескрипторов по 32 Б** —
формат `vring_rx_desc` драйвера (`+0x10` d0, `+0x14` addr_low, `+0x1e` length),
пишется в `rx_buf__init_descriptor` @0x8dee00.

### Раскладка элемента (0x538 = 1336 Б)

Размер тела: `mid__refill_rx_buffers` @0x8e1e6c `sub r3,r1,0x38`, где
`r1 = [0x8062e8] = 0x538` → длина буфера для DMA = **0x500 = 1280**; адрес для
DMA = `alloc() & 0x3ffff`; `rx_api__alloc_rx_buffer` @0x8c2c16 возвращает `elem+0x38`.

| смещ. | разм. | поле | якорь |
|---|---|---|---|
| +0x00 | 4 | `next` свободного списка | 0x8c4886-0x8c4890 |
| +0x08 | 4 | `data` = elem+0x38 | 0x8c2c10/0x8c2c16, 0x8df124-0x8df128 |
| +0x10 | 4 | флаги (обнуляются) | 0x8df12c |
| +0x14 | 4 | текущий указатель (после снятия 24-байтного MAC-заголовка = elem+0x50) | 0x8df124, дамп elem10/11 |
| +0x18 | 2 | `mbox_hdr.seq` (из 0x803dbc) | 0x8e04d6 / 0x8e0522 |
| +0x1a | 2 | `mbox_hdr.len` = 8 + 16 + длина кадра | 0x8e04ee |
| +0x1c | 2 | `mbox_hdr.type` (0 = WMI) | 0x8e04d0 |
| +0x1e | 1 | `mbox_hdr.flags` | 0x8e04da, биты 0x8e050c… |
| +0x1f | 1 | `mbox_hdr.reserved` (младший байт len) | 0x8e04f2 |
| +0x20 | 1 | `wmi_cmd_hdr.mid` | 0x8e04f6 |
| +0x22 | 2 | `command_id` = **0x1840 `WMI_RX_MGMT_PACKET_EVENTID`** | 0x8e0502 |
| +0x24 | 4 | `fw_timestamp` — таймер **0x880254** (не TSF) | 0x8e0506 |
| **+0x28** | 16 | **`struct wmi_rx_mgmt_info`** (нагрузка события) | указатель в 0x8c2c10, 0x8dee7c; `rx_mgmt_srvs__distribute` @0x8df0c8 |
| +0x28 | 1 | mcs | по структуре драйвера |
| +0x29 | 1 | snr | |
| +0x2a | 1 | range | |
| +0x2b | 1 | sqi | |
| +0x2c | 2 | **stype** (подтип 802.11) | дамп: 0x0000 у Assoc-Req, 0x0004 у Probe-Req — совпадает с FC кадра **[железо]** |
| +0x2e | 2 | status | |
| +0x30 | 4 | **len** кадра | дамп: 33 / 93 / 86 — совпадает с разбором IE **[железо]** |
| +0x34 | 1 | qid | ассерт «0 или 1» в 0x8dee84 |
| +0x35 | 1 | mid | |
| +0x36 | 1 | cid | |
| **+0x37** | 1 | **channel** | `rx_pkt_srvs__dispatch` 0x8df12e (`add_s r1,0x37`) → `rx_pkt__stamp_channel` 0x8c9f74, `stb r1,[r13]` @0x8c9f84; значение из vmethod радио-менеджера `[[gp-0x30]+0]+0x1c` = 0x8c9f6c, возвращающего `rm_sm+0xd0` (раздел 3) |
| +0x38 | 0x500 | тело кадра 802.11 | 0x8e1e6c |

Шапка +0x18..+0x27 — `wil6210_mbox_hdr` + `wmi_cmd_hdr`:
`basic_if__mailbox_send` @**0x8e04ce** делает `sub r13,r13,0x10`, то есть шапка
ложится на `elem+0x28 − 0x10`. В дампах: `+0x18 = u16 9/7`, `+0x1a = len+24
(0x75/0x6e)`, `+0x1e..+0x1f = 02 75` (flags=2 и младший байт len),
`+0x20 = 0x18400000`, `+0x24` — быстро меняющийся таймер 0x880254. У BA/ADDBA/Action
шапка нулевая: эти кадры уходят внутренним обработчикам, событие хосту не
строится. Та же константа 0x1840 используется при делегировании хосту кадра
Authentication (`rx_mgmt_srvs__distribute` → 0x8df0b0).

Содержимое пула на стенде **[железо]**: elem7/8/9 — Action Block-Ack
(ADDBA Req/Resp, len 33), elem10 — Association Request с SSID «WL60TEST»
(len 93), elem11 — направленный Probe Request (len 86); все от
24:18:1d:26:d4:7b к 26:18:1d:24:3b:0b. Пул не очищается и не реагирует на обрыв
связи — в нём остаются последние принятые mgmt-кадры. Адреса вида 0x84d94c —
это `elem+0x38` элемента 0x84d914, а 0x84de4c — база элемента №9 (`next`).

## 2. vif/mid (0x2e4 Б) с вложенным bss по +0x48

`mid_pool__init` @**0x8d61a4**:

    8d61b0 mov r13,0x8058d0        ; голова llist
    8d61b6 mov r1,0x8058f0         ; база элемента
    8d61bc add r0,r13,0xc          ; дескриптор mem_pool = 0x8058dc
    8d61c0 mov r2,0x2e4            ; размер = 740
    8d61c4 bl  mem_pool__init      ; r3 = 1  (один элемент)
    8d61ca bl  llist__init(0x8058d0)

Живое: `0x8058dc = {head=0, base=0x8058f0, elem=0x2e4, used=1, total=1}`.
Верхняя граница подтверждается записью `[mid+0x2e0]` в `l2_mgr__pcp_start_flow` @0x8dc550.

**vif = mid = 0x8058f0 … 0x805bd3 (740 Б), один экземпляр.** `vif+0x4c`
(bss_mode) = 0x80593c, `vif+0x14f` (bss_bi_ctrl) = 0x805a3f.

**bss = mid + 0x48 = 0x805938** — идиома `add3 rX,mid,0x9` (= +0x48) перед
вызовом bss-функций: `mid__open` @0x8c2d90, `l2_mgr__wmi_cmd_handler_set_ssid`
@0x8f3326, `tx_bcon__update_bcon` @0x8c2198, `l2_mgr__pcp_start_flow` @0x8dc584.

### Поля mid (база 0x8058f0)

| смещ. | адрес | поле | якорь | живое |
|---|---|---|---|---|
| +0x00/+0x04 | 0x8058f0 | узел llist (`+0x04` → 0x8058d0) | 0x8d61ca | 0x8058d0 |
| **+0x0a** | 0x8058fa | **свой MAC (6 Б)** | `mid__copy_bssid` 0x8c9afc-0x8c9b00; 0x8dc554 | 26:18:1d:24:3b:0b |
| +0x10 | 0x805900 | mid id (байт) | `mid__open` 0x8c2d7c, `mid_list__by_mid` 0x8ca1d0 | 0 |
| +0x14 | 0x805904 | network type (маска 1/2/4/0x10/0x20) | `mid__type_of` 0x8cabe6 | 0x10 |
| +0x24 | 0x805914 | сброс в 0 | 0x8c2d80 | |
| +0x28 | 0x805918 | счётчики | `mid__set_default_counters` 0x8c2d9e | |
| +0x48 | 0x805938 | **bss** | — | |
| +0x1c8 | 0x805ab8 | RSN IE по умолчанию (0x30,0x14,ver=1, 00-0F-AC-08 …) | `mid__set_default_dmg_params` 0x8c9726/0x8c972c | |
| +0x234 | 0x805b24 | подобъект PCP (vtable по +0x00 = 0x8006ac) | 0x8c19a6, 0x8c2d86 | |
| +0x2b4 | 0x805ba4 | объект «программирование MAC в HW» | `mid__program_mac_addr` 0x8c2da6 | |
| +0x2e0 | 0x805bd0 | последнее слово структуры | 0x8dc550 | |

### Поля bss (база 0x805938 = mid+0x48)

| смещ. | адрес | поле | якорь | живое |
|---|---|---|---|---|
| +0x00 | 0x805938 | обратный указатель на mid | `mid__init` 0x8d6576; 0x8c9afc | 0x8058f0 |
| +0x04 | 0x80593c | **состояние/режим BSS** (2 = активна; = vif+0x4c) | `bss_set_active` 0x8c458a; 0x8c21e2; 0x8c9aea | 2 |
| +0x08 | 0x805940 | mode (2/3) | `bss_set_mode` 0x8c459c; 0x8dc5d6 | 3 |
| **+0x0c** | 0x805944 | **BSSID (6 Б)** | `mid__copy_bssid` 0x8c9af0 | 26:18:1d:24:3b:0b |
| **+0x26** | 0x80595e | **SSID (32 Б)** | `mid__set_ssid` 0x8e2112; `mid__copy_ssid` 0x8ca938; `verify_ssid` 0x8e7210 | `WL60TEST` |
| **+0x48** | 0x805980 | **длина SSID (u32, 1..32)** | 0x8e2104/0x8e210c; 0x8e71f2 | 8 |
| **+0x4c** | 0x805984 | **индекс канала (байт)** | `l2_mgr__pcp_start_flow` 0x8dc5cc `stb r18,[r14,0x4c]`, r18 = `[0x8033dc]` | 0 |
| +0x4e/+0x50 | 0x805986/88 | u16 = 100/100 (не меняются при смене BI) | дамп | 100/100 |
| **+0x52** | 0x80598a | **Awake Window (u16)**, по умолчанию 1000 | `mid__set_awake_window` 0x8e1590 `stw r1,[r0,0x52]`; геттер 0x8c989e; init 0x8d6582/86 | 1000 |
| **+0x54** | 0x80598c | **hidden_ssid (байт)** | 0x8dc5e0; проверка 0x8f332a | 0 |
| +0x58 | 0x805990 | 0 при init | 0x8d658a | 0 |
| **+0x5c** | 0x805994 | **Capability Info (u16)** | `bss_set_mode__capinfo` 0x8c439e-0x8c43ac (bset b2, bic 0x18, or r2<<4, bclr b5) | 0x0007 |
| **+0x5e** | 0x805996 | **DMG Capabilities (17 Б)**: MAC(6) + AID(1) + STA-cap(8) + AP/PCP-cap(2) | побайтово равно телу IE 148 в принятых кадрах | `26 18 1d 24 3b 0b 01 11 d1 b7 06 00 00 40 10 00 00` |
| **+0x75** | 0x8059ad | **массив 8 × 17 Б** — DMG-cap слоты станций PBSS, первый байт = 8 | цикл `mid__init` 0x8d6594-0x8d65a8 (`[bss+0x75+i*0x11]=8`) | 0x08 на 0x8059ad/be/cf/e0/f1, 0x805a02/13/24 |
| **+0x107** | 0x805a3f | **`bss_bi_ctrl`, 6 Б** (Beacon Interval Control, 48 бит) | см. ниже | `80 7c 40 80 00 10`, за полем `00 00` |
| +0x10c | 0x805a44 | байт с битом PCP-Assoc-Ready (бит 4) | `bss_bi_ctrl_PCP_ready_set` 0x8c42c2/0x8c42c6; чтение 0x8c21e6 (`lsr 4; bmsk 1`) | 0x10 → ready=1 |
| +0x10e | 0x805a46 | **`old_vendor_specific`, 12 Б** | `set_old_wilocity_vs` @0x8e1bb4 | `aa 6c 00 01 02 03 00 40 …` |
| +0x11a | — | «новый» vendor-specific элемент | `build_vendor_ie` @0x8e2284, OUI `04 CE 14` | |
| +0x1a8/+0x1ac | 0x805ae0/ae4 | обнуляются | 0x8d6578/0x8d657c | |
| +0x1b0/+0x1bc/+0x1c8/+0x1d4 | 0x805ae8/af4/b00/b0c | **4 дескриптора IE-буферов** `{ptr, len, ?}` по 12 Б (ptr → fw_peri, напр. 0x84a538/len 9, 0x84aa54/len 0x34) | `mid__init` 0x8d65ac/b8/c2/ce; `mid__get_bcon_additional_ies` | |

#### `bss_bi_ctrl` (+0x107, = vif+0x14f)
Длина 6 Б доказана копированием в `0x8e8960`:

    8e8962 add    r1,r1,0x14f    ; источник = mid+0x14f = bss+0x107
    8e8966 bl.d   memcpy
    8e896a _mov_s r2,0x6         ; длина = 6
    8e896c mov_s  r0,0x6         ; и возвращает 6

Шесть байт — 48 бит поля Beacon Interval Control стандарта; вендорское
`bcon_interval_ctrl_ei` тоже 48 бит. `tx_bcon__update_bcon` @0x8c2204 читает 8 Б
(`add r13,r13,0x107` @0x8c21d4; `bclr b1` = discovery_mode @0x8c21de;
`memcpy(sp+4, r13, 8)` @0x8c2204 → lo/hi в `lmac_if__send_bcon_mgt`), два
лишних байта — паддинг 0x80510d и первый байт `old_vendor_specific` (живьём нули).

#### `old_vendor_specific` (+0x10e, 12 Б)
`set_old_wilocity_vs` @0x8e1bb4, база `add3 r13,r0,0x20` = bss+0x100.

| смещ. | поле | писатель | читатель |
|---|---|---|---|
| +0x00..03 | `00 AA 6C 00` — OUI + OUI-type | иммедиаты 0x8e1bd0..0x8e1bda | — |
| +0x04..07 | флаги/версия из `[[0x800164]+0x40]` = 0x800944 | 0x8e1bdc…0x8e1bf0 | лог «flags %x» |
| +0x08 u16 | `networkType` (0x40 из `set_vendor_specific_version` @0x8e2210) | 0x8e1bee | `mlme_sm__assoc_req_handle` @0x8e9a92 |
| +0x0a u16 | `test_mode` | 0x8e1bf2 | @0x8e9a80 |
| все 12 | копия принятого от соседа старого VS-элемента | memcpy @0x8e1c16 | — |

Живое `aa 6c 00 01 02 03 00 40` раскладывается по этой таблице байт в байт.

### Период маяка и канал

* **`0x8002c0` = `g_bcon_interval` (u32, TU)** — единственный первичный
  экземпляр. Якорь: `wmi_handler_bcon_ctrl` @**0x8e7978** `st.as r4,[gp,0x150]`
  (gp=0x800170), r4 = `ldw [cmd+0x00]`. На стенде BI = 100 TU и
  `0x8002c0 = 100`, а масштабированный адрес (`gp + 0x150*4 = 0x8006b0`)
  содержит 127804 **[железо]**: в `INSNS-4100.txt` смещение при `.as` уже
  приведено к байтам, масштабировать вручную не нужно.
* **`0x8033dc` = `g_pcp_channel` (u32)**. Якоря: `wmi_handler_set_pcp_channel`
  @**0x8f3310**, `wmi_handler_pcp_start` @**0x8e7a16** (из `cmd+0x0d` =
  `wmi_pcp_start_cmd.channel`). Соседи того же блока: `+0x6c = security_en`,
  `+0x70 = sec_offload_en` (0x8e7998/0x8e799a; читается в
  `bss_bi_ctrl_PCP_ready_set` 0x8c42ae).
* **`0x8033d8 = 0x00854800`** — база `g_dbg_dashboard` ([DASHBOARD.md](DASHBOARD.md)).
* Раскладка старой `wmi_pcp_start_cmd` по `wmi_handler_pcp_start`
  (0x8e79de…0x8e7a16): +0x00 bcon_interval (le16), +0x02 pcp_max_assoc_sta,
  +0x03 hidden_ssid, +0x04 is_go, +0x0c network_type, +0x0d channel,
  +0x0e disable_sec_offload, +0x0f disable_sec.

## 3. radio_manager: кластер 0x8063f4…0x806500 (0x8064xx)

* **`radio_mgr` = 0x8063f4** (`[gp-0x30] = [0x800140] = 0x8063f4`, vtable
  `*0x8063f4 = 0x8007e8` — оба значения совпадают с живым дампом).
  `radio_mgr__init_pool_and_sm` @0x8d5c0c: `+0x04` = mem_pool {база **0x806500**,
  элемент **0x24**, кол-во **0x10**}; `+0x18` = llist (0x80640c); `+0x28` = **rm_sm**.
* **`rm_sm` = 0x80641c** (`radio_manager_main_sm__init` @0x8d59b8). Поля
  `basic_sm` сверены с живым дампом байт в байт: `+0x18 = 0x802b24` (таблица
  переходов), `+0x1c = 0x8015c4`, `+0x20 = 0x801594`, `+0x28 = 1`,
  `+0x2c = 0x80640c`, `+0x30 = 0x8063f4`. Вложенный `rm_chan_sw_sm` = rm_sm+0x34
  (0x806450), его таблица 0x802c8c лежит по 0x806468. Формат объекта `basic_sm` —
  [docs/STATE-MACHINES.md](../../docs/STATE-MACHINES.md).

| адрес | = | поле | якорь |
|---|---|---|---|
| **0x8064ec** | rm_sm+0xd0 | **текущий (primary) индекс канала**, 0xffff = нет | init `st 0xffff,[r0,0xd0]` @0x8d59c2; геттер @0x8c9f60 (`ld r2,[r0,0xd0]`, r0 = radio_mgr+0x28); `RADIO_MGR__unset_primary_channel` передаёт 0xffff |
| 0x8064f0 | rm_sm+0xd4 | второе возвращаемое значение геттера | 0x8d59c8 |
| **0x806490** | rm_sm+0x74 | запись «запрос канала», **0x28 Б** | ниже |
| **0x8064b8** | rm_sm+0x9c | вторая такая же запись (шаг 0x28; `memcpy` первой) | |
| 0x80648c | rm_sm+0x70 = **rm_chan_sw_sm+0x3c** | **канал в процессе переключения** | ниже |

Запись запроса канала строит `RADIO_MGR__set_primary_channel` (0x8e1ed8) →
vmethod `[vtbl+4] = 0x8e1e8c` (`mid__inject_sm_event`):

    8e1eb8 st r15,[sp,0x00]   ; канал
    8e1ebc st 1,  [sp,0x04]
    8e1eb6 st 0,  [sp,0x08]
    8e1eb4 st r13,[sp,0x0c]
    8e1eaa st r8, [sp,0x18]
    8e1eae st r4, [sp,0x1c]
    8e1eb2 st r14,[sp,0x20]   ; период маяка в TU (r3 в set_primary_channel)
    8e1ebe stb r3,[sp,0x24]
           -> basic_sm dispatch(rm_sm, …, sp, …)

Итого **+0x00 = канал, +0x04 = 1, +0x20 = период маяка в TU**; +0x10 и +0x14 не
пишутся (`radio_mgr__copy_tune_params` @0x8e59f4 перескакивает +0x10, читателей
нет). Живое: 0x806490=0 (канал), 0x806494=1, 0x8064a0=0x1820, **0x8064b0=100**;
0x8064b8=0, 0x8064bc=1, 0x8064c8=0x1820, **0x8064d8=100** — BI совпадает с
`g_bcon_interval`. Значение 0x1820 (6176) на +0x10 — остаток стекового кадра
`fw_log__emit1`, вызываемого перед vmethod. Источник:
`l2_mgr__pcp_start_flow` @0x8dc5be-0x8dc5c6 вызывает
`RADIO_MGR__set_primary_channel(r0 = канал из 0x8033dc, r3 = ld.as [gp,0x150])`.

`rm_chan_sw_sm+0x3c` (0x80648c) пишут `rm_chan_sw_sm__on_ch_switch_kick`
@0x8c4dee (`st 0xffff,[r13,0x3c]` — «канала нет») и
`rm_ch_switch_sm__switch_on` @0x8e342c (канал из записи запроса); читают
`rm_ch_switch_sm__notify_ch_switch_done` @0x8c4db8 (лог `[channel = %d]`) и
@0x8c4dd4. Значение переносится в `rm_sm+0xd0` через
`radio_mgr__set_tune_result` @0x8e49f8.

**Цепочка канала в RX:** `rx_pkt_srvs__dispatch` 0x8df12e → 0x8c9f74 → vmethod
0x8c9f6c → `ld [rm_sm+0xd0]` → `stb` @0x8c9f84 в `elem+0x37` (раздел 1).

## 4. Смежные глобалы и регистры

Момент ответа RX→TX 0x886d10, тайминги IFS в данных ucode (0x8019fc, 0x801a08) и
регистр 0x886d88 — общие для версий, описаны в
[docs/LMAC-PROTOCOL.md §3.1](../../docs/LMAC-PROTOCOL.md#31-команда-0x00-fui_cmds_hw_cfg_ifs_timing_cfg_s-по-body0x30-код-железо-пак);
мёртвые поля 0x80104a/0x80104c маски классов кадра —
[docs/ROLELESS-LINK.md §2.1](../../docs/ROLELESS-LINK.md#21-структура-код).

## Замечания
- Пул начинается с 0x84af54, а не с 0x84d900 (0x84d900 лежит внутри элемента
  0x84d3dc). Байт 0x84d94b = 0x84d914+0x37 — поле `channel` элемента 0x84d914.
- Пара байт `+0x1e..+0x1f` шапки при чтении как u16 выглядит как
  `0x200|(len+24)` — это flags=2 и младший байт len, не одно поле.
- `old_vendor_specific` начинается на bss+0x10e (12 Б), а не на +0x10f.

## Источники
- `4.1/ref/GLOBALS-fw.txt`, `4.1/ref/SM-TABLES.txt`
- [docs/FW-OBJECTS.md](../../docs/FW-OBJECTS.md), [DASHBOARD.md](DASHBOARD.md)
