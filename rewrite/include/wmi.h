/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Тела WMI-команд хоста и WMI-событий fw (host ↔ fw). Буфер записи ящика — struct mbox_hdr
 * (include/mbox.h, 0x10 Б), тело — с +0x10; диспетчер — fw/wmi_cmd.c, обработчики —
 * fw/wmi_h_*.c, прототипы — include/wmi_handlers.h.
 *
 * Имена — из драйвера wil6210 (drivers/net/wireless/ath/wil6210/wmi.h, SparRAW-driver), но
 * раскладка — как её читает/пишет vendor 6.2 (fw главнее драйвера): где они расходятся,
 * у структуры помечено «6.2:». Все смещения закреплены _Static_assert.
 *
 * Структуры НЕ packed: у gcc packed-поле получает выравнивание 1, и ARC600 читал бы u16/u32
 * побайтно — а vendor читает тело словами/полусловами (буферы пулов выровнены на 4). Поля
 * расставлены так, что естественная раскладка совпадает с __packed драйвера; где драйвер
 * кладёт u32/u64 по смещению, не кратному 4/8, поле здесь — массив половин (u16[2]) или
 * u32[2] — так, как его и читает vendor. Где vendor читает MAC словом + полусловом (журнал)
 * — анонимный union с полями *_lo / *_hi (вместе со следующим полем, чтобы размер union не
 * рос из-за выравнивания). */
#ifndef WMI_H
#define WMI_H
#include "types.h"
#include "sta_max.h"

#define WMI_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)
#define WMI_SIZE(t, n)   _Static_assert(sizeof(t) == (n), #t)

#define WMI_MAC_LEN        6
#define WMI_MAX_SSID_LEN   32
#define WMI_NUM_MCS        13

/* ======================= общие части ======================= */

/* Событие из одного статуса {status, reserved[3]} — у драйвера отдельная структура на
 * каждое событие; vendor пишет только status (байты 1..3 — где обнулены, отмечено у места):
 * RF_PWR_ON_DELAY 0x185d, SET_HIGH_POWER_TABLE_PARAMS 0x185e, FIXED_SCHEDULING_UL_CONFIG
 * 0x185f, VRING_SWITCH_TIMING_CONFIG 0x1868, TOF_SET_TX_RX_OFFSET 0x1997, SET_RF_SECTOR_ON
 * 0x19a4, PRIO_TX_SECTORS_* 0x19a5, BF_CONTROL 0x19aa, FIXED_SCHEDULING_CONFIG_COMPLETE
 * 0x1a02, ENABLE_FIXED_SCHEDULING_COMPLETE 0x1a03, SET_MULTI_DIRECTED_OMNIS_CONFIG 0x1a04,
 * SET_LONG_RANGE_CONFIG_COMPLETE 0x1a05, SET_CCA_INDICATIONS_BI_AVG_NUM 0x1a08,
 * SET_GRANT_MCS 0x1a0e, SET_AP_SLOT_SIZE 0x1a0f, BRP_SET_ANT_LIMIT 0x1924,
 * SET_SELECTED_RF_SECTOR_INDEX_DONE 0x19a3, RF_XPM_WRITE_RESULT 0x1857 (длина 1),
 * SET_RF_SECTOR_PARAMS_DONE 0x19a1 (длина 1), SET_MGMT_RETRY_LIMIT 0x1930, SW_TX_COMPLETE
 * 0x182b, P2P_CFG_DONE 0x1910, PORT_ALLOCATED 0x1911, PCP_STARTED 0x1918, TRAFFIC_RESUME
 * 0x1905 (длина 1). */
struct wmi_status_event {
    u8  status;                                /* 0x00 */
    u8  reserved[3];                           /* 0x01 */
};
WMI_SIZE(struct wmi_status_event, 4);

/* Кольцо в памяти хоста (struct wmi_sw_ring_cfg): ring_mem_base — u64 по смещению +4
 * команды, поэтому — байты / два слова. */
struct wmi_sw_ring_cfg {
    union {
        u8  ring_mem_base[8];                  /* 0x00 */
        u32 ring_mem_base32[2];                /* 0x00: lo, hi */
    };
    u16 ring_size;                             /* 0x08 */
    u16 max_mpdu_size;                         /* 0x0a */
};
WMI_OFF(struct wmi_sw_ring_cfg, ring_size, 0x08);
WMI_SIZE(struct wmi_sw_ring_cfg, 0xc);

/* Параметры расписания vring (struct wmi_vring_cfg_schd; +0x14 тела WMI_VRING_CFG). */
struct wmi_vring_cfg_schd {
    u16 priority;                              /* 0x00 */
    u16 timeslot_us;                           /* 0x02 */
};
WMI_SIZE(struct wmi_vring_cfg_schd, 4);

/* Конфигурация vring (struct wmi_vring_cfg драйвера). */
struct wmi_vring_cfg {
    struct wmi_sw_ring_cfg tx_sw_ring;         /* 0x00 */
    u8  ringid;                                /* 0x0c */
    u8  cidxtid;                               /* 0x0d: [3:0] cid, [7:4] tid */
    u8  encap_trans_type;                      /* 0x0e */
    u8  ds_cfg;                                /* 0x0f */
    u8  nwifi_ds_trans_type;                   /* 0x10 */
    u8  mac_ctrl;                              /* 0x11 */
    u8  to_resolution;                         /* 0x12 */
    u8  agg_max_wsize;                         /* 0x13 */
    struct wmi_vring_cfg_schd schd_params;     /* 0x14 */
};
WMI_OFF(struct wmi_vring_cfg, ringid, 0x0c);
WMI_OFF(struct wmi_vring_cfg, agg_max_wsize, 0x13);
WMI_OFF(struct wmi_vring_cfg, schd_params, 0x14);
WMI_SIZE(struct wmi_vring_cfg, 0x18);

/* WMI_VRING_CFG_CMDID (0x821). */
struct wmi_vring_cfg_cmd {
    u32 action;                                /* 0x00: 0 ADD, 1 MODIFY, 2 DEL */
    struct wmi_vring_cfg vring_cfg;            /* 0x04 */
};
WMI_OFF(struct wmi_vring_cfg_cmd, vring_cfg.tx_sw_ring.max_mpdu_size, 0x0e);
WMI_SIZE(struct wmi_vring_cfg_cmd, 0x1c);

/* WMI_ACS_PASSIVE_SCAN_COMPLETE_EVENTID (0x9005): запись канала (struct scan_acs_info). */
struct wmi_scan_acs_info {
    u8  channel;                               /* 0x00 */
    u8  beacon_found;                          /* 0x01 */
    u16 busy_time;                             /* 0x02 */
    u16 tx_time;                               /* 0x04 */
    u16 rx_time;                               /* 0x06 */
    u8  channel_load;                          /* 0x08 */
    u8  reserved[3];
};
WMI_SIZE(struct wmi_scan_acs_info, 0xc);
struct wmi_acs_passive_scan_complete_event {
    u32 dwell_time;                            /* 0x00 */
    u16 starting_channel;                      /* 0x04 */
    u8  filled;                                /* 0x06 */
    u8  status;                                /* 0x07 */
    struct wmi_scan_acs_info scan_info[];      /* 0x08 */
};
WMI_OFF(struct wmi_acs_passive_scan_complete_event, scan_info, 0x08);

/* WMI_VRING_CFG_DONE_EVENTID (0x1821). */
struct wmi_vring_cfg_done_event {
    u8  ringid;                                /* 0x00 */
    u8  status;                                /* 0x01 */
    u8  reserved[2];
    u32 tx_vring_tail_ptr;                     /* 0x04: адрес MAC-очереди (hwd_dma_macq_reg_addr) */
};
WMI_SIZE(struct wmi_vring_cfg_done_event, 8);

