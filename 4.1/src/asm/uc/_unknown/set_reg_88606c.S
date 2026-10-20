/* set_reg_88606c @ 0x926cf8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: cf_end_mtp_step, tx_rate_select_and_program
 */
	.section .text.set_reg_88606c,"ax",@progbits
	.global set_reg_88606c
set_reg_88606c:
	.global L_926cf8
L_926cf8:
	mov r0,0x102
L_926cfc:
	st r0,[0x88606c]
L_926d04:
	j_s [blink]
L_926d06:
	nop_s
