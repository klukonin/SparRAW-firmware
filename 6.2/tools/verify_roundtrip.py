#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сверка: собрать сегмент из ассемблерного текста и сравнить с оригиналом.

Все инструкции раскладываются по своим настоящим адресам через .org от базы
сегмента, объект линкуется по этой базе — тогда PC-относительные переходы
кодируются так же, как в оригинале. Затем побайтовое сравнение.
"""
import argparse, os, re, subprocess, sys, tempfile
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from gen_asm_tree import normalize, relabel


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--bin', required=True)
    ap.add_argument('--base', required=True)
    ap.add_argument('--as', dest='as_', required=True)
    ap.add_argument('--ld', dest='ld_', required=True)
    ap.add_argument('--cpu', default='arc600')
    ap.add_argument('--limit', type=int, default=0)
    a = ap.parse_args()
    base = int(a.base, 16)
    blob = open(a.bin, 'rb').read()
    end = base + len(blob)

    rows = []
    for l in open(a.insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if base <= ad < end:
            rows.append((ad, int(p[2]), p[3].rstrip('\n')))
    rows.sort()
    if a.limit:
        rows = rows[:a.limit]
    span_end = rows[-1][0] + rows[-1][1]

    with tempfile.TemporaryDirectory() as td:
        s = os.path.join(td, 'seg.s')
        known = {ad for ad, _, _ in rows}
        with open(s, 'w') as f:
            f.write('\t.section .text\n')
            for ad, ln, txt in rows:
                f.write('\t.org 0x%x\nL_%06x:\n\t%s\n'
                        % (ad - base, ad, relabel(normalize(txt), known)))
        o = os.path.join(td, 'seg.o'); e = os.path.join(td, 'seg.elf'); b = os.path.join(td, 'seg.bin')
        r = subprocess.run([a.as_, '-mcpu=' + a.cpu, '-o', o, s], capture_output=True, text=True)
        if r.returncode:
            print(r.stderr[:3000]); sys.exit('ассемблер не отработал')
        r = subprocess.run([a.ld_, '-Ttext=0x%x' % base, '-o', e, o], capture_output=True, text=True)
        if r.returncode:
            print(r.stderr[:2000]); sys.exit('линковщик не отработал')
        subprocess.run([a.ld_.replace('-ld', '-objcopy'), '-O', 'binary', '-j', '.text', e, b], check=True)
        got = open(b, 'rb').read()

    ref = blob[:span_end - base]
    got = got[:len(ref)]
    bad = [i for i in range(min(len(ref), len(got))) if ref[i] != got[i]]
    print('инструкций %d, байт сверено %d, расхождений %d (%.3f%%)'
          % (len(rows), len(ref), len(bad), 100.0 * len(bad) / max(1, len(ref))))
    # какие инструкции задеты
    if bad:
        idx = {}
        for ad, ln, txt in rows:
            for k in range(ln):
                idx[ad - base + k] = (ad, txt)
        seen = {}
        for i in bad:
            if i in idx:
                ad, txt = idx[i]
                seen.setdefault(txt.split()[0], [0, txt])[0] += 1
        print('мнемоники с расхождением (топ):')
        for mn, (c, ex) in sorted(seen.items(), key=lambda kv: -kv[1][0])[:12]:
            print('   %-12s %4d байт   пример: %s' % (mn, c, ex[:60]))


if __name__ == '__main__':
    main()
