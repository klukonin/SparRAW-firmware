// SPDX-License-Identifier: AGPL-3.0-or-later
/* Сигнализация хосту (FW→host прерывания, «дверной звонок»).
 * Драйвер ждёт IRQ FW_READY — это запись 1<<0x1c в 0x881bf8 и 0x881d24. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"


/* hwd_pcie_exit_l1 (0x8d12ac): бит «держать PCIe вне L1» = on (1 — перед дверным звонком,
 * 0 — после). on=0 сначала ждёт: пустая задержка 0x50×2 nop, затем до 0x1e8480 опросов, пока link
 * не в L1 (0x8d1054 = 0) и [0x882b88] бит 0 = 1. Затем бит on:
 *   EP под SerDes:   [0x882554] бит 3;
 *   иначе, on != 0:  [0x882028] бит 19, затем [0x882024] бит 24;
 *   иначе, on == 0:  [0x882024] бит 24, затем [0x882028] бит 19.
 * Перед каждой записью vendor проверяет on & ~1 (сисассерт 0xac). */
void hwd_pcie_exit_l1(u32 on)
{
    u32 serdes = hwd_pcie_is_ep_under_serdes();     /* r15 */

    if (on == 0) {
        /* Пустая задержка vendor: lp_count = 0x50; nop_s; lp, тело — 2 nop_s (0x8d12be..0x8d12cc). */
        arc_zol_nops2_mb(0x50);

        u32 cnt = 0x1e8480, l1, b;
        do {
            l1 = hwd_pcie_is_l1_state();
            cnt--;                                    /* delay-слот bl.d 0x8d1054 */
            b = hwd_pcie_get_882b80();
        } while (l1 == 0 && b == 1 && cnt != 0);
        if (l1 == 0 && b == 1) {
            /* vendor логирует blink — адрес возврата последнего вызова (0x8d1428), т.е.
             * точку внутри этой функции; у нас — то же самое: blink после нашего вызова. */
            u32 bl;
            __asm__ volatile("mov %0, blink" : "=r"(bl));
            fw_log_emit1(0, 0x101dbf4, bl);
        }
        if (b == 0)
            fw_log_emit0(0x11, 0x101dc24);
    }

    u32 hi = on & ~1u;                              /* r14 */
    if (serdes != 0) {
        if (hi != 0) fw_sysassert_fatal(__builtin_return_address(0), 0xac);
        MMIO32(HW_PCIE_SERDES_L1_HOLD) = (on << 3) | (MMIO32(HW_PCIE_SERDES_L1_HOLD) & ~(1u << 3));
    } else if (on != 0) {
        if (hi != 0) fw_sysassert_fatal(__builtin_return_address(0), 0xac);
        MMIO32(HW_PCIE_SW_CTL_28) = (on << 19) | (MMIO32(HW_PCIE_SW_CTL_28) & ~(1u << 19));
        if (hi != 0) fw_sysassert_fatal(__builtin_return_address(0), 0xac);
        MMIO32(HW_PCIE_SW_CTL_24) = (on << 24) | (MMIO32(HW_PCIE_SW_CTL_24) & ~(1u << 24));
    } else {
        if (hi != 0) fw_sysassert_fatal(__builtin_return_address(0), 0xac);
        MMIO32(HW_PCIE_SW_CTL_24) = (on << 24) | (MMIO32(HW_PCIE_SW_CTL_24) & ~(1u << 24));
        if (hi != 0) fw_sysassert_fatal(__builtin_return_address(0), 0xac);
        MMIO32(HW_PCIE_SW_CTL_28) = (on << 19) | (MMIO32(HW_PCIE_SW_CTL_28) & ~(1u << 19));
    }
}

/* hwd_dma__raise_host_fw_int (0x8d0ad8): exit_l1(1), [0x881bf8] = 1<<a, sync,
 * [0x881d24] = 1<<a, sync, exit_l1(0). */
void hwd_dma_raise_host_fw_int(u32 a)
{
    hwd_pcie_exit_l1(1);
    MMIO32(HW_RGF_DMA_EP_MISC_ICR_ICS) = 1u << a;
    arc_sync();
    MMIO32(HW_DMA_FW_INT_D24) = 1u << a;
    arc_sync();
    hwd_pcie_exit_l1(0);
}

/* host_irq__raise_fw_error (0x8d0cfc): хвостовой вызов 0x8d0ad8(0x1f) — бит 31,
 * в драйвере wil6210 ISR_MISC_FW_ERROR = BIT_DMA_EP_MISC_ICR_FW_INT(3) («FW error detected»). */
void host_irq_raise_fw_error(void)
{
    hwd_dma_raise_host_fw_int(0x1f);
}

/* FW_READY: бит 0x1c. */
void host_irq_raise_fw_ready(void)
{
    hwd_dma_raise_host_fw_int(0x1c);
}

/* pcie__set_event_bit (0x8d1a98): exit_l1(1), [0x8826b0] = 1<<bit, sync, exit_l1(0). */
void pcie_set_event_bit(u32 bit)
{
    hwd_pcie_exit_l1(1);
    MMIO32(HW_PCIE_HOST_EVENT_SET) = 1u << bit;
    arc_sync();
    hwd_pcie_exit_l1(0);
}

/* pcie__set_event_bit_19 (0x8d1b00): хвостовой вызов 0x8d1a98(0x19). */
void pcie_set_event_bit_19(void)
{
    pcie_set_event_bit(0x19);
}
