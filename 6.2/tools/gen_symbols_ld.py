#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сгенерировать ld/symbols.ld: адреса вендорских функций как символы,
чтобы наш код звал их по имени.

Вход:  ref/SYMS.txt        (SYM 0xADDR SIZE name|auto ИМЯ)
       ref/FN-NAMES.txt    (необязательно: адрес -> восстановленное имя)
Выход: ld/symbols.ld       — функции fw_code (наш код живёт там же)
       ld/symbols-ucode.ld — функции uc_code, ОТДЕЛЬНО

Почему отдельно: uc_code исполняется ДРУГИМ процессором (микрокод), вызвать
оттуда/туда обычным bl нельзя. Смешивать их в одном скрипте — верный способ
собрать нерабочий образ.

Схема имён:
  * каждой функции даётся адресный алиас  sub_008c2190  — адресуемо всё;
  * если имя восстановлено, добавляется человекочитаемый символ:
    "class::method" -> class__method (:: недопустимо в идентификаторе C).
Всё через PROVIDE: если наш код определит такой символ сам, победит наш.
"""
import argparse, os, re, sys
from collections import defaultdict

UC_BASE = 0x920000

def mangle(n):
    n = n.replace('::', '__')
    n = re.sub(r'[^A-Za-z0-9_]', '_', n)
    if n and n[0].isdigit():
        n = '_' + n
    return n

def load_syms(path):
    out = []
    for l in open(path):
        if not l.startswith('SYM'):
            continue
        p = l.split(None, 4)
        addr, size, kind, name = int(p[1], 16), int(p[2]), p[3], p[4].strip()
        out.append((addr, size, kind, name))
    return sorted(out)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--syms', default='ref/SYMS.txt')
    ap.add_argument('--names', default='ref/FN-NAMES.txt')
    ap.add_argument('--out', default='ld/symbols.ld')
    ap.add_argument('--out-ucode', default='ld/symbols-ucode.ld')
    a = ap.parse_args()

    syms = load_syms(a.syms)

    # дополнительные имена из FN-NAMES.txt (если формат "0xADDR  имя  размер ...")
    extra = {}
    if os.path.exists(a.names):
        for l in open(a.names):
            if not l.startswith('0x'):
                continue
            p = l.split()
            # в таблицах 6.x безымянные функции помечены '?' — это НЕ имя
            if len(p) >= 2 and p[1] != '?' and re.match(r'^[A-Za-z_]', p[1]):
                extra[int(p[0], 16)] = p[1]

    groups = {'fw': [], 'uc': []}
    for addr, size, kind, name in syms:
        groups['uc' if addr >= UC_BASE else 'fw'].append((addr, size, kind, name))

    stats = {}
    for key, path in (('fw', a.out), ('uc', a.out_ucode)):
        items = groups[key]
        used = defaultdict(int)
        lines = []
        named = 0
        for addr, size, kind, name in items:
            alias = 'sub_%08x' % addr
            lines.append('PROVIDE(%-28s = 0x%08x);  /* %5d B */' % (alias, addr, size))
            friendly = None
            if kind == 'name' and not name.startswith(('thunk_', 'FUN_')):
                friendly = name
            elif addr in extra:
                friendly = extra[addr]
            if friendly:
                m = mangle(friendly)
                used[m] += 1
                if used[m] > 1:
                    m = '%s_%08x' % (m, addr)      # разводим тёзок адресом
                lines.append('PROVIDE(%-28s = 0x%08x);' % (m, addr))
                named += 1
        hdr = [
            '/* СГЕНЕРИРОВАНО tools/gen_symbols_ld.py — править вручную не надо.',
            ' * %s: %d функций, из них с восстановленным именем %d.' % (
                'fw_code' if key == 'fw' else 'uc_code (ДРУГОЙ процессор!)',
                len(items), named),
            ' * Каждой функции дан адресный алиас sub_XXXXXXXX; где имя известно,',
            ' * добавлен читаемый символ (:: заменено на __).',
            ' */', '']
        os.makedirs(os.path.dirname(path) or '.', exist_ok=True)
        open(path, 'w').write('\n'.join(hdr + lines) + '\n')
        stats[key] = (len(items), named, path)

    for key in ('fw', 'uc'):
        n, named, path = stats[key]
        print('%-22s функций %4d, именованных %3d -> %s' %
              ('fw_code' if key == 'fw' else 'uc_code', n, named, path))
    return 0

if __name__ == '__main__':
    sys.exit(main())
