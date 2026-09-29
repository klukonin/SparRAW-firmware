/* get_p8003b4_48 @ 0x8d9ac8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__calc_goodput, link_stats_sm__started, sm_pring__bind_vring
 * Глобалы (через gp): 0x8003b4
 */
	.section .text.get_p8003b4_48,"ax",@progbits
	.global get_p8003b4_48
get_p8003b4_48:
	.global L_8d9ac8
L_8d9ac8:
	ld_s r0,[gp,0x244]
L_8d9aca:
	ld_s r0,[r0,0x48]
L_8d9acc:
	j_s [blink]
L_8d9ace:
	nop_s
