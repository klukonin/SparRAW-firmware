# SPDX-License-Identifier: AGPL-3.0-or-later
"""Состояние fw после разрыва соединения: всё, что было заведено на соединение, возвращается к состоянию «после
загрузки» (или «AP запущена, станций нет»), и следующее подключение идёт так же, как первое.

Прежняя ошибка этого класса: mid_list_remove_entry оставлял bss.state = 2 после разрыва — следующий START_SCAN шёл
как «скан при соединении», хост больше не подключался (исправлено: сброс bss.state в mid_list_remove_entry). Здесь каждый путь разрыва доводится через
настоящие обработчики (WMI хоста, события uc, принятые кадры, таймеры u_schd — fwflows.py), затем:
  * idle — поля из fwflows.idle_state (записи mid, база соединений, пулы, запросы радио, таймеры/задачи u_schd,
    стримы, очереди TX, счётчики поддержания линка станции в общей с uc памяти, флаги l2mgr) равны «после загрузки»;
  * reconnect — новое подключение к тому же пиру даёт те же команды uc и события хосту, что первое с загрузки;
  * хосту ушло ровно одно WMI_DISCONNECT_EVENT; START_SCAN после разрыва — не «скан при соединении».
Найденный остаток — xfail(strict=True) с полем, путём, последствием и местом, где его надо сбросить.
"""
import functools, struct

import pytest

import fwemu
import fwflows as F

# Очереди TX управления/данных останавливаются вместе с каналом (radio_mgr_unset_primary_channel при разрыве STA,
# pcp_stop_flow) и включаются следующим переключением канала (CONNECT/PCP_START); после загрузки канала ещё не было,
# очереди «включены». Следующее подключение это проверяет (reconnect).
IGNORE_TX_STATE = ('tx_api_mgmt.state', 'tx_api_2.state', 'tx_api_data.state')
RANK = ('conn_mgr.rank_pool.used', 'conn_mgr.rank_list.count')
QUIESCE_US = 5_000_000
CID = 0


def _assoc_resp(w, status=0, aid=1):
    fw = w.fw
    body = struct.pack('<HHH', 0x10, status, aid)           # Capability, Status Code, AID (9.3.3.7)
    fw.call('rx_pkt_handler', fw.rx_pkt(fw.mgmt_frame(1, F.OWN_MAC, F.AP_MAC, F.AP_MAC, body), cid=CID))
    fw.run_tasks()


def _disassoc_from(w, peer, da, bssid, reason):
    fw = w.fw
    fw.call('rx_pkt_handler', fw.rx_pkt(fw.mgmt_frame(10, da, peer, bssid, struct.pack('<H', reason)), cid=CID))
    fw.run_tasks()


def _no_beacon_bis(w, limit=64):
    """BI без маяка пира: событие uc 0x17 (статистика BI → sys_state 22 → детектор плохих маяков) при
    mac_mon_pub.bti.detected = 0 — до разрыва."""
    for _ in range(limit):
        w.fw.lmac_evt(0x17)
        F.settle(w.fw)
        c = w.conn_by_cid(CID)
        if not c or w.msm(c) == F.MSM_WAIT_FOR_DISCONN:
            return
    raise AssertionError('нет разрыва за %d BI без маяка' % limit)


# ---- пути разрыва STA (подключение — fwflows.Fw.sta_connect; кольцо данных cid 0 — как у драйвера) ----

def sta_wmi_disconnect(w):
    w.sta_connect(); w.sta_add_vring()
    w.fw.wmi(F.WMI_DISCONNECT)


def sta_assoc_timeout(w):
    """Assoc Response нет: таймер ассоциации MLME (mlme_assoc_timeout_ms)."""
    w.sta_connect(stop='assoc_req')
    assert w.fw.fire_timer('mlme_assoc_timeout_cb')


def sta_assoc_reject(w):
    """AP отказал: Assoc Response со Status Code 37 (9.4.1.9, REQUEST_DECLINED)."""
    w.sta_connect(stop='assoc_req')
    _assoc_resp(w, status=37, aid=0)


def sta_disconnect_during_assoc(w):
    """WMI_DISCONNECT, пока ждём Assoc Response."""
    w.sta_connect(stop='assoc_req')
    w.fw.wmi(F.WMI_DISCONNECT)


