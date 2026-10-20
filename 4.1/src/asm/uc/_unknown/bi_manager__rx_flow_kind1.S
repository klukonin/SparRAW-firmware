/* bi_manager__rx_flow_kind1 @ 0x92879c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__run_rx_flow_by_kind
 * Зовёт сам: bf__abort_unexpected, bf_sm__step_by_state, bf_substate__set, rx_funcs__rx_flow
 */
	.section .text.bi_manager__rx_flow_kind1,"ax",@progbits
	.global bi_manager__rx_flow_kind1
bi_manager__rx_flow_kind1:
	.global L_92879c
L_92879c:
	st.a r13,[sp,-0xc]
L_9287a0:
	st blink,[sp, 0x4]
L_9287a4:
	bl.d L_92f280
L_9287a8:
	st r14,[sp, 0x8]
L_9287ac:
	brne.d r0,0x1,L_9287d8
L_9287b0:
	mov_s r14,r0
L_9287b2:
	mov_s r13,0x801418
L_9287b8:
	ld r0,[r13]
L_9287bc:
	bl.d L_9283dc
L_9287c0:
	mov r1,0xa
L_9287c4:
	breq_s r0,0,L_9287d8
L_9287c6:
	ld_s r0,[r13]
L_9287c8:
	bl.d L_930dc4
L_9287cc:
	mov r1,0x0
L_9287d0:
	bl.d L_9221f8
L_9287d4:
	ld r0,[r13]
	.global L_9287d8
L_9287d8:
	ld blink,[sp, 0x4]
L_9287dc:
	mov_s r0,r14
L_9287de:
	ld_s r14,[sp,0x8]
L_9287e0:
	j.d [blink]
L_9287e4:
	ld.ab r13,[sp,0xc]
