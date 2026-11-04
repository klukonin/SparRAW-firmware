# SPDX-License-Identifier: AGPL-3.0-or-later
"""Поддержание направленной связи (ref/linkmaint): 802.11-2020 11.27.1 [p. 2355–2356], 9.5.6 [p. 1442] (табл. 9-344,
9-345), рис. 11-46. Ожидания — из текста стандарта."""
from fractions import Fraction as Fr

import pytest

from . import fields as F
from . import linkmaint as L

A, B, AP = 'a', 'b', 'ap'


def blm(unit, value, master):
    return F.Blm(unit_index=unit, value=value, is_master=master)


@pytest.mark.parametrize('fa,fb,want', [
    (blm(0, 10, 0), blm(0, 20, 0), 640),        # «0 | 0 | ≥ → (STA-A)»: большее; 32 мкс × 20
    (blm(1, 3, 1), blm(0, 20, 0), 6000),        # «1 | 0 | >,<,= → (STA-A)»: мастер; 2000 мкс × 3
    (blm(0, 20, 0), blm(1, 3, 1), 6000),        # «in no particular order»
    (blm(0, 5, 1), blm(0, 5, 1), 160),          # «1 | 1 | = → (STA-A)»
    (blm(0, 5, 1), blm(0, 6, 1), None),         # оба мастера, разные — таблица результата не задаёт
    (blm(0, 0, 1), blm(0, 6, 0), None),         # BLMV = 0 — «undefined … does not participate»
])
def test_negotiation_table_9_345(fa, fb, want):
    assert L.negotiate(fa, fb) == want


def test_active_time_and_expiry_with_halts():
    # таймер останавливается в BTI/A-BFT и в чужих SP/CBAP; рис. 11-46 — «Halt … Release»
    halts = [(100, 150), (300, 320)]
    assert L.active_time(0, 200, halts) == 150
    assert L.expiry(0, 100, halts) == 100                 # остановка начинается ровно в момент истечения
    assert L.expiry(0, 120, halts) == 170
    assert L.expiry(0, 300, halts) == 370
    assert L.expiry(120, 10, halts) == 160                # установлен внутри остановки — счёт после неё


def test_set_rules_11_27_1():
    # инициатор — по приёму немедленного ответа; получатель — после передачи ответа
    assert L.sets_timer('Ack', B, A, A, AP) == 'init_rx_resp'
    assert L.sets_timer('BlockAck', A, B, A, AP) == 'recip_tx_resp'
    assert L.sets_timer('DMG CTS', B, A, A, AP) == 'init_rx_resp'
    assert L.sets_timer('DMG DTS', B, A, A, AP) == 'init_rx_resp'
    # AP: ответ STA в ATI, SPR в ответ на Poll; STA: запрос AP в ATI, Poll или Grant
    assert L.sets_timer('Action', A, AP, AP, AP, in_ati=True) == 'ap_rx_ati_resp'
    assert L.sets_timer('SPR', A, AP, AP, AP, after='Poll') == 'ap_rx_spr'
    assert L.sets_timer('SPR', A, AP, AP, AP) is None
    assert L.sets_timer('Grant', AP, A, A, AP) == 'sta_rx_poll_grant'
    assert L.sets_timer('Poll', AP, A, A, AP) == 'sta_rx_poll_grant'
    assert L.sets_timer('Announce', AP, A, A, AP, in_ati=True) == 'sta_rx_ati_req'
    assert L.sets_timer('Data', A, B, A, AP) is None
    assert L.sets_timer('Ack', B, 'c', A, AP) is None


def test_link_timer():
    t = L.LinkTimer(None)
    t.set(0)
    assert not t.defined and t.value(10) is None and not t.expired(10 ** 9)
    t = L.LinkTimer(640, [(100, 200)])
    t.set(0)
    assert t.value(50) == 590 and t.value(150) == 540 and t.expires_at() == 740
    assert not t.expired(739) and t.expired(740)


def test_judge_expiry_without_qos_null():
    ev = [L.LogEv(0, 20, 'SSW-Ack', A, B), L.LogEv(100, 110, 'Data', A, B), L.LogEv(113, 120, 'Ack', B, A),
          L.LogEv(700, 710, 'Data', A, B)]
    v, s = L.check_blm_log(ev, A, B, Fr(500))
    assert [x.rule for x in v] == ['blm_expired'] and v[0].idx == 3 and s['sets'] == 2
    # QoS Null с Ack до истечения поддерживает связь
    ev2 = ev[:3] + [L.LogEv(600, 610, 'QoS Null', A, B), L.LogEv(613, 620, 'Ack', B, A)] + ev[3:]
    assert L.check_blm_log(ev2, A, B, Fr(500))[0] == []
    # восстановление ISS после истечения — не нарушение
    ev3 = ev[:3] + [L.LogEv(700, 715, 'SSW', A, B)]
    assert L.check_blm_log(ev3, A, B, Fr(500))[0] == []
    # остановка (BTI) продлевает таймер
    assert L.check_blm_log(ev, A, B, Fr(500), halts=[(200, 300)])[0] == []
    # не определён — правил нет
    assert L.check_blm_log(ev, A, B, None) == ([], dict(sets=0, expired=0, defined=False))
