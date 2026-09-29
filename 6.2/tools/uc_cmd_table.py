#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Таблица команд ucode 6.2: код -> заглушка -> обработчик.

Диспетчер (fw_code вызывает его через кольцо команд MAC) устроен так:

    cmp_s r1,0x4a                   ; верхняя граница кода команды
    bhi   <выход>
    ldw.x.as r1,[0x8019dc,r1]       ; ПОЛУСЛОВНАЯ таблица смещений
    add   r0,pcl,0xa                ; база заглушек
    add1_s r0,r0,r1                 ; база + значение*2
    j_s   r0

В 4.1 таблица была БАЙТОВОЙ и лежала по 0x800c68 — при переносе
инструмента это первое, что надо перепроверить: ширина элемента задаётся
мнемоникой (`ldb` против `ldw.x.as`), а не соглашением.

Адрес таблицы линкерный. Данные ucode линкуются с базой 0x800000 и
грузятся по AHB 0x940000, так что смещение в файле = линкерный - 0x800000.
(Сводка `wil_syms segments` показывает для этой записи linker 0x40000 —
это АДРЕС ЗАПИСИ В КОНТЕЙНЕРЕ, а не база, с которой собран ucode. Взяв
её, таблица читается из нулей и карта выходит пустой.)
"""
import argparse, bisect, json


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--uc-data', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--insns', required=True)
    ap.add_argument('--table', default='0x8019dc')
    ap.add_argument('--stub-base', default='0x93c966')
    ap.add_argument('--max-cmd', default='0x4a')
    ap.add_argument('--data-linker-base', default='0x800000')
    ap.add_argument('--names', help='дописать имена обработчиков сюда')
    a = ap.parse_args()

    data = open(a.uc_data, 'rb').read()
    off = int(a.table, 16) - int(a.data_linker_base, 16)
    base = int(a.stub_base, 16)
    nmax = int(a.max_cmd, 16)

    ins = {}
    for l in open(a.insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ins[int(p[1], 16)] = (int(p[2]), p[3].rstrip())

    blocks = sorted(json.load(open(a.blocks))['blocks'], key=lambda b: b['addr'])
    ads = [b['addr'] for b in blocks]

    def owner(x):
        i = bisect.bisect_right(ads, x) - 1
        return blocks[i] if i >= 0 else None

    # заглушка: первый bl/bl.d в ней и есть обработчик
    rows, targets = [], {}
    for cmd in range(nmax + 1):
        v = int.from_bytes(data[off + cmd * 2:off + cmd * 2 + 2], 'little')
        stub = base + v * 2
        h = None
        ad = stub
        for _ in range(6):
            if ad not in ins:
                break
            ln, t = ins[ad]
            if t.startswith(('bl ', 'bl.d ')) and '0x' in t:
                h = int(t.split('0x')[-1], 16)
                break
            if t.startswith(('b ', 'b_s ', 'b.d ')):
                break
            ad += ln
        rows.append((cmd, v, stub, h))
        if h is not None:
            targets.setdefault(h, []).append(cmd)

    shared = {h for h, cs in targets.items() if len(cs) > 1}
    print('таблица 0x%s, заглушки от 0x%06x, команд 0..0x%02x'
          % (a.table[2:], base, nmax))
    named = []
    for cmd, v, stub, h in rows:
        b = owner(h) if h else None
        nm = b['name'] if b else '—'
        mark = ''
        if h and b and b['addr'] != h:
            mark = ' (не начало блока)'
        print('  0x%02x -> слот %5d  заглушка %06x  обработчик %s%s'
              % (cmd, v, stub, nm, mark))
        if h and b and b['addr'] == h and nm.startswith('sub_') \
           and h not in shared:
            named.append((h, 'ucode_cmd_0x%02x_handler' % cmd, cmd))

    uniq = {h for h, _, _ in named}
    print('\nразных обработчиков %d, из них безымянных и однозначных %d'
          % (len(targets), len(uniq)))
    if a.names and named:
        seen = set()
        with open(a.names, 'a') as f:
            f.write('\n# --- обработчики команд ucode по таблице 0x%s '
                    '(uc_cmd_table.py) ---\n' % a.table[2:])
            for h, nm, cmd in sorted(named):
                if h in seen:
                    continue
                seen.add(h)
                # адрес таблицы в комментарий НЕ ставим: ревизия
                # audit_names.py требует, чтобы адрес из комментария
                # подтверждался телом блока, а таблицу читает диспетчер,
                # а не обработчик — выходили бы 42 ложных замечания
                f.write('0x%08x %s # заглушка %d таблицы диспетчера команд\n'
                        % (h, nm, cmd))
        print('дописано имён: %d -> %s' % (len(seen), a.names))


if __name__ == '__main__':
    main()
