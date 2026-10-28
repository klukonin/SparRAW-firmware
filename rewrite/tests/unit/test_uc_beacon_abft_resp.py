# SPDX-License-Identifier: AGPL-3.0-or-later
"""Ответ станции в A-BFT по полям принятого DMG Beacon (802.11-2020 10.42.5.2, 10.42.2.3, 9.3.1.15, 9.5.1/9.5.2):
маяк → решение (bti_bi2_event_step) → abft_responder_fast: слот по backoff, пачка SSW (число = FSS + 1, CDOWN,
Direction, Sector ID, Duration до конца слота), шаблон SSW (RA, SSW Feedback), пропуск A-BFT после Feedback в
Discovery Mode. Ожидания MAC, отправка кадра и разбор SSW-Feedback — заглушки (Feedback «принят»).

Факты о MAC: 0x2d — поле SSW кадра (рис. 9-846: б0 Direction, б1..9 CDOWN, б10..15 Sector ID); перед каждым SSW
0x15 + 0x14000007 — Duration буквально (uc/abft.h, H-DUR); событие слота — r54.7, конец A-BFT — r54.8."""
import math

import pytest

from test_uc_beacon_rx import ABFT_CFG, BCN_RX, AP, OWN, bic_encode, bti_path, dmg_beacon, sta  # noqa: F401
from test_uc_beacon_tx import CLK, SBIFS, SSW_LEN, ctrl_txtime, ss_slot_time, ssw_field, stubs, zero

REC = 0x803e80                      # sls_peer_rec ответа (bi_ctx.rec), 0x18 Б
SSW_TPL = 0x802b4c                  # шаблон SSW: +0 FC, +4 RA, +0x13 SSW Feedback (3 Б)
RESP_STUBS = ['mac_set_mode_a000', 'uc_spin_until_event4', 'abft_arm_response_window', 'l1_task_dispatch',
              'abft_send_ssw_feedback', 'mac_program_tx_common', 'mac_evt_enable_bit_sync_b', 'mac_evt_enable_bit_sync',
              'tx_program_vector_rf', 'mac_set_rf_chain_state_with_sta_sector', 'uc_wait_event1_or_event4',
              'uc_evt_build_and_post_report', 'uc_assert']


def respond(uc, slot=0):
    """abft_responder_fast после маяка CDOWN 0 (слот выбран заранее): ждёт slot событий границ слотов, передаёт пачку,
    получает Feedback (заглушка разбора → 1), ждёт конца A-BFT (r54.8)."""
    zero(uc, REC, 0x18)
    uc.w8(REC + 0xd, 8)
    uc.w8(0x800439, 0)                                  # abft_gp0_armed
    reads = {'n': 0}

    def r54(n, k):                                      # чтения r54: вход, затем одно на событие; конец A-BFT — после Feedback
        return 0x100 if k >= slot + 2 else 0
    uc.ext.update({54: r54, 55: 0x10, 43: 1 << 31, 42: (1 << 15) | (1 << 12), 45: 1 << 31})
    s = stubs(uc, RESP_STUBS)
    s.update(abft_resp_parse_fdbk=1, tx_ctx_alloc_next=0x803f80)
    uc.call('abft_responder_fast', REC, 1, slot, stub=s)
    cmds = uc.mac_cmds
    ssw, dur = [], []
    for i, c in enumerate(cmds):
        if c >> 24 == 0x2d:
            ssw.append(ssw_field(c & 0xffffff))
            nxt = cmds[i + 1]
            assert nxt >> 24 == 0x15 and cmds[i + 2] == 0x14000007, [hex(x) for x in cmds[i:i + 3]]
            dur.append(nxt & 0xffffff)
    slot_evts = [i for i, c in enumerate(cmds) if c == 0x49000080]
    first = next(i for i, c in enumerate(cmds) if c >> 24 == 0x2d)
    return ssw, dur, sum(1 for i in slot_evts if i < first)


def beacon_then_respond(uc, slot=0, **bic):
    """Маяк BTI (путь bti_bi2_event_step) → ответ. Сектор лучшего маяка 5, антенна 0."""
    s = bti_path(uc, dmg_beacon(bic_encode(**bic), bssid=AP, sector=5))
    assert s['abft_go'] == 1
    return respond(uc, slot)


