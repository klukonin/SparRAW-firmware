# SPDX-License-Identifier: AGPL-3.0-or-later
"""Сценарии fw для юнит-тестов (tests/unit/fwemu.py): подключение STA / AP через настоящие обработчики WMI, событий
uc (LMAC) и принятых кадров — как их видит fw на стенде; uc и пир смоделированы ответами по порядку протокола.

Раскладки объектов — include/conn.h, include/mid.h, include/link_sm.h, include/link_loss.h (смещения там закреплены
_Static_assert); здесь — только те поля, что проверяют тесты.
"""
import contextlib, os, re, struct

REW = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# ---- WMI (include/wmi.h) ----
WMI_CONNECT, WMI_DISCONNECT, WMI_DISCONNECT_STA = 0x1, 0x3, 0x4
WMI_START_SCAN = 0x7
WMI_VRING_CFG, WMI_BCAST_VRING_CFG, WMI_VRING_BA_EN, WMI_VRING_BA_DIS = 0x821, 0x822, 0x823, 0x824
WMI_PCP_START, WMI_PCP_STOP = 0x918, 0x919
EV_CONNECT, EV_DISCONNECT, EV_VRING_CFG_DONE, EV_NOT_SUPPORTED = 0x1002, 0x1003, 0x1821, 0xffff

# ---- состояния (include/conn.h, include/mid.h) ----
MSM_KEY_ASSOC, MSM_WAIT_FOR_DISCONN = 7, 8                  # conn_main_sm
MLME_ASSOCIATED = 2
BSS_ACTIVE = 2

# ---- раскладки (смещения закреплены _Static_assert в include/conn.h, include/mid.h) ----
CM_CID_DB, CM_CONN_POOL = 0x80, 0xc0                        # struct conn_mgr
C_PEER, C_LM, C_MLME, C_MSM = 0x1c, 0x70, 0xf0, 0x124       # struct conn
LM_LM_SM = 0x00                                             # struct lm_if (conn + 0x70)
MID_BSS, BSS_STATE, BSS_MODE = 0x48, 0x04, 0x08             # struct mid / mid_bss


def _sta_max():
    """SPARRAW_MAX_STA / SPARRAW_PEER_UNKNOWN / SPARRAW_STA_SLOTS — из include/sta_max.h (единый параметр fw и uc)."""
    src = open(os.path.join(REW, 'include', 'sta_max.h')).read()
    n = int(re.search(r'#define\s+SPARRAW_MAX_STA\s+(\d+)u?', src).group(1))
    return n, n, n + 1


SPARRAW_MAX_STA, SPARRAW_PEER_UNKNOWN, SPARRAW_STA_SLOTS = _sta_max()
AP_MAC = bytes([0x04, 0xd4, 0xc4, 0x11, 0x22, 0x33])
STA_MAC = bytes([0x04, 0xd4, 0xc4, 0x55, 0x66, 0x77])
OWN_MAC = bytes(6)                                          # fw после загрузки: WMI_SET_MAC_ADDRESS не было


def connect_cmd(bssid=AP_MAC, channel=2, ssid=b'test', network_type=1):
    """WMI_CONNECT (struct wmi_connect_cmd): открытая сеть, как wil6210 (dot11_auth OPEN, auth NONE, crypto NONE)."""
    c = bytearray(0x3c)
    c[0] = network_type
    c[1] = 1                                                # WMI_AUTH11_OPEN
    c[2] = 1                                                # WMI_AUTH_NONE
    c[3] = 1                                                # WMI_CRYPT_NONE
    c[5] = 1
    c[7] = len(ssid)
    c[8:8 + len(ssid)] = ssid
    c[0x28] = channel
    c[0x2a:0x30] = bssid
    c[0x34:0x3a] = bssid
    return bytes(c)


def bf_done(cid, peer, status=1, typ=0, rf_sector=3):
    """Событие uc BF (struct lmac_evt_bf_done, include/lmac_cmd.h)."""
    b = bytearray(0x44)
    struct.pack_into('<I', b, 0, 20)
    b[4] = cid
    b[5] = 3
    b[6] = 5
    b[8] = 5
    struct.pack_into('<H', b, 0xa, rf_sector)
    b[0xc] = 20
    struct.pack_into('<II', b, 0x2c, status, typ)
    b[0x34:0x3a] = peer
    return bytes(b)


