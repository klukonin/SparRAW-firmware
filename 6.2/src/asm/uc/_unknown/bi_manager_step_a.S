/* bi_manager_step_a @ 0x92218c, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi__run_bti_cycle
 * Зовёт сам: gp_timer__stop, memset0_words_uc, rx_nav__arm_flag_if_enabled, uc_read_bi_sync
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_manager_step_a
bi_manager_step_a:
	.global L_92218c
L_92218c:
	st.a r13,[sp,-0xc]
L_922190:
	st blink,[sp, 0x4]
L_922194:
	mov r13,0x0
L_922198:
	bl.d L_925998
L_92219c:
	mov r0,r13
L_9221a0:
	ldb r7,[0x802194]
L_9221a8:
	st_s r14,[sp,0x8]
L_9221aa:
	mov_s r14,0x802f14
L_9221b0:
	breq r7,0x0,L_922230
L_9221b4:
	ld r5,[0x8014c0]
L_9221bc:
	brne r5,0x0,L_922230
L_9221c0:
	ldb r4,[r14]
L_9221c4:
	breq r4,0x0,L_922230
L_9221c8:
	norm r11,r7
L_9221cc:
	mov r9,0x802a6c
L_9221d4:
	mov r11,0x8021e0
L_9221dc:
	ldw r10,[r11, 0x14]
L_9221e0:
	ldw r2,[r9, 0x22]
L_9221e4:
	brne.d r2,r10,L_9221f8
L_9221e8:
	st r13,[r9, 0x18]
L_9221ec:
	ldw r8,[r11, 0x12]
L_9221f0:
	ldw r1,[r9, 0x20]
L_9221f4:
	breq r1,r8,L_922200
	.global L_9221f8
L_9221f8:
	ld r0,[r9, 0x10]
L_9221fc:
	breq r0,0x0,L_922210
	.global L_922200
L_922200:
	st r13,[r9, 0x14]
L_922204:
	st r13,[r9, 0x10]
L_922208:
	b.d L_92221c
L_92220c:
	st r13,[r9, 0x1c]
	.global L_922210
L_922210:
	ld r8,[r9, 0x14]
L_922214:
	add r8,r8,0x1
L_922218:
	st r8,[r9, 0x14]
	.global L_92221c
L_92221c:
	mov r10,0x886000
L_922224:
	ld r6,[r10, 0x24]
L_922228:
	bset r6,r6,0x1f
L_92222c:
	st r6,[r10, 0x24]
	.global L_922230
L_922230:
	bl L_936b60
L_922234:
	breq_s r0,0,L_922240
L_922236:
	ldb r3,[gp, -0xdf]
L_92223a:
	cmp_s r3,0x0
L_92223c:
	bl.eq L_92dc28
	.global L_922240
L_922240:
	mov r0,r14
L_922244:
	bl.d L_920a84
L_922248:
	mov r1,0x1c
L_92224c:
	ld blink,[sp, 0x4]
L_922250:
	ld_s r14,[sp,0x8]
L_922252:
	j_s.d [blink]
L_922254:
	ld.ab r13,[sp,0xc]
