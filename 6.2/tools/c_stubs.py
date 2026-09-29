#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Замена блоков на C/C++ без сдвига кода (обычная сборка 6.2).

Для каждого блока, у которого в каталоге замен есть <имя>.c или <имя>.cpp,
строка `.include "<dir>/<имя>.S"` в src/asm/<seg>/_all.S заменяется заглушкой
того же размера:

    L_<адрес>:  b <имя>          ; переход на реализацию на C
                nop_s × …        ; добивка до исходного размера

Адресная метка сохраняется, поэтому все вызовы и указатели на начало блока
остаются в силе; реализация на C экспортирует обычное имя блока и
размещается компоновщиком в свободном хвосте сегмента. Код за блоком не
сдвигается.

Замена отвергается, если в блок ведут переходы или указатели не на его
начало (метки L_<адрес> внутри блока, упомянутые вне его файла).

--gap-block ИМЯ --gap-start АДРЕС открывают неиспользуемую область внутри
сегмента под код на C: блок ИМЯ обрезается по АДРЕС (живое начало блока
остаётся), а все блоки за ним переводятся в секцию .text.<регион>_hi,
которую скрипт размещения ставит на исходный адрес конца блока.  Между
ними компоновщик кладёт секции .text.gap* (FW_TEXT_GAP в src/include/fw.h).

    tools/c_stubs.py --all src/asm/fw/_all.S --blocks src/asm/fw/blocks.json \\
        --csrc src/c/fw --out build/fw/_all.S
