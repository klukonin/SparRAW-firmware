# SPDX-License-Identifier: AGPL-3.0-or-later
"""Пир пропал в любой момент: fw сама обнаруживает потерю за ограниченное время, сообщает хосту, освобождает всё,
что было заведено на пира, не падает и не зависает, отвечает хосту и принимает следующее подключение как первое.

«Пропал» (fwflows.peer_gone): с выбранного шага пир молчит — кадры к нему без Ack (код ошибки дескриптора TX),
BF/SLS к нему — неудача (uc BF_DONE со статусом 0), keep-alive без ответа (бит cid в ll_ctx.pending_mask остаётся,
uc/tx.c), маяков нет (каждый BI — статистика uc 0x17 без маяка). uc и MAC живы; TSF идёт вместе со временем u_schd
(fwflows.run_tsf) — детекторы потери линка считают по TSF.

Сроки — из параметров fw (fw_data / ll_cfg_presets, читаются из fw.elf):
  * AP: детектор плохих маяков у точки выключен (набор поддержания 0, flags 0x3: старение TX + keep-alive,
    conn_mgr_system_state_evt_handler → link_maintain_cfg_apply, fw/l2mgr.c). Молчащую станцию без данных ловит
    цепочка keep-alive → старение: простой копится до ka_period_hi (30 с), команда uc 0x26, Ack нет — бит cid в
    pending_mask, детектор старения копит простой до ageing_thr (60 с) → conn_disconnect (fw/link_loss.c). С данными
    хоста в кольце — сразу старение (60 с). Срок: ka_period_hi + ageing_thr + 3 периода детекторов + pring_stop_timeout
    (остановка pring при разрыве) ≈ 90,5 с. Эмуляция идёт ~2,5 с на секунду при соединении, поэтому пороги старения и
    keep-alive в тестах AP укорочены в SCALE раз (fwflows.scale_link_loss), срок — так же.
  * STA: плохие маяки (набор 2: bcn_thr × conn_multi_omni_count BI подряд без маяка, ≈ 2,15 с), таймер ассоциации
    mlme_assoc_timeout_ms (3 с), BF линк-апа / первого BF сопровождения — lm_linkup_fail_max / link_first_fbf_max_tries
    неудач подряд. Пороги не укорочены.
Проверка «после»: idle_state как test_fw_conn_cleanup (AP — равно «AP запущена, станций нет», STA — «после загрузки»),
uc о станции ничего не держит, WMI_ECHO отвечает, точка не остановлена, следующее подключение — как первое.
Найденное отклонение — xfail(strict=True) с местом в коде и точкой исправления.
"""
import functools, struct

import pytest

import fwemu
import fwflows as F

CID = 0
WMI_ECHO, WMI_ECHO_RSP = 0x803, 0x1803
WMI_PCP_STOPPED = 0x1919
SCALE = 1                         # AP: пороги старения / keep-alive (наборы поддержания — 5 с / 1 с) — без укорочения
QUIESCE_US = 5_000_000            # окно проверки частоты ложных тревог (4,5 с, l2mgr_link_lost_radio_cb) истекает само
TICK_US = 16
# Как в test_fw_conn_cleanup: очереди TX fw останавливаются вместе с каналом и включаются следующим переключением.
# ka_cnt — статистика срабатываний keep-alive (диагностика), обнуляется в начале мониторинга следующего соединения
# (ka_necessity_detector_start_monitoring, fw/link_loss.c); следующее подключение это проверяет (_rejoin / _reconnect).
IGNORE = ('tx_api_mgmt.state', 'tx_api_2.state', 'tx_api_data.state', 'll_ctx.ka_cnt[cid]')
FATAL = (fwemu.FwAssert, fwemu.SmError, fwemu.SpinError)


def _preset(fw, idx, off):
    return fw.r32(fw.a('ll_cfg_presets') + 0x24 * idx + off)


def ap_bound_us(fw):
    """Срок обнаружения пропавшей станции точкой: после ассоциации — набор поддержания 0 (в тесте укорочен); после SLS
    в A-BFT без Assoc Request — ожидание запроса CONN_ASSOC_WAIT_US (10 с, fw/conn.c)."""
    period, ka, ageing = _preset(fw, 0, 0x04), _preset(fw, 0, 0x0c), _preset(fw, 0, 0x08)
    return max(ka + ageing + 3 * period, 10_000_000) + \
        fw.r32(fw.a('pring_stop_timeout'))


