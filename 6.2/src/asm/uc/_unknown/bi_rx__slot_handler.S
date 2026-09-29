/* bi_rx__slot_handler @ 0x92b4d8, 368 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi__dispatch_by_role
 * Зовёт сам: bi_manager__eval_bcon_slot, bi_rx__start_rx_window, bi_tx__check_idle_and_start_uc, internal_tx__clear_pending_bit, peer_masks__apply_op, uc_read_tsf_lo
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_rx__slot_handler
bi_rx__slot_handler:
	.global L_92b4d8
L_92b4d8:
	st.a r13,[sp,-0x14]
L_92b4dc:
	st blink,[sp, 0x4]
L_92b4e0:
	st_s r14,[sp,0x8]
L_92b4e2:
	st_s r15,[sp,0xc]
L_92b4e4:
	st r16,[sp, 0x10]
L_92b4e8:
	sub_s sp,sp,0x8
L_92b4ea:
	mov_s r13,0x801030
L_92b4f0:
	ldb r1,[r13, 0x8c]
L_92b4f4:
	mov_s r14,r0
L_92b4f6:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92b4f8:
	stb r1,[r13, 0x8c]
L_92b4fc:
	mov r1,sp
L_92b500:
	bl.d L_927de0
L_92b504:
	add r2,sp,0x4
L_92b508:
	cmp_s r0,0x0
L_92b50a:
	beq_s L_92b612
L_92b50c:
	ld r10,[0x8014c0]
L_92b514:
	breq.d r10,0x0,L_92b536
L_92b518:
	mov_s r15,0x1
L_92b51a:
	ld_s r0,[r14,0x8]
L_92b51c:
	brne_s r0,0,L_92b536
L_92b51e:
	mov_s r2,0x4b
L_92b520:
	asl r2,r2,0x5
L_92b524:
	mov lp_count,r2
L_92b528:
	nop_s
L_92b52a:
	lp L_92b532
L_92b52e:
	nop_s
L_92b530:
	nop_s
	.global L_92b532
L_92b532:
	st r15,[r14, 0x8]
	.global L_92b536
L_92b536:
	ldb r0,[sp]
L_92b53a:
	bl.d L_9210b0
L_92b53e:
	ld r1,[sp, 0x4]
L_92b542:
	ldb r15,[sp]
L_92b546:
	breq.d r0,0x0,L_92b5b2
L_92b54a:
	ld r16,[sp, 0x4]
L_92b54e:
	bl L_9364c8
L_92b552:
	asl r8,0x1,r15
L_92b55a:
	asl r11,r8,0x8
L_92b55e:
	cmp r16,0x0
L_92b562:
	mov.eq r15,r11
L_92b566:
	mov.ne r15,r8
L_92b56a:
	mov_s r0,0x802f80
L_92b570:
	mov_s r1,0x1
L_92b572:
	bl.d L_934bb0
L_92b576:
	mov r2,r15
L_92b57a:
	ld_s r2,[r14]
L_92b57c:
	bic_s r2,r2,r15
L_92b57e:
	st_s r2,[r14]
L_92b580:
	ldb r3,[r13, 0x8d]
L_92b584:
	ldb r7,[sp]
L_92b588:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_92b58a:
	add r7,r7,gp
L_92b58e:
	ldb r4,[r7, 0xac]
L_92b592:
	stb r3,[r13, 0x8d]
L_92b596:
	add r4,r4,0x1
L_92b59a:
	stb r4,[r7, 0xac]
L_92b59e:
	add_s sp,sp,0x8
L_92b5a0:
	ld blink,[sp, 0x4]
L_92b5a4:
	ld_s r14,[sp,0x8]
L_92b5a6:
	ld_s r15,[sp,0xc]
L_92b5a8:
	ld r16,[sp, 0x10]
L_92b5ac:
	j_s.d [blink]
L_92b5ae:
	ld.ab r13,[sp,0x14]
	.global L_92b5b2
L_92b5b2:
	bl L_9364c8
L_92b5b6:
	asl r1,0x1,r15
L_92b5be:
	asl r9,r1,0x8
L_92b5c2:
	cmp r16,0x0
L_92b5c6:
	mov.eq r2,r9
L_92b5ca:
	mov.ne r2,r1
L_92b5ce:
	mov r0,0x802f80
L_92b5d6:
	bl.d L_934bb0
L_92b5da:
	mov r1,0x2
L_92b5de:
	ldb r5,[r13, 0x8e]
L_92b5e2:
	ldb r8,[sp]
L_92b5e6:
	add r5,r5,0x1
L_92b5ea:
	add r8,r8,gp
L_92b5ee:
	ldb r6,[r8, 0xa4]
L_92b5f2:
	stb r5,[r13, 0x8e]
L_92b5f6:
	add r6,r6,0x1
L_92b5fa:
	stb r6,[r8, 0xa4]
L_92b5fe:
	add_s sp,sp,0x8
L_92b600:
	ld blink,[sp, 0x4]
L_92b604:
	ld_s r14,[sp,0x8]
L_92b606:
	ld_s r15,[sp,0xc]
L_92b608:
	ld r16,[sp, 0x10]
L_92b60c:
	j_s.d [blink]
L_92b60e:
	ld.ab r13,[sp,0x14]
	.global L_92b612
L_92b612:
	bl.d L_93696c
L_92b616:
	mov r0,0x2
L_92b61a:
	mov_s r2,0x81
L_92b61c:
	asl_s r2,r2,0x12
L_92b61e:
	mov r32,r2
L_92b622:
	st.ab r2,[r25,0x4]
L_92b626:
	bclr r25,r25,0xa
L_92b62a:
	bl.d L_92bd70
L_92b62e:
	mov r0,0x0
L_92b632:
	add_s sp,sp,0x8
L_92b634:
	ld blink,[sp, 0x4]
L_92b638:
	ld_s r14,[sp,0x8]
L_92b63a:
	ld_s r15,[sp,0xc]
L_92b63c:
	ld r16,[sp, 0x10]
L_92b640:
	j_s.d [blink]
L_92b642:
	ld.ab r13,[sp,0x14]
L_92b646:
	nop_s
