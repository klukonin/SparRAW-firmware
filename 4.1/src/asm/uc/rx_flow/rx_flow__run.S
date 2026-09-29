/* rx_flow__run @ 0x92ce9c, 2212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_flow.c
 *   SYSTEM
 * Зовут его: bi_manager_rx_step, rx_funcs__rx_flow, tx_flow_size_step, tx_initiator_rx_step, tx_initiator_substep, txss__init_sweep, txss__init_sweep_b, txss__prepare_frames, txss_rx_step
 * Зовёт сам: cf_end_mtp_step, mac__load_tx_vector, rfc_ctrl__switch, rw_g_801038, rx__mac_prepare, rx_flow__handle_frame, rx_flow__latch_phy_883830, rx_flow__phy_override, rx_flow_step, rx_funcs__handle_ppdu_report, rx_nav_update, tbl_801754__byte_by_index
 * Глобалы (через gp): 0x80052c, 0x800530, 0x800540, 0x800570, 0x800578, 0x80057c, 0x800604, 0x800608, 0x800610, 0x800614
 */
	.section .text.rx_flow__run,"ax",@progbits
	.global rx_flow__run
rx_flow__run:
	.global L_92ce9c
L_92ce9c:
	st.a r13,[sp,-0x18]
L_92cea0:
	st blink,[sp, 0x4]
L_92cea4:
	st_s r14,[sp,0x8]
L_92cea6:
	st_s r15,[sp,0xc]
L_92cea8:
	st r16,[sp, 0x10]
L_92ceac:
	st r17,[sp, 0x14]
L_92ceb0:
	mov r4,0xeeee09
L_92ceb8:
	mov r32,r4
L_92cebc:
	st.ab r4,[r25,0x4]
L_92cec0:
	bclr r25,r25,0xa
L_92cec4:
	ld r7,[0x8006b4]
L_92cecc:
	lr r7,[r7]
L_92ced0:
	bmsk r7,r7,0x17
L_92ced4:
	mov r32,r7
L_92ced8:
	st.ab r7,[r25,0x4]
L_92cedc:
	bclr r25,r25,0xa
L_92cee0:
	mov r1,0x0
L_92cee4:
	st.as r1,[gp,-0x10]
L_92cee8:
	ld.as r8,[gp,-0x11]
L_92ceec:
	mov r17,0x1
L_92cef0:
	and r8,r8,0xffff0fff
L_92cef8:
	st.as r8,[gp,-0x11]
L_92cefc:
	or r8,r8,0x1d000000
L_92cf04:
	mov r32,r8
L_92cf08:
	st.ab r8,[r25,0x4]
L_92cf0c:
	bclr r25,r25,0xa
L_92cf10:
	nop_s
L_92cf12:
	nop_s
L_92cf14:
	mov 0x0,0x0
L_92cf18:
	bl L_92b69c
L_92cf1c:
	bmsk r5,r40,0x2
L_92cf20:
	st.as r5,[gp,0x1]
L_92cf24:
	mov r4,0x0
L_92cf28:
	brne.d r5,0x5,L_92cf58
L_92cf2c:
	st.as r4,[gp,0x12]
L_92cf30:
	mov r5,0x4d000000
L_92cf38:
	mov r32,r5
L_92cf3c:
	st.ab r5,[r25,0x4]
L_92cf40:
	bclr r25,r25,0xa
L_92cf44:
	nop_s
L_92cf46:
	nop_s
L_92cf48:
	nop_s
L_92cf4a:
	mov_s r1,r55
L_92cf4c:
	ld.as r5,[gp,0x1]
L_92cf50:
	cmp r1,0x160
L_92cf54:
	mov.cc r17,0x0
	.global L_92cf58
L_92cf58:
	cmp r5,0x0
L_92cf5c:
	mov.eq r17,0x0
L_92cf60:
	cmp.ne r17,0x0
L_92cf64:
	bne L_92cf80
