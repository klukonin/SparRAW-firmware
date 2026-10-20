/* pring__isr_dispatch @ 0x8e72fc, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_pring_dma
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_dma__ack_881c38, hwd_dma__read_cause_881c2c, u_schd__add, vring__reg_write_locked_28
 */
	.section .text.pring__isr_dispatch,"ax",@progbits
	.global pring__isr_dispatch
pring__isr_dispatch:
	.global L_8e72fc
L_8e72fc:
	push_s blink
L_8e72fe:
	bl L_8c02b8
L_8e7302:
	bl L_8cda4c
L_8e7306:
	mov_s r16,r0
L_8e7308:
	bmsk r14,r0,0x0
L_8e730c:
	lsr r13,r0,0x4
L_8e7310:
	bmsk_s r13,r13,0x0
L_8e7312:
	lsr r15,r0,0x8
L_8e7316:
	bmsk_s r15,r15,0x0
L_8e7318:
	b_s L_8e7336
	.global L_8e731a
L_8e731a:
	norm r0,r14
L_8e731e:
	rsub r17,r0,0x1e
L_8e7322:
	mov_s r0,0x1cbd8
L_8e7328:
	mov_s r1,r17
L_8e732a:
	mov_s r2,0x0
L_8e732c:
	bl.d L_8c2ac8
L_8e7330:
	mov_s r3,0x2
L_8e7332:
	bclr r14,r14,r17
	.global L_8e7336
L_8e7336:
	brne_s r14,0,L_8e731a
L_8e7338:
	b_s L_8e7356
	.global L_8e733a
L_8e733a:
	norm r0,r13
L_8e733e:
	rsub r14,r0,0x1e
L_8e7342:
	mov_s r0,0x1cbb8
L_8e7348:
	mov_s r1,r14
L_8e734a:
	mov_s r2,0x0
L_8e734c:
	bl.d L_8c2ac8
L_8e7350:
	mov_s r3,0x2
L_8e7352:
	bclr r13,r13,r14
	.global L_8e7356
L_8e7356:
	brne_s r13,0,L_8e733a
L_8e7358:
	b_s L_8e7376
	.global L_8e735a
L_8e735a:
	norm r0,r15
L_8e735e:
	rsub r13,r0,0x1e
L_8e7362:
	mov_s r0,0x1cbc8
L_8e7368:
	mov_s r1,r13
L_8e736a:
	mov_s r2,0x0
L_8e736c:
	bl.d L_8c2ac8
L_8e7370:
	mov_s r3,0x2
L_8e7372:
	bclr r15,r15,r13
	.global L_8e7376
L_8e7376:
	brne_s r15,0,L_8e735a
L_8e7378:
	mov_s r0,r16
L_8e737a:
	bl.d L_8cde20
L_8e737e:
	mov_s r1,0x1
L_8e7380:
	mov_s r0,r16
L_8e7382:
	bl.d L_8cd6ac
L_8e7386:
	mov_s r1,0x1
L_8e7388:
	b L_8c031c
