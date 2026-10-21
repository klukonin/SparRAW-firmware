# SPDX-License-Identifier: AGPL-3.0-or-later
"""Эмулятор ARCompact (ARC600) для дифференциальной проверки функций uc.

Декодирование — через objdump (binutils знает ARC600 точно); здесь только
семантика. Память разреженная; обращения к MMIO, расширенным core-регистрам
(r32..r56) и aux-регистрам — события трассы. Неинициализированная память и
значения чтений MMIO детерминированы (seed), поэтому два прогона (vendor и наш
код) на одном seed видят одинаковый «мир».

Использование (дифференциальная проверка функции):
    cpu = CPU(seed=0x5eed)
    cpu.load(0x920000, vendor_code_bytes, is_code=True)  # код (ICCM)
    cpu.load(0x800000, data_bytes)                        # данные (DCCM)
    cpu.mmio(0x880000, 0x10000)                           # MMIO-регион (MAC)
    cpu.set_regs({0: arg0, 1: arg1})                      # аргументы (r0, r1)
    cpu.sp = 0x803a48                                     # стек
    cpu.blink = 0x9aaaaa                                  # адрес возврата
    cpu.run(0x920000, stop=0x9aaaaa)                      # выполнить функцию
    trace = cpu.trace                                    # события для сравнения

Интерфейс для пофункциональной сверки (vendor vs наш код):
    cpu.func_range = (lo, hi)          # диапазон функции (детект хвостовых вызовов)
    cpu.alias = [(0, 0x20000, 0x920000)]  # две проекции ICCM (код и с 0, и с базы)
    cpu.call_hook = hook               # перехват вызовов (см. ниже)
    # hook(cpu, target, is_tail, args) -> None («исполнять») или
    # ('stub', r0, r1) — записать вызов, вернуть r0/r1, не исполнять callee.
    # Подпрограммы сохранения регистров и libgcc-millicode возвращают None (исполнять).
    cpu.run(entry, stop=blink_sentinel, max_steps=N)   # стоп по возврату + лимит
    cpu.trace   # ('mmio', r/w, addr, size, val) | ('lr'/'sr', addr, val) |
                # ('flag', val) | ('sleep',) | ('sync',) | ('extreg', w, n, val) |
                # ('call', target, stub_r0) — по порядку
    cpu.mem     # итоговый срез DCCM (записи сравниваются без учёта порядка)

Детерминизм: значения неинициализированной памяти/MMIO — f(seed, адрес, номер
чтения), поэтому vendor- и наш прогон при одинаковой последовательности чтений
видят одинаковый «мир».

Справочник ARC600: /home/evilwirelessman/Documents/WORK/60_GHZ/arc600-docs/
(ARCompactISA_PRM.txt — ISA, root__ARC600-REFERENCE.md — карта регистров/aux).
"""
import hashlib, os, re, shutil, subprocess, tempfile

M32 = 0xffffffff

TC = (os.environ['ARC_DIR'] + '/bin') if os.environ.get('ARC_DIR') else \
    os.path.abspath(os.path.join(os.path.dirname(__file__),
                                 '../../../../../toolchain/arc_gnu_2021.03_prebuilt_elf32_le_linux_install/bin'))
if not os.path.exists(TC + '/arc-elf32-objcopy'):   # из git worktree вне дерева: путь не найдётся молча
    raise SystemExit('нет тулчейна ARC в %s — задайте ARC_DIR' % TC)
OBJDUMP = TC + '/arc-elf32-objdump'
OBJCOPY = TC + '/arc-elf32-objcopy'
AS = TC + '/arc-elf32-as'
LD = TC + '/arc-elf32-ld'


# --------------------------------------------------------------------------- #
# Имена регистров и aux-регистров (как их печатает objdump / принимает gas).
# --------------------------------------------------------------------------- #

REGS = {}
for _i in range(64):
    REGS['r%d' % _i] = _i
REGS.update({
    # objdump печатает r29 как 'ilink', r30 как 'r30'; gas знает и 'ilink1/2'.
    'gp': 26, 'fp': 27, 'sp': 28, 'ilink': 29, 'ilink1': 29, 'ilink2': 30,
    'blink': 31, 'lp_count': 60, 'reserved': 61, 'pcl': 63,
    'mlo': 57, 'mmid': 58, 'mhi': 59,
})

# aux-регистры: имя -> адрес (карта binutils, root__ARC600-REFERENCE.md §2).
AUX = {
    'status': 0x00, 'semaphore': 0x01, 'lp_start': 0x02, 'lp_end': 0x03,
    'identity': 0x04, 'debug': 0x05, 'pc': 0x06, 'adcr': 0x07, 'apcr': 0x08,
    'acr': 0x09, 'status32': 0x0a, 'status32_l1': 0x0b, 'status32_l2': 0x0c,
    'ivic': 0x10, 'che_mode': 0x11, 'mulhi': 0x12, 'lockline': 0x13,
    'count0': 0x21, 'control0': 0x22, 'limit0': 0x23, 'pcport': 0x24,
    'int_vector_base': 0x25,
    'count1': 0x100, 'control1': 0x101, 'limit1': 0x102,
    'aux_irq_lev': 0x200, 'aux_irq_hint': 0x201, 'aux_inter_core_interrupt': 0x202,
    'eret': 0x400, 'erbta': 0x401, 'erstatus': 0x402, 'ecr': 0x403, 'efa': 0x404,
    'icause1': 0x40a, 'icause2': 0x40b, 'aux_ienable': 0x40c, 'aux_itrigger': 0x40d,
    'xpu': 0x410, 'bta': 0x412, 'bta_l1': 0x413, 'bta_l2': 0x414,
    'aux_irq_lv12': 0x43, 'aux_irq_pending': 0x416,
    # build-регистры конфигурации (детект опциональных блоков ядра)
    'dspram_build': 0x79, 'mac_build': 0x7a, 'multiply_build': 0x7b,
    'swap_build': 0x7c, 'norm_build': 0x7d, 'minmax_build': 0x7e,
    'barrel_build': 0x7f, 'arc600_build_config': 0xc1, 'isa_config': 0xc2,
}

# биты STATUS32 (Z/N/C/V, E1/E2, H)
_Z, _N, _C, _V = 1 << 11, 1 << 10, 1 << 9, 1 << 8

COND = {
    '': lambda f: True, 'al': lambda f: True, 'ra': lambda f: True,
    'eq': lambda f: f['Z'], 'z': lambda f: f['Z'],
    'ne': lambda f: not f['Z'], 'nz': lambda f: not f['Z'],
    'p': lambda f: not f['N'], 'pl': lambda f: not f['N'],
    'n': lambda f: f['N'], 'mi': lambda f: f['N'],
    'c': lambda f: f['C'], 'cs': lambda f: f['C'], 'lo': lambda f: f['C'],
    'nc': lambda f: not f['C'], 'cc': lambda f: not f['C'], 'hs': lambda f: not f['C'],
    'v': lambda f: f['V'], 'vs': lambda f: f['V'],
    'nv': lambda f: not f['V'], 'vc': lambda f: not f['V'],
    'gt': lambda f: (not f['Z']) and f['N'] == f['V'],
    'ge': lambda f: f['N'] == f['V'],
    'lt': lambda f: f['N'] != f['V'],
    'le': lambda f: f['Z'] or f['N'] != f['V'],
    'hi': lambda f: (not f['C']) and (not f['Z']),
    'ls': lambda f: f['C'] or f['Z'],
    'pnz': lambda f: (not f['N']) and (not f['Z']),
}

# br<cc> — сравнение двух операндов (не флаги): breq/brne/brlt/brge/brlo/brhs
BRCC = {'eq': lambda a, b: a == b, 'ne': lambda a, b: a != b,
        'lt': lambda a, b: s32(a) < s32(b), 'ge': lambda a, b: s32(a) >= s32(b),
        'lo': lambda a, b: a < b, 'hs': lambda a, b: a >= b,
        'gt': lambda a, b: s32(a) > s32(b), 'le': lambda a, b: s32(a) <= s32(b),
        'hi': lambda a, b: a > b, 'ls': lambda a, b: a <= b}


def s32(x):
    x &= M32
    return x - (1 << 32) if x & 0x80000000 else x


def sext(x, bits):
    x &= (1 << bits) - 1
    return (x - (1 << bits)) & M32 if x >> (bits - 1) else x


class EmuError(Exception):
    pass


# --------------------------------------------------------------------------- #
# Разбор операндов (текст из objdump).
# --------------------------------------------------------------------------- #

def split_ops(s):
    """Разбить строку операндов на токены по запятым вне скобок."""
    if not s:
        return []
    out, depth, cur = [], 0, []
    for ch in s:
        if ch == '[':
            depth += 1
        elif ch == ']':
            depth -= 1
        if ch == ',' and depth == 0:
            out.append(''.join(cur).strip())
            cur = []
        else:
            cur.append(ch)
    out.append(''.join(cur).strip())
    return [t for t in out if t != '']


def regnum(tok):
    """Имя регистра -> номер (0..63), либо None."""
    return REGS.get(tok)


def imm(tok):
    """Токен -> 32-битное непосредственное значение, либо None (если не число)."""
    t = tok.strip()
    if t == '':
        return None
    try:
        if t[:2].lower() == '0x':
            return int(t, 16) & M32
        return int(t, 10) & M32
    except ValueError:
        return None


def mem(tok):
    """Разобрать `[...]`: вернуть список внутренних токенов, либо None."""
    t = tok.strip()
    if t.startswith('[') and t.endswith(']'):
        return split_ops(t[1:-1])
    return None


