# SPDX-License-Identifier: AGPL-3.0-or-later
"""Стенд для тестов прошивки: два узла OpenWrt с wil6210 (Sparrow), управление питанием, роли STA/AP.

Узлы описывает TOML-файл (tests/stand.example.toml): тестируемый узел (dut) и партнёр (peer). Партнёр в обычном
состоянии — точка доступа на своей (эталонной) прошивке; для теста AP роли меняются: dut — точка, peer — станция
на ТОМ ЖЕ тестируемом образе (vendor-станция 6.2 к точке по стандарту не идёт: B43 маяка, 9.3.4.2).

Драйвер wil6210 после загрузки системы не грузится сам (node_boot.sh --install): каждая итерация — перезагрузка
(sync; reboot -f), затем командой прошивка итерации в tmpfs (firmware_class.path), роль в uci без commit и один
network reload, insmod с параметрами итерации, network.wireless up radio0, проверки (docs/STAND.md,
tools/stand/nodeboot.py: в т. ч. прошивка стартовала один раз). Смена прошивки, модуля, роли — новая перезагрузка;
rmmod и wifi down/up/reload запрещены (nodeboot.check_cmd). Адреса 10.60.0.x, правила nft и сервер iperf3 —
командами после загрузки. Питание снимается только если узел не отвечает по ssh, не больше [test]
max_power_cycles раз за прогон (по умолчанию 1). Пропажа узла в тестах test_*_vanish — «sync; reboot -f»
(Node.vanish), не питание.
"""
import os, re, shlex, struct, subprocess, sys, time

HERE = os.path.dirname(os.path.abspath(__file__))
REWRITE = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(REWRITE, 'tools'))
sys.path.insert(0, os.path.join(REWRITE, 'tools', 'hwdbg'))
sys.path.insert(0, os.path.join(REWRITE, 'tools', 'stand'))

import nodeboot
from nodeboot import StandError, fw_records, fw_version   # noqa: F401 (часть интерфейса модуля: test_image, test_boot)

# Дополнительные команды uci для точки (обе роли: peer-AP и dut-AP), например
# SPARRAW_AP_UCI="uci set wireless.default_radio0.multicast_to_unicast=1" — проверка опций hostapd набором. Без commit:
# живут до перезагрузки узла.
AP_UCI = list(nodeboot.split_uci(os.environ.get('SPARRAW_AP_UCI', '')))

SSH_OPTS = nodeboot.SSH_OPTS


def fw_is_pro(blob):
    return '-PRO' in (fw_version(blob) or '').upper()


# ============================== узел ==============================

