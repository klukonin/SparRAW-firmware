# SPDX-License-Identifier: AGPL-3.0-or-later
"""Подготовка узла стенда: смена прошивки, драйвера и роли — только перезагрузкой устройства (docs/STAND.md).

Одна схема для всех (pytest-стенд tests/stand.py, ручные записи tools/stand/*.sh):

  1. файлы: /lib/firmware/wil6210.fw и /lib/modules/$(uname -r)/wil6210.ko (если заданы) — запись во временный
     файл, mv, sync, сверка md5 до перезагрузки;
  2. роль в uci: опции прошлого сценария возвращаются к исходным значениям (/etc/sparraw-stand.uci), затем
     mode/ssid/network/disabled=0, затем команды uci сценария (опции hostapd и т. п.) → uci commit;
  3. параметры модуля wil6210, нужные с самого старта (no_fw_recovery=Y), — строка «options wil6210 …» в
     /etc/modules.conf с меткой (kmodloader читает её при загрузке модуля); без параметров строка удаляется;
  4. sync; sleep 1; sync → reboot → ожидание ssh с новым boot_id;
  5. проверки: строка версии fw (wmi_evt_ready «FW ver. …»), md5 fw/модуля/платы, интерфейс в нужной роли, у
     станции — связь с точкой.

Никаких rmmod/insmod/wifi down/up: rmmod после работы Wi-Fi висел в D, netifd после wifi down/up на перенастроенном
узле терял PHY, после insmod интерфейс переименовывался в phy1-*. Питание снимается только если узел не отвечает
по ssh после перезагрузки, не больше одного раза (колбэк power решает, разрешено ли ещё).

Узел — объект с полем name и методом sh(cmd, timeout, input=None) -> (rc | None при зависании, stdout, stderr):
одна попытка ssh без самовосстановления. CLI — tools/stand/node_boot.sh.
"""
import hashlib, re, shlex, struct, subprocess, sys, time

STATE_UCI = '/etc/sparraw-stand.uci'      # «ключ=исходное значение» / «ключ» (не было) опций сценария: откат
STATE_SIG = '/etc/sparraw-stand.sig'      # подпись подготовленного состояния (matches())
MODCONF = '/etc/modules.conf'
MODMARK = '# sparraw-stand'
FW = '/lib/firmware/wil6210.fw'
KO = '/lib/modules/$(uname -r)/wil6210.ko'
BRD = '/lib/firmware/wil6210.brd'
RADIO = 'wireless.radio0'
IFACE = 'wireless.default_radio0'

# Время (с): узел wAP 60G грузится ~60–90 с
BOOT_TIMEOUT = 300        # от reboot до ssh с новым boot_id
REBOOT_HANG = 120         # узел отвечает со старым boot_id дольше — reboot завис (процесс в D), один «reboot -f»
FW_TIMEOUT = 120          # от ssh до wmi_evt_ready
IFACE_TIMEOUT = 60        # от wmi_evt_ready до интерфейса в нужной роли
LINK_TIMEOUT = 120        # станция: до «Connected»

_sleep = time.sleep       # подменяются в юнит-тесте
_now = time.monotonic


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


def md5(b):
    return hashlib.md5(b).hexdigest()


# ============================== описание роли ==============================

class Spec:
    """Что должно быть на узле после перезагрузки.

    role      'ap' | 'sta'
    ssid      SSID точки (своей или к которой идёт станция)
    network   None — не трогать wireless.default_radio0.network, '' — удалить, иначе — имя сети uci (точка: lan)
    fw        образ .fw (bytes) или None — не менять
    fw_node   путь к образу на самом узле (копия на место, напр. fw_backup peer) — вместо fw
    ko        модуль wil6210.ko (bytes) или None — не менять
    uci       команды uci сценария (список строк «uci set …»), применяются после роли, до commit; исходные
              значения ключей «uci set» запоминаются, следующая подготовка их возвращает (или удаляет ключ, которого
              не было) — опция сценария не переживает его
    modparams параметры модуля wil6210 с самого старта («no_fw_recovery=Y») или None
    brd_md5   ожидаемый md5 платы (можно префикс от 8 знаков) или None
    wait_link станция: ждать связь с точкой при проверке
    """

    def __init__(self, role, ssid, network=None, fw=None, fw_node=None, ko=None, uci=(), modparams=None,
                 brd_md5=None, wait_link=True, link_timeout=LINK_TIMEOUT):
        if role not in ('ap', 'sta'):
            raise StandError('роль %r: нужна ap или sta' % role)
        if fw is not None and fw_node:
            raise StandError('fw и fw_node вместе')
        self.role, self.ssid, self.network = role, ssid, network
        self.fw, self.fw_node, self.ko = fw, fw_node, ko
        self.uci = list(split_uci(uci))
        self.modparams = modparams or None
        self.brd_md5 = brd_md5 or None
        self.wait_link, self.link_timeout = wait_link, link_timeout

    @property
    def fw_ver(self):
        return fw_version(self.fw) if self.fw else None


