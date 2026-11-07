# SPDX-License-Identifier: AGPL-3.0-or-later
"""ref/chswitch: ECSA (9.4.2.52 [p. 1119], рис. 9-369), кадр ECSA (9.6.7.7, рис. 9-871), Supported Channels (9.4.2.17,
рис. 9-176), Supported Operating Classes (9.4.2.53); смена канала DMG BSS (11.8.8.6 [p. 2188]), ECS (11.9.1
[p. 2189]), Supported Channels при ассоциации (11.8.2.2 [p. 2178]); DMG-классы табл. E-4; правила судьи ecsa и
supp_channels. Ожидания — из текста стандарта."""
from types import SimpleNamespace as NS

import pytest

from . import air_judge as J
from . import chswitch as C
from . import elements as E
from . import timing as T
from .test_air_judge_c import AP, STA, Air
from .test_linkadapt import act, hdr


# ---------------------------------------------------------------------------------------------- элементы
def test_ecsa_layout():
    # рис. 9-369: ID 60, Length 4: Channel Switch Mode, New Operating Class, New Channel Number, Channel Switch Count
    x = C.Ecsa(1, 180, 3, 5)
    b = C.encode_ecsa(x)
    assert b == bytes([60, 4, 1, 180, 3, 5]) and C.parse_ecsa(b[2:]) == x
    with pytest.raises(ValueError):
        C.parse_ecsa(b[2:] + b'\x00')                         # табл. 9-92: не расширяемый


def test_ecsa_fields_dmg():
    assert C.check_ecsa(C.Ecsa(0, 180, 6, 1)) == []
    assert C.check_ecsa(C.Ecsa(0, 181, 2, 1)) == []
    assert any('Mode' in m for m in C.check_ecsa(C.Ecsa(2, 180, 2, 1)))      # 9.4.2.52: 0 или 1
    assert any('табл. E-4' in m for m in C.check_ecsa(C.Ecsa(0, 115, 36, 1)))  # не DMG-класс
    assert any('класса 181' in m for m in C.check_ecsa(C.Ecsa(0, 181, 5, 1)))  # 181 — только 2, 3
    assert C.channel_freq_mhz(2) == 60480                     # 56,16 ГГц + 2 × 2,16 ГГц


def test_ecsa_frame():
    # рис. 9-871: Category 4 (Public), Public Action 4, четыре поля; 11.9.1 — Address 1 широковещательный
    b = C.encode_ecsa_frame(C.Ecsa(0, 180, 4, 3))
    assert b == bytes([4, 4, 0, 180, 4, 3])
    assert C.parse_ecsa_frame(b) == (C.Ecsa(0, 180, 4, 3), [])
    assert C.check_ecsa_frame_addr(T.BCAST) == [] and C.check_ecsa_frame_addr(STA)


def test_supported_channels():
    # рис. 9-176: пары (First Channel Number, Number of Channels)
    b = C.encode_supported_channels([(1, 4), (6, 1)])
    assert b == bytes([36, 4, 1, 4, 6, 1])
    sb = C.parse_supported_channels(b[2:])
    assert C.channels_of(sb) == {1, 2, 3, 4, 6} and C.subbands_of({1, 2, 3, 4, 6}) == [(1, 4), (6, 1)]
    assert C.check_supported_channels(sb) == []
    assert C.check_supported_channels([(5, 3)])                # 7 — не DMG-канал
    assert C.check_supported_channels([(2, 0)])
    with pytest.raises(ValueError):
        C.parse_supported_channels(b'\x01')


def test_supported_opclasses():
    assert C.parse_supported_opclasses(bytes([180, 180, 181, 130, 1])) == (180, [180, 181])
    assert C.check_supported_opclasses(180, [180]) == []
    assert C.check_supported_opclasses(81, [81])               # 11.9.2: класс работы DMG BSS — DMG


# ---------------------------------------------------------------------------------------------- модель
def test_ap_announce_count_per_tbtt():
    ap = C.ApChannelSwitch(180, 2)
    ap.announce(10, channel=3, count=3)
    # 9.4.2.52: Count — число TBTT до смены; 1 — смена непосредственно перед следующим TBTT
    assert [ap.element_for(k) and ap.element_for(k).count for k in range(9, 15)] == [None, 3, 2, 1, None, None]
    assert ap.switch_bi() == 13
    assert not ap.tick(12) and ap.tick(13) and ap.channel == 3 and ap.pending is None
    with pytest.raises(ValueError):
        ap.announce(20, channel=9, count=1)
    with pytest.raises(ValueError):
        C.ApChannelSwitch(ecs=False)                            # 11.9.1


def test_ap_select_common_channel():
    # 11.8.8.6: точка «may make use of the information in received Supported Channels elements»
    assert C.ApChannelSwitch.select({STA: {1, 2, 3}, 'x': {2, 3, 4}}, current=2) == 3
    assert C.ApChannelSwitch.select({STA: {1}, 'x': {2}}) is None


def test_sta_behaviour():
    s = C.StaChannelSwitch(2)
    assert s.on_ecsa(10, C.Ecsa(1, 180, 4, 2)) == 'switch'
    assert not s.tick(11) and s.tick(12) and s.channel == 4
    # 11.8.8.6: STA может игнорировать режим и выбрать другое действие; сама ECSA не передаёт
    assert C.StaChannelSwitch.may_transmit(1) and not C.StaChannelSwitch.may_send_ecsa()
    assert C.StaChannelSwitch(2, follow=False).on_ecsa(10, C.Ecsa(0, 180, 4, 2)) == 'alternative'
    assert C.check_sta_no_ecsa(False, True) and C.check_sta_no_ecsa(True, True) == []


