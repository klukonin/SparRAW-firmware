# SPDX-License-Identifier: AGPL-3.0-or-later
"""A-MSDU DMG (ref/amsdu) и правило судьи amsdu: 9.3.2.2 [p. 819–821], 9.2.4.5.9/9.2.4.5.13 [p. 776], табл. 9-25
[p. 787], табл. 9-30 [p. 816], табл. 9-253/9-254 [p. 1241–1242], 10.11 [p. 1715–1717], 9.4.1.13 [p. 882], 10.12.1
[p. 1719], 10.13 [p. 1724]. Ожидания — из текста стандарта."""
import pytest

from . import air_judge as J
from . import amsdu as A
from . import blockack as BA
from . import elements as E
from . import fields as F
from .test_air_judge_c import AP, STA, Air

D1, D2, S1 = '02:00:00:00:00:01', '02:00:00:00:00:02', '02:00:00:00:00:10'


def msdu(n, da=STA, sa=S1, tid=0, expiry=None):
    return A.Msdu(da, sa, bytes(i % 251 for i in range(n)), tid, expiry)


# ---------------------------------------------------------------------------------------------------- формат
def test_basic_padding_rule():
    """9.3.2.2.2: каждый подкадр, кроме последнего, дополнен до кратного 4; последний — без паддинга; заголовок DA, SA,
    Length (рис. 9-69, 14 октетов)."""
    body = A.encode_basic([msdu(1), msdu(5), msdu(3)])
    # 14 + 1 = 15 → +1; 14 + 5 = 19 → +1; последний 14 + 3 = 17 — без паддинга
    assert len(body) == 16 + 20 + 17
    p = A.parse(body, A.BASIC)
    assert not p.violations and [s.length for s in p.subframes] == [1, 5, 3]
    assert [s.pad for s in p.subframes] == [1, 1, 0]
    assert p.subframes[1].off == 16 and p.subframes[2].off == 36
    assert p.subframes[0].da == STA and p.subframes[0].sa == S1


def test_basic_length_is_ieee8023_order():
    """9.3.2.2.2: порядок полей и бит — как в кадре IEEE 802.3: Length — старший октет первым."""
    body = A.encode_basic([msdu(0x0102)])
    assert body[12:14] == b'\x01\x02'


def test_short_padding_excludes_header():
    """9.3.2.2.3: паддинг Short — до кратного 4 длины подкадра без заголовка (Length 2 октета)."""
    body = A.encode_short([msdu(5), msdu(4), msdu(1)])
    assert len(body) == (2 + 5 + 3) + (2 + 4 + 0) + (2 + 1)
    p = A.parse(body, A.SHORT)
    assert not p.violations and [s.length for s in p.subframes] == [5, 4, 1]
    assert p.subframes[0].da is None                    # рис. 9-71: адресов в подкадре нет


def test_last_subframe_padding_is_violation():
    """9.3.2.2.2: «The last A-MSDU subframe has no padding»."""
    body = A.encode_basic([msdu(1), msdu(1)]) + b'\0\0\0'
    p = A.parse(body, A.BASIC)
    assert any('паддинг запрещён' in v for v in p.violations)


def test_wrong_padding_between_subframes():
    """Паддинг не 0–3 до кратного 4: следующий заголовок не на месте — разбор расходится с длиной тела."""
    a = A.encode_basic([msdu(1)])
    body = a + bytes(1) + A.encode_basic([msdu(1)])      # правильно — 1 октет; здесь 1, но тело собрано без учёта
    ok = A.parse(body, A.BASIC)
    assert not ok.violations
    bad = a + bytes(2) + A.encode_basic([msdu(1)])
    assert A.parse(bad, A.BASIC).violations


def test_msdu_and_amsdu_size_limits_dmg():
    """Табл. 9-25 (DMG PPDU): MSDU ≤ 7920, A-MSDU ≤ 7935 октетов."""
    A.encode_basic([msdu(A.MAX_MSDU_DMG)])                       # 14 + 7920 = 7934 ≤ 7935
    with pytest.raises(F.FieldError):
        A.encode_basic([msdu(A.MAX_MSDU_DMG + 1)])
    with pytest.raises(F.FieldError):
        A.encode_basic([msdu(4000), msdu(4000)])                 # 4016 + 4014 > 7935
    big = A.encode_basic([msdu(3950), msdu(3950)])[:A.MAX_AMSDU_DMG] + bytes(100)
    assert any('7935' in v for v in A.parse(big, A.BASIC).violations)
    assert A.MAX_AMSDU_DMG == 7935 and A.MAX_MSDU_DMG == 7920


