/* if_gain__apply_delta @ 0x8d561c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, if_gain
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global if_gain__apply_delta
if_gain__apply_delta:
	.global L_8d561c
L_8d561c:
	push_s r13
L_8d561e:
	ldb_s r3,[r1,0x2]
L_8d5620:
	ldb_s r2,[r1,0x4]
L_8d5622:
	lsr r13,r0,0x1f
L_8d5626:
	abs_s r0,r0
L_8d5628:
	extb_s r0,r0
L_8d562a:
	brne_s r13,0,L_8d5640
L_8d562c:
	brge r0,r3,L_8d5636
L_8d5630:
	sub_s r3,r3,r0
L_8d5632:
	extb_s r3,r3
L_8d5634:
	b_s L_8d5652
	.global L_8d5636
L_8d5636:
	sub_s r0,r0,r3
L_8d5638:
	add_s r2,r2,r0
L_8d563a:
	extb_s r2,r2
L_8d563c:
	mov_s r3,0x0
L_8d563e:
	b_s L_8d5652
	.global L_8d5640
L_8d5640:
	brge r0,r2,L_8d564a
L_8d5644:
	sub_s r2,r2,r0
L_8d5646:
	extb_s r2,r2
L_8d5648:
	b_s L_8d5652
	.global L_8d564a
L_8d564a:
	sub_s r0,r0,r2
L_8d564c:
	add_s r3,r3,r0
L_8d564e:
	extb_s r3,r3
L_8d5650:
	mov_s r2,0x0
	.global L_8d5652
L_8d5652:
	stb_s r3,[r1,0x2]
L_8d5654:
	stb_s r2,[r1,0x4]
L_8d5656:
	j_s.d [blink]
L_8d5658:
	pop_s r13
L_8d565a:
	nop_s
