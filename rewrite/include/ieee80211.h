/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Кадры 802.11 (DMG) и элементы, как их разбирает fw 6.2, и приёмная сторона: пакет RX
 * (элемент пула rx_ring.pool), дескриптор RX-кольца DMA, запись разбора mgmt-кадра и
 * объект RX-служб 0x842840. Ширины полей — как у vendor при доступе (MAC читается и
 * полусловами, и словом; невыровненные поля тел action-кадров — побайтно). */
#ifndef IEEE80211_H
#define IEEE80211_H
#include "types.h"

#define IEEE_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

/* ---------------- адрес и заголовки ---------------- */

/* MAC-адрес: vendor читает его байтами, полусловами (ldw) и словом + полусловом. */
union mac_addr {
    u8  b[6];
    u16 h[3];
};
_Static_assert(sizeof(union mac_addr) == 6, "mac_addr");

/* Младшие 4 Б MAC одним словом (ld) — только где vendor так читает и адрес выровнен на 4. */
static inline u32 mac_lo32(const union mac_addr *m)
{
    return *(const u32 *)m->b;
}

/* Frame Control: тип [3:2], подтип [7:4]; второй байт — флаги (бит 3 — Retry). */
#define FC_TYPE(fc)     (((fc) >> 2) & 3u)
#define FC_STYPE(fc)    (((fc) >> 4) & 0xfu)
#define FC_TYPE_MGMT    0u
#define FC_TYPE_CTRL    1u
#define FC_TYPE_DATA    2u
#define FC_TYPE_EXT     3u              /* extension (DMG-бикон — подтип 0) */

/* Заголовок 802.11 (mgmt/data — 0x18 Б; extension/control — первые 0xa Б: FC, Duration,
 * адрес 1 = BSSID у DMG-бикона). vendor читает FC и полусловом, и словом (FC + Duration). */
struct ieee80211_hdr {
    union {
        struct {
            union {
                u16 fc;                        /* 0x00 */
                u8  fc_b[2];                   /* 0x00: [0] тип/подтип, [1] флаги FC */
            };
            u16 duration;                      /* 0x02 */
        };
        u32 fc_dur;                            /* 0x00: FC + Duration (ld) */
    };
    union mac_addr addr1;                      /* 0x04: RA / BSSID (бикон) */
    union mac_addr addr2;                      /* 0x0a: TA / SA */
    union mac_addr addr3;                      /* 0x10: BSSID */
    u16 seq;                                   /* 0x16 */
};
IEEE_OFF(struct ieee80211_hdr, addr1, 0x04);
IEEE_OFF(struct ieee80211_hdr, addr2, 0x0a);
IEEE_OFF(struct ieee80211_hdr, addr3, 0x10);
_Static_assert(sizeof(struct ieee80211_hdr) == 0x18, "ieee80211_hdr");
#define IEEE80211_HDR_LEN       0x18u  /* mgmt-заголовок */
#define IEEE80211_HDR_SHORT_LEN 0xau   /* extension/control-заголовок */

/* DMG-бикон (extension-кадр, подтип 0; tx_mgmt_build_step 0x8d7df4): после короткого
 * заголовка (FC, Duration, BSSID — struct ieee80211_hdr) поля не выровнены — побайтно. */
struct ieee80211_dmg_beacon {
    u8 hdr[IEEE80211_HDR_SHORT_LEN];           /* 0x00 */
    u8 timestamp[8];                           /* 0x0a */
    u8 ssw[3];                                 /* 0x12: Sector Sweep */
    u8 bcn_int[2];                             /* 0x15: Beacon Interval (LE) */
    u8 bi_ctrl[6];                             /* 0x17: Beacon Interval Control */
    u8 dmg_params;                             /* 0x1d: DMG Parameters */
};
IEEE_OFF(struct ieee80211_dmg_beacon, bcn_int, 0x15);
IEEE_OFF(struct ieee80211_dmg_beacon, dmg_params, 0x1d);
_Static_assert(sizeof(struct ieee80211_dmg_beacon) == 0x1e, "ieee80211_dmg_beacon");

