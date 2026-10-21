"""Латентность участка функции uc, vendor против нашего (гибрид: заменена FN; uc_hybrid PAIRS).
usage: [env] seg_lat.py [nseeds] [rets,..]
  FN=rx_flow_run          функция
  START=4,6,7             отсчёт с первой записи r32 с таким значением (по умолчанию — со входа)
  STOP=0x37000020 | ret   до записи r32 с этим значением или до возврата (ret: пути без 0x37000020)
  DEEP=1                  исполнять вызываемые vendor-функции (без него заглушки; встроенные у нас
                          функции против заглушки у vendor дают разные пути — сравнение ложное)
  BIAS="r40:4,6,7 0x800528:1"   смещённые чтения регистров/слов DCCM;  ARGS="0:0x802978" — аргументы
  NEED=0x37000005         только пути, где у обоих есть такие команды MAC;  NARGS — число аргументов
  BYTES=1                 ещё и выбранные байты кода (8-байтовые limm — лишний такт выборки)
  V=1                     по сидам: команды MAC и вызовы
Печатает разницу инструкций, взятых переходов (и байт) наш − vendor."""
import sys, os, importlib.util, tempfile, statistics, collections
R = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, R)
spec = importlib.util.spec_from_file_location('eq', R + '/eqcheck.py'); eq = importlib.util.module_from_spec(spec); spec.loader.exec_module(eq)
N = int(sys.argv[1]) if len(sys.argv) > 1 else 60
RL = [int(x, 0) for x in (sys.argv[2] if len(sys.argv) > 2 else '0,1,2,3').split(',')]
FN = os.environ.get('FN', 'rx_flow_run')
STOP_S = os.environ.get('STOP', '0x37000020')
STOP = -1 if STOP_S == 'ret' else int(STOP_S, 0)   # ret — до возврата из функции, без записи 0x37000020
START = [int(x, 0) for x in os.environ['START'].split(',')] if os.environ.get('START') else None
BYTES = bool(os.environ.get('BYTES'))  # считать и выбранные байты кода (8-байтовые limm-инструкции — лишний такт выборки)
NEED = [int(x, 0) for x in os.environ.get('NEED', '').split(',') if x]
DEEP = bool(os.environ.get('DEEP'))   # исполнять вызываемые vendor-функции (иначе заглушки: встроенные у нас
                                      # функции дают другой путь, чем заглушка у vendor — сравнение ложное)
orig = eq.EqCPU.step
def step(self):
    if getattr(self, 'hit', None): return orig(self)
    k = len(self.trace); pc0 = self.pc
    if BYTES and getattr(self, 't0', None) is not None or BYTES and START is None:
        if not getattr(self, 'hit', None): self.pcl = getattr(self, 'pcl', []); self.pcl.append(pc0)
    r = orig(self)
    lp = getattr(self, 'lpc', None)
    if lp is not None and not (lp < pc0 <= lp + 8) and getattr(self, 't0', None) is not None or (START is None and lp is not None and not (lp < pc0 <= lp + 8)):
        self.tk = getattr(self, 'tk', 0) + 1     # взятый переход (PC не следующий): ~+1..2 такта на ARC
    self.lpc = pc0
    for t in self.trace[k:]:
        if t[:3] == ('extreg', 'w', 32):
            if START is not None and getattr(self, 't0', None) is None and t[-1] in START:
                self.t0 = self.insns
            if t[-1] == STOP and (START is None or getattr(self, 't0', None) is not None):
                self.hit = self.insns - (getattr(self, 't0', 0) or 0); self.hit_tk = getattr(self, 'tk', 0)
    return r
eq.EqCPU.step = step
seen = {}
om = eq.make_cpu
def mk(*a, **kw):
    c = om(*a, **kw); seen['c'] = c; return c
eq.make_cpu = mk
eq.uh.fresh_snapshot()
vb = eq.CMAP[FN][0]; va, vsz = vb['addr'], vb['size']
WD = tempfile.mkdtemp(); hcode, syms, own = eq.build_hybrid(FN, WD)
NA = int(os.environ['NARGS']) if os.environ.get('NARGS') else eq.arity(va)   # число аргументов (по умолчанию — арность vendor)
ha = syms.get(FN, va); hr = (ha, ha + (0x4000 if ha != va else vsz))
for kv in os.environ.get('BIAS', '').split():
    k, v = kv.split(':'); vals = [int(x, 0) for x in v.split(',')]
    eq.BIAS[0xEE000000 + int(k[1:]) if k.startswith('r') else int(k, 0)] = vals