/* ======================= команды ======================= */

/* WMI_CONNECT_CMDID (0x001). */
struct wmi_connect_cmd {
    u8  network_type;                          /* 0x00: enum wmi_network_type */
    u8  dot11_auth_mode;                       /* 0x01 */
    u8  auth_mode;                             /* 0x02 */
    u8  pairwise_crypto_type;                  /* 0x03 */
    u8  pairwise_crypto_len;                   /* 0x04 */
    u8  group_crypto_type;                     /* 0x05 */
    u8  group_crypto_len;                      /* 0x06 */
    u8  ssid_len;                              /* 0x07 */
    u8  ssid[WMI_MAX_SSID_LEN];                /* 0x08 */
    u8  channel;                               /* 0x28 */
    u8  edmg_channel;                          /* 0x29: 6.2 не читает */
    u8  bssid[WMI_MAC_LEN];                    /* 0x2a */
    u32 ctrl_flags;                            /* 0x30: бит 6 — WMI_CONNECT_DO_WPA_OFFLOAD */
    union {
        struct {
            u8 dst_mac[WMI_MAC_LEN];           /* 0x34 */
            u8 reserved1[2];                   /* 0x3a: 6.2 — [0] режим vendor IE (l2mgr_connect) */
        };
        struct {
            u32 dst_mac_lo;                    /* 0x34: dst_mac[0..3] */
            u16 dst_mac_hi;                    /* 0x38: dst_mac[4..5] */
        };
    };
};
WMI_OFF(struct wmi_connect_cmd, channel, 0x28);
WMI_OFF(struct wmi_connect_cmd, bssid, 0x2a);
WMI_OFF(struct wmi_connect_cmd, ctrl_flags, 0x30);
WMI_OFF(struct wmi_connect_cmd, dst_mac, 0x34);
WMI_OFF(struct wmi_connect_cmd, dst_mac_hi, 0x38);
WMI_OFF(struct wmi_connect_cmd, reserved1, 0x3a);
WMI_SIZE(struct wmi_connect_cmd, 0x3c);
#define WMI_CONNECT_DO_WPA_OFFLOAD 0x40u

/* WMI_DISCONNECT_STA_CMDID (0x004), WMI_DEL_STA_CMDID (0x936) — одна раскладка
 * (struct wmi_disconnect_sta_cmd / wmi_del_sta_cmd); журнал del_sta читает MAC полусловами. */
struct wmi_disconnect_sta_cmd {
    union {
        struct {
            u8  dst_mac[WMI_MAC_LEN];          /* 0x00 */
            u16 disconnect_reason;             /* 0x06 */
        };
        u16 dst_mac16[3];                      /* 0x00 */
    };
};
WMI_OFF(struct wmi_disconnect_sta_cmd, disconnect_reason, 0x06);
WMI_SIZE(struct wmi_disconnect_sta_cmd, 8);

/* WMI_START_SCAN_CMDID (0x007). Первые 0x10 Б vendor читает полусловами (журнал). */
struct wmi_start_scan_cmd {
    u8  direct_scan_mac_addr[WMI_MAC_LEN];     /* 0x00 */
    u8  discovery_mode;                        /* 0x06 */
    u8  reserved;                              /* 0x07 */
    u32 dwell_time;                            /* 0x08 */
    u32 force_scan_interval;                   /* 0x0c */
    u8  scan_type;                             /* 0x10: enum wmi_scan_type */
    u8  num_channels;                          /* 0x11 */
    struct {
        u8 channel;
        u8 reserved;
    } channel_list[];                          /* 0x12 */
};
WMI_OFF(struct wmi_start_scan_cmd, scan_type, 0x10);
WMI_OFF(struct wmi_start_scan_cmd, channel_list, 0x12);

/* WMI_BCON_CTRL_CMDID (0x00f); его же тело собирает WMI_PCP_START на стеке. */
struct wmi_bcon_ctrl_cmd {
    u16 bcon_interval;                         /* 0x00: 0 — PCP_STOP */
    u16 frag_num;                              /* 0x02 */
    u32 ss_mask[2];                            /* 0x04: u64 */
    u8  network_type;                          /* 0x0c */
    u8  pcp_max_assoc_sta;                     /* 0x0d: 6.2 — число секторов A-BFT (2..8) */
    u8  disable_sec_offload;                   /* 0x0e */
    u8  disable_sec;                           /* 0x0f */
    u8  hidden_ssid;                           /* 0x10 */
    u8  is_go;                                 /* 0x11 */
    u8  abft_len;                              /* 0x12 */
    u8  reserved;                              /* 0x13 */
};
WMI_OFF(struct wmi_bcon_ctrl_cmd, network_type, 0x0c);
WMI_OFF(struct wmi_bcon_ctrl_cmd, abft_len, 0x12);
WMI_SIZE(struct wmi_bcon_ctrl_cmd, 0x14);

/* WMI_ADD_CIPHER_KEY_CMDID (0x016). */
struct wmi_add_cipher_key_cmd {
    u8  key_index;                             /* 0x00 */
    u8  key_type;                              /* 0x01 */
    u8  key_usage;                             /* 0x02: enum wmi_key_usage */
    u8  key_len;                               /* 0x03 */
    u8  key_rsc[8];                            /* 0x04 */
    u8  key[32];                               /* 0x0c: WMI_MAX_KEY_LEN */
    u8  key_op_ctrl;                           /* 0x2c */
    u8  mac[WMI_MAC_LEN];                      /* 0x2d */
};
WMI_OFF(struct wmi_add_cipher_key_cmd, key, 0x0c);
WMI_OFF(struct wmi_add_cipher_key_cmd, mac, 0x2d);
WMI_SIZE(struct wmi_add_cipher_key_cmd, 0x33);

/* WMI_DELETE_CIPHER_KEY_CMDID (0x017). */
struct wmi_delete_cipher_key_cmd {
    u8  key_index;                             /* 0x00 */
    u8  mac[WMI_MAC_LEN];                      /* 0x01 */
};
WMI_SIZE(struct wmi_delete_cipher_key_cmd, 7);

/* WMI_SET_APPIE_CMDID (0x03f). */
struct wmi_set_appie_cmd {
    u8  mgmt_frm_type;                         /* 0x00: enum wmi_mgmt_frame_type */
    u8  reserved;                              /* 0x01 */
    u16 ie_len;                                /* 0x02 */
    u8  ie_info[];                             /* 0x04 */
};
WMI_OFF(struct wmi_set_appie_cmd, ie_info, 0x04);

/* WMI_ECHO_CMDID (0x803) / WMI_DEEP_ECHO_CMDID (0x804) {value}; WMI_SET_ACTIVE_SILENT_RSSI_
 * TABLE_CMDID (0x85c) {table}; WMI_SET_AP_SLOT_SIZE_CMDID (0xa0f) {slot_size} — одно слово. */
struct wmi_echo_cmd {
    u32 value;                                 /* 0x00 */
};
WMI_SIZE(struct wmi_echo_cmd, 4);

/* WMI_ADD_DEBUG_TX_PCKT_CMDID (0x808): только 6.2 (в драйвере нет); поля — по тому, что
 * vendor передаёт в TX_API::send_packet. */
struct wmi_add_debug_tx_pckt_cmd {
    union {
        u32 len32;                             /* 0x00: так в журнале */
        u16 len;                               /* 0x00: длина кадра */
    };
    u32 cid;                                   /* 0x04 */
    u16 retry_limit;                           /* 0x08 */
    u8  rsv_0a[2];                             /* 0x0a */
    u8  a8;                                    /* 0x0c: аргумент 8 send_packet */
    u8  rsv_0d[7];                             /* 0x0d */
    u8  a6;                                    /* 0x14: аргумент 6 */
    u8  a7;                                    /* 0x15: аргумент 7 */
};
WMI_OFF(struct wmi_add_debug_tx_pckt_cmd, retry_limit, 0x08);
WMI_OFF(struct wmi_add_debug_tx_pckt_cmd, a8, 0x0c);
WMI_OFF(struct wmi_add_debug_tx_pckt_cmd, a6, 0x14);

