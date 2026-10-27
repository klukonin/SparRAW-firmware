# SPDX-License-Identifier: AGPL-3.0-or-later
"""pytest: проверка образа прошивки — статически (без железа) и на стенде (tests/README.md).

  pytest tests --fw <образ.fw>                       # только статические проверки образа и дерева
  pytest tests --fw <образ.fw> --stand tests/stand.toml [--ko wil6210.ko] [-m 'not slow']
"""
import os, time
import pytest

import stand as standlib

HERE = os.path.dirname(os.path.abspath(__file__))


def pytest_addoption(parser):
    g = parser.getgroup('sparraw')
    g.addoption('--fw', help='проверяемый образ wil6210 .fw')
    g.addoption('--stand', default=os.environ.get('SPARRAW_STAND'),
                help='TOML-описание стенда (tests/stand.example.toml); без него стендовые тесты пропускаются')
    g.addoption('--ko', help='модуль драйвера wil6210.ko для dut (иначе — драйвер из образа узла)')
    g.addoption('--peer-fw', help='образ станции peer в тесте AP (по умолчанию — проверяемый)')
    g.addoption('--artifacts', default='test-artifacts', help='каталог журналов упавших стендовых тестов')


def pytest_configure(config):
    for m in ('image: статическая проверка образа', 'tree: проверка дерева исходников (нужен тулчейн ARC)',
              'stand: нужен стенд', 'sta: dut — станция', 'ap: dut — точка доступа',
              'pro: только образ SparRAW-PRO', 'slow: долгий (iperf, серии)',
              'known_issue: известная открытая проблема (ожидаемо может падать)'):
        config.addinivalue_line('markers', m)


@pytest.fixture(scope='session')
def fw_path(request):
    p = request.config.getoption('--fw')
    if not p:
        pytest.skip('нет --fw')
    return os.path.abspath(p)


@pytest.fixture(scope='session')
def fw_blob(fw_path):
    return open(fw_path, 'rb').read()


@pytest.fixture(scope='session')
def stand(request, fw_path):
    cfg_path = request.config.getoption('--stand')
    if not cfg_path:
        pytest.skip('нет --stand')
    import tomllib
    cfg = tomllib.load(open(cfg_path, 'rb'))
    s = standlib.Stand(cfg, fw_path, request.config.getoption('--ko'), request.config.getoption('--peer-fw'))
    request.session.__dict__['_sparraw_stand'] = s
    yield s
    s.teardown()


@pytest.fixture
def sta(stand):
    """Стенд в роли «dut — станция», связь установлена."""
    if not stand.ensure('sta'):
        pytest.fail('dut не подключился к точке peer: %s' % stand.disconnects()[-3:])
    return stand


@pytest.fixture
def ap(stand):
    """Стенд в роли «dut — точка, peer — станция на том же образе», станция подключена."""
    if not stand.ensure('ap'):
        pytest.fail('станция peer не подключилась к точке dut')
    return stand


@pytest.fixture
def pro(fw_blob):
    if not standlib.fw_is_pro(fw_blob):
        pytest.skip('образ не SparRAW-PRO')


@pytest.hookimpl(hookwrapper=True)
def pytest_runtest_makereport(item, call):
    """Упавший стендовый тест: dmesg и журнал fw обоих узлов — в --artifacts/<тест>/."""
    out = yield
    rep = out.get_result()
    if rep.when != 'call' or not rep.failed or 'stand' not in item.fixturenames:
        return
    s = item.funcargs.get('stand') or item.funcargs.get('sta') or item.funcargs.get('ap')
    if s is None:
        return
    d = os.path.join(item.config.getoption('--artifacts'), item.name.replace('/', '_'))
    os.makedirs(d, exist_ok=True)
    for node in (s.dut, s.peer):
        try:
            open(os.path.join(d, node.name + '.dmesg.txt'), 'w').write(node.dmesg())
            open(os.path.join(d, node.name + '.fw_peri.bin'), 'wb').write(node.blob('fw_peri'))
        except Exception as e:                     # узел мог не ответить — журналы остальных всё равно сохранить
            open(os.path.join(d, node.name + '.error.txt'), 'w').write(repr(e))
    try:
        open(os.path.join(d, 'dut.fwlog.txt'), 'w').write('\n'.join(s.dut.fw_log(s.fw_path)))
    except Exception:
        pass


ORDER = ['test_image', 'test_sta', 'test_ftm', 'test_sta_robust', 'test_ap']


def pytest_collection_modifyitems(config, items):
    """Порядок: статические → станция → FTM → неверные команды → точка доступа (смена роли — перезагрузка;
    известные проблемы — в конце своей группы, чтобы их последствия не задели остальные тесты)."""
    def key(it):
        mod = it.module.__name__.rsplit('.', 1)[-1]
        return (ORDER.index(mod) if mod in ORDER else len(ORDER), 'known_issue' in it.keywords)
    items.sort(key=key)
    for it in items:
        if 'known_issue' in it.keywords:
            it.add_marker(pytest.mark.xfail(reason='известная открытая проблема', strict=False))


_STAND = []


@pytest.fixture(scope='session', autouse=True)
def _remember_stand(request):
    yield
    s = request.session.__dict__.get('_sparraw_stand')
    if s:
        _STAND.append(s)


def pytest_terminal_summary(terminalreporter):
    """Сводка самовосстановления: узел переставал отвечать и был перезагружен по питанию."""
    for s in _STAND:
        rec = ['%s ×%d' % (n.name, n.recoveries) for n in (s.dut, s.peer) if n.recoveries]
        if rec:
            terminalreporter.write_line('стенд: перезагрузка по питанию (узел не отвечал): ' + ', '.join(rec),
                                        yellow=True)
