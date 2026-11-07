# SPDX-License-Identifier: AGPL-3.0-or-later
"""Передача роли PCP (PBSS) по 802.11-2020 11.27.2 [p. 2357–2359]: элементы Next PCP List (9.4.2.140 [p. 1261],
рис. 9-581: Token, AID по убыванию приоритета) и PCP Handover (9.4.2.141 [p. 1261], рис. 9-582: Old BSSID, New PCP
Address, Remaining BIs), кадры Handover Request / Handover Response (категория DMG, действия 4/5, 9.6.19.6/9.6.19.7
[p. 1573], табл. 9-462, 9-463), способность — поле PCP Handover DMG Capabilities (9.4.2.127.3, рис. 9-553).

Поведение:
  явная передача (11.27.2.2) — PCP шлёт Handover Request способной STA или способная STA — способному PCP; ответ
    (Result 0 — согласие); после ответа PCP dot11NbrOfChangeBeacons BI кладёт PCP Handover в каждый DMG Beacon/Announce:
    Old BSSID = BSSID, New PCP Address = кандидат, Remaining BIs — от последнего Handover Remaining BI запроса, −1 на
    каждом TBTT; член BSS ставит счётчик по элементу, −1 на TBTT, на 0 — фильтр маяков на нового PCP; кандидат на 0
    становится PCP (HandoverPcp, HandoverMember);
  неявная передача (11.27.2.3) — Next PCP List в маяках, Token +1 при каждом изменении списка; кандидат i срабатывает
    после i·dot11ImplicitHandoverLostBeacons BI без маяков PCP и шлёт DMG Beacon с PCP Handover (Remaining BIs от
    dot11MaxLostBeacons, −1 на TBTT) dot11MaxLostBeacons BTI, пока нет маяков PCP и кандидата с меньшим индексом
    (ImplicitCandidate); член BSS после dot11MaxLostBeacons BI без маяков выбирает нового PCP с наименьшим Remaining BIs
    (choose_new_pcp);
  после передачи псевдостатическое расписание не меняется (check_pseudo_static_kept); член BSS шлёт кадр новому PCP за
    dot11MaxLostBeacons BI (check_member_contact).

СПОРНО → принято (PLAN.md №63): Next PCP List «length … is 0» при отсутствии способных STA (11.27.2.1) — элемент
с Length 0 (без Token); Length 1 (Token без AID) — нарушение («one or more AID», 9.4.2.140).
СПОРНО → принято (PLAN.md №64): 11.27.2.2 «Handover Result field set to 1, 2, or 3» противоречит 9.6.19.7 (Result —
0/1, 1–3 — причины Handover Reject Reason); норма — 9.6.19.7: Result ∉ {0, 1} — резерв.
СПОРНО → принято (PLAN.md №65): Remaining BIs в BI j = R0 − (j − j0), j0 — первый BI с элементом, R0 — Handover
Remaining BI; передача — на TBTT, где счётчик становится 0. dot11NbrOfChangeBeacons DEFVAL 4 не больше
dot11MaxLostBeacons 4 (11.29.2 требует «greater») и dot11ImplicitHandoverLostBeacons DEFVAL 8 не меньше
dot11MaxLostBeacons (11.27.2.3 «should be lower») — значения MIB — параметры, DEFVAL лишь по умолчанию.
Не моделируется: выбор кандидата по PCP factor (11.1.4.3.10), безопасность и BF кандидата с членами (should)."""
from collections import namedtuple

from . import elements as E
from . import fields as F
from .timing import DOT11_MAX_LOST_BEACONS

CATEGORY_DMG = 16
ACT_HANDOVER_REQ, ACT_HANDOVER_RESP = 4, 5                # табл. 9-457
EID_NEXT_PCP_LIST, EID_PCP_HANDOVER = 160, 161            # табл. 9-92
PCP_HANDOVER_LEN = 13                                     # рис. 9-582: 6 + 6 + 1
# 9.6.19.6: Handover Reason
REASON_LEAVING, REASON_LOW_POWER, REASON_BETTER_PCP, REASON_WANTS_PCP = 0, 1, 2, 3
# 9.6.19.7: Handover Result / Handover Reject Reason
RESULT_ACCEPT, RESULT_REJECT = 0, 1
REJECT_LOW_POWER, REJECT_IN_PROGRESS, REJECT_BAD_REMAINING, REJECT_UNSPECIFIED = 0, 1, 2, 3
# MIB DEFVAL (dot11DMGOperationEntry, C.3) — перенести в timing.py при сведении с ref/linkadapt (11.29)
NBR_OF_CHANGE_BEACONS_DEFVAL = 4            # dot11NbrOfChangeBeacons DEFVAL { 4 }
IMPLICIT_HANDOVER_LOST_BEACONS_DEFVAL = 8   # dot11ImplicitHandoverLostBeacons DEFVAL { 8 }