def ese_alloc(alloc_id, src_aid, dst_aid=0, atype=0, start=1000, dur=500, nblk=1, period=0):
    """Поле распределения Extended Schedule (9.4.2.131, struct ese_alloc): Allocation Control (ID B0–B3, тип
    B4–B6: 0 — SP, 1 — CBAP), BF Control, Source/Destination AID, Allocation Start, Block Duration, Number of
    Blocks, Block Period."""
    return (bytes([(alloc_id & 0xf) | (atype << 4), 0]) + bytes(2) + bytes([src_aid, dst_aid]) +
            struct.pack('<IHBH', start, dur, nblk, period))


def dmg_beacon(bssid, allocs=(), bi=100, bss_type=3):
    """DMG Beacon (9.3.4.2): FC (Extension, подтип 0), Duration, BSSID; Timestamp, SSW, Beacon Interval, BI Control,
    DMG Parameters (BSS Type B0–B1); Extended Schedule (EID 0x90) из allocs."""
    hdr = struct.pack('<HH', 0x000c, 0) + bytes(bssid)
    body = bytes(8) + bytes(3) + struct.pack('<H', bi) + bytes(6) + bytes([bss_type & 3])
    if allocs:
        a = b''.join(allocs)
        body += bytes([0x90, len(a)]) + a
    return hdr + body


def vring_cfg_cmd(ringid, cid, tid=0, action=0, mpdu=0x800, wsize=0, timeslot_us=0xfff, ring_size=0x400):
    """WMI_VRING_CFG (struct wmi_vring_cfg_cmd) как у wil6210: schd_params {priority 0, timeslot_us 0xfff}."""
    b = bytearray(0x1c)
    struct.pack_into('<IIH', b, 4, 0x20000000 + 0x10000 * ringid, 0, ring_size)
    struct.pack_into('<HH', b, 4 + 0x14, 0, timeslot_us)
    struct.pack_into('<I', b, 0, action)
    struct.pack_into('<H', b, 4 + 0xa, mpdu)
    b[4 + 0x0c] = ringid
    b[4 + 0x0d] = (cid & 0xf) | (tid << 4)
    b[4 + 0x13] = wsize
    return bytes(b)


def uc_reply(fw, cmd):
    """Ответ uc на команду LMAC (по uc/cmd.c, uc/evt.c): [(тип события, тело)]. Команды без ответа — [].
    0x03 RX off → 0x03; 0x01 RX on → 0x01; 0x08 op 1 (снять очередь) → 0x08 QUEUE_DELETED {qid};
    0x18 запись поля станции → 0x11 {sta, mode}; 0x09 запуск BF к cid → 0x06 BF_DONE (uc_send_evt_bf_done) с
    итогом fw.uc_bf_status (1 — успех, по умолчанию) и MAC пира соединения cid."""
    t, b = cmd.type, cmd.body
    gone_cids = fw.gone[1] if getattr(fw, 'gone', None) else ()
    if t == 0x09 and len(b) >= 0xc:
        cid = struct.unpack_from('<I', b, 8)[0]
        conn = Fw(fw).conn_by_cid(cid) if cid < SPARRAW_MAX_STA else 0
        if not conn:
            return []
        status = 0 if cid in gone_cids else getattr(fw, 'uc_bf_status', 1)     # пир пропал — SLS без ответа
        return [(0x06, bf_done(cid, fw.rbytes(conn + C_PEER, 6), status, 0))]
    if t == 0x26 and len(b) >= 1 and b[0] < SPARRAW_MAX_STA:
        # CMD_KEEP_ALIVE_TRIGGER (uc/cmd.c keep_alive_arm_slot → uc/tx.c): пир ответил — бит снят
        # (internal_tx_clear_pending), traffic[cid] + 1; пир пропал — Ack нет, бит cid в ll_ctx.pending_mask остаётся
        ll, cid = fw.a('ll_ctx'), b[0]
        if cid in gone_cids:
            fw.w32(ll + LL_PENDING_MASK, fw.r32(ll + LL_PENDING_MASK) | (1 << cid))
        else:
            fw.w32(ll + LL_PENDING_MASK, fw.r32(ll + LL_PENDING_MASK) & ~(1 << cid))
            fw.w32(ll + LL_TRAFFIC + 4 * cid, fw.r32(ll + LL_TRAFFIC + 4 * cid) + 1)
        return []
    if t == 0x05 and len(b) >= 0x14 and b[0xc] < SPARRAW_MAX_STA and struct.unpack_from('<I', b, 0x10)[0] == 1:
        # запись станции выключена: у станции нет очередей — uc снимает ожидающий keep-alive (uc/tx.c,
        # internal_tx_clear_pending при sta_tab.qid_mask_q6 == 0)
        ll = fw.a('ll_ctx')
        fw.w32(ll + LL_PENDING_MASK, fw.r32(ll + LL_PENDING_MASK) & ~(1 << b[0xc]))
        return []
    if t == 0x03:
        return [(0x03, b'')]
    if t == 0x01:
        return [(0x01, b'')]
    if t == 0x08 and len(b) >= 0xc and struct.unpack_from('<I', b, 8)[0] == 1:
        return [(0x08, struct.pack('<III', b[0], 0, 0))]
    if t == 0x18 and len(b) >= 8:
        return [(0x11, b[0:8])]
    return []


