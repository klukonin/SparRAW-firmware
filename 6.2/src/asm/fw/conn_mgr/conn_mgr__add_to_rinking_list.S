/* conn_mgr__add_to_rinking_list @ 0x8c2d78, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::add_to_rinking_list() ADD index CID %d to ranking list.
 * Зовут его: conn_mgr__activate_conn, conn_mgr__link_up_evt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn_mgr__find_in_ranking_list_fw, fw_log_emit1, fw_sysassert_fatal, list__find_entry_d, mem_pool__allocate
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__add_to_rinking_list
conn_mgr__add_to_rinking_list:
	.global L_8c2d78
L_8c2d78:
	push_s blink
L_8c2d7a:
	bl L_8c01e0
L_8c2d7e:
	bl.d L_8da308
L_8c2d82:
	mov_s r13,r0
L_8c2d84:
	brne_s r0,0,L_8c2db2
L_8c2d86:
	mov_s r15,0x854000
L_8c2d8c:
	bl.d L_8c354c
L_8c2d90:
	add2 r0,r15,0x1b
L_8c2d94:
	mov.f r14,r0
L_8c2d98:
	beq_s L_8c2db6
	.global L_8c2d9a
L_8c2d9a:
	st_s r13,[r14,0x8]
L_8c2d9c:
	mov_s r0,r15
L_8c2d9e:
	bl.d L_8c25f4
L_8c2da2:
	mov_s r1,r14
L_8c2da4:
	mov_s r1,0x100bdec
L_8c2daa:
	mov_s r0,0x2b
L_8c2dac:
	bl.d L_8dcc10
L_8c2db0:
	ldb_s r2,[r13,0x8]
	.global L_8c2db2
L_8c2db2:
	b L_8c024c
	.global L_8c2db6
L_8c2db6:
	mov_s r0,blink
L_8c2db8:
	mov_s r1,0x11cc
L_8c2dbe:
	bl L_8c9b28
L_8c2dc2:
	b_s L_8c2d9a