eq.RETS[:] = RL
for kv in os.environ.get('ARGS', '').split():   # ARGS="0:0x802978" — значения аргументов (иначе случайные)
    k, v = kv.split(':'); eq.ARGS[int(k)] = [int(x, 0) for x in v.split(',')]
import re, subprocess
def isz(elf, args=()):
    m = {}
    for l in subprocess.run([eq.uh.OD, '-d', *args, elf], capture_output=True, text=True).stdout.splitlines():
        mm = re.match(r'\s*([0-9a-f]+):\s+((?:[0-9a-f]{4} ?)+)\s', l)
        if mm: m[int(mm.group(1), 16)] = 2 * len(mm.group(2).split())
    return m
if BYTES:
    VSZ = isz(eq.uh.VELF); HSZ = isz(os.path.join(WD, 'hy', 'hy.elf'))
def nbytes(c, m):
    def one(p):
        q = p if p >= 0x20000 else p + 0x920000
        for t in (m, VSZ):
            if q in t: return t[q]
            if p in t: return t[p]
        raise KeyError(hex(p))
    return sum(one(p) for p in getattr(c, 'pcl', []))
db = []
d = []; va_ = []; vb_ = []; dtk = []; mism = 0
for s in range(N):
    seed = 0x5eed1000 + s
    eq.run_one(eq.VCODE, va, (va, va + vsz), va, NA, seed, 400000, deep=DEEP); ca = seen['c']
    eq.run_one(hcode, ha, hr, va, NA, seed, 400000, own=own, deep=DEEP); cb = seen['c']
    if STOP == -1:
        no = lambda c: not any(t[:3] == ('extreg', 'w', 32) and t[-1] == 0x37000020 for t in c.trace)
        ca.hit = ca.insns if no(ca) else None; cb.hit = cb.insns if no(cb) else None
        ca.hit_tk = getattr(ca, 'tk', 0); cb.hit_tk = getattr(cb, 'tk', 0)
    a = getattr(ca, 'hit', None); b = getattr(cb, 'hit', None)
    if NEED:                                   # NEED=0x37000005 — только пути с такой командой MAC у обоих
        has = lambda c: all(any(t[:3] == ('extreg', 'w', 32) and t[-1] == x for t in c.trace) for x in NEED)
        if not (has(ca) and has(cb)): continue
    if bool(a) != bool(b): mism += 1; continue
    if a:
        d.append(b - a); va_.append(a); vb_.append(b); dtk.append(cb.hit_tk - ca.hit_tk)
        if BYTES: db.append(nbytes(cb, HSZ) - nbytes(ca, VSZ))
        if os.environ.get('V'):
            cm = lambda c: ' '.join('%x' % t[-1] for t in c.trace if t[:3] == ('extreg', 'w', 32))
            fc = lambda c: ' '.join(sorted({'%x' % t[1] for t in c.trace if t[0] == 'call'}))
            print('seed %d: v %d наш %d (%+d) | cmd %s | calls %s' % (s, a, b, b - a, cm(ca)[:200], fc(ca)[:200]))
print('%s: старт %s, путей до %s: %d из %d (расхождений достижимости %d)' % (FN, os.environ.get('START', 'вход'), STOP_S, len(d), N, mism))
if d:
    print('vendor инстр: мин %d мед %d макс %d' % (min(va_), statistics.median(va_), max(va_)))
    print('наш    инстр: мин %d мед %d макс %d' % (min(vb_), statistics.median(vb_), max(vb_)))
    print('наш - vendor: мин %+d мед %+d макс %+d' % (min(d), statistics.median(d), max(d)))
    print('распределение:', sorted(collections.Counter(d).items()))
    print('взятых переходов, наш - vendor: мин %+d мед %+d макс %+d' % (min(dtk), statistics.median(dtk), max(dtk)))
    if BYTES: print('байт кода, наш - vendor: мин %+d мед %+d макс %+d' % (min(db), statistics.median(db), max(db)))
