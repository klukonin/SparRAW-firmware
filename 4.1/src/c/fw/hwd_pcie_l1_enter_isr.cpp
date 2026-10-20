// SPDX-License-Identifier: AGPL-3.0-or-later
/* hwd_pcie_l1_enter_isr (0x8ce8d8, 32 байта).
 *
 * Обработчик прерывания «PCIe вошёл в L1». Зовут из общего обработчика
 * прерываний (0x8c0eee). Если LTSSM при этом не в L1_IDLE — это ошибка, и
 * она пишется в журнал; сама работа по входу в L1 делается в любом случае.
 */
#include "fw.h"

extern "C" {
int hwd_pcie_ltssm_is_l1_idle(void);
/* Пишет константу 0x4000 в регистр PCIe 0x882fe0 — это и есть
 * собственно вход в L1. Аргументов не берёт. */
void set_reg_882fe0(void);
}

/* "hwd_pcie_l1_enter_isr: PCIE LTSSM State != LTSSM_S_L1_IDLE", 0x18b24 */
enum { MSG_LTSSM_NOT_IDLE = 0x01018b24 };

enum { FWLOG_MOD_DRIVERS = 1 };

extern "C" void hwd_pcie_l1_enter_isr(void)
{
	if (!hwd_pcie_ltssm_is_l1_idle())
		fw_log__emit0(FWLOG_MOD_DRIVERS, FWLOG_LVL_ERR, MSG_LTSSM_NOT_IDLE);
	set_reg_882fe0();
}
