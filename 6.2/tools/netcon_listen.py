#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Слушает netconsole узлов и пишет всё в файл с отметками времени.

Узел вооружает netconsole в rc.local (порты 6666 и 6667). Ловить его
нужно заранее: при зависании ядра это единственный источник сведений —
dmesg на узле уже не прочесть.
    tools/netcon_listen.py <файл> [порт]
"""
import socket
import sys
import time

path = sys.argv[1]
port = int(sys.argv[2]) if len(sys.argv) > 2 else 6666
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind(('0.0.0.0', port))
with open(path, 'a', buffering=1) as f:
    while True:
        d, a = s.recvfrom(9000)
        f.write('%s %s %s' % (time.strftime('%H:%M:%S'), a[0],
                              d.decode('utf-8', 'replace')))
        if not d.endswith(b'\n'):
            f.write('\n')
