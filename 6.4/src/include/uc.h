// SPDX-License-Identifier: AGPL-3.0-or-later
/* Общие объявления для блоков ucode 6.2.0.1000, переписанных на C/C++.
 *
 * Адресное пространство ucode своё: код 0x920000 (линкерный 0x000000),
 * данные 0x940000 (линкерный 0x800000).  С кодом прошивки оно не
 * пересекается, хотя адреса выглядят одинаково.
 */
#ifndef WIL6210_UC62_H
#define WIL6210_UC62_H

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;

#ifdef __cplusplus
extern "C" {
#endif

/* Запись в журнал ucode без аргументов: заголовок UCLOG_HDR(модуль, уровень)
 * и дескриптор строки.  В 6.2 журнал ведут функции (в 4.1 запись шла
 * прямо в кольцо); имя блока в дереве — uc_log__emit_snapshot. */
void uc_log__emit_snapshot(u32 hdr, u32 token);
/* То же с двумя аргументами строки. */
void uc_log__emit2(u32 hdr, u32 token, u32 a0, u32 a1);

/* Фатальная ошибка ucode: адрес возврата вызывающего и код ошибки. */
void uc_sysassert(void *caller, u32 code);

/* Обнулить память словами; длина в БАЙТАХ. */
void memset0_words_uc(void *dst, u32 len);

#ifdef __cplusplus
}
#endif

/* Глобальная переменная ucode по абсолютному адресу пространства данных
 * ucode (gp ucode = 0x800528). */
#define UC_GLOBAL(type, addr) (*(volatile type *)(addr))

/* Прерывания ucode: бит 1 STATUS32 (вспомогательный регистр 0xa) — E1.
 * irq_save запрещает их и возвращает прежний STATUS32; irq_restore
 * возвращает прежнее состояние бита, не трогая остальные. */
static inline u32 irq_save(void)
{
	u32 st;
	__asm__ volatile("lr %0,[0xa]" : "=r"(st));
	__asm__ volatile("flag %0" : : "r"(st & ~2u) : "memory");
	return st;
}

static inline void irq_restore(u32 saved)
{
	u32 st;
	__asm__ volatile("lr %0,[0xa]" : "=r"(st));
	__asm__ volatile("flag %0" : : "r"((saved & 2u) | st) : "memory");
}

/* Заголовок записи журнала ucode: биты 0..3 — модуль, биты 4..5 — уровень. */
#define UCLOG_HDR(mod, lvl) ((((lvl) & 3) << 4) | ((mod) & 0xf))

enum {
	UCLOG_MOD_SYSTEM = 0,
	UCLOG_LVL_ERR    = 0,
	UCLOG_LVL_INFO   = 2,
};

/* Регистры MAC пишутся через кольцо команд: слово кладётся по адресу в r25
 * с автоинкрементом, затем бит 10 адреса сбрасывается (кольцо
 * заворачивается).  r25 зарезервирован флагом -ffixed-r25. */
static inline void mac_cmd(u32 word)
{
	__asm__ volatile("mov r32,%0\n\t"
	                 "st.ab %0,[r25,0x4]\n\t"
	                 "bclr r25,r25,0xa"
	                 : : "r"(word) : "memory");
}

/* Селектор MAC (команда 0x1d): поля по 4 бита выбирают, что показывают
 * регистры чтения r40, r41, r47.  Текущее значение полей хранится в
 * тени [gp-0x44]; после команды до чтения регистра — три такта. */
#define g_mac_select_shadow UC_GLOBAL(u32, 0x008004e4)
enum {
	MAC_CMD_SELECT        = 0x1d000000,
	MAC_SEL_R41_SHIFT     = 8,       /* 3 — r41 бит 30 «маяк в очереди» */
	MAC_SEL_R40_SHIFT     = 12,      /* 4 — r40 = позиция в BI, мкс */
	MAC_SEL_R47_SHIFT     = 16,      /* 2 — r47 = LFSR */
	MAC_SEL_R41_BCON_Q    = 3,
	MAC_SEL_R40_BI_POS    = 4,
	MAC_SEL_R47_LFSR      = 2,
};

static inline void mac_select(u32 shift, u32 val)
{
	u32 sh = g_mac_select_shadow & ~(0xfu << shift);
	g_mac_select_shadow = sh | (val << shift);
	mac_cmd(MAC_CMD_SELECT | sh | (val << shift));
	__asm__ volatile("nop_s\n\tnop_s\n\tnop_s" : : : "memory");
}

/* Регистры событий и чтения MAC (ядро ucode, r32..r59). */
#define UC_READ_REG(reg) ({ u32 v_; __asm__ volatile("mov %0," #reg : "=r"(v_) : : "memory"); v_; })

/* Биты r42 (события группы 1) и r54 (группы 4, таймеры GP). */
enum {
	EV1_RX_FRAME   = 1u << 12,
	EV1_PPDU_REPORT = 1u << 16,
	EV4_GP0_END    = 1u << 6,
};

/* Старшие 32 бита произведения a·b (mulu64, как в коде вендора). */
static inline u32 mul_hi32(u32 a, u32 b)
{
	u32 hi;
	__asm__ volatile("mulu64 %1,%2\n\tmov %0,mhi" : "=r"(hi) : "r"(a), "r"(b));
	return hi;
}

/* Аппаратный сравниватель TSF: 64-битное значение и слово управления. */
#define TSF_CMP_LO  (*(volatile u32 *)0x00886d30)
#define TSF_CMP_HI  (*(volatile u32 *)0x00886d34)
#define TSF_CMP_CTL (*(volatile u32 *)0x00886d38)
enum { TSF_CMP_ARM = 0x000c0050, TSF_CMP_DISARM = 0x000c0010 };

#endif