L_92cf68:
	mov r11,0x801458
L_92cf70:
	ld r7,[r11, 0x44]
L_92cf74:
	add r7,r7,0x1
L_92cf78:
	b.d L_92cfc8
L_92cf7c:
	st r7,[r11, 0x44]
	.global L_92cf80
L_92cf80:
	mov r6,0x1f006000
L_92cf88:
	mov r32,r6
L_92cf8c:
	st.ab r6,[r25,0x4]
L_92cf90:
	bclr r25,r25,0xa
L_92cf94:
	mov_s r0,0x38000300
L_92cf9a:
	mov_s r32,r0
L_92cf9c:
	st.ab r0,[r25,0x4]
L_92cfa0:
	bclr r25,r25,0xa
L_92cfa4:
	mov_s r1,0x3600003f
L_92cfaa:
	mov_s r32,r1
L_92cfac:
	st.ab r1,[r25,0x4]
L_92cfb0:
	bclr r25,r25,0xa
L_92cfb4:
	mov_s r2,0x6000101
L_92cfba:
	mov_s r32,r2
L_92cfbc:
	st.ab r2,[r25,0x4]
L_92cfc0:
	bclr r25,r25,0xa
L_92cfc4:
	mov r17,0x1
	.global L_92cfc8
L_92cfc8:
	mov r7,0x4d000000
L_92cfd0:
	mov r32,r7
L_92cfd4:
	st.ab r7,[r25,0x4]
L_92cfd8:
	bclr r25,r25,0xa
L_92cfdc:
	nop_s
L_92cfde:
	nop_s
L_92cfe0:
	nop_s
L_92cfe2:
	st.as r55,[gp,0x2]
L_92cfe6:
	ld.as r2,[gp,-0x11]
L_92cfea:
	and r2,r2,0xffff0fff
L_92cff2:
	or r1,r2,0xa000
L_92cffa:
	or r2,r2,0x1d00a000
L_92d002:
	st.as r1,[gp,-0x11]
L_92d006:
	mov_s r32,r2
L_92d008:
	st.ab r2,[r25,0x4]
L_92d00c:
	bclr r25,r25,0xa
L_92d010:
	nop_s
L_92d012:
	nop_s
L_92d014:
	nop_s
L_92d016:
	mov_s r3,r40
L_92d018:
	lsr r14,r3,0x8
L_92d01c:
	bmsk_s r14,r14,0x5
L_92d01e:
	lsr_s r3,r3,0x10
L_92d020:
	bmsk r1,r3,0x5
L_92d024:
	sub_s r1,r1,r14
L_92d026:
	bmsk_s r1,r1,0x5
L_92d028:
	brhs r1,0x2,L_92d0bc
	.global L_92d02c
L_92d02c:
	ld.as r13,[gp,0x15]
L_92d030:
	mov_s r3,0x8
L_92d032:
	bmsk_s r13,r13,0x5
L_92d034:
	mov_s r2,0x801418
L_92d03a:
	st_s r3,[r2]
L_92d03c:
	ld r15,[0x801a78]
L_92d044:
	mov_s r3,0x0
L_92d046:
	ld r11,[r2, 0x10]
L_92d04a:
	st_s r3,[r2,0xc]
L_92d04c:
	bic r11,r11,-0x9
L_92d050:
	bset r11,r11,0x1f
L_92d054:
	st r11,[r2, 0x10]
L_92d058:
	breq.d r14,r13,L_92d0d4
L_92d05c:
	mov r16,0x1
L_92d060:
	st.as r14,[gp,0x15]
L_92d064:
	mov r8,0x20d2000
L_92d06c:
	mov r32,r8
L_92d070:
	st.ab r8,[r25,0x4]
L_92d074:
	bclr r25,r25,0xa
L_92d078:
	mov_s r0,r40
L_92d07a:
	bbit1 r0,0x18,L_92d098
