// SPDX-License-Identifier: AGPL-3.0-or-later
/* STREAM_MGR — стримы (TX vring хоста ↔ соединение/TID) и их контекст.
 *
 * Контекст стрима — struct stream_ctx (include/stream.h; 0x78 Б, пул 0x847b34, элементы
 * stream_ctxs 0x847b48 × 9; таблица стримов по номеру vring stream_by_vr — 0x847f80);
 * vt 0x800888 ставит статический конструктор массива 0x8c1c28 (элемент — 0x8ed190).
 * Запись vring_tbl — struct vring_tbl_entry (include/vring_schd.h). */
#include "../include/types.h"
#include "../include/wmi.h"
#include "../include/mid.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/vring_schd.h"
#include "../include/conn.h"
#include "../include/stream.h"
#include "../include/macq_desc.h"
#include "../include/fwdata.h"

/* vring__get_pring_id (0x8cbed8, 14 Б): bcast-стрим — pring 8, иначе cid соединения. */
u32 vring_get_pring_id(const struct stream_ctx *ctx)
{
    if (ctx->bcast != 0)
        return 8;
    return ctx->conn->cid;
}

/* vring__get_pring_id_of_obj (0x8cbec8, 6 Б): то же для владельца автомата стрима. */
u32 vring_get_pring_id_of_obj(const struct stream_sm *obj)
{
    return vring_get_pring_id(obj->ctx);
}

/* stream_mgr__pring_by_index (0x8da0dc, 46 Б): поле +0xc (bcast) стрима vring vr. */
u32 stream_mgr_pring_by_index(u32 vr)
{
    struct stream_ctx *s = stream_by_vr[vr];
    if (s == 0)
        fw_sysassert_fatal((void *)0, 0x6030);
    return s->bcast;
}

/* vring__active_ring_table (0x8cd080, 22 Б): объект vring_schd текущего режима. */
struct vring_schd_if *vring_active_ring_table(void)
{
    if (vring_pair_mode == 1u)
        return &vring_schd_alt.base;
    return &vring_schd.base;
}

/* hwd_dma__macq_reg_addr (0x8d083c, 12 Б): адрес регистра хвоста vring (для CFG_DONE). */
u32 hwd_dma_macq_reg_addr(u32 idx)
{
    return ((idx << 8) + 0x440c100u) >> 3;
}

/* vring_ctx__alloc (0x8c3490, 38 Б). */
struct stream_ctx *vring_ctx_alloc(void)
{
    struct stream_ctx *ctx = mem_pool_allocate(&stream_pool);
    if (ctx == 0)
        fw_sysassert_fatal((void *)0, 0x1085);
    return ctx;
}

/* wmi_vring_cfg__with_847b34 (0x8cb204, 12 Б): вернуть контекст в пул. */
void wmi_vring_cfg_with_847b34(struct stream_ctx *c)
{
    stream_mgr_check_vring(&stream_pool, c);
}

/* sm_obj__store_desc (0x8d96c0, 60 Б): поля контекста стрима + конструктор ba_sm. noinline —
 * как у vendor отдельная функция (с полями по имени gcc встраивает её в vring_configure_tx
 * и переставляет записи). */
__attribute__((noinline)) void sm_obj_store_desc(struct stream_ctx *d, u8 vr, struct conn *conn, u8 tid, u32 ba_en,
                       u8 tbl_vr, u8 pring_type, u32 mid, u32 bcast)
{
    d->conn = conn;
    d->tid = tid;
    d->ba_en = ba_en;
    d->removing = 0;
    d->ssn = 0;
    d->tbl_vr = tbl_vr;
    d->pring_type = pring_type;
    d->vr = vr;
    d->mid = mid;
    d->configured = 0;
    d->bcast = bcast;
    obj_vt80296c_ctor(&d->sm, d);
}

/* mid__type_of (0x8ccecc, 54 Б): тип MID по типу сети записи. */
u32 mid_type_of(const struct mid *mid)
{
    switch (mid->network_type) {
    case 4:
    case 2:
    case 0x20:
        return 0;
    case 1:
        return 1;
    case 0x10:
        return 2;
    default:
        fw_sysassert_fatal((void *)0, 0x11f5);
        return 0;
    }
}