def sta_disconnect_waiting_radio(w):
    """WMI_DISCONNECT сразу за WMI_CONNECT — радио ещё не выдано (l2mgr_connect_waiting_radio)."""
    w.fw.wmi(F.WMI_CONNECT, F.connect_cmd())
    w.fw.wmi(F.WMI_DISCONNECT)


def sta_peer_disassoc(w):
    """Disassociation от AP (9.3.3.5, причина 3)."""
    w.sta_connect(); w.sta_add_vring()
    _disassoc_from(w, F.AP_MAC, F.OWN_MAC, F.AP_MAC, 3)


def sta_no_beacons(w):
    """Потеря линка: маяков AP нет (детектор плохих маяков, ll_ctx.bcn_cnt > bcn_thr)."""
    w.sta_connect(); w.sta_add_vring()
    _no_beacon_bis(w)


def sta_link_lost_then_no_beacons(w):
    """uc: LINK_LOST (событие 0x09, подтверждено), BF к пиру не проходит, затем BI без маяков."""
    w.sta_connect(); w.sta_add_vring()
    w.fw.uc_bf_status = 0
    w.fw.lmac_evt(0x09, struct.pack('<III', CID, 0, 1))
    F.settle(w.fw)
    _no_beacon_bis(w)
    w.fw.uc_bf_status = 1


def sta_beacon_timeout(w):
    """После BF новой связи маяка пира нет: таймер conn_main_sm_bcon_rx_timeout_evt по всем RX-секторам."""
    fw = w.fw
    fw.wmi(F.WMI_CONNECT, F.connect_cmd())
    F.settle(fw)
    fw.lmac_evt(0x05, F.bf_done(CID, F.AP_MAC))
    for _ in range(64):
        if not fw.fire_timer('conn_main_sm_bcon_rx_timeout_evt'):
            return
    raise AssertionError('таймер маяка взводится бесконечно')


def sta_linkup_bf_fail(w):
    """Линк-ап: BF к пиру не проходит ни разу (uc BF_DONE со статусом 0) — до lm_linkup_fail_max попыток."""
    fw = w.fw
    fw.uc_bf_status = 0
    fw.wmi(F.WMI_CONNECT, F.connect_cmd())
    F.settle(fw)
    fw.lmac_evt(0x05, F.bf_done(CID, F.AP_MAC))
    conn = w.conn_by_cid(CID)
    fw.call('basic_sm_handle_event', conn + F.C_MSM, 1, 1, 0, 0)
    fw.run_tasks()
    F.settle(fw)
    fw.uc_bf_status = 1


STA_PATHS = [
    ('wmi_disconnect', sta_wmi_disconnect, False),
    ('assoc_timeout', sta_assoc_timeout, True),
    ('assoc_reject', sta_assoc_reject, True),
    ('disconnect_during_assoc', sta_disconnect_during_assoc, True),
    ('disconnect_waiting_radio', sta_disconnect_waiting_radio, False),
    ('peer_disassoc', sta_peer_disassoc, False),
    ('no_beacons', sta_no_beacons, False),
    ('link_lost_then_no_beacons', sta_link_lost_then_no_beacons, False),
    ('beacon_timeout', sta_beacon_timeout, False),
    ('linkup_bf_fail', sta_linkup_bf_fail, False),
]
_STA = {n: f for n, f, _ in STA_PATHS}


def _record(fw):
    """Что увидели uc и хост за шаг: команды LMAC (тип, тело) и события WMI (id, тело)."""
    return ([(c.type, c.body) for c in fw.lmac_cmds], [(e.id, e.body) for e in fw.wmi_evts])


def _connect_record(w):
    fw = w.fw
    fw.clear()
    fw._uc_seen = 0
    conn = w.sta_connect()
    w.sta_add_vring()
    return _record(fw), (w.msm(conn), w.mlme(conn), w.bss_state())


@functools.lru_cache(maxsize=None)
def _fresh_connect(elf):
    """Первое подключение STA с загрузки — эталон для повторного."""
    w = F.Fw(fwemu.FW(elf).boot())
    return _connect_record(w)


