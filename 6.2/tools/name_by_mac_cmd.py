#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Имя блока ucode по команде MAC, которую он посылает.

Микрокод управляет MAC через кольцо команд: слово кладётся `st.ab rX,[r25,4]`,
старший байт слова — код команды (см. память проекта по протоколу LMAC и
разбору команды 0x27 «маска движка событий»).

Если блок посылает команды РОВНО ОДНОГО кода, про него честно сказать,
что он программирует MAC этой командой — не больше и не меньше. Имя
адресно-честное, той же породы, что принятые `mac_bringup__prog_881000`.
Блоки с несколькими разными кодами пропускаются: какая из команд
главная — уже догадка.

Код 0x00 не считается: нулевой старший байт бывает у обычных данных,
попавших в кольцо, и командой не является.

ВАЖНО: r25 — глобальный указатель кольца, свой код под ucode собирать
только с `-ffixed-r25` (см. config.mk).
"""
import argparse, bisect, collections, json, re

MOV = re.compile(r'^_?mov(?:_s)?\s+(r\d+),\s*0x([0-9a-f]+)$')
STAB = re.compile(r'^_?st\.ab\s+(r\d+),\[r25,\s*0x4\]$')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--lo', default='0x920000')
    ap.add_argument('--hi', default='0x93ecc4')
    ap.add_argument('--min-size', type=int, default=16)
    ap.add_argument('--out')
    a = ap.parse_args()
    lo, hi = int(a.lo, 16), int(a.hi, 16)

    st = sorted(json.load(open(a.blocks))['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]
    cmds = collections.defaultdict(collections.Counter)
    const, cur = {}, None
    for l in open(a.insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if not lo <= ad < hi:
            continue
        b = st[bisect.bisect_right(ads, ad) - 1]
        if b is not cur:
            cur, const = b, {}
        t = p[3].rstrip()
        m = MOV.match(t)
        if m:
            const[m.group(1)] = int(m.group(2), 16)
            continue
        m = STAB.match(t)
        if m and m.group(1) in const:
            v = const[m.group(1)]
            code = (v >> 24) & 0xff
            if v > 0xffff and code:
                cmds[b['name']][code] += 1

    out = []
    for b in st:
        if not b['name'].startswith(('sub_', 'blk_')) or b['size'] < a.min_size:
            continue
        c = cmds.get(b['name'])
        if not c or len(c) != 1:
            continue
        code, n = next(iter(c.items()))
        out.append((b['addr'], 'mac_cmd_0x%02x__%06x' % (code, b['addr']),
                    b['size'], code, n))
    if a.out:
        with open(a.out, 'a') as f:
            f.write('\n# --- блоки ucode по единственной посылаемой команде MAC '
                    '(name_by_mac_cmd.py) ---\n')
            for ad, nm, sz, code, n in out:
                f.write('0x%08x %s # шлёт в кольцо r25 только команду 0x%02x '
                        '(%d раз), %d Б\n' % (ad, nm, code, n, sz))
    print('блоков с единственным кодом команды MAC: %d, байт %d'
          % (len(out), sum(x[2] for x in out)))


if __name__ == '__main__':
    main()
