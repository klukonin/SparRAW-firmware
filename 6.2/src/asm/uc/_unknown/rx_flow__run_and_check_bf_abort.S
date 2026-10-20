/* rx_flow__run_and_check_bf_abort @ 0x926310, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched__rx_slot, l1_fixed_sched_ap_sm, l1_fixed_sched_sta_sm
 * Зовёт сам: bf__abort_unexpected, bf__store_flow_status, bf_sm__run_sta, rx_funcs__rx_flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_flow__run_and_check_bf_abort
rx_flow__run_and_check_bf_abort:
	.global L_926310
L_926310:
	st.a r13,[sp,-0xc]
L_926314:
	st blink,[sp, 0x4]
L_926318:
	bl.d L_933928
L_92631c:
	st r14,[sp, 0x8]
L_926320:
	brne.d r0,0x1,L_92634c
L_926324:
	mov_s r14,r0
L_926326:
	mov_s r13,0x802288
L_92632c:
	ld r0,[r13]
L_926330:
	bl.d L_92b254
L_926334:
	mov r1,0xa
L_926338:
	breq_s r0,0,L_92634c
L_92633a:
	ld_s r0,[r13]
L_92633c:
	bl.d L_9357cc
L_926340:
	mov r1,0x0
L_926344:
	bl.d L_921940
L_926348:
	ld r0,[r13]
	.global L_92634c
L_92634c:
	ld blink,[sp, 0x4]
L_926350:
	mov_s r0,r14
L_926352:
	ld_s r14,[sp,0x8]
L_926354:
	j.d [blink]
L_926358:
	ld.ab r13,[sp,0xc]