def sta_bound_us(fw):
    """Срок обнаружения пропавшей точки станцией: таймер ассоциации или BI без маяка до порога (набор 2) и остановка
    pring; + BI."""
    bis = _preset(fw, 2, 0x1c) * fw.r8(fw.a('conn_multi_omni_count')) + 1
    return max(fw.r32(fw.a('mlme_assoc_timeout_ms')) * 1000,
               bis * F.BI_US + fw.r32(fw.a('pring_stop_timeout'))) + F.BI_US


def _disc_evts(fw, n0, peer=None):
    """[(тик, событие)] WMI_DISCONNECT_EVENT начиная с n0 (peer — только с этим MAC в теле)."""
    return [(fw.evt_time[i], e) for i, e in enumerate(fw.wmi_evts) if i >= n0 and e.id == F.EV_DISCONNECT
            and (peer is None or bytes(peer) in e.body)]


def _echo(fw):
    ev = fw.wmi(WMI_ECHO, struct.pack('<I', 0x5a5a1234))
    return [(e.id, struct.unpack_from('<I', e.body, 0)[0]) for e in ev]


def _record(fw, n_cmd, n_evt):
    return ([c.type for c in fw.lmac_cmds[n_cmd:]], [e.id for e in fw.wmi_evts[n_evt:]])


# =============================== AP: станция пропала ===============================

def _ap_fresh(elf):
    fw = fwemu.FW(elf).boot()
    F.run_tsf(fw)
    F.scale_link_loss(fw, SCALE)
    F.track_event_times(fw)
    w = F.Fw(fw)
    w.ap_start()
    return w


def _gone(w, macs=(F.STA_MAC,), cids=(CID,)):
    fw = w.fw
    F.peer_gone(fw, macs, cids)
    w.t0, w.n0 = fw.now(), len(fw.wmi_evts)


def _assoc_req(w, peer=F.STA_MAC, cid=CID):
    fw = w.fw
    own = w.own_mac()
    req = struct.pack('<HH', 0x10, 1)                         # Capability, Listen Interval (9.3.3.6)
    fw.call('rx_pkt_handler', fw.rx_pkt(fw.mgmt_frame(0, own, peer, own, req), cid=cid))
    fw.run_tasks()


def _abft_bf(w, peer=F.STA_MAC):
    w.fw.lmac_evt(0x05, F.bf_done(F.SPARRAW_PEER_UNKNOWN, peer, 1, 2))
    F.settle(w.fw)


def _joined(w):
    w.ap_sta_join()
    w.sta_add_vring()


def ap_assoc_resp_unacked(w):
    """(a) Assoc Request принят, станция пропала до Ack на Assoc Response (повторы TX, затем отказ ассоциации)."""
    _abft_bf(w)
    _assoc_req(w)
    _gone(w)


def ap_after_assoc_before_port(w):
    """(b) Assoc Response подтверждён, станция пропала до первого BF сопровождения, порта данных и ключа."""
    _abft_bf(w)
    _assoc_req(w)
    w.fw.tx_complete('tx_api_mgmt')
    _gone(w)


def ap_after_abft_sls(w):
    """(c) SLS в A-BFT прошёл (соединение заведено, uc: запись станции включена), Assoc Request так и не пришёл."""
    _abft_bf(w)
    _gone(w)


def ap_link_lost_during_bf(w):
    """(c) Станция ассоциирована, пропала во время BF сопровождения: uc LINK_LOST (0x09, подтверждено), повторные BF
    без ответа."""
    _joined(w)
    _gone(w)
    w.fw.lmac_evt(0x09, struct.pack('<III', CID, 0, 1))


def ap_during_addba(w):
    """(d) Хост включил BA (WMI_VRING_BA_EN): ADDBA Request без Ack."""
    _joined(w)
    _gone(w)
    w.fw.wmi(F.WMI_VRING_BA_EN, struct.pack('<BBHB3x', 0, 32, 0, 0))


