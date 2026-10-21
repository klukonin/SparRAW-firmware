# Отличия rewrite от vendor (wil6210 6.2.0.1000) — состояние на 2026-10-20

## Итог

- **Образ целиком наш:** код fw (ARC600, C11) и код uc (MAC-CPU) — из rewrite; от vendor
  берутся только данные (fw_data, uc_data, AGC-таблицы).
- **Работает:** скан, BF, ассоциация с WL60TEST, данные. hwboot `RESULT: data`, linktest
  ping 0 %, iperf3 up ~975–985 / down ~1000–1020 Мбит/с (vendor ~988/968). `iw station dump`.
- **Покрытие fw:** из 2170 функций vendor (≥ 8 Б по SYMS.txt) 2132 упомянуты в портах —
  182 690 из 183 672 Б (99,5 %). Оставшиеся 38 адресов (`FUN_ram_008e4340` и т. п.) уже
  портированы под именами без vendor-адреса в комментарии (напр. 0x8e4340 —
  `rx_macq_pack_desc` в rx_chain.c, 0x8d8e5c — `calib_engine_sm_init` в power.c).
- **Weak-заглушек в fw.elf нет** (`arc-elf32-nm fw.elf | awk '$2=="W"'` пусто).
- **WMI:** все 102 команды vendor-диспетчера (docs/WMI-DISPATCH.md); UT 0x900 — модули 7, 9..13.

## Известные расхождения и незавершённое

