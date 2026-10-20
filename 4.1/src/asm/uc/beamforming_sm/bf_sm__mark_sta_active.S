/* bf_sm__mark_sta_active @ 0x922448, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   beamforming_sm.c
 * Зовут его: bf__abort_unexpected, bf_sm__trigger
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, uc_sysassert
 */
	.section .text.bf_sm__mark_sta_active,"ax",@progbits
	.global bf_sm__mark_sta_active
bf_sm__mark_sta_active:
	.global L_922448
L_922448:
	push_s blink
L_92244a:
	bl L_920214
L_92244e:
	mov_s r3,0x800ef4
L_922454:
	ld_s r13,[r3,0x6c]
L_922456:
	asl_s r14,r0,0x2
L_922458:
	cmp_s r13,0x0
L_92245a:
	mov_s r13,0x1
L_92245c:
	ld_s r2,[r3,0x6c]
L_92245e:
	sub_s.ne r13,r13,r13
L_922460:
	bset r2,r2,r0
L_922464:
	add1_s r14,r14,r14
L_922466:
	st_s r2,[r3,0x6c]
L_922468:
	add_s r14,r14,r3
L_92246a:
	st_s r1,[r14]
L_92246c:
	mov_s r2,0x0
L_92246e:
	st_s r2,[r14,0x4]
L_922470:
	stb_s r2,[r14,0xb]
L_922472:
	ld_s r1,[r3,0x7c]
L_922474:
	bmsk r14,r1,0x2
L_922478:
	add r2,r14,0x800f64
L_922480:
	stb_s r0,[r2]
L_922482:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_922484:
	st_s r1,[r3,0x7c]
L_922486:
	ld_s r0,[r3,0x7c]
L_922488:
	ld_s r1,[r3,0x78]
L_92248a:
	sub_s r0,r0,r1
L_92248c:
	brhs r0,0x9,L_922496
	.global L_922490
L_922490:
	b.d L_920284
L_922494:
	mov_s r0,r13
	.global L_922496
L_922496:
	mov_s r0,blink
L_922498:
	mov_s r2,0x1000754
L_92249e:
	mov_s r1,0x12
L_9224a0:
	bl.d L_925548
L_9224a4:
	mov_s r3,0x49
L_9224a6:
	b_s L_922490
