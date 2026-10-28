# SPDX-License-Identifier: AGPL-3.0-or-later
"""Срок: путь uc от события MAC до команды-действия укладывается во время, которое дают стандарт и железо.

Класс «срок» (tests/unit/README.md): в отличие от «вечного ожидания» (SpinError) здесь путь конечен, но может быть
длиннее, чем позволяет 802.11-2020 (SIFS / MBIFS / SBIFS / слот A-BFT / подполе TRN) минус документированная
задержка железа. Тест ведёт функции uc по ХУДШЕЙ ветке (64 сектора, ≥ 2 RF-модулей с делениями, старший индекс
станции, ожидание BAP, разреженная маска BRP),
отмечает точку события (первое чтение регистра события с поднятым битом после последнего чтения со сброшенным —
то чтение, что выпустило ожидание) и команду-действие (запись r32 / MMIO), считает такты между ними по модели
стоимости ARC600 (COST ниже) и сравнивает с бюджетом B по правилу запаса:

    проходит, если W ≤ B − max(MARGIN_PCT·B, MARGIN_FLOOR_CLK)

W — худший путь в тактах по модели, B — срок (стандарт минус задержка железа; источник — в docstring и выводе).
Ожидания
железа (MTP r43/r45, подтверждения r42.14, r53) эмулятор проходит за один опрос — W это ЧИСТО программная часть;
время ответа MAC сверх одного опроса в W не входит (где оно известно — вычтено из B, см. источник).
Путь, не прошедший правило, — xfail(strict=True) с B, W, требуемым и фактическим запасом в reason: найденный риск.

Модель стоимости (ARCompact PRM / ARC600, arc600-docs; где документа нет — явное допущение, с запасом вверх):
  * 1 такт на инструкцию (5-стадийный конвейер, CPI 1 для АЛУ; эмулятор считает и delay-слот);
  * +1 такт на 8-байтную инструкцию (limm): выборка 32 бита за такт (tools/arcemu/seg_lat.py BYTES);
  * взятый переход/вызов/возврат: +2 без delay-слота, +1 с .d (условие и цель — на 2-й стадии, PRM гл. 8 «condition
    code test for these jumps is carried out one stage earlier»; seg_lat: «~+1..2 такта»; берём верхнюю оценку);
    возврат на LP_START в zero-overhead loop — 0 (PRM «ARC 600 Loop Operation»);
  * загрузка из памяти (ld*/pop): +1 (PRM: «loads take a minimum of one cycle to complete», зависимая следующая
    инструкция ждёт; считаем, что ждёт всегда);
  * чтение порта MAC r33..r63: +1; команда MAC (запись r32): +2 (допущение: рукопожатие интерфейса расширения;
    не измерено);
  * чтение MMIO 0x880000..0x8bffff (AHB): +8, запись MMIO: +2 (допущение: AHB-чтение не измерено, notes/timing/
    ifs-misc.md «200 латентностей AHB (не измерено)»; запись — буферизована).
Калибровка по стенду (test_cost_model_calibration_abft_sta): A-BFT станции, событие слота → 0x19 — модель 505 / стенд
531 тактов (fp2, IFS-MEASURED.md); SIFS_CNT → 0x19 — модель 449 / стенд 431–436 (uc/ifs.h:108); ≈ 1,64 такта на
инструкцию. Модель в пределах ±5 % от стенда на пути, где стенд включает и ожидания MAC.
"""
import pytest

from test_uc_beacon_tx import MAC_CMD_LOG, clean_shadows, zero

CLK_PER_US = 165                        # Timer1 / такт uc (H-T1, uc/abft.h)
SIFS = 495                              # aSIFSTime 3 мкс (Table 20-30)
MBIFS = 1485                            # 3·aSIFSTime (10.3.2.3.10)
SBIFS = 165                             # 1 мкс (Table 20-30)

# ---- правило запаса (одно место) ----
MARGIN_PCT = 0.20
MARGIN_FLOOR_CLK = 100                  # ≈ 0,6 мкс: разброс задержки очереди команд MAC 0,55 мкс (H-ORIGIN) +
                                        # aAirPropagationTime 0,1 мкс + дрожание выхода из опроса r42


def required_margin(budget):
    return max(MARGIN_PCT * budget, MARGIN_FLOOR_CLK)


def passes(w, budget):
    return w <= budget - required_margin(budget)


# ---- модель стоимости ----
COST = dict(insn=1, limm=1, taken=2, taken_d=1, load=1, ext_rd=1, mac_cmd=2, mmio_rd=8, mmio_wr=2)
MMIO_LO, MMIO_HI = 0x880000, 0x8c0000
_LOADS = ('ld', 'ldb', 'ldh', 'ldw', 'pop')


def _is_load(ins):
    b = ins.base[:-2] if ins.base.endswith('_s') else ins.base
    return b in _LOADS