def test_empty_amsdu_and_truncated_record():
    assert A.parse(b'', A.BASIC).violations                      # рис. 9-68: хотя бы один подкадр
    body = A.encode_basic([msdu(100), msdu(100), msdu(100)])
    p = A.parse(body[:150], A.BASIC, complete=False)             # запись усечена (dsnap): не нарушение
    assert p.truncated and not p.violations and len(p.subframes) == 1
    assert A.parse(body[:150], A.BASIC).violations              # то же как полное тело — обрезанный подкадр


def test_amsdu_type_reserved_without_present():
    """9.2.4.5.13: A-MSDU Type зарезервирован при A-MSDU Present = 0."""
    with pytest.raises(F.FieldError):
        A.encode_qos(0, amsdu=0, amsdu_type=A.SHORT)
    raw = A.encode_mpdu(STA, AP, AP, b'x', from_ds=1, amsdu=0)
    raw = raw[:24] + bytes([raw[24], raw[25] | 1]) + raw[26:]  # B8 = 1
    assert any('A-MSDU Type' in v for v in A.check_mpdu(raw).violations)


def test_qos_fields_dmg_layout():
    """Табл. 9-11 (DMG): B7 A-MSDU Present, B8 A-MSDU Type, B9 RDG/More PPDU, B15 AC Constraint."""
    q = A.parse_qos(int.from_bytes(A.encode_qos(5, ackpol=3, amsdu=1, amsdu_type=1, rdg=1, acc=1), 'little'))
    assert (q.tid, q.ackpol, q.amsdu, q.amsdu_type, q.rdg, q.acc) == (5, 3, 1, 1, 1, 1)
    assert int.from_bytes(A.encode_qos(0, amsdu=1), 'little') == 1 << 7


# ---------------------------------------------------------------------------------------------------- MPDU, 10.11
def dl(subs, **kw):
    """QoS Data точки → STA (To DS 0, From DS 1): Address 3 = BSSID в случае Basic (табл. 9-30)."""
    kw.setdefault('from_ds', 1)
    return A.encode_mpdu(STA, AP, AP, A.encode_basic(subs), **kw)


def test_downlink_basic_ok():
    ch = A.check_mpdu(dl([msdu(60, sa=D1), msdu(60, sa=D2)]), bssid=AP)
    assert ch.violations == [] and len(ch.parsed.subframes) == 2 and ch.groups == []


def test_address3_must_be_bssid_for_basic():
    """Табл. 9-30: 0/1, Basic A-MSDU — Address 3 = BSSID (в случае MSDU там SA)."""
    raw = A.encode_mpdu(STA, AP, S1, A.encode_basic([msdu(10)]), from_ds=1)
    assert any('Address 3' in v for v in A.check_mpdu(raw).violations)


def test_subframe_da_must_map_to_ra():
    """9.3.2.2.2 + табл. 9-30 (0/1: RA = DA): DA подкадра ≠ RA — нарушение; групповой — кандидат DMS."""
    ch = A.check_mpdu(dl([msdu(10, da=D1)]))
    assert any('DA' in v and 'RA' in v for v in ch.violations)
    ch = A.check_mpdu(dl([msdu(10, da='01:00:5e:01:02:03')]))
    assert ch.violations == [] and [s.da for s in ch.groups] == ['01:00:5e:01:02:03']


def test_uplink_sa_must_be_ta():
    """Табл. 9-30: 1/0 — TA = SA; Address 3 = BSSID (= RA); DA подкадров — любые, групповой — не DMS."""
    subs = [msdu(10, da=D1, sa=STA), msdu(10, da='ff:ff:ff:ff:ff:ff', sa=STA)]
    up = A.encode_mpdu(AP, STA, AP, A.encode_basic(subs), to_ds=1)
    ch = A.check_mpdu(up)
    assert ch.violations == [] and ch.groups == []
    bad = A.encode_mpdu(AP, STA, AP, A.encode_basic([msdu(10, da=D1, sa=S1)]), to_ds=1)
    assert any('SA' in v and 'TA' in v for v in A.check_mpdu(bad).violations)


