/* uc_tx__is_idle @ 0x93c658, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__process_request_fifo, bti__prepare_sweep_set, fixed_sched__run_tx_slot, ucode_cmd_trigger_bf
 * Зовёт сам: __ld_r13_to_r13_ret, qset1_mask__any_pending_uc
 * Глобалы (через gp): 0x800588, 0x8005bc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_tx__is_idle
uc_tx__is_idle:
	.global L_93c658
L_93c658:
	push_s blink
L_93c65a:
	push_s r13
L_93c65c:
	ldw_s r0,[gp,0x94]
L_93c65e:
	brne_s r0,0,L_93c664
	.global L_93c660
L_93c660:
	mov_s r0,0x0
L_93c662:
	b_s L_93c672
	.global L_93c664
L_93c664:
	ld_s r0,[gp,0x60]
L_93c666:
	brne_s r0,0,L_93c660
L_93c668:
	mov_s r13,0x1
L_93c66a:
	bl.d L_93c678
L_93c66e:
	mov_s r0,r13
L_93c670:
	mov_s r0,r13
	.global L_93c672
L_93c672:
	b L_9202ac
L_93c676:
	nop_s
