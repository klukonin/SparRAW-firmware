#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Собрать .fw = vendor fw_code (0x8c0000) + НАШ uc_code (0x920000) + vendor остальное.

Цель: запустить vendor-инициализацию RFC с нашим uc, который дампит RFC-регистры
в shared RGF (0x880c00..) в момент uc-ready — снять «calibration-ready» state vendor.
"""
import argparse, struct, subprocess, tempfile, os, zlib

HEAD = struct.Struct('<HHI')
FW_MAGIC = 0x36323130


def parse_fw(blob):
    recs, off = [], 0
    while off + HEAD.size <= len(blob):
        typ, flags, size = HEAD.unpack_from(blob, off)
        payload = blob[off + HEAD.size: off + HEAD.size + size]
        if len(payload) != size:
            break
        recs.append((typ, flags, payload))
        off += HEAD.size + size
    return recs


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--uc-elf', required=True)
    ap.add_argument('--vendor', required=True)
    ap.add_argument('--out', required=True)
    ap.add_argument('--objcopy', default='arc-elf32-objcopy')
    a = ap.parse_args()

    vend = parse_fw(open(a.vendor, 'rb').read())

    tmp = tempfile.mkdtemp()
    vec = os.path.join(tmp, 'vec.bin')
    txt = os.path.join(tmp, 'txt.bin')
    subprocess.run([a.objcopy, '-O', 'binary', '--only-section=.vectors', a.uc_elf, vec], check=True)
    subprocess.run([a.objcopy, '-O', 'binary', '--only-section=.text', a.uc_elf, txt], check=True)
    uc_code_b = open(vec, 'rb').read() + open(txt, 'rb').read()
    print('our uc_code: %d bytes' % len(uc_code_b))

    # Оставляем ВСЁ vendor (в т.ч. fw_code 0x8c0000), кроме vendor uc_code (0x920000..0x940000).
    records = []
    for typ, flags, payload in vend:
        if typ == 2 and len(payload) >= 4:
            addr = struct.unpack_from('<I', payload, 0)[0]
            if 0x920000 <= addr < 0x940000:
                continue
        records.append((typ, flags, payload))

    # Вставляем наш uc_code на 0x920000.
    records.append((2, 0, struct.pack('<I', 0x920000) + uc_code_b))

    body = bytearray()
    for typ, flags, payload in records:
        p = payload
        if len(p) % 4:
            p += b'\0' * (4 - len(p) % 4)
        body += HEAD.pack(typ, flags, len(p)) + p

    # Патчим data_len (arg4 @16) и crc (arg2 @8) в file-header (первая запись type 6).
    data_len = len(body)
    struct.pack_into('<I', body, HEAD.size + 16, data_len)
    patched = bytearray(body)
    struct.pack_into('<I', patched, HEAD.size + 8, 0)
    crc = zlib.crc32(bytes(patched)) & 0xffffffff
    struct.pack_into('<I', body, HEAD.size + 8, crc)

    open(a.out, 'wb').write(bytes(body))
    print('wrote %s (%d bytes), crc 0x%08x' % (a.out, len(body), crc))


if __name__ == '__main__':
    main()
