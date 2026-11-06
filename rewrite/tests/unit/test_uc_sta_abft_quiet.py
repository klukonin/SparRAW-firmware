# SPDX-License-Identifier: AGPL-3.0-or-later
"""Станция не начинает свою развёртку TxSS (ISS, инициатор SLS) внутри A-BFT — 802.11-2020 10.42.5.2: «In the A-BFT, the AP
or PCP is the initiator and the STA is the responder in the RSS part of the SLS»; ответчик передаёт только с начала
выбранного слота (backoff по слотам). A-BFT есть в BI, где маяк несёт Next A-BFT = 0 (9.3.4.2, рис. 9-77), начинается
через MBIFS после конца BTI и длится (A-BFT Length + 1)·aSSSlotTime (10.42.5.1, 10.42.5.2):
  aSSSlotTime = aAirPropagationTime + aSSDuration + MBIFS + aSSFBDuration + MBIFS,
  aSSDuration = (FSS − 1)·SBIFS + FSS·TXTIME(SSW) (табл. 10-… «aSSDuration»), FSS — значение поля + 1;
конец BTI — по Duration последнего принятого маяка (10.42.5.1, «A STA shall consider that a BTI is completed at the
expiration of the value within the Duration field»).

Захват assoc 2026-11-04 (судья эфира ref/air_judge, правило abft): станция до ассоциации (вход в BTI с пути приёма,
kind 1; GP0 взведён поздно — статус 4, A-BFT пропущена, автомат BI сразу в DTI) через 39 мкс после конца BTI шлёт 33 SSW
с Direction = 0 и Duration DTI — в A-BFT BI с Next A-BFT = 0 (2 слота × FSS 16). Цепочка здесь: маяк в пути приёма
(rx_flow_handle_frame) → bti_sta_beacon_abft_flow (kind 1, поздний GP0) → доступ MAC к среде для внутренней передачи
(internal_tx_isr, бит 3 — развёртка TxSS) в разные моменты BI; ожидания MAC — заглушки."""
import os

import pytest

import ucemu
from test_uc_beacon_rx import BTI_STUBS, RX_STUBS, bic_encode, dmg_beacon, stubs, sta  # noqa: F401 (sta — фикстура)

REW = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
A = ucemu.dccm_addrs(os.path.join(REW, 'uc', 'dccm.h'))

RX_BUF = 0x804010
BI_CTX = 0x802f44                     # struct bi_ctx_s: +0 kind, +4 status
BTI_CNT_X04 = 0x802a6c + 4            # bti_cnt.x04: б31..30 — итог взвода GP0 (0 — не взводился)
BCN_RX = 0x802f14                     # +1 abft_here
ITX = 0x8006cc                        # itx_pending: +0 mask, +4 mask2, +8 exclude, +0xc txss_postponed
BF_CUR_STA = 0x800470
UC_ROLE_AP = 0x8014c0
STA_ABFT = 0x85796c                   # include/fwsh.h fwsh_sta_abft: +0 end_tsf, +4 span_us, +8 txss_defer_cnt
EVT4_GP2_END = 1 << 8                 # r54 б8 — конец GP2 (взвод GP0 опоздал)

# 802.11-2020: табл. 20-30 (DMG), 10.3.2.3, 20.11.3 — мкс
SIFS, SBIFS, AIRPROP = 3.0, 1.0, 0.1
MBIFS = 3 * SIFS
TXTIME_SSW = 2460 / 165               # SSW 26 Б, control PHY (20.11.3) = 14,909 мкс
TXTIME_SSW_FB = 3012 / 165            # aSSFBDuration = TXTIME(SSW-Feedback 28 Б) = 18,255 мкс


def abft_window(t_bcn_end, duration, abft_len_field, fss_field):
    """[начало, конец) A-BFT по стандарту от конца принятого маяка."""
    fss = fss_field + 1
    ss_dur = (fss - 1) * SBIFS + fss * TXTIME_SSW
    slot = AIRPROP + ss_dur + MBIFS + TXTIME_SSW_FB + MBIFS
    start = t_bcn_end + duration + MBIFS
    return start, start + (abft_len_field + 1) * slot


def beacon_rx(uc, frame, tsf, kind1_late=True):
    """Маяк сети в пути приёма, затем вход в BTI с пути приёма (kind 1) с поздним GP0 — как у станции до ассоциации."""
    uc.wbytes(RX_BUF, frame)
    uc.ext.update({42: 1 << 16, 36: 1 << 7, 38: 0, 37: 0, 55: tsf})
    uc.call('rx_flow_handle_frame', 0x807e00, stub=stubs(uc, RX_STUBS))
    uc.w32(BI_CTX, 1)
    uc.w8(BI_CTX + 4, 0)
    uc.w32(BTI_CNT_X04, 0)
    uc.ext.update({54: EVT4_GP2_END if kind1_late else 0, 55: tsf})
    uc.call('bti_sta_beacon_abft_flow', BI_CTX,
            stub=stubs(uc, ['uc_assert', 'uc_log_emit_snapshot', 'bti_beacon_track_best_metric']))
    return uc.r8(BI_CTX + 4)


