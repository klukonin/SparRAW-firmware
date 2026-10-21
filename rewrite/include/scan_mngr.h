/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* scan_mngr — менеджер скана записи mid (fw/scan.c, scan_mngr.c, discovery.c, wmi_cmd.c, conn.c,
 * bf_result.c, lmac_evt.c): списки кандидатов (pending) / найденных (scanned) BSS из dband-инфо,
 * список каналов, инфо пассивного скана, лучшие ответы на пробу (peer_info_array), автомат
 * скана при соединении swc_psc_sm (внутри объекта) и автомат каналов channels_switch_sm (вне
 * DCCM, 0x842d00 + 0x24·mid). Раскладка — как у vendor 6.2 (объект 0x8052ec + 0x228·mid,
 * radio_req__addr_of 0x8f3698; [mid+0x23c] = mid_disc.scan); имена — из журнала vendor
 * (m_scan_pend_list, scanned_list, m_active_probs, m_is_connected, postpone_scan,
 * m_ucode_scan_type, peer_info_array, p_dband_info->conn_ptr, prob_resp_timeout_event_id).
 * Смещения закреплены _Static_assert; ширины полей — как у доступов vendor. */
#ifndef SCAN_MNGR_H
#define SCAN_MNGR_H
#include "types.h"
#include "basic_sm.h"
#include "llist.h"

#define SCAN_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

struct scan_mngr;
struct conn;
struct mid;
struct rm_req;

/* Статус пробы dband-инфо (dband_info.status). */
enum {
    DBAND_ST_NEW = 1,       /* бикон принят (dband_beacon_ind) / повторная проба (prob_done 3) */
    DBAND_ST_ABFT = 2,      /* пир найден ABFT BF (handle_abft_bf_result_in_scan) */
    DBAND_ST_PROBING = 3,   /* probe request отправлен (send_prob_req) */
    DBAND_ST_DONE = 4,      /* проба завершена (prob_done) */
};

/* dband-инфо — найденный BSS (пул dband_info_pool, 0x10 × 0x4c; alloc_dband_info 0x8f0cf8).
 * Элемент списков scan_mngr.pend / scan_mngr.scanned и find_sm.found. */
struct dband_info {
    struct dband_info *next;                   /* 0x00: узел llist */
    struct llist *list;                        /* 0x04: список, где стоит («container») */
    union {                                    /* 0x08: BSSID; журнал vendor — словом и полусловом */
        u8 bssid[6];
        struct { u32 bssid_lo; u16 bssid_hi; };
    };
    u8 ssid[32];                               /* 0x10 */
    u8 ssid_len;                               /* 0x30 */
    u8 rsv_31[3];
    u32 own_bss;                               /* 0x34: BSSID совпал с BSS соединения mid (скан при соединении) */
    u8 bf_sector;                              /* 0x38: RX-сектор пира из ABFT BF */
    u8 rx_omni;                                /* 0x39: RX-сектор (omni) скана при приёме */
    u8 rsv_3a[2];
    u32 bf_time;                               /* 0x3c: время BF (слово 0 события LMAC) */
    u8 bf_kind;                                /* 0x40: тип: 3 — DMG-бикон, 2 — ABFT (проба с прежним сектором) */
    u8 status;                                 /* 0x41: DBAND_ST_* */
    u8 retries;                                /* 0x42: повторов пробы (prob_done 3) */
    u8 rsv_43;
    struct conn *conn;                         /* 0x44: conn_ptr — соединение пробы */
    u32 probe_tmr;                             /* 0x48: prob_resp_timeout_event_id (u_schd) или 0 */
};
SCAN_OFF(struct dband_info, ssid, 0x10);
SCAN_OFF(struct dband_info, own_bss, 0x34);
SCAN_OFF(struct dband_info, bf_kind, 0x40);
SCAN_OFF(struct dband_info, conn, 0x44);
_Static_assert(sizeof(struct dband_info) == 0x4c, "dband_info");