/* Заголовок QoS Data (0x1a Б; тестовый кадр FW2FW, tx_send_packet_step). */
struct ieee80211_qos_hdr {
    struct ieee80211_hdr h;                    /* 0x00 */
    u16 qos_ctrl;                              /* 0x18: [3:0] TID */
};
IEEE_OFF(struct ieee80211_qos_hdr, qos_ctrl, 0x18);
#define IEEE80211_QOS_HDR_LEN 0x1au    /* длина в кадре; sizeof — 0x1c (выравнивание на 4) */

/* Disassociation (подтип 0xa): код причины после заголовка. */
struct ieee80211_disassoc {
    struct ieee80211_hdr h;                    /* 0x00 */
    u16 reason;                                /* 0x18 */
};
IEEE_OFF(struct ieee80211_disassoc, reason, 0x18);

/* Association Response (подтип 1): Capability Info, Status, AID. */
struct ieee80211_assoc_resp {
    struct ieee80211_hdr h;                    /* 0x00 */
    u16 capinfo;                               /* 0x18 */
    u16 status;                                /* 0x1a */
    u16 aid;                                   /* 0x1c */
};
IEEE_OFF(struct ieee80211_assoc_resp, status, 0x1a);
IEEE_OFF(struct ieee80211_assoc_resp, aid, 0x1c);

/* Status Code + AID Association Response (после Capability Info). */
struct ieee80211_status_aid {
    u16 status;                                /* 0x00 */
    u16 aid;                                   /* 0x02 */
};

/* RSN IE по умолчанию (mid__set_default_dmg_params 0x8cb728): по одному парному шифру
 * и AKM; счётчики и версия — полусловами. */
struct rsn_ie_1x1 {
    u8  eid;                                   /* 0x00: 0x30 */
    u8  len;                                   /* 0x01 */
    u16 version;                               /* 0x02 */
    u8  group_cipher[4];                       /* 0x04 */
    u16 pairwise_count;                        /* 0x08 */
    u8  pairwise_cipher[4];                    /* 0x0a */
    u16 akm_count;                             /* 0x0e */
    u8  akm[4];                                /* 0x10 */
    u8  rsn_cap[2];                            /* 0x14 */
};
IEEE_OFF(struct rsn_ie_1x1, akm_count, 0x0e);
IEEE_OFF(struct rsn_ie_1x1, rsn_cap, 0x14);

/* Фиксированные поля Probe Response / бикона после заголовка (mgmt_tx__copy_ie_hdr). */
struct ieee80211_probe_resp_fixed {
    u8  timestamp[8];                          /* 0x00 */
    u16 bcn_int;                               /* 0x08 */
    u8  capinfo[2];                            /* 0x0a */
};
IEEE_OFF(struct ieee80211_probe_resp_fixed, bcn_int, 0x08);

/* ---------------- элементы (IE) ---------------- */

#define EID_SSID        0x00
#define EID_RATES       0x01
#define EID_COUNTRY     0x07
#define EID_REQUEST     0x0a
#define EID_MEAS_REQ    0x26
#define EID_RSN         0x30
#define EID_WAKEUP_SCHED 0x8f           /* 143 */
#define EID_EXT_SCHED   0x90            /* Extended Schedule */
#define EID_DMG_CAP     0x94
#define EID_DMG_OP      0x97
#define EID_MULTI_BAND  0x9e
#define EID_VENDOR      0xdd

/* Ссылка на элемент в записи разбора: ID, длина, указатель на тело (после заголовка). */
struct ie_ref {
    u8 eid;                                    /* 0x00 */
    u8 len;                                    /* 0x01 */
    u8 rsv_02[2];
    u8 *body;                                  /* 0x04: 0 — элемента не было */
};
_Static_assert(sizeof(struct ie_ref) == 8, "ie_ref");

/* Распределение (Allocation) элемента Extended Schedule — 15 Б, без выравнивания: поля
 * vendor читает побайтно (ese__alloc_to_slot 0x8c7d4c). */
