#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# hybrid_uc.py <our.fw> <out.fw> [vendor.fw] — образ «vendor fw + НАШ uc»: из vendor-образа,
# сегменты uc_code (0x920000) и uc_data (0x940000) берутся из нашего образа (build_fw.py с
# --uc-elf). Так делится вина fw/uc: на стенде 2026-10-18 этот гибрид ассоциировался, когда наш
# fw — нет. В отличие от tools/build_vendor_fw_with_our_uc.py меняет и uc_data (без него не грузится).
import os, struct, sys, zlib
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
import build_fw
ours, out = sys.argv[1], sys.argv[2]
ven = sys.argv[3] if len(sys.argv) > 3 else os.path.join(
    os.path.dirname(os.path.abspath(__file__)), '../../../images/openwrt/fw/wil6210_6.2.0.1000.fw')
V = build_fw.parse_fw(open(ven, 'rb').read())
T = build_fw.parse_fw(open(ours, 'rb').read())
mine = {struct.unpack_from('<I', p, 0)[0]: p for t, f, p in T if t == 2}
recs = []
for t, f, p in V:
    if t == 2 and struct.unpack_from('<I', p, 0)[0] in (0x920000, 0x940000):
        p = mine[struct.unpack_from('<I', p, 0)[0]]
    recs.append((t, f, p))
b = bytearray(b''.join(build_fw.HEAD.pack(t, f, len(p)) + p for t, f, p in recs))
H = build_fw.HEAD.size
struct.pack_into('<I', b, H + 16, len(b))
struct.pack_into('<I', b, H + 8, 0)
struct.pack_into('<I', b, H + 8, zlib.crc32(bytes(b)) & 0xffffffff)
open(out, 'wb').write(b)
print('wrote', out)
