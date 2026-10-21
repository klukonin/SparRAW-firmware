#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сверка адресов общей памяти fw ↔ uc: литерал FWSH_A_<имя> в include/fwsh.h (основа имён-
макросов uc) и символ <имя> из fw/fw.ld в fw.elf должны совпадать; символа нет — ошибка.
usage: check_fwsh.py <fw.elf> <nm>"""
import re, subprocess, sys, os


def main():
    elf, nm = sys.argv[1], sys.argv[2]
    here = os.path.dirname(os.path.abspath(__file__))
    h = open(os.path.join(here, '..', 'include', 'fwsh.h')).read()
    lits = {m.group(1): int(m.group(2), 16)
            for m in re.finditer(r'^#define\s+FWSH_A_(\w+)\s+(0x[0-9a-fA-F]+)u?\b', h, re.M)}
    syms = {}
    for l in subprocess.run([nm, elf], capture_output=True, text=True, check=True).stdout.splitlines():
        p = l.split()
        if len(p) == 3:
            syms[p[2]] = int(p[0], 16)
    bad = 0
    for n, a in sorted(lits.items(), key=lambda x: x[1]):
        if n not in syms:
            print('check_fwsh: %s (0x%x) — нет символа в fw.elf (fw/fw.ld)' % (n, a))
            bad = 1
        elif syms[n] != a:
            print('check_fwsh: %s — в fwsh.h 0x%x, в fw.ld 0x%x' % (n, a, syms[n]))
            bad = 1
    if not lits:
        print('check_fwsh: в include/fwsh.h нет FWSH_A_*')
        bad = 1
    return bad


if __name__ == '__main__':
    sys.exit(main())
