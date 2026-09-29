#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Строит ref/RAW-*.txt — минимальный список инструкций, которые ассемблер
кодирует не так, как вендорский образ.

Почему нужен отдельный проход, а не сравнение собранного сегмента.
Если ассемблер выдал инструкцию ДРУГОЙ ДЛИНЫ, весь хвост блока съезжает и
в расхождение попадают инструкции, закодированные верно. Поэтому каждая
инструкция ставится на свой настоящий адрес через .org — тогда сдвиг не
накапливается и список выходит точный и минимальный.

Причины расхождений, найденные на 4.1 и подтверждённые на 6.2:
  * компактные формы add_s/sub_s/asl_s/asr_s с широким непосредственным
    операндом (u7): GNU as 2.36 их не генерирует, выбирая форму u5;
  * j/bl с limm на абсолютный адрес вне сегмента: as кодирует короткой
    формой без limm;
  * заполнение нулями, которое Ghidra разобрала как `b .`.
"""
import argparse, os, re, subprocess, sys, tempfile
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from gen_asm_tree import normalize, relabel


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--bin', required=True)
    ap.add_argument('--base', required=True)
    ap.add_argument('--as', dest='as_', required=True)
    ap.add_argument('--ld', dest='ld_', required=True)
    ap.add_argument('--objcopy', required=True)
    ap.add_argument('--cpu', default='arc600')
    ap.add_argument('--raw', required=True)
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

    with tempfile.TemporaryDirectory() as td:
        s, o = os.path.join(td, 'seg.s'), os.path.join(td, 'seg.o')
        e, b = os.path.join(td, 'seg.elf'), os.path.join(td, 'seg.bin')
        with open(s, 'w') as f:
            f.write('\t.section .text\n')
            for ad, ln, txt in rows:
                f.write('\t.org 0x%x\nL_%06x:\n\t%s\n'
                        % (ad - base, ad, relabel(normalize(txt), known)))
            f.write('\t.org 0x%x\n' % len(blob))
        r = subprocess.run([a.as_, '-mcpu=' + a.cpu, '-o', o, s],
                           capture_output=True, text=True)
        if r.returncode:
            sys.exit(r.stderr[:3000])
        subprocess.run([a.ld_, '-Ttext=0x%x' % base, '-o', e, o], check=True,
                       capture_output=True)
        subprocess.run([a.objcopy, '-O', 'binary', '-j', '.text', e, b], check=True)
        got = open(b, 'rb').read()

    bad = set()
    for ad, ln, txt in rows:
        off = ad - base
        if blob[off:off + ln] != got[off:off + ln]:
            bad.add(ad)

    # Заплата в слоте задержки утаскивает за собой свой переход.
    # Ассемблер не считает .byte инструкцией и подставляет в слот
    # СЛЕДУЮЩУЮ живую инструкцию: получается либо отказ
    # ("has a jump/branch instruction in its delay slot"), либо, хуже,
    # молча другой порядок исполнения. Поэтому переход с суффиксом .d
    # перед сырой заплатой тоже уходит в сырые байты.
    DELAYED = re.compile(r'^_?[a-z]+[a-z0-9_]*\.d\b')
    pulled = 0
    while True:
        add = set()
        for i, (ad, ln, txt) in enumerate(rows):
            if ad in bad and i and rows[i - 1][0] not in bad \
               and DELAYED.match(rows[i - 1][2]):
                add.add(rows[i - 1][0])
        if not add:
            break
        bad |= add
        pulled += len(add)

    zero = sum(1 for ad, ln, _ in rows
               if ad in bad and blob[ad - base:ad - base + ln] == b'\0' * ln)
    bad = sorted(bad)
    with open(a.raw, 'w') as f:
        f.write('# адреса инструкций, оставленных сырыми байтами\n')
        f.write('# из них заполнение нулями, разобранное как код: %d\n' % zero)
        f.write('# из них подтянуто как переход перед заплатой в слоте задержки: %d\n' % pulled)
        for ad in bad:
            f.write('0x%06x\n' % ad)
    print('%s: инструкций %d, сырыми %d (%.2f%%), из них нулей %d, слотов задержки %d'
          % (a.raw, len(rows), len(bad), 100.0 * len(bad) / len(rows), zero, pulled))


if __name__ == '__main__':
    main()
