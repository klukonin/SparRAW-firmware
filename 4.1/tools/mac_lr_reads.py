#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Расшифровка локальных чтений MAC: команда 0x1d выбирает селектор, затем
микрокод читает регистр результата r36..r56.

Идиома (подтверждена на 4.1 и на железе):
    and rX,rX,0xffff0fff     ; в теневой копии [gp,-0x44] обнулить поле
    or  rX,rX,0x1d00N000     ; положить индекс селектора N
    mov r32,rX               ; отправить
    nop / nop / mov 0,0      ; задержка конвейера
    ... rNN ...              ; забрать результат (r36..r56)

Имя элемента берётся из ref/MSXD-LR-RGF.txt: группа = регистр
результата, индекс в группе = значение селектора.

    mac_lr_reads.py > ref/MAC-LR-READS.txt
"""
import argparse, bisect, json, re, sys, collections

AND = re.compile(r'\band\s+(r\d+),\s*r\d+,\s*(0x[0-9a-f]{8})$')
OR = re.compile(r'\bor\s+(r\d+),\s*r\d+,\s*(0x1d[0-9a-f]{6})$')
SEND = re.compile(r'\bmov(?:_s)?\s+r32,\s*(r\d+)$')
USE = re.compile(r'\br(3[6-9]|4[0-9]|5[0-6])\b')


def load_rgf(path):
    """группа -> {индекс: имя}"""
    tab, grp = {}, None
    for l in open(path, encoding='utf-8'):
        if l.startswith('== '):
            grp = l[3:].strip()
            tab.setdefault(grp, {})
        elif l.startswith('[') and grp:
            m = re.match(r'\[(\d+)\]\s+(\S+)', l)
            if m:
                tab[grp].setdefault(int(m.group(1)), m.group(2))
    return tab


def group_for(reg, tab):
    """r40 -> ключ группы в файле (R40 или R40_SINGLE_MAPPED)"""
    for k in tab:
        if k.split('_')[0] == 'R%s' % reg:
            return k
    return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', default='../blobs/insns/INSNS-4100.txt')
    ap.add_argument('--rgf', default='../6.2/ref/MSXD-LR-RGF.txt')
    ap.add_argument('--lo', default='0x920000')
    ap.add_argument('--hi', default='0x940000')
    a = ap.parse_args()
    lo, hi = int(a.lo, 16), int(a.hi, 16)
    tab = load_rgf(a.rgf)

    d = json.load(open('src/asm/uc/blocks.json'))
    st = sorted(d['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]

    ins = []
    for l in open(a.insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if lo <= ad < hi:
            ins.append((ad, p[3].rstrip().lstrip('_')))

    masks, vals = {}, {}
    found, named = 0, 0
    for i, (ad, t) in enumerate(ins):
        m = AND.search(t)
        if m:
            masks[m.group(1)] = int(m.group(2), 16)
            continue
        m = OR.search(t)
        if m:
            vals[m.group(1)] = int(m.group(2), 16)
            continue
        m = SEND.search(t)
        if not m:
            continue
        reg = m.group(1)
        val = vals.pop(reg, None)
        mask = masks.pop(reg, None)
        if val is None:
            continue
        # позиция обнулённого полубайта = позиция поля
        shift = None
        if mask is not None:
            for s in range(0, 24, 4):
                if ((~mask) >> s) & 0xf == 0xf:
                    shift = s
                    break
        sel = (val >> shift) & 0xf if shift is not None else None
        # первый прочитанный регистр результата после задержки
        rr = None
        for j in range(i + 1, min(i + 12, len(ins))):
            if SEND.search(ins[j][1]):
                break
            u = USE.search(ins[j][1])
            if u:
                rr = u.group(1)
                break
        if rr is None:
            continue
        found += 1
        b = st[bisect.bisect_right(ads, ad) - 1]
        g = group_for(rr, tab)
        nm = tab.get(g, {}).get(sel) if (g and sel is not None) else None
        if nm:
            named += 1
        print('0x%06x  0x%08x  поле[%s]  сел=%s  r%s  %-28s %s'
              % (ad, val, ('%d:%d' % (shift + 3, shift)) if shift is not None else '?',
                 ('0x%x' % sel) if sel is not None else '?', rr,
                 nm or '(нет в файле)', b['name']))
    print('# чтений разобрано: %d, из них названо по MSXD_LR_RGF: %d'
          % (found, named), file=sys.stderr)


if __name__ == '__main__':
    main()
