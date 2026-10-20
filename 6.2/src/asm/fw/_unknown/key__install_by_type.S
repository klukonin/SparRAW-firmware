/* key__install_by_type @ 0x8d6e68, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: set_gtk, set_tk
 * Зовёт сам: add_key
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global key__install_by_type
key__install_by_type:
	.global L_8d6e68
L_8d6e68:
	push_s blink
L_8d6e6a:
	breq_s r2,0,L_8d6e78
L_8d6e6c:
	brne r2,0x1,L_8d6e82
L_8d6e70:
	bmsk_s r1,r1,0x0
L_8d6e72:
	add1_s r1,r1,r3
L_8d6e74:
	add_s r1,r1,0x10
L_8d6e76:
	b_s L_8d6e7c
	.global L_8d6e78
L_8d6e78:
	bmsk_s r1,r1,0x0
L_8d6e7a:
	add1_s r1,r1,r3
	.global L_8d6e7c
L_8d6e7c:
	bl.d L_8d0edc
L_8d6e80:
	extb_s r1,r1
	.global L_8d6e82
L_8d6e82:
	pop_s blink
L_8d6e84:
	j_s [blink]
L_8d6e86:
	nop_s
