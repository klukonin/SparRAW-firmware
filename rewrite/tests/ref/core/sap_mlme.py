# SPDX-License-Identifier: AGPL-3.0-or-later
"""MLME-SAP (802.11-2020 6.3; DMG BF — 6.3.91) в объёме этапа 1. Каждый примитив — dataclass с атрибутом NAME
(имя по стандарту) и полями с именами параметров стандарта; параметры, которых этап 1 не использует, опущены
(их список — в пункте). Направление: request/response — SME → MLME (MlmeSap.request/.response), confirm/indication
— MLME → SME (MlmeSapUser.confirm/.indication).

  MLME-START.request/.confirm             6.3.11.2/6.3.11.3   — точка: запуск BSS (DMG Beacon по BeaconPeriod)
  MLME-SCAN.request/.confirm              6.3.3.2/6.3.3.3     — пассивный (DMG Beacon) и активный (Probe) поиск
  MLME-JOIN.request/.confirm              6.3.4.2/6.3.4.3     — принять TSF и BeaconPeriod BSS (11.1.4.5)
  MLME-ASSOCIATE.request/.confirm/
                .indication/.response     6.3.7.2–6.3.7.5     — ассоциация DMG (State 2 → 4, без 802.11 Auth, 11.3.1)
  MLME-ADDBA.request/.confirm/
            .indication/.response         6.3.27.2–6.3.27.5   — соглашение Block Ack (HT-immediate, 10.25.2)
  MLME-BF-TRAINING.request/.confirm/
                  .indication             6.3.91.2–6.3.91.4   — SLS (RequestBRP = false) в DTI; indication — BF,
                                                                начатое пиром (A-BFT по ISS маяков точки)
ResultCode — строки перечислений стандарта (SUCCESS, TIMEOUT, BF_TIMEOUT, …)."""
from dataclasses import dataclass, field
from typing import Optional, Protocol, Tuple

SUCCESS, TIMEOUT, REFUSED, INVALID_PARAMETERS = 'SUCCESS', 'TIMEOUT', 'REFUSED', 'INVALID_PARAMETERS'
BF_TIMEOUT = 'BF_TIMEOUT'                                       # 6.3.91.3.2
INFRASTRUCTURE = 'INFRASTRUCTURE'                               # BSSType (6.3.3.2.2, 6.3.11.2.2)
PASSIVE, ACTIVE = 'PASSIVE', 'ACTIVE'                           # ScanType (6.3.3.2.2)
IMMEDIATE = 'Immediate'                                         # BlockAckPolicy (6.3.27.2.2)


@dataclass
class BSSDescription:
    """Элемент BSSDescriptionSet (6.3.3.3.2) — нужное для DMG: BSSID, SSID, BSSType, BeaconPeriod, Timestamp,
    Local Time, DMG Capabilities; плюс итог ISS маяков BTI (лучший сектор точки и SNR) — 6.3.3.3.2 «DMG Capabilities»
    не несёт его, SME передаёт описание в MLME-JOIN как SelectedBSS."""
    BSSID: str
    SSID: bytes
    BSSType: str = INFRASTRUCTURE
    BeaconPeriod: int = 100
    Timestamp: int = 0
    LocalTime: int = 0
    DMGCapabilities: Optional[object] = None
    best_sector: Tuple[int, int, float] = (0, 0, 0.0)             # (Sector ID, DMG Antenna ID, SNR дБ) — модель


class _Prim:
    NAME = ''
    CLAUSE = ''


# -------------------------------------------------------------------------------- 6.3.11 START
@dataclass
class MlmeStartRequest(_Prim):
    """6.3.11.2: SSID, BSSType, BeaconPeriod, …, EDCAParameterSet, DMG Capabilities, DMG Operation, … (остальные
    параметры этапу 1 не нужны). DMG-специфика BI (A-BFT, CBAP Only) — параметры модели (abft_slots, fss_frames,
    sectors): стандарт выводит их из MIB (dot11…), а не из примитива."""
    NAME, CLAUSE = 'MLME-START.request', '6.3.11.2'
    SSID: bytes
    BSSType: str = INFRASTRUCTURE
    BeaconPeriod: int = 100
    EDCAParameterSet: Optional[dict] = None
    abft_slots: int = 8
    fss_frames: int = 8


@dataclass
class MlmeStartConfirm(_Prim):
    NAME, CLAUSE = 'MLME-START.confirm', '6.3.11.3'
    ResultCode: str = SUCCESS


# -------------------------------------------------------------------------------- 6.3.3 SCAN
@dataclass
class MlmeScanRequest(_Prim):
    """6.3.3.2: BSSType, BSSID, SSID, ScanType, ProbeDelay, ChannelList, MinChannelTime, MaxChannelTime (TU)."""
    NAME, CLAUSE = 'MLME-SCAN.request', '6.3.3.2'
    BSSType: str = INFRASTRUCTURE
    BSSID: str = 'ff:ff:ff:ff:ff:ff'
    SSID: bytes = b''
    ScanType: str = PASSIVE
    ProbeDelay: int = 0
    ChannelList: Tuple[int, ...] = (2,)
    MinChannelTime: int = 100
    MaxChannelTime: int = 300


@dataclass
class MlmeScanConfirm(_Prim):
    NAME, CLAUSE = 'MLME-SCAN.confirm', '6.3.3.3'
    BSSDescriptionSet: list = field(default_factory=list)
    ResultCode: str = SUCCESS