def _ba_agreed(w, peer, own, bssid):
    """WMI_VRING_BA_EN → ADDBA Request (Ack) → ADDBA Response пира (9.6.4.3) — стрим кольца 0 в BA_AGREED."""
    fw = w.fw
    fw.wmi(F.WMI_VRING_BA_EN, struct.pack('<BBHB3x', 0, 32, 0, 0))
    F.settle(fw)
    req = [f for _, f in fw.tx_frames if f[0] == 0xd0 and f[0x18:0x1a] == b'\x03\x00'][-1]
    body = bytes([3, 1, req[0x1a]]) + struct.pack('<HHH', 0, 32 << 6, 0)
    fw.call('stream_mgr_action', fw.rx_pkt(fw.mgmt_frame(13, own, peer, bssid, body), cid=CID))
    fw.run_tasks()
    F.settle(fw)
    assert fw.r8(fw.r32(fw.a('stream_by_vr')) + 0x10) == 2, 'BA не согласован'


def ap_ba_agreed(w):
    """BA согласован (TX-стрим к станции), станция пропала: DELBA при разрыве без Ack."""
    _joined(w)
    own = w.own_mac()
    _ba_agreed(w, F.STA_MAC, own, own)
    _gone(w)


def ap_under_data(w):
    """(e) В кольце хоста к станции данные (vring привязан к pring), Ack нет."""
    _joined(w)
    _gone(w)
    F.host_tx_pending(w.fw, 0)


def ap_idle_no_data(w):
    """Станция ассоциирована, трафика нет — пропала (keep-alive без ответа → старение)."""
    _joined(w)
    _gone(w)


def ap_disconnect_sta_unacked(w):
    """(f) Хост: WMI_DISCONNECT_STA, а станции уже нет — Disassociation без Ack."""
    _joined(w)
    _gone(w)
    w.fw.wmi(F.WMI_DISCONNECT_STA, F.STA_MAC + struct.pack('<H', 3))



def _xf(reason, raises=AssertionError):
    return pytest.mark.xfail(strict=True, raises=raises, reason=reason)


# (имя, сценарий, хосту сообщено о станции (CONNECT_EVENT ушёл до пропажи))
AP_PATHS = [
    ('assoc_resp_unacked', ap_assoc_resp_unacked, False),
    ('after_assoc_before_port', ap_after_assoc_before_port, False),
    ('after_abft_sls', ap_after_abft_sls, False),
    ('link_lost_during_bf', ap_link_lost_during_bf, True),
    ('during_addba', ap_during_addba, True),
    ('ba_agreed', ap_ba_agreed, True),
    ('under_data', ap_under_data, True),
    ('idle_no_data', ap_idle_no_data, True),
    ('disconnect_sta_unacked', ap_disconnect_sta_unacked, True),
]
_AP = {n: (f, told) for n, f, told in AP_PATHS}


NEWCOMER = bytes([0x04, 0xd4, 0xc4, 0x55, 0x77, 0x01])


def _join_record(w, peer):
    """Вход станции peer (BF в A-BFT → Assoc Request → …): (cid, msm, mlme), (команды uc, события хосту)."""
    fw = w.fw
    nc, ne = len(fw.lmac_cmds), len(fw.wmi_evts)
    _abft_bf(w, peer)
    cid = w.cid_of(peer)
    if cid is None:
        return (None, None, None), _record(fw, nc, ne)
    _assoc_req(w, peer, cid)
    F.settle(fw)
    conn = w.conn_by_cid(cid)
    return (cid, w.msm(conn), w.mlme(conn)), _record(fw, nc, ne)


@functools.lru_cache(maxsize=None)
def _ap_reference_join(elf):
    """Первая станция на свежей точке: cid, состояние, команды uc и события хосту."""
    return _join_record(_ap_fresh(elf), NEWCOMER)


