/* sm_pring__timeout @ 0x8e9268, 464 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Timeout: [V-Ring %d] is_eop_TO %d, ptp_avial %d
 *   Timeout: FLUSH CMD for V-Ring %d at <%d> so far run %d usec
 *   PRING: TIMEOUT HANDLER: DMA is not Empty, Try#:%d
 *   Vring disconnect flow but DMA is not idle m_vring_index %d
 *   PRING is idle - close V-Ring %d.
 *   Spurious event of PRING timeout at <%d>.
 * Зовут его: vring__stop_hw
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, dma_is_idle, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal, hwd_pcie_exit_l1, lmac_if_send_cmd_0x08, pring__find_by_id, rm_main_sm__enter_step, tx_macq__is_empty, txq_ptp_sw_is_fifo_idle
 * Глобалы (через gp): 0x800232, 0x800348
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_pring__timeout
sm_pring__timeout:
	.global L_8e9268
L_8e9268:
	push_s blink
L_8e926a:
	bl.d L_8c01d4
L_8e926e:
	mov_s r2,0x0
L_8e9270:
	mov_s r14,r0
L_8e9272:
	mov_s r0,0x886a00
L_8e9278:
	ld r18,[r0, 0x24]
L_8e927c:
	ld_s r1,[r14,0x1c]
L_8e927e:
	cmp_s r1,0x0
L_8e9280:
	ld_s r0,[r14,0x24]
L_8e9282:
	beq_s L_8e938e
L_8e9284:
	cmp_s r0,0x0
L_8e9286:
	mov_s r13,0x1
L_8e9288:
	st_s r2,[r14,0x1c]
L_8e928a:
	bne_s L_8e9374
	.global L_8e928c
L_8e928c:
	ld_s r1,[r14,0x18]
L_8e928e:
	cmp_s r1,0x4
L_8e9290:
	bhi L_8e9426
L_8e9294:
	ldb r1,[0x8023ec,r1]
L_8e929c:
	add r0,pcl,0x8
L_8e92a0:
	add1_s r0,r0,r1
L_8e92a2:
	j_s [r0]
L_8e92a4:
	ldw_s r0,[r14]
L_8e92a6:
	mov_s r15,0x0
L_8e92a8:
	bl.d L_8d08c0
L_8e92ac:
	mov_s r1,r15
L_8e92ae:
	mov_s r16,r0
L_8e92b0:
	mov_s r0,0x1
L_8e92b2:
	bl.d L_8d12ac
L_8e92b6:
	mov_s r17,r0
L_8e92b8:
	cmp r16,0x0
L_8e92bc:
	st r17,[r14, 0x20]
L_8e92c0:
	bne_s L_8e93f2
L_8e92c2:
	bl.d L_8ccfd8
L_8e92c6:
	ldw_s r0,[r14,0x2]
L_8e92c8:
	mov_s r16,r0
L_8e92ca:
	bl.d L_8da15c
L_8e92ce:
	mov_s r1,r15
L_8e92d0:
	brne r0,0x0,L_8e93a4
L_8e92d4:
	bl L_8e9524
L_8e92d8:
	ld_s r1,[r14,0xc]
L_8e92da:
	asl_s r15,r0,0x4
L_8e92dc:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e92de:
	st_s r1,[r14,0xc]
L_8e92e0:
	ldb r2,[gp, 0xae]
L_8e92e4:
	brlo.d r1,r2,L_8e931e
L_8e92e8:
	ldw_s r0,[r14]
L_8e92ea:
	bl.d L_8d08c0
L_8e92ee:
	mov_s r1,0x1
L_8e92f0:
	bl.d L_8ea47c
L_8e92f4:
	mov_s r0,0x0
L_8e92f6:
	mov_s r0,r16
L_8e92f8:
	bl.d L_8da15c
L_8e92fc:
	mov_s r1,0x1
L_8e92fe:
	mov_s r1,0x100d0d8
L_8e9304:
	mov_s r0,0x7
L_8e9306:
	ldw_s r2,[r14,0x2]
L_8e9308:
	mov_s r3,r13
L_8e930a:
	bl.d L_8dcd00
L_8e930e:
	mov r4,r18
L_8e9312:
	mov_s r0,blink
L_8e9314:
	mov_s r1,0x12a9
L_8e931a:
	bl L_8c9b28
	.global L_8e931e
L_8e931e:
	mov_s r2,0x0
L_8e9320:
	ld.as r4,[gp,0x71]
L_8e9324:
	mov_s r0,0x20f3c
L_8e932a:
	ldw_s r1,[r14]
L_8e932c:
	mov_s r3,0x1
L_8e932e:
	mov_s r5,r2
L_8e9330:
	bl.d L_8e0c0c
L_8e9334:
	mov_s r6,r2
L_8e9336:
	st_s r0,[r14,0x1c]
L_8e9338:
	ld_s r0,[r14,0x30]
L_8e933a:
	mov_s r1,0x100d108
L_8e9340:
	sub r4,r15,r0
L_8e9344:
	ldw_s r2,[r14,0x2]
L_8e9346:
	mov_s r0,0x27
L_8e9348:
	bl.d L_8dcd00
L_8e934c:
	mov_s r3,r15
L_8e934e:
	bl.d L_8cd00c
L_8e9352:
	ldb_s r0,[r14,0x2]
L_8e9354:
	mov.f r13,r0
L_8e9358:
	beq_s L_8e9396
	.global L_8e935a
L_8e935a:
	mov_s r0,0x3
L_8e935c:
	ldb_s r2,[r13,0xa]
L_8e935e:
	mov_s r1,r0
L_8e9360:
	ldb_s r3,[r14,0x2]
L_8e9362:
	mov r4,0x0
L_8e9366:
	mov r5,0x1
L_8e936a:
	bl.d L_8dbb60
L_8e936e:
	mov r6,r4
L_8e9372:
	b_s L_8e9432
	.global L_8e9374
L_8e9374:
	mov_s r1,0x12a7
L_8e937a:
	mov_s r0,blink
L_8e937c:
	b_s L_8e9388
	.global L_8e937e
L_8e937e:
	mov_s r0,blink
L_8e9380:
	mov_s r1,0x12ae
L_8e9386:
	mov_s r13,r2
	.global L_8e9388
L_8e9388:
	bl L_8c9b28
L_8e938c:
	b_s L_8e928c
	.global L_8e938e
L_8e938e:
	breq_s r0,0,L_8e937e
L_8e9390:
	st_s r2,[r14,0x24]
L_8e9392:
	mov_s r13,r2
L_8e9394:
	b_s L_8e928c
	.global L_8e9396
L_8e9396:
	mov_s r0,blink
L_8e9398:
	mov_s r1,0x16ca
L_8e939e:
	bl L_8c9b28
L_8e93a2:
	b_s L_8e935a
	.global L_8e93a4
L_8e93a4:
	ld_s r1,[r14,0xc]
L_8e93a6:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e93a8:
	st_s r1,[r14,0xc]
L_8e93aa:
	ldb_s r0,[gp,0xae]
L_8e93ac:
	brlo r0,r1,L_8e93da
L_8e93b0:
	ld.as r4,[gp,0x71]
L_8e93b4:
	mov_s r0,0x20f3c
L_8e93ba:
	ldw_s r1,[r14]
L_8e93bc:
	mov_s r2,r15
L_8e93be:
	mov_s r3,0x1
L_8e93c0:
	mov_s r5,r15
L_8e93c2:
	bl.d L_8e0c0c
L_8e93c6:
	mov_s r6,r15
L_8e93c8:
	st_s r0,[r14,0x1c]
L_8e93ca:
	mov_s r1,0x100d144
L_8e93d0:
	mov_s r0,0x27
L_8e93d2:
	bl.d L_8dcc10
L_8e93d6:
	ld_s r2,[r14,0xc]
L_8e93d8:
	b_s L_8e9432
	.global L_8e93da
L_8e93da:
	mov_s r1,0x100d178
L_8e93e0:
	mov_s r0,0x7
L_8e93e2:
	bl.d L_8dcc10
L_8e93e6:
	ldw_s r2,[r14,0x2]
L_8e93e8:
	mov_s r1,0x12aa
L_8e93ee:
	mov_s r0,blink
L_8e93f0:
	b_s L_8e942e
	.global L_8e93f2
L_8e93f2:
	bl.d L_8d12ac
L_8e93f6:
	mov_s r0,r15
L_8e93f8:
	st_s r15,[r14,0x20]
L_8e93fa:
	mov_s r1,0x100d1b4
L_8e9400:
	mov_s r0,0x27
L_8e9402:
	bl.d L_8dcc10
L_8e9406:
	ldw_s r2,[r14,0x2]
L_8e9408:
	bl.d L_8c6954
L_8e940c:
	mov_s r0,r14
L_8e940e:
	b_s L_8e9432
L_8e9410:
	bl L_8e9524
L_8e9414:
	mov_s r1,0x100d1d8
L_8e941a:
	mov_s r2,r0
L_8e941c:
	mov_s r0,0x27
L_8e941e:
	/* bl.d 0x008dcc10 */
	.byte 0xf6,0x0f,0xaf,0xf9
L_8e9422:
	/* _asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_8e9424:
	b_s L_8e9432
	.global L_8e9426
L_8e9426:
	mov_s r0,blink
L_8e9428:
	mov_s r1,0x12ab
	.global L_8e942e
L_8e942e:
	bl L_8c9b28
	.global L_8e9432
L_8e9432:
	b L_8c0234
L_8e9436:
	nop_s