class Instr:
    """Декодированная инструкция (текст из objdump + разобранные поля)."""
    __slots__ = ('addr', 'size', 'text', 'mn', 'base', 'sfx', 'ops', 'target',
                 'cc', 'delay', 'setf', 'wb', 'x')

    def __init__(self, addr, size, mn, args, target):
        self.addr, self.size, self.target = addr, size, target
        self.text = (mn + ' ' + args).strip()
        self.mn = mn
        parts = mn.split('.')
        self.base = parts[0]
        self.sfx = parts[1:]
        self.ops = split_ops(args)
        self.delay = 'd' in self.sfx
        self.setf = 'f' in self.sfx
        self.wb = next((x for x in self.sfx if x in ('a', 'ab', 'aw', 'as')), '')
        self.x = 'x' in self.sfx
        _skip = {'f', 'd', 'nd', 'b', 'w', 'h', 'a', 'ab', 'aw', 'as', 'x', 'di'}
        cc = [x for x in self.sfx if x not in _skip]
        self.cc = cc[0] if cc else ''

    def cond(self, flags):
        """Истина, если условие выполняется при данных флагах."""
        if self.cc not in COND:
            raise EmuError('неизвестное условие %r в %r' % (self.cc, self.text))
        return COND[self.cc](flags)


# --------------------------------------------------------------------------- #
# Декодирование через objdump.
# --------------------------------------------------------------------------- #

_LINE = re.compile(r'^\s*([0-9a-fA-F]+):\s+((?:[0-9a-fA-F]{2,8}\s+)+)\s+'
                   r'([^\s][^\t]*?)\s*(?:\t(.*))?$')


def disasm(code, base=0):
    """Дизассемблировать байты кода через objdump.

    Возвращает список (addr, size, mnemonic, args, target), где target —
    абсолютный адрес перехода из комментария `;addr` (или None).
    """
    if not code:
        return []
    tmp = tempfile.mkdtemp(prefix='arcemu-')
    try:
        binp = os.path.join(tmp, 'c.bin')
        elfp = os.path.join(tmp, 'c.elf')
        with open(binp, 'wb') as f:
            f.write(code)
        subprocess.run([OBJCOPY, '-I', 'binary', '-O', 'elf32-littlearc',
                        '-B', 'arc600', '--set-section-flags',
                        '.data=alloc,load,readonly,code,contents',
                        '--rename-section', '.data=.text', binp, elfp],
                       check=True, capture_output=True)
        out = subprocess.run([OBJDUMP, '-M', 'cpu=arc600',
                              '--adjust-vma=%d' % base, '-d', elfp],
                             capture_output=True, text=True).stdout
    finally:
        shutil.rmtree(tmp, ignore_errors=True)

    res = []
    for line in out.splitlines():
        m = _LINE.match(line)
        if not m:
            continue
        addr = int(m.group(1), 16)
        bytes_hex = m.group(2).replace(' ', '')
        if not bytes_hex:
            continue
        size = len(bytes_hex) // 2
        mn = m.group(3).strip()
        rest = m.group(4) or ''
        args, target = rest, None
        if '\t' in rest:
            args, tail = rest.split('\t', 1)
            t = re.match(r';\s*([0-9a-fA-F]+)', tail)
            if t:
                target = int(t.group(1), 16)
        res.append((addr, size, mn, args.strip(), target))
    return res


# --------------------------------------------------------------------------- #
# Ядро эмулятора.
# --------------------------------------------------------------------------- #

def _decode_ext(b, addr):
    """Резервный декодер для кодировок, которые objdump печатает как `.word`.

    vendor (MetaWare) кодирует MUL64/MULU64 (major 5, subop 4/5) с полем A = B
    (а не 62 «без приёмника»); binutils считает это недопустимым. Приёмника у
    mul64 нет — A игнорируется. Форматы: P=00 (c — регистр или limm при c=62),
    P=01 (c — u6). Возврат: Instr или None.
    """
    if len(b) < 4:
        return None
    w = (int.from_bytes(b[0:2], 'little') << 16) | int.from_bytes(b[2:4], 'little')
    if (w >> 27) != 5:
        return None
    sub = (w >> 16) & 0x3f
    if sub not in (4, 5):
        return None
    p = (w >> 22) & 3
    breg = ((w >> 12) & 7) << 3 | ((w >> 24) & 7)
    c = (w >> 6) & 0x3f
    mn = 'mul64' if sub == 4 else 'mulu64'
    if p == 0 and c == 62:
        if len(b) < 8:
            return None
        limm = (int.from_bytes(b[4:6], 'little') << 16) | int.from_bytes(b[6:8], 'little')
        return Instr(addr, 8, mn, '0,r%d,0x%x' % (breg, limm), None)
    if p == 0:
        return Instr(addr, 4, mn, '0,r%d,r%d' % (breg, c), None)
    if p == 1:
        return Instr(addr, 4, mn, '0,r%d,0x%x' % (breg, c), None)
    return None


