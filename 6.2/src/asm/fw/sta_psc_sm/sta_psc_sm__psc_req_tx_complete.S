/* sta_psc_sm__psc_req_tx_complete @ 0x8e19b0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__action
 * Зовёт сам: ps_connection__psc_req_rx_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sta_psc_sm__psc_req_tx_complete
sta_psc_sm__psc_req_tx_complete:
	.global L_8e19b0
L_8e19b0:
	mul64 r0,0x88
L_8e19b4:
	add r0,mlo,0x803db0
L_8e19bc:
	b L_8e1990
