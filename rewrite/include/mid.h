/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Запись mid — сетевой интерфейс fw (fw/mid.c, scan_mngr.c, wmi_cmd.c, wmi_h_*.c, …).
 * Записи — элементы пула mid_pool (vendor 0x804e7c, 1 × 0x2b0 с 0x804e90), открытые стоят в
 * списке mid_list (0x804e70); бит открытого mid — mid_open_bitmap ([gp,0xd5] = 0x800259).
 * Поиск по номеру — mid_list_by_mid_fw (0x8cc3dc). Внутри записи — объект BSS (+0x48,
 * struct mid_bss), объект discovery (+0x234, struct mid_disc; таблица методов 0x80070c) и
 * его find_mngr (+0x240). Раскладка — как у vendor 6.2, смещения закреплены _Static_assert;
 * ширины полей — как у доступов vendor. */
#ifndef MID_H
#define MID_H
#include "types.h"
#include "basic_sm.h"
#include "llist.h"
#include "mem_pool.h"
#include "scan_mngr.h"
#include "sched_scheme.h"
#include "sta_max.h"

#define MID_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

struct mid;
struct mid_disc;
struct rx_pkt;

/* Режим BSS (mid_bss.mode, bss_set_mode): у vendor 2 и 3 — «PCP/AP» (mid__state_is_2_or_3). */
enum {
    MID_MODE_STA = 1,
    MID_MODE_PCP = 2,                          /* validate_connect: «Connect is not allowed in PCP mode» */
    MID_MODE_AP  = 3,                          /* pcp_start_flow: network_type AP (0x10) */
};

/* Состояние BSS (mid_bss.state): 1 — поиск/умолчание (obj__set_field4_one 0x8c4ee4),
 * 2 — BSS активен (bss_set_active 0x8c4ec8: связь STA / PCP запущен). */
enum { MID_BSS_IDLE = 1, MID_BSS_ACTIVE = 2 };

/* Тело элемента DMG Capabilities (0x11 Б): своё (mid_bss.dmg_cap) и записи списка станций
 * PBSS (mid_bss.pbss, fw/pcp_ext.c). */
struct dmg_cap {
    u8 sta_addr[6];                            /* 0x00 */
    u8 aid;                                    /* 0x06: в списке PBSS 8 — запись свободна */
    u8 sta_cap[8];                             /* 0x07: DMG STA Capability Information */
    u8 pcp_cap[2];                             /* 0x0f: DMG PCP/AP Capability Information */
};
_Static_assert(sizeof(struct dmg_cap) == 0x11, "dmg_cap");

/* Блок IE хоста (WMI_SET_APPIE, fw/mgmt_tx.c, app_ies_*): {буфер, длина, тип кадра}. */
struct app_ies {
    u32 buf;                                   /* 0x00: буфер TX-пула или 0 */
    union {
        u16 len;                               /* 0x04: длина (app_ies__clear пишет stw, remove_tlv — ldw) */
        u32 len_w;                             /* 0x04: словом (app_ies__set_buffer, is_empty, walk_list) */
    };
    u32 frame_type;                            /* 0x08 */
};
_Static_assert(__builtin_offsetof(struct app_ies, len) == 4, "app_ies.len");
_Static_assert(sizeof(struct app_ies) == 0xc, "app_ies");

/* Итератор по списку IE блока (ie_iter__init 0x8e5de8 / app_ie__walk_list 0x8df404). */
struct ie_iter {
    struct app_ies *blk;                       /* 0x00 */
    u8 *cur;                                   /* 0x04: текущий IE, 0 — конец */
    u32 off;                                   /* 0x08: смещение следующего IE от начала */
};
_Static_assert(sizeof(struct ie_iter) == 0xc, "ie_iter");

/* Своя копия Wilocity VS старого формата (OUI 00:aa:6c, 12 Б; set_old_wilocity_vs
 * 0x8e69e0 пишет её в mid_bss+0x10e): раскладка — как struct wil_vs_old (ieee80211.h),
 * cap / net_type vendor пишет полусловами (stw). */
struct wil_vs_own {
    u8  oui[3];                                /* 0x00: 00 aa 6c */
    u8  rsv_03;
    u8  board[4];                              /* 0x04: plat_board_info->publish_id */
    u16 cap;                                   /* 0x08 */
    u16 net_type;                              /* 0x0a */
};
_Static_assert(sizeof(struct wil_vs_own) == 0xc, "wil_vs_own");

