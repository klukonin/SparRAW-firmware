#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Пофункциональная дифференциальная проверка uc: vendor 6.2 vs наш C.

Для функции F собираются два образа ICCM: vendor uc и гибрид (uc_hybrid.py
--select fn:F — в vendor-образе заменена только F). Обе версии исполняются в
эмуляторе cpu.py на N одинаковых входах (seed). Вызовы других vendor-функций
не исполняются: заглушка с детерминированным ответом, вызов пишется в трассу с
аргументами (их число — из C-прототипа вызываемой). Сравниваются:
  - события по порядку: MMIO r/w, lr/sr, flag, r32..r56, вызовы (цель+аргументы);
  - итоговые записи в RAM (без стека) — как множество;
  - возвращаемое значение (если C-функция не void).

  eqcheck.py fn1 [fn2 ...] | --all  [--seeds N] [--json out]
"""
import argparse, bisect, collections, hashlib, shutil, importlib.util, json, os, re, subprocess, sys, tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
TOOLS = os.path.dirname(HERE)
REW = os.path.dirname(TOOLS)
sys.path.insert(0, HERE)
import cpu as cpumod                                   # noqa: E402

_spec = importlib.util.spec_from_file_location('uh', os.path.join(TOOLS, 'uc_hybrid.py'))
uh = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(uh)

M32 = 0xffffffff
BASE = 0x920000
SENTINEL = 0x9ff000            # адрес возврата (вне кода)
SP0 = 0x803a48
GP = 0x800528
STACK_LO = SP0 - 0x2000
MMIO = [(0x880000, 0x8c0000)]


class EqCPU(cpumod.CPU):
    """CPU для сверки: «мир» diff_world (стабильная RAM, счётчики чтений MMIO/aux/
    r32..r56 по адресу) + учёт записанных функцией байт стека (для сравнения
    стековых буферов, передаваемых вызываемым)."""

    def __init__(self, *a, **k):
        k['diff_world'] = True
        self.dic = k.pop('dic', None) or []
        super().__init__(*a, **k)
        self.stk_written = set()
        self.sp_min = SP0                     # глубина стека за прогон: стеком считается [sp_min, SP0]
        self.cov = None                       # set() — собирать PC в func_range

    # «словарный мир»: часть неинициализированных значений — константы vendor-функции
    def _pick(self, tag, addr, n, size, v):
        if not self.dic:
            return v
        h = hashlib.sha256(b'dic:%s:%08x:%08x:%d' % (tag, self.seed, addr & M32, n)).digest()
        k = h[0] % 8
        if k < 4:
            v = self.dic[int.from_bytes(h[1:4], 'little') % len(self.dic)]
        elif k == 4:
            v = 0
        if size < 4:
            v &= (1 << (8 * size)) - 1
        return v & M32

    def _det(self, addr, size=4):
        v = super()._det(addr, size)
        n = self._addr_reads.get(addr & M32, 0)
        b = BIAS.get(addr & M32)
        if b is not None and self.dic is not None and self.seed & 1:
            h = hashlib.sha256(b'bias:%08x:%08x:%d' % (self.seed, addr & M32, n)).digest()
            if h[0] & 3:                           # 3/4 — направленное значение
                return b[h[1] % len(b)] & ((1 << (8 * size)) - 1 if size < 4 else M32)
        return self._pick(b'd', addr, n, size, v)

    def read(self, addr, size):
        a0 = self._alias_addr(addr & M32)
        # Значение слова зависит только от (seed, адрес слова); заполняются лишь незаписанные
        # байты каждого задетого выровненного слова. Иначе байт, прочитанный после записи
        # соседнего в том же слове (config_brp_rf: brp_pick.selected = 0 до чтения
        # count/snr_cfg) или невыровненным чтением через границу слова (aw_set_new_tbtt со
        # случайным p), брался из другого генератора, и мир зависел от порядка и ширины доступа.
        if self.dic and not self.is_mmio(a0 & ~3):
            for a in range(a0 & ~3, a0 + max(size, 1), 4):
                if all((a + i) in self.mem for i in range(4)):
                    continue
                hb = hashlib.sha256(b'ram:%08x:%08x' % (self.seed, a)).digest()
                v = self._pick(b'r', a, 0, 4, int.from_bytes(hb[:4], 'little'))
                bv = BIAS.get(a)
                if bv is not None and self.seed & 1 and hb[5] & 3:
                    v = bv[hb[6] % len(bv)] & M32
                for i in range(4):
                    if (a + i) not in self.mem:
                        self.mem[a + i] = (v >> (8 * i)) & 0xff
                        self.ram_init.add(a + i)
        return super().read(addr, size)

    def step(self):
        if self.cov is not None:
            self.cov.add(self.pc + BASE if self.pc < 0x20000 else self.pc)   # зеркало ICCM с 0
        pc = self.pc
        r = super().step()
        if self.sp < self.sp_min and STACK_LO <= self.sp:
            self.sp_min = self.sp
        tp = self.__dict__.setdefault('tpc', [])
        while len(tp) < len(self.trace):
            tp.append(pc)                     # PC инструкции, породившей событие трассы
        return r

    def write(self, addr, data):
        a = self._alias_addr(addr & M32)
        if STACK_LO <= a < SP0 + 0x40:
            self.stk_written.update(range(a, a + len(data)))
        return super().write(addr, data)


# --------------------------------------------------------------------------- #
def c_params():
    """C-имя -> число параметров (по определениям в uc/*.c)."""
    res = {}
    rx = re.compile(r'^(?:static\s+)?(?:inline\s+)?(?:void|u8|u16|u32|u64|s8|s16|s32|int|struct\s+\w+)\s+\**(\w+)\s*\(([^)]*)\)\s*(?:\{.*|/\*.*)?$')
    for f in os.listdir(uh.UCDIR):
        if not f.endswith('.c'):
            continue
        for l in open(os.path.join(uh.UCDIR, f)):
            m = rx.match(l.rstrip())
            if m:
                p = m.group(2).strip()
                n = 0 if p in ('', 'void') else len(p.split(','))
                rt = l.split()[0] if not l.startswith(('static', 'inline')) else l.split()[1]
                res.setdefault(m.group(1), (n, rt))
    # объявления из uc/*.h (asm-функции, многострочные сигнатуры) — склеить до ';'
    drx = re.compile(r'^(?:extern\s+)?(void|u8|u16|u32|u64|s8|s16|s32|int|struct\s+\w+)\s*(\**)\s*(\w+)\s*\(([^)]*)\)\s*;')
    for f in os.listdir(uh.UCDIR):
        if not f.endswith('.h'):
            continue
        txt = re.sub(r'/\*.*?\*/', '', open(os.path.join(uh.UCDIR, f)).read(), flags=re.S)
        for decl in re.findall(r'^[a-z][^;#{}]*;', txt, re.M):
            m = drx.match(' '.join(decl.split()))
            if m:
                p = m.group(4).strip()
                n = 0 if p in ('', 'void') else len(p.split(','))
                res.setdefault(m.group(3), (n, m.group(1) + m.group(2)))
    return res


CP = c_params()
CMAP = uh.c_map()
V2C = {}
for _n, (_vb, _f) in CMAP.items():
    if _vb:
        _cur = V2C.get(_vb['addr'])
        _rank = lambda n, vb=_vb: (uh.norm(n) != uh.norm(vb['name']), n.startswith('L_'))
        if _cur is None or _rank(_n) < _rank(_cur):
            V2C[_vb['addr']] = _n          # основная копия: совпадение имени, затем не-L_
STARTS = {b['addr']: b for b in uh.blocks}
MILLI_LO, MILLI_HI = 0x920200, 0x9202f0           # vendor-подпрограммы сохранения регистров


def _returns_value_map():
    """vendor-адрес функции -> True, если её r0 используется вызывающими.

    Для каждого места вызова смотрим вперёд до ~12 команд: чтение r0 -> используется;
    перезапись r0 без чтения -> не используется; возврат (j [blink] или переход на
    vendor-эпилог __ld_*_ret 0x92029c..0x9202f0) -> как у самого вызывающего
    (транзитивно, неподвижная точка); прочие переходы -> используется (консервативно).
    """
    import bisect as _b
    dis = subprocess.run([uh.OD, '-d', uh.VELF], capture_output=True, text=True).stdout
    rows = []
    for line in dis.splitlines():
        m = re.match(r'\s+([0-9a-f]+):\s+(?:[0-9a-f]{4}\s)+\s*(\S+)\s*([^;]*)(?:;([0-9a-f]+))?', line)
        if m:
            rows.append((int(m.group(1), 16), m.group(2), m.group(3).strip(), m.group(4)))
    bl = sorted(uh.blocks, key=lambda b: b['addr'])
    ba = [b['addr'] for b in bl]

    def owner(a):
        k = _b.bisect_right(ba, a) - 1
        return bl[k]['addr'] if k >= 0 else None
    sites = {}           # callee -> [('used'|'unused'|('ret', caller))]
    for i, (a, mn, ops, tgt) in enumerate(rows):
        if not (mn.startswith('bl') or mn.startswith('jl')) or not tgt:
            continue
        t = int(tgt, 16)
        k = i + (2 if '.d' in mn else 1)
        verdict = 'used'
        for j in range(k, min(k + 14, len(rows))):
            _, m2, o2, t2 = rows[j]
            toks = [x.strip() for x in re.split(r'[,\[\]]', o2) if x.strip()]
            base = m2.split('.')[0].replace('_s', '')
            if base == 'j' and toks == ['blink']:
                verdict = ('ret', owner(a))
                break
            if base == 'b' and t2 and 0x92029c <= int(t2, 16) < 0x9202f0:
                verdict = ('ret', owner(a))
                break
            if base.startswith(('bl', 'jl')):
                verdict = 'used' if 'r0' in toks else 'unused'
                break
            if base.startswith(('st', 'push', 'cmp', 'tst', 'btst', 'br', 'bbit', 'sr', 'flag', 'lp')):
                if 'r0' in toks:
                    break
                continue
            if base.startswith(('b', 'j')) and not base.startswith(('bset', 'bclr', 'bmsk', 'bic', 'bxor')):
                break                                 # переход — консервативно used
            if base in ('ld', 'ldb', 'ldh', 'ldw', 'pop') and toks and toks[0] == 'r0':
                verdict = 'used' if 'r0' in toks[1:] else 'unused'
                break
            if toks and toks[0] == 'r0':
                cond = any(c in m2.split('.')[1:] for c in COND_SFX)
                verdict = 'used' if ('r0' in toks[1:] or cond) else 'unused'
                break
            if 'r0' in toks[1:]:
                break
        sites.setdefault(t, []).append(verdict)
    res = {t: None for t in sites}
    for _ in range(50):
        changed = False
        for t, vs in sites.items():
            v = False
            for x in vs:
                if x == 'used':
                    v = True
                elif isinstance(x, tuple):
                    caller = x[1]
                    v = v or res.get(caller) is not False if caller in res else v or True
            if res[t] != v:
                res[t] = v
                changed = True
        if not changed:
            break
    return {t: bool(v) for t, v in res.items()}


FOCUS = {}
BIAS = {}
ARGS = {}           # --args: i -> значения аргумента ri
RETS = []           # --rets: возвраты заглушек вызываемых
POKE = {}              # имя C-функции -> [(адрес, [значения])]; --poke              # адрес (MMIO или 0xEE000000+n для rN) -> [значения]; --bias
COND_SFX = {'eq', 'ne', 'lt', 'le', 'gt', 'ge', 'lo', 'hs', 'hi', 'ls', 'c', 'nc', 'p', 'n', 'v', 'nv', 'pnz', 'z', 'nz'}
RETVAL = _returns_value_map()


def arity(vaddr):
    n = V2C.get(vaddr)
    return CP.get(n, (1, 'u32'))[0] if n else 1


def build_hybrid(fn, work):
    out = os.path.join(work, fn + '.bin')
    rep = os.path.join(work, fn + '.json')
    r = subprocess.run([sys.executable, os.path.join(TOOLS, 'uc_hybrid.py'), '--select', 'fn:' + fn,
                        '--out', out, '--report', rep, '--work', os.path.join(work, 'hy')],
                       capture_output=True, text=True)
    if r.returncode != 0 or not os.path.exists(out):
        raise RuntimeError('гибрид не собран: ' + (r.stdout + r.stderr)[-300:])
    syms = {}
    for line in subprocess.run([uh.NM, os.path.join(work, 'hy', 'hy.elf')],
                               capture_output=True, text=True).stdout.splitlines():
        p = line.split()
        if len(p) == 3:
            syms[p[2]] = int(p[0], 16)
    own = []
    for line in subprocess.run([uh.OD, '-h', os.path.join(work, 'hy', 'hy.elf')],
                               capture_output=True, text=True).stdout.splitlines():
        p = line.split()
        if len(p) >= 4 and p[1].startswith(('.text', '.libgcc')):
            own.append((int(p[3], 16), int(p[3], 16) + int(p[2], 16)))
    return open(out, 'rb').read(), syms, own


VCODE = uh.fw_segment(uh.VENDOR_FW, BASE)
VDATA = uh.fw_segment(uh.VENDOR_FW, 0x940000)
VSNAPS = []          # --vdata: живые снимки uc DCCM (tools/hwsnap.sh) — начальное состояние вместо загрузочного


def _table_ranges():
    """Таблицы vendor DCCM, читаемые по индексу ([0x80xxxx,rN]) — переходы/константы; не мутировать."""
    d = subprocess.run([uh.OD, '-d', uh.VELF], capture_output=True, text=True).stdout
    out = set()
    for m in re.finditer(r'\[0x(80[0-9a-f]{4}),r\d+\]', d):
        b = int(m.group(1), 16)
        out.update(range(b & ~3, (b & ~3) + 0x40, 4))
    return frozenset(out)


TABLES = _table_ranges()


def _base_vdata(seed):
    return VSNAPS[seed % len(VSNAPS)] if VSNAPS else VDATA


def _mutated_vdata(seed, dic, focus=()):
    """Копия vendor DCCM, где часть слов (не похожих на указатели кода/данных)
    заменена значениями «словаря»/0/случайными — чтобы ветвления по глобальным
    флагам тоже покрывались. Детерминированно по seed (одинаково для обоих образов)."""
    b = bytearray(_base_vdata(seed))
    for o in range(0, len(b) - 3, 4):
        v = int.from_bytes(b[o:o + 4], 'little')
        if 0x400 <= v < 0x20000 or 0x800000 <= v < 0x810000 or 0x920000 <= v < 0x940000:
            continue                              # похоже на указатель (таблицы переходов и т. п.)
        if (0x800000 + o) in TABLES:
            continue                              # индексируемая таблица (в т. ч. байтовые смещения переходов)
        h = hashlib.sha256(b'vd:%08x:%x' % (seed, o)).digest()
        k = h[0] % 8
        if (0x800000 + o) in focus:
            k = h[0] % 5                          # слова, которые функция читает явно — почти всегда мутируем
        if k < 3 and dic:
            v = dic[int.from_bytes(h[1:4], 'little') % len(dic)]
        elif k == 3:
            v = 0
        elif k == 4:
            v = int.from_bytes(h[4:8], 'little')
        else:
            continue
        b[o:o + 4] = (v & M32).to_bytes(4, 'little')
    return bytes(b)


def func_consts(va, vsz):
    """Непосредственные константы vendor-функции (+ соседи ±1) — «словарь» мира."""
    d = subprocess.run([uh.OD, '-d', '--start-address=%d' % va, '--stop-address=%d' % (va + vsz), uh.VELF],
                       capture_output=True, text=True).stdout
    vals, n = set(), 0
    for line in d.splitlines():
        m = re.match(r'\s+[0-9a-f]+:\s+(?:[0-9a-f]{4}\s)+\s*(\S+)\s*([^;]*)', line)
        if not m:
            continue
        n += 1
        mn = m.group(1)
        if mn.startswith(('b', 'j', 'lp')) and not mn.startswith(('bset', 'bclr', 'bmsk', 'bic', 'btst', 'bxor', 'br', 'bbit')):
            continue
        for t in re.findall(r'(?<![\w\[])(-?0x[0-9a-f]+|-?\d+)(?![\w\]])', m.group(2)):
            x = int(t, 0) & M32
            if mn.startswith(('bset', 'bclr', 'btst', 'bbit', 'bxor')) and x < 32:
                vals.update({1 << x, ~(1 << x) & M32})
            vals.update({x, (x + 1) & M32, (x - 1) & M32})
    return sorted(vals), n


def func_focus(va, vsz):
    """Слова DCCM, к которым функция обращается явно: абсолютные 0x80xxxx и [gp,N]."""
    d = subprocess.run([uh.OD, '-d', '--start-address=%d' % va, '--stop-address=%d' % (va + vsz), uh.VELF],
                       capture_output=True, text=True).stdout
    out = set()
    for line in d.splitlines():
        m = re.match(r'\s+[0-9a-f]+:\s+(?:[0-9a-f]{4}\s)+\s*(\S+)\s*([^;]*)', line)
        if not m:
            continue
        mn, ops = m.group(1), m.group(2)
        for t in re.findall(r'0x80[0-9a-f]{4}\b', ops):
            out.add(int(t, 16) & ~3)
        g = re.search(r'\[gp,(-?\d+)\]', ops)
        if g:
            off = int(g.group(1))
            if '.as' in mn:
                off *= 2 if mn.startswith(('ldw', 'ldh', 'stw', 'sth')) else 4
            out.add((GP + off) & ~3)
    return frozenset(out)


def make_cpu(code, seed, dic=None, mutate=False, focus=()):
    c = EqCPU(seed=seed, dic=dic)
    c.load(BASE, code, is_code=True)
    if VSNAPS and (seed // len(VSNAPS)) % 2 == 0:
        mutate = False                       # половина прогонов — снимок как есть (реальное рабочее состояние)
    c.vdata0 = _mutated_vdata(seed, dic, focus) if mutate else _base_vdata(seed)
    c.load(0x800000, c.vdata0)                # начальный DCCM uc (vendor uc_data, возможно мутированный)
    for a_, vs in BIAS.items():               # --bias для DCCM: начальное значение слова (иначе чтение
        if 0x800000 <= a_ < 0x800000 + len(c.vdata0):   # берётся из снимка и bias не действует)
            c.load(a_, (vs[seed % len(vs)] & 0xffffffff).to_bytes(4, 'little'))
    for lo, hi in MMIO:
        c.mmio(lo, hi)
    c.alias = [(0, 0x20000, BASE)]
    c.sp = SP0
    c.blink = SENTINEL
    c.regs[26] = GP                          # gp uc (vendor reset 0x9201d8: mov gp,0x800528)
    return c


def run_one(code, entry, frange, self_addr, nargs, seed, max_steps, own=None, deep=False, dic=None, cov=None):
    c = make_cpu(code, seed, dic, mutate=bool(dic), focus=FOCUS.get(self_addr, ()))
    if cov is not None:
        c.cov = cov
    ev = []
    ncall = collections.Counter()

    def norm(t):
        return t + BASE if t < 0x20000 else t

    def hook(cpu, target, is_tail, args):
        t = norm(target & M32)
        if t == SENTINEL:
            return None
        if MILLI_LO <= t < MILLI_HI:
            return None
        if any(lo <= t < hi for lo, hi in (own or [frange])):
            return None                      # свой код: тело, внутренние подпрограммы, хелперы, libgcc
        if deep and BASE <= t < BASE + 0x20000 and V2C.get(t) != 'uc_assert':
            return None                      # глубокий режим: исполнять любой код ICCM (кроме assert — он не возвращается)
        b = STARTS.get(t)
        if b is None or b['name'].startswith('__'):
            ncall[t] += 1                    # косвенный/неизвестный адрес — заглушка
            h = hashlib.sha256(b'iret:%08x:%08x:%d' % (seed, t, ncall[t])).digest()
            ev.append(('icall', t, tuple(args[:1])))   # арность неизвестна: в r1..r3 у vendor часто мусор
            return ('stub', int.from_bytes(h[:4], 'little'), int.from_bytes(h[4:8], 'little'))
        n = arity(t)
        a = []
        for x in args[:n]:
            if cpu.sp_min <= x <= SP0:
                # стековый буфер: только байты, записанные самой функцией
                bs = [cpu.mem.get(x + i) if (x + i) in cpu.stk_written else None for i in range(16)]
                for w in range(0, 16, 4):           # слова = сохранённые регистры -> скрыть
                    if None not in bs[w:w + 4] and int.from_bytes(bytes(bs[w:w + 4]), 'little') in cpu.saved_markers:
                        bs[w:w + 4] = [None] * 4
                a.append(('STK', tuple(bs)))
            else:
                a.append(x)
        if V2C.get(t) == 'uc_assert' and a:
            a[0] = 'blink'          # исключение: vendor передаёт текущий blink (mov r0,blink)
        ncall[t] += 1
        h = hashlib.sha256(b'ret:%08x:%08x:%d' % (seed, t, ncall[t])).digest()
        r0 = int.from_bytes(h[:4], 'little') & 0xff if h[4] & 1 else int.from_bytes(h[:4], 'little')
        if cpu.dic and h[5] % 8 < 4:            # словарный мир: малые/словарные возвраты
            r0 = (h[6] % 12) if h[5] % 8 < 2 else cpu.dic[int.from_bytes(h[6:9], 'little') % len(cpu.dic)]
        if RETS:
            r0 = RETS[h[10] % len(RETS)] & M32
        ev.append(('call', V2C.get(t, b['name']), tuple(a)))
        # выходные стековые буферы: вызываемая пишет одинаковые (детерминированные) байты
        if True:
            for k, x in enumerate(args[:n]):
                if cpu.sp_min <= x <= SP0:
                    hb = hashlib.sha256(b'out:%08x:%08x:%d:%d' % (seed, t, ncall[t], k)).digest()
                    for i in range(8):
                        # не затирать сохранённые регистры/адреса возврата кадра (настоящая
                        # вызываемая пишет только свой буфер; 8 Б могли накрыть blink)
                        wa = (x + i) & ~3
                        wv = int.from_bytes(bytes(cpu.mem.get(wa + j, 0) for j in range(4)), 'little')
                        if wv in cpu.saved_markers or BASE <= wv < BASE + 0x20000:
                            continue
                        cpu.mem[x + i] = hb[i] if hb[8] & 1 else (hb[i] & 7 if i % 4 == 0 else 0)
                        cpu.stk_written.add(x + i)
        for addr, vals in POKE.get(V2C.get(t, b['name']), ()):
            if cpu.dic and h[9] & 3:              # словарный мир: побочный эффект вызываемой
                v = vals[h[10] % len(vals)]
                cpu.write(addr, list((v & M32).to_bytes(4, 'little')))
        return ('stub', r0, int.from_bytes(h[4:8], 'little'))

    c.call_hook = hook
    c.func_range = frange
    regs = {}
    for i in range(8):
        h = hashlib.sha256(b'arg:%08x:%d' % (seed, i)).digest()
        k = h[0] % 4
        v = int.from_bytes(h[1:5], 'little')
        regs[i] = [v & 7, 0x800000 + (v & 0x3ffc), v & 0xffff, v][k] if i < nargs else 0
        if i in ARGS and i < nargs:
            regs[i] = ARGS[i][v % len(ARGS[i])] & M32
    for i in range(13, 26):
        regs[i] = 0xc5c50000 | i             # маркеры callee-saved (узнаваемы в стеке)
    regs[25] = 0x800000 + 4 * (seed & 0xff)  # r25 — указатель кольца MAC-команд (глобальный)
    c.set_regs(regs)
    c.saved_markers = {0xc5c50000 | i for i in range(13, 25)} | {SENTINEL}
    err = None
    try:
        c.run(entry, stop=SENTINEL, max_steps=max_steps)
    except Exception as e:                    # noqa: BLE001
        err = '%s: %s' % (type(e).__name__, e)
    # события cpu (кроме его собственных 'call') + наши вызовы — в порядке появления
    out = []
    pcs = []
    tpc = getattr(c, 'tpc', [])
    ci = 0
    for k, e in enumerate(c.trace):
        n0 = len(out)
        if e[0] == 'call':
            if not deep or (ci < len(ev) and ev[ci][0] == 'icall'):
                out.append(ev[ci] if ci < len(ev) else e)
            ci += 1
        elif e[0] in ('lr', 'sr') and len(e) > 2 and e[1] == 0x0a:
            out.append(e[:-1] + (e[-1] & ~0xf00,))    # STATUS32: Z/N/C/V не сравниваем
        elif e[0] == 'flag':
            out.append(('flag', e[1] & ~0xf00) + tuple(e[2:]))
        elif e[0] in ('mmio', 'lr', 'sr', 'extreg', 'sleep'):
            out.append(e)
        if len(out) > n0:
            pcs.append(tpc[k] if k < len(tpc) else 0)
    ram = {a: v for a, v in c.mem.items()
           if (a not in c.ram_init or a in c.ram_written) and not (c.sp_min - 0x40 <= a < SP0 + 0x40)
           and not (BASE <= a < BASE + 0x20000) and not (0x800000 <= a < 0x800000 + len(c.vdata0) and c.vdata0[a - 0x800000] == v)}
    return dict(ev=out, pcs=pcs, ram=ram, r0=c.regs[0] & M32, err=err, exhausted=c.exhausted, pc=c.pc, steps=c.insns)


def compare(A, B, rtype, retval=True):
    if A['err'] and B['err']:
        return None                      # обе упали (мусорный указатель в мутированном мире) — непоказательно
    if A['err'] or B['err']:
        return ('error', A['err'], B['err'])
    n = min(len(A['ev']), len(B['ev']))
    for i in range(n):
        if A['ev'][i] != B['ev'][i]:
            return ('event', i, A['ev'][i], B['ev'][i], A['ev'][max(0, i - 3):i])
    if len(A['ev']) != len(B['ev']) and not (A['exhausted'] and B['exhausted']):
        return ('evcount', len(A['ev']), len(B['ev']), A['ev'][n:n + 3], B['ev'][n:n + 3])
    if A['exhausted'] or B['exhausted']:
        return None                      # лимит шагов: состояния частичные (сравнен общий префикс событий)
    if A['ram'] != B['ram']:
        ka = set(A['ram']) ^ set(B['ram'])
        kd = sorted(k for k in set(A['ram']) & set(B['ram']) if A['ram'][k] != B['ram'][k])
        return ('ram', [hex(x) for x in sorted(ka)[:8]], [(hex(k), A['ram'][k], B['ram'][k]) for k in kd[:8]])
    if rtype != 'void' and retval and A['r0'] != B['r0'] and not (A['exhausted'] or B['exhausted']):
        return ('ret', hex(A['r0']), hex(B['r0']))
    return None


def _call_mismatch(d):
    """Расхождение затрагивает вызовы (наличие/порядок) — кандидат на глубокую сверку."""
    if d[0] == 'event':
        return d[2][0] in ('call', 'icall') or d[3][0] in ('call', 'icall')
    if d[0] == 'evcount':
        return any(e[0] in ('call', 'icall') for e in list(d[3]) + list(d[4]))
    return d[0] == 'ram'


def check(fn, seeds=8, max_steps=200000, work=None):
    """Сверка: заглушки вызовов; при расхождении в вызовах (инлайн/разбиение на функции)
    — глубокая сверка (вызываемые vendor-функции исполняются в обоих образах)."""
    vb = CMAP.get(fn, (None,))[0]
    if vb is None:
        return dict(fn=fn, status='unmapped')
    own_work = work is None
    work = work or tempfile.mkdtemp(prefix='eq_')
    try:
        hcode, syms, own = build_hybrid(fn, work)
    except RuntimeError as e:
        return dict(fn=fn, status='nobuild', msg=str(e))
    finally:
        if own_work:
            shutil.rmtree(work, ignore_errors=True)
    nargs, rtype = CP.get(fn, (4, 'u32'))
    va, vsz = vb['addr'], vb['size']
    ha = syms.get(fn, va)
    hr = (ha, ha + (0x2000 if ha != va else vsz))
    res = dict(fn=fn, vaddr=hex(va), status='equal', diffs=[])
    dic, ninsn = func_consts(va, vsz)
    res['_cov'] = cov_holder = []
    FOCUS[va] = func_focus(va, vsz)
    cov = set()
    cov_holder.append(cov)
    deep_needed = False

    def dk(s):                                 # сид 0, 2, 4.. — исходный мир; 1, 3.. — словарный
        return dic if s % 2 else None
    for s in range(seeds):
        seed = 0x5eed0000 + s
        A = run_one(VCODE, va, (va, va + vsz), va, nargs, seed, max_steps, dic=dk(s), cov=cov)
        B = run_one(hcode, ha, hr, va, nargs, seed, max_steps, own=own, dic=dk(s))
        d = compare(A, B, rtype, RETVAL.get(va, True))
        res['cov'] = '%d%%' % (100 * len({p for p in cov if va <= p < va + vsz}) // max(1, ninsn))
        sa, sb = res.get('steps', (0, 0))
        res['steps'] = (sa + A.get('steps', 0), sb + B.get('steps', 0))   # своя цена (callee — заглушки)
        if d is not None:
            if _call_mismatch(d):
                deep_needed = True
                res['shallow'] = repr(d)[:300]
                break
            res['status'] = 'diff'
            res['diffs'].append(dict(seed=hex(seed), d=repr(d)[:600]))
            res['_ab'] = (A, B, d)
            return res
    if not deep_needed:
        return res
    for s in range(seeds):
        seed = 0x5eed0000 + s
        A = run_one(VCODE, va, (va, va + vsz), va, nargs, seed, max_steps * 5, deep=True, dic=dk(s), cov=cov)
        B = run_one(hcode, ha, hr, va, nargs, seed, max_steps * 5, own=own, deep=True, dic=dk(s))
        res['cov'] = '%d%%' % (100 * len({p for p in cov if va <= p < va + vsz}) // max(1, ninsn))
        d = compare(A, B, rtype, RETVAL.get(va, True))
        if d is not None:
            res['status'] = 'diff'
            res['diffs'].append(dict(seed=hex(seed), d='DEEP ' + repr(d)[:600]))
            res['_ab'] = (A, B, d)
            return res
    res['status'] = 'equal(deep)'
    return res


_NAMES = None


def _pcname(pc):
    """Имя vendor-блока по PC (ICCM, зеркало с 0); вне известных блоков — hex."""
    global _NAMES
    import bisect
    if _NAMES is None:
        p = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'ghidra', 'out', 'names.txt')
        _NAMES = sorted((int(l.split()[0], 16), l.split()[1]) for l in open(p))
    a = pc + BASE if pc < 0x20000 else pc
    k = bisect.bisect_right([x for x, _ in _NAMES], a) - 1
    return '%x(%s+%x)' % (a, _NAMES[k][1], a - _NAMES[k][0]) if k >= 0 else '%x' % a


def _check_star(x):
    try:
        return check(*x)
    except Exception as ex:                    # noqa: BLE001
        return dict(fn=x[0], status='crash', msg=repr(ex)[:300])


def _steps_txt(r):
    """Отношение числа исполненных инструкций наш/vendor (только своя функция, callee — заглушки)."""
    sa, sb = r.get('steps', (0, 0))
    return '  x%.2f' % (sb / sa) if sa else ''


def _iter_print(it, fns, a):
    for fn, r in zip(fns, it):
        msg = '%-12s %5s' % (r['status'], r.get('cov', '')) + _steps_txt(r) + ('' if r['status'] != 'diff' else '  ' + r['diffs'][0]['d'][:300])
        print('%-45s %s' % (fn, msg), flush=True)
        if getattr(a, 'trace', False) and r.get('_ab'):
            A, B, d = r['_ab']
            print('    seed %s, r0: vendor=%#x наш=%#x' % (r['diffs'][0]['seed'], A['r0'], B['r0']))
            k = d[1] if isinstance(d[1], int) else min(len(A['ev']), len(B['ev']))
            for i in range(max(0, k - 10), k + 4):
                x = A['ev'][i] if i < len(A['ev']) else None
                y = B['ev'][i] if i < len(B['ev']) else None
                print('    %3d %s %-62s | %s' % (i, '  ' if x == y else '!!', str(x)[:62], str(y)[:62]))
                if x != y and i == k:
                    pa = A.get('pcs', []); pb = B.get('pcs', [])
                    print('        PC: vendor %s | наш %s' % (_pcname(pa[i] if i < len(pa) else 0),
                                                         _pcname(pb[i] if i < len(pb) else 0)))
            if d[0] == 'ram':
                print('    ram:', d[1][:8], d[2][:8])
        r.pop('_cov', None)
        r.pop('_ab', None)
        yield r


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('fns', nargs='*')
    ap.add_argument('--all', action='store_true')
    ap.add_argument('--seeds', type=int, default=24)
    ap.add_argument('--json')
    ap.add_argument('--jobs', type=int, default=1)
    ap.add_argument('--poke', default='', help='fn:0xADDR=v1|v2;fn2:... — запись после заглушенного вызова fn')
    ap.add_argument('--trace', action='store_true', help='окно событий вокруг первого расхождения')
    ap.add_argument('--uncov', action='store_true', help='напечатать непокрытые диапазоны vendor-кода')
    ap.add_argument('--args', default='', help='r0=0|1|2,r1=0..7 — значения аргументов (иначе случайные)')
    ap.add_argument('--rets', default='', help='0|1|0x500 — возвраты заглушек вызываемых (иначе случайные)')
    ap.add_argument('--bias', default='', help='r38=0x20000800|0x800,r36=0,0x8837b0=2 — направленные значения чтений')
    ap.add_argument('--vdata', default='', help='glob живых снимков uc_data (tools/hwsnap.sh), seed %% N')
    a = ap.parse_args()
    uh.fresh_snapshot()          # код фиксируется на старте: сборка с нуля во временный каталог
    import glob as _g
    VSNAPS.extend(open(f, 'rb').read() for f in sorted(_g.glob(a.vdata)) if a.vdata)
    def _vals(v):
        if '..' in v:
            lo, hi = (int(x, 0) for x in v.split('..'))
            return list(range(lo, hi + 1))
        return [int(x, 0) for x in v.split('|')]
    for it in filter(None, a.args.split(',')):
        k, v = it.split('=')
        ARGS[int(k.lstrip('r'))] = _vals(v)
    RETS.extend(_vals(a.rets) if a.rets else [])
    for it in filter(None, a.bias.split(',')):
        k, v = it.split('=')
        addr = 0xEE000000 + int(k[1:]) if k.startswith('r') else int(k, 0)
        BIAS[addr] = [int(x, 0) for x in v.split('|')]
    for it in filter(None, a.poke.split(';')):
        fn_, rest = it.split(':', 1)
        ad, v = rest.split('=')
        POKE.setdefault(fn_, []).append((int(ad, 0), [int(x, 0) for x in v.split('|')]))
    fns = a.fns
    if a.all:
        fns = sorted(n for n, (vb, f) in CMAP.items() if vb and V2C.get(vb['addr']) == n)   # без дублей
    out = []
    if a.jobs > 1:
        import multiprocessing as mp
        with mp.get_context('fork').Pool(a.jobs) as pool:
            it = pool.imap(_check_star, [(fn, a.seeds) for fn in fns])
            results = list(_iter_print(it, fns, a))
        out = results
    for fn in ([] if a.jobs > 1 else fns):
        r = check(fn, a.seeds)
        out.append(r)
        msg = '%-12s %5s' % (r['status'], r.get('cov', '')) + _steps_txt(r) + ('' if r['status'] != 'diff' else '  ' + r['diffs'][0]['d'][:300])
        print('%-45s %s' % (fn, msg), flush=True)
        if a.uncov and r.get('_cov'):
            vb = CMAP[fn][0]
            d = subprocess.run([uh.OD, '-d', '--start-address=%d' % vb['addr'],
                                '--stop-address=%d' % (vb['addr'] + vb['size']), uh.VELF],
                               capture_output=True, text=True).stdout
            pcs = [int(m.group(1), 16) for m in re.finditer(r'^\s+([0-9a-f]+):', d, re.M)]
            cv = r['_cov'][0]
            run = None
            for pc in pcs + [None]:
                if pc is not None and pc not in cv:
                    run = run or [pc, pc]
                    run[1] = pc
                elif run:
                    print('    не покрыто: %06x..%06x' % tuple(run))
                    run = None
        if getattr(a, 'trace', False) and r.get('_ab'):
            A, B, d = r['_ab']
            print('    seed %s, r0: vendor=%#x наш=%#x' % (r['diffs'][0]['seed'], A['r0'], B['r0']))
            k = d[1] if isinstance(d[1], int) else min(len(A['ev']), len(B['ev']))
            for i in range(max(0, k - 10), k + 4):
                x = A['ev'][i] if i < len(A['ev']) else None
                y = B['ev'][i] if i < len(B['ev']) else None
                print('    %3d %s %-62s | %s' % (i, '  ' if x == y else '!!', str(x)[:62], str(y)[:62]))
                if x != y and i == k:
                    pa = A.get('pcs', []); pb = B.get('pcs', [])
                    print('        PC: vendor %s | наш %s' % (_pcname(pa[i] if i < len(pa) else 0),
                                                         _pcname(pb[i] if i < len(pb) else 0)))
            if d[0] == 'ram':
                print('    ram:', d[1][:8], d[2][:8])
        r.pop('_cov', None)
        r.pop('_ab', None)
    if a.json:
        json.dump(out, open(a.json, 'w'), indent=1)
    c = collections.Counter(r['status'] for r in out)
    print('ИТОГО:', dict(c))


if __name__ == '__main__':
    main()
