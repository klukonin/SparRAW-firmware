/* tx__take_eligibility_slot @ 0x926354, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: get_tx_eligibility, internal_tx_step
 * Глобалы (через gp): 0x800574
 */
	.section .text.tx__take_eligibility_slot,"ax",@progbits
	.global tx__take_eligibility_slot
tx__take_eligibility_slot:
	.global L_926354
L_926354:
	push_s r13
L_926356:
	ld.as r13,[gp,0x13]
L_92635a:
	extb.f 0x0,r13
L_92635e:
	mov_s r3,0x0
L_926360:
	beq_s L_92638c
L_926362:
	mov_s r1,0xff
	.global L_926364
L_926364:
	ldb r2,[gp, -0xea]
L_926368:
	cmp_s r2,0x0
L_92636a:
	cmp.ne r1,0x0
L_92636e:
	bne_s L_926376
L_926370:
	mov_s r2,0x8
L_926372:
	stb r2,[gp, -0xea]
	.global L_926376
L_926376:
	bmsk r1,r13,r2
L_92637a:
	bclr r1,r1,r2
L_92637e:
	mov_s r3,0x1
L_926380:
	breq_s r1,0,L_926364
L_926382:
	norm r1,r1
L_926386:
	rsub r2,r1,0x1e
L_92638a:
	st_s r2,[r0]
	.global L_92638c
L_92638c:
	mov_s r0,r3
L_92638e:
	j_s.d [blink]
L_926390:
	pop_s r13
L_926392:
	nop_s
