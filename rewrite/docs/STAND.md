# Стенд: драйвер только по команде, смена — только перезагрузкой

Правила проекта:

1. **Перезапуск драйвера, прошивки и смена роли узла — только через перезагрузку устройства.** Выигрыш в минуту на
   загрузку не стоит рисков: больше времени уходит на погоню за призрачными ошибками и артефактами быстрого
   перезапуска.
2. **По умолчанию модуль с прошивкой не загружается сам после загрузки системы** — только командой стенда, с
   конкретной прошивкой, нужной в этой итерации.

Что было (стенд, 2026-11):

- `rmmod wil6210` после работы Wi-Fi висел в состоянии D; набор после этого раз за разом снимал питание — узел .12
  перестал грузиться даже в failsafe (восстановлен загрузкой по сети и sysupgrade, 2026-11-07);
- netifd после `wifi down`/`wifi up` на перенастроенном узле — «PHY is undefined for device»;
- после `insmod` своего модуля (поверх загруженного при старте) интерфейс переименовывался в `phy1-*`;
- фантомные «ping 0/15» после перезапуска радио;
- 2026-11-08: .11 7 раз за день не вернулся из обычного `reboot` с загруженным wil6210 (или завис на ходу),
  помогало только снятие питания; .12 — ни разу. Отсюда перезагрузка стенда `sync; reboot -f` (раздел «Перезагрузка»);
- 2026-11-08: при подъёме роли командой `wifi up radio0` после `ubus call network reload` на точке-вендоре прошивка
  стартовала 4 раза подряд (4× `wmi_evt_ready` «FW ver»), станция получала «link up: no beacon from peer» и
  CTRL-EVENT-ASSOC-REJECT status 1, связь то была, то нет. Причина — в процедуре (раздел «Подъём роли»), исправлено.

## Однократная подготовка узла

```sh
tools/stand/node_boot.sh --install 192.168.1.11
tools/stand/node_boot.sh --install 192.168.1.12
```

Идемпотентно. Что делает:

- `/etc/modules.d/wil6210` (одна строка `wil6210`) — в бэкап `/etc/sparraw-stand.modules.d.wil6210` и удаляется:
  kmodloader при старте грузит только перечисленное в `/etc/modules.d` (с зависимостями — поэтому вместе с wil6210
  пропадают и `cfg80211`, `compat`: итерация грузит их `modprobe cfg80211`). Другой файл `/etc/modules.d`,
  `/etc/modules-boot.d` с wil6210 — ошибка (убрать вручную);
- проверено по исходникам OpenWrt: procd (`/etc/hotplug.json`) модули по MODALIAS не грузит — только создаёт узлы
  устройств и отдаёт прошивку по запросу ядра (`load-firmware /lib/firmware`, запасной путь ядра firmware user helper; при
  найденном ядром файле не задействуется); `/etc/hotplug.d` образа wil6210 не упоминает. Чёрный список не нужен.
  `--install` всё равно сообщает, если что-то в `/etc/hotplug.d` или `/etc/rc.local` упоминает wil6210;
- следы прежней схемы (роль с commit): опции сценариев из `/etc/sparraw-stand.uci` возвращаются к исходным, файлы
  `/etc/sparraw-stand.uci`, `/etc/sparraw-stand.sig` и строка `options wil6210 … # sparraw-stand` в
  `/etc/modules.conf` удаляются (параметры теперь — аргументы insmod).

Закоммиченная роль радио в uci остаётся: без phy netifd просто ждёт. `--uninstall` возвращает `/etc/modules.d/wil6210`
из бэкапа.

## Итерация

Одна реализация для pytest-стенда и ручных записей — `tools/stand/nodeboot.py` (CLI `tools/stand/node_boot.sh`):

1. `sync; sleep 1; sync; reboot -f` (раздел «Перезагрузка»; `[test] reboot = "init"` / `--reboot-mode init` —
   обычный `reboot`) → ожидание ssh с **новым** `boot_id`.
2. **Драйвера нет:** `wil6210` не в `/proc/modules`, иначе ошибка «узел загрузил драйвер сам» (не выполнен
   `--install`).
