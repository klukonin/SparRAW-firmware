/* get_tx_eligibility__precheck @ 0x9264f0, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mtp_queue__release_mgmt, tx_initiator_flow
 * Зовёт сам: get_tx_eligibility
 */
	.section .text.get_tx_eligibility__precheck,"ax",@progbits
	.global get_tx_eligibility__precheck
get_tx_eligibility__precheck:
	.global L_9264f0
L_9264f0:
	mov_s r8,r1
L_9264f2:
	ld.as r4,[gp,-0x22]
L_9264f6:
	ldb r1,[0x801034]
L_9264fe:
	cmp r4,0x0
L_926502:
	mov_s r6,r0
L_926504:
	jne.d [blink]
L_926508:
	mov_s r0,0x1
L_92650a:
	ld r5,[0x8009e8]
L_926512:
	cmp r5,0x0
L_926516:
	jeq_s [blink]
L_926518:
	ld.as r3,[gp,-0x31]
L_92651c:
	brne r3,r8,L_926534
L_926520:
	ldb r2,[r6,0x135]
L_926528:
	mov_s r0,0x1
L_92652a:
	and_s r2,r2,r1
L_92652c:
	cmp_s r1,r2
L_92652e:
	j_s.d [blink]
L_926530:
	sub.ne r0,r0,r0
	.global L_926534
L_926534:
	cmp r8,0x1f
L_926538:
	beq.d L_92618c
L_92653c:
	mov.eq r0,r6
L_926540:
	ld.as r6,[r6,0x4d]
L_926544:
	asl r7,0x1,r2
L_92654c:
	tst r6,r7
L_926550:
	jne_s [blink]
L_926552:
	tst r7,r1
L_926556:
	jeq_s [blink]
L_926558:
	j.d [blink]
L_92655c:
	mov_s r0,0x0
L_92655e:
	nop_s
