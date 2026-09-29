/* aw__set_new_tbtt @ 0x93520c, 416 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__cmd_0f_step
 * Зовёт сам: aw__compute_tbtt_from_hw, aw__set_tbtt_offset, aw_tbtt_set_step, mac__get_beacon_interval_tu_uc, sched__calc_next_start_tsf, uc_read_tsf_lo
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global aw__set_new_tbtt
aw__set_new_tbtt:
	.global L_93520c
L_93520c:
	st.a r13,[sp,-0x2c]
L_935210:
	st blink,[sp, 0x4]
L_935214:
	st_s r14,[sp,0x8]
L_935216:
	st_s r15,[sp,0xc]
L_935218:
	st r16,[sp, 0x10]
L_93521c:
	st r17,[sp, 0x14]
L_935220:
	st r18,[sp, 0x18]
L_935224:
	st r21,[sp, 0x24]
L_935228:
	st r22,[sp, 0x28]
L_93522c:
	mov r18,r0
L_935230:
	bl.d L_9364c8
L_935234:
	add3 r21,r0,0x9
L_935238:
	mov_s r13,r0
L_93523a:
	add r1,r18,0x12c
L_935242:
	mov r22,0x0
L_935246:
	mov_s r0,r22
L_935248:
	bl.d L_937518
L_93524c:
	mov r2,r22
L_935250:
	ld.as r6,[r18,0x4b]
L_935254:
	st r19,[sp, 0x1c]
L_935258:
	sub r6,r6,r13
L_93525c:
	cmp r6,0x2710
L_935264:
	bls.d L_935294
L_935268:
	st r20,[sp, 0x20]
L_93526c:
	bl L_9374d8
L_935270:
	add r3,r18,0x200
L_935278:
	ld r7,[r3, -0xd4]
L_93527c:
	asl r0,r0,0xa
L_935280:
	ld r8,[r3, -0xd0]
L_935284:
	sub.f r7,r7,r0
L_935288:
	sbc r8,r8,r22
L_93528c:
	st r7,[r3, -0xd4]
L_935290:
	st.as r8,[r18,0x4c]
	.global L_935294
L_935294:
	add r1,r18,0x20
L_935298:
	add r2,r18,0x2c
L_93529c:
	bl.d L_935560
L_9352a0:
	mov r0,r18
L_9352a4:
	ldb r15,[0x802194]
L_9352ac:
	breq r15,0x0,L_935330
L_9352b0:
	add r16,r18,0x200
L_9352b8:
	add3 r19,r18,0x9
L_9352bc:
	add3 r20,r18,0x15
	.global L_9352c0
L_9352c0:
	norm r2,r15
L_9352c4:
	rsub r7,r2,0x1e
L_9352c8:
	asl r13,0x1,r7
L_9352d0:
	not r17,r13
L_9352d4:
	and r15,r15,r17
L_9352d8:
	asl r14,r7,0x2
L_9352dc:
	add1 r14,r14,r14
L_9352e0:
	add r1,r19,r14
L_9352e4:
	asl r7,r7,0x4
L_9352e8:
	add r2,r20,r7
L_9352ec:
	bl.d L_935560
L_9352f0:
	mov r0,r18
L_9352f4:
	ldb r4,[r16, -0xd8]
L_9352f8:
	extb r15,r15
L_9352fc:
	ld r6,[r21,r14]
L_935300:
	and r4,r4,r17
L_935304:
	breq.d r6,0x2,L_935314
L_935308:
	stb r4,[r16, -0xd8]
L_93530c:
	or r4,r4,r13
L_935310:
	stb r4,[r16, -0xd8]
	.global L_935314
L_935314:
	ldb r5,[r16, -0xd7]
L_935318:
	and r5,r5,r17
L_93531c:
	brne.d r6,0x0,L_93532c
L_935320:
	stb r5,[r16, -0xd7]
L_935324:
	or r13,r13,r5
L_935328:
	stb r13,[r16, -0xd7]
	.global L_93532c
L_93532c:
	brne r15,0x0,L_9352c0
	.global L_935330
L_935330:
	ld r0,[r18, 0x20]
L_935334:
	cmp r0,0x0
L_935338:
	bl.ne.d L_924768
L_93533c:
	mov.ne r0,r18
L_935340:
	ld r3,[r18, 0x44]
L_935344:
	breq_s r3,0,L_935380
L_935346:
	ld.as r6,[r18,0x4b]
L_93534a:
	ld r1,[r18, 0x3c]
L_93534e:
	brlo r6,r1,L_935380
L_935352:
	mov_s r0,0x802f68
L_935358:
	bl.d L_934dbc
L_93535c:
	ldw r1,[r18, 0x40]
L_935360:
	st r22,[r18, 0x44]
L_935364:
	mov r5,0x802f80
L_93536c:
	ldw.as r2,[r5,0xbe]
L_935370:
	add r2,r2,0x1
L_935374:
	stw.as r2,[r5,0xbe]
L_935378:
	ld r4,[r18, 0x40]
L_93537c:
	stw.as r4,[r5,0xbf]
	.global L_935380
L_935380:
	ld blink,[sp, 0x4]
L_935384:
	ld_s r14,[sp,0x8]
L_935386:
	ld_s r15,[sp,0xc]
L_935388:
	ld r16,[sp, 0x10]
L_93538c:
	ld r17,[sp, 0x14]
L_935390:
	ld r18,[sp, 0x18]
L_935394:
	ld r19,[sp, 0x1c]
L_935398:
	ld r20,[sp, 0x20]
L_93539c:
	ld r21,[sp, 0x24]
L_9353a0:
	ld r22,[sp, 0x28]
L_9353a4:
	j.d [blink]
L_9353a8:
	ld.ab r13,[sp,0x2c]