3. Если `/etc/rc.local` узла ждёт `/sys/module/wil6210` (оверлей SparRAW-driver: до 60 с, затем пишет параметры
   модуля) — insmod после uptime 120 с, когда rc.local уже закончил: иначе параметры зависели бы от того, успел ли
   модуль появиться за 60 с. Нужные параметры — явно аргументами insmod.
4. **Прошивка итерации — в tmpfs, флеш не трогается:** `/tmp/sparraw-fw/wil6210.fw` (файл с хоста или копия файла
   на узле — `fw_backup` peer-точки), сверка md5; рядом копия `/lib/firmware/wil6210.brd` — md5 сверяется с
   `brd_md5` (плата малой мощности, `e17714311e27…`), не та плата — ошибка до insmod.
5. `echo -n /tmp/sparraw-fw > /sys/module/firmware_class/parameters/path`. Ядро 6.18
   (`drivers/base/firmware_loader/main.c`, `fw_path[]`) ищет файл сначала в этом пути, затем в
   `/lib/firmware/updates/…` и `/lib/firmware`. Файла в пути нет — ядро молча возьмёт `/lib/firmware`, поэтому
   проверка сверяет версию из dmesg с образом итерации и md5 файла в `/tmp/sparraw-fw`.
6. **Роль в uci без commit** (см. ниже) + команды сценария (`--uci`, `SPARRAW_AP_UCI`: только
   `uci set/delete/add_list/del_list`), md5 `/etc/config/wireless` → `/tmp/sparraw-stand.wireless.md5`, **один**
   `ubus call network reload` — до insmod: netifd получает роль, пока phy нет (почему так — «Подъём роли»).
   Ожидание, пока netifd закончит попытку setup без phy: `ubus call network.wireless status` → `radio0.pending`
   = false (до 45 с; radio0 в netifd нет — ошибка).
7. `modprobe cfg80211` (с `compat`), `insmod <модуль> <параметры итерации>`: свой модуль — из
   `/tmp/sparraw-drv/wil6210.ko` (с хоста, `--ko`), иначе модуль системы `/lib/modules/$(uname -r)/wil6210.ko`.
   Параметры (`no_fw_recovery=Y` у станции на проверяемом образе и т. п.) — `--modparam`, `[test] modparams`.
8. Появился `/sys/class/ieee80211/phy*` → radio0 в netifd указывает на него (как `find_phy()` wifi-scripts:
   `config.path` — хвост `realpath /sys/class/ieee80211/phyN/device`, иначе `config.phy`, `config.macaddr`; не
   указывает — ошибка до подъёма: иначе «PHY is undefined for device») →
   `ubus call network.wireless up '{"device":"radio0"}'`. **Не `wifi up`.**
9. **Проверки:** radio0 в netifd `up`, не `pending` (до 90 с); версия fw в dmesg (`wmi_evt_ready: FW ver. …`) =
   версии образа итерации; затем окно 10 с, после него:
   - **прошивка стартовала один раз**: число «FW ver.» в dmesg ≤ `[test] max_fw_starts` (`--max-fw-starts`, по
     умолчанию 1), иначе «прошивка перезапускалась N раз при подъёме (FW ver. в dmesg ×N: метки времени)»;
   - **роль поднята один раз**: в logread `netifd: radio0 (pid): wifi-scripts: Starting` ×1, `Tearing down` ×0,
     у точки нет `AP-DISABLED` (hostapd);
   - `/etc/config/wireless` не изменился (commit не случился);
   - у станции — связь (`Connected`) и ни одного `CTRL-EVENT-DISCONNECTED` за 10 с после неё, связь на конце
     окна есть (станция peer в тесте AP — без ожидания связи); ASSOC-REJECT/DISCONNECTED за загрузку — в журнал;
   - `firmware_class.path` = `/tmp/sparraw-fw`, md5 fw и модуля, md5 платы, wil6210 загружен, интерфейс роли
     (`type AP`/`type managed`), счётчик «Firmware error».

   Перезапуски при подъёме без «Firmware error» — ошибка стенда (`Report.hard`, pytest останавливает фикстуру):
   процедура не та, дальше мерить нечего. С «Firmware error» — восстановление fw после сбоя проверяемого образа,
   это предмет тестов (мягкая проблема).