/* Элемент списка каналов скана (пул scan_ch_pool 0x842c74, 10 × 0xc). */
struct scan_ch {
    struct scan_ch *next;                      /* 0x00: узел llist */
    struct llist *list;                        /* 0x04 */
    u32 channel;                               /* 0x08: номер канала (0..3) */
};
_Static_assert(sizeof(struct scan_ch) == 0xc, "scan_ch");

/* Инфо пассивного скана канала (scan_mngr.passive[канал]; WMI_ACS_PASSIVE_SCAN_COMPLETE). */
struct scan_passive_info {
    u32 valid;                                 /* 0x00: 1 — заполнена (calculate_passive_scan_info) */
    u32 busy_ms;                               /* 0x04: на входе — время, на выходе — длительность, мс */
    u32 bcon_found;                            /* 0x08: на входе — счётчик биконов, на выходе — «вырос» */
};
_Static_assert(sizeof(struct scan_passive_info) == 0xc, "scan_passive_info");

/* Лучший ответ на пробу BSS на канале (peer_info_array; probe_resp_ind 0x8f7ae4,
 * l2_mgr__connect_next 0x8e4c24 возвращает адрес записи). */
struct scan_peer {
    union {
        u8 bssid[6];                           /* 0x00: BSSID (сравнение побайтно) */
        struct {
            u32 bssid_lo;                      /* 0x00: vendor пишет BSSID словом и полусловом */
            u16 bssid_hi;                      /* 0x04 */
            u8 rx_omni;                        /* 0x06: лучший directed omni (по SNR) — RX-сектор связи */
            s8 rx_snr;                         /* 0x07: его SNR */
            u8 tx_omni;                        /* 0x08: omni последнего лучшего tx_sector_snr */
            s8 tx_snr;                         /* 0x09: tx_sector_snr */
            u16 rssi;                          /* 0x0a */
            u32 tx_bcon_time;                  /* 0x0c: bcon_systime для tx_omni */
            u32 bcon_time;                     /* 0x10: bcon_systime для rx_omni (mid__link_acquis_step) */
        };
    };
};
SCAN_OFF(struct scan_peer, rx_omni, 0x06);
SCAN_OFF(struct scan_peer, bcon_time, 0x10);
_Static_assert(sizeof(struct scan_peer) == 0x14, "scan_peer");
/* 0x800338: запись пира, к которой идёт connect_multi_omni (l2_mgr__connect_multi_omni
 * 0x8c71fc: st.as [gp,0x6d] результата l2_mgr__connect_next), 0 — нет. */
extern struct scan_peer *volatile conn_multi_omni_target;

#define SCAN_PEER_CH   4                       /* каналов в peer_info_array */
#define SCAN_PEER_N    4                       /* записей на канал */
#define SCAN_PASSIVE_N 5                       /* инфо пассивного скана (по номеру канала) */

/* Поля команды WMI_START_SCAN (wmi_start_scan_cmd до channel_list), копия в scan_mngr для
 * перезапуска со следующим RX-сектором (dwelling_done → start_scan). */
struct scan_cmd_copy {
    u8 direct_mac[6];                          /* 0x00: direct_scan_mac_addr */
    u8 discovery_mode;                         /* 0x06 */
    u8 rsv_07;
    u32 dwell_time;                            /* 0x08: мс */
    u32 force_scan_interval;                   /* 0x0c */
    u8 scan_type;                              /* 0x10 */
    u8 num_channels;                           /* 0x11 */
    u8 rsv_12[2];
};
_Static_assert(sizeof(struct scan_cmd_copy) == 0x14, "scan_cmd_copy");

/* Автомат скана при соединении swc_psc_sm (описатель 0x8030e0; scan_mngr + 0x1d0). */
struct swc_psc_sm {
    struct basic_sm hdr;                       /* 0x00 */
    struct scan_mngr *scan;                    /* 0x08: action_start_scan */
    u32 sob_tmr;                               /* 0x0c: таймер ожидания SOB (sob_started_wd_timeout_cb) */
};
_Static_assert(sizeof(struct swc_psc_sm) == 0x10, "swc_psc_sm");

