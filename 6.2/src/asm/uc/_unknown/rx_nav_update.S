/* rx_nav_update @ 0x934590, 492 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run
 * Зовёт сам: mac__prepare_txrx_window, rx_nav__set_from_duration
 * Глобалы (через gp): 0x800568, 0x80056c, 0x8005f4, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_nav_update
rx_nav_update:
	.global L_934590
L_934590:
	push_s blink
L_934592:
	mov_s r6,r0
L_934594:
	ld.as r11,[gp,0x34]
L_934598:
	ld r0,[0x8029f0]
L_9345a0:
	bmsk r4,r11,0x4
L_9345a4:
	brne.d r4,0x1,L_934620
L_9345a8:
	mov r5,r1
L_9345ac:
	bic r1,r11,0x1f
L_9345b0:
	bbit0.d r5,0x8,L_9345c0
L_9345b4:
	st.as r1,[gp,0x34]
L_9345b8:
	btst_s r3,0xc
L_9345ba:
	btst.eq r1,0x12
L_9345be:
	bne_s L_9345d0
	.global L_9345c0
L_9345c0:
	ld.as r7,[gp,0x10]
L_9345c4:
	cmp r7,0x0
L_9345c8:
	btst.ne r1,0x9
L_9345cc:
	beq L_934608
	.global L_9345d0
L_9345d0:
	bic r1,r1,0x1f
L_9345d4:
	st.as r1,[gp,0x34]
L_9345d8:
	ld_s r1,[r0,0xc]
L_9345da:
	mov r11,0x0
L_9345de:
	bclr_s r1,r1,0x1
L_9345e0:
	st_s r1,[r0,0xc]
L_9345e2:
	st r11,[r0, 0x20]
L_9345e6:
	ld.as r8,[gp,0x33]
L_9345ea:
	bbit0 r8,0x1,L_934600
L_9345ee:
	mov r9,r38
L_9345f2:
	bbit0 r9,0xf,L_934600
L_9345f6:
	ld.as r2,[gp,0x34]
L_9345fa:
	bset_s r2,r2,0x3
L_9345fc:
	st.as r2,[gp,0x34]
	.global L_934600
L_934600:
	pop_s blink
L_934602:
	j_s.d [blink]
L_934604:
	st.as r11,[gp,0x10]
	.global L_934608
L_934608:
	mov r9,0x8022c8
L_934610:
	ld r3,[r9, 0x10]
L_934614:
	add r3,r3,0x1
L_934618:
	b.d L_9346d0
L_93461c:
	st r3,[r9, 0x10]
	.global L_934620
L_934620:
	brne r4,0x10,L_934688
L_934624:
	bbit0 r5,0x1,L_93467c
L_934628:
	bic r3,r11,0x1f
L_93462c:
	st.as r3,[gp,0x34]
L_934630:
	ld r4,[r0, 0xc]
L_934634:
	mov r5,0x0
L_934638:
	bclr r4,r4,0x1
L_93463c:
	st r4,[r0, 0xc]
L_934640:
	st r5,[r0, 0x20]
L_934644:
	ld.as r2,[gp,0x33]
L_934648:
	bbit1.d r2,0x1,L_934658
L_93464c:
	mov r1,-0x20
L_934650:
	b.d L_934664
L_934654:
	ld.as r11,[gp,0x34]
	.global L_934658
L_934658:
	mov r4,r38
L_93465c:
	bbit1.d r4,0xf,L_934670
L_934660:
	ld.as r11,[gp,0x34]
	.global L_934664
L_934664:
	and r11,r11,r1
L_934668:
	pop_s blink
L_93466a:
	j_s.d [blink]
L_93466c:
	st.as r11,[gp,0x34]
	.global L_934670
L_934670:
	bic r11,r11,0x1f
L_934674:
	pop_s blink
L_934676:
	j_s.d [blink]
L_934678:
	st.as r11,[gp,0x34]
	.global L_93467c
L_93467c:
	bset r11,r11,0x7
L_934680:
	pop_s blink
L_934682:
	j_s.d [blink]
L_934684:
	st.as r11,[gp,0x34]
	.global L_934688
L_934688:
	brne r4,0x2,L_9346fc
L_93468c:
	bic r11,r11,0x1f
L_934690:
	st.as r11,[gp,0x34]
L_934694:
	btst r5,0x9
L_934698:
	btst.ne r3,0xc
L_93469c:
	beq_s L_9346dc
L_93469e:
	ld.as r10,[gp,-0x32]
L_9346a2:
	brne r10,0x0,L_9346d0
L_9346a6:
	ld_s r1,[r0,0xc]
L_9346a8:
	mov r4,0x0
L_9346ac:
	bclr_s r1,r1,0x1
L_9346ae:
	st_s r1,[r0,0xc]
L_9346b0:
	st r4,[r0, 0x20]
L_9346b4:
	ld.as r1,[gp,0x33]
L_9346b8:
	bbit0 r1,0x1,L_934778
L_9346bc:
	mov_s r0,r38
L_9346be:
	bbit0 r0,0xf,L_934778
L_9346c2:
	ld_s r0,[gp,0xd0]
L_9346c4:
	pop_s blink
L_9346c6:
	bset_s r0,r0,0x3
L_9346c8:
	j.d [blink]
L_9346cc:
	st.as r0,[gp,0x34]
	.global L_9346d0
L_9346d0:
	bl.d L_920b58
L_9346d4:
	mov r1,0x2
L_9346d8:
	pop_s blink
L_9346da:
	j_s [blink]
	.global L_9346dc
L_9346dc:
	bl.d L_920b58
L_9346e0:
	mov r1,0x2
L_9346e4:
	mov r7,0x802210
L_9346ec:
	ld r6,[r7, 0xc]
L_9346f0:
	pop_s blink
L_9346f2:
	add r6,r6,0x1
L_9346f6:
	j_s.d [blink]
L_9346f8:
	st r6,[r7, 0xc]
	.global L_9346fc
L_9346fc:
	brne r4,0x4,L_934764
L_934700:
	bbit0 r2,0x1,L_934718
L_934704:
	bic r11,r11,0x1f
L_934708:
	st.as r11,[gp,0x34]
L_93470c:
	mov r6,0x1
L_934710:
	pop_s blink
L_934712:
	j_s.d [blink]
L_934714:
	st.as r6,[gp,0x11]
	.global L_934718
L_934718:
	mov_s r3,r37
L_93471a:
	bbit0 r3,0x2,L_93475c
L_93471e:
	mov r10,0x804010
L_934726:
	mov_s r0,0x1
L_934728:
	ldw r1,[r10]
L_93472c:
	mov r3,0x80401a
L_934734:
	bl.d L_92dd30
L_934738:
	ldw r2,[r10, 0x2]
L_93473c:
	mov r8,0x8022c8
L_934744:
	ld r1,[r8, 0x64]
L_934748:
	ld_s r0,[gp,0xd0]
L_93474a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_93474c:
	st r1,[r8, 0x64]
L_934750:
	bic r0,r0,0x1f
L_934754:
	b.d L_93467c
L_934758:
	or r11,r0,0x5
	.global L_93475c
L_93475c:
	b.d L_93467c
L_934760:
	ld.as r11,[gp,0x34]
	.global L_934764
L_934764:
	brne r4,0x8,L_934778
L_934768:
	cmp r6,0x0
L_93476c:
	mov.ne r1,0xffffffe0
L_934774:
	bne L_934664
	.global L_934778
L_934778:
	pop_s blink
L_93477a:
	j_s [blink]
