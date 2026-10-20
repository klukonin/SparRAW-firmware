// SPDX-License-Identifier: AGPL-3.0-or-later
/* Расписание ESE чужой (и своей) точки у станции: какие аллокации брать
 * (6.4, прошивка apsta; 802.11-2020 10.39.4, 10.39.5, 10.39.6.2).
 *
 * 6.2 держит в таблице аллокаций ESE (3 записи) все поля, где станция —
 * источник или назначение, либо адрес широковещательный, не глядя на тип;
 * бит «источник» записи ставит при Source AID = свой или 255.  Доступ к
 * среде расписание не ограничивало: EDCA работала весь DTI.
 *
 * Теперь (патч 0018) при CBAP Only = 0 DTI по умолчанию закрыт (10.39.4), а
 * в таблицу идут только окна, где станции можно инициировать обмен, плюс
 * SP, где она назначение (события PS ucode):
 *   SP  (тип 0): источник = свой — инициировать можно; назначение = свой —
 *                запись без права инициации (10.39.6.2: в SP передаёт
 *                источник, назначение только отвечает);
 *   CBAP (тип 1): Source AID = свой или 255, либо Destination AID = свой
 *                (10.39.5);
 *   прочее — не берётся: чужие SP и CBAP, SP с широковещательным адресом
 *   (в том числе «барьер» 255→255, стр. 124106) соблюдаются тем, что DTI
 *   вне разрешённых окон закрыт.
 * Бит 7 записи (в пак-имени is_source) теперь значит «инициировать можно»:
 * по нему ucode открывает передачу на время окна (uc/new/ese_dti.cpp).
 *
 * Флаг «DTI расписан» ставится по каждому маяку своей точки.  Вендорское
 * фиксированное расписание (WMI 0xa03) идёт своим путём — при нём флаг 0.
 */
#include "fw.h"
#include "fw_uc_shared.h"

enum {
	AID_BROADCAST        = 0xff,
	ALLOC_TYPE_SP        = 0,
	ALLOC_TYPE_CBAP      = 1,
	ESE_FIELD_LEN        = 15,
	ESE_FIELDS_MAX       = 255 / ESE_FIELD_LEN,
	DMG_PARAMS_CBAP_ONLY = 0x04,
};

/* Поле аллокации ESE (9.4.2.131): Allocation Control, BF Control, Source
 * AID, Destination AID, Allocation Start, ... */
struct ese_field {
	u8 control_lo;          /* B0..B3 Allocation ID, B4..B6 Allocation Type */
	u8 control_hi;
	u8 bf_control[2];
	u8 source_aid;
	u8 destination_aid;
};

static inline u32 alloc_type(const u8 *f)
{
	return (f[0] >> 4) & 0x7;
}

/* Свой AID: [[схема+0x10]+8] (так читает cid_pair__matches). */
static inline u8 own_aid(const u8 *scheme)
{
	return *(*(u8 *const *)(scheme + 0x10) + 8);
}

/* Брать ли поле в таблицу (вместо cid_pair__matches в разборе маяка). */
extern "C" u32 ese_rx__alloc_wanted(const u8 *scheme, u32 src, u32 dst, const u8 *f)
{
	u32 own = own_aid(scheme);

	switch (alloc_type(f)) {
	case ALLOC_TYPE_SP:
		return src == own || dst == own;
	case ALLOC_TYPE_CBAP:
		return src == own || src == AID_BROADCAST || dst == own;
	default:
		return 0;
	}
}

/* Бит 7 записи: инициировать обмен в окне можно (вместо «источник»). */
extern "C" u32 ese_rx__may_initiate(const u8 *f, const u8 *scheme)
{
	if (alloc_type(f) == ALLOC_TYPE_CBAP)
		return 1;       /* в таблице только разрешённые CBAP */
	return f[4] == own_aid(scheme);
}

/* sched__alloc_changed замечает только смену ID и адресов первого поля:
 * новое начало или длительность, другие поля и их число до железа не
 * доходили.  Сравнивается всё ESE. */
extern "C" u32 sched__alloc_changed(void *scheme, const u8 *fields, u32 count);

static u8 g_ese_last[ESE_FIELDS_MAX * ESE_FIELD_LEN];
static u8 g_ese_last_count;

extern "C" u32 ese_rx__alloc_changed(void *scheme, const u8 *fields, u32 count)
{
	u32 changed = sched__alloc_changed(scheme, fields, count);
	u32 n = count > ESE_FIELDS_MAX ? ESE_FIELDS_MAX : count;
	u32 len = n * ESE_FIELD_LEN;

	if (n != g_ese_last_count)
		changed = 1;
	for (u32 i = 0; i < len; i++) {
		if (g_ese_last[i] != fields[i]) {
			changed = 1;
			g_ese_last[i] = fields[i];
		}
	}
	g_ese_last_count = n;
	return changed;
}

/* Флаг «DTI расписан» по маяку своей точки; затем штатный впрыск BCON_RX.
 * rx — контекст приёма (r14 dmg_bcon__rx_handler): [+0xc] таблица
 * элементов, её +0x6c — ESE, +0x84 — DMG Parameters. */
extern "C" void conn_main_sm__inject_bcon_rx(void *conn, void *rx);

#define g_fixed_sched_en FW_GLOBAL(u8, 0x00847adc + 5)
#define g_ese_dti (*(volatile struct ese_dti_state *)UC_EXT_DATA_FW(ESE_DTI_OFS))

extern "C" void ese_rx__on_own_beacon(void *conn, u8 *rx)
{
	const u8 *ei = *(const u8 *const *)(rx + 0xc);
	const u8 *ese = *(const u8 *const *)(ei + 0x6c);
	const u8 *dmg = *(const u8 *const *)(ei + 0x84);
	u32 sched = ese && dmg && !(dmg[0] & DMG_PARAMS_CBAP_ONLY) && !g_fixed_sched_en;

	if ((g_ese_dti.flags & ESE_DTI_VALID_MASK) != ESE_DTI_VALID) {
		g_ese_dti.closed = 0;
		g_ese_dti.opened = 0;
		g_ese_dti.beacons = 0;
	}
	g_ese_dti.flags = ESE_DTI_VALID | (sched ? ESE_DTI_SCHEDULED : 0);
	if (sched)
		g_ese_dti.beacons = g_ese_dti.beacons + 1;
	conn_main_sm__inject_bcon_rx(conn, rx);
}

/* Входы из ассемблера (патч 0018).
 * - schedule_scheme_builder__build_allocations_from_beacon, вместо
 *   cid_pair__matches: r0 схема, r1 Source AID, r2 Destination AID (слот
 *   задержки), поле — в r13 вызывающего.
 * - ese__alloc_to_slot, вместо вычисления «источника» (20 байт): r13 поле,
 *   r14 схема; результат 0/1 в r1, собираемое слово в r0 не трогается.
 */
__asm__(
	"	.section .text.ese_rx_entries,\"ax\",@progbits\n"
	"	.p2align 2\n"
	"	.global ese_rx__alloc_wanted_entry\n"
	"ese_rx__alloc_wanted_entry:\n"
	"	b.d ese_rx__alloc_wanted\n"
	"	mov_s r3,r13\n"
	"	.global ese_rx__may_initiate_entry\n"
	"ese_rx__may_initiate_entry:\n"
	"	push_s blink\n"
	"	push_s r0\n"
	"	mov_s r0,r13\n"
	"	bl.d ese_rx__may_initiate\n"
	"	mov_s r1,r14\n"
	"	mov_s r1,r0\n"
	"	pop_s r0\n"
	"	pop_s blink\n"
	"	j_s [blink]\n");
