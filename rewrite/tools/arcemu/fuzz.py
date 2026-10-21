#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Дифференциальный фаззинг эмулятора cpu.py.

Случайная C-функция f(a,b,c,d) (u32-арифметика, сдвиги, сравнения, ветвления,
циклы, загрузки/записи байт/полуслов/слов в буфер, умножение, min/max)
компилируется ARC-gcc (разные опции) и исполняется в эмуляторе; та же функция
компилируется нативным cc. Сравниваются возврат и выходной буфер.

  fuzz.py [--n 200] [--seed 1] [--keep]
"""
import argparse, os, random, shutil, subprocess, sys, tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import cpu as cpumod                                   # noqa: E402

TC = cpumod.TC
GCC = TC + '/arc-elf32-gcc'
OPTS = [
    ['-O0'], ['-Os'], ['-O2'], ['-O2', '-mmul64'], ['-Os', '-mnorm'],
    ['-O2', '-mnorm', '-mmul64', '-funroll-loops'], ['-O1', '-mbarrel-shifter'],
]
BUF = 0x10000          # выходной/рабочий буфер (u32[32])
CODE = 0x1000
RET = 0xff00


class Gen:
    def __init__(self, rng):
        self.r = rng
        self.vars = ['a', 'b', 'c', 'd']
        self.n = 0

    def lit(self):
        return self.r.choice(['0', '1', '2', '3', '7', '0x1f', '0xff', '0xffff', '0x80000000',
                              '0x7fffffff', '0xffffffff', '%#x' % self.r.getrandbits(32),
                              str(self.r.randrange(0, 64))]) + 'u'

    def atom(self):
        return self.r.choice(self.vars + [self.lit()])

    def expr(self, d=0):
        if d > 3 or self.r.random() < 0.25:
            return self.atom()
        k = self.r.randrange(24)
        x, y = self.expr(d + 1), self.expr(d + 1)
        if k == 0: return '(%s + %s)' % (x, y)
        if k == 1: return '(%s - %s)' % (x, y)
        if k == 2: return '(%s & %s)' % (x, y)
        if k == 3: return '(%s | %s)' % (x, y)
        if k == 4: return '(%s ^ %s)' % (x, y)
        if k == 5: return '(%s << (%s & 31u))' % (x, y)
        if k == 6: return '(%s >> (%s & 31u))' % (x, y)
        if k == 7: return '(u32)((s32)%s >> (%s & 31u))' % (x, y)
        if k == 8: return '(%s * %s)' % (x, y)
        if k == 9: return '(u32)((s32)%s < (s32)%s)' % (x, y)
        if k == 10: return '(u32)(%s < %s)' % (x, y)
        if k == 11: return '(~%s)' % x
        if k == 12: return '(u32)(-(s32)%s)' % x
        if k == 13: return '((s32)%s < (s32)%s ? %s : %s)' % (x, y, x, y)
        if k == 14: return '(u32)(u8)%s' % x
        if k == 15: return '(u32)(s16)%s' % x
        if k == 16: return '(((%s >> %d) & 1u) ? %s : %s)' % (x, self.r.randrange(32), y, self.expr(d + 1))
        if k == 17: return '(%s ? (u32)__builtin_clz(%s) : 32u)' % (x, x)
        if k == 18: return '((s32)%s > (s32)%s ? %s : %s)' % (x, y, x, y)
        if k == 19: return '(u32)(s8)%s' % x
        if k == 20: return '(u32)(((unsigned long long)%s << 32 | %s) + ((unsigned long long)%s << 32 | %s) >> %d)' % (x, y, y, x, self.r.randrange(64))
        if k == 21: return '(u32)(((unsigned long long)%s * %s) >> 32)' % (x, y)
        if k == 22: return 'buf[(%s) & 31u]' % x
        return '(%s == %s ? %s : %s)' % (x, y, self.expr(d + 1), self.expr(d + 1))

    def stmt(self, d=0):
        k = self.r.randrange(10)
        v = self.r.choice(self.vars)
        idx = self.r.randrange(32)
        if k <= 2:
            return '%s = %s;' % (v, self.expr())
        if k == 3:
            return 'buf[%d] = %s;' % (idx, self.expr())
        if k == 4:
            return '((u8 *)buf)[%d] = (u8)%s; %s ^= ((u16 *)buf)[%d];' % (
                self.r.randrange(128), self.expr(), v, self.r.randrange(64))
        if k == 5:
            return '%s += (u32)((s8 *)buf)[%d];' % (v, self.r.randrange(128))
        if k == 6 and d < 2:
            return 'if (%s) { %s } else { %s }' % (self.expr(), self.stmt(d + 1), self.stmt(d + 1))
        if k == 7 and d < 2:
            self.n += 1
            i = 'i%d' % self.n
            return 'for (u32 %s = 0; %s < (%s & 15u); %s++) { %s }' % (i, i, self.atom(), i, self.stmt(d + 1))
        if k == 8:
            return 'buf[(%s) & 31u] = %s;' % (self.expr(), self.expr())
        return 'buf[%d] += %s;' % (idx, self.expr())

    def func(self):
        body = '\n    '.join(self.stmt() for _ in range(self.r.randrange(4, 12)))
        return ('typedef unsigned int u32; typedef int s32; typedef unsigned short u16;'
                ' typedef short s16; typedef unsigned char u8; typedef signed char s8;\n'
                'u32 f(u32 a, u32 b, u32 c, u32 d, u32 *buf)\n{\n    %s\n    return a ^ b ^ c ^ d;\n}\n' % body)


NATIVE_MAIN = r'''
#include <stdio.h>
#include <string.h>
u32 f(u32, u32, u32, u32, u32 *);
int main(int argc, char **argv) {
    u32 buf[32]; unsigned i;
    unsigned a, b, c, d;
    sscanf(argv[1], "%x", &a); sscanf(argv[2], "%x", &b); sscanf(argv[3], "%x", &c); sscanf(argv[4], "%x", &d);
    for (i = 0; i < 32; i++) buf[i] = 0x01010101u * (i + 1);
    u32 r = f(a, b, c, d, buf);
    printf("%08x", r); for (i = 0; i < 32; i++) printf(" %08x", buf[i]); printf("\n");
    return 0;
}
'''


def native(src, work, args):
    exe = os.path.join(work, 'n')
    if not os.path.exists(exe):
        open(os.path.join(work, 'n.c'), 'w').write(src + NATIVE_MAIN)
        subprocess.run(['cc', '-O0', '-fwrapv', '-fno-strict-aliasing', '-o', exe, os.path.join(work, 'n.c')], check=True,
                       capture_output=True)
    out = subprocess.run([exe] + ['%x' % x for x in args], capture_output=True, text=True).stdout.split()
    return [int(x, 16) for x in out]


def arc_build(src, work, opts):
    c = os.path.join(work, 'a.c')
    open(c, 'w').write(src)
    o, e, b = (os.path.join(work, 'a.' + x) for x in ('o', 'elf', 'bin'))
    lib = subprocess.run([GCC, '-mcpu=arc600'] + opts + ['-print-libgcc-file-name'],
                         capture_output=True, text=True).stdout.strip()
    # gas (binutils 2021.03) кодирует `neg.f 0,rX` с приёмником r0 (A=0 вместо 62);
    # эквивалентный `rsub.f 0,rX,0` кодируется верно — подменяем до ассемблирования.
    asm = os.path.join(work, 'a.s')
    subprocess.run([GCC, '-mcpu=arc600', '-ffreestanding', '-fno-builtin', '-fwrapv', '-fno-strict-aliasing'] + opts +
                   ['-S', '-o', asm, c], check=True, capture_output=True)
    import re as _re
    txt = _re.sub(r'\bneg(_s)?\.f(\s+)0,(r\d+)', r'rsub.f\g<2>0,\g<3>,0', open(asm).read())
    open(asm, 'w').write(txt)
    subprocess.run([TC + '/arc-elf32-as', '-mcpu=arc600', '-o', o, asm], check=True, capture_output=True)
    subprocess.run([TC + '/arc-elf32-ld', '-Ttext=0x%x' % CODE, '-e', 'f', '-o', e, o, lib],
                   check=True, capture_output=True)
    subprocess.run([TC + '/arc-elf32-objcopy', '-O', 'binary', '--only-section=.text', e, b],
                   check=True, capture_output=True)
    sym = subprocess.run([TC + '/arc-elf32-nm', e], capture_output=True, text=True).stdout
    entry = [int(l.split()[0], 16) for l in sym.splitlines() if l.endswith(' f')][0]
    return open(b, 'rb').read(), entry


def arc_run(code, entry, args):
    c = cpumod.CPU(seed=1)
    c.load(CODE, code, is_code=True)
    for i in range(32):
        v = 0x01010101 * (i + 1) & 0xffffffff
        c.write(BUF + 4 * i, list(v.to_bytes(4, 'little')))
    c.set_regs({0: args[0], 1: args[1], 2: args[2], 3: args[3], 4: BUF})
    c.sp = 0x8000
    c.blink = RET
    c.run(entry, stop=RET, max_steps=2_000_000)
    if c.pc != RET:
        raise cpumod.EmuError('не вернулась (pc=0x%x, exhausted=%s)' % (c.pc, c.exhausted))
    return [c.regs[0] & 0xffffffff] + [c.read(BUF + 4 * i, 4) for i in range(32)]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--n', type=int, default=200)
    ap.add_argument('--seed', type=int, default=1)
    ap.add_argument('--keep', action='store_true')
    a = ap.parse_args()
    rng = random.Random(a.seed)
    fails = 0
    for t in range(a.n):
        src = Gen(rng).func()
        opts = OPTS[t % len(OPTS)]
        work = tempfile.mkdtemp(prefix='fz_')
        try:
            code, entry = arc_build(src, work, opts)
            for k in range(3):
                args = [rng.getrandbits(32) if rng.random() < 0.5 else rng.randrange(40) for _ in range(4)]
                exp = native(src, work, args)
                try:
                    got = arc_run(code, entry, args)
                except Exception as e:                  # noqa: BLE001
                    got = ['ERR %s' % e]
                if got != exp:
                    fails += 1
                    d = next((i for i in range(min(len(got), len(exp))) if got[i] != exp[i]), None)
                    print('FAIL #%d opts=%s args=%s diff@%s: emu=%s native=%s' % (
                        t, ' '.join(opts), ['%#x' % x for x in args], d,
                        got[d] if d is not None and d < len(got) else got[:1],
                        exp[d] if d is not None else exp[:1]))
                    keep = os.path.join(HERE, 'fuzz_fail_%d_%d.c' % (a.seed, t))
                    open(keep, 'w').write('// opts: %s\n// args: %s\n' % (' '.join(opts), args) + src)
                    break
        finally:
            if not a.keep:
                shutil.rmtree(work, ignore_errors=True)
    print('ИТОГО: %d функций, провалов %d' % (a.n, fails))
    sys.exit(1 if fails else 0)


if __name__ == '__main__':
    main()