NextPcpList = namedtuple('NextPcpList', 'token aids')        # token None — элемент с Length 0
PcpHandover = namedtuple('PcpHandover', 'old_bssid new_pcp remaining')
HandoverReq = namedtuple('HandoverReq', 'reason remaining_bi')
HandoverResp = namedtuple('HandoverResp', 'result reject_reason')


# ---------------------------------------------------------------------------------------------------- элементы
def encode_next_pcp_list(token, aids):
    if token is None:
        return E.encode_element(EID_NEXT_PCP_LIST, b'')
    return E.encode_element(EID_NEXT_PCP_LIST, bytes([token]) + bytes(aids))


def parse_next_pcp_list(info):
    b = bytes(info)
    return NextPcpList(None, []) if not b else NextPcpList(b[0], list(b[1:]))


def check_next_pcp_list(n, capable=None):
    """capable — {AID: способен ли (поле PCP Handover)} или None."""
    v = []
    if n.token is not None and not n.aids:
        v.append('Next PCP List: Token без AID — «one or more AID of NextPCP» или Length 0 (9.4.2.140, 11.27.2.1; '
                 'PLAN.md №63)')
    if len(set(n.aids)) != len(n.aids):
        v.append(f'Next PCP List: AID с повтором {n.aids} (11.27.2.1: упорядоченный список STA)')
    if capable is not None:
        for a in n.aids:
            if capable.get(a) is False:
                v.append(f'Next PCP List: AID {a} не способна к передаче PCP (11.27.2.1: «list of … PCP handover '
                         f'capable STAs»)')
        if n.token is None and any(capable.values()):
            v.append('Next PCP List с Length 0 при способной STA в PBSS (11.27.2.1)')
    return v


def encode_pcp_handover(h):
    return E.encode_element(EID_PCP_HANDOVER, F.mac_bytes(h.old_bssid) + F.mac_bytes(h.new_pcp) + bytes([h.remaining]))


def parse_pcp_handover(info):
    b = E.known_info(info, PCP_HANDOVER_LEN, 'PCP Handover')
    return PcpHandover(F.mac_str(b[0:6]), F.mac_str(b[6:12]), b[12])


# ---------------------------------------------------------------------------------------------------- кадры
def encode_request(reason, remaining_bi):
    return bytes([CATEGORY_DMG, ACT_HANDOVER_REQ, reason, remaining_bi])


def encode_response(result, reject_reason=0):
    return bytes([CATEGORY_DMG, ACT_HANDOVER_RESP, result, reject_reason])


def parse_frame(body):
    b = bytes(body)
    if len(b) < 4 or b[0] != CATEGORY_DMG or b[1] not in (ACT_HANDOVER_REQ, ACT_HANDOVER_RESP):
        raise ValueError('не Handover Request/Response (табл. 9-462/9-463)')
    return (HandoverReq(b[2], b[3]) if b[1] == ACT_HANDOVER_REQ else HandoverResp(b[2], b[3])), b[1]


def check_request(r, src_is_pcp, src_capable=None, dst_capable=None, pbss=True):
    v = []
    if r.reason > REASON_WANTS_PCP:
        v.append(f'Handover Reason {r.reason} — резерв (9.6.19.6)')
    if not pbss:
        v.append('Handover Request вне PBSS (11.27.2: передача роли PCP)')
    if src_is_pcp and dst_capable is False:
        v.append('PCP шлёт Handover Request неспособной STA (11.27.2.2: «to a non-PCP STA that is handover capable»)')
    if not src_is_pcp and (src_capable is False or dst_capable is False):
        v.append('Handover Request от STA без способности или к неспособному PCP (11.27.2.2)')
    return v


def check_response(r):
    v = []
    if r.result not in (RESULT_ACCEPT, RESULT_REJECT):
        v.append(f'Handover Result {r.result} — резерв (9.6.19.7; 11.27.2.2 «1, 2, or 3» — PLAN.md №64)')
    if r.result == RESULT_ACCEPT and r.reject_reason:
        v.append('Handover Reject Reason ≠ 0 при Result 0 — «reserved and set to 0» (9.6.19.7)')
    if r.result == RESULT_REJECT and r.reject_reason > REJECT_UNSPECIFIED:
        v.append(f'Handover Reject Reason {r.reject_reason} — резерв (9.6.19.7)')
    return v


