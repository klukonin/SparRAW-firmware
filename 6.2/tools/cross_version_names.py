#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Перенос имён между версиями по совпадению лог-строк.

4.1.0.1000 покрыта именами полностью, 6.2.0.1000 — только частично, а
код у них общий: вендор собирает одни исходники. Прямая улика, что два
блока — одна и та же функция: **они печатают одну и ту же лог-строку**.

Это НЕ сравнение по сигнатурам — оно на этих образах отвергнуто трижды
(см. память проекта). Строка — текст из самой прошивки, а не догадка о
похожести кода.

Условия приёма, все обязательны:
  * строка встречается ровно у ОДНОГО блока в каждой из версий;
  * строка длиннее порога — короткие вроде "ok" совпадают случайно;
  * имя-донор настоящее, а не sub_/frag_/tail_/epi_/stub_ret_/blk_;
  * блок-приёмник ещё безымянный;
  * если разные строки одного блока тянут разные имена — блок пропускается.
"""
import argparse, collections, json


GENERIC = ('sub_', 'blk_', 'frag_', 'tail_', 'epi_', 'stub_ret_', 'FUN_')


def index(anno_path, blocks_path, minlen):
    anno = json.load(open(anno_path))
    blocks = {b['name']: b for b in json.load(open(blocks_path))['blocks']}
    by = collections.defaultdict(set)
    for nm, v in anno.items():
        for s in v.get('strings') or []:
            if len(s) >= minlen:
                by[s].add(nm)
    uniq = {s: next(iter(v)) for s, v in by.items() if len(v) == 1}
    return uniq, blocks


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--from-anno', required=True)
    ap.add_argument('--from-blocks', required=True)
    ap.add_argument('--to-anno', required=True)
    ap.add_argument('--to-blocks', required=True)
    ap.add_argument('--min-len', type=int, default=16)
    ap.add_argument('--out', required=True)
    ap.add_argument('--tag', default='fw')
    a = ap.parse_args()

    src, _ = index(a.from_anno, a.from_blocks, a.min_len)
    dst, dblocks = index(a.to_anno, a.to_blocks, a.min_len)

    taken = set()
    for l in open(a.out):
        q = l.split()
        if len(q) >= 2 and q[0].startswith('0x'):
            taken.add(q[1])

    votes = collections.defaultdict(collections.Counter)
    proof = {}
    for s, dnm in dst.items():
        snm = src.get(s)
        if not snm or snm.startswith(GENERIC):
            continue
        if not dnm.startswith(GENERIC):
            continue
        votes[dnm][snm] += 1
        proof.setdefault((dnm, snm), s)

    out, skip = [], collections.Counter()
    for dnm, c in sorted(votes.items()):
        top, n = c.most_common(1)[0]
        if len(c) > 1 and n == c.most_common(2)[1][1]:
            skip['разные имена от разных строк'] += 1
            continue
        nm = top
        if nm in taken:
            if nm + '_' + a.tag in taken:
                skip['имя уже занято'] += 1
                continue
            nm += '_' + a.tag
        taken.add(nm)
        out.append((dblocks[dnm]['addr'], nm, n, sum(c.values()),
                    proof[(dnm, top)][:56]))

    with open(a.out, 'a') as f:
        f.write('\n# --- перенос имён из 4.1.0.1000 по совпадению лог-строк '
                '(%s), cross_version_names.py ---\n' % a.tag)
        for ad, nm, n, tot, s in sorted(out):
            f.write('0x%08x %s # та же строка в 4.1 (%d/%d): %s\n'
                    % (ad, nm, n, tot, s))
    print('%s: перенесено %d имён; пропущено: %s'
          % (a.tag, len(out), dict(skip)))


if __name__ == '__main__':
    main()
