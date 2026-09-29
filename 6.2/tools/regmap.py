#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Карта периферийных регистров 6.2 (0x880000..0x88ffff) из дерева.

Для каждого блока fw и ucode инструкции идут по порядку с распространением
констант (см. scan): адреса вида `mov rX,0x88xxxx` + смещение, собранные
сдвигом/сложением, прямые `[0x88xxxx]`, массивы `[база, индекс]` («[]»).

Смысл регистра берётся из ref/REGS-KNOWN.txt (`0xADDR имя # смысл`, ведётся
руками по находкам); узел страницы 0x100 — по самому частому префиксу
модуля у обращающихся блоков. Упоминания — файлы ref/*.md с этим адресом.

    tools/regmap.py                 # пишет ref/REGS-62.md
    tools/regmap.py --stat          # только сводка
"""
import argparse, bisect, collections, glob, json, re

LO, HI = 0x880000, 0x890000
M32 = 0xffffffff
MEM = re.compile(r'^(ld|st)(b|w)?(?:_s)?((?:\.[a-z]+)*)\s+(?:(\S+),)?\[([^\]]+)\]')
IMM = re.compile(r'^-?(0x[0-9a-f]+|\d+)$')
CALL = re.compile(r'^(bl|jl)(?:[a-z]*)?(?:_s)?(\.d)?\b')


def num(s):
    s = s.strip()
    return int(s, 16) if '0x' in s else int(s)


def alu(op, a, b):
    """Значение операции ARC над известными операндами; None — не умеем."""
    if op == 'add':
        return a + b
    if op == 'sub':
        return a - b
    if op == 'rsub':
        return b - a
    if op in ('add1', 'add2', 'add3'):
        return a + (b << int(op[3]))
    if op in ('sub1', 'sub2', 'sub3'):
        return a - (b << int(op[3]))
    if op == 'asl':
        return a << (b & 31)
    if op == 'lsr':
        return a >> (b & 31)
    if op == 'or':
        return a | b
    if op == 'and':
        return a & b
    if op == 'bic':
        return a & ~b
    if op == 'xor':
        return a ^ b
    if op == 'bset':
        return a | (1 << (b & 31))
    if op == 'bclr':
        return a & ~(1 << (b & 31))
    if op == 'bmsk':
        return a & ((1 << ((b & 31) + 1)) - 1)
    return None


def scan(insns, blocks, lo, hi):
    """Распространение констант по блоку в порядке адресов.

    Известные значения регистров идут от mov с константой и арифметики над
    известными (add/sub/asl/lsr/or/and/bic/bset/bclr/bmsk/add1-3/extb/extw),
    так ловятся и адреса, собранные сдвигом (0x11<<19 = 0x880000). Вызов
    (bl/jl) портит r0..r12 и blink (с учётом слота задержки .d);
    условная запись (mov.ne …) и любая иная запись в регистр делают его
    неизвестным. Ветвления внутри блока не разветвляют состояние —
    приближение: адрес может потеряться, но выдумывается лишь при записи
    в регистр на обходном пути, чего в коротких аксессорах не бывает.
    Обращение [база, индекс-регистр] с известной базой записывается как
    массив («[]»)."""
    st = sorted(blocks, key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]
    acc = collections.defaultdict(lambda: collections.defaultdict(set))
    cur, val, pend = None, {}, 0

    def clobber():
        # адрес регистра, переданный вызову в r0..r3, — обращение через
        # помощник («A»)
        for r in ('r0', 'r1', 'r2', 'r3'):
            a = val.get(r)
            if a is not None and LO <= a < HI:
                acc[a & ~3][cur['name']].add('A')
        for r in ['r%d' % i for i in range(13)] + ['blink']:
            val.pop(r, None)

    def get(o):
        o = o.strip()
        if IMM.match(o):
            return num(o) & M32
        return val.get(o)

    for l in open(insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if not lo <= ad < hi:
            continue
        b = st[bisect.bisect_right(ads, ad) - 1]
        if b is not cur:
            cur, val, pend = b, {}, 0
        t = p[3].strip().lstrip('_')
        mn, _, rest = t.partition(' ')
        ops = [x.strip() for x in rest.split(',')] if rest else []
        after = pend == 1
        pend = max(0, pend - 1)
        m = MEM.match(t)
        if m:
            kind = 'R' if m.group(1) == 'ld' else 'W'
            mods = m.group(3)
            mo = [x.strip() for x in m.group(5).split(',')]
            a, arr = None, False
            if len(mo) == 1:
                a = get(mo[0])
            else:
                x, y = get(mo[0]), get(mo[1])
                if x is not None and y is not None:
                    a = (x + y) & M32
                elif x is not None and not IMM.match(mo[1]):
                    a, arr = x, True
            if a is not None and LO <= a < HI:
                acc[a & ~3][b['name']].add(kind + ('[]' if arr else ''))
            if ('.aw' in mods or '.ab' in mods or '.a' == mods) and len(mo) == 2:
                x, y = val.get(mo[0]), get(mo[1])
                if x is not None and y is not None:
                    val[mo[0]] = (x + y) & M32
                else:
                    val.pop(mo[0], None)
            if kind == 'R' and m.group(4):
                val.pop(m.group(4), None)
        elif CALL.match(mn):
            if CALL.match(mn).group(2):
                pend = 1            # слот задержки выполняется до вызова
            else:
                clobber()
        elif ops and re.match(r'^(r\d+|gp|fp|sp|blink)$', ops[0]):
            base = mn.split('.')[0].replace('_s', '')
            cond = '.' in mn and any(c in mn.split('.')[1:] for c in
                   ('eq', 'ne', 'z', 'nz', 'lt', 'ge', 'gt', 'le', 'lo', 'hs',
                    'hi', 'ls', 'pl', 'mi', 'cc', 'cs', 'c', 'nc', 'p', 'n'))
            d = ops[0]
            v = None
            if not cond:
                if base == 'mov' and len(ops) == 2:
                    v = get(ops[1])
                elif base in ('extb', 'extw') and len(ops) == 2:
                    s = get(ops[1])
                    v = None if s is None else s & (0xff if base == 'extb' else 0xffff)
                elif len(ops) == 3:
                    a1, a2 = get(ops[1]), get(ops[2])
                    if a1 is not None and a2 is not None:
                        v = alu(base, a1, a2)
                elif len(ops) == 2 and base in ('asl', 'lsr'):
                    s = get(ops[1])
                    v = None if s is None else alu(base, s, 1)
            if v is None:
                val.pop(d, None)
            else:
                val[d] = v & M32
        if after:
            clobber()
    return acc


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', default='../blobs/insns/INSNS-6200.txt')
    ap.add_argument('--out', default='ref/REGS-62.md')
    ap.add_argument('--stat', action='store_true')
    a = ap.parse_args()

    acc = collections.defaultdict(dict)
    for seg, lo, hi in (('fw', 0x8c0000, 0x900000), ('uc', 0x920000, 0x940000)):
        bl = json.load(open(f'src/asm/{seg}/blocks.json'))['blocks']
        for r, users in scan(a.insns, bl, lo, hi).items():
            for n, k in users.items():
                acc[r][(seg, n)] = k

    known = {}
    for l in open('ref/REGS-KNOWN.txt'):
        l = l.rstrip('\n')
        if not l.startswith('0x'):
            continue
        ad, rest = l.split(None, 1)
        name, _, mean = rest.partition('#')
        known[int(ad, 16)] = (name.strip(), mean.strip())

    docs = {}
    for f in sorted(glob.glob('ref/*.md')):
        if f.endswith('REGS-62.md'):
            continue
        docs[f] = open(f).read().lower()

    def mentions(r):
        k = '0x%06x' % r
        return [f[4:-3] for f, t in docs.items() if k in t]

    pages = collections.defaultdict(list)
    for r in sorted(set(acc) | set(known)):
        pages[r & ~0xff].append(r)

    def unit(regs):
        c = collections.Counter()
        for r in regs:
            for (seg, n) in acc.get(r, {}):
                if '__' in n:
                    c[n.split('__')[0]] += 1
        return ', '.join(x for x, _ in c.most_common(3)) or '—'

    nk = sum(1 for r in acc if r in known)
    print('регистров с обращениями: %d, из них со смыслом в REGS-KNOWN: %d; '
          'в REGS-KNOWN всего %d' % (len(acc), nk, len(known)))
    if a.stat:
        return

    o = ['# Периферийные регистры 6.2 (0x880000..0x88ffff)', '',
         'Сгенерировано `tools/regmap.py` из дерева `src/asm` и '
         '`ref/REGS-KNOWN.txt` — руками не править, править REGS-KNOWN и '
         'пересобрать (`make regs`).', '',
         'Столбцы: адрес (выровнен на слово); имя и смысл из REGS-KNOWN; '
         'обращения — блоки fw/uc (R чтение, W запись, [] — массив с '
         'индексом в регистре, A — адрес передан аргументом вызова; распространение констант по блоку, обращения '
         'через аргументы функций не видны); '
         'документы, где адрес упомянут. Хостовое окно: fw_peri = '
         '0x908000 + (A − 0x840000)… для 0x88xxxx — см. BLOBS.md.', '',
         'Регистровый файл MAC r36..r56 (ARC aux ucode) — отдельно, '
         'MSXD_LR_RGF в `ref/`.', '',
         'Всего регистров с обращениями: %d; со смыслом: %d.' % (len(acc), nk), '']
    for pg in sorted(pages):
        regs = pages[pg]
        o.append('## 0x%06x — %s' % (pg, unit(regs)))
        o.append('')
        o.append('| адрес | имя | смысл | обращения | документы |')
        o.append('|---|---|---|---|---|')
        for r in regs:
            nm, mean = known.get(r, ('', ''))
            us = sorted(acc.get(r, {}).items())
            s = ', '.join('%s`%s` %s' % ('uc:' if seg == 'uc' else '', n, ''.join(sorted(k)))
                          for (seg, n), k in us[:6])
            if len(us) > 6:
                s += ' … (+%d)' % (len(us) - 6)
            o.append('| 0x%06x | %s | %s | %s | %s |' % (
                r, nm, mean.replace('|', '/'), s or '—', ', '.join(mentions(r)) or '—'))
        o.append('')
    open(a.out, 'w').write('\n'.join(o))
    print('записано', a.out)


if __name__ == '__main__':
    main()
