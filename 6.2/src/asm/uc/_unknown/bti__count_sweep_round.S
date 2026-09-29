/* bti__count_sweep_round @ 0x9222e0, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti__bi2_event_step
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti__count_sweep_round
bti__count_sweep_round:
	.global L_9222e0
L_9222e0:
	st.a r13,[sp,-0x8]
L_9222e4:
	st_s r14,[sp,0x4]
L_9222e6:
	mov_s r13,r0
L_9222e8:
	mov_s r3,0x802a6c
L_9222ee:
	ld_s r0,[r3]
L_9222f0:
	mov_s r14,blink
L_9222f2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9222f4:
	ld_s r1,[r3,0x18]
L_9222f6:
	st_s r0,[r3]
L_9222f8:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_9222fa:
	st_s r1,[r3,0x18]
L_9222fc:
	ldb_s r2,[r13,0x5]
L_9222fe:
	mov r9,0x2000020
L_922306:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_922308:
	stb r2,[r13, 0x5]
L_92230c:
	mov r32,r9
L_922310:
	st.ab r9,[r25,0x4]
L_922314:
	bclr r25,r25,0xa
L_922318:
	ldb r8,[0x85773c]
L_922320:
	brlt r8,0x2,L_922340
L_922324:
	ldb r7,[r13, 0x5]
L_922328:
	brne r7,r8,L_922340
L_92232c:
	mov r5,0x0
L_922330:
	stb r5,[r13, 0x5]
L_922334:
	mov r4,0x5
L_922338:
	b.d L_922348
L_92233c:
	stb r4,[r13, 0x4]
	.global L_922340
L_922340:
	mov r6,0x2
L_922344:
	stb r6,[r13, 0x4]
	.global L_922348
L_922348:
	mov_s blink,r14
L_92234a:
	ld_s r14,[sp,0x4]
L_92234c:
	j.d [blink]
L_922350:
	ld.ab r13,[sp,0x8]