def test_pbss_direct_and_pcp_forwarding():
    """Табл. 9-30 (0/0): RA = DA, TA = SA, Address 3 = BSSID; групповой DA — DMS в PBSS (11.21.16.2); через PCP с PCP
    Forwarding = 1 — DA подкадров любые (10.11, PLAN.md №28)."""
    subs = [msdu(10, da=STA, sa=D1), msdu(10, da='01:00:5e:00:00:01', sa=D1)]
    pbss = A.encode_mpdu(STA, D1, AP, A.encode_basic(subs))
    ch = A.check_mpdu(pbss, bssid=AP)
    assert ch.violations == [] and len(ch.groups) == 1
    to_pcp = A.encode_mpdu(AP, STA, AP, A.encode_basic([msdu(10, da=D1, sa=STA), msdu(10, da=D2, sa=STA)]))
    assert A.check_mpdu(to_pcp, bssid=AP)                       # без PCP Forwarding DA ≠ RA — нарушение
    assert A.check_mpdu(to_pcp, bssid=AP, ra_is_pcp_fwd=True).violations == []
    wds = A.encode_mpdu(D1, D2, AP, A.encode_basic([msdu(10)]), to_ds=1, from_ds=1, a4=S1)
    assert any('Address 4' in v for v in A.check_mpdu(wds, bssid=AP).violations)   # 1/1: A3 = A4 = BSSID


def test_group_address1_forbidden():
    """10.11: Address 1 MPDU с A-MSDU — индивидуальный (GCR concealment у DMG нет)."""
    raw = A.encode_mpdu('ff:ff:ff:ff:ff:ff', AP, AP, A.encode_basic([msdu(10, da='ff:ff:ff:ff:ff:ff')]), from_ds=1)
    assert any('Address 1' in v for v in A.check_mpdu(raw).violations)


def test_no_fragmentation():
    """10.11: «An A-MSDU shall be carried, without fragmentation, within a single QoS Data frame»."""
    assert any('фрагмент' in v for v in A.check_mpdu(dl([msdu(10)], more_frag=1)).violations)
    assert any('фрагмент' in v for v in A.check_mpdu(dl([msdu(10)], fn=1)).violations)


def test_qos_null_with_amsdu_present():
    """Табл. 9-11: у QoS Null B7 зарезервирован; 9.3.2.2.2: A-MSDU — только в QoS Data."""
    raw = A.encode_mpdu(STA, AP, AP, b'', from_ds=1, subtype=12)
    assert any('QoS Null' in v for v in A.check_mpdu(raw).violations)


def test_short_needs_ptp_tspec_and_no_forwarding():
    """10.11: Short — только после PTP TSPEC с A-MSDU Subframe = 1 в запросе и ответе; без пересылки."""
    assert A.short_allowed((1, 1)) and not A.short_allowed((1, 0)) and not A.short_allowed(None)
    raw = A.encode_mpdu(STA, AP, AP, A.encode_short([msdu(10), msdu(10)]), from_ds=1, kind=A.SHORT)
    assert any('PTP TSPEC' in v for v in A.check_mpdu(raw).violations)
    assert A.check_mpdu(raw, short_ok=True).violations == []
    fwd = A.encode_mpdu(STA, AP, S1, A.encode_short([msdu(10)]), from_ds=1, kind=A.SHORT)   # SA (A3) ≠ TA
    assert any('пересылк' in v for v in A.check_mpdu(fwd, short_ok=True).violations)


def caps(basic=0, short=0):
    return E.DmgCapabilities(STA, 1, {}, {}, 0, {}, basic, short)


def test_subframe_count_limit_from_dmg_capabilities():
    """10.11 + табл. 9-253: значение 1 — не больше 4 подкадров Basic; 0 — без ограничения."""
    four = dl([msdu(4)] * 4)
    five = dl([msdu(4)] * 5)
    assert A.check_mpdu(four, rx_caps=caps(basic=1)).violations == []
    assert any('> 4' in v for v in A.check_mpdu(five, rx_caps=caps(basic=1)).violations)
    assert A.check_mpdu(five, rx_caps=caps(basic=0)).violations == []
    # табл. 9-254: Short, значение 1 — 32 подкадра
    raw = A.encode_mpdu(STA, AP, AP, A.encode_short([msdu(1)] * 33), from_ds=1, kind=A.SHORT)
    assert any('> 32' in v for v in A.check_mpdu(raw, rx_caps=caps(short=1), short_ok=True).violations)


