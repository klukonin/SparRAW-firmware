// SPDX-License-Identifier: AGPL-3.0-or-later
/* wmi__post_temp_sense_done — ответ хосту на измерение температуры
 * (6.2: 0x8e5dac, 60 байт).
 *
 * Собирает событие WMI_TEMP_SENSE_DONE_EVENTID (0x180e): температура
 * baseband и РЧ в тысячных долях °C.  Тело события в 6.2 — 0x24 байта
 * (в 4.1 — 8), заполняются первые два слова.
 *
 * Возвращено из 4.1: запись в журнал с обеими температурами.
 */
#include "fw.h"
#include "strings-fw.h"

enum {
	WMI_TEMP_SENSE_DONE_EVENTID = 0x180e,
	TEMP_SENSE_DONE_LEN         = 0x24,
};

struct wmi_temp_sense_done_event {
	u32 baseband_t1000;   /* °C × 1000 */
	u32 rf_t1000;
};

extern "C" {
/* Буфер события из пула (под запретом прерываний). */
void *mem_pool__alloc_locked(u32 ctx);
void wmi_evt__post(u32 ctx, void *body, u32 a2, u32 evt_id, u32 len,
                   u32 a5, u32 a6, u32 a7, u32 a8);
}

/* ctx — то, что вызывающий передаёт и в выделение буфера, и в отправку
 * события (в обеих версиях это один и тот же аргумент). */
extern "C" void wmi__post_temp_sense_done(u32 baseband_t1000, u32 rf_t1000, u32 ctx)
{
	struct wmi_temp_sense_done_event *evt =
		(struct wmi_temp_sense_done_event *)mem_pool__alloc_locked(ctx);

	evt->baseband_t1000 = baseband_t1000;
	evt->rf_t1000 = rf_t1000;
	fw_log_emit2(FWLOG_HDR(FWLOG_MOD_SYSTEM, FWLOG_LVL_INFO), MSG64_TEMP_SENSE_DONE,
	             baseband_t1000, rf_t1000);

	wmi_evt__post(ctx, evt, 0, WMI_TEMP_SENSE_DONE_EVENTID, TEMP_SENSE_DONE_LEN,
	              0, 0, 0, 0);
}
