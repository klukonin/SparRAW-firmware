# SPDX-License-Identifier: AGPL-3.0-or-later
"""Юнит-тесты uc/fw без стенда (tests/unit/README.md): одна сборка uc.elf на сессию, эмулятор ARC на тест."""
import os, shutil, subprocess, sys
import pytest

HERE = os.path.dirname(os.path.abspath(__file__))
R = os.path.dirname(os.path.dirname(HERE))
sys.path.insert(0, HERE)


def _toolchain():
    d = os.environ.get('ARC_DIR', os.path.join(R, '..', 'toolchain', 'arc_gnu_2021.03_prebuilt_elf32_le_linux_install'))
    if os.path.exists(os.path.join(d, 'bin', 'arc-elf32-gcc')):
        return os.path.abspath(d)
    if shutil.which('arc-elf32-gcc'):
        return os.path.dirname(os.path.dirname(shutil.which('arc-elf32-gcc')))
    return None


# Тулчейн нужен уже при импорте модулей (tools/arcemu/cpu.py ищет objdump): найден — ARC_DIR для них; нет — юнит-тесты
# не собираются (без падения всего прогона, например стендового).
_TC = _toolchain()
if _TC:
    os.environ['ARC_DIR'] = _TC
    collect_ignore_glob = []
else:
    collect_ignore_glob = ['test_*.py']


def pytest_configure(config):
    config.addinivalue_line('markers', 'unit: юнит-тест без стенда (эмулятор ARC / хостовый gcc)')


def pytest_collection_modifyitems(config, items):
    for it in items:
        if str(it.fspath).startswith(HERE):
            it.add_marker(pytest.mark.unit)


@pytest.fixture(scope='session')
def toolchain():
    d = _toolchain()
    if not d:
        pytest.skip('нет тулчейна ARC (ARC_DIR)')
    os.environ['ARC_DIR'] = d                     # tools/arcemu/cpu.py берёт objdump отсюда
    return d


@pytest.fixture(scope='session')
def build_dir(toolchain, tmp_path_factory):
    """uc.elf и fw.elf из текущего дерева (SPARRAW_UNIT_BUILD — готовый каталог сборки, без пересборки)."""
    pre = os.environ.get('SPARRAW_UNIT_BUILD')
    if pre:
        return pre
    out = tmp_path_factory.mktemp('unitbuild')
    env = dict(os.environ, PATH=os.path.join(toolchain, 'bin') + os.pathsep + os.environ['PATH'])
    r = subprocess.run(['make', '-C', R, 'ARC_DIR=' + toolchain, 'BUILD=' + str(out), '-j8',
                        str(out / 'uc.elf')], capture_output=True, text=True, env=env)
    assert r.returncode == 0, r.stdout[-2000:] + r.stderr[-2000:]
    return str(out)


VENDOR_FW = os.path.join(R, '..', 'images', 'openwrt', 'fw', 'wil6210_6.2.0.1000.fw')


@pytest.fixture(scope='session')
def uc_fw(build_dir, toolchain, tmp_path_factory):
    """Образ vendor fw + наш uc (build_fw.py --uc-elf): из него — начальная DCCM (uc_data), как на железе."""
    if not os.path.exists(VENDOR_FW):
        return None
    out = str(tmp_path_factory.mktemp('unitfw') / 'uc.fw')
    r = subprocess.run([sys.executable, os.path.join(R, 'tools', 'build_fw.py'), '--uc-elf',
                        os.path.join(build_dir, 'uc.elf'), '--vendor', VENDOR_FW, '--out', out,
                        '--objcopy', os.path.join(toolchain, 'bin', 'arc-elf32-objcopy')],
                       capture_output=True, text=True)
    assert r.returncode == 0, r.stdout[-2000:] + r.stderr[-2000:]
    return out


@pytest.fixture(scope='session')
def fw_elf(build_dir, toolchain):
    """fw.elf главного ядра: из каталога сборки; нет — собрать туда же (make <BUILD>/fw.elf)."""
    elf = os.path.join(build_dir, 'fw.elf')
    if not os.path.exists(elf):
        env = dict(os.environ, PATH=os.path.join(toolchain, 'bin') + os.pathsep + os.environ['PATH'])
        r = subprocess.run(['make', '-C', R, 'ARC_DIR=' + toolchain, 'BUILD=' + build_dir, '-j8', elf],
                           capture_output=True, text=True, env=env)
        assert r.returncode == 0, r.stdout[-2000:] + r.stderr[-2000:]
    return elf


@pytest.fixture
def fw(fw_elf):
    """Свежий эмулятор fw после загрузки (tests/unit/fwemu.py FW.boot): конструкторы, fw_main, LMAC READY от uc
    (WMI_READY хосту), драйвер поднял интерфейс (WMI_CFG_RX_CHAIN). Снимок загрузки кэшируется на сессию."""
    import fwemu
    return fwemu.FW(fw_elf).boot()


@pytest.fixture
def uc(build_dir, uc_fw):
    """Свежий эмулятор uc: код из uc.elf, DCCM — uc_data образа (или 0 + .ucdata без vendor-образа)."""
    import ucemu
    return ucemu.UC(os.path.join(build_dir, 'uc.elf'), uc_fw)
