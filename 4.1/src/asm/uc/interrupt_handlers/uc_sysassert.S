/* uc_sysassert @ 0x925548, 904 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Crash TSF: curr tsf 0x%08x %08x
 *   SYSTEM FATAL CRASH0: curr_blink=0x%X, prev_blink =0x%X, SYSASSERT_CODE_0x%x
 *   SYSTEM FATAL CRASH1: sp=%d, ilink1=0x%X, ilink2=0x%X
 *   PRS_ICR=0x%08X
 *   mrfc_switch2tx_status_bus=0x%08X
 *   mrfc_switch2rx_status_bus=0x%08X
 *   Assert in file: %s ,
 *   [NNL]  line: %d
 * Зовут его: abft_responder__tx_ssw, aw_worker__collect_awake_peers, background_task__dispatch, basic_if__alloc_evt_slot, basic_if__post_to_fw_mailbox, basic_sm__assert_bad_event_uc, basic_sm__dispatch_loop, beacon_tx__build_slot_bitmap, bf_gpc__program_mac_by_mode, bf_gpc__program_mac_by_mode_b
 * Зовёт сам: set_reg_883150, set_reg_884804, uc_sysassert__emit_mac_trace, uc_sysassert__idle_hist, uc_sysassert__snapshot_mac
 * Глобалы (через gp): 0x80055c, 0x800564
 */
	.section .text.uc_sysassert,"ax",@progbits
	.global uc_sysassert
uc_sysassert:
	.global L_925548
L_925548:
	st.a r13,[sp,-0x1c]
L_92554c:
	st blink,[sp, 0x4]
L_925550:
	st_s r14,[sp,0x8]
L_925552:
	st_s r15,[sp,0xc]
L_925554:
	st r16,[sp, 0x10]
L_925558:
	st r17,[sp, 0x14]
L_92555c:
	st r18,[sp, 0x18]
L_925560:
	sub_s sp,sp,0x8
L_925562:
	mov_s r16,r0
L_925564:
	ld.as r10,[gp,0xf]
L_925568:
	mov_s r17,r2
L_92556a:
	cmp r10,0x0
L_92556e:
	mov_s r15,r1
L_925570:
	bne.d L_9258b4
L_925574:
	mov_s r18,r3
L_925576:
	mov_s r0,0x1
L_925578:
	st.as r0,[gp,0xf]
L_92557c:
	mov_s r1,sp
L_92557e:
	mov_s r0,0x0
L_925580:
	bl.d L_9325e4
L_925584:
	mov r2,r0
L_925588:
	mov_s r13,0x80209c
L_92558e:
	ldb r9,[r13, 0x4]
L_925592:
	mov_s r1,0x1000154
L_925598:
	bbit0 r9,0x2,L_9255f0
L_92559c:
	ld r7,[r13]
L_9255a0:
	ld r10,[sp]
L_9255a4:
	add r9,r7,0x2
L_9255a8:
	extb r9,r9
L_9255ac:
	mov r8,0x8020b0
L_9255b4:
	add2 r9,r8,r9
L_9255b8:
	st r10,[r9]
L_9255bc:
	add r0,r7,0x1
L_9255c0:
	extb r0,r0
L_9255c4:
	ld r11,[sp, 0x4]
L_9255c8:
	add2 r0,r8,r0
L_9255cc:
	st r11,[r0]
L_9255d0:
	bmsk r10,r1,0x13
L_9255d4:
	or r10,r10,0xaa000000
L_9255dc:
	extb r9,r7
L_9255e0:
	add2 r9,r8,r9
L_9255e4:
	st r10,[r9]
L_9255e8:
	add r7,r7,0x3
L_9255ec:
	st r7,[r13]
	.global L_9255f0
L_9255f0:
	mov r8,0x857000
L_9255f8:
	st r15,[r8, 0x28]
L_9255fc:
	st r16,[r8, 0x2c]
L_925600:
	mov r6,0x80eeeeee
L_925608:
	mov r32,r6
L_92560c:
	st.ab r6,[r25,0x4]
L_925610:
	bclr r25,r25,0xa
L_925614:
	bset r1,r15,0x1f
L_925618:
	mov r32,r1
L_92561c:
	st.ab r1,[r25,0x4]
L_925620:
	bclr r25,r25,0xa