class Meter:
    """Пошаговая стоимость исполнения: для каждого события трассы (cpu.trace) — накопленные такты по COST и число
    инструкций к концу шага, в котором оно возникло. Ставится на экземпляр CPU (ucemu не меняется)."""

    def __init__(self, uc, stop=None):
        """stop(cmd) — остановить исполнение после команды MAC, для которой stop истинно (дальше пути нет)."""
        self.uc = uc
        c = self.c = uc.cpu
        self.clk = 0                       # накопленные такты модели
        self.ins = 0                       # накопленные инструкции (как cpu.insns)
        self.ev = {}                       # индекс события трассы → (clk, ins) к концу шага
        self.pc = {}                       # индекс события трассы → pc инструкции
        self.steps = []                    # (pc, такты шага, накопленные такты)
        self.parts = dict.fromkeys(COST, 0)
        orig = c.step

        def step():
            pc0 = c.pc & 0xffffffff
            k = len(c.trace)
            i0 = c.insns
            lp_start, lp_end = c.aux.get(0x02, 0), c.aux.get(0x03, 0)
            ins = c.fetch(pc0)
            orig()
            n = c.insns - i0
            seq = (pc0 + ins.size) & 0xffffffff
            add = dict(insn=n)
            dins = None
            if n == 2 and ins.delay:
                dins = c.fetch(seq)
                seq = (seq + dins.size) & 0xffffffff
            for i in (ins, dins):
                if i is None:
                    continue
                if i.size == 8:
                    add['limm'] = add.get('limm', 0) + 1
                if _is_load(i):
                    add['load'] = add.get('load', 0) + 1
            npc = c.pc & 0xffffffff
            if npc != seq and not (lp_end and seq == lp_end and npc == lp_start):
                add['taken_d' if ins.delay else 'taken'] = 1
            for e in c.trace[k:]:
                if e[0] == 'extreg':
                    if e[1] == 'w' and e[2] == 32:
                        add['mac_cmd'] = add.get('mac_cmd', 0) + 1
                    elif e[1] == 'r' and e[2] != 32:
                        add['ext_rd'] = add.get('ext_rd', 0) + 1
                elif e[0] == 'mmio' and MMIO_LO <= e[2] < MMIO_HI:
                    add['mmio_rd' if e[1] == 'r' else 'mmio_wr'] = add.get('mmio_rd' if e[1] == 'r' else 'mmio_wr', 0) + 1
            cost = 0
            for key, v in add.items():
                cost += COST[key] * v
                self.parts[key] += v
            self.clk += cost
            self.steps.append((pc0, cost, self.clk))
            self.ins += n
            for j in range(k, len(c.trace)):
                self.ev[j] = (self.clk, self.ins)
                self.pc[j] = pc0
                e = c.trace[j]
                if stop is not None and e[:3] == ('extreg', 'w', 32) and stop(e[4]):
                    c.halted = True

        c.step = step
        self.t0 = len(c.trace)

    # ---- поиск точек ----
    def events(self, since=None):
        t = self.c.trace
        for j in range(self.t0 if since is None else since, len(t)):
            yield j, t[j]

    def cmd_idx(self, pred, after=None, nth=0):
        """Индексы записей r32 (команд MAC), удовлетворяющих pred, после индекса after."""
        out = [j for j, e in self.events() if e[:3] == ('extreg', 'w', 32) and pred(e[4]) and (after is None or j > after)]
        return out[nth] if out else None

    def all_cmds(self, pred, after=None):
        return [j for j, e in self.events() if e[:3] == ('extreg', 'w', 32) and pred(e[4]) and (after is None or j > after)]

    def mmio_w_idx(self, addr, after=None):
        out = [j for j, e in self.events() if e[0] == 'mmio' and e[1] == 'w' and e[2] == addr and (after is None or j > after)]
        return out[0] if out else None

    def trigger(self, reg, mask, before, after=None):
        """Чтение регистра reg, выпустившее ожидание перед индексом before (и после after): первое чтение с
        (v & mask) после последнего чтения с (v & mask) == 0."""
        t = self.c.trace
        run = None
        for j in range(self.t0 if after is None else after + 1, before):
            e = t[j]
            if e[:3] == ('extreg', 'r', reg):
                if e[4] & mask:
                    if run is None:
                        run = j
                else:
                    run = None
        return run

    def dump(self, a=None, b=None, regs=None):
        """Отладка: события трассы между a и b с функцией и тактами."""
        out = []
        for j, e in self.events():
            if (a is not None and j < a) or (b is not None and j > b):
                continue
            if e[0] == 'extreg' and (regs is None or e[2] in regs):
                out.append('%6d %5d %-40s %s r%d %#x' % (j, self.ev[j][0], self.uc.where(self.pc[j]), e[1], e[2], e[4]))
        return '\n'.join(out)

    def profile(self, a, b):
        """Такты по функциям между событиями a и b (для разбора худшего пути)."""
        lo, hi = self.ev[a][0], self.ev[b][0]
        prof = {}
        for pc, cost, cum in self.steps:
            if lo < cum <= hi:
                fn = self.uc.where(pc).split('+')[0]
                prof[fn] = prof.get(fn, 0) + cost
        return sorted(prof.items(), key=lambda x: -x[1])

    def span(self, a, b):
        """(такты модели, инструкции) от конца шага события a до конца шага события b."""
        return self.ev[b][0] - self.ev[a][0], self.ev[b][1] - self.ev[a][1]


def verdict(name, w, ins, budget, src):
    req = required_margin(budget)
    msg = ('%s: W = %d тактов (%d инстр.; %.2f мкс) против B = %d (%.2f мкс, %s); запас B−W = %d, требуется ≥ %d '
           '(max(%d%%·B, %d))' % (name, w, ins, w / CLK_PER_US, budget, budget / CLK_PER_US, src, budget - w, int(req),
                                  int(MARGIN_PCT * 100), MARGIN_FLOOR_CLK))
    print(msg)
    RESULTS[name] = dict(w=w, ins=ins, budget=budget, src=src, margin=budget - w, req=int(req), ok=passes(w, budget))
    return msg


RESULTS = {}


def check(name, w, ins, budget, src):
    msg = verdict(name, w, ins, budget, src)
    assert passes(w, budget), msg


def risk(path, w, budget, src):
    """xfail(strict) для пути, не прошедшего правило запаса: W, B, требуемый и фактический запас — в reason
    (значения на момент записи теста; ход их изменения виден в выводе -s)."""
    req = int(required_margin(budget))
    over = 'worst %d clk > budget %d clk' % (w, budget) if w > budget else 'worst %d clk ≤ budget %d clk' % (w, budget)
    return pytest.mark.xfail(strict=True, reason='%s: %s (%s); margin B−W = %d < required %d' %
                             (path, over, src, budget - w, req))


def last_cmd(uc, pred):
    """Последняя выданная команда MAC с pred (для ответа порта по текущему выбору/состоянию MAC)."""
    for e in reversed(uc.cpu.trace):
        if e[:3] == ('extreg', 'w', 32) and pred(e[4]):
            return e[4]
    return None


def cmds_since(uc, pred):
    return any(e[:3] == ('extreg', 'w', 32) and pred(e[4]) for e in uc.cpu.trace)


# =====================================================================================================================
# A-BFT станции (bti.c abft_responder_fast → abft_ssw_go → abft_ssw_burst)
# =====================================================================================================================
from test_uc_beacon_rx import BCN_RX, AP, sta  # noqa: E402,F401
from test_uc_beacon_abft_resp import REC  # noqa: E402

IS_TX = lambda c: c >> 24 == 0x19                              # noqa: E731  пуск TX (0x19000001 / 0x198…)


