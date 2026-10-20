#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Собирает по каждому блоку улики, нужные при переписывании его на C++.

Всё берётся из дизассемблированного образа, без Ghidra:
  * кого блок зовёт и кто зовёт его — по целям bl/b, попавшим в другие блоки;
  * какие строки он печатает — по константам вида 0x01xxxxxx, где младшие
    20 бит суть смещение в таблице строк образа;
  * к каким регистрам и глобалам обращается — по константам 0x88xxxx и
    по обращениям через gp.
"""
import argparse
import collections
import json
import re

CALL = re.compile(r'\b(?:bl|b|j|jl)[a-z.]*\s+(?:.*,)?0x00([0-9a-f]{6})\b')
# ссылка на строку: бит 24 взведён, младшие 20 бит — смещение
CONST = re.compile(r'0x([0-9a-f]{6,8})\b')
RGF = re.compile(r'0x00(88[0-9a-f]{4})\b')
GP = re.compile(r'\[gp,(-?\d+|0x[0-9a-f]+)\]')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--strings', help='таблица строк образа (запись типа 101)')
    ap.add_argument('--gp', required=True,
                    help='значение gp этого сегмента: fw 0x800184, ucode 0x800528')
    ap.add_argument('--out', required=True)
    a = ap.parse_args()

    m = json.load(open(a.blocks))
    base, end = m['base'], m['end']
    starts = sorted(b['addr'] for b in m['blocks'])
    name = {b['addr']: b['name'] for b in m['blocks']}

    def owner(ad):
        lo, hi = 0, len(starts)
        while lo < hi:
            mid = (lo + hi) // 2
            if starts[mid] <= ad:
                lo = mid + 1
            else:
                hi = mid
        return starts[lo - 1] if lo else None

    gp = int(a.gp, 16)
    strings = open(a.strings, 'rb').read() if a.strings else b''

    def sref(off):
        if off >= len(strings):
            return None
        if off and strings[off - 1] != 0:
            return None          # ссылка обязана быть на начало строки
        e = strings.find(b'\0', off)
        s = strings[off:e if e > 0 else len(strings)]
        try:
            return s.decode('ascii')
        except UnicodeDecodeError:
            return None

    calls = collections.defaultdict(set)
    strs = collections.defaultdict(list)
    rgfs = collections.defaultdict(set)
    gps = collections.defaultdict(set)
    for l in open(a.insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if not base <= ad < end:
            continue
        txt = p[3]
        o = owner(ad)
        for mm in CALL.finditer(txt):
            t = int(mm.group(1), 16)
            if base <= t < end:
                to = owner(t)
                if to is not None and to != o:
                    calls[o].add(to)
        for mm in CONST.finditer(txt):
            v = int(mm.group(1), 16)
            if (v >> 24) & 0x3 == 0 or (v >> 26):
                continue
            s = sref(v & 0xfffff)
            if s and len(s) > 3:
                strs[o].append(s)
        for mm in RGF.finditer(txt):
            rgfs[o].add(int(mm.group(1), 16))
        for mm in GP.finditer(txt):
            # gp — настоящий глобальный указатель, и он постоянен: смещение
            # в инструкции сразу превращается в адрес переменной
            gps[o].add(gp + int(mm.group(1), 0))

    callers = collections.defaultdict(set)
    for f, ts in calls.items():
        for t in ts:
            callers[t].add(f)

    out = {}
    for b in m['blocks']:
        ad = b['addr']
        e = {}
        if calls.get(ad):
            e['calls'] = sorted(name[x] for x in calls[ad])
        if callers.get(ad):
            e['callers'] = sorted(name[x] for x in callers[ad])
        if strs.get(ad):
            seen, uniq = set(), []
            for s in strs[ad]:
                if s not in seen:
                    seen.add(s)
                    uniq.append(s)
            e['strings'] = uniq
        if rgfs.get(ad):
            e['rgf'] = ['0x%06x' % x for x in sorted(rgfs[ad])]
        if gps.get(ad):
            e['globals'] = ['0x%06x' % x for x in sorted(gps[ad])]
        if e:
            out[b['name']] = e
    json.dump(out, open(a.out, 'w'), ensure_ascii=False, indent=0)
    print('%s: улики собраны для %d блоков из %d -> %s'
          % (m['region'], len(out), len(m['blocks']), a.out))


if __name__ == '__main__':
    main()
