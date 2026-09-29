/* abft_responder_substep @ 0x92c844, 292 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder_worker
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x80057c
 */
	.section .text.abft_responder_substep,"ax",@progbits
	.global abft_responder_substep
abft_responder_substep:
	.global L_92c844
L_92c844:
	st.a r13,[sp,-0x8]
L_92c848:
	st_s r14,[sp,0x4]
L_92c84a:
	mov_s r14,blink
L_92c84c:
	mov_s r13,r0
L_92c84e:
	mov_s r0,0x0
L_92c850:
	bset r0,r0,0x10
L_92c854:
	bl.d L_931808
L_92c858:
	mov r1,0x0
L_92c85c:
	ldb r5,[gp, -0xf3]
L_92c860:
	breq r5,0x0,L_92c920
	.global L_92c864
L_92c864:
	ld_s r0,[gp,0x54]
L_92c866:
	mov_s r1,0x2011000
L_92c86c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92c86e:
	st.as r0,[gp,0x15]
L_92c872:
	mov_s r0,0x801458
L_92c878:
	ld r11,[r0, 0x38]
L_92c87c:
	add r11,r11,0x1
L_92c880:
	st r11,[r0, 0x38]
L_92c884:
	mov r32,r1
L_92c888:
	st.ab r1,[r25,0x4]
L_92c88c:
	bclr r25,r25,0xa
L_92c890:
	mov r4,r37
L_92c894:
	bbit0 r4,0x19,L_92c958
L_92c898:
	mov r9,0x804010
L_92c8a0:
	mov r10,0x801e68
L_92c8a8:
	ldb r11,[r10, 0x10]
L_92c8ac:
	ldb r3,[r9, 0xa]
L_92c8b0:
	brne r3,r11,L_92c958
L_92c8b4:
	ldb r0,[r10, 0x11]
L_92c8b8:
	ldb r6,[r9, 0xb]
L_92c8bc:
	brne r0,r6,L_92c958
L_92c8c0:
	ldb r1,[r10, 0x12]
L_92c8c4:
	ldb r4,[r9, 0xc]
L_92c8c8:
	brne r1,r4,L_92c958
L_92c8cc:
	ldb r2,[r10, 0x13]
L_92c8d0:
	ldb r5,[r9, 0xd]
L_92c8d4:
	brne r2,r5,L_92c958
L_92c8d8:
	ldb r3,[r10, 0x14]
L_92c8dc:
	ldb r8,[r9, 0xe]
L_92c8e0:
	brne r3,r8,L_92c958
L_92c8e4:
	ldb r10,[r10, 0x15]
L_92c8e8:
	ldb r7,[r9, 0xf]
L_92c8ec:
	brne r10,r7,L_92c958
L_92c8f0:
	ld r1,[r9, 0x10]
L_92c8f4:
	bmsk_s r1,r1,0x5
L_92c8f6:
	stb_s r1,[r13,0xe]
L_92c8f8:
	ld r2,[r9, 0x10]
L_92c8fc:
	lsr_s r2,r2,0x6
L_92c8fe:
	bmsk_s r2,r2,0x1
L_92c900:
	stb_s r2,[r13,0xf]
L_92c902:
	ldb.x r8,[r9, 0x11]
L_92c906:
	stb r8,[r13, 0x10]
L_92c90a:
	mov r7,r38
L_92c90e:
	bbit0 r7,0xb,L_92c948
L_92c912:
	lsr r2,r38,0x8
L_92c916:
	bmsk_s r2,r2,0x2
L_92c918:
	b.d L_92c950
L_92c91c:
	stb r2,[r13, 0xd]
	.global L_92c920
L_92c920:
	ldb r1,[gp, -0xf9]
L_92c924:
	bmsk_s r1,r1,0x0
L_92c926:
	or r1,r1,0x32000000
L_92c92e:
	mov_s r32,r1
L_92c930:
	st.ab r1,[r25,0x4]
L_92c934:
	bclr r25,r25,0xa
L_92c938:
	ldb r3,[gp, -0xf9]
L_92c93c:
	add r3,r3,0x1
L_92c940:
	b.d L_92c864
L_92c944:
	stb r3,[gp, -0xf9]
	.global L_92c948
L_92c948:
	mov r6,0x8
L_92c94c:
	stb r6,[r13, 0xd]
	.global L_92c950
L_92c950:
	b.d L_92c95c
L_92c954:
	mov r0,0x1
	.global L_92c958
L_92c958:
	mov r0,0x0
	.global L_92c95c
L_92c95c:
	mov_s blink,r14
L_92c95e:
	ld_s r14,[sp,0x4]
L_92c960:
	j.d [blink]
L_92c964:
	ld.ab r13,[sp,0x8]
