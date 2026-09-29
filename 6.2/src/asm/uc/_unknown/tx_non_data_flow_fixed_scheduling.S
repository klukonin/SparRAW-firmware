/* tx_non_data_flow_fixed_scheduling @ 0x939594, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_initiator_flow_fixed_scheduling() Check for busy2 (CCA) or energy (RSSI) and abort if found
 *   tx_non_data_flow_fixed_scheduling() tx_bcast_flow
 *   tx_non_data_flow_fixed_scheduling() Starting internal TX
 * Зовут его: l1_fixed_sched_ap__ev4_state2
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, internal_tx_isr, mac__select_all_sectors_and_wait, mac__set_mode_0000, tx_bcast_flow, tx_ctx__alloc_next, tx_sta__run_txop, uc_log__emit_snapshot
 * Глобалы (через gp): 0x8005f4, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_non_data_flow_fixed_scheduling
tx_non_data_flow_fixed_scheduling:
	.global L_939594
L_939594:
	push_s blink
L_939596:
	bl L_920234
L_93959a:
	mov_s r14,r0
L_93959c:
	mov_s r0,0x14000100
L_9395a2:
	mov_s r32,r0
L_9395a4:
	st.ab r0,[r25,0x4]
L_9395a8:
	bclr r25,r25,0xa
L_9395ac:
	bl.d L_9384d4
L_9395b0:
	mov_s r0,0x1
L_9395b2:
	bl.d L_936870
L_9395b6:
	mov_s r13,r0
L_9395b8:
	mov_s r0,r42
L_9395ba:
	bbit0 r0,0xe,L_9395ec
L_9395be:
	mov_s r1,0x8022c8
L_9395c4:
	ld_s r0,[r1,0x4]
L_9395c6:
	st.as 0x800,[gp,0x34]
L_9395ce:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9395d0:
	st_s r0,[r1,0x4]
L_9395d2:
	mov_s r1,0x8010b0
L_9395d8:
	ld_s r0,[r1,0x44]
L_9395da:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9395dc:
	st_s r0,[r1,0x44]
L_9395de:
	mov_s r1,0x1001738
L_9395e4:
	bl.d L_92d13c
L_9395e8:
	mov_s r0,0x21
L_9395ea:
	b_s L_93969c
	.global L_9395ec
L_9395ec:
	ld_s r0,[r13,0xc]
L_9395ee:
	st_s r14,[r13,0x4]
L_9395f0:
	bset_s r0,r0,0x0
L_9395f2:
	st_s r0,[r13,0xc]
L_9395f4:
	breq r14,0x1f,L_939616
L_9395f8:
	ld_s r0,[gp,-0xc0]
L_9395fa:
	brne r14,r0,L_939668
L_9395fe:
	cmp r0,0xff
L_939602:
	beq_s L_939668
L_939604:
	mov_s r1,0x1001798
L_93960a:
	bl.d L_92d13c
L_93960e:
	mov_s r0,0x21
L_939610:
	bl L_937844
L_939614:
	b_s L_93969c
	.global L_939616
L_939616:
	mov_s r0,0x80
L_939618:
	bset_s r0,r0,0x19
L_93961a:
	mov_s r32,r0
L_93961c:
	st.ab r0,[r25,0x4]
L_939620:
	bclr r25,r25,0xa
L_939624:
	mov_s r1,0x10017cc
L_93962a:
	bl.d L_92d13c
L_93962e:
	mov_s r0,0x21
L_939630:
	mov_s r0,0xeeee03
L_939636:
	mov_s r32,r0
L_939638:
	st.ab r0,[r25,0x4]
L_93963c:
	bclr r25,r25,0xa
L_939640:
	bl.d L_92bbfc
L_939644:
	mov_s r0,r13
L_939646:
	ld_s r0,[gp,-0x48]
L_939648:
	or r0,r0,0x27003f00
L_939650:
	mov_s r32,r0
L_939652:
	st.ab r0,[r25,0x4]
L_939656:
	bclr r25,r25,0xa
L_93965a:
	mov_s r1,0x8010b0
L_939660:
	ld_s r0,[r1,0x48]
L_939662:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_939664:
	st_s r0,[r1,0x48]
L_939666:
	b_s L_93969c
	.global L_939668
L_939668:
	bl.d L_93a088
L_93966c:
	mov_s r0,r13
L_93966e:
	ld_s r0,[gp,0xd0]
L_939670:
	bbit1 r0,0x9,L_939684
L_939674:
	mov_s r0,0x14000100
L_93967a:
	mov_s r32,r0
L_93967c:
	st.ab r0,[r25,0x4]
L_939680:
	bclr r25,r25,0xa
	.global L_939684
L_939684:
	bl L_93e0dc
L_939688:
	mov_s r0,0x0
L_93968a:
	st.as r0,[gp,0x33]
L_93968e:
	st.as r0,[gp,0x34]
L_939692:
	mov_s r1,0x802978
L_939698:
	st_s r0,[r1,0xc]
L_93969a:
	st_s r0,[r1,0x48]
	.global L_93969c
L_93969c:
	b L_9202a4
