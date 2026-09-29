#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Разрез склеенных блоков по границе «возврат, затем пролог».

Ghidra не выделяет функцию, на которую никто не ссылается напрямую —
например, ту, что вызывается только через таблицу или указатель. Такая
функция прилипает к предыдущей, и блок разрастается: в fw 6.2 так
получился блок на 1008 байт, где первые четыре байта — переход, а за
ними несколько самостоятельных функций.

Признак границы механический и не требует догадок: инструкция
безусловного возврата (`j [blink]`, `j_s [blink]`, в том числе в слоте
задержки), а сразу за ней — начало пролога: `push_s blink`,
`st.a r13,[sp,…]` или `st.a blink,[sp,…]`.

Адрес, вписанный в NAMES-EXTRA, создаёт границу; байты образа не
меняются, гейт обязан остаться побайтовым.
"""
import argparse, json, re

# Функция кончается не только возвратом `j [blink]`. Чаще она уходит
# хвостовым переходом на милликод-восстановитель (`b 0x8c01f4…0x8c025c`
# = __ld_rNN_to_r13_ret) или на общий эпилог. Ревизия показала: из 65
# границ склеенных блоков fw признаку `j [blink]` отвечают только 6,
# остальные 59 — именно безусловный переход.
RET = re.compile(r'^_?(?:j(?:_s)?(?:\.d)?\s+\[?blink\]?'
                 r'|b(?:_s)?(?:\.d)?\s+0x00[0-9a-f]{6})$')
PROLOG = re.compile(r'^(?:push_s\s+blink|st\.a\s+r13,\[sp,|st\.a\s+blink,\[sp,'
                    r'|st\.a\s+r\d+,\[sp,)')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--lo', required=True)
    ap.add_argument('--hi', required=True)
    ap.add_argument('--min-tail', type=int, default=16,
                    help='не резать, если до конца блока меньше этого')
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
    cuts = []
    for b in st:
        end = b['addr'] + b['size']
        seq, p = [], b['addr']
        while p < end:
            ln, t = ins.get(p, (2, '?'))
            seq.append((p, ln, t))
            p += ln
        for i in range(len(seq) - 1):
            ad, ln, t = seq[i]
            if not RET.match(t):
                continue
            # Безусловный переход считается концом функции только если он
            # ведёт НАРУЖУ блока. Переход внутрь себя — это обычное
            # ветвление, и резать по нему нельзя.
            m = re.match(r'^_?b(?:_s)?(?:\.d)?\s+0x00([0-9a-f]{6})$', t)
            if m:
                tgt = int(m.group(1), 16)
                if b['addr'] <= tgt < end:
                    continue
            nxt = seq[i + 1]
            # у возврата с суффиксом .d следующая инструкция — слот задержки
            k = i + 2 if t.endswith('.d') and i + 2 < len(seq) else i + 1
            if k >= len(seq):
                continue
            nad, nln, ntxt = seq[k]
            if nad == b['addr'] or end - nad < a.min_tail:
                continue
            if PROLOG.match(ntxt.lstrip('_')):
                cuts.append((nad, b['name'], end - nad))

    if a.out:
        with open(a.out, 'a') as f:
            f.write('\n# --- разрез по границе «возврат, затем пролог» (%s), '
                    'split_after_return.py ---\n' % a.tag)
            for ad, owner, tail in cuts:
                f.write('0x%08x sub_%06x # начало пролога сразу за возвратом, '
                        'внутри %s (хвост %d Б)\n' % (ad, ad, owner, tail))
    print('%s: разрезов %d' % (a.tag, len(cuts)))


if __name__ == '__main__':
    main()