struct ese_alloc {
    u8 ctrl[2];                                /* 0x00: Allocation Control ([0] биты 0..3 — id, 4..5 — тип) */
    u8 bf_ctrl[2];                             /* 0x02 */
    u8 src_aid;                                /* 0x04 */
    u8 dst_aid;                                /* 0x05 */
    u8 start[4];                               /* 0x06: Allocation Start (TSF, мкс) */
    u8 block_dur[2];                           /* 0x0a */
    u8 n_blocks;                               /* 0x0c */
    u8 block_period[2];                        /* 0x0d */
};
_Static_assert(sizeof(struct ese_alloc) == 0xf, "ese_alloc");

/* TLV Wilocity VS-элемента (после OUI 3 Б): тип и длина — по байтам (LE), значение —
 * байты или полуслово (vendor: ldw по адресу TLV + 4 — wil_vs_tlv_val16). Выравнивание
 * 1 (адрес TLV произвольный): иначе gcc вправе склеить байтовые чтения в ldw. */
struct wil_vs_tlv {
    u8 type[2];                                /* 0x00 */
    u8 len[2];                                 /* 0x02 */
    u8 val[2];                                 /* 0x04 */
};
_Static_assert(sizeof(struct wil_vs_tlv) == 6, "wil_vs_tlv");
static inline u32 wil_vs_tlv_val16(const struct wil_vs_tlv *t)
{
    return *(const u16 *)t->val;
}

/* Тело Wilocity VS-элемента старого формата (OUI 00:aa:6c, 12 Б; set_old_wilocity_vs
 * 0x8e69e0 собирает такое же в своём кадре): поля — побайтно. */
struct wil_vs_old {
    u8 oui[3];                                 /* 0x00: 00 aa 6c */
    u8 rsv_03;
    u8 board[4];                               /* 0x04: байты платы (plat_board_info +0x2c) */
    u8 cap[2];                                 /* 0x08 */
    u8 net_type[2];                            /* 0x0a: тип сети (wvs_mode) */
};
_Static_assert(sizeof(struct wil_vs_old) == 0xc, "wil_vs_old");
/* net_type полусловом (ldw, как vendor set_old_wilocity_vs 0x8e69e0). */
static inline u32 wil_vs_old_net_type16(const struct wil_vs_old *v)
{
    return *(const u16 *)v->net_type;
}

/* ---------------- тела action-кадров (с байта категории) ---------------- */

#define ACT_CAT_BA      3
#define ACT_CAT_PUBLIC  4
#define ACT_CAT_DMG     0x10

struct ieee80211_action {
    u8 category;                               /* 0x00 */
    u8 action;                                 /* 0x01 */
};

/* ADDBA Request (Block Ack, 9.6.4.2): невыровненные u16 — байтами. */
struct ieee80211_addba {
    u8 category;                               /* 0x00: 3 */
    u8 action;                                 /* 0x01: 0 */
    u8 token;                                  /* 0x02 */
    u8 params[2];                              /* 0x03: A-MSDU [0], политика [1], TID [5:2],
                                                *       размер окна [15:6] */
    u8 timeout[2];                             /* 0x05 */
    u8 ssn[2];                                 /* 0x07 */
};
_Static_assert(sizeof(struct ieee80211_addba) == 9, "ieee80211_addba");

/* ADDBA Response (9.6.4.3). */
struct ieee80211_addba_resp {
    u8 category;                               /* 0x00: 3 */
    u8 action;                                 /* 0x01: 1 */
    u8 token;                                  /* 0x02 */
    u8 status[2];                              /* 0x03 */
    u8 params[2];                              /* 0x05: как у Request */
    u8 timeout[2];                             /* 0x07 */
};
_Static_assert(sizeof(struct ieee80211_addba_resp) == 9, "ieee80211_addba_resp");

/* DELBA (9.6.4.4). */
struct ieee80211_delba {
    u8 category;                               /* 0x00 */
    u8 action;                                 /* 0x01: 2 */
    u8 params[2];                              /* 0x02: [1] бит 3 — инициатор, [7:4] — TID */
    u16 reason;                                /* 0x04 (ldw) */
};