def abft_sta_run(uc, fss=15):
    """Станция в своём слоте 0 A-BFT: маяк уже разобран (bcn_rx: FSS, BSSID, лучший сектор). Ожидания MAC не
    заглушены: abft_arm_response_window, сторож SIFS_CNT, RF, FIFO, MTP — все на пути. r55: GP_CLK2 (после
    0x4d00000a) — целый слот впереди, SIFS_CNT (после 0x4d000000) — 0x10 (сторож пропускает)."""
    zero(uc, REC, 0x18)
    uc.w8(REC + 0xd, 8)
    uc.w8(0x800439, 0)                                  # abft_gp0_armed
    uc.w32(0x8005f4, 0)                                 # txrx_state1: обычный 0x19000001
    bic = fss << 10                                     # A-BFT Length 1 слот (поле 0), FSS
    uc.wbytes(BCN_RX + 2, bic.to_bytes(6, 'little'))
    uc.wbytes(BCN_RX + 0x14, AP)

    def r54(n, k):                                      # вход: событий нет; затем граница слота 0; после пачки — конец A-BFT
        if k == 0:
            return 0
        return 0x180 if cmds_since(uc, IS_TX) else 0x80

    def r55(n, k):
        c = last_cmd(uc, lambda c: c >> 24 == 0x4d)
        return 0xffffff if c == 0x4d00000a else 0x10
    uc.ext.update({54: r54, 55: r55, 43: 1 << 31, 45: 1 << 31, 47: 1, 42: (1 << 15) | (1 << 14) | (1 << 12)})
    m = Meter(uc)
    uc.call('abft_responder_fast', REC, 1, 0,
            stub={'tx_ctx_alloc_next': 0x803f80, 'l1_task_dispatch': 0, 'abft_resp_parse_fdbk': 1,
                  'uc_evt_build_and_post_report': 0, 'uc_assert': 0})
    txs = m.all_cmds(IS_TX)
    assert len(txs) == fss + 1, 'пачка: %d SSW вместо %d' % (len(txs), fss + 1)
    return m, txs


@pytest.mark.parametrize('fss', [4, 15])
def test_abft_sta_slot_event_to_first_ssw(sta, fss):
    """Событие границы своего слота (r54.7) → 0x19 первого SSW (802.11-2020 10.42.5.2: RSS ответчика — с начала
    слота). B = 4,34 мкс = 716 тактов: стенд, развёртка выдачи 0x19 после события (uc/ifs.h, SIFS_CNT_ABFT_SSW_LATE):
    до 4,34 мкс пачка полная, с 4,45 первый SSW теряется у AP."""
    m, txs = abft_sta_run(sta, fss)
    t = m.trigger(54, 0x80, txs[0])
    w, n = m.span(t, txs[0])
    check('abft_sta_slot_to_ssw', w, n, 716, 'стенд: 0x19 ≤ 4,34 мкс после события слота, uc/ifs.h:108')


@risk('abft_ssw_go: r55 SIFS_CNT → 0x19 первого SSW', 449, 435,
      'P = 4,34 − 1,60 − 0,10 мкс в выводе SIFS_CNT_ABFT_SSW_LATE, uc/ifs.h:108; стенд P = 2,61–2,64 мкс с меткой')
def test_abft_sta_sifs_guard_to_first_ssw(sta):
    """Чтение SIFS_CNT сторожем (r55 после 0x4d000000) → 0x19 первого SSW. Порог сторожа 1,60 мкс выведен как
    D − P − шаг = 4,34 − 2,64 − 0,10 (uc/ifs.h:108), т. е. верен, только пока путь P ≤ 2,64 мкс = 435 тактов
    («удлинение пути от проверки до 0x19 на ΔP требует уменьшить порог на ΔP»)."""
    m, txs = abft_sta_run(sta)
    g = [j for j, e in m.events() if e[:3] == ('extreg', 'r', 55) and j < txs[0]][-1]
    w, n = m.span(g, txs[0])
    check('abft_sta_guard_to_ssw', w, n, 435, 'P в выводе порога SIFS_CNT_ABFT_SSW_LATE, uc/ifs.h:108')


@risk('abft_ssw_burst: r42.15 tx_end → 0x19 следующего SSW', 387, 165,
      'SBIFS 10.3.2.3.8, uc/bti.c:726; стенд: зазор 1,01 мкс держит MAC — срок от tx_end не установлен')
def test_abft_sta_ssw_to_ssw_sbifs(sta):
    """tx_end SSW (r42.15) → 0x19 следующего SSW пачки: SBIFS 1 мкс ± 0,03 (10.3.2.3.8, 10.42.2.3.2). Худший промежуток
    пачки FSS 15. B = SBIFS = 165 тактов от tx_end (uc/bti.c:726 «SBIFS программно не выдерживается»)."""
    m, txs = abft_sta_run(sta)
    worst = None
    for a, b in zip(txs, txs[1:]):
        t = m.trigger(42, 1 << 15, b, after=a)
        w, n = m.span(t, b)
        if worst is None or w > worst[0]:
            worst = (w, n)
    check('abft_sta_ssw_gap', worst[0], worst[1], SBIFS, 'SBIFS от tx_end, 10.3.2.3.8; uc/bti.c:726')


# =====================================================================================================================
# Ответы через SIFS: конец кадра (r42.14 в цикле ХРУПКО rx_flow_run) → команда ответа
# =====================================================================================================================
# Срок по стандарту — aSIFSTime 3 мкс от конца PPDU (10.3.2.3.3), но точка отсчёта MAC относительно r42.14 и задержки
# PHY у DMG не определены (Table 20-30: «implementation dependent»), а стенд показывает, что абсолютная оценка по
# SIFS_CNT не работает (SIFS_CNT перед запросом в MTP 3,9–6,1 мкс без сбоев, docs/UC-REGISTERS.md §2.16). Поэтому B
# восстановлен по стенду: vendor-путь Ack (конец кадра → 0x37000020) — 409 инструкций (notes/timing/m1-paths.md P0.1,
# эмулятор) проходит, а +12..18 тактов перед ним дают assert 0x26 (поздняя команда, uc/rx.c:682, uc-rx.md). Такты
# vendor-пути — по CPI модели на нашем пути (W/n): B = 409·W/n + 12.
VENDOR_ACK_INSNS = 409
HW_PAD_FAIL_CLK = 12
SIFS_SRC = 'стенд: vendor-путь 409 инстр. + 12 тактов → assert 0x26 (uc/rx.c:682; m1-paths P0.1)'
STA_IDX = 7                                                 # худший индекс станции (r38[10:8])
TX_CTX_POOL = 0x802978


