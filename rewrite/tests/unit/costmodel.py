# SPDX-License-Identifier: AGPL-3.0-or-later
"""Модель стоимости исполнения uc (ARC600, 165 МГц): шаг эмулятора → такты. Одна на модель MAC (machw.HW) и тесты
сроков (test_uc_deadlines.Meter).

Эталон — микротесты на железе (uc/bench.c, наборы 1–3, разбор tools/hwdbg/bench.py, стенд 2026-10-29); модель
воспроизводит все 135 тестов в пределах 0,3 такта (фактически ≤ 0,06) — test_cost_model.py. Таблица и особенности
по инструкциям — docs/UC-TIMING.md.
Имена в скобках — тесты uc/bench.c, числа — такты группы.

  * инструкция 1; 16- и 32-битная одинаково (NOP_S, NOP); с limm 2 — и 32-битная (8 Б: LIMM, LIMM_NOP 3,
    LIMM_NOPS2 4), и 16-битная (6 Б: LIMM_S 3, LIMM_S2 4);
  * переход b/bl/bcc выполненный: +1 без delay-слота, +0 с ним (BR 2, BR_D 2); j/jl по регистру (возврат j_s [blink])
    +2 / +1 (CALLRET 7, CALLRET_D 7); сравнение с переходом brcc/bbit +4 / +3 (BRNE 5, BRNE_D 5), без перехода 0
    (BREQ_NT_N3), но за 1 / 2 инструкции до LP_END +4 / +3 (BREQ_NT_BACK 2,25 = 2 + 4/16, BREQ_NT 2,19 = 2 + 3/16),
    за 3 и дальше — 0. brcc назад (смещение < 0) стоит 2, если прошлое его исполнение было с переходом, иначе 5 —
    с переходом или без (BREQ_NT_BK8/16/32, BREQS_NT_BK4: без перехода всегда — 5; BRCC_LOOP2*: 5 + 2,
    BRCC_LOOP3*: 5 + 2 + 2 при теле 2–14 инструкций); bcc назад без перехода — 1 (CMP_BNE_NT_BK); смещение 0 — как
    вперёд (BREQ_NT_BACK).
    Цель — 32-битная инструкция по адресу
    ≡ 2 (mod 4) (пересекает слово выборки) — ещё +1 (BR_MIS 5). Возврат на LP_START zero-overhead loop — 0, кроме
    первого возврата в цикле с телом из одной инструкции: +1 (LP3_1, LP5_1; LP1_1, LP3_2 — без добавки);
  * j/jl по регистру берут регистр на такт раньше прочих: после загрузки (pop_s blink) ждут результат + 1, после
    АЛУ (mov) — 1 такт (BL_PUSH 11, BL_POP_NOP_J 11, BL_MOVJ 10); blink от самого bl — без ожидания (CALLRET);
  * условный переход ждёт флаги: для bcc готовы через 3 такта после cmp/tst/btst/.f, выполнен переход или нет
    (CMP_BNE, CMP_BEQ_NT, CMP_N1_BNE, CMP_N2_BNE, MOVF_BEQ_NT, ANDF_BNE, TST_BNE — все 5), для jcc — через 2
    (CMP_JEQS_NT 4); условное исполнение прочих (mov.ne) не ждёт (CMP_MOVNE 2);
  * загрузка из своей памяти (DCCM uc, стек): 1 такт, результат через 2 — ждёт следующая инструкция, если читает или
    пишет тот же регистр (табло по именам регистров в операндах: LD_DCCM 2, LDUSE_DCCM 3, LD_DCCM_NOP 2, LD_DCCM_ST 2,
    PUSHPOP 3); запись 1 (ST_DCCM);
  * загрузка из памяти fw (0x840000..0x87ffff): 3 такта, результат через 4 (LD_FW 4, LDUSE_FW 5, LD_FW_NOP 4,
    LD_FW_N3 6); запись 1 (ST_FW); к шине регистров отношения не имеет (ST_MAC_LD_FW = ST_MAC);
  * чтение регистра: блок MAC 0x886000..0x886fff — 12, прочие (RGF 0x880xxx, PHY 0x883xxx) — 9 (LD_MAC, LD_RGF,
    LD_PHY). Неблокирующее: ld стоит 1 такт, ждёт инструкция, которой нужен результат (табло; ld в тот же регистр не
    ждёт), и следующее чтение регистра (LD_MAC_N3/N7/N11: ld + 3/7/11 nop = 12). Второе чтение другого адреса при
    одном неперекрытом в полёте выдаётся сразу и кончается в max(начало + задержка − 1, конец первого + 4 (MAC) /
    1 (прочие)), его результат — ещё через 3; иначе чтение ждёт конца всех (LD_MAC_LD_MAC2 16, LD_MAC_LD_RGF 13,
    LD_TSF3 28, LD_TSF_N4_LD 16, LD_TSF2_USE 20). Вне блока MAC (PHY/RGF) перекрывается и чтение того же адреса в другой регистр (в тот же — нет: LD_PHY/LD_RGF
    16 подряд по 8,94): стенд
    2026-10-30 (метка STAMP_SNR_SEL, rx_flow_measure_snr_select_best, 8 чтений 0x883830 подряд + 37 тактов прочего на
    проход) — 70,9 такта на проход (16 проходов — 1134), при последовательных чтениях модель давала 109;
  * запись в регистр: 1 такт, шина занята ещё 6 (MAC) / 5 (прочие) тактов — следующая запись ждёт (ST_MAC 6,
    ST_MAC_N3 6, ST_MAC_N7 8); запись завершается через 12 (MAC) / 10 (прочие) тактов от начала — sync ждёт
    (STSYNC_MAC 12, ST_MAC_N7_SYNC 12, STSYNC_RGF 10); чтение регистра — не раньше чем через 3 такта после начала
    записи, занятость шины записью его не держит (ST_MAC_LD_MAC 15); запись ждёт конца предыдущего чтения;
  * sync без незавершённой записи 1; lr/sr 1; чтение расширенного регистра ядра (r40) 1 (CORE_RD);
  * команда MAC (запись r32) 1, подряд и перед чтениями без ожидания (MAC_CMD, MAC_CMD_N3, MAC_CMD_R40,
    MAC_CMD_LD_MAC).
Проверка на реальном пути (тот же код, метки UC_STAMP 16, образы evtst/evtB): отправка события в fw — 4 отрезка
92/68/225/34 и 155 тактов, модель равна стенду на всех пяти.
Измерено и равно 1 без добавок: mul64 (результат r57 — сразу, от операнда не зависит), flag, установка lp, сдвиг на
регистр (MUL*, FLAG, LOOP2_LP, ASL_REG); jl [reg] — как j (JL).
Не измерено и взято по аналогии: чтение прочих расширенных регистров (как r40), выполненный jcc (как j). Повтор
завершения BF со снимка стенда (UC.from_snapshot) — docs/UC-TIMING.md.
"""
import collections
import re

