# SPDX-License-Identifier: AGPL-3.0-or-later
"""Стенд для тестов прошивки: два узла OpenWrt с wil6210 (Sparrow), управление питанием, роли STA/AP.

Узлы описывает TOML-файл (tests/stand.example.toml): тестируемый узел (dut) и партнёр (peer). Партнёр в обычном
состоянии — точка доступа на своей (эталонной) прошивке; для теста AP роли меняются: dut — точка, peer — станция
на ТОМ ЖЕ тестируемом образе (vendor-станция 6.2 к точке по стандарту не идёт: B43 маяка, 9.3.4.2).

Всё — через ssh и uci без commit: power-cycle возвращает узлы в исходное состояние.
"""
import os, re, shlex, struct, subprocess, sys, time

HERE = os.path.dirname(os.path.abspath(__file__))
REWRITE = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(REWRITE, 'tools'))
sys.path.insert(0, os.path.join(REWRITE, 'tools', 'hwdbg'))

SSH_OPTS = ['-F', '/dev/null', '-o', 'StrictHostKeyChecking=no', '-o', 'UserKnownHostsFile=/dev/null',
            '-o', 'ConnectTimeout=8', '-o', 'LogLevel=ERROR']


class StandError(Exception):
    pass


# ============================== образ .fw ==============================

def fw_records(blob):
    """[(type, flags, payload)] записей образа wil6210 .fw."""
    out, off = [], 0
    while off + 8 <= len(blob):
        typ, flags, size = struct.unpack_from('<HHI', blob, off)
        out.append((typ, flags, blob[off + 8:off + 8 + size]))
        off += 8 + size
    return out


def fw_version(blob):
    """Строка версии из файлового заголовка (запись 6, комментарий «FW version: …»)."""
    for typ, _, p in fw_records(blob):
        if typ == 6:
            c = p[20:52].split(b'\0')[0].decode('latin1')
            return c.split('FW version: ', 1)[-1]
    return None


def fw_is_pro(blob):
    return '-PRO' in (fw_version(blob) or '').upper()


# ============================== узел ==============================

