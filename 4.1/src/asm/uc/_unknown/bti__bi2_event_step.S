/* bti__bi2_event_step @ 0x931f8c, 1108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BI2 event
 *   BI1 interrupt Out Of BTI period
 * Зовут его: bti_transmitter_bi2_flow
 * Зовёт сам: bti_worker_bi2_step, uc_bi_counter_in_window, uc_read_bi_sync, uc_read_tsf_lo, uc_wait_event_busy
 * Глобалы (через gp): 0x800540, 0x80059c
 */
	.section .text.bti__bi2_event_step,"ax",@progbits
	.global bti__bi2_event_step
bti__bi2_event_step:
	.global L_931f8c
L_931f8c:
	st.a r13,[sp,-0x10]
L_931f90:
	st blink,[sp, 0x4]
L_931f94:
	st_s r14,[sp,0x8]
L_931f96:
	st_s r15,[sp,0xc]
L_931f98:
	mov r13,r0
L_931f9c:
	mov r6,0x2041030
L_931fa4:
	mov r32,r6
L_931fa8:
	st.ab r6,[r25,0x4]
L_931fac:
	bclr r25,r25,0xa
L_931fb0:
	bl L_9315e8
L_931fb4:
	st r0,[0x801b14]
L_931fbc:
	bl.d L_932508
L_931fc0:
	mov r0,r13
L_931fc4:
	cmp r0,0x0
L_931fc8:
	beq L_932388
L_931fcc:
	bl L_931c64
L_931fd0:
	cmp r0,0x0
L_931fd4:
	beq L_932388
	.global L_931fd8
L_931fd8:
	mov_s r0,0x20
L_931fda:
	bset_s r0,r0,0xc
L_931fdc:
	bl.d L_931808
L_931fe0:
	mov r1,0x0
L_931fe4:
	mov r9,r42
L_931fe8:
	btst r9,0xc
L_931fec:
	beq L_9322c0
L_931ff0:
	ld r0,[r13]
L_931ff4:
	bl.d L_923ba8
L_931ff8:
	mov r1,0x1
L_931ffc:
	breq r0,0x0,L_931fd8
L_932000:
	mov r7,0x49000100
L_932008:
	mov r32,r7
L_93200c:
	st.ab r7,[r25,0x4]
L_932010:
	bclr r25,r25,0xa
L_932014:
	bmsk r0,r38,0x0
L_932018:
	mov_s r13,0x801e68
L_93201e:
	stb_s r0,[r13]
L_932020:
	mov_s r15,0x804010
L_932026:
	ldb_s r3,[r15,0x19]
L_932028:
	ldb_s r1,[r15,0x18]
L_93202a:
	asl_s r3,r3,0x8
L_93202c:
	or_s r1,r1,r3
L_93202e:
	bic.f r1,r1,-0x781
L_932032:
	bne L_9322a8
L_932036:
	ldb r11,[r15, 0x17]
L_93203a:
	ldb r10,[r15, 0x18]
L_93203e:
	ldb r9,[r15, 0x19]
L_932042:
	ldb r8,[r15, 0x1a]
L_932046:
	stb r11,[r13, 0x2]
L_93204a:
	stb r10,[r13, 0x3]
L_93204e:
	stb r9,[r13, 0x4]
L_932052:
	stb r8,[r13, 0x5]
L_932056:
	ldb r11,[r15, 0x1b]
L_93205a:
	ldb r10,[r15, 0x1c]
L_93205e:
	stb r11,[r13, 0x6]
L_932062:
	stb r10,[r13, 0x7]
L_932066:
	ldb r11,[r13, 0x3]
L_93206a:
	lsr r11,r11,0x2
L_93206e:
	bmsk r11,r11,0x3
L_932072:
	cmp r11,0x4
L_932076:
	bcc L_9321d4
L_93207a:
	mov_s r0,0x0
L_93207c:
	stb_s r0,[r13,0x1]
L_93207e:
	stb_s r0,[r13,0x1b]
L_932080:
	mov r14,0x0
L_932084:
	b.d L_932120
L_932088:
	bset r14,r14,0xb
	.global L_93208c
L_93208c:
	ldw r7,[r13, 0x26]
L_932090:
	mov r9,0x1
L_932094:
	add r7,r7,0x1
L_932098:
	stw r7,[r13, 0x26]
L_93209c:
	stb r9,[r13, 0x1b]
L_9320a0:
	mov_s r14,0x0
L_9320a2:
	ld.as r5,[gp,-0x11]
L_9320a6:
	bset_s r14,r14,0xb
L_9320a8:
	and r5,r5,0xffff0fff
L_9320b0:
	or r11,r5,0xd000
L_9320b8:
	st.as r11,[gp,-0x11]
L_9320bc:
	or r5,r5,0x1d00d000
L_9320c4:
	mov r32,r5
L_9320c8:
	st.ab r5,[r25,0x4]
L_9320cc:
	bclr r25,r25,0xa
L_9320d0:
	nop_s
L_9320d2:
	nop_s
L_9320d4:
	nop_s
L_9320d6:
	lsr r7,r40,0x9
L_9320da:
	bmsk r7,r7,0xa
