# SPDX-License-Identifier: AGPL-3.0-or-later
"""Без стенда: узел стенда (tools/stand/nodeboot.py) и загрузка ролей (stand.Stand) на подставном узле.

Правило docs/STAND.md: после загрузки системы wil6210 не грузится сам; итерация — reboot -f → проверка lsmod →
прошивка итерации в tmpfs → firmware_class.path → роль в uci без commit + один network reload (netifd без phy) →
ожидание netifd → insmod с параметрами → phy ↔ radio0 → network.wireless up radio0 (идемпотентно, hotplug делает
то же) → проверки, в т. ч. прошивка стартовала один раз; смена — только новой перезагрузкой: ни rmmod, ни
modprobe -r, ни wifi down/reload/up; питание — только при неответе по ssh и не больше одного раза.
"""
import hashlib, itertools, os, re, struct

import pytest

import stand as standlib
from stand import nodeboot as nb

BACKUP = b'vendor-fw-backup'
SYSFW = b'flash-fw'
LOWPWR = 'e17714311e27' + '0' * 20
SEQ = itertools.count()     # общий порядок событий узлов стенда
RADIO_PATH = 'platform/soc/40000000.pci/pci0000:00/0000:00:00.0/0000:01:00.0'


def md5(b):
    return hashlib.md5(b).hexdigest()


def fw_blob(ver):
    """Минимальный образ .fw: запись 6 с комментарием «FW version: ver» (как в nodeboot.fw_version)."""
    c = (b'\0' * 20 + ('FW version: %s' % ver).encode()).ljust(52, b'\0')
    return struct.pack('<HHI', 6, 0, len(c)) + c


class Clock:
    def __init__(self):
        self.t = 0.0

    def now(self):
        return self.t

    def sleep(self, s):
        self.t += s


