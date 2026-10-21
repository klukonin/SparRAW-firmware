// SPDX-License-Identifier: AGPL-3.0-or-later
/* DMA-кольцо: dma_mgr__configure_ring (0x8c6e90) + helper'ы. .textlate. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/macq_desc.h"
#include "../include/fwdata.h"

/* dpal__cpl_timeout_evt (0x8c9680): таймаут завершения — первое событие записывается,
 * повторное с другим значением → assert. */
__attribute__((section(".textlate"))) void dpal_cpl_timeout_evt(u32 v)
{
    if (dpal_cpl_timeout_seen != 1) {
        MMIO32(HW_DMA_RING_SELECT) = v;
        dma_cpl_timeout_val = v;
        dpal_cpl_timeout_seen = 1;
        return;
    }
    if (v == dma_cpl_timeout_val)
        return;
    fw_sysassert_fatal((void *)0, 0x1006);
}

/* vring__reg_write_locked_20 (0x8d0508, 48 Б). */
__attribute__((section(".textlate"))) void vring_reg_write_locked_20(u32 val, u32 do_sync)
{
    u32 s = arc_irq_disable();
    MMIO32(HW_DMA_FW_ICR_C08_IMC) = val;
    if (do_sync) arc_sync();
    arc_irq_restore(s);
}

/* hwd_dma__set_ring_base (0x8d0468, 80 Б). */
__attribute__((section(".textlate"))) void hwd_dma_set_ring_base(u32 idx, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5)
{
    u32 off = idx * 896u;
    MMIO32(((off + 0x4409940u) >> 3) & ~3u) = a1;
    if (a5 != 0) dpal_cpl_timeout_evt(a2);
    MMIO32(((off + 0x4409720u) >> 3) & ~3u) = a3;
    MMIO32(((off + 0x4409740u) >> 3) & ~3u) = a4;
}

/* hwd_dma__set_ring_field_99e0 (0x8d0a80, 88 Б): 16-бит поле. */
__attribute__((section(".textlate"))) void hwd_dma_set_ring_field_99e0(u32 idx, u32 value)
{
    u32 bit, word_addr, word, mask;
    if (value & 0xffff0000u) fw_sysassert_fatal(0, 0xac);
    bit = (idx * 896u + 0x44099e0u) & 0x1fu;
    word_addr = ((idx * 896u + 0x44099e0u) >> 3) & ~3u;
    word = MMIO32(word_addr);
    mask = (1u << (bit + 15)) | ((1u << (bit + 15)) - (1u << bit));
    MMIO32(word_addr) = (word & ~mask) | (value << bit);
}

/* hwd_dma__set_ring_field_9a10 (0x8d0c48, 84 Б): 4-бит поле. */
__attribute__((section(".textlate"))) void hwd_dma_set_ring_field_9a10(u32 idx, u32 value)
{
    u32 raw, bit, word;
    if (value & ~0xFu) fw_sysassert_fatal(0, 0xac);
    raw = idx * 0x380u + 0x4409a10u;
    bit = raw & 0x1fu;
    word = MMIO32((raw >> 3) & ~3u);
    MMIO32((raw >> 3) & ~3u) = (value << bit) | (word & ~(0xFu << bit));
}

/* hwd_dma__uses_rgf_881000 (0x8d0ba4, 92 Б). */
__attribute__((section(".textlate"))) void hwd_dma_uses_rgf_881000(u32 a0, u32 a1, u32 a2)
{
    u32 bitoff, p, addr, mask, word;
    MMIO32(HW_DMA_RING_SEL_102C) = a1;
    arc_sync();
    if (a1 != 0 && a2 != 0) {
        bitoff = a0 * 896u + 0x4409a20u;
        p = bitoff & 0x1fu;
        addr = (bitoff >> 3) & ~3u;
        mask = (1u << ((p + 31u) & 31u)) | ((1u << ((p + 31u) & 31u)) - (1u << p));
        word = MMIO32(addr);
        MMIO32(addr) = (a2 << p) | (word & ~mask);
    }
}

/* field_set_0x00__8d0a44 (0x8d0a44, 60 Б). */
__attribute__((section(".textlate"))) void field_set_0x00_8d0a44(u32 a0, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6)
{
    u32 value = (a1 << 1) | (a2 << 2) | (a3 << 3) | (a6 << 4) | (a4 << 5) | (a5 << 6);
    MMIO32((a0 * 896u + 0x44096e0u) >> 3) = value;
    arc_sync();
}

/* macq_hw__set_low_nibble (0x8d0708, 36 Б): включить кольцо (low nibble = 0xf). */
__attribute__((section(".textlate"))) void macq_hw_set_low_nibble(u32 idx)
{
    u32 addr = (idx * 896u + 0x44096c0u) >> 3;
    MMIO32(addr) = MMIO32(addr & ~3u) | 0xFu;
    arc_sync();
}

/* hwd_dma__reset_ring (0x8d0700, 28 Б). */
__attribute__((section(".textlate"))) void hwd_dma_reset_ring(u32 idx)
{
    MMIO32((idx * 896u + 0x44096c0u) >> 3) = 0;
    arc_sync();
}

/* 0x802c34: конфигурация DMA-колец по номеру кольца (9 × 4 Б): [0] — параметр hwd_dma_set_ring_base,
 * [1] и [3] — параметры field_set_0x00_8d0a44, [2] — режим (0 — с базой; 1 — без: ассерт 0x120b
 * при [3] == 0 и 0x120c для кольца 3). */
