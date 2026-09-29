#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Расшифровать автоматы basic_sm: имена состояний, событий и обработчиков.

basic_sm__setup(obj, name, init_state, trans, event_names, n_events,
                state_names, n_states) — аргументы r0..r7.
Таблица переходов: запись 5 байт, [0..3] адрес обработчика, [4] следующее
состояние; индекс = cur_state + evt * n_states.
"""
import json, re, struct, sys, bisect

DATA_BASE = 0x800000
STR_BASE = 0x1000000
SETUP = 0x8d6478


def load_data(sym):
    import struct as _s
    by = bytearray()
    for l in open('src/data/fw_data.S'):
        m = re.match(r'\s*\.byte\s+([0-9a-fx,\s]+?)\s*(?:/\*|$)', l)
        if m:
            for v in m.group(1).split(','):
                v = v.strip()
                if v:
                    by.append(int(v, 0))
            continue
        m = re.match(r'\s*\.long\s+(\S+)\s+-\s+0x008c0000', l)
        if m:
            n = m.group(1)
            if n.startswith('L_'):
                v = int(n[2:], 16) - 0x8c0000
            else:
                v = sym.get(n, 0x8c0000) - 0x8c0000
            by += _s.pack('<I', v)
    return by


def main():
    d0 = json.load(open('src/asm/fw/blocks.json'))
    sym = {b['name']: b['addr'] for b in d0['blocks']}
    by = load_data(sym)
    sd = open('ref/strings-fw.bin', 'rb').read()

    def dw(a):
        o = a - DATA_BASE
        return struct.unpack_from('<I', by, o)[0] if 0 <= o <= len(by) - 4 else None

    def s(a):
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

    def strv(arr, i):
        p = dw(arr + 4 * i)
        return s(p) if p else None

    rows = []
    for l in open('../blobs/insns/INSNS-4100.txt'):
        if l.startswith('I '):
            p = l.split(None, 3)
            a = int(p[1], 16)
            if 0x8c0000 <= a < 0x8f3b58:
                rows.append((a, p[3].rstrip()))

    d = json.load(open('src/asm/fw/blocks.json'))
    st = sorted(d['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]

    def own(a):
        i = bisect.bisect_right(ads, a) - 1
        return st[i] if i >= 0 else None

    MOVK = re.compile(r'^_?mov(?:_s)?\s+(r\d+),\s*(0x[0-9a-f]+|\d+)$')
    LDGP = re.compile(r'^_?ld\.as\s+(r\d+),\[gp,\s*(-?0x[0-9a-f]+|-?\d+)\]$')
    CALL = re.compile(r'^_?(?:bl|b)(?:\.d)?\s+0x0*([0-9a-f]{6})$')
    gp = 0x800170

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
                regs[mm.group(1)] = dw(gp + int(mm.group(2), 0))
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
            en = strv(ev, e) or ('EVT%d' % e)
            for c in range(nst):
                cn = strv(stn, c) or ('ST%d' % c)
                idx = c + e * nst
                raw = dw(trans + idx * 5)
                h = (raw + 0x8c0000) if raw else 0
                ns = by[trans + idx * 5 + 4 - DATA_BASE + DATA_BASE - DATA_BASE] if 0 <= trans + idx * 5 + 4 - DATA_BASE < len(by) else None
                ns = by[trans + idx * 5 + 4 - DATA_BASE]
                nsn = strv(stn, ns) or ('ST%d' % ns)
                if h and 0x8c0000 <= h < 0x8f3b58:
                    b = own(h)
                    flag = '' if b and b['addr'] == h else '  (не начало блока!)'
                    out.append((h, name, cn, en, nsn, b['name'] if b else '?', flag))
                    print('   %-18s x %-26s -> %-34s next=%-18s%s'
                          % (cn, en, b['name'] if b else '?', nsn, flag))
    print('# обработчиков найдено: %d' % len(out), file=sys.stderr)

    import collections
    grp = collections.defaultdict(list)
    for h, sm, cn, en, nsn, bn, flag in out:
        grp[h].append((sm, cn, en, bn, flag))

    def norm(x):
        return re.sub(r'[^A-Za-z0-9]+', '_', x or '?').strip('_').lower()

    cands = []
    for h in sorted(grp):
        v = grp[h]
        bn, flag = v[0][3], v[0][4]
        if not bn.startswith(('sub_', 'blk_')):
            continue
        sms = {x[0] for x in v}
        evs = {x[2] for x in v}
        sts = {x[1] for x in v}
        if len(sms) != 1 or len(evs) != 1 or None in sms or None in evs:
            continue
        sm = norm(list(sms)[0])
        ev = norm(list(evs)[0])
        for pre in ('lm_evt_', 'rm_evt_', 'sm_evt_', 'evt_'):
            if ev.startswith(pre):
                ev = ev[len(pre):]
        cands.append((h, '%s__on_%s' % (sm, ev), sorted(sts), list(sms)[0], list(evs)[0], flag))

    seen = collections.Counter(c[1] for c in cands)
    print('\n#### КАНДИДАТЫ В ИМЕНА (%d)' % len(cands), file=sys.stderr)
    for h, nm, sts, sm, ev, flag in cands:
        if seen[nm] > 1:
            nm = '%s__%s' % (nm, norm(sts[0]))
        print('0x%08x  %-46s # %s: %s x %s%s'
              % (h, nm, sm, ','.join(sts)[:44], ev, flag), file=sys.stderr)


if __name__ == '__main__':
    main()
