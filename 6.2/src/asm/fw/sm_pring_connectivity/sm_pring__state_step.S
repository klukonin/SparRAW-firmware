/* sm_pring__state_step @ 0x8ea69c, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Do nothing.
 * Зовут его: vring_schd__stop_vring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, fw_sysassert_fatal, macq_hw__disable_queue_fw, u_schd__cancel, u_schd__now, u_schd__schedule, vring__reg_write_locked_28, vring__reg_write_locked_3c
 * Глобалы (через gp): 0x800348
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_pring__state_step
sm_pring__state_step:
	.global L_8ea69c
L_8ea69c:
	push_s blink
L_8ea69e:
	bl L_8c01e0
L_8ea6a2:
	ld_s r1,[r0,0x18]
L_8ea6a4:
	brhs.d r1,0x5,L_8ea742
L_8ea6a8:
	mov_s r14,r0
L_8ea6aa:
	ldb.x r1,[0x8023dc,r1]
L_8ea6b2:
	add r0,pcl,0xa
L_8ea6b6:
	add1_s r0,r0,r1
L_8ea6b8:
	j_s [r0]
L_8ea6ba:
	mov_s r0,0x3
L_8ea6bc:
	ldw_s r15,[r14]
L_8ea6be:
	st_s r0,[r14,0x18]
L_8ea6c0:
	add_s r15,r15,0x8
L_8ea6c2:
	mov_s r0,0x0
L_8ea6c4:
	bset r0,r0,r15
L_8ea6c8:
	bl.d L_8d0538
L_8ea6cc:
	mov_s r1,0x1
L_8ea6ce:
	ld_s r0,[r14,0x2c]
L_8ea6d0:
	mov_s r13,0x0
L_8ea6d2:
	breq_s r0,0,L_8ea6da
L_8ea6d4:
	bl L_8c8de0
L_8ea6d8:
	st_s r13,[r14,0x2c]
	.global L_8ea6da
L_8ea6da:
	ld_s r0,[r14,0x28]
L_8ea6dc:
	breq_s r0,0,L_8ea6e4
L_8ea6de:
	bl L_8c8de0
L_8ea6e2:
	st_s r13,[r14,0x28]
	.global L_8ea6e4
L_8ea6e4:
	bl L_8e9524
L_8ea6e8:
	st_s r13,[r14,0x38]
L_8ea6ea:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8ea6ec:
	st_s r0,[r14,0x34]
L_8ea6ee:
	bl.d L_8d0c9c
L_8ea6f2:
	ldw_s r0,[r14]
L_8ea6f4:
	ld_s r0,[gp,-0x104]
L_8ea6f6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ea6f8:
	st.as r0,[gp,-0x41]
L_8ea6fc:
	ld_s r0,[r14,0x1c]
L_8ea6fe:
	brne_s r0,0,L_8ea728
	.global L_8ea700
L_8ea700:
	mov_s r2,0x0
L_8ea702:
	ld.as r4,[gp,0x71]
L_8ea706:
	mov_s r0,0x20f3c
L_8ea70c:
	ldw_s r1,[r14]
L_8ea70e:
	mov_s r3,0x1
L_8ea710:
	mov_s r5,r2
L_8ea712:
	bl.d L_8e0c0c
L_8ea716:
	mov_s r6,r2
L_8ea718:
	st_s r0,[r14,0x1c]
L_8ea71a:
	mov_s r0,0x0
L_8ea71c:
	bset r0,r0,r15
L_8ea720:
	bl.d L_8d0568
L_8ea724:
	mov_s r1,0x1
L_8ea726:
	b_s L_8ea74e
	.global L_8ea728
L_8ea728:
	mov_s r0,blink
L_8ea72a:
	mov_s r1,0xe8
L_8ea72c:
	bl.d L_8c9b28
L_8ea730:
	bset_s r1,r1,0xc
L_8ea732:
	b_s L_8ea700
L_8ea734:
	mov_s r1,0x100d098
L_8ea73a:
	bl.d L_8dcba8
L_8ea73e:
	mov_s r0,0x27
L_8ea740:
	b_s L_8ea74e
	.global L_8ea742
L_8ea742:
	mov_s r0,blink
L_8ea744:
	mov_s r1,0x12a5
L_8ea74a:
	bl L_8c9b28
	.global L_8ea74e
L_8ea74e:
	b L_8c024c
L_8ea752:
	nop_s
