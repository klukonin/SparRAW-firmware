#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Имя мелкого блока по полю объекта, которое он трогает.

Хвост безымянных в fw_code — это в основном крошечные методы, которые
получают указатель на объект в r0 и читают или пишут одно его поле:

    j_s.d blink ; _ldw r0,[r0,0x52]        -> field_get_0x52
    mov_s r1,0x0 ; st_s r1,[r0,0x4] ; ...  -> field_set_0x04

Имя говорит ровно то, что видно: блок работает с полем по такому-то
смещению от переданного указателя. Какому классу принадлежит объект,
из тела блока не видно, поэтому в имени этого и нет — «лучше sub_, чем
красивая ложь», а здесь есть что сказать точнее, чем sub_.

Принимается только блок, у которого смещение РОВНО одно и база — сам
аргумент r0 (не глобал и не регистровый блок: те разбирают
name_by_global.py и name_by_rgf.py). Одиночный переход получает имя
переходника tail_<цель>.
"""
import argparse, collections, json, re

ACC = re.compile(r'^_?(ld|ldb|ldw|st|stb|stw)(_s)?(\.\w+)?\s+[^,]+,\s*\[r0'
                 r'(?:,\s*(-?0x[0-9a-f]+|-?\d+))?\]$')
OTHER_MEM = re.compile(r'\[(?!r0[,\]])(r\d+|gp|sp)')
JUMP = re.compile(r'^_?b(\.d)?\s+0x00([0-9a-f]{6})$')


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
    names = {b['name'] for b in blocks}
    by_addr = {b['addr']: b for b in blocks}
    out, stats = [], collections.Counter()
    for b in sorted(blocks, key=lambda x: x['addr']):
        if not b['name'].startswith(('sub_', 'blk_')):
            continue
        if not (lo <= b['addr'] < hi) or b['size'] > a.max_size:
            continue
        body, p = [], b['addr']
        while p < b['addr'] + b['size']:
            ln, t = ins.get(p, (2, '?'))
            body.append(t)
            p += ln
        core = [t for t in body if not t.startswith('nop')]
        if not core:
            continue

        # одиночный переход — переходник
        if len(core) <= 2:
            m = JUMP.match(core[0])
            if m:
                tgt = int(m.group(2), 16)
                tb = by_addr.get(tgt)
                if tb and not tb['name'].startswith(('sub_', 'blk_')):
                    out.append((b['addr'], 'tail_%s' % tb['name'], b['size'],
                                'переход в %s' % tb['name']))
                    stats['переходник'] += 1
                    continue

        # Если r0 в блоке загружен константой (в том числе собран
        # сдвигом: `mov r0,0x11 ; asl r0,r0,0x13` = 0x880000), то это не
        # аргумент-указатель, а база регистрового блока, и имя
        # `field_get_0x08` скрывало бы доступ к конкретному регистру.
        if any(re.match(r'^_?mov(?:_s)?\s+r0,\s*(0x[0-9a-f]+|\d+)$', t)
               or re.match(r'^_?asl(?:_s)?\s+r0,', t) for t in core):
            continue
        offs, kinds, dirty = set(), set(), False
        for t in core:
            m = ACC.match(t)
            if m:
                offs.add(int(m.group(4), 0) if m.group(4) else 0)
                kinds.add('r' if m.group(1).startswith('ld') else 'w')
                continue
            if OTHER_MEM.search(t):
                dirty = True      # трогает не только объект в r0
        if dirty or len(offs) != 1:
            continue
        off = next(iter(offs))
        pref = 'field_get' if kinds == {'r'} else (
            'field_set' if kinds == {'w'} else 'field_rw')
        out.append((b['addr'], '%s_0x%02x__%06x' % (pref, off & 0xffff, b['addr']),
                    b['size'], 'единственное поле [r0,0x%x]' % off))
        stats[pref] += 1

    if a.out:
        with open(a.out, 'a') as f:
            f.write('\n# --- мелкие блоки по единственному полю объекта в r0 '
                    '(%s), name_by_obj_field.py ---\n' % a.tag)
            for ad, nm, sz, why in out:
                f.write('0x%08x %s # %s, %d Б\n' % (ad, nm, why, sz))
    print('%s: имён %d, байт %d; по видам: %s'
          % (a.tag, len(out), sum(x[2] for x in out), dict(stats)))


if __name__ == '__main__':
    main()