@functools.lru_cache(maxsize=None)
def _ap_path(elf, name):
    w = _ap_fresh(elf)
    fw = w.fw
    r = {'ap_idle': F.idle_state(fw), 'bound': ap_bound_us(fw)}
    r['uc0'] = F.uc_station(list(fw.boot_lmac_cmds) + list(fw.lmac_cmds), CID)
    try:
        _AP[name][0](w)
        F.settle(fw)
        fw.advance(r['bound'] + F.BI_US, between=F.settle)
        r['disc'] = [((t - w.t0) & F.M32) * TICK_US for t, _ in _disc_evts(fw, w.n0)]
        r['disc_other'] = [e.body.hex() for _, e in _disc_evts(fw, w.n0) if F.STA_MAC not in e.body]
        fw.advance(QUIESCE_US, between=F.settle)
        r['after'] = F.idle_state(fw)
        r['uc'] = F.uc_station(list(fw.boot_lmac_cmds) + list(fw.lmac_cmds), CID)
        r['wild'] = list(fw.wild)
        r['pcp_stopped'] = WMI_PCP_STOPPED in [e.id for e in fw.wmi_evts[w.n0:]]
        r['bss_mode'] = w.bss_mode()
        r['echo'] = _echo(fw)
        # входит новая станция
        F.peer_back(fw)
        r['rejoin'] = _join_record(w, NEWCOMER)
        r['ka_cnt'] = fw.r32(fw.a('ll_ctx') + 0x1c4 + 4 * CID)
    except FATAL as e:
        r['exc'] = e
    return r


def _ap(elf, name):
    r = _ap_path(elf, name)
    if 'exc' in r:
        raise r['exc']
    return r


def _p(name, xfails=None):
    marks = [_xf(xfails[name])] if xfails and name in xfails else []
    return pytest.param(name, id=name, marks=marks)


@pytest.mark.parametrize('path', [_p(n) for n, _, _ in AP_PATHS])
def test_ap_station_vanish_disconnect_once_in_bound(fw_elf, path):
    """Хосту — ровно одно WMI_DISCONNECT_EVENT этой станции не позже срока (если о станции хосту не сообщали —
    не больше одного); о других станциях — ничего."""
    r = _ap(fw_elf, path)
    told = _AP[path][1]
    disc = r['disc']
    assert not r['disc_other'], 'разрыв чужой станции: %s' % r['disc_other']
    if told:
        assert len(disc) == 1, 'WMI_DISCONNECT_EVENT хосту: %d раз за %d мкс' % (len(disc), r['bound'])
    else:
        assert len(disc) <= 1, 'WMI_DISCONNECT_EVENT хосту: %d раз' % len(disc)
    assert all(t <= r['bound'] for t in disc), 'разрыв через %s мкс, срок %d мкс' % (disc, r['bound'])


@pytest.mark.parametrize('path', [_p(n) for n, _, _ in AP_PATHS])
def test_ap_station_vanish_resources_released(fw_elf, path):
    """После срока: состояние — «AP запущена, станций нет» (cid, conn, ранг, пулы, стримы, таймеры, ll_ctx), uc о
    станции ничего не держит (запись выключена, сопровождение снято, ключ недействителен, MAC-очереди — как до
    станции), обращений вне карты памяти нет."""
    r = _ap(fw_elf, path)
    diff = F.state_diff(r['ap_idle'], r['after'], IGNORE)
    assert not diff, 'после пропажи станции (%s) не снято: %s' % (path, diff)
    uc = r['uc']
    assert (uc['enabled'], uc['maint'], uc['key_valid']) == (False, False, False), uc
    assert uc['queues'] == r['uc0']['queues'], (uc, r['uc0'])
    assert not r['wild'], 'обращения вне карты памяти: %s' % r['wild'][:4]


@pytest.mark.parametrize('path', [_p(n) for n, _, _ in AP_PATHS])
def test_ap_station_vanish_ap_keeps_serving(fw_elf, path):
    """Точка работает дальше: BSS не остановлен (режим AP, PCP_STOPPED не было, pcp_started — в idle_state), WMI_ECHO
    отвечает, новая станция входит так же, как первая на свежей точке: тот же cid, KEY_ASSOC / ASSOCIATED, те же
    команды uc и события хосту; счётчики keep-alive — с нуля."""
    r = _ap(fw_elf, path)
    assert not r['pcp_stopped'] and r['bss_mode'] in (2, 3), (r['pcp_stopped'], r['bss_mode'])
    assert r['echo'] == [(WMI_ECHO_RSP, 0x5a5a1234)], r['echo']
    ref_state, (ref_cmds, ref_evts) = _ap_reference_join(fw_elf)
    state, (cmds, evts) = r['rejoin']
    assert state == ref_state, 'повторный вход: (cid, msm, mlme) %s, с загрузки %s' % (state, ref_state)
    assert [hex(t) for t in cmds] == [hex(t) for t in ref_cmds]
    assert [hex(i) for i in evts] == [hex(i) for i in ref_evts]
    assert r['ka_cnt'] == 0


