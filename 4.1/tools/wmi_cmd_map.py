#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Карта WMI: строка "---->> [HOST CMD] WMI_..." в диспетчере -> обработчик.

Диспетчер host_if__wmi_cmd_dispatch @0x8da54c печатает имя команды прямо
перед вызовом её обработчика, поэтому пара берётся без догадок.
"""
import bisect, json, re

D = 0x8da54c
SIZE = 2360


def main():
    d = json.load(open('src/asm/fw/blocks.json'))
    st = sorted(d['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]
    sd = open('ref/strings-fw.bin', 'rb').read()

    def s(a):
        o = a - 0x1000000
        if 0 <= o < len(sd):
            t = sd[o:o + 80].split(b'\0')[0]
            try:
                return t.decode('ascii')
            except UnicodeDecodeError:
                return None

    def own(a):
        i = bisect.bisect_right(ads, a) - 1
        return st[i] if i >= 0 else None

    rows = []
    for l in open('../blobs/insns/INSNS-4100.txt'):
        if l.startswith('I '):
            p = l.split(None, 3)
            a = int(p[1], 16)
            if D <= a < D + SIZE:
                rows.append((a, p[3].rstrip()))

    MOV = re.compile(r'^_?mov(?:_s)?\s+r\d+,\s*(0x1[0-9a-f]{6})$')
    CALL = re.compile(r'^_?(?:bl|b)(?:\.d)?\s+0x0*([0-9a-f]{6})$')
    cur = None
    print('| команда | обработчик |')
    print('|---|---|')
    for a, t in rows:
        m = MOV.match(t)
        if m:
            v = s(int(m.group(1), 16))
            if v and 'HOST CMD' in v:
                cur = v.replace('---->> [HOST CMD] ', '').strip()
            continue
        m = CALL.match(t)
        if m and cur:
            h = int(m.group(1), 16)
            b = own(h)
            if b and 0x8c0000 <= h < 0x8f3b58 and 'fwlog' not in b['name'] and 'emit' not in b['name']:
                print('| %s | `%s` |' % (cur, b['name']))
                cur = None


if __name__ == '__main__':
    main()
