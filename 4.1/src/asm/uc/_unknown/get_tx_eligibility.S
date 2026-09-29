/* get_tx_eligibility @ 0x92616c, 372 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   get_tx_eligibility(), Denide BF go to next internal
 *   get_tx_eligibility(), There is no eligibility in Internal Queue
 * Зовут его: get_tx_eligibility__precheck, rx_funcs__handle_ppdu_report, rx_funcs__identify_peer
 * Зовёт сам: get_g_800674, set_bit_80067c, set_g_80067c, tx__take_eligibility_slot
 */
	.section .text.get_tx_eligibility,"ax",@progbits
	.global get_tx_eligibility
get_tx_eligibility:
	.global L_92616c
L_92616c:
	push_s r13
L_92616e:
	mov_s r3,0x804010
L_926174:
	ld_s r13,[r3,0x10]
L_926176:
	bmsk_s r13,r13,0x5
L_926178:
	st_s r13,[r0]
L_92617a:
	ld_s r0,[r3,0x10]
L_92617c:
	lsr_s r0,r0,0x6
L_92617e:
	bmsk_s r0,r0,0x1
L_926180:
	st_s r0,[r1]
L_926182:
	ldb.x r0,[r3, 0x11]
L_926186:
	stb_s r0,[r2]
L_926188:
	j_s.d [blink]
L_92618a:
	pop_s r13
	.global L_92618c
L_92618c:
	st.a r13,[sp,-0x14]
L_926190:
	st blink,[sp, 0x4]
L_926194:
	st_s r14,[sp,0x8]
L_926196:
	st_s r15,[sp,0xc]
L_926198:
	st r16,[sp, 0x10]
L_92619c:
	sub_s sp,sp,0x4
L_92619e:
	mov_s r15,r0
L_9261a0:
	bl.d L_928ca8
L_9261a4:
	mov r16,r1
L_9261a8:
	bl L_928e5c
L_9261ac:
	mov r14,r0
	.global L_9261b0
L_9261b0:
	norm r5,r14
L_9261b4:
	rsub r13,r5,0x1e
L_9261b8:
	breq r13,0x2,L_926234
L_9261bc:
	cmp_s r13,0x3
L_9261be:
	bne_s L_9262c8
L_9261c0:
	ld.as r2,[gp,-0x2f]
L_9261c4:
	ld.as r7,[r15,0x4d]
L_9261c8:
	asl r8,0x1,r2
L_9261d0:
	tst r8,r7
L_9261d4:
	bne.d L_9261e0
L_9261d8:
	mov_s r3,0x1
L_9261da:
	tst r8,r16
L_9261de:
	sub_s.ne r3,r3,r3
	.global L_9261e0
L_9261e0:
	cmp_s r3,0x0
L_9261e2:
	bne_s L_9262c8
L_9261e4:
	bl.d L_928c98
L_9261e8:
	mov r0,0x3
L_9261ec:
	mov_s r0,0x80209c
L_9261f2:
	ldb r6,[r0, 0x5]
L_9261f6:
	mov r11,0x1002d80
L_9261fe:
	bbit0 r6,0x2,L_926274
L_926202:
	bmsk r11,r11,0x13
L_926206:
	ld r10,[r0]
L_92620a:
	or r11,r11,0xa2100000
L_926212:
	extb r1,r10
L_926216:
	mov_s r3,0x8020b0
L_92621c:
	add2_s r3,r3,r1
L_92621e:
	st r11,[r3]
L_926222:
	add r10,r10,0x1
L_926226:
	st r10,[r0]
L_92622a:
	bclr.f r14,r14,r13
L_92622e:
	bne_s L_9261b0
L_926230:
	b L_92627c
	.global L_926234
L_926234:
	bl.d L_926354
L_926238:
	mov r0,sp
L_92623c:
	breq r0,0x0,L_9262c8
L_926240:
	ld r1,[sp]
L_926244:
	ld.as r4,[r15,0x4d]
L_926248:
	asl r5,0x1,r1
L_926250:
	tst r4,r5
L_926254:
	bne.d L_926264
L_926258:
	mov r6,0x1
L_92625c:
	tst r5,r16
L_926260:
	sub.ne r6,r6,r6
	.global L_926264
L_926264:
	brne r6,0x0,L_9262c8
L_926268:
	stb r1,[gp, -0xea]
L_92626c:
	bl.d L_928c98
L_926270:
	mov r0,0x2
	.global L_926274
L_926274:
	bclr.f r14,r14,r13
L_926278:
	bne L_9261b0
	.global L_92627c
L_92627c:
	mov_s r2,0x80209c
L_926282:
	ldb_s r1,[r2,0x5]
L_926284:
	mov r8,0x1002db4
L_92628c:
	bbit0 r1,0x2,L_9262bc
L_926290:
	bmsk r8,r8,0x13
L_926294:
	ld r9,[r2]
L_926298:
	or r8,r8,0xa2100000
L_9262a0:
	extb r10,r9
L_9262a4:
	mov r0,0x8020b0
L_9262ac:
	add2 r0,r0,r10
L_9262b0:
	st r8,[r0]
L_9262b4:
	add r9,r9,0x1
L_9262b8:
	st r9,[r2]
	.global L_9262bc
L_9262bc:
	bl L_928ca8
L_9262c0:
	b.d L_9262cc
L_9262c4:
	mov r0,0x0
	.global L_9262c8
L_9262c8:
	mov r0,0x1
	.global L_9262cc
L_9262cc:
	add_s sp,sp,0x4
L_9262ce:
	ld blink,[sp, 0x4]
L_9262d2:
	ld_s r14,[sp,0x8]
L_9262d4:
	ld_s r15,[sp,0xc]
L_9262d6:
	ld r16,[sp, 0x10]
L_9262da:
	j_s.d [blink]
L_9262dc:
	ld.ab r13,[sp,0x14]
