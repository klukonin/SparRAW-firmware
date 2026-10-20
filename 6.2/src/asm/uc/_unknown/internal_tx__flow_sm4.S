/* internal_tx__flow_sm4 @ 0x926cc4, 1532 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx_isr
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, abif__save_override_restore, gp0__arm_usec_c, internal_tx__read_result_889568, internal_tx__read_result_889570, internal_tx__update_state_locked, itx__rr_pick_pending_a, itx__set_result_code, itx__slot_ready, itx__tx_frame_3ies, itx__wait_ack_rf
 * Глобалы (через gp): 0x8005f4, 0x8005f8, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global internal_tx__flow_sm4
internal_tx__flow_sm4:
	.global L_926cc4
L_926cc4:
	push_s blink
L_926cc6:
	bl.d L_920210
L_926cca:
	mov_s r1,0x0
L_926ccc:
	sub_s sp,sp,0x2c
L_926cce:
	bset_s r1,r1,0xe
L_926cd0:
	mov_s r0,0x0
L_926cd2:
	st.as r1,[gp,0x33]
L_926cd6:
	st.as r0,[gp,0x34]
L_926cda:
	bl.d L_927ec0
L_926cde:
	add_s r0,sp,0x18
L_926ce0:
	brne_s r0,0,L_926cec
L_926ce2:
	bl.d L_9272e0
L_926ce6:
	mov_s r0,0x8
L_926ce8:
	b L_9272b8
	.global L_926cec
L_926cec:
	ld_s r0,[gp,-0x34]
L_926cee:
	cmp_s r0,0x1
L_926cf0:
	ld_s r1,[sp,0x18]
L_926cf2:
	bl.eq.d L_934e18
L_926cf6:
	mov.eq r0,r1
L_926cfa:
	ld_s r0,[sp,0x18]
L_926cfc:
	or r0,r0,0xaab100
L_926d04:
	mov_s r32,r0
L_926d06:
	st.ab r0,[r25,0x4]
L_926d0a:
	bclr r25,r25,0xa
L_926d0e:
	mov_s r0,0x1
L_926d10:
	bl.d L_9384d4
L_926d14:
	mov_s r16,r0
L_926d16:
	mov_s r2,0x857300
L_926d1c:
	ld_s r1,[r2,0x44]
L_926d1e:
	st_s r0,[sp,0x0]
L_926d20:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_926d22:
	st_s r1,[r2,0x44]
L_926d24:
	ld_s r1,[sp,0x18]
L_926d26:
	mov_s r13,0x0
L_926d28:
	st_s r1,[r0]
L_926d2a:
	st_s r13,[r0,0x8]
L_926d2c:
	ld_s r1,[sp,0x18]
L_926d2e:
	mov_s r2,0x80111c
L_926d34:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_926d36:
	add2_s r1,r1,r1
L_926d38:
	ld_s r1,[r2,r1]
L_926d3a:
	norm r1,r1
L_926d3e:
	rsub r2,r1,0x1e
L_926d42:
	st_s r2,[r0,0x4]
L_926d44:
	mov_s r0,0x857280
L_926d4a:
	ldb_s r0,[r0,0xe]
L_926d4c:
	cmp_s r0,0x0
L_926d4e:
	mov_s r0,0x30
L_926d50:
	mov.le r0,0x12
L_926d54:
	bl.d L_9283e0
L_926d58:
	mov r19,0x1b
L_926d5c:
	ld_s r0,[sp,0x18]
L_926d5e:
	mov_s r3,0x802354
L_926d64:
	asl_s r1,r0,0x2
L_926d66:
	add2_s r1,r1,r1
L_926d68:
	add r2,r3,0xd
L_926d6c:
	bl.d L_927f40
L_926d70:
	ldb r23,[r2,r1]
L_926d74:
	mov_s r15,r0
L_926d76:
	ld_s r0,[sp,0x18]
L_926d78:
	cmp_s r15,0x1
L_926d7a:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_926d7c:
	add2_s r0,r0,r0
L_926d7e:
	add_s r1,r3,r0
L_926d80:
	ldw_s r2,[r1,0x8]
L_926d82:
	add_s r3,r3,r0
L_926d84:
	mov r1,0x7d0
L_926d88:
	ldb_s r14,[r3,0x12]
L_926d8a:
	min r18,r2,r1
L_926d8e:
	mov_s r0,0x14
L_926d90:
	mov.eq r17,0x1
L_926d94:
	beq_s L_926dc8
L_926d96:
	mov_s r1,0x802408
L_926d9c:
	mov_s r0,0x800698
L_926da2:
	ld_s r0,[r0]
L_926da4:
	mov_s r3,0x800694
L_926daa:
	st_s r0,[sp,0x8]
L_926dac:
	ld_s r3,[r3]
L_926dae:
	mov_s r0,0x1
L_926db0:
	mov_s r2,0x7
L_926db2:
	bl.d L_929d20
L_926db6:
	ld r4,[sp, 0x8]
L_926dba:
	mov_s r1,0x802aa0
L_926dc0:
	st r16,[r1]
L_926dc4:
	mov_s r17,r13
L_926dc6:
	mov_s r0,r19
	.global L_926dc8
L_926dc8:
	st_s r0,[sp,0x4]
L_926dca:
	mov_s r0,0x0
L_926dcc:
	bbit0 r14,0x1,L_926dda
L_926dd0:
	mov_s r0,0x8577b8
L_926dd6:
	ldb_s r0,[r0,0x1d]
L_926dd8:
	/* add_s r0,0x5 */
	.byte 0x05,0xe0
	.global L_926dda
