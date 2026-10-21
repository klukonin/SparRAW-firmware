// SPDX-License-Identifier: AGPL-3.0-or-later
/* Юнит-тесты WMI 0x900: обработчики модулей и ответ (событие 0x1900). */
#ifndef UT_H
#define UT_H
#include "types.h"

struct wmi_mbox;

#define UT_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

/* Тело команды WMI_UNIT_TEST_CMDID (0x900) так, как его читают модули 9..12 vendor 6.2:
 * заголовок как у драйверного struct wmi_ut_cmd (include/wmi.h), но параметров больше
 * place_holder[6] — подкоманды читают до +0x28, запись регистров RFC (UT 10/12) копирует
 * 0x5c Б с +8, запись блока XPM (UT 9/0x98e) берёт данные с +0x1c. Параметр k — слово
 * arg[k] (+4 + 4k); vendor часто читает только младший байт/полуслово слова (ldb/ldh
 * [payload + 4 + 4k]) — arg8[4k] / arg16[2k]; со знаком — arg_s8 / arg_s16. */
struct ut_cmd {
    u16 module_id;                             /* 0x00 */
    u16 subtype_id;                            /* 0x02 */
    union {                                    /* 0x04 */
        u32 arg[0x18];
        u16 arg16[0x30];
        s16 arg_s16[0x30];
        u8  arg8[0x60];
        s8  arg_s8[0x60];
    };
};
UT_OFF(struct ut_cmd, arg, 0x04);
_Static_assert(sizeof(struct ut_cmd) == 0x64, "ut_cmd");

/* Статистика BF соединения (UT 10/21 hw_sysapi_get_beamforming_statistics, данные ответа
 * 0x2c Б) — упаковка снимка отчёта BF (struct lmac_evt_bf_done, include/lmac_cmd.h) в
 * link_stats__pack_conn_entry (0x8cdd7c). */
struct ut_bf_stats {
    u8  status;                                /* 0x00: lmac_evt_bf_done.status (младший байт) */
    u8  type;                                  /* 0x01: .type */
    u8  diag_lo;                               /* 0x02 */
    u8  diag_hi;                               /* 0x03 */
    u8  ssw_rx_cnt;                            /* 0x04 */
    u8  tx_sector;                             /* 0x05 */
    u8  tx_sector_b1;                          /* 0x06 */
    u8  rsv07;                                 /* 0x07: не пишется */
    s32 own_snr;                               /* 0x08 */
    s32 peer_snr;                              /* 0x0c: (s8) .peer_snr */
    u32 sect_seen[2][2];                       /* 0x10 */
    u32 brp_snr;                               /* 0x20 */
    u16 brp_selected;                          /* 0x24 */
    u16 rx_sector;                             /* 0x26 */
    u32 tsf;                                   /* 0x28 */
};
UT_OFF(struct ut_bf_stats, own_snr, 0x08);
UT_OFF(struct ut_bf_stats, sect_seen, 0x10);
UT_OFF(struct ut_bf_stats, brp_selected, 0x24);
_Static_assert(sizeof(struct ut_bf_stats) == 0x2c, "ut_bf_stats");

/* Ответ WMI_UT_RESPONSE (событие 0x1900): {u16 module, u16 subtype} (ut__begin_response),
 * +4 статус, +8 данные подкоманды (до 0xe8 Б: fw_sysapi_mgr::send_evt2host обнуляет 0xec Б
 * с +4). Буфер — элемент пула событий ящика (struct wmi_mbox.tx_pool). */
struct ut_rsp {
    u16 module_id;                             /* 0x00 */
    u16 subtype_id;                            /* 0x02 */
    u32 status;                                /* 0x04 */
    union {                                    /* 0x08 */
        u32 data[0x3a];
        u8  data8[0xe8];
        struct ut_bf_stats bf;
    };
};
UT_OFF(struct ut_rsp, status, 0x04);
UT_OFF(struct ut_rsp, data, 0x08);
_Static_assert(sizeof(struct ut_rsp) == 0xf0, "ut_rsp");

/* Запрос доступа к RGF RFC по маске модулей (UT 10/11 чтение, 10/12 запись; DCCM 0x80669c,
 * 0xd0 Б, в образе нули): готовит обработчик модуля 10, исполняет hw_sysapi_rfc_fetch_rgf_util
 * под радио (fw/rf_sector.c). */
struct rfc_rgf_req {
    struct wmi_mbox *host_if;                  /* 0x00: ящик ответа (mb обработчика UT) */
    struct ut_rsp *rsp;                        /* 0x04: буфер ответа */
    u32 rf_mask;                               /* 0x08: маска RF-модулей (arg8[0]) */
    u32 count;                                 /* 0x0c: число адресов/пар (arg[0] [15:8]) */
    u32 nres;                                  /* 0x10: число результатов в out */
    u32 read;                                  /* 0x14: != 0 — чтение, 0 — запись */
    u32 regs[0x17];                            /* 0x18: адреса (чтение) или пары {адрес, значение} */
    u32 out[0x17];                             /* 0x74: результаты чтения */
};
UT_OFF(struct rfc_rgf_req, regs, 0x18);
UT_OFF(struct rfc_rgf_req, out, 0x74);
_Static_assert(sizeof(struct rfc_rgf_req) == 0xd0, "rfc_rgf_req");
extern struct rfc_rgf_req rfc_rgf_req;         /* 0x80669c (fw/sysapi_stats.c, FWDATA) */

struct ut_rsp *ut_begin_response(struct wmi_mbox *mb, u32 module, u32 subtype);   /* ut_resp.c (0x8eae60) */
void wmi_evt_send_words(struct wmi_mbox *mb, volatile struct ut_rsp *buf, u32 len); /* ut_resp.c (0x8eae78) */

/* Модули 9..12: (mb — ящик команд, c — тело команды). В wmi.c —
 * weak-заглушки (поглощают команду без ответа); полные порты — в отдельных файлах. */
void ut_hw_flows_operational_cmd_handler(struct wmi_mbox *mb, const struct ut_cmd *c);   /* 9:  0x8fa884 */
void ut_module_hw_flows_sysapi_cmd_handler(struct wmi_mbox *mb, const struct ut_cmd *c); /* 10: 0x8faf34 */
void ut_hw_modes_cmd_handler(struct wmi_mbox *mb, const struct ut_cmd *c);               /* 11: 0x8fada4 */
void ut_hw_drivers_cmd_handler(struct wmi_mbox *mb, const struct ut_cmd *c);             /* 12: 0x8eaec8 */

#endif
