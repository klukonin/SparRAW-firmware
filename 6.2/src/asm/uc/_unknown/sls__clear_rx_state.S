/* sls__clear_rx_state @ 0x92ed50, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__abort_unexpected, rx_flow__run, txss_init__send_fdbk_wait_ack, txss_resp__wait_fdbk
 * Зовёт сам: memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sls__clear_rx_state
sls__clear_rx_state:
	.global L_92ed50
L_92ed50:
	mov_s r0,0x8021e0
L_92ed56:
	b.d L_920a84
L_92ed5a:
	mov_s r1,0x18
