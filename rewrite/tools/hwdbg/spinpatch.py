#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# spinpatch.py <in.fw> <addr hex> <out.fw> — вечный цикл (b .) по адресу кода в образе wil6210 (пересчёт CRC)
import struct, sys, zlib
src, addr, out = sys.argv[1], int(sys.argv[2], 16), sys.argv[3]
b = bytearray(open(src, 'rb').read())
sys.path.insert(0, __import__('os').path.join(__import__('os').path.dirname(__import__('os').path.abspath(__file__)), '..'))
from build_fw import HEAD
off = 0; done = False
while off + 12 <= len(b):
    typ, flags, size = HEAD.unpack_from(b, off)
    p = off + HEAD.size
    if typ == 2:
        dest = struct.unpack_from('<I', b, p)[0]
        if dest <= addr < dest + size - 4:
            o = p + 4 + (addr - dest)
            if addr % 4 == 2:
                b[o:o+2] = bytes.fromhex('e078')      # nop_s (0x78e0)
                o += 2
            b[o:o+4] = bytes.fromhex('01000000')      # b . (0x0001 0x0000)
            done = True
    off = p + size
assert done, 'addr not in code records'
# CRC: поле crc в первой записи (тип 6) по смещению HEAD+8, с обнулённым полем
crc_off = HEAD.size + 8
t = bytearray(b); struct.pack_into('<I', t, crc_off, 0)
struct.pack_into('<I', b, crc_off, zlib.crc32(bytes(t)) & 0xffffffff)
open(out, 'wb').write(bytes(b)); print('patched', hex(addr), '->', out)
