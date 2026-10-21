#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сверка карты DCCM: имя-макрос в uc/dccm.h ((*(T *)0xADDR) / ((T *)0xADDR)) и объект с тем же
именем в uc.elf (uc/data.c) должны иметь один адрес; объекты data.c без макроса — предупреждение; тег структуры не должен совпадать с именем макроса.
usage: check_dccm.py <uc.elf> <nm>"""
import re, subprocess, sys, os

def main():
    elf, nm = sys.argv[1], sys.argv[2]
    here = os.path.dirname(os.path.abspath(__file__))
    h = open(os.path.join(here, '..', 'uc', 'dccm.h')).read()
    macros = {m.group(1): int(m.group(2), 16)
              for m in re.finditer(r'^#define\s+(\w+)\s+\(\*?\([^)]*\*\)\s*(0x[0-9a-fA-F]+)\)', h, re.M)}
    syms = {}
    for l in subprocess.run([nm, elf], capture_output=True, text=True, check=True).stdout.splitlines():
        p = l.split()
        if len(p) == 3 and p[1] in 'DdBbRr' and 0x800000 <= int(p[0], 16) < 0x808000:
            syms[p[2]] = int(p[0], 16)
    bad = [(n, a, syms[n]) for n, a in macros.items() if n in syms and syms[n] != a]
    for n, a, s in bad:
        print('check_dccm: %s — в dccm.h 0x%x, в data.c 0x%x' % (n, a, s))
    # тег структуры, совпадающий с именем макроса, ломает `struct <имя>` в .c
    tags = set(re.findall(r'^struct\s+(\w+)\s*\{', h, re.M))
    clash = sorted(tags & set(macros))
    for n in clash:
        print('check_dccm: тег struct %s совпадает с макросом %s' % (n, n))
    return 1 if bad or clash else 0

if __name__ == '__main__':
    sys.exit(main())
