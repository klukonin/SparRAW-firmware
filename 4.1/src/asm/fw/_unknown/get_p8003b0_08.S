/* get_p8003b0_08 @ 0x8d9b24, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_lost_diag__dump_mac_rx
 * Глобалы (через gp): 0x8003b0
 */
	.section .text.get_p8003b0_08,"ax",@progbits
	.global get_p8003b0_08
get_p8003b0_08:
	.global L_8d9b24
L_8d9b24:
	ld_s r0,[gp,0x240]
L_8d9b26:
	ld_s r0,[r0,0x8]
L_8d9b28:
	j_s [blink]
L_8d9b2a:
	nop_s
