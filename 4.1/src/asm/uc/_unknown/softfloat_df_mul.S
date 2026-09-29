/* softfloat_df_mul @ 0x9204ac, 1204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_build_schedule_tables
 */
	.section .text.softfloat_df_mul,"ax",@progbits
	.global softfloat_df_mul
softfloat_df_mul:
	.global L_9204ac
L_9204ac:
	mov_s r12,0xffe00000
L_9204b2:
	add1 r4,r12,r1
L_9204b6:
	add1 r5,r12,r3
L_9204ba:
	bclr_s r12,r12,0x16
L_9204bc:
	cmp r4,r12
L_9204c0:
	cmp.cs r5,r12
L_9204c4:
	bcc.d L_92057a
L_9204c8:
	bset_s r12,r12,0x16
L_9204ca:
	lsr r4,r4,0x15
L_9204ce:
	lsr r5,r5,0x15
L_9204d2:
	add r5,r5,r4
L_9204d6:
	sub r5,r5,0x3fe
L_9204da:
	cmp r5,0x7fb
L_9204de:
	bcc.d L_9205c4
L_9204e2:
	xor.f r12,r1,r3
L_9204e6:
	add r7,r5,0x1
L_9204ea:
	bset_s r1,r1,0x14
L_9204ec:
	bmsk_s r1,r1,0x14
L_9204ee:
	bset_s r3,r3,0x14
L_9204f0:
	bset.mi r7,r7,0xb
L_9204f4:
	asl r3,r3,0xb
L_9204f8:
	lsr r5,r2,0x15
L_9204fc:
	asl.f r2,r2,0xb
L_920500:
	mulu64 r0,r2
L_920504:
	or r3,r3,r5
L_920508:
	mov_s r12,mhi
L_92050a:
	cmp mlo,0x0
L_92050e:
	mulu64 r0,r3
L_920512:
	bset.ne r7,r7,0x1f
L_920516:
	add.f r12,r12,mlo
L_92051a:
	adc r0,mhi,0x0
L_92051e:
	mulu64 r1,r2
L_920522:
	add.f r12,r12,mlo
L_920526:
	adc.f r0,r0,mhi
L_92052a:
	mulu64 r1,r3
L_92052e:
	adc r1,0x0,0x0
L_920536:
	add.f r0,r0,mlo
L_92053a:
	adc r1,r1,mhi
L_92053e:
	bbit1.d r1,0x14,L_920556
L_920542:
	add.f r12,r12,r12
L_920546:
	sub r7,r7,0x1
L_92054a:
	adc.f r0,r0,r0
L_92054e:
	adc r1,r1,r1
L_920552:
	add.f r12,r12,r12
	.global L_920556
L_920556:
	asl r4,r7,0x14
L_92055a:
	jcc.d [blink]
L_92055e:
	add_s r1,r1,r4
L_920560:
	asl r5,r1,0x1f
L_920564:
	or.f r5,r5,r7
L_920568:
	bset.ne r5,r5,0x1f
L_92056c:
	lsr r5,r5,0x1f
L_920570:
	add.f r0,r0,r5
L_920574:
	j_s.d [blink]
L_920576:
	adc r1,r1,0x0
	.global L_92057a
L_92057a:
	sub.f r4,r4,r12
L_92057e:
	cmp.eq r0,0x0
L_920582:
	jeq.d [blink]
L_920586:
	mov.eq r1,0x0
L_92058a:
	sub.f r5,r5,r12
L_92058e:
	cmp.eq r2,0x0
L_920592:
	mov.eq r0,0x0
L_920596:
	jeq.d [blink]
L_92059a:
	mov.eq r1,0x0
L_92059e:
	cmp r4,r12
L_9205a2:
	cmp.cs r5,r12
L_9205a6:
	bcs.d L_9205c4
L_9205aa:
	cmp r4,r5
L_9205ae:
	cmp.eq r0,r2
