/* mac_q__tx_ppdu @ 0x939888, 284 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__prepare_txrx_window, rx__program_mac_and_wait, rx_funcs__rx_flow, tx_mtp_queue_gate, tx_sta__wait_slot_and_tx, txop_initiator_open_txop_flow
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac__program_tx_with_qid, macq__probe_empty, uc_sysassert
 * Глобалы (через gp): 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_q__tx_ppdu
mac_q__tx_ppdu:
	.global L_939888
L_939888:
	push_s blink
L_93988a:
	bl L_92022c
L_93988e:
	mov_s r14,r0
L_939890:
	push_s r1
L_939892:
	ld_s r0,[r0,0xc]
L_939894:
	btst_s r0,0x1
L_939896:
	beq_s L_93998c
L_939898:
	ld_s r15,[r14,0x20]
L_93989a:
	ld_s r13,[r14,0x4]
L_93989c:
	ld r16,[r14]
L_9398a0:
	brne_s r15,0,L_9398ac
L_9398a2:
	bl.d L_92dab8
L_9398a6:
	mov_s r0,r13
L_9398a8:
	cmp_s r0,0x0
L_9398aa:
	beq_s L_93999a
	.global L_9398ac
L_9398ac:
	mov_s r0,0x886500
L_9398b2:
	ld_s r0,[r0,0x6c]
L_9398b4:
	bmsk.f 0x0,r0,0x3
L_9398b8:
	mov.ne r0,blink
L_9398bc:
	bl.ne.d L_926618
L_9398c0:
	mov.ne r1,0x3
L_9398c4:
	mov_s r0,0x1c000006
L_9398ca:
	mov_s r32,r0
L_9398cc:
	st.ab r0,[r25,0x4]
L_9398d0:
	bclr r25,r25,0xa
L_9398d4:
	or r15,r15,0x46000008
L_9398dc:
	asl_s r1,r13,0x4
L_9398de:
	ld_s r0,[sp,0x0]
L_9398e0:
	or_s r1,r1,r15
L_9398e2:
	asl_s r0,r0,0xc
L_9398e4:
	or_s r0,r0,r1
L_9398e6:
	mov_s r32,r0
L_9398e8:
	st.ab r0,[r25,0x4]
L_9398ec:
	bclr r25,r25,0xa
L_9398f0:
	mov_s r1,0x8022c8
L_9398f6:
	ld_s r0,[r1,0x14]
L_9398f8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9398fa:
	st_s r0,[r1,0x14]
	.global L_9398fc
L_9398fc:
	mov_s r0,r53
L_9398fe:
	bbit0 r0,0x2,L_9398fc
L_939902:
	ld_s r0,[gp,-0x44]
L_939904:
	and r0,r0,0xfff0ffff
L_93990c:
	bset r1,r0,0x10
L_939910:
	or r0,r0,0x1d010000
L_939918:
	st.as r1,[gp,-0x11]
L_93991c:
	mov_s r32,r0
L_93991e:
	st.ab r0,[r25,0x4]
L_939922:
	bclr r25,r25,0xa
L_939926:
	nop_s
L_939928:
	nop_s
L_93992a:
	nop_s
	.global L_93992c
L_93992c:
	mov_s r0,r47
L_93992e:
	bbit1 r0,0x0,L_93992c
L_939932:
	asl r0,r16,0x8
L_939936:
	bset_s r0,r0,0x1a
L_939938:
	bset_s r0,r0,0x1e
L_93993a:
	or_s r13,r13,r0
L_93993c:
	bset_s r13,r13,0x13
L_93993e:
	bset_s r13,r13,0x15
L_939940:
	mov_s r32,r13
L_939942:
	st.ab r13,[r25,0x4]
L_939946:
	bclr r25,r25,0xa
L_93994a:
	mov_s r0,0x45000001
L_939950:
	mov_s r32,r0
L_939952:
	st.ab r0,[r25,0x4]
L_939956:
	bclr r25,r25,0xa
L_93995a:
	mov_s r0,0x460001f1
L_939960:
	mov_s r32,r0
L_939962:
	st.ab r0,[r25,0x4]
L_939966:
	bclr r25,r25,0xa
L_93996a:
	bl.d L_92d93c
L_93996e:
	ld_s r0,[r14,0x4]
	.global L_939970
L_939970:
	mov_s r0,r43
L_939972:
	bbit0 r0,0x1f,L_939970
L_939976:
	mov_s r0,r51
L_939978:
	bmsk r1,r0,0x3
L_93997c:
	st.as r1,[gp,0x38]
L_939980:
	lsr_s r0,r0,0x4
L_939982:
	st.as r0,[gp,0x39]
	.global L_939986
L_939986:
	mov_s r0,r45
L_939988:
	bbit0 r0,0x1f,L_939986
	.global L_93998c
L_93998c:
	ld_s r0,[r14,0xc]
L_93998e:
	bic r0,r0,0x7
L_939992:
	st_s r0,[r14,0xc]
L_939994:
	b.d L_920294
L_939998:
	add_s sp,sp,0x4
	.global L_93999a
L_93999a:
	mov_s r0,blink
L_93999c:
	bl.d L_926618
L_9399a0:
	mov_s r1,0x7
L_9399a2:
	b_s L_9398ac
