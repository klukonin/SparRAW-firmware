/* mac_rx_cnt__get_crc_err @ 0x8dd8a8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_lost_diag__dump_mac_rx, mac_ampdu_statistics_timeout_cb, stats__delta_since_baseline
 * Глобалы (через gp): 0x8003d0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_rx_cnt__get_crc_err
mac_rx_cnt__get_crc_err:
	.global L_8dd8a8
L_8dd8a8:
	ld_s r0,[gp,0x24c]
L_8dd8aa:
	ld_s r0,[r0,0x4]
L_8dd8ac:
	j_s [blink]
L_8dd8ae:
	nop_s
