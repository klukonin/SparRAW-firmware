/* bf_substate__txss_step_by_slot @ 0x93639c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_substate__dispatch_by_state
 * Зовёт сам: __ld_r13_ret_uc, bf_sm__reset_slot_table, bf_sm__state_action, set_g_800fa8_minus20, txss_flow_step_b
 */
	.section .text.bf_substate__txss_step_by_slot,"ax",@progbits
	.global bf_substate__txss_step_by_slot
bf_substate__txss_step_by_slot:
	.global L_93639c
L_93639c:
	push_s blink
L_93639e:
	push_s r13
L_9363a0:
	mov_s r13,r0
L_9363a2:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_9363a4:
	add1_s r0,r0,r0
L_9363a6:
	mov_s r1,0x800ef8
L_9363ac:
	ld_s r0,[r1,r0]
L_9363ae:
	breq_s r0,0,L_9363b8
L_9363b0:
	breq r0,0x9,L_9363ce
L_9363b4:
	mov_s r13,0x2
L_9363b6:
	b_s L_9363d0
	.global L_9363b8
L_9363b8:
	mov_s r0,r13
L_9363ba:
	bl.d L_9281a0
L_9363be:
	mov_s r1,0x4
L_9363c0:
	bl L_92b668
L_9363c4:
	bl.d L_93657c
L_9363c8:
	mov_s r0,r13
L_9363ca:
	mov_s r13,0x0
L_9363cc:
	b_s L_9363d0
	.global L_9363ce
L_9363ce:
	mov_s r13,0x1
	.global L_9363d0
L_9363d0:
	cmp_s r13,0x0
L_9363d2:
	bl.ne L_928380
L_9363d6:
	b.d L_92028c
L_9363da:
	mov_s r0,r13
