/* ftm__send_ucode_session_cfg @ 0x8db81c, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ftm__responder_rx_req, state_sm_803424__action_8f064c
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, conn_mgr__by_cid, lmac_if__post_cmd, mem_pool__alloc_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm__send_ucode_session_cfg
ftm__send_ucode_session_cfg:
	.global L_8db81c
L_8db81c:
	push_s blink
L_8db81e:
	bl L_8c01d4
L_8db822:
	mov_s r18,r0
L_8db824:
	mov_s r15,r1
L_8db826:
	mov_s r14,r2
L_8db828:
	mov_s r16,r3
L_8db82a:
	mov_s r0,0x804280
L_8db830:
	bl.d L_8c33d0
L_8db834:
	mov r17,r4
L_8db838:
	mov_s r13,r0
L_8db83a:
	bl.d L_8cbffc
L_8db83e:
	mov_s r0,r18
L_8db840:
	breq r13,0x0,L_8db8c0
L_8db844:
	st_s r15,[r13]
L_8db846:
	ldb_s r1,[r0,0x8]
L_8db848:
	stw_s r1,[r13,0x8]
L_8db84a:
	brne r15,0x1,L_8db8b4
L_8db84e:
	ldb_s r1,[r14,0x7]
L_8db850:
	lsr_s r1,r1,0x2
L_8db852:
	bmsk r2,r1,0x0
L_8db856:
	ld_s r1,[r13,0x4]
L_8db858:
	bclr_s r1,r1,0x0
L_8db85a:
	or_s r2,r2,r1
L_8db85c:
	st_s r2,[r13,0x4]
L_8db85e:
	ldb_s r1,[r14,0x3]
L_8db860:
	bclr_s r2,r2,0x1
L_8db862:
	bmsk.f 0x0,r1,0x3
L_8db866:
	mov_s r1,0x1
L_8db868:
	sub_s.ne r1,r1,r1
L_8db86a:
	asl_s r1,r1
L_8db86c:
	or_s r2,r2,r1
L_8db86e:
	mov.f r1,r16
L_8db872:
	bic r2,r2,0x18
L_8db876:
	mov.ne r1,0x1
L_8db87a:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_8db87c:
	bclr_s r1,r1,0x4
L_8db87e:
	or_s r2,r2,r1
L_8db880:
	mov.f r1,r17
L_8db884:
	bset_s r2,r2,0x4
L_8db886:
	mov.ne r1,0x1
L_8db88a:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8db88c:
	bclr_s r2,r2,0x2
L_8db88e:
	or_s r1,r1,r2
L_8db890:
	st_s r1,[r13,0x4]
L_8db892:
	ldb_s r1,[r14,0x3]
L_8db894:
	mov_s r2,0xfa
L_8db896:
	lsr_s r1,r1,0x4
L_8db898:
	mul64_s r1,r2
L_8db89a:
	sub r1,mlo,r2
L_8db89e:
	stw_s r1,[r13,0x6]
L_8db8a0:
	ldb r0,[r0,0x17c]
L_8db8a8:
	stb_s r0,[r13,0xa]
L_8db8aa:
	ldb_s r0,[r14,0x7]
L_8db8ac:
	lsr_s r0,r0,0x3
L_8db8ae:
	stb_s r0,[r13,0x5]
L_8db8b0:
	mov_s r0,0x0
L_8db8b2:
	stw_s r0,[r13,0xc]
	.global L_8db8b4
L_8db8b4:
	mov_s r0,r13
L_8db8b6:
	mov_s r1,0x2d
L_8db8b8:
	mov_s r2,0x14
L_8db8ba:
	bl.d L_8e5204
L_8db8be:
	mov_s r3,0x0
	.global L_8db8c0
L_8db8c0:
	b L_8c0234
