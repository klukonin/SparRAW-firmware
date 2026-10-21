#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""signcmp.py — профиль знаковости функций fw: vendor 6.2 asm против нашей сборки fw.elf.

  signcmp.py [--elf fw.elf] [--fn a,b] [--min N] [--all] [--json out]

Сопоставление функций: адрес vendor из комментария над нашим определением (первый адрес,
который является началом блока vendor в 6.2/src/asm/fw/blocks.json), иначе — по имени
(без '_' и регистра). Наша функция, которой нет в ELF (static, заинлайнена), добавляет
профиль своего vendor-двойника к функциям того же файла, которые её вызывают.
ICF: несколько наших имён по одному адресу — профиль кода считается один раз на имя.

Считаются по функции:
  s   — знаковые условия: brlt/brge, b/j/bl/mov/… с .lt/.ge/.gt/.le;
  u   — беззнаковые: brlo/brhs, .lo/.hs/.hi/.ls/.c/.nc/.cs/.cc;
  n   — проверки знака: .n/.p/.mi/.pl, bbit0/bbit1 …,31, btst …,31;
  mm  — min/max (на ARC только знаковые);
  asr / lsr;
  sx  — знакорасширение: ldb.x/ldw.x/ldh.x, sexb/sexw/sexh;  zx — extb/extw/exth;
  m64 — mul64 (знаковое старшее слово) против mulu64.
