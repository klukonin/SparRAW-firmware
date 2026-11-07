# SPDX-License-Identifier: AGPL-3.0-or-later
"""DMS (ref/dms) и правило судьи dms: 11.21.16.1–11.21.16.2 [p. 2291–2294], 9.4.2.87/9.4.2.88 [p. 1190–1194],
9.6.13.26/9.6.13.27 [p. 1547], 9.4.2.30/9.4.2.32 [p. 1078–1092], 9.4.2.26 (бит 26), 11.21.1 [p. 2256], 11.3.5.4
[p. 2137–2138]. Ожидания — из текста стандарта."""
import ipaddress

from . import air_judge as J
from . import amsdu as A
from . import dms as M
from . import elements as E
from . import fields as F
from .test_air_judge_c import AP, STA, Air

STA2 = '24:18:1d:26:d4:7c'
G1, G2 = '01:00:5e:01:02:03', '01:00:5e:07:08:09'
SRC = '02:00:00:00:00:10'


def add(*groups, proc=None):
    return M.Descriptor(0, M.REQ_ADD, tuple(M.tclas_eth(g) for g in groups), proc)


def roundtrip_req(token, ds):
    return M.parse_frame(M.encode_request_frame(token, ds))


# ---------------------------------------------------------------------------------------------------- кодеки
def test_descriptor_layout_and_length():
    """Рис. 9-476: DMSID, DMS Length = 1 + n, Request Type; TCLAS типа 0 — 16 октетов Frame Classifier (рис. 9-304),
    элемент TCLAS = 2 + 1 (UP) + 16."""
    b = M.encode_descriptor(add(G1))
    assert b[0] == 0 and b[2] == M.REQ_ADD and b[1] == 1 + 19 and len(b) == 3 + 19
    assert b[3] == M.EID_TCLAS and b[4] == 17 and b[6] == 0            # Element ID 14, Length 17, тип 0
    f = roundtrip_req(7, [add(G1)])
    assert f.action == M.ACT_DMS_REQ and f.token == 7 and f.items[0].tclas[0].ctype == 0
    assert M.tclas_group(f.items[0].tclas[0]) == ('mac', G1)


def test_status_layout_terminate_length_3():
    """Рис. 9-479: DMS Length = 3 + n; «Terminate» — DMS Length 3."""
    b = M.encode_status(M.Status(5, M.RESP_TERMINATE, 0x1230))
    assert list(b[:3]) == [5, 3, M.RESP_TERMINATE] and int.from_bytes(b[3:5], 'little') == 0x1230
    f = M.parse_frame(M.encode_response_frame(0, [M.Status(5, M.RESP_TERMINATE, 0x1230)]))
    assert f.items[0].last_seq == 0x1230 and M.check_response(f) == []


def test_frame_header_category_and_action():
    """Табл. 9-51: WNM — 10; табл. 9-425: DMS Request 23, DMS Response 24; Dialog Token запроса ≠ 0 (9.6.13.26)."""
    b = M.encode_request_frame(1, [add(G1)])
    assert b[:2] == bytes([10, 23])
    assert M.encode_response_frame(0, [])[:2] == bytes([10, 24])
    import pytest
    with pytest.raises(ValueError):
        M.encode_request_frame(0, [add(G1)])


def test_elements_split_at_255():
    """11.21.16.2: дескрипторы длиннее 255 октетов — несколько элементов, каждый дескриптор целиком в одном."""
    ds = [add(G1, G2, proc=M.PROC_ANY) for _ in range(8)]       # 3 + 2·19 + 3 = 44 октета каждый
    raw = M.encode_request_elements(ds)
    els = E.parse_elements(raw, defragment=False)
    assert len(els) == 2 and all(len(e.info) <= 255 for e in els) and len(els[0].info) == 5 * 44
    f = roundtrip_req(1, ds)
    assert len(f.items) == 8 and M.check_request(f) == []
    # лишнее разбиение (поместилось бы в первый элемент) — нарушение
    bad = E.encode_element(M.EID_DMS_REQ, M.encode_descriptor(ds[0])) * 2
    f2 = M.parse_frame(bytes([10, 23, 1]) + bad)
    assert any('11.21.16.2' in v for v in M.check_request(f2))


