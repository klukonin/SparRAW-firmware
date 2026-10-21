// SPDX-License-Identifier: AGPL-3.0-or-later
/* Регистры DMA vring/колец хоста (блок 0x881c00): чтение статуса, маскирование,
 * квитирование — все записи под снятым E1, как vendor (lr status32; flag; st; flag). */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/rx_ring.h"


/* hwd_dma__set_881c00 (0x8d0778, 18 Б): бит a в 0x881c44 и 0x881c58. */
void hwd_dma_set_881c00(u32 a)
{
    MMIO32(HW_DMA_FW_ICR_C40_ICR) = (1u << a);
    MMIO32(HW_DMA_FW_ICR_C40_IMC) = (1u << a);
}

/* hwd_dma__init (0x8d0760, 24 Б): биты 0x1f/0x1c/0x1b. */
void hwd_dma_init(void)
{
    hwd_dma_set_881c00(0x1f);
    hwd_dma_set_881c00(0x1c);
    hwd_dma_set_881c00(0x1b);
}

/* hwd_dma__read_status (0x8d0870, 36 Б): статус DMA vring [0x881c48]. */
u32 hwd_dma_read_status(void)
{
    u32 saved = arc_irq_disable();
    u32 r = MMIO32(HW_DMA_FW_ICR_C40_ICM);
    arc_irq_restore(saved);
    return r;
}

/* hwd_dma__get_881c80 (0x8d0894, 16 Б): есть ли данные в кольце хоста idx. */
u32 hwd_dma_get_881c80(u32 idx)
{
    return (MMIO32(HW_DMA_RINGS_WITH_DATA) >> idx) & 1;
}

/* Запись регистра блока 0x881c00 под снятым E1 (общее тело 0x8d0b14/0x8d0b74/0x8d0c18/
 * 0x8d05c0/…). */
static void hwd_dma_write_locked(u32 reg, u32 v, u32 flag)
{
    u32 saved = arc_irq_disable();
    MMIO32(reg) = v;
    if (flag != 0)
        arc_sync();
    arc_irq_restore(saved);
}

/* hwd_dma__uses_rgf_881c00_8d0c18 (0x8d0c18, 48 Б): [0x881c54] — маска прерываний vring. */
void hwd_dma_op(u32 a, u32 b)
{
    hwd_dma_write_locked(HW_DMA_FW_ICR_C40_IMS, a, b);
}

/* hwd_dma__ack_881c44 (0x8d05c0, 48 Б): квитирование [0x881c44]. */
void hwd_dma_ack_881c44(u32 a, u32 b)
{
    hwd_dma_write_locked(HW_DMA_FW_ICR_C40_ICR, a, b);
}

/* hwd_dma__uses_rgf_881c00_8d0b74 (0x8d0b74, 48 Б): [0x881c38]. */
void hwd_dma_write_881c38(u32 v, u32 flag)
{
    hwd_dma_write_locked(HW_DMA_FW_ICR_C24_IMS, v, flag);
}

/* hwd_dma__bad_cause (0x8d072c, 50 Б): биты 31/28/27 статуса → ассерт 0xbad1. */
void hwd_dma_bad_cause(void)
{
    u32 r2 = MMIO32(HW_DMA_FW_ICR_C40_ICM);
    if ((r2 & (1u << 31)) || (r2 & (1u << 28)) || (r2 & (1u << 27))) {
        fw_log_emit1(0, 0x101d4b0, r2);
        fw_sysassert_fatal((void *)0, 0xbad1);
    }
}

/* hwd_dma__uses_rgf_881c00_8d0b14 (0x8d0b14, 48 Б): [0x881c14]. */
void hwd_dma_uses_rgf_881c00_8d0b14(u32 v, u32 flag)
{
    hwd_dma_write_locked(HW_DMA_FW_ICR_C08_ICS, v, flag);
}

/* tx_api__mask_from_queue (0x8e97e8, 14 Б): маска DMA-кольца r->dma_ring в 0x881c14. */
void tx_api_mask_from_queue(const struct rx_dma_ring *r)
{
    hwd_dma_uses_rgf_881c00_8d0b14(1u << r->dma_ring, 0);
}
