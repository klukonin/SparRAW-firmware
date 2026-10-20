/* bti__bi2_event_step @ 0x936e40, 1300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BI2 event
 *   BI1 interrupt Out Of BTI period
 * Зовут его: bti_transmitter_bi2_flow
 * Зовёт сам: bf_pending__set_bit, bti__count_sweep_round, bti_worker_bi2_step, rx_capture__match_filter, rx_meas__append_sample, rx_meas__capture_frame, rx_meas__finish_with_8830ec, uc_bi_counter_in_window, uc_log__emit_snapshot, uc_read_bi_sync, uc_read_tsf_lo, uc_wait_event_busy
 * Глобалы (через gp): 0x800598
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti__bi2_event_step
bti__bi2_event_step:
	.global L_936e40
L_936e40:
	st.a r13,[sp,-0x18]
L_936e44:
	st blink,[sp, 0x4]
L_936e48:
	st_s r14,[sp,0x8]
L_936e4a:
	st_s r15,[sp,0xc]
L_936e4c:
	st r16,[sp, 0x10]
L_936e50:
	st r17,[sp, 0x14]
L_936e54:
	sub_s sp,sp,0x8
L_936e56:
	mov_s r14,r0
L_936e58:
	mov_s r0,0x2051030
L_936e5e:
	mov_s r32,r0
L_936e60:
	st.ab r0,[r25,0x4]
L_936e64:
	bclr r25,r25,0xa
L_936e68:
	bl L_9364c8
L_936e6c:
	st r0,[0x802a78]
L_936e74:
	bl.d L_937474
L_936e78:
	mov r0,r14
L_936e7c:
	cmp r0,0x0
L_936e80:
	beq L_937328
L_936e84:
	bl L_936b60
L_936e88:
	cmp r0,0x0
L_936e8c:
	beq L_937328
	.global L_936e90
L_936e90:
	mov_s r0,0x20
L_936e92:
	bset_s r0,r0,0xc
L_936e94:
	bl.d L_9366e8
L_936e98:
	mov r1,0x0
L_936e9c:
	mov_s r2,r42
L_936e9e:
	btst_s r2,0xc
L_936ea0:
	beq L_937298
L_936ea4:
	ld r0,[r14]
L_936ea8:
	bl.d L_923a84
L_936eac:
	mov r1,0x1
L_936eb0:
	breq_s r0,0,L_936e90
L_936eb2:
	mov_s r1,0x49000100
L_936eb8:
	mov r32,r1
L_936ebc:
	st.ab r1,[r25,0x4]
L_936ec0:
	bclr r25,r25,0xa
L_936ec4:
	bmsk r1,r38,0x0
L_936ec8:
	mov_s r13,0x802f14
L_936ece:
	stb_s r1,[r13]
L_936ed0:
	mov_s r15,0x804010
L_936ed6:
	ldb r6,[r15, 0x19]
L_936eda:
	ldb_s r3,[r15,0x18]
L_936edc:
	asl r6,r6,0x8
L_936ee0:
	or r3,r3,r6
L_936ee4:
	bic.f r3,r3,-0x781
L_936ee8:
	bne_s L_936f4c
L_936eea:
	ldb r11,[r15, 0x17]
L_936eee:
	ldb r10,[r15, 0x18]
L_936ef2:
	ldb r9,[r15, 0x19]
L_936ef6:
	ldb r8,[r15, 0x1a]
L_936efa:
	stb r11,[r13, 0x2]
L_936efe:
	stb r10,[r13, 0x3]
L_936f02:
	stb r9,[r13, 0x4]
L_936f06:
	stb r8,[r13, 0x5]
L_936f0a:
	ldb r11,[r15, 0x1b]
L_936f0e:
	ldb r10,[r15, 0x1c]
L_936f12:
	stb r11,[r13, 0x6]
L_936f16:
	stb r10,[r13, 0x7]
L_936f1a:
	ldb_s r2,[r15,0x1d]
L_936f1c:
	ldb_s r3,[r13,0x3]
L_936f1e:
	lsr_s r3,r3,0x2
L_936f20:
	bmsk_s r3,r3,0x3
L_936f22:
	cmp_s r3,0x4
L_936f24:
	bmsk r2,r2,0x1
L_936f28:
	bcc.d L_937118
L_936f2c:
	st r2,[r13, 0x8]
L_936f30:
	mov r10,0x0
L_936f34:
	stb r10,[r13, 0x1]
L_936f38:
	stb r10,[r13, 0x1f]
L_936f3c:
	mov r16,0x800
L_936f44:
	b.d L_936fe8
L_936f48:
	mov r17,0x1
	.global L_936f4c
L_936f4c:
	mov r5,0x0
L_936f50:
	stb r5,[r13, 0x1]
	.global L_936f54
L_936f54:
	stb r5,[r13, 0x1f]
L_936f58:
	mov r16,0x800
L_936f60:
	breq.d r5,0x0,L_936fd0
L_936f64:
	mov r17,0x1
L_936f68:
	ld.as r10,[gp,-0x11]
L_936f6c:
	and r10,r10,0xffff0fff
L_936f74:
	or r0,r10,0xd000
L_936f7c:
	or r2,r10,0x1d00d000
L_936f84:
	st.as r0,[gp,-0x11]
L_936f88:
	mov r32,r2
L_936f8c:
	st.ab r2,[r25,0x4]
L_936f90:
	bclr r25,r25,0xa
L_936f94:
	nop_s
L_936f96:
	nop_s
L_936f98:
	nop_s
L_936f9a:
	mov r11,r40
L_936f9e:
	st r11,[sp]
L_936fa2:
	lsr r11,r11,0x9
L_936fa6:
	bmsk r11,r11,0xa
L_936faa:
	sub r2,r11,r16
L_936fae:
	cmp r11,0x3ff
L_936fb2:
	mov.hi r3,r2
L_936fb6:
	mov.ls r3,r11
L_936fba:
	mov_s r13,0x802f14
L_936fc0:
	st_s r3,[r13,0x10]
L_936fc2:
	ldw_s r0,[r15,0x12]
L_936fc4:
	lsr_s r0,r0,0xa
L_936fc6:
	stb_s r0,[r13,0xc]
L_936fc8:
	ldw_s r0,[r15,0x14]
L_936fca:
	bmsk_s r0,r0,0x1
L_936fcc:
	stb r0,[r13, 0xd]
	.global L_936fd0
L_936fd0:
	ldw r11,[r15, 0x4]
L_936fd4:
	ldw r10,[r15, 0x6]
L_936fd8:
	ldw r9,[r15, 0x8]
L_936fdc:
	stw r11,[r13, 0x14]
L_936fe0:
	stw r10,[r13, 0x16]
L_936fe4:
	stw r9,[r13, 0x18]
	.global L_936fe8
L_936fe8:
	mov_s r2,0x886000
L_936fee:
	ld r11,[r2, 0x24]
L_936ff2:
	bmsk r11,r11,0x1e
L_936ff6:
	st r11,[r2, 0x24]
L_936ffa:
	ld_s r0,[gp,-0x44]
L_936ffc:
	and r0,r0,0xffff0fff
L_937004:
	or r1,r0,0xd000
L_93700c:
	or r0,r0,0x1d00d000
L_937014:
	st.as r1,[gp,-0x11]
L_937018:
	mov r32,r0
L_93701c:
	st.ab r0,[r25,0x4]
L_937020:
	bclr r25,r25,0xa
L_937024:
	nop_s
L_937026:
	nop_s
L_937028:
	nop_s
L_93702a:
	lsr r8,r40,0x9
L_93702e:
	bmsk r8,r8,0xa
L_937032:
	sub r1,r8,r16
L_937036:
	cmp r8,0x3ff
L_93703a:
	mov.ls r1,r8
L_93703e:
	mov_s r13,0x803134
L_937044:
	ld r4,[r13, 0xc]
L_937048:
	mov_s r15,sp
L_93704a:
	cmp r4,0x2
L_93704e:
	st_s r1,[sp,0x0]
L_937050:
	bne.d L_937224
L_937054:
	mov r16,0x0
L_937058:
	ld_s r3,[r13]
L_93705a:
	cmp_s r3,0x0
L_93705c:
	beq L_937224
L_937060:
	cmp r3,0x6
L_937064:
	bhi L_937224
L_937068:
	bl.d L_93e56c
L_93706c:
	mov r0,r13
L_937070:
	cmp_s r0,0x0
L_937072:
	beq L_937224
L_937076:
	ld r11,[r13]
L_93707a:
	sub.f r11,r11,0x1
L_93707e:
	beq_s L_9371fc
L_937080:
	cmp r11,0x1
L_937084:
	beq_s L_93720c
L_937086:
	cmp r11,0x2
L_93708a:
	beq_s L_937218
L_93708c:
	cmp r11,0x3
L_937090:
	beq L_937224
L_937094:
	cmp r11,0x4
L_937098:
	bne_s L_937224
L_93709a:
	ld.as r11,[gp,-0x11]
L_93709e:
	add r15,r13,0x18
L_9370a2:
	and r11,r11,0xffff0fff
L_9370aa:
	or r5,r11,0x5000
L_9370b2:
	st.as r5,[gp,-0x11]
L_9370b6:
	or r2,r11,0x1d005000
L_9370be:
	mov_s r32,r2
L_9370c0:
	st.ab r2,[r25,0x4]
L_9370c4:
	bclr r25,r25,0xa
L_9370c8:
	nop_s
L_9370ca:
	nop_s
L_9370cc:
	nop_s
L_9370ce:
	st r40,[r15]
L_9370d2:
	ld.as r10,[gp,-0x11]
L_9370d6:
	and r10,r10,0xffff0fff
L_9370de:
	or r7,r10,0x6000
L_9370e6:
	or r1,r10,0x1d006000
L_9370ee:
	st.as r7,[gp,-0x11]
L_9370f2:
	mov_s r32,r1
L_9370f4:
	st.ab r1,[r25,0x4]
L_9370f8:
	bclr r25,r25,0xa
L_9370fc:
	nop_s
L_9370fe:
	nop_s
L_937100:
	mov 0x0,0x0
L_937104:
	st r40,[r15, 0x4]
L_937108:
	st r17,[r13, 0xc]
L_93710c:
	bl.d L_9216f8
L_937110:
	mov r0,0x0
L_937114:
	b L_937224
	.global L_937118
L_937118:
	mov r4,0x1
L_93711c:
	mov r11,0x803124
L_937124:
	ld r9,[r11, 0x4]
L_937128:
	stb r4,[r13, 0x1]
L_93712c:
	brne.d r9,0x3,L_937144
L_937130:
	ld r3,[r11, 0x8]
	.global L_937134
L_937134:
	ldw r5,[r13, 0x24]
L_937138:
	add r5,r5,0x1
L_93713c:
	b.d L_9371c0
L_937140:
	stw r5,[r13, 0x24]
	.global L_937144
L_937144:
	breq r9,0x0,L_9371a4
	.global L_937148
L_937148:
	brne r9,0x1,L_937164
L_93714c:
	ldb r9,[0x802194]
L_937154:
	sub.f r9,r9,0x0
L_937158:
	mov.ne r9,0x1
L_93715c:
	extb.f 0x0,r9
L_937160:
	beq L_937134
	.global L_937164
L_937164:
	brne r3,0x0,L_93717c
L_937168:
	ldb r6,[r13, 0x3]
L_93716c:
	ldb r9,[r13, 0x2]
L_937170:
	asl r6,r6,0x8
L_937174:
	or r9,r9,r6
L_937178:
	bbit1 r9,0x1,L_937194
	.global L_93717c
L_93717c:
	brne r3,0x1,L_9371c8
L_937180:
	ldb r4,[r13, 0x3]
L_937184:
	ldb r0,[r13, 0x2]
L_937188:
	asl r4,r4,0x8
L_93718c:
	or r0,r0,r4
L_937190:
	bbit1 r0,0x1,L_9371c8
	.global L_937194
L_937194:
	ldw r6,[r13, 0x26]
L_937198:
	add r6,r6,0x1
L_93719c:
	b.d L_9371c0
L_9371a0:
	stw r6,[r13, 0x26]
	.global L_9371a4
L_9371a4:
	ldb r4,[0x802194]
L_9371ac:
	sub.f r4,r4,0x0
L_9371b0:
	mov.ne r4,0x1
L_9371b4:
	extb.f 0x0,r4
L_9371b8:
	bne L_937134
L_9371bc:
	b L_937148
	.global L_9371c0
L_9371c0:
	b.d L_936f54
L_9371c4:
	mov r5,0x0
	.global L_9371c8
L_9371c8:
	ldw r7,[r11]
L_9371cc:
	brlt r7,0x1,L_9371e8
L_9371d0:
	sub r7,r7,0x1
L_9371d4:
	ldw r8,[r13, 0x28]
L_9371d8:
	stw r7,[r11]
L_9371dc:
	add r8,r8,0x1
L_9371e0:
	b.d L_9371c0
L_9371e4:
	stw r8,[r13, 0x28]
	.global L_9371e8
L_9371e8:
	ldw r9,[r13, 0x2a]
L_9371ec:
	add r9,r9,0x1
L_9371f0:
	stw r9,[r13, 0x2a]
L_9371f4:
	b.d L_936f54
L_9371f8:
	mov r5,0x1
	.global L_9371fc
L_9371fc:
	mov r0,r13
L_937200:
	bl.d L_928854
L_937204:
	mov r1,r15
L_937208:
	b L_937224
	.global L_93720c
L_93720c:
	bl.d L_92893c
L_937210:
	mov r0,r13
L_937214:
	b L_937224
	.global L_937218
L_937218:
	mov r0,r13
L_93721c:
	bl.d L_927f6c
L_937220:
	mov r1,r15
	.global L_937224
L_937224:
	ld.as r1,[gp,0x1c]
L_937228:
	brne r1,0x0,L_937288
	.global L_93722c
L_93722c:
	brne r1,0x0,L_937268
L_937230:
	ld r11,[0x801424]
L_937238:
	bbit1 r11,0x0,L_937268
	.global L_93723c
L_93723c:
	mov r9,0x801030
L_937244:
	ldb r8,[r9, 0x50]
L_937248:
	ld_s r0,[sp,0x0]
L_93724a:
	asl r8,r8,0x3
L_93724e:
	add2 r8,r8,r8
L_937252:
	add r8,r8,r9
L_937256:
	ld r5,[r8, 0x18]
L_93725a:
	brge r5,r0,L_937268
L_93725e:
	st r0,[r8, 0x18]
L_937262:
	mov_s r1,0x1
L_937264:
	stb r1,[r8, 0x14]
	.global L_937268
L_937268:
	stb r16,[r14, 0x5]
L_93726c:
	mov_s r0,0x1
L_93726e:
	add_s sp,sp,0x8
L_937270:
	ld blink,[sp, 0x4]
L_937274:
	ld_s r14,[sp,0x8]
L_937276:
	ld_s r15,[sp,0xc]
L_937278:
	ld r16,[sp, 0x10]
L_93727c:
	ld r17,[sp, 0x14]
L_937280:
	j.d [blink]
L_937284:
	ld.ab r13,[sp,0x18]
	.global L_937288
L_937288:
	ld r5,[0x801424]
L_937290:
	bbit1 r5,0x0,L_93723c
L_937294:
	b L_93722c
	.global L_937298
L_937298:
	ld.as r1,[gp,-0x11]
L_93729c:
	and r1,r1,0xffff0fff
L_9372a4:
	bset r8,r1,0xe
L_9372a8:
	or r1,r1,0x1d004000
L_9372b0:
	st.as r8,[gp,-0x11]
L_9372b4:
	mov r32,r1
L_9372b8:
	st.ab r1,[r25,0x4]
L_9372bc:
	bclr r25,r25,0xa
L_9372c0:
	nop_s
L_9372c2:
	nop_s
L_9372c4:
	nop_s
L_9372c6:
	bmsk r7,r40,0x19
L_9372ca:
	mov_s r2,0x802ec0
L_9372d0:
	ldw r10,[r2, 0x2]
L_9372d4:
	st.as r7,[gp,-0x15]
L_9372d8:
	add r10,r10,0x1
L_9372dc:
	stw r10,[r2, 0x2]
L_9372e0:
	mov r1,0x1001d5c
L_9372e8:
	bl.d L_92d13c
L_9372ec:
	mov r0,0x20
L_9372f0:
	mov r3,0x801030
L_9372f8:
	ld r9,[r3, 0xcc]
L_9372fc:
	add r9,r9,0x1
L_937300:
	st r9,[r3, 0xcc]
L_937304:
	bl.d L_9222e0
L_937308:
	mov r0,r14
L_93730c:
	mov_s r0,0x0
L_93730e:
	add_s sp,sp,0x8
L_937310:
	ld blink,[sp, 0x4]
L_937314:
	ld_s r14,[sp,0x8]
L_937316:
	ld_s r15,[sp,0xc]
L_937318:
	ld r16,[sp, 0x10]
L_93731c:
	ld r17,[sp, 0x14]
L_937320:
	j.d [blink]
L_937324:
	ld.ab r13,[sp,0x18]
	.global L_937328
L_937328:
	mov r1,0x1001d68
L_937330:
	bl.d L_92d13c
L_937334:
	mov r0,0x20
L_937338:
	mov_s r0,0x0
L_93733a:
	stb_s r0,[r14,0x4]
L_93733c:
	add_s sp,sp,0x8
L_93733e:
	ld blink,[sp, 0x4]
L_937342:
	ld_s r14,[sp,0x8]
L_937344:
	ld_s r15,[sp,0xc]
L_937346:
	ld r16,[sp, 0x10]
L_93734a:
	ld r17,[sp, 0x14]
L_93734e:
	j_s.d [blink]
L_937350:
	ld.ab r13,[sp,0x18]