L_92d07e:
	mov_s r0,0x0
L_92d080:
	bset r0,r0,0x10
L_92d084:
	bl.d L_93187c
L_92d088:
	mov r1,0x0
L_92d08c:
	ld.as r3,[gp,0x15]
L_92d090:
	add r3,r3,0x1
L_92d094:
	st.as r3,[gp,0x15]
	.global L_92d098
L_92d098:
	ld.as r5,[gp,0x14]
L_92d09c:
	mov r9,0xeeee04
L_92d0a4:
	add r5,r5,0x1
L_92d0a8:
	st.as r5,[gp,0x14]
L_92d0ac:
	mov r32,r9
L_92d0b0:
	st.ab r9,[r25,0x4]
L_92d0b4:
	bclr r25,r25,0xa
L_92d0b8:
	b L_92d3fc
	.global L_92d0bc
L_92d0bc:
	mov_s r0,blink
L_92d0be:
	mov_s r2,0x10010dc
L_92d0c4:
	mov r1,0x44
L_92d0c8:
	bl.d L_925548
L_92d0cc:
	mov r3,0x565
L_92d0d0:
	b L_92d02c
	.global L_92d0d4
L_92d0d4:
	ld.as r7,[gp,-0x11]
L_92d0d8:
	and r7,r7,0xffff0fff
L_92d0e0:
	st.as r7,[gp,-0x11]
L_92d0e4:
	or r7,r7,0x1d000000
L_92d0ec:
	mov r32,r7
L_92d0f0:
	st.ab r7,[r25,0x4]
L_92d0f4:
	bclr r25,r25,0xa
L_92d0f8:
	nop_s
L_92d0fa:
	nop_s
L_92d0fc:
	nop_s
L_92d0fe:
	bmsk r3,r40,0x2
L_92d102:
	mov_s r32,r3
L_92d104:
	st.ab r3,[r25,0x4]
L_92d108:
	bclr r25,r25,0xa
L_92d10c:
	bmsk r6,r40,0x2
L_92d110:
	cmp r6,0x5
L_92d114:
	bhi L_92d2d0
L_92d118:
	ld.as r4,[0x800bd8,r6]
L_92d120:
	j [r4]
L_92d124:
	ld.as r6,[gp,-0x11]
L_92d128:
	and r6,r6,0xffff0fff
L_92d130:
	or r8,r6,0xa000
L_92d138:
	or r6,r6,0x1d00a000
L_92d140:
	st.as r8,[gp,-0x11]
L_92d144:
	mov r32,r6
L_92d148:
	st.ab r6,[r25,0x4]
L_92d14c:
	bclr r25,r25,0xa
L_92d150:
	nop_s
L_92d152:
	nop_s
L_92d154:
	nop_s
L_92d156:
	lsr r10,r40,0x10
L_92d15a:
	bmsk r10,r10,0x5
L_92d15e:
	cmp_s r13,r10
L_92d160:
	bne L_92d2d0
L_92d164:
	mov r9,0x801458
L_92d16c:
	ld r6,[r9, 0x3c]
L_92d170:
	add r6,r6,0x1
L_92d174:
	st r6,[0x854d84]
L_92d17c:
	b.d L_92d3fc
L_92d180:
	st r6,[r9, 0x3c]
L_92d184:
	mov_s r0,0x1
L_92d186:
	mov_s r1,0x1
L_92d188:
	bl.d L_9316b4
L_92d18c:
	mov r2,0x4
L_92d190:
	bmsk r10,r40,0x2
L_92d194:
	breq r10,0x2,L_92d1c4
L_92d198:
	mov r6,0x801458
L_92d1a0:
	ld r8,[r6, 0x40]
L_92d1a4:
	mov r16,0x0
L_92d1a8:
	add r8,r8,0x1
L_92d1ac:
	st r8,[r6, 0x40]
L_92d1b0:
	mov_s r0,0xeeee05
