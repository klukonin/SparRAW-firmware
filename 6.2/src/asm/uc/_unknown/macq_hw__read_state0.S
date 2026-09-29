/* macq_hw__read_state0 @ 0x929020, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_is_tx_pipe_idle, vring__disconnect_flush
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq_hw__read_state0
macq_hw__read_state0:
	.global L_929020
L_929020:
	asl_s r1,r0,0x3
L_929022:
	sub_s r1,r1,r0
L_929024:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_929026:
	add r0,r1,0x4409800
L_92902e:
	lsr r1,r0,0x3
L_929032:
	bic r1,r1,0x3
L_929036:
	ld_s r3,[r1]
L_929038:
	bmsk_s r0,r0,0x4
L_92903a:
	lsr r0,r3,r0
L_92903e:
	j_s.d [blink]
L_929040:
	bmsk_s r0,r0,0x3
L_929042:
	nop_s
