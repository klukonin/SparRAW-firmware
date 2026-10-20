// SPDX-License-Identifier: AGPL-3.0-or-later
/* ucode_cmd_0x33_handler — LMAC 0x33 UPM_CFG: PS без графика на станции
 * (ucode 6.2: 0x93d2a8, 116 байт).  Прошивка шлёт по WMI_UPM_CFG (0x960) и,
 * в 6.4, по профилю PS хоста (iw set power_save).
 *
 * Тело {u32 enable (0/1), u32 timeout_us}; тайм-аут простоя принимается в
 * [5000, 80000] мкс, иначе состояние не меняется.  Выключение будит станцию.
 *
 * 6.4 apsta: при включении взводится таймер простоя GP8 — в 6.2 его взводил
 * только выход из doze, и первый вход не наступал никогда.  Значение пишется
 * и в копию на время скана: после скана ucode возвращает включение из неё,
 * и в 6.2 выключение хостом отменялось первым же сканом.
 */
#include "uc_ps.h"

struct lmac_upm_cfg {
	u32 enable;
	u32 timeout_us;
};

enum {
	UPM_TIMEOUT_MIN_US = 5000,
	UPM_TIMEOUT_MAX_US = 80000,
};

extern "C" void ucode_cmd_0x33_handler(volatile struct pm_ctx *ctx, const struct lmac_upm_cfg *cmd)
{
	u32 enable = cmd->enable;
	if (enable > 1)
		return;

	u32 t = cmd->timeout_us;
	if (t < UPM_TIMEOUT_MIN_US || t > UPM_TIMEOUT_MAX_US) {
		enable = g_pm_ctx.upm_enable;
	} else {
		g_pm_ctx.upm_enable = enable;
		g_pm_ctx.upm_enable_saved = enable;
		g_pm_ctx.upm_timeout_ticks = t * MAC_TICKS_PER_US;
	}

	if (enable) {
		if (!ctx->in_doze)
			gp_timer__set_value(ctx, GP_TIMER_UPM_IDLE, g_pm_ctx.upm_timeout_ticks);
		return;
	}
	g_pm_ctx.upm_state_16d = 0;
	g_pm_ctx.upm_state_16c = 0;
	if (ctx->in_doze == 1)
		ps__hold_awake_for_sta(ctx, 0);
}
