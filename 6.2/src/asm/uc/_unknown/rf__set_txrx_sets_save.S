/* rf__set_txrx_sets_save @ 0x92a314, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rfc__restore_txrx_sets
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rf__set_txrx_sets_save
rf__set_txrx_sets_save:
	.global L_92a314
L_92a314:
	st.a r13,[sp,-0x14]
L_92a318:
	st blink,[sp, 0x4]
L_92a31c:
	st_s r14,[sp,0x8]
L_92a31e:
	st_s r15,[sp,0xc]
L_92a320:
	st r16,[sp, 0x10]
L_92a324:
	mov_s r15,r0
L_92a326:
	mov_s r14,0x889800
L_92a32c:
	breq.d r2,0x0,L_92a33c
L_92a330:
	mov r16,r1
L_92a334:
	ld.as r7,[r14,-0xde]
L_92a338:
	st r7,[r2]
	.global L_92a33c
L_92a33c:
	mov_s r13,0x889000
L_92a342:
	breq_s r3,0,L_92a34c
L_92a344:
	ld.as r6,[r13,0x55]
L_92a348:
	st r6,[r3]
	.global L_92a34c
L_92a34c:
	and.f 0x0,r16,0xffffff00
L_92a354:
	bne L_92a3a8
	.global L_92a358
L_92a358:
	ld.as r5,[r14,-0xde]
L_92a35c:
	asl r16,r16,0x10
L_92a360:
	and r5,r5,0xff00ffff
L_92a368:
	or r16,r16,r5
L_92a36c:
	st.as r16,[r14,-0xde]
L_92a370:
	bic.f r14,r15,0xf
L_92a374:
	bne L_92a3b8
	.global L_92a378
L_92a378:
	brne r14,0x0,L_92a3c8
	.global L_92a37c
L_92a37c:
	ld.as r4,[r13,0x55]
L_92a380:
	ld blink,[sp, 0x4]
L_92a384:
	bic r4,r4,0xf
L_92a388:
	or r4,r4,r15
L_92a38c:
	bic r4,r4,0xf0
L_92a390:
	/* asl_s r15,r15,0x4 */
	.byte 0x04,0xbf
L_92a392:
	or r4,r4,r15
L_92a396:
	st.as r4,[r13,0x55]
L_92a39a:
	ld_s r14,[sp,0x8]
L_92a39c:
	ld_s r15,[sp,0xc]
L_92a39e:
	ld r16,[sp, 0x10]
L_92a3a2:
	j_s.d [blink]
L_92a3a4:
	ld.ab r13,[sp,0x14]
	.global L_92a3a8
L_92a3a8:
	mov r0,blink
L_92a3ac:
	bl.d L_926618
L_92a3b0:
	mov r1,0xac
L_92a3b4:
	b L_92a358
	.global L_92a3b8
L_92a3b8:
	mov r0,blink
L_92a3bc:
	bl.d L_926618
L_92a3c0:
	mov r1,0xad
L_92a3c4:
	b L_92a378
	.global L_92a3c8
L_92a3c8:
	mov r0,blink
L_92a3cc:
	bl.d L_926618
L_92a3d0:
	mov r1,0xae
L_92a3d4:
	b_s L_92a37c
L_92a3d6:
	nop_s
