/* conn_mgr__link_down_evt @ 0x8daae8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::link_down_evt()
 * Зовут его: conn_mgr__find_reusable_cid, conn_mgr__link_up_evt, mlme_sm__disconnect_ev_handle, scan_mngr__clean_all_lists, scan_mngr__prob_done
 * Зовёт сам: __ld_r13_to_r13_ret, conn__abort, conn_mgr__free_cid_db_element, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__link_down_evt
conn_mgr__link_down_evt:
	.global L_8daae8
L_8daae8:
	push_s blink
L_8daaea:
	push_s r13
L_8daaec:
	mov_s r13,r0
L_8daaee:
	mov_s r1,0x100bd2c
L_8daaf4:
	bl.d L_8dcba8
L_8daaf8:
	mov_s r0,0x2b
L_8daafa:
	mov_s r0,r13
L_8daafc:
	bl.d L_8f0444
L_8dab00:
	mov_s r1,0x0
L_8dab02:
	bl.d L_8caf54
L_8dab06:
	ldb_s r0,[r13,0x8]
L_8dab08:
	b L_8c025c
