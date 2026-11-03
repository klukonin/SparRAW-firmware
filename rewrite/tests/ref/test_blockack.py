# SPDX-License-Identifier: AGPL-3.0-or-later
"""Эталон Block Ack (HT-immediate, DMG): ожидания — из текста 802.11-2020 (10.25, 9.3.1.7/9.3.1.8, 9.4.1.13,
9.6.4, табл. 10-6), включая границы окна, wraparound 4095→0 и нарушения, которые модель должна отвергать."""
import random
from fractions import Fraction as Fr

import pytest

from . import blockack as B

IMPL = B.NORMAL_OR_IMPLICIT


# ---- 10.25.1: арифметика по модулю 4096 ----
def test_sn_wraparound():
    assert B.sn_add(4095, 1) == 0
    assert B.sn_add(0, -1) == 4095
    assert B.sn_off(0, 4095) == 1


@pytest.mark.parametrize('sn,region', [
    (10, B.IN), (73, B.IN),                       # WinStart ≤ SN ≤ WinEnd
    (74, B.AHEAD), (10 + 2047, B.AHEAD),          # WinEnd < SN < WinStart + 2^11
    (10 + 2048, B.BEHIND), (9, B.BEHIND),         # WinStart + 2^11 ≤ SN < WinStart
])
def test_sn_region_bounds(sn, region):
    assert B.sn_region(sn, 10, 73) == region


def test_sn_region_wrap():
    start, end = 4090, B.sn_add(4090, 63)          # окно 4090 … 57 через 4095→0
    assert end == 57
    assert B.sn_region(0, start, end) == B.IN
    assert B.sn_region(57, start, end) == B.IN
    assert B.sn_region(58, start, end) == B.AHEAD
    assert B.sn_region(4089, start, end) == B.BEHIND


# ---- кодирование полей по рисункам ----
def test_ba_params_bits_fig_9_96():
    assert B.encode_ba_params(B.BAParams(1, 0, 0, 0)) == bytes([0x01, 0x00])      # B0 A-MSDU Supported
    assert B.encode_ba_params(B.BAParams(0, 1, 0, 0)) == bytes([0x02, 0x00])      # B1 Block Ack Policy
    assert B.encode_ba_params(B.BAParams(0, 0, 15, 0)) == bytes([0x3C, 0x00])     # B2–B5 TID
    assert B.encode_ba_params(B.BAParams(0, 0, 0, 1023)) == bytes([0xC0, 0xFF])   # B6–B15 Buffer Size
    assert B.encode_ba_params(B.BAParams(0, 0, 0, 64)) == bytes([0x00, 0x10])
    p = B.BAParams(1, 1, 5, 64)
    assert B.encode_ba_params(p) == bytes([0x17, 0x10])
    assert B.parse_ba_params(B.encode_ba_params(p)) == p
    with pytest.raises(ValueError):
        B.encode_ba_params(B.BAParams(0, 1, 16, 1))
    with pytest.raises(ValueError):
        B.encode_ba_params(B.BAParams(0, 1, 0, 1024))                            # 10 бит


def test_delba_params_bits_fig_9_99():
    assert B.encode_delba_params(1, 0) == bytes([0x00, 0x08])                     # B11 Initiator
    assert B.encode_delba_params(0, 7) == bytes([0x00, 0x70])                     # B12–B15 TID
    assert B.parse_delba_params(bytes([0x00, 0xF8])) == (1, 15)
    assert B.parse_delba_params(bytes([0xFF, 0x07])) == (0, 0)                    # B0–B10 Reserved


def test_ssc_bits_fig_9_37():
    assert B.encode_ssc(1) == bytes([0x10, 0x00])                                 # SSN с B4
    assert B.encode_ssc(4095) == bytes([0xF0, 0xFF])
    assert B.parse_ssc(bytes([0xF3, 0xFF])) == (4095, 3)
    with pytest.raises(ValueError):
        B.encode_ssc(4096)


