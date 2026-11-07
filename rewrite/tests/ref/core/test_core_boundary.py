# SPDX-License-Identifier: AGPL-3.0-or-later
"""Граница импорта: ядро (модули ref/core, кроме тестов) не импортирует ничего из tests/unit (эмулятор, модели
железа, мост) — только стандартную библиотеку, эталон ref/* и себя. Проверяется статически (AST) и динамически
(в отдельном процессе после импорта всех модулей ядра в sys.modules нет модулей tests/unit)."""
import ast
import os
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
TESTS = os.path.abspath(os.path.join(HERE, '..', '..'))
UNIT = os.path.join(TESTS, 'unit')
CORE = sorted(f[:-3] for f in os.listdir(HERE) if f.endswith('.py') and not f.startswith('test_') and
              f != 'conftest.py')
UNIT_MODS = sorted(f[:-3] for f in os.listdir(UNIT) if f.endswith('.py'))


def test_core_modules_listed():
    assert {'sap_phy', 'sap_mac', 'sap_mlme', 'offload', 'mac', 'ap', 'sta', 'medium_ideal', 'journal',
            'scenario', 'sme', 'judge_run', 'frames', 'sim'} <= set(CORE)


def test_static_imports():
    allowed_top = set(sys.stdlib_module_names)
    for m in CORE:
        tree = ast.parse(open(os.path.join(HERE, m + '.py')).read())
        for node in ast.walk(tree):
            if isinstance(node, ast.Import):
                for a in node.names:
                    top = a.name.split('.')[0]
                    assert top in allowed_top and top not in UNIT_MODS, (m, a.name)
            elif isinstance(node, ast.ImportFrom):
                if node.level == 0:
                    top = node.module.split('.')[0]
                    assert top in allowed_top and top not in UNIT_MODS, (m, node.module)
                else:
                    # относительный импорт: . — ядро, .. — ref; выше ref — запрещено
                    assert node.level <= 2, (m, node.module)
                    if node.level == 2 and node.module:
                        assert not node.module.startswith('unit'), (m, node.module)


def test_dynamic_no_unit_modules():
    code = ('import sys, importlib\n'
            f'mods = {CORE!r}\n'
            'for m in mods: importlib.import_module("ref.core." + m)\n'
            f'unit = {UNIT_MODS!r}\n'
            f'bad = [n for n, x in sys.modules.items() if n in unit or (getattr(x, "__file__", None) or "")'
            f'.startswith({UNIT!r})]\n'
            'print(bad); sys.exit(1 if bad else 0)\n')
    r = subprocess.run([sys.executable, '-c', code], cwd=TESTS, capture_output=True, text=True)
    assert r.returncode == 0, r.stdout + r.stderr
