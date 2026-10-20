/* get_g_8001ea @ 0x8ca120, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x8001ea
 */
	.section .text.get_g_8001ea,"ax",@progbits
	.global get_g_8001ea
get_g_8001ea:
	.global L_8ca120
L_8ca120:
	j_s.d [blink]
L_8ca122:
	ldw_s r0,[gp,0x7a]