def test_ba_control_bits_fig_9_42():
    assert B.encode_ba_control(1, 0, 0, 0) == bytes([0x02, 0x00])                 # B1 Multi-TID
    assert B.encode_ba_control(0, 1, 0, 0) == bytes([0x04, 0x00])                 # B2 Compressed Bitmap
    assert B.encode_ba_control(0, 0, 3, 0) == bytes([0x18, 0x00])                 # B3–B4 GCR Mode
    assert B.encode_ba_control(0, 0, 0, 15) == bytes([0x00, 0xF0])                # B12–B15 TID_INFO
    assert B.parse_ba_control(B.encode_ba_control(0, 1, 0, 3)) == (0, 1, 0, 3)
    assert B.parse_ba_control(bytes([0xE1, 0x0F])) == (0, 0, 0, 0)                # B0, B5–B11 Reserved


def test_ba_variants_table_9_28():
    assert B.ba_variant(0, 1, 0) == 'compressed'
    assert B.ba_variant(1, 0, 0) == 'extended_compressed'
    assert B.ba_variant(1, 1, 0) == 'multi_tid'
    assert B.ba_variant(0, 1, 0b10) == 'glk_gcr'        # «01»: B3 = 0, B4 = 1
    assert B.ba_variant(0, 1, 0b01) == 'gcr'            # «10»: B3 = 1, B4 = 0
    for mt, c, g in [(0, 0, 0), (0, 0, 3), (0, 1, 3), (1, 0, 1), (1, 1, 2)]:
        with pytest.raises(ValueError):
            B.ba_variant(mt, c, g)


def test_dmg_ba_variant_10_25_5():
    assert B.ba_variant(*B.dmg_ba_variant(1), 0) == 'compressed'
    assert B.ba_variant(*B.dmg_ba_variant(0), 0) == 'extended_compressed'


def test_ba_info_fig_9_43_9_45():
    b = B.encode_ba_info(100, 1)
    assert b == bytes([0x40, 0x06, 0x01] + [0] * 7)                               # бит 0 карты = B0 1-го октета
    assert len(b) == 10
    assert B.encode_ba_info(0, 1 << 63)[-1] == 0x80                               # бит 63 — старший последнего
    e = B.encode_ba_info(100, 0xA5, rbufcap=7)
    assert len(e) == 11 and e[-1] == 7
    assert B.parse_ba_info(e, extended=True) == (100, 0xA5, 7)
    with pytest.raises(ValueError):
        B.parse_ba_info(bytes([0x41, 0x06]) + bytes(8))                           # Fragment Number ≠ 0
    assert B.bitmap_sns(4095, 0b11) == [4095, 0]


def test_addba_frames_tables_9_360_9_361_9_362():
    req = B.AddbaReq(7, B.BAParams(0, 1, 0, 64), 0, 4095)
    raw = B.encode_addba_req(req)
    assert raw[:3] == bytes([3, 0, 7]) and len(raw) == 9
    assert raw[7:9] == bytes([0xF0, 0xFF])
    assert B.parse_addba_req(raw) == req
    with pytest.raises(ValueError):
        B.encode_addba_req(req._replace(token=0))                                 # «nonzero value»
    resp = B.make_addba_response(req, buffer_size=32)
    raw = B.encode_addba_resp(resp)
    assert raw[:5] == bytes([3, 1, 7, 0, 0]) and len(raw) == 9
    assert B.parse_addba_resp(raw) == resp
    d = B.encode_delba(1, 5, B.REASON_TIMEOUT)
    assert d == bytes([3, 2, 0x00, 0x58, 39, 0])
    assert B.parse_delba(d) == (1, 5, 39)


# ---- 10.25.2: согласование ----
def test_agreement_requires_ht_dmg_s1g():
    assert B.agreement_allowed(True, True)
    assert not B.agreement_allowed(True, False)