Смена прошивки, модуля или роли — новая итерация, то есть новая перезагрузка. Запрещено (`nodeboot.check_cmd`, на
каждую команду стенда к узлу): `rmmod`, `modprobe -r`, `wifi down`, `wifi reload`, `wifi up`, `wifi reconf`, голый
`wifi` (= `wifi up`). Единственное исключение —
`test_ap.py::test_ap_stop`: `wifi down` и есть предмет проверки (останов точки, PCP_STOP); радио обратно не
поднимается, следующая загрузка роли перезагружает узел.

Подпись итерации — `/tmp/sparraw-stand.sig` (роль, SSID, сеть, команды сценария, параметры, md5 fw и модуля): если
peer-точка в этой загрузке уже то, что нужно, перед следующей загрузкой dut-станции она не перезагружается.

### Роль — uci без commit

Роль и опции сценария выставляются `uci set` без `uci commit`: дельта лежит в `/tmp/.uci` (tmpfs), флеш не
пишется, после перезагрузки узел чистый сам. netifd её видит: он открывает конфиг через libuci с контекстом по
умолчанию (`config.c`: `uci_alloc_context()`, `savedir` не меняется вне DUMMY_MODE), а libuci по умолчанию
(`UCI_FLAG_SAVED_DELTA`, `UCI_SAVEDIR` = `/tmp/.uci`) накладывает сохранённые дельты при загрузке пакета. Пакет
wireless netifd читает из ucode (`/lib/netifd/main.uc`: `uci.cursor(config_path, savedir = null)` вне dummy-режима —
те же умолчания libuci, дельта видна) и только на старте и по `network reload`. Прежние наборы тоже поднимали роль
через `uci set` без commit и `wifi up`. Commit нигде не нужен.

### Подъём роли: почему reload до insmod и network.wireless up, а не wifi up

По исходникам OpenWrt master (netifd 2026.09.11, `package/network/config/wifi-scripts`, ucode-вариант
`CONFIG_WIFI_SCRIPTS_UCODE=y`):

- `ubus call network reload` → `config_init_all()` (netifd `config.c`) → ucode `wireless.uc`: `config_init` (конфиг
  radio0 из uci, с дельтой) и `config_start` — `start()` каждого радио: autostart, сброс счётчика повторов и
  `retry_setup_failed`, setup — **только из состояния down** (`wireless-device.uc`).
- setup = `lib/netifd/wireless/mac80211.sh setup`: без phy — `log('Bug: PHY is undefined for device')` и
  `set_retry(false)`; netifd (`wdev_setup_cb`) ставит `retry_setup_failed`, teardown (тоже «PHY is undefined») —
  радио в down **без повторов**. Прошивка тут не участвует — драйвера нет. С phy — wpa_supplicant/hostapd поднимают
  интерфейс, `ndo_open` → `wil_up` → `wil_reset(load_fw)` — старт прошивки (у wil6210 он только при подъёме
  интерфейса: probe грузит fw лишь у WMI-only образов, `pcie_bus.c`).
- `ubus call network.wireless up` → тот же `start()`: в setup/up — ничего; `retry` (его вызывает hotplug
  `/etc/hotplug.d/ieee80211/10-wifi-detect` при появлении phy, после `wifi config`) — только из down. Оба
  идемпотентны: кто первый, тот поднял, второй — no-op.
- `/sbin/wifi up` = `network.wireless down` + `network reload` + `network.wireless up` (`wifi_updown enable`):
  это **перезапуск** радио. Вместе с hotplug-`retry` (поднял сразу после insmod) он давал: setup → `down`
  (cancel_setup или teardown) → setup снова; `mark_up` с cancel_setup — ещё teardown/setup. Каждый
  teardown → hostapd снимает интерфейс → `wil_down`, каждый setup → `wil_up` → новый старт прошивки: 4× «FW ver»
  на точке-вендоре 2026-11-08.
- reload **после** insmod хуже: hotplug-`retry` успевает поднять радио с ролью из закоммиченного конфига, затем
  reload меняет конфиг → `check()` → новый setup поверх поднятого.
- `wifi config` из того же hotplug пишет `uci commit wireless`, только если radio0 не нашлось по path/macaddr/phy
  (`lib/wifi/mac80211.uc`); commit закоммитил бы и дельту роли — проверка md5 `/etc/config/wireless` это ловит.

