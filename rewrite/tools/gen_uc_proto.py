#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Генерирует uc/proto.h — прототипы всех нестатических функций, определённых в uc/*.c.

Подключается через -include для uc/*.o, чтобы не было неявных объявлений
(int-возврат вместо u8/u16, неверное число аргументов) и чтобы gcc ловил
расхождения локальных объявлений с определениями.
  gen_uc_proto.py [--check]
"""
import os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
UC = os.path.join(os.path.dirname(HERE), 'uc')
OUT = os.path.join(UC, 'proto.h')
TYPES = r'(?:const\s+)?(?:void|u8|u16|u32|u64|s8|s16|s32|s64|int|unsigned|char|bool|struct\s+\w+)'
RX = re.compile(r'^(?!static\b)(?:inline\s+)?(%s(?:\s*\*+\s*|\s+))(\w+)\s*\(([^)]*)\)\s*(?:\{.*|/\*.*)?$' % TYPES)


def collect():
    defs = {}
    for f in sorted(os.listdir(UC)):
        if not f.endswith('.c'):
            continue
        L = open(os.path.join(UC, f)).read().split('\n')
        for i, l in enumerate(L):
            m = RX.match(l.rstrip())
            if not m:
                continue
            # определение, если '{' в строке или первая непустая следующая строка начинается с '{'
            nxt = next((x for x in L[i + 1:i + 3] if x.strip()), '')
            if '{' not in l and not nxt.startswith('{'):
                continue
            if '__attribute__' in l:
                continue
            rt, name, params = m.group(1).strip(), m.group(2), ' '.join(m.group(3).split())
            defs.setdefault(name, (rt, params or 'void', f))
    return defs


# Функции на ассемблере (uc/*.S) — прототипы вручную.
ASM = {
    # многострочные определения в C (генератор их не разбирает)
    'ppdu_unpack_desc_word': ('void', 'u32 a, u32 *o0, u32 *o1, u32 *o2, u32 *o3, u32 *o4, u32 *o5', 'phy.c'),
}


def render(defs):
    out = ['/* SPDX-License-Identifier: AGPL-3.0-or-later */',
           '/* АВТОГЕНЕРАЦИЯ tools/gen_uc_proto.py — не править руками. */',
           '#ifndef UC_PROTO_H', '#define UC_PROTO_H', '#include "../include/types.h"', '']
    # структуры из параметров (описаны в uc/dccm.h, который подключается после proto.h)
    tags = sorted({t for rt, p, f in defs.values() for t in re.findall(r'\bstruct\s+(\w+)', rt + ' ' + p)})
    out += ['struct %s;' % t for t in tags] + ([''] if tags else [])
    for n in sorted(defs):
        rt, p, f = defs[n]
        sp = '' if rt.endswith('*') else ' '
        out.append('%s%s%s(%s);%s/* %s */' % (rt, sp, n, p, ' ' * max(1, 60 - len(rt) - len(n) - len(p)), f))
    out += ['', '#endif', '']
    return '\n'.join(out)


if __name__ == '__main__':
    d = collect()
    for k, v in ASM.items():
        d.setdefault(k, v)
    txt = render(d)
    if '--check' in sys.argv:
        sys.exit(0 if os.path.exists(OUT) and open(OUT).read() == txt else 1)
    open(OUT, 'w').write(txt)
    print('%s: %d прототипов' % (OUT, txt.count(');')))
