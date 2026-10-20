// SPDX-License-Identifier: AGPL-3.0-or-later
/* hwd_pcie_l1_enter_isr — обработчик входа PCIe в L1 (6.2: вектор 18).
 *
 * Если LTSSM не в состоянии L1 idle — записать ошибку в журнал; в любом
 * случае замаскировать прерывание входа в L1.  Тот же код, что в 4.1.
 */
#include "fw.h"

/* "hwd_pcie_l1_enter_isr: PCIE LTSSM State != LTSSM_S_L1_IDLE" */
enum { MSG_LTSSM_NOT_IDLE = 0x0101dcd4 };

extern "C" void hwd_pcie_l1_enter_isr(void)
{
	if (!hwd_pcie_ltssm_is_l1_idle())
		fw_log_emit0(FWLOG_HDR(FWLOG_MOD_DRIVERS, FWLOG_LVL_ERR), MSG_LTSSM_NOT_IDLE);
	pcie__mask_l1_enter_irq();
}
