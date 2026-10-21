#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Генерирует fw/fw_data.c — начальный образ DCCM fw (рантайм 0x800000.., в .fw — запись 0x900000).

Источник значений — vendor 6.2 fw_data. Указатели на vendor-код (проверенный список
6.2/ref/RELOCS-OK-fw.txt, см. tools/fw_ptrmap.py) становятся C-инициализаторами с нашими
функциями — линкер разрешает их сам; бинарная подмена при сборке (fw_ptrmap) больше не нужна.
Ненулевые участки — объекты в секциях .fwdata.<адрес> (Makefile ставит по адресу), остальное
до конца vendor-образа — нули (tools/build_fw.py).
  gen_fw_data.py fw.elf          (fw.elf — для сопоставления vendor-адрес → наш порт)
Это механическое начало: дальше участки разбираются на именованные типизированные объекты.
"""
import os, re, struct, sys

HERE = os.path.dirname(os.path.abspath(__file__))
REW = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import fw_ptrmap
from build_fw import parse_fw

VENDOR = os.path.join(REW, '..', 'images', 'openwrt', 'fw', 'wil6210_6.2.0.1000.fw')
OUT = os.path.join(REW, 'fw', 'fw_data.c')
GAP = 16          # нулевой разрыв больше GAP байт — новый объект


def vendor_fw_data():
    for r in parse_fw(open(VENDOR, 'rb').read()):
        t, p = (r[0], r[2]) if isinstance(r, tuple) else (r['type'], r['payload'])
        if t == 2 and struct.unpack_from('<I', p, 0)[0] == 0x900000:
            return p[4:]
    sys.exit('нет fw_data в vendor-образе')


NAMES = os.path.join(REW, 'fw', 'dccm_names.txt')
HDR = os.path.join(REW, 'fw', 'dccm.h')
SIZE = {'u8': 1, 's8': 1, 'u16': 2, 's16': 2, 'u32': 4, 's32': 4, 'u64': 8, 'ext': 1}


def names():
    """fw/dccm_names.txt: «0xADDR [volatile] TYPE[N] имя  # смысл» → [(off, qual, type, n, name, comment)]"""
    res = []
    if not os.path.exists(NAMES):
        return res
    for ln, l in enumerate(open(NAMES), 1):
        l = l.rstrip('\n')
        code, _, cmt = l.partition('#')
        p = code.split()
        if not p:
            continue
        qual = ''
        if p[1] == 'volatile':
            qual = 'volatile '
            p = p[:1] + p[2:]
        m = re.fullmatch(r'(\w+)(?:\[(\d+)\])?', p[1])
        if len(p) != 3 or not m or m.group(1) not in SIZE:
            sys.exit('dccm_names.txt:%d: «%s»' % (ln, l))
        a = int(p[0], 16)
        t, n = m.group(1), int(m.group(2) or 0)
        if t != 'ext' and a % min(SIZE[t], 4):
            sys.exit('dccm_names.txt:%d: %s по невыровненному адресу 0x%x' % (ln, t, a))
        res.append((a - 0x800000, qual, t, n, p[2], cmt.strip()))
    res.sort()
    for x, y in zip(res, res[1:]):
        if x[0] + SIZE[x[2]] * max(x[3], 1) > y[0]:
            sys.exit('dccm_names.txt: %s и %s перекрываются' % (x[4], y[4]))
    return res