class FakeNode:
    """Узел OpenWrt в памяти. Флеш: /lib/firmware (wil6210.fw, .brd, бэкап), /etc/modules.d/wil6210 (autoload),
    закоммиченный uci. tmpfs (пропадает с перезагрузкой): /tmp/sparraw-*, дельта uci, модули, firmware_class.path.
    setup netifd берёт роль из дельты поверх commit, прошивку — из firmware_class.path, если файл там есть, иначе из
    /lib/firmware (как fw_path[] ядра). events — шаги итерации по порядку.

    netifd (wireless.uc / wireless-device.uc): конфиг радио берётся при загрузке и network reload (commit + дельта);
    setup без phy — «PHY is undefined», set_retry(false): radio0 в down; network.wireless up / retry (hotplug
    10-wifi-detect при insmod, если hotplug) — setup только из down, повтор — ничего. Каждый setup — старт fw
    (+ extra_fw_restarts лишних: модель перезапусков при подъёме) и «Starting» в logread.

    down_s — сколько узел грузится; dead — не отвечает; dead_until_power — не возвращается после reboot, оживает
    после снятия питания; hang_reboot — reboot не перезагружает (процесс в D), «reboot -f» — да; pending_polls —
    сколько опросов status netifd ещё занят setup после reload; flap — станция теряет связь сразу после подключения;
    commit_on_hotplug — hotplug закоммитил wireless; radio_path — config.path radio0 в netifd."""

    def __init__(self, name, clock, role='ap', down_s=70, mac='02:00:00:00:00:01', autoload=False):
        self.name, self.host, self.clock, self.down_s, self.mac = name, 'root@' + name, clock, down_s, mac
        self.cmds, self.events = [], []
        self.flash = {'/lib/firmware/wil6210.fw': md5(SYSFW), '/lib/firmware/wil6210.fw.backup': md5(BACKUP),
                      nb.BRD: LOWPWR}
        self.autoload = autoload
        self.committed = {'mode': role, 'ssid': 'OLD'}
        self.vers = {}               # md5 образа → версия (строка wmi_evt_ready)
        self.boot = 1
        self.up_at = 0
        self.dead = self.dead_until_power = self.hang_reboot = False
        self.power_cycles = 0
        self.fwerr = 0
        self.hotplug = True
        self.extra_fw_restarts = 0
        self.pending_polls = 0
        self.flap = False
        self.commit_on_hotplug = False
        self.radio_path = RADIO_PATH
        self.flash[nb.WCONF] = 'cfg-committed'
        self._fresh()

    def _fresh(self):
        """Состояние сразу после загрузки системы."""
        self.tmp, self.delta, self.fwpath, self.running, self.insmod_args = {}, {}, '', None, None
        self.modules = {'wil6210', 'cfg80211'} if self.autoload else set()
        # netifd после загрузки: setup с закоммиченной ролью без phy не прошёл — radio0 в down
        self.nd_cfg, self.nd_state, self.nd_failed, self.nd_pending = dict(self.committed), 'down', True, 0
        self.fw_starts, self.fw_ts, self.starts, self.teardowns, self.disc, self.link_calls = 0, [], 0, 0, 0, 0
        if self.autoload:            # автозагрузка: драйвер и роль из commit, прошивка с флеша
            self.running = dict(self.committed, fw=self.flash['/lib/firmware/wil6210.fw'], sig='')

    # --- состояние ---
    def is_up(self):
        return not self.dead and self.clock.now() >= self.up_at

    def _do_reboot(self):
        self.boot += 1
        self.up_at = self.clock.now() + self.down_s
        self._fresh()
        self.events.append('reboot')
        if self.dead_until_power:
            self.dead = True

    def power(self, why=''):
        self.power_cycles += 1
        if self.dead_until_power:
            self.dead = self.dead_until_power = False
        self._do_reboot()

    def ver(self):
        return self.vers.get(self.running['fw']) or 'v-' + self.running['fw'][:6]

    def _setup(self):
        """netifd setup radio0 (из down): без phy — сбой без повторов; с phy — роль из конфига netifd, старт fw."""
        if 'wil6210' not in self.modules:
            self.nd_failed, self.nd_state = True, 'down'
            return
        fw = self.tmp.get(nb.FW_TMP) if self.fwpath == nb.FWDIR and nb.FW_TMP in self.tmp else \
            self.flash['/lib/firmware/wil6210.fw']
        self.running = dict(self.nd_cfg, fw=fw, sig=self.tmp.get(nb.SIG, ''))
        self.starts += 1
        for _ in range(1 + self.extra_fw_restarts):
            self.fw_starts += 1
            self.fw_ts.append('%.3f' % (20 + self.fw_starts))
        self.nd_state, self.nd_failed = 'up', False
        self.events.append('setup')
        self.up_seq = next(SEQ)

    def _wstatus(self):
        pending = bool(self.nd_pending)
        self.nd_pending = max(0, self.nd_pending - 1)
        phy = 'wil6210' in self.modules
        out = 'w_up=%s\nw_pending=%s\nw_retry_setup_failed=%s\nw_path=%s\nw_phy=\nw_macaddr=\nphy=%s\n' % (
            str(self.nd_state == 'up').lower(), str(pending).lower(), str(self.nd_failed).lower(),
            self.radio_path, 'phy0' if phy else '')
        if phy:
            out += 'phypath=/sys/devices/%s\nphymac=%s\n' % (RADIO_PATH, self.mac)
        return out

    def iw(self):
        if not self.running:
            return ''
        t = 'AP' if self.running['mode'] == 'ap' else 'managed'
        i = 'phy0-ap0' if t == 'AP' else 'phy0-sta0'
        return 'phy#0\n\tInterface %s\n\t\tifindex 9\n\t\taddr %s\n\t\ttype %s\n' % (i, self.mac, t)

    # --- ssh ---
    def sh(self, cmd, timeout, input=None):
        self.cmds.append(cmd)
        if not self.is_up():
            return None if self.dead else 255, b'', b'ssh: connect to host: No route'
        out = self._answer(cmd, input)
        if out is None:
            return 1, b'', b'failed'
        return 0, out.encode(), b''

    def _answer(self, cmd, input):
        if cmd == nb.BOOT_ID_CMD:
            return 'boot-%d\n' % self.boot
        if 'reboot -f' in cmd:
            self._do_reboot()
            return ''
        if re.search(r'\breboot$', cmd):     # обычный reboot (через procd)
            if not self.hang_reboot:
                self._do_reboot()
            return ''
        if 'echo INSTALLED' in cmd:
            out = 'AUTOLOAD_REMOVED\n' if self.autoload else ''
            self.autoload = False
            return out + 'INSTALLED\n'
        if 'echo UNINSTALLED' in cmd:
            self.autoload = True
            return 'UNINSTALLED\n'
        if cmd == nb.LOADED_CMD:
            self.events.append('lsmod')
            return '%d\n' % ('wil6210' in self.modules)
        if cmd == nb.RC_SETTLE_CMD:
            return 'ok\n'
        if cmd.startswith('P=') and 'cat > "$P.new"' in cmd:          # put_cmd
            path = cmd.split(';')[0][2:]
            self.tmp[path] = md5(input)
            self.vers[md5(input)] = nb.fw_version(input) if path == nb.FW_TMP else None
            self.events.append('fw' if path == nb.FW_TMP else 'ko')
            return '%s  %s\n' % (self.tmp[path], path)
        m = re.match(r'md5sum (\S+)$', cmd)
        if m and m.group(1) in self.flash:
            return '%s  x\n' % self.flash[m.group(1)]
        m = re.match(r'mkdir -p \S+ && cp (\S+) (\S+) && md5sum', cmd)
        if m:
            self.tmp[m.group(2)] = self.flash[m.group(1)]
            self.events.append('fw')
            return '%s  x\n' % self.tmp[m.group(2)]
        if cmd.startswith('cp %s %s' % (nb.BRD, nb.BRD_TMP)):
            self.tmp[nb.BRD_TMP] = self.flash[nb.BRD]
            self.events.append('brd')
            return '%s  x\n' % self.tmp[nb.BRD_TMP]
        if cmd.startswith('echo -n %s > %s' % (nb.FWDIR, nb.FWPATH)):
            self.fwpath = nb.FWDIR
            self.events.append('fwpath')
            return self.fwpath
        if 'echo UCI_SET' in cmd:
            assert 'uci commit' not in cmd and cmd.count('ubus call network reload') == 1
            assert cmd.index('md5sum %s' % nb.WCONF) < cmd.index('ubus call network reload')
            self.delta['mode'] = re.search(r'\.mode=(\w+)', cmd).group(1)
            self.delta['ssid'] = re.search(r'\.ssid=(\S+)', cmd).group(1).strip("'")
            self.tmp[nb.SIG] = re.search(r'echo (\w+) > ', cmd).group(1)
            self.tmp[nb.WCONF_MD5] = self.flash[nb.WCONF]
            self.events += ['uci', 'reload']
            # network reload: config_init (дельта поверх commit) → config_start → start(): setup из down
            self.nd_cfg = dict(self.committed, **self.delta)
            self.nd_failed = False
            if self.nd_state == 'down':
                self._setup()
            self.nd_pending = self.pending_polls
            return 'UCI_SET\n'
        if cmd.startswith('modprobe cfg80211'):
            self.modules.add('cfg80211')
            self.events.append('modprobe')
            return '1\n'
        if cmd.startswith('insmod '):
            if 'wil6210' in self.modules or 'cfg80211' not in self.modules:
                return None
            parts = cmd.replace(nb.KO_SYS, 'KO_SYS').split()
            self.modules.add('wil6210')
            self.insmod_args = parts[2:]
            self.ko_md5 = self.tmp.get(nb.KO_TMP) if parts[1] == nb.KO_TMP else md5(b'sysko')
            self.events.append('insmod')
            if self.hotplug:         # 10-wifi-detect: wifi config + network.wireless retry
                if self.commit_on_hotplug:
                    self.flash[nb.WCONF] = 'cfg-recommitted'
                if self.nd_state == 'down':
                    self._setup()
            return ''
        if cmd == nb.PHY_CMD:
            return 'phy0\n' if 'wil6210' in self.modules else ''
        if cmd == nb.WSTATUS_CMD:
            return self._wstatus()
        if cmd == nb.UP_CMD:
            assert 'wil6210' in self.modules
            self.events.append('up')
            self.nd_failed = False
            if self.nd_state == 'down':
                self._setup()
            return ''
        if cmd == nb.FW_READY_CMD:
            return '[ 20.0] wil6210 x: wmi_evt_ready: FW ver. %s(SW 1)\n' % self.ver() if self.running else ''
        if cmd == 'iw dev':
            return self.iw()
        if cmd == nb.LINK_CMD:
            if not (self.running and self.running['mode'] == 'sta'):
                return ''
            self.link_calls += 1
            if self.flap and self.link_calls >= 2:
                if self.link_calls == 2:
                    self.disc += 1
                return ''
            return 'phy0-sta0\n'
        if cmd == nb.FACTS_CMD:
            r = self.running
            ap = r and r['mode'] == 'ap'
            return ('ver=%s\nfwerr=%d\nprobe=\nmod=%d\nfwpath=%s\nfw=%s\nko=%s\nbrd=%s\nsig=%s\n' % (
                self.ver() if r else '', self.fwerr, 'wil6210' in self.modules, self.fwpath,
                self.tmp.get(nb.FW_TMP, ''), getattr(self, 'ko_md5', '') if 'wil6210' in self.modules else '',
                self.tmp.get(nb.BRD_TMP, ''), self.tmp.get(nb.SIG, '')) +
                'fwstarts=%d\nfwts=%s\nstarts=%d\nteardowns=%d\napen=%d\napdis=%d\nconn=%d\ndisc=%d\nrej=0\n'
                'cfg0=%s\ncfg=%s\n' % (
                    self.fw_starts, ' '.join(self.fw_ts), self.starts, self.teardowns, self.starts if ap else 0,
                    0, self.starts if r and not ap else 0, self.disc, self.tmp.get(nb.WCONF_MD5, ''),
                    self.flash[nb.WCONF])) + self.iw()
        if cmd == 'dmesg':
            return '[   20.000000] wil6210 x: wmi_evt_ready: FW ver. %s(SW 1)\n' % self.ver() if self.running else ''
        if 'station dump' in cmd:
            return 'Station 02:00:00:00:00:02 (on phy0-ap0)\n' if self.running and self.running['mode'] == 'ap' else ''
        if cmd.startswith('cat /sys/class/net/') and cmd.endswith('/address'):
            return self.mac + '\n'
        return ''

    def iteration_events(self):
        """Шаги последней итерации (после последней перезагрузки)."""
        ev = self.events
        i = len(ev) - 1 - ev[::-1].index('reboot') if 'reboot' in ev else 0
        return ev[i:]


