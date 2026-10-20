/* mac_tx_cnt__get_ok @ 0x8dd758, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__calc_goodput, mac_ampdu_statistics_timeout_cb, sm_802f58__action_8e774c, sm_pring__bind_vring, stats__delta_since_baseline
 * Глобалы (через gp): 0x8003d4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_tx_cnt__get_ok
mac_tx_cnt__get_ok:
	.global L_8dd758
L_8dd758:
	ld_s r0,[gp,0x250]
L_8dd75a:
	ld_s r0,[r0,0x48]
L_8dd75c:
	j_s [blink]
L_8dd75e:
	nop_s
