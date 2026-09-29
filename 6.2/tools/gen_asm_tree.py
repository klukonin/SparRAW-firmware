#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Разложить образ прошивки в дерево собственных исходников.

Каждая функция — отдельный файл `src/asm/<region>/<имя>.S` со своей секцией;
размещение по исходным адресам задаёт сгенерированный скрипт линковщика.
Это фундамент для полной пересборки: дальше файлы по одному заменяются на C,
а сборка каждый раз сверяется с оригиналом побайтово.

Вход:  INSNS.txt  (I <addr hex> <len> <текст Ghidra>)
       SYMS.txt   (SYM 0xADDR SIZE kind ИМЯ)
       сегмент-бинарь (для байтового отката там, где ассемблер не сходится)
"""
import argparse, collections, json, os, re, sys

REGS = re.compile(r'^(r\d+|blink|sp|gp|fp|ilink[12]|pcl|lp_count|mlo|mhi|mmid)$')


def normalize(t):
    """Рендеринг Ghidra -> синтаксис GNU as (различия найдены гейтом ассемблера)."""
    # Ghidra помечает инструкцию в слоте задержки ведущим подчёркиванием.
    # Для ассемблера это обычная инструкция, идущая следом за переходом.
    if t.startswith('_'):
        t = t[1:]
    # Ghidra печатает вычисленное значение PC рядом с регистром: "pcl=0x8c1ab0"
    t = re.sub(r'\bpcl=0x[0-9a-fA-F]+', 'pcl', t)
    # Ghidra иногда печатает лишнюю закрывающую скобку: [sp, 0x34]]
    t = re.sub(r'\]\]\s*$', ']', t)
    mn, _, ops = t.partition(' ')
    ops = ops.strip()
    base = mn.split('.')[0]
    root = base[:-2] if base.endswith('_s') else base
    # косвенный переход через регистр, в том числе условный: j[cc] blink -> j[cc] [blink]
    if re.match(r'^(j|jl)(eq|ne|cc|cs|hi|ls|lt|ge|gt|le|pl|mi|vs|vc)?(_s)?$', base) and REGS.match(ops):
        return '%s [%s]' % (mn, ops)
    # sync печатается Ghidra с операндом, ассемблер его не принимает
    if base == 'sync':
        return 'sync'
    # условный branch-and-link: Ghidra "blne", ассемблер ждёт "bl.ne"
    m = re.match(r'^bl(eq|ne|cc|cs|hi|ls|lt|ge|gt|le|pl|mi|vs|vc)(\.d)?$', mn)
    if m:
        return 'bl.%s%s %s' % (m.group(1), m.group(2) or '', ops)
    if '.as' in mn:
        # масштаб поля зависит от разрядности доступа: слово 4, полуслово 2
        scale = 2 if base in ('ldw', 'stw') else 4
        m = re.match(r'^(.*\[)([^,\]]+),\s*(-?0x[0-9a-fA-F]+|-?\d+)(\].*)$', ops)
        if m:
            v = int(m.group(3), 0)
            if v % scale == 0:
                sign = '-' if v < 0 else ''
                ops = '%s%s,%s0x%x%s' % (m.group(1), m.group(2), sign, abs(v) // scale, m.group(4))
                return '%s %s' % (mn, ops)
    if root in ('lsr', 'asl', 'asr', 'ror', 'rlc', 'rrc') and re.match(r'^[^,]+,[^,]+,\s*(0x1|1)$', ops):
        return '%s %s' % (mn, ops.rsplit(',', 1)[0])
    if base in ('add_s', 'sub_s'):
        parts = [x.strip() for x in ops.split(',')]
        if len(parts) == 2:
            return '%s %s,%s,%s' % (mn, parts[0], parts[0], parts[1])
    return t



PCREL_LOCAL = re.compile(r'^(lp|b[a-z]*_s|br)')
TARGET = re.compile(r'\b0x00([0-9a-fA-F]{6})\b')


def relabel(t, known):
    """Абсолютные адреса переходов -> метки.

    До линковки ассемблер считает секцию от нуля, поэтому абсолютный адрес
    цели выходит за диапазон коротких переходов (b_s, bbit, lp). Ссылка на
    метку снимает вопрос: смещение считается по месту.
    """
    def sub(m):
        a = int(m.group(1), 16)
        return 'L_%06x' % a if a in known else m.group(0)
    return TARGET.sub(sub, t)

BRANCH = re.compile(r'^_?(b|bl|br|bb|lp|j|jl)[a-z0-9_.]*\s')
SLOT_BRANCH = re.compile(r'^_?(b|bl|br|bb|lp|j|jl)[a-z0-9_.]*\b')


def symbolize(nrm, vals, base):
    """Иммедиат-указатель на код -> «метка - база»; абсолютный j/jl на код
    (адрес в пространстве процессора) -> то же самое."""
    for v in sorted(vals, key=lambda x: -x):
        pat = re.compile(r'(?<![\w\[])0x0*%x\b' % v)
        nrm = pat.sub('L_%06x-0x%x' % (base + v, base), nrm, count=1)
    return nrm


def mangle(n):
    n = n.replace('::', '__')
    n = re.sub(r'[^A-Za-z0-9_]', '_', n)
    if n and n[0].isdigit():
        n = '_' + n
    return n


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--syms', required=True)
    ap.add_argument('--bin', required=True)
    ap.add_argument('--base', required=True)
    ap.add_argument('--region', required=True)
    ap.add_argument('--names-extra', help='наши имена поверх выгруженных из Ghidra')
    ap.add_argument('--filemap', help='адрес -> исходный файл прошивки')
    ap.add_argument('--anno', help='улики по блокам (gen_annotations.py)')
    ap.add_argument('--raw', help='адреса инструкций-заплат')
    ap.add_argument('--outdir', required=True)
    ap.add_argument('--ld', required=True)
    ap.add_argument('--unified', action='store_true',
                    help='обычная сборка: все блоки в одной секции, _all.S включает их по порядку')
    ap.add_argument('--relocs', help='принятые указатели на код (ref/RELOCS-OK-*.txt)')
    a = ap.parse_args()
    base = int(a.base, 16)
    blob = open(a.bin, 'rb').read()
    end = base + len(blob)

    rows = []
    for l in open(a.insns):
        if not l.startswith('I '):
            continue
        p = l.split(None, 3)
        ad = int(p[1], 16)
        if base <= ad < end:
            rows.append((ad, int(p[2]), p[3].rstrip('\n')))
    rows.sort()
    known = {ad for ad, _, _ in rows}

    raw = set()
    if a.raw:
        for l in open(a.raw):
            l = l.strip()
            if l.startswith('0x'):
                raw.add(int(l, 16))

    # принятые указатели на код: иммедиат инструкции (code) и абсолютный
    # переход (vec) пишутся символом «метка - база», а цели указателей из
    # данных (data) обязаны быть глобальными метками
    code_rel, ptr_tgt = {}, set()
    if a.relocs and os.path.exists(a.relocs):
        for l in open(a.relocs):
            q = l.split()
            if len(q) >= 3 and not l.startswith('#'):
                src, where, v = q[0], int(q[1], 16), int(q[2], 16)
                ptr_tgt.add(base + v)
                if src in ('code', 'vec'):
                    code_rel.setdefault(where, set()).add(v)

    # какие адреса вообще упоминаются как цели — только им нужны глобальные метки
    refd = set(x for x in ptr_tgt)
    for ad, ln, txt in rows:
        for m in TARGET.finditer(txt):
            v = int(m.group(1), 16)
            if v in known:
                refd.add(v)

    funcs = []
    for l in open(a.syms):
        if not l.startswith('SYM'):
            continue
        p = l.split()
        ad, sz, nm = int(p[1], 16), int(p[2]), p[-1]
        if base <= ad < end:
            funcs.append((ad, nm))
    if a.names_extra and os.path.exists(a.names_extra):
        extra = {}
        for l in open(a.names_extra):
            if l.startswith('#'):
                continue
            q = l.split()
            if len(q) >= 2 and q[0].startswith('0x'):
                extra[int(q[0], 16)] = q[1]
        funcs = [(ad, extra.get(ad, nm)) for ad, nm in funcs]
        # Адрес из NAMES-EXTRA создаёт новую границу блока — и потому
        # обязан лежать НА ГРАНИЦЕ ИНСТРУКЦИИ. Иначе блок начинается
        # посреди инструкции: сборка всё равно сойдётся побайтово (там
        # сырые байты), но символ указывает в никуда и блок нельзя
        # декомпилировать. Один такой адрес уже был — 0x9215d0 разрезал
        # `flag r0` пополам.
        starts = {r0 for r0, _, _ in rows}   # не затеняем argparse-namespace `a`
        skipped = []
        for ad, nm in extra.items():
            if base <= ad < end and all(ad != x for x, _ in funcs):
                if ad not in starts or ad % 4:
                    # Либо адрес не на границе инструкции, либо не кратен
                    # четырём — секция с такого адреса начаться не может
                    # (см. ниже про PC & ~3). И то и другое даёт символ,
                    # указывающий в никуда.
                    skipped.append((ad, nm))
                    continue
                funcs.append((ad, nm))
        if skipped:
            for ad, nm in sorted(skipped):
                print('ВНИМАНИЕ: 0x%06x (%s) не на границе инструкции — '
                      'граница не создана' % (ad, nm))
    funcs.sort()

    ins = {ad: (ln, txt) for ad, ln, txt in rows}

    def branch_after_slot(p, ln):
        """Ассемблер ARC сам отслеживает слот задержки и не считает сырые
        байты инструкцией: если слот сырой, «слотом» для него станет
        следующая настоящая инструкция, и переход там — ошибка сборки."""
        t = ins[p][1].split()[0]
        if '.d' not in t:
            return False
        s = p + ln
        if s not in ins:
            return True
        n = s + ins[s][0]
        # запрещены и переход, и инструкция с длинным иммедиатом (6/8 байт)
        return n not in ins or bool(SLOT_BRANCH.match(ins[n][1])) or ins[n][0] > 4

    # Каждая секция обязана начинаться с адреса, кратного 4: ARC считает
    # смещения ветвлений от PC & ~3, а ассемблер, не зная будущего адреса
    # секции, принимает её начало выровненным.  Границы блоков поэтому
    # округляются вниз, а инструкции, разрезанные границей, выкладываются
    # сырыми байтами.
    bounds = sorted({base, end} | {ad & ~3 for ad, _ in funcs})
    # Имя из NAMES-EXTRA может быть записано на ВЫРОВНЕННЫЙ адрес блока
    # (например 0x9215d0), тогда как в SYMS стоит настоящий вход
    # (0x9215d2). Такой адрес не создаёт новой границы — она и так есть
    # после выравнивания, — но переименовать блок обязан.
    if a.names_extra and os.path.exists(a.names_extra):
        aligned = {ad & ~3 for ad, _ in funcs}
        for ad, nm in extra.items():
            if base <= ad < end and ad in aligned:
                funcs = [(x, nm if (x & ~3) == ad else n) for x, n in funcs]
    names = {}
    used = collections.Counter()
    for ad, nm in funcs:
        nm = mangle(nm) if not nm.startswith(('FUN_', 'thunk_')) else 'sub_%06x' % ad
        used[nm] += 1
        if used[nm] > 1:
            nm = '%s_%06x' % (nm, ad)
        names.setdefault(ad, nm)

    # прошивка печатает имена своих исходных файлов в ассертах — по ним
    # дерево раскладывается так же, как лежал вендорский исходник
    fmap = {}
    if a.filemap and os.path.exists(a.filemap):
        for l in open(a.filemap):
            if l.startswith('#'):
                continue
            q = l.split()
            if len(q) >= 2:
                fmap[int(q[0], 16)] = q[1]

    def subdir(s0, s1):
        for x in range(s0, s1, 2):
            if x in fmap:
                return re.sub(r'[^A-Za-z0-9_.-]', '_', fmap[x]).rsplit('.', 1)[0]
        return '_unknown'

    anno = json.load(open(a.anno)) if a.anno and os.path.exists(a.anno) else {}

    def head(sec):
        e = anno.get(sec)
        if not e:
            return ''
        t = [' *']
        if e.get('strings'):
            t.append(' * Печатает:')
            for x in e['strings'][:8]:
                t.append(' *   %s' % x.replace('*/', '* /').rstrip())
        if e.get('callers'):
            t.append(' * Зовут его: %s' % ', '.join(e['callers'][:10]))
        if e.get('calls'):
            t.append(' * Зовёт сам: %s' % ', '.join(e['calls'][:12]))
        if e.get('rgf'):
            t.append(' * Регистры MAC: %s' % ', '.join(e['rgf'][:10]))
        if e.get('globals'):
            t.append(' * Глобалы (через gp): %s' % ', '.join(e['globals'][:12]))
        return '\n'.join(t) + '\n'

    os.makedirs(a.outdir, exist_ok=True)
    ldlines, manifest, nfile, nraw, nins = [], [], 0, 0, 0
    for s0, s1 in zip(bounds, bounds[1:]):
        # имя блока — имя первой функции внутри него: начало блока
        # округлено вниз до 4, и функция может стоять на пару байт правее
        sec = next((names[x] for x in range(s0, s1, 2) if x in names), None) \
            or 'blk_%06x' % s0
        body, p = [], s0
        while p < s1:
            if p in names and names[p] != sec:
                body.append('\t.global %s\n%s:' % (names[p], names[p]))
            if p in refd:
                body.append('\t.global L_%06x\nL_%06x:' % (p, p))
            elif p in ins:
                body.append('L_%06x:' % p)
            ln, txt = ins.get(p, (1, None))
            if txt is None or p + ln > s1:
                # данные, хвост разрезанной инструкции или просто выравнивание
                n = 1 if txt is None else s1 - p
                body.append('\t.byte ' + ','.join('0x%02x' % x
                                                   for x in blob[p - base:p - base + n]))
                p += n
                continue
            nrm = relabel(normalize(txt), known)
            if p in code_rel and ln > 4:
                # только длинный иммедиат: символ в короткой форме заставил
                # бы ассемблер взять limm и изменил бы размер инструкции
                nrm = symbolize(nrm, code_rel[p], base)
            outside = any(int(m, 16) < s0 or int(m, 16) >= s1
                          for m in re.findall(r'L_([0-9a-f]{6})', nrm))
            israw = p in raw or (outside and PCREL_LOCAL.match(nrm))
            if israw and a.unified and BRANCH.match(nrm) and 'L_' in nrm \
                    and any(blob[p - base:p - base + ln]) \
                    and ('L_%06x' % p) not in nrm \
                    and not branch_after_slot(p, ln):
                # в общей секции ассемблер сам считает смещение перехода;
                # сырым остаётся только слот, если его кодировку он не
                # воспроизводит
                israw = False
            if israw:
                body.append('\t/* %s */' % txt.replace('/*', '').replace('*/', ''))
                body.append('\t.byte ' + ','.join('0x%02x' % x
                                                   for x in blob[p - base:p - base + ln]))
                nraw += 1
            else:
                body.append('\t' + nrm)
                nins += 1
            p += ln
        sub = subdir(s0, s1)
        os.makedirs(os.path.join(a.outdir, sub), exist_ok=True)
        with open(os.path.join(a.outdir, sub, sec + '.S'), 'w') as f:
            f.write('/* %s @ 0x%06x, %d байт.  Сгенерировано gen_asm_tree.py\n'
                    ' * из дизассемблированной прошивки %s.  Заменяется на C/C++\n'
                    ' * по мере декомпиляции; сборка сверяется с оригиналом\n'
                    ' * побайтово, поэтому адрес и размер менять нельзя.\n%s */\n'
                    % (sec, s0, s1 - s0, a.region, head(sec)))
            f.write('\t.section .text.%s,"ax",@progbits\n\t.p2align 2\n\t.global %s\n%s:\n'
                    % (a.region if a.unified else sec, sec, sec))
            f.write('\n'.join(body) + '\n')
        manifest.append({'name': sec, 'addr': s0, 'size': s1 - s0, 'dir': sub})
        ldlines.append('  .text.%s 0x%08x : { KEEP(*(.text.%s)) }\n'
                       '  ASSERT(SIZEOF(.text.%s) <= %d, "блок %s не влезает '
                       'в отведённые ему %d байт")'
                       % (sec, s0, sec, sec, s1 - s0, sec, s1 - s0))
        nfile += 1

    if a.unified:
        # один ассемблерный модуль на сегмент: блоки по порядку адресов
        with open(os.path.join(a.outdir, '_all.S'), 'w') as f:
            f.write('/* Сегмент %s целиком: блоки в исходном порядке.  Сгенерировано\n'
                    ' * gen_asm_tree.py --unified.  Все блоки в одной секции, поэтому\n'
                    ' * переходы между ними считает ассемблер, а адреса — компоновщик. */\n'
                    % a.region)
            for b in manifest:
                f.write('\t.include "%s/%s.S"\n' % (b['dir'], b['name']))
    with open(a.ld, 'w') as f:
        f.write('/* Размещение блоков по исходным адресам.  Сгенерировано '
                'gen_asm_tree.py — править нельзя.\n'
                ' * Каждый блок прибит к своему адресу и не имеет права\n'
                ' * вырасти: ASSERT ловит переполнение при замене на C. */\n'
                'SECTIONS\n{\n  . = 0x%08x;\n' % base)
        f.write('\n'.join(ldlines) + '\n')
        f.write('  /DISCARD/ : { *(.comment) *(.ARC.attributes) }\n}\n')
    # выкинуть файлы прошлой генерации, иначе переименованный блок
    # останется вторым определением того же символа
    keep = {os.path.join(b['dir'], b['name'] + '.S') for b in manifest} | {'_all.S'}
    stale = []
    for root, _, files in os.walk(a.outdir):
        for f in files:
            if f.endswith('.S') and os.path.relpath(os.path.join(root, f), a.outdir) not in keep:
                stale.append(os.path.join(root, f))
    for f in stale:
        os.remove(f)
    for root, dirs, files in os.walk(a.outdir, topdown=False):
        if root != a.outdir and not os.listdir(root):
            os.rmdir(root)
    if stale:
        print('  удалено устаревших файлов: %d' % len(stale))

    json.dump({'region': a.region, 'base': base, 'end': end, 'blocks': manifest},
              open(os.path.join(a.outdir, 'blocks.json'), 'w'), indent=1)
    print('%s: файлов %d, инструкций %d, байтовых заплат %d (%.2f%%) -> %s'
          % (a.region, nfile, nins, nraw, 100.0 * nraw / (nins + nraw), a.outdir))


if __name__ == '__main__':
    main()
