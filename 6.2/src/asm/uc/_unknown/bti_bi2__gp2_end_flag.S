/* bti_bi2__gp2_end_flag @ 0x923ca8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_transmitter_bi2_flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti_bi2__gp2_end_flag
bti_bi2__gp2_end_flag:
	.global L_923ca8
L_923ca8:
	and r0,r54,0x100
L_923cb0:
	j_s [blink]
L_923cb2:
	nop_s
