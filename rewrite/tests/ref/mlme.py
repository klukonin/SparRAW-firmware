# SPDX-License-Identifier: AGPL-3.0-or-later
"""DMG MLME по 802.11-2020: сканирование (11.1.4.1, 11.1.4.2.2, 11.1.4.3.3, 11.1.4.3.4, 11.1.4.3.9), DMG Beacon
до установления BSS (11.1.3.4), выбор PCP (11.1.4.3.10), запуск DMG BSS (11.1.4.4.2), синхронизация (11.1.4.5,
11.1.3.7), ожидание DMG Beacon и потеря связи (11.1.3.1, 11.27.2.3), правила ATI (10.39.3), состояния и классы
кадров (11.3.1–11.3.3), аутентификация/деаутентификация (11.3.4, 12.3.3.1), ассоциация, реассоциация,
дизассоциация non-AP STA и AP/PCP (11.3.5.1–11.3.5.10), распространение информации PBSS (11.3.7), тайм-ауты
(dot11AssociationResponseTimeout, AssocRespConfirmTime, 2 с, Timeout Interval типа 3, JoinFailureTimeout,
AuthenticateFailureTimeout). Время — Fraction, мкс; MIB-величины в TU переводятся через TU = 1024 мкс.

Состав:
  константы табл. 11-22 и MIB (DEFVAL), диапазоны DMG BSS Parameter Configuration (рис. 9-557 + MIB SYNTAX);
  frame_class, may_transmit, rx_filter              — 11.3.3, 11.3.4.1, 11.3.5.1;
  Peer                                              — переменная состояния пары STA (11.3.1, рис. 11-17);
  StaMlme                                           — non-AP/non-PCP STA: (ре)ассоциация, дизассоциация,
                                                      деаутентификация, тайм-ауты, запреты повторов, MIB из
                                                      DMG Operation (11.3.5.2, 11.3.5.4, 11.3.5.6, 11.3.5.7);
  ApMlme                                            — AP/PCP: приём (ре)ассоциации, AID, SA Query-отказ,
                                                      дизассоциация/деаутентификация (11.3.5.3, 11.3.5.5,
                                                      11.3.5.8, 11.3.5.9), PBSS info distribution (11.3.7);
  AtiAp, ati_sta_response, ati_start_earliest, check_ati_frame — 10.39.3;
  ScanRequest, BssDesc, PassiveScan, DmgActiveScan, should_respond_probe, DiscoveryBeaconing — 11.1.4, 11.1.3.4;
  pcp_factor, candidate_pcp, personal_start_window  — 11.1.4.3.10, 11.1.4.4.2;
  Join, LinkMonitor, bhi_listen_until               — 11.1.4.5, 11.1.3.1, 11.1.3.7, 11.27.2.3;
  check_assoc_log                                   — судья журнала эфира AP ↔ STA (список Violation).

Не моделируется: FILS, FT, SAE и Shared Key как обмены (только «успех/неуспех за AuthenticateFailureTimeout»);
MMS/MM-SME (несколько MAC-сущностей), OCT (11.31.5), Interworking/Emergency services, mesh (MPM/AMPE), IBSS-
процедуры кроме фильтра классов кадров, S1G/CMMG/CDMG, multiple BSSID set (только «не член набора»), Request/
Extended Request в Probe Request (11.1.4.3.9), FILS-критерии ответа, сам 4-way handshake (только переход
State 3 → 4 по MLME-SETPROTECTION), обработка MFP (кадр либо принят, либо отброшен — задаёт вызывающий),
содержимое кадров (это elements.py), поле Duration (duration.py), расписание BI (bi.py), BF (sls.py, abft.py).

СПОРНО-места помечены в докстроках; сводка — в отчёте модуля."""
from collections import namedtuple
from fractions import Fraction as Fr
from math import ceil

from .cbap import Violation
from .elements import (AID_DMG_MAX, AID_DMG_MIN, AUTH_OPEN_SYSTEM, DENIED_NO_MORE_STAS, INVALID_CLASS2_FRAME,
                       INVALID_CLASS3_FRAME, REFUSED_TEMPORARILY, SUCCESS, TIE_ASSOC_COMEBACK,
                       UNSUPPORTED_AUTH_ALGORITHM)
from .timing import (aMaxBIDuration, aMinBTIPeriod, aMinChannelTime, ASSOC_RESP_CONFIRM_UNIT, BCAST,
                     DOT11_MAX_LOST_BEACONS, DOT11_MIN_BHI_DURATION, MBIFS, PIFS, SIFS, TU)

WILDCARD_BSSID = BCAST                      # 9.2.4.3.4: wildcard BSSID — все единицы
WILDCARD_SSID = ''                          # 9.4.2.2: wildcard SSID — SSID нулевой длины

# ---- 3.1, табл. 11-22: TU, aMaxBIDuration, aMinChannelTime (мкс), aMinBTIPeriod — timing.py ----

# ---- MIB (приложение C), DEFVAL ----
# dot11MaxLostBeacons, dot11MinBHIDuration — timing.py
DOT11_IMPLICIT_HANDOVER_LOST_BEACONS = 8    # dot11ImplicitHandoverLostBeacons DEFVAL { 8 }
DOT11_PS_REQUEST_SUSPENSION_INTERVAL = 8    # DEFVAL { 8 } интервалов маяка
DOT11_BROADCAST_STA_INFO_DURATION = 32      # DEFVAL { 32 } интервалов маяка
DOT11_MIN_PP_DURATION = 200                 # DEFVAL { 200 } мкс
DOT11_SP_IDLE_TIMEOUT = 200                 # DEFVAL { 200 } мкс
DOT11_ASSOC_SA_QUERY_MAX_TIMEOUT = 1000     # dot11AssociationSAQueryMaximumTimeout DEFVAL { 1000 } TU
# dot11AssociationResponseTimeout: SYNTAX 1..4294967295 TU, DEFVAL НЕ задан — обязательный параметр StaMlme.

# 9.4.2.128, рис. 9-557: AssocRespConfirmTime — «in units of 50 milliseconds»
# AssocRespConfirmTime — единица 50 мс (9.4.2.128): timing.ASSOC_RESP_CONFIRM_UNIT
# 11.3.5.2 g), 11.3.5.4 f) 2), 11.3.5.7 e): «until a period of (at least) 2 s has elapsed»
RETRY_HOLDOFF = Fr(2000000)
# 11.1.3.4: «uniform distribution between (10 TUs, 200 TUs), i.e., 10 TUs to 199 TUs»
DISCOVERY_BI_TU = (10, 199)
# 11.1.4.4.2: MLME-START(PERSONAL) — «no later than 4×aMaxBIDuration» / «shall not … less than 4 × aMaxBIDuration»
PERSONAL_START_TU = 4 * aMaxBIDuration / TU

# DMG BSS Parameter Configuration (рис. 9-557) → MIB (11.3.5.2 d), 11.3.5.4 d)); диапазоны — SYNTAX MIB.
# СПОРНО: у dot11AssocRespConfirmTime нет объекта MIB в приложении C (есть только ссылка в 11.3.5.2 d) 4)) —
# хранится как значение поля (единицы 50 мс), диапазон — ширина поля (1 октет).
BSS_PARAM_TO_MIB = {
    'ps_request_suspension_interval': ('dot11PSRequestSuspensionInterval', 1, 64),
    'min_bhi_duration': ('dot11MinBHIDuration', 1, 100000),
    'broadcast_sta_info_duration': ('dot11BroadcastSTAInfoDuration', 1, 512),
    'assoc_resp_confirm_time': ('dot11AssocRespConfirmTime', 0, 255),
    'min_pp_duration': ('dot11MinPPDuration', 1, 100000),
    'sp_idle_timeout': ('dot11SPIdleTimeout', 1, 100000),
    'max_lost_beacons': ('dot11MaxLostBeacons', 1, 32),
}
MIB_DEFAULTS = {
    'dot11PSRequestSuspensionInterval': DOT11_PS_REQUEST_SUSPENSION_INTERVAL,
    'dot11MinBHIDuration': DOT11_MIN_BHI_DURATION,
    'dot11BroadcastSTAInfoDuration': DOT11_BROADCAST_STA_INFO_DURATION,
    'dot11AssocRespConfirmTime': None,
    'dot11MinPPDuration': DOT11_MIN_PP_DURATION,
    'dot11SPIdleTimeout': DOT11_SP_IDLE_TIMEOUT,
    'dot11MaxLostBeacons': DOT11_MAX_LOST_BEACONS,
}

