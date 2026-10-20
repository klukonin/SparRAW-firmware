#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Имя блока-переходника: подготовка аргументов плюс хвостовой переход.

Хвост мелких безымянных блоков в обоих сегментах — это заготовки вызова:
несколько `mov` в регистры аргументов и безусловный переход в настоящую
функцию.

    mov_s r1,0x5 ; mov_s r2,0x0 ; mov_s r3,r2 ; b.d 0x008d9b6c

Про такой блок честно сказать ровно одно: он передаёт управление в X,
подготовив аргументы. Класс `tail_` в проекте принят и признан здоровым
(ревизия 4.1 не нашла в нём брака).

Условия: блок не длиннее порога, содержит ровно один безусловный переход
и он последний, цель — начало ИМЕНОВАННОГО блока, и внутри нет обычных
вызовов `bl` (иначе это не переходник, а функция).
"""
import argparse, collections, json, re

JUMP = re.compile(r'^_?b(?:_s)?(\.d)?\s+0x00([0-9a-f]{6})$')
CALL = re.compile(r'^_?(bl|jl)')
GENERIC = ('sub_', 'blk_', 'FUN_')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--lo', required=True)
    ap.add_argument('--hi', required=True)
    ap.add_argument('--max-size', type=int, default=32)
    ap.add_argument('--out')
    ap.add_argument('--tag', default='fw')
    a = ap.parse_args()
    lo, hi = int(a.lo, 16), int(a.hi, 16)

    ins = {}
    for l in open(a.insns):
        if l.startswith('I '):
            p = l.split(None, 3)
            ins[int(p[1], 16)] = (int(p[2]), p[3].rstrip())

    blocks = json.load(open(a.blocks))['blocks']
    by_addr = {b['addr']: b for b in blocks}
    out = []
    for b in sorted(blocks, key=lambda x: x['addr']):
        if not b['name'].startswith(GENERIC) or b['size'] > a.max_size:
            continue
        if not lo <= b['addr'] < hi:
            continue
        body, p = [], b['addr']
        while p < b['addr'] + b['size']:
            ln, t = ins.get(p, (2, '?'))
            body.append(t)
            p += ln
        core = [t for t in body if not t.startswith('nop')]
        if not core or any(CALL.match(t) for t in core):
            continue
        jumps = [t for t in core if JUMP.match(t)]
        if len(jumps) != 1:
            continue
        # переход должен быть последним по смыслу: за ним только слот задержки
        i = core.index(jumps[0])
        if i < len(core) - 2:
            continue
        tgt = int(JUMP.match(jumps[0]).group(2), 16)
        tb = by_addr.get(tgt)
        if not tb or tb['name'].startswith(GENERIC):
            continue
        out.append((b['addr'], tb['name'], b['size'], len(core) - 1))

    names = collections.Counter(x[1] for x in out)
    used = {b['name'] for b in blocks}
    written = 0
    if a.out:
        with open(a.out, 'a') as f:
            f.write('\n# --- переходники: подготовка аргументов и хвостовой '
                    'переход в названную функцию (%s), name_tail_calls.py ---\n'
                    % a.tag)
            for ad, tn, sz, nprep in out:
                nm = 'tail_%s' % tn
                if names[tn] > 1 or nm in used:
                    nm = 'tail_%s__%06x' % (tn, ad)
                if nm in used:
                    continue
                used.add(nm)
                written += 1
                f.write('0x%08x %s # %d инструкций подготовки, переход в %s\n'
                        % (ad, nm, nprep, tn))
    print('%s: переходников %d, записано %d' % (a.tag, len(out), written))


if __name__ == '__main__':
    main()
