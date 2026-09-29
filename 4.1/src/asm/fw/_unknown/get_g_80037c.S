/* get_g_80037c @ 0x8ca0e0, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x80037c
 */
	.section .text.get_g_80037c,"ax",@progbits
	.global get_g_80037c
get_g_80037c:
	.global L_8ca0e0
L_8ca0e0:
	j_s.d [blink]
L_8ca0e2:
	ld_s r0,[gp,0x20c]
