# SPDX-License-Identifier: AGPL-3.0-or-later
"""dut — станция у точки peer (версии и подключение — test_boot): данные, пропускная способность, журнал fw."""
import re
import pytest

from stand import long_verdict

pytestmark = [pytest.mark.stand, pytest.mark.sta]


def test_no_fw_error_after_connect(sta):
    assert sta.dut.fw_errors() == 0, re.findall(r'.*Firmware error.*', sta.dut.dmesg_new())


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
@pytest.mark.long
def test_throughput_long_up(sta):
    """Выгрузка станция → точка [test] iperf_long_s секунд (300): ни одного интервала (10 с) ниже
    iperf_long_min_frac × min_up_mbps, без потерь линка, разрывов и ошибок FW на обоих узлах (стенд 2026-11-08:
    короткие 8 с проходят, а наша станция → наша точка держит 4–36 Мбит/с с первых секунд)."""
    long_verdict(sta, False)


@pytest.mark.slow
@pytest.mark.long
def test_throughput_long_down(sta):
    """Загрузка точка → станция [test] iperf_long_s секунд: те же проверки, граница — min_down_mbps."""
    long_verdict(sta, True)


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


@pytest.mark.slow
def test_reconnect_after_peer_restart(sta):
    """Точка перезапускается — перезагрузкой устройства (docs/STAND.md: перезапуск драйвера и fw — только так):
    станция замечает разрыв и переподключается, когда точка снова в эфире (пропажа точки по питанию —
    test_sta_vanish.py)."""
    before = len(sta.disconnects())
    sta.restart_peer()           # reboot, ssh, FW точки и интерфейс AP (~1,5 мин), адрес и iperf3
    ok = sta._wait(sta.dut, 'iw dev %s link 2>/dev/null | grep Connected' % sta.dut.iface(), 120)
    reasons = sta.disconnects()[before:]
    assert reasons, 'разрыв не был замечен'
    if sta.ko:   # имена причин печатает драйвер SparRAW
        assert all(re.search(r'reason \[proto \d+ wmi \d+: [a-z]', r) for r in reasons), 'причина без имени: %s' % reasons
    assert ok, 'не переподключилась за 120 с после загрузки точки; причины: %s' % reasons
    assert sta.ping(5) >= 4