L_9320de:
	sub r1,r7,r14
L_9320e2:
	cmp r7,0x3ff
L_9320e6:
	mov.hi r2,r1
L_9320ea:
	mov.ls r2,r7
L_9320ee:
	mov_s r13,0x801e68
L_9320f4:
	st_s r2,[r13,0xc]
L_9320f6:
	ldw r11,[r15, 0x12]
L_9320fa:
	lsr r11,r11,0xa
L_9320fe:
	stb r11,[r13, 0x8]
L_932102:
	ldw_s r0,[r15,0x14]
L_932104:
	bmsk_s r0,r0,0x1
L_932106:
	stb_s r0,[r13,0x9]
	.global L_932108
L_932108:
	ldw r11,[r15, 0x4]
L_93210c:
	ldw r10,[r15, 0x6]
L_932110:
	ldw r9,[r15, 0x8]
L_932114:
	stw r11,[r13, 0x10]
L_932118:
	stw r10,[r13, 0x12]
L_93211c:
	stw r9,[r13, 0x14]
	.global L_932120
L_932120:
	mov r4,0x886000
L_932128:
	ld r8,[r4, 0x24]
L_93212c:
	bmsk r8,r8,0x1e
L_932130:
	st r8,[r4, 0x24]
L_932134:
	ld.as r3,[gp,-0x11]
L_932138:
	and r3,r3,0xffff0fff
L_932140:
	or r10,r3,0xd000
L_932148:
	or r3,r3,0x1d00d000
L_932150:
	st.as r10,[gp,-0x11]
L_932154:
	mov r32,r3
L_932158:
	st.ab r3,[r25,0x4]
L_93215c:
	bclr r25,r25,0xa
L_932160:
	nop_s
L_932162:
	nop_s
L_932164:
	nop_s
L_932166:
	lsr r4,r40,0x9
L_93216a:
	bmsk r4,r4,0xa
L_93216e:
	sub r3,r4,r14
L_932172:
	cmp r4,0x3ff
L_932176:
	mov.hi r9,r3
L_93217a:
	mov.ls r9,r4
L_93217e:
	ld.as r4,[gp,0x1d]
L_932182:
	breq r4,0x0,L_93218c
L_932186:
	ld_s r0,[gp,0x18]
L_932188:
	bbit1 r0,0x0,L_932198
	.global L_93218c
L_93218c:
	brne r4,0x0,L_9321c4
L_932190:
	ld.as r8,[gp,0x6]
L_932194:
	bbit1 r8,0x0,L_9321c4
	.global L_932198
L_932198:
	mov r7,0x80088c
L_9321a0:
	ldb r11,[r7, 0x50]
L_9321a4:
	asl r11,r11,0x3
L_9321a8:
	add2 r11,r11,r11
L_9321ac:
	add r7,r7,r11
L_9321b0:
	ld r5,[r7, 0x18]
L_9321b4:
	brge r5,r9,L_9321c4
L_9321b8:
	st r9,[r7, 0x18]
L_9321bc:
	mov r6,0x1
L_9321c0:
	stb r6,[r7, 0x14]
	.global L_9321c4
L_9321c4:
	mov_s r0,0x1
L_9321c6:
	ld blink,[sp, 0x4]
L_9321ca:
	ld_s r14,[sp,0x8]
L_9321cc:
	ld_s r15,[sp,0xc]
L_9321ce:
	j_s.d [blink]
L_9321d0:
	ld.ab r13,[sp,0x10]
	.global L_9321d4
L_9321d4:
	mov r6,0x1
L_9321d8:
	mov r3,0x80208c
L_9321e0:
	ld r8,[r3, 0x4]
L_9321e4:
	stb r6,[r13, 0x1]
L_9321e8:
	brne.d r8,0x3,L_932200
L_9321ec:
	ld r11,[r3, 0x8]
	.global L_9321f0
L_9321f0:
	ldw r9,[r13, 0x20]
L_9321f4:
	add r9,r9,0x1
L_9321f8:
	b.d L_932278
L_9321fc:
	stw r9,[r13, 0x20]
	.global L_932200
L_932200:
	breq r8,0x0,L_93225c
	.global L_932204
L_932204:
	brne r8,0x1,L_932220
L_932208:
	ldb r10,[0x801034]
L_932210:
	sub.f r10,r10,0x0
L_932214:
	mov.ne r10,0x1
L_932218:
	extb.f 0x0,r10
L_93221c:
	beq L_9321f0
	.global L_932220
L_932220:
	brne r11,0x0,L_932238
L_932224:
	ldb r5,[r13, 0x3]
L_932228:
	ldb r2,[r13, 0x2]
L_93222c:
	asl r5,r5,0x8
L_932230:
	or r2,r2,r5
L_932234:
	bbit1 r2,0x1,L_93224c
	.global L_932238
L_932238:
	brne r11,0x1,L_932284
L_93223c:
	ldb_s r1,[r13,0x3]
L_93223e:
	ldb r8,[r13, 0x2]
L_932242:
	asl_s r1,r1,0x8
L_932244:
	or r8,r8,r1
