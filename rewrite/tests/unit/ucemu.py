# SPDX-License-Identifier: AGPL-3.0-or-later
"""Обвязка юнит-тестов uc: функция из build/uc.elf исполняется в эмуляторе ARC (tools/arcemu/cpu.py).

    uc = UC(elf)                        # код + начальные данные DCCM из ELF, свежий «мир» на каждый тест
    uc.w8(0x800878, 4); uc.w32(...)     # подготовить состояние DCCM
    uc.ext[45] = 1 << 31                # значение чтения r32..r56 (порты MAC); callable(n, k) — по номеру чтения k
    r0 = uc.call('brp_init_tx_request', stub={'uc_spin_until_event': 0})
    uc.mac_cmds                         # записи в r32 (uc_mac_cmd) по порядку
    uc.calls                            # [(имя, (r0..r3))] — вызовы заглушек

Заглушка не исполняет вызываемую функцию (возврат — заданный r0), остальные вызовы исполняются.
MMIO — функциональный регистровый файл (запись видна последующему чтению), неинициализированное чтение = 0.
"""
import os, re, struct, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))
REW = os.path.dirname(os.path.dirname(HERE))
sys.path.insert(0, os.path.join(REW, 'tools', 'arcemu'))
import cpu as cpumod                                    # noqa: E402

M32 = 0xffffffff
ICCM = 0x920000                 # код uc виден и с 0, и с 0x920000
SENTINEL = 0x9ff000             # адрес возврата из тестируемой функции
SP0 = 0x803a48                  # вершина стека uc (как в eqcheck)
GP = 0x800528
MAC_CMD_LOG = 0x800000          # r25 (uc/uc.ld mac_cmd_log)
DCCM, DCCM_SIZE = 0x800000, 0x8000
UC_DATA_HOST = 0x940000         # uc_data в .fw (вид хоста) = DCCM 0x800000


def _sections(path):
    """[(name, addr, data)] — секции PROGBITS с флагом ALLOC."""
    b = open(path, 'rb').read()
    shoff, = struct.unpack_from('<I', b, 0x20)
    shentsize, shnum, shstrndx = struct.unpack_from('<HHH', b, 0x2e)
    sh = [struct.unpack_from('<IIIIIIIIII', b, shoff + i * shentsize) for i in range(shnum)]
    stro = sh[shstrndx][4]
    out = []
    for name, typ, flags, addr, off, size, *_ in sh:
        if typ == 1 and flags & 2 and size:            # SHT_PROGBITS, SHF_ALLOC
            n = b[stro + name:b.index(b'\0', stro + name)].decode()
            out.append((n, addr, b[off:off + size]))
    return out


def _symbols(path):
    out = subprocess.run([cpumod.TC + '/arc-elf32-nm', path], capture_output=True, text=True, check=True).stdout
    sym = {}
    for l in out.splitlines():
        p = l.split()
        if len(p) == 3 and p[1] in 'tTwW':
            sym[p[2]] = int(p[0], 16)
    return sym


SPIN_MAX = 2000                 # чтений одного r32..r56 в одной точке — считается вечным ожиданием


class SpinError(RuntimeError):
    pass


T1_LIMIT = 0x13ab6680           # предел Timer1 (uc_timer_start(1, 0, 0x13ab6680, …), uc/mac.c, uc/boot.c)


class _CPU(cpumod.CPU):
    def __init__(self, owner, **k):
        super().__init__(**k)
        self._o = owner

    def read_aux(self, addr):
        if (addr & M32) == 0x100:
            # COUNT1 (Timer1, 165 МГц) идёт: такт на инструкцию от начала теста, заворот на пределе. Цикл, читающий
            # Timer1, ограничен сроком — счётчик «вечного ожидания» для него сбрасывается.
            self._o._spin = {}
            return (self._o.t1_base + self.insns) % (T1_LIMIT + 1)
        return super().read_aux(addr)

    def read_reg(self, n):
        if 32 <= n <= 56:
            key = (self.pc, n)
            sp = self._o._spin[key] = self._o._spin.get(key, 0) + 1
            if sp > SPIN_MAX:
                raise SpinError('опрос r%d без выхода в %s (значение %#x): задайте uc.ext[%d] или заглушку'
                                % (n, self._o.where(self.pc), self._o._val(n), n))
            k = self._o._ext_reads.get(n, 0)
            self._o._ext_reads[n] = k + 1
            src = self._o.ext.get(n, 0)
            v = (src(n, k) if callable(src) else src) & M32
            self.trace.append(('extreg', 'r', n, 4, v))
            return v
        return super().read_reg(n)


