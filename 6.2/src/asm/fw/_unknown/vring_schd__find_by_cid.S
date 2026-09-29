/* vring_schd__find_by_cid @ 0x8ebebc, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_schd__stop_vring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schd__find_by_cid
vring_schd__find_by_cid:
	.global L_8ebebc
L_8ebebc:
	push_s blink
L_8ebebe:
	bl.d L_8c01e0
L_8ebec2:
	mov_s r4,r1
L_8ebec4:
	mov_s r13,0x0
L_8ebec6:
	st_s r13,[r3]
L_8ebec8:
	st_s r13,[r2]
L_8ebeca:
	ld r1,[r0, 0xa0]
L_8ebece:
	brlo r1,0x1,L_8ebef0
	.global L_8ebed2
L_8ebed2:
	mul64 r13,0x3c
L_8ebed6:
	add r1,r0,0x28
L_8ebeda:
	add_s r1,r1,mlo
L_8ebedc:
	ld_s r15,[r1,0x14]
L_8ebede:
	breq_s r15,0,L_8ebee6
L_8ebee0:
	ldb_s r14,[r15,0x9]
L_8ebee2:
	breq r14,r4,L_8ebef4
	.global L_8ebee6
L_8ebee6:
	ld r1,[r0, 0xa0]
L_8ebeea:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8ebeec:
	brlo r13,r1,L_8ebed2
	.global L_8ebef0
L_8ebef0:
	mov_s r0,0x0
L_8ebef2:
	b_s L_8ebefa
	.global L_8ebef4
L_8ebef4:
	st_s r1,[r3]
L_8ebef6:
	st_s r15,[r2]
L_8ebef8:
	mov_s r0,0x1
	.global L_8ebefa
L_8ebefa:
	b L_8c024c
L_8ebefe:
	nop_s