/* Автомат каналов channels_switch_sm (описатель 0x802fb4, ctor 0x8d9058; 0x842d00 + 0x24·mid,
 * scan_mngr__entry_addr 0x8cc6a4). */
struct channels_switch_sm {
    struct basic_sm hdr;                       /* 0x00 */
    struct scan_mngr *scan;                    /* 0x08 */
    struct rm_req *req;                        /* 0x0c: запрос радио (request_secondary) */
    u32 alloc_tmr;                             /* 0x10: таймер выделения радио */
    u32 dwell_tmr;                             /* 0x14: таймер пребывания */
    u32 scan_tmr;                              /* 0x18: общий таймер скана */
    struct scan_ch *cur;                       /* 0x1c: текущий канал */
    struct mid *mid;                           /* 0x20 */
};
_Static_assert(sizeof(struct channels_switch_sm) == 0x24, "channels_switch_sm");

/* Состояния channels_switch_sm (байт hdr.state; по vendor: 4 — DWELLING). */
enum { CS_ST_DWELLING = 4 };

/* Объект scan_mngr (0x228 Б). */
struct scan_mngr {
    struct llist pend;                         /* 0x000: m_scan_pend_list — кандидаты (проба), не больше 8 */
    struct llist scanned;                      /* 0x00c: scanned_list — найденные BSS */
    struct llist channels;                     /* 0x018: оставшиеся каналы (struct scan_ch) */
    u8 num_channels;                           /* 0x024 */
    u8 rsv_025[3];
    struct scan_passive_info passive[SCAN_PASSIVE_N]; /* 0x028: по номеру канала */
    u8 direct_mac[6];                          /* 0x064: direct_scan_mac_addr (mgmt_tx__copy_addr_from_conn) */
    u8 rsv_06a[2];
    u32 scan_type;                             /* 0x06c: 0 активный, 2 ACS (пассивный), 3 — с discovery */
    u32 dwell_us;                              /* 0x070: время пребывания на канале */
    u32 rsv_074;
    u32 active;                                /* 0x078: скан идёт */
    struct mid *mid;                           /* 0x07c */
    struct channels_switch_sm *cs;             /* 0x080 */
    struct scan_peer peers[SCAN_PEER_CH][SCAN_PEER_N]; /* 0x084: peer_info_array[канал][i] */
    u8 peer_cnt[SCAN_PEER_CH];                 /* 0x1c4: записей peers[канал] */
    u32 aborted;                               /* 0x1c8: скан прерван (итог — статус 2) */
    u32 postponed;                             /* 0x1cc: postpone_scan — ждёт паузы колец (scan_resume) */
    struct swc_psc_sm swc;                     /* 0x1d0 */
    u32 dwell_stopped;                         /* 0x1e0: пребывание окончено / прервано (биконы не принимать) */
    u32 ch_order[4];                           /* 0x1e4: каналы команды, текущий первым (sort_scan_ch_list) */
    u32 rsv_1f4;
    struct scan_cmd_copy cmd;                  /* 0x1f8 */
    u32 postpone_arg;                          /* 0x20c: аргумент a2 запуска (результат паузы колец) */
    u32 connected_arg;                         /* 0x210: аргумент a3 запуска (есть соединение) */
    u8 rx_omni;                                /* 0x214: текущий RX-сектор (omni) */
    u8 active_probs;                           /* 0x215: m_active_probs */
    u8 discovery_mode;                         /* 0x216 */
    u8 ucode_scan_type;                        /* 0x217: m_ucode_scan_type (режим discovery для uc) */
    u32 connected_scan_time;                   /* 0x218: время скана при соединении */
    u32 tsf_start[2];                          /* 0x21c: TSF старта */
    u32 is_connected;                          /* 0x224: m_is_connected — скан через swc_psc_sm */
};
SCAN_OFF(struct scan_mngr, num_channels, 0x24);
SCAN_OFF(struct scan_mngr, passive, 0x28);
SCAN_OFF(struct scan_mngr, direct_mac, 0x64);
SCAN_OFF(struct scan_mngr, scan_type, 0x6c);
SCAN_OFF(struct scan_mngr, active, 0x78);
SCAN_OFF(struct scan_mngr, cs, 0x80);
SCAN_OFF(struct scan_mngr, peers, 0x84);
SCAN_OFF(struct scan_mngr, peer_cnt, 0x1c4);
SCAN_OFF(struct scan_mngr, aborted, 0x1c8);
SCAN_OFF(struct scan_mngr, swc, 0x1d0);
SCAN_OFF(struct scan_mngr, dwell_stopped, 0x1e0);
SCAN_OFF(struct scan_mngr, ch_order, 0x1e4);
SCAN_OFF(struct scan_mngr, cmd, 0x1f8);
SCAN_OFF(struct scan_mngr, postpone_arg, 0x20c);
SCAN_OFF(struct scan_mngr, rx_omni, 0x214);
SCAN_OFF(struct scan_mngr, connected_scan_time, 0x218);
SCAN_OFF(struct scan_mngr, tsf_start, 0x21c);
SCAN_OFF(struct scan_mngr, is_connected, 0x224);
_Static_assert(sizeof(struct scan_mngr) == 0x228, "scan_mngr");

