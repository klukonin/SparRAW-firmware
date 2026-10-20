/* if_gain__apply_delta @ 0x8d27e8, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, hwf_if_gain_fin_est
 */
	.section .text.if_gain__apply_delta,"ax",@progbits
	.global if_gain__apply_delta
if_gain__apply_delta:
	.global L_8d27e8
L_8d27e8:
	push_s r13
L_8d27ea:
	ldb_s r3,[r1,0x2]
L_8d27ec:
	ldb_s r2,[r1,0x4]
L_8d27ee:
	lsr r13,r0,0x1f
L_8d27f2:
	abs_s r0,r0
L_8d27f4:
	extb_s r0,r0
L_8d27f6:
	brne_s r13,0,L_8d280c
L_8d27f8:
	brge r0,r3,L_8d2802
L_8d27fc:
	sub_s r3,r3,r0
L_8d27fe:
	extb_s r3,r3
L_8d2800:
	b_s L_8d281e
	.global L_8d2802
L_8d2802:
	sub_s r0,r0,r3
L_8d2804:
	add_s r2,r2,r0
L_8d2806:
	extb_s r2,r2
L_8d2808:
	mov_s r3,0x0
L_8d280a:
	b_s L_8d281e
	.global L_8d280c
L_8d280c:
	brge r0,r2,L_8d2816
L_8d2810:
	sub_s r2,r2,r0
L_8d2812:
	extb_s r2,r2
L_8d2814:
	b_s L_8d281e
	.global L_8d2816
L_8d2816:
	sub_s r0,r0,r2
L_8d2818:
	add_s r3,r3,r0
L_8d281a:
	extb_s r3,r3
L_8d281c:
	mov_s r2,0x0
	.global L_8d281e
L_8d281e:
	stb_s r3,[r1,0x2]
L_8d2820:
	stb_s r2,[r1,0x4]
L_8d2822:
	j_s.d [blink]
L_8d2824:
	pop_s r13
L_8d2826:
	nop_s
