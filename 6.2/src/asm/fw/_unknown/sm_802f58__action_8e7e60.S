/* sm_802f58__action_8e7e60 @ 0x8e7e60, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, led_scheme__apply, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_802f58__action_8e7e60
sm_802f58__action_8e7e60:
	.global L_8e7e60
L_8e7e60:
	push_s blink
L_8e7e62:
	push_s r13
L_8e7e64:
	mov_s r13,r0
L_8e7e66:
	mov_s r0,0x1
L_8e7e68:
	stb_s r0,[r13,0x3]
L_8e7e6a:
	ld_s r0,[r13,0x8]
L_8e7e6c:
	breq_s r0,0,L_8e7e76
L_8e7e6e:
	bl L_8c8de0
L_8e7e72:
	mov_s r0,0x0
L_8e7e74:
	st_s r0,[r13,0x8]
	.global L_8e7e76
L_8e7e76:
	ld_s r0,[r13,0xc]
L_8e7e78:
	breq_s r0,0,L_8e7e82
L_8e7e7a:
	bl L_8c8de0
L_8e7e7e:
	mov_s r0,0x0
L_8e7e80:
	st_s r0,[r13,0xc]
	.global L_8e7e82
L_8e7e82:
	bl.d L_8da84c
L_8e7e86:
	mov_s r0,0x4
L_8e7e88:
	b L_8c025c