#define WLAN_ACT_ADDBA_REQ     0
#define WLAN_ACT_ADDBA_RESP    1
#define WLAN_ACT_DELBA         2

/* Кадр действия Block Ack в payload TX-пакета (заголовок + тело; обработчики завершения
 * TX получают payload). Тела fw строит сам: frame_build_addba_req/resp, frame_build_delba. */
struct ba_action_frame {
    struct ieee80211_hdr h;                    /* 0x00 */
    union {
        struct ieee80211_addba addba_req;      /* 0x18 */
        struct ieee80211_addba_resp addba_resp;
        struct ieee80211_delba delba;
    };
};
IEEE_OFF(struct ba_action_frame, addba_req.params, 0x1b);
IEEE_OFF(struct ba_action_frame, delba.params, 0x1a);

/* Параметры probe request активного скана (на стеке scan_mngr_send_prob_req, 5 слов). */
struct tx_probe_param {
    const u8 *ra;                              /* 0x00: → addr1 */
    const u8 *bssid;                           /* 0x04 */
    const u8 *ssid;                            /* 0x08 */
    u32 ssid_len;                              /* 0x0c */
    u32 channel;                               /* 0x10: канал TX (tx_api_send_mgmt a1) */
};
_Static_assert(sizeof(struct tx_probe_param) == 0x14, "tx_probe_param");

/* ---------------- приёмная сторона ---------------- */

/* Дескриптор RX-кольца DMA (32 Б; fwq_tx__handle_completion 0x8cc7c4,
 * rx_api__drain_list init 0x8e39dc). */
struct rx_desc {
    u32 w0;                                    /* 0x00: cid [6:4] */
    u32 w1;                                    /* 0x04: MCS [20:16], [24:21] → info.mcs */
    u8  rsv_08[8];
    u32 ctrl;                                  /* 0x10: бит 10 (и 9) ставит init */
    u32 buf;                                   /* 0x14: 18 младших бит адреса буфера */
    u32 w6;                                    /* 0x18 */
    u8  rsv_1c;
    u8  status;                                /* 0x1d: бит 0 — готов (DD), бит 2 → info.status */
    u16 len;                                   /* 0x1e: длина кадра; init — размер буфера */
};
IEEE_OFF(struct rx_desc, buf, 0x14);
IEEE_OFF(struct rx_desc, status, 0x1d);
_Static_assert(sizeof(struct rx_desc) == 0x20, "rx_desc");

/* Заголовок пакета хосту WMI_RX_MGMT_PACKET_EVENTID (0x1840) — struct wmi_rx_mgmt_info
 * драйвера wil6210 (16 Б, в пакете RX с +0x28). */
struct rx_mgmt_info {
    u8  mcs;                                   /* 0x00 */
    s8  snr;                                   /* 0x01 */
    u8  range;                                 /* 0x02 */
    u8  sqi;                                   /* 0x03 */
    u16 stype;                                 /* 0x04: подтип кадра */
    u16 status;                                /* 0x06 */
    u32 len;                                   /* 0x08: длина кадра с заголовком 802.11 */
    u8  qid;                                   /* 0x0c: 0 — заголовок 0x18 Б, 1 — 0xa Б */
    u8  mid;                                   /* 0x0d */
    u8  cid;                                   /* 0x0e */
    u8  channel;                               /* 0x0f */
};
_Static_assert(sizeof(struct rx_mgmt_info) == 0x10, "rx_mgmt_info");

struct rx_mgmt_ei;

/* Пакет RX — элемент пула rx_ring.pool (0xc × 0x538 Б): заголовок 0x38 Б, кадр с +0x38
 * (адрес кадра — в дескрипторе DMA). */
