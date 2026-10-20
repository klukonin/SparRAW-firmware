/* bf_sm__reset_sta_rate @ 0x9221bc, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__start_request, bf_sm__substate_advance
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, memset0_words_uc, rate_search__reset_sta, tbl_8018b5__byte_by_index
 */
	.section .text.bf_sm__reset_sta_rate,"ax",@progbits
	.global bf_sm__reset_sta_rate
bf_sm__reset_sta_rate:
	.global L_9221bc
L_9221bc:
	push_s blink
L_9221be:
	bl L_920214
L_9221c2:
	mov_s r13,r0
L_9221c4:
	mov_s r14,r1
L_9221c6:
	mov_s r0,gp
L_9221c8:
	add r0,r0,0xe4
L_9221cc:
	bl.d L_92166c
L_9221d0:
	mov_s r1,0x3
L_9221d2:
	breq_s r14,0,L_9221e4
L_9221d4:
	mov_s r2,0x0
L_9221d6:
	asl_s r0,r13,0x2
L_9221d8:
	add2_s r0,r0,r0
L_9221da:
	add r1,r0,0x857849
L_9221e2:
	stb_s r2,[r1]
	.global L_9221e4
L_9221e4:
	bl.d L_92c320
L_9221e8:
	mov_s r0,r13
L_9221ea:
	cmp_s r0,0x0
L_9221ec:
	bl.eq.d L_92bd80
L_9221f0:
	mov.eq r0,r13
L_9221f4:
	b L_920284
