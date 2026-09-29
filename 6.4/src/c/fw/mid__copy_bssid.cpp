// SPDX-License-Identifier: AGPL-3.0-or-later
/* mid__copy_bssid — адрес BSSID в заголовок своего кадра (6.2: 0x8cbb58,
 * 40 байт).  Зовут построители кадров управления (DMG Beacon, Probe
 * Request/Response, ассоциация) и путь данных.
 *
 * bss+0x04 = 2 (BSS активен) — BSSID из bss+0x0c, иначе собственный MAC
 * узла ([bss] = mid, +0x0a).
 *
 * Изменение 6.4 (mesh): у члена DMG IBSS BSSID — всегда адрес ячейки.
 * Шаблон DMG Beacon собирается в pcp_start ещё до bss_set_active, и маяк
 * уходил со своим MAC, а Probe Response — уже с BSSID ячейки: соседи не
 * узнавали маяк своей IBSS (ни отмены BTI 11.1.3.5, ни TSF 11.1.5), а
 * сканирующая станция не сводила Probe Response с маяком и отбрасывала его.
 */
#include "ibss.h"

enum { MAC_ADDR_LEN = 6 };

extern "C" void *memcpy_fw(void *dst, const void *src, u32 len);

extern "C" void mid__copy_bssid(u8 *bss, u8 *dst)
{
	const u8 *src;

	if (g_ibss || *(u32 *)(bss + 0x04) == BSS_STATE_ACTIVE)
		src = bss + 0x0c;
	else
		src = *(u8 **)bss + 0x0a;
	memcpy_fw(dst, src, MAC_ADDR_LEN);
}