| Что | Где | Статус |
|---|---|---|
| Зависание fw в калибровке self-TX (IF_GAIN sub 2) — 3 из 23 прогонов | calib_hw.c | исправлено: предел ~20 мс (DBG_SELFTX_TO 0x806a40) |
| Ассерт uc 0x6000/0x26 (INT6, MAC_HW_ICR б5: поздняя команда 0x37000020 на пути продолжения TXOP; код 0x6000 — лишь б0 txrx_state2) — ~1 из 25 | uc/rx.c `rx_txop_continue` | исправлено 2026-10-18: ветка RD (BA в нашем TXOP) шлётся из обработчика без возврата в rx_flow_run, O2 (`UC_HOT`) на цепочке; запас ≥ 8 инструкций (стресс UC_DBG_TXOP_PAD: старый код +4 — 9/9 сбой, новый +4/+8 — 0 из 5) |
| Редкие `ready`/`assoc` без данных бывают и у vendor (3/4 в серии 2026-10-18) — стенд/эфир | — | учитывать при оценке |
| UT модуль 9, подкоманда 0x983 (`hwf_sector_rf_chain_set` 0x8d7154) — вызов как vendor 0x8faa2e (2026-10-20) | ut_flows.c, rf_sector.c | сделано; стенд не проверял |
| Режим AP/PCP (2026-10-19, tools/hwboot_ap.sh): .12 — AP, .11 vendor STA — 4/4 data, iperf ~950–977 / 886–1018 Мбит/с; исправлены колбэки DMG beacon (65c9d3f5) и rs_start для cid 8 (09d96d24). PBSS/GO, безопасность (WPA offload) — не проверены; несколько станций на стенде из 2 устройств не проверить | — | работает (базово) |
| Большинство новых WMI-обработчиков (кроме STA-пути и NOTIFY_REQ) на стенде не проверены | wmi_h_*.c | не проверено |
| Порядок IE в probe req: снимок «dd07/dd27 переставлены» был до беззнакового сравнения eid (0716c922); статически сверено — 00 7f 72 94 dd07 dd27 dd0f, как в журнале vendor (2026-10-20) | mgmt_tx.c | совпадает; сверить журналом на стенде |
| Дубли портов (149 групп, в т.ч. `_cp`-копии) | ut_hw_drivers.c, sysapi_stats.c, mac_ext.c и др. | сделано 2026-10-19 (bb55dbbe, 5116c8ce — одиночные `_cp` без суффикса); функций `*_cp` нет (остались только имена регистров PHY `*_COUNTER_CP` — имена REGS-KNOWN) |
| vectors.c: `wbe_driver_pcie_debug` (0x8f7d20), `pcie_device_power_sm_traffic_resume_req` (0x8e05ec, DBI 0x60/0x64), `pcie_l1_latency_wa` (0x8ed7b4, DBI 0x40/0x70c/0x7c/0x708), запись BAR 0x8f0e14 (DBI 0x10/0x14 в PERST) — портированы 2026-10-20; вызов vendor по [0x8000e8] в 0x8f5e6c — указатель всегда 0 (доказано), не повторён | vectors.c | сделано; стенд: PERST deassert / hot reset, L1 |
| Событие ucode 0x22: vendor 0x8db8c4 → 0x8cb484 (итог пачки FTM → BURST автомату сессии conn->ftm), r2/r3 не читаются — бага vendor нет; порт звал не ту функцию (разбор кадра 0x8cb3bc), исправлено 2026-10-20 | lmac_evt.c | сделано; стенд: FTM-инициатор |
| Неинициализированные байты пула в событиях хосту/LMAC — единое правило: тело элемента обнуляет mem_pool_alloc_locked (2026-10-20); у сборщиков — «у vendor остаток слота пула» | pool.c (+ комментарии wmi_h_*.c, sysapi_stats.c, misc_ext_sysapi.c, pcp_ext.c) | сделано (заметно: 0x1a0f — статус 0) |
| Прежние TODO в fw/*.c (2026-10-20): портированы sniffer WMI_CFG_RX_CHAIN, edca__fill_default_ac_params (EDCA IE был с нулевыми AC), add_discovery_bcon, l2_mgr::connect_multi_omni (+ копия команды вместо указателя в кольцо ящика); прочие — утверждения | wmi_cmd.c, mid.c, stubs.c | сделано; стенд не проверял (sniffer, discovery, multi-omni, EDCA в probe resp/биконе AP) |
| cnt_handler__clear_all (0x8f6424): опрос lp N+1 при счётчике N — при полном таймауте счётчик −1 и ассерт не срабатывает (особенность vendor, сохранена; исправление даст ассерт при загрузке, если биты готовности не встают — только со стендом) | hw_init.c | кандидат в баг vendor |
| Порог ICCM: код до 0x8fc7b4 из 0x900000 (~14 КБ запаса) | fw.ld | следить |

## Сознательные отличия от vendor (баги vendor исправлены, с доказательствами в комментариях)

- Стековые буферы, уходящие в железо/хосту, обнуляются (vendor отдаёт остатки стека):
  правила MAC-парсера, дескриптор окна MACQ (mac_bringup), DBI-чтения pcie_l1_latency_wa,
  UT 0x42c и др.
- Буферы ящиков (события хосту, UT-ответы, LMAC-команды) — элемент пула обнуляет
  mem_pool_alloc_locked (vendor 0x8c33d0 не чистит — уходило содержимое прошлого сообщения).
- l2_mgr::connect_multi_omni: отложенный CONNECT берёт копию команды (vendor — указатель в
  запись кольца ящика, которую mbox__consume_one сразу отдаёт хосту).
- 0x8f5e6c: вызов по указателю [0x8000e8] (всегда 0 — переход на адрес 0) не повторён.
- 0x8d8230 (split-MAC IE): копия IE хоста в 256-байтный стек без проверки длины — в порту
  чтение напрямую из кадра (без переполнения).
- Отладочная область DBG 0x806a00..0x806a7f (include/dbg.h) — наша, vendor её не пишет.

## Сохранённые особенности vendor (с комментариями в коде)

Примеры: WMI 0x9a6/0x9a7 отвечают id 0x19a5; 0xa02 пишет таблицу по
непроверенному индексу хоста; SET_PASSPHRASE копирует по старой длине SSID; 0xfff вечный цикл;
UT-модули на неизвестной подкоманде теряют элемент пула; link_lost_diag сравнивает с 80 °C
температуру BB, а не RF. Полный список — в комментариях `ХРУПКО:`/«баг vendor» в fw/.

## Как проверить

```
make BUILD=$B $B/fw.elf $B/uc.elf
python3 tools/build_fw.py --elf $B/fw.elf --uc-elf $B/uc.elf --vendor ../images/openwrt/fw/wil6210_6.2.0.1000.fw --out X.fw
tools/hwboot.sh X.fw 150      # RESULT: data
tools/linktest.sh 30 10       # ping/iperf3
```

## Стендовые проверки 2026-10-20 (tools/stand_tests)

| Путь | Результат |
|---|---|
| temp, stations, link_stats, bf, LED, PMC, WMI_ECHO | = vendor |
| BA add/del_tx/del_rx | работает; после DELBA связь восстанавливается (у vendor — нет) |
| FTM: сессия и результаты | = vendor: 0x1995 (3 измерения) + 0x1991 через ~17 мс; сырой RTT ≈ −0,3 нс (смещения не откалиброваны), заглушки ответчика TSF Sync/TOD/TOA Error; драйвер событий не обрабатывает |
| monitor (sniffer, WMI_CFG_RX_CHAIN) | = vendor (~3800 кадров/6 с) |
| AP: маяк/probe IE, EDCA, данные | = vendor; QoS Info исправлен на 0x08 (баг vendor) |
| multi-omni connect | путь выполняется; данных нет и у vendor (AP не поддерживает) |
| PCIe remove/rescan, reset | не проверить: вешают хост .12 и с vendor fw |
