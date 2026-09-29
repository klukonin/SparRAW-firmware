/* get_g_80023f @ 0x8ca17c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power__correction_alg
 * Глобалы (через gp): 0x80023f
 */
	.section .text.get_g_80023f,"ax",@progbits
	.global get_g_80023f
get_g_80023f:
	.global L_8ca17c
L_8ca17c:
	j_s.d [blink]
L_8ca17e:
	ldb_s r0,[gp,0xcf]
