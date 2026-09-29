/* u_schd__pop_ready @ 0x8cc534, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__run
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, llist__pop_front
 * Глобалы (через gp): 0x80019c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__pop_ready
u_schd__pop_ready:
	.global L_8cc534
L_8cc534:
	push_s blink
L_8cc536:
	bl L_8c01dc
L_8cc53a:
	lr r16,[0xa]
L_8cc53e:
	bclr r0,r16,0x1
L_8cc542:
	flag r0
L_8cc546:
	ld_s r0,[gp,0x18]
L_8cc548:
	cmp_s r0,0x0
L_8cc54a:
	mov.eq r1,0x0
L_8cc54e:
	beq_s L_8cc596
L_8cc550:
	ld_s r0,[gp,0x18]
L_8cc552:
	norm r0,r0
L_8cc556:
	rsub r14,r0,0x1e
L_8cc55a:
	brhs r14,0x3,L_8cc59c
	.global L_8cc55e
L_8cc55e:
	asl_s r13,r14,0x2
L_8cc560:
	add1_s r13,r13,r13
L_8cc562:
	mov_s r15,0x803c5c
L_8cc568:
	bl.d L_8e2674
L_8cc56c:
	add_s r0,r15,r13
L_8cc56e:
	mov_s r1,r0
L_8cc570:
	ld_s r0,[r15,r13]
L_8cc572:
	cmp_s r0,0x0
L_8cc574:
	mov_s r0,0x1
L_8cc576:
	sub_s.ne r0,r0,r0
L_8cc578:
	extb.f 0x0,r0
L_8cc57c:
	beq_s L_8cc588
L_8cc57e:
	ld_s r0,[gp,0x18]
L_8cc580:
	bclr r0,r0,r14
L_8cc584:
	st.as r0,[gp,0x6]
	.global L_8cc588
L_8cc588:
	lr r2,[0xa]
L_8cc58c:
	and r0,r16,0x2
L_8cc590:
	or_s r0,r0,r2
L_8cc592:
	flag r0
	.global L_8cc596
L_8cc596:
	b.d L_8c0244
L_8cc59a:
	mov_s r0,r1
	.global L_8cc59c
L_8cc59c:
	mov_s r0,blink
L_8cc59e:
	mov_s r1,0x64
L_8cc5a0:
	bl.d L_8c9b28
L_8cc5a4:
	bset_s r1,r1,0xc
L_8cc5a6:
	b_s L_8cc55e
