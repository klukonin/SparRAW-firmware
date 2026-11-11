# SPDX-License-Identifier: AGPL-3.0-or-later
"""Короткий кадр SC кончился раньше, чем rx_flow_run сверил счётчики PPDU (ref/core/README.md, «Этап 3», смешанная пара
точка-ядро + станция-прошивка): Action ADDBA Response на MCS 1 — 37 Б, 3,38 мкс (9.6.4.3: Category, Block Ack Action,
Dialog Token, Status Code, Block Ack Parameter Set, Block Ack Timeout + заголовок 24 + FCS), заголовок SC разобран через
2,47 мкс (20.4.3), а путь uc от прерывания busy_event до проверки счётчиков — ~460 тактов (2,8 мкс). Кадр
индивидуально адресован — Ack через SIFS обязателен (802.11-2020 10.3.2.11). Было: концов PPDU на один больше своего
счётчика — ветка рассинхронизации (трасса 0xeeee04) считала кадр «без события», Ack нет; ядро повторяло кадр, а при тике
L1 перед кадром (vendor: тик целиком раньше приёма) — все повторы без Ack и uc_assert 0x26/0x6002.

Здесь — rx_flow_run в модели MAC (machw): вход до конца кадра с концом во время пролога и вход сразу после конца — Ack
через SIFS в срок (H-SIFSRESP SC), без 0xeeee04; по портам (ucemu): порог SIFS_CNT пути (SIFS_CNT_RX_LATE_END_SC, uc/ifs.h),
control PHY, новый PPDU, снятый отчёт — прежний разбор рассинхронизации."""
import pytest

from machw import HW, RESP_CMD_DEADLINE_SC_CLK, sc_txtime_clk

ADDBA_RESP_LEN = 37
EEEE04 = 0xeeee04                                           # трасса ветки рассинхронизации счётчика PPDU
RESP_CMD = 0x37000020                                       # команда ответа через SIFS (rx_frame_tx_resp_seq)
PPDU_EVT_CNT = 0x800578                                     # ppdu_evt_cnt — свой счётчик концов PPDU uc
NOEVT_CNT = 0x800574                                        # rx_flow_noevt_cnt
# Порог SIFS_CNT позднего конца для SC (uc/ifs.h SIFS_CNT_RX_LATE_END_SC): код SIFS_CNT — мкс << 8 | такты 0..164
SC_LATE_END_LIMIT = (1 << 8) | 90


def _frame_report(uc, mcs):
    """Отчёт о кадре (r36..r39) как у test_uc_deadlines.sifs_frame('ack') — кадр с Ack от известной станции; r38 [24:20]
    received_mcs — PHY кадра (0 — control, иначе SC)."""
    import test_uc_deadlines as d
    from test_uc_beacon_tx import clean_shadows
    uc.cpu.regs[25] = d.MAC_CMD_LOG
    clean_shadows(uc)
    d.sifs_frame(uc, 'ack')
    rep = {n: uc.ext.pop(n) for n in (36, 37, 38, 39)}
    rep[38] = (rep[38] & ~(0x1f << 20)) | (mcs << 20)
    return rep


def _run_until(hw, t):
    while hw._next_t() is not None and hw._next_t() <= t:
        hw.advance_to_next()
    hw.now = max(hw.now, t)


@pytest.mark.parametrize('entry', [-60, 0, 30])
def test_short_sc_frame_ended_before_check_acked(uc, entry):
    """Кадр SC 3,38 мкс; uc входит в rx_flow_run за 60 тактов до его конца (конец — во время пролога, до проверки
    счётчиков), ровно в конец и через 30 тактов после него. Ack в эфире, команда ответа — в срок модели для SC
    (H-SIFSRESP, RESP_CMD_DEADLINE_SC_CLK от конца PPDU), ветки 0xeeee04 нет, свой счётчик PPDU догнал PHY."""
    rep = _frame_report(uc, 1)
    for n in (42, 40, 43, 45, 47, 55):
        uc.ext.pop(n, None)
    hw = HW(uc)
    dur = sc_txtime_clk(ADDBA_RESP_LEN, 1)
    assert dur == 558
    end = hw.air_rx(hw.now + 100, ADDBA_RESP_LEN, 'ADDBA Response пира (SC MCS 1)', report=rep, sifs_resp=True,
                    resp_len=14, dur=dur, mcs=1)
    _run_until(hw, end + entry)
    uc.call('rx_flow_run', stub={'uc_assert': 0}, max_steps=2_000_000)
    cmds = [c for _, c in hw.cmd_log]
    cmd = [t for t, c in hw.cmd_log if c == RESP_CMD]
    tx = [a for a in hw.air_log if a[2] == 'tx']
    assert EEEE04 not in cmds, 'ветка рассинхронизации: кадр без ответа'
    assert cmd and tx, 'нет ответа через SIFS'
    print('вход %+d: 0x37000020 через %d тактов после конца (срок SC %d), Ack в эфире через %.2f мкс' % (
        entry, cmd[0] - end, RESP_CMD_DEADLINE_SC_CLK, (tx[0][0] - end) / 165))
    assert not hw.late, hw.late
    assert not [c for c in uc.calls if c[0] == 'uc_assert'], uc.calls
    assert uc.r32(PPDU_EVT_CNT) & 0x3f == hw.ppdu_cnt & 0x3f


