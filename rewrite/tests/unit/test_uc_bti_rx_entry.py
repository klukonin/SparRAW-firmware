# SPDX-License-Identifier: AGPL-3.0-or-later
"""Вход станции в BTI с пути приёма (bti_transmitter_bi2_flow, kind = 1): маяк уже разобран, uc ждёт следующий маяк
этого BTI, чтобы вовремя взвести A-BFT. Живучесть: ожидание ограничено концом BTI — Duration маяка (9.3.4.2: время до
конца BTI); в BTI в эфире только маяки. Без срока станция ждала маяк следующего BI и отбрасывала кадры DTI (RTS, BRP,
данные) — стенд 2026-10-28: шторм CTS, провал BRP, «lost link: no beacons»."""
import pytest

BI_CTX = 0x802f44                   # struct bi_ctx_s: +0 kind, +4 status
RX_DURATION = 0x804012              # Duration принятого маяка, мкс
RX_BCN_SSW = 0x804022               # поле SSW маяка: б1..9 CDOWN
BCN_RX_LATE = 0x802f14 + 0x1c       # bcn_rx.abft_gp0_late_cnt
CLK_PER_US = 165
EVT_BI2, EVT_RX_FRAME = 1 << 5, 1 << 12

STUBS = {}                          # ожидания MAC исполняются: зависание должно быть видно


def enter(uc, duration_us, cdown):
    uc.w32(BI_CTX, 1)
    uc.w8(BI_CTX + 4, 0)
    uc.w16(RX_DURATION, duration_us)
    uc.w16(RX_BCN_SSW, cdown << 1)
    uc.w16(BCN_RX_LATE, 0)


@pytest.mark.parametrize('duration_us', [50, 1000, 3000])
def test_no_next_beacon_returns_by_end_of_bti(uc, duration_us):
    """Следующий маяк к станции не пришёл (сектора развёртки направлены мимо): uc возвращается к приёму не позже конца
    BTI, A-BFT этого BI пропущен (status 4, abft_gp0_late_cnt + 1) — как при позднем взводе GP0."""
    enter(uc, duration_us, cdown=40)
    uc.ext[42] = 0                                    # ни кадра, ни bi2_event
    t0 = uc.t1()
    uc.call('bti_transmitter_bi2_flow', BI_CTX, stub=STUBS, max_steps=40 * duration_us * CLK_PER_US)
    waited_us = (uc.t1() - t0) / CLK_PER_US
    assert waited_us <= duration_us * 1.05 + 20, 'ждал %.0f мкс при конце BTI через %d' % (waited_us, duration_us)
    assert uc.r8(BI_CTX + 4) == 4
    assert uc.r16(BCN_RX_LATE) == 1


def test_wait_survives_timer1_wrap(uc):
    """COUNT1 заворачивается на пределе 0x13ab6680 (и сбрасывается тиком L1): срок не должен стать бесконечным."""
    import ucemu
    uc.t1_base = ucemu.T1_LIMIT - 1000
    enter(uc, 100, cdown=10)
    uc.ext[42] = 0
    uc.call('bti_transmitter_bi2_flow', BI_CTX, stub=STUBS, max_steps=200 * 100 * CLK_PER_US)
    assert uc.r8(BI_CTX + 4) == 4


def test_last_beacon_does_not_wait(uc):
    """CDOWN = 0 — маяков в этом BTI больше нет: ждать нечего, ожидания маяка нет вовсе."""
    enter(uc, 1000, cdown=0)
    uc.ext[42] = 0
    t0 = uc.t1()
    uc.call('bti_transmitter_bi2_flow', BI_CTX, stub=STUBS)
    assert (uc.t1() - t0) / CLK_PER_US < 50