L_9205b2:
	mov.cs r0,r2
L_9205b6:
	mov.cs r1,r3
L_9205ba:
	xor.f r3,r3,r1
L_9205be:
	j_s.d [blink]
L_9205c0:
	bset.mi r1,r1,0x1f
	.global L_9205c4
L_9205c4:
	asl.f r5,r3
L_9205c8:
	adc r4,0x0,0x0
L_9205d0:
	cmp.eq r2,0x0
L_9205d4:
	beq.d L_920944
L_9205d8:
	asl.f r9,r1
L_9205dc:
	xor.cs r4,r4,0x1
L_9205e0:
	cmp.eq r0,0x0
L_9205e4:
	beq L_92091e
L_9205e8:
	lsr.f r6,r9,0x15
L_9205ec:
	bic r1,r1,0xfff00000
L_9205f4:
	or.ne r1,r1,0x100000
L_9205fc:
	bne.d L_920658
L_920600:
	mov_s r0,r0
L_920602:
	cmp_s r1,0x0
L_920604:
	beq L_920610
L_920608:
	b.d L_920622
L_92060c:
	norm r10,r1
	.global L_920610
L_920610:
	cmp_s r0,0x0
L_920612:
	mov r10,0x1f
L_920616:
	bmi L_920622
L_92061a:
	norm r10,r0
L_92061e:
	add r10,r10,0x20
	.global L_920622
L_920622:
	sub r10,r10,0xa
L_920626:
	sub r6,r6,r10
L_92062a:
	add r6,r6,0x1
L_92062e:
	sub.f r11,0x20,r10
L_920636:
	lsr r11,r0,r11
L_92063a:
	bgt L_92064c
L_92063e:
	sub r11,r10,0x20
L_920642:
	asl r1,r0,r11
L_920646:
	b.d L_920658
L_92064a:
	mov_s r0,0x0
	.global L_92064c
L_92064c:
	asl r0,r0,r10
L_920650:
	asl r10,r1,r10
L_920654:
	or r1,r11,r10
	.global L_920658
L_920658:
	lsr.f r7,r5,0x15
L_92065c:
	bic r8,r3,0xfff00000
L_920664:
	or.ne r8,r8,0x100000
L_92066c:
	bne.d L_9206ca
L_920670:
	mov_s r2,r2
L_920672:
	cmp r8,0x0
L_920676:
	beq L_920682
L_92067a:
	b.d L_920694
L_92067e:
	norm r10,r8
	.global L_920682
L_920682:
	cmp_s r2,0x0
L_920684:
	mov r10,0x1f
L_920688:
	bmi L_920694
L_92068c:
	norm r10,r2
L_920690:
	add r10,r10,0x20
	.global L_920694
L_920694:
	sub r10,r10,0xa
L_920698:
	sub r7,r7,r10
L_92069c:
	add r7,r7,0x1
L_9206a0:
	sub.f r11,0x20,r10
L_9206a8:
	lsr r11,r2,r11
L_9206ac:
	bgt L_9206be
L_9206b0:
	sub r11,r10,0x20
L_9206b4:
	asl r8,r2,r11
L_9206b8:
	b.d L_9206ca
L_9206bc:
	mov_s r2,0x0
	.global L_9206be
L_9206be:
	asl r2,r2,r10
L_9206c2:
	asl r10,r8,r10
L_9206c6:
	or r8,r11,r10
	.global L_9206ca
L_9206ca:
	cmp r6,0x7ff
L_9206ce:
	beq L_9208c8
L_9206d2:
	cmp r7,0x7ff
L_9206d6:
	beq.d L_9208fa
L_9206da:
	mulu64 r0,r2
L_9206de:
	add r6,r6,r7
L_9206e2:
	mov r10,mlo
L_9206e6:
	mov r11,mhi
L_9206ea:
	mulu64 r1,r2
L_9206ee:
	sub r6,r6,0x3ff
L_9206f2:
	add.f r11,r11,mlo