"""
import argparse, json, os, re, sys


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--all', required=True, help='исходный _all.S сегмента')
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--csrc', required=True, help='каталог замен на C/C++')
    ap.add_argument('--relocs', action='append', default=[],
                    help='указатели на код: строки «code <место> <смещение цели от базы сегмента>» (ref/RELOCS-OK-*.txt)')
    ap.add_argument('--gap-block', help='блок, конец которого отдаётся под код на C')
    ap.add_argument('--gap-start', help='адрес, с которого блок --gap-block не нужен, hex')
    ap.add_argument('--objdir', help='скомпилированные объекты C (<блок>.o)')
    ap.add_argument('--objdump', help='objdump для размеров секций')
    ap.add_argument('--place-out', help='куда записать точки разреза для gen_layout.py')
    ap.add_argument('--out', required=True)
    a = ap.parse_args()

    root = os.path.dirname(os.path.abspath(a.all))
    blocks = json.load(open(a.blocks))['blocks']
    by_name = {b['name']: b for b in blocks}
    repl = set()
    if os.path.isdir(a.csrc):
        for fn in os.listdir(a.csrc):
            base, ext = os.path.splitext(fn)
            if ext in ('.c', '.cpp'):
                if base not in by_name:
                    sys.exit(f'c_stubs: {fn}: блока {base} в дереве нет')
                repl.add(base)

    # метки внутри заменяемых блоков, на которые ссылаются извне
    inner = {}
    for n in repl:
        b = by_name[n]
        if b['size'] < 4 or b['size'] % 2:
            sys.exit(f'c_stubs: {n}: размер {b["size"]} не вмещает переход')
        for x in range(b['addr'] + 2, b['addr'] + b['size'], 2):
            inner['L_%x' % x] = n
    bad = []
    if inner:
        pat = re.compile(r'\bL_[0-9a-f]+\b')
        for b in blocks:
            p = os.path.join(root, b['dir'], b['name'] + '.S')
            if b['name'] in repl or not os.path.exists(p):
                continue
            for m in pat.findall(open(p).read()):
                if m in inner:
                    bad.append(f'{b["name"]} ссылается на {m} внутри {inner[m]}')
        base = json.load(open(a.blocks)).get('base', 0)
        for rp in a.relocs:
            if os.path.exists(rp):
                for line in open(rp):
                    f = line.split()
                    if len(f) >= 3 and f[0] == 'code':
                        lab = 'L_%x' % (base + int(f[2], 16))
                        if lab in inner:
                            bad.append(f'{os.path.basename(rp)}: указатель {f[1]} на {lab} внутри {inner[lab]}')
    # Блок, первая инструкция которого — слот задержки перехода из
    # предыдущего блока (bl.d/b.d/j.d/br*.d…), — не вход функции, а середина
    # чужой: заглушка встала бы в слот задержки.
    order = sorted(blocks, key=lambda b: b['addr'])
    prev = {order[i]['name']: order[i - 1] for i in range(1, len(order))}
    insn = re.compile(r'^\t([a-z][a-z0-9_.]*)\b')
    for n in repl:
        pb = prev.get(n)
        if not pb or pb['addr'] + pb['size'] != by_name[n]['addr']:
            continue
        p = os.path.join(root, pb['dir'], pb['name'] + '.S')
        if not os.path.exists(p):
            continue
        last = [m.group(1) for m in map(insn.match, open(p)) if m and not m.group(1).startswith('.')]
        if last and last[-1].endswith('.d'):
            bad.append(f'{n}: начинается в слоте задержки «{last[-1]}» в конце {pb["name"]}')
    if bad:
        sys.exit('c_stubs: замена без сдвига невозможна:\n  ' + '\n  '.join(sorted(set(bad))))

    region = json.load(open(a.blocks))['region']
    sec0 = '.section .text.%s,' % region
    base = json.load(open(a.blocks)).get('base', 0)

    # Где лежит реализация каждого заменённого блока: на месте блока, если
    # объект C (код и данные) влезает в его размер, иначе — в хвосте, а на
    # месте блока — заглушка-переход.
    inplace = {}
    for n in sorted(repl):
        b = by_name[n]
        need, align, gap = obj_size(a, n)
        if need is None or gap:
            continue
        if b['addr'] % max(align, 2) == 0 and need <= b['size']:
            inplace[n] = need

    # Точки разреза по возрастанию адреса: дыры на месте блоков и зазор.
    cuts = []
    for n in inplace:
        b = by_name[n]
        cuts.append({'kind': 'block', 'name': n, 'start': b['addr'],
                     'end': b['addr'] + b['size'], 'used': inplace[n]})
    gap_start = int(a.gap_start, 16) if a.gap_start else None
    if a.gap_block:
        gb = by_name.get(a.gap_block)
        if not gb or not (gb['addr'] < gap_start < gb['addr'] + gb['size']):
            sys.exit(f'c_stubs: {a.gap_start} не внутри блока {a.gap_block}')
        cuts.append({'kind': 'gap', 'name': a.gap_block, 'start': gap_start,
                     'end': gb['addr'] + gb['size']})
    cuts.sort(key=lambda c: c['start'])
    cut_by_block = {c['name']: c for c in cuts}

    part = 0                      # номер текущей секции ассемблера
    def sec(k):
        return '.section .text.%s%s,' % (region, '' if k == 0 else '_p%d' % k)

    out, done = [], set()
    inc = re.compile(r'^\s*\.include\s+"([^"]+)/([^"/]+)\.S"\s*$')
    for line in open(a.all):
        m = inc.match(line)
        if not m:
            out.append(line.rstrip('\n'))
            continue
        d, name = m.groups()
        path = os.path.join(root, d, name + '.S')
        c = cut_by_block.get(name)
        if c and c['kind'] == 'gap':
            # живое начало блока — до метки L_<gap_start>, остальное отдаётся
            src = open(path).read().replace(sec0, sec(part)).split('\n')
            cut = [i for i, l in enumerate(src) if re.match(r'\s*(\.global\s+)?L_%x\b' % gap_start, l)]
            if not cut:
                sys.exit(f'c_stubs: в {name} нет метки L_{gap_start:x}')
            out += src[:cut[0]]
            out.append(f'/* {name}: с {gap_start:#x} до конца блока — место под код на C */')
            part += 1
            c['part'] = part
            continue
        if c and c['kind'] == 'block':
            # реализация на C ляжет на место блока; метка — её синоним
            b = by_name[name]
            out += [f'/* {name} @ {b["addr"]:#x}, {b["size"]} байт: реализация на C на месте блока */',
                    f'\t.global L_{b["addr"]:x}', f'\t.set L_{b["addr"]:x}, {name}']
            part += 1
            c['part'] = part
            done.add(name)
            continue
        src = open(path).read()
        if part:
            if src.count(sec0) != 1:
                sys.exit(f'c_stubs: {name}: ожидалась одна директива {sec0}')
            src = src.replace(sec0, sec(part))
        if name in repl:
            b = by_name[name]
            head = [l for l in src.split('\n') if l.strip().startswith(('.section', '.p2align', '.align'))]
            out += head
            out += [f'/* {name} @ {b["addr"]:#x}, {b["size"]} байт: реализация на C в хвосте */',
                    f'\t.global L_{b["addr"]:x}', f'L_{b["addr"]:x}:', f'\tb {name}']
            k = (b['size'] - 4) // 2
            if k:
                out += [f'\t.rept {k}', '\tnop_s', '\t.endr']
            done.add(name)
            continue
        if part:
            out.append(src.rstrip('\n'))
        else:
            out.append(line.rstrip('\n'))
    miss = repl - done
    if miss:
        sys.exit('c_stubs: не найдены в _all.S: ' + ', '.join(sorted(miss)))
    os.makedirs(os.path.dirname(os.path.abspath(a.out)), exist_ok=True)
    open(a.out, 'w').write('\n'.join(out) + '\n')
    if a.place_out:
        json.dump({'region': region, 'base': base, 'parts': part, 'cuts': cuts},
                  open(a.place_out, 'w'), indent=1)
    if repl:
        tail = sorted(repl - set(inplace))
        print(f'c_stubs: блоков на C: {len(repl)}; на своём месте {len(inplace)}'
              f'{" (" + ", ".join(sorted(inplace)) + ")" if inplace else ""}'
              f'; в хвосте {len(tail)}{" (" + ", ".join(tail) + ")" if tail else ""}')


def obj_size(a, name):
    """Размер объекта C блока (всё, что ляжет на место блока), наибольшее
    выравнивание секции и признак кода для зазора (.text.gap)."""
    if not a.objdir or not a.objdump:
        return None, 1, False
    o = os.path.join(a.objdir, name + '.o')
    if not os.path.exists(o):
        return None, 1, False
    import subprocess
    txt = subprocess.run([a.objdump, '-h', o], capture_output=True, text=True, check=True).stdout
    need, align, gap = 0, 1, False
    for l in txt.split('\n'):
        f = l.split()
        if len(f) >= 7 and f[0].isdigit():
            sname, size, al = f[1], int(f[2], 16), 2 ** int(f[6].split('**')[1])
            if sname.startswith('.text.gap'):
                gap = True
                continue
            if not sname.startswith(('.text', '.rodata', '.data', '.bss', '.sdata', '.sbss')) or size == 0:
                continue
            need = (need + al - 1) // al * al + size
            align = max(align, al)
    return need, align, gap


if __name__ == '__main__':
    main()
