/* bf_state__set @ 0x9283c8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__abort_to_state11, bf_sm__check_request_timeout, bf_sm__check_sta_timeout, bf_sm__clear_sta, bf_sm__process_request_fifo, bf_sm__substate_advance, bf_sm__trigger, bf_substate__dispatch_by_state
 */
	.section .text.bf_state__set,"ax",@progbits
	.global bf_state__set
bf_state__set:
	.global L_9283c8
L_9283c8:
	mov_s r2,0x0
L_9283ca:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_9283cc:
	add1_s r0,r0,r0
L_9283ce:
	add_s r0,r0,0x800ef4
L_9283d4:
	st_s r1,[r0]
L_9283d6:
	st_s r2,[r0,0x4]
L_9283d8:
	j_s [blink]
L_9283da:
	nop_s
