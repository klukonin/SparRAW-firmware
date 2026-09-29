/* bi__run_bti_cycle @ 0x928794, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi__bti_timer_step, bti__dispatch_sweep_step
 * Зовёт сам: bf_ctx__dispatch_by_role, bi_manager_step_a, bi_manager_step_b, l1_task__dispatch, uc_sysassert
 * Глобалы (через gp): 0x8005be
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi__run_bti_cycle
bi__run_bti_cycle:
	.global L_928794
L_928794:
	st.a r13,[sp,-0xc]
L_928798:
	st_s r14,[sp,0x8]
L_92879a:
	mov_s r14,r0
L_92879c:
	ldw.as r0,[gp,0x4b]
L_9287a0:
	cmp r0,0x300
L_9287a4:
	bne.d L_928804
L_9287a8:
	st blink,[sp, 0x4]
	.global L_9287ac
L_9287ac:
	mov_s r1,0x802f15
L_9287b2:
	ldb_s r2,[r1]
L_9287b4:
	breq.d r2,0x0,L_9287d0
L_9287b8:
	add r13,r14,0x8
L_9287bc:
	mov r0,0x2
L_9287c0:
	bl.d L_934e30
L_9287c4:
	mov r1,0x0
L_9287c8:
	bl.d L_935a44
L_9287cc:
	mov r0,r13
	.global L_9287d0
L_9287d0:
	bl.d L_92218c
L_9287d4:
	mov r0,r14
L_9287d8:
	bl.d L_922258
L_9287dc:
	mov r0,r13
L_9287e0:
	ldw.as r3,[gp,0x4b]
L_9287e4:
	cmp r3,0x300
L_9287e8:
	bne L_928814
	.global L_9287ec
L_9287ec:
	mov r0,0x3
L_9287f0:
	bl.d L_934e30
L_9287f4:
	mov r1,0x0
L_9287f8:
	ld blink,[sp, 0x4]
L_9287fc:
	ld_s r14,[sp,0x8]
L_9287fe:
	j_s.d [blink]
L_928800:
	ld.ab r13,[sp,0xc]
	.global L_928804
L_928804:
	mov r0,blink
L_928808:
	bl.d L_926618
L_92880c:
	mov r1,0x59
L_928810:
	b L_9287ac
	.global L_928814
L_928814:
	mov r0,blink
L_928818:
	bl.d L_926618
L_92881c:
	mov r1,0x60
L_928820:
	b_s L_9287ec
L_928822:
	nop_s
