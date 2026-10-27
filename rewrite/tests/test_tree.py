# SPDX-License-Identifier: AGPL-3.0-or-later
"""Проверки дерева исходников и сборки (нужен тулчейн ARC: ARC_DIR или arc-elf32-gcc в PATH)."""
import os, shutil, subprocess, sys
import pytest

import stand as standlib

pytestmark = pytest.mark.tree
R = standlib.REWRITE


@pytest.fixture(scope='module')
def toolchain():
    d = os.environ.get('ARC_DIR', os.path.join(R, '..', 'toolchain', 'arc_gnu_2021.03_prebuilt_elf32_le_linux_install'))
    b = os.path.join(d, 'bin')
    if os.path.exists(os.path.join(b, 'arc-elf32-gcc')):
        return os.path.abspath(d)
    if shutil.which('arc-elf32-gcc'):
        return os.path.dirname(os.path.dirname(shutil.which('arc-elf32-gcc')))
    pytest.skip('нет тулчейна ARC')


@pytest.fixture(scope='module')
def build(toolchain, tmp_path_factory):
    """Чистая сборка fw.elf и uc.elf из дерева во временный каталог."""
    out = tmp_path_factory.mktemp('build')
    env = dict(os.environ, PATH=os.path.join(toolchain, 'bin') + os.pathsep + os.environ['PATH'])
    r = subprocess.run(['make', '-C', R, 'ARC_DIR=' + toolchain, 'BUILD=' + str(out), '-j8',
                        str(out / 'fw.elf'), str(out / 'uc.elf')], capture_output=True, text=True, env=env)
    assert r.returncode == 0, r.stdout[-2000:] + r.stderr[-2000:]
    warn = [l for l in (r.stdout + r.stderr).splitlines() if 'warning:' in l]
    return out, env, warn


def test_build_without_warnings(build):
    _, _, warn = build
    assert not warn, warn[:10]


def test_fw_proto_up_to_date(build):
    _, env, _ = build
    r = subprocess.run([sys.executable, os.path.join(R, 'tools', 'gen_fw_proto.py'), '--check'],
                       capture_output=True, text=True, env=env, cwd=R)
    assert r.returncode == 0, 'fw/proto.h устарел: tools/gen_fw_proto.py\n' + r.stdout[-1000:] + r.stderr[-1000:]


def test_fwsh_layout(build, toolchain):
    out, env, _ = build
    r = subprocess.run([sys.executable, os.path.join(R, 'tools', 'check_fwsh.py'), str(out / 'fw.elf'),
                        os.path.join(toolchain, 'bin', 'arc-elf32-nm')], capture_output=True, text=True, env=env)
    assert r.returncode == 0, r.stdout[-1500:] + r.stderr[-1500:]


def test_image_from_tree(build, toolchain, tmp_path):
    """build_fw.py собирает образ из дерева, и он проходит статические проверки test_image."""
    out, env, _ = build
    img = tmp_path / 'tree.fw'
    r = subprocess.run([sys.executable, os.path.join(R, 'tools', 'build_fw.py'), '--elf', str(out / 'fw.elf'),
                        '--uc-elf', str(out / 'uc.elf'), '--vendor',
                        os.path.join(R, '..', 'images', 'openwrt', 'fw', 'wil6210_6.2.0.1000.fw'),
                        '--objcopy', os.path.join(toolchain, 'bin', 'arc-elf32-objcopy'), '--out', str(img)],
                       capture_output=True, text=True, env=env)
    assert r.returncode == 0, r.stdout[-1500:] + r.stderr[-1500:]
    r = subprocess.run([sys.executable, '-m', 'pytest', '-q', '-p', 'no:cacheprovider', '-m', 'image',
                        os.path.join(R, 'tests', 'test_image.py'), '--fw', str(img)], capture_output=True, text=True)
    assert r.returncode == 0, r.stdout[-2000:]
