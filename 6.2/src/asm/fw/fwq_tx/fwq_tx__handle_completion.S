/* fwq_tx__handle_completion @ 0x8cc7c4, 492 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FW RX PAYLOADS SHORTAGE - RING PENDED (%d) dma_handled %d.
 * Зовут его: fwq_tx__handle_completion_thunk
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r20_to_r13_ret, __ld_r21_to_r13_ret, __st_r20_to_r13, __st_r21_to_r13, fw_log_emit2, fw_sysassert_fatal, fwq_tx__count_below_limit, fwq_tx__get_count, hwd_dma__write_ring_reg, list__find_entry_d, llist__pop_front
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__handle_completion
fwq_tx__handle_completion:
	.global L_8cc7c4
L_8cc7c4:
	push_s blink
L_8cc7c6:
	bl L_8c01c8
L_8cc7ca:
	sub_s sp,sp,0xc
L_8cc7cc:
	mov_s r14,r0
L_8cc7ce:
	mov_s r21,r1
L_8cc7d0:
	mov r17,0x0
L_8cc7d4:
	mov r20,0x1
L_8cc7d8:
	ld_s r0,[r0,0x10]
L_8cc7da:
	mov_s r12,0x1
L_8cc7dc:
	asl r0,r12,r0
L_8cc7e0:
	bl.d L_8d04d8
L_8cc7e4:
	mov_s r1,r17
L_8cc7e6:
	mov_s r0,r14
L_8cc7e8:
	bl.d L_8cc1ec
L_8cc7ec:
	ld_s r1,[r14,0x8]
L_8cc7ee:
	mov_s r13,r0
L_8cc7f0:
	mov r16,r17
L_8cc7f4:
	b_s L_8cc8a6
	.global L_8cc7f6
L_8cc7f6:
	st r17,[r14, 0x14]
L_8cc7fa:
	ld_s r0,[r13,0x14]
L_8cc7fc:
	mov_s r15,sp
L_8cc7fe:
	bset r19,r0,0x12
L_8cc802:
	bset.f r19,r19,0x17
L_8cc806:
	mov.eq r0,blink
L_8cc80a:
	mov.eq r1,0x2
L_8cc80e:
	bl.eq.d L_8c9b28
L_8cc812:
	bset.eq r1,r1,0xc
L_8cc816:
	st r19,[r15, 0x4]
L_8cc81a:
	sub r0,r19,0x38
L_8cc81e:
	st_s r0,[r15]
L_8cc820:
	sub r0,r19,0x10
L_8cc824:
	st_s r0,[r15,0x8]
L_8cc826:
	ldb_s r0,[r13,0x1d]
L_8cc828:
	ld_s r15,[sp,0x0]
L_8cc82a:
	lsr_s r0,r0,0x2
L_8cc82c:
	bmsk_s r0,r0,0x0
L_8cc82e:
	stw_s r0,[r15,0x2e]
L_8cc830:
	ldw_s r0,[r13,0x1e]
L_8cc832:
	add r18,r15,0x20
L_8cc836:
	st_s r0,[r15,0x30]
L_8cc838:
	ld_s r0,[r13,0x4]
L_8cc83a:
	lsr_s r0,r0,0x10
L_8cc83c:
	bmsk_s r0,r0,0x4
L_8cc83e:
	bl.d L_8cc158
L_8cc842:
	stb r0,[r18, 0x14]
L_8cc846:
	stb r0,[r18, 0x15]
L_8cc84a:
	ld_s r0,[r13]
L_8cc84c:
	lsr_s r0,r0,0x4
L_8cc84e:
	bmsk_s r0,r0,0x2
L_8cc850:
	stb r0,[r18, 0x16]
L_8cc854:
	ld_s r1,[r13,0x4]
L_8cc856:
	st r17,[r15, 0x10]
L_8cc85a:
	lsr_s r1,r1,0x15
L_8cc85c:
	bmsk_s r1,r1,0x3
L_8cc85e:
	stb r1,[r18, 0x8]
L_8cc862:
	st r19,[r15, 0x14]
L_8cc866:
	mov_s r0,r21
L_8cc868:
	bl.d L_8c25f4
L_8cc86c:
	mov_s r1,r15
L_8cc86e:
	bl.d L_8c3394
L_8cc872:
	add r16,r16,0x1
L_8cc876:
	bmsk_s r0,r0,0x11
L_8cc878:
	st_s r0,[r13,0x14]
L_8cc87a:
	ldb_s r0,[r13,0x1d]
L_8cc87c:
	add r1,r14,0x8
L_8cc880:
	bclr_s r0,r0,0x0
L_8cc882:
	stb_s r0,[r13,0x1d]
L_8cc884:
	bl.d L_8c7f00
L_8cc888:
	mov_s r0,r14
L_8cc88a:
	add r1,r14,0xc
L_8cc88e:
	bl.d L_8c7f00
L_8cc892:
	mov_s r0,r14
L_8cc894:
	ld_s r0,[r14,0x10]
L_8cc896:
	bl.d L_8d0c00
L_8cc89a:
	ld_s r1,[r14,0xc]
L_8cc89c:
	mov_s r0,r14
L_8cc89e:
	bl.d L_8cc1ec
L_8cc8a2:
	ld_s r1,[r14,0x8]
L_8cc8a4:
	mov_s r13,r0
	.global L_8cc8a6
L_8cc8a6:
	ldb_s r0,[r13,0x1d]
L_8cc8a8:
	bbit0 r0,0x0,L_8cc8cc
L_8cc8ac:
	bl L_8e3c48
L_8cc8b0:
	brne r0,0x0,L_8cc7f6
L_8cc8b4:
	bl L_8e3c64
L_8cc8b8:
	mov_s r1,0x1018ce4
L_8cc8be:
	mov_s r2,r0
L_8cc8c0:
	mov_s r0,0x27
L_8cc8c2:
	bl.d L_8dcc80
L_8cc8c6:
	mov_s r3,r16
L_8cc8c8:
	st r20,[r14, 0x14]
	.global L_8cc8cc
L_8cc8cc:
	ld_s r0,[r14,0x10]
L_8cc8ce:
	mov_s r12,0x1
L_8cc8d0:
	asl r0,r12,r0
L_8cc8d4:
	bl.d L_8d0508
L_8cc8d8:
	mov_s r1,0x0
L_8cc8da:
	b.d L_8c021c
L_8cc8de:
	add_s sp,sp,0xc
L_8cc8e0:
	push_s blink
L_8cc8e2:
	bl L_8c01cc
L_8cc8e6:
	sub_s sp,sp,0x8
L_8cc8e8:
	mov_s r16,r0
L_8cc8ea:
	mov_s r20,r1
L_8cc8ec:
	mov_s r19,r2
L_8cc8ee:
	ld_s r0,[r0,0x18]
L_8cc8f0:
	mov_s r12,0x1
L_8cc8f2:
	asl r0,r12,r0
L_8cc8f6:
	mov_s r1,0x0
L_8cc8f8:
	bl.d L_8d04d8
L_8cc8fc:
	mov_s r17,r1
L_8cc8fe:
	add r14,r16,0x4
L_8cc902:
	b_s L_8cc974
	.global L_8cc904
L_8cc904:
	bmsk r18,r1,0x2
L_8cc908:
	bclr_s r1,r1,0x8
L_8cc90a:
	ld_s r13,[r0,0x14]
L_8cc90c:
	st_s r1,[r0,0x1c]
L_8cc90e:
	st r17,[r0, 0x14]
L_8cc912:
	ld_s r0,[r0,0x10]
L_8cc914:
	bset_s r13,r13,0x12
L_8cc916:
	lsr_s r0,r0,0x10
L_8cc918:
	bmsk_s r0,r0,0x4
L_8cc91a:
	mov_s r15,sp
L_8cc91c:
	bset_s r13,r13,0x17
L_8cc91e:
	brne r0,0x19,L_8cc92a
L_8cc922:
	ld_s r0,[gp,-0x150]
L_8cc924:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cc926:
	st.as r0,[gp,-0x54]
	.global L_8cc92a
L_8cc92a:
	cmp_s r13,0x0
L_8cc92c:
	mov.eq r0,blink
L_8cc930:
	mov.eq r1,0x11e9
L_8cc938:
	bl.eq L_8c9b28
L_8cc93c:
	st_s r13,[r15,0x4]
L_8cc93e:
	sub r13,r13,0x24
L_8cc942:
	st_s r13,[r15]
L_8cc944:
	ld_s r13,[sp,0x0]
L_8cc946:
	stb r18,[r13, 0x11]
L_8cc94a:
	bl.d L_8e2674
L_8cc94e:
	mov_s r0,r19
L_8cc950:
	cmp_s r13,r0
L_8cc952:
	mov.ne r0,blink
L_8cc956:
	mov.ne r1,0x1228
L_8cc95e:
	bl.ne L_8c9b28
L_8cc962:
	mov_s r0,r20
L_8cc964:
	bl.d L_8c25f4
L_8cc968:
	mov_s r1,r13
L_8cc96a:
	add r1,r14,0x8
L_8cc96e:
	bl.d L_8c7f00
L_8cc972:
	mov_s r0,r14
	.global L_8cc974
L_8cc974:
	mov_s r0,r14
L_8cc976:
	bl.d L_8cc1ec
L_8cc97a:
	ld_s r1,[r14,0x8]
L_8cc97c:
	ld_s r1,[r0,0x1c]
L_8cc97e:
	bbit1 r1,0x8,L_8cc904
L_8cc982:
	ld r0,[r16, 0x18]
L_8cc986:
	mov_s r12,0x1
L_8cc988:
	asl r0,r12,r0
L_8cc98c:
	bl.d L_8d0508
L_8cc990:
	mov_s r1,0x0
L_8cc992:
	b.d L_8c0224
L_8cc996:
	add_s sp,sp,0x8
L_8cc998:
	push_s blink
L_8cc99a:
	push_s r13
L_8cc99c:
	ld r3,[r0, 0x8c]
L_8cc9a0:
	add r2,r0,0x34
L_8cc9a4:
	ld_s r0,[r3]
L_8cc9a6:
	ld_s r13,[r0,0xc]
L_8cc9a8:
	jl_s.d [r13]
L_8cc9aa:
	mov_s r0,r3
L_8cc9ac:
	b L_8c025c
