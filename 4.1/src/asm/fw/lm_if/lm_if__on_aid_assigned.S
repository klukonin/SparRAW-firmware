/* lm_if__on_aid_assigned @ 0x8d9c18, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_if.cpp
 * Зовут его: pcp_ap__set_aid
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_sysassert_fatal, get_reg_880a3c_8d7210, u_schd__add
 */
	.section .text.lm_if__on_aid_assigned,"ax",@progbits
	.global lm_if__on_aid_assigned
lm_if__on_aid_assigned:
	.global L_8d9c18
L_8d9c18:
	push_s blink
L_8d9c1a:
	push_s r13
L_8d9c1c:
	bl.d L_8d7210
L_8d9c20:
	mov_s r13,r0
L_8d9c22:
	breq_s r0,0,L_8d9c36
L_8d9c24:
	mov_s r0,0x921c
L_8d9c2a:
	ld_s r1,[r13,0x4]
L_8d9c2c:
	mov_s r2,0x0
L_8d9c2e:
	bl.d L_8c2ac8
L_8d9c32:
	mov_s r3,0x1
L_8d9c34:
	b_s L_8d9c48
	.global L_8d9c36
L_8d9c36:
	ld_s r0,[r13]
L_8d9c38:
	breq_s r0,0,L_8d9c4c
	.global L_8d9c3a
L_8d9c3a:
	ld_s r0,[r13]
L_8d9c3c:
	mov_s r1,0x5
L_8d9c3e:
	mov_s r2,0x0
L_8d9c40:
	mov_s r3,r2
L_8d9c42:
	bl.d L_8d6a1c
L_8d9c46:
	mov_s r4,r2
	.global L_8d9c48
L_8d9c48:
	b L_8c033c
	.global L_8d9c4c
L_8d9c4c:
	mov_s r0,blink
L_8d9c4e:
	mov_s r2,0x1010e10
L_8d9c54:
	mov_s r1,0x93
L_8d9c56:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8d9c58:
	bl.d L_8c82c0
L_8d9c5c:
	mov_s r3,0x91
L_8d9c5e:
	b_s L_8d9c3a