def test_under_ba_needs_amsdu_supported():
    """10.11: под соглашением BA — A-MSDU только при A-MSDU Supported = 1 в ADDBA Response."""
    raw = dl([msdu(10), msdu(10)], ackpol=3)
    assert A.check_mpdu(raw, ba=1).violations == []
    assert any('A-MSDU Supported' in v for v in A.check_mpdu(raw, ba=0).violations)


def test_amsdu_in_ampdu_needs_ba():
    """10.12.1 + табл. 9-530: DMG A-MPDU — Data Enabled Immediate Response, данные — только под HT-immediate BA."""
    raw = dl([msdu(10)], ackpol=0)
    assert any('A-MPDU' in v for v in A.check_mpdu(raw, in_ampdu=True).violations)
    assert A.check_mpdu(raw, in_ampdu=True, ba=1).violations == []


def test_ampdu_qos_bits_identical():
    """10.12.1: биты 4 и 8–15 QoS Control одинаковы во всех MPDU A-MPDU; B7 (A-MSDU Present) — может различаться."""
    a = int.from_bytes(A.encode_qos(0, ackpol=3, amsdu=1), 'little')
    b = int.from_bytes(A.encode_qos(0, ackpol=3, amsdu=0), 'little')
    c = int.from_bytes(A.encode_qos(0, ackpol=3, amsdu=1, amsdu_type=1), 'little')
    assert A.check_ampdu_qos([a, b]) == []
    assert A.check_ampdu_qos([a, c])


def test_encrypted_body_not_parsed():
    """9.3.2.2.2: «If encrypted, the MPDU is encrypted as a single unit» — тело не разбирается."""
    ch = A.check_mpdu(dl([msdu(10)], protected=1))
    assert ch.parsed is None and 'зашифровано' in ch.unchecked


# ---------------------------------------------------------------------------------------------------- величины
def test_lifetime_all_constituents():
    """10.11: срок A-MSDU истекает, только когда истёк срок всех MSDU."""
    assert not A.lifetime_expired(10, [5, 20])
    assert A.lifetime_expired(20, [5, 20])
    assert not A.lifetime_expired(100, [5, None])


def test_buffer_size_octets():
    """9.4.1.13: буфер — максимальный MSDU (A-MSDU Supported = 0) или A-MSDU (= 1); DMG — табл. 9-25."""
    assert A.buffer_octets(64, 0) == 64 * 7920 and A.buffer_octets(64, 1) == 64 * 7935


def test_ba_response_carries_amsdu_supported():
    """10.25.2 NOTE 3: получатель волен ответить любым A-MSDU Supported; бит — B0 Block Ack Parameter Set."""
    req = BA.AddbaReq(1, BA.BAParams(1, 1, 0, 64), 0, 0)
    r = BA.make_addba_response(req, amsdu=0)
    assert r.params.amsdu == 0 and BA.encode_ba_params(BA.BAParams(1, 1, 0, 0))[0] & 1


def test_ppdu_duration_never_binds_single_amsdu():
    """10.13 + табл. 20-30 (aPPDUMaxTime 2000 мкс): одно MPDU с A-MSDU 7935 октетов на SC MCS 1 — около 165 мкс, т. е.
    предел длительности ограничивает A-MPDU, а не A-MSDU."""
    assert A.fits_ppdu(7935 + 30, 1)
    assert A.max_amsdu_in_ppdu(1) == A.MAX_AMSDU_DMG


# ---------------------------------------------------------------------------------------------------- генератор
def test_aggregator_same_tid_and_limits():
    """10.11: один TID на A-MSDU; предел подкадров получателя; 7935 октетов; одиночный MSDU — без A-MSDU."""
    ag = A.Aggregator(rx_caps=caps(basic=1))
    q = [msdu(100, tid=0)] * 6 + [msdu(100, tid=5)] + [msdu(100, tid=0)]
    out = ag.build(q)
    assert [(k, len(ms)) for k, ms in out] == [(A.BASIC, 4), (A.BASIC, 2), (None, 1), (None, 1)]
    for k, ms in out:
        assert len({m.tid for m in ms}) == 1
        if k is not None:
            body = A.encode(k, ms)
            assert len(body) <= A.MAX_AMSDU_DMG and not A.parse(body, k).violations
    big = A.Aggregator().build([msdu(3000)] * 3)
    assert [len(ms) for _, ms in big] == [2, 1]               # 3014 + 2 + 3014 = 6030; ещё 3014 > 7935