def test_tclas_ip_classifiers():
    """Табл. 9-164: типы 1 и 4 — Destination IP; групповой IPv4 224/4, IPv6 ff00::/8 (11.21.16.2)."""
    t = M.tclas_ip4('239.1.2.3', dport=5000)
    assert M.check_tclas_dms(t) == [] and M.tclas_group(t) == ('ip', ipaddress.IPv4Address('239.1.2.3'))
    assert M.check_tclas_dms(M.tclas_ip4('10.0.0.1'))
    t6 = M.tclas_ip6('ff05::1:3')
    assert M.check_tclas_dms(t6) == [] and M.parse_tclas(E.parse_elements(M.encode_tclas(t6))[0].info) == t6
    assert M.group_mac(('ip', ipaddress.IPv4Address('239.129.2.3'))) == '01:00:5e:01:02:03'
    assert M.group_mac(('ip', ipaddress.IPv6Address('ff02::1:ff00:1'))) == '33:33:ff:00:00:01'


def test_tclas_dms_types_only_0_1_4():
    """11.21.16.2: Classifier Type — 0, 1 или 4; адрес назначения — групповой."""
    assert any('0, 1, 4' in v for v in M.check_tclas_dms(M.Tclas(255, 5, 7, bytes(4))))
    assert any('не групповой' in v for v in M.check_tclas_dms(M.tclas_eth(STA)))
    t4 = M.tclas_ip4('239.1.2.3')._replace(mask=4)              # без бита Version
    assert any('Version' in v for v in M.check_tclas_dms(t4))


# ---------------------------------------------------------------------------------------------------- правила полей
def test_descriptor_rules():
    """9.4.2.87 / 11.21.16.2."""
    assert M.check_descriptor(add(G1)) == []
    assert any('DMSID' in v for v in M.check_descriptor(add(G1)._replace(dmsid=3)))       # Add: DMSID = 0
    assert any('нет TCLAS' in v for v in M.check_descriptor(M.Descriptor(0, M.REQ_ADD)))
    assert any('без TCLAS Processing' in v for v in M.check_descriptor(add(G1, G2)))       # 2 TCLAS — Processing
    assert any('Processing при 1' in v for v in M.check_descriptor(add(G1, proc=0)))
    assert any('зарезервирован' in v for v in M.check_descriptor(M.Descriptor(0, 3)))     # табл. 9-229
    rm = M.Descriptor(4, M.REQ_REMOVE)
    assert M.check_descriptor(rm) == [] and M.encode_descriptor(rm)[1] == 1                # Remove: DMS Length 1
    assert any('Remove' in v for v in M.check_descriptor(rm._replace(tspec=bytes(55))))
    assert any('DMSID = 0' in v for v in M.check_descriptor(M.Descriptor(0, M.REQ_CHANGE)))
    assert any('Request Type ≠' in v for v in M.check_descriptor(M.Descriptor(4, M.REQ_CHANGE, add(G1).tclas)))


def test_gcr_out_for_dmg():
    """11.21.16.1: «DMG STAs do not use GCR» — подэлемент GCR Request/Response и «GCR Advertise» — нарушения."""
    d = add(G1)._replace(subelements=bytes([M.SUBEL_GCR, 1, 0x11]))
    assert any('GCR' in v for v in M.check_descriptor(d))
    assert any('GCR' in v for v in M.check_status(M.Status(1, M.RESP_GCR_ADVERTISE, 0, add(G1).tclas)))


