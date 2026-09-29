/* bf_sm__clear_pending @ 0x92208c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__abort_unexpected, bf_sm__assert_and_clear, bf_sm__check_request_timeout, bf_sm__check_sta_timeout, bf_sm__pop_request_fifo, bf_sm__trigger
 * Зовёт сам: __ld_r13_ret_uc, bf_pending__set_bit, mem_8571dc__or_bit
 */
	.section .text.bf_sm__clear_pending,"ax",@progbits
	.global bf_sm__clear_pending
bf_sm__clear_pending:
	.global L_92208c
L_92208c:
	push_s blink
L_92208e:
	push_s r13
L_922090:
	mov_s r13,r0
L_922092:
	bl.d L_921f58
L_922096:
	mov_s r0,0x0
L_922098:
	bl.d L_9224a8
L_92209c:
	mov_s r0,r13
L_92209e:
	b L_92028c
L_9220a2:
	nop_s