Таблицы переходов (ld*.x [0x80xxxx,r]) не считаются; клоны gcc .part/.isra/.constprop —
к исходной функции.
Расхождение: vendor знаковое там, где у нас только беззнаковое (и наоборот). Оценка —
сумма «перетекания» знаковых в беззнаковые; печатается по убыванию. Шум: инлайн, разная
форма проверки знака (brlt r,0 ↔ bbit1 r,31), сравнения с константой, переписанные циклы —
каждое место разбирать руками по asm vendor и C.
"""
import os, re, sys, glob, json, argparse, subprocess, collections

R = os.path.dirname(os.path.abspath(__file__))
TOP = os.path.join(R, '..')
ASM = os.path.join(TOP, '..', '6.2', 'src', 'asm', 'fw')

SIGNED = {'lt', 'ge', 'gt', 'le'}
UNSIGNED = {'lo', 'hs', 'hi', 'ls', 'c', 'nc', 'cs', 'cc'}
SIGNF = {'n', 'p', 'mi', 'pl'}
CONDS = SIGNED | UNSIGNED | SIGNF | {'eq', 'ne', 'z', 'nz', 'v', 'nv', 'vs', 'vc', 'pnz', 'al', 'ra'}
KEYS = ('s', 'u', 'n', 'mm', 'asr', 'lsr', 'sx', 'zx', 'm64', 'mu64')


def classify(mn, ops):
    """Мнемоника (без _s/.d/.f) → список категорий."""
    m = mn.replace('_s', '')
    parts = m.split('.')
    base, sfx = parts[0], [p for p in parts[1:] if p not in ('d', 'f', 'x', 'as', 'a', 'ab', 'aw', 'di')]
    out = []
    cond = None
    if base in ('brlt', 'brge'):
        out.append('s')
    elif base in ('brlo', 'brhs'):
        out.append('u')
    elif base in ('bbit0', 'bbit1') and re.search(r',\s*(31|0x1f)\b', ops):
        out.append('n')
    elif base == 'btst' and re.search(r',\s*(31|0x1f)$', ops.strip()):
        out.append('n')
    elif base in ('b', 'j', 'bl', 'jl'):
        pass
    else:
        # b<cc>, bl<cc>, j<cc>, jl<cc> (objdump), сначала b/j + cc
        for pre in ('b', 'j', 'bl', 'jl'):
            if base.startswith(pre) and base[len(pre):] in CONDS:
                cond = base[len(pre):]
                break
    for p in sfx:
        if p in CONDS:
            cond = p
    if cond in SIGNED: out.append('s')
    elif cond in UNSIGNED: out.append('u')
    elif cond in SIGNF: out.append('n')
    if base in ('min', 'max'): out.append('mm')
    if base == 'asr': out.append('asr')
    if base == 'lsr': out.append('lsr')
    if base in ('sexb', 'sexw', 'sexh'):
        out.append('sx')
    elif base in ('ldb', 'ldw', 'ldh') and 'x' in parts[1:] \
            and not re.search(r'\[\s*(0x8[0-9a-f]{5}|\d{7,})\s*,', ops):
        # ld*.x rX,[0x80xxxx,rY] — смещение таблицы переходов switch: не считается
        out.append('sx')
    if base in ('extb', 'extw', 'exth'): out.append('zx')
    if base == 'mul64': out.append('m64')
    if base == 'mulu64': out.append('mu64')
    return out


def vendor_blocks():
    j = json.load(open(os.path.join(ASM, 'blocks.json')))
    return {b['addr']: b for b in j['blocks']}


def vendor_profile(blk):
    f = os.path.join(ASM, blk['dir'], blk['name'] + '.S')
    if not os.path.exists(f):
        return None, []
    c = collections.Counter(); lines = []
    for l in open(f):
        if not l.startswith('\t'): continue
        st = l.strip()
        # недекодированные инструкции (.byte) — в комментарии над ними: /* asl_s r1,r1,0x5 */
        mc = re.match(r'^/\* _?([a-z][a-z0-9_.]*) (.*) \*/$', st)
        if mc: st = mc.group(1) + ' ' + mc.group(2)
        elif st.startswith(('.', '/*', '*')): continue
        p = st.split(None, 1)
        for k in classify(p[0], p[1] if len(p) > 1 else ''):
            c[k] += 1
            lines.append((k, st))
    return c, lines


def our_profiles(elf):
    d = subprocess.run(['arc-elf32-objdump', '-d', '--no-show-raw-insn', elf],
                       capture_output=True, text=True, check=True).stdout
    prof = {}; lines = {}; cur = None
    for l in d.splitlines():
        m = re.match(r'^([0-9a-f]+) <([^>]+)>:', l)
        if m:
            # gcc-клоны (.part.N/.isra.N/.constprop.N) — к исходной функции
            cur = re.sub(r'\.(part|isra|constprop|cold)\b.*$', '', m.group(2))
            prof.setdefault(cur, collections.Counter()); lines.setdefault(cur, []); continue
        m = re.match(r'^\s+([0-9a-f]+):\s+(\S+)\s*(.*)$', l)
        if not m or cur is None: continue
        ops = re.sub(r'\s*;.*$', '', m.group(3))
        for k in classify(m.group(2), ops):
            prof[cur][k] += 1
            lines[cur].append((k, m.group(1) + ': ' + m.group(2) + ' ' + ops))
    return prof, lines


DEF = re.compile(r'^(?!static\s+inline\b)(?:[A-Za-z_][\w\s\*]*?[\s\*])?([A-Za-z_]\w*)\s*\(([^;{}]*?)\)\s*'
                 r'(?:__attribute__\s*\(\(.*?\)\)\s*)*(\{|\n\{)', re.M | re.S)
ADDR = re.compile(r'0x(8[c-f][0-9a-f]{4})\b')
KW = {'if', 'for', 'while', 'switch', 'return', 'sizeof', 'do', 'else'}


def c_defs(blocks):
    """{имя: (файл, адрес vendor | None, тело)} по fw/*.c."""
    res = {}
    for f in sorted(glob.glob(os.path.join(TOP, 'fw', '*.c'))):
        src = open(f).read()
        for m in DEF.finditer(src):
            name = m.group(1)
            if name in KW: continue
            # комментарий непосредственно над определением
            head = src[:m.start()].rstrip()
            cm = None
            if head.endswith('*/'):
                i = head.rfind('/*')
                cm = head[i:]
            else:
                # // строки
                ls = head.split('\n'); buf = []
                while ls and ls[-1].lstrip().startswith('//'):
                    buf.insert(0, ls.pop())
                cm = '\n'.join(buf) if buf else None
            addr = None
            if cm:
                for a in ADDR.findall(cm):
                    if int(a, 16) in blocks:
                        addr = int(a, 16); break
            i = src.find('{', m.end() - 1); d = 1; j = i + 1
            while d and j < len(src):
                d += {'{': 1, '}': -1}.get(src[j], 0); j += 1
            res.setdefault(name, (os.path.basename(f), addr, src[i:j]))
    return res


