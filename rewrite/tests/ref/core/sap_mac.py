# SPDX-License-Identifier: AGPL-3.0-or-later
"""MAC-SAP (802.11-2020 5.2): MA-UNITDATA.request (5.2.3), MA-UNITDATA.indication (5.2.4),
MA-UNITDATA-STATUS.indication (5.2.5). Имена параметров — как в стандарте (пробелы → «_»).

Ядро реализует: data — MSDU (октеты), priority — UP 0…7 (5.2.3.2: «contention-based … 0 to 7»; TID = UP, AC — по
табл. 10-1), service class — QoSAck (QoSNoAck не используется: под соглашением Block Ack No Ack запрещена, табл.
9-13); routing information, drop eligible, station vector, MSDU format — передаются как есть, MAC их не использует
(5.2.3.2: в DMG BSS не применяются)."""
from dataclasses import dataclass
from typing import Optional, Protocol

# 5.2.3.2 / 5.2.4.2 / 5.2.5.2
QOS_ACK, QOS_NO_ACK = 'QoSAck', 'QoSNoAck'
SUCCESS = 'Success'                               # 5.2.4.2 reception status
SUCCESSFUL = 'Successful'                         # 5.2.5.2 a) transmission status
NO_BSS = 'Undeliverable (no BSS available)'       # 5.2.5.2 h)
# СПОРНО: 5.2.5.2 не перечисляет «повторы исчерпаны» (MSDU отброшен по пределу повторов, 10.23.2.12); ближайшее —
# общий вид «Undeliverable» без уточнения.
UNDELIVERABLE = 'Undeliverable'


@dataclass(frozen=True)
class MaUnitdataRequest:
    """MA-UNITDATA.request (5.2.3)."""
    source_address: str
    destination_address: str
    data: bytes
    priority: int = 0
    routing_information: Optional[object] = None
    drop_eligible: int = 0
    service_class: str = QOS_ACK
    station_vector: Optional[object] = None
    MSDU_format: Optional[object] = None


@dataclass(frozen=True)
class MaUnitdataIndication:
    """MA-UNITDATA.indication (5.2.4)."""
    source_address: str
    destination_address: str
    data: bytes
    reception_status: str = SUCCESS
    priority: int = 0
    routing_information: Optional[object] = None
    drop_eligible: int = 0
    service_class: str = QOS_ACK
    station_vector: Optional[object] = None
    MSDU_format: Optional[object] = None


@dataclass(frozen=True)
class MaUnitdataStatusIndication:
    """MA-UNITDATA-STATUS.indication (5.2.5)."""
    source_address: str
    destination_address: str
    transmission_status: str
    provided_priority: int = 0
    provided_service_class: str = QOS_ACK


class MacSap(Protocol):
    def ma_unitdata_request(self, req: MaUnitdataRequest) -> None: ...


class MacSapUser(Protocol):
    def ma_unitdata_indication(self, ind: MaUnitdataIndication) -> None: ...
    def ma_unitdata_status_indication(self, ind: MaUnitdataStatusIndication) -> None: ...