UCI_ALLOWED = re.compile(r'^uci\s+(?:-q\s+)?(set|delete|add_list|del_list)\s+([A-Za-z0-9_]+)\.([^\s=]+)(?:=|\s|$)')
UCI_SET_KEY = re.compile(r'^uci\s+(?:-q\s+)?set\s+([A-Za-z0-9_]+\.[A-Za-z0-9_@\[\]\-]+(?:\.[A-Za-z0-9_\-]+)?)=')


def split_uci(cmds):
    """Команды uci сценария: строка «a; b» или список. Только uci set/delete/add_list/del_list — ни commit (его
    делает подготовка), ни wifi/rmmod/reboot."""
    if isinstance(cmds, str):
        cmds = [cmds]
    for c in cmds:
        for part in (c or '').split(';'):
            part = part.strip()
            if not part:
                continue
            if not UCI_ALLOWED.match(part):
                raise StandError('команда сценария «%s»: разрешены только uci set/delete/add_list/del_list' % part)
            yield part


def uci_configs(cmds):
    return sorted({UCI_ALLOWED.match(c).group(2) for c in cmds})


def uci_set_keys(cmds):
    return [m.group(1) for m in map(UCI_SET_KEY.match, cmds) if m]


def signature(spec, fw_md5, ko_md5):
    """Подпись состояния: роль, SSID, сеть, команды сценария, параметры модуля, md5 образа и модуля."""
    s = '|'.join([spec.role, spec.ssid, repr(spec.network), ';'.join(spec.uci), spec.modparams or '',
                  fw_md5 or '-', ko_md5 or '-'])
    return md5(s.encode())


# ============================== команды на узле ==============================

def uci_script(spec, sig):
    """Скрипт роли: вернуть опции прошлого сценария, выставить роль и опции сценария (запомнив их исходные
    значения), commit, параметры модуля, подпись, sync. Последняя строка вывода — PREPARED."""
    q = shlex.quote
    L = ['if [ -f %s ]; then while IFS= read -r l; do [ -n "$l" ] || continue; k=${l%%%%=*}; '
         'if [ "$k" != "$l" ]; then uci set "$l"; else uci -q delete "$k"; fi; uci commit "${k%%%%.*}"; '
         'done < %s; rm -f %s; fi' % (STATE_UCI, STATE_UCI, STATE_UCI),
         'uci set %s.disabled=0' % RADIO,
         'uci set %s.disabled=0' % IFACE,
         'uci set %s.mode=%s' % (IFACE, spec.role),
         'uci set %s.ssid=%s' % (IFACE, q(spec.ssid))]
    if spec.network == '':
        L.append('uci -q delete %s.network' % IFACE)
    elif spec.network is not None:
        L.append('uci set %s.network=%s' % (IFACE, q(spec.network)))
    keys = uci_set_keys(spec.uci)
    if keys:
        L.append(': > %s.new' % STATE_UCI)
        L += ["if v=$(uci -q get %s); then printf '%%s=%%s\\n' %s \"$v\"; else printf '%%s\\n' %s; fi >> %s.new"
              % (q(k), q(k), q(k), STATE_UCI) for k in keys]
    L += spec.uci
    for cfg in sorted(set(['wireless'] + uci_configs(spec.uci))):
        L.append('uci commit %s || { echo "uci commit %s failed"; exit 3; }' % (cfg, cfg))
    if keys:
        L.append('mv -f %s.new %s' % (STATE_UCI, STATE_UCI))
    L.append("if [ -f %s ]; then sed -i '/%s$/d' %s; fi" % (MODCONF, MODMARK, MODCONF))
    if spec.modparams:
        L.append('echo %s >> %s' % (q('options wil6210 %s %s' % (spec.modparams, MODMARK)), MODCONF))
    L.append('echo %s > %s' % (sig, STATE_SIG))
    L += ['sync', 'sleep 1', 'sync', 'echo PREPARED']
    return '\n'.join(L) + '\n'