/* WMI_TEMP_SENSE_CMDID (0x80e). */
struct wmi_temp_sense_cmd {
    u32 measure_baseband_en;                   /* 0x00 */
    u32 measure_rf_en;                         /* 0x04 */
    u32 measure_mode;                          /* 0x08: 1 — синхронно */
};
WMI_SIZE(struct wmi_temp_sense_cmd, 0xc);

/* WMI_CFG_RX_CHAIN_CMDID (0x820). sniffer_cfg.mode vendor читает двумя полусловами. */
struct wmi_sniffer_cfg {
    union {
        u32 mode;                              /* 0x00: enum wmi_sniffer_cfg_mode */
        u16 mode16[2];
    };
    u32 phy_info_mode;                         /* 0x04 */
    u32 phy_support;                           /* 0x08 */
    u8  channel;                               /* 0x0c */
    u8  reserved[3];                           /* 0x0d */
};
WMI_SIZE(struct wmi_sniffer_cfg, 0x10);

struct wmi_cfg_rx_chain_cmd {
    u32 action;                                /* 0x00 */
    struct wmi_sw_ring_cfg rx_sw_ring;         /* 0x04 */
    u8  mid;                                   /* 0x10 */
    u8  decap_trans_type;                      /* 0x11 */
    u8  l2_802_3_offload_ctrl;                 /* 0x12 */
    u8  l2_nwifi_offload_ctrl;                 /* 0x13 */
    u8  vlan_id;                               /* 0x14 */
    u8  nwifi_ds_trans_type;                   /* 0x15 */
    u8  l3_l4_ctrl;                            /* 0x16 */
    u8  ring_ctrl;                             /* 0x17 */
    u16 prefetch_thrsh;                        /* 0x18 */
    s16 wb_thrsh;                              /* 0x1a: vendor берёт со знаком (ldh.x) */
    u32 itr_value;                             /* 0x1c */
    s16 host_thrsh;                            /* 0x20: со знаком */
    u8  reorder_type;                          /* 0x22 */
    u8  reserved;                              /* 0x23 */
    struct wmi_sniffer_cfg sniffer_cfg;        /* 0x24 */
    union {
        s16 max_rx_pl_per_desc;                /* 0x34: со знаком (проверка) */
        u16 max_rx_pl_per_desc_u;              /* 0x34: без знака (журнал) */
    };
    u8  rsv_36[2];                             /* 0x36: хвост выравнивания (драйвер: 0x36 Б) */
};
WMI_OFF(struct wmi_cfg_rx_chain_cmd, rx_sw_ring, 0x04);
WMI_OFF(struct wmi_cfg_rx_chain_cmd, wb_thrsh, 0x1a);
WMI_OFF(struct wmi_cfg_rx_chain_cmd, host_thrsh, 0x20);
WMI_OFF(struct wmi_cfg_rx_chain_cmd, reorder_type, 0x22);
WMI_OFF(struct wmi_cfg_rx_chain_cmd, sniffer_cfg, 0x24);
WMI_OFF(struct wmi_cfg_rx_chain_cmd, max_rx_pl_per_desc, 0x34);
WMI_SIZE(struct wmi_cfg_rx_chain_cmd, 0x38);

/* WMI_BCAST_VRING_CFG_CMDID (0x822). */
struct wmi_bcast_vring_cfg {
    struct wmi_sw_ring_cfg tx_sw_ring;         /* 0x00 */
    u8  ringid;                                /* 0x0c */
    u8  encap_trans_type;                      /* 0x0d */
    u8  ds_cfg;                                /* 0x0e */
    u8  nwifi_ds_trans_type;                   /* 0x0f */
};
WMI_SIZE(struct wmi_bcast_vring_cfg, 0x10);

struct wmi_bcast_vring_cfg_cmd {
    u32 action;                                /* 0x00: 0 — add, 2 — delete */
    struct wmi_bcast_vring_cfg vring_cfg;      /* 0x04 */
};
WMI_OFF(struct wmi_bcast_vring_cfg_cmd, vring_cfg.ringid, 0x10);
WMI_SIZE(struct wmi_bcast_vring_cfg_cmd, 0x14);

/* WMI_SET_SSID_CMDID (0x827); то же — WMI_GET_SSID_EVENTID (0x1828). */
struct wmi_set_ssid_cmd {
    u32 ssid_len;                              /* 0x00 */
    u8  ssid[WMI_MAX_SSID_LEN];                /* 0x04 */
};
WMI_SIZE(struct wmi_set_ssid_cmd, 0x24);

/* WMI_SET_PCP_CHANNEL_CMDID (0x829). */
struct wmi_set_pcp_channel_cmd {
    u8  channel;                               /* 0x00 */
    u8  reserved[3];                           /* 0x01 */
};
WMI_SIZE(struct wmi_set_pcp_channel_cmd, 4);

/* WMI_SW_TX_REQ_CMDID (0x82b). */
struct wmi_sw_tx_req_cmd {
    union {
        struct {
            u8  dst_mac[WMI_MAC_LEN];          /* 0x00 */
            u16 len;                           /* 0x06 */
        };
        u16 dst_mac16[3];                      /* 0x00: журнал */
        struct {
            u32 dst_mac_lo;                    /* 0x00: журнал */
            u16 dst_mac_hi;                    /* 0x04 */
        };
    };
    u8  payload[];                             /* 0x08 */
};
WMI_OFF(struct wmi_sw_tx_req_cmd, len, 0x06);
WMI_OFF(struct wmi_sw_tx_req_cmd, payload, 0x08);

/* WMI_BF_TRIG_CMDID (0x83a). 6.2: bf_type и cid — слова, MAC — с +0xc (vendor
 * 0x8fc12c ld_s [r13], 0x8fc158 ld_s [r13,4], 0x8fc170 add r1,r13,0xc); в драйвере — байты
 * {bf_type, cid, dst_mac[6]}. */
struct wmi_bf_trig_cmd {
    u32 bf_type;                               /* 0x00: 0 — по MAC, 1 — по cid */
    union {
        u32 cid32;                             /* 0x04: журнал */
        u8  cid;                               /* 0x04 */
    };
    u32 rsv_08;                                /* 0x08 */
    union {
        struct {
            u8 dst_mac[WMI_MAC_LEN];           /* 0x0c */
            u8 reserved[2];                    /* 0x12 */
        };
        struct {
            u32 dst_mac_lo;                    /* 0x0c: журнал */
            u16 dst_mac_hi;                    /* 0x10 */
        };
    };
};
WMI_OFF(struct wmi_bf_trig_cmd, dst_mac, 0x0c);
WMI_OFF(struct wmi_bf_trig_cmd, dst_mac_hi, 0x10);

/* WMI_LINK_MAINTAIN_CFG_WRITE_CMDID (0x842) / _READ_CMDID (0x843). 6.2: lm_cfg — 0x24 Б
 * (9 слов, = struct ll_cid_cfg include/link_loss.h); в драйвере ещё disconnect_timeout. */
#define WMI_LM_CFG_LEN 0x24
struct wmi_link_maintain_cfg_write_cmd {
    u32 cfg_type;                              /* 0x00: 0..3 — набор, 4 — из команды */
    u32 cid;                                   /* 0x04: 0xffffffff — все */
    u32 lm_cfg[WMI_LM_CFG_LEN / 4];            /* 0x08 */
};
WMI_SIZE(struct wmi_link_maintain_cfg_write_cmd, 0x2c);