class CPU:
    """ARC600 (ARCompact) CPU: регистры, флаги, sparse-память, aux, трасса."""

    def __init__(self, seed=0x5EED, mem=None, mmio_regions=None, label='cpu',
                 functional_mmio=False, mac_regs=None, io_hooks=None, diff_world=False):
        self.regs = [0] * 64
        # diff_world=True — «мир» для пофункциональной сверки двух реализаций:
        #   RAM: неинициализированный байт = f(seed, адрес), запоминается (стабилен);
        #   MMIO/aux/r32..r56: значение = f(seed, адрес, номер чтения ЭТОГО адреса),
        #   чтобы лишнее чтение в одной реализации не сдвигало «мир» другой.
        self.diff_world = diff_world
        self._addr_reads = {}
        self.ram_init = set()     # адреса RAM, «проинициализированные» чтением (diff_world)
        self.ram_written = set()  # адреса RAM, куда была запись (для сверки eqcheck)
        self.seed = seed & M32
        self.pc = 0
        self.halted = False
        self.insns = 0
        self.label = label
        # mem/mmio_regions/mac_regs/io_hooks можно разделять между ядрами.
        # functional_mmio=True — MMIO это общий регистровый файл (запись-чтение
        # видимы обоим ядрам); False — MMIO детерминированная заглушка (дифф-чек).
        self.functional_mmio = functional_mmio
        self.mem = {} if mem is None else mem
        # расширенные core-регистры r32..r56 (порты MAC) — общий файл при System
        self.mac_regs = {} if mac_regs is None else mac_regs
        # хуки моделей конкретных MMIO-регистров: addr -> (read_fn, write_fn)
        self.io_hooks = {} if io_hooks is None else io_hooks
        # aux-регистры с реальной семантикой (моделируются, не трассируются);
        # прочие aux читаются детерминированно и попадают в трассу.
        self.aux = {0x02: 0, 0x03: 0, 0x0a: 0, 0x12: 0}
        self.mmio_regions = [] if mmio_regions is None else mmio_regions
        self.trace = []          # события (kind, dir, addr, size, value)
        self.breakpoints = set()
        self._instr = {}         # addr -> Instr (кэш декодирования)
        self._code_regions = []  # [(lo, hi, code_bytes)]
        self._cur = None
        self.exhausted = False
        self._max_steps = 10_000_000
        # детерминированный «мир»: глобальный счётчик чтений (номер чтения)
        self.read_num = 0
        # перехват вызовов: callable(cpu, target, is_tail, args) -> None или
        # ('stub', r0, r1). None/«execute» — исполнять вызываемую функцию.
        self.call_hook = None
        # диапазон текущей функции (lo, hi) для детекта хвостовых вызовов
        self.func_range = None
        # алиасы адресов ICCM: список (lo, hi, base) — [lo,hi) → base+offset
        self.alias = []
        # прерывания (минимальная модель)
        self.irq_pending = set()  # ожидающие номера векторов прерываний (0..31)
        self.vector_base = 0      # база таблицы векторов (32 слота × 8 байт)
        self.irq_hook = None      # callable(v) — срабатывает при записи в 0x202
        # build-регистры конфигурации (детект опциональных блоков ядра)
        self.aux[0x7b] = 0x1     # multiply_build (MUL64 есть)
        self.aux[0x7d] = 0x1     # norm_build
        self.aux[0x7e] = 0x1     # minmax_build
        self.aux[0x7f] = 0x1     # barrel_build
        self.aux[0x200] = 0      # aux_irq_lev (уровень прерываний)
        self.aux[0x202] = 0      # aux_inter_core_interrupt (межъядерное)

    # --- конфигурация памяти --------------------------------------------- #
    def load(self, addr, data, is_code=False):
        """Загрузить байты памяти по адресу addr (перезаписывает)."""
        data = bytes(data)
        for i, b in enumerate(data):
            self.mem[addr + i] = b
        if is_code:
            self._code_regions.append((addr, addr + len(data), data))

    def mmio(self, lo, hi):
        self.mmio_regions.append((lo, hi))

    def _in(self, regions, addr):
        return any(lo <= addr < hi for lo, hi in regions)

    def is_mmio(self, addr):
        return self._in(self.mmio_regions, addr)

    # --- регистры --------------------------------------------------------- #
    def read_reg(self, n):
        if n == 63:
            return self.pc & ~3          # pcl — PC, выровненный по слову
        if 32 <= n <= 56:
            # расширенные core-регистры — порты MAC. При functional_mmio — общий
            # регистровый файл (значение по умолчанию 0); иначе детерм. значение.
            if self.functional_mmio:
                v = self.mac_regs.get(n, 0) & M32
            else:
                v = self._det(0xEE000000 + n, 4)
            self.trace.append(('extreg', 'r', n, 4, v))
            return v
        return self.regs[n] & M32

    def write_reg(self, n, v):
        v &= M32
        if n == 63:
            self.pc = v & ~3             # запись в pcl = переход
            return
        if 32 <= n <= 56:
            if self.functional_mmio:
                self.mac_regs[n] = v     # общий регистровый файл MAC
            self.trace.append(('extreg', 'w', n, 4, v))
            return
        self.regs[n] = v

    def set_regs(self, d):
        """Задать регистры словарём {номер: значение} (аргументы функции и т.п.)."""
        for n, v in d.items():
            self.regs[n] = v & M32

    @property
    def sp(self):
        return self.regs[28] & M32

    @sp.setter
    def sp(self, v):
        self.regs[28] = v & M32

    @property
    def blink(self):
        return self.regs[31] & M32

    @blink.setter
    def blink(self, v):
        self.regs[31] = v & M32

    # --- флаги STATUS32 --------------------------------------------------- #
    @property
    def flags(self):
        s = self.aux.get(0x0a, 0)
        return {'Z': 1 if s & _Z else 0, 'N': 1 if s & _N else 0,
                'C': 1 if s & _C else 0, 'V': 1 if s & _V else 0}

    def set_flags(self, z=None, n=None, c=None, v=None):
        s = self.aux.get(0x0a, 0)
        if z is not None:
            s = (s & ~_Z) | (_Z if z else 0)
        if n is not None:
            s = (s & ~_N) | (_N if n else 0)
        if c is not None:
            s = (s & ~_C) | (_C if c else 0)
        if v is not None:
            s = (s & ~_V) | (_V if v else 0)
        self.aux[0x0a] = s

    def _set_logic_flags(self, res, c=None, v=None):
        res &= M32
        self.set_flags(z=(res == 0), n=bool(res & 0x80000000), c=c, v=v)

    # --- детерминизм ------------------------------------------------------ #
    def _det(self, addr, size=4):
        """Детерминированное значение для неинициализированного/MMIO чтения.

        Ключ — (seed, адрес, номер чтения): каждый очередной неинициализированный/
        MMIO-читанный адрес даёт своё (но воспроизводимое) значение, поэтому
        vendor- и наш прогон при одинаковой последовательности чтений видят
        одинаковый «мир». Чтение одного адреса байтом/словом — согласовано.
        """
        if self.diff_world:
            k = addr & M32
            n = self._addr_reads.get(k, 0) + 1
            self._addr_reads[k] = n
        else:
            self.read_num += 1
            n = self.read_num
        h = hashlib.sha256(b'%08x:%08x:%08x' % (self.seed, addr & M32, n)).digest()
        v = int.from_bytes(h[:4], 'little') & M32
        if size < 4:
            v &= (1 << (8 * size)) - 1
        return v

    def _alias_addr(self, addr):
        """Применить алиасы ICCM (например, 0x0 ↔ 0x920000)."""
        for lo, hi, base in self.alias:
            if lo <= addr < hi:
                return base + (addr - lo)
        return addr

    # --- память ----------------------------------------------------------- #
    def read(self, addr, size):
        addr = self._alias_addr(addr & M32)
        if size == 0:
            return 0
        if self.is_mmio(addr):
            hook = self.io_hooks.get(addr & ~3)
            if hook and hook[0] is not None:
                v = hook[0](self, addr) & M32
                self.trace.append(('mmio', 'r', addr, size, v))
                return v
            if self.functional_mmio and all((addr + i) in self.mem for i in range(size)):
                v = 0
                for i in range(size):
                    v |= self.mem[addr + i] << (8 * i)
            else:
                # заглушка / неинициализированный регистр: детерминированно
                v = self._det(addr, size)
            self.trace.append(('mmio', 'r', addr, size, v & M32))
            return v & M32
        # RAM: инициализированные байты из памяти, неинициализированные — детерм.
        if self.diff_world:
            for i in range(size):
                if (addr + i) not in self.mem:
                    hb = hashlib.sha256(b'ram:%08x:%08x' % (self.seed, addr + i)).digest()
                    self.mem[addr + i] = hb[0]
                    self.ram_init.add(addr + i)
        if all((addr + i) in self.mem for i in range(size)):
            v = 0
            for i in range(size):
                v |= self.mem[addr + i] << (8 * i)
            return v & M32
        base_det = self._det(addr, size)
        v = 0
        for i in range(size):
            b = self.mem.get(addr + i)
            if b is None:
                b = (base_det >> (8 * i)) & 0xff
            v |= b << (8 * i)
        return v & M32

    def write(self, addr, data):
        addr = self._alias_addr(addr & M32)
        v = int.from_bytes(bytes(data), 'little') & M32
        if self.is_mmio(addr):
            hook = self.io_hooks.get(addr & ~3)
            if hook and hook[1] is not None:
                hook[1](self, addr, v)
                self.trace.append(('mmio', 'w', addr, len(data), v))
                return
            if self.functional_mmio:
                for i, b in enumerate(data):
                    self.mem[addr + i] = b & 0xff
            self.trace.append(('mmio', 'w', addr, len(data), v))
            return
        for i, b in enumerate(data):
            self.mem[addr + i] = b & 0xff
            self.ram_written.add(addr + i)

    # --- aux -------------------------------------------------------------- #
    def read_aux(self, addr):
        addr &= M32
        if addr in self.aux:
            return self.aux[addr] & M32
        return self._det(0xAA000000 + addr, 4)

    def write_aux(self, addr, v):
        addr &= M32
        v &= M32
        if addr == 0x0a:
            self.aux[addr] = v & 0x0f07   # Z/N/C/V/E1/E2/H (биты 11:8, 2:0)
        elif addr == 0x12:                 # mulhi — зеркало mhi
            self.aux[addr] = v
            self.regs[59] = v
        elif addr in (0x02, 0x03, 0x7b, 0x7d, 0x7e, 0x7f):
            self.aux[addr] = v             # lp_start/lp_end/build — модель
        elif addr in (0x200, 0x201):
            self.aux[addr] = v             # aux_irq_lev / aux_irq_hint
        elif addr == 0x202:                 # aux_inter_core_interrupt
            self.aux[addr] = v
            if self.irq_hook:
                self.irq_hook(v)           # System сигналит другому ядру

    # --- декодирование ---------------------------------------------------- #
    def _decode(self, addr):
        addr = self._alias_addr(addr & M32)
        if addr in self._instr:
            return self._instr[addr]
        for lo, hi, code in self._code_regions:
            if lo <= addr < hi:
                for a, size, mn, args, tgt in disasm(code, lo):
                    if mn.startswith('.'):
                        ext = _decode_ext(code[a - lo:a - lo + 8], a)
                        if ext is not None:
                            self._instr[a] = ext
                            continue
                    self._instr[a] = Instr(a, size, mn, args, tgt)
                return self._instr.get(addr)
        return None

    def fetch(self, addr):
        addr = self._alias_addr(addr & M32)
        ins = self._decode(addr)
        if ins is None:
            # линейный проход по региону рассинхронизировался (данные/хвост чужой функции
            # перед этим адресом в гибриде) — декодировать с addr. В кэш — только первую
            # инструкцию: последняя в 12-байтном окне может быть обрезана (8-байтная с limm
            # -> '.word') и раньше затирала верную запись следующего PC.
            raw = bytes(self.read(addr + i, 1) & 0xff for i in range(12))
            for a, size, mn, args, tgt in disasm(raw, addr):
                if a == addr:
                    self._instr[a] = Instr(a, size, mn, args, tgt)
            ins = self._instr.get(addr)
        if ins is None:
            raise EmuError('не удалось декодировать инструкцию по 0x%08x' % addr)
        return ins

    # --- операнды --------------------------------------------------------- #
    def _op(self, tok):
        """Токен операнда -> ('reg', n) | ('imm', v) | ('mem', [tokens])."""
        r = regnum(tok)
        if r is not None:
            return ('reg', r)
        m = mem(tok)
        if m is not None:
            return ('mem', m)
        v = imm(tok)
        if v is not None:
            return ('imm', v)
        raise EmuError('непонятный операнд %r в %r' % (tok, self._cur.text if self._cur else '?'))

    def _val(self, tok):
        kind = self._op(tok)
        if kind[0] == 'reg':
            return self.read_reg(kind[1])
        return kind[1]

    def _addr_of(self, mtok):
        """Разобрать адресный операнд -> (addr, wb_reg, wb_delta).

        Формы: [reg], [reg, imm], [reg, reg], [imm], [imm, reg].
        Масштабирование .as — на log2(размер данных) (и индекс, и смещение);
        .ab/.aw возвращают wb_reg/wb_delta (writeback выполняется в _ldst).
        """
        parts = [self._op(t) for t in mtok]
        size = self._ldst_size(self._cur.base)
        sb = {1: 0, 2: 1, 4: 2}[size]              # log2 размера данных
        scale = sb if self._cur.wb == 'as' else 0

        base_reg = None   # регистр-база ([reg, ...])
        base_abs = None   # абсолютная база ([imm, ...])
        index = None      # индексный регистр
        off = 0           # непосредственное смещение

        first_is_reg = parts[0][0] == 'reg'
        for t in parts:
            if t[0] == 'reg':
                if base_reg is None and first_is_reg:
                    base_reg = t[1]
                else:
                    index = t[1]      # второй регистр, либо [imm, reg]
            else:
                v = s32(t[1]) & M32
                if not first_is_reg and base_abs is None:
                    base_abs = v      # [imm, ...] — абсолютный адрес
                else:
                    off = v           # [reg, imm] — смещение

        if base_abs is not None:
            b = base_abs
        else:
            b = self.read_reg(base_reg)

        src2 = self.read_reg(index) if index is not None else off
        if self._cur.wb == 'ab':
            addr = b                          # .ab: адрес = база без offset
        elif index is not None:
            addr = (b + (self.read_reg(index) << scale)) & M32
        else:
            addr = (b + (off << scale)) & M32

        wb_reg = base_reg if (base_reg is not None and self._cur.wb in ('ab', 'aw')) else None
        return addr, wb_reg, src2

    # --- прерывания -------------------------------------------------------- #
    def request_irq(self, n):
        """Запросить прерывание по вектору n (0..31)."""
        self.irq_pending.add(n & 31)

    def _irq_enabled(self):
        s = self.aux.get(0x0a, 0)
        return bool(s & 0x6)        # STATUS32 E1 (бит 1) или E2 (бит 2)

    def _deliver_irq(self):
        """Доставить старшее ожидающее прерывание (если разрешено).

        Сохраняет PC→ilink1, STATUS32→status32_l1, запрещает вложенные
        прерывания и прыгает к слоту вектора (там `j <обработчик>`).
        """
        if not self.irq_pending or not self._irq_enabled():
            return
        n = min(self.irq_pending)
        self.irq_pending.discard(n)
        self.regs[29] = self.pc & M32              # ilink1 = адрес возврата
        self.aux[0x0b] = self.aux.get(0x0a, 0)     # status32_l1 = status32
        self.aux[0x0a] = self.aux.get(0x0a, 0) & ~0x6   # очистить E1/E2
        self.pc = (self.vector_base + n * 8) & M32

    # --- главный цикл ----------------------------------------------------- #
    def step(self):
        """Выполнить одну инструкцию (с учётом delay-слота и перехвата вызовов).

        Ветвления возвращают из _execute:
          None                — последовательно;
          int                 — переход по адресу (для .d — после delay-слота);
          ('stub', r0, r1)    — перехваченный вызов без delay-слота;
          ('tail_stub', r0, r1) — перехваченный хвостовой переход;
          ('call_d', tgt, link_flag, is_tail) — вызов/хвост с delay-слотом:
                перехват ПОСЛЕ слота (ARC: условие и цель вычисляются до слота,
                слот исполняется всегда, вызываемый видит регистры после слота).
        Zero-overhead loop (PRM «ARC 600 Loop Operation»): если последовательный
        адрес исполненной инструкции (NEXT_PC) == LP_END — LP_COUNT декрементируется
        ВСЕГДА (и при взятом переходе, и при 0 → 0xffffffff); при взятом переходе
        следующий PC — его цель; иначе при старом LP_COUNT не 0/1 — LP_START.
        Переход на LP_END из середины цикла — выход без декремента.
        """
        if self.halted:
            return
        self._deliver_irq()
        ins = self.fetch(self.pc)
        self._cur = ins
        lp_end = self.aux.get(0x03, 0)
        nxt = (ins.addr + ins.size) & M32
        at_end = bool(lp_end) and nxt == lp_end      # инструкция — последняя в цикле
        tgt = self._execute(ins)
        sequential = False
        if isinstance(tgt, tuple) and tgt[0] == 'call_d':
            _, t, link, is_tail = tgt
            dins = self.fetch(nxt)
            self._cur = dins
            self._execute(dins)                 # delay-слот — до перехвата
            after = (nxt + dins.size) & M32
            self.insns += 2
            d = self._call_hook(ins, t, is_tail)
            if d is not None:
                self.trace.append(('call', t, d[1] if len(d) > 1 else None))
                self.regs[0] = d[1] & M32
                if len(d) > 2 and d[2] is not None:
                    self.regs[1] = d[2] & M32
                # возврат из вызова — прыжок (не последовательный поток)
                self.pc = after if link else (self.regs[31] & M32)
            else:
                if link:
                    self.regs[31] = after
                self.pc = t & M32
        elif isinstance(tgt, tuple):
            # перехваченный вызов без delay-слота: ('stub', r0, r1) / ('tail_stub', r0, r1)
            self.regs[0] = tgt[1] & M32
            if tgt[2] is not None:
                self.regs[1] = tgt[2] & M32
            self.pc = (self.regs[31] & M32) if tgt[0] == 'tail_stub' else nxt
            self.insns += 1
        elif tgt is not None and ins.delay:
            dins = self.fetch(nxt)
            self._cur = dins
            self._execute(dins)     # результат ветвления слота игнорируется
            self.pc = tgt
            self.insns += 2
            if lp_end and ((nxt + dins.size) & M32) == lp_end:
                self._lp_decrement()             # delay-слот на последнем месте цикла
        elif tgt is not None:
            self.pc = tgt
            self.insns += 1
        else:
            self.pc = nxt
            self.insns += 1
            sequential = True
        if sequential:
            self._loop_end_check()
        elif at_end and not (isinstance(tgt, tuple) and tgt[0] == 'call_d') and not (tgt is not None and not isinstance(tgt, tuple) and ins.delay):
            self._lp_decrement()                 # взятый переход на последнем месте: только декремент
        self._cur = None

    def _lp_decrement(self):
        self.regs[60] = (self.regs[60] - 1) & M32

    def _loop_end_check(self):
        """Zero-overhead loop: по достижении lp_end декремент lp_count.

        Семантика ARC: декремент ПРИ pc == lp_end; переход к lp_start только
        если новое значение счётчика != 0 (иначе — выход из цикла).
        """
        lp_end = self.aux.get(0x03, 0)
        lp_start = self.aux.get(0x02, 0)
        if lp_end and self.pc == lp_end:
            cnt = self.regs[60] & M32
            self.regs[60] = (cnt - 1) & M32      # декремент всегда (0 → 0xffffffff)
            if cnt not in (0, 1):
                self.pc = lp_start & M32

    def run(self, start=None, stop=None, max_steps=None):
        """Выполнять, пока не достигнут stop / breakpoint / halt / лимит.

        При достижении лимита шагов взводится self.exhausted (иначе — False).
        """
        self.exhausted = False
        if start is not None:
            self.pc = start & M32
        limit = max_steps or self._max_steps
        for _ in range(limit):
            if self.halted:
                break
            if stop is not None and self.pc == (stop & M32):
                break
            if self.pc in self.breakpoints:
                break
            self.step()
        else:
            self.exhausted = True
        return self.pc

    # --- вспомогательные -------------------------------------------------- #
    @staticmethod
    def _ldst_size(name):
        n = name[:-2] if name.endswith('_s') else name
        if n in ('ldb', 'stb'):
            return 1
        if n in ('ldw', 'ldh', 'stw', 'sth'):
            return 2
        return 4

    def _split_branch(self, name):
        """(base_op, condition) для мнемоники ветвления (objdump «слепляет» cc)."""
        for prefix in ('bbit0', 'bbit1', 'bl', 'br', 'jl', 'lp'):
            if name.startswith(prefix):
                rest = name[len(prefix):]
                if rest == '':
                    return prefix, ''
                condset = BRCC if prefix == 'br' else COND
                if rest in condset:
                    return prefix, rest
        for prefix in ('b', 'j'):
            if name.startswith(prefix):
                rest = name[len(prefix):]
                if rest in COND:
                    return prefix, rest
        return name, ''

    # --- семантика -------------------------------------------------------- #
    def _execute(self, ins):
        """Выполнить ins. Вернуть адрес перехода, либо None (последовательно)."""
        name = ins.base
        if name.endswith('_s'):
            name = name[:-2]        # короткие 16-битные формы — та же семантика

        # ветвления и переходы ------------------------------------------
        if name[:1] in ('b', 'j', 'l') and name != 'ld' and name != 'lr':
            op, cc = self._split_branch(name)
            if op == 'b' or op == 'bl':
                return self._b(ins, link=(op == 'bl'), cc=cc)
            if op == 'br':
                return self._br(ins, cc)
            if op == 'bbit0' or op == 'bbit1':
                return self._bbit(ins, want=(op == 'bbit1'))
            if op == 'j' or op == 'jl':
                return self._j(ins, link=(op == 'jl'), cc=cc)
            if op == 'lp':
                return self._lp(ins, cc)

        # загрузка/сохранение ------------------------------------------
        if name in ('ld', 'ldb', 'ldh', 'ldw', 'st', 'stb', 'sth', 'stw'):
            self._ldst(ins, store=name.startswith('st'))
            return None
        if name in ('push', 'pop'):
            self._pushpop(ins, pop=(name == 'pop'))
            return None

        # aux -----------------------------------------------------------
        if name == 'lr':
            self._lr(ins)
            return None
        if name == 'sr':
            self._sr(ins)
            return None

        # прочие --------------------------------------------------------
        if name == 'mov':
            self._mov(ins)
            return None
        if name == 'flag':
            self._flag(ins)
            return None
        if name == 'nop':
            return None
        if name == 'sleep':
            self.trace.append(('sleep',))
            self.halted = True
            return None
        if name in ('swi', 'brk', 'trap', 'unimp'):
            raise EmuError('исключение/ловушка %r по 0x%08x' % (name, ins.addr))
        if ins.mn.startswith('.'):
            # данные (таблицы) в потоке кода — исполнять нельзя
            raise EmuError('данные %r по 0x%08x (исполнение таблицы?)' % (ins.mn, ins.addr))
        if name == 'sync':
            self.trace.append(('sync',))
            return None
        if name == 'rtie':
            raise EmuError('rtie не поддерживается (в Sparrow не используется)')

        h = self._alu.get(name)
        if h is not None:
            h(self, ins)
            return None
        raise EmuError('неизвестная инструкция %r по 0x%08x' % (ins.mn, ins.addr))

    # --- ветвления --------------------------------------------------------- #
    def _link_addr(self, ins):
        """Адрес возврата для bl/jl: после инструкции (и delay-слота при .d)."""
        ret = (ins.addr + ins.size) & M32
        if ins.delay:
            dins = self.fetch(ret)
            ret = (ret + dins.size) & M32
        return ret

    def _call_hook(self, ins, target, is_tail):
        """Перехват вызова: вернуть None («исполнять») или ('stub', r0, r1)."""
        if self.call_hook is None:
            return None
        args = tuple(self.regs[i] & M32 for i in range(8))
        d = self.call_hook(self, target, is_tail, args)
        if d is None:
            return None
        if isinstance(d, tuple) and d and d[0] == 'stub':
            return d
        # 'execute' или иное не-заглушка — исполнять
        return None

    def _is_tail(self, target):
        """Хвостовой вызов: переход за пределы текущей функции."""
        if self.func_range is None:
            return False
        lo, hi = self.func_range
        return not (lo <= target < hi)

    def _b(self, ins, link, cc):
        if cc and not COND[cc](self.flags):
            return None
        tgt = ins.target
        if ins.delay and (link or self._is_tail(tgt)) and self.call_hook is not None:
            return ('call_d', tgt, link, not link)
        if link:
            d = self._call_hook(ins, tgt, False)
            if d is not None:
                self.trace.append(('call', tgt, d[1] if len(d) > 1 else None))
                return ('stub', d[1], d[2] if len(d) > 2 else None)
            self.regs[31] = self._link_addr(ins)
            return tgt
        # безусловный/условный переход: хвостовой вызов, если за пределы функции
        if self._is_tail(tgt):
            d = self._call_hook(ins, tgt, True)
            if d is not None:
                self.trace.append(('call', tgt, d[1] if len(d) > 1 else None))
                return ('tail_stub', d[1], d[2] if len(d) > 2 else None)
        return tgt

    def _br(self, ins, cc):
        if cc not in BRCC:
            raise EmuError('неизвестное br-условие %r в %r' % (cc, ins.text))
        a = self._val(ins.ops[0])
        b = self._val(ins.ops[1])
        if BRCC[cc](a, b):
            return ins.target
        return None

    def _bbit(self, ins, want):
        r = self._val(ins.ops[0])
        bit = self._val(ins.ops[1]) & 31
        if ((r >> bit) & 1) == want:
            return ins.target
        return None

    def _j(self, ins, link, cc):
        if cc and not COND[cc](self.flags):
            return None
        op = ins.ops[0]
        m = mem(op)
        tgt = self._val(m[0]) if m is not None else self._val(op)
        if ins.delay and not ins.setf and (link or self._is_tail(tgt)) and self.call_hook is not None:
            return ('call_d', tgt, link, not link)
        if link:
            d = self._call_hook(ins, tgt, False)
            if d is not None:
                self.trace.append(('call', tgt, d[1] if len(d) > 1 else None))
                return ('stub', d[1], d[2] if len(d) > 2 else None)
            self.regs[31] = self._link_addr(ins)
            return tgt
        if self._is_tail(tgt) and not ins.setf:
            d = self._call_hook(ins, tgt, True)
            if d is not None:
                self.trace.append(('call', tgt, d[1] if len(d) > 1 else None))
                return ('tail_stub', d[1], d[2] if len(d) > 2 else None)
        if ins.setf:
            # j.f [ilink] — возврат из прерывания: восстановить STATUS32
            self.aux[0x0a] = self.aux.get(0x0b, 0) & 0x0f07
        return tgt

    def _lp(self, ins, cc):
        if cc and not COND[cc](self.flags):
            return ins.target       # условие ложно — ветвление к цели
        self.aux[0x02] = (ins.addr + ins.size) & M32   # lp_start = следующая
        self.aux[0x03] = ins.target & M32              # lp_end = цель
        return None

    # --- ld/st ------------------------------------------------------------- #
    def _ldst(self, ins, store):
        val_tok, mtok = ins.ops[0], ins.ops[1]
        m = mem(mtok)
        if m is None:
            raise EmuError('ld/st без адреса: %r' % ins.text)
        size = self._ldst_size(ins.base)

        addr, wb_reg, wb_delta = self._addr_of(m)
        old_base = self.read_reg(wb_reg) if wb_reg is not None else None

        if store:
            v = self._val(val_tok)
            self.write(addr, [(v >> (8 * i)) & 0xff for i in range(size)])
            if wb_reg is not None:
                self.write_reg(wb_reg, (old_base + wb_delta) & M32)
        else:
            v = self.read(addr, size)
            if ins.x and size < 4:
                v = sext(v, size * 8)
            # writeback до записи dst, чтобы при dst==base «выиграл» загруженный
            # результат (PRM: src1 ← src1+src2, затем dest ← Memory).
            if wb_reg is not None:
                self.write_reg(wb_reg, (old_base + wb_delta) & M32)
            self.write_reg(regnum(val_tok), v)

    def _pushpop(self, ins, pop):
        sp = 28
        rn = regnum(ins.ops[0])
        if rn is None:
            raise EmuError('push/pop без регистра: %r' % ins.text)
        if pop:
            v = self.read(self.regs[sp], 4)
            self.write_reg(rn, v)
            self.regs[sp] = (self.regs[sp] + 4) & M32
        else:
            self.regs[sp] = (self.regs[sp] - 4) & M32
            v = self.read_reg(rn)
            self.write(self.regs[sp], [(v >> (8 * i)) & 0xff for i in range(4)])

    # --- lr/sr ------------------------------------------------------------- #
    def _aux_addr(self, mtok):
        nm = mtok[0]
        if nm in AUX:
            return ('imm', AUX[nm])
        t = self._op(nm)
        if t[0] in ('reg', 'imm'):
            return t
        raise EmuError('неизвестный aux-регистр %r' % nm)

    def _lr(self, ins):
        dst = regnum(ins.ops[0])
        m = mem(ins.ops[1])
        aa = self._aux_addr(m)
        a = self.read_reg(aa[1]) if aa[0] == 'reg' else aa[1]
        v = self.read_aux(a)
        self.write_reg(dst, v)
        self.trace.append(('lr', a, 4, v))          # все lr — в трассу

    def _sr(self, ins):
        m = mem(ins.ops[1])
        aa = self._aux_addr(m)
        a = self.read_reg(aa[1]) if aa[0] == 'reg' else aa[1]
        v = self._val(ins.ops[0])
        self.write_aux(a, v)
        self.trace.append(('sr', a, 4, v))          # все sr — в трассу

    # --- mov/flag ---------------------------------------------------------- #
    def _mov(self, ins):
        if not self._cond_ok(ins):
            return
        v = self._val(ins.ops[1])
        dn = regnum(ins.ops[0])
        if dn is not None:
            self.write_reg(dn, v)
        if ins.setf:
            self._set_logic_flags(v)

    def _flag(self, ins):
        if not self._cond_ok(ins):
            return
        v = self._val(ins.ops[0])
        self.trace.append(('flag', v))              # flag — в трассу
        if v & 1:
            # H=1: только halt, прочие флаги остаются без изменений (PRM FLAG)
            self.aux[0x0a] = self.aux.get(0x0a, 0) | 1
            self.halted = True
            return
        self.aux[0x0a] = ((v & 0x0f00) | (v & 0x07)) & 0x0f07

    # --- арифметика -------------------------------------------------------- #
    def _cond_ok(self, ins):
        return ins.cond(self.flags)

    def _3op(self, ins):
        """(dst_reg|None, b, c) для 2/3-операндных форм."""
        dn = regnum(ins.ops[0])
        b = self._val(ins.ops[1])
        c = self._val(ins.ops[2]) if len(ins.ops) > 2 else b
        return dn, b, c

    @staticmethod
    def _base(ins):
        """Базовое имя мнемоники без суффикса `_s` (16-битные формы)."""
        b = ins.base
        return b[:-2] if b.endswith('_s') else b

    def _alu_op(self, ins, fn):
        if not self._cond_ok(ins):
            return
        dn, b, c = self._3op(ins)
        res, fl = fn(b, c, self.flags['C'])
        if dn is not None:
            self.write_reg(dn, res)
        if ins.setf:
            self._set_logic_flags(res, c=fl.get('c'), v=fl.get('v'))

    @staticmethod
    def _add_fn(b, c, C, shift=0):
        c = (c << shift) & M32
        r = (b + c) & M32
        return r, {'c': (b + c) >> 32 & 1, 'v': ((~(b ^ c) & (b ^ r)) >> 31) & 1}

    @staticmethod
    def _sub_fn(b, c, C, shift=0):
        c = (c << shift) & M32
        r = (b - c) & M32
        return r, {'c': 1 if b < c else 0,
                   'v': ((~(b ^ (~c & M32)) & (b ^ r)) >> 31) & 1}

    @staticmethod
    def _adc_fn(b, c, C):
        r = (b + c + C) & M32
        return r, {'c': (b + c + C) >> 32 & 1, 'v': ((~(b ^ c) & (b ^ r)) >> 31) & 1}

    @staticmethod
    def _sbc_fn(b, c, C):
        r = (b - c - C) & M32
        return r, {'c': 1 if (b - C) < c else 0,
                   'v': ((~(b ^ (~c & M32)) & (b ^ r)) >> 31) & 1}

    @staticmethod
    def _logic_fn(op):
        return lambda b, c, C: (op(b, c) & M32, {})

    def _cmp(self, ins):
        if not self._cond_ok(ins):
            return
        b = self._val(ins.ops[0])
        c = self._val(ins.ops[1])
        base = self._base(ins)
        if base == 'rcmp':
            b, c = c, b
        if base == 'tst':
            r = (b & c) & M32
            self._set_logic_flags(r)
        else:
            r = (b - c) & M32
            self.set_flags(z=(r == 0), n=bool(r & 0x80000000),
                           c=(1 if b < c else 0),
                           v=((~(b ^ (~c & M32)) & (b ^ r)) >> 31) & 1)

    def _shift(self, ins):
        if not self._cond_ok(ins):
            return
        base = self._base(ins)
        # 2-операндные asl/lsr/asr/ror = сдвиг/ротация ровно на 1 (PRM Table 32);
        # rrc/rlc всегда 2-операндные (ротация через C на 1).
        if len(ins.ops) == 2 and base in ('asl', 'lsr', 'asr', 'ror'):
            dn = regnum(ins.ops[0])
            b = self._val(ins.ops[1])
            cnt = 1
        else:
            dn, b, cnt = self._3op(ins)
            cnt &= 31
        if base == 'asl':
            r = (b << cnt) & M32
            c = ((b >> (32 - cnt)) & 1) if cnt else 0
        elif base == 'lsr':
            r = (b >> cnt) & M32
            c = ((b >> (cnt - 1)) & 1) if cnt else 0
        elif base == 'asr':
            r = (s32(b) >> cnt) & M32
            c = ((b >> (cnt - 1)) & 1) if cnt else 0
        elif base == 'ror':
            r = ((b >> cnt) | (b << (32 - cnt))) & M32 if cnt else b
            c = ((b >> (cnt - 1)) & 1) if cnt else 0
        elif base == 'rrc':
            r = ((b >> 1) | (self.flags['C'] << 31)) & M32
            c = b & 1
        elif base == 'rlc':
            r = ((b << 1) | self.flags['C']) & M32
            c = (b >> 31) & 1
        else:
            raise EmuError('сдвиг %r' % base)
        if dn is not None:
            self.write_reg(dn, r)
        if ins.setf:
            self._set_logic_flags(r, c=c)

    def _bit(self, ins):
        if not self._cond_ok(ins):
            return
        base = self._base(ins)
        if base == 'btst':
            a = self._val(ins.ops[0])
            b = self._val(ins.ops[1]) & 31
            bit_set = (a >> b) & 1
            self.set_flags(z=(bit_set == 0), n=(1 if b == 31 and bit_set else 0))
            return
        dn, b, c = self._3op(ins)
        bit = c & 31
        if base == 'bmsk':
            m = M32 if (c & 31) == 31 else ((1 << ((c & 31) + 1)) - 1) & M32
            r = (b & m) & M32
        elif base == 'bset':
            r = (b | (1 << bit)) & M32
        elif base == 'bclr':
            r = (b & ~(1 << bit)) & M32
        else:  # bxor
            r = (b ^ (1 << bit)) & M32
        if dn is not None:
            self.write_reg(dn, r)
        if ins.setf:
            self._set_logic_flags(r)

    def _ext(self, ins):
        if not self._cond_ok(ins):
            return
        dn, b, _ = self._3op(ins)
        base = self._base(ins)
        if base == 'extb':
            r = b & 0xff
        elif base == 'extw':
            r = b & 0xffff
        elif base == 'sexb':
            r = sext(b, 8)
        elif base == 'sexw':
            r = sext(b, 16)
        else:
            raise EmuError('ext %r' % base)
        if dn is not None:
            self.write_reg(dn, r)
        if ins.setf:
            self._set_logic_flags(r)

    def _mul(self, ins):
        if not self._cond_ok(ins):
            return
        if len(ins.ops) < 3:
            raise EmuError('mul64 без операндов: %r' % ins.text)
        b = self._val(ins.ops[1])
        c = self._val(ins.ops[2])
        if self._base(ins) == 'mul64':
            p = s32(b) * s32(c)
        else:  # mulu64
            p = (b & M32) * (c & M32)
        p &= 0xffffffffffffffff
        self.regs[57] = p & M32          # mlo
        self.regs[58] = (p >> 16) & M32  # mmid
        self.regs[59] = (p >> 32) & M32  # mhi
        self.aux[0x12] = (p >> 32) & M32

    def _norm(self, ins):
        if not self._cond_ok(ins):
            return
        dn, b, _ = self._3op(ins)
        b &= M32
        # «normalization integer» = число ведущих битов, равных знаковому, − 1
        sign = b >> 31
        cnt = 0
        for i in range(31, -1, -1):
            if ((b >> i) & 1) == sign:
                cnt += 1
            else:
                break
        r = cnt - 1
        if dn is not None:
            self.write_reg(dn, r)
        if ins.setf:
            self.set_flags(z=(b == 0), n=bool(b & 0x80000000))

    def _minmax(self, ins):
        if not self._cond_ok(ins):
            return
        dn, b, c = self._3op(ins)
        base = self._base(ins)
        alu = (b - c) & M32
        if base == 'max':
            sel2 = s32(c) >= s32(b)
        else:  # min
            sel2 = s32(c) <= s32(b)
        r = (c if sel2 else b) & M32
        if dn is not None:
            self.write_reg(dn, r)
        if ins.setf:
            self.set_flags(z=(b == c), n=bool(alu & 0x80000000),
                           c=(1 if sel2 else 0),
                           v=((~(b ^ (~c & M32)) & (b ^ alu)) >> 31) & 1)


