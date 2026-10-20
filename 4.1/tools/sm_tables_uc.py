#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""То же, что sm_tables.py, но для ucode: свой setup @0x928174 и свои данные.

ВАЖНО: у ucode СВОЁ адресное пространство данных — сегмент uc_data
(0x940000 в образе) ложится по 0x800000, а не fw_data.
"""
import bisect, json, re, struct, sys

DATA_BASE = 0x800000
STR_BASE = 0x1000000
SETUP = 0x928174
GP = 0x800528


def load(path, sym):
    by = bytearray()
    for l in open(path):
        m = re.match(r'\s*\.byte\s+([0-9a-fx,\s]+?)\s*(?:/\*|$)', l)
        if m:
            for v in m.group(1).split(','):
                v = v.strip()
                if v:
                    by.append(int(v, 0))
            continue
        m = re.match(r'\s*\.long\s+(\S+)\s+-\s+0x00920000', l)
        if m:
            n = m.group(1)
            v = int(n[2:], 16) if n.startswith('L_') else sym.get(n, 0x920000)
            by += struct.pack('<I', v - 0x920000)
            continue
        if re.match(r'\s*\.long\s+', l):
            by += b'\0\0\0\0'
    return by


def main():
    d0 = json.load(open('src/asm/uc/blocks.json'))
    sym0 = {b['name']: b['addr'] for b in d0['blocks']}
    by = load('src/data/uc_data.S', sym0)
    # указатели на код ucode лежат сырыми байтами (адрес абсолютный)
    sd = open('ref/strings-uc.bin', 'rb').read()

    def dw(a):
        o = a - DATA_BASE
        return struct.unpack_from('<I', by, o)[0] if 0 <= o <= len(by) - 4 else None

    def s(a):
        if a is None:
            return None
        o = a - STR_BASE
        if 0 <= o < len(sd):
            t = sd[o:o + 60].split(b'\0')[0]
        else:
            o = a - DATA_BASE
            if not (0 <= o < len(by)):
                return None
            t = bytes(by[o:o + 60]).split(b'\0')[0]
        if len(t) < 2:
            return None
        try:
            r = t.decode('ascii')
        except UnicodeDecodeError:
            return None
        return r if all(32 <= ord(c) < 127 for c in r) else None

    rows = []
    for l in open('../blobs/insns/INSNS-4100.txt'):
        if l.startswith('I '):
            p = l.split(None, 3)
            a = int(p[1], 16)
            if 0x920000 <= a < 0x93a000:
                rows.append((a, p[3].rstrip()))

    d = json.load(open('src/asm/uc/blocks.json'))
    st = sorted(d['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]

    def own(a):
        i = bisect.bisect_right(ads, a) - 1
        return st[i] if i >= 0 else None

    MOVK = re.compile(r'^_?mov(?:_s)?\s+(r\d+),\s*(0x[0-9a-f]+|\d+)$')
    LDGP = re.compile(r'^_?ld\.as\s+(r\d+),\[gp,\s*(-?0x[0-9a-f]+|-?\d+)\]$')
    CALL = re.compile(r'^_?(?:bl|b)(?:\.d)?\s+0x0*([0-9a-f]{6})$')

    out = []
    for i, (a, t) in enumerate(rows):
        m = CALL.match(t)
        if not m or int(m.group(1), 16) != SETUP:
            continue
        regs = {}
        for j in range(max(0, i - 24), i + 2):
            tt = rows[j][1]
            mm = MOVK.match(tt)
            if mm:
                regs[mm.group(1)] = int(mm.group(2), 0)
                continue
            mm = LDGP.match(tt)
            if mm:
                regs[mm.group(1)] = dw(GP + int(mm.group(2), 0))
        need = ['r1', 'r3', 'r4', 'r5', 'r6', 'r7']
        if any(k not in regs or regs[k] is None for k in need):
            print('# 0x%06x: неполные аргументы %s' % (a, regs), file=sys.stderr)
            continue
        name = s(regs['r1'])
        trans, ev, stn, nev, nst = regs['r3'], regs['r4'], regs['r5'], regs['r6'], regs['r7']
        caller = own(a)
        print('== %s  init=%s @0x%06x  trans=0x%06x  events=0x%06x x%d  states=0x%06x x%d'
              % (name, caller['name'], caller['addr'], trans, ev, nev, stn, nst))
        for e in range(nev):
            en = s(dw(ev + 4 * e)) or ('EVT%d' % e)
            for c in range(nst):
                cn = s(dw(stn + 4 * c)) or ('ST%d' % c)
                idx = c + e * nst
                raw = dw(trans + idx * 5)
                h = (raw + 0x920000) if raw else 0
                o = trans + idx * 5 + 4 - DATA_BASE
                ns = by[o] if 0 <= o < len(by) else 0
                nsn = s(dw(stn + 4 * ns)) or ('ST%d' % ns)
                if h and 0x920000 <= h < 0x93a000:
                    b = own(h)
                    flag = '' if b and b['addr'] == h else '  (не начало блока!)'
                    out.append((h, name, cn, en, b['name'] if b else '?', flag))
                    print('   %-20s x %-24s -> %-36s next=%-18s%s'
                          % (cn, en, b['name'] if b else '?', nsn, flag))
    print('# обработчиков: %d' % len(out), file=sys.stderr)

    import collections
    grp = collections.defaultdict(list)
    for h, sm, cn, en, bn, flag in out:
        grp[h].append((sm, cn, en, bn, flag))

    def norm(x):
        return re.sub(r'[^A-Za-z0-9]+', '_', x or '?').strip('_').lower()

    cands = []
    for h in sorted(grp):
        v = grp[h]
        bn = v[0][3]
        if not bn.startswith(('sub_', 'blk_')):
            continue
        sms = {x[0] for x in v}
        evs = {x[2] for x in v}
        sts = {x[1] for x in v}
        if len(sms) != 1 or len(evs) != 1 or None in sms or None in evs:
            continue
        cands.append((h, '%s__on_%s' % (norm(list(sms)[0]), norm(list(evs)[0])),
                      sorted(sts), list(sms)[0], list(evs)[0], v[0][4]))
    seen = collections.Counter(c[1] for c in cands)
    print('\n#### КАНДИДАТЫ (%d)' % len(cands), file=sys.stderr)
    for h, nm, sts, sm, ev, flag in cands:
        if seen[nm] > 1:
            nm = '%s__%s' % (nm, norm(sts[0]))
        print('0x%08x  %-44s # %s: %s x %s%s'
              % (h, nm, sm, ','.join(sts)[:40], ev, flag), file=sys.stderr)


if __name__ == '__main__':
    main()
