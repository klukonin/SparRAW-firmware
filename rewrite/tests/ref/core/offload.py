# SPDX-License-Identifier: AGPL-3.0-or-later
"""Точки разгрузки (rewrite/docs/ARCHITECTURE.md, раздел 2): функции стандарта, которые адаптер железа берёт на себя.
Ядро получает набор флагов от адаптера (AdapterCaps); в идеальной среде набор пуст — всё делает ядро, и поведение
этапа 1 не меняется ни в чём.

Для каждой точки — что ядро делает само и что получает от адаптера, когда точка разгружена (этап 3):

  SIFS_RESPONSE   немедленный ответ через SIFS (Ack, BlockAck, DMG CTS; 10.3.2.3.3, 10.3.2.9, 10.3.2.11, 10.25.6.5).
                  Ядро ответ не передаёт; решение «отвечать ли» (в т. ч. DMG CTS при свободном NAV, 10.3.2.9), сам
                  кадр и момент — у адаптера. Ядро получает offload_response_pending() (ответ назначен — со своей
                  стороны среду не занимать), offload_tx_start()/offload_tx_end() (ответ в эфире — полудуплекс,
                  отсчёт EDCA от его конца). Ответный CF-End (9.3.1.6) и BRP-ответ (10.42.3.2) — по-прежнему ядро.
  BA_SCOREBOARD   scoreboard получателя Block Ack (10.25.6.3) — BlockAck строит адаптер; ядро ведёт только буфер
                  переупорядочения и выдачу MSDU (10.25.6.6). Только вместе с SIFS_RESPONSE: BlockAck — ответ через
                  SIFS, у адаптера нет scoreboard ядра.
  DURATION        Duration RTS и кадров очереди (QoS Data, кадры управления с Ack; 9.2.5) — ядро передаёт кадр со
                  своим значением, адаптер ставит своё и до PHY-TXEND.confirm сообщает его offload_duration(value):
                  ядро берёт его для TXNAV (10.23.2.2) и конца NAV держателя TXOP (Duration следующих кадров, запас
                  под CF-End, 10.23.2.10).
  EDCA_BACKOFF    backoff и доступ EDCA (10.23.2.2–10.23.2.4) для работ очереди (кадры управления с Ack и TXOP
                  данных — то, что у железа идёт через очереди MAC): ядро просит доступ offload_access_request(),
                  адаптер отвечает offload_access_granted() в момент, когда его арбитр выиграл доступ; ядро начинает
                  обмен, если он укладывается в CBAP и лимит TXOP (10.39.5, 10.23.2.9). Работы вне очереди (SLS, BRP
                  setup — у железа их передаёт микрокод сам) — доступ EDCA ядра, как в идеальной среде.
  NAV             NAV (10.3.2.4, 10.23.2.10) ведёт адаптер; ядро спрашивает его через OffloadNav (тот же интерфейс,
                  что cbap.Nav: busy, idle_from, idle_for_rts; обновления по кадрам ядро не делает).
  BEACON_TIMESTAMP вставка Timestamp в DMG Beacon (11.1.3.1) — адаптер переписывает поле Timestamp маяка ядра.
  SSW_SWEEP       развёртка SSW и сетка слотов A-BFT (10.42.2.2.2, 10.42.5.2) — не реализована (этап 4).

Интерфейс (кроме PHY-SAP, sap_phy.py):
  адаптер → ядро (OffloadUser, методы DmgMac): offload_response_pending, offload_tx_start, offload_tx_end,
      offload_duration, offload_access_granted;
  ядро → адаптер (OffloadSap, методы объекта PHY адаптера): offload_access_request, offload_nav_busy,
      offload_nav_idle_from, offload_nav_idle_for_rts."""
import enum
from dataclasses import dataclass
from typing import Protocol


