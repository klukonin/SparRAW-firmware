/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Соединение conn (пир по cid) и база соединений conn_mgr (vendor 6.2, рабочая память
 * 0x854000, вне DCCM): список ранжирования, таблица cid → conn (cid_db), пул записей
 * соединений 8 × 0x1a0 (журнал vendor печатает «conn_p=0x854c34» — адрес записи пула).
 * Вложенные части записи: lm_if (линк-менеджер, +0x70), автомат MLME (описатель
 * 0x802458, +0xf0), автомат соединения conn_main_sm (0x802744, +0x124) с автоматом
 * разрыва conn_disc_sm (0x8027a0, +0x130), резерв +0x164 (автомат сессии FTM — только SparRAW-pro).
 * Конструкторы — discovery.c (connection__init 0x8f54a4, connection__store_ptr 0x8d9264,
 * obj_vt802458/802744/803424__ctor, disc_flush_sm__init), пулы — l2mgr.c
 * (link_loss_detectors__init 0x8d94f0). Смещения закреплены _Static_assert. */
#ifndef CONN_H
#define CONN_H
#include "types.h"
#include "basic_sm.h"
#include "llist.h"
#include "mem_pool.h"
#include "mid.h"
#include "sta_max.h"

#define CONN_OFF(t, f, o) _Static_assert(__builtin_offsetof(t, f) == (o), #t "." #f)

struct conn;
struct mid;
struct conn_msm;
struct rx_pkt;
struct rm_req;
struct lm_sm;
struct ll_detectors;

#define CONN_MAX SPARRAW_MAX_STA               /* cid 0..7 (conn_mgr__by_cid: ассерт 0x11c9) */

/* Снимок результата BF / dband-информации бикона (0x44 Б): conn__snapshot_step (0x8c28d0)
 * копирует его из события LMAC в lm_if+0xc; lm_if__on_linkup_ready передаёт его lm_sm. */
struct conn_bf_snap {
    u32 rssi;                                  /* 0x00: RSSI (+72 — WMI_NOTIFY_REQ_DONE) */
    u8  rsv04;                                 /* 0x04 */
    u8  sector[4];                             /* 0x05: секторы (STA-конфиг uc, NOTIFY_REQ_DONE) */
    u8  rsv09;                                 /* 0x09 */
    u16 rx_sector;                             /* 0x0a: RX-сектор пира */
    u8  rsv0c[0x20];                           /* 0x0c */
    u32 status;                                /* 0x2c: итог BF (1 — успех) */
    u8  rsv30[0x14];                           /* 0x30 */
};
CONN_OFF(struct conn_bf_snap, sector, 0x05);
CONN_OFF(struct conn_bf_snap, rx_sector, 0x0a);
CONN_OFF(struct conn_bf_snap, status, 0x2c);
_Static_assert(sizeof(struct conn_bf_snap) == 0x44, "conn_bf_snap");

/* lm_if — интерфейс линк-менеджера соединения (conn+0x70, 0x80 Б). */
struct lm_if {
    struct lm_sm *lm_sm;                       /* 0x00: &lm_sm_recs[cid] (lm_if__set_cid; include/link_sm.h) */
    struct conn *conn;                         /* 0x04: владелец */
    u32 snap_time;                             /* 0x08: время снимка (u_schd_now) */
    struct conn_bf_snap snap;                  /* 0x0c: снимок BF/бикона */
    u8  mcs_total[13];                         /* 0x50: статистика по MCS (link_stats; 0x1f Б с 0x50) */
    u8  mcs_bad[13];                           /* 0x5d */
    u8  rsv6a[4];                              /* 0x6a */
    u8  mcs;                                   /* 0x6e: текущий MCS */
    u8  rsv6f;                                 /* 0x6f */
    u32 notify_period;                         /* 0x70: период WMI_NOTIFY_REQ_DONE, мкс */
    u32 notify_timer;                          /* 0x74: таймер статистики */
    u32 notify_en;                             /* 0x78: периодическая статистика включена */
    struct ll_detectors *detectors;            /* 0x7c: &ll_detectors[cid] (0 — выкл.; include/link_loss.h) */
};
CONN_OFF(struct lm_if, snap, 0x0c);
CONN_OFF(struct lm_if, mcs_total, 0x50);
CONN_OFF(struct lm_if, mcs, 0x6e);
CONN_OFF(struct lm_if, notify_period, 0x70);
CONN_OFF(struct lm_if, detectors, 0x7c);
_Static_assert(sizeof(struct lm_if) == 0x80, "lm_if");

