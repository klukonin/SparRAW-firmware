/* get_p8003b0_48 @ 0x8d9af4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__report
 * Глобалы (через gp): 0x8003b0
 */
	.section .text.get_p8003b0_48,"ax",@progbits
	.global get_p8003b0_48
get_p8003b0_48:
	.global L_8d9af4
L_8d9af4:
	ld_s r0,[gp,0x240]
L_8d9af6:
	ld_s r0,[r0,0x48]
L_8d9af8:
	j_s [blink]
L_8d9afa:
	nop_s
