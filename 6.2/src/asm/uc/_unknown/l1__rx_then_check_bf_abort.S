/* l1__rx_then_check_bf_abort @ 0x92b6ac, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__phase_of
 * Зовёт сам: bf__abort_unexpected, bf__store_flow_status, bf_sm__run_sta, rx_funcs__rx_flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1__rx_then_check_bf_abort
l1__rx_then_check_bf_abort:
	.global L_92b6ac
L_92b6ac:
	st.a r13,[sp,-0xc]
L_92b6b0:
	st blink,[sp, 0x4]
L_92b6b4:
	bl.d L_933928
L_92b6b8:
	st r14,[sp, 0x8]
L_92b6bc:
	brne.d r0,0x1,L_92b6e8
L_92b6c0:
	mov_s r14,r0
L_92b6c2:
	mov_s r13,0x802288
L_92b6c8:
	ld r0,[r13]
L_92b6cc:
	bl.d L_92b254
L_92b6d0:
	mov r1,0xa
L_92b6d4:
	breq_s r0,0,L_92b6e8
L_92b6d6:
	ld_s r0,[r13]
L_92b6d8:
	bl.d L_9357cc
L_92b6dc:
	mov r1,0x0
L_92b6e0:
	bl.d L_921940
L_92b6e4:
	ld r0,[r13]
	.global L_92b6e8
L_92b6e8:
	ld blink,[sp, 0x4]
L_92b6ec:
	mov_s r0,r14
L_92b6ee:
	ld_s r14,[sp,0x8]
L_92b6f0:
	j.d [blink]
L_92b6f4:
	ld.ab r13,[sp,0xc]
