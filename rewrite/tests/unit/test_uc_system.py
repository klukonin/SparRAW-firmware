# SPDX-License-Identifier: AGPL-3.0-or-later
"""uc с загрузки в модели MAC с прерываниями (machw.HW, irqs=True): таймеры ARC и уровни прерываний ARC600.

uc_main инициализирует себя (bi_mode_init_sequence, uc_timers_start_with_irq: таймер 0 — 1650 тактов, L1; таймер 1 —
сторож 2 с, L2), разрешает E1/E2 и уходит в главный цикл: фоновые задачи, затем sleep. Будит его тик L1 (вектор 3,
l1_task_entry(3)), обработчик снимает IP записью CONTROL0 и возвращается j.f [ilink1] за sleep. Проверяется сама
механика: тики идут с периодом таймера, каждый обработан на уровне 1 и закончен, между тиками ядро спит."""
from machw import HW, TIMER_VEC

STEPS = 60_000
BG_TASK_PENDING = 0x800648                                     # uc/dccm.h bg_task_pending


def boot(uc, steps=STEPS):
    hw = HW(uc)
    try:
        uc.call('uc_main', max_steps=steps)
    except RuntimeError as e:                                   # главный цикл не возвращается — так и должно быть
        assert 'не вернулась' in str(e), e
    return hw


def test_timer0_ticks_wake_main_loop(uc):
    hw = boot(uc)
    c = uc.cpu
    assert hw.timers[0].limit == 1650 and hw.timers[0].ctrl & 1, 'таймер 0 не запущен с прерыванием'
    assert c.read_aux(0x200) >> TIMER_VEC[0] & 1 == 0, 'тик таймера 0 — уровень 1'
    ticks = [t for t, n in hw.irq_log if n == TIMER_VEC[0]]
    assert len(ticks) > 100
    periods = {b - a for a, b in zip(ticks, ticks[1:])}
    assert periods == {hw.timers[0].limit + 1}, periods         # H-TVEC: период LIMIT + 1, доставка без опозданий
    sleeps = sum(1 for e in c.trace if e[0] == 'sleep')
    rti = sum(1 for e in c.trace if e == ('rti', 1))
    assert abs(sleeps - len(ticks)) <= 1 and abs(rti - len(ticks)) <= 1   # каждый тик: из сна, обработан, снова сон


def test_watchdog_timer1_level2(uc):
    hw = boot(uc, 10_000)
    c = uc.cpu
    assert hw.timers[1].limit == 0x13ab6680 and hw.timers[1].ctrl & 1
    assert c.read_aux(0x200) >> TIMER_VEC[1] & 1 == 1, 'сторож (таймер 1) — уровень 2'


def test_sleep_until_event_wakes_by_level2(uc):
    """uc_sleep_until_event: маска событий r42 в 0x886d3c, взвод 0x21000002, sleep; событие из маски — L2 вектор 10
    (H-WAKE), l2_task_entry(1) квитирует 0x21000009, j.f [ilink2] — за sleep, STATUS32 восстановлен."""
    from machw import WAKE_VEC
    hw = HW(uc)
    c = uc.cpu
    c.aux[0x200] |= 1 << WAKE_VEC                              # bi_mode_init_event_timers: uc_irq_set_level(0xa, 1)
    c.aux[0x0a] |= 0x6                                         # главный цикл: E1 | E2
    from machw import IRQ_ENTRY_CLK, IRQ_WAKE_CLK
    t_ev = hw.now + 5000
    hw.at(t_ev, lambda: hw._set42(15), 'tx_end')               # tx_end_event через 5000 тактов
    uc.call('uc_sleep_until_event', 1 << 15, 0)
    wakes = [t for t, n in hw.irq_log if n == WAKE_VEC]
    assert wakes == [t_ev + IRQ_ENTRY_CLK + IRQ_WAKE_CLK], (t_ev, hw.irq_log)   # спящее ядро: сразу + вход + пробуждение
    assert 0x21000009 in uc.mac_cmds
    assert c.read_aux(0x43) == 0 and c.read_aux(0x0a) & 6 == 6


def test_fw2uc_wake_request_l1(uc):
    """fw → uc: причина «выход из сна» (fw2uc ICR б2) при спящем главном цикле — L1 вектор 8 (H-FW2UC):
    l1_task_entry(0) читает ICM, маскирует б2 (IMS) и откладывает обработку в фоновую задачу 4."""
    from machw import FW2UC_VEC
    hw = boot(uc, 20_000)
    t_req = hw.now
    hw.fw2uc(4)
    c = uc.cpu
    for _ in range(3000):                                    # продолжить главный цикл после загрузки
        c.step()
        if any(n == FW2UC_VEC for _, n in hw.irq_log):
            break
    got = [t for t, n in hw.irq_log if n == FW2UC_VEC]
    assert got and got[0] >= t_req, hw.irq_log[-5:]
    for _ in range(3000):
        c.step()
        if hw.f2u.imv & 4:
            break
    assert hw.f2u.imv & 4, 'б2 не замаскирован'
    pend = False
    for _ in range(200):
        c.step()
        pend = pend or bool(uc.r32(BG_TASK_PENDING) & (1 << 4))
    assert pend, 'фоновая задача 4 не отложена'


