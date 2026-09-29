/* get_g_800288 @ 0x8ca0cc, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_queue__config_by_mode
 * Глобалы (через gp): 0x800288
 */
	.section .text.get_g_800288,"ax",@progbits
	.global get_g_800288
get_g_800288:
	.global L_8ca0cc
L_8ca0cc:
	j_s.d [blink]
L_8ca0ce:
	ldw_s r0,[gp,0x118]