L_925624:
	ror r0,0x1
L_925628:
	mov r32,r0
L_92562c:
	st.ab r0,[r25,0x4]
L_925630:
	bclr r25,r25,0xa
L_925634:
	ldb r6,[r13, 0x4]
L_925638:
	mov r1,0x1000174
L_925640:
	bbit0.d r6,0x0,L_925690
L_925644:
	mov r7,blink
L_925648:
	ld_s r0,[r13]
L_92564a:
	mov r5,0x8020b0
L_925652:
	add_s r2,r0,0x3
L_925654:
	extb_s r2,r2
L_925656:
	add2 r2,r5,r2
L_92565a:
	st_s r15,[r2]
L_92565c:
	add_s r2,r0,0x2
L_92565e:
	extb_s r2,r2
L_925660:
	add2 r2,r5,r2
L_925664:
	st r7,[r2]
L_925668:
	add r4,r0,0x1
L_92566c:
	extb r4,r4
L_925670:
	add2 r4,r5,r4
L_925674:
	st r16,[r4]
L_925678:
	bmsk_s r1,r1,0x13
L_92567a:
	or r1,r1,0xac000000
L_925682:
	extb_s r3,r0
L_925684:
	add2 r3,r5,r3
L_925688:
	st_s r1,[r3]
L_92568a:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_92568c:
	st r0,[r13]
	.global L_925690
L_925690:
	mov r4,0x10001c0
L_925698:
	mov_s r3,sp
L_92569a:
	mov_s r1,ilink1
L_92569c:
	bbit0.d r6,0x0,L_9256f8
L_9256a0:
	mov r11,ilink2
L_9256a4:
	ld r9,[r13]
L_9256a8:
	mov_s r0,0x8020b0
L_9256ae:
	add r10,r9,0x3
L_9256b2:
	extb r10,r10
L_9256b6:
	add2 r10,r0,r10
L_9256ba:
	st r11,[r10]
L_9256be:
	add r2,r9,0x2
L_9256c2:
	extb_s r2,r2
L_9256c4:
	add2 r2,r0,r2
L_9256c8:
	st_s r1,[r2]
L_9256ca:
	add r2,r9,0x1
L_9256ce:
	extb_s r2,r2
L_9256d0:
	add2 r2,r0,r2
L_9256d4:
	st r3,[r2]
L_9256d8:
	bmsk r4,r4,0x13
L_9256dc:
	or r4,r4,0xac000000
L_9256e4:
	extb r10,r9
L_9256e8:
	add2 r0,r0,r10
L_9256ec:
	st r4,[r0]
L_9256f0:
	add r9,r9,0x4
L_9256f4:
	st r9,[r13]
	.global L_9256f8
L_9256f8:
	ld r1,[0x886210]
L_925700:
	ldb r4,[r13, 0x4]
L_925704:
	mov_s r3,0x10001f8
L_92570a:
	bbit0 r4,0x2,L_925740
L_92570e:
	ld r11,[r13]
L_925712:
	mov_s r2,0x8020b0
L_925718:
	add r0,r11,0x1
L_92571c:
	extb_s r0,r0
L_92571e:
	add2 r0,r2,r0
L_925722:
	st_s r1,[r0]
L_925724:
	bmsk_s r3,r3,0x13
L_925726:
	or r3,r3,0xa6000000
L_92572e:
	extb r9,r11
L_925732:
	add2 r2,r2,r9
L_925736:
	st_s r3,[r2]
L_925738:
	add r11,r11,0x2
L_92573c:
	st r11,[r13]
	.global L_925740
L_925740:
	mov_s r14,0x887000
L_925746:
	ld r11,[r14, -0xc4]
L_92574a:
	ldb r7,[r13, 0x4]
L_92574e:
	mov_s r1,0x1000208
L_925754:
	bbit0 r7,0x2,L_92578c
L_925758:
	ld r9,[r13]
L_92575c:
	mov_s r0,0x8020b0
L_925762:
	add r10,r9,0x1
L_925766:
	extb r10,r10
L_92576a:
	add2 r10,r0,r10
L_92576e:
	st r11,[r10]
L_925772:
	bmsk_s r1,r1,0x13
L_925774:
	or r1,r1,0xa6000000
L_92577c:
	extb r3,r9
L_925780:
	add2_s r0,r0,r3
