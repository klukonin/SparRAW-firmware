# SPDX-License-Identifier: AGPL-3.0-or-later
"""Точки разгрузки (rewrite/docs/ARCHITECTURE.md, раздел 2): функции стандарта, которые адаптер железа может взять на
себя. Ядро получает набор флагов от адаптера; в идеальной среде набор пуст — всё делает ядро.

Для каждой точки — что ядро делает само и что получит от адаптера, когда точка разгружена (этап 3):

  SIFS_RESPONSE   немедленный ответ через SIFS (Ack, BlockAck, DMG CTS; 10.3.2.3.3, 10.3.2.9, 10.3.2.11, 10.25.6.5)
                  — ядро не передаёт ответ, а получает событие «ответ передан» (вид, RA, Duration, MCS) для журнала
                  и учёта NAV/TXOP.
  DURATION        Duration RTS и кадров очереди (9.2.5) — ядро передаёт кадр с Duration-заглушкой, адаптер сообщает
                  поставленное значение.
  EDCA_BACKOFF    backoff и доступ EDCA (10.23.2.2–10.23.2.4) — ядро ставит обмен в очередь адаптера, получает «TXOP
                  получен» (момент) и итог.
  NAV             NAV (10.3.2.4, 10.23.2.10) — ядро не ведёт NAV, спрашивает адаптер «среда свободна» (DMG CTS).
  BA_SCOREBOARD   scoreboard получателя Block Ack (10.25.6.3) — BlockAck строит адаптер; ядро ведёт только буфер
                  переупорядочения по принятым MPDU.
  BEACON_TIMESTAMP вставка Timestamp в DMG Beacon (11.1.3.1) — ядро передаёт маяк без Timestamp, адаптер ставит.
  SSW_SWEEP       развёртка SSW и сетка слотов A-BFT (10.42.2.2.2, 10.42.5.2) — ядро задаёт план (сектора, CDOWN,
                  слот), адаптер передаёт кадры в моменты сетки.

Этап 1: ядро принимает только пустой набор (IDEAL); иной набор — NotImplementedError с указанием этапа."""
import enum
from dataclasses import dataclass


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
    if caps.offload != IDEAL:
        raise NotImplementedError(f'разгрузка {caps.offload} — этап 3 (адаптер Sparrow); этап 1 — только IDEAL')
    return caps
