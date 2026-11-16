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


def unit_args(config):
    """Аргументы прогона, указывающие внутрь tests/unit (явный запрос юнит-тестов): [(путь, есть ли '::')]."""
    out = []
    for a in config.args:
        p = os.path.abspath(os.path.join(str(config.invocation_params.dir), a.split('::')[0]))
        if p == HERE or p.startswith(HERE + os.sep):
            out.append((p, '::' in a))
    return out


def pytest_configure(config):
    # Сторож: tests/unit запрошен явно, а тулчейна нет — без этого тесты эмуляции молча не собираются и прогон «зелёный»
    # на одном tests/ref (2026-11-16: 1585 вместо ~3150 в рабочей копии дерева без ARC_DIR). Общий прогон tests/ (стенд)
    # без тулчейна по-прежнему идёт без юнит-тестов.
    if not _TC and unit_args(config):
        raise pytest.UsageError('tests/unit запрошен, но тулчейн ARC не найден — тесты эмуляции не соберутся; '
                                'задайте ARC_DIR (…/toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install)')
    config.addinivalue_line('markers', 'unit: юнит-тест без стенда (эмулятор ARC / хостовый gcc)')
    # Параллельный прогон: pytest -n 8 --dist loadgroup — тесты с общим дорогим кэшем/фикстурой в одной группе
    config.addinivalue_line('markers', 'xdist_group(name): группа тестов на один воркер pytest-xdist (loadgroup)')


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
    """Свежий эмулятор uc: код из uc.elf, DCCM — uc_data образа (или 0 + .ucdata без vendor-образа). Расписание DTI в
    общем с fw блоке — «нет расписания», как после crt0 нашего fw (fw/start.S обнуляет 0x857000..0x857a00 и
    0x857f80..0x857f8c): флаг станции fwsh_diag.ese_dti_sched, заголовок ese_slot_tbl, ese_own_tbl, fwsh_sp_gate,
    fwsh_uc_wait (include/fwsh.h tests/unit/fwsh_addr.py; прочее — мусор эмулятора, как прежде)."""
    import ucemu
    from fwsh_addr import A, SP_GATE_SIZE
    u = ucemu.UC(os.path.join(build_dir, 'uc.elf'), uc_fw)
    u.cpu.write(0x857028, bytes(1))                          # fwsh_diag.ese_dti_sched
    u.cpu.write(0x857264, bytes(4))                          # ese_slot_tbl: mode, count, uc
    u.cpu.write(A['ese_own_tbl'], bytes(A['fwsh_sp_gate'] + SP_GATE_SIZE - A['ese_own_tbl']))   # ese_own_tbl, fwsh_sp_gate
    u.cpu.write(A['fwsh_uc_wait'], bytes(0xc))               # fwsh_uc_wait (верхний диапазон crt0)
    return u


@pytest.fixture
def fw_factory(fw_elf):
    """Фабрика независимых эмуляторов fw (несколько узлов в одном тесте, air.Air)."""
    import fwemu
    return lambda: fwemu.FW(fw_elf).boot()


@pytest.fixture
def uc_factory(build_dir, uc_fw):
    """Фабрика независимых эмуляторов uc."""
    import ucemu
    return lambda: ucemu.UC(os.path.join(build_dir, 'uc.elf'), uc_fw)


UC_DEFER_LATE_MARK = 0x80e500ff       # uc/rx.c rx_post_late: отложенная работа после пуска не до приёма


@pytest.fixture(autouse=True)
def uc_order_guard():
    """Сторож порядка uc во всех тестах эмуляции: работа после пуска, отложенная за него (rx_post_run: буфер
    приёма 0x32), должна быть сделана до следующего приёма — иначе uc ставит метку 0x80e500ff (rx_post_late) и
    доделывает её на входе rx_flow_run. Метка в журнале команд любого узла — ошибка порядка (2026-11-15: запрос итога с
    приёмом ответного CF-End, test_fw_sls_collision ловил только косвенно)."""
    seen = {id(n): len(getattr(n, 'hw', None).cmd_log) if getattr(n, 'hw', None) else 0 for n in list(_cosim_live())}
    yield
    bad = []
    for n in list(_cosim_live()):
        hw = getattr(n, 'hw', None)
        if hw is None:
            continue
        for t, v in hw.cmd_log[seen.get(id(n), 0):]:
            if v == UC_DEFER_LATE_MARK:
                bad.append(t)
    assert not bad, 'uc: отложенная работа после пуска не сделана до приёма (rx_post_late) на тактах %s' % bad[:8]


def _cosim_live():
    m = sys.modules.get('cosim')
    return m.CoSim.instances if m is not None else ()
