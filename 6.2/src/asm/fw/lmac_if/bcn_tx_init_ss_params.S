/* bcn_tx_init_ss_params @ 0x8c4664, 248 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bcn_tx_init_ss_params: discovery beacon total sectors
 *   bcn_tx_init_ss_params:  total sectors %d
 *   bcon_post_send: bcon_type=%d; b_mode=%d; b_send=%d
 * Зовут его: lmac_if__build_bcon_cfg
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal, lmac_if__send_bcon_mgt, rf_if__tx_sectors_vcall_14, sector_list__validate, stream_mgr__check_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bcn_tx_init_ss_params
bcn_tx_init_ss_params:
	.global L_8c4664
L_8c4664:
	sub_s sp,sp,0x8
L_8c4666:
	push_s blink
L_8c4668:
	bl L_8c01e4
L_8c466c:
	mov_s r13,r0
L_8c466e:
	ld_s r0,[gp,-0x18]
L_8c4670:
	st_s r1,[sp,0xc]
L_8c4672:
	breq_s r0,0,L_8c46a8
	.global L_8c4674
L_8c4674:
	mov_s r0,0x857720
L_8c467a:
	ldb_s r0,[r0,0x1c]
L_8c467c:
	add_s r14,r13,0x4
L_8c467e:
	brlt.d r0,0x2,L_8c46b4
L_8c4682:
	add r2,r14,0x8
L_8c4686:
	mov lp_count,0x40
L_8c468a:
	mov_s r1,0x0
L_8c468c:
	lp L_8c4698
L_8c4690:
	add_s r12,r2,r1
L_8c4692:
	stb_s r1,[r12]
L_8c4694:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c4696:
	extb_s r1,r1
	.global L_8c4698
L_8c4698:
	mov_s r0,0x40
L_8c469a:
	stb r0,[r14, 0x48]
L_8c469e:
	mov_s r0,0x0
L_8c46a0:
	st_s r0,[r14]
L_8c46a2:
	st_s r0,[r14,0x4]
L_8c46a4:
	mov_s r0,0x1
L_8c46a6:
	b_s L_8c46ca
	.global L_8c46a8
L_8c46a8:
	mov_s r0,blink
L_8c46aa:
	mov_s r1,0x4d
L_8c46ac:
	bl.d L_8c9b28
L_8c46b0:
	bset_s r1,r1,0xc
L_8c46b2:
	b_s L_8c4674
	.global L_8c46b4
L_8c46b4:
	mov_s r0,0x8042c8
L_8c46ba:
	bl L_8cb7f8
L_8c46be:
	mov_s r2,0x0
L_8c46c0:
	mov_s r1,r0
L_8c46c2:
	mov_s r0,r14
L_8c46c4:
	bl.d L_8d9ac8
L_8c46c8:
	mov_s r3,r2
	.global L_8c46ca
L_8c46ca:
	cmp_s r0,0x0
L_8c46cc:
	mov.eq r0,blink
L_8c46d0:
	mov.eq r1,0x1369
L_8c46d8:
	bl.eq L_8c9b28
L_8c46dc:
	ldb_s r0,[sp,0xc]
L_8c46de:
	bbit0 r0,0x1,L_8c46f4
L_8c46e2:
	mov_s r0,0x10
L_8c46e4:
	stb r0,[r13, 0x4c]
L_8c46e8:
	mov_s r1,0x1004a74
L_8c46ee:
	bl.d L_8dcba8
L_8c46f2:
	mov_s r0,0x20
	.global L_8c46f4
L_8c46f4:
	mov_s r1,0x1004aac
L_8c46fa:
	mov_s r0,0x20
L_8c46fc:
	bl.d L_8dcc10
L_8c4700:
	ldb r2,[r13, 0x4c]
L_8c4704:
	mov_s r12,0xc
L_8c4706:
	b L_8c0256
L_8c470a:
	nop_s
L_8c470c:
	push_s blink
L_8c470e:
	bl L_8c01e4
L_8c4712:
	mov.f r13,r0
L_8c4716:
	mov_s r14,r1
L_8c4718:
	beq_s L_8c4756
L_8c471a:
	ld_s r2,[r13]
L_8c471c:
	mov_s r1,0x1017148
L_8c4722:
	ld_s r3,[r13,0xc]
L_8c4724:
	mov_s r0,0x2c
L_8c4726:
	bl.d L_8dcd00
L_8c472a:
	mov_s r4,r14
L_8c472c:
	breq_s r14,0,L_8c473e
L_8c472e:
	ld r4,[r13, 0x10]
L_8c4732:
	ld_s r0,[r13]
L_8c4734:
	ld_s r1,[r13,0xc]
L_8c4736:
	ld_s r2,[r13,0x4]
L_8c4738:
	bl.d L_8db288
L_8c473c:
	ld_s r3,[r13,0x8]
	.global L_8c473e
L_8c473e:
	mov_s r1,0x805a98
L_8c4744:
	add r0,r1,0x14
L_8c4748:
	cmp_s r13,r0
L_8c474a:
	mov.ne r0,r1
L_8c474e:
	bl.ne.d L_8caed0
L_8c4752:
	mov.ne r1,r13
	.global L_8c4756
L_8c4756:
	b L_8c0254
L_8c475a:
	nop_s
