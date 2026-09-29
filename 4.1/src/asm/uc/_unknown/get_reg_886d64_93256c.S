/* get_reg_886d64_93256c @ 0x93256c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__compute_next_tbtt, aw__set_new_tbtt, calc_awake_tsf
 */
	.section .text.get_reg_886d64_93256c,"ax",@progbits
	.global get_reg_886d64_93256c
get_reg_886d64_93256c:
	.global L_93256c
L_93256c:
	ld r0,[0x886d64]
L_932574:
	j.d [blink]
L_932578:
	extw_s r0,r0
L_93257a:
	nop_s
