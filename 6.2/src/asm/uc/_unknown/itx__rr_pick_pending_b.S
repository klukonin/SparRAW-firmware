/* itx__rr_pick_pending_b @ 0x927f00, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm2
 * Глобалы (через gp): 0x800570
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global itx__rr_pick_pending_b
itx__rr_pick_pending_b:
	.global L_927f00
L_927f00:
	push_s r13
L_927f02:
	ld.as r13,[gp,0x12]
L_927f06:
	extb.f 0x0,r13
L_927f0a:
	mov_s r3,0x0
L_927f0c:
	beq_s L_927f38
L_927f0e:
	mov_s r1,0xff
	.global L_927f10
L_927f10:
	ldb r2,[gp, -0xe6]
L_927f14:
	cmp_s r2,0x0
L_927f16:
	cmp.ne r1,0x0
L_927f1a:
	bne_s L_927f22
L_927f1c:
	mov_s r2,0x8
L_927f1e:
	stb r2,[gp, -0xe6]
	.global L_927f22
L_927f22:
	bmsk r1,r13,r2
L_927f26:
	bclr r1,r1,r2
L_927f2a:
	mov_s r3,0x1
L_927f2c:
	breq_s r1,0,L_927f10
L_927f2e:
	norm r1,r1
L_927f32:
	rsub r2,r1,0x1e
L_927f36:
	st_s r2,[r0]
	.global L_927f38
L_927f38:
	mov_s r0,r3
L_927f3a:
	j_s.d [blink]
L_927f3c:
	pop_s r13
L_927f3e:
	nop_s
