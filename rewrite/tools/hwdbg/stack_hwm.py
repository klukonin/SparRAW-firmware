#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""stack_hwm.py <uc_data.bin>… — высшая отметка стека uc по закраске (uc/start.S, узор 0x57ac57ac).

Стек uc — 0x803648..0x804000 (uc/uc.ld __stack_bottom/__stack_top), при старте залит узором. Печатает для каждого
снимка: глубину (от вершины до самого низкого слова, отличного от узора) и испорченные слова узора ниже отметки,
не примыкающие к ней (запись чужого кода в стековую область)."""
import struct
import sys

DCCM = 0x800000
BOTTOM, TOP = 0x803648, 0x804000
PAINT = 0x57ac57ac


def hwm(blob):
    words = [struct.unpack_from('<I', blob, a - DCCM)[0] for a in range(BOTTOM, TOP, 4)]
    low = next((i for i, w in enumerate(words) if w != PAINT), len(words))
    return TOP - (BOTTOM + 4 * low), low


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 2
    worst = 0
    for f in sys.argv[1:]:
        b = open(f, 'rb').read()
        if len(b) < TOP - DCCM:
            continue
        d, low = hwm(b)
        if struct.unpack_from('<I', b, BOTTOM - DCCM)[0] != PAINT and d == TOP - BOTTOM:
            print('%s: узора нет (образ без закраски?)' % f)
            continue
        worst = max(worst, d)
        print('%s: глубина стека %d Б из %d (запас %d)' % (f, d, TOP - BOTTOM, TOP - BOTTOM - d))
    print('максимум: %d Б' % worst)
    return 0


if __name__ == '__main__':
    sys.exit(main())
