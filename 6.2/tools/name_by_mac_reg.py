#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Имя блока ucode по регистру MAC r40..r56, с которым он работает.

r40..r56 — регистровый файл MAC (MSXD_LR_RGF из пака Talyn, расшифровка
полей в ref/MSXD-LR-RGF.txt; например r42 бит 6 —
PHY_REMAINING_PPDU, а не «tsf_event», как казалось поначалу).

Если блок трогает РОВНО ОДИН из этих регистров, честно сказать, что он
работает с ним — это та же порода имён, что `mac_bringup__prog_881000`.
Блоки с несколькими регистрами пропускаются: выбор главного был бы
догадкой.
"""
import argparse, bisect, collections, json, re

REG = re.compile(r'\br(4[0-9]|5[0-6])\b')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--lo', default='0x920000')
    ap.add_argument('--hi', default='0x93ecc4')
    ap.add_argument('--min-size', type=int, default=16)
    ap.add_argument('--out')
    a = ap.parse_args()
    lo, hi = int(a.lo, 16), int(a.hi, 16)

    st = sorted(json.load(open(a.blocks))['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]
    use = collections.defaultdict(collections.Counter)
    for l in open(a.insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if not lo <= ad < hi:
            continue
        b = st[bisect.bisect_right(ads, ad) - 1]
        for m in REG.finditer(p[3]):
            use[b['name']][int(m.group(1))] += 1

    out = []
    for b in st:
        if not b['name'].startswith(('sub_', 'blk_')) or b['size'] < a.min_size:
            continue
        c = use.get(b['name'])
        if not c or len(c) != 1:
            continue
        r, n = next(iter(c.items()))
        out.append((b['addr'], 'macreg_r%d__%06x' % (r, b['addr']), b['size'], r, n))
    if a.out:
        with open(a.out, 'a') as f:
            f.write('\n# --- блоки ucode по единственному регистру MAC r40..r56 '
                    '(name_by_mac_reg.py) ---\n')
            for ad, nm, sz, r, n in out:
                f.write('0x%08x %s # трогает только r%d (%d обращений), %d Б\n'
                        % (ad, nm, r, n, sz))
    print('блоков с единственным регистром MAC: %d, байт %d'
          % (len(out), sum(x[2] for x in out)))


if __name__ == '__main__':
    main()
