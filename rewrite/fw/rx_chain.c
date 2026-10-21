// SPDX-License-Identifier: AGPL-3.0-or-later
/* RX-chain setup (0x820-обработчик): rx_macq_setup + rx_chain_configure + l2_offload. .textlate. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/rx_ring.h"
#include "../include/ieee80211.h"
#include "../include/macq_desc.h"
#include "../include/fwdata.h"


/* rx_chain__configure (0x8c44bc, 76 Б). */
__attribute__((section(".textlate"))) void rx_chain_configure(u32 cfg, u32 a1, u32 a2, u32 a3, u32 a4)
{
    const struct rx_macq_cfg *d = (const struct rx_macq_cfg *)cfg;
    rx_chain_build_desc(rx_macq_bufs.chain.w, d->type, a1, a2, a3, a4, d->sniffer);
    macq_desc_write(rx_macq_bufs.chain.w, d->queue, 1, 3, 0, 0, 0, 3);
}

/* disc_sm__sw_data_stopped (0x8f9c1c, 138 Б): TX-очереди (их [0x8001f4] = 10 — прежде
 * здесь стоял 0, и очереди/pring не создавались), пул vring, pring 0 и 1, кольца DMA 0/1. */
__attribute__((section(".textlate"))) void disc_sm_sw_data_stopped(void)
{
    u32 count = fixed_sched_get_entry_count();
    if (count != 0) {
        tx_queue_mgr_create_queue(count, 0, 0, 0x40, 0x2000, 0x2800, 0x1f28, 1, 5);
        pring_init_pool();
        vring_schd_add_sniffer_vring(0, 0x2000, 0x2800);
        dma_mgr_configure_ring(0, 0, 0, 0, 0, 0, 0, 0);
    }
    dma_mgr_configure_ring(1, 0, 0, 0, 0, 0, 0, 0);
    vring_schd_add_sniffer_vring(1, 0x4800, 0x800);
    disc_sw_data_active = 0;
}

/* rx_chain__reg_8813c8_addr (0x8d0834, 8 Б): адрес регистра хвоста RX-кольца для ответа
 * WMI_CFG_RX_CHAIN_DONE. */
__attribute__((section(".textlate"))) u32 rx_chain_reg_8813c8_addr(void)
{
    return HW_DMA_DESCQ2_SW_TAIL;
}

/* rx_macq__build_ba_desc (0x8e4448): дескриптор BA-окна RX-MACQ (struct macq_desc). win —
 * struct rx_ba_win_params (кладёт rx_macq_program_ba_win).
 * Прежний порт читал поля как u32 (соседние перекрывались, +6 невыровнен) — ложный
 * ассерт 0x1502 и мусор в дескрипторе. */