# DMG CTS на RTS: путь длиннее (rx_end_switch_to_tx → mac_switch_rx_to_tx ждёт конца PPDU, cca_ppdu_comp), срок
# аппаратного ответа отсчитывается иначе, чем у Ack — бюджет Ack к нему неприменим. B — vendor-путь CTS (эмулятор,
# lat.py: конец кадра r49 → 0x37000020, 20 сидов, медиана 546 инстр.), на стенде работает (RTS/CTS без сбоев); точка
# отказа сверх него не измерена — B только нижняя граница срока, без надбавки.
# Ответный CF-End (медленный путь rx_flow_send_imm_response, тоже через rx_end_switch_to_tx) — так же по vendor-пути:
# 436 инстр. (lat.py, r37 б16, Duration 1000).
VENDOR_PATH_INSNS = {'cts': 546, 'cfend': 436}
VENDOR_PATH_SRC = 'vendor-путь %s %d инстр. (эмулятор, lat.py r49 → 0x37000020), работает на стенде; точка отказа не мерена'


def sifs_budget(w, n, kind='ack'):
    if kind in VENDOR_PATH_INSNS:
        return int(VENDOR_PATH_INSNS[kind] * w / n)
    return int(VENDOR_ACK_INSNS * w / n) + HW_PAD_FAIL_CLK


def r42_rx(uc, extra=0):
    """r42 по месту чтения: в uc_wait_event_busy (ожидание 9<<11 до конца кадра) — б11 (PPDU ещё идёт), в цикле
    ХРУПКО rx_flow_run — б14 (конец кадра); дальше — б16 (отчёт), б14/б15 (подтверждения, tx_end)."""
    def f(n, k):
        w = uc.where(uc.cpu.pc)
        if w.startswith('uc_wait_event_busy') and not cmds_since(uc, lambda c: c == 0xeeee07):
            return (1 << 11) | extra
        return (1 << 16) | (1 << 14) | (1 << 15) | extra
    return f


def sifs_frame(uc, kind):
    """Отчёт о кадре (r36..r39, docs/UC-REGISTERS.md §2.5). Станция известна (r38.11 — фильтр rx_flow_handle_frame
    требует addr2_match_valid), индекс 7; BAP с ожиданием (mac_cmd31_mode ≠ 0) — худшая ветка."""
    r38 = 0x20000800 | (STA_IDX << 8)                        # fcs_ok_partial + addr2_match_valid
    r36 = r37 = 0
    if kind == 'ack':                                       # QoS Data, нормальная политика, без агрегации → Ack
        r36 = 1 << 1 | (3 << 19)
    elif kind == 'ba':                                      # A-MPDU → BlockAck
        r36, r38 = 1 << 1 | (3 << 19), r38 | 1 << 25
    elif kind == 'bar':                                     # BlockAckReq → BlockAck
        r36 = 1 << 1 | 1 << 18
    elif kind == 'cts':                                     # RTS → DMG CTS
        r37 = 1
    elif kind == 'cfend':                                   # CF-End с Duration ≠ 0 → ответный CF-End (медленный путь)
        r37 = 1 << 16
    elif kind == 'grant_ack':                               # Grant → Grant Ack (медленный путь)
        r37 = 1 << 10
    uc.w16(0x804012, 1000)                                  # rx_buf_duration
    uc.w32(0x801424, 0)                                     # rx_mode_flags
    uc.w32(0x8005f4, 0)                                     # txrx_state1: не TXOP, не BF
    uc.w32(0x8005f8, 0)
    uc.w32(0x800480, 0)                                     # rx_resp_skip_cnt
    uc.w8(0x800436, 0)                                      # rx_buf_toggle_dis: команда 0x32 на пути
    uc.w8(0x800444, 1)                                      # mac_cmd31_mode: ожидание BAP на пути (худшая ветка)
    uc.w32(0x800578, 0)                                     # ppdu_evt_cnt: seq 0
    uc.w32(0x8004e8, 0)
    uc.w32(TX_CTX_POOL + 0x78, TX_CTX_POOL)                 # tx_ctx_pool.cur = slot 0
    uc.w8(0x857e38 + 0x14 * STA_IDX + 0x11, 0)              # link_stat[sta].bf_reasons: BF к станции не идёт
    uc.w32(0x80146c, 0)                                     # rx_nav.flags: NAV не взведён (DMG CTS разрешён)
    # r40: состояние 2 (приём), счётчики PPDU [13:8] = 0 (= seq), [21:16] = 1 (пришёл новый), б24 cca_ppdu_comp
    uc.ext.update({42: r42_rx(uc), 36: r36, 37: r37, 38: r38, 39: 0, 53: 0xff, 43: 1 << 31, 45: 1 << 31, 47: 1,
                   55: 0x1f0, 40: 0x01010002, 41: 1})


def sifs_run(uc, kind, act=lambda c: c == 0x37000020, prep=None):
    uc.cpu.regs[25] = MAC_CMD_LOG
    clean_shadows(uc)
    sifs_frame(uc, kind)
    if prep:
        prep(uc)
    m = Meter(uc, stop=act)
    uc.call('rx_flow_run', stub={'uc_assert': 0}, max_steps=200000)
    a = m.cmd_idx(act)
    assert a is not None, 'нет ответа: %s' % [hex(c) for c in uc.mac_cmds]
    t = m.trigger(42, 1 << 14, a)
    w, n = m.span(t, a)
    return m, t, a, w, n


_SIFS_HW = 'B = 409·W/n + 12: стенд vendor Ack + 12 тактов → assert 0x26, uc/rx.c:682'


@pytest.mark.parametrize('kind', [
    pytest.param('ack', marks=risk('rx_flow_run → rx_frame_tx_resp_seq: r42.14 → 0x37000020 (Ack)', 603, 682, _SIFS_HW)),
    pytest.param('ba', marks=risk('то же, BlockAck на A-MPDU', 560, 681, _SIFS_HW)),
    pytest.param('bar', marks=risk('то же, BlockAck на BAR', 562, 678, _SIFS_HW)),
    pytest.param('cts', marks=risk('то же, DMG CTS на RTS (rx_end_switch_to_tx + mac_switch_rx_to_tx на пути; у нас на 69 '
                                   'инстр. короче vendor)', 790, 904, VENDOR_PATH_SRC % ('DMG CTS', 546))),
    pytest.param('cfend', marks=risk('медленный путь: ответный CF-End (rx_flow_send_imm_response; на 6 инстр. короче '
                                     'vendor)', 696, 705, VENDOR_PATH_SRC % ('CF-End', 436))),
    'grant_ack'])
