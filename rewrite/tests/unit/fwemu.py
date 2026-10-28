# SPDX-License-Identifier: AGPL-3.0-or-later
"""Обвязка юнит-тестов fw (главное ядро ARC600): функции из build/fw.elf исполняются в эмуляторе (tools/arcemu/cpu.py).

    fw = FW(elf).boot()                 # код ICCM + DCCM (.fwdata.* из ELF) + «загрузка» (см. boot), снимок кэшируется
    fw.w32(a, v); fw.r8(a); fw.a('conn_mgr')   # память (DCCM 0x800000.., SRAM 0x840000.., общая с uc 0x857000..)
    fw.mmio[0x880254] = 5               # MMIO 0x880000..0x8c0000 — функциональный регистровый файл (+ mmio_read_hook)
    r0 = fw.call('fn', a0, a1, stub={'callee': 0, 'other': lambda fw, args: 1})
    fw.wmi(0x803, body)                 # команда хоста → wmi_host_cmd_dispatch, затем готовые задачи u_schd
    fw.lmac_evt(0x06, body)             # событие uc → lmac_if_ucode_event_dispatch
    fw.call('rx_pkt_handler', fw.rx_pkt(frame, cid=0))   # принятый кадр управления (буфер из rx_ring.pool)
    fw.tx_complete()                    # «железо» завершило кадры кольца TX (Ack)
    fw.advance(us); fw.fire_timer(name) # время u_schd: таймеры срабатывают по срокам, как прерывание таймера
    fw.lmac_cmds                        # [LmacCmd(type, len, flags, body)] — команды LMAC fw → uc (lmac_if_post_cmd)
    fw.wmi_evts                         # [WmiEvt(id, len, mid, body)] — события WMI fw → хост (wmi_evt_post)
    fw.tx_frames                        # [(кольцо, кадр)] — кадры, поставленные в кольцо TX (tx_ring_post_frame)
    fw.logs; fw.logged('WMI_BAD_PARAM') # журнал fw (уровень, токен, аргументы); fw.rejects — wmi_reject_param
    fw.timers(); fw.ready_tasks()       # взведённые таймеры [(cb, a0, a1, срок, задача)] / готовые задачи u_schd
    fw.wild                             # обращения вне карты памяти fw (на чипе — зависание шины AHB)

Перехват — по PC входа в функцию (а не по инструкции вызова): ловятся bl/jl, хвостовые b/j и вызовы через указатель.
Заглушка: функция не исполняется, r0 = значение (или результат callable(fw, args)), возврат по blink.
Всегда перехвачены: ассерт fw (FwAssert с кодом и путём), недопустимое событие автомата (SmError),
вечный опрос MMIO (SpinError), журнал fw_log_emit*, отправка команд LMAC и событий WMI (буферы ящиков — из области
теста; события хост «читает» сразу: буферы кадров RX/TX возвращаются в пулы колбэками кольца).
"""
import collections, os, struct, sys

HERE = os.path.dirname(os.path.abspath(__file__))
REW = os.path.dirname(os.path.dirname(HERE))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(REW, 'tools', 'arcemu'))
sys.path.insert(0, os.path.join(REW, 'tools'))
import cpu as cpumod                                    # noqa: E402
from ucemu import _sections                             # noqa: E402
import subprocess                                       # noqa: E402

M32 = 0xffffffff
ICCM, ICCM_SIZE = 0x8c0000, 0x40000
DCCM, DCCM_SIZE = 0x800000, 0x8000
SRAM, SRAM_END = 0x840000, 0x860000      # рабочая память fw (fw/fw.ld) + общий с uc блок 0x857000
SENTINEL = 0x8ff000                      # адрес возврата из тестируемой функции (ICCM, вне кода)
SP0 = DCCM + DCCM_SIZE                   # __stack_top (fw/fw.ld)
GP = 0x800184                            # __gp
MMIO_LO, MMIO_HI = 0x880000, 0x8c0000

LmacCmd = collections.namedtuple('LmacCmd', 'type len flags body')
WmiEvt = collections.namedtuple('WmiEvt', 'id len mid body')


class SpinError(RuntimeError):
    pass