/* Объект BSS записи mid (e+0x48, 0x1ec Б): адреса, SSID, канал, поля бикона и IE. */
struct mid_bss {
    struct mid *owner;                         /* 0x00: запись mid */
    u32 state;                                 /* 0x04: MID_BSS_* */
    u32 mode;                                  /* 0x08: MID_MODE_* (bss_set_mode) */
    u8 bssid[6];                               /* 0x0c: BSSID (свой MAC у PCP, MAC AP у STA) */
    /* 0x12..0x25 — EDCA Parameter Set IE целиком (ie__push_edca копирует 0x14 Б): eid, len,
     * QoS Info (+0x14), резерв (+0x15), записи AC (+0x16 + 4·i, struct edca_ac_param —
     * mid_edca_ac()); первая запись лежит в старшей половине edca_w. */
    u8 edca_12;                                /* 0x12: eid 0xc (l2mgr__set_edca_defaults) */
    u8 edca_13;                                /* 0x13: len 0x12 */
    union {                                    /* 0x14: vendor — bf-хелпер словом, затем байт +0x15 */
        u32 edca_w;
        struct { u8 edca_14; u8 edca_15; };
    };
    u8 edca_ac[0x0e];                          /* 0x18: продолжение записей AC */
    u8 ssid[32];                               /* 0x26 */
    u32 ssid_len;                              /* 0x48: 0 — SSID нет */
    u8 channel;                                /* 0x4c: первичный канал (PCP) */
    u8 rsv_4d;
    u16 bcon_int;                              /* 0x4e: интервал маяка (WMI_CONNECT_EVENT; Listen Interval
                                                * в Assoc Request) */
    u16 bcon_int2;                             /* 0x50: интервал маяка (копия, mid__reset_bss_defaults) */
    u16 _ps_cut_aw_len;                        /* 0x52: Awake Window (mid__get_aw_len) — PS вырезан */
    u8 is_go;                                  /* 0x54: != 0 — запись PCP/AP (pcp_start: is_go) */
    u8 abft_len;                               /* 0x55: abft_len − 1 (WMI_BCON_CTRL), 3 бита в бикон */
    u8 rsv_56[2];
    u32 hidden;                                /* 0x58: hidden_ssid */
    union {                                    /* 0x5c: capability info — vendor пишет словом */
        u32 capinfo_w;
        struct {
            union {                            /* 0x5c: тип BSS (0..1), бит 2, privacy (бит 4) */
                u16 capinfo;
                u8 capinfo_b[2];
            };
            struct dmg_cap dmg_cap;            /* 0x5e: свой DMG Capabilities */
            struct dmg_cap pbss[SPARRAW_MAX_STA];   /* 0x6f: список станций PBSS по AID */
        };
    };
    u8 blk_f8[10];                             /* 0xf8: обнуляется mid__reset_10b_at_248, [9] = 0x14 */
    union {                                    /* 0x102 */
        u16 dmg_params_h;                      /* mid__reset_ie_area: RMW полусловом (ldw/stw) */
        struct {
            u8 dmg_params;                     /* 0x102: DMG Parameters (тип BSS 0..1, бит 2) */
            u8 blk_103[4];                     /* 0x103: обнуляется mid__reset_ssid */
            u8 bi_ctrl[6];                     /* 0x107: Beacon Interval Control бикона */
        };
    };
    struct wil_vs_own vs_old;                  /* 0x10e: VS старого формата (set_old_wilocity_vs) */
    u8 vs_ie[0x60];                            /* 0x11a: vendor IE Wilocity (eid 0xdd) */
    u8 vs_ie_len;                              /* 0x17a: полная длина vs_ie */
    u8 caps5[3];                               /* 0x17b: 5-битные поля capability (sta_rec__unpack_5bit_caps) */
    u8 rsv_17e[2];
    u8 rsn_ie[0x28];                           /* 0x180: RSN IE (mid__replace_rsn_ie, до 0x28 Б) */
    u32 f1a8;                                  /* 0x1a8: 0 в mid__init */
    u32 f1ac;                                  /* 0x1ac: 0 в mid__init и bss_set_mode */
    struct app_ies ie_assoc_req;               /* 0x1b0 */
    struct app_ies ie_assoc_resp;              /* 0x1bc */
    struct app_ies ie_probe_req;               /* 0x1c8 */
    struct app_ies ie_probe_resp;              /* 0x1d4 */
    struct app_ies ie_beacon;                  /* 0x1e0 */
};
MID_OFF(struct mid_bss, ssid, 0x26);
MID_OFF(struct mid_bss, vs_old, 0x10e);
MID_OFF(struct mid_bss, ssid_len, 0x48);
MID_OFF(struct mid_bss, capinfo_w, 0x5c);
MID_OFF(struct mid_bss, dmg_cap, 0x5e);
MID_OFF(struct mid_bss, pbss, 0x6f);
MID_OFF(struct mid_bss, blk_f8, 0xf8);
MID_OFF(struct mid_bss, bi_ctrl, 0x107);
MID_OFF(struct mid_bss, vs_ie, 0x11a);
MID_OFF(struct mid_bss, rsn_ie, 0x180);
MID_OFF(struct mid_bss, ie_assoc_req, 0x1b0);
_Static_assert(sizeof(struct mid_bss) == 0x1ec, "mid_bss");