def put_cmd(path):
    """Запись stdin в path атомарно (временный файл, mv), sync, md5 записанного."""
    return ('P=%s; cat > "$P.new" && mv -f "$P.new" "$P" && sync && md5sum "$P"' % path)


FACTS_CMD = (
    'echo "ver=$(dmesg | sed -n \'s/.*FW ver\\. \\([^(]*\\)(.*/\\1/p\' | tail -1)"; '
    'echo "fwerr=$(dmesg | grep -c \'Firmware error\')"; '
    'echo "probe=$(dmesg | sed -n \'s/.*wil6210 \\(SparRAW-[^ ]*\\) device found.*/\\1/p\' | tail -1)"; '
    'echo "fw=$(md5sum %s 2>/dev/null | cut -d\' \' -f1)"; '
    'echo "ko=$(md5sum %s 2>/dev/null | cut -d\' \' -f1)"; '
    'echo "brd=$(md5sum %s 2>/dev/null | cut -d\' \' -f1)"; '
    'echo "sig=$(cat %s 2>/dev/null)"; '
    'echo "modconf=$(grep -c \'%s$\' %s 2>/dev/null)"; '
    'iw dev 2>/dev/null' % (FW, KO, BRD, STATE_SIG, MODMARK, MODCONF))

LINK_CMD = ('for I in $(iw dev | sed -n "s/.*Interface //p"); do iw dev $I link 2>/dev/null | grep -q Connected && '
            'echo $I; done')
FW_READY_CMD = "dmesg | grep -m1 -E 'FW ver\\. |Firmware error'"
BOOT_ID_CMD = 'cat /proc/sys/kernel/random/boot_id'


def _out(r):
    return r[1].decode('utf-8', 'replace') if isinstance(r[1], bytes) else (r[1] or '')


def _sh(node, cmd, timeout=60, input=None):
    """Команда, которая должна пройти: (rc 0) → stdout; иначе StandError (без перезагрузки)."""
    r = node.sh(cmd, timeout, input)
    if r[0] != 0:
        err = r[2].decode('utf-8', 'replace') if isinstance(r[2], bytes) else (r[2] or '')
        why = 'зависла %d с' % timeout if r[0] is None else 'код %s: %s' % (r[0], err.strip()[-200:])
        raise StandError('%s: «%s» — %s' % (node.name, cmd.splitlines()[0][:80], why))
    return _out(r)


def boot_id(node):
    r = node.sh(BOOT_ID_CMD, 15)
    return _out(r).strip() if r[0] == 0 else None


def _wait(cond, timeout, step=3):
    t0 = _now()
    while True:
        v = cond()
        if v:
            return v
        if _now() - t0 >= timeout:
            return None
        _sleep(step)


# ============================== шаги ==============================

def prepare(node, spec, log=None):
    """Файлы и роль на узле (без перезагрузки). Возвращает ожидаемые md5 {'fw', 'ko'}."""
    log = log or (lambda s: None)
    want = {'fw': None, 'ko': None}
    if spec.fw is not None:
        want['fw'] = md5(spec.fw)
        got = _sh(node, put_cmd(FW), 120, spec.fw).split()[:1]
        if got != [want['fw']]:
            raise StandError('%s: md5 записанной прошивки %s, ожидается %s' % (node.name, got, want['fw']))
        log('%s: прошивка записана (%s)' % (node.name, want['fw'][:12]))
    elif spec.fw_node:
        want['fw'] = (_sh(node, 'md5sum %s' % shlex.quote(spec.fw_node)).split() or [None])[0]
        got = _sh(node, 'cp %s %s.new && mv -f %s.new %s && sync && md5sum %s'
                  % (shlex.quote(spec.fw_node), FW, FW, FW, FW)).split()[:1]
        if got != [want['fw']]:
            raise StandError('%s: md5 прошивки после копии %s: %s, ожидается %s' % (node.name, spec.fw_node, got,
                                                                                   want['fw']))
        log('%s: прошивка из %s (%s)' % (node.name, spec.fw_node, want['fw'][:12]))
    if spec.ko is not None:
        want['ko'] = md5(spec.ko)
        got = _sh(node, put_cmd(KO), 120, spec.ko).split()[:1]
        if got != [want['ko']]:
            raise StandError('%s: md5 записанного модуля %s, ожидается %s' % (node.name, got, want['ko']))
        log('%s: модуль записан (%s)' % (node.name, want['ko'][:12]))
    out = _sh(node, uci_script(spec, signature(spec, want['fw'], want['ko'])), 60)
    if 'PREPARED' not in out:
        raise StandError('%s: роль в uci не записана: %s' % (node.name, out[-300:]))
    log('%s: роль %s, SSID %s — в uci (commit)' % (node.name, spec.role, spec.ssid))
    return want


