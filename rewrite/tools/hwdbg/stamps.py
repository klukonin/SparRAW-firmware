#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Метки UC_STAMP (uc/dbg.h) из снимка blob_uc_data: записи журнала uc с токеном 0xfff00|id.

usage: stamps.py <uc_data.bin> [--pairs A:B ...]
Печатает метки в порядке записи: id, такты COUNT1 (Timer1, 165 МГц), разность с предыдущей
меткой, a0, a1. --pairs A:B — для каждой метки B разность с ближайшей предшествующей меткой A
(такты и мкс), итог: min/медиана/max."""
import struct, sys, statistics

LOG = 0x3234            # uc_log (uc 0x803234) — смещение в blob_uc_data
RING = LOG + 0x14       # 256 слов
PERIOD = 0x13ab6680     # предел Timer1 (такты), счётчик переполняется по нему


def stamps(blob):
    wr = struct.unpack_from('<I', blob, LOG)[0]
    ring = struct.unpack_from('<256I', blob, RING)
    out = []
    # обход в хронологическом порядке: от wr_idx по кругу
    for k in range(256):
        i = (wr + k) & 0xff
        h = ring[i]
        if (h & 0xfff00000) == 0xa8000000 and (h & 0xfff00) == 0xfff00:
            out.append((h & 0xff, ring[(i + 1) & 0xff], ring[(i + 2) & 0xff], ring[(i + 3) & 0xff]))
    return out


def dcyc(a, b):
    return (b - a) % PERIOD


def main():
    a = sys.argv[1:]
    if not a:
        print(__doc__)
        return
    st = stamps(open(a[0], 'rb').read())
    pairs = [tuple(int(x, 0) for x in p.split(':')) for p in a[a.index('--pairs') + 1:]] if '--pairs' in a else []
    prev = None
    for sid, t, a0, a1 in st:
        d = '' if prev is None else '%+8d' % dcyc(prev, t)
        print('id=%-3d t=%10d %s a0=0x%08x a1=0x%08x' % (sid, t, d, a0, a1))
        prev = t
    for pa, pb in pairs:
        last, ds = None, []
        for sid, t, _, _ in st:
            if sid == pa:
                last = t
            elif sid == pb and last is not None:
                ds.append(dcyc(last, t))
                last = None
        if ds:
            print('%d->%d: n=%d min=%d med=%d max=%d тактов (%.2f / %.2f / %.2f мкс)' % (
                pa, pb, len(ds), min(ds), statistics.median(ds), max(ds),
                min(ds) / 165, statistics.median(ds) / 165, max(ds) / 165))


if __name__ == '__main__':
    main()