def test_sifs_response_command(uc, kind):
    """Принят кадр с немедленным ответом (Ack 10.3.2.11, BlockAck 10.25.3/10.25.6, DMG CTS 10.3.2.9, CF-End 10.39.8.1,
    Grant Ack 10.39.4) — от конца кадра (r42.14 в цикле ХРУПКО rx_flow_run) до 0x37000020: команды, которую MAC при
    опоздании отмечает MAC_HW_ICR б4/б5 (assert 0x26, uc/rx.c:682)."""
    m, t, a, w, n = sifs_run(uc, kind)
    print(m.profile(t, a))
    src = VENDOR_PATH_SRC % (kind, VENDOR_PATH_INSNS[kind]) if kind in VENDOR_PATH_INSNS else SIFS_SRC
    check('sifs_resp_' + kind, w, n, sifs_budget(w, n, kind), src)


def test_txop_continue_after_ack(uc):
    """Держатель TXOP принял Ack (режим 1 txrx_state2) → следующий кадр TXOP через SIFS (10.23.2.8, 10.29.3): от конца
    кадра (r42.14) до запроса в MTP 0x1b001111 в rx_txop_continue (путь rx_flow_step → rx_dispatch_by_g_8005f8; m1-paths
    P0.2: vendor 409/417). Стенд: +20 nop на этом пути — отказ fw (uc/rx.c:386, запас 16–19 инструкций)."""
    def prep(uc):
        uc.w32(0x8005f4, 2)                                 # txrx_state1: TXOP
        uc.w32(0x8005f8, 0x101)                             # ждём Ack
        uc.ext.update({36: 1 << 8, 38: 0x800 | (STA_IDX << 8), 41: 1})
    m, t, a, w, n = sifs_run(uc, 'ack', act=lambda c: c == 0x1b001111, prep=prep)
    print(m.profile(t, a))
    check('txop_continue', w, n, int(417 * w / n) + HW_PAD_FAIL_CLK,
          'стенд: vendor-путь 417 инстр. (m1-paths P0.2) + 12 тактов; uc/rx.c:386')


@pytest.mark.parametrize('kind', ['ack', 'ba'])
def test_rf_back_to_rx_after_response(uc, kind):
    """После ответа РЧ — снова на приём до преамбулы следующего кадра партнёра через SIFS после конца нашего (10.3.2.3.3;
    после DMG CTS — данные, 10.3.2.9): от tx_end (r42.15) до записи HW_ABIF_DVS_RF_CTRL = rf_set_rx
    (rx_resp_finish_restore_rx, uc/rx.c:2004). B = aSIFSTime − aRxTxSwitchTime (у DMG implementation dependent; 1 мкс —
    Table 25-37) = 330 тактов."""
    uc.cpu.regs[25] = MAC_CMD_LOG
    clean_shadows(uc)
    sifs_frame(uc, kind)
    m = Meter(uc)
    hit = {}
    orig = uc.cpu.write

    def wr(addr, data):
        orig(addr, data)
        if addr == 0x889488 and 'done' not in hit and cmds_since(uc, lambda c: c == 0x18000000):
            hit['done'] = 1
            uc.cpu.halted = True
    uc.cpu.write = wr
    uc.call('rx_flow_run', stub={'uc_assert': 0}, max_steps=200000)
    a = [j for j, e in m.events() if e[:3] == ('mmio', 'w', 0x889488)][-1]
    t = m.trigger(42, 1 << 15, a, after=m.cmd_idx(lambda c: c == 0x18000000))
    w, n = m.span(t, a)
    check('rf_rx_after_' + kind, w, n, SIFS - CLK_PER_US, 'aSIFSTime − aRxTxSwitchTime 1 мкс, 10.3.2.3.3; uc/rx.c:2004')


# =====================================================================================================================
# GP-таймеры A-BFT
# =====================================================================================================================
def test_abft_sta_gp0_armed_before_gp2_end(sta):
    """Станция, первый маяк BTI (bti_bi2_event_step): GP0 (конец BTI) взводится, пока идёт GP2 = 0x284 (3,903 мкс) от
    конца приёма маяка (H-GP5) минус TRIM 0,25 мкс, иначе A-BFT этого BI пропущен (uc/bti.c:945, uc/abft.h). Путь —
    от отчёта о приёме (r42.16 в bti_worker_bi2_step; ~0,3 мкс после конца кадра, uc/abft.h) до 0x5200090c.
    B = 3,903 − 0,25 − 0,3 мкс = 552 такта."""
    from test_uc_beacon_rx import dmg_beacon, bic_encode, RX_BUF
    sta.wbytes(RX_BUF, dmg_beacon(bic_encode(), bssid=AP, cdown=63, duration=1300))
    sta.wbytes(BCN_RX + 0x14, AP)
    zero(sta, 0x803f00, 0x40)
    sta.ext.update({42: lambda n, k: (1 << 12) | ((1 << 16) if k >= 3 else 0), 36: 1 << 7, 38: 1, 55: 0x100})
    m = Meter(sta, stop=lambda c: c == 0x5200090c)
    sta.call('bti_bi2_event_step', 0x803f00,
             stub={'uc_read_tsf_lo': 0, 'uc_log_emit_snapshot': 0, 'uc_assert': 0, 'uc_bi_counter_in_window': 1,
                   'uc_read_bi_sync': 1})
    a = m.cmd_idx(lambda c: c == 0x5200090c)
    t = m.trigger(42, 1 << 16, a)
    w, n = m.span(t, a)
    check('abft_sta_gp0_arm', w, n, 0x284 - 41 - 50, 'GP2 0x284 − TRIM 41 − r42.16 50, uc/bti.c:945, uc/abft.h H-GP5')


@risk('bti_arm_period_gp0 (поздняя ветка): r55 GP_CLK2 → 0x50 GP1', 86, 17,
      'aAirPropagationTime 0,1 мкс — допуск совпадения сеток станции и AP, uc/bti.c:1336; задержка не вычитается')
def test_abft_sta_late_gp1_phase(sta):
    """Станция пропустила первую границу слота (r54.7 уже стоит): остаток до следующей границы считается по GP_CLK2 (r55)
    и пишется в GP1 (0x50) от момента команды; всё время между чтением r55 и 0x50 сдвигает границы слотов станции позже
    сетки AP, а совпадать они должны с точностью ~aAirPropagationTime (uc/bti.c:1336, 10.42.5.2). Худший случай —
    A-BFT 8 слотов, прошли все, кроме последнего (цикл вычитания максимальной длины), FSS 15."""
    sta.wbytes(BCN_RX + 2, ((7 << 7) | (15 << 10)).to_bytes(6, 'little'))
    sta.ext.update({54: 0x80, 55: 1})                       # GP_CLK2 почти кончился — прошло больше всего слотов
    m = Meter(sta)
    sta.call('bti_arm_period_gp0')
    g = [j for j, e in m.events() if e[:3] == ('extreg', 'r', 55)][0]
    a = m.cmd_idx(lambda c: c >> 24 == 0x50)
    w, n = m.span(g, a)
    check('abft_sta_late_gp1', w, n, 17, 'aAirPropagationTime 0,1 мкс, uc/bti.c:1336')


