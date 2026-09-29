#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""События ucode -> прошивка: тип -> имя из строки "Ucode->..." -> обработчик.

Диспетчер (fw_code 0x8df07c в 6.2) устроен как и командный в ucode:

    ldw_s r1,[r15,0x4]              ; тип события
    cmp_s r1,0x30
    ldw.x.as r1,[0x801f40,r1]       ; таблица полуслов
    add   r0,pcl,0x8 ; add1_s ; j_s r0

Каждая ветка сперва печатает строку вида "Ucode->EVENT_ECHO : type ..."
через fw_log_emit*, и уже следующий вызов — настоящий обработчик. Имя
берётся из строки, то есть подтверждено самой прошивкой, а не догадкой.

Данные fw линкуются с базой 0x800000 (грузятся по AHB 0x900000).
"""
import argparse, bisect, json, re

CALL = re.compile(r'^_?(?:bl|jl)(?:\.d)?\s+0x0*([0-9a-f]{6})$')
MOVS = re.compile(r'^_?mov(?:_s)?\s+r\d+,\s*(0x1[0-9a-f]{6})$')
LOGGERS = {0x8dcba8, 0x8dcc10, 0x8dcc80, 0x8dcd00}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--fw-data', required=True)
    ap.add_argument('--strings', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--insns', required=True)
    ap.add_argument('--table', default='0x801f40')
    ap.add_argument('--branch-base', default='0x8df0bc')
    ap.add_argument('--max-type', default='0x30')
    ap.add_argument('--data-linker-base', default='0x800000')
    ap.add_argument('--names')
    a = ap.parse_args()

    data = open(a.fw_data, 'rb').read()
    sd = open(a.strings, 'rb').read()
    off = int(a.table, 16) - int(a.data_linker_base, 16)
    base = int(a.branch_base, 16)

    order, ins = [], {}
    for l in open(a.insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        ins[ad] = (int(p[2]), p[3].rstrip())
        order.append(ad)
    order.sort()

    blocks = sorted(json.load(open(a.blocks))['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in blocks]

    def owner(x):
        i = bisect.bisect_right(ads, x) - 1
        return blocks[i] if i >= 0 else None

    def sget(v):
        o = v - 0x1000000
        if 0 <= o < len(sd):
            return sd[o:o + 120].split(b'\0')[0].decode('ascii', 'replace')
        return None

    rows, seen = [], {}
    for ty in range(int(a.max_type, 16) + 1):
        v = int.from_bytes(data[off + ty * 2:off + ty * 2 + 2], 'little')
        br = base + v * 2
        name, handler, ad = None, None, br
        for _ in range(14):
            if ad not in ins:
                break
            ln, t = ins[ad]
            m = MOVS.match(t)
            if m and name is None:
                s = sget(int(m.group(1), 16))
                if s and 'Ucode->' in s:
                    name = s.split('Ucode->', 1)[1].split(':')[0].strip()
            m = CALL.match(t)
            if m:
                h = int(m.group(1), 16)
                if h not in LOGGERS:
                    handler = h
                    break
            if t.startswith(('b ', 'b_s ', 'b.d ')) and name:
                break
            ad += ln
        rows.append((ty, v, br, name, handler))
        seen.setdefault(br, []).append(ty)

    shared = {br for br, ts in seen.items() if len(ts) > 1}
    named = []
    print('таблица %s, ветки от %s, типов 0..%s'
          % (a.table, a.branch_base, a.max_type))
    for ty, v, br, name, h in rows:
        b = owner(h) if h else None
        print('  0x%02x ветка %06x  %-26s -> %s'
              % (ty, br, name or '—', b['name'] if b else '—'))
        if h and b and b['addr'] == h and b['name'].startswith('sub_') \
           and name and br not in shared:
            nm = re.sub(r'[^a-z0-9_]', '_', name.lower())
            named.append((h, nm, name))

    if a.names and named:
        used, out = set(), []
        for h, nm, raw in sorted(named):
            if nm in used or h in {x[0] for x in out}:
                continue
            used.add(nm)
            out.append((h, nm, raw))
        with open(a.names, 'a') as f:
            f.write('\n# --- обработчики событий ucode->fw: имя из строки '
                    '"Ucode->…", печатаемой веткой диспетчера '
                    '(uc_evt_table.py) ---\n')
            for h, nm, raw in out:
                f.write('0x%08x %s # строка ветки: Ucode->%s\n' % (h, nm, raw))
        print('\nдописано имён: %d -> %s' % (len(out), a.names))


if __name__ == '__main__':
    main()