struct wmi_link_maintain_cfg_read_cmd {
    u32 cid;                                   /* 0x00 */
};

/* WMI_SET_SECTORS_CMDID (0x849): только 6.2. Слова 1/2: биты 4..18 — сектор, 0..3 — RF
 * (LMAC 0x05). */
struct wmi_set_sectors_cmd {
    u32 cid;                                   /* 0x00 */
    u32 sector_rf[2];                          /* 0x04 */
};
WMI_SIZE(struct wmi_set_sectors_cmd, 0xc);

/* WMI_RF_MGMT_CMDID (0x853). */
struct wmi_rf_mgmt_cmd {
    u32 rf_mgmt_type;                          /* 0x00: 0 — W_DISABLE, 1 — W_ENABLE, 2 — статус */
};

/* WMI_RF_XPM_READ_CMDID (0x856) / WMI_RF_XPM_WRITE_CMDID (0x857). */
struct wmi_rf_xpm_read_cmd {
    u8  rf_id;                                 /* 0x00 */
    u8  reserved[3];                           /* 0x01 */
    u32 xpm_bit_address;                       /* 0x04 */
    u32 num_bytes;                             /* 0x08 */
};
WMI_SIZE(struct wmi_rf_xpm_read_cmd, 0xc);

struct wmi_rf_xpm_write_cmd {
    u8  rf_id;                                 /* 0x00 */
    u8  reserved0[3];                          /* 0x01 */
    u32 xpm_bit_address;                       /* 0x04 */
    u32 num_bytes;                             /* 0x08 */
    u8  verify;                                /* 0x0c */
    u8  reserved1[3];                          /* 0x0d */
    u8  data_bytes[];                          /* 0x10 */
};
WMI_OFF(struct wmi_rf_xpm_write_cmd, verify, 0x0c);
WMI_OFF(struct wmi_rf_xpm_write_cmd, data_bytes, 0x10);

/* WMI_RF_PWR_ON_DELAY_CMDID (0x85d). */
struct wmi_rf_pwr_on_delay_cmd {
    u16 down_delay_usec;                       /* 0x00 → rf_pwr_on_hold */
    u16 up_delay_usec;                         /* 0x02 → rf_pwr_on_extra_delay */
};
WMI_SIZE(struct wmi_rf_pwr_on_delay_cmd, 4);

/* WMI_SET_HIGH_POWER_TABLE_PARAMS_CMDID (0x85e): vendor копирует его кусками полей
 * (rf_cfg_load_800d04). */
struct wmi_set_high_power_table_params_cmd {
    u8  tx_dtype_temp[3];                      /* 0x00 */
    u8  reserved0;                             /* 0x03 */
    u32 tx_dtype_conf[4];                      /* 0x04 */
    u8  tx_etype_temp[3];                      /* 0x14 */
    u8  reserved1;                             /* 0x17 */
    u32 tx_etype_conf[8];                      /* 0x18 */
    u8  rx_dtype_temp[3];                      /* 0x38 */
    u8  reserved2;                             /* 0x3b */
    u32 rx_dtype_conf[4];                      /* 0x3c */
    u8  rx_etype_temp[3];                      /* 0x4c */
    u8  reserved3;                             /* 0x4f */
    u32 rx_etype_conf[8];                      /* 0x50 */
    u8  rx_2_tx_temp[3];                       /* 0x70 */
    u8  reserved4;                             /* 0x73 */
    s8  rx_2_tx_offs[4];                       /* 0x74 */
};
WMI_OFF(struct wmi_set_high_power_table_params_cmd, tx_etype_conf, 0x18);
WMI_OFF(struct wmi_set_high_power_table_params_cmd, rx_etype_conf, 0x50);
WMI_OFF(struct wmi_set_high_power_table_params_cmd, rx_2_tx_offs, 0x74);
WMI_SIZE(struct wmi_set_high_power_table_params_cmd, 0x78);

/* WMI_FIXED_SCHEDULING_UL_CONFIG_CMDID (0x85f). */
struct wmi_fixed_scheduling_ul_config_cmd {
    s8  mcs;                                   /* 0x00: −1 — все записи */
    u8  rd_count_per_slot;                     /* 0x01 */
    u8  reserved[2];                           /* 0x02 */
};
WMI_SIZE(struct wmi_fixed_scheduling_ul_config_cmd, 4);

/* WMI_NOTIFY_REQ_CMDID (0x863). */
struct wmi_notify_req_cmd {
    u8  cid;                                   /* 0x00 */
    u8  year;                                  /* 0x01 */
    u8  month;                                 /* 0x02 */
    u8  day;                                   /* 0x03 */
    u32 interval_usec;                         /* 0x04 */
    u8  hour;                                  /* 0x08 */
    u8  minute;                                /* 0x09 */
    u8  second;                                /* 0x0a */
    u8  miliseconds;                           /* 0x0b */
};
WMI_SIZE(struct wmi_notify_req_cmd, 0xc);

/* WMI_VRING_SWITCH_TIMING_CONFIG_CMDID (0x868). */
struct wmi_vring_switch_timing_config_cmd {
    u32 interval_usec;                         /* 0x00 */
    u32 idle_th_usec;                          /* 0x04 */
};
WMI_SIZE(struct wmi_vring_switch_timing_config_cmd, 8);

/* WMI_UNIT_TEST_CMDID (0x900): модуль, подтип, параметры (fw/wmi.c). */
struct wmi_ut_cmd {
    u16 module_id;                             /* 0x00 */
    u16 subtype_id;                            /* 0x02 */
    union {
        u32 place_holder[6];                   /* 0x04 */
        u16 place_holder16[12];                /* 0x04: полусловами */
    };
};
WMI_SIZE(struct wmi_ut_cmd, 0x1c);

/* Отладочная команда 0xfff (orig_fract, 0x8dc4d8): только 6.2; имена — из журнала vendor
 * «0xfff: addr:%08x val:%08x mask:%08x» (по смыслу: число шагов, шаг, флаги). */
struct wmi_dbg_fff_cmd {
    u32 rsv_00;                                /* 0x00 */
    u32 addr;                                  /* 0x04: число шагов n */
    u32 val;                                   /* 0x08: шаг */
    u32 mask;                                  /* 0x0c: бит 1 — вверх, бит 0 — вниз, биты 8.. — пауза */
};
WMI_SIZE(struct wmi_dbg_fff_cmd, 0x10);

/* WMI_P2P_CFG_CMDID (0x910). */
struct wmi_p2p_cfg_cmd {
    u8  discovery_mode;                        /* 0x00: enum wmi_discovery_mode */
    u8  channel;                               /* 0x01 */
    u16 bcon_interval;                         /* 0x02 */
};
WMI_SIZE(struct wmi_p2p_cfg_cmd, 4);

/* WMI_PORT_ALLOCATE_CMDID (0x911). */
struct wmi_port_allocate_cmd {
    u8  mac[WMI_MAC_LEN];                      /* 0x00 */
    u8  port_role;                             /* 0x06 */
    u8  mid;                                   /* 0x07 */
};
WMI_SIZE(struct wmi_port_allocate_cmd, 8);

/* WMI_POWER_MGMT_CFG_CMDID (0x913). */
struct wmi_power_mgmt_cfg_cmd {
    u8  power_source;                          /* 0x00 */
    u8  reserved[3];                           /* 0x01 */
};

