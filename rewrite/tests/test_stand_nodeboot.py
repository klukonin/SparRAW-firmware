# SPDX-License-Identifier: AGPL-3.0-or-later
"""Без стенда: подготовка узла (tools/stand/nodeboot.py) и загрузка ролей стенда (stand.Stand) на подставном узле.

Проверяется правило docs/STAND.md: смена прошивки, драйвера и роли — только перезагрузкой (uci commit, sync, reboot),
ни одной команды rmmod/insmod/wifi down/up; питание снимается только при неответе по ssh и не больше одного раза.
"""
import hashlib, re

import pytest

import stand as standlib
from stand import nodeboot

FORBIDDEN = re.compile(r'\b(rmmod|insmod|modprobe)\b|\bwifi\s+(down|up)\b|\bwifi\s*($|;)')
BACKUP = b'vendor-fw-backup'


def md5(b):
    return hashlib.md5(b).hexdigest()


def fw_blob(ver):
    """Минимальный образ .fw: запись 6 с комментарием «FW version: ver» (как в nodeboot.fw_version)."""
    c = (b'\0' * 20 + ('FW version: %s' % ver).encode()).ljust(52, b'\0')
    import struct
    return struct.pack('<HHI', 6, 0, len(c)) + c


class Clock:
    def __init__(self):
        self.t = 0.0

    def now(self):
        return self.t

    def sleep(self, s):
        self.t += s


