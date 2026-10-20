/* conn_mgr__allocate_cid_db_element @ 0x8c2f84, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::allocate_cid_db_element() CID %d::::: 0x%x status %d.
 *   No free CID resource found.
 * Зовут его: conn_mgr__activate_conn
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit3
 */
	.section .text.conn_mgr__allocate_cid_db_element,"ax",@progbits
	.global conn_mgr__allocate_cid_db_element
conn_mgr__allocate_cid_db_element:
	.global L_8c2f84
L_8c2f84:
	push_s blink
L_8c2f86:
	bl.d L_8c02c4
L_8c2f8a:
	mov_s r3,0x0
L_8c2f8c:
	b_s L_8c2f90
	.global L_8c2f8e
L_8c2f8e:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_8c2f90
L_8c2f90:
	brhs.d r3,0x8,L_8c2fce
L_8c2f94:
	st_s r3,[r1]
L_8c2f96:
	mov_s r14,0x80469c
L_8c2f9c:
	add3 r13,r14,r3
L_8c2fa0:
	ld_s r2,[r13]
L_8c2fa2:
	brne_s r2,0,L_8c2f8e
L_8c2fa4:
	st_s r0,[r13,0x4]
L_8c2fa6:
	ld_s r2,[r1]
L_8c2fa8:
	mov_s r13,0x1
L_8c2faa:
	add3 r0,r14,r2
L_8c2fae:
	st_s r13,[r0]
L_8c2fb0:
	ld_s r3,[r1]
L_8c2fb2:
	mov_s r2,0x100a8ec
L_8c2fb8:
	add3_s r14,r14,r3
L_8c2fba:
	ld r4,[r14, 0x4]
L_8c2fbe:
	mov_s r0,0xb
L_8c2fc0:
	ld r5,[r14]
L_8c2fc4:
	bl.d L_8ee034
L_8c2fc8:
	mov_s r1,0x2
L_8c2fca:
	mov_s r0,r13
L_8c2fcc:
	b_s L_8c2fde
	.global L_8c2fce
L_8c2fce:
	mov_s r2,0x100a92c
L_8c2fd4:
	mov_s r0,0xb
L_8c2fd6:
	bl.d L_8edfb0
L_8c2fda:
	mov_s r1,0x1
L_8c2fdc:
	mov_s r0,0x0
	.global L_8c2fde
L_8c2fde:
	b L_8c0334
L_8c2fe2:
	nop_s
