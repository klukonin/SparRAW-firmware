#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Выкладывает неисполняемые записи образа в исходники.

Сегменты данных и таблицы регистров вендорского образа становятся обычными
ассемблерными файлами с байтовыми массивами: дальше их по частям заменяют
осмысленные структуры, а сборка всё это время сверяется с оригиналом.
"""
import argparse
import json
import os
import struct


def sym_map(path, base, size):
    """Имена из Ghidra, попавшие внутрь сегмента."""
    out = {}
    if not path or not os.path.exists(path):
        return out
    for l in open(path):
        if not l.startswith('SYM'):
            continue
        p = l.split()
        ad, nm = int(p[1], 16), p[-1]
        if base <= ad < base + size and not nm.startswith(('FUN_', 'DAT_', 'thunk_')):
            out.setdefault(ad, nm)
    return out


def code_ptrs(blocks_json, code_base):
    """Смещения начал блоков кода: именно в таком виде прошивка хранит
    указатели на функции — адрес минус база сегмента."""
    if not blocks_json or not os.path.exists(blocks_json):
        return {}
    m = json.load(open(blocks_json))
    return {b['addr'] - code_base: b['name'] for b in m['blocks'] if b['addr'] - code_base >= 0x400}


def read_globals(paths, base, size):
    """Адреса, к которым код обращается через gp: они и есть переменные."""
    out = set()
    for p in paths:
        if not os.path.exists(p):
            continue
        for l in open(p):
            if l.startswith('#'):
                continue
            q = l.split()
            if q and q[0].startswith('0x'):
                a = int(q[0], 16)
                if base <= a < base + size:
                    out.add(a)
    return out


def emit_blob(path, name, base, blob, syms, comment, ptrs=None, code_base=0,
              gl=(), abase=None):
    with open(path, 'w') as f:
        f.write('/* %s\n * Адрес 0x%08x, %d байт.  Сгенерировано gen_data_tree.py.\n'
                ' * По мере разбора байтовые куски заменяются на именованные\n'
                ' * структуры; сборка сверяется с оригиналом побайтово. */\n'
                % (comment, base, len(blob)))
        f.write('\t.section .rodata.%s,"a",@progbits\n\t.global %s\n%s:\n' % (name, name, name))
        off = 0
        while off < len(blob):
            ad = base + off
            if ad in syms:
                f.write('\t.global %s\n%s:\n' % (syms[ad], syms[ad]))
            elif abase is not None and abase + off in gl:
                g = abase + off
                f.write('\t.global g_%06x\ng_%06x:\n' % (g, g))
            # указатель на функцию обязан пережить перенос блока в другое
            # место, поэтому пишется символом, а не числом
            if ptrs is not None and off % 4 == 0 and off + 4 <= len(blob):
                v = struct.unpack_from('<I', blob, off)[0]
                if v in ptrs:
                    f.write('\t.long %s - 0x%08x /* %06x */\n' % (ptrs[v], code_base, ad))
                    off += 4
                    continue
            # строка обрывается перед ближайшим указателем, иначе он
            # утонул бы в байтовом массиве
            n = 16
            for k in range(1, 16):
                if abase is not None and abase + off + k in gl:
                    n = k
                    break
            if ptrs is not None:
                for k in range(4, 16, 4):
                    if off + k + 4 <= len(blob) and \
                       struct.unpack_from('<I', blob, off + k)[0] in ptrs and \
                       (off + k) % 4 == 0:
                        n = k
                        break
            row = blob[off:off + n]
            txt = ''.join(chr(c) if 32 <= c < 127 else '.' for c in row)
            f.write('\t.byte %-63s /* %06x %s */\n'
                    % (','.join('0x%02x' % c for c in row), ad, txt))
            off += len(row)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--kit', required=True, help='каталог с seg_*.bin и segments.json')
    ap.add_argument('--image', required=True, help='вендорский .fw для записи direct_write')
    ap.add_argument('--syms')
    # адресные пространства fw и ucode разные, хотя адреса совпадают:
    # список глобалов у каждого сегмента свой
    ap.add_argument('--globals-fw')
    ap.add_argument('--globals-uc')
    ap.add_argument('--fw-blocks', help='src/asm/fw/blocks.json')
    ap.add_argument('--uc-blocks', help='src/asm/uc/blocks.json')
    ap.add_argument('--outdir', required=True)
    ap.add_argument('--ld', required=True)
    a = ap.parse_args()
    os.makedirs(a.outdir, exist_ok=True)

    segs = json.load(open(os.path.join(a.kit, 'segments.json')))
    ptrmap = {0x900000: (code_ptrs(a.fw_blocks, 0x8c0000), 0x8c0000),
              0x940000: (code_ptrs(a.uc_blocks, 0x920000), 0x920000)}
    # адрес сегмента данных в адресном пространстве ARC (по sparrow_fw_mapping)
    arcbase = {0x900000: 0x800000, 0x940000: 0x800000}
    names = {0x900000: 'fw_data', 0x940000: 'uc_data',
             0x88a004: 'agc_tbl_004', 0x88a208: 'agc_tbl_208', 0x88a608: 'agc_tbl_608'}
    lines, made = [], []
    for s in sorted(segs, key=lambda x: x['addr']):
        if s['region'] in ('fw_code', 'uc_code'):
            continue
        base = s['addr']
        nm = names.get(base, 'seg_%08x' % base)
        blob = open(os.path.join(a.kit, s['file']), 'rb').read()
        ptrs, cb = ptrmap.get(base, (None, 0))
        emit_blob(os.path.join(a.outdir, nm + '.S'), nm, base, blob,
                  sym_map(a.syms, base, len(blob)), 'Сегмент %s' % s['region'],
                  ptrs, cb,
                  read_globals([{0x900000: a.globals_fw,
                                 0x940000: a.globals_uc}.get(base) or ''],
                               arcbase.get(base, base), len(blob)),
                  arcbase.get(base))
        lines.append('    . = 0x%08x ; KEEP(*(.rodata.%s))' % (base, nm))
        made.append((nm, base, len(blob)))

    # direct_write: тройки (адрес, значение, маска), которые загрузчик
    # применяет к регистрам до старта ядра
    d = open(a.image, 'rb').read()
    o = 0
    dw = None
    while o + 8 <= len(d):
        ty, fl, sz = struct.unpack_from('<HHI', d, o)
        if ty == 7:
            dw = d[o + 8:o + 8 + sz]
            break
        o += 8 + ((sz + 3) & ~3)
    if dw is None:
        raise SystemExit('в образе нет записи direct_write')
    with open(os.path.join(a.outdir, 'direct_write.S'), 'w') as f:
        f.write('/* Запись direct_write вендорского образа: %d троек\n'
                ' * (адрес, значение, маска), которые драйвер пишет в регистры\n'
                ' * до снятия ядра со сброса.  Сгенерировано gen_data_tree.py. */\n'
                % (len(dw) // 12))
        f.write('\t.section .rodata.direct_write,"a",@progbits\n'
                '\t.global fw_direct_write\nfw_direct_write:\n')
        for i in range(0, len(dw), 12):
            ad, val, msk = struct.unpack_from('<III', dw, i)
            f.write('\t.long 0x%08x, 0x%08x, 0x%08x\n' % (ad, val, msk))
    made.append(('direct_write', 0, len(dw)))

    with open(a.ld, 'w') as f:
        f.write('/* Размещение сегментов данных.  Сгенерировано gen_data_tree.py. */\n')
        for nm, base, ln in made:
            if nm == 'direct_write':
                continue
            f.write('SECTIONS { . = 0x%08x; .rodata.%s : { KEEP(*(.rodata.%s)) } }\n'
                    % (base, nm, nm))
    for nm, base, ln in made:
        print('  %-14s 0x%08x %7d байт' % (nm, base, ln))


if __name__ == '__main__':
    main()