def _build_alu():
    s = CPU
    s._alu = {
        'add': lambda c, i: c._alu_op(i, lambda b, x, C: c._add_fn(b, x, C)),
        'add1': lambda c, i: c._alu_op(i, lambda b, x, C: c._add_fn(b, x, C, 1)),
        'add2': lambda c, i: c._alu_op(i, lambda b, x, C: c._add_fn(b, x, C, 2)),
        'add3': lambda c, i: c._alu_op(i, lambda b, x, C: c._add_fn(b, x, C, 3)),
        'sub': lambda c, i: c._alu_op(i, c._sub_fn),
        'sub1': lambda c, i: c._alu_op(i, lambda b, x, C: c._sub_fn(b, x, C, 1)),
        'sub2': lambda c, i: c._alu_op(i, lambda b, x, C: c._sub_fn(b, x, C, 2)),
        'sub3': lambda c, i: c._alu_op(i, lambda b, x, C: c._sub_fn(b, x, C, 3)),
        'adc': lambda c, i: c._alu_op(i, c._adc_fn),
        'sbc': lambda c, i: c._alu_op(i, c._sbc_fn),
        'and': lambda c, i: c._alu_op(i, c._logic_fn(lambda b, x: b & x)),
        'or': lambda c, i: c._alu_op(i, c._logic_fn(lambda b, x: b | x)),
        'xor': lambda c, i: c._alu_op(i, c._logic_fn(lambda b, x: b ^ x)),
        'bic': lambda c, i: c._alu_op(i, c._logic_fn(lambda b, x: b & (~x & M32))),
        'neg': lambda c, i: c._alu_op(i, lambda b, x, C: c._sub_fn(0, b, C)),
        'not': lambda c, i: c._alu_op(i, lambda b, x, C: ((~b) & M32, {})),
        'abs': lambda c, i: c._alu_op(i, lambda b, x, C: (abs(s32(b)) & M32,
                    {'c': (b >> 31) & 1, 'v': 1 if b == 0x80000000 else 0})),
        'rsub': lambda c, i: c._alu_op(i, lambda b, x, C: c._sub_fn(x, b, C)),
        'cmp': lambda c, i: c._cmp(i),
        'rcmp': lambda c, i: c._cmp(i),
        'tst': lambda c, i: c._cmp(i),
        'asl': lambda c, i: c._shift(i),
        'lsr': lambda c, i: c._shift(i),
        'asr': lambda c, i: c._shift(i),
        'ror': lambda c, i: c._shift(i),
        'rrc': lambda c, i: c._shift(i),
        'rlc': lambda c, i: c._shift(i),
        'bset': lambda c, i: c._bit(i),
        'bclr': lambda c, i: c._bit(i),
        'bxor': lambda c, i: c._bit(i),
        'btst': lambda c, i: c._bit(i),
        'bmsk': lambda c, i: c._bit(i),
        'extb': lambda c, i: c._ext(i),
        'extw': lambda c, i: c._ext(i),
        'sexb': lambda c, i: c._ext(i),
        'sexw': lambda c, i: c._ext(i),
        'mul64': lambda c, i: c._mul(i),
        'mulu64': lambda c, i: c._mul(i),
        'norm': lambda c, i: c._norm(i),
        'min': lambda c, i: c._minmax(i),
        'max': lambda c, i: c._minmax(i),
    }


