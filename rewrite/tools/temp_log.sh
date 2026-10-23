#!/bin/sh
# SPDX-License-Identifier: AGPL-3.0-or-later
# temp_log.sh [период_с] [phy] — журнал температур чипа в CSV на stdout (запуск на устройстве).
# Читает снимок службы температуры в блоке статистики fw (temp_snap 0x853808: BB, активный RF,
# RF0..7, мград) через debugfs mem_addr/mem_val — радио не занимается, в отличие от debugfs temp
# (тот на каждое чтение запрашивает новое измерение). Снимок обновляется службой раз в 10 с, пока
# есть соединение или интерфейс не простаивает; без соединения значения замирают. Формат совпадает
# у vendor 6.2 и SparRAW.
#   temp_log.sh 30 > /tmp/temp.csv    — каждые 30 с: время, T_mac, T_radio (°C)
# Точность: T_mac — компаратор с лестницей 32 кодов, шаг ~3 °C, без OTP-калибровки;
# T_radio — шаг 0.16 °C.
per=${1:-10}; phy=${2:-phy0}
d=/sys/kernel/debug/ieee80211/$phy/wil6210
[ -w "$d/mem_addr" ] || { echo "нет $d/mem_addr (debugfs смонтирован? драйвер wil6210?)" >&2; exit 1; }
rd() { echo "$1" > "$d/mem_addr"; sed -n 's/.*= 0x//p' "$d/mem_val"; }
c() { v=$((0x$1)); [ "$v" -ge 2147483648 ] && { echo NA; return; }; echo "$((v / 1000)).$(printf %03d $((v % 1000)))"; }
echo "time,t_mac,t_radio"
while :; do
	echo "$(date +%s),$(c "$(rd 0x853808)"),$(c "$(rd 0x85380c)")"
	sleep "$per"
done