def test_status_rules():
    """9.4.2.88."""
    acc = M.Status(1, M.RESP_ACCEPT, 0, add(G1).tclas)
    assert M.check_status(acc) == []
    assert any('DMSID = 0' in v for v in M.check_status(acc._replace(dmsid=0)))
    assert any('нет TCLAS' in v for v in M.check_status(acc._replace(tclas=())))
    assert any('Last Sequence' in v for v in M.check_status(acc._replace(last_seq=0x10)))     # Reserved / 65535
    assert M.check_status(acc._replace(last_seq=M.LAST_SEQ_UNSUPPORTED)) == []
    term = M.Status(1, M.RESP_TERMINATE, 0x0105)
    assert any('B0–B3' in v for v in M.check_status(term))
    assert any('DMS Length = 3' in v for v in M.check_status(term._replace(last_seq=0x50, tclas=add(G1).tclas)))
    assert M.check_status(term._replace(last_seq=M.LAST_SEQ_NOT_GROUP)) == []


def test_unsolicited_response_only_terminate():
    """9.6.13.27: Dialog Token 0 — ответ без запроса, «autonomously to terminate»."""
    f = M.parse_frame(M.encode_response_frame(0, [M.Status(1, M.RESP_ACCEPT, 0, add(G1).tclas)]))
    assert any('без запроса' in v for v in M.check_response(f))


# ---------------------------------------------------------------------------------------------------- обмен
def test_exchange_order_dmsid_and_copy():
    """11.21.16.2: статус на каждый дескриптор в том же порядке; Accept — ненулевой DMSID и копии TCLAS; Denied —
    DMSID 0; Remove → Terminate; токен — из запроса."""
    req = [add(G1), add(G2), M.Descriptor(9, M.REQ_REMOVE)]
    ok = [M.Status(1, M.RESP_ACCEPT, 0, req[0].tclas), M.Status(0, M.RESP_DENIED, 0, req[1].tclas),
          M.Status(9, M.RESP_TERMINATE, M.LAST_SEQ_NOT_GROUP)]
    assert M.check_exchange(req, ok, 3, 3) == []
    assert any('Dialog Token' in v for v in M.check_exchange(req, ok, 3, 4))
    assert any('DMS Status на' in v for v in M.check_exchange(req, ok[:2]))
    swapped = [ok[1], ok[0], ok[2]]                 # порядок нарушен: Accept с TCLAS первого — на второй
    assert any('копия' in v for v in M.check_exchange(req, swapped))
    assert any('копия' in v for v in M.check_exchange(req[:1], [ok[0]._replace(tclas=req[1].tclas)]))
    assert any('Denied с DMSID' in v for v in M.check_exchange(req[1:2], [ok[1]._replace(dmsid=4)]))
    assert any('Terminate' in v for v in M.check_exchange(req[2:], [M.Status(9, M.RESP_ACCEPT, 0)]))


def test_exchange_change_keeps_dmsid():
    """11.21.16.2: ответ на «Change» — DMSID дескриптора и при Accept, и при Denied."""
    ch = [M.Descriptor(4, M.REQ_CHANGE, tspec=bytes(55))]
    good = [M.Status(4, M.RESP_DENIED, 0, add(G1).tclas, None, bytes(55))]
    assert M.check_exchange(ch, good) == []
    assert any('DMSID 5' in v for v in M.check_exchange(ch, [good[0]._replace(dmsid=5)]))


def test_exchange_provider_without_dms_bit_must_reject():
    """11.21.1: «shall reject the request if the receiving WNM STA has not advertised support»."""
    req = [add(G1)]
    acc = [M.Status(1, M.RESP_ACCEPT, 0, req[0].tclas)]
    assert any('11.21.1' in v for v in M.check_exchange(req, acc, provider_dms=False))


