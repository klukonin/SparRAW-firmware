# SPDX-License-Identifier: AGPL-3.0-or-later
"""Ранний путь Ack/BlockAck (uc/rx.c rx_fast_resp_early): отчёт о PPDU (r42 б16) приходит после входа в
rx_flow_handle_frame — у PPDU с MPDU длиннее ~200 Б через 1,9 мкс после конца приёма (стенд 2026-11-15, метки UC_EVM).
Ответ (Ack 10.3.2.11, BlockAck 10.25.3/10.25.6) готовится по предварительному отчёту, решение — по окончательному:

  - отчёт пришёл — запрос MTP (0x1b001111) через несколько команд, а не через проверки и пролог прежнего пути;
  - поля окончательного отчёта разошлись с предварительными — ответ по окончательному (прежний путь), запрос один;
  - окончательный отчёт не требует ответа — запроса MTP нет.
"""
import pytest

from test_uc_beacon_tx import MAC_CMD_LOG, clean_shadows
from test_uc_deadlines import Meter, sifs_frame

EARLY_FNS = ('rx_flow_handle_frame', 'rx_fast_resp_early')
REQ = 0x1b001111
RESP = 0x37000020


def late_report(uc, k, pre=None, fin=None):
    """r42 без б16 (отчёта нет) на первых k чтениях в rx_flow_handle_frame / rx_fast_resp_early, затем с ним; порты
    отчёта {номер: значение}: pre — до отчёта, fin — после (по умолчанию — как задал sifs_frame)."""
    st = {'n': 0, 'rep': False}
    base = uc.ext[42]
    pre, fin = pre or {}, fin or {}

    def r42(n, kk):
        v = base(n, kk) if callable(base) else base
        if not st['rep'] and uc.where(uc.cpu.pc).startswith(EARLY_FNS):
            st['n'] += 1
            if st['n'] <= k:
                return v & ~(1 << 16)
            st['rep'] = True
        return v

    def port(p, dflt):
        return lambda n, kk: fin.get(p, dflt) if st['rep'] else pre.get(p, dflt)
    uc.ext[42] = r42
    for p in set(pre) | set(fin):
        uc.ext[p] = port(p, uc.ext[p])
    return st


def run(uc, kind, k=6, pre=None, fin=None):
    uc.cpu.regs[25] = MAC_CMD_LOG
    clean_shadows(uc)
    sifs_frame(uc, kind)
    st = late_report(uc, k, pre, fin)
    m = Meter(uc, stop=lambda c: c == RESP)
    uc.call('rx_flow_run', stub={'uc_assert': 0}, max_steps=200000)
    return m, st


def mtp_words(uc):
    c = uc.mac_cmds
    return [(c[i + 1], c[i + 2]) for i in range(len(c) - 2) if c[i] == REQ]


@pytest.mark.parametrize('kind', ['ba', 'ack'])
def test_early_request_soon_after_report(uc, kind):
    """Отчёт пришёл позже входа: ответ есть, запрос MTP — один, вид в 0x16 по отчёту (BlockAck — 1, Ack — 0), от
    чтения r42 с б16 до запроса — не больше 120 тактов модели (BlockAck ~107, Ack с ожиданием BAP ~105; прежний путь —
    проверки, пролог, скорость, сектор, mtp_service_dispatch: стенд 0,85 мкс против 0,39 у раннего)."""
    m, st = run(uc, kind)
    assert st['rep'], 'ранний путь не ждал отчёта'
    assert 'rx_fast_resp_early' in {uc.where(pc).split('+')[0] for pc in m.pc.values()}, 'ранний путь не взят'
    w = mtp_words(uc)
    assert len(w) == 1, [hex(c) for c in uc.mac_cmds]
    assert (w[0][0] >> 8) & 7 == (1 if kind == 'ba' else 0) and w[0][0] >> 24 == 0x16
    a = m.cmd_idx(lambda c: c == REQ)
    t = m.trigger(42, 1 << 16, a)
    clk, n = m.span(t, a)
    print('отчёт → запрос MTP: %d тактов, %d инструкций' % (clk, n))
    assert clk <= 120, clk
    assert m.cmd_idx(lambda c: c == RESP) is not None