# 11.3.5.4 c): что сбрасывается при реассоциации к тому же AP/PCP (и при ассоциации — 11.3.5.2 b), 11.3.5.3 k))
RESET_ON_REASSOC_SAME = ('EDCAF state', 'block ack agreements (non-GCR)', 'sequence number', 'packet number',
                         'duplicate detection caches', 'tx queues', 'fragmentation/reassembly buffers',
                         'power management mode', 'WNM sleep mode', 'TPKSAs', 'TSPECs', 'DMG TSPECs',
                         'GLK-GCR agreement', 'MSCS', 'SCS')
KEPT_ON_REASSOC_SAME = ('PSMP sessions', 'Enablement/Deenablement', 'GDD enablement', 'TDLS agreements', 'MMSLs',
                        'GCR agreements (non-GLK-GCR)', 'DMS agreements', 'TFS agreements', 'FMS agreements',
                        'triggered autonomous reporting', 'FTM sessions', 'DMG SP and CBAP allocations', 'PTP TSPECs')
RESET_ALL = RESET_ON_REASSOC_SAME + KEPT_ON_REASSOC_SAME

# Коды статуса (табл. 9-50), которые относятся к «misconfiguration or parameter mismatch» (11.3.5.2 g)).
# СПОРНО: стандарт не делит табл. 9-50 на «конфигурационные» и прочие; пример «не конфигурационного» — только
# «AP or PCP is unable to support additional associations» (17). Здесь конфигурационные — несовпадения
# возможностей/параметров/политики безопасности: 10, 13, 18, 19, 22, 23, 24, 25, 27, 40–46, 72.
CONFIG_STATUS = frozenset({10, 13, 18, 19, 22, 23, 24, 25, 27, 40, 41, 42, 43, 44, 45, 46, 72})
# То же для кодов причины (табл. 9-49, 11.3.5.7 d)): 10, 11, 13, 17–22, 24, 29. СПОРНО по той же причине.
CONFIG_REASON = frozenset({10, 11, 13, 17, 18, 19, 20, 21, 22, 24, 29})

S1, S2, S3, S4 = 1, 2, 3, 4                 # 11.3.1


class Refused(Exception):
    """Запрос MLME, который процедура обязана отклонить (rule — короткий ключ, msg — пункт)."""
    def __init__(self, rule, msg):
        super().__init__(f'{rule}: {msg}')
        self.rule, self.msg = rule, msg


def tu(x):
    """TU → мкс (3.1)."""
    return Fr(x) * TU


def mac_int(a):
    """12.7.1: MAC — 6 октетов как беззнаковое целое, первый октет — старший."""
    return int(a.replace(':', ''), 16)


def is_group(a):
    """9.2.4.3.2 / IEEE 802: бит I/G — младший бит первого октета."""
    return bool(int(a.split(':')[0], 16) & 1)


# =====================================================================================================
# 11.3.3 — классы кадров
# =====================================================================================================
_C1_CONTROL = frozenset({'RTS', 'CTS', 'DMG CTS', 'Ack', 'Grant', 'SSW', 'SSW-Feedback', 'SSW-Ack', 'Grant Ack',
                         'CF-End'})
# 9.6.21, табл. 9-486: Announce и BRP — кадры категории Unprotected DMG → «Unprotected DMG Action frames» (класс 1)
_C1_MGMT = frozenset({'Probe Request', 'Probe Response', 'Beacon', 'Authentication', 'Deauthentication', 'ATIM',
                      'Public Action', 'Self-protected Action', 'Unprotected DMG Action', 'Announce', 'BRP'})
_C2_MGMT = frozenset({'Association Request', 'Association Response', 'Reassociation Request',
                      'Reassociation Response', 'Disassociation'})
_C3_CONTROL = frozenset({'PS-Poll', 'Poll', 'SPR', 'DMG DTS'})
_BA = frozenset({'BlockAck', 'BlockAckReq'})
_QOS_TS = frozenset({'ADDTS Request', 'ADDTS Response', 'DELTS'})
# прочие Action / Action No Ack (DMG-категория: Information Request/Response, ADDBA/DELBA, SA Query …)
_ACTION = frozenset({'Action', 'Action No Ack', 'Information Request', 'Information Response', 'ADDBA Request',
                     'ADDBA Response', 'DELBA', 'SA Query Request', 'SA Query Response'}) | _QOS_TS
BSS_TYPES = ('infra', 'pbss', 'ibss')


def frame_class(kind, bss='infra', rsna=False):
    """11.3.3: класс кадра 1/2/3 для пары STA в BSS вида bss; rsna — dot11RSNAActivated у проверяющей STA."""
    assert bss in BSS_TYPES
    if kind == 'DMG Beacon':                            # a) 4) i) Extension frames
        return 1
    if kind in _C1_CONTROL or kind in _C1_MGMT:         # a) 1) i–x, a) 2) i–vii, ix
        return 1
    if kind in _BA:                                     # a) 1) xi–xii; c) 3) v–vi
        return 1 if bss == 'ibss' or (bss == 'pbss' and not rsna) else 3
    if kind in ('Data', 'EAPOL'):                       # a) 3) — IBSS и внутри PBSS; c) 1) — инфраструктура
        return 1 if bss in ('ibss', 'pbss') else 3
    if kind in _ACTION:
        if bss == 'ibss':                               # a) 2) viii
            return 1
        if bss == 'pbss' and not rsna and kind not in _QOS_TS:   # a) 2) x (кроме ADDTS Req/Resp, DELTS)
            return 1
        return 3                                        # c) 2) i
    if kind in _C2_MGMT:                                # b)
        return 2
    if kind in _C3_CONTROL:                             # c) 3) i–iv
        return 3
    raise ValueError(f'неизвестный вид кадра {kind!r}')


def class_allowed(state, cls):
    """11.3.3: State 1 — класс 1; State 2 — классы 1, 2; State 3/4 — все."""
    return cls <= {S1: 1, S2: 2, S3: 3, S4: 3}[state]


def may_transmit(state, kind, bss='infra', rsna=False):
    """11.3.3: «shall not transmit Class 2 frames unless in State 2 or 3 or 4», «Class 3 … unless in State 3 or 4»;
    11.3.1: State 3 — IEEE 802.1X Controlled Port заблокирован: из кадров Data проходит только EAPOL
    (неконтролируемый порт); в State 4 порт открыт. 'EAPOL' в инфраструктуре — класс 3 (Data)."""
    cls = frame_class(kind, bss, rsna)
    if not class_allowed(state, cls):
        return False
    if state == S3 and kind == 'Data' and bss == 'infra':
        return False
    return True


def rx_filter(state, kind, ra, bss='infra', rsna=False):
    """Приём кадра от удалённой STA, для которой у нас состояние state. → (решение, ответ, Reason Code):
    'accept'; 'ignore' (IBSS: «Class 2 and Class 3 frames are not allowed in an IBSS … shall ignore»);
    'discard' + 'Deauthentication' (11.3.4.1: класс 2/3 от STA в State 1, Address 1 — индивидуальный) или
    'Disassociation' (11.3.5.1: DMG STA в инфраструктуре, класс 3 от STA в State 2).
    Reason Code ответа стандарт не фиксирует; берём по смыслу табл. 9-49: 6 INVALID_CLASS2_FRAME /
    7 INVALID_CLASS3_FRAME. В PBSS ответ не предписан (правила 11.3.4.1/11.3.5.1 — «in an infrastructure BSS»):
    кадр только отбрасывается (11.3.3)."""
    cls = frame_class(kind, bss, rsna)
    if bss == 'ibss' and cls in (2, 3):
        return 'ignore', None, None
    if class_allowed(state, cls):
        return 'accept', None, None
    individual = not is_group(ra)
    if bss != 'infra' or not individual:
        return 'discard', None, None
    if state == S1:
        return 'discard', 'Deauthentication', INVALID_CLASS2_FRAME if cls == 2 else INVALID_CLASS3_FRAME
    return 'discard', 'Disassociation', INVALID_CLASS3_FRAME          # state 2, класс 3