# -------------------------------------------------------------------------------- 6.3.4 JOIN
@dataclass
class MlmeJoinRequest(_Prim):
    """6.3.4.2: SelectedBSS, JoinFailureTimeout (интервалы маяка), DMG Capabilities."""
    NAME, CLAUSE = 'MLME-JOIN.request', '6.3.4.2'
    SelectedBSS: BSSDescription = None
    JoinFailureTimeout: int = 4


@dataclass
class MlmeJoinConfirm(_Prim):
    NAME, CLAUSE = 'MLME-JOIN.confirm', '6.3.4.3'
    ResultCode: str = SUCCESS


# -------------------------------------------------------------------------------- 6.3.7 ASSOCIATE
@dataclass
class MlmeAssociateRequest(_Prim):
    NAME, CLAUSE = 'MLME-ASSOCIATE.request', '6.3.7.2'
    PeerSTAAddress: str = ''
    ListenInterval: int = 0


@dataclass
class MlmeAssociateConfirm(_Prim):
    NAME, CLAUSE = 'MLME-ASSOCIATE.confirm', '6.3.7.3'
    ResultCode: str = SUCCESS
    AssociationID: int = 0
    EDCAParameterSet: Optional[dict] = None
    PeerSTAAddress: str = ''


@dataclass
class MlmeAssociateIndication(_Prim):
    NAME, CLAUSE = 'MLME-ASSOCIATE.indication', '6.3.7.4'
    PeerSTAAddress: str = ''
    SSID: bytes = b''
    DMGCapabilities: Optional[object] = None


@dataclass
class MlmeAssociateResponse(_Prim):
    NAME, CLAUSE = 'MLME-ASSOCIATE.response', '6.3.7.5'
    PeerSTAAddress: str = ''
    ResultCode: str = SUCCESS
    AssociationID: Optional[int] = None


# -------------------------------------------------------------------------------- 6.3.27 ADDBA
@dataclass
class MlmeAddbaRequest(_Prim):
    """6.3.27.2: PeerSTAAddress, DialogToken, TID, BlockAckPolicy, BufferSize, BlockAckTimeout,
    BlockAckStartingSequenceControl."""
    NAME, CLAUSE = 'MLME-ADDBA.request', '6.3.27.2'
    PeerSTAAddress: str = ''
    DialogToken: int = 1
    TID: int = 0
    BlockAckPolicy: str = IMMEDIATE
    BufferSize: int = 64
    BlockAckTimeout: int = 0
    BlockAckStartingSequenceControl: Optional[int] = None      # None — MAC берёт следующий SN TID


@dataclass
class MlmeAddbaConfirm(_Prim):
    NAME, CLAUSE = 'MLME-ADDBA.confirm', '6.3.27.3'
    PeerSTAAddress: str = ''
    DialogToken: int = 0
    TID: int = 0
    ResultCode: str = SUCCESS
    BlockAckPolicy: str = IMMEDIATE
    BufferSize: int = 0
    BlockAckTimeout: int = 0


@dataclass
class MlmeAddbaIndication(_Prim):
    NAME, CLAUSE = 'MLME-ADDBA.indication', '6.3.27.4'
    PeerSTAAddress: str = ''
    DialogToken: int = 0
    TID: int = 0
    BlockAckPolicy: str = IMMEDIATE
    BufferSize: int = 0
    BlockAckTimeout: int = 0


@dataclass
class MlmeAddbaResponse(_Prim):
    NAME, CLAUSE = 'MLME-ADDBA.response', '6.3.27.5'
    PeerSTAAddress: str = ''
    DialogToken: int = 0
    TID: int = 0
    ResultCode: str = SUCCESS
    BlockAckPolicy: str = IMMEDIATE
    BufferSize: int = 64
    BlockAckTimeout: int = 0


# -------------------------------------------------------------------------------- 6.3.91 BF-TRAINING
@dataclass
class MlmeBfTrainingRequest(_Prim):
    NAME, CLAUSE = 'MLME-BF-TRAINING.request', '6.3.91.2'
    PeerSTAAddress: str = ''
    RequestBRP: bool = False


@dataclass
class MlmeBfTrainingConfirm(_Prim):
    NAME, CLAUSE = 'MLME-BF-TRAINING.confirm', '6.3.91.3'
    PeerSTAAddress: str = ''
    ResultCode: str = SUCCESS


@dataclass
class MlmeBfTrainingIndication(_Prim):
    NAME, CLAUSE = 'MLME-BF-TRAINING.indication', '6.3.91.4'
    PeerSTAAddress: str = ''
    ResultCode: str = SUCCESS


PRIMITIVES = {c.NAME: c for c in (
    MlmeStartRequest, MlmeStartConfirm, MlmeScanRequest, MlmeScanConfirm, MlmeJoinRequest, MlmeJoinConfirm,
    MlmeAssociateRequest, MlmeAssociateConfirm, MlmeAssociateIndication, MlmeAssociateResponse, MlmeAddbaRequest,
    MlmeAddbaConfirm, MlmeAddbaIndication, MlmeAddbaResponse, MlmeBfTrainingRequest, MlmeBfTrainingConfirm,
    MlmeBfTrainingIndication)}


class MlmeSap(Protocol):
    """Сторона MLME: SME вызывает request (…request) и response (…response)."""
    def mlme_request(self, prim) -> None: ...
    def mlme_response(self, prim) -> None: ...


class MlmeSapUser(Protocol):
    """Сторона SME: MLME вызывает confirm (…confirm) и indication (…indication)."""
    def mlme_confirm(self, prim) -> None: ...
    def mlme_indication(self, prim) -> None: ...