_build_alu()


def parse_fw(blob):
    """Разобрать .fw образ (заголовок <HHI>) → список (host_addr, payload).

    Возвращает только записи типа 2 (сегменты код/данные) как (адрес, байты).
    """
    import struct
    HEAD = struct.Struct('<HHI')
    recs, off = [], 0
    while off + HEAD.size <= len(blob):
        typ, flags, size = HEAD.unpack_from(blob, off)
        payload = blob[off + HEAD.size: off + HEAD.size + size]
        if len(payload) != size:
            break
        if typ == 2 and len(payload) >= 4:
            addr = struct.unpack_from('<I', payload, 0)[0]
            recs.append((addr, payload[4:]))
        off += HEAD.size + size
    return recs


# --------------------------------------------------------------------------- #
# Двухъядерная система (fw + uc) с общей памятью и потактовым планировщиком.
# --------------------------------------------------------------------------- #

class System:
    """Два ядра ARC600 (user-CPU `fw` и MAC-CPU `uc`) с общей памятью.

    Общая память (`self.mem`) и MMIO-регионы (`self.mmio_regions`) разделяются
    между ядрами: оба видят fw_data 0x800000 и периферию. Код декодируется на
    своём ядре (fw._code_regions / uc._code_regions). Планировщик — круговой
    потактный (по одной инструкции на активное ядро за `step()`).

    Модель межъядерного обмена: общая память (fw_data) + межъядерные прерывания
    (запись в aux 0x202 одного ядра будит другое; доставка по таблице векторов,
    возврат `j.f [ilink]`). Функциональная RGF-периферия НЕ моделируется — MMIO
    остаётся детерминированной заглушкой-трассой.
    """

    # адреса областей Sparrow (ARC-рантайм, см. rewrite/uc/uc.ld и fw/fw.ld)
    FW_CODE = 0x8c0000
    FW_DATA = 0x800000
    UC_CODE = 0x920000
    UC_DATA = 0x940000

    def __init__(self, seed=0x5EED):
        self.mem = {}
        self.mmio_regions = []
        self.mac_regs = {}   # общий регистровый файл MAC (расширенные r32..r56)
        self.io_hooks = {}   # модели конкретных MMIO-регистров (addr -> (rd, wr))
        self.fw = CPU(seed, mem=self.mem, mmio_regions=self.mmio_regions, label='fw',
                      functional_mmio=True, mac_regs=self.mac_regs,
                      io_hooks=self.io_hooks)
        self.uc = CPU(seed, mem=self.mem, mmio_regions=self.mmio_regions, label='uc',
                      functional_mmio=True, mac_regs=self.mac_regs,
                      io_hooks=self.io_hooks)
        self.fw.vector_base = self.FW_CODE
        self.uc.vector_base = self.UC_CODE
        # две адресные проекции ICCM: код виден и с 0, и со своей базы
        self.fw.alias = [(0, 0x40000, self.FW_CODE)]   # fw ICCM 256 КБ
        self.uc.alias = [(0, 0x20000, self.UC_CODE)]   # uc ICCM 128 КБ
        # межъядерные прерывания: запись в 0x202 одного ядра будит другое
        self.fw.irq_hook = lambda v: self.uc.request_irq(v & 31)
        self.uc.irq_hook = lambda v: self.fw.request_irq(v & 31)
        self.tick = 0
        self._init_spi()

    def _init_spi(self):
        """Модель SPI-контроллера (flash): статус всегда «idle + ready».

        0x8801a8 — статус: бит 31 = busy (0 = готов), бит 29 = ready (1 = готов).
        Возвращаем 0x20000000, чтобы опросы hwd_spi_poll_done/hwd_spi_read
        завершались сразу. FIFO 0x8800a8 читается как обычная память.
        """
        def spi_status_read(cpu, addr):
            return 0x20000000
        self.io_hooks[0x8801a8] = (spi_status_read, None)

    def interrupt(self, core, n):
        """Вручную запросить прерывание по вектору n на ядре core ('fw'/'uc')."""
        (self.fw if core == 'fw' else self.uc).request_irq(n)

    def mmio(self, lo, hi):
        """Объявить общий MMIO-регион (виден обоим ядрам)."""
        self.mmio_regions.append((lo, hi))

    def load_data(self, addr, data):
        """Загрузить данные в общую память (видимы обоим ядрам)."""
        data = bytes(data)
        for i, b in enumerate(data):
            self.mem[addr + i] = b

    def load_fw(self, code, data=b''):
        """Загрузить fw_code (0x8c0000) и, опционально, fw_data (0x800000)."""
        self.fw.load(self.FW_CODE, code, is_code=True)
        if data:
            self.load_data(self.FW_DATA, data)
        self.fw.pc = self.FW_CODE          # reset-вектор

    def load_uc(self, code, data=b''):
        """Загрузить uc_code (0x920000) и, опционально, uc_data (0x940000)."""
        self.uc.load(self.UC_CODE, code, is_code=True)
        if data:
            self.load_data(self.UC_DATA, data)
        self.uc.pc = self.UC_CODE          # reset-вектор

    def load_vendor_data(self, fw_path):
        """Загрузить вендорские данные из .fw образа.

        Извлекает сегменты: fw_data (host 0x900000 → ARC 0x800000), uc_data
        (0x940000) и board-таблицы (0x88a0xx) и кладёт их в общую память.
        Возвращает список (arc_addr, size) загруженных сегментов.
        """
        blob = open(fw_path, 'rb').read()
        loaded = []
        for host_addr, payload in parse_fw(blob):
            if 0x900000 <= host_addr < 0x920000:     # fw_data → ARC 0x800000
                arc = self.FW_DATA
            elif 0x940000 <= host_addr < 0x960000:   # uc_data
                arc = self.UC_DATA
            elif 0x88a000 <= host_addr < 0x88b000:   # board-данные (AGC)
                arc = host_addr
            else:
                continue
            self.load_data(arc, payload)
            loaded.append((arc, len(payload)))
        return loaded

    def step(self):
        """Один такт: по одной инструкции на каждое не-halted ядро (круговой)."""
        for c in (self.fw, self.uc):
            if not c.halted:
                c.step()
        self.tick += 1

    def run(self, max_ticks=None, stop=None):
        """Исполнять оба ядра, пока не упрутся в halt / stop / лимит тактов."""
        limit = max_ticks or 10_000_000
        for _ in range(limit):
            if stop is not None and (self.fw.pc == (stop & M32) or self.uc.pc == (stop & M32)):
                break
            if self.fw.halted and self.uc.halted:
                break
            self.step()
        return self.tick

    def read(self, addr, size=4):
        """Читать из общей памяти (для проверки результата)."""
        addr &= M32
        v = 0
        for i in range(size):
            v |= self.mem.get(addr + i, 0) << (8 * i)
        return v & M32


