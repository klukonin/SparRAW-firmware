# SPDX-License-Identifier: AGPL-3.0-or-later
"""dut — точка доступа (PCP/AP), peer — станция на том же образе: подключение, данные, останов точки."""
import re
import pytest

from stand import nodeboot     # tools/stand/nodeboot.py
from stand import long_verdict

pytestmark = [pytest.mark.stand, pytest.mark.ap]


def test_ap_nodes_run_image(ap, fw_blob, check):
    """Обе стороны — на проверяемом образе (peer-станция vendor 6.2 к точке по стандарту не идёт)."""
    import hashlib
    want = hashlib.md5(fw_blob).hexdigest()
    for n in (ap.dut, ap.peer):
        got = n.run('md5sum %s' % nodeboot.FW_TMP, check=False).split()[:1]
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


@pytest.mark.slow
@pytest.mark.long
def test_throughput_long_up(ap):
    """Выгрузка станция peer → точка dut [test] iperf_long_s секунд (300), интервалы 10 с: ни одного ниже
    iperf_long_min_frac × min_up_mbps, без потерь линка, разрывов и ошибок FW (стенд 2026-11-08: наша станция → наша
    точка — 4–36 Мбит/с с первых секунд, «lost link: TX stalled» у станции; короткий test_ap_throughput проходил)."""
    long_verdict(ap, False)


@pytest.mark.slow
@pytest.mark.long
def test_throughput_long_down(ap):
    """Загрузка точка dut → станция peer [test] iperf_long_s секунд: те же проверки, граница — min_down_mbps."""
    long_verdict(ap, True)


def test_ap_stop(ap):
    """Останов точки (PCP_STOP) без ошибки. wifi down здесь — сам предмет проверки, не перезапуск: обратно радио не
    поднимается, следующая загрузка роли перезагружает узел (docs/STAND.md)."""
    ap.dut.run('wifi down radio0', check=False, timeout=60, allow_wifi_down=True)
    import time; time.sleep(3)
    d = ap.dut.dmesg()
    ap.role = None
    assert not re.search(r'PCP_STOP failed|wmi_call\(.*PCP_STOP.*timeout', d), re.findall(r'.*PCP_STOP.*', d)
    assert ap.dut.fw_errors() == 0
