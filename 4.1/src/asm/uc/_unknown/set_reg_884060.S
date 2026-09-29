/* set_reg_884060 @ 0x9274f0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode_program_a, mac_mode_program_b
 */
	.section .text.set_reg_884060,"ax",@progbits
	.global set_reg_884060
set_reg_884060:
	.global L_9274f0
L_9274f0:
	st r0,[0x884060]
L_9274f8:
	j_s [blink]
L_9274fa:
	nop_s