# ---- несколько станций: пропала одна ----

VICTIM = F.SPARRAW_MAX_STA // 2


def _sta_mac(i):
    return bytes([0x04, 0xd4, 0xc4, 0x55, 0x66, 0x10 + i])


@pytest.fixture(scope='module')
def ap_full(fw_elf):
    """Точка с SPARRAW_MAX_STA станциями, станция VICTIM пропала; срок обнаружения прошёл."""
    w = _ap_fresh(fw_elf)
    fw = w.fw
    for i in range(F.SPARRAW_MAX_STA):
        w.ap_sta_join(peer=_sta_mac(i), cid=i)
        w.sta_add_vring(cid=i, ringid=i)
    cmds0 = list(fw.boot_lmac_cmds) + list(fw.lmac_cmds)
    _gone(w, macs=(_sta_mac(VICTIM),), cids=(VICTIM,))
    bound = ap_bound_us(fw)
    fw.advance(bound + F.BI_US, between=F.settle)
    return w, cmds0, bound


def test_ap_one_of_max_sta_vanishes_only_it_disconnected(ap_full):
    w, _, bound = ap_full
    fw = w.fw
    disc = _disc_evts(fw, w.n0)
    assert [bytes(_sta_mac(VICTIM)) in e.body for _, e in disc] == [True], [e.body.hex() for _, e in disc]
    assert ((disc[0][0] - w.t0) & F.M32) * TICK_US <= bound
    assert w.conn_by_cid(VICTIM) == 0
    uc = F.uc_station(list(fw.boot_lmac_cmds) + list(fw.lmac_cmds), VICTIM)
    assert (uc['enabled'], uc['maint'], uc['key_valid']) == (False, False, False), uc


def test_ap_one_of_max_sta_vanishes_others_unaffected(ap_full):
    """Остальные станции: соединение то же, KEY_ASSOC / ASSOCIATED, uc держит запись и сопровождение, стрим на месте."""
    w, _, _ = ap_full
    fw = w.fw
    cmds = list(fw.boot_lmac_cmds) + list(fw.lmac_cmds)
    for i in range(F.SPARRAW_MAX_STA):
        if i == VICTIM:
            continue
        c = w.conn_by_cid(i)
        assert c and fw.rbytes(c + F.C_PEER, 6) == _sta_mac(i), 'cid %d' % i
        assert (w.msm(c), w.mlme(c)) == (F.MSM_KEY_ASSOC, F.MLME_ASSOCIATED), 'cid %d' % i
        uc = F.uc_station(cmds, i)
        assert (uc['enabled'], uc['maint']) == (True, True), (i, uc)
        assert fw.r32(fw.a('stream_by_vr') + 4 * i) != 0, 'стрим кольца %d снят' % i


def test_ap_one_of_max_sta_vanishes_slot_reused(ap_full):
    """Новая станция занимает освободившийся cid и проходит вход до KEY_ASSOC; WMI_ECHO отвечает."""
    w, _, _ = ap_full
    fw = w.fw
    assert _echo(fw) == [(WMI_ECHO_RSP, 0x5a5a1234)]
    F.peer_back(fw)                                          # модель: cid VICTIM теперь у живой станции
    conn = w.ap_sta_join(peer=NEWCOMER, cid=VICTIM)
    assert (w.msm(conn), w.mlme(conn)) == (F.MSM_KEY_ASSOC, F.MLME_ASSOCIATED)


# ---- PCP_STOP, когда станция пропала ----

