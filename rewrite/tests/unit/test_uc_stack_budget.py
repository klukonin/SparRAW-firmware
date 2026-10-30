# SPDX-License-Identifier: AGPL-3.0-or-later
"""Статический бюджет стека uc (tools/arcemu/stack_budget.py): граф вызовов GCC с размерами кадров.

Стек uc — 2488 Б (0x803648..0x804000, ниже — журнал uc_log; до 2026-10-28 вершина была 0x803a48, 1 КБ). Худший
случай сейчас: главный цикл спит в background_task_dispatch (фоновые задачи идут с запрещёнными L1), поверх — цепочка L1
с кадром входа в прерывание, поверх — L2. Вылазки L1 из фоновых задач (план планировщика по запасу) кладут под L1 ещё и
цепочку фоновой задачи — тест держит запас и для этого случая. Правка, удлинившая самую глубокую цепочку или добавившая
крупный локальный массив, падает здесь, а не порчей журнала uc на железе."""
import os
import subprocess
import sys

import pytest

R = os.path.normpath(os.path.join(os.path.dirname(__file__), '..', '..'))
sys.path.insert(0, os.path.join(R, 'tools', 'arcemu'))
import stack_budget as sb                                    # noqa: E402

IDLE_MAIN = ('uc_main', 'boot_uc_init_and_run', 'boot_uc_init_tail', 'background_task_dispatch')
MARGIN = 128                                                 # запас на функции на ассемблере и косвенные вызовы


@pytest.fixture(scope='module')
def stack_build(toolchain, tmp_path_factory):
    out = tmp_path_factory.mktemp('stackbuild')
    env = dict(os.environ, PATH=os.path.join(toolchain, 'bin') + os.pathsep + os.environ['PATH'])
    r = subprocess.run(['make', '-C', R, 'ARC_DIR=' + toolchain, 'BUILD=' + str(out), '-j8',
                        'UC_DBG=-fstack-usage -fcallgraph-info=su', str(out / 'uc.elf')],
                       capture_output=True, text=True, env=env)
    assert r.returncode == 0, r.stdout[-2000:] + r.stderr[-2000:]
    return out


@pytest.fixture(scope='module')
def graph(stack_build):
    return sb.load(str(stack_build))


def test_tail_jumps_are_jumps(stack_build, toolchain):
    """Рёбра sb.TAIL_JUMPS (исключены из графа) — в коде переходы b, без bl: стек не растёт."""
    od = os.path.join(toolchain, 'bin', 'arc-elf32-objdump')
    dis = subprocess.run([od, '-d', '--no-show-raw-insn', str(stack_build / 'uc.elf')], capture_output=True,
                         text=True).stdout
    for src, dst in sorted(sb.TAIL_JUMPS):
        body = dis.split('<%s>:\n' % src, 1)[1].split('\n\n', 1)[0]
        to_dst = [ln for ln in body.splitlines() if ln.rstrip().endswith('<%s>' % dst)]
        assert to_dst, '%s не переходит в %s' % (src, dst)
        assert all('\tb\t' in ln or '\tb.d\t' in ln for ln in to_dst), to_dst


def test_uc_stack_fits(graph):
    size, dyn, edges = graph
    assert not dyn, 'кадр переменного размера (alloca/VLA): %s' % sorted(dyn)
    memo = {}
    l1, ch1 = sb.depth(sb.ROOT_L1, size, edges, memo, [], set(), set())
    l2, _ = sb.depth(sb.ROOT_L2, size, edges, memo, [], set(), set())
    bg, _ = sb.depth('background_task_dispatch', size, edges, memo, [], set(), set())
    idle = sum(size.get(f, 0) for f in IDLE_MAIN)
    now = idle + l1 + sb.ISR_FRAME + l2 + sb.ISR_FRAME
    with_excursion = bg + (idle - size.get('background_task_dispatch', 0)) + l1 + sb.ISR_FRAME + l2 + sb.ISR_FRAME
    print('стек: сейчас %d Б из %d (главный цикл %d + L1 %d + L2 %d + 2 кадра ISR); с вылазкой L1 из фоновой задачи '
          '%d Б; цепочка L1: %s' % (now, sb.STACK_BYTES, idle, l1, l2, with_excursion, ' → '.join(ch1)))
    assert now + MARGIN <= sb.STACK_BYTES
    assert with_excursion + MARGIN <= sb.STACK_BYTES
