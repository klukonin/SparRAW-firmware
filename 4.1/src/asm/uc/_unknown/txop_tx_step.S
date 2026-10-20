/* txop_tx_step @ 0x9332d4, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: cf_end__send_frame, internal_tx_step, tx_rate_select_and_program, txop_initiator_open_txop_flow
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, direct_tx__issue_cmd_33, uc_wait_direct_tx_ready
 */
	.section .text.txop_tx_step,"ax",@progbits
	.global txop_tx_step
txop_tx_step:
	.global L_9332d4
L_9332d4:
	push_s blink
L_9332d6:
	/* bl.d 0x00920214 */
	.byte 0x42,0x0f,0x6f,0xf6
L_9332da:
	/* _asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_9332dc:
	bset r3,r1,0x2
L_9332e0:
	asl r1,r2,0x8
L_9332e4:
	or r33,r1,r3
L_9332e8:
	ld.as r3,[gp,-0x6]
L_9332ec:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_9332ee:
	sub_s r1,r3,0x4
L_9332f0:
	st.as r1,[gp,-0x6]
L_9332f4:
	add3_s r0,r0,r0
L_9332f6:
	add r13,r0,0x801190
L_9332fe:
	mov_s r1,0x33000443
L_933304:
	add r14,r13,0x2c
L_933308:
	brne r2,0x5,L_93333c
L_93330c:
	sub_s r3,r3,0xa
L_93330e:
	st.as r3,[gp,-0x6]
L_933312:
	mov_s r32,r1
L_933314:
	st.ab r1,[r25,0x4]
L_933318:
	bclr r25,r25,0xa
L_93331c:
	bl L_924f7c
L_933320:
	ldw_s r0,[r13,0x2c]
L_933322:
	bset r34,r0,0x18
L_933326:
	ldw_s r0,[r14,0x2]
L_933328:
	bset r34,r0,0x18
L_93332c:
	ldw_s r0,[r14,0x4]
L_93332e:
	bset r34,r0,0x18
L_933332:
	ld_s r0,[gp,-0x18]
L_933334:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_933336:
	st.as r0,[gp,-0x6]
L_93333a:
	b_s L_933360
	.global L_93333c
L_93333c:
	ldw_s r0,[r13,0x2c]
L_93333e:
	bset r34,r0,0x18
L_933342:
	ldw_s r0,[r14,0x2]
L_933344:
	bset r34,r0,0x18
L_933348:
	ldw_s r0,[r14,0x4]
L_93334a:
	bset r34,r0,0x18
L_93334e:
	ld_s r0,[gp,-0x18]
L_933350:
	sub_s r0,r0,0xc
L_933352:
	st.as r0,[gp,-0x6]
L_933356:
	mov_s r32,r1
L_933358:
	st.ab r1,[r25,0x4]
L_93335c:
	bclr r25,r25,0xa
	.global L_933360
L_933360:
	bl L_924f7c
L_933364:
	bl L_924e6c
L_933368:
	b L_920284