/* l2mgr__program_args (0x8c6c04, 40 Б): адреса RA/TA в TX-дескриптор очереди. */
u32 l2mgr_program_args(const struct vring_tbl_entry *e, const void *p1, const void *p2, u8 a3, u8 a4,
                       u8 a5)
{
    struct macq_qdesc buf;
    tx_dma_build_desc(buf.addr, p1, p2, a3, 0, a5, a4);
    return qh_write_or_conn_alloc(e->macq, 8, &buf, 0);
}

/* mac_enable_bcast_ring (0x8c14d4, 28 Б). */
void mac_enable_bcast_ring(void)
{
    MMIO32(HW_L2_OFFLOAD_TX_CTL) |= 1u;
    MMIO32(HW_DMA_OFFLOAD_DECAP_CFG) |= (1u << 7);
}

/* vring_hw__clear_tx_ctl_bit0 (0x8df5b4, 14 Б). */
void vring_hw_clear_tx_ctl_bit0(void)
{
    MMIO32(HW_L2_OFFLOAD_TX_CTL) &= ~1u;
}

/* tx_macq__setup_params (0x8c6e44, 74 Б): параметры TX MACQ записи vring_tbl.
 * Поле +0xe — 16 бит (ldw/stw): прежний порт писал u32 по невыровненному адресу. */
void tx_macq_setup_params(struct vring_tbl_entry *e, u32 a1, u32 a2, u32 a3, u32 a4)
{
    struct macq_qdesc buf;
    e->sector_mode = (u8)a1;
    e->to_res = (u8)a3;
    e->ctl = (u16)((e->ctl & ~2u) | ((a2 & 1u) << 1));
    ba_sm_addba_at_10(e, &buf, a1, a2, e->to_res, a4);
    qh_write_or_conn_alloc(e->macq, 2, &buf, 0);
}

/* 0x802450: адреса MACQ-записи широковещательного vring (vring__configure_tx: mov_s
 * r1,0x802450; ld_s/ldw_s). В образе vendor — нули (не ff:ff:…), и никто их не пишет:
 * vendor программирует bcast-запись нулевым MAC — повторено как есть. Читается по значению —
 * не const (чтение DCCM, как у vendor). */
FWDATA(802450) u16 vring_bcast_addr[3] = { 0, 0, 0 };

/* vring__configure_tx (0x8e6024, 172 Б): контекст стрима (соединение cfg) + MACQ записи
 * vring_tbl. Для bcast (a11 != 0) адреса — vring_bcast_addr (6 Б, 0x802450). */
u32 vring_configure_tx(struct stream_ctx *desc, u32 idx, struct conn *cfg, u8 a3, u32 a4, u32 flag,
                       u32 a6, u32 a7, u8 a8, u8 a9, u32 a10, u32 a11)
{
    struct vring_tbl_entry *entry;
    (void)a4;                                       /* vendor: r4 затирается нулём (8e602a) */
    sm_obj_store_desc(desc, (u8)idx, cfg, a3, 0, (u8)idx, a8, a10, a11);
    entry = vring_tbl_entry_addr(idx);
    if (a11 != 0) {
        u16 bc[3];
        bc[0] = vring_bcast_addr[0];
        bc[1] = vring_bcast_addr[1];
        bc[2] = vring_bcast_addr[2];
        l2mgr_program_args(entry, bc, bc, 8, a9, 255);
    } else {
        struct mid *mid = cfg->mid;
        l2mgr_program_args(entry, cfg->peer, mid->mac, cfg->cid,
                           (u8)mid_type_of(mid), 255);
    }
    if (flag != 0 && flag != 1) {
        mac_enable_bcast_ring();
        tx_macq_setup_params(entry, 0, a7, a6, 0);
    } else {
        vring_hw_clear_tx_ctl_bit0();
        tx_macq_setup_params(entry, 1, a7, a6, 0);
    }
    desc->configured = 1;
    return 1;
}

/* stream_mgr__install_ba_rule (0x8dfc34, 36 Б): 6 правил ключей для соединения. */
void stream_mgr_install_ba_rule(u32 a, u32 b)
{
    for (u32 i = 0; i < 6; i++)
        install_key_parse_flags(a, i, b);
}

