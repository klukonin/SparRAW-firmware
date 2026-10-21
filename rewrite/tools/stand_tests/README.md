# Стендовые тесты путей fw (2026-10-20)

Запуск с хоста (стенд .12/.11, как tools/hwboot.sh): `OUT=<dir> tools/stand_tests/run_<x>.sh <fw> <tag>`.
Сравнивать vendor (`../images/openwrt/fw/wil6210_6.2.0.1000.fw`) и наш образ одной и той же процедурой.

- `run_sta.sh` — STA: ping, temp, stations/link_stats, bf, BA (`back` add/del_tx/del_rx), LED, PMC,
  WMI_ECHO (wmi_send), старт сессии FTM (здесь fw отвечает «не поддерживается»; FTM — SparRAW-pro),
  затем (часть B) monitor/sniffer (смена типа основного интерфейса — wil6210 не поддерживает виртуальные) и PCIe remove/rescan. Журнал fw — после части A.
- `run_ap.sh` — .12 AP, .11 vendor STA (KEEP=1): IE маяка/probe со стороны .11 (`scan dump -u`), BA.
- `run_mo.sh` — multi-omni connect: WMI_SET_MULTI_DIRECTED_OMNIS_CONFIG (0xa04) = 2 + переподключение,
  снимки журнала fw во время теста.
- `fwcheck.sh <dir>` — счётчики событий в журнале fw.

Ограничения стенда: PCIe remove/rescan и `reset` вешают хост .12 и с vendor fw (нужен power-cycle);
multi-omni с этой AP — данных нет и у vendor.