/* Запись AC в EDCA Parameter Set (802.11 9.4.2.29): ACI/AIFSN (AIFSN [3:0], ACM б4,
 * ACI [6:5]), ECWmin [3:0] / ECWmax [7:4], TXOP limit (×32 мкс). */
struct edca_ac_param {
    u8  aci_aifsn;
    u8  ecw;
    u16 txop;
};
_Static_assert(sizeof(struct edca_ac_param) == 4, "edca_ac_param");

static inline struct edca_ac_param *mid_edca_ac(struct mid_bss *o, u32 ac)
{
    return (struct edca_ac_param *)((u8 *)o + 0x16) + ac;
}

/* Параметры безопасности записи (e+0x28; l2mgr__config_security 0x8f1c84,
 * mid__set_default_counters 0x8f5350). */
struct mid_sec {
    u32 dot11_auth;                            /* 0x00: dot11_auth_mode */
    u32 auth;                                  /* 0x04: auth_mode */
    u32 group_crypto;                          /* 0x08 */
    u32 pairwise;                              /* 0x0c: 4-й параметр config_security */
    u32 enabled;                               /* 0x10: 1 после config_security */
    u32 privacy;                               /* 0x14: [e+0x3c] — защита (bcon_ctrl_prepare_mid) */
    u32 wpa_offload;                           /* 0x18 */
    struct mid *owner;                         /* 0x1c */
};
_Static_assert(sizeof(struct mid_sec) == 0x20, "mid_sec");

struct find_mngr;

/* Автомат find_sm (описатель 0x8030f4, obj_vt8030f4__ctor 0x8f532c; fw/link_sm.c). */
struct find_sm {
    struct basic_sm hdr;                       /* 0x00 */
    u8 bf_state[SPARRAW_MAX_STA];              /* 0x08: состояние BF по cid (8 — свободно) */
    struct find_mngr *owner;                   /* 0x10 */
    u32 req;                                   /* 0x14: запрос радио (struct rm_req *), 0 в ctor */
    struct llist found;                        /* 0x18: найденные BSS (dband-инфо) */
};
_Static_assert(sizeof(struct find_sm) == 0x24, "find_sm");

/* find_mngr объекта discovery (e+0x240): поиск/прослушивание P2P (fw/wmi_h_pcp.c, link_sm.c). */
struct find_mngr {
    u8 rsv_00[0x0c];
    u32 quiet;                                 /* 0x0c: тихий режим (P2P discovery_mode == 1) */
    u8 channel;                                /* 0x10 */
    u8 rsv_11;
    u16 bi;                                    /* 0x12: интервал */
    u32 mode;                                  /* 0x14 */
    u32 timer;                                 /* 0x18 */
    struct find_sm sm;                         /* 0x1c */
    u32 active;                                /* 0x40: discovery идёт */
    u32 bcon_added;                            /* 0x44: discovery-бикон поставлен */
    struct mid *mid;                           /* 0x48 */
    u8 rsv_4c[4];
};
MID_OFF(struct find_mngr, sm, 0x1c);
MID_OFF(struct find_mngr, active, 0x40);
_Static_assert(sizeof(struct find_mngr) == 0x50, "find_mngr");

/* Таблица методов объекта discovery (0x80070c, ctor 0x8c1ad4). */
struct mid_disc_vt {
    u32 rsv0;
    void (*rx_pkt)(struct mid_disc *d, struct rx_pkt *pkt);   /* [1] discovery__rx_pkt_handler (0x8e3f0c) */
};

/* Объект discovery записи mid (e+0x234, 0x5c Б): скан и поиск. */
struct mid_disc {
    const struct mid_disc_vt *vt;              /* 0x00 */
    struct mid *mid;                           /* 0x04 */
    struct scan_mngr *scan;                    /* 0x08: объект scan_mngr (radio_req__addr_of: 0x8052ec + 0x228·i) */
    struct find_mngr find;                     /* 0x0c */
};
MID_OFF(struct mid_disc, find, 0x0c);
_Static_assert(sizeof(struct mid_disc) == 0x5c, "mid_disc");

