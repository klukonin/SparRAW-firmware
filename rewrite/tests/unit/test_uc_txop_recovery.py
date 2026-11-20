# SPDX-License-Identifier: AGPL-3.0-or-later
"""Поток вверх станция → наша точка вставал через ~1 с (стенд 2026-11-03: MAC станции idle, кадров от станции нет,
через 5 с потеря связи по старению TX, assert fw 0x12aa). Цепочка: точка теряет RTS станции, станция после RTS без
DMG CTS закрывает TXOP, которого не получала, — CF-End (802.11-2020 10.23.2.10) — и ждёт событий MAC о нём без срока.

Здесь — по функции:
- tx_sta_wait_slot_and_tx / tx_sta_run_txop: RTS без DMG CTS — передача RTS не удалась (10.3.2.9): backoff, без
  закрытия TXOP (ни запроса итога, ни CF-End);
- uc_wait_txop_end: ожидание txop_event (конец TXOP у MAC) — не дольше лимита TXOP + запас, счётчик
  mac_mon_report.txop_end_tmo; tx_send_and_await_rx_frame после CF-End без txop_event возвращается."""
import pytest

CLK = 165
M32 = 0xffffffff
PATH = 2 * CLK
TXOP_LIMIT_CUR = 0x800478
MAC_MON = 0x801084
TXOP_END_TMO = MAC_MON + 0x6a
TXRX_STATE2 = 0x8005f8
TX_CTX0 = 0x802978
TX_CTX_CUR = 0x802978 + 0x78
LINK_STAT = 0x857e38
CTS_FAIL = LINK_STAT + 0x10
DTI_QSET_MODE = 0x8004f4
BF_CTRL = 0x8021b8

EVT_TXOP, EVT_BUSY2, EVT_TX_END = 1 << 7, 1 << 14, 1 << 15
EVT_BI1 = 1 << 4                                             # bi1_event: TBTT (упреждение ~8 мкс)


# ---- uc_wait_txop_end: ожидание конца TXOP со сроком ------------------------------------------------------------

def test_wait_txop_end_event(uc):
    uc.ext[42] = EVT_TXOP
    uc.w32(TXOP_LIMIT_CUR, 2000)
    n0 = uc.r8(TXOP_END_TMO)
    assert uc.call('uc_wait_txop_end') == 1
    assert uc.r8(TXOP_END_TMO) == n0


@pytest.mark.parametrize('limit_us', [2000, 300])
def test_wait_txop_end_bounded(uc, limit_us):
    """txop_event не приходит (у MAC нет TXOP): выход не раньше лимита TXOP (TXOP не бывает длиннее) и не позже
    лимит + 100 мкс + путь; mac_mon_report.txop_end_tmo + 1. Прежде — uc_spin_until_event без срока (SpinError)."""
    uc.ext[42] = 0
    uc.w32(TXOP_LIMIT_CUR, limit_us)
    n0 = uc.r8(TXOP_END_TMO)
    t0 = uc.t1()
    assert uc.call('uc_wait_txop_end', max_steps=4_000_000) == 0
    dt = uc.t1() - t0
    assert limit_us * CLK <= dt <= (limit_us + 100) * CLK + PATH, dt / CLK
    assert uc.r8(TXOP_END_TMO) == (n0 + 1) & 0xff


HOLDER_STUBS = {n: 0 for n in (
    'cf_end_send_frame', 'uc_sleep_until_event', 'gp0_timer_arm_usec', 'mac_set_rf_chain_state', 'uc_wait_one_event',
    'rx_mode_configure', 'mac_program_tx_vector')}


def test_cf_end_without_txop_event_returns(uc):
    """Держатель TXOP послал CF-End (Duration 18), ответа нет (тайм-аут GP0 — tx_await_rx_or_timeout = 1), txop_event
    MAC не поднимает: tx_send_and_await_rx_frame возвращается не позже лимита TXOP + запас, txop_end_tmo + 1.
    Прежде основной поток uc висел здесь навсегда (команды LMAC ещё обслуживались прерыванием, приём и TX — нет)."""
    uc.w32(TX_CTX0, 0)
    uc.w32(DTI_QSET_MODE, 0)
    uc.w32(TXOP_LIMIT_CUR, 300)
    uc.ext.update({40: 0xffff, 42: EVT_BUSY2 | EVT_TX_END})   # остаток TXOP большой; txop_event нет
    n0 = uc.r8(TXOP_END_TMO)
    uc.call('tx_send_and_await_rx_frame', TX_CTX0, 0, 0, 0, stub=dict(HOLDER_STUBS, tx_await_rx_or_timeout=1),
            max_steps=4_000_000)
    assert [n for n, _ in uc.calls].count('cf_end_send_frame') == 1
    assert uc.r8(TXOP_END_TMO) == (n0 + 1) & 0xff


# ---- Закрытие TXOP: ожидание конца передачи (событие 6) — только после своей передачи ----------------------------

MGMT_QID = 0x1a
TX_CTX_QID = TX_CTX0 + 4


