# SPDX-License-Identifier: AGPL-3.0-or-later
"""DTI по расписанию (этап 4, п. 2): Extended Schedule, SP, CBAP-распределения, динамическое распределение (PP/GP),
усечение, продление и восстановление SP — часть DMG MAC ядра (примесь к mac.DmgMac). Правила — 802.11-2020, номера
пунктов в комментариях; модели и судьи — ref/schedule, ref/sp, ref/dynalloc, ref/bi (используются, не дублируются).

Точка (AP):
  - расписание BI — политика SME (sched_policy: BI → [schedule.Req]); schedule.plan строит Extended Schedule
    (9.4.2.131) от конца BHI: guard time между распределениями (10.39.6.5), aDMGPPMinListeningTime между SP с общей STA
    (10.39.6.2); Allocation Start — младшие 32 бита TSF; элемент — в каждом DMG Beacon BTI (DMG Parameters: CBAP Only
    = 0, 9.4.1.46); без политики — CBAP Only, как этапы 1–3;
  - PP/GP в SP broadcast/broadcast (10.39.7.2, 10.39.7.3): Poll каждой связанной STA через SBIFS (Duration и Response
    Offset — ур. (10-18), duration.pp_schedule), SPR в ответ; затем GP: Grant каждой запросившей STA, начало выделения =
    PHY-TXEND Grant + Duration; следующий GP — после конца выделения;
  - продление SP (10.39.9): на SPR в Extendable SP — Grant через SIFS; гарантирует, только если следующий SP —
    broadcast/broadcast и длиннее запрошенного, иначе отказ (Allocation Duration 0);
  - восстановление SP (10.39.6.7): AP-получатель Truncatable SP, не получивший ни одного кадра источника за
    dot11SPIdleTimeout от начала SP, усекает SP и отдаёт остаток источнику Grant-ом (10.39.7).
Станция и точка в SP/выделении:
  - источник начинает обмен в начале SP (10.39.6.2), получатель отвечает через SIFS; обмены — A-MPDU с BlockAck (или
    MSDU с Ack) без RTS, каждый — с ответом до конца SP («In no case …»); повтор без ответа — через PIFS (10.39.6.2);
  - очередь пуста, SP Truncatable — усечение (10.39.8.1): CF-End к AP (если AP не пир), затем CF-End пиру;
  - очередь не опустела к концу Extendable SP — SPR продления к AP (10.39.9), при гранте — Grant партнёру (если партнёр
    не AP) и обмен до продлённого конца;
  - EDCA — только в CBAP-распределениях, где STA вправе начинать обмен (10.39.5: broadcast или Source/Destination AID
    = свой); между окнами EDCAF и NAV заморожены (10.39.5).
Станция: Extended Schedule — из DMG Beacon своего BSS (schedule.StaView: псевдостатичные при пропуске маяка,
obsolete allocation, 10.39.6.1/10.39.6.4); на Poll — SPR через Response Offset (DAI: запрошенное время под свою очередь
к AP); на Grant себе — выделение (SP с собой источником), Grant Ack через SIFS, если объявлен Grant Ack Supported.

Не исполняется: ATI (Announce, Poll в ATI, восстановление по ATI 10.39.6.7 второй абзац), DMG protected period
(10.39.6.6, DTS), уступка SP Grant-ом (relinquish), усечение Grant-ом с CBAP, Heartbeat, BF в SP по Beamforming
Training, spatial sharing, PCP Active = 0, псевдостатичные распределения с несколькими блоками."""
from fractions import Fraction as Fr
from math import ceil

from .. import bi as BI
from .. import duration as D
from .. import fields as F
from .. import schedule as S
from .. import sp as SPm
from ..timing import (AID_AP_PCP, AID_BROADCAST, ALLOC_CBAP, ALLOC_SP, BCAST, DOT11_SP_IDLE_TIMEOUT, PIFS, SBIFS,
                      SIFS, TU, aAirPropagationTime, aTSFResolution, txtime, txtime_control)
from . import frames as FR
from . import sap_phy as P

