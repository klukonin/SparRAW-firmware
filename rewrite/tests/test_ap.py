# SPDX-License-Identifier: AGPL-3.0-or-later
"""dut — точка доступа (PCP/AP), peer — станция на том же образе: подключение, данные, останов точки."""
import re
import pytest

pytestmark = [pytest.mark.stand, pytest.mark.ap]


def test_ap_nodes_run_image(ap, fw_blob, check):
    """Обе стороны — на проверяемом образе (peer-станция vendor 6.2 к точке по стандарту не идёт)."""
    import hashlib
    want = hashlib.md5(fw_blob).hexdigest()
    for n in (ap.dut, ap.peer):
        got = n.run('md5sum /lib/firmware/wil6210.fw', check=False).split()[:1]
        check.equal(got[0] if got else None, want, 'md5 прошивки на %s' % n.name)
        ver = re.findall(r'FW ver\. (\S+?)\(', n.dmesg())    # последняя загрузка; dmesg_new() её может не содержать
        check.is_true(ver and ver[-1] == ap_version(fw_blob), 'версия FW на %s: %s' % (n.name, ver[-1:] or None))


def ap_version(blob):
    import stand as standlib
    return standlib.fw_version(blob)


def test_ap_station_associated(ap):
    out = ap.dut.run('iw dev %s station dump' % ap.dut.iface(), check=False)
    assert 'Station' in out


def test_ap_no_fw_error(ap, check):
    check.is_true(ap.dut.fw_errors() == 0, 'ошибка FW на dut (точка)')
    check.is_true(ap.peer.fw_errors() == 0, 'ошибка FW на peer (станция)')


def test_ap_ping(ap):
    got = ap.ping(15)
    assert got >= 14, 'ping %d/15' % got


@pytest.mark.slow
def test_ap_throughput(ap, check):
    up = ap.iperf(ap.t.get('iperf_s', 8))
    down = ap.iperf(ap.t.get('iperf_s', 8), reverse=True)
    check.is_true(up >= ap.t.get('min_up_mbps', 500), 'up %.0f Мбит/с' % up)
    check.is_true(down >= ap.t.get('min_down_mbps', 500), 'down %.0f Мбит/с' % down)


def test_ap_stop(ap):
    """Останов точки (PCP_STOP) без ошибки; дальше стенду нужна перезагрузка в любую роль."""
    ap.dut.run('wifi down radio0', check=False, timeout=60)
    import time; time.sleep(3)
    d = ap.dut.dmesg()
    ap.role = None
    assert not re.search(r'PCP_STOP failed|wmi_call\(.*PCP_STOP.*timeout', d), re.findall(r'.*PCP_STOP.*', d)
    assert ap.dut.fw_errors() == 0
