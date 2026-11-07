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
SP0 = 0x804000                  # вершина стека uc (uc/uc.ld __stack_top)
GP = 0x800528
MAC_CMD_LOG = 0x800000          # r25 (uc/uc.ld mac_cmd_log)
DCCM, DCCM_SIZE = 0x800000, 0x8000
FW_PERI = 0x840000              # память fw, общая с uc (debugfs blob_fw_peri — её снимок)
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
            # COUNT1 (Timer1, 165 МГц) идёт: такт на инструкцию от начала теста (с моделью железа machw — её часы),
            # заворот на пределе. Цикл, читающий Timer1, ограничен сроком — счётчик «вечного ожидания» сбрасывается.
            self._o._spin = {}
            if self._o.t1_hook:
                return self._o.t1_hook()
            return (self._o.t1_base + self.insns) % (T1_LIMIT + 1)
        return super().read_aux(addr)

    def _counting(self, key):
        """Опрос в одной точке, но регистры ядра между проверками меняются (счётчик проходов — ожидание с пределом,
        uc_spin_until_event_tmo, ожидание BAP в rx_get_required_response): не вечное ожидание. Снимок r0..r24 — на
        середине счёта (SPIN_MAX / 2), сверка — на пределе; совпал — регистры стоят, это зависание."""
        return self._o._spin_regs.get(key) != tuple(self.regs[:25])

    def _spin_note(self, key, sp):
        if sp == SPIN_MAX // 2:
            self._o._spin_regs[key] = tuple(self.regs[:25])

    def read_reg(self, n):
        if 32 <= n <= 56:
            o = self._o
            if o.ext_hook:
                v = o.ext_hook(n)
                if v is not None:
                    key = (self.pc, n)
                    if o._spin_val.get(key) != v:             # значение порта меняется (TSF, счётчики) — не зависание
                        o._spin_val[key] = v
                        o._spin = {}
                    sp = o._spin[key] = o._spin.get(key, 0) + 1
                    self._spin_note(key, sp)
                    if sp > SPIN_MAX and self._counting(key):
                        o._spin[key] = 0                      # ожидание с пределом (счётчик проходов) — не зависание
                    elif sp > SPIN_MAX:
                        # опрос в одной точке: если железо ещё что-то сделает — продвинуть часы к событию
                        if o.hw.advance_to_next():
                            o._spin[key] = 0
                            v = o.ext_hook(n)
                        else:
                            raise SpinError('опрос r%d без выхода в %s (значение %#x): железо больше ничего не сделает'
                                            % (n, o.where(self.pc), v))
                    v &= M32
                    self.trace.append(('extreg', 'r', n, 4, v))
                    return v
            key = (self.pc, n)
            sp = self._o._spin[key] = self._o._spin.get(key, 0) + 1
            self._spin_note(key, sp)
            if sp > SPIN_MAX and self._counting(key):
                self._o._spin[key] = 0
            elif sp > SPIN_MAX:
                raise SpinError('опрос r%d без выхода в %s (значение %#x): задайте uc.ext[%d] или заглушку'
                                % (n, self._o.where(self.pc), self._o._val(n), n))
            k = self._o._ext_reads.get(n, 0)
            self._o._ext_reads[n] = k + 1
            src = self._o.ext.get(n, 0)
            v = (src(n, k) if callable(src) else src) & M32
            self.trace.append(('extreg', 'r', n, 4, v))
            return v
        return super().read_reg(n)

    def write_reg(self, n, v):
        super().write_reg(n, v)
        if n == 32 and self._o.cmd_hook:
            self._o.cmd_hook(v & M32)
        elif n in (33, 34) and self._o.fifo_hook:
            self._o.fifo_hook(n, v & M32)


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
        self.elf = elf
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
        self._spin_val = {}
        self._spin_regs = {}           # снимок регистров ядра на проверке опроса (_CPU._counting)
        self.t1_base = 0               # COUNT1 в начале теста (задать, чтобы проверить заворот)
        self._ext_reads = {}
        self.calls = []
        self.hw = None                 # модель MAC во времени (machw.HW) — подключает себя сама
        self.ext_hook = None
        self.fifo_hook = None                     # (n, v): запись порта FIFO передачи r33 (слово) / r34 (байт)
        self.cmd_hook = None
        self.t1_hook = None

    @classmethod
    def from_snapshot(cls, elf, uc_data, fw_peri=None):
        """Эмулятор в состоянии стенда: uc_data — снимок DCCM uc (debugfs blob_uc_data), fw_peri — снимок памяти fw с
        FW_PERI (blob_fw_peri), оба сняты с uc из того же elf. Без fw_peri память fw — детерминированный мусор
        эмулятора, и путь кода, читающий её (кольца ящика, link_stat …), уходит в сторону. Модель MAC — HW(u,
        mailbox=False): иначе её инициализация ящика затрёт кольца снимка (0x85f000)."""
        u = cls(elf)
        u.cpu.load(DCCM, bytes(uc_data))
        if fw_peri is not None:
            u.cpu.load(FW_PERI, bytes(fw_peri))
        return u

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
        rep = os.environ.get('SPARRAW_STACK_REPORT')
        if rep:
            # глубина стека по функциям (SP0 − минимальный sp) — для бюджета стека при вложенном L1
            # и участки с запрещёнными L1 (STATUS32.E1 = 0, снятым кодом): вызов стартует с E1 = 1, как в работе
            orig, low = c.step, [SP0]
            c.aux[0x0a] = c.aux.get(0x0a, 0) | 2
            mask = dict(start=None, pc=0, worst=0, wpc=0)

            def step():
                pc = c.pc
                orig()
                if c.sp < low[0]:
                    low[0] = c.sp
                e1 = c.aux.get(0x0a, 0) & 2
                if not e1 and mask['start'] is None:
                    mask['start'], mask['pc'] = c.insns, pc
                elif e1 and mask['start'] is not None:
                    n = c.insns - mask['start']
                    if n > mask['worst']:
                        mask['worst'], mask['wpc'] = n, mask['pc']
                    mask['start'] = None
            c.step = step
            try:
                c.run(self.sym[fn], stop=SENTINEL, max_steps=max_steps)
            finally:
                c.step = orig
                if mask['start'] is not None:                    # не восстановлен до возврата
                    n = c.insns - mask['start']
                    if n > mask['worst']:
                        mask['worst'], mask['wpc'] = n, mask['pc']
                with open(rep, 'a') as fh:
                    fh.write('%s %d %s %d %s\n' % (fn, SP0 - low[0], os.environ.get('PYTEST_CURRENT_TEST', '').split(' ')[0],
                                                   mask['worst'], self.where(mask['wpc']) if mask['worst'] else '-'))
        else:
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
        if self.t1_hook:
            return self.t1_hook()
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
