#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Автоматы basic_sm в 6.2: описатели, таблицы переходов, имена действий.

Устройство отличается от 4.1, где `basic_sm__setup` писал все таблицы
прямо в объект. В 6.2 setup — это `0x8d94e0`, шестнадцать байт:

    ldb_s r2,[r1,0x2]   ; init_state из ОПИСАТЕЛЯ (r1)
    st_s  r1,[r0,0x4]   ; obj->desc = описатель
    stb_s r2,[r0]       ; obj->state = init_state
    stb_s 0xff,[r0,0x2] ; предыдущее состояние — «нет»
    stb_s 0,[r0,0x3]

Описатель — 20 байт в fw_data:

    +0  байт  число СОБЫТИЙ
    +1  байт  число СОСТОЯНИЙ   (порядок именно такой: проверено на
                                 mlme_sm — 14 событий и 3 состояния
                                 UNASSOCIATE/ASSOCIATE/ASSOCIATED; при
                                 обратном чтении имена состояний
                                 продолжаются именами событий, и это
                                 единственный внешний признак ошибки)
    +2  байт  начальное состояние
    +4  адрес таблицы переходов (обычно сразу за описателем)
    +8  адрес массива указателей на имена состояний
    +12 адрес массива указателей на имена событий

Таблица переходов — запись 5 байт, как и в 4.1: первые четыре байта —
смещение обработчика от 0x8c0000, пятый — следующее состояние. Индекс
ячейки = состояние + событие * число_состояний.

