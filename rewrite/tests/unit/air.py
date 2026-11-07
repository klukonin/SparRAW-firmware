# SPDX-License-Identifier: AGPL-3.0-or-later
"""Эфир нескольких узлов: каждый узел — совместный прогон fw + uc (cosim.CoSim) со своей моделью MAC; передача одного
узла — приём у остальных (кадр в буфер приёма uc, отчёт r36..r39).

    air = Air([ap, sta])                # узлы: CoSim; часы — общие (H-SYNC: TSF синхронизирован, сетка TBTT одна)
    air.run_us(30_000)                  # все узлы вперёд во времени

Синхронизация консервативная, без опережения: шагает узел с наименьшим горизонтом (работающий — его часы, спящий
без доставляемого прерывания — время его следующего события железа: до него он ничего не передаст), остальные не
дальше этого горизонта (machw.bound — и во сне). Передачу machw объявляет при постановке (on_tx), начало — не раньше
часов передатчика; приёмник не дальше их на одну свою инструкцию: начало, попавшее внутрь неё, обрабатывается на её
конце — так же, как любое событие железа одного узла (machw._run_due после шага). Раньше начала этой инструкции —
ошибка синхронизации (ModelGapAir).

Допущения (метки H-*):
- H-SYNC: TSF узлов совпадает (одна сетка TBTT), задержки распространения нет;
- H-RXBUF: MAC кладёт принятый кадр (PSDU с Frame Control) в буфер приёма uc с 0x804010 (uc/dccm.h rx_buf_*);
- H-RXREP: отчёт о принятом маяке своей BSS — значения стенда (метка STAMP_BCN_REP, 1742 маяка vendor-AP, все
  одинаковые): r36 0x80, r37 0, r38 0xe0001009, r39 0x08000040; SSW — ssw_report (метка STAMP_SSW_REP); отчёт готов
  на rx_frame_event (H-RXREP-HDR);
- канал идеальный: каждый кадр каждого сектора принимается (модели антенн/секторов нет)."""
from machw import ctrl_txtime_clk, sc_txtime_clk, BA_LEN, RESP_CMD_DEADLINE_CLK, RESP_CMD_DEADLINE_CTS_CLK

RX_BUF = 0x804010
BCN_REP = {36: 0x80, 37: 0, 38: 0xe0001009, 39: 0x08000040}

