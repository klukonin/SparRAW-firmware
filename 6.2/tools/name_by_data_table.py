#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Имя блока по таблице данных, которую он индексирует.

Родственник `name_by_rgf.py`, только для данных, а не для блоков
регистров. Признак строгий: адрес 0x80xxxx попал в регистр и этот
регистр стал базой ИНДЕКСИРУЕМОГО доступа `ld rX,[база,индекс]` — то
есть блок ходит по массиву, а не читает одно поле.

Так узнаются, например, ветви обработки передачи в микрокоде: каждая
разбирает свой массив дескрипторов (элемент 80 байт) — 0x80110c,
0x801110, 0x80111c. Что именно лежит в массиве, из тела блока не видно,
поэтому в имени этого и нет: честно ровно то, что блок ходит по такой-то
таблице.

Блоки с несколькими таблицами пропускаются: какая из них главная — уже
догадка.
"""
import argparse, bisect, collections, json, re

MOV = re.compile(r'^_?mov(?:_s)?\s+(r\d+),\s*(0x80[0-9a-f]{4})$')
IDX = re.compile(r'^_?ld[bw]?(?:_s)?[a-z.]*\s+\S+,\[(r\d+),\s*(r\d+)\]$')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--lo', required=True)
    ap.add_argument('--hi', required=True)
    ap.add_argument('--min-size', type=int, default=32)
    ap.add_argument('--out')
    ap.add_argument('--tag', default='uc')
    a = ap.parse_args()
    lo, hi = int(a.lo, 16), int(a.hi, 16)

    st = sorted(json.load(open(a.blocks))['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]
    use = collections.defaultdict(set)
    const, cur = {}, None
    for l in open(a.insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if not lo <= ad < hi:
            continue
        b = st[bisect.bisect_right(ads, ad) - 1]
        if b is not cur:
            cur, const = b, {}
        t = p[3].rstrip()
        m = MOV.match(t)
        if m:
            const[m.group(1)] = m.group(2)
            continue
        m = IDX.match(t)
        if m and m.group(1) in const:
            use[b['name']].add(const[m.group(1)])

    out = []
    for b in st:
        if not b['name'].startswith(('sub_', 'blk_')) or b['size'] < a.min_size:
            continue
        t = use.get(b['name'])
        if not t or len(t) != 1:
            continue
        out.append((b['addr'], 'uses_tbl_%s__%06x' % (next(iter(t))[2:], b['addr']),
                    b['size'], next(iter(t))))
    if a.out:
        with open(a.out, 'a') as f:
            f.write('\n# --- блоки по единственной индексируемой таблице данных '
                    '(%s), name_by_data_table.py ---\n' % a.tag)
            for ad, nm, sz, tb in out:
                f.write('0x%08x %s # ходит по массиву %s, %d Б\n' % (ad, nm, tb, sz))
    print('%s: блоков %d, байт %d' % (a.tag, len(out), sum(x[2] for x in out)))


if __name__ == '__main__':
    main()
