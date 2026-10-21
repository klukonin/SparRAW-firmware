"""rx_flow_handle_frame: путь до ответа ACK/BA (ХРУПКО, uc/rx.c rx_frame_tx_resp_seq).
Статистика: инструкций (и взятых переходов) от входа rx_flow_handle_frame до команды 0x37000020,
vendor vs наш, по многим сидам; RETS перебираются случайно из списка.  usage: resp_lat.py [nseeds] [rets,..]; STOPVAL=0x19000001 — другая конечная команда"""
import sys, os, importlib.util, tempfile, statistics, collections
R = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, R)
spec = importlib.util.spec_from_file_location('eq', R + '/eqcheck.py'); eq = importlib.util.module_from_spec(spec); spec.loader.exec_module(eq)
N = int(sys.argv[1]) if len(sys.argv) > 1 else 60
RL = [int(x) for x in (sys.argv[2] if len(sys.argv) > 2 else '0,1,2,3').split(',')]
orig = eq.EqCPU.step
def step(self):
    if getattr(self, 'hit', None): return orig(self)
    k = len(self.trace); pc0 = self.pc; r = orig(self)
    lp = getattr(self, 'lpc', None)
    if lp is not None and not (lp < pc0 <= lp + 8): self.tk = getattr(self, 'tk', 0) + 1
    self.lpc = pc0
    for t in self.trace[k:]:
        if t[:3] == ('extreg', 'w', 32) and t[-1] == int(os.environ.get('STOPVAL', '0x37000020'), 0):
            self.hit = (self.insns, getattr(self, 'tk', 0))
    return r
eq.EqCPU.step = step
seen = {}
om = eq.make_cpu
def mk(*a, **kw):
    c = om(*a, **kw); seen['c'] = c; return c
eq.make_cpu = mk
eq.uh.fresh_snapshot()
fn = 'rx_flow_handle_frame'
vb = eq.CMAP[fn][0]; va, vsz = vb['addr'], vb['size']
hcode, syms, own = eq.build_hybrid(fn, tempfile.mkdtemp())
ha = syms.get(fn, va); hr = (ha, ha + (0x2000 if ha != va else vsz))
for k, v in [('r36', [0]), ('r38', [0x20000800]), ('r39', [0]), ('0x801424', [1])]:
    eq.BIAS[0xEE000000 + int(k[1:]) if k.startswith('r') else int(k, 0)] = v
eq.RETS[:] = RL
d = []; dt = []; va_ = []; mism = 0
for s in range(N):
    seed = 0x5eed1000 + s
    eq.run_one(eq.VCODE, va, (va, va + vsz), va, 1, seed, 200000); ca = seen['c']
    eq.run_one(hcode, ha, hr, va, 1, seed, 200000, own=own); cb = seen['c']
    a = getattr(ca, 'hit', None); b = getattr(cb, 'hit', None)
    if bool(a) != bool(b): mism += 1; continue
    if a:
        d.append(b[0] - a[0]); dt.append(b[1] - a[1]); va_.append(a[0])
if d:
    print('путей до 0x37000020: %d (из %d, расхождений достижимости %d)' % (len(d), N, mism))
    print('vendor инстр: мин %d мед %d макс %d' % (min(va_), statistics.median(va_), max(va_)))
    print('наш - vendor, инстр: мин %+d мед %+d макс %+d' % (min(d), statistics.median(d), max(d)))
    print('наш - vendor, взятых переходов: мин %+d мед %+d макс %+d' % (min(dt), statistics.median(dt), max(dt)))
    print('распределение разницы:', sorted(collections.Counter(d).items()))
else:
    print('нет путей до 0x37000020', mism)
