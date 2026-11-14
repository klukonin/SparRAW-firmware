# SPDX-License-Identifier: AGPL-3.0-or-later
"""Начало BI в L1 (l1_task_dispatch): смена слота MAC_MON (публикуется слот прошлого BI) и снимок TSF/счётчика BI —
ровно один раз за BI на обоих путях входа в BTI: по bi1_event (случай 0) и по маяку своей BSS, принятому rx_flow DTI
до разбора bi1_event (случай 5). Детектор потерь маяков fw считает по опубликованному слоту;
без смены слота на пути случая 5 fw получал пустой слот каждый BI и рвал связь «lost link: no beacons» при маяке в
каждом BTI (стенд 2026-11-13, AP .12 / STA .11, под нагрузкой приём DTI накрывает TBTT)."""

BI_CTX = 0x802f44                   # struct bi_ctx_s
BI_START_RX = BI_CTX + 7            # bi_ctx.bi_start_rx
SLOT_IDX = 0x801080                 # mac_mon_slot_idx
STUBS = {'uc_sm_handle_event': 0, 'bi_timing_snapshot': 0, 'bi_after_enter_dti': 0}


def fn_range(uc, fn):
    """Границы функции по таблице символов: хвостовой «b» в заглушку (uc_sm_handle_event) cpu.py ловит только
    при заданном func_range, ucemu его не задаёт."""
    lo = uc.sym[fn] & 0x1ffff
    return lo, min(a & 0x1ffff for a in uc.sym.values() if (a & 0x1ffff) > lo)


def call(uc, fn, *args):
    uc.calls.clear()
    uc.cpu.func_range = fn_range(uc, fn)
    try:
        uc.call(fn, *args, stub=STUBS)
    finally:
        uc.cpu.func_range = None


def dispatch(uc, a, b=0):
    call(uc, 'l1_task_dispatch', a, b)
    return [n for n, _ in uc.calls if n == 'bi_timing_snapshot']


def enter_dti(uc):
    call(uc, 'bi_sm_on_enter_dti', BI_CTX)


def test_bi1_event_path_flips_once_per_bi(uc):
    """Обычный путь: bi1_event каждого BI меняет слот и снимает время; вход в DTI ничего не ломает."""
    uc.w8(SLOT_IDX, 0)
    uc.w8(BI_START_RX, 0)
    for k in range(4):
        assert dispatch(uc, 0) == ['bi_timing_snapshot']
        assert uc.r8(SLOT_IDX) == (k + 1) % 2
        enter_dti(uc)
        assert uc.r8(BI_START_RX) == 0


def test_rx_flow_beacon_path_flips_slot(uc):
    """Маяк своей BSS из rx_flow DTI (случай 5, b = 0) входит в BTI — слот меняется так же, как по bi1_event;
    поздний bi1_event того же BI слот не меняет второй раз; вход в DTI снимает отметку — следующий BI по bi1_event."""
    uc.w8(SLOT_IDX, 0)
    uc.w8(BI_START_RX, 0)
    assert dispatch(uc, 5, 0) == ['bi_timing_snapshot']
    assert uc.r8(SLOT_IDX) == 1 and uc.r8(BI_START_RX) == 1
    assert dispatch(uc, 5, 0) == []                          # второй маяк того же BTI
    assert dispatch(uc, 0) == []                             # bi1_event этого BI разобран после маяка
    assert uc.r8(SLOT_IDX) == 1
    enter_dti(uc)
    assert uc.r8(BI_START_RX) == 0
    assert dispatch(uc, 0) == ['bi_timing_snapshot']
    assert uc.r8(SLOT_IDX) == 0


def test_rx_flow_every_bi_alternates(uc):
    """Под нагрузкой путь случая 5 — каждый BI подряд: слот чередуется каждый BI (иначе маяки копятся в одном слоте,
    опубликованный пуст)."""
    uc.w8(SLOT_IDX, 0)
    uc.w8(BI_START_RX, 0)
    for k in range(6):
        assert dispatch(uc, 5, 0) == ['bi_timing_snapshot']
        assert uc.r8(SLOT_IDX) == (k + 1) % 2
        enter_dti(uc)


def test_rx_flow_other_result_keeps_slot(uc):
    """rx_flow без маяка своей BSS (b ≠ 0) BI не начинает."""
    uc.w8(SLOT_IDX, 0)
    uc.w8(BI_START_RX, 0)
    assert dispatch(uc, 5, 1) == []
    assert uc.r8(SLOT_IDX) == 0 and uc.r8(BI_START_RX) == 0
