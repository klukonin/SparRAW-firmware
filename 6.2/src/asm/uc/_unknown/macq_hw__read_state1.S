/* macq_hw__read_state1 @ 0x929044, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_is_tx_pipe_idle, vring__disconnect_flush
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq_hw__read_state1
macq_hw__read_state1:
	.global L_929044
L_929044:
	asl_s r1,r0,0x3
L_929046:
	sub_s r1,r1,r0
L_929048:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_92904a:
	add r0,r1,0x4409820
L_929052:
	lsr r1,r0,0x3
L_929056:
	bic r1,r1,0x3
L_92905a:
	ld_s r3,[r1]
L_92905c:
	bmsk_s r0,r0,0x4
L_92905e:
	lsr r0,r3,r0
L_929062:
	j_s.d [blink]
L_929064:
	bmsk_s r0,r0,0x3
L_929066:
	nop_s
