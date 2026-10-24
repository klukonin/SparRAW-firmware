#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Поиск функций uc, ломающих работу, на железе (.12 STA, .11 AP).

Образ: vendor fw (оригинал 6.2) + гибридный uc (uc_hybrid.py) с подменой набора
функций. Рекурсивно делим набор пополам; набор «хороший», если образ достигает
цели (--goal ready | assoc). После провала проверяем эталон (чистый vendor);
если эталон тоже не проходит — power-cycle .12 и повтор.

  uc_bisect.py --goal ready [--start all|list:file] --log build/bisect.log
  [REPEAT=3] --goal noerr: набор хорош, только если все REPEAT загрузок без FWERR.
  [REPEAT=2 STRESS=240] --goal nolost: после data — iperf вверх/вниз STRESS секунд; хорош, только если
  во всех REPEAT загрузках нет LOST_LINK (dmesg «wmi 2]») и FWERR.
  [REPEAT=2] --goal ap: .12 — AP (tools/hwboot_ap.sh), .11 vendor STA; хорош, если во всех REPEAT станция подключилась (assoc|data).
  .11 остаётся STA (KEEP=1) — после бисекции вернуть AP (см. hwboot_ap.sh restore).
Результат: build/bisect_<goal>.json (bad — найденные функции, good — проверенные).
"""
import argparse, json, os, re, subprocess, sys, time

HERE = os.path.dirname(os.path.abspath(__file__))
REW = os.path.dirname(HERE)
FW = os.path.dirname(REW)
VENDOR = FW + '/images/openwrt/fw/wil6210_6.2.0.1000.fw'
TAPO = os.path.abspath(FW + '/../SparRAW-tools/host/tapo_plug.py')
STA, PLUG = 'root@192.168.1.12', '192.168.10.105'
SSH = ['ssh', '-F', '/dev/null', '-o', 'StrictHostKeyChecking=no', '-o', 'UserKnownHostsFile=/dev/null',
       '-o', 'ConnectTimeout=8', '-o', 'LogLevel=ERROR', STA]
LOG = None


def log(*a):
    msg = time.strftime('%H:%M:%S ') + ' '.join(str(x) for x in a)
    print(msg, flush=True)
    if LOG:
        open(LOG, 'a').write(msg + '\n')


def ssh(cmd, inp=None, timeout=120):
    r = subprocess.run(SSH + [cmd], input=inp, capture_output=True, timeout=timeout)
    return r.stdout.decode(errors='replace')


def run_fw(path, goal):
    """Тест ТОЛЬКО через ребут .12 (tools/hwboot.sh). -> 'assoc' | 'ready' | 'noready'."""
    env = dict(os.environ, HOLD='30' if goal == 'noerr' else '0')
    if goal == 'ap':
        # .12 в роли AP, .11 (vendor) — STA; .11 остаётся STA между прогонами (KEEP=1)
        r = subprocess.run([HERE + '/hwboot_ap.sh', path, '45'], capture_output=True, text=True,
                           timeout=400, env=dict(env, KEEP='1'))
        m = re.search(r'RESULT: (\w+)', r.stdout)
        return m.group(1) if m else 'noready'
    r = subprocess.run([HERE + '/hwboot.sh', path, '24' if goal == 'ready' else '60'],
                       capture_output=True, text=True, timeout=400, env=env)
    m = re.search(r'RESULT: (\w+)', r.stdout)
    res = m.group(1) if m else 'noready'
    if goal == 'noerr':
        e = re.search(r'FWERR: (\d+)', r.stdout)
        if res != 'noready' and e and e.group(1) == '0':
            return 'noerr'
        return 'err' + (e.group(1) if e else '?') + '/' + res
    if goal == 'nolost':
        if res != 'data':
            return 'nodata/' + res
        t = int(os.environ.get('STRESS', '240')) // 4
        ip = "iperf3 -c 10.60.0.11 -t %d %s >/dev/null 2>&1"
        try:
            ssh('; '.join(ip % (t, x) for x in ('', '-R', '', '-R')), timeout=t * 4 + 120)
        except subprocess.TimeoutExpired:
            # iperf3 зависает, когда связь пропала посреди прогона — это сигнал, а не сбой стенда
            log('  iperf завис — проверяю dmesg')
            subprocess.run(SSH + ['killall iperf3'], capture_output=True, timeout=30)
        out = ssh("dmesg | grep -c 'wmi 2]'; dmesg | grep -c 'error detected'")
        n = [int(x) for x in out.split()[:2]] if len(out.split()) >= 2 else [9, 9]
        return 'nolost' if n == [0, 0] else 'lost%d/err%d' % (n[0], n[1])
    return res


def power_cycle():
    log('power-cycle .12')
    subprocess.run(['python3', TAPO, PLUG, 'cycle', '15'], capture_output=True, timeout=120)
    time.sleep(25)
    for _ in range(60):
        try:
            if subprocess.run(SSH + ['true'], capture_output=True, timeout=15).returncode == 0:
                return
        except subprocess.TimeoutExpired:
            pass
        time.sleep(3)
    sys.exit('.12 не поднялся после power-cycle')


AP = 'root@192.168.1.11'


def ap_restart():
    """AP .11 со временем залипает (перестаёт принимать ассоциации даже эталона):
    перезапуск radio на .11 (допустимо на стенде), uci без commit."""
    subprocess.run(SSH[:-1] + [AP, 'wifi down; sleep 3; wifi up; sleep 15'], capture_output=True, timeout=120)
    log('  AP .11: wifi перезапущен')


def ok(res, goal):
    if goal in ('noerr', 'nolost'):
        return res == goal
    if goal == 'ap':
        # assoc без ping бывает и у vendor (1/4) — шум; баг uc — станция не подключается (ready)
        return res in ('assoc', 'data')
    rank = {'noready': 0, 'ready': 1, 'assoc': 2, 'data': 3}
    return rank.get(res, 0) >= rank[goal]


def baseline(goal):
    for attempt in range(2):
        r = run_fw(VENDOR, goal)
        if ok(r, goal):
            return
        log('эталон не прошёл (%s) — повтор' % r)
        if goal in ('assoc', 'data', 'noerr', 'nolost'):
            ap_restart()
    sys.exit('эталон не проходит даже после перезапуска AP — стенд неисправен')


def build(fns, out):
    lst = out + '.list'
    open(lst, 'w').write('\n'.join(sorted(fns)))
    r = subprocess.run(['python3', HERE + '/uc_hybrid.py', '--select', 'list:' + lst,
                        '--out', out + '.bin', '--fw', out, '--report', out + '.json'],
                       capture_output=True, text=True)
    if r.returncode != 0 or not os.path.exists(out):
        log('СБОРКА НЕ УДАЛАСЬ:', (r.stdout + r.stderr)[-800:])
        return False
    return True


TESTS = [0]


def test(fns, goal):
    out = REW + '/build/bisect_cur.fw'
    if os.path.exists(out):
        os.remove(out)
    if not build(fns, out):
        return None
    TESTS[0] += 1
    if goal in ('noerr', 'nolost', 'ap'):
        # ошибка прерывистая: удачный прогон — это флап, провал — сигнал.
        # Хорош только набор, у которого все REPEAT загрузок без FWERR.
        for k in range(int(os.environ.get('REPEAT', '3'))):
            r = run_fw(out, goal)
            # «assoc без данных» бывает и у vendor (~10%) — не сигнал, повтор загрузки
            for _ in range(2):
                if goal != 'nolost' or not r.startswith('nodata'):
                    break
                log('  (%s — повтор загрузки)' % r)
                if r == 'nodata/ready':
                    ap_restart()        # «ready» без ассоциации — обычно залип AP
                r = run_fw(out, goal)
            good = ok(r, goal)
            if not good:
                break
        log('тест #%d: %d функций -> %s' % (TESTS[0], len(fns), 'OK' if good else 'FAIL ' + r))
        return good
    r = run_fw(out, goal)
    good = ok(r, goal)
    if not good:
        if goal in ('assoc', 'data', 'noerr'):
            ap_restart()
        r2 = run_fw(out, goal)          # повтор (тоже через ребут) — отсечь флапы
        if ok(r2, goal):
            good = True
            log('  (флап: первый прогон %s, повтор %s)' % (r, r2))
    log('тест #%d: %d функций -> %s' % (TESTS[0], len(fns), 'OK' if good else 'FAIL ' + r))
    return good


def find_bad(fns, goal, state, known_bad=False):
    fns = sorted(fns)
    key = ','.join(fns)
    if known_bad:
        g = False
    elif key in state['cache']:
        g = state['cache'][key]
    else:
        g = test(fns, goal)
        state['cache'][key] = g
        json.dump(state, open(state['path'], 'w'))
    if g:
        state['good'] = sorted(set(state['good']) | set(fns))
        return []
    if g is None:
        log('сборка не удалась для набора из %d — делим дальше' % len(fns))
        if len(fns) == 1:
            log('НЕСОБИРАЕМО (не виновник):', fns[0])
            state.setdefault('unbuildable', []).append(fns[0])
            json.dump(state, open(state['path'], 'w'))
            return []
    if len(fns) == 1:
        log('ВИНОВНИК:', fns[0])
        state['bad'] = sorted(set(state['bad']) | set(fns))
        json.dump(state, open(state['path'], 'w'))
        return fns
    h = len(fns) // 2
    left = find_bad(fns[:h], goal, state)
    # если левая половина целиком хорошая, правая обязана быть плохой (без взаимодействий)
    # «правая обязана быть плохой» — только если сам набор реально протестирован как FAIL
    right = find_bad(fns[h:], goal, state, known_bad=(not left and g is False and not known_bad))
    if not left and not right and known_bad and key not in state['cache']:
        # провал набора был только выведен (левая половина соседа прошла) — проверить сам набор
        g = test(fns, goal)
        state['cache'][key] = g
        json.dump(state, open(state['path'], 'w'))
        if g:
            log('набор из %d на деле проходит (вывод был ложным)' % len(fns))
            return []
    if not left and not right and g is False:      # g is None — просто не собрался, не провал
        log('ВЗАИМОДЕЙСТВИЕ: набор из %d падает, половины проходят' % len(fns))
        state.setdefault('interact', []).append(fns)
        json.dump(state, open(state['path'], 'w'))
    return left + right


def main():
    global LOG
    ap = argparse.ArgumentParser()
    ap.add_argument('--goal', choices=['ready', 'assoc', 'data', 'noerr', 'nolost', 'ap'], default='ready')
    ap.add_argument('--start', default='all')
    ap.add_argument('--log', default=REW + '/build/bisect.log')
    a = ap.parse_args()
    LOG = a.log
    sys.path.insert(0, HERE)
    import uc_hybrid
    uc_hybrid.fresh_snapshot()   # бисекция всё время работает с кодом на момент старта
    # кэш результатов привязан к отпечатку кода: другой код — другой кэш
    import hashlib, glob as _g
    src = os.path.dirname(uc_hybrid.UCDIR)
    h = hashlib.sha256()
    for f in sorted(_g.glob(src + '/Makefile') + _g.glob(src + '/include/*.h') + _g.glob(src + '/uc/*')):
        h.update(open(f, 'rb').read())
    path = REW + '/build/bisect_%s_%s.json' % (a.goal, h.hexdigest()[:12])
    state = json.load(open(path)) if os.path.exists(path) else dict(cache={}, good=[], bad=[])
    state['path'] = path
    if a.start == 'all':
        rep = REW + '/build/uc_all_fns.json'
        subprocess.run(['python3', HERE + '/uc_hybrid.py', '--select', 'all', '--list-only',
                        '--report', rep], check=True, capture_output=True)
        fns = json.load(open(rep))['fns']
    else:
        fns = open(a.start[5:]).read().split()
    log('старт: цель=%s, функций %d' % (a.goal, len(fns)))
    baseline(a.goal)
    bad = find_bad(fns, a.goal, state)
    log('ГОТОВО: виновников %d: %s; тестов %d' % (len(bad), ' '.join(bad), TESTS[0]))


if __name__ == '__main__':
    main()
