#!/usr/bin/env python3
"""Сопоставление функций 4.1.0.1000 и 6.2.0.1000 и выделение того, что есть
только в одной версии.

Признаки сопоставления (в порядке надёжности):
  body   — тело совпало (6.2/ref/CORRELATION-{FW,UC}.txt);
  string — общая лог-строка, которую в каждой версии печатает ровно один блок;
  name   — одинаковое имя после нормализации;
  graph  — у сопоставленной пары ровно по одному несопоставленному вызываемому
           (или вызывающему) блоку с каждой стороны, и они совместимы: общая
           лог-строка либо обе без строк при размерах в пределах 1,5× и близком
           составе мнемоник (косинус гистограмм ≥ 0,85);
           повторяется до неподвижной точки.

    tools/version_diff.py fw|uc [--list only41|only62|pairs] [--json out.json]
"""
import argparse, collections, json, re, sys, os

ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')


def blocks(v, seg):
    b = json.load(open(f'{ROOT}/{v}/src/asm/{seg}/blocks.json'))['blocks']
    return {x['name']: x for x in b}


def anno(v, seg):
    return json.load(open(f'{ROOT}/{v}/ref/ANNO-{seg}.json'))


_MN = {}


def mnem(v, seg, name, d):
    """Гистограмма мнемоник блока из src/asm/<seg>/<dir>/<name>.S."""
    key = (v, seg, name)
    if key not in _MN:
        c = collections.Counter()
        p = f'{ROOT}/{v}/src/asm/{seg}/{d}/{name}.S'
        if os.path.exists(p):
            for l in open(p, errors='ignore'):
                m = re.match(r'\t([a-z_][a-z0-9_.]*)\s', l)
                if m and not m.group(1).startswith('.'):
                    c[m.group(1).split('.')[0]] += 1
        _MN[key] = c
    return _MN[key]


def cos(a, b):
    num = sum(a[k] * b[k] for k in a if k in b)
    den = (sum(x * x for x in a.values()) * sum(x * x for x in b.values())) ** 0.5
    return num / den if den else 0.0


def norm_str(s):
    s = re.sub(r'%[-+ #0]*[0-9*]*(?:\.[0-9*]+)?[hlLqjzt]*[diouxXeEfgGcspn]', '%', s)
    s = re.sub(r'0x[0-9a-fA-F]+', '0x', s)
    return re.sub(r'\s+', ' ', s).strip().lower()


def norm_name(n):
    n = re.sub(r'^uc_', '', n)
    n = re.sub(r'_(uc|fw)$', '', n)
    n = re.sub(r'^wmi_handler_', 'wmi_', n)
    n = re.sub(r'_[0-9a-f]{6}(?=$|__)', '', n)
    n = re.sub(r'__[0-9a-f]{6}$', '', n)
    return n


MECH = re.compile(r'^(sub_|leaf_|tail_|stub_|uses_|get_g_|set_g_|rgf_|macreg_|mac_cmd_0x|calls__|field_get|bits__|__st_|__ld_)')


def load_corr(seg):
    p = f'{ROOT}/6.2/ref/CORRELATION-{seg.upper()}.txt'
    out = {}
    if os.path.exists(p):
        for l in open(p):
            f = l.split()
            if len(f) >= 2 and f[0].startswith('0x'):
                out[int(f[0], 16)] = int(f[1], 16)
    return out