# --------------------------------------------------------------------------- #
# Самопроверка (python3 cpu.py) — небольшие ARC600-программы через as/ld.
# --------------------------------------------------------------------------- #

def _assemble(src, base=0):
    """Собрать ARC600 asm -> байты .text (для тестов), .text по адресу base."""
    tmp = tempfile.mkdtemp(prefix='arcemu-test-')
    try:
        s = os.path.join(tmp, 't.s')
        o = os.path.join(tmp, 't.o')
        e = os.path.join(tmp, 't.elf')
        b = os.path.join(tmp, 't.bin')
        with open(s, 'w') as f:
            f.write(src.replace(';', '\n'))
        subprocess.run([AS, '-mcpu=arc600', '-o', o, s], check=True, capture_output=True)
        subprocess.run([LD, '-Ttext=0x%x' % base, '-o', e, o], check=True, capture_output=True)
        subprocess.run([OBJCOPY, '-O', 'binary', '--only-section=.text', e, b],
                       check=True, capture_output=True)
        return open(b, 'rb').read()
    finally:
        shutil.rmtree(tmp, ignore_errors=True)


def _selftest():
    ok = True

    def check(c, expect_regs=None, expect_mem=None):
        nonlocal ok
        if expect_regs:
            for n, v in expect_regs.items():
                if c.regs[n] & M32 != v & M32:
                    print('  FAIL reg r%d = 0x%x, ожидалось 0x%x' % (n, c.regs[n], v))
                    ok = False
        if expect_mem:
            for a, v in expect_mem.items():
                if c.read(a, 4) & M32 != v & M32:
                    print('  FAIL mem[0x%x] = 0x%x, ожидалось 0x%x' % (a, c.read(a, 4), v))
                    ok = False

    def run_prog(label, code, init, expect_regs=None, expect_mem=None):
        c = CPU(seed=1)
        c.load(0, code, is_code=True)
        for n, v in init.items():
            c.regs[n] = v
        c.run(0, stop=0x100, max_steps=5000)
        print('%-28s pc=0x%x' % (label, c.pc))
        check(c, expect_regs, expect_mem)
        return c

    run_prog('арифметика', _assemble(
        'add r0,r1,r2; add.f r3,r1,r2; sub r4,r1,r2; mov r5,0x12345678;'
        'and r6,r1,r2; or r7,r1,r2; xor r8,r1,r2; bic r9,r1,r2; j [blink]'),
        {1: 10, 2: 3, 31: 0x100},
        expect_regs={0: 13, 3: 13, 4: 7, 5: 0x12345678, 6: 2, 7: 11, 8: 9, 9: 8})
    run_prog('сдвиги/биты', _assemble(
        'asl r0,r1,2; lsr r2,r1,2; bset r3,r1,3; bclr r4,r1,0;'
        'bmsk r5,r1,3; sexb r6,r1; extb r7,r1; j [blink]'),
        {1: 0x00000055, 31: 0x100},
        expect_regs={0: 0x154, 2: 0x15, 3: 0x5d, 4: 0x54, 5: 5, 6: 0x55, 7: 0x55})
    run_prog('mulu64', _assemble(
        'mulu64 r1,r2; mov r0,mlo; mov r3,mhi; j [blink]'),
        {1: 0x10000000, 2: 0x10, 31: 0x100},
        expect_regs={0: 0x00000000, 3: 0x1})
    run_prog('ld/st + writeback', _assemble(
        'st r1,[r2]; ld r0,[r2]; stb r4,[r2,2]; ldb r5,[r2,2];'
        'ld.aw r6,[r2,4]; j [blink]'),
        {1: 0xdeadbeef, 2: 0x1000, 4: 0x77, 31: 0x100},
        expect_regs={0: 0xdeadbeef, 5: 0x77, 2: 0x1004},
        expect_mem={0x1000: 0xde77beef})
    run_prog('ветвление + delay-слот', _assemble(
        'mov r0,1; b.d 1f; mov r0,2; mov r0,3; 1: mov r1,0xaa; j [blink]'),
        {31: 0x100}, expect_regs={0: 2, 1: 0xaa})
    run_prog('цикл lp', _assemble(
        'mov lp_count,3; lp 1f; add r0,r0,1; 1: nop; j [blink]'),
        {31: 0x100}, expect_regs={0: 3})

    # --- регрессии, найденные глубоким ревью ------------------------------ #
    # однооперандные сдвиги = сдвиг на 1
    run_prog('сдвиг на 1 (2 операнда)', _assemble(
        'asl r0,r1; lsr r2,r1; asr r3,r1; j [blink]'),
        {1: 5, 31: 0x100}, expect_regs={0: 10, 2: 2, 3: 2})
    # norm = число ведущих знаковых битов − 1
    run_prog('norm', _assemble(
        'norm r0,r1; norm r2,r3; norm r4,r5; norm r6,r7; j [blink]'),
        {1: 1, 3: 0x7fffffff, 5: 0x80000000, 7: 0xffffffff, 31: 0x100},
        expect_regs={0: 30, 2: 0, 4: 0, 6: 31})
    # .ab: адрес = база (без offset), writeback после
    run_prog('ld.ab (pop-идиома)', _assemble(
        'st r5,[r6]; ld.ab r0,[r6,4]; j [blink]'),
        {5: 0xdeadbeef, 6: 0x1000, 31: 0x100},
        expect_regs={0: 0xdeadbeef, 6: 0x1004})
    # .as с непосредственным смещением масштабируется на размер слова
    run_prog('ld.as (imm масштаб)', _assemble(
        'st r5,[r6,8]; ld.as r0,[r6,2]; j [blink]'),
        {5: 0xdeadbeef, 6: 0x1000, 31: 0x100}, expect_regs={0: 0xdeadbeef})
    # абсолютная адресация [imm]
    run_prog('абсолютный [imm]', _assemble(
        'st r5,[0x2000]; ld r0,[0x2000]; j [blink]'),
        {5: 0x12345678, 31: 0x100}, expect_regs={0: 0x12345678},
        expect_mem={0x2000: 0x12345678})
    # bl.d: BLINK = адрес ПОСЛЕ delay-слота
    c = run_prog('bl.d возврат', _assemble(
        'bl.d 1f; mov r0,0xaa; 1: nop; j [blink]'),
        {31: 0x100}, expect_regs={})
    if c.regs[31] != 0x8:
        print('  FAIL blink = 0x%x, ожидалось 0x8' % c.regs[31])
        ok = False
    # условный mul64 при ложном условии не выполняется
    run_prog('условный mul64', _assemble(
        'mulu64.eq r1,r2; mov r0,mlo; j [blink]'),
        {1: 3, 2: 4, 31: 0x100}, expect_regs={0: 0})
    # lp: взятый переход на LP_END — ВЫХОД из цикла (не возврат к lp_start)
    run_prog('lp: выход переходом на lp_end', _assemble(
        'mov lp_count,10; mov r0,0; lp 1f; add r0,r0,1; cmp r0,3; beq 1f; nop; 1: j [blink]'),
        {31: 0x100}, expect_regs={0: 3})
    # lp: последовательное достижение LP_END — N итераций (как было)
    run_prog('lp: N итераций', _assemble(
        'mov lp_count,5; mov r0,0; lp 1f; add r0,r0,2; 1: j [blink]'),
        {31: 0x100}, expect_regs={0: 10})
    # lp: взятый переход ПОСЛЕДНЕЙ инструкцией цикла — LP_COUNT всё равно декрементируется
    # (PRM «ARC 600 Loop Operation»); переход из середины — без декремента
    run_prog('lp: переход на последнем месте', _assemble(
        'mov lp_count,10; mov r0,0; lp 1f; add r0,r0,1; cmp r0,3; beq 1f; 1: mov r1,lp_count; j [blink]'),
        {31: 0x100}, expect_regs={0: 3, 1: 7})
    run_prog('lp: выход из середины', _assemble(
        'mov lp_count,10; mov r0,0; lp 1f; add r0,r0,1; cmp r0,3; beq 1f; nop; 1: mov r1,lp_count; j [blink]'),
        {31: 0x100}, expect_regs={0: 3, 1: 8})
    # lp: LP_COUNT == 0 — тело один раз, счётчик 0 → 0xffffffff
    run_prog('lp: lp_count = 0', _assemble(
        'mov lp_count,0; mov r0,0; lp 1f; add r0,r0,1; nop; 1: mov r1,lp_count; j [blink]'),
        {31: 0x100}, expect_regs={0: 1, 1: 0xffffffff})

    # bl.d / j.d с перехватом: hook видит регистры ПОСЛЕ delay-слота
    seen = []

    def hook(cpu, target, is_tail, args):
        if not (0 <= target < 0x40) and target != 0x100:
            seen.append((target, is_tail, args[1]))
            return ('stub', 0x55, None)
        return None
    c = CPU(seed=1)
    c.load(0, _assemble('mov r1,1; bl.d 0x80; mov r1,2; mov r2,r0; j.d 0x200; mov r1,7'), is_code=True)
    c.call_hook, c.func_range, c.regs[31] = hook, (0, 0x40), 0x100
    c.run(0, stop=0x100, max_steps=100)
    good = (seen == [(132, False, 2), (512, True, 7)] and c.regs[2] == 0x55 and c.pc == 0x100)
    print('%-28s %s %s' % ('перехват bl.d/j.d после слота', 'OK' if good else 'FAIL', seen))
    ok = ok and good

    # diff_world: стабильная RAM, счётчики чтений MMIO — по адресу
    a1, a2 = CPU(seed=7, diff_world=True), CPU(seed=7, diff_world=True)
    for c in (a1, a2):
        c.mmio(0x880000, 0x890000)
    r_ram = (a1.read(0x5000, 4), a1.read(0x5000, 4))
    x1 = a1.read(0x880010, 4); a1.read(0x880020, 4); x2 = a1.read(0x880010, 4)
    y1 = a2.read(0x880010, 4); y2 = a2.read(0x880010, 4)
    good = r_ram[0] == r_ram[1] and (x1, x2) == (y1, y2) and x1 != x2
    print('%-28s %s' % ('diff_world: RAM/MMIO', 'OK' if good else 'FAIL'))
    ok = ok and good
    return ok