L_926dda:
	st_s r0,[sp,0x14]
L_926ddc:
	mov_s r0,0x0
L_926dde:
	bbit0 r14,0x2,L_926dec
L_926de2:
	mov_s r0,0x8577f8
L_926de8:
	ldb_s r0,[r0,0x1]
L_926dea:
	/* add_s r0,0x5 */
	.byte 0x05,0xe0
	.global L_926dec
L_926dec:
	st_s r0,[sp,0xc]
L_926dee:
	mov_s r0,0x0
L_926df0:
	bbit0 r14,0x3,L_926dfe
L_926df4:
	mov_s r0,0x857818
L_926dfa:
	ldb_s r0,[r0,0x5]
L_926dfc:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
	.global L_926dfe
L_926dfe:
	st_s r0,[sp,0x10]
L_926e00:
	or r0,r18,0xaab200
L_926e08:
	mov_s r32,r0
L_926e0a:
	st.ab r0,[r25,0x4]
L_926e0e:
	bclr r25,r25,0xa
L_926e12:
	or r14,r14,0xaac000
L_926e1a:
	mov_s r32,r14
L_926e1c:
	st.ab r14,[r25,0x4]
L_926e20:
	bclr r25,r25,0xa
L_926e24:
	mov_s r0,0x802aa0
L_926e2a:
	st_s r13,[r0,0x4]
L_926e2c:
	bset r0,r18,0x18
L_926e30:
	bset_s r0,r0,0x1a
L_926e32:
	bset_s r0,r0,0x1c
L_926e34:
	mov_s r32,r0
L_926e36:
	st.ab r0,[r25,0x4]
L_926e3a:
	bclr r25,r25,0xa
L_926e3e:
	mov_s r0,0x14000007
L_926e44:
	mov_s r32,r0
L_926e46:
	st.ab r0,[r25,0x4]
L_926e4a:
	bclr r25,r25,0xa
L_926e4e:
	bl.d L_939a64
L_926e52:
	ldb_s r0,[sp,0x18]
L_926e54:
	ld_s r0,[gp,-0x44]
L_926e56:
	and r0,r0,0xffff0fff
L_926e5e:
	bset r1,r0,0xd
L_926e62:
	bset_s r1,r1,0xf
L_926e64:
	or r0,r0,0x1d00a000
L_926e6c:
	st.as r1,[gp,-0x11]
L_926e70:
	mov_s r32,r0
L_926e72:
	st.ab r0,[r25,0x4]
L_926e76:
	bclr r25,r25,0xa
L_926e7a:
	bl L_936870
L_926e7e:
	bl L_936520
L_926e82:
	mov_s r1,r40
L_926e84:
	mov_s r0,r42
L_926e86:
	bbit1 r0,0xe,L_926e8e
L_926e8a:
	bbit1 r1,0x18,L_926ed2
	.global L_926e8e
L_926e8e:
	mov_s r0,r45
L_926e90:
	bbit0 r0,0x1f,L_926e8e
L_926e94:
	mov_s r0,0x29000002
L_926e9a:
	mov_s r32,r0
L_926e9c:
	st.ab r0,[r25,0x4]
