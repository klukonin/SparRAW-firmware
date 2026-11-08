# SPDX-License-Identifier: AGPL-3.0-or-later
"""Узел стенда: драйвер wil6210 грузится только командой, с прошивкой итерации; смена — только перезагрузкой
(docs/STAND.md).

Однократно (install, `node_boot.sh --install <host>`): автозагрузка wil6210 снимается — /etc/modules.d/wil6210 в
бэкап /etc/sparraw-stand.modules.d.wil6210. После загрузки системы драйвера нет; netifd без phy просто ждёт.

Итерация (boot): «sync; sleep 1; sync; reboot -f» (настройка reboot_mode: 'force' по умолчанию, 'init' — обычный
reboot через procd) → ssh с новым boot_id → проверка «wil6210 не загружен» → прошивка итерации в tmpfs
(/tmp/sparraw-fw/wil6210.fw, рядом копия платы /lib/firmware/wil6210.brd с проверкой md5), путь поиска прошивки
ядра firmware_class.path = /tmp/sparraw-fw (ищется ПЕРВЫМ: fw_path[] в drivers/base/firmware_loader/main.c), флеш не
трогается → роль в uci БЕЗ commit (дельта в /tmp/.uci: netifd читает её — libuci по умолчанию UCI_FLAG_SAVED_DELTA,
savedir /tmp/.uci; после перезагрузки узел чистый) + ОДИН `ubus call network reload` до insmod: netifd получает
роль, пока phy нет, его попытка setup кончается «PHY is undefined» и set_retry(false) — радио ждёт в down без
повторов, прошивку это не трогает → дождаться, пока netifd закончит (status radio0: pending false) → modprobe
cfg80211 → insmod <модуль> <параметры итерации> → появился phy, radio0 netifd указывает на него (config.path) →
`ubus call network.wireless up '{"device":"radio0"}'` (идемпотентно: start() при setup/up ничего не делает; тот
же подъём делает hotplug 10-wifi-detect вызовом network.wireless retry — кто первый, тот и поднял, второй — no-op).
`wifi up` НЕ используется: /sbin/wifi up = network.wireless down + network reload + up, то есть перезапуск
(teardown → setup), и в гонке с hotplug давал 4 старта прошивки подряд.
Проверки: radio0 up в netifd, версия fw в dmesg, прошивка стартовала ровно один раз («FW ver.» в dmesg — не больше
Spec.max_fw_starts), роль поднята один раз (wifi-scripts «Starting» ×1, «Tearing down» ×0, hostapd без AP-DISABLED),
/etc/config/wireless не изменился (commit не случился), md5 fw и модуля, плата, путь прошивки, интерфейс роли, у
станции — связь и ни одного Disconnect за STABLE_S секунд после неё.

Запрещено (check_cmd): rmmod, modprobe -r, wifi down/reload/up/reconf — смена прошивки, модуля и роли только новой
перезагрузкой. Питание снимается только если узел не отвечает по ssh после перезагрузки, не больше одного раза
(колбэк power решает, разрешено ли ещё).

Узел — объект с полем name и методом sh(cmd, timeout, input=None) -> (rc | None при зависании, stdout, stderr):
одна попытка ssh без самовосстановления. CLI — tools/stand/node_boot.sh.
"""
import hashlib, os, re, shlex, struct, subprocess, sys, time

FWDIR = '/tmp/sparraw-fw'                 # firmware_class.path итерации (tmpfs)
FW_TMP = FWDIR + '/wil6210.fw'
BRD_TMP = FWDIR + '/wil6210.brd'
DRVDIR = '/tmp/sparraw-drv'
KO_TMP = DRVDIR + '/wil6210.ko'           # свой модуль итерации (tmpfs)
KO_SYS = '/lib/modules/$(uname -r)/wil6210.ko'
BRD = '/lib/firmware/wil6210.brd'
FWPATH = '/sys/module/firmware_class/parameters/path'
SIG = '/tmp/sparraw-stand.sig'            # подпись загруженного состояния (matches()); пропадает с перезагрузкой
MODD = '/etc/modules.d/wil6210'
MODD_BAK = '/etc/sparraw-stand.modules.d.wil6210'
# прежняя схема (роль с commit, параметры в modules.conf) — install убирает её следы
LEGACY_UCI = '/etc/sparraw-stand.uci'
LEGACY_SIG = '/etc/sparraw-stand.sig'
MODCONF = '/etc/modules.conf'
MODMARK = '# sparraw-stand'
RADIO = 'wireless.radio0'
IFACE = 'wireless.default_radio0'
WCONF = '/etc/config/wireless'
WCONF_MD5 = '/tmp/sparraw-stand.wireless.md5'   # md5 закоммиченного wireless до подъёма (commit не должен случиться)

# Перезагрузка узла. 'force' (по умолчанию): busybox reboot -f (init/halt.c) — sync() и сразу системный вызов reboot,
# мимо procd: шаг shutdown inittab (/etc/init.d/rcS K shutdown — network stop → wifi teardown → hostapd снимает
# интерфейсы → wil_down с fw) не выполняется, зависнуть на остановке драйвера нечему. Флеш: перед вызовом
# «sync; sleep 1; sync» и sync() самого busybox; итерация на флеш ничего не пишет (роль — дельта в /tmp, прошивка —
# tmpfs). Ядро всё равно делает device_shutdown() (.shutdown драйверов; у wil6210 его нет). 'init' — обычный reboot
# (сигнал procd: shutdown-скрипты, SIGTERM/SIGKILL всем, sync, reboot) — на .11 7 раз за 2026-11-08 не вернулся.
REBOOT_CMDS = {'force': 'sync; sleep 1; sync; reboot -f', 'init': 'sync; sleep 1; sync; reboot'}
REBOOT_MODE = 'force'
MAX_FW_STARTS = None     # по роли: станция 1; точка 2 — hostapd поднимает интерфейс, перечитывает конфигурацию
                         # («Restart interface … new PHY») и поднимает снова: 2 старта fw за 0,4 с (стенд 2026-11-08)
