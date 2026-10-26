#!/bin/sh
# SPDX-License-Identifier: AGPL-3.0-or-later
# txpower_ctl.sh <код>|board [phy] — мощность TX SparRAW (open): потолок кода усиления TX-строк RF-таблиц, применяется сразу,
# без разрыва линка. Запускать на устройстве (нужен debugfs wil6210).
#   txpower_ctl.sh 15     — максимум (как в board-файлах MikroTik)
#   txpower_ctl.sh 3      — пониженная мощность
#   txpower_ctl.sh board  — значения board-файла
# Шкала нелинейна, абсолютной калибровки в дБм нет. wAP 60G (board 60deg), относительно максимума по SNR всех
# секторов на пире: 8…15 — 0 дБ, 7 — −2,5, 6 — −5,5, 5 — −10, 4 — −16, 3 — ≈ −22; 2 и ниже — линк может пропасть.
# Команда WMI_SPARRAW_TX_POWER (0x0f12): заголовок {mid 0, 0, id LE16, 0 LE32} + {код, 0, 0, 0}.
# Настройка не сохраняется при перезагрузке прошивки.
case "$1" in
board) c=255 ;;
''|*[!0-9]*) echo "usage: $0 <0..15>|board [phy]" >&2; exit 2 ;;
*) c=$1; [ "$c" -le 15 ] || { echo "код 0..15" >&2; exit 2; } ;;
esac
phy=${2:-phy0}
f=/sys/kernel/debug/ieee80211/$phy/wil6210/wmi_send
[ -w "$f" ] || { echo "нет $f (debugfs смонтирован? драйвер wil6210?)" >&2; exit 1; }
echo -ne "\x00\x00\x12\x0f\x00\x00\x00\x00$(printf '\\x%02x' $c)\x00\x00\x00" > "$f"