class SmError(RuntimeError):
    """basic_sm_error_handler: событие, недопустимое в состоянии автомата (у fw — ассерт 0x1033)."""
    def __init__(self, sm, desc, state, event, where):
        super().__init__('автомат %#x (описатель %s): событие %d в состоянии %d недопустимо (%s)'
                         % (sm, desc, event, state, where))
        self.sm, self.desc, self.state, self.event = sm, desc, state, event


class FwAssert(RuntimeError):
    def __init__(self, code, where):
        super().__init__('ассерт fw %#x (%s)' % (code, where))
        self.code = code
        self.where = where


SPIN_MAX = 4000          # чтений одного MMIO-адреса в одной точке — вечное ожидание


def _symbols(path):
    out = subprocess.run([cpumod.TC + '/arc-elf32-nm', path], capture_output=True, text=True, check=True).stdout
    code, data = {}, {}
    for l in out.splitlines():
        p = l.split()
        if len(p) != 3:
            continue
        a, t, n = int(p[0], 16), p[1], p[2]
        if t in 'tTwW':
            code[n] = a
        elif t in 'dDbBrRaAgGsS':
            data[n] = a
    return code, data


def _func_sizes(path):
    out = subprocess.run([cpumod.TC + '/arc-elf32-nm', '-S', path], capture_output=True, text=True, check=True).stdout
    sz = {}
    for l in out.splitlines():
        p = l.split()
        if len(p) == 4:
            sz[p[3]] = int(p[1], 16)
    return sz


# Карта памяти fw (fw/fw.ld): DCCM, рабочая SRAM с общим с uc блоком (0x840000..0x858000; 0x85a000.. — буферы теста),
# MMIO; ICCM (и его младшая проекция) — только чтение (константы .rodata). Остальное — «дикое» обращение (fw.wild):
# на чипе чтение отсутствующего адреса AHB не завершается.
_MAP_RW = ((DCCM, DCCM + DCCM_SIZE), (SRAM, 0x858000), (0x85a000, SRAM_END), (MMIO_LO, MMIO_HI))
_MAP_RO = ((ICCM, ICCM + ICCM_SIZE), (0, ICCM_SIZE))


def _mapped(a, write):
    for lo, hi in _MAP_RW:
        if lo <= a < hi:
            return True
    if not write:
        for lo, hi in _MAP_RO:
            if lo <= a < hi:
                return True
    return False


class _CPU(cpumod.CPU):
    def __init__(self, owner, **k):
        super().__init__(**k)
        self._o = owner

    def read(self, addr, size):
        a = addr & M32
        if not _mapped(a, False):
            self._o.wild.append(('r', a, self._o.where(self.pc)))
        if MMIO_LO <= a < MMIO_HI:
            key = (self.pc, a)
            n = self._o._spin[key] = self._o._spin.get(key, 0) + 1
            if n > SPIN_MAX:
                raise SpinError('опрос MMIO %#x без выхода в %s (значение %#x; путь %s): задайте fw.mmio[...], '
                                'fw.mmio_read_hook или заглушку'
                                % (a, self._o.where(self.pc), self._o.mmio_get(a), self._o.history(8)))
            h = self._o.mmio_read_hook.get(a & ~3)
            if h is not None:
                v = h(self._o, a) & M32
                self.trace.append(('mmio', 'r', a, size, v))
                return v
            if not all((a + i) in self.mem for i in range(size)):
                return 0                     # неинициализированный регистр = 0
        return super().read(addr, size)

    def write(self, addr, data):
        a = addr & M32
        if not _mapped(a, True):
            self._o.wild.append(('w', a, self._o.where(self.pc)))
        if MMIO_LO <= a < MMIO_HI:
            h = self._o.mmio_write_hook.get(a & ~3)
            if h is not None:
                h(self._o, a, int.from_bytes(bytes(data), 'little'))
        return super().write(addr, data)

    def read_aux(self, addr):
        a = addr & M32
        if a in (0x21, 0x100):              # COUNT0/COUNT1 — идут: такт на инструкцию
            self._o._spin = {}
            return (self._o.t_base + self.insns) & M32
        if a not in self.aux:
            return 0
        return super().read_aux(addr)

    def read_reg(self, n):
        if 32 <= n <= 56:
            return self._o.ext.get(n, 0) & M32
        return super().read_reg(n)

    def write_reg(self, n, v):
        if 32 <= n <= 56:
            self._o.ext[n] = v & M32
            self.trace.append(('extreg', 'w', n, 4, v & M32))
            return
        return super().write_reg(n, v)

    def step(self):
        if self.halted:
            return
        pc = self.pc & M32
        if pc < ICCM_SIZE:
            pc += ICCM
        self._o._hist.append(pc)
        h = self._o._entry.get(pc)
        if h is not None:
            r = h(self)
            if r is not None:                 # заглушка: возврат по blink
                self.regs[0] = r & M32
                self.pc = self.regs[31] & M32
                self.insns += 1
                return
        super().step()