/* Автомат MLME (описатель 0x802458, conn+0xf0, 0x34 Б). Состояния: 0 UNASSOCIATE,
 * 1 ASSOCIATE, 2 ASSOCIATED (байт sm.state — «связь есть» при 2). */
enum { MLME_UNASSOCIATE = 0, MLME_ASSOCIATE = 1, MLME_ASSOCIATED = 2 };
/* События (имена vendor, 0x801084; DISASSOCIAT — так в образе). */
enum {
    MLME_EV_CONNECT = 0, MLME_EV_DISCONNECT = 1, MLME_EV_DISASSOCIAT = 2,
    MLME_EV_ASSOC_RESPONSE_START = 3, MLME_EV_ASSOC_RESPONSE = 4, MLME_EV_ASSOC_REJECT = 5,
    MLME_EV_ASSOC_TIMEOUT = 6, MLME_EV_RM_CHANNEL_LOCKED = 7, MLME_EV_DATA_PORT_OPEN = 8,
    MLME_EV_WAITFOR_CTRL_ASSOC_RES = 9, MLME_EV_CTRL_ASSOC_RESPONSE_RET = 10,
    MLME_EV_CTRL_NEW_STA = 11, MLME_EV_WAITFOR_CTRL_DEL_STA = 12, MLME_EV_CTRL_DEL_STA = 13,
};
struct mlme_sm {
    struct basic_sm sm;                        /* 0x00 */
    u32 radio_locked;                          /* 0x08: радио захвачено */
    u32 busy;                                  /* 0x0c: ждём ответ / идёт обмен Assoc */
    struct rm_req *rm_req;                     /* 0x10: запрос радио-менеджера */
    u32 assoc_timer;                           /* 0x14: таймер ассоциации */
    u32 ctrl_timer;                            /* 0x18: таймер ответа хоста (split MAC) */
    u32 del_sta_timer;                         /* 0x1c: таймер удаления станции хостом */
    struct conn *conn;                         /* 0x20: владелец */
    u32 tx_payload;                            /* 0x24: TX-кадр Assoc Req/Resp */
    u16 status;                                /* 0x28: статус Assoc Response */
    u16 host_reason;                           /* 0x2a: 8 — ждём Disassoc от хоста (1 после) */
    struct rx_pkt *rx_pkt;                     /* 0x2c: сохранённый RX-кадр Assoc (WMI_CONNECT_EVENT) */
    struct rx_pkt *host_pkt;                   /* 0x30: кадр, отданный хосту (split MAC) */
};
CONN_OFF(struct mlme_sm, busy, 0x0c);
CONN_OFF(struct mlme_sm, conn, 0x20);
CONN_OFF(struct mlme_sm, status, 0x28);
CONN_OFF(struct mlme_sm, rx_pkt, 0x2c);
_Static_assert(sizeof(struct mlme_sm) == 0x34, "mlme_sm");

/* Автомат разрыва соединения conn_disc_sm (vendor sm_8027a0; conn+0x130 = conn_main_sm+0xc,
 * 0x20 Б). Имена — из таблиц строк vendor (0x8004d4 / 0x801124). */