static inline void bf_set32(u32 *w, u32 lo, u32 hi, u32 v)
{
    u32 m = ((hi - lo == 31) ? 0xffffffffu : ((1u << (hi - lo + 1)) - 1)) << lo;
    *w = (*w & ~m) | ((v << lo) & m);
}
__attribute__((section(".textlate"))) void rx_macq_build_ba_desc(struct macq_desc *dst, u32 len,
                                                                 const struct rx_ba_win_params *w, u32 mode)
{
    u32 off = (len + 7u) >> 3;
    if ((MMIO32(HW_RX_Q_BASE_CFG) & 0x3ffu) + off >= w->size)
        fw_sysassert_fatal(0, 0x101b);
    s32 start = w->start, end = (s32)w->start + w->size;
    if (mode == 3u) {
        if (start < 0xc00 || end > 0x2000) fw_sysassert_fatal(0, 0x101c);
    } else {
        if (start < 0xc00 || end > 0x3000) fw_sysassert_fatal(0, 0x1502);
    }
    dst->rd = w->start;
    dst->wr = w->start;
    dst->base = w->start;
    dst->lines = w->size;
    u32 *p8 = &dst->w2, *pc = &dst->w3;
    bf_set32(p8, 0, 11, off & 0xfff);           /* 0x8ed340 */
    bf_set32(p8, 12, 23, w->param_a & 0xfff);   /* 0x8ed3a0 */
    dst->param_a_lo = (u8)w->param_a;
    bf_set32(pc, 0, 3, (w->param_a >> 8) & 0xf);    /* 0x8ed370 */
    bf_set32(pc, 16, 27, w->param_a & 0xfff);   /* 0x8ed3e8 */
    *pc &= ~(1u << 28);
    bf_set32(pc, 4, 15, w->param_b & 0xfff);    /* 0x8ed4f0 */
    bf_set32(pc, 29, 31, 0);                    /* 0x8ed4c0 */
}
__attribute__((section(".textlate"))) void rx_macq_pack_desc(u32 *desc, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6, u32 a7)
{
    u32 w;
    if (MMIO32(HW_RX_Q_BASE_CFG) & (1u << 10)) { if (a3 != 0u) fw_sysassert_fatal(0, 0x1017u); }
    w = desc[0];
    w = (w & ~((1u<<19)|(1u<<20))) | ((a3 & 1u) << 19) | (((a5==0u)?1u:0u) << 20);
    desc[0] = w;
    if (a1 == 2u) { ((u8*)desc)[1] = 0x89; desc[0] = (desc[0] & ~(0x1fu<<21)) | (0x8u<<21); desc[0] |= (1u<<16); }
    else if (a1 == 3u) { ((u8*)desc)[1] = 0xcb; desc[0] &= ~(0x1fu<<21); desc[0] &= ~(1u<<16); }
    else { ((u8*)desc)[1] = 0xdf; desc[0] = (desc[0] & ~(0x1fu<<21)) | (((a5*24u)&0x1fu)<<21); desc[0] &= ~(1u<<16); }
    w = desc[0];
    w = (w & ~((1u<<17)|(1u<<18))) | (1u<<18) | ((a5 & 1u) << 17);
    w = (w & ~((1u<<6)|(1u<<7))) | (1u<<5) | ((a7 & 1u) << 6) | ((a4 & 1u) << 7);
    desc[0] = w;
    desc[0] = (desc[0] & ~(0xfu<<28)) | (1u<<28);
    desc[0] = (desc[0] & ~(0x3u<<26)) | ((a6 & 3u) << 26);
    w = desc[1];
    w = (w & ~0x1fffu) | (a2 & 0x1fffu);
    desc[1] = w;
    if (a1 == 3u) desc[1] |= (1u << 14);
}
/* 0x802810: таблица переходов switch vendor ese__set_alloc_type (0x8e4220;
 * ldb, цель = 0x8e424e + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(802810) const u8 ese_set_alloc_type_jt[5] = {
    0x00, 0x07, 0x0b, 0x2e, 0x2e,
};

__attribute__((section(".textlate"))) void ese_set_alloc_type(void *p, u32 mode, u32 type, u32 flag)
{
    u32 *w = (u32 *)p; (void)flag;
    memset0_words(p, 0x10);
    w[0] = 0;
    if (type < 5) {
        w[1] = 0;
        switch (type) {
        case 0: w[3] &= ~((1u<<23)|(1u<<24)|(1u<<25)); w[3] &= ~(1u<<26); break;
        case 1: w[3] |= (1u<<23)|(1u<<24)|(1u<<25); w[3] &= ~(1u<<26); break;
        case 2: w[3] |= 0x7800000u; break;
        default: w[3] &= ~((1u<<23)|(1u<<24)|(1u<<25)); w[3] |= (1u<<23)|(1u<<24); w[3] &= ~(1u<<26); break;
        }
    }
    ese_bits_set16h_s0_w3((u8 *)w + 6, 0);
    w[2] = 1u | ((mode == 2) ? 4u : 0u) | ((rx_reorder_sw & 1u) << 1);
    ese_bits_set32_s3_w29((u8 *)w + 8, 0);
}
/* 0x802820: таблица переходов switch vendor rx_chain__build_desc_b (0x8e41a8;
 * ldb, цель = 0x8e41ce + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(802820) const u8 rx_chain_build_desc_b_jt[6] = {
    0x05, 0x05, 0x00, 0x07, 0x0b, 0x0b,
};

__attribute__((section(".textlate"))) void rx_chain_build_desc_b(void *desc, u32 mode, u32 value)
{
    u8 *d = (u8 *)desc; u32 sel, i;
    memset0_words(d, 0x30);
    if (mode >= 6u) { fw_sysassert_fatal(0, 0x1018u); sel = 0; }
    else switch (mode) {
        case 0: case 1: sel = 1u; break;
        case 2: sel = (qdesc_cfg_is_override() != 0u) ? 2u : 1u; break;
        case 3: sel = (*(volatile u32 *)0x8002a8u != 0u) ? 4u : 1u; break;
        default: sel = 0; break;
    }
    bits_set32_s0_w4((u32 *)d, sel & 0xfu);
    d[2] = (u8)value;
    for (i = 0; i < 8u; i++) rx_chain_bits_set16h_s0_w12((u16 *)(d + 4u + 2u*i), 0xfffu);
}
__attribute__((section(".textlate"))) u32 qdesc_cfg_is_override(void){ return qdesc_cfg_override; }

__attribute__((section(".textlate"))) void bits_set32_s0_w4(u32 *p, u32 v){ *p = (*p & ~0xFu) | (v & 0xFu); }
__attribute__((section(".textlate"))) void rx_chain_bits_set16h_s0_w12(u16 *p, u32 v){ *p = (u16)((*p & ~0xfffu) | (v & 0xfffu)); }
__attribute__((section(".textlate"))) void ese_bits_set16h_s0_w3(void *p, u32 v){ *(u16*)p = (u16)((*(u16*)p & ~7u) | (v & 7u)); }
__attribute__((section(".textlate"))) void ese_bits_set32_s3_w29(void *p, u32 v){ *(u32*)p = (*(u32*)p & 7u) | ((v << 3) & ~7u); }

/* rx_macq__program_ba_win (0x8e37fc, 102 Б). */
__attribute__((section(".textlate"))) void rx_macq_program_ba_win(u32 cfg, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5)
{
    struct rx_macq_cfg *d = (struct rx_macq_cfg *)cfg;
    struct rx_ba_win_params win;
    u32 g = rx_reorder_sw;
    win.queue = d->queue;
    win.size = (u16)a3;
    win.start = (u16)a2;
    win.param_a = (u16)a4;
    if (g != 0 && (s32)a5 > 0x40) fw_sysassert_fatal(0, 0x1276);
    win.param_b = (u16)a5;
    /* 8e3826 stw_s r13,[r14,2] — 16 бит; прежний порт писал u32 по невыровненному
     * cfg+2 (cfg = 0x843188 + idx*16) и задевал байты +4/+5. */
    d->payload = (u16)a5;
    rx_macq_build_ba_desc(&rx_macq_bufs.ba_win, a1, &win, d->type);
    macq_desc_write(&rx_macq_bufs.ba_win, d->queue, 1, 0, 0, 0, 0, 1);
}

