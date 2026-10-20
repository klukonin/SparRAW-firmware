// SPDX-License-Identifier: AGPL-3.0-or-later
/* Общие объявления для блоков прошивки, переписанных на C/C++.
 *
 * Всё, что объявлено здесь, живёт в ещё не переписанном ассемблерном
 * дереве и линкуется по глобальному имени: адреса подставляет
 * ld/image-*.ld, поэтому здесь адресов нет.
 */
#ifndef WIL6210_FW_H
#define WIL6210_FW_H

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;

#ifdef __cplusplus
extern "C" {
#endif

/* Кольцо журнала прошивки.  Первый аргумент — номер подсистемы, второй —
 * уровень, третий — упакованный дескриптор строки (смещение в таблице
 * строк, номер подсистемы и уровень в старших битах).  Аргументы
 * значений печатаются хостом по формату из таблицы строк. */
void fw_log__emit0(u32 module, u32 level, u32 token);
void fw_log__emit1(u32 module, u32 level, u32 token, u32 a0);
void fw_log__emit2(u32 module, u32 level, u32 token, u32 a0, u32 a1);

/* lmac_if: берёт буфер команды, обнуляет поле +0x74 и шлёт в LMAC команду
 * 0x0b длиной 0x94 — остановку передачи маяка. Аргументов не принимает. */
void lmac_if__stop_beacon(void);

/* tx_bcon::del_bcon — снять маяк с передачи. Возвращает 0. */
int tx_bcon__del_bcon(void *bcon);

#ifdef __cplusplus
}
#endif

/* Номера подсистем журнала — те же, что печатает разбор кольца на хосте. */
enum {
	FWLOG_MOD_SYSTEM   = 0,
	FWLOG_MOD_MAC_MON  = 2,
	FWLOG_MOD_BSS      = 11,
	FWLOG_MOD_CONN_MGR = 11,
	FWLOG_MOD_TX_BCON  = 12,
};

enum {
	FWLOG_LVL_ERR     = 0,
	FWLOG_LVL_WARN    = 1,
	FWLOG_LVL_INFO    = 2,
	FWLOG_LVL_VERBOSE = 3,
};

#endif
