/* calib_lo_power__save_level @ 0x8d3ef4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power__step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_lo_power__save_level
calib_lo_power__save_level:
	.global L_8d3ef4
L_8d3ef4:
	j_s.d [blink]
L_8d3ef6:
	stb r0,[gp, 0xaf]
L_8d3efa:
	nop_s