/* WMI_PCP_START_CMDID (0x918). */
struct wmi_pcp_start_cmd {
    u16 bcon_interval;                         /* 0x00 */
    u8  pcp_max_assoc_sta;                     /* 0x02 */
    u8  hidden_ssid;                           /* 0x03 */
    u8  is_go;                                 /* 0x04 */
    u8  edmg_channel;                          /* 0x05: 6.2 не читает */
    u8  raw_mode;                              /* 0x06: 6.2 не читает */
    u8  reserved[3];                           /* 0x07 */
    u8  abft_len;                              /* 0x0a */
    u8  ap_sme_offload_mode;                   /* 0x0b */
    u8  network_type;                          /* 0x0c */
    u8  channel;                               /* 0x0d */
    u8  disable_sec_offload;                   /* 0x0e */
    u8  disable_sec;                           /* 0x0f */
};
WMI_OFF(struct wmi_pcp_start_cmd, abft_len, 0x0a);
WMI_SIZE(struct wmi_pcp_start_cmd, 0x10);

/* WMI_PS_DEV_PROFILE_CFG_CMDID (0x91c). */
struct wmi_ps_dev_profile_cfg_cmd {
    u8  ps_profile;                            /* 0x00 */
    u8  reserved[3];                           /* 0x01 */
};

/* WMI_RS_CFG_CMDID (0x921). back_failure_mask / mcs_en_vec — u32 по +0x1e/+0x22 вложенной
 * структуры (кратно лишь 2): vendor читает их полусловами — здесь u16[2]. */
struct wmi_rs_cfg {
    u8  per_threshold[WMI_NUM_MCS];            /* 0x00 */
    u8  min_frame_cnt[WMI_NUM_MCS];            /* 0x0d */
    u8  stop_th;                               /* 0x1a */
    u8  mcs1_fail_th;                          /* 0x1b */
    u8  max_back_failure_th;                   /* 0x1c */
    u8  dbg_disable_internal_trigger;          /* 0x1d */
    u16 back_failure_mask[2];                  /* 0x1e: u32 */
    u16 mcs_en_vec[2];                         /* 0x22: u32 */
};
WMI_OFF(struct wmi_rs_cfg, back_failure_mask, 0x1e);
WMI_SIZE(struct wmi_rs_cfg, 0x26);

struct wmi_rs_cfg_cmd {
    u8  cid;                                   /* 0x00 */
    u8  rs_enable;                             /* 0x01 */
    struct wmi_rs_cfg rs_cfg;                  /* 0x02 */
};
WMI_OFF(struct wmi_rs_cfg_cmd, rs_cfg.stop_th, 0x1c);
WMI_OFF(struct wmi_rs_cfg_cmd, rs_cfg.back_failure_mask, 0x20);
WMI_SIZE(struct wmi_rs_cfg_cmd, 0x28);

/* WMI_GET_DETAILED_RS_RES_CMDID (0x922). */
struct wmi_get_detailed_rs_res_cmd {
    u8  cid;                                   /* 0x00 */
    u8  reserved[3];                           /* 0x01 */
};


/* WMI_BRP_SET_ANT_LIMIT_CMDID (0x924). */
struct wmi_brp_set_ant_limit_cmd {
    u8  cid;                                   /* 0x00 */
    u8  limit_mode;                            /* 0x01: 0..2 */
    u8  ant_limit;                             /* 0x02 */
    u8  reserved;                              /* 0x03 */
};
WMI_SIZE(struct wmi_brp_set_ant_limit_cmd, 4);

/* WMI_SET_MGMT_RETRY_LIMIT_CMDID (0x930). */
struct wmi_set_mgmt_retry_limit_cmd {
    u8  mgmt_retry_limit;                      /* 0x00 */
    u8  reserved[3];                           /* 0x01 */
};

/* WMI_NEW_STA_CMDID (0x935). */
struct wmi_new_sta_cmd {
    u8  dst_mac[WMI_MAC_LEN];                  /* 0x00 */
    u8  aid;                                   /* 0x06 */
};




/* RF-сектор (struct wmi_rf_sector_info, 24 Б): шесть слов строки сектора RFC. */
struct wmi_rf_sector_info {
    u32 psh_hi;                                /* 0x00 */
    u32 psh_lo;                                /* 0x04 */
    u32 etype0;                                /* 0x08 */
    u32 etype1;                                /* 0x0c */
    u32 etype2;                                /* 0x10 */
    u32 dtype_swch_off;                        /* 0x14 */
};
WMI_SIZE(struct wmi_rf_sector_info, 0x18);
#define WMI_MAX_RF_MODULES_NUM 8

/* WMI_GET_RF_SECTOR_PARAMS_CMDID (0x9a0) / WMI_SET_RF_SECTOR_PARAMS_CMDID (0x9a1). */
struct wmi_get_rf_sector_params_cmd {
    u16 sector_idx;                            /* 0x00 */
    u8  sector_type;                           /* 0x02: 0 — RX, 1 — TX */
    u8  rf_modules_vec;                        /* 0x03 */
};
WMI_SIZE(struct wmi_get_rf_sector_params_cmd, 4);

struct wmi_set_rf_sector_params_cmd {
    u16 sector_idx;                            /* 0x00 */
    u8  sector_type;                           /* 0x02 */
    u8  rf_modules_vec;                        /* 0x03 */
    struct wmi_rf_sector_info sectors_info[WMI_MAX_RF_MODULES_NUM];   /* 0x04 */
};
WMI_SIZE(struct wmi_set_rf_sector_params_cmd, 0xc4);

/* WMI_GET_SELECTED_RF_SECTOR_INDEX_CMDID (0x9a2) / WMI_SET_… (0x9a3). */
struct wmi_get_selected_rf_sector_index_cmd {
    u8  cid;                                   /* 0x00 */
    u8  sector_type;                           /* 0x01 */
    u8  reserved[2];                           /* 0x02 */
};
WMI_SIZE(struct wmi_get_selected_rf_sector_index_cmd, 4);

struct wmi_set_selected_rf_sector_index_cmd {
    u8  cid;                                   /* 0x00 */
    u8  sector_type;                           /* 0x01 */
    u16 sector_idx;                            /* 0x02: 0..0x7f или 0xffff */
};
WMI_SIZE(struct wmi_set_selected_rf_sector_index_cmd, 4);

/* WMI_PRIO_TX_SECTORS_ORDER_CMDID (0x9a5) / _NUMBER_CMDID (0x9a6) / _SET_DEFAULT_CFG_CMDID
 * (0x9a7). */
struct wmi_prio_tx_sectors_order_cmd {
    u8  tx_sectors_priority_array[0x40];       /* 0x00: MAX_NUM_OF_SECTORS */
    u8  sector_sweep_type;                     /* 0x40: < 3 */
    u8  cid;                                   /* 0x41: < 9 */
    u8  reserved[2];                           /* 0x42 */
};
WMI_SIZE(struct wmi_prio_tx_sectors_order_cmd, 0x44);

struct wmi_prio_tx_sectors_number_cmd {
    u8  beacon_number_of_sectors;              /* 0x00 */
    u8  txss_number_of_sectors;                /* 0x01 */
    u8  cid;                                   /* 0x02 */
    u8  reserved;                              /* 0x03 */
};
WMI_SIZE(struct wmi_prio_tx_sectors_number_cmd, 4);

struct wmi_prio_tx_sectors_set_default_cfg_cmd {
    u8  sector_sweep_type;                     /* 0x00 */
    u8  cid;                                   /* 0x01 */
    u8  reserved[2];                           /* 0x02 */
};

/* WMI_SPARRAW_TDMA_CFG_CMDID (0x0f10, SparRAW): простой TDMA точки (fw/tdma.c) — включён по умолчанию,
 * порог по умолчанию TDMA_MIN_STA. Ответного события нет. Хост: tools/tdma_ctl.sh. */
#define WMI_SPARRAW_TDMA_CFG_CMDID 0x0f10u
struct wmi_sparraw_tdma_cfg_cmd {
    u8  enable;                                /* 0x00: 0 — выключить (весь DTI — CBAP), иначе включить */
    u8  min_sta;                               /* 0x01: порог (станций); 0 — по умолчанию */
    u8  reserved[2];                           /* 0x02 */
};
WMI_SIZE(struct wmi_sparraw_tdma_cfg_cmd, 4);

