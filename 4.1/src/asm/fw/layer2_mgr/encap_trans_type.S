/* encap_trans_type @ 0x8f37b8, 452 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   NEW VRING (TID %d) to CID %d cannot be proceed - CID is not exist.
 *   layer2_mgr.cpp
 *   DELETE VRING (TID %d), CID %d.
 *   NEW VRING (TID %d) to CID %d.
 *   encap_trans_type = %d, TX max_mpdu_size = %d, agg_max_wsize = %d
 *   lifetime_en = %d, u_to_resolution = %d, aggr_en = %d
 *   requested MSDU size = %d to big (%d)
 *   OOB mode force to MAX MSDU size = %d
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: STREAM_MGR__ADD, __ld_r21_to_r13_ret, __st_r21_to_r13, bcast_vring__delete, conn_mgr__by_cid, fw_log__emit1, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, l2mgr__send_vring_cfg_done, mid__setup_bcast_vring, stream_mgr__alloc_pring
 */
	.section .text.encap_trans_type,"ax",@progbits
	.global encap_trans_type
encap_trans_type:
	.global L_8f37b8
L_8f37b8:
	push_s blink
L_8f37ba:
	bl L_8c02a8
L_8f37be:
	ldb r17,[r0, 0x10]
L_8f37c2:
	mov_s r14,r0
L_8f37c4:
	sub_s sp,sp,0x18
L_8f37c6:
	brhs.d r17,0xa,L_8f37f0
L_8f37ca:
	mov_s r19,r1
L_8f37cc:
	ldb_s r15,[r14,0x11]
L_8f37ce:
	mov_s r13,r15
L_8f37d0:
	bic r13,r13,-0xf1
L_8f37d4:
	/* asr_s r13,r13,0x4 */
	.byte 0x44,0xbd
L_8f37d6:
	brhs r13,0x7,L_8f3808
	.global L_8f37da
L_8f37da:
	bl.d L_8c9e44
L_8f37de:
	bmsk r0,r15,0x3
L_8f37e2:
	mov.f r16,r0
L_8f37e6:
	bne_s L_8f383c
L_8f37e8:
	mov_s r2,0x100ca60
L_8f37ee:
	b_s L_8f3820
	.global L_8f37f0
L_8f37f0:
	mov_s r0,blink
L_8f37f2:
	mov_s r2,0x100c474
L_8f37f8:
	mov_s r1,0x11da
L_8f37fe:
	bl.d L_8c82c0
L_8f3802:
	mov r3,0x22f
L_8f3806:
	b_s L_8f396e
	.global L_8f3808
L_8f3808:
	mov_s r0,blink
L_8f380a:
	mov_s r2,0x100c474
L_8f3810:
	mov_s r1,0x11db
L_8f3816:
	bl.d L_8c82c0
L_8f381a:
	mov r3,0x239
L_8f381e:
	b_s L_8f37da
	.global L_8f3820
L_8f3820:
	mov_s r0,0xb
L_8f3822:
	mov_s r1,0x1
L_8f3824:
	mov_s r3,r13
L_8f3826:
	bmsk r4,r15,0x3
	.global L_8f382a
L_8f382a:
	bl L_8edff8
L_8f382e:
	mov_s r0,r17
L_8f3830:
	mov_s r1,0x0
L_8f3832:
	mov_s r2,0x1
L_8f3834:
	bl.d L_8f0b8c
L_8f3838:
	mov_s r3,r19
L_8f383a:
	b_s L_8f396e
	.global L_8f383c
L_8f383c:
	add3 r0,r16,0x16
L_8f3840:
	ldb_s r1,[r0]
L_8f3842:
	breq r1,0x2,L_8f384c
L_8f3846:
	ld_s r0,[r0,0x30]
L_8f3848:
	cmp_s r0,0x0
L_8f384a:
	beq_s L_8f3974
	.global L_8f384c
L_8f384c:
	ld_s r0,[r14]
L_8f384e:
	breq_s r0,0,L_8f3874
L_8f3850:
	cmp_s r0,0x1
L_8f3852:
	beq_s L_8f3958
L_8f3854:
	cmp_s r0,0x2
L_8f3856:
	bne_s L_8f3958
L_8f3858:
	mov_s r2,0x100caa4
L_8f385e:
	mov_s r0,0xb
L_8f3860:
	mov_s r1,0x2
L_8f3862:
	mov_s r3,r13
L_8f3864:
	bl.d L_8edff8
L_8f3868:
	bmsk r4,r15,0x3
L_8f386c:
	bl.d L_8c7884
L_8f3870:
	ldb_s r0,[r14,0x10]