def test_addba_response_rules():
    req = B.AddbaReq(1, B.BAParams(0, 1, 3, 16), 100, 0)
    assert B.check_addba_response(req, B.make_addba_response(req, buffer_size=64))     # ответ > запроса допустим
    assert B.check_addba_response(req, B.make_addba_response(req, buffer_size=1))
    assert B.check_addba_response(req, B.make_addba_response(req, accept=False)) is False
    ok = B.make_addba_response(req, buffer_size=8)
    with pytest.raises(ValueError):
        B.check_addba_response(req, ok._replace(params=ok.params._replace(buffer_size=0)))   # SUCCESS → ≥ 1
    with pytest.raises(ValueError):
        B.check_addba_response(req, ok._replace(params=ok.params._replace(policy=0)))
    with pytest.raises(ValueError):
        B.check_addba_response(req, ok._replace(token=2))
    with pytest.raises(ValueError):
        B.check_addba_response(req, ok._replace(params=ok.params._replace(tid=4)))
    with pytest.raises(ValueError):
        B.make_addba_response(req, buffer_size=0)
    assert ok.timeout == 100                                                       # по умолчанию — из запроса


@pytest.mark.parametrize('req,resp,grow,win', [
    (64, 32, False, 32),        # ответ меньше: «shall change … not greater than … Buffer Size» ответа
    (128, 100, False, 64),      # и «not greater than the value 64»
    (32, 64, False, 32),        # ответ больше: «may change» — по умолчанию нет
    (32, 64, True, 64),
    (0, 16, False, 16),         # 0 — «no information»
    (16, 16, False, 16),
])
def test_originator_win_size(req, resp, grow, win):
    assert B.originator_win_size(req, resp, grow) == win


def test_recipient_win_size():
    assert B.recipient_win_size(8) == 8
    assert B.recipient_win_size(1023) == 64


def test_inactivity_timer_tu():
    t = B.InactivityTimer(10)
    assert not t.expired(Fr(10239))
    assert t.expired(Fr(10240))                                                   # 10 TU = 10240 мкс
    t.reset(5000)
    assert not t.expired(Fr(10240))
    assert not B.InactivityTimer(0).expired(Fr(10) ** 9)                          # 0 — выключен


# ---- 9.2.4.5.4 / 10.25.6.5: когда BlockAck ----
def test_ack_policy_and_response():
    assert B.ack_policy_name(IMPL, in_ampdu=False) == 'normal'
    assert B.ack_policy_name(IMPL, in_ampdu=True) == 'implicit_bar'
    assert B.ack_policy_name(B.BLOCK_ACK, True) == 'block_ack'
    assert B.ampdu_response(['block_ack', 'implicit_bar']) == 'BlockAck'
    assert B.ampdu_response(['block_ack', 'block_ack']) is None
    assert B.ampdu_response([]) is None                                           # ничего не принято без ошибки


# ---- 10.25.6.3: полное состояние ----
def test_scoreboard_establishment():
    sb = B.Scoreboard(16, 4090)
    assert (sb.start, sb.end) == (4090, 9)


def test_scoreboard_in_window_and_ahead_shift():
    sb = B.Scoreboard(8, 0)
    for sn in (0, 1, 7):
        sb.on_data(sn)
    sb.on_data(10)                                   # b)2): WinStartR = 10 − 8 + 1 = 3, WinEndR = 10
    assert (sb.start, sb.end) == (3, 10)
    ssn, bm = sb.bitmap()
    assert ssn == 3 and B.bitmap_sns(ssn, bm) == [7, 10]       # 8, 9 обнулены (WinEndR+1 … SN−1)


def test_scoreboard_behind_no_change():
    sb = B.Scoreboard(8, 3)
    sb.on_data(5)
    before = (sb.start, sb.end, set(sb.bits))
    sb.on_data(3 + 2048)                             # WinStartR + 2^11 — BEHIND
    sb.on_data(2)
    assert (sb.start, sb.end, sb.bits) == before
    sb.on_data(3 + 2047)                             # последний SN области AHEAD
    assert sb.end == 3 + 2047