def _closing_waits(uc, qid, rem, sp_gate=0):
    """tx_send_and_await_rx_frame(b = 1, c = 0) — закрытие TXOP после кадра очереди qid при остатке TXOP rem (r40).
    Возвращает (число ожиданий события 6, ушёл ли CF-End, был ли запрос итога)."""
    from fwsh_addr import A
    uc.w32(TX_CTX0, 0)
    uc.w32(TX_CTX_QID, qid)
    uc.w32(DTI_QSET_MODE, 0)
    uc.w32(TXOP_LIMIT_CUR, 300)
    uc.w8(A['fwsh_sp_gate'] + 0x0a, sp_gate)                 # fwsh_sp_gate.init_sp: своё SP
    uc.ext.update({40: rem, 42: EVT_BUSY2 | EVT_TX_END})
    k = len(uc.calls)
    uc.call('tx_send_and_await_rx_frame', TX_CTX0, 1, 0, 0,
            stub=dict(HOLDER_STUBS, tx_submit_frame=0, uc_spin_until_event=0, tx_await_rx_or_timeout=0,
                      uc_wait_txop_end=1, ese_dti_sp_src_end=0), max_steps=4_000_000)
    names = [n for n, _ in uc.calls[k:]]
    return names.count('uc_wait_one_event'), 'cf_end_send_frame' in names, 'tx_submit_frame' in names


@pytest.mark.parametrize('qid', [0, MGMT_QID])
@pytest.mark.parametrize('rem', [0, 0xffff])
def test_closing_waits_only_after_own_tx(uc, qid, rem):
    """Событие 6 — конец своей передачи; каждое ожидание — парой к кадру: QoS Null запроса итога (очереди данных) и
    CF-End (10.23.2.10, если остаток TXOP его вмещает). У очереди управления запроса итога нет (11.3.3):
    при малом остатке не передаётся ничего — и ждать нечего. Прежде хвост ждал всегда — ожидание без срока (стенд
    2026-11-20, u6000hold: assert 0x6000 застал станцию в нём после Probe Request без Ack)."""
    waits, cf_end, submit = _closing_waits(uc, qid, rem)
    assert submit == (qid != MGMT_QID)
    assert cf_end == (rem == 0xffff)
    assert waits == int(submit) + int(cf_end)


@pytest.mark.parametrize('qid', [0, MGMT_QID])
def test_closing_in_own_sp_waits_only_after_own_tx(uc, qid):
    """Своё SP (tx_sp_end_restore_rx): CF-End не шлём (усечение SP, 10.39.8.1); событие 6 ждём лишь после QoS Null
    запроса итога — у очереди управления его нет."""
    waits, cf_end, submit = _closing_waits(uc, qid, 0xffff, sp_gate=1)
    assert not cf_end
    assert waits == int(submit) == int(qid != MGMT_QID)


CLOSE_STUBS = {n: 0 for n in ('ese_dti_sp_src_end', 'mac_select_all_sectors_and_wait', 'mac_cmd_29000001',
                              'mac_program_tx_vector', 'tx_send_and_await_rx_frame')}
TX_PATH = ('mac_select_all_sectors_and_wait', 'mac_cmd_29000001')   # слот и проба CCA — до решения CCA (mac_cca_ok встроена)


TXOP_REM_END_TSF = 0x80048c                                  # uc/dccm.h txop_rem_end_tsf: конец остатка TXOP (TSF, мкс)
HW_MAC_TSF_LO = 0x886eb8                                     # include/hw.h: TSF, младшее слово, мкс
TSF0 = 0x12345678
FAR, NEAR, PASSED = 1000, 10, -100                          # срок от открытия, мкс от входа в закрытие


@pytest.mark.parametrize('qid,rem,evt,end_us,tx', [
    (MGMT_QID, 0xffff, EVT_TXOP, FAR, False),  # MAC уже закрыл TXOP (за TBTT)
    (MGMT_QID, 0xffff, EVT_BI1, FAR, False),   # TBTT настал (bi1_event; u6000f2)
    (MGMT_QID, 0xffff, 0, NEAR, False),  # до конца остатка от открытия 10 мкс < слот + CF-End, REMAINING уже перескочил (u6000f3)
    (MGMT_QID, 0xffff, 0, PASSED, False),  # срок прошёл — ожидание Ack кончилось за TBTT (u6000st)
    (MGMT_QID, 0xffff, 0, FAR, True),   # CF-End вмещается — слот, CCA, CF-End
    (0, 0, 0, PASSED, True),            # очередь данных — запрос итога (QoS Null в остаток плана)
])
def test_close_mgmt_without_tx_skips_tx_path(uc, qid, rem, evt, end_us, tx):
    """10.39.5: обмен, открытый до конца CBAP, за его конец не продолжают. Закрытие TXOP очереди управления, когда CF-End
    (10.23.2.10) не вмещается в остаток, TXOP у MAC уже кончился или настал TBTT, — без слота, пробы CCA и команд TX.
    Остаток — по сроку, запомненному при открытии (txop_rem_end_tsf), а не по REMAINING_TIME: у самой границы TBTT тот
    перескакивает на следующий BI, bi1_event у станции ещё не поднят (u6000f3). Прежде uc давал команды
    TX за TBTT (после тайм-аута Ack кадра у границы) — MAC_HW_ICR б16 → assert 0x6000 (стенд 2026-11-20, u6000st)."""
    uc.w32(TX_CTX0, 0)
    uc.w32(TX_CTX_QID, qid)
    uc.w32(TXRX_STATE2, 0)
    uc.w32(HW_MAC_TSF_LO, TSF0)
    uc.w32(TXOP_REM_END_TSF, TSF0 + end_us)
    uc.ext.update({40: rem, 42: evt})
    k = len(uc.calls)
    uc.call('tx_cca_check_and_send', TX_CTX0, 1, 1, 0, stub=CLOSE_STUBS)
    names = [n for n, _ in uc.calls[k:]]
    assert all((n in names) == tx for n in TX_PATH), names
    assert uc.r32(TXRX_STATE2) & (1 << 9)