L_9206f6:
	adc r2,mhi,0x0
L_9206fa:
	mulu64 r0,r8
L_9206fe:
	add.f r11,r11,mlo
L_920702:
	adc r2,r2,mhi
L_920706:
	mulu64 r1,r8
L_92070a:
	add.f r2,r2,mlo
L_92070e:
	adc r9,mhi,0x0
L_920712:
	asl r1,r9,0xc
L_920716:
	lsr r3,r2,0x14
L_92071a:
	or_s r1,r1,r3
L_92071c:
	asl r7,r2,0xc
L_920720:
	asl r0,r2,0xc
L_920724:
	lsr r3,r11,0x14
L_920728:
	or_s r0,r0,r3
L_92072a:
	asl r12,r11,0xc
L_92072e:
	cmp r10,0x0
L_920732:
	or.ne r12,r12,0x2
L_920736:
	sub.f 0x0,r6,0x0
L_92073a:
	ble L_92077e
L_92073e:
	and.f 0x0,r1,0x200000
L_920746:
	beq L_92075a
L_92074a:
	add r6,r6,0x1
L_92074e:
	lsr.f r1,r1
L_920752:
	rrc.f r0,r0
L_920756:
	rrc r12,r12
	.global L_92075a
L_92075a:
	sub.f 0x0,r12,0x0
L_92075e:
	bge L_920796
L_920762:
	and.f 0x0,r12,0x7fffffff
L_92076a:
	bne L_920776
L_92076e:
	and.f 0x0,r0,0x1
L_920772:
	beq L_920796
	.global L_920776
L_920776:
	add.f r0,r0,0x1
L_92077a:
	adc r1,r1,0x0
	.global L_92077e
L_92077e:
	and.f 0x0,r1,0x200000
L_920786:
	beq L_920796
L_92078a:
	add r6,r6,0x1
L_92078e:
	lsr.f r1,r1
L_920792:
	rrc r0,r0
	.global L_920796
L_920796:
	cmp r6,0x7ff
L_92079a:
	bge L_9208ac
L_92079e:
	cmp r6,0x0
L_9207a2:
	ble L_9207bc
	.global L_9207a6
L_9207a6:
	bic r1,r1,0x100000
L_9207ae:
	asl r2,r6,0x14
L_9207b2:
	or_s r1,r1,r2
L_9207b4:
	ror r2,r4
L_9207b8:
	or_s r1,r1,r2
	.global L_9207ba
L_9207ba:
	j_s [blink]
	.global L_9207bc
L_9207bc:
	cmp r6,-0x35
L_9207c0:
	blt L_9208bc
L_9207c4:
	sub r10,0x0,r6
L_9207cc:
	sub.f r10,r10,0x1
L_9207d0:
	mov 0x0,0x0
L_9207d4:
	blt L_92085e
L_9207d8:
	beq L_920866
L_9207dc:
	cmp r10,0x20
L_9207e0:
	mov 0x0,0x0
L_9207e4:
	blt L_92080e
L_9207e8:
	sub r10,r10,0x20
L_9207ec:
	or.f r12,r12,r0
L_9207f0:
	mov r11,-0x1
L_9207f4:
	bne L_920804
L_9207f8:
	asl r11,r11,r10
L_9207fc:
	xor r11,r11,-0x1
L_920800:
	and r12,r1,r11
	.global L_920804
L_920804:
	lsr r0,r1,r10
L_920808:
	b.d L_920866
L_92080c:
	mov_s r1,0x0
	.global L_92080e
L_92080e:
	cmp_s r12,0x0
L_920810:
	mov r11,-0x1
L_920814:
	bne L_920830
L_920818:
	cmp r10,0x20
L_92081c:
	sub.ge r11,r11,r11
L_920820:
	bge L_920828
L_920824:
	asl r11,r11,r10
	.global L_920828
L_920828:
	xor r11,r11,-0x1
