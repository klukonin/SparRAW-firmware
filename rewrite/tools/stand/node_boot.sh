#!/bin/sh
# SPDX-License-Identifier: AGPL-3.0-or-later
# node_boot.sh <host> --role ap|sta [--ssid S] [--fw F] [--ko K] [--uci "<cmds>"] [--network N] [--modparam P=V]
#              [--brd-md5 M] [--tapo ADDR] [--no-link] [--no-reboot]
# Узел стенда в заданной роли — только через перезагрузку (docs/STAND.md): файлы fw/модуля, роль в uci (commit),
# sync, reboot, ожидание ssh, проверки (версия fw в dmesg, md5 fw/модуля/платы, интерфейс роли, связь станции).
# Код выхода: 0 — всё сошлось, 2 — узел загружен, но проверка не прошла, 3 — ошибка (узел не поднялся и т. п.).
# Реализация — nodeboot.py (та же, что у pytest-стенда tests/stand.py).
exec python3 "$(dirname "$0")/nodeboot.py" "$@"