def norm(n):
    return re.sub(r'[^a-z0-9]', '', n.lower())


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--elf', default=os.path.join(TOP, 'build', 'fw.elf'))
    ap.add_argument('--fn', default='')
    ap.add_argument('--min', type=int, default=1, help='минимальная оценка')
    ap.add_argument('--all', action='store_true', help='печатать и функции без расхождений')
    ap.add_argument('-v', action='store_true', help='печатать сами инструкции')
    ap.add_argument('--json')
    a = ap.parse_args()
    blocks = vendor_blocks()
    byname = {}
    for ad, b in blocks.items():
        byname.setdefault(norm(b['name']), ad)
    O, OL = our_profiles(a.elf)
    defs = c_defs(blocks)
    # имя → адрес vendor
    vmap = {}
    for n, (f, ad, body) in defs.items():
        if ad is None: ad = byname.get(norm(n))
        if ad is not None: vmap[n] = ad
    for n in O:
        if n not in vmap and norm(n) in byname: vmap[n] = byname[norm(n)]
    # заинлайненные: есть в C и у vendor, нет в ELF → в вызывающие из того же файла
    extra = collections.defaultdict(list)
    for n, ad in vmap.items():
        if n in O or n not in defs: continue
        f = defs[n][0]
        for cn, (cf, _, body) in defs.items():
            if cf == f and cn != n and cn in O and re.search(r'\b%s\s*\(' % re.escape(n), body):
                extra[cn].append(n)
    # наши вспомогательные функции без пары vendor (вынесенные из тела) → в вызывающую
    # сопоставленную функцию того же файла (если такая одна)
    helper = collections.defaultdict(list)
    for n in O:
        if n in vmap or n not in defs: continue
        f = defs[n][0]
        callers = [cn for cn, (cf, _, body) in defs.items()
                   if cf == f and cn != n and cn in vmap and cn in O
                   and re.search(r'\b%s\s*\(' % re.escape(n), body)]
        if len(callers) == 1: helper[callers[0]].append(n)
    VP = {}
    def vprof(ad):
        if ad not in VP: VP[ad] = vendor_profile(blocks[ad])
        return VP[ad]
    # группы: адрес vendor → наши функции (несколько наших на одну vendor — сумма)
    groups = collections.OrderedDict()
    unm = 0
    fns = a.fn.split(',') if a.fn else sorted(O)
    for n in fns:
        if n not in O: continue
        if n not in vmap:
            unm += 1; continue
        groups.setdefault(vmap[n], []).append(n)
    rows = []
    for ad, ns in groups.items():
        vc, vl = vprof(ad)
        if vc is None: unm += len(ns); continue
        vc = collections.Counter(vc); vl = list(vl)
        inl = []
        for n in ns:
            for x in extra.get(n, []):
                if vmap[x] == ad or x in inl: continue
                c2, l2 = vprof(vmap[x])
                if c2 is None: continue
                vc.update(c2); vl += [(k, '[%s] %s' % (x, s)) for k, s in l2]; inl.append(x)
        oc = collections.Counter(); ol = []
        hl = []
        for n in ns:
            for x in [n] + helper.get(n, []):
                if x != n: hl.append(x)
                oc.update(O[x]); ol += [(k, ('[%s] ' % x if len(ns) > 1 or x != n else '') + s) for k, s in OL[x]]
        n = ','.join(ns) + (' (+' + ','.join(hl) + ')' if hl else '')
        g = lambda c, k: c.get(k, 0)
        # «перетекание» знаковых условий в беззнаковые и обратно
        s2u = max(0, g(vc, 's') - g(oc, 's'))
        u2s = max(0, g(oc, 's') - g(vc, 's'))
        sc = 0; why = []
        if s2u:
            w = 3 if g(oc, 'u') > g(vc, 'u') else 1
            if g(oc, 's') == 0: w += 1
            # знак через N-флаг/bbit 31 у нас — частая законная замена brlt r,0
            if g(oc, 'n') > g(vc, 'n'): w = max(1, w - 2)
            sc += s2u * w; why.append('vendor знак. усл. %d, наш %d (беззн. %d→%d)' %
                                      (g(vc, 's'), g(oc, 's'), g(vc, 'u'), g(oc, 'u')))
        if u2s:
            w = 2 if g(vc, 'u') > g(oc, 'u') else 1
            sc += u2s * w; why.append('наш знак. усл. %d, vendor %d (беззн. %d→%d)' %
                                      (g(oc, 's'), g(vc, 's'), g(vc, 'u'), g(oc, 'u')))
        if g(vc, 'mm') > g(oc, 'mm'):
            sc += 2 * (g(vc, 'mm') - g(oc, 'mm')); why.append('min/max vendor %d наш %d' % (g(vc, 'mm'), g(oc, 'mm')))
        if g(vc, 'asr') > g(oc, 'asr'):
            sc += 2 * (g(vc, 'asr') - g(oc, 'asr')); why.append('asr vendor %d наш %d (lsr %d/%d)' %
                                                                (g(vc, 'asr'), g(oc, 'asr'), g(vc, 'lsr'), g(oc, 'lsr')))
        if g(oc, 'asr') > g(vc, 'asr'):
            sc += g(oc, 'asr') - g(vc, 'asr'); why.append('asr наш %d vendor %d' % (g(oc, 'asr'), g(vc, 'asr')))
        if g(vc, 'sx') > g(oc, 'sx'):
            sc += g(vc, 'sx') - g(oc, 'sx'); why.append('знакорасш. vendor %d наш %d (zx %d/%d)' %
                                                       (g(vc, 'sx'), g(oc, 'sx'), g(vc, 'zx'), g(oc, 'zx')))
        if g(oc, 'sx') > g(vc, 'sx'):
            sc += g(oc, 'sx') - g(vc, 'sx'); why.append('знакорасш. наш %d vendor %d' % (g(oc, 'sx'), g(vc, 'sx')))
        if g(vc, 'm64') and not g(oc, 'm64') and g(oc, 'mu64'):
            sc += 1; why.append('mul64 vendor %d, наш mulu64 %d' % (g(vc, 'm64'), g(oc, 'mu64')))
        rows.append((sc, n, ad, dict(vc), dict(oc), why, inl, vl, ol))
    rows.sort(key=lambda r: (-r[0], r[1]))
    shown = 0
    for sc, n, ad, vc, oc, why, inl, vl, ol in rows:
        if sc < a.min and not a.all: continue
        shown += 1
        print('%3d  %-44s vendor %#x %s%s' % (sc, n, ad, blocks[ad]['name'],
                                             (' +инлайн ' + ','.join(inl)) if inl else ''))
        for w in why: print('       ' + w)
        if a.v:
            for k in ('s', 'u', 'n', 'mm', 'asr', 'sx'):
                va = [s for kk, s in vl if kk == k]; oa = [s for kk, s in ol if kk == k]
                if va or oa:
                    print('       [%s] vendor: %s' % (k, ' | '.join(va)))
                    print('       [%s] наш:    %s' % (k, ' | '.join(oa)))
    print('функций ELF %d, сопоставлено %d, без пары %d, кандидатов (оценка >= %d) %d' %
          (len(O), len(rows), unm, a.min, sum(1 for r in rows if r[0] >= a.min)), file=sys.stderr)
    if a.json:
        json.dump([{'score': r[0], 'fn': r[1], 'vendor': '%#x' % r[2], 'v': r[3], 'o': r[4], 'why': r[5]}
                   for r in rows], open(a.json, 'w'), indent=1, ensure_ascii=False)


if __name__ == '__main__':
    main()
