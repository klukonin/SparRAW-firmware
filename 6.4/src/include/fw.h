// SPDX-License-Identifier: AGPL-3.0-or-later
/* Общие объявления для блоков прошивки 6.2.0.1000, переписанных на C/C++.
 *
 * Всё, что объявлено здесь, живёт в ассемблерном дереве и линкуется по
 * глобальному имени; адреса подставляет компоновщик.
 */
#ifndef WIL6210_FW62_H
#define WIL6210_FW62_H

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
typedef unsigned long long u64;
typedef long long s64;

#ifdef __cplusplus
extern "C" {
#endif

/* Кольцо журнала прошивки 6.2.  Первый аргумент — заголовок
 * FWLOG_HDR(модуль, уровень), второй — дескриптор строки (смещение в
 * таблице строк со старшими битами формата).  В запись добавляется слово
 * TSF (mac_read_tsf64). */
void fw_log_emit0(u32 hdr, u32 token);
void fw_log_emit1(u32 hdr, u32 token, u32 a0);
void fw_log_emit2(u32 hdr, u32 token, u32 a0, u32 a1);
void fw_log_emit3(u32 hdr, u32 token, u32 a0, u32 a1, u32 a2);

/* Прочитать 64-битный TSF MAC: out[0] — младшее слово, out[1] — старшее.
 * wait не 0 — сначала дождаться признака готовности счётчика. */
void mac_read_tsf64(u32 unused, u32 out[2], u32 wait);

/* Фатальная ошибка прошивки: адрес возврата вызывающего и код. */
void fw_sysassert_fatal(void *caller, u32 code);

/* tx_bcon::del_bcon — снять маяк с передачи. */
int tx_bcon__del_bcon(void *bcon);

/* LMAC-команда 0x0b «удалить маяк»: остановка передачи маяка. */
void lmac_if__send_bcon_del_0b(void);

/* PCIe: состояние LTSSM — L1 idle (не 0 — да). */
int hwd_pcie_ltssm_is_l1_idle(void);
/* PCIe: замаскировать прерывание входа в L1 (запись в регистр 0x882fe0). */
void pcie__mask_l1_enter_irq(void);

#ifdef __cplusplus
}
#endif

/* Разместить функцию в неиспользуемой области внутри fw_code
 * (0x8edd18..0x8f0000, 8936 байт) вместо свободного хвоста сегмента. */
#define FW_TEXT_GAP __attribute__((section(".text.gap")))
/* Начало зазора (0x8edd18) — точки входа по фиксированным адресам: на них
 * ссылаются таблицы переходов в данных (ветки диспетчера WMI).  Слот N
 * занимает 16 байт с адреса FW_GAP_SLOT_ADDR(N); функция слота объявляется
 * FW_GAP_SLOT("NN") и сама выравнивает свой размер до 16 байт.  Слоты:
 *   00 — WMI 0x859 BRP_RF_CHAINS_LIMIT (обе прошивки)
 *   01 — WMI 0x85a IBSS_BSSID (mesh) */
#define FW_GAP_SLOT(nn) __attribute__((section(".text.gap.head." nn), naked))
#define FW_GAP_SLOT_ADDR(n) (0x008edd18 + 16 * (n))

/* Глобальная переменная прошивки по абсолютному адресу (в дереве данных 6.2
 * меток нет; адрес — из листинга, gp fw = 0x800184). */
#define FW_GLOBAL(type, addr) (*(volatile type *)(addr))

/* Код страны регулятивного домена (u16). */
#define g_regulatory_country_code FW_GLOBAL(u16, 0x800214)

/* Описание BSS (vif) — поле mid+0x48; только известные поля. */
struct bss {
	u32 unknown_00;
	u32 state;              /* +0x04: BSS_STATE_* */
	u32 mode;               /* +0x08: BSS_MODE_* (bss_set_mode) */
	u8  unknown_0c[0x40];
	u8  channel;            /* +0x4c */
	u8  unknown_4d;
	u16 bcon_interval_tu;   /* +0x4e: интервал маяка в Probe Response */
	u16 bcon_interval2_tu;  /* +0x50: вторая копия интервала */
	u8  unknown_52[2];
	u8  is_go;              /* +0x54: из WMI_PCP_START */
	u8  abft_len;           /* +0x55: из WMI_PCP_START */
	u8  unknown_56[2];
	u32 unknown_58;         /* +0x58: байт +0x10 команды WMI_PCP_START */
};

enum {
	BSS_STATE_ACTIVE = 2,
	BSS_MODE_PBSS    = 2,
	BSS_MODE_AP      = 3,
};

#ifdef __cplusplus
extern "C" {
#endif
void bss_set_active(struct bss *bss);
void bss_set_mode(struct bss *bss, u32 mode);
#ifdef __cplusplus
}
#endif

/* Интервал маяка в TU из настройки хоста: пишут WMI_PCP_START и WMI 0x803. */
#define g_bcon_interval_tu FW_GLOBAL(u32, 0x8002d4)

/* Заголовок записи: биты 0..3 — модуль, биты 4..5 — уровень. */
#define FWLOG_HDR(mod, lvl) ((((lvl) & 3) << 4) | ((mod) & 0xf))

/* Номера модулей журнала — те же, что в 4.1. */
enum {
	FWLOG_MOD_SYSTEM   = 0,
	FWLOG_MOD_DRIVERS  = 1,
	FWLOG_MOD_MAC_MON  = 2,
	FWLOG_MOD_PHY_MON  = 4,
	FWLOG_MOD_BSS      = 11,
	FWLOG_MOD_TX_BCON  = 12,
	FWLOG_MOD_POWER_MNGR = 14,
};

enum {
	FWLOG_LVL_ERR     = 0,
	FWLOG_LVL_WARN    = 1,
	FWLOG_LVL_INFO    = 2,
	FWLOG_LVL_VERBOSE = 3,
};

/* Запись «Ucode->ИМЯ: type 0x0%x, curr tsf 0x%08x %08x» — как диспетчер
 * событий ucode 4.1 печатал каждое событие. */
static inline void fw_log_ucode_evt(u32 token, u32 type)
{
	u32 tsf[2];

	mac_read_tsf64(0, tsf, 0);
	fw_log_emit3(FWLOG_HDR(FWLOG_MOD_SYSTEM, FWLOG_LVL_INFO), token, type, tsf[1], tsf[0]);
}

#endif
