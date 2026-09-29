// SPDX-License-Identifier: AGPL-3.0-or-later
/* uc_bi_counter_in_window — ворота A приёма маяков в BTI (ucode 6.2:
 * 0x937474, 100 байт).
 *
 * Зовёт bti__bi2_event_step перед ожиданием чужого маяка.  Приём разрешён в
 * начале BI (первые 2500 мкс — там BTI) и в последние 25 мкс перед TBTT.
 * Позиция в BI сохраняется для прочих шагов BTI.
 *
 * Прошивка mesh (DMG IBSS, 11.1.3.5): BTI члена ячейки начинается после
 * случайной задержки до 2·aCWminDMGIBSS·BTI (bti__prepare_sweep_set), поэтому
 * окно шире на эту задержку и ещё один BTI.
 */
#include "uc.h"
#include "fw_uc_shared.h"

enum {
	BI_POS_MASK         = 0x3ffffff,
	BTI_RX_WINDOW_US    = 2500,
	BI_END_GUARD_US     = 25,
};

/* Позиция в BI последнего замера ([gp-0x50]). */
#define g_bi_pos_us     UC_GLOBAL(u32, 0x008004d8)
/* Длина BI, мкс (слово перед блоком конфигурации BI 0x8022a8). */
#define g_bi_len_us     UC_GLOBAL(u32, 0x008022a4)

#ifdef FW64_MESH
#define g_ibss_uc (*(volatile struct ibss_uc_state *)UC_EXT_DATA_UC(IBSS_UC_OFS))
enum { A_CW_MIN_DMG_IBSS = 3 };     /* 802.11-2020 табл. 11-22 */

static u32 rx_window_us(void)
{
	u32 w = g_ibss_uc.bti_us;
	u32 bti = (w & ~IBSS_BTI_US_MASK) == IBSS_BTI_US_VALID ? w & IBSS_BTI_US_MASK
	                                                        : IBSS_BTI_US_DEFAULT;
	return BTI_RX_WINDOW_US + (2 * A_CW_MIN_DMG_IBSS + 1) * bti;
}
#else
static inline u32 rx_window_us(void) { return BTI_RX_WINDOW_US; }
#endif

extern "C" u32 uc_bi_counter_in_window(void *ctx)
{
	(void)ctx;
	mac_select(MAC_SEL_R40_SHIFT, MAC_SEL_R40_BI_POS);
	u32 pos = UC_READ_REG(r40) & BI_POS_MASK;
	g_bi_pos_us = pos;
	return pos > g_bi_len_us - BI_END_GUARD_US || pos < rx_window_us();
}
