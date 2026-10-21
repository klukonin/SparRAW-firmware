/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* fw_sysapi_mgr — менеджер запросов статистики/измерений UT_MODULE_HW_FLOWS_SYSAPI
 * (fw/sysapi_stats.c, phy_ext.c, mac_ext.c, misc_ext_sysapi.c, lmac_evt.c).
 * Один экземпляр в DCCM — vendor 0x805170 (0xbc Б, до OTP-буфера 0x80522c); конструктор —
 * 0x8c196c (fw/ctors.c). Раскладка — как у vendor 6.2, смещения закреплены _Static_assert.
 * Имена полей — по журналу vendor (m_ut_wmi_context, m_completion_cb, rssi_adc_min …).
 * Поля volatile: прежний код обращался к ним через volatile-указатели. */
#ifndef SYSAPI_MGR_H
#define SYSAPI_MGR_H
#include "types.h"
#include "fwsh.h"

struct wmi_mbox;

#define SYSAPI_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

/* Номер запроса (+0x00 request_type). */
enum {
    SYSAPI_REQ_ENERGY      = 1,   /* статистика энергии RX (RSSI/SNR) */
    SYSAPI_REQ_PLCP        = 2,   /* PLCP-заголовок */
    SYSAPI_REQ_RX_PKT_PHY  = 3,   /* данные PHY принятого пакета */
    SYSAPI_REQ_PHY_RX      = 4,   /* статистика PHY RX */
    SYSAPI_REQ_AMPDU       = 5,   /* статистика A-MPDU */
    SYSAPI_REQ_CHAN_EST    = 6,   /* оценка канала */
    SYSAPI_REQ_FLUSH_STATS = 7,   /* сброс статистики */
    SYSAPI_REQ_UT_ARGS     = 8,   /* аргументы UT (расписание, LMAC 0x42) */
};

/* Контекст ответа UT (m_ut_wmi_context): как ctx обработчика 0x8faf34 — слово
 * {u16 module, u16 subtype} и ящик (host_if_p); целиком передаётся как const u32 *. */
union sysapi_ut_ctx {
    u32 w[2];
    struct {
        u16 module;                            /* 0x00: ut_module_id */
        u16 subtype;                           /* 0x02: ut_subtype_id */
        struct wmi_mbox *host_if;              /* 0x04: host_if_p — ящик ответа */
    };
};

/* Итог статистики энергии (запрос 1, ответ хосту 0x2c Б): TSF и min/max по отсчётам
 * (fw_sysapi_mgr::get_rssi_and_snr_statistics 0x8f3780, complete_energy_statistics). */
struct sysapi_energy_stats {
    volatile u32 tsf_start_lo;                 /* 0x00: TSF старта запроса */
    volatile u32 tsf_start_hi;                 /* 0x04 */
    volatile u32 tsf_last_lo;                  /* 0x08: TSF последнего отсчёта (0x857298) */
    volatile u32 tsf_last_hi;                  /* 0x0c */
    volatile s32 rssi_adc_min;                 /* 0x10 */
    volatile s32 rssi_adc_max;                 /* 0x14 */
    volatile s32 snr_adc_min;                  /* 0x18: индекс LUT rssi_snr_lut */
    volatile s32 snr_adc_max;                  /* 0x1c */
    volatile s32 rssi_ant_min;                 /* 0x20: RSSI Q4 (rx_energy__calc_rssi_q4) */
    volatile s32 rssi_ant_max;                 /* 0x24 */
    volatile u32 samples_num;                  /* 0x28 */
};
_Static_assert(sizeof(struct sysapi_energy_stats) == 0x2c, "sysapi_energy_stats");

/* LUT RSSI ADC → SNR ADC (lut__find_index 0x8c74e8): отсортированные ключи, значения, число. */
struct sysapi_lut {
    const s32 *keys;                           /* 0x00 */
    const u32 *vals;                           /* 0x04 */
    u32 n;                                     /* 0x08 */
};

/* База счётчиков MAC — снимок на старте статистики A-MPDU (0x8f6370); дельты считает
 * stats__delta_since_baseline (0x8f64f4). */
struct sysapi_mac_stats_base {
    volatile u32 tx_lo;                        /* 0x00: u64 счётчик TX MAC */
    volatile u32 tx_hi;                        /* 0x04 */
    volatile u32 rx_lo;                        /* 0x08: u64 счётчик RX MAC */
    volatile u32 rx_hi;                        /* 0x0c */
    volatile u32 tx_ok;                        /* 0x10 */
    volatile u32 tx_fail;                      /* 0x14 */
    volatile u32 rx_crc_total;                 /* 0x18 */
    volatile u32 rx_crc_err;                   /* 0x1c */
    volatile u32 by_id;                        /* 0x20: счётчик по id (MCS), сумма пары */
    volatile u32 by_id_first;                  /* 0x24: первое слово пары (*out) */
};
_Static_assert(sizeof(struct sysapi_mac_stats_base) == 0x28, "sysapi_mac_stats_base");

struct fw_sysapi_mgr;

/* Колбэк ответа ucode (m_completion_cb): fw_sysapi_mgr::complete_pending_request (0x8f1c50)
 * зовёт его с телом события LMAC. */
typedef void (*sysapi_completion_cb)(struct fw_sysapi_mgr *m, u32 status, const void *body);