@pytest.mark.parametrize('end_us,tx', [(FAR, True), (NEAR, False), (PASSED, False)])
def test_close_mgmt_deadline_across_tsf_wrap(uc, end_us, tx):
    """Срок закрытия через заворот TSF[31:0] (открытие перед заворотом, закрытие — после или наоборот): разность со
    знаком — решение то же, что без заворота."""
    now = 0xffffffff - 300
    uc.w32(TX_CTX0, 0)
    uc.w32(TX_CTX_QID, MGMT_QID)
    uc.w32(TXRX_STATE2, 0)
    uc.w32(HW_MAC_TSF_LO, now)
    uc.w32(TXOP_REM_END_TSF, (now + end_us) & 0xffffffff)
    uc.ext.update({40: 0xffff, 42: 0})
    k = len(uc.calls)
    uc.call('tx_cca_check_and_send', TX_CTX0, 1, 1, 0, stub=CLOSE_STUBS)
    names = [n for n, _ in uc.calls[k:]]
    assert all((n in names) == tx for n in TX_PATH), names


@pytest.mark.parametrize('tsf', [TSF0, 0xffffffff - 10])
def test_open_notes_txop_rem_end(uc, tsf):
    """Открытие TXOP запоминает конец остатка: TSF + REMAINING_TIME (мкс) — тот срок, по которому закрытие решает,
    вмещается ли CF-End (10.39.5). Не Timer1: COUNT1 обнуляет тик L1 каждые 10 мкс (стенд ul5, 2026-11-20)."""
    uc.w32(HW_MAC_TSF_LO, tsf)
    uc.call('txop_note_rem_end', 76)
    assert uc.r32(TXOP_REM_END_TSF) == (tsf + 76) & 0xffffffff

# ---- RTS без DMG CTS: backoff, без закрытия TXOP ---------------------------------------------------------------

RUN_TXOP_STUBS = {n: 0 for n in ('txop_pick_ctrl_code_by_peer', 'handle_bf_triggers', 'tx_cca_check_and_send',
                                 'mac_select_rf_module_cmd31', 'rx_flow_run', 'bf_metrics_reset_and_stamp',
                                 'rx_check_mode_2')}


@pytest.mark.parametrize('rx_mode_flags', [3, 1])
def test_rts_without_cts_no_cf_end(uc, rx_mode_flags):
    """802.11-2020 10.3.2.9: RTS ушёл, DMG CTS за CTSTimeout нет — передача RTS не удалась, backoff (окно слотов
    растёт — tx_pick_slot_for_peer(1), cts_fail + 1); TXOP не получен — 10.23.2.10: «A non-AP STA that is not the TXOP
    holder shall not transmit a CF-End frame». tx_sta_run_txop не закрывает TXOP: ни tx_cca_check_and_send (запрос
    итога передачи + CF-End), ни ожиданий конца TXOP. Прежде (rx_mode_flags б1 = 1 — по умолчанию) — закрывал."""
    uc.w32(TX_CTX0 + 0, 0)                                   # sta 0
    uc.w32(TX_CTX0 + 4, 0)                                   # qid 0
    uc.w32(TX_CTX_CUR, TX_CTX0)
    uc.w32(0x801424, rx_mode_flags)                          # rx_mode_flags
    uc.w8(CTS_FAIL, 0)
    uc.w8(BF_CTRL + 8, 0xff)                                 # порог cts_fail → BF (ctrl_code_tx) — не достигнут
    uc.w8(BF_CTRL + 0xa, 0xff)
    uc.w32(TXRX_STATE2, 0x104)                               # б8 ждём ответ, б2 — открыли RTS
    uc.ext[42] = 0
    uc.call('tx_sta_run_txop', TX_CTX0, stub=dict(RUN_TXOP_STUBS, txop_initiator_open_txop_flow=1,
                                                   sxd_hal_wait_slot2_busy2=0))
    names = [n for n, _ in uc.calls]
    assert 'tx_cca_check_and_send' not in names, names
    assert uc.r8(CTS_FAIL) == 1