@pytest.mark.parametrize('fss', [4, 5, 8, 15])
def test_ssw_burst_fss_cdown_direction(sta, fss):
    """9.3.4.2: FSS — число SSW в слоте − 1; 10.42.5.2: ответчик передаёт в слоте не больше этого числа SSW;
    10.42.2.3.2: CDOWN — оставшиеся передачи, последний SSW — CDOWN 0; 9.5.1: Direction = 1 (ответчик);
    Sector ID однозначно указывает сектор (TXSS — разные секторы)."""
    ssw, _, _ = beacon_then_respond(sta, fss=fss)
    assert len(ssw) == fss + 1
    assert [x['cdown'] for x in ssw] == list(range(fss, -1, -1))
    assert all(x['direction'] == 1 for x in ssw)
    assert len({x['sector'] for x in ssw}) == len(ssw)


@pytest.mark.parametrize('fss', [4, 7, 15])
def test_ssw_duration_until_end_of_slot(sta, fss):
    """9.3.1.15: в A-BFT Duration SSW — время до конца текущего SSW-слота; 9.2.5.1 — вверх до мкс. Пачка с начала
    слота (10.42.5.2), кадры через SBIFS: k-й SSW кончается через k·(TXTIME(SSW) + SBIFS) + TXTIME(SSW)."""
    _, dur, _ = beacon_then_respond(sta, fss=fss)
    slot = ss_slot_time(fss)
    t = ctrl_txtime(SSW_LEN)
    assert dur == [math.ceil(slot - k * (t + SBIFS) - t) for k in range(fss + 1)]


@pytest.mark.parametrize('slot', [0, 1, 3, 7])
def test_ssw_burst_starts_in_backoff_slot(sta, slot):
    """10.42.5.2: backoff уменьшается в конце каждого слота; RSS — только в начале слота, где backoff = 0, т. е. в
    слоте с номером backoff (от 0): перед пачкой — slot + 1 событий границ слотов (r54.7)."""
    _, _, n_evt = beacon_then_respond(sta, slot=slot, abft_len=7)
    assert n_evt == slot + 1


def test_ssw_template_ra_and_feedback(sta):
    """9.3.1.15: RA — адрес станции, которой адресована развёртка (передатчик маяка — BSSID DMG Beacon, 9.3.4.2);
    FC — Control, подтип Control Frame Extension, SSW (9.2.4.1.3); SSW Feedback (рис. 9-849, вне ISS):
    Sector Select / DMG Antenna Select — сектор и антенна лучшего маяка (кадра ISS)."""
    beacon_then_respond(sta)
    fc = sta.r16(SSW_TPL)
    assert (fc >> 2 & 3, fc >> 4 & 0xf, fc >> 8 & 0xf) == (1, 6, 8)
    assert sta.rbytes(SSW_TPL + 4, 6) == AP
    fb = int.from_bytes(sta.rbytes(SSW_TPL + 0x13, 3), 'little')
    assert (fb & 0x3f, fb >> 6 & 3) == (5, 0)


@pytest.mark.parametrize('disc', [0, 1])
def test_feedback_then_next_abfts(sta, disc):
    """10.42.5.2: после SSW-Feedback в A-BFT маяка с Discovery Mode = 1 следующие aMaxABFTAccessPeriod (2) A-BFT не
    используются; без Discovery Mode такого правила нет — станция может отвечать в следующем же A-BFT."""
    beacon_then_respond(sta, discovery=disc)
    go = []
    for _ in range(3):
        zero(sta, BCN_RX + 0x1e, 2)
        go.append(bti_path(sta, dmg_beacon(bic_encode(discovery=disc)))['abft_go'])
    assert go == ([0, 0, 1] if disc else [1, 1, 1])


@pytest.mark.xfail(strict=True, reason='10.42.2.3.3: в A-BFT с IsResponderTXSS = 0 (responder RXSS) станция шлёт SSW '
                                       'через разные секторы (TXSS); RXSS — все SSW через один выбранный сектор')
@pytest.mark.parametrize('fss', [4, 15])
def test_rxss_abft_single_sector(sta, fss):
    """10.42.5.2: IsResponderTXSS = 0 — A-BFT для responder RXSS; 10.42.2.3.3: «the responder shall transmit the number
    of SSW frames indicated … FSS field (A-BFT) from the DMG antenna and sector that were selected during the preceding
    TXSS». Станция либо не передаёт в таком A-BFT, либо все SSW — через один сектор."""
    s = bti_path(sta, dmg_beacon(bic_encode(fss=fss, is_resp_txss=0), bssid=AP, sector=5))
    if not s['abft_go']:
        return
    ssw, _, _ = respond(sta)
    assert len(ssw) == fss + 1
    assert len({x['sector'] for x in ssw}) == 1
