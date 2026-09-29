/* tx_ctx__alloc_next @ 0x9384d4, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__respond_flow, bi_mode_init_sequence, bti_worker__bti_transmitter_beacon_sweep_flow, internal_tx__flow_sm2, internal_tx__flow_sm4, internal_tx__flow_sm6, macq__kick_queue_tx, rx_funcs__rx_flow, tx_bcast_flow, tx_initiator_flow_fixed_scheduling
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fsched__get_cur_idx
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_ctx__alloc_next
tx_ctx__alloc_next:
	.global L_9384d4
L_9384d4:
	push_s blink
L_9384d6:
	bl L_920234
L_9384da:
	mov_s r3,0x802978
L_9384e0:
	ld r1,[r3, 0x80]
L_9384e4:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_9384e6:
	bmsk r2,r1,0x0
L_9384ea:
	mul64 r2,0x3c
L_9384ee:
	add r13,r3,mlo
L_9384f2:
	breq_s r0,0,L_9384fa
L_9384f4:
	st r1,[r3, 0x80]
L_9384f8:
	st_s r13,[r3,0x78]
	.global L_9384fa
L_9384fa:
	mov_s r14,0x0
L_9384fc:
	mov_s r0,0xff
L_9384fe:
	st_s r0,[r13,0x4]
L_938500:
	ld_s r0,[r13]
L_938502:
	st_s r14,[r13,0x20]
L_938504:
	st_s r14,[r13,0xc]
L_938506:
	brhs.d r0,0x8,L_938534
L_93850a:
	st_s r14,[r13,0x24]
L_93850c:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_93850e:
	add2_s r0,r0,r0
L_938510:
	add_s r0,r0,0x801104
L_938516:
	ldw_s r1,[r0,0x2]
L_938518:
	bbit0 r1,0x0,L_938534
L_93851c:
	ld_s r2,[r0,0xc]
L_93851e:
	mov_s r1,0x7fff00
L_938524:
	and r0,r2,r1
L_938528:
	breq r0,r1,L_938534
L_93852c:
	mov_s r0,0x801024
L_938532:
	st_s r2,[r0]
	.global L_938534
L_938534:
	ld_s r0,[gp,-0x34]
L_938536:
	brne_s r0,0,L_938542
L_938538:
	mov_s r0,0x801024
L_93853e:
	ld_s r0,[r0]
L_938540:
	b_s L_938558
	.global L_938542
L_938542:
	mov_s r0,0x801be8
L_938548:
	bl L_927d54
L_93854c:
	mov_s r1,0x801108
L_938552:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_938554:
	add2_s r0,r0,r0
L_938556:
	ld_s r0,[r1,r0]
	.global L_938558
L_938558:
	st_s r0,[r13,0x2c]
L_93855a:
	st_s r14,[r13,0x30]
L_93855c:
	mov_s r0,0xf
L_93855e:
	st_s r0,[r13,0x1c]
L_938560:
	st_s r14,[r13,0x34]
L_938562:
	b.d L_9202a4
L_938566:
	mov_s r0,r13