struct rx_pkt {
    u32 next;                                  /* 0x00: узел llist */
    u32 owner;                                 /* 0x04 */
    struct ieee80211_hdr *hdr;                 /* 0x08: заголовок 802.11 (= body до снятия) */
    struct rx_mgmt_ei *ei;                     /* 0x0c: запись разбора mgmt-кадра */
    u32 rsv_10;                                /* 0x10: при приёме — 0 */
    u8 *body;                                  /* 0x14: кадр; после разбора — тело за заголовком */
    u8 rsv_18[0x10];
    struct rx_mgmt_info info;                  /* 0x28: заголовок события хосту */
    u8 frame[0x500];                           /* 0x38 */
};
IEEE_OFF(struct rx_pkt, hdr, 0x08);
IEEE_OFF(struct rx_pkt, ei, 0x0c);
IEEE_OFF(struct rx_pkt, body, 0x14);
IEEE_OFF(struct rx_pkt, info, 0x28);
IEEE_OFF(struct rx_pkt, frame, 0x38);
_Static_assert(sizeof(struct rx_pkt) == 0x538, "rx_pkt");
#define RX_PKT_OF_BUF(buf)  ((struct rx_pkt *)((u32)(buf) - __builtin_offsetof(struct rx_pkt, frame)))

/* Запись разбора mgmt-кадра (rx_mgmt_prs__parse 0x8de190, set_parse_ei 0x8e6a54): ссылки
 * на элементы и указатели на поля фиксированной части в теле кадра. */
struct rx_mgmt_ei {
    u32 busy;                                  /* 0x00: 1 — занята */
    u8  nfields;                               /* 0x04: число разобранных полей и IE */
    u8  rsv_05[3];
    struct ie_ref ssid;                        /* 0x08: 0 */
    struct ie_ref rates;                       /* 0x10: 1 */
    struct ie_ref country;                     /* 0x18: 7 */
    struct ie_ref ie_0c;                       /* 0x20: 0x0c */
    u8  rsv_28[0x18];
    struct ie_ref rsn;                         /* 0x40: 0x30 */
    u8  rsv_48[0x20];
    struct ie_ref ext_sched;                   /* 0x68: 0x90 Extended Schedule */
    struct ie_ref dmg_cap;                     /* 0x70: 0x94 */
    struct ie_ref dmg_op;                      /* 0x78: 0x97 */
    u8  rsv_80[4];
    u8 *dmg_params;                            /* 0x84: DMG Parameters (бикон) */
    struct ie_ref ie_be;                       /* 0x88: 0xbe */
    struct ie_ref multi_band;                  /* 0x90: 0x9e */
    struct ie_ref vs_wil_old;                  /* 0x98: VS 00:aa:6c */
    struct ie_ref vs_wil;                      /* 0xa0: VS 04:ce:14 */
    struct ie_ref ie_9d;                       /* 0xa8: 0x9d */
    u8 *timestamp;                             /* 0xb0 */
    u8 *capability;                            /* 0xb4 */
    u8 *ssw;                                   /* 0xb8: бикон */
    u8 *bcn_int;                               /* 0xbc */
    u8 *bi_ctrl;                               /* 0xc0: Beacon Interval Control (бикон) */
    u8 *clustering;                            /* 0xc4: бикон, если BI Control бит 0 */
    u16 listen_int;                            /* 0xc8 */
    u16 aid;                                   /* 0xca */
    u16 status;                                /* 0xcc: Status / Reason Code */
    u8  rsv_ce[2];
    u8 *ies;                                   /* 0xd0: начало элементов */
};
IEEE_OFF(struct rx_mgmt_ei, ssid, 0x08);
IEEE_OFF(struct rx_mgmt_ei, rsn, 0x40);
IEEE_OFF(struct rx_mgmt_ei, ext_sched, 0x68);
IEEE_OFF(struct rx_mgmt_ei, dmg_params, 0x84);
IEEE_OFF(struct rx_mgmt_ei, vs_wil, 0xa0);
IEEE_OFF(struct rx_mgmt_ei, timestamp, 0xb0);
IEEE_OFF(struct rx_mgmt_ei, listen_int, 0xc8);
IEEE_OFF(struct rx_mgmt_ei, ies, 0xd0);
_Static_assert(sizeof(struct rx_mgmt_ei) == 0xd4, "rx_mgmt_ei");

