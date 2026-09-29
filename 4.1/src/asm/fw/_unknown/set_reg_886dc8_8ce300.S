/* set_reg_886dc8_8ce300 @ 0x8ce300, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.set_reg_886dc8_8ce300,"ax",@progbits
	.global set_reg_886dc8_8ce300
set_reg_886dc8_8ce300:
	.global L_8ce300
L_8ce300:
	mov_s r0,0x886d80
L_8ce306:
	st 0x3d002000,[r0, 0x48]
L_8ce30e:
	j_s [blink]