# =====================================================================================================
# 11.3.1, 11.3.2 — переменная состояния пары STA
# =====================================================================================================
class Peer:
    """Состояние локальной STA относительно удалённой (11.3.1).
      dmg — пара DMG; auth80211 — выполнялась ли IEEE 802.11-аутентификация. 12.3.3.1: DMG STA не выполняет
      Open System — значит у DMG STA в инфраструктуре/PBSS обмен Authentication бывает только с другим
      алгоритмом (SAE …). 11.3.1: «State 2: Initial start state for DMG STAs that do not perform IEEE 802.11
      authentication», State 1 — для остальных.
      deauth_dmg — как поступать DMG STA без аутентификации, ИНИЦИИРУЮЩЕЙ деаутентификацию.
        СПОРНО: 11.3.4.4 c) «The state … shall be set to State 1» без исключений, а рис. 11-17 подписывает переходы
        в State 1 «Deauthentication (except DMG STAs that did not perform IEEE 802.11 authentication)», и 11.3.4.5
        для получателя такого кадра требует «shall remain in the same state». По умолчанию 'figure' — состояние не
        меняется (рис. 11-17 + симметрия с 11.3.4.5); 'text' — State 1 по 11.3.4.4 c)."""
    def __init__(self, dmg=True, auth80211=False, fils=False, deauth_dmg='figure'):
        assert deauth_dmg in ('figure', 'text')
        self.dmg, self.auth80211, self.fils, self.deauth_dmg = dmg, auth80211, fils, deauth_dmg
        self.state = S2 if dmg and not auth80211 else S1

    @property
    def dmg_no_auth(self):
        return self.dmg and not self.auth80211

    def auth_ok(self):
        """11.3.4.1, 11.3.4.2 c), 11.3.4.3 g): State 1 → 2; в остальных — без изменений."""
        self.auth80211 = True
        if self.state == S1:
            self.state = S2

    def deauth(self, originator):
        """11.3.4.4 c) (originator) / 11.3.4.5 (получатель). → прежнее состояние."""
        prev = self.state
        if self.dmg_no_auth and (not originator or self.deauth_dmg == 'figure'):
            return prev
        self.state = S1
        return prev

    def assoc_ok(self, rsna):
        """11.3.5.1: успех → State 3 или 4 (FILS — 4); 11.3.5.2 e): 4, или 3 при dot11RSNAActivated."""
        self.state = S4 if self.fils or not rsna else S3

    def disassoc(self):
        """11.3.5.1: «Disassociation notification when not in State 1 sets the state … to State 2» (FILS — 1)."""
        prev = self.state
        if prev != S1:
            self.state = S1 if self.fils else S2
        return prev

    def protection(self):
        """11.3.5.2 i), 11.3.5.3 p): MLME-SETPROTECTION.request(Rx_Tx) → State 4."""
        if self.state in (S3, S4):
            self.state = S4


# =====================================================================================================
# 11.3.5.2, 11.3.5.4, 11.3.5.6, 11.3.5.7 — non-AP / non-PCP STA
# =====================================================================================================
class StaMlme:
    """MLME non-AP / non-PCP DMG STA. Действия — в self.out (('tx', вид, адресат, поля)) и self.confirms
    (('MLME-…confirm', адресат, результат)). Время t — мкс.
      assoc_timeout_tu — dot11AssociationResponseTimeout (TU), DEFVAL в MIB нет;
      rsna — dot11RSNAActivated; bss — 'infra' | 'pbss'.
    Отсчёт dot11AssociationResponseTimeout — от передачи (Re)Association Request: MIB «number of TU that a
    requesting STA should wait for a response to a transmitted (Re)Association Request frame»; ответ точно на
    границе ещё принимается («within»)."""
    def __init__(self, mac, assoc_timeout_tu, rsna=False, bss='infra', deauth_dmg='figure'):
        assert bss in ('infra', 'pbss')
        self.mac, self.rsna, self.bss, self.deauth_dmg = mac, rsna, bss, deauth_dmg
        self.assoc_timeout_tu = assoc_timeout_tu
        self.mib = dict(MIB_DEFAULTS)
        self.peers = {}
        self.pending = None          # dict: kind, ap, deadline, current_ap, ft
        self.holdoff = {}            # ap → момент, раньше которого нельзя слать (Re)Association Request
        self.misconfig = set()       # ap, для которых ждём исправления конфигурации
        self.ess = {}                # ap → ESS (SSID) — для 11.3.5.4 a)
        self.out, self.confirms, self.resets = [], [], []

    def peer(self, ap, auth80211=False):
        if ap not in self.peers:
            self.peers[ap] = Peer(True, auth80211, deauth_dmg=self.deauth_dmg)
        return self.peers[ap]

    def state(self, ap):
        return self.peer(ap).state

    def associated_ap(self):
        return [a for a, p in self.peers.items() if p.state in (S3, S4)]

    # ---- аутентификация (11.3.4.2, 12.3.3.1) ----
    def authenticate(self, ap, alg, t, ok, t_done=None, failure_timeout_tu=None):
        """11.3.4.2. 12.3.3.1: «A DMG STA shall not perform an IEEE 802.11 authentication exchange using the Open
        System authentication algorithm» → Refused. Успех засчитывается, только если завершён в пределах
        AuthenticateFailureTimeout (TU) от t (11.3.4.2 c))."""
        if alg == AUTH_OPEN_SYSTEM:
            raise Refused('dmg_open_system', '12.3.3.1: DMG STA не выполняет Open System')
        p = self.peer(ap, auth80211=True)
        in_time = failure_timeout_tu is None or t_done is None or t_done - t <= tu(failure_timeout_tu)
        if ok and in_time:
            p.auth_ok()
        self.confirms.append(('MLME-AUTHENTICATE.confirm', ap, SUCCESS if ok and in_time else 'FAILURE'))
        return p.state

    # ---- запреты повторной (ре)ассоциации ----
    def can_request(self, ap, t):
        """11.3.5.2 g), 11.3.5.4 f) 2), 11.3.5.7 d) e). → (bool, правило)."""
        if ap in self.misconfig:
            return False, 'misconfig'
        if t < self.holdoff.get(ap, Fr(-1)):
            return False, 'holdoff'
        return True, None

    def config_corrected(self, ap):
        self.misconfig.discard(ap)

    def _fail_holdoff(self, ap, t, status, tie, config_related):
        cfg = (status in CONFIG_STATUS) if config_related is None else config_related
        if cfg:
            self.misconfig.add(ap)
        if tie is not None:
            kind, value = tie
            if kind == TIE_ASSOC_COMEBACK:              # «until the period specified in the TIE has elapsed»
                self.holdoff[ap] = t + tu(value)
                return
        if not cfg:                                     # «at least 2 s»
            self.holdoff[ap] = t + RETRY_HOLDOFF

    # ---- ассоциация (11.3.5.2) ----
    def associate(self, ap, t, ssid=None, pcp_assoc_ready=None):
        """MLME-ASSOCIATE.request в момент t (= передача Association Request).
        pcp_assoc_ready — поле PCP Association Ready последнего DMG Beacon от PCP (11.1.3.7: при 0 «shall not
        transmit an Association Request frame addressed to the PCP»)."""
        if self.pending:
            raise Refused('pending', 'уже идёт (ре)ассоциация')
        if self.bss == 'pbss' and pcp_assoc_ready == 0:
            raise Refused('pcp_assoc_ready', '11.1.3.7: PCP Association Ready = 0')
        ok, why = self.can_request(ap, t)
        if not ok:
            raise Refused(why, '11.3.5.2 g) / 11.3.5.7 d) e)')
        p = self.peer(ap)
        if p.state == S1:                               # a)
            self.confirms.append(('MLME-ASSOCIATE.confirm', ap, 'FAILURE'))
            return False
        self.resets.append((ap, RESET_ALL))             # b)
        self.out.append(('tx', 'Association Request', ap, {}))     # c)
        self.pending = dict(kind='assoc', ap=ap, deadline=t + tu(self.assoc_timeout_tu), current_ap=None,
                            ft=False, ssid=ssid)
        return True

    def _adopt_mib(self, cfg):
        """11.3.5.2 d) / 11.3.5.4 d): MIB ← DMG BSS Parameter Configuration; значение вне SYNTAX MIB → ValueError."""
        for field, (name, lo, hi) in BSS_PARAM_TO_MIB.items():
            if field in cfg:
                v = cfg[field]
                if not lo <= v <= hi:
                    raise ValueError(f'{field} = {v} вне {name} {lo}..{hi}')
                self.mib[name] = v

    def on_assoc_resp(self, ap, t, status, dmg_op_cfg=None, tie=None, config_related=None):
        """Association / Reassociation Response от ap в момент t. tie — (Timeout Interval Type, Value) или None."""
        pd = self.pending
        if not pd or pd['ap'] != ap or t > pd['deadline']:
            return None                                 # ответ вне процедуры — игнорируется
        self.pending = None
        reassoc = pd['kind'] == 'reassoc'
        name = 'MLME-REASSOCIATE.confirm' if reassoc else 'MLME-ASSOCIATE.confirm'
        p = self.peer(ap)
        if status == SUCCESS:
            if dmg_op_cfg:
                self._adopt_mib(dmg_op_cfg)             # d)
            if reassoc:
                old = pd['current_ap']
                p.state = S4 if (pd['ft'] or not self.rsna) else S3      # 11.3.5.4 c)
                if old is not None and old != ap and old in self.peers:
                    self.peers[old].state = S2
                self.resets.append((ap, RESET_ON_REASSOC_SAME if old == ap else RESET_ALL))
            else:
                for other, q in self.peers.items():     # e): прочие AP/PCP в State 3/4 → State 2
                    if other != ap and q.state in (S3, S4):
                        q.state = S2
                p.assoc_ok(self.rsna)
            if pd['ssid'] is not None:
                self.ess[ap] = pd['ssid']
            self.confirms.append((name, ap, SUCCESS))
            return p.state
        # g) / 11.3.5.4 f): неуспех → State 2 относительно этого AP (FT — без изменения)
        if not (reassoc and pd['ft']):
            p.state = S2
        self._fail_holdoff(ap, t, status, tie, config_related)
        self.confirms.append((name, ap, status))
        return p.state

    def tick(self, t):
        """Истечение dot11AssociationResponseTimeout: «fails to complete within …» → State 2, confirm(TIMEOUT)."""
        pd = self.pending
        if pd and t > pd['deadline']:
            self.pending = None
            if not (pd['kind'] == 'reassoc' and pd['ft']):
                self.peer(pd['ap']).state = S2
            self.confirms.append(('MLME-REASSOCIATE.confirm' if pd['kind'] == 'reassoc' else
                                  'MLME-ASSOCIATE.confirm', pd['ap'], 'TIMEOUT'))
            return True
        return False

    def adopt_assoc_resp_confirm_time(self, n):
        """9.4.2.128: AssocRespConfirmTime (×50 мс) «can use … to set dot11AssociationResponseTimeOut».
        СПОРНО: перевод 50 мс → TU; берём вверх (⌈n·50000/1024⌉), чтобы тайм-аут не был короче обещанного AP."""
        self.assoc_timeout_tu = ceil(n * ASSOC_RESP_CONFIRM_UNIT / TU)
        return self.assoc_timeout_tu

    def on_auth_assoc_delay(self, delay_tu):
        """11.3.4.3: Association Delay Info → dot11AssociationResponseTimeOut ≥ значения поля."""
        self.assoc_timeout_tu = max(self.assoc_timeout_tu, delay_tu)

    def set_protection(self, ap):
        self.peer(ap).protection()

    # ---- реассоциация (11.3.5.4) ----
    def reassociate(self, new_ap, current_ap, t, ft=False, ssid=None, pcp_assoc_ready=None):
        """a): «not associated in the same ESS or the state for the new AP or PCP is State 1» → confirm(FAILURE).
        ssid — ESS нового AP; текущая ассоциация — с current_ap в State 3/4 и тем же SSID."""
        if self.pending:
            raise Refused('pending', 'уже идёт (ре)ассоциация')
        if self.bss == 'pbss' and pcp_assoc_ready == 0:
            raise Refused('pcp_assoc_ready', '11.1.3.7: PCP Association Ready = 0')
        ok, why = self.can_request(new_ap, t)
        if not ok:
            raise Refused(why, '11.3.5.4 f) 2) / 11.3.5.7 d) e)')
        cur = self.peers.get(current_ap)
        same_ess = cur is not None and cur.state in (S3, S4) and (ssid is None or self.ess.get(current_ap) == ssid)
        if not same_ess or self.peer(new_ap).state == S1:
            self.confirms.append(('MLME-REASSOCIATE.confirm', new_ap, 'FAILURE'))
            return False
        self.out.append(('tx', 'Reassociation Request', new_ap, {'current_ap': current_ap}))   # b)
        self.pending = dict(kind='reassoc', ap=new_ap, deadline=t + tu(self.assoc_timeout_tu),
                            current_ap=current_ap, ft=ft, ssid=ssid if ssid is not None else
                            self.ess.get(current_ap))
        return True

    # ---- дизассоциация (11.3.5.6, 11.3.5.7) ----
    def disassociate(self, ap, reason):
        p = self.peer(ap)
        if p.state in (S3, S4):                         # a)
            self.out.append(('tx', 'Disassociation', ap, {'reason': reason}))
        p.disassoc()                                    # b)
        self.confirms.append(('MLME-DISASSOCIATE.confirm', ap, SUCCESS))   # c)
        return p.state

    def on_disassoc(self, ap, t, reason, mfp_discard=False):
        """11.3.5.7: только от AP/PCP в State 3/4 и если кадр не отброшен MFP."""
        p = self.peer(ap)
        if mfp_discard or p.state not in (S3, S4):
            return p.state
        p.disassoc()                                    # a)
        self.confirms.append(('MLME-DISASSOCIATE.indication', ap, reason))   # b)
        if reason in CONFIG_REASON:                     # d)
            self.misconfig.add(ap)
        else:                                           # e)
            self.holdoff[ap] = max(self.holdoff.get(ap, Fr(-1)), t + RETRY_HOLDOFF)
        return p.state

    # ---- деаутентификация (11.3.4.4, 11.3.4.5) ----
    def deauthenticate(self, ap, reason):
        p = self.peer(ap)
        if p.state in (S2, S3, S4):                     # b)
            self.out.append(('tx', 'Deauthentication', ap, {'reason': reason}))
        p.deauth(originator=True)                       # c)
        self.confirms.append(('MLME-DEAUTHENTICATE.confirm', ap, SUCCESS))
        return p.state

    def on_deauth(self, ap, reason, mfp_discard=False):
        p = self.peer(ap)
        if mfp_discard or p.state == S1:
            return p.state
        prev = p.state
        p.deauth(originator=False)
        if p.state != prev:
            self.confirms.append(('MLME-DEAUTHENTICATE.indication', ap, reason))
        return p.state

    def rx(self, ap, kind, ra):
        """Фильтр приёма по состоянию (11.3.3/11.3.4.1/11.3.5.1); ответ-кадр кладётся в out."""
        d, reply, reason = rx_filter(self.peer(ap).state, kind, ra, self.bss, self.rsna)
        if reply:
            self.out.append(('tx', reply, ap, {'reason': reason}))
        return d


