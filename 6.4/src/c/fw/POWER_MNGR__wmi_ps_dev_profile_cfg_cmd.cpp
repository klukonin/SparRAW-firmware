// SPDX-License-Identifier: AGPL-3.0-or-later
/* POWER_MNGR__wmi_ps_dev_profile_cfg_cmd — WMI 0x91C PS_DEV_PROFILE_CFG
 * (6.2: 0x8ec970, 96 байт).  Это MLME-POWERMGT.request хоста (`iw set
 * power_save`): профиль 0 DEFAULT (PS разрешён), 1 PS_DISABLED; ответ —
 * событие 0x191C со статусом (MLME-POWERMGT.confirm).
 *
 * 6.4 apsta: после смены профиля синхронизирует UPM станции (upm.cpp) — в
 * 6.2 профиль на станции PS без графика не включал.
 */
#include "ps.h"

enum {
	WMI_PS_DEV_PROFILE_CFG_EVENTID = 0x191c,
	PS_DEV_PROFILE_CFG_EVENT_LEN   = 4,
	/* "POWER_MNGR::wmi_ps_dev_profile_cfg_cmd(ps_profile = %d)" */
	MSG_PS_PROFILE_CMD = 0x01002030,
	/* "<<---- [HOST EVENT] WMI_PS_DEV_PROFILE_CFG_EVENT status %d" */
	MSG_PS_PROFILE_EVT = 0x0100206c,
};

struct wmi_ps_dev_profile_cfg_cmd {
	u8 ps_profile;
};

extern "C" {
void *mem_pool__alloc_locked(u32 ctx);
void wmi_evt__post(u32 ctx, void *body, u32 a2, u32 evt_id, u32 len,
                   u32 a5, u32 a6, u32 a7, u32 a8);
/* 0 — профиль применён или уже активен, 1 — неверный профиль. */
u32  PS_CFG_SCHEME__switch_active_ps_profile(u32 profile, u32 a1);
}

extern "C" void POWER_MNGR__wmi_ps_dev_profile_cfg_cmd(const struct wmi_ps_dev_profile_cfg_cmd *cmd,
                                                      u32 a1, u32 ctx)
{
	u32 *evt = (u32 *)mem_pool__alloc_locked(ctx);

	fw_log_emit1(FWLOG_HDR(FWLOG_MOD_POWER_MNGR, FWLOG_LVL_INFO), MSG_PS_PROFILE_CMD,
	             cmd->ps_profile);
	u32 status = PS_CFG_SCHEME__switch_active_ps_profile(cmd->ps_profile, a1);
	*evt = status;
	upm__sync();
	fw_log_emit1(FWLOG_HDR(FWLOG_MOD_POWER_MNGR, FWLOG_LVL_INFO), MSG_PS_PROFILE_EVT, status);
	wmi_evt__post(ctx, evt, 0, WMI_PS_DEV_PROFILE_CFG_EVENTID, PS_DEV_PROFILE_CFG_EVENT_LEN,
	              a1, 0, 0, 0);
}
