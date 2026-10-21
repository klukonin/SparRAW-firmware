#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# uclog.py <uc_data.bin> — журнал uc (кольцо 256 слов по uc_data+0x3234+0x14) в хронологии.
# Заголовок: биты 31..26 = 0b1010nn (nn — число аргументов 0..3), 25..18 — длина, 19..0 — токен
# строки (SparRAW-tools/host/ucode_strings.json, 6.2.0.1000). Неизвестный токен (свои отладочные
# вставки, напр. 0x10fff00) печатается как ?<token> с аргументами в hex.
import json, os, struct, sys
STR = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                   '../../../../SparRAW-tools/host/ucode_strings.json')
b = open(sys.argv[1], 'rb').read()
S = {int(k): v for k, v in json.load(open(STR))['6.2.0.1000']['strings'].items()}
base = 0x3234
ring = [struct.unpack_from('<I', b, base + 0x14 + 4 * i)[0] for i in range(256)]
out, i = [], 0
while i < 256:
    h = ring[i]
    if (h >> 26) & 0x3c == 0x28:            # 0xa0..0xaf
        n = (h >> 26) & 3
        t = S.get(h & 0xfffff)
        if t is None:
            t = '?%x' % (h & 0xfffff) + ' %x' * n
        args = [ring[(i + 2 + k) & 0xff] for k in range(n)]
        try:
            s = t % tuple(args) if n else t
        except Exception:
            s = '%s %s' % (t, [hex(a) for a in args])
        out.append((ring[(i + 1) & 0xff], s))
        i += 2 + n
    else:
        i += 1
for ts, s in sorted(out):
    print('%08x %s' % (ts, s[:160]))
