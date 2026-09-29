/* bf_pending__set_bit @ 0x9216f8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__abort_step, bf__flow_exit, bf_sm__process_request_fifo, bti__bi2_event_step, bti_bi2__track_best_metric, internal_tx_isr, l1_task__mask_halt_req_and_defer, l1_task__mask_wake_req_and_defer, rx_flow__handle_frame, rx_flow_step
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_pending__set_bit
bf_pending__set_bit:
	.global L_9216f8
L_9216f8:
	lr r2,[0xa]
L_9216fc:
	bclr r1,r2,0x1
L_921700:
	flag r1
L_921704:
	mov_s r3,0x800648
L_92170a:
	ld_s r1,[r3]
L_92170c:
	bic r2,r2,-0x3
L_921710:
	bset r1,r1,r0
L_921714:
	st_s r1,[r3]
L_921716:
	lr r0,[0xa]
L_92171a:
	or_s r2,r2,r0
L_92171c:
	flag r2
L_921720:
	j_s [blink]
L_921722:
	nop_s