FC_SSW, FC_SSW_FB, FC_SSW_ACK = 0x0864, 0x0964, 0x0a64     # Control Frame Extension 8/9/10 (9.3.1.15–17)
# Кадр управления «для нас» (H-RXREP-Q, стенд 2026-10-30, метка STAMP_RESP_REP у AP, переподключения): r36 0x1000004
# (б2 mgmt + б24), r37 0, r38 0xe0000800 (известный отправитель), r39 младший байт 0x50, тип [13:8] у разных кадров разный
# (у Assoc Request не выделен — 0). Ack — по именам полей (r36 б8 imm_ack), не снят.
QFRAME_REP = {36: 0x1000004, 37: 0, 38: 0xe0000000, 39: 0x08000050}
ACK_REP = {36: 0x100, 37: 0, 38: 0xe0000000, 39: 0x08000040}
# H-RXREP-DATA: QoS Data «для нас». Стенд 2026-10-30 (метка STAMP_RESP_REP у AP, кадры данных станции на MCS 1, без
# нагрузки): r36 0x00120002 (б1 qos_data_detected, data_frame_qid [23:19] = 2), r38 0xe0110800 (FCS, индекс отправителя,
# requested_ack_policy [17:16] = 1, received_mcs [24:20] = 1), r39 0x08002c50 (тип 0x2c). В модели: r39 — как на стенде,
# r38 — FCS + индекс отправителя + MCS кадра; data_frame_qid и requested_ack_policy — 0 (связь с TID и Ack Policy
# кадра не установлена)
DATA_REP = {36: 0x2, 37: 0, 38: 0xe0000000, 39: 0x08002c50}
# H-AMPDU (стенд 2026-10-30, iperf, метки STAMP_RESP_REP и STAMP_RESP_WAIT): A-MPDU данных у приёмника — r36 0x00110002,
# r38 FCS + б25 mpdu_aggregation + б12 bap_enable + индекс отправителя + MCS (+ б15 RD — RDG держателя, H-RD),
# r39 0x08023e50; BlockAck у отправителя — r36 0x201 (б9 back), r38 FCS + б12 + индекс + MCS 1, r39 0x08001840
AMPDU_REP = {36: 0x00110002, 37: 0, 38: 0xe2001000, 39: 0x08023e50}
BA_REP = {36: 0x201, 37: 0, 38: 0xe0001000, 39: 0x08001840}
# H-RD: ответ RD (BlockAck + A-MPDU данных ответчика) у держателя TXOP — r36 0x203 (стенд, MAC-STAND «бывает и BlockAck
# вместе с данными встречной стороны»), r38 как у A-MPDU без б15 (стенд, PMC: 0xe2801800)
RD_RESP_REP = {36: 0x203, 37: 0, 38: 0xe2001000, 39: 0x08023e50}
R38_RD = 1 << 15
# H-RXGRP (по именам полей r38 mcast_indication б13 / bcast_indication б14, на стенде не снято): кадр с групповым RA
# (I/G-бит A1, 802.11-2020 9.2.4.3.4) MAC отмечает в отчёте приёма — широковещательный (все единицы) б14, прочий
# групповой б13. uc по ним отличает кадр «для нас» (rx_flow_handle_frame: ADDR2_VALID без MCAST/BCAST/NEIGHBOUR) от
# группового: на групповой ответа через SIFS нет (9.2.4.5.4 Table 9-12, 10.3.2.11), BAP приём не отмечает. Без этих
# битов модель выдавала групповой кадр точки за адресованный станции — uc станции ждал MAC_BAP_RX_UPDATE (r53 б3),
# которого у группового кадра нет (air_rx sifs_resp = False), и висел (метка 0xff31)
R38_MCAST = 1 << 13
R38_BCAST = 1 << 14


def r38_group(ra):
    """Биты группового RA в r38 (H-RXGRP)."""
    if not ra[0] & 1:
        return 0
    return R38_BCAST if bytes(ra) == b'\xff' * 6 else R38_MCAST
# RTS у получателя и DMG CTS у отправителя RTS (стенд 2026-10-30, iperf: STAMP_RESP_REP, STAMP_TXOP_WAIT): r36 б3 у обоих,
# r37 б0 rts / б1 mmWaveCTS, r38 FCS + индекс отправителя, r39 0x08001a40 / 0x0801b340
RTS_REP = {36: 0x8, 37: 0x1, 38: 0xe0000000, 39: 0x08001a40}
CTS_REP = {36: 0x8, 37: 0x2, 38: 0xe0000000, 39: 0x0801b340}


def rx_report(fc, idx, cdown):
    """Отчёт приёма r36..r39 кадра SLS по типу (H-RXREP-SSW, стенд 2026-10-29, метка STAMP_SSW_REP у AP в слоте
    A-BFT, 31 кадр SSW): r36 б6 ss_detected; r37 ss_bitmap б24 SSW / б25 SSW-Feedback / б26 SSW-Ack (у неизвестного
    отправителя SSW — 0xf9000000); r38 FCS ok б29..31 + addr2_match б11 / индекс [10:8]; r39 тип [13:8] (SSW 0x36) +
    б27/б6/б0; б15 zero_cdown при CDOWN 0 — по имени поля (на стенде не попал). SSW-Feedback/Ack — по именам полей
    (тип, б27/6/0 — как у SSW; метка STAMP_FB_REP у станции снимается)."""
    known = idx is not None
    bit = {FC_SSW: 24, FC_SSW_FB: 25, FC_SSW_ACK: 26}.get(fc)
    if bit is None:
        raise ModelGapAir('эфир: отчёт приёма кадра FC %#06x не моделируется' % fc)
    tidx = {FC_SSW: 0x36}.get(fc, 0x36 + bit - 24)
    r37 = (1 << bit) if known or fc != FC_SSW else 0xf9000000
    return {36: 0x40, 37: r37, 38: (0xe0000800 | (idx & 7) << 8) if known else 0xe0000000,
            39: 0x08000041 | tidx << 8 | (0x8000 if fc == FC_SSW and cdown == 0 else 0)}


