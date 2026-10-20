/* set_reg_88269c @ 0x8ee768, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__link_down, dpal__cpl_timeout_log
 */
	.section .text.set_reg_88269c,"ax",@progbits
	.global set_reg_88269c
set_reg_88269c:
	.global L_8ee768
L_8ee768:
	mov_s r0,0x882680
L_8ee76e:
	st 0x1000,[r0, 0x1c]
L_8ee776:
	j_s [blink]