Отсюда порядок: дельта роли → один reload (без phy) → дождаться netifd → insmod → phy ↔ radio0 →
`network.wireless up` → один старт прошивки. `wifi config` вручную не нужен (radio0 на узлах есть),
`network.wireless notify` — канал самих wifi-scripts к netifd (set_up/set_data/process_add), не команда.

### Перезагрузка: reboot -f

`nodeboot.REBOOT_MODE = 'force'`: `sync; sleep 1; sync; reboot -f`. busybox 1.38 (`init/halt.c`): без `-n` —
`sync()`, с `-f` — сразу системный вызов `reboot(RB_AUTOBOOT)`, без сигнала init. Обычный `reboot` шлёт SIGTERM
procd: `procd_shutdown()` → шаг `shutdown` inittab (`/etc/init.d/rcS K shutdown`: network stop → netifd гасит
радио → hostapd/wpa_supplicant снимают интерфейс → `wil_down` → `__wil_down`/`wil_reset` с прошивкой — тот же путь,
что у зависавшего в D `rmmod`), затем SIGTERM/SIGKILL всем, sync, reboot (`state.c`). С `-f` останавливать
драйвер нечему; ядро всё равно делает `device_shutdown()`, а `.shutdown` у wil6210 нет (`pcie_bus.c`). Флеш:
итерация на него ничего не пишет (роль — дельта в `/tmp/.uci`, прошивка и модуль — tmpfs), перед вызовом
`sync; sleep 1; sync` и `sync()` самого busybox; overlay без umount после sync цел. `[test] reboot = "init"` /
`--reboot-mode init` — обычный `reboot` (с прежним запасным `reboot -f`, если узел 120 с отвечает со старым
`boot_id`).

## Адреса и iperf3 — командами после загрузки, не в uci

Адреса 10.60.0.x, sysctl ARP, правила nft, привязка прерываний и `iperf3 -s -D` выставляются после каждой загрузки
обычными командами (`ip addr add`, `iperf3 -D`). В uci network их **не** коммитим:

- адрес точки — второй адрес на `br-lan`, через который идёт управление узлом по ssh; ошибка в закоммиченной
  `network.lan` отрезает узел от стенда, а восстановление — только руками (failsafe);
- набор не знает и не должен менять сетевую конфигурацию узлов (`wl60` на .12 настроена вне стенда);
- `iperf3 -s`, nft и прерывания всё равно не описываются uci — шаг после загрузки нужен в любом случае.

## Питание

Снятие питания (Tapo) — **только если узел не отвечает по ssh**:

- после перезагрузки: нет ssh с новым `boot_id` за 300 с → одно снятие питания → ещё 300 с → `StandError` с
  текстом «проверить вручную». Узел отвечает со старым `boot_id` дольше 120 с (в режиме `init` reboot завис на
  процессе в D) — один `sync; reboot -f` (это всё ещё перезагрузка, не питание); не помогло — `StandError`,
  питание не снимается, раз узел отвечает;
- зависла команда, а узел отвечает по ssh — `StandError` без перезагрузки и без снятия питания;
- ssh не отвечает посреди теста — ожидание 240 с (узел мог перезагрузиться сам), затем одно снятие питания;
- за прогон pytest — не больше `[test] max_power_cycles` (по умолчанию 1) снятий питания на узел; дальше —
  `StandError`, без повторов (износ флеша). Ручные инструменты снимают питание только с `TAPO_AP`/`TAPO_STA`
  (`--tapo`), тоже один раз.

Пропажа узла в тестах `test_sta_vanish.py`, `test_ap_vanish.py` (стимул: партнёр исчезает из эфира без
разъединения) — тоже без питания: `sync; reboot -f` по ssh (`Node.vanish`). busybox `reboot -f` (`init/halt.c`)
делает sync и сразу системный вызов reboot, минуя procd: скрипты остановки не выполняются, hostapd/wpa_supplicant и
netifd не останавливаются — Deauth/Disassociation не уходят. В ядре `device_shutdown()` вызывает только `.shutdown`
драйверов, у wil6210 его нет (`pcie_bus.c`), fw ничего не шлёт. (Если это когда-нибудь окажется не так —
мгновенная перезагрузка ядром `echo b > /proc/sysrq-trigger` после sync.) Узел поднимается **без драйвера**; тест
ждёт новый `boot_id` и сам загружает драйвер командой (`nodeboot.bring_up`: станция на проверяемом образе в тесте
точки, `Stand._peer_restore_ap` — точка на своей прошивке), дальше проверяет как раньше.

