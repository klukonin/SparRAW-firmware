#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Имя блока по единственной структуре данных, к которой он обращается.

Расширение `name_by_global.py`: тот смотрит только на доступы через gp и
на блоки до 80 байт. Здесь считаются ЛИТЕРАЛЬНЫЕ адреса 0x80xxxx,
встречающиеся в теле, независимо от размера блока.

Если такой адрес ровно один, про блок честно сказать, что он работает с
этой структурой — не больше и не меньше. Что именно в ней лежит, из тела
не видно, и в имени этого нет.

Блоки, которые трогают и регистры 0x88xxxx, пропускаются: для них есть
`name_by_rgf.py`, и банк регистров информативнее адреса данных.
"""
import argparse, collections, json, re

# Данные прошивки: 0x80xxxx (линкерные), плюс области 0x84xxxx и
# 0x85xxxx, куда вендор кладёт крупные структуры и буферы. Диапазоны
# кода (0x8c..0x8f у fw, 0x92..0x93 у ucode) сюда не попадают.
GLB = re.compile(r'\b0x(8[0-5][0-9a-f]{4})\b')
RGF = re.compile(r'\b0x(88[0-9a-f]{4})\b')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--lo', required=True)
    ap.add_argument('--hi', required=True)
    ap.add_argument('--min-size', type=int, default=16)
    ap.add_argument('--max-addrs', type=int, default=1,
                    help='сколько адресов можно перечислить в имени')
    ap.add_argument('--out')
    ap.add_argument('--tag', default='fw')
    a = ap.parse_args()
    lo, hi = int(a.lo, 16), int(a.hi, 16)

    ins = {}
    for l in open(a.insns):
        if l.startswith('I '):
            p = l.split(None, 3)
            ad = int(p[1], 16)
            if lo <= ad < hi:
                ins[ad] = (int(p[2]), p[3].rstrip())

    st = sorted(json.load(open(a.blocks))['blocks'], key=lambda b: b['addr'])
    used = {b['name'] for b in st}
    out = []
    for b in st:
        if not b['name'].startswith(('sub_', 'blk_')) or b['size'] < a.min_size:
            continue
        body, p = [], b['addr']
        while p < b['addr'] + b['size']:
            ln, t = ins.get(p, (2, '?'))
            body.append(t)
            p += ln
        txt = ' '.join(body)
        banks = sorted(set(RGF.findall(txt)))
        g = sorted(set(GLB.findall(txt)))
        if banks:
            # банк регистров информативнее адреса данных, поэтому если
            # блок трогает и то, и другое, имя даёт банк
            if len(banks) > a.max_addrs:
                continue
            nm = 'rgf_%s__%06x' % ('_'.join(banks), b['addr'])
        else:
            if not g or len(g) > a.max_addrs:
                continue
            nm = 'uses_g_%s__%06x' % ('_'.join(g), b['addr'])
        if nm in used:
            continue
        used.add(nm)
        out.append((b['addr'], nm, b['size'],
                    ', '.join('0x' + x for x in (banks or g))))

    if a.out:
        with open(a.out, 'a') as f:
            f.write('\n# --- блоки по единственной структуре данных (%s), '
                    'name_by_single_struct.py ---\n' % a.tag)
            for ad, nm, sz, g in out:
                f.write('0x%08x %s # адреса, к которым обращается тело: %s, %d Б\n'
                        % (ad, nm, g, sz))
    print('%s: блоков %d, байт %d' % (a.tag, len(out), sum(x[2] for x in out)))


if __name__ == '__main__':
    main()
