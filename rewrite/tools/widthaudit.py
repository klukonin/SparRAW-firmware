#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""widthaudit.py — ширина доступа к абсолютным адресам DCCM: vendor (ld/ldw/ldb, st/stw/stb,
gp-относительные с масштабом .as) против C (*(u32|u16|u8 *)0xADDR) в той же функции."""
import os, re, glob, collections
R = os.path.dirname(os.path.abspath(__file__))
GP = 0x800528
names = {}
for l in open(os.path.join(R, 'ghidra', 'out', 'names.txt')):
    p = l.split()
    if len(p) >= 2: names[int(p[0], 16)] = p[1]
src = ''.join(open(f).read() for f in glob.glob(os.path.join(R, '..', 'uc', '*.c')))
def body(n):
    m = re.search(r'^[a-z][^\n;]*\b%s\s*\([^;{]*\)\s*(?:/\*[^\n]*?\*/)?\s*\{' % re.escape(n), src, re.M)
    if not m: return None
    i = src.index('{', m.end() - 1) + 1; d = 1
    while d and i < len(src): d += {'{': 1, '}': -1}.get(src[i], 0); i += 1
    return src[m.start():i]
SZ = {'': 4, 'w': 2, 'b': 1}
for f in sorted(glob.glob(os.path.join(R, '..', '..', '6.2', 'src', 'asm', 'uc', '*', '*.S'))):
    t = open(f).read(); m = re.search(r'@ 0x([0-9a-f]+)', t)
    if not m: continue
    n = names.get(int(m.group(1), 16)); b = body(n) if n else None
    if not b: continue
    ins = [l.strip() for l in t.split('\n') if l.startswith('\t') and not l.strip().startswith(('.', '/*'))]
    regc = {}; vacc = collections.defaultdict(set)
    for s in ins:
        mm = re.match(r'^mov(_s)?\s+(r\d+),(0x80[0-9a-f]{4})$', s)
        if mm: regc[mm.group(2)] = int(mm.group(3), 16); continue
        mm = re.match(r'^(ld|st)([wb]?)(\.x)?(\.a[bws]?|\.as)?(_s)?\s+(r\d+|0x[0-9a-f]+),\[(gp|r\d+),\s*(-?0x[0-9a-f]+|\d+)\]', s)
        if mm:
            op, w, as_, base, off = mm.group(1), mm.group(2), mm.group(4) or '', mm.group(7), mm.group(8)
            off = int(off, 16) if 'x' in off else int(off)
            sz = SZ[w]
            if base == 'gp':
                a = GP + off * (sz if as_ == '.as' else 1)
            elif base in regc and as_ != '.as':
                a = regc[base] + off
            else:
                continue
            if 0x800000 <= a < 0x808000: vacc[a].add(sz)
        dst = re.match(r'^\S+\s+(r\d+),', s)
        if dst and dst.group(1) in regc and not s.startswith(('st', 'mov ', 'mov_s')): regc.pop(dst.group(1), None)
    for a, szs in vacc.items():
        cs = set(int(x) // 8 for x in re.findall(r'\*\(u(8|16|32) \*\)\(?0x%x\b' % a, b))
        if cs and not (cs & szs):
            print('%-40s 0x%06x vendor %s C %s' % (n, a, sorted(szs), sorted(cs)))
