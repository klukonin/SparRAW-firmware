# SPDX-License-Identifier: AGPL-3.0-or-later
"""Живучесть ожиданий uc при молчащем пире: каждое ожидание ответа пира / эфира обязано кончиться по сроку,
который uc сам взвёл на том же пути (GP-таймер, Timer1), не позже границы из 802.11-2020. Вечное ожидание
(SpinError) или выход позже границы — ошибка живучести: uc не обслуживает приём (RTS, BRP, данные) — шторм CTS,
провал BRP, потеря связи (стенд 2026-10-28, вход в BTI с пути приёма — test_uc_bti_rx_entry.py).

Модель GP0..GP2 (r54 б6..8, docs/MAC-COMMANDS.md §7.6): 0x4f+i — длительность, такты 165 МГц; 0x52+i — пуск
(младший байт ≠ 0) или стоп (= 0); 0x49 — квитирование битов r54. Приближения: пуск по аппаратному триггеру
(…0408 — конец своей передачи, …090c — конец GP2 и т. п.) считается в момент команды (передача в тестах
заглушена); квитирование бита таймера, взведённого с триггером, перезапускает его — следующая передача
(заглушка) кончается сразу. Пока какой-то GP идёт, опрос r42/r54 считается ограниченным сроком (как опрос
Timer1 в ucemu): счётчик SpinError сбрасывается. Ожидание без взведённого таймера по-прежнему ловится SpinError.

Границы (такты 165 МГц; 802.11-2020 Table 20-30: aSIFSTime 3 мкс, aSlotTime 5 мкс, aSBIFSTime 1 мкс,
aRxPHYStartDelay control 10 мкс; aBRPIFS 40 мкс — Table 20-30/Annex, BRPIFS = aBRPIFS + 10 % — 10.3.2.3.9)."""
import pytest

M32 = 0xffffffff
CLK = 165
SIFS = 3 * CLK
SLOT = 5 * CLK
SBIFS = 1 * CLK
PIFS = SIFS + SLOT                                     # 10.3.2.3.4
MBIFS = 3 * SIFS                                       # 10.3.2.3.10
RX_START_CTRL = 10 * CLK                               # aRxPHYStartDelay, DMG control mode
RESP_TIMEOUT = SIFS + SLOT + RX_START_CTRL             # AckTimeout/CTSTimeout (10.3.2.11, 10.3.2.9): 18 мкс
BRPIFS = 44 * CLK                                      # aBRPIFS 40 мкс + 10 % (10.3.2.3.9)
TXTIME_SSW = 2460                                      # uc/ifs.h DMG_CTRL_TXTIME_CLK(26): 14,909 мкс (20.4.3.3)
TXTIME_SSW_FB = 3012                                   # SSW-Feedback 28 Б: 18,255 мкс
TXTIME_SSW_ACK = 3012                                  # SSW-Ack 28 Б
BF_RETRY_LIMIT = 8                                     # dot11BFRetryLimit (uc/ifs.h DOT11_BF_RETRY_LIMIT)
PATH = 2 * CLK                                         # запас на путь uc от события до возврата (≤ 2 мкс)

SLS_RX_FLAGS = 0x8021e0
RSS_WAIT_CLK = 0x8020c4                                # u32[9] по станциям; [10] = 0x8020ec — rss_wait_clk_x10
RSS_WAIT_CLK_X10 = 0x8020ec
BRP_INIT_REQ_NORESP = 0x801e94 + 0x4e
HW_MAC_USEC_TO_TBTT = 0x886ec0


