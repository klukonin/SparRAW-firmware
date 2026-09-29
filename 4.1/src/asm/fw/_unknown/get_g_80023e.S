/* get_g_80023e @ 0x8ca178, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power__correction_alg
 * Глобалы (через gp): 0x80023e
 */
	.section .text.get_g_80023e,"ax",@progbits
	.global get_g_80023e
get_g_80023e:
	.global L_8ca178
L_8ca178:
	j_s.d [blink]
L_8ca17a:
	ldb_s r0,[gp,0xce]