def reboot(node, log=None):
    """sync и reboot. Возвращает boot_id до перезагрузки (ожидание — wait_up)."""
    old = boot_id(node)
    node.sh('sync; sleep 1; sync; reboot', 20)
    (log or (lambda s: None))('%s: reboot' % node.name)
    return old


def wait_up(node, old_id, power=None, log=None, timeout=BOOT_TIMEOUT):
    """Ждать ssh с новым boot_id. Узел отвечает со старым дольше REBOOT_HANG — один «sync; reboot -f». Не отвечает к
    концу timeout — power(why) (одно снятие питания; колбэк сам решает, разрешено ли, и бросает StandError, если
    нет), затем ещё timeout; дальше — StandError. Без power — StandError сразу."""
    log = log or (lambda s: None)
    t0, forced, cur = _now(), False, None
    while True:
        cur = boot_id(node)
        if cur and cur != old_id:
            log('%s: загрузился (%d с)' % (node.name, _now() - t0))
            return
        if cur and cur == old_id and not forced and _now() - t0 >= REBOOT_HANG:
            log('%s: отвечает со старым boot_id %d с — reboot завис, sync; reboot -f' % (node.name, _now() - t0))
            node.sh('sync; sleep 1; sync; reboot -f', 20)
            forced = True
        if _now() - t0 >= timeout:
            break
        _sleep(5)
    if cur:
        raise StandError('%s: не перезагрузился за %d с (ssh отвечает, boot_id прежний; reboot -f не помог) — '
                         'питание не снимается, узел отвечает; проверить вручную (ps, dmesg)' % (node.name, timeout))
    why = 'нет ssh %d с после reboot' % timeout
    if power is None:
        raise StandError('%s: %s; питание не снимается (не задано управление питанием) — проверить узел вручную'
                         % (node.name, why))
    power(why)
    t0 = _now()
    while _now() - t0 < timeout:
        cur = boot_id(node)
        if cur and cur != old_id:
            log('%s: загрузился после снятия питания (%d с)' % (node.name, _now() - t0))
            return
        _sleep(5)
    raise StandError('%s: нет ssh и после снятия питания (%d с) — дальше питание не снимается, проверить узел '
                     'вручную (failsafe, загрузка по сети)' % (node.name, timeout))


class Report:
    """Итог проверки узла: facts — разобранные значения, problems — несоответствия (текст), kinds — их виды
    ('fw' — FW не загрузилась, 'md5' — на узле не те файлы, 'ver', 'iface', 'link', 'brd', 'fwerr'), iface, link."""
    HARD = ('fw', 'md5')     # проверяемый объект не тот или не загрузился — дальнейшие тесты ничего не скажут

    def __init__(self):
        self.facts, self.problems, self.kinds, self.iface, self.link = {}, [], set(), None, False

    def add(self, kind, msg):
        self.kinds.add(kind)
        self.problems.append(msg)

    @property
    def ok(self):
        return not self.problems

    @property
    def hard(self):
        return bool(self.kinds & set(self.HARD))

    def line(self, name):
        f = self.facts
        s = '%s: fw %s md5 %s ko %s brd %s iface %s %s FWERR %s' % (
            name, f.get('ver') or '?', (f.get('fw') or '-')[:12], (f.get('ko') or '-')[:12], (f.get('brd') or '-')[:12],
            self.iface or '-', f.get('type') or '-', f.get('fwerr'))
        if f.get('type') == 'managed':
            s += ' link %s' % ('да' if self.link else 'нет')
        return s + ('' if self.ok else ' — ' + '; '.join(self.problems))


def facts(node):
    """Разбор FACTS_CMD: ключи ver/fwerr/probe/fw/ko/brd/sig/modconf; ifaces — [(имя, тип)], iface/type — первый."""
    out = _out(node.sh(FACTS_CMD, 30))
    f = dict(re.findall(r'^(\w+)=(.*)$', out, re.M))
    f['ifaces'] = re.findall(r'Interface (\S+)\n(?:[ \t]+(?!type ).*\n)*?[ \t]+type (\S+)', out)
    f['iface'], f['type'] = f['ifaces'][0] if f['ifaces'] else (None, None)
    return f