/* rx_macq__program_desc_848018 (0x8df908, 156 Б). */
__attribute__((section(".textlate"))) void rx_macq_program_desc_848018(u32 cfg, u32 a1, u32 a2, u32 a3, u32 a4)
{
    const struct rx_macq_cfg *p = (const struct rx_macq_cfg *)cfg;
    u32 w = p->sniffer;
    rx_macq_pack_desc(rx_macq_bufs.ctl, (u32)p->type, a1, a2, a3, a4, (u32)(w != 0u), (u32)(w == 0u));
    macq_desc_write(rx_macq_bufs.ctl, (u32)p->queue, 1u, 2u, 0u, 0u, 0u, 1u);
}

/* rx_macq__program_offload_desc (0x8df65c, 60 Б). */
__attribute__((section(".textlate"))) void rx_macq_program_offload_desc(void *p)
{
    const struct rx_macq_cfg *c = p;
    void *off = rx_macq_bufs.offload;
    u32 flag = (c->reorder == 1u) ? 1u : 0u;
    u8 b1 = c->type;
    u8 b4 = c->decap;
    ese_set_alloc_type(off, b1, b4, flag);
    macq_desc_write(off, c->queue, 1u, 0u, 0u, 0u, 1u, 1u);
}

/* rx_chain__configure_b (0x8c4508, 56 Б). */
__attribute__((section(".textlate"))) void rx_chain_configure_b(u32 cfg, u32 a1)
{
    const struct rx_macq_cfg *d = (const struct rx_macq_cfg *)cfg;
    rx_chain_build_desc_b(rx_macq_bufs.chain.w, d->type, a1);
    macq_desc_write(rx_macq_bufs.chain.w, d->queue, 1, 3, 0, 0, 0, 3);
}

/* dma_offload__pack_decap_cfg (0x8df530): упаковать флаги декапсуляции
 * в 0x881b88 (биты 0..7): a0 | a1<<2 | a2<<3 | a3<<5 | a4<<6 | a5<<7. */
__attribute__((section(".textlate"))) void dma_offload_pack_decap_cfg(u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5)
{
    u32 v = a0 | (a1 << 2) | (a2 << 3) | (a3 << 5) | (a4 << 6) | (a5 << 7);
    MMIO32(HW_DMA_OFFLOAD_DECAP_CFG) = v;
    arc_sync();
}

