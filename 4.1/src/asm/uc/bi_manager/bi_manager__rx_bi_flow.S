/* bi_manager__rx_bi_flow @ 0x9285d4, 348 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__l1_rx_entry
 * Зовёт сам: bi_manager__eval_bcon_slot, bi_manager_rx_step, bi_tx__check_idle_and_start, power_mngr_peer_update, uc_pending__clear_bit
 */
	.section .text.bi_manager__rx_bi_flow,"ax",@progbits
	.global bi_manager__rx_bi_flow
bi_manager__rx_bi_flow:
	.global L_9285d4
L_9285d4:
	st.a r13,[sp,-0x10]
L_9285d8:
	st blink,[sp, 0x4]
L_9285dc:
	st_s r14,[sp,0x8]
L_9285de:
	st_s r15,[sp,0xc]
L_9285e0:
	sub_s sp,sp,0x8
L_9285e2:
	mov_s r13,0x80088c
L_9285e8:
	ldb r3,[r13, 0x8c]
L_9285ec:
	mov_s r14,r0
L_9285ee:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_9285f0:
	stb r3,[r13, 0x8c]
L_9285f4:
	mov r1,sp
L_9285f8:
	bl.d L_9262e0
L_9285fc:
	add r2,sp,0x4
L_928600:
	cmp_s r0,0x0
L_928602:
	beq_s L_9286fe
L_928604:
	ld r6,[0x8009e8]
L_92860c:
	breq.d r6,0x0,L_92862e
L_928610:
	mov_s r15,0x1
L_928612:
	ld_s r0,[r14,0x8]
L_928614:
	brne_s r0,0,L_92862e
L_928616:
	mov_s r3,0x4b
L_928618:
	asl r3,r3,0x5
L_92861c:
	mov lp_count,r3
L_928620:
	nop_s
L_928622:
	lp L_92862a
L_928626:
	nop_s
L_928628:
	nop_s
	.global L_92862a
L_92862a:
	st r15,[r14, 0x8]
	.global L_92862e
L_92862e:
	ldb r0,[sp]
L_928632:
	bl.d L_921a48
L_928636:
	ld r1,[sp, 0x4]
L_92863a:
	ldb r4,[sp]
L_92863e:
	breq.d r0,0x0,L_9286aa
L_928642:
	ld r5,[sp, 0x4]
L_928646:
	asl r3,0x1,r4
L_92864e:
	asl r4,r3,0x8
L_928652:
	cmp r5,0x0
L_928656:
	mov.eq r15,r4
L_92865a:
	mov.ne r15,r3
L_92865e:
	mov_s r0,0x801ed0
L_928664:
	mov_s r1,0x1
L_928666:
	bl.d L_9302a4
L_92866a:
	mov r2,r15
L_92866e:
	ld r4,[r14]
L_928672:
	bic r4,r4,r15
L_928676:
	st r4,[r14]
L_92867a:
	ldb r5,[r13, 0x8d]
L_92867e:
	ldb_s r1,[sp,0x0]
L_928680:
	add r5,r5,0x1
L_928684:
	add_s r1,r1,0x800644
L_92868a:
	ldb r6,[r1]
L_92868e:
	stb r5,[r13, 0x8d]
L_928692:
	add r6,r6,0x1
L_928696:
	stb r6,[r1]
L_92869a:
	add_s sp,sp,0x8
L_92869c:
	ld blink,[sp, 0x4]
L_9286a0:
	ld_s r14,[sp,0x8]
L_9286a2:
	ld_s r15,[sp,0xc]
L_9286a4:
	j_s.d [blink]
L_9286a6:
	ld.ab r13,[sp,0x10]
	.global L_9286aa
L_9286aa:
	asl r2,0x1,r4
L_9286b2:
	asl r7,r2,0x8
L_9286b6:
	cmp r5,0x0
L_9286ba:
	mov.eq r2,r7
L_9286be:
	mov r0,0x801ed0
L_9286c6:
	bl.d L_9302a4
L_9286ca:
	mov r1,0x2
L_9286ce:
	ldb r7,[r13, 0x8e]
L_9286d2:
	ldb_s r2,[sp,0x0]
L_9286d4:
	add r7,r7,0x1
L_9286d8:
	add_s r2,r2,0x80063c
L_9286de:
	ldb r8,[r2]
L_9286e2:
	stb r7,[r13, 0x8e]
L_9286e6:
	add r8,r8,0x1
L_9286ea:
	stb r8,[r2]
L_9286ee:
	add_s sp,sp,0x8
L_9286f0:
	ld blink,[sp, 0x4]
L_9286f4:
	ld_s r14,[sp,0x8]
L_9286f6:
	ld_s r15,[sp,0xc]
L_9286f8:
	j_s.d [blink]
L_9286fa:
	ld.ab r13,[sp,0x10]
	.global L_9286fe
L_9286fe:
	bl.d L_931a78
L_928702:
	mov r0,0x2
L_928706:
	mov_s r1,0x81
L_928708:
	asl_s r1,r1,0x12
L_92870a:
	mov r32,r1
L_92870e:
	st.ab r1,[r25,0x4]
L_928712:
	bclr r25,r25,0xa
L_928716:
	bl.d L_928f6c
L_92871a:
	mov r0,0x0
L_92871e:
	add_s sp,sp,0x8
L_928720:
	ld blink,[sp, 0x4]
L_928724:
	ld_s r14,[sp,0x8]
L_928726:
	ld_s r15,[sp,0xc]
L_928728:
	j_s.d [blink]
L_92872a:
	ld.ab r13,[sp,0x10]
L_92872e:
	nop_s
