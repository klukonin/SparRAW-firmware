#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сопоставить безымянные глобалы ucode/fw с именами из пака Talyn по раскладке.

Годится только точное вхождение: множество реально использованных смещений
должно целиком лежать в множестве смещений полей структуры из пака, а размер
структуры — вмещать самое дальнее обращение.  Всё остальное — догадка.
"""
import argparse, collections, re, xml.etree.ElementTree as ET

XML = '../../../WIGIG_TLN_7.5_11ad_pack/globals/TALYN_M_B0/%s_image_globals.xml'


def talyn(kind):
    root = ET.parse(XML % kind).getroot()
    tops = []
    for n in root:
        offs = set()
        base = int(n.get('address'), 16)
        stack = [n]
        while stack:
            x = stack.pop()
            offs.add(int(x.get('address'), 16) - base)
            stack.extend(list(x))
        tops.append((base, n.get('name'), offs))
    tops.sort()
    out = []
    for i, (ad, nm, offs) in enumerate(tops):
        # размер: до следующего глобала в том же килобайтовом регионе
        sz = None
        for ad2, _, _ in tops[i + 1:]:
            if ad2 > ad:
                sz = ad2 - ad
                break
        out.append((ad, nm, offs, sz))
    return out


def sparrow(insns, lo, hi):
    rows = []
    for l in open(insns):
        if l.startswith('I '):
            p = l.split(None, 3)
            rows.append((int(p[1], 16), p[3].rstrip()))
    use = collections.defaultdict(set)
    mv = re.compile(r'\bmov(?:_s)?\s+(r\d+|gp),\s*(?:0x([0-9a-f]{6}))\b')
    acc = re.compile(r'\b(?:ld|ldb|ldw|st|stb|stw)[a-z_.]*\s+(?:[^,]+),\s*\[(r\d+)(?:,\s*(-?0x[0-9a-f]+|-?\d+))?\]')
    direct = re.compile(r'\b(?:ld|ldb|ldw|st|stb|stw)[a-z_.]*\s+(?:[^,]+),\s*\[0x([0-9a-f]{6})\]')
    for i, (a, t) in enumerate(rows):
        if not (lo <= a < hi):
            continue
        m = direct.search(t)
        if m:
            use[int(m.group(1), 16)].add(0)
            continue
        m = mv.search(t)
        if not m:
            continue
        addr = int(m.group(2), 16)
        if not (0x800000 <= addr < 0x860000):
            continue
        reg = m.group(1)
        for j in range(i + 1, min(i + 14, len(rows))):
            tt = rows[j][1]
            if re.search(r'\b(mov|add|sub|or|and)[a-z_.]*\s+%s,' % reg, tt):
                break
            am = acc.search(tt)
            if am and am.group(1) == reg:
                off = int(am.group(2), 0) if am.group(2) else 0
                if 0 <= off < 0x400:
                    use[addr].add(off)
    return use


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', default='../blobs/insns/INSNS-4100.txt')
    ap.add_argument('--kind', default='ucode', choices=['ucode', 'fw'])
    ap.add_argument('--lo', default='0x920000')
    ap.add_argument('--hi', default='0x940000')
    ap.add_argument('--min-offs', type=int, default=4)
    a = ap.parse_args()
    T = talyn(a.kind)
    S = sparrow(a.insns, int(a.lo, 16), int(a.hi, 16))
    for base in sorted(S):
        offs = S[base]
        if len(offs) < a.min_offs:
            continue
        far = max(offs)
        cands = [(nm, len(o)) for ad, nm, o, sz in T
                 if offs <= o and (sz is None or far < sz)]
        if cands and len(cands) <= 6:
            print('0x%06x  смещений %-3d (до +0x%03x)  ->  %s'
                  % (base, len(offs), far, ', '.join(n for n, _ in cands)))


if __name__ == '__main__':
    main()