#define RX_MGMT_EI_N 5

/* Объект RX-служб (0x842840, 0x434 Б): две базы с таблицами методов (rx_pkt_srvs_vtbl
 * 0x800874: [1] rx_mgmt_prs__alloc_ei, [2] rx_pkt_srvs__dispatch; rx_pkt_srvs_vtbl2
 * 0x800880 — вторая база, [1] dispatch_thunk), таблица записей разбора и счётчики. */
struct rx_pkt_srvs;
struct rx_pkt_srvs_vt {
    u32 rsv0;                                  /* 0x00: 0 */
    u32 (*alloc_ei)(struct rx_pkt_srvs *o, struct rx_pkt *pkt);    /* 0x04 */
    void (*dispatch)(struct rx_pkt_srvs *o, struct rx_pkt *pkt);   /* 0x08 */
};
_Static_assert(sizeof(struct rx_pkt_srvs_vt) == 12, "rx_pkt_srvs_vt");
/* Вторая база (this = &o->vt2): dispatch_thunk переходит к первой (this − 4). */
struct rx_pkt_srvs_vt2 {
    u32 rsv0;                                  /* 0x00: 0 */
    void (*dispatch)(const struct rx_pkt_srvs_vt2 **base2, struct rx_pkt *pkt);   /* 0x04: this = &o->vt2 */
};
_Static_assert(sizeof(struct rx_pkt_srvs_vt2) == 8, "rx_pkt_srvs_vt2");
extern const struct rx_pkt_srvs_vt rx_pkt_srvs_vtbl;     /* 0x800874 (fw/rx.c) */
extern const struct rx_pkt_srvs_vt2 rx_pkt_srvs_vtbl2;   /* 0x800880 (fw/rx.c) */

struct rx_pkt_srvs {
    const struct rx_pkt_srvs_vt *vt;           /* 0x000: rx_pkt_srvs_vtbl */
    const struct rx_pkt_srvs_vt2 *vt2;         /* 0x004: rx_pkt_srvs_vtbl2 */
    struct rx_mgmt_ei ei[RX_MGMT_EI_N];        /* 0x008 */
    u32 cnt_42c;                               /* 0x42c: обнуляется l2mgr__reset_oob_rings */
    u32 data_rx_count;                         /* 0x430: принятые data-кадры */
};
IEEE_OFF(struct rx_pkt_srvs, ei, 0x008);
IEEE_OFF(struct rx_pkt_srvs, data_rx_count, 0x430);
_Static_assert(sizeof(struct rx_pkt_srvs) == 0x434, "rx_pkt_srvs");

extern struct rx_pkt_srvs rx_pkt_srvs;         /* 0x842840 (fw/fw.ld) */
/* Кольцо и пул RX (rx_pool__init, fw/l2mgr.c; символы fw/fw.ld). */
#define RX_RING_MEM_N 8
#define RX_PKT_MEM_N  12
extern struct rx_desc rx_ring_mem[RX_RING_MEM_N];   /* 0x843800 */
extern struct rx_pkt rx_pkt_mem[RX_PKT_MEM_N];      /* 0x84a940: элементы rx_ring.pool */

/* Таблица методов eapol_frame_builder (0x8006f4; объект — слово eapol_builder_obj 0x8002f0,
 * его ставит конструктор 0x8c1928): [1] build (0x8f15ec, fw/vt_misc.c). */
struct conn;
struct eapol_builder_vt {
    u32 rsv0;                                  /* 0x00: 0 */
    u32 (*build)(u32 obj, u8 *buf, u32 *out_len, struct conn *ctx, u32 to_ds,
                 const void *src, u32 len);    /* 0x04 */
};
_Static_assert(sizeof(struct eapol_builder_vt) == 8, "eapol_builder_vt");
extern const struct eapol_builder_vt eapol_builder_vtbl;  /* 0x8006f4 (fw/vt_misc.c) */

#endif