def test_aggregator_ba_and_lifetime():
    """10.11: под BA без A-MSDU Supported — по одному MSDU; MSDU с истёкшим сроком не передаются."""
    out = A.Aggregator(ba_amsdu={0: 0}).build([msdu(10)] * 3)
    assert [k for k, _ in out] == [None, None, None]
    out = A.Aggregator().build([msdu(10, expiry=5), msdu(10, expiry=50), msdu(10)], now=10)
    assert [len(ms) for _, ms in out] == [2]


def test_aggregator_short_tid():
    out = A.Aggregator(short_tids={0}).build([msdu(10)] * 3)
    assert out[0][0] == A.SHORT and not A.parse(A.encode_short(out[0][1]), A.SHORT).violations


# ---------------------------------------------------------------------------------------------------- судья amsdu
def data_ev(a, raw, t, src=AP, dst=STA, agg=False, length=None):
    e = a.add('A-MPDU' if agg else 'Data', src, dst, t, length=length or len(raw) + 4, mcs=4, raw=raw, tx='AP',
              rx=('STA',))
    e.mpdus, e.agg = [raw], agg
    return e


def addba(a, t, amsdu, tid=0):
    req = BA.encode_addba_req(BA.AddbaReq(1, BA.BAParams(1, 1, tid, 64), 0, 0))
    a.add('Action', AP, STA, t, length=24 + len(req) + 4, raw=bytes(24) + req, action='ADDBA Request', tx='AP')
    resp = BA.encode_addba_resp(BA.make_addba_response(BA.parse_addba_req(req), amsdu=amsdu))
    a.add('Action', STA, AP, t + 50, length=24 + len(resp) + 4, raw=bytes(24) + resp, action='ADDBA Response',
          tx='STA')


def test_judge_amsdu_ok_and_bad_padding():
    a = Air()
    data_ev(a, dl([msdu(20), msdu(30)]), 1000)
    bad = dl([msdu(20), msdu(30)]) + b'\0\0'                  # паддинг после последнего
    data_ev(a, bad, 2000)
    r = J.r_amsdu(a.ctx())
    assert r.checked == 2 and len(r.viol) == 1 and 'паддинг' in r.viol[0][1]
    assert r.info['подкадров в A-MSDU'] == {2: 2}


def test_judge_amsdu_under_ba_without_support():
    a = Air()
    addba(a, 100, amsdu=0)
    data_ev(a, dl([msdu(20), msdu(30)], ackpol=3), 1000, agg=True)
    r = J.r_amsdu(a.ctx())
    assert any('A-MSDU Supported' in m for _, m, _ in r.viol)
    a2 = Air()
    addba(a2, 100, amsdu=1)
    data_ev(a2, dl([msdu(20), msdu(30)], ackpol=3), 1000, agg=True)
    assert J.r_amsdu(a2.ctx()).viol == []


def test_judge_amsdu_unrecorded_bodies_unchecked():
    """Данные без записанного заголовка (по умолчанию нет rxqos/txqos) — «не проверяемо», не «ок»."""
    a = Air()
    e = a.add('Data', AP, STA, 1000, length=500, mcs=4, raw=bytes(24), tx='AP', synth=True)
    e.mpdus = []
    r = J.r_amsdu(a.ctx())
    assert r.status == 'unchecked' and r.unchecked
    assert J.r_amsdu in J.RULES and any(x[0] == 'amsdu_body' for x in J.NOT_CHECKABLE)


def test_judge_amsdu_short_without_tspec_is_capture_verdict():
    a = Air()
    data_ev(a, A.encode_mpdu(STA, AP, AP, A.encode_short([msdu(8), msdu(8)]), from_ds=1, kind=A.SHORT), 1000)
    r = J.r_amsdu(a.ctx())
    assert [v for _, _, v in r.viol] == ['capture']