ORDER = ['reboot', 'lsmod', 'fw', 'brd', 'fwpath', 'uci', 'reload', 'modprobe', 'insmod', 'up']


def assert_order(node, with_ko=False, reboot=True):
    ev = node.iteration_events()
    want = [e for e in ORDER if reboot or e != 'reboot']
    if with_ko:
        want.insert(want.index('fwpath'), 'ko')
    got = []
    for e in ev:                 # первые вхождения, проверки lsmod после insmod не в счёт; setup netifd — отдельно
        if e not in got and e != 'setup':
            got.append(e)
    assert got[:len(want)] == want, got


def no_restart(node):
    bad = [c for c in node.cmds if nb.FORBIDDEN.search(c) or re.search(r'\buci\s+commit\b', c)]
    assert not bad, bad
    assert sum('ubus call network reload' in c for c in node.cmds) <= node.boot   # один reload на загрузку


@pytest.fixture
def clock(monkeypatch):
    c = Clock()
    monkeypatch.setattr(nb, '_now', c.now)
    monkeypatch.setattr(nb, '_sleep', c.sleep)
    monkeypatch.setattr(standlib.time, 'sleep', c.sleep)
    monkeypatch.setattr(standlib.time, 'time', c.now)
    return c


# ============================== команды ==============================