enum { CONN_DISC_INITIAL = 0, CONN_DISC_WAIT_FOR_DISC_DONE = 1 };
enum {
    CONN_DISC_EV_OWN_START = 0, CONN_DISC_EV_NTF_SW_DATA_STOPPED = 1,
    CONN_DISC_EV_NTF_MLME_DISC_DONE = 2, CONN_DISC_EV_NTF_LMS_STOPPED = 3,
    CONN_DISC_EV_NTF_FW_TX_STOPPED = 4, CONN_DISC_EV_OWN_DISC_DONE = 5,
    CONN_DISC_EV_READY_FOR_FLUSH = 6,
};
struct conn_disc_sm {
    struct basic_sm sm;                        /* 0x00 */
    struct conn_msm *msm;                      /* 0x08: владелец */
    u32 steps;                                 /* 0x0c: шаги (бит 0 TX, 1 данные хоста, 2 LMS, 3 сброс) */
    u32 del_flag;                              /* 0x10: удалить стримы с флагом (причины 1/2/7) */
    u8  reason;                                /* 0x14: причина разрыва */
    u8  rsv15;                                 /* 0x15 */
    u16 proto;                                 /* 0x16: код протокола */
    u32 wait;                                  /* 0x18: ждём завершения TX Disassoc */
    u32 wait_timer;                            /* 0x1c: таймер ожидания */
};
CONN_OFF(struct conn_disc_sm, steps, 0x0c);
CONN_OFF(struct conn_disc_sm, proto, 0x16);
CONN_OFF(struct conn_disc_sm, wait_timer, 0x1c);
_Static_assert(sizeof(struct conn_disc_sm) == 0x20, "conn_disc_sm");

/* Автомат соединения conn_main_sm (описатель 0x802744, conn+0x124, 0x40 Б). Состояния:
 * 0 UNRESOURCED, 1 WAIT_FOR_BCON_RX, 2 WAIT_FOR_LINKUP, 3 READY_FOR_ASSOC,
 * 4 WAIT_FOR_ASSOC_DONE, 5 ASSOCIATED, 6 WAIT_FOR_LM_START, 7 KEY_ASSOC, 8 WAIT_FOR_DISCONN. */
enum {
    CONN_MSM_UNRESOURCED = 0, CONN_MSM_WAIT_FOR_BCON_RX = 1, CONN_MSM_WAIT_FOR_LINKUP = 2,
    CONN_MSM_READY_FOR_ASSOC = 3, CONN_MSM_WAIT_FOR_ASSOC_DONE = 4, CONN_MSM_ASSOCIATED = 5,
    CONN_MSM_WAIT_FOR_LM_START = 6, CONN_MSM_KEY_ASSOC = 7, CONN_MSM_WAIT_FOR_DISCONN = 8,
};
/* События (имена vendor SM_EVT_*, 0x8010ec). */
enum {
    CONN_MSM_EV_OWN_START_LINK = 0, CONN_MSM_EV_BCON_RX = 1, CONN_MSM_EV_NTF_LINKUP = 2,
    CONN_MSM_EV_OWN_ASSOC = 3, CONN_MSM_EV_NTF_ASSOC_START = 4, CONN_MSM_EV_NTF_ASSOC_DONE = 5,
    CONN_MSM_EV_NTF_LM_STARTED = 6, CONN_MSM_EV_NTF_KEY_INSTALLED = 7, CONN_MSM_EV_OWN_DISC = 8,
    CONN_MSM_EV_NTF_DISC_COMPLETE = 9, CONN_MSM_EV_OWN_ABORT = 10,
};
struct conn_msm {
    struct basic_sm sm;                        /* 0x00 */
    struct conn *conn;                         /* 0x08: владелец */
    struct conn_disc_sm disc;                  /* 0x0c: автомат разрыва */
    u32 bcon_timer;                            /* 0x2c: таймер ожидания бикона */
    u32 assoc_wait_timer;                      /* 0x30: AP — ожидание Assoc Request после линк-апа (наше; у vendor
                                                * не используется, обнуляет конструктор) */
    u32 lm_started;                            /* 0x34: линк-менеджер уже запущен */
    u32 lm_start_req;                          /* 0x38: запуск линк-менеджера запрошен */
    u8  bcon_tries;                            /* 0x3c: попытки ожидания бикона */
    u8  rsv3d[3];                              /* 0x3d */
};
CONN_OFF(struct conn_msm, disc, 0x0c);
CONN_OFF(struct conn_msm, bcon_timer, 0x2c);
CONN_OFF(struct conn_msm, bcon_tries, 0x3c);
_Static_assert(sizeof(struct conn_msm) == 0x40, "conn_msm");


/* Соединение (0x1a0 Б): элемент пула conn_mgr.conn_pool, узел списка соединений записи
 * mid ([mid+0x18]). */