/* Счётчики скана (0x805514, 7 полуслов; обнуляют mid_ctx_pool__init и start_scan; vendor
 * адресует от 0x8054ec). */
struct scan_stats {
    union {
        u16 h[7];                              /* обнуление — циклом по полусловам */
        struct {
            u16 cur_channel;                   /* 0x00: канал скана (action_pop_ch_and_tune) */
            u16 rsv_02;
            u16 bcon_ind;                      /* 0x04: DMG-биконов в dband_beacon_ind */
            u16 bss_added;                     /* 0x06: кандидатов добавлено */
            u16 rsv_08[2];
            u16 scan_done;                     /* 0x0c: сканов завершено */
        };
    };
};
_Static_assert(sizeof(struct scan_stats) == 0xe, "scan_stats");

/* Экземпляры: DCCM — FWDATA в fw/scan.c (в каталоге ext[N]); автоматы каналов — символ
 * fw/fw.ld. По одному на запись mid (MID_RECS_N). */
#define SCAN_MNGR_N 1
extern struct scan_mngr scan_mngrs[SCAN_MNGR_N];                 /* 0x8052ec */
extern volatile struct scan_stats scan_stats;                    /* 0x805514 */
/* swc_psc_sm (описатель 0x8030e0): переходы [событие][состояние] и имена (fw_data, fw/scan.c);
 * имена channels_switch_sm (0x802fb4) — там же. */
extern const struct sm_trans swc_psc_sm_trans[4][3];             /* 0x801650 */
extern const u32 swc_psc_sm_state_names[3];                      /* 0x80168c */
extern const u32 swc_psc_sm_event_names[4];                      /* 0x801698 */
extern const u32 chsw_sm_state_names[7];                         /* 0x801608 */
extern const u32 chsw_sm_event_names[8];                         /* 0x801624 */
extern struct channels_switch_sm scan_cs_sms[SCAN_MNGR_N];       /* 0x842d00 (fw.ld) */
#define SCAN_CH_N 10
extern struct scan_ch scan_ch_mem[SCAN_CH_N];                    /* 0x842c88 (fw.ld): память scan_ch_pool */

/* Описатели автоматов в DCCM (FWDATA, fw/scan.c; ид [0x10] пишет статический конструктор). */
extern struct sm_desc channels_switch_sm_desc;       /* 0x802fb4 */
extern struct sm_desc swc_psc_sm_desc;               /* 0x8030e0 */

#endif