@functools.lru_cache(maxsize=None)
def _sta_path(elf, name):
    """Путь разрыва с загрузки → (состояние после загрузки, после разрыва, события хосту, START_SCAN «при
    соединении», дикие обращения, запись повторного подключения)."""
    fw = fwemu.FW(elf).boot()
    w = F.Fw(fw)
    boot = F.idle_state(fw)
    _STA[name](w)
    F.settle(fw)
    # покой: окна, которые по стандарту/замыслу живут дольше соединения (проверка частоты ложных тревог 4,5 с),
    # истекают сами; таймер, оставшийся и после этого, — остаток
    fw.advance(QUIESCE_US, between=F.settle)
    after = F.idle_state(fw)
    evts = [e.id for e in fw.wmi_evts]
    scan_connected = fw.call('mid_list_any_in_state2')
    wild = list(fw.wild)
    uc = (F.uc_station(fw.boot_lmac_cmds, CID), F.uc_station(fw.boot_lmac_cmds + fw.lmac_cmds, CID))
    recon = _connect_record(w)
    return boot, after, evts, scan_connected, wild, uc, recon


def _param(name):
    return pytest.param(name, id=name)


@pytest.mark.parametrize('path', [_param(n) for n, _, _ in STA_PATHS])
def test_sta_teardown_returns_to_idle(fw_elf, path):
    boot, after, evts, scan_connected, wild, _, _ = _sta_path(fw_elf, path)
    assert evts.count(F.EV_DISCONNECT) == 1, 'WMI_DISCONNECT_EVENT хосту: %d раз (%s)' % (
        evts.count(F.EV_DISCONNECT), [hex(e) for e in evts])
    assert scan_connected == 0, 'mid_list_any_in_state2: следующий START_SCAN пойдёт как «скан при соединении»'
    diff = F.state_diff(boot, after, IGNORE_TX_STATE + RANK)
    assert not diff, 'после разрыва (%s) не сброшено: %s' % (path, diff)
    assert not wild, 'обращения вне карты памяти: %s' % wild[:4]


@pytest.mark.parametrize('path', [_param(n) for n, _, _ in STA_PATHS])
def test_sta_teardown_leaves_no_rank_entry(fw_elf, path):
    """Разрыв до ассоциации (тайм-аут, отказ, WMI_DISCONNECT) снимает элемент списка ранжирования вместе с записью
    соединения (conn_mgr_link_down_evt)."""
    boot, after, _, _, _, _, _ = _sta_path(fw_elf, path)
    assert [(k, boot[k], after[k]) for k in RANK if boot[k] != after[k]] == []


@pytest.mark.parametrize('path', [_param(n) for n, _, _ in STA_PATHS])
def test_sta_teardown_uc_station_idle(fw_elf, path):
    """uc после разрыва ничего не держит для станции: запись станции выключена (LMAC 0x05 op 1), сопровождение снято
    (0x0f), ключ недействителен (0x18 mode 1), MAC-очереди станции сняты (0x08 op 1) — как после загрузки."""
    *_, (uc_boot, uc_after), _ = _sta_path(fw_elf, path)
    assert uc_after == uc_boot


@pytest.mark.parametrize('path', [_param(n) for n, _, _ in STA_PATHS])
def test_sta_reconnect_after_teardown_same_as_first(fw_elf, path):
    """Повторное подключение после разрыва: те же команды uc и события хосту, что первое с загрузки; итог —
    KEY_ASSOC / ASSOCIATED, BSS активен."""
    (base_lmac, base_evts), base_state = _fresh_connect(fw_elf)
    *_, ((lmac, evts), state) = _sta_path(fw_elf, path)
    assert state == (F.MSM_KEY_ASSOC, F.MLME_ASSOCIATED, F.BSS_ACTIVE)
    assert [hex(t) for t, _ in lmac] == [hex(t) for t, _ in base_lmac]
    assert lmac == base_lmac
    assert [hex(i) for i, _ in evts] == [hex(i) for i, _ in base_evts]
    assert evts == base_evts


# ---- счётчики поддержания линка в общей с uc памяти (ll_ctx, include/fwsh.h) ----

LL_FIELDS = (('traffic', 0x120, 4), ('act_140', 0x140, 4), ('idle', 0x164, 4), ('ka_acc', 0x184, 4),
             ('ka_period', 0x1a4, 4), ('ka_cnt', 0x1c4, 4), ('bcn_cnt', 0x1ec, 2))


def _ll(fw, cid=CID):
    ll = fw.a('ll_ctx')
    out = {n: (fw.r16(ll + o + 2 * cid) if w == 2 else fw.r32(ll + o + 4 * cid)) for n, o, w in LL_FIELDS}
    out['pending_mask'] = (fw.r32(ll + 0x160) >> cid) & 1
    return out


