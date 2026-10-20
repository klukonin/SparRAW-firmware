/* rx_flow__handle_frame @ 0x931f04, 3812 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run
 * Зовёт сам: bf_pending__set_bit, mtp_service__dispatch, peer_masks__apply_op, rx__detect_field_1b_change, rx__is_brp_frame, rx__mac_prepare, rx__send_dmg_cts, rx__send_response_frame, rx__switch_to_rx_mode, rx__update_nav_from_frame, rx_capture__match_filter, rx_flow__send_imm_response
 * Глобалы (через gp): 0x800528, 0x80053c, 0x800564, 0x8005be, 0x8005e7, 0x8005f4, 0x8005f8, 0x800608, 0x80060c, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_flow__handle_frame
rx_flow__handle_frame:
	.global L_931f04
L_931f04:
	st.a r13,[sp,-0x20]
L_931f08:
	st blink,[sp, 0x4]
L_931f0c:
	st_s r14,[sp,0x8]
L_931f0e:
	st_s r15,[sp,0xc]
L_931f10:
	st r16,[sp, 0x10]
L_931f14:
	st r17,[sp, 0x14]
L_931f18:
	st r18,[sp, 0x18]
L_931f1c:
	st r19,[sp, 0x1c]
L_931f20:
	mov r9,r42
L_931f24:
	sub sp,sp,0x8
L_931f28:
	bbit1.d r9,0x10,L_931f3c
L_931f2c:
	mov_s r14,r0
L_931f2e:
	mov_s r0,0x0
L_931f30:
	bset r0,r0,0x10
L_931f34:
	bl.d L_9366e8
L_931f38:
	mov r1,0x0
	.global L_931f3c
L_931f3c:
	ldb r3,[gp, -0xf2]
L_931f40:
	cmp_s r3,0x0
L_931f42:
	beq_s L_932014
	.global L_931f44
L_931f44:
	mov_s r13,0x803134
L_931f4a:
	ld r4,[r13, 0xc]
L_931f4e:
	cmp r4,0x2
L_931f52:
	bne_s L_932068
L_931f54:
	ld_s r3,[r13]
L_931f56:
	cmp_s r3,0x0
L_931f58:
	beq_s L_932068
L_931f5a:
	cmp_s r3,0x6
L_931f5c:
	bhi L_932068
L_931f60:
	bl.d L_93e56c
L_931f64:
	mov r0,r13
L_931f68:
	cmp_s r0,0x0
L_931f6a:
	beq_s L_932068
L_931f6c:
	ld r11,[r13]
L_931f70:
	sub.f r11,r11,0x1
L_931f74:
	beq_s L_932040
L_931f76:
	cmp r11,0x1
L_931f7a:
	beq_s L_932050
L_931f7c:
	cmp r11,0x2
L_931f80:
	beq_s L_93205c
L_931f82:
	cmp r11,0x3
L_931f86:
	beq_s L_932068
L_931f88:
	cmp r11,0x4
L_931f8c:
	bne L_932068
L_931f90:
	ld.as r11,[gp,-0x11]
L_931f94:
	add r15,r13,0x18
L_931f98:
	and r11,r11,0xffff0fff
L_931fa0:
	or r8,r11,0x5000
L_931fa8:
	st.as r8,[gp,-0x11]
L_931fac:
	or r5,r11,0x1d005000
L_931fb4:
	mov r32,r5
L_931fb8:
	st.ab r5,[r25,0x4]
L_931fbc:
	bclr r25,r25,0xa
L_931fc0:
	nop_s
L_931fc2:
	nop_s
L_931fc4:
	nop_s
L_931fc6:
	st r40,[r15]
L_931fca:
	ld_s r0,[gp,-0x44]
L_931fcc:
	and r0,r0,0xffff0fff
L_931fd4:
	or r9,r0,0x6000
L_931fdc:
	or r0,r0,0x1d006000
L_931fe4:
	st.as r9,[gp,-0x11]
L_931fe8:
	mov r32,r0
L_931fec:
	st.ab r0,[r25,0x4]
L_931ff0:
	bclr r25,r25,0xa
L_931ff4:
	nop_s
L_931ff6:
	nop_s
L_931ff8:
	mov 0x0,0x0
L_931ffc:
	st r40,[r15, 0x4]
L_932000:
	mov r9,0x1
L_932004:
	st r9,[r13, 0xc]
L_932008:
	bl.d L_9216f8
L_93200c:
	mov r0,0x0
L_932010:
	b L_932068
	.global L_932014
L_932014:
	ldb r9,[gp, -0xf9]
L_932018:
	bmsk r9,r9,0x0
L_93201c:
	or r9,r9,0x32000000
L_932024:
	mov r32,r9
L_932028:
	st.ab r9,[r25,0x4]
L_93202c:
	bclr r25,r25,0xa
L_932030:
	ldb r10,[gp, -0xf9]
L_932034:
	add r10,r10,0x1
L_932038:
	b.d L_931f44
L_93203c:
	stb r10,[gp, -0xf9]
	.global L_932040
L_932040:
	mov r0,r13
L_932044:
	bl.d L_928854
L_932048:
	mov r1,0x0
L_93204c:
	b L_932068
	.global L_932050
L_932050:
	bl.d L_92893c
L_932054:
	mov r0,r13
L_932058:
	b L_932068
	.global L_93205c
L_93205c:
	mov r0,r13
L_932060:
	bl.d L_927f6c
L_932064:
	mov r1,0x0
	.global L_932068
L_932068:
	mov r1,r36
L_93206c:
	bbit1 r1,0x7,L_932098
	.global L_932070
L_932070:
	mov_s r0,r36
L_932072:
	btst_s r0,0x19
L_932074:
	beq L_9323d4
L_932078:
	bl L_92bdbc
L_93207c:
	cmp_s r0,0x0
L_93207e:
	beq L_9323d4
L_932082:
	mov_s r0,r38
L_932084:
	btst r0,0xb
L_932088:
	beq L_93238c
L_93208c:
	lsr r8,r38,0x8
L_932090:
	b.d L_932390
L_932094:
	bmsk r8,r8,0x2
	.global L_932098
L_932098:
	mov r4,0x802a6c
L_9320a0:
	ld r0,[r4, 0x8]
L_9320a4:
	mov_s r1,0x49000100
L_9320aa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9320ac:
	st r0,[r4, 0x8]
L_9320b0:
	mov r32,r1
L_9320b4:
	st.ab r1,[r25,0x4]
L_9320b8:
	bclr r25,r25,0xa
L_9320bc:
	bmsk r2,r38,0x0
L_9320c0:
	mov_s r13,0x802f14
L_9320c6:
	stb_s r2,[r13]
L_9320c8:
	mov_s r15,0x804010
L_9320ce:
	ldb r4,[r15, 0x19]
L_9320d2:
	ldb_s r3,[r15,0x18]
L_9320d4:
	asl r4,r4,0x8
L_9320d8:
	or r3,r3,r4
L_9320dc:
	bic.f r3,r3,-0x781
L_9320e0:
	bne_s L_932138
L_9320e2:
	ldb r11,[r15, 0x17]
L_9320e6:
	ldb r10,[r15, 0x18]
L_9320ea:
	ldb r9,[r15, 0x19]
L_9320ee:
	ldb r8,[r15, 0x1a]
L_9320f2:
	stb r11,[r13, 0x2]
L_9320f6:
	stb r10,[r13, 0x3]
L_9320fa:
	stb r9,[r13, 0x4]
L_9320fe:
	stb r8,[r13, 0x5]
L_932102:
	ldb r11,[r15, 0x1b]
L_932106:
	ldb r10,[r15, 0x1c]
L_93210a:
	stb r11,[r13, 0x6]
L_93210e:
	stb r10,[r13, 0x7]
L_932112:
	ldb_s r3,[r15,0x1d]
L_932114:
	ldb r4,[r13, 0x3]
L_932118:
	lsr r4,r4,0x2
L_93211c:
	bmsk r4,r4,0x3
L_932120:
	bmsk r3,r3,0x1
L_932124:
	brhs.d r4,0x4,L_9321e0
L_932128:
	st_s r3,[r13,0x8]
L_93212a:
	mov_s r1,0x0
L_93212c:
	stb r1,[r13, 0x1]
L_932130:
	b.d L_93215c
L_932134:
	stb r1,[r13, 0x1f]
	.global L_932138
L_932138:
	mov r8,0x0
L_93213c:
	stb r8,[r13, 0x1]
L_932140:
	stb r8,[r13, 0x1f]
	.global L_932144
L_932144:
	ldw r11,[r15, 0x4]
L_932148:
	ldw r10,[r15, 0x6]
L_93214c:
	ldw r9,[r15, 0x8]
L_932150:
	stw r11,[r13, 0x14]
L_932154:
	stw r10,[r13, 0x16]
L_932158:
	stw r9,[r13, 0x18]
	.global L_93215c
L_93215c:
	brne_s r2,0,L_932168
L_93215e:
	ldb r7,[r13, 0x1f]
L_932162:
	cmp r7,0x0
L_932166:
	beq_s L_932070
	.global L_932168
L_932168:
	ld.as r8,[gp,0x33]
L_93216c:
	ld r5,[0x8014c4]
L_932174:
	mov r15,0x1
L_932178:
	and r3,r8,0x8
L_93217c:
	brne.d r5,0x3,L_93219c
L_932180:
	mov r6,0x0
L_932184:
	ldb_s r0,[r13,0x3]
L_932186:
	ldb r8,[r13, 0x2]
L_93218a:
	asl_s r0,r0,0x8
L_93218c:
	or r8,r8,r0
L_932190:
	bbit0 r8,0x1,L_93219c
L_932194:
	ld r5,[r13, 0x8]
L_932198:
	brne r5,0x3,L_9321a0
	.global L_93219c
L_93219c:
	mov r15,0x0
	.global L_9321a0
L_9321a0:
	or.f 0x0,r3,r6
L_9321a4:
	bne_s L_9321bc
L_9321a6:
	mov_s r3,0x8022c8
L_9321ac:
	ld_s r2,[r3,0x68]
L_9321ae:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_9321b0:
	st_s r2,[r3,0x68]
L_9321b2:
	ld.as r3,[gp,0x34]
L_9321b6:
	bset_s r3,r3,0xa
L_9321b8:
	st.as r3,[gp,0x34]
	.global L_9321bc
L_9321bc:
	bl L_92f2bc
L_9321c0:
	ld r4,[r14, 0xc]
L_9321c4:
	cmp r15,0x0
L_9321c8:
	bclr r4,r4,0x0
L_9321cc:
	beq.d L_93233c
L_9321d0:
	st r4,[r14, 0xc]
L_9321d4:
	bl.d L_9343a8
L_9321d8:
	mov r0,0x0
L_9321dc:
	b L_932dc8
	.global L_9321e0
L_9321e0:
	mov r7,0x1
L_9321e4:
	mov r6,0x803124
L_9321ec:
	ld r3,[r6, 0x4]
L_9321f0:
	stb r7,[r13, 0x1]
L_9321f4:
	brne.d r3,0x3,L_93220c
L_9321f8:
	ld r7,[r6, 0x8]
	.global L_9321fc
L_9321fc:
	ldw r6,[r13, 0x24]
L_932200:
	add r6,r6,0x1
L_932204:
	b.d L_932288
L_932208:
	stw r6,[r13, 0x24]
	.global L_93220c
L_93220c:
	breq r3,0x0,L_93226c
	.global L_932210
L_932210:
	brne r3,0x1,L_93222c
L_932214:
	ldb r1,[0x802194]
L_93221c:
	sub.f r1,r1,0x0
L_932220:
	mov.ne r1,0x1
L_932224:
	extb.f 0x0,r1
L_932228:
	beq L_9321fc
	.global L_93222c
L_93222c:
	brne r7,0x0,L_932244
L_932230:
	ldb r9,[r13, 0x3]
L_932234:
	ldb r11,[r13, 0x2]
L_932238:
	asl r9,r9,0x8
L_93223c:
	or r11,r11,r9
L_932240:
	bbit1 r11,0x1,L_93225c
	.global L_932244
L_932244:
	brne r7,0x1,L_932294
L_932248:
	ldb r8,[r13, 0x3]
L_93224c:
	ldb r4,[r13, 0x2]
L_932250:
	asl r8,r8,0x8
L_932254:
	or r4,r4,r8
L_932258:
	bbit1 r4,0x1,L_932294
	.global L_93225c
L_93225c:
	ldw r7,[r13, 0x26]
L_932260:
	add r7,r7,0x1
L_932264:
	b.d L_932288
L_932268:
	stw r7,[r13, 0x26]
	.global L_93226c
L_93226c:
	ldb r5,[0x802194]
L_932274:
	sub.f r5,r5,0x0
L_932278:
	mov.ne r5,0x1
L_93227c:
	extb.f 0x0,r5
L_932280:
	bne L_9321fc
L_932284:
	b L_932210
	.global L_932288
L_932288:
	mov r0,0x0
L_93228c:
	b.d L_932144
L_932290:
	stb r0,[r13, 0x1f]
	.global L_932294
L_932294:
	ldw r8,[r6]
L_932298:
	brlt r8,0x1,L_9322b4
L_93229c:
	sub r8,r8,0x1
L_9322a0:
	ldw r9,[r13, 0x28]
L_9322a4:
	stw r8,[r6]
L_9322a8:
	add r9,r9,0x1
L_9322ac:
	b.d L_932288
L_9322b0:
	stw r9,[r13, 0x28]
	.global L_9322b4
L_9322b4:
	ldw r10,[r13, 0x2a]
L_9322b8:
	mov r6,0x1
L_9322bc:
	add r10,r10,0x1
L_9322c0:
	stw r10,[r13, 0x2a]
L_9322c4:
	ld.as r2,[gp,-0x11]
L_9322c8:
	stb r6,[r13, 0x1f]
L_9322cc:
	and r2,r2,0xffff0fff
L_9322d4:
	or r1,r2,0xd000
L_9322dc:
	st.as r1,[gp,-0x11]
L_9322e0:
	or r2,r2,0x1d00d000
L_9322e8:
	mov r32,r2
L_9322ec:
	st.ab r2,[r25,0x4]
L_9322f0:
	bclr r25,r25,0xa
L_9322f4:
	nop_s
L_9322f6:
	nop_s
L_9322f8:
	nop_s
L_9322fa:
	mov r11,r40
L_9322fe:
	st r11,[sp]
L_932302:
	lsr r11,r11,0x9
L_932306:
	bmsk r11,r11,0xa
L_93230a:
	sub r9,r11,0x800
L_932312:
	cmp r11,0x3ff
L_932316:
	mov.hi r10,r9
L_93231a:
	mov.ls r10,r11
L_93231e:
	mov_s r13,0x802f14
L_932324:
	st r10,[r13, 0x10]
L_932328:
	ldw_s r0,[r15,0x12]
L_93232a:
	lsr_s r0,r0,0xa
L_93232c:
	stb_s r0,[r13,0xc]
L_93232e:
	ldw_s r1,[r15,0x14]
L_932330:
	bmsk_s r1,r1,0x1
L_932332:
	stb_s r1,[r13,0xd]
L_932334:
	b.d L_932144
L_932338:
	ldb r2,[r13]
	.global L_93233c
L_93233c:
	mov r0,0x801030
L_932344:
	ldb r4,[r0, 0x50]
L_932348:
	mov r10,0x1
L_93234c:
	asl r4,r4,0x3
L_932350:
	add2 r4,r4,r4
L_932354:
	add r4,r4,r0
L_932358:
	ldb r5,[r4, 0x25]
L_93235c:
	mov r11,0x8022c8
L_932364:
	add r5,r5,0x1
L_932368:
	stb r5,[r4, 0x25]
L_93236c:
	ld r6,[r11, 0x60]
L_932370:
	stb r10,[r4, 0x26]
L_932374:
	add r6,r6,0x1
L_932378:
	ld.as r7,[gp,0x34]
L_93237c:
	st r6,[r11, 0x60]
L_932380:
	bset r7,r7,0x18
L_932384:
	b.d L_932dc8
L_932388:
	st.as r7,[gp,0x34]
	.global L_93238c
L_93238c:
	mov r8,0x8
	.global L_932390
L_932390:
	mov r3,0x8022c8
L_932398:
	ldb r9,[r3, 0x8b]
L_93239c:
	st r8,[0x802288]
L_9323a4:
	ld.as r10,[gp,0x33]
L_9323a8:
	add r9,r9,0x1
L_9323ac:
	bbit1.d r10,0x2,L_9323c0
L_9323b0:
	stb r9,[r3, 0x8b]
L_9323b4:
	ld.as r10,[gp,0x34]
L_9323b8:
	bset r10,r10,0x19
L_9323bc:
	st.as r10,[gp,0x34]
	.global L_9323c0
L_9323c0:
	bl L_92f2bc
L_9323c4:
	ld r11,[r14, 0xc]
L_9323c8:
	bclr r11,r11,0x0
L_9323cc:
	b.d L_932dc8
L_9323d0:
	st r11,[r14, 0xc]
	.global L_9323d4
L_9323d4:
	mov r16,0x0
L_9323d8:
	mov r4,0xeeee0c
L_9323e0:
	mov r32,r4
L_9323e4:
	st.ab r4,[r25,0x4]
L_9323e8:
	bclr r25,r25,0xa
L_9323ec:
	mov_s r1,0x0
L_9323ee:
	st_s r1,[r14,0x24]
L_9323f0:
	ld.as r11,[gp,0x0]
L_9323f4:
	mov r5,0x802288
L_9323fc:
	ld r1,[r5, 0x10]
L_932400:
	cmp r11,0x0
L_932404:
	btst.ne r1,0x3
L_932408:
	bne L_932414
	.global L_93240c
L_93240c:
	b.d L_932424
L_932410:
	mov r0,0x0
	.global L_932414
L_932414:
	ld r6,[r14, 0x4]
L_932418:
	ld.as r11,[gp,0xf]
L_93241c:
	bbit0.d r11,r6,L_93240c
L_932420:
	mov r0,0x1
	.global L_932424
L_932424:
	extb r4,r0
L_932428:
	st r4,[sp]
L_93242c:
	bmsk_s r0,r0,0x0
L_93242e:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_932430:
	bclr_s r1,r1,0x4
L_932432:
	or_s r1,r1,r0
L_932434:
	st r1,[r5, 0x10]
L_932438:
	nop_s
L_93243a:
	nop_s
L_93243c:
	nop_s
L_93243e:
	ld_s r0,[gp,-0x44]
L_932440:
	and r0,r0,0xffff0fff
L_932448:
	or r6,r0,0xb000
L_932450:
	or r0,r0,0x1d00b000
L_932458:
	st.as r6,[gp,-0x11]
L_93245c:
	mov r32,r0
L_932460:
	st.ab r0,[r25,0x4]
L_932464:
	bclr r25,r25,0xa
L_932468:
	nop_s
L_93246a:
	nop_s
L_93246c:
	nop_s
L_93246e:
	mov r9,r37
L_932472:
	mov_s r0,0x804010
L_932478:
	bbit0 r9,0x10,L_932484
L_93247c:
	ldw r10,[r0, 0x2]
L_932480:
	brne r10,0x0,L_932494
	.global L_932484
L_932484:
	mov r2,r37
L_932488:
	bbit1 r2,0x0,L_932494
L_93248c:
	mov r8,r40
L_932490:
	bbit0 r8,0xf,L_932498
	.global L_932494
L_932494:
	bl L_924fc4
	.global L_932498
L_932498:
	mov_s r1,r38
L_93249a:
	mov_s r13,0x802288
L_9324a0:
	bbit0 r1,0xb,L_9324b4
L_9324a4:
	lsr r1,r38,0x8
L_9324a8:
	bmsk r1,r1,0x2
L_9324ac:
	b.d L_9324f8
L_9324b0:
	st r1,[r13]
	.global L_9324b4
L_9324b4:
	mov r5,r36
L_9324b8:
	bbit0 r5,0x7,L_9324d0
L_9324bc:
	mov r0,0x804014
L_9324c4:
	bl L_9349a0
L_9324c8:
	b.d L_9324f8
L_9324cc:
	st r0,[r13]
	.global L_9324d0
L_9324d0:
	mov r11,r36
L_9324d4:
	bbit0 r11,0x6,L_9324ec
L_9324d8:
	mov r0,0x80401a
L_9324e0:
	bl L_9349a0
L_9324e4:
	b.d L_9324f8
L_9324e8:
	st r0,[r13]
	.global L_9324ec
L_9324ec:
	mov r8,0x8
L_9324f0:
	st r8,[r13]
L_9324f4:
	mov_s r2,0x0
L_9324f6:
	st_s r2,[sp,0x0]
	.global L_9324f8
L_9324f8:
	mov r5,r36
L_9324fc:
	bbit1 r5,0x6,L_93256c
L_932500:
	mov_s r3,r36
L_932502:
	bbit1 r3,0x19,L_93256c
L_932506:
	and r2,r38,0x30006800
L_93250e:
	mov_s r13,0x802288
L_932514:
	cmp_s r2,0x20000800
L_93251a:
	bne L_932910
L_93251e:
	lsr r4,r39,0x8
L_932522:
	bmsk r4,r4,0x5
L_932526:
	cmp r4,0xc
L_93252a:
	mov r4,0x1
L_93252e:
	sub.ne r4,r4,r4
L_932532:
	extb.f 0x0,r4
L_932536:
	beq_s L_93255c
L_932538:
	mov r6,0x804010
L_932540:
	ldb r8,[r6, 0x18]
L_932544:
	brne.d r8,0x4,L_93255c
L_932548:
	ldb r7,[r6, 0x19]
L_93254c:
	cmp r7,0x21
L_932550:
	beq L_932624
L_932554:
	cmp r7,0x20
L_932558:
	beq L_9328c4
	.global L_93255c
L_93255c:
	ld r2,[r13]
L_932560:
	mov r17,r16
L_932564:
	b.d L_932664
L_932568:
	mov r18,r16
	.global L_93256c
L_93256c:
	ld r5,[0x801424]
L_932574:
	bbit1 r5,0x0,L_9325bc
L_932578:
	bl L_92f2bc
L_93257c:
	ld.as r11,[gp,0x34]
L_932580:
	bset r11,r11,0xa
L_932584:
	st.as r11,[gp,0x34]
L_932588:
	ld r11,[r14, 0xc]
L_93258c:
	bclr r11,r11,0x0
L_932590:
	st r11,[r14, 0xc]
L_932594:
	ld r10,[0x802288]
L_93259c:
	asl r10,r10,0x2
L_9325a0:
	add2 r10,r10,r10
L_9325a4:
	add r10,r10,0x857e38
L_9325ac:
	ldb r2,[r10, 0x11]
L_9325b0:
	bset r2,r2,0x2
L_9325b4:
	b.d L_932dc8
L_9325b8:
	stb r2,[r10, 0x11]
	.global L_9325bc
L_9325bc:
	bl L_928520
L_9325c0:
	cmp r0,0x0
L_9325c4:
	beq L_932dc8
L_9325c8:
	bl L_92f2bc
L_9325cc:
	ld_s r3,[r14,0xc]
L_9325ce:
	bclr_s r3,r3,0x0
L_9325d0:
	st_s r3,[r14,0xc]
L_9325d2:
	ld r11,[0x8021e0]
L_9325da:
	bic.f r11,r11,-0x222
L_9325de:
	bne L_932dc8
L_9325e2:
	ldw.as r8,[gp,0x4b]
L_9325e6:
	ldw r3,[0x802968]
L_9325ee:
	cmp_s r3,r8
L_9325f0:
	beq L_932dc8
L_9325f4:
	stw.as r3,[gp,0x4b]
L_9325f8:
	or r3,r3,0x1730000
L_932600:
	st r3,[0x886d00]
L_932608:
	sync
L_93260c:
	mov r8,0x38000200
L_932614:
	mov r32,r8
L_932618:
	st.ab r8,[r25,0x4]
L_93261c:
	bclr r25,r25,0xa
L_932620:
	b L_932dc8
	.global L_932624
L_932624:
	mov_s r1,0xccb000
L_93262a:
	mov_s r32,r1
L_93262c:
	st.ab r1,[r25,0x4]
L_932630:
	bclr r25,r25,0xa
L_932634:
	mov r0,0x804010
L_93263c:
	bl.d L_93e42c
L_932640:
	ld r1,[r13]
L_932644:
	ld_s r2,[r13]
L_932646:
	mov_s r18,r0
L_932648:
	asl_s r1,r2,0x2
L_93264a:
	add2_s r1,r1,r1
L_93264c:
	add r1,r1,0x802354
L_932654:
	ldw r5,[r1, 0x4]
L_932658:
	mov r17,0x1
L_93265c:
	add r5,r5,0x1
L_932660:
	stw r5,[r1, 0x4]
	.global L_932664
L_932664:
	ld r5,[0x801424]
L_93266c:
	btst r5,0x0
L_932670:
	btst.eq r5,0x1
L_932674:
	bne_s L_9326ac
L_932676:
	asl_s r1,r2,0x2
L_932678:
	add1_s r1,r1,r1
L_93267a:
	ld r6,[r1,0x802610]
L_932682:
	sub.f r6,r6,0x0
L_932686:
	mov.ne r6,0x1
L_93268a:
	extb.f 0x0,r6
L_93268e:
	bne_s L_9326ac
L_932690:
	mov r5,0x8014e8
L_932698:
	ldb r3,[r5]
L_93269c:
	ldb r1,[r5, 0x1]
L_9326a0:
	brge r3,r1,L_9326ac
L_9326a4:
	stb r3,[r5, 0x1]
L_9326a8:
	stb r2,[r5, 0x2]
	.global L_9326ac
L_9326ac:
	lsr r7,r38,0x14
L_9326b0:
	bmsk r7,r7,0x4
L_9326b4:
	stb r7,[gp, -0xe1]
L_9326b8:
	mov r1,sp
L_9326bc:
	bl.d L_932e40
L_9326c0:
	mov r0,r14
L_9326c4:
	st r0,[r14, 0x24]
L_9326c8:
	ldb r13,[gp, -0xe1]
L_9326cc:
	ldb r19,[r14]
L_9326d0:
	mov r6,r36
L_9326d4:
	btst r6,0x9
L_9326d8:
	beq.d L_9327a0
L_9326dc:
	mov_s r15,0x0
L_9326de:
	mov_s r0,r38
L_9326e0:
	btst_s r0,0xc
L_9326e2:
	beq_s L_9327a0
L_9326e4:
	ldb r2,[gp, -0xe4]
L_9326e8:
	breq r2,0x0,L_932758
L_9326ec:
	mov r5,r53
L_9326f0:
	bbit1 r5,0x0,L_93273c
L_9326f4:
	mov r5,0x23010003
L_9326fc:
	mov r32,r5
L_932700:
	st.ab r5,[r25,0x4]
L_932704:
	bclr r25,r25,0xa
L_932708:
	mov r8,0x2000200
L_932710:
	mov r32,r8
L_932714:
	st.ab r8,[r25,0x4]
L_932718:
	bclr r25,r25,0xa
L_93271c:
	nop_s
L_93271e:
	nop_s
L_932720:
	mov 0x0,0x0
	.global L_932724
L_932724:
	mov_s r1,r42
L_932726:
	bbit1 r1,0x9,L_932730
L_93272a:
	mov_s r3,r53
L_93272c:
	bbit0 r3,0x0,L_932724
	.global L_932730
L_932730:
	mov r5,r42
L_932734:
	btst r5,0x9
L_932738:
	bne L_9328d8
	.global L_93273c
L_93273c:
	and r8,r53,0x10
L_932740:
	st.as r8,[gp,-0x32]
L_932744:
	mov r6,0x1c000001
L_93274c:
	mov r32,r6
L_932750:
	st.ab r6,[r25,0x4]
L_932754:
	bclr r25,r25,0xa
	.global L_932758
L_932758:
	lsr r4,r53,0x8
L_93275c:
	bmsk r4,r4,0x6
L_932760:
	lsr r3,r53,0x10
L_932764:
	mov r8,0x802210
L_93276c:
	ld r5,[r8]
L_932770:
	bmsk r3,r3,0x6
L_932774:
	add r5,r5,r4
L_932778:
	ld r6,[r8, 0x4]
L_93277c:
	st r5,[r8]
L_932780:
	add r6,r6,r3
L_932784:
	ld r7,[r8, 0x8]
L_932788:
	st r6,[r8, 0x4]
L_93278c:
	add r7,r7,0x1
L_932790:
	brlt.d r13,0x1,L_9327a0
L_932794:
	st r7,[r8, 0x8]
L_932798:
	mov r6,0x1
L_93279c:
	st r6,[r8, 0x14]
	.global L_9327a0
L_9327a0:
	mov r9,0x8800
L_9327a8:
	and r3,r38,r9
L_9327ac:
	mov_s r13,0x802288
L_9327b2:
	brne r3,r9,L_9327c4
L_9327b6:
	ld r5,[r13, 0x10]
L_9327ba:
	mov_s r15,0x1
L_9327bc:
	bset r5,r5,0x3
L_9327c0:
	st r5,[r13, 0x10]
	.global L_9327c4
L_9327c4:
	ld.as r3,[gp,-0xd]
L_9327c8:
	breq.d r3,0x0,L_9327ec
L_9327cc:
	ld r4,[r14, 0x24]
L_9327d0:
	asl r2,r19,0x2
L_9327d4:
	add1_s r2,r2,r2
L_9327d6:
	ld r6,[r2,0x802610]
L_9327de:
	sub.f r6,r6,0x0
L_9327e2:
	mov.ne r6,0x1
L_9327e6:
	extb.f 0x0,r6
L_9327ea:
	sub_s.ne r15,r15,r15
	.global L_9327ec
L_9327ec:
	cmp r4,0x0
L_9327f0:
	mov.eq r15,0x0
L_9327f4:
	bl.d L_93daf0
L_9327f8:
	mov r0,r14
L_9327fc:
	brne r0,0x0,L_932820
L_932800:
	ld.as r7,[gp,0x0]
L_932804:
	tst r15,r7
L_932808:
	beq.d L_932820
L_93280c:
	ld r16,[sp]
L_932810:
	ld r4,[r13, 0x4]
L_932814:
	ld r9,[r13]
L_932818:
	cmp r9,r4
L_93281c:
	bset.eq r16,r16,0x0
	.global L_932820
L_932820:
	ld r5,[r14, 0x24]
L_932824:
	brne r5,0x0,L_932830
L_932828:
	cmp r16,0x1
L_93282c:
	bne L_9328e8
	.global L_932830
L_932830:
	cmp r5,0x1
L_932834:
	mov.eq r16,0x0
L_932838:
	breq.d r5,0x0,L_93284c
L_93283c:
	ld r4,[r13]
L_932840:
	ld r10,[r14, 0xc]
L_932844:
	btst r10,0x9
L_932848:
	mov.eq r16,0x0
	.global L_93284c
L_93284c:
	asl r4,r4,0x4
L_932850:
	add2 r4,r4,r4
L_932854:
	ld r15,[r4,0x80110c]
L_93285c:
	mov r4,0x37000005
L_932864:
	mov r32,r4
L_932868:
	st.ab r4,[r25,0x4]
L_93286c:
	bclr r25,r25,0xa
L_932870:
	mov r7,0x37000002
L_932878:
	mov r32,r7
L_93287c:
	st.ab r7,[r25,0x4]
L_932880:
	bclr r25,r25,0xa
L_932884:
	or r15,r15,0x3f000000
L_93288c:
	mov r32,r15
L_932890:
	st.ab r15,[r25,0x4]
L_932894:
	bclr r25,r25,0xa
L_932898:
	ld r6,[r14, 0xc]
L_93289c:
	bmsk r8,r16,0x0
L_9328a0:
	bclr r6,r6,0x0
L_9328a4:
	or r6,r6,r8
L_9328a8:
	st r6,[r14, 0xc]
L_9328ac:
	ld_s r2,[r13]
L_9328ae:
	asl r8,r8
L_9328b2:
	st_s r2,[r14]
L_9328b4:
	ld r7,[r13, 0x10]
L_9328b8:
	bclr r7,r7,0x1
L_9328bc:
	b.d L_932904
L_9328c0:
	or r8,r8,r7
	.global L_9328c4
L_9328c4:
	mov_s r2,0xccb001
L_9328ca:
	mov_s r32,r2
L_9328cc:
	st.ab r2,[r25,0x4]
L_9328d0:
	bclr r25,r25,0xa
L_9328d4:
	b L_93255c
	.global L_9328d8
L_9328d8:
	mov r0,blink
L_9328dc:
	bl.d L_926618
L_9328e0:
	mov r1,0x3b
L_9328e4:
	b L_93273c
	.global L_9328e8
L_9328e8:
	bl L_92f2bc
L_9328ec:
	mov r2,r37
L_9328f0:
	bbit0.d r2,0x10,L_932904
L_9328f4:
	ld r8,[r13, 0x10]
L_9328f8:
	ld.as r7,[gp,0x34]
L_9328fc:
	bset r7,r7,0x9
L_932900:
	st.as r7,[gp,0x34]
	.global L_932904
L_932904:
	bset r8,r8,0x2
L_932908:
	b.d L_932a0c
L_93290c:
	st r8,[r13, 0x10]
	.global L_932910
L_932910:
	bl L_92f2bc
L_932914:
	mov r4,r38
L_932918:
	mov_s r1,0x804010
L_93291e:
	bbit0 r4,0x1e,L_9329b4
L_932922:
	lsr r2,r39,0x8
L_932926:
	bmsk_s r2,r2,0x5
L_932928:
	brne r2,0x33,L_9329b4
L_93292c:
	ldb r9,[gp, 0xbc]
L_932930:
	ldb r6,[r1, 0xa]
L_932934:
	brne r9,r6,L_9329b4
L_932938:
	ldb r10,[gp, 0xbd]
L_93293c:
	ldb_s r2,[r1,0xb]
L_93293e:
	brne r2,r10,L_9329b4
L_932942:
	ldb r11,[gp, 0xbe]
L_932946:
	ldb r4,[r1, 0xc]
L_93294a:
	brne r11,r4,L_9329b4
L_93294e:
	ldb_s r0,[gp,0xbf]
L_932950:
	ldb r9,[r1, 0xd]
L_932954:
	brne r0,r9,L_9329b4
L_932958:
	ldb r3,[gp, 0xc0]
L_93295c:
	ldb_s r2,[r1,0xe]
L_93295e:
	brne r3,r2,L_9329b4
L_932962:
	ldb r4,[gp, 0xc1]
L_932966:
	ldb r6,[r1, 0xf]
L_93296a:
	brne r4,r6,L_9329b4
L_93296e:
	mov_s r0,0x804014
L_932974:
	bl L_9349a0
L_932978:
	mov r15,0x8022c8
L_932980:
	brhs.d r0,0x8,L_9329c8
L_932984:
	mov_s r1,r0
L_932986:
	st_s r1,[r13]
L_932988:
	bl.d L_92f4bc
L_93298c:
	mov r0,0x1
L_932990:
	ld r6,[r13, 0x10]
L_932994:
	ld r9,[r15, 0x80]
L_932998:
	bset r6,r6,0x2
L_93299c:
	st r6,[r13, 0x10]
L_9329a0:
	add r9,r9,0x1
L_9329a4:
	bl.d L_9364c8
L_9329a8:
	st r9,[r15, 0x80]
L_9329ac:
	b.d L_932a04
L_9329b0:
	st.as r0,[gp,0x5]
	.global L_9329b4
L_9329b4:
	mov r7,r38
L_9329b8:
	bbit0 r7,0x1c,L_9329d8
L_9329bc:
	bl.d L_9343a8
L_9329c0:
	mov r0,0x1
L_9329c4:
	b L_932a04
	.global L_9329c8
L_9329c8:
	ld r10,[r15, 0x84]
L_9329cc:
	add r10,r10,0x1
L_9329d0:
	b.d L_932a04
L_9329d4:
	st r10,[r15, 0x84]
	.global L_9329d8
L_9329d8:
	mov r4,r39
L_9329dc:
	mov r6,r38
L_9329e0:
	lsr r2,r39,0x8
L_9329e4:
	bmsk_s r2,r2,0x5
L_9329e6:
	cmp_s r2,0x8
L_9329e8:
	mov_s r2,0x1
L_9329ea:
	sub_s.ne r2,r2,r2
L_9329ec:
	mov_s r0,0x802f80
L_9329f2:
	ld.as r5,[r0,0x51]
L_9329f6:
	btst r4,0x4
L_9329fa:
	btst.ne r6,0xe
L_9329fe:
	cmp.ne r2,0x0
L_932a02:
	bne_s L_932a3c
	.global L_932a04
L_932a04:
	mov r17,r16
L_932a08:
	mov r18,r16
	.global L_932a0c
L_932a0c:
	cmp r16,0x0
L_932a10:
	ld r5,[r14, 0x24]
L_932a14:
	bne.d L_932dc8
L_932a18:
	st r5,[r13, 0xc]
L_932a1c:
	ld r10,[r14, 0xc]
L_932a20:
	cmp r5,0x9
L_932a24:
	bclr r10,r10,0x0
L_932a28:
	bhi.d L_932d8c
L_932a2c:
	st r10,[r14, 0xc]
L_932a30:
	ld.as r11,[0x80195c,r5]
L_932a38:
	j [r11]
	.global L_932a3c
L_932a3c:
	ld r11,[r13]
L_932a40:
	asl r2,0x1,r11
L_932a48:
	brne r5,0x0,L_932a70
L_932a4c:
	mov r1,0x3
L_932a50:
	bl.d L_934bb0
L_932a54:
	asl r2,r2,0x8
L_932a58:
	mov r4,0x801030
L_932a60:
	ldb r3,[r4, 0x90]
L_932a64:
	add r3,r3,0x1
L_932a68:
	b.d L_932a04
L_932a6c:
	stb r3,[r4, 0x90]
	.global L_932a70
L_932a70:
	mov r1,0x4
L_932a74:
	bl.d L_934bb0
L_932a78:
	asl r2,r2,0x8
L_932a7c:
	b L_932a04
L_932a80:
	ld_s r1,[r14]
L_932a82:
	mov_s r0,0x0
L_932a84:
	ld r2,[r14, 0x8]
L_932a88:
	bl.d L_92d9d4
L_932a8c:
	mov r3,0xff
	.global L_932a90
L_932a90:
	mov r7,r43
L_932a94:
	bbit0 r7,0x1f,L_932a90
L_932a98:
	mov r4,r51
L_932a9c:
	bmsk r3,r4,0x3
L_932aa0:
	st.as r3,[gp,0x38]
L_932aa4:
	lsr r4,r4,0x4
L_932aa8:
	st.as r4,[gp,0x39]
L_932aac:
	lsr r2,r43,0x10
L_932ab0:
	bmsk_s r2,r2,0x4
L_932ab2:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_932ab4:
	or r2,r2,0x3e000000
L_932abc:
	mov r32,r2
L_932ac0:
	st.ab r2,[r25,0x4]
L_932ac4:
	bclr r25,r25,0xa
L_932ac8:
	mov_s r0,0x37000020
L_932ace:
	mov_s r32,r0
L_932ad0:
	st.ab r0,[r25,0x4]
L_932ad4:
	bclr r25,r25,0xa
L_932ad8:
	mov_s r0,0x8022c8
L_932ade:
	ld_s r3,[r0,0xc]
L_932ae0:
	ld.as r4,[gp,0x5e]
L_932ae4:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_932ae6:
	st_s r3,[r0,0xc]
L_932ae8:
	ld r5,[0x802940]
L_932af0:
	and r4,r4,0xfcffffff
L_932af8:
	asl r5,r5,0x18
L_932afc:
	or r5,r5,r4
L_932b00:
	st.as r5,[gp,0x5e]
L_932b04:
	st r5,[0x889488]
L_932b0c:
	mov_s r1,0x2008000
L_932b12:
	mov_s r32,r1
L_932b14:
	st.ab r1,[r25,0x4]
L_932b18:
	bclr r25,r25,0xa
L_932b1c:
	mov_s r2,0x19000001
L_932b22:
	mov_s r32,r2
L_932b24:
	st.ab r2,[r25,0x4]
L_932b28:
	bclr r25,r25,0xa
	.global L_932b2c
L_932b2c:
	mov r5,r45
L_932b30:
	bbit0 r5,0x1f,L_932b2c
L_932b34:
	mov r8,0x18000000
L_932b3c:
	mov r32,r8
L_932b40:
	st.ab r8,[r25,0x4]
L_932b44:
	bclr r25,r25,0xa
L_932b48:
	mov_s r0,r14
L_932b4a:
	mov_s r1,0x0
L_932b4c:
	bl.d L_9336d8
L_932b50:
	mov r2,r18
L_932b54:
	cmp r17,0x0
L_932b58:
	beq L_932d98
L_932b5c:
	ld r0,[0x802288]
L_932b64:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_932b66:
	add2_s r0,r0,r0
L_932b68:
	add r0,r0,0x802354
L_932b70:
	ldw r6,[r0, 0x6]
L_932b74:
	add r6,r6,0x1
L_932b78:
	b.d L_932d98
L_932b7c:
	stw r6,[r0, 0x6]
L_932b80:
	ld_s r1,[r14]
L_932b82:
	mov_s r0,0x1
L_932b84:
	ld r2,[r14, 0x8]
L_932b88:
	bl.d L_92d9d4
L_932b8c:
	mov r3,0xff
	.global L_932b90
L_932b90:
	mov_s r0,r43
L_932b92:
	bbit0 r0,0x1f,L_932b90
L_932b96:
	mov r8,r51
L_932b9a:
	bmsk r7,r8,0x3
L_932b9e:
	st.as r7,[gp,0x38]
L_932ba2:
	lsr r8,r8,0x4
L_932ba6:
	st.as r8,[gp,0x39]
L_932baa:
	lsr r1,r43,0x10
L_932bae:
	bmsk_s r1,r1,0x4
L_932bb0:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_932bb2:
	or r1,r1,0x3e000000
L_932bba:
	mov_s r32,r1
L_932bbc:
	st.ab r1,[r25,0x4]
L_932bc0:
	bclr r25,r25,0xa
L_932bc4:
	mov r7,0x37000020
L_932bcc:
	mov r32,r7
L_932bd0:
	st.ab r7,[r25,0x4]
L_932bd4:
	bclr r25,r25,0xa
L_932bd8:
	mov_s r1,0x8022c8
L_932bde:
	ld_s r0,[r1,0xc]
L_932be0:
	ld.as r7,[gp,0x5e]
L_932be4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_932be6:
	st_s r0,[r1,0xc]
L_932be8:
	ld r8,[0x802940]
L_932bf0:
	and r7,r7,0xfcffffff
L_932bf8:
	asl r8,r8,0x18
L_932bfc:
	or r8,r8,r7
L_932c00:
	st.as r8,[gp,0x5e]
L_932c04:
	st r8,[0x889488]
L_932c0c:
	mov_s r3,0x2008000
L_932c12:
	mov_s r32,r3
L_932c14:
	st.ab r3,[r25,0x4]
L_932c18:
	bclr r25,r25,0xa
L_932c1c:
	mov r4,0x19000001
L_932c24:
	mov r32,r4
L_932c28:
	st.ab r4,[r25,0x4]
L_932c2c:
	bclr r25,r25,0xa
	.global L_932c30
L_932c30:
	mov r1,r45
L_932c34:
	bbit0 r1,0x1f,L_932c30
L_932c38:
	mov r9,0x18000000
L_932c40:
	mov r32,r9
L_932c44:
	st.ab r9,[r25,0x4]
L_932c48:
	bclr r25,r25,0xa
L_932c4c:
	mov_s r0,r14
L_932c4e:
	mov_s r1,0x1
	.global L_932c50
L_932c50:
	bl.d L_9336d8
L_932c54:
	mov r2,0x0
L_932c58:
	b L_932d98
L_932c5c:
	mov_s r0,0x20000400
L_932c62:
	mov_s r32,r0
L_932c64:
	st.ab r0,[r25,0x4]
L_932c68:
	bclr r25,r25,0xa
L_932c6c:
	ld_s r1,[r14]
L_932c6e:
	mov_s r0,0x5
L_932c70:
	ld r2,[r14, 0x8]
L_932c74:
	bl.d L_92d9d4
L_932c78:
	mov r3,0xff
	.global L_932c7c
L_932c7c:
	mov_s r2,r43
L_932c7e:
	bbit0 r2,0x1f,L_932c7c
L_932c82:
	mov_s r2,r51
L_932c84:
	bmsk r0,r2,0x3
L_932c88:
	st.as r0,[gp,0x38]
L_932c8c:
	lsr r2,r2,0x4
L_932c90:
	st.as r2,[gp,0x39]
L_932c94:
	lsr r9,r43,0x10
L_932c98:
	bmsk r9,r9,0x4
L_932c9c:
	asl r9,r9,0x4
L_932ca0:
	or r9,r9,0x3e000000
L_932ca8:
	mov r32,r9
L_932cac:
	st.ab r9,[r25,0x4]
L_932cb0:
	bclr r25,r25,0xa
L_932cb4:
	mov r8,0x37000020
L_932cbc:
	mov r32,r8
L_932cc0:
	st.ab r8,[r25,0x4]
L_932cc4:
	bclr r25,r25,0xa
L_932cc8:
	mov_s r3,0x8022c8
L_932cce:
	ld_s r2,[r3,0xc]
L_932cd0:
	ld.as r5,[gp,0x5e]
L_932cd4:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_932cd6:
	and r8,r5,0xfcffffff
L_932cde:
	ld r5,[0x802940]
L_932ce6:
	st_s r2,[r3,0xc]
L_932ce8:
	asl r5,r5,0x18
L_932cec:
	or r5,r5,r8
L_932cf0:
	st.as r5,[gp,0x5e]
L_932cf4:
	st r5,[0x889488]
L_932cfc:
	mov r5,0x2008000
L_932d04:
	mov r32,r5
L_932d08:
	st.ab r5,[r25,0x4]
L_932d0c:
	bclr r25,r25,0xa
L_932d10:
	mov r6,0x19000001
L_932d18:
	mov r32,r6
L_932d1c:
	st.ab r6,[r25,0x4]
L_932d20:
	bclr r25,r25,0xa
	.global L_932d24
L_932d24:
	mov_s r3,r45
L_932d26:
	bbit0 r3,0x1f,L_932d24
L_932d2a:
	mov_s r1,0x18
L_932d2c:
	asl_s r1,r1,0x18
L_932d2e:
	mov_s r32,r1
L_932d30:
	st.ab r1,[r25,0x4]
L_932d34:
	bclr r25,r25,0xa
L_932d38:
	mov_s r0,r14
L_932d3a:
	mov_s r1,0x5
L_932d3c:
	bl.d L_9336d8
L_932d40:
	mov r2,0x0
L_932d44:
	mov r4,0x801030
L_932d4c:
	ldw r10,[r4, 0xb6]
L_932d50:
	add r10,r10,0x1
L_932d54:
	b.d L_932d98
L_932d58:
	stw r10,[r4, 0xb6]
L_932d5c:
	bl L_936200
L_932d60:
	mov r0,r14
L_932d64:
	b.d L_932c50
L_932d68:
	mov r1,0x8
L_932d6c:
	bl L_936320
L_932d70:
	mov r0,r14
L_932d74:
	b.d L_932c50
L_932d78:
	mov r1,0xa
L_932d7c:
	bl L_93626c
L_932d80:
	mov r0,r14
L_932d84:
	b.d L_932c50
L_932d88:
	mov r1,0x3
	.global L_932d8c
L_932d8c:
	mov r0,blink
L_932d90:
	bl.d L_926618
L_932d94:
	mov r1,0x42
	.global L_932d98
L_932d98:
	mov_s r2,0x14
L_932d9a:
	asl_s r2,r2,0x18
L_932d9c:
	mov r32,r2
L_932da0:
	st.ab r2,[r25,0x4]
L_932da4:
	bclr r25,r25,0xa
L_932da8:
	ld r7,[r14, 0x24]
L_932dac:
	brne r7,0x2,L_932dbc
L_932db0:
	mov r4,0x1
L_932db4:
	b.d L_932dc8
L_932db8:
	stb r4,[gp, -0xfb]
	.global L_932dbc
L_932dbc:
	brne r7,0x1,L_932dc8
L_932dc0:
	mov r6,0x1
L_932dc4:
	stb r6,[gp, -0xfc]
	.global L_932dc8
L_932dc8:
	add_s sp,sp,0x8
L_932dca:
	ld blink,[sp, 0x4]
L_932dce:
	ld_s r14,[sp,0x8]
L_932dd0:
	ld_s r15,[sp,0xc]
L_932dd2:
	ld r16,[sp, 0x10]
L_932dd6:
	ld r17,[sp, 0x14]
L_932dda:
	ld r18,[sp, 0x18]
L_932dde:
	ld r19,[sp, 0x1c]
L_932de2:
	j_s.d [blink]
L_932de4:
	ld.ab r13,[sp,0x20]