def main():
    elf = sys.argv[1]
    d = vendor_fw_data()
    nv = names()
    nm = 'arc-elf32-nm'
    vn, syms, resolve = fw_ptrmap.build_map(elf, nm)
    ptr = {}
    for addr, val in fw_ptrmap.relocs():
        off = addr - 0x800000
        cur = struct.unpack_from('<I', d, off)[0]
        if cur != val:
            sys.exit('fw_data 0x%x: ожидали 0x%x, там 0x%x' % (addr, val, cur))
        name, how = resolve(fw_ptrmap.CODE_BASE + val)
        if not name:
            sys.exit('fw_data 0x%x: нет порта для vendor 0x%x (%s)' % (addr, fw_ptrmap.CODE_BASE + val, how))
        ptr[off] = (name, fw_ptrmap.CODE_BASE + val)
    # ненулевые байты и байты указателей (указатель может стоять по любому смещению — упакованные
    # дескрипторы автоматов и т.п.)
    used = bytearray(len(d))
    for i in range(len(d)):
        if d[i]:
            used[i] = 1
    for o in ptr:
        used[o:o + 4] = b'\x01' * 4
    for off, qual, t, n, nm, cmt in nv:
        sz = SIZE[t] * max(n, 1)
        if t != 'ext' and any(off <= o < off + sz or o < off < o + 4 for o in ptr):
            sys.exit('%s (0x%x): внутри указатель на код' % (nm, 0x800000 + off))
        if t == 'ext':
            for o in [o for o in ptr if off <= o < off + sz]:
                del ptr[o]                      # указатели — в ручном определении
        used[off:off + sz] = bytes(sz)          # вне участков — свой объект
    named = bytearray(len(d) + 64)
    for off, qual, t, n, nm, cmt in nv:
        named[off:off + SIZE[t] * max(n, 1)] = b'\x01' * (SIZE[t] * max(n, 1))
    idx = [i for i in range(len(d)) if used[i]]
    spans = []                                  # безымянные участки (все разобраны — пусто)
    if idx:
        s0 = p0 = idx[0]
        for x in idx[1:]:
            if x - p0 > GAP or any(named[p0 + 1:x]):   # не склеивать через именованную переменную
                spans.append((s0, p0 + 1))
                s0 = x
            p0 = x
        spans.append((s0, p0 + 1))
    # участки не должны резать указатель
    for a, b in spans:
        for o in ptr:
            assert not (a < o + 4 and o < b) or (a <= o and o + 4 <= b), hex(o)

    out = ['// SPDX-License-Identifier: AGPL-3.0-or-later',
           '/* Начальный образ DCCM fw (fw_data): рантайм 0x800000.., в .fw — запись 0x900000.',
           ' * Сгенерировано tools/gen_fw_data.py из vendor 6.2 fw_data — механический перенос:',
           ' * значения как у vendor, указатели на vendor-код — наши функции (C-инициализаторы).',
           ' * Объект — ненулевой участок образа в секции .fwdata.<адрес> (Makefile ставит её по',
           ' * адресу); между участками и до 0x%06x — нули (tools/build_fw.py). Указатели бывают по' % (0x800000 + len(d)),
           ' * невыровненным адресам (упакованные дескрипторы) — отсюда packed-структуры. Дальше',
           ' * участки разбираются на именованные типизированные объекты (правка вручную). */',
           '#include "../include/types.h"', '',
           '#include "../include/fwdata.h"', '',
           '/* Указатель на функцию в образе (vtable, автомат, колбэк). */',
           'typedef union { u32 w; void (*f)(void); } fwd_ptr;',
           '#define F_(fn) { .f = (void (*)(void))(fn) }', '']
    n_ptr = 0
    for a, b in spans:
        addr = 0x800000 + a
        fields, inits = [], []
        o = a
        while o < b:
            if o in ptr:
                name, va = ptr[o]
                fields.append('    fwd_ptr p%x;' % (o - a))
                inits.append('    F_(%s),   /* 0x%06x: vendor 0x%06x */' % (name, 0x800000 + o, va))
                n_ptr += 1
                o += 4
                continue
            e = o
            while e < b and e not in ptr:
                e += 1
            fields.append('    u8 b%x[%d];' % (o - a, e - o))
            bs = ['0x%02x,' % x for x in d[o:e]]
            inits.append('    {')
            for k in range(0, len(bs), 12):
                inits.append('        ' + ' '.join(bs[k:k + 12]))
            inits.append('    },')
            o = e
        out.append('FWDATA(%06x) struct __attribute__((packed)) {' % addr)
        out += fields
        out.append('} fwd_%06x = {' % addr)
        out += inits
        out.append('};')
    if nv:
        out += ['', '/* ---- именованные переменные (fw/dccm_names.txt; объявления — fw/dccm.h) ---- */']
    hdr = ['/* Сгенерировано tools/gen_fw_data.py из fw/dccm_names.txt — не редактировать. */',
           '/* Переменные DCCM fw по фиксированным адресам: определения — fw/fw_data.c (секции',
           ' * .fwdata.<адрес>, значения — начальный образ vendor 6.2). */',
           '#ifndef FW_DCCM_H', '#define FW_DCCM_H', '#include "types.h"', '']
    for off, qual, t, n, nm, cmt in nv:
        addr = 0x800000 + off
        if t == 'ext':
            continue                            # определён вручную (FWDATA в другом файле)
        sz = SIZE[t]
        vals = [int.from_bytes(d[off + k * sz:off + (k + 1) * sz], 'little', signed=t[0] == 's')
                if off + (k + 1) * sz <= len(d) else 0 for k in range(max(n, 1))]
        fmt = (lambda v: '%d' % v) if t[0] == 's' else (lambda v: '0x%x' % v)
        if n:
            init = '{ ' + ', '.join(fmt(v) for v in vals) + ' }'
            decl = '%s%s %s[%d]' % (qual, t, nm, n)
        else:
            init = fmt(vals[0])
            decl = '%s%s %s' % (qual, t, nm)
        out.append('FWDATA(%06x) %s = %s;' % (addr, decl, init))
        hdr.append('extern %s;%s /* 0x%06x%s */' % (decl, ' ' * max(1, 44 - len(decl)), addr,
                                                    (': ' + cmt) if cmt else ''))
    hdr += ['', '#endif', '']
    out.append('')
    open(OUT, 'w').write('\n'.join(out))
    open(HDR, 'w').write('\n'.join(hdr))
    print('fw/fw_data.c: %d объектов, %d указателей, образ до 0x%x' % (len(spans), n_ptr, 0x800000 + len(d)))


if __name__ == '__main__':
    main()
