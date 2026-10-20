/* set_reg_88269c_8ee7a4 @ 0x8ee7a4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__link_down
 */
	.section .text.set_reg_88269c_8ee7a4,"ax",@progbits
	.global set_reg_88269c_8ee7a4
set_reg_88269c_8ee7a4:
	.global L_8ee7a4
L_8ee7a4:
	mov r1,0x200
L_8ee7a8:
	mov_s r0,0x882680
L_8ee7ae:
	st_s r1,[r0,0x1c]
L_8ee7b0:
	j_s [blink]
L_8ee7b2:
	nop_s