def test_same_tclas_set_same_dmsid():
    """11.21.16.2: тот же набор TCLAS (без учёта порядка) у непрекращённого потока — тот же DMSID."""
    p = mk_provider()
    _, s1 = p.on_request(STA, [add(G1, G2, proc=0)], 1)
    _, s2 = p.on_request(STA2, [add(G2, G1, proc=0)], 1)
    assert s1[0].resp_type == s2[0].resp_type == M.RESP_ACCEPT and s1[0].dmsid == s2[0].dmsid != 0
    accepted = {s1[0].dmsid: M._tclas_key(add(G1, G2, proc=0).tclas, 0)}
    bad = [s2[0]._replace(dmsid=s1[0].dmsid + 1)]
    assert any('same DMSID' in v for v in M.check_exchange([add(G2, G1, proc=0)], bad, accepted=accepted))


# ---------------------------------------------------------------------------------------------------- поведение
def mk_provider(**kw):
    p = M.DmsProvider(AP, **kw)
    p.associate(STA, True)
    p.associate(STA2, True)
    return p


def group_msdu(da=G1, data=b'\xaa\xaa\x03\x00\x00\x00\x08\x00' + bytes(20)):
    return A.Msdu(da, SRC, data, 0)


def test_provider_individual_amsdu_with_group_da():
    """11.21.16.2: принятый DMS — групповые MSDU станции как подкадры индивидуального A-MSDU, DA подкадра — групповой;
    групповой кадр — пока есть связанная станция без DMS."""
    p = mk_provider()
    tok, st = p.on_request(STA, [add(G1)], 5)
    assert tok == 5 and st[0].resp_type == M.RESP_ACCEPT and st[0].dmsid != 0
    txs = p.transmit_group(group_msdu(), sn=100)
    kinds = sorted((t.kind, t.ra) for t in txs)
    assert kinds == [('amsdu', STA), ('group', G1)]
    body = next(t.body for t in txs if t.kind == 'amsdu')
    sub = A.parse(body, A.BASIC).subframes
    assert [(s.da, s.sa) for s in sub] == [(G1, SRC)]
    # MPDU с этим A-MSDU к STA проходит проверки 10.11; групповой DA — кандидат DMS
    ch = A.check_mpdu(A.encode_mpdu(STA, AP, AP, body, from_ds=1), bssid=AP)
    assert ch.violations == [] and [s.da for s in ch.groups] == [G1]
    # другая группа — только групповой кадр
    assert [t.kind for t in p.transmit_group(group_msdu(G2))] == ['group']


def test_provider_no_group_copy_when_all_use_dms():
    """11.21.16.2: групповая копия — «if at least one associated STA has not requested DMS» (PLAN.md №32)."""
    p = mk_provider()
    p.on_request(STA, [add(G1)], 1)
    p.on_request(STA2, [add(G1)], 1)
    txs = p.transmit_group(group_msdu(), sn=7)
    assert sorted(t.kind for t in txs) == ['amsdu', 'amsdu']
    _, st = p.terminate(next(iter(p.flows)), STA)
    assert st[0].last_seq == M.LAST_SEQ_NOT_GROUP          # последний кадр не посылался групповым — 65 534


def test_provider_terminate_last_sequence_control():
    """9.4.2.88: «Terminate» — B4–B15 Last Sequence Control = SN последнего группового кадра, B0–B3 = 0."""
    p = mk_provider()
    p.on_request(STA, [add(G1)], 1)
    p.transmit_group(group_msdu(), sn=0x123)
    i = next(iter(p.flows))
    tok, st = p.on_request(STA, [M.Descriptor(i, M.REQ_REMOVE)], 9)
    assert st == [M.Status(i, M.RESP_TERMINATE, 0x1230)] and M.check_status(st[0]) == []
    assert p.flows == {} and [t.kind for t in p.transmit_group(group_msdu())] == ['group']
    p2 = mk_provider(last_seq_supported=False)
    p2.on_request(STA, [add(G1)], 1)
    _, st2 = p2.terminate(next(iter(p2.flows)), STA)
    assert st2[0].last_seq == M.LAST_SEQ_UNSUPPORTED