@pytest.mark.parametrize('role,network', [('ap', 'lan'), ('sta', None), ('sta', '')])
def test_uci_script_without_commit(role, network):
    s = nb.uci_script(nb.Spec(role, 'WL 60', network, fw=b'x'), 'sig0')
    lines = s.strip().splitlines()
    assert 'uci set wireless.default_radio0.mode=%s' % role in lines
    assert "uci set wireless.default_radio0.ssid='WL 60'" in lines
    assert ('uci set wireless.default_radio0.network=lan' in lines) == (network == 'lan')
    assert ('uci -q delete wireless.default_radio0.network' in lines) == (network == '')
    assert 'uci commit' not in s and lines.count('ubus call network reload') == 1
    assert lines.index("md5sum /etc/config/wireless | cut -d' ' -f1 > %s" % nb.WCONF_MD5) < \
        lines.index('ubus call network reload')
    assert lines[-1] == 'echo UCI_SET'
    assert not nb.FORBIDDEN.search(s) and 'reboot' not in s and 'insmod' not in s


def test_scenario_uci_applied_before_reload():
    s = nb.uci_script(nb.Spec('ap', 'X', 'lan', fw=b'x', uci='uci set wireless.default_radio0.multicast_to_unicast=1'),
                      'sig')
    assert s.index('multicast_to_unicast=1') < s.index('ubus call network reload')


@pytest.mark.parametrize('bad', ['wifi up', 'uci commit wireless', 'rmmod wil6210', 'uci set x=1; wifi down', 'reboot'])
def test_scenario_rejects_non_uci(bad):
    with pytest.raises(nb.StandError):
        nb.Spec('ap', 'X', fw=b'x', uci=bad)


def test_spec_needs_explicit_firmware_and_sane_params():
    with pytest.raises(nb.StandError, match='прошивка итерации'):
        nb.Spec('ap', 'X')
    with pytest.raises(nb.StandError):
        nb.Spec('ap', 'X', fw=b'x', fw_node='/y')
    with pytest.raises(nb.StandError, match='имя=значение'):
        nb.Spec('ap', 'X', fw=b'x', modparams='no_fw_recovery=Y; reboot')


@pytest.mark.parametrize('cmd', ['rmmod wil6210', 'modprobe -r wil6210', 'modprobe -qr wil6210', 'wifi down',
                                 'wifi reload', 'x; wifi down radio0', 'wifi up radio0', 'wifi', 'true; wifi',
                                 'wifi reconf', 'a\n  wifi\nb'])
def test_check_cmd_forbids_restart(cmd):
    with pytest.raises(nb.StandError, match='запрещённая'):
        nb.check_cmd(cmd)


def test_check_cmd_allows_iteration_commands():
    for c in ('modprobe cfg80211; grep -c x /proc/modules', 'insmod /tmp/sparraw-drv/wil6210.ko no_fw_recovery=Y',
              nb.UP_CMD, nb.WSTATUS_CMD, nb.FACTS_CMD, nb.install_script(), nb.RC_SETTLE_CMD, 'wifi status',
              nb.uci_script(nb.Spec('ap', 'X', fw=b'x'), 's')):
        nb.check_cmd(c)
    nb.check_cmd('wifi down radio0', allow_wifi_down=True)
    with pytest.raises(nb.StandError):
        nb.check_cmd('rmmod wil6210', allow_wifi_down=True)


def test_rc_settle_does_not_find_itself():
    """Ожидание rc.local ищет «sh /etc/rc.local» в ps — текст самой команды (sh -c) этой строки не содержит."""
    assert 'rc.local' not in nb.RC_SETTLE_CMD and re.search(r'\[s\]h /etc/rc\[\.\]local', nb.RC_SETTLE_CMD)


def test_install_script():
    s = nb.install_script()
    assert 'cp /etc/modules.d/wil6210 /etc/sparraw-stand.modules.d.wil6210' in s and 'rm -f /etc/modules.d/wil6210' in s
    assert "sed -i '/# sparraw-stand$/d' /etc/modules.conf" in s
    assert s.strip().splitlines()[-2:] == ['sync', 'echo INSTALLED']


