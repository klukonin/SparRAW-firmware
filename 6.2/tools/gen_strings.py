#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Таблица строк журнала 6.4: вендорская таблица + новые строки.

Запись журнала несёт смещение строки в таблице (в 6.2 биты 0..17 заголовка,
выше — байт времени), поэтому новые строки дописываются за концом
вендорской таблицы и получают смещения, которые код на C передаёт логгеру
так же, как вендорский: 0x01000000 | смещение.

    tools/gen_strings.py --vendor ref/strings-fw.bin --list src/strings/fw.txt \\
        --out-bin build/strings-fw.bin --out-h build/gen/strings-fw.h
"""
import argparse, os, re, sys

LIMIT = 1 << 18          # смещение должно поместиться в биты 0..17
TOKEN = 0x01000000       # признак «ссылка на строку», как у вендорских констант


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--vendor', required=True)
    ap.add_argument('--list', required=True)
    ap.add_argument('--out-bin', required=True)
    ap.add_argument('--out-h', required=True)
    a = ap.parse_args()

    tab = bytearray(open(a.vendor, 'rb').read())
    if tab and tab[-1] != 0:
        tab.append(0)
    names, lines = set(), []
    for n, line in enumerate(open(a.list, encoding='utf-8'), 1):
        line = line.rstrip('\n')
        if not line.strip() or line.lstrip().startswith('#'):
            continue
        m = re.match(r'^([A-Z][A-Z0-9_]*)\s+(\S.*)$', line)
        if not m:
            sys.exit(f'{a.list}:{n}: ожидается «ИМЯ текст»')
        name, text = m.groups()
        if len(text) >= 2 and text[0] == text[-1] == '"':
            text = text[1:-1]      # в кавычках — дословно, с краевыми пробелами
        if name in names:
            sys.exit(f'{a.list}:{n}: {name} уже есть')
        if not all(32 <= ord(c) < 127 for c in text):
            sys.exit(f'{a.list}:{n}: только ASCII — декодер печатает latin1')
        names.add(name)
        off = len(tab)
        tab += text.encode() + b'\0'
        if len(tab) > LIMIT:
            sys.exit(f'{a.list}:{n}: таблица вышла за {LIMIT:#x}')
        lines.append(f'\t{name} = {TOKEN | off:#010x}, /* "{text}" */')

    os.makedirs(os.path.dirname(os.path.abspath(a.out_bin)), exist_ok=True)
    os.makedirs(os.path.dirname(os.path.abspath(a.out_h)), exist_ok=True)
    open(a.out_bin, 'wb').write(bytes(tab))
    guard = re.sub(r'\W', '_', os.path.basename(a.out_h)).upper()
    open(a.out_h, 'w').write(
        f'/* Сгенерировано tools/gen_strings.py из {a.list}. Не править. */\n'
        f'#ifndef {guard}\n#define {guard}\n\nenum {{\n' + '\n'.join(lines) +
        f'\n}};\n\n#endif\n')
    print(f'{a.list}: {len(lines)} строк, таблица {len(tab)} Б -> {a.out_bin}')


if __name__ == '__main__':
    main()
