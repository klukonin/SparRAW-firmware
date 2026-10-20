/* power_mngr_peer_update @ 0x9302a4, 380 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_worker__collect_awake_peers, bi_manager__rx_bi_flow, rx_flow__grant_detected, rx_flow__handle_frame
 * Зовёт сам: mac__read_pair64_consistent
 */
	.section .text.power_mngr_peer_update,"ax",@progbits
	.global power_mngr_peer_update
power_mngr_peer_update:
	.global L_9302a4
L_9302a4:
	st.a r13,[sp,-0x10]
L_9302a8:
	st blink,[sp, 0x4]
L_9302ac:
	st_s r14,[sp,0x8]
L_9302ae:
	st_s r15,[sp,0xc]
L_9302b0:
	sub sp,sp,0x8
L_9302b4:
	breq.d r1,0x0,L_9302e8
L_9302b8:
	mov_s r14,r0
L_9302ba:
	breq r1,0x1,L_930300
L_9302be:
	breq r1,0x2,L_930320
L_9302c2:
	breq r1,0x3,L_930310
L_9302c6:
	brne r1,0x4,L_93032c
L_9302ca:
	ld.as r11,[r14,0x4f]
L_9302ce:
	add_s sp,sp,0x8
L_9302d0:
	or r11,r11,r2
L_9302d4:
	st.as r11,[r14,0x4f]
L_9302d8:
	ld blink,[sp, 0x4]
L_9302dc:
	ld_s r14,[sp,0x8]
L_9302de:
	ld_s r15,[sp,0xc]
L_9302e0:
	j.d [blink]
L_9302e4:
	ld.ab r13,[sp,0x10]
	.global L_9302e8
L_9302e8:
	mov_s r0,0x0
L_9302ea:
	st.as r0,[r14,0x4d]
L_9302ee:
	st.as r0,[r14,0x4e]
L_9302f2:
	st.as r0,[r14,0x4f]
L_9302f6:
	mov_s r1,0x1
L_9302f8:
	b.d L_93032c
L_9302fc:
	st.as r1,[r14,0x50]
	.global L_930300
L_930300:
	not_s r0,r2
L_930302:
	ld.as r10,[r14,0x4e]
L_930306:
	extb_s r0,r0
L_930308:
	and r10,r10,r0
L_93030c:
	st.as r10,[r14,0x4e]
	.global L_930310
L_930310:
	ld.as r9,[r14,0x4d]
L_930314:
	or r9,r9,r2
L_930318:
	b.d L_93032c
L_93031c:
	st.as r9,[r14,0x4d]
	.global L_930320
L_930320:
	ld.as r6,[r14,0x4e]
L_930324:
	or r6,r6,r2
L_930328:
	st.as r6,[r14,0x4e]
	.global L_93032c
L_93032c:
	ld r4,[0x8009e8]
L_930334:
	add r13,r14,0x200
L_93033c:
	brne r4,0x0,L_9303cc
L_930340:
	mov_s r1,sp
L_930342:
	mov_s r15,0x0
L_930344:
	mov r0,r15
L_930348:
	bl.d L_93257c
L_93034c:
	mov r2,0x1
L_930350:
	ld r5,[r13, -0xd4]
L_930354:
	ld r2,[r13, -0xd0]
L_930358:
	ld r4,[sp, 0x4]
L_93035c:
	ld r6,[sp]
L_930360:
	cmp_s r2,r4
L_930362:
	cmp.eq r5,r6
L_930366:
	mov_s r0,0x1
L_930368:
	sub.ls r0,r0,r0
L_93036c:
	mov r7,0x857000
L_930374:
	ld r1,[r7, 0x58]
L_930378:
	asl r3,r0,0x1b
L_93037c:
	bclr_s r1,r1,0x1b
L_93037e:
	or_s r1,r1,r3
L_930380:
	st r1,[r7, 0x58]
L_930384:
	ld_s r2,[r14,0x20]
L_930386:
	cmp_s r2,0x0
L_930388:
	cmp.ne r0,0x1
L_93038c:
	bne_s L_930398
L_93038e:
	mov_s r3,0x1
L_930390:
	b.d L_9303b0
L_930394:
	stb r3,[r13, -0xcc]
	.global L_930398
L_930398:
	ldb r1,[r13, -0xc8]
L_93039c:
	ldb r2,[r13, -0xcc]
L_9303a0:
	ldb r3,[r13, -0xcb]
L_9303a4:
	or_s r2,r2,r1
L_9303a6:
	stb r2,[r13, -0xcc]
L_9303aa:
	ldb r2,[r13, -0xc7]
L_9303ae:
	or_s r3,r3,r2
	.global L_9303b0
L_9303b0:
	stb r3,[r13, -0xcb]
L_9303b4:
	stb r15,[r13, -0xc8]
L_9303b8:
	stb r15,[r13, -0xc7]
L_9303bc:
	add_s sp,sp,0x8
L_9303be:
	ld blink,[sp, 0x4]
L_9303c2:
	ld_s r14,[sp,0x8]
L_9303c4:
	ld_s r15,[sp,0xc]
L_9303c6:
	j_s.d [blink]
L_9303c8:
	ld.ab r13,[sp,0x10]
	.global L_9303cc
L_9303cc:
	ldb r3,[r13, -0xd7]
L_9303d0:
	ldb r4,[0x801034]
L_9303d8:
	ldb r7,[r13, -0xcc]
L_9303dc:
	and r4,r4,r3
L_9303e0:
	or r7,r7,r4
L_9303e4:
	ldb r8,[r13, -0xcb]
L_9303e8:
	stb r7,[r13, -0xcc]
L_9303ec:
	or r8,r8,r4
L_9303f0:
	stb r8,[r13, -0xcb]
L_9303f4:
	ldb r9,[r13, -0xc8]
L_9303f8:
	not r6,r4
L_9303fc:
	and r9,r9,r6
L_930400:
	ldb r5,[r13, -0xc7]
L_930404:
	stb r9,[r13, -0xc8]
L_930408:
	and r5,r5,r6
L_93040c:
	stb r5,[r13, -0xc7]
L_930410:
	add_s sp,sp,0x8
L_930412:
	ld blink,[sp, 0x4]
L_930416:
	ld_s r14,[sp,0x8]
L_930418:
	ld_s r15,[sp,0xc]
L_93041a:
	j_s.d [blink]
L_93041c:
	ld.ab r13,[sp,0x10]