class GP:
    """Модель GP0..GP2 поверх журнала команд MAC (запись r32) — см. docstring модуля."""

    def __init__(self, uc):
        self.uc = uc
        self.val = [0, 0, 0]
        self.start = [None, None, None]
        self.mode = [0, 0, 0]
        self.latched = 0
        self.arms = [[], [], []]                       # (t, длительность) каждого пуска
        cpu = uc.cpu
        orig = cpu.write_reg

        def wr(n, v):
            if n == 32:
                self.cmd(v & M32)
            orig(n, v)
        cpu.write_reg = wr
        uc.ext[54] = self.r54

    def cmd(self, v):
        t, op, arg = self.uc.t1(), v >> 24, v & 0xffffff
        if 0x4f <= op <= 0x51:
            self.val[op - 0x4f] = arg
        elif 0x52 <= op <= 0x54:
            i = op - 0x52
            if arg & 0xff:
                self.start[i], self.mode[i] = t, arg
                self.arms[i].append((t, self.val[i]))
            else:
                self.start[i], self.mode[i] = None, 0
        elif op == 0x49:
            for i in range(3):
                if arg & (1 << (6 + i)):
                    self.latched &= ~(1 << (6 + i))
                    if self.start[i] is None and self.mode[i] and (self.mode[i] & 0xff) != 0x0b:
                        self.start[i] = t                  # триггер — конец следующей (заглушенной) передачи
                        self.arms[i].append((t, self.val[i]))

    def r54(self, n, k):
        t = self.uc.t1()
        for i in range(3):
            if self.start[i] is not None and t - self.start[i] >= self.val[i]:
                self.latched |= 1 << (6 + i)
                self.start[i] = None
        if any(s is not None for s in self.start):
            self.uc._spin = {}                         # срок взведён — ожидание ограничено
        return self.latched


# ---------------------------------------------------------------------------------------------------------------
# Ответ на собственный кадр: CTS на RTS, Ack на данные — keep-alive (internal_tx_flow_sm2), TXOP (tx_send_and_await_rx_frame)

def test_cts_wait_silent_peer_ends_by_cts_timeout(uc):
    """RTS ушёл, CTS нет: itx_wait_cts_b выходит по GP0 (gp0_arm_usec_b(0x12) в internal_tx_flow_sm2) не позже
    CTSTimeout = aSIFSTime + aSlotTime + aRxPHYStartDelay = 18 мкс (10.3.2.9) от конца RTS."""
    gp = GP(uc)
    uc.ext[42] = 0
    t0 = uc.t1()
    uc.call('gp0_arm_usec_b', 0x12)
    r = uc.call('itx_wait_cts_b')
    assert r == 0
    assert uc.t1() - t0 <= RESP_TIMEOUT + PATH, 'ждал %.1f мкс' % ((uc.t1() - t0) / CLK)
    assert len(gp.arms[0]) == 1


def test_ack_wait_silent_peer_ends_by_ack_timeout(uc):
    """Данные keep-alive ушли, Ack нет: itx_wait_ack выходит по GP0 (gp0_arm_usec_b(0xc)) не позже AckTimeout
    = 18 мкс (10.3.2.11)."""
    GP(uc)
    uc.ext[42] = 0
    t0 = uc.t1()
    uc.call('gp0_arm_usec_b', 0xc)
    assert uc.call('itx_wait_ack') == 0
    assert uc.t1() - t0 <= RESP_TIMEOUT + PATH


def test_txop_response_wait_silent_peer_times_out(uc):
    """tx_await_rx_or_timeout (ответ на кадр TXOP, tx_send_and_await_rx_frame: gp0_arm_usec_b(0x12) при
    dti_qset_mode 0) — выход по GP0, возврат 1 (тайм-аут), не позже AckTimeout (10.3.2.11)."""
    GP(uc)
    uc.ext[42] = 0
    t0 = uc.t1()
    uc.call('gp0_arm_usec_b', 0x12)
    assert uc.call('tx_await_rx_or_timeout') == 1
    assert uc.t1() - t0 <= RESP_TIMEOUT + PATH


# ---------------------------------------------------------------------------------------------------------------
# BRP (10.42.6.4): ответ BRP-кадром — не позже BRPIFS (10.3.2.3.9); без него инициатор повторяет запрос

