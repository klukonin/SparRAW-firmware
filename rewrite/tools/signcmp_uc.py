#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""signcmp_uc.py — знаковый/беззнаковый профиль функций uc: vendor 6.2 asm против нашего uc.elf.

Функции сопоставляются как в sigaudit.py (адрес из «@ 0x…» в 6.2/src/asm/uc/**.S →
tools/ghidra/out/names.txt → наш символ); дополнительно — по комментарию «6.2 asm 0x…»
/ «/* 0x9xxxxx */» перед определением функции в uc/*.c (если имени нет в names.txt).
Для каждой функции считаются:
  S   — знаковые условия: br/b/j/bl/set + lt/ge/gt/le, предикаты .lt/.ge/.gt/.le;
  U   — беззнаковые: lo/hs/hi/ls (cs/cc/c/nc сводятся к lo/hs);
  S0/U0 — то же, но оба операнда заведомо в [0, 2^31) (ldb/ldw/extb/bmsk/lsr/малая константа
        в пределах 16 инструкций назад) — знак не влияет, в оценку не входят;
  N   — проверка знакового бита: mi/pl/n/p, bbit0/bbit1 …,31;
  MM  — min/max (на ARC только знаковые);
  ASR / LSR — сдвиги; SEX — sexb/sexw/sexh; LDX — ld*.x (знаковое расширение при загрузке);
  WRAP — add/sub, сразу сужение extb/extw/sexb/bmsk 7|15 и сравнение/min/max: у vendor
        арифметика в u8/u16 (C: (u8)(x + 1)); у нас без приведения — int, заворота нет
        (так найдено internal_tx_flow_sm4: max(dialog_tok + 1, 2)).
Ранжирование: «перекос» — vendor знаковых больше, а беззнаковых меньше, чем у нас (или
наоборот), плюс разница MM/ASR/SEX/LDX.  Шум: инлайн, свёртка констант, gcc заменяет
сравнения на breq/bmsk и т.п. — каждый кандидат разбирать руками.

  signcmp_uc.py [--elf uc.elf] [--names names.txt] [--fn a,b] [--all] [--min-score N] [-v]
"""
import os, re, sys, glob, argparse, subprocess, collections

R = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, R)
import sigaudit  # noqa: E402

CC_NORM = {'cs': 'lo', 'c': 'lo', 'cc': 'hs', 'nc': 'hs', 'z': 'eq', 'nz': 'ne', 'n': 'mi', 'p': 'pl'}
CCS = {'eq', 'ne', 'z', 'nz', 'lo', 'hs', 'hi', 'ls', 'cs', 'cc', 'c', 'nc', 'lt', 'ge', 'gt', 'le',
       'mi', 'pl', 'n', 'p', 'vs', 'vc', 'v', 'nv', 'al', 'ra', 'pnz'}
SIGNED = {'lt', 'ge', 'gt', 'le'}
UNSIGNED = {'lo', 'hs', 'hi', 'ls'}
SIGNBIT = {'mi', 'pl'}
KEYS = ('S', 'U', 'S0', 'U0', 'N', 'MM', 'ASR', 'LSR', 'SEX', 'LDX', 'WRAP')


def cond_of(mn):
    """Условие инструкции (нормализованное) или None."""
    parts = mn.split('.')
    base = parts[0]
    if base.endswith('_s'): base = base[:-2]
    for p in parts[1:]:
        p = p.replace('_s', '')
        if p in CCS: return CC_NORM.get(p, p)
    for pre in ('br', 'set', 'j', 'b'):           # brlt, setlo, jhi, blo
        if base.startswith(pre) and base[len(pre):] in CCS:
            return CC_NORM.get(base[len(pre):], base[len(pre):])
    if base.startswith('jl') and base[2:] in CCS: return CC_NORM.get(base[2:], base[2:])
    if base.startswith('bl') and base[2:] in CCS: return CC_NORM.get(base[2:], base[2:])
    return None


REG = re.compile(r'^(r\d+|gp|fp|sp|blink|lp_count)$')
FLAGSET = ('cmp', 'rcmp', 'tst', 'btst')


def _split(t):
    m = re.match(r'^(\S+)\s*(.*)$', t)
    if not m: return '', []
    return m.group(1), sigaudit.split_args(m.group(2))


def _base(mn):
    b = mn.split('.')[0]
    return b[:-2] if b.endswith('_s') else b


def _imm(x):
    try:
        return int(x, 0)
    except ValueError:
        return None


CLOB = {'r%d' % i for i in range(13)} | {'blink'}
NOWR = ('st', 'br', 'bb', 'cmp', 'rcmp', 'tst', 'btst', 'push', 'j', 'b', 'lp', 'sr', 'flag', 'nop', 'sync')
BWR = ('bmsk', 'bmskn', 'bclr', 'bset', 'bic', 'bxor')


def nonneg(insns, tg, i, op, depth=0):
    """Операнд op инструкции i заведомо в [0, 2^31)? Ищем его определение назад по линейному
    участку (до метки-цели перехода, вызова или 16 инструкций): ldb/ldw без .x, extb/extw,
    bmsk < 31, lsr на != 0, and с малой маской, малая константа."""
    v = _imm(op)
    if v is not None: return 0 <= v < 0x80000000
    if not REG.match(op) or depth > 2: return False
    for j in range(i - 1, max(-1, i - 16), -1):
        if insns[j + 1][0] in tg: return False          # сюда входят переходом — не знаем
        mn, a = _split(insns[j][1])
        b = _base(mn)
        if b in ('bl', 'jl') or (b.startswith(('bl', 'jl')) and cond_of(mn)):
            if op in CLOB: return False                 # результат/порча вызовом — не знаем
            continue
        if a and a[0] == op and not (b.startswith(NOWR) and b not in BWR):
            if cond_of(mn): return False                # предикатная запись — не знаем
            if re.match(r'^ld[bwh]$', b) and '.x' not in mn: return True
            if b in ('extb', 'extw'): return True
            if b == 'bmsk' and len(a) >= 2 and _imm(a[-1]) is not None and _imm(a[-1]) < 31: return True
            if b == 'lsr' and (len(a) == 2 or _imm(a[2]) not in (None, 0)): return True
            if b == 'and' and any(_imm(x) is not None and 0 <= _imm(x) < 0x80000000 for x in a[1:]):
                return True
            if b == 'bclr' and len(a) == 3 and _imm(a[2]) == 31: return True
            if b == 'mov' and len(a) == 2: return nonneg(insns, tg, j, a[1], depth + 1)
            if b == 'min' and len(a) == 3:              # знаковый min: оба >= 0
                return nonneg(insns, tg, j, a[1], depth + 1) and nonneg(insns, tg, j, a[2], depth + 1)
            if b == 'max' and len(a) == 3:              # знаковый max: хотя бы один >= 0
                return nonneg(insns, tg, j, a[1], depth + 1) or nonneg(insns, tg, j, a[2], depth + 1)
            return False
    return False


def benign(insns, tg, i):
    """Знаковое и беззнаковое условие здесь равносильны: оба операнда сравнения в [0, 2^31)."""
    mn, a = _split(insns[i][1])
    b = _base(mn)
    if b.startswith('br') and len(a) == 3: return nonneg(insns, tg, i, a[0]) and nonneg(insns, tg, i, a[1])
    for j in range(i - 1, max(-1, i - 10), -1):     # ищем, кто ставил флаги
        if insns[j + 1][0] in tg: return False
        mj, aj = _split(insns[j][1])
        bj = _base(mj)
        if bj in FLAGSET and len(aj) == 2:
            return bj == 'cmp' and nonneg(insns, tg, j, aj[0]) and nonneg(insns, tg, j, aj[1])
        if '.f' in mj.split('.')[1:] or 'f' in mj.split('.')[1:]:
            return False                                # sub.f и т.п.: разность может быть < 0
        if bj in ('bl', 'jl'): return False
    return False


def profile(insns, tg):
    c = collections.Counter(); where = collections.defaultdict(list)
    for i, (lab, t) in enumerate(insns):
        m = re.match(r'^(\S+)\s*(.*)$', t)
        if not m: continue
        mn, args = m.group(1), m.group(2)
        base = mn.split('.')[0]
        if base.endswith('_s'): base = base[:-2]
        cc = cond_of(mn)
        k = None
        if cc in SIGNED: k = 'S'
        elif cc in UNSIGNED: k = 'U'
        elif cc in SIGNBIT: k = 'N'
        elif base in ('bbit0', 'bbit1') and re.match(r'^\S+,\s*(31|0x1f)\b', args): k = 'N'
        if k in ('S', 'U') and benign(insns, tg, i):
            k += '0'                                   # операнды заведомо >= 0: шум
        if k:
            c[k] += 1; where[k].append((lab, t))
        k2 = None
        if base in ('min', 'max'): k2 = 'MM'
        elif re.match(r'^asr\d*$', base): k2 = 'ASR'
        elif re.match(r'^lsr\d*$', base): k2 = 'LSR'
        elif base in ('sexb', 'sexw', 'sexh'): k2 = 'SEX'
        elif re.match(r'^ld[bwh]?$', base) and '.x' in mn: k2 = 'LDX'
        if k2:
            c[k2] += 1; where[k2].append((lab, t))
        if wrap(insns, i):
            c['WRAP'] += 1; where['WRAP'].append((lab, t))
    return c, where


ARITH = ('add', 'sub', 'rsub', 'add1', 'add2', 'add3', 'sub1', 'sub2', 'sub3', 'asl', 'neg', 'mpy', 'mul')
USE = ('cmp', 'rcmp', 'min', 'max', 'br', 'set')


def wrap(insns, i):
    """Сужение результата арифметики до байта/полуслова (add; extb/sexb/bmsk 7|15) прямо
    перед сравнением/min/max: vendor считает в u8/s8 (C: (u8)(x + 1)), у нас — легко int."""
    mn, a = _split(insns[i][1])
    b = _base(mn)
    if b in ('extb', 'extw', 'sexb', 'sexw', 'sexh') and len(a) == 2: dst, src = a
    elif b == 'bmsk' and len(a) == 3 and a[2] in ('7', '15', '0x7', '0xf'): dst, src = a[0], a[1]
    elif b == 'bmsk' and len(a) == 2 and a[1] in ('7', '15', '0x7', '0xf'): dst = src = a[0]
    else: return False
    for j in range(i - 1, max(-1, i - 3), -1):
        mj, aj = _split(insns[j][1])
        if aj and aj[0] == src:
            if not _base(mj).startswith(ARITH): return False
            break
    else:
        return False
    for j in range(i + 1, min(len(insns), i + 5)):
        mj, aj = _split(insns[j][1])
        bj = _base(mj)
        if bj.startswith(USE) and dst in aj[:3]: return True
        if aj and aj[0] == dst and not bj.startswith(('st', 'br', 'cmp')): return False
    return False


def strip_tables(insns, tg):
    """Наш ELF: таблицы переходов gcc лежат в .text сразу после j_s [rX], objdump декодирует их
    как инструкции (ложные bn/bge/bls…). Вырезаем [TBL, TBL + число·размер) по
    «ld[bh](.as) rX,[TBL,rY]» и границе из предшествующего cmp/bhi или brhs."""
    cut = []
    for i, (lab, t) in enumerate(insns):
        mn, a = _split(t)
        mm = re.match(r'^ld([bhw]?)$', _base(mn))
        if not mm or len(a) != 2: continue
        mt = re.match(r'^\[(0x[0-9a-f]+),\s*(r\d+)\]$', a[1])
        if not mt: continue
        tbl, idx = int(mt.group(1), 16), mt.group(2)
        sz = {'b': 1, 'h': 2, 'w': 2, '': 4}[mm.group(1)]
        n = None
        for j in range(i - 1, max(-1, i - 4), -1):
            mj, aj = _split(insns[j][1])
            bj = _base(mj)
            if bj == 'cmp' and aj[:1] == [idx] and _imm(aj[1]) is not None: n = _imm(aj[1]) + 1; break
            if bj in ('brhs', 'brhi') and aj[:1] == [idx] and _imm(aj[1]) is not None:
                n = _imm(aj[1]) + (bj == 'brhi'); break
        if n is None: continue
        cut.append((tbl, tbl + n * sz))
    if not cut: return insns
    def addr(lab):
        return int(lab[2:], 16) if lab and lab.startswith('L_') else None
    return [x for x in insns if not any(lo <= (addr(x[0]) or -1) < hi for lo, hi in cut)]


def comment_map():
    """«6.2 asm 0x…»/«/* 0x9… */» прямо перед или в первой строке определения функции → адрес."""
    out = {}
    for f in glob.glob(os.path.join(R, '..', 'uc', '*.c')):
        lines = open(f).read().split('\n')
        for i, l in enumerate(lines):
            m = re.match(r'^(?:static\s+)?(?:inline\s+)?(?:__attribute__\(\([^)]*\)\)\s*)*[a-z_][\w ]*?\**\b(\w+)\s*\([^;]*\)\s*(\{.*|/\*.*)?$', l)
            if not m or l.startswith((' ', '\t')) or m.group(1) in ('if', 'while', 'for', 'switch'): continue
            ctx = ' '.join(lines[max(0, i - 3):i + 1])
            ma = re.search(r'(?:6\.2(?: asm)?:?\s*)?0x(9[0-3][0-9a-f]{4})\b', ctx)
            if ma: out.setdefault(m.group(1), int(ma.group(1), 16))
    return out


def find_names(arg):
    if arg: return arg
    p = os.path.join(R, 'ghidra', 'out', 'names.txt')
    if os.path.exists(p): return p
    try:  # рабочее дерево git worktree: names.txt лежит в основной копии (не в git)
        g = subprocess.run(['git', 'rev-parse', '--git-common-dir'], cwd=R, capture_output=True,
                           text=True).stdout.strip()
        q = os.path.join(os.path.dirname(os.path.abspath(os.path.join(R, g))), 'rewrite', 'tools', 'ghidra',
                         'out', 'names.txt')
        if os.path.exists(q): return q
    except OSError:
        pass
    sys.exit('нет names.txt (tools/ghidra/out) — укажите --names')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--elf', default=os.path.join(R, '..', 'build', 'uc.elf'))
    ap.add_argument('--names')
    ap.add_argument('--fn', default='')
    ap.add_argument('--all', action='store_true', help='печатать и совпавшие')
    ap.add_argument('--min-score', type=float, default=1)
    ap.add_argument('-v', action='store_true', help='показать сами инструкции')
    a = ap.parse_args()
    names = {}
    for l in open(find_names(a.names)):
        p = l.split()
        if len(p) >= 2: names[int(p[0], 16)] = p[1]
    O = sigaudit.our_funcs(a.elf)
    # vendor-функции, чьего имени нет в names.txt (или наш символ назван иначе), — по комментарию в C
    extra = 0
    have = set(names.values())
    for ours, adr in comment_map().items():
        if ours in O and ours not in have and names.get(adr) not in O:
            names[adr] = ours; extra += 1
    V = sigaudit.vendor_funcs(names)              # наше имя → vendor insns
    # скрытые входы: функция из C-комментария начинается внутри чужого vendor-файла
    # (напр. rf_gain_adjust_cb 0x935748 в хвосте mac__read_tsf64_uc.S) — режем файл по адресу
    for ours, adr in comment_map().items():
        if ours in V or ours not in O: continue
        lab = 'L_%x' % adr
        for vn, (ins, tg) in list(V.items()):
            k = next((i for i, x in enumerate(ins) if x[0] == lab), None)
            if k:
                V[vn] = (ins[:k], tg); V[ours] = (ins[k:], tg); extra += 1
                if a.v: print('скрытый вход %s 0x%x в %s' % (ours, adr, vn), file=sys.stderr)
                break
    fns = a.fn.split(',') if a.fn else sorted(set(V) & set(O))
    rows = []
    for n in fns:
        if n not in V or n not in O: continue
        pv, wv = profile(*V[n]); po, wo = profile(strip_tables(*O[n]), O[n][1])
        # mi/pl и bbit …,31 — то же знаковое сравнение с нулём (vendor bmi, gcc brlt …,0)
        dS = pv['S'] + pv['N'] + pv['MM'] - po['S'] - po['N'] - po['MM']
        dU = pv['U'] - po['U']
        skew = min(abs(dS), abs(dU)) if dS * dU < 0 else 0
        score = 3 * skew + abs(dS) + abs(dU) * 0.5 \
            + abs(pv['ASR'] - po['ASR']) + abs(pv['SEX'] + pv['LDX'] - po['SEX'] - po['LDX']) \
            + 2 * max(0, pv['WRAP'] - po['WRAP'])
        rows.append((score, n, pv, po, wv, wo))
    rows.sort(key=lambda r: (-r[0], r[1]))
    shown = 0
    for score, n, pv, po, wv, wo in rows:
        if score < a.min_score and not a.all: continue
        shown += 1
        diff = ' '.join('%s %d/%d' % (k, pv[k], po[k]) for k in KEYS if pv[k] or po[k])
        print('%5.1f  %-44s %s' % (score, n, diff))
        if a.v:
            for k in KEYS:
                if pv[k] == po[k]: continue
                print('        %s vendor: %s' % (k, '; '.join(t for _, t in wv[k])))
                print('        %s наш:    %s' % (k, '; '.join(t for _, t in wo[k])))
    print('(vendor/наш)  функций сравнено %d (по комментариям +%d), кандидатов (score >= %g) %d'
          % (len(rows), extra, a.min_score, shown), file=sys.stderr)


if __name__ == '__main__':
    main()
