#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Строит скрипт размещения сегмента с учётом переписанных на C блоков.

Пока блок остаётся ассемблерным, он прибит к своему исходному адресу:
внутри него PC-относительные переходы посчитаны от него.  Как только блок
переписан на C, его адрес перестаёт что-либо значить — весь код ссылается
на него по глобальному символу, — и он уезжает в свободный хвост области,
а на старом месте остаётся дырка, забитая нулями.  Так переписанная
функция больше не обязана влезать в вендорский размер.
"""
import argparse
import json
import os


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--csrc', help='каталог с .c/.cpp/.S, замещающими блоки')
    ap.add_argument('--pool', required=True, help='адрес свободного хвоста, hex')
    ap.add_argument('--pool-end', required=True)
    ap.add_argument('--data-sec', help='секция сегмента данных, линкуемая вместе с кодом')
    ap.add_argument('--data-addr', help='её адрес в адресном пространстве ARC')
    ap.add_argument('--bin', help='вендорский сегмент: чем забить освободившееся место')
    ap.add_argument('--fill-out', help='куда записать заполнитель освободившихся мест')
    ap.add_argument('--data-bin', help='сегмент данных: искать в нём ссылки на переехавшее')
    ap.add_argument('--out', required=True)
    a = ap.parse_args()
    m = json.load(open(a.blocks))

    over = set()
    if a.csrc and os.path.isdir(a.csrc):
        for fn in os.listdir(a.csrc):
            stem, ext = os.path.splitext(fn)
            if ext in ('.c', '.cpp', '.cc', '.S'):
                over.add(stem)

    ali = []
    # На месте переехавшего блока остаются ИСХОДНЫЕ байты, а не нули.
    # Причина: в данных прошивки есть слова, похожие на указатели внутрь
    # блоков, и разобраны они ещё не все. Пока такой указатель не найден и
    # не переведён в символ, безопаснее, чтобы по старому адресу лежал
    # прежний код, а не мусор.
    fill = []
    blob = open(a.bin, 'rb').read() if a.bin else b''
    out = ['/* Размещение сегмента %s.  Сгенерировано gen_layout.py. */' % m['region'],
           'SECTIONS', '{']
    kept = 0
    for b in m['blocks']:
        if b['name'] in over:
            # переписанный блок уезжает, но его адресная метка обязана
            # уцелеть: на неё ссылаются ещё не переписанные соседи
            ali.append('  PROVIDE(L_%06x = %s);' % (b['addr'], b['name']))
            if blob:
                o = b['addr'] - m['base']
                fill.append((b['name'], b['addr'], blob[o:o + b['size']]))
            continue
        kept += 1
        out.append('  .text.%s 0x%08x : { KEEP(*(.text.%s)) }' % (b['name'], b['addr'], b['name']))
        out.append('  ASSERT(SIZEOF(.text.%s) <= %d, "блок %s не влезает в '
                   'отведённые ему %d байт")' % (b['name'], b['size'], b['name'], b['size']))
    for nm, ad, by in fill:
        out.append('  .text.vacated_%s 0x%08x : { KEEP(*(.text.vacated_%s)) }'
                   % (nm, ad, nm))
    if over:
        out.append('  /* переписанные на C блоки — в свободный хвост */')
        out.append('  .text.rewritten 0x%s : {' % a.pool.lstrip('0x'))
        for nm in sorted(over):
            out.append('    KEEP(*(.text.%s)) KEEP(*(.text.%s.*))' % (nm, nm))
        out.append('    KEEP(*(.text.rw)) KEEP(*(.text.rw.*))')
        # компилятор выносит inline-функции и константы в секции со своими
        # именами (.text._ZL...constprop). Всё, что не разобрали прибитые
        # правила выше, собирается сюда — они идут первыми, поэтому
        # ассемблерные блоки этот образец уже не заденет.
        out.append('    *(.text .text.*)')
        # переписанным блокам нужны и собственные переменные: своей памяти
        # данных у нас нет, но область кода — обычная ОЗУ, и её свободный
        # хвост так же свободен
        # сегмент данных исключаем поимённо: он размещается отдельно и
        # своим адресом, иначе уловитель утащит его сюда и запись data в
        # образе соберётся пустой
        ex = ('EXCLUDE_FILE(*%s.o) ' % a.data_sec) if a.data_sec else ''
        # EXCLUDE_FILE надо писать перед КАЖДЫМ образцом: в этой версии ld
        # он относится только к ближайшему следующему
        out.append('    *(%s.rodata %s.rodata.*)' % (ex, ex))
        out.append('    *(.data .data.*)')
        out.append('    *(.bss .bss.* COMMON)')
        out.append('  }')
        out.append('  .rodata.rewritten : { KEEP(*(.rodata.rw)) KEEP(*(.rodata.rw.*)) }')
        out.append('  ASSERT(. <= %s, "переписанный код не влезает в свободный хвост")'
                   % a.pool_end)
    if a.data_sec:
        # сегмент данных линкуется вместе с кодом: в нём лежат указатели
        # на функции, и разрешить их может только линковщик
        out.append('  .rodata.%s %s : { KEEP(*(.rodata.%s)) }'
                   % (a.data_sec, a.data_addr, a.data_sec))
    out += ali
    out.append('  /DISCARD/ : { *(.comment) *(.note*) *(.ARC.attributes) }')
    out.append('}')
    if a.fill_out:
        with open(a.fill_out, 'w') as f:
            f.write('/* Исходные байты блоков, переехавших в свободный хвост.\n'
                    ' * Остаются на прежних адресах: на них может указывать ещё\n'
                    ' * не разобранная таблица в данных прошивки.\n'
                    ' * Сгенерировано gen_layout.py. */\n')
            for nm, ad, by in fill:
                f.write('\t.section .text.vacated_%s,"ax",@progbits\n' % nm)
                for i in range(0, len(by), 16):
                    f.write('\t.byte %s\n' % ','.join('0x%02x' % x for x in by[i:i + 16]))
    open(a.out, 'w').write('\n'.join(out) + '\n')
    # предупреждение о словах данных, похожих на ссылку внутрь переехавшего
    # блока: снаружи такую ссылку никто не поправит
    if a.data_bin and fill and os.path.exists(a.data_bin):
        import struct
        d = open(a.data_bin, 'rb').read()
        rng = [(b['addr'] - m['base'], b['addr'] - m['base'] + b['size'], b['name'])
               for b in m['blocks'] if b['name'] in over]
        warn = []
        for o in range(0, len(d) - 3, 4):
            v = struct.unpack_from('<I', d, o)[0]
            for lo, hi, nm in rng:
                if lo < v < hi:
                    warn.append((o, v, nm))
        for o, v, nm in warn[:10]:
            print('  ВНИМАНИЕ: слово данных 0x%06x указывает внутрь переехавшего '
                  'блока %s (смещение 0x%x) — проверь, не таблица ли это'
                  % (0x800000 + o, nm, v))

    print('%s: прибито блоков %d, переписано на C %d -> %s'
          % (m['region'], kept, len(over), a.out))


if __name__ == '__main__':
    main()