def test_brp_setup_silent_responder_gives_up(uc):
    """brp_init_exchange_request: ответчик молчит — три запроса (заглушка передачи), каждый ждёт GP0 (0x203a,
    пуск по концу передачи), затем отказ (init_req_noresp + 1). Срок одной попытки не больше BRPIFS +
    aRxPHYStartDelay (ответ, начатый в пределах BRPIFS, ещё не обнаружен PHY раньше — 10.3.2.3.9, 129102)."""
    gp = GP(uc)
    uc.ext[42] = 0
    uc.w16(BRP_INIT_REQ_NORESP, 0)
    t0 = uc.t1()
    r = uc.call('brp_init_exchange_request', stub={'brp_init_tx_request': 0})
    assert r == 0
    assert [c[0] for c in uc.calls].count('brp_init_tx_request') == 3
    assert uc.r16(BRP_INIT_REQ_NORESP) == 1
    per = [v for _, v in gp.arms[0]]
    assert per and all(0 < v <= BRPIFS + RX_START_CTRL for v in per), per
    assert uc.t1() - t0 <= 3 * (BRPIFS + RX_START_CTRL) + 3 * PATH


# ---------------------------------------------------------------------------------------------------------------
# SLS в DTI (10.42.2): RSS через MBIFS после ISS, SSW-Feedback через MBIFS после RSS, SSW-Ack через MBIFS

def test_txss_initiator_silent_responder_rss_wait_ends(uc):
    """txss_init_wait_rss: RSS не началась — выход по GP0 = rss_wait_clk[sta] (0x29528 после подключения
    станции, ucode_cmd_0x0e/0x18), статус 2. Граница: MBIFS + развёртка из 64 SSW через SBIFS (10.42.2.3,
    10.3.2.3.8) = MBIFS + 64·(TXTIME(SSW) + SBIFS)."""
    GP(uc)
    uc.ext[42] = 0
    uc.w32(SLS_RX_FLAGS, 0)
    rss = 0x29528
    t0 = uc.t1()
    r = uc.call('txss_init_wait_rss', 0, rss,
                stub={'mac_evt_enable_bit_sync_b': 0, 'bf_store_flow_status': 0, 'rx_flow_run': 0})
    assert r == 0
    st = [c[1][1] for c in uc.calls if c[0] == 'bf_store_flow_status']
    assert st == [2]
    assert uc.t1() - t0 <= MBIFS + 64 * (TXTIME_SSW + SBIFS) + PATH


def test_txss_initiator_silent_responder_fdbk_retries_bounded(uc):
    """txss_init_send_fdbk_wait_ack: SSW-Ack нет — повтор Feedback PIFS после ожидаемого конца Ack, не больше
    dot11BFRetryLimit повторов (10.42.6.2, 10.42.2.2); каждое ожидание — GP1. Выход не позже
    (1 + dot11BFRetryLimit)·(MBIFS + TXTIME(SSW-Ack) + PIFS) от первого Feedback (передача заглушена)."""
    gp = GP(uc)
    uc.ext[42] = 0
    uc.w32(HW_MAC_USEC_TO_TBTT, 0x3ffffff)                 # до TBTT далеко: повторы помещаются
    t0 = uc.t1()
    uc.call('txss_init_send_fdbk_wait_ack', 0,
            stub={'txss_init_send_ssw_fdbk': 0, 'mac_evt_enable_bit_sync': 0, 'mac_evt_enable_bit_sync_b': 0,
                  'mac_mode_switch_core_and_rf': 0, 'bf_store_flow_status': 0, 'rx_flow_run': 0,
                  'ese_dti_us_to_window_end': 0xffffff})
    fb = [c for c in uc.calls if c[0] == 'txss_init_send_ssw_fdbk']
    assert len(fb) == 1 + BF_RETRY_LIMIT
    assert len(gp.arms[1]) == 1 + BF_RETRY_LIMIT
    assert uc.t1() - t0 <= (1 + BF_RETRY_LIMIT) * (MBIFS + TXTIME_SSW_ACK + PIFS + PATH)


@pytest.mark.xfail(strict=True, reason=(
    'txss_resp_wait_iss_end (uc/tail.c) взводит GP0 ожидания SSW-Feedback (txss_resp_wait_fdbk: цикл '
    'sxd_hal_wait_slot2_busy2 + r54.6 без иного выхода) длительностью rss_wait_clk_x10 = rss_wait_clk[10] '
    '(0x8020ec, за концом таблицы из 9 станций) — слово никто не пишет, в образе 0: срок 0 тактов. По '
    '10.42.2.2/10.42.2.4 Feedback начинается через MBIFS после RSS и обнаруживается через aRxPHYStartDelay; '
    'GP с длительностью 0 — либо нет ожидания Feedback вовсе, либо (если 0 не срабатывает) ответчик ждёт '
    'Feedback вечно при молчащем инициаторе. Поведение GP при 0 не установлено.'))
