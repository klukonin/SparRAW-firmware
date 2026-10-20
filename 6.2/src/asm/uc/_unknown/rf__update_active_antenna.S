/* rf__update_active_antenna @ 0x9238cc, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sta__set_tx_sector
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, uc_divmod_unsigned
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rf__update_active_antenna
rf__update_active_antenna:
	.global L_9238cc
L_9238cc:
	push_s blink
L_9238ce:
	bl L_920230
L_9238d2:
	mov_s r15,r0
L_9238d4:
	mov_s r0,r1
L_9238d6:
	mov_s r14,0x8006b4
L_9238dc:
	ldw_s r1,[r14]
L_9238de:
	brlt r1,0x2,L_923906
L_9238e2:
	ldb_s r2,[r14,0x4]
L_9238e4:
	breq_s r2,0,L_923906
L_9238e6:
	mov_s r0,0x8014a4
L_9238ec:
	ld_s r0,[r0,0x1c]
L_9238ee:
	stb_s r2,[r14,0x3]
L_9238f0:
	breq_s r0,0,L_9238fe
L_9238f2:
	mov_s r0,0x8577a0
L_9238f8:
	ldb_s r0,[r0,0x14]
L_9238fa:
	brge r0,0x2,L_923910
	.global L_9238fe
L_9238fe:
	mov_s r0,0x1
L_923900:
	stb_s r0,[r14,0x3]
L_923902:
	stb_s r0,[r14,0x5]
L_923904:
	b_s L_923910
	.global L_923906
L_923906:
	ldb_s r13,[r14,0x2]
L_923908:
	brne r1,0x1,L_923914
	.global L_92390c
L_92390c:
	stb_s r13,[r14,0x3]
L_92390e:
	stb_s r13,[r14,0x5]
	.global L_923910
L_923910:
	b L_92029c
	.global L_923914
L_923914:
	bl L_9203e0
L_923918:
	extw_s r1,r0
L_92391a:
	bl.d L_9203e0
L_92391e:
	mov_s r0,r15
L_923920:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923922:
	extw_s r0,r0
L_923924:
	brlt.d r0,0x2,L_92393a
L_923928:
	sub_s r1,r13,0x1
L_92392a:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_92392c:
	extw lp_count,r0
L_923930:
	nop_s
L_923932:
	lp L_92393a
L_923936:
	and_s r13,r13,r1
L_923938:
	sub_s r1,r13,0x1
	.global L_92393a
L_92393a:
	bic_s r13,r13,r1
L_92393c:
	b_s L_92390c
L_92393e:
	nop_s
