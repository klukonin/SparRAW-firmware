/* mac_tx_cnt__get_u64_14 @ 0x8dd7a4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__counter64_b_thunk, lmac_if__update_pct_stats, mac_ampdu_statistics_timeout_cb, stats__delta_since_baseline
 * Глобалы (через gp): 0x8003d4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_tx_cnt__get_u64_14
mac_tx_cnt__get_u64_14:
	.global L_8dd7a4
L_8dd7a4:
	ld_s r0,[gp,0x250]
L_8dd7a6:
	ld_s r1,[r0,0x18]
L_8dd7a8:
	ld_s r0,[r0,0x14]
L_8dd7aa:
	j_s [blink]
