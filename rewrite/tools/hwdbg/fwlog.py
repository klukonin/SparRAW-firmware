#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""fwlog.py <fw_peri.bin> [--raw] [--fw <образ.fw>] — журнал fw 6.2 из кольца 0x843900 (blob_fw_peri).

Запись: заголовок (биты 31..28 = 0xa/0xb, 27..26 — число аргументов, 25..18 — старший байт TSF,
17..0 — смещение строки), слово времени, аргументы. Строки: таблица vendor 6.2/ref/strings-fw.bin
и свои SparRAW с 0x30000 (include/logstr_fw.def; с --fw — из записи образа, для чужой сборки).
Кольцо переполняется — вывод по умолчанию в хронологическом порядке (после записи с наибольшим
временем идут самые старые). --raw — в порядке буфера.
"""
import os, re, struct, sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, '..'))
import logstr
VENDOR_STRINGS = os.path.join(HERE, '..', '..', '..', '6.2', 'ref', 'strings-fw.bin')


def load_strings(image=None):
    """Таблица строк: vendor + свои SparRAW (из образа image или из include/logstr_fw.def)."""
    return logstr.merged(open(VENDOR_STRINGS, 'rb').read(), 'fw', image)


S = None   # таблица по умолчанию — загружается при первом decode() без tab


def st(o):
    if o >= len(S):
        return None
    return S[o:o + 200].split(b'\0')[0].decode('latin1')


def decode(P, base=0x843900, n=0x1000, tab=None):
    """[(время, строка)] из снимка blob_fw_peri; tab — таблица строк (load_strings), по умолчанию из .def."""
    global S
    if tab is not None:
        S = tab
    elif S is None:
        S = load_strings()
    w = struct.unpack_from('<%dI' % (n // 4), P, base - 0x840000)
    out, i = [], 1
    while i < len(w):
        h = w[i]
        if (h >> 28) in (0xa, 0xb) and i + 1 < len(w):
            na = (h >> 26) & 3
            fmt = st(h & 0x3ffff) or '?'
            aa = []
            for a in w[i + 2:i + 2 + na]:
                aa.append(st(a - 0x1000000) if 0x1000000 <= a < 0x1040000 and st(a - 0x1000000) else a)
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


def chrono(recs):
    """Записи в хронологическом порядке: кольцо переполняется — после записи с наибольшим временем самые старые."""
    if not recs:
        return recs
    k = max(range(len(recs)), key=lambda j: recs[j][0])
    return recs[k + 1:] + recs[:k + 1]


if __name__ == '__main__':
    img = sys.argv[sys.argv.index('--fw') + 1] if '--fw' in sys.argv else None
    recs = decode(open(sys.argv[1], 'rb').read(), tab=load_strings(img))   # argv[1] — снимок blob_fw_peri
    if '--raw' not in sys.argv:
        recs = chrono(recs)
    for _, line in recs:
        if not line.endswith('0x0x0'):
            print(line)