# ---- по портам: кадр, конец которого уже посчитан PHY (r40 PHY_SIGNALS: концы [13:8] = 1, начала CCA [21:16] = 1) ----

def _ports(uc, mcs=1, sifs_cnt=0x40, cca_cnt=1, report=True):
    rep = _frame_report(uc, mcs)
    uc.ext.update(rep)

    def r42(n, k):
        return (1 << 14) | (1 << 15) | ((1 << 16) if report else 0)
    # r40: выбор 0 — состояние MAC 2 (приём шёл на входе); PHY_SIGNALS — счётчики и cca_ppdu_comp (б24, приёма нет)
    uc.ext[40] = (1 << 24) | (cca_cnt & 0x3f) << 16 | 1 << 8 | 2
    uc.ext[42] = r42
    uc.ext[55] = sifs_cnt


def _run_ports(uc):
    uc.w32(PPDU_EVT_CNT, 0)
    n0 = uc.r32(NOEVT_CNT)
    uc.call('rx_flow_run', stub={'uc_assert': 0, 'uc_spin_until_event_tmo': 0}, max_steps=400_000)
    cmds = uc.mac_cmds
    return EEEE04 in cmds, RESP_CMD in cmds, uc.r32(NOEVT_CNT) - n0


def test_late_end_within_limit_answered(uc):
    """SIFS_CNT на проверке ниже порога SC — кадр разбирается, команда ответа есть, ветки 0xeeee04 нет."""
    _ports(uc, sifs_cnt=SC_LATE_END_LIMIT - 1)
    noevt, resp, d = _run_ports(uc)
    assert resp and not noevt and d == 0


@pytest.mark.parametrize('case', ['limit', 'zero', 'control', 'new_ppdu', 'no_report'])
def test_late_end_rejected(uc, case):
    """Прежний разбор рассинхронизации (0xeeee04, rx_flow_noevt_cnt + 1, без ответа): SIFS_CNT на пороге (ответ не
    успеет, SIFS_CNT_RX_LATE_END_SC), SIFS_CNT 0 (счёт не идёт — как у rx_end_switch_to_tx), control PHY (MCS 0: путь
    длиннее срока, uc/ifs.h), начался новый PPDU (начал CCA больше концов), отчёт о PPDU (r42 б16) снят."""
    kw = dict(limit=dict(sifs_cnt=SC_LATE_END_LIMIT), zero=dict(sifs_cnt=0), control=dict(mcs=0),
              new_ppdu=dict(cca_cnt=2), no_report=dict(report=False))[case]
    _ports(uc, **kw)
    noevt, resp, d = _run_ports(uc)
    assert noevt and not resp and d == 1


# ---- тик L1 при busy_event: проверка приёма между шагами тика (l1_tick_rx_first, uc/l1.c) ----

RX_ON_STATE = 0x8005bc                                      # rx_on_state: 0 — RX OFF (до LMAC 0x01, после 0x03)


@pytest.mark.parametrize('rx_on', [0, 1])
def test_tick_busy_dispatch_only_with_rx_on(uc, rx_on):
    """r42 б19 (busy_event) взведён на каждом шаге тика l1_task_entry(3). RX OFF: обработчик событий L1 из тика не
    вызывается — его предусловие rx_on_state != 0 (uc_assert 0x27), а busy_event при RX OFF бывает (стенд 2026-11-10:
    загрузка, uc_assert 0x27 из тика на обоих узлах). RX ON: вызывается — приём раньше остальных шагов тика."""
    uc.w16(RX_ON_STATE, rx_on)
    uc.ext[42] = lambda n, k: 1 << 19
    # вход в l1_task_dispatch_evt1 — по PC: из функции проверки он хвостовой (b), заглушка ucemu его не ловит;
    # дальше — выход, как из заглушки (blink — в тик)
    at = uc.sym['l1_task_dispatch_evt1'] & 0x1ffff
    c, n, step = uc.cpu, [0], uc.cpu.step

    def watch():
        if c.pc & 0x1ffff == at:
            n[0] += 1
            c.pc = c.regs[31]
            return None
        return step()
    c.step = watch
    try:
        uc.call('l1_task_entry', 3, stub={'uc_assert': 0}, max_steps=400_000)
    finally:
        del c.step
    assert not [x for x in uc.calls if x[0] == 'uc_assert'], uc.calls
    n = n[0]
    assert (n > 0) == bool(rx_on), n