class Node:
    def __init__(self, name, cfg, tools, max_power_cycles=1):
        self.name = name
        self.host = cfg['host']
        self.cfg = cfg
        self.tools = tools
        self.on_recover = None     # колбэк стенда: узел перезагрузился — роль стенда потеряна
        self.recoveries = 0        # снятия питания по неответу (сводка pytest)
        self.max_power_cycles = max_power_cycles
        self.dmesg_mark = 0        # время ядра (dmesg) начала роли: ошибки FW считаются после него
        self.mark_boot = None
        self.iperf_cpu = None      # маска CPU для iperf3 (taskset), [test] iperf_cpu

    def sh(self, cmd, timeout, input=None):
        """Одна попытка ssh без самовосстановления: (код | None при зависании, stdout, stderr). Для nodeboot."""
        try:
            r = subprocess.run(['ssh'] + SSH_OPTS + [self.host, cmd], capture_output=True, timeout=timeout,
                               input=input)
            return r.returncode, r.stdout, r.stderr
        except subprocess.TimeoutExpired:
            return None, b'', b''

    def _ssh(self, cmd, timeout, input=None):
        """ssh. Узел не отвечает (ошибка соединения или зависание, при котором и ssh молчит) — recover() и одна
        повторная попытка. Зависла команда, а узел отвечает — StandError без перезагрузки и без снятия питания:
        следующая загрузка роли перезагрузит узел штатно."""
        for attempt in (0, 1):
            rc, out, err = self.sh(cmd, timeout, input)
            if rc is not None and rc != 255:
                return subprocess.CompletedProcess(cmd, rc, out, err)
            if rc is None:
                if self.alive():
                    raise StandError('%s: команда зависла (%d с): «%s» — узел отвечает по ssh, питание не снимается'
                                     % (self.name, timeout, cmd[:80]))
                why = 'зависание %d с, ssh не отвечает' % timeout
            else:
                why = 'ssh: %s' % err.decode('utf-8', 'replace').strip()[-120:]
            if attempt == 0:
                self.recover(why)
        raise StandError('%s: не отвечает и после восстановления (%s)' % (self.name, why))

    def recover(self, why):
        """Узел не отвечает по ssh: ждать (мог перезагрузиться сам — паника, сторож); не поднялся за 240 с — одно
        снятие питания (power_recover, в пределах [test] max_power_cycles), дальше StandError. Роль стенда
        сбрасывается (on_recover): следующая фикстура роли загрузит её заново."""
        sys.stderr.write('\n[стенд] %s: %s — жду ssh\n' % (self.name, why))
        if not self.wait_alive(240, fail=False):
            self.power_recover(why)
            if not self.wait_alive(300, fail=False):
                raise StandError('%s: нет ssh и после снятия питания — дальше питание не снимается; проверить узел '
                                 'вручную (failsafe, загрузка по сети)' % self.name)
        self.reset_mark()
        if self.on_recover:
            self.on_recover(self)

    def power_recover(self, why):
        """Снятие питания узла, который не отвечает по ssh (колбэк power для nodeboot.wait_up и recover). Не больше
        max_power_cycles раз за прогон: серия снятий питания 2026-11-07 оставила узел незагружаемым (восстановлен
        загрузкой по сети и sysupgrade)."""
        if self.recoveries >= self.max_power_cycles:
            raise StandError('%s: %s; питание за прогон уже снималось %d раз (предел [test] max_power_cycles = %d) — '
                             'больше не снимаю, чтобы не изнашивать флеш; проверить узел вручную'
                             % (self.name, why, self.recoveries, self.max_power_cycles))
        self.recoveries += 1
        sys.stderr.write('\n[стенд] %s: %s — снятие питания (%d из %d)\n'
                         % (self.name, why, self.recoveries, self.max_power_cycles))
        self.power_cycle()

    def run(self, cmd, timeout=60, check=True, input=None, allow_wifi_down=False):
        nodeboot.check_cmd(cmd, allow_wifi_down)   # rmmod, modprobe -r, wifi reload — никогда; wifi down — только test_ap_stop
        if self.iperf_cpu:   # iperf3 (сервер и клиент) — на своём ядре: на ядре прерываний wil6210 или RPS — до −25 %
            cmd = re.sub(r'(?<!killall )\biperf3 ', 'taskset %s iperf3 ' % self.iperf_cpu, cmd)
        r = self._ssh(cmd, timeout, input)
        if check and r.returncode != 0:
            raise StandError('%s: «%s» → %d: %s' % (self.name, cmd[:80], r.returncode,
                                                     r.stderr.decode('utf-8', 'replace')[-300:]))
        return r.stdout.decode('utf-8', 'replace')

    def runb(self, cmd, timeout=60):
        nodeboot.check_cmd(cmd)
        return self._ssh(cmd, timeout).stdout

    def put(self, data, path):
        self.run('cat > %s; sync' % shlex.quote(path), input=data, timeout=120)

    def alive(self):
        return self.sh('true', 15)[0] == 0

    def wait_alive(self, timeout=240, fail=True):
        t0 = time.time()
        while time.time() - t0 < timeout:
            if self.alive():
                return True
            time.sleep(3)
        if fail:
            raise StandError('%s: нет ssh %d с' % (self.name, timeout))
        return False

    def power_cycle(self, off_s=15):
        """Снятие питания (Tapo) — только power_recover (узел не отвечает по ssh). Для смены роли, прошивки,
        драйвера и для тестов пропажи — никогда (nodeboot.reboot, Node.vanish: reboot -f)."""
        p = self.cfg['power']
        if p.get('kind') != 'tapo':
            raise StandError('%s: неизвестное управление питанием %r' % (self.name, p))
        # перед снятием питания — сброс записей на флеш, если узел отвечает (2026-11-07 узел .12 после серии
        # power-cycle не грузился даже в failsafe; восстановлен загрузкой по сети и sysupgrade)
        self.sh('sync; sleep 1; sync', 15)
        r = subprocess.run([sys.executable, self.tools['tapo'], p['addr'], 'cycle', str(off_s)],
                           capture_output=True, timeout=120)
        if r.returncode != 0:
            raise StandError('%s: power-cycle не удался: %s' % (self.name, r.stderr.decode()[-300:]))

    def vanish(self):
        """Стимул тестов пропажи (test_*_vanish): узел исчезает из эфира без разъединения — «sync; reboot -f» по
        ssh. После загрузки драйвера нет — тест загружает его сам (Stand._peer_restore_ap, nodeboot.bring_up).
        busybox reboot -f (init/halt.c) делает sync и сразу системный вызов reboot, минуя procd: скрипты
        остановки, hostapd/wpa_supplicant и netifd не останавливаются, Deauth/Disassociation не уходят; у wil6210 нет
        .shutdown (pcie_bus.c), так что device_shutdown() ядра fw не трогает. Питание не снимается. Возвращает
        boot_id до перезагрузки — для nodeboot.wait_up()."""
        old = nodeboot.boot_id(self)
        self.sh('sync; sleep 1; sync; reboot -f', 15)
        return old

    def reset_mark(self):
        """Новая загрузка: dmesg_new()/fw_errors() — весь dmesg этой загрузки."""
        self.dmesg_mark = 0
        self.mark_boot = None

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

    def _boot_id(self):
        return self.run('cat /proc/sys/kernel/random/boot_id', check=False).strip()

    def mark(self):
        """Отметка начала роли (время ядра последней строки dmesg и идентификатор загрузки): дальше dmesg_new()/
        fw_errors() — только новые строки. По времени, не по числу строк: кольцо dmesg долгоживущего узла заполнено и
        сдвигается. Узел перезагрузился после отметки (другой boot_id) — новое всё: время ядра началось с нуля, и
        сравнение по времени прятало бы ошибки новой загрузки."""
        ts = [t for t in map(self._ktime, self.dmesg().splitlines()) if t is not None]
        self.dmesg_mark = ts[-1] if ts else 0
        self.mark_boot = self._boot_id()

    def dmesg_new(self):
        if getattr(self, 'mark_boot', None) and self._boot_id() != self.mark_boot:
            return self.dmesg()
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



