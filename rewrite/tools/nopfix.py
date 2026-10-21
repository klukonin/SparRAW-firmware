#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""nopfix.py [--apply] — для каждой nop-группы vendor после MAC-команды найти в
C-порте uc_mac_cmd(...) с той же константой и вставить ту же последовательность
nop'ов.  Неоднозначные места печатает для ручного разбора."""
import os, re, glob, sys
R = os.path.dirname(os.path.abspath(__file__))
ASM = os.path.join(R, '..', '..', '6.2', 'src', 'asm', 'uc')
APPLY = '--apply' in sys.argv
names = {}
for l in open(os.path.join(R, 'ghidra', 'out', 'names.txt')):
    p = l.split()
    if len(p) >= 2: names[int(p[0], 16)] = p[1]
cfiles = {f: open(f).read() for f in glob.glob(os.path.join(R, '..', 'uc', '*.c'))}

def find_body(name):
    for f, s in cfiles.items():
        m = re.search(r'^[a-z][^\n;]*\b%s\s*\([^;{]*\)\s*\{' % re.escape(name), s, re.M)
        if m:
            i = m.end(); d = 1
            while d and i < len(s):
                d += {'{': 1, '}': -1}.get(s[i], 0); i += 1
            return f, m.start(), i
    return None

NOPMAP = {'nop_s': 'nop_s', 'nop': 'nop', 'mov 0x0,0x0': 'mov 0,0'}
manual = []
for af in sorted(glob.glob(os.path.join(ASM, '*', '*.S'))):
    t = open(af).read()
    m = re.search(r'@ 0x([0-9a-f]+)', t)
    if not m: continue
    a = int(m.group(1), 16)
    ins = [l.strip() for l in t.split('\n') if l.startswith('\t') and not l.strip().startswith(('.', '/*'))]
    groups = []
    for i, s in enumerate(ins):
        if s.startswith('bclr r25,r25') and i + 1 < len(ins) and ins[i+1] in NOPMAP:
            j = i + 1; seq = []
            while j < len(ins) and ins[j] in NOPMAP: seq.append(NOPMAP[ins[j]]); j += 1
            # регистр команды и константа
            mm = re.match(r'st\.ab (r\d+),\[r25', ins[i-1])
            const = None
            if mm:
                reg = mm.group(1)
                for k in range(i-2, max(i-12, -1), -1):
                    c = re.match(r'(?:mov|mov_s|or|or_s|bset|bset_s)\s+%s,(?:%s,|r\d+,)?(0x[0-9a-f]+)$' % (reg, reg), ins[k])
                    if c and int(c.group(1), 16) > 0xffff: const = int(c.group(1), 16); break
            groups.append((const, seq, ins[j] if j < len(ins) else ''))
    if not groups: continue
    n = names.get(a, os.path.basename(af)[:-2])
    fb = find_body(n)
    if not fb: manual.append((n, 'нет C-функции', groups)); continue
    f, b0, b1 = fb
    body = cfiles[f][b0:b1]
    newbody = body; changed = 0
    from collections import defaultdict
    byc = defaultdict(list)
    for const, seq, nxt in groups:
        if const is None: manual.append((n, 'нет константы', [(const, seq, nxt)])); continue
        byc[const].append((seq, nxt))
    for const, gl in byc.items():
        pat = re.compile(r'([ \t]*)(uc_mac_cmd\([^;]*?0x%x[^;]*\);[^\n]*\n)' % const, re.I)
        hits = list(pat.finditer(newbody))
        if len(hits) != len(gl):
            manual.append((n, '%d совпадений 0x%x на %d групп' % (len(hits), const, len(gl)), [(const, s_, x_) for s_, x_ in gl])); continue
        for h, (seq, nxt) in reversed(list(zip(hits, gl))):
            after = newbody[h.end():h.end()+80]
            if 'nop' in after.split('\n')[0]: continue
            ins_txt = '%s__asm__ volatile("%s");\n' % (h.group(1), '\\n\\t'.join(seq))
            newbody = newbody[:h.end()] + ins_txt + newbody[h.end():]
            changed += 1
    if changed:
        print('%-40s +%d' % (n, changed))
        if APPLY:
            cfiles[f] = cfiles[f][:b0] + newbody + cfiles[f][b1:]
if APPLY:
    for f, s in cfiles.items():
        if open(f).read() != s: open(f, 'w').write(s)
print('--- вручную:')
for n, why, g in manual:
    print('%-40s %s %s' % (n, why, [(hex(c) if c else None, len(s), x) for c, s, x in g]))