@pytest.mark.parametrize('path', ['after_abft_sls', 'idle_no_data'])
def test_ap_pcp_stop_after_station_vanished_returns_to_boot(fw_elf, path):
    """Хост останавливает точку, а станция пропала (Disassociation без Ack): WMI_PCP_STOPPED — один раз, не позже
    1 с (предел повторов l2mgr_pcp_stop_try), состояние — «после загрузки», BSS снова STA."""
    boot = F.idle_state(fwemu.FW(fw_elf).boot())
    w = _ap_fresh(fw_elf)
    fw = w.fw
    _AP[path][0](w)
    F.settle(fw)
    fw.wmi(F.WMI_PCP_STOP)
    F.settle(fw)
    fw.advance(1_000_000, between=F.settle)
    assert [e.id for e in fw.wmi_evts[w.n0:]].count(WMI_PCP_STOPPED) == 1
    fw.advance(QUIESCE_US, between=F.settle)
    assert F.state_diff(boot, F.idle_state(fw), IGNORE) == []
    assert w.bss_mode() == 1


def test_ap_max_sta_ghosts_do_not_block_new_station(fw_elf):
    """SPARRAW_MAX_STA станций прошли SLS в A-BFT и пропали без Assoc Request (их соединения ещё ждут запроса — до
    CONN_ASSOC_WAIT_US, fw/conn.c); новая станция всё равно входит до KEY_ASSOC / ASSOCIATED: при полной базе неассоциированное соединение замещается
    по рангу, ёмкость ассоциаций (mid_count_active_conns) призраков не считает."""
    w = _ap_fresh(fw_elf)
    fw = w.fw
    ghosts = [_sta_mac(i) for i in range(F.SPARRAW_MAX_STA)]
    for m in ghosts:
        _abft_bf(w, m)
    _gone(w, macs=ghosts, cids=range(F.SPARRAW_MAX_STA))
    fw.advance(ap_bound_us(fw) + F.BI_US, between=F.settle)
    F.peer_back(fw)
    state, _ = _join_record(w, NEWCOMER)
    assert state[0] is not None and state[1:] == (F.MSM_KEY_ASSOC, F.MLME_ASSOCIATED), \
        'новая станция не вошла: (cid, msm, mlme) %s; занято cid: %d' % (
            state, sum(1 for i in range(F.SPARRAW_MAX_STA) if w.conn_by_cid(i)))


# ---- станция пропала и вернулась раньше, чем точка это заметила ----

def test_ap_station_returns_before_detected_is_answered(fw_elf):
    """Станция пропала и через 100 мс (раньше срока обнаружения) вернулась: SLS в A-BFT, Assoc Request — точка
    отвечает Association Response (Status 0) без Disassociation, станция — KEY_ASSOC / ASSOCIATED."""
    w = _ap_fresh(fw_elf)
    fw = w.fw
    fw.wmi(0x85b, struct.pack('<B3x', 1))          # WMI_REASSOC_INPLACE_CFG — наш драйвер шлёт его после PCP_START
    _joined(w)
    _gone(w)
    fw.advance(100_000, between=F.settle)
    assert w.cid_of(F.STA_MAC) is not None, 'точка уже сняла станцию — сценарий не тот'
    F.peer_back(fw)
    fw.tx_frames.clear()
    _abft_bf(w)
    _assoc_req(w, cid=w.cid_of(F.STA_MAC))
    F.settle(fw)
    to_sta = [f for _, f in fw.tx_frames if f[4:10] == F.STA_MAC]
    stypes = [(f[0] >> 4) & 0xf for f in to_sta if f[0] & 0x0c == 0]
    assert 10 not in stypes, 'станции ушла Disassociation в ответ на Assoc Request'
    resp = [f for f in to_sta if f[0] == 0x10]
    assert resp and struct.unpack_from('<H', resp[-1], 0x1a)[0] == 0, 'нет Association Response (Status 0)'
    cid = w.cid_of(F.STA_MAC)
    assert cid is not None
    conn = w.conn_by_cid(cid)
    assert (w.msm(conn), w.mlme(conn)) == (F.MSM_KEY_ASSOC, F.MLME_ASSOCIATED)


# =============================== STA: точка пропала ===============================

AP = F.AP_MAC


def _sta_fresh(elf):
    fw = fwemu.FW(elf).boot()
    F.run_tsf(fw)
    F.track_event_times(fw)
    return F.Fw(fw)


def _sta_gone(w):
    _gone(w, macs=(AP,), cids=(CID,))


def _connect_until_new_link(w):
    fw = w.fw
    fw.wmi(F.WMI_CONNECT, F.connect_cmd())
    F.settle(fw)


