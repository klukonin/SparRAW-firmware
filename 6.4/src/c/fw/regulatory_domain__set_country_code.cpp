// SPDX-License-Identifier: AGPL-3.0-or-later
/* regulatory_domain::set_country_code — запомнить код страны (6.2: 20 байт).
 *
 * Зовут из mid__apply_app_ies и discovery_handle_probe_resp.  Тот же код,
 * что в 4.1 (там переменная лежит по 0x8001fc).
 */
#include "fw.h"

/* "regulatory_domain::set_country_code. country code: 0x%x" */
enum { MSG_SET_COUNTRY = 0x01010dd0 };

extern "C" void regulatory_domain__set_country_code(u16 country_code)
{
	g_regulatory_country_code = country_code;
	fw_log_emit1(FWLOG_HDR(FWLOG_MOD_SYSTEM, FWLOG_LVL_INFO), MSG_SET_COUNTRY, country_code);
}
