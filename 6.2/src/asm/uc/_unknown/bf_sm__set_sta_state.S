/* bf_sm__set_sta_state @ 0x92b220, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__abort_to_state11, bf__reset_sta, bf_init_sm, bf_sm__dispatch_by_state, bf_sm__process_request_fifo, l1_task__select_by_mode
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, field_rw_0x2c__9351f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__set_sta_state
bf_sm__set_sta_state:
	.global L_92b220
L_92b220:
	push_s blink
L_92b222:
	bl L_920234
L_92b226:
	mov_s r13,r0
L_92b228:
	ld_s r0,[gp,-0x34]
L_92b22a:
	mov_s r14,r1
L_92b22c:
	cmp_s r0,0x1
L_92b22e:
	cmp.eq r14,0x11
L_92b232:
	bne_s L_92b240
L_92b234:
	mov_s r0,0x801be8
L_92b23a:
	bl.d L_9351f8
L_92b23e:
	extb_s r1,r13
	.global L_92b240
L_92b240:
	mov_s r0,0x0
L_92b242:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_92b244:
	add2_s r13,r13,r13
L_92b246:
	add_s r13,r13,0x801ffc
L_92b24c:
	st_s r14,[r13]
L_92b24e:
	st_s r0,[r13,0x4]
L_92b250:
	b L_9202a4