class FakeNode:
    """Узел OpenWrt в памяти: файлы (md5), закоммиченная роль, загрузка по reboot (boot_id), проверки nodeboot.

    down_s — сколько узел грузится после reboot; dead — не возвращается никогда (ни после reboot, ни после
    питания); dead_until_power — не возвращается после reboot, оживает после снятия питания; hang_reboot — reboot
    не перезагружает (процесс в D), «reboot -f» — да."""

    def __init__(self, name, clock, role='ap', ssid='S', down_s=70, mac='02:00:00:00:00:01'):
        self.name, self.clock, self.down_s, self.mac = name, clock, down_s, mac
        self.cmds = []
        self.files = {nodeboot.FW: md5(b'old'), 'ko': md5(b'oldko'), '/lib/firmware/wil6210.fw.backup': md5(BACKUP),
                      nodeboot.BRD: 'e17714311e27' + '0' * 20}
        self.committed = {'mode': role, 'ssid': ssid, 'sig': ''}
        self.running = dict(self.committed, fw=self.files[nodeboot.FW])
        self.boot = 1
        self.up_at = 0
        self.dead = self.dead_until_power = self.hang_reboot = False
        self.power_cycles = 0
        self.fwerr = 0
        self.vers = {}               # md5 образа → версия (строка wmi_evt_ready)

    # --- состояние ---
    def is_up(self):
        return not self.dead and self.clock.now() >= self.up_at

    def _do_reboot(self):
        self.boot += 1
        self.up_at = self.clock.now() + self.down_s
        self.running = dict(self.committed, fw=self.files[nodeboot.FW])
        if self.dead_until_power:
            self.dead = True

    def power(self, why=''):
        self.power_cycles += 1
        if self.dead_until_power:
            self.dead = self.dead_until_power = False
        self._do_reboot()

    def ver(self):
        return self.vers.get(self.running['fw']) or 'v-' + self.running['fw'][:6]

    def iw(self):
        t = 'AP' if self.running['mode'] == 'ap' else 'managed'
        i = 'phy0-ap0' if t == 'AP' else 'phy0-sta0'
        return 'phy#0\n\tInterface %s\n\t\tifindex 9\n\t\taddr %s\n\t\ttype %s\n' % (i, self.mac, t)

    # --- ssh ---
    def sh(self, cmd, timeout, input=None):
        self.cmds.append(cmd)
        if not self.is_up():
            return None if self.dead else 255, b'', b'ssh: connect to host: No route'
        out = self._answer(cmd, input)
        return 0, out.encode(), b''

    def _answer(self, cmd, input):
        if cmd == nodeboot.BOOT_ID_CMD:
            return 'boot-%d\n' % self.boot
        if 'reboot -f' in cmd:
            self._do_reboot()
            return ''
        if re.search(r'\breboot$', cmd):
            if not self.hang_reboot:
                self._do_reboot()
            return ''
        if cmd.startswith('P=') and 'cat > "$P.new"' in cmd:          # put_cmd
            path = cmd.split(';')[0][2:]
            key = 'ko' if path == nodeboot.KO else path
            self.files[key] = md5(input)
            if key == nodeboot.FW:
                self.vers[md5(input)] = nodeboot.fw_version(input)
            return '%s  %s\n' % (self.files[key], path)
        if cmd.startswith('md5sum /lib/firmware/wil6210.fw.backup'):
            return '%s  x\n' % md5(BACKUP)
        if cmd.startswith('cp /lib/firmware/wil6210.fw.backup'):
            self.files[nodeboot.FW] = md5(BACKUP)
            return '%s  x\n' % md5(BACKUP)
        if 'echo PREPARED' in cmd:
            self.committed['mode'] = re.search(r'\.mode=(\w+)', cmd).group(1)
            self.committed['ssid'] = re.search(r'\.ssid=(\S+)', cmd).group(1).strip("'")
            self.committed['sig'] = re.search(r'echo (\w+) > /etc/sparraw-stand.sig', cmd).group(1)
            return 'PREPARED\n'
        if cmd == nodeboot.FW_READY_CMD:
            return '[ 20.0] wil6210 x: wmi_evt_ready: FW ver. %s(SW 1)\n' % self.ver()
        if cmd == 'iw dev':
            return self.iw()
        if cmd == nodeboot.LINK_CMD:
            return 'phy0-sta0\n' if self.running['mode'] == 'sta' else ''
        if cmd == nodeboot.FACTS_CMD:
            return ('ver=%s\nfwerr=%d\nprobe=\nfw=%s\nko=%s\nbrd=%s\nsig=%s\nmodconf=0\n' % (
                self.ver(), self.fwerr, self.running['fw'], self.files['ko'], self.files[nodeboot.BRD],
                self.running['sig'])) + self.iw()
        if cmd == 'dmesg':
            return '[   20.000000] wil6210 x: wmi_evt_ready: FW ver. %s(SW 1)\n' % self.ver()
        if 'station dump' in cmd:
            return 'Station 02:00:00:00:00:02 (on phy0-ap0)\n' if self.running['mode'] == 'ap' else ''
        if cmd.startswith('cat /sys/class/net/') and cmd.endswith('/address'):
            return self.mac + '\n'
        return ''

    def all_cmds(self):
        return '\n'.join(self.cmds)


@pytest.fixture
def clock(monkeypatch):
    c = Clock()
    monkeypatch.setattr(nodeboot, '_now', c.now)
    monkeypatch.setattr(nodeboot, '_sleep', c.sleep)
    monkeypatch.setattr(standlib.time, 'sleep', c.sleep)
    monkeypatch.setattr(standlib.time, 'time', c.now)
    return c


def no_restart(node):
    bad = [c for c in node.cmds if FORBIDDEN.search(c)]
    assert not bad, bad


# ============================== команды ==============================

@pytest.mark.parametrize('role,network', [('ap', 'lan'), ('sta', None), ('sta', '')])
def test_uci_script_commits_and_syncs(role, network):
    s = nodeboot.uci_script(nodeboot.Spec(role, 'WL 60', network, modparams='no_fw_recovery=Y'), 'sig0')
    lines = s.strip().splitlines()
    assert 'uci set wireless.default_radio0.mode=%s' % role in lines
    assert "uci set wireless.default_radio0.ssid='WL 60'" in lines
    assert ('uci set wireless.default_radio0.network=lan' in lines) == (network == 'lan')
    assert ('uci -q delete wireless.default_radio0.network' in lines) == (network == '')
    assert any(l.startswith('uci commit wireless') for l in lines)
    assert lines[-4:] == ['sync', 'sleep 1', 'sync', 'echo PREPARED']
    assert "echo 'options wil6210 no_fw_recovery=Y # sparraw-stand' >> /etc/modules.conf" in lines
    assert not FORBIDDEN.search(s) and 'reboot' not in s


