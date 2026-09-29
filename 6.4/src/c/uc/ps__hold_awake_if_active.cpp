// SPDX-License-Identifier: AGPL-3.0-or-later
/* ps__hold_awake_if_active — таймер простоя GP8 истёк: войти в doze по UPM
 * (ucode 6.2: 0x93da98, 40 байт).  Зовёт l1__on_event4.
 *
 * 6.4 apsta (11.2.7.2.2): в 6.2 вход разрешён только при договоре PSC
 * (psc_state == 1), хотя PS без графика от PSC не зависит.  Теперь вход
 * запрещён лишь в BI сна по графику — там станция и так спит.
 */
#include "uc_ps.h"

extern "C" void ps__hold_awake_if_active(volatile struct pm_ctx *ctx)
{
	if (g_pm_ctx.upm_enable == 1 && ctx->psc_state != PSC_STATE_DOZE_BI)
		ps__hold_awake_for_sta(ctx, 1);
}
