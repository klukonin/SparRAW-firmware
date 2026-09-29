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

/* DMG IBSS (прошивка mesh): состояние случайной задержки маяка 11.1.3.5.
 * Прошивка обнуляет при старте ячейки (l2_mgr__pcp_start_flow), ucode
 * ведёт (bti__prepare_sweep_set); счётчики читаются с хоста для отладки. */
#define IBSS_UC_OFS          0x04
struct ibss_uc_state {
	u32 bti_us;             /* IBSS_BTI_US_VALID | длительность своего BTI, мкс */
	u32 sent;               /* BTI с развёрткой своего маяка */
	u32 cancelled;          /* BTI отменён: раньше пришёл маяк своей IBSS */
	u32 last_delay_us;      /* последняя задержка перед BTI */
};
#define IBSS_BTI_US_VALID    0x11bd0000u
#define IBSS_BTI_US_MASK     0xffffu
/* Пока BTI не измерен: 63 сектора ≈ 1,4 мс (замер 4.1, docs/BEACONING.md §9.2). */
#define IBSS_BTI_US_DEFAULT  1400u
#define IBSS_BTI_US_MIN      50u
#define IBSS_BTI_US_MAX      4000u


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

/* DMG IBSS (прошивка mesh): управление с хоста для опытов.  Слово =
 * IBSS_CTL_VALID | флаги; без записи (мусор включения) — всё по умолчанию. */
#define IBSS_CTL_OFS         0x28
#define IBSS_CTL_VALID       0x1b5c0000u
#define IBSS_CTL_VALID_MASK  0xffff0000u
#define IBSS_CTL_NO_DELAY    0x1u   /* маяк в TBTT без случайной задержки */
#define IBSS_CTL_VENDOR_BTI  0x2u   /* штатная развёртка, без кода 11.1.3.5 (опыты) */

/* DMG IBSS (прошивка mesh): синхронизация TSF 11.1.5 в прошивке — счётчики для
 * хоста (new/ibss_tsf.cpp).  Без маркера valid — мусор включения. */
#define IBSS_TSF_OFS         0x2c
struct ibss_tsf_state {
	u32 valid;              /* IBSS_TSF_VALID */
	u32 seen;               /* маяков своей ячейки */
	u32 adopted;            /* сколько раз принят более поздний TSF */
	u32 last_diff_us;       /* Timestamp маяка минус свой TSF, последний (со знаком) */
	u32 links;              /* запусков захвата линка (SLS в DTI) к соседу */
	u32 lost;               /* соседей отключено: нет маяков 100 отчётов MAC_MON */
};
#define IBSS_TSF_VALID       0x15f0115fu

#endif