def sta_bf_no_event(w):
    """Скан/SLS к точке: uc так и не сообщил о новой связи (точки нет)."""
    _connect_until_new_link(w)
    _sta_gone(w)


def sta_bf_failed(w):
    """Скан/SLS к точке: uc сообщил о новой связи с неудачей (NEW_LINK, статус 0)."""
    _connect_until_new_link(w)
    _sta_gone(w)
    w.fw.lmac_evt(0x05, F.bf_done(CID, AP, status=0))


def sta_after_bf_no_beacon(w):
    """SLS прошёл (NEW_LINK), точка пропала до маяка."""
    _connect_until_new_link(w)
    w.fw.lmac_evt(0x05, F.bf_done(CID, AP))
    _sta_gone(w)


def sta_after_beacon_linkup_bf(w):
    """Маяк пойман, точка пропала: BF линк-апа без ответа."""
    fw = w.fw
    _connect_until_new_link(w)
    fw.lmac_evt(0x05, F.bf_done(CID, AP))
    _sta_gone(w)
    fw.call('basic_sm_handle_event', w.conn_by_cid(CID) + F.C_MSM, 1, 1, 0, 0)
    fw.run_tasks()


def sta_assoc_req_unacked(w):
    """BF линк-апа прошёл, Assoc Request ушёл — Ack нет (повторы TX, таймер ассоциации)."""
    fw = w.fw
    _connect_until_new_link(w)
    fw.lmac_evt(0x05, F.bf_done(CID, AP))
    fw.call('basic_sm_handle_event', w.conn_by_cid(CID) + F.C_MSM, 1, 1, 0, 0)
    fw.run_tasks()
    F.settle(fw, tx=False)                                   # uc: BF линк-апа; Assoc Request в кольце TX
    _sta_gone(w)


def sta_no_assoc_resp(w):
    """Assoc Request подтверждён, Assoc Response нет."""
    w.sta_connect(stop='assoc_req')
    _sta_gone(w)


def sta_right_after_assoc(w):
    """Assoc Response принят, точка пропала до первого BF сопровождения."""
    fw = w.fw
    w.sta_connect(stop='assoc_req')
    body = struct.pack('<HHH', 0x10, 0, 1)
    fw.call('rx_pkt_handler', fw.rx_pkt(fw.mgmt_frame(1, F.OWN_MAC, AP, AP, body), cid=CID))
    fw.run_tasks()
    _sta_gone(w)


def sta_under_data(w):
    """Соединение с данными хоста в кольце — точка пропала (маяков нет, Ack нет)."""
    w.sta_connect()
    w.sta_add_vring()
    _sta_gone(w)
    F.host_tx_pending(w.fw, 0)


def sta_during_addba(w):
    w.sta_connect()
    w.sta_add_vring()
    _sta_gone(w)
    w.fw.wmi(F.WMI_VRING_BA_EN, struct.pack('<BBHB3x', 0, 32, 0, 0))


def sta_ba_agreed(w):
    w.sta_connect()
    w.sta_add_vring()
    _ba_agreed(w, AP, F.OWN_MAC, AP)
    _sta_gone(w)


def sta_during_disconnect(w):
    """Хост: WMI_DISCONNECT, точки уже нет — Disassociation без Ack."""
    w.sta_connect()
    w.sta_add_vring()
    _sta_gone(w)
    w.fw.wmi(F.WMI_DISCONNECT)


STA_PATHS = [
    ('bf_no_event', sta_bf_no_event),
    ('bf_failed', sta_bf_failed),
    ('after_bf_no_beacon', sta_after_bf_no_beacon),
    ('after_beacon_linkup_bf', sta_after_beacon_linkup_bf),
    ('assoc_req_unacked', sta_assoc_req_unacked),
    ('no_assoc_resp', sta_no_assoc_resp),
    ('right_after_assoc', sta_right_after_assoc),
    ('under_data', sta_under_data),
    ('during_addba', sta_during_addba),
    ('ba_agreed', sta_ba_agreed),
    ('during_disconnect', sta_during_disconnect),
]
_STA = dict(STA_PATHS)


def _connect_record(w):
    fw = w.fw
    nc, ne = len(fw.lmac_cmds), len(fw.wmi_evts)
    conn = w.sta_connect()
    w.sta_add_vring()
    return _record(fw, nc, ne), (w.msm(conn), w.mlme(conn), w.bss_state())


