#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Карта команд прошивка -> ucode: отправитель (fw) и обработчик (ucode).

Отправка: send_cmd2_lmac @0x8e0694, код в r1.
Приём: umac_if_cmd_handler @0x936dd0 — код индексирует БАЙТОВУЮ таблицу
0x800c68 (пространство данных ucode), байт*2 — смещение заглушки от 0x936e5e,
заглушка зовёт обработчик.
"""
import bisect, json, re

def blocks(seg):
    d = json.load(open('src/asm/%s/blocks.json' % seg))
    st = sorted(d['blocks'], key=lambda b: b['addr'])
    return st, [b['addr'] for b in st]


def main():
    fw, fwa = blocks('fw')
    uc, uca = blocks('uc')

    def own(st, ads, a):
        i = bisect.bisect_right(ads, a) - 1
        return st[i]['name'] if i >= 0 else '?'

    by = bytearray()
    for l in open('src/data/uc_data.S'):
        m = re.match(r'\s*\.byte\s+([0-9a-fx,\s]+?)\s*(?:/\*|$)', l)
        if m:
            for v in m.group(1).split(','):
                v = v.strip()
                if v:
                    by.append(int(v, 0))
        elif re.match(r'\s*\.long\s+', l):
            by += b'\0\0\0\0'

    ins = {}
    rows = []
    for l in open('../blobs/insns/INSNS-6200.txt'):
        if l.startswith('I '):
            p = l.split(None, 3)
            a = int(p[1], 16)
            t = p[3].rstrip()
            ins[a] = t
            if 0x8c0000 <= a < 0x8fc564:
                rows.append((a, t))

    MOVK = re.compile(r'^_?mov(?:_s)?\s+(r\d+),\s*(0x[0-9a-f]+|\d+)$')
    CALL = re.compile(r'^_?(?:bl|b)(?:\.d)?\s+0x0*([0-9a-f]{6})$')
    send = {}
    for i, (a, t) in enumerate(rows):
        m = CALL.match(t)
        if not m or int(m.group(1), 16) != 0x8e0694:
            continue
        regs = {}
        for j in range(max(0, i - 12), i + 2):
            mm = MOVK.match(rows[j][1])
            if mm:
                regs[mm.group(1)] = int(mm.group(2), 0)
        c = regs.get('r1')
        if c is not None:
            send.setdefault(c, set()).add(own(fw, fwa, a))

    print('| код | отправитель (fw) | обработчик (ucode) |')
    print('|---|---|---|')
    for code in range(0x42):
        o = 0x800c68 + code - 0x800000
        if o >= len(by):
            break
        stub = 0x936e5e + 2 * by[o]
        t = ins.get(stub, '')
        m = re.search(r'0x0*([0-9a-f]{6})', t)
        h = own(uc, uca, int(m.group(1), 16)) if m and t.startswith(('bl', 'b ', 'b.d')) else '—'
        s = ', '.join(sorted(send.get(code, []))) or '—'
        if s == '—' and h == '—':
            continue
        print('| 0x%02x | %s | %s |' % (code, s, h))


if __name__ == '__main__':
    main()