T_POLL, T_SPR, T_GRANT, T_GRANT_ACK = D.tx('poll'), D.tx('spr'), D.tx('grant'), D.tx('grant_ack')
T_CF_END = txtime_control(20)
SP_RETRY = 3                              # повторов обмена в SP без ответа (через PIFS)
CBAP_MAX = 65535                          # 9.4.2.131: Allocation Block Duration CBAP ≤ 65 535 мкс
SP_MAX = 32767                            # … SP ≤ 32 767 мкс
EXT_REQ_MAX = 4000                        # не больше стольких мкс просить продлением за раз (выбор STA)


# ===================================================================================================== политики SME
def policy_sp(ul_us=4000, dl_us=4000, dyn_us=0, cbap_rest=True, truncatable=1, extendable=0, pseudo_static=0,
              cbap_first_us=0, dyn_first=False):
    """Расписание «SP на станцию» (выбор точки, 10.39.6.2): CBAP broadcast cbap_first_us (вход новых станций, кадры
    управления); каждой связанной STA — SP STA → AP (ul_us) и SP AP → STA (dl_us); SP broadcast/broadcast под
    динамическое распределение (dyn_us, PP/GP; dyn_first — перед SP станций); CBAP broadcast на остаток BI
    (cbap_rest; блоками ≤ 65 535 мкс)."""
    def plan(mac, k):
        out = []
        if cbap_first_us and mac.assoc_aids():
            out.append(S.Req(S.CBAP, AID_BROADCAST, AID_BROADCAST, cbap_first_us, pseudo_static))
        if dyn_us and dyn_first and mac.assoc_aids():
            out.append(S.Req(S.SP, AID_BROADCAST, AID_BROADCAST, dyn_us, pseudo_static, 1, 0))
        for aid in mac.assoc_aids():
            if ul_us:
                out.append(S.Req(S.SP, aid, AID_AP_PCP, ul_us, pseudo_static, truncatable, extendable))
            if dl_us:
                out.append(S.Req(S.SP, AID_AP_PCP, aid, dl_us, pseudo_static, truncatable, extendable))
        if dyn_us and not dyn_first and mac.assoc_aids():
            out.append(S.Req(S.SP, AID_BROADCAST, AID_BROADCAST, dyn_us, pseudo_static, 1, 0))
        if cbap_rest:
            out.append('rest')
        return out
    return plan


def policy_cbap_split(common_us=2000, min_sta=2):
    """Расписание «CBAP на станцию» (как простой TDMA open прошивки: общее CBAP broadcast, затем CBAP {Source = STA,
    Destination = AP} поровну; псевдостатичные, 10.39.5, 10.39.6.4); меньше min_sta станций — CBAP Only."""
    def plan(mac, k):
        aids = mac.assoc_aids()
        if len(aids) < min_sta:
            return None
        out = [S.Req(S.CBAP, AID_BROADCAST, AID_BROADCAST, common_us, 1)]
        out += [('split', aid) for aid in aids]
        return out
    return plan


