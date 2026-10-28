# SPDX-License-Identifier: AGPL-3.0-or-later
"""dut — точка на проверяемом образе, станция peer пропадает без разъединения (выключение по питанию) в разные
моменты. Точка не падает, продолжает работать (WMI, маяки — станция снова находит сеть), станция входит снова:
пока точка её ещё считает ассоциированной — переассоциацией на месте (тот же cid, без Disassociation), после срока
обнаружения — заново. Разбор в эмуляторе — tests/unit/test_fw_peer_vanish.py, test_fw_reassoc.py."""
import re
import time

import pytest

pytestmark = [pytest.mark.stand, pytest.mark.ap, pytest.mark.slow]

# Точка замечает пропавшую станцию: keep-alive через 1 с простоя + старение очереди 5 с + остановка кольца (набор
# поддержания 0, fw/l2mgr.c; test_fw_peer_vanish.ap_bound_us) ≈ 6,5 с; станция выключена дольше с запасом.
AP_DETECT_S = 30


def _no_recovery(node):
    """FW error не восстанавливать: в артефакты упавшего теста попадёт состояние fw на момент сбоя."""
    node.run('echo Y > /sys/module/wil6210/parameters/no_fw_recovery', check=False)


def _sta_mac(ap):
    p = ap.peer
    return p.run('cat /sys/class/net/%s/address' % p.iface(), check=False).strip()


def _peer_sta_up(ap, mac):
    """peer после включения: станция с прежним MAC (иначе это новая станция, а не возвращение) на SSID точки (uci
    без commit, как Stand.boot_ap), адрес для ping."""
    p = ap.peer
    p.wait_alive()
    _no_recovery(p)
    ssid = ap.t.get('ap_ssid', 'SPARRAW-TEST')
    p.run('killall iperf3 2>/dev/null; wifi down; sleep 2; uci set wireless.default_radio0.mode=sta; '
          'uci delete wireless.default_radio0.network; uci set wireless.default_radio0.ssid=%s; '
          'uci set wireless.default_radio0.macaddr=%s; ip addr del %s/24 dev br-lan; wifi up radio0'
          % (ssid, mac, ap.cfg['peer']['ip']), check=False, timeout=60)


def _peer_linked(ap, timeout):
    p = ap.peer
    t0 = time.time()
    while time.time() - t0 < timeout:
        i = p.iface()
        if i and 'Connected' in p.run('iw dev %s link' % i, check=False):
            p.run('sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2; '
                  'ip addr add %s/24 dev %s 2>/dev/null; nft insert rule inet fw4 input iifname %s accept; '
                  'ip neigh flush dev %s' % (ap.cfg['peer']['ip'], i, i, i), check=False)
            return True
        time.sleep(3)
    return False


def _ap_alive(ap, check):
    """Точка жива: нет ошибки FW, WMI отвечает (debugfs читает журнал fw — mbox), интерфейс AP на месте."""
    d = ap.dut
    check.is_true(d.fw_errors() == 0, 'ошибка FW на точке')
    check.is_true('type AP' in d.run('iw dev', check=False), 'точка остановлена')
    check.is_true(not re.search(r'wmi_call.*timeout|WMI ring full', d.dmesg_new()), 'WMI точки не отвечает')


def _vanish_and_return(ap, check, off_s, during=None):
    d = ap.dut
    _no_recovery(d)
    mac = _sta_mac(ap)
    d.mark()
    ap.peer.mark()
    if during:
        during(ap)
    ap.peer.power_cycle(off_s)                  # без разъединения: станция просто пропадает
    ap.peer_dirty = True
    time.sleep(10)
    _ap_alive(ap, check)
    _peer_sta_up(ap, mac)
    check.is_true(_peer_linked(ap, 150), 'станция не вошла снова')
    check.is_true(ap.peer.fw_errors() == 0, 'ошибка FW на станции')
    _ap_alive(ap, check)
    got = ap.ping(10)
    check.is_true(got >= 9, 'ping после возвращения %d/10' % got)
    return d.dmesg_new()


def test_station_vanishes_idle_and_returns(ap, check):
    """Станция пропала в простое и вернулась раньше срока обнаружения: вход переассоциацией на месте (драйвер:
    «reassociated in place»), без «Invalid status» и без Disassociation-разрыва."""
    log = _vanish_and_return(ap, check, 15)
    check.is_true('reassociated in place' in log or 'successful connection' in log, 'нет входа станции:\n%s' % log[-800:])
    check.is_true('Invalid status' not in log, 'драйвер: Invalid status — CONNECT занятого cid без переассоциации')


def test_station_vanishes_under_traffic_and_returns(ap, check):
    """Пропала во время передачи к ней (iperf точка → станция): точка не падает, кольцо станции не вешает fw."""
    def traffic(ap):
        ap.peer.run('(iperf3 -c %s -t 60 -R >/dev/null 2>&1 &)' % ap.cfg['dut']['ip'], check=False)
        time.sleep(5)
    log = _vanish_and_return(ap, check, 15, during=traffic)
    check.is_true('Invalid status' not in log)


def test_station_gone_longer_than_detection(ap, check):
    """Станция выключена дольше срока обнаружения: точка снимает её сама (WMI_DISCONNECT_EVENT), затем станция
    входит заново."""
    d = ap.dut
    _no_recovery(d)
    mac = _sta_mac(ap)
    d.mark()
    ap.peer.mark()
    ap.peer.power_cycle(AP_DETECT_S)
    ap.peer_dirty = True
    log = d.dmesg_new()
    check.is_true(re.search(r'wmi_evt_disconnect: Disconnect', log) is not None,
                  'точка не сняла пропавшую станцию за %d с' % AP_DETECT_S)
    check.is_true('Station' not in d.run('iw dev %s station dump' % d.iface(), check=False) or
                  'successful connection' in log, 'станция ещё числится у точки')
    _ap_alive(ap, check)
    _peer_sta_up(ap, mac)
    check.is_true(_peer_linked(ap, 150), 'станция не вошла снова')
    check.is_true(ap.peer.fw_errors() == 0, 'ошибка FW на станции')
    _ap_alive(ap, check)
