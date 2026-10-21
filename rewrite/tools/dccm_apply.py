#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Заменяет в fw/*.c доступы к DCCM по числовому адресу на имена из fw/dccm_names.txt.

  dccm_apply.py [файлы…]      (по умолчанию все fw/*.c, кроме fw_data.c)

  *(T *)0xA / *(volatile T *)0xA / *(T *)(0xA)  → имя        (T той же ширины и знака)
  W(0xA)/W32 → u32, H/W16 → u16, B/W8 → u8 (локальные макросы разыменования) → имя
  (T *)0xA                                      → &имя       (T того же типа)
Остальное (другая ширина/знак, адрес в арифметике) не трогается — печатается списком:
это места для ручного разбора (поле структуры, массив, union).
Машинный код не меняется (абсолютный адрес тот же) — проверять tools/codecmp.py.
"""
import os, re, sys, glob

HERE = os.path.dirname(os.path.abspath(__file__))
REW = os.path.dirname(HERE)
sys.path.insert(0, HERE)
from gen_fw_data import names, SIZE

MAC = {'W': 'u32', 'W32': 'u32', 'H': 'u16', 'W16': 'u16', 'B': 'u8', 'W8': 'u8', 'MMIO32': 'u32'}


def main():
    nv = {0x800000 + off: (qual, t, n, nm) for off, qual, t, n, nm, _ in names() if t != 'ext'}
    files = sys.argv[1:] or [f for f in sorted(glob.glob(os.path.join(REW, 'fw', '*.c')))
                             if not f.endswith('fw_data.c')]
    left = []
    total = 0
    for f in files:
        s = open(f).read()
        o = s

        def deref(m):
            vol, t, a = m.group(1), m.group(2), int(m.group(3), 16)
            if a not in nv:
                return m.group(0)
            qual, ct, n, nm = nv[a]
            if n or t != ct or (vol and not qual):
                left.append('%s: %s (каталог: %s%s%s)' % (os.path.basename(f), m.group(0), qual, ct,
                                                          '[%d]' % n if n else ''))
                return m.group(0)
            return nm

        def macro(m):
            a = int(m.group(2), 16)
            if a not in nv:
                return m.group(0)
            qual, ct, n, nm = nv[a]
            if n or MAC[m.group(1)] != ct:
                left.append('%s: %s (каталог: %s)' % (os.path.basename(f), m.group(0), ct))
                return m.group(0)
            return nm

        def ptr(m):
            vol, t, a = m.group(1), m.group(2), int(m.group(3), 16)
            if a not in nv:
                return m.group(0)
            qual, ct, n, nm = nv[a]
            if t != ct or (vol and not qual):
                left.append('%s: %s (каталог: %s%s)' % (os.path.basename(f), m.group(0), qual, ct))
                return m.group(0)
            return nm if n else '&' + nm

        # *(T *)0xA — «+ x» дальше относится к значению; *(T *)(0xA) — только если сразу «)»
        s = re.sub(r'\*\s*\(\s*(volatile\s+)?(u8|u16|u32|s8|s16|s32|u64)\s*\*\s*\)\s*(0x80[0-7][0-9a-f]{3})\b(?!\s*\[)', deref, s)
        s = re.sub(r'\*\s*\(\s*(volatile\s+)?(u8|u16|u32|s8|s16|s32|u64)\s*\*\s*\)\s*\(\s*(0x80[0-7][0-9a-f]{3})\s*\)', deref, s)
        s = re.sub(r'\b(MMIO32|W32|W16|W8|W|H|B)\s*\(\s*(0x80[0-7][0-9a-f]{3})\s*\)', macro, s)
        s = re.sub(r'\(\s*(volatile\s+)?(u8|u16|u32|s8|s16|s32|u64)\s*\*\s*\)\s*(0x80[0-7][0-9a-f]{3})\b(?!\s*[+\[])', ptr, s)
        if s != o:
            total += 1
            open(f, 'w').write(s)
    # оставшиеся упоминания именованных адресов
    for f in files:
        for i, l in enumerate(open(f), 1):
            code = re.sub(r'/\*.*?\*/|//.*', '', l)
            if re.match(r'\s*\*(\s|/|$)', code) or code.lstrip().startswith('/*'):
                continue          # строка многострочного комментария (не «*(T *)…» в коде)
            for m in re.finditer(r'\b0x80[0-7][0-9a-f]{3}\b', code):
                if int(m.group(0), 16) in nv:
                    left.append('%s:%d: %s' % (os.path.basename(f), i, l.strip()[:110]))
    print('изменено файлов: %d' % total)
    for x in sorted(set(left)):
        print('  осталось:', x)


if __name__ == '__main__':
    main()