def test_fw_version_parse():
    assert nb.fw_version(fw_blob('6.4.1.0-SparRAW')) == '6.4.1.0-SparRAW'
    assert standlib.fw_version is nb.fw_version


# ============================== итерация на одном узле ==============================

def test_iteration_order(clock):
    n = FakeNode('n', clock, role='sta')
    fw, ko = fw_blob('a'), b'KO'
    spec = nb.Spec('ap', 'WL60TEST', 'lan', fw=fw, ko=ko, modparams='no_fw_recovery=Y', brd_md5='e17714311e27')
    rep = nb.boot(n, spec)
    assert rep.ok, rep.problems
    assert_order(n, with_ko=True)
    assert n.insmod_args == ['no_fw_recovery=Y'] and n.fwpath == nb.FWDIR
    assert n.running['mode'] == 'ap' and n.running['fw'] == md5(fw) and n.committed['mode'] == 'sta'  # флеш не тронут
    assert n.flash['/lib/firmware/wil6210.fw'] == md5(SYSFW)
    assert n.power_cycles == 0 and n.boot == 2
    assert n.fw_starts == 1 and n.starts == 1 and rep.facts['fwstarts'] == '1'
    assert any('reboot -f' in c for c in n.cmds) and not any(re.search(r'\breboot$', c) for c in n.cmds)
    no_restart(n)


def test_reload_once_before_insmod_then_idempotent_up(clock):
    """Один network reload — до insmod (netifd берёт роль без phy, setup не проходит и прошивку не трогает), затем
    ожидание netifd, insmod, network.wireless up; hotplug уже поднял радио — up ничего не перезапускает."""
    n = FakeNode('n', clock, role='sta')
    n.pending_polls = 3
    rep = nb.boot(n, nb.Spec('ap', 'X', 'lan', fw=fw_blob('a')))
    assert rep.ok, rep.problems
    c = n.cmds
    ins = next(i for i, x in enumerate(c) if x.startswith('insmod '))
    rel = [i for i, x in enumerate(c) if 'ubus call network reload' in x]
    assert len(rel) == 1 and rel[0] < ins
    assert sum(x == nb.WSTATUS_CMD for x in c[rel[0]:ins]) >= 4          # ждал, пока netifd занят setup без phy
    assert c.index(nb.UP_CMD) > ins and not any(x.startswith('wifi ') for x in c)
    ev = n.iteration_events()
    assert ev.index('setup') < ev.index('up')                            # поднял hotplug, up — no-op
    assert n.fw_starts == 1 and n.starts == 1


def test_up_without_hotplug(clock):
    """hotplug не сработал — радио поднимает network.wireless up, тоже один раз."""
    n = FakeNode('n', clock)
    n.hotplug = False
    rep = nb.boot(n, nb.Spec('sta', 'X', fw=fw_blob('a')))
    assert rep.ok and rep.link, rep.problems
    ev = n.iteration_events()
    assert ev.index('up') < ev.index('setup') and n.fw_starts == 1


def test_fw_restarts_at_bringup_are_error(clock):
    """Прошивка стартовала 4 раза при подъёме (как на точке-вендоре 2026-11-08) — ошибка стенда."""
    n = FakeNode('n', clock)
    n.extra_fw_restarts = 3
    rep = nb.boot(n, nb.Spec('ap', 'X', fw=fw_blob('a')))
    assert 'restart' in rep.kinds and rep.hard
    assert any('прошивка перезапускалась 4 раз при подъёме' in p and '21.000 22.000 23.000 24.000' in p
               for p in rep.problems), rep.problems
    m = FakeNode('m', clock)
    m.extra_fw_restarts = 1
    assert nb.boot(m, nb.Spec('ap', 'X', fw=fw_blob('a'), max_fw_starts=2)).ok        # настройка допуска
    k = FakeNode('k', clock)
    k.extra_fw_restarts, k.fwerr = 1, 1
    rep = nb.boot(k, nb.Spec('sta', 'X', fw=fw_blob('a'), wait_link=False))
    assert rep.kinds == {'restart', 'fwerr'} and not rep.hard          # восстановление после FW error — предмет тестов


def test_role_restart_is_error(clock, monkeypatch):
    n = FakeNode('n', clock)
    orig = n._setup

    def twice():
        orig()
        if 'wil6210' in n.modules:
            n.starts += 1
            n.teardowns += 1
    monkeypatch.setattr(n, '_setup', twice)
    rep = nb.boot(n, nb.Spec('ap', 'X', fw=fw_blob('a')))
    assert rep.hard and any('«Starting» ×2, «Tearing down» ×1' in p for p in rep.problems), rep.problems


def test_sta_disconnect_after_link(clock):
    n = FakeNode('n', clock)
    n.flap = True
    rep = nb.boot(n, nb.Spec('sta', 'X', fw=fw_blob('a')))
    assert rep.kinds == {'link'} and not rep.link
    assert any('связь пропала за %d с после связи (CTRL-EVENT-DISCONNECTED ×1)' % nb.STABLE_S in p
               for p in rep.problems), rep.problems


