/* key__install_by_type @ 0x8d4104, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: set_gtk, set_tk
 * Зовёт сам: add_key
 */
	.section .text.key__install_by_type,"ax",@progbits
	.global key__install_by_type
key__install_by_type:
	.global L_8d4104
L_8d4104:
	push_s blink
L_8d4106:
	breq_s r2,0,L_8d4114
L_8d4108:
	brne r2,0x1,L_8d411e
L_8d410c:
	bmsk_s r1,r1,0x0
L_8d410e:
	add1_s r1,r1,r3
L_8d4110:
	add_s r1,r1,0x10
L_8d4112:
	b_s L_8d4118
	.global L_8d4114
L_8d4114:
	bmsk_s r1,r1,0x0
L_8d4116:
	add1_s r1,r1,r3
	.global L_8d4118
L_8d4118:
	bl.d L_8ce17c
L_8d411c:
	extb_s r1,r1
	.global L_8d411e
L_8d411e:
	pop_s blink
L_8d4120:
	j_s [blink]
L_8d4122:
	nop_s
