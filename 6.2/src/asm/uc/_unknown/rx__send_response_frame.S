/* rx__send_response_frame @ 0x936200, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame, rx_funcs__handle_ppdu_report
 * Зовёт сам: bi__remaining_time_us, direct_tx__issue_cmd_33, tx__send_imm_response, tx_fifo__write_bytes, uc_wait_direct_tx_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__send_response_frame
rx__send_response_frame:
	.global L_936200
L_936200:
	st.a r13,[sp,-0x8]
L_936204:
	st_s r14,[sp,0x4]
L_936206:
	mov_s r14,blink
L_936208:
	bl L_92dc44
L_93620c:
	mov_s r1,r0
L_93620e:
	mov_s r0,0x0
L_936210:
	bl.d L_9385d8
L_936214:
	mov r2,0x16
L_936218:
	mov r33,0x664
L_93621c:
	ld.as r3,[gp,-0x5]
L_936220:
	mov_s r13,0x80146c
L_936226:
	sub_s r3,r3,0x10
L_936228:
	st.as r3,[gp,-0x5]
L_93622c:
	mov_s r2,0x33000063
L_936232:
	mov_s r32,r2
L_936234:
	st.ab r2,[r25,0x4]
L_936238:
	bclr r25,r25,0xa
L_93623c:
	bl L_925874
L_936240:
	add r0,r13,0x10
L_936244:
	bl.d L_9257f4
L_936248:
	mov r1,0x6
L_93624c:
	bl L_925774
L_936250:
	mov_s r1,0x801030
L_936256:
	ldw r0,[r1, 0xb8]
L_93625a:
	mov_s blink,r14
L_93625c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93625e:
	stw r0,[r1, 0xb8]
L_936262:
	ld_s r14,[sp,0x4]
L_936264:
	j.d [blink]
L_936268:
	ld.ab r13,[sp,0x8]
