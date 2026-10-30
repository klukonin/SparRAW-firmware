# SPDX-License-Identifier: AGPL-3.0-or-later
"""AP: передача Assoc Response не удалась (mlme_assoc_tx_done_cb, status ≠ 0) — событие ASSOC_REJECT (5) автомату
mlme с кодом TX-статуса в a0. Действие mlme_sm_on_assoc_reject берёт пакет из a0 только у станции (там отправитель
передаёт принятый Assoc Response); у AP a0 — не указатель: код причины разрыва (mlme_notify, protocol) — 1, а не
слова, прочитанные по адресу a0 + 0xc."""
import fwflows as F

MLME_EV_ASSOC_REJECT = 5
MLME_ASSOCIATE = 1                       # include/conn.h: идёт обмен Assoc (AP ждёт завершения TX ответа)


def test_ap_assoc_reject_status_is_not_packet(fw):
    f = F.Fw(fw)
    f.ap_start()
    conn = f.ap_sta_join()
    got = []
    for status in (1, 3, 0x14):
        fw.w8(conn + F.C_MLME, MLME_ASSOCIATE)
        fw.call('basic_sm_handle_event', conn + F.C_MLME, MLME_EV_ASSOC_REJECT, status, 0, 0,
                stub={'mlme_notify': lambda fw, a: got.append(a[2]) or 0})
    assert got == [1, 1, 1], got