# ===================================================================================================== примесь
class DtiMixin:
    """Расписание DTI, SP и динамическое распределение — для mac.DmgMac (роль — ap.DmgApMac / sta.DmgStaMac)."""

    def _dti_init(self):
        self.sched_policy = None             # AP: политика SME (BI → [Req]); None — CBAP Only
        self.sview = None                    # STA: schedule.StaView
        self.sp_rx_seen = {}                 # SP (ключ) → момент первого кадра источника (10.39.6.7)
        self.dti_log = []                    # (k, [Period]) — для тестов
        self.grant_ack_supported = 0         # DMG Capabilities: Grant Ack Supported (10.39.4)

    def my_aid(self):
        return AID_AP_PCP if self.ROLE == 'AP' else (self.aid or None)

    # ------------------------------------------------------------------ AP: построение расписания
    def assoc_aids(self):
        return sorted(a for a in (self.peers[s].aid for s in self.associated()) if a)

    def _dti_entries(self, k, bhi_end):
        """[schedule.Entry] BI k по политике SME или None (CBAP Only). «Поровну» (split) и «остаток» (rest) — время до
        следующего TBTT после фиксированных распределений с guard time (10.39.6.5) и aDMGPPMinListeningTime."""
        if self.sched_policy is None:
            return None
        reqs = self.sched_policy(self, k)
        if not reqs:
            return None
        t_next = BI.tbtt(k + 1, self.bi_tu)
        fixed = [r for r in reqs if isinstance(r, S.Req)]
        splits = [r[1] for r in reqs if isinstance(r, tuple) and not isinstance(r, S.Req) and r[0] == 'split']
        rest = 'rest' in reqs
        ps = fixed[-1].pseudo_static if fixed else int(bool(splits))
        t_cur = Fr(ceil(bhi_end))
        if fixed:
            t_cur = S.plan(k, self.bi_tu, bhi_end, fixed)[-1].alloc.blocks(BI.tbtt(k, self.bi_tu))[-1][1]
        slack = Fr(0)
        for _ in range(8):
            g = BI.guard_between(True, True, self.bi_tu * TU) + 1
            avail = int(t_next - t_cur - slack) - 1
            out = list(fixed)
            if splits:
                each = (avail - g * len(splits)) // len(splits)
                out += [S.Req(S.CBAP, aid, AID_AP_PCP, max(1, min(each, CBAP_MAX)), 1) for aid in splits]
            elif rest:
                left = avail - g
                while left > 0:
                    d = min(left, CBAP_MAX)
                    out.append(S.Req(S.CBAP, AID_BROADCAST, AID_BROADCAST, d, ps))
                    left -= d + g
            if not out:
                return None
            try:
                return S.plan(k, self.bi_tu, bhi_end, out)
            except S.ScheduleError:
                slack += 64 + slack                # не уместилось (guard, окружение до мкс) — короче
        raise S.ScheduleError(f'расписание BI {k} не строится')

    # ------------------------------------------------------------------ периоды BI → окна доступа
    def _dti_periods(self, k, entries, bic, params, bti_end_tsf):
        cfg = BI.BiConfig(bic=bic, params=params, allocations=[e.alloc for e in entries])
        return BI.layout(k, self.bi_tu, cfg, bti_end_tsf)

    def _dti_apply(self, k, periods, margin=0):
        """Периоды BI k (TSF) → окна CBAP, где можно начинать обмен (10.39.5), и SP/broadcast SP (10.39.6.2, 10.39.7)."""
        aid = self.my_aid()
        tm = self.t_of_tsf
        self.dti_log.append((k, periods))
        del self.dti_log[:-8]
        wins = [(tm(p.start), tm(p.end)) for p in periods
                if p.kind == S.CBAP and SPm.cbap_may_initiate(aid, p, cbap_only=p.cbap_only)]
        self._cbap_chain(wins, margin)
        for p in periods:
            if p.kind != S.SP or p.alloc is None:
                continue
            s, e = tm(p.start), tm(p.end)
            if e <= self.sim.now:
                continue
            if p.src_aid == AID_BROADCAST and p.dst_aid == AID_BROADCAST:
                if p.alloc.key() in getattr(self, 'cluster_sp_keys', ()):
                    continue                  # Beacon SP другой точки кластера (10.40.2.1) — не динамическое
                if self.ROLE == 'AP':
                    self.sim.at(max(s, self.sim.now), self._dyn_begin, p, s, e)
            elif aid is not None and p.src_aid == aid:
                self.sim.at(max(s, self.sim.now), self._sp_source_begin, p, s, e)
            elif aid is not None and p.dst_aid == aid and self.ROLE == 'AP' and p.alloc.truncatable:
                self.sim.at(s + DOT11_SP_IDLE_TIMEOUT, self._sp_recovery_check, p, s, e)

    def _cbap_chain(self, wins, margin):
        """Окна CBAP BI по очереди: следующее открывается в конце предыдущего (mac.set_cbap, 10.39.5)."""
        wins = sorted(w for w in wins if w[1] > self.sim.now)
        if not wins:
            return
        self.set_cbap(wins[0][0], wins[0][1], margin)
        for (s0, e0), (s1, e1) in zip(wins, wins[1:]):
            self.sim.at(e0, self.set_cbap, s1, e1, margin)

    # ------------------------------------------------------------------ SP: источник (10.39.6.2)
    def _mac_of_aid(self, a):
        if a == AID_AP_PCP:
            return self.bssid
        for p in self.peers.values():
            if p.aid == a:
                return p.addr
        return None

    def _sp_source_begin(self, p, s, e):
        peer = self._mac_of_aid(p.dst_aid)
        if peer is None:
            return
        self._sp_run(peer, e, p.alloc, why='SP')

    def _sp_run(self, peer, end, alloc, why='SP'):
        """Последовательность источника до end (SP или выделение Grant)."""
        if self.seq is not None:
            # своя последовательность ещё идёт (обмен CBAP не должен заходить в SP — 10.39.5) — начать после неё
            self.sim.at(self.sim.now + SIFS, self._sp_run, peer, end, alloc, why)
            return
        if self.tx_on or self.rx_on or self.sim.now >= end:
            return
        self.log('sp_start', peer=peer, end=end, why=why)
        self._seq_start(self._seq_sp(peer, end, alloc), txop_end=end)

    def _sp_ex_time(self, plen, mcs, agg):
        resp = D.response_txtime('ba' if agg else 'ack', mcs, 32 if agg else 14)
        return txtime(plen, mcs) + SIFS + resp

    def _seq_sp(self, peer, end, alloc):
        """Обмены источника в SP (10.39.6.2): A-MPDU + BlockAck (или MSDU + Ack) через SIFS, каждый с ответом — до конца
        SP; без ответа — повтор через PIFS (не больше SP_RETRY); очередь пуста — усечение (Truncatable, 10.39.8.1);
        к концу Extendable SP очередь не пуста — продление (10.39.9)."""
        gap, tries, extended = SIFS, 0, False
        while True:
            p = self.peer(peer)
            now = self.sim.now
            left = end - now - gap
            if alloc is not None and alloc.extendable and not extended and self.ROLE != 'AP':
                left -= T_SPR + SIFS + T_GRANT + SIFS + T_GRANT + SIFS   # место под обмен продления (10.39.9)

            def fits(ex, left=left):
                return ex + 2 * aAirPropagationTime <= left
            step = self._sp_data_step(p, now + gap, fits)
            if step is None:
                if not self._has_data_for(peer):
                    break
                # данные есть, времени нет — продление (10.39.9), если SP Extendable
                if alloc is not None and alloc.extendable and not extended and self.ROLE != 'AP':
                    extended = True
                    new_end = yield from self._sp_extend(peer, end, alloc, gap)
                    if new_end is not None and new_end > end:
                        end = new_end
                        gap = SIFS
                        continue
                return True
            tx, on_ok, on_fail = step
            tx.gap = gap
            r = yield tx
            if r is None:
                on_fail()
                tries += 1
                if tries > SP_RETRY:
                    return False
                gap = PIFS                    # 10.39.6.2: «may retransmit … PIFS after the end of the frame»
                continue
            on_ok(r)
            tries, gap = 0, SIFS
        # очередь пуста: усечение Truncatable SP (10.39.8.1), если время на обмен усечения есть
        if alloc is not None and alloc.truncatable and self.ROLE != 'AP':
            yield from self._sp_truncate(peer, end, gap)
        return True

    def _sp_data_step(self, p, t, fits):
        """Шаг обмена данными в SP: (Tx, on_ok(r), on_fail()) или None (нечего или не умещается)."""
        if not self._may_send_data(p.addr):
            return None
        ra = p.addr
        beam = self._beam_to(ra)
        to_ds, from_ds = self._ds_bits()
        if p.orig is not None:
            o, store, _ = p.orig
            n, mcs, plen, _res = self._ampdu_plan(p, t, fits=lambda tt, ex: fits(ex), rts=False, cf_end=False)
            if n == 0:
                return None
            retry = {s for s, v in o.state.items() if v == self._BA.RETRY}
            sns = o.build_ampdu(n)
            items = [(s, store[s], s in retry) for s in sns]
            agg = True
        elif p.msdus:
            sn, data, sa, da, r0 = p.msdus[0]
            mcs = self._la(p)
            plen = FR.QOS_HDR + len(data) + 4
            if not fits(self._sp_ex_time(plen, mcs, False)):
                return None
            items = [(sn, (data, sa, da), r0 > 0)]
            agg = False
        else:
            return None
        resp_mcs = D.response_mcs('ba' if agg else 'ack', mcs, 32 if agg else 14)
        t_resp = txtime(32 if agg else 14, resp_mcs)
        # Duration: SIFS + ответ (обмен вне TXOP EDCA, 9.2.5.2 a)) + распространение
        dur = D.field(SIFS + t_resp + 2 * aAirPropagationTime)

        def build(tt):
            return [FR.qos_data(dur, ra, self.addr, self._addr3(sa, da), s, data, to_ds, from_ds, retry=rt)
                    for s, (data, sa, da), rt in items]
        exp = (lambda fr: fr[0].kind == 'BlockAck' and fr[0].ra == self.addr and fr[0].ta == ra) if agg else \
            (lambda fr: fr[0].kind == 'Ack' and fr[0].ra == self.addr)
        tx = self.Tx(None, mcs, beam, agg=agg, build=build, expect=exp, resp_mcs=resp_mcs, what='Data (SP)')

        def on_ok(r):
            if agg:
                ssn, bm = self._BA.parse_ba_info(r[0][0].raw[18:28])
                acked, _ = p.orig[0].on_blockack(ssn, bm)
                for s in acked:
                    data, sa, da = p.orig[1].pop(s)
                    self._status((sa, da), 'Successful')
                self._ba_refill(p)
            else:
                sn, data, sa, da, _ = p.msdus.popleft()
                self._status((sa, da), 'Successful')

        def on_fail():
            if agg:
                p.orig[0].on_blockack_lost()
            else:
                sn, data, sa, da, rr = p.msdus[0]
                p.msdus[0] = (sn, data, sa, da, rr + 1)
        return tx, on_ok, on_fail

    def _sp_truncate(self, peer, end, gap):
        """10.39.8.1: CF-End к AP (объявить время AP), затем CF-End пиру; если пир — AP, один CF-End ему. Не начинать,
        если обмен усечения не умещается до конца SP."""
        ap = self.bssid
        frames = ([ap] if ap != peer else []) + [peer]
        need = gap + len(frames) * (T_CF_END + SIFS)
        if self.sim.now + need > end:
            return
        self.log('sp_truncate', peer=peer, rem=end - self.sim.now)
        g = gap
        for ra in frames:
            yield self.Tx([FR.cf_end(0, ra, self.addr)], 0, self._beam_to(ra), gap=g, what='CF-End (усечение)')
            g = SIFS

    def _sp_extend(self, peer, end, alloc, gap):
        """10.39.9: SPR к AP (Duration — остаток SP без SPR, Allocation Duration — сколько нужно), Grant AP через SIFS;
        при гранте — Grant партнёру (если партнёр не AP) через SIFS. → новый конец или None."""
        ap = self.bssid
        need_us = min(EXT_REQ_MAX, int(self._sp_backlog_time(peer)) + 1)
        t0 = self.sim.now + gap
        if t0 + T_SPR + SIFS + T_GRANT + SIFS + (T_GRANT if peer != ap else 0) > end:
            return None
        dur = D.field(end - (t0 + T_SPR))
        dai = F.Dai(0, ALLOC_SP, self.my_aid(), self._aid_of(peer), need_us)
        spr = F.encode_frame(F.Spr(dur, ap, self.addr, dai, F.BfControl()), with_fcs=False)
        self.log('sp_extend_request', peer=peer, us=need_us)
        r = yield self.Tx([spr], 0, self._beam_to(ap), gap=gap, what='SPR (продление)',
                          expect=lambda fr: fr[0].kind == 'Grant' and fr[0].ta == ap and fr[0].ra == self.addr,
                          resp_mcs=0)
        if r is None:
            return None
        g = F.parse_frame(r[0][0].raw, with_fcs=False)
        if g.dai.alloc_duration == 0:
            self.log('sp_extend_declined', peer=peer)
            return None
        if peer != ap:
            # SIFS после Grant AP — Grant партнёру: Duration = Duration Grant AP − TXTIME(Grant) − SIFS (10.39.9)
            d2 = D.duration_grant_ext_forward(g.duration, T_GRANT)
            fw = F.encode_frame(F.Grant(d2, peer, self.addr, g.dai, F.BfControl()), with_fcs=False,
                                grant_ctx='sp_individual' if g.dai.alloc_duration == F.ALLOC_DUR_SPECIAL else None)
            yield self.Tx([fw], 0, self._beam_to(peer), gap=SIFS, what='Grant (продление партнёру)')
        self.log('sp_extended', peer=peer, us=g.dai.alloc_duration)
        return end + g.dai.alloc_duration

    def _sp_backlog_time(self, peer):
        p = self.peer(peer)
        n = len(p.backlog) + len(p.msdus) + (sum(1 for v in p.orig[0].state.values()
                                                 if v in (self._BA.NEW, self._BA.RETRY)) if p.orig else 0)
        mcs = self._la(p)
        per = self._sp_ex_time(FR.QOS_HDR + 1500 + 4 + 8, mcs, True) / 32 + 1
        return n * per + 50

    def _aid_of(self, mac):
        if mac == self.bssid and self.ROLE == 'STA':
            return AID_AP_PCP
        p = self.peers.get(mac)
        return p.aid if p is not None and p.aid else AID_AP_PCP

    # ------------------------------------------------------------------ SP: получатель-AP (10.39.6.7), продление (AP)
    def _sp_note_rx(self, f):
        """Принятый кадр: отметка источника в текущем SP (для восстановления 10.39.6.7)."""
        self._last_rx_from = getattr(self, '_last_rx_from', {})
        if f.ta is not None:
            self._last_rx_from[f.ta] = self.sim.now

    def _sp_recovery_check(self, p, s, e):
        src = self._mac_of_aid(p.src_aid)
        last = getattr(self, '_last_rx_from', {}).get(src)
        if src is None or (last is not None and last >= s):
            return
        if self.seq is not None or self.tx_on or self.rx_on:
            return
        rem = e - self.sim.now - T_GRANT - SIFS
        if rem <= 0:
            return
        # 10.39.6.7: усечь и отдать остаток источнику механизмом 10.39.7 (Grant, начало выделения — PHY-TXEND + 0)
        self.log('sp_recovery', sta=src, rem=rem)
        dai = F.Dai(0, ALLOC_SP, p.src_aid, AID_AP_PCP, min(SP_MAX, int(rem)))
        g = F.encode_frame(F.Grant(0, src, self.addr, dai, F.BfControl()), with_fcs=False, grant_ctx='ati_gp')
        self._phy_tx([g], 0, self._beam_to(src))

    def _ap_rx_spr(self, f, rxv):
        """AP: SPR не в ответ на Poll — запрос продления текущего SP (10.39.9); ответ Grant через SIFS."""
        spr = F.parse_frame(f.raw, with_fcs=False)
        cur = self._sp_current()
        if cur is None:
            return
        p, s, e, periods = cur
        if not p.alloc.extendable or f.ta not in (self._mac_of_aid(p.src_aid), self._mac_of_aid(p.dst_aid)):
            return
        req = spr.dai.alloc_duration
        # 10.39.9: гарантировать — только если следующий SP broadcast/broadcast и длиннее запрошенного
        nxt = [q for q in periods if q.kind == S.SP and q.start >= p.end]
        nxt = min(nxt, key=lambda q: q.start) if nxt else None
        ok = nxt is not None and nxt.src_aid == nxt.dst_aid == AID_BROADCAST and nxt.end - nxt.start > req
        d = D.duration_grant_ext_reply(spr.duration, T_GRANT)
        dai = F.Dai(0, ALLOC_SP, spr.dai.src_aid, spr.dai.dst_aid, req if ok else 0)
        g = F.encode_frame(F.Grant(d, f.ta, self.addr, dai, F.BfControl()), with_fcs=False)
        self._respond(g, 0, self._beam_to(f.ta))
        if ok:
            self.sp_ext_until = e + req          # продлённый SP занимает начало следующего SP broadcast
        self.log('sp_extend_reply', sta=f.ta, granted=req if ok else 0)

    def _sp_current(self):
        for k, periods in reversed(self.dti_log):
            for p in periods:
                if p.kind == S.SP and p.alloc is not None and \
                        self.t_of_tsf(p.start) <= self.sim.now < self.t_of_tsf(p.end):
                    return p, self.t_of_tsf(p.start), self.t_of_tsf(p.end), periods
        return None

    # ------------------------------------------------------------------ PP/GP (10.39.7.2, 10.39.7.3): AP
    def _dyn_begin(self, p, s, e):
        """SP broadcast/broadcast: PP — Poll каждой связанной STA, затем GP по запросам (после продлённого SP, если
        продление заняло начало, 10.39.9)."""
        ext = getattr(self, 'sp_ext_until', None)
        if ext is not None and ext > self.sim.now:
            self.sim.at(ext + SIFS, self._dyn_begin, p, ext + SIFS, e)
            return
        stas = [self._mac_of_aid(a) for a in self.assoc_aids()]
        stas = [x for x in stas if x is not None]
        if not stas or self.seq is not None or self.tx_on:
            return
        self._seq_start(self._seq_dyn(stas, s, e), txop_end=e)

    def _seq_dyn(self, stas, s, e):
        n = len(stas)
        sched = D.pp_schedule([T_POLL] * n, [T_SPR] * n, [0] * n)
        need = sched[0][0] + T_POLL
        if s + need + SIFS > e:
            return False
        self.dyn_req = {}
        t = self.sim.now
        ends = []
        for i, sta in enumerate(stas):
            dur, ro = sched[i]
            poll = F.encode_frame(F.Poll(int(dur), sta, self.addr, int(ro)), with_fcs=False)
            yield self.Tx([poll], 0, self._beam_to(sta), at=t, what='Poll')
            ends.append((self.sim.now, int(ro), sta))
            t = self.sim.now + SBIFS
        # SPR — через Response Offset от конца своего Poll (10.39.7.2, PLAN №45)
        last_end, last_ro, _ = ends[-1]
        until = last_end + last_ro + T_SPR + SIFS
        coll = yield self.Rx(lambda fr: fr[0].kind == 'SPR' and fr[0].ra == self.addr, until, collect=True)
        for frs, rxv, t0, te in coll or []:
            spr = F.parse_frame(frs[0].raw, with_fcs=False)
            if spr.dai.alloc_duration:
                self.dyn_req[frs[0].ta] = spr.dai
        pp_end = until                           # конец PP: ожидаемый конец последнего SPR + SIFS (10.39.7.2)
        t = pp_end + SIFS                        # GP — «SIFS following the end of a PP» (PLAN №47)
        for sta in stas:
            dai = self.dyn_req.get(sta)
            if dai is None:
                continue
            if t + T_GRANT >= e:
                break
            alloc = min(dai.alloc_duration, int(e - (t + T_GRANT) - SIFS), SP_MAX)
            if alloc <= 0:
                break
            ga = getattr(self.peers.get(sta), 'caps', None)
            gack = bool(ga is not None and ga.sta_cap.get('grant_ack'))
            gd = D.field(SIFS + T_GRANT_ACK) if gack else 0       # последний Grant GP (PLAN №48)
            g_dai = F.Dai(0, ALLOC_SP, dai.src_aid, dai.dst_aid, alloc)
            g = F.encode_frame(F.Grant(gd, sta, self.addr, g_dai, F.BfControl()), with_fcs=False, grant_ctx='ati_gp')
            if gack:
                r = yield self.Tx([g], 0, self._beam_to(sta), at=t, what='Grant', resp_mcs=0,
                                  expect=lambda fr, sta=sta: fr[0].kind == 'Grant Ack' and fr[0].ta == sta)
            else:
                yield self.Tx([g], 0, self._beam_to(sta), at=t, what='Grant')
            w_start = self.sim.now + gd if not gack else self.sim.now
            if gack:
                w_start = self.seq['ref']
            w_end = w_start + alloc
            self.log('gp_grant', sta=sta, start=w_start, end=w_end)
            # AP — получатель выделения: ждёт обменов STA до конца выделения
            yield self.Rx(lambda fr: False, w_end)
            t = self.sim.now + SIFS
        return True

    # ------------------------------------------------------------------ PP/GP: станция
    def _rx_dyn(self, f, rxv):
        """Poll / Grant точки себе (10.39.7.2, 10.39.7.3)."""
        if f.kind == 'Poll':
            poll = F.parse_frame(f.raw, with_fcs=False)
            # SPR через Response Offset от конца Poll (10.39.7.2, PLAN №45); DAI — запрос времени под очередь к AP
            need = int(self._sp_backlog_time(f.ta)) if self._has_data_for(f.ta) else 0
            dai = F.Dai(0, ALLOC_SP, self.my_aid() or 0, AID_AP_PCP, min(SP_MAX, need))
            d = D.duration_spr_response(poll.duration, poll.response_offset, T_SPR)
            spr = F.encode_frame(F.Spr(int(d), f.ta, self.addr, dai, F.BfControl()), with_fcs=False)
            self.sim.at(self.sim.now + poll.response_offset, self._tx_at, spr, self._beam_to(f.ta), 'SPR')
            return
        if f.kind == 'Grant':
            g = F.parse_frame(f.raw, with_fcs=False)
            if g.dai.alloc_duration in (0, F.ALLOC_DUR_SPECIAL) or g.dai.src_aid != self.my_aid():
                return
            if self.grant_ack_supported:
                ga = F.encode_frame(F.GrantAck(D.duration_grant_ack(g.duration, T_GRANT_ACK), f.ta, self.addr,
                                               F.BfControl()), with_fcs=False)
                self._respond(ga, 0, self._beam_to(f.ta))
            start = self.sim.now + g.duration          # 10.39.7.3: PHY-TXEND Grant + Duration
            end = start + g.dai.alloc_duration
            peer = self._mac_of_aid(g.dai.dst_aid)
            self.log('grant_rx', start=start, end=end)
            if peer is not None:
                self.sim.at(max(start, self.sim.now + SIFS if self.grant_ack_supported else start),
                            self._sp_run, peer, end, None, 'GP')

    def _tx_at(self, mpdu, beam, what):
        if not self.tx_on and not self.rx_on:
            self._phy_tx([mpdu], 0, beam)

    # ------------------------------------------------------------------ STA: расписание из маяка
    def _sta_schedule(self, k, b, rx_t, bti_end, abft_end):
        """DMG Beacon своего BSS с Extended Schedule (CBAP Only = 0): StaView (10.39.6.1, 10.39.6.4) → периоды BI k."""
        if self.sview is None or self.sview.aid != self.aid:
            self.sview = S.StaView(self.aid, self.bi_tu)
        ent = S.from_elements(b.elements)
        if ent is not None:
            self.sview.receive(k, ent, rx_tsf=self.tsf(rx_t))
        entries = self.sview.allocations(k)
        bic = _bic_bi(b.bic)
        params = BI.DmgParameters(b.params.bss_type, b.params.cbap_only, b.params.cbap_source, b.params.privacy,
                                  b.params.ecapc)
        periods = self._dti_periods(k, entries, bic, params, self.tsf(bti_end))
        self._dti_apply(k, periods, margin=aTSFResolution)


def _bic_bi(b):
    """fields.Bic (сырые поля рис. 9-77) → bi.BeaconIntervalControl."""
    return BI.BeaconIntervalControl(
        cc_present=b.cc_present, discovery_mode=b.discovery, next_beacon=b.next_beacon, ati_present=b.ati_present,
        abft_length=b.abft_length, fss=b.fss, is_responder_txss=b.is_resp_txss, next_abft=b.next_abft,
        fragmented_txss=b.fragmented_txss, txss_span=b.txss_span, n_bis_abft=b.n_bis_abft, abft_count=b.abft_count,
        n_abft_in_ant=b.n_abft_in_ant, pcp_association_ready=b.pcp_assoc_ready)


__all__ = ['DtiMixin', 'policy_sp', 'policy_cbap_split', 'BCAST', 'P', 'ALLOC_CBAP']