M32 = 0xffffffff
MMIO_LO, MMIO_HI = 0x880000, 0x8c0000
MAC_LO, MAC_HI = 0x886000, 0x887000          # блок MAC: чтение 12, занятость шины после записи 6
FW_LO, FW_HI = 0x840000, 0x880000            # память fw (общая с uc): загрузка 4
_LOADS = ('ld', 'ldb', 'ldh', 'ldw', 'pop')
_REG = re.compile(r'\b(r\d+|gp|fp|sp|ilink[12]|blink|lp_count)\b')

# цены (добавка к 1 такту инструкции)
LIMM = 1
TAKEN, TAKEN_D, MISALIGNED_TARGET = 1, 0, 1  # b/bl/bcc; цель — 32-битная инструкция по адресу ≡ 2 (mod 4): +1
TAKEN_JREG, TAKEN_JREG_D = 2, 1              # j/jl по регистру (возврат j_s [blink])
TAKEN_BRCC, TAKEN_BRCC_D = 4, 3              # сравнение с переходом brcc/bbit (BRNE 5); .d — по аналогии, не измерено
READY_LOAD, READY_LOAD_FW, BLOCK_LOAD_FW = 2, 4, 2   # результат загрузки готов через; fw: инструкция стоит ещё 2
RD_MAC, RD_OTHER = 12, 9                     # чтение регистра: результат и шина — через
WR_BUSY_MAC, WR_BUSY_OTHER = 6, 5            # шина занята после записи
WR_DONE_MAC, WR_DONE_OTHER = 12, 10          # запись завершена (sync) — от начала записи
RD_AFTER_WR = 3                              # чтение регистра — не раньше начала записи + 3
RD_OV_AFTER_MAC, RD_OV_AFTER_OTHER = 4, 1    # второе чтение (другой адрес) завершается не раньше конца первого + 4 / 1
RD_OV_LAT = 1                                # … и не раньше своего начала + задержка − 1 (LD_TSF_N4_LD)
RD_OVERLAP_READY = 3                         # результат перекрывшего чтения — позже его конца
EXT_RD, MAC_CMD = 0, 0
FLAGS_READY_BCC = 3                          # флаги для условного перехода готовы через 3 такта после cmp/.f
FLAGS_READY_JCC = 2                          # для jcc — через 2 (CMP_JEQS_NT, CMP_JEQ_NT)
JREG_EARLY = 1                               # j/jl [reg]: регистр нужен на такт раньше (BL_PUSH, BL_MOVJ)
ALU_READY = 1                                # результат ALU — следующей инструкции
LP_ONE_INSN = 1                              # цикл lp с телом из одной инструкции: +1 на первом возврате (LP3_1, LP5_1)
BRCC_BACK_WARM, BRCC_BACK_COLD = 1, 4        # brcc назад (смещение < 0), с переходом или без: +1, если прошлое его
                                             # исполнение было с переходом, иначе +4 (BRCC_LOOP*, BREQ_NT_BK*)
