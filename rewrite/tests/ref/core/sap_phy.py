# SPDX-License-Identifier: AGPL-3.0-or-later
"""PHY-SAP (802.11-2020 8.3.5) и векторы DMG PHY (20.2.2 табл. 20-1, 20.2.3, 20.2.4).

Примитивы (имена — как в 8.3.5; в Python точка и дефис заменены: PHY-TXSTART.request → phy_txstart_request):

  MAC → PHY (PhySap)                                   PHY → MAC (PhySapUser)
  PHY-TXSTART.request(TXVECTOR)        8.3.5.5         PHY-TXSTART.confirm(TXSTATUS)    8.3.5.6
  PHY-DATA.request(DATA)               8.3.5.2         PHY-DATA.confirm                 8.3.5.4
  PHY-TXEND.request                    8.3.5.7         PHY-TXEND.confirm                8.3.5.8
  PHY-CCARESET.request(IPI-STATE)      8.3.5.10        PHY-CCA.indication(STATE, …)     8.3.5.12
  PHY-CONFIG.request(PHYCONFIG_VECTOR) 8.3.5.15        PHY-RXSTART.indication(RXVECTOR) 8.3.5.13
                                                       PHY-DATA.indication(DATA)        8.3.5.3
                                                       PHY-RXEND.indication(RXERROR)    8.3.5.14

Упрощения модели (не меняют времени на эфире):
  - PHY-DATA.request/.indication передают PSDU целиком одним вызовом (в стандарте — по октету); PHY-DATA.confirm —
    один на PSDU;
  - PHY-TXSTART.request — начало первого символа преамбулы на антенне (aTxPHYDelay = 0), PHY-TXEND.confirm — конец
    последнего символа (TXTIME, 20.11.3); PHY-RXSTART.indication — через aRxPHYStartDelay (табл. 20-30) от начала
    преамбулы на антенне приёмника, PHY-RXEND.indication — в конец PPDU у приёмника (aRxPHYDelay = 0);
  - направленность — абстракция «луч» (Beam: DMG-антенна и сектор; сектор None — квази-омни). Луч передачи —
    ANT_CONFIG TXVECTOR (табл. 20-1: «Values are implementation dependent»); луч приёма — расширение модели
    PHYCONFIG_VECTOR.RX_ANT_CONFIG (20.2.3 задаёт только OPERATING_CHANNEL; как DMG-приёмник выбирает диаграмму,
    стандарт оставляет реализации). Ядро не знает, какие антенны у железа: только номера секторов и качество из
    RXVECTOR (SNR, RCPI)."""
from dataclasses import dataclass
from typing import Optional, Protocol

from ..timing import aRxPHYStartDelay, T_CE, T_CE_CM, T_HEADER, T_STF, T_STF_CM, Tc, txtime

# PHY-CCA.indication STATE (8.3.5.12.2)
BUSY, IDLE = 'BUSY', 'IDLE'
# PHY-RXEND.indication RXERROR (8.3.5.14.2)
NO_ERROR, FORMAT_VIOLATION, CARRIER_LOST, UNSUPPORTED_RATE, FILTERED = (
    'NoError', 'FormatViolation', 'CarrierLost', 'UnsupportedRate', 'Filtered')
# TXVECTOR/RXVECTOR AGGREGATION (табл. 20-1)
AGGREGATED, NOT_AGGREGATED = 'AGGREGATED', 'NOT_AGGREGATED'
NO_ADD_PPDU = 'NO-ADD-PPDU'
BT_NOT_REQUESTED = 'BEAM-TRACKING-NOT-REQUESTED'


@dataclass(frozen=True)
class Beam:
    """Диаграмма антенны: antenna — DMG Antenna ID (9.5.1), sector — Sector ID; sector=None — квази-омни (3.2:
    «quasi-omni antenna pattern»)."""
    sector: Optional[int] = None
    antenna: int = 0

    @property
    def quasi_omni(self):
        return self.sector is None

    def __repr__(self):
        return 'QO' if self.sector is None else f'S{self.sector}/A{self.antenna}'


QUASI_OMNI = Beam(None, 0)


@dataclass(frozen=True)
class TxVector:
    """TXVECTOR DMG (табл. 20-1, столбец TXVECTOR = Y)."""
    MCS: int
    LENGTH: int
    ADD_PPDU: str = NO_ADD_PPDU
    PPDU_TYPE: Optional[str] = None
    TRN_LEN: int = 0
    AGGREGATION: str = NOT_AGGREGATED
    ANT_CONFIG: Beam = QUASI_OMNI
    BEAM_TRACKING_REQUEST: str = BT_NOT_REQUESTED
    LAST_RSSI: int = 0
    TURNAROUND: int = 0