## Открыто: выгрузка STA→AP встаёт в новой схеме (2026-11-08)

Факты (OpenWrt, ядро 6.18.52, ipq4019, wAP 60G):

- в новой схеме выгрузка STA→AP встаёт во всех прогонах: 1-я секунда 70–300 Мбит/с, далее 0, у iperf3 окно
  1.41 KB и Retr 0; загрузка AP→STA — 949 Мбит/с. Так и с нашей прошивкой станции (6.4.1.0-SparRAW), и с прошивкой
  вендора 6.2 на станции; точка — вендор 6.2. В старой схеме (модуль грузился при старте kmodloader'ом, набор делал
  `rmmod` + `insmod /tmp/drv.ko`, роль в uci с commit, `wifi up`) выгрузка проходила, срыв 1 из ~15;
- исключено: `uc_trace_ms`/`fw_log_level`, `napi_threaded=0`, привязка IRQ (`smp_affinity` 2);
- снимок при зависании (станция, `napi_threaded=Y`): `rings`: `tx_0 size 4096 swtail=1696 swhead=1200 hwtail=1200`;
  дамп кольца — почти все `_` (DU выставлен), редкие `h`/`H`; счётчик `wil6210_tx` в `/proc/interrupts` не растёт;
  поток `napi/phy0-0` в S (`napi_threaded_poll`), affinity CPU3; `stations`: `BACK([32] 0 TU A-) [3600|495]`.

Чтение снимка по коду драйвера (unified): занято (4096 + 1200 − 1696) % 4096 = 3600, свободно 495 (`debugfs.c`
`rings`); `hwtail` — эхо записи драйвера (= `swhead`). Железо дескрипторы отработало (`_` = DU), драйвер их не
разбирает: `wil_tx_complete()` не вызывается или стоит на первом. Свободно 495 < size/8 = 512 — очередь netdev
остановлена (`txrx.c`), будит её только разбор завершений (свободно > size/4); новых передач нет → новых TX_DONE
нет → прерывания нет; таймера-перепроверки в драйвере нет. Одно потерянное событие — вечная остановка. TSQ держит
TCP (окно 1.41 KB, без потерь). Путь: MSI+0 `wil6210_irq_tx` (`interrupt.c`) маскирует TX (IMS), читает и чистит
ICR, при TX_DONE и fwready — `napi_schedule`, маску не снимает; `wil6210_netdev_poll_tx` (`netdev.c`) разбирает
кольца и при `done < budget` — `napi_complete` + снятие маски (IMC). ICC (режим очистки ICR) для DMA_EP_TX/RX в
legacy DMA драйвер не пишет — значение от чипа/прошивки. ITR TX (500/13 мкс) пишет только `wil_reset` после FW
ready (`wil_configure_interrupt_moderation`, в dmesg «set ITR_TX_CNT_TRSH»), пропускает, если главный интерфейс —
monitor. У драйвера нет `.shutdown`: после тёплой перезагрузки первая загрузка модуля застаёт чип с работавшей
прошивкой; в старой схеме измерялась вторая загрузка (после `rmmod` с его сбросами).

Гипотезы по рангу и опыт на каждую (без rmmod; `D=/sys/kernel/debug/ieee80211/phy0/wil6210`). Снимок при
зависании — сначала ICC и IMV: при ICC = 1 (очистка чтением) чтение ICR/ICM стирает причину:

```sh
D=/sys/kernel/debug/ieee80211/phy0/wil6210
cat $D/DMA_EP_TX_ICR/ICC $D/DMA_EP_TX_ICR/IMV          # затем, если ICC = 0: ICM, ICR
for r in TRSH DATA CTL IDL_TRSH IDL_DATA IDL_CTL; do echo $r $(cat $D/ITR_CNT/TX/$r); done
grep wil6210 /proc/interrupts; dmesg | grep -c 'set ITR_TX_CNT_TRSH'; cat $D/PSEUDO_ISR/*
echo 0 > $D/ring_index; echo 1696 > $D/desc_index; cat $D/desc   # дескриптор на swtail (и swtail+nr_frags)
```