L_925782:
	st_s r1,[r0]
L_925784:
	add r9,r9,0x2
L_925788:
	st r9,[r13]
	.global L_92578c
L_92578c:
	ld r4,[r14, -0xc0]
L_925790:
	ldb r5,[r13, 0x4]
L_925794:
	mov_s r2,0x100022c
L_92579a:
	bbit0 r5,0x2,L_9257d0
L_92579e:
	ld_s r3,[r13]
L_9257a0:
	mov r6,0x8020b0
L_9257a8:
	add r7,r3,0x1
L_9257ac:
	extb r7,r7
L_9257b0:
	add2 r7,r6,r7
L_9257b4:
	st r4,[r7]
L_9257b8:
	bmsk_s r2,r2,0x13
L_9257ba:
	or r4,r2,0xa6000000
L_9257c2:
	extb_s r2,r3
L_9257c4:
	add2 r2,r6,r2
L_9257c8:
	st r4,[r2]
L_9257cc:
	/* add_s r3,0x2 */
	.byte 0x02,0xe3
L_9257ce:
	st_s r3,[r13]
	.global L_9257d0
L_9257d0:
	mov r8,0x1000250
L_9257d8:
	bbit0 r5,0x2,L_925818
L_9257dc:
	ld r4,[r13]
L_9257e0:
	mov r6,0x8020b0
L_9257e8:
	add r7,r4,0x1
L_9257ec:
	extb r7,r7
L_9257f0:
	add2 r7,r6,r7
L_9257f4:
	st r17,[r7]
L_9257f8:
	bmsk r8,r8,0x13
L_9257fc:
	or r8,r8,0xb6000000
L_925804:
	extb r7,r4
L_925808:
	add2 r7,r6,r7
L_92580c:
	st r8,[r7]
L_925810:
	add r4,r4,0x2
L_925814:
	st r4,[r13]
	.global L_925818
L_925818:
	mov r6,0x1000268
L_925820:
	bbit0 r5,0x2,L_925860
L_925824:
	ld r5,[r13]
L_925828:
	mov r7,0x8020b0
L_925830:
	add r2,r5,0x1
L_925834:
	extb r2,r2
L_925838:
	add2 r2,r7,r2
L_92583c:
	st r18,[r2]
L_925840:
	bmsk r6,r6,0x13
L_925844:
	or r6,r6,0xa6000000
L_92584c:
	extb r8,r5
L_925850:
	add2 r8,r7,r8
L_925854:
	st r6,[r8]
L_925858:
	add r5,r5,0x2
L_92585c:
	st r5,[r13]
	.global L_925860
L_925860:
	bl L_92522c
L_925864:
	ld.as r3,[gp,-0x2e]
L_925868:
	cmp r3,0x1
L_92586c:
	bl.eq.d L_927480
L_925870:
	mov.eq r0,0x0
L_925874:
	bl.d L_92b7f8
L_925878:
	mov r0,0xd
L_92587c:
	bl.d L_9274e4
L_925880:
	mov r0,0x1
L_925884:
	st.as r15,[gp,-0x1a]
L_925888:
	st.as r15,[gp,-0x18]
L_92588c:
	st.as r16,[gp,-0x1b]
L_925890:
	st.as r25,[gp,0xd]
L_925894:
	mov_s r1,0x40
L_925896:
	st.as r1,[r14,-0x6b]
L_92589a:
	st.as r1,[r14,-0x6e]
L_92589e:
	nop_s
L_9258a0:
	nop_s
L_9258a2:
	nop_s
L_9258a4:
	nop_s
L_9258a6:
	flag 0x1
L_9258aa:
	nop_s
L_9258ac:
	nop_s
L_9258ae:
	nop_s
L_9258b0:
	mov 0x0,0x0
	.global L_9258b4
L_9258b4:
	add_s sp,sp,0x8
L_9258b6:
	ld blink,[sp, 0x4]
L_9258ba:
	ld_s r14,[sp,0x8]
L_9258bc:
	ld_s r15,[sp,0xc]
L_9258be:
	ld r16,[sp, 0x10]
L_9258c2:
	ld r17,[sp, 0x14]
L_9258c6:
	ld r18,[sp, 0x18]
L_9258ca:
	j_s.d [blink]
L_9258cc:
	ld.ab r13,[sp,0x1c]
