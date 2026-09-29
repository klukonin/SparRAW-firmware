/* get_g_800220 @ 0x8ca0d0, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x800220
 */
	.section .text.get_g_800220,"ax",@progbits
	.global get_g_800220
get_g_800220:
	.global L_8ca0d0
L_8ca0d0:
	j_s.d [blink]
L_8ca0d2:
	ldb_s r0,[gp,0xb0]
