/* itx__rr_pick_pending_a @ 0x927ec0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global itx__rr_pick_pending_a
itx__rr_pick_pending_a:
	.global L_927ec0
L_927ec0:
	push_s r13
L_927ec2:
	ld.as r13,[gp,-0x16]
L_927ec6:
	extb.f 0x0,r13
L_927eca:
	mov_s r3,0x0
L_927ecc:
	beq_s L_927ef8
L_927ece:
	mov_s r1,0xff
	.global L_927ed0
L_927ed0:
	ldb r2,[gp, -0xe7]
L_927ed4:
	cmp_s r2,0x0
L_927ed6:
	cmp.ne r1,0x0
L_927eda:
	bne_s L_927ee2
L_927edc:
	mov_s r2,0x8
L_927ede:
	stb r2,[gp, -0xe7]
	.global L_927ee2
L_927ee2:
	bmsk r1,r13,r2
L_927ee6:
	bclr r1,r1,r2
L_927eea:
	mov_s r3,0x1
L_927eec:
	breq_s r1,0,L_927ed0
L_927eee:
	norm r1,r1
L_927ef2:
	rsub r2,r1,0x1e
L_927ef6:
	st_s r2,[r0]
	.global L_927ef8
L_927ef8:
	mov_s r0,r3
L_927efa:
	j_s.d [blink]
L_927efc:
	pop_s r13
L_927efe:
	nop_s
