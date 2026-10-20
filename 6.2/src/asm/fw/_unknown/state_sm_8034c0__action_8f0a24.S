/* state_sm_8034c0__action_8f0a24 @ 0x8f0a24, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, ftm__ctx_addr, state_sm_8034c0__action_step, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_8034c0__action_8f0a24
state_sm_8034c0__action_8f0a24:
	.global L_8f0a24
L_8f0a24:
	push_s blink
L_8f0a26:
	push_s r13
L_8f0a28:
	mov_s r13,r0
L_8f0a2a:
	ld_s r0,[r0,0x10]
L_8f0a2c:
	breq_s r0,0,L_8f0a36
L_8f0a2e:
	bl L_8c8de0
L_8f0a32:
	mov_s r0,0x0
L_8f0a34:
	st_s r0,[r13,0x10]
	.global L_8f0a36
L_8f0a36:
	bl L_8ccf04
L_8f0a3a:
	bl.d L_8cb5a4
L_8f0a3e:
	ld_s r1,[r13,0x20]
L_8f0a40:
	b L_8c025c
