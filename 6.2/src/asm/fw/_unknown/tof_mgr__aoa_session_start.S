/* tof_mgr__aoa_session_start @ 0x8c3930, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [TOF] tof_mgr::aoa_session_start function
 *   [TOF] tof_mgr::aoa_session_start function - no connection object
 *   unassoc AOA set_bssid
 *   lmac_if_rxss_ctrl to TRUE
 * Зовут его: state_sm_8034c0__action_step
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit0, host_if__send_pair, l2mgr__apply_mac_address, lmac_cmd_pool__alloc, lmac_if__post_cmd, lmac_if_send_cmd_0x0f, low_sme__send_evt2sw, mid_list__by_mid_fw, mid_list__find_by
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tof_mgr__aoa_session_start
tof_mgr__aoa_session_start:
	.global L_8c3930
L_8c3930:
	push_s blink
L_8c3932:
	bl.d L_8c01d8
L_8c3936:
	mov_s r0,0x2b
L_8c3938:
	mov_s r13,r1
L_8c393a:
	mov_s r1,0x1019a28
L_8c3940:
	bl.d L_8dcba8
L_8c3944:
	mov_s r14,0x0
L_8c3946:
	bl.d L_8cc3dc
L_8c394a:
	mov_s r0,r14
L_8c394c:
	add r16,r13,0x10
L_8c3950:
	bl.d L_8cc024
L_8c3954:
	mov_s r1,r16
L_8c3956:
	mov.f r15,r0
L_8c395a:
	bne_s L_8c3998
L_8c395c:
	mov_s r1,0x1019a54
L_8c3962:
	bl.d L_8dcba8
L_8c3966:
	mov_s r0,0x2b
L_8c3968:
	bl L_8c32d8
L_8c396c:
	ldb_s r1,[r13,0x8]
L_8c396e:
	mov_s r2,0x90
L_8c3970:
	stb_s r1,[r0,0x6]
L_8c3972:
	ld_s r1,[r13,0x10]
L_8c3974:
	mov_s r3,r14
L_8c3976:
	st_s r1,[r0]
L_8c3978:
	ldw_s r1,[r13,0x14]
L_8c397a:
	mov_s r4,r14
L_8c397c:
	stw_s r1,[r0,0x4]
L_8c397e:
	ld_s r1,[r13,0x18]
L_8c3980:
	mov_s r5,r14
L_8c3982:
	stb_s r1,[r0,0x7]
L_8c3984:
	mov_s r1,0x2
L_8c3986:
	stb_s r1,[r0,0xc]
L_8c3988:
	mov_s r1,0x1923
L_8c398e:
	bl.d L_8e5474
L_8c3992:
	mov_s r6,r14
L_8c3994:
	mov_s r0,r14
L_8c3996:
	b_s L_8c3a00
	.global L_8c3998
L_8c3998:
	bl.d L_8cc3dc
L_8c399c:
	mov_s r0,r14
L_8c399e:
	add3 r17,r0,0x9
L_8c39a2:
	ld r0,[r17, 0x4]
L_8c39a6:
	cmp_s r0,0x2
L_8c39a8:
	mov_s r0,0x1
L_8c39aa:
	sub_s.ne r0,r0,r0
L_8c39ac:
	extb.f 0x0,r0
L_8c39b0:
	bne_s L_8c39da
L_8c39b2:
	mov_s r1,0x1019a98
L_8c39b8:
	bl.d L_8dcba8
L_8c39bc:
	mov_s r0,0x20
L_8c39be:
	mov_s r0,r17
L_8c39c0:
	bl.d L_8e6368
L_8c39c4:
	mov_s r1,r16
L_8c39c6:
	ldb_s r0,[r15,0x8]
L_8c39c8:
	bl.d L_8dbd74
L_8c39cc:
	mov_s r1,0x1
L_8c39ce:
	mov_s r1,0x1019ab0
L_8c39d4:
	bl.d L_8dcba8
L_8c39d8:
	mov_s r0,0x20
	.global L_8c39da
L_8c39da:
	bl L_8c3284
L_8c39de:
	ldb_s r1,[r13,0x8]
L_8c39e0:
	st_s r14,[r0,0x8]
L_8c39e2:
	stb_s r1,[r0,0x6]
L_8c39e4:
	ld_s r1,[r13,0x18]
L_8c39e6:
	mov_s r2,0x10
L_8c39e8:
	stb_s r1,[r0,0x7]
L_8c39ea:
	ld_s r1,[r13,0x10]
L_8c39ec:
	st_s r1,[r0]
L_8c39ee:
	ldw_s r1,[r13,0x14]
L_8c39f0:
	stw_s r1,[r0,0x4]
L_8c39f2:
	ldb_s r1,[r15,0x8]
L_8c39f4:
	stw_s r1,[r0,0xc]
L_8c39f6:
	mov_s r1,0x31
L_8c39f8:
	bl.d L_8e5204
L_8c39fc:
	mov_s r3,0x0
L_8c39fe:
	mov_s r0,0x1
	.global L_8c3a00
L_8c3a00:
	b L_8c023c
