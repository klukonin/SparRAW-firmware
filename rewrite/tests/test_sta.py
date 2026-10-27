# SPDX-License-Identifier: AGPL-3.0-or-later
"""dut — станция у точки peer: загрузка, подключение, данные, пропускная способность, журнал без фатальных ошибок."""
import re
import pytest

import stand as standlib

pytestmark = [pytest.mark.stand, pytest.mark.sta]


def test_fw_ready_with_image_version(sta, fw_blob):
    v = standlib.fw_version(fw_blob)
    m = re.findall(r'FW ver\. (\S+)\(', sta.dut.dmesg())
    assert m, 'нет wmi_evt_ready в dmesg'
    assert m[-1] == v, 'загружена прошивка %s, проверяется %s' % (m[-1], v)


def test_no_fw_error_after_connect(sta):
    assert sta.dut.fw_errors() == 0, re.findall(r'.*Firmware error.*', sta.dut.dmesg())


def test_ping(sta):
    got = sta.ping(15)
    assert got >= 14, 'ping %d/15' % got


@pytest.mark.slow
def test_throughput_up(sta):
    v = sta.iperf(sta.t.get('iperf_s', 8))
    assert v >= sta.t.get('min_up_mbps', 500), 'up %.0f Мбит/с' % v


@pytest.mark.slow
def test_throughput_down(sta):
    v = sta.iperf(sta.t.get('iperf_s', 8), reverse=True)
    assert v >= sta.t.get('min_down_mbps', 500), 'down %.0f Мбит/с' % v


@pytest.mark.slow
def test_no_disconnect_under_traffic(sta):
    """Связь держится под нагрузкой в обе стороны (детекторы потери линка не срабатывают)."""
    before = len(sta.disconnects())
    sta.iperf(sta.t.get('iperf_s', 8), reverse=True)
    sta.iperf(sta.t.get('iperf_s', 8))
    new = sta.disconnects()[before:]
    assert not new, new


def test_fw_log_has_no_fatal(sta, fw_path):
    log = sta.dut.fw_log(fw_path)
    assert log, 'журнал fw пуст (не читается blob_fw_peri?)'
    bad = [l for l in log if re.search(r'SYSTEM FATAL|sysassert|FATAL CRASH', l, re.I)]
    assert not bad, bad[:5]


def test_link_stats_sane(sta):
    """Станция видна точке как подключённая с ненулевым MCS (iw station dump на dut)."""
    out = sta.dut.run('iw dev %s station dump' % sta.dut.iface(), check=False)
    assert 'Station' in out, out
    m = re.search(r'tx bitrate:\s+([\d.]+)', out)
    assert m and float(m.group(1)) > 0, out


@pytest.mark.known_issue
@pytest.mark.slow
def test_reconnect_after_peer_restart(sta):
    """Точка перезапускает радио — станция переподключается; известная проблема: после потери линка станция может не переподключиться."""
    before = len(sta.disconnects())
    sta.peer.run('wifi down; sleep 3; wifi up', check=False, timeout=60)
    ok = sta._wait(sta.dut, 'iw dev %s link 2>/dev/null | grep Connected' % sta.dut.iface(), 90)
    reasons = sta.disconnects()[before:]
    assert reasons, 'разрыв не был замечен'
    if sta.ko:   # имена причин печатает драйвер SparRAW
        assert all(re.search(r'reason \[proto \d+ wmi \d+: [a-z]', r) for r in reasons), 'причина без имени: %s' % reasons
    assert ok, 'не переподключилась за 90 с; причины: %s' % reasons
    assert sta.ping(5) >= 4
