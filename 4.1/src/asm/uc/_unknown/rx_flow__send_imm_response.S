/* rx_flow__send_imm_response @ 0x9313e8, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__post_rx_act8
 * Зовёт сам: direct_tx__issue_cmd_33, direct_tx_rx__program, uc_wait_direct_tx_ready
 */
	.section .text.rx_flow__send_imm_response,"ax",@progbits
	.global rx_flow__send_imm_response
rx_flow__send_imm_response:
	.global L_9313e8
L_9313e8:
	push_s r13
L_9313ea:
	mov_s r13,blink
L_9313ec:
	mov_s r0,0x0
L_9313ee:
	mov_s r1,r0
L_9313f0:
	bl.d L_9334c4
L_9313f4:
	mov r2,0x10
L_9313f8:
	mov r33,0xe4
L_9313fc:
	ld.as r3,[gp,-0x6]
L_931400:
	mov_s r0,0x33000063
L_931406:
	sub_s r3,r3,0x10
L_931408:
	st.as r3,[gp,-0x6]
L_93140c:
	mov r32,r0
L_931410:
	st.ab r0,[r25,0x4]
L_931414:
	bclr r25,r25,0xa
L_931418:
	bl L_924f7c
L_93141c:
	bl L_924e6c
L_931420:
	mov_s r2,0x8014dc
L_931426:
	ldw_s r1,[r2]
L_931428:
	mov_s blink,r13
L_93142a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_93142c:
	stw_s r1,[r2]
L_93142e:
	j_s.d [blink]
L_931430:
	pop_s r13
L_931432:
	nop_s
