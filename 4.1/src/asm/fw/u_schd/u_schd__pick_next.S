/* u_schd__pick_next @ 0x8ca30c, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   u_schd.cpp
 * Зовут его: u_schd__large_task_warn
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, llist__pop_front
 * Глобалы (через gp): 0x800190
 */
	.section .text.u_schd__pick_next,"ax",@progbits
	.global u_schd__pick_next
u_schd__pick_next:
	.global L_8ca30c
L_8ca30c:
	push_s blink
L_8ca30e:
	bl L_8c02bc
L_8ca312:
	lr r16,[0xa]
L_8ca316:
	bclr r0,r16,0x1
L_8ca31a:
	flag r0
L_8ca31e:
	ld_s r0,[gp,0x20]
L_8ca320:
	cmp_s r0,0x0
L_8ca322:
	mov.eq r1,0x0
L_8ca326:
	beq_s L_8ca36e
L_8ca328:
	ld_s r0,[gp,0x20]
L_8ca32a:
	norm r0,r0
L_8ca32e:
	rsub r14,r0,0x1e
L_8ca332:
	brhs r14,0x3,L_8ca374
	.global L_8ca336
L_8ca336:
	asl_s r13,r14,0x2
L_8ca338:
	add1_s r13,r13,r13
L_8ca33a:
	mov_s r15,0x8034b0
L_8ca340:
	bl.d L_8de2d4
L_8ca344:
	add_s r0,r15,r13
L_8ca346:
	mov_s r1,r0
L_8ca348:
	ld_s r0,[r15,r13]
L_8ca34a:
	cmp_s r0,0x0
L_8ca34c:
	mov_s r0,0x1
L_8ca34e:
	sub_s.ne r0,r0,r0
L_8ca350:
	extb.f 0x0,r0
L_8ca354:
	beq_s L_8ca360
L_8ca356:
	ld_s r0,[gp,0x20]
L_8ca358:
	bclr r0,r0,r14
L_8ca35c:
	st.as r0,[gp,0x8]
	.global L_8ca360
L_8ca360:
	lr r2,[0xa]
L_8ca364:
	and r0,r16,0x2
L_8ca368:
	or_s r0,r0,r2
L_8ca36a:
	flag r0
	.global L_8ca36e
L_8ca36e:
	b.d L_8c0324
L_8ca372:
	mov_s r0,r1
	.global L_8ca374
L_8ca374:
	mov_s r0,blink
L_8ca376:
	mov_s r2,0x1001708
L_8ca37c:
	mov_s r1,0x64
L_8ca37e:
	bset_s r1,r1,0xc
L_8ca380:
	bl.d L_8c82c0
L_8ca384:
	mov_s r3,0x76
L_8ca386:
	b_s L_8ca336
