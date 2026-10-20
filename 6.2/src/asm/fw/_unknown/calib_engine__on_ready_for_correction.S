/* calib_engine__on_ready_for_correction @ 0x8c75c0, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, calib_engine__accumulate_if_enabled, calib_silent_rssi_sparrow__correction_alg, fw_sysassert_fatal, sm__defer_call, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_engine__on_ready_for_correction
calib_engine__on_ready_for_correction:
	.global L_8c75c0
L_8c75c0:
	push_s blink
L_8c75c2:
	bl L_8c01e4
L_8c75c6:
	bl.d L_8e9524
L_8c75ca:
	mov_s r13,r0
L_8c75cc:
	mov_s r14,r0
L_8c75ce:
	ld_s r0,[r13,0x18]
L_8c75d0:
	mov_s r1,0x800e08
L_8c75d6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c75d8:
	st_s r0,[r13,0x18]
L_8c75da:
	ld_s r0,[r13,0xc]
L_8c75dc:
	add r4,r13,0x38
L_8c75e0:
	add2_s r1,r1,r0
L_8c75e2:
	ld_s r0,[r1]
L_8c75e4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c75e6:
	st_s r0,[r1]
L_8c75e8:
	ld_s r0,[r13,0x8]
L_8c75ea:
	ld_s r1,[r13,0x10]
L_8c75ec:
	ld_s r2,[r13,0x18]
L_8c75ee:
	bl.d L_8c766c
L_8c75f2:
	ld_s r3,[r13,0x1c]
L_8c75f4:
	breq_s r0,0,L_8c760c
L_8c75f6:
	breq r0,0x1,L_8c7622
L_8c75fa:
	breq r0,0x2,L_8c7638
L_8c75fe:
	mov_s r0,blink
L_8c7600:
	mov_s r1,0x140a
L_8c7606:
	bl L_8c9b28
L_8c760a:
	b_s L_8c764c
	.global L_8c760c
L_8c760c:
	ld_s r1,[r13,0xc]
L_8c760e:
	add_s r1,r1,r1
L_8c7610:
	add2_s r1,r1,r1
L_8c7612:
	add_s r1,r1,0x8538c0
L_8c7618:
	ldw_s r0,[r1,0x18]
L_8c761a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c761c:
	extw_s r0,r0
L_8c761e:
	stw_s r0,[r1,0x18]
L_8c7620:
	b_s L_8c764c
	.global L_8c7622
L_8c7622:
	ld_s r0,[r13,0xc]
L_8c7624:
	add_s r0,r0,r0
L_8c7626:
	add2_s r0,r0,r0
L_8c7628:
	add_s r0,r0,0x8538c0
L_8c762e:
	ldw_s r1,[r0,0x1a]
L_8c7630:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c7632:
	extw_s r1,r1
L_8c7634:
	stw_s r1,[r0,0x1a]
L_8c7636:
	b_s L_8c764c
	.global L_8c7638
L_8c7638:
	ld_s r1,[r13,0xc]
L_8c763a:
	add_s r1,r1,r1
L_8c763c:
	add2_s r1,r1,r1
L_8c763e:
	add_s r1,r1,0x8538c0
L_8c7644:
	ldw_s r0,[r1,0x1c]
L_8c7646:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c7648:
	extw_s r0,r0
L_8c764a:
	stw_s r0,[r1,0x1c]
	.global L_8c764c
L_8c764c:
	bl L_8e9524
L_8c7650:
	sub_s r0,r0,r14
L_8c7652:
	bl.d L_8eaa20
L_8c7656:
	/* _asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8c7658:
	mov_s r0,r13
L_8c765a:
	mov_s r1,0x3
L_8c765c:
	mov_s r2,0x0
L_8c765e:
	mov_s r3,r2
L_8c7660:
	bl.d L_8e7044
L_8c7664:
	mov_s r4,r2
L_8c7666:
	b L_8c0254
L_8c766a:
	nop_s
