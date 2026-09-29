# Документация

Описание прошивки Sparrow (wil6210) по результатам реверса: что известно об устройстве
кода, данных и поведения. Общие для версий темы — в этом каталоге (различия помечены
**[4.1]**, **[6.2]**, **[обе]**); то, что есть только в одной версии, — в `4.1/docs/` и
`6.2/docs/`.

Уровни доказанности: **[железо]** — проверено на стенде, **[код]** — по листингу,
**[пак]** — по вендорским именам пака 11ad, **[гипотеза]** — не проверено.

## Сборка и исходники

| документ | о чём |
|---|---|
| [TOOLCHAIN](TOOLCHAIN.md) | тулчейн ARC GNU 2021.03, ключи, гейт кодировок |
| [REWRITING](REWRITING.md) | замена ассемблерного блока на C/C++, свободные хвосты, патчи quilt |
| [CROSS-VERSION](CROSS-VERSION.md) | соответствие 4.1 ↔ 6.2: доля общего кода, перенос имён, различия |
| [VERSION-DIFF](VERSION-DIFF.md) | что убрано из 4.1 и добавлено в 6.2: функциональность, интерфейсы, память |

## Чип и аппаратура

| документ | о чём |
|---|---|
| [HARDWARE-BLOCKS](HARDWARE-BLOCKS.md) | карта памяти, регистры RGF, TSF и таймеры MAC, прерывания, счётчики PHY |
| [MAC-REGISTERS](MAC-REGISTERS.md) | регистры локального чтения MAC (r36…r56, MSXD_LR_RGF) |
| [MAC-COMMANDS](MAC-COMMANDS.md) | кольцо команд MAC (core write): формат, коды, последовательности |
| [HW-DRIVERS](HW-DRIVERS.md) | загрузка, векторы, PCIe, питание, калибровки, температура, ABIF, board/РЧ, ToF/FTM |

## Прошивка (fw)

| документ | о чём |
|---|---|
| [FW-OBJECTS](FW-OBJECTS.md) | C++-каркас: объекты, классы, синглтоны, vif/bss/пулы, dashboard |
| [FW-UTILITIES](FW-UTILITIES.md) | битовые поля, милли-код, аксессоры, мелкие функции |
| [SCHEDULER](SCHEDULER.md) | планировщик `u_schd` и главный цикл |
| [STATE-MACHINES](STATE-MACHINES.md) | движок `basic_sm`, инвентарь автоматов, обработчики переходов |
| [L2-MANAGER](L2-MANAGER.md) | слой L2: инициализация, подъём MAC, кольца и ящики, события хосту |
| [MLME](MLME.md) | ассоциация, соединение и CID, ключи, приём маяков, скан, P2P Find |
| [RADIO-MANAGER](RADIO-MANAGER.md) | владение радио и переключение канала |
| [HOST-INTERFACE](HOST-INTERFACE.md) | исполнение команд хоста: подключение, PCP/AP, скан, отключение |
| [WMI](WMI.md) | команды и события WMI обеих версий |
| [ESE](ESE.md) | расписание ESE (TDMA 802.11ad) |
| [ROLELESS-LINK](ROLELESS-LINK.md) | режим OOB, ответчик A-BFT, связь без ролей PCP/STA |

## Микрокод (ucode) и эфир

| документ | о чём |
|---|---|
| [LMAC-PROTOCOL](LMAC-PROTOCOL.md) | протокол fw ↔ ucode: транспорт, команды, тела, события |
| [UCODE-TASKS](UCODE-TASKS.md) | слои L1/L2/фон, главный цикл, векторы ucode, общая память |
| [BEACONING](BEACONING.md) | конфигурация и передача маяка, рандомизатор, NAV, окна BI, состояние на железе |
| [BF-ENGINE](BF-ENGINE.md) | beamforming: SLS/TXSS, BRP, rate search, очередь запросов |
| [DATAPATH](DATAPATH.md) | тракт данных: передача и приём, запрет CID на время BF |
| [STANDARD-MAPPING](STANDARD-MAPPING.md) | соответствие механизмов IEEE 802.11ad / 802.11-2020 |
| [VENDOR-ENUMS](VENDOR-ENUMS.md) | вендорские перечисления пака 11ad |

## Только 4.1.0.1000 (`4.1/docs/`)

| документ | о чём |
|---|---|
| [BEACON-CONFIG](../4.1/docs/BEACON-CONFIG.md) | блок конфигурации биконинга 0x801438 и `CMD_BCON_MGT` |
| [UCODE-BEACON](../4.1/docs/UCODE-BEACON.md) | лог ucode, ATIM, телеметрия MAC_MON |
| [DISTBCN-PATCH](../4.1/docs/DISTBCN-PATCH.md) | однобайтовый патч гейта распределённого биконинга |
| [DASHBOARD](../4.1/docs/DASHBOARD.md) | разметка `g_dbg_dashboard` |
| [STRUCTS](../4.1/docs/STRUCTS.md) | разметка RX-пула, vif/mid, bss, radio_manager |
| [MISC](../4.1/docs/MISC.md) | прочие функции 4.1 по областям |
| [NAMES-FROM-62](../4.1/docs/NAMES-FROM-62.md) | имена функций 4.1 по одноимённым функциям 6.2 |

## Только 6.2.0.1000 (`6.2/docs/`)

| документ | о чём |
|---|---|
| [BENCH](../6.2/docs/BENCH.md) | поведение 6.2 на железе, известные особенности и исправления |
| [FIXED-SCHED](../6.2/docs/FIXED-SCHED.md) | фиксированное расписание (TDMA) |
| [UT-DRIVERS](../6.2/docs/UT-DRIVERS.md) | UT-подкоманды драйверов: код → функция |
| [RX-BRP-UC](../6.2/docs/RX-BRP-UC.md) | таблица станций ucode, приём ответа, замеры приёма |
| [MISC-FW](../6.2/docs/MISC-FW.md) | UT hw_sysapi, FTM/ToF, каталог блоков fw по исходным файлам |
| [MISC-UC](../6.2/docs/MISC-UC.md) | каталог блоков ucode, MAC-ядро и регистры |

Карта периферийных регистров 6.2 генерируется: `make regs` → [`6.2/ref/REGS-62.md`](../6.2/ref/REGS-62.md).
