/* ba_sm__action_8e2a30 @ 0x8e2a30, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__action_8e2a30
ba_sm__action_8e2a30:
	.global L_8e2a30
L_8e2a30:
	push_s blink
L_8e2a32:
	push_s r13
L_8e2a34:
	mov_s r13,r0
L_8e2a36:
	mov_s r2,r1
L_8e2a38:
	add_s r0,r0,0x2c
L_8e2a3a:
	mov_s r1,0x3
L_8e2a3c:
	mov_s r3,0x0
L_8e2a3e:
	bl.d L_8d9b6c
L_8e2a42:
	mov_s r4,r3
L_8e2a44:
	ld_s r0,[r13,0x40]
L_8e2a46:
	ld_s r1,[r0,0x68]
L_8e2a48:
	ld_s r1,[r1,0x8]
L_8e2a4a:
	jl_s [r1]
L_8e2a4c:
	b L_8c025c
