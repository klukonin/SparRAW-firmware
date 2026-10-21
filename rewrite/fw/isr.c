// SPDX-License-Identifier: AGPL-3.0-or-later
/* Диспетчер прерываний — isr_880b50__dispatch_causes (0x8c161c).
 * Читает регистр причин 0x880b54, сбрасывает его и разводит по обработчикам.
 * Бит 0x1b — команда от хоста (WMI), бит 0x9 — событие ucode.
 * Это тело вектора 4; тела остальных векторов — fw/vectors.c. */
#include "../include/types.h"
#include "../include/rf_kill.h"
#include "../include/hw.h"
#include "../include/arc.h"


/* Шаг обработки host-команды (0x8cdbb4). */
void isr_step_22f70_80044c(void)
{
    rf_kill_mask_irq();
    u_schd_schedule(rf_kill_irq_task,
                    0, 0, 0, rf_kill_debounce_delay, 0, 0);
}

/* Замаскировать awake-TSF (0x880b60). */
void host_irq_mask_awake_tsf(void)
{
    MMIO32(HW_RGF_USER_USER_ICR_IMS) = 0x10;
}

void isr_880b50_dispatch_causes(void)
{

    u32 cause = MMIO32(HW_RGF_USER_USER_ICR_ICM); /* ДИАГНОСТИКА: причина (биты) — видно в mbox rx[0].addr */
    MMIO32(HW_RGF_USER_USER_ICR_ICR) = cause; /* сбросить причину */

    if (u_schd_timer_irq_pending(cause) != 0)
        u_schd_expire_timers_thunk();

    if (cause & (1u << 0x12)) {
        gpio_pulse_880b60_18();
        MMIO32(HW_RX_MBOX_INT_COUNT) += 1;    /* [0x880a3c+0x14] счётчик */
    }
    if (cause & (1u << 0x13))
        gpio_pulse_880b60_19();
    if (cause & (1u << 0x9))
        uc_evt_mask_irq_and_defer_drain();
    if (cause & (1u << 0x1b))
        isr_step_22f70_80044c();
    if (cause & (1u << 0x4)) {                  /* Awake TSF: взводил только deep sleep (вырезан) — защитно */
        host_irq_mask_awake_tsf();
        u32 buf[2];
        mac_read_tsf64(0, buf, 0);
        fw_log_emit2(0x20, 0x10001ac, buf[1], buf[0]);
    }   /* ДИАГНОСТИКА: конец dispatch_causes */
}

/* Маскировать IRQ rf-kill (0x8c14bc). */
void rf_kill_mask_irq(void)
{
    MMIO32(HW_RGF_USER_USER_ICR_IMS) = 0x8000000;
    arc_sync();
}

/* Задача обработки rf-kill IRQ (0x8e2f70). */

void rf_kill_irq_task(u32 a0, u32 a1)
{
    (void)a0;
    (void)a1;
    u32 v = MMIO32(HW_RF_KILL_PIN);
    basic_sm_handle_event(&rf_mgmt_sm, (v & 1) ? 0 : 1, 0, 0, 0);
    mac_toggle_880288_b1();
    rf_kill_ack_irq();
    rf_kill_unmask_irq();
}

/* Подтверждение/размаскировка rf-kill IRQ. */
void rf_kill_ack_irq(void)
{
    MMIO32(HW_RGF_USER_USER_ICR_ICR) = 0x8000000;
    arc_sync();
}

void rf_kill_unmask_irq(void)
{
    MMIO32(HW_RGF_USER_USER_ICR_IMC) = 0x8000000;
    arc_sync();
}

/* Маскировать IRQ ucode и отложить drain (0x8ca20c). vendor 0x8cd864: mask 0x880b60,
 * затем u_schd_add(lmac_mbox__drain_task, 0, 0, 1) — НЕ wmi_host_poll. */

void uc_evt_mask_irq_and_defer_drain(void)
{
    MMIO32(HW_RGF_USER_USER_ICR_IMS) = 0x200; /* маска IRQ ucode (vendor 0x8cd864) */
    u_schd_add(lmac_mbox_drain_task, 0, 0, 1);   /* vendor: drain LMAC mbox */
}

/* lmac_mbox__drain_task — в lmac.c (разбор событий ucode). */
/* Прежний скелет isr_mac_886028_fw (смесь векторов 12 и 13) заменён isr_mac_886028 и
 * isr_caf_icr_889470 (fw/vectors.c). */
