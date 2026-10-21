#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сравнение машинного кода двух сборок по функциям (гейт рефакторинга plain C11).

  codecmp.py old.elf new.elf [--map old=new ...] [-v]

Каждая функция → поток «мнемоника операнды», где цели переходов/вызовов заменены на
<символ+смещение>, а адреса инструкций убраны. Функции сопоставляются по имени
(--map — переименования; файл `--maps FILE`, строки «old new»). Печатает изменённые,
пропавшие и новые функции; код возврата 0 — всё совпало.
limm-константы, попадающие в код/rodata (>= 0x8c0000), сводятся к
<символ+смещение>, поэтому сдвиг раскладки сам по себе изменением не считается;
MMIO и прочие числа сравниваются как есть.
"""
import re, subprocess, sys, argparse, collections

TGT = re.compile(r'(-?\d+)?\s*;\s*([0-9a-f]+) <([^>]+)>')


def symtab(elf):
    """Отсортированные (адрес, имя) символов кода/данных образа (для нормализации limm)."""
    out = subprocess.run(['arc-elf32-nm', '-n', elf], capture_output=True, text=True, check=True).stdout
    syms = []
    for l in out.splitlines():
        p = l.split()
        if len(p) == 3 and p[1] in 'tTrRdDbB' and not p[2].startswith(('.L', '$')):
            syms.append((int(p[0], 16), p[2]))
    return syms


def funcs(elf):
    import bisect
    syms = symtab(elf)
    addrs = [a for a, _ in syms]
    lo = addrs[0] if addrs else 0
    hi = addrs[-1] + 0x10000 if addrs else 0

    def sym(m):
        v = int(m.group(0), 16)
        # только адреса внутри символов образа (код 0x8c…, rodata, данные .data); MMIO и
        # константы вне диапазона — как есть
        # DCCM (0x800000..) — фиксированные адреса, раскладка их не двигает: как есть
        if not (lo <= v < hi) or v < 0x8c0000:
            return m.group(0)
        i = bisect.bisect_right(addrs, v) - 1
        a, n = syms[i]
        return '<%s+%#x>' % (n, v - a) if v != a else '<%s>' % n

    out = subprocess.run(['arc-elf32-objdump', '-d', '--no-show-raw-insn', elf],
                         capture_output=True, text=True, check=True).stdout
    fn = None
    res = collections.OrderedDict()
    for l in out.splitlines():
        m = re.match(r'^([0-9a-f]+) <(.+)>:$', l)
        if m:
            fn = m.group(2)
            res[fn] = []
            continue
        m = re.match(r'^\s*[0-9a-f]+:\s+(\S+)\s*(.*)$', l)
        if not m or fn is None:
            continue
        ops = m.group(2)
        mt = TGT.search(ops)
        if mt:
            ops = ops[:mt.start()] + '<' + mt.group(3) + '>'
        else:
            ops = re.sub(r'\b0x[0-9a-f]{6,8}\b', sym, ops)
        res[fn].append((m.group(1) + ' ' + ops.strip()).strip())
    return res


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('old')
    ap.add_argument('new')
    ap.add_argument('--map', action='append', default=[])
    ap.add_argument('--maps')
    ap.add_argument('-v', action='store_true')
    a = ap.parse_args()
    ren = dict(x.split('=') for x in a.map)
    if a.maps:
        for l in open(a.maps):
            p = l.split()
            if len(p) == 2:
                ren[p[0]] = p[1]
    o, n = funcs(a.old), funcs(a.new)

    def canon(body):
        # имена целей внутри тела тоже переводим (old → new)
        return [re.sub(r'<([^>+]+)', lambda m: '<' + ren.get(m.group(1), m.group(1)), x) for x in body]

    changed, gone = [], []
    for f, body in o.items():
        g = ren.get(f, f)
        if g not in n:
            gone.append(f)
            continue
        if canon(body) != n[g]:
            changed.append(g)
    new = [f for f in n if f not in {ren.get(x, x) for x in o}]
    for f in changed:
        print('CHANGED', f)
        if a.v:
            import difflib
            ob = canon(o[[k for k in o if ren.get(k, k) == f][0]])
            for d in difflib.unified_diff(ob, n[f], lineterm='', n=1):
                print('   ', d)
    for f in gone:
        print('GONE   ', f)
    for f in new:
        print('NEW    ', f)
    print('функций: old %d, new %d; изменено %d, пропало %d, новых %d'
          % (len(o), len(n), len(changed), len(gone), len(new)))
    sys.exit(0 if not (changed or gone or new) else 1)


if __name__ == '__main__':
    main()