# =====================================================================================================
# 11.3.5.3, 11.3.5.5, 11.3.5.8, 11.3.5.9, 11.3.7 — AP / PCP
# =====================================================================================================
class ApMlme:
    """MLME DMG AP или PCP. SME-решение (ResultCode) передаёт вызывающий в result; AP сам добавляет то, что
    предписано: AID 1…254 (9.4.1.8; нет свободного — DENIED_NO_MORE_STAS), отказ REFUSED_TEMPORARILY + TIE
    типа 3 при MFP (11.3.5.3 e)), переходы состояний после Ack ответа (n), l)), освобождение AID.
      max_sta — предел ассоциированных STA (не больше 254)."""
    def __init__(self, mac, bss='infra', rsna=False, max_sta=AID_DMG_MAX, deauth_dmg='figure'):
        assert bss in ('infra', 'pbss') and max_sta <= AID_DMG_MAX
        self.mac, self.bss, self.rsna, self.max_sta, self.deauth_dmg = mac, bss, rsna, max_sta, deauth_dmg
        self.peers, self.aid, self.heartbeat = {}, {}, {}
        self.pending_resp = {}      # sta → ('assoc'|'reassoc', status, ft, heartbeat)
        self.out, self.ind, self.resets = [], [], []
        self.pmf = set()            # STA с согласованной MFP и действующей SA
        self.info = PbssInfoDistribution() if bss == 'pbss' else None

    def peer(self, sta):
        if sta not in self.peers:
            self.peers[sta] = Peer(True, False, deauth_dmg=self.deauth_dmg)
        return self.peers[sta]

    def state(self, sta):
        return self.peer(sta).state

    def authenticate(self, *a, **k):
        raise Refused('ap_initiates_auth', '11.3.4.1: «APs and PCPs do not initiate authentication»')

    def associate(self, *a, **k):
        raise Refused('ap_initiates_assoc', '11.3.5.1: «APs and PCPs do not initiate association»')

    def on_auth_req(self, sta, alg, accept=True):
        """12.3.3.1: DMG STA не выполняет Open System; 12.3.3.2.1: Open System можно пройти «Any non-DMG STA».
        СПОРНО: что делать DMG AP с запросом Open System от DMG STA — не сказано; модель отвечает
        UNSUPPORTED_AUTH_ALGORITHM (13) и состояние не меняет (11.3.4.3 f)). Другие алгоритмы: accept → SUCCESS,
        State 1 → 2 (11.3.4.3 g))."""
        p = self.peer(sta)
        if alg == AUTH_OPEN_SYSTEM:
            self.out.append(('tx', 'Authentication', sta, {'status': UNSUPPORTED_AUTH_ALGORITHM}))
            return UNSUPPORTED_AUTH_ALGORITHM
        p.auth80211 = True
        if accept:
            p.auth_ok()
            self.out.append(('tx', 'Authentication', sta, {'status': SUCCESS}))
            return SUCCESS
        self.out.append(('tx', 'Authentication', sta, {'status': 1}))
        return 1

    def _free_aid(self):
        used = set(self.aid.values())
        if len(used) >= self.max_sta:
            return None
        for a in range(AID_DMG_MIN, AID_DMG_MAX + 1):
            if a not in used:
                return a
        return None

    def _release(self, sta):
        self.aid.pop(sta, None)

    def on_assoc_req(self, sta, t=0, result=SUCCESS, heartbeat=False, reassoc=False, current_ap=None, ft=False,
                     sa_query_remaining_tu=None):
        """11.3.5.3 / 11.3.5.5: → (status, aid, tie). Состояние меняется только по Ack (on_resp_acked) или сразу
        при отказе (o) / m))."""
        p = self.peer(sta)
        tie = None
        status = result
        # e): State 4, действующая SA с MFP → REFUSED_TEMPORARILY + TIE type 3 (FT — исключение для реассоциации)
        if status == SUCCESS and p.state == S4 and sta in self.pmf and not (reassoc and ft):
            status = REFUSED_TEMPORARILY
            tie = (TIE_ASSOC_COMEBACK, sa_query_remaining_tu if sa_query_remaining_tu is not None
                   else DOT11_ASSOC_SA_QUERY_MAX_TIMEOUT)
        aid = None
        if status == SUCCESS:
            aid = self.aid.get(sta) or self._free_aid()
            if aid is None:
                status = DENIED_NO_MORE_STAS
        if status == SUCCESS:
            self.aid[sta] = aid
            same = reassoc and current_ap == self.mac
            if not (reassoc and ft):                     # 11.3.5.3 k), 11.3.5.5 p) q)
                self.resets.append((sta, RESET_ON_REASSOC_SAME if same else RESET_ALL))
            self.pending_resp[sta] = ('reassoc' if reassoc else 'assoc', ft, heartbeat)
        else:
            # o) / m): MFP — без изменений; без MFP (и не FT) — State 4 → 3
            if sta not in self.pmf and not (reassoc and ft) and p.state == S4:
                p.state = S3
        kind = 'Reassociation Response' if reassoc else 'Association Response'
        self.out.append(('tx', kind, sta, {'status': status, 'aid': aid, 'tie': tie}))
        return status, aid, tie

    def on_resp_acked(self, sta, k_bi=None):
        """n) / l): Ack на ответ SUCCESS → State 4, или 3 при dot11RSNAActivated (FT-реассоциация — 4)."""
        kind, ft, hb = self.pending_resp.pop(sta)
        p = self.peer(sta)
        p.state = S4 if (not self.rsna or (kind == 'reassoc' and ft)) else S3
        self.heartbeat[sta] = hb        # 10.39.3: Heartbeat из последней успешной Association Request
        if self.info is not None:
            self.info.on_assoc(k_bi)
        self.ind.append(('MLME-ASSOCIATE.indication-complete', sta, p.state))
        return p.state

    def on_resp_abandoned(self, sta):
        """Ack на ответ SUCCESS не получен: состояние не меняется (n) требует Ack). Судьба AID стандартом не
        задана — освобождаем, если STA не ассоциирована."""
        self.pending_resp.pop(sta, None)
        if self.peer(sta).state not in (S3, S4):
            self._release(sta)

    def set_protection(self, sta):
        self.peer(sta).protection()

    def disassociate(self, sta, reason):
        """11.3.5.8 a) b); AID освобождается в confirm (e)) — on_mgmt_done."""
        p = self.peer(sta)
        prev = p.state
        if prev in (S3, S4):
            self.out.append(('tx', 'Disassociation', sta, {'reason': reason}))
        p.disassoc()
        return prev

    def on_mgmt_done(self, sta, prev_state):
        """c)–e) 11.3.5.8 и f) 11.3.4.4: после Ack или отказа от передачи — освободить AID, если было State 3/4."""
        if prev_state in (S3, S4):
            self._release(sta)
            self.heartbeat.pop(sta, None)

    def on_disassoc(self, sta, mfp_discard=False):
        """11.3.5.9: от STA в State 3/4 → State 2, AID освобождается (e))."""
        p = self.peer(sta)
        if mfp_discard or p.state not in (S3, S4):
            return p.state
        p.disassoc()
        self._release(sta)
        self.heartbeat.pop(sta, None)
        self.ind.append(('MLME-DISASSOCIATE.indication', sta, None))
        return p.state

    def deauthenticate(self, sta, reason):
        p = self.peer(sta)
        prev = p.state
        if prev in (S2, S3, S4):
            self.out.append(('tx', 'Deauthentication', sta, {'reason': reason}))
        p.deauth(originator=True)
        return prev

    def on_deauth(self, sta, mfp_discard=False):
        """11.3.4.5: DMG без аутентификации — состояние не меняется; иначе State 1 и освобождение AID (b) 2))."""
        p = self.peer(sta)
        if mfp_discard or p.state == S1:
            return p.state
        prev = p.state
        p.deauth(originator=False)
        if p.state != prev:
            self._release(sta)
        return p.state

    def rx(self, sta, kind, ra):
        d, reply, reason = rx_filter(self.peer(sta).state, kind, ra, self.bss, self.rsna)
        if reply:
            self.out.append(('tx', reply, sta, {'reason': reason}))
        return d


