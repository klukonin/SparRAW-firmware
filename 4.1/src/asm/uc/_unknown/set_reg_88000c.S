/* set_reg_88000c @ 0x92792c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_main_init
 */
	.section .text.set_reg_88000c,"ax",@progbits
	.global set_reg_88000c
set_reg_88000c:
	.global L_92792c
L_92792c:
	st r0,[0x88000c]
L_927934:
	j_s [blink]
L_927936:
	nop_s