FW_STARTS_BY_ROLE = {'sta': 1, 'ap': 2}

# Время (с): узел wAP 60G грузится ~60–90 с
BOOT_TIMEOUT = 300        # от reboot до ssh с новым boot_id
REBOOT_HANG = 120         # узел отвечает со старым boot_id дольше — reboot завис (процесс в D), один «reboot -f»
RCLOCAL_BAK = '/etc/sparraw-stand.rc.local'
RC_SETTLE = 120           # rc.local узла ждёт /sys/module/wil6210 до 60 с: insmod — после uptime RC_SETTLE
PHY_TIMEOUT = 30          # от insmod до /sys/class/ieee80211/phy*
FW_TIMEOUT = 120          # от wifi up до wmi_evt_ready
IFACE_TIMEOUT = 60        # от wmi_evt_ready до интерфейса в нужной роли
LINK_TIMEOUT = 120        # станция: до «Connected»
NETIFD_IDLE_TIMEOUT = 45  # от network reload до конца попытки setup без phy (таймаут скрипта netifd — 30 с)
UP_TIMEOUT = 90           # от network.wireless up до radio0 up в netifd
STABLE_S = 10             # после подъёма: окно без перезапусков fw/роли и без Disconnect станции

_sleep = time.sleep       # подменяются в юнит-тесте
_now = time.monotonic


class StandError(Exception):
    pass


# ============================== запреты ==============================

# /sbin/wifi (wifi-scripts): up и голый wifi = network.wireless down + network reload + up — перезапуск радио;
# reconf = reload + reconf; reload = network reload. Подъём итерации — только network.wireless up (load()).
FORBIDDEN = re.compile(r'\brmmod\b|\bmodprobe\b[^;&|]*\s-[a-z]*r|\bwifi\s+(down|reload|up|reconf)\b'
                       r'|(?:^|[;&|(])\s*wifi\s*(?:$|[;&|)])', re.M)


def check_cmd(cmd, allow_wifi_down=False):
    """Команда на узел не перезапускает драйвер: rmmod, modprobe -r, wifi up/reload/reconf — никогда; wifi down —
    только как предмет проверки (test_ap_stop), allow_wifi_down=True."""
    m = FORBIDDEN.search(cmd)
    if m and not (allow_wifi_down and re.fullmatch(r'wifi\s+down', m.group(0))):
        raise StandError('запрещённая команда «%s» в «%s»: смена драйвера, прошивки, роли — только перезагрузкой '
                         '(docs/STAND.md)' % (m.group(0), cmd[:80]))
    return cmd


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


# ============================== описание итерации ==============================

MODPARAM = re.compile(r'^[a-z_][a-z0-9_]*=[A-Za-z0-9_.,:-]+$')


class Spec:
    """Что загрузить на узле в этой итерации.

    role      'ap' | 'sta'
    ssid      SSID точки (своей или к которой идёт станция)
    network   None — не трогать wireless.default_radio0.network, '' — удалить, иначе — имя сети uci (точка: lan)
    fw        образ .fw (bytes) — или fw_node: путь к образу на самом узле (напр. fw_backup peer); одно из двух
              обязательно: прошивка итерации задаётся явно
    ko        свой модуль wil6210.ko (bytes) или None — модуль системы /lib/modules/$(uname -r)/wil6210.ko
    uci       команды uci сценария (список «uci set …»), применяются после роли, без commit
    modparams параметры insmod («no_fw_recovery=Y fw_log_level=7») или None
    brd_md5   ожидаемый md5 платы (можно префикс от 8 знаков) или None
    wait_link станция: ждать связь с точкой при проверке
    max_fw_starts  сколько стартов прошивки (wmi_evt_ready) допустимо за подъём роли; больше — ошибка «прошивка
              перезапускалась N раз при подъёме»
    """

    def __init__(self, role, ssid, network=None, fw=None, fw_node=None, ko=None, uci=(), modparams=None,
                 brd_md5=None, wait_link=True, link_timeout=LINK_TIMEOUT, max_fw_starts=MAX_FW_STARTS):
        if role not in ('ap', 'sta'):
            raise StandError('роль %r: нужна ap или sta' % role)
        if (fw is None) == (not fw_node):
            raise StandError('прошивка итерации: нужно ровно одно из fw (файл) и fw_node (путь на узле)')
        self.role, self.ssid, self.network = role, ssid, network
        self.fw, self.fw_node, self.ko = fw, fw_node, ko
        self.uci = list(split_uci(uci))
        mp = (modparams or '').split()
        bad = [p for p in mp if not MODPARAM.match(p)]
        if bad:
            raise StandError('параметры модуля %s: нужен вид имя=значение' % bad)
        self.modparams = ' '.join(mp) or None
        self.brd_md5 = brd_md5 or None
        self.wait_link, self.link_timeout = wait_link, link_timeout
        self.max_fw_starts = int(max_fw_starts) if max_fw_starts is not None else FW_STARTS_BY_ROLE[role]

    @property
    def fw_ver(self):
        return fw_version(self.fw) if self.fw else None


UCI_ALLOWED = re.compile(r'^uci\s+(?:-q\s+)?(set|delete|add_list|del_list)\s+([A-Za-z0-9_]+)\.([^\s=]+)(?:=|\s|$)')


