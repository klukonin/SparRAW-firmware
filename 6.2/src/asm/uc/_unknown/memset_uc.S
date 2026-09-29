/* memset_uc @ 0x92d834, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: buf__fill_ff, memset0_words_uc
 * Зовёт сам: __ld_r13_to_r13_ret, buf__check_bounds, ucode_cmd_dispatch
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global memset_uc
memset_uc:
	.global L_92d834
L_92d834:
	push_s r13
L_92d836:
	extb_s r1,r1
L_92d838:
	asl r3,r1,0x8
L_92d83c:
	or_s r3,r3,r1
L_92d83e:
	asl r1,r3,0x10
L_92d842:
	or_s r1,r1,r3
L_92d844:
	brlo.d r2,0x8,L_92d868
L_92d848:
	mov_s r3,r0
L_92d84a:
	b_s L_92d852
	.global L_92d84c
L_92d84c:
	stb.ab r1,[r3,0x1]
L_92d850:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
	.global L_92d852
L_92d852:
	bmsk.f 0x0,r3,0x1
L_92d856:
	bne_s L_92d84c
L_92d858:
	lsr r13,r2,0x2
L_92d85c:
	bmsk_s r2,r2,0x1
	.global L_92d85e
L_92d85e:
	sub.f r13,r13,0x1
L_92d862:
	st.ab r1,[r3,0x4]
L_92d866:
	bne_s L_92d85e
	.global L_92d868
L_92d868:
	cmp_s r2,0x0
L_92d86a:
	mov.ne lp_count,r2
L_92d86e:
	nop_s
L_92d870:
	lpne L_92d87a
L_92d874:
	stb.ab r1,[r3,0x1]
L_92d878:
	nop_s
	.global L_92d87a
L_92d87a:
	j_s.d [blink]
L_92d87c:
	pop_s r13
L_92d87e:
	nop_s
L_92d880:
	push_s blink
L_92d882:
	push_s r13
L_92d884:
	mov_s r13,r0
L_92d886:
	add r2,r1,0x10
L_92d88a:
	mov_s r0,r1
L_92d88c:
	bl.d L_93c928
L_92d890:
	mov_s r1,r2
L_92d892:
	add r0,r13,0x24
L_92d896:
	mov_s r2,0x0
L_92d898:
	ld_s r1,[r0]
L_92d89a:
	bl.d L_92ac80
L_92d89e:
	st_s r2,[r1]
L_92d8a0:
	b L_9202ac
