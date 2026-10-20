/* bf_metrics__reset_and_stamp @ 0x9374b4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__rx_flow, tx_initiator_step
 * Зовёт сам: __ld_r13_ret_uc, memset0_words_uc, uc_read_tsf_lo
 */
	.section .text.bf_metrics__reset_and_stamp,"ax",@progbits
	.global bf_metrics__reset_and_stamp
bf_metrics__reset_and_stamp:
	.global L_9374b4
L_9374b4:
	push_s blink
L_9374b6:
	push_s r13
L_9374b8:
	mov_s r13,0x801118
L_9374be:
	mov_s r0,r13
L_9374c0:
	bl.d L_92166c
L_9374c4:
	mov_s r1,0x18
L_9374c6:
	bl L_9315e8
L_9374ca:
	b.d L_92028c
L_9374ce:
	st_s r0,[r13,0x10]
