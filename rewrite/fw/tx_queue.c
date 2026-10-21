// SPDX-License-Identifier: AGPL-3.0-or-later
/* TX-очереди MAC (TX MACQ) под vring хоста: записи vring_tbl (0x806014 + i*16) и их
 * MACQ-дескрипторы. Создаются при WMI_CFG_RX_CHAIN (disc_sm__sw_data_stopped) —
 * [0x8001f4] (10) очередей с общим окном 0x2000..0x2800. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/fwq_tx.h"
#include "../include/vring_schd.h"
#include "../include/macq_desc.h"
#include "../include/sys_cfg.h"


/* Поле w бит [lo .. lo+n-1] = v (vendor bits__set32_* → bf__set_field_word_fw). */
static void bf32(u32 *w, u32 lo, u32 n, u32 v)
{
    u32 m = ((n >= 32) ? 0xffffffffu : ((1u << n) - 1u)) << lo;
    *w = (*w & ~m) | ((v << lo) & m);
}

/* fixed_sched__get_entry_count (0x8ccec8, 4 Б): число TX-очередей [gp+112] = [0x8001f4]
 * (в образе 10; vendor его не меняет). */
u32 fixed_sched_get_entry_count(void)
{
    return txq_count;
}

/* txq_ring_param_config_queue (0x8ea4b8, 222 Б): MACQ-дескриптор d TX-окна по параметрам p. */
void txq_ring_param_config_queue(struct macq_desc *d, u32 mpdu, const struct txq_ring_param *p,
                                 u32 type)
{
    u32 start = p->start;
    u32 n;
    if (type == 4) {
        if ((s32)start < 0x3000 || (s32)(p->lines + start) > 0x5200)
            fw_sysassert_fatal((void *)0, 0x1020);
    } else {
        if ((s32)start < 0x2000 || (s32)(p->lines + start) > 0x5200)
            fw_sysassert_fatal((void *)0, 0x1557);
    }
    n = (mpdu + 7) >> 3;
    if (n + 9 >= p->lines) {
        fw_log_emit3(0, 0x101346c, p->lines, n, 9);
        fw_sysassert_fatal((void *)0, 0x1024);
    }
    if ((s32)p->param_b < 6)
        fw_sysassert_fatal((void *)0, 0x1021);
    d->rd = p->start;
    d->wr = p->start;
    d->base = p->start;
    d->lines = p->lines;
    bf32(&d->w2, 0, 12, n & 0xfffu);                          /* 0x8ed340 */
    bf32(&d->w2, 12, 12, p->param_a & 0xfffu);                /* 0x8ed3a0 */
    d->param_a_lo = (u8)p->param_a;
    bf32(&d->w3, 0, 4, (p->param_a >> 8) & 0xfu);             /* 0x8ed370 */
    bf32(&d->w3, 16, 12, p->param_a & 0xfffu);                /* 0x8ed3e8 */
    bf32(&d->w3, 4, 12, p->param_b & 0xfffu);                 /* 0x8ed4f0 */
    bf32(&d->w3, 28, 4, 0);                                   /* 0x8ed4a8 */
}

/* tx_macq__config_ring_params (0x8e29b8, 118 Б): окно TX MACQ записи e. */
void tx_macq_config_ring_params(struct vring_tbl_entry *e, u32 a1, u32 a2, u32 start, u32 size,
                                u32 mpdu)
{
    struct {
        struct txq_ring_param p;               /* sp+0 */
        struct macq_desc d;                    /* sp+0xc */
    } sp;
    if (e->state != 0)
        fw_sysassert_fatal((void *)0, 0x127c);
    e->win_start = (u16)start;
    e->param_a = (u16)a1;
    e->win_lines = (u16)size;
    e->param_b = (u16)a2;
    sp.p.macq = e->macq;
    sp.p.start = (u16)start;
    sp.p.lines = (u16)size;
    sp.p.param_a = (u16)a1;
    sp.p.param_b = (u16)a2;
    txq_ring_param_config_queue(&sp.d, mpdu, &sp.p, e->mode);
    macq_desc_write(&sp.d, e->macq, 2, 0, 0, 0, 0, 1);
    e->state = 1;
}

/* sm_pring__all_wb_done_evt (0x8c3180, 12 Б; имя vendor ошибочно): дескриптор режима
 * очереди в буфер +0x20. */
void sm_pring_all_wb_done_evt(const struct vring_tbl_entry *e, struct macq_qdesc *buf)
{
    tx_queue_config_by_mode(&buf->mode, e->mode);
}

/* ba_sm__addba_at_08 (0x8c4540, 20 Б): дескриптор очереди по типу в буфер +0x40.
 * vendor: add3 r0,r1,0x8 = r1 + (8 << 3). Прежний порт клал дескриптор в buf+8, и
 * qh_write_by_flags_fw (флаг 0x10) отдавал в MACQ из buf+0x40 остатки стека — MTP
 * отказывал в передаче из очереди (r45 null_status 0x81, probe не уходил). */
void ba_sm_addba_at_08(const struct vring_tbl_entry *e, struct macq_qdesc *buf, u32 a2, u32 a3,
                       u32 a4, u32 a5, u32 a6)
{
    qdesc_build_by_type(&buf->ba, e->mode, a2, a3, a4, a5, a6);
}

/* tx_macq__setup (0x8d944c, 146 Б): тип очереди, параметры и дескрипторы (LMAC/MACQ),
 * для типов кроме 5/6 — очередь MAC выключена. a2 vendor не использует (r2 затирается). */
void tx_macq_setup(struct vring_tbl_entry *e, u32 mode, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6,
                   u32 a7)
{
    struct macq_qdesc buf;
    (void)a2;
    if (e->state != 1)
        fw_sysassert_fatal((void *)0, 0x127b);
    e->mode = (u8)mode;
    e->max_mpdu = 0x1f28;
    tx_macq_setup_params(e, 0, a3, 0xa, 0);
    sm_pring_all_wb_done_evt(e, &buf);
    ba_sm_addba_at_08(e, &buf, a6, a4, a5, a7, 1);
    qh_write_or_conn_alloc(e->macq, 0x14, &buf, a5);
    if (mode != 5 && mode != 6)
        mac_ring_enable(e->macq, 0);
    e->state = 2;
}

/* tx_queue_mgr__create_queue (0x8d9978, 220 Б): count записей vring_tbl от first —
 * окна (a2..a5; при a7 == 0 следующие сдвигаются) и тип mode. */
void tx_queue_mgr_create_queue(u32 count, u32 first, u32 a2, u32 a3, u32 a4, u32 a5,
                               u32 mpdu, u32 a7, u32 mode)
{
    struct vring_tbl_entry *e = &vring_tbl[first];
    if (mode == 4)
        fw_sysassert_fatal((void *)0, 0x128d);
    for (u32 i = first; i < first + count; i++, e++) {
        u32 t = 0, b;
        e->macq = (u8)i;
        e->max_mpdu = (u16)mpdu;
        tx_macq_config_ring_params(e, (u16)a2, (u16)a3, (u16)a4, (u16)a5, mpdu);
        if (mode == 3)
            t = 7;                                  /* OOB R1 (только SparRAW-pro): 6 */
        b = txq_dma_mode_tbl[0].mode;               /* vendor: ldb_s [0x8031c8, 1] — без индекса */
        tx_macq_setup(e, mode, b == 0, b == 1, (u8)t, 0, 0, 0);
        if (a7 == 0) {
            a4 += a5;
            a2 += a3;
        }
    }
}