class Node:
    def __init__(self, name, cfg, tools):
        self.name = name
        self.host = cfg['host']
        self.cfg = cfg
        self.tools = tools
        self.on_recover = None     # колбэк стенда: узел перезагружен — роль потеряна
        self.recoveries = 0
        self.dmesg_mark = 0        # время ядра (dmesg) начала роли: ошибки FW считаются после него

    def _ssh(self, cmd, timeout, input=None):
        """ssh с самовосстановлением: узел не отвечает (ssh 255 или зависание) — power-cycle через розетку и повтор."""
        for attempt in (0, 1):
            try:
                r = subprocess.run(['ssh'] + SSH_OPTS + [self.host, cmd], capture_output=True, timeout=timeout,
                                   input=input)
                if r.returncode != 255:
                    return r
                why = 'ssh: %s' % r.stderr.decode('utf-8', 'replace').strip()[-120:]
            except subprocess.TimeoutExpired:
                why = 'зависание %d с' % timeout
            if attempt == 0:
                self.recover(why)
        raise StandError('%s: не отвечает и после перезагрузки (%s)' % (self.name, why))

    def recover(self, why):
        sys.stderr.write('\n[стенд] %s: %s — перезагрузка по питанию\n' % (self.name, why))
        self.recoveries += 1
        self.power_cycle()
        time.sleep(25)
        self.wait_alive()
        self.dmesg_mark = 0
        if self.on_recover:
            self.on_recover(self)

    def run(self, cmd, timeout=60, check=True, input=None):
        r = self._ssh(cmd, timeout, input)
        if check and r.returncode != 0:
            raise StandError('%s: «%s» → %d: %s' % (self.name, cmd[:80], r.returncode,
                                                     r.stderr.decode('utf-8', 'replace')[-300:]))
        return r.stdout.decode('utf-8', 'replace')

    def runb(self, cmd, timeout=60):
        return self._ssh(cmd, timeout).stdout

    def put(self, data, path):
        self.run('cat > %s; sync' % shlex.quote(path), input=data, timeout=120)

    def alive(self):
        try:
            return subprocess.run(['ssh'] + SSH_OPTS + [self.host, 'true'], capture_output=True,
                                  timeout=15).returncode == 0
        except subprocess.TimeoutExpired:
            return False

    def wait_alive(self, timeout=240):
        t0 = time.time()
        while time.time() - t0 < timeout:
            if self.alive():
                return
            time.sleep(3)
        raise StandError('%s: нет ssh %d с после включения' % (self.name, timeout))

    def power_cycle(self, off_s=15):
        p = self.cfg['power']
        if p.get('kind') != 'tapo':
            raise StandError('%s: неизвестное управление питанием %r' % (self.name, p))
        r = subprocess.run([sys.executable, self.tools['tapo'], p['addr'], 'cycle', str(off_s)],
                           capture_output=True, timeout=120)
        if r.returncode != 0:
            raise StandError('%s: power-cycle не удался: %s' % (self.name, r.stderr.decode()[-300:]))

    # --- wil6210 ---
    def iface(self):
        m = re.search(r'Interface (\S+)', self.run('iw dev', check=False))
        return m.group(1) if m else None

    def debugfs(self):
        d = self.run('ls -d /sys/kernel/debug/ieee80211/phy*/wil6210 2>/dev/null | head -1', check=False).strip()
        if not d:
            raise StandError('%s: нет debugfs wil6210' % self.name)
        return d

    def blob(self, name):
        return self.runb('cat %s/blob_%s' % (self.debugfs(), name))

    def dmesg(self):
        return self.run('dmesg', check=False)

    @staticmethod
    def _ktime(line):
        m = re.match(r'\[\s*(\d+\.\d+)\]', line)
        return float(m.group(1)) if m else None

    def mark(self):
        """Отметка начала роли (время ядра последней строки dmesg): дальше dmesg_new()/fw_errors() — только новые
        строки. По времени, не по числу строк: кольцо dmesg долгоживущего узла заполнено и сдвигается."""
        ts = [t for t in map(self._ktime, self.dmesg().splitlines()) if t is not None]
        self.dmesg_mark = ts[-1] if ts else 0

    def dmesg_new(self):
        return '\n'.join(l for l in self.dmesg().splitlines() if (self._ktime(l) or 0) > self.dmesg_mark)

    def fw_errors(self):
        return len(re.findall(r'error detected|Firmware error', self.dmesg_new()))

    def wmi_send(self, cmdid, payload=b'', mid=0):
        """Команда WMI через debugfs wmi_send драйвера (заголовок: mid, rsv, id, timestamp)."""
        data = struct.pack('<BBHI', mid, 0, cmdid, 0) + payload
        self.run('cat > %s/wmi_send' % self.debugfs(), input=data)

    def mbox_events(self):
        """[(id, тело без 8 Б заголовка WMI)] событий из кольца rx debugfs mbox (FW → хост)."""
        txt = self.run('cat %s/mbox' % self.debugfs(), check=False)
        txt = txt[txt.find('ring rx'):]
        out = []
        for m in re.finditer(r'\[\s*\d+\]\s+\S+\s+0x[0-9a-f]+ -> [^\n]*\n((?:\s+: [0-9a-f ]+\n)+)', txt):
            b = bytes.fromhex(''.join(l.split(':', 1)[1] for l in m.group(1).splitlines()))
            if len(b) >= 8:
                out.append((struct.unpack_from('<H', b, 2)[0], b[8:]))
        return out

    def fw_log(self, image=None):
        """Журнал fw (кольцо в blob_fw_peri), строки в хронологии; image — образ для своих строк SparRAW."""
        import fwlog
        recs = fwlog.decode(self.blob('fw_peri'), tab=fwlog.load_strings(image))
        return [line for _, line in fwlog.chrono(recs)]

    def load_driver(self, ko_path):
        self.put(open(ko_path, 'rb').read(), '/tmp/drv.ko')
        self.run('rmmod wil6210; insmod /tmp/drv.ko', timeout=60)


# ============================== стенд ==============================