@dataclass(frozen=True)
class RxVector:
    """RXVECTOR DMG (табл. 20-1, столбец RXVECTOR = Y). SNR — дБ (−13…50,75 шагом 0,25), RCPI/RSSI — как в 20.3.10
    (здесь — уровень приёма, дБм, модель среды)."""
    MCS: int
    LENGTH: int
    ADD_PPDU: str = NO_ADD_PPDU
    PPDU_TYPE: Optional[str] = None
    TRN_LEN: int = 0
    AGGREGATION: str = NOT_AGGREGATED
    RSSI: Optional[float] = None
    SNR: Optional[float] = None
    RCPI: Optional[float] = None
    BEAM_TRACKING_REQUEST: str = BT_NOT_REQUESTED
    LAST_RSSI: int = 0
    TURNAROUND: int = 0


@dataclass(frozen=True)
class TxStatus:
    """TXSTATUS (20.2.4, табл. 20-2) — без TIME_OF_DEPARTURE (не запрашивается)."""
    TX_START_OF_FRAME_OFFSET: int = 0


@dataclass(frozen=True)
class PhyConfigVector:
    """PHYCONFIG_VECTOR (20.2.3): OPERATING_CHANNEL (1, 3, …, 15; канал = ½·(OPERATING_CHANNEL + 1)).
    RX_ANT_CONFIG — расширение модели: диаграмма приёма (см. докстроку модуля)."""
    OPERATING_CHANNEL: int = 3
    RX_ANT_CONFIG: Beam = QUASI_OMNI


class PhySap(Protocol):
    """Сторона PHY: вызывается MAC."""
    def phy_txstart_request(self, txvector: TxVector) -> None: ...
    def phy_data_request(self, data: bytes) -> None: ...
    def phy_txend_request(self) -> None: ...
    def phy_ccareset_request(self, ipi_state=None) -> None: ...
    def phy_config_request(self, vector: PhyConfigVector) -> None: ...


class PhySapUser(Protocol):
    """Сторона MAC: вызывается PHY."""
    def phy_txstart_confirm(self, txstatus: TxStatus) -> None: ...
    def phy_data_confirm(self) -> None: ...
    def phy_txend_confirm(self) -> None: ...
    def phy_cca_indication(self, state: str, channel_list=None) -> None: ...
    def phy_rxstart_indication(self, rxvector: RxVector) -> None: ...
    def phy_data_indication(self, data: bytes) -> None: ...
    def phy_rxend_indication(self, rxerror: str) -> None: ...


# ---------------------------------------------------------------------------------------- времена PPDU
def ppdu_time(txv):
    """TXTIME PPDU (20.11.3) по TXVECTOR; TRN-поля здесь не используются (этап 1 — без BRP с TRN)."""
    assert txv.TRN_LEN == 0
    return txtime(txv.LENGTH, txv.MCS)


def rx_start_delay(mcs):
    """Момент PHY-RXSTART.indication от начала PPDU у приёмника (модель). 8.3.5.13.3: после проверки заголовка PHY;
    aRxPHYStartDelay (табл. 20-30: control 10 мкс, SC 3,6 мкс) — верхняя граница, на которую рассчитаны
    AckTimeout/CTSTimeout (10.3.2.11). SC: конец заголовка T_STF + T_CE + T_HEADER (2,47 мкс; Ack на MCS 1 длится
    3,09 мкс — RXSTART через 3,6 мкс пришёл бы после конца PPDU); control: aRxPHYStartDelay (заголовок control
    mode кодирован вместе с данными первого кодового слова LDPC, 20.4.3.3; самый короткий PPDU control — Ack, 13,2 мкс)."""
    return aRxPHYStartDelay['control'] if mcs == 0 else T_STF + T_CE + T_HEADER


def response_wait(mcs):
    """aRxPHYStartDelay ожидаемого ответа (табл. 20-30) — слагаемое AckTimeout/CTSTimeout (10.3.2.11, 10.3.2.9)."""
    return aRxPHYStartDelay['control' if mcs == 0 else 'sc']


def data_symbol_offset(mcs):
    """Начало символа данных с первым битом кадра от начала PPDU — точка Timestamp (11.1.3.1).
    СПОРНО → принято (как air_pcap.PRE — одно прочтение для ядра и судьи): control mode — заголовок 5 октетов идёт
    перед кадром в первом кодовом слове, каждый бит — 32 чипа Ga32 (20.4.3.3): T_STF-CM + T_CE-CM + 40·32·Tc;
    SC — после STF, CE и заголовка (T_STF + T_CE + T_HEADER, 20.11.3)."""
    return T_STF_CM + T_CE_CM + 40 * 32 * Tc if mcs == 0 else T_STF + T_CE + T_HEADER


__all__ = ['Beam', 'QUASI_OMNI', 'TxVector', 'RxVector', 'TxStatus', 'PhyConfigVector', 'PhySap', 'PhySapUser',
           'BUSY', 'IDLE', 'NO_ERROR', 'FORMAT_VIOLATION', 'CARRIER_LOST', 'UNSUPPORTED_RATE', 'FILTERED',
           'AGGREGATED', 'NOT_AGGREGATED', 'ppdu_time', 'rx_start_delay', 'response_wait', 'data_symbol_offset']
