/* l1_task__main_step @ 0x92caf4, 536 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   L1_FIXED_SCHED_TASK PRE TBTT tsf:0x%x
 * Зовут его: l1_task__entry_uc
 * Зовёт сам: __ld_r13_to_r13_ret, bi__dispatch_by_role, l1__enter_fixed_sched, l1_fixed_sched_ap_sm, l1_fixed_sched_sta_sm, l1_task__dispatch, l1_task__phase_of, l1_task__report_link_lost, uc_log__emit1, uc_read_tsf_lo, uc_sysassert
 * Глобалы (через gp): 0x800558, 0x800588, 0x8005bc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_task__main_step
l1_task__main_step:
	.global L_92caf4
L_92caf4:
	push_s blink
L_92caf6:
	mov_s r0,0xcafcaa
L_92cafc:
	mov_s r32,r0
L_92cafe:
	st.ab r0,[r25,0x4]
L_92cb02:
	bclr r25,r25,0xa
L_92cb06:
	bmsk r0,r42,0x17
L_92cb0a:
	mov_s r32,r0
L_92cb0c:
	st.ab r0,[r25,0x4]
L_92cb10:
	bclr r25,r25,0xa
L_92cb14:
	mov_s r0,0x800738
L_92cb1a:
	ld_s r0,[r0,0x10]
L_92cb1c:
	lr r0,[r0]
L_92cb20:
	bmsk_s r0,r0,0x17
L_92cb22:
	mov_s r32,r0
L_92cb24:
	st.ab r0,[r25,0x4]
L_92cb28:
	bclr r25,r25,0xa
L_92cb2c:
	mov_s r0,0x8006a8
L_92cb32:
	ldb_s r0,[r0]
L_92cb34:
	brne_s r0,0,L_92cb80
	.global L_92cb36
L_92cb36:
	ldw_s r0,[gp,0x94]
L_92cb38:
	breq_s r0,0,L_92cb8e
	.global L_92cb3a
L_92cb3a:
	mov_s r0,r42
L_92cb3c:
	bbit0 r0,0x13,L_92cba2
L_92cb40:
	bl L_9364c8
L_92cb44:
	mov_s r1,0x800634
L_92cb4a:
	ld_s r2,[r1]
L_92cb4c:
	st_s r0,[r1,0x4]
L_92cb4e:
	breq_s r2,0,L_92cb66
L_92cb50:
	sub_s r0,r0,r2
L_92cb52:
	brlo r0,0xa,L_92cb62
L_92cb56:
	mov_s r2,0x8010b0
L_92cb5c:
	ld_s r0,[r2,0x28]
L_92cb5e:
	add_s r0,r0,0xa
L_92cb60:
	st_s r0,[r2,0x28]
	.global L_92cb62
L_92cb62:
	mov_s r0,0x0
L_92cb64:
	st_s r0,[r1]
	.global L_92cb66
L_92cb66:
	ld_s r0,[gp,0x60]
L_92cb68:
	cmp_s r0,0x1
L_92cb6a:
	mov_s r0,0x1
L_92cb6c:
	sub_s.ne r0,r0,r0
L_92cb6e:
	extb.f 0x0,r0
L_92cb72:
	beq_s L_92cb98
	.global L_92cb74
L_92cb74:
	mov_s r0,0x802f44
L_92cb7a:
	bl L_92b648
L_92cb7e:
	b_s L_92cc22
	.global L_92cb80
L_92cb80:
	mov_s r0,blink
L_92cb82:
	mov_s r1,0x1314
L_92cb88:
	bl L_926618
L_92cb8c:
	b_s L_92cb36
	.global L_92cb8e
L_92cb8e:
	mov_s r0,blink
L_92cb90:
	bl.d L_926618
L_92cb94:
	mov_s r1,0x27
L_92cb96:
	b_s L_92cb3a
	.global L_92cb98
L_92cb98:
	mov_s r0,blink
L_92cb9a:
	bl.d L_926618
L_92cb9e:
	mov_s r1,0x28
L_92cba0:
	b_s L_92cb74
	.global L_92cba2
L_92cba2:
	mov_s r0,r42
L_92cba4:
	bbit0 r0,0x4,L_92cbf8
L_92cba8:
	ldb_s r0,[gp,-0xdf]
L_92cbaa:
	breq_s r0,0,L_92cbda
L_92cbac:
	mov_s r0,0x8014a4
L_92cbb2:
	ld_s r0,[r0,0x1c]
L_92cbb4:
	breq r0,0x1,L_92cbf0
L_92cbb8:
	mov_s r0,0x80212c
L_92cbbe:
	ldb r1,[r0, 0x68]
L_92cbc2:
	breq_s r1,0,L_92cbda
L_92cbc4:
	norm r1,r1
L_92cbc8:
	rsub r0,r1,0x1e
L_92cbcc:
	asl_s r1,r0,0x4
L_92cbce:
	add2_s r1,r1,r1
L_92cbd0:
	mov_s r2,0x80111c
L_92cbd6:
	ld_s r1,[r2,r1]
L_92cbd8:
	brne_s r1,0,L_92cbf2
	.global L_92cbda
L_92cbda:
	mov_s r1,0x802ec0
L_92cbe0:
	ldw_s r0,[r1]
L_92cbe2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92cbe4:
	stw_s r0,[r1]
L_92cbe6:
	mov_s r0,0x0
L_92cbe8:
	bl.d L_934e30
L_92cbec:
	mov_s r1,r0
L_92cbee:
	b_s L_92cc22
	.global L_92cbf0
L_92cbf0:
	mov_s r0,0x0
	.global L_92cbf2
L_92cbf2:
	bl L_92c7ec
L_92cbf6:
	b_s L_92cc42
	.global L_92cbf8
L_92cbf8:
	mov_s r0,r42
L_92cbfa:
	bbit0 r0,0x12,L_92cc22
L_92cbfe:
	mov_s r2,0x800634
L_92cc04:
	ld_s r0,[r2]
L_92cc06:
	breq_s r0,0,L_92cc18
L_92cc08:
	mov_s r1,0x8010b0
L_92cc0e:
	ld_s r0,[r1,0x28]
L_92cc10:
	add_s r0,r0,0xa
L_92cc12:
	st_s r0,[r1,0x28]
L_92cc14:
	mov_s r0,0x0
L_92cc16:
	st_s r0,[r2]
	.global L_92cc18
L_92cc18:
	mov_s r0,0x802f44
L_92cc1e:
	bl L_92b448
	.global L_92cc22
L_92cc22:
	mov_s r1,0x800624
L_92cc28:
	ld_s r0,[r1]
L_92cc2a:
	st.as r25,[gp,0xc]
L_92cc2e:
	breq_s r0,0,L_92cc38
L_92cc30:
	mov_s r0,0x0
L_92cc32:
	bl.d L_928ab8
L_92cc36:
	st_s r0,[r1]
	.global L_92cc38
L_92cc38:
	and.f 0x0,r42,0xc0010
L_92cc40:
	bne_s L_92cb3a
	.global L_92cc42
L_92cc42:
	pop_s blink
L_92cc44:
	j_s [blink]
L_92cc46:
	nop_s
	.global L_92cc48
L_92cc48:
	push_s blink
L_92cc4a:
	push_s r13
L_92cc4c:
	mov_s r13,0x0
	.global L_92cc4e
L_92cc4e:
	mov_s r0,r42
L_92cc50:
	bbit0 r0,0x13,L_92cc84
L_92cc54:
	bl L_9364c8
L_92cc58:
	mov_s r1,0x800638
L_92cc5e:
	st_s r0,[r1]
L_92cc60:
	mov_s r2,0x800634
L_92cc66:
	ld_s r1,[r2]
L_92cc68:
	breq_s r1,0,L_92cc80
L_92cc6a:
	sub_s r0,r0,r1
L_92cc6c:
	brlo r0,0xa,L_92cc7c
L_92cc70:
	mov_s r1,0x8010b0
L_92cc76:
	ld_s r0,[r1,0x28]
L_92cc78:
	add_s r0,r0,0xa
L_92cc7a:
	st_s r0,[r1,0x28]
	.global L_92cc7c
L_92cc7c:
	mov_s r0,0x0
L_92cc7e:
	st_s r0,[r2]
	.global L_92cc80
L_92cc80:
	mov_s r13,0x2
L_92cc82:
	b_s L_92ccd6
	.global L_92cc84
L_92cc84:
	mov_s r0,r42
L_92cc86:
	bbit0 r0,0x4,L_92ccb4
L_92cc8a:
	mov_s r1,0x802ec0
L_92cc90:
	ldw_s r0,[r1]
L_92cc92:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92cc94:
	bl.d L_9364c8
L_92cc98:
	stw_s r0,[r1]
L_92cc9a:
	mov_s r2,r0
L_92cc9c:
	mov_s r1,0x10006dc
L_92cca2:
	bl.d L_92d1d0
L_92cca6:
	mov_s r0,0x20
L_92cca8:
	mov_s r0,0x0
L_92ccaa:
	bl.d L_934e30
L_92ccae:
	mov_s r1,r0
L_92ccb0:
	mov_s r13,0x1
L_92ccb2:
	b_s L_92ccd6
	.global L_92ccb4
L_92ccb4:
	mov_s r0,r42
L_92ccb6:
	bbit0 r0,0x12,L_92ccd6
L_92ccba:
	mov_s r2,0x800634
L_92ccc0:
	ld_s r0,[r2]
L_92ccc2:
	breq_s r0,0,L_92ccd4
L_92ccc4:
	mov_s r1,0x8010b0
L_92ccca:
	ld_s r0,[r1,0x28]
L_92cccc:
	add_s r0,r0,0xa
L_92ccce:
	st_s r0,[r1,0x28]
L_92ccd0:
	mov_s r0,0x0
L_92ccd2:
	st_s r0,[r2]
	.global L_92ccd4
L_92ccd4:
	mov_s r13,0x6
	.global L_92ccd6
L_92ccd6:
	mov_s r1,0x800624
L_92ccdc:
	ld_s r0,[r1]
L_92ccde:
	breq_s r0,0,L_92cce8
L_92cce0:
	mov_s r13,0x0
L_92cce2:
	bl.d L_928ab8
L_92cce6:
	st_s r13,[r1]
	.global L_92cce8
L_92cce8:
	breq_s r13,0,L_92ccfc
L_92ccea:
	ld_s r0,[gp,-0x34]
L_92ccec:
	cmp_s r0,0x1
L_92ccee:
	mov_s r0,r13
L_92ccf0:
	bne_s L_92ccf8
L_92ccf2:
	bl L_92c66c
L_92ccf6:
	b_s L_92ccfc
	.global L_92ccf8
L_92ccf8:
	bl L_92c840
	.global L_92ccfc
L_92ccfc:
	and.f 0x0,r42,0xc0010
L_92cd04:
	bne_s L_92cc4e
L_92cd06:
	b L_9202ac
L_92cd0a:
	nop_s