class UC:
    _cache = {}
    _decoded = {}

    def __init__(self, elf, fw=None):
        """elf — uc.elf (код); fw — .fw с этим uc (build_fw.py --uc-elf): начальная DCCM — его uc_data, как на железе
        после загрузки. Без fw — DCCM = 0 плюс секции .ucdata из ELF."""
        if (elf, fw) not in UC._cache:
            dccm = bytearray(DCCM_SIZE)
            if fw:
                for host, data in cpumod.parse_fw(open(fw, 'rb').read()):
                    if UC_DATA_HOST <= host < UC_DATA_HOST + DCCM_SIZE:
                        o = host - UC_DATA_HOST
                        dccm[o:o + len(data)] = data[:DCCM_SIZE - o]
            UC._cache[(elf, fw)] = (_sections(elf), _symbols(elf), bytes(dccm))
        secs, self.sym, dccm = UC._cache[(elf, fw)]
        self.addr2sym = {a: n for n, a in self.sym.items()}
        c = _CPU(self, functional_mmio=True)
        c.mmio(0x880000, 0x8c0000)
        c.load(DCCM, dccm)
        for name, addr, data in secs:
            if fw and name.startswith('.ucdata'):
                continue                                # уже в uc_data образа (с перенаправленными указателями)
            code = name in ('.vectors', '.text') or name.startswith('.text')
            c.load(addr, data, is_code=code)
        c.alias = [(ICCM, ICCM + 0x20000, 0)]
        # кэш декодирования (objdump всего кода, ~0,5 с) — общий для всех эмуляторов одного ELF: код не меняется,
        # Instr после декодирования не изменяются
        c._instr = UC._decoded.setdefault(elf, {})
        self.cpu = c
        # r32..r56 по умолчанию — MAC свободен: все циклы опроса готовности в uc выходят сразу
        # (r40: б24 = 1, б3 = 0, поле 0..2 = 5; r45 б31 = 1). События приёма (r42, r54 …) тест задаёт сам.
        self.ext = {40: (1 << 24) | 5, 45: 1 << 31}
        self._spin = {}
        self.t1_base = 0               # COUNT1 в начале теста (задать, чтобы проверить заворот)
        self._ext_reads = {}
        self.calls = []

    # ---- память ----
    def r8(self, a): return self.cpu.read(a, 1)
    def r16(self, a): return self.cpu.read(a, 2)
    def r32(self, a): return self.cpu.read(a, 4)
    def w8(self, a, v): self.cpu.write(a, bytes([v & 0xff]))
    def w16(self, a, v): self.cpu.write(a, struct.pack('<H', v & 0xffff))
    def w32(self, a, v): self.cpu.write(a, struct.pack('<I', v & M32))
    def rbytes(self, a, n): return bytes(self.cpu.read(a + i, 1) for i in range(n))
    def wbytes(self, a, data): self.cpu.write(a, bytes(data)) if len(data) <= 4 else [self.cpu.write(a + i, bytes([x])) for i, x in enumerate(data)]

    # ---- вызов ----
    def call(self, fn, *args, stub=None, max_steps=2_000_000):
        """Исполнить fn(args) до возврата. stub: {имя: r0} — не исполнять, вернуть r0 (None → 0)."""
        stub = dict(stub or {})
        bad = [n for n in stub if n not in self.sym]
        if bad:
            raise KeyError('нет символов в uc.elf: %s' % bad)
        stub_at = {self.sym[n] & 0x1ffff: (n, v) for n, v in stub.items()}
        c = self.cpu
        start = len(c.trace)

        def hook(cpu, target, is_tail, a):
            t = target & 0x1ffff
            if t in stub_at:
                n, v = stub_at[t]
                self.calls.append((n, tuple(cpu.regs[i] & M32 for i in range(4))))
                return ('stub', 0 if v is None else v, 0)
            return None
        c.call_hook = hook
        c.set_regs({i: a for i, a in enumerate(args)})
        c.sp = SP0
        c.regs[26] = GP
        c.regs[25] = MAC_CMD_LOG                       # uc/start.S: кольцо журнала команд MAC
        c.blink = SENTINEL
        c.halted = False
        self._spin = {}
        c.run(self.sym[fn], stop=SENTINEL, max_steps=max_steps)
        if c.exhausted:
            raise RuntimeError('%s: не вернулась за %d шагов (pc=%#x в %s)' % (fn, max_steps, c.pc, self.where(c.pc)))
        self.last_trace = c.trace[start:]
        return c.regs[0] & M32

    def _val(self, n):
        src = self.ext.get(n, 0)
        return src(n, self._ext_reads.get(n, 0)) if callable(src) else src

    def where(self, pc):
        pc &= 0x1ffff
        best = max(((a & 0x1ffff, n) for n, a in self.sym.items() if (a & 0x1ffff) <= pc), default=(0, '?'))
        return '%s+%#x' % (best[1], pc - best[0])

    def t1(self):
        """Текущее значение COUNT1 эмулятора (такты)."""
        return (self.t1_base + self.cpu.insns) % (T1_LIMIT + 1)

    @property
    def mac_cmds(self):
        """Команды MAC (uc_mac_cmd = запись в r32) за последний вызов."""
        return [e[4] for e in self.last_trace if e[0] == 'extreg' and e[1] == 'w' and e[2] == 32]


_DEF = re.compile(r'^#define\s+(\w+)\s+\(\*\((?:volatile\s+)?(?:struct\s+)?(\w+)\s*\*\)\s*(0x[0-9a-fA-F]+)\)')
_DEFP = re.compile(r'^#define\s+(\w+)\s+\(\((?:volatile\s+)?struct\s+(\w+)\s*\*\)\s*(0x[0-9a-fA-F]+)\)')


def dccm_addrs(dccm_h):
    """Имя → адрес для #define из uc/dccm.h (переменные и массивы структур)."""
    out = {}
    for l in open(dccm_h):
        m = _DEF.match(l) or _DEFP.match(l)
        if m:
            out[m.group(1)] = int(m.group(3), 16)
    return out