def split_uci(cmds):
    """Команды uci сценария: строка «a; b» или список. Только uci set/delete/add_list/del_list — ни commit (роль
    живёт до перезагрузки), ни wifi/rmmod/reboot."""
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


def signature(spec, fw_md5, ko_md5):
    """Подпись итерации: роль, SSID, сеть, команды сценария, параметры модуля, md5 образа и модуля."""
    s = '|'.join([spec.role, spec.ssid, repr(spec.network), ';'.join(spec.uci), spec.modparams or '',
                  fw_md5 or '-', ko_md5 or '-'])
    return md5(s.encode())


# ============================== команды на узле ==============================

def uci_script(spec, sig):
    """Роль без commit (дельта в /tmp/.uci), md5 закоммиченного wireless (проверка «commit не случился»), один
    ubus call network reload — netifd берёт роль ДО появления phy (config_init → update → setup без phy →
    «PHY is undefined», set_retry(false): радио ждёт в down, прошивка не трогается; при подъёме после phy роль уже
    та); подпись итерации в /tmp. Последняя строка вывода — UCI_SET."""
    q = shlex.quote
    L = ['uci set %s.disabled=0' % RADIO,
         'uci set %s.disabled=0' % IFACE,
         'uci set %s.mode=%s' % (IFACE, spec.role),
         'uci set %s.ssid=%s' % (IFACE, q(spec.ssid))]
    if spec.network == '':
        L.append('uci -q delete %s.network' % IFACE)
    elif spec.network is not None:
        L.append('uci set %s.network=%s' % (IFACE, q(spec.network)))
    L += spec.uci
    L += ["md5sum %s | cut -d' ' -f1 > %s" % (WCONF, WCONF_MD5),
          'ubus call network reload', 'echo %s > %s' % (sig, SIG), 'echo UCI_SET']
    return '\n'.join(L) + '\n'


def install_script():
    """Однократно: снять автозагрузку wil6210 (бэкап), убрать следы прежней схемы (опции сценария с commit —
    вернуть исходные значения, подпись, параметры в modules.conf), сообщить, что ещё на узле упоминает wil6210."""
    return '\n'.join([
        'if [ -f %s ]; then [ -f %s ] || cp %s %s; rm -f %s; echo "AUTOLOAD_REMOVED"; fi' % (MODD, MODD_BAK, MODD,
                                                                                         MODD_BAK, MODD),
        'O=$(grep -lw wil6210 /etc/modules.d/* /etc/modules-boot.d/* 2>/dev/null); [ -z "$O" ] || echo "OTHER_AUTOLOAD $O"',
        'if [ -f %s ]; then while IFS= read -r l; do [ -n "$l" ] || continue; k=${l%%%%=*}; '
        'if [ "$k" != "$l" ]; then uci set "$l"; else uci -q delete "$k"; fi; uci commit "${k%%%%.*}"; '
        'done < %s; rm -f %s; echo "LEGACY_UCI_RESTORED"; fi' % (LEGACY_UCI, LEGACY_UCI, LEGACY_UCI),
        'rm -f %s' % LEGACY_SIG,
        "if [ -f %s ] && grep -q '%s$' %s; then sed -i '/%s$/d' %s; echo LEGACY_MODCONF_REMOVED; fi"
        % (MODCONF, MODMARK, MODCONF, MODMARK, MODCONF),
        'H=$(grep -rlw wil6210 /etc/hotplug.d /etc/hotplug.json 2>/dev/null); [ -z "$H" ] || echo "HOTPLUG $H"',
        # rc.local прошлой схемы ждал /sys/module/wil6210 и ставил параметры модуля — теперь они в insmod итерации
        'if grep -qw wil6210 /etc/rc.local 2>/dev/null; then [ -f %s ] || cp /etc/rc.local %s; '
        'printf "%%s\\n" "# стенд SparRAW: параметры драйвера 60 ГГц — при insmod итерации (rewrite/docs/STAND.md)" "exit 0" '
        '> /etc/rc.local; echo RCLOCAL_REPLACED; fi' % (RCLOCAL_BAK, RCLOCAL_BAK),
        'grep -qw wil6210 /etc/rc.local 2>/dev/null && echo RCLOCAL',
        'sync', 'echo INSTALLED']) + '\n'


def uninstall_script():
    return ('if [ -f %s ] && [ ! -f %s ]; then cp %s %s; fi; if [ -f %s ]; then cp %s /etc/rc.local && rm -f %s; fi; '
            'sync; echo UNINSTALLED\n' % (MODD_BAK, MODD, MODD_BAK, MODD, RCLOCAL_BAK, RCLOCAL_BAK, RCLOCAL_BAK))


def put_cmd(path):
    """Запись stdin в path атомарно (каталог, временный файл, mv), md5 записанного. Пути — в tmpfs."""
    return ('P=%s; mkdir -p "${P%%/*}" && cat > "$P.new" && mv -f "$P.new" "$P" && md5sum "$P"' % path)