/* WMI_SCHEDULING_SCHEME_CMDID (0xa01; у vendor — ESE_CFG). Слот — 20 Б. */
struct wmi_sched_scheme_slot {
    u32 tbtt_offset;                           /* 0x00 */
    u8  flags;                                 /* 0x04 */
    u8  type;                                  /* 0x05 */
    u16 duration;                              /* 0x06 */
    u16 tx_op;                                 /* 0x08 */
    u16 period;                                /* 0x0a */
    u8  num_of_blocks;                         /* 0x0c */
    u8  idle_period;                           /* 0x0d */
    u8  src_aid;                               /* 0x0e */
    u8  dest_aid;                              /* 0x0f */
    u32 reserved;                              /* 0x10 */
};
WMI_SIZE(struct wmi_sched_scheme_slot, 0x14);

#define WMI_SCHED_MAX_ALLOCS_PER_CMD 4u                /* как в драйвере wil6210 (wmi.h) */
struct wmi_scheduling_scheme_cmd {
    u8  serial_num;                            /* 0x00 */
    u8  ese_advertisment;                      /* 0x01: строить Allocation IE */
    u16 flags;                                 /* 0x02 */
    u8  num_allocs;                            /* 0x04 */
    u8  reserved[3];                           /* 0x05 */
    u32 start_tbtt[2];                         /* 0x08: u64 */
    struct wmi_sched_scheme_slot allocs[];     /* 0x10: до WMI_SCHED_MAX_ALLOCS_PER_CMD */
};
WMI_OFF(struct wmi_scheduling_scheme_cmd, allocs, 0x10);

/* WMI_FIXED_SCHEDULING_CONFIG_CMDID (0xa02). */
struct wmi_map_mcs_to_schd_params {
    u8  mcs;                                   /* 0x00: индекс записи (vendor не проверяет) */
    u8  time_in_usec_before_initiate_tx;       /* 0x01 */
    u8  rd_enabled;                            /* 0x02 */
    u8  reserved;                              /* 0x03 */
    u16 time_in_usec_to_stop_vring;            /* 0x04 */
    u16 flush_to_in_usec;                      /* 0x06 */
    u32 mac_buff_size_in_bytes;                /* 0x08 */
};
WMI_SIZE(struct wmi_map_mcs_to_schd_params, 0xc);

struct wmi_fixed_scheduling_config_cmd {
    struct wmi_map_mcs_to_schd_params mcs_to_schd_params_map[WMI_NUM_MCS];   /* 0x00 */
    u16 max_sta_rd_ppdu_duration_in_usec;      /* 0x9c */
    u16 max_sta_grant_ppdu_duration_in_usec;   /* 0x9e */
    u16 assoc_slot_duration_in_usec;           /* 0xa0 */
    u16 virtual_slot_duration_in_usec;         /* 0xa2 */
    u8  number_of_ap_slots_for_initiate_grant; /* 0xa4 */
    u8  reserved[3];                           /* 0xa5 */
};
WMI_OFF(struct wmi_fixed_scheduling_config_cmd, max_sta_rd_ppdu_duration_in_usec, 0x9c);
WMI_OFF(struct wmi_fixed_scheduling_config_cmd, number_of_ap_slots_for_initiate_grant, 0xa4);
WMI_SIZE(struct wmi_fixed_scheduling_config_cmd, 0xa8);

/* WMI_SET_MULTI_DIRECTED_OMNIS_CONFIG_CMDID (0xa04). */
struct wmi_set_multi_directed_omnis_config_cmd {
    u8  dest_ap_num_directed_omnis;            /* 0x00 */
    u8  reserved[3];                           /* 0x01 */
};

/* WMI_SET_CCA_INDICATIONS_BI_AVG_NUM_CMDID (0xa08). */
struct wmi_set_cca_indications_bi_avg_num_cmd {
    u8  bi_number;                             /* 0x00 */
    u8  reserved[3];                           /* 0x01 */
};

/* WMI_SET_GRANT_MCS_CMDID (0xa0e). */
struct wmi_set_grant_mcs_cmd {
    u8  mcs;                                   /* 0x00 */
    u8  reserved[3];                           /* 0x01 */
};

/* WMI_SET_MAC_ADDRESS_CMDID (0xf003). */
struct wmi_set_mac_address_cmd {
    u8  mac[WMI_MAC_LEN];                      /* 0x00 */
    u8  reserved[2];                           /* 0x06 */
};

/* WMI_SET_PASSPHRASE_CMDID (0xf049). */
struct wmi_set_passphrase_cmd {
    u8  ssid[WMI_MAX_SSID_LEN];                /* 0x00 */
    u8  passphrase[64];                        /* 0x20: WMI_PASSPHRASE_LEN */
    u8  ssid_len;                              /* 0x60 */
    u8  passphrase_len;                        /* 0x61 */
};
WMI_OFF(struct wmi_set_passphrase_cmd, ssid_len, 0x60);
WMI_SIZE(struct wmi_set_passphrase_cmd, 0x62);

/* WMI_PMC_CMDID (0xf04f). */
struct wmi_pmc_cmd {
    u8  op;                                    /* 0x00: 0 — кольцо, 1 — сброс */
    u8  reserved;                              /* 0x01 */
    u16 ring_size;                             /* 0x02 */
    u32 mem_base[2];                           /* 0x04: u64 lo, hi */
};
WMI_SIZE(struct wmi_pmc_cmd, 0xc);

/* ======================= события ======================= */

/* WMI_DISCONNECT_EVENTID (0x1003). */
struct wmi_disconnect_event {
    u16 protocol_reason_status;                /* 0x00 */
    u8  bssid[WMI_MAC_LEN];                    /* 0x02 */
    u8  disconnect_reason;                     /* 0x08: enum wmi_disconnect_reason */
    u8  assoc_resp_len;                        /* 0x09 */
};
WMI_SIZE(struct wmi_disconnect_event, 0xa);

/* WMI_SCAN_COMPLETE_EVENTID (0x100a) {status}; то же одно слово — WMI_ECHO_RSP (0x1803),
 * WMI_PS_DEV_PROFILE_CFG (0x191c), WMI_GET_BASEBAND_TYPE (0x1867), WMI_PCP_FACTOR (0x191a). */
struct wmi_word_event {
    u32 value;                                 /* 0x00 */
};

/* WMI_CFG_RX_CHAIN_DONE_EVENTID (0x1820). */
struct wmi_cfg_rx_chain_done_event {
    u32 rx_ring_tail_ptr;                      /* 0x00 */
    u32 status;                                /* 0x04: 1 — SUCCESS */
};
WMI_SIZE(struct wmi_cfg_rx_chain_done_event, 8);

/* WMI_TEMP_SENSE_DONE_EVENTID (0x180e). 6.2: 36 Б — BB и 8 RF (в драйвере одно RF). */
struct wmi_temp_sense_done_event {
    u32 baseband_t1000;                        /* 0x00 */
    u32 rf_t1000[8];                           /* 0x04 */
};
WMI_SIZE(struct wmi_temp_sense_done_event, 0x24);

/* WMI_GET_PCP_CHANNEL_EVENTID (0x182a). */
struct wmi_get_pcp_channel_event {
    u8  channel;                               /* 0x00 */
    u8  reserved[3];                           /* 0x01 */
};

/* WMI_LINK_MAINTAIN_CFG_WRITE_DONE_EVENTID (0x1842) / _READ_DONE_EVENTID (0x1843). */
struct wmi_link_maintain_cfg_read_done_event {
    u32 cid;                                   /* 0x00 */
    u32 status;                                /* 0x04 */
    u32 lm_cfg[WMI_LM_CFG_LEN / 4];            /* 0x08 */
};
WMI_SIZE(struct wmi_link_maintain_cfg_read_done_event, 0x2c);

