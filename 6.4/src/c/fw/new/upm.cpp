// SPDX-License-Identifier: AGPL-3.0-or-later
/* PS без графика на станции по профилю хоста (6.4, прошивка apsta;
 * 802.11-2020 11.2.7.2.1–11.2.7.2.2).
 *
 * MLME-POWERMGT.request — это `iw set power_save`: драйвер шлёт профиль
 * WMI 0x91C.  В 6.2 профиль на станции ничего не включал, а механизм UPM
 * (LMAC 0x33) хост не трогал вовсе.  Теперь UPM включён, пока профиль
 * DEFAULT и порт данных к точке открыт (после (ре)ассоциации станция
 * начинает в active mode, 11.2.7.1); на AP и PCP — всегда выключен.
 * Зовут: подключение, отключение, смена профиля.
 */
#include "ps.h"

enum { BSS_MODE_STA = 1 };

extern "C" {
void *mid_list__by_mid_fw(u32 idx);
void  lmac_if_upm_cfg_handler(const u32 *cfg);
}

extern "C" void upm__sync(void)
{
	if (g_lmac_ready != 1)
		return;
	u8 *mid = (u8 *)mid_list__by_mid_fw(0);
	bool sta = mid && ((struct bss *)(mid + 0x48))->mode == BSS_MODE_STA;
	u32 cfg[2] = {
		sta && g_ps_conn_mask && g_ps_active_profile == PS_PROFILE_DEFAULT,
		UPM_IDLE_TIMEOUT_US,
	};
	lmac_if_upm_cfg_handler(cfg);
}
