#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Реестр мест, где в прошивке записан адрес кода (кандидаты в перемещения).

Для обычной сборки (gen_layout.py --plain) все такие места должны стать
символами: иначе изменение размера любого блока сдвинет код, а указатель
останется старым.  В адресном пространстве своего процессора код fw лежит
с 0 (хост видит его по 0x8c0000), код ucode — тоже с 0 (хост: 0x920000),
поэтому указатель на функцию — это «адрес в дереве минус база сегмента».

Источники:
  data  — слово образа данных сегмента (fw_data / uc_data), любое
          выравнивание: записи таблиц автоматов 5-байтные;
  code  — иммедиат mov/st/push, не смещение в [..] и не операнд сравнения;
  vec   — абсолютный переход таблицы векторов.

Уверенность (conf):
  high  — таблица автомата (ref/SM-TABLES*.txt), серия соседних указателей,
          цель без прямых вызовов, аргумент u_schd__*, вектор;
  mid   — одиночное выровненное слово/иммедиат на блок с прямыми вызовами;
  low   — невыровненное слово вне таблиц автоматов, значение < 0x800.

Полнота: блок без прямых вызовов и без проваливания в него из предыдущего
блока должен иметь хотя бы один указатель; блоки без него перечисляются.

    tools/reloc_audit.py            # пишет ref/RELOCS-fw.txt, ref/RELOCS-uc.txt
