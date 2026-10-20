#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Состав варианта прошивки: каталог замен на C и серия патчей quilt.

Список варианта перечисляет ИСКЛЮЧЕНИЯ: в вариант идут все блоки src/c и
новые функции src/c/<сег>/new, кроме названных, и все патчи серии, кроме
названных.  Строка «only» в списке меняет смысл на обратный: в вариант идёт
ТОЛЬКО названное.

    tools/variant.py --list variants/lite.txt --csrc src/c --out build/cdir-lite \\
        --series patches/series --series-out patches/series-lite

В --out появляются ссылки на оставшиеся файлы, в --series-out — оставшиеся
патчи в порядке основной серии.
"""
import argparse, os, sys


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--list', required=True)
    ap.add_argument('--csrc', required=True)
    ap.add_argument('--out', required=True)
    ap.add_argument('--series', required=True)
    ap.add_argument('--series-out', required=True)
    a = ap.parse_args()

    blocks, patches = [], set()
    only = False
    for n, line in enumerate(open(a.list), 1):
        line = line.split('#', 1)[0].strip()
        if not line:
            continue
        if line == 'only':
            only = True
            continue
        if line.startswith('patch '):
            patches.add(line.split(None, 1)[1])
            continue
        seg, _, name = line.partition('/')
        if seg not in ('fw', 'uc') or not name:
            sys.exit(f'{a.list}:{n}: ожидается fw/<блок>, uc/<блок> или patch <файл>')
        blocks.append((seg, name))

    excl = set(blocks)
    known = set()
    n_in = 0
    for seg in ('fw', 'uc'):
        for sub in ('', 'new'):
            d = os.path.join(a.out, seg, sub)
            os.makedirs(d, exist_ok=True)
            for f in os.listdir(d):
                if not os.path.isdir(os.path.join(d, f)):
                    os.unlink(os.path.join(d, f))
            sd = os.path.join(a.csrc, seg, sub)
            if not os.path.isdir(sd):
                continue
            for f in sorted(os.listdir(sd)):
                stem, ext = os.path.splitext(f)
                if ext not in ('.c', '.cpp'):
                    continue
                key = (seg, stem if not sub else 'new/' + stem)
                known.add(key)
                if (key in excl) != only:
                    continue
                os.symlink(os.path.abspath(os.path.join(sd, f)), os.path.join(d, f))
                n_in += 1
    miss = excl - known
    if miss:
        sys.exit(f'{a.list}: нет в src/c: {", ".join(s + "/" + n for s, n in sorted(miss))}')

    series = [l.strip() for l in open(a.series) if l.strip() and not l.startswith('#')]
    miss = patches - set(series)
    if miss:
        sys.exit(f'{a.list}: нет в серии: {", ".join(sorted(miss))}')
    keep = [p for p in series if (p in patches) == only]
    open(a.series_out, 'w').write(''.join(p + '\n' for p in keep))
    print(f'вариант {os.path.basename(a.list)}: файлов на C {n_in} '
          f'({"только названные" if only else f"исключено {len(excl)}"}), патчей {len(keep)}')


if __name__ == '__main__':
    main()