L_926ea0:
	bclr r25,r25,0xa
L_926ea4:
	mov_s r0,0x800698
L_926eaa:
	ld_s r14,[r0]
L_926eac:
	mov_s r3,0x800694
L_926eb2:
	mov_s r13,0x0
L_926eb4:
	ld_s r3,[r3]
L_926eb6:
	mov_s r1,0x802408
L_926ebc:
	mov_s r0,r13
L_926ebe:
	mov_s r2,0x7
L_926ec0:
	bl.d L_929d20
L_926ec4:
	mov_s r4,r14
L_926ec6:
	mov_s r0,0x802aa0
L_926ecc:
	b.d L_9272b8
L_926ed0:
	st_s r13,[r0]
	.global L_926ed2
L_926ed2:
	ld_s r0,[sp,0x18]
L_926ed4:
	mov_s r1,0x80110c
L_926eda:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_926edc:
	add2_s r0,r0,r0
L_926ede:
	ld_s r1,[r1,r0]
L_926ee0:
	mov_s r0,0x5
L_926ee2:
	mov_s r2,0x0
L_926ee4:
	bl.d L_92f798
L_926ee8:
	mov_s r3,r2
L_926eea:
	mov_s r0,0x19000001
L_926ef0:
	mov_s r32,r0
L_926ef2:
	st.ab r0,[r25,0x4]
L_926ef6:
	bclr r25,r25,0xa
L_926efa:
	mov_s r0,0x18
L_926efc:
	asl_s r0,r0,0x18
L_926efe:
	mov_s r32,r0
L_926f00:
	st.ab r0,[r25,0x4]
L_926f04:
	bclr r25,r25,0xa
L_926f08:
	bl.d L_936544
L_926f0c:
	mov_s r0,0x6
L_926f0e:
	ld_s r0,[sp,0x18]
L_926f10:
	mov_s r1,0x801108
L_926f16:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_926f18:
	add2_s r0,r0,r0
L_926f1a:
	ld_s r1,[r1,r0]
L_926f1c:
	bl.d L_92f42c
L_926f20:
	mov_s r0,0x1
L_926f22:
	bl L_9364c8
L_926f26:
	mov_s r1,0x8006e0
L_926f2c:
	st_s r0,[r1]
L_926f2e:
	bl.d L_9361bc
L_926f32:
	mov_s r0,0x5
L_926f34:
	ld_s r0,[gp,0x178]
L_926f36:
	mov_s r1,0x802944
L_926f3c:
	bclr_s r0,r0,0x18
L_926f3e:
	ld_s r1,[r1]
L_926f40:
	bclr_s r0,r0,0x19
L_926f42:
	asl_s r1,r1,0x18
L_926f44:
	or_s r0,r0,r1
L_926f46:
	st.as r0,[gp,0x5e]
L_926f4a:
	mov_s r1,0x889480
L_926f50:
	st_s r0,[r1,0x8]
L_926f52:
	mov_s r0,0x80
L_926f54:
	bset_s r0,r0,0x19
L_926f56:
	mov_s r32,r0
L_926f58:
	st.ab r0,[r25,0x4]
L_926f5c:
	bclr r25,r25,0xa
L_926f60:
	mov_s r0,0x14
L_926f62:
	asl_s r0,r0,0x18
L_926f64:
	mov_s r32,r0
L_926f66:
	st.ab r0,[r25,0x4]
L_926f6a:
	bclr r25,r25,0xa
L_926f6e:
	ld_s r0,[sp,0x0]
L_926f70:
	bl.d L_93dfec
L_926f74:
	ld_s r0,[r0]
L_926f76:
	cmp_s r0,0x0
L_926f78:
	beq L_9271e4
L_926f7c:
	mov_s r0,0x20000400
L_926f82:
	mov_s r32,r0
L_926f84:
	st.ab r0,[r25,0x4]
L_926f88:
	bclr r25,r25,0xa
L_926f8c:
	cmp_s r15,0x0
L_926f8e:
	mov r19,0x802aa0
L_926f96:
	beq.d L_9271fe
L_926f9a:
	mov.eq r14,0x1
L_926f9e:
	mov_s r20,r15
L_926fa0:
	mov_s r22,r13
L_926fa2:
	mov_s r16,r13
L_926fa4:
	mov_s r18,r13
L_926fa6:
	b_s L_926faa
	.global L_926fa8
L_926fa8:
	mov_s r19,r0
	.global L_926faa
