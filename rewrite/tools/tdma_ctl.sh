#!/bin/sh
# SPDX-License-Identifier: AGPL-3.0-or-later
# tdma_ctl.sh on|off [порог] [phy] — простой TDMA точки SparRAW (open): время DTI поровну между станциями.
# Запускать на устройстве (нужен debugfs wil6210). По умолчанию TDMA включён, порог — 2 станции.
#   tdma_ctl.sh off           — выключить (весь DTI — CBAP)
#   tdma_ctl.sh on            — включить с порогом по умолчанию
#   tdma_ctl.sh on 1          — включить уже при одной станции
# Команда WMI_SPARRAW_TDMA_CFG (0x0f10): заголовок {mid 0, 0, id LE16, 0 LE32} + {enable, min_sta, 0, 0}.
# Настройка не сохраняется при перезагрузке прошивки.
case "$1" in on) en=1 ;; off) en=0 ;; *) echo "usage: $0 on|off [min_sta] [phy]" >&2; exit 2 ;; esac
min=${2:-0}; phy=${3:-phy0}
f=/sys/kernel/debug/ieee80211/$phy/wil6210/wmi_send
[ -w "$f" ] || { echo "нет $f (debugfs смонтирован? драйвер wil6210?)" >&2; exit 1; }
[ "$min" -ge 0 ] 2>/dev/null && [ "$min" -le 8 ] || { echo "порог 0..8" >&2; exit 2; }
echo -ne "\x00\x00\x10\x0f\x00\x00\x00\x00\x0$en\x0$min\x00\x00" > "$f"
