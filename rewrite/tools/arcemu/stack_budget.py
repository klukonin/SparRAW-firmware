#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Статический бюджет стека uc по графу вызовов GCC (-fstack-usage -fcallgraph-info=su).

usage: stack_budget.py <каталог сборки uc с *.ci> [--top N]

Сборка: make BUILD=<dir> UC_DBG="-fstack-usage -fcallgraph-info=su" <dir>/uc.elf — рядом с объектами появляются
*.ci (граф вызовов в формате VCG с размером кадра каждой функции).

Стек uc один (uc/uc.ld: __stack_top 0x804000, ниже — журнал uc_log до 0x803648: 2488 Б). На нём одновременно может
оказаться: цепочка главного цикла / фоновой задачи, кадр входа в L1 (пролог прерывания uc/start.S UC_ISR — 19 слов,
76 Б) и цепочка L1, затем кадр L2 и цепочка L2 (L2 вытесняет L1, вложенность L1 в L1 невозможна: вход снимает E1).
Печатает глубину каждого корня и худшую сумму. Не учтено: функции на ассемблере (кроме пролога ISR) и цели
косвенных вызовов — перечисляются отдельно, их надо добавить вручную (--indirect имя=цель,…).
"""
import glob
import os
import re
import sys

STACK_BYTES = 0x804000 - 0x803648      # uc/uc.ld: от конца uc_log до __stack_top
ISR_FRAME = 19 * 4                      # uc/start.S UC_ISR: r12, r59, r57, r0..r11, lp_count, lp_start, lp_end, blink
ROOTS_MAIN = ('uc_main', 'background_task_dispatch')
ROOT_L1 = 'l1_task_entry'
ROOT_L2 = 'l2_task_entry'

# Хвостовые переходы (b, не bl) — граф GCC их не отличает от вызовов. Такое ребро стек не растит: глубина цели уже
# учтена от её прежнего входа. Без исключения цикл «переход заново» выглядит рекурсией. Каждое ребро проверяет
# tests/unit/test_uc_stack_budget.py::test_tail_jumps_are_jumps по дизассемблеру.
TAIL_JUMPS = {('mac_switch_rx_to_tx_again', 'mac_switch_rx_to_tx')}

NODE = re.compile(r'node: \{ title: "([^"]+)" label: "([^"]*)"')
EDGE = re.compile(r'edge: \{ sourcename: "([^"]+)" targetname: "([^"]+)"')
SIZE = re.compile(r'\\n(\d+) bytes \((static|dynamic[^)]*)\)')


def load(d):
    size, dyn, edges = {}, set(), {}
    for f in glob.glob(os.path.join(d, '**', '*.ci'), recursive=True):
        for line in open(f):
            m = NODE.search(line)
            if m:
                s = SIZE.search(m.group(2))
                if s:
                    size[m.group(1)] = int(s.group(1))
                    if s.group(2) != 'static':
                        dyn.add(m.group(1))
                continue
            m = EDGE.search(line)
            if m and (m.group(1), m.group(2)) not in TAIL_JUMPS:
                edges.setdefault(m.group(1), set()).add(m.group(2))
    return size, dyn, edges


def depth(fn, size, edges, memo, stack, unknown, indirect):
    """Худшая глубина от fn (байты) и цепочка; рекурсия — ошибка."""
    if fn in memo:
        return memo[fn]
    if fn in stack:
        raise SystemExit('рекурсия: %s' % ' → '.join(stack + [fn]))
    if fn not in size:
        if fn.startswith('__indirect_call'):
            indirect.add(stack[-1] if stack else fn)
        else:
            unknown.add(fn)
        memo[fn] = (0, [fn])
        return memo[fn]
    best = (0, [])
    for t in edges.get(fn, ()):
        d, ch = depth(t, size, edges, memo, stack + [fn], unknown, indirect)
        if d > best[0]:
            best = (d, ch)
    memo[fn] = (size[fn] + best[0], [fn] + best[1])
    return memo[fn]


def main():
    a = sys.argv[1:]
    if not a:
        print(__doc__)
        return 2
    size, dyn, edges = load(a[0])
    for spec in a[a.index('--indirect') + 1].split(',') if '--indirect' in a else []:
        src, dst = spec.split('=')
        edges.setdefault(src, set()).add(dst)
    memo, unknown, indirect = {}, set(), set()
    res = {}
    for r in ROOTS_MAIN + (ROOT_L1, ROOT_L2):
        if r in size:
            res[r] = depth(r, size, edges, memo, [], unknown, indirect)
    for r, (d, ch) in res.items():
        print('%-26s %4d Б: %s' % (r, d, ' → '.join('%s(%d)' % (f, size.get(f, 0)) for f in ch)))
    main_d = max(res[r][0] for r in ROOTS_MAIN if r in res)
    l1 = res.get(ROOT_L1, (0,))[0] + ISR_FRAME
    l2 = res.get(ROOT_L2, (0,))[0] + ISR_FRAME
    total = main_d + l1 + l2
    print('худший случай: главный/фон %d + L1 (с кадром ISR %d) %d + L2 %d = %d Б из %d (запас %d)'
          % (main_d, ISR_FRAME, l1, l2, total, STACK_BYTES, STACK_BYTES - total))
    if dyn:
        print('динамический кадр (alloca/VLA):', ', '.join(sorted(dyn)))
    if indirect:
        print('косвенные вызовы (цели не учтены):', ', '.join(sorted(indirect)))
    asm = sorted(u for u in unknown if not u.startswith('__builtin'))
    if asm:
        print('без размера кадра (ассемблер/внешние, 0 Б):', ', '.join(asm))
    return 0 if total <= STACK_BYTES else 1


if __name__ == '__main__':
    sys.exit(main())