struct wmi_link_maintain_cfg_write_done_event {
    u32 cid;                                   /* 0x00 */
    u32 status;                                /* 0x04 */
};
WMI_SIZE(struct wmi_link_maintain_cfg_write_done_event, 8);

/* WMI_RF_XPM_READ_RESULT_EVENTID (0x1856). */
struct wmi_rf_xpm_read_result_event {
    u8  status;                                /* 0x00 */
    u8  reserved[3];                           /* 0x01 */
    u8  data_bytes[];                          /* 0x04 */
};
WMI_OFF(struct wmi_rf_xpm_read_result_event, data_bytes, 0x04);

/* WMI_SET_SILENT_RSSI_TABLE_DONE_EVENTID (0x185c). */
struct wmi_set_silent_rssi_table_done_event {
    u32 status;                                /* 0x00 */
    u32 table;                                 /* 0x04 */
};
WMI_SIZE(struct wmi_set_silent_rssi_table_done_event, 8);

/* WMI_NOTIFY_REQ_DONE_EVENTID (0x1863). tsf — u64 по +4: два слова. */
struct wmi_notify_req_done_event {
    u32 status;                                /* 0x00: статус BF */
    u32 tsf[2];                                /* 0x04: lo, hi */
    s8  rssi;                                  /* 0x0c */
    u8  tx_mode;                               /* 0x0d */
    u8  reserved0[2];                          /* 0x0e */
    u32 tx_tpt;                                /* 0x10 */
    u32 tx_goodput;                            /* 0x14 */
    u32 rx_goodput;                            /* 0x18 */
    u16 bf_mcs;                                /* 0x1c */
    u16 my_rx_sector;                          /* 0x1e */
    u16 my_tx_sector;                          /* 0x20 */
    u16 other_rx_sector;                       /* 0x22 */
    u16 other_tx_sector;                       /* 0x24 */
    u16 range;                                 /* 0x26 */
    u8  sqi;                                   /* 0x28 */
    u8  reserved[3];                           /* 0x29 */
};
WMI_OFF(struct wmi_notify_req_done_event, tx_tpt, 0x10);
WMI_OFF(struct wmi_notify_req_done_event, range, 0x26);
WMI_SIZE(struct wmi_notify_req_done_event, 0x2c);

/* WMI_GET_STATUS_DONE_EVENTID (0x1864). */
struct wmi_get_status_done_event {
    u32 is_associated;                         /* 0x00 */
    u8  cid;                                   /* 0x04 */
    u8  reserved0[3];                          /* 0x05 */
    u8  bssid[WMI_MAC_LEN];                    /* 0x08 */
    u8  channel;                               /* 0x0e */
    u8  reserved1;                             /* 0x0f */
    u8  network_type;                          /* 0x10 */
    u8  reserved2[3];                          /* 0x11 */
    u32 ssid_len;                              /* 0x14 */
    u8  ssid[WMI_MAX_SSID_LEN];                /* 0x18 */
    u32 rf_status;                             /* 0x38 */
    u32 is_secured;                            /* 0x3c */
};
WMI_OFF(struct wmi_get_status_done_event, ssid_len, 0x14);
WMI_OFF(struct wmi_get_status_done_event, rf_status, 0x38);
WMI_SIZE(struct wmi_get_status_done_event, 0x40);

/* WMI_GET_RF_STATUS_EVENTID (0x1866). */
struct wmi_get_rf_status_event {
    u32 rf_type;                               /* 0x00 */
    u32 attached_rf_vector;                    /* 0x04 */
    u32 enabled_rf_vector;                     /* 0x08 */
    u8  rf_status[32];                         /* 0x0c */
    u32 board_file_rf_type;                    /* 0x2c */
    u32 board_file_platform_type;              /* 0x30 */
    u32 board_file_version;                    /* 0x34 */
    u32 enabled_xif_vector;                    /* 0x38 */
    u32 reserved;                              /* 0x3c */
};
WMI_OFF(struct wmi_get_rf_status_event, board_file_rf_type, 0x2c);
WMI_SIZE(struct wmi_get_rf_status_event, 0x40);

/* WMI_GET_MGMT_RETRY_LIMIT_EVENTID (0x1931). */
struct wmi_get_mgmt_retry_limit_event {
    u8  mgmt_retry_limit;                      /* 0x00 */
    u8  reserved[3];                           /* 0x01 */
};




/* WMI_RS_CFG_DONE_EVENTID (0x1921). */
struct wmi_rs_cfg_done_event {
    u8  cid;                                   /* 0x00 */
    u8  status;                                /* 0x01 */
    u8  reserved[2];                           /* 0x02 */
};

/* WMI_GET_DETAILED_RS_RES_EVENTID (0x1922): rs_results — 0x1f Б (копия статистики MCS
 * lm_if), tsf — u32 по +0x1a вложенной структуры (кратно лишь 2): байты. */
struct wmi_rs_results {
    u8  num_of_tx_pkt[WMI_NUM_MCS];            /* 0x00 */
    u8  num_of_non_acked_pkt[WMI_NUM_MCS];     /* 0x0d */
    u8  tsf[4];                                /* 0x1a */
    u8  mcs;                                   /* 0x1e */
};
WMI_SIZE(struct wmi_rs_results, 0x1f);

struct wmi_get_detailed_rs_res_event {
    u8  cid;                                   /* 0x00 */
    u8  status;                                /* 0x01: 1 — нет данных */
    struct wmi_rs_results rs_results;          /* 0x02 */
    u8  reserved[3];                           /* 0x21 */
};
WMI_SIZE(struct wmi_get_detailed_rs_res_event, 0x24);

/* WMI_GET_RF_SECTOR_PARAMS_DONE_EVENTID (0x19a0). */
struct wmi_get_rf_sector_params_done_event {
    u8  status;                                /* 0x00 */
    u8  reserved[7];                           /* 0x01 */
    u32 tsf[2];                                /* 0x08: u64 */
    struct wmi_rf_sector_info sectors_info[WMI_MAX_RF_MODULES_NUM];   /* 0x10 */
};
WMI_OFF(struct wmi_get_rf_sector_params_done_event, sectors_info, 0x10);
WMI_SIZE(struct wmi_get_rf_sector_params_done_event, 0xd0);

/* WMI_GET_SELECTED_RF_SECTOR_INDEX_DONE_EVENTID (0x19a2). */
struct wmi_get_selected_rf_sector_index_done_event {
    u16 sector_idx;                            /* 0x00 */
    u8  status;                                /* 0x02 */
    u8  reserved[5];                           /* 0x03 */
    u32 tsf[2];                                /* 0x08: u64 */
};
WMI_SIZE(struct wmi_get_selected_rf_sector_index_done_event, 0x10);

/* WMI_SCHEDULING_SCHEME_EVENTID (0x1a01). */
struct wmi_scheduling_scheme_event {
    u8  status;                                /* 0x00 */
    u8  serial_num;                            /* 0x01 */
    u8  failure_type;                          /* 0x02 */
    u8  reserved[1];                           /* 0x03 */
};
WMI_SIZE(struct wmi_scheduling_scheme_event, 4);

/* WMI_GET_ASSOC_LIST_RES_EVENTID (0x1a06). */
struct wmi_assoc_sta_info {
    u8  mac[WMI_MAC_LEN];                      /* 0x00 */
    u8  omni_index_address;                    /* 0x06: 6.2 — RX-сектор соединения */
    u8  reserved;                              /* 0x07 */
};
WMI_SIZE(struct wmi_assoc_sta_info, 8);

