#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# uclog.py <uc_data.bin> [--fw <образ.fw>] — журнал uc (кольцо 256 слов по uc_data+0x3234+0x14) в хронологии.
# Заголовок: биты 31..26 = 0b1010nn (nn — число аргументов 0..3), 25..18 — старший байт TSF, 17..0 —
# смещение строки: vendor (SparRAW-tools/host/ucode_strings.json, 6.2.0.1000) и свои SparRAW с 0x10000
# (include/logstr_uc.def; с --fw — из записи образа). Неизвестный токен (свои отладочные вставки,
# напр. 0x10fff00) печатается как ?<token> с аргументами в hex.
import json, os, struct, sys
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, '..'))
import logstr
STR = os.path.join(HERE, '../../../../SparRAW-tools/host/ucode_strings.json')
b = open(sys.argv[1], 'rb').read()
S = {int(k): v for k, v in json.load(open(STR))['6.2.0.1000']['strings'].items()}
_t = logstr.from_image(open(sys.argv[sys.argv.index('--fw') + 1], 'rb').read(), 'uc') if '--fw' in sys.argv else None
_base, _tab = _t if _t else logstr.table('uc')
_o = 0
for _s in _tab.split(b'\0')[:-1]:
    S[_base + _o] = _s.decode('latin1')
    _o += len(_s) + 1
base = 0x3234
ring = [struct.unpack_from('<I', b, base + 0x14 + 4 * i)[0] for i in range(256)]
out, i = [], 0
while i < 256:
    h = ring[i]
    if (h >> 26) & 0x3c == 0x28:            # 0xa0..0xaf
        n = (h >> 26) & 3
        t = S.get(h & 0x3ffff)
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