def test_scoreboard_wrap_clears_stale_bits():
    sb = B.Scoreboard(4, 0)
    for sn in range(4):
        sb.on_data(sn)
    for sn in (1000, 2000, 3000, 4000):
        sb.on_data(sn)
    sb.on_data(1)                                    # окно 4094, 4095, 0, 1: бит 0 с прошлого круга — стёрт
    assert (sb.start, sb.end) == (4094, 1)
    assert B.bitmap_sns(*sb.bitmap()) == [1]


def test_scoreboard_bar_rules():
    sb = B.Scoreboard(8, 0)
    for sn in (0, 2, 5, 7):
        sb.on_data(sn)
    sb.on_bar(5)                                     # c)1): WinStartR = 5, биты 8 … 12 обнулены
    assert (sb.start, sb.end) == (5, 12)
    assert B.bitmap_sns(*sb.bitmap()) == [5, 7]
    sb.on_bar(5 + 2048)                              # c)3): без изменений
    sb.on_bar(4)
    assert (sb.start, sb.end) == (5, 12)
    sb.on_bar(100)                                   # c)2): окно 100 … 107, все биты 0
    assert (sb.start, sb.end) == (100, 107)
    assert sb.bitmap() == (100, 0)


# ---- 10.25.6.4: частичное состояние ----
def test_partial_state_record_from_data():
    sb = B.Scoreboard(16, None, partial=True)
    assert not sb.has_record
    sb.on_data(2)                                    # b): WinEndR = 2, WinStartR = 2 − 16 + 1 = 4083
    assert (sb.start, sb.end) == (4083, 2)
    assert sb.bitmap() == (4083, 1 << 15)
    sb.drop()
    sb.on_bar(50)                                    # d): WinStartR = SSN, всё 0
    assert sb.bitmap() == (50, 0)


def test_partial_null_blockack():
    r = B.Recipient(16, 0, partial=True, null_ba_without_state=True)
    assert r.on_bar(30) == (30, 0)                   # «null BlockAck … bitmap is set to all 0s»


# ---- 10.25.6.5: SSN BlockAck и биты за пределами окна ----
def test_blockack_ssn_range():
    sb = B.Scoreboard(16, 100)
    for sn in (100, 115):
        sb.on_data(sn)
    assert sb.bitmap(52)[0] == 52                    # WinEndR − 63 = 52
    with pytest.raises(ValueError):
        sb.bitmap(51)
    with pytest.raises(ValueError):
        sb.bitmap(101)
    _, bm = sb.bitmap(52)
    assert B.bitmap_sns(52, bm) == [100, 115]
    _, bm = sb.bitmap(52, below_start=1)             # ниже WinStartR — «may be set to any value»
    assert bm == (1 << 48) - 1 | 1 << 48 | 1 << 63
    sb.bits.add(116)
    assert not sb.bitmap()[1] >> 16                  # выше WinEndR — 0


# ---- 10.25.6.6: буфер переупорядочения ----
def test_reorder_in_order_and_gap():
    rb = B.ReorderBuffer(8, 0)
    assert rb.on_data(0, 'a') == B.STORED
    assert rb.on_data(2, 'c') == B.STORED
    assert rb.delivered == [(0, 'a')] and rb.start == 1
    assert rb.on_data(2, 'c2') == B.DUPLICATE        # «otherwise discard the MPDU»
    rb.on_data(1, 'b')
    assert [s for s, _ in rb.delivered] == [0, 1, 2]
    assert (rb.start, rb.end) == (3, 10)
    assert rb.on_data(2) == B.OLD                    # c): WinStartB + 2^11 ≤ SN < WinStartB