# ---------------------------------------------------------------------------------------------------- явная передача
class HandoverPcp:
    """PCP при явной передаче (11.27.2.2). n_change — dot11NbrOfChangeBeacons."""

    def __init__(self, bssid, n_change=NBR_OF_CHANGE_BEACONS_DEFVAL):
        self.bssid, self.n_change = bssid, n_change
        self.candidate, self.remaining_bi, self.bi_req = None, None, None
        self.start_bi, self.r0 = None, None
        self.done = False

    def request_sent(self, peer, remaining_bi, bi):
        self.candidate, self.remaining_bi, self.bi_req = peer, remaining_bi, bi

    def request_received(self, peer, remaining_bi, bi):
        self.request_sent(peer, remaining_bi, bi)

    def response(self, result, bi):
        """После передачи или приёма Handover Response с Result 0 — элемент PCP Handover в «next
        dot11NbrOfChangeBeacons beacon intervals» (с BI bi + 1); Handover Remaining BI не считает BI запроса — при
        ответе в BI запроса начальное Remaining BIs = Handover Remaining BI (PLAN.md №65)."""
        if result == RESULT_ACCEPT and self.candidate is not None:
            self.start_bi, self.r0 = bi + 1, self.remaining_bi - (bi - self.bi_req)
        else:
            self.candidate = None

    def beacon_element(self, bi):
        """PcpHandover для маяков BI bi или None. Элемент — в каждом из dot11NbrOfChangeBeacons BI после ответа,
        Remaining BIs = R0 − (bi − j0) (PLAN.md №65); в BI, где значение стало бы 0, PCP уже кандидат."""
        if self.start_bi is None or bi < self.start_bi:
            return None
        rem = self.r0 - (bi - self.start_bi)
        if rem <= 0:                            # с этого TBTT PCP — кандидат: маяков старого PCP нет
            self.done = True
            return None
        if bi - self.start_bi >= self.n_change:
            return None
        return PcpHandover(self.bssid, self.candidate, rem)

    def takes_over_bi(self):
        """BI, с TBTT которого кандидат — PCP (счётчик стал 0)."""
        return None if self.start_bi is None else self.start_bi + self.r0


class HandoverMember:
    """Член PBSS (non-PCP STA): счётчик по PCP Handover, −1 на каждом TBTT, на 0 — фильтр маяков на нового PCP."""

    def __init__(self, pcp):
        self.filter, self.counter, self.new_pcp = pcp, None, None

    def on_beacon(self, h):
        self.counter, self.new_pcp = h.remaining, h.new_pcp
        if self.counter == 0:
            self.filter = self.new_pcp

    def tbtt(self):
        if self.counter is not None and self.counter > 0:
            self.counter -= 1
            if self.counter == 0:
                self.filter = self.new_pcp


def check_handover_beacons(seq, bssid, n_change=NBR_OF_CHANGE_BEACONS_DEFVAL, max_bi=None):
    """seq — [(BI, PcpHandover | None)] маяков старого PCP по BI (по порядку). Нарушения 11.27.2.2: Old BSSID = BSSID,
    New PCP постоянен, Remaining BIs −1 на каждом TBTT, элемент в каждом из dot11NbrOfChangeBeacons BI после первого."""
    v = []
    first = next(((k, h) for k, h in seq if h is not None), None)
    if first is None:
        return v
    j0, h0 = first
    for k, h in seq:
        if k < j0:
            continue
        if h is None:
            due = k - j0 < n_change and h0.remaining - (k - j0) > 0
            if due:
                v.append(f'BI {k}: нет PCP Handover, хотя после первого ({j0}) не прошло dot11NbrOfChangeBeacons = '
                         f'{n_change} BI (11.27.2.2)')
            continue
        if h.old_bssid != bssid:
            v.append(f'BI {k}: Old BSSID {h.old_bssid} ≠ BSSID PBSS {bssid} (11.27.2.2)')
        if h.new_pcp != h0.new_pcp:
            v.append(f'BI {k}: New PCP Address сменился {h0.new_pcp} → {h.new_pcp} (11.27.2.2)')
        want = h0.remaining - (k - j0)
        if h.remaining != want:
            v.append(f'BI {k}: Remaining BIs {h.remaining}, ожидалось {want} (−1 на каждом TBTT, 11.27.2.2; '
                     f'PLAN.md №65)')
    return v


# ---------------------------------------------------------------------------------------------------- неявная
class NextPcpListPcp:
    """PCP ведёт Next PCP List: Token 0 при старте PBSS, +1 при каждом изменении списка (11.27.2.1, 9.4.2.140)."""

    def __init__(self):
        self.token, self.aids = 0, []

    def update(self, aids):
        aids = list(aids)
        if aids != self.aids:
            if self.aids or aids:
                self.token = (self.token + 1) % 256
            self.aids = aids
        return self.element()

    def element(self):
        return NextPcpList(self.token if self.aids else None, list(self.aids))


