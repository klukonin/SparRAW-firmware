/* state_sm_803424__action_8f064c @ 0x8f064c, 260 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FTM SESSION SM: not valid FTM request
 *   FTM SESSION SM: frame buffer allocate fail
 *   action_ftm_start_session(): CID %d, FTM flags [0x%x], ftm per burst %d
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__handle_event, ftm__send_ucode_session_cfg, ftm__set_shared_active_flag, fw_log_emit0, fw_log_emit3, memcpy_fw, mid_list__by_mid_fw, tx_api__send_mgmt_with_cb, tx_mgmt_ftm_req
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_803424__action_8f064c
state_sm_803424__action_8f064c:
	.global L_8f064c
L_8f064c:
	push_s blink
L_8f064e:
	bl L_8c01dc
L_8f0652:
	sub_s sp,sp,0xc
L_8f0654:
	mov_s r14,r0
L_8f0656:
	ld_s r15,[r0,0x1c]
L_8f0658:
	mov_s r13,0x0
L_8f065a:
	st_s r13,[sp,0x4]
L_8f065c:
	st_s r13,[sp,0x8]
L_8f065e:
	brne_s r15,0,L_8f067c
L_8f0660:
	mov_s r1,0x1019c90
	.global L_8f0666
L_8f0666:
	bl.d L_8dcba8
L_8f066a:
	mov_s r0,0x2b
L_8f066c:
	mov_s r0,r14
L_8f066e:
	mov_s r1,0x7
L_8f0670:
	mov_s r2,0x0
L_8f0672:
	mov_s r3,r2
L_8f0674:
	bl.d L_8d9b6c
L_8f0678:
	mov_s r4,r2
L_8f067a:
	b_s L_8f0748
	.global L_8f067c
L_8f067c:
	bl L_8c3414
L_8f0680:
	st_s r0,[r14,0x14]
L_8f0682:
	brne_s r0,0,L_8f068c
L_8f0684:
	mov_s r1,0x1019cb8
L_8f068a:
	b_s L_8f0666
	.global L_8f068c
L_8f068c:
	ld_s r2,[r14,0x10]
L_8f068e:
	mov_s r1,0x1019ce4
L_8f0694:
	ldb r4,[r15, 0xb]
L_8f0698:
	mov_s r0,0x2b
L_8f069a:
	ldb_s r2,[r2,0x8]
L_8f069c:
	bl.d L_8dcd00
L_8f06a0:
	ldb_s r3,[r15,0x9]
L_8f06a2:
	ld_s r3,[r14,0x10]
L_8f06a4:
	add_s r1,sp,0x4
L_8f06a6:
	ld_s r0,[r14,0x14]
L_8f06a8:
	add r4,sp,0x8
L_8f06ac:
	bl.d L_8e9d48
L_8f06b0:
	ld_s r2,[r3,0x18]
L_8f06b2:
	ld_s r15,[sp,0x8]
L_8f06b4:
	brne_s r15,0,L_8f06ba
	.global L_8f06b6
L_8f06b6:
	mov_s r16,r13
L_8f06b8:
	b_s L_8f06d4
	.global L_8f06ba
L_8f06ba:
	cmp r15,0xff
L_8f06be:
	bhs_s L_8f06b6
L_8f06c0:
	ld r16,[r14, 0x14]
L_8f06c4:
	mov_s r0,0x85781c
L_8f06ca:
	add r1,r16,r15
L_8f06ce:
	bl.d L_8c0380
L_8f06d2:
	mov_s r2,0xb
	.global L_8f06d4
L_8f06d4:
	ld_s r0,[r14,0x10]
L_8f06d6:
	add r2,r15,r16
L_8f06da:
	ldb_s r0,[r0,0x8]
L_8f06dc:
	mov_s r1,0x0
L_8f06de:
	mov_s r3,r1
L_8f06e0:
	bl.d L_8db81c
L_8f06e4:
	mov_s r4,r1
L_8f06e6:
	bl.d L_8cb544
L_8f06ea:
	mov_s r0,0x1
L_8f06ec:
	bl.d L_8cc3dc
L_8f06f0:
	mov_s r0,0x0
L_8f06f2:
	ld_s r0,[r0,0x4c]
L_8f06f4:
	mov_s r1,0x1
L_8f06f6:
	cmp_s r0,0x2
L_8f06f8:
	mov_s r0,0x1
L_8f06fa:
	sub_s.ne r0,r0,r0
L_8f06fc:
	extb.f 0x0,r0
L_8f0700:
	sub_s.ne r1,r1,r1
L_8f0702:
	ldw r4,[sp, 0x4]
L_8f0706:
	mov r7,0x331ec
L_8f070e:
	st_s r13,[sp,0x0]
L_8f0710:
	ld_s r0,[r14,0x10]
L_8f0712:
	mov_s r2,0x1
L_8f0714:
	ld_s r3,[r14,0x14]
L_8f0716:
	mov r5,0x4
L_8f071a:
	bl.d L_8e5a28
L_8f071e:
	mov r6,0x5
L_8f0722:
	ld_s r0,[gp,-0xf4]
L_8f0724:
	mov_s r1,L_8f3254-0x8c0000
L_8f072a:
	mulu64 r0,0x3e8
L_8f072e:
	mov_s r0,r1
L_8f0730:
	ld_s r1,[r14,0x10]
L_8f0732:
	mov_s r2,0x0
L_8f0734:
	mov r4,mlo
L_8f0738:
	mov_s r3,0x1
L_8f073a:
	mov r5,0x0
L_8f073e:
	bl.d L_8e0c0c
L_8f0742:
	mov r6,0x0
L_8f0746:
	st_s r0,[r14,0xc]
	.global L_8f0748
L_8f0748:
	b.d L_8c0244
L_8f074c:
	add_s sp,sp,0xc
L_8f074e:
	nop_s
