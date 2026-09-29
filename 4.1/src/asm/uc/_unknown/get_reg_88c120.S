/* get_reg_88c120 @ 0x926ce8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager_rx_step
 */
	.section .text.get_reg_88c120,"ax",@progbits
	.global get_reg_88c120
get_reg_88c120:
	.global L_926ce8
L_926ce8:
	ld r0,[0x88c120]
L_926cf0:
	j.d [blink]
L_926cf4:
	bmsk_s r0,r0,0x17
L_926cf6:
	nop_s