/* l2_offload__set_rx_decap_cfg (0x8df5a8): 0x881b30 = vlan_id. */
__attribute__((section(".textlate"))) void l2_offload_set_rx_decap_cfg(u32 cfg)
{
    MMIO32(HW_L2_RX_DECAP_CFG) = cfg;
}

/* dma__set_881b94_bits45 (0x8df560): биты 4,5 регистра 0x881b94
 * (ipv4_checksum_en → бит 4, tcpip_checksum_en → бит 5). */
__attribute__((section(".textlate"))) void dma_set_881b94_bits45(u32 a0, u32 a1)
{
    if (a0 & ~1u) fw_sysassert_fatal(0, 0xac);
    MMIO32(HW_DMA_OFFLOAD_CTL_B94) = (MMIO32(HW_DMA_OFFLOAD_CTL_B94) & ~(1u << 4)) | ((a0 & 1u) << 4);
    if (a1 & ~1u) fw_sysassert_fatal(0, 0xac);
    MMIO32(HW_DMA_OFFLOAD_CTL_B94) = (MMIO32(HW_DMA_OFFLOAD_CTL_B94) & ~(1u << 5)) | ((a1 & 1u) << 5);
}

/* rx_macq__program_offload_desc_with_b4 (0x8e2474): entry[4]=b4 + программирование. */
__attribute__((section(".textlate"))) void rx_macq_program_offload_desc_with_b4(u8 *p, u32 b4)
{
    ((struct rx_macq_cfg *)p)->decap = (u8)b4;
    rx_macq_program_offload_desc((void *)p);
}

/* l2_offload__cfg_rx_decap (0x8c7070): L2/L3 offload + RX-декапсуляция DMA (из
 * wmi_cfg_rx_chain после dma_mgr__configure_ring). Кадр vendor: байты [sp] = p[0x12]
 * (l2_802_3_offload_ctrl), [sp+1] = p[0x13] (l2_nwifi_offload_ctrl), [sp+2] = p[0x16]
 * (l3_l4_ctrl); [sp+3] не пишется (ld/ldh захватывают его старшими битами, но
 * используются только биты 0..1 — на результат не влияет).
 * 802.3 (decap 0): a1 = !snap_keep (bxor r17,r17,0 после журнала SNAP_keep — в 0x881b88
 * бит 2 = «снять SNAP»), a3 = vlan_insertion, при vlan — 0x881b30 = vlan_id; b4 = vlan ? 2 : 1.
 * Прежний порт писал a1 = snap_keep (на стенде 0x881b88 = 0x41 против 0x45 у vendor) и не
 * вёл журнал. */
__attribute__((section(".textlate"))) void l2_offload_cfg_rx_decap(const u8 *p)
{
    u32 l2_8023 = p[0x12];
    u32 l2_nwifi = p[0x13];
    u32 l3l4 = p[0x16];
    u32 a0, a1, a2, a3, a4, a5, b4;

    fw_log_emit1(0x2b, 0x100d6b4, p[0x11]);         /* L2 Offload Rx Decap_trans_type */
    if (p[0x11] == 0) {                             /* WMI_DECAP_TYPE_802_3 */
        u32 snap_keep = (l2_8023 >> 1) & 1u;
        u32 vlan_insert = l2_8023 & 1u;
        fw_log_emit1(0x2b, 0x100d6d8, snap_keep);   /* SNAP_keep */
        fw_log_emit1(0x2b, 0x100d6f4, vlan_insert); /* vlan_insertion */
        a1 = snap_keep ^ 1u;
        if (vlan_insert != 0) {
            l2_offload_set_rx_decap_cfg(p[0x14]);
            b4 = 2;
            a3 = 1;
        } else {
            b4 = 1;
            a3 = 0;
        }
        a0 = 1; a2 = 0; a4 = 1; a5 = 0;
    } else if (p[0x11] == 1) {                      /* WMI_DECAP_TYPE_NATIVE_WIFI */
        a0 = 2; a1 = 0; a2 = p[0x15]; a3 = 0; a4 = l2_nwifi & 1u; a5 = 0;
        b4 = 3;
    } else {                                        /* WMI_DECAP_TYPE_NONE */
        a0 = 0; a1 = 1; a2 = 0; a3 = 0; a4 = 1; a5 = 1;
        b4 = 0;
    }

    dma_offload_pack_decap_cfg(a0, a1, a2, a3, a4, a5);
    rx_macq_program_offload_desc_with_b4((u8 *)rx_macq_entry_addr(2), b4);
    fw_log_emit2(0x2b, 0x100d714, l3l4 & 1u, (l3l4 >> 1) & 1u);  /* L3 Offloads */
    dma_set_881b94_bits45(l3l4 & 1u, (l3l4 >> 1) & 1u);
}

