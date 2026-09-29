/* bti__arm_period_gp0 @ 0x9307bc, 332 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_bi2__track_best_metric
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti__arm_period_gp0
bti__arm_period_gp0:
	.global L_9307bc
L_9307bc:
	st.a r13,[sp,-0xc]
L_9307c0:
	mov r13,0x802f14
L_9307c8:
	ldb r5,[r13, 0x3]
L_9307cc:
	st blink,[sp, 0x4]
L_9307d0:
	lsr r5,r5,0x2
L_9307d4:
	bmsk r5,r5,0x3
L_9307d8:
	cmp r5,0x4
L_9307dc:
	bcs.d L_9308ec
L_9307e0:
	st r14,[sp, 0x8]
	.global L_9307e4
L_9307e4:
	mov_s r2,0x80167c
L_9307ea:
	sub_s r2,r2,0x8
L_9307ec:
	ldw.as r14,[r2,r5]
L_9307f0:
	mov_s r1,r54
L_9307f2:
	btst_s r1,0x7
L_9307f4:
	beq_s L_9308a4
L_9307f6:
	mov r5,0x802f14
L_9307fe:
	ldb r0,[r5, 0x3]
L_930802:
	ldb r4,[r5, 0x2]
L_930806:
	asl_s r0,r0,0x8
L_930808:
	or r4,r4,r0
L_93080c:
	lsr r4,r4,0x7
L_930810:
	bmsk r4,r4,0x2
L_930814:
	add r4,r4,0x1
L_930818:
	mulu64 r4,r14
L_93081c:
	mov_s r0,0x4d00000a
L_930822:
	mov_s r13,mlo
L_930824:
	mov r32,r0
L_930828:
	st.ab r0,[r25,0x4]
L_93082c:
	bclr r25,r25,0xa
L_930830:
	nop_s
L_930832:
	nop_s
L_930834:
	mov 0x0,0x0
L_930838:
	sub r13,r13,r55
L_93083c:
	mov r6,0x0
L_930840:
	brlo.d r13,r14,L_93085c
L_930844:
	stb r6,[gp, -0xe5]
	.global L_930848
L_930848:
	sub r13,r13,r14
L_93084c:
	add r6,r6,0x1
L_930850:
	brhs.d r13,r14,L_930848
L_930854:
	extb r6,r6
L_930858:
	stb r6,[gp, -0xe5]
	.global L_93085c
L_93085c:
	sub r3,r14,r13
L_930860:
	or r3,r3,0x50000000
L_930868:
	mov r32,r3
L_93086c:
	st.ab r3,[r25,0x4]
L_930870:
	bclr r25,r25,0xa
L_930874:
	mov r8,0x5300080e
L_93087c:
	mov r32,r8
L_930880:
	st.ab r8,[r25,0x4]
L_930884:
	bclr r25,r25,0xa
L_930888:
	mov r9,0x49000080
L_930890:
	mov r32,r9
L_930894:
	st.ab r9,[r25,0x4]
L_930898:
	bclr r25,r25,0xa
L_93089c:
	mov r7,0x1
L_9308a0:
	stb r7,[gp, -0xef]
	.global L_9308a4
L_9308a4:
	or r14,r14,0x50000000
L_9308ac:
	mov r32,r14
L_9308b0:
	st.ab r14,[r25,0x4]
L_9308b4:
	bclr r25,r25,0xa
L_9308b8:
	mov r6,0x5300080e
L_9308c0:
	mov r32,r6
L_9308c4:
	st.ab r6,[r25,0x4]
L_9308c8:
	bclr r25,r25,0xa
L_9308cc:
	mov r7,0x49000080
L_9308d4:
	mov r32,r7
L_9308d8:
	st.ab r7,[r25,0x4]
L_9308dc:
	bclr r25,r25,0xa
L_9308e0:
	ld blink,[sp, 0x4]
L_9308e4:
	ld_s r14,[sp,0x8]
L_9308e6:
	j_s.d [blink]
L_9308e8:
	ld.ab r13,[sp,0xc]
	.global L_9308ec
L_9308ec:
	mov_s r0,blink
L_9308ee:
	mov_s r1,0x55
L_9308f0:
	bl.d L_926618
L_9308f4:
	asl r1,r1,0x6
L_9308f8:
	ldb r5,[r13, 0x3]
L_9308fc:
	lsr r5,r5,0x2
L_930900:
	b.d L_9307e4
L_930904:
	bmsk r5,r5,0x3