def test_scenario_uci_before_commit_and_restored_next_time():
    s = nodeboot.uci_script(nodeboot.Spec('ap', 'X', 'lan', uci='uci set wireless.default_radio0.multicast_to_unicast=1;'
                                          ' uci set network.lan.foo=bar'), 'sig')
    i_opt = s.index('multicast_to_unicast=1')
    assert i_opt < s.index('uci commit wireless') and s.index('network.lan.foo=bar') < s.index('uci commit network')
    # исходное значение запомнено ДО изменения, откат прошлого сценария — до роли
    assert s.index('uci -q get wireless.default_radio0.multicast_to_unicast') < i_opt
    assert s.index('done < /etc/sparraw-stand.uci') < s.index('.mode=ap')
    assert 'mv -f /etc/sparraw-stand.uci.new /etc/sparraw-stand.uci' in s
    # без параметров модуля строка в modules.conf удаляется и не добавляется
    assert "sed -i '/# sparraw-stand$/d' /etc/modules.conf" in s and 'options wil6210' not in s


@pytest.mark.parametrize('bad', ['wifi up', 'uci commit wireless', 'rmmod wil6210', 'uci set x=1; wifi down', 'reboot'])
def test_scenario_rejects_non_uci(bad):
    with pytest.raises(nodeboot.StandError):
        nodeboot.Spec('ap', 'X', uci=bad)


def test_fw_version_parse():
    assert nodeboot.fw_version(fw_blob('6.4.1.0-SparRAW')) == '6.4.1.0-SparRAW'
    assert standlib.fw_version is nodeboot.fw_version


# ============================== загрузка одного узла ==============================

def test_boot_sequence(clock):
    n = FakeNode('n', clock, role='sta')
    fw, ko = fw_blob('a'), b'KO'
    spec = nodeboot.Spec('ap', 'WL60TEST', 'lan', fw=fw, ko=ko, brd_md5='e17714311e27')
    rep = nodeboot.boot(n, spec)
    assert rep.ok, rep.problems
    assert rep.iface == 'phy0-ap0' and n.running['mode'] == 'ap' and n.running['fw'] == md5(fw)
    order = [i for i, c in enumerate(n.cmds) if 'cat > "$P.new"' in c or 'PREPARED' in c or c.endswith('reboot')]
    kinds = ['fw' if nodeboot.FW in n.cmds[i] and 'cat >' in n.cmds[i] else 'ko' if 'wil6210.ko' in n.cmds[i] and
             'cat >' in n.cmds[i] else 'uci' if 'PREPARED' in n.cmds[i] else 'reboot' for i in order]
    assert kinds == ['fw', 'ko', 'uci', 'reboot']
    assert n.cmds[order[-1]].startswith('sync; sleep 1; sync; reboot')
    assert n.power_cycles == 0 and n.boot == 2
    no_restart(n)


def test_boot_reports_soft_problems(clock):
    n = FakeNode('n', clock)
    n.files[nodeboot.BRD] = 'ffff'
    n.fwerr = 1
    rep = nodeboot.boot(n, nodeboot.Spec('ap', 'X', fw=fw_blob('a'), brd_md5='e17714311e27'))
    assert rep.kinds == {'brd', 'fwerr'} and not rep.hard


def test_md5_mismatch_stops_before_reboot(clock, monkeypatch):
    n = FakeNode('n', clock)
    orig = n._answer
    monkeypatch.setattr(n, '_answer', lambda c, i: 'deadbeef  x\n' if 'cat > "$P.new"' in c else orig(c, i))
    with pytest.raises(nodeboot.StandError, match='md5'):
        nodeboot.boot(n, nodeboot.Spec('ap', 'X', fw=fw_blob('a')))
    assert not any(c.endswith('reboot') for c in n.cmds)