def test_txss_responder_fdbk_wait_deadline_armed(uc):
    """Ответчик SLS после своей RSS ждёт SSW-Feedback: срок ожидания (GP0, 0x4f перед 0x52000408) должен
    покрывать начало Feedback (MBIFS после RSS, 10.42.2.2) + обнаружение (aRxPHYStartDelay) и быть конечным:
    не дольше всех повторов инициатора ((1 + dot11BFRetryLimit) циклов Feedback → MBIFS → Ack → PIFS)."""
    uc.ext[54] = 1                                          # txss_end_ind: ISS кончилась — путь к RSS
    uc.ext[42] = 0
    uc.w32(SLS_RX_FLAGS, 0)
    uc.call('txss_resp_wait_iss_end', 0, 0x29528,
            stub={'mac_mode_switch_core_and_rf': 0, 'txss_program_tx_frame': 1, 'txss_rank_best_sector': 0})
    cmds = uc.mac_cmds
    i = cmds.index(0x52000408)
    assert cmds[i - 1] >> 24 == 0x4f
    v = cmds[i - 1] & 0xffffff
    hi = (1 + BF_RETRY_LIMIT) * (TXTIME_SSW_FB + MBIFS + TXTIME_SSW_ACK + PIFS)
    assert MBIFS + RX_START_CTRL <= v <= hi, 'GP0 ожидания Feedback = %d тактов' % v


def test_txss_responder_fdbk_wait_bounded_by_its_gp0(uc):
    """txss_resp_wait_fdbk при молчащем инициаторе выходит только по r54.6 (GP0 из txss_resp_wait_iss_end):
    с взведённым сроком (здесь — граница ожидания первого Feedback MBIFS + aRxPHYStartDelay + TXTIME) цикл
    кончается со статусом 0xa не позже срока + n слотов ожидания занятости."""
    gp = GP(uc)
    uc.ext[42] = 0
    uc.w32(SLS_RX_FLAGS, 0)
    uc.w16(0x800508, 2)                                     # resp_wait_slots (как задаёт fw)
    dl = MBIFS + RX_START_CTRL + TXTIME_SSW_FB
    uc.call('gp_timer_arm', 0, dl, 0, 0)
    t0 = uc.t1()
    # slot2_event (r42.8) — аппаратный отсчёт слотов: модель — событие на каждом чтении после aSlotTime
    last = {'t': t0}

    def r42(n, k):
        t = uc.t1()
        if t - last['t'] >= SLOT:
            last['t'] = t
            return 1 << 8
        return 0
    uc.ext[42] = r42
    uc.call('txss_resp_wait_fdbk', 0, stub={'bf_store_flow_status': 0, 'rx_flow_run': 0,
                                            'mac_evt_enable_bit_sync_b': 0})
    st = [c[1][1] for c in uc.calls if c[0] == 'bf_store_flow_status']
    assert st == [0xa]
    assert uc.t1() - t0 <= dl + 2 * SLOT + PATH
    assert gp.latched & 0x40


# ---------------------------------------------------------------------------------------------------------------
# A-BFT AP (10.42.5.2): SSW ответчиков в слоте; конец слота — GP1

def test_abft_ap_slot_silent_ends_at_slot_boundary(uc):
    """mac_mode_program_c (AP в A-BFT): в слоте ни одного SSW — выход по GP1 (граница слота) без передачи
    Feedback. Срок — длительность слота aSSSlotTime (10.42.5.2), здесь — взведённая длительность GP1."""
    GP(uc)
    uc.ext[42] = 0
    slot = 0x1000
    uc.call('gp_timer_arm', 1, slot, 0, 0)
    t0 = uc.t1()
    uc.call('mac_mode_program_c', 0x803000, stub={'direct_tx_step': 0, 'uc_evt_build_and_post_report': 0})
    assert not [c for c in uc.calls if c[0] == 'direct_tx_step']
    assert uc.t1() - t0 <= slot + PATH
