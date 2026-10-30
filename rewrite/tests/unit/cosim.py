# SPDX-License-Identifier: AGPL-3.0-or-later
"""Совместный прогон fw и uc: fw — в своём эмуляторе (fwemu.FW, сценарии fwflows), uc — в эмуляторе с моделью MAC
во времени и прерываниями (ucemu.UC + machw.HW).

    cs = CoSim(fw, uc)                  # uc с загрузки (uc_main), команды fw с загрузки — в uc
    with cs:                            # fwflows.uc_reply → настоящий uc
        F.Fw(fw).ap_start()             # команды LMAC fw → кольцо uc (L1 вектор 8), события uc → fw
    cs.hw.cmd_log, cs.hw.air_log        # что uc сделал с MAC, что ушло в эфир

Общая память fw ↔ uc (блок 0x857000.., include/fwsh.h) копируется fw → uc перед каждой командой и обратно после.
Хост в живом режиме: команды WMI (wmi), кольца TX (host_tx → DMA → очередь MAC, H-DMA2/H-ENCAP), завершения (host_done) и
приём данных (host_rx); окно дескрипторов очередей MAC для fw — H-QDESC.
Наборы RF (fwsh_sets) у эмулятора fw нулевые — board-файл не загружается; RF_SETS_STAND — значения со стенда
(blob_fw_peri, 2026-10-29: один набор, 64 TX-сектора, маска RF 1)."""
import fwflows as F
from machw import HW

SHARED = (0x857000, 0x858000)
FWSH_N_RX_ANT = 0x85728c                      # fwsh_n_rx_ant, fwsh_total_sectors, fwsh_long_range
FWSH_SETS = 0x857730
RF_SETS_STAND = bytes.fromhex(
    'fdffffff400000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000'
    '0000000001000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff010000000000000000000000'
    '0000000000000000000000000100000000000000000000003c788400') + bytes(0x74)  # +0x80 — указатель на rf_set_ranges (0x84783c)
ANT_STAND = bytes.fromhex('014000')
# DMA колец хоста (H-DMA2)
HW_DMA_RINGS_WITH_DATA = 0x881c84            # кольца хоста с непрочитанными дескрипторами
HW_DMA_FW_ICR_C40_ICM = 0x881c48             # причина прерывания DMA vring (vring_schdlr_isr_dispatch)
HW_TXQ_RING_ENABLE = 0x886a14                # кольца, которые DMA переносит в очереди MAC (fw: mac_ring_enable)
HW_TXQ_PTP_AVAIL = 0x886a24
VRINGS = 24                                  # кольца хоста 0..23 (wil6210 WIL6210_MAX_TX_RINGS)
# окно дескрипторов очередей MAC (fw/macq.c macq_desc_read/macq_desc_write)
HW_QDESC_WIN_CTRL, HW_QDESC_WIN_CMD, HW_QDESC_WIN_ADDR, HW_QDESC_WIN_DATA0 = 0x886608, 0x88660c, 0x886610, 0x886614


def data_frame(sa, da, bssid, to_ds, seq, payload, ethertype=0x0800, tid=0):
    """H-ENCAP: кадр 802.3 хоста (кольцо с encap_trans_type 802_3) → QoS Data, как его собирает MAC (802.11-2020
    9.3.2.1: A1 — RA, A2 — TA, A3 — BSSID/DA/SA по To DS/From DS; QoS Control — TID, Ack Policy 00 «Normal Ack»;
    тело — LLC/SNAP + payload). Номер последовательности — от MAC (здесь — счётчик узла)."""
    fc = 0x0088 | (0x0100 if to_ds else 0x0200)
    a1, a2, a3 = (bssid, sa, da) if to_ds else (da, bssid, sa)
    return (fc.to_bytes(2, 'little') + bytes(2) + bytes(a1) + bytes(a2) + bytes(a3) + ((seq & 0xfff) << 4).to_bytes(2, 'little')
            + (tid & 0xf).to_bytes(2, 'little') + bytes.fromhex('aaaa03000000') + ethertype.to_bytes(2, 'big') + bytes(payload))


