/* get_g_8000a0 @ 0x8c98a4, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_base__vt2c, link_lost_diag_part2, wmi_handler_temp_sense
 */
	.section .text.get_g_8000a0,"ax",@progbits
	.global get_g_8000a0
get_g_8000a0:
	.global L_8c98a4
L_8c98a4:
	j_s.d [blink]
L_8c98a6:
	ld_s r0,[gp,-0xd0]