def role_type(spec):
    return 'AP' if spec.role == 'ap' else 'managed'


def pick_iface(f, spec):
    """Интерфейс роли spec (не монитор захвата): (имя, тип) или первый."""
    for name, typ in f.get('ifaces', []):
        if typ == role_type(spec):
            return name, typ
    return f.get('iface'), f.get('type')


def wait_fw(node, timeout=FW_TIMEOUT):
    """Ждать строку wmi_evt_ready («FW ver.») или «Firmware error» в dmesg текущей загрузки."""
    return bool(_wait(lambda: _out(node.sh(FW_READY_CMD, 15)).strip(), timeout))


def wait_iface(node, spec, timeout=IFACE_TIMEOUT):
    t = 'type %s' % role_type(spec)
    return bool(_wait(lambda: t in _out(node.sh('iw dev', 15)), timeout))


def verify(node, spec, want=None, log=None, link=None):
    """Проверки после загрузки. want — ожидаемые md5 из prepare() ({'fw', 'ko'}); link — ждать связь станции
    (по умолчанию spec.wait_link)."""
    log = log or (lambda s: None)
    want = want or {}
    rep = Report()
    if not wait_fw(node):
        rep.add('fw', 'нет wmi_evt_ready за %d с (FW не загрузилась)' % FW_TIMEOUT)
    if not wait_iface(node, spec):
        rep.add('iface', 'нет интерфейса type %s за %d с' % (role_type(spec), IFACE_TIMEOUT))
    if spec.role == 'sta' and (spec.wait_link if link is None else link):
        rep.link = bool(_wait(lambda: _out(node.sh(LINK_CMD, 15)).strip(), spec.link_timeout))
        if not rep.link:
            rep.add('link', 'станция не подключилась к %s за %d с' % (spec.ssid, spec.link_timeout))
    f = rep.facts = facts(node)
    rep.iface, f['type'] = pick_iface(f, spec)
    if not f.get('ver'):
        rep.add('fw', 'в dmesg нет «FW ver.» (wmi_evt_ready)')
    elif spec.fw_ver and f.get('ver') != spec.fw_ver:
        rep.add('ver', 'версия FW %r, ожидается %r' % (f.get('ver'), spec.fw_ver))
    for k in ('fw', 'ko'):
        if want.get(k) and f.get(k) != want[k]:
            rep.add('md5', 'md5 %s %s, ожидается %s' % (k, f.get(k), want[k]))
    if spec.brd_md5 and not (f.get('brd') or '').startswith(spec.brd_md5):
        rep.add('brd', 'md5 платы %s, ожидается %s' % (f.get('brd'), spec.brd_md5))
    if f.get('fwerr', '0') not in ('', '0'):
        rep.add('fwerr', 'Firmware error ×%s' % f['fwerr'])
    log(rep.line(node.name))
    return rep


def matches(node, spec, wait=0):
    """Узел уже в состоянии spec (подпись подготовки, md5 прошивки и модуля, FW загружена, интерфейс роли) —
    перезагрузка не нужна. wait — сколько ждать загрузки FW и интерфейса, если файлы и подпись сошлись (узел только
    что включился). Для fw/ko в виде bytes md5 считается здесь, для fw_node — на узле."""
    try:
        f = facts(node)
    except Exception:
        return False
    fw = md5(spec.fw) if spec.fw is not None else None
    if spec.fw_node:
        r = node.sh('md5sum %s' % shlex.quote(spec.fw_node), 15)
        fw = (_out(r).split() or [None])[0] if r[0] == 0 else None
        if not fw:
            return False
    ko = md5(spec.ko) if spec.ko is not None else None
    if not (f.get('sig') == signature(spec, fw, ko) and (fw is None or f.get('fw') == fw)
            and (ko is None or f.get('ko') == ko)):
        return False
    if wait and not (wait_fw(node, wait) and wait_iface(node, spec, wait)):
        return False
    f = facts(node)
    return pick_iface(f, spec)[1] == role_type(spec) and bool(f.get('ver'))


def boot(node, spec, power=None, log=None):
    """Вся схема на одном узле: prepare → reboot → wait_up → verify. Возвращает Report."""
    want = prepare(node, spec, log)
    old = reboot(node, log)
    wait_up(node, old, power, log)
    return verify(node, spec, want, log)