def test_reorder_ahead_passes_with_gaps():
    rb = B.ReorderBuffer(4, 0)
    rb.on_data(1, 'b')
    rb.on_data(3, 'd')
    rb.on_data(6, 'g')                               # b): WinEndB = 6, WinStartB = 3; 1 выдаётся с дырой, 3 — по порядку
    assert [s for s, _ in rb.delivered] == [1, 3]
    assert (rb.start, rb.end) == (4, 7)
    assert set(rb.buf) == {6}


def test_reorder_bar():
    rb = B.ReorderBuffer(8, 0)
    for sn in (2, 3, 5):
        rb.on_data(sn)
    rb.on_bar(0)                                     # SSN = WinStartB — без изменений
    rb.on_bar(2048)                                  # b): WinStartB + 2^11 ≤ SSN — без изменений
    assert rb.delivered == [] and rb.start == 0
    rb.on_bar(3)                                     # a): 2 — с дырой, затем 3 по порядку
    assert [s for s, _ in rb.delivered] == [2, 3]
    assert (rb.start, rb.end) == (4, 11)


def test_reorder_wrap_order():
    rb = B.ReorderBuffer(8, 4093)
    for sn in (1, 0, 4095, 4094, 4093):
        rb.on_data(sn)
    assert [s for s, _ in rb.delivered] == [4093, 4094, 4095, 0, 1]
    assert rb.start == 2


def test_reorder_dmg_hint():
    rb = B.ReorderBuffer(8, 0)
    rb.on_data(1)
    rb.on_data(3, dmg_hint=True)                     # 10.25.6.6.2 a)2) DMG: выдача с SN, дыры 0 и 2
    assert [s for s, _ in rb.delivered] == [1, 3]
    assert rb.start == 4


def test_reorder_flush_impl():
    rb = B.ReorderBuffer(8, 0)
    rb.on_data(2)
    rb.on_data(5)
    rb.flush()
    assert [s for s, _ in rb.delivered] == [2, 5] and rb.start == 6


# ---- получатель: дубликаты, A-MPDU с пропусками, BlockAckReq ----
def test_recipient_duplicate_cache_rc2():
    r = B.Recipient(64, 0)
    assert r.on_mpdu(5) == B.ACCEPT
    assert r.on_mpdu(5, retry=True) == B.DUPLICATE   # RR5: Retry = 1 и совпадение в кэше
    assert r.on_mpdu(6, retry=True) == B.ACCEPT      # повтор, которого не было
    assert r.on_mpdu(5) == B.DUPLICATE               # без Retry — дубликат по буферу (5 ещё ждёт 0 … 4)
    r.on_mpdu(0)
    assert r.on_mpdu(0) == B.OLD                     # уже выдан: ниже WinStartB


def test_recipient_ampdu_with_holes_then_retry():
    r = B.Recipient(64, 0)
    got = [s for s in range(10) if s not in (3, 7)]
    ssn, bm = r.on_ampdu([(s, False, IMPL) for s in got])
    assert ssn == 0 and B.bitmap_sns(ssn, bm) == got
    assert [s for s, _ in r.delivered] == [0, 1, 2]
    ssn, bm = r.on_ampdu([(3, True, IMPL), (7, True, IMPL), (10, False, IMPL), (11, False, IMPL)])
    assert B.bitmap_sns(ssn, bm) == list(range(12))
    assert [s for s, _ in r.delivered] == list(range(12))
    assert r.on_ampdu([(12, False, B.BLOCK_ACK)]) is None      # Block Ack policy — ответа нет


def test_recipient_beyond_window_moves_both():
    r = B.Recipient(8, 0)
    r.on_mpdu(1)
    assert r.on_mpdu(20) == B.ACCEPT                 # SN ≥ WinEnd, < WinStart + 2^11
    assert (r.sb.start, r.sb.end) == (13, 20)
    assert (r.rb.start, r.rb.end) == (13, 20)
    assert [s for s, _ in r.delivered] == [1]
    assert r.on_mpdu(13 + 2048) == B.OLD


