/* __ld_r13_to_r13_ret @ 0x9202ac, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__abort_step, bf__abort_to_state11, bf__clear_pending_and_notify, bf__enter_mode3, bf__flow_exit, bf__pause_sta_tx, bf__resume_sta_tx, bf__trigger_for_mid, bf_metrics__reset_and_stamp, bf_req__claim_and_report_23
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global __ld_r13_to_r13_ret
__ld_r13_to_r13_ret:
	.global L_9202ac
L_9202ac:
	mov_s r12,0x4
	.global L_9202ae
L_9202ae:
	mov_s r13,0x4
L_9202b0:
	b_s L_9202e8
L_9202b2:
	nop_s
L_9202b4:
	mov_s r12,0x4
L_9202b6:
	b_s L_9202ec
	.global L_9202b8
L_9202b8:
	ld gp,[sp, 0x34]
	.global L_9202bc
L_9202bc:
	ld r25,[sp, 0x30]
	.global L_9202c0
L_9202c0:
	ld r24,[sp, 0x2c]
	.global L_9202c4
L_9202c4:
	ld r23,[sp, 0x28]
	.global L_9202c8
L_9202c8:
	ld r22,[sp, 0x24]
	.global L_9202cc
L_9202cc:
	ld r21,[sp, 0x20]
	.global L_9202d0
L_9202d0:
	ld r20,[sp, 0x1c]
	.global L_9202d4
L_9202d4:
	ld r19,[sp, 0x18]
	.global L_9202d8
L_9202d8:
	ld r18,[sp, 0x14]
	.global L_9202dc
L_9202dc:
	ld r17,[sp, 0x10]
	.global L_9202e0
L_9202e0:
	ld r16,[sp, 0xc]
	.global L_9202e4
L_9202e4:
	ld_s r15,[sp,0x8]
	.global L_9202e6
L_9202e6:
	ld_s r14,[sp,0x4]
	.global L_9202e8
L_9202e8:
	ld.ab r13,[sp,r13]
	.global L_9202ec
L_9202ec:
	ld.ab blink,[sp,r12]
L_9202f0:
	j_s [blink]
L_9202f2:
	nop_s