def _system_selftest():
    """Двухъядерная проверка: fw и uc общаются через общую fw_data опросом."""
    fw_code = _assemble(
        'mov r1,0x42\n'
        'st r1,[0x800000]\n'
        '1: ld r0,[0x800004]\n'
        'breq r0,0,1b\n'
        'mov r2,r0\n'
        'sleep')
    uc_code = _assemble(
        '1: ld r0,[0x800000]\n'
        'breq r0,0,1b\n'
        'add r1,r0,r0\n'
        'st r1,[0x800004]\n'
        'sleep')

    s = System(seed=1)
    s.load_data(0x800000, b'\0' * 0x100)   # нулевая fw_data (почтовый ящик)
    s.load_fw(fw_code)
    s.load_uc(uc_code)
    s.run(max_ticks=5000)

    ok = (s.fw.regs[2] == 0x84 and s.read(0x800004) == 0x84
          and s.fw.halted and s.uc.halted)
    print('system (fw+uc): %d тактов, fw.r2=0x%x, [0x800004]=0x%x, halted=%s/%s'
          % (s.tick, s.fw.regs[2], s.read(0x800004), s.fw.halted, s.uc.halted))
    return ok


def _irq_selftest():
    """Межъядерное прерывание: fw пишет в 0x202, uc доставляет и обрабатывает."""
    uc_code = _assemble(
        'j _reset\n'
        '.org 40\n'               # слот вектора 5 (5*8=40)
        'j _handler\n'
        '_reset:\n'
        'mov r1,0xdead\n'         # значение ДО разрешения прерываний
        'flag 2\n'                # E1 — разрешить прерывания
        '1: b 1b\n'               # спин
        '_handler:\n'
        'st r1,[0x800000]\n'      # обработчик пишет в общую память
        'j.f [ilink]\n',          # возврат из прерывания
        base=0x920000)
    fw_code = _assemble(
        'mov r1,5\n'
        'sr r1,[0x202]\n'         # aux_inter_core_interrupt=5 → будит uc
        'sleep\n', base=0x8c0000)

    s = System(seed=1)
    s.load_data(0x800000, b'\0' * 0x100)
    s.load_fw(fw_code)
    s.load_uc(uc_code)
    s.run(max_ticks=5000)

    ok = (s.read(0x800000) == 0xdead and s.fw.halted)
    print('irq (fw→uc): %d тактов, [0x800000]=0x%x, fw halted=%s'
          % (s.tick, s.read(0x800000), s.fw.halted))
    return ok


