/* conn_mgr__link_down_evt @ 0x8d79cc, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::link_down_evt()
 * Зовут его: conn_mgr__find_reusable_cid, conn_mgr__link_up_evt, l2mgr__disconnect_done, scan_mngr__clean_all_lists, scan_mngr__prob_done
 * Зовёт сам: __ld_r13_ret, conn__abort, conn_mgr__free_cid_db_element, fw_log__emit0
 */
	.section .text.conn_mgr__link_down_evt,"ax",@progbits
	.global conn_mgr__link_down_evt
conn_mgr__link_down_evt:
	.global L_8d79cc
L_8d79cc:
	push_s blink
L_8d79ce:
	push_s r13
L_8d79d0:
	mov_s r13,r0
L_8d79d2:
	mov_s r2,0x100a888
L_8d79d8:
	mov_s r0,0xb
L_8d79da:
	bl.d L_8edfb0
L_8d79de:
	mov_s r1,0x2
L_8d79e0:
	mov_s r0,r13
L_8d79e2:
	bl.d L_8e8dbc
L_8d79e6:
	mov_s r1,0x0
L_8d79e8:
	bl.d L_8c9304
L_8d79ec:
	ldb_s r0,[r13,0x8]
L_8d79ee:
	.byte 0x51,0x01