TX_QUEUES = ('tx_api_mgmt', 'tx_api_2', 'tx_api_data')       # очереди собственных кадров fw (include/fwq_tx.h)


def settle(fw, uc=True, tx=True, limit=50):
    """Довести fw до покоя: ответы uc на новые команды LMAC (uc_reply), завершение кадров колец TX собственных
    очередей fw (Ack пира / маяк ушёл), готовые задачи u_schd. Таймеры не срабатывают — их тест вызывает явно
    (fw.advance / fw.fire_timer)."""
    done = getattr(fw, '_uc_seen', 0)
    if done > len(fw.lmac_cmds):
        done = 0
    for _ in range(limit):
        progress = False
        if uc:
            while done < len(fw.lmac_cmds):
                cmd = fw.lmac_cmds[done]
                done += 1
                for typ, body in uc_reply(fw, cmd):
                    fw.lmac_evt(typ, body)
                    progress = True
        if tx:
            for q in TX_QUEUES:
                if fw.tx_pending(q):
                    if getattr(fw, 'gone', None):
                        tx_complete_by_ra(fw, q, lambda ra: TX_NO_ACK if ra in fw.gone[0] else 0)
                    else:
                        fw.tx_complete(q)
                    progress = True
        fw._uc_seen = done
        if not progress and not (getattr(fw, 'gone', None) and _bi_ticks(fw)):
            return
    raise RuntimeError('settle: нет покоя за %d шагов' % limit)


# ---- пир пропал: с какого-то шага пир молчит (tests/unit/test_fw_peer_vanish.py) ----

HW_MAC_TSF_LO, HW_MAC_TSF_HI = 0x886eb8, 0x886ebc   # include/hw.h: HW_MAC_TIMING_INDIRECT_REG_5, HW_MAC_TSF_HI
HW_DMA_RINGS_WITH_DATA, HW_TXQ_PTP_AVAIL = 0x881c84, 0x886a24
TX_NO_ACK = 1               # код ошибки дескриптора TX [2:0]; fw различает только 0 / не 0 (fwq_tx_long_retry_failures)
LL_TRAFFIC, LL_PENDING_MASK = 0x120, 0x160                  # struct ll_ctx (include/fwsh.h)
BI_US = 102400                                               # BI 100 TU (Fw.ap_start, dmg_beacon)
M32 = 0xffffffff


def run_tsf(fw):
    """TSF MAC идёт вместе со временем u_schd (тик 16 мкс): детекторы потери линка (fw/link_loss.c), учёт времени
    pring (sm_pring_notify_step) считают прошедшее по TSF. Без этого TSF стоит и ни один срок по TSF не истекает."""
    fw.mmio_read_hook[HW_MAC_TSF_LO] = lambda fw, a: (fw.now() << 4) & M32
    fw.mmio_read_hook[HW_MAC_TSF_HI] = lambda fw, a: (fw.now() << 4) >> 32


class _TimedEvts(list):
    """События WMI с временем u_schd отправки (fw.evt_time[i] — тик события fw.wmi_evts[i])."""
    def __init__(self, fw):
        super().__init__()
        self._fw = fw
        fw.evt_time = []

    def append(self, e):
        self._fw.evt_time.append(self._fw.now())
        super().append(e)

    def clear(self):
        self._fw.evt_time.clear()
        super().clear()