def test_late_response_command_is_mac_error_l2(uc):
    """Поздняя команда ответа через SIFS (H-LATE): MAC_HW_ICR б4 → L2 вектор 6 (H-MACERR) прямо во время пути приёма
    в L1 (E1 = 0, E2 = 1) → l2_task_report_error_bits → assert 0x26, как у железа (uc/rx.c:682, стенд std9)."""
    import test_uc_deadlines as d
    from test_uc_beacon_tx import clean_shadows
    from machw import MACERR_VEC
    uc.cpu.regs[25] = d.MAC_CMD_LOG
    clean_shadows(uc)
    d.sifs_frame(uc, 'ack')
    rep = {n: uc.ext.pop(n) for n in (36, 37, 38, 39)}
    for n in (42, 40, 43, 45, 47, 55):
        uc.ext.pop(n, None)
    hw = HW(uc)
    c = uc.cpu
    c.aux[0x0a] = (c.aux.get(0x0a, 0) & ~2) | 4             # путь приёма — в L1: E1 снят, E2 разрешён
    uc.call('irq_init_event_masks')                          # маски MAC_HW_ICR / ERRORS, уровень вектора 6 — L2
    t0 = hw.now
    hw.air_rx(t0, 200, 'кадр пира', report=rep, sifs_resp=True, resp_len=14, resp_deadline=100)   # срок невыполним
    hw.advance_to_next()
    a = uc.sym['uc_assert']
    c.breakpoints.update({a, a & 0x1ffff})                   # остановиться на входе uc_assert (из L2 — хвостовой переход)
    try:
        uc.call('rx_flow_run', max_steps=2_000_000)
    finally:
        c.breakpoints.difference_update({a, a & 0x1ffff})
    assert hw.late, 'опоздание не зафиксировано'
    assert any(n == MACERR_VEC for _, n in hw.irq_log), hw.irq_log
    assert uc.where(c.pc).startswith('uc_assert+0x0') and c.regs[1] == 0x26, (uc.where(c.pc), hex(c.regs[1]))
    assert c.read_aux(0x43) & 2, 'assert — внутри L2'


def test_fw_lmac_command_round_trip(uc):
    """Ящик fw ↔ uc во времени: uc после загрузки шлёт «ucode ready» (событие 0x00); команда LMAC 0x03 (RX off) от
    fw — запись кольца команд и причина fw2uc б0 → L1 вектор 8 → ответ uc событием 0x03."""
    from machw import FW2UC_VEC
    hw = boot(uc, 20_000)
    assert [t for t, _ in hw.uc_events()] == [0x00]
    t0 = hw.now
    hw.lmac_cmd(0x03)
    c, ev = uc.cpu, []
    for _ in range(20_000):
        c.step()
        ev += hw.uc_events()
        if ev:
            break
    assert [t for t, _ in ev] == [0x03], ev
    assert any(n == FW2UC_VEC and t >= t0 for t, n in hw.irq_log)
    assert hw.now - t0 < 2000, hw.now - t0


def test_bi1_event_before_tbtt(uc):
    """H-BI1: после команды 0x0d MAC поднимает bi1_event за (период − [0x886d18]) мкс − [0x886d1c] тактов до TBTT
    (1235 тактов при штатных 0x18ff8 / 0x55), TBTT — сетка периода [0x886d64]·1024 мкс. В сам момент bi1_event
    0x886ec0 (целые мкс TSF) — 8; на стенде на входе L1 — 7 (метка STAMP_BI1_LEAD, 270 из 350): позже на вход и путь."""
    from machw import CLK_PER_US
    hw = HW(uc)
    for a, v in ((0x886d64, 0x64), (0x886d18, 0x18ff8), (0x886d1c, 0x55)):
        uc.w32(a, v)
    hw._cmd(0x0d000006)
    seen = []
    for _ in range(3):
        while not hw.tbtt_log or len(hw.tbtt_log) == len(seen):
            hw.advance_to_next()
        t, tbtt = hw.tbtt_log[-1]
        seen.append((t, tbtt, uc.r32(0x886ec0)))
    for t, tbtt, to_tbtt in seen:
        assert (tbtt - hw.tsf0_us) * CLK_PER_US - t == 8 * CLK_PER_US - 0x55
        assert to_tbtt == 8
    assert [b[1] - a[1] for a, b in zip(seen, seen[1:])] == [102400, 102400]