L_92d1b6:
	mov_s r32,r0
L_92d1b8:
	st.ab r0,[r25,0x4]
L_92d1bc:
	bclr r25,r25,0xa
L_92d1c0:
	b L_92d2d0
	.global L_92d1c4
L_92d1c4:
	ld_s r0,[gp,-0x48]
L_92d1c6:
	or r0,r0,0x27007300
L_92d1ce:
	mov_s r32,r0
L_92d1d0:
	st.ab r0,[r25,0x4]
L_92d1d4:
	bclr r25,r25,0xa
L_92d1d8:
	mov_s r3,0x2004000
L_92d1de:
	mov_s r32,r3
L_92d1e0:
	st.ab r3,[r25,0x4]
L_92d1e4:
	bclr r25,r25,0xa
L_92d1e8:
	nop_s
L_92d1ea:
	nop_s
L_92d1ec:
	nop_s
L_92d1ee:
	mov_s r0,0xd
L_92d1f0:
	asl r0,r0,0xb
L_92d1f4:
	bl.d L_931808
L_92d1f8:
	mov r1,0x0
L_92d1fc:
	and r2,r42,0x4000
L_92d204:
	rsub.f r2,r2,0x1
L_92d208:
	mov.cs r2,0x0
L_92d20c:
	brne r2,0x1,L_92d230
L_92d210:
	ld.as r9,[gp,0x6]
L_92d214:
	bbit0 r9,0x1,L_92d230
L_92d218:
	bmsk r6,r40,0x2
L_92d21c:
	brne r6,0x2,L_92d230
L_92d220:
	ld r1,[0x8837b0]
L_92d228:
	btst r1,0x1
L_92d22c:
	bl.ne L_92a0c4
	.global L_92d230
L_92d230:
	ld.as r1,[gp,-0x11]
L_92d234:
	and r1,r1,0xffff0fff
L_92d23c:
	or r0,r1,0xa000
L_92d244:
	or r1,r1,0x1d00a000
L_92d24c:
	st.as r0,[gp,-0x11]
L_92d250:
	mov r32,r1
L_92d254:
	st.ab r1,[r25,0x4]
L_92d258:
	bclr r25,r25,0xa
L_92d25c:
	nop_s
L_92d25e:
	nop_s
L_92d260:
	mov 0x0,0x0
L_92d264:
	ld.as r9,[gp,-0x12]
L_92d268:
	or r9,r9,0x27007300
L_92d270:
	mov r32,r9
L_92d274:
	st.ab r9,[r25,0x4]
L_92d278:
	bclr r25,r25,0xa
L_92d27c:
	mov r4,0x2004000
L_92d284:
	mov r32,r4
L_92d288:
	st.ab r4,[r25,0x4]
L_92d28c:
	bclr r25,r25,0xa
L_92d290:
	nop_s
L_92d292:
	nop_s
L_92d294:
	mov 0x0,0x0
	.global L_92d298
L_92d298:
	mov r4,r42
L_92d29c:
	bbit1 r4,0xe,L_92d2a8
L_92d2a0:
	mov r10,r49
L_92d2a4:
	bbit0 r10,0xd,L_92d298
	.global L_92d2a8
L_92d2a8:
	bl.d L_92ce6c
L_92d2ac:
	mov r10,r49
L_92d2b0:
	lsr r11,r40,0x8
L_92d2b4:
	bmsk r11,r11,0x5
L_92d2b8:
	lsr r14,r40,0x10
L_92d2bc:
	bmsk r14,r14,0x5
L_92d2c0:
	sub r9,r14,r11
L_92d2c4:
	bmsk r9,r9,0x5
L_92d2c8:
	brhs r9,0x2,L_92d340
	.global L_92d2cc
L_92d2cc:
	breq r14,r13,L_92d358
	.global L_92d2d0
L_92d2d0:
	cmp r17,0x0
L_92d2d4:
	cmp.eq r16,0x1