def test_peer_sta_without_link_skips_window_link_check(clock):
    n = FakeNode('n', clock)
    n.flap = True
    rep = nb.boot(n, nb.Spec('sta', 'X', fw=fw_blob('a')), link=False)
    assert rep.ok, rep.problems


def test_commit_during_bringup_is_error(clock):
    n = FakeNode('n', clock)
    n.commit_on_hotplug = True
    rep = nb.boot(n, nb.Spec('ap', 'X', fw=fw_blob('a')))
    assert 'commit' in rep.kinds and rep.hard


def test_radio_not_pointing_to_phy_stops_before_up(clock):
    n = FakeNode('n', clock)
    n.radio_path = 'platform/soc/other.pci/0000:01:00.0'
    with pytest.raises(nb.StandError, match='не указывает на phy'):
        nb.boot(n, nb.Spec('ap', 'X', fw=fw_blob('a')))
    assert nb.UP_CMD not in n.cmds


def test_netifd_without_radio0_stops_before_insmod(clock, monkeypatch):
    n = FakeNode('n', clock)
    orig = n._answer
    monkeypatch.setattr(n, '_answer', lambda c, i: '' if c == nb.WSTATUS_CMD else orig(c, i))
    with pytest.raises(nb.StandError, match='не знает radio0'):
        nb.boot(n, nb.Spec('ap', 'X', fw=fw_blob('a')))
    assert not any(c.startswith('insmod') for c in n.cmds)


@pytest.mark.parametrize('w,ok', [
    ({'phy': 'phy0', 'phypath': '/sys/devices/a/b/0000:01:00.0', 'w_path': 'a/b/0000:01:00.0'}, True),
    ({'phy': 'phy0', 'phypath': '/sys/devices/a/b/0000:01:00.0', 'w_path': 'a/b/0000:01:00.0+1'}, True),
    ({'phy': 'phy0', 'phypath': '/sys/devices/a/b/0000:02:00.0', 'w_path': 'a/b/0000:01:00.0'}, False),
    ({'phy': 'phy0', 'w_phy': 'phy0'}, True),
    ({'phy': 'phy0', 'w_macaddr': '02:00:00:00:00:AA', 'phymac': '02:00:00:00:00:aa'}, True),
    ({'phy': 'phy0'}, False),
    ({'phy': '', 'w_path': 'x'}, False)])
def test_radio_matches_phy(w, ok):
    assert nb.radio_matches_phy(w)[0] == ok


def test_reboot_modes(clock):
    n = FakeNode('n', clock)
    nb.reboot(n)
    assert n.cmds[-1] == 'sync; sleep 1; sync; reboot -f'
    nb.reboot(n, mode='init')
    assert n.cmds[-1] == 'sync; sleep 1; sync; reboot'
    with pytest.raises(nb.StandError, match='режим перезагрузки'):
        nb.reboot(n, mode='soft')


def test_system_module_when_no_ko(clock):
    n = FakeNode('n', clock)
    nb.boot(n, nb.Spec('ap', 'X', fw=fw_blob('a')))
    assert any(c.startswith('insmod /lib/modules/$(uname -r)/wil6210.ko') for c in n.cmds)
    assert_order(n)


def test_autoloaded_driver_is_error(clock):
    n = FakeNode('n', clock, autoload=True)
    with pytest.raises(nb.StandError, match='загрузил драйвер wil6210 сам'):
        nb.boot(n, nb.Spec('ap', 'X', fw=fw_blob('a')))
    assert not any(c.startswith('insmod') for c in n.cmds)
    nb.install(n)
    nb.install(n)                # идемпотентно
    assert nb.boot(n, nb.Spec('ap', 'X', fw=fw_blob('a'))).ok


def test_wrong_board_stops_before_insmod(clock):
    n = FakeNode('n', clock)
    n.flash[nb.BRD] = 'ffff'
    with pytest.raises(nb.StandError, match='плата'):
        nb.boot(n, nb.Spec('ap', 'X', fw=fw_blob('a'), brd_md5='e17714311e27'))
    assert not any(c.startswith('insmod') for c in n.cmds)


def test_soft_problems_reported(clock):
    n = FakeNode('n', clock)
    n.fwerr = 1
    rep = nb.boot(n, nb.Spec('ap', 'X', fw=fw_blob('a')))
    assert rep.kinds == {'fwerr'} and not rep.hard


def test_fw_node_copied_to_tmp(clock):
    n = FakeNode('n', clock)
    rep = nb.boot(n, nb.Spec('ap', 'X', fw_node='/lib/firmware/wil6210.fw.backup'))
    assert rep.ok and n.running['fw'] == md5(BACKUP)


