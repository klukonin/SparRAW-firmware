// SPDX-License-Identifier: AGPL-3.0-or-later
/* wmi_pcp_start — разбор тела WMI_PCP_START (0x918) (6.2: 0x8ec91c, 84 байта).
 *
 * Перекладывает поля команды во внутреннюю структуру и передаёт её
 * wmi_pcp_start_cmd_handler; канал и режим SME-offload кладёт в объект
 * настройки PCP (0x803b80).
 *
 * Добавлено в 6.4: бит 0 байта reserved[0] (байт 7 тела; ни 4.1, ни 6.2 его
 * не читают, мейнлайн-драйвер шлёт 0) включает безролевой линк — параметр
 * модуля драйвера roleless (патч драйвера 916).
 */
#include "fw.h"
#include "conn.h"

/* Тело WMI_PCP_START (wmi.h: struct wmi_pcp_start_cmd). */
struct wmi_pcp_start_cmd {
	u16 bcon_interval;         /* +0x00 */
	u8  pcp_max_assoc_sta;     /* +0x02 */
	u8  hidden_ssid;           /* +0x03 */
	u8  is_go;                 /* +0x04 */
	u8  edmg_channel;          /* +0x05: 6.2 не читает */
	u8  raw_mode;              /* +0x06: 6.2 не читает */
	u8  flags_64;              /* +0x07: reserved[0]; 6.4: бит 0 — безролевой линк */
	u8  reserved[2];           /* +0x08 */
	u8  abft_len;              /* +0x0a */
	u8  ap_sme_offload_mode;   /* +0x0b */
	u8  network_type;          /* +0x0c */
	u8  channel;               /* +0x0d */
	u8  disable_sec_offload;   /* +0x0e */
	u8  disable_sec;           /* +0x0f */
};
enum { WMI_PCP_START_FLAG_ROLELESS = 1u << 0 };

/* Внутренняя структура для wmi_pcp_start_cmd_handler (раскладка 6.2). */
struct pcp_start_req {
	u16 bcon_interval;         /* +0x00 */
	u16 zero_02;
	u32 zero_04;
	u32 zero_08;
	u8  network_type;          /* +0x0c */
	u8  pcp_max_assoc_sta;     /* +0x0d */
	u8  disable_sec_offload;   /* +0x0e */
	u8  disable_sec;           /* +0x0f */
	u8  hidden_ssid;           /* +0x10 */
	u8  is_go;                 /* +0x11 */
	u8  abft_len;              /* +0x12 */
	u8  unset_13;              /* +0x13: 6.2 не заполняет */
};
static_assert(sizeof(struct pcp_start_req) == 0x14, "pcp_start_req");

/* Объект настройки PCP 0x803b80: +0x00 канал, +0xa8 режим SME-offload. */
#define g_pcp_cfg_channel      FW_GLOBAL(u32, 0x803b80)
#define g_pcp_cfg_sme_offload  FW_GLOBAL(u8, 0x803b80 + 0xa8)

u32 g_roleless_link;

extern "C" void wmi_pcp_start_cmd_handler(struct pcp_start_req *req);

extern "C" void wmi_pcp_start(const struct wmi_pcp_start_cmd *cmd)
{
	struct pcp_start_req req;

	req.bcon_interval = cmd->bcon_interval;
	req.zero_02 = 0;
	req.zero_04 = 0;
	req.zero_08 = 0;
	req.network_type = cmd->network_type;
	req.pcp_max_assoc_sta = cmd->pcp_max_assoc_sta;
	req.hidden_ssid = cmd->hidden_ssid;
	req.disable_sec_offload = cmd->disable_sec_offload;
	req.disable_sec = cmd->disable_sec;
	req.is_go = cmd->is_go;
	req.abft_len = cmd->abft_len;
	g_pcp_cfg_channel = cmd->channel;
	g_pcp_cfg_sme_offload = cmd->ap_sme_offload_mode;

	g_roleless_link = cmd->flags_64 & WMI_PCP_START_FLAG_ROLELESS;

	wmi_pcp_start_cmd_handler(&req);
}