BRCC_NT_LP_END = {1: 4, 2: 3}                # brcc без перехода за d инструкций до LP_END: +4 / +3, d ≥ 3 — 0
                                             # (BREQ_NT_BACK d = 1 и 3, BREQ_NT d = 2 и 4, BREQ_NT_N3 d = 5)
_JREG = ('j', 'jl')
_NO_DEST = ('st', 'b', 'j', 'cmp', 'tst', 'btst', 'rcmp', 'push', 'lp', 'flag', 'sr', 'nop', 'mul64', 'sync')
_CONDS = ('eq', 'z', 'ne', 'nz', 'p', 'pl', 'n', 'mi', 'c', 'cs', 'lo', 'nc', 'cc', 'hs', 'v', 'vs', 'nv', 'vc', 'gt',
          'ge', 'lt', 'le', 'hi', 'ls', 'pnz')
_BCC = frozenset(p + c + s for p in ('b', 'bl', 'j', 'jl') for c in _CONDS for s in ('', '_s'))
_SETF = frozenset(b + s for b in ('cmp', 'tst', 'btst', 'rcmp') for s in ('', '_s'))
_BRCC = ('brne', 'breq', 'brlt', 'brge', 'brlo', 'brhs', 'bbit0', 'bbit1')

KEYS = ('insn', 'limm', 'taken', 'taken_d', 'taken_jreg', 'taken_brcc', 'taken_brcc_back', 'brcc_lp_end',
        'brcc_back_warm', 'brcc_back_cold', 'lp_one_insn', 'misaligned', 'load', 'load_fw', 'ext_rd', 'mac_cmd',
        'mmio_rd', 'mmio_wr', 'bus_wait', 'rd_wait', 'flag_wait', 'jreg_wait', 'sync_wait')


def _offset(ins):
    try:
        return int(ins.ops[-1], 0)
    except (ValueError, IndexError):
        return 0


def is_load(ins):
    b = ins.base[:-2] if ins.base.endswith('_s') else ins.base
    return b in _LOADS


class _Info:
    """Статическое об инструкции для шага модели (разбор один раз; Instr эмулятора неизменяемы и кешируются по ELF)."""
    __slots__ = ('b', 'load', 'regs', 'regs_src', 'jreg', 'flagwait', 'jcc', 'setf', 'alu_dest', 'lp', 'limm', 'brcc',
                 'back')

    def __init__(self, i):
        b = i.base[:-2] if i.base.endswith('_s') else i.base
        self.b = b
        self.load = b in _LOADS
        self.regs = frozenset(_REG.findall(' '.join(i.ops)))
        self.regs_src = frozenset(_REG.findall(' '.join(i.ops[1:])))
        self.jreg = i.ops[0].strip('[]') if b in _JREG and i.ops else None
        self.flagwait = i.base in _BCC or bool(i.cc) and i.base in ('b', 'bl', 'j', 'jl')
        self.jcc = i.base.startswith('j')
        self.setf = bool(i.setf) or i.base in _SETF
        self.alu_dest = (i.ops[0] if i.ops and not self.load and _REG.fullmatch(i.ops[0])
                         and not b.startswith(_NO_DEST) else None)
        self.lp = b == 'lp'
        self.limm = i.size in (6, 8)                   # limm: и 32-, и 16-битной инструкции
        self.brcc = b in _BRCC
        self.back = self.brcc and _offset(i) < 0


