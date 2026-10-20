/* macq_hw__sync_dma_wptr @ 0x92a69c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: macq__flush_queue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq_hw__sync_dma_wptr
macq_hw__sync_dma_wptr:
	.global L_92a69c
L_92a69c:
	asl_s r3,r1,0x3
L_92a69e:
	sub_s r3,r3,r1
L_92a6a0:
	/* asl_s r3,r3,0x7 */
	.byte 0x07,0xbb
L_92a6a2:
	add_s r3,r3,0x44098c0
L_92a6a8:
	lsr r1,r3,0x3
L_92a6ac:
	bic r1,r1,0x3
L_92a6b0:
	ld r4,[r1]
L_92a6b4:
	bmsk_s r3,r3,0x4
L_92a6b6:
	lsr r4,r4,r3
L_92a6ba:
	extw r4,r4
L_92a6be:
	asl_s r0,r0,0x8
L_92a6c0:
	add r2,r0,0x440c140
L_92a6c8:
	lsr_s r2,r2,0x3
L_92a6ca:
	bic r5,r2,0x3
L_92a6ce:
	st r4,[r5]
L_92a6d2:
	bset r4,r4,0x1f
L_92a6d6:
	st r4,[r5]
L_92a6da:
	j_s [blink]
