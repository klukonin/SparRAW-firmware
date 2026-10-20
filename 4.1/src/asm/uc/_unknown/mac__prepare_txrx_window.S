/* mac__prepare_txrx_window @ 0x92177c, 376 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_nav_update, tx_flow_size_step, tx_initiator_substep
 * Зовёт сам: mac_counter__program_0008, rx__mac_prepare, uc_wait_event_busy
 * Глобалы (через gp): 0x800604, 0x800608
 */
	.section .text.mac__prepare_txrx_window,"ax",@progbits
	.global mac__prepare_txrx_window
mac__prepare_txrx_window:
	.global L_92177c
L_92177c:
	st.a r13,[sp,-0xc]
L_921780:
	st blink,[sp, 0x4]
L_921784:
	st_s r14,[sp,0x8]
L_921786:
	mov_s r13,r0
L_921788:
	mov r14,r1
L_92178c:
	ld.as r9,[gp,0x37]
L_921790:
	mov r8,0x0
L_921794:
	ld.as r7,[gp,0x38]
L_921798:
	bic r9,r9,-0x3
L_92179c:
	mov r5,0x31000000
L_9217a4:
	bic r7,r7,0x1f
L_9217a8:
	or.f 0x0,r9,r8
L_9217ac:
	bset r7,r7,0x7
L_9217b0:
	beq.d L_9218b8
L_9217b4:
	st.as r7,[gp,0x38]
L_9217b8:
	stb r8,[gp, -0xe9]
L_9217bc:
	mov r32,r5
L_9217c0:
	st.ab r5,[r25,0x4]
L_9217c4:
	bclr r25,r25,0xa
L_9217c8:
	ld.as r7,[gp,-0x11]
L_9217cc:
	and r7,r7,0xffff0fff
L_9217d4:
	or r6,r7,0x3000
L_9217dc:
	or r7,r7,0x1d003000
L_9217e4:
	st.as r6,[gp,-0x11]
L_9217e8:
	mov r32,r7
L_9217ec:
	st.ab r7,[r25,0x4]
L_9217f0:
	bclr r25,r25,0xa
L_9217f4:
	nop_s
L_9217f6:
	nop_s
L_9217f8:
	mov 0x0,0x0
L_9217fc:
	brne.d r14,0x2,L_921824
L_921800:
	extw r6,r40
L_921804:
	ldb r9,[0x801a0b]
L_92180c:
	asl r0,r9
L_921810:
	brhs r0,r6,L_921824
L_921814:
	sub1 r6,r6,r9
L_921818:
	brlo r6,0x5,L_921824
L_92181c:
	mov r3,r42
L_921820:
	bbit0 r3,0x7,L_921838
	.global L_921824
L_921824:
	ld.as r5,[gp,0x38]
L_921828:
	bset r5,r5,0xa
L_92182c:
	bl.d L_92b7c4
L_921830:
	st.as r5,[gp,0x38]
L_921834:
	b L_921848
	.global L_921838
L_921838:
	mov_s r0,0x14000002
L_92183e:
	mov_s r32,r0
L_921840:
	st.ab r0,[r25,0x4]
L_921844:
	bclr r25,r25,0xa
	.global L_921848
L_921848:
	ld_s r1,[r13,0xc]
L_92184a:
	btst_s r1,0x1
L_92184c:
	mov.ne r0,r13
L_921850:
	bl.ne.d L_933f90
L_921854:
	mov.ne r1,0x2
L_921858:
	ld.as r6,[gp,-0x12]
L_92185c:
	or r6,r6,0x27000e00
L_921864:
	mov r32,r6
L_921868:
	st.ab r6,[r25,0x4]
L_92186c:
	bclr r25,r25,0xa
L_921870:
	mov r7,0x2004000
L_921878:
	mov r32,r7
L_92187c:
	st.ab r7,[r25,0x4]
L_921880:
	bclr r25,r25,0xa
L_921884:
	nop_s
L_921886:
	nop_s
L_921888:
	nop_s
L_92188a:
	mov_s r0,0x2
L_92188c:
	bset r0,r0,0xe
L_921890:
	bl.d L_931808
L_921894:
	mov r1,0x0
L_921898:
	mov_s r2,r42
L_92189a:
	bbit0 r2,0xe,L_9218e8
L_92189e:
	ld.as r4,[gp,0x38]
L_9218a2:
	ld blink,[sp, 0x4]
L_9218a6:
	bclr r4,r4,0x8
L_9218aa:
	st.as r4,[gp,0x38]
L_9218ae:
	ld_s r14,[sp,0x8]
L_9218b0:
	j.d [blink]
L_9218b4:
	ld.ab r13,[sp,0xc]
	.global L_9218b8
L_9218b8:
	stb r8,[gp, -0xe9]
L_9218bc:
	mov r32,r5
L_9218c0:
	st.ab r5,[r25,0x4]
L_9218c4:
	bclr r25,r25,0xa
L_9218c8:
	ld r8,[r13, 0xc]
L_9218cc:
	bbit0 r8,0x1,L_9218e8
L_9218d0:
	mov r0,r13
L_9218d4:
	bl.d L_933f90
L_9218d8:
	mov r1,0x2
L_9218dc:
	ld blink,[sp, 0x4]
L_9218e0:
	ld_s r14,[sp,0x8]
L_9218e2:
	j_s.d [blink]
L_9218e4:
	ld.ab r13,[sp,0xc]
	.global L_9218e8
L_9218e8:
	ld blink,[sp, 0x4]
L_9218ec:
	ld_s r14,[sp,0x8]
L_9218ee:
	j_s.d [blink]
L_9218f0:
	ld.ab r13,[sp,0xc]