L_92d2d8:
	beq_s L_92d404
L_92d2da:
	cmp r16,0x0
L_92d2de:
	bne_s L_92d450
	.global L_92d2e0
L_92d2e0:
	mov r11,r37
L_92d2e4:
	bbit1 r11,0x18,L_92d2f0
L_92d2e8:
	mov r10,r38
L_92d2ec:
	bbit0 r10,0x0,L_92d314
	.global L_92d2f0
L_92d2f0:
	mov r9,r39
L_92d2f4:
	bbit0 r9,0xf,L_92d314
L_92d2f8:
	mov r8,r42
L_92d2fc:
	bbit0 r8,0x10,L_92d314
L_92d300:
	mov r6,0x801038
L_92d308:
	ld r5,[r6]
L_92d30c:
	bset r5,r5,0x1
L_92d310:
	st r5,[r6]
	.global L_92d314
L_92d314:
	bl L_92b7c4
L_92d318:
	mov_s r0,0x0
L_92d31a:
	mov_s r1,r0
L_92d31c:
	mov r2,r0
L_92d320:
	bl.d L_92fd3c
L_92d324:
	mov r3,r0
L_92d328:
	mov r7,0x20d2800
L_92d330:
	mov r32,r7
L_92d334:
	st.ab r7,[r25,0x4]
L_92d338:
	bclr r25,r25,0xa
L_92d33c:
	b L_92d520
	.global L_92d340
L_92d340:
	mov_s r0,blink
L_92d342:
	mov_s r2,0x10010dc
L_92d348:
	mov r1,0x45
L_92d34c:
	bl.d L_925548
L_92d350:
	mov r3,0x5cf
L_92d354:
	b L_92d2cc
	.global L_92d358
L_92d358:
	mov_s r1,0xeeee07
L_92d35e:
	mov_s r32,r1
L_92d360:
	st.ab r1,[r25,0x4]
L_92d364:
	bclr r25,r25,0xa
L_92d368:
	mov r32,r13
L_92d36c:
	st.ab r13,[r25,0x4]
L_92d370:
	bclr r25,r25,0xa
L_92d374:
	mov_s r2,0x801458
L_92d37a:
	ld_s r0,[r2,0x3c]
L_92d37c:
	mov_s r3,0x800654
L_92d382:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92d384:
	ld r4,[r3]
L_92d388:
	st_s r0,[r2,0x3c]
L_92d38a:
	add r4,r4,0x1
L_92d38e:
	st r4,[r3]
L_92d392:
	ld.as r5,[gp,0x6]
L_92d396:
	mov_s r3,0x855000
L_92d39c:
	ld r4,[0x8016b0]
L_92d3a4:
	bbit0.d r5,0x1,L_92d3d8
L_92d3a8:
	st.as r0,[r3,-0x9f]
L_92d3ac:
	bbit0 r4,0x1,L_92d3c4
L_92d3b0:
	ld r5,[r2, 0x54]
L_92d3b4:
	add r5,r5,0x1
L_92d3b8:
	st r5,[r2, 0x54]
L_92d3bc:
	b.d L_92d3fc
L_92d3c0:
	st.as r5,[r3,-0x99]
	.global L_92d3c4
L_92d3c4:
	ld r10,[r2, 0x50]
L_92d3c8:
	add r10,r10,0x1
L_92d3cc:
	st r10,[r2, 0x50]
L_92d3d0:
	b.d L_92d3fc
L_92d3d4:
	st.as r10,[r3,-0x9b]
	.global L_92d3d8
L_92d3d8:
	bbit0 r4,0x0,L_92d3f0
L_92d3dc:
	ld r11,[r2, 0x58]
L_92d3e0:
	add r11,r11,0x1
L_92d3e4:
	st r11,[r2, 0x58]
L_92d3e8:
	b.d L_92d3fc
L_92d3ec:
	st.as r11,[r3,-0x9c]
	.global L_92d3f0
