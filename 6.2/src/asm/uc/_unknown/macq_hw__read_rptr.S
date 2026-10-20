/* macq_hw__read_rptr @ 0x929088, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_is_tx_pipe_idle, macq__flush_queue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq_hw__read_rptr
macq_hw__read_rptr:
	.global L_929088
L_929088:
	asl_s r2,r0,0x3
L_92908a:
	sub_s r2,r2,r0
L_92908c:
	/* asl_s r2,r2,0x7 */
	.byte 0x07,0xba
L_92908e:
	add_s r2,r2,0x4409880
L_929094:
	lsr r1,r2,0x3
L_929098:
	bic r1,r1,0x3
L_92909c:
	ld_s r0,[r1]
L_92909e:
	bmsk_s r2,r2,0x4
L_9290a0:
	lsr_s r0,r0,r2
L_9290a2:
	j_s.d [blink]
L_9290a4:
	extw_s r0,r0
L_9290a6:
	nop_s
