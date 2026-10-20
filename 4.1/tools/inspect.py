#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Компактный вид блока: улики плюс листинг с разрешёнными именами.

Нужен для перебора хвоста: на блок должно уходить одно чтение.
Адреса вызовов и переходов заменяются именами, повторяющиеся милли-код и
логирование сворачиваются, чтобы в глаза бросалась суть.
"""
import argparse
import bisect
import json
import re
import subprocess

TC = '../toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install/bin/arc-elf32-objdump'


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('names', nargs='+')
    ap.add_argument('--seg', default='fw')
    ap.add_argument('--max', type=int, default=40, help='строк листинга на блок')
    a = ap.parse_args()
    m = json.load(open('src/asm/%s/blocks.json' % a.seg))
    an = json.load(open('ref/ANNO-%s.json' % a.seg))
    by = {b['name']: b for b in m['blocks']}
    starts = sorted(b['addr'] for b in m['blocks'])
    nm = {b['addr']: b['name'] for b in m['blocks']}

    def own(x):
        i = bisect.bisect_right(starts, x) - 1
        return nm[starts[i]] if i >= 0 else hex(x)

    for name in a.names:
        b = by.get(name)
        if not b:
            print('нет такого блока: %s' % name)
            continue
        e = an.get(name, {})
        print('===== %s  %d байт  @0x%06x  [%s]' % (name, b['size'], b['addr'], b['dir']))
        for f, t in (('strings', 'печатает'), ('callers', 'зовут'), ('calls', 'зовёт'),
                     ('globals', 'глобалы'), ('rgf', 'регистры MAC')):
            if e.get(f):
                print('  %-12s %s' % (t, ', '.join(map(str, e[f]))[:160]))
        out = subprocess.run([TC, '-d', '--start-address=0x%x' % b['addr'],
                              '--stop-address=0x%x' % (b['addr'] + b['size']),
                              'build/%s.elf' % a.seg], capture_output=True, text=True).stdout
        n = 0
        for l in out.splitlines():
            mm = re.match(r'^\s+([0-9a-f]+):\s+(?:[0-9a-f]{4} )+\s*(.*)$', l)
            if not mm:
                continue
            t = mm.group(2)
            t = re.sub(r';([0-9a-f]+) <[^>]*>', lambda x: ';' + own(int(x.group(1), 16)), t)
            t = re.sub(r'\s+', ' ', t).strip()
            t = re.sub(r'^(bl|b)([a-z._]*) -?\d+ ;', r'\1\2 ', t)
            print('   %s' % t)
            n += 1
            if n >= a.max:
                print('   ... (ещё %d байт)' % (b['size'] - (int(mm.group(1), 16) - b['addr'])))
                break


if __name__ == '__main__':
    main()
