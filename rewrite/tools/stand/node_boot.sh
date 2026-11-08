#!/bin/sh
# SPDX-License-Identifier: AGPL-3.0-or-later
# node_boot.sh --install <host>       — однократно: снять автозагрузку wil6210 (идемпотентно; --uninstall — вернуть)
# node_boot.sh <host> --role ap|sta (--fw F | --fw-node P) [--ko K] [--modparam P=V]… [--ssid S] [--network N]
#              [--uci "<cmds>"] [--brd-md5 M] [--tapo ADDR] [--no-link] [--reboot-only | --load-only | --no-reboot]
# Итерация на узле стенда (docs/STAND.md): reboot → ssh → «wil6210 не загружен» → прошивка итерации в tmpfs
# (/tmp/sparraw-fw, firmware_class.path) → роль в uci без commit → insmod <модуль> <параметры> → wifi up radio0 →
# проверки (версия fw в dmesg, md5 fw/модуля/платы, интерфейс роли, связь станции). rmmod и wifi down/up — никогда.
# Код выхода: 0 — всё сошлось, 2 — узел загружен, но проверка не прошла, 3 — ошибка (узел не поднялся и т. п.).
# Реализация — nodeboot.py (та же, что у pytest-стенда tests/stand.py).
exec python3 "$(dirname "$0")/nodeboot.py" "$@"
