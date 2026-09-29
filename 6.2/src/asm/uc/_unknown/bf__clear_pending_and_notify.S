/* bf__clear_pending_and_notify @ 0x9258b0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__abort_to_state11, bf__reset_sta, bf_sm__process_request_fifo
 * Зовёт сам: __ld_r13_to_r13_ret, bf__resume_sta_tx, internal_tx__clear_pending_bit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__clear_pending_and_notify
bf__clear_pending_and_notify:
	.global L_9258b0
L_9258b0:
	push_s blink
L_9258b2:
	push_s r13
L_9258b4:
	mov_s r13,r0
L_9258b6:
	bl.d L_92bd70
L_9258ba:
	mov_s r0,0x3
L_9258bc:
	mov_s r0,0x3
L_9258be:
	bl.d L_92bb34
L_9258c2:
	mov_s r1,r13
L_9258c4:
	b L_9202ac
