/* get_g_8001e8 @ 0x8ca0d8, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_macq__config_bcast_ring, tx_queue__config_by_mode
 * Глобалы (через gp): 0x8001e8
 */
	.section .text.get_g_8001e8,"ax",@progbits
	.global get_g_8001e8
get_g_8001e8:
	.global L_8ca0d8
L_8ca0d8:
	j_s.d [blink]
L_8ca0da:
	ldw_s r0,[gp,0x78]
