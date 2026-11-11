#!/bin/sh
# SPDX-License-Identifier: AGPL-3.0-or-later
# tdma_ctl.sh on|strict|off [порог] [phy] — TDMA точки SparRAW (open, docs/TDMA.md): время DTI между станциями.
# Запускать на устройстве (нужен debugfs wil6210). По умолчанию TDMA включён (простое деление), порог — 2 станции.
#   tdma_ctl.sh off           — выключить (весь DTI — CBAP)
#   tdma_ctl.sh on            — простое деление: CBAP станция → точка поровну + общее CBAP
#   tdma_ctl.sh strict        — строгий: SP точка → станция и станция → точка поровну + общее CBAP (10.39.6.2)
#   tdma_ctl.sh strict 1      — то же уже при одной станции
# Команда WMI_SPARRAW_TDMA_CFG (0x0f10): заголовок {mid 0, 0, id LE16, 0 LE32} + {enable, min_sta, mode, 0}.
# Настройка не сохраняется при перезагрузке прошивки.
case "$1" in on) en=1; mode=0 ;; strict) en=1; mode=1 ;; off) en=0; mode=0 ;;
*) echo "usage: $0 on|strict|off [min_sta] [phy]" >&2; exit 2 ;; esac
min=${2:-0}; phy=${3:-phy0}
f=/sys/kernel/debug/ieee80211/$phy/wil6210/wmi_send
[ -w "$f" ] || { echo "нет $f (debugfs смонтирован? драйвер wil6210?)" >&2; exit 1; }
[ "$min" -ge 0 ] 2>/dev/null && [ "$min" -le 8 ] || { echo "порог 0..8" >&2; exit 2; }
echo -ne "\x00\x00\x10\x0f\x00\x00\x00\x00\x0$en\x0$min\x0$mode\x00" > "$f"
