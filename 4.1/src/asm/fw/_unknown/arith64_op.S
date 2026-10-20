/* arith64_op @ 0x8c0568, 376 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__report, power_halt_seq
 */
	.section .text.arith64_op,"ax",@progbits
	.global arith64_op
arith64_op:
	.global L_8c0568
L_8c0568:
	b.d L_8c059a
L_8c056c:
	mov r4,0x0
L_8c0570:
	xor r4,r1,r3
L_8c0574:
	asl.f 0x0,r1
L_8c0578:
	mov r5,0x0
L_8c057c:
	bcc.d L_8c058c
L_8c0580:
	rrc r4,r4
L_8c0584:
	rsub.f r0,r0,r5
L_8c0588:
	sbc r1,r5,r1
	.global L_8c058c
L_8c058c:
	cmp_s r3,0x0
L_8c058e:
	bpl L_8c059a
L_8c0592:
	rsub.f r2,r2,r5
L_8c0596:
	sbc r3,r5,r3
	.global L_8c059a
L_8c059a:
	or.f r5,r3,r2
L_8c059e:
	beq L_8c06cc
L_8c05a2:
	mov_s r11,r3
L_8c05a4:
	mov_s r12,r2
L_8c05a6:
	mov_s r2,r0
L_8c05a8:
	mov_s r3,r1
L_8c05aa:
	mov.f r5,r11
L_8c05ae:
	mov r10,0x0
L_8c05b2:
	bmi L_8c05ca
L_8c05b6:
	add.eq r10,r10,0x20
L_8c05ba:
	mov.eq.f r5,r12
L_8c05be:
	norm r7,r5
L_8c05c2:
	add.pl r10,r10,0x1
L_8c05c6:
	add.pl r10,r10,r7
	.global L_8c05ca
L_8c05ca:
	mov r7,0x0
L_8c05ce:
	mov.f r5,r3
L_8c05d2:
	add.eq r7,r7,0x20
L_8c05d6:
	bmi L_8c05ea
L_8c05da:
	mov.eq.f r5,r2
L_8c05de:
	norm r0,r5
L_8c05e2:
	add.pl r7,r7,0x1
L_8c05e6:
	add.pl r7,r7,r0
	.global L_8c05ea
L_8c05ea:
	rsub.f r7,r7,r10
L_8c05ee:
	mov.mi r7,0x0
L_8c05f2:
	add r7,r7,0x1
L_8c05f6:
	mov r5,r7
L_8c05fa:
	cmp r7,0x20
L_8c05fe:
	mov_s r1,0x0
L_8c0600:
	bmi.d L_8c0610
L_8c0604:
	mov_s r0,0x0
L_8c0606:
	mov_s r1,r2
L_8c0608:
	mov_s r2,r3
L_8c060a:
	mov_s r3,0x0
L_8c060c:
	sub.f r7,r7,0x20
	.global L_8c0610
L_8c0610:
	mov lp_count,r5
L_8c0614:
	beq L_8c063c
L_8c0618:
	rsub.f r10,r7,0x20
L_8c061c:
	beq L_8c069a
L_8c0620:
	asl r0,r1,r10
L_8c0624:
	lsr r1,r1,r7
L_8c0628:
	asl r5,r2,r10
L_8c062c:
	add_s r1,r1,r5
L_8c062e:
	lsr r2,r2,r7
L_8c0632:
	asl r5,r3,r10
L_8c0636:
	lsr r3,r3,r7
L_8c063a:
	add_s r2,r2,r5
	.global L_8c063c
L_8c063c:
	cmp r10,0x20
L_8c0640:
	bgt L_8c06aa
L_8c0644:
	lp L_8c0670
L_8c0648:
	add.f r0,r0,r0
L_8c064c:
	adc.f r1,r1,r1
L_8c0650:
	adc.f r2,r2,r2
L_8c0654:
	adc r3,r3,r3
L_8c0658:
	sub.f r2,r2,r12
L_8c065c:
	sbc.f r3,r3,r11
L_8c0660:
	bcc L_8c066c
L_8c0664:
	add.f r2,r2,r12
L_8c0668:
	adc.f r3,r3,r11
	.global L_8c066c
L_8c066c:
	add.cc r0,r0,0x1
	.global L_8c0670
L_8c0670:
	sub.f 0x0,r4,0x0
L_8c0674:
	mov r5,0x0
L_8c0678:
	beq L_8c0698
L_8c067c:
	bge L_8c0688
L_8c0680:
	rsub.f r2,r2,r5
L_8c0684:
	sbc r3,r5,r3
	.global L_8c0688
L_8c0688:
	asl.f r4,r4
L_8c068c:
	bpl L_8c0698
L_8c0690:
	rsub.f r0,r0,r5
L_8c0694:
	sbc r1,r5,r1
	.global L_8c0698
L_8c0698:
	j_s [blink]
	.global L_8c069a
L_8c069a:
	mov_s r0,r1
L_8c069c:
	mov_s r1,r2
L_8c069e:
	mov_s r2,r3
L_8c06a0:
	mov_s r3,0x0
L_8c06a2:
	/* j 0x0000063c */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x3c,0x06
	.global L_8c06aa
L_8c06aa:
	lp L_8c06c4
L_8c06ae:
	add.f r0,r0,r0
L_8c06b2:
	adc.f r1,r1,r1
L_8c06b6:
	adc.f r2,r2,r2
L_8c06ba:
	cmp_s r2,r12
L_8c06bc:
	sub.cc r2,r2,r12
L_8c06c0:
	or.cc r0,r0,0x1
	.global L_8c06c4
L_8c06c4:
	/* j 0x00000670 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x70,0x06
	.global L_8c06cc
L_8c06cc:
	mov_s r2,0x0
L_8c06ce:
	sub_s r0,r2,0x1
L_8c06d0:
	mov_s r3,0x0
L_8c06d2:
	lsr r1,r0
L_8c06d6:
	/* j 0x00000698 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x98,0x06
L_8c06de:
	nop_s