class PbssInfoDistribution:
    """11.3.7: после ассоциации PCP шлёт Information Response; распространение — не реже раза в
    dot11BroadcastSTAInfoDuration интервалов маяка. Интервалы — номера BI k.
    СПОРНО: «following the association» без срока; считаем долгом до ближайшей рассылки, но не позже
    k_assoc + dot11BroadcastSTAInfoDuration."""
    def __init__(self, duration=DOT11_BROADCAST_STA_INFO_DURATION, k0=0):
        self.duration, self.last, self.owed_since = duration, k0, None

    def on_assoc(self, k):
        if k is not None and self.owed_since is None:
            self.owed_since = k

    def on_sent(self, k):
        self.last, self.owed_since = k, None

    def deadline(self):
        d = self.last + self.duration
        if self.owed_since is not None:
            d = min(d, self.owed_since + self.duration)
        return d

    def overdue(self, k):
        return k > self.deadline()


# =====================================================================================================
# 10.39.3 — ATI
# =====================================================================================================
AirFrame = namedtuple('AirFrame', 'kind ta ra start end response_offset no_ack', defaults=(None, False))

ATI_REQUEST_KINDS = frozenset(_C1_MGMT | _C2_MGMT | _ACTION | {'Ack', 'Grant', 'Poll', 'RTS', 'DMG CTS', 'EAPOL'})
ATI_RESPONSE_KINDS = frozenset(_C1_MGMT | _C2_MGMT | _ACTION | {'Ack', 'SPR', 'DMG CTS', 'EAPOL'})


def ati_start_earliest(prev_end, guard=0):
    """10.39.3: ATI начинается не раньше Max(guard time, MBIFS) после конца A-BFT (или BTI без A-BFT)."""
    return prev_end + max(Fr(guard), MBIFS)


def ati_sta_response(f, me, ap):
    """10.39.3: non-AP STA передаёт в ATI только в ответ на индивидуальный кадр с TA = AP и RA = STA; ответ —
    через SIFS после приёма, адресован AP. Групповой RA — без ответа (NOTE 2). → момент начала ответа или None."""
    if f.ta != ap or f.ra != me or is_group(f.ra):
        return None
    return f.end + SIFS


class AtiAp:
    """10.39.3: AP/PCP в ATI. Heartbeat = 1 в DMG Capabilities последней успешной Association Request → в каждом ATI
    планировать передачу этой STA; не ответила → следующая попытка и далее — DMG Control modulation class, пока
    не придёт корректный кадр от STA."""
    def __init__(self):
        self.hb, self.control_only = set(), set()

    def set_heartbeat(self, sta, flag):
        (self.hb.add if flag else self.hb.discard)(sta)

    def must_schedule(self):
        return sorted(self.hb)

    def on_no_response(self, sta):
        self.control_only.add(sta)

    def on_valid_frame(self, sta):
        self.control_only.discard(sta)

    def modulation(self, sta):
        return 'control' if sta in self.control_only else 'any'

    @staticmethod
    def next_tx_earliest(prev_end, same_sta):
        """«a SIFS elapses without its receipt, the AP … may either repeat … or, as early as one PIFS after the end
        of its previous transmission, transmit a frame to any other STA».
        СПОРНО: для повтора той же STA нижняя граница прямо не названа; берём «после SIFS без ответа» → prev_end
        + SIFS (альтернатива — тоже PIFS)."""
        return prev_end + (SIFS if same_sta else PIFS)


