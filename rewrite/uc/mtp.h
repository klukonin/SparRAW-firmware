/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Запрос MTP (секвенсор передачи MAC): 0x1b001111 «запрос», слово 0x16 (что передать), слово 0x17 (параметры:
 * скорость, контекст ответа), затем 3×nop_s до чтения ответа r43 (MAC_MTP_RESP_VALID). Слова собираются только здесь —
 * прежде их собирали ~14 мест (ответ через SIFS, продолжение TXOP, очереди управления, маяк, групповые), и расхождение
 * копий не было видно. Макросы (а не функции): заголовок включается до include/arc.h (Makefile, -include). */
#ifndef UC_MTP_H
#define UC_MTP_H

#define MTP_REQ                0x1b001111u
#define MTP_W16(v)             (0x16000000u | (v))
#define MTP_W17(v)             (0x17000000u | (v))

/* 0x16 ответа через SIFS по виду (mtp_service_dispatch): 0 — Ack, 1 — BlockAck, 3 — 0x103 без 0x17, 5 — DMG CTS */
#define MTP_W16_RESP(kind)     MTP_W16(((kind) << 8) | 0x1f0022u)
/* 0x16 кадра очереди qid; mode: 1 — обычный, 3 / 0x103 — с контекстом ответа (0x17 [23:16]), 4 — RD, 0x10 — итог */
#define MTP_W16_Q(qid, mode)   MTP_W16(((qid) << 16) | (mode))

/* 0x17 [12:8] MCS | 3 — скорость задаёт uc; 0 — выбирает MAC */
#define MTP_RATE(mcs)          (((mcs) << 8) | 3u)
/* 0x17 [23:16] — контекст ответа (qid принятого / resp_ctx8) */
#define MTP_CTX(c)             ((c) << 16)
/* скорость поиска скорости станции s (MCS пробы), если поиск у неё идёт, иначе other */
#define MTP_RS_RATE_OR(s, other) \
    (((txrx_state1 & 2u) && rs_state[s].active != 0) ? MTP_RATE((u32)rs_sta_mcs_try(s)) : (other))

/* запрос: три слова + 3×nop_s (vendor-группа до чтения r43). _NL — без журнала команд (путь в сроке SIFS) */
#define MTP_REQUEST(w16, w17) \
    do { uc_mac_cmd(MTP_REQ); uc_mac_cmd(w16); uc_mac_cmd(w17); arc_nops(3); } while (0)
#define MTP_REQUEST_NL(w16, w17) \
    do { uc_mac_cmd_nl(MTP_REQ); uc_mac_cmd_nl(w16); uc_mac_cmd_nl(w17); arc_nops(3); } while (0)

#endif
