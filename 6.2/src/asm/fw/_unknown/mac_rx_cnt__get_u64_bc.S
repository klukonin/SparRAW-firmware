/* mac_rx_cnt__get_u64_bc @ 0x8dd798, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__counter64_a_thunk, lmac_if__update_pct_stats, mac_ampdu_statistics_timeout_cb, stats__delta_since_baseline
 * Глобалы (через gp): 0x8003d0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_rx_cnt__get_u64_bc
mac_rx_cnt__get_u64_bc:
	.global L_8dd798
L_8dd798:
	ld_s r0,[gp,0x24c]
L_8dd79a:
	ld r1,[r0, 0xc0]
L_8dd79e:
	ld r0,[r0, 0xbc]
L_8dd7a2:
	j_s [blink]
