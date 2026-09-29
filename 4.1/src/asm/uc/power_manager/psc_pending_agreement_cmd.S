/* psc_pending_agreement_cmd @ 0x92b308, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   psc_pending_agreement_cmd() sleep_cycle: %x, bi_start_time: %x
 *   power_manager.cpp
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: uc_sysassert
 */
	.section .text.psc_pending_agreement_cmd,"ax",@progbits
	.global psc_pending_agreement_cmd
psc_pending_agreement_cmd:
	.global L_92b308
L_92b308:
	mov_s r1,r0
L_92b30a:
	mov_s r0,0x801ed0
L_92b310:
	b L_92b314
	.global L_92b314
L_92b314:
	st.a r13,[sp,-0x10]
L_92b318:
	st blink,[sp, 0x4]
L_92b31c:
	st_s r14,[sp,0x8]
L_92b31e:
	st_s r15,[sp,0xc]
L_92b320:
	ldb_s r15,[r1]
L_92b322:
	mov_s r14,r1
L_92b324:
	cmp r15,0xff
L_92b328:
	mov r13,r0
L_92b32c:
	beq.d L_92b340
L_92b330:
	add.eq r13,r13,0x2c
L_92b334:
	brhs r15,0x8,L_92b3c8
	.global L_92b338
L_92b338:
	/* asl_s r15,r15,0x4 */
	.byte 0x04,0xbf
L_92b33a:
	add r13,r13,0xa8
L_92b33e:
	add_s r13,r13,r15
	.global L_92b340
L_92b340:
	ldb_s r2,[r14,0x1]
L_92b342:
	mov_s r1,0x1002df4
L_92b348:
	stb r2,[r13, 0x4]
L_92b34c:
	ld r8,[r14, 0x4]
L_92b350:
	ld r6,[r14, 0x8]
L_92b354:
	st r8,[r13, 0x8]
L_92b358:
	st r6,[r13, 0xc]
L_92b35c:
	mov r5,0x80209c
L_92b364:
	ldb r7,[r5, 0x4]
L_92b368:
	ld r4,[r13, 0x8]
L_92b36c:
	ldw r6,[r13, 0xc]
L_92b370:
	bbit0.d r7,0x2,L_92b3b4
L_92b374:
	mov r8,0x1
L_92b378:
	ld r0,[r5]
L_92b37c:
	mov_s r2,0x8020b0
L_92b382:
	add_s r3,r0,0x2
L_92b384:
	extb_s r3,r3
L_92b386:
	add2 r3,r2,r3
L_92b38a:
	st r4,[r3]
L_92b38e:
	add_s r3,r0,0x1
L_92b390:
	extb_s r3,r3
L_92b392:
	add2 r3,r2,r3
L_92b396:
	st r6,[r3]
L_92b39a:
	bmsk_s r1,r1,0x13
L_92b39c:
	or r1,r1,0xaa000000
L_92b3a4:
	extb r4,r0
L_92b3a8:
	add2 r2,r2,r4
L_92b3ac:
	st_s r1,[r2]
L_92b3ae:
	/* add_s r0,0x3 */
	.byte 0x03,0xe0
L_92b3b0:
	st r0,[r5]
	.global L_92b3b4
L_92b3b4:
	st r8,[r13]
L_92b3b8:
	ld blink,[sp, 0x4]
L_92b3bc:
	ld_s r14,[sp,0x8]
L_92b3be:
	ld_s r15,[sp,0xc]
L_92b3c0:
	j.d [blink]
L_92b3c4:
	ld.ab r13,[sp,0x10]
	.global L_92b3c8
L_92b3c8:
	mov_s r0,blink
L_92b3ca:
	mov_s r2,0x1002cd0
L_92b3d0:
	mov r1,0x1481
L_92b3d8:
	bl.d L_925548
L_92b3dc:
	mov r3,0x1bc
L_92b3e0:
	b_s L_92b338
L_92b3e2:
	nop_s