/* Запись mid (0x2b0 Б). */
struct mid {
    struct mid *next;                          /* 0x00: узел mid_list */
    struct llist *list;                        /* 0x04 */
    u8 aid;                                    /* 0x08: AID у STA (WMI_CONNECT_EVENT; ese__peer_cid_by_aid
                                                * сравнивает с ним cid) */
    u8 rsv_09;
    union {                                    /* 0x0a: свой MAC (WMI_SET_MAC_ADDRESS) */
        u8 mac[6];
        u16 mac_h[3];                          /* бит 0 mac_h[0] — групповой адрес */
    };
    u8 id;                                     /* 0x10: номер mid */
    u8 max_assoc;                              /* 0x11: макс. число STA (PCP Capability, assoc_ready_check);
                                                * pcp_start_flow пишет туда число секторов A-BFT */
    u8 rsv_12[2];
    u32 network_type;                          /* 0x14: enum wmi_network_type */
    struct llist conns;                        /* 0x18: соединения записи (элементы — struct conn, include/conn.h) */
    u8 cid_mask;                               /* 0x24: биты cid соединений записи (маска vring_schd) */
    u8 rsv_25[3];
    struct mid_sec sec;                        /* 0x28 */
    struct mid_bss bss;                        /* 0x48 */
    struct mid_disc disc;                      /* 0x234 */
    struct sched_scheme *sched;                /* 0x290: схема расписания (0x805234, mid__sched_obj) */
    u8 gtk[16];                                /* 0x294: групповой ключ (обратный порядок байт) */
    u8 gtk_idx;                                /* 0x2a4 */
    u8 rsv_2a5[3];
    u32 pcp_ready_tmr;                         /* 0x2a8: таймер pcp_ready_timer_cb */
    u32 connect_busy;                          /* 0x2ac: != 0 — «connect flow in progress» */
};
MID_OFF(struct mid, mac, 0x0a);
MID_OFF(struct mid, id, 0x10);
MID_OFF(struct mid, network_type, 0x14);
MID_OFF(struct mid, conns, 0x18);
MID_OFF(struct mid, cid_mask, 0x24);
MID_OFF(struct mid, sec, 0x28);
MID_OFF(struct mid, bss, 0x48);
MID_OFF(struct mid, disc, 0x234);
MID_OFF(struct mid, sched, 0x290);
MID_OFF(struct mid, gtk, 0x294);
MID_OFF(struct mid, pcp_ready_tmr, 0x2a8);
_Static_assert(sizeof(struct mid) == 0x2b0, "mid");

/* Экземпляры (DCCM, FWDATA в fw/mid.c; в fw/dccm_names.txt — ext[N]). */
#define MID_RECS_N 1
extern struct llist mid_list;                          /* 0x804e70: открытые записи */
extern struct mem_pool mid_pool;                       /* 0x804e7c: пул записей */
extern struct mid mid_recs[MID_RECS_N];                /* 0x804e90: память пула */
extern const struct mid_disc_vt mid_disc_vtbl;         /* 0x80070c */

/* Пул dband-инфо (кандидаты BSS скана, 0x10 × 0x4c Б; mid__init_scan_and_pools,
 * alloc_dband_info). */
#define DBAND_INFO_N    0x10
#define DBAND_INFO_SIZE 0x4c
/* Счётчики кадров управления discovery (0x843158, 0x30 Б; обнуляет mid__init_scan_and_pools).
 * Объект volatile: vendor каждый раз читает и пишет память. */
struct mgmt_stats {
    u32 probe_req_rx;                          /* 0x00: принято probe req */
    u32 probe_req_tx;                          /* 0x04: отправлено probe req (скан) */
    u32 probe_req_tx_ok;                       /* 0x08: probe req — TX завершён успешно */
    u32 probe_resp_to_host;                    /* 0x0c: probe resp передано хосту */
    u32 probe_resp_rx;                         /* 0x10: принято probe resp */
    u32 probe_req_handled;                     /* 0x14: probe req разобран (ответ или нет) */
    u32 probe_resp_tx_ok;                      /* 0x18: probe resp — TX завершён успешно */
    u32 bcon_to_host;                          /* 0x1c: биконов передано хосту */
    u32 bcon_set;                              /* 0x20: бикон PCP поставлен (add_bcon при старте) */
    u32 bcon_wb;                               /* 0x24: бикон PCP возвращён (pcp_bcon_wb) */
    u32 bcon_rx;                               /* 0x28: принято биконов */
    u32 rsv_2c;
};
_Static_assert(__builtin_offsetof(struct mgmt_stats, bcon_rx) == 0x28, "mgmt_stats.bcon_rx");
_Static_assert(sizeof(struct mgmt_stats) == 0x30, "mgmt_stats");
extern volatile struct mgmt_stats mgmt_stats;                 /* 0x843158 (fw.ld) */

extern struct mem_pool dband_info_pool;                       /* 0x805524 */
extern u8 dband_info_mem[DBAND_INFO_N][DBAND_INFO_SIZE];      /* 0x805538 */

/* Описатели автоматов в DCCM (FWDATA, fw/link_sm.c; ид [0x10] пишет статический конструктор). */
extern struct sm_desc find_sm_desc;                  /* 0x8030f4 */

#endif