def track_event_times(fw):
    fw.wmi_evts = _TimedEvts(fw)


def tx_complete_by_ra(fw, q, status_of):
    """«Железо» завершило кадры кольца TX очереди q, код каждого — status_of(RA кадра): пропавшему пиру Ack нет."""
    qa = fw.a(q)
    ring = fw.r32(qa + 0x8c)
    base, size, tail, head = (fw.r32(ring + 4 + 4 * i) for i in range(4))
    i = tail
    while size and i != head:
        d = base + 0x20 * i
        pl = fw.r32(d) | (1 << 18) | (1 << 23)            # адрес кадра (tx_ring_complete)
        st = status_of(fw.rbytes(pl + 4, 6))
        fw.w32(d + 0x1c, (fw.r32(d + 0x1c) & ~7) | 0x100 | (st & 7))
        i = (i + 1) % size
    fw.call('TX_API_handle_completed_packets', qa)
    fw.run_tasks()


def _bi_ticks(fw):
    """Каждый BI uc шлёт статистику BI (событие 0x17, peer_slots_scan_by_masks); маяка пира нет —
    mac_mon_pub.bti.detected = 0."""
    n = 0
    while ((fw.now() - fw.bi_next) & M32) < 0x80000000:
        fw.bi_next = (fw.bi_next + (BI_US >> 4)) & M32
        fw.lmac_evt(0x17)
        n += 1
    return n


def peer_gone(fw, macs, cids, bf_fails=True):
    """С этого шага пиры macs (и их cid) молчат: кадры к ним без Ack, BF к ним — неудача (uc BF_DONE статус 0),
    keep-alive без ответа, маяков пира нет (BI без маяка). uc и MAC живы. Модель действует в settle (между шагами
    fw.advance — between=settle)."""
    fw.gone = (set(bytes(m) for m in macs), set(cids) if bf_fails else set())
    fw.bi_next = (fw.now() + (BI_US >> 4)) & M32


def peer_back(fw):
    fw.gone = None


def host_tx_pending(fw, vr):
    """Хост положил данные в кольцо vr (бит vr в HW_DMA_RINGS_WITH_DATA, прерывание DMA → задача
    vring_schd_move_ready_if_idle): vring привязывается к pring и копит время работы по TSF — вход детектора старения
    TX. Очередь MAC в модели пуста (tx_macq_is_empty: при привязке — предусловие fw; при остановке pring —
    неподтверждённые кадры сброшены), очереди TXQ доступны."""
    fw.default_stubs['tx_macq_is_empty'] = 1
    fw.mmio[HW_TXQ_PTP_AVAIL] = M32
    fw.mmio[HW_DMA_RINGS_WITH_DATA] = fw.mmio[HW_DMA_RINGS_WITH_DATA] | (1 << vr)
    fw.call('vring_schd_move_ready_if_idle', vr, 0)
    fw.run_tasks()