LOADED_CMD = "grep -c '^wil6210 ' /proc/modules"
FACTS_CMD = (
    'echo "ver=$(dmesg | sed -n \'s/.*FW ver\\. \\([^(]*\\)(.*/\\1/p\' | tail -1)"; '
    'echo "fwerr=$(dmesg | grep -c \'Firmware error\')"; '
    'echo "probe=$(dmesg | sed -n \'s/.*wil6210 \\(SparRAW-[^ ]*\\) device found.*/\\1/p\' | tail -1)"; '
    'echo "mod=$(grep -c \'^wil6210 \' /proc/modules)"; '
    'echo "fwpath=$(cat %s 2>/dev/null)"; '
    'echo "fw=$(md5sum %s 2>/dev/null | cut -d\' \' -f1)"; '
    'echo "ko=$( (md5sum %s 2>/dev/null || md5sum %s 2>/dev/null) | cut -d\' \' -f1)"; '
    'echo "brd=$(md5sum %s 2>/dev/null | cut -d\' \' -f1)"; '
    'echo "sig=$(cat %s 2>/dev/null)"; '
    # подъём роли: сколько раз стартовала прошивка (wmi_evt_ready) и когда; netifd — запуски скрипта setup
    # радио (wifi-scripts «Starting»/«Tearing down», строки netifd «radio0 (pid): …»); hostapd/wpa_supplicant
    'echo "fwstarts=$(dmesg | grep -c \'FW ver\\. \')"; '
    'echo "fwts=$(dmesg | sed -n \'s/^\\[ *\\([0-9.]*\\)\\].*FW ver\\. .*/\\1/p\' | tr \'\\n\' \' \')"; '
    'L=$(logread 2>/dev/null); '
    'echo "starts=$(echo "$L" | grep -c \'radio0 ([0-9]*): wifi-scripts: Starting\')"; '
    'echo "teardowns=$(echo "$L" | grep -c \'radio0 ([0-9]*): wifi-scripts: Tearing down\')"; '
    'echo "apen=$(echo "$L" | grep -c \'AP-ENABLED\')"; '
    'echo "apdis=$(echo "$L" | grep -c \'AP-DISABLED\')"; '
    'echo "conn=$(echo "$L" | grep -c \'CTRL-EVENT-CONNECTED\')"; '
    'echo "disc=$(echo "$L" | grep -c \'CTRL-EVENT-DISCONNECTED\')"; '
    'echo "rej=$(echo "$L" | grep -c \'CTRL-EVENT-ASSOC-REJECT\')"; '
    'echo "cfg0=$(cat %s 2>/dev/null)"; '
    'echo "cfg=$(md5sum %s 2>/dev/null | cut -d\' \' -f1)"; '
    'iw dev 2>/dev/null' % (FWPATH, FW_TMP, KO_TMP, KO_SYS, BRD_TMP, SIG, WCONF_MD5, WCONF))

LINK_CMD = ('for I in $(iw dev | sed -n "s/.*Interface //p"); do iw dev $I link 2>/dev/null | grep -q Connected && '
            'echo $I; done')
FW_READY_CMD = "dmesg | grep -m1 -E 'FW ver\\. |Firmware error'"
BOOT_ID_CMD = 'cat /proc/sys/kernel/random/boot_id'
# Состояние radio0 в netifd (wireless-device.uc status(): up, pending — идёт setup/teardown, retry_setup_failed) и
# чем radio0 указывает на phy (config.path / phy / macaddr — как find_phy() в wifi/utils.uc), рядом — сам phy
WSTATUS_CMD = ("S=$(ubus call network.wireless status '{\"device\":\"radio0\"}' 2>/dev/null); "
               "j() { echo \"$S\" | jsonfilter -e \"$1\" 2>/dev/null; }; "
               "for k in up pending retry_setup_failed; do echo \"w_$k=$(j @.radio0.$k)\"; done; "
               "for k in path phy macaddr; do echo \"w_$k=$(j @.radio0.config.$k)\"; done; "
               "P=$(ls /sys/class/ieee80211 2>/dev/null | head -1); echo \"phy=$P\"; "
               "[ -z \"$P\" ] || { echo \"phypath=$(readlink -f /sys/class/ieee80211/$P/device)\"; "
               "echo \"phymac=$(cat /sys/class/ieee80211/$P/macaddress)\"; }")
# Подъём радио: wireless.uc ubus up → wdev start(): autostart, сброс retry, setup только из state down — повтор и
# гонка с hotplug (network.wireless retry) ничего не перезапускают. НЕ /sbin/wifi up (= down + reload + up).
UP_CMD = 'ubus call network.wireless up \'{"device":"radio0"}\''
PHY_CMD = 'ls /sys/class/ieee80211/ 2>/dev/null | head -1'
# rc.local узла упоминает wil6210 — дождаться uptime RC_SETTLE и конца «sh /etc/rc.local» (/etc/init.d/done). Имя файла
# в тексте команды не встречается целиком: ps видит и sh -c самой команды — иначе она нашла бы саму себя
RC_SETTLE_CMD = ("F=/etc/rc; F=$F.local; grep -qw wil6210 $F 2>/dev/null || { echo ok; exit 0; }; "
                 "[ $(cut -d. -f1 /proc/uptime) -ge %d ] && ! ps w | grep -q '[s]h /etc/rc[.]local' && echo ok"
                 % RC_SETTLE)


def _out(r):
    return r[1].decode('utf-8', 'replace') if isinstance(r[1], bytes) else (r[1] or '')


def _sh(node, cmd, timeout=60, input=None):
    """Команда, которая должна пройти: (rc 0) → stdout; иначе StandError (без перезагрузки)."""
    check_cmd(cmd)
    r = node.sh(cmd, timeout, input)
    if r[0] != 0:
        err = r[2].decode('utf-8', 'replace') if isinstance(r[2], bytes) else (r[2] or '')
        why = 'зависла %d с' % timeout if r[0] is None else 'код %s: %s' % (r[0], err.strip()[-200:])
        raise StandError('%s: «%s» — %s' % (node.name, cmd.splitlines()[0][:80], why))
    return _out(r)


def _q(node, cmd, timeout=15):
    """Опрос без требований к коду возврата: stdout или ''."""
    check_cmd(cmd)
    return _out(node.sh(cmd, timeout))


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

