#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""fwlog.py <fw_peri.bin> [--raw] — журнал fw 6.2 из кольца 0x843900 (blob_fw_peri).

Запись: заголовок (биты 31..28 = 0xa/0xb, 27..26 — число аргументов, 19..0 — смещение строки
в таблице строк 6.2/ref/strings-fw.bin), слово времени, аргументы. Кольцо переполняется —
вывод по умолчанию в хронологическом порядке (после записи с наибольшим временем идут
самые старые). --raw — в порядке буфера.
"""
import os, re, struct, sys

HERE = os.path.dirname(os.path.abspath(__file__))
S = open(os.path.join(HERE, '..', '..', '..', '6.2', 'ref', 'strings-fw.bin'), 'rb').read()


def st(o):
    if o >= len(S):
        return None
    return S[o:o + 200].split(b'\0')[0].decode('latin1')


def decode(P, base=0x843900, n=0x1000):
    w = struct.unpack_from('<%dI' % (n // 4), P, base - 0x840000)
    out, i = [], 1
    while i < len(w):
        h = w[i]
        if (h >> 28) in (0xa, 0xb) and i + 1 < len(w):
            na = (h >> 26) & 3
            fmt = st(h & 0xfffff) or '?'
            aa = []
            for a in w[i + 2:i + 2 + na]:
                aa.append(st(a - 0x1000000) if 0x1000000 <= a < 0x1030000 and st(a - 0x1000000) else a)
            try:
                txt = fmt.replace('%s', '%r')
                txt = re.sub(r'%[0-9lu]*[dux]', '%s', txt)
                txt = re.sub(r'%[0-9]*X', '%s', txt)
                txt = txt % tuple(hex(a) if isinstance(a, int) else a for a in aa)
            except Exception:
                txt = fmt + ' ' + repr(aa)
            out.append((w[i + 1], '%05x ts=%08x %s' % (i * 4, w[i + 1], txt)))
            i += 2 + na
        else:
            i += 1
    return out


if __name__ == '__main__':
    recs = decode(open(sys.argv[1], 'rb').read())
    if '--raw' not in sys.argv and recs:
        k = max(range(len(recs)), key=lambda j: recs[j][0])
        recs = recs[k + 1:] + recs[:k + 1]
    for _, line in recs:
        if not line.endswith('0x0x0'):
            print(line)