FWDATA(802c34) const u8 dma_ring_cfg[9][4] = {
    { 0x01, 0x00, 0x01, 0x01 },   /* кольцо 0 */
    { 0x01, 0x00, 0x01, 0x01 },   /* кольцо 1 */
    { 0x01, 0x01, 0x00, 0x00 },   /* кольцо 2 */
    { 0x00, 0x00, 0x00, 0x00 },   /* кольцо 3 */
    { 0x00, 0x01, 0x00, 0x00 },   /* кольцо 4 */
    { 0x00, 0x00, 0x00, 0x01 },   /* кольцо 5 */
    { 0x00, 0x00, 0x00, 0x01 },   /* кольцо 6 */
    { 0x03, 0x01, 0x00, 0x00 },   /* кольцо 7 */
    { 0x02, 0x00, 0x00, 0x00 },   /* кольцо 8 */
};

/* dma_mgr__configure_ring (0x8c6e90, 300 Б): конфигурация DMA-кольца + enable. */
__attribute__((section(".textlate"))) void dma_mgr_configure_ring(u32 a, u32 b, u32 c, u32 d, u32 e, u32 f, u32 g, u32 h)
{
    const volatile u8 *cfg = dma_ring_cfg[a];
    u8 b0 = cfg[0], b1 = cfg[1], b2 = cfg[2], b3 = cfg[3];
    u32 is7 = (a == 7u), is8 = (a == 8u);
    (void)f; (void)g;
    if (b2 == 1u && b3 == 0u) fw_sysassert_fatal(0, 0x120b);
    if (b2 == 1u && a == 3u)  fw_sysassert_fatal(0, 0x120c);

    field_set_0x00_8d0a44(a, b0, b1, b2, b3, is7, is8);

    if (is7) {
        if (a & 0xfffffff0u) fw_sysassert_fatal(0, 0xac);
        MMIO32(HW_PRP_CTRL) = (MMIO32(HW_PRP_CTRL) & 0xfffff0ffu) | (a << 8);
    }

    if (b2 == 0u) {
        /* vendor (8c6f30): последний индекс d-1 только для кольца 4 и 7, иначе 0. */
        u32 last = ((a == 4u) || is7) ? (d - 1u) : 0u;
        hwd_dma_set_ring_base(a, b, c, d, last, b0);
        if (!is7) {
            hwd_dma_set_ring_field_99e0(a, 1u);
            hwd_dma_set_ring_field_9a10(a, 1u);
        } else if (e != 0u) {
            hwd_dma_set_ring_field_99e0(a, e);
        }
        if (h >= 3u && h < 0x1f28u)
            hwd_dma_uses_rgf_881000(a, 1u, h);
        macq_hw_set_low_nibble(a);
    }

    if ((u32)(a - 3u) <= 3u)
        vring_reg_write_locked_20(1u << a, 0u);
}

/* rx_macq__bind_queue (0x8e42b8, 136 Б): привязать MACQ-очередь к кольцу + enable. */
__attribute__((section(".textlate"))) void rx_macq_bind_queue(u32 macq_idx, u32 qtype, u32 ring_idx, u32 enable)
{
    u32 r1, addr, bit, mask, v, b, qaddr;
    if (ring_idx >= 0xc || macq_idx >= 0x20)
        fw_sysassert_fatal(0, 0x101d);
    r1 = macq_idx >> 3;
    addr = HW_PRP_QID_RING_MAP + r1 * 4;
    bit = (macq_idx & 7u) * 4;
    mask = 0xfu << bit;
    /* vendor: при enable!=0 в поле ring-select пишется 0 (не ring_idx) */
    u32 rsel = (enable != 0u) ? 0u : ring_idx;
    MMIO32(addr) = (MMIO32(addr) & ~mask) | (rsel << bit);
    /* vendor (8e42fa): иной qtype — регистр выбора кольца, адрес которого уже в r2 */
    qaddr = (qtype == 0) ? HW_PRP_QID_MAP_SEL0 : (qtype == 1) ? HW_PRP_QID_MAP_SEL1 : (qtype == 2) ? HW_PRP_QID_MAP_SEL2 : addr;
    v = MMIO32(qaddr);
    b = 1u << macq_idx;
    MMIO32(qaddr) = (enable != 0) ? (v & ~b) : (v | b);
}

/* 0x803208: таблица переходов vendor rx_macq__bind_all_queues (0x8e1298): ldb.x, 6 записей, цель = 0x8e12bc + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803208) __attribute__((aligned(1))) const u8 rx_macq_bind_all_queues_jt[6] = {
    0x00, 0x00, 0x02, 0x04, 0x00, 0x00,
};

/* rx_macq__bind_all_queues (0x8e1298, 76 Б): привязать все очереди MACQ-объекта. */
__attribute__((section(".textlate"))) void rx_macq_bind_all_queues(u32 macq, u32 ring, u32 enable)
{
    u8 type = ((const struct rx_macq_cfg *)macq)->type;
    u8 idx  = ((const struct rx_macq_cfg *)macq)->queue;
    u32 q;
    if (type >= 6) fw_sysassert_fatal(0, 0x1275);
    /* vendor jump-table @0x803208 = {0,0,2,1,0,0}: type0..5 → qtype */
    q = (type == 2) ? 2 : (type == 3) ? 1 : 0;
    rx_macq_bind_queue(idx, q, ring, enable);
}

/* rx_chain__set_payload_size (0x8e7138, 8 Б): [0x80020c] = payload size.
 * vendor: stw.as r0,[gp,0x44] — stw=16-бит, .as масштабирует 0x44<<1=0x88,
 * gp(0x800184)+0x88 = 0x80020c (тот же глобал, что читает rx_chain__get_cfg_word). */
__attribute__((section(".textlate"))) void rx_chain_set_payload_size(u32 v)
{
    rx_chain_payload_size = (u16)v;
}