_INFO = {}                                     # id(Instr) → (Instr, _Info): ссылка держит id занятым


def _info(i):
    e = _INFO.get(id(i))
    if e is None or e[0] is not i:
        e = _INFO[id(i)] = (i, _Info(i))
    return e[1]


class Cost:
    """Состояние шины регистров между шагами; step() — такты одного шага эмулятора (инструкция или пара
    «переход + delay-слот»). now — такты модели к началу шага (для ожиданий шины)."""

    def __init__(self):
        self.rd_free = 0                     # все начатые чтения регистров завершены к
        self.rd_start = -10 ** 9             # начало последнего чтения
        self.rd_addr = None                  # его адрес
        self.rd_dst = None                   # и регистр-приёмник
        self.rd_ov = False                   # оно само перекрыло предыдущее
        self.wr_free = 0                     # шина свободна для следующей записи с
        self.wr_start = -10 ** 9             # начало последней записи в регистр
        self.wr_done = 0                     # последняя запись в регистр завершена к
        self.parts = collections.Counter()
        self.flags_ready = 0                 # флаги для условного перехода готовы к
        self.pend = {}                       # табло: регистр → такт готовности результата загрузки / чтения регистра
        self.pend_rd = set()                 # из них — чтения регистров: ld в тот же регистр их не ждёт
        self.alu_ready = {}                  # регистр → такт готовности результата ALU (только для j/jl [reg])
        self.lp_fresh = False                # после lp — возврата к LP_START ещё не было
        self.brcc_taken = {}                 # адрес brcc → был ли переход при прошлом исполнении

    def _regs(self, i):
        return _REG.findall(' '.join(i.ops))

    def _regs_src(self, i):
        return _REG.findall(' '.join(i.ops[1:]))

    def step(self, c, pc0, ins, n, trace_new, lp, now):
        p = self.parts
        cost = 0
        p['insn'] += n
        seq = (pc0 + ins.size) & M32
        dins = None
        if n == 2 and ins.delay:
            dins = c.fetch(seq)
            seq = (seq + dins.size) & M32
        mmio = any(e[0] == 'mmio' for e in trace_new)
        t_ins = now
        for i in (ins, dins):
            if i is None:
                continue
            ci = _info(i)
            t = now + cost                               # начало инструкции
            if ci.jreg is not None:                      # переход по регистру: регистр — на такт раньше
                r = ci.jreg
                need = max(self.pend[r] + JREG_EARLY if r in self.pend else t,
                           self.alu_ready.get(r, t - 1) + JREG_EARLY)
                if need > t:
                    p['jreg_wait'] += need - t
                    cost += need - t
                    t = need
            if self.pend:
                regs = set(ci.regs)
                d0 = i.ops[0] if ci.load and i.ops else None
                if d0 is not None and d0 in self.pend_rd and d0 not in ci.regs_src:
                    regs.discard(d0)                     # перезапись результата чтения регистра — без ожидания
                    self.pend.pop(d0)
                    self.pend_rd.discard(d0)
                ready = max((self.pend.pop(r) for r in regs if r in self.pend), default=t)
                self.pend_rd -= regs
                if ready > t:
                    p['rd_wait'] += ready - t
                    cost += ready - t
                    t = ready
            if ci.flagwait:
                fr = self.flags_ready - (FLAGS_READY_BCC - FLAGS_READY_JCC if ci.jcc else 0)
                if fr > t:
                    p['flag_wait'] += fr - t
                    cost += fr - t
                    t = fr
            if ci.setf:
                self.flags_ready = t + FLAGS_READY_BCC
            if i is ins:
                t_ins = t
            if self.alu_ready:
                self.alu_ready = {r: v for r, v in self.alu_ready.items() if v > t}
            if ci.alu_dest is not None:
                self.alu_ready[ci.alu_dest] = t + ALU_READY
            if ci.lp:
                self.lp_fresh = True
            cost += 1
            if ci.limm:
                cost += LIMM
                p['limm'] += 1
            if ci.load and not mmio and i.ops:
                if FW_LO <= c.last_ld < FW_HI:
                    cost += BLOCK_LOAD_FW
                    p['load_fw'] += 1
                    self.pend[i.ops[0]] = t + READY_LOAD_FW
                else:
                    p['load'] += 1
                    self.pend[i.ops[0]] = t + READY_LOAD
        cost += n - (2 if dins is not None else 1)       # прочие инструкции шага (если эмулятор исполнил больше)
        npc = c.pc & M32
        lp_start, lp_end = lp
        ci = _info(ins)
        bb, back = ci.b, ci.back
        if back:                                         # цена не зависит от исхода — только от прошлого исполнения
            warm = self.brcc_taken.get(pc0)
            k, v = ('brcc_back_warm', BRCC_BACK_WARM) if warm else ('brcc_back_cold', BRCC_BACK_COLD)
            cost += v
            p[k] += 1
            self.brcc_taken[pc0] = npc != seq and not (lp_end and seq == lp_end and npc == lp_start)
        elif npc == seq and lp_end and bb in _BRCC:
            a, d = seq, 0                                # brcc без перехода: сколько инструкций до LP_END
            while a != lp_end and d < max(BRCC_NT_LP_END):
                a = (a + c.fetch(a).size) & M32
                d += 1
            if a == lp_end and d in BRCC_NT_LP_END:
                cost += BRCC_NT_LP_END[d]
                p['brcc_lp_end'] += BRCC_NT_LP_END[d]
        if lp_end and seq == lp_end and npc == lp_start and self.lp_fresh:
            self.lp_fresh = False
            if pc0 == lp_start:                          # тело из одной инструкции
                cost += LP_ONE_INSN
                p['lp_one_insn'] += 1
        if npc != seq and not (lp_end and seq == lp_end and npc == lp_start):
            b = bb
            if b in _BRCC and back:
                k, v = 'taken_brcc_back', 0                  # учтено выше
            elif b in _BRCC:
                k, v = 'taken_brcc', TAKEN_BRCC_D if ins.delay else TAKEN_BRCC
            elif b in _JREG:
                k, v = 'taken_jreg', TAKEN_JREG_D if ins.delay else TAKEN_JREG
            else:
                k, v = 'taken_d' if ins.delay else 'taken', TAKEN_D if ins.delay else TAKEN
            cost += v
            p[k] += 1
            if npc & 3 == 2 and c.fetch(npc).size >= 4:
                cost += MISALIGNED_TARGET
                p['misaligned'] += 1
        li = dins if (dins is not None and _info(dins).load) else ins
        dst = li.ops[0] if li.ops else None              # регистр-приёмник чтения
        for e in trace_new:
            if e[0] == 'extreg':
                if e[1] == 'w' and e[2] == 32:
                    cost += MAC_CMD
                    p['mac_cmd'] += 1
                elif e[1] == 'r':
                    cost += EXT_RD
                    p['ext_rd'] += 1
            elif e[0] == 'mmio' and MMIO_LO <= e[2] < MMIO_HI:
                t = t_ins                                # начало инструкции обращения
                mac = MAC_LO <= e[2] < MAC_HI
                if e[1] == 'r':
                    t0 = max(t, self.wr_start + RD_AFTER_WR)
                    lat = RD_MAC if mac else RD_OTHER
                    ov = False
                    if self.rd_free <= t0:
                        start, end = t0, t0 + lat
                    elif not self.rd_ov and (e[2] != self.rd_addr or (not mac and dst != self.rd_dst)):
                        start, ov = t0, True
                        end = max(t0 + lat - RD_OV_LAT, self.rd_free + (RD_OV_AFTER_MAC if mac else RD_OV_AFTER_OTHER))
                    else:
                        start = self.rd_free
                        end = start + lat
                    p['mmio_rd'] += 1
                    p['bus_wait'] += start - t
                    cost += start - t
                    self.rd_free = max(self.rd_free, end)
                    self.rd_start, self.rd_addr, self.rd_ov, self.rd_dst = start, e[2], ov, dst
                    t_ins = start
                    if is_load(ins) and ins.ops:
                        self.pend[ins.ops[0]] = end + (RD_OVERLAP_READY if ov else 0)
                        self.pend_rd.add(ins.ops[0])
                else:
                    start = max(t, self.wr_free, self.rd_free)
                    p['mmio_wr'] += 1
                    p['bus_wait'] += start - t
                    cost += start - t
                    self.wr_start = start
                    self.wr_free = start + (WR_BUSY_MAC if mac else WR_BUSY_OTHER)
                    self.wr_done = start + (WR_DONE_MAC if mac else WR_DONE_OTHER)
                    t_ins = start
            elif e[0] == 'sync':
                t = t_ins
                w = max(0, self.wr_done - t - 1)
                cost += w
                p['sync_wait'] += w
        return cost

