/* bap_q_avail__check @ 0x930268, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx__dispatch_by_g_8005f8
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bap_q_avail__check
bap_q_avail__check:
	.global L_930268
L_930268:
	push_s blink
L_93026a:
	bl.d L_920230
L_93026e:
	mul64 r0,0x2c
L_930272:
	mov_s r14,0x802670
L_930278:
	mov_s r3,mlo
L_93027a:
	add_s r13,r14,r3
L_93027c:
	ldb_s r15,[r13,0x1f]
L_93027e:
	ldb_s r0,[r13,0x1b]
L_930280:
	brne_s r15,0,L_930294
L_930282:
	add_s r14,r14,r0
L_930284:
	ldb.a r0,[r3,r14]
L_930288:
	add_s r0,r0,r1
L_93028a:
	stb_s r0,[r3]
L_93028c:
	ldb_s r0,[r3,0xd]
L_93028e:
	add_s r2,r2,r0
L_930290:
	stb_s r2,[r3,0xd]
L_930292:
	b_s L_9302d2
	.global L_930294
L_930294:
	ld_s r0,[gp,-0x44]
L_930296:
	and r0,r0,0xfffff0ff
L_93029e:
	bset r1,r0,0xa
L_9302a2:
	bset_s r1,r1,0xb
L_9302a4:
	or r0,r0,0x1d000c00
L_9302ac:
	st.as r1,[gp,-0x11]
L_9302b0:
	mov_s r32,r0
L_9302b2:
	st.ab r0,[r25,0x4]
L_9302b6:
	bclr r25,r25,0xa
L_9302ba:
	nop_s
L_9302bc:
	nop_s
L_9302be:
	nop_s
L_9302c0:
	asl.f 0x0,r41,0x2
L_9302c4:
	bne_s L_9302cc
L_9302c6:
	mov_s r0,0x0
L_9302c8:
	stb_s r0,[r13,0x1f]
L_9302ca:
	b_s L_9302d2
	.global L_9302cc
L_9302cc:
	ld_s r0,[r13,0x20]
L_9302ce:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9302d0:
	st_s r0,[r13,0x20]
	.global L_9302d2
L_9302d2:
	b L_92029c
L_9302d6:
	nop_s