"""
import argparse, bisect, collections, json, re, struct

SEGS = {
    'fw': dict(base=0x8c0000, end=0x900000, data='seg_00900000.bin', sm='ref/SM-TABLES.txt'),
    'uc': dict(base=0x920000, end=0x940000, data='seg_00940000.bin', sm='ref/SM-TABLES-UC.txt'),
}
UNCOND = re.compile(r'^_?(j|j_s|b|b_s|j\.d|j_s\.d|b\.d|j\.f|jeq_s_never)\b')
ABS = re.compile(r'0x00([89][0-9a-f]{5})\b')
IMM = re.compile(r'(?<![\w\[])(?<!, )(-?0x[0-9a-f]+)\b(?!\])')


def load(insns, lo, hi):
    ins = []
    for l in open(insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        a = int(p[1], 16)
        if lo <= a < hi:
            ins.append((a, int(p[2]), p[3].strip()))
    return ins


def sm_cells(path, data):
    """Адреса (в ОЗУ данных, 0x80xxxx) четырёхбайтовых полей обработчиков
    в таблицах переходов автоматов: описатель из строки «== имя (описатель
    0x80xxxx, S состояний x E событий», таблица — слово описателя +4,
    ячейка 5 байт (4 — адрес обработчика, 1 — следующее состояние)."""
    cells = set()
    try:
        txt = open(path).read()
    except OSError:
        return cells
    for m in re.finditer(r'описатель (0x80[0-9a-f]{4}), (\d+) состояний x (\d+) событий', txt):
        d, ns, ne = int(m.group(1), 16), int(m.group(2)), int(m.group(3))
        tab = struct.unpack_from('<I', data, d - 0x800000 + 4)[0]
        for i in range(ns * ne):
            cells.add(tab + 5 * i)
    return cells


def audit(seg, insns, kit, blocks_json, anno_json):
    S = SEGS[seg]
    base, end = S['base'], S['end']
    bl = sorted(json.load(open(blocks_json))['blocks'], key=lambda b: b['addr'])
    starts = {b['addr']: b['name'] for b in bl}
    ads = [b['addr'] for b in bl]
    ins = load(insns, base, end)
    at = {a: (n, t) for a, n, t in ins}
    labels = set(starts)
    direct = collections.Counter()
    for a, n, t in ins:
        mn = t.split()[0].lstrip('_')
        for m in ABS.finditer(t):
            v = int(m.group(1), 16)
            if base <= v < end:
                labels.add(v)
                if mn[0] in 'bj':
                    direct[v] += 1

    def owner(addr):
        return bl[bisect.bisect_right(ads, addr) - 1]

    # проваливание: последняя инструкция предыдущего блока не безусловный уход
    fall = set()
    for p, b in zip(bl, bl[1:]):
        last = [(a, n, t) for a, n, t in ins if p['addr'] <= a < p['addr'] + p['size']][-1:]
        if last:
            t = last[0][2].lstrip('_')
            mn = t.split()[0]
            if not (mn in ('j', 'j_s', 'j.d', 'j_s.d', 'j.f', 'b', 'b_s', 'b.d', 'rtie') or
                    mn.startswith(('j_s', 'j.', 'b.d'))):
                fall.add(b['addr'])
            # слот задержки: уход предпоследней
    rows = []

    def add(src, where, width, v, conf, why):
        tgt = base + v
        rows.append(dict(src=src, where=where, width=width, value=v, target=tgt,
                         tname=starts.get(tgt) or ('%s+0x%x' % (owner(tgt)['name'], tgt - owner(tgt)['addr'])),
                         conf=conf, why=why))

    # ---- векторы: абсолютные j в таблице векторов
    vt = bl[0]
    for a, n, t in ins:
        if vt['addr'] <= a < vt['addr'] + vt['size'] and t.lstrip('_').startswith('j '):
            m = re.search(r'0x([0-9a-f]+)', t)
            if m:
                add('vec', a, 4, int(m.group(1), 16), 'high', 'таблица векторов')

    # ---- иммедиаты в коде
    uschd = {a for a, nm in starts.items() if nm.startswith('u_schd__')}
    for i, (a, n, t) in enumerate(ins):
        mn = t.split()[0].lstrip('_')
        base_mn = mn.split('.')[0].replace('_s', '')
        if base_mn not in ('mov', 'st', 'push', 'stw', 'stb'):
            continue
        body = t.split(None, 1)[1] if ' ' in t else ''
        head = body.split('[')[0]
        for m in re.finditer(r'(?<![\w])(0x[0-9a-f]+)\b', head):
            v = int(m.group(1), 16)
            if not (0x100 <= v < end - base) or base + v not in labels:
                continue
            why, conf = [], 'mid'
            tgt = base + v
            if direct[tgt] == 0 and tgt in starts:
                why.append('цель без прямых вызовов'); conf = 'high'
            dst = body.split(',')[0].strip()
            for a2, n2, t2 in ins[i + 1:i + 6]:
                m2 = re.match(r'_?bl\S*\s+0x00([89][0-9a-f]{5})', t2)
                if m2 and int(m2.group(1), 16) in uschd and dst == 'r0':
                    why.append('аргумент u_schd'); conf = 'high'; break
            if v < 0x800 and conf != 'high':
                conf = 'low'; why.append('малое значение')
            if n <= 4:
                # короткий иммедиат: указатель так не пишут, и символ изменил
                # бы размер инструкции
                conf = 'low'; why.append('короткая форма')
            if tgt not in starts:
                why.append('внутрь блока')
            add('code', a, 4, v, conf, ', '.join(why) or 'иммедиат')

    # ---- слова образа данных
    d = open(kit + S['data'], 'rb').read()
    cells = sm_cells(S['sm'], d)
    hits = {}
    for off in range(0, len(d) - 3):
        v = struct.unpack_from('<I', d, off)[0]
        if 0x100 <= v < end - base and base + v in labels:
            hits[off] = v
    for off, v in hits.items():
        ram = 0x800000 + off
        tgt = base + v
        why, conf = [], 'mid'
        if ram in cells:
            why.append('таблица автомата'); conf = 'high'
        elif off % 4 == 0 and ((off + 4) in hits or (off - 4) in hits):
            why.append('серия указателей'); conf = 'high'
        elif off % 4 == 0 and direct[tgt] == 0 and tgt in starts:
            why.append('цель без прямых вызовов'); conf = 'high'
        elif off % 4:
            why.append('невыровнено'); conf = 'low'
        if v < 0x800 and conf != 'high':
            conf = 'low'; why.append('малое значение')
        if tgt not in starts:
            why.append('внутрь блока')
        add('data', ram, 4, v, conf, ', '.join(why) or 'слово данных')

    covered = {r['target'] for r in rows if r['conf'] != 'low'}
    orphans = [b for b in bl[1:] if direct[b['addr']] == 0 and b['addr'] not in fall
               and b['addr'] not in covered]
    return rows, orphans, bl, direct, fall


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', default='../blobs/insns/INSNS-6200.txt')
    ap.add_argument('--kit', default='../blobs/kit-6200/')
    a = ap.parse_args()
    for seg in ('fw', 'uc'):
        rows, orphans, bl, direct, fall = audit(seg, a.insns, a.kit,
                                                f'src/asm/{seg}/blocks.json', f'ref/ANNO-{seg}.json')
        c = collections.Counter((r['src'], r['conf']) for r in rows)
        with open(f'ref/RELOCS-{seg}.txt', 'w') as f:
            f.write('# Кандидаты в перемещения %s (tools/reloc_audit.py).\n' % seg)
            f.write('# источник  место  значение  цель  уверенность  почему\n')
            for r in sorted(rows, key=lambda r: (r['src'], r['where'])):
                f.write('%-4s 0x%06x 0x%05x %-50s %-4s %s\n' % (
                    r['src'], r['where'], r['value'], r['tname'], r['conf'], r['why']))
            f.write('\n# блоки без прямых вызовов, без проваливания и без указателя (%d):\n' % len(orphans))
            for b in orphans:
                f.write('#   0x%06x %s\n' % (b['addr'], b['name']))
        print('%s: %s; сирот без указателя %d (из %d без прямых вызовов)' % (
            seg, dict(sorted(c.items())), len(orphans),
            sum(1 for b in bl if direct[b['addr']] == 0)))


if __name__ == '__main__':
    main()