1. **Потеряно событие TX_DONE / прерывание.** Регистры различают варианты:
   - (a) IMV & 1 = 0, ICR/ICM & 1 ≠ 0 — причина взведена, маска снята, MSI не пришёл (окно между чтением ICR в
     обработчике и IMC в опросе; модерация 500/13 мкс делает его обычным). Опыт: `echo 1 > $D/DMA_EP_TX_ICR/ICS`
     — если `swtail` сдвинулся и iperf ожил, это (a);
   - (b) ICR = 0 при DU по всему кольцу, ITR TX CTL не EN|EXT_TIC_SEL или DATA застыл — модерация. Опыт: `ethtool -C
     phy0-sta0 tx-usecs 500` прямо при зависании;
   - (c) IMV & 1 ≠ 0 (маска стоит), а NAPI не запланирован. Опыт: `echo 3 > $D/DMA_EP_TX_ICR/IMC`.
2. **Пробка в голове кольца**: на `swtail + nr_frags` нет DU, дальше DU есть (NAPI работает, разбирать нечего;
   подозрение — TSO: `nr_frags` по сегментам). Опыт: `desc` на `swtail`; повтор выгрузки с
   `ethtool -K phy0-sta0 tso off`.
3. **Состояние чипа при первой загрузке после тёплой перезагрузки** (нет `.shutdown`; регистры, которые драйвер не
   пишет: ICC TX/RX, legacy ITR, TX_DESQ_NO_MOD 0x881d40). Опыт: сравнить ICC и `ITR_CNT/*` в рабочем и зависшем
   состоянии; решающий — холодный старт станции (питание) перед загрузкой, но снятие питания вне «узел не
   отвечает» — только с разрешения владельца стенда. Альтернатива — патч `.shutdown` (маска IRQ, останов CPU
   прошивки, `pci_clear_master`), чтобы перезагрузка оставляла чип как после `rmmod`.
4. **Несколько стартов прошивки при подъёме роли** (4× на точке до исправления процедуры): после исправления
   проверяется сам собой — первый прогон выгрузки с «стартов fw 1» на обоих узлах.
5. Поздний `cfg80211`, MSI (`n_msi=3`), affinity — слабая: affinity и `napi_threaded` уже исключены, поток napi
   в S, не в R.

Диагностика в драйвере (если регистры не решат; не закоммичено): счётчики `tx_irq`, `tx_sched_fail`
(`napi_schedule()` вернул false), `tx_poll`, `tx_budget_hit`, `tx_unmask`, `tx_hol` (+ индекс: в
`wil_tx_complete` на `lf` нет DU, а на `lf+1` есть) и последний ISR/jiffies последнего tx-irq — файл debugfs
`tx_diag` вместе с живыми IMV/ICR/ICM TX и ITR TX CTL/DATA. Застыло всё, IMV = 0, ICR ≠ 0 → 1a; растут `tx_poll` и
`tx_hol` → 2; `tx_sched_fail > 0` → 1c. Независимо от причины по правилу «безопасный выход при пропущенном сроке
железа»: очередь остановлена и tx-irq нет дольше N мс — `napi_schedule(&wil->napi_tx)` (таймер или проверка в
`wil_start_xmit`).

## Как пользоваться

pytest-стенд (`tests/README.md`) — всё само: фикстуры ролей вызывают `Stand.boot_sta()`/`boot_ap()`. Перезапуск
точки в `test_reconnect_after_peer_restart` — `Stand.restart_peer()` (перезагрузка peer и загрузка точки).

Узел вручную:

