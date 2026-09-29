/* sta_tbl__find_by_mac @ 0x9349a0, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame, rx_funcs__handle_ppdu_report
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sta_tbl__find_by_mac
sta_tbl__find_by_mac:
	.global L_9349a0
L_9349a0:
	push_s r13
L_9349a2:
	mov_s r1,r0
L_9349a4:
	mov_s r0,0x0
L_9349a6:
	b_s L_9349aa
	.global L_9349a8
L_9349a8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_9349aa
L_9349aa:
	brge r0,0x8,L_9349d6
L_9349ae:
	asl_s r2,r0,0x4
L_9349b0:
	add2_s r2,r2,r2
L_9349b2:
	add_s r2,r2,0x801104
L_9349b8:
	ldw_s r13,[r2,0x30]
L_9349ba:
	ldw_s r3,[r1]
L_9349bc:
	brne r13,r3,L_9349a8
L_9349c0:
	ldw_s r13,[r2,0x32]
L_9349c2:
	ldw_s r3,[r1,0x2]
L_9349c4:
	brne r13,r3,L_9349a8
L_9349c8:
	ldw_s r13,[r2,0x34]
L_9349ca:
	ldw_s r3,[r1,0x4]
L_9349cc:
	brne r13,r3,L_9349a8
L_9349d0:
	ldw_s r2,[r2,0x2]
L_9349d2:
	bbit0 r2,0x0,L_9349a8
	.global L_9349d6
L_9349d6:
	j_s.d [blink]
L_9349d8:
	pop_s r13
L_9349da:
	nop_s
