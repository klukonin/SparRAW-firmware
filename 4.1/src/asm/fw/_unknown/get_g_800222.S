/* get_g_800222 @ 0x8ca0d4, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x800222
 */
	.section .text.get_g_800222,"ax",@progbits
	.global get_g_800222
get_g_800222:
	.global L_8ca0d4
L_8ca0d4:
	j_s.d [blink]
L_8ca0d6:
	ldb_s r0,[gp,0xb2]
