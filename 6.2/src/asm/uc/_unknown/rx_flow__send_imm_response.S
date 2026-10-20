/* rx_flow__send_imm_response @ 0x93626c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame
 * Зовёт сам: direct_tx__issue_cmd_33, tx__send_imm_response, uc_wait_direct_tx_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_flow__send_imm_response
rx_flow__send_imm_response:
	.global L_93626c
L_93626c:
	push_s r13
L_93626e:
	mov_s r13,blink
L_936270:
	mov_s r0,0x0
L_936272:
	mov_s r1,r0
L_936274:
	bl.d L_9385d8
L_936278:
	mov r2,0x10
L_93627c:
	mov r33,0xe4
L_936280:
	ld.as r3,[gp,-0x5]
L_936284:
	mov_s r0,0x33000063
L_93628a:
	sub_s r3,r3,0x10
L_93628c:
	st.as r3,[gp,-0x5]
L_936290:
	mov r32,r0
L_936294:
	st.ab r0,[r25,0x4]
L_936298:
	bclr r25,r25,0xa
L_93629c:
	bl L_925874
L_9362a0:
	bl L_925774
L_9362a4:
	mov_s r2,0x80242c
L_9362aa:
	ldw_s r1,[r2]
L_9362ac:
	mov_s blink,r13
L_9362ae:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_9362b0:
	stw_s r1,[r2]
L_9362b2:
	j_s.d [blink]
L_9362b4:
	pop_s r13
L_9362b6:
	nop_s