def test_early_fields_changed_answer_by_final(uc):
    """Предварительный отчёт — одиночный QoS Data (Ack), окончательный — A-MPDU: ответ BlockAck (вид 1) по
    окончательному, запрос MTP один."""
    sta = 0x20000800 | (7 << 8)
    m, st = run(uc, 'ack', pre={38: sta}, fin={38: sta | 1 << 25})
    w = mtp_words(uc)
    assert len(w) == 1, [hex(c) for c in uc.mac_cmds]
    assert (w[0][0] >> 8) & 7 == 1


def test_early_r36_empty_amp(uc):
    """Предварительный r36 ещё пуст (стенд: до отчёта только б3 reservation_detected), r38 — A-MPDU от известной
    станции: ранний путь берёт кадр как QoS Data, qid — из окончательного r36; ответ BlockAck, qid в 0x17 [20:16]."""
    sta = 0x20000800 | (7 << 8) | 1 << 25
    m, st = run(uc, 'ba', pre={36: 1 << 3, 38: sta}, fin={36: 1 << 1 | 5 << 19, 38: sta})
    assert 'rx_fast_resp_early' in {uc.where(pc).split('+')[0] for pc in m.pc.values()}, 'ранний путь не взят'
    w = mtp_words(uc)
    assert len(w) == 1 and (w[0][0] >> 8) & 7 == 1 and (w[0][1] >> 16) & 0x1f == 5, [hex(x) for x in w[0]]


def test_early_type_unknown_predicts_amp(uc):
    """Стенд: у ~40 % ответов BlockAck к входу в r36 только б3, в r38 — адрес и FCS без MPDU_AGG; QoS Data и A-MPDU —
    вместе с отчётом. Ранний путь предсказывает A-MPDU: ответ BlockAck (вид 1), запрос один, qid — из окончательного."""
    sta = 0x20000800 | (7 << 8)
    m, st = run(uc, 'ba', pre={36: 1 << 3, 38: sta}, fin={36: 1 << 1 | 3 << 19, 38: sta | 1 << 25})
    assert 'rx_fast_resp_early' in {uc.where(pc).split('+')[0] for pc in m.pc.values()}, 'ранний путь не взят'
    w = mtp_words(uc)
    assert len(w) == 1 and (w[0][0] >> 8) & 7 == 1 and (w[0][1] >> 16) & 0x1f == 3, [hex(x) for x in w[0]]


def test_early_type_unknown_single_mpdu_ack(uc):
    """Предсказание A-MPDU не сбылось — окончательный отчёт: одиночный QoS Data (политика Normal Ack): ответ Ack (вид 0)
    прежним путём, запрос один."""
    sta = 0x20000800 | (7 << 8)
    m, st = run(uc, 'ack', pre={36: 1 << 3, 38: sta}, fin={38: sta})
    w = mtp_words(uc)
    assert len(w) == 1 and (w[0][0] >> 8) & 7 == 0, [hex(c) for c in uc.mac_cmds]


def test_early_known_type_not_qos_no_early(uc):
    """Тип в r36 уже известен и это не QoS Data (кадр управления): ранний путь не берётся."""
    sta = 0x20000800 | (7 << 8)
    m, st = run(uc, 'ba', k=1, pre={36: 1 << 2 | 1 << 3, 38: sta})   # отчёт — со второго чтения r42 (прежнее ожидание вне rx_flow_handle_frame)
    assert 'rx_fast_resp_early' not in {uc.where(pc).split('+')[0] for pc in m.pc.values()}