def _poison_ll(fw, cid=CID):
    """Ход соединения: uc и детекторы накрутили счётчики станции (трафик, простой, keep-alive, BI без маяка)."""
    ll = fw.a('ll_ctx')
    for n, o, w in LL_FIELDS:
        if w == 2:
            fw.w16(ll + o + 2 * cid, 7)
        else:
            fw.w32(ll + o + 4 * cid, 0x1234 + o)


@pytest.mark.parametrize('path', ['wmi_disconnect', 'peer_disassoc', 'no_beacons'])
def test_sta_link_counters_fresh_on_reconnect(fw_elf, path):
    """Счётчики станции в ll_ctx после разрыва и нового подключения — как у первого подключения с загрузки
    (детекторы старения TX / keep-alive / плохих маяков стартуют с нуля, иначе новый линк рвётся раньше срока)."""
    fw = fwemu.FW(fw_elf).boot()
    w = F.Fw(fw)
    w.sta_connect(); w.sta_add_vring()
    fresh = _ll(fw)
    _poison_ll(fw)
    fw.clear()
    if path == 'wmi_disconnect':
        fw.wmi(F.WMI_DISCONNECT)
    elif path == 'peer_disassoc':
        _disassoc_from(w, F.AP_MAC, F.OWN_MAC, F.AP_MAC, 3)
    else:
        _no_beacon_bis(w)
    F.settle(fw)
    assert F.EV_DISCONNECT in [e.id for e in fw.wmi_evts]
    fw.clear()
    fw._uc_seen = 0
    w.sta_connect(); w.sta_add_vring()
    assert _ll(fw) == fresh


# ---- шторм LINK_LOST: проверка частоты ложных тревог ----

def test_link_lost_storm_does_not_crash_fw(fw):
    """uc сообщает LINK_LOST (0x09) чаще, чем раз в 0,5 с (пир пропал, BF не проходит): fw не должна падать."""
    w = F.Fw(fw)
    w.sta_connect(); w.sta_add_vring()
    fw.uc_bf_status = 0
    for _ in range(10):
        fw.lmac_evt(0x09, struct.pack('<III', CID, 0, 1))
        F.settle(fw)
        fw.advance(100_000)
    fw.advance(5_000_000)



# ---- Block Ack (TX): стрим возвращается в NOT_BA_AGR, таймеры установки сняты, повторный BA_EN — как первый ----

def _stream(fw, vr=0):
    return fw.r32(fw.a('stream_by_vr') + 4 * vr)


def _ba_state(fw, s):
    """(stream_sm, ba_setup_sm, wait_sm, таймеры ответа/повтора/общий) — include/stream.h. ctx.ba_en (флаг BA_EN
    хоста) fw только пишет — не сравнивается."""
    return (fw.r8(s + 0x10), fw.r8(s + 0x18), fw.r8(s + 0x3c),
            fw.r32(s + 0x18 + 0xc) != 0, fw.r32(s + 0x18 + 0x10) != 0, fw.r32(s + 0x18 + 0x14) != 0)


BA_IDLE = (0, 0, 0, False, False, False)
BA_AGREED = 2


def _ba_en(w, wsize=32):
    fw = w.fw
    fw.wmi(F.WMI_VRING_BA_EN, struct.pack('<BBHB3x', 0, wsize, 0, 0))
    F.settle(fw)
    req = [f for _, f in fw.tx_frames if f[0] == 0xd0 and f[0x18:0x1a] == b'\x03\x00']
    assert req, 'ADDBA Request не отправлен'
    return req[-1]


def _addba_resp(w, token, wsize=32, status=0):
    fw = w.fw
    body = bytes([3, 1, token]) + struct.pack('<HHH', status, wsize << 6, 0)   # 9.6.4.3
    fw.call('stream_mgr_action', fw.rx_pkt(fw.mgmt_frame(13, F.OWN_MAC, F.AP_MAC, F.AP_MAC, body), cid=CID))
    fw.run_tasks()
    F.settle(fw)


def _ba_up(w):
    req = _ba_en(w)
    _addba_resp(w, req[0x18 + 2])
    s = _stream(w.fw)
    assert w.fw.r8(s + 0x10) == BA_AGREED
    return s


@pytest.fixture
def sta_ba(fw):
    w = F.Fw(fw)
    w.sta_connect()
    w.sta_add_vring()
    return w