def test_no_power_when_node_returns(clock):
    n = FakeNode('n', clock, down_s=200)
    calls = []
    nodeboot.boot(n, nodeboot.Spec('ap', 'X'), power=lambda why: calls.append(why))
    assert calls == []


def test_power_once_when_unreachable_then_error(clock):
    n = FakeNode('n', clock)
    n.dead_until_power = True
    calls = []

    def power(why):
        calls.append(why)
        n.power(why)
    rep = nodeboot.boot(n, nodeboot.Spec('ap', 'X'), power=power)
    assert len(calls) == 1 and rep.ok

    m = FakeNode('m', clock)
    m.dead_until_power = True
    calls.clear()

    def power_dead(why):
        calls.append(why)
        m.power_cycles += 1          # питание снято, узел так и не поднялся
    with pytest.raises(nodeboot.StandError, match='после снятия питания'):
        nodeboot.boot(m, nodeboot.Spec('ap', 'X'), power=power_dead)
    assert len(calls) == 1


def test_no_power_callback_means_error(clock):
    n = FakeNode('n', clock)
    n.dead_until_power = True
    with pytest.raises(nodeboot.StandError, match='питание не снимается'):
        nodeboot.boot(n, nodeboot.Spec('ap', 'X'))


def test_hung_reboot_forced_once(clock):
    n = FakeNode('n', clock)
    n.hang_reboot = True
    calls = []
    rep = nodeboot.boot(n, nodeboot.Spec('ap', 'X'), power=lambda w: calls.append(w))
    assert rep.ok and calls == []
    assert sum('reboot -f' in c for c in n.cmds) == 1


def test_matches(clock):
    n = FakeNode('n', clock, role='sta')
    spec = nodeboot.Spec('ap', 'X', 'lan', fw=fw_blob('a'))
    assert not nodeboot.matches(n, spec)
    nodeboot.boot(n, spec)
    assert nodeboot.matches(n, spec)
    assert not nodeboot.matches(n, nodeboot.Spec('ap', 'X', 'lan', fw=fw_blob('b')))
    assert not nodeboot.matches(n, nodeboot.Spec('ap', 'X', 'lan', fw=fw_blob('a'), uci='uci set a.b.c=1'))


# ============================== стенд ==============================

class FakeStandNode(standlib.Node):
    """stand.Node, у которого ssh и питание — подставной узел."""

    def __init__(self, name, cfg, tools, mpc, fake):
        super().__init__(name, cfg, tools, mpc)
        self.fake = fake

    def sh(self, cmd, timeout, input=None):
        return self.fake.sh(cmd, timeout, input)

    def power_cycle(self, off_s=15):
        self.fake.power()


@pytest.fixture
def mkstand(clock, tmp_path):
    def mk(peer_role='ap'):
        fw = tmp_path / 'test.fw'
        fw.write_bytes(fw_blob('6.4.1.0-SparRAW'))
        cfg = {'dut': {'host': 'd', 'mac': '02:00:00:00:00:12', 'ip': '10.60.0.12'},
               'peer': {'host': 'p', 'ip': '10.60.0.11', 'ssid': 'STAND', 'fw_backup': '/lib/firmware/wil6210.fw.backup'},
               'test': {'ap_ssid': 'APTEST', 'brd_md5': 'e17714311e27'}}
        s = standlib.Stand(cfg, str(fw))
        fd, fp = FakeNode('dut', clock, role='sta', mac='02:00:00:00:00:12'), FakeNode('peer', clock, role=peer_role,
                                                                                       ssid='STAND')
        s.dut = FakeStandNode('dut', cfg['dut'], {}, 1, fd)
        s.peer = FakeStandNode('peer', cfg['peer'], {}, 1, fp)
        for n in (s.dut, s.peer):
            n.on_recover = s._node_recovered
        return s, fd, fp
    return mk