L_926faa:
	ld_s r0,[gp,-0x44]
L_926fac:
	and r0,r0,0xffff0fff
L_926fb4:
	bset r1,r0,0xc
L_926fb8:
	bset_s r1,r1,0xd
L_926fba:
	or r0,r0,0x1d003000
L_926fc2:
	st.as r1,[gp,-0x11]
L_926fc6:
	mov_s r32,r0
L_926fc8:
	st.ab r0,[r25,0x4]
L_926fcc:
	bclr r25,r25,0xa
L_926fd0:
	nop_s
L_926fd2:
	nop_s
L_926fd4:
	nop_s
L_926fd6:
	extw r0,r40
L_926fda:
	cmp_s r0,0x2f
L_926fdc:
	bcs L_9271bc
L_926fe0:
	mov_s r0,0x0
L_926fe2:
	mov_s r21,r0
L_926fe4:
	st r0,[r19, 0x4]
L_926fe8:
	mov_s r0,0x857280
L_926fee:
	ldb_s r0,[r0,0xe]
L_926ff0:
	cmp_s r0,0x0
L_926ff2:
	mov_s r0,0x30
L_926ff4:
	mov.le r0,0xc
L_926ff8:
	bl L_9283e0
L_926ffc:
	mov_s r14,0x8577b8
L_927002:
	breq r17,0x0,L_927010
L_927006:
	stb r21,[r14, 0x3]
L_92700a:
	mov_s r0,0xff
L_92700c:
	stb_s r0,[r14,0x2]
L_92700e:
	b_s L_927066
	.global L_927010
L_927010:
	ld_s r0,[sp,0x18]
L_927012:
	mov r21,0x802424
L_92701a:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92701c:
	add2_s r0,r0,r0
L_92701e:
	add_s r0,r0,0x802354
L_927024:
	ldb_s r1,[r0,0x11]
L_927026:
	mov_s r2,0xc
L_927028:
	ldb_s r0,[r0,0x10]
L_92702a:
	stb_s r1,[r14,0x3]
L_92702c:
	stb_s r0,[r14,0x2]
L_92702e:
	ld r0,[r21]
L_927032:
	mov_s r1,0x0
L_927034:
	bl.d L_920484
L_927038:
	mov_s r3,r1
L_92703a:
	st_s r0,[sp,0x1c]
L_92703c:
	st_s r1,[sp,0x20]
L_92703e:
	ld r0,[r21, 0x4]
L_927042:
	mov_s r1,0x0
L_927044:
	mov_s r2,0xc
L_927046:
	bl.d L_920484
L_92704a:
	mov_s r3,r1
L_92704c:
	st_s r0,[sp,0x24]
L_92704e:
	st_s r1,[sp,0x28]
L_927050:
	add r0,r14,0xa
L_927054:
	add_s r1,sp,0x24
L_927056:
	bl.d L_920330
L_92705a:
	mov_s r2,0x6
L_92705c:
	add_s r0,r14,0x4
L_92705e:
	add_s r1,sp,0x1c
L_927060:
	bl.d L_920330
L_927064:
	mov_s r2,0x6
	.global L_927066
L_927066:
	ld_s r0,[sp,0x18]
L_927068:
	mov_s r2,0x80110c
L_92706e:
	asl_s r1,r0,0x4
L_927070:
	add2_s r1,r1,r1
L_927072:
	sub_s r14,r2,0x4
L_927074:
	ld_s r2,[r2,r1]
L_927076:
	extb_s r0,r0
L_927078:
	ld.as r1,[gp,-0x17]
L_92707c:
	mov_s r3,0xd
L_92707e:
	ld r4,[sp, 0x4]
L_927082:
	ld r5,[sp, 0x14]
L_927086:
	ld r6,[sp, 0xc]
L_92708a:
	bl.d L_938a88
L_92708e:
	ld r7,[sp, 0x10]
L_927092:
	bl.d L_936544
L_927096:
	mov_s r0,0x6
L_927098:
	mov_s r0,0x0
L_92709a:
	bl.d L_9366dc
L_92709e:
	bset_s r0,r0,0xf
L_9270a0:
	cmp r17,0x0
L_9270a4:
	mov_s r1,0x1
L_9270a6:
	sub_s.ne r1,r1,r1
L_9270a8:
	cmp r22,0x0
L_9270ac:
	mov_s r0,0x1
