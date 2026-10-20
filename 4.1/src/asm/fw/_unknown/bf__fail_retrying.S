/* bf__fail_retrying @ 0x8c3f80, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BF_FAIL_RETRYING release_radio_after_bf_evt. failed_bf_cnt=%d
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, maintain_sm__release_radio_after_bf_evt, schedule_long_term_trigger
 */
	.section .text.bf__fail_retrying,"ax",@progbits
	.global bf__fail_retrying
bf__fail_retrying:
L_8c3f80:
	push_s blink
L_8c3f82:
	bl L_8c02c0
L_8c3f86:
	mov_s r14,r0
L_8c3f88:
	mov_s r15,r1
L_8c3f8a:
	bl.d L_8de158
L_8c3f8e:
	mov_s r13,0x0
L_8c3f90:
	ld_s r0,[r15,0xc]
L_8c3f92:
	add3 r1,r14,0x10
L_8c3f96:
	brne r0,0x2,L_8c3fb0
L_8c3f9a:
	ld_s r3,[r1,0x3c]
L_8c3f9c:
	mov_s r2,0x1011e68
L_8c3fa2:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8c3fa4:
	st_s r3,[r1,0x3c]
L_8c3fa6:
	mov_s r0,r13
L_8c3fa8:
	bl.d L_8edfcc
L_8c3fac:
	mov_s r1,0x2
L_8c3fae:
	b_s L_8c3fd6
	.global L_8c3fb0
L_8c3fb0:
	brne r0,0x1,L_8c3fbe
L_8c3fb4:
	ld_s r0,[r1,0x38]
L_8c3fb6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c3fb8:
	st_s r0,[r1,0x38]
L_8c3fba:
	st_s r13,[r1,0x40]
L_8c3fbc:
	b_s L_8c3fd6
	.global L_8c3fbe
L_8c3fbe:
	ld_s r0,[r1,0x3c]
L_8c3fc0:
	stb r13,[r14, 0x3d]
L_8c3fc4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c3fc6:
	ld_s r2,[r1,0x40]
L_8c3fc8:
	st_s r0,[r1,0x3c]
L_8c3fca:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8c3fcc:
	st_s r2,[r1,0x40]
L_8c3fce:
	mov_s r0,r14
L_8c3fd0:
	bl.d L_8dfa80
L_8c3fd4:
	mov_s r1,r13
	.global L_8c3fd6
L_8c3fd6:
	b L_8c032c
L_8c3fda:
	nop_s