def install(node, log=None):
    """Однократная подготовка узла (идемпотентно). Возвращает список замечаний; другая автозагрузка wil6210 —
    StandError."""
    log = log or (lambda s: None)
    out = _sh(node, install_script(), 60)
    if 'INSTALLED' not in out:
        raise StandError('%s: подготовка не завершилась: %s' % (node.name, out[-300:]))
    notes = []
    for l in out.splitlines():
        if l.startswith('OTHER_AUTOLOAD'):
            raise StandError('%s: wil6210 грузят при старте ещё и %s — убрать вручную' % (node.name, l.split(None, 1)[1]))
        if l.startswith('HOTPLUG'):
            notes.append('hotplug упоминает wil6210: %s — проверить, не грузит ли он модуль' % l.split(None, 1)[1])
        if l == 'RCLOCAL':
            notes.append('/etc/rc.local ждёт /sys/module/wil6210 (параметры модуля) — insmod будет после uptime %d с, '
                         'когда rc.local уже закончил' % RC_SETTLE)
    log('%s: автозагрузка wil6210 %s%s' % (node.name, 'снята (бэкап %s)' % MODD_BAK if 'AUTOLOAD_REMOVED' in out
                                          else 'уже снята', ''.join('; ' + n for n in notes)))
    for k, s in (('LEGACY_UCI_RESTORED', 'опции прошлых сценариев возвращены'),
                 ('LEGACY_MODCONF_REMOVED', 'строка параметров в modules.conf убрана'),
                 ('RCLOCAL_REPLACED', 'rc.local с ожиданием wil6210 заменён пустым (бэкап %s)' % RCLOCAL_BAK)):
        if k in out:
            log('%s: %s' % (node.name, s))
    return notes


def uninstall(node, log=None):
    """Вернуть автозагрузку wil6210 (из бэкапа)."""
    out = _sh(node, uninstall_script(), 30)
    (log or (lambda s: None))('%s: автозагрузка wil6210 возвращена' % node.name)
    return 'UNINSTALLED' in out


def reboot(node, log=None, mode=None):
    """sync и перезагрузка: mode 'force' (по умолчанию REBOOT_MODE) — reboot -f мимо procd, 'init' — обычный reboot
    (REBOOT_CMDS). Возвращает boot_id до перезагрузки (ожидание — wait_up)."""
    mode = mode or REBOOT_MODE
    if mode not in REBOOT_CMDS:
        raise StandError('режим перезагрузки %r: нужен %s' % (mode, ' или '.join(sorted(REBOOT_CMDS))))
    old = boot_id(node)
    node.sh(REBOOT_CMDS[mode], 20)
    (log or (lambda s: None))('%s: %s' % (node.name, REBOOT_CMDS[mode].rsplit('; ', 1)[-1]))
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


def check_clean(node):
    """После загрузки системы wil6210 не загружен (автозагрузка снята install)."""
    n = _q(node, LOADED_CMD).strip()
    if n != '0':
        raise StandError('%s: узел загрузил драйвер wil6210 сам (lsmod) — автозагрузка не снята: node_boot.sh '
                         '--install %s' % (node.name, getattr(node, 'host', node.name)))


def wstatus(node):
    """Разбор WSTATUS_CMD: w_up/w_pending/w_retry_setup_failed ('true'/'false'/'' — radio0 нет в netifd),
    w_path/w_phy/w_macaddr — чем radio0 указывает на phy, phy/phypath/phymac — сам phy."""
    return dict(re.findall(r'^(\w+)=(.*)$', _q(node, WSTATUS_CMD), re.M))


def radio_matches_phy(w):
    """radio0 в netifd указывает на найденный phy — как find_phy() wifi-scripts (wifi/utils.uc): config.path —
    хвост realpath /sys/class/ieee80211/<phy>/device (до «+»), иначе config.phy — имя, иначе config.macaddr.
    Возвращает (да/нет, чем сверено)."""
    if not w.get('phy'):
        return False, 'phy нет'
    if w.get('w_path'):
        path = w['w_path'].split('+')[0]
        return (w.get('phypath') or '').endswith(path), 'path %s ↔ %s' % (path, w.get('phypath'))
    if w.get('w_phy'):
        return w['w_phy'] == w['phy'], 'phy %s ↔ %s' % (w['w_phy'], w['phy'])
    if w.get('w_macaddr'):
        return w['w_macaddr'].lower() == (w.get('phymac') or '').lower(), 'macaddr %s ↔ %s' % (w['w_macaddr'],
                                                                                            w.get('phymac'))
    return False, 'у radio0 нет ни path, ни phy, ни macaddr'


def netconsole(node, log):
    """Журнал ядра узла по UDP на хост до insmod — чтобы зависание/паника узла оставили след (стенд 2026-11-08:
    «самопроизвольные перезагрузки» оказались паникой, видимой только через netconsole). Включается переменной
    SPARRAW_NETCON="<ip хоста>,<mac хоста>"; порт 6600 + последний октет адреса узла (.11 → 6611); приёмник на хосте
    (socat -u UDP-RECV:<порт> -) запускает тот, кто ведёт прогон."""
    nc = os.environ.get('SPARRAW_NETCON')
    if not nc:
        return
    ip, mac = nc.split(',')
    me = node.host.split('@')[-1]
    port = 6600 + int(me.rsplit('.', 1)[-1])
    _sh(node, 'rmmod netconsole 2>/dev/null; insmod /lib/modules/$(uname -r)/netconsole.ko '
              'netconsole=+6665@%s/br-lan,%d@%s/%s && echo 8 > /proc/sys/kernel/printk && '
              'echo "stand netconsole $(cat /proc/sys/kernel/random/boot_id)" > /dev/kmsg' % (me, port, ip, mac), 30)
    log('%s: netconsole → %s:%d' % (node.name, ip, port))