class Stand:
    """Роли: 'sta' — dut станция у точки peer; 'ap' — dut точка, peer станция (тот же образ)."""

    def __init__(self, cfg, fw_path, ko_path=None, peer_fw_path=None):
        tools = dict(cfg.get('tools', {}))
        tools['tapo'] = os.path.normpath(os.path.join(REWRITE, tools.get('tapo', '../../SparRAW-tools/host/tapo_plug.py')))
        self.cfg = cfg
        self.t = cfg.get('test', {})
        self.dut = Node('dut', cfg['dut'], tools)
        self.peer = Node('peer', cfg['peer'], tools)
        self.fw_path = fw_path
        self.fw = open(fw_path, 'rb').read()
        self.ko = ko_path
        self.peer_fw = open(peer_fw_path, 'rb').read() if peer_fw_path else self.fw
        self.role = None
        self.peer_dirty = False
        for n in (self.dut, self.peer):
            n.on_recover = self._node_recovered

    def _node_recovered(self, node):
        """Узел перезагружен по питанию — роль стенда потеряна (следующая фикстура роли загрузит её заново).
        peer после перезагрузки поднимается со своим сохранённым режимом и залитым файлом прошивки — его точку
        (прошивка fw_backup, SSID, адрес) надо восстановить."""
        self.role = None
        if node is self.peer:
            self.peer_dirty = True

    # --- общие шаги ---
    def _peer_restore_ap(self):
        """peer — снова точка на своей прошивке (fw_backup), SSID стенда, адрес и сервер iperf3. После роли станции
        на тестируемом образе — через перезагрузку по питанию: перезапуска wifi мало (станция dut потом раз за
        разом не слышала маяк точки, «link up: no beacon from peer»)."""
        p, c = self.peer, self.cfg['peer']
        if self.peer_dirty and c.get('fw_backup'):
            p.run('cp %s /lib/firmware/wil6210.fw; sync' % c['fw_backup'], check=False)
        if self.peer_dirty and 'power' in c:
            p.power_cycle()
            time.sleep(25)
            p.wait_alive()
        p.run("killall iperf3 2>/dev/null; for i in $(iw dev | sed -n 's/.*Interface //p'); do ip addr flush dev $i; done; "
              "uci set wireless.default_radio0.mode=ap; uci set wireless.default_radio0.network=lan; "
              "uci set wireless.default_radio0.ssid=%s; fw4 reload; wifi down; sleep 2; wifi up radio0; sleep 5; "
              "ip addr show br-lan | grep -q %s || ip addr add %s/24 dev br-lan; "
              "sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2; iperf3 -s -D"
              % (c['ssid'], c['ip'], c['ip']), check=False, timeout=90)
        self.peer_dirty = False

    def _dut_boot(self):
        d = self.dut
        d.put(self.fw, '/lib/firmware/wil6210.fw')   # завис — _ssh перезагрузит узел и повторит
        d.power_cycle()
        time.sleep(25)
        d.wait_alive()
        if self.ko:
            d.load_driver(self.ko)

    def _wait(self, node, cond_cmd, timeout):
        t0 = time.time()
        while time.time() - t0 < timeout:
            if node.run(cond_cmd, check=False).strip():
                return True
            time.sleep(3)
        return False

    # --- роли ---
    def boot_sta(self, timeout=90):
        p, c = self.peer, self.cfg['peer']
        if self.peer_dirty or p.run('iw dev | grep -c "type AP"', check=False).strip() == '0':
            self._peer_restore_ap()
        # точка может держать зависшую запись станции и не слать маяки — перезапуск wifi параллельно загрузке dut
        p.run('iw dev $(iw dev | sed -n "s/.*Interface //p" | head -1) station del %s' % self.cfg['dut']['mac'], check=False)
        p.run('wifi down; sleep 2; wifi up; sleep 3; ip addr show br-lan | grep -q %s || ip addr add %s/24 dev br-lan; '
              'killall iperf3 2>/dev/null; iperf3 -s -D' % (c['ip'], c['ip']), check=False, timeout=60)
        self._dut_boot()
        d = self.dut
        d.run('uci set wireless.radio0.disabled=0; uci set wireless.default_radio0.disabled=0; '
              'uci set wireless.default_radio0.mode=sta; uci set wireless.default_radio0.ssid=%s; wifi up radio0 >/dev/null 2>&1'
              % c['ssid'], check=False)
        if not self._wait(d, "dmesg | grep -m1 'FW ready after'", 60):
            raise StandError('dut: FW не готова')
        p.mark()
        self.role = 'sta'
        self.connected = self._wait(d, 'iw dev %s link 2>/dev/null | grep Connected' % (d.iface() or 'x'), timeout)
        if self.connected:
            d.run('ip addr add %s/24 dev %s 2>/dev/null; sysctl -qw net.ipv4.conf.all.arp_ignore=1 '
                  'net.ipv4.conf.all.arp_announce=2' % (self.cfg['dut']['ip'], d.iface()), check=False)
        return self.connected

    def boot_ap(self, timeout=120):
        p, d = self.peer, self.dut
        ap_ssid = self.t.get('ap_ssid', 'SPARRAW-TEST')
        # peer — станция на тестируемом образе
        p.put(self.peer_fw, '/lib/firmware/wil6210.fw')
        self.peer_dirty = True
        p.run('killall iperf3 2>/dev/null; wifi down; sleep 2; uci set wireless.default_radio0.mode=sta; '
              'uci delete wireless.default_radio0.network; uci set wireless.default_radio0.ssid=%s; '
              'ip addr del %s/24 dev br-lan; wifi up radio0' % (ap_ssid, self.cfg['peer']['ip']), check=False, timeout=60)
        self._dut_boot()
        d.run('uci set wireless.radio0.disabled=0; uci set wireless.default_radio0.disabled=0; '
              'uci set wireless.default_radio0.mode=ap; uci set wireless.default_radio0.ssid=%s; wifi up radio0 >/dev/null 2>&1'
              % ap_ssid, check=False)
        if not self._wait(d, "dmesg | grep -m1 'FW ready after'", 60):
            raise StandError('dut: FW не готова')
        p.mark()
        self.role = 'ap'
        self.connected = self._wait(d, 'iw dev %s station dump 2>/dev/null | grep Station' % (d.iface() or 'x'), timeout)
        if self.connected:
            di, pi = d.iface(), p.iface()
            d.run('ip addr add %s/24 dev %s 2>/dev/null; nft insert rule inet fw4 input iifname %s accept; '
                  'sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2; killall iperf3 2>/dev/null; iperf3 -s -D'
                  % (self.cfg['dut']['ip'], di, di), check=False)
            p.run('sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2; ip addr add %s/24 dev %s 2>/dev/null; '
                  'nft insert rule inet fw4 input iifname %s accept; ip neigh flush dev %s'
                  % (self.cfg['peer']['ip'], pi, pi, pi), check=False)
        return self.connected

    def linked(self):
        """Связь в текущей роли жива (станция подключена / у точки есть станция)."""
        try:
            d = self.dut
            if self.role == 'sta':
                return 'Connected' in d.run('iw dev %s link' % d.iface(), check=False)
            if self.role == 'ap':
                return 'Station' in d.run('iw dev %s station dump' % d.iface(), check=False)
        except Exception:
            pass
        return False

    def ensure_booted(self, role):
        """Узлы загружены в роли role (связь может не установиться)."""
        if self.role != role:
            (self.boot_sta if role == 'sta' else self.boot_ap)()

    def ensure(self, role):
        """Стенд в роли role со связью; иначе — загрузка в эту роль (предыдущий тест мог оборвать связь)."""
        if self.role != role or not self.linked():
            (self.boot_sta if role == 'sta' else self.boot_ap)()
        return self.connected

    def teardown(self):
        if self.peer_dirty:
            self._peer_restore_ap()

    # --- измерения ---
    def client_server(self):
        """(клиент, адрес сервера): станция всегда клиент iperf3/ping к точке."""
        if self.role == 'ap':
            return self.peer, self.cfg['dut']['ip']
        return self.dut, self.cfg['peer']['ip']

    def ping(self, n=15):
        cl, ip = self.client_server()
        out = cl.run('ping -q -c %d -i 1 -W 1 %s 2>&1 | tail -2' % (n, ip), check=False, timeout=n + 30)
        m = re.search(r'(\d+) packets received', out)
        return int(m.group(1)) if m else 0

    def iperf(self, seconds=8, reverse=False):
        """Мбит/с: reverse=False — от станции к точке (up), True — к станции (down)."""
        cl, ip = self.client_server()
        out = cl.run('iperf3 -c %s -t %d -f m %s 2>&1' % (ip, seconds, '-R' if reverse else ''),
                     check=False, timeout=seconds + 40)
        m = re.findall(r'([\d.]+) Mbits/sec\s+\S*\s*(sender|receiver)', out)
        want = 'receiver' if reverse else 'sender'
        v = [float(x) for x, k in m if k == want]
        return v[-1] if v else 0.0

    def disconnects(self, node=None):
        return re.findall(r'wmi_evt_disconnect: Disconnect [^\n]*', (node or self.dut).dmesg())
