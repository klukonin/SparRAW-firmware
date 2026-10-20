/* get_g_800378 @ 0x8ca0c8, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x800378
 */
	.section .text.get_g_800378,"ax",@progbits
	.global get_g_800378
get_g_800378:
	.global L_8ca0c8
L_8ca0c8:
	j_s.d [blink]
L_8ca0ca:
	ld_s r0,[gp,0x208]
