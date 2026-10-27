# SPDX-License-Identifier: AGPL-3.0-or-later
"""dut — точка доступа (PCP/AP), peer — станция на том же образе: подключение, данные, останов точки."""
import re
import pytest

pytestmark = [pytest.mark.stand, pytest.mark.ap]


def test_ap_station_associated(ap):
    out = ap.dut.run('iw dev %s station dump' % ap.dut.iface(), check=False)
    assert 'Station' in out


def test_ap_no_fw_error(ap):
    assert ap.dut.fw_errors() == 0
    assert ap.peer.fw_errors() == 0


def test_ap_ping(ap):
    got = ap.ping(15)
    assert got >= 14, 'ping %d/15' % got


@pytest.mark.slow
def test_ap_throughput(ap):
    up = ap.iperf(ap.t.get('iperf_s', 8))
    down = ap.iperf(ap.t.get('iperf_s', 8), reverse=True)
    assert up >= ap.t.get('min_up_mbps', 500) and down >= ap.t.get('min_down_mbps', 500), \
        'up %.0f down %.0f Мбит/с' % (up, down)


def test_ap_stop(ap):
    """Останов точки (PCP_STOP) без ошибки; дальше стенду нужна перезагрузка в любую роль."""
    ap.dut.run('wifi down radio0', check=False, timeout=60)
    import time; time.sleep(3)
    d = ap.dut.dmesg()
    ap.role = None
    assert not re.search(r'PCP_STOP failed|wmi_call\(.*PCP_STOP.*timeout', d), re.findall(r'.*PCP_STOP.*', d)
    assert ap.dut.fw_errors() == 0