def qos_tid(f):
    """TID QoS Data (9.2.4.5.2: QoS Control B0..B3; в DMG QoS Control сразу после Sequence Control, A4 нет). None —
    не QoS Data (тип 2, б7 подтипа = 1 — QoS, 9.2.4.1.3 Table 9-1)."""
    fc = int.from_bytes(f[:2], 'little')
    if (fc >> 2) & 3 != 2 or not fc & 0x80 or len(f) < 26:
        return None
    return f[24] & 0xf


def blockack_frame(ra, ta, tid, ssn, sns):
    """Compressed BlockAck (9.3.1.8.2, рис. 9-41): FC (Control, подтип 9), Duration (в модели 0: MAC собирает
    ответ сам, значение не снято), RA, TA, BA Control (рис. 9-42: Multi-TID B1 = 0, Compressed Bitmap B2 = 1,
    GCR Mode B3..B4 = 0 — Compressed BlockAck по Table 9-28; TID_INFO B12..B15 = TID), BA Information (рис. 9-43):
    Block Ack Starting Sequence Control (рис. 9-37: Fragment Number B0..B3 = 0, Starting Sequence Number B4..B15),
    Block Ack Bitmap 8 октетов — бит (SN − SSN) mod 4096 на каждый принятый MSDU (9.3.1.8.2)."""
    ctrl = (1 << 2) | (tid & 0xf) << 12
    bm = 0
    for sn in sns:
        d = (sn - ssn) & 0xfff
        if d < 64:
            bm |= 1 << d
    return ((0x0094).to_bytes(2, 'little') + bytes(2) + bytes(ra) + bytes(ta) + ctrl.to_bytes(2, 'little') +
            ((ssn & 0xfff) << 4).to_bytes(2, 'little') + bm.to_bytes(8, 'little'))


def qos_ack_policy(f):
    """Ack Policy QoS Data/QoS Null (9.2.4.5.4: QoS Control B5..B6; Table 9-13: 0 Normal Ack или Implicit BAR,
    1 No Ack, 2 No explicit acknowledgment / PSMP Ack, 3 Block Ack). None — кадр не QoS Data (тип 2, б7 подтипа)."""
    fc = int.from_bytes(f[:2], 'little')
    if (fc >> 2) & 3 != 2 or not fc & 0x80 or len(f) < 26:
        return None
    return (f[24] >> 5) & 3


def rx_dup_cache_key(f):
    """Кэш обнаружения дубликатов приёмника (802.11-2020 10.3.2.14.3, Table 10-6) для кадра Data/Management:
    QoS Data — RC2, индекс <Address 2, TID>; QoS (+)Null — RC3, кэша нет (None); прочие Data — RC1, <Address 2>;
    Management — RC4, <Address 2>. Запись кэша — <sequence number, fragment number> (Sequence Control целиком)."""
    fc = int.from_bytes(f[:2], 'little')
    typ, sub = (fc >> 2) & 3, (fc >> 4) & 0xf
    a2 = bytes(f[10:16])
    if typ == 2 and sub & 0x8:
        if sub & 0x4:
            return None                                     # QoS Null / QoS CF-Poll и т. п. без данных — RC3
        return ('qos', a2, qos_tid(f))
    if typ == 2:
        return ('data', a2)
    if typ == 0:
        return ('mgmt', a2)
    return None


def rx_is_duplicate(cache, f):
    """10.3.2.14.3: запись принятого кадра вносится в кэш; при Retry = 1 (FC B11) кадр с той же записью
    <SN, FN> в своём кэше — дубликат (отбрасывается). True — дубликат."""
    key = rx_dup_cache_key(f)
    if key is None:
        return False
    fc = int.from_bytes(f[:2], 'little')
    sc = int.from_bytes(f[22:24], 'little')                 # Sequence Control: FN B0..B3, SN B4..B15 (9.2.4.4)
    dup = bool(fc & 0x0800) and cache.get(key) == sc
    cache[key] = sc
    return dup