def load(node, spec, log=None):
    """Драйвер итерации на только что загруженном узле: прошивка и плата в tmpfs, путь firmware_class, роль в uci
    без commit и один network reload (до insmod), ожидание netifd, insmod с параметрами, phy ↔ radio0,
    network.wireless up radio0. Возвращает ожидаемые md5 {'fw', 'ko'}."""
    log = log or (lambda s: None)
    check_clean(node)
    netconsole(node, log)
    if not _wait(lambda: _q(node, RC_SETTLE_CMD).strip(), RC_SETTLE + 60, 5):
        raise StandError('%s: /etc/rc.local не закончился за %d с после загрузки' % (node.name, RC_SETTLE + 60))
    want = {'fw': None, 'ko': None}
    if spec.fw is not None:
        want['fw'] = md5(spec.fw)
        got = _sh(node, put_cmd(FW_TMP), 120, spec.fw).split()[:1]
    else:
        want['fw'] = (_sh(node, 'md5sum %s' % shlex.quote(spec.fw_node)).split() or [None])[0]
        got = _sh(node, 'mkdir -p %s && cp %s %s && md5sum %s' % (FWDIR, shlex.quote(spec.fw_node), FW_TMP,
                                                                  FW_TMP)).split()[:1]
    if got != [want['fw']]:
        raise StandError('%s: md5 прошивки в %s %s, ожидается %s' % (node.name, FW_TMP, got, want['fw']))
    brd = (_sh(node, 'cp %s %s && md5sum %s' % (BRD, BRD_TMP, BRD_TMP)).split() or [''])[0]
    if spec.brd_md5 and not brd.startswith(spec.brd_md5):
        raise StandError('%s: плата %s — md5 %s, ожидается %s (плата малой мощности?) — драйвер не загружаю'
                         % (node.name, BRD, brd, spec.brd_md5))
    if spec.ko is not None:
        want['ko'] = md5(spec.ko)
        got = _sh(node, put_cmd(KO_TMP), 120, spec.ko).split()[:1]
        if got != [want['ko']]:
            raise StandError('%s: md5 модуля в %s %s, ожидается %s' % (node.name, KO_TMP, got, want['ko']))
    if _sh(node, 'echo -n %s > %s && cat %s' % (FWDIR, FWPATH, FWPATH)).strip() != FWDIR:
        raise StandError('%s: firmware_class.path не принял %s' % (node.name, FWDIR))
    log('%s: прошивка %s (%s), плата %s → %s' % (node.name, spec.fw_ver or spec.fw_node or '', want['fw'][:12],
                                                brd[:12], FWDIR))
    out = _sh(node, uci_script(spec, signature(spec, want['fw'], want['ko'])), 60)
    if 'UCI_SET' not in out:
        raise StandError('%s: роль в uci не выставлена: %s' % (node.name, out[-300:]))
    # reload запустил setup radio0 без phy — дождаться его конца, чтобы insmod не попал в середину попытки
    w = _wait(lambda: (lambda w: w if w.get('w_pending') == 'false' else None)(wstatus(node)),
              NETIFD_IDLE_TIMEOUT, 1)
    if not w:
        w = wstatus(node)
        raise StandError('%s: netifd %s за %d с после network reload' % (
            node.name, 'не знает radio0 (network.wireless status пуст)' if not w.get('w_pending')
            else 'не закончил setup radio0', NETIFD_IDLE_TIMEOUT))
    if _sh(node, "modprobe cfg80211; grep -c '^cfg80211 ' /proc/modules").strip() != '1':
        raise StandError('%s: cfg80211 не загрузился (modprobe cfg80211)' % node.name)
    ko = KO_TMP if spec.ko is not None else KO_SYS
    _sh(node, ('insmod %s %s' % (ko, spec.modparams or '')).strip(), 60)
    if _q(node, LOADED_CMD).strip() != '1':
        raise StandError('%s: wil6210 не загрузился (insmod %s)' % (node.name, ko))
    if not _wait(lambda: _q(node, PHY_CMD).strip(), PHY_TIMEOUT, 1):
        raise StandError('%s: нет phy wil6210 за %d с после insmod' % (node.name, PHY_TIMEOUT))
    ok, how = radio_matches_phy(wstatus(node))
    if not ok:
        raise StandError('%s: radio0 в netifd не указывает на phy wil6210 (%s) — wifi-scripts ответят «PHY is '
                         'undefined for device»' % (node.name, how))
    _sh(node, UP_CMD, 30)
    log('%s: insmod %s %s; роль %s, SSID %s (uci без commit); network.wireless up radio0 (%s)'
        % (node.name, ko, spec.modparams or '', spec.role, spec.ssid, how))
    return want


class Report:
    """Итог проверки узла: facts — разобранные значения, problems — несоответствия (текст), kinds — их виды
    ('fw' — FW не загрузилась или не из пути итерации, 'md5' — на узле не те файлы, 'commit' — при подъёме
    изменился закоммиченный wireless, 'restart' — прошивка или роль перезапускались при подъёме, 'ver', 'iface',
    'link', 'brd', 'fwerr'), iface, link."""
    HARD = ('fw', 'md5', 'commit')   # проверяемый объект не тот, не загрузился, узел изменён — тесты ничего не скажут

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
        """'restart' без Firmware error — сбой процедуры подъёма (стенд), с ним — следствие восстановления fw после
        сбоя проверяемого образа: это предмет тестов, не стенда."""
        return bool(self.kinds & set(self.HARD)) or ('restart' in self.kinds and 'fwerr' not in self.kinds)

    def line(self, name):
        f = self.facts
        s = '%s: fw %s md5 %s ko %s brd %s iface %s %s FWERR %s стартов fw %s' % (
            name, f.get('ver') or '?', (f.get('fw') or '-')[:12], (f.get('ko') or '-')[:12], (f.get('brd') or '-')[:12],
            self.iface or '-', f.get('type') or '-', f.get('fwerr'), f.get('fwstarts', '?'))
        if f.get('type') == 'managed':
            s += ' link %s' % ('да' if self.link else 'нет')
        return s + ('' if self.ok else ' — ' + '; '.join(self.problems))