L_8f3872:
	b_s L_8f396e
	.global L_8f3874
L_8f3874:
	mov_s r2,0x100cac4
L_8f387a:
	mov_s r0,0xb
L_8f387c:
	mov_s r1,0x2
L_8f387e:
	mov_s r3,r13
L_8f3880:
	bl.d L_8edff8
L_8f3884:
	bmsk r4,r15,0x3
L_8f3888:
	bl L_8c2d04
L_8f388c:
	mov_s r21,r0
L_8f388e:
	ldb_s r0,[r14,0x16]
L_8f3890:
	ldw r20,[r14, 0xe]
L_8f3894:
	mov_s r18,r0
L_8f3896:
	stb r0,[sp, 0x11]
L_8f389a:
	ldb_s r0,[r14,0x15]
L_8f389c:
	mov_s r2,0x100cae4
L_8f38a2:
	stb_s r0,[sp,0x10]
L_8f38a4:
	ldb r5,[r14, 0x17]
L_8f38a8:
	mov_s r0,0xb
L_8f38aa:
	ldb_s r3,[r14,0x12]
L_8f38ac:
	mov_s r1,0x2
L_8f38ae:
	bl.d L_8ee034
L_8f38b2:
	mov r4,r20
L_8f38b6:
	ld_s r15,[sp,0x10]
L_8f38b8:
	mov_s r2,0x100cb28
L_8f38be:
	lsr r5,r15
L_8f38c2:
	mov_s r0,0xb
L_8f38c4:
	mov_s r1,0x2
L_8f38c6:
	bmsk r3,r15,0x0
L_8f38ca:
	bmsk r4,r18,0x5
L_8f38ce:
	bl.d L_8ee034
L_8f38d2:
	bmsk r5,r5,0x0
L_8f38d6:
	ldb_s r0,[r14,0x17]
L_8f38d8:
	brne_s r0,0,L_8f38f8
L_8f38da:
	mov r4,0x1f28
L_8f38e2:
	brge 0x1f28,r20,L_8f38f8
L_8f38ea:
	mov_s r2,0x100cb60
L_8f38f0:
	mov_s r0,0xb
L_8f38f2:
	mov_s r1,0x1
L_8f38f4:
	mov_s r3,r20
L_8f38f6:
	b_s L_8f382a
	.global L_8f38f8
L_8f38f8:
	bl.d L_8cacc0
L_8f38fc:
	mov_s r0,r17
L_8f38fe:
	mov_s r19,r0
L_8f3900:
	mov_s r0,0x80345c
L_8f3906:
	ld_s r0,[r0,0xc]
L_8f3908:
	breq_s r0,0,L_8f3922
L_8f390a:
	mov r20,0x1f28
L_8f3912:
	mov_s r2,0x100cb88
L_8f3918:
	mov_s r0,0xb
L_8f391a:
	mov_s r1,0x1
L_8f391c:
	bl.d L_8edfcc
L_8f3920:
	mov_s r3,r20
	.global L_8f3922
L_8f3922:
	stw r20,[r19, 0x6]
L_8f3926:
	mov_s r0,0x0
L_8f3928:
	extb_s r3,r13
L_8f392a:
	ldb r5,[r14, 0x12]
L_8f392e:
	st_s r0,[sp,0x0]
L_8f3930:
	st_s r0,[sp,0x4]
L_8f3932:
	st_s r0,[sp,0x8]
L_8f3934:
	st_s r0,[sp,0xc]
L_8f3936:
	mov_s r0,r21
L_8f3938:
	mov_s r1,r17
L_8f393a:
	mov_s r2,r16
L_8f393c:
	mov r4,0x0
L_8f3940:
	bmsk r6,r18,0x5
L_8f3944:
	bl.d L_8e1360
L_8f3948:
	bmsk r7,r15,0x0
L_8f394c:
	add_s r1,r14,0x4
L_8f394e:
	mov_s r0,r21
L_8f3950:
	bl.d L_8c263c
L_8f3954:
	mov_s r2,r20
L_8f3956:
	b_s L_8f396e
	.global L_8f3958
L_8f3958:
	mov_s r0,blink
L_8f395a:
	mov_s r2,0x100c474
L_8f3960:
	mov_s r1,0x11dc
L_8f3966:
	bl.d L_8c82c0
L_8f396a:
	mov r3,0x27d
	.global L_8f396e
L_8f396e:
	b.d L_8c02fc
L_8f3972:
	add_s sp,sp,0x18
	.global L_8f3974
L_8f3974:
	mov_s r2,0x100cbb0
L_8f397a:
	b_s L_8f3820