def test_provider_denies_without_dms_support():
    """11.21.16.2: DMS — станциям, «that support DMS»; 11.21.1: точка без бита DMS отказывает."""
    p = M.DmsProvider(AP)
    p.associate(STA, False)
    _, st = p.on_request(STA, [add(G1)], 1)
    assert st[0].resp_type == M.RESP_DENIED and st[0].dmsid == 0
    p2 = M.DmsProvider(AP, activated=False)
    p2.associate(STA, True)
    assert p2.on_request(STA, [add(G1)], 1)[1][0].resp_type == M.RESP_DENIED
    p3 = mk_provider()
    assert p3.on_request(STA, [add(STA)], 1)[1][0].resp_type == M.RESP_DENIED   # не групповой адрес


def test_provider_responses_pass_exchange_check():
    p = mk_provider()
    req = [add(G1), add(G2, G1, proc=M.PROC_ANY)]
    tok, st = p.on_request(STA, req, 3)
    assert M.check_exchange(req, st, 3, tok) == []
    assert all(M.check_status(s, k) == [] for k, s in enumerate(st, 1))
    ch = [M.Descriptor(st[0].dmsid, M.REQ_CHANGE, tspec=bytes(55))]
    tok, st2 = p.on_request(STA, ch, 4)
    assert st2[0].resp_type == M.RESP_ACCEPT and M.check_exchange(ch, st2) == [] and M.check_status(st2[0]) == []


def test_reassociation_keeps_dms_same_ap_only():
    """11.3.5.4 c): к той же точке DMS-соглашения не затрагиваются; к другой — удаляются."""
    p = mk_provider()
    p.on_request(STA, [add(G1)], 1)
    p.reassociate(STA, True, same_ap=True)
    assert p.members(group_msdu()) == {STA}
    p.reassociate(STA, True, same_ap=False)
    assert p.members(group_msdu()) == set()


def test_ip_classifier_matching():
    """9.4.2.30: сравниваются параметры с битом маски 1 (тип 4, IPv4: Destination IP, Destination Port)."""
    t = M.tclas_ip4('239.1.2.3', dport=5000)
    ip = bytes([0x45, 0, 0, 28, 0, 0, 0, 0, 1, 17, 0, 0]) + bytes([10, 0, 0, 1]) + bytes([239, 1, 2, 3])
    udp = (1234).to_bytes(2, 'big') + (5000).to_bytes(2, 'big') + bytes(4)
    m = A.Msdu(G1, SRC, b'\xaa\xaa\x03\x00\x00\x00\x08\x00' + ip + udp, 0)
    assert M.tclas_match(t, m)
    assert not M.tclas_match(M.tclas_ip4('239.1.2.3', dport=5001), m)
    assert M.tclas_set_match((t, M.tclas_eth(G2)), M.PROC_ANY, m)
    assert not M.tclas_set_match((t, M.tclas_eth(G2)), M.PROC_ALL, m)


def test_recipient_discard_and_duplicates():
    """11.21.16.2: станция отбрасывает групповые кадры принятых групп до прекращения; после — дубли по Last Sequence
    Control (PLAN.md №33)."""
    r = M.DmsRecipient(STA)
    assert r.request([add(G1)], provider_dms=False) is None             # 11.21.1
    assert r.request([add(G1)], provider_is_pcp=True, pcp_forwarding=False) is None    # PBSS, PCP Forwarding = 0
    tok, ds = r.request([add(G1)])
    r.on_response(tok, [M.Status(3, M.RESP_ACCEPT, 0, ds[0].tclas)])
    assert not r.rx_group(G1, 10) and r.rx_group(G2, 10)
    r.on_response(0, [M.Status(3, M.RESP_TERMINATE, 20 << 4)])
    assert not r.rx_group(G1, 20)                      # SN ≤ последнего доставленного индивидуально — дубль
    assert r.rx_group(G1, 21) and r.rx_group(G1, 15)   # первый новый снимает фильтр
    assert r.rx_amsdu(A.encode_basic([A.Msdu(G1, SRC, b'x')])) == [(G1, SRC, b'x')]