# ============================== CLI (tools/stand/node_boot.sh) ==============================

SSH_OPTS = ['-F', '/dev/null', '-o', 'StrictHostKeyChecking=no', '-o', 'UserKnownHostsFile=/dev/null',
            '-o', 'ConnectTimeout=8', '-o', 'LogLevel=ERROR']


class SshNode:
    def __init__(self, host, name=None):
        self.host, self.name = host, name or host

    def sh(self, cmd, timeout, input=None):
        try:
            r = subprocess.run(['ssh'] + SSH_OPTS + [self.host, cmd], capture_output=True, timeout=timeout,
                               input=input)
            return r.returncode, r.stdout, r.stderr
        except subprocess.TimeoutExpired:
            return None, b'', b''


def tapo_power(tool, addr, name, off_s=15):
    used = []

    def power(why):
        if used:
            raise StandError('%s: %s; питание уже снималось — больше не снимаю' % (name, why))
        used.append(why)
        sys.stderr.write('[node_boot] %s: %s — снятие питания (Tapo %s, %d с)\n' % (name, why, addr, off_s))
        r = subprocess.run([sys.executable, tool, addr, 'cycle', str(off_s)], capture_output=True, timeout=120)
        if r.returncode != 0:
            raise StandError('%s: снятие питания не удалось: %s' % (name, r.stderr.decode()[-300:]))
    return power


def main(argv=None):
    import argparse, os
    ap = argparse.ArgumentParser(prog='node_boot.sh', description=__doc__.split('\n')[0])
    ap.add_argument('host', help='root@192.168.1.11 или 192.168.1.11')
    ap.add_argument('--role', required=True, choices=('ap', 'sta'))
    ap.add_argument('--ssid', default='WL60TEST')
    ap.add_argument('--network', help="сеть uci интерфейса (точка — по умолчанию lan; '' — удалить)")
    ap.add_argument('--fw', help='образ .fw → /lib/firmware/wil6210.fw')
    ap.add_argument('--ko', help='модуль → /lib/modules/$(uname -r)/wil6210.ko')
    ap.add_argument('--uci', action='append', default=[], help='команды uci сценария через «;» (до commit)')
    ap.add_argument('--modparam', action='append', default=[], help='параметр wil6210 с самого старта, напр. '
                    'no_fw_recovery=Y (строка в /etc/modules.conf)')
    ap.add_argument('--brd-md5', default=os.environ.get('BRD_MD5') or None, help='ожидаемый md5 платы (префикс)')
    ap.add_argument('--no-link', action='store_true', help='станция: не ждать связь')
    ap.add_argument('--link-timeout', type=int, default=LINK_TIMEOUT)
    ap.add_argument('--tapo', help='адрес розетки Tapo: снять питание, если узел не отвечает после reboot (один раз)')
    ap.add_argument('--tapo-tool', default=os.environ.get('TAPO_TOOL') or os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                    '..', '..', '..', '..', 'SparRAW-tools', 'host', 'tapo_plug.py')))
    ap.add_argument('--no-reboot', action='store_true', help='только проверки (узел уже загружен)')
    a = ap.parse_args(argv)
    host = a.host if '@' in a.host else 'root@' + a.host
    network = a.network if a.network is not None else ('lan' if a.role == 'ap' else None)
    spec = Spec(a.role, a.ssid, network, fw=open(a.fw, 'rb').read() if a.fw else None,
                ko=open(a.ko, 'rb').read() if a.ko else None, uci=a.uci, modparams=' '.join(a.modparam) or None,
                brd_md5=a.brd_md5, wait_link=not a.no_link, link_timeout=a.link_timeout)
    node = SshNode(host, host.split('@')[-1])
    log = lambda s: print('[node_boot] ' + s, flush=True)
    power = tapo_power(a.tapo_tool, a.tapo, node.name) if a.tapo else None
    try:
        if a.no_reboot:
            rep = verify(node, spec, {'fw': md5(spec.fw) if spec.fw else None,
                                      'ko': md5(spec.ko) if spec.ko else None}, log)
        else:
            rep = boot(node, spec, power, log)
    except StandError as e:
        print('[node_boot] ОШИБКА: %s' % e, flush=True)
        return 3
    return 0 if rep.ok else 2


if __name__ == '__main__':
    sys.exit(main())
