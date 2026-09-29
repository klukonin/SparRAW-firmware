// SPDX-License-Identifier: AGPL-3.0-or-later
/* bi__dti_step — начало DTI (ucode 6.2: 0x935d5c, 52 байта).  Зовёт
 * bi__after_enter_dti (переходы автомата BI BHI_TO_DTI и AW_TO_DTI).
 *
 * Будит РЧ после окон BHI/AW и открывает передачу: MAC 0x5a либо, при
 * [gp-0x34] ≠ 0, запись поля qset (0, 0).
 * 6.4 apsta: затем станция в UPM-doze выходит из него, если в AW пришёл ATIM
 * или есть свои данные (new/upm_wake.cpp).
 * 6.4 apsta: при расписании ESE точки (CBAP Only = 0) передача закрывается
 * до разрешённого окна (new/ese_dti.cpp).
 */
#include "uc.h"

#define g_dti_qset_mode UC_GLOBAL(u32, 0x008004f4)
enum { MAC_CMD_DTI_OPEN = 0x5a000000 };

extern "C" {
void pm__wake_sequence(void);
void sxd_hal__write_qset_field(u32 a0, u32 a1);
void upm__dti_start(void);
void ese_dti__dti_start(void);
}

extern "C" void bi__dti_step(void)
{
	pm__wake_sequence();
	if (!g_dti_qset_mode)
		mac_cmd(MAC_CMD_DTI_OPEN);
	else
		sxd_hal__write_qset_field(0, 0);
	upm__dti_start();
	ese_dti__dti_start();
}
