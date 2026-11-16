# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сторож количества: весь tests/unit без фильтров должен собрать не меньше UNIT_MIN_TESTS тестов. Тихая потеря модулей
(пропущенный тулчейн, collect_ignore, ошибка импорта под условием) иначе выглядит как зелёный прогон. При удалении тестов —
опустить границу в том же коммите; при добавлении — можно поднять."""
import os
from conftest import HERE, unit_args

UNIT_MIN_TESTS = 1570   # 2026-11-16: собрано 1578


def test_unit_collected_count(request):
    import pytest
    cfg = request.config
    if not any(p == HERE and not node for p, node in unit_args(cfg)):
        pytest.skip('не весь tests/unit')
    if cfg.option.keyword or cfg.option.markexpr or cfg.getoption('deselect', None) or cfg.getoption('lf', False):
        pytest.skip('прогон с фильтром')
    n = sum(1 for it in request.session.items if str(it.fspath).startswith(HERE + os.sep))
    assert n >= UNIT_MIN_TESTS, 'tests/unit: собрано %d тестов, ожидалось не меньше %d' % (n, UNIT_MIN_TESTS)
