#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Чинит склейку блоков: разрезает их по целям вызовов.

Ghidra местами не разделяет соседние функции, и один «блок» вбирает
несколько настоящих. В fw 6.2 так вышло, например, с 0x8de394: 4 208
байт одним куском, внутри — и mlme_notify, и диспетчер команд WMI со
116 лог-строками. Пока они склеены, ни одна из них не получит имени, а
метрика покрытия засчитает весь кусок по имени первой.

Критерий разреза механический и не допускает догадок: **цель `bl`/`jl`
— всегда начало функции**. Если такая цель лежит внутри блока, но не в
его начале, блок склеен именно там.

Адрес, дописанный в NAMES-EXTRA, СОЗДАЁТ новую границу, поэтому разрез делается просто записью имени `sub_АДРЕС`.
Байты образа от этого не меняются — гейт обязан остаться побайтовым.
"""
import argparse, bisect, json, re

CALL = re.compile(r'^_?(bl|jl)(\.d)?\s+0x00([0-9a-fA-F]{6})$')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--base', required=True)
    ap.add_argument('--end', required=True)
    ap.add_argument('--out', required=True)
    ap.add_argument('--tag', default='fw')
    a = ap.parse_args()
    lo, hi = int(a.base, 16), int(a.end, 16)

    targets = set()
    starts = set()
    for l in open(a.insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if not lo <= ad < hi:
            continue
        starts.add(ad)
        m = CALL.match(p[3].rstrip())
        if m:
            t = int(m.group(3), 16)
            if lo <= t < hi:
                targets.add(t)

    blocks = sorted(json.load(open(a.blocks))['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in blocks]
    own = {b['addr'] for b in blocks}

    have = set()
    for l in open(a.out):
        q = l.split()
        if len(q) >= 2 and q[0].startswith('0x'):
            have.add(int(q[0], 16))

    cuts = []
    for t in sorted(targets):
        if t in own or t in have:
            continue
        if t not in starts:
            continue          # цель не на границе инструкции — не трогаем
        i = bisect.bisect_right(ads, t) - 1
        if i < 0:
            continue
        cuts.append((t, blocks[i]['name'], blocks[i]['addr'], blocks[i]['size']))

    with open(a.out, 'a') as f:
        f.write('\n# --- разрез склеенных блоков по целям вызовов (%s), '
                'split_by_calls.py ---\n' % a.tag)
        for t, nm, ba, bs in cuts:
            f.write('0x%08x sub_%06x # цель bl/jl внутри %s (%06x..%06x)\n'
                    % (t, t, nm, ba, ba + bs))
    per = {}
    for t, nm, ba, bs in cuts:
        per.setdefault(nm, 0)
        per[nm] += 1
    print('%s: целей вызова %d, разрезов %d в %d блоках'
          % (a.tag, len(targets), len(cuts), len(per)))
    for nm, n in sorted(per.items(), key=lambda kv: -kv[1])[:8]:
        print('   %-34s разрезов %d' % (nm, n))


if __name__ == '__main__':
    main()
