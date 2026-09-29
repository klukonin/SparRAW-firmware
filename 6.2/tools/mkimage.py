#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Собрать прошиваемый образ: вендорский .fw + наш код + патчи хуков.

Контейнер .fw — последовательность записей:
    заголовок записи: <u16 type><u16 flags><u32 size>, затем payload
    type 6  — файловый заголовок: <u32 signature><u32 reserved><u32 crc>
              <u32 version><u32 data_len><32s comment>
    type 2  — данные: <u32 addr> + содержимое, пишется по адресу addr
Загрузчик применяет записи по порядку, поэтому НАШ КОД добавляется отдельной
записью type 2 и не трогает ни одного вендорского байта.

    mkimage.py --in вендор.fw --out образ.fw \\
               --add build/ext.bin@0x8fc564 \\
               --overlay build/hook_008c2190.ovl [--strip]
"""
import argparse, os, struct, sys, zlib

HEAD = struct.Struct('<HHI')
FILE_HEADER = struct.Struct('<IIIII32s')
DROP_FOR_MAINLINE = {100, 101, 102}   # вендорские строковые таблицы: mainline-драйвер их не знает

# ёмкость областей на чипе (из sparrow_fw_mapping драйвера wil6210)
REGIONS = {'fw_code': (0x8c0000, 0x40000), 'fw_data': (0x900000, 0x8000),
           'uc_code': (0x920000, 0x20000), 'uc_data': (0x940000, 0x4000)}


class Bad(Exception):
    pass


def parse(blob):
    recs, off = [], 0
    while off + HEAD.size <= len(blob):
        typ, flags, size = HEAD.unpack_from(blob, off)
        payload = blob[off + HEAD.size: off + HEAD.size + size]
        if len(payload) != size:
            break
        recs.append(dict(type=typ, flags=flags, payload=payload))
        off += HEAD.size + size
        if typ == 6:
            data_len = FILE_HEADER.unpack_from(payload, 0)[4]
            if off >= data_len:
                break
    return recs


def region_of(addr):
    for name, (base, cap) in REGIONS.items():
        if base <= addr < base + cap:
            return name, base, cap
    return None, None, None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--in', dest='inp', required=True)
    ap.add_argument('--out', required=True)
    ap.add_argument('--add', action='append', default=[],
                    help='файл@адрес — добавить записью type 2')
    ap.add_argument('--overlay', action='append', default=[],
                    help='файл со строками "0xADDR: hexbytes" — правка на месте')
    ap.add_argument('--strip', action='store_true',
                    help='выбросить записи 100/101/102 (нужно для mainline-драйвера)')
    a = ap.parse_args()

    recs = parse(open(a.inp, 'rb').read())
    if not recs or recs[0]['type'] != 6:
        raise Bad('первая запись не файловый заголовок — это не .fw')
    print('прочитано записей: %d, типы %s' % (len(recs), [r['type'] for r in recs]))

    if a.strip:
        before = len(recs)
        recs = [r for r in recs if r['type'] not in DROP_FOR_MAINLINE]
        if before != len(recs):
            print('выброшено вендорских строковых записей: %d' % (before - len(recs)))

    # карта занятого: адрес -> длина, по записям данных
    occupied = []
    for r in recs:
        if r['type'] == 2 and len(r['payload']) >= 4:
            addr = struct.unpack_from('<I', r['payload'], 0)[0]
            occupied.append((addr, len(r['payload']) - 4, r))

    # ---- правки на месте (патчи хуков)
    for ovl in a.overlay:
        for line in open(ovl):
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            addr_s, _, hex_s = line.partition(':')
            addr, data = int(addr_s, 16), bytes.fromhex(hex_s.strip())
            for base, size, r in occupied:
                if base <= addr and addr + len(data) <= base + size:
                    p = bytearray(r['payload'])
                    o = 4 + (addr - base)
                    was = bytes(p[o:o + len(data)])
                    p[o:o + len(data)] = data
                    r['payload'] = bytes(p)
                    print('патч 0x%08x: %s -> %s' % (addr, was.hex(), data.hex()))
                    break
            else:
                raise Bad('адрес 0x%08x не попадает ни в одну запись данных' % addr)

    # ---- наш код отдельными записями
    for spec in a.add:
        fn, _, addr_s = spec.partition('@')
        if not addr_s:
            raise Bad('ожидается файл@адрес, получено %r' % spec)
        addr = int(addr_s, 16)
        data = open(fn, 'rb').read()
        if not data:
            raise Bad('%s пуст' % fn)
        if len(data) % 4:
            data += b'\0' * (4 - len(data) % 4)
        name, base, cap = region_of(addr)
        if name is None:
            raise Bad('адрес 0x%08x вне известных областей чипа' % addr)
        if addr + len(data) > base + cap:
            raise Bad('не влезает в %s: 0x%08x+%d > 0x%08x'
                      % (name, addr, len(data), base + cap))
        for obase, osize, _ in occupied:
            if addr < obase + osize and obase < addr + len(data):
                raise Bad('пересекается с вендорской записью 0x%08x..0x%08x'
                          % (obase, obase + osize))
        recs.append(dict(type=2, flags=0, payload=struct.pack('<I', addr) + data))
        occupied.append((addr, len(data), recs[-1]))
        print('добавлено: %s -> 0x%08x, %d Б (область %s, до конца остаётся %d Б)'
              % (fn, addr, len(data), name, base + cap - addr - len(data)))

    # ---- пересборка с пересчётом data_len и crc
    body = bytearray()
    for r in recs:
        if r['type'] == 6:
            sig, res, _, ver, _, comment = FILE_HEADER.unpack_from(r['payload'], 0)
            payload = FILE_HEADER.pack(sig, res, 0, ver, 0, comment)
        else:
            payload = r['payload']
        if len(payload) % 4:
            raise Bad('payload записи type %d не кратен 4' % r['type'])
        body += HEAD.pack(r['type'], r['flags'], len(payload))
        body += payload
    data_len = len(body)
    struct.pack_into('<I', body, HEAD.size + 16, data_len)
    patched = bytearray(body)
    struct.pack_into('<I', patched, HEAD.size + 8, 0)
    crc = zlib.crc32(bytes(patched)) & 0xffffffff
    struct.pack_into('<I', body, HEAD.size + 8, crc)

    open(a.out, 'wb').write(bytes(body))
    print('собран %s: %d Б, записей %d, типы %s, data_len %d, crc 0x%08x'
          % (a.out, len(body), len(recs), [r['type'] for r in recs], data_len, crc))
    return 0


if __name__ == '__main__':
    try:
        sys.exit(main())
    except Bad as e:
        print('ОШИБКА: %s' % e)
        sys.exit(1)
