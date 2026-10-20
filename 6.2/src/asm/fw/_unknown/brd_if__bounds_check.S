/* brd_if__bounds_check @ 0x8e2188, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if__parse_chunk_header
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if__bounds_check
brd_if__bounds_check:
	.global L_8e2188
L_8e2188:
	push_s blink
L_8e218a:
	bl.d L_8c01e0
L_8e218e:
	mov_s r0,r5
L_8e2190:
	ld_s r14,[r0]
L_8e2192:
	brlo.d r2,r14,L_8e21c0
L_8e2196:
	mov_s r13,r4
L_8e2198:
	ld_s r14,[r0,0x4]
L_8e219a:
	brlo r14,r2,L_8e21c0
L_8e219e:
	ldw_s r14,[r0,0x12]
L_8e21a0:
	ldw_s r15,[r0,0x10]
L_8e21a2:
	brge r14,r15,L_8e21c0
L_8e21a6:
	ld_s r15,[r0,0x8]
L_8e21a8:
	breq_s r15,0,L_8e21b2
L_8e21aa:
	add3_s r15,r15,r14
L_8e21ac:
	st_s r2,[r15]
L_8e21ae:
	st_s r3,[r15,0x4]
L_8e21b0:
	b_s L_8e21ba
	.global L_8e21b2
L_8e21b2:
	ld_s r2,[r0,0xc]
L_8e21b4:
	brne_s r2,0,L_8e21ba
L_8e21b6:
	st_s r1,[r0,0xc]
L_8e21b8:
	st_s r13,[r0,0x14]
	.global L_8e21ba
L_8e21ba:
	ldw_s r1,[r0,0x12]
L_8e21bc:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e21be:
	stw_s r1,[r0,0x12]
	.global L_8e21c0
L_8e21c0:
	b L_8c024c