def test_stand_boot_sta_reboots_peer_once_then_reuses(mkstand):
    s, fd, fp = mkstand()
    assert s.boot_sta()
    assert s.role == 'sta' and fd.running['mode'] == 'sta' and fd.running['fw'] == md5(s.fw)
    assert fp.running['mode'] == 'ap' and fp.running['fw'] == md5(BACKUP) and fp.boot == 2   # первый раз — подпись
    assert any('ip addr add 10.60.0.11/24 dev br-lan' in c for c in fp.cmds)
    assert any('ip addr add 10.60.0.12/24 dev phy0-sta0' in c for c in fd.cmds)
    s.boot_sta()                                     # peer уже точка на своей прошивке — без перезагрузки
    assert fp.boot == 2 and fd.boot == 3
    no_restart(fd), no_restart(fp)


def test_stand_boot_ap_and_teardown(mkstand):
    s, fd, fp = mkstand()
    assert s.boot_ap()
    assert fd.running['mode'] == 'ap' and fp.running['mode'] == 'sta' and fp.running['fw'] == md5(s.fw)
    assert any("options wil6210 no_fw_recovery=Y" in c for c in fp.cmds)
    assert any('nft insert rule inet fw4 input iifname phy0-ap0 accept' in c for c in fd.cmds)
    b = fp.boot
    s.teardown()
    assert fp.boot == b + 1 and fp.running['mode'] == 'ap' and fp.running['fw'] == md5(BACKUP)
    no_restart(fd), no_restart(fp)


def test_stand_restart_peer_is_reboot(mkstand):
    s, fd, fp = mkstand()
    s.boot_sta()
    b = fp.boot
    s.restart_peer()
    assert fp.boot == b + 1 and fp.running['mode'] == 'ap'
    no_restart(fp)


def test_stand_hung_command_no_power(mkstand, monkeypatch):
    s, fd, fp = mkstand()
    orig = fd.sh
    monkeypatch.setattr(fd, 'sh', lambda c, t, i=None: (None, b'', b'') if c == 'cat /x' else orig(c, t, i))
    with pytest.raises(standlib.StandError, match='зависла'):
        s.dut.run('cat /x')
    assert fd.power_cycles == 0


def test_stand_power_budget(mkstand):
    s, fd, fp = mkstand()
    fd.dead_until_power = True
    fd.up_at = 10 ** 9                               # узел пропал
    fd.dead = True
    s.dut.run('true', check=False)                   # recover: ждёт ssh, затем одно снятие питания
    assert fd.power_cycles == 1 and s.dut.recoveries == 1
    fd.dead = True
    with pytest.raises(standlib.StandError, match='max_power_cycles'):
        s.dut.run('true', check=False)
    assert fd.power_cycles == 1


def test_vanish_is_reboot_f_without_power(mkstand):
    """Стимул тестов пропажи: «sync; reboot -f» (без скриптов остановки), не снятие питания; узел поднимается сам в
    закоммиченной роли, после чего точка peer восстанавливается без ещё одной перезагрузки."""
    s, fd, fp = mkstand()
    s.boot_sta()
    b = fp.boot
    old = s.peer.vanish()
    assert old == 'boot-%d' % b and fp.cmds[-1] == 'sync; sleep 1; sync; reboot -f'
    nodeboot.wait_up(s.peer, old, s.peer.power_recover)
    s._peer_restore_ap()
    assert fp.boot == b + 1 and fp.power_cycles == 0 and s.peer.recoveries == 0
    assert fp.running['mode'] == 'ap' and fp.running['fw'] == md5(BACKUP)
    no_restart(fp)


def test_vanish_tests_do_not_cut_power():
    """test_*_vanish не снимают питание: ни power_cycle, ни power_recover — только Node.vanish."""
    import os
    here = os.path.dirname(os.path.abspath(__file__))
    for f in ('test_sta_vanish.py', 'test_ap_vanish.py'):
        src = open(os.path.join(here, f)).read()
        assert 'power_cycle(' not in src and '.vanish()' in src, f
