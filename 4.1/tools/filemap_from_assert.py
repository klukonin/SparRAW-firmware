#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Карта «блок -> файл исходника» по вызовам sysassert.

`uc_sysassert` печатает __FILE__, и ссылка на строку передаётся в регистре
как (hdr<<16)|offset, где offset — смещение в таблице строк образа.
Значит для каждого вызова можно узнать, из какого файла вендора собран
вызывающий блок.  Проверено: offset 0xd80 -> «sxd_hal.c», 0x1b80 ->
«nav_db.c».

    filemap_from_assert.py > ref/FILEMAP-FROM-ASSERT.txt
"""
import bisect, collections, json, re, sys

ASSERT = 0x925548          # uc_sysassert
MOVK = re.compile(r'\bmov(?:_s)?\s+(r\d+),\s*(0x1[0-9a-f]{6})\b')
CALL = re.compile(r'\b(?:bl|jl)[a-z.]*\s+0x00([0-9a-f]{6})')


def main():
    pool = open('../blobs/fwlog-strings/ucode-4.1.0.1000.bin', 'rb').read()

    def s_at(off):
        if off >= len(pool):
            return None
        end = pool.find(b'\0', off)
        t = pool[off:end].decode('latin1', 'replace')
        return t if re.fullmatch(r'[\w.\-]+\.(c|cpp|h|hpp)', t) else None

    d = json.load(open('src/asm/uc/blocks.json'))
    st = sorted(d['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in st]

    ins = []
    for l in open('../blobs/insns/INSNS-4100.txt'):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if 0x920000 <= ad < 0x940000:
            ins.append((ad, p[3].rstrip().lstrip('_')))

    hits = collections.defaultdict(collections.Counter)
    lit, cur = {}, None
    for i, (ad, t) in enumerate(ins):
        b = st[bisect.bisect_right(ads, ad) - 1]
        if b is not cur:          # на границе блока литералы забываем
            cur, lit = b, {}
        m = MOVK.search(t)
        if m:
            lit[m.group(1)] = int(m.group(2), 16)
            continue
        m = CALL.search(t)
        if m and int(m.group(1), 16) == ASSERT:
            # имя файла идёт в r2 (проверено на 0x925076: mov_s r2,0x1000d80)
            v = lit.get('r2')
            if v is not None:
                name = s_at(v & 0xffff)
                if name:
                    j = bisect.bisect_right(ads, ad) - 1
                    hits[st[j]['name']][name] += 1

    # якоря: блок -> файл, доказано строкой __FILE__
    anchor = {}
    for blk, c in hits.items():
        anchor[blk] = c.most_common(1)[0][0]
    name2addr = {b['name']: b['addr'] for b in st}
    ax = sorted(name2addr[b] for b in anchor if b in name2addr)
    byaddr = {name2addr[b]: f for b, f in anchor.items() if b in name2addr}

    # интерполяция: если ближайшие якоря слева и справа указывают на один
    # файл, блок между ними почти наверняка из него же (код одного файла
    # линкуется подряд)
    interp = {}
    for b in st:
        if b['name'] in anchor:
            continue
        i = bisect.bisect_left(ax, b['addr'])
        if 0 < i < len(ax) and byaddr[ax[i - 1]] == byaddr[ax[i]]:
            interp[b['name']] = byaddr[ax[i]]

    print('# блок -> файл вендорского исходника')
    print('# по строке __FILE__ в sysassert: %d блоков (доказано)' % len(anchor))
    print('# интерполяцией между якорями одного файла: %d блоков (вероятно)'
          % len(interp))
    byfile = collections.defaultdict(list)
    for blk, f in anchor.items():
        byfile[f].append(blk)
    for blk, f in interp.items():
        byfile[f].append(blk + '   [интерполяция]')
    for f in sorted(byfile):
        print('\n== %s  (%d блоков)' % (f, len(byfile[f])))
        for b in sorted(byfile[f]):
            print('   %s' % b)


if __name__ == '__main__':
    main()
