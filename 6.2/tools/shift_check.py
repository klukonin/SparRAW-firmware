#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Проверка обычной сборки со сдвигом кода: всё ли переехало правильно.

После патча, меняющего размер блока, код за ним сдвигается.  Проверяем:

1. Инструкции.  Для каждой инструкции вендорского сегмента (по меткам L_xxxxxx
   собранного ELF известно, где она теперь) дизассемблируем старую и новую
   копию и сравниваем текст.  Совпасть обязаны всё, кроме целей переходов и
   указателей на код, а те — строго через отображение «старый → новый».
   Инструкции внутри изменённых патчем блоков не проверяются (они и должны
   отличаться), но переходы ИЗ них — проверяются по отображению.
2. Данные.  Слово сегмента данных может отличаться от вендорского только
   там, где стоит принятый указатель (ref/RELOCS-OK-*.txt), и только на
   сдвиг его цели.
3. Подозрительные числа.  Слова данных и длинные иммедиаты, равные адресу
   кода за точкой сдвига, которые НЕ сдвинулись и не входят в принятые,
   выводятся списком: если это указатель — он потерян.

    tools/shift_check.py fw        # после make rebuild с патчами
"""
import argparse, bisect, json, os, re, struct, subprocess, sys

SEGS = {
    'fw': dict(base=0x8c0000, kit='seg_008c0000.bin', data='seg_00900000.bin', dsec='fw_data'),
    'uc': dict(base=0x920000, kit='seg_00920000.bin', data='seg_00940000.bin', dsec='uc_data'),
}
OBJDUMP = '../toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install/bin/arc-elf32-objdump'
NM = '../toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install/bin/arc-elf32-nm'


OBJCOPY = OBJDUMP.replace('objdump', 'objcopy')


def disasm(binpath, vma):
    """Сырой сегмент -> объект с .incbin в .text -> ELF по адресу vma -> objdump -d."""
    AS = OBJDUMP.replace('objdump', 'as')
    LD = OBJDUMP.replace('objdump', 'ld')
    src, obj, elf = binpath + '.S', binpath + '.o', binpath + '.elf'
    open(src, 'w').write('\t.section .text,"ax",@progbits\n\t.incbin "%s"\n'
                         % os.path.abspath(binpath))
    subprocess.run([AS, '-mcpu=arc600', '-o', obj, src], check=True)
    subprocess.run([LD, '-Ttext=0x%x' % vma, '-e', '0x%x' % vma, '-o', elf, obj], check=True)
    out = subprocess.run([OBJDUMP, '-d', elf], capture_output=True, text=True).stdout
    res = {}
    for l in out.splitlines():
        m = re.match(r'^\s*([0-9a-f]+):\s+((?:[0-9a-f]{4} ?)+)\s+(.*)$', l)
        if m:
            res[int(m.group(1), 16)] = (len(m.group(2).split()) * 2, m.group(3).strip())
    return res


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('seg', choices=('fw', 'uc'))
    ap.add_argument('--kit', default='../blobs/kit-6200/')
    a = ap.parse_args()
    S = SEGS[a.seg]
    base = S['base']
    elf = 'build/%s.elf' % a.seg
    # отображение старый -> новый по меткам L_xxxxxx
    M = {}
    for l in subprocess.run([NM, elf], capture_output=True, text=True).stdout.splitlines():
        q = l.split()
        if len(q) == 3 and re.match(r'^L_[0-9a-f]{6}$', q[2]):
            M[int(q[2][2:], 16)] = int(q[0], 16)
    olds = sorted(M)

    def mp(x):
        """новый адрес для старого (между метками — по ближайшей левой)"""
        if x in M:
            return M[x]
        i = bisect.bisect_right(olds, x) - 1
        return M[olds[i]] + (x - olds[i]) if i >= 0 else x

    shifted = [o for o in olds if M[o] != o]
    first = min(shifted) if shifted else None
    blocks = sorted(json.load(open('src/asm/%s/blocks.json' % a.seg))['blocks'], key=lambda b: b['addr'])
    # блоки, изменённые патчами: файлы, упомянутые в patches/
    patched = set()
    try:
        for pn in open('patches/series').read().split():
            for l in open('patches/' + pn):
                m = re.match(r'^\+\+\+ b/src/asm/%s/.*/([^/]+)\.S' % a.seg, l)
                if m:
                    patched.add(m.group(1))
    except OSError:
        pass
    pranges = [(b['addr'], b['addr'] + b['size']) for b in blocks if b['name'] in patched]

    def in_patched(x):
        return any(lo <= x < hi for lo, hi in pranges)

    import shutil
    shutil.copy(a.kit + S['kit'], 'build/%s-vendor.bin' % a.seg)
    old = disasm('build/%s-vendor.bin' % a.seg, base)
    new = disasm('build/%s.bin' % a.seg, base)
    NUM = re.compile(r'0x([0-9a-f]+)|;([0-9a-f]{6})\b|\b([0-9a-f]{6}) <')
    bad, nins = [], 0
    for o, (ln, txt) in sorted(old.items()):
        if o not in M or in_patched(o):
            continue
        n = M[o]
        if n not in new:
            bad.append('0x%06x: нет инструкции по новому адресу 0x%06x' % (o, n))
            continue
        t_new = new[n][1]
        # нормализуем: абсолютные адреса кода и смещения в пространстве
        # процессора (v < размера сегмента) переводим через отображение
        def norm(t, mapf):
            t = re.sub(r'\s+', ' ', t)
            t = re.sub(r';([0-9a-f]+)', lambda m: ';%x' % mapf(int(m.group(1), 16)), t)
            t = re.sub(r'<[^>]*>', '', t)
            return t
        # в старом тексте цели переходов — через отображение
        t1 = norm(txt, mp)
        t2 = norm(t_new, lambda x: x)
        # относительные смещения в тексте objdump («b 28») различаются —
        # сравниваем только абсолютную цель после «;»
        t1 = re.sub(r'(\b[bj]\w*(?:\.\w+)*\s+(?:[^,;]*,)*?)-?\d+(\s*;)', r'\1#\2', t1)
        t2 = re.sub(r'(\b[bj]\w*(?:\.\w+)*\s+(?:[^,;]*,)*?)-?\d+(\s*;)', r'\1#\2', t2)
        nins += 1
        if t1 != t2:
            # указатель-иммедиат: старое значение v сдвинулось ровно по отображению
            v1 = re.findall(r'0x([0-9a-f]+)', t1)
            v2 = re.findall(r'0x([0-9a-f]+)', t2)
            ok = len(v1) == len(v2) and all(
                x == y or mp(base + int(x, 16)) - base == int(y, 16) for x, y in zip(v1, v2)) and \
                re.sub(r'0x[0-9a-f]+', 'N', t1) == re.sub(r'0x[0-9a-f]+', 'N', t2)
            if not ok:
                bad.append('0x%06x->0x%06x: «%s» стало «%s»' % (o, n, txt, t_new))
    print('%s: сдвиг с 0x%06x, проверено инструкций %d, расхождений %d'
          % (a.seg, first or 0, nins, len(bad)))
    for b in bad[:30]:
        print('  ' + b)

    # данные
    ok_rel = {}
    for l in open('ref/RELOCS-OK-%s.txt' % a.seg):
        q = l.split()
        if len(q) >= 3 and q[0] == 'data':
            ok_rel[int(q[1], 16)] = int(q[2], 16)
    d_old = open(a.kit + S['data'], 'rb').read()
    d_new = open('build/%s.bin' % S['dsec'], 'rb').read()
    dbad, dsus = [], []
    for off in range(0, len(d_old) - 3):
        ram = 0x800000 + off
        if ram in ok_rel:
            v = ok_rel[ram]
            want = mp(base + v) - base
            got = struct.unpack_from('<I', d_new, off)[0]
            if got != want:
                dbad.append('0x%06x: указатель 0x%x должен стать 0x%x, а стал 0x%x' % (ram, v, want, got))
    diffs = [i for i in range(len(d_old)) if d_old[i] != d_new[i]]
    covered = set()
    for ram in ok_rel:
        covered.update(range(ram - 0x800000, ram - 0x800000 + 4))
    stray = [i for i in diffs if i not in covered]
    if first is not None:
        for off in range(0, len(d_old) - 3):
            v = struct.unpack_from('<I', d_old, off)[0]
            if first <= base + v < base + 0x40000 and base + v in M and (0x800000 + off) not in ok_rel \
               and M[base + v] != base + v:
                dsus.append((0x800000 + off, v))
    print('%s данные: указателей %d, неверных %d, лишних изменённых байт %d, '
          'несдвинутых чисел-похожих-на-адрес за точкой сдвига %d'
          % (a.seg, len(ok_rel), len(dbad), len(stray), len(dsus)))
    for b in dbad[:10]:
        print('  ' + b)
    for off in stray[:10]:
        print('  лишнее изменение байта 0x%06x' % (0x800000 + off))
    with open('build/%s-shift-suspects.txt' % a.seg, 'w') as f:
        for ram, v in dsus:
            f.write('data 0x%06x 0x%05x\n' % (ram, v))
    sys.exit(1 if bad or dbad or stray else 0)


if __name__ == '__main__':
    main()