/* 0x802818: таблица переходов switch vendor rx_chain__build_desc (0x8e40d4;
 * ldb, цель = 0x8e40fe + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(802818) const u8 rx_chain_build_desc_jt[6] = {
    0x04, 0x04, 0x00, 0x06, 0x0a, 0x0a,
};

/* rx_chain__build_desc (0x8e40d4, 212 Б). */
__attribute__((section(".textlate"))) void rx_chain_build_desc(u32 *desc, u8 mode, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6)
{
    u8 *d = (u8 *)desc;
    u32 sel;
    if (a6 != 0) sel = 0;
    else if (mode >= 6) { fw_sysassert_fatal(0, 0x1018); sel = 0; }
    else switch (mode) {
        case 0: case 1: sel = 1; break;
        case 2: sel = (qdesc_cfg_is_override() != 0) ? 2 : 1; break;
        case 3: sel = (rx_reorder_sw != 0) ? 4 : 1; break;
        default: sel = 0; break;
    }
    u32 *dw = desc;
    memset0_words(d, 0x30);
    /* поля a3 и a4 + a3 - 1 — 12 бит: vendor bmsk …,0xb и bits__set32_s{0,8,16}_w12
     * (0x8ed340/0x8ed568/0x8ed3e8); было 0x7FF (11 бит). */
    dw[0] = (sel & 0xF) | ((a2 & 0xF) << 4) | ((a3 & 0xFFF) << 8);
    d[3] = 0;
    dw[1] = (((a4 + a3 - 1) & 0xFFF) << 0) | ((a3 & 0xFFF) << 16);
    dw[2] = (((a4 + a3 - 1) & 0xFFF) << 0) | ((a4 & 0x7F) << 16);
    d[0xb] = 0; d[0xc] = 0; d[0xd] = 0; d[0xe] = 0;
    if (sel == 4) { if ((s32)a5 < (s32)(a4 + 2)) fw_sysassert_fatal(0, 0x1019); }
    else { if ((s32)a5 < (s32)(a4 * 2)) fw_sysassert_fatal(0, 0x101a); }
    d[0xf] = (u8)a5;
}


/* rx_buf__alloc (0x8c3394, 60 Б): выделить RX-буфер из пула rx_ring.pool (0x806000). */
__attribute__((section(".textlate"))) void *rx_buf_alloc(void)
{
    void *b = mem_pool_allocate(&rx_ring.pool);
    if (b == 0) fw_sysassert_fatal(0, 0x1001);
    return ((struct rx_pkt *)b)->frame;
}

/* rx_pool__set_fields (0x8d9394, 12 Б). */
__attribute__((section(".textlate"))) void rx_pool_set_fields(struct ring_idx *p, u32 base, u32 size)
{
    p->base = base; p->size = size; p->tail = 0; p->head = 0;
}

/* rx_api__drain_all_lists (0x8e6c60, 140 Б). */
__attribute__((section(".textlate"))) u32 rx_api_drain_all_lists(struct ring_idx *ctx)
{
    struct rx_desc *list = (struct rx_desc *)ctx->base;
    u32 count = ctx->size;
    u32 i;
    for (i = 0; i < count; i++) {
        u32 mask = (u32)rx_buf_alloc() & 0x3ffffu;
        u32 param = *(volatile u32 *)&rx_ring.pool.elem_size - __builtin_offsetof(struct rx_pkt, frame);   /* 0x806008 */
        rx_api_drain_list_init(list, mask, 0, param);
        list++;
    }
    ctx->head = count - 1;
    return count - 1;
}

/* rx_pool__configure_step (0x8e60d0, 56 Б). */
__attribute__((section(".textlate"))) u32 rx_pool_configure_step(struct rx_dma_ring *p, u32 list, u32 count, u32 dma_ring)
{
    rx_pool_set_fields(&p->r, list, count);
    rx_api_drain_all_lists(&p->r);
    p->dma_ring = dma_ring;
    p->pended = 0;
    return 0;
}
