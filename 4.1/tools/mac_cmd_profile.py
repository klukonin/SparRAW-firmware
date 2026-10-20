#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Профиль команд MAC по состояниям устройства.

Считает для каждого кода долю на 1000 команд в каждом снятом состоянии
(AP маячит, станция в покое, под нагрузкой, скан, установление связи…).
Сравнение профилей даёт семантику там, где чтение кода бессильно: код,
исчезающий у непередающей станции, относится к передающему тракту; код,
падающий в ноль под нагрузкой, — к простою, и так далее.

    mac_cmd_profile.py имя=трасса.bin ... > ref/MAC-CMD-PROFILE.txt
"""
import collections, importlib.util, re, struct, sys


def main():
    spec = importlib.util.spec_from_file_location(
        'm', '../../SparRAW-tools/host/wil_mac_ring.py')
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)

    states = []
    for arg in sys.argv[1:]:
        name, _, path = arg.partition('=')
        b = open(path, 'rb').read()
        sn = [list(struct.unpack('<256I', b[i * 1024:(i + 1) * 1024]))
              for i in range(len(b) // 1024)]
        st, prev = [], sn[0]
        for cur in sn[1:]:
            w = m.window(prev, cur)
            if w and w[2]:
                st += [cur[(w[0] + j) % 256] for j in range(w[1])
                       if prev[(w[0] + j) % 256] != cur[(w[0] + j) % 256]]
            prev = cur
        c = collections.Counter(x >> 24 for x in st)
        tot = max(len(st), 1)
        states.append((name, {k: 1000 * v / tot for k, v in c.items()}))

    sense = {}
    try:
        for l in open('ref/MAC-CMD-MAP.txt'):
            if l.startswith('0x'):
                # «частые параметры» — переменное число токенов, поэтому
                # смысл берём от первой квадратной скобки уровня, а не по
                # фиксированной колонке (иначе параметры лезут в описание)
                p = l.split()
                i = l.find('[')
                sense[int(p[0], 16)] = l[i:].strip() if i > 0 else ''
    except FileNotFoundError:
        pass

    codes = sorted({c for _, p in states for c in p})
    print('# доля команд на 1000 в каждом состоянии')
    print('%-5s %s  %s' % ('код', ' '.join('%9s' % n[:9] for n, _ in states),
                           'смысл'))
    for c in codes:
        row = ' '.join('%9.1f' % p.get(c, 0) for _, p in states)
        print('0x%02x  %s  %s' % (c, row, sense.get(c, '')[:40]))


if __name__ == '__main__':
    main()
