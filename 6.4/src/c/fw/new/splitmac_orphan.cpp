// SPDX-License-Identifier: AGPL-3.0-or-later
/* Split MAC точки (6.4; исправление 6.2, патч 0017): завершение SW TX для
 * кадра хоста без соединения.  Отдельно от splitmac.cpp (переассоциация).
 */

/* Кадр от хоста для станции без соединения.  Первым же кадром после
 * WMI_PCP_STARTED hostapd шлёт широковещательный Disassociation
 * (ff:ff:ff:ff:ff:ff), соединения под этот адрес нет, и
 * handle_packet_splitmac выходил после строки «CONN OBJ is NULL» молча:
 * хост не получал WMI_SW_TX_COMPLETE (драйвер ждал 2 с под wmi_mutex,
 * hostapd стоял) и копия кадра из пула не возвращалась.  Патч 0017
 * переводит на вставку вызов этой строки (0x8f3bd6, задержка-слот
 * остаётся на месте): она пишет ту же строку, сообщает хосту неудачу
 * отправки (статус 1, как отказ по длине в wmi_sw_tx_req) и освобождает
 * кадр.  У handle_packet_splitmac r13 = кадр, r19 = MID; оба сохраняются
 * через вызовы по соглашению ARC.
 */
__asm__(
	"	.section .text.splitmac_no_conn,\"ax\",@progbits\n"
	"	.p2align 2\n"
	"	.global splitmac__no_conn\n"
	"splitmac__no_conn:\n"
	"	push_s blink\n"
	"	bl L_8dcc80\n"		/* строка «CONN OBJ is NULL» */
	"	mov_s r0,1\n"
	"	bl.d L_8f8e50\n"		/* l2mgr__send_sw_tx_complete(1, mid) */
	"	mov r1,r19\n"
	"	bl.d TX_API__free_memory\n"
	"	mov_s r0,r13\n"
	"	pop_s blink\n"
	"	j_s [blink]\n");
