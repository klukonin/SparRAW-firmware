/* l1_fixed_sched_ap__ev4_state2 @ 0x935e74, 416 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap_sm
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, field_rw_0x2c__924fb4, fixed_sched__check_slot_flag, fixed_sched__read_slot_id, fixed_sched__run_tx_slot, fsched__arm_slot_timer, fsched__cur_entry_byte0, fsched__cur_entry_byte1, fsched__get_cur_idx, fsched__pick_ready_queue, fsched__slot_byte0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_fixed_sched_ap__ev4_state2
l1_fixed_sched_ap__ev4_state2:
	.global L_935e74
L_935e74:
	push_s blink
L_935e76:
	bl L_920224
L_935e7a:
	bl.d L_926840
L_935e7e:
	sub_s sp,sp,0x8
L_935e80:
	mov_s r14,0x801be8
L_935e86:
	bl.d L_928824
L_935e8a:
	mov_s r0,r14
L_935e8c:
	bl.d L_92be90
L_935e90:
	add_s r0,sp,0x4
L_935e92:
	mov r16,0x8007d4
L_935e9a:
	breq_s r0,0,L_935ebe
L_935e9c:
	mov_s r0,0xbb8
L_935ea2:
	bl L_9351ec
L_935ea6:
	bl.d L_939594
L_935eaa:
	ld_s r0,[sp,0x4]
L_935eac:
	mov_s r2,0x4
L_935eae:
	ldb_s r0,[gp,-0xee]
L_935eb0:
	add2 r1,r16,r0
L_935eb4:
	stb_s r2,[r1,0x2]
	.global L_935eb6
L_935eb6:
	bl.d L_925014
L_935eba:
	mov_s r0,0xf
L_935ebc:
	b_s L_93600c
	.global L_935ebe
L_935ebe:
	bl.d L_920d04
L_935ec2:
	mov_s r0,r14
L_935ec4:
	brne_s r0,0,L_935f06
L_935ec6:
	bl.d L_924f48
L_935eca:
	mov_s r0,0x0
L_935ecc:
	ldb r2,[gp, -0xee]
L_935ed0:
	add2 r1,r16,r2
L_935ed4:
	brne r0,0x2,L_935ee8
L_935ed8:
	mov_s r0,0x7
L_935eda:
	stb_s r0,[r1,0x2]
	.global L_935edc
L_935edc:
	mov_s r0,0x0
L_935ede:
	mov_s r1,0x80064c
L_935ee4:
	st_s r0,[r1]
L_935ee6:
	b_s L_93600c
	.global L_935ee8
L_935ee8:
	mov_s r0,0x5
L_935eea:
	stb_s r0,[r1,0x2]
L_935eec:
	mov_s r0,0xbb8
L_935ef2:
	bl L_9351ec
L_935ef6:
	bl L_93768c
L_935efa:
	bl.d L_928308
L_935efe:
	mov_s r0,r14
L_935f00:
	bl L_925014
L_935f04:
	b_s L_93600c
	.global L_935f06
L_935f06:
	bl.d L_924f48
L_935f0a:
	mov_s r0,0x1
L_935f0c:
	mov_s r17,r0
L_935f0e:
	brne r0,0x2,L_935f1e
L_935f12:
	ldb_s r0,[gp,-0xee]
L_935f14:
	mov_s r2,0x7
L_935f16:
	add2 r1,r16,r0
L_935f1a:
	stb_s r2,[r1,0x2]
L_935f1c:
	b_s L_935edc
	.global L_935f1e
L_935f1e:
	bl.d L_927d54
L_935f22:
	mov_s r0,r14
L_935f24:
	mov_s r15,r0
L_935f26:
	bl.d L_927dbc
L_935f2a:
	mov_s r0,r14
L_935f2c:
	st_s r0,[sp,0x0]
L_935f2e:
	bl.d L_927db0
L_935f32:
	mov_s r0,r14
L_935f34:
	ldb r1,[gp, -0xee]
L_935f38:
	extb_s r13,r15
L_935f3a:
	add2 r0,r16,r1
L_935f3e:
	stb_s r15,[r0,0x3]
L_935f40:
	mov_s r0,r14
L_935f42:
	bl.d L_92be4c
L_935f46:
	mov_s r1,r13
L_935f48:
	breq_s r0,0,L_935f5a
L_935f4a:
	bl.d L_92eb94
L_935f4e:
	mov_s r0,r15
L_935f50:
	mov_s r0,r14
L_935f52:
	bl.d L_924fb4
L_935f56:
	mov_s r1,r13
L_935f58:
	b_s L_935eb6
	.global L_935f5a
L_935f5a:
	mov_s r13,0x80064c
L_935f60:
	ldb_s r0,[r13,0x6]
L_935f62:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_935f64:
	stb_s r0,[r13,0x6]
L_935f66:
	bl.d L_934e18
L_935f6a:
	mov_s r0,r15
L_935f6c:
	bl.d L_92accc
L_935f70:
	mov_s r0,r14
L_935f72:
	bl.d L_926298
L_935f76:
	ld_s r0,[sp,0x0]
L_935f78:
	mov_s r18,r0
L_935f7a:
	bl.d L_92bddc
L_935f7e:
	mov_s r0,r14
L_935f80:
	cmp r18,0x0
L_935f84:
	cmp.eq r0,0x0
L_935f88:
	beq_s L_935fd2
L_935f8a:
	ldb_s r0,[gp,-0xee]
L_935f8c:
	mov_s r2,0x8
L_935f8e:
	add2 r1,r16,r0
L_935f92:
	stb_s r2,[r1,0x2]
L_935f94:
	bl.d L_92ec18
L_935f98:
	mov_s r0,r14
L_935f9a:
	mov_s r0,0x5
L_935f9c:
	st_s r0,[r13]
L_935f9e:
	breq r18,0x0,L_935fce
L_935fa2:
	mov_s r0,0x0
L_935fa4:
	mov_s r2,0x857200
L_935faa:
	ld_s r1,[r2,0x48]
L_935fac:
	bset r0,r0,r15
L_935fb0:
	tst_s r1,r0
L_935fb2:
	beq_s L_935fce
L_935fb4:
	add_s r15,r15,r13
L_935fb6:
	ldb_s r1,[r15,0x10]
L_935fb8:
	brlt r1,0x1,L_935fce
L_935fbc:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_935fbe:
	ldb_s r3,[r13,0x18]
L_935fc0:
	extb_s r1,r1
L_935fc2:
	brlt.d r1,r3,L_935fce
L_935fc6:
	stb_s r1,[r15,0x10]
L_935fc8:
	ld_s r1,[r2,0x4c]
L_935fca:
	or_s r0,r0,r1
L_935fcc:
	st_s r0,[r2,0x4c]
	.global L_935fce
L_935fce:
	mov_s r0,0x5
L_935fd0:
	b_s L_93600c
	.global L_935fd2
L_935fd2:
	bl.d L_9290bc
L_935fd6:
	ld_s r0,[sp,0x0]
L_935fd8:
	mov_s r1,0x800814
L_935fde:
	stw_s r0,[r1,0x4]
L_935fe0:
	bl.d L_922458
L_935fe4:
	mov_s r0,r14
L_935fe6:
	bl L_9364c8
L_935fea:
	st_s r0,[r13,0x8]
L_935fec:
	bl.d L_927dc8
L_935ff0:
	mov_s r0,r14
L_935ff2:
	mulu64 r0,0xa5
L_935ff6:
	mov_s r0,0x0
L_935ff8:
	bl.d L_934f54
L_935ffc:
	mov_s r1,mlo
L_935ffe:
	cmp r17,0x1
L_936002:
	mov_s r0,0x7
L_936004:
	mov.ne r0,0x4
L_936008:
	st_s r0,[r13]
L_93600a:
	mov_s r0,0x0
	.global L_93600c
L_93600c:
	b.d L_920284
L_936010:
	add_s sp,sp,0x8
L_936012:
	nop_s
