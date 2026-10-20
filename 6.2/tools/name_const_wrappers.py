#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Имена обёрток, которые зовут названную функцию с константами.

Очень много мелких блоков устроены одинаково: положить константы в
регистры и вызвать общую подпрограмму. Про такой блок известно ровно
всё, и имя может это сказать целиком.

Особый случай — семейство битовых полей. У примитива `bf__insert_field`
**r10 это сдвиг, а r11 — ШИРИНА МИНУС ЕДИНИЦА** (`bmsk r0,r0,r11`), так
что обёртка `r10=0x4, r11=0xb` описывает поле «биты 4..15», то есть
сдвиг 4 ширина 12. В 4.1 на этом ошиблись: все 14 имён `bf_*_uc` были
смещены на единицу, потому что r11 приняли за ширину.

Остальные обёртки получают имя вида `<цель>__<рег>_<значение>`.
"""
import argparse, json, re

CALL = re.compile(r'^_?(?:bl|b)(?:\.d)?\s+0x00([0-9a-f]{6})$')
MOV = re.compile(r'^_?mov(?:_s)?\s+(r\d+),\s*(0x[0-9a-f]+|\d+)$')
GENERIC = ('sub_', 'blk_', 'FUN_')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--max-size', type=int, default=40)
    ap.add_argument('--max-insns', type=int, default=6)
    ap.add_argument('--out')
    ap.add_argument('--tag', default='fw')
    a = ap.parse_args()

    ins = {}
    for l in open(a.insns):
        if l.startswith('I '):
            p = l.split(None, 3)
            ins[int(p[1], 16)] = (int(p[2]), p[3].rstrip())
    st = sorted(json.load(open(a.blocks))['blocks'], key=lambda b: b['addr'])
    by_addr = {b['addr']: b for b in st}
    used = {b['name'] for b in st}

    out = []
    for b in st:
        if not b['name'].startswith(GENERIC) or b['size'] > a.max_size:
            continue
        body, p = [], b['addr']
        while p < b['addr'] + b['size']:
            ln, t = ins.get(p, (2, '?'))
            body.append(t)
            p += ln
        core = [t for t in body if not t.startswith('nop')]
        calls = [t for t in core if CALL.match(t)]
        movs = [MOV.match(t) for t in core if MOV.match(t)]
        if len(calls) != 1 or not movs or len(core) > a.max_insns:
            continue
        tb = by_addr.get(int(CALL.match(calls[0]).group(1), 16))
        if not tb or tb['name'].startswith(GENERIC):
            continue
        args = {m.group(1): int(m.group(2), 0) for m in movs}
        if tb['name'].startswith('bf__') and 'r10' in args and 'r11' in args:
            nm = 'bf_set_s%d_w%d%s' % (args['r10'], args['r11'] + 1,
                                       '_' + a.tag if a.tag == 'uc' else '')
            why = 'поле: сдвиг %d, ширина %d (r11+1), через %s' % (
                args['r10'], args['r11'] + 1, tb['name'])
        else:
            # разделитель обязателен: «r15» читается и как r1=5, и как r15
            parts = '_'.join('%s_%x' % (k, v) for k, v in sorted(args.items())[:2])
            nm = '%s__%s' % (tb['name'], parts)
            why = 'обёртка: %s с %s' % (tb['name'],
                                        ', '.join('%s=0x%x' % kv for kv in sorted(args.items())))
        if len(nm) > 60:
            continue
        if nm in used:
            nm = '%s_%06x' % (nm, b['addr'])
        used.add(nm)
        out.append((b['addr'], nm, why))

    if a.out:
        with open(a.out, 'a') as f:
            f.write('\n# --- обёртки с константными аргументами (%s), '
                    'name_const_wrappers.py. Для семейства bf_* ширина '
                    'поля = r11 + 1 ---\n' % a.tag)
            for ad, nm, why in out:
                f.write('0x%08x %s # %s\n' % (ad, nm, why))
    print('%s: обёрток названо %d' % (a.tag, len(out)))


if __name__ == '__main__':
    main()
