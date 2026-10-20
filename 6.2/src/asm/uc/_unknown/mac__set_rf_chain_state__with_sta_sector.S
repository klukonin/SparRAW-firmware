/* mac__set_rf_chain_state__with_sta_sector @ 0x935928, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw, bcon_txss_sweep_step, direct_tx_step, sls__send_ssw_ack, txss_init__send_ssw_fdbk
 * Зовёт сам: mac__set_rf_chain_state
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__set_rf_chain_state__with_sta_sector
mac__set_rf_chain_state__with_sta_sector:
	.global L_935928
L_935928:
	mov_s r1,0x801024
L_93592e:
	mov_s r0,0x1
L_935930:
	b.d L_92f42c
L_935934:
	ld_s r1,[r1]
L_935936:
	nop_s
