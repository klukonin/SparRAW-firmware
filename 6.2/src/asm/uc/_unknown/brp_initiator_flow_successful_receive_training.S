/* brp_initiator_flow_successful_receive_training @ 0x922824, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HH brp_initiator_flow_successful_receive_training rf_module %d was trained current mux status = 0x%08x
 *   HH brp_initiator_flow_successful_receive_training rf_module %d
 * Зовут его: brp_initiator_brp_transaction_flow
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, brp__bits_uc_set32_s1_w8, rf_utils__auto_fill_with_byte, rfc__clear_core_reg1, rfca__get_rf_mask_uc, rfca__select_rf_uc, uc_log__emit1, uc_log__emit2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp_initiator_flow_successful_receive_training
brp_initiator_flow_successful_receive_training:
	.global L_922824
L_922824:
	push_s blink
L_922826:
	bl L_920228
L_92282a:
	sub_s sp,sp,0x4
L_92282c:
	bl.d L_928c68
L_922830:
	mov_s r16,r0
L_922832:
	st_s r0,[sp,0x0]
L_922834:
	mov_s r13,0x0
L_922836:
	bset r13,r13,r16
L_92283a:
	extb_s r15,r13
L_92283c:
	mov_s r0,r15
L_92283e:
	bl.d L_928b8c
L_922842:
	mov_s r1,0x0
L_922844:
	mov_s r14,0x800824
L_92284a:
	ld_s r0,[r14,0x4c]
L_92284c:
	ld_s r1,[r14,0x50]
L_92284e:
	bic_s r0,r0,r13
L_922850:
	st_s r0,[r14,0x4c]
L_922852:
	lsr_s r1,r1
L_922854:
	or_s r1,r1,r13
L_922856:
	extb_s r1,r1
L_922858:
	add3 r0,r14,0xa
L_92285c:
	bl L_93e3c0
L_922860:
	bl L_928c68
L_922864:
	mov_s r1,0x10009d8
L_92286a:
	mov_s r3,r0
L_92286c:
	mov_s r0,0x20
L_92286e:
	bl.d L_92d27c
L_922872:
	mov_s r2,r16
L_922874:
	mov r17,0x8006b4
L_92287c:
	ldb r0,[r17, 0x5]
L_922880:
	tst_s r0,r15
L_922882:
	ld_s r0,[r14,0x4c]
L_922884:
	cmp.ne r0,0x0
L_922888:
	beq_s L_9228a0
L_92288a:
	mov_s r1,0x1000a40
L_922890:
	mov_s r0,0x20
L_922892:
	bl.d L_92d1d0
L_922896:
	mov_s r2,r16
L_922898:
	mov_s r0,r15
L_92289a:
	bl.d L_92f160
L_92289e:
	mov_s r1,0x1
	.global L_9228a0
L_9228a0:
	ld_s r0,[r14,0x4c]
L_9228a2:
	brne_s r0,0,L_9228aa
L_9228a4:
	ld_s r0,[r14,0x50]
L_9228a6:
	bclr_s r0,r0,0x0
L_9228a8:
	st_s r0,[r14,0x50]
	.global L_9228aa
L_9228aa:
	mov_s r1,0x801ed4
L_9228b0:
	ldw_s r0,[r1,0x10]
L_9228b2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9228b4:
	extw_s r0,r0
L_9228b6:
	stw_s r0,[r1,0x10]
L_9228b8:
	ldb r0,[r17, 0x5]
L_9228bc:
	tst_s r0,r13
L_9228be:
	bl.eq.d L_929f94
L_9228c2:
	mov.eq r0,0x0
L_9228c6:
	ld_s r0,[sp,0x0]
L_9228c8:
	bl.d L_928b8c
L_9228cc:
	mov_s r1,0x0
L_9228ce:
	b.d L_92028c
L_9228d2:
	add_s sp,sp,0x4
