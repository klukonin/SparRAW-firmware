/* rx_macq__bind_queue @ 0x8e42b8, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_macq__bind_all_queues
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_macq__bind_queue
rx_macq__bind_queue:
	.global L_8e42b8
L_8e42b8:
	push_s blink
L_8e42ba:
	bl L_8c01dc
L_8e42be:
	mov_s r14,r0
L_8e42c0:
	mov_s r13,r1
L_8e42c2:
	mov_s r15,r2
L_8e42c4:
	mov_s r16,r3
L_8e42c6:
	cmp_s r2,0xc
L_8e42c8:
	cmp.cs r14,0x20
L_8e42cc:
	bcc L_8e430c
	.global L_8e42d0
L_8e42d0:
	cmp r16,0x0
L_8e42d4:
	sub_s.ne r0,r0,r0
L_8e42d6:
	mov.eq r0,r15
L_8e42da:
	lsr r1,r14,0x3
L_8e42de:
	mov_s r2,0x886800
L_8e42e4:
	add2_s r2,r2,r1
L_8e42e6:
	bmsk r1,r14,0x2
L_8e42ea:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8e42ec:
	mov_s r3,0xf
L_8e42ee:
	ld_s r15,[r2]
L_8e42f0:
	asl_s r3,r3,r1
L_8e42f2:
	bic_s r15,r15,r3
L_8e42f4:
	asl_s r0,r0,r1
L_8e42f6:
	or_s r0,r0,r15
L_8e42f8:
	st_s r0,[r2]
L_8e42fa:
	breq_s r13,0,L_8e4318
L_8e42fc:
	breq r13,0x1,L_8e4320
L_8e4300:
	cmp_s r13,0x2
L_8e4302:
	mov.eq r2,0x886828
L_8e430a:
	b_s L_8e4326
	.global L_8e430c
L_8e430c:
	mov_s r0,blink
L_8e430e:
	mov_s r1,0x1d
L_8e4310:
	bl.d L_8c9b28
L_8e4314:
	bset_s r1,r1,0xc
L_8e4316:
	b_s L_8e42d0
	.global L_8e4318
L_8e4318:
	mov_s r2,0x886820
L_8e431e:
	b_s L_8e4326
	.global L_8e4320
L_8e4320:
	mov_s r2,0x886824
	.global L_8e4326
L_8e4326:
	ld_s r0,[r2]
L_8e4328:
	mov_s r1,0x0
L_8e432a:
	cmp r16,0x0
L_8e432e:
	bset r1,r1,r14
L_8e4332:
	bic.ne r0,r0,r1
L_8e4336:
	bne_s L_8e433a
L_8e4338:
	or_s r0,r0,r1
	.global L_8e433a
L_8e433a:
	st_s r0,[r2]
L_8e433c:
	b L_8c0244
