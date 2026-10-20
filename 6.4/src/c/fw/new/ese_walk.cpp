// SPDX-License-Identifier: AGPL-3.0-or-later
/* ESE: закладка окон SP только из непустой таблицы (6.4; исправление 6.2,
 * патч 0020).  Отдельно от ese_rx.cpp: исправление нужно и там, где разбора
 * ESE по 10.39 (патчи 0018/0019) нет.
 */
#include "fw.h"

/* Закладка записей в аппаратный массив SP (lmac_if__evt_walk) только из
 * непустой таблицы.  Снятие расписания обнуляет num_of_allocations, но
 * ucode продолжает просить подложить записи (событие 0x29), и
 * lmac_if__evt_walk закладывал 4 нулевые записи: без бита 7 они идут с
 * start/end_mask_ind — аппаратной маской передачи на время SP, — и так
 * без конца.  После снятия ESE точкой передача вставала у обоих узлов.
 * Пустой может быть и таблица станции, если все окна точки чужие.
 * Патч 0020: все три вызова lmac_if__evt_walk идут сюда. */
extern "C" void lmac_if__evt_walk(void *scheme);

/* [схема] — курсор {u8 индекс; ...; +4 таблица}, таблица — заголовок
 * {scheme_state, num_of_allocations, is_in_slot, cur_slot_idx} и записи
 * (lmac_evt__entry_end, sched_builder__reset_alloc_list). */
enum { ALLOC_HDR_NUM = 1 };

extern "C" void ese__evt_walk_if_any(void *scheme)
{
	const u8 *cursor = *(const u8 *const *)scheme;
	const u8 *hdr = *(const u8 *const *)(cursor + 4);

	if (hdr[ALLOC_HDR_NUM])
		lmac_if__evt_walk(scheme);
}
