/* pcie__l1_latency_wa @ 0x8ed7b4, 536 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Setting L1 enter latency to 16us - EP under switch
 *   Setting L1 enter latency to 16us - EP under serdes
 *   BUG_5663_WA Disabling L0s - EP under switch
 *   BUG_5663_WA Disabling L0s - EP under serdes
 *   Setting low power entrence count to 0x20 - EP under switch
 *   Setting low power entrence count to 0x20 - EP under serdes
 * Зовут его: isr16__pcie_l1_latency_wa
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, dbi_write, fw_log_emit0, hwd_pcie__is_ep_under_serdes, hwd_pcie__read_8825c0, hwd_pcie_l1_sub_timing_config, low_sme__termination_check, pcie__bits_set32_s27_w5, pcie__dbi_read, pcie__set_l1_bit11
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__l1_latency_wa
pcie__l1_latency_wa:
	.global L_8ed7b4
L_8ed7b4:
	push_s blink
L_8ed7b6:
	bl L_8c01dc
L_8ed7ba:
	bl.d L_8d1470
L_8ed7be:
	sub_s sp,sp,0x14
L_8ed7c0:
	bl.d L_8d141c
L_8ed7c4:
	mov_s r13,r0
L_8ed7c6:
	lsr_s r0,r0
L_8ed7c8:
	bmsk_s r0,r0,0x0
L_8ed7ca:
	or.f 0x0,r0,r13
L_8ed7ce:
	mov_s r14,0x0
L_8ed7d0:
	beq_s L_8ed810
L_8ed7d2:
	add r16,sp,0x4
L_8ed7d6:
	mov_s r0,0x40
L_8ed7d8:
	mov_s r1,r14
L_8ed7da:
	mov_s r2,0x1
L_8ed7dc:
	mov_s r3,r14
L_8ed7de:
	mov_s r4,r14
L_8ed7e0:
	mov_s r5,r2
L_8ed7e2:
	bl.d L_8c8208
L_8ed7e6:
	mov r6,r16
L_8ed7ea:
	mov_s r0,r16
L_8ed7ec:
	mov_s r1,r14
L_8ed7ee:
	bl.d L_8ed49c
L_8ed7f2:
	mov_s r2,r14
L_8ed7f4:
	st_s r14,[sp,0x0]
L_8ed7f6:
	mov_s r0,0x40
L_8ed7f8:
	ld_s r1,[sp,0x4]
L_8ed7fa:
	mov_s r3,0x1
L_8ed7fc:
	mov_s r4,r14
L_8ed7fe:
	mov_s r5,r14
L_8ed800:
	mov r6,0x1
L_8ed804:
	bl.d L_8c8338
L_8ed808:
	mov r7,0x1
L_8ed80c:
	bl L_8d169c
	.global L_8ed810
L_8ed810:
	mov_s r15,0xc7ffffff
L_8ed816:
	add r16,sp,0xc
L_8ed81a:
	brne_s r13,0,L_8ed854
L_8ed81c:
	mov_s r1,0x10014f8
L_8ed822:
	bl.d L_8dcba8
L_8ed826:
	mov_s r0,0x20
L_8ed828:
	mov r0,0x70c
L_8ed82c:
	mov_s r1,0x0
L_8ed82e:
	mov_s r2,r1
L_8ed830:
	mov_s r3,r1
L_8ed832:
	mov_s r4,r1
L_8ed834:
	mov r5,0x1
L_8ed838:
	bl.d L_8c8208
L_8ed83c:
	mov r6,r16
L_8ed840:
	ld_s r1,[sp,0xc]
L_8ed842:
	st_s r14,[sp,0x0]
L_8ed844:
	and_s r1,r1,r15
L_8ed846:
	bset_s r1,r1,0x1d
L_8ed848:
	st_s r1,[sp,0xc]
L_8ed84a:
	mov r0,0x70c
L_8ed84e:
	mov_s r2,0x0
L_8ed850:
	mov_s r3,0x0
L_8ed852:
	b_s L_8ed888
	.global L_8ed854
L_8ed854:
	mov_s r1,0x100152c
L_8ed85a:
	bl.d L_8dcba8
L_8ed85e:
	mov_s r0,0x20
L_8ed860:
	mov r0,0x70c
L_8ed864:
	mov_s r1,0x0
L_8ed866:
	mov_s r2,0x1
L_8ed868:
	mov_s r3,r1
L_8ed86a:
	mov_s r4,r1
L_8ed86c:
	mov_s r5,r2
L_8ed86e:
	bl.d L_8c8208
L_8ed872:
	mov r6,r16
L_8ed876:
	ld_s r1,[sp,0xc]
L_8ed878:
	st_s r14,[sp,0x0]
L_8ed87a:
	and_s r1,r1,r15
L_8ed87c:
	bset_s r1,r1,0x1d
L_8ed87e:
	st_s r1,[sp,0xc]
L_8ed880:
	mov r0,0x70c
L_8ed884:
	mov_s r2,0x0
L_8ed886:
	mov_s r3,0x1
	.global L_8ed888
L_8ed888:
	mov r4,0x0
L_8ed88c:
	mov r5,r4
L_8ed890:
	mov r6,0x1
L_8ed894:
	bl.d L_8c8338
L_8ed898:
	mov r7,r6
L_8ed89c:
	brne_s r13,0,L_8ed8da
L_8ed89e:
	mov_s r1,0x1001560
L_8ed8a4:
	bl.d L_8dcba8
L_8ed8a8:
	mov_s r0,0x20
L_8ed8aa:
	st_s r14,[sp,0x10]
L_8ed8ac:
	add r16,sp,0x10
L_8ed8b0:
	mov_s r0,0x7c
L_8ed8b2:
	mov_s r1,0x0
L_8ed8b4:
	mov_s r2,0x0
L_8ed8b6:
	mov_s r3,0x0
L_8ed8b8:
	mov r4,0x0
L_8ed8bc:
	mov r5,0x1
L_8ed8c0:
	bl.d L_8c8208
L_8ed8c4:
	mov r6,r16
L_8ed8c8:
	bl.d L_8f8f50
L_8ed8cc:
	mov_s r0,r16
L_8ed8ce:
	ld_s r1,[sp,0x10]
L_8ed8d0:
	st_s r14,[sp,0x0]
L_8ed8d2:
	mov_s r0,0x7c
L_8ed8d4:
	mov_s r2,0x0
L_8ed8d6:
	mov_s r3,0x0
L_8ed8d8:
	b_s L_8ed914
	.global L_8ed8da
L_8ed8da:
	mov_s r1,0x100158c
L_8ed8e0:
	bl.d L_8dcba8
L_8ed8e4:
	mov_s r0,0x20
L_8ed8e6:
	st_s r14,[sp,0x10]
L_8ed8e8:
	add r16,sp,0x10
L_8ed8ec:
	mov_s r0,0x7c
L_8ed8ee:
	mov_s r1,0x0
L_8ed8f0:
	mov_s r2,0x1
L_8ed8f2:
	mov_s r3,0x0
L_8ed8f4:
	mov r4,0x0
L_8ed8f8:
	mov r5,0x1
L_8ed8fc:
	bl.d L_8c8208
L_8ed900:
	mov r6,r16
L_8ed904:
	bl.d L_8f8f50
L_8ed908:
	mov_s r0,r16
L_8ed90a:
	ld_s r1,[sp,0x10]
L_8ed90c:
	st_s r14,[sp,0x0]
L_8ed90e:
	mov_s r0,0x7c
L_8ed910:
	mov_s r2,0x0
L_8ed912:
	mov_s r3,0x1
	.global L_8ed914
L_8ed914:
	mov r4,0x0
L_8ed918:
	mov r5,r4
L_8ed91c:
	mov r6,0x1
L_8ed920:
	bl.d L_8c8338
L_8ed924:
	mov r7,r6
L_8ed928:
	st_s r14,[sp,0x10]
L_8ed92a:
	add r16,sp,0x10
L_8ed92e:
	brne_s r13,0,L_8ed96a
L_8ed930:
	mov_s r1,0x10015b8
L_8ed936:
	bl.d L_8dcba8
L_8ed93a:
	mov_s r0,0x20
L_8ed93c:
	mov r0,0x708
L_8ed940:
	mov_s r1,0x0
L_8ed942:
	mov_s r2,0x0
L_8ed944:
	mov_s r3,0x0
L_8ed946:
	mov r4,0x0
L_8ed94a:
	mov r5,0x1
L_8ed94e:
	bl.d L_8c8208
L_8ed952:
	mov r6,r16
L_8ed956:
	ld_s r1,[sp,0x10]
L_8ed958:
	st_s r14,[sp,0x0]
L_8ed95a:
	bmsk_s r1,r1,0x17
L_8ed95c:
	bset_s r1,r1,0x1d
L_8ed95e:
	st_s r1,[sp,0x10]
L_8ed960:
	mov r0,0x708
L_8ed964:
	mov_s r2,0x0
L_8ed966:
	mov_s r3,0x0
L_8ed968:
	b_s L_8ed9a2
	.global L_8ed96a
L_8ed96a:
	mov_s r1,0x10015f4
L_8ed970:
	bl.d L_8dcba8
L_8ed974:
	mov_s r0,0x20
L_8ed976:
	mov r0,0x708
L_8ed97a:
	mov_s r1,0x0
L_8ed97c:
	mov_s r2,0x1
L_8ed97e:
	mov_s r3,0x0
L_8ed980:
	mov r4,0x0
L_8ed984:
	mov r5,0x1
L_8ed988:
	bl.d L_8c8208
L_8ed98c:
	mov r6,r16
L_8ed990:
	ld_s r1,[sp,0x10]
L_8ed992:
	st_s r14,[sp,0x0]
L_8ed994:
	bmsk_s r1,r1,0x17
L_8ed996:
	bset_s r1,r1,0x1d
L_8ed998:
	st_s r1,[sp,0x10]
L_8ed99a:
	mov r0,0x708
L_8ed99e:
	mov_s r2,0x0
L_8ed9a0:
	mov_s r3,0x1
	.global L_8ed9a2
L_8ed9a2:
	mov r4,0x0
L_8ed9a6:
	mov r5,r4
L_8ed9aa:
	mov r6,0x1
L_8ed9ae:
	bl.d L_8c8338
L_8ed9b2:
	mov r7,r6
L_8ed9b6:
	b.d L_8c0244
L_8ed9ba:
	add_s sp,sp,0x14
L_8ed9bc:
	j_s.d [blink]
L_8ed9be:
	mov_s r0,0x0
L_8ed9c0:
	j_s [blink]
L_8ed9c2:
	nop_s
L_8ed9c4:
	b.d L_8e9110
L_8ed9c8:
	mov_s r0,0x1
L_8ed9ca:
	nop_s
