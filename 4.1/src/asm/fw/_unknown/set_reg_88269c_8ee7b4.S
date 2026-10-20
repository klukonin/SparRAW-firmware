/* set_reg_88269c_8ee7b4 @ 0x8ee7b4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__link_down
 */
	.section .text.set_reg_88269c_8ee7b4,"ax",@progbits
	.global set_reg_88269c_8ee7b4
set_reg_88269c_8ee7b4:
	.global L_8ee7b4
L_8ee7b4:
	mov_s r1,0x1
L_8ee7b6:
	mov_s r0,0x882680
L_8ee7bc:
	st_s r1,[r0,0x1c]
L_8ee7be:
	j_s [blink]
