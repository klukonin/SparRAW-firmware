/* brp_copy_step @ 0x9232a8, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__flow_main
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, memcpy_uc, memset0_words_uc
 */
	.section .text.brp_copy_step,"ax",@progbits
	.global brp_copy_step
brp_copy_step:
	.global L_9232a8
L_9232a8:
	push_s blink
L_9232aa:
	bl L_92020c
L_9232ae:
	st.a r0,[sp,-0x10]
L_9232b2:
	mov_s r13,r3
L_9232b4:
	mov r16,r4
L_9232b8:
	btst_s r1,0x7
L_9232ba:
	mov.ne r3,0x4
L_9232be:
	mov.ne r0,0x3
L_9232c2:
	bne_s L_9232d6
L_9232c4:
	btst_s r1,0x6
L_9232c6:
	mov.ne r3,0x2
L_9232ca:
	bne_s L_9232d4
L_9232cc:
	btst_s r1,0x5
L_9232ce:
	mov_s r3,0x1
L_9232d0:
	mov.eq r3,0x0
	.global L_9232d4
L_9232d4:
	mov_s r0,r3
	.global L_9232d6
L_9232d6:
	add_s r2,r2,r3
L_9232d8:
	asr_s r2,r2,r0
L_9232da:
	add_s r1,r1,r3
L_9232dc:
	asr_s r1,r1,r0
L_9232de:
	extb_s r2,r2
L_9232e0:
	min r0,r2,0x1f
L_9232e4:
	extb_s r1,r1
L_9232e6:
	min r1,r1,0x1f
L_9232ea:
	extb_s r0,r0
L_9232ec:
	mov_s r2,0x80084c
L_9232f2:
	ldb_s r14,[r2,r0]
L_9232f4:
	extb_s r1,r1
L_9232f6:
	ldb_s r15,[r2,r1]
L_9232f8:
	add_s r0,sp,0x4
L_9232fa:
	bl.d L_92166c
L_9232fe:
	mov_s r1,0xc
L_923300:
	sub_s r15,r15,r14
L_923302:
	sexb_s r15,r15
L_923304:
	add r0,r15,r16
L_923308:
	sexb_s r0,r0
L_92330a:
	max r0,r0,0x0
L_92330e:
	sexb_s r0,r0
L_923310:
	brge r0,0x5,L_923324
L_923314:
	mov_s r1,0x800758
L_92331a:
	ldb_s r1,[r1,0x4]
L_92331c:
	bbit0 r1,0x6,L_923324
L_923320:
	st_s r13,[sp,0xc]
L_923322:
	b_s L_923374
	.global L_923324
L_923324:
	brge r0,0xd,L_92333a
L_923328:
	mov_s r1,0x800758
L_92332e:
	ldb_s r1,[r1,0x4]
L_923330:
	bbit0 r1,0x5,L_92333a
L_923334:
	st_s r13,[sp,0xc]
L_923336:
	st_s r13,[sp,0x4]
L_923338:
	b_s L_923376
	.global L_92333a
L_92333a:
	brge r0,0x15,L_92334e
L_92333e:
	mov_s r1,0x800758
L_923344:
	ldb_s r1,[r1,0x4]
L_923346:
	bbit0 r1,0x4,L_92334e
L_92334a:
	st_s r13,[sp,0xc]
L_92334c:
	b_s L_923376
	.global L_92334e
L_92334e:
	brge r0,0x1d,L_923364
L_923352:
	mov_s r1,0x800758
L_923358:
	ldb_s r1,[r1,0x4]
L_92335a:
	bbit0 r1,0x3,L_923364
L_92335e:
	st_s r13,[sp,0x8]
L_923360:
	st_s r13,[sp,0x4]
L_923362:
	b_s L_923376
	.global L_923364
L_923364:
	brge r0,0x25,L_923376
L_923368:
	mov_s r0,0x800758
L_92336e:
	ldb_s r0,[r0,0x4]
L_923370:
	bbit0 r0,0x2,L_923376
	.global L_923374
L_923374:
	st_s r13,[sp,0x8]
	.global L_923376
L_923376:
	ld_s r0,[sp,0x0]
L_923378:
	add_s r1,sp,0x4
L_92337a:
	bl.d L_920310
L_92337e:
	mov_s r2,0xc
L_923380:
	b.d L_920274
L_923384:
	add_s sp,sp,0x10
L_923386:
	nop_s
