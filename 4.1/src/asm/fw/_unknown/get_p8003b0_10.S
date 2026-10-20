/* get_p8003b0_10 @ 0x8d9aec, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__report
 * Глобалы (через gp): 0x8003b0
 */
	.section .text.get_p8003b0_10,"ax",@progbits
	.global get_p8003b0_10
get_p8003b0_10:
	.global L_8d9aec
L_8d9aec:
	ld_s r0,[gp,0x240]
L_8d9aee:
	ld_s r0,[r0,0x10]
L_8d9af0:
	j_s [blink]
L_8d9af2:
	nop_s