L_92d3f0:
	ld_s r1,[r2,0x4c]
L_92d3f2:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92d3f4:
	st r1,[r2, 0x4c]
L_92d3f8:
	st.as r1,[r3,-0x9d]
	.global L_92d3fc
L_92d3fc:
	b.d L_92d2d0
L_92d400:
	mov r16,0x0
	.global L_92d404
L_92d404:
	mov r5,0xeeee06
L_92d40c:
	mov r32,r5
L_92d410:
	st.ab r5,[r25,0x4]
L_92d414:
	bclr r25,r25,0xa
L_92d418:
	ld.as r11,[gp,0x15]
L_92d41c:
	mov_s r13,0x801458
L_92d422:
	add r11,r11,0x1
L_92d426:
	ld_s r1,[r13,0x38]
L_92d428:
	st.as r11,[gp,0x15]
L_92d42c:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92d42e:
	st_s r1,[r13,0x38]
L_92d430:
	st r1,[0x857048]
L_92d438:
	mov r0,0x0
L_92d43c:
	bl.d L_9317fc
L_92d440:
	bset r0,r0,0x10
L_92d444:
	ld_s r0,[r13,0x48]
L_92d446:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92d448:
	b.d L_92d2e0
L_92d44c:
	st r0,[r13, 0x48]
	.global L_92d450
L_92d450:
	ld.as r2,[gp,0x15]
L_92d454:
	ld.as r5,[gp,0x38]
L_92d458:
	add r2,r2,0x1
L_92d45c:
	bbit0.d r5,0x2,L_92d4a8
L_92d460:
	st.as r2,[gp,0x15]
L_92d464:
	mov r0,0x0
L_92d468:
	bl.d L_92b9d0
L_92d46c:
	ld r1,[r15]
L_92d470:
	ld r4,[r15]
L_92d474:
	asl r4,r4,0x3
L_92d478:
	add3 r4,r4,r4
L_92d47c:
	add r4,r4,0x801190
L_92d484:
	ldb r1,[r4, 0x47]
L_92d488:
	breq_s r1,0,L_92d4a8
L_92d48a:
	ld r3,[r4, 0x14]
L_92d48e:
	ld_s r2,[r15,0x4]
L_92d490:
	bbit0 r3,r2,L_92d4a8
L_92d494:
	bl.d L_926d08
L_92d498:
	add r0,r4,0x34
L_92d49c:
	ld r9,[r15, 0xc]
L_92d4a0:
	bset r9,r9,0xb
L_92d4a4:
	st r9,[r15, 0xc]
	.global L_92d4a8
L_92d4a8:
	ld.as r8,[gp,0x37]
L_92d4ac:
	and.f 0x0,r8,0x7e0
L_92d4b4:
	beq L_92d4c0
L_92d4b8:
	bl L_92d740
L_92d4bc:
	b L_92d528
	.global L_92d4c0
L_92d4c0:
	bbit0 r8,0x1,L_92d508
L_92d4c4:
	ld.as r8,[gp,-0x11]
L_92d4c8:
	and r8,r8,0xffff0fff
L_92d4d0:
	or r7,r8,0x3000
L_92d4d8:
	or r8,r8,0x1d003000
L_92d4e0:
	st.as r7,[gp,-0x11]
L_92d4e4:
	mov r32,r8
L_92d4e8:
	st.ab r8,[r25,0x4]
L_92d4ec:
	bclr r25,r25,0xa
L_92d4f0:
	nop_s
L_92d4f2:
	nop_s
L_92d4f4:
	mov 0x0,0x0
L_92d4f8:
	extw r1,r40
L_92d4fc:
	bl.d L_92db44
L_92d500:
	mov r0,r15
L_92d504:
	b L_92d528
	.global L_92d508
L_92d508:
	bl.d L_92de68
L_92d50c:
	mov r0,r15