def scale_link_loss(fw, div):
    """Пороги поддержания линка (ll_cfg_presets и разложенные из них ll_ctx.cfg[]): старение TX, периоды keep-alive —
    в div раз короче (период прогона детекторов прежний). Срок разрыва масштабируется так же."""
    ll, pre = fw.a('ll_ctx'), fw.a('ll_cfg_presets')
    for base in [pre + 0x24 * i for i in range(4)] + [ll + 0x24 * i for i in range(SPARRAW_MAX_STA)]:
        for off in (0x08, 0x0c, 0x10):                        # ageing_thr, ka_period_hi, ka_period_lo
            fw.w32(base + off, fw.r32(base + off) // div)


class Fw:
    """Обёртка над fwemu.FW с адресами объектов соединения."""

    def __init__(self, fw):
        self.fw = fw
        self.cm = fw.a('conn_mgr')
        self.mid0 = fw.r32(fw.a('mid_list') + 4)

    def conn_by_cid(self, cid):
        e = self.cm + CM_CID_DB + 8 * cid
        return self.fw.r32(e + 4) if self.fw.r32(e) else 0

    def msm(self, conn): return self.fw.r8(conn + C_MSM)
    def mlme(self, conn): return self.fw.r8(conn + C_MLME)
    def bss_state(self): return self.fw.r32(self.mid0 + MID_BSS + BSS_STATE)
    def bss_mode(self): return self.fw.r32(self.mid0 + MID_BSS + BSS_MODE)

    def lm_sm(self, conn): return self.fw.r32(conn + C_LM + LM_LM_SM)

    def rx_beacon(self, frame):
        """Принятый DMG Beacon: discovery_rx_pkt_handler объекта discovery записи mid (как метод [1] таблицы)."""
        fw = self.fw
        fw.call('discovery_rx_pkt_handler', self.mid0 + 0x234, fw.rx_pkt(frame, short_hdr=True))
        fw.run_tasks()
        settle(fw)

    def ese_slots(self):
        """Таблица окон ESE, общая с uc (struct ese_slot_tbl, include/fwsh.h): [(ctrl, src_aid, dst_aid)]."""
        fw = self.fw
        t = fw.a('ese_slot_tbl')
        return [(fw.r8(t + 4 + 0xc * i), fw.r8(t + 4 + 0xc * i + 2), fw.r8(t + 4 + 0xc * i + 3))
                for i in range(fw.r8(t + 1))]

    # ---- STA ----
    def sta_connect(self, peer=AP_MAC, aid=1, stop='data'):
        """STA: WMI_CONNECT → радио (uc: RX off 0x03, RX on 0x01) → BF новой связи (uc 0x05) → бикон пира (BCON_RX)
        → Assoc Request; Assoc Response (AID) → первый BF сопровождения (uc 0x06) → WMI_CONNECT_EVENT, ключ (открытая
        сеть) → порт данных. stop: 'assoc_req' — остановиться после Assoc Request (ждём ответа), 'data' — до конца.
        Возврат — адрес conn."""
        fw = self.fw
        fw.wmi(WMI_CONNECT, connect_cmd(bssid=peer))
        settle(fw)                                          # uc: RX off/on — канал захвачен
        fw.lmac_evt(0x05, bf_done(0, peer))                 # uc: BF новой связи (SLS) успешен
        conn = self.conn_by_cid(0)
        assert conn, 'после NEW_LINK нет соединения cid 0'
        # бикон пира в окне ожидания: событие BCON_RX автомату conn_main_sm (a0 = 1 «бикон есть»); линк-ап — BF
        # (uc: LMAC 0x09 → BF_DONE), затем Assoc Request (Ack получен)
        fw.call('basic_sm_handle_event', conn + C_MSM, 1, 1, 0, 0)
        fw.run_tasks()
        settle(fw)
        if stop == 'assoc_req':
            return conn
        body = struct.pack('<HHH', 0x10, 0, aid)            # Capability, Status 0, AID (9.3.3.7)
        fw.call('rx_pkt_handler', fw.rx_pkt(fw.mgmt_frame(1, OWN_MAC, peer, peer, body), cid=0))
        fw.run_tasks()
        settle(fw)                                          # первый BF сопровождения, CONNECT_EVENT, ключ
        return conn

    def sta_add_vring(self, cid=0, ringid=0, tid=0):
        r = self.fw.wmi(WMI_VRING_CFG, vring_cfg_cmd(ringid, cid, tid))
        settle(self.fw)
        return r

    # ---- AP ----
    def own_mac(self):
        return self.fw.rbytes(self.mid0 + 0x0a, 6)

    def ap_start(self, channel=2, max_sta=SPARRAW_MAX_STA, bi=100, secure=False):
        """WMI_PCP_START (struct wmi_pcp_start_cmd): AP (network_type 0x10), без защиты (secure — RSNA, ключи ставит
        хост WMI_ADD_CIPHER_KEY); uc — RX off/on на канале; PCP_STARTED хосту (таймер 30 мс)."""
        fw = self.fw
        b = bytearray(0x10)
        struct.pack_into('<H', b, 0, bi)
        b[2] = max_sta
        b[0xc] = 0x10
        b[0xd] = channel
        b[0xf] = 0 if secure else 1                         # disable_sec
        fw.wmi(WMI_PCP_START, bytes(b))
        settle(fw)
        fw.advance(0x7530)
        settle(fw)

    def ap_sta_join(self, peer=STA_MAC, cid=0):
        """Станция peer входит в BSS точки: BF в A-BFT (uc 0x05, cid SPARRAW_PEER_UNKNOWN = MAX_STA) → соединение,
        Assoc Request (9.3.3.6) → Assoc Response (TX, Ack) → первый BF сопровождения (uc 0x06) → CONNECT_EVENT,
        порт данных. Возврат — адрес conn."""
        fw = self.fw
        fw.lmac_evt(0x05, bf_done(SPARRAW_PEER_UNKNOWN, peer, 1, 2))
        settle(fw)
        conn = self.conn_by_cid(cid)
        assert conn, 'после BF в A-BFT нет соединения cid %d' % cid
        own = self.own_mac()
        req = struct.pack('<HH', 0x10, 1)                   # Capability, Listen Interval
        fw.call('rx_pkt_handler', fw.rx_pkt(fw.mgmt_frame(0, own, peer, own, req), cid=cid))
        fw.run_tasks()
        settle(fw)
        return conn

    def cid_of(self, peer):
        """cid соединения с пиром peer (None — нет)."""
        for cid in range(SPARRAW_MAX_STA):
            c = self.conn_by_cid(cid)
            if c and self.fw.rbytes(c + C_PEER, 6) == bytes(peer):
                return cid
        return None


# ---- состояние «покоя» соединений: имя поля → значение (сравнение с состоянием после загрузки) ----

def _pool_used(fw, pool):
    return fw.r32(pool + 0xc)


def idle_state(fw, cid=0, max_sta=None):
    """Поля fw, которые после разрыва любого соединения должны вернуться к состоянию «после загрузки»: записи mid,
    база соединений, пулы, запросы радио, таймеры/задачи u_schd, стримы, общие с uc счётчики станции cid,
    глобальные флаги l2mgr. Значения таймеров — имена колбэков (адреса задач от прогона к прогону разные)."""
    a = fw.a
    s = {}
    max_sta = SPARRAW_MAX_STA if max_sta is None else max_sta
    mid = fw.r32(a('mid_list') + 4)
    s['mid.bss.state'] = fw.r32(mid + MID_BSS + BSS_STATE)
    s['mid.cid_mask'] = fw.r8(mid + 0x24)
    s['mid.conns.count'] = fw.r32(mid + 0x18)
    s['mid.connect_busy'] = fw.r32(mid + 0x2ac)
    s['mid.pcp_ready_tmr'] = fw.r32(mid + 0x2a8)
    cm = a('conn_mgr')
    s['conn_mgr.cid_db.used'] = tuple(fw.r32(cm + CM_CID_DB + 8 * i) for i in range(max_sta))
    s['conn_mgr.conn_pool.used'] = _pool_used(fw, cm + CM_CONN_POOL)
    s['conn_mgr.rank_pool.used'] = _pool_used(fw, cm + 0x6c)
    s['conn_mgr.rank_list.count'] = fw.r32(cm)
    for n, p in (('tx_pkt_pool', a('tx_pkt_pool')), ('rx_ring.pool', a('rx_ring') + 0x1c),
                 ('u_schd.task_pool', a('u_schd') + 0x2c), ('sm_defer_pool', a('sm_defer_pool')),
                 ('stream_pool', a('stream_pool')), ('vring_rec_pool', a('vring_rec_pool')),
                 ('dband_info_pool', a('dband_info_pool'))):
        s[n + '.used'] = _pool_used(fw, p)
    rq = a('rm_req_pool')
    s['rm_req_pool.busy'] = tuple(sorted(fw.name_of(fw.r32(rq + 0x24 * i + 0xc)) for i in range(0x10)
                                         if fw.r32(rq + 0x24 * i + 8) != 0))
    rm = a('radio_mgr') + 0x28                                # rm_main_sm
    s['radio_mgr.sm.state'] = fw.r8(rm)
    s['radio_mgr.cs.state'] = fw.r8(rm + 0x10)
    s['radio_mgr.holders.count'] = fw.r32(rm + 0x7c)
    s['radio_mgr.queue.count'] = fw.r32(fw.r32(rm + 8))
    s['u_schd.timers'] = tuple(sorted(t[0] for t in fw.timers()))
    s['u_schd.ready'] = tuple(sorted(t[0] for t in fw.ready_tasks()))
    s['stream_by_vr'] = tuple(fw.r32(a('stream_by_vr') + 4 * i) != 0 for i in range(10))
    av = a('fwq_tx_avail')
    s['fwq_tx_avail.count[cid]'] = fw.r8(av + 4 + cid)
    s['fwq_tx_avail.mask'] = fw.r32(av + 0x10)
    s['fwq_tx_avail.prio_mask'] = fw.r32(av + 0x20)
    for q in ('tx_api_mgmt', 'tx_api_2', 'tx_api_data'):
        qa = a(q)
        s[q + '.state'] = fw.r32(qa + 8)
        s[q + '.flush_cid_mask'] = fw.r32(qa + 0x14)
        s[q + '.queued'] = (fw.r32(qa + 0x18), fw.r32(qa + 0x24), fw.r32(qa + 0x34), fw.r32(qa + 0x40))
    s['tx_pending.count'] = fw.r32(a('tx_pending'))
    ll = a('ll_ctx')
    for n, o, w in (('traffic', 0x120, 4), ('act_140', 0x140, 4), ('idle', 0x164, 4), ('ka_acc', 0x184, 4),
                    ('ka_cnt', 0x1c4, 4), ('bcn_cnt', 0x1ec, 2)):
        s['ll_ctx.%s[cid]' % n] = fw.r16(ll + o + 2 * cid) if w == 2 else fw.r32(ll + o + 4 * cid)
    s['ll_ctx.pending_mask[cid]'] = (fw.r32(ll + 0x160) >> cid) & 1
    s['ll_ctx.drop_req[cid]'] = (fw.r8(ll + 0x1fc) >> cid) & 1
    det = a('ll_detectors') + 0xa4 * cid
    s['ll_detectors[cid].ageing.timer'] = fw.r32(det + 0x10) != 0
    s['ll_detectors[cid].ka.timer'] = fw.r32(det + 0x54 + 0x10) != 0
    s['ll_detectors[cid].bcn.armed'] = fw.r32(det + 0x98 + 8)
    for n in ('l2mgr_pending_ops', 'tx_flush_cid_mask', 'conn_link_lost_rm_req', 'maintain_paused', 'pcp_started',
              'wbe_link_up_timer', 'sched_ready_mask'):
        s[n] = fw.r32(a(n))
    for n in ('l2mgr_connect_waiting_radio', 'l2mgr_connect_cancelled'):
        s[n] = fw.r8(a(n))
    return s


def state_diff(before, after, ignore=()):
    """[(поле, было, стало)] — поля, отличные от «после загрузки»."""
    return [(k, before[k], after[k]) for k in before if k not in ignore and before[k] != after[k]]


def uc_station(cmds, cid):
    """Что uc знает о станции cid по потоку команд LMAC (uc/cmd.c): запись станции включена (0x05 op 0/1),
    сопровождение (0x0f on), ключ действителен (0x18 mode 0/4 — да, 1 — нет); и MAC-очереди (0x08 op 0 — добавить,
    op 1 — снять) — множество qid, снятых не было."""
    st = {'enabled': False, 'maint': False, 'key_valid': False}
    queues = set()
    for c in cmds:
        b = c.body
        if c.type == 0x05 and len(b) >= 0x14 and b[0xc] == cid:
            op = struct.unpack_from('<I', b, 0x10)[0]
            if op in (0, 1):
                st['enabled'] = op == 0
        elif c.type == 0x0f and len(b) >= 6 and struct.unpack_from('<I', b, 0)[0] == cid:
            st['maint'] = struct.unpack_from('<H', b, 4)[0] != 0
        elif c.type == 0x18 and len(b) >= 8 and struct.unpack_from('<I', b, 0)[0] == cid:
            mode = struct.unpack_from('<I', b, 4)[0]
            if mode in (0, 1, 4):
                st['key_valid'] = mode != 1
        elif c.type == 0x08 and len(b) >= 0xc:
            op = struct.unpack_from('<I', b, 8)[0]
            if op == 0:
                queues.add(b[0])
            elif op == 1:
                queues.discard(b[0])
    st['queues'] = tuple(sorted(queues))
    return st


class KnownFatal(Exception):
    """Ожидаемый (уже найденный) фатальный ассерт fw — для xfail(strict=True, raises=KnownFatal): другой код ассерта
    или иной сбой xfail не засчитывается и тест падает."""


@contextlib.contextmanager
def known_fatal(code):
    import fwemu
    try:
        yield
    except fwemu.FwAssert as e:
        if e.code == code:
            raise KnownFatal(str(e)) from e
        raise
