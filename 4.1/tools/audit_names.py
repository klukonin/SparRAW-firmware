#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Ревизия честности имён. Дополняет coverage.py.

coverage.py отвечает на вопрос «остались ли блоки без имени». Этого мало:
имя бывает и есть, и при этом лживо. Ревизия 2026-09-24 нашла 137 таких
блоков при показателе покрытия 100 %. Эта утилита ищет их все:

  * имя по лог-строке (fwlog_/uclog_/live_) — это не имя функции,
    а строка, которую она печатает; у десятка разных функций она одна;
  * аксессорное имя (get_g_/set_reg_/rw_g_/...) на блоке, где есть вызовы,
    циклы или таблица переходов, — значит это функция, а не аксессор;
  * <подсистема>_helper — конвенция проекта такие имена запрещает;
  * переходник, названный по цели, которую с тех пор переименовали;
  * stub_ret_ и epi_, переставшие соответствовать своей форме;
  * адрес данных, названный в комментарии, которого нет ни в образе, ни как
    известная база плюс смещение — так прожил незамеченным выдуманный
    0x8484dc (промах из-за sub3: это a - b*8, а не a - b).
"""
import json, re, subprocess, sys
from collections import Counter

TC = '../toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install/bin/arc-elf32-objdump'
ACC = ('get_g_', 'set_g_', 'rw_g_', 'get_reg', 'set_reg', 'get_mem_', 'set_mem_')
DEAD = r'(fwlog_|uclog_|live_|sub_|blk_|tail_tail)'


def main():
    bad = []
    for seg in ('fw', 'uc'):
        m = json.load(open('src/asm/%s/blocks.json' % seg))
        out = subprocess.run([TC, '-d', '--start-address=0x%x' % m['base'],
                              '--stop-address=0x%x' % m['end'],
                              'build/%s.elf' % seg], capture_output=True, text=True).stdout
        ins = {}
        for l in out.splitlines():
            mm = re.match(r'^\s+([0-9a-f]+):\s+((?:[0-9a-f]{4} )+)\s*(.*)$', l)
            if mm:
                t = re.sub(r'\s*<[^>]*>', '', mm.group(3))
                ins[int(mm.group(1), 16)] = (len(mm.group(2).split()) * 2,
                                             re.sub(r'\s+', ' ', t).strip())
        for x in m['blocks']:
            n, body, p = x['name'], [], x['addr']
            while p < x['addr'] + x['size']:
                sz, t = ins.get(p, (2, '?')); body.append(t); p += sz
            core = [t for t in body if not t.startswith('nop')]

            if n.startswith(('sub_', 'blk_', 'FUN_')):
                bad.append(('без имени', seg, x['addr'], n))
            if n.startswith(('fwlog_', 'uclog_', 'live_')):
                bad.append(('имя по лог-строке', seg, x['addr'], n))
            if '_helper' in n:
                bad.append(('запрещённый _helper', seg, x['addr'], n))
            if n.startswith(('tail_', 'epi_', 'frag_')) and re.search(DEAD, n):
                bad.append(('переходник в мёртвое имя', seg, x['addr'], n))
            if n.startswith(ACC):
                hard = [t for t in core
                        if re.match(r'^(bl|jl|lp|lpcc|lphi)', t) or 'pcl' in t]
                if hard or x['size'] > 28:
                    bad.append(('аксессорное имя на функции', seg, x['addr'], n))
            if n.startswith('stub_ret_') and not all(
                    re.match(r'^j(_s)?(\.d)? \[blink\]$', t) or
                    re.match(r'^mov(_s)? r0,', t) for t in core):
                bad.append(('stub_ret_ не пустой', seg, x['addr'], n))

    # Адрес данных, названный в комментарии, должен подтверждаться ТЕЛОМ
    # СВОЕГО блока: встречаться там литералом либо раскладываться как
    # «литерал из того же блока + смещение». Проверка по всему образу
    # бесполезна — почти любой адрес окажется рядом с каким-нибудь чужим.
    # Разобранные вручную исключения: адрес упомянут законно, но держит его
    # не сам блок. Список короткий намеренно — он для доказанных случаев,
    # а не для того, чтобы глушить проверку.
    OK_BY_HAND = {
        (0x8c4d20, 0x8045a4),   # таблицу колец держит вызываемый pring__by_index
        (0x8e3604, 0x882680),   # регистр держит pcie__set_event_bit через два переходника
        (0x8e4758, 0x882680),   # то же
        (0x92b908, 0x886e0c),   # регистр пишет ВЫЗЫВАЮЩИЙ mac__program_886e0c_20b
        (0x920140, 0x800000),   # вектор сброса описывает раскладку памяти, а не обращения
        (0x920140, 0x800528),
        (0x920140, 0x8028b0),
    }
    ent, cur = {}, None
    for l in open('ref/NAMES-EXTRA.txt'):
        m = re.match(r'^(0x[0-9a-fA-F]{8})\s+(\S+)\s*(?:#\s*(.*))?$', l.rstrip())
        if m:
            cur = int(m.group(1), 16); ent[cur] = [m.group(2), m.group(3) or '']
        elif cur is not None and l.startswith((' ', chr(9))) and '#' in l:
            ent[cur][1] += ' ' + l.split('#', 1)[1].strip()
        elif not l.strip() or l.lstrip().startswith('#'):
            cur = None
    for seg in ('fw', 'uc'):
        m = json.load(open('src/asm/%s/blocks.json' % seg))
        gp = 0x800184 if seg == 'fw' else 0x800528
        out = subprocess.run([TC, '-d', '--start-address=0x%x' % m['base'],
                              '--stop-address=0x%x' % m['end'],
                              'build/%s.elf' % seg], capture_output=True, text=True).stdout
        ins = {}
        for l in out.splitlines():
            mm = re.match(r'^\s+([0-9a-f]+):\s+((?:[0-9a-f]{4} )+)\s*(.*)$', l)
            if mm:
                t = re.sub(r'\s*<[^>]*>', '', mm.group(3))
                ins[int(mm.group(1), 16)] = (len(mm.group(2).split()) * 2,
                                             re.sub(r'\s+', ' ', t).strip())
        for x in m['blocks']:
            ad = x['addr']
            if ad not in ent:
                continue
            body, p = [], ad
            while p < ad + x['size']:
                sz, t = ins.get(p, (2, '?')); body.append(t); p += sz
            text = ' ; '.join(body)
            ok = {int(h, 16) for h in re.findall(r'0x(8[0-9a-f]{5})', text)}
            # база, собранная сдвигом: mov rX,0x11 ; asl rX,rX,0x13 = 0x880000
            for mm in re.finditer(r'mov(?:_s)? (r\d+),(0x[0-9a-f]+|\d+)', text):
                k = int(mm.group(2), 0)
                for sh in re.findall(r'asl(?:_s)? %s,%s,(0x[0-9a-f]+|\d+)'
                                     % (mm.group(1), mm.group(1)), text):
                    v = k << int(sh, 0)
                    if 0x800000 <= v < 0x890000:
                        ok.add(v)
            # objdump печатает СЫРОЕ поле [gp,N]: эффективный адрес gp + N*4
            for mm in re.finditer(r'(ld|st)[a-z_.]*\s+\S+,\[gp,\s*(-?\w+)\]', text):
                n = int(mm.group(2), 0)
                ok.add(gp + n * 4); ok.add(gp + n)
            # адреса из ТЕЛ прямых вызываемых: помощник часто и есть тот,
            # кто держит литерал регистра (mac_read_tsf64 -> 0x886ebc)
            an = json.load(open('ref/ANNO-%s.json' % seg))
            by_name = {b['name']: b for b in m['blocks']}
            for c in an.get(x['name'], {}).get('calls', []):
                cb = by_name.get(c)
                if not cb:
                    continue
                q, ct = cb['addr'], []
                while q < cb['addr'] + cb['size']:
                    sz, t = ins.get(q, (2, '')); ct.append(t); q += sz
                for h in re.findall(r'0x(8[0-9a-f]{5})', ' ; '.join(ct)):
                    ok.add(int(h, 16))
            bases = set(ok)
            for bb in bases:
                for off in range(-0x400, 0x401):
                    ok.add(bb + off)
            # имена вызываемых, и вызываемых у них: адрес регистра часто
            # зашит в имя помощника на уровень-два глубже
            deep = set(an.get(x['name'], {}).get('calls', []))
            for c in list(deep):
                deep |= set(an.get(c, {}).get('calls', []))
            calls = ' '.join(deep)
            for h in re.findall(r'(8[0-9a-f]{5})', calls):
                v = int(h, 16)
                for off in range(-0x400, 0x400, 2):
                    ok.add(v + off)
            # Адреса берём И ИЗ КОММЕНТАРИЯ, И ИЗ САМОГО ИМЕНИ. Раньше
            # смотрели только комментарий — и целый класс лжи проходил
            # мимо: имя `get_g_8035f2`, перенесённое с 4.1, обещало
            # адрес, которого в теле 6.2 нет, а комментарий при этом был
            # безобидным («то же тело, что 0x… в 4.1»).
            nm_for_addr = ent[ad][0] or ''
            # У переходника имя описывает ЦЕЛЬ (`tail_get_reg_880254`), и
            # адрес принадлежит ей, а не телу самого перехода. Тело
            # переходника — это одна инструкция `b`, в нём адреса данных
            # быть и не может.
            if nm_for_addr.startswith('tail_'):
                nm_for_addr = ''
            # Имя действия автомата несёт адрес ОПИСАТЕЛЯ (`sm_801d64__action_…`,
            # `channels_switch_sm_802234__action_…`). Он идентифицирует автомат,
            # а не обращение блока, и телом подтверждаться не обязан.
            # Все формы имени, где шестнадцатеричное поле — это адрес
            # ОПИСАТЕЛЯ автомата: `…_sm_801bec__on_…`, `state_sm_8034c0__…`,
            # `sm_801d64__action_…`, `…__action_<свой адрес>`.
            nm_for_addr = re.sub(r'(_sm)_[0-9a-f]{6}(?=__)', r'\1', nm_for_addr)
            nm_for_addr = re.sub(r'^sm_[0-9a-f]{6}(?=__)', 'sm', nm_for_addr)
            nm_for_addr = re.sub(r'_?([0-9a-f]{6})(?=__action_)', '', nm_for_addr)
            src = ent[ad][1] + ' ' + re.sub(r'_((?:8[0-9a-f]{5}))', r' 0x\1 ',
                                            nm_for_addr)
            for h in set(re.findall(r'0x(8[0-9a-f]{5})', src)):
                v = int(h, 16)
                if 0x8c0000 <= v < 0x940000 or v in ok or (ad, v) in OK_BY_HAND:
                    continue
                bad.append(('адрес из комментария не подтверждён телом блока',
                            seg, ad, '%s -> 0x%06x' % (ent[ad][0], v)))

    c = Counter(r[0] for r in bad)
    if not bad:
        print('ревизия имён: замечаний нет')
        return 0
    print('ревизия имён: %d замечаний' % len(bad))
    for k, v in c.most_common():
        print('  %-30s %d' % (k, v))
    print()
    # содержательные замечания печатаем первыми: «без имени» — это не
    # брак, а просто непокрытый остаток, и при сорока строках вывода он
    # вытеснял собой всё, ради чего ревизия и запускается
    bad.sort(key=lambda x: (x[0] == 'без имени',))
    for kind, seg, ad, n in bad[:40]:
        print('  %-30s %-3s 0x%06x  %s' % (kind, seg, ad, n))
    return 1


if __name__ == '__main__':
    sys.exit(main())
