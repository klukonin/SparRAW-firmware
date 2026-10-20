/* get_g_80023d @ 0x8ca164, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power__correction_alg
 * Глобалы (через gp): 0x80023d
 */
	.section .text.get_g_80023d,"ax",@progbits
	.global get_g_80023d
get_g_80023d:
	.global L_8ca164
L_8ca164:
	j_s.d [blink]
L_8ca166:
	ldb_s r0,[gp,0xcd]
