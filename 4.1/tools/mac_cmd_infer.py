#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Вывести неизвестные отправки по соседству: статика + живая трасса.

Если в блоке идут подряд отправка A (значение известно) и отправка B
(значение статически не восстановлено), а в снятой с железа трассе за A
СТАБИЛЬНО следует значение V, которое не принадлежит никакому другому
известному месту, то B посылает именно V.

Так подтверждён 0x34: в `direct_tx__program_cmd34` известна только
0x33000001, а в трассе за ней всегда идёт 0x34xxxxxx.

    mac_cmd_infer.py ring1.bin ring2.bin ... > ref/MAC-CMD-INFERRED.txt
"""
import collections, re, struct, sys, importlib.util

MINSUP = 5          # меньше наблюдений -- не вывод, а совпадение
MINSHARE = 0.80     # доля, при которой сосед считается стабильным


def load_ring(path, window):
    b = open(path, 'rb').read()
    sn = [list(struct.unpack('<256I', b[i * 1024:(i + 1) * 1024]))
          for i in range(len(b) // 1024)]
    out, prev = [], sn[0]
    for cur in sn[1:]:
        w = window(prev, cur)
        if w and w[2]:
            out += [cur[(w[0] + j) % 256] for j in range(w[1])
                    if prev[(w[0] + j) % 256] != cur[(w[0] + j) % 256]]
        prev = cur
    return out


def main():
    spec = importlib.util.spec_from_file_location(
        'm', '../../SparRAW-tools/host/wil_mac_ring.py')
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)

    sites, order = {}, []          # значение -> места; и порядок отправок
    for l in open('ref/MAC-CMD-SITES.txt'):
        if not l.startswith('0x'):
            continue
        p = l.split()
        ad, blk = int(p[0], 16), p[-1]
        exact = re.fullmatch(r'[0-9a-f]{8}', p[1])
        val = int(p[1], 16) if exact else None
        if val is not None:
            sites.setdefault(val, []).append(ad)
        order.append((ad, val, blk))
    order.sort()

    stream = []
    for f in sys.argv[1:]:
        stream += load_ring(f, m.window)
    if not stream:
        sys.exit('нет трасс')

    nxt = collections.defaultdict(collections.Counter)
    for i in range(len(stream) - 1):
        nxt[stream[i]][stream[i + 1]] += 1

    known = set(sites)
    out = []
    for i in range(len(order) - 1):
        ad, val, blk = order[i]
        ad2, val2, blk2 = order[i + 1]
        if val is None or val2 is not None or blk != blk2:
            continue
        n_sites = len(sites.get(val, []))
        if n_sites == 0:
            continue
        c = nxt.get(val)
        if not c:
            continue
        v, n = c.most_common(1)[0]
        tot = sum(c.values())
        if tot < MINSUP or n / tot < MINSHARE:
            continue
        if v in known:
            continue          # сосед уже принадлежит известному месту
        out.append((ad2, v, n, tot, blk2, ad, val, n_sites))

    print('# выведено по соседству в трассе (%d команд в потоке)' % len(stream))
    print('# Достоверность: «точно» -- опорная отправка единственная в образе,')
    print('# значит сосед в трассе однозначно принадлежит этому месту.')
    print('# «вероятно» -- опорное значение шлётся из нескольких мест, и вывод')
    print('# опирается лишь на то, что наблюдаемый сосед ничем другим не занят.')
    print('# адрес      значение    код   опора                        доля   вывод      блок')
    for ad2, v, n, tot, blk, ad, val, ns in out:
        print('0x%06x  %08x  0x%02x  после 0x%08x (мест %d)  %d/%d  %-9s  %s'
              % (ad2, v, (v >> 24) & 0xff, val, ns, n, tot,
                 'точно' if ns == 1 else 'вероятно', blk))
    print('# выведено отправок: %d' % len(out), file=sys.stderr)


if __name__ == '__main__':
    main()
