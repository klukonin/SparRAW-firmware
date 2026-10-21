#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# vpatch_txop.py <N> <out.fw> (RW=<rewrite>, тулчейн в PATH) — vendor uc (через uc_hybrid.mk_fw, как vpatch 10-16): 0x931570 mov r9,0x1b001111
# (путь продолжения TXOP) -> b tramp; tramp (0x93ecd0, после конца кода, выравн. 16): N nop; mov r9,..; j 0x931578
import sys, subprocess, os, tempfile
N, out = int(sys.argv[1]), sys.argv[2]
sys.path.insert(0, os.environ['RW'] + '/tools'); import uc_hybrid as uh
v = bytearray(uh.fw_segment(uh.VENDOR_FW, uh.BASE)); end = uh.BASE + len(v); TR = (end + 15) & ~15
SITE = 0x931570
assert v[SITE - uh.BASE:SITE - uh.BASE + 8] == bytes.fromhex('0a21801f001b1111')
d = tempfile.mkdtemp()
open(d + '/p.s', 'w').write('    .section .c0,"ax"\n    b tramp\n    nop\n    .section .tramp,"ax"\ntramp:\n'
                            + '    nop\n' * N + '    mov r9,0x1b001111\n    j 0x931578\n')
open(d + '/p.ld', 'w').write('SECTIONS { .c0 0x%x : { *(.c0) } .tramp 0x%x : { *(.tramp) } }' % (SITE, TR))
subprocess.run(['arc-elf32-as', '-mcpu=arc600', '-o', d + '/p.o', d + '/p.s'], check=True)
subprocess.run(['arc-elf32-ld', '-T', d + '/p.ld', '-o', d + '/p.elf', d + '/p.o'], check=True)
sec = lambda s: subprocess.run(['arc-elf32-objcopy', '-O', 'binary', '-j', s, d + '/p.elf', '/dev/stdout'], capture_output=True, check=True).stdout
c0 = sec('.c0'); assert len(c0) == 8
v[SITE - uh.BASE:SITE - uh.BASE + 8] = c0
v += b'\0' * (TR - end) + sec('.tramp')
open(d + '/uc.bin', 'wb').write(v)
uh.mk_fw(uh.VENDOR_FW, d + '/uc.bin', out)
print(subprocess.run(['arc-elf32-objdump', '-d', d + '/p.elf'], capture_output=True, text=True).stdout.split('Disassembly')[-1][-400:])