def check_ati_frame(f, ap, by_ap, prev_request=None):
    """10.39.3: список нарушений для кадра f в ATI.
      by_ap — передаёт AP/PCP; prev_request — кадр-запрос AP, на который отвечает STA."""
    v = []
    if by_ap:
        if f.kind not in ATI_REQUEST_KINDS:
            v.append(('ati_kind', f'{f.kind} не может быть запросом в ATI'))
        if f.kind == 'Poll' and f.response_offset not in (None, 0):
            v.append(('ati_poll_offset', 'Response Offset в Poll в ATI ≠ 0'))
        if f.no_ack and not is_group(f.ra):
            v.append(('ati_no_ack', 'индивидуальный запрос в ATI как Action No Ack'))
        return v
    if f.kind not in ATI_RESPONSE_KINDS:
        v.append(('ati_kind', f'{f.kind} не может быть ответом в ATI'))
    if f.ra != ap:
        v.append(('ati_resp_ra', 'ответ STA в ATI адресован не AP/PCP'))
    if prev_request is None or ati_sta_response(prev_request, f.ta, ap) is None:
        v.append(('ati_unsolicited', 'STA передаёт в ATI не в ответ на индивидуальный запрос AP'))
    elif f.start != prev_request.end + SIFS:
        v.append(('ati_resp_sifs', f'ответ через {f.start - prev_request.end} мкс, нужно SIFS'))
    return v


# =====================================================================================================
# 11.1.4 — сканирование
# =====================================================================================================
class ScanRequest:
    """Параметры MLME-SCAN.request (6.3.3.2.2): scan_type 'passive'|'active'; channels — ChannelList;
    min_ct, max_ct — MinChannelTime/MaxChannelTime (TU, max_ct ≥ min_ct); probe_delay — мкс; ssid (None или ''
    — wildcard), bssid (None — wildcard), ssid_list, discovery_mode (0/1)."""
    def __init__(self, scan_type, channels, min_ct, max_ct=None, probe_delay=0, ssid=None, bssid=None,
                 ssid_list=(), discovery_mode=0):
        assert scan_type in ('passive', 'active')
        max_ct = min_ct if max_ct is None else max_ct
        if max_ct < min_ct:
            raise ValueError('MaxChannelTime < MinChannelTime (6.3.3.2.2)')
        self.scan_type, self.channels = scan_type, list(channels)
        self.min_ct, self.max_ct, self.probe_delay = min_ct, max_ct, Fr(probe_delay)
        self.ssid = ssid or WILDCARD_SSID
        self.bssid = bssid or WILDCARD_BSSID
        self.ssid_list, self.discovery_mode = tuple(ssid_list), discovery_mode


BssDesc = namedtuple('BssDesc', 'bssid ssid bss_type channel beacon_interval discovery_mode source',
                     defaults=(None, None, None, None, 100, 0, 'DMG Beacon'))


def desc_matches(req, d):
    """11.1.4.1/11.1.4.2.2: BSSID и SSID из запроса (wildcard — любой). SSID в DMG Beacon необязателен
    (табл. 9-45, порядок 18). СПОРНО: DMG Beacon без SSID при заданном в запросе SSID — не совпадает (SSID нельзя
    подтвердить; альтернатива — сообщать такие BSS, т. к. их SSID нельзя и опровергнуть)."""
    if req.bssid != WILDCARD_BSSID and d.bssid != req.bssid:
        return False
    wanted = {s for s in (req.ssid,) + req.ssid_list if s}
    if not wanted or WILDCARD_SSID in (req.ssid_list or ()):
        return True
    return d.ssid is not None and d.ssid in wanted


def _desc(d):
    """11.1.3.7: «ignore the BSS Type field … if the Discovery Mode field … is 1»."""
    return d._replace(bss_type=None) if d.discovery_mode == 1 else d


class PassiveScan:
    """11.1.4.2.2 — пассивное сканирование DMG STA (судья/генератор).
      visit(ch, t0, t1, rx) — пребывание на канале [t0, t1] и принятые кадры (BssDesc для DMG Beacon, либо строка
      вида прочего кадра); tx(kind) — любая передача во время сканирования.
    Правила: на канале — не меньше MinChannelTime («no less than MinChannelTime»; верхнего предела у DMG нет,
    MaxChannelTime — только non-DMG, 11.1.4.2.1); не-DMG Beacon не прерывает канал; результат — все DMG Beacon,
    совпавшие с BSSID/SSID (без параметров — все); каналы — только из ChannelList, все; STA «in the receive
    state» и на Probe Request не отвечает (NOTE 11.1.4.2.2)."""
    def __init__(self, req):
        assert req.scan_type == 'passive'
        self.req, self.visits, self.found, self.txs = req, [], [], []

    def visit(self, ch, t0, t1, rx=()):
        self.visits.append((ch, Fr(t0), Fr(t1)))
        for f in rx:
            if isinstance(f, BssDesc) and f.source == 'DMG Beacon':
                d = _desc(f._replace(channel=ch))
                if desc_matches(self.req, d) and d not in self.found:
                    self.found.append(d)

    def tx(self, kind):
        self.txs.append(kind)

    def confirm(self):
        return list(self.found)

    def violations(self):
        v = []
        seen = set()
        for ch, t0, t1 in self.visits:
            if ch not in self.req.channels:
                v.append(('scan_channel', f'канал {ch} не из ChannelList'))
            if t1 - t0 < tu(self.req.min_ct):
                v.append(('scan_dwell', f'канал {ch}: {t1 - t0} мкс < MinChannelTime'))
            seen.add(ch)
        for ch in self.req.channels:
            if ch not in seen:
                v.append(('scan_missed', f'канал {ch} не просканирован'))
        for k in self.txs:
            v.append(('scan_passive_tx', f'передача {k} при пассивном сканировании'))
        return v


class DmgActiveScan:
    """11.1.4.3.3 — активное сканирование DMG STA на одном канале (шаги a–j).
      start(t) — начало канала; on_rx_start(t) — PHY-RXSTART до истечения ProbeDelay (a); таймер (b) стартует
      в min(t + ProbeDelay, первый RXSTART).
      may_beacon(t) — c): DMG Beacon с Discovery Mode = 1 «for a period no longer than MaxChannelTime».
      on_dmg_beacon(t, bf_required) — d): BF (10.42.5) только если DMG Beacon принят до MaxChannelTime.
      on_ssw_feedback(direction, peer) — что было в d): 'tx' (передали SSW-Feedback адресату peer) или 'rx'.
      probe_plan() — f)/g): (обязательна ли Probe Request, допустимые RA).
      on_probe_response(t, desc) — i): учитываются до MaxChannelTime и по критериям запроса.
      end() — j): NAV = 0."""
    def __init__(self, req, me, ch=None):
        assert req.scan_type == 'active'
        self.req, self.me, self.ch = req, me, ch
        self.t_start = self.t_timer = None
        self.fb = None
        self.found, self.nav, self.bf = [], None, []

    def start(self, t):
        self.t_start, self.t_timer = Fr(t), Fr(t) + self.req.probe_delay

    def on_rx_start(self, t):
        if self.t_timer is not None and t < self.t_timer:
            self.t_timer = Fr(t)

    def _elapsed(self, t):
        return Fr(t) - self.t_timer

    def may_beacon(self, t):
        return self.req.discovery_mode == 1 and 0 <= self._elapsed(t) <= tu(self.req.max_ct)

    def may_tx(self, t):
        """a): до ProbeDelay/RXSTART STA ждёт — передавать нельзя."""
        return Fr(t) >= self.t_timer

    def on_dmg_beacon(self, t, bf_required=True):
        if self._elapsed(t) < tu(self.req.max_ct) and bf_required:
            self.bf.append(Fr(t))
            return True
        return False

    def on_ssw_feedback(self, direction, peer):
        assert direction in ('tx', 'rx')
        self.fb = (direction, peer)

    def probe_plan(self):
        """→ (required, allowed_ra, extra_broadcast_allowed). f) 1): после SSW-Feedback probe обязательна:
        RA — broadcast или (tx) адресат SSW-Feedback / (rx, «Optionally») передатчик SSW-Feedback.
        g) 1): иначе — необязательна, только broadcast. f) 2) / g) 2): при SSID List — ещё ≥ 0 broadcast-запросов.
        Во всех — DMG Capabilities element (проверяет elements.py)."""
        extra = bool(self.req.ssid_list)
        if self.fb is None:
            return False, {BCAST}, extra
        return True, {BCAST, self.fb[1]}, extra

    def on_probe_response(self, t, d):
        if self._elapsed(t) < tu(self.req.max_ct) and desc_matches(self.req, d):
            d = _desc(d._replace(channel=self.ch, source='Probe Response'))
            if d not in self.found:
                self.found.append(d)
            return True
        return False

    def end(self):
        self.nav = 0
        return list(self.found)


