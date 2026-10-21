#!/usr/bin/env python3
"""Отладка: заполнитель неписаной ICCM (от конца кода fw до 0x900000).
Каждые 2 Б — bl_s на ближайшую «площадку» (площадка каждые 1 КБ): площадка пишет blink
(адрес входа + 2 или + 4) в DBG_GUARD (0x806a40, только первый раз) и останавливает ядро.
Вход в неписаную ICCM = вызов vendor-кода, которого у нас нет (указатель не подменён)."""
import sys
start, end, out = int(sys.argv[1], 16), int(sys.argv[2], 16), sys.argv[3]
mode = sys.argv[4] if len(sys.argv) > 4 else 'entry'
# entry: bl_s — в 0x806a40 адрес входа (+2); caller: b_s — исходный blink, r0..r3, sp в 0x806a44..
start = (start + 0x3ff) & ~0x3ff
L = ['    .section .guard,"ax"', '    .org 0']
PAD = 0x400 if mode == 'entry' else 0x200
a = start
while a < end:
    off = a - start
    if off % PAD == 0:
        if mode == 'entry':
            L += ['pad_%x:' % a,
                  '    ld r12, [0x806a40]', '    cmp r12, 0', '    bne 1f', '    st blink, [0x806a40]',
                  '1:  flag 1', '    nop_s', '    nop_s', '    b 1b', '    .align 4']
        else:
            L += ['pad_%x:' % a,
                  '    st blink, [0x806a44]', '    st r0, [0x806a48]', '    st r1, [0x806a4c]',
                  '    st r2, [0x806a50]', '    st r3, [0x806a54]', '    st sp, [0x806a58]',
                  '    ld r12, [sp, 0]', '    st r12, [0x806a5c]', '    ld r12, [sp, 4]', '    st r12, [0x806a60]',
                  '1:  flag 1', '    nop_s', '    nop_s', '    b 1b', '    .align 4']
        a = start + off + 0x80
        L.append('    .org 0x%x' % (a - start))
        continue
    p = start + (off // PAD) * PAD
    L.append(('    bl_s pad_%x' if mode == 'entry' else '    b_s pad_%x') % p)
    a += 2
open(out, 'w').write('\n'.join(L) + '\n')
