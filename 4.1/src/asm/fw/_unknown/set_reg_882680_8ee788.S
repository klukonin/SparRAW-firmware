/* set_reg_882680_8ee788 @ 0x8ee788, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__HOST_8edad4, WBE_DRIVER__link_down
 */
	.section .text.set_reg_882680_8ee788,"ax",@progbits
	.global set_reg_882680_8ee788
set_reg_882680_8ee788:
	.global L_8ee788
L_8ee788:
	mov_s r1,0x882680
L_8ee78e:
	st 0x2000,[r1]
L_8ee796:
	st 0x4000,[r1]
L_8ee79e:
	mov_s r0,0x8
L_8ee7a0:
	st_s r0,[r1]
L_8ee7a2:
	j_s [blink]