def facts(node):
    """Разбор FACTS_CMD: ключи ver/fwerr/probe/mod/fwpath/fw/ko/brd/sig; ifaces — [(имя, тип)], iface/type — первый."""
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
    return bool(_wait(lambda: _q(node, FW_READY_CMD).strip(), timeout))


def wait_iface(node, spec, timeout=IFACE_TIMEOUT):
    t = 'type %s' % role_type(spec)
    return bool(_wait(lambda: t in _q(node, 'iw dev'), timeout))


def _n(f, k):
    try:
        return int(f.get(k) or 0)
    except ValueError:
        return 0


def wait_radio_up(node, timeout=UP_TIMEOUT):
    """radio0 в netifd: up и не pending (setup закончен, wifi-scripts вызвали set_up)."""
    return bool(_wait(lambda: (lambda w: w.get('w_up') == 'true' and w.get('w_pending') == 'false')(wstatus(node)),
                      timeout, 2))


def verify(node, spec, want=None, log=None, link=None):
    """Проверки после load(). want — ожидаемые md5 ({'fw', 'ko'}); link — ждать связь станции (по умолчанию
    spec.wait_link). После подъёма — окно STABLE_S: перезапуски fw и роли считаются по всей загрузке (dmesg, logread),
    Disconnect станции — за окно после связи."""
    log = log or (lambda s: None)
    want = want or {}
    rep = Report()
    if not wait_fw(node):
        rep.add('fw', 'нет wmi_evt_ready за %d с (FW не загрузилась)' % FW_TIMEOUT)
    if not wait_radio_up(node):
        w = wstatus(node)
        rep.add('iface', 'netifd: radio0 не поднялось за %d с (up=%s pending=%s retry_setup_failed=%s)'
                % (UP_TIMEOUT, w.get('w_up'), w.get('w_pending'), w.get('w_retry_setup_failed')))
    if not wait_iface(node, spec):
        rep.add('iface', 'нет интерфейса type %s за %d с' % (role_type(spec), IFACE_TIMEOUT))
    want_link = spec.role == 'sta' and (spec.wait_link if link is None else link)
    if want_link:
        rep.link = bool(_wait(lambda: _q(node, LINK_CMD).strip(), spec.link_timeout))
        if not rep.link:
            rep.add('link', 'станция не подключилась к %s за %d с' % (spec.ssid, spec.link_timeout))
    f0 = facts(node)
    _sleep(STABLE_S)
    still = bool(_q(node, LINK_CMD).strip()) if want_link and rep.link else None
    f = rep.facts = facts(node)
    if still is not None:
        d = _n(f, 'disc') - _n(f0, 'disc')
        if d or not still:
            rep.link = still
            rep.add('link', 'станция: %s за %d с после связи (CTRL-EVENT-DISCONNECTED ×%d)'
                    % ('связь пропала' if not still else 'Disconnect', STABLE_S, d))
    n = _n(f, 'fwstarts')
    if n > spec.max_fw_starts:
        rep.add('restart', 'прошивка перезапускалась %d раз при подъёме (FW ver. в dmesg ×%d: %s; допустимо %d)'
                % (n, n, (f.get('fwts') or '').strip() or '?', spec.max_fw_starts))
    st, td = _n(f, 'starts'), _n(f, 'teardowns')
    if st > 1 or td:
        rep.add('restart', 'роль поднималась не один раз: wifi-scripts «Starting» ×%d, «Tearing down» ×%d (logread)'
                % (st, td))
    if spec.role == 'ap' and _n(f, 'apdis'):
        rep.add('restart', 'hostapd: AP-DISABLED ×%s (AP-ENABLED ×%s)' % (f.get('apdis'), f.get('apen')))
    if f.get('cfg0') and f.get('cfg') != f.get('cfg0'):
        rep.add('commit', '%s изменился при подъёме (md5 %s → %s): commit роли на флеш (wifi config из hotplug '
                '10-wifi-detect делает «uci commit wireless», если не узнал radio0)' % (WCONF, f['cfg0'][:12],
                                                                                    (f.get('cfg') or '-')[:12]))
    rep.iface, f['type'] = pick_iface(f, spec)
    if f.get('mod') != '1':
        rep.add('fw', 'wil6210 не загружен')
    if f.get('fwpath') != FWDIR:
        rep.add('fw', 'firmware_class.path %r, ожидается %s' % (f.get('fwpath'), FWDIR))
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
    if spec.role == 'sta' and (_n(f, 'rej') or _n(f, 'disc')):
        log('%s: wpa_supplicant за загрузку: ASSOC-REJECT ×%s, DISCONNECTED ×%s, CONNECTED ×%s'
            % (node.name, f.get('rej'), f.get('disc'), f.get('conn')))
    log(rep.line(node.name))
    return rep


def matches(node, spec, wait=0):
    """В этой загрузке узла уже загружена итерация spec (подпись в /tmp, md5 прошивки и модуля, FW, интерфейс роли)
    — перезагрузка не нужна. wait — сколько ждать FW и интерфейса, если подпись и файлы сошлись."""
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
    if not (f.get('mod') == '1' and f.get('sig') == signature(spec, fw, ko) and f.get('fw') == fw
            and (ko is None or f.get('ko') == ko)):
        return False
    if wait and not (wait_fw(node, wait) and wait_iface(node, spec, wait)):
        return False
    f = facts(node)
    return pick_iface(f, spec)[1] == role_type(spec) and bool(f.get('ver'))


