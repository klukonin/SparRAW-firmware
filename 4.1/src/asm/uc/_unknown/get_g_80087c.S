/* get_g_80087c @ 0x930f34, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw, bcon_txss_sweep_step, direct_tx_step, rx_funcs_step, txss_flow_step
 * Зовёт сам: mac__set_rf_chain_state
 */
	.section .text.get_g_80087c,"ax",@progbits
	.global get_g_80087c
get_g_80087c:
	.global L_930f34
L_930f34:
	mov_s r1,0x80087c
L_930f3a:
	mov_s r0,0x1
L_930f3c:
	b.d L_92b934
L_930f40:
	ld_s r1,[r1]
L_930f42:
	nop_s
