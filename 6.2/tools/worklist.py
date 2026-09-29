#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Очередь на разбор: безымянные блоки с уликами, по убыванию размера.

Полное покрытие упирается не в приёмы, а в перебор: осталось около 1770
блоков на 83 КБ, и почти все требуют чтения. Этот список выдаёт по каждому
всё, что известно заранее, чтобы на блок уходило чтение, а не раскопки.
"""
import argparse
import json


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--seg', default='fw')
    ap.add_argument('-n', type=int, default=10)
    ap.add_argument('--skip', type=int, default=0)
    ap.add_argument('--dir', help='только блоки из этого исходного файла')
    a = ap.parse_args()
    m = json.load(open('src/asm/%s/blocks.json' % a.seg))
    an = json.load(open('ref/ANNO-%s.json' % a.seg))
    bl = [b for b in m['blocks'] if b['name'].startswith(('sub_', 'blk_'))]
    if a.dir:
        bl = [b for b in bl if b['dir'] == a.dir]
    bl.sort(key=lambda x: -x['size'])
    for b in bl[a.skip:a.skip + a.n]:
        e = an.get(b['name'], {})
        print('== %s  %d байт  @0x%06x  [%s]' % (b['name'], b['size'], b['addr'], b['dir']))
        for f, t in (('strings', 'печатает'), ('callers', 'зовут'),
                     ('calls', 'зовёт'), ('globals', 'глобалы'), ('rgf', 'регистры')):
            if e.get(f):
                print('   %-9s %s' % (t, ', '.join(map(str, e[f]))[:150]))


if __name__ == '__main__':
    main()