# ============================== стенд ==============================

class Stand:
    """Роли: 'sta' — dut станция у точки peer; 'ap' — dut точка, peer станция (тот же образ). Каждая загрузка роли —
    перезагрузка узлов и загрузка драйвера командой (nodeboot): узел, перезагрузившийся сам или после снятия питания,
    поднимается без драйвера и без роли."""

    def __init__(self, cfg, fw_path, ko_path=None, peer_fw_path=None):
        tools = dict(cfg.get('tools', {}))
        tools['tapo'] = os.path.normpath(os.path.join(REWRITE, tools.get('tapo', '../../SparRAW-tools/host/tapo_plug.py')))
        self.cfg = cfg
        self.t = cfg.get('test', {})
        mpc = int(self.t.get('max_power_cycles', 1))
        self.dut = Node('dut', cfg['dut'], tools, mpc)
        self.peer = Node('peer', cfg['peer'], tools, mpc)
        self.fw_path = fw_path
        self.fw = open(fw_path, 'rb').read()
        self.ko = ko_path
        self.ko_blob = open(ko_path, 'rb').read() if ko_path else None
        self.peer_fw = open(peer_fw_path, 'rb').read() if peer_fw_path else self.fw
        self.role = None
        self.connected = False
        # перезагрузка узла: [test] reboot = "force" (sync; reboot -f мимо procd, по умолчанию) | "init" (nodeboot)
        self.reboot_mode = self.t.get('reboot', nodeboot.REBOOT_MODE)
        if self.reboot_mode not in nodeboot.REBOOT_CMDS:
            raise StandError('[test] reboot = %r: нужен %s'
                             % (self.reboot_mode, ' или '.join(sorted(nodeboot.REBOOT_CMDS))))
        # стартов прошивки за подъём роли, больше — ошибка «прошивка перезапускалась N раз» (nodeboot.verify)
        self.max_fw_starts = self.t.get('max_fw_starts')   # None — по роли (nodeboot.FW_STARTS_BY_ROLE)
        for n in (self.dut, self.peer):
            n.on_recover = self._node_recovered
            n.iperf_cpu = self.t.get('iperf_cpu')

    @staticmethod
    def log(s):
        sys.stderr.write('[стенд] %s\n' % s)

    def tune_cpu(self):
        """Прерывания wil6210 (tx/rx/misc, с ними NAPI) обоих узлов — на ядро [test] irq_cpu (маска). Без этого GIC
        доставляет их на cpu0. Стенд 2026-10-30 (iperf, вверх/вниз): cpu0 987/1009, cpu1 989/1013, ядро iperf 741/760,
        CPU3 830/840 — на CPU3 OpenWrt уже ведёт RPS интерфейса wifi (rps_cpus 8)."""
        m = self.t.get('irq_cpu')
        if not m:
            return
        for n in (self.dut, self.peer):
            n.run('for i in $(grep wil6210 /proc/interrupts | cut -d: -f1); do echo %s > /proc/irq/$i/smp_affinity; done'
                  % m, check=False)

    def _node_recovered(self, node):
        """Узел перезагрузился (сам или после снятия питания) — драйвера нет, роль потеряна: следующая фикстура
        роли загрузит её заново."""
        self.role = None

    # --- описания ролей (nodeboot.Spec) ---
    def _brd(self):
        return self.t.get('brd_md5') or None

    def _mp(self, *extra):
        """Параметры insmod узла на проверяемом образе: [test] modparams + extra."""
        return ' '.join([self.t.get('modparams', '')] + list(extra)).strip() or None

    def peer_ap_spec(self):
        """peer — точка на своей прошивке (fw_backup на узле, иначе /lib/firmware/wil6210.fw), SSID стенда, сеть lan,
        опции SPARRAW_AP_UCI, параметры [peer] modparams."""
        c = self.cfg['peer']
        return nodeboot.Spec('ap', c['ssid'], 'lan', fw_node=c.get('fw_backup') or '/lib/firmware/wil6210.fw',
                             uci=AP_UCI, modparams=c.get('modparams'), brd_md5=self._brd(),
                             max_fw_starts=self.max_fw_starts)

    def dut_sta_spec(self, timeout=90):
        """dut — станция на проверяемом образе (и модуле --ko) у точки peer; сеть — [dut] sta_network (иначе не
        трогать)."""
        return nodeboot.Spec('sta', self.cfg['peer']['ssid'], self.cfg['dut'].get('sta_network'), fw=self.fw,
                             ko=self.ko_blob, modparams=self._mp(), brd_md5=self._brd(), link_timeout=timeout,
                             max_fw_starts=self.max_fw_starts)

    def peer_sta_spec(self, timeout=120):
        """peer — станция на проверяемом образе у точки dut; FW error не восстанавливать с самого старта
        (insmod … no_fw_recovery=Y): состояние fw на момент сбоя остаётся для артефактов."""
        return nodeboot.Spec('sta', self.t.get('ap_ssid', 'SPARRAW-TEST'), '', fw=self.peer_fw,
                             modparams=self._mp('no_fw_recovery=Y'), brd_md5=self._brd(), link_timeout=timeout,
                             max_fw_starts=self.max_fw_starts)

    def dut_ap_spec(self):
        return nodeboot.Spec('ap', self.t.get('ap_ssid', 'SPARRAW-TEST'), None, fw=self.fw, ko=self.ko_blob,
                             uci=AP_UCI, modparams=self._mp(), brd_md5=self._brd(),
                             max_fw_starts=self.max_fw_starts)

    @staticmethod
    def _hard(node, rep):
        """Проверяемый объект не загрузился или на узле не те файлы — StandError; остальное (версия, плата, связь,
        FW error) проверяют тесты."""
        if rep.hard:
            raise StandError('%s: %s' % (node.name, '; '.join(rep.problems)))
        return rep

    # --- общие шаги ---
    @staticmethod
    def _reach(*nodes):
        """Перед подготовкой роли узлы отвечают по ssh; нет — recover() (ожидание, не больше одного снятия питания)."""
        for n in nodes:
            if not n.alive():
                n.recover('нет ssh перед загрузкой роли')

    def _peer_ap_runtime(self):
        """Точка peer после загрузки: адрес стенда на br-lan, sysctl ARP, сервер iperf3 (команды, не перезапуск)."""
        c = self.cfg['peer']
        self.peer.run("ip addr show br-lan | grep -q 'inet %s/' || ip addr add %s/24 dev br-lan; "
                      "sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2; "
                      "killall iperf3 2>/dev/null; iperf3 -s -D" % (c['ip'], c['ip']), check=False, timeout=30)

    def _peer_restore_ap(self):
        """peer — точка на своей прошивке, SSID стенда, адрес и сервер iperf3. Уже так в этой загрузке (подпись в
        /tmp, md5, интерфейс AP) — ничего; драйвер не загружен (узел только что загрузился: reboot -f теста пропажи,
        перезапуск точки) — загрузить командой; загружено другое — перезагрузка и загрузка (rmmod нет)."""
        p, spec = self.peer, self.peer_ap_spec()
        self._reach(p)
        if not nodeboot.matches(p, spec, wait=nodeboot.FW_TIMEOUT):
            if nodeboot._q(p, nodeboot.LOADED_CMD).strip() == '0':
                rep = nodeboot.bring_up(p, spec, self.log)
            else:
                rep = nodeboot.boot(p, spec, p.power_recover, self.log, reboot_mode=self.reboot_mode)
            self._hard(p, rep)
            p.mark()
        self._peer_ap_runtime()

    def _wait(self, node, cond_cmd, timeout):
        t0 = time.time()
        while time.time() - t0 < timeout:
            if node.run(cond_cmd, check=False).strip():
                return True
            time.sleep(3)
        return False

    # --- роли ---
    def boot_sta(self, timeout=90):
        """dut — станция у точки peer: перезагрузка dut и загрузка драйвера с проверяемым образом в роли STA; peer,
        если в этой загрузке он не точка на своей прошивке, — перезагрузка параллельно и загрузка точки первой."""
        p, d = self.peer, self.dut
        self.role, self.connected = None, False
        pspec, dspec = self.peer_ap_spec(), self.dut_sta_spec(timeout)
        self._reach(p, d)
        peer_ok = nodeboot.matches(p, pspec)
        pold = None if peer_ok else nodeboot.reboot(p, self.log, self.reboot_mode)
        dold = nodeboot.reboot(d, self.log, self.reboot_mode)
        if not peer_ok:
            nodeboot.wait_up(p, pold, p.power_recover, self.log)
            self._hard(p, nodeboot.bring_up(p, pspec, self.log))
        self._peer_ap_runtime()
        # точка может держать запись станции dut прошлой загрузки (vendor-точка с зависшей записью переставала слать
        # маяки) — снять, пока dut перезагружается
        p.run('iw dev $(iw dev | sed -n "s/.*Interface //p" | head -1) station del %s' % self.cfg['dut']['mac'],
              check=False)
        nodeboot.wait_up(d, dold, d.power_recover, self.log)
        d.reset_mark()
        p.mark()
        rep = self._hard(d, nodeboot.bring_up(d, dspec, self.log))
        self.role = 'sta'
        self.connected = rep.link
        if self.connected:
            d.run('ip addr add %s/24 dev %s 2>/dev/null; sysctl -qw net.ipv4.conf.all.arp_ignore=1 '
                  'net.ipv4.conf.all.arp_announce=2' % (self.cfg['dut']['ip'], rep.iface), check=False)
            self.tune_cpu()
        return self.connected

    def boot_ap(self, timeout=120):
        """dut — точка на проверяемом образе, peer — станция на том же образе: оба узла перезагружаются параллельно,
        драйвер грузится командой — сначала точка, затем станция."""
        p, d = self.peer, self.dut
        self.role, self.connected = None, False
        pspec, dspec = self.peer_sta_spec(timeout), self.dut_ap_spec()
        self._reach(p, d)
        pold = nodeboot.reboot(p, self.log, self.reboot_mode)
        dold = nodeboot.reboot(d, self.log, self.reboot_mode)
        nodeboot.wait_up(d, dold, d.power_recover, self.log)
        nodeboot.wait_up(p, pold, p.power_recover, self.log)
        d.reset_mark()
        p.reset_mark()               # станция на проверяемом образе: ошибки FW считаются с её загрузки
        drep = self._hard(d, nodeboot.bring_up(d, dspec, self.log))
        self._hard(p, nodeboot.bring_up(p, pspec, self.log, link=False))
        self.role = 'ap'
        di = drep.iface or d.iface() or 'x'
        self.connected = self._wait(d, 'iw dev %s station dump 2>/dev/null | grep Station' % di, timeout)
        if self.connected:
            pi = p.iface()
            d.run('ip addr add %s/24 dev %s 2>/dev/null; nft insert rule inet fw4 input iifname %s accept; '
                  'sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2; killall iperf3 2>/dev/null; iperf3 -s -D'
                  % (self.cfg['dut']['ip'], di, di), check=False)
            p.run('sysctl -qw net.ipv4.conf.all.arp_ignore=1 net.ipv4.conf.all.arp_announce=2; ip addr add %s/24 dev %s 2>/dev/null; '
                  'nft insert rule inet fw4 input iifname %s accept; ip neigh flush dev %s'
                  % (self.cfg['peer']['ip'], pi, pi, pi), check=False)
            self.tune_cpu()
        return self.connected

    def restart_peer(self):
        """Перезапуск точки peer (test_reconnect_after_peer_restart) — перезагрузкой устройства, затем драйвер точки
        командой, адрес и iperf3."""
        p = self.peer
        old = nodeboot.reboot(p, self.log, self.reboot_mode)
        nodeboot.wait_up(p, old, p.power_recover, self.log)
        self._peer_restore_ap()

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
        """peer — снова точка на своей прошивке (перезагрузкой, если он не в этой роли)."""
        try:
            self._peer_restore_ap()
        except StandError as e:
            sys.stderr.write('\n[стенд] peer не возвращён в роль точки: %s\n' % e)

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
