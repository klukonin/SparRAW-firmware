# SPDX-License-Identifier: AGPL-3.0-or-later
"""Первые стендовые тесты: узлы загрузились с нужной прошивкой и драйвером, станция подключилась.

При несовпадении здесь остальные стендовые тесты проверяют не тот образ или не тот модуль — их результат
ничего не говорит о проверяемой версии.
"""
import hashlib, re
import pytest

import stand as standlib

pytestmark = [pytest.mark.stand, pytest.mark.sta]


def md5(b):
    return hashlib.md5(b).hexdigest()


def node_md5(node, path):
    out = node.run('md5sum %s 2>/dev/null' % path, check=False).split()
    return out[0] if out else None


def ko_version(path):
    """Версия драйвера SparRAW из файла модуля (строка сообщения probe: «wil6210 SparRAW-<дата> device found»)."""
    m = re.search(rb'wil6210 (SparRAW-\d{4}\.\d\d\.\d\d)', open(path, 'rb').read())
    return m.group(1).decode() if m else None


def test_dut_firmware(sta_booted, fw_blob, check):
    d = sta_booted.dut
    check.equal(node_md5(d, '/lib/firmware/wil6210.fw'), md5(fw_blob), 'md5 /lib/firmware/wil6210.fw на dut')
    loaded = re.findall(r'FW ver\. (\S+?)\(', d.dmesg())
    check.is_true(loaded, 'в dmesg dut нет wmi_evt_ready (FW не загрузилась?)')
    if loaded:
        check.equal(loaded[-1], standlib.fw_version(fw_blob), 'версия загруженной FW на dut')
    check.is_true(d.fw_errors() == 0, 'ошибка FW при загрузке dut')


def test_dut_driver(sta_booted, check):
    d, ko = sta_booted.dut, sta_booted.ko
    probe = re.findall(r'wil6210 (SparRAW-\S+)? ?device found', d.dmesg())
    if not ko:
        pytest.skip('без --ko — драйвер из образа узла: %s' % ((probe[-1] if probe else '') or 'не SparRAW'))
    check.equal(node_md5(d, '/tmp/drv.ko'), md5(open(ko, 'rb').read()), 'md5 модуля на dut')
    check.is_true('wil6210' in d.run('lsmod', check=False), 'модуль wil6210 не загружен')
    want = ko_version(ko)
    check.is_true(want, '%s: нет версии SparRAW в модуле' % ko)
    if want:
        check.is_true(probe and probe[-1] == want, 'probe драйвера на dut: %r, ожидается %s' % (probe[-1:] or None, want))


def test_peer_firmware(sta_booted, check):
    """В роли станции peer — точка на своей (эталонной) прошивке fw_backup."""
    p, c = sta_booted.peer, sta_booted.cfg['peer']
    if c.get('fw_backup'):
        check.equal(node_md5(p, '/lib/firmware/wil6210.fw'), node_md5(p, c['fw_backup']),
                   'прошивка peer = %s' % c['fw_backup'])
    check.is_true('type AP' in p.run('iw dev', check=False), 'peer не в режиме точки')


def test_dut_connects(sta_booted):
    assert sta_booted.connected, 'dut не подключился к точке peer; разрывы: %s' % sta_booted.disconnects()[-3:]