def should_respond_probe(r, preq):
    """11.1.4.3.4 (без multiple BSSID, Interworking, FILS, mesh-ID). → (bool, буква пункта отказа или None).
      r — dict: role ('ap'|'pcp'|'ibss'|'sta'), dmg, pbss_member, active_scan, mac, bssid (None — не в BSS),
          ssid (None — не в BSS), bss ('infra'|'pbss'|'ibss'|None), beacon_since_tbtt (IBSS), trained(ta)→bool,
          channel (dot11CurrentChannel);
      preq — dict: ta, ra (Address 1), bssid (Address 3), ssid ('' — wildcard), ssid_list, dsss_channel."""
    role = r['role']
    ok_role = (role in ('ap', 'ibss', 'pcp') or
               (role == 'sta' and r.get('dmg') and not r.get('pbss_member') and r.get('active_scan')))
    if not ok_role:
        return False, 'a'
    ra = preq['ra']
    bcast = is_group(ra)
    if not bcast and ra != r['mac']:
        return False, 'b'
    if role == 'sta' and r.get('dmg') and r.get('bss') == 'infra' and bcast:
        return False, 'c'
    if role == 'sta' and r.get('bss') == 'pbss' and bcast:
        return False, 'd'
    if role == 'ibss' and not r.get('beacon_since_tbtt') and bcast:
        return False, 'e'
    ssid = preq.get('ssid', WILDCARD_SSID)
    lst = preq.get('ssid_list', ())
    if not (ssid == WILDCARD_SSID or (r.get('ssid') is not None and
                                      (ssid == r['ssid'] or r['ssid'] in lst))):
        return False, 'g'
    a3 = preq.get('bssid', WILDCARD_BSSID)
    if a3 != WILDCARD_BSSID and a3 != r.get('bssid'):
        return False, 'h'
    ch = preq.get('dsss_channel')
    if ch is not None and ch != r.get('channel'):
        return False, 'j'
    if r.get('dmg') and not r.get('trained', lambda _: True)(preq['ta']):
        return False, 'k'
    return True, None


def probe_response_ra(preq):
    """11.1.4.3.9: non-FILS STA — Address 1 = адрес STA, сгенерировавшей Probe Request."""
    return preq['ta']


class DiscoveryBeaconing:
    """11.1.3.4 — DMG Beacon до установления BSS (DiscoveryMode = 1 в MLME-SCAN, 11.1.4.3.3 c)).
    check_bti(beacons) — кадры одного BTI: dict(discovery_mode, next_abft, bi_tu, duration, bti_end, end);
    next_bti(t_first_last, bi_tu) — начало следующего BTI (CCA занят → можно позже, не раньше);
    tsf_reset_at — TSF = 0 в первом TBTT с Discovery Mode = 1 и в TBTT BI, где поменяли Beacon Interval;
    should_cease(event) — 'rx_dmg_beacon' от другой STA или 'probe_resp_acked'."""
    def __init__(self):
        self.prev_bi, self.tsf_resets = None, []

    @staticmethod
    def bi_ok(bi_tu):
        """«should generate a random value … 10 TUs to 199 TUs»."""
        return DISCOVERY_BI_TU[0] <= bi_tu <= DISCOVERY_BI_TU[1]

    def check_bti(self, tbtt, beacons):
        v = []
        bis = {b['bi_tu'] for b in beacons}
        if len(bis) > 1:
            v.append(('disc_bi_same', 'разные Beacon Interval в одном BTI'))
        for b in beacons:
            if b['discovery_mode'] != 1:
                v.append(('disc_mode', 'Discovery Mode ≠ 1'))
            if b.get('next_abft', 0) != 0:
                v.append(('disc_next_abft', 'Next A-BFT ≠ 0'))
            if 'duration' in b and b['duration'] != b['bti_end'] - b['end']:
                v.append(('disc_duration', 'Duration ≠ остаток BTI'))
        bi = next(iter(bis)) if len(bis) == 1 else None
        if self.prev_bi is None or (bi is not None and bi != self.prev_bi):
            self.tsf_resets.append(tbtt)
        if bi is not None and not self.bi_ok(bi):
            v.append(('disc_bi_range', f'Beacon Interval {bi} TU вне 10…199 (should)'))
        self.prev_bi = bi
        return v

    @staticmethod
    def next_bti(t_first_last, bi_tu):
        return Fr(t_first_last) + tu(bi_tu)

    @staticmethod
    def should_cease(event):
        return event in ('rx_dmg_beacon', 'probe_resp_acked')


# =====================================================================================================
# 11.1.4.3.10, 11.1.4.4.2 — выбор PCP и запуск DMG BSS
# =====================================================================================================
PCP_FACTOR = [('_r0', 7), ('max_associated_sta', 8), ('total_sectors', 7), ('pseudo_static', 1), ('tddti', 1),
              ('decentralized_clustering', 1), ('power_source', 1), ('_r26', 6)]


def pcp_factor(caps):
    """Рис. 11-9: PCP factor DMG STA (B0 — младший бит). caps — значения полей DMG Capabilities как на эфире."""
    v, pos = 0, 0
    for name, w in PCP_FACTOR:
        x = 0 if name.startswith('_') else caps.get(name, 0)
        if not 0 <= x < (1 << w):
            raise ValueError(f'{name} = {x} не влезает в {w} бит')
        v |= x << pos
        pos += w
    assert pos == 32
    return v


def candidate_pcp(self_factor, self_mac, peer_factor, peer_mac):
    """11.1.4.3.10: кандидат, если self > peer или равны и MAC больше (12.7.1)."""
    return self_factor > peer_factor or (self_factor == peer_factor and mac_int(self_mac) > mac_int(peer_mac))


def personal_start_window(t_confirm, candidate):
    """11.1.4.4.2: кандидат PCP — MLME-START(PERSONAL) «should … no later than 4×aMaxBIDuration» после
    MLME-SCAN.confirm → (t_confirm, t_confirm + 4·aMaxBIDuration); не кандидат — «shall not … if less than
    4 × aMaxBIDuration has elapsed» → (t_confirm + 4·aMaxBIDuration, None)."""
    d = tu(PERSONAL_START_TU)
    return (Fr(t_confirm), Fr(t_confirm) + d) if candidate else (Fr(t_confirm) + d, None)


def start_bssid(bss_type, station_id):
    """11.1.4: инфраструктура — BSSID = dot11StationID; PBSS — BSSID STA (неизменен после START).
    СПОРНО: для PBSS текст не говорит, чему равен BSSID; 11.1.3.7 («MAC address currently in use by the PCP»)
    подсказывает MAC PCP."""
    return station_id


# =====================================================================================================
# 11.1.4.5, 11.1.3.1, 11.1.3.7, 11.27.2.3 — синхронизация и потеря связи
# =====================================================================================================
class Join:
    """11.1.4.5: MLME-JOIN — принять BSSID; по приёму маяка этого BSS — принять TSF и beacon interval (11.1.3.3.1),
    JOIN.confirm(SUCCESS); JoinFailureTimeout (в интервалах маяка) истёк раньше — FAILURE.
    Используется только кадр с BSSID нашего AP/PCP (11.1.3.7); DMG Beacon с Discovery Mode = 1 BSS не задаёт.
    СПОРНО: в 11.1.4.5 — «Beacon frame»; для DMG берём DMG Beacon (Announce TSF тоже несёт, 11.1.2.1, но в
    процедуре JOIN не назван)."""
    def __init__(self, bssid, bi_tu, join_failure_timeout, t0=0):
        assert join_failure_timeout >= 1
        self.bssid, self.bi_tu = bssid, bi_tu
        self.deadline = Fr(t0) + join_failure_timeout * tu(bi_tu)
        self.result, self.tsf, self.adopted_bi = None, None, None

    def on_beacon(self, t, bssid, tsf, bi_tu, discovery_mode=0, kind='DMG Beacon'):
        if self.result is not None or kind != 'DMG Beacon' or bssid != self.bssid or discovery_mode == 1:
            return self.result
        if t > self.deadline:
            self.result = 'FAILURE'
            return self.result
        self.result, self.tsf, self.adopted_bi = 'SUCCESS', tsf, bi_tu
        return self.result

    def tick(self, t):
        if self.result is None and t > self.deadline:
            self.result = 'FAILURE'
        return self.result