/* l2mgr__send_vring_en_evt (0x8f8ee4, 70 Б): событие 0x1865 {vring} хосту. */
void l2mgr_send_vring_en_evt(u32 vring, u32 chan)
{
    u8 *p = (u8 *)host_if_send_pair();
    memset0_words(p, 4);
    p[0] = (u8)vring;
    fw_log_emit1(0x2b, 0x100d534, vring);
    low_sme_send_evt2sw(p, 0x1865, 4, chan, 0, 0, 0);
}

/* STREAM_MGR::ADD (0x8c2dc4, 310 Б): зарегистрировать стрим ctx (cfg — vring_cfg
 * WMI-команды, mpdu — max_mpdu_size): в vring_schd (vt[3]), правила ключей, при
 * agg_max_wsize — BA (vt[6] контекста), ответ WMI_VRING_CFG_DONE; для соединения в
 * состоянии 7 — ещё событие 0x1865. Возврат 0 — успех (ctx остаётся у стрима). */
u32 STREAM_MGR_ADD(struct stream_ctx *ctx, const struct wmi_vring_cfg *cfg, u32 mpdu)
{
    u32 vr = ctx->vr;
    struct conn *conn = conn_mgr_by_cid(cfg->cidxtid & 0xfu);
    u32 st;

    if (conn == 0)
        fw_sysassert_fatal((void *)0, 0x128a);
    if (stream_by_vr[vr] != 0) {
        fw_log_emit1(0x2b, 0x1010a3c, vr);
        l2mgr_send_vring_cfg_done(vr, hwd_dma_macq_reg_addr(vr), 1,
                                  conn->mid->id);
        return 1;
    }
    stream_by_vr[vr] = ctx;

    if (conn->mlme.sm.state != 2 && conn->mlme.busy == 0) {
        st = 1;
    } else {
        struct vring_schd_if *tbl;
        conn->n_vrings = (u8)(conn->n_vrings + 1);
        tbl = vring_active_ring_table();
        tbl->vt->add_vring(tbl, &cfg->tx_sw_ring, ctx, &cfg->schd_params, 1);
        stream_mgr_install_ba_rule(conn->cid, 2);
        {
            u32 agg = cfg->agg_max_wsize;
            if (agg == 0) {
                fw_log_emit1(0x2b, 0x1010aec, mpdu);
                st = 0;
            } else if (agg * mpdu > 0x14000u) {
                fw_log_emit2(0x2b, 0x1010ab8, agg, mpdu);
                st = 1;
            } else {
                fw_log_emit2(0x2b, 0x1010a74, agg, mpdu);
                /* vt[6] контекста (0x8c4124 sw_vring::ba_agreed): BA с окном agg */
                ctx->vt->ba_agreed(ctx, cfg->agg_max_wsize, 0, 0);
                st = 0;
            }
        }
    }

    l2mgr_send_vring_cfg_done(vr, hwd_dma_macq_reg_addr(vr), st & 0xffu,
                              conn->mid->id);
    if (st != 0)
        return st;
    if (conn->msm.sm.state == 7)
        l2mgr_send_vring_en_evt(vr, conn->mid->id);
    return 0;
}

/* stream_mgr::delete_vring (0x8c8ebc, 102 Б): удаление стрима — событие автомату ba_sm
 * (6/0x24 для широковещательного стрима, иначе 1/0x25). */
void stream_mgr_delete_vring(u32 vring)
{
    struct stream_ctx *s;
    if (vring >= STREAM_VR_N) {
        fw_log_emit1(0x1b, 0x1010b68, vring);
        return;
    }
    s = stream_by_vr[vring];
    if (s == 0)
        return;
    if (s->bcast != 0) {
        fw_log_emit2(0x2b, 0x1010b34, vring, 1);
        s->removing = 1;
        ba_sm_evt_type(s, 6, 0x24, 0, 0);
    } else {
        s->ba_en = 0;
        s->removing = 1;
        ba_sm_evt_type(s, 1, 0x25, 0, 0);
    }
}