class Offload(enum.Flag):
    NONE = 0
    SIFS_RESPONSE = enum.auto()
    DURATION = enum.auto()
    EDCA_BACKOFF = enum.auto()
    NAV = enum.auto()
    BA_SCOREBOARD = enum.auto()
    BEACON_TIMESTAMP = enum.auto()
    SSW_SWEEP = enum.auto()


IDEAL = Offload.NONE
# Реализовано в ядре (этап 3); SSW_SWEEP — этап 4
IMPLEMENTED = (Offload.SIFS_RESPONSE | Offload.DURATION | Offload.EDCA_BACKOFF | Offload.NAV | Offload.BA_SCOREBOARD |
               Offload.BEACON_TIMESTAMP)
# Набор Sparrow (MAC-STAND, допущения H-* модели MAC эмулятора) — адаптер tests/unit/adapter_sparrow.py
SPARROW = IMPLEMENTED

# Таблица ARCHITECTURE.md: точка → (идеальная среда, Sparrow — факт стенда/допущение). Для отчётов сравнения.
TABLE = {
    Offload.SIFS_RESPONSE: ('ядро', 'MAC (ответ через ~4,5 мкс, MAC-STAND)'),
    Offload.DURATION: ('ядро', 'MAC (остаток лимита TXOP, H-DURQ)'),
    Offload.EDCA_BACKOFF: ('ядро', 'MAC (CWmin, AIFS, слот)'),
    Offload.NAV: ('ядро', 'MAC'),
    Offload.BA_SCOREBOARD: ('ядро', 'MAC (BAP)'),
    Offload.BEACON_TIMESTAMP: ('ядро', 'MAC (движок маяка)'),
    Offload.SSW_SWEEP: ('ядро', 'uc + MAC (GP-таймеры)'),
}


@dataclass(frozen=True)
class AdapterCaps:
    """Что адаптер сообщает ядру при подключении: набор разгруженных точек и имя."""
    name: str = 'ideal'
    offload: Offload = IDEAL


def require_supported(caps):
    """Набор разгрузки, который ядро умеет исполнять; иначе NotImplementedError с причиной."""
    extra = caps.offload & ~IMPLEMENTED
    if extra:
        raise NotImplementedError(f'разгрузка {extra} не реализована в ядре (этап 4)')
    resp, sb = bool(caps.offload & Offload.SIFS_RESPONSE), bool(caps.offload & Offload.BA_SCOREBOARD)
    if resp != sb:
        raise NotImplementedError('SIFS_RESPONSE и BA_SCOREBOARD разгружаются только вместе: BlockAck — ответ через '
                                  'SIFS, scoreboard для него — у того, кто отвечает')
    return caps


class OffloadSap(Protocol):
    """Сторона адаптера, вызываемая ядром (только для разгруженных точек)."""
    def offload_access_request(self) -> None: ...
    def offload_nav_busy(self, t) -> bool: ...
    def offload_nav_idle_from(self): ...
    def offload_nav_idle_for_rts(self, t, ta) -> bool: ...


class OffloadUser(Protocol):
    """Сторона ядра, вызываемая адаптером."""
    def offload_response_pending(self) -> None: ...
    def offload_tx_start(self, kind: str) -> None: ...
    def offload_tx_end(self) -> None: ...
    def offload_duration(self, value: int) -> None: ...
    def offload_access_granted(self) -> None: ...


class OffloadNav:
    """NAV, который ведёт адаптер (точка NAV разгружена): интерфейс cbap.Nav для кода ядра, обновления — у адаптера."""
    def __init__(self, phy):
        self.phy = phy

    def idle_from(self):
        return self.phy.offload_nav_idle_from()

    def busy(self, t):
        return self.phy.offload_nav_busy(t)

    def idle_for_rts(self, t, ta):
        return self.phy.offload_nav_idle_for_rts(t, ta)

    def rx_start(self, t):
        pass

    def rx(self, t_end, f):
        pass

    def shift(self, e, s2):
        pass
