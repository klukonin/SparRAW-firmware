/* mtp_service__dispatch @ 0x92a404, 236 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mtp_service.cpp
 * Зовут его: cf_end_mtp_step, rx_flow__post_rx_act1, rx_flow__post_rx_act2, rx_flow__post_rx_act3
 * Зовёт сам: tbl_801754__byte_by_index, uc_sysassert
 * Глобалы (через gp): 0x800604
 */
	.section .text.mtp_service__dispatch,"ax",@progbits
	.global mtp_service__dispatch
mtp_service__dispatch:
	.global L_92a404
L_92a404:
	st.a r13,[sp,-0xc]
L_92a408:
	st blink,[sp, 0x4]
L_92a40c:
	st r14,[sp, 0x8]
L_92a410:
	asl r13,r0,0x8
L_92a414:
	or r13,r13,0x1f0022
L_92a41c:
	brhs.d r0,0x6,L_92a490
L_92a420:
	mov_s r14,0x0
L_92a422:
	ld.as r4,[0x800dec,r0]
L_92a42a:
	j [r4]
L_92a42e:
	b.d L_92a4a4
L_92a432:
	mov r14,0x103
L_92a436:
	asl r14,r2,0x10
L_92a43a:
	ld.as r8,[gp,0x37]
L_92a43e:
	bbit0 r8,0x1,L_92a478
L_92a442:
	asl r7,r1,0x2
L_92a446:
	add1 r7,r7,r7
L_92a44a:
	ld r5,[r7,0x8016d8]
L_92a452:
	sub.f r5,r5,0x0
L_92a456:
	mov.ne r5,0x1
L_92a45a:
	extb.f 0x0,r5
L_92a45e:
	beq_s L_92a478
L_92a460:
	bl.d L_92c1ec
L_92a464:
	mov r0,r1
L_92a468:
	asl r0,r0,0x8
L_92a46c:
	or r0,r0,0x3
L_92a470:
	b.d L_92a4a4
L_92a474:
	or r14,r14,r0
	.global L_92a478
L_92a478:
	cmp r3,0xff
L_92a47c:
	beq L_92a4a4
L_92a480:
	asl r6,r3,0x8
L_92a484:
	or r6,r6,0x3
L_92a488:
	b.d L_92a4a4
L_92a48c:
	or r14,r14,r6
	.global L_92a490
L_92a490:
	mov_s r0,blink
L_92a492:
	mov_s r2,0x10027c0
L_92a498:
	mov r1,0x8c
L_92a49c:
	bl.d L_925548
L_92a4a0:
	mov r3,0x62
	.global L_92a4a4
L_92a4a4:
	mov_s r1,0x1b001111
L_92a4aa:
	mov_s r32,r1
L_92a4ac:
	st.ab r1,[r25,0x4]
L_92a4b0:
	bclr r25,r25,0xa
L_92a4b4:
	or r13,r13,0x16000000
L_92a4bc:
	mov r32,r13
L_92a4c0:
	st.ab r13,[r25,0x4]
L_92a4c4:
	bclr r25,r25,0xa
L_92a4c8:
	or r14,r14,0x17000000
L_92a4d0:
	mov r32,r14
L_92a4d4:
	st.ab r14,[r25,0x4]
L_92a4d8:
	bclr r25,r25,0xa
L_92a4dc:
	nop_s
L_92a4de:
	nop_s
L_92a4e0:
	nop_s
L_92a4e2:
	ld blink,[sp, 0x4]
L_92a4e6:
	ld_s r14,[sp,0x8]
L_92a4e8:
	j.d [blink]
L_92a4ec:
	ld.ab r13,[sp,0xc]