def test_abft_ap_grid_armed_before_trigger(uc):
    """AP после развёртки 64 маяков: GP0/GP2 сетки A-BFT стартуют триггером MAC через aSIFSTime + 7 тактов после
    txop_event (H-GP3, uc/abft.h ABFT_AP_TRIG03_CLK = 502); команды 0x4f/0x50/0x51 и пуск 0x5400030c должны прийти раньше
    (uc/bti.c:499). B = 502 такта от txop_event (r42.7)."""
    from test_uc_beacon_tx import lmac_0x0b, program_bic, bti_sweep, perm
    uc.cpu.regs[25] = MAC_CMD_LOG
    lmac_0x0b(uc, n_frames=64, order=perm(64), abft_len=7, fss=15, n_bi_abft=1)
    program_bic(uc)
    m = Meter(uc)
    bti_sweep(uc)
    a = m.cmd_idx(lambda c: c == 0x5400030c)
    t = m.trigger(42, 1 << 7, a)
    w, n = m.span(t, a)
    check('abft_ap_grid', w, n, 502, 'ABFT_AP_TRIG03_CLK = aSIFSTime + 7, uc/abft.h H-GP3; uc/bti.c:499')


# =====================================================================================================================
# SSW-Feedback AP в A-BFT (mac_mode_program_c → direct_tx_step)
# =====================================================================================================================
@risk('mac_mode_program_c → direct_tx_step: r55 SIFS_CNT → 0x19 SSW-Feedback', 269, 330,
      'uc/tail.c:1006: ≤ ~2 мкс от чтения r55 до старта передачи')
def test_abft_ap_feedback_after_guard(uc):
    """AP принял SSW станции в A-BFT; по событию GP1 (r54.7) — сторож SIFS_CNT (r55 после 0x4d000000, порог 6,81 мкс) и
    SSW-Feedback (direct_tx_step → 0x19000001), 10.42.5.2. После сторожа до 0x19 остаётся ≤ ~2 мкс = 330 тактов минус
    задержка PHY (uc/tail.c:1006: «от чтения r55 до старта передачи остаётся ≤ ~2 мкс (~330 тактов)»)."""
    uc.cpu.regs[25] = MAC_CMD_LOG
    clean_shadows(uc)
    rec = 0x803e80
    zero(uc, rec, 0x18)
    from test_uc_beacon_rx import RX_BUF
    ssw = bytearray(32)
    ssw[0:2] = (0x0864).to_bytes(2, 'little')               # SSW (Control Frame Extension)
    ssw[10:16] = bytes.fromhex('24181d243b0b')
    ssw[16:19] = (1 | (15 << 1) | (5 << 10)).to_bytes(3, 'little')   # Direction 1 (ответчик), CDOWN 15, сектор 5
    uc.wbytes(RX_BUF, bytes(ssw))
    r38 = 0x800 | (STA_IDX << 8)

    def r54(n, k):                                          # сначала SSW (r42.12), затем событие GP1
        return 0x80 if cmds_since(uc, lambda c: c == 0x1d00d000) else 0
    uc.ext.update({42: (1 << 12) | (1 << 16) | (1 << 14) | (1 << 15), 54: r54, 55: 0x300, 38: r38, 37: 1 << 24,
                   36: 1 << 6, 40: (1 << 24) | 5, 43: 1 << 31, 45: 1 << 31, 47: 0xffff})
    m = Meter(uc, stop=IS_TX)
    uc.call('mac_mode_program_c', rec, stub={'uc_assert': 0, 'uc_evt_build_and_post_report': 0}, max_steps=200000)
    a = m.cmd_idx(IS_TX)
    assert a is not None, [hex(c) for c in uc.mac_cmds]
    g = [j for j, e in m.events() if e[:3] == ('extreg', 'r', 55) and j < a][-1]
    w, n = m.span(g, a)
    print(m.profile(g, a))
    check('abft_ap_feedback', w, n, 330, 'uc/tail.c:1006 (≤ ~2 мкс после r55)')


# =====================================================================================================================
# SLS: ответы через MBIFS
# =====================================================================================================================
# B: MBIFS 9 мкс (10.3.2.3.10, допуск −0/+0,49) минус aRxTxTurnaroundTime (1 мкс, как для SIFS выше). Интервал держит
# MAC (0x886d00 = MBIFS, стенд E1: SSW-Ack через 9,05 мкс, notes/timing/IFS-MEASURED.md) — uc должен выдать команды
# до его конца.
MBIFS_B = MBIFS - CLK_PER_US
MBIFS_SRC = 'MBIFS − aRxTxTurnaroundTime 1 мкс, 10.3.2.3.10'
SLS = 0x80212c
TA = bytes.fromhex('24181d243b0b')


@pytest.mark.parametrize('rf_modules', [1, 2], ids=['rf1', 'rf2_div'])
def test_ssw_ack_after_feedback(uc, rf_modules):
    """Ответчик принял SSW-Feedback (r37.25) → SSW-Ack через MBIFS (10.42.2.2, 10.42.2.5) прямо из обработчика приёма
    (sls_rx_ssw_frame → sls_send_ssw_ack, uc/txss.c:658/693). От конца кадра (r42.14 в rx_flow_run) до 0x19 SSW-Ack.
    Худшее: станция (не AP) — сверка TA с поддерживаемой станцией, ≥ 2 RF-модулей с rf_modules.x4 = 0 — два
    программных деления в rf_update_active_antenna."""
    def prep(uc):
        uc.w32(0x801424, 1)                                 # rx_mode_flags б0: BF-режим приёма
        uc.w32(0x8005f4, 8)                                 # txrx_state1: RX BF
        uc.w32(0x8020b0, 0)                                 # bf_req.pending_mask
        uc.w32(0x8014c0, 0)                                 # uc_role_ap: станция
        uc.w8(SLS + 0x68, 1 << STA_IDX)                     # maint_sta_mask: сверка TA
        uc.w8(SLS + 0x66, 1 << STA_IDX)                     # rank_valid_mask: рейтинг секторов есть
        uc.wbytes(0x801104 + 0x50 * STA_IDX + 0x30, TA)     # sta_tab[7].mac
        uc.wbytes(0x804010 + 10, TA)                        # rx_buf: TA
        uc.w16(0x8006b4, rf_modules)                        # rf_modules.count
        uc.w8(0x8006b4 + 2, 3)                              # cur
        uc.w8(0x8006b4 + 4, 0)                              # x4 = 0 → деления при count ≥ 2
        uc.ext.update({36: 1 << 6, 37: 1 << 25, 38: 0x800 | (STA_IDX << 8), 39: 0})
    m, t, a, w, n = sifs_run(uc, 'ack', act=IS_TX, prep=prep)
    print(m.profile(t, a))
    check('ssw_ack_' + ('rf%d' % rf_modules), w, n, MBIFS_B, MBIFS_SRC)


