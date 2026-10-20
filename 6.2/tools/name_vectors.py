#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Имена обработчиков по таблице векторов в начале сегмента.

Первые байты каждого сегмента — таблица переходов по восемь байт на
запись: `j 0x<смещение>` с limm. Смещение отсчитывается ОТ БАЗЫ
СЕГМЕНТА (Ghidra печатает его как абсолютный адрес вида 0x120, и это
сбивает с толку: такого адреса в образе нет).

Цели почти никогда не совпадают с началами блоков — Ghidra их не
выделяет, потому что в таблицу никто не «вызывает». Адрес, вписанный в
NAMES-EXTRA, создаёт границу и вытаскивает обработчик наружу.

Имя адресно-честное: номер записи в таблице векторов. Что именно за
прерывание — из тела не видно, и в имени этого нет. Общая цель у
нескольких векторов называется по первому из них.
"""
import argparse, json, re

VEC = re.compile(r'^j\s+0x([0-9a-f]+)$')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--base', required=True)
    ap.add_argument('--table-size', default='0x120')
    ap.add_argument('--out')
    ap.add_argument('--tag', default='fw')
    a = ap.parse_args()
    base, tsz = int(a.base, 16), int(a.table_size, 16)

    starts = {b['addr'] for b in json.load(open(a.blocks))['blocks']}
    seen, out = {}, []
    for l in open(a.insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if not base <= ad < base + tsz:
            continue
        m = VEC.match(p[3].strip())
        if not m:
            continue
        idx = (ad - base) // 8
        tgt = base + int(m.group(1), 16)
        if tgt in seen:
            continue
        seen[tgt] = idx
        out.append((tgt, idx, tgt in starts))

    if a.out:
        with open(a.out, 'a') as f:
            f.write('\n# --- обработчики векторов прерываний (%s): цель записи '
                    'таблицы в начале сегмента, смещение отсчитывается от базы '
                    'сегмента (name_vectors.py) ---\n' % a.tag)
            for tgt, idx, was in out:
                f.write('0x%08x %s_vector_%02d # запись %d таблицы векторов%s\n'
                        % (tgt, a.tag, idx, idx,
                           '' if was else ', граница создана этой записью'))
    print('%s: векторов с разными целями %d, из них уже были началами блоков %d'
          % (a.tag, len(out), sum(1 for _, _, w in out if w)))


if __name__ == '__main__':
    main()
