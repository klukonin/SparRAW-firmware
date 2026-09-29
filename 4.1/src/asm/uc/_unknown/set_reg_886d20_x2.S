/* set_reg_886d20_x2 @ 0x9304bc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 */
	.section .text.set_reg_886d20_x2,"ax",@progbits
	.global set_reg_886d20_x2
set_reg_886d20_x2:
	.global L_9304bc
L_9304bc:
	mov_s r2,0x886d00
L_9304c2:
	st_s r1,[r2,0x24]
L_9304c4:
	st_s r0,[r2,0x20]
L_9304c6:
	j_s [blink]