@pytest.mark.parametrize('peer_ant', [1])
def test_rss_after_iss_end(uc, peer_ant):
    """Ответчик TXSS: конец ISS инициатора (r54.0 txss_end_ind в txss_resp_wait_iss_end) → первый SSW RSS через MBIFS
    (10.42.2.2, uc/txss.c:467): mac_mode_switch_core_and_rf (RX→TX), mac_program_4f_52, txss_program_tx_frame с
    подготовкой развёртки 64 секторов (txss_set_sweep_param, копия порядка 64 Б) до 0x19. Худшее: 64 сектора, пир с
    peer_ant DMG-антеннами."""
    uc.cpu.regs[25] = MAC_CMD_LOG
    clean_shadows(uc)
    sta = STA_IDX
    ss = 0x802b68 + 0x4c * sta
    zero(uc, ss, 0x4c)
    uc.wbytes(ss + 8, bytes(range(64)))
    uc.w8(ss + 0x48, 64)
    uc.w8(0x801104 + 0x50 * sta + 0x4c, peer_ant)
    uc.w32(0x8014c0, 0)
    uc.w32(0x8005f4, 0)
    uc.w8(0x8021e0, 0)                                      # sls_rx.flags: конец ISS — по событию r54.0
    uc.w8(0x801ffc + 0, 0)
    uc.ext.update({54: lambda n, k: 1 if k >= 1 else 0, 40: (1 << 24) | 5, 42: (1 << 14) | (1 << 15) | (1 << 16),
                   43: 1 << 31, 45: 1 << 31, 47: 1, 49: 0})
    m = Meter(uc, stop=IS_TX)
    uc.call('txss_resp_wait_iss_end', sta, 0x1000, stub={'uc_assert': 0}, max_steps=200000)
    a = m.cmd_idx(IS_TX)
    assert a is not None, [hex(c) for c in uc.mac_cmds]
    t = m.trigger(54, 1, a)
    w, n = m.span(t, a)
    print(m.profile(t, a))
    check('rss_after_iss_ant%d' % peer_ant, w, n, MBIFS_B, MBIFS_SRC)


# =====================================================================================================================
# BRP: цикл метрик TRN (brp_program_and_measure)
# =====================================================================================================================
TRN_SUBFIELD_CLK = 60           # 640 Tc = 0,3636 мкс (20.9.2.2.6, Figure 20-21: Ga128 −Gb128 Ga128 Gb128 Ga128) · 165


@pytest.mark.parametrize('mask', [
    pytest.param(0xffffffff, id='all', marks=risk('brp_program_and_measure: 0x49000002 → 0x49000002 (маска — все)', 65, 60,
                                                  'TRN-подполе 640 Tc, 20.9.2.2.6; ХРУПКО uc/brp.c:850, assert 4 на железе')),
    pytest.param(0x80000001, id='sparse', marks=risk('то же, разреженная маска (пропуск 30 бит за проход)', 244, 60,
                                                     'TRN-подполе 640 Tc, 20.9.2.2.6'))])
def test_brp_trn_metric_iteration(uc, mask):
    """Метрика TRN-подполя в r40 живёт до следующего подполя (uc/brp.c:850/887, ХРУПКО: assert 4 на железе): проход цикла
    от метрики (0x49000002 — квитирование r54.1) до следующего опроса не должен быть длиннее подполя TRN 640 Tc ≈ 60
    тактов. W — худший промежуток между соседними 0x49000002 (метрики приходят подряд). Маски конфигураций BRP: все
    (каждый проход — запись метрики и uc_shl64) и разреженная (пропуск 30 бит в одном проходе)."""
    uc.cpu.regs[25] = MAC_CMD_LOG
    clean_shadows(uc)
    uc.w32(0x85776c, mask)                                  # fwsh_sets.brp_cfg_mask[0] (include/fwsh.h)
    cnt = {'i': -1}                                         # первая 0x49000002 — пуск измерения

    def r40(n, k):                                          # индекс TRN-подполя [30:24] по порядку (без assert 4)
        v = (cnt['i'] & 0x7f) << 24 | (0x155 << 14) | 1
        return v

    def r54(n, k):
        return 2
    uc.ext.update({49: (1 << 13) | (1 << 5), 54: r54, 40: r40, 47: 0, 45: 1 << 31, 43: 1 << 31})
    m = Meter(uc)
    c = uc.cpu
    inner = c.step

    def step():
        k = len(c.trace)
        inner()
        for e in c.trace[k:]:
            if e[:3] == ('extreg', 'w', 32) and e[4] == 0x49000002:
                cnt['i'] += 1
    c.step = step
    after = ['uc_assert', 'brp_program_mac_sequence_uc', 'brp_pick_sector_cfg', 'rf_select_sector_cmd41',
             'sta_set_rx_sector']                           # после цикла — вне срока
    uc.call('brp_program_and_measure', 0, 0, 0, stub={k: 0 for k in after if k in uc.sym})
    acks = m.all_cmds(lambda c: c == 0x49000002)[1:]       # первая — пуск измерения
    assert len(acks) == 32, len(acks)
    worst = max((m.span(x, y) for x, y in zip(acks, acks[1:])), key=lambda v: v[0])
    check('brp_trn_iter_' + ('all' if mask == 0xffffffff else 'sparse'), worst[0], worst[1], TRN_SUBFIELD_CLK,
          'TRN-подполе 640 Tc, 20.9.2.2.6; uc/brp.c:850')


# =====================================================================================================================
# Развёртка маяков AP: соседние маяки через SBIFS (bcon_txss_sweep_step)
# =====================================================================================================================
@risk('bcon_txss_sweep_step: r42.15 tx_end → 0x19 следующего маяка (64 маяка)', 276, 165,
      'SBIFS 10.3.2.3.8, uc/tail.c:2567; стенд E4: зазор 1,000 мкс — срок от tx_end не установлен')
