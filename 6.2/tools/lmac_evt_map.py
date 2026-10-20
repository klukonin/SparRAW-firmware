#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Карта событий ucode -> прошивка: тип, имя из строки "Ucode->..." и обработчик.

Диспетчер lmac_if__ucode_event_dispatch @0x8dae80: тип индексирует таблицу
ПОЛУСЛОВ 0x801b98, значение*2 — смещение ветки от 0x8daeb8. В каждой ветке
своя строка и свой обработчик.
"""
import bisect, json, re, struct

TBL = 0x801b98
BASE = 0x8daeb8
SKIP = 320   # общая ветка-заглушка


def main():
    by = bytearray()
    for l in open('src/data/fw_data.S'):
        m = re.match(r'\s*\.byte\s+([0-9a-fx,\s]+?)\s*(?:/\*|$)', l)
        if m:
            for v in m.group(1).split(','):
                v = v.strip()
                if v:
                    by.append(int(v, 0))
        elif re.match(r'\s*\.long\s+', l):
            by += b'\0\0\0\0'
    ins = {}
    for l in open('../blobs/insns/INSNS-6200.txt'):
        if l.startswith('I '):
            p = l.split(None, 3)
            ins[int(p[1], 16)] = (int(p[2]), p[3].rstrip())
    d = json.load(open('src/asm/fw/blocks.json'))
    st = sorted(d['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]
    sd = open('ref/strings-fw.bin', 'rb').read()

    def s(a):
        o = a - 0x1000000
        if 0 <= o < len(sd):
            t = sd[o:o + 70].split(b'\0')[0]
            try:
                return t.decode('ascii')
            except UnicodeDecodeError:
                return None

    def own(a):
        i = bisect.bisect_right(ads, a) - 1
        return st[i]

    print('| тип | имя | обработчик |')
    print('|---|---|---|')
    for e in range(0x29):
        v = struct.unpack_from('<H', by, TBL + 2 * e - 0x800000)[0]
        if v == SKIP:
            continue
        name = None
        h = None
        p = BASE + 2 * v
        for _ in range(12):
            if p not in ins:
                break
            ln, t = ins[p]
            m = re.search(r'0x(1[0-9a-f]{6})', t)
            if m and name is None:
                v2 = s(int(m.group(1), 16))
                if v2 and 'Ucode->' in v2:
                    name = v2.split(':')[0].replace('Ucode->', '').strip()
            m = re.match(r'^_?(?:bl|b|jl)(?:\.d)?\s+0x0*([0-9a-f]{6})$', t)
            if m and h is None:
                hh = int(m.group(1), 16)
                if 0x8c0000 <= hh < 0x8fc564:
                    b = own(hh)
                    if not any(x in b['name'] for x in ('emit', 'assert', 'NNL')):
                        h = b['name']
            p += ln
        print('| 0x%02x | %s | `%s` |' % (e, name or '?', h or '—'))


if __name__ == '__main__':
    main()
