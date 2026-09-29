/* sorted_llist__unlink @ 0x8c1f70, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   llist.cpp
 * Зовут его: sorted_llist__insert
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.sorted_llist__unlink,"ax",@progbits
	.global sorted_llist__unlink
sorted_llist__unlink:
	.global L_8c1f70
L_8c1f70:
	push_s blink
L_8c1f72:
	bl L_8c02c4
L_8c1f76:
	mov.f r13,r1
L_8c1f7a:
	mov_s r14,r0
L_8c1f7c:
	beq_s L_8c1f8a
	.global L_8c1f7e
L_8c1f7e:
	ld_s r0,[r13,0x4]
L_8c1f80:
	brne_s r0,0,L_8c1f9c
	.global L_8c1f82
L_8c1f82:
	ld_s r0,[r14]
L_8c1f84:
	breq_s r0,0,L_8c1fae
L_8c1f86:
	ld_s r0,[r14,0x4]
L_8c1f88:
	b_s L_8c1fb2
	.global L_8c1f8a
L_8c1f8a:
	mov_s r0,blink
L_8c1f8c:
	mov_s r2,0x1001de0
L_8c1f92:
	mov_s r1,0xd1
L_8c1f94:
	bl.d L_8c82c0
L_8c1f98:
	mov_s r3,0x13
L_8c1f9a:
	b_s L_8c1f7e
	.global L_8c1f9c
L_8c1f9c:
	mov_s r0,blink
L_8c1f9e:
	mov_s r2,0x1001de0
L_8c1fa4:
	mov_s r1,0xd2
L_8c1fa6:
	bl.d L_8c82c0
L_8c1faa:
	mov_s r3,0x14
L_8c1fac:
	b_s L_8c1f82
	.global L_8c1fae
L_8c1fae:
	st_s r13,[r14,0x8]
L_8c1fb0:
	mov_s r0,0x0
	.global L_8c1fb2
L_8c1fb2:
	st_s r0,[r13]
L_8c1fb4:
	ld_s r0,[r14]
L_8c1fb6:
	st_s r13,[r14,0x4]
L_8c1fb8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c1fba:
	st_s r0,[r14]
L_8c1fbc:
	b.d L_8c0334
L_8c1fc0:
	st_s r14,[r13,0x4]
L_8c1fc2:
	nop_s
