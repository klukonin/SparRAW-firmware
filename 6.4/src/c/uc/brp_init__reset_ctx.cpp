// SPDX-License-Identifier: AGPL-3.0-or-later
/* brp_init__reset_ctx — подготовка дескриптора BRP к новому обмену со станцией
 * (ucode 6.2: 0x92afb8, 176 байт).  Аналог brp__reset_db 4.1.
 *
 * Зовёт brp_init__flow в начале BRP-инициатора.  Очищает дескриптор и
 * таблицы кандидатов секторов, записывает CID и маску РЧ-цепочек, флаги
 * режима по записи станции и шлёт команду MAC 0x02011000.
 *
 * Возвращено из 4.1: длина списка лучших секторов BRP (поле 15..20 слова
 * +0x00 дескриптора, читает brp__pick_sector_cfg) снова задаётся хостом —
 * WMI 0x859, как в 4.1.  Без команды остаётся значение из образа (10).
 * Лимит антенн по станции (WMI 0x924, LMAC 0x32) по-прежнему его перекрывает.
 */
#include "uc.h"
#include "fw_uc_shared.h"

/* Дескриптор BRP (0x800824; в 4.1 — 0x800734). Только нужные поля. */
struct brp_desc {
	u32 cfg;                /* +0x00: биты 15..20 — длина списка лучших секторов */
	u8  rf_chains;          /* +0x04: маска РЧ-цепочек */
	u8  unknown_05[3];
	u32 cand[8][2];         /* +0x08: по РЧ-цепочке */
	u8  cid;                /* +0x48 */
	u8  unknown_49[3];
	u32 rf_chains_word;     /* +0x4c */
	u32 flags;              /* +0x50 */
	u32 mode;               /* +0x54: биты 4..8 — число из записи станции */
};
static_assert(__builtin_offsetof(struct brp_desc, cid) == 0x48, "brp_desc+0x48");
static_assert(__builtin_offsetof(struct brp_desc, mode) == 0x54, "brp_desc+0x54");
#define g_brp_desc (*(volatile struct brp_desc *)0x00800824)

enum {
	BRP_LIST_LEN_SHIFT = 15,
	BRP_FLAG_ACTIVE    = 1u << 0,
	BRP_FLAG_B9        = 1u << 9,    /* станция без бита 0 в записи +0x0a */
	BRP_FLAG_B16       = 1u << 16,
	BRP_MODE_B2        = 1u << 2,
	MAC_CMD_BRP_RESET  = 0x02011000,
};

/* Маска РЧ-цепочек BRP (байт 0x8006b7, в образе 1). */
#define g_brp_rf_chains UC_GLOBAL(u8, 0x008006b7)

/* Запись станции для BRP: 0x801ffc + cid * 20. */
struct brp_sta {
	u8 unknown_00[9];
	u8 n;                   /* +0x09 */
	u8 flags;               /* +0x0a: бит 0 */
	u8 unknown_0b[9];
};
static_assert(sizeof(struct brp_sta) == 20, "brp_sta");
#define brp_sta_table ((volatile struct brp_sta *)0x00801ffc)

/* Таблицы кандидатов по РЧ-цепочке: 8 × 64 и 8 × 32 байта. */
#define BRP_CAND_A(i) ((void *)(0x00801c94 + (i) * 0x40))
#define BRP_CAND_B(i) ((void *)(0x00801ef4 + (i) * 0x20))

/* WMI 0x859 (fw_uc_shared.h). */
#define g_brp_list_len UC_GLOBAL(u32, UC_EXT_DATA_UC(BRP_LIST_LEN_OFS))

extern "C" void brp__bits_uc_set32_s4_w5(volatile u32 *word, u32 value);

extern "C" void brp_init__reset_ctx(u32 cid)
{
	volatile struct brp_desc *d = &g_brp_desc;

	memset0_words_uc((void *)&d->cid, 0x10);

	/* как brp__reset_db 4.1: длина списка из настройки хоста */
	u32 len = g_brp_list_len;
	if ((len & ~BRP_LIST_LEN_MASK) == BRP_LIST_LEN_VALID)
		d->cfg = (d->cfg & ~(BRP_LIST_LEN_MASK << BRP_LIST_LEN_SHIFT)) |
		         ((len & BRP_LIST_LEN_MASK) << BRP_LIST_LEN_SHIFT);

	u8 chains = g_brp_rf_chains;
	d->cid = cid;
	d->rf_chains = chains;
	u32 flags = d->flags | BRP_FLAG_ACTIVE | BRP_FLAG_B16;
	d->flags = flags;
	d->rf_chains_word = chains;

	for (u32 i = 0; i < 8; i++) {
		d->cand[i][0] = 0;
		d->cand[i][1] = 0;
		memset0_words_uc(BRP_CAND_A(i), 0x40);
		memset0_words_uc(BRP_CAND_B(i), 0x20);
	}

	volatile struct brp_sta *s = &brp_sta_table[cid];
	if (!(s->flags & 1)) {
		d->flags = flags | BRP_FLAG_B9;
	} else if (s->n >= 1) {
		d->mode |= BRP_MODE_B2;
		brp__bits_uc_set32_s4_w5(&d->mode, s->n & 0x1f);
	}

	mac_cmd(MAC_CMD_BRP_RESET);
}
