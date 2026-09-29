/* rx__send_dmg_cts @ 0x936320, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame
 * Зовёт сам: direct_tx__init_rx_desc, direct_tx__issue_cmd_33, tx__send_imm_response, tx_fifo__write_bytes, uc_wait_direct_tx_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__send_dmg_cts
rx__send_dmg_cts:
	.global L_936320
L_936320:
	st.a r13,[sp,-0x8]
L_936324:
	st_s r14,[sp,0x4]
L_936326:
	sub_s sp,sp,0x18
L_936328:
	ldw r1,[0x804012]
L_936330:
	mov_s r14,blink
L_936332:
	ldb_s r0,[gp,-0xec]
L_936334:
	sub r1,r1,0x14
L_936338:
	bl.d L_9385d8
L_93633c:
	mov r2,0x17
L_936340:
	mov_s r0,sp
L_936342:
	mov_s r1,0x1
L_936344:
	bl.d L_9246c4
L_936348:
	mov r2,r1
L_93634c:
	ldw r33,[sp]
L_936350:
	ld.as r2,[gp,-0x5]
L_936354:
	add_s r13,sp,0x10
L_936356:
	sub_s r2,r2,0x10
L_936358:
	st.as r2,[gp,-0x5]
L_93635c:
	mov_s r1,0x33000063
L_936362:
	mov_s r32,r1
L_936364:
	st.ab r1,[r25,0x4]
L_936368:
	bclr r25,r25,0xa
L_93636c:
	bl L_925874
L_936370:
	mov r0,r13
L_936374:
	bl.d L_9257f4
L_936378:
	mov r1,0x7
L_93637c:
	bl L_925774
L_936380:
	mov_s r2,0x8022c8
L_936386:
	ld_s r3,[r2,0x2c]
L_936388:
	mov_s blink,r14
L_93638a:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_93638c:
	st_s r3,[r2,0x2c]
L_93638e:
	add_s sp,sp,0x18
L_936390:
	ld_s r14,[sp,0x4]
L_936392:
	j_s.d [blink]
L_936394:
	ld.ab r13,[sp,0x8]