def test_early_final_no_response(uc):
    """Окончательный отчёт без fcs_ok_partial (ни один MPDU не принят): запроса MTP нет."""
    sta = 0x20000800 | (7 << 8) | 1 << 25
    m, st = run(uc, 'ba', pre={38: sta}, fin={38: sta & ~(1 << 29)})
    assert not mtp_words(uc), [hex(c) for c in uc.mac_cmds]


def test_early_mcs_from_final(uc):
    """MCS принятого кадра (r38 [24:20]) до отчёта 0 (стенд), в окончательном — 8: ранний путь не отказывается, скорость
    ответа в 0x17 — по окончательному (rx_resp_rate: MCS ≥ 2 → явный, не выше 4)."""
    sta = 0x20000800 | (7 << 8)
    m, st = run(uc, 'ba', pre={36: 1 << 3, 38: sta}, fin={36: 1 << 1, 38: sta | 1 << 25 | 8 << 20})
    assert 'rx_fast_resp_early' in {uc.where(pc).split('+')[0] for pc in m.pc.values()}, 'ранний путь не взят'
    w = mtp_words(uc)
    assert len(w) == 1 and (w[0][0] >> 8) & 7 == 1 and w[0][1] & 0x1f03 == (4 << 8 | 3), [hex(x) for x in w[0]]


def req_fn(uc, m):
    a = m.cmd_idx(lambda c: c == REQ)
    return a is not None and uc.where(m.pc[a]).split('+')[0]


@pytest.mark.parametrize('qnull', [0, 1])
def test_early_pred_fail_single_ack_here(uc, qnull):
    """Тип к входу неизвестен (r36 — только б3), окончательный отчёт: одиночный QoS Data / QoS Null (б17) той же станции,
    Normal Ack: не сбылось только предсказание A-MPDU — Ack (вид 0) раннего пути, запрос MTP выдан из него же (не
    прежним путём через mtp_service_dispatch), запрос один."""
    sta = 0x20000800 | (7 << 8)
    m, st = run(uc, 'ack', pre={36: 1 << 3, 38: sta}, fin={36: 1 << 1 | qnull << 17, 38: sta})
    w = mtp_words(uc)
    assert len(w) == 1 and (w[0][0] >> 8) & 7 == 0, [hex(c) for c in uc.mac_cmds]
    assert req_fn(uc, m) == 'rx_fast_resp_early', req_fn(uc, m)
    assert m.cmd_idx(lambda c: c == RESP) is not None


def test_early_pred_fail_other_station_fallback(uc):
    """Предсказание A-MPDU не сбылось, и станция в окончательном отчёте другая: ранний путь отказывается (ответ — прежним
    путём по окончательному), запрос один."""
    pre, fin = 0x20000800 | (7 << 8), 0x20000800 | (6 << 8)
    m, st = run(uc, 'ack', pre={36: 1 << 3, 38: pre}, fin={36: 1 << 1, 38: fin})
    assert req_fn(uc, m) != 'rx_fast_resp_early'
    assert len(mtp_words(uc)) <= 1


@pytest.mark.parametrize('kind', ['ba', 'ack'])
@pytest.mark.parametrize('k', [0, 6], ids=['fast', 'early'])
def test_no_rf_tx_before_request(uc, kind, k):
    """RF «передача» (HW_ABIF_DVS_RF_CTRL) — только после 0x37000020 (rx_frame_tx_resp_after_req), не до запроса MTP, на
    обоих быстрых путях (k = 0: отчёт уже есть — rx_fast_resp; 6 — rx_fast_resp_early): стенд 2026-11-15, ранняя
    запись стоила BlockAck 0,14 мкс."""
    m, st = run(uc, kind, k=k)
    a = m.cmd_idx(lambda c: c == REQ)
    assert a is not None
    w = [j for j, e in m.events() if e[:3] == ('mmio', 'w', 0x889488)]
    assert not [j for j in w if j < a], 'запись RF до запроса MTP'
    assert req_fn(uc, m) == ('rx_fast_resp_early' if k else 'mtp_service_dispatch'), req_fn(uc, m)