/* fw_sysapi_mgr (vendor 0x805170, 0xbc Б). */
struct fw_sysapi_mgr {
    volatile u32 request_type;                 /* 0x00: SYSAPI_REQ_* */
    volatile union sysapi_ut_ctx ut;           /* 0x04: m_ut_wmi_context */
    volatile u32 timeout;                      /* 0x0c: тайм-аут (≥ 100) */
    volatile u32 timer;                        /* 0x10: задача таймера u_schd */
    volatile u8  ampdu_mcs;                    /* 0x14: MCS фильтра A-MPDU (zero_and_fill не трогает) */
    u8  rsv_15[3];                             /* 0x15 */
    volatile u32 active;                       /* 0x18: запрос идёт */
    volatile u32 stopped;                      /* 0x1c: запрос остановлен */
    volatile u32 status;                       /* 0x20: статус ответа (2 — ждём ucode) */
    volatile u32 tsf_start[2];                 /* 0x24: TSF старта (u64) */
    volatile u32 tsf_stop[2];                  /* 0x2c: TSF останова (u64) */
    volatile sysapi_completion_cb completion_cb; /* 0x34: m_completion_cb */
    volatile u32 energy_count;                 /* 0x38: число замеров энергии (≤ 0x14) */
    struct sysapi_energy_stats energy;         /* 0x3c: ответ запроса 1 */
    u8  plcp_rsp[0x20];                        /* 0x68: ответ запроса 2 (копия тела ucode) */
    struct sysapi_lut rssi_snr_lut;            /* 0x88: (0x8051f8) */
    struct sysapi_mac_stats_base mac_base;     /* 0x94: (0x805204) */
};
SYSAPI_OFF(struct fw_sysapi_mgr, ut, 0x04);
SYSAPI_OFF(struct fw_sysapi_mgr, timer, 0x10);
SYSAPI_OFF(struct fw_sysapi_mgr, ampdu_mcs, 0x14);
SYSAPI_OFF(struct fw_sysapi_mgr, active, 0x18);
SYSAPI_OFF(struct fw_sysapi_mgr, status, 0x20);
SYSAPI_OFF(struct fw_sysapi_mgr, tsf_start, 0x24);
SYSAPI_OFF(struct fw_sysapi_mgr, tsf_stop, 0x2c);
SYSAPI_OFF(struct fw_sysapi_mgr, completion_cb, 0x34);
SYSAPI_OFF(struct fw_sysapi_mgr, energy_count, 0x38);
SYSAPI_OFF(struct fw_sysapi_mgr, energy, 0x3c);
SYSAPI_OFF(struct fw_sysapi_mgr, plcp_rsp, 0x68);
SYSAPI_OFF(struct fw_sysapi_mgr, rssi_snr_lut, 0x88);
SYSAPI_OFF(struct fw_sysapi_mgr, mac_base, 0x94);
_Static_assert(sizeof(struct fw_sysapi_mgr) == 0xbc, "fw_sysapi_mgr");

/* Экземпляр (fw/sysapi_stats.c, FWDATA(805170); в каталоге fw/dccm_names.txt — ext[188]). */
extern struct fw_sysapi_mgr fw_sysapi_mgr;
/* LUT RSSI ADC → SNR ADC (fw/sysapi_stats.c): ключи 0x801170, значения 0x801230 (48). */
#define RSSI_SNR_LUT_N 48
extern const s32 rssi_snr_lut_keys[RSSI_SNR_LUT_N];
extern const s32 rssi_snr_lut_vals[RSSI_SNR_LUT_N];

/* Статистика PHY RX от ucode (struct phy_rx_stats, fwsh_phy.st 0x8576ac) — include/fwsh.h. */

/* Тело ответа ucode на запрос PLCP-заголовка (команда 2, 0x20 Б); поля — по журналу vendor
 * «fw_sysapi_mgr::complete_plcp_header(): PLCP Header Results: …». */
struct lmac_evt_plcp_hdr {
    u32 rsv00[2];                              /* 0x00 */
    u32 mcs;                                   /* 0x08: plcp_mcs */
    u32 length;                                /* 0x0c: plcp_length */
    u32 train_length;                          /* 0x10: plcp_train_length */
    u32 packet_type;                           /* 0x14: plcp_packet_type */
    u32 add_ppdu;                              /* 0x18: plcp_add_ppdu */
    u32 aggregation;                           /* 0x1c: plcp_aggregation */
};
_Static_assert(sizeof(struct lmac_evt_plcp_hdr) == 0x20, "lmac_evt_plcp_hdr");

/* Накопитель долей занятости эфира (CCA) по BI (0x80426c, 0x14 Б; DCCM, сразу за
 * operational_mbox): lmac_if__update_pct_stats (fw/lmac_evt.c) копит две доли в процентах и
 * усредняет по окну [0x803c1c] + 1 BI; wmi_set_cca_indications_bi_avg_num (fw/wmi_h_bf.c)
 * сбрасывает. */
struct cca_pct_stats {
    u16 n;                                     /* 0x00: BI в окне (с 1) */
    u8  pct2;                                  /* 0x02: доля 2 последнего BI, % */
    u8  rsv_03;
    u32 sum2;                                  /* 0x04: сумма долей 2 */
    u8  avg2;                                  /* 0x08: среднее доли 2 за окно */
    u8  pct1;                                  /* 0x09: доля 1 последнего BI, % */
    u8  rsv_0a[2];
    u32 sum1;                                  /* 0x0c */
    u8  avg1;                                  /* 0x10 */
    u8  rsv_11[3];
};
_Static_assert(__builtin_offsetof(struct cca_pct_stats, pct1) == 9, "cca_pct_stats.pct1");
_Static_assert(__builtin_offsetof(struct cca_pct_stats, avg1) == 0x10, "cca_pct_stats.avg1");
_Static_assert(sizeof(struct cca_pct_stats) == 0x14, "cca_pct_stats");
extern struct cca_pct_stats cca_pct_stats;     /* 0x80426c (fw/lmac_evt.c) */

#endif
