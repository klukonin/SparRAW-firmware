/* mac_rx_cnt__get_crc_total @ 0x8dd7ac, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_ampdu_statistics_timeout_cb, stats__delta_since_baseline
 * Глобалы (через gp): 0x8003d0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_rx_cnt__get_crc_total
mac_rx_cnt__get_crc_total:
	.global L_8dd7ac
L_8dd7ac:
	ld_s r0,[gp,0x24c]
L_8dd7ae:
	ld_s r1,[r0,0x8]
L_8dd7b0:
	ld_s r0,[r0,0x4]
L_8dd7b2:
	j_s.d [blink]
L_8dd7b4:
	add_s r0,r0,r1
L_8dd7b6:
	nop_s
