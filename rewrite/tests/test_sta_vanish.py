# SPDX-License-Identifier: AGPL-3.0-or-later
"""dut — станция на проверяемом образе, точка peer (vendor) пропадает без разъединения («sync; reboot -f», Node.vanish), в
простое и под трафиком. Станция замечает потерю линка, не падает и, когда точка снова в эфире, подключается заново и
держит линк — без «lost link» сразу после подключения и без «association timeout» по кругу."""
import time

import pytest

from stand import nodeboot     # tools/stand/nodeboot.py

pytestmark = [pytest.mark.stand, pytest.mark.slow]

HOLD_S = 30       # линк после возвращения держится не меньше (прежняя ошибка — «lost link: no beacons» через ~6 с)


def _peer_gone_and_back(sta, check, off_s, traffic):
    d = sta.dut
    d.run('echo Y > /sys/module/wil6210/parameters/no_fw_recovery', check=False)
    d.mark()
    if traffic:
        cl, srv = sta.client_server()
        d.run('(iperf3 -c %s -t 40 >/dev/null 2>&1 &)' % srv, check=False)
        time.sleep(5)
    old = sta.peer.vanish()             # стимул теста: reboot -f — точка пропадает без разъединения, питание не снимается
    time.sleep(off_s)
    nodeboot.wait_up(sta.peer, old, sta.peer.power_recover)
    sta._peer_restore_ap()              # peer поднялся без драйвера: загрузить точку командой, адрес, iperf3
    check.is_true(d.fw_errors() == 0, 'ошибка FW станции после пропажи точки')
    ok = sta._wait(d, 'iw dev %s link 2>/dev/null | grep Connected' % d.iface(), 120)
    log = d.dmesg_new()
    check.is_true(ok, 'станция не подключилась снова за 120 с:\n%s' % '\n'.join(sta.disconnects()[-6:]))
    if not ok:
        return
    d.run('ip addr add %s/24 dev %s 2>/dev/null' % (sta.cfg['dut']['ip'], d.iface()), check=False)
    n0 = len(sta.disconnects())
    time.sleep(HOLD_S)
    check.is_true(len(sta.disconnects()) == n0, 'разрыв после возвращения: %s' % sta.disconnects()[n0:])
    check.is_true(sta.ping(10) >= 9, 'ping после возвращения')
    check.is_true(d.fw_errors() == 0, 'ошибка FW станции')
    check.is_true('association timeout' not in log or log.count('association timeout') < 3,
                  'association timeout по кругу')


def test_peer_ap_vanishes_idle(sta, check):
    _peer_gone_and_back(sta, check, 15, traffic=False)


def test_peer_ap_vanishes_under_traffic(sta, check):
    _peer_gone_and_back(sta, check, 15, traffic=True)
