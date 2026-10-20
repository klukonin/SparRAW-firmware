/* l1_task__entry @ 0x92c974, 364 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_isr_l1_task0, uc_isr_l1_task2, uc_vector_03, uc_vector_09
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bi__tsf_delta64, grant_detect_step, l1_task__check_pending, l1_task__check_ready, l1_task__entry_uc, l1_task__kick_and_dispatch_uc, l1_task__mask_halt_req_and_defer, l1_task__mask_wake_req_and_defer, l1_task__select_by_mode, phy__signal_gain_adc_in_range
 * Глобалы (через gp): 0x8005bc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_task__entry
l1_task__entry:
	.global L_92c974
L_92c974:
	push_s blink
L_92c976:
	bl L_920234
L_92c97a:
	breq r0,0x0,L_92ca64
L_92c97e:
	cmp_s r0,0x1
L_92c980:
	beq_s L_92cac2
L_92c982:
	cmp_s r0,0x2
L_92c984:
	beq_s L_92cac8
L_92c986:
	cmp_s r0,0x3
L_92c988:
	bne_s L_92cacc
L_92c98a:
	mov_s r0,0x8006a8
L_92c990:
	ldb_s r0,[r0]
L_92c992:
	cmp_s r0,0x0
L_92c994:
	bne_s L_92cad0
	.global L_92c996
L_92c996:
	mov_s r2,0x800738
L_92c99c:
	ld_s r3,[r2,0xc]
L_92c99e:
	ld_s r0,[r2,0x4]
L_92c9a0:
	mov_s r13,0x800634
L_92c9a6:
	sr r3,[r0]
L_92c9aa:
	ld_s r0,[r2,0x10]
L_92c9ac:
	sr 0x0,[r0]
L_92c9b4:
	ld_s r0,[r13]
L_92c9b6:
	mov_s r1,0x0
L_92c9b8:
	breq_s r0,0,L_92c9c8
L_92c9ba:
	mov_s r2,0x8010b0
L_92c9c0:
	ld_s r0,[r2,0x28]
L_92c9c2:
	st_s r1,[r13]
L_92c9c4:
	add_s r0,r0,0xa
L_92c9c6:
	st_s r0,[r2,0x28]
	.global L_92c9c8
L_92c9c8:
	bl L_924f28
L_92c9cc:
	brne r0,0x1,L_92c9d6
L_92c9d0:
	bl L_9364c8
L_92c9d4:
	st_s r0,[r13]
	.global L_92c9d6
L_92c9d6:
	bl L_921840
L_92c9da:
	bl L_92e718
L_92c9de:
	mov_s r0,0x0
L_92c9e0:
	mov_s r1,r0
L_92c9e2:
	bl.d L_92db88
L_92c9e6:
	mov_s r2,0x1
L_92c9e8:
	bl L_930d44
L_92c9ec:
	bl L_928a48
L_92c9f0:
	ld_s r0,[r13]
L_92c9f2:
	brne_s r0,0,L_92ca02
L_92c9f4:
	bl L_924f28
L_92c9f8:
	brne r0,0x1,L_92ca02
L_92c9fc:
	bl L_9364c8
L_92ca00:
	st_s r0,[r13]
	.global L_92ca02
L_92ca02:
	ldw_s r0,[gp,0x94]
L_92ca04:
	breq r0,0x0,L_92cacc
L_92ca08:
	ld_s r0,[gp,-0x34]
L_92ca0a:
	brne r0,0x2,L_92cacc
L_92ca0e:
	mov_s r0,0x80141c
L_92ca14:
	ld_s r0,[r0,0x8]
L_92ca16:
	bbit1 r0,0x0,L_92cacc
L_92ca1a:
	mov_s r14,0x80212c
L_92ca20:
	ldb r0,[r14, 0x68]
L_92ca24:
	breq r0,0x0,L_92cacc
L_92ca28:
	mov_s r1,0x801c18
L_92ca2e:
	ld_s r0,[r1]
L_92ca30:
	bl.d L_924818
L_92ca34:
	ld_s r1,[r1,0x4]
L_92ca36:
	ld_s r2,[r13,0x10]
L_92ca38:
	brhs r2,r0,L_92cacc
L_92ca3c:
	ldb r0,[r14, 0x68]
L_92ca40:
	norm r0,r0
L_92ca44:
	rsub r1,r0,0x1e
L_92ca48:
	asl_s r0,r1,0x2
L_92ca4a:
	add2_s r0,r0,r0
L_92ca4c:
	add_s r0,r0,0x857e38
L_92ca52:
	ldb_s r2,[r0,0x11]
L_92ca54:
	brne r2,0x0,L_92cacc
L_92ca58:
	bset_s r2,r2,0x2
L_92ca5a:
	stb_s r2,[r0,0x11]
L_92ca5c:
	bl.d L_92f4bc
L_92ca60:
	mov_s r0,0x2
L_92ca62:
	b_s L_92cacc
	.global L_92ca64
L_92ca64:
	mov_s r0,0xcafcaf
L_92ca6a:
	mov_s r32,r0
L_92ca6c:
	st.ab r0,[r25,0x4]
L_92ca70:
	bclr r25,r25,0xa
L_92ca74:
	mov_s r0,0x886d80
L_92ca7a:
	ld_s r13,[r0,0x54]
L_92ca7c:
	or r0,r13,0xf000
L_92ca84:
	mov_s r32,r0
L_92ca86:
	st.ab r0,[r25,0x4]
L_92ca8a:
	bclr r25,r25,0xa
	.global L_92ca8e
L_92ca8e:
	bbit0 r13,0x0,L_92ca9a
L_92ca92:
	bl.d L_927378
L_92ca96:
	bclr_s r13,r13,0x0
L_92ca98:
	b_s L_92cabe
	.global L_92ca9a
L_92ca9a:
	bbit0 r13,0x1,L_92caa6
L_92ca9e:
	bl.d L_9274e0
L_92caa2:
	bclr_s r13,r13,0x1
L_92caa4:
	b_s L_92cabe
	.global L_92caa6
L_92caa6:
	bbit0 r13,0x2,L_92cab2
L_92caaa:
	bl.d L_9274f4
L_92caae:
	bclr_s r13,r13,0x2
L_92cab0:
	b_s L_92cabe
	.global L_92cab2
L_92cab2:
	mov_s r0,blink
L_92cab4:
	mov_s r1,0x1315
L_92caba:
	bl L_926618
	.global L_92cabe
L_92cabe:
	brne_s r13,0,L_92ca8e
L_92cac0:
	b_s L_92cacc
	.global L_92cac2
L_92cac2:
	bl L_92cae0
L_92cac6:
	b_s L_92cacc
	.global L_92cac8
L_92cac8:
	bl L_92cd0c
	.global L_92cacc
L_92cacc:
	b L_9202a4
	.global L_92cad0
L_92cad0:
	mov_s r0,blink
L_92cad2:
	mov_s r1,0x1313
L_92cad8:
	bl L_926618
L_92cadc:
	b_s L_92c996
L_92cade:
	nop_s
