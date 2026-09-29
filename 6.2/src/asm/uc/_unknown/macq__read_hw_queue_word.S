/* macq__read_hw_queue_word @ 0x9290bc, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state2, l1_fixed_sched_ap__ev4_state4, macq__flush_queue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq__read_hw_queue_word
macq__read_hw_queue_word:
	.global L_9290bc
L_9290bc:
	asl_s r0,r0,0x8
L_9290be:
	add_s r0,r0,0x440c0c0
L_9290c4:
	lsr_s r0,r0,0x3
L_9290c6:
	bic r0,r0,0x3
L_9290ca:
	ld_s r0,[r0]
L_9290cc:
	j_s [blink]
L_9290ce:
	nop_s