def bring_up(node, spec, log=None, link=None):
    """Узел только что загрузился (reboot, reboot -f): драйвер итерации и проверки. Возвращает Report."""
    want = load(node, spec, log)
    return verify(node, spec, want, log, link)


def boot(node, spec, power=None, log=None, link=None, reboot_mode=None):
    """Вся итерация на одном узле: reboot → wait_up → load → verify. Возвращает Report."""
    old = reboot(node, log, reboot_mode)
    wait_up(node, old, power, log)
    return bring_up(node, spec, log, link)


# ============================== CLI (tools/stand/node_boot.sh) ==============================

SSH_OPTS = ['-F', '/dev/null', '-o', 'StrictHostKeyChecking=no', '-o', 'UserKnownHostsFile=/dev/null',
            '-o', 'ConnectTimeout=8', '-o', 'LogLevel=ERROR']


class SshNode:
    def __init__(self, host, name=None):
        self.host, self.name = host, name or host

    def sh(self, cmd, timeout, input=None):
        check_cmd(cmd)
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
    ap.add_argument('--install', action='store_true', help='однократно: снять автозагрузку wil6210 (идемпотентно)')
    ap.add_argument('--uninstall', action='store_true', help='вернуть автозагрузку wil6210 из бэкапа')
    ap.add_argument('--role', choices=('ap', 'sta'))
    ap.add_argument('--ssid', default='WL60TEST')
    ap.add_argument('--network', help="сеть uci интерфейса (точка — по умолчанию lan; '' — удалить)")
    ap.add_argument('--fw', help='образ .fw итерации → %s' % FW_TMP)
    ap.add_argument('--fw-node', help='образ на самом узле (напр. /lib/firmware/wil6210.fw.backup) → %s' % FW_TMP)
    ap.add_argument('--ko', help='свой модуль → %s (иначе модуль системы)' % KO_TMP)
    ap.add_argument('--uci', action='append', default=[], help='команды uci сценария через «;» (без commit)')
    ap.add_argument('--modparam', action='append', default=[], help='параметр insmod, напр. no_fw_recovery=Y')
    ap.add_argument('--brd-md5', default=os.environ.get('BRD_MD5') or None, help='ожидаемый md5 платы (префикс)')
    ap.add_argument('--no-link', action='store_true', help='станция: не ждать связь')
    ap.add_argument('--link-timeout', type=int, default=LINK_TIMEOUT)
    ap.add_argument('--max-fw-starts', type=int, default=MAX_FW_STARTS,
                    help='сколько стартов прошивки (FW ver. в dmesg) допустимо за подъём (по умолчанию %(default)s)')
    ap.add_argument('--reboot-mode', choices=sorted(REBOOT_CMDS), default=REBOOT_MODE,
                    help="force — sync; reboot -f мимо procd (по умолчанию), init — обычный reboot")
    ap.add_argument('--tapo', help='адрес розетки Tapo: снять питание, если узел не отвечает после reboot (один раз)')
    ap.add_argument('--tapo-tool', default=os.environ.get('TAPO_TOOL') or os.path.normpath(os.path.join(
        os.path.dirname(os.path.abspath(__file__)), '..', '..', '..', '..', 'SparRAW-tools', 'host', 'tapo_plug.py')))
    g = ap.add_mutually_exclusive_group()
    g.add_argument('--load-only', action='store_true', help='без reboot: узел только что загрузился (драйвера нет)')
    g.add_argument('--reboot-only', action='store_true', help='только reboot, ожидание ssh и проверка «драйвера нет» '
                   '(драйвер — потом --load-only)')
    g.add_argument('--no-reboot', action='store_true', help='только проверки (итерация уже загружена)')
    a = ap.parse_args(argv)
    host = a.host if '@' in a.host else 'root@' + a.host
    node = SshNode(host, host.split('@')[-1])
    log = lambda s: print('[node_boot] ' + s, flush=True)
    try:
        if a.install or a.uninstall:
            (install if a.install else uninstall)(node, log)
            return 0
        if a.reboot_only:
            power = tapo_power(a.tapo_tool, a.tapo, node.name) if a.tapo else None
            wait_up(node, reboot(node, log, a.reboot_mode), power, log)
            check_clean(node)
            log('%s: загружен, wil6210 не загружен' % node.name)
            return 0
        if not a.role:
            ap.error('нужен --role (или --install)')
        network = a.network if a.network is not None else ('lan' if a.role == 'ap' else None)
        spec = Spec(a.role, a.ssid, network, fw=open(a.fw, 'rb').read() if a.fw else None, fw_node=a.fw_node,
                    ko=open(a.ko, 'rb').read() if a.ko else None, uci=a.uci, modparams=' '.join(a.modparam) or None,
                    brd_md5=a.brd_md5, wait_link=not a.no_link, link_timeout=a.link_timeout,
                    max_fw_starts=a.max_fw_starts)
        power = tapo_power(a.tapo_tool, a.tapo, node.name) if a.tapo else None
        if a.no_reboot:
            rep = verify(node, spec, {'fw': md5(spec.fw) if spec.fw else None,
                                      'ko': md5(spec.ko) if spec.ko else None}, log)
        elif a.load_only:
            rep = bring_up(node, spec, log)
        else:
            rep = boot(node, spec, power, log, reboot_mode=a.reboot_mode)
    except StandError as e:
        print('[node_boot] ОШИБКА: %s' % e, flush=True)
        return 3
    return 0 if rep.ok else 2


if __name__ == '__main__':
    sys.exit(main())
