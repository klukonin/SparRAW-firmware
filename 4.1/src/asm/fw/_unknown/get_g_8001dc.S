/* get_g_8001dc @ 0x8cabe0, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sniffer_mode_step
 * Глобалы (через gp): 0x8001dc
 */
	.section .text.get_g_8001dc,"ax",@progbits
	.global get_g_8001dc
get_g_8001dc:
	.global L_8cabe0
L_8cabe0:
	j_s.d [blink]
L_8cabe2:
	ld_s r0,[gp,0x6c]
