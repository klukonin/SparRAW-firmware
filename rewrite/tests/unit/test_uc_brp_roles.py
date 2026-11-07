# SPDX-License-Identifier: AGPL-3.0-or-later
"""Роли BRP после SLS в живом эфире двух узлов (air.Air, fw + uc каждого узла).

802.11-2020 10.42.3.1 [p. 1942]: «When the beam refinement occurs within the same allocation as the SLS, the SLS
initiator is the beam refinement initiator … The other STA is the beam refinement responder». 10.42.6.4.2: транзакцию
начинает инициатор кадром BRP с Initiator = 1 (9.4.2.129); ответчик отвечает кадрами с Initiator = 0. DTI в open —
CBAP Only (одно распределение до следующего BTI), поэтому после SLS в DTI кадр BRP с Initiator = 1 может слать только
инициатор этого SLS (передатчик ISS — SSW с Direction = 0, 9.5.1).

Стенд (assoc_*.pcap, 2026-11-04, судья эфира brp_role): после SLS, начатого AP, станция (ответчик SLS) шлёт 10 BRP с
Initiator = 1, AP — свои 10; после SLS станции AP шлёт BRP с Initiator = 1. Причина (uc bf.c
bf_sm_process_request_fifo, состояние 4 — итог TXSS ответчика): успешный SLS ответчика вёл в состояние 9 —
BRP инициатора (brp_init_flow) — так же, как у инициатора SLS."""
import pytest

import fwflows as F
from air import Air
from test_air import _node, BI_TU, WMI_CONNECT_EVENT, _live_data

FC_SSW = 0x0864                                   # Control Frame Extension 8 (табл. 9-2)


def roles(air):
    """Журнал эфира → (SLS: [(t, инициатор)], BRP: [(t, src, Initiator)], нарушения 10.42.3.1)."""
    sls, brp, bad = [], [], []
    last_ssw = None                                # (src, Direction) предыдущего SSW
    init = None                                    # инициатор последнего SLS
    for f in sorted(air.frames, key=lambda f: f['start']):
        fr, src = f['frame'], bytes(f['src'].mac)
        fc = int.from_bytes(fr[:2], 'little')
        if fc == FC_SSW:
            direction = fr[16] & 1                 # поле SSW (рис. 9-834): B0 Direction, 0 — инициатор
            if direction == 0 and last_ssw != (src, 0):
                init = src
                sls.append((f['start'], src))
            last_ssw = (src, direction)
            continue
        last_ssw = None
        if (fc >> 2) & 3 == 0 and (fc >> 4) & 0xf == 14 and len(fr) > 33 and fr[24] == 0x14 and fr[25] == 1:
            # Action No Ack, категория Unprotected DMG (20, табл. 9-51), BRP (9.6.21.3): тело — Category, Action, Dialog Token,
            # BRP Request (4), DMG Beam Refinement element: ID, Length, B0 Initiator (рис. 9-558)
            ini = fr[24 + 3 + 4 + 2] & 1
            brp.append((f['start'], src, ini))
            if init is None:
                continue
            if ini == 1 and src != init:
                bad.append('BRP Initiator=1 от ответчика SLS %s @%d' % (src.hex(), f['start'] // 165))
            if ini == 0 and src == init:
                bad.append('BRP Initiator=0 от инициатора SLS %s @%d' % (src.hex(), f['start'] // 165))
    return sls, brp, bad


@pytest.fixture(scope='module')
def assoc_air(fw_elf, build_dir, uc_fw):
    """Ассоциация в живом эфире (как test_air.test_live_association) и 15 мс после WMI_CONNECT_EVENT — BF станции
    после ассоциации (SLS, BRP), повторы серии."""
    import os
    import fwemu
    import ucemu
    fw_factory = lambda: fwemu.FW(fw_elf).boot()
    uc_factory = lambda: ucemu.UC(os.path.join(build_dir, 'uc.elf'), uc_fw)
    ap = _node(fw_factory, uc_factory, F.AP_MAC)
    sta = _node(fw_factory, uc_factory, F.STA_MAC)
    ap.bssid = sta.bssid = ap.mac
    with ap:
        F.Fw(ap.fw).set_mac(ap.mac)
        F.Fw(ap.fw).set_ssid(b'test')
        F.Fw(ap.fw).ap_start(bi=BI_TU)
    with sta:
        F.Fw(sta.fw).set_mac(sta.mac)
    ap.hw.backoff_seed, sta.hw.backoff_seed = 1, 1001
    ap.live()
    sta.live()
    sta.wmi(F.WMI_CONNECT, F.connect_cmd(bssid=ap.mac, ssid=b'test'))
    air = Air([ap, sta])
    for _ in range(80):
        air.run_us(500)
        if any(e.id == WMI_CONNECT_EVENT for e in sta.fw.wmi_evts):
            break
    air.run_us(15_000)
    return dict(air=air, ap=ap, sta=sta)


@pytest.mark.xdist_group('brp_roles_assoc')
def test_brp_initiator_is_sls_initiator_after_association(assoc_air):
    """10.42.3.1, 10.42.6.4.2: после каждого SLS ассоциации BRP с Initiator = 1 шлёт только инициатор SLS."""
    r = assoc_air
    sls, brp, bad = roles(r['air'])
    assert sls, 'SLS в эфире нет'
    assert brp, 'BRP в эфире нет'
    assert not bad, (bad[:6], [(t // 165, s.hex()) for t, s in sls])
    assert not r['ap'].hw.late and not r['sta'].hw.late


@pytest.mark.xdist_group('brp_roles_assoc')
def test_brp_responder_answers_initiator(assoc_air):
    """10.42.3.1 / 10.42.6.4.2: ответчик SLS — ответчик уточнения: на BRP инициатора с запросом приёмной тренировки
    (L-RX > 0) отвечает кадром BRP с Initiator = 0, своей транзакции не начинает."""
    sls, brp, bad = roles(assoc_air['air'])
    resp = [(t, s) for t, s, ini in brp if ini == 0]
    assert resp, ('ответа BRP ответчика нет', [(t // 165, s.hex(), i) for t, s, i in brp][:12])


@pytest.fixture(scope='module')
def bidir(fw_elf, build_dir, uc_fw):
    """Ассоциация, затем данные станция → AP и AP → станция (test_air._live_data): оба узла занимают среду."""
    return _live_data(fw_elf, build_dir, uc_fw)


@pytest.mark.xdist_group('brp_roles_bidir')
def test_brp_roles_bidirectional_traffic(bidir):
    """Двусторонний трафик: роли BRP по 10.42.3.1 при SLS любого из узлов; данные проходят в обе стороны."""
    r = bidir
    sls, brp, bad = roles(r['air'])
    assert not bad, bad[:6]
    assert [st for _, vr, st in r['sta'].host_done] == [0] * len(r['payloads'])
    assert len(r['ap'].host_done) == len(r['payloads']) and all(st == 0 for _, _, st in r['ap'].host_done)
    assert not r['ap'].hw.late and not r['sta'].hw.late