@pytest.mark.parametrize('teardown', ['wmi_ba_dis', 'peer_delba', 'addba_no_response'])
def test_ba_teardown_returns_stream_to_idle(sta_ba, teardown):
    w = sta_ba
    fw = w.fw
    if teardown == 'addba_no_response':
        # ADDBA Response нет: повторы по ba_addba_resp_timeout и общий таймаут установки ba_setup_total_timeout
        # (настройки fw_data; укорочены, чтобы не гонять 32 с периодических служб в эмуляторе)
        fw.w32(fw.a('ba_addba_resp_timeout'), 100_000)
        fw.w32(fw.a('ba_setup_total_timeout'), 1_000_000)
        _ba_en(w)
        fw.advance(1_500_000, between=F.settle)
        assert [e.body[0] for e in fw.wmi_evts if e.id == 0x1823][-1] != 0   # WMI_BA_STATUS: отказ хосту
    else:
        _ba_up(w)
        if teardown == 'wmi_ba_dis':
            fw.wmi(F.WMI_VRING_BA_DIS, struct.pack('<BBH', 0, 0, 39))
        else:
            delba = bytes([3, 2]) + struct.pack('<BBH', 0, 0, 37)      # 9.6.4.4, инициатор BA — мы
            fw.call('stream_mgr_action', fw.rx_pkt(fw.mgmt_frame(13, F.OWN_MAC, F.AP_MAC, F.AP_MAC, delba), cid=CID))
            fw.run_tasks()
        F.settle(fw)
    s = _stream(fw)
    assert _ba_state(fw, s) == BA_IDLE
    timers = [t[0] for t in fw.timers()]
    assert not [t for t in timers if t.startswith('ba_setup')], timers
    # повторный BA_EN — как первый: ADDBA Request и согласование
    fw.clear()
    _ba_up(w)
    assert [e.body[0] for e in fw.wmi_evts if e.id == 0x1823][-1] == 0      # WMI_BA_STATUS: успех


def test_disconnect_with_ba_agreed_returns_to_idle(fw):
    boot = F.idle_state(fw)
    w = F.Fw(fw)
    w.sta_connect()
    w.sta_add_vring()
    _ba_up(w)
    fw.wmi(F.WMI_DISCONNECT)
    F.settle(fw)
    assert F.state_diff(boot, F.idle_state(fw), IGNORE_TX_STATE) == []
    assert not [t[0] for t in fw.timers() if t[0].startswith('ba_setup')]


# ---- AP: станция уходит, AP остаётся / AP останавливают ----

@pytest.fixture
def ap(fw):
    """AP запущена (WMI_PCP_START), станция cid 0 вошла и получила кольцо данных; (Fw, состояние «AP без станций»,
    состояние после загрузки)."""
    boot = F.idle_state(fw)
    w = F.Fw(fw)
    w.ap_start()
    ap_idle = F.idle_state(fw)
    conn = w.ap_sta_join()
    w.sta_add_vring()
    assert (w.msm(conn), w.mlme(conn)) == (F.MSM_KEY_ASSOC, F.MLME_ASSOCIATED)
    w.cmds_before = list(fw.boot_lmac_cmds) + list(fw.lmac_cmds)   # команды uc с загрузки (для uc_station)
    fw.clear()
    return w, ap_idle, boot


@pytest.mark.parametrize('how', ['wmi_disconnect_sta', 'peer_disassoc', 'wmi_disconnect'])
def test_ap_station_leaves_ap_idle(ap, how):
    w, ap_idle, _ = ap
    fw = w.fw
    if how == 'wmi_disconnect_sta':
        fw.wmi(F.WMI_DISCONNECT_STA, F.STA_MAC + struct.pack('<H', 3))
    elif how == 'peer_disassoc':
        own = w.own_mac()
        _disassoc_from(w, F.STA_MAC, own, own, 8)
    else:
        fw.wmi(F.WMI_DISCONNECT)
    F.settle(fw)
    assert [e.id for e in fw.wmi_evts].count(F.EV_DISCONNECT) == 1
    assert F.state_diff(ap_idle, F.idle_state(fw), IGNORE_TX_STATE) == []
    uc = F.uc_station(w.cmds_before + list(fw.lmac_cmds), CID)
    assert (uc['enabled'], uc['maint'], uc['key_valid']) == (False, False, False), uc
    # та же станция входит снова — так же, как в первый раз
    fw.clear()
    fw._uc_seen = 0
    conn = w.ap_sta_join()
    assert (w.msm(conn), w.mlme(conn)) == (F.MSM_KEY_ASSOC, F.MLME_ASSOCIATED)
    assert F.EV_CONNECT in [e.id for e in fw.wmi_evts]


