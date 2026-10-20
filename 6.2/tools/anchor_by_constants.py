#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сопоставление блоков между версиями по уникальным константам.

Развитие приёма, найденного на маркерах трассировки `0xeeeeNN`: микрокод
пишет их в кольцо команд MAC при входе в функцию, и номер маркера
совпадает у 4.1 и 6.2. Но такой якорь даёт не только маркер — годится
ЛЮБАЯ константа, которая встречается ровно в одном блоке каждой версии:
магические слова, коды кадров, пороги, идентификаторы.

Это не сравнение по сигнатурам (оно на этих образах отвергнуто трижды)
и не граф вызовов: константа — буквальное содержимое обеих прошивок.

Что отбрасывается и почему:
  * константы меньше порога — совпадают случайно;
  * адреса кода и данных (0x8xxxxx, 0x9xxxxx) — они версионные, у 4.1 и
    6.2 разные, и совпадение тут означало бы совпадение раскладки.
    ИСКЛЮЧЕНИЕ — сами маркеры 0xeeeeNN: они попадают в этот диапазон,
    но адресами не являются, и без явной оговорки лучший якорь метода
    отбрасывался бы вместе с адресами;
  * строковые адреса 0x10xxxxx — то же самое;
  * константа, встречающаяся больше чем в одном блоке хотя бы одной из
    версий: тогда это не якорь, а общая величина.

Имя принимается, если большинство якорей блока ведут в один блок-донор.
"""
import argparse, bisect, collections, json, re

CONST = re.compile(r'\b0x([0-9a-f]{4,8})\b')


def index(insns, lo, hi, blocks, minval, maxowners=1):
    """Возвращает {константа: имя блока} для констант, уникальных в версии."""
    st = sorted(json.load(open(blocks))['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]
    by = collections.defaultdict(set)
    for l in open(insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        a = int(p[1], 16)
        if not lo <= a < hi:
            continue
        i = bisect.bisect_right(ads, a) - 1
        nm = st[i]['name']
        for m in CONST.finditer(p[3]):
            v = int(m.group(1), 16)
            if v < minval:
                continue
            if 0xeeee00 <= v <= 0xeeeeff:
                by[v].add(nm)                  # маркер трассировки ucode:
                continue                       # специально уникален, см. ниже
            if 0x800000 <= v < 0x1000000:      # адрес кода или данных
                continue
            if 0x1000000 <= v < 0x1100000:     # адрес в таблице строк
                continue
            by[v].add(nm)
    # maxowners > 1: константа может принадлежать нескольким блокам, и
    # тогда она сама по себе якорем не является — но пара таких констант,
    # указывающих на один и тот же блок-донор, уже улика. Поэтому
    # возвращаем множества, а решение принимает голосование.
    uniq = {v: s for v, s in by.items() if 1 <= len(s) <= maxowners}
    return uniq, {b['name']: b for b in st}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--from-insns', required=True)
    ap.add_argument('--from-blocks', required=True)
    ap.add_argument('--to-insns', required=True)
    ap.add_argument('--to-blocks', required=True)
    ap.add_argument('--lo', required=True)
    ap.add_argument('--hi', required=True)
    ap.add_argument('--min-const', default='0x1000')
    ap.add_argument('--min-anchors', type=int, default=2)
    ap.add_argument('--max-owners', type=int, default=1,
                    help='скольким блокам версии константа может принадлежать')
    ap.add_argument('--size-tol', type=int, default=75,
                    help='при одном якоре: насколько близки размеры, в %%')
    ap.add_argument('--out', required=True)
    ap.add_argument('--tag', default='uc')
    a = ap.parse_args()
    lo, hi, mv = int(a.lo, 16), int(a.hi, 16), int(a.min_const, 16)

    src, sblocks = index(a.from_insns, lo, hi, a.from_blocks, mv, a.max_owners)
    dst, dblocks = index(a.to_insns, lo, hi, a.to_blocks, mv, a.max_owners)

    GENERIC = ('sub_', 'blk_', 'frag_', 'tail_', 'epi_', 'stub_ret_', 'FUN_')
    taken = set()
    for l in open(a.out):
        q = l.split()
        if len(q) >= 2 and q[0].startswith('0x'):
            taken.add(q[1])

    votes = collections.defaultdict(collections.Counter)
    proof = {}
    for v, dset in dst.items():
        sset = src.get(v)
        if not sset:
            continue
        for dnm in dset:
            if not dnm.startswith(GENERIC):
                continue
            for snm in sset:
                if snm.startswith(GENERIC):
                    continue
                votes[dnm][snm] += 1
                proof.setdefault((dnm, snm), []).append(v)

    out, skip = [], collections.Counter()
    for dnm, c in sorted(votes.items()):
        top, n = c.most_common(1)[0]
        if n < a.min_anchors or n == 1:
            # Один якорь — улика слабее: константа могла совпасть случайно.
            # Принимаем только при независимом подтверждении размером:
            # функция, пережившая версию, меняется, но не в разы.
            ds, ss = dblocks[dnm]['size'], sblocks[top]['size']
            if not (min(ds, ss) * 100 >= max(ds, ss) * a.size_tol):
                skip['якорь один, размеры не сходятся'] += 1
                continue
        if len(c) > 1 and n <= c.most_common(2)[1][1] * 2:
            skip['якоря спорят'] += 1
            continue
        nm = top
        if nm in taken:
            if nm + '_' + a.tag in taken:
                skip['имя уже занято'] += 1
                continue
            nm += '_' + a.tag
        taken.add(nm)
        anchors = sorted(proof[(dnm, top)])[:3]
        out.append((dblocks[dnm]['addr'], nm, n, sum(c.values()),
                    ' '.join('0x%x' % x for x in anchors)))

    with open(a.out, 'a') as f:
        f.write('\n# --- сопоставление с 4.1.0.1000 по уникальным константам '
                '(%s), anchor_by_constants.py ---\n' % a.tag)
        for ad, nm, n, tot, anc in sorted(out):
            f.write('0x%08x %s # якорей %d/%d, напр.: %s\n' % (ad, nm, n, tot, anc))
    print('%s: сопоставлено %d блоков; пропущено: %s'
          % (a.tag, len(out), dict(skip)))


if __name__ == '__main__':
    main()