def obs_seq(counts, k0=10, x=C.Ecsa(0, 180, 3, 0)):
    return [C.Obs(k0 + i, 'DMG Beacon', None if c is None else x._replace(count=c), k0 + i)
            for i, c in enumerate(counts)]


def test_sequence_ok_and_violations():
    assert C.check_ecsa_sequence(obs_seq([None, 4, 3, 2, 1, None, None]))[0] == []
    # несколько маяков в одном BTI — один счётчик
    o = obs_seq([3, 2, 1])
    assert C.check_ecsa_sequence([o[0], o[0]._replace(ref='b'), o[1], o[2]])[0] == []
    # счётчик не −1 на TBTT
    v, _ = C.check_ecsa_sequence(obs_seq([4, 3, 3, 1]))
    assert len(v) == 1 and 'Count 3' in v[0][1]
    # обрыв объявления до момента смены (11.8.8.6: «until the intended channel switch time»)
    v, _ = C.check_ecsa_sequence(obs_seq([4, 3, None, None]))
    assert len(v) == 1 and '11.8.8.6' in v[0][1]
    # канал сменился во время объявления
    o = obs_seq([3, 2, 1])
    o[1] = o[1]._replace(ecsa=C.Ecsa(0, 180, 5, 2))
    assert any('режим/класс/канал' in m for _, m in C.check_ecsa_sequence(o)[0])
    # Count 0 — «any time after the frame»
    v, notes = C.check_ecsa_sequence(obs_seq([0, 0, None]))
    assert v == [] and notes


def test_association_channels_rule():
    sc = E.Element(36, None, bytes([1, 6]))
    assert C.check_association_channels([sc]) == ([], {1, 2, 3, 4, 5, 6})
    # Supported Channels в Information Request вместо Association Request — тоже «provide» (11.8.2.2)
    assert C.check_association_channels([], [[sc]])[0] == []
    v, _ = C.check_association_channels([E.Element(0, None, b'x')])
    assert v and '11.8.2.2' in v[0]
    # пересечение для широковещательного Information Response
    assert C.check_bcast_supported_channels([(2, 2)], {STA: {1, 2, 3}, 'x': {2, 3, 4}}) == []
    assert C.check_bcast_supported_channels([(1, 3)], {STA: {1, 2, 3}, 'x': {2, 3, 4}})


# ---------------------------------------------------------------------------------------------- судья
BI_US = 100 * T.TU


def beacon(a, k, els=(), ts=None, cdown=0):
    t = 1000 + k * BI_US
    p = NS(beacon_interval=100, timestamp=int(t if ts is None else ts), ssw=NS(cdown=cdown, sector_id=cdown),
           elements=tuple((x[0], None, bytes(x[2:])) for x in els), bic=None, params=None)
    return a.add('DMG Beacon', AP, T.BCAST, t, length=60, p=p, tx='AP')


def test_judge_ecsa_ok_and_count_error():
    a = Air()
    beacon(a, 1)
    for k, c in zip(range(2, 6), (4, 3, 2, 1)):
        beacon(a, k, [C.encode_ecsa(C.Ecsa(0, 180, 3, c))])
    beacon(a, 6)
    r = J.r_ecsa(a.ctx())
    assert r.viol == [] and r.checked == 4 and r.info['ecsa_frames'] == 4
    a = Air()
    for k, c in zip(range(2, 6), (4, 3, 1, 1)):
        beacon(a, k, [C.encode_ecsa(C.Ecsa(0, 180, 3, c))])
    assert any('Count 1' in m for _, m, _ in J.r_ecsa(a.ctx()).viol)


def test_judge_ecsa_from_sta_and_frame_address():
    a = Air()
    act(a, STA, AP, 1000, C.encode_ecsa_frame(C.Ecsa(0, 180, 3, 2)))     # от STA и Address 1 = AP
    msgs = [m for _, m, _ in J.r_ecsa(a.ctx()).viol]
    assert any('non-AP' in m for m in msgs) and any('11.9.1' in m for m in msgs)
    a = Air()
    raw = hdr(13, T.BCAST, AP) + C.encode_ecsa_frame(C.Ecsa(0, 180, 3, 2))
    a.add('Action', AP, T.BCAST, 1000, length=len(raw) + 4, raw=raw, tx='AP')
    r = J.r_ecsa(a.ctx())
    assert r.viol == [] and r.checked == 1


def assoc_req(a, src, t, els):
    raw = hdr(0, AP, src) + E.encode_body(E.ASSOC_REQ, {'capability': 0, 'listen_interval': 0},
                                          [E.encode_element(0, b'x')] + list(els))
    return a.add(E.ASSOC_REQ, src, AP, t, length=len(raw) + 4, raw=raw, tx='STA')


def test_judge_supported_channels():
    a = Air()
    assoc_req(a, STA, 1000, [C.encode_supported_channels([(1, 6)])])
    r = J.r_supp_channels(a.ctx())
    assert r.viol == [] and r.checked == 1
    a = Air()
    assoc_req(a, STA, 1000, [])
    assert any('11.8.2.2' in m for _, m, _ in J.r_supp_channels(a.ctx()).viol)
    a = Air()
    assoc_req(a, STA, 1000, [C.encode_supported_channels([(5, 3)])])
    assert any('DMG-каналов' in m for _, m, _ in J.r_supp_channels(a.ctx()).viol)


def test_judge_rules_registered():
    assert {J.r_ecsa, J.r_supp_channels} <= set(J.RULES) and 'ecsa_switch' in {x[0] for x in J.NOT_CHECKABLE}
