/* calib_obj__get_byte_b4 @ 0x8cbbbc, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__send_cmd_0x16_calib_b4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_obj__get_byte_b4
calib_obj__get_byte_b4:
	.global L_8cbbbc
L_8cbbbc:
	j_s.d [blink]
L_8cbbbe:
	ldb r0,[r0, 0xb4]
L_8cbbc2:
	nop_s
