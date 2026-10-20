#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Назвать безымянные блоки по блоку регистров, с которым они работают.

Имя вида `<файл>__rgf_<база>` (или get_/set_, если блок только читает или
только пишет) говорит ровно то, что известно: эта функция обращается к
такому-то блоку регистров.  Это та же честность, что у принятых в проекте
`mac_bringup__prog_881000` и `vring__reg_write_locked_3c`.

Берутся только блоки, у которых база РОВНО ОДНА — иначе имя было бы
догадкой о том, какая из них главная.
"""
import argparse, bisect, collections, json, re

SHORT = {
    'hw_drivers_phy': 'hwd_phy', 'hw_drivers_abif': 'hwd_abif',
    'hw_drivers_dma': 'hwd_dma', 'hw_drivers_pcie': 'hwd_pcie',
    'hw_drivers_mac': 'hwd_mac', 'hw_drivers_mac_parser': 'mac_parser',
    'hw_drivers_rfc': 'hwd_rfc', 'hw_drivers_user_spi': 'hwd_spi',
    'hw_drivers_pcie_dbi': 'hwd_dbi', 'hw_modes_mac': 'hwm_mac',
    'hw_modes_phy': 'hwm_phy', 'hw_boot_configs': 'hw_boot',
}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--seg', default='fw')
    ap.add_argument('--lo', default='0x8c0000')
    ap.add_argument('--hi', default='0x8f3b58')
    ap.add_argument('--min-size', type=int, default=20)
    ap.add_argument('--max-size', type=int, default=200)
    a = ap.parse_args()
    lo, hi = int(a.lo, 16), int(a.hi, 16)

    d = json.load(open('src/asm/%s/blocks.json' % a.seg))
    st = sorted(d['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]

    def own(x):
        i = bisect.bisect_right(ads, x) - 1
        return st[i]

    banks = collections.defaultdict(set)
    rw = collections.defaultdict(set)
    const = {}
    pat = re.compile(r'\bmov(?:_s)?\s+(r\d+),\s*0x(88[0-9a-f]{4})\b')
    use = re.compile(r'\b(ld|ldb|ldw|st|stb|stw)[a-z._]*\s+(?:[^,]+),\s*\[(r\d+)')
    absu = re.compile(r'\b(ld|ldb|ldw|st|stb|stw)[a-z._]*\s+(?:[^,]+),\s*\[0x(88[0-9a-f]{4})')
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
        m = pat.search(t)
        if m:
            const[m.group(1)] = m.group(2)
            banks[b['name']].add(m.group(2))
            continue
        m = absu.search(t)
        if m:
            banks[b['name']].add(m.group(2))
            rw[b['name']].add('r' if m.group(1).startswith('ld') else 'w')
            continue
        m = use.search(t)
        if m and m.group(2) in const:
            rw[b['name']].add('r' if m.group(1).startswith('ld') else 'w')

    out = []
    for b in st:
        n = b['name']
        if not n.startswith(('sub_', 'blk_')):
            continue
        if not (a.min_size <= b['size'] <= a.max_size):
            continue
        s = banks.get(n)
        if not s or len(s) != 1:
            continue
        bank = next(iter(s))
        kind = rw.get(n, set())
        pref = 'get' if kind == {'r'} else ('set' if kind == {'w'} else 'rgf')
        sh = SHORT.get(b['dir'])
        nm = '%s__%s_%s' % (sh, pref, bank) if sh else '%s_reg_%s' % (pref, bank)
        out.append((b['addr'], nm, b['size'], b['dir']))
    seen = collections.Counter(x[1] for x in out)
    for ad, nm, sz, dr in out:
        if seen[nm] > 1:
            nm = '%s_%06x' % (nm, ad)
        print('0x%08x  %-34s # %d Б, %s' % (ad, nm, sz, dr))
    import sys
    print('# блоков: %d, байт: %d' % (len(out), sum(x[2] for x in out)), file=sys.stderr)


if __name__ == '__main__':
    main()
