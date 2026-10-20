/* conn_mgr__ranking_remove @ 0x8c8b8c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Removed index CID %d from ranking list.
 * Зовут его: conn_mgr__link_up_evt, tail_conn_mgr__ranking_remove
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, iter__has_more, iter__init, iter__next, llist__remove, mem_pool__free
 */
	.section .text.conn_mgr__ranking_remove,"ax",@progbits
	.global conn_mgr__ranking_remove
conn_mgr__ranking_remove:
	.global L_8c8b8c
L_8c8b8c:
	push_s blink
L_8c8b8e:
	bl L_8c02bc
L_8c8b92:
	sub_s sp,sp,0x4
L_8c8b94:
	mov_s r15,r0
L_8c8b96:
	mov_s r13,sp
L_8c8b98:
	mov r16,0x80461c
L_8c8ba0:
	mov_s r0,r13
L_8c8ba2:
	bl.d L_8e1138
L_8c8ba6:
	mov_s r1,r16
L_8c8ba8:
	b_s L_8c8bb8
	.global L_8c8baa
L_8c8baa:
	bl.d L_8db188
L_8c8bae:
	mov_s r0,r13
L_8c8bb0:
	mov_s r14,r0
L_8c8bb2:
	ld_s r0,[r0,0x8]
L_8c8bb4:
	breq r15,r0,L_8c8bc4
	.global L_8c8bb8
L_8c8bb8:
	bl.d L_8cb674
L_8c8bbc:
	mov_s r0,r13
L_8c8bbe:
	brne_s r0,0,L_8c8baa
L_8c8bc0:
	mov_s r0,0x0
L_8c8bc2:
	b_s L_8c8bec
	.global L_8c8bc4
L_8c8bc4:
	mov_s r0,r16
L_8c8bc6:
	bl.d L_8de4ec
L_8c8bca:
	mov_s r1,r14
L_8c8bcc:
	mov_s r0,0x0
L_8c8bce:
	st_s r0,[r14,0x8]
L_8c8bd0:
	add2 r0,r16,0x1b
L_8c8bd4:
	bl.d L_8c9268
L_8c8bd8:
	mov_s r1,r14
L_8c8bda:
	mov_s r2,0x100a9c4
L_8c8be0:
	mov_s r0,0xb
L_8c8be2:
	mov_s r1,0x2
L_8c8be4:
	bl.d L_8edfcc
L_8c8be8:
	ldb_s r3,[r15,0x8]
L_8c8bea:
	mov_s r0,0x1
	.global L_8c8bec
L_8c8bec:
	b.d L_8c0324
L_8c8bf0:
	add_s sp,sp,0x4
L_8c8bf2:
	nop_s
