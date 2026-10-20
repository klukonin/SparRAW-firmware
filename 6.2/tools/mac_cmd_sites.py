#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Статический список отправок в кольцо команд MAC с символьным разбором.

Значение слова восстанавливается небольшим интерпретатором в пределах
ОДНОГО блока (на границе состояние сбрасывается -- иначе легко подобрать
чужую константу и получить мнимую команду).  Когда значение не сводится к
числу, инструмент не сдаётся, а сохраняет формулу: этого хватает, чтобы
узнать КОД команды или хотя бы его базу.

Ключевая идиома вендорского кода -- код получается сдвигом на 24:

    add  r0,0x52 ; asl r0,r0,0x18      ->  код = 0x52 + индекс
    add1 r3,r14,0x29 ; asl r3,r3,0x18  ->  то же (add1 = rb + rc*2)
    mov  r7,0x49000000 ; bset r2,r7,r6 ->  код 0x49, бит = индекс+6

Поэтому часть кодов видна только на железе: их старший байт возникает в
рантайме.  Такие отправки печатаются с базой и пометкой «+idx».

    mac_cmd_sites.py > ref/MAC-CMD-SITES.txt
"""
import argparse, bisect, json, re, sys

M = 0xffffffff
SEND = re.compile(r'\bmov(?:_s)?(?:\.\w+)?\s+r32,\s*(0x[0-9a-f]+|-?\d+|r\d+)$')
R3 = re.compile(r'\b(add|add1|add2|add3|sub|or|and|xor|bset|bclr|bmsk|asl|lsr|ror)'
                r'(?:_s)?(?:\.\w+)?\s+(r\d+),\s*(r\d+),\s*(0x[0-9a-f]+|-?\d+|r\d+)$')
R2 = re.compile(r'\b(add|sub|or|and|xor|bset|bclr|bmsk|asl|lsr)'
                r'(?:_s)?(?:\.\w+)?\s+(r\d+),\s*(0x[0-9a-f]+|-?\d+|r\d+)$')
MOVI = re.compile(r'\bmov(?:_s)?(?:\.\w+)?\s+(r\d+),\s*(0x[0-9a-f]+|-?\d+)$')
MOVR = re.compile(r'\bmov(?:_s)?(?:\.\w+)?\s+(r\d+),\s*(r\d+)$')
WRITE = re.compile(r'\b[a-z][a-z0-9._]*\s+(r\d+)\s*,')


def num(s):
    return int(s, 0) & M


class Sym(str):
    """Неизвестное значение с человекочитаемой формулой."""


def apply(op, a, b):
    ci, cj = isinstance(a, int), isinstance(b, int)
    if ci and cj:
        if op == 'add':  return (a + b) & M
        if op == 'add1': return (a + (b << 1)) & M
        if op == 'add2': return (a + (b << 2)) & M
        if op == 'add3': return (a + (b << 3)) & M
        if op == 'sub':  return (a - b) & M
        if op == 'or':   return a | b
        if op == 'and':  return a & b
        if op == 'xor':  return a ^ b
        if op == 'bset': return a | (1 << (b & 31))
        if op == 'bclr': return a & ~(1 << (b & 31)) & M
        if op == 'bmsk': return a & ((1 << ((b & 31) + 1)) - 1)
        if op == 'asl':  return (a << (b & 31)) & M
        if op == 'lsr':  return (a & M) >> (b & 31)
        if op == 'ror':  return ((a >> (b & 31)) | (a << (32 - (b & 31)))) & M
        return None
    sa = ('0x%x' % a) if ci else str(a)
    sb = ('0x%x' % b) if cj else str(b)
    if op == 'asl' and cj and b == 24:
        return Sym('(%s)<<24' % sa)
    if op in ('add', 'add1', 'add2', 'add3') and ci:
        mult = {'add': 1, 'add1': 2, 'add2': 4, 'add3': 8}[op]
        return Sym('0x%x+idx' % a if mult == 1 else '0x%x+%d*idx' % (a, mult))
    if op in ('add', 'add1', 'add2', 'add3') and cj:
        mult = {'add': 1, 'add1': 2, 'add2': 4, 'add3': 8}[op]
        return Sym('0x%x+idx' % (b * mult) if mult > 1 else '0x%x+idx' % b)
    if op == 'bmsk' and cj and b == 0x17:
        return Sym('idx24')          # обрезано до 24 бит: старший байт чист
    if op == 'bset' and ci:
        return Sym('0x%x|bit(%s)' % (a, sb))
    if op == 'bset' and cj and b >= 24:
        # код собирают цепочкой bset поверх неизвестной базы:
        #   bset r2,r2,0x19 ; bset r2,r2,0x1b ; bset r2,r2,0x1d  ->  0x2a
        m = re.match(r'^(.*)\|B\(([\d,]+)\)$', str(a))
        if m:
            bits = m.group(2) + ',%d' % b
            return Sym('%s|B(%s)' % (m.group(1), bits))
        return Sym('%s|B(%d)' % (a, b))
    if op == 'or' and ci:
        return Sym('0x%x|%s' % (a, sb))
    if op == 'or' and cj:
        return Sym('0x%x|%s' % (b, sa))
    if op == 'or' and not ci and not cj:
        # `or r0,r0,r13`, где одна половина уже несёт код команды:
        # старший байт даёт она, вторая половина лишь дополняет параметр
        for x, y in ((a, b), (b, a)):
            if re.match(r'^0x[0-9a-f]{2}0{6}\|', str(x)) or '|B(' in str(x):
                return Sym(str(x))
    return None


def code_of(v):
    """-> (код, вид): вид 'exact' | 'idx' (база+индекс) | 'maybe' | None.

    Для формулы `A|X` код равен старшему байту A только если X заведомо не
    трогает старшие 8 бит (то есть был обрезан bmsk по 24 битам).  Иначе
    код лишь ПРЕДПОЛОЖИТЕЛЕН -- об этом надо говорить прямо, а не выдавать
    догадку за факт.
    """
    if isinstance(v, int):
        return (v >> 24) & 0xff, 'exact'
    if isinstance(v, Sym):
        m = re.match(r'^\((0x[0-9a-f]+)\+(?:\d\*)?idx\)<<24$', v)
        if m:
            return int(m.group(1), 0) & 0xff, 'idx'
        m = re.match(r'^.*\|B\(([\d,]+)\)$', v)
        if m:
            code = 0
            for b in m.group(1).split(','):
                code |= 1 << (int(b) - 24)
            return code, 'bits'
        if re.match(r'^\(.*\)<<24$', v):
            return None, 'computed'   # код возникает в рантайме, база неизвестна
        m = re.match(r'^(0x[0-9a-f]+)\|(.+)$', v)
        if m:
            hi = (int(m.group(1), 0) >> 24) & 0xff
            if m.group(2) == 'idx24':
                return hi, 'exact'
            if hi:
                return hi, 'maybe'
    return None, None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--seg', default='uc')
    ap.add_argument('--insns', default='../blobs/insns/INSNS-4100.txt')
    ap.add_argument('--lo', default='0x920000')
    ap.add_argument('--hi', default='0x940000')
    a = ap.parse_args()
    lo, hi = int(a.lo, 16), int(a.hi, 16)

    d = json.load(open('src/asm/%s/blocks.json' % a.seg))
    st = sorted(d['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]

    reg, cur, out = {}, None, []
    for l in open(a.insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if not (lo <= ad < hi):
            continue
        t = p[3].rstrip().lstrip('_')
        b = st[bisect.bisect_right(ads, ad) - 1]
        if b is not cur:
            cur, reg = b, {}

        m = SEND.search(t)
        if m:
            v = m.group(1)
            out.append((ad, reg.get(v) if v.startswith('r') else num(v), b['name']))
            continue
        m = MOVI.search(t)
        if m:
            reg[m.group(1)] = num(m.group(2))
            continue
        m = MOVR.search(t)
        if m:
            src = reg.get(m.group(2))
            reg.pop(m.group(1), None) if src is None else reg.__setitem__(m.group(1), src)
            continue
        m = R3.search(t)
        if m:
            op, rd, rb, rc = m.groups()
            x = reg.get(rb)
            y = reg.get(rc) if rc.startswith('r') else num(rc)
            r = None
            if x is not None and y is not None:
                r = apply(op, x, y)
            elif x is not None:
                r = apply(op, x, Sym('idx'))
            elif y is not None:
                r = apply(op, Sym('idx'), y)
            reg.pop(rd, None) if r is None else reg.__setitem__(rd, r)
            continue
        m = R2.search(t)
        if m:
            op, rd, rc = m.groups()
            x = reg.get(rd)
            y = reg.get(rc) if rc.startswith('r') else num(rc)
            r = None
            if x is not None and y is not None:
                r = apply(op, x, y)
            elif x is not None:
                r = apply(op, x, Sym('idx'))
            elif y is not None:
                # `add_s r0,0x52` над неизвестным r0 -- это и есть «база+индекс»
                r = apply(op, Sym('idx'), y)
            reg.pop(rd, None) if r is None else reg.__setitem__(rd, r)
            continue
        m = WRITE.match(t)
        if m and m.group(1) != 'r32':
            reg.pop(m.group(1), None)

    n = {'exact': 0, 'idx': 0, 'maybe': 0, 'computed': 0, 'bits': 0, None: 0}
    for ad, val, nm in out:
        code, kind = code_of(val)
        n[kind] += 1
        if isinstance(val, int):
            print('0x%06x  %08x  0x%02x %06x  %s'
                  % (ad, val, (val >> 24) & 0xff, val & 0xffffff, nm))
        elif kind == 'idx':
            print('0x%06x  вычисл.   0x%02x+idx  %-38s %s' % (ad, code, str(val), nm))
        elif kind == 'exact':
            print('0x%06x  частично  0x%02x ??????  %-38s %s' % (ad, code, str(val), nm))
        elif kind == 'bits':
            print('0x%06x  биты      0x%02x ??????  %-38s %s' % (ad, code, str(val), nm))
        elif kind == 'computed':
            print('0x%06x  РАНТАЙМ   ??+idx    %-38s %s' % (ad, str(val), nm))
        elif kind == 'maybe':
            print('0x%06x  вероятно  0x%02x?????  %-38s %s' % (ad, code, str(val), nm))
        else:
            print('0x%06x  ????????  -           %-38s %s'
                  % (ad, str(val) if val is not None else '', nm))
    print('# отправок: %d; точных: %d; база+индекс: %d; код из bset-битов: %d; '
          'в рантайме: %d; вероятных: %d; неизвестных: %d'
          % (len(out), n['exact'], n['idx'], n['bits'], n['computed'], n['maybe'],
             n[None]), file=sys.stderr)


if __name__ == '__main__':
    main()