def match(seg):
    A, B = blocks('4.1', seg), blocks('6.2', seg)
    NA, NB = anno('4.1', seg), anno('6.2', seg)
    a_by_addr = {x['addr']: n for n, x in A.items()}
    b_by_addr = {x['addr']: n for n, x in B.items()}
    pair, how = {}, {}          # имя 4.1 -> имя 6.2

    def add(a, b, why):
        if a in pair or b in pair.values():
            return False
        pair[a] = b; how[a] = why
        return True

    # 1. тело
    for ab, aa in load_corr(seg).items():
        a, b = a_by_addr.get(aa), b_by_addr.get(ab)
        if a and b:
            add(a, b, 'body')
    # 2. уникальная общая строка
    def str_index(N, blk):
        idx = collections.defaultdict(set)
        for n, x in N.items():
            if n not in blk:
                continue
            for s in x.get('strings', []):
                if not re.search(r'\.(c|cpp|h)$', s):
                    idx[norm_str(s)].add(n)
        return idx
    SA, SB = str_index(NA, A), str_index(NB, B)
    for s in set(SA) & set(SB):
        if len(SA[s]) == 1 and len(SB[s]) == 1 and len(s) >= 8:
            add(next(iter(SA[s])), next(iter(SB[s])), 'string')
    # 3. имя; милли-код libgcc (__st_*/__ld_*) — точное совпадение имени
    for n in A:
        if n.startswith(('__st_', '__ld_')) and n in B:
            add(n, n, 'name')
    ib = collections.defaultdict(list)
    for n in B:
        if not MECH.match(n):
            ib[norm_name(n)].append(n)
    for n in A:
        if MECH.match(n) or n in pair:
            continue
        c = ib.get(norm_name(n), [])
        if len(c) == 1:
            add(n, c[0], 'name')
    # 4. граф
    changed = True
    while changed:
        changed = False
        for a, b in list(pair.items()):
            for key in ('calls', 'callers'):
                ca = [x for x in NA.get(a, {}).get(key, []) if x in A and x not in pair and not x.startswith('__')]
                cb = [x for x in NB.get(b, {}).get(key, []) if x in B and x not in pair.values() and not x.startswith('__')]
                if len(ca) == 1 and len(cb) == 1:
                    x, y = ca[0], cb[0]
                    sa, sb = A[x]['size'], B[y]['size']
                    ta = {norm_str(t) for t in NA.get(x, {}).get('strings', [])}
                    tb = {norm_str(t) for t in NB.get(y, {}).get('strings', [])}
                    # совместимость: общая строка, либо обе без строк и размеры близки (≤1.5×)
                    ok = (ta & tb) or (not ta and not tb and min(sa, sb) * 3 >= max(sa, sb) * 2
                                       and cos(mnem('4.1', seg, x, A[x]['dir']), mnem('6.2', seg, y, B[y]['dir'])) >= 0.85)
                    if ok:
                        changed |= add(x, y, 'graph')
    return A, B, NA, NB, pair, how


def filemap(v):
    fm = {}
    p = f'{ROOT}/{v}/ref/FN-FILEMAP.txt'
    for l in open(p):
        f = l.split()
        if len(f) >= 2 and f[0].startswith('0x'):
            fm[int(f[0], 16)] = f[1]
    return fm


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('seg', choices=['fw', 'uc'])
    ap.add_argument('--list', choices=['only41', 'only62', 'pairs'])
    ap.add_argument('--json')
    a = ap.parse_args()
    A, B, NA, NB, pair, how = match(a.seg)
    inv = {v: k for k, v in pair.items()}
    only41 = [n for n in A if n not in pair]
    only62 = [n for n in B if n not in inv]
    sz = lambda D, L: sum(D[n]['size'] for n in L)
    print(f'{a.seg}: блоков 4.1 {len(A)} ({sz(A, A)} Б), 6.2 {len(B)} ({sz(B, B)} Б)')
    c = collections.Counter(how.values())
    print(f'пар {len(pair)}: ' + ', '.join(f'{k} {v}' for k, v in c.most_common()))
    print(f'только 4.1: {len(only41)} блоков, {sz(A, only41)} Б; только 6.2: {len(only62)} блоков, {sz(B, only62)} Б')
    if a.list == 'only41':
        for n in sorted(only41, key=lambda n: A[n]['addr']):
            print(f"{A[n]['addr']:#x} {A[n]['size']:5d} {n}")
    elif a.list == 'only62':
        for n in sorted(only62, key=lambda n: B[n]['addr']):
            print(f"{B[n]['addr']:#x} {B[n]['size']:5d} {n}")
    elif a.list == 'pairs':
        for k in sorted(pair, key=lambda n: A[n]['addr']):
            print(f"{A[k]['addr']:#x} {B[pair[k]]['addr']:#x} {how[k]:6s} {k} = {pair[k]}")
    if a.json:
        json.dump({'pairs': pair, 'how': how, 'only41': only41, 'only62': only62}, open(a.json, 'w'), ensure_ascii=False, indent=1)


if __name__ == '__main__':
    main()