L_9270ae:
	sub_s.ne r0,r0,r0
L_9270b0:
	tst_s r0,r1
L_9270b2:
	beq_s L_9270cc
L_9270b4:
	ld_s r0,[sp,0x18]
L_9270b6:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_9270b8:
	add2_s r0,r0,r0
L_9270ba:
	add_s r0,r0,0x802354
L_9270c0:
	ldb_s r1,[r0,0x10]
L_9270c2:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_9270c4:
	extb_s r1,r1
L_9270c6:
	max r1,r1,0x2
L_9270ca:
	stb_s r1,[r0,0x10]
	.global L_9270cc
L_9270cc:
	add r0,r19,0xc
L_9270d0:
	bl.d L_929ea8
L_9270d4:
	mov_s r1,0x10
L_9270d6:
	cmp_s r13,0x0
L_9270d8:
	mov.eq r13,0x1
L_9270dc:
	bl.d L_936588
L_9270e0:
	mov_s r0,0x6
L_9270e2:
	ld_s r0,[sp,0x18]
L_9270e4:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9270e6:
	add2_s r0,r0,r0
L_9270e8:
	ld_s r1,[r14,r0]
L_9270ea:
	bl.d L_92f42c
L_9270ee:
	mov_s r0,0x1
L_9270f0:
	ld_s r0,[gp,0x178]
L_9270f2:
	mov_s r1,0x802944
L_9270f8:
	bclr_s r0,r0,0x18
L_9270fa:
	ld_s r1,[r1]
L_9270fc:
	bclr_s r0,r0,0x19
L_9270fe:
	asl_s r1,r1,0x18
L_927100:
	or_s r0,r0,r1
L_927102:
	st.as r0,[gp,0x5e]
L_927106:
	mov_s r1,0x889480
L_92710c:
	st_s r0,[r1,0x8]
L_92710e:
	bl L_93dbec
L_927112:
	breq r0,0x0,L_9271c0
L_927116:
	ld_s r0,[gp,-0x44]
L_927118:
	and r0,r0,0xffff0fff
L_927120:
	st.as r0,[gp,-0x11]
L_927124:
	or r0,r0,0x1d000000
L_92712c:
	mov_s r32,r0
L_92712e:
	st.ab r0,[r25,0x4]
L_927132:
	bclr r25,r25,0xa
L_927136:
	nop_s
L_927138:
	nop_s
L_92713a:
	nop_s
L_92713c:
	sub r20,r20,0x1
L_927140:
	brne r18,0x0,L_927154
L_927144:
	mov_s r1,0x14
L_927146:
	mov_s r0,0x0
L_927148:
	st_s r1,[sp,0x4]
L_92714a:
	st_s r0,[sp,0x14]
L_92714c:
	st_s r0,[sp,0x10]
L_92714e:
	st_s r0,[sp,0xc]
L_927150:
	mov r18,0x1
	.global L_927154
L_927154:
	brne r17,0x0,L_927182
L_927158:
	ld_s r0,[sp,0x18]
L_92715a:
	mov_s r14,0x802424
L_927160:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_927162:
	add2_s r0,r0,r0
L_927164:
	add_s r0,r0,0x802354
L_92716a:
	ldb_s r1,[r0,0x11]
L_92716c:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92716e:
	extb_s r1,r1
L_927170:
	max r1,r1,0x1
L_927174:
	bl.d L_929ed4
L_927178:
	stb_s r1,[r0,0x11]
L_92717a:
	bl.d L_929ec8
L_92717e:
	st_s r0,[r14]
L_927180:
	st_s r0,[r14,0x4]
	.global L_927182
L_927182:
	cmp r20,0x1
L_927186:
	mov_s r0,0x1
L_927188:
	sub_s.ne r0,r0,r0
L_92718a:
	tst r0,r23
L_92718e:
	beq_s L_9271a6
L_927190:
	ld_s r0,[sp,0x18]
L_927192:
	mov_s r2,0x0
L_927194:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_927196:
	add2_s r0,r0,r0
L_927198:
	add r1,r0,0x802364
L_9271a0:
	stb_s r2,[r1]
L_9271a2:
	mov r22,0x1
	.global L_9271a6
L_9271a6:
	add r16,r16,0x1
L_9271aa:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_9271ac:
	cmp_s r15,0x0
L_9271ae:
	mov_s r0,0x802aa0
L_9271b4:
	bhi.d L_926fa8
