#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Каталог обращений fw к DCCM по числовому адресу (этап 4 plain C11).

  dccm_catalog.py [--min N]      → таблица: адрес, ширина доступа, файлы, число мест, «база+смещение»

Ищет в fw/*.c константы 0x80xxxx (0x800000..0x807fff) в выражениях доступа:
  *(T *)0x80…, *(volatile T *)0x80…, W/W32/W8/W16/B/H/VOL(0x80…), (T *)0x80… (база объекта),
  0x80… + смещение. Для каждого адреса — где и как используется; по этому решается,
  переменная это (одиночный доступ) или объект/массив (база + смещения).
"""
import re, glob, sys, collections, os

HERE = os.path.dirname(os.path.abspath(__file__))
REW = os.path.dirname(HERE)
T = r'(?:volatile\s+)?(?:const\s+)?(u8|u16|u32|s8|s16|s32|u64)'
PAT = [
    # *(T *)0xA (+ x дальше — к значению) и *(T *)(0xA)
    ('deref', re.compile(r'\*\s*\(\s*' + T + r'\s*\*\s*\)\s*(?:(0x80[0-7][0-9a-f]{3})\b(?!\s*\[)|\(\s*(0x80[0-7][0-9a-f]{3})\s*\))')),
    ('macro', re.compile(r'\b(W|W32|W8|W16|B|H|VOL|R32)\s*\(\s*(0x80[0-7][0-9a-f]{3})\s*\)')),
    ('base+', re.compile(r'(0x80[0-7][0-9a-f]{3})\s*\+(?!=)\s*([^;,)]+)')),
    ('ptr', re.compile(r'\(\s*' + T + r'\s*\*\s*\)\s*(0x80[0-7][0-9a-f]{3})\b')),
]
ANY = re.compile(r'\b0x80[0-7][0-9a-f]{3}\b')


def main():
    st = collections.defaultdict(lambda: dict(kinds=collections.Counter(), files=collections.Counter(), w=set()))
    for f in sorted(glob.glob(os.path.join(REW, 'fw', '*.c'))):
        if f.endswith('fw_data.c'):
            continue
        fn = os.path.basename(f)
        for l in open(f):
            code = re.sub(r'/\*.*?\*/|//.*', '', l)
            for m in ANY.finditer(code):
                a = int(m.group(0), 16)
                st[a]['files'][fn] += 1
            for k, rx in PAT:
                for m in rx.finditer(code):
                    if k == 'deref':
                        a = int(m.group(2) or m.group(3), 16); st[a]['w'].add(m.group(1))
                    elif k == 'macro':
                        a = int(m.group(2), 16); st[a]['w'].add(m.group(1))
                    elif k == 'ptr':
                        a = int(m.group(2), 16); st[a]['w'].add(m.group(1) + '*')
                    else:
                        a = int(m.group(1), 16)
                    st[a]['kinds'][k] += 1
    mn = int(sys.argv[sys.argv.index('--min') + 1]) if '--min' in sys.argv else 1
    rows = sorted(st.items())
    tot = sum(sum(v['files'].values()) for _, v in rows)
    print('# адресов %d, упоминаний %d' % (len(rows), tot))
    for a, v in rows:
        n = sum(v['files'].values())
        if n < mn:
            continue
        print('0x%06x %4d  %-14s %-28s %s' % (a, n, ','.join(sorted(v['w'])) or '-',
              ' '.join('%s:%d' % kv for kv in v['kinds'].items()),
              ' '.join('%s:%d' % kv for kv in v['files'].most_common(4))))


if __name__ == '__main__':
    main()