def test_beacon_sweep_sbifs(uc, monkeypatch):
    """BTI AP, 64 маяка: следующий маяк — через SBIFS 1 мкс ± 0,03 (10.3.2.3.8) после конца предыдущего; интервал
    отмеряет MAC (0x886d0c), uc обязан перепрограммировать кадр раньше (uc/tail.c:2567). W — от tx_end (r42.15) до 0x19
    следующего маяка, худший из 63 промежутков; ожидания MAC на пути (события 5/6 — mac_evt_enable_bit_sync*, MTP)
    исполняются, а не заглушены (r42 б14 — подтверждение после 0x2004000, иначе busy2 отменил бы BTI). B = SBIFS 165
    тактов от tx_end. Стенд E4 (notes/timing/IFS-MEASURED.md): зазор маяков нашего AP 1,000 мкс — r42.15 опережает
    конец кадра в эфире или MAC держит кадр; фактический срок не установлен."""
    import test_uc_beacon_tx as btx
    on_path = {'mac_program_tx_beacon', 'mac_evt_enable_bit_sync_b', 'bcon_tx_ack_cmds', 'uc_spin_until_event',
               'mac_evt_enable_bit_sync', 'mac_program_rx_window', 'mac_evt_select_timer_group',
               'mac_set_rf_chain_state_with_sta_sector', 'bcon_txss_program_sector'}
    monkeypatch.setattr(btx, 'SWEEP_WAITS', [x for x in btx.SWEEP_WAITS if x not in on_path])

    class TL(btx.MacTimeline):
        def __call__(self, n, k):
            v = super().__call__(n, k)                  # б7 txop_event, б14 после пуска сетки A-BFT
            ack = last_cmd(uc, lambda c: c >> 24 == 2) == 0x2004000
            return v | (1 << 15) | (1 << 1) | ((1 << 14) if ack else 0)
    monkeypatch.setattr(btx, 'MacTimeline', TL)
    uc.cpu.regs[25] = MAC_CMD_LOG
    btx.lmac_0x0b(uc, n_frames=64, order=btx.perm(64), abft_len=1, fss=15, n_bi_abft=1)
    btx.program_bic(uc)
    m = Meter(uc)
    btx.bti_sweep(uc)
    txs = m.all_cmds(IS_TX)
    assert len(txs) >= 64, [hex(c) for c in uc.mac_cmds][:80]
    worst = None
    for x, y in zip(txs, txs[1:64]):
        t = m.trigger(42, 1 << 15, y, after=x)
        w, n = m.span(t, y)
        if worst is None or w > worst[0]:
            worst = (w, n, t, y)
    print(m.profile(worst[2], worst[3]))
    check('beacon_sweep_gap', worst[0], worst[1], SBIFS, 'SBIFS от tx_end, 10.3.2.3.8; uc/tail.c:2567')


# =====================================================================================================================
# CBAP: слот отсрочки → пуск TX (tx_cca_check_and_send)
# =====================================================================================================================
def test_cbap_slot_to_tx_start(uc):
    """Событие слота CBAP (r42.1 в mac_select_all_sectors_and_wait) → проба CCA (0x29000001, mac_cca_ok) → пуск
    передачи (tx_submit_frame … 0x18008000 / 0x19…) — пока проба CCA верна, в пределах слота aSlotTime 5 мкс
    (10.23.2.2, 10.39.5, Table 20-30; uc/tx.c:286). B = aSlotTime = 825 тактов."""
    uc.cpu.regs[25] = MAC_CMD_LOG
    clean_shadows(uc)
    ctx = 0x803e00
    zero(uc, ctx, 0x3c)
    uc.w8(ctx, STA_IDX)
    uc.w32(0x8004f4, 0)                                     # dti_qset_mode
    uc.w32(0x8005f4, 0)

    def r42(n, k):
        ack = last_cmd(uc, lambda c: c >> 24 == 2) == 0x2004000
        return ((1 << 1) if k >= 1 else 0) | (1 << 15) | ((1 << 14) if ack else 0)
    uc.ext.update({42: r42, 40: (1 << 24) | 0xffff, 43: 1 << 31, 45: 1 << 31, 47: 1})
    act = lambda c: c >> 24 == 0x19 or c == 0x18008000           # noqa: E731
    m = Meter(uc, stop=act)
    uc.call('tx_cca_check_and_send', ctx, 0, 1, 0, stub={'uc_assert': 0}, max_steps=200000)
    a = m.cmd_idx(act)
    assert a is not None, [hex(c) for c in uc.mac_cmds]
    t = m.trigger(42, 1 << 1, a)
    w, n = m.span(t, a)
    print(m.profile(t, a), hex(uc.cpu.trace[a][4]))
    check('cbap_slot_to_tx', w, n, 5 * CLK_PER_US, 'aSlotTime 5 мкс, 10.23.2.2; uc/tx.c:286')


# =====================================================================================================================
# Калибровка модели стоимости по стенду
# =====================================================================================================================
def test_cost_model_calibration_abft_sta(sta):
    """Модель против стенда на одном и том же пути (станция, A-BFT): событие слота → 0x19 — 531 такт (fp2, 24 загрузки,
    notes/timing/IFS-MEASURED.md), чтение SIFS_CNT → 0x19 — 2,61–2,64 мкс = 431–436 тактов (с меткой опыта, uc/ifs.h:108).
    Числа стенда включают ожидания MAC (MTP, подтверждения), которых эмулятор не видит, и код того времени; поэтому
    требование — модель в пределах ±25 % от стенда (не оптимистичнее −25 %, иначе модель занижает такты)."""
    m, txs = abft_sta_run(sta)
    t = m.trigger(54, 0x80, txs[0])
    g = [j for j, e in m.events() if e[:3] == ('extreg', 'r', 55) and j < txs[0]][-1]
    w_evt, n_evt = m.span(t, txs[0])
    w_g, n_g = m.span(g, txs[0])
    print('калибровка: событие → 0x19 модель %d (инстр. %d) / стенд 531; сторож → 0x19 модель %d (инстр. %d) / стенд '
          '431–436; такт/инстр. %.2f' % (w_evt, n_evt, w_g, n_g, w_evt / n_evt))
    assert 0.75 * 531 <= w_evt <= 1.25 * 531
    assert 0.75 * 431 <= w_g <= 1.25 * 436
