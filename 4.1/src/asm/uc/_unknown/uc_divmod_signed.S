/* uc_divmod_signed @ 0x9203c0, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__compute_next_tbtt, power_manager__scale_counters_ms, tx_initiator__build_tx_vector
 */
	.section .text.uc_divmod_signed,"ax",@progbits
	.global uc_divmod_signed
uc_divmod_signed:
	.global L_9203c0
L_9203c0:
	b.d L_9203dc
L_9203c4:
	mov r8,0x0
L_9203c8:
	lsr.f r8,r1,0x1f
L_9203cc:
	rsub.ne r1,r1,0x0
L_9203d0:
	asr.f r3,r0,0x1f
L_9203d4:
	rsub.ne r0,r0,0x0
L_9203d8:
	xor r8,r8,r3
	.global L_9203dc
L_9203dc:
	mov.f r2,r1
L_9203e0:
	beq.d L_920430
L_9203e4:
	mov_s r1,r0
L_9203e6:
	mov_s r0,0x0
L_9203e8:
	sub_s r3,r0,0x1
L_9203ea:
	norm.f r5,r1
L_9203ee:
	mov.mi r5,r3
L_9203f2:
	norm.f r6,r2
L_9203f6:
	mov.mi r6,r3
L_9203fa:
	sub.f r3,r6,r5
L_9203fe:
	mov.mi r3,0x0
L_920402:
	add lp_count,r3,0x1
L_920406:
	asl.pl r2,r2,r3
L_92040a:
	lp L_92041e
L_92040e:
	sub.f r1,r1,r2
L_920412:
	bset.cc r0,r0,lp_count
L_920416:
	add.cs r1,r1,r2
L_92041a:
	lsr r2,r2
	.global L_92041e
L_92041e:
	lsr.f r8,r8
L_920422:
	ror r0,r0
L_920426:
	rsub.cs r0,r0,0x0
L_92042a:
	j_s.d [blink]
L_92042c:
	rsub.ne r1,r1,0x0
	.global L_920430
L_920430:
	/* j 0x00001158 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x58,0x11
