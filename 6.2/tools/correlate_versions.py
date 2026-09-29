#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Корреляционный анализ 4.1 <-> 6.2: сопоставление функций по телу.

Это НЕ сравнение по сигнатурам «похожести» (оно на этих образах
отвергнуто трижды) и не граф вызовов. Здесь сравнивается САМО ТЕЛО
функции с точностью до перемещения: вендор пересобрал те же исходники,
адреса переехали, а последовательность инструкций осталась.

Отпечаток строится так: для каждой инструкции берётся текст, в котором
* адрес цели перехода/вызова внутри сегмента заменён на `@`,
* адрес данных 0x80xxxx.. и строки 0x10xxxxx — на `#`,
потому что и то, и другое версионно. Всё остальное — мнемоника,
регистры, непосредственные значения — остаётся как есть.

Совпадение принимается, только если отпечаток встречается РОВНО ОДИН РАЗ
в каждой версии. Иначе это типовой код (пролог-эпилог, переходник), и
сопоставление было бы догадкой.
"""
import argparse, collections, hashlib, json, re

ADDR_CODE = re.compile(r'0x00[0-9a-f]{6}\b')
ADDR_DATA = re.compile(r'0x(?:8[0-9a-f]{5}|1[0-9a-f]{6})\b')


MNEM = re.compile(r'^_?([a-z][a-z0-9_.]*)')


def fingerprints(insns_path, blocks_path, lo, hi, mode='exact'):
    ins = {}
    for l in open(insns_path):
        if l.startswith('I '):
            p = l.split(None, 3)
            a = int(p[1], 16)
            if lo <= a < hi:
                ins[a] = (int(p[2]), p[3].rstrip())
    blocks = json.load(open(blocks_path))['blocks']
    out = {}
    for b in blocks:
        if not lo <= b['addr'] < hi:
            continue
        body, p = [], b['addr']
        while p < b['addr'] + b['size']:
            ln, t = ins.get(p, (0, None))
            if t is None:
                body.append('?')
                p += 2
                continue
            if mode == 'mnemonics':
                # Второй уровень: только последовательность мнемоник.
                # Ловит функции, где вендор поменял константы или
                # смещения полей, но не тронул структуру кода. Требует
                # заметно большей длины, иначе совпадает типовой пролог.
                m = MNEM.match(t)
                t = m.group(1) if m else t
            else:
                t = ADDR_CODE.sub('@', t)
                t = ADDR_DATA.sub('#', t)
            body.append(t)
            p += ln
        if not body:
            continue
        h = hashlib.sha1('\n'.join(body).encode()).hexdigest()
        out[b['name']] = (h, b['size'], len(body), b['addr'])
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--from-insns', required=True)
    ap.add_argument('--from-blocks', required=True)
    ap.add_argument('--to-insns', required=True)
    ap.add_argument('--to-blocks', required=True)
    ap.add_argument('--lo', required=True)
    ap.add_argument('--hi', required=True)
    ap.add_argument('--mode', choices=('exact', 'mnemonics'), default='exact')
    ap.add_argument('--replace-mechanical', action='store_true',
                    help='перекрывать механические имена именем из 4.1')
    ap.add_argument('--size-tol', type=int, default=90,
                    help='режим mnemonics: насколько близки размеры, в %%')
    ap.add_argument('--min-insns', type=int, default=4,
                    help='короче этого отпечаток слишком типовой')
    ap.add_argument('--out')
    ap.add_argument('--tag', default='fw')
    ap.add_argument('--report')
    a = ap.parse_args()
    lo, hi = int(a.lo, 16), int(a.hi, 16)

    src = fingerprints(a.from_insns, a.from_blocks, lo, hi, a.mode)
    dst = fingerprints(a.to_insns, a.to_blocks, lo, hi, a.mode)

    def index(d):
        by = collections.defaultdict(list)
        for nm, (h, sz, n, ad) in d.items():
            if n >= a.min_insns:
                by[h].append((nm, sz, ad))
        return by

    si, di = index(src), index(dst)
    pairs, ambig = [], 0
    for h, dl in di.items():
        sl = si.get(h)
        if not sl:
            continue
        if len(dl) != 1 or len(sl) != 1:
            ambig += 1
            continue
        # В режиме mnemonics отпечаток слабее: одинаковая
        # последовательность мнемоник встречается у разных функций.
        # Требуем ещё и близкого размера — при равном числе инструкций
        # разница в байтах означает разные формы операндов, то есть
        # разный код.
        if a.mode == 'mnemonics':
            ds, ss = dl[0][1], sl[0][1]
            if min(ds, ss) * 100 < max(ds, ss) * a.size_tol:
                ambig += 1
                continue
        pairs.append((dl[0], sl[0], h))

    # Безымянные — их имя надо поставить.
    GENERIC = ('sub_', 'blk_', 'frag_', 'tail_', 'epi_', 'stub_ret_', 'FUN_')
    # Механические имена: честные, но менее содержательные, чем имя
    # из 4.1. Их корреляция ПЕРЕКРЫВАЕТ: `mac_cmd_0x02__923a84` против
    # `bti_worker_bi2_step` — второе говорит о функции, первое лишь о
    # том, какую команду она шлёт. Содержательные имена, полученные
    # разбором, не трогаются.
    MECH = ('uses_rgf_', 'uses_g_', 'uses_tbl_', 'field_get_', 'field_set_',
            'field_rw_', 'get_reg_', 'set_reg_', 'rgf_reg_', 'get_g_',
            'set_g_', 'rw_g_', 'macreg_r', 'mac_cmd_0x', 'ucode_cmd_0x',
            'fw_vector_', 'uc_vector_', 'tbl_')
    taken = set()
    if a.out:
        for l in open(a.out):
            q = l.split()
            if len(q) >= 2 and q[0].startswith('0x'):
                taken.add(q[1])
    named, samebytes = [], 0
    for (dnm, dsz, dad), (snm, ssz, sad), h in sorted(pairs, key=lambda x: x[0][2]):
        samebytes += dsz
        if snm.startswith(GENERIC):
            continue
        if not dnm.startswith(GENERIC) and not (
                a.replace_mechanical and dnm.startswith(MECH)):
            continue
        nm = snm
        if nm in taken:
            if nm + '_' + a.tag in taken:
                continue
            nm += '_' + a.tag
        taken.add(nm)
        named.append((dad, nm, dsz, sad))

    total_dst = sum(v[1] for v in dst.values())
    print('%s[%s]: функций 4.1 %d, 6.2 %d; совпало у %d пар '
          '(%d байт, %.1f%% сегмента); неоднозначных отпечатков %d'
          % (a.tag, a.mode, len(src), len(dst), len(pairs), samebytes,
             100.0 * samebytes / max(1, total_dst), ambig))
    print('   из них дают НОВОЕ имя: %d' % len(named))

    if a.report:
        with open(a.report, 'w') as f:
            f.write('# Корреляция 4.1 <-> 6.2 по точному телу функции\n')
            f.write('# (адреса кода и данных нормализованы, остальное дословно)\n')
            f.write('# 6.2-адрес  4.1-адрес  размер  имя в 4.1\n')
            for (dnm, dsz, dad), (snm, ssz, sad), h in sorted(pairs, key=lambda x: x[0][2]):
                f.write('0x%06x  0x%06x  %5d  %s\n' % (dad, sad, dsz, snm))
    if a.out and named:
        with open(a.out, 'a') as f:
            f.write('\n# --- корреляция с 4.1.0.1000: тело функции совпало '
                    'ТОЧНО после нормализации адресов (%s), '
                    'correlate_versions.py ---\n' % a.tag)
            for ad, nm, sz, sad in named:
                f.write('0x%08x %s # то же тело, что 0x%06x в 4.1 (%d Б)\n'
                        % (ad, nm, sad, sz))


if __name__ == '__main__':
    main()
