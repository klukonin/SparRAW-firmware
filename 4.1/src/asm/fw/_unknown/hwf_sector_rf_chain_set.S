/* hwf_sector_rf_chain_set @ 0x8d47f0, 504 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_sector_rf_chain_set(): sector_num=%d, is_tx_sector=%d, chain_num=%d
 *   hwf_sector_rf_chain_set(): edge_gain=%d, edge_phase=%d, dist_gain=%d
 *   hwf_sector_rf_chain_set(): dist_num=%d, is_x16_on=%d, activate_sector=%d
 *   hwf_sector_rf_chain_set(): sector# %d was activated (settings applied to current RF chain HW)
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, fw_log__emit1, fw_log__emit3, hwd_rfc__read_sector_chain, hwd_rfc__read_sector_reg, hwd_rfc_sector_dist_gain_set, hwd_rfc_sector_edge_gain_set, hwd_rfc_sector_edge_phase_set, hwd_rfc_sector_x16_state_set, rf_sector_commit_rx, rf_sector_commit_tx
 */
	.section .text.hwf_sector_rf_chain_set,"ax",@progbits
	.global hwf_sector_rf_chain_set
hwf_sector_rf_chain_set:
	.global L_8d47f0
L_8d47f0:
	push_s blink
L_8d47f2:
	bl L_8c02a0
L_8d47f6:
	sub_s sp,sp,0x14
L_8d47f8:
	mov_s r20,r0
L_8d47fa:
	mov_s r19,r1
L_8d47fc:
	mov_s r18,r2
L_8d47fe:
	mov_s r21,r3
L_8d4800:
	st r4,[sp, 0x4]
L_8d4804:
	st r5,[sp, 0x8]
L_8d4808:
	st r6,[sp, 0xc]
L_8d480c:
	st r7,[sp]
L_8d4810:
	mov r22,0x0
L_8d4814:
	bl.d L_8d0960
L_8d4818:
	mov r5,r22
L_8d481c:
	ld r4,[sp, 0x8]
L_8d4820:
	mov_s r0,r20
L_8d4822:
	mov_s r1,r19
L_8d4824:
	mov_s r2,r18
L_8d4826:
	mov_s r3,r21
L_8d4828:
	bl.d L_8d0b58
L_8d482c:
	mov r5,r22
L_8d4830:
	ld_s r0,[sp,0xc]
L_8d4832:
	asr r15,r21,0x2
L_8d4836:
	extb_s r15,r15
L_8d4838:
	brne r0,0x0,L_8d48b6
L_8d483c:
	mov_s r3,r21
L_8d483e:
	bic r3,r3,-0xfd
L_8d4842:
	add_s r14,r3,0x1
L_8d4844:
	extb_s r14,r14
L_8d4846:
	add_s r13,r14,0x1
L_8d4848:
	extb_s r13,r13
L_8d484a:
	add r16,r13,0x1
L_8d484e:
	extb r16,r16
L_8d4852:
	breq r3,r21,L_8d4862
L_8d4856:
	mov_s r0,r20
L_8d4858:
	mov_s r1,r19
L_8d485a:
	bl.d L_8d08bc
L_8d485e:
	mov_s r2,r18
L_8d4860:
	mov_s r22,r0
	.global L_8d4862
L_8d4862:
	cmp_s r14,r21
L_8d4864:
	mov.eq r17,0x0
L_8d4868:
	beq_s L_8d4878
L_8d486a:
	mov_s r0,r20
L_8d486c:
	mov_s r1,r19
L_8d486e:
	mov_s r2,r18
L_8d4870:
	bl.d L_8d08bc
L_8d4874:
	mov_s r3,r14
L_8d4876:
	mov_s r17,r0
	.global L_8d4878
L_8d4878:
	cmp_s r13,r21
L_8d487a:
	mov.eq r13,0x0
L_8d487e:
	beq_s L_8d488e
L_8d4880:
	mov_s r0,r20
L_8d4882:
	mov_s r1,r19
L_8d4884:
	mov_s r2,r18
L_8d4886:
	bl.d L_8d08bc
L_8d488a:
	mov_s r3,r13
L_8d488c:
	mov_s r13,r0
	.global L_8d488e
L_8d488e:
	cmp r21,r16
L_8d4892:
	mov_s r0,0x0
L_8d4894:
	mov.ne r0,r20
L_8d4898:
	mov.ne r1,r19
L_8d489c:
	mov.ne r2,r18
L_8d48a0:
	bl.ne.d L_8d08bc
L_8d48a4:
	mov.ne r3,r16
L_8d48a8:
	add r1,r17,r22
L_8d48ac:
	add_s r1,r1,r13
L_8d48ae:
	add.f 0x0,r1,r0
L_8d48b2:
	bpnz L_8d48ca
	.global L_8d48b6
L_8d48b6:
	ld r4,[sp, 0xc]
L_8d48ba:
	mov_s r0,r20
L_8d48bc:
	mov_s r1,r19
L_8d48be:
	mov_s r2,r18
L_8d48c0:
	mov_s r3,r15
L_8d48c2:
	bl.d L_8d0800
L_8d48c6:
	mov r5,0x0
	.global L_8d48ca
