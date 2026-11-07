# SPDX-License-Identifier: AGPL-3.0-or-later
"""Общее для тестов ядра: сценарий + оба судьи. Мост эмулятора (unit/ref_bridge2) подключается здесь, в тестах, — ядро
его не импортирует (граница: test_core_boundary)."""
import os
import sys

import pytest

UNIT = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'unit')


@pytest.fixture(scope='session')
def RB():
    sys.path.insert(0, UNIT)
    try:
        import ref_bridge2
    finally:
        sys.path.remove(UNIT)
    return ref_bridge2


def judge_all(bss, RB):
    """→ (Ctx air_judge, [Rule], [нарушения air_judge], события моста, [находки моста])."""
    from .judge_run import air, air_violations, bridge
    from .scenario import AP_ADDR
    c, rules = air(bss.journal, AP_ADDR)
    evs, found = bridge(bss.journal, AP_ADDR, RB)
    return c, rules, air_violations(rules), evs, found


def fmt(c, va, evs, found, RB, n=10):
    out = [f'air_judge {v.rule} [{v.verdict}] {c.evs[v.idx].where() if v.idx >= 0 else "-"}: {v.msg}'
           for v in va[:n]]
    return '\n'.join(out) + '\n' + RB.report(evs, found, n)