struct conn {
    u32 next;                                  /* 0x00: узел llist (список mid+0x18) */
    u32 owner;                                 /* 0x04: список-владелец */
    u8  cid;                                   /* 0x08 */
    u8  aid;                                   /* 0x09 */
    u8  n_vrings;                              /* 0x0a: добавлено vring (stream_mgr; 0 — connection__init) */
    u8  reassoc_req;                           /* 0x0b: последний запрос станции — Reassociation Request (ответ —
                                                * Reassociation Response, 9.3.3.8); наше, у vendor — выравнивание */
    u16 rx_sector;                             /* 0x0c: RX-сектор пира (0xffff — не выбран) */
    u8  rsv0e[2];                              /* 0x0e */
    u32 bcon_time;                             /* 0x10: время бикона / пробы (u_schd_now) */
    u8  bf_byte;                               /* 0x14: байт 12 события BF LMAC */
    u8  rsv15[3];                              /* 0x15 */
    struct mid *mid;                           /* 0x18: запись mid (BSS) */
    union {                                    /* 0x1c: MAC пира; vendor читает и словом + полусловом */
        u8 peer[6];
        struct {
            u32 peer_lo;
            u16 peer_hi;
        };
    };
    u32 initiator;                             /* 0x24: мы инициатор (STA) */
    u32 pbss;                                  /* 0x28: член PBSS без обмена Assoc */
    u32 skip_bf;                               /* 0x2c: линк уже есть — линк-ап без BF (повторная проба) */
    u8  tk[16];                                /* 0x30: парный ключ (обратный порядок байт) */
    u8  tk_idx;                                /* 0x40: индекс ключа */
    u8  rsv41[3];                              /* 0x41 */
    u32 wvs_mode;                              /* 0x44: Wilocity VS пира (старый формат / тестовый режим) */
    u32 sw_tx_busy;                            /* 0x48: кадр хоста (SW TX mgmt) ждёт линка */
    u8  sw_tx_sent;                            /* 0x4c: кадр хоста отправлен */
    u8  retry_cnt;                             /* 0x4d: счётчик таймера повтора */
    u8  rsv4e[2];                              /* 0x4e */
    u32 retry_timer;                           /* 0x50: таймер повтора (conn__arm_retry_timer) */
    u8  bf_win_pos;                            /* 0x54: позиция в окне BF id */
    u8  bf_win[16];                            /* 0x55: окно значений BF id */
    u8  rsv65[3];                              /* 0x65 */
    u32 bf_win_sum;                            /* 0x68: сумма окна */
    u8  bf_win_fill;                           /* 0x6c: заполнено */
    u8  rsv6d[3];                              /* 0x6d */
    struct lm_if lm;                           /* 0x70 */
    struct mlme_sm mlme;                       /* 0xf0 */
    struct conn_msm msm;                       /* 0x124 */
    u8  rsv164[0x20];                          /* 0x164: автомат сессии FTM — только SparRAW-pro */
    u32 vs_version;                            /* 0x184: версия Wilocity VS пира (set_vendor_specific_version; 1 после init) */
    u32 features_ver;                          /* 0x188: features_version_tracking пира (0xffff — неизвестно) */
    u8  rsv18c;                                /* 0x18c */
    u8  bf_avg;                                /* 0x18d: среднее окна BF id */
    u8  bf_last;                               /* 0x18e: последнее BF id */
    u8  dmg_caps[0x11];                        /* 0x18f: DMG Capabilities пира (из Probe Req) */
};
CONN_OFF(struct conn, cid, 0x08);
CONN_OFF(struct conn, rx_sector, 0x0c);
CONN_OFF(struct conn, mid, 0x18);
CONN_OFF(struct conn, peer, 0x1c);
CONN_OFF(struct conn, initiator, 0x24);
CONN_OFF(struct conn, tk, 0x30);
CONN_OFF(struct conn, wvs_mode, 0x44);
CONN_OFF(struct conn, retry_timer, 0x50);
CONN_OFF(struct conn, bf_win, 0x55);
CONN_OFF(struct conn, bf_win_fill, 0x6c);
CONN_OFF(struct conn, lm, 0x70);
CONN_OFF(struct conn, mlme, 0xf0);
CONN_OFF(struct conn, msm, 0x124);
CONN_OFF(struct conn, msm.disc, 0x130);
CONN_OFF(struct conn, rsv164, 0x164);
CONN_OFF(struct conn, vs_version, 0x184);
CONN_OFF(struct conn, features_ver, 0x188);
CONN_OFF(struct conn, bf_avg, 0x18d);
CONN_OFF(struct conn, dmg_caps, 0x18f);
_Static_assert(sizeof(struct conn) == 0x1a0, "conn");

