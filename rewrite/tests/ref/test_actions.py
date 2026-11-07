# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/actions: табл. 9-51 и таблицы действий 9.6 для DMG, Action No Ack (9.3.3.14), 10.28.4, WNM (11.21.1)."""
import pytest

from . import actions as A


def msgs(v, verdict=None):
    return [m for m, x in v if verdict is None or x == verdict]


# ---------------------------------------------------------------------------------- табл. 9-51, 9.4.1.11
@pytest.mark.parametrize('body,status', [
    (bytes([3, 0]), 'open'),            # ADDBA Request (табл. 9-359)
    (bytes([20, 1]), 'open'),           # BRP (табл. 9-486)
    (bytes([4, 32]), 'pro'),            # FTM Request — pro
    (bytes([7, 0]), 'nondmg'),          # HT
    (bytes([12, 0]), 'nondmg'),         # TDLS: «A DMG STA shall not use the TDLS protocol» (11.20.1)
    (bytes([26, 0]), 'nondmg'),         # FILS — «only … non-DMG non-S1G» (11.45.1)
    (bytes([0, 4]), 'nondmg'),          # Channel Switch Announcement — DMG использует ECSA (11.8.8.6)
    (bytes([16, 8]), 'out'),            # Relay Search Request — relay не делаем
    (bytes([2, 0]), 'reserved'),        # категория 2 — Reserved
    (bytes([3, 3]), 'reserved'),        # Block Ack Action 3 — Reserved (табл. 9-359)
    (bytes([16, 6]), 'reserved'),       # DMG Action 6 — Reserved (табл. 9-457)
    (bytes([127, 0, 0x50, 0x6f]), 'open'),   # Vendor-specific
])
def test_classify_table_9_51(body, status):
    assert A.classify(body).status == status


def test_reserved_and_error_category_9_4_1_11():
    assert msgs(A.check_action(bytes([17, 0]), False, False), 'ours')          # 17 — Reserved (Wi-Fi Alliance)
    assert msgs(A.check_action(bytes([0x83, 0]), False, False), 'ours')        # Error без возврата
    assert A.check_action(bytes([0x83, 0]), False, False, echo_of=b'') == []    # возврат по 10.28.4


def test_noack_only_where_specified_9_3_3_14():
    # Link Measurement Request/Report в DMG BSS — Action или Action No Ack (9.6.6.4/9.6.6.5)
    assert A.check_action(bytes([5, 2, 0, 0, 0]), True, False) == []
    # ADDBA Request как Action No Ack — нарушение
    assert msgs(A.check_action(bytes([3, 0, 1]), True, False), 'ours')
    # BRP — только Action No Ack (9.6.21.3)
    assert msgs(A.check_action(bytes([20, 1, 0]), False, False), 'ours')
    assert A.check_action(bytes([20, 1, 0]), True, False) == []
    # Information Response: No Ack — только широковещательный; широковещательный — только No Ack (9.6.19.5)
    assert msgs(A.check_action(bytes([16, 3, 0]), True, False), 'ours')
    assert msgs(A.check_action(bytes([16, 3, 0]), False, True), 'ours')
    assert A.check_action(bytes([16, 3, 0]), True, True) == []
    assert A.check_action(bytes([16, 3, 0]), False, False) == []


def test_ati_request_not_noack_10_39_3():
    v = A.check_action(bytes([20, 0]) + bytes(10), True, False, in_ati=True)
    assert msgs(v, 'model') and 'ATI' in msgs(v)[0]
    assert A.check_action(bytes([20, 0]) + bytes(10), True, True, in_ati=True) == []      # групповой — не запрос


def test_out_of_scope_is_model_not_violation():
    v = A.check_action(bytes([6, 1]), False, False)          # FT Request
    assert msgs(v, 'model') and not msgs(v, 'ours')


def test_echo_10_28_4():
    rx = bytes([40, 1, 2, 3])
    assert A.must_echo(rx, group=False) is True
    assert A.must_echo(rx, group=True) is False
    assert A.must_echo(bytes([7, 0]), group=False) is None            # HT — зависит от реализации
    assert A.check_echo(rx, bytes([40 | 0x80, 1, 2, 3])) == []
    assert A.check_echo(rx, bytes([40 | 0x80, 1, 2, 4]))


def test_table_dmg_complete():
    rows = A.table_dmg()
    keys = {(c, a) for c, a, *_ in rows}
    assert (16, 2) in keys and (20, 0) in keys and (10, 23) in keys
    assert all(st in ('open', 'pro', 'out', 'nondmg') for *_, st, _ in rows)
    assert {c for c, *_ in rows} == set(A.CATEGORY)


# ---------------------------------------------------------------------------------- WNM 11.21.1
def ext(*bits):
    v = 0
    for b in bits:
        v |= 1 << b
    return v.to_bytes(8, 'little')


def test_wnm_request_needs_peer_bit():
    assert A.check_wnm_request(10, 7, A.wnm_bits(ext(19)))  == []             # BTM Request, бит 19 = 1
    assert A.check_wnm_request(10, 7, A.wnm_bits(ext()))                       # «shall not request»
    assert A.check_wnm_request(10, 8, A.wnm_bits(ext())) == []                 # ответ — не запрос
    assert A.check_wnm_request(10, 26, A.wnm_bits(ext(46))) == []              # WNM Notification — бит 46


def test_wnm_must_reject_unadvertised():
    accept = bytes([10, 8, 1, 0, 0])
    reject = bytes([10, 8, 1, 1, 0])
    assert A.check_wnm_response(10, 8, accept, A.wnm_bits(ext()))[0]           # принял без бита 19
    assert A.check_wnm_response(10, 8, reject, A.wnm_bits(ext()))[0] == []
    assert A.check_wnm_response(10, 8, accept, A.wnm_bits(ext(19)))[0] == []
    assert A.check_wnm_response(10, 22, bytes([10, 22, 1]), A.wnm_bits(ext())) == ([], None)   # статус не разбирается


def test_wnm_sta_needs_ecs_and_rm():
    v = A.check_wnm_caps(ext(19), capinfo_rm=0)
    assert len(msgs(v, 'ours')) == 2
    assert A.check_wnm_caps(ext(2, 19), capinfo_rm=1) == []
    assert msgs(A.check_wnm_caps(ext(2, 17), capinfo_rm=1), 'model')          # WNM sleep — TIM/DTIM
    assert A.check_wnm_caps(ext(), capinfo_rm=0) == []                         # не WNM STA
