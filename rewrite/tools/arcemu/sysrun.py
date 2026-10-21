#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Прогон целого .fw (fw+uc) в двухъядерном эмуляторе; сравнение трасс uc двух образов.

  sysrun.py A.fw [B.fw] [--ticks N] — печатает первые расхождения uc-трасс (mmio/extreg/sr/flag).
"""
import argparse, os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import cpu as cpumod


def boot(path, ticks):
    s = cpumod.System()
    s.mmio(0x880000, 0x8a0000)
    for host, data in cpumod.parse_fw(open(path, 'rb').read()):
        if 0x8c0000 <= host < 0x900000:
            s.fw.load(host, data, is_code=True)
        elif 0x900000 <= host < 0x920000:
            s.load_data(0x800000 + host - 0x900000, data)
        elif 0x920000 <= host < 0x940000:
            s.uc.load(host, data, is_code=True)
        elif 0x940000 <= host < 0x960000:
            s.load_data(0x800000 + host - 0x940000, data)   # uc DCCM
        else:
            s.load_data(host, data)
    s.fw.pc = s.FW_CODE
    s.uc.pc = s.UC_CODE
    err = None
    try:
        s.run(max_ticks=ticks)
    except Exception as e:
        err = '%s: %s' % (type(e).__name__, e)
    return s, err


def events(c):
    return [e for e in c.trace if e[0] in ('mmio', 'extreg', 'sr', 'flag', 'sleep') and not (e[0] == 'mmio' and e[1] == 'r')]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('fws', nargs='+')
    ap.add_argument('--ticks', type=int, default=200000)
    ap.add_argument('--show', type=int, default=25)
    a = ap.parse_args()
    runs = []
    for f in a.fws:
        s, err = boot(f, a.ticks)
        ev = events(s.uc)
        print('%s: tick=%d fw.pc=%x uc.pc=%x uc.halted=%s fw.halted=%s err=%s uc-events=%d'
              % (os.path.basename(f), s.tick, s.fw.pc, s.uc.pc, s.uc.halted, s.fw.halted, err, len(ev)))
        runs.append(ev)
    if len(runs) == 2:
        A, B = runs
        i = next((k for k in range(min(len(A), len(B))) if A[k] != B[k]), min(len(A), len(B)))
        print('первое расхождение uc-событий на #%d' % i)
        for k in range(max(0, i - 5), i + a.show):
            print('%5d  %-50s %s' % (k, A[k] if k < len(A) else '-', B[k] if k < len(B) else '-'))
    else:
        for e in runs[0][:a.show]:
            print(e)


if __name__ == '__main__':
    main()
