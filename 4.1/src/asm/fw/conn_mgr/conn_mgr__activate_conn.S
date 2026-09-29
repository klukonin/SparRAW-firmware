/* conn_mgr__activate_conn @ 0x8c1df0, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr.cpp
 *   conn_mgr::activate_conn() LINKUP for CID %d starting.
 * Зовут его: mid__add_connection, mid__link_acquisition_action, scan_mngr__prob_done
 * Зовёт сам: __ld_r13_ret, conn__bind_cid_to_lm, conn_mgr__add_to_rinking_list, conn_mgr__allocate_cid_db_element, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.conn_mgr__activate_conn,"ax",@progbits
	.global conn_mgr__activate_conn
conn_mgr__activate_conn:
	.global L_8c1df0
L_8c1df0:
	push_s blink
L_8c1df2:
	push_s r13
L_8c1df4:
	sub_s sp,sp,0x4
L_8c1df6:
	mov_s r13,r0
L_8c1df8:
	brne r1,0x1,L_8c1e1a
L_8c1dfc:
	bl.d L_8c2f84
L_8c1e00:
	mov_s r1,sp
L_8c1e02:
	brne_s r0,0,L_8c1e1e
L_8c1e04:
	mov_s r0,blink
L_8c1e06:
	mov_s r2,0x100a878
L_8c1e0c:
	mov_s r1,0x11cb
L_8c1e12:
	bl.d L_8c82c0
L_8c1e16:
	mov_s r3,0x45
L_8c1e18:
	b_s L_8c1e1e
	.global L_8c1e1a
L_8c1e1a:
	ldb_s r0,[r13,0x8]
L_8c1e1c:
	st_s r0,[sp,0x0]
	.global L_8c1e1e
L_8c1e1e:
	mov_s r2,0x100a98c
L_8c1e24:
	mov_s r0,0xb
L_8c1e26:
	mov_s r1,0x2
L_8c1e28:
	bl.d L_8edfcc
L_8c1e2c:
	ld_s r3,[sp,0x0]
L_8c1e2e:
	bl.d L_8c25e4
L_8c1e32:
	mov_s r0,r13
L_8c1e34:
	mov_s r0,r13
L_8c1e36:
	bl.d L_8f1358
L_8c1e3a:
	ld_s r1,[sp,0x0]
L_8c1e3c:
	ld_s r0,[sp,0x0]
L_8c1e3e:
	b.d L_8c033c
L_8c1e42:
	add_s sp,sp,0x4