class LinkMonitor:
    """11.1.3.1: инфраструктура — STA ожидает ≥ 1 DMG Beacon каждые dot11BeaconPeriod × dot11MaxLostBeacons TU;
    PBSS — DMG Beacon или Announce. Совпадает с обязанностью AP (11.1.2.1: «within a time interval that is not
    longer than dot11BeaconPeriod × dot11MaxLostBeacons TUs»).
    lost(t) — ожидание нарушено (t > последний + окно). Действие по потере стандарт для non-AP STA в
    инфраструктуре не задаёт (только 11.27.2.3 для члена PBSS при неявном handover: «should associate with the
    new PCP» после dot11MaxLostBeacons BI без DMG Beacon/Announce).
    max_lost по умолчанию — DEFVAL 4; после ассоциации — из DMG Operation (11.3.5.2 d) 7))."""
    def __init__(self, bssid, bi_tu, bss='infra', max_lost=DOT11_MAX_LOST_BEACONS, t0=0):
        assert 1 <= max_lost <= 32 and bss in ('infra', 'pbss')
        self.bssid, self.bi_tu, self.bss, self.max_lost = bssid, bi_tu, bss, max_lost
        self.last = Fr(t0)

    def window(self):
        return self.bi_tu * self.max_lost * TU

    def on_rx(self, t, kind, bssid, discovery_mode=0):
        if bssid != self.bssid or discovery_mode == 1:
            return False
        if kind == 'DMG Beacon' or (kind == 'Announce' and self.bss == 'pbss'):
            self.last = max(self.last, Fr(t))
            return True
        return False

    def deadline(self):
        return self.last + self.window()

    def lost(self, t):
        return Fr(t) > self.deadline()


def implicit_handover_trigger_bis(i, lost_beacons=DOT11_IMPLICIT_HANDOVER_LOST_BEACONS):
    """11.27.2.3: кандидат i начинает неявный handover после i × dot11ImplicitHandoverLostBeacons BI без DMG
    Beacon/Announce от PCP."""
    assert i >= 1
    return i * lost_beacons


def bhi_listen_until(t_ref, min_bhi=DOT11_MIN_BHI_DURATION):
    """11.1.3.7: активная DMG STA готова к приёму от AP/PCP не меньше dot11MinBHIDuration после TBTT или
    ожидаемого начала ATI (последний Next DMG ATI)."""
    return Fr(t_ref) + min_bhi


# =====================================================================================================
# Судья журнала эфира: ассоциация и классы кадров между AP и STA
# =====================================================================================================
LogEvent = namedtuple('LogEvent', 't kind ta ra info', defaults=(None,))


def check_assoc_log(events, ap, rsna=False, bss='infra', dmg=True):
    """Журнал: LogEvent(t, вид, TA, RA, info dict). info: 'status', 'aid', 'acked' (у ответа на (Re)Association),
    'alg' (Authentication), 'reason'. Проверяется (список Violation(idx, rule, msg)):
      class_tx       — 11.3.3: передача класса 2 в State 1 / класса 3 вне State 3/4 (по состоянию пары);
      ap_initiates   — 11.3.4.1 / 11.3.5.1: AP шлёт (Re)Association Request;
      open_system    — 12.3.3.1: Authentication с Open System между DMG STA;
      aid_range      — 9.4.1.8: AID в ответе SUCCESS вне 1…254; aid_dup — AID уже у другой ассоциированной STA;
      holdoff        — 11.3.5.2 g) / 11.3.5.7 e): Request к AP раньше 2 с после отказа не по конфигурации без
                       TIE / раньше TIE типа 3 / раньше 2 с после Disassociation от AP;
      port_blocked   — 11.3.1: Data (не EAPOL) в State 3 в инфраструктуре — порт 802.1X закрыт;
      missing_reply  — 11.3.5.1 (11.3.4.1): AP в инфраструктуре получил индивидуальный кадр класса 3 от STA в
                       State 2 (класса 2/3 от State 1) и до конца журнала не отправил Disassociation
                       (Deauthentication).
    Состояния ведутся по кадрам: успех (Re)Association + Ack → State 3/4 (3 при rsna), Disassociation → 2,
    Deauthentication → без изменения для DMG без аутентификации (11.3.4.5), иначе 1.
    Отказ (Re)Association у ассоциированной STA → State 2 (взгляд STA, 11.3.5.2 g)); СПОРНО: AP по 11.3.5.3 o)
    держит State 3 — судья берёт более строгий взгляд STA и для кадров AP."""
    viol = []
    peers, aid_of, holdoff, owed = {}, {}, {}, {}

    def peer(sta):
        if sta not in peers:
            peers[sta] = Peer(dmg, False)
        return peers[sta]

    for i, e in enumerate(events):
        info = e.info or {}
        if e.ta == ap:
            sta, from_ap = e.ra, True
        elif e.ra == ap:
            sta, from_ap = e.ta, False
        else:
            continue
        if is_group(sta):
            continue
        p = peer(sta)
        cls = frame_class(e.kind, bss, rsna)
        if e.kind == 'Authentication' and dmg and info.get('alg') == AUTH_OPEN_SYSTEM:
            viol.append(Violation(i, 'open_system', '12.3.3.1: DMG STA и Open System'))
        if from_ap and e.kind in ('Association Request', 'Reassociation Request'):
            viol.append(Violation(i, 'ap_initiates', '11.3.5.1: AP не инициирует ассоциацию'))
        if not from_ap and e.kind in ('Association Request', 'Reassociation Request'):
            if Fr(e.t) < holdoff.get(sta, Fr(-1)):
                viol.append(Violation(i, 'holdoff', f'Request в {e.t} раньше {holdoff[sta]} (11.3.5.2 g))'))
        if not class_allowed(p.state, cls):
            viol.append(Violation(i, 'class_tx', f'{e.kind} (класс {cls}) в State {p.state} (11.3.3)'))
            if not from_ap and bss == 'infra':
                owed[sta] = (i, 'Deauthentication' if p.state == S1 else 'Disassociation')
        elif not may_transmit(p.state, e.kind, bss, rsna):
            viol.append(Violation(i, 'port_blocked', f'{e.kind} в State 3: 802.1X Controlled Port закрыт (11.3.1)'))
        # переходы
        if from_ap and e.kind in ('Association Response', 'Reassociation Response'):
            st = info.get('status', SUCCESS)
            if st == SUCCESS:
                aid = info.get('aid')
                if aid is None or not AID_DMG_MIN <= aid <= AID_DMG_MAX:
                    viol.append(Violation(i, 'aid_range', f'AID {aid} вне 1…254 (9.4.1.8)'))
                elif any(a == aid and s != sta and peers[s].state in (S3, S4) for s, a in aid_of.items()):
                    viol.append(Violation(i, 'aid_dup', f'AID {aid} уже занят'))
                if info.get('acked', True):
                    p.assoc_ok(rsna)
                    aid_of[sta] = aid
            else:
                tie = info.get('tie')
                if tie and tie[0] == TIE_ASSOC_COMEBACK:
                    holdoff[sta] = Fr(e.t) + tu(tie[1])
                elif st not in CONFIG_STATUS:
                    holdoff[sta] = Fr(e.t) + RETRY_HOLDOFF
                if p.state in (S3, S4):
                    p.state = S2
        elif e.kind == 'Disassociation':
            if p.state in (S3, S4):
                p.disassoc()
                aid_of.pop(sta, None)
                if from_ap and info.get('reason') not in CONFIG_REASON:
                    holdoff[sta] = Fr(e.t) + RETRY_HOLDOFF
            if from_ap and owed.get(sta, (0, ''))[1] == 'Disassociation':
                owed.pop(sta)
        elif e.kind == 'Deauthentication':
            prev = p.state
            p.deauth(originator=False)
            if p.state != prev:
                aid_of.pop(sta, None)
            if from_ap and owed.get(sta, (0, ''))[1] == 'Deauthentication':
                owed.pop(sta)
    for sta, (i, kind) in owed.items():
        viol.append(Violation(i, 'missing_reply', f'нет {kind} в ответ на кадр не своего класса (11.3.5.1)'))
    return viol
