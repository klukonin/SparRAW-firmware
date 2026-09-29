// SPDX-License-Identifier: AGPL-3.0-or-later
/* Общие объявления для блоков ucode, переписанных на C++.
 *
 * Адресное пространство ucode своё: код 0x920000 (линкерный 0x000000),
 * данные 0x940000 (линкерный 0x800000).  С кодом прошивки оно не
 * пересекается, хотя адреса выглядят одинаково.
 */
#ifndef WIL6210_UC_H
#define WIL6210_UC_H

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;

/* Кольцо журнала ucode лежит в его памяти данных: указатель записи по
 * 0x80209c, байты разрешённых уровней сразу за ним, само кольцо на 256
 * слов — по 0x8020b0.  Прошивка забирает его через blob_uc_data. */
#define UCLOG_WPTR   (*(volatile u32 *)0x0080209c)
#define UCLOG_LEVELS ((volatile u8 *)0x008020a0)
#define UCLOG_RING   ((volatile u32 *)0x008020b0)

static inline void uclog(u32 token)
{
	u32 w = UCLOG_WPTR;
	UCLOG_RING[(u8)w] = token;
	UCLOG_WPTR = w + 1;
}

/* Порядок записи тот же, что в прошивке: сначала аргументы, слово-заголовок
 * последним — иначе хост успевает прочесть заголовок без аргументов. */
static inline void uclog1(u32 token, u32 arg)
{
	u32 w = UCLOG_WPTR;
	UCLOG_RING[(u8)(w + 1)] = arg;
	UCLOG_RING[(u8)w] = token;
	UCLOG_WPTR = w + 2;
}

static inline bool uclog_enabled(u32 module, u32 level)
{
	return (UCLOG_LEVELS[module] >> level) & 1;
}

/* r42 — регистр состояния событий ucode: биты в нём те же, что в регистре
 * разрешения пробуждения 0x886d3c, с которым работает uc_sleep_until_event. */
static inline u32 uc_events(void)
{
	u32 v;
	__asm__ volatile("mov %0,r42" : "=r"(v));
	return v;
}

/* Регистры MAC пишутся не напрямую, а через кольцо команд: слово
 * кладётся по адресу в r25 с автоинкрементом, после чего бит 10
 * адреса сбрасывается — так кольцо заворачивается. */
static inline void mac_cmd(u32 word)
{
	__asm__ volatile("mov r32,%0\n\t"
	                 "st.ab %0,[r25,0x4]\n\t"
	                 "bclr r25,r25,0xa"
	                 : : "r"(word) : "memory");
}

/* Аппаратный сравниватель TSF: 64-битное значение и слово управления. */
#define TSF_CMP_LO  (*(volatile u32 *)0x00886d30)
#define TSF_CMP_HI  (*(volatile u32 *)0x00886d34)
#define TSF_CMP_CTL (*(volatile u32 *)0x00886d38)
enum { TSF_CMP_ARM = 0x000c0050, TSF_CMP_DISARM = 0x000c0010 };

#endif