L_9271b8:
	extb r16,r16
	.global L_9271bc
L_9271bc:
	mov_s r14,0x1
L_9271be:
	b_s L_927202
	.global L_9271c0
L_9271c0:
	mov_s r1,0x8010d0
L_9271c6:
	ldb_s r0,[r1,0x1f]
L_9271c8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9271ca:
	extb_s r0,r0
L_9271cc:
	stb_s r0,[r1,0x1f]
L_9271ce:
	ld_s r0,[sp,0x18]
L_9271d0:
	or r0,r0,0xcbb000
L_9271d8:
	mov_s r32,r0
L_9271da:
	st.ab r0,[r25,0x4]
L_9271de:
	bclr r25,r25,0xa
L_9271e2:
	b_s L_9271bc
	.global L_9271e4
L_9271e4:
	mov_s r1,0x8010d0
L_9271ea:
	ldb_s r0,[r1,0x1f]
L_9271ec:
	mov_s r14,r13
L_9271ee:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9271f0:
	extb_s r0,r0
L_9271f2:
	stb_s r0,[r1,0x1f]
L_9271f4:
	ldb_s r1,[sp,0x18]
L_9271f6:
	mov_s r0,0x1
L_9271f8:
	bl.d L_925698
L_9271fc:
	mov_s r2,0x1f
	.global L_9271fe
L_9271fe:
	mov_s r16,r13
L_927200:
	mov_s r18,r13
	.global L_927202
L_927202:
	or r0,r16,0xcbc000
L_92720a:
	mov_s r32,r0
L_92720c:
	st.ab r0,[r25,0x4]
L_927210:
	bclr r25,r25,0xa
L_927214:
	mov_s r0,0x0
L_927216:
	bset_s r0,r0,0x1d
L_927218:
	mov_s r32,r0
L_92721a:
	st.ab r0,[r25,0x4]
L_92721e:
	bclr r25,r25,0xa
L_927222:
	mov_s r13,0x802aa0
L_927228:
	ld_s r0,[r13,0x4]
L_92722a:
	cmp_s r0,0x0
L_92722c:
	bl.ne L_92f2bc
L_927230:
	ld_s r0,[sp,0x18]
L_927232:
	mov_s r1,r18
L_927234:
	mov_s r2,r14
L_927236:
	bl.d L_927e54
L_92723a:
	mov_s r3,r23
L_92723c:
	ld_s r0,[sp,0x18]
L_92723e:
	mov_s r1,0x802367
L_927244:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_927246:
	add2_s r0,r0,r0
L_927248:
	ldb_s r0,[r1,r0]
L_92724a:
	or r0,r0,0xbbc000
L_927252:
	mov_s r32,r0
L_927254:
	st.ab r0,[r25,0x4]
L_927258:
	bclr r25,r25,0xa
L_92725c:
	ld_s r0,[sp,0x18]
L_92725e:
	bl.d L_9272e0
L_927262:
	stb r0,[gp, -0xe7]
L_927266:
	mov_s r14,0x0
L_927268:
	ldb_s r1,[sp,0x18]
L_92726a:
	mov_s r0,r14
L_92726c:
	bl.d L_925698
L_927270:
	mov_s r2,0x1f
L_927272:
	mov_s r0,0x800698
L_927278:
	ld_s r15,[r0]
L_92727a:
	mov_s r3,0x800694
L_927280:
	ld_s r3,[r3]
L_927282:
	mov_s r1,0x802408
L_927288:
	mov_s r0,r14
L_92728a:
	mov_s r2,0x7
L_92728c:
	bl.d L_929d20
L_927290:
	mov_s r4,r15
L_927292:
	ld_s r0,[sp,0x18]
L_927294:
	st_s r14,[r13]
L_927296:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_927298:
	add2_s r0,r0,r0
L_92729a:
	add r1,r0,0x802366
L_9272a2:
	stb_s r14,[r1]
L_9272a4:
	mov_s r0,0x802424
L_9272aa:
	st_s r14,[r0]
L_9272ac:
	st_s r14,[r0,0x4]
L_9272ae:
	add r0,r13,0xc
L_9272b2:
	bl.d L_920a84
L_9272b6:
	mov_s r1,0x40
	.global L_9272b8
L_9272b8:
	b.d L_92025c
L_9272bc:
	add_s sp,sp,0x2c
L_9272be:
	nop_s
