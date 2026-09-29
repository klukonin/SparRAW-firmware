/* rx__send_response_frame @ 0x93137c, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__post_rx_act7, rx_funcs__handle_ppdu_report
 * Зовёт сам: bi__remaining_time_us, direct_tx__issue_cmd_33, direct_tx__push_payload, direct_tx_rx__program, uc_wait_direct_tx_ready
 */
	.section .text.rx__send_response_frame,"ax",@progbits
	.global rx__send_response_frame
rx__send_response_frame:
	.global L_93137c
L_93137c:
	st.a r13,[sp,-0x8]
L_931380:
	st_s r14,[sp,0x4]
L_931382:
	mov_s r14,blink
L_931384:
	bl L_92a608
L_931388:
	mov_s r1,r0
L_93138a:
	mov_s r0,0x0
L_93138c:
	bl.d L_9334c4
L_931390:
	mov r2,0x16
L_931394:
	mov r33,0x664
L_931398:
	ld.as r3,[gp,-0x6]
L_93139c:
	mov_s r13,0x800994
L_9313a2:
	sub_s r3,r3,0x10
L_9313a4:
	st.as r3,[gp,-0x6]
L_9313a8:
	mov_s r2,0x33000063
L_9313ae:
	mov_s r32,r2
L_9313b0:
	st.ab r2,[r25,0x4]
L_9313b4:
	bclr r25,r25,0xa
L_9313b8:
	bl L_924f7c
L_9313bc:
	add r0,r13,0x10
L_9313c0:
	bl.d L_924ef4
L_9313c4:
	mov r1,0x6
L_9313c8:
	bl L_924e6c
L_9313cc:
	mov_s r1,0x80088c
L_9313d2:
	ldw r0,[r1, 0xb0]
L_9313d6:
	mov_s blink,r14
L_9313d8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9313da:
	stw r0,[r1, 0xb0]
L_9313de:
	ld_s r14,[sp,0x4]
L_9313e0:
	j.d [blink]
L_9313e4:
	ld.ab r13,[sp,0x8]
