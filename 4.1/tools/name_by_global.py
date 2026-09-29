#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Назвать безымянные ЛИСТОВЫЕ блоки по единственному глобалу, с которым они работают.

Правила намеренно узкие: блок не зовёт ничего (лист), не больше 80 байт и
трогает ровно один адрес в 0x800000..0x807fff.  Такой блок — аксессор, и
имя `get_g_/set_g_/rw_g_<адрес>` описывает его целиком.
"""
import argparse, bisect, collections, json, re


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--seg', default='fw')
    ap.add_argument('--lo', default='0x8c0000')
    ap.add_argument('--hi', default='0x8f3b58')
    ap.add_argument('--gp', default='0x800170')
    ap.add_argument('--max-size', type=int, default=80)
    a = ap.parse_args()
    lo, hi, gp = int(a.lo, 16), int(a.hi, 16), int(a.gp, 16)

    d = json.load(open('src/asm/%s/blocks.json' % a.seg))
    st = sorted(d['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]

    def own(x):
        i = bisect.bisect_right(ads, x) - 1
        return st[i]

    G = collections.defaultdict(set)
    RW = collections.defaultdict(set)
    CALL = collections.Counter()
    const = {}
    movk = re.compile(r'\bmov(?:_s)?\s+(r\d+),\s*0x(80[0-7][0-9a-f]{3})\b')
    absu = re.compile(r'\b(ld|ldb|ldw|st|stb|stw)[a-z._]*\s+(?:[^,]+),\s*\[0x(80[0-7][0-9a-f]{3})')
    gpu = re.compile(r'\b(ld|ldb|ldw|st|stb|stw)([a-z._]*)\s+(?:[^,]+),\s*\[gp,\s*(-?0x[0-9a-f]+|-?\d+)\]')
    regu = re.compile(r'\b(ld|ldb|ldw|st|stb|stw)[a-z._]*\s+(?:[^,]+),\s*\[(r\d+)')
    call = re.compile(r'^_?(?:bl|jl)')
    cur = None
    for l in open('../blobs/insns/INSNS-4100.txt'):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if not (lo <= ad < hi):
            continue
        b = own(ad)
        if b is not cur:
            cur, const = b, {}
        t = p[3].rstrip()
        if call.match(t):
            CALL[b['name']] += 1
        m = movk.search(t)
        if m:
            const[m.group(1)] = m.group(2)
            G[b['name']].add(m.group(2))
            continue
        m = absu.search(t)
        if m:
            G[b['name']].add(m.group(2))
            RW[b['name']].add('r' if m.group(1).startswith('ld') else 'w')
            continue
        m = gpu.search(t)
        if m:
            off = int(m.group(3), 0)
            G[b['name']].add('%06x' % (gp + off))
            RW[b['name']].add('r' if m.group(1).startswith('ld') else 'w')
            continue
        m = regu.search(t)
        if m and m.group(2) in const:
            RW[b['name']].add('r' if m.group(1).startswith('ld') else 'w')

    out = []
    for b in st:
        n = b['name']
        if not n.startswith(('sub_', 'blk_')) or b['size'] > a.max_size:
            continue
        if CALL.get(n):
            continue
        s = G.get(n)
        if not s or len(s) != 1:
            continue
        g = next(iter(s))
        k = RW.get(n, set())
        pref = 'get_g' if k == {'r'} else ('set_g' if k == {'w'} else 'rw_g')
        out.append((b['addr'], '%s_%s' % (pref, g), b['size']))
    seen = collections.Counter(x[1] for x in out)
    for ad, nm, sz in out:
        if seen[nm] > 1:
            nm = '%s_%06x' % (nm, ad)
        print('0x%08x  %-30s # %d Б' % (ad, nm, sz))
    import sys
    print('# блоков: %d, байт: %d' % (len(out), sum(x[2] for x in out)), file=sys.stderr)


if __name__ == '__main__':
    main()
