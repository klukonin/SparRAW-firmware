/* uc_divmod_signed @ 0x9203e8, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dti_worker__scheduled_dti_allocation_event, uc_divmod_unsigned
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_divmod_signed
uc_divmod_signed:
	.global L_9203e8
L_9203e8:
	lsr.f r8,r1,0x1f
L_9203ec:
	rsub.ne r1,r1,0x0
L_9203f0:
	asr.f r3,r0,0x1f
L_9203f4:
	rsub.ne r0,r0,0x0
L_9203f8:
	xor r8,r8,r3
	.global L_9203fc
L_9203fc:
	mov.f r2,r1
L_920400:
	beq.d L_920450
L_920404:
	mov_s r1,r0
L_920406:
	mov_s r0,0x0
L_920408:
	sub_s r3,r0,0x1
L_92040a:
	norm.f r5,r1
L_92040e:
	mov.mi r5,r3
L_920412:
	norm.f r6,r2
L_920416:
	mov.mi r6,r3
L_92041a:
	sub.f r3,r6,r5
L_92041e:
	mov.mi r3,0x0
L_920422:
	add lp_count,r3,0x1
L_920426:
	asl.pl r2,r2,r3
L_92042a:
	lp L_92043e
L_92042e:
	sub.f r1,r1,r2
L_920432:
	bset.cc r0,r0,lp_count
L_920436:
	add.cs r1,r1,r2
L_92043a:
	lsr r2,r2
	.global L_92043e
L_92043e:
	lsr.f r8,r8
L_920442:
	ror r0,r0
L_920446:
	rsub.cs r0,r0,0x0
L_92044a:
	j_s.d [blink]
L_92044c:
	rsub.ne r1,r1,0x0
	.global L_920450
L_920450:
	/* j 0x000004a4 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0xa4,0x04
