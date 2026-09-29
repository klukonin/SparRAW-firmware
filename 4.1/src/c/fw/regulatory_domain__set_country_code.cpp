// SPDX-License-Identifier: AGPL-3.0-or-later
/* regulatory_domain::set_country_code (0x8e1670, 20 байт).
 *
 * Запоминает код страны в глобальной переменной 0x8001fc (полуслово; её же
 * читают четыре функции в hw_flows_rf) и печатает его в журнал. Оригинал
 * уходит в fw_log__emit1 хвостовым переходом.
 */
#include "fw.h"

/* Метка стоит в сегменте данных: src/data/fw_data.S, адрес 0x8001fc. */
extern "C" u16 g_8001fc;

/* "regulatory_domain::set_country_code. country code: 0x%0x", смещение 0xeadc */
enum { MSG_SET_COUNTRY = 0x0100eadc };

extern "C" void regulatory_domain__set_country_code(u16 cc)
{
	g_8001fc = cc;
	fw_log__emit1(FWLOG_MOD_SYSTEM, FWLOG_LVL_INFO, MSG_SET_COUNTRY, cc);
}
