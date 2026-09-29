/* mac_rx_cnt__get_crc_ok @ 0x8dd8b0, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_lost_diag__dump_mac_rx
 * Глобалы (через gp): 0x8003d0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_rx_cnt__get_crc_ok
mac_rx_cnt__get_crc_ok:
	.global L_8dd8b0
L_8dd8b0:
	ld_s r0,[gp,0x24c]
L_8dd8b2:
	ld_s r0,[r0,0x8]
L_8dd8b4:
	j_s [blink]
L_8dd8b6:
	nop_s