def txss_access(uc, tsf):
    """MAC дал доступ к среде внутренней передаче (бит 3 — BF станции 0): 1 — развёртка TxSS начата."""
    uc.w32(ITX, 1 << 3)
    uc.w32(ITX + 4, 0)
    uc.w32(ITX + 8, 0)
    uc.w32(BF_CUR_STA, 0)
    uc.ext.update({55: tsf, 54: 0})
    uc.calls = []
    uc.call('internal_tx_isr', stub=stubs(uc, ['bf_sm_run_sta', 'bg_task_set_pending_bit', 'uc_log_emit1',
                                               'uc_log_emit3', 'mac_backoff_settle_set_chain_modes', 'uc_assert']))
    ran = any(n == 'bf_sm_run_sta' for n, _ in uc.calls)
    assert bool(uc.r32(ITX) & (1 << 3)) == (not ran), 'бит 3 снят без развёртки или остался после неё'
    return ran


def _sta_ready(uc):
    uc.w32(UC_ROLE_AP, 0)
    for o in range(0, 0xc, 4):
        uc.w32(STA_ABFT + o, 0)


T0 = 50_000_000                                   # TSF записи маяка (мкс) — после отчёта PPDU (конец маяка)


@pytest.mark.parametrize('abft_len,fss', [(1, 15), (0, 15), (7, 15), (1, 3), (3, 8)])
@pytest.mark.parametrize('duration', [0, 22, 1400])
def test_sta_no_iss_inside_abft(sta, abft_len, fss, duration):
    """Маяк с Next A-BFT = 0 (A-BFT Length, FSS — разные, в т. ч. FSS < aSSFramesPerSlot: A-BFT идёт и без нас): во
    всей A-BFT развёртка TxSS станции не начинается (бит 3 остаётся — MAC даст доступ снова), после её конца —
    начинается не позже чем через 2 мкс (модель TSF uc — целые мкс)."""
    _sta_ready(sta)
    bcn = dmg_beacon(bic_encode(next_abft=0, abft_len=abft_len, fss=fss), duration=duration, cdown=3)
    assert beacon_rx(sta, bcn, T0) == 4                   # A-BFT пропущена, автомат BI — в DTI (как на стенде)
    s, e = abft_window(T0, duration, abft_len, fss)
    for t in [T0 + duration, s, s + 30, (s + e) / 2, e - 1]:          # начало DTI по мнению автомата BI … конец A-BFT
        assert not txss_access(sta, int(t)), 'ISS станции в A-BFT: %.1f мкс от начала A-BFT [%.1f, %.1f)' % (
            t - s, s - T0, e - T0)
    assert txss_access(sta, int(e) + 2), 'после конца A-BFT развёртка не началась'
    assert sta.r32(STA_ABFT + 8) == 5


@pytest.mark.parametrize('next_abft', [1, 2, 15])
def test_sta_iss_right_after_bti_without_abft(sta, next_abft):
    """Next A-BFT ≠ 0 — A-BFT в этом BI нет (10.42.5.1): DTI сразу за BTI, развёртку не откладываем."""
    _sta_ready(sta)
    bcn = dmg_beacon(bic_encode(next_abft=next_abft, abft_len=1, fss=15), duration=22)
    beacon_rx(sta, bcn, T0)
    assert txss_access(sta, T0 + 22 + 30)
    assert sta.r32(STA_ABFT + 8) == 0


def test_sta_abft_gate_survives_tsf_jump(sta):
    """Скачок TSF (синхронизация с точкой) — запись вне окна действительности, развёртка не откладывается."""
    _sta_ready(sta)
    beacon_rx(sta, dmg_beacon(bic_encode(next_abft=0, abft_len=1, fss=15), duration=22), T0)
    assert txss_access(sta, T0 - 1_000_000)
    assert txss_access(sta, T0 + 22 + 10_000_000)


def test_ap_txss_not_gated(sta):
    """Точка (инициатор A-BFT своего BI) — проверка только для станции."""
    _sta_ready(sta)
    beacon_rx(sta, dmg_beacon(bic_encode(next_abft=0, abft_len=1, fss=15), duration=22), T0)
    sta.w32(UC_ROLE_AP, 1)
    sta.w32(0x80229c + 8, 0)                               # bcn_bi.bi_len_us = 0: без проверки конца BI
    assert txss_access(sta, T0 + 22 + 30)


@pytest.mark.parametrize('fss,resp_txss', [(2, 1), (15, 0)])
def test_sta_no_iss_in_abft_without_us_synced(sta, fss, resp_txss):
    """GP0 взведён вовремя (итог взвода в bti_cnt.x04 = 1), но A-BFT не для неё (FSS < aSSFramesPerSlot или RXSS
    ответчика, IsResponderTXSS = 0): GP2 конца A-BFT не взводится, автомат BI её не ждёт — A-BFT при Next A-BFT = 0
    всё равно идёт (10.42.5.1), развёртка TxSS в ней не начинается."""
    _sta_ready(sta)
    bcn = dmg_beacon(bic_encode(next_abft=0, abft_len=1, fss=fss, is_resp_txss=resp_txss), duration=22)
    sta.wbytes(RX_BUF, bcn)
    sta.w32(BI_CTX, 1)
    sta.w32(BTI_CNT_X04, 1 << 30)                        # GP0 взведён вовремя (по маяку взвода)
    sta.w8(BCN_RX + 1, 0)                                # abft_here = 0 (решение bti_beacon_rx_step)
    sta.ext.update({55: T0, 54: (1 << 6) | EVT4_GP2_END})   # GP0/GP2 кончились: слежение за маяками BTI выходит сразу
    sta.call('bti_sta_beacon_abft_flow', BI_CTX, stub=stubs(sta, ['uc_assert', 'uc_log_emit_snapshot']))
    assert sta.r8(BI_CTX + 4) != 4
    s, e = abft_window(T0, 22, 1, fss)
    assert not txss_access(sta, int(s) + 30)
    assert txss_access(sta, int(e) + 2)
