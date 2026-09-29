/* bf_gpc__program_mac_by_mode_b @ 0x92b58c, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bf_gpc_service.cpp
 * Зовут его: bti_transmitter_bi2_flow
 * Зовёт сам: uc_sysassert
 */
	.section .text.bf_gpc__program_mac_by_mode_b,"ax",@progbits
	.global bf_gpc__program_mac_by_mode_b
bf_gpc__program_mac_by_mode_b:
	.global L_92b58c
L_92b58c:
	st.a r13,[sp,-0xc]
L_92b590:
	mov_s r13,0x801e68
L_92b596:
	ldb_s r1,[r13,0x3]
L_92b598:
	st_s r14,[sp,0x8]
L_92b59a:
	lsr_s r1,r1,0x2
L_92b59c:
	bmsk r1,r1,0x3
L_92b5a0:
	st blink,[sp, 0x4]
L_92b5a4:
	brlo.d r1,0x4,L_92b618
L_92b5a8:
	mov r14,r0
	.global L_92b5ac
L_92b5ac:
	mov_s r2,0x802060
L_92b5b2:
	sub_s r2,r2,0x8
L_92b5b4:
	ldw.as r4,[r2,r1]
L_92b5b8:
	ldb_s r0,[r13,0x3]
L_92b5ba:
	ldb_s r2,[r13,0x2]
L_92b5bc:
	asl_s r0,r0,0x8
L_92b5be:
	or_s r2,r2,r0
L_92b5c0:
	lsr_s r2,r2,0x7
L_92b5c2:
	bmsk r3,r2,0x2
L_92b5c6:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_92b5c8:
	mulu64 r3,r4
L_92b5cc:
	add r4,mlo,0x5cd
L_92b5d4:
	sub r4,r4,r14
L_92b5d8:
	or r4,r4,0x51000000
L_92b5e0:
	mov r32,r4
L_92b5e4:
	st.ab r4,[r25,0x4]
L_92b5e8:
	bclr r25,r25,0xa
L_92b5ec:
	mov_s r3,0x5400070e
L_92b5f2:
	mov_s r32,r3
L_92b5f4:
	st.ab r3,[r25,0x4]
L_92b5f8:
	bclr r25,r25,0xa
L_92b5fc:
	mov_s r2,0x49000100
L_92b602:
	mov_s r32,r2
L_92b604:
	st.ab r2,[r25,0x4]
L_92b608:
	bclr r25,r25,0xa
L_92b60c:
	ld blink,[sp, 0x4]
L_92b610:
	ld_s r14,[sp,0x8]
L_92b612:
	j_s.d [blink]
L_92b614:
	ld.ab r13,[sp,0xc]
	.global L_92b618
L_92b618:
	mov_s r0,blink
L_92b61a:
	mov_s r2,0x10028ec
L_92b620:
	mov r1,0x1471
L_92b628:
	bl.d L_925548
L_92b62c:
	mov r3,0x19
L_92b630:
	ldb_s r1,[r13,0x3]
L_92b632:
	lsr_s r1,r1,0x2
L_92b634:
	b.d L_92b5ac
L_92b638:
	bmsk_s r1,r1,0x3
L_92b63a:
	nop_s
