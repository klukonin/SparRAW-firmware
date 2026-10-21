#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""sigaudit.py — «отпечатки» функций: vendor 6.2 asm против нашей сборки build/uc.elf.

Для каждой функции, которая есть и там и там, протягивает константы по регистрам
(mov/bset/asl/or/add… с известными операндами, сброс на метках-целях переходов
и после вызовов) и собирает:
  calls — вызываемые функции (bl/jl/хвостовой b на начало функции);
  mem   — (адрес, ширина, r|w) для доступов с вычисленным адресом (DCCM/MMIO);
  mac   — константные команды MAC (запись в r32);
  const — прочие константы >= 0x100 (кроме адресов).
Печатает расхождения.  Шум: инлайн, CSE, разная раскладка вычислений — разбирать руками.

  sigaudit.py [--elf build/uc.elf] [--fn a,b] [--only calls,mem,mac,const] [--json out]
"""
import os, re, sys, glob, json, argparse, subprocess, collections

R = os.path.dirname(os.path.abspath(__file__))
GP = 0x800528
SZ = {'': 4, 'w': 2, 'h': 2, 'b': 1}
NOWRITE = ('st', 'cmp', 'tst', 'btst', 'br', 'bb', 'b', 'j', 'push', 'pop', 'nop', 'sr', 'flag',
           'sync', 'lp', 'sleep', 'rcmp')
BITOPS = {'bset', 'bclr', 'bmsk', 'asl', 'lsr', 'asr', 'or', 'and', 'add', 'sub', 'bic', 'xor',
          'add1', 'add2', 'add3', 'sub1', 'sub2', 'sub3', 'rsub', 'extb', 'extw', 'bxor', 'not',
          'neg', 'ror'}
M32 = 0xffffffff


def num(s):
    s = s.strip()
    try:
        return int(s, 0)
    except ValueError:
        return None


def split_args(s):
    out, d, cur = [], 0, ''
    for ch in s:
        if ch == '[': d += 1
        if ch == ']': d -= 1
        if ch == ',' and d == 0:
            out.append(cur.strip()); cur = ''
        else:
            cur += ch
    if cur.strip(): out.append(cur.strip())
    return out


def alu(op, a, b):
    if op in ('bset',): return a | (1 << (b & 31))
    if op == 'bclr': return a & ~(1 << (b & 31))
    if op == 'bxor': return a ^ (1 << (b & 31))
    if op == 'bmsk': return a & ((1 << ((b & 31) + 1)) - 1)
    if op == 'asl': return a << (b & 31)
    if op == 'lsr': return a >> (b & 31)
    if op == 'asr': return (a - (1 << 32) if a & 0x80000000 else a) >> (b & 31)
    if op == 'ror': b &= 31; return (a >> b) | (a << (32 - b))
    if op == 'or': return a | b
    if op == 'and': return a & b
    if op == 'xor': return a ^ b
    if op == 'bic': return a & ~b
    if op == 'add': return a + b
    if op == 'add1': return a + (b << 1)
    if op == 'add2': return a + (b << 2)
    if op == 'add3': return a + (b << 3)
    if op == 'sub': return a - b
    if op == 'sub1': return a - (b << 1)
    if op == 'sub2': return a - (b << 2)
    if op == 'sub3': return a - (b << 3)
    if op == 'rsub': return b - a
    return None


class Sig:
    def __init__(self):
        self.calls = collections.Counter(); self.mem = set(); self.mac = set(); self.const = set()


def analyze(insns, targets, fnstart):
    """insns: [(label_or_None, text)]; targets — множество меток-целей; fnstart(name)->имя функции|None."""
    s = Sig(); reg = {}; pend = None
    once = collections.Counter()
    for _, t in insns:
        mm = re.match(r'^(\S+)\s+(r\d+),', t)
        if mm and not mm.group(1).startswith(('st', 'cmp', 'tst', 'btst', 'br', 'bb')): once[mm.group(2)] += 1
        if re.match(r'^(bl|jl)', t): once.update({r: 2 for r in CLOB})
    def val(x):
        if x is None: return None
        if x in reg: return reg[x]
        if re.match(r'^-?(0x[0-9a-f]+|\d+)$', x): return num(x) & M32
        return None
    def note(v):
        if v is not None and v >= 0x100 and not (0x800000 <= v < 0x900000): s.const.add(v)
    insns = list(insns)
    for i in range(len(insns) - 1):            # слот задержки вызова исполняется до вызова
        if re.match(r'^(bl|jl)\S*\.d\b', insns[i][1]) and insns[i + 1][0] not in targets:
            insns[i], insns[i + 1] = (insns[i][0], insns[i + 1][1]), (None, insns[i][1].replace('.d', '', 1))
    for lab, t in insns:
        if lab is not None and lab in targets: reg = {k: v for k, v in reg.items() if once.get(k) == 1}
        m = re.match(r'^(\S+)\s*(.*)$', t)
        if not m: continue
        mn, args = m.group(1), split_args(m.group(2))
        base = mn.split('.')[0].replace('_s', '')
        mc = re.match(r'^(bl|jl|b|j)(eq|ne|hi|ls|cs|cc|lo|hs|mi|pl|gt|ge|lt|le|nz|z)$', base)
        if mc: base = mc.group(1); mn = base + '.' + mc.group(2) + mn[len(mn.split('.')[0]):]
        sfx = mn.split('.')[1:]
        cond = any(x in ('ne', 'eq', 'hi', 'ls', 'cs', 'cc', 'lo', 'hs', 'mi', 'pl', 'gt', 'ge', 'lt',
                         'le', 'nz', 'z') for x in sfx)
        dly = 'd' in sfx
        for a in args:
            if re.match(r'^-?(0x[0-9a-f]+|\d+)$', a): note(num(a) & M32)
        # вызовы
        if base in ('bl', 'jl') or (base in ('b', 'j') and not cond and args and fnstart(args[-1])):
            tgt = fnstart(args[-1]) if args else None
            tgt = ALIAS.get(tgt, tgt)
            if tgt and not tgt.startswith('_'): s.calls[tgt] += 1
            if base in ('bl', 'jl'):
                pend = 'call'
                if not dly: reg = {k: v for k, v in reg.items() if k not in CLOB}; pend = None
            continue
        # доступ к памяти
        mm = re.match(r'^(ld|st)([whb]?)$', base)
        if mm and len(args) == 2 and args[1].startswith('['):
            sz = SZ[mm.group(2)]; d = 'r' if mm.group(1) == 'ld' else 'w'
            inner = split_args(args[1][1:-1])
            asx = 'as' in sfx; aw = 'a' in sfx or 'aw' in sfx; ab = 'ab' in sfx
            ea = None; idx = False
            if len(inner) == 1:
                ea = val(inner[0]) if inner[0] != 'gp' else GP
            else:
                b = GP if inner[0] == 'gp' else val(inner[0])
                o = val(inner[1])
                if b is not None:
                    if o is None: ea = b; idx = True
                    else: ea = b + (o * sz if asx else (o if o < 0x80000000 else o - (1 << 32)))
                    if ab: ea = b
            if ea is not None and ea >= 0x800000:
                s.mem.add((ea & M32, sz, d + ('i' if idx else '')))
            if d == 'w' and mn.startswith('st') and False: pass
            if (aw or ab) and inner and inner[0] in reg: reg.pop(inner[0])
            if d == 'r': reg.pop(args[0], None)
            if d == 'w':
                v = val(args[0]); note(v) if v is not None and not re.match(r'^r\d+$', args[0]) else None
            continue
        if not args: continue
        dst = args[0]
        if base == 'mov' or base == 'mov_s':
            v = val(args[1]) if len(args) > 1 else None
            if dst == 'r32' and v is not None: s.mac.add(v)
            if cond:
                reg.pop(dst, None)
            elif v is not None:
                reg[dst] = v; note(v)
            else:
                reg.pop(dst, None)
            continue
        if base.startswith(NOWRITE) and base not in BITOPS and not base.startswith(('bset', 'bclr', 'bmsk', 'bic', 'bxor')):
            continue
        if base in BITOPS and not cond:
            if len(args) == 3: a, b = val(args[1]), val(args[2])
            elif len(args) == 2:
                if base in ('extb', 'extw', 'not', 'neg'): a, b = val(args[1]), 0
                else: a, b = val(dst), val(args[1])
            else: a = b = None
            if base == 'extb' and a is not None: r = a & 0xff
            elif base == 'extw' and a is not None: r = a & 0xffff
            elif base == 'not' and a is not None: r = ~a
            elif base == 'neg' and a is not None: r = -a
            else: r = alu(base, a, b) if a is not None and b is not None else None
            if re.match(r'^r\d+$', dst):
                if r is None: reg.pop(dst, None)
                else: reg[dst] = r & M32; note(r & M32)
            continue
        if re.match(r'^r\d+$', dst): reg.pop(dst, None)
    return s


ALIAS = {'uc_sysassert': 'uc_assert'}
CLOB = {'r%d' % i for i in range(13)} | {'blink'}


def load_names():
    names, byname = {}, {}
    for l in open(os.path.join(R, 'ghidra', 'out', 'names.txt')):
        p = l.split()
        if len(p) >= 2:
            names[int(p[0], 16)] = p[1]; byname[p[1]] = int(p[0], 16)
    return names, byname


def vendor_funcs(names):
    out = {}
    for f in sorted(glob.glob(os.path.join(R, '..', '..', '6.2', 'src', 'asm', 'uc', '*', '*.S'))):
        if f.endswith('_all.S'): continue
        t = open(f).read(); m = re.search(r'@ 0x([0-9a-f]+)', t)
        if not m: continue
        n = names.get(int(m.group(1), 16))
        if not n: continue
        insns, lab, pc = [], None, None
        for l in t.split('\n'):
            ml = re.match(r'^(L_[0-9a-f]+):', l)
            if ml: lab = ml.group(1); continue
            if not l.startswith('\t'): continue
            st = l.strip()
            mc = re.match(r'^/\* (.*) \*/$', st)
            if mc: pc = mc.group(1); continue
            if st.startswith('.byte') and pc: insns.append((lab, pc)); lab = None; pc = None; continue
            if st.startswith(('.', '/*', '*')): continue
            insns.append((lab, st.replace(', ', ',').replace(' ,', ','))); lab = None
        targets = set()
        for _, x in insns:
            for mt in re.findall(r'\bL_[0-9a-f]+\b', x): targets.add(mt)
        out[n] = (insns, targets)
    return out


def our_funcs(elf):
    d = subprocess.run(['arc-elf32-objdump', '-d', '--no-show-raw-insn', elf], capture_output=True, text=True).stdout
    out = {}; cur = None
    for l in d.splitlines():
        m = re.match(r'^([0-9a-f]+) <([^>]+)>:', l)
        if m: cur = m.group(2); out[cur] = []; continue
        m = re.match(r'^\s+([0-9a-f]+):\s+(.*)$', l)
        if not m or cur is None: continue
        addr, t = m.group(1), m.group(2)
        tgt = re.search(r';\s*([0-9a-f]+)\s+<([^>]+)>', t)
        t = re.sub(r'\s*;.*$', '', t).strip()
        mn = t.split(None, 1)
        if tgt:
            name = tgt.group(2)
            t = mn[0] + ' ' + (('@' + name) if '+' not in name else ('L_' + tgt.group(1)))
            if len(mn) > 1 and ',' in mn[1]:  # brcc a,b,tgt
                t = mn[0] + ' ' + ','.join(split_args(mn[1])[:-1] + [t.split(' ', 1)[1]])
        out[cur].append(('L_' + addr.lstrip('0'), t.replace('\t', ' ')))
    res = {}
    for n, insns in out.items():
        targets = set()
        for _, x in insns:
            for mt in re.findall(r'\bL_[0-9a-f]+\b', x): targets.add(mt)
        res[n] = (insns, targets)
    return res


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--elf', default=os.path.join(R, '..', 'build', 'uc.elf'))
    ap.add_argument('--fn', default='')
    ap.add_argument('--only', default='calls,mem,mac,const')
    ap.add_argument('--json')
    a = ap.parse_args()
    names, byname = load_names()
    V = vendor_funcs(names)
    O = our_funcs(a.elf)
    only = set(a.only.split(','))
    fns = a.fn.split(',') if a.fn else sorted(set(V) & set(O))
    def vstart(x):
        m = re.match(r'^L_([0-9a-f]+)$', x)
        return names.get(int(m.group(1), 16)) if m else None
    def ostart(x):
        return x[1:] if x.startswith('@') else None
    report = {}
    for n in fns:
        if n not in V or n not in O: continue
        sv = analyze(*V[n], vstart); so = analyze(*O[n], ostart)
        d = {}
        if 'calls' in only:
            cv, co = set(sv.calls), set(so.calls)
            if cv != co: d['calls'] = (sorted(cv - co), sorted(co - cv))
        if 'mem' in only:
            mv = {x for x in sv.mem if len(x[2]) == 1}; mo = {x for x in so.mem if len(x[2]) == 1}
            if mv != mo: d['mem'] = (sorted(mv - mo), sorted(mo - mv))
        if 'mac' in only and sv.mac != so.mac: d['mac'] = (sorted(sv.mac - so.mac), sorted(so.mac - sv.mac))
        if 'const' in only and sv.const != so.const:
            d['const'] = (sorted(sv.const - so.const), sorted(so.const - sv.const))
        if d:
            report[n] = d
            print('== %s' % n)
            for k, (va, oa) in d.items():
                f = (lambda x: '0x%x/%d%s' % x) if k == 'mem' else (lambda x: '0x%x' % x) if k in ('mac', 'const') else str
                print('  %-5s только vendor: %s' % (k, ' '.join(f(x) for x in va)))
                print('  %-5s только наш:    %s' % ('', ' '.join(f(x) for x in oa)))
    print('функций сравнено %d, с расхождениями %d' % (len([n for n in fns if n in V and n in O]), len(report)),
          file=sys.stderr)
    if a.json:
        json.dump({k: {kk: [list(map(lambda z: list(z) if isinstance(z, tuple) else z, vv)) for vv in v]
                       for kk, v in d.items()} for k, d in report.items()}, open(a.json, 'w'), indent=1)


if __name__ == '__main__':
    main()
