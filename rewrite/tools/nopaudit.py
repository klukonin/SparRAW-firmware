#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""nopaudit.py — где vendor после MAC-команды (st.ab …,[r25] / bclr r25) ставит
nop'ы перед чтением регистров ядра, а в нашем C-порте asm-nop'ов меньше.
Эмулятор задержку MAC не моделирует, поэтому eqcheck такие места не ловит."""
import os, re, glob, sys
R = os.path.dirname(os.path.abspath(__file__))
ASM = os.path.join(R, '..', '..', '6.2', 'src', 'asm', 'uc')
names = {}
for l in open(os.path.join(R, 'ghidra', 'out', 'names.txt')):
    p = l.split()
    if len(p) >= 2: names[int(p[0], 16)] = p[1]
src = ''
for f in glob.glob(os.path.join(R, '..', 'uc', '*.c')): src += open(f).read()

def cbody(name):
    m = re.search(r'^[a-z][^\n;]*\b%s\s*\([^;{]*\)\s*\{' % re.escape(name), src, re.M)
    if not m: return None
    i = m.end(); d = 1
    while d and i < len(src):
        d += {'{': 1, '}': -1}.get(src[i], 0); i += 1
    return src[m.start():i]

def nopcount(b):
    """Число nop-инструкций в теле: примитивы include/arc.h (arc_nops(n) и др.) + сырой asm."""
    c = 0
    for m in re.finditer(r'\barc_(nops|nops_mb|nops_nop|zol_nops2|nop_s|nop|nop_mb)\s*\(([^)]*)\)', b):
        k, a = m.group(1), m.group(2).strip()
        c += {'nops': lambda: int(a, 0), 'nops_mb': lambda: int(a, 0),
              'nops_nop': lambda: int(a, 0) + 1, 'zol_nops2': lambda: 3}.get(k, lambda: 1)()
    b = re.sub(r'\barc_\w+\s*\([^)]*\)', '', b)
    return c + len(re.findall(r'nop', b))

for f in sorted(glob.glob(os.path.join(ASM, '*', '*.S'))):
    t = open(f).read()
    m = re.search(r'@ 0x([0-9a-f]+)', t)
    if not m: continue
    a = int(m.group(1), 16)
    ins = [l.strip() for l in t.split('\n') if l.startswith('\t') and not l.strip().startswith(('.', '/*'))]
    groups = 0
    for i, s in enumerate(ins):
        if s.startswith('bclr r25,r25') and i + 1 < len(ins) and ins[i+1] in ('nop_s', 'nop', 'mov 0x0,0x0'):
            groups += 1
    if not groups: continue
    n = names.get(a, os.path.basename(f)[:-2])
    b = cbody(n)
    if b is None:
        print('%-40s vendor %d групп nop, C-функция не найдена' % (n, groups)); continue
    c = nopcount(b)
    if c < groups:
        print('%-40s vendor %d групп nop, в C nop-вставок %d' % (n, groups, c))