def test_md5_mismatch_stops_before_insmod(clock, monkeypatch):
    n = FakeNode('n', clock)
    orig = n._answer
    monkeypatch.setattr(n, '_answer', lambda c, i: 'deadbeef  x\n' if 'cat > "$P.new"' in c else orig(c, i))
    with pytest.raises(nb.StandError, match='md5'):
        nb.boot(n, nb.Spec('ap', 'X', fw=fw_blob('a')))
    assert not any(c.startswith('insmod') for c in n.cmds)


def test_no_power_when_node_returns(clock):
    n = FakeNode('n', clock, down_s=200)
    calls = []
    nb.boot(n, nb.Spec('ap', 'X', fw=b'f'), power=lambda why: calls.append(why))
    assert calls == []


def test_power_once_when_unreachable_then_error(clock):
    n = FakeNode('n', clock)
    n.dead_until_power = True
    calls = []

    def power(why):
        calls.append(why)
        n.power(why)
    rep = nb.boot(n, nb.Spec('ap', 'X', fw=b'f'), power=power)
    assert len(calls) == 1 and rep.ok

    m = FakeNode('m', clock)
    m.dead_until_power = True
    calls.clear()

    def power_dead(why):
        calls.append(why)
        m.power_cycles += 1          # питание снято, узел так и не поднялся
    with pytest.raises(nb.StandError, match='после снятия питания'):
        nb.boot(m, nb.Spec('ap', 'X', fw=b'f'), power=power_dead)
    assert len(calls) == 1


def test_no_power_callback_means_error(clock):
    n = FakeNode('n', clock)
    n.dead_until_power = True
    with pytest.raises(nb.StandError, match='питание не снимается'):
        nb.boot(n, nb.Spec('ap', 'X', fw=b'f'))


def test_hung_reboot_forced_once(clock):
    """Режим 'init' (обычный reboot через procd) завис — один reboot -f."""
    n = FakeNode('n', clock)
    n.hang_reboot = True
    calls = []
    rep = nb.boot(n, nb.Spec('ap', 'X', fw=b'f'), power=lambda w: calls.append(w), reboot_mode='init')
    assert rep.ok and calls == []
    assert sum('reboot -f' in c for c in n.cmds) == 1


def test_matches_within_one_boot_only(clock):
    n = FakeNode('n', clock, role='sta')
    spec = nb.Spec('ap', 'X', 'lan', fw=fw_blob('a'))
    assert not nb.matches(n, spec)
    nb.boot(n, spec)
    assert nb.matches(n, spec)
    assert not nb.matches(n, nb.Spec('ap', 'X', 'lan', fw=fw_blob('b')))
    assert not nb.matches(n, nb.Spec('ap', 'X', 'lan', fw=fw_blob('a'), uci='uci set a.b.c=1'))
    n.sh('sync; sleep 1; sync; reboot -f', 15)
    clock.sleep(100)
    assert not nb.matches(n, spec)             # после перезагрузки драйвера нет


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
    def mk():
        fw = tmp_path / 'test.fw'
        fw.write_bytes(fw_blob('6.4.1.0-SparRAW'))
        cfg = {'dut': {'host': 'd', 'mac': '02:00:00:00:00:12', 'ip': '10.60.0.12'},
               'peer': {'host': 'p', 'ip': '10.60.0.11', 'ssid': 'STAND', 'fw_backup': '/lib/firmware/wil6210.fw.backup'},
               'test': {'ap_ssid': 'APTEST', 'brd_md5': 'e17714311e27', 'modparams': 'fw_log_level=7'}}
        s = standlib.Stand(cfg, str(fw))
        fd, fp = FakeNode('dut', clock, role='sta', mac='02:00:00:00:00:12'), FakeNode('peer', clock, role='ap')
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
    assert fd.insmod_args == ['fw_log_level=7'] and fp.insmod_args == []
    assert fp.running['mode'] == 'ap' and fp.running['fw'] == md5(BACKUP) and fp.boot == 2
    assert_order(fd), assert_order(fp)
    assert any('ip addr add 10.60.0.11/24 dev br-lan' in c for c in fp.cmds)
    assert any('ip addr add 10.60.0.12/24 dev phy0-sta0' in c for c in fd.cmds)
    s.boot_sta()                                     # peer в этой загрузке уже точка на своей прошивке
    assert fp.boot == 2 and fd.boot == 3
    no_restart(fd), no_restart(fp)


def test_stand_boot_ap_and_teardown(mkstand):
    s, fd, fp = mkstand()
    assert s.boot_ap()
    assert fd.running['mode'] == 'ap' and fp.running['mode'] == 'sta' and fp.running['fw'] == md5(s.fw)
    assert fp.insmod_args == ['fw_log_level=7', 'no_fw_recovery=Y']
    assert any('nft insert rule inet fw4 input iifname phy0-ap0 accept' in c for c in fd.cmds)
    # точка грузится раньше станции
    assert fd.up_seq < fp.up_seq
    b = fp.boot
    s.teardown()                                     # peer — станция с драйвером: перезагрузка и точка
    assert fp.boot == b + 1 and fp.running['mode'] == 'ap' and fp.running['fw'] == md5(BACKUP)
    assert_order(fp)
    no_restart(fd), no_restart(fp)


