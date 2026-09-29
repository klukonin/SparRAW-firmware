/* l1_fixed_sched_ap__ev4_state4 @ 0x938880, 408 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap_sm
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bi__tsf_delta64, dma_is_tx_pipe_idle, fixed_sched__run_tx_slot, fixed_sched__slot_prepare, fixed_sched__slot_setup, fsched__arm_slot_timer, fsched__cur_entry_byte0, fsched__drop_station, fsched__get_cur_idx, fsched__slot_half4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_fixed_sched_ap__ev4_state4
l1_fixed_sched_ap__ev4_state4:
	.global L_938880
L_938880:
	push_s blink
L_938882:
	bl L_920224
L_938886:
	sub_s sp,sp,0xc
L_938888:
	bl.d L_9356cc
L_93888c:
	add_s r0,sp,0x4
L_93888e:
	mov_s r14,0x801be8
L_938894:
	bl.d L_927d54
L_938898:
	mov_s r0,r14
L_93889a:
	mov_s r15,r0
L_93889c:
	bl.d L_93d1ec
L_9388a0:
	mov_s r0,r14
L_9388a2:
	ldb_s r0,[gp,-0xee]
L_9388a4:
	mov r18,0x8007d4
L_9388ac:
	add2 r1,r18,r0
L_9388b0:
	stb_s r15,[r1,0x3]
L_9388b2:
	bl.d L_927d5c
L_9388b6:
	mov_s r0,r14
L_9388b8:
	bl.d L_9351ec
L_9388bc:
	mov_s r16,r0
L_9388be:
	bl.d L_92ec28
L_9388c2:
	mov_s r0,r14
L_9388c4:
	bl L_93768c
L_9388c8:
	mov_s r13,0x800814
L_9388ce:
	ldw_s r0,[r13]
L_9388d0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9388d2:
	stw_s r0,[r13]
L_9388d4:
	bl.d L_927dbc
L_9388d8:
	mov_s r0,r14
L_9388da:
	st_s r0,[sp,0x0]
L_9388dc:
	ldb r0,[r14, 0x2d]
L_9388e0:
	cmp_s r0,0x0
L_9388e2:
	bl.ne.d L_93cc24
L_9388e6:
	mov.ne r0,r14
L_9388ea:
	b_s L_9388f8
	.global L_9388ec
L_9388ec:
	bl.d L_9351ec
L_9388f0:
	sub r0,r16,r2
L_9388f4:
	bl L_93768c
	.global L_9388f8
L_9388f8:
	ld_s r0,[sp,0x0]
L_9388fa:
	mov_s r1,0x0
L_9388fc:
	bl.d L_926184
L_938900:
	mov_s r2,0xf
L_938902:
	brne_s r0,0,L_938926
L_938904:
	ld_s r0,[sp,0x4]
L_938906:
	bl.d L_924818
L_93890a:
	ld_s r1,[sp,0x8]
L_93890c:
	mov_s r2,r0
L_93890e:
	sub2 r0,r16,0x19
L_938912:
	brlo r2,r0,L_9388ec
L_938916:
	mov r16,0x1
L_93891a:
	mov_s r0,0x0
L_93891c:
	bl.d L_93cfdc
L_938920:
	ld_s r1,[sp,0x0]
L_938922:
	mov_s r0,r16
L_938924:
	b_s L_938928
	.global L_938926
L_938926:
	mov_s r0,0x0
	.global L_938928
L_938928:
	mov_s r17,r0
L_93892a:
	bl.d L_9290bc
L_93892e:
	ld_s r0,[sp,0x0]
L_938930:
	extw_s r1,r0
L_938932:
	stw_s r0,[r13,0x6]
L_938934:
	ldw_s r0,[r13,0x4]
L_938936:
	sub r16,r1,r0
L_93893a:
	ldw_s r0,[r13,0xc]
L_93893c:
	extw r16,r16
L_938940:
	add_s r0,r0,r16
L_938942:
	stw_s r0,[r13,0xc]
L_938944:
	breq r17,0x0,L_9389ce
L_938948:
	bl.d L_927dbc
L_93894c:
	mov_s r0,r14
L_93894e:
	mov_s r2,0x802948
L_938954:
	ld_s r1,[r2]
L_938956:
	stw r16,[r13, 0x8]
L_93895a:
	bset r1,r1,r0
L_93895e:
	st_s r1,[r2]
L_938960:
	ldb r1,[gp, -0xee]
L_938964:
	mov_s r2,0xb
L_938966:
	add2 r0,r18,r1
L_93896a:
	stb_s r2,[r0,0x2]
L_93896c:
	ld_s r0,[sp,0x0]
L_93896e:
	mov_s r1,0x0
L_938970:
	ldw_s r14,[r13,0x6]
L_938972:
	mov_s r2,r0
L_938974:
	bl.d L_925c8c
L_938978:
	mov_s r3,r15
L_93897a:
	bl.d L_9290bc
L_93897e:
	ld_s r0,[sp,0x0]
L_938980:
	ldw_s r1,[r13,0x2]
L_938982:
	sub_s r0,r0,r14
L_938984:
	extw_s r0,r0
L_938986:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_938988:
	stw_s r1,[r13,0x2]
L_93898a:
	ldw_s r1,[r13,0xe]
L_93898c:
	stw_s r0,[r13,0xa]
L_93898e:
	add_s r0,r0,r1
L_938990:
	stw_s r0,[r13,0xe]
L_938992:
	brne r16,0x0,L_9389c6
L_938996:
	mov_s r2,0x0
L_938998:
	mov_s r1,0x857200
L_93899e:
	ld_s r0,[r1,0x48]
L_9389a0:
	bset r2,r2,r15
L_9389a4:
	or_s r0,r0,r2
L_9389a6:
	mov_s r13,0x80064c
L_9389ac:
	add_s r3,r13,r15
L_9389ae:
	st_s r0,[r1,0x48]
L_9389b0:
	ldb_s r0,[r3,0x10]
L_9389b2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9389b4:
	extb_s r0,r0
L_9389b6:
	stb_s r0,[r3,0x10]
L_9389b8:
	ldb_s r3,[r13,0x18]
L_9389ba:
	brlt r0,r3,L_9389dc
L_9389be:
	ld_s r0,[r1,0x4c]
L_9389c0:
	or_s r0,r0,r2
L_9389c2:
	st_s r0,[r1,0x4c]
L_9389c4:
	b_s L_9389dc
	.global L_9389c6
L_9389c6:
	bl.d L_92ed00
L_9389ca:
	mov_s r0,r15
L_9389cc:
	b_s L_9389dc
	.global L_9389ce
L_9389ce:
	bl.d L_92ed00
L_9389d2:
	mov_s r0,r15
L_9389d4:
	ld_s r0,[sp,0x0]
L_9389d6:
	bl.d L_925b50
L_9389da:
	mov_s r1,0x0
	.global L_9389dc
L_9389dc:
	bl L_9364c8
L_9389e0:
	mov_s r1,0x80064c
L_9389e6:
	ld_s r2,[r1,0x8]
L_9389e8:
	st_s r0,[r1,0xc]
L_9389ea:
	cmp_s r0,r2
L_9389ec:
	sub.hi r0,r0,r2
L_9389f0:
	bhi_s L_9389fc
L_9389f2:
	rsub r1,r2,0xffffffff
L_9389fa:
	add_s r0,r0,r1
	.global L_9389fc
L_9389fc:
	mov_s r2,0x857700
L_938a02:
	add2_s r2,r2,r15
L_938a04:
	ld_s r1,[r2,0x48]
L_938a06:
	add_s r0,r0,r1
L_938a08:
	st_s r0,[r2,0x48]
L_938a0a:
	bl.d L_925014
L_938a0e:
	mov_s r0,0x0
L_938a10:
	b.d L_920284
L_938a14:
	add_s sp,sp,0xc
L_938a16:
	nop_s
