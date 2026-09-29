/* ps_cfg__profile_matches @ 0x8da4a8, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CFG_SCHEME__switch_active_ps_profile
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_cfg__profile_matches
ps_cfg__profile_matches:
	.global L_8da4a8
L_8da4a8:
	push_s r13
L_8da4aa:
	mov_s r2,0x0
L_8da4ac:
	mov_s r13,0x803d5c
L_8da4b2:
	add_s r3,r13,0x4
L_8da4b4:
	b_s L_8da4b8
	.global L_8da4b6
L_8da4b6:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_8da4b8
L_8da4b8:
	brge r2,0x1,L_8da4c8
L_8da4bc:
	asl_s r1,r2,0x2
L_8da4be:
	add3_s r1,r1,r1
L_8da4c0:
	ld_s r1,[r3,r1]
L_8da4c2:
	breq r0,r1,L_8da4b6
L_8da4c6:
	b_s L_8da4ce
	.global L_8da4c8
L_8da4c8:
	ld_s r1,[r13,0x24]
L_8da4ca:
	breq r0,r1,L_8da4d2
	.global L_8da4ce
L_8da4ce:
	mov_s r0,0x0
L_8da4d0:
	b_s L_8da4d4
	.global L_8da4d2
L_8da4d2:
	mov_s r0,0x1
	.global L_8da4d4
L_8da4d4:
	j_s.d [blink]
L_8da4d6:
	pop_s r13
L_8da4d8:
	ldb_s r0,[r0]
L_8da4da:
	cmp_s r0,0x2
L_8da4dc:
	mov_s r0,0x1
L_8da4de:
	j_s.d [blink]
L_8da4e0:
	sub_s.ne r0,r0,r0
L_8da4e2:
	nop_s
L_8da4e4:
	add_s r0,r0,0xc
L_8da4e6:
	ld_s r1,[r0,0x8]
L_8da4e8:
	ld_s r1,[r1,0xc]
L_8da4ea:
	j_s [r1]
L_8da4ec:
	ldb_s r0,[r0]
L_8da4ee:
	cmp_s r0,0x1
L_8da4f0:
	mov_s r0,0x1
L_8da4f2:
	j_s.d [blink]
L_8da4f4:
	sub_s.ne r0,r0,r0
L_8da4f6:
	nop_s
L_8da4f8:
	add_s r0,r0,0xc
L_8da4fa:
	ld_s r1,[r0,0x8]
L_8da4fc:
	ld_s r1,[r1,0xc]
L_8da4fe:
	j_s [r1]
L_8da500:
	ldb_s r0,[r0]
L_8da502:
	cmp_s r0,0x3
L_8da504:
	mov_s r0,0x1
L_8da506:
	j_s.d [blink]
L_8da508:
	sub_s.ne r0,r0,r0
L_8da50a:
	nop_s
L_8da50c:
	add_s r0,r0,0xc
L_8da50e:
	ld_s r1,[r0,0x8]
L_8da510:
	ld_s r1,[r1,0x10]
L_8da512:
	j_s [r1]
L_8da514:
	ldb_s r0,[r0]
L_8da516:
	cmp_s r0,0x2
L_8da518:
	mov_s r0,0x1
L_8da51a:
	j_s.d [blink]
L_8da51c:
	sub_s.ne r0,r0,r0
L_8da51e:
	nop_s
L_8da520:
	add_s r0,r0,0xc
L_8da522:
	ld_s r1,[r0,0x8]
L_8da524:
	ld_s r1,[r1,0x10]
L_8da526:
	j_s [r1]
