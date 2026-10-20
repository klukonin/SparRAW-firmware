// SPDX-License-Identifier: AGPL-3.0-or-later
/* Ячейки 6.4, общие для прошивки и ucode.
 *
 * Лежат в свободной области данных ucode 0x803a48..0x804000 (за вершиной
 * стека ucode; 1464 байта, ld/memory.ld).  ucode видит их по своему адресу
 * 0x80xxxx, прошивка — через окно данных ucode 0x94xxxx.  Область не
 * загружается из образа: после включения там случайные байты, поэтому
 * каждое значение хранится с признаком действительности в старшей половине.
 */
#ifndef WIL6210_FW_UC_SHARED_H
#define WIL6210_FW_UC_SHARED_H

#define UC_EXT_DATA_UC(ofs)  (0x00803a48 + (ofs))   /* адрес для ucode */
#define UC_EXT_DATA_FW(ofs)  (0x00943a48 + (ofs))   /* адрес для прошивки */

/* WMI 0x859 BRP_RF_CHAINS_LIMIT (из 4.1): длина списка лучших секторов BRP,
 * 6 бит.  Слово = BRP_LIST_LEN_VALID | N; без команды — значение из образа
 * ucode (10), как 4.1 по умолчанию. */
#define BRP_LIST_LEN_OFS     0x00
#define BRP_LIST_LEN_VALID   0x08590000u
#define BRP_LIST_LEN_MASK    0x3fu

/* PS без графика (прошивка apsta): станция в UPM-doze приняла адресованный ей
 * ATIM (ставит путь приёма ucode, снимает начало DTI).  Не 0 — принят. */
#define UPM_ATIM_RX_OFS      0x14

/* Расписание DTI от точки (прошивка apsta, станция; 802.11-2020 10.39.4,
 * 10.39.5, 10.39.6.2).  Прошивка по каждому маяку своей точки ставит
 * ESE_DTI_SCHEDULED, если в маяке есть ESE и CBAP Only = 0 (весь DTI не
 * CBAP): тогда инициировать обмен можно только в разрешённых окнах.  ucode
 * закрывает передачу в начале DTI и открывает её на окна с битом «инициация
 * разрешена» (new/ese_dti.cpp).  Счётчики — для отладки с хоста. */
#define ESE_DTI_OFS          0x18
struct ese_dti_state {
	u32 flags;              /* ESE_DTI_VALID | ESE_DTI_SCHEDULED */
	u32 closed;             /* ucode: сколько раз передача закрыта */
	u32 opened;             /* ucode: сколько раз открыта на окно */
	u32 beacons;            /* прошивка: маяков с расписанием */
};
#define ESE_DTI_VALID        0xe5e00000u
#define ESE_DTI_VALID_MASK   0xffff0000u
#define ESE_DTI_SCHEDULED    0x1u

#endif