L_92082c:
	and r12,r0,r11
	.global L_920830
L_920830:
	sub.f r11,0x20,r10
L_920838:
	asl r11,r1,r11
L_92083c:
	bgt L_92084e
L_920840:
	add r11,r10,0x20
L_920844:
	lsr r0,r1,r11
L_920848:
	b.d L_92085a
L_92084c:
	mov_s r1,0x0
	.global L_92084e
L_92084e:
	lsr r0,r0,r10
L_920852:
	lsr r1,r1,r10
L_920856:
	or r0,r0,r11
	.global L_92085a
L_92085a:
	b L_920866
	.global L_92085e
L_92085e:
	asl.f r0,r0
L_920862:
	rlc r1,r1
	.global L_920866
L_920866:
	and.f 0x0,r0,0x2
L_92086a:
	mov 0x0,0x0
L_92086e:
	beq L_92088a
L_920872:
	and r10,r0,0x5
L_920876:
	or.f 0x0,r10,r12
L_92087a:
	mov 0x0,0x0
L_92087e:
	beq L_92088a
L_920882:
	add.f r0,r0,0x2
L_920886:
	adc r1,r1,0x0
	.global L_92088a
L_92088a:
	lsr.f r1,r1
L_92088e:
	rrc r0,r0
L_920892:
	lsr.f r1,r1
L_920896:
	rrc r0,r0
L_92089a:
	sub r6,r6,r6
L_92089e:
	and.f 0x0,r1,0x100000
L_9208a6:
	add.ne r6,r6,0x1
L_9208aa:
	b_s L_9207a6
	.global L_9208ac
L_9208ac:
	mov r6,0x7ff
L_9208b0:
	mov_s r1,0x100000
L_9208b6:
	b.d L_9207a6
L_9208ba:
	mov_s r0,0x0
	.global L_9208bc
L_9208bc:
	sub r6,r6,r6
L_9208c0:
	mov_s r1,0x0
L_9208c2:
	b.d L_9207a6
L_9208c6:
	mov_s r0,0x0
	.global L_9208c8
L_9208c8:
	cmp_s r1,0x100000
L_9208ce:
	cmp.eq r0,0x0
L_9208d2:
	ror r1,r4
L_9208d6:
	or.ne r1,r1,0x7ff80000
L_9208de:
	sub_s.ne r0,r0,r0
L_9208e0:
	bne_s L_9207ba
L_9208e2:
	cmp r7,0x7ff
L_9208e6:
	beq L_9208fa
L_9208ea:
	ror r1,r4
L_9208ee:
	or r1,r1,0x7ff00000
L_9208f6:
	mov_s r0,0x0
L_9208f8:
	b_s L_9207ba
	.global L_9208fa
L_9208fa:
	cmp r8,0x100000
L_920902:
	cmp.eq r2,0x0
L_920906:
	ror r1,r4
L_92090a:
	or.ne r1,r1,0x7ff80000
L_920912:
	or.eq r1,r1,0x7ff00000
L_92091a:
	mov_s r0,0x0
L_92091c:
	b_s L_9207ba
	.global L_92091e
L_92091e:
	cmp r5,0xffe00000
L_920926:
	mov 0x0,0x0
L_92092a:
	bcc L_920956
L_92092e:
	mov 0x0,0x0
	.global L_920932
L_920932:
	mov_s r0,0x0
L_920934:
	mov_s r1,0x0
L_920936:
	cmp r4,0x0
L_92093a:
	or.ne r1,r1,0x80000000
L_920942:
	b_s L_9207ba
	.global L_920944
L_920944:
	xor.cs r4,r4,0x1
L_920948:
	cmp r9,0xffe00000
L_920950:
	blo_s L_920932
L_920952:
	mov 0x0,0x0
	.global L_920956
L_920956:
	mov_s r1,0x7ff80000
L_92095c:
	mov_s r0,0x0
L_92095e:
	b_s L_9207ba