class FW:
    _cache = {}
    _decoded = {}
    _booted = {}

    def __init__(self, elf):
        if elf not in FW._cache:
            secs = _sections(elf)
            code, data = _symbols(elf)
            FW._cache[elf] = (secs, code, data, _func_sizes(elf))
        secs, self.sym, self.data_sym, self.size = FW._cache[elf]
        self.elf = elf
        self.addr2sym = sorted((a, n) for n, a in self.sym.items() if ICCM <= a < ICCM + ICCM_SIZE)
        self._by_addr = {}
        for a, n in self.addr2sym:
            self._by_addr.setdefault(a, n)
        c = _CPU(self, functional_mmio=True)
        c.mmio(MMIO_LO, MMIO_HI)
        c.vector_base = ICCM
        c.alias = [(0, ICCM_SIZE, ICCM)]
        # crt0: DCCM и SRAM — нули (fw/start.S обнуляет SRAM-диапазоны; DCCM вне образа у vendor тоже 0)
        z = dict.fromkeys(range(DCCM, DCCM + DCCM_SIZE), 0)
        z.update(dict.fromkeys(range(SRAM, SRAM_END), 0))
        c.mem.update(z)
        for name, addr, d in secs:
            code = name in ('.text', '.textlate') or name.startswith('.text')
            c.load(addr, d, is_code=code)
        c._instr = FW._decoded.setdefault(elf, {})
        self.cpu = c
        self.ext = {}
        self.t_base = 0
        self._spin = {}
        self.calls = []
        self.lmac_cmds = []
        self.wmi_evts = []
        self.logs = []
        self.tx_frames = []
        self.rejects = []
        self.wild = []
        self._host_free = []
        self._depth = 0
        self.host_consumes = True              # хост сразу читает события (буферы возвращаются)
        # модели регистров с «готовностью»: счётчики MAC (HW_MAC_CNT_CTRL 0x887008) — операция сразу завершена
        self.mmio_read_hook = {0x887008: lambda fw, a: fw.mmio_get(0x887008) | 0xc0000000}
        self.mmio_write_hook = {}
        self._entry = {}
        self._hist = collections.deque(maxlen=48)
        self.default_stubs = {}
        self._install_fixed()

    # ---- адреса ----
    def a(self, name):
        """Адрес символа (функция или объект данных, включая символы fw.ld)."""
        if name in self.data_sym:
            return self.data_sym[name]
        return self.sym[name]

    def where(self, pc):
        import bisect
        pc &= M32
        if pc < ICCM_SIZE:
            pc += ICCM
        i = bisect.bisect_right(self.addr2sym, (pc, '\xff')) - 1
        if i < 0:
            return '%#x' % pc
        a, n = self.addr2sym[i]
        return '%s+%#x' % (n, pc - a)

    _LS = None

    @classmethod
    def ls_fw(cls, name):
        """Токен своей строки журнала fw LS_FW(name) (include/logstr.h, include/logstr_fw*.def)."""
        if cls._LS is None:
            import logstr
            items = logstr.parse_def(open(os.path.join(REW, 'include', 'logstr_fw.def')).read())
            pro = os.path.join(REW, 'include', 'logstr_fw_pro.def')
            if os.path.exists(pro):
                items += logstr.parse_def(open(pro).read())
            off, cls._LS = 0, {}
            for n, sv in items:
                cls._LS[n] = 0x1030000 + off
                off += len(sv) + 1
        return cls._LS[name]

    def logged(self, token):
        """Записи журнала fw с токеном (число или имя своей строки LS_FW): [(уровень, токен, аргументы…)]."""
        if isinstance(token, str):
            token = self.ls_fw(token)
        return [l for l in self.logs if l[1] == token]

    def data_name(self, addr):
        for n, a in self.data_sym.items():
            if a == addr:
                return n
        return '%#x' % addr

    def name_of(self, addr):
        addr &= M32
        if addr < ICCM_SIZE:
            addr += ICCM
        return self._by_addr.get(addr, '%#x' % addr)

    # ---- память ----
    def r8(self, a): return self.cpu.read(a, 1)
    def r16(self, a): return self.cpu.read(a, 2)
    def r32(self, a): return self.cpu.read(a, 4)
    def w8(self, a, v): self.cpu.write(a, bytes([v & 0xff]))
    def w16(self, a, v): self.cpu.write(a, struct.pack('<H', v & 0xffff))
    def w32(self, a, v): self.cpu.write(a, struct.pack('<I', v & M32))
    def rbytes(self, a, n): return bytes(self.cpu.mem.get(a + i, 0) for i in range(n))

    def wbytes(self, a, data):
        for i, x in enumerate(bytes(data)):
            self.cpu.mem[a + i] = x

    def snapshot(self, ranges):
        """{адрес: байт} по списку (lo, hi) — для сравнения состояний."""
        m = self.cpu.mem
        return {a: m.get(a, 0) for lo, hi in ranges for a in range(lo, hi)}

    @property
    def mmio(self):
        fw = self

        class _M:
            def __setitem__(s, a, v): fw.cpu.mem.update({a + i: (v >> (8 * i)) & 0xff for i in range(4)})
            def __getitem__(s, a): return fw.mmio_get(a)
        return _M()

    def mmio_get(self, a):
        return int.from_bytes(bytes(self.cpu.mem.get(a + i, 0) for i in range(4)), 'little')

    # ---- перехваты ----
    def _install_fixed(self):
        def fw_assert(cpu):
            raise FwAssert(cpu.regs[1] & M32, '%s; путь: %s' % (self.where(cpu.regs[31]), self.history(12)))
        for n in ('fw_sysassert_fatal', 'fw_sysassert'):
            if n in self.sym:
                self._entry_fixed(n, fw_assert)

        def sm_err(cpu):
            sm = cpu.regs[0] & M32
            d = self.r32(sm + 4)
            raise SmError(sm, self.data_name(d), self.r8(sm), self.r8(sm + 1), self.history(6))
        self._entry_fixed('basic_sm_error_handler', sm_err)

        def post_cmd(cpu):
            body, typ, ln, fl = (cpu.regs[i] & M32 for i in range(4))
            self.lmac_cmds.append(LmacCmd(typ, ln, fl, self.rbytes(body, ln)))
            self._scratch_free(body)
            return 0
        self._entry_fixed('lmac_if_post_cmd', post_cmd)
        # буферы ящиков (команды LMAC, события WMI): из своей области — кольца ящиков хоста/uc в тесте не крутятся
        self._entry_fixed('lmac_cmd_pool_alloc', lambda cpu: self._scratch_alloc(0x110) + 0x10)
        self._entry_fixed('mem_pool_alloc_locked', lambda cpu: self._scratch_alloc(0x610) + 0x10)

        def evt_post(cpu):
            r = [cpu.regs[i] & M32 for i in range(8)]
            ln = r[4] + (8 if r[2] == 0 else 0)
            self.wmi_evts.append(WmiEvt(r[3], r[4], r[5], self.rbytes(r[1], min(ln, 0x600))))
            # хост прочитал событие: буфер с флагом 1 (кадр RX) — wmi_evt_alloc_and_fill, с флагом 2 (кадр TX) —
            # tx_api_free_memory (колбэки кольца событий, mbox_init_descriptor); без флагов — буфер ящика (у теста
            # из своей области). Выполняется после возврата из текущего вызова (call не реентерабелен).
            if r[6]:
                self._host_free.append(('wmi_evt_alloc_and_fill', r[1]))
            elif r[7]:
                self._host_free.append(('tx_api_free_memory', r[1]))
            return 0
        self._entry_fixed('wmi_evt_post', evt_post)

        # кадры, поставленные в кольцо TX (DMA): (кольцо, байты кадра) — «эфир» fw
        def post_frame(cpu):
            tr, pl, ln = (cpu.regs[i] & M32 for i in range(3))
            self.tx_frames.append((tr, self.rbytes(pl, min(ln, 0x600))))
            return None                                 # исполнять
        self._entry_fixed('tx_ring_post_frame', post_frame)

        def reject(cpu):
            self.rejects.append(tuple(cpu.regs[i] & M32 for i in range(3)))
            return None
        if 'wmi_reject_param' in self.sym:
            self._entry_fixed('wmi_reject_param', reject)
        # журнал fw: аргументы (уровень, токен, …) — для проверок «залогировано»
        for n in ('fw_log_emit0', 'fw_log_emit1', 'fw_log_emit2', 'fw_log_emit3'):
            if n in self.sym:
                k = int(n[-1])
                self._entry_fixed(n, (lambda k: lambda cpu: self.logs.append(
                    tuple(cpu.regs[i] & M32 for i in range(2 + k))) or 0)(k))

    def _entry_fixed(self, name, fn):
        self._entry[self.sym[name]] = fn
        self._fixed = getattr(self, '_fixed', set()) | {self.sym[name]}

    # пул буферов команд LMAC / событий WMI для заглушек: свободная область SRAM (выше всех объектов fw.ld)
    _SCR_LO, _SCR_HI = 0x85a000, 0x85f000

    def _scratch_alloc(self, n):
        p = getattr(self, '_scr', self._SCR_LO)
        if p + n > self._SCR_HI:
            p = self._SCR_LO
        self._scr = p + n
        for i in range(n):
            self.cpu.mem[p + i] = 0
        return p

    def _scratch_free(self, p):
        pass

    def _install_stubs(self, stub):
        self._entry = {a: f for a, f in self._entry.items() if a in self._fixed}
        allst = dict(self.default_stubs)
        allst.update(stub or {})
        bad = [n for n in allst if n not in self.sym]
        if bad:
            raise KeyError('нет символов в fw.elf: %s' % bad)
        for n, v in allst.items():
            a = self.sym[n]

            def h(cpu, n=n, v=v):
                args = tuple(cpu.regs[i] & M32 for i in range(8))
                self.calls.append((n, args))
                if callable(v):
                    r = v(self, args)
                    return 0 if r is None else r
                return 0 if v is None else v
            self._entry[a] = h

    # ---- вызов ----
    def call(self, fn, *args, stub=None, max_steps=3_000_000):
        """Исполнить fn(args) до возврата. stub: {имя: r0 | callable(fw, args) | None}. Возврат — r0."""
        self._install_stubs(stub)
        c = self.cpu
        c.set_regs({i: a for i, a in enumerate(args)})
        c.sp = SP0 - 0x40
        c.regs[26] = GP
        c.blink = SENTINEL
        c.halted = False
        c.aux[0x0a] = 0
        self._spin = {}
        start = self.sym[fn] if isinstance(fn, str) else fn
        self._depth += 1
        try:
            c.run(start, stop=SENTINEL, max_steps=max_steps)
        except (FwAssert, SpinError, SmError):
            raise
        except Exception as e:
            raise RuntimeError('%s: %s; последние PC: %s' % (fn, e, self.history())) from e
        finally:
            self._depth -= 1
        if c.exhausted:
            raise RuntimeError('%s: не вернулась за %d шагов (pc=%#x в %s)' % (fn, max_steps, c.pc, self.where(c.pc)))
        c.trace.clear()
        r0 = c.regs[0] & M32
        if self._depth == 0 and self.host_consumes:
            while self._host_free:
                f, pl = self._host_free.pop(0)
                self.call(f, pl, stub=stub)
        return r0

    def history(self, n=16):
        """Последние n переходов между функциями (для диагностики сбоя)."""
        out = []
        for pc in self._hist:
            w = self.where(pc).split('+')[0]
            if not out or out[-1] != w:
                out.append(w)
        return ' > '.join(out[-n:])

    def stub_calls(self, name):
        return [a for n, a in self.calls if n == name]

    # ---- загрузка ----
    # Шаги fw_main, ждущие железо (PCIe SerDes, счётчики MAC), — заглушки; остальное исполняется как на чипе.
    BOOT_STUBS = {'pcie_serdes_init': 0, 'u_schd_run': 0,
                  'power_start_two_timers': 0, 'hwd_rfc_read_calibrate': 0, 'temp_sense_get_cached': 0}
    BOOT_TX_SECTORS = 32
    BOOT_TIME = 0x10000                  # время u_schd при загрузке (тики 16 мкс ≈ 1 с)
    BOOT_MMIO = {0x880200: 1 << 6}     # HW_BOOT_WAIT_880200 б6: HW boot done (fw_main «HW statemachine WA»)

    @staticmethod
    def rx_chain_cmd(ring_size=0x400, mpdu=0x800):
        """WMI_CFG_RX_CHAIN (struct wmi_cfg_rx_chain_cmd) как у wil6210 при подъёме интерфейса: кольцо RX хоста,
        программная переупорядочивание (reorder_type 1), без sniffer."""
        b = bytearray(0x38)
        struct.pack_into('<IIHH', b, 4, 0x10000000, 0, ring_size, mpdu)   # sw_ring {base u64, size u16, mpdu u16}
        b[0x22] = 1
        return bytes(b)

    def boot(self, lmac_ready=True, driver_up=True):
        """Состояние «после загрузки»: crt0 (нули SRAM — уже в __init__), статические конструкторы, fw_main до входа
        в цикл u_schd_run, инициализация очередей таймеров u_schd_run и (lmac_ready) событие LMAC READY от uc —
        l2mgr_on_lmac_ready (WMI_READY). Снимок памяти кэшируется на ELF: повторный boot() — копия."""
        key = (self.elf, lmac_ready, driver_up)
        if key not in FW._booted:
            for a, v in self.BOOT_MMIO.items():
                self.mmio[a] = v
            self.mmio[self.SYS_TIMER] = self.BOOT_TIME   # не 0: «свежесть» по времени (now − t < N) у fw считается
            self.call('static_ctors_run')
            self.call('fw_main', stub=self.BOOT_STUBS)
            us = self.a('u_schd')
            self.call('u_schd_init_queue', self.r32(us))
            self.call('u_schd_init_queue', self.r32(us + 4))
            # board-файл хоста «загружен»: rf_obj.brd_if = &rf_obj.brd, TX-секторов BOOT_TX_SECTORS (стенд — 32)
            rf = self.a('rf_obj')
            self.w32(rf + 0x58, rf + 4)
            for i in range(0x40):
                self.w8(rf + 4 + i, i if i < self.BOOT_TX_SECTORS else 0xff)
            self.w8(rf + 4 + 0x40, self.BOOT_TX_SECTORS)
            self.w8(rf + 0x45c, 1)
            self.w8(rf + 0x45d, 1)
            if lmac_ready:
                self.call('lmac_if_lmac_ready_evt', stub=self.BOOT_STUBS)
                self.run_tasks(stub=self.BOOT_STUBS)
                if driver_up:                           # драйвер поднял интерфейс: кольцо RX (TX-очереди, пул vring)
                    self.wmi(0x820, self.rx_chain_cmd(), stub=self.BOOT_STUBS)
            FW._booted[key] = (dict(self.cpu.mem), list(self.lmac_cmds), list(self.wmi_evts))
        mem, lc, we = FW._booted[key]
        self.cpu.mem.clear()
        self.cpu.mem.update(mem)
        self.boot_lmac_cmds, self.boot_wmi_evts = lc, we
        self.clear()
        return self

    def save(self):
        """Снимок состояния (память, MMIO, порты MAC) — для многих сценариев из одной точки."""
        return (dict(self.cpu.mem), dict(self.ext), getattr(self, '_uc_seen', 0), len(self.lmac_cmds))

    def restore(self, snap):
        mem, ext, seen, _ = snap
        self.cpu.mem.clear()
        self.cpu.mem.update(mem)
        self.ext = dict(ext)
        self.clear()
        self._uc_seen = 0

    def clear(self):
        """Забыть записанные вызовы/команды/события (перед шагом сценария)."""
        self.calls.clear()
        self.wild.clear()
        self.tx_frames.clear()
        self.rejects.clear()
        self.lmac_cmds.clear()
        self.wmi_evts.clear()
        self.logs.clear()

    # ---- хост ----
    WMI_BUF = 0x85f000                  # буфер команды хоста (mbox_hdr + тело), вне объектов fw.ld

    def wmi(self, cmd_id, body=b'', mid=0, stub=None, run=True):
        """Команда хоста: mbox_hdr (0x10 Б) + тело в буфер, wmi_host_cmd_dispatch(&operational_mbox, буфер);
        run — затем выполнить готовые задачи u_schd. Возврат — события WMI этого шага."""
        n0 = len(self.wmi_evts)
        body = bytes(body)
        hdr = struct.pack('<HHHHBBHI', 0, len(body), 0, 0, mid, 0, cmd_id, 0)
        for i in range(0x800):
            self.cpu.mem[self.WMI_BUF + i] = 0
        self.wbytes(self.WMI_BUF, hdr + body)
        self.call('wmi_host_cmd_dispatch', self.a('operational_mbox'), self.WMI_BUF, stub=stub)
        if run:
            self.run_tasks(stub=stub)
        return self.wmi_evts[n0:]

    UC_EVT_BUF = 0x85f800               # буфер события uc (mbox_hdr + тело)

    def lmac_evt(self, typ, body=b'', stub=None, run=True):
        """Событие uc → fw: mbox_hdr (type) + тело, lmac_if_ucode_event_dispatch(&lmac_mbox, буфер); run — затем
        готовые задачи u_schd. Возврат — команды LMAC этого шага."""
        n0 = len(self.lmac_cmds)
        body = bytes(body)
        for i in range(0x200):
            self.cpu.mem[self.UC_EVT_BUF + i] = 0
        self.wbytes(self.UC_EVT_BUF, struct.pack('<HHHHBBHI', 0, len(body), typ, 0, 0, 0, 0, 0) + body)
        self.call('lmac_if_ucode_event_dispatch', self.a('lmac_mbox'), self.UC_EVT_BUF, stub=stub)
        if run:
            self.run_tasks(stub=stub)
        return self.lmac_cmds[n0:]

    def rx_pkt(self, frame, cid=0, mid=0, short_hdr=False):
        """RX-буфер из настоящего пула rx_ring.pool с кадром 802.11 (заголовок 0x18 Б; short_hdr — 0xa Б, DMG Beacon):
        поля rx_pkt как у пути приёма (hdr = body = frame, info.len/qid/mid/cid). Возврат — адрес struct rx_pkt."""
        pool = self.a('rx_ring') + 0x1c
        p = self.call('mem_pool_allocate', pool)
        if not p:
            raise RuntimeError('rx_ring.pool пуст')
        for i in range(0x538):
            self.cpu.mem[p + i] = 0
        frame = bytes(frame)
        self.wbytes(p + 0x38, frame)
        self.w32(p + 0x08, p + 0x38)
        self.w32(p + 0x14, p + 0x38)
        self.w32(p + 0x28 + 0x08, len(frame))
        self.w8(p + 0x28 + 0x0c, 1 if short_hdr else 0)
        self.w8(p + 0x28 + 0x0d, mid)
        self.w8(p + 0x28 + 0x0e, cid)
        return p

    @staticmethod
    def mgmt_frame(stype, da, sa, bssid, body, fc_flags=0):
        """Кадр управления 802.11 (9.3.3.1): FC (тип 0, подтип stype), Duration, A1..A3, Sequence Control, тело."""
        fc = (stype << 4) | (fc_flags << 8)
        return struct.pack('<HH', fc, 0) + bytes(da) + bytes(sa) + bytes(bssid) + b'\0\0' + bytes(body)

    def tx_pending(self, q='tx_api_mgmt'):
        """Число дескрипторов кольца TX очереди q, ещё не завершённых «железом» (tail..head)."""
        ring = self.r32(self.a(q) + 0x8c)
        size, tail, head = self.r32(ring + 8), self.r32(ring + 0xc), self.r32(ring + 0x10)
        return (head - tail) % size if size else 0

    def tx_complete(self, q='tx_api_mgmt', status=0, stub=None, run=True):
        """«Железо» завершило все кадры кольца TX очереди q (struct fwq_tx): дескрипторам tail..head — DU и код
        status [2:0] (0 — Ack получен), затем TX_API_handle_completed_packets(q) — как прерывание DMA."""
        qa = self.a(q)
        ring = self.r32(qa + 0x8c)
        base, size, tail, head = (self.r32(ring + 4 + 4 * i) for i in range(4))
        i = tail
        while size and i != head:
            d = base + 0x20 * i
            self.w32(d + 0x1c, (self.r32(d + 0x1c) & ~7) | 0x100 | (status & 7))
            i = (i + 1) % size
        self.call('TX_API_handle_completed_packets', qa, stub=stub)
        if run:
            self.run_tasks(stub=stub)

    # ---- u_schd ----
    def _llist_items(self, l):
        out, p, k = [], self.r32(l + 4), 0
        while p and k < 0x100:
            out.append(p)
            p = self.r32(p)
            k += 1
        return out

    def ready_tasks(self):
        """[(cb-имя, a0, a1, prio)] — задачи в ready-очередях u_schd."""
        us = self.a('u_schd')
        out = []
        for prio in range(3):
            for t in self._llist_items(us + 8 + 12 * prio):
                out.append((self.name_of(self.r32(t + 0xc)), self.r32(t + 0x10), self.r32(t + 0x14), prio))
        return out

    def timers(self):
        """[(cb-имя, a0, a1, deadline, задача)] — взведённые таймеры (обе очереди u_schd)."""
        us = self.a('u_schd')
        out = []
        for q in range(2):
            tq = self.r32(us + 4 * q)
            if tq:
                for t in self._llist_items(tq):
                    out.append((self.name_of(self.r32(t + 0xc)), self.r32(t + 0x10), self.r32(t + 0x14),
                                self.r32(t + 8), t))
        return out

    def run_tasks(self, stub=None, limit=200):
        """Выполнить готовые задачи u_schd (как цикл u_schd_run), пока очереди не опустеют. Возврат — число задач."""
        n = 0
        while n < limit:
            t = self.call('u_schd_pop_ready', stub=stub)
            if not t:
                return n
            cb, a0, a1 = self.r32(t + 0xc), self.r32(t + 0x10), self.r32(t + 0x14)
            self.call(cb, a0, a1, stub=stub)
            self.call('mem_pool_free_locked_evt', t, stub=stub)
            n += 1
        raise RuntimeError('u_schd: больше %d задач подряд (цикл событий?)' % limit)

    SYS_TIMER = 0x880254                 # HW_SYS_TIMER_NOW: время u_schd (тик = 16 мкс)

    def now(self):
        return self.mmio_get(self.SYS_TIMER)

    def advance(self, us, stub=None, between=None, limit=100000):
        """Продвинуть время u_schd на us мкс как на чипе: время ставится на срок ближайшего таймера, прерывание таймера
        (u_schd_expire_timers — истёкшие в ready-очереди), цикл u_schd_run (run_tasks); between(fw) — после каждого
        шага (ответы uc). Возврат — [(имя cb, срок)] сработавших таймеров."""
        target = (self.now() + (us >> 4)) & M32
        fired = []
        for _ in range(limit):
            ts = [t for t in self.timers() if ((t[3] - target) & M32) >= 0x80000000 or t[3] == target]
            if not ts:
                break
            dl = min(t[3] for t in ts) if not any(((t[3] - self.now()) & M32) >= 0x80000000 for t in ts) \
                else self.now()
            self.mmio[self.SYS_TIMER] = dl
            fired += [(t[0], t[3]) for t in ts if t[3] == dl]
            self.call('u_schd_expire_timers', stub=stub)
            self.run_tasks(stub=stub)
            if between:
                between(self)
        else:
            raise RuntimeError('advance: больше %d шагов' % limit)
        self.mmio[self.SYS_TIMER] = target
        return fired

    def fire_timer(self, name, stub=None):
        """Сработать ближайшему таймеру с cb name (время — на его срок, остальные таймеры до него тоже срабатывают,
        как на чипе). Возврат — True, если такой таймер был."""
        ts = [t for t in self.timers() if t[0] == name]
        if not ts:
            return False
        t = min(ts, key=lambda t: (t[3] - self.now()) & M32)
        self.advance((((t[3] - self.now()) & M32) << 4), stub=stub)
        return True
