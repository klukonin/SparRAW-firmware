#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Собрать сегмент прошивки из ассемблерного текста ДО ПОБАЙТОВОГО СОВПАДЕНИЯ.

Сходящийся цикл: собрали -> сравнили с оригиналом -> инструкции, где ассемблер
выбрал другую (тоже верную) кодировку, переводим в сырые байты с сохранением
дизассемблерного текста в комментарии -> собрали снова. Повторяем, пока
расхождений не останется.

Итог: образ, который собирается из НАШЕГО дерева и совпадает с оригиналом байт
в байт, плюс честная доля «настоящего ассемблера» против байтовых заплат.
"""
import argparse, os, subprocess, sys, tempfile
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from gen_asm_tree import normalize, relabel


def emit(path, rows, base, known, raw, blob):
    with open(path, 'w') as f:
        f.write('\t.section .text\n')
        for ad, ln, txt in rows:
            f.write('\t.org 0x%x\nL_%06x:\n' % (ad - base, ad))
            if ad in raw:
                b = blob[ad - base:ad - base + ln]
                f.write('\t/* %s */\n' % txt.replace('/*', '').replace('*/', ''))
                f.write('\t.byte ' + ','.join('0x%02x' % x for x in b) + '\n')
            else:
                f.write('\t%s\n' % relabel(normalize(txt), known))


def build(tc, s, base, out):
    o = s + '.o'; e = s + '.elf'
    r = subprocess.run([tc + '-as', '-mcpu=arc600', '-o', o, s], capture_output=True, text=True)
    if r.returncode:
        return None, r.stderr
    r = subprocess.run([tc + '-ld', '-Ttext=0x%x' % base, '-o', e, o], capture_output=True, text=True)
    if r.returncode:
        return None, r.stderr
    subprocess.run([tc + '-objcopy', '-O', 'binary', '-j', '.text', e, out], check=True)
    return open(out, 'rb').read(), None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--insns', required=True)
    ap.add_argument('--bin', required=True)
    ap.add_argument('--base', required=True)
    ap.add_argument('--tc', required=True, help='префикс тулчейна, напр. .../arc-elf32')
    ap.add_argument('--out-asm')
    ap.add_argument('--rounds', type=int, default=6)
    ap.add_argument('--out-raw', help='куда записать адреса инструкций-заплат')
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
    idx = {}
    for ad, ln, txt in rows:
        for k in range(ln):
            idx[ad - base + k] = ad

    # отложенный переход и инструкция в его слое задержки неразделимы:
    # если одна уходит в байты, ассемблер перестаёт видеть слот у другой
    nxt = {rows[i][0]: rows[i + 1][0] for i in range(len(rows) - 1)}
    prv = {v: k for k, v in nxt.items()}
    delayed = {ad for ad, _, txt in rows if '.d' in txt.split()[0]}

    def expand(s0):
        out = set(s0)
        while True:
            add = set()
            for ad in out:
                if ad in delayed and nxt.get(ad) not in out:
                    add.add(nxt[ad])
                p0 = prv.get(ad)
                if p0 is not None and p0 in delayed and p0 not in out:
                    add.add(p0)
            if not add:
                return out
            out |= add

    # переход на цель вне сегмента ассемблер закодировать не может
    # (обычно это разбор мусора в хвосте) — сразу в байты
    import re as _re
    OUTSIDE = _re.compile(r'\b0x00([0-9a-fA-F]{6})\b')
    seed = set()
    for ad, ln, txt in rows:
        mn = txt.lstrip('_').split()[0]
        if not _re.match(r'^(b|j|bl|lp)', mn):
            continue
        for m in OUTSIDE.finditer(txt):
            if int(m.group(1), 16) not in known:
                seed.add(ad)
    raw = expand(seed)
    if raw:
        print('вне сегмента ссылаются %d инструкций — переведены в байты' % len(raw))
    with tempfile.TemporaryDirectory() as td:
        for rnd in range(a.rounds):
            s = a.out_asm if a.out_asm else os.path.join(td, 'seg.s')
            emit(s, rows, base, known, raw, blob)
            got, err = build(a.tc, s, base, os.path.join(td, 'seg.bin'))
            if got is None:
                print(err[:2000]); sys.exit('сборка не прошла')
            n = min(len(got), len(blob))
            bad = [i for i in range(n) if got[i] != blob[i]]
            newraw = expand({idx[i] for i in bad if i in idx} | raw) - raw
            covered = sum(ln for ad, ln, _ in rows if ad not in raw)
            print('круг %d: расхождений %d байт (%.3f%%), настоящим ассемблером %d из %d байт (%.2f%%)'
                  % (rnd + 1, len(bad), 100.0 * len(bad) / n, covered, len(blob),
                     100.0 * covered / len(blob)))
            if not bad:
                if a.out_asm:
                    emit(a.out_asm, rows, base, known, raw, blob)
                if a.out_raw:
                    with open(a.out_raw, 'w') as f:
                        f.write('# адреса инструкций, оставленных сырыми байтами\n')
                        for x in sorted(raw):
                            f.write('0x%06x\n' % x)
                print('ПОБАЙТОВОЕ СОВПАДЕНИЕ достигнуто; байтовых заплат: %d инструкций' % len(raw))
                return
            if not newraw:
                print('не сходится: остались расхождения вне границ инструкций')
                return
            raw |= newraw
    print('круги исчерпаны')


if __name__ == '__main__':
    main()
