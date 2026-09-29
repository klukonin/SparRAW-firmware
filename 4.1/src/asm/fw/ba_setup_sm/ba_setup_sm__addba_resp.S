/* ba_setup_sm__addba_resp @ 0x8e92dc, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ADDBA RESP - status %d, w-size %d. timeout %d
 *   ADDBA RESP  - a_msdu %d,  bapolicy %d
 *   ADDBA RESP- reduce window size to %d (asked for %d
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ba_setup_sm__close_addba_resp_timeout, ba_setup_sm__close_ba_setup_global_timeout, basic_sm__inject_event, fw_log__emit2, fw_log__emit3
 */
	.section .text.ba_setup_sm__addba_resp,"ax",@progbits
	.global ba_setup_sm__addba_resp
ba_setup_sm__addba_resp:
L_8e92dc:
	/* b_s 0x008e92a6 */
	.byte 0xe5,0xf1
	.global fwlog_ADDBA_RESP_reduce_window_size_to_d_asked
fwlog_ADDBA_RESP_reduce_window_size_to_d_asked:
L_8e92de:
	nop_s
L_8e92e0:
	push_s blink
L_8e92e2:
	bl L_8c02c0
L_8e92e6:
	mov_s r13,r0
L_8e92e8:
	bl.d L_8ea488
L_8e92ec:
	mov_s r14,r1
L_8e92ee:
	mov_s r2,0x1010390
L_8e92f4:
	ldb_s r0,[r14,0x4]
L_8e92f6:
	ldb_s r3,[r14,0x3]
L_8e92f8:
	asl_s r0,r0,0x8
L_8e92fa:
	or_s r3,r3,r0
L_8e92fc:
	ldb_s r1,[r14,0x6]
L_8e92fe:
	ldb_s r0,[r14,0x5]
L_8e9300:
	asl_s r1,r1,0x8
L_8e9302:
	or_s r0,r0,r1
L_8e9304:
	lsr_s r0,r0,0x6
L_8e9306:
	bmsk r4,r0,0x9
L_8e930a:
	ldb_s r0,[r14,0x8]
L_8e930c:
	ldb r5,[r14, 0x7]
L_8e9310:
	asl_s r0,r0,0x8
L_8e9312:
	or r5,r5,r0
L_8e9316:
	mov_s r0,0x7
L_8e9318:
	bl.d L_8ee034
L_8e931c:
	mov_s r1,0x2
L_8e931e:
	add r15,r13,0x20
L_8e9322:
	ldb_s r1,[r15,0xd]
L_8e9324:
	ldb_s r0,[r14,0x2]
L_8e9326:
	brne r1,r0,L_8e93aa
L_8e932a:
	ldb_s r3,[r14,0x5]
L_8e932c:
	mov_s r2,0x10103c0
L_8e9332:
	lsr r4,r3
L_8e9336:
	mov_s r0,0x7
L_8e9338:
	mov_s r1,0x2
L_8e933a:
	bmsk_s r3,r3,0x0
L_8e933c:
	bl.d L_8edff8
L_8e9340:
	bmsk r4,r4,0x0
L_8e9344:
	ldb_s r0,[r14,0x6]
L_8e9346:
	ldb_s r3,[r14,0x5]
L_8e9348:
	asl_s r0,r0,0x8
L_8e934a:
	or_s r3,r3,r0
L_8e934c:
	lsr_s r3,r3,0x6
L_8e934e:
	ldb r4,[r15, 0x1c]
L_8e9352:
	bmsk_s r3,r3,0x9
L_8e9354:
	brge r3,r4,L_8e9366
L_8e9358:
	mov_s r2,0x10103e8
L_8e935e:
	mov_s r0,0x7
L_8e9360:
	bl.d L_8edff8
L_8e9364:
	mov_s r1,0x2
	.global L_8e9366
L_8e9366:
	ldb_s r1,[r14,0x6]
L_8e9368:
	ldb_s r0,[r14,0x5]
L_8e936a:
	asl_s r1,r1,0x8
L_8e936c:
	or_s r0,r0,r1
L_8e936e:
	lsr_s r0,r0,0x6
L_8e9370:
	bmsk_s r0,r0,0x9
L_8e9372:
	stb_s r0,[r15,0x1d]
L_8e9374:
	ldb_s r0,[r14,0x8]
L_8e9376:
	ldb_s r1,[r14,0x7]
L_8e9378:
	asl_s r0,r0,0x8
L_8e937a:
	or_s r1,r1,r0
L_8e937c:
	stw r1,[r13, 0x42]
L_8e9380:
	ldb_s r0,[r14,0x5]
L_8e9382:
	bmsk_s r0,r0,0x0
L_8e9384:
	stb_s r0,[r15,0x1f]
L_8e9386:
	ldb_s r0,[r14,0x4]
L_8e9388:
	ldb_s r1,[r14,0x3]
L_8e938a:
	asl_s r0,r0,0x8
L_8e938c:
	or_s r1,r1,r0
L_8e938e:
	cmp_s r1,0x0
L_8e9390:
	mov_s r0,r13
L_8e9392:
	mov.ne r1,0x8
L_8e9396:
	bne_s L_8e93a0
L_8e9398:
	bl L_8ea4b0
L_8e939c:
	mov_s r0,r13
L_8e939e:
	mov_s r1,0x7
	.global L_8e93a0
L_8e93a0:
	mov_s r2,0x0
L_8e93a2:
	mov_s r3,r2
L_8e93a4:
	bl.d L_8d6a1c
L_8e93a8:
	mov_s r4,r2
	.global L_8e93aa
L_8e93aa:
	.byte 0x85,0x07