```sh
tools/stand/node_boot.sh 192.168.1.11 --role ap  --fw build/wil6210.fw [--uci "uci set wireless.default_radio0.multicast_to_unicast=0"]
tools/stand/node_boot.sh 192.168.1.12 --role sta --fw build/wil6210.fw --network wl60 [--ko wil6210.ko] [--modparam no_fw_recovery=Y]
tools/stand/node_boot.sh 192.168.1.11 --role ap  --fw-node /lib/firmware/wil6210.fw.backup   # образ, лежащий на узле
tools/stand/node_boot.sh 192.168.1.12 --role sta --fw X.fw --reboot-only   # только reboot и проверка «драйвера нет»
tools/stand/node_boot.sh 192.168.1.12 --role sta --fw X.fw --load-only     # затем драйвер (узел только что загрузился)
tools/stand/node_boot.sh 192.168.1.12 --role sta --fw X.fw --no-reboot     # только проверки загруженной итерации
```

Ключи: `--ssid` (по умолчанию `WL60TEST`), `--brd-md5` (или `BRD_MD5`), `--no-link` (станция: не ждать связь),
`--link-timeout`, `--tapo <адрес>` (снять питание один раз, если узел не поднялся; путь к `tapo_plug.py` —
`--tapo-tool` или `TAPO_TOOL`). Код выхода: 0 — всё сошлось, 2 — драйвер загружен, но проверка не прошла (строка
`[node_boot] …` перечисляет что), 3 — ошибка (не поднялся, драйвер загрузился сам, не те файлы, не та плата).

Записи (`tools/stand/`, общие переменные — `stand_lib.sh`: `AP`, `STA`, `SSID`, `STA_NET`, `BRD_MD5`, `MODPARAMS`,
`OUT`):

| скрипт | что |
|---|---|
| `rdrun.sh <fw> <tag>` | оба узла — итерация параллельно, счётчики uc до/после, захват PMC 30 с на обоих + iperf вверх/вниз; `ANALYZE="<команда>"` — разбор двух pcap |
| `bcrun.sh <fw> <tag>` | точка с `multicast_to_unicast=0`, захват 40 с с записями данных, широковещательный и адресный ping, TA CTS-to-self точки |
| `assocrun.sh <fw> <tag>` | точка — итерация, станция — только перезагрузка (параллельно); захват точки `CAP_S` с (90), затем драйвер станции командой (`--load-only`): в записи её вход (A-BFT/SLS, Probe/Association, первые кадры) |

## Первый прогон после перехода — что смотреть

- `--install` на обоих узлах: «автозагрузка wil6210 снята», нет «wil6210 грузят при старте ещё и …»; замечания про
  `/etc/rc.local`/hotplug;
- после первой перезагрузки: проверка «драйвера нет» проходит (`lsmod | grep wil6210` пусто, `cfg80211` тоже не
  загружен — это нормально); netifd не ругается на отсутствующий phy;
- `cat /sys/module/firmware_class/parameters/path` = `/tmp/sparraw-fw`; в dmesg версия fw итерации, а не та, что
  лежит в `/lib/firmware/wil6210.fw`;
- `modprobe cfg80211` (kmodloader) поднимает и `compat`; insmod своего модуля из `/tmp/sparraw-drv` проходит;
- после `network.wireless up` netifd поднимает роль из несохранённой дельты (`uci changes wireless` показывает её,
  `uci show wireless.default_radio0` — роль итерации), интерфейс `phy0-*`; строка узла
  `… FWERR 0 стартов fw 1`; в logread ровно одно `radio0 (…): wifi-scripts: Starting`;
- `cat /sys/module/wil6210/parameters/no_fw_recovery` у станции peer в тесте AP — Y;
- станция dut после перезагрузки точки: нет «link up: no beacon from peer» (зависшая запись станции на точке
  снимается `iw … station del`);
- реальное время: «загрузился (N с)», ожидание rc.local (до uptime 120 с, если rc.local ждёт wil6210); таймауты —
  300 с до ssh, 45 с до конца setup netifd без phy, 30 с до phy, 90 с до radio0 up, 120 с до wmi_evt_ready, 60 с
  до интерфейса, 120 с до связи станции, окно 10 с;
- если и при правильной процедуре «прошивка перезапускалась 2 раз» на каждом узле — проверить по меткам времени и
  logread, не поднимает ли hostapd/wpa_supplicant интерфейс дважды сам; если так и задумано —
  `[test] max_fw_starts = 2` с записью причины здесь;
- сводка pytest «перезагрузка по питанию (узел не отвечал)» — должна быть пустой.
