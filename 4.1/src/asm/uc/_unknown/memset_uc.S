/* memset_uc @ 0x92a264, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: memset0_words_uc
 */
	.section .text.memset_uc,"ax",@progbits
	.global memset_uc
memset_uc:
	.global L_92a264
L_92a264:
	push_s r13
L_92a266:
	extb_s r1,r1
L_92a268:
	asl r3,r1,0x8
L_92a26c:
	or_s r3,r3,r1
L_92a26e:
	asl r1,r3,0x10
L_92a272:
	or_s r1,r1,r3
L_92a274:
	brlo.d r2,0x8,L_92a298
L_92a278:
	mov_s r3,r0
L_92a27a:
	b_s L_92a282
	.global L_92a27c
L_92a27c:
	stb.ab r1,[r3,0x1]
L_92a280:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
	.global L_92a282
L_92a282:
	bmsk.f 0x0,r3,0x1
L_92a286:
	bne_s L_92a27c
L_92a288:
	lsr r13,r2,0x2
L_92a28c:
	bmsk_s r2,r2,0x1
	.global L_92a28e
L_92a28e:
	sub.f r13,r13,0x1
L_92a292:
	st.ab r1,[r3,0x4]
L_92a296:
	bne_s L_92a28e
	.global L_92a298
L_92a298:
	cmp_s r2,0x0
L_92a29a:
	mov.ne lp_count,r2
L_92a29e:
	nop_s
L_92a2a0:
	lpne L_92a2aa
L_92a2a4:
	stb.ab r1,[r3,0x1]
L_92a2a8:
	nop_s
	.global L_92a2aa
L_92a2aa:
	j_s.d [blink]
L_92a2ac:
	pop_s r13
L_92a2ae:
	nop_s
