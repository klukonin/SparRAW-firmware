#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Карта битовых полей команд MAC, снятая с кода.

Поля команды собирают сдвигами и установкой битов непосредственно перед
отправкой:

    ldb r3,[r1,0xc] ; asl r3,r3,1     -> поле начинается с бита 1
    ldb r0,[r1,0xd] ; asl r0,r0,0xa   -> с бита 10
    bset r2,r2,0x19                   -> одиночный бит 25

Инструмент проходит окно инструкций перед каждой отправкой и собирает
позиции, по которым укладываются куски параметра.  Это даёт формат
команды без документации.

    mac_cmd_fields.py > ref/MAC-CMD-FIELDS.txt
"""
import bisect, collections, json, re, sys

WIN = 26
ASL = re.compile(r'\basl(?:_s)?\s+(r\d+),\s*(r\d+),\s*(0x[0-9a-f]+|\d+)$')
ASL2 = re.compile(r'\basl(?:_s)?\s+(r\d+),\s*(0x[0-9a-f]+|\d+)$')
BSET = re.compile(r'\bbset(?:_s)?\s+(r\d+),\s*(?:r\d+,\s*)?(0x[0-9a-f]+|\d+)$')
BMSK = re.compile(r'\bbmsk(?:_s)?\s+(r\d+),\s*(?:r\d+,\s*)?(0x[0-9a-f]+|\d+)$')
SEND = re.compile(r'\bmov(?:_s)?(?:\.\w+)?\s+r32,')
LD = re.compile(r'\bld[bw]?(?:_s)?[a-z.]*\s+(r\d+),\s*\[([^\]]+)\]')


def main():
    ins = []
    for l in open('../blobs/insns/INSNS-4100.txt'):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if 0x920000 <= ad < 0x940000:
            ins.append((ad, p[3].rstrip().lstrip('_')))

    codes = {}
    for l in open('ref/MAC-CMD-SITES.txt'):
        if not l.startswith('0x'):
            continue
        p = l.split()
        m = re.match(r'0x([0-9a-f]{2})', p[2])
        if m:
            codes[int(p[0], 16)] = int(m.group(1), 16)

    pos = {ad: i for i, (ad, _) in enumerate(ins)}
    fields = collections.defaultdict(collections.Counter)
    srcs = collections.defaultdict(collections.Counter)
    for ad, code in codes.items():
        i = pos.get(ad)
        if i is None:
            continue
        for j in range(max(0, i - WIN), i):
            t = ins[j][1]
            if SEND.search(t):
                fields[code]['|'] += 0      # граница: раньше была другая команда
                continue
            m = ASL.search(t) or ASL2.search(t)
            if m:
                sh = int(m.groups()[-1], 0)
                if 0 < sh < 24:
                    fields[code]['сдвиг %d' % sh] += 1
                continue
            m = BSET.search(t)
            if m:
                b = int(m.group(2), 0)
                if b < 24:
                    fields[code]['бит %d' % b] += 1
                continue
            m = LD.search(t)
            if m:
                srcs[code][m.group(2).split(',')[0].strip()] += 1

    for code in sorted(fields):
        f = [k for k, v in fields[code].most_common() if v and k != '|']
        if not f:
            continue
        print('0x%02x  %s' % (code, ', '.join(f[:8])))
    print('# кодов с разобранными полями: %d' % len(fields), file=sys.stderr)


if __name__ == '__main__':
    main()