def check_next_pcp_tokens(seq):
    """seq — [NextPcpList] маяков по порядку: Token меняется ровно на +1 (по модулю 256) при изменении списка и не
    меняется без изменения (11.27.2.1)."""
    v = []
    prev = None
    for k, n in enumerate(seq):
        if prev is not None and prev.token is not None and n.token is not None:
            if n.aids == prev.aids and n.token != prev.token:
                v.append(f'[{k}] Token {prev.token} → {n.token} без изменения списка (9.4.2.140)')
            if n.aids != prev.aids and n.token != (prev.token + 1) % 256:
                v.append(f'[{k}] список изменился, Token {prev.token} → {n.token}, нужно +1 (11.27.2.1)')
        prev = n
    return v


class ImplicitCandidate:
    """Неявный кандидат i (индекс в Next PCP List с 1, 11.27.2.3)."""

    def __init__(self, mac, aid, prev_bssid, lost_beacons=IMPLICIT_HANDOVER_LOST_BEACONS_DEFVAL,
                 max_lost=DOT11_MAX_LOST_BEACONS):
        self.mac, self.aid, self.bssid = mac, aid, prev_bssid
        self.index, self.token = None, None
        self.lost_beacons, self.max_lost = lost_beacons, max_lost
        self.missed = 0
        self.active, self.remaining, self.sent = False, None, 0

    def on_next_pcp_list(self, n):
        """→ True, если надо запросить сведения у PCP Information Request (Token сменился, 11.27.2.3)."""
        self.index = n.aids.index(self.aid) + 1 if self.aid in n.aids else None
        changed = self.index is not None and n.token != self.token
        self.token = n.token
        return changed

    def bi(self, pcp_beacon_seen, lower_candidate_beacon=False):
        """Итог очередного BI → PcpHandover для своего DMG Beacon в следующем BTI или None."""
        if pcp_beacon_seen:
            self.missed, self.active, self.sent = 0, False, 0
            return None
        self.missed += 1
        if lower_candidate_beacon:
            self.active = False                 # кандидат с меньшим индексом уже взял PBSS
            return None
        if not self.active and self.index is not None and self.missed >= self.index * self.lost_beacons:
            self.active, self.remaining = True, self.max_lost
        if not self.active or self.remaining <= 0:
            return None
        # СПОРНО → принято (PLAN.md №66): срабатывание — в конце BI, Remaining BIs = dot11MaxLostBeacons, затем −1 на
        # TBTT перед BTI: маяки несут dot11MaxLostBeacons − 1 … 0 — ровно dot11MaxLostBeacons BTI и последний с 0.
        self.remaining -= 1
        self.sent += 1
        return PcpHandover(self.bssid, self.mac, self.remaining)

    @property
    def completed(self):
        """«successfully transmits a DMG Beacon frame with the Remaining BIs … equal to 0» — передача завершена."""
        return self.active and self.sent > 0 and self.remaining == 0


def choose_new_pcp(heard, old_bssid):
    """11.27.2.3: член после dot11MaxLostBeacons BI без маяков — к новому PCP, чей DMG Beacon несёт PCP Handover с Old
    BSSID = прежний BSSID и наименьшим Remaining BIs. heard — [(TA, PcpHandover)]."""
    c = [(h.remaining, ta) for ta, h in heard if h.old_bssid == old_bssid]
    return min(c)[1] if c else None


def check_pseudo_static_kept(before, after):
    """11.27.2.1: «the pseudo-static scheduling information shall remain unchanged» — псевдостатические распределения
    (Allocation с Pseudo-static = 1) нового PCP те же, что у прежнего (по Source/Destination AID, ID, типу, началу и
    длине)."""
    def key(a):
        return (a.src_aid, a.dst_aid, a.ctrl['allocation_id'], a.ctrl['allocation_type'], a.start, a.block_duration,
                a.num_blocks, a.block_period)
    b = {key(a) for a in before if a.ctrl['pseudo_static']}
    a = {key(x) for x in after if x.ctrl['pseudo_static']}
    v = [f'псевдостатическое распределение {k} пропало после передачи PCP (11.27.2.1)' for k in sorted(b - a)]
    v += [f'новое псевдостатическое распределение {k} после передачи PCP (11.27.2.1)' for k in sorted(a - b)]
    return v


def check_member_contact(handover_bi, member_tx_bis, max_lost=DOT11_MAX_LOST_BEACONS):
    """11.27.2.1: член PBSS — кадр новому PCP за dot11MaxLostBeacons BI после передачи. member_tx_bis — BI, в которых
    член передавал новому PCP."""
    if not any(handover_bi <= k < handover_bi + max_lost for k in member_tx_bis):
        return [f'нет кадра новому PCP за {max_lost} BI после передачи (BI {handover_bi}, 11.27.2.1)']
    return []


def capable(caps):
    """DmgCapabilities → поле PCP Handover (9.4.2.127.3; у non-PCP STA поле есть в DMG AP or PCP Capabilities)."""
    return bool(caps.ap_pcp_cap['pcp_handover'])