struct wmi_get_assoc_list_res_event {
    struct wmi_assoc_sta_info assoc_sta_list[SPARRAW_MAX_STA];   /* 0x00: WMI_GET_ASSOC_LIST_SIZE */
    u8  count;                                 /* 0x40 */
    u8  reserved[3];                           /* 0x41 */
};
WMI_OFF(struct wmi_get_assoc_list_res_event, count, 0x40);
WMI_SIZE(struct wmi_get_assoc_list_res_event, 0x44);

/* WMI_GET_CCA_INDICATIONS_EVENTID (0x1a07). */
struct wmi_get_cca_indications_event {
    u8  status;                                /* 0x00 */
    u8  cca_ed_percent;                        /* 0x01 */
    u8  cca_ed_avg_percent;                    /* 0x02 */
    u8  nav_percent;                           /* 0x03 */
    u8  nav_avg_percent;                       /* 0x04 */
    u8  reserved[3];                           /* 0x05 */
};
WMI_SIZE(struct wmi_get_cca_indications_event, 8);

/* WMI_MAC_ADDR_RESP_EVENTID (0x9003). Журнал читает MAC словом + полусловом. */
struct wmi_mac_addr_resp_event {
    union {
        struct {
            u8 mac[WMI_MAC_LEN];               /* 0x00 */
            u8 auth_mode;                      /* 0x06 */
            u8 crypt_mode;                     /* 0x07 */
        };
        struct {
            u32 mac_lo;                        /* 0x00 */
            u16 mac_hi;                        /* 0x04 */
        };
    };
    u32 offload_mode;                          /* 0x08 */
};
WMI_OFF(struct wmi_mac_addr_resp_event, auth_mode, 0x06);
WMI_SIZE(struct wmi_mac_addr_resp_event, 0xc);

/* WMI_FW_VER_EVENTID (0x9004). */
struct wmi_fw_ver_event {
    u32 fw_major;                              /* 0x00 */
    u32 fw_minor;                              /* 0x04 */
    u32 fw_subminor;                           /* 0x08 */
    u32 fw_build;                              /* 0x0c */
    u32 hour;                                  /* 0x10 */
    u32 minute;                                /* 0x14 */
    u32 second;                                /* 0x18 */
    u32 day;                                   /* 0x1c */
    u32 month;                                 /* 0x20 */
    u32 year;                                  /* 0x24 */
    u32 bl_major;                              /* 0x28 */
    u32 bl_minor;                              /* 0x2c */
    u32 bl_subminor;                           /* 0x30 */
    u32 bl_build;                              /* 0x34 */
    u8  fw_capabilities_len;                   /* 0x38 */
    u8  reserved[3];                           /* 0x39 */
    u32 fw_capabilities[];                     /* 0x3c */
};
WMI_OFF(struct wmi_fw_ver_event, bl_major, 0x28);
WMI_OFF(struct wmi_fw_ver_event, fw_capabilities, 0x3c);
WMI_SIZE(struct wmi_fw_ver_event, 0x3c);

/* WMI_COMMAND_NOT_SUPPORTED_EVENTID (0xffff). */
struct wmi_command_not_supported_event {
    u8  mid;                                   /* 0x00 */
    u8  reserved0;                             /* 0x01 */
    u16 command_id;                            /* 0x02 */
    u16 command_subtype;                       /* 0x04 */
    u16 reserved1;                             /* 0x06 */
};
WMI_SIZE(struct wmi_command_not_supported_event, 8);

/* ======================= объекты обработчиков ======================= */

struct wmi_mbox;                               /* include/mbox.h */
struct rm_req;                                 /* include/radio_mgr.h */

/* Запросы GET/SET_RF_SECTOR_PARAMS, ждущие радио (wmi_handler_get/set_rf_sector_params,
 * fw/wmi_h_bf.c): копия команды, ящик ответа, запрос радио-менеджера (≠ 0 — занят). В DCCM
 * подряд: get — 0x80483c (0xc Б), set — 0x804848 (0xcc Б); в образе нули, первый запрос
 * обнуляет объект (диспетчер, wmi_rf_sector_get_first / _set_first). Поля volatile — vendor
 * перечитывает их на каждом обращении (прежде — W()/H()/B()). */
struct wmi_rf_sector_get_req {
    volatile struct wmi_get_rf_sector_params_cmd req;   /* 0x00 */
    struct wmi_mbox *volatile mbox;            /* 0x04 */
    struct rm_req *volatile radio;             /* 0x08 */
};
WMI_OFF(struct wmi_rf_sector_get_req, radio, 0x08);
WMI_SIZE(struct wmi_rf_sector_get_req, 0xc);

struct wmi_rf_sector_set_req {
    volatile struct wmi_set_rf_sector_params_cmd req;   /* 0x00 */
    struct wmi_mbox *volatile mbox;            /* 0xc4 */
    struct rm_req *volatile radio;             /* 0xc8 */
};
WMI_OFF(struct wmi_rf_sector_set_req, mbox, 0xc4);
WMI_SIZE(struct wmi_rf_sector_set_req, 0xcc);

extern struct wmi_rf_sector_get_req wmi_rf_sector_get;   /* 0x80483c */
extern struct wmi_rf_sector_set_req wmi_rf_sector_set;   /* 0x804848 */

/* ======================= BA (fw/ba.c) ======================= */

/* WMI_VRING_BA_EN_CMDID. */
struct wmi_vring_ba_en_cmd {
    u8  ringid;                                /* 0x00 */
    u8  agg_max_wsize;                         /* 0x01 */
    u16 ba_timeout;                            /* 0x02 */
    u8  amsdu;                                 /* 0x04 */
    u8  reserved[3];                           /* 0x05 */
};
WMI_SIZE(struct wmi_vring_ba_en_cmd, 8);

/* WMI_RCP_ADDBA_RESP_CMDID. */
struct wmi_rcp_addba_resp_cmd {
    u8  cidxtid;                               /* 0x00: [3:0] cid, [7:4] tid */
    u8  dialog_token;                          /* 0x01 */
    u16 status_code;                           /* 0x02 */
    u16 ba_param_set;                          /* 0x04: б0 — A-MSDU, [15:6] размер окна */
    u16 ba_timeout;                            /* 0x06 */
};
WMI_SIZE(struct wmi_rcp_addba_resp_cmd, 8);

/* WMI_RCP_DELBA_CMDID. */
struct wmi_rcp_delba_cmd {
    u8  cidxtid;                               /* 0x00 */
    u8  reserved;                              /* 0x01 */
    u16 reason;                                /* 0x02 */
};
WMI_SIZE(struct wmi_rcp_delba_cmd, 4);

/* WMI_ADDBA_REQ_EVENTID (0x1824). */
struct wmi_addba_req_event {
    u8  cidxtid;                               /* 0x00 */
    u8  dialog_token;                          /* 0x01 */
    u16 ba_param_set;                          /* 0x02 */
    u16 ba_timeout;                            /* 0x04 */
    u16 ba_seq_ctrl;                           /* 0x06 */
};
WMI_SIZE(struct wmi_addba_req_event, 8);

/* WMI_DELBA_EVENTID (0x1826). */
struct wmi_delba_event {
    u8  cidxtid;                               /* 0x00 */
    u8  from_initiator;                        /* 0x01 */
    u16 reason;                                /* 0x02 */
};
WMI_SIZE(struct wmi_delba_event, 4);

/* WMI_RCP_ADDBA_RESP_SENT_EVENTID (0x1825). */
struct wmi_rcp_addba_resp_sent_event {
    u8  cidxtid;                               /* 0x00 */
    u8  reserved;                              /* 0x01 */
    u16 status;                                /* 0x02 */
};
WMI_SIZE(struct wmi_rcp_addba_resp_sent_event, 4);





#endif
