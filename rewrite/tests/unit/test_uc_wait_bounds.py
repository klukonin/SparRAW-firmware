# SPDX-License-Identifier: AGPL-3.0-or-later
"""Ожидания событий MAC в uc с пределом (политика: у ожидания бита/события железа, зависящего от эфира или пира, —
предел по времени стандарта и безопасный выход; прежде — вечный опрос, uc вставал навсегда).

- uc_spin_until_event_tmo: опрос r42 не дольше заданного числа проходов (UC_SPIN_PASSES(clk) — не меньше clk тактов);
  при пределе — счётчик, метка и TSF в fwsh_uc_wait (0x857978), возврат 0.
- rx_get_required_response: ожидание MAC_BAP_RX_UPDATE (r53 б3, BAP отметил приём) — не меньше aPPDUMaxTime + SIFS
  (2 мс, Table 20-30; 3 мкс), при пределе ответа нет (0), метка 0xff31.
- rx_flow_run (отчёт PPDU, r42 б16) и brp_responder_flow_enter (конец PPDU BRP, busy2 по маске 0x73): предел
  aPPDUMaxTime (+ SIFS), метки 0xff33 / 0xff32 — вызов uc_spin_until_event_tmo с этими метками проверяется по коду."""
import pytest

CLK = 165
PPDU_MAX_CLK = 2000 * CLK              # aPPDUMaxTime DMG (Table 20-30)
SIFS_CLK = 3 * CLK
UC_WAIT = 0x857978                     # fwsh_uc_wait: +0 tmo_cnt, +4 last_marker, +8 last_tsf
UC_WAIT_MARKER = 0x800628
EVT_BUSY2, EVT_PPDU_REPORT = 1 << 14, 1 << 16

RX_RESP_SKIP_CNT, DTI_QSET_MODE, RXF_STA = 0x800480, 0x8004f4, 0x802288
RX_BAP_RX_UP = 0x800544
PPDU_EVT_CNT = 0x800578                # тень r40 PHY_SIGNALS [13:8]
TX_CTX, OUT = 0x806900, 0x806a00


def passes(clk):
    return clk // 4 + 1                # UC_SPIN_PASSES (uc/proto.h)


@pytest.fixture
def uc(uc):
    """uc с обнулённым fwsh_uc_wait (на железе его обнуляет crt0 fw)."""
    for o in (0, 4, 8):
        uc.w32(UC_WAIT + o, 0)
    return uc


def test_spin_tmo_event(uc):
    uc.ext[42] = EVT_PPDU_REPORT
    n0 = uc.r32(UC_WAIT)
    assert uc.call('uc_spin_until_event_tmo', EVT_PPDU_REPORT, passes(PPDU_MAX_CLK), 0xff33) == 1
    assert uc.r32(UC_WAIT) == n0


@pytest.mark.parametrize('clk', [SIFS_CLK, PPDU_MAX_CLK])
def test_spin_tmo_bounded(uc, clk):
    """Событие не приходит: выход не раньше clk тактов (проход ≥ 4 тактов) и не позже 2·clk + путь; fwsh_uc_wait —
    счётчик + 1, метка, метка ожидания снята."""
    uc.ext[42] = 0
    uc.w32(UC_WAIT_MARKER, 0xff32)
    n0 = uc.r32(UC_WAIT)
    t0 = uc.t1()
    assert uc.call('uc_spin_until_event_tmo', EVT_BUSY2, passes(clk), 0xff32, max_steps=4_000_000) == 0
    dt = uc.t1() - t0
    assert clk <= dt <= 2 * clk + 200, dt
    assert uc.r32(UC_WAIT) == n0 + 1
    assert uc.r32(UC_WAIT + 4) == 0xff32
    assert uc.r32(UC_WAIT_MARKER) == 0


def _qos_data_for_us(uc, bap):
    """Принят QoS Data «для нас», не A-MPDU, Ack Policy Normal (r38 [17:16] = 0), тип ≠ ATIM: ветка ожидания BAP."""
    uc.w32(RX_RESP_SKIP_CNT, 0)
    uc.w32(DTI_QSET_MODE, 0)
    uc.w32(RXF_STA, 0)
    uc.ext.update({36: 1 << 1, 37: 0, 38: 0xe0000800, 39: 0x08002c50, 53: bap})


def test_bap_rx_update_answer(uc):
    """BAP отметил приём (б3) и статус (б5): ответ нужен (1), rx_bap_rx_up = 1, срывов нет."""
    _qos_data_for_us(uc, (1 << 3) | (1 << 5))
    n0 = uc.r32(UC_WAIT)
    assert uc.call('rx_get_required_response', TX_CTX, OUT) == 1
    assert uc.r32(RX_BAP_RX_UP) == 1
    assert uc.r32(UC_WAIT) == n0 and uc.r32(UC_WAIT_MARKER) == 0


def test_bap_rx_update_bounded(uc):
    """BAP приём не отмечает (r53 б3 = 0): выход не раньше aPPDUMaxTime + SIFS (вход возможен с начала кадра) и не
    позже ~2× этого; ответа нет (0), rx_bap_rx_up = 0, метка 0xff31 в fwsh_uc_wait; тень счётчика PPDU — по r40
    (за время ожидания PHY принял другие кадры). Прежде — вечный опрос (vendor 0x933004 так же)."""
    _qos_data_for_us(uc, 0)
    uc.w32(RX_BAP_RX_UP, 1)
    uc.w32(PPDU_EVT_CNT, 3)
    uc.ext[40] = (1 << 24) | (0x2a << 8) | 5
    n0 = uc.r32(UC_WAIT)
    t0 = uc.t1()
    assert uc.call('rx_get_required_response', TX_CTX, OUT, max_steps=4_000_000) == 0
    dt = uc.t1() - t0
    assert PPDU_MAX_CLK + SIFS_CLK <= dt <= 2 * (PPDU_MAX_CLK + SIFS_CLK), dt
    assert uc.r32(RX_BAP_RX_UP) == 0
    assert uc.r32(PPDU_EVT_CNT) == 0x2a
    assert uc.r32(UC_WAIT) == n0 + 1 and uc.r32(UC_WAIT + 4) == 0xff31
    assert uc.r32(UC_WAIT_MARKER) == 0


@pytest.mark.parametrize('fn,marker', [('rx_flow_run', 0xff33), ('brp_responder_flow_enter', 0xff32)])
def test_site_uses_bounded_spin(build_dir, toolchain, fn, marker):
    """Ожидания конца/отчёта PPDU в rx_flow_run и brp_responder_flow_enter — через uc_spin_until_event_tmo со своей
    меткой (третий аргумент, r2) рядом с вызовом."""
    import os
    import subprocess
    dis = subprocess.run([os.path.join(toolchain, 'bin', 'arc-elf32-objdump'), '-d', '--no-show-raw-insn',
                          os.path.join(build_dir, 'uc.elf')], capture_output=True, text=True).stdout
    lines = dis.split('<%s>:' % fn, 1)[1].split('\n\n', 1)[0].splitlines()
    calls = [i for i, ln in enumerate(lines) if '<uc_spin_until_event_tmo>' in ln]
    assert calls, fn
    assert any(('0x%x' % marker) in ' '.join(lines[max(0, i - 8):i + 2]) for i in calls), fn