class CoSim:
    def __init__(self, fw, uc, boot_steps=20_000, cmd_steps=200_000, first_tbtt_us=None):
        self.fw, self.uc, self.cmd_steps = fw, uc, cmd_steps
        for i, b in enumerate(RF_SETS_STAND):
            fw.cpu.mem[FWSH_SETS + i] = b
        for i, b in enumerate(ANT_STAND):
            fw.cpu.mem[FWSH_N_RX_ANT + i] = b
        self.hw = HW(uc) if first_tbtt_us is None else HW(uc, tbtt_us=1_000_000 + first_tbtt_us)   # tsf0 = 1 с
        self.hw.mac_q_model = True                              # очереди MAC — по кадрам fw (_track_tx)
        self.bcon_ring = (fw.a('tx_api_2'), fw.a('tx_api_2') + 0x90)   # пара очередей маяка → очередь MAC 0x1e
        # H-MACQ2: кольца fw → очереди MAC (fw/fwq_tx.c dma_mgr_reset_*_queue): управление 0x1a, данные 0x19
        self.q_rings = {0x1a: ('tx_api_mgmt', fw.a('tx_api_mgmt')), 0x19: ('tx_api_data', fw.a('tx_api_data'))}
        self.tx_seen = 0
        try:
            uc.call('uc_main', max_steps=boot_steps)
        except RuntimeError as e:                               # главный цикл не возвращается
            assert 'не вернулась' in str(e), e
        self.ready = self.hw.uc_events()                        # «ucode ready»
        self.log = []                                           # (тип команды, [типы событий])
        self.feed(fw.boot_lmac_cmds)                            # fw их уже отправила при загрузке (ответы — заглушки)

    def _track_tx(self):
        """Кадры fw в кольце маяка (tx_api_2 → очередь MAC 30): маяк стоит в очереди (H-MACQ); новые кадры колец
        управления/данных — в очереди MAC 0x1a/0x19 (H-MACQ2)."""
        new = self.fw.tx_frames[self.tx_seen:]
        self.tx_seen = len(self.fw.tx_frames)
        for r, f in new:
            for qid, (name, a) in self.q_rings.items():
                if a <= r < a + 0x90:
                    self.hw.mac_q.setdefault(qid, []).append(bytes(f))
                    self.hw.mac_q_pending |= 1 << qid
                    self.hw._backoff_kick()
        for r, f in self.fw.tx_frames:
            if self.bcon_ring[0] <= r < self.bcon_ring[1]:
                self.hw.mac_q_pending |= 1 << 30
                self.bcon_frame = f                             # шаблон маяка — для эфира (air.Air)
                self.hw.sweep_len = len(f) + 4                  # PSDU маяка (MPDU + FCS) — MAC знает по кадру в очереди

    def to_uc(self):
        c = self.uc.cpu
        for a in range(*SHARED):
            c.write(a, bytes([self.fw.cpu.mem.get(a, 0)]))

    def to_fw(self):
        c = self.uc.cpu
        for a in range(*SHARED):
            self.fw.cpu.mem[a] = c.read(a, 1)

    def feed(self, cmds):
        """Команды LMAC fw → uc по одной: запись кольца, исполнение uc до прочтения команды и затишья; события uc."""
        hw, c, out = self.hw, self.uc.cpu, []
        for cmd in cmds:
            self._track_tx()
            self.to_uc()
            hw.lmac_cmd(cmd.type, cmd.body)
            slot = hw.MBOX_DESC + 0x80 + 8 * ((hw._cmd_wr - 1) % 16)
            ev, quiet = [], None
            for _ in range(self.cmd_steps):
                c.step()
                ev += hw.uc_events()
                if quiet is None and not hw._mmio32(slot):        # uc прочитал команду
                    quiet = 3000
                elif quiet is not None:
                    quiet -= 1
                    if quiet == 0:
                        break
            else:
                raise RuntimeError('uc не прочитал команду LMAC %#x за %d шагов' % (cmd.type, self.cmd_steps))
            self.to_fw()
            self.log.append((cmd.type, [t for t, _ in ev]))
            out += ev
        return out

    def _reply(self, fw, cmd):
        return self.feed([cmd])

    def run_us(self, us):
        """uc дальше во времени модели (фон, тики, TBTT) — us мкс."""
        self._track_tx()
        self.to_uc()
        hw, c = self.hw, self.uc.cpu
        end = hw.now + int(us * 165)
        while hw.now < end:
            c.step()
        self.to_fw()
        return hw.uc_events()

    # ---- fw во времени модели (эфир нескольких узлов, air.Air) ----
    FW_TICK_CLK = 16 * 165                                      # тик u_schd (HW_SYS_TIMER_NOW) — 16 мкс

    def live(self):
        """Перевести узел в режим «fw во времени модели»: часы u_schd идут за часами MAC (тик 16 мкс), TSF fw — TSF
        модели; дальше fw работает только из pump() (события uc, сроки своих таймеров), команды LMAC — в ящик uc без
        исполнения (исполняет uc в общем цикле)."""
        fw, hw = self.fw, self.hw
        fw.mmio_read_hook[F.HW_MAC_TSF_LO] = lambda f, a: hw.tsf_us() & F.M32
        fw.mmio_read_hook[F.HW_MAC_TSF_HI] = lambda f, a: hw.tsf_us() >> 32
        self.fw_tick0 = (fw.now() - hw.now // self.FW_TICK_CLK) & F.M32
        self.cmd_seen = len(fw.lmac_cmds)
        fw._uc_seen = self.cmd_seen
        self.fw_log = []                                        # (такт, что)
        self.rx_q = []
        self.host_q = []
        self.host_ring = {}                                     # кольцо хоста → [кадр] (ещё не в очереди MAC)
        self.host_done = []                                     # (такт, кольцо, статус) — завершения кадров хосту
        self.host_rx = []                                       # (такт, кадр) — данные, принятые хостом
        self.dma_irq = 0
        self.seq = 0
        fw.mmio[HW_TXQ_PTP_AVAIL] = F.M32                       # H-DMA2: очереди TXQ доступны (fw: assert 0x12a1)
        self.qdesc = {}
        fw.mmio_write_hook[HW_QDESC_WIN_CTRL] = lambda f, a, v: self._qdesc_op(v)
        self._next_fw = self._fw_deadline()

    def _fw_tick(self):
        return (self.fw_tick0 + self.hw.now // self.FW_TICK_CLK) & F.M32

    def _fw_deadline(self):
        """Такт модели ближайшего таймера fw (None — таймеров нет)."""
        fw, now = self.fw, self.fw.now()
        ds = [((t[3] - now) & F.M32) for t in fw.timers()]
        ds = [d if d < 0x80000000 else 0 for d in ds]
        if not ds:
            return None
        return (self.hw.now // self.FW_TICK_CLK + min(ds)) * self.FW_TICK_CLK

    def wmi(self, cmd_id, body):
        """Команда хоста в живом режиме: fw исполняет её сразу (задачи u_schd), команды LMAC — в ящик uc."""
        self.host_q.append((cmd_id, bytes(body)))
        self.pump()

    def host_tx(self, vr, da, payload, ethertype=0x0800):
        """Хост (драйвер) кладёт кадр 802.3 в кольцо TX vr и пишет хвост (H-DMA2): бит vr в DMA_RINGS_WITH_DATA,
        прерывание DMA vring у fw (вектор 9 — vring_schd_move_ready_if_idle). В очередь MAC vr кадры переносит DMA,
        пока fw держит кольцо включённым (TXQ_RING_ENABLE, mac_ring_enable при привязке к pring)."""
        to_ds = bytes(getattr(self, 'bssid', self.mac)) != bytes(self.mac)
        f = data_frame(self.mac, da, getattr(self, 'bssid', self.mac), to_ds, self.seq, payload, ethertype)
        self.seq += 1
        self.host_ring.setdefault(vr, []).append(f)
        self.dma_irq |= 1 << vr

    def _dma(self):
        """DMA колец хоста (H-DMA2): кольца с кадрами — в DMA_RINGS_WITH_DATA fw; включённые fw — в очереди MAC."""
        fw, hw = self.fw, self.hw
        en = fw.mmio_get(HW_TXQ_RING_ENABLE)
        for vr, ring in self.host_ring.items():
            if ring and en >> vr & 1:
                hw.mac_q.setdefault(vr, []).extend(ring)
                ring.clear()
                hw.mac_q_pending |= 1 << vr
                hw._backoff_kick()
        bits = sum(1 << vr for vr, ring in self.host_ring.items() if ring)
        if fw.mmio_get(HW_DMA_RINGS_WITH_DATA) != bits:
            fw.mmio[HW_DMA_RINGS_WITH_DATA] = bits

    def _qdesc_op(self, ctrl):
        """H-QDESC: окно дескрипторов очередей MAC — запуск записью CTRL (б30): CMD б31 — запись, [22:20] — тип;
        ADDR [1:0] — номер слова-группы, [3:2] — размер (2 — два слова, иначе четыре), [8:4] — очередь. Запись
        сохраняет DATA0..3, чтение их возвращает (не писали — нули). Указатели очередей модель MAC не двигает: для fw
        очередь всегда пуста (tx_macq_is_empty)."""
        if not ctrl & (1 << 30):
            return
        fw = self.fw
        cmd, addr = fw.mmio_get(HW_QDESC_WIN_CMD), fw.mmio_get(HW_QDESC_WIN_ADDR)
        key = ((cmd >> 20) & 7, (addr >> 4) & 0x1f, addr & 3)
        n = 2 if (addr >> 2) & 3 == 2 else 4
        if cmd >> 31:
            self.qdesc[key] = [fw.mmio_get(HW_QDESC_WIN_DATA0 + 4 * i) for i in range(n)]
            # H-AMPDU: соглашение BA очереди — дескриптор типа 2: индекс 1, слово 1 б0 (включено), индекс 0, слово 1
            # [15:6] — окно (fw после WMI_RING_BA_EN/ADDBA: 0 → 1 и 0x800 = окно 32)
            t, q = key[0], key[1]
            d1, d0 = self.qdesc.get((2, q, 1)), self.qdesc.get((2, q, 0))
            if t == 2 and d1 and d0 and len(d1) > 1 and len(d0) > 1:
                self.hw.q_agg[q] = (d0[1] >> 6) & 0x3ff if d1[1] & 1 else 0
        else:
            ws = list(self.qdesc.get(key, [0] * n)[:n])
            if key[0] == 2 and key[2] == 0 and ws:
                # слово 0 дескриптора очереди — указатели [15:0]/[31:16], их ведёт MAC: очередь для fw пуста (равны)
                ws[0] = (ws[0] & 0xffff) * 0x10001
            for i, w in enumerate(ws):
                fw.mmio[HW_QDESC_WIN_DATA0 + 4 * i] = w

    def rx_to_fw(self, frame, cid=0, short_hdr=False):
        """Принятый кадр → fw (H-FWRX): буфер rx_ring как у разбора кольца DMA (rx_dma_ring_reap: len, qid — тип
        заголовка, cid — индекс отправителя у MAC), затем rx_pkt_srvs_dispatch_default — классификация fw."""
        self.rx_q.append((bytes(frame), cid, short_hdr))

    def pump(self):
        """fw по событиям: события uc → fw (lmac_evt), принятые кадры (rx_to_fw), сроки таймеров fw, новые команды
        LMAC → ящик uc. True — fw что-то делал (общая память передана обратно uc)."""
        hw, fw = self.hw, self.fw
        if hw.q_done:                                           # MAC завершил кадры очередей — DMA → fw (статус)
            self.to_fw()
            done, hw.q_done = hw.q_done, []
            for qid, st in done:
                if qid < VRINGS:                                # кольцо хоста: статус дескриптора — хосту
                    self.host_done.append((hw.now, qid, st))
                    continue
                self.fw_log.append((hw.now, 'txdone %#x st %d' % (qid, st)))
                fw.tx_complete(self.q_rings[qid][0], status=st)
            self._after_fw()
        ev = []
        if hw.uc2fw:                                            # uc поднял причину для fw (ICS) — читать ящик
            hw.uc2fw = 0
            ev = hw.uc_events()
        due = self._next_fw is not None and hw.now >= self._next_fw
        if not ev and not due and not self.rx_q and not self.host_q and not self.dma_irq:
            return False
        self.to_fw()
        tick = self._fw_tick()
        if ((tick - fw.now()) & F.M32) < 0x80000000:
            fw.advance(((tick - fw.now()) & F.M32) << 4)        # сроки таймеров до «сейчас»
        if self.dma_irq:                                        # прерывание DMA vring (isr_vring_dma_fw)
            self._dma()
            fw.mmio[HW_DMA_FW_ICR_C40_ICM] = self.dma_irq
            self.dma_irq = 0
            self.fw_log.append((hw.now, 'dma irq %#x' % fw.mmio_get(HW_DMA_FW_ICR_C40_ICM)))
            fw.call('isr_vring_dma_fw')
            fw.mmio[HW_DMA_FW_ICR_C40_ICM] = 0
            fw.run_tasks()
        for typ, body in ev:
            self.fw_log.append((hw.now, 'evt %#x' % typ, bytes(body).hex()))
            fw.lmac_evt(typ, body)
        host, self.host_q = self.host_q, []
        for cmd_id, body in host:
            self.fw_log.append((hw.now, 'wmi %#x' % cmd_id))
            fw.wmi(cmd_id, body)
            fw.run_tasks()
        rx, self.rx_q = self.rx_q, []
        for frame, cid, short in rx:
            self.fw_log.append((hw.now, 'rx %04x' % int.from_bytes(frame[:2], 'little')))
            p = fw.rx_pkt(frame, cid=cid, short_hdr=short)
            fw.call('rx_pkt_srvs_dispatch_default', p)
            fw.run_tasks()
        for cmd in fw.lmac_cmds[self.cmd_seen:]:
            self.fw_log.append((hw.now, 'cmd %#x' % cmd.type))
            hw.lmac_cmd(cmd.type, cmd.body)
        self.cmd_seen = len(fw.lmac_cmds)
        fw._uc_seen = self.cmd_seen
        self._after_fw()
        return True

    def _after_fw(self):
        hw, fw = self.hw, self.fw
        for cmd in fw.lmac_cmds[self.cmd_seen:]:
            self.fw_log.append((hw.now, 'cmd %#x' % cmd.type))
            hw.lmac_cmd(cmd.type, cmd.body)
        self.cmd_seen = len(fw.lmac_cmds)
        fw._uc_seen = self.cmd_seen
        self._track_tx()
        if hasattr(self, 'host_ring'):
            self._dma()
        self.to_uc()
        self._next_fw = self._fw_deadline()

    def __enter__(self):
        self._orig = F.uc_reply
        F.uc_reply = self._reply
        return self

    def __exit__(self, *exc):
        F.uc_reply = self._orig