def _harness_selftest():
    """Интерфейс для пофункциональной сверки: перехват вызовов, алиас ICCM,
    детерминизм по номеру чтения, полнота трассы."""
    ok = True

    # перехват bl (заглушка) + хвостовой вызов
    code = _assemble('mov r0,0x11\nbl callee\nmov r2,r0\nj [blink]\n'
                     'callee: mov r0,0x99\nj [blink]')
    calls = []

    def hook(cpu, target, is_tail, args):
        calls.append((target, is_tail, args))
        return ('stub', 0x7777, 0x8888)

    c = CPU(seed=1)
    c.load(0, code, is_code=True)
    c.blink = 0x100
    c.call_hook = hook
    c.run(0, stop=0x100, max_steps=50)
    ok = ok and c.regs[0] == 0x7777 and c.regs[2] == 0x7777 and len(calls) == 1

    # алиас ICCM: код на 0x920000 виден и с 0
    c = CPU(seed=1)
    c.load(0x920000, _assemble('mov r0,0xaa\nj [blink]'), is_code=True)
    c.alias = [(0, 0x20000, 0x920000)]
    ok = ok and c.fetch(0x0).text.startswith('mov')

    # детерминизм по номеру чтения: одинаковая последовательность -> те же значения
    c1, c2 = CPU(seed=5), CPU(seed=5)
    v1a = c1.read(0x5000, 4)
    v1b = c1.read(0x5000, 4)
    v2a = c2.read(0x5000, 4)
    v2b = c2.read(0x5000, 4)
    ok = ok and v1a != v1b and v1a == v2a and v1b == v2b
    print('harness: перехват/алиас/детерминизм', 'OK' if ok else 'FAILED')
    return ok


if __name__ == '__main__':
    import sys
    ok = _selftest()
    print('selftest:', 'OK' if ok else 'FAILED')
    ok2 = _system_selftest()
    print('system selftest:', 'OK' if ok2 else 'FAILED')
    ok3 = _irq_selftest()
    print('irq selftest:', 'OK' if ok3 else 'FAILED')
    ok4 = _harness_selftest()
    print('harness selftest:', 'OK' if ok4 else 'FAILED')
    sys.exit(0 if (ok and ok2 and ok3 and ok4) else 1)