# ---------------------------------------------------------------------------------------------------- судья dms
def act(a, src, dst, t, body, name, tx):
    raw = bytes(24) + body
    return a.add('Action', src, dst, t, length=len(raw) + 4, raw=raw, action=name, tx=tx)


def data_ev(a, raw, t):
    e = a.add('Data', AP, STA, t, length=len(raw) + 4, mcs=4, raw=raw, tx='AP', rx=('STA',))
    e.mpdus = [raw]
    return e


def amsdu_mpdu(da):
    return A.encode_mpdu(STA, AP, AP, A.encode_basic([A.Msdu(da, SRC, b'\xaa' * 40)]), from_ds=1)


def test_judge_dms_exchange_and_data_ok():
    a = Air()
    act(a, STA, AP, 1000, M.encode_request_frame(2, [add(G1)]), 'DMS Request', 'STA')
    act(a, AP, STA, 2000, M.encode_response_frame(2, [M.Status(1, M.RESP_ACCEPT, 0, add(G1).tclas)]),
        'DMS Response', 'AP')
    data_ev(a, amsdu_mpdu(G1), 3000)
    r = J.r_dms(a.ctx())
    assert r.viol == [] and r.checked == 3


def test_judge_dms_group_da_without_agreement():
    a = Air()
    act(a, STA, AP, 1000, M.encode_request_frame(2, [add(G1)]), 'DMS Request', 'STA')
    act(a, AP, STA, 2000, M.encode_response_frame(2, [M.Status(0, M.RESP_DENIED, 0, add(G1).tclas)]),
        'DMS Response', 'AP')
    data_ev(a, amsdu_mpdu(G1), 3000)
    r = J.r_dms(a.ctx())
    assert [v for _, m, v in r.viol if 'без принятого DMS' in m] == ['ours']
    a2 = Air()                                          # DMS-обмена в захвате нет вовсе — вердикт capture
    data_ev(a2, amsdu_mpdu(G1), 3000)
    assert [v for _, _, v in J.r_dms(a2.ctx()).viol] == ['capture']


def test_judge_dms_bad_response_and_roles():
    a = Air()
    act(a, STA, AP, 1000, M.encode_request_frame(2, [add(G1), add(G2)]), 'DMS Request', 'STA')
    act(a, AP, STA, 2000, M.encode_response_frame(2, [M.Status(1, M.RESP_ACCEPT, 0, add(G1).tclas)]),
        'DMS Response', 'AP')                           # один статус на два дескриптора
    act(a, AP, STA, 3000, M.encode_request_frame(3, [add(G1)]), 'DMS Request', 'AP')     # запрос от точки
    r = J.r_dms(a.ctx())
    ms = [m for _, m, _ in r.viol]
    assert any('DMS Status на 2' in m for m in ms) and any('non-AP STA' in m for m in ms)


def test_judge_dms_terminate_then_group_da():
    a = Air()
    act(a, STA, AP, 1000, M.encode_request_frame(2, [add(G1)]), 'DMS Request', 'STA')
    act(a, AP, STA, 2000, M.encode_response_frame(2, [M.Status(1, M.RESP_ACCEPT, 0, add(G1).tclas)]),
        'DMS Response', 'AP')
    act(a, AP, STA, 2500, M.encode_response_frame(0, [M.Status(1, M.RESP_TERMINATE, M.LAST_SEQ_NOT_GROUP)]),
        'DMS Response', 'AP')
    data_ev(a, amsdu_mpdu(G1), 3000)
    r = J.r_dms(a.ctx())
    assert any('без принятого DMS' in m for _, m, _ in r.viol)


def test_judge_dms_registered():
    assert J.r_dms in J.RULES and {'dms_recipient', 'dms_group_copy'} <= {x[0] for x in J.NOT_CHECKABLE}
    assert F.is_group(G1)