def test_ap_pcp_stop_after_stations_left_returns_to_boot(ap):
    w, _, boot = ap
    fw = w.fw
    fw.wmi(F.WMI_DISCONNECT_STA, F.STA_MAC + struct.pack('<H', 3))
    F.settle(fw)
    fw.clear()
    fw.wmi(F.WMI_PCP_STOP)
    F.settle(fw)
    assert 0x1919 in [e.id for e in fw.wmi_evts]    # WMI_PCP_STOPPED
    assert F.state_diff(boot, F.idle_state(fw), IGNORE_TX_STATE) == []
    assert w.bss_mode() == 1                         # BSS — снова STA (bss_set_mode в pcp_stop_flow)


def test_ap_pcp_stop_with_station_stops_bss(ap):
    """PCP_STOP при ассоциированной станции: станция отключается, затем BSS останавливается и хосту уходит
    WMI_PCP_STOPPED (драйвер его ждёт) — не дольше 1 с."""
    w, _, boot = ap
    fw = w.fw
    fw.wmi(F.WMI_PCP_STOP)
    F.settle(fw)
    fw.advance(1_000_000, between=F.settle)
    F.settle(fw)
    evts = [e.id for e in fw.wmi_evts]
    assert 0x1919 in evts, 'нет WMI_PCP_STOPPED'
    assert evts.count(F.EV_DISCONNECT) == 1, 'станция не отключена'
    assert F.state_diff(boot, F.idle_state(fw), IGNORE_TX_STATE) == []


# ---- AID и расписание ESE своего BSS (общая с uc таблица окон ese_slot_tbl) ----

ESE_MAY_INITIATE = 0x80                              # бит 7 ctrl слота: uc открывает передачу в окне (fw/rx.c)
def _connect_with_own_sp(w, aid):
    w.sta_connect(aid=aid)
    w.sta_add_vring()
    w.rx_beacon(F.dmg_beacon(F.AP_MAC, [F.ese_alloc(1, src_aid=1)]))     # SP 1: источник AID 1, адресат AP


def test_own_sp_marked_may_initiate(fw):
    """Опора следующих тестов: маяк своего BSS с SP для своего AID — окно в таблице uc с битом «инициировать»."""
    w = F.Fw(fw)
    _connect_with_own_sp(w, aid=1)
    assert [(c & ESE_MAY_INITIATE, s) for c, s, _ in w.ese_slots()] == [(ESE_MAY_INITIATE, 1)]


def test_sta_disconnect_clears_aid_and_ese(fw):
    """После разрыва STA: AID прошлой ассоциации и таблица SP из ESE (общая с uc) сброшены."""
    w = F.Fw(fw)
    _connect_with_own_sp(w, aid=1)
    fw.wmi(F.WMI_DISCONNECT)
    F.settle(fw)
    assert F.EV_DISCONNECT in [e.id for e in fw.wmi_evts]
    assert (fw.r8(w.mid0 + 8), w.ese_slots()) == (0, [])


def test_sta_reconnect_new_aid_does_not_initiate_in_old_sp(fw):
    """Разрыв, новая ассоциация с AID 2, тот же маяк (SP — AID 1, теперь чужой): окна с «инициировать» быть не должно —
    как при подключении с AID 2 с загрузки."""
    w = F.Fw(fw)
    _connect_with_own_sp(w, aid=1)
    fw.wmi(F.WMI_DISCONNECT)
    F.settle(fw)
    fw.clear()
    fw._uc_seen = 0
    w.sta_connect(aid=2)
    w.sta_add_vring()
    w.rx_beacon(F.dmg_beacon(F.AP_MAC, [F.ese_alloc(1, src_aid=1)]))
    assert fw.r8(w.mid0 + 8) == 2
    assert [c for c, _, _ in w.ese_slots() if c & ESE_MAY_INITIATE] == []


def test_fresh_connect_new_aid_ignores_foreign_sp(fw):
    """Контроль: с загрузки, AID 2, тот же маяк — SP чужой станции в таблицу не попадает."""
    w = F.Fw(fw)
    w.sta_connect(aid=2)
    w.sta_add_vring()
    w.rx_beacon(F.dmg_beacon(F.AP_MAC, [F.ese_alloc(1, src_aid=1)]))
    assert [c for c, _, _ in w.ese_slots() if c & ESE_MAY_INITIATE] == []
