/* bti_worker__bti_transmitter_beacon_sweep_flow @ 0x923cb4, 1368 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bti_worker::bti_transmitter_beacon_sweep_flow() current_tsf: 0x%08x, Next tsf: 0x%08x, uniform_random: %d
 * Зовут его: bti__prepare_sweep_set
 * Зовёт сам: bcon_txss_sweep_step, bi__remaining_time_us, bi_cfg__tick_counters, bi_ctrl__program_mac_bcon, bti__measure_frame_duration, rx_nav__arm_flag_if_enabled, set_tsf_event, tx_ctx__alloc_next, txss__set_sweep_param, uc_log__emit3, uc_read_tsf_lo, uc_shl64
 * Глобалы (через gp): 0x8005f4, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti_worker__bti_transmitter_beacon_sweep_flow
bti_worker__bti_transmitter_beacon_sweep_flow:
	.global L_923cb4
L_923cb4:
	st.a r13,[sp,-0x14]
L_923cb8:
	st blink,[sp, 0x4]
L_923cbc:
	st_s r14,[sp,0x8]
L_923cbe:
	st_s r15,[sp,0xc]
L_923cc0:
	st r16,[sp, 0x10]
L_923cc4:
	sub_s sp,sp,0x8
L_923cc6:
	mov r9,0x10
L_923cca:
	st.as r9,[gp,0x33]
L_923cce:
	mov_s r13,0x8022a8
L_923cd4:
	ld r9,[r13]
L_923cd8:
	mov_s r2,0x0
L_923cda:
	cmp r9,0x2
L_923cde:
	mov_s r16,r0
L_923ce0:
	bne.d L_923d84
L_923ce4:
	st.as r2,[gp,0x34]
L_923ce8:
	ld r10,[r16]
L_923cec:
	brne r10,0x0,L_923d84
L_923cf0:
	ld.as r4,[gp,-0x11]
L_923cf4:
	and r4,r4,0xfff0ffff
L_923cfc:
	bset r5,r4,0x11
L_923d00:
	or r4,r4,0x1d020000
L_923d08:
	st.as r5,[gp,-0x11]
L_923d0c:
	mov r32,r4
L_923d10:
	st.ab r4,[r25,0x4]
L_923d14:
	bclr r25,r25,0xa
L_923d18:
	nop_s
L_923d1a:
	nop_s
L_923d1c:
	nop_s
L_923d1e:
	mov_s r0,r47
L_923d20:
	mulu64 r0,0xbd
L_923d24:
	mov r0,mhi
L_923d28:
	add r14,r0,0xa
L_923d2c:
	or r9,r14,0x30000000
L_923d34:
	mov r32,r9
L_923d38:
	st.ab r9,[r25,0x4]
L_923d3c:
	bclr r25,r25,0xa
L_923d40:
	bl L_9364c8
L_923d44:
	mov_s r1,0x0
L_923d46:
	mov_s r15,r0
L_923d48:
	mov r0,r14
L_923d4c:
	bl.d L_920458
L_923d50:
	mov r2,0xa
L_923d54:
	ld_s r3,[r13,0x18]
L_923d56:
	add.f r0,r0,r3
L_923d5a:
	ld r4,[r13, 0x1c]
L_923d5e:
	st_s r0,[r13,0x18]
L_923d60:
	adc r1,r1,r4
L_923d64:
	st r1,[r13, 0x1c]
L_923d68:
	bl.d L_935680
L_923d6c:
	add r0,r13,0x18
L_923d70:
	ld_s r3,[r13,0x18]
L_923d72:
	mov_s r1,0x1001d88
L_923d78:
	mov_s r0,0x20
L_923d7a:
	mov_s r2,r15
L_923d7c:
	bl.d L_92d338
L_923d80:
	mov r4,r14
	.global L_923d84
L_923d84:
	ldb r4,[gp, -0xdf]
L_923d88:
	brne r4,0x0,L_923df8
L_923d8c:
	bl L_92dc28
L_923d90:
	bl L_92dc44
L_923d94:
	breq_s r0,0,L_923df8
L_923d96:
	mov r10,0x857000
L_923d9e:
	ld r5,[r10, 0x30]
L_923da2:
	mov_s r14,0x800714
L_923da8:
	ld_s r1,[r14]
L_923daa:
	add r5,r5,0x1
L_923dae:
	mov_s r13,0x803110
L_923db4:
	brne.d r1,0x0,L_923de0
L_923db8:
	st r5,[r10, 0x30]
L_923dbc:
	bl L_9364c8
L_923dc0:
	mov r6,0x1
L_923dc4:
	st_s r0,[r13]
L_923dc6:
	st r6,[r14]
L_923dca:
	add_s sp,sp,0x8
L_923dcc:
	ld blink,[sp, 0x4]
L_923dd0:
	ld_s r14,[sp,0x8]
L_923dd2:
	ld_s r15,[sp,0xc]
L_923dd4:
	ld r16,[sp, 0x10]
L_923dd8:
	j.d [blink]
L_923ddc:
	ld.ab r13,[sp,0x14]
	.global L_923de0
L_923de0:
	bl L_9364c8
L_923de4:
	ld_s r2,[r13]
L_923de6:
	sub_s r0,r0,r2
L_923de8:
	cmp r0,0x7530
L_923df0:
	blt.d L_9241f8
L_923df4:
	st r0,[r13, 0x4]
	.global L_923df8
L_923df8:
	ld_s r0,[gp,-0x48]
L_923dfa:
	or r0,r0,0x27007e00
L_923e02:
	mov_s r32,r0
L_923e04:
	st.ab r0,[r25,0x4]
L_923e08:
	bclr r25,r25,0xa
L_923e0c:
	mov r4,0x2004002
L_923e14:
	mov r32,r4
L_923e18:
	st.ab r4,[r25,0x4]
L_923e1c:
	bclr r25,r25,0xa
L_923e20:
	bl.d L_9384d4
L_923e24:
	mov r0,0x1
L_923e28:
	mov r5,0x1e
L_923e2c:
	st r5,[r0, 0x4]
L_923e30:
	mov r5,0x857800
L_923e38:
	ldb r6,[r5, -0xc4]
L_923e3c:
	brlt.d r6,0x2,L_923e64
L_923e40:
	mov_s r15,r0
L_923e42:
	ld r11,[r5, -0x50]
L_923e46:
	ldb r2,[gp, -0xf7]
L_923e4a:
	add1 r11,r11,r2
L_923e4e:
	ldb r1,[r11, 0x1]
L_923e52:
	ldb r0,[r11]
L_923e56:
	sub_s r1,r1,r0
L_923e58:
	add r1,r1,0x1
L_923e5c:
	stb r1,[0x802a68]
	.global L_923e64
L_923e64:
	bl.d L_937cf0
L_923e68:
	mov r0,sp
L_923e6c:
	bl L_9381c4
L_923e70:
	mov_s r0,0x2
L_923e72:
	bset_s r0,r0,0xe
L_923e74:
	bl.d L_9366e8
L_923e78:
	mov r1,0x0
L_923e7c:
	mov r4,r42
L_923e80:
	mov_s r1,0x80062c
L_923e86:
	bbit0 r4,0xe,L_923ea4
L_923e8a:
	ld_s r2,[r1]
L_923e8c:
	add_s sp,sp,0x8
L_923e8e:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_923e90:
	st_s r2,[r1]
L_923e92:
	ld blink,[sp, 0x4]
L_923e96:
	ld_s r14,[sp,0x8]
L_923e98:
	ld_s r15,[sp,0xc]
L_923e9a:
	ld r16,[sp, 0x10]
L_923e9e:
	j_s.d [blink]
L_923ea0:
	ld.ab r13,[sp,0x14]
	.global L_923ea4
L_923ea4:
	mov_s r14,0x0
L_923ea6:
	st_s r14,[r1]
L_923ea8:
	mov_s r2,0x802a14
L_923eae:
	ld_s r1,[r2,0xc]
L_923eb0:
	brne.d r1,0x0,L_923ec4
L_923eb4:
	mov r13,sp
L_923eb8:
	ldb r4,[0x85773c]
L_923ec0:
	brlt r4,0x2,L_923ecc
	.global L_923ec4
L_923ec4:
	b.d L_923ed0
L_923ec8:
	mov r3,0x0
	.global L_923ecc
L_923ecc:
	mov r3,0x1
	.global L_923ed0
L_923ed0:
	ldb r4,[r2, 0x54]
L_923ed4:
	extb_s r3,r3
L_923ed6:
	ldb r5,[gp, -0xf7]
L_923eda:
	mov_s r0,r13
L_923edc:
	add r1,r2,0xc
L_923ee0:
	bl.d L_9357ec
L_923ee4:
	mov r2,0x1
L_923ee8:
	ldw r5,[sp, 0x2]
L_923eec:
	ldw r8,[sp, 0x4]
L_923ef0:
	mov r4,0x802e14
L_923ef8:
	ld r10,[r4, 0x40]
L_923efc:
	add r8,r8,r5
L_923f00:
	add r10,r10,r8
L_923f04:
	st r10,[r4, 0x40]
L_923f08:
	mov r6,0x14000100
L_923f10:
	mov r32,r6
L_923f14:
	st.ab r6,[r25,0x4]
L_923f18:
	bclr r25,r25,0xa
L_923f1c:
	mov_s r0,r15
L_923f1e:
	mov_s r1,0x5
L_923f20:
	mov_s r2,r13
L_923f22:
	mov_s r3,0x0
L_923f24:
	mov r4,r3
L_923f28:
	bl.d L_93b430
L_923f2c:
	mov r5,r3
L_923f30:
	cmp r0,0x0
L_923f34:
	beq L_9241a8
L_923f38:
	ldb r3,[0x80229c]
L_923f40:
	mov r5,0x802f14
L_923f48:
	rsub.f r6,r3,0x1
L_923f4c:
	mov r11,0x1
L_923f50:
	mov.cs r6,0x0
L_923f54:
	stb r6,[r5, 0x1]
L_923f58:
	st r14,[0x800714]
L_923f60:
	bl.d L_937cac
L_923f64:
	stb r11,[r5, 0x1e]
L_923f68:
	mov r7,0x2040010
L_923f70:
	mov r32,r7
L_923f74:
	st.ab r7,[r25,0x4]
L_923f78:
	bclr r25,r25,0xa
L_923f7c:
	mov r8,0x8022c8
L_923f84:
	ld r9,[r8, 0x18]
L_923f88:
	mov_s r0,0x1
L_923f8a:
	add r9,r9,0x1
L_923f8e:
	st r9,[r8, 0x18]
L_923f92:
	stb r0,[r16, 0x4]
L_923f96:
	ldb r7,[0x802f15]
L_923f9e:
	cmp r7,0x0
L_923fa2:
	beq L_9241a0
L_923fa6:
	mov_s r1,0x3c000004
L_923fac:
	mov r32,r1
L_923fb0:
	st.ab r1,[r25,0x4]
L_923fb4:
	bclr r25,r25,0xa
L_923fb8:
	mov r9,0x14000400
L_923fc0:
	mov r32,r9
L_923fc4:
	st.ab r9,[r25,0x4]
L_923fc8:
	bclr r25,r25,0xa
L_923fcc:
	mov_s r3,r42
L_923fce:
	btst_s r3,0x7
L_923fd0:
	bne L_9241c8
	.global L_923fd4
L_923fd4:
	mov_s r1,r42
L_923fd6:
	bbit0 r1,0x7,L_923fd4
L_923fda:
	mov_s r0,0x14
L_923fdc:
	asl_s r0,r0,0x18
L_923fde:
	mov_s r32,r0
L_923fe0:
	st.ab r0,[r25,0x4]
L_923fe4:
	bclr r25,r25,0xa
L_923fe8:
	ld r13,[0x802a1c]
L_923ff0:
	mov_s r0,0x52
L_923ff2:
	add r13,r13,0x1ef
L_923ff6:
	asl_s r0,r0,0x18
L_923ff8:
	mov r32,r0
L_923ffc:
	st.ab r0,[r25,0x4]
L_924000:
	bclr r25,r25,0xa
L_924004:
	mov_s r1,0x52
L_924006:
	asl_s r1,r1,0x18
L_924008:
	mov r32,r1
L_92400c:
	st.ab r1,[r25,0x4]
L_924010:
	bclr r25,r25,0xa
L_924014:
	mov_s r2,0x49000040
L_92401a:
	mov_s r32,r2
L_92401c:
	st.ab r2,[r25,0x4]
L_924020:
	bclr r25,r25,0xa
L_924024:
	or r13,r13,0x4f000000
L_92402c:
	mov r32,r13
L_924030:
	st.ab r13,[r25,0x4]
L_924034:
	bclr r25,r25,0xa
L_924038:
	mov_s r3,0x52000308
L_92403e:
	mov_s r32,r3
L_924040:
	st.ab r3,[r25,0x4]
L_924044:
	bclr r25,r25,0xa
L_924048:
	ld r13,[0x802a14]
L_924050:
	mov r4,0x53000000
L_924058:
	add r13,r13,0xa5
L_92405c:
	mov r32,r4
L_924060:
	st.ab r4,[r25,0x4]
L_924064:
	bclr r25,r25,0xa
L_924068:
	mov r5,0x53000000
L_924070:
	mov r32,r5
L_924074:
	st.ab r5,[r25,0x4]
L_924078:
	bclr r25,r25,0xa
L_92407c:
	mov r6,0x49000080
L_924084:
	mov r32,r6
L_924088:
	st.ab r6,[r25,0x4]
L_92408c:
	bclr r25,r25,0xa
L_924090:
	or r13,r13,0x50000000
L_924098:
	mov r32,r13
L_92409c:
	st.ab r13,[r25,0x4]
L_9240a0:
	bclr r25,r25,0xa
L_9240a4:
	mov r7,0x5300090c
L_9240ac:
	mov r32,r7
L_9240b0:
	st.ab r7,[r25,0x4]
L_9240b4:
	bclr r25,r25,0xa
L_9240b8:
	mov r8,0x54000000
L_9240c0:
	mov r32,r8
L_9240c4:
	st.ab r8,[r25,0x4]
L_9240c8:
	bclr r25,r25,0xa
L_9240cc:
	mov r9,0x54000000
L_9240d4:
	mov r32,r9
L_9240d8:
	st.ab r9,[r25,0x4]
L_9240dc:
	bclr r25,r25,0xa
L_9240e0:
	mov_s r0,0x49000100
L_9240e6:
	mov_s r32,r0
L_9240e8:
	st.ab r0,[r25,0x4]
L_9240ec:
	bclr r25,r25,0xa
L_9240f0:
	mov_s r1,0x51000339
L_9240f6:
	mov_s r32,r1
L_9240f8:
	st.ab r1,[r25,0x4]
L_9240fc:
	bclr r25,r25,0xa
L_924100:
	mov_s r2,0x5400030c
L_924106:
	mov_s r32,r2
L_924108:
	st.ab r2,[r25,0x4]
L_92410c:
	bclr r25,r25,0xa
L_924110:
	ld.as r8,[gp,-0x11]
L_924114:
	and r8,r8,0xffff0fff
L_92411c:
	st.as r8,[gp,-0x11]
L_924120:
	or r8,r8,0x1d000000
L_924128:
	mov r32,r8
L_92412c:
	st.ab r8,[r25,0x4]
L_924130:
	bclr r25,r25,0xa
L_924134:
	nop_s
L_924136:
	nop_s
L_924138:
	mov 0x0,0x0
L_92413c:
	bmsk r7,r40,0x2
L_924140:
	brne r7,0x5,L_9241d8
	.global L_924144
L_924144:
	mov_s r0,0x5
L_924146:
	mov_s r1,r0
L_924148:
	bl.d L_936594
L_92414c:
	mov r2,0x4
L_924150:
	nop_s
L_924152:
	nop_s
L_924154:
	nop_s
L_924156:
	mov_s r2,r42
L_924158:
	bbit0 r2,0xe,L_9241e8
	.global L_92415c
L_92415c:
	ld r0,[0x802a18]
L_924164:
	or r0,r0,0x51000000
L_92416c:
	mov r32,r0
L_924170:
	st.ab r0,[r25,0x4]
L_924174:
	bclr r25,r25,0xa
L_924178:
	mov_s r3,0x5400090a
L_92417e:
	mov_s r32,r3
L_924180:
	st.ab r3,[r25,0x4]
L_924184:
	bclr r25,r25,0xa
L_924188:
	mov r4,0x5200000e
L_924190:
	mov r32,r4
L_924194:
	st.ab r4,[r25,0x4]
L_924198:
	bclr r25,r25,0xa
L_92419c:
	b L_9241a8
	.global L_9241a0
L_9241a0:
	mov r8,r42
L_9241a4:
	bbit0 r8,0x7,L_9241a0
	.global L_9241a8
L_9241a8:
	mov_s r3,0x0
L_9241aa:
	st.as r3,[gp,0x33]
L_9241ae:
	st.as r3,[gp,0x34]
L_9241b2:
	add_s sp,sp,0x8
L_9241b4:
	ld blink,[sp, 0x4]
L_9241b8:
	ld_s r14,[sp,0x8]
L_9241ba:
	ld_s r15,[sp,0xc]
L_9241bc:
	ld r16,[sp, 0x10]
L_9241c0:
	j.d [blink]
L_9241c4:
	ld.ab r13,[sp,0x14]
	.global L_9241c8
L_9241c8:
	mov r0,blink
L_9241cc:
	bl.d L_926618
L_9241d0:
	mov r1,0x75
L_9241d4:
	b L_923fd4
	.global L_9241d8
L_9241d8:
	mov r0,blink
L_9241dc:
	bl.d L_926618
L_9241e0:
	mov r1,0x77
L_9241e4:
	b L_924144
	.global L_9241e8
L_9241e8:
	mov r0,blink
L_9241ec:
	bl.d L_926618
L_9241f0:
	mov r1,0x84
L_9241f4:
	b L_92415c
	.global L_9241f8
L_9241f8:
	add_s sp,sp,0x8
L_9241fa:
	ld blink,[sp, 0x4]
L_9241fe:
	ld_s r14,[sp,0x8]
L_924200:
	ld_s r15,[sp,0xc]
L_924202:
	ld r16,[sp, 0x10]
L_924206:
	j_s.d [blink]
L_924208:
	ld.ab r13,[sp,0x14]
