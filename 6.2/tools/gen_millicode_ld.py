#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сопоставляет милли-код прошивки с тем, что зовёт gcc.

ВНИМАНИЕ: связывать их напрямую НЕЛЬЗЯ, и в сборке это не делается.
Соглашения расходятся на стороне восстановления: вендорский трамплин сам
ставит `r12 = 4` (снять только blink), а gcc передаёт в r12 размер кадра.
Подставив одно вместо другого, получаем сдвиг стека ровно на размер кадра.
Поэтому наш код собирается с `-mno-millicode`, а этот скрипт остаётся
справочником: он показывает, где в образе лежат обе цепочки.

Прошивка собрана с милли-кодом ARC: вместо серии push/pop компилятор зовёт
общие цепочки. gcc для нашего кода делает то же самое и ссылается на них по
стандартным именам `__st_r13_to_rNN`, `__ld_r13_to_rNN` и `..._ret`. Эти
подпрограммы в образе уже есть — надо лишь сказать линковщику их адреса.

Цепочка сохранения — сплошная лента `st.aw rNN,[sp,-4]`, заканчивающаяся
`j_s.d [blink]` + `st.aw r13`: вход, сохраняющий r13..rNN, лежит на
4*(NN-13) байт раньше конца.

Цепочка восстановления — таблица входов `mov_s r12,4; mov_s r13,N; b ...`,
где N — сколько байт регистров снять; число регистров N/4 задаёт rNN.
"""
import argparse
import re


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--lo', required=True)
    ap.add_argument('--hi', required=True)
    ap.add_argument('--suffix', default='', help='добавка к имени, если сегментов два')
    ap.add_argument('--out', required=True)
    a = ap.parse_args()
    lo, hi = int(a.lo, 16), int(a.hi, 16)

    rows = []
    for l in open(a.insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if lo <= ad < hi:
            rows.append((ad, int(p[2]), p[3].rstrip()))
    rows.sort()
    by = {ad: (n, t) for ad, n, t in rows}

    # конец цепочки сохранения: j_s.d [blink] со `st.a r13` в слоте задержки
    save_end = None
    for i, (ad, n, t) in enumerate(rows):
        # у инструкции в слоте задержки Ghidra ставит впереди подчёркивание
        if t.startswith('j_s.d') and i + 1 < len(rows) and \
           re.match(r'_?st\.aw?\s+r13,\[sp,-0x4\]$', rows[i + 1][2]):
            save_end = ad
            break
    if save_end is None:
        raise SystemExit('не нашёл конец цепочки сохранения в %06x..%06x' % (lo, hi))

    out = ['/* Милли-код ARC, уже присутствующий в образе: адреса под именами,',
           ' * которыми его зовёт gcc. Сгенерировано gen_millicode_ld.py. */']
    for nn in range(13, 27):
        ad = save_end - 4 * (nn - 13)
        if ad not in by:
            break
        nm = 'gp' if nn == 26 else 'r%d' % nn
        out.append('PROVIDE(__st_r13_to_%s%s = 0x%08x);' % (nm, a.suffix, ad))

    # таблица восстановления: mov_s r12,0x4 ; mov_s r13,N
    for i, (ad, n, t) in enumerate(rows):
        if not re.match(r'mov_s\s+r12,0x4$', t):
            continue
        if i + 1 >= len(rows):
            continue
        m = re.match(r'mov_s\s+r13,(0x[0-9a-f]+|\d+)$', rows[i + 1][2])
        if not m:
            continue
        cnt = int(m.group(1), 0) // 4
        if not 1 <= cnt <= 14:
            continue
        nn = 12 + cnt
        nm = 'gp' if nn == 26 else 'r%d' % nn
        out.append('PROVIDE(__ld_r13_to_%s_ret%s = 0x%08x);' % (nm, a.suffix, ad))

    open(a.out, 'w').write('\n'.join(out) + '\n')
    print('%s: записей %d -> %s' % (a.out, len(out) - 2, a.out))


if __name__ == '__main__':
    main()
