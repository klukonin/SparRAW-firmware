// SPDX-License-Identifier: AGPL-3.0-or-later
/* Доступ станции к среде по расписанию ESE (6.4, прошивка apsta;
 * 802.11-2020 10.39.4, 10.39.5, 10.39.6.2).
 *
 * При CBAP Only = 0 станция в DTI может инициировать обмен только в
 * CBAP-аллокациях, где ей это разрешено, и в своих SP как источник; вне
 * них — молчать.  В 6.2 расписание доступ не ограничивало: EDCA работала
 * весь DTI.  Здесь DTI по умолчанию закрыт, окна открывают его.
 *
 * Флаг «DTI расписан» ставит прошивка по маякам точки
 * (fw/new/ese_rx.cpp); она же оставляет в таблице аллокаций только
 * разрешённые окна и SP, где станция назначение, и ставит в записи бит 7
 * «инициировать можно».  Аппаратный массив SP даёт события начала и конца
 * записей (dti_worker__scheduled_dti_allocation_event).
 *
 * Рычаг — пауза передачи станции (bf__pause_sta_tx / bf__resume_sta_tx):
 * битовая маска причин на CID (0x802a90), очереди пира убираются из
 * опубликованных масок qset и возвращаются, только когда снята последняя
 * причина.  BF пользуется причиной 3, расписание — своей причиной 8, так
 * что гонки с запретом на время BF нет.  Мгновенные ответы (ACK, BA,
 * DMG CTS) идут мимо очередей — роль назначения в SP сохраняется.
 */
#include "uc.h"
#include "fw_uc_shared.h"

#define g_ese_dti          (*(volatile struct ese_dti_state *)UC_EXT_DATA_UC(ESE_DTI_OFS))
#define g_uc_role_pcp      UC_GLOBAL(u32, 0x008014c0)
#define g_dti_qset_mode    UC_GLOBAL(u32, 0x008004f4)   /* вендорский TDMA */
/* Заголовок таблицы аллокаций ESE (общий блок): is_in_slot. */
#define g_ese_in_slot      UC_GLOBAL(u8, 0x00857266)
/* Scratchpad записи массива SP, окно которой сейчас идёт. */
#define g_sp_cur_scratch   UC_GLOBAL(u32, 0x00886f8c)
#define g_sta_pause(cid)   UC_GLOBAL(u16, 0x00802a90 + 2 * (cid))
#define g_sta_flags(cid)   UC_GLOBAL(u16, 0x00801104 + 0x50 * (cid) + 2)

enum {
	PAUSE_REASON_ESE   = 8,
	CID_COUNT          = 8,
	STA_VALID          = 0x1,
	SLOT_MAY_INITIATE  = 0x80,      /* бит 7 scratchpad записи */
};

extern "C" {
void bf__pause_sta_tx(u32 reason, u32 cid);
void bf__resume_sta_tx(u32 reason, u32 cid);
}

static bool ese_dti__scheduled(void)
{
	u32 f = g_ese_dti.flags;

	return (f & ESE_DTI_VALID_MASK) == ESE_DTI_VALID &&
	       (f & ESE_DTI_SCHEDULED) &&
	       g_uc_role_pcp != 1 && !g_dti_qset_mode;
}

static void ese_dti__close(void)
{
	bool any = false;

	for (u32 cid = 0; cid < CID_COUNT; cid++) {
		if (!(g_sta_flags(cid) & STA_VALID) ||
		    (g_sta_pause(cid) & (1u << PAUSE_REASON_ESE)))
			continue;
		bf__pause_sta_tx(PAUSE_REASON_ESE, cid);
		any = true;
	}
	if (any)
		g_ese_dti.closed = g_ese_dti.closed + 1;
}

static void ese_dti__open(void)
{
	bool any = false;

	for (u32 cid = 0; cid < CID_COUNT; cid++) {
		if (!(g_sta_pause(cid) & (1u << PAUSE_REASON_ESE)))
			continue;
		bf__resume_sta_tx(PAUSE_REASON_ESE, cid);
		any = true;
	}
	if (any)
		g_ese_dti.opened = g_ese_dti.opened + 1;
}

/* Начало DTI (bi__dti_step): закрыть, если сейчас не идёт разрешённое окно. */
extern "C" void ese_dti__dti_start(void)
{
	if (!ese_dti__scheduled()) {
		ese_dti__open();
		return;
	}
	if (!g_ese_in_slot || !(g_sp_cur_scratch & SLOT_MAY_INITIATE))
		ese_dti__close();
}

/* Начало окна: scratch — scratchpad записи (r16 dti_worker). */
extern "C" void ese_dti__slot_start(u32 scratch)
{
	if (ese_dti__scheduled() && (scratch & SLOT_MAY_INITIATE))
		ese_dti__open();
}

/* Конец окна. */
extern "C" void ese_dti__slot_end(void)
{
	if (ese_dti__scheduled())
		ese_dti__close();
}

/* Входы из dti_worker__scheduled_dti_allocation_event (патч 0019): вызовы
 * строк «starting slot» (uc_log__emit2) и «closing slot» (uc_log__emit1)
 * переведены сюда; строка печатается как раньше, затем открытие или
 * закрытие.  r16 вызывающего — scratchpad записи.
 *
 * Событие окна (SCHEDULED_DTI_ALLOC) dti_worker собирает на своём стеке:
 * +2 — вектор CID пира окна, +4 — маска.  Прошивка по нему разрешает
 * кольца передачи хоста только этим CID, остальным запрещает
 * (ps_assoc_mgr__shallow_sleep_enter → vring_schd prohibit/allow); конец
 * окна идёт с пустым вектором — «запретить всех».  После снятия
 * расписания (num_of_allocations = 0) последним приходит конец окна, и
 * запрет в 6.2 оставался навсегда: передача вставала у точки и у станции.
 * Поэтому при пустой таблице конец окна несёт вектор «все CID». */
__asm__(
	"	.section .text.ese_dti_entries,\"ax\",@progbits\n"
	"	.p2align 2\n"
	"	.global ese_dti__slot_start_log\n"
	"ese_dti__slot_start_log:\n"
	"	push_s blink\n"
	"	bl uc_log__emit2\n"
	"	bl.d ese_dti__slot_start\n"
	"	mov_s r0,r16\n"
	"	pop_s blink\n"
	"	j_s [blink]\n"
	"	.global ese_dti__slot_end_log\n"
	"ese_dti__slot_end_log:\n"
	"	ldb r12,[0x857265]\n"		/* num_of_allocations */
	"	brne r12,0,1f\n"
	"	mov r12,0xff\n"
	"	stb r12,[sp,2]\n"			/* вектор CID события */
	"1:\n"
	"	push_s blink\n"
	"	bl uc_log__emit1\n"
	"	bl ese_dti__slot_end\n"
	"	pop_s blink\n"
	"	j_s [blink]\n");
