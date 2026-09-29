#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Карта «механической» темноты: блоки, чьё имя до сих пор составлено
из адресов (uses_g_*, rgf_*, macreg_*, mac_cmd_0x*, leaf_*, tail_* …).

Прежняя метрика (tools/darkmap.py — упомянут ли блок в документах) для 6.2
исчерпана: всё упомянуто, но часть лишь каталогом. Механическое имя — честный
признак того, что тело блока не прочитано до смысла.

Блоки группируются по функциональному узлу: для каждого берётся ближайший
вызывающий (или, если его нет, вызываемый) с осмысленным именем, и по
префиксу этого имени (до «__») строится кластер.

    tools/mechmap.py uc            # сводка кластеров ucode
    tools/mechmap.py fw -c bf_sm   # блоки кластера с соседями
"""
import argparse, json, re, collections

MECH = re.compile(r'^(uses_|rgf_|leaf_|tail_|get_g_|set_g_|get_reg|set_reg|tbl__|'
                  r'calls__|stub_|field_get|rw_g_|sub_|bf_set_|deref_|mac_cmd_0x|'
                  r'macreg_)')


# Милли-код libgcc ARC (сохранение/восстановление регистров в прологах и
# эпилогах, см. arc-millicode-wil6210): имена __st_rN_to_rM / __ld_rN_to_rM_ret
# и варианты с gp — это настоящие имена из libgcc, а не адресные заглушки.
MILLICODE = re.compile(r'^__(st|ld)_(r\d+|gp)_to_r\d+(_ret)?$')


def is_mech(n):
    if MILLICODE.match(n):
        return False
    return bool(MECH.match(n)) or n.startswith('__')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('seg', choices=('fw', 'uc'))
    ap.add_argument('-c', '--cluster', help='показать блоки кластера')
    ap.add_argument('-n', type=int, default=40)
    a = ap.parse_args()
    blocks = json.load(open(f'src/asm/{a.seg}/blocks.json'))['blocks']
    size = {b['name']: b['size'] for b in blocks}
    addr = {b['name']: b['addr'] for b in blocks}
    anno = json.load(open(f'ref/ANNO-{a.seg}.json'))

    def named(ns):
        return [n for n in ns if n in size and not is_mech(n)]

    def owner(n, depth=3):
        # ближайший осмысленный сосед: сначала вызывающие, потом вызываемые
        seen, front = {n}, [n]
        for _ in range(depth):
            nxt = []
            for x in front:
                an = anno.get(x, {})
                for key in ('callers', 'calls'):
                    good = named(an.get(key, []))
                    if good:
                        return sorted(good, key=lambda g: -size[g])[0]
                    nxt += [y for y in an.get(key, []) if y not in seen]
            seen.update(nxt)
            front = nxt
        return '(без соседей)'

    mech = [b['name'] for b in blocks if is_mech(b['name'])]
    total = sum(size.values())
    mb = sum(size[n] for n in mech)
    cl = collections.defaultdict(list)
    for n in mech:
        o = owner(n)
        key = o.split('__')[0] if '__' in o else o
        cl[key].append((n, o))
    if a.cluster:
        for n, o in sorted(cl.get(a.cluster, []), key=lambda x: -size[x[0]]):
            an = anno.get(n, {})
            print('%6d %-44s @%x  <- %s' % (size[n], n, addr[n],
                  ','.join(an.get('callers', []))[:90]))
        return
    print('# %s: механических %d блоков, %d Б из %d (%.1f %%)'
          % (a.seg, len(mech), mb, total, 100.0 * mb / total))
    rows = sorted(cl.items(), key=lambda kv: -sum(size[n] for n, _ in kv[1]))
    for k, v in rows[:a.n]:
        print('%6d Б %4d блоков  %s' % (sum(size[n] for n, _ in v), len(v), k))


if __name__ == '__main__':
    main()