Имена состояний и событий лежат в таблице строк образа, поэтому имя
действия подтверждено самой прошивкой: `ps_sm__on_ps_enable_in_ps_disabled`
читается ровно так, как ячейка и стоит в таблице.
"""
import argparse, bisect, collections, json, re, struct


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--fw-data', required=True)
    ap.add_argument('--strings', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--setup', default='0x8d94e0')
    ap.add_argument('--data-base', default='0x800000')
    ap.add_argument('--code-base', default='0x8c0000')
    ap.add_argument('--names', help='дописать имена действий сюда')
    a = ap.parse_args()
    dbase, cbase = int(a.data_base, 16), int(a.code_base, 16)

    data = open(a.fw_data, 'rb').read()
    sd = open(a.strings, 'rb').read()
    blocks = sorted(json.load(open(a.blocks))['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in blocks]
    starts = set(ads)

    def dw(x):
        o = x - dbase
        return struct.unpack_from('<I', data, o)[0] if 0 <= o <= len(data) - 4 else None

    def byte(x):
        o = x - dbase
        return data[o] if 0 <= o < len(data) else None

    def text(x):
        o = x - 0x1000000
        if 0 <= o < len(sd):
            return sd[o:o + 64].split(b'\0')[0].decode('ascii', 'replace')
        o = x - dbase
        if 0 <= o < len(data):
            return data[o:o + 64].split(b'\0')[0].decode('ascii', 'replace')
        return None

    # где setup вызывают и с каким описателем
    rows = []
    for l in open(a.insns):
        if l.startswith('I '):
            p = l.split(None, 3)
            rows.append((int(p[1], 16), p[3].rstrip()))
    MOV = re.compile(r'^_?mov(?:_s)?\s+(r\d+),\s*(0x[0-9a-f]+)$')
    descs = []
    for i, (ad, t) in enumerate(rows):
        if a.setup.replace('0x', '0x00') not in t and a.setup not in t:
            continue
        const = {}
        for j in range(max(0, i - 10), i + 2):
            m = MOV.match(rows[j][1])
            if m:
                const[m.group(1)] = int(m.group(2), 16)
        if 'r1' in const:
            descs.append((const['r1'], ad))

    def ident(s):
        return re.sub(r'[^a-z0-9_]', '_', s.lower()).strip('_')

    # Первый проход: у каких автоматов какие обработчики. Нужен, чтобы
    # отделить ОБЩИЕ обработчики (пустая заглушка, общий «неожиданное
    # событие») от собственных. Без этого голосование за имя автомата
    # выигрывает общая заглушка, и тринадцать разных автоматов получают
    # одно и то же имя — проверено, именно так и вышло.
    owners = collections.defaultdict(set)
    parsed = []
    for desc, site in sorted(set(descs)):
        ne, ns = byte(desc), byte(desc + 1)
        trans = dw(desc + 4)
        if not ns or not ne or not trans:
            continue
        hs = set()
        for ev in range(ne):
            for stt in range(ns):
                off = trans - dbase + (stt + ev * ns) * 5
                if off + 5 <= len(data):
                    hs.add(cbase + int.from_bytes(data[off:off + 4], 'little'))
        for h in hs:
            owners[h].add(desc)
        parsed.append(desc)
    shared = {h for h, ds in owners.items() if len(ds) > 1}

    # имя автомата: считаем для всех, затем отбрасываем неуникальные —
    # одно имя на два разных автомата означает, что голосование ошиблось
    smname = {}
    for desc in parsed:
        ne, ns = byte(desc), byte(desc + 1)
        trans, snames = dw(desc + 4), dw(desc + 8)
        states = [text(dw(snames + 4 * i)) or '?' for i in range(ns)] if snames else []
        pref = ''
        if states and all(x and '_' in x for x in states):
            parts = [x.split('_')[0] for x in states]
            if len(set(parts)) == 1:
                pref = parts[0].lower()
        nm = ident(pref + '_sm') if pref else ''
        if not nm:
            cand = collections.Counter()
            for ev in range(ne):
                for stt in range(ns):
                    off = trans - dbase + (stt + ev * ns) * 5
                    if off + 5 > len(data):
                        continue
                    h = cbase + int.from_bytes(data[off:off + 4], 'little')
                    if h in shared:
                        continue
                    i = bisect.bisect_right(ads, h) - 1
                    if i < 0:
                        continue
                    b = blocks[i]['name']
                    if '__' in b and b.split('__')[0].endswith('_sm'):
                        cand[b.split('__')[0]] += 1
            nm = cand.most_common(1)[0][0] if cand else ''
        smname[desc] = nm
    dupes = {n for n in smname.values() if n and
             list(smname.values()).count(n) > 1}
    for desc in parsed:
        if not smname[desc]:
            smname[desc] = 'sm_%06x' % desc
        elif smname[desc] in dupes:
            # имя выведено верно, но таких автоматов в образе несколько
            # (например два разных PS): различаем адресом описателя
            smname[desc] = '%s_%06x' % (smname[desc], desc)

    named, report = [], []
    for desc, site in sorted(set(descs)):
        ne, ns = byte(desc), byte(desc + 1)
        init = byte(desc + 2)
        trans, snames, enames = dw(desc + 4), dw(desc + 8), dw(desc + 12)
        if not ns or not ne or not trans:
            continue
        states = [text(dw(snames + 4 * i)) or '?' for i in range(ns)] if snames else []
        events = [text(dw(enames + 4 * i)) or '?' for i in range(ne)] if enames else []
        sm = smname.get(desc, 'sm_%06x' % desc)
        report.append('== %s (описатель 0x%06x, %d состояний x %d событий, '
                      'старт %s, настроен из %06x)'
                      % (sm, desc, ns, ne, states[init] if init is not None and
                         init < len(states) else init, site))
        cells = collections.defaultdict(list)
        for ev in range(ne):
            for stt in range(ns):
                off = trans - dbase + (stt + ev * ns) * 5
                if off + 5 > len(data):
                    continue
                v = int.from_bytes(data[off:off + 4], 'little')
                nxt = data[off + 4]
                h = cbase + v
                cells[h].append((ev, stt, nxt))
        for h, cc in sorted(cells.items()):
            i = bisect.bisect_right(ads, h) - 1
            owner = blocks[i]['name'] if i >= 0 else '?'
            mark = '' if h in starts else '  (внутри %s)' % owner
            ev0, st0, nxt = cc[0]
            report.append('   %06x%s  %s' % (h, mark, '; '.join(
                '%s в %s -> %s' % (events[e] if e < len(events) else e,
                                   states[s] if s < len(states) else s,
                                   states[n] if n < len(states) else n)
                for e, s, n in cc[:3])))
            if h in shared:
                continue          # общий на несколько автоматов — не его имя
            if h in starts and owner.startswith(('sub_', 'blk_')) and len(cc) == 1:
                nm = '%s__on_%s_in_%s' % (sm, ident(events[ev0]) if ev0 < len(events)
                                          else ev0, ident(states[st0]) if st0 < len(states) else st0)
                named.append((h, nm, sm))
            elif h not in starts:
                named.append((h, '%s__action_%06x' % (sm, h), sm))

    print('\n'.join(report))
    if a.names and named:
        used, out = set(), []
        for h, nm, sm in sorted(named):
            if nm in used:
                nm = '%s_%06x' % (nm, h)
            used.add(nm)
            out.append((h, nm))
        with open(a.names, 'a') as f:
            f.write('\n# --- действия автоматов basic_sm: ячейка таблицы '
                    'переходов, имена события и состояния взяты из таблицы '
                    'строк образа (sm_tables.py) ---\n')
            for h, nm in out:
                f.write('0x%08x %s # ячейка таблицы переходов автомата\n' % (h, nm))
        print('\nдописано имён действий: %d' % len(out))
    print('\nавтоматов разобрано: %d' % len(set(d for d, _ in descs)))


if __name__ == '__main__':
    main()
