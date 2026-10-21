#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Аудит gp-относительной адресации: адреса DCCM 0x8004xx..0x8007xx, к которым vendor-функция
обращается через [gp,N] (с масштабом .as), против констант в C-теле функции.
Печатает функции, где есть vendor-адреса, отсутствующие в C, и C-адреса из «gp-окна»,
которых нет у vendor (типичная ошибка масштаба ×1/×2/×4)."""
import os, re, subprocess, sys, importlib.util
HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location('uh', os.path.join(os.path.dirname(HERE), 'uc_hybrid.py'))
uh = importlib.util.module_from_spec(spec); spec.loader.exec_module(uh)
GP = 0x800528
LO, HI = 0x800400, 0x800800


def vendor_gp(vb):
    d = subprocess.run([uh.OD, '-d', '--start-address=%d' % vb['addr'], '--stop-address=%d' % (vb['addr'] + vb['size']),
                        uh.VELF], capture_output=True, text=True).stdout
    out = set()
    for line in d.splitlines():
        parts = line.split('\t')
        if len(parts) < 4:
            continue
        mn, ops = parts[2].strip(), parts[3]
        m = re.search(r'\[gp,(-?\d+)\]', ops)
        if m:
            off = int(m.group(1))
            if '.as' in mn:
                off *= 2 if re.match(r'(ldh|ldw|sth|stw)', mn) else 4
            out.add(GP + off)
        m = re.match(r'r\d+,gp,(\d+)', ops)
        if mn.startswith('add') and m:
            out.add(GP + int(m.group(1)))
    return out


def vendor_lit(vb):
    """Абсолютные константы 0x8004xx..0x8007xx в коде функции (mov/ld/st [0x80....])."""
    d = subprocess.run([uh.OD, '-d', '--start-address=%d' % vb['addr'], '--stop-address=%d' % (vb['addr'] + vb['size']),
                        uh.VELF], capture_output=True, text=True).stdout
    return {int(x, 16) for x in re.findall(r'0x(800[4-7][0-9a-f]{2})\b', d)}


def c_body(fn, f):
    L = open(os.path.join(uh.UCDIR, f)).read().split('\n')
    for i, l in enumerate(L):
        if re.match(r'^(?:static\s+)?\w[\w\s\*]*\b%s\s*\(' % re.escape(fn), l) and not l.rstrip().endswith(';'):
            out = []
            for k in range(i, len(L)):
                out.append(L[k])
                if k > i and L[k].startswith('}'):
                    break
            return '\n'.join(out)
    return ''


def main():
    cm = uh.c_map()
    only = set(sys.argv[1:])
    for fn, (vb, f) in sorted(cm.items()):
        if not vb or not f.endswith('.c') or (only and fn not in only):
            continue
        body = c_body(fn, f)
        body = re.sub(r'/\*.*?\*/', '', body, flags=re.S)
        cv = {int(x, 16) for x in re.findall(r'0x(800[4-7][0-9a-f]{2})\b', body)}
        # учесть 0x800528 + N / - N
        for m in re.finditer(r'0x800528\s*([+-])\s*(0x[0-9a-f]+|\d+)(?:\s*\*\s*(\d+))?', body):
            v = int(m.group(2), 0) * (int(m.group(3)) if m.group(3) else 1)
            cv.add(GP + v if m.group(1) == '+' else GP - v)
        vv = {a for a in vendor_gp(vb) if LO <= a < HI}
        cv = {a for a in cv if LO <= a < HI}
        vl = vendor_lit(vb)
        miss = sorted(a for a in vv if not any(abs(a - c) < 4 and (a & ~3) == (c & ~3) for c in cv))
        extra = sorted(a for a in cv if not any((a & ~3) == (v & ~3) for v in vv)
                       and not any(0 <= a - v < 0x40 for v in vl))
        if miss and extra:
            print('%-44s vendor-нет-в-C: %s   C-нет-у-vendor: %s' % (fn, ' '.join('%x' % a for a in miss),
                                                                 ' '.join('%x' % a for a in extra)))


if __name__ == '__main__':
    main()
