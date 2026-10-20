#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Перенести карту «функция -> исходный файл» с 4.1 на 6.2.

В 4.1 карта построена по ассертам и лог-строкам, называющим файл. В 6.2
таких строк нет вовсе (проверено: ни одного `*.c`/`*.cpp` в обеих
таблицах строк), поэтому собрать её на месте нечем.

Зато есть соответствия функций, доказанные независимо — переносом имени
по общей лог-строке и якорями-константами. Функция, отвечающая функции
4.1 из файла X, лежит в том же файле X: вендор собирает общие исходники.

Дальше — соседство: если блок окружён с обеих сторон блоками одного
файла, он из того же файла. Разрыв между разными файлами не заполняется:
там граница, и гадать, где именно она проходит, нельзя.
"""
import argparse, json


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--from-filemap', required=True)
    ap.add_argument('--from-blocks', required=True)
    ap.add_argument('--to-blocks', required=True)
    ap.add_argument('--out', required=True)
    a = ap.parse_args()

    fmap = {}
    for l in open(a.from_filemap):
        if l.startswith('#') or not l.strip():
            continue
        q = l.split()
        if q[0].startswith('0x'):
            fmap[int(q[0], 16)] = q[1]

    src = json.load(open(a.from_blocks))['blocks']
    name2file = {}
    for b in src:
        f = fmap.get(b['addr'])
        if f:
            name2file[b['name']] = f

    dst = sorted(json.load(open(a.to_blocks))['blocks'], key=lambda b: b['addr'])
    direct = 0
    files = [None] * len(dst)
    for i, b in enumerate(dst):
        nm = b['name']
        f = name2file.get(nm)
        if f is None:
            for suf in ('_fw', '_uc'):
                if nm.endswith(suf):
                    f = name2file.get(nm[:-len(suf)])
                    break
        if f:
            files[i] = f
            direct += 1

    # соседство: заполняем только промежутки между одинаковыми файлами
    filled = 0
    i = 0
    while i < len(files):
        if files[i] is None:
            i += 1
            continue
        j = i + 1
        while j < len(files) and files[j] is None:
            j += 1
        if j < len(files) and files[j] == files[i]:
            for k in range(i + 1, j):
                files[k] = files[i]
                filled += 1
        i = j

    with open(a.out, 'w') as f:
        f.write('# Карта «адрес -> файл» для 6.2, перенесённая с 4.1 по\n'
                '# доказанным соответствиям функций и достроенная соседством\n'
                '# (filemap_from_4x.py). Прямых попаданий %d, по соседству %d.\n'
                % (direct, filled))
        for b, fn in zip(dst, files):
            if fn:
                f.write('0x%06x  %s\n' % (b['addr'], fn))
    total = sum(1 for x in files if x)
    print('%s: файл известен у %d блоков из %d (прямо %d, соседством %d)'
          % (a.out, total, len(dst), direct, filled))


if __name__ == '__main__':
    main()
