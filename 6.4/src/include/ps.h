// SPDX-License-Identifier: AGPL-3.0-or-later
/* Энергосбережение без графика (802.11-2020 11.2.7.2.2, DMG-M13.1), сторона
 * AP прошивки apsta.
 *
 * Спящие станции ведёт ucode: бит PM принятых кадров (R38 бит 26) копится в
 * маске upm_vector объекта PM ucode (0x802f80+0x178), бит на CID.  Прошивка
 * узнаёт о смене маски событием ucode 0x16 и гасит кольца спящих.  Здесь —
 * то, чего в 6.2 нет: элемент UPSIM в DMG Beacon (9.4.2.166) и обязательное
 * Awake Window, пока спит хоть одна станция.
 */
#ifndef WIL6210_FW62_PS_H
#define WIL6210_FW62_PS_H

#include "fw.h"

/* upm_vector ucode, как его видит прошивка (окно данных ucode 0x94xxxx). */
#define g_uc_upm_vector   FW_GLOBAL(u8, 0x009430f8)

/* CID с открытым портом данных (ps_connection_mgr__on_assoc / on_disassoc). */
#define g_ps_conn_mask    FW_GLOBAL(u32, 0x00800274)
/* Активный профиль PS хоста (PS_CFG_SCHEME, WMI 0x91C): 0 DEFAULT, 1 PS_DISABLED. */
#define g_ps_active_profile FW_GLOBAL(u32, 0x00803d5c + 0x24)
/* 1 — ucode запущен и принимает команды LMAC. */
#define g_lmac_ready      FW_GLOBAL(u32, 0x008003c8)
/* Настройка PS: 0x80043c = «PS разрешён» (профиль), соединения — 0x803db0 + 0x88·cid. */
#define g_ps_enabled      FW_GLOBAL(u32, 0x0080043c)
#define PS_CONNECTION(cid) ((void *)(0x00803db0 + 0x88 * (cid)))

enum {
	PS_PROFILE_DEFAULT = 0,
	UPM_IDLE_TIMEOUT_US = 30000,    /* значение ucode 6.2 по умолчанию */
};

/* UPSIM, 9.4.2.166. */
enum {
	EID_UPSIM             = 200,
	UPSIM_PS_PCP          = 1u << 0,    /* в инфраструктурной BSS всегда 0 */
	UPSIM_PS_NON_PCP      = 1u << 1,    /* спят все станции */
	UPSIM_OFFSET_SHIFT    = 3,          /* Bitmap Offset, B3..B7 */
	UPSIM_MAP_OCTETS      = 32,         /* виртуальная карта 256 бит по AID */
	UPSIM_AID_MIN         = 1,
	UPSIM_AID_MAX         = 254,
	UPSIM_IE_MAX          = 3 + UPSIM_MAP_OCTETS,
};

#ifdef __cplusplus
extern "C" {
#endif
/* Записать UPSIM для маски спящих CID; длина элемента, 0 — никто не спит. */
u32  ie__push_upsim(u8 *p, u32 upm_cids);
/* Маска, с которой собран текущий маяк, и интерфейс, для которого он собран. */
extern u32   g_upsim_bcon_upm;
extern void *g_upsim_bcon_mid;
/* Пересобрать маяк, если маска спящих изменилась с последней сборки. */
void ps_upsim__refresh_bcon(void);
/* Станция: UPM (PS без графика) включён, пока профиль хоста DEFAULT и порт
 * данных к точке открыт; иначе выключен (LMAC 0x33). */
void upm__sync(void);
#ifdef __cplusplus
}
#endif

#endif
