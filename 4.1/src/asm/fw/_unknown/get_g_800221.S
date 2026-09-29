/* get_g_800221 @ 0x8ca0dc, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x800221
 */
	.section .text.get_g_800221,"ax",@progbits
	.global get_g_800221
get_g_800221:
	.global L_8ca0dc
L_8ca0dc:
	j_s.d [blink]
L_8ca0de:
	ldb_s r0,[gp,0xb1]