def test_recipient_bar_releases():
    r = B.Recipient(16, 4094)
    for sn in (4095, 1):
        r.on_mpdu(sn)
    ssn, bm = r.on_bar(4095)                         # дыра 4094 закрыта BlockAckReq
    assert ssn == 4095 and B.bitmap_sns(ssn, bm) == [4095, 1]
    assert [s for s, _ in r.delivered] == [4095]
    assert r.rb.start == 0


# ---- 10.25.6.7 / 10.25.6.8: отправитель ----
def test_originator_window_and_retry_order():
    o = B.Originator(4, 0)
    o.enqueue(8)
    assert o.build_ampdu() == [0, 1, 2, 3]
    assert o.build_ampdu() == []                     # окно занято
    acked, retry = o.on_blockack(0, 0b1011)
    assert acked == [0, 1, 3] and retry == [2]
    assert o.start == 2
    assert o.build_ampdu() == [2, 4, 5]              # DMG: сначала повторы, затем новые, в окне 2 … 5


def test_originator_ssn_beyond_winstart_not_updated():
    o = B.Originator(8, 0)
    o.enqueue(8)
    o.build_ampdu()
    acked, retry = o.on_blockack(3, 0b1)             # NOTE 1: SSN > WinStartO (частичное состояние)
    assert acked == [3] and 0 not in retry and o.state[0] == B.SENT
    acked, retry = o.on_blockack(0, 0)               # NOTE 2: подтверждённый не возвращается
    assert o.state[3] == B.ACKED and retry == [0, 1, 2, 4, 5, 6, 7]


def test_originator_wrap():
    o = B.Originator(4, 4094)
    assert o.enqueue(4) == [4094, 4095, 0, 1]
    o.build_ampdu()
    assert o.on_blockack(4094, 0b1111)[0] == [4094, 4095, 0, 1]
    assert o.start == 2


def test_originator_bitmap_outside_window_ignored():
    o = B.Originator(4, 0)
    o.enqueue(10)
    o.build_ampdu()
    acked, _ = o.on_blockack(0, (1 << 64) - 1)
    assert acked == [0, 1, 2, 3]                     # 4 … не переданы — не подтверждаются


def test_discard_then_bar_moves_recipient():
    o = B.Originator(8, 0)
    r = B.Recipient(8, 0)
    o.enqueue(4)
    o.build_ampdu()
    for sn in (1, 2, 3):                             # 0 потерян
        r.on_mpdu(sn)
    o.on_blockack(*r.build_blockack())
    assert o.start == 0
    ssn = o.discard(0)                               # срок жизни 0 истёк → BlockAckReq с SSN = 4
    assert ssn == 4
    o.on_blockack(*r.on_bar(ssn))
    assert [s for s, _ in r.delivered] == [1, 2, 3]
    assert r.rb.start == 4


@pytest.mark.parametrize('seed', range(5))
def test_end_to_end_lossy_wrap(seed):
    """A-MPDU через канал с потерями, BlockAck тоже теряется; через 4095→0 всё выдано ровно раз и по порядку."""
    rnd = random.Random(seed)
    o = B.Originator(B.originator_win_size(64, 32), 4000)
    r = B.Recipient(32, 4000)
    o.enqueue(300)
    for _ in range(2000):
        ampdu = o.build_ampdu()
        if not ampdu and o.start == o.next_sn:
            break
        rx = [(s, True, IMPL) for s in ampdu if rnd.random() > 0.3]
        ba = r.on_ampdu(rx) if rx else None
        if ba is None or rnd.random() < 0.1:
            o.on_blockack_lost()
        else:
            o.on_blockack(*ba)
    want = [B.sn_add(4000, i) for i in range(300)]
    assert [s for s, _ in r.delivered] == want