/* Элемент списка ранжирования (0xc Б, пул conn_mgr.rank_pool). */
struct conn_rank {
    u32 next;                                  /* 0x00: узел llist */
    u32 owner;                                 /* 0x04 */
    struct conn *conn;                         /* 0x08 */
};
_Static_assert(sizeof(struct conn_rank) == 0xc, "conn_rank");

/* Слот cid_db (8 Б). */
struct conn_cid_slot {
    u32 used;                                  /* 0x00: 1 — занят */
    struct conn *conn;                         /* 0x04 */
};
_Static_assert(sizeof(struct conn_cid_slot) == 8, "conn_cid_slot");

/* База соединений conn_mgr (0x854000, 0xdd4 Б). */
struct conn_mgr {
    struct llist rank_list;                    /* 0x000: ранжирование соединений */
    struct conn_rank rank_elems[CONN_MAX];     /* 0x00c: хранилище rank_pool */
    struct mem_pool rank_pool;                 /* 0x06c */
    struct conn_cid_slot cid_db[CONN_MAX];     /* 0x080: cid → conn */
    struct mem_pool conn_pool;                 /* 0x0c0 */
    struct conn conns[CONN_MAX];               /* 0x0d4: хранилище conn_pool */
};
CONN_OFF(struct conn_mgr, rank_elems, 0x00c);
CONN_OFF(struct conn_mgr, rank_pool, 0x06c);
CONN_OFF(struct conn_mgr, cid_db, 0x080);
CONN_OFF(struct conn_mgr, conn_pool, 0x0c0);
CONN_OFF(struct conn_mgr, conns, 0x0d4);
_Static_assert(sizeof(struct conn_mgr) == 0xdd4, "conn_mgr");

/* Экземпляр — символ fw/fw.ld (рабочая память, не DCCM). */
extern struct conn_mgr conn_mgr;               /* 0x854000 */

/* События вложенным автоматам (basic_sm_handle_event и sm_defer_call из fw/proto.h принимают
 * объект указателем). */
static inline void mlme_sm_event(struct mlme_sm *sm, u32 ev, u32 a0, u32 a1, u32 a2)
{
    basic_sm_handle_event(sm, ev, a0, a1, a2);
}

static inline void mlme_sm_defer(struct mlme_sm *sm, u32 ev, u32 a0, u32 a1, u32 a2)
{
    sm_defer_call(sm, ev, a0, a1, a2);
}

static inline void conn_msm_event(struct conn_msm *sm, u32 ev, u32 a0, u32 a1, u32 a2)
{
    basic_sm_handle_event(sm, ev, a0, a1, a2);
}

static inline void conn_msm_defer(struct conn_msm *sm, u32 ev, u32 a0, u32 a1, u32 a2)
{
    sm_defer_call(sm, ev, a0, a1, a2);
}

static inline void conn_disc_event(struct conn_disc_sm *d, u32 ev, u32 a0, u32 a1, u32 a2)
{
    basic_sm_handle_event(d, ev, a0, a1, a2);
}

/* Автоматы соединения в fw_data (ид [0x10] описателя пишут конструкторы fw/ctors.c):
 * mlme_sm — fw/mlme.c, conn_main_sm — fw/conn.c, conn_disc_sm — fw/link_sm.c. */
extern struct sm_desc mlme_sm_desc;                           /* 0x802458 */
extern const struct sm_trans mlme_sm_table[14][3];            /* 0x80246c */
extern struct sm_desc conn_msm_desc;                          /* 0x802744 */
extern const struct sm_trans conn_msm_table[11][9];           /* 0x802554 */
extern struct sm_desc conn_disc_sm_desc;                      /* 0x8027a0 */
extern const struct sm_trans conn_disc_sm_table[7][2];        /* 0x802758 */

#endif
