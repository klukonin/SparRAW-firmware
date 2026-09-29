/* sm_pring__get_vring @ 0x8c4d20, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schdlr.cpp
 * Зовут его: vring_schd__move_to_ready
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.sm_pring__get_vring,"ax",@progbits
	.global sm_pring__get_vring
sm_pring__get_vring:
	.global L_8c4d20
L_8c4d20:
	push_s blink
L_8c4d22:
	bl.d L_8c02c4
L_8c4d26:
	mul64 r1,0x38
L_8c4d2a:
	add_s r0,r0,0x24
L_8c4d2c:
	add r13,r0,mlo
L_8c4d30:
	ld_s r0,[r13,0x14]
L_8c4d32:
	mov_s r14,r1
L_8c4d34:
	breq_s r0,0,L_8c4d40
L_8c4d36:
	breq r14,0x1,L_8c4d46
	.global L_8c4d3a
L_8c4d3a:
	ld_s r0,[r13,0x14]
L_8c4d3c:
	ldb_s r0,[r0,0xb]
L_8c4d3e:
	brne_s r0,0,L_8c4d5e
	.global L_8c4d40
L_8c4d40:
	b.d L_8c0334
L_8c4d44:
	mov_s r0,r13
	.global L_8c4d46
L_8c4d46:
	mov_s r0,blink
L_8c4d48:
	mov_s r2,0x100a584
L_8c4d4e:
	mov_s r1,0x140b
L_8c4d54:
	bl.d L_8c82c0
L_8c4d58:
	mov r3,0x331
L_8c4d5c:
	b_s L_8c4d3a
	.global L_8c4d5e
L_8c4d5e:
	brne r14,0x1,L_8c4d40
L_8c4d62:
	mov_s r0,blink
L_8c4d64:
	mov_s r2,0x100a584
L_8c4d6a:
	mov_s r1,0x140c
L_8c4d70:
	bl.d L_8c82c0
L_8c4d74:
	mov r3,0x33a