L_8d48ca:
	ld_s r0,[sp,0xc]
L_8d48cc:
	cmp_s r0,0x0
L_8d48ce:
	mov.ne r0,0x1
L_8d48d2:
	st_s r0,[sp,0x10]
L_8d48d4:
	asr_s r0,r15,0x2
L_8d48d6:
	extb r23,r0
L_8d48da:
	ld_s r0,[sp,0xc]
L_8d48dc:
	brne r0,0x0,L_8d4960
L_8d48e0:
	mov_s r3,r15
L_8d48e2:
	bic r3,r3,-0xfd
L_8d48e6:
	add_s r14,r3,0x1
L_8d48e8:
	extb_s r14,r14
L_8d48ea:
	add_s r13,r14,0x1
L_8d48ec:
	extb_s r13,r13
L_8d48ee:
	add r22,r13,0x1
L_8d48f2:
	extb r22,r22
L_8d48f6:
	mov_s r0,0x0
L_8d48f8:
	cmp_s r3,r21
L_8d48fa:
	mov.ne r0,r20
L_8d48fe:
	mov.ne r1,r19
L_8d4902:
	bl.ne.d L_8d07c8
L_8d4906:
	mov.ne r2,r18
L_8d490a:
	cmp_s r14,r21
L_8d490c:
	mov_s r17,r0
L_8d490e:
	mov.eq r16,0x0
L_8d4912:
	beq_s L_8d4922
L_8d4914:
	mov_s r0,r20
L_8d4916:
	mov_s r1,r19
L_8d4918:
	mov_s r2,r18
L_8d491a:
	bl.d L_8d07c8
L_8d491e:
	mov_s r3,r14
L_8d4920:
	mov_s r16,r0
	.global L_8d4922
L_8d4922:
	cmp_s r13,r21
L_8d4924:
	mov.eq r13,0x0
L_8d4928:
	beq_s L_8d4938
L_8d492a:
	mov_s r0,r20
L_8d492c:
	mov_s r1,r19
L_8d492e:
	mov_s r2,r18
L_8d4930:
	bl.d L_8d07c8
L_8d4934:
	mov_s r3,r13
L_8d4936:
	mov_s r13,r0
	.global L_8d4938
L_8d4938:
	cmp r21,r22
L_8d493c:
	mov_s r0,0x0
L_8d493e:
	mov.ne r0,r20
L_8d4942:
	mov.ne r1,r19
L_8d4946:
	mov.ne r2,r18
L_8d494a:
	bl.ne.d L_8d07c8
L_8d494e:
	mov.ne r3,r22
L_8d4952:
	add r1,r16,r17
L_8d4956:
	add_s r1,r1,r13
L_8d4958:
	add.f 0x0,r1,r0
L_8d495c:
	bpnz L_8d4974
	.global L_8d4960
L_8d4960:
	ld r4,[sp, 0x10]
L_8d4964:
	mov_s r0,r20
L_8d4966:
	mov_s r1,r19
L_8d4968:
	mov_s r2,r18
L_8d496a:
	mov_s r3,r23
L_8d496c:
	bl.d L_8d0cf8
L_8d4970:
	mov r5,0x0
	.global L_8d4974
L_8d4974:
	mov_s r2,0x1016c74
L_8d497a:
	mov_s r0,0x0
L_8d497c:
	mov_s r1,0x2
L_8d497e:
	mov_s r3,r19
L_8d4980:
	mov r4,r18
L_8d4984:
	bl.d L_8ee034
L_8d4988:
	mov r5,r21
L_8d498c:
	ld_s r3,[sp,0x4]
L_8d498e:
	mov_s r2,0x1016cbc
L_8d4994:
	ld r4,[sp, 0x8]
L_8d4998:
	mov_s r0,0x0
L_8d499a:
	mov_s r1,0x2
L_8d499c:
	bl.d L_8ee034
L_8d49a0:
	ld r5,[sp, 0xc]
L_8d49a4:
	mov_s r2,0x1016d04
L_8d49aa:
	ld r4,[sp, 0x10]
L_8d49ae:
	mov_s r0,0x0
L_8d49b0:
	mov_s r1,0x2
L_8d49b2:
	mov_s r3,r15
L_8d49b4:
	bl.d L_8ee034
L_8d49b8:
	ld r5,[sp]
L_8d49bc:
	ld_s r0,[sp,0x0]
L_8d49be:
	breq_s r0,0,L_8d49e2
L_8d49c0:
	mov_s r0,r20
L_8d49c2:
	mov_s r1,r19
L_8d49c4:
	breq r18,0x0,L_8d49ce
L_8d49c8:
	bl L_8d0ef4
L_8d49cc:
	b_s L_8d49d2
	.global L_8d49ce
L_8d49ce:
	bl L_8d073c
	.global L_8d49d2
L_8d49d2:
	mov_s r2,0x1016d50
L_8d49d8:
	mov_s r0,0x0
L_8d49da:
	mov_s r1,0x2
L_8d49dc:
	bl.d L_8edfcc
L_8d49e0:
	mov_s r3,r19
	.global L_8d49e2
L_8d49e2:
	b.d L_8c02ec
L_8d49e6:
	add_s sp,sp,0x14
