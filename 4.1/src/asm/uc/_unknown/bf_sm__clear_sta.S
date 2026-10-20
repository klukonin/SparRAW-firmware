/* bf_sm__clear_sta @ 0x9229c4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_clear_all_sta, ucode_cmd_0x05_handler
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf__clear_pending_and_notify, bf_sm__pop_request_fifo, bf_state__set, memset0_words_uc
 */
	.section .text.bf_sm__clear_sta,"ax",@progbits
	.global bf_sm__clear_sta
bf_sm__clear_sta:
	.global L_9229c4
L_9229c4:
	push_s blink
L_9229c6:
	bl L_920210
L_9229ca:
	mov_s r13,r0
L_9229cc:
	mov_s r15,0x800ef4
L_9229d2:
	ld_s r0,[r15,0x6c]
L_9229d4:
	mov_s r14,0x0
L_9229d6:
	bbit0 r0,r13,L_9229f0
L_9229da:
	mov_s r0,r13
L_9229dc:
	bl.d L_9283c8
L_9229e0:
	mov_s r1,r14
L_9229e2:
	bl.d L_924fb8
L_9229e6:
	mov_s r0,r13
L_9229e8:
	mov_s r0,r14
L_9229ea:
	bl.d L_9223b4
L_9229ee:
	mov_s r1,r14
	.global L_9229f0
L_9229f0:
	asl_s r0,r13,0x2
L_9229f2:
	add2_s r0,r0,r0
L_9229f4:
	add r1,r0,0x857849
L_9229fc:
	stb_s r14,[r1]
L_9229fe:
	asl_s r0,r13,0x2
L_922a00:
	add1_s r0,r0,r0
L_922a02:
	add_s r0,r0,r15
L_922a04:
	bl.d L_92166c
L_922a08:
	mov_s r1,0xc
L_922a0a:
	b L_92027c
L_922a0e:
	nop_s
