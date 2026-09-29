#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Имя листового блока: ни вызовов, ни циклов, ни обращений к данным.

Такой блок работает только с переданными аргументами и регистрами —
про него больше нечего сказать, и `leaf_<адрес>` описывает его
ПОЛНОСТЬЮ. Это та же порода честных классов, что принятые в проекте
`tail_`, `epi_`, `frag_`, `stub_ret_`: не догадка о смысле, а точное
описание формы.

Блоки с вызовами сюда не попадают: у них есть связи, и имя должно
приходить из разбора, а не из формы.
"""
import argparse, json, re

CALL = re.compile(r'^_?(?:bl|jl)')
LOOP = re.compile(r'^_?(?:lp|lpne|lpcc|lphi)\b')
# Данные — не только литеральный адрес, но и доступ через gp: `ld_s r0,[gp,0x20c]`
# абсолютного адреса в тексте не содержит, и прежняя проверка его не видела.
DATA = re.compile(r'\b0x8[0-9a-b][0-9a-f]{4}\b|\[gp')
# Безусловный переход за пределы блока — это хвостовой ВЫЗОВ, а переход
# назад внутри блока — ЦИКЛ. Ни того, ни другого у листа быть не может.
JUMP = re.compile(r'^_?(?:b|j)(?:_s)?(?:\.d)?\s+0x00([0-9a-f]{6})$')
INDIRECT = re.compile(r'^_?j(?:_s)?(?:\.d)?\s+r\d+$')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--lo', required=True)
    ap.add_argument('--hi', required=True)
    ap.add_argument('--min-size', type=int, default=8)
    ap.add_argument('--out')
    ap.add_argument('--tag', default='fw')
    a = ap.parse_args()
    lo, hi = int(a.lo, 16), int(a.hi, 16)

    ins = {}
    for l in open(a.insns):
        if l.startswith('I '):
            p = l.split(None, 3)
            ad = int(p[1], 16)
            if lo <= ad < hi:
                ins[ad] = (int(p[2]), p[3].rstrip())

    st = sorted(json.load(open(a.blocks))['blocks'], key=lambda b: b['addr'])
    out = []
    for b in st:
        if not b['name'].startswith(('sub_', 'blk_')) or b['size'] < a.min_size:
            continue
        body, p = [], b['addr']
        while p < b['addr'] + b['size']:
            ln, t = ins.get(p, (2, '?'))
            body.append(t)
            p += ln
        txt = ' '.join(body)
        if any(CALL.match(t) for t in body) or any(LOOP.match(t) for t in body):
            continue
        if DATA.search(txt):
            continue
        if any(INDIRECT.match(t) for t in body):
            continue
        out_of_block = False
        p2 = b['addr']
        for t in body:
            m = JUMP.match(t)
            if m:
                tgt = int(m.group(1), 16)
                if not (b['addr'] <= tgt < b['addr'] + b['size']):
                    out_of_block = True      # хвостовой вызов
                elif tgt <= p2:
                    out_of_block = True      # переход назад — цикл
            p2 += 2
        if out_of_block:
            continue
        out.append((b['addr'], 'leaf_%06x' % b['addr'], b['size'], len(body)))

    if a.out:
        with open(a.out, 'a') as f:
            f.write('\n# --- листовые блоки (%s): ни вызовов, ни циклов, ни '
                    'обращений к данным — работают только с аргументами. '
                    'Имя описывает форму полностью (name_leaf_blocks.py) ---\n'
                    % a.tag)
            for ad, nm, sz, n in out:
                f.write('0x%08x %s # лист, %d инструкций, %d Б\n' % (ad, nm, n, sz))
    print('%s: листовых блоков %d, байт %d' % (a.tag, len(out), sum(x[2] for x in out)))


if __name__ == '__main__':
    main()