L_92d510:
	ld.as r5,[gp,0x38]
L_92d514:
	and.f 0x0,r5,0x3000000
L_92d51c:
	beq L_92d528
	.global L_92d520
L_92d520:
	b.d L_92d728
L_92d524:
	mov r16,0x0
	.global L_92d528
L_92d528:
	ld.as r2,[gp,-0x10]
L_92d52c:
	breq_s r2,0,L_92d538
L_92d52e:
	mov_s r13,0x801458
L_92d534:
	b L_92d6f8
	.global L_92d538
L_92d538:
	ld_s r0,[r15,0xc]
L_92d53a:
	bbit1 r0,0x0,L_92d548
L_92d53e:
	mov_s r13,0x801458
L_92d544:
	b L_92d6e0
	.global L_92d548
L_92d548:
	ld.as r2,[gp,0x38]
L_92d54c:
	ld r0,[r15]
L_92d550:
	bbit0.d r2,0x1e,L_92d5a8
L_92d554:
	ld_s r13,[r15,0x4]
L_92d556:
	asl r4,r0,0x2
L_92d55a:
	add1 r4,r4,r4
L_92d55e:
	ld r1,[r4,0x8016d8]
L_92d566:
	asl_s r13,r13,0x10
L_92d568:
	sub.f r1,r1,0x0
L_92d56c:
	mov.ne r1,0x1
L_92d570:
	extb.f 0x0,r1
L_92d574:
	beq.d L_92d58c
L_92d578:
	bset r13,r13,0x2
L_92d57c:
	bl L_92c1ec
L_92d580:
	asl r0,r0,0x8
L_92d584:
	b.d L_92d590
L_92d588:
	or r14,r0,0x3
	.global L_92d58c
L_92d58c:
	mov r14,0x0
	.global L_92d590
L_92d590:
	mov r6,0x1b001111
L_92d598:
	mov r32,r6
L_92d59c:
	st.ab r6,[r25,0x4]
L_92d5a0:
	bclr r25,r25,0xa
L_92d5a4:
	b L_92d620
	.global L_92d5a8
L_92d5a8:
	ld r7,[r15, 0x20]
L_92d5ac:
	ld r4,[r15, 0x8]
L_92d5b0:
	mov r14,0x0
L_92d5b4:
	brne.d r7,0x2,L_92d5cc
L_92d5b8:
	asl r13,r13,0x10
L_92d5bc:
	or r13,r13,0x103
	.global L_92d5c0
L_92d5c0:
	bset r13,r13,0x5
L_92d5c4:
	b.d L_92d5dc
L_92d5c8:
	asl r14,r4,0x10
	.global L_92d5cc
L_92d5cc:
	cmp r7,0x1
L_92d5d0:
	beq.d L_92d5c0
L_92d5d4:
	or.eq r13,r13,0x3
L_92d5d8:
	bset r13,r13,0x0
	.global L_92d5dc
L_92d5dc:
	ld.as r11,[gp,0x37]
L_92d5e0:
	bbit0 r11,0x1,L_92d60c
L_92d5e4:
	asl_s r3,r0,0x2
L_92d5e6:
	add1_s r3,r3,r3
L_92d5e8:
	ld r5,[r3,0x8016d8]
L_92d5f0:
	sub.f r5,r5,0x0
L_92d5f4:
	mov.ne r5,0x1
L_92d5f8:
	extb.f 0x0,r5
L_92d5fc:
	beq L_92d60c
L_92d600:
	bl L_92c1ec
L_92d604:
	asl_s r0,r0,0x8
L_92d606:
	or r0,r0,0x3
L_92d60a:
	or_s r14,r14,r0
	.global L_92d60c
L_92d60c:
	mov r8,0x1b001111
L_92d614:
	mov r32,r8
L_92d618:
	st.ab r8,[r25,0x4]
L_92d61c:
	bclr r25,r25,0xa
	.global L_92d620
