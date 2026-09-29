/* bf__clear_pending_and_notify @ 0x924fb8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__abort_to_state11, bf_sm__clear_sta, bf_sm__process_request_fifo
 * Зовёт сам: __ld_r13_ret_uc, rf_sector__clear_sta_bit, uc_pending__clear_bit
 */
	.section .text.bf__clear_pending_and_notify,"ax",@progbits
	.global bf__clear_pending_and_notify
bf__clear_pending_and_notify:
	.global L_924fb8
L_924fb8:
	push_s blink
L_924fba:
	push_s r13
L_924fbc:
	mov_s r13,r0
L_924fbe:
	bl.d L_928f6c
L_924fc2:
	mov_s r0,0x3
L_924fc4:
	mov_s r0,0x3
L_924fc6:
	bl.d L_928d94
L_924fca:
	mov_s r1,r13
L_924fcc:
	b L_92028c
