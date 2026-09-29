/* set_reg_88268c_x2_8f2920 @ 0x8f2920, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__ACTIVATING
 */
	.section .text.set_reg_88268c_x2_8f2920,"ax",@progbits
	.global set_reg_88268c_x2_8f2920
set_reg_88268c_x2_8f2920:
	.global L_8f2920
L_8f2920:
	mov_s r1,0x1
L_8f2922:
	mov_s r0,0x882680
L_8f2928:
	st_s r1,[r0,0xc]
L_8f292a:
	st_s r1,[r0,0x20]
L_8f292c:
	j_s [blink]
L_8f292e:
	nop_s