@functools.lru_cache(maxsize=None)
def _sta_reference(elf):
    return _connect_record(_sta_fresh(elf))


@functools.lru_cache(maxsize=None)
def _sta_path(elf, name):
    w = _sta_fresh(elf)
    fw = w.fw
    r = {'boot': F.idle_state(fw), 'bound': sta_bound_us(fw), 'uc0': F.uc_station(fw.boot_lmac_cmds, CID)}
    try:
        _STA[name](w)
        F.settle(fw)
        fw.advance(r['bound'] + F.BI_US, between=F.settle)
        r['disc'] = [((t - w.t0) & F.M32) * TICK_US for t, _ in _disc_evts(fw, w.n0)]
        r['disc_before'] = len(_disc_evts(fw, 0)) - len(r['disc'])
        fw.advance(QUIESCE_US, between=F.settle)
        r['after'] = F.idle_state(fw)
        r['scan_connected'] = fw.call('mid_list_any_in_state2')
        r['uc'] = F.uc_station(list(fw.boot_lmac_cmds) + list(fw.lmac_cmds), CID)
        r['wild'] = list(fw.wild)
        r['echo'] = _echo(fw)
        F.peer_back(fw)
        fw._uc_seen = len(fw.lmac_cmds)
        r['reconnect'] = _connect_record(w)
        r['ka_cnt'] = fw.r32(fw.a('ll_ctx') + 0x1c4 + 4 * CID)
    except FATAL as e:
        r['exc'] = e
    return r


def _sta(elf, name):
    r = _sta_path(elf, name)
    if 'exc' in r:
        raise r['exc']
    return r


@pytest.mark.parametrize('path', [_p(n) for n, _ in STA_PATHS])
def test_sta_ap_vanish_disconnect_once_in_bound(fw_elf, path):
    """Подключение начал хост — ровно одно WMI_DISCONNECT_EVENT за всё время, не позже срока после пропажи."""
    r = _sta(fw_elf, path)
    n = r['disc_before'] + len(r['disc'])
    assert n == 1, 'WMI_DISCONNECT_EVENT хосту: %d раз (после пропажи — через %s мкс)' % (n, r['disc'])
    assert all(t <= r['bound'] for t in r['disc']), 'разрыв через %s мкс, срок %d мкс' % (r['disc'], r['bound'])


@pytest.mark.parametrize('path', [_p(n) for n, _ in STA_PATHS])
def test_sta_ap_vanish_returns_to_idle(fw_elf, path):
    """Состояние — «после загрузки» (idle_state), START_SCAN — не «скан при соединении», uc о станции ничего не держит,
    обращений вне карты памяти нет, WMI_ECHO отвечает."""
    r = _sta(fw_elf, path)
    diff = F.state_diff(r['boot'], r['after'], IGNORE)
    assert not diff, 'после пропажи точки (%s) не сброшено: %s' % (path, diff)
    assert r['scan_connected'] == 0
    assert r['uc'] == r['uc0'], (r['uc'], r['uc0'])
    assert not r['wild'], 'обращения вне карты памяти: %s' % r['wild'][:4]
    assert r['echo'] == [(WMI_ECHO_RSP, 0x5a5a1234)], r['echo']


@pytest.mark.parametrize('path', [_p(n) for n, _ in STA_PATHS])
def test_sta_ap_vanish_reconnect_same_as_first(fw_elf, path):
    """Точка вернулась: подключение — те же команды uc и события хосту, что первое с загрузки; KEY_ASSOC /
    ASSOCIATED, BSS активен; счётчики keep-alive — с нуля."""
    r = _sta(fw_elf, path)
    (ref_cmds, ref_evts), ref_state = _sta_reference(fw_elf)
    (cmds, evts), state = r['reconnect']
    assert state == ref_state == (F.MSM_KEY_ASSOC, F.MLME_ASSOCIATED, F.BSS_ACTIVE), (state, ref_state)
    assert [hex(t) for t in cmds] == [hex(t) for t in ref_cmds]
    assert [hex(i) for i in evts] == [hex(i) for i in ref_evts]
    assert r['ka_cnt'] == 0