def test_stand_reboot_mode_and_fw_starts_from_config(mkstand):
    s, fd, fp = mkstand()
    assert s.reboot_mode == 'force' and s.max_fw_starts is None
    s.t['reboot'], s.reboot_mode, s.max_fw_starts = 'init', 'init', 3
    s.boot_sta()
    assert any(re.search(r'\breboot$', c) for c in fd.cmds) and not any('reboot -f' in c for c in fd.cmds)
    assert s.dut_sta_spec().max_fw_starts == 3 and s.peer_ap_spec().max_fw_starts == 3
    cfg = dict(s.cfg, test=dict(s.t, reboot='soft'))
    with pytest.raises(standlib.StandError, match='reboot'):
        standlib.Stand(cfg, s.fw_path)


def test_stand_fw_restart_is_stand_error(mkstand):
    s, fd, fp = mkstand()
    fd.extra_fw_restarts = 3
    with pytest.raises(standlib.StandError, match='прошивка перезапускалась 4 раз'):
        s.boot_sta()


def test_stand_restart_peer_is_reboot(mkstand):
    s, fd, fp = mkstand()
    s.boot_sta()
    b = fp.boot
    s.restart_peer()
    assert fp.boot == b + 1 and fp.running['mode'] == 'ap'
    assert_order(fp)
    no_restart(fp)


def test_stand_run_rejects_restart_commands(mkstand):
    s, fd, fp = mkstand()
    for c in ('rmmod wil6210', 'wifi down; wifi up', 'modprobe -r wil6210'):
        with pytest.raises(standlib.StandError, match='запрещённая'):
            s.dut.run(c)
    s.dut.run('wifi down radio0', allow_wifi_down=True)      # test_ap_stop: сам предмет проверки
    assert not any('rmmod' in c for c in fd.cmds)


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
    fd.dead = True
    s.dut.run('true', check=False)                   # recover: ждёт ssh, затем одно снятие питания
    assert fd.power_cycles == 1 and s.dut.recoveries == 1
    fd.dead = True
    with pytest.raises(standlib.StandError, match='max_power_cycles'):
        s.dut.run('true', check=False)
    assert fd.power_cycles == 1


def test_vanish_then_driver_loaded_by_command(mkstand):
    """Стимул тестов пропажи: «sync; reboot -f», не питание; узел поднимается БЕЗ драйвера, тест загружает точку
    командой (без ещё одной перезагрузки)."""
    s, fd, fp = mkstand()
    s.boot_sta()
    b = fp.boot
    old = s.peer.vanish()
    assert old == 'boot-%d' % b and fp.cmds[-1] == 'sync; sleep 1; sync; reboot -f'
    nb.wait_up(s.peer, old, s.peer.power_recover)
    assert 'wil6210' not in fp.modules
    s._peer_restore_ap()
    assert fp.boot == b + 1 and fp.power_cycles == 0 and s.peer.recoveries == 0
    assert fp.running['mode'] == 'ap' and fp.running['fw'] == md5(BACKUP)
    assert_order(fp)
    no_restart(fp)


def test_vanish_tests_do_not_cut_power():
    """test_*_vanish: пропажа — Node.vanish, не power_cycle; после неё драйвер грузится командой."""
    here = os.path.dirname(os.path.abspath(__file__))
    for f in ('test_sta_vanish.py', 'test_ap_vanish.py'):
        src = open(os.path.join(here, f)).read()
        assert 'power_cycle(' not in src and '.vanish()' in src, f
    assert 'bring_up' in open(os.path.join(here, 'test_ap_vanish.py')).read()


def test_scripts_have_no_restart_commands():
    """Инструменты стенда не перезапускают драйвер: в tools/stand/*.sh нет rmmod, modprobe -r, wifi down/reload."""
    d = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'tools', 'stand')
    for f in os.listdir(d):
        if f.endswith('.sh'):
            for i, l in enumerate(open(os.path.join(d, f)), 1):
                if not l.lstrip().startswith('#'):
                    assert not nb.FORBIDDEN.search(l), '%s:%d: %s' % (f, i, l)


def test_fw_starts_allowance_by_role():
    """Допуск стартов fw по роли: станция 1, точка 2 (hostapd поднимает интерфейс дважды, стенд 2026-11-08)."""
    assert nb.Spec('sta', 'X', fw=fw_blob('a')).max_fw_starts == 1
    assert nb.Spec('ap', 'X', fw=fw_blob('a')).max_fw_starts == 2
    assert nb.Spec('ap', 'X', fw=fw_blob('a'), max_fw_starts=1).max_fw_starts == 1


def test_netconsole_cmd_passes_forbidden_check():
    """Включение netconsole не использует rmmod (2026-11-09: «rmmod netconsole» сорвал ночную матрицу)."""
    nb.check_cmd(nb.NETCON_CMD % ('192.168.1.11', 6611, '192.168.1.5', '00:11:22:33:44:55'))
    assert 'netconsole' in nb.install_script()