L_932248:
	bbit1 r8,0x1,L_932284
	.global L_93224c
L_93224c:
	ldw r11,[r13, 0x22]
L_932250:
	add r11,r11,0x1
L_932254:
	b.d L_932278
L_932258:
	stw r11,[r13, 0x22]
	.global L_93225c
L_93225c:
	ldb r10,[0x801034]
L_932264:
	sub.f r10,r10,0x0
L_932268:
	mov.ne r10,0x1
L_93226c:
	extb.f 0x0,r10
L_932270:
	bne L_9321f0
L_932274:
	b L_932204
	.global L_932278
L_932278:
	mov r2,0x0
L_93227c:
	b.d L_9322b4
L_932280:
	stb r2,[r13, 0x1b]
	.global L_932284
L_932284:
	ldw r10,[r3]
L_932288:
	cmp r10,0x0
L_93228c:
	ble L_93208c
L_932290:
	sub r10,r10,0x1
L_932294:
	ldw r9,[r13, 0x24]
L_932298:
	stw r10,[r3]
L_93229c:
	add r9,r9,0x1
L_9322a0:
	b.d L_932278
L_9322a4:
	stw r9,[r13, 0x24]
	.global L_9322a8
L_9322a8:
	mov r4,0x0
L_9322ac:
	stb r4,[r13, 0x1]
L_9322b0:
	stb r4,[r13, 0x1b]
	.global L_9322b4
L_9322b4:
	mov r14,0x0
L_9322b8:
	b.d L_932108
L_9322bc:
	bset r14,r14,0xb
	.global L_9322c0
L_9322c0:
	ld.as r6,[gp,-0x11]
L_9322c4:
	and r6,r6,0xffff0fff
L_9322cc:
	bset r7,r6,0xe
L_9322d0:
	or r6,r6,0x1d004000
L_9322d8:
	st.as r7,[gp,-0x11]
L_9322dc:
	mov r32,r6
L_9322e0:
	st.ab r6,[r25,0x4]
L_9322e4:
	bclr r25,r25,0xa
L_9322e8:
	nop_s
L_9322ea:
	nop_s
L_9322ec:
	nop_s
L_9322ee:
	bmsk r7,r40,0x19
L_9322f2:
	mov r6,0x801e14
L_9322fa:
	ldw r5,[r6, 0x2]
L_9322fe:
	st.as r7,[gp,-0x15]
L_932302:
	mov r11,0x80209c
L_93230a:
	ldb r9,[r11, 0x4]
L_93230e:
	mov_s r2,0x1002f94
L_932314:
	add r5,r5,0x1
L_932318:
	bbit0.d r9,0x2,L_932348
L_93231c:
	stw r5,[r6, 0x2]
L_932320:
	bmsk_s r2,r2,0x13
L_932322:
	ld r4,[r11]
L_932326:
	or r2,r2,0xa2000000
L_93232e:
	extb r3,r4
L_932332:
	mov r10,0x8020b0
L_93233a:
	add2 r3,r10,r3
L_93233e:
	st_s r2,[r3]
L_932340:
	add r4,r4,0x1
L_932344:
	st r4,[r11]
	.global L_932348
L_932348:
	mov_s r2,0x801b08
L_93234e:
	ld_s r3,[r2]
L_932350:
	ld_s r1,[r2,0x18]
L_932352:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_932354:
	st_s r3,[r2]
L_932356:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_932358:
	st r1,[r2, 0x18]
L_93235c:
	mov r8,0x2000020
L_932364:
	mov r32,r8
L_932368:
	st.ab r8,[r25,0x4]
L_93236c:
	bclr r25,r25,0xa
L_932370:
	mov r8,0x2
L_932374:
	stb r8,[r13, 0x4]
L_932378:
	mov_s r0,0x0
L_93237a:
	ld blink,[sp, 0x4]
L_93237e:
	ld_s r14,[sp,0x8]
L_932380:
	ld_s r15,[sp,0xc]
L_932382:
	j_s.d [blink]
L_932384:
	ld.ab r13,[sp,0x10]
	.global L_932388
L_932388:
	mov r1,0x80209c
L_932390:
	ldb r4,[r1, 0x4]
L_932394:
	mov r6,0x1002fa0
L_93239c:
	bbit0.d r4,0x2,L_9323d0
L_9323a0:
	mov r0,0x0
L_9323a4:
	bmsk r6,r6,0x13
L_9323a8:
	ld r5,[r1]
L_9323ac:
	or r6,r6,0xa2000000
L_9323b4:
	extb r7,r5
L_9323b8:
	mov r11,0x8020b0
L_9323c0:
	add2 r7,r11,r7
L_9323c4:
	st r6,[r7]
L_9323c8:
	add r5,r5,0x1
L_9323cc:
	st r5,[r1]
	.global L_9323d0
L_9323d0:
	stb_s r0,[r13,0x4]
L_9323d2:
	ld blink,[sp, 0x4]
L_9323d6:
	ld_s r14,[sp,0x8]
L_9323d8:
	ld_s r15,[sp,0xc]
L_9323da:
	j_s.d [blink]
L_9323dc:
	ld.ab r13,[sp,0x10]