class ModelGapAir(RuntimeError):
    pass


class Air:
    drop = None                                             # callable(src, кадр, rec) → True: кадр не принял никто

    def __init__(self, nodes):
        self.nodes = list(nodes)
        self.log = []                                       # (такт, отправитель, приёмник, описание)
        # кадры в эфире для эталона (tests/ref): начало и конец PPDU в тактах, отправитель, байты кадра (A-MPDU — список),
        # Duration (мкс), MCS, описание MAC
        self.frames = []
        for n in self.nodes:
            n.hw.on_tx = (lambda src: lambda rec: self._tx(src, rec))(n)
            n.hw.collisions = []
            if not hasattr(n, 'peer_idx'):
                n.peer_idx = {}                             # адрес → индекс в таблице станций MAC (addr2_match_index)

    def _frame(self, src, rec):
        """Байты кадра в эфире и отчёт приёма (функция приёмника → {36..39}).
        - маяк развёртки (шаблон fw в кольце маяка, FIFO нет): шаблон с Duration (machw._dur_field), TSF на момент
          передачи, полем SSW (0x2d) и BI Control (0x2a/0x2b) — H-BIC: эти поля MAC пишет сам;
        - кадр из FIFO прямой передачи (FC, Duration, RA, тело): H-TAMAC — MAC вставляет после RA свой адрес (TA) и,
          у кадра SSW, поле SSW (0x2d); сколько вставлено — разность длины MPDU из 0x34 и FIFO (9 — TA + SSW,
          6 — TA): SSW 13 + 9 = 22 (9.3.1.15), SSW-Feedback 18 + 6 = 24 (9.3.1.16). Duration — 0x15 (H-DUR)."""
        ssw = (rec['ssw'] & 0xffffff).to_bytes(3, 'little')
        if isinstance(rec.get('qframe'), list):
            # H-AMPDU: A-MPDU — в буфер приёма первый MPDU, хосту — все; Duration — MAC (H-DURQ, machw._dur_field)
            f = bytes(rec['qframe'][0])
            f = f[:2] + (rec['dur_us'] & 0xffff).to_bytes(2, 'little') + f[4:]
            mcs = rec.get('mcs', 0) & 0x1f
            if rec.get('rd_resp'):
                return f, (lambda dst: {**RD_RESP_REP, 38: RD_RESP_REP[38] | self._r38(dst, src) | mcs << 20})
            rd = R38_RD if rec.get('rdg') else 0
            return f, (lambda dst: {**AMPDU_REP, 38: AMPDU_REP[38] | self._r38(dst, src) | mcs << 20 | rd})
        if rec['what'].startswith('ответ на') and 'A-MPDU' in rec['what']:
            # BlockAck на A-MPDU — Compressed (9.3.1.8.2): TID и номера MPDU — из принятого A-MPDU (resp_ba, _tx)
            tid, ssn, sns = getattr(src, 'resp_ba', (0, 0, ()))
            m = rec.get('mcs', 1) & 0x1f
            # Duration ответа — Duration A-MPDU − SIFS − TXTIME(BlockAck) (9.2.5.7; стенд: 519…1914 при данных ~1952)
            t_ba = -(-(sc_txtime_clk(BA_LEN, m) if m else ctrl_txtime_clk(BA_LEN)) // 165)
            d = max(0, getattr(src, 'resp_dur', 0) - 3 - t_ba)
            f = blockack_frame(getattr(src, 'resp_ra', bytes(6)), src.mac, tid, ssn, sns)
            f = f[:2] + d.to_bytes(2, 'little') + f[4:]
            return f, (lambda dst: {**BA_REP, 38: BA_REP[38] | self._r38(dst, src) | m << 20})
        if rec.get('qframe') is not None:
            # H-MACQ2: кадр очереди MAC — MPDU, собранный fw; отчёт приёма — по именам полей (не снят со стенда);
            # Duration — MAC (H-DURQ, machw._dur_field)
            f = bytes(rec['qframe'])
            f = f[:2] + (rec['dur_us'] & 0xffff).to_bytes(2, 'little') + f[4:]
            if (f[0] >> 2) & 3 == 2:
                mcs = rec.get('mcs', 0) & 0x1f
                ack = qos_ack_policy(f) << 16 if qos_ack_policy(f) is not None else 0   # r38 requested_ack_policy
                return f, (lambda dst: {**DATA_REP, 38: self._r38(dst, src) | mcs << 20 | ack | r38_group(f[4:10])})
            return f, (lambda dst: {**QFRAME_REP, 38: self._r38(dst, src) | r38_group(f[4:10])})
        if rec['what'].startswith('ответ на') and getattr(src, 'resp_kind', None) == 'cts':
            # DMG CTS (9.3.1.13): FC 0x0564, Duration = Duration RTS − (SIFS + TXTIME CTS) вверх, RA — TA RTS, TA — свой
            d = max(0, getattr(src, 'resp_dur', 0) - (3 + -(-ctrl_txtime_clk(20) // 165)))
            f = (0x0564).to_bytes(2, 'little') + d.to_bytes(2, 'little') + bytes(getattr(src, 'resp_ra', bytes(6))) + \
                bytes(src.mac)
            return f, (lambda dst: {**CTS_REP, 38: self._r38(dst, src)})
        if rec['what'].startswith('ответ на'):
            # Ack (9.3.1.4): FC 0x00d4, Duration 0, RA — передатчик кадра, на который ответ (MAC собирает сам)
            f = (0x00d4).to_bytes(2, 'little') + bytes(2) + bytes(getattr(src, 'resp_ra', bytes(6)))
            return f, (lambda dst: dict(ACK_REP))
        q = rec['fifo']
        if rec['what'].startswith('sweep') and q is None:
            tpl = getattr(src, 'bcon_frame', None)
            if tpl is None:
                raise ModelGapAir('эфир: развёртка без FIFO и без шаблона маяка у узла')
            f = bytearray(tpl)
            f[2:4] = (rec['dur_us'] & 0xffff).to_bytes(2, 'little')
            tsf = src.hw.tsf0_us + rec['start'] // 165
            f[0xa:0x12] = tsf.to_bytes(8, 'little')
            f[0x12:0x15] = ssw
            f[0x17:0x1d] = rec['bic']                       # BI Control — MAC из 0x2a/0x2b (H-BIC)
            return bytes(f), (lambda dst: dict(BCN_REP))
        if q is None:
            raise ModelGapAir('эфир: кадр %r без FIFO — содержимое не моделируется' % rec['what'])
        ins = rec['mpdu_len'] - len(q)
        dur = (rec['dur_us'] & 0xffff).to_bytes(2, 'little')
        if ins == 9:
            f = q[0:2] + dur + q[4:10] + src.mac + ssw + q[10:]
        elif ins == 6:
            f = q[0:2] + dur + q[4:10] + src.mac + q[10:]
        elif ins == 12 and int.from_bytes(q[0:2], 'little') == 0x00e4:
            # H-FIFO-CFEND (стенд: CF-End станции в конце TXOP, FIFO — только FC и Duration): MAC вставляет RA — партнёр
            # TXOP (uc ждёт ответный CF-End, 10.39.8.1) — и TA; в эфире двух узлов партнёр — другой узел
            peer = [n for n in self.nodes if n is not src]
            ra = bytes(peer[0].mac) if len(peer) == 1 else b'\xff' * 6
            f = q[0:2] + dur + ra + src.mac
        elif ins == 12 and (q[0] >> 2) & 3 == 0:
            # H-FIFO-MGMT: кадр управления из FIFO (BRP — Action No Ack): FC, Duration, A1, Sequence Control (полуслово
            # r34, mac.c), тело; MAC вставляет A2 (свой адрес) и A3 (BSSID) — 12 + тело → 24 + тело
            bssid = bytes(getattr(src, 'bssid', src.mac))
            f = q[0:2] + dur + q[4:10] + src.mac + bssid + q[10:12] + q[12:]
        else:
            raise ModelGapAir('эфир: кадр %r — MAC вставляет %d октетов (FIFO %s)' % (rec['what'], ins, q.hex()))
        fc = int.from_bytes(q[0:2], 'little')
        cdown = (rec['ssw'] >> 1) & 0x1ff
        if (fc >> 2) & 3 == 0:
            # кадр управления из FIFO: Action No Ack (подтип 14, BRP) — r36 б25 no_action_mgmt + б2 mgmt (по именам
            # полей, не снято); прочие — как кадр очереди (QFRAME_REP, стенд)
            r36 = (1 << 25) | 0x04 if (fc >> 4) & 0xf == 14 else QFRAME_REP[36]
            return bytes(f), (lambda dst: {**QFRAME_REP, 36: r36, 38: self._r38(dst, src)})
        if fc == 0x00b4:
            return bytes(f), (lambda dst: {**RTS_REP, 38: self._r38(dst, src)})
        if fc == 0x00e4:
            # CF-End (9.3.1.8): r37 б16 mmWaveCF_END (по имени поля, не снят)
            return bytes(f), (lambda dst: {36: 0, 37: 1 << 16, 38: self._r38(dst, src), 39: 0x08000040})
        return bytes(f), (lambda dst: rx_report(fc, Air._idx(dst, src), cdown))

    def _tx(self, src, rec):
        frame, report_of = self._frame(src, rec)
        if not hasattr(src.hw, 'air_dur_log'):
            src.hw.air_dur_log = {}
        src.hw.air_dur_log[rec['start']] = rec['dur_us']    # Duration в эфире — для разборов
        qf = rec.get('qframe')
        self.frames.append(dict(rec=rec, start=rec['start'], end=rec['start'] + rec['dur'], src=src, frame=bytes(frame),
                                mpdus=[bytes(x) for x in qf] if isinstance(qf, list) else None,
                                dur_us=rec['dur_us'], mcs=rec.get('mcs', 0), what=rec['what']))
        if self.drop is not None and self.drop(src, frame, rec):
            # потеря кадра в эфире (тесты живучести): в эфире был (журнал передатчика, frames), не принял никто
            self.frames[-1]['dropped'] = True
            return
        for dst in self.nodes:
            if dst is src:
                continue
            if rec['start'] < dst.t_prev:
                raise ModelGapAir('эфир: кадр %r начинается в %d, приёмник уже прошёл %d' % (rec['what'], rec['start'],
                                                                                          dst.t_prev))
            self.log.append((rec['start'], src, dst, rec['what']))

            def hdr(hw, frame=frame, dst=dst):
                for i, b in enumerate(frame):               # H-RXBUF
                    dst.uc.cpu.write(RX_BUF + i, bytes([b]))
            fc = int.from_bytes(frame[:2], 'little')
            rts = fc == 0x00b4 and frame[4:10] == bytes(dst.mac)
            # Ack Policy No Ack (QoS Control B5..B6 = 1, 9.2.4.5.4): ответа через SIFS нет (QoS Null MAC, H-QNULL)
            noack = not isinstance(rec.get('qframe'), list) and qos_ack_policy(frame) == 1
            uni = (rec.get('qframe') is not None or rts) and frame[4:10] == bytes(dst.mac) and not noack
            if uni:
                dst.resp_ra = bytes(src.mac)                # Ack — тому, кто прислал
                dst.resp_kind = 'cts' if rts else 'ack'
                dst.resp_dur = rec['dur_us'] & 0xffff
                if isinstance(rec.get('qframe'), list):
                    # BlockAck: TID A-MPDU (одного TID, 10.12.2) и номера MPDU; SSN — наименьший (окно с первого)
                    fs = [bytes(x) for x in rec['qframe']]
                    sns = [int.from_bytes(x[22:24], 'little') >> 4 for x in fs]
                    dst.resp_ba = (qos_tid(fs[0]) or 0, sns[0], sns)
            if fc == 0x00d4 and frame[4:10] == bytes(dst.mac):
                dst.hw.at(rec['start'] + rec['dur'], dst.hw.ack_rx, 'ack_rx')
            if fc == 0x0094 and frame[4:10] == bytes(dst.mac):
                dst.hw.at(rec['start'] + rec['dur'], dst.hw.ba_rx, 'ba_rx')
            if rec.get('rd_resp') and frame[4:10] == bytes(dst.mac):
                dst.hw.at(rec['start'] + rec['dur'], dst.hw.rd_resp_rx, 'rd_resp_rx')   # BlockAck в ответе RD (H-RD)
            ampdu = isinstance(rec.get('qframe'), list)
            report = report_of(dst)
            if ampdu:
                rec.setdefault('reports', []).append(report)   # RDG (r38 б15) — по пуску 0x18 передатчика (H-RD)
            dst.hw.air_rx(rec['start'], len(frame), rec['what'], on_hdr=hdr, report=report, dur=rec['dur'],
                          sifs_resp=uni, resp_len=BA_LEN if ampdu else 20 if rts else 14,
                          resp_deadline=RESP_CMD_DEADLINE_CTS_CLK if rts else RESP_CMD_DEADLINE_CLK,
                          report_at_hdr=True, on_end=lambda hw, fs=(rec['qframe'] if ampdu else [frame]), d=dst, src=src: [
                              self._to_fw(d, src, bytes(x)) for x in fs],
                          nav_us=0 if frame[4:10] == bytes(dst.mac) else self._nav_us(frame, rec),
                          txss_end=self._txss_end(frame, rec), trn=rec.get('trn', 0),
                          mcs=rec.get('mcs', 0))
            if rec['start'] <= dst.hw.now:
                dst.hw._run_due()                           # начало внутри последней инструкции приёмника — на её конце

    @staticmethod
    def _idx(dst, src):
        """Индекс отправителя в таблице станций MAC (addr2_match_index): заданный узлу peer_idx или, если у приёмника
        живой fw, cid соединения с этим адресом (fw программирует MAC по своей таблице соединений)."""
        if bytes(src.mac) in dst.peer_idx:
            return dst.peer_idx[bytes(src.mac)]
        if getattr(dst, 'fw_tick0', None) is not None:
            import fwflows as F
            return F.Fw(dst.fw).cid_of(src.mac)
        return None

    @staticmethod
    def _r38(dst, src):
        idx = Air._idx(dst, src)
        return 0xe0000000 | ((0x800 | (idx & 7) << 8) if idx is not None else 0)

    @staticmethod
    def _txss_end(f, rec):
        """txss_end_ind (r54 б0) у приёмника — по концу SSW с CDOWN 0 (последний кадр развёртки пира; как air_rx
        txss_end в тестах SLS)."""
        return int.from_bytes(f[:2], 'little') == 0x0864 and ((rec['ssw'] >> 1) & 0x1ff) == 0

    @staticmethod
    def _nav_us(f, rec):
        """NAV по принятому кадру (не мне): Duration; у DMG Beacon с A-BFT в этом BI (BI Control: Next A-BFT = 0) —
        ещё MBIFS + длина A-BFT × aSSSlotTime (H-NAVABFT: доступ к среде — только в DTI, после A-BFT, 802.11-2020
        10.42.5; aSSSlotTime = aAirPropagationTime + aSSDuration + MBIFS + aSSFBDuration + MBIFS)."""
        nav = rec['dur_us']
        if int.from_bytes(f[:2], 'little') & 0xff == 0x0c and len(f) >= 0x1d:
            bic = int.from_bytes(f[0x17:0x1d], 'little')
            abft_len, fss, next_abft = (bic >> 7) & 7, ((bic >> 10) & 0xf) + 1, (bic >> 15) & 0xf
            if next_abft == 0:
                ssdur = fss * ctrl_txtime_clk(26) + (fss - 1) * 165
                slot = 17 + ssdur + 9 * 165 + ctrl_txtime_clk(28) + 9 * 165
                nav += -(-(9 * 165 + (abft_len + 1) * slot) // 165)
        return nav

    def _to_fw(self, dst, src, f):
        """H-FWRX — какие принятые кадры MAC отдаёт в кольцо fw: DMG Beacon — первый за BTI (стенд: после ассоциации
        1 маяк за BI, CDOWN первого; при подключении больше — механизм не найден, не моделируется); кадр управления
        (тип 0) на свой адрес; данные (тип 2) на свой адрес и групповые данные своего BSS (A1 — групповой, A2 — BSSID:
        стенд — широковещательный ping и ARP точки станция принимает) — хосту (кольцо RX, host_rx); прочее — нет."""
        if getattr(dst, 'fw_tick0', None) is None:
            return
        fc = int.from_bytes(f[:2], 'little')
        mine = f[4:10] == bytes(dst.mac) or (len(f) >= 16 and f[4] & 1 and (fc >> 2) & 3 == 2 and
                                              f[10:16] == bytes(getattr(dst, 'bssid', b'')))
        if (fc >> 2) & 3 in (0, 2) and mine and len(f) >= 24:
            # 802.11-2020 10.3.2.14.3, Table 10-6: кэш по <A2, TID> у QoS Data, по <A2> у прочих; запись <SN, FN>
            if rx_is_duplicate(dst.__dict__.setdefault('rx_seq', {}), f):
                return
        if (fc >> 2) & 3 == 2 and mine:
            if (fc >> 4) & 0xc == 0xc:
                # QoS Null (подтип 12) — данных нет, MAC в очередь не отдаёт (стенд, PMC: w0 б16 у принятого QoS Null)
                dst.rx_qos_null.append((dst.hw.now, bytes(f)))
                return
            dst.host_rx.append((dst.hw.now, f))
            return
        if fc & 0xff == 0x0c:                                # Extension, подтип 0 — DMG Beacon
            cdown = (int.from_bytes(f[0x12:0x15], 'little') >> 1) & 0x1ff
            last = getattr(dst, '_bcn_fw_at', None)
            if last is not None and dst.hw.now - last < 165 * 2000:
                return                                       # не первый в этом BTI
            dst._bcn_fw_at = dst.hw.now
            dst.rx_to_fw(f, short_hdr=True)
        elif (fc >> 2) & 3 == 0 and f[4:10] == bytes(dst.mac):
            idx = self._idx(dst, src)
            dst.rx_to_fw(f, cid=(idx if idx is not None else 0) & 7)

    @staticmethod
    def _horizon(n):
        c = n.uc.cpu
        if c.sleeping and c.irq_ready() is None:
            t = n.hw._next_t()
            f = getattr(n, '_next_fw', None) if getattr(n, 'fw_tick0', None) is not None else None
            ts = [x for x in (t, f) if x is not None]
            return float('inf') if not ts else max(min(ts), n.hw.now)
        return n.hw.now

    def run_us(self, us):
        """Все узлы вперёд на us мкс (от самых поздних часов)."""
        for n in self.nodes:
            if getattr(n, 'fw_tick0', None) is None:
                n._track_tx()
                n.to_uc()
            n.t_prev = n.hw.now
        end = max(n.hw.now for n in self.nodes) + int(us * 165)
        while True:
            hz = [self._horizon(n) for n in self.nodes]
            i = min(range(len(self.nodes)), key=hz.__getitem__)
            if hz[i] >= end:
                break
            n = self.nodes[i]
            bound = min([end] + [h for j, h in enumerate(hz) if j != i])
            if getattr(n, 'fw_tick0', None) is not None and n._next_fw is not None:
                bound = min(bound, max(n._next_fw, n.hw.now + 1))   # срок таймера fw — граница и во сне
            n.hw.bound = bound
            c = n.uc.cpu
            live = getattr(n, 'fw_tick0', None) is not None
            if not hasattr(n, '_assert_pc'):
                n._assert_pc = {n.uc.sym[k] & 0x1ffff for k in ('uc_assert',) if k in n.uc.sym}
            while True:
                if (c.pc & 0x1ffff) in n._assert_pc:
                    raise ModelGapAir('uc узла %s: uc_assert(%#x) из %s' % (
                        bytes(n.mac).hex() if hasattr(n, 'mac') else '?', c.regs[1], n.uc.where(c.regs[0])))
                n.t_prev = n.hw.now
                c.step()
                if live:
                    n.pump()
                if n.hw.now >= bound or (c.sleeping and c.irq_ready() is None):
                    break
        for n in self.nodes:
            n.hw.bound = None
            if getattr(n, 'fw_tick0', None) is None:
                n.to_fw()
        return [n.hw.uc_events() for n in self.nodes]