L_92d620:
	or r13,r13,0x16000000
L_92d628:
	mov r32,r13
L_92d62c:
	st.ab r13,[r25,0x4]
L_92d630:
	bclr r25,r25,0xa
L_92d634:
	or r14,r14,0x17000000
L_92d63c:
	mov r32,r14
L_92d640:
	st.ab r14,[r25,0x4]
L_92d644:
	bclr r25,r25,0xa
L_92d648:
	nop_s
L_92d64a:
	nop_s
L_92d64c:
	mov 0x0,0x0
	.global L_92d650
L_92d650:
	mov r6,r43
L_92d654:
	bbit0 r6,0x1f,L_92d650
L_92d658:
	mov r9,r51
L_92d65c:
	bmsk r3,r9,0x3
L_92d660:
	st.as r3,[gp,0x3a]
L_92d664:
	lsr r3,r9,0x4
L_92d668:
	st.as r3,[gp,0x3b]
L_92d66c:
	lsr r14,r43,0x10
L_92d670:
	bmsk_s r14,r14,0x4
L_92d672:
	asl_s r0,r14,0x4
L_92d674:
	or r0,r0,0x3e000000
L_92d67c:
	mov r32,r0
L_92d680:
	st.ab r0,[r25,0x4]
L_92d684:
	bclr r25,r25,0xa
L_92d688:
	mov r4,0x37000020
L_92d690:
	mov r32,r4
L_92d694:
	st.ab r4,[r25,0x4]
L_92d698:
	bclr r25,r25,0xa
L_92d69c:
	mov_s r13,0x801458
L_92d6a2:
	ld_s r1,[r13,0xc]
L_92d6a4:
	mov_s r0,r15
L_92d6a6:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92d6a8:
	st r1,[r13, 0xc]
L_92d6ac:
	ld r10,[r15, 0xc]
L_92d6b0:
	lsr r9,r10,0xb
L_92d6b4:
	bmsk r9,r9,0x0
L_92d6b8:
	asl r9,r9,0xc
L_92d6bc:
	bclr r10,r10,0xc
L_92d6c0:
	or r9,r9,r10
L_92d6c4:
	st r9,[r15, 0xc]
L_92d6c8:
	bl.d L_937a0c
L_92d6cc:
	mov r1,r14
L_92d6d0:
	ld r11,[r15, 0xc]
L_92d6d4:
	bclr r11,r11,0xc
L_92d6d8:
	bset r11,r11,0x5
L_92d6dc:
	st r11,[r15, 0xc]
	.global L_92d6e0
L_92d6e0:
	ld r0,[0x801428]
L_92d6e8:
	lsr_s r0,r0
L_92d6ea:
	mov_s r1,r36
L_92d6ec:
	mov_s r2,r37
L_92d6ee:
	mov_s r3,r38
L_92d6f0:
	bl.d L_92fd3c
L_92d6f4:
	bmsk r0,r0,0x0
	.global L_92d6f8
L_92d6f8:
	ld_s r1,[r13,0x38]
L_92d6fa:
	mov r4,0x0
L_92d6fe:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92d700:
	st r1,[r13, 0x38]
L_92d704:
	st r1,[0x857048]
L_92d70c:
	st r4,[0x800654]
L_92d714:
	mov r5,0x20d2800
L_92d71c:
	mov r32,r5
L_92d720:
	st.ab r5,[r25,0x4]
L_92d724:
	bclr r25,r25,0xa
	.global L_92d728
L_92d728:
	ld blink,[sp, 0x4]
L_92d72c:
	mov_s r0,r16
L_92d72e:
	ld_s r14,[sp,0x8]
L_92d730:
	ld_s r15,[sp,0xc]
L_92d732:
	ld r16,[sp, 0x10]
L_92d736:
	ld r17,[sp, 0x14]
L_92d73a:
	j_s.d [blink]
L_92d73c:
	ld.ab r13,[sp,0x18]
