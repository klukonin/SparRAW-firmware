/* get_p8003b4_50 @ 0x8d9ad0, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__calc_goodput, link_stats_sm__started, sm_pring__bind_vring
 * Глобалы (через gp): 0x8003b4
 */
	.section .text.get_p8003b4_50,"ax",@progbits
	.global get_p8003b4_50
get_p8003b4_50:
	.global L_8d9ad0
L_8d9ad0:
	ld_s r0,[gp,0x244]
L_8d9ad2:
	ld_s r0,[r0,0x50]
L_8d9ad4:
	j_s [blink]
L_8d9ad6:
	nop_s
