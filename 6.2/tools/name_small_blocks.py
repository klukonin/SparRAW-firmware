#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Называет мелкие блоки по их форме.

Хвост безымянного кода — это не «непонятные функции», а узнаваемые мелочи:
переходники к другой функции, пустые заглушки, чтение и запись одной
переменной. Форма такого блока описывает его целиком, поэтому имя по форме
— не догадка, а полное описание.

Правила намеренно строгие: блок должен состоять ровно из распознанных
инструкций и заканчиваться возвратом или хвостовым переходом. Всё, что
сложнее, остаётся безымянным.
"""
import argparse
import bisect
import json
import re

RET = re.compile(r'^_?j_?s?(\.d)?\s+blink$')
TAIL = re.compile(r'^_?b(\.d)?\s+0x0*([0-9a-f]{6})$')
MOVK = re.compile(r'^_?mov(_s)?\s+(r\d+|gp),(0x[0-9a-f]+|\d+)$')
MOVR = re.compile(r'^_?mov(_s)?\s+r\d+,r\d+$')
NOP = re.compile(r'^_?nop(_s)?$')
LDABS = re.compile(r'^_?ld(b|w)?(_s)?\s+r\d+,\[0x0*(8[0-9a-f]{5})\]$')
# регистры MAC/PHY — такие же однозначные аксессоры, как и глобалы
STABS = re.compile(r'^_?st(b|w)?(_s)?\s+(r\d+|0x[0-9a-f]+),\[0x0*(8[0-9a-f]{5})\]$')
LDGP = re.compile(r'^_?ld(b|w)?[a-z._]*\s+r\d+,\[gp,\s*(-?\w+)\]$')
LDREG = re.compile(r'^_?ld(b|w)?(_s)?\s+r\d+,\[(r\d+)(?:,\s*(-?\w+))?\]$')
STREG = re.compile(r'^_?st(b|w)?(_s)?\s+(?:r\d+|0x[0-9a-f]+),\[(r\d+)(?:,\s*(-?\w+))?\]$')
STGP = re.compile(r'^_?st(b|w)?[a-z._]*\s+r\d+,\[gp,\s*(-?\w+)\]$')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--gp', required=True)
    ap.add_argument('--max-size', type=int, default=24)
    a = ap.parse_args()
    gp = int(a.gp, 16)

    m = json.load(open(a.blocks))
    lo, hi = m['base'], m['end']
    starts = sorted(b['addr'] for b in m['blocks'])
    nm = {b['addr']: b['name'] for b in m['blocks']}

    ins = {}
    for l in open(a.insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if lo <= ad < hi:
            ins[ad] = (int(p[2]), p[3].rstrip())

    def owner(ad):
        i = bisect.bisect_right(starts, ad) - 1
        return nm[starts[i]] if i >= 0 else None

    out, stats = [], {}
    for b in m['blocks']:
        if not b['name'].startswith(('sub_', 'blk_')) or b['size'] > a.max_size:
            continue
        body, p = [], b['addr']
        while p < b['addr'] + b['size']:
            if p not in ins:
                body = None
                break
            body.append(ins[p][1])
            p += ins[p][0]
        if not body:
            continue

        kind = None
        tail = None
        reads, writes = [], []
        ok = True
        # простое распространение констант: какой регистр держит какой адрес
        const = {}
        for t in body:
            if NOP.match(t) or MOVR.match(t):
                continue
            mm = MOVK.match(t)
            if mm:
                const[mm.group(2)] = int(mm.group(3), 0)
                continue
            if RET.match(t):
                kind = kind or 'ret'
                continue
            mm = TAIL.match(t)
            if mm:
                tail = int(mm.group(2), 16)
                continue
            mm = LDABS.match(t)
            if mm:
                reads.append(int(mm.group(3), 16))
                continue
            mm = STABS.match(t)
            if mm:
                writes.append(int(mm.group(4), 16))
                continue
            mm = LDGP.match(t)
            if mm:
                reads.append(gp + int(mm.group(2), 0))
                continue
            mm = STGP.match(t)
            if mm:
                writes.append(gp + int(mm.group(2), 0))
                continue
            mm = LDREG.match(t)
            if mm and mm.group(3) in const:
                writes_off = int(mm.group(4), 0) if mm.group(4) else 0
                reads.append(const[mm.group(3)] + writes_off)
                continue
            mm = STREG.match(t)
            if mm and mm.group(3) in const:
                off = int(mm.group(4), 0) if mm.group(4) else 0
                writes.append(const[mm.group(3)] + off)
                continue
            ok = False
            break
        if not ok:
            continue

        name = None
        # хвост эпилога: только возврат кадра стека, отрезанный от своей функции
        if (not reads and not writes and tail is None and kind is None
                and body and all(re.match(r'^_?(add|sub)(_s)?\s+sp,', x) or NOP.match(x)
                                 for x in body)):
            name = 'epi_%06x' % b['addr']
        elif tail is not None and not reads and not writes:
            t = owner(tail)
            if t and not t.startswith(('sub_', 'blk_')):
                name = 'tail_%s' % t
        elif writes and not reads and len(set(writes)) == len(writes):
            w = min(writes)
            suf = '' if len(writes) == 1 else '_x%d' % len(writes)
            if 0x800000 <= w < 0x808000:
                name = 'set_g_%06x%s' % (w, suf)
            elif 0x880000 <= w < 0x890000:
                name = 'set_reg_%06x%s' % (w, suf)
            elif 0x840000 <= w < 0x860000:
                name = 'set_mem_%06x%s' % (w, suf)
        elif reads and not writes and len(set(reads)) == len(reads):
            r = min(reads)
            suf = '' if len(reads) == 1 else '_x%d' % len(reads)
            if 0x800000 <= r < 0x808000:
                name = 'get_g_%06x%s' % (r, suf)
            elif 0x880000 <= r < 0x890000:
                name = 'get_reg_%06x%s' % (r, suf)
            elif 0x840000 <= r < 0x860000:
                name = 'get_mem_%06x%s' % (r, suf)
        elif kind == 'ret' and not reads and not writes and tail is None:
            name = 'stub_ret_%06x' % b['addr']
        if name:
            out.append((b['addr'], name))
            stats[name.split('_')[0]] = stats.get(name.split('_')[0], 0) + 1

    seen = set()
    for ad, n in out:
        if n in seen:
            n = '%s_%06x' % (n, ad)
        seen.add(n)
        print('0x%08x  %s' % (ad, n))
    import sys
    print('# распознано %d блоков: %s' % (len(out), stats), file=sys.stderr)


if __name__ == '__main__':
    main()
