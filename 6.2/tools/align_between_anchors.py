#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Достроить соответствие версий между уже найденными опорами.

Опоры — блоки 6.2, которым имя дано переносом из 4.1 (по лог-строке или
по уникальной константе). Между двумя соседними опорами обе версии
содержат по цепочке блоков. Если цепочки совпадают И числом блоков, И
размером каждого — байт в байт, — соответствие внутри них однозначно:
перебрать иначе нельзя, не нарушив ни одного размера.

Это НЕ сравнение по сигнатурам и не граф вызовов: работает только
порядок в сегменте и точные размеры, а границы участка закреплены
опорами, каждая из которых доказана отдельно.

Цепочка отвергается целиком, если хоть один размер разошёлся: частичное
совпадение означало бы, что внутри что-то добавили или убрали, и
дальнейшее выравнивание было бы догадкой.
"""
import argparse, json


GENERIC = ('sub_', 'blk_', 'frag_', 'tail_', 'epi_', 'stub_ret_', 'FUN_')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--from-blocks', required=True)
    ap.add_argument('--to-blocks', required=True)
    ap.add_argument('--out', required=True)
    ap.add_argument('--tag', default='fw')
    ap.add_argument('--max-gap', type=int, default=40,
                    help='максимум блоков в цепочке между опорами')
    a = ap.parse_args()

    src = sorted(json.load(open(a.from_blocks))['blocks'], key=lambda b: b['addr'])
    dst = sorted(json.load(open(a.to_blocks))['blocks'], key=lambda b: b['addr'])
    sidx = {b['name']: i for i, b in enumerate(src)}

    # опоры: блок 6.2 назван именем, которое есть и в 4.1
    anchors = []
    for j, b in enumerate(dst):
        nm = b['name']
        i = sidx.get(nm)
        if i is None:
            for suf in ('_fw', '_uc'):
                if nm.endswith(suf):
                    i = sidx.get(nm[:-len(suf)])
                    break
        if i is not None and not nm.startswith(GENERIC):
            anchors.append((j, i))
    # оставить только монотонно растущую цепочку опор
    mono = []
    for j, i in anchors:
        while mono and mono[-1][1] >= i:
            mono.pop()
        mono.append((j, i))

    taken = set()
    for l in open(a.out):
        q = l.split()
        if len(q) >= 2 and q[0].startswith('0x'):
            taken.add(q[1])

    out, spans, rejected = [], 0, 0
    for (j0, i0), (j1, i1) in zip(mono, mono[1:]):
        dseg, sseg = dst[j0 + 1:j1], src[i0 + 1:i1]
        if not dseg or len(dseg) != len(sseg) or len(dseg) > a.max_gap:
            rejected += 1
            continue
        if any(d['size'] != s['size'] for d, s in zip(dseg, sseg)):
            rejected += 1
            continue
        spans += 1
        for d, s in zip(dseg, sseg):
            if not d['name'].startswith(GENERIC) or s['name'].startswith(GENERIC):
                continue
            nm = s['name']
            if nm in taken:
                if nm + '_' + a.tag in taken:
                    continue
                nm += '_' + a.tag
            taken.add(nm)
            out.append((d['addr'], nm, len(dseg), d['size']))

    with open(a.out, 'a') as f:
        f.write('\n# --- выравнивание между опорами (%s): цепочки блоков '
                'между двумя доказанными соответствиями, совпавшие числом '
                'и всеми размерами, align_between_anchors.py ---\n' % a.tag)
        for ad, nm, n, sz in sorted(out):
            f.write('0x%08x %s # цепочка из %d блоков сошлась размер в размер '
                    '(%d Б)\n' % (ad, nm, n, sz))
    print('%s: опор %d, цепочек принято %d, отвергнуто %d, имён %d'
          % (a.tag, len(mono), spans, rejected, len(out)))


if __name__ == '__main__':
    main()
